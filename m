Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCCDC5DF9E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D3022283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AyGyEgUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D3022283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FB16EDDD;
	Wed, 21 Oct 2020 14:23:37 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19696EDBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoN8VtVEhKvJJAXFEIeJ2LtIgHadbg/50+4tB4Q/3Adwyo3gEKdha8uiOoTyC00R2SGXJk2m1SSSmzxg0BK3k1Q6Mg+R+zqMrZwGiklmWJ+LWcyDTGl/EWrqC7X0MlBPKRivPVDTmt1y/j12/f1LBh2KnWsM35QAy7bpMwU2SKUy2H4GCOhkxc9lA8ZULFO2x05HtMe+Ch2TXh3m73gwIMk/spL6J7PMo/dF7dVeTUjPfUDKOFvrhpCLU45bFbH/lcavqB0fYeOmNWZtQRXD/IbnKsDa1ZpXGxIm4V2YS8t2MV0j+CqnlQ7Cu1Hx8Z8jv7aj/f8FwVvFozo+9NvgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFot3S3jRV3tNUrPNk+nPFIuOMACqgv6M8939WJYBS4=;
 b=jzWZQdqnZvg46G0zM2PbeHfx0dQJwMvuOMYmbdiBQvAWnAGCIw0hn/KZu/PQC/Qj43vDnb1KrxIAlhqxwFP9he08iGgzr9P0KBtbuYBRzVZ//MTjkW6szcs5sOoeg1UZ+qoM+A7XS9Ey526dulkBqzGrLV7VsSFeg9C/BtfufKDT2lGK+OuNEnwjMCilp1PxKwJbYPC1xZ/qJqrHx4E3xg3LwD2XL09iRyqJCwd89QP9GRBv+39izcGavNMi2/qx2V/MzSpG8l7hfGQE7yVgzRtxzNgCRmHet5uLxfphKFMzeflPu5prGsvaCelI6UOS+WfKgCwPEwSV8qc8hOkU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFot3S3jRV3tNUrPNk+nPFIuOMACqgv6M8939WJYBS4=;
 b=AyGyEgUq/nu4WMJ0+/dJmmlaaGp59NW2++6oRuNhedPjX6ZL4Zs9aApEmsPanR8n1LhstBOK/81SAFUtBsx1IE3Ujmd4B5BblMEIC+D8yHK+fmIa3HXOUPlky+pB9DmxWxN4GiP5ScWsSK6zT6u6kHA3bOQk2ISA8590QBVMG98=
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:23:30 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::9e) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:29 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:29 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/33] drm/amd/display: Removed unreferenced variables.
Date: Wed, 21 Oct 2020 10:22:55 -0400
Message-ID: <20201021142257.190969-32-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41c91fae-b4ed-4a1e-3b4d-08d875cce203
X-MS-TrafficTypeDiagnostic: MN2PR12MB4285:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4285C71B7DA1C4068C982DC88B1C0@MN2PR12MB4285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggm5HByAeWoMYeQpm1IM2dnISOsPriw/0F2Nt0veQWiYH0PECiZBqm/rBRmUbycyL/quSbqMjuUxc4RCj4L14mG8vxZsM5ENQEwpqGkV/7+2OR1FvXxe/5QecFARii8igrlY2iDCTr/KKKFJIFjvq/Rf04zyYj00HZ6yfRJMLoq2xfgzKBPd3Cg45rYCqyWYbkhlVhzR2IyJ9JWJGmnEqCtyCFBk7IzaCxJB5Jt73NasbR61ssb/t61LWh64eoBe6B4kqkanWhtvRZbQ5WivJVAyDs75pdfkxAlDqsJzriBuV/U8gXCcE6lhckhiZqzKwsp3Ov7YA1vjXCpCIZmiVEDbfqFwAH/fSkFh/oTP7vefEZ1ctj6vmC7rAvZ7VborPWuVbYgOrezXr7HtgCa8Aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966005)(54906003)(336012)(2906002)(86362001)(478600001)(8936002)(186003)(426003)(6916009)(8676002)(44832011)(7696005)(26005)(316002)(2616005)(36756003)(4326008)(70586007)(70206006)(81166007)(5660300002)(356005)(82740400003)(47076004)(83380400001)(82310400003)(6666004)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:29.8126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c91fae-b4ed-4a1e-3b4d-08d875cce203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 George Shen <george.shen@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

Signed-off-by: George Shen <george.shen@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c | 1 -
 drivers/gpu/drm/amd/display/dc/dc.h           | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
index 9e16af22e4aa..a249a0e5edd0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
@@ -54,7 +54,6 @@ static bool dc_sink_construct(struct dc_sink *sink, const struct dc_sink_init_da
 	sink->ctx = link->ctx;
 	sink->dongle_max_pix_clk = init_params->dongle_max_pix_clk;
 	sink->converter_disable_audio = init_params->converter_disable_audio;
-	sink->is_mst_legacy = init_params->sink_is_legacy;
 	sink->dc_container_id = NULL;
 	sink->sink_id = init_params->link->ctx->dc_sink_id_count;
 	// increment dc_sink_id_count because we don't want two sinks with same ID
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7622cd222d66..b7f53908ebea 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1175,7 +1175,7 @@ struct dc_sink {
 	void *priv;
 	struct stereo_3d_features features_3d[TIMING_3D_FORMAT_MAX];
 	bool converter_disable_audio;
-	bool is_mst_legacy;
+
 	struct dc_sink_dsc_caps dsc_caps;
 	struct dc_sink_fec_caps fec_caps;
 
@@ -1202,7 +1202,6 @@ struct dc_sink_init_data {
 	struct dc_link *link;
 	uint32_t dongle_max_pix_clk;
 	bool converter_disable_audio;
-	bool sink_is_legacy;
 };
 
 struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
