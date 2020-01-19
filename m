Return-Path: <SRS0=dEFY=3I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98B9C32771
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 02:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB85C2469D
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 02:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hKqhrDkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB85C2469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8931F6E1B6;
	Sun, 19 Jan 2020 02:46:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE086E1B6
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2020 02:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foTRdN5YbtayZGjoS95x+VFXdkwNJxE6Xj4xdule2Xhf2jHJsQxuPfZUkQpAAO1XnYsAMvK2jfK/Wid+R0oK9LNUXr/+JwPGBF0PfGmXkdSvEsfVwZckfIfXJSEUdFvBjEYmfRrHvUrkTLOwvxxyif+jpv4SI/zl8h3o9KVKowkTh4kbuPqbmkOs93Gto+FAICvqDOm+U+l2/99H7bgEiYXsCVis/oVse/bIcM23LDdznigML+15wRdfb5MJxUd7n8KIs8S0bfgZRrVyBdGIC1x2416G+Itpn4LnLBrc0C/Ttcglf/iKeUNN66O+ycNbV7WLpsryPhl9UiZu6g6T5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fjnIoDFSbPZCLE54mXR31gmfGCVkQFVOM2mSbiSmaI=;
 b=FXLnUjX8kZuoDqZt//QggVdSI2kc64JaFFzbTkEuBlId8VHWFrBdG5QMR87HhWPH6GXxpdmRdCwAPY62csvl+UgJ6tnwUVBc6skmHa1iHzUARMvHHa4vmlz3xtG4Ij8X6gkM1K9icy88J/CdStSnIFvXQrHwlHbxqu6o5f14obJ1urGIhrgqWEEtLxvlApK7dEbmRV45QrUV3A8xfmwngsTCIrfV5F8qAoWq8CT3pVmH9qMaSFHwd3LhxVOo9YBPcrEoKWI5cTa5t2f0tCWZckcO4zrls5IT7+6CnYf3F6Ss0fVP9f6DWFJUOAg5yzgeX7Sr8ce3HUhxXyruYI1EPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fjnIoDFSbPZCLE54mXR31gmfGCVkQFVOM2mSbiSmaI=;
 b=hKqhrDkQZ38Xg7M9GODIB/ZYiKL4bQriyfqHJXIhv2FJ8H4FIvYhOx4gsMxNMb9pUqPamoe9sj9VG8grqkYpcLry0FJWCnJvs7WkTmw7/rtn87AU/BUC4tXpoP4mUHFjTqXtFSNxqJprITtk9jfzjULR+NgBt76P+zsVBs4Ik74=
Received: from DM3PR12CA0098.namprd12.prod.outlook.com (2603:10b6:0:55::18) by
 BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:25::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Sun, 19 Jan 2020 02:46:18 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by DM3PR12CA0098.outlook.office365.com
 (2603:10b6:0:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Sun, 19 Jan 2020 02:46:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Sun, 19 Jan 2020 02:46:18 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 18 Jan
 2020 20:46:17 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 18 Jan 2020 20:46:15 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: abstract EDC counter clear to a separated
 function
Date: Sun, 19 Jan 2020 10:46:00 +0800
Message-ID: <20200119024602.23079-3-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119024602.23079-1-Dennis.Li@amd.com>
References: <20200119024602.23079-1-Dennis.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39850400004)(376002)(428003)(189003)(199004)(316002)(1076003)(2906002)(86362001)(70206006)(70586007)(81166006)(36756003)(6666004)(4326008)(5660300002)(8676002)(356004)(336012)(8936002)(186003)(478600001)(110136005)(7696005)(81156014)(6636002)(2616005)(426003)(26005)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2593; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 211abb55-1e04-4418-f17c-08d79c89c254
X-MS-TrafficTypeDiagnostic: BN7PR12MB2593:
X-Microsoft-Antispam-PRVS: <BN7PR12MB25936F34ACFFC961F1131A68ED330@BN7PR12MB2593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0287BBA78D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu+kqE46pY/UgUIFrl/hsTV53BeaTP/2GTn2Ro5kU/gotapQERcimHwxnMRTWlmqhbT5ZmKEakYUlP7yZXqGP74QrmVmTgHCt7xX8xHVkUnjqTZ3Ow85Ok+AIqolz9m0Vop9aW/nBI0PeN/xoOeMT0iqsnmP5pU2+dlegi20O5bqpTBSkrb+orFiyyEDn/6g+/pNQryLyX+Th75EfgujIniLjwL+667D07YTt/SNXqlYV5xamQ2UHC3iyanGDisAQzG7idSBopa8om+gONogTUaN+poyhUnACJJjAohCQtb+pLzcXUmhmod2JvXmNpop6CWdo5kBcbqeCJW1sHTqQRk/NySiLiXJJobQFkixXoV6bJI72JPJfoCDKeokydy0ClT23dnSLNVWe7Sx8MMoQRB+66hzSBkKGlFjSjaiA7vXRWo61wv3in1TWcBCResZtcWslGdNwdG75iIXngeU7vJ4mShrDxCJtGzALikT4WI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 02:46:18.0603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211abb55-1e04-4418-f17c-08d79c89c254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2593
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Add IP prefix for the IP related codes.
2. Refactor the code to clear EDC counter.

Change-Id: I1cd9ec304a7ace9a74480264d24368fd11a87833
Signed-off-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 112 ++++++++++++++++++--------
 1 file changed, 77 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 759d8144f9c0..35b5ca7a9272 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -736,6 +736,7 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
+static void gfx_v9_0_clear_ras_edc_counter(struct amdgpu_device *adev);
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if);
 
@@ -3996,7 +3997,7 @@ static const struct soc15_reg_entry sgpr2_init_regs[] = {
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x0000ff00 },
 };
 
-static const struct soc15_reg_entry sec_ded_counter_registers[] = {
+static const struct soc15_reg_entry gfx_v9_0_edc_counter_regs[] = {
    { SOC15_REG_ENTRY(GC, 0, mmCPC_EDC_SCRATCH_CNT), 0, 1, 1},
    { SOC15_REG_ENTRY(GC, 0, mmCPC_EDC_UCODE_CNT), 0, 1, 1},
    { SOC15_REG_ENTRY(GC, 0, mmCPF_EDC_ROQ_CNT), 0, 1, 1},
@@ -4085,7 +4086,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
 	struct amdgpu_ib ib;
 	struct dma_fence *f = NULL;
-	int r, i, j, k;
+	int r, i;
 	unsigned total_size, vgpr_offset, sgpr_offset;
 	u64 gpu_addr;
 
@@ -4231,18 +4232,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 		goto fail;
 	}
 
-	/* read back registers to clear the counters */
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < ARRAY_SIZE(sec_ded_counter_registers); i++) {
-		for (j = 0; j < sec_ded_counter_registers[i].se_num; j++) {
-			for (k = 0; k < sec_ded_counter_registers[i].instance; k++) {
-				gfx_v9_0_select_se_sh(adev, j, 0x0, k);
-				RREG32(SOC15_REG_ENTRY_OFFSET(sec_ded_counter_registers[i]));
-			}
-		}
-	}
-	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xe0000000);
-	mutex_unlock(&adev->grbm_idx_mutex);
+	gfx_v9_0_clear_ras_edc_counter(adev);
 
 fail:
 	amdgpu_ib_free(adev, &ib, NULL);
@@ -5519,7 +5509,7 @@ static int gfx_v9_0_priv_inst_irq(struct amdgpu_device *adev,
 }
 
 
-static const struct soc15_ras_field_entry gc_ras_fields_vg20[] = {
+static const struct soc15_ras_field_entry gfx_v9_0_ras_fields[] = {
 	{ "CPC_SCRATCH", SOC15_REG_ENTRY(GC, 0, mmCPC_EDC_SCRATCH_CNT),
 	  SOC15_REG_FIELD(CPC_EDC_SCRATCH_CNT, SEC_COUNT),
 	  SOC15_REG_FIELD(CPC_EDC_SCRATCH_CNT, DED_COUNT)
@@ -6092,7 +6082,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_CNT, 0);
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < ARRAY_SIZE(vml2_mems); i++) {
 		WREG32_SOC15(GC, 0, mmVM_L2_MEM_ECC_INDEX, i);
 		data = RREG32_SOC15(GC, 0, mmVM_L2_MEM_ECC_CNT);
 
@@ -6111,7 +6101,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 		}
 	}
 
-	for (i = 0; i < 7; i++) {
+	for (i = 0; i < ARRAY_SIZE(vml2_walker_mems); i++) {
 		WREG32_SOC15(GC, 0, mmVM_L2_WALKER_MEM_ECC_INDEX, i);
 		data = RREG32_SOC15(GC, 0, mmVM_L2_WALKER_MEM_ECC_CNT);
 
@@ -6132,7 +6122,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 		}
 	}
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < ARRAY_SIZE(atc_l2_cache_2m_mems); i++) {
 		WREG32_SOC15(GC, 0, mmATC_L2_CACHE_2M_EDC_INDEX, i);
 		data = RREG32_SOC15(GC, 0, mmATC_L2_CACHE_2M_EDC_CNT);
 
@@ -6144,7 +6134,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 		}
 	}
 
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < ARRAY_SIZE(atc_l2_cache_4k_mems); i++) {
 		WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, i);
 		data = RREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_CNT);
 
@@ -6171,36 +6161,36 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int __get_ras_error_count(const struct soc15_reg_entry *reg,
+static int gfx_v9_0_ras_error_count(const struct soc15_reg_entry *reg,
 	uint32_t se_id, uint32_t inst_id, uint32_t value,
 	uint32_t *sec_count, uint32_t *ded_count)
 {
 	uint32_t i;
 	uint32_t sec_cnt, ded_cnt;
 
-	for (i = 0; i < ARRAY_SIZE(gc_ras_fields_vg20); i++) {
-		if(gc_ras_fields_vg20[i].reg_offset != reg->reg_offset ||
-			gc_ras_fields_vg20[i].seg != reg->seg ||
-			gc_ras_fields_vg20[i].inst != reg->inst)
+	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_ras_fields); i++) {
+		if(gfx_v9_0_ras_fields[i].reg_offset != reg->reg_offset ||
+			gfx_v9_0_ras_fields[i].seg != reg->seg ||
+			gfx_v9_0_ras_fields[i].inst != reg->inst)
 			continue;
 
 		sec_cnt = (value &
-				gc_ras_fields_vg20[i].sec_count_mask) >>
-				gc_ras_fields_vg20[i].sec_count_shift;
+				gfx_v9_0_ras_fields[i].sec_count_mask) >>
+				gfx_v9_0_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
 			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
-				gc_ras_fields_vg20[i].name,
+				gfx_v9_0_ras_fields[i].name,
 				se_id, inst_id,
 				sec_cnt);
 			*sec_count += sec_cnt;
 		}
 
 		ded_cnt = (value &
-				gc_ras_fields_vg20[i].ded_count_mask) >>
-				gc_ras_fields_vg20[i].ded_count_shift;
+				gfx_v9_0_ras_fields[i].ded_count_mask) >>
+				gfx_v9_0_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
 			DRM_INFO("GFX SubBlock %s, Instance[%d][%d], DED %d\n",
-				gc_ras_fields_vg20[i].name,
+				gfx_v9_0_ras_fields[i].name,
 				se_id, inst_id,
 				ded_cnt);
 			*ded_count += ded_cnt;
@@ -6210,6 +6200,58 @@ static int __get_ras_error_count(const struct soc15_reg_entry *reg,
 	return 0;
 }
 
+static void gfx_v9_0_clear_ras_edc_counter(struct amdgpu_device *adev)
+{
+	int i, j, k;
+
+	/* read back registers to clear the counters */
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
+		for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
+			for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
+				gfx_v9_0_select_se_sh(adev, j, 0x0, k);
+				RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
+			}
+		}
+	}
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xe0000000);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	WREG32_SOC15(GC, 0, mmVM_L2_MEM_ECC_INDEX, 255);
+	WREG32_SOC15(GC, 0, mmVM_L2_MEM_ECC_CNT, 0);
+	WREG32_SOC15(GC, 0, mmVM_L2_WALKER_MEM_ECC_INDEX, 255);
+	WREG32_SOC15(GC, 0, mmVM_L2_WALKER_MEM_ECC_CNT, 0);
+	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_2M_EDC_INDEX, 255);
+	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_2M_EDC_CNT, 0);
+	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);
+	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_CNT, 0);
+
+	for (i = 0; i < ARRAY_SIZE(vml2_mems); i++) {
+		WREG32_SOC15(GC, 0, mmVM_L2_MEM_ECC_INDEX, i);
+		RREG32_SOC15(GC, 0, mmVM_L2_MEM_ECC_CNT);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(vml2_walker_mems); i++) {
+		WREG32_SOC15(GC, 0, mmVM_L2_WALKER_MEM_ECC_INDEX, i);
+		RREG32_SOC15(GC, 0, mmVM_L2_WALKER_MEM_ECC_CNT);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(atc_l2_cache_2m_mems); i++) {
+		WREG32_SOC15(GC, 0, mmATC_L2_CACHE_2M_EDC_INDEX, i);
+		RREG32_SOC15(GC, 0, mmATC_L2_CACHE_2M_EDC_CNT);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(atc_l2_cache_4k_mems); i++) {
+		WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, i);
+		RREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_CNT);
+	}
+
+	WREG32_SOC15(GC, 0, mmVM_L2_MEM_ECC_INDEX, 255);
+	WREG32_SOC15(GC, 0, mmVM_L2_WALKER_MEM_ECC_INDEX, 255);
+	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_2M_EDC_INDEX, 255);
+	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);
+}
+
 static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status)
 {
@@ -6226,14 +6268,14 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	for (i = 0; i < ARRAY_SIZE(sec_ded_counter_registers); i++) {
-		for (j = 0; j < sec_ded_counter_registers[i].se_num; j++) {
-			for (k = 0; k < sec_ded_counter_registers[i].instance; k++) {
+	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
+		for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
+			for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
 				gfx_v9_0_select_se_sh(adev, j, 0, k);
 				reg_value =
-					RREG32(SOC15_REG_ENTRY_OFFSET(sec_ded_counter_registers[i]));
+					RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
 				if (reg_value)
-					__get_ras_error_count(&sec_ded_counter_registers[i],
+					gfx_v9_0_ras_error_count(&gfx_v9_0_edc_counter_regs[i],
 							j, k, reg_value,
 							&sec_count, &ded_count);
 			}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
