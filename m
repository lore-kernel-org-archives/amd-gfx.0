Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA2FF532CE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 04:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40CAC10E008;
	Tue, 24 Mar 2026 04:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TEf1lOGH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6FED10E008
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 04:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0Lc90CbIRJHHgB++UFxhC9ctvPgbNAagu5hiD/ddkuQA3Q18FQ7w2jTmAfDLnjSQ3M8zTwX6Znz1MNVvqeXc6DYTs7rQVkynKYTKRJK2kaDuE3YNo/ZHhi3fjtFxoOLr/GRzl347RURq+deqgYs4u0AOTXpxGCl6xpiTv4OaZMt7ovCR6ta0wpm62LtxrDvxhZEx07srLj/Y4o3JuuzbjiDcSPG6jkME6wjzrfRKJRJspHWHalFImDLEvi6l7Je5CvM5GlmKesJbJvY54gracBaXqPH11ExgPkGnYkwojqmnN5uGvvDknUcz/0VX4FM9qzITdYBJ7FrhK0BITUJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5ps+V2IMZmgs1fUHxrAEf3VQrbtYcTPFEqpEzbKWt8=;
 b=yfq6HrTHsetmP+VXTOHtPwg+lD7mbEH3E7r+pcrbiuKNIZ4PKASfMnGKn10Glgwki86sgBbvHbsNebCT+MrQiuiQc/Qku4VEkwICUudGvlhlgb3V9l3ZHfhhu2HVCjvrQbxhBZL3Onalulg4DJ1cT/l5+PdHkrmOTUS40V4H8WFjYQPICA/Ld9xe0sT5YRmFbV/9i7fWYSRYxORwatYJE/kU4zsEMvLzb8iYFvT+759wOoe0uGvRsNTHl5/yxfRtaulKGchMhf5gQCvV+Z7GgG7B4qg+r7oyn7HFhtw+Kn0qf+hWgBRUUfiVau00yOcnNlUXUjNdsj9/ughcC65hEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5ps+V2IMZmgs1fUHxrAEf3VQrbtYcTPFEqpEzbKWt8=;
 b=TEf1lOGHK+37b1rD1SVfWLU+jsXJSOQ9S/n9193ONqhs9JhsZB0i6JMZzrcRL2Id/A31mWDabUcyoTyx4qaIIRDG718E1tJJNoA0P5aYhKwVbc8gk9VBzBxncHM3STQPXuptBberPoVG7ycjZLyvtRPAu8Jlhfd/nWd1gjcvAok=
Received: from DM6PR14CA0066.namprd14.prod.outlook.com (2603:10b6:5:18f::43)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 04:11:47 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::f4) by DM6PR14CA0066.outlook.office365.com
 (2603:10b6:5:18f::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 04:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 04:11:46 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 23:11:44 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH V2] drm/amdgpu: add support to query vram info from firmware
Date: Tue, 24 Mar 2026 12:11:23 +0800
Message-ID: <20260324041123.1882318-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 418e36bb-6e9f-4118-3064-08de895b76ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: QPdkSSJZonSHA233WihS73tcZFnkQl9+GIRSB1NkmxDL6ZaNTt4CZtTuAN++XvhsE7p82Vfot7Fen+8gxLZduPj4Ma/bVYgcIRNaZEw8HTrj95Goa6syupD00TzJCab7OTilutrjXP4M/xUM0XrFwhtfPJ/146QbMWtZpkJmT+LbTgCBq6e3Ln6ZfjYE0YNl/MYaCbCnW1RWNR2XresGHKUNe3li2ezUVpZYBHg2M45h1lOR6MMC2h9gvDQKRqDtwY2MP9Ry5vT0Hogm4Zcszhz+TMQZV9cuJxfPEm+SCLrIWeypI+2v+KyAWJsr1V5yC78e0Rd29yGnpKPZARk2bZOKu6Z5ah6O+7N9l7eISmCesBo2bv0EJVKvh5t8zeNdBFqnzTjYK8WrRODHWwk/CwGSRaghmSN1ysGxEFvUKuclIKulArIoAKmWGN3slqKnrVYbycnAsSxQ0wGtXZdGz+jvaHQ36vluVd2Y+E3I53nd8WhFF3L/ekCSgspXLqRtt0wqflmpDYczGM7feU45MwLf0YtCdmLBESiIwlvb/sV3MYsfalDvxbclGnm/mX0tPtzhAb60KHuzBJqegcFT02H+RTryt0fYWlRaTWyRjytvthrUusvLsgNAW5bj8i8L/+AuAXmjpT1cTnZ7lYl+6LneJj+itBU5UAUUq4ICTTQcQSj2xpTq/h79muIICjV8MYHdbmSokrV/1Mble2YWGoJZfDIg3NuZbEwcR7mZlWiDSiqj/w7ylnqpcikr/A+PqHNRPpp3t6aG2nFOls/pqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6empoZw2/EM98/TWXMK1hBEvyLog4vsP8Z8ahLnQwgHSVWSKxkPq88ofoIdrwsOOUsSgsa6/RKv/psKAKsxUHezqrhvyxd3iCeIYJ4g/Iuxd/7g4SM/LB/zaPBDJc9uSqRFL2NJ3IdwPqEZtsHDaW2NAO6r+WtPsMiYTQgSbdf1tt0Ze/38VDQVjRR6P5oIJF4L5qIpnOUs6K9A2Sx5zOgqnLWduA7snPEi0y5PZ3mvGizPme2tzZUq50Py92mPEu67TTCwyQLZtZfM21s/krOSraE+i4xwMRobrf8xcIo4kHDypbLfWPMnyTRDdZKwN8/gnPGWsR32IVn7R1TpA8Wee2YKsz8YO2Dz0YvJg/AOJfHiEwx7NS/8fBj2wjDzymWTyw7qrQ4tGKbGi9yWWOa/zDWvhTWEhtFW0R0lB7zkbH398ici6fIXahsDmWi2A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 04:11:46.2652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e36bb-6e9f-4118-3064-08de895b76ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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

add support to query vram info from firmware

v2: change APU vram type, add multi-aid check

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 13 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 56 ++++++++++---------
 2 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 7f4751e5caaf..504b5f0a74ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -399,6 +399,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
+		case IP_VERSION(9, 5, 0):
+		case IP_VERSION(9, 4, 4):
+		case IP_VERSION(9, 4, 3):
 			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
 			break;
 		default:
@@ -475,6 +478,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 			switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 			case IP_VERSION(12, 0, 0):
 			case IP_VERSION(12, 0, 1):
+			case IP_VERSION(9, 5, 0):
+			case IP_VERSION(9, 4, 4):
+			case IP_VERSION(9, 4, 3):
 				umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
 
 				if (frev == 4) {
@@ -488,8 +494,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 							*vram_vendor = mem_vendor;
 						if (vram_type)
 							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-						if (vram_width)
+						if (vram_width) {
 							*vram_width = mem_channel_number * (1 << mem_channel_width);
+							if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
+							    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+							    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+								*vram_width *= 4;
+						}
 						break;
 					default:
 						return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1ca0202cfdea..285eecb65522 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
 }
 
-static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
+static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
 {
 	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
+	int dev_var = adev->pdev->device & 0xF;
 	u32 vram_info;
 
-	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
-	adev->gmc.vram_width = 128 * 64;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
-		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
-		adev->rev_id == 0x3)
-		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
-
-	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
-		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
-		adev->gmc.vram_vendor = vram_info & 0xF;
+	if (adev->gmc.is_app_apu) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+		adev->gmc.vram_width = 128 * 64;
+	} else if (adev->flags & AMD_IS_APU) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
+		adev->gmc.vram_width = 64 * 64;
+	} else if (amdgpu_is_multi_aid(adev)) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+		adev->gmc.vram_width = 128 * 64;
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
+		    adev->rev_id == 0x3)
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+		    (dev_var == 0x5))
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
+			vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
+			adev->gmc.vram_vendor = vram_info & 0xF;
+		}
 	}
 }
 
@@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (amdgpu_is_multi_aid(adev)) {
-		gmc_v9_4_3_init_vram_info(adev);
-	} else if (!adev->bios) {
-		if (adev->flags & AMD_IS_APU) {
-			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
-			adev->gmc.vram_width = 64 * 64;
-		} else {
-			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
-			adev->gmc.vram_width = 128 * 64;
-		}
+	if (!adev->bios) {
+		gmc_v9_0_init_vram_info(adev);
 	} else {
 		r = amdgpu_atomfirmware_get_vram_info(adev,
-			&vram_width, &vram_type, &vram_vendor);
+				&vram_width, &vram_type, &vram_vendor);
 		if (amdgpu_sriov_vf(adev))
 			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
 			 * and DF related registers is not readable, seems hardcord is the
@@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.vram_type = vram_type;
 		adev->gmc.vram_vendor = vram_vendor;
 	}
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 2, 2):
-- 
2.34.1

