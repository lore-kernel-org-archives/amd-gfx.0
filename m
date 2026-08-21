Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC53C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D6D10F384;
	Fri, 21 Aug 2026 16:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OFf6tMnh";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6472A10F384
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM5s+BvV/KzKOEDM/PN/3iJA1bxml5jH3tIiaVv6lRp7H8AiUzXyOsHHZf96x/QjKDWwYE48EH+GGjjvXRzKNmEvMuZXvytZyBLa7gUuM2fDDzh/BzEPZwzRc+VHk8PYCmsS4Sk5kgGkascb8gVXEHHmjayMrwmJVNFbDJeHLhissZ9EefgRYQ7KAqazqqqt5lWcdZw82OouWLq66EKHeQVma5n9rMEgYFvnlnu7/A58b0DDAJeMPJ94HyUkHBrr0j9Em1zDhUC4vAwHcNC0tb7ASgWaUhovKb6ujKrUtY96Be9GwSwFuAF1V/eyTuM5oOITeKZnaMzM+slDJBfFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEe4OcS9UJkTzkbxn9PvH5bUmznRRiXFVdBCBTy1k6I=;
 b=cD8U27x406DowMW53FUHxr12yuZwXpdMr+dIsn289Rmu2d4u7wkLy/FSzxTtlNNF7Z3dnYvcHg12o/jK8EwSPWuykCohaENb6uNmBT6Xb5wWRya3ZPujUkX+7YLQ8605aOkaBoMHmnNviO2W1m83Rx3BdzvfLjP/1r3OfOs0WdtY7AIVh47WVboL7lCxj1b3RWl6cIL7z9DKUQWPKe/G8+xUwWI72ahnBTJT05NhRkxNq0bpx+umWLcPb2aOP4629wonjzJ/aXoExq0s7Z+EanUDMYOGNS7EFebpBameFQy3mJRan9r/lLXP+78KV5VQkmwHWrwiq3Z0vfhN3SNq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEe4OcS9UJkTzkbxn9PvH5bUmznRRiXFVdBCBTy1k6I=;
 b=OFf6tMnhNMG7LMtyTdw8lOa1kO9diRXfiKplf5HSeUiKY1lLuXKZnp9PiPNyQob/xOIRIJV41MsMzQI6yTL5gUUZcUi6f7FUU4+Em1SZx0wM1MCu4ffsT4fSeSUoSipCEHHikyQzHL1qFtjABBO5wmSzycPpXOJl7D3O64NtLmY=
Received: from MN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:52f::10)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:15:14 +0000
Received: from BN5PEPF0004698E.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::33) by MN0PR03CA0004.outlook.office365.com
 (2603:10b6:208:52f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698E.mail.protection.outlook.com (10.167.245.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:15:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Horatio Zhang <hongkun.zhang@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/14] drm/amdgpu: Init soc_v1_0 rev_id from IP discovery
 die_id
Date: Fri, 21 Aug 2026 12:14:01 -0400
Message-ID: <20260821161401.754042-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698E:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dae5f7-b6c3-4837-4fe6-08deff9f6208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0Pzko8FWoXQwDvuvmkKMNCxb3CWK2f4Mb3/CaBS/4V1ORp8oo9ZdQHVCaWcVKoyGph/FX32LtGdQ3vTOY8AA09mEA3G3CxpF2AQ2CQjkLDOBGb9vLSxRcuZTIslmTcMXu2hzKQYvmg26teCcMjwhkR9SAViBvfCoUarz4mMWs/Ef+5uxwjiAmXUCukFfj45NLsbrr2dAisqIjHOHNlWaExGeLmOrxoIq5xxa5HIRCrXXWCr1KetKc6+eppp4ZCt2PqeoskBR+acbEJ98UwzT9ELFoOv5BtnKWsgrCvIskgL6B6XUVEbj86rkjZD54QG7ThVHl9IZl8MrLtI0rPSM4QJymiptZsfnMCVpD/iQvLWEvg6Wq5kS+QNe7cjtLsegZqcOirghJdyLrHhk0vN9h+ke8APkB0pFJJMbIpY1svaJXWRkKgvW5Rn1BYoqFOuclnbpBAGLJ0ZyQEzqQxE/0wp5/FtNV99GOAdD9YDLOmqt0CGoZZzJHecLwTTN5yQobSAWNOXaAuNlNQZUeJJMtJigLhpadOBG8iKh3xcG32VTejWq6giXpC+vLPhAGmr+xHzEODsWedi2/T3isLyfJnYCbRML02SRBKZf76yC+srIkIGKR+h3CY0SJbWaEaf3/sucDlzpLyg8zFBdRPdZLT/ruv6sSiYWc8H9OSAvp5EU0Tbe2RShUkJY4t3+yFgyqMIjp5/ZmA+qiSl+kCKWHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bmE/8K5KoRX1hcV7sXs+yRPaSvuG4zVcqk9Yp4b1+FaUc2/uxdXmRzJxMVHazXLfkKLaRqmy4afJMPpJNUHqlOz3YPvBiEpIx72MlzFtseqUXD+Wm5jMwjourB/JyCg/86k7HsjFsjaxo4UjIWzhgyGIlCGwLtD2cmmo5t6RDn6iGc2+FXP5zfO2ik+nnKHELwtsSYEgJ3RnyTZLTKjjMhYsqQekkwJ9Y8hvODCXN3+f75wMTGd7xQF/MYK925qrhHBMkLJWo0m/G9MNGOEAIGbsPbUcE8mlM+x2QlZOQ32Rnqwq/NWIzc6oytNsjpWHgMzCkGVjq1yjG488pIElUvfifa6EWYxd7nqBXm9czNAkM/pYOjBfiBvXq4Q5ZccJ4S7JFoDMW1KhvnRjFLiA5/1HSd05EByMCmnfyvt1I7UEwnsgXss6VSckfcdKarqr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:15:13.7100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dae5f7-b6c3-4837-4fe6-08deff9f6208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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

From: Horatio Zhang <hongkun.zhang@amd.com>

Software components need to detect die revisions in order to apply the
correct software workarounds. During system boot, ASP firmware reads
the IDCODE values from the MID, AID and XCD fuses and encodes the die
revision into die_info[0].die_id in the IP discovery blob.

v2: Default die_rev_id to 0 and warn instead of failing probe when IP
discovery does not provide a die rev id.
v3: Update names for external_rev_id enumerators.

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 +
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 74 ++++++++++++++++++-
 3 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 92033b67771c3..81c3cdba4caf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -4038,3 +4038,27 @@ int amdgpu_discovery_get_gc_major_minor_version(struct amdgpu_device *adev,
 		*minor = le16_to_cpu(gc_info->v1.header.version_minor);
 	return 0;
 }
+
+int amdgpu_discovery_get_die_rev_id(struct amdgpu_device *adev,
+				    uint16_t *die_rev_id)
+{
+	uint8_t *discovery_bin = adev->discovery.bin;
+	struct ip_discovery_header *ihdr;
+	struct table_info *info;
+	u16 offset;
+
+	if (!discovery_bin)
+		return -EINVAL;
+	if (amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY))
+		return -EINVAL;
+
+	offset = le16_to_cpu(info->offset);
+	if (!offset)
+		return -EINVAL;
+
+	ihdr = (struct ip_discovery_header *)(discovery_bin + offset);
+
+	if (die_rev_id)
+		*die_rev_id = le16_to_cpu(ihdr->die_info[0].die_id);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 997ba1717e744..6e1d55e78790a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -53,6 +53,8 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  int *range_cnt, bool refresh);
 int amdgpu_discovery_get_gc_major_minor_version(struct amdgpu_device *adev,
 						uint16_t *major, uint16_t *minor);
+int amdgpu_discovery_get_die_rev_id(struct amdgpu_device *adev,
+				    uint16_t *die_rev_id);
 
 void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 41d7300fd5ccd..fb3c7cb350995 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -49,6 +49,23 @@
 #define NORMALIZE_MID_REG_OFFSET(offset) \
 		(offset & 0x3FFFF)
 
+/*
+ * die_info[0].die_id from IP discovery encodes the silicon revision:
+ *   bit[15:12] Reserved
+ *   bit[11:8] MID revision
+ *   bit[7:4]  AID revision
+ *   bit[3:0]  XCD revision
+ * The value is copied into adev->rev_id[15:0] (rev_id[31:16] are 0) and mapped
+ * to adev->external_rev_id below.
+ */
+#define SOC_V1_0_DIE_REV_XCD__SHIFT 0
+#define SOC_V1_0_DIE_REV_AID__SHIFT 4
+#define SOC_V1_0_DIE_REV_MID__SHIFT 8
+#define SOC_V1_0_DIE_REV(mid, aid, xcd)           \
+	(((mid) << SOC_V1_0_DIE_REV_MID__SHIFT) | \
+	 ((aid) << SOC_V1_0_DIE_REV_AID__SHIFT) | \
+	 ((xcd) << SOC_V1_0_DIE_REV_XCD__SHIFT))
+
 static const struct amdgpu_video_codecs vcn_5_0_2_video_codecs_encode_vcn0 = {
 	.codec_count = 0,
 	.codec_array = NULL,
@@ -326,9 +343,60 @@ static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
 	.get_fw_reserved_info = &soc_v1_0_get_fw_reserved_info,
 };
 
+enum soc_v1_0_external_rev_id {
+	SOC_V1_0_MID_A0_AID_A0_XCD_A0 = 0x1,
+	SOC_V1_0_MID_A0_AID_A0_XCD_B0 = 0x2,
+	SOC_V1_0_MID_A0_AID_A1_XCD_A0 = 0x3,
+	SOC_V1_0_MID_A0_AID_A1_XCD_B0 = 0x4,
+};
+
+static int soc_v1_0_set_rev_id(struct amdgpu_device *adev)
+{
+	u16 die_rev_id = 0, xcd_rev_id;
+	int r;
+
+	xcd_rev_id = amdgpu_device_get_rev_id(adev);
+	r = amdgpu_discovery_get_die_rev_id(adev, &die_rev_id);
+	if (r) {
+		die_rev_id = 0;
+		dev_warn(adev->dev,
+			"missing die rev id from ip discovery, assuming 0\n");
+	}
+
+	/*
+	 * FIXME: XCD revision is not yet populated in die_info[0].die_id by
+	 * ASP firmware. Use the PCI revision ID register as a temporary
+	 * fallback until firmware support is available.
+	 */
+	die_rev_id |= xcd_rev_id << SOC_V1_0_DIE_REV_XCD__SHIFT;
+	adev->rev_id = die_rev_id;
+
+	/* SOC_V1_0_DIE_REV(mid_rev, aid_rev, xcd_rev) */
+	switch (die_rev_id) {
+	case SOC_V1_0_DIE_REV(0, 0, 0):
+		adev->external_rev_id = SOC_V1_0_MID_A0_AID_A0_XCD_A0;
+		break;
+	case SOC_V1_0_DIE_REV(0, 0, 1):
+		adev->external_rev_id = SOC_V1_0_MID_A0_AID_A0_XCD_B0;
+		break;
+	case SOC_V1_0_DIE_REV(0, 1, 0):
+		adev->external_rev_id = SOC_V1_0_MID_A0_AID_A1_XCD_A0;
+		break;
+	case SOC_V1_0_DIE_REV(0, 1, 1):
+		adev->external_rev_id = SOC_V1_0_MID_A0_AID_A1_XCD_B0;
+		break;
+	default:
+		dev_warn(adev->dev, "unknown die rev id 0x%x\n", die_rev_id);
+		break;
+	}
+
+	return 0;
+}
+
 static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
 	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
 	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
@@ -343,14 +411,14 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 
 	adev->asic_funcs = &soc_v1_0_asic_funcs;
 
-	adev->rev_id = amdgpu_device_get_rev_id(adev);
-	adev->external_rev_id = 0xff;
+	r = soc_v1_0_set_rev_id(adev);
+	if (r)
+		return r;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
 		adev->cg_flags = 0;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
-		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.55.0

