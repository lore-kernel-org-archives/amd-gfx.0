Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E464C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F121920663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SodQPjuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F121920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17C76E250;
	Thu, 16 Jan 2020 20:11:28 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0ED06E255
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hstd2//OtTb1peyO5IoUdOVWsUDpAdZ89ydBMVxnuweK//8HitUughXs0M7XKytEDOF3XKh2e95S1bGeI1dwPG46MMFlha1iFeLSxIod4Xu59Y/bUQOwFrxAQWkZ5nIiX2QB6P3RhjPY4l4MdGNRj6Q5xSkqmFlGi0dwPkOKWSRivhnjJ4sM3NjQVbSu3TJtMrLvX0MaXUCFNWb1CJFdCpeXMBVr4GQnFrp/wQ2Sc0gsEw2SHiqJKfM90U2W2rVxNWeRi5L3Q47y/0093kXIka7KnJ5EahHcJK5izo80P2wJdrIzdwePLM2DZM8cWMMRngSsP6qTPxXFaPs2Y0IUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4xgF3/hC+nLZm/Ngw/TnOVhqLV2A+SD41nYh1a6ODw=;
 b=Udnd14iIZCjP0eabmHMEXIELkmurfaeDx/2BA1Bz5XkLY+3KFY0isWvqHkV45CsW+jksvD+heDeLOsFl6nytXYrHMRs8U6/67K6kjCDrOVJSiHQPTbFQk6KybyJPZKlsZO0wEB5Swtqqb77KWDuIiOts2JF3z3XlO8rqXYOGblb4wK/tBc09gqEK3F59bGZoxnEfXSMzAvUD9KsiexA4JTCyMl4Jd2DRMWQyo759Y2Q3SPAF+JPx8mZn8iRu1a/nrX1DDjI2osqOTFKj4CIr4lXGjgxqSU69QJhltRckSFV49yKMK/bTvodORqK3IduRbeSK+Ti7pKOimMDiXjvzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4xgF3/hC+nLZm/Ngw/TnOVhqLV2A+SD41nYh1a6ODw=;
 b=SodQPjuVirkJzCN5l6H7y9YGTrvxq1LOrZImdH9MPe35CIkx3bF2wpL/auTxLiclF0gtbxv8jygSKuLz3RagXdpM4/UaBe7KH9Y+L4CSsufp6ayn44gvUaC2wa6lOv8+Pfozi5O0pGAthIV/+PB9uHCrFl7VH7cihkYBN4TAeEk=
Received: from BN8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:60::19)
 by DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Thu, 16 Jan
 2020 20:11:27 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::204) by BN8PR12CA0006.outlook.office365.com
 (2603:10b6:408:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:11:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:11:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:26 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:26 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:11:25 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/22] drm/amd/display: Add debug option to disable DSC support
Date: Thu, 16 Jan 2020 15:10:39 -0500
Message-ID: <20200116201058.29200-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(428003)(189003)(199004)(86362001)(8676002)(54906003)(356004)(316002)(6666004)(2906002)(6916009)(36756003)(81166006)(7696005)(2616005)(1076003)(81156014)(426003)(336012)(478600001)(26005)(5660300002)(70206006)(70586007)(186003)(4326008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1131; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 959b27b7-8f4b-482c-c6ce-08d79ac04465
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:
X-Microsoft-Antispam-PRVS: <DM5PR12MB113111B0A0E98962231E3623F9360@DM5PR12MB1131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t28nZqAiguI1AezwZ3k+fSyKqn4SBTAISX2fcTdejDsXh3qzhcAoSRwKlGnpZCHbMbnCHnMjSd5/VKb4KbHjhr2dcQqEKR1AdiazF99IIa2SKu9bpSrL2t8x12d/CeUbJzSq5+5Avby8Sbp1sEagXKd3/ACYxYOXGs7FUVgmv/Jy+PM/yZvLgUooXla6ivuJ0/ze0K1hrmR7OdVkkEhiKdKRBFxVbajt14JE6QPPheOA8PnjTl1/Dz/VAj+ie52EFmbobe+4fQ4yXLw6JjXQedFwzOVTmJVv6/GkTjpgtUv1LwCn+SnBbfEZH7n1jCrZ9Dq/jX0oyuy6eZAHopThkV7wmiNTna7VB3p8Tigt3e75kl86982OhQv/gAtcSTLOULZ+5v1SyIkdIpcKuSapLucS4ozYMpgjKiAlhj+EhGQ0dqi2Kvaf4mhGjxOouinq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:11:26.7172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959b27b7-8f4b-482c-c6ce-08d79ac04465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
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
 Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[how]
Empty dsc enc caps when debug option is set to disable DSC.

Change-Id: I95e63c63bb0513a80144087c8327dcdcfa23c494
Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
IP-reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h         | 1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3fa85a54360f..7d31dcb9e37f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -425,6 +425,7 @@ struct dc_debug_options {
 	bool validate_dml_output;
 	bool enable_dmcub_surface_flip;
 	bool usbc_combo_phy_reset_wa;
+	bool disable_dsc;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 8b78fcbfe746..87d682d25278 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -224,7 +224,8 @@ static void get_dsc_enc_caps(
 
 	memset(dsc_enc_caps, 0, sizeof(struct dsc_enc_caps));
 	if (dsc) {
-		dsc->funcs->dsc_get_enc_caps(dsc_enc_caps, pixel_clock_100Hz);
+		if (!dsc->ctx->dc->debug.disable_dsc)
+			dsc->funcs->dsc_get_enc_caps(dsc_enc_caps, pixel_clock_100Hz);
 		if (dsc->ctx->dc->debug.native422_support)
 			dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
