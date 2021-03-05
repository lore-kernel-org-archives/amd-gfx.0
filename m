Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CBC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD0660200
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD0660200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF65B6E2F2;
	Fri,  5 Mar 2021 20:03:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E2A6E2F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEHwGG1iq5uDdnP8iahb9QvuimlTJC3WOhDzOndaBhDvnof2RMPFzspxQCTb4QXhgr8WchtyfBhaI5kfsdMoUJmFvsA2xQNmi5Mgko+BQHOV7SstleF7ikrHWBtzmjqH3SRTI1tpdrMnaT1Ws7Kwc4l9xm2dkciwk7pLez3/a9TSWe/qoZeT8CMlv3G9iguXHG8L4UY5i5+AiGeX3pOhsKLJ1Av5rlJWqbuvDMliwcUXdrTmCa6b21RmMLBLsCupFPYsOTQggGKwxZ+xy+oV/ZskU0+l8BY2UbMs0vbSRRQcFP5G/0ng8p4twIzio4xtAqrl28v5r4PiHPEc9TUOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m3c3szQjm9kX+ACT4PtDmnGZxaD3Db/20/bKW29Gt8=;
 b=gZ7ArRtBW7IEA5svThzERtivsOzj6oQ/OxXO0kGjiFr5m7QuaE0ExYH+3kUyGVKh8C/BeRH94qZsRw3wwYhzqBMTtDun7NV3Dt/NHpqGT5LSv3RKMFQzwCS0tkq+pbD2w+hZDpncf9f5Jk7p4bT+00Oc221tcms0JC4M9DpM3u8dtH9aaAVZFMgQd8reFUs357O10p0Pi9iyt8VOaTqUn1pOnj4OSh3PoDO7BwGNlJawz19ixVzM5awhxprT4FLshFRf430YurF7985/OzOYYfimVQZqPivKSVSRj62NbimxobuXNeP2bdTsMEd1WdwaOcAGxi4C4fk1Wh1snncHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m3c3szQjm9kX+ACT4PtDmnGZxaD3Db/20/bKW29Gt8=;
 b=RBIiRCs4u5QlKHmN2R/GxpK9dynohNS1TqCdLhrr+VWt9hOSl8xULV/8YPu+b7KGFEwIs+ALilr8wRxjwVwTC6+sBaXXbDJqB0ckRGuBJdOQ2a4u5zogdRSNPWC1g+PbQTbVBzCp8M5PSNrrH4kr7MKpzWTqIshji6c11dacE60=
Received: from DS7PR03CA0113.namprd03.prod.outlook.com (2603:10b6:5:3b7::28)
 by DM6PR12MB3787.namprd12.prod.outlook.com (2603:10b6:5:1c1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 20:03:47 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::8e) by DS7PR03CA0113.outlook.office365.com
 (2603:10b6:5:3b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:03:45 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:03:44 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:03:39 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: Enabled pipe harvesting in dcn30
Date: Fri, 5 Mar 2021 15:02:48 -0500
Message-ID: <20210305200301.17696-2-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e72c0cf-05ad-4eda-2f8b-08d8e011c891
X-MS-TrafficTypeDiagnostic: DM6PR12MB3787:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3787773814C093EE8E999C41E5969@DM6PR12MB3787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaM9A+zn1zHNZNKXtRV1Vj2TyWCnM/0+DzYmnQnB8Y3fd9zjylHzEVWIHZgqSBfKRiGNWnl70RTztX1OShpgx1gI5bb+JDLs5ZWzo4KkUYwkjL0xvgkY7PZCvwm+sOUWOKcEIVXwRS4PG52xzqnA3aWCdI/9eIchy+Kq87tCS27nxEgdeUrO8soWYZBklIVesFRabTXwQSH7O7QKnDV3AIgr+MoX23/SXPE7GRonwr5zHz4SpfF2RPXSR3zTwqF4rDOeITCck3G7WLXx1eQyYEzWhNelo0ORoZmpFH9Ta4/mQndqdLOQsOdk53b/NOoPWeVSQQoWLZSS2tYChFb8GFGU2JZxeLpr7eNJmo6M9TtaGoeGLyIMb/qSHZZCjtomVoNx9ZJM6Z40onSCcN0b7RJCJM6+h4nfH5AOylJ+mu4nPZBP0LwxX8vajT2AnhTJpcHMzyXiTtoowoNdx3PXmAoRmLBgs25NaIj6SDHlUOulHQD7ScSY2DHmS88gAf6PsQZrcCREWSCKRV3B93EsNkhE441Hc6VnTbCpFPsMPMDugF6eztQkkc1Lo3qhlEJZSxgmZRh5SWxaHW/obHVnisTQZBudvSPd0AaF9BMAbc1EK+qNAdSbTkHUx4kb0N0NxB2QPgsNYZyiwrh98xm249dYBLIH6BQwVbKVlP7d851SH0o2iXcpzqEZhQ1h9ZAj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(4326008)(186003)(47076005)(8936002)(426003)(336012)(26005)(8676002)(86362001)(478600001)(2616005)(70586007)(1076003)(356005)(6666004)(81166007)(5660300002)(54906003)(316002)(70206006)(2906002)(36756003)(82740400003)(44832011)(82310400003)(6916009)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:03:45.5869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e72c0cf-05ad-4eda-2f8b-08d8e011c891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3787
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
Cc: Dillon Varone <dillon.varone@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Why & How]
Ported logic from dcn21 for reading in pipe fusing to dcn30.
Supported configurations are 1 and 6 pipes. Invalid fusing
will revert to 1 pipe being enabled.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index f85765cc73f4..71e2d5e02571 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2508,6 +2508,19 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 };
 
+#define CTX ctx
+
+#define REG(reg_name) \
+	(DCN_BASE.instance[0].segment[mm ## reg_name ## _BASE_IDX] + mm ## reg_name)
+
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* Support for max 6 pipes */
+	value = value & 0x3f;
+	return value;
+}
+
 static bool dcn30_resource_construct(
 	uint8_t num_virtual_links,
 	struct dc *dc,
@@ -2517,6 +2530,15 @@ static bool dcn30_resource_construct(
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
 	struct ddc_service_init_data ddc_init_data;
+	uint32_t pipe_fuses = read_pipe_fuses(ctx);
+	uint32_t num_pipes = 0;
+
+	if (!(pipe_fuses == 0 || pipe_fuses == 0x3e)) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: Unexpected fuse recipe for navi2x !\n");
+		/* fault to single pipe */
+		pipe_fuses = 0x3e;
+	}
 
 	DC_FP_START();
 
@@ -2650,6 +2672,15 @@ static bool dcn30_resource_construct(
 	/* PP Lib and SMU interfaces */
 	init_soc_bounding_box(dc, pool);
 
+	num_pipes = dcn3_0_ip.max_num_dpp;
+
+	for (i = 0; i < dcn3_0_ip.max_num_dpp; i++)
+		if (pipe_fuses & 1 << i)
+			num_pipes--;
+
+	dcn3_0_ip.max_num_dpp = num_pipes;
+	dcn3_0_ip.max_num_otg = num_pipes;
+
 	dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
 
 	/* IRQ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
