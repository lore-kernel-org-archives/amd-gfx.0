Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF3CC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7D820663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3qXkkqG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7D820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154C66E25A;
	Thu, 16 Jan 2020 20:14:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41AD6E25D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDEfYfMYwV/KcPfJgrs02Fq/z1LmFe72fMbHJJ8HgnevLNlzPEUS1YRMYXXKvSX5HUY/4hHFOCvFmeyEH42ATT9FGKYjk1BlB2gKNVHP9LFgiANqDj9rh5s4ZD/Ij5nohMD0e3W1qUsmZR/mqaPV0Z2NfiAwBBLTBxJ02o/TFE3DI2zzsgH+5XKpMGEtu5i88esrlzF9wHewbABnllbdQY/WPbee0tD33+k5Qh6ygEZtg/kwEEyOn4fWnjsmhMxgi2hDFhYFbKBrga4E8z1CTsnZ6GREV9lfWKm3gR+sNEb+T/ZyMkB7/1q3ZdGzUzr5ywvYevE7aMduDnYGj96Jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbwgCsEwUvoud8lzJ4BAPALbpJUP0x8wXGXY6ZL+Yv0=;
 b=aFK+D44hodGR1MATyFTtPBje6weJY9Zf6oao77a8oEv9WRDHIwv8jCbbxLLF9v58p6d8Si798m19n/s69GG5X7WfAR2T2ksWtrVVmSjYzyaWnGRLFsp7IbO7uFWTdoRpnRnZtFA1jQ1kLt5a+dtY5QNsToMaZ0g0uX8cvTDmM4cI9TuGCQcDZGTotuusQMmww3B81lwN8mo+qkyuXCDP5eAvyBGVTym0Uobfj3a//fmXCoTGg4A3ntS+Q4cGi6YyRNlhiiL8T/iit9GNkg/Shi3vYcCMMUl2WIM7paoG+vfnSG5NrymC8qQnHLe8phjG4Ir1q7Dot81oeS48RxTOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbwgCsEwUvoud8lzJ4BAPALbpJUP0x8wXGXY6ZL+Yv0=;
 b=3qXkkqG7kSZR07FugWKO6Y69rKAspUQmppAqsicFz2yfX/vpZzuRhx8JjddZFCEzbsEhka9xTwPDMo7Pi+8x32eqlnZucUUI/gGkkKvlCkwSIcvM0ndznM1uQ2C+4gt6OPKSHi1lBVf3fGtELWuLsYkIj3yVSk5zpdA9J5DdK28=
Received: from DM5PR12CA0008.namprd12.prod.outlook.com (2603:10b6:4:1::18) by
 BN8PR12MB3476.namprd12.prod.outlook.com (2603:10b6:408:63::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Thu, 16 Jan 2020 20:14:24 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by DM5PR12CA0008.outlook.office365.com
 (2603:10b6:4:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:23 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:23 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:23 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/22] drm/amd/display: Add debug option to disable DSC support
Date: Thu, 16 Jan 2020 15:13:59 -0500
Message-ID: <20200116201418.2254-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(428003)(189003)(199004)(1076003)(26005)(81166006)(81156014)(186003)(7696005)(8936002)(8676002)(6916009)(2906002)(356004)(6666004)(316002)(86362001)(70586007)(478600001)(70206006)(336012)(54906003)(2616005)(426003)(36756003)(5660300002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3476; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03a4519-cbaa-44d9-72b9-08d79ac0ae1a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3476:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34766DFB11F662AB31FEA2D2F9360@BN8PR12MB3476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CCnKW+3LRHKKIgXEj40123q4h9BEvUvez6aFeQ6GdKiizqzX5N3y7z9aOU6PdWAP+2+NlVGVWQN7+OUVSK69+jRPNGfi6r6gsT6uNwtECP7rA7NKG2lm8qujX5N/6DiEpp1yjXMSTbTUCFRoyDlXQbYOAvgThtF/3xZtaHV2kXqT9g6TJM9oVM5HJPJKL514HJSKC2BcfR+KOV4rhQNr3+IpG8U+5b5c7g191v2XkcqyV/EnaZSeTv4vPGg0Zkq2DawbJHpnzgq9juPlIV/2l2WT+agPNSsHA8O4UOPz3LJul8G+GR2LBzt5nVD7c0l45KSV3ufLxCw4XrarNJ9YloK/kZX0X+5MX3kKOYRVsURIOYWiFbRPr8rRIEQyfdYCzqiPvhWPPlS6r6Dy7GjIEBzg4lSRqQckxHGfChORWjrQynfiHZ1zIk8OsW1ueAR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:24.0551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03a4519-cbaa-44d9-72b9-08d79ac0ae1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3476
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

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
