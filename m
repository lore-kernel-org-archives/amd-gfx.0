Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE8BCAC587
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 02:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D2F10E296;
	Mon, 15 Sep 2025 02:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EcIhkWFK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2374E10E28C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 02:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4lVQ4QDiyXXU68HE+1nTKO6Wgd1UGFBThOm4F5YAQgxMbf9brEKkiCSE25IbMPUIm9XWlkXXJ5E0iOYmZ2a35t56CwwUtGJz8hPUt/qLj3wAs0Ss4ERPvlrycwbRAMFk9DvTPf+mk/uMaLPFXpT7J7aQ859ndR/IgtwMXW++KIso/kg1Plts2FlpmwI+gCzPtcngkNucdXCQGmlI4zX1JZeinVmBEoEYRaTNmA7a1uQZX64fyKD42uqIYj4yYnjtRTPvIIoVGw97EEzi1/+s2akQJl41lRXVKNXuGGxt94YferkOnh6ZuiaYcCn5Dz3TBHin/boIr619idERQdw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYM9qyZnyrW8USiy9hiFuLhBFG89smpLtyvhbTuTxkg=;
 b=H4WwD9iYW7N8UJ9+bHI1Cf+7HQuUA7T3b9FmyUuBv7K/u0X/VKeV17YnfDc0/qLlnhW3RAauadP3f2oVtshaTVVEgxhenf47m1wf1YBJg7PZ9C2689VXiqSMcTEWnp2Hyt6QQ61Tmx/2Yol0SnT0cTeWknB8mYReMBGbosIr3ONiaC7MKYCN3pqqP9Z892D9qnS+p+1ToC72kB1rcPsJZ5DbOW9V9hJqtMhBt0GIxJNWGTA3GLChbN8FKrvCdj1jSJcronKyoiXmXmAp/rz7cn1dBSPj425poGqKDi8Bq679lfQmF8w+CZmrXFQcfyqHh11ntcs2fv3js43egEmJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYM9qyZnyrW8USiy9hiFuLhBFG89smpLtyvhbTuTxkg=;
 b=EcIhkWFKl3wda9adee/61D55zkjq63BaUOCys91Jxl9SJsNPAlV63UoYCLjkKeCIOT1x5A/pYixWvM6y4kBzBO6PzTST8a6eKU6zhmn9OsgIWCaASDPEolhsGKyHN4yAk1CAg1VmaIaqejiWp68X6D70TKIs/NkaHroKmeLHS4Y=
Received: from BN0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:408:ec::14)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 02:09:33 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::c0) by BN0PR04CA0099.outlook.office365.com
 (2603:10b6:408:ec::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 02:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 02:09:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 14 Sep
 2025 19:09:31 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 14 Sep
 2025 21:09:31 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 14 Sep 2025 19:09:29 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
Subject: [v5 3/4] drm/amdgpu: Move VCN reset mask setup to late_init for VCN
 5.0.1
Date: Mon, 15 Sep 2025 10:08:45 +0800
Message-ID: <20250915020924.137122-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915020924.137122-1-Jesse.Zhang@amd.com>
References: <20250915020924.137122-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: ae17b6d8-1ac4-4300-6a27-08ddf3fce932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zCq2DRJNn/MMpIBilzM+9p914vZQAZdSegVRfVPN1pKgFDqNKt5ccZIVZQiD?=
 =?us-ascii?Q?fJPjRsuPvtwYUq/pIA4wWrwXGcfsABuGz8CErnG7OidLj1Hg56gbYOWSTUWz?=
 =?us-ascii?Q?C1Kz2+lsmKiHmr4UsvaByuE9Qxyyv0+lhiWueqEtxP5Vov8aVOp6F9bOmU/7?=
 =?us-ascii?Q?Yhu2bm6UkqOakNtlsXILfF7ecEKATGQ7DS50MNPqSZEkAv+L+aOf/JJHHOOz?=
 =?us-ascii?Q?XmQb2tcTKv71F+vdA/KwmIp0SSBBvh7XbvSjCGc9oBz5n/Ow//U4MxGgJkCq?=
 =?us-ascii?Q?8oJlnWOJf9n9Rqo9MAJGZc4XSq6mQoEMsnTTZpEqFxe0NDl2oO7lEAfxEmiY?=
 =?us-ascii?Q?lAHs8rQzGT/2m5Xl2Db3A6w0qI0eCjeMcI/UUiGuo+bJqpaB38WVZSGU39fI?=
 =?us-ascii?Q?PuiebICKOK7mV124HH5FZK4hBVnKwY+L4/WgQR1RiiqqIYX8aCpoVwot+ImZ?=
 =?us-ascii?Q?DlL/cDXUNDEaXrnNVBZOBVH+oPTUQGxmLvKPf55xk7LffFc46c3kI2zRLA0B?=
 =?us-ascii?Q?9dq2YEHD0ID9W40suRaSXOnmmz1zTji4Zai87mKzRXW1i97EkaGHEPaA+PzA?=
 =?us-ascii?Q?nzSOT5L+3Dm9ZvCa0twG+8iTcEQiHcVpq8BOSyCWByLbPJ3th0vU0D6mSgLL?=
 =?us-ascii?Q?c3SfSS2sXaPPAA3vZM/VytN1WCd381y17ehbbANt0Gx6c4X+Rgxeg4WArEEt?=
 =?us-ascii?Q?BJSvNSpaZKcv2s/T+y4TscLj36nid9uVQFY2/2dEsYaNY2Clw1e2XTzW53ze?=
 =?us-ascii?Q?FKjUHZxz8Zgt3NxxKSv6ALffJ1LDGxIQznie6ILUEOmrdph/np44Hm4cBzEJ?=
 =?us-ascii?Q?uJG3/Ms2gZm5AM7SgGoPX2Qj+yRQB26acxBKB8NsvZ44bEt8I9EQmL/uOXBD?=
 =?us-ascii?Q?06mM5OLgJ15/ABAqNIf1VWPY0D80mmF5U30aWkTbDj4YfLC1jynwgdIbpeGR?=
 =?us-ascii?Q?d/4OAx+1yikhE4CdiULA50xpjo1WXOnIXkKzJ+02I+qeEBf9oo+VMqBHpVUk?=
 =?us-ascii?Q?rid+zRyF0VLcCQ7P8xaBCOEIzdzJbrWlaszQyWYdaS5BVsjWLlqWHT8BxQXd?=
 =?us-ascii?Q?PXWzjht7gDlDDiN0wZrPgitCRUlEV9IRmbIqUQGmdu0yKsyqiri7jP9SWWb9?=
 =?us-ascii?Q?ZQWi5GK3Nr0auXY074A8ovXECAIBp+p/owU2iXRUDYbphlcC4OurFu9G9Nkc?=
 =?us-ascii?Q?P4N44ibeD5YpIvxrDRQq4IWzZZawSBuqcqLWo1rq2VkqAIQAGxDkImfJTtqm?=
 =?us-ascii?Q?eli+75D81FcdBNMa4W8ioIfRMA+poJYH7VlqUM414uNCKavRgvSx/ED79WTE?=
 =?us-ascii?Q?gZO296aXKnJ+bVpgAbihKDVCUDljidl6+eZ8q97RZ8IAKPJf+8wojVu4s5bk?=
 =?us-ascii?Q?hw+iPCUHJKaOJfPWokA79WKUIvfn2xrMZCIbobo2ghGcw0FsNFM9HMBbPQO/?=
 =?us-ascii?Q?B2KzqRLJi2DXZcQVOzJOgdDIJ1THWI2ia6BmFnwHR9kyrK0rwxBx0ffSMpu6?=
 =?us-ascii?Q?3HL9hvuVcE/tnXQ1oAwa1Hjbt/D9oU+A1/8w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 02:09:32.5756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae17b6d8-1ac4-4300-6a27-08ddf3fce932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766
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

This patch moves the initialization of the VCN supported_reset mask from
sw_init to a new late_init function for VCN 5.0.1. The change ensures
that all necessary hardware and firmware initialization is complete
before determining the supported reset types.

Key changes:
- Added vcn_v5_0_1_late_init() function to handle late initialization
- Moved supported_reset mask setup from sw_init to late_init
- Added check for per-queue reset support via amdgpu_dpm_reset_vcn_is_supported()
- Updated ip_funcs to use the new late_init function

This change helps ensure proper reset behavior by waiting until all
dependencies are initialized before determining available reset types.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 11b931153ea1..714350cabf2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -113,6 +113,25 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v5_0_1_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 12):
+		if ((adev->psp.sos.fw_version >= 0x00450025) && amdgpu_dpm_reset_vcn_is_supported(adev))
+			adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static void vcn_v5_0_1_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
 	struct amdgpu_vcn5_fw_shared *fw_shared;
@@ -187,10 +206,6 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_v5_0_1_fw_shared_init(adev, i);
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->vcn.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1541,7 +1556,7 @@ static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.name = "vcn_v5_0_1",
 	.early_init = vcn_v5_0_1_early_init,
-	.late_init = NULL,
+	.late_init = vcn_v5_0_1_late_init,
 	.sw_init = vcn_v5_0_1_sw_init,
 	.sw_fini = vcn_v5_0_1_sw_fini,
 	.hw_init = vcn_v5_0_1_hw_init,
-- 
2.49.0

