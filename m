Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F06C11F68
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 14:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56A061433
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 14:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56A061433
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E2B6E9E3;
	Wed, 30 Jun 2021 14:07:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F056E9E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 14:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym6B66fZ300CNSSNYTzjHYF46ODdOIN5cN4lI9dNYm+nvarxqVhwzfYh+LnE8jWAscrgrH2n29pUbse30nEQxPP5nQlBY0QVehSMcBe3U2dKSQ8eo0Zl35wb59dbGKDZTYyjIqR7V9Y2umwNt+49dYn8ilLHjPGYadU1j5vwN1v3YZ9nJIlBrnw4w7z4oJmHXb7mBc5N6MdGHzgkk0OTs+bl89rxXkHjQB0+XS2LHkRZa1zIKGv/8eIhFyF09I0zY1Z+plN757cze0iFZqjYx/HFv3WgEaARms3BPcdoyml6EGbfLolLBIt02KzsOccFWBUZFzQQJhtO8GQ+JMqspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlradN/HSC0huuVfdO6qxJjn9rGCRC66s4Fjb0xaqdc=;
 b=g2gIwAdQbb2xtOxNYMo2bBToiv0twea+3QcUdm4xfTFpspQ3eGmDQ8/YSkBG86HWz4Lmsp1QJ7b9M/wP4/R11pLUEvKQ1ez8wkBkPIR9w+C66TLz6SwVEpcfHxf6qR5/93lIJagSg7MaFmBsCnWCnukMrLNjyJhMuOJxq2HZ1UiwofIyXabigaeLvk15gjLW2isylszv42yo4se3YyeWzWAaEehMnYhzVUI1Xkcn+Vxr6YTCOnC9FCAO524VSKXmqS95Wz8VsXbkgksSol8GSE3HbD8t1bkYzs0xiDPwJ2KcamN9sgvpGy0B9O0Gl0oB+A7bvghXmTmiU+YP2gD07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlradN/HSC0huuVfdO6qxJjn9rGCRC66s4Fjb0xaqdc=;
 b=RQ09qVmmV1Pn0KSFrnjZfJfiyeVC99oLkUFNAFDpqIWG7RKrxspWVjzotxtckg2UNEP1RaqnAPMf1MK3yhjD5xwi+EVnRvLTeBmbppir2hIyoIJLlSrl4pSDaepg1Mm6O2RmJYd2K5yj3uUgyWL1d2eFy6JRW6TtSlPghY47MGE=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Wed, 30 Jun 2021 14:07:34 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::7b) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Wed, 30 Jun 2021 14:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:07:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 09:07:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 09:07:33 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 30 Jun 2021 09:07:33 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Extend DMUB diagnostic logging to DCN3.1
Date: Wed, 30 Jun 2021 10:07:29 -0400
Message-ID: <20210630140729.28464-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ef5129-cf35-4bfd-8541-08d93bd068b1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3819:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3819A480BFE8BF92D8A70CD3EC019@DM6PR12MB3819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/ZySxY/H9BDqPphNnVhxS3lbV28soKMymDRGR19phFvhLyN7ppT8EMh7G0AYrk9ykcmYtLDlCcIOLGnwO5BAqQipxPO6TvarPiQfk6MeHl9Nlerr8G/RVdvf02Kc6Q0G5qapIskwjWJ8dwEt9VstCklzZsh7mJB/tx6aVrtqYI4vGUeXW1jzmhpJAXnHJ5g8gdIcVuDx4M7VCyc5tUg1zka+lAYb5gQXp7zyhxANVoANwjxUVzrREYFzaR0oVu2pzKh/Ja9zneQXLYH1rkyGrqwg7PsCLyWTfzfc6nv/RoS/h9HLSC5lQupaHRZpEKHfPcTHDcKB4inkS1rJWqLS4mr4oarRNuHsZj+7acEKAI4O7BKUDJ0CJIvqQWIqd/ZcWx/7dB+C69SxkEzJWwPu4ezPrTx9KN8AEKtUQZLDPdbysyZDXy3fTeRmEFAoyUeXSgt4NCYOuKreo7IxmJgFr977oy1z4SJUg46mGzmTXRjPiZqmiFlUUmaR+0kvYQcIqcw/xUOER1GTqxZlTk0YP9jBgj7+8uFiVBPZpNusQvXuA7JDs5Trw8v6X4icubwSyutd6r0ECIsR740rRgcMckYwnCCLeH6RO1W932SrEfT4oJyNJqwvn8ol3bSewycvOAd1yh8l6Imf6S+mHmxzPU2xcEWyFMWxa67Fou+hR1QAXuHZHqK9NKfy6Km6PqXnFoz4EVfzo6Yfi1aAl0NHlXtecOHvPCogKAB0CpyhFs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(186003)(5660300002)(2906002)(36756003)(8936002)(4326008)(86362001)(26005)(8676002)(6666004)(6916009)(478600001)(83380400001)(82740400003)(336012)(356005)(2616005)(81166007)(44832011)(70586007)(316002)(426003)(36860700001)(1076003)(47076005)(82310400003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:07:34.4267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ef5129-cf35-4bfd-8541-08d93bd068b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3819
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
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
Extend existing support for DCN2.1 DMUB diagnostic logging to
DCN3.1 so we can collect useful information if the DMUB hangs.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 60 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h | 16 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  5 +-
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 8c886ece71..973de34641 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -352,3 +352,63 @@ uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
+
+void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+{
+	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
+	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+
+	if (!dmub || !diag_data)
+		return;
+
+	memset(diag_data, 0, sizeof(*diag_data));
+
+	diag_data->dmcub_version = dmub->fw_version;
+
+	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+
+	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
+	diag_data->is_dmcub_enabled = is_dmub_enabled;
+
+	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
+	diag_data->is_dmcub_soft_reset = is_soft_reset;
+
+	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
+	diag_data->is_dmcub_secure_reset = is_sec_reset;
+
+	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
+	diag_data->is_traceport_en  = is_traceport_enabled;
+
+	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
+	diag_data->is_cw0_enabled = is_cw0_enabled;
+
+	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
+	diag_data->is_cw6_enabled = is_cw6_enabled;
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index 2829c3e9a3..9456a6a2d5 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -36,6 +36,9 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_CNTL) \
 	DMUB_SR(DMCUB_CNTL2) \
 	DMUB_SR(DMCUB_SEC_CNTL) \
+	DMUB_SR(DMCUB_INBOX0_SIZE) \
+	DMUB_SR(DMCUB_INBOX0_RPTR) \
+	DMUB_SR(DMCUB_INBOX0_WPTR) \
 	DMUB_SR(DMCUB_INBOX1_BASE_ADDRESS) \
 	DMUB_SR(DMCUB_INBOX1_SIZE) \
 	DMUB_SR(DMCUB_INBOX1_RPTR) \
@@ -103,11 +106,15 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_SCRATCH14) \
 	DMUB_SR(DMCUB_SCRATCH15) \
 	DMUB_SR(DMCUB_GPINT_DATAIN1) \
+	DMUB_SR(DMCUB_GPINT_DATAOUT) \
 	DMUB_SR(CC_DC_PIPE_DIS) \
 	DMUB_SR(MMHUBBUB_SOFT_RESET) \
 	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
 	DMUB_SR(DCN_VM_FB_OFFSET) \
-	DMUB_SR(DMCUB_TIMER_CURRENT)
+	DMUB_SR(DMCUB_TIMER_CURRENT) \
+	DMUB_SR(DMCUB_INST_FETCH_FAULT_ADDR) \
+	DMUB_SR(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR) \
+	DMUB_SR(DMCUB_DATA_WRITE_FAULT_ADDR)
 
 #define DMUB_DCN31_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -115,6 +122,7 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_CNTL2, DMCUB_SOFT_RESET) \
 	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET) \
 	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_MEM_UNIT_ID) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS) \
 	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_TOP_ADDRESS) \
 	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE) \
 	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_TOP_ADDRESS) \
@@ -138,11 +146,13 @@ struct dmub_srv;
 	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
 	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
 	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
-	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET)
+	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET) \
+	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR)
 
 struct dmub_srv_dcn31_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
 	DMUB_DCN31_REGS()
+	DMCUB_INTERNAL_REGS()
 #undef DMUB_SR
 };
 
@@ -227,4 +237,6 @@ void dmub_dcn31_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub);
 
+void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
+
 #endif /* _DMUB_DCN31_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index a195734b4d..e58740afdc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -211,6 +211,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 #ifdef CONFIG_DRM_AMD_DC_DCN3_1
 
 	case DMUB_ASIC_DCN31:
+		dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
 		funcs->backdoor_load = dmub_dcn31_backdoor_load;
@@ -234,9 +235,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->get_outbox0_wptr = dmub_dcn31_get_outbox0_wptr;
 		funcs->set_outbox0_rptr = dmub_dcn31_set_outbox0_rptr;
 
-		if (asic == DMUB_ASIC_DCN31) {
-			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
-		}
+		funcs->get_diagnostic_data = dmub_dcn31_get_diagnostic_data;
 
 		funcs->get_current_time = dmub_dcn31_get_current_time;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
