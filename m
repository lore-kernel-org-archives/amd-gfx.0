Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4073EB5965
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 04:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F1710E00E;
	Wed, 11 Feb 2026 04:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHL84XHx";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0FA10E00E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 04:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DF+Qzj7Ebs8e4RXQ814Uoq/vc8UG7BQVdQPO+YzAtkraBcPkxTEF2yWpVjJ+NLshnPpzdBZPbKUOpEvya31OKlOxaK1aCKZJdbUPGxfEO2+Q395ix8/gi1sNsQaNPeC/RTkBfpNEqvwx9jkeP95PRNAsg27CDQ2hEwIksfeh5PnVfXixQRl23W/4jWVAoHkRDh5hXzSD8G0rB9WuBZlBvu9eYwnk/7KtQSGjwNf9YmibsCFhC2WlBbj+6ySVJUkPqU/u07o1Wl/Z7aLiBrcORNywv6JwHU2+PrtV5bJhhDvrzTd9eh6QLRlEB+d242rVsV/O1bfpI+iGF0zOGPUqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HPe0/RdG5wyWg+59mIcUbbobWyNkb9Rct3aJrb48rA=;
 b=d1sca1GsX4Nj+Fltn8lNrJPazkoZlrWxmrncsQf943rtRtVMN8Tc842/A3SNtzMwSpWI8SF3jfjmmHDlqitl1Ug+W+Ems1jXzgkRBkTZiwgGUkwgUSt4fDibn471FeyfUjUUzquebxnmnQAKyLd6bEO7YWDh7RW+Q0h3QBVYgn0PoZhK4iPcwDdup9oRmB2kL71pfl6hhwovbqobKO3LOfyMkEQRFxbxUNzDziRZDuBH20pGXJOy40fBUYRxffz7bt5/uqs+tQBLC3/K5i8EoEvttaZkJWCQXAClkK/2kBOs3FM0pCoEUacUtuGmsAHahohw9Zp2d0cyO2f+Tb4DCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HPe0/RdG5wyWg+59mIcUbbobWyNkb9Rct3aJrb48rA=;
 b=iHL84XHxZ2CBOVRREki7NW54Q2WJ71DuD81ky69CoL0BIJH9e1Gt0/KrhQX0OX9sYYIuv80Rk6tO5k4L/Tf8Keb8i9sVgdDZla93KbVMJViNDnPzfVGKTBKCKnxJv800qzPYiCM5oN23eTAImqvEV9sVJ6UWwQJQN+Yb4vfviE0=
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 04:19:16 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::43) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Wed,
 11 Feb 2026 04:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 04:19:15 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 22:19:14 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amdgpu:Add psp v13_0_15 ip block
Date: Wed, 11 Feb 2026 12:18:42 +0800
Message-ID: <20260211041842.2136714-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: f63b5a47-41bf-4699-1e57-08de6924b804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T8QLNkXNvtbz3s45dk0IpaDgfECJ/wp6MIFTuehfoJS5op3Stp2YlVv8ZOQm?=
 =?us-ascii?Q?JqrGVkGyG+GAgs0zvc1MQbT0gVckuMSGqc3drFNY2xMMinjf2XSjH2OXGROz?=
 =?us-ascii?Q?HBJf1chdgLO708o1jAhGb47AOyUMfFdGpsAUnKMDXIiDVpqZs75sZmOK4aFt?=
 =?us-ascii?Q?JYtCgJfceiS6mRMcY54jH6moUsj0cpAbGIkcDr07UYiVp+wuc/XM9bC8rzJY?=
 =?us-ascii?Q?pTrMlpWtlOYgSIOwOphwalqPgli2ICARjdtro4MuWKaj0yHGc+4fMcSgLScS?=
 =?us-ascii?Q?Qn8Jem56c4RVdV6hM3x8+zTR8TpJZDnqluuVh4JKjp3pzD8dmYq1e7VQRNPq?=
 =?us-ascii?Q?oFGiMZudopQb6At05gy+5RgZkJ7rt9akck1PFGzBlr+nHq2A+ZQaptueVMJJ?=
 =?us-ascii?Q?2hsxx1DBKOENUURIaZ+L3lgYHAZSzJd1P7S2Gc/Es9KdJEMBvXgrX5STl12f?=
 =?us-ascii?Q?OucTdjhKqhFF3hJCY6rvk9JgZfR3b+88b9p95zGK9OirU1WINGe9ulHHVA6g?=
 =?us-ascii?Q?oPPRVtaXstS4hI7BPA3gKDa8aAaX/LXIOKk4y5JNFMJ8o4kG0txpSz9Pvj4f?=
 =?us-ascii?Q?vm+H4UoLJoJlE2BfnUNNFzPfGh6f0oQWhzY/tgEBwx3lDh6wo7VLp9QrRgzN?=
 =?us-ascii?Q?XgLdZW804l1jrGM1PtrRwKnqZ0nYm6i7axMCc9t7V1BtOWKY0qR8vQ+xMfkL?=
 =?us-ascii?Q?zC0XMdXrfYviZvEco8kZ1HqnAEBDOmYbW6z8HjlYBvn4eVOBQ+jEORJRdg0g?=
 =?us-ascii?Q?xmoEUW9peB5/giIJSJc+8GWc7xh6QA4nlQgfknYr8GiLzeG2pbvzMdirdxbo?=
 =?us-ascii?Q?d11z4BaFDLBH2s/qwhs3euF4CYS41fFygBBcXtlDFN3Og2yvP3rB6G7LYvYy?=
 =?us-ascii?Q?2c3H8vjsMtcEuqPAusBdXjhjkn+cZ1gE3bE+OQ/q/njzVcP1k6kM20s7h7rs?=
 =?us-ascii?Q?AF9vIE6MzQOkWxd6GVkquP9RhgdHmFoif4/e74zF7rxQXLWEu8btvzUrOpwI?=
 =?us-ascii?Q?hxn7NY8iXl9DQOIs5vXmYrTjkxrK2SoJuHGBI9T84QjokKvNfzq1Uu4tacqn?=
 =?us-ascii?Q?52zHhIOo2Msq7c8J24bqtv/Ioq1MYXMKfqcJiPJhnsxXR3HkPv87TabVKRVh?=
 =?us-ascii?Q?aCUQZ/qZp9/WhfzNs+GEUUCAE7MrBmBcV0g0TTC+6lv0Xm4ye74hm8WCAGBi?=
 =?us-ascii?Q?iHyxbK34g9AJ7q+4V/Z5PexxsS+PDG2Vq0VpkdFMqsHLictA03MgJ1Yxf7o7?=
 =?us-ascii?Q?7e7j4LN1mZV2YOKXISF3iZUjsyQMIvyUh561K9AoDlHVFKOFNjTkmGZaWo22?=
 =?us-ascii?Q?GmHs45TemNwjz48U7GuUj0todIUhW6tGb4kI6V6zif8Wo270kkZVMYq334/k?=
 =?us-ascii?Q?AGJSjY72DONjH4IFk2lQ1sYEtLSNzNsqWW5Mx5EY2IsUv4K7ExbkwComoG9c?=
 =?us-ascii?Q?cDuvhcu3F3H1cWZu1c1JzOjKIcCrcR3nYqcMSt9sxajYdOVNNGbj8s5BZKek?=
 =?us-ascii?Q?QvIytn8HckU2z/6sM5YO5XQmWSMyGRUi/p2N8ZQB8e9qJtSwR5MWDEstkOF8?=
 =?us-ascii?Q?+a84kwq1l5u++j/ioQCiy0eRRuvLOIsfWrV4o8v6/QB1VGbw0tvx+9TJKdRk?=
 =?us-ascii?Q?ljykMQFjLlezRTXQeH1ms1a1ambuyuPVw567mWJEPehZXr9+DYd0uD8W6qyv?=
 =?us-ascii?Q?C9YaPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LFBEExtfuIF9f+uQKnYRjpA8wRYEarX8xG6vGcZR5uo+d6DB89zgJScq6gvh9F7oJEWFpMtgmy6NsmNkCnjjfbcrLRDLuQRCQ59v+oUhgV8nwcHLnRdPiMdH0BpFyFK2sA6tbcEKPzPkcFmtwCOxXVkQO5d2zC66s5UXQDVx1t62K5YK0fN2RI1dwPnqTXCPk78l2KtDMto/qCCksZXSiyRwg2EwljISekm5giaJ8Hg/JZKTIXGTpCi1sMTiGCnB5tD3l1+T8JKq8Ly06dSkcnrvdjAVyIZIieAvhKIMWahTXqDbnR7PFQX3TYx0kGVeyXkUFhRE14IEK3RKl8FGmbVatG7FXk6QK7FQYlnTnrU1H5yiSu1j/CDe/ZBfcSrRUMHLaKE1JzCDRXWeBPIAapAHO6CLbW02nc/jhl1ldY8/xbt48EHim2107bB5xWAS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 04:19:15.8886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63b5a47-41bf-4699-1e57-08de6924b804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
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

Add support for psp v13_0_15 ip block

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  3 ++-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 41e63c286912..0d369462496e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2164,6 +2164,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 15):
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 5eeea965032a..a7c7b378c696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -148,6 +148,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		break;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 15):
 		ret = psp_init_cap_microcode(psp, ucode_prefix);
 		ret &= psp_init_ta_microcode(psp, ucode_prefix);
 		break;
@@ -219,6 +220,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp->autoload_supported = false;
 		break;
 	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 15):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = false;
 		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
@@ -383,7 +385,8 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14))
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+		amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15))
 		return false;
 
 	db_header_pos = adev->gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index af4a7d7c4abd..d1e1a4369521 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -57,6 +57,8 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_12_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_12_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_14_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_14_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_15_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_15_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_1_toc.bin");
@@ -121,6 +123,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 15):
 		err = psp_init_sos_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
@@ -156,7 +159,8 @@ static void psp_v13_0_bootloader_print_status(struct psp_context *psp,
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) {
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+		amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15)) {
 		at = 0;
 		for_each_inst(i, adev->aid_mask) {
 			bl_status_reg =
@@ -202,7 +206,8 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	retry_cnt =
 		((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 		  amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-		  amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14))) ?
+		  amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+		  amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15))) ?
 			PSP_VMBX_POLLING_LIMIT :
 			10;
 	/* Wait for bootloader to signify that it is ready having bit 31 of
@@ -232,7 +237,8 @@ static int psp_v13_0_wait_for_bootloader_steady_state(struct psp_context *psp)
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) {
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15)) {
 		ret = psp_v13_0_wait_for_vmbx_ready(psp);
 		if (ret)
 			amdgpu_ras_query_boot_status(adev, 4);
@@ -872,7 +878,8 @@ static bool psp_v13_0_get_ras_capability(struct psp_context *psp)
 
 	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) &&
+	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15)) &&
 	    (!(adev->flags & AMD_IS_APU))) {
 		reg_data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
 		adev->ras_hw_enabled = (reg_data & GENMASK_ULL(23, 0));
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 54b14751fd7a..4e037a6978f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1478,7 +1478,8 @@ static void soc15_common_get_clockgating_state(struct amdgpu_ip_block *ip_block,
 	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 2)) &&
 	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6)) &&
 	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 12)) &&
-	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 14))) {
+	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 14)) &&
+		(amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 15))) {
 		/* AMD_CG_SUPPORT_DRM_MGCG */
 		data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
 		if (!(data & 0x01000000))
-- 
2.34.1

