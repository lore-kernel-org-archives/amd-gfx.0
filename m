Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E8C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC4D21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QphtkgRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC4D21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B75E6E32B;
	Thu, 16 Apr 2020 23:41:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ECCA6E32B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWEcxb/i9EF3sD6zGK20lrn4pUIbXSccPr/P85NMEfgmP/DDoQk/ygEpHMWsO3+htqYdiT1GcrRAa2Rq7s+cf2FOjQLyhMz5q5MKWysLXRJyN6384Tqm1VGQ9rwLuZ1fuSs40c1gIcJfx5Lx7hIAgW1Kyxg+REiZru29gx2OG2ZSGJxr3cwtz3mLpnEioxLEhXJLzyV0AFihWMJj0q+k8sdshJ+FWsOGTnRznsea1Yoo6/iz4NeHy2sHrWrKJJSBIVL4GAtOxIUstznaMJEP5+VLAVHezUgahOcjamdwwM29sXslqwo1kbe+ybAUKlHXPHfhPvdszavZfFgfCDylPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1jEuB8KwiCIzdCTiDD6DKL2eSJzRmWVNiZP3Bgo/78=;
 b=iG7M02B7JutOxPgVlzoEFvmWo1xj9uCGldG+7oWAuByGmCrPa5NqDjiyubYZRg0KVOaGEDvuy9j9ICq4J3JWQTe1YgYkSPY23ENIpwt+sNLJHj39r0Z+L55jJIBQiZAH70Y78AhaxOsGvgAH73yHZ8q7RpasfzUjm5WsFwUcDFpRKGy8jbeON0usFil0zFHM6gbjCEI4UgN5XPiSKkxkjc9gBSEhNWsNHZZVViljCwkLKU9JJ4hon4RMbXhEMugj/NgBbgj6ih9X6Qya52uqIfONl5Z2eaPy8nUEtpjJy+uDOVbNpxFtwVxZTVC9F1go2jmJsfzFymWUQZwKDpeiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1jEuB8KwiCIzdCTiDD6DKL2eSJzRmWVNiZP3Bgo/78=;
 b=QphtkgRWn2WlJeo+Xig60OfWl0WKWTBqXH4xo30O7Qlz71lu2VDYLmc2tsZ3gOkhc+ih4pVXKLXB0i1dvL392AJPSAXhCgKb4D+SOXSSceGnJvYNMYH3iuyYlTFAs4JgfgVvMJiRfXBanrPhN9ZVlR45L8zS9aVFor/gMHB30Lo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/35] drm/amd/display: Cap certain DML values for Low Pix Clk
 on DCN2.1
Date: Thu, 16 Apr 2020 19:40:31 -0400
Message-Id: <20200416234044.2082886-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:39 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b76a0069-83b8-46d7-a4d3-08d7e25fb606
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245981C0A7E68FB1E5C1C78498D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKoUT7ORjWEpeqJsAUq3eaw+aRjUTqSYAVVoviHv+Gf7Yf4XYrv4t3XSjjXJPSr0zTK3u51pDSHq52hxnOHAkYmL1j1jalXMowbr5DquN2mfuxeAeFhRnJpX17R4b8Ef+jLdVd6tphX+kiFEKt5Zafs0u9vDH90Sv3lEbFcNqBxvJauUkDCMYmGHtJjR4muzWgnjxxmhstRmMsGxKtcKnz7mnGTzHFRn1MA9Imfcun1kTJ4jyll5+sUDE3TRNd/aDt7hWGQhP46PZ0PJZQxhyhVY1Y6ayNPQpPrfSlTdGOQLIiuoYcovh26yEebTrCAU8NAysCFbgQrtork2NFjZd5Q7PQdvc0xSmfHFZlPkirbnIqMG0/q2EhCIljAba3453+ls7AT4HeR1+/6/uk2mp5SKHV3mRdUh0eVdtrmUJIcQjeYRTJB1BvuFUf29zEj6
X-MS-Exchange-AntiSpam-MessageData: XIB48trGAkclDEP7KsykKjO0w/lJgvO8TPsTAI3fe3vVpEfdet/qaoMyRNWD6Uq/aYtXukhXEqillBVSrrpWPVvac3ILtMNAcokmie+9vRrwuWrn2gT8VzgTBObqHfEWg9pAHvXvYdb1elKrTp+8m61aJppgkABqi5s1Ap0hHYw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76a0069-83b8-46d7-a4d3-08d7e25fb606
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:40.2392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XJx48y/0Ue0IF+c5CR9zmcYgWkvlwYg1PQuZY569yCfz90DTds7GWuF5Bq97WM8nU8dJNyjqX6NOO31Pd5U7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
In certain conditions with low pixel clock, some values in DML may go
past the max due to margining for latency hiding. This causes assertions
to get hit.

[HOW]
If the pixel clock is low and some values are high, cap it to the max.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c    | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 5430ced02bac..193f31b8ac4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -1490,13 +1490,21 @@ static void dml_rq_dlg_get_dlg_params(
 	disp_dlg_regs->refcyc_per_pte_group_vblank_l =
 			(unsigned int) (dst_y_per_row_vblank * (double) htotal
 					* ref_freq_to_pix_freq / (double) dpte_groups_per_row_ub_l);
-	ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)dml_pow(2, 13));
+	if ((refclk_freq_in_mhz / ref_freq_to_pix_freq < 28) &&
+			disp_dlg_regs->refcyc_per_pte_group_vblank_l >= (unsigned int)dml_pow(2, 13))
+		disp_dlg_regs->refcyc_per_pte_group_vblank_l = (1 << 13) - 1;
+	else
+		ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)dml_pow(2, 13));
 
 	if (dual_plane) {
 		disp_dlg_regs->refcyc_per_pte_group_vblank_c = (unsigned int) (dst_y_per_row_vblank
 				* (double) htotal * ref_freq_to_pix_freq
 				/ (double) dpte_groups_per_row_ub_c);
-		ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_c
+		if ((refclk_freq_in_mhz / ref_freq_to_pix_freq < 28) &&
+				disp_dlg_regs->refcyc_per_pte_group_vblank_c >= (unsigned int)dml_pow(2, 13))
+			disp_dlg_regs->refcyc_per_pte_group_vblank_c = (1 << 13) - 1;
+		else
+			ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_c
 				< (unsigned int)dml_pow(2, 13));
 	}
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
