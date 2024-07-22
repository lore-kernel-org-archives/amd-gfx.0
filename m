Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7413FC3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 02:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B58F10E08C;
	Mon, 22 Jul 2024 02:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQacfXaH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274D910E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 02:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMzgAfmXFGGgw3ucfsPW4GMIBIeuo35dqrfS2uQ+46lzbY3Qg8yxi6YWmEJtA8Q7n3urwbjvGd2vWNQX3iNcUgp6DDq9uo3IG0sqvpkO2F6qMUnxsVkvLJpHthoI+L/iTRpUDIO8xRFr1hJZjDGDLjCh6mvVePehV4lx7h5PWyvF+SFZtQRcZrAjtBiYWtxj09bm6B/xJHC4e4Zzbe/y5EBIPvhlcE89v3CdQKaKpFDvaNDEwMY6vav/zNIxOWUTrC3/4uv5SLQEdyZe3pwLpL+o5vFQH3vcactTCP7HncLXlBQvJDqscifS9j0z6zqVwb3z7WEosBIMS3/aGE0Aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11+W5uqi+gmFDPLAh6Qe3UabD/MuSNQwHE2uQSzS7wc=;
 b=TBrQqvJZhV4CDOnoW7kbrDSzAef+516yPLnfbBdEXDxHdAul/n7ADKzv2mUPVcQOegI6HsWpnbiPgRZWvSd5a6YruuRYEgpX3ubAJ88Z3cDzTOpm+LFfzatrEJd+vjGXCfD7XC/Em3+qMMSdWAp4s1Ro4nJjMzGON5fqlvzcssvpvNAkabtvVj46goihaPce5F0cKW678AmY9XsSAJK+jcpuu38BjEqdn4QUJP+kzRR4+OwPsO0/WsnjWO7Vyd9lEiD3ndV5YjzXS759dvsHXsngTN1shemfSFnXR5IUl7p8w3Bjgxgy+B9pAJSFeECtjmHFNoqf71jVnl0rzrZP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11+W5uqi+gmFDPLAh6Qe3UabD/MuSNQwHE2uQSzS7wc=;
 b=WQacfXaHMG1Gx0gJteRAmj3iuITTpDBXlfIRZ/EMm+RRJc9XzVofAREXdfsdcW9IJOV3nsCrIIc5BBbeUgjfDw2IxpFIEH1FeNraR3pce4nr5BsJeswcdqQLJ8WmTBs+szP7T7Mu4jC3AV2+Alqi4XzdBJRgpWdiKrkEqmLF34M=
Received: from MN2PR19CA0056.namprd19.prod.outlook.com (2603:10b6:208:19b::33)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 02:26:26 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::32) by MN2PR19CA0056.outlook.office365.com
 (2603:10b6:208:19b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 22 Jul 2024 02:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 02:26:25 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 21 Jul
 2024 21:26:21 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: skip kfd init if GFX is not ready.
Date: Mon, 22 Jul 2024 10:25:09 +0800
Message-ID: <20240722022509.620547-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a8e2ff-5712-4bf0-0031-08dca9f5afb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YFdJCmIcli0D5QZi6zKw7nipbHcfhxpAZLtFaXHgZnvsq0Tk1TExHY+wpxf8?=
 =?us-ascii?Q?fpF9fMVMnbRP/u38UlUBjUXiEDpabapxPIeJhBOLxLbHFoPWYw2NT3ERd2AL?=
 =?us-ascii?Q?NJdhl+5HAJN7oMkG9apCaxlBJBh6+juaSnUy2ECet7NS58GiwD7i7YklFZCL?=
 =?us-ascii?Q?WzUDNTAx4sMsPXOwpQ+W82+xq8cWKCvmIoWlAw5Pq8/eZbIlHy3t+03kdmbT?=
 =?us-ascii?Q?K2BEAJ9kMnpWrjxMp/388mAvuVt3GwzDUHBobW1RwFqkWngf20n0rs4o2WON?=
 =?us-ascii?Q?Gs+cFIEqxq5flLuH6Eo0mPHJ7TRxrPTpssu/gT8nZIG9SxZmIxFecMwx3MtY?=
 =?us-ascii?Q?0BFg7/hoUPhvoJpMFZqV4+uHCvxwHx+Ss9CqNI3g3u0UbvoIoYq1HZAZimOf?=
 =?us-ascii?Q?KPBJU5ZbYd0AygZynhK5X1xo2kmu5OMgxGjrvJ/JD7L+DaZsvA97az6LeWhR?=
 =?us-ascii?Q?Lx7d4pYH43hkJpa8hS88TFnvtWg60yqlKkPTs0uHzuReTkGrIMBUwtqPEKlb?=
 =?us-ascii?Q?ofVG+tkOdSyaKnMYLt3H6yJhjqAxfZAGbPCeWbkkzvRRtXu/76W8e/tCTFUo?=
 =?us-ascii?Q?cRW9slcvjCqqzEUq8GHlAaJaEmILgP3ysbR/ikEKXNGqLad9UhXdRqAnmJqZ?=
 =?us-ascii?Q?vR5wLPQglg6V+XZ/7h1sCyX2QOxjWcxBgXhZQRx1jsOsqJlXPnqiTKFY8YlN?=
 =?us-ascii?Q?b1PNF/EVyJcdQeg8R/Mx5sGE5kAk2I30Xbf+JkhTal64npP2zizwz++IARlL?=
 =?us-ascii?Q?1NNPUDc2xRg/txD1979T1RoxbYgP85G254c34SK2yXx8oPMVtSAoUqg41hAP?=
 =?us-ascii?Q?NqVx4BV8CJ2xZo11SwKyRuaojWGlLOVGlDI1T1iLJwrL9NYRJl0m+wxRq6s+?=
 =?us-ascii?Q?fIv8yIau8ZNYpcl0IFAA7Kd0qhiB23Seq44KiSXfDuP4kdk78wZsXW3A78T+?=
 =?us-ascii?Q?+YRIiU4QxQ4kLRiue8k7EbpJeO7ucjYQXHTbWorHCjvRWAlmQoc4e03GyGB3?=
 =?us-ascii?Q?WXckJ4bXeroPsC2O3L3ZR7aZw2BBqviPOdfFYu9RCRzHXYnwjsngNTrmEon0?=
 =?us-ascii?Q?BYLeeMJmKbtRaqhdCQsGKQRuzctd3I0UcyrejnYzDhUHc6+MxgJOmLVcNgKr?=
 =?us-ascii?Q?C7rQ/ZsnxwGe1fUaNQe6Hr4+Mm2nMaSEIXX1awxpVj4f7gHrD35/id8XlDMl?=
 =?us-ascii?Q?qnMem59tKcVK5bIxLi1M32pjgfYd44r+5IgImaW16CM9PRp+HsM2OSkmr1cC?=
 =?us-ascii?Q?GAbpcKewzu8vJ41SaAmgkP57uIEDsdn1YMP3g5wBjyEKaaeME6raX1/ho8s2?=
 =?us-ascii?Q?NZz22kaks12DWuX2agFdJYDYPR6sqHg/DI7dCDdd0ThX7VoISsd1k+IYGNMc?=
 =?us-ascii?Q?kq/x0ZR1ncDgs2xibL0n5l6O54qS00hc4TGHTiMi3vLfGBMol4HyCZJKV30f?=
 =?us-ascii?Q?x7yjvvF+SWvWfhqmm6OT8UOTK8bo95DG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 02:26:25.8746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a8e2ff-5712-4bf0-0031-08dca9f5afb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

avoid kfd init crash in that case.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bcacf2e35eba..730dae77570c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2471,6 +2471,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_ip_block *ip_block;
 	struct pci_dev *parent;
 	int i, r;
 	bool total;
@@ -2608,7 +2609,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
-	amdgpu_amdkfd_device_probe(adev);
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+	if (ip_block->status.valid != false)
+		amdgpu_amdkfd_device_probe(adev);
+
 	adev->cg_flags &= amdgpu_cg_mask;
 	adev->pg_flags &= amdgpu_pg_mask;
 
-- 
2.37.3

