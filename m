Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F87C5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E24110F722;
	Fri, 14 Aug 2026 21:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PG9JxY3m";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D1A10F718
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7YKGmyFq25Hvd3TPQRVqRUNiTlVK2cvggn9WFhaA1peUggOEPvzoBEnvkBsccmQrTYaw5OJ68xs9kyfOUiGfAy+m3R9obJBPDqENy2UPZmm/wxRRU+d1o4D2wkmfY5b/zdeYpu0FwQtPs4QkNSlowiph2n88terFgzPZX2vFoFhEvS9/y7jgumP0FO4zZU3ej94douauqJfrkcWZgZJM0ZFb01VD+QBJ5oOvTMUOY8KIMXBXKB2/GwHi/s6ge9U9yCBgs0Q4fJsDSlmWBtZ3T5/g1LSDKe1dFgyTPve9AQDyYLCMuTLJQCxzMqbreJT66ETgeH3OFO/DjPQm5vpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEBWaUUr5/b4EDk5qczgqcSMPnHjDvqGKe5OvCglA5k=;
 b=P8m//cDn7atCIQpqNNhDI7X5RzB4BEiBqmYvJr9xOieDxmwHPgUKvWT7nDIt1AYrq77BHicSoYj4x/39cNzva2NxOO0IwtOUxnrcnWz5FAfdo1dFXRKofT8ndIvd3VhVzXejOO06q/CqbmC7GmkIUISpOpVltuYdbDHVe+0dAruL1uHjWW52ML7bKafjCaMFvMmtVduICYrbuh6q3jJwAXI/cqiBmQMSaRR59RmCI5AjRaUsLE2gHDZ+35W8QEmlN8Nw8oQqMQq8SOrzZ2Fp2rNUP8HbZLfAqZqR9UxWO7WxlGlcyIXiZtvFK3cE59cScfCzJ+yO3+ugwmtQwZgYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEBWaUUr5/b4EDk5qczgqcSMPnHjDvqGKe5OvCglA5k=;
 b=PG9JxY3mnYqh5xH2rWcrxoawCmSoQrEdPOQYmfYwLQcp9+dbylFI6d9wK4/2klmdHmwbEA8tNbykcFul9HTVtYHXzDD39jdtGQIPYUxCTaWEMDkx1Ok5JLjEPfttp5XspsZWZXF1FpgKAY6MLA2PQtB/lAbyvZz/4oiKonjc6ko=
Received: from DS1PR07CA0019.namprd07.prod.outlook.com (2603:10b6:8:44d::10)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:43 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::62) by DS1PR07CA0019.outlook.office365.com
 (2603:10b6:8:44d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiahao Li <Jiahao.Li@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 069/109] drm/amdgpu: add new interface in guest driver for
 getting RAS capability when uniras enabled
Date: Fri, 14 Aug 2026 17:02:06 -0400
Message-ID: <20260814210246.3067612-70-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 31850c02-88c5-4dc5-7c56-08defa478654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5N+Iwlryq00wSUTzjlo3i6NBLqHY3UA7NyyXxN2ttm2+5ZOlgfXx+OyNJOgvvzF1Tqj1tTPurmKFBzxQWeakWdydmJfy+3Sv/5kqGvTSfVzbG47/O6UdidIvjWX2qs7a2smdsyf6I0p7Gbsr75i5lJNf6ycyOt3zkm9c4/Cs8k9orAEB60xyjWjWodnMMO98rJLFhBqjEz5ubXNyhGcECcgp63BBz4JonzK1DcsfRXk4M/pj0rNqmgA+hukkWx7ck6//KeBQWrmi923xbKaVdWTEss3v27hAx/6bOpr656OlWVT3WbLg9A/IsSjGWLDlu1ek5gf008W6+njARLiF5J5yDO7LXlNCRFtRjWXhjP10bm6ZezVfeXCnlLIQm0/z/7/aC1vZS9CA95XzhwSffu8WtOFKYWGAQmDXWJvF8cYWVOpeELb+GG/vv/oJWSi73vPwhRDUmtQTicPjHR3xKAm9QcJVmMetR9ProzGufqzBgq1YncxeDGyXI8riAF4kvwtshZZWBuo3GMNaizs8Vvl2+WT4pbuwrvXlWefzFeveeUcDvEZNk7U7ooR9NkGUTdMmOSdSUzVfgBokN9klKH1RJZfDVPJo+Az9lTFAaa/4ocYyaJbAiV5dXETvVft/tY84e+P4YuDrjkhQNqPaucUb+0+upbnIIcZFmnZhjOoWwY/TzqAsQQg1CWFMhGgfgR+GDE26C6iFji2nuBXVDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IEnS8JqJ4mfr/pci42AeDVEBQO7gH77v4DQdLX0Nip2cOd5j8q6qso7WZomDak8/bkflViPOE4+iFtyk1kCG+vM8vs74V2PncoqtJlw5FuDu4/RAixpGtkbSPOMu/SK15UBLCThwN+mrEJCq6b+nE/Yp6DauAwyCrsu6tUvDuwcGt7YR0hXR8rK8pFRB5A9xwehYnmJqvdNkZhXJhvR73GQ3V2l7oG5xk81PcXMSV98njgntwE4JjY6AR1Fo82cS+FsRdoalluwuMpOnzBHzCjRDA/Kako4s1zKTcCQUfYHfs0K4Y89obbCRIZrKHaakH1MtH50TZ+MCqjA70j0CViA6lk8FHIb73hytxtdQSTRyEQMamvcIidz/1jL1B2OTFO52M9FNLL91vlJTXqtnF2ixomvIfzcNRoljkpN7twuOOnzhvw6/LqyhWV1uQgM0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:43.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31850c02-88c5-4dc5-7c56-08defa478654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
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

From: Jiahao Li <Jiahao.Li@amd.com>

- Adding a new interface in guest driver to parse the pf2vf message and
  return RAS capability to the caller when uniras is enabled

- Update RAS capability fields in amdgv_sriovmsg.h for uniras

Signed-off-by: Jiahao Li <Jiahao.Li@amd.com>
Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 39 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 27 ++++++++++++--
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b43fc643668d2..73169cb775f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -339,6 +339,41 @@ static int amdgpu_virt_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_virt_get_uniras_ras_caps(struct amdgpu_device *adev,
+				    struct amd_sriov_uniras_caps *caps)
+{
+	struct amd_sriov_msg_pf2vf_info *pf2vf_msg;
+
+	if (!adev || !caps)
+		return -EINVAL;
+
+	if (!adev->virt.fw_reserve.p_pf2vf)
+		return -EINVAL;
+
+	if (adev->virt.fw_reserve.p_pf2vf->version != AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER)
+		return -EINVAL;
+
+	pf2vf_msg = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
+
+	if (pf2vf_msg->header.size > (AMD_SRIOV_MSG_SIZE_KB << 10) ||
+	    pf2vf_msg->header.size <
+	    offsetof(struct amd_sriov_msg_pf2vf_info, pf2vf_ras_caps) +
+	    sizeof(pf2vf_msg->pf2vf_ras_caps))
+		return -EINVAL;
+
+	if (!pf2vf_msg->feature_flags.flags.uniras_support)
+		return -EOPNOTSUPP;
+
+	*caps = pf2vf_msg->pf2vf_ras_caps.uniras_caps;
+
+	dev_dbg(adev->dev,
+		"uniras caps: ras_ext_ecc_type=0x%x ras_int_ecc_attributes=0x%x ras_en_block_mask=0x%llx\n",
+		caps->ras_ext_ecc_type, caps->ras_int_ecc_attributes,
+		caps->ras_en_block_mask);
+
+	return 0;
+}
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
@@ -614,9 +649,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		if (amdgpu_sriov_is_unitid_support(adev))
 			adev->unitid = pf2vf->unitid;
 
-		adev->virt.ras_en_caps.all = pf2vf->ras_en_caps.all;
+		adev->virt.ras_en_caps.all = pf2vf->pf2vf_ras_caps.ras_en_caps.all;
 		adev->virt.ras_telemetry_en_caps.all =
-			pf2vf->ras_telemetry_en_caps.all;
+			pf2vf->pf2vf_ras_caps.ras_telemetry_en_caps.all;
 		break;
 	default:
 		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index bcf7156a4a9e0..9957241bdf592 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -506,6 +506,8 @@ bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 					  u32 acc_flags, u32 hwip,
 					  bool write, u32 *rlcg_flag);
 u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id);
+int amdgpu_virt_get_uniras_ras_caps(struct amdgpu_device *adev,
+				    struct amd_sriov_uniras_caps *caps);
 bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);
 int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_block block,
 				  struct ras_err_data *err_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 8cd26ba55e6c6..5a253d50faa76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -164,7 +164,8 @@ union amd_sriov_msg_feature_flags {
 		uint32_t xgmi_connected_to_cpu  : 1;
 		uint32_t ptl_support		: 1;
 		uint32_t unitid_support		: 1;
-		uint32_t reserved		: 16;
+		uint32_t uniras_support		: 1;
+		uint32_t reserved		: 15;
 	} flags;
 	uint32_t all;
 };
@@ -210,6 +211,27 @@ union amd_sriov_ras_caps {
 	uint64_t all;
 };
 
+struct amd_sriov_uniras_caps {
+	uint32_t ras_ext_ecc_type;
+	uint32_t ras_int_ecc_attributes;
+	uint64_t ras_en_block_mask;
+};
+
+/*
+ * PF2VF RAS capability words (16 bytes, layout matches legacy fields):
+ * ras_ext_ecc_type and ras_int_ecc_attributes are aliases ras_en_caps,
+ * ras_en_block_mask aliases ras_telemetry_en_caps.
+ */
+union amd_sriov_msg_pf2vf_ras_caps {
+	/* ras caps for uniras enabled case */
+	struct amd_sriov_uniras_caps uniras_caps;
+	/* ras caps for uniras disabled case*/
+	struct {
+		union amd_sriov_ras_caps ras_en_caps;
+		union amd_sriov_ras_caps ras_telemetry_en_caps;
+	};
+};
+
 union amd_sriov_msg_os_info {
 	struct {
 		uint32_t windows  : 1;
@@ -314,8 +336,7 @@ struct amd_sriov_msg_pf2vf_info {
 	/* vf bdf on host pci tree for debug only */
 	uint32_t bdf_on_host;
 	uint32_t more_bp;	//Reserved for future use.
-	union amd_sriov_ras_caps ras_en_caps;
-	union amd_sriov_ras_caps ras_telemetry_en_caps;
+	union amd_sriov_msg_pf2vf_ras_caps pf2vf_ras_caps;
 	/* PTL status response for guest */
 	uint32_t ptl_enabled;        // PTL enable status: 0=disabled, 1=enabled
 	uint32_t ptl_pref_format1;   // Current preferred format 1
-- 
2.55.0

