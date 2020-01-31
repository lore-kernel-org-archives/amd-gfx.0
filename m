Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B12C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CACF2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ygKO0uTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CACF2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D996FC36;
	Fri, 31 Jan 2020 22:17:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8296B6FC32
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFznxjVdmnNWfHL2vsJuBpe+ef17MWRBL7KbSMnFh760mhe9rEnh+lMIvJZ+asXwcnBUaXR8Rso0V1cVCwiREqJKDzJSZTG678MB8aVPrQ3WJ9ondiSyFoXGAQv4dfGjEwu5BlTvExOM4CdX7U04M6GmnmMno2829wX+hMUZZOPhMf8IPjr4obNLX33sa0RocivgGMbRT+PzbAoq5i6RtUSPS6b7P7DYLIn02NKaUQNyhDoSnSutUH7uAsM/acvld41btLtTBzJuDl59gQexmWJJ3OuAOAdXb+Lx92oiI3QZc7XZnQ3giphmLxhFhld9rYq0Om8IIlmsPS8YYNcXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l+0H8/+EJJC8ZiEJdn4Ed9MIkFNB5pK5OIE2iJGyhQ=;
 b=bb60NhwD89nRt/gkyyT84ltBxW+gjeyOF4tu1Dc7kkdBlj3HbPJwQIdegNAJydrwN1Wpx9yxDcSIdNSXlvygXTWVfbiXBcMZJWcYr+6de5DHgIV5vjQG8RZXqHzBJ5rlF8weTcVd4OkFLuf3qlwUmOxuoDDdhtLqD7vkqO2JV95Ly5c40vTmkmWF5JFu9sSG2wYPh2YnatUCq2tIQzutmlh2rI8/oa6TJS7zI0CIuo1gdhG23YWCZsm0wzdcno9RqQnZDYOTo07k9OtMnsc2YPeXKsfDM358g+1gl8LWT9DfA/6LAqYQEUGkE+hLU915N1/V7HQAlnZ/ujKNSu3uCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l+0H8/+EJJC8ZiEJdn4Ed9MIkFNB5pK5OIE2iJGyhQ=;
 b=ygKO0uTlUKOLnxxl71x/5j0l2LOeVSbJojx0HlcdSgZYGvEygasKNnxO3kJq/pLklQNmndl6lfPmw79smGkeFIYwfvPYCJq3YjimqwMVKlB0bYL8B8TEMkat8A7GN934QGKF1GY6tW+89YMMMP/rV3yjYFT4Xg+f5qonDgjcxnA=
Received: from BN6PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:405:4c::29) by MWHPR12MB1566.namprd12.prod.outlook.com
 (2603:10b6:301:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Fri, 31 Jan
 2020 22:17:03 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::203) by BN6PR1201CA0019.outlook.office365.com
 (2603:10b6:405:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:02 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:00 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:00 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:00 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/33] drm/amd/display: Move USB-C workaround to after
 parameter variables are set
Date: Fri, 31 Jan 2020 17:16:12 -0500
Message-ID: <20200131221643.10035-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(428003)(199004)(189003)(7696005)(8936002)(186003)(70586007)(356004)(5660300002)(316002)(1076003)(6666004)(54906003)(26005)(6916009)(4326008)(426003)(2616005)(36756003)(8676002)(336012)(86362001)(2906002)(70206006)(81166006)(478600001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1566; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e67e830f-7717-42a7-d61d-08d7a69b4c41
X-MS-TrafficTypeDiagnostic: MWHPR12MB1566:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1566B5E7F19A236E2A380E44F9070@MWHPR12MB1566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qc0BXF8E1FvrduByp9MNb3Hmoif4yPXzt4hJO3TmwgvZyhEqfhkebPLBebBOJVoHnmGcfdMmdDwgyvGH4T7nftKMc4GMvZ58Y8iy3U/LHUAD3ssW47Vejk4EqoCzC+quKe9u7Z1V3nKak1ZUeSpZicksIIqeO3N2o7fXgdDrW82yt2a0rLKjZ2Af6tLfM+pAapIHAPWqOyQA/RjUW+rEE3jxucPNc1yikrONR8qfZOBjtOrI0OkhRAP+qQ9H4Nzk1QYfg34WB9eUv4l5BvUqEu69FJYSaEJyFLfd042T06qWo00VY/BL6Io/iNas9xLsXozZ/4km+eCckqk51zmjbAM42AwYfDIzlLmg/kAsQFK0svptZDp8BwjnFcngh17sOCumoc17JPYRZ2hD40T6MCcPz0hLkDpLKis3JQngVWY1JK4/49O0ySxg6NplHeKr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:02.5308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67e830f-7717-42a7-d61d-08d7a69b4c41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1566
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 George Shen <george.shen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The call to dp_enable_link_phy are using default/invalid values for clock id
and link settings.

[How]
Move workaround code to after its parameter variables are determined.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cb731c1d30b1..8ff0f5b7104b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1892,6 +1892,16 @@ bool dp_verify_link_cap(
 	/* disable PHY done possible by BIOS, will be done by driver itself */
 	dp_disable_link_phy(link, link->connector_signal);
 
+	dp_cs_id = get_clock_source_id(link);
+
+	/* link training starts with the maximum common settings
+	 * supported by both sink and ASIC.
+	 */
+	initial_link_settings = get_common_supported_link_settings(
+			*known_limit_link_setting,
+			max_link_cap);
+	cur_link_setting = initial_link_settings;
+
 	/* Temporary Renoir-specific workaround for SWDEV-215184;
 	 * PHY will sometimes be in bad state on hotplugging display from certain USB-C dongle,
 	 * so add extra cycle of enabling and disabling the PHY before first link training.
@@ -1902,15 +1912,6 @@ bool dp_verify_link_cap(
 		dp_disable_link_phy(link, link->connector_signal);
 	}
 
-	dp_cs_id = get_clock_source_id(link);
-
-	/* link training starts with the maximum common settings
-	 * supported by both sink and ASIC.
-	 */
-	initial_link_settings = get_common_supported_link_settings(
-			*known_limit_link_setting,
-			max_link_cap);
-	cur_link_setting = initial_link_settings;
 	do {
 		skip_video_pattern = true;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
