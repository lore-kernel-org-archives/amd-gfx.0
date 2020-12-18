Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7C4C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAC223B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAC223B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4CF89A08;
	Fri, 18 Dec 2020 22:30:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E8089C13
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLUiW6UZuEEAdh4iRhDMDU7jOOUkjZnjwplh9qsx4KgbhTEqVXXvcbg5csNyOtrlMyqwG2ExvcuXpcCuMVkKfzJAJGxYEmKBXzZ2kh7wuFpZzhbZy3UvBv8wcNeNVx/DUdSw9Fd4PeKClw++7NuNt8v9ArIAkJmCJCp9KWyJTDyY0159eorAPapkSXGquQCsmiW/wKRUt2pxpj0Mdwl/ao2VKqsxnX9riWqK5tuA0i8zkJey470pY1FsfcF2gzSqWQszaBDiDcEGtuPhe5Qw8+uPxL+1DYTAT2G7s7LVSa+TYVDI3qyJn2bQsjUDUknRSR5Qh6ubU0vbFKZzcRO7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7ZZUQvKrm3C8kJh/GhkQeP5uCCo2qmf9G0MmAxqvrU=;
 b=MxA5oOSKwfJP0bAXyDVY5EbTYQgQZqbjjaMW9aK7nuUxqVnYmP1F41b6tWJSPU6VQinjHRiDtaNQ0cUkCNYp2yzY3/0fudSJQ4Jp/OkpI8KR/Mb0EWvJmGctRhZUbsLaShTUzakOyilx13mT2QHvoH2ZKiSWF7GXOG34PfveKTDSDac5MlpeBBfJ/77hwjvs6bfLu6AHGmYCE4a/2bRd0HFo6Fb+oB2DQZb5Bz33MpwKiCgpNwc8vijGl+/VYAMDzNL7uaXS5bH/m63+drOQ28lidQXXlcIbVso2T6l8pw3W5q0UP24gn3RKY32WJWTp5JqOORCvFQTb174Kv6dI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7ZZUQvKrm3C8kJh/GhkQeP5uCCo2qmf9G0MmAxqvrU=;
 b=gcEuP6CjUjbuU3hG3O+8u4LpUY20SxCiJ+ZY7hOV5Z7WmfzcQSMMqvVVdXRK6xHCNRMagIEF1oeJgNNvq9HN4kmHScdccJEVC+Z2L8Smtu9kV1xvPtmAyKZMGKe/v4JtAnrQozWosBZxirxJndZr07qGbHKRkxlzJTB36hlA/wk=
Received: from DS7PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:3bb::24)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 22:30:15 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::5e) by DS7PR03CA0079.outlook.office365.com
 (2603:10b6:5:3bb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13 via Frontend
 Transport; Fri, 18 Dec 2020 22:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:30:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:08 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:30:07 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: add getter routine to retrieve mpcc mux
Date: Fri, 18 Dec 2020 17:29:04 -0500
Message-ID: <20201218222904.393785-15-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa230c6-437d-42e9-0e60-08d8a3a47d76
X-MS-TrafficTypeDiagnostic: BYAPR12MB2919:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2919D5709470CC8B1C7F9B71F5C30@BYAPR12MB2919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5ZFwIf2VA29nHHXm8YeB+rDC1cokYKSItoCDlLj0yjq4W3J7kpAFpPFVE/AW8SoL+2J03n53coKLcWyXNyMslVMyaQDZPLOK+rysocKaoaFLlzQJMDuTeWHNLWjWIMbOzD46nUmJiA8Vyn1kmz0u3/pokihI/Vh9FN9YfCzGKhTqitkU5yN5/sJCfMBIkfqbCvGXHMeDMLQQPKuGWIDlIuNzqc04/ahHRo8uDl07nxhFTpzYCChZrxhcXWSd8QYT4jlRlwLeTlEh7+OTdHoDWAUbZT1U/eKFFFEzvb4yQ+OT2pu48cKBrM9arYI30zr+xrp1HDMTx9SjJl5juKxpEh0CBFKvH5O+8Rp0RSH5/XQNr1im9fXhvmHkSbKOblcSmgGQGVwNjL7DyprMvIlotKd/bbQVZt7Sq2tfcWgIGnU1Dy24mcPHhACbZujxc61Iqru9uwCrjHebAQYIObOjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(8936002)(426003)(82310400003)(7696005)(54906003)(8676002)(82740400003)(70586007)(47076004)(2906002)(26005)(70206006)(186003)(4326008)(81166007)(86362001)(1076003)(36756003)(316002)(5660300002)(2616005)(83380400001)(6916009)(356005)(478600001)(6666004)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:30:14.6808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa230c6-437d-42e9-0e60-08d8a3a47d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Add function to identify which MPCC is providing input to a specified OPP

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c |  1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h      |  4 ++++
 5 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 3fcd408e9103..a46cb20596fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -467,6 +467,17 @@ void mpc1_cursor_lock(struct mpc *mpc, int opp_id, bool lock)
 	REG_SET(CUR[opp_id], 0, CUR_VUPDATE_LOCK_SET, lock ? 1 : 0);
 }
 
+unsigned int mpc1_get_mpc_out_mux(struct mpc *mpc, int opp_id)
+{
+	struct dcn10_mpc *mpc10 = TO_DCN10_MPC(mpc);
+	uint32_t val;
+
+	if (opp_id < MAX_OPP && REG(MUX[opp_id]))
+		REG_GET(MUX[opp_id], MPC_OUT_MUX, &val);
+
+	return val;
+}
+
 static const struct mpc_funcs dcn10_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
@@ -483,6 +494,7 @@ static const struct mpc_funcs dcn10_mpc_funcs = {
 	.set_denorm_clamp = NULL,
 	.set_output_csc = NULL,
 	.set_output_gamma = NULL,
+	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
 };
 
 void dcn10_mpc_construct(struct dcn10_mpc *mpc10,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h
index 66a4719c22a0..dbfffc6383dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h
@@ -200,4 +200,5 @@ void mpc1_read_mpcc_state(
 
 void mpc1_cursor_lock(struct mpc *mpc, int opp_id, bool lock);
 
+unsigned int mpc1_get_mpc_out_mux(struct mpc *mpc, int opp_id);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 99cc095dc33c..6a99fdd55e8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -556,6 +556,7 @@ const struct mpc_funcs dcn20_mpc_funcs = {
 	.set_ocsc_default = mpc2_set_ocsc_default,
 	.set_output_gamma = mpc2_set_output_gamma,
 	.power_on_mpc_mem_pwr = mpc20_power_on_ogam_lut,
+	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
 };
 
 void dcn20_mpc_construct(struct dcn20_mpc *mpc20,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index d7d053fc6e91..3e6f76096119 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -1428,6 +1428,7 @@ const struct mpc_funcs dcn30_mpc_funcs = {
 	.program_3dlut = mpc3_program_3dlut,
 	.release_rmu = mpcc3_release_rmu,
 	.power_on_mpc_mem_pwr = mpc20_power_on_ogam_lut,
+	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 879f502ae530..75c77ad9cbfe 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -359,6 +359,10 @@ struct mpc_funcs {
 
 	int (*release_rmu)(struct mpc *mpc, int mpcc_id);
 
+	unsigned int (*get_mpc_out_mux)(
+			struct mpc *mpc,
+			int opp_id);
+
 };
 
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
