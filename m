Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D672AC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 07:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8CE20705
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 07:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BWF0Q3Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8CE20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FDE6E9C4;
	Fri, 27 Mar 2020 07:57:25 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690045.outbound.protection.outlook.com [40.107.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 060E76E9C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 07:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD8dvx0K0a1VqJncy6s5NRaiWcGA8xWzAkOr7/frgVWMPLmzYURZinO4E6IEET0m4StatjwAJ+/hWuXhYGwu7pENz40xbbGwyLzh2AbORhbWAFa1RAdUXuY71UG7fzzJ+lreVHsBlmurHEHcZ6iQFpnDZrhFkV1NvAFUM7czutdmnhl8C+875eudzXp2PUevpG0RlbNpVes/Xb42VDmhKk46QxMSED7ofA4ymsVit7bX1v3+krpGoX2eH/yhGyGA0WwepNdGp2fuZBAEXohTjDr5De4JO37vOeZlyuKmshRgWP8u65OY+BikZmXCkoq0PhqGKiCyGw0ojejwz+CYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4U7Dg25oiIoIYNDLVkhtxXh4kF78ZmDBfNl7PJBH38=;
 b=Lyo3iR96nlP/QujVE7JDTjU0fNLYI+CkobNjG40nWK4qj0LnYuA85dDtRN+T5aCw40cznTxUr155k+gjqWJqhMOa2zufeIsxX+cfLllKtLxQRI4nbk7KkTsu/X+iMrRti93RygjfpNAeQ+3BsxXwFWP2TnEC9aMPGVUwbyrw/HXQW0SE9HHfTtofM6dECSlWncJFvHor32iqsB/kUCPNdS/8ai73GCsSqWB7PbElie2Vnt3mPIqfnUFDCGhB70Y20LkcVYdgmoa9Yln975WJG/t7UFGU7fJMpq3aefhqrN2wSSqedO9H4SmIwbgjh/nr33EhnXhrA3wfZ0kuPp8hiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4U7Dg25oiIoIYNDLVkhtxXh4kF78ZmDBfNl7PJBH38=;
 b=BWF0Q3Z0iHxbNGstQ7zybMVKrEb1pe1E6L4elQL1aVUewJVDQAeIaqa5rLt5zIXU8cJYFc/Rgu2Hb0faCfjfJ/FIn8Xj7wMd+6DAGNv3JIDo+YYuj7GDpenJJloUPL6PkaEWIl0B0Td2wLD2PvLZwFCwCrQLaBZq7rCU7Zv3BL0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 07:57:23 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 07:57:23 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: move the ASIC specific nbio operation
 out of smu_v11_0.c
Date: Fri, 27 Mar 2020 15:57:01 +0800
Message-Id: <20200327075701.17821-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327075701.17821-1-evan.quan@amd.com>
References: <20200327075701.17821-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 07:57:21 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53c868c2-c024-4d97-0d90-08d7d2247b73
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:|MN2PR12MB4270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4270BCB463225F8B96DE3BD4E4CC0@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(316002)(66946007)(2906002)(66476007)(5660300002)(44832011)(478600001)(2616005)(956004)(52116002)(6486002)(7696005)(186003)(86362001)(1076003)(36756003)(8676002)(66556008)(81166006)(81156014)(8936002)(6916009)(4326008)(26005)(16526019)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4270;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kjm3D+70GeZAQz6CFx9tulck1GSqkOhimSICDz1bZ/YfhZQSgpnr+O+qdx/SwbPytJwv0YOjHVMKwhGiRNw+jWxzlmTorLMxcsXVBUfOpiSzSJlVzZYL80hS7gP8yHAjZKWVa2DlsOCmcc4b2ITcr993JYcJP3Riug4IY8uEqq+frV4iw5j4GyCnZPDq6s1RGel1NelEUD3AL5Bq20H2MNz34dhA+ReDmLqHMWvdv4DdYWD9VSfckr/ucvFxWQdQnS8hR2/TBGJMbv53h942Ytyrl8Mev5Yb37KGkpAoAo6UMTeDIAC8EjXh7eS3wyXHuzJEP/+E/kcP5KNRjKxZrg608RADEvLhjlXyaWZUAg7auLzB7bbPRY7j/XUZQsWFYGWL3j+NFAk/dI73TXCK3t6tluL945m4cwqqqtqvBS7CUx8gKpqYftQ1MTc+ywWK
X-MS-Exchange-AntiSpam-MessageData: kJVLwm1YUdzS3fB4p+8z+dXEZgPiEobC5EpeILWzYyx8TBPteubMmkRedpbeMvIoqts1D0MfXbIGBuQjPZQWqjB/xiPbJWeQSZFrqYB87Nm3kRlS/jxYLd6hrkwFlXrIcdYt3jHCZBjx7yFfnu9VSA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c868c2-c024-4d97-0d90-08d7d2247b73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 07:57:23.0876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lg4GmbVNBwC2HP5T3cfgo5iAvTgrPkEetBFW/PjlWSt57JePhN6L5ZiZoEIzE5Ir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is ASIC specific and should be placed in _ppt.c of each ASIC.

Change-Id: If2b29ccf0dfc0dc90e1636a806b13ce2efed58c6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c    | 10 +---------
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c   | 14 +++++++++++++-
 4 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index c6d3bef15320..5db8c56066ee 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -35,6 +35,7 @@
 #include "arcturus_ppt.h"
 #include "smu_v11_0_pptable.h"
 #include "arcturus_ppsmc.h"
+#include "nbio/nbio_7_4_offset.h"
 #include "nbio/nbio_7_4_sh_mask.h"
 #include "amdgpu_xgmi.h"
 #include <linux/i2c.h>
@@ -2210,6 +2211,18 @@ static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 	i2c_del_adapter(control);
 }
 
+static bool arcturus_is_baco_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t val;
+
+	if (!smu_v11_0_baco_is_support(smu))
+		return false;
+
+	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
+	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
+}
+
 static uint32_t arcturus_get_pptable_power_limit(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -2321,7 +2334,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support= smu_v11_0_baco_is_support,
+	.baco_is_support= arcturus_is_baco_supported,
 	.baco_get_state = smu_v11_0_baco_get_state,
 	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 1112e4c5f4d7..c94270f7c198 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -28,13 +28,15 @@
 #include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
+#include "soc15_common.h"
 #include "smu_v11_0.h"
 #include "smu11_driver_if_navi10.h"
 #include "atom.h"
 #include "navi10_ppt.h"
 #include "smu_v11_0_pptable.h"
 #include "smu_v11_0_ppsmc.h"
-#include "nbio/nbio_7_4_sh_mask.h"
+#include "nbio/nbio_2_3_offset.h"
+#include "nbio/nbio_2_3_sh_mask.h"
 
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
 
@@ -1942,6 +1944,18 @@ static int navi10_setup_od_limits(struct smu_context *smu) {
 	return 0;
 }
 
+static bool navi10_is_baco_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t val;
+
+	if (!smu_v11_0_baco_is_support(smu))
+		return false;
+
+	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
+	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
+}
+
 static int navi10_set_default_od_settings(struct smu_context *smu, bool initialize) {
 	OverDriveTable_t *od_table, *boot_od_table;
 	int ret = 0;
@@ -2318,7 +2332,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support= smu_v11_0_baco_is_support,
+	.baco_is_support= navi10_is_baco_supported,
 	.baco_get_state = smu_v11_0_baco_get_state,
 	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 31b93cff19d5..655ba4fb05dc 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -42,8 +42,6 @@
 #include "asic_reg/thm/thm_11_0_2_sh_mask.h"
 #include "asic_reg/mp/mp_11_0_offset.h"
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
-#include "asic_reg/nbio/nbio_7_4_offset.h"
-#include "asic_reg/nbio/nbio_7_4_sh_mask.h"
 #include "asic_reg/smuio/smuio_11_0_0_offset.h"
 #include "asic_reg/smuio/smuio_11_0_0_sh_mask.h"
 
@@ -1662,9 +1660,7 @@ static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v
 
 bool smu_v11_0_baco_is_support(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	uint32_t val;
 	bool baco_support;
 
 	mutex_lock(&smu_baco->mutex);
@@ -1679,11 +1675,7 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
 	   !smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
 		return false;
 
-	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
-	if (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
-		return true;
-
-	return false;
+	return true;
 }
 
 enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 49ff3756bd9f..3f1044326dcb 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -35,6 +35,7 @@
 #include "vega20_ppt.h"
 #include "vega20_pptable.h"
 #include "vega20_ppsmc.h"
+#include "nbio/nbio_7_4_offset.h"
 #include "nbio/nbio_7_4_sh_mask.h"
 #include "asic_reg/thm/thm_11_0_2_offset.h"
 #include "asic_reg/thm/thm_11_0_2_sh_mask.h"
@@ -3174,6 +3175,17 @@ static int vega20_update_pcie_parameters(struct smu_context *smu,
 	return ret;
 }
 
+static bool vega20_is_baco_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t val;
+
+	if (!smu_v11_0_baco_is_support(smu))
+		return false;
+
+	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
+	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
+}
 
 static const struct pptable_funcs vega20_ppt_funcs = {
 	.tables_init = vega20_tables_init,
@@ -3262,7 +3274,7 @@ static const struct pptable_funcs vega20_ppt_funcs = {
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support= smu_v11_0_baco_is_support,
+	.baco_is_support= vega20_is_baco_supported,
 	.baco_get_state = smu_v11_0_baco_get_state,
 	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
