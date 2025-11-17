Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40788CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 23:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB25010E1D9;
	Mon, 17 Nov 2025 23:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gG1CWsIz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F421610E1D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 23:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJflNkcUbybpFkDyTHNEPLeu79yzmtCxt5Kw3Qpq8gwAoc1E39iaTD0BWK/bmDHFoaQGORct/O0lrBFR7LhI2fTTBCMwo+RqEaM+Foq6FUS+IChApc5bGdgdTgR9wavJhjoYP3jymqC2IepwZyWsmQR/VyAkwycSzpgquygdV9ZxQvR0pK2E5v6ILCBGnUVArhZ7k7fT5x5yNg8781LrH45+4g3Sh/XB0EdfRO1Nr0e5hDE7aI9goX5gI6521qHpO333hznibApEIKBwFxPHo5mQPvA4CViJG/P+gvCgmzb8nlKeocZyLJ/pZ9eTquQ+ruP54drv7DZSGnIGnacA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CfmsjWqe1/qvKb5gznyeBFOcAroo7QkWS34sik7SQU=;
 b=CQsyq+JHw9Wc+zvhNwzAReGLPZDL7B8VA0cEDxIaOublWilvINJC7OvTdB50LCePHna1Db0y/elv+Wu+EioOxPh7Ywmo+UIDauHPtapIObEw1ncQ8TeQqUGzFqG3+qvULCRSalXCWOSIrXT51c6KofETfZCdHjNLZACUHrU+pUVp3xg+ucuxs4ZW2UMzJziRFUrBVSJ903bXb5W1ug4Q7LalWh67S0PfSinGbW0Q84poiJufu6QlVTxIdo/+bHudPrUWHf3YWDtkYyVqMHX6eZjWZpLoHhC1rqJLSWAlawT2yi9GK2KwiAPlJGV7blID6cEbiY7XcSORw/LGFttmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CfmsjWqe1/qvKb5gznyeBFOcAroo7QkWS34sik7SQU=;
 b=gG1CWsIzG2k/tnFZ6T81e149y/bEhhLcKrcrBpCaCZM9bSqNcXG5DODU9WaSpvl9L4LJyufiKgBqtuoWy1dIIQslsIaDKWERxGpqv4CzFDaGa9w7CxPulUSbeg4hX7PwzPQJtaFj5sWPs7ClkS8FsWMLgooO7e5zRaPPJBMPR1M=
Received: from CH5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:1f1::14)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 23:21:43 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1b) by CH5PR03CA0002.outlook.office365.com
 (2603:10b6:610:1f1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 23:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 23:21:42 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 15:21:41 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] =?UTF-8?q?drm/amdkfd:=20Remove=20hard=E2=80=91coded=20GC?=
 =?UTF-8?q?=20IP=20version=20checks=20from=20kfd=5Fnode=5Fby=5Firq=5Fids?=
Date: Mon, 17 Nov 2025 18:20:56 -0500
Message-ID: <20251117232056.1480995-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e62598-2375-456b-eb01-08de26301144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0xJUzJESllNVFQ3Z2ovcFN1ZVRLcHU1N1Q4OUZqMWlZandkYzNHZ29abUxE?=
 =?utf-8?B?TUs1d2pNRnY1YkFzeS9VMTJpR2t1aDVIcWVnYmQxRW9WdFJ6amY3V1Nja0l4?=
 =?utf-8?B?eW92MXl5a29YODZReWc5ZER6blVmZjc0bHVRcVRKeHlNYkFlZnRuUGIvNWFp?=
 =?utf-8?B?Q05ndURXTTZlcFl1Nzd3c1hrNzJpNFhMMktCYk1pc2tHZUJzcWFzZitNVmtN?=
 =?utf-8?B?bjlFaUo0MUJwS0hPUFlCU2x5NlJtWHJ3bWVTUlQ0TXE1d0hPMXpFd2kvOFph?=
 =?utf-8?B?S2xQM1J3bjd4K2hNazFjQzdMdFRNWGY1RGE0QTRpR2c2a1hGL2ZDdHhEV2tS?=
 =?utf-8?B?aWptVmphZTVPdGJJZDVJQkZBSDRmN1loRkRySDM3WDF5VWJObytVWmRXQmZy?=
 =?utf-8?B?UFJwdEdlM1l6TGROaUIwVEVxMEg5UzVGUVNiUnpxY1NHb0RXc0RVVGVkaHNT?=
 =?utf-8?B?ekhXelBoaWZxVmVOVVJ1UFgwZkR0eTdremQrMGI4WDZ2eHByM3pFSHVXTDd5?=
 =?utf-8?B?WGxVYm1ocXVaM3hDL01SVmlzU2twN1dHNGN0MkptbG01NTJaRjcxMlNnNUJq?=
 =?utf-8?B?Q0ovU0w1S3VCSlY4YTdkTGFpV1VFeTFuVWRkVHpRQUpZRExZVTNrSDVDQ0Ns?=
 =?utf-8?B?aXVuWEJBMk1GMU1qR1dicDZGeW1ya014MDNNTjAwTkU2MVcvU0ErUmNDRjEr?=
 =?utf-8?B?UXY2N1d4RmRZLzNZM09qdVh0TStuZmlzeG8rdnJ5OVBYaWN6cXkvVDNDbytM?=
 =?utf-8?B?clZsSXRoekhqeW9FdlUyOXZIa0M4bkdwYlY1QlM3NC91L2tYOUlRQ2kvdGdI?=
 =?utf-8?B?aWlTMkw0QlVidjdNQXZRZFhkRzcvV0ZzbEhiYU9NdTl5cmM2bE9ONVNmS2Rv?=
 =?utf-8?B?MG4rd0trbExQWFNobUtXS0orT0FxK05ZaHdLeVlRYUhYaXUvbzNqR3BOVmhi?=
 =?utf-8?B?TzhRZUh4V0RjZXhDeW9CVkovSHQ0OEZZcjNleXZTMGhzcmc0THNLekRCR0da?=
 =?utf-8?B?ZFgrYmhKOTh2c3l4WFpIem9oT2FhQ0xUMU5VaExXTGZLYytKenRzSUlWa21s?=
 =?utf-8?B?NGN1QU9tdWkyeDd2NVFQZ1BsVDZPaDRFS2pJTVArZjVVNDhkQUZwbGR3RHIw?=
 =?utf-8?B?SkluU25hNUFSVTAwa1VIS1BZR0hUUHBXZXpxbzhUOGRZYTQyUkMxSlBqQWpS?=
 =?utf-8?B?MVY1SFhjc3BKVFdhNVFjL21jSVdYVkduY3ZsZlNua0JZaFpYUksvbU9yaU1U?=
 =?utf-8?B?VDcrdTBkeVVXaEcyeExkeUdYSTZSbDQ0R1pBcjdzb295eGF6dnZVSEQ1VXk5?=
 =?utf-8?B?YTBXRk9pODJWM3dwQ3hZenp4TlBHdVplV0cvb3E2NDdYRzF6M2tmVmE0NlVR?=
 =?utf-8?B?YVRHL01GZ3VDdGIzeFJPTUNlcHd5YXpKa1FqSHFIZTQ4MzB5SGpyU2hKN1Bj?=
 =?utf-8?B?UWljTnpTdlROMHpWcU45SDdsTXBxODlZT1VpSVhHTytuZS93bENTZDIvYVha?=
 =?utf-8?B?QXlLSWlHeU9uajZ2K21IMGJiSDB0anFYdkh3SkV1aHNHZ0Y2NDY4blJzQ2U5?=
 =?utf-8?B?OExUM2JZTGlkNitsN0JOVFA3endmKy9pVGZqeWg3bDJjUFA1YmdFUUF0a2dH?=
 =?utf-8?B?bFh3Q0FEeUJpZEtUK1BTenZsSk5ZQkk2TFFCQ2JmZkxTZGFkQlF4S2k4VUZs?=
 =?utf-8?B?cEJJY0MrREc4aFdmSzNKZGJ5TWJKWEVTN1d0ZTZHQlVTZE5VTks0ZEtGQ01s?=
 =?utf-8?B?dXVEYnZOckxNZk02ZHNTa05vZkJxR29yMzNxN1JEY3VoQzdmekEyalhMSFdr?=
 =?utf-8?B?M2NTYzFuQm9HQnpmUHpWb2JDUzArWGNETWsydFp1Rm5YMTdSSlkxdHpiYTFq?=
 =?utf-8?B?OENhWlIwVGpLbHNwdDBqNEh1dm1XYWNWYlB3aVh0VXY1VGdSdWE4ZkhRK2tB?=
 =?utf-8?B?NGxXdER4TlFMcEwxdXBjNUVJaHY2YW51Q1NCNm9GaENDdXBiUExsVTJKd1pE?=
 =?utf-8?B?eTlQVnkzY2ZxOXhhNlBBcW5kR0E1M2YvZDRMb3pGTTZpUWNQdCsvcGQvQW5p?=
 =?utf-8?B?b05qMTFreUp1NU9sbmZpVUw5QmluM1dqVUNHSU1hLzNpYmlJOTg2eXhxSHJD?=
 =?utf-8?Q?t4b4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:21:42.2888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e62598-2375-456b-eb01-08de26301144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
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

From: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>

Replace the GC IP version hard-coded check with multi-aid check in
kfd_node_by_irq_ids(). If aid_mask is not set, we immediately return
dev->nodes[0] otherwise we iterate and match using kfd_irq_is_from_node().

Signed-off-by: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb1..7bf0fac50fa2d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1163,9 +1163,11 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	struct kfd_dev *dev = adev->kfd.dev;
 	uint32_t i;
 
-	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) &&
-	    KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 4) &&
-	    KFD_GC_VERSION(dev) != IP_VERSION(9, 5, 0))
+	/*
+	 * On multi-aid system, attempt per-node matching. Otherwise,
+	 * fall back to the first node.
+	 */
+	if (!amdgpu_is_multi_aid(adev))
 		return dev->nodes[0];
 
 	for (i = 0; i < dev->num_nodes; i++)
-- 
2.51.1

