Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F325C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96F823B98
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96F823B98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EB88932E;
	Fri, 18 Dec 2020 22:16:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4260A8932E
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d029k24uXhZIepbHq2qupS5NqjfIqnVrnAOyvnzpkuF8KLQl8AYJKM0rU0DXtYNtYajUfdPr2IWwo6r7vlnMAP4t2U7WbDf1QQ3hlY6Ab3GFIrnRX4QtMT2/cbIwRbfS7AhxxxMr4ZagvVM4TcSVUQjfuGmF5RiLjHrikArix7WfY0hUCtvu0XMsWJOGOnfwQSiOZXeRIj+i43CoRzIHSInPseTz5k+eFV0QasB1aJOixXykQJwfMIoQI956ATNJaWtJvne+X2i3mQ7APlGjwL8PUcneCz1WgnMrwYNhoc3wk16TzAgLKV7rGR4ODEsxU6B2gnrjyNfphMVEkrGNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ehgpzEdIuihUe48U+f7CGCXPuY4VFsoKJGxDNJPRqs=;
 b=gBumog//0MwC3COKIzErrCCm3Y5YyTTaszXNolnht8gJuZKohbU4MtlWgo4muVgi+Z3udakUmfGyuHE4uV0VQ6mvZ+EZRZbn0v3Tj6CF5PdJRu95TfNbmtmezRFk9ssDYaHxG9NtfIvHx1wBH5KKbfSwBXIMapn8V6xatLNTsl/Xg0fQdKIMOp6VNaJx1WbyAckWMqlQm8Ag11PsFhL/r25FRRe7pn7ZCjyMpZmnI6vjhTnFqd2vMT6dS7aDsewu6fJU8nSwtuADuBUtrAaABTSOe+0ia8jYVK75IvwrwfjKAONth0SxmO88V5LxO9qOYfXZ2bg8t7zSzWbPMMSPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ehgpzEdIuihUe48U+f7CGCXPuY4VFsoKJGxDNJPRqs=;
 b=Jg+p7mEgxpPFsXl7Gowsr19TW41Rk4Md8Fhya3KrORjrFoBM+LpkzmbfQVYjRq5odFem776M89UI3Kp6RfuNvWGSrreQZizoAzZKMpUL51SYFl6ynrYjzLGqwS1aUaO4r8Wrqv5l7ukLbSvZRaR1lrchxveWq3jYAwxRaeQqOcA=
Received: from MW4PR03CA0315.namprd03.prod.outlook.com (2603:10b6:303:dd::20)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 22:16:29 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::93) by MW4PR03CA0315.outlook.office365.com
 (2603:10b6:303:dd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.18 via Frontend
 Transport; Fri, 18 Dec 2020 22:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:16:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:16:26 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:16:26 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 18 Dec 2020 16:16:26 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <roman.li@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Create and Destroy PSR resources for DCN302
Date: Fri, 18 Dec 2020 17:16:16 -0500
Message-ID: <20201218221616.2452182-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89e300f2-0d63-458b-7333-08d8a3a29096
X-MS-TrafficTypeDiagnostic: BL0PR12MB4946:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4946CDAF3A2A3FA42E79FFA3F9C30@BL0PR12MB4946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQQWfHWfo0bnGjz1NGXHMva5tqLdHThhK6zVymfcr4wUSeScGXI5sR4WRLxUcS6D3rVsGGWS4qsKJ0QZujZaPE1vKLKCZv5rnAeYMPssQHpK33HgHVssOLEbg3VUrEI2pR1400yneGDBfDoXnfMt0cUizgs3o3O2CYGs3nonRE9itUseVJQRZfrXpssiIR/+BdCjBT9SUZ9gbShlIaH2D8As2myvW9P0rCAaAkxomIeJK8jtuj01Mbj5MchHQA/hWOJzoub9I926ybboxcX0XqWdfQzAu4QtGGKy18b0O+zY7myMvvuU5HLQTxGG/FacTiDZu8fEg6YlplAv0qjUxEW6CFXbGUcp3Gl2vfhC0MhyReJzTqGnDhn65pN2/Eh5ET1B//7ZyA3gzoU9ZBSF3sAm6SA+s6h5ibmKgS4bzGMXIkxZrA8vXCntJuE0l6+DtXFqRCZEXsvfFmlDf+7iaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(2906002)(186003)(26005)(5660300002)(36756003)(6666004)(70586007)(70206006)(54906003)(4326008)(336012)(316002)(2616005)(82310400003)(1076003)(478600001)(8676002)(86362001)(6636002)(81166007)(356005)(426003)(110136005)(7696005)(82740400003)(8936002)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:16:27.7074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e300f2-0d63-458b-7333-08d8a3a29096
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
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
Cc: Joshua Aberback <joshua.aberback@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

We need these to support PSR on DCN302

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 808c4dcdb3ac..8d24cd5e484e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -53,6 +53,7 @@
 #include "dce/dce_i2c_hw.h"
 #include "dce/dce_panel_cntl.h"
 #include "dce/dmub_abm.h"
+#include "dce/dmub_psr.h"
 
 #include "hw_sequencer_private.h"
 #include "reg_helper.h"
@@ -238,6 +239,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.dwb_fi_phase = -1, // -1 = disable
 		.dmub_command_table = true,
 		.enable_tri_buf = true,
+		.disable_psr = true,
 };
 
 enum dcn302_clk_src_array_id {
@@ -1213,6 +1215,9 @@ static void dcn302_resource_destruct(struct resource_pool *pool)
 			dce_abm_destroy(&pool->multiple_abms[i]);
 	}
 
+	if (pool->psr != NULL)
+		dmub_psr_destroy(&pool->psr);
+
 	if (pool->dccg != NULL)
 		dcn_dccg_destroy(&pool->dccg);
 }
@@ -1469,6 +1474,14 @@ static bool dcn302_resource_construct(
 	}
 	pool->timing_generator_count = i;
 
+	/* PSR */
+	pool->psr = dmub_psr_create(ctx);
+	if (pool->psr == NULL) {
+		dm_error("DC: failed to create psr!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
+
 	/* ABMs */
 	for (i = 0; i < pool->res_cap->num_timing_generator; i++) {
 		pool->multiple_abms[i] = dmub_abm_create(ctx, &abm_regs[i], &abm_shift, &abm_mask);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
