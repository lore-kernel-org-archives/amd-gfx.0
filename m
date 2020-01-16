Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7759DC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495B620663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fXi3dX65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495B620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060876E489;
	Thu, 16 Jan 2020 20:14:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F456E48C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I89zuWAzdHZ1z3vN7wt5kJGCcKahFlnKQzlrI4x8P3NqDupDmZYOY/cXv2tTVXFgPk1yZTLwdL+6P8oO5CU2jaXrYuElKQzXlsVwfG8CuMAaauXKs6cJeA/fBAJxoFj0yrSnvpjYlJTykEqEbJzHR8OiKlUlFfC7rQGH+79RsOfCDWwhlHhe8wz10+Q98fDe7z52V7iuYrOkLhy6dATDa7A5Eadd0uhVE7Vg8qoczgEOTtjuRIPean1592nMjyMZHGMeUqTAMRIcpdlt5ORWksSHsqaKzlhrk1qdvLHrPBvLue1hDgEu/jOymOf+hSey78H/aWi/LHJ5lw2OlPeoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GTmAr0JWR4jEDAdUJvUAC4Sv1MFnuUYJmPo8t2QehU=;
 b=SgxY3gU8J56dDKdpAGmdPuw/YaS0zTSzY+YUhtUtV1dvjBaXnvoAn8dXkUc7fxzAiqbYwwv3b4PRwBQbsGiZXT37fGIVBxnLdYPvTYhdsp/X+qF30RGvy0fhwcZKlc+/+VdJh/Vg1GeFjF+lJfH/rkob99ZrdtlFCKKgJ6/6XQrk0J7NpDNUF2IT//oZ7bTo3u6N6mmVXsAOhH+Cp4o4zK118SIB0Vrk40ye07rEXTPbiej5QtnEhm1iWtfLCVBy567u34n0JeipXmZhd+srsZWiaWWC4vRRLme8NTtDnyGiHzCNmCkMhAL8kmfm3kbwLZMjskSirKsvWQuIw0SqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GTmAr0JWR4jEDAdUJvUAC4Sv1MFnuUYJmPo8t2QehU=;
 b=fXi3dX65znKjTbdF3WMZnQsXkmip2MPZPTnsuDty0+31tzunrMTT0P+CdOqleu6hWKeNdqJwNthw/k7riRSy4e+H9h8N/qVxN8IclXCJea1ltBImOexlsZapGeNPb98j0lOyYoqSVGjnBjGxMaYDDNaTfG47YF34+GXC0pvCM4o=
Received: from DM5PR12CA0007.namprd12.prod.outlook.com (2603:10b6:4:1::17) by
 BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Thu, 16 Jan
 2020 20:14:34 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by DM5PR12CA0007.outlook.office365.com
 (2603:10b6:4:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:32 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:31 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:28 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:28 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/22] drm/amd/display: fix rotation_angle to use enum values
Date: Thu, 16 Jan 2020 15:14:09 -0500
Message-ID: <20200116201418.2254-14-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(428003)(189003)(199004)(2906002)(336012)(70206006)(70586007)(86362001)(6916009)(478600001)(7696005)(54906003)(36756003)(356004)(6666004)(186003)(316002)(26005)(4326008)(2616005)(81166006)(81156014)(8936002)(8676002)(5660300002)(1076003)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4196; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bf44e92-ead5-46bc-b4a2-08d79ac0b2be
X-MS-TrafficTypeDiagnostic: BY5PR12MB4196:
X-Microsoft-Antispam-PRVS: <BY5PR12MB419689B07EC31F3FECA0367FF9360@BY5PR12MB4196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGZ2THNZhpYSZuwHt9jhSHLFqKkc3f8cGBlhc7Lq/Wcy/UMU05tDjTYxfFC/8wNO1xBUwamlwKdnsbt3+hUhUVzdHngdbJrDenThHxf0jmsphv9sFD5RJBw+QyHr24EcfIB7csl+0JtnYgW+ItBXfmFL4M6YlKbyjJWuy3nL+VhC51EDp8Nhtu/FP+h7H1YDBRCOZ1k/zoFb8oGHq0c60sPgStN5lEzPLJ0SBwUb3A1eEbyUOflM83Te5nF8Y6t5Y+UPcXeTGzyvDU3f9ceXyonC2a3Wabtv+RoiJbNrrZvc/EHOXRRTOPBNC3JMAX3BBU2rWkbGLwDvv72bTTgKK1GaPWWhUvJS5oFzgKRYMHmRfEgJyA6NShxQ8VgkaIJEKnr9zQdjfgkXbkB8Gpl5fqw4vWM3Gjyelly5SiBuLMIRGnnPRhkUyt7d+ntIsoev
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:31.8423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf44e92-ead5-46bc-b4a2-08d79ac0b2be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 Brandon Syu <Brandon.Syu@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brandon Syu <Brandon.Syu@amd.com>

[Why]
Hardcoded fixed values are not proper.

[How]
Use enum values instead of fixed numbers.

Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index da63fc53cc4a..cf09b9335728 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -261,28 +261,28 @@ static void hubp21_apply_PLAT_54186_wa(
 			address->video_progressive.luma_addr.high_part == 0xf4)
 		return;
 
-	if ((rotation_angle == 0 || rotation_angle == 180)
+	if ((rotation_angle == ROTATION_ANGLE_0 || rotation_angle == ROTATION_ANGLE_180)
 			&& viewport_c_height <= 512)
 		return;
 
-	if ((rotation_angle == 90 || rotation_angle == 270)
+	if ((rotation_angle == ROTATION_ANGLE_90 || rotation_angle == ROTATION_ANGLE_270)
 				&& viewport_c_width <= 512)
 		return;
 
 	switch (rotation_angle) {
-	case 0: /* 0 degree rotation */
+	case ROTATION_ANGLE_0: /* 0 degree rotation */
 		row_height = 128;
 		patched_viewport_height = (viewport_c_height / row_height + 1) * row_height + 1;
 		patched_viewport_width = viewport_c_width;
 		hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
 		break;
-	case 2: /* 180 degree rotation */
+	case ROTATION_ANGLE_180: /* 180 degree rotation */
 		row_height = 128;
 		patched_viewport_height = viewport_c_height + row_height;
 		patched_viewport_width = viewport_c_width;
 		hubp21->PLAT_54186_wa_chroma_addr_offset = 0 - chroma_pitch * row_height * chroma_bpe;
 		break;
-	case 1: /* 90 degree rotation */
+	case ROTATION_ANGLE_90: /* 90 degree rotation */
 		row_height = 256;
 		if (h_mirror_en) {
 			patched_viewport_height = viewport_c_height;
@@ -294,7 +294,7 @@ static void hubp21_apply_PLAT_54186_wa(
 			hubp21->PLAT_54186_wa_chroma_addr_offset = 0 - tile_blk_size;
 		}
 		break;
-	case 3:	/* 270 degree rotation */
+	case ROTATION_ANGLE_270: /* 270 degree rotation */
 		row_height = 256;
 		if (h_mirror_en) {
 			patched_viewport_height = viewport_c_height;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
