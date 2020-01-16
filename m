Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E7C33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4101320663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XcWzi2WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4101320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A986E483;
	Thu, 16 Jan 2020 20:14:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6873D6E478
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8FobH9evhxYkAIyY8TKXc6yYNILlcvl8+Blmewan11C0tc/vmRDzGVafRpFC9UWbMzQV1SEX2jH+CJULnVU/fiZN1QEFCdGVH63jQDjFXWRUHYnz9wxVSlzVzpgk3kTFNtaysJAH5pZtfDwu7uusSyIY30UWGZIiA8jOK5z3L4UWAbh+pYD3R26Px9K5IFU7kEtQGUsp6PD+zHTDg+aY6E5FJXGFXHeWZHsfTN0DG/y5AE2eViUZwMeSPVezRq4bNUILQnTDkBxmEfYA1+2aggEGIxaoW/UDqC3o5o4K4dfKEj5qzGraAZKMk+ObW9IaBL3QfY0Hse6+Fc2I2MF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaOPGEifvtmNnr6EJFIQvtZfWiRwi/NE3ZUe0uhczo8=;
 b=DkVVnwbnsaCJzHqgZtrORllwT4D1fYMjPV2RkHKyySmWLmYmHCUU8zVmdQ5W9D40N4xwdSQL6OR40QYlutNrKMSjQIO/+t7gwfjZTLo6+Lmml2DFLUfXzBu+aLqvoZKyCj3pwEm8CV4WpNGzY0RNNLjXzvtcL6LqGeLMR6Q45BIr/oHsd5G9W6mL3bTxruNz6UR91XQjsNHjz+HRCLTG/PqfHcVRI6qfZRYdqy+ODRt680gv4YeK8UAqY2/gj/yXsFbDz2R9ZTLLLxteoS1AK2z9eE+XBgoLrDNkF2JoO7pXm6J0WwLiDGlVB2la+3Ln7uSQSeO/+ytiQILXjgEeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaOPGEifvtmNnr6EJFIQvtZfWiRwi/NE3ZUe0uhczo8=;
 b=XcWzi2WMfiSzaJOzVLF7j0ShBO6AOlSCaVCKp/Og0XsovgxhFOmRe3TmehwAKMQ2ZU8PlvEkpZAtq5mepALV4kinOzfmiR7M7vYqHcaDf0ld9tWfwFTngUm2t7gPLGr8ocb7SytlvE4+v9+ZN4F6n8hnZVHXOsPkoZctaUJ2Qn0=
Received: from DM3PR12CA0133.namprd12.prod.outlook.com (2603:10b6:0:51::29) by
 BN6PR12MB1588.namprd12.prod.outlook.com (2603:10b6:405:7::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Thu, 16 Jan 2020 20:14:38 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by DM3PR12CA0133.outlook.office365.com
 (2603:10b6:0:51::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:38 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:32 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:32 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/22] drm/amd/display: changed max_downscale_src_width to
 4096.
Date: Thu, 16 Jan 2020 15:14:16 -0500
Message-ID: <20200116201418.2254-21-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(428003)(189003)(199004)(2616005)(8936002)(478600001)(8676002)(81156014)(81166006)(2906002)(7696005)(86362001)(70206006)(4326008)(336012)(6666004)(1076003)(70586007)(5660300002)(356004)(186003)(426003)(54906003)(26005)(316002)(36756003)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1588; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4c4ffcd-e235-4304-c961-08d79ac0b68e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1588:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1588D48ADF419BEE75288F35F9360@BN6PR12MB1588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acpVH/vXDLifGC6Bk1uLnRC8Xm/2ZD6L6R95b86ooT4f+Eb1M3oTsxKUwtAjeHAqDLnOCoapaL7cgw5YTSrjHa1BlFOEYe3GF1bcY5Fl7l6NpbPhnz635x1fLEGJ7FEiVNwRTXtKwIjrxRfWTJER+kvOYHxaDmuQG+aX7gQJWdOYnmyp19Co1dtSej7xnOKJz80sl1SJ06PXJQNQNrjEz0Z767UTz3399gOcvyzD5znJ7PuqjiOTG/w8k/8dBgFZs/0kKYIbGYCz3KQ+KVC/yo6/iCvoonSOWGFapLAtAHXBw4R6yDG6gaVRwzKJd8sA5MzsVQmc6h0UezwjP/Abrt4LgzU8kPJqjefJ3uVCduNw+l0pGF3yqKhijRPz9tKAQmx2v1t78pJeKMDrIL5FjVqC8VI2mndU+5+H747dS+udc0Rj86bRB9sqVnzG96Jd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:38.2453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c4ffcd-e235-4304-c961-08d79ac0b68e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1588
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
 Isabel Zhang <isabel.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
MPO isn't enabled on some 4k videos due to video source width is 4096
and the current limit is 3840.

[How]
Changed the limit to 4096.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 1d741bca2211..0d506d30d6b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -830,7 +830,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
 		.performance_trace = false,
-		.max_downscale_src_width = 3840,
+		.max_downscale_src_width = 4096,
 		.disable_pplib_wm_range = false,
 		.scl_reset_length10 = true,
 		.sanity_checks = true,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
