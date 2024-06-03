Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD8AC27C52
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB92810E22F;
	Mon,  3 Jun 2024 01:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ja3cqn2c";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C34610E22C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF4dLPLiby5Nr433UCjGt/CZmF8K71j3JQ4hJUs4028ys1zVy8/8O1lfXXukdVHnLd7J5dr61lTK6FzhEQVswlf7ScIcmaEpvlDN6Bw3U5AVFks/Qy721bgfsrT33pnFTJYYUABsGOJ59as9eMxUhxdaQ7gt66cUjwsdwC/SBC9E2K01Vr9x9+UpJli4ngFEONS+9pfKNZ/gILhaQXqNR2rvyx5DCTQKmcl34lvpuhi/kBOLbFex61aHG8cwZ/M79xR5GWNstaN4nVxKxzdEzYYxy3JgcaII+MR1F760Lmht9jlXhZ568d8sA8L0OjFl7gj5wQNP2vug/K6A8aAGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvXPxe8S2FpZ5rAVOFja213gIx4aL7Fc7tUuDLFxbEw=;
 b=EGFtmfVBQW8IQ1rgUzbXgJSj5I6nKmqRfkqRoGj6txk06z+PgHj8Y3jTq1Y+D0sOD9g6Qr/mBu8biea+wwiF+4g62vJEnPt1EDnvxZFBwgYkWAY2mQAcRFUR3MbQ5tJSyS9z0ZsEptBvwn+vNAOIX16S5nyFhJGJJyTYLQ2G00JnXuOjR6w2epJH+EJ3na3ukFgmP7PzNZotw1LiWAaaK13T3yfbdX3tMwY0R915b5VrE3ssvUNvM/im6PDpU4nXB7lqZDPsTASiwUz6nvMJnLo9U+3ClDkqHyyuLxcnSOvGPWli6fqJ4yS8fSK8Jd25nC9NruYGzPH2o7Qy00UmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvXPxe8S2FpZ5rAVOFja213gIx4aL7Fc7tUuDLFxbEw=;
 b=Ja3cqn2cIadi6rGbiEf7s1tnvkR2TG33VF1NiskDP0ooA8ktcC9wT5E8Nn5K8bEXHLVZNHGxP/LIekD/p1ayjUZGRAyGaraWMPKqDI/7l6WYMBGfxlbV4gU+Av65PivR6u0j3sLuxKJRlguvL+eO9i3fbmBRxjclIK0Q5chTunQ=
Received: from BYAPR02CA0031.namprd02.prod.outlook.com (2603:10b6:a02:ee::44)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 01:42:58 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::10) by BYAPR02CA0031.outlook.office365.com
 (2603:10b6:a02:ee::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:58 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:56 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 12/18] drm/amdgpu: refine gfx6 firmware loading
Date: Mon, 3 Jun 2024 09:42:06 +0800
Message-ID: <20240603014212.1969546-13-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2fa9d3-4015-4085-5063-08dc836e7f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iGMvMUY8+cJW3dZWCgLtjTK7wRuftkmQRdhGickscFshcuudUCNZtXy3xEJy?=
 =?us-ascii?Q?9S8SuRQk4zRl8D3ypbXi7RkXixIQphPk31zJIpHYq08OFNWFtJXwu56FtNIm?=
 =?us-ascii?Q?EK8nFViPCIQxWdjCPCy9hPG4OZKNyP90Ov+ecAkhbzlAu7vGZMoyUFkU4GWY?=
 =?us-ascii?Q?HDM0+dfodr5A3Pj+QxMIybwhLPzALH6IDgR5pdNqt5PK27fCxH2tMKEyFr0C?=
 =?us-ascii?Q?7Im8+1AqefhXR8eEFSm/NAHJRuGHzf5IEgeneXalyyXSqan53JBY2vCCOBxw?=
 =?us-ascii?Q?hrEtLw88mgu6gpQYd0IEWqEsFC6KpEetZ5Erx8eLh3LT34OkwlNs3QCJMBt7?=
 =?us-ascii?Q?ZICrleWE96glxq+IGTZM1+qnRXDgA5CGnISzgn5NW4Pesq6tkTHmQpj0WoL4?=
 =?us-ascii?Q?p+eI9U3VYTjhQqG41MZy8dr8ADADB6qz1dTfIzbwqZ6DJPvImNFLcJgF5pEK?=
 =?us-ascii?Q?cHt6Nhcs9MlUYhLCsOxhiIiQxDif50b6CoPnUkQJLqzx1dWzo4J7zugzwIQT?=
 =?us-ascii?Q?hmaK1+Btx2a7ii9d0ulrNI/vne41+C3bBjYq+/7KYOhxgNWvg0Vdf+fL4SeZ?=
 =?us-ascii?Q?q+ho1YhYVIPFFR847JU9BSYSNoka/uay5MZ1pYxZgjHnT8VYRsFPsDNlNUmX?=
 =?us-ascii?Q?xwDht5/z3JY9ns7txLTbDg3mDveDQnVFrI/bUz1BszBKStxMo4HzjIvUbmxk?=
 =?us-ascii?Q?JGLUPXL4sND0WvOyxl6XwdwhrKs4mqPcb1tQ84mp/v9aHKbvJLOSIWAXyR6F?=
 =?us-ascii?Q?srXazr7D82eQ4NvsmF+hBQ+svqMKEEqrtAk/OVFkPLJXKz8uhfTRfCaHTK9C?=
 =?us-ascii?Q?Xz6imPw0bPtqn3GTPPvuX5RxIFGjRhQo/XwCp5pikIs/3fh5wfI9Gj/cDqey?=
 =?us-ascii?Q?hZ3QfGJSdFao+3Rc2kGwGAJ/q1AyDZD7PlfrF9stto35m9xkGVNlZp9+2bJW?=
 =?us-ascii?Q?94m5dmd+zzIx73pwFCQGl0AW2lvLYrsV+vczsyMud1fcdIM3qvuoNeB+vF6F?=
 =?us-ascii?Q?tHo8gWS4R7oRb8qcGggLkjeoXMwXkwJJqwHM0ryz5oImVVlmedwwccrSIjyh?=
 =?us-ascii?Q?DdHAA2dBTZdcx1npGex6NXjBb3dDZQfBbkj7eDv2LDtYhqexNYoSRZJa++IU?=
 =?us-ascii?Q?Pd0XOPlig4G9ClstPF754tE+zZg3pCXRepcIdztiXEAqwLyu9YZpXY2tmFlf?=
 =?us-ascii?Q?Jno9cxAaBwaLY6x0xKWqz02w1uIdyz+0xGMYO27bYhwH/vLlHMR131xheXk2?=
 =?us-ascii?Q?d8H+fPF/CvAbSEilhiSFfn6rO++hbespJwRjBdfitpE/4y6efP9kesaZAFd1?=
 =?us-ascii?Q?kLsWkBXy2zVDMVEg8r5e/vsbllXG/cK16eomXewgEH4aKhHI40/pET6iWuOs?=
 =?us-ascii?Q?r+vnceCzDmHZioGHMblkR3WIoIg2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:58.7864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2fa9d3-4015-4085-5063-08dc836e7f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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

refine gfx6 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index d0992ce9fb47..564f0b9336b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -311,7 +311,6 @@ static const u32 verde_rlc_save_restore_register_list[] =
 static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 	const struct rlc_firmware_header_v1_0 *rlc_hdr;
@@ -337,32 +336,32 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	default: BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.pfp_fw->data;
 	adev->gfx.pfp_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.me_fw->data;
 	adev->gfx.me_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.ce_fw->data;
 	adev->gfx.ce_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v1_0 *)adev->gfx.rlc_fw->data;
@@ -371,7 +370,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		pr_err("gfx6: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("gfx6: Failed to load firmware %s gfx firmware\n", chip_name);
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
 		amdgpu_ucode_release(&adev->gfx.me_fw);
 		amdgpu_ucode_release(&adev->gfx.ce_fw);
-- 
2.34.1

