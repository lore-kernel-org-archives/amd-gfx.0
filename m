Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3882C2BA18
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 03:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291C710E922;
	Fri, 21 Jun 2024 03:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YMb8+zSw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250B110E922
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 03:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjUsSuoYDZ8ia1MKR7sOBC10AlIAJMTkG7dClbC1R0ZbOg1AKt9DyO0qsvLU3hkeW8O7mQZXr8hE0e9e0WcQkHeMt3a8N3L1ukf04M7lnhY+lnfjvZ+QqxexO9UBHthERmaHH3EtihD+7k+m+3BJWwoLus90ZtFRaZffvqcPBZSRCgV52mzZ51zvi6y+K5SMD+MB9cidutqKtNK40TgDAqtzHYKayWUJDV19CpXwXqa22d8RAX2TTTjfSlCVj7SKcQqJt+j2K1VqQkTbHtRObPKZMXemjnfGA8vFdZxqVkvcsCd7RQluy+fKcrxnn2/amw2FSg+iYnvPDFwQ5nEjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+aR0QdqRZF2j566bsoEqWkJcNV0s88nbo6QptphP+Q=;
 b=cGCG2WAAwb4p1prwix33MjqQ4aLQqGme2SSu9y4vO2p8ToNIXP0+NK+qH3OFPaE1WFFPDtBx0cedMeXEWc9ia4G73p6xeNiZBtVOpn0b8n67VkF1q1lG8JOQe9853wzfUweZ62L3Cax4FIQ+KRoJRbwESsYANJabHKLvNkNKRf8l2JTIBOuJ3jogmijCxKggqpfeMsikKmzBc7unUH1E9JqtIgpnGeVNiJOH//aAD5+DkA77V2/PWIuvVVACax0uMj6WLsJStVesxougl0F7RFTnvCdM5vveZyRIs/WU+0fx3Hyno7R82zofOFoFiBUpDh75LDBZM03KPDNWfXw4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+aR0QdqRZF2j566bsoEqWkJcNV0s88nbo6QptphP+Q=;
 b=YMb8+zSwahAx8TDUYLlo4VPu2Kj8ZQUpmBqwuo0Qy6dzrQ1eJ/VHOgWWbvpTsBs/tAzlFC7IMTUgVY0CKQ6+mTwSJLnmSxwuh4eihOHJyloQJoQrmeE52XzpsRg/3Mq1/UcSTWeAewJyFuuvIwqUAz5hy3DZ203FWAkGWolhl1k=
Received: from CH5PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:1ed::17)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 03:39:51 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::85) by CH5PR02CA0001.outlook.office365.com
 (2603:10b6:610:1ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Fri, 21 Jun 2024 03:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 03:39:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 22:39:50 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 22:39:49 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Alexander.Deucher@amd.com>, <Haijun.Chang@amd.com>, 
 <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write
 under sriov in TLB flush
Date: Fri, 21 Jun 2024 11:39:48 +0800
Message-ID: <20240621033948.1738395-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5438c7-8afc-4c2e-2200-08dc91a3cee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|1800799021|82310400023|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hXa6yFlra6q/6h0zmr44vJYTHwHqSEwxm6OGIPBc1s84WwNo7QVwaNsp+sb9?=
 =?us-ascii?Q?pLeccISYCRDxepW9wyhR9crqFEJrkz+mmHJ8xk1VAeYnirD40QxCABcOhebL?=
 =?us-ascii?Q?q3qcMty+RjEmPq8izGoQrqA5k2x7KZaERDRtKbXVJY9n5SOm3aIy4LEvknml?=
 =?us-ascii?Q?RCRBEDpMB3FQqrgAOBG28gFf8XQphPWRGU8mkRRWpw35vDu8rnrEPvRpr8Sy?=
 =?us-ascii?Q?yIXPAtFGVF7s6fU09V7NdyGJA1F4lktk6IDq48iJD6NYJz6Sz7+zMi8EInE3?=
 =?us-ascii?Q?8o6dOUDxJkAkmIYvQx6xZ5JZ6sah18Ra1A1mKqEynOI85wUIJME7S0B4mZe0?=
 =?us-ascii?Q?9hsrUjTOGFlsf7e5eBTIOq3mo3evriBEMvJJZLBep5EbRRglRM0kM4L8tK6l?=
 =?us-ascii?Q?26Wp6dnlFyisiUO8Ofh07TQkCGF+3IcqtIbBK+b0oxu/sEybRra/jR076bN1?=
 =?us-ascii?Q?ANeDDbCPL+zM2VjCGe9r9/Ek0B3xN6VaRm3Eac6GjBcd9sIPzfrPaIGQcEeB?=
 =?us-ascii?Q?0OD5WkxFmvvQZf03/YGfDVcPVblQ2+T+GG8fwgDyuTljzBkDlkFpPPeRGB2M?=
 =?us-ascii?Q?67vDBH2oEjCTr06uR5bZMENDZF9NpW3/wT2mb2wR0YQrHSt9BhsQ6fmUEKc4?=
 =?us-ascii?Q?1JZ62MW5rY915tUbLHBx5xy1bO+O6yhc9UwVo2fP4hYc2rZHX7k/mdLcTdb2?=
 =?us-ascii?Q?75umcc6p+JAIU2WcZaCMabIkEWAsFPBYV9b3zi3efeukfDqaz/oRD5+hJCDr?=
 =?us-ascii?Q?hf20n5QxZdFFegXKiI+ZmkpVxuZX2HEzsGwm87QwOlV48Rv17lQE+CDt0hmw?=
 =?us-ascii?Q?JslcAFsuONemLu5ttsmw2S282FrYBRp+m2+PctuUJPls/cRqLauLEfdOV9Wo?=
 =?us-ascii?Q?g9C6Qk2T/djqIa0+ZGgejpIWyctvkR42JM1FK5e8fvlIPL/lJN56jm6HhHtm?=
 =?us-ascii?Q?EsSFgodnQXTJXgg2hBCcsZei1Mp0JezdhUJDUabHHAlkJ/xdvzkL5KcWStQ+?=
 =?us-ascii?Q?LB1/AQIPtbUNzeolkBsOlGygdYSZNL8jQFOlvtZZrim3YgS10RiuslMRGpa6?=
 =?us-ascii?Q?mtzBgJj0DQupsfkWCmxFv90x/xCODRpa0lUjrT3AKQaiHsvqrQ7Q5W3dzAeQ?=
 =?us-ascii?Q?7YgQx7y9Eyrvs55t7zkNctXAfOMVJeYUeLu867DaLmcVHNDwDb3Vk5lUxmmQ?=
 =?us-ascii?Q?mYv0cUtZA8GvGszez/biTNErIkDOwGK0JcOIycziVJWVBy6KswSEATc4n6zM?=
 =?us-ascii?Q?GUDErIxrZnCKmOgDs4/iC5BsnGYlFA3LZbafBWsZRpKxpmsY+Q0qCE6ZYMAm?=
 =?us-ascii?Q?PdpmI+xqnQGEGu7oOlKY92DDwbXFII4L9ShaWiA9S1N9LwGclSdVoJfcaMbA?=
 =?us-ascii?Q?Ve6mmd14BWnC4krSS5Y5vxy2mTwmHgamUIZOzYYnZhpdwlhKuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 03:39:51.5322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5438c7-8afc-4c2e-2200-08dc91a3cee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
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

[TODO]
later will add the normalization in sriovw/rreg after fixing bugs

v2
rename the normalized macro, add ip block type for further use
move asics func declaration after ip block type since new func
refers ip block type

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 112 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  16 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/soc15.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |   5 +-
 6 files changed, 85 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 083f353cff6e..070fd9e601fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -583,61 +583,6 @@ struct amdgpu_video_codecs {
 	const struct amdgpu_video_codec_info *codec_array;
 };
 
-/*
- * ASIC specific functions.
- */
-struct amdgpu_asic_funcs {
-	bool (*read_disabled_bios)(struct amdgpu_device *adev);
-	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
-				   u8 *bios, u32 length_bytes);
-	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
-			     u32 sh_num, u32 reg_offset, u32 *value);
-	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
-	int (*reset)(struct amdgpu_device *adev);
-	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
-	/* get the reference clock */
-	u32 (*get_xclk)(struct amdgpu_device *adev);
-	/* MM block clocks */
-	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
-	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
-	/* static power management */
-	int (*get_pcie_lanes)(struct amdgpu_device *adev);
-	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
-	/* get config memsize register */
-	u32 (*get_config_memsize)(struct amdgpu_device *adev);
-	/* flush hdp write queue */
-	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
-	/* invalidate hdp read cache */
-	void (*invalidate_hdp)(struct amdgpu_device *adev,
-			       struct amdgpu_ring *ring);
-	/* check if the asic needs a full reset of if soft reset will work */
-	bool (*need_full_reset)(struct amdgpu_device *adev);
-	/* initialize doorbell layout for specific asic*/
-	void (*init_doorbell_index)(struct amdgpu_device *adev);
-	/* PCIe bandwidth usage */
-	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
-			       uint64_t *count1);
-	/* do we need to reset the asic at init time (e.g., kexec) */
-	bool (*need_reset_on_init)(struct amdgpu_device *adev);
-	/* PCIe replay counter */
-	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
-	/* device supports BACO */
-	int (*supports_baco)(struct amdgpu_device *adev);
-	/* pre asic_init quirks */
-	void (*pre_asic_init)(struct amdgpu_device *adev);
-	/* enter/exit umd stable pstate */
-	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
-	/* query video codecs */
-	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
-				  const struct amdgpu_video_codecs **codecs);
-	/* encode "> 32bits" smn addressing */
-	u64 (*encode_ext_smn_addressing)(int ext_id);
-
-	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
-				 enum amdgpu_reg_state reg_state, void *buf,
-				 size_t max_size);
-};
-
 /*
  * IOCTL.
  */
@@ -728,6 +673,63 @@ enum amd_hw_ip_block_type {
 	MAX_HWIP
 };
 
+/*
+ * ASIC specific functions.
+ */
+struct amdgpu_asic_funcs {
+	bool (*read_disabled_bios)(struct amdgpu_device *adev);
+	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
+				   u8 *bios, u32 length_bytes);
+	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
+			     u32 sh_num, u32 reg_offset, u32 *value);
+	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
+	int (*reset)(struct amdgpu_device *adev);
+	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
+	/* get the reference clock */
+	u32 (*get_xclk)(struct amdgpu_device *adev);
+	/* MM block clocks */
+	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
+	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
+	/* static power management */
+	int (*get_pcie_lanes)(struct amdgpu_device *adev);
+	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
+	/* get config memsize register */
+	u32 (*get_config_memsize)(struct amdgpu_device *adev);
+	/* flush hdp write queue */
+	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
+	/* invalidate hdp read cache */
+	void (*invalidate_hdp)(struct amdgpu_device *adev,
+			       struct amdgpu_ring *ring);
+	/* check if the asic needs a full reset of if soft reset will work */
+	bool (*need_full_reset)(struct amdgpu_device *adev);
+	/* initialize doorbell layout for specific asic*/
+	void (*init_doorbell_index)(struct amdgpu_device *adev);
+	/* PCIe bandwidth usage */
+	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
+			       uint64_t *count1);
+	/* do we need to reset the asic at init time (e.g., kexec) */
+	bool (*need_reset_on_init)(struct amdgpu_device *adev);
+	/* PCIe replay counter */
+	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
+	/* device supports BACO */
+	int (*supports_baco)(struct amdgpu_device *adev);
+	/* pre asic_init quirks */
+	void (*pre_asic_init)(struct amdgpu_device *adev);
+	/* enter/exit umd stable pstate */
+	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
+	/* query video codecs */
+	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs);
+	/* encode "> 32bits" smn addressing */
+	u64 (*encode_ext_smn_addressing)(int ext_id);
+
+	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
+				 enum amdgpu_reg_state reg_state, void *buf,
+				 size_t max_size);
+	/* normalize offset to keep in lower 16-bit */
+	u32 (*normalize_reg_offset)(enum amd_hw_ip_block_type hwip, u32 offset);
+};
+
 #define HWIP_MAX_INSTANCE	44
 
 #define HW_ID_MAX		300
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 2c9a0aa41e2d..98b00c0e522f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -1085,3 +1085,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 
 	return size;
 }
+
+u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type hwip, u32 offset)
+{
+	u32 normalized_offset;
+
+	switch (hwip) {
+	case GC_HWIP:
+		normalized_offset = offset & 0xffff;
+		break;
+	default:
+		normalized_offset = offset;
+		break;
+	}
+
+	return normalized_offset;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88b4644f8e96..66fd229c196a 100644
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
+			req = NORMALIZE_XCC_REG_OFFSET(GC, req);
+			ack = NORMALIZE_XCC_REG_OFFSET(GC, ack);
+		}
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8d16dacdc172..e6e61fc77080 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
+	.normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 282584a48be0..f1e974604e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
+u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..ddf0aad51821 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,7 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
 	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
 
-#endif
+#define NORMALIZE_XCC_REG_OFFSET(ip, offset) \
+	((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
+	adev->asic_funcs->normalize_reg_offset(ip##_HWIP, offset) : offset)
+#endif
\ No newline at end of file
-- 
2.34.1

