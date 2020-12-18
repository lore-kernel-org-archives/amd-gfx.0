Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95DCC3526C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7F023B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7F023B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC2389856;
	Fri, 18 Dec 2020 22:29:59 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5A189856
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3o17g8T32Bezt3zhF69fFeXAnSTZ0czqnffeYDd1HE2MLNOBgVPhUK8SUz3q5O3w4FoQXungguli8UsXPNbALuOxej4TlPo8Zp5T27H7SiRwk6vdqS95AIvDRS6+fDYFUVARmghrqQrhJdjUP3xO+0zteoInktamNAws/ujzh2TSLMkTtt7gNWNCfXD1isTgMIus3elwJMVhv9EtRPKR99E6UBeHdsUxqxk070COzgW7UwCtrd2G3edUpNMe0wf4P58a0A2bV0hbBEtpP7adfgJDDGOcZvGtV7yVw5lff3Hi4TruW5fWpXZvjtLILZD4ifDxbijvF5kcb0RfMVMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjR2tw+1/ni7qHbL/nq/yc93p8/PNn5kmZmuyql3dw=;
 b=mO0OMow3YSh2Lx2VV8RNQHkTIsVMxuvFLg+Ki/Ifz8upEyjIOuKybADXrBrgOLbv3inp4hOufWrnCf1fSJJKQkqre0KlE8r1ajBgfRD+o9Ep1GDYvFJBE0I0zNMSBWhw1WIAH89LhPK/9eJJ7kl830jQv8jgcLBuI+/O8FnuzEtsj6L8t9ixITygYBlsMDI7GI59uS9ifXeqKVXxVPS3XPVj7Mdog3TCUFRs7DAOd5S4UXe0hcRIKr8oJ2+WFvGQ4LTw1SG5FxXvNJdWgQqKMVpJU0RZRCJZ8rR9+ngNap9W79npMuxgi/F42DYP3jK9vw/6PEm1xr90TAp13/0aIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjR2tw+1/ni7qHbL/nq/yc93p8/PNn5kmZmuyql3dw=;
 b=xTUDVz81iUwfIDoy43iCJ2jOgWmS7T1azuL3FkPwViHQdu1Wa6sHeG+bkf2sZX+z3DHtijSH0LjTyTqjBTgdo4C9mtpdoJdLEk8WXkohnYZcYBoyPuSkZiE6WM9LqNfDAhoBc0un8i/8EURIxP1qMX3qQ9bcZLeIxYKtQolJQoo=
Received: from DS7PR03CA0065.namprd03.prod.outlook.com (2603:10b6:5:3bb::10)
 by BYAPR12MB2598.namprd12.prod.outlook.com (2603:10b6:a03:6a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 22:29:56 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::45) by DS7PR03CA0065.outlook.office365.com
 (2603:10b6:5:3bb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend
 Transport; Fri, 18 Dec 2020 22:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:29:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:50 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:50 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:49 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: Interfaces for hubp blank and soft
 reset
Date: Fri, 18 Dec 2020 17:28:52 -0500
Message-ID: <20201218222904.393785-3-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f30301-88a2-4a95-d1e6-08d8a3a4717a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2598:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2598070B9224A3DE202E9F61F5C30@BYAPR12MB2598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMggRwHt1JJO6+PW4h5dzVxzt1G/OdrtoO/rp0fmsmZ68BxaFXAmZiuuL8+hNLb0SfxZQp5EGd6pHphdeFZFqmvFa+/3vRh58GbT298KhiY3uydFOXC2px/YGv74FwkwJjauPFLxqm2+sy43PIOSVHGatpca3DUHlLec9aSMixMlF8ZyOhMQXfM73xYmjnMI4w/EX3FQ83YcOd1ZqGI5F1EuTeqLP+3ESt6hl81pHPpjqsWz07jEB7GP12UzDGIH9BPosrolpt/89IlriWwuspz8JdUXd30l+EKvF7JO/OjeYntAKElM8ow/dPM7njz1iztZpY31qdEVqV0c0TuZ5XYfMI7y16+ax3biA5e8D7ZYpLfzREiex4u/Ur4XSzY5u6paH0KQ4kGcIhou7GV5Gk5RE4sT2H+SSqewTQzJjop6kHr+BTXXens+YIJPsSL7hWrOkpEYsTouL8kfZC0woA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966005)(6916009)(186003)(1076003)(2906002)(426003)(4326008)(8676002)(356005)(7696005)(81166007)(47076004)(316002)(70206006)(82740400003)(6666004)(8936002)(86362001)(36756003)(2616005)(83380400001)(336012)(82310400003)(26005)(478600001)(70586007)(5660300002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:29:54.5794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f30301-88a2-4a95-d1e6-08d8a3a4717a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2598
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
HUBP blanking sequence on DCN30 requires us to check if HUBP is in blank
and also toggle HUBP_DISABLE, which should instead be called
HUBP_SOFT_RESET for what it does in HW.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  | 18 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |  4 ++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  2 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h   |  2 ++
 5 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 41679ad531c5..9e796dfeac20 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1241,6 +1241,22 @@ void hubp1_vtg_sel(struct hubp *hubp, uint32_t otg_inst)
 	REG_UPDATE(DCHUBP_CNTL, HUBP_VTG_SEL, otg_inst);
 }
 
+bool hubp1_in_blank(struct hubp *hubp)
+{
+	uint32_t in_blank;
+	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
+
+	REG_GET(DCHUBP_CNTL, HUBP_IN_BLANK, &in_blank);
+	return in_blank ? true : false;
+}
+
+void hubp1_soft_reset(struct hubp *hubp, bool reset)
+{
+	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_CNTL, HUBP_DISABLE, reset ? 1 : 0);
+}
+
 void hubp1_init(struct hubp *hubp)
 {
 	//do nothing
@@ -1272,6 +1288,8 @@ static const struct hubp_funcs dcn10_hubp_funcs = {
 
 	.dmdata_set_attributes = NULL,
 	.dmdata_load = NULL,
+	.hubp_soft_reset = hubp1_soft_reset,
+	.hubp_in_blank = hubp1_in_blank,
 };
 
 /*****************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
index 780af5b3c16f..a9a6ed7f4f99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
@@ -260,6 +260,7 @@
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_NO_OUTSTANDING_REQ, mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_VTG_SEL, mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_DISABLE, mask_sh),\
+	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_IN_BLANK, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, NUM_PIPES, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, NUM_BANKS, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, PIPE_INTERLEAVE, mask_sh),\
@@ -455,6 +456,7 @@
 	type HUBP_VTG_SEL;\
 	type HUBP_UNDERFLOW_STATUS;\
 	type HUBP_UNDERFLOW_CLEAR;\
+	type HUBP_IN_BLANK;\
 	type NUM_PIPES;\
 	type NUM_BANKS;\
 	type PIPE_INTERLEAVE;\
@@ -772,5 +774,7 @@ void hubp1_vready_workaround(struct hubp *hubp,
 
 void hubp1_init(struct hubp *hubp);
 void hubp1_read_state_common(struct hubp *hubp);
+bool hubp1_in_blank(struct hubp *hubp);
+void hubp1_soft_reset(struct hubp *hubp, bool reset);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index b7e44e53a342..0df0da2e6a4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1595,6 +1595,8 @@ static struct hubp_funcs dcn20_hubp_funcs = {
 	.hubp_set_flip_control_surface_gsl = hubp2_set_flip_control_surface_gsl,
 	.hubp_init = hubp1_init,
 	.validate_dml_output = hubp2_validate_dml_output,
+	.hubp_in_blank = hubp1_in_blank,
+	.hubp_soft_reset = hubp1_soft_reset,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index af462fe4260d..88ffa9ff1ed1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -509,6 +509,8 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_clear_underflow = hubp2_clear_underflow,
 	.hubp_set_flip_control_surface_gsl = hubp2_set_flip_control_surface_gsl,
 	.hubp_init = hubp3_init,
+	.hubp_in_blank = hubp1_in_blank,
+	.hubp_soft_reset = hubp1_soft_reset,
 };
 
 bool hubp3_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 315e3061c592..22f3f643ed1b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -188,6 +188,8 @@ struct hubp_funcs {
 	void (*set_unbounded_requesting)(
 		struct hubp *hubp,
 		bool enable);
+	bool (*hubp_in_blank)(struct hubp *hubp);
+	void (*hubp_soft_reset)(struct hubp *hubp, bool reset);
 
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
