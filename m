Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D379C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109258F554;
	Fri, 22 Jul 2022 20:42:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE3F8F429
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9Am197bWWVHjWov7wjWaeE5tbhHujHZz7K/zBjdlpWSrpGCvTjEqclrxugmjpMjXExBkwjsCMDS4MUPERZ1l0Da+zvHWLblQcStW0Mhv3CU+GPAp+qOU1iVMp6Xbs7YFDETAr2mvRbX3WCorE5ATgnda5/Vfex15koc0tQp4Nink0tQ7rXUjhO12R0rdScDKPu1O6af79oNz3fxUOjH1tHa493J1wN5jzjEwLdbsc6rgw8RuijGSBuY8e7EutJm2/u1uU2VITclZ7sZ18hz8fpZGJnZzv+4/9kC1iTASnYl/Ezl86Fe86yEKI5PX7pxE+cEeQVmwecZtMfO39EzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN5w108jrfrD+zIiWOQhTS/3/sJm+pqdVgjsxMkj8x4=;
 b=AuVzcUKsVURSK5HmiNmk2C8Kps3BKyOQEhRLdnkUSINT8EWVFjHzuv9/Hd43KX1KRq9fv8hnWaU4zUdAcx603e9ecaXz8nKli3LFQpfSp7CYi30j6WN+yAV3Ym0bBn3cn+/to5BwR5QaFuteitGDKtnS/+liD94ADrUCGwliiEfDjO9o8l53/JURMGk5X2yvxV+W5MkLaP2fEK6hL3o8+IEnmscOz0kPkJxpixE4boQgeKHNnAmjLcIfd7L+WTRl7WSXb+AwXPWTOEjRv3i3mhvIj3uL4xtaF+S9mrC7GDME7i3X/4691tLqUc3wq5hntmVOo4M8vQLoKjrmncB8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN5w108jrfrD+zIiWOQhTS/3/sJm+pqdVgjsxMkj8x4=;
 b=QsTP/IhnaWC2xG/N0keiU9+rAvxlIiBzuTzjqI1TwyEPkPkE9aH5MOcopcpUyo4SDg8NG+5Nexkd1oldAR4BuOQyDncRGu+/DBbFXCAZb2PRQDoHDsbDlEPJIqr5T2lCv92iqvm7jILeIdzADpBziynIGHva3a3Zrn32fZNzoSI=
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 MWHPR1201MB0015.namprd12.prod.outlook.com (2603:10b6:300:df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:42:50 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::8e) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:42:50 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:42:47 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/31] drm/amd/display: Add dc_ctx to link_enc_create()
 parameters
Date: Fri, 22 Jul 2022 14:31:30 -0600
Message-ID: <20220722203137.4043516-25-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cb5d94e-50a2-4462-1c8d-08da6c22be44
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4paORP4mcucKuDn8NEYHmhzLfT3M76rhBm0KJnR3g6vMlNh9BJzW1161ued91jLCkLqld/ntf4Z6EPs/LhhZ/qQuQBOJVDii5xqhSFPKjY2JjD4m0PjHGBBkIgBApnMLbSRgHDMoBEQcBXm3hg0jQQYZ2mJoFQgPBDCFYoGD/DxzF5x1Jle1HwNVcWmzUaBxTOSOz8yhu73Wl8Bb+4EdPaSTbBwfkFyY02/a4y+CjQepIzrzGLe6uO+6tY8f5AdyGOHH2Pdsqa2bAOccGPfzf1/ajG5ZXU7/SQ16GrVz4chjqElW+e39h1Z3DX5FyLPv/x3n+YVe7V5wTxMRaUtsBveg1LF6t/f4FlZbjgv7gpsECK3vYXSl8Z+qZliK65OfsfbepSnK3N0tbme0i/0/gnjfDXkRwI9Jaj8LlT3CJt9OfIYbp0g1HCyDhhXuOHv6oJYZHqXmG0pKIlWaNsJ8qagB3xauO/MC3ZGFlACX7iD9lyhdp1NcVtloP9wd2/4Dp3X/F6GUS0fmX6orPYSMfFD238fTC8oB+O9B9CPXYjr6reQut9FVJ+GK3IRCGrOTTLAkE4w60E3w63SUn3hqJpnbJYNoq4VAzb81gPMSHSjr4XEzu5/gTdc7jnkr70VNZ+XxNnRSK6Bqq1UXJmrfKdY23nNWrP4LwzKkS0sXtKzSGwHtNvbh/VR0XW+lxYdm4g6zWhDcJ1WG3vQ4be5wBkvNT+VoZ86nDed9vOh2OZegpRGc447S8mPE9yRyOvw6cjX2PPoeo+FTQ0zkF225X97QQPmbhjNwIcUuhiZJadrzwL7tGNI9lh27BFKNTVkJy+ljkvs7zD7XKttr68UFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(46966006)(36840700001)(4326008)(40480700001)(8676002)(36860700001)(83380400001)(1076003)(478600001)(356005)(2906002)(81166007)(6666004)(41300700001)(82740400003)(8936002)(26005)(44832011)(30864003)(5660300002)(82310400005)(70206006)(70586007)(86362001)(7696005)(40460700003)(54906003)(16526019)(6916009)(36756003)(316002)(426003)(186003)(47076005)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:42:50.2075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb5d94e-50a2-4462-1c8d-08da6c22be44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0015
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 mark.broadworth@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Preparation to enable run time initialization of register offsets to add
dc_context to the link_enc_create callback. This is needed to get the
dc_ctx handle where register offset initialization routine is called.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h         | 1 +
 23 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ef54b96affa8..9e51338441d0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1703,7 +1703,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 	enc_init_data.transmitter =
 		translate_encoder_to_transmitter(enc_init_data.encoder);
 	link->link_enc =
-		link->dc->res_pool->funcs->link_enc_create(&enc_init_data);
+		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
 
 	if (!link->link_enc) {
 		DC_ERROR("Failed to create link encoder!\n");
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 9ad8ad4550d9..54805802cbd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -612,6 +612,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dce100_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 41804059550f..f808315b2835 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -660,6 +660,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dce110_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 62da6bc3094d..e179e80667d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -618,6 +618,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dce112_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index c4353a03b48a..1b70b78e2fa1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -697,6 +697,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dce120_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index dcfa0a3efa00..fc6aa098bda0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -710,6 +710,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dce60_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 0c3695e79652..b28025960050 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -713,6 +713,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dce80_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index e75be799012e..174eebbe8b4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -740,6 +740,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn10_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn10_link_encoder *enc10 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 1483de85a524..621767e994bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -925,6 +925,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 struct link_encoder *dcn20_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 7cbe1e9daa36..da0241e8c255 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -50,6 +50,7 @@ struct resource_pool *dcn20_create_resource_pool(
 		struct dc *dc);
 
 struct link_encoder *dcn20_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data);
 
 unsigned int dcn20_calc_max_scaled_time(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index e549a79f3fe1..407d995bfa99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -788,6 +788,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn201_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index d95875952fba..7cb35bb1c0f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1325,6 +1325,7 @@ static int map_transmitter_id_to_phy_instance(
 }
 
 static struct link_encoder *dcn21_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn21_link_encoder *enc21 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 8bdf3573610f..64320e0ca446 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -927,6 +927,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn30_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index a5df74110284..db172677d613 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -890,6 +890,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn301_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index f537888f4fa6..4fab537e822f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -891,7 +891,9 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
 		hpd_regs(4)
 };
 
-static struct link_encoder *dcn302_link_encoder_create(const struct encoder_init_data *enc_init_data)
+static struct link_encoder *dcn302_link_encoder_create(
+	struct dc_context *ctx,
+	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 76f863eb86ef..0a67f8a5656d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -819,7 +819,9 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
 		hpd_regs(1)
 };
 
-static struct link_encoder *dcn303_link_encoder_create(const struct encoder_init_data *enc_init_data)
+static struct link_encoder *dcn303_link_encoder_create(
+	struct dc_context *ctx,
+	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6d25fcf865bf..468a893ff785 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1093,6 +1093,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn31_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index b5672fb90236..63861cdfb09f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1262,6 +1262,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn31_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 1a5f5977f962..7463b12ae4a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1089,6 +1089,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn31_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 53dea466348f..d56a212e065c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1088,6 +1088,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn31_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 314dec5712b5..bb1d880eee1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1117,6 +1117,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn32_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 9ac0fcf79bed..73d2a653a279 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1119,6 +1119,7 @@ static const struct encoder_feature_support link_enc_feature = {
 };
 
 static struct link_encoder *dcn321_link_encoder_create(
+	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index e4b4102b1538..b3d0a4ea2446 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -96,6 +96,7 @@ struct resource_funcs {
 	struct panel_cntl*(*panel_cntl_create)(
 		const struct panel_cntl_init_data *panel_cntl_init_data);
 	struct link_encoder *(*link_enc_create)(
+			struct dc_context *ctx,
 			const struct encoder_init_data *init);
 	/* Create a minimal link encoder object with no dc_link object
 	 * associated with it. */
-- 
2.37.1

