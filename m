Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21B1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6AA60724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E6AA60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013DA6E1CD;
	Wed,  8 Sep 2021 14:54:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A196E1CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0a4QzoOHFA1cnf712PKctUyZ2ZkaTmwkxIL8QdXjQLLRnWHvEIanOGvRrrd4BVnx1Oj2wIx2GkVopq2UYdmHZbjYoZNDlkZ1OZehbK/wP3HL7uqqrFXIEiPC8BaImmi56jcd6bDsOrdgamlcozdQl90UR6v3l/wjN5mew02LduX9jIKPn58Tybg0hYrdKRxDxdIoNn4zNomNAD/giIpB48mOzMBUV2SZx40xOZm4adRJs7Z07cWtjj+Z7OAEM2rSxeu3Sbkc9Brc+udPgQgg65acfnQPi2oDYimjDxKGnYXQXgalJvxFx6b+Sg9YySC06AI1K5f+e6YPjKw9uVPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Jx9FayJQKLFcwG0M8qWryr5fhXDJVQrur5faEVELQBg=;
 b=V7dMsbFlMgAU+o/4CANSI1QGi1/KS7pKgpdvVPl16rXCKgWSISCLXSfJ9q6GkvEhkpzA1eDBzhvXITfX140aBTtmVA9H+YlvzMu7r+SG2+L4e45AYndqzrcqHNWITh7iqgb+FcizSQhFyMyOFJezzwLcD23wsyfkB+fPBUyKM7nk4OsFAe0tSOcNK8A/OnuPDCFAoH5UWPRHg9UMNW9uCBUjPa1iJaUoUE+oh7a2itU3olqjdyGqxHQEl3VmNsrUg2UIPgCW2wwHl5bwgCDCk/RbTFjY7Ie6Nxtzbd+AjSL8OMUgI8033xDKzEqzmwpLbnAY6gtXX4maNHNbVvGX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx9FayJQKLFcwG0M8qWryr5fhXDJVQrur5faEVELQBg=;
 b=iF/cFEzIjvBBGUvwxCo+O0Hw5xKHUeVfBIZlYX+IfyJR/XmX+XhkHpkIk3MHGkH3VqlbyazYZhwpLL0RQmSnViPve1cqmE/fYmv+cenM2AdKj4upsrrZxBPENPnnM0hYhg3wv8DfSPAY2+pxY3fR4KEM+VLL6BDTH14S9JVGP/Y=
Received: from DM6PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:100::27)
 by SN6PR12MB4766.namprd12.prod.outlook.com (2603:10b6:805:e2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 14:54:42 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::cc) by DM6PR03CA0050.outlook.office365.com
 (2603:10b6:5:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:42 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:41 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Josip Pavic
 <Josip.Pavic@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 07/33] drm/amd/display: unblock abm when odm is enabled only
 on configs that support it
Date: Wed, 8 Sep 2021 10:53:58 -0400
Message-ID: <20210908145424.3311-8-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cc3d9d1-5f30-49da-1653-08d972d8976e
X-MS-TrafficTypeDiagnostic: SN6PR12MB4766:
X-Microsoft-Antispam-PRVS: <SN6PR12MB47663CC8C6DF6C5A78502BB3E4D49@SN6PR12MB4766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbkuBDhNDRQv17/InXfWMVjsORvhcj8KINQzA5FI/joByzHSewaEOBtaDPoQNYWRyhXXxTNdomnRNPF3xJguGxO9nP4ljsQMXCEIZ072jOPLUnWxBiptPcNDlpkAcnrma/E7nzol3FgW5ZR5bWehme7F3z6PKP//J0xExltYxdEiJ0jdqKJC0VG/GSoAeQ0QAivB19CTxtDMAU4oLe/Z1fdwETlc0nIm0QlD2lF0cQV9AbBMNHK4ClV2BSIPuPE0siNxYQEOalVFnrjmWt0tIojh0KNySu0w5/rgT8ZfabkEZ/McTzd65JfDN91EuechP3CQjIgJ6BM6t63yk3sqRC/AlanKDvSoy9cnoymZHwhiFewBigHBdayjiWOEIiQQi4ItkQL/Qou31D/kTDxLylF35SJ2Kacztg1zKYliE4HFm3IDzrBnuQSpEEHB5X13g2ujKfbA9HkcveUsLVVkCbqOAee98hGoRIyGr0L0xFGOZu/c2lYrjDcsTR1pSU8gNC58dZk1niYCACMtID83NgfC6JQgAVmXv/UW7nikJ2MLzQMop5QMmGixAEixBboKTteWr8B7LbLamDtlawYOKjOwrn1/6yGVWrTsIhl119p9cHy67+q0VmbWKQqTMZDJ8O91OntoI4LJ6i6n/BiGumLO8bA6g9AsOIXQIQN9h/jH6Di1ySSh+N/tShTAYHkjN3JO3xoVByyV+dMxqReQhWdAxnbTjCQ5UOqCOvrofMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(82310400003)(2906002)(83380400001)(86362001)(36756003)(6916009)(316002)(82740400003)(36860700001)(4326008)(81166007)(54906003)(2616005)(336012)(426003)(356005)(6666004)(1076003)(47076005)(478600001)(8676002)(70206006)(70586007)(44832011)(186003)(5660300002)(26005)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:42.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc3d9d1-5f30-49da-1653-08d972d8976e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4766
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

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
When ODM is enabled, ABM is blocked on dcn31 but unblocked on dcn30.

Since the dcn31 firmware is now able to handle ABM interop with ODM, it
is no longer necessary to block ABM when ODM is enabled.

Since the dcn30 firmware does not handle ABM interop with ODM, leaving
that combination unblocked can lead to one side of the screen appearing
brighter than the other.

[How]
When ODM is enabled, unblock abm on dcn31 and block it on dcn30

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 15 ---------------
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  1 -
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 3a5b53dd2f6d..93f32a312fee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.is_abm_supported = dcn21_is_abm_supported
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 7feba8a0d847..2434232fb3f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -595,18 +595,3 @@ void dcn31_reset_hw_ctx_wrap(
 		}
 	}
 }
-
-bool dcn31_is_abm_supported(struct dc *dc,
-		struct dc_state *context, struct dc_stream_state *stream)
-{
-	int i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-		if (pipe_ctx->stream == stream &&
-				(pipe_ctx->prev_odm_pipe == NULL && pipe_ctx->next_odm_pipe == NULL))
-			return true;
-	}
-	return false;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 40011cd3c8ef..10c83f4083b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_pipe = dcn21_set_pipe,
 	.z10_restore = dcn31_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
-	.is_abm_supported = dcn31_is_abm_supported,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
-- 
2.25.1

