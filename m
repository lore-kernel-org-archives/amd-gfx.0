Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED403C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 15:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38F4613EA
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 15:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38F4613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 657116EF21;
	Fri, 11 Jun 2021 15:48:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893076EF21
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 15:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk+97SuEX2xrvqMHuAsABbOZ5oeXaJTr6RkdfNwMKdNQ1Dd93g+H4fImPgp/H/yUd5VVfiBAW9cjfzNcXc6w2CnYMpS8O0bb/XGxeKBDne1ObV+Ifv2Z6v+AXpoROyGUgoZQ95Kt5C9oOOXEVbwYaSDHpR4/rWS9OcjDxBLQzVHR0Ugs/M/qWOiiTuN8fU0FZBDDrwmh98GIYIS5qcklCG2OdDRiLV42BIAyLAxkF/GPi2mdectWLd5y6cLJyhTEsfLN/WRWCHwxT3ozBa4fQbQRkHYp3uXtZZQJfNl/ztfc1ATVe260NGo/QonXYrHbMAbiO3JYus2o1j9AgvVYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJkfv0T7Zymut1Zffz4j+5Yhst0oGYgY9YdslJ0ysN4=;
 b=iChAI4pbrDQTwnCPAsHfW90xqaLaB6JPbWryDakh2CUZZsTDAJhdv5JQKXbK875kjfZNMzigBsqrMbs6BVlRpvv2xtc3NgGFam5Jv/xmtfBrIJ8yZnN/PjBqhJdz2YJ8nR7WMfb6DkzoHJgbV5ETTGDVkGeWVWINWcvflO2LRwLHQZLc+ntJ70U2+F9tqmpnRhgT+DWZH4MvNVqePhECIGLUM5T/I7DTt16/wgImjkLhIQeymj2UyUJtH7PBtchiRYincKTXyZ2FDfsmjIVpYpbMBQn0ROLlxnC/RGaMjXspJwINJhTZ8cAUHkgGrODKteVvbEwC2YGmKPAHNaXjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJkfv0T7Zymut1Zffz4j+5Yhst0oGYgY9YdslJ0ysN4=;
 b=MWL7fY6NUvbC9cVzWZWxxLxiPwi9BeCglaDc3gxACRKe1q4pom0S0Eu1ehdGKYMrfWJGB3IvsacC9VvtVj9a/Q8jYquft814TRT+7O6aeH/yvMINQw+MDIiI1leILHJ2aby5+CfDZWPr9gueyHgtJeS4mZjy9lJb4h9Smy/j4Rg=
Received: from BN9PR03CA0223.namprd03.prod.outlook.com (2603:10b6:408:f8::18)
 by MN2PR12MB4829.namprd12.prod.outlook.com (2603:10b6:208:1b6::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 15:48:40 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::1e) by BN9PR03CA0223.outlook.office365.com
 (2603:10b6:408:f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Fri, 11 Jun 2021 15:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 15:48:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 10:48:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 10:48:39 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 11 Jun 2021 10:48:39 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: add dummy PG callback for beige goby
Date: Fri, 11 Jun 2021 11:48:39 -0400
Message-ID: <20210611154839.109966-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc72d85c-cfb6-48a4-e53f-08d92cf06287
X-MS-TrafficTypeDiagnostic: MN2PR12MB4829:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4829C4025E7ECB59D2F05B3B8B349@MN2PR12MB4829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EFUlvQvrpPyz5mi+bKQuztuQnT7LRezwSEQFapJbh4DBf82Fn1T/Sf/dlIJ/GPI59ZVcn5VDiBbPX64sJCpJbaCpf00NDeI95CH/0kUPEbxGV2NeyArm7D8JAOa33I1oCmBOLVZBP10X58ukSvda9bZ/3nCHSLwNusjjeh1q0dXisI/MPzLRCKU8aH8/X+700zMFZ3l2PgVclojZE9jUpZaUOhr5T2eenh2nfNfnLJNE/vHNuOSME3HqT2oCF5zcDhAvxnIIHRoF7jQcwYNOP939SF8AvRDz60jA4L28qruYmeyN9KtZgZsRXrW/elezbrJ3Af7eP8sCl0iFIqo03Yr9Eos3YUdQPmuWl0vuhYlqjZvSB0rSRJth1hfdix+O8rteZVIEifgwkPcRzuUDDZgjd14L45TAc/dDVHnIgHA9GSzMijRFisltjBjsTcws2ucXvmsRfj5nMwWF73VLnNWWf+L7fDyRUoi4VKA/sDlw2YCUlnJDeoK/98np53u2fzJR1oqN7ZcJIzNih/R3auNzmb7lopvhW45taBKRbH94u8rQZcfc9YKIpgEosb7ca2yfV9CNmJ/XNCDNdm59So4IonAx6aRNbaZIkljasM40GUl1fnFVUZcC74xPKhR8LTrLC0QSs2agvYazCE9N1SM/hXbruN7UyO5LA2hze1rs2UgUPSDjb1QQTcl2Fnr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(7696005)(1076003)(186003)(2616005)(336012)(2906002)(316002)(70206006)(82310400003)(70586007)(44832011)(26005)(356005)(47076005)(36756003)(86362001)(81166007)(6916009)(4326008)(426003)(5660300002)(36860700001)(478600001)(82740400003)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 15:48:40.6042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc72d85c-cfb6-48a4-e53f-08d92cf06287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4829
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
Cc: aurabindo.pillai@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
PG registers are absent in beige goby, so programming these registers
generate call trace. Fix this by adding a dummy function in dcn303
initialization function which prevents writing to non existant registers.

Fixes: 54f910c6372e ("drm/amd/display: Initial DC support for Beige Goby")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h | 1 +
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
index dc33ec8b7bdb..b48b732aa647 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
@@ -38,3 +38,8 @@ void dcn303_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool po
 {
 	/*DCN303 removes PG registers*/
 }
+
+void dcn303_enable_power_gating_plane(struct dce_hwseq *hws, bool enable)
+{
+	/*DCN303 removes PG registers*/
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
index fc6cab720b6d..8b69a3b76c11 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
@@ -13,5 +13,6 @@
 void dcn303_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
 void dcn303_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
 void dcn303_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool power_on);
+void dcn303_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 #endif /* __DC_HWSS_DCN303_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
index 86d4b303d02f..aa5dbbade2bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
@@ -16,4 +16,5 @@ void dcn303_hw_sequencer_construct(struct dc *dc)
 	dc->hwseq->funcs.dpp_pg_control = dcn303_dpp_pg_control;
 	dc->hwseq->funcs.hubp_pg_control = dcn303_hubp_pg_control;
 	dc->hwseq->funcs.dsc_pg_control = dcn303_dsc_pg_control;
+	dc->hwseq->funcs.enable_power_gating_plane = dcn303_enable_power_gating_plane;
 }
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
