Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9BBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BEE510F369;
	Fri, 17 Jun 2022 19:36:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1161610F3D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzchQxk9jWrj74hy6jNxsbvGBU9iC63cVPYkhze7C0wjaumUdjGBVIsRKsaZfbzSG00wk76Woct+WhiDW6aguKxv+EMA4FXUB2UFNRQaXIkP6+B1KlqP0Zw46A/ciaWrbDGsopOIia84jDdEQak2na6A9oIfK9q76XFRh+O/3eh0N1oyOmB1w0aGiEcj+H9GYurF9Z+WrTmeAkmxrPKx6+6cW7oh/h+qy5y5fPkSjhcgfMv98KQz6plhM2P7MCQsGbthoA9nJhb36LR2j2GpeQwDIA1d18SYWrimA7EEEdxCiUxbxNSZdKokTbMSGEbw7000eGD9TjRV1qTo/jrj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBvrIQyOVcxhs/ruGTgagkbR5cV1FLewvV1CqIQX+Z4=;
 b=k1JVzVo/RGkJKnHt57B+dFQ0FkXS4VXR0YxLdXofAPJwgWZlz2bZaXk7BSZ1yR83fzUKDb2h7s+BROzftUV+kqf+TQoJOnjuBMlVCT+fu7PmGtrI1L6iPz/zDi7QVzikW6B3DIk+ofy6hbLZGbcho1FQTUBYx+PvViXNB42O3ljfkLQh+upcSJ8avszjf+obhzFcy8uQzTImDMscXTOR+cu51n3UBPi08D3y5meA3bC34Oqyw8Lrn4FeVmhJdfr8a8WsliUM9/wWjnJEtxkJdVFNXTqSdngDAM/cTVvcQqIHj7fcipYOPoxw7L+CfCpWG8AjB066o0KTLYaCvEcQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBvrIQyOVcxhs/ruGTgagkbR5cV1FLewvV1CqIQX+Z4=;
 b=2jdBRWA0M6EPSgPJ01FQ1k/oNqlRAG2KOUVsBoGiz1Dv6oUHY6ZRhMQQaSnnB5a3LZLbGSAo2WPsUv1qcYXzcpdWxVObobeNr1d68k5VOqZz/5zHZwcJSojU/PGOnIUjUY8LAglEIH3arCrD+G6VmDzvkxbtbZg/zkYM8dgJhhs=
Received: from BN9PR03CA0260.namprd03.prod.outlook.com (2603:10b6:408:ff::25)
 by BL0PR12MB4612.namprd12.prod.outlook.com (2603:10b6:208:8f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:35:53 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::4e) by BN9PR03CA0260.outlook.office365.com
 (2603:10b6:408:ff::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:53 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/31] drm/amd/display: refactor function transmitter_to_phy_id
Date: Fri, 17 Jun 2022 15:34:57 -0400
Message-ID: <20220617193512.3471076-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7a0e2d3-765b-4ebf-05d6-08da50989788
X-MS-TrafficTypeDiagnostic: BL0PR12MB4612:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB46128DC3BE850098C45A8B7B98AF9@BL0PR12MB4612.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkMK9Dk1e//2VRtCIM1sfSPSKr1WCf3o1EDk1u+EwPbbCMheaFzi4j82NexBGKXoOiMUHHYJ7v184DqdzPo92yG3n4ibVZjvzIxr0Ev+hDhSc++1WPqRg0NBGTpQuoy4/N5ktS9n59MeEBo9DvfcPMkYaHHu6l5Tmm1xjZEJh4Ybi/9sYN5ePxs17yMc91BmcasWiqTvKlOH+RfNY7xSbBoq1nUMZtCx036nMtDnN7rJbnOc1nKMxlqaHNb2OWpAHV69jKxTk0P/349QQUD79B8J12cKUnykn4zo1v52RTBEg2DZ9rX+qdNJKAE2CWe5/4glEm/JlPsaPrVHZpGeJezu8/fQBomCCW3WU8vu0OpJk+zmfpnkNwNA+cu0ardbE/2GDqM4Beb+Nr3YJy7C11R+B0zLqu+CoM/EF9nsHuFLfcDygTO4+2dBH+7lf9PMJlCp60abQbRI+ASIzqc4m8RzqthBTpeBMvRNUpbZDUV/8TydjuwGyvOBPybbw6R/2BTy5IovGKr0E6WmT0kgJX05UgrdhYGKYr7DDmvbxVfpcGfEqPt9e2E0+c8ZAm/9vxgAotM11cGPcDRyCA5zuI++sAzsu6wKf6wAbDyd72rEIC93W0H41deNhr4aYIou9POqXqw9ppFEWYT0tXC0WP10LbA/+C2JrI3SvlDFpFsPVB3HvaYamfWEmGz2Gem1ZsrdADV1zl2v11fPaCxX4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(316002)(498600001)(47076005)(54906003)(2616005)(5660300002)(86362001)(16526019)(1076003)(7696005)(186003)(26005)(70206006)(82310400005)(40460700003)(336012)(356005)(8676002)(4326008)(36860700001)(6916009)(36756003)(426003)(70586007)(2906002)(83380400001)(81166007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:53.3090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a0e2d3-765b-4ebf-05d6-08da50989788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4612
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Nicholas Choi <Nicholas.Choi@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Nathan Chancellor <natechancellor@gmail.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Choi <Nicholas.Choi@amd.com>

[Why & How]
Since we only need transmitter value in function transmitter_to_phy_id().
Replace argument struct dc_link with enum transmitter.

Reviewed-by: Chao-kai Wang <Stylon.Wang@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 43b55bc6e2db..58882d42eff5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3185,8 +3185,11 @@ bool dc_link_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
 }
 
 static inline enum physical_phy_id
-transmitter_to_phy_id(enum transmitter transmitter_value)
+transmitter_to_phy_id(struct dc_link *link)
 {
+	struct dc_context *dc_ctx = link->ctx;
+	enum transmitter transmitter_value = link->link_enc->transmitter;
+
 	switch (transmitter_value) {
 	case TRANSMITTER_UNIPHY_A:
 		return PHYLD_0;
@@ -3213,8 +3216,7 @@ transmitter_to_phy_id(enum transmitter transmitter_value)
 	case TRANSMITTER_UNKNOWN:
 		return PHYLD_UNKNOWN;
 	default:
-		WARN_ONCE(1, "Unknown transmitter value %d\n",
-			  transmitter_value);
+		DC_ERROR("Unknown transmitter value %d\n", transmitter_value);
 		return PHYLD_UNKNOWN;
 	}
 }
@@ -3331,7 +3333,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 	psr_context->phyType = PHY_TYPE_UNIPHY;
 	/*PhyId is associated with the transmitter id*/
 	psr_context->smuPhyId =
-		transmitter_to_phy_id(link->link_enc->transmitter);
+		transmitter_to_phy_id(link);
 
 	psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
 	psr_context->vsync_rate_hz = div64_u64(div64_u64((stream->
-- 
2.25.1

