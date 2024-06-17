Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D290C27C79
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 10:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC66510E336;
	Mon, 17 Jun 2024 10:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rzOnPEVK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A46910E336
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 10:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lceAmhIkEDRoGBSpDvtkvJ837r1vqANx0FUJcxW4iSiPGjn26abdwZ0y0lujnRrBNdDGXwccrgPeKMhVYUITUY8YxWcvGfDlR0MN5RJyTQTqZrhk7P2r/PNakQXGo6erR3JFLp4Xolw4jnDK3mYsPn7A3gjDIbfbge+Q0yFNVpcmm04+LSGaRJ+xfg+V6vNA4+rf66MqpPxkc6F9Mz7HXDW0XTECv3D7kT0QLXtD2cQjz88wW1/RavNjpD9yAhSFrNP71+ynmuVLpsqlnKmKzHWNjhLrCg5nXpQCwG+Qqk0qCLUM4rYxZqqJUq7UqOfYJPjYflHXfMMyuo0YEdt84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OswXcXoIlmA5eLcpTGpcsYhFdKYs1w7IknB38APD2d4=;
 b=oZrDUnCiHlJu2XO0hY1PgLayu/BVkp7PrlRSVcWUThCStipDHMWQ0L8LpUd/NzZ3i6lFgBlwMupX/Hh9ruoqJQG69OPP7rg5Hr3FTVu/UgToORhEYzaSG7Fei/F/3MZSHlkIdEj1nzE1WoZL63O8d/L4cH1cQiBghCRyVoWnv8D2OnxVRYSqlECUCENLe27I2LFkByj2GDqOjygcj/PbdY2SuBjMnOrRflX8voEgL9dWYAsYrrMW8vOCCy/u5gMKmL7Nr6jQznEJEXkaIVs1S92J0HnOB/adU9uTdjviQ19ZcABjRhvyrNplFtbp8Qcf8qqTwU2w6T65tneAgVsqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OswXcXoIlmA5eLcpTGpcsYhFdKYs1w7IknB38APD2d4=;
 b=rzOnPEVKTUwf1bmZurpnTn5atuZAPlK5TGGiaIoQJRWIjb/mAlkNyqJZRa3du3pKGqnkUI62zsXltwxAzKJmjPVtIrYxUCmQUGsKasPANBj92IC90TC7pViJtJ21CmcBZeRy9GkcE8OPoHPvxavmWOw82VZjaqOBDS9Ku0f8LqE=
Received: from MN2PR11CA0023.namprd11.prod.outlook.com (2603:10b6:208:23b::28)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 10:11:17 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::23) by MN2PR11CA0023.outlook.office365.com
 (2603:10b6:208:23b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 10:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 10:11:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:11:16 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 05:11:15 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write
 under sriov
Date: Mon, 17 Jun 2024 18:11:14 +0800
Message-ID: <20240617101114.243566-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: a2271516-a668-42cf-7be0-08dc8eb5d3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?opPeCDw7tyUsrLDnrsD0mDj/cEYlE9LtDYFi62i1v2SLQMxSiGKAFA0AUjY6?=
 =?us-ascii?Q?gTRthLtNNSDcqGtLsjNsWJBd6jGvlzAjtYRe99NLQLygpOZlcwbdAkuAUd08?=
 =?us-ascii?Q?+q/eBl3NwiKGvMnH3/vaYfSW9ZPntApSijwP1ROamy+gDIiml3++VpHrAR9G?=
 =?us-ascii?Q?pDGuR8OqJbOmd0AuKj49bY6F0w1WagrcIkLgXgtcsUEYqHvI20nNg4uT8z6J?=
 =?us-ascii?Q?OWQ1Zhmt8YuBdX4DoHmUlnW1QHu2m4c4EW6cT6JRf1nsqW1enXpVP52HSB+q?=
 =?us-ascii?Q?sMz3AhB4syM2Axlyr3QeaoE9fc5b5ax4ucFUzu/4BkktreDcSDokZI6fU2yK?=
 =?us-ascii?Q?dYHUZv9GUwfiCN21oB9iDXKy2SgUkX5FqtNNoMeW15+Ipw4kStL718vnSSc/?=
 =?us-ascii?Q?ki6F9JNWAdd4g5mKrvxLXUtLRLfsyv2ppi5i5GkCH77padV7o8NJEV3YIKVt?=
 =?us-ascii?Q?0cqz5Xl2eqNAUL1khSYoQZdWf5LMJre7PaoRiuG7FKNbKJK80ZYwwrEDrgUa?=
 =?us-ascii?Q?blSTVUpkbLTxcSCwarEu2zlx5sE/mTiHiOkkbcUffJ9HCtBwOnQfwc1MN5mS?=
 =?us-ascii?Q?Jg4HnNRCDj1xetEa6rkcmX28JSTMksNgf7ian+JwuPjwD0xhGLmwm04ccKwv?=
 =?us-ascii?Q?YiJorCAZMRfbEzH0TwQCVln642gVxjuR3GDlDdDP1UjMlnQM7OOkAP57veC3?=
 =?us-ascii?Q?zORS/uOUno0Z2Etbs0zfwm4E9IDrQTc6ku1HZWlsHu0dteMamm5GyQuUXJ6s?=
 =?us-ascii?Q?55YfhS0PC4Locdarv7BMu89wRq7Xp+iRIgcvdN9cWfen81eXPVH6d7SRw3as?=
 =?us-ascii?Q?XPmf5EadVzFq86gXKWOYrBjVpR7YEMIjXuQSO8U/zfaCMTnk1AuODcGkKrMo?=
 =?us-ascii?Q?5pWupq/B//EovnbM1deRqsC4Dbkq+Cj3FxiNl+0mYzFHpYW2TtauTqLGGCho?=
 =?us-ascii?Q?Pz3VcO9H+HuwjTLwGBT3hFlKVCRp7e3FI3e4ibLOJ0gqh+JKVo4ejQhflil2?=
 =?us-ascii?Q?Iwa0LRkyfCy0RGc4Bal2RrIc3JzplkK7e4ZJ6kYz/GFny6UOsiJV4QKo6WZE?=
 =?us-ascii?Q?gOWbtp7jjM4fYDkLd/hoZNSgG0A3MrqbpeviJbxgCSTEVpXXLcf5RkCuHQhW?=
 =?us-ascii?Q?l4WDVzT50uUIk46K3Cmjk1XHmn981XwXFVQwtpPvrkDe41z61gpds6l33Tql?=
 =?us-ascii?Q?O3P8Yhlg0ZpZHhdvHjhN8r9n/y2PQs5hPODFcgboSVi9/GYpQON+S5DETuu8?=
 =?us-ascii?Q?f2mg8pr9Vf9rCmZwsvjuRvEK8rPz3b1YbqdUfzzLcmr3UumjW+GOkzP+nRXE?=
 =?us-ascii?Q?coiqIJcz9bSYW7Ua7MTvgLTagHZBhdqPE3yvD/Ltj36R7vGcsC5ylN5OX1pe?=
 =?us-ascii?Q?vy4AYSIt0dtjDN7zRwfQu9I+Vaule1/4ouGfDXXZAtteVOScaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:11:17.0638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2271516-a668-42cf-7be0-08dc8eb5d3ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
RLCG will mask xcd out and always assume it's accessing its own xcd

also fix the typo in sriov_w/rreg:
for KIQ case, use xcc with xcc_id to read and write

v2
amend some typos

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  2 ++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 63f2286858c4..d43652a38484 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1075,6 +1075,10 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
+	/* Select lower 16 bits to write in local xcc */
+	if ((hwip == GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
+		offset = NORMALIZE_XCC_REG_OFFSET(offset);
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
 		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
@@ -1084,7 +1088,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, value);
 	else
-		WREG32(offset, value);
+		WREG32_XCC(offset, value, xcc_id);
 }
 
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
@@ -1095,6 +1099,10 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
+	/* Select lower 16 bits to read in local xcc */
+	if ((hwip == GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
+		offset = NORMALIZE_XCC_REG_OFFSET(offset);
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);
@@ -1102,7 +1110,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
 	else
-		return RREG32(offset);
+		return RREG32_XCC(offset, xcc_id);
 }
 
 bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88b4644f8e96..5bb275b96e6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* Select lower 16 bits to write in local xcc */
+		if (AMDGPU_IS_GFXHUB(vmhub)) {
+			req = NORMALIZE_XCC_REG_OFFSET(req);
+			ack = NORMALIZE_XCC_REG_OFFSET(ack);
+		}
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..9ddf68e7d06e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,6 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
 	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
 
+#define NORMALIZE_XCC_REG_OFFSET(offset) (offset & 0xffff)
+
 #endif
-- 
2.34.1

