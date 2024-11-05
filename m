Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D9CD36109
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 19:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268D710E60D;
	Tue,  5 Nov 2024 19:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zYHQd0DD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A9510E60D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 19:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laIHLNMo1xXwX3tyvLVnBj4HzMSGNwVZn48hTGnlnwaTG8ecak0mgeZXvKZLzr4NIHkYxnvjX+KrC4qs0OC5xN9cK4mPapiKJq6L3caUgi3L5WMNdejqZzPSdM9dXiOPK6HglFOfzHNLnZPWYuhTpRoPdPMpx3P0xh7WrNz3C8UHp1DpSBuzZO+kmAH9kaxDaXPvo691yo9CLz9wBUWn9/wEX/gWKRrw+7yJ7zalRt16Ul8gxqPw54IKwZinIwlZJzFQ8OK7hPcOTvhoacfrD7R/e4jLZGsEgkNCun4b07lH1oA49kIA122ny5/RASGmLINLn43QqhH8nqMbG4cGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbziLfqSacxXgXWEObXK5AOVPozJ0K9C6rpz1kppJls=;
 b=lIlnrexXZPvI1SUnc6/+r7G1BQRP4fIYpX7j+061rNfmqj0hq28Q1IzckBiR8grGW2+KfDIuRtPH78pxLYRFTsxDNckYhhUqWJuWIyH6cruL/aiZ20dh2y83uH9ITkscNTaURgIYxggWIViyLSOTeKTV+wCbSx14AiMtzGM+omu+B2LO84JX0XcO2/rcsIw4mlyAQuEryMWWR8SXDtJ1Z9ct+ZcCa70D6gm2QPlMtO1gop2Rs2yPYVBvGWzVFXPxICtG0QdeYSrswbWR/4qXsAvoT910xUNBbu3Ig3lJFC/hcWy57hMYRu0M0/C/JJPcKGnNRQVFE8LoMa2TLoNZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbziLfqSacxXgXWEObXK5AOVPozJ0K9C6rpz1kppJls=;
 b=zYHQd0DD/+zS0sWIDz6FQyw2VzKL5+CbybxglSWQAvShNIbn2meU76ik+9H9Z4Q6lsRgyGRNQ1O8Fmy4WYemZalZp9VYKtX4z/0NOoHxIu/YC1sxlzWUyIoDzqF/yW3pS/B8mFuCVsbX9uKYThSpfOvtmvnC4DfoqE7NUnlhT+M=
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 19:04:50 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::3a) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 19:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 19:04:50 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 13:04:49 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <victor.skvortsov@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <zhigang.luo@amd.com>, <tao.zhou1@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: VF Query RAS Caps from Host if supported
Date: Tue, 5 Nov 2024 14:04:28 -0500
Message-ID: <20241105190429.323478-3-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105190429.323478-1-victor.skvortsov@amd.com>
References: <20241105190429.323478-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 140c8417-2820-49c0-09d0-08dcfdccb92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/gSOp3/U1bxphpN4DErYEliGSV9kSS/n5w6VaCiJFghyexhD6kXZq5ohgdF0?=
 =?us-ascii?Q?mcyoUeKNMqjwBu5BNFyzxgq10RYAMaEWLRGD5mEzM8jfNWQ5BoWIz4zrFBFy?=
 =?us-ascii?Q?pSJ3zdvm88jyqwLNCLxyC9ZL80TM7vPSaExwzWPikxLkjNKPvPyj2UXEI/GY?=
 =?us-ascii?Q?lZcRq6dxhBYFgqRxqsIVrgZUhCyXFgp2+jCl4CBQQMo7bSI74NIpPvZbavH+?=
 =?us-ascii?Q?UaeIIJ5lYrDjVfcucwggN5IDPt11YjPebC9NJKOEPbDfPmC4DACGxXpWeTXM?=
 =?us-ascii?Q?qkEMAVq18IPt9tP+Og1PKVNeXzkbGwPv9NnK4jIzwnxpP3Opt7L8XgzCrBP6?=
 =?us-ascii?Q?oUwYtlKOM8XqTVaII8Yh2H1NMwHthTHqabxhYO+7lnznzZACwDoyFGpe5HXk?=
 =?us-ascii?Q?uyB7wk+PgzESph4SNYWHyO7qAy7rj8E24Mberfw0H5p/8VjKVmnJXCjVpeC/?=
 =?us-ascii?Q?TDl7i7QELKZvU3z/+GYffJ6tPpKvLn2MW54IQwnZYLfqhQp3MBMx9AwTtTDG?=
 =?us-ascii?Q?AqXvpz66i4IrHTwJ3IJ1RAUeSMV3e9VQW65N6RUz5/bErSO5FBadBjs2rRDM?=
 =?us-ascii?Q?MLCXTk2wAkJ+AXjrh2pmB0jRmn+uFO2+PVcB/niY77k3QjYZfFLICeoaqKFW?=
 =?us-ascii?Q?m+mY3wP5YqJjFgc9oYOF/e9b8hu3svR/FG7jPA3WQrdq5HiHQVbMEgmi0vou?=
 =?us-ascii?Q?Ofl+2/RpG0wj1hvrNoDOelSHHfqyOiAz8OXkVQIxTZPyYhI/nhh+4MMfANiT?=
 =?us-ascii?Q?lZM1JUcmihS4r3SdS77YjXlvqZFk6ud+D2L7NqM//qbhbEIQ/2KsDMIJER7O?=
 =?us-ascii?Q?hB/+gVMKizVLVngb8PWLaAJeXXp8j5Ezmj1r80DYxauyrSt1d0SgYi5hOqG5?=
 =?us-ascii?Q?w+5sM6V6JjK8NcULUJj7zbovvPFxXyO4ER78gvYBuobYexfywm06YXWEZh93?=
 =?us-ascii?Q?D+XF2/8aLes9IMhPWTZbAogGK6uw+4jzaFFrkWAazEsmbnAFN9/vNTg1F51m?=
 =?us-ascii?Q?6Db0RSD/ztUCpCgTP9dq37so38Awgi/rMz4ojLibS+CqJNgfp50oVC7q38Gi?=
 =?us-ascii?Q?S6RqOY/QPJt86FWvTyiCLtENx6HGsk2qBLwPXKhzu0yh4R8v7ggR8qWwahBK?=
 =?us-ascii?Q?4FKHhi3imw1UXFHLQA/gbn/ysz/GxPrJ1rXOqitQih2GNbg3n5Sg1OYMnWqC?=
 =?us-ascii?Q?THVJDKr2I/4fbzsXLAYm6uXg0UhnjMQarz01Agl44gPb4QTlGdKU+rlFWtY6?=
 =?us-ascii?Q?J+LRatsuyk2oUvtlY2AlnfIm6IptdGaVx80mwZc7p766N5eXxM+Rv6nLcVUY?=
 =?us-ascii?Q?j6WQ04jI0o6BaVv0DBviTm7Wm2BTB0vi244sclUiNJk7wYZJYWDI3Z0tZAGH?=
 =?us-ascii?Q?NMCunVZ2AFW8752QQlyhMQa+eIGaMHx7SfEaUnM5o0kZnN4BZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:04:50.0682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140c8417-2820-49c0-09d0-08dcfdccb92a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
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

If VF RAS Capability support is enabled, guest is able to
retrieve the real RAS support from the host.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 53 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  7 ++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1d9eda883bb8..89d87dc17ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3452,6 +3452,11 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	if (!amdgpu_ras_asic_supported(adev))
 		return;
 
+	if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_virt_get_ras_capability(adev))
+			goto init_ras_enabled_flag;
+	}
+
 	/* query ras capability from psp */
 	if (amdgpu_psp_get_ras_capability(&adev->psp))
 		goto init_ras_enabled_flag;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b6397d3229e1..53297c40f09c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -523,6 +523,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 
 		adev->unique_id =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
+		adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
 		break;
 	default:
 		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
@@ -1144,3 +1145,55 @@ bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev)
 
 	return xnack_mode;
 }
+
+bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!amdgpu_sriov_ras_caps_en(adev))
+		return false;
+
+	if (adev->virt.ras_en_caps.bits.block_umc)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__UMC);
+	if (adev->virt.ras_en_caps.bits.block_sdma)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__SDMA);
+	if (adev->virt.ras_en_caps.bits.block_gfx)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__GFX);
+	if (adev->virt.ras_en_caps.bits.block_mmhub)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MMHUB);
+	if (adev->virt.ras_en_caps.bits.block_athub)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__ATHUB);
+	if (adev->virt.ras_en_caps.bits.block_pcie_bif)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__PCIE_BIF);
+	if (adev->virt.ras_en_caps.bits.block_hdp)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__HDP);
+	if (adev->virt.ras_en_caps.bits.block_xgmi_wafl)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__XGMI_WAFL);
+	if (adev->virt.ras_en_caps.bits.block_df)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__DF);
+	if (adev->virt.ras_en_caps.bits.block_smn)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__SMN);
+	if (adev->virt.ras_en_caps.bits.block_sem)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__SEM);
+	if (adev->virt.ras_en_caps.bits.block_mp0)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MP0);
+	if (adev->virt.ras_en_caps.bits.block_mp1)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MP1);
+	if (adev->virt.ras_en_caps.bits.block_fuse)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__FUSE);
+	if (adev->virt.ras_en_caps.bits.block_mca)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MCA);
+	if (adev->virt.ras_en_caps.bits.block_vcn)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__VCN);
+	if (adev->virt.ras_en_caps.bits.block_jpeg)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__JPEG);
+	if (adev->virt.ras_en_caps.bits.block_ih)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__IH);
+	if (adev->virt.ras_en_caps.bits.block_mpio)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MPIO);
+
+	if (adev->virt.ras_en_caps.bits.poison_propogation_mode)
+		con->poison_supported = true; /* Poison is handled by host */
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f6eee57338df..f0ff84add692 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -137,6 +137,7 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_VCN_RB_DECOUPLE = (1 << 7),
 	/* MES info */
 	AMDGIM_FEATURE_MES_INFO_ENABLE = (1 << 8),
+	AMDGIM_FEATURE_RAS_CAPS = (1 << 9),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -277,6 +278,8 @@ struct amdgpu_virt {
 	uint32_t autoload_ucode_id;
 
 	struct mutex rlcg_reg_lock;
+
+	union amd_sriov_ras_caps ras_en_caps;
 };
 
 struct amdgpu_video_codec_info;
@@ -321,6 +324,9 @@ struct amdgpu_video_codec_info;
 #define amdgpu_sriov_vf_mmio_access_protection(adev) \
 ((adev)->virt.caps & AMDGPU_VF_MMIO_ACCESS_PROTECT)
 
+#define amdgpu_sriov_ras_caps_en(adev) \
+((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_CAPS)
+
 static inline bool is_virtual_machine(void)
 {
 #if defined(CONFIG_X86)
@@ -384,4 +390,5 @@ bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 					  u32 acc_flags, u32 hwip,
 					  bool write, u32 *rlcg_flag);
 u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id);
+bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

