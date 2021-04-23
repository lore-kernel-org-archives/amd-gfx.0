Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70254C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B025613F5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B025613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACB16EB24;
	Fri, 23 Apr 2021 02:40:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE74B6EB24
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVdHznVdzPpWoSNc6MFqinZEWAuT2WKv0ZYM01oCKd5koKel7F0ptA1D5OgO6xLBPNwmZeEuETus9ye+gSQ3dYgLdEWaA10l0hJcfW9K0wm6uVNWu0Kk9u4vfA+1T5LvZbeHtPVSiu+s4cg8o/tbGMWhwsPwvjxSiD6C+ykkWpZv+SIQVwt56OcIDzbaqZqNO4d1ir//aUYQSUfXgTyThNST52URSjmBfCa/bX5P5TrvLmfdVtG94whwsOId2CNbUxXuZROINwP/bVLrqIhG/UqGicPz/3kkOqzU6IqDVO7vSNb57YwYK2XWCxRIRN2tRvsxwbGtlUFtWwjOGK0QHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN/HXSem1Lh6A8xmF1SXefhx6G2FBHRtLq58kwkvuXM=;
 b=eK01zDFZkzigj4+YoioYgybKLsLfMRBoYECO1OUUEm3pXcKYlTReffEh4rl3X8enqNdhiXUeMvSD3hUtsWbvYeSngpDp+HvMouTafUj4/qlvoJvIj79W5w4cMqXEK1cc7vZZsR1nl7EOBVLu3B6WmazG5zfx9iGded7qyx1bbKcFHwlgxzhhR/T0PWLfrignWxI2Hwbvzw4pUgdcGKIoKSatVYpkvkJcnOyf4NKgPgBRNaAijVUqvk58Tbztm96wGKpdmlt36eJdDHhTMmW2hMuLhz1yTgq6q1lTqGJTt1md/se2YnAkRMZVf8uw0ZgkvSp2KHDDA9x+01i41yuFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN/HXSem1Lh6A8xmF1SXefhx6G2FBHRtLq58kwkvuXM=;
 b=e9VZj45+OqXp+4dBsCQ5GHCGXXY5IYUXQMAKgNtKL8HsjV93qRvpLFaYotnTMCkgHrPBcvc8VbfILpugSrUCsFV6PpGDxsst2zDnThBUvZ/TxhvXuGYqOQNcWZj/sWpAuqSmYukZy9G8xVB9VtCZoXnW2le2JorE+hOJL6MucS8=
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 23 Apr
 2021 02:40:12 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d3) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:11 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: ddc resource data need to be
 initialized
Date: Fri, 23 Apr 2021 10:37:04 +0800
Message-ID: <20210423023714.22044-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac269639-fb4d-4347-b4fb-08d906011e6a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798E065DBA73D9FD0EBE087FC459@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLk9BjGpoXBbww2QmLJmC4TDIMEXPOLiDgiN9Rw6AaRdKeX7zLtBb7/faThXgD+QUjXmnqsa8Yt6Gl8uQ2lFlUqw2HdAX8C5JdPws97pCBIMWHkkEDKbSnCpQMxVOjOlFr7lH7QpsSuMDXZJY2BIk6cBlss2C5sXaTQm3JeyS/vfy4uq9c2l9Vtfr493X564S93+ZyoofvTArQ3F/YYNL0Iw0S9Ndh6NcvNQ3sx9sNOw2XwAD88dG78WjRLw+Dma/nkmpcph6xcE7odwa3TbWZJQXBi7uwyYlj6KEnC5zN3zrL5WuQtOd8U2EMOLExCv8+VQ6lzP99sdCZ8SNijk7IjMPHNDRnhLU7mduFkMaLBa6ZKA7cpvrR8yIh/BaYDIC49AoH00PUO8VlsBFkTiCHA9BufFTrZexN66LNGy1eBlbgdr/ts1ZuLzD22fciAx3O3JWpiCD/+ej/pIBQVG1GZ9o99Eny5+HEDR+0nHtdjWiPy/YrrKWxd4edaSiZLC8JvZWrU7cepOzHOvSq1A12tsHBOxkwlZ+21GQXD8tkrDFGFlU42BejFTFX5vmG3UqNnK8GXYhpD/cwTjQwmv956dmLpfD/QcPGKdwRlSrw2xCjWJaIHsCjAA0w2QVU8mMT2spo6YxsPo5NnRw0K1dzQriBtdkoHMVz2+YKXbjItCC0pvrjusLqTwoO33uPoK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(6666004)(83380400001)(186003)(1076003)(47076005)(6916009)(8936002)(426003)(478600001)(36860700001)(8676002)(336012)(26005)(36756003)(82310400003)(2906002)(2616005)(316002)(82740400003)(70586007)(7696005)(81166007)(86362001)(4326008)(54906003)(356005)(70206006)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:12.3170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac269639-fb4d-4347-b4fb-08d906011e6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Eryk.Brol@amd.com, Yu-ting Shen <Yu-ting.Shen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yu-ting Shen <Yu-ting.Shen@amd.com>

[WHY]
to initial ddc structure before we use them to avoid error checking.

[HOW]
add 0 as structure initialization value in DCN resource construct

Signed-off-by: Yu-ting Shen <Yu-ting.Shen@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 527e56c353cb..6a56a03cfba3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3667,7 +3667,7 @@ static bool dcn20_resource_construct(
 	int i;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
-	struct ddc_service_init_data ddc_init_data;
+	struct ddc_service_init_data ddc_init_data = {0};
 	struct _vcs_dpi_soc_bounding_box_st *loaded_bb =
 			get_asic_rev_soc_bb(ctx->asic_id.hw_internal_rev);
 	struct _vcs_dpi_ip_params_st *loaded_ip =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 4a5fa23d8e7b..45f96221a094 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2538,7 +2538,7 @@ static bool dcn30_resource_construct(
 	int i;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
-	struct ddc_service_init_data ddc_init_data;
+	struct ddc_service_init_data ddc_init_data = {0};
 	uint32_t pipe_fuses = read_pipe_fuses(ctx);
 	uint32_t num_pipes = 0;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
