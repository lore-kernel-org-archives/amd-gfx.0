Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4F9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB93B610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB93B610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 716836E21C;
	Fri, 24 Sep 2021 19:10:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1C36E216
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm3CkfRJ0VivdlwWLOSkWRTg1Jc8lBi6iq49PjgsCJeEeFceKUNPVoEiovQUOyECoIsqDc7y7/iB4q+xQ8bkxZAJJ2TIJIkNqEBdUo7FXlDx+IGbhhZ55g5zZhe5DA2szX5CnoR7N7Y8hDbufBEoHEAEZkzz5Uif5enVNNUCe42A67Ic0ieIqhmBhh8SbBzZRtQdeuTlqnDBLjRxI+xIaxuHLwzptYrrOvFfe1Xg90m1E8Z2sxqvtZt919NCiwGm94vQAChqRWtwmwiYWd6hZ+6dMuuuIM7KqlzV4+IZ8ftloa/0Yi1my6a9IjxyDHxNN0HXREzlqnc6RbCpWOAwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Vb7ZuR7Df5m8zPqO1RFOamWub3a4T9SIu24Q7TZnf/w=;
 b=L9Z4UkxfNJuv92UG+0xazqOceeuPJAzY6cQyKu41bO5AU/bMYCXB1lTsWSKE+SxUgp8G/52mImeXBXxWtp17sK16yMAIJOUP3IDiaCZFkLHn6xw1u11FyWmEVUIjuupAGs4DxNJraUSpkh4v0Duc7rQcQ5XzfFM+yNxtes5aYFSPDvjp2YD0qf00P+ixonrBXiBRTTtR4/yr/OkgAEz3gvNKX+4uP0MsYMRmEh/gnsXsuUPiLmeOjQQgzDq3+ktVOuZsb0RhisAzl+l5Jw79jH2dwMTQ0ivHUzJ3KZ43nNZpJJuS8QPR5yw4k1iB+IaDB+b24x/iM9gmeqxjhKatKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb7ZuR7Df5m8zPqO1RFOamWub3a4T9SIu24Q7TZnf/w=;
 b=mDRoPDni/l6YuJcB2UhLU4rWTm96KDw+x1arF2tUbp4rIIjFP6HtL57YCihLdjVurTlHm4ZSQ/tcTybZ2fNNcpp7w1qds4M0ziGZ9u0IYbbXJlrkwCi005ry/6zFqstbWxL7Tyaq3VBLX2DkWqP1oRFdQrZswf37IEwtXWs71sM=
Received: from BN9PR03CA0453.namprd03.prod.outlook.com (2603:10b6:408:139::8)
 by CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 19:10:17 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::17) by BN9PR03CA0453.outlook.office365.com
 (2603:10b6:408:139::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:15 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:12 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Oliver Logush
 <oliver.logush@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 15/24] drm/amd/display: Add an extra check for dcn10 OPTC data
 format
Date: Fri, 24 Sep 2021 15:09:25 -0400
Message-ID: <20210924190934.1193379-16-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca5b292-43b5-4b01-a34b-08d97f8ef18c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1829CEC102B9EEE9A70598CEEBA49@CY4PR12MB1829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R74RVMLYR2JpPyXofvMMU3BbYI2hj06uRy5nDCW4Ob7ySkTOEGdZRD3OjFe49xMGhfPaFXZl+WqsDSlmhalWLMt4L+2sLzeTnnCoqcbOrliflJlbGM4LGkJ3dbxQmP6Oa1NxbQ8mt1A4ajrx6DoaUj/V3gpmkD5hQYU1VbubXQbWroIFSfIsZ6I8aR4O7uTUXVuWn5o880lmM4RFImgplLCwTN/lQYi9o6AQQ+u7fR4iy7B8f+cE3JuPPQxXtX9nrrXKfTP/fM+y/VYta1EWKm+8eqtue/sBJpkxnZCpjKmbWp4gOdyWPsYV+svNEgNqdQopyWybjN2SaWhl7DhmZoOAVdFId0mRQ45GRMLD8hoO2pqLYe6S8kYGjw+5AOveLqURlnu0+bwauEzp8soyCdjyW66MUcGMIO5OEY8XEfdJ6rDRKjbi21qGCOv+IM5ZP0LOjnHaYF2cnoquqIZ9QglUtgpyWR49RmHbYrLJsb5yYJo/6eNPJ5/hwjT+VVp9sIaqBHpfTYywRL286e0PwjPWox43Exaoyvsry8gGpQRSeNucfAz1vkDWBD6kPg+VsuAhFdsjP2EmmEP9aMbkPqbLrnMCvXVBXHZ13tauYd7bGzL2IqXXG5NQg5rbrGFiKjHuKsKiq2+zkhOcPSBxw7YX4a7s9yrzjrienSXL6iWixZF9FCnu+RU1pG7f3wG6u/xwhNEh9KD+3YkBRZz710wG0o4M0d74pzcbCHfcH1g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(8936002)(316002)(356005)(70586007)(70206006)(54906003)(47076005)(8676002)(7696005)(82310400003)(4326008)(2906002)(5660300002)(508600001)(2616005)(86362001)(36860700001)(36756003)(1076003)(426003)(336012)(186003)(6666004)(83380400001)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:16.3825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca5b292-43b5-4b01-a34b-08d97f8ef18c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
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

From: Oliver Logush <oliver.logush@amd.com>

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h  | 6 ------
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h       | 1 -
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h
index f0e0d07b0311..1ca4907b144d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h
@@ -62,12 +62,6 @@
 
 #define CURSOR0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY__SHIFT	0x4
 #define CURSOR0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY_MASK		0x00000010L
-#define CURSOR1_CURSOR_CONTROL__CURSOR_2X_MAGNIFY__SHIFT	0x4
-#define CURSOR1_CURSOR_CONTROL__CURSOR_2X_MAGNIFY_MASK		0x00000010L
-#define CURSOR2_CURSOR_CONTROL__CURSOR_2X_MAGNIFY__SHIFT	0x4
-#define CURSOR2_CURSOR_CONTROL__CURSOR_2X_MAGNIFY_MASK		0x00000010L
-#define CURSOR3_CURSOR_CONTROL__CURSOR_2X_MAGNIFY__SHIFT	0x4
-#define CURSOR3_CURSOR_CONTROL__CURSOR_2X_MAGNIFY_MASK		0x00000010L
 
 #define IPP_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 37848f4577b1..3d2a2848857a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -304,7 +304,7 @@ void optc1_program_timing(
 	if (optc1_is_two_pixels_per_containter(&patched_crtc_timing) || optc1->opp_count == 2)
 		h_div = H_TIMING_DIV_BY2;
 
-	if (REG(OPTC_DATA_FORMAT_CONTROL)) {
+	if (REG(OPTC_DATA_FORMAT_CONTROL) && optc1->tg_mask->OPTC_DATA_FORMAT != 0) {
 		uint32_t data_fmt = 0;
 
 		if (patched_crtc_timing.pixel_encoding == PIXEL_ENCODING_YCBCR422)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index ec28cb9c3a8e..9ccbb2b519b7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -171,7 +171,6 @@ struct dwbc {
 	bool dwb_is_efc_transition;
 	bool dwb_is_drc;
 	int wb_src_plane_inst;/*hubp, mpcc, inst*/
-	bool update_privacymask;
 	uint32_t mask_id;
         int otg_inst;
         bool mvc_cfg;
-- 
2.25.1

