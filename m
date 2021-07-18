Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81C2C636CB
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8983661182
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8983661182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B30989DFB;
	Sun, 18 Jul 2021 14:06:32 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6314689DE3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhoVg6icE8jRd3qhA5SGiO5QsLELrWDwgGZmnzmL62GCgPDG6x2qZfhgF/E00Fr6KhnDsVwtcIYvzkoTAG8z2jTGCrkMLTQneDGL7qrUP7iRtqKIu7NLA3jRnx3RbONO3/rylYffpUPnqHGVnpr8V1x/Me07NC+MTcJdXrzUwKAJ+zANFkVaUU9PKDMC3Rhqox6qtJbp+im/2A1kWk1cp5n0i/T4YbAm9LS46z+eP7pGygBLbM7BwaHmtvBNyy8o0yZ2RPoY/OUllG1RHrvpvE5Eg90ZuYR43jL8UmcPMR7t30quJ8gYg2xX8DWUH8fcdGNdpgvZeXKc1RfGhwvJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlUQki5Tsg3jg1hWEvgsWhezK2zwYUje3EYGbrDNFLM=;
 b=Z1j62brHsnEPxccJSJCizXNRSIC+FKpC12VDve9nFDvztAExpjP12dOT44u5E/D3VTK1mjCqtCS+jgiUw39Qg7JIeq8JBJUlOUApykTdpltxODeVCAIoch2QOUMwPBtLVtC5FTjniKxwoyShxPIyk7UuQ5paCb7RH+R8sNKw4ycvff6+0DW6MyyK4b9R39/W4IEhyM2GfDKKnXD/MeLoPhjrJ6bMK12wP1lYjH8tHh7dSYvtoj+jTGooN9b5y1+XI8XkPbnRQtfZ00YzpVudD34X1kfuahRNayI6k4lVVnw6Y/DrB4F6IXhUwFJ+9TAvHIlf9vrdYCabfPNYtz6adg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlUQki5Tsg3jg1hWEvgsWhezK2zwYUje3EYGbrDNFLM=;
 b=MeQRz2Mn+Bqs1eNFsA7XLzSW4FPmk0eTDcOdtPWwebI4ylpM3w9YnLCOWl1XyB3di8fi8TZDxttA6y1nTgL/1M2ijPXJdOJqWmuJ0MlKFTjHWkjZkeKXteOaHkF6eJXOd+sRqpJmp9W/4zRdFcnocJ1XhwAkpKUpjRUiqGlPyZc=
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.31; Sun, 18 Jul
 2021 14:06:29 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::52) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:28 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/32] drm/amd/display: implement workaround for riommu
 related hang
Date: Sun, 18 Jul 2021 10:05:44 -0400
Message-ID: <20210718140610.1584616-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f83a34f4-e2b9-44a5-4672-08d949f53cf0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5322:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5322B6E783AE57D392FCD44198E09@BN9PR12MB5322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUKd6b2CGpSkDFfQVpaqh6Rd4hqPbt0el+sTR75DQxbSjWQZXFaRisKQ/gDdW+d4poMOlKmiex76FYjtbHvX7rVQ6/0r0noLx4vqU8FWSYEcWxeaRFIJP7YUrBMjDv1dj/Wm5OD14QmoI6oNnPJGFbs6fN49QgC8NAACzjFXrBpdKRNQYz6IC4lquWxZfXVJav92++BNg4Tz8lVbNimLKDB1WFPxHAmo3rcHe/b0r1jnAaoS6ULSun4rITbAduBLSgVdj3FW8FMaOvD7/YgnZfdpnYy6rDFHTkl1Upemv4iPWsVyHsfbSH9Ot8AhFdHuunYQJ9IEJjaP6OQymWIEM+PG8w3d3hoxKenBESWEWdbSmcquGJF9hgkZ1Vtc7wGDv92SX/PRfw2WEWdpbK6zteyvn5+mf9GiCuXRIMc8BJN/TlbVcHV3e2Lgk3fcQ7XO0lDpqqqkNj1h1jGZOK8CE6tRParR+symvFN+RExpilwDyP0bLDCN6Mhmg79jCIjgBmiS/jWtGZ580DPY7lrMYG3yWpI2Job4Epqv2Go0Qj/BQurUfteVEAdq8OEq85mslNrXVMI1a5gw2OQKrOsubOvzOoB3QKjshrdFpk7eONxd4ityQ9qqz9rinI8PPyLANE7ryR47Cst4UJqbvKnwpIwprnBy5KzdVfSuhzQ9jztYpZFqUse/Tx+uyL9SMp6/hVORKqaWv3BAD3M2kKzuCAbcZp0HKuShiW3tzLBuoq8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(70586007)(83380400001)(70206006)(6916009)(508600001)(26005)(16526019)(186003)(8936002)(6666004)(2906002)(336012)(5660300002)(54906003)(316002)(426003)(2616005)(1076003)(82310400003)(4326008)(47076005)(86362001)(8676002)(36860700001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:28.6121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83a34f4-e2b9-44a5-4672-08d949f53cf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
During S4/S5/reboot, sometimes riommu invalidation request arrive too
early, DCN may be unable to respond to the invalidation request
resulting in pstate hang.

[How]
VBIOS will force allow pstate for riommu invalidation and driver will
clear it after powering down display pipes.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h |  4 +++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 18 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h |  1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c  |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c  |  3 +++
 .../amd/display/dc/inc/hw_sequencer_private.h  |  1 +
 6 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index df6539e4c730..0464a8f3db3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -636,6 +636,7 @@ struct dce_hwseq_registers {
 	uint32_t ODM_MEM_PWR_CTRL3;
 	uint32_t DMU_MEM_PWR_CNTL;
 	uint32_t MMHUBBUB_MEM_PWR_CNTL;
+	uint32_t DCHUBBUB_ARB_HOSTVM_CNTL;
 };
  /* set field name */
 #define HWS_SF(blk_name, reg_name, field_name, post_fix)\
@@ -1110,7 +1111,8 @@ struct dce_hwseq_registers {
 	type DOMAIN_POWER_FORCEON;\
 	type DOMAIN_POWER_GATE;\
 	type DOMAIN_PGFSM_PWR_STATUS;\
-	type HPO_HDMISTREAMCLK_G_GATE_DIS;
+	type HPO_HDMISTREAMCLK_G_GATE_DIS;\
+	type DISABLE_HOSTVM_FORCE_ALLOW_PSTATE;
 
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 836864a5a5dc..6ac6faf0c533 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -47,6 +47,7 @@
 #include "dce/dmub_outbox.h"
 #include "dc_link_dp.h"
 #include "inc/link_dpcd.h"
+#include "dcn10/dcn10_hw_sequencer.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -594,3 +595,20 @@ bool dcn31_is_abm_supported(struct dc *dc,
 	}
 	return false;
 }
+
+static void apply_riommu_invalidation_wa(struct dc *dc)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+
+	if (!hws->wa.early_riommu_invalidation)
+		return;
+
+	REG_UPDATE(DCHUBBUB_ARB_HOSTVM_CNTL, DISABLE_HOSTVM_FORCE_ALLOW_PSTATE, 0);
+}
+
+void dcn31_init_pipes(struct dc *dc, struct dc_state *context)
+{
+	dcn10_init_pipes(dc, context);
+	apply_riommu_invalidation_wa(dc);
+
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
index ff72f0fdd5be..40dfebe78fdd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
@@ -52,5 +52,6 @@ void dcn31_reset_hw_ctx_wrap(
 		struct dc_state *context);
 bool dcn31_is_abm_supported(struct dc *dc,
 		struct dc_state *context, struct dc_stream_state *stream);
+void dcn31_init_pipes(struct dc *dc, struct dc_state *context);
 
 #endif /* __DC_HWSS_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index e3048f8827d2..de74f62f96cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -104,7 +104,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
-	.init_pipes = dcn10_init_pipes,
+	.init_pipes = dcn31_init_pipes,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index c67bc9544f5d..3fe0aac4aaa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -741,6 +741,7 @@ static const struct dccg_mask dccg_mask = {
 
 #define HWSEQ_DCN31_REG_LIST()\
 	SR(DCHUBBUB_GLOBAL_TIMER_CNTL), \
+	SR(DCHUBBUB_ARB_HOSTVM_CNTL), \
 	SR(DIO_MEM_PWR_CTRL), \
 	SR(ODM_MEM_PWR_CTRL3), \
 	SR(DMU_MEM_PWR_CNTL), \
@@ -801,6 +802,7 @@ static const struct dce_hwseq_registers hwseq_reg = {
 #define HWSEQ_DCN31_MASK_SH_LIST(mask_sh)\
 	HWSEQ_DCN_MASK_SH_LIST(mask_sh), \
 	HWS_SF(, DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, mask_sh), \
+	HWS_SF(, DCHUBBUB_ARB_HOSTVM_CNTL, DISABLE_HOSTVM_FORCE_ALLOW_PSTATE, mask_sh), \
 	HWS_SF(, DOMAIN0_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
 	HWS_SF(, DOMAIN0_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
 	HWS_SF(, DOMAIN1_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
@@ -1299,6 +1301,7 @@ static struct dce_hwseq *dcn31_hwseq_create(
 		hws->regs = &hwseq_reg;
 		hws->shifts = &hwseq_shift;
 		hws->masks = &hwseq_mask;
+		hws->wa.early_riommu_invalidation = true;
 	}
 	return hws;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index f7f7e4fff0c2..082549f75978 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -41,6 +41,7 @@ struct dce_hwseq_wa {
 	bool DEGVIDCN10_254;
 	bool DEGVIDCN21;
 	bool disallow_self_refresh_during_multi_plane_transition;
+	bool early_riommu_invalidation;
 };
 
 struct hwseq_wa_state {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
