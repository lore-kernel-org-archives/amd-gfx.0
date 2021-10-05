Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833DBC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533EB61507
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 533EB61507
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDCC96EB46;
	Tue,  5 Oct 2021 07:55:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3716EB46
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdBo6O4bviaitTK4QoXYxbABFJ6vqUF3masYPp3z1jY6S/zFrF1nuO4TuxjGEeIcos4pS/NkRJPDHSbzNDKbuThnwfGnr3IjX4m+DL90Frm7dYAkDKhL0nMCQRGAHgUyTsNm3XjxhyNG1EcM4UkUlb/D+0C6a15NJNyB39osu1ud/0E8tBvCgXc7lB77xyY1UVd27jTFg4+szC4erqfQkh1105M4QosFhiLZ0o/5YB6+K4QWcsZESD3GRgKCwE7VE6McOggA9+Ag3w9KPQkD4krss1tCTflHeSUklzq3As9Ul8RTtGXD9VPoGK2L36bHDdjymHZfJwSKvNwmW6Vfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkoA7tpwCR/c6RZtZi1tQ5LtvoyTCKmkl9E01MzKp40=;
 b=BLJ6gefL+t9JcomqsbtjdaeiOWmyeZ0npsmsR61WCk4AFL6hOth1JnP/IAR0q9XY1ZIA96DzP6P3kQ6k1d4yU2E6ETRpdxcGdPGhsnPaLb0eyemnA66jp0GIOMNQQBynQ7Z7aCHBiJ1y5/CskfjxBEWXDw2n1jjiAoZO9bn1rbCXXq4wTTswpGLWGG6IBDfsjV7FX70Xui2BFSN5Sx6IgErrau+w0Tp/4gjMyQiDlQc3qgzhAphjTwSplhHXTfXK6ymrRDlmyFm9VY018bDl6MCvwNeUaKWYobMEzHhGmURb4jwCm9qVn4BQLXyqmeUu48G7/iLgSn1u8zpATGd8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkoA7tpwCR/c6RZtZi1tQ5LtvoyTCKmkl9E01MzKp40=;
 b=FtlCVzEohOZQ6W6AnNDQAu3oUnpvzNxz1GEkPqtowJ//Cx5dwh5R7VK8s2YBXXZkJKU2hPsCWdjdaAKGzxf8126tX+PH25nxVTB6pD2laWg0X+RcgZt1mUe3nYByXG5HA97i98IPAu653EQHcltdriaH6ZaH21ZbaU5ijpLjkLw=
Received: from MWHPR13CA0029.namprd13.prod.outlook.com (2603:10b6:300:95::15)
 by BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 07:55:43 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::11) by MWHPR13CA0029.outlook.office365.com
 (2603:10b6:300:95::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend
 Transport; Tue, 5 Oct 2021 07:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:55:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:55:41 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:55:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 08/23] drm/amd/display: Support USB4 when DP link training
Date: Tue, 5 Oct 2021 15:51:50 +0800
Message-ID: <20211005075205.3467938-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eb38e11-cfe2-45aa-8ef4-08d987d587f9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3361:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3361B2ED78BD7CD0735E55ECFCAF9@BN8PR12MB3361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+flJ6f0V5hkHhoaVTXSpcZckv2m/0iNrWklvznJP6PRKI36LPDzoPgqNPrOubjZDr9OugUkiUUjHGuQlat7Z06gWVAsX+3qS4tgOAYijF+O8I0q2Fc8eekFQqDecHBq7ta6yLub/ob1MPzmrqtUYeoR28hYAIBQbRV+PuQH7F0zz/dJnU60ombcEqz1ze+T/awtUeXWCF01H3ePOhrIhP/CeOlGvhnPRyNZJh4JYN9h8Kl8u1HzfwULHcHdoUm6wGleyEHL6auLCT/BT5/IpraVSKsTohROz/EYXq/mTJ2R30jCwnOWinvRp9sv1HTJyCuaecx5VggpTYzVDM7rwy4xcfQI787bKQ+utsOujrFQzfRZYbRLQb8GQy37oRAhX/VzTzpIuuhYqso1RhRG0jCerfGKPK7IeF6YwcpC29J8ThLNTdvSWRjQ/Kz1mZridpyeXJ0oa5OYno5Ja/gqakG0jG5kt6pijkd8JZNtWcD3bX42UCNnEMqkO3NBuYOexE1b2u9+nyRA0MGWibnGEesg83I9MpssVgjcEo/BZuPEbpRiZZAoz9TOUd3AoeiUOjeZPqw9rH2apINucrA19Et/dGs3nydiohXlQ4CvpC9yE/YEm4QY28b/NMJG4eKkK5OYfliag6AiycbuNq49eC948EjWMzVzmPQJ7afFL4vwOAjHmUhmQ/zfqmotCmfLHAZlQKT1eFHztd0McJ2hDY0vL0H/i2rsgx5+bOJOHKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(70206006)(8676002)(36860700001)(54906003)(70586007)(47076005)(186003)(508600001)(7696005)(26005)(81166007)(36756003)(356005)(6916009)(83380400001)(2616005)(316002)(4326008)(1076003)(86362001)(8936002)(426003)(2906002)(6666004)(336012)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:55:42.7079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb38e11-cfe2-45aa-8ef4-08d987d587f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3361
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why & How]
Add codes for commit "822536713066 drm/amd/display: Add fallback
and abort paths for DP link training" to support USB4 DP tunneling
feature

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    | 6 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1c397d5551ba..6b5ddf0a29c1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1862,6 +1862,12 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	/* get link settings for video mode timing */
 	decide_link_settings(stream, &link_settings);
 
+	/* Train with fallback when enabling DPIA link. Conventional links are
+	 * trained with fallback during sink detection.
+	 */
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		do_fallback = true;
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING &&
 			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index dd1d0262ba40..d7dddc0998db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2408,9 +2408,9 @@ bool perform_link_training_with_retries(
 			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
 			return true;
 		} else {
-			if (link->is_dig_mapping_flexible)
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
 				status = dc_link_dpia_perform_link_training(link,
-									    link_setting,
+									    &current_setting,
 									    skip_video_pattern);
 			else
 				status = dc_link_dp_perform_link_training(link,
-- 
2.25.1

