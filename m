Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6851C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 21:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D202137B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 21:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="orkYGqoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D202137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513786EC16;
	Fri, 17 Apr 2020 21:43:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155F06EABC
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 21:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0NiOnF/UnjATZF3OgwxZHa4klb9W74YbAMAnOXn59Fk1SsaYazTbEBZV/OM9oL6YVwWYhuADGiib7QZxdUrurm5c7XSGvbI6NDtOTYXoGqK5u4fuvzIHDeXO/HPzV7CSDfYRqMcLCn1TYMm0LfC86o6hhobcfooDQ/WvbBZScMENdronSzG35WTXVnBly836qitf6TyEcZFYm2e/Jk4ipu2qyg41HpEmeAhs23raTUXcwxh2+zDf0RAXDLLDGC3uyqd5HrMaI1sBrsPQ+MNzI//vmYS93oVMoqaHkwHrZj5onJu5IURgWnRj3lr0hRHcodF+Y4AFim7SXhyreWWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su5jihDl9CDwsGjwaBQ9szXXejneEfnizecAlvFpQPA=;
 b=MnB0aUJ8hQR8GlJ/POXdaFH38C0xxqxJcip75hSKWa/AQYuJQroDBzLI+XgENXZwAB4y+sZxuoWN67s3sFLgfziyfj8S/Vf84YBAH8n1mJAa+PTAlw2DZ4XV1sn9sAsJVfEmYbk9tNtFlYlIBqML4uR7w/7Q7nuZgX5tYiO7FRud30lHKwWBw7S2phOsBFeAkuQi0PWQx74V79g3YvEA6uQqAnFjzXZyGKn7tOgKdghjR6ZhECfd/YkE/8n2IJZCEKU4Q0NZwuFnbae+aIcniFbmvyW37G2yI2J8fO2aE6gxYQd7k1ZxvjYsgafH64DGzyu6wQr4pBTvJ3RAGLlG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su5jihDl9CDwsGjwaBQ9szXXejneEfnizecAlvFpQPA=;
 b=orkYGqoWuSJwfUWr3cx4ysGKWFrUNuU4a1wvo6rIf0GzMmSjHDYmou7yDX+0TNiS9rwXFlogoEos8doQYy/6suG0pT3FMOyw3WZf9k3sLkvBXJhzGVJB3DGZfh6+/ZyCh8G304rqOdGfMDyl4JTsudAfhFb+WLf6+TEH7OSrCto=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Fri, 17 Apr
 2020 21:43:15 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 21:43:14 +0000
Date: Fri, 17 Apr 2020 17:43:08 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: christian.koenig@amd.com
Subject: Re: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub
 abm config table
Message-ID: <20200417214308.347n7xk2d46zx3nd@outlook.office365.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
 <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
 <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
 <c3f3fef6-6c35-7201-c75e-2a72dca42350@gmail.com>
In-Reply-To: <c3f3fef6-6c35-7201-c75e-2a72dca42350@gmail.com>
X-ClientProxiedBy: BN8PR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:408:80::28) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::2) by
 BN8PR15CA0051.namprd15.prod.outlook.com (2603:10b6:408:80::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Fri, 17 Apr 2020 21:43:13 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b902279-3b47-410b-6ed8-08d7e3185518
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:|MW2PR12MB2364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2364A9328050088356FCEF4998D90@MW2PR12MB2364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(16526019)(2906002)(54906003)(1076003)(7696005)(186003)(81156014)(8936002)(5660300002)(478600001)(21480400003)(9686003)(8676002)(316002)(52116002)(55016002)(66476007)(86362001)(66946007)(6666004)(66556008)(6636002)(4326008)(44144004)(6506007)(34206002)(2700100001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiHp7mV6av4eeZd1nTooGt8fvUEZ/JNnEKbWh7MXes0mAxomMOr4nguWH1EbfP6nfDtz7nvoNW/MljoerUdedarGXHSnTLTmiyyEb+Aq+E5y966QfdFKLMgZzM25mZJfkR3nFmt1VpYm7UH0tm8KUvxMpOCgYjUsGoWh262aDmang+7xPZ6quejRVc30Erl14va/Bo3kCEeHWlhPIh9kzORvJhwXLL/qg+6Ho7n/XZN4zQcpoRcoNmdryna6SenTniBqN3OS8bdAFvj1AbKka7AItXy6oGiAPgSlvCuzt52SpC9XpH/QDFfG+PJU582nD7PXMdI24hGmvY8kUiIz53WjoMwEUzTpx23+DYj1+pEaOAmuScRWphVN/Vj+bh3zjAwHAunKbUMP1zd3mokrwcOGLPWUL4HO9UMfuFd//CGPtWP741qmuqs/n8bbgwbYWdTVCDtnuQfXt7epy9nuXsfDSTqAbrdm9NJssBeLiu5QFiPdsOE8TWtSgUvjMHpH
X-MS-Exchange-AntiSpam-MessageData: 4KNiBl3EgJMQVyKzHDEoMQr7VTfj4fhOAtwzBwwEA0bhOwR34amov9PTs3wnSaWlAoIFdHxtsU00GxgLWKD8xxAAxRzyyAr1WpCGTCvj/olGhQ0gr626BM+tGd+rSliQJNkn7QxpprtMrpCit+B1kb/7l9zLf2RFd9M+odv6DfH/0Pb1gIchQ9F5Y/WknYdEa4gK3TnD+tP97vSrz6n5vmPRRRcjkqTbNuwxLXzMGEkcUiFUC3WN4ujEEEniy3Xso9xYZMErWlO7ReK7j2F7O2tJfzCzvHMuRpAaKFCPfsCwSawpBxwmiZocqanJayy855ClAiSs2hR2xBL21Kj6stBPUsZmMs8kiQGVrCkR5XX22MbD2pVwlXmb80s1PkIf2dJnjHGhicTL1pyD5/IhPVbKNs422gV44XyKQMUHodS7yCmWfWFl1evlEJuVE3xbRWFJCmESiVuxYqFm8WPioGdC+ZGk3ub/o/jdyaY1y3CWF9DkDxm62AyPdLv4ECzLFmqFZoUuivRUBP//kiABxCP95MZ8CN/BJqJjaEkb01rc33ivF6BdWkNp3f1LJNh1ikzrGBKRxyjLYzuruaPc+80DFbSypcXkuIPcHkm312BzIUA+xu8SoQQUR1UTHHPR0Szw60xOn//GuO1zc9lVIZYUVayZcKywS3I/1LTxwys5pKoRf7C1MZk9ls7c5VFK9gUPwPpkKlqr1CfoHrsDrQ4oGO5OKUzn38m5nTkBYEJRPkn/6Of8IfTxOmvCDNuFYjmlgFOtupd2jAgTlehzSNNZbnrSAdl0UsXJ/WVw4y9wet8R8j4k/sLUwan6oowe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b902279-3b47-410b-6ed8-08d7e3185518
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 21:43:14.7966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2U0TL3sx267sxVkahkbqen8gVa5KtcbGBxXebfQdOwEVwIWxgL49RZYNAtR4FQdHvMqh/LYwg3cZXlu8F0qUgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Wood, Wyatt" <Wyatt.Wood@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>
Content-Type: multipart/mixed; boundary="===============1994626031=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1994626031==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bt6xqpo4ujszsefl"
Content-Disposition: inline

--bt6xqpo4ujszsefl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Wyatt made the below patch for fixing this issue. I can apply it on top
of this patchset if you all agree.

[Why]
Current code does not guarantee the correct endianness of memory being
copied to fw, specifically in the case where cpu isn't little endian.

[How]
Windows and Diags are always little endian, so we define a macro that
does nothing.  Linux already defines this macro and will do the correct
endianness conversion.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 58 ++++++++++---------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/dr=
ivers/gpu/drm/amd/display/modules/power/power_helpers.c
index edb446455f6b..8c37bcc27132 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -265,9 +265,11 @@ static void fill_backlight_transform_table_v_2_2(struc=
t dmcu_iram_parameters par
 		ASSERT(lut_index < params.backlight_lut_array_size);
=20
 		table->backlight_thresholds[i] =3D (big_endian) ?
-			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) : DIV_ROUNDUP((i * 6=
5536), num_entries);
+			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) :
+			cpu_to_le16(DIV_ROUNDUP((i * 65536), num_entries));
 		table->backlight_offsets[i] =3D (big_endian) ?
-			cpu_to_be16(params.backlight_lut_array[lut_index]) : params.backlight_l=
ut_array[lut_index];
+			cpu_to_be16(params.backlight_lut_array[lut_index]) :
+			cpu_to_le16(params.backlight_lut_array[lut_index]);
 	}
 }
=20
@@ -596,7 +598,9 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table=
, struct dmcu_iram_parame
 	unsigned int set =3D params.set;
=20
 	ram_table->flags =3D 0x0;
-	ram_table->min_abm_backlight =3D (big_endian) ? cpu_to_be16(params.min_ab=
m_backlight) : params.min_abm_backlight;
+	ram_table->min_abm_backlight =3D (big_endian) ?
+		cpu_to_be16(params.min_abm_backlight) :
+		cpu_to_le16(params.min_abm_backlight);
=20
 	for (i =3D 0; i < NUM_AGGR_LEVEL; i++) {
 		ram_table->hybrid_factor[i] =3D abm_settings[set][i].brightness_gain;
@@ -620,30 +624,30 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_tab=
le, struct dmcu_iram_parame
 	ram_table->iir_curve[4] =3D 0x65;
=20
 	//Gamma 2.2
-	ram_table->crgb_thresh[0] =3D (big_endian) ? cpu_to_be16(0x127c) : 0x127c;
-	ram_table->crgb_thresh[1] =3D (big_endian) ? cpu_to_be16(0x151b) : 0x151b;
-	ram_table->crgb_thresh[2] =3D (big_endian) ? cpu_to_be16(0x17d5) : 0x17d5;
-	ram_table->crgb_thresh[3] =3D (big_endian) ? cpu_to_be16(0x1a56) : 0x1a56;
-	ram_table->crgb_thresh[4] =3D (big_endian) ? cpu_to_be16(0x1c83) : 0x1c83;
-	ram_table->crgb_thresh[5] =3D (big_endian) ? cpu_to_be16(0x1e72) : 0x1e72;
-	ram_table->crgb_thresh[6] =3D (big_endian) ? cpu_to_be16(0x20f0) : 0x20f0;
-	ram_table->crgb_thresh[7] =3D (big_endian) ? cpu_to_be16(0x232b) : 0x232b;
-	ram_table->crgb_offset[0] =3D (big_endian) ? cpu_to_be16(0x2999) : 0x2999;
-	ram_table->crgb_offset[1] =3D (big_endian) ? cpu_to_be16(0x3999) : 0x3999;
-	ram_table->crgb_offset[2] =3D (big_endian) ? cpu_to_be16(0x4666) : 0x4666;
-	ram_table->crgb_offset[3] =3D (big_endian) ? cpu_to_be16(0x5999) : 0x5999;
-	ram_table->crgb_offset[4] =3D (big_endian) ? cpu_to_be16(0x6333) : 0x6333;
-	ram_table->crgb_offset[5] =3D (big_endian) ? cpu_to_be16(0x7800) : 0x7800;
-	ram_table->crgb_offset[6] =3D (big_endian) ? cpu_to_be16(0x8c00) : 0x8c00;
-	ram_table->crgb_offset[7] =3D (big_endian) ? cpu_to_be16(0xa000) : 0xa000;
-	ram_table->crgb_slope[0]  =3D (big_endian) ? cpu_to_be16(0x3609) : 0x3609;
-	ram_table->crgb_slope[1]  =3D (big_endian) ? cpu_to_be16(0x2dfa) : 0x2dfa;
-	ram_table->crgb_slope[2]  =3D (big_endian) ? cpu_to_be16(0x27ea) : 0x27ea;
-	ram_table->crgb_slope[3]  =3D (big_endian) ? cpu_to_be16(0x235d) : 0x235d;
-	ram_table->crgb_slope[4]  =3D (big_endian) ? cpu_to_be16(0x2042) : 0x2042;
-	ram_table->crgb_slope[5]  =3D (big_endian) ? cpu_to_be16(0x1dc3) : 0x1dc3;
-	ram_table->crgb_slope[6]  =3D (big_endian) ? cpu_to_be16(0x1b1a) : 0x1b1a;
-	ram_table->crgb_slope[7]  =3D (big_endian) ? cpu_to_be16(0x1910) : 0x1910;
+	ram_table->crgb_thresh[0] =3D (big_endian) ? cpu_to_be16(0x127c) : cpu_to=
_le16(0x127c);
+	ram_table->crgb_thresh[1] =3D (big_endian) ? cpu_to_be16(0x151b) : cpu_to=
_le16(0x151b);
+	ram_table->crgb_thresh[2] =3D (big_endian) ? cpu_to_be16(0x17d5) : cpu_to=
_le16(0x17d5);
+	ram_table->crgb_thresh[3] =3D (big_endian) ? cpu_to_be16(0x1a56) : cpu_to=
_le16(0x1a56);
+	ram_table->crgb_thresh[4] =3D (big_endian) ? cpu_to_be16(0x1c83) : cpu_to=
_le16(0x1c83);
+	ram_table->crgb_thresh[5] =3D (big_endian) ? cpu_to_be16(0x1e72) : cpu_to=
_le16(0x1e72);
+	ram_table->crgb_thresh[6] =3D (big_endian) ? cpu_to_be16(0x20f0) : cpu_to=
_le16(0x20f0);
+	ram_table->crgb_thresh[7] =3D (big_endian) ? cpu_to_be16(0x232b) : cpu_to=
_le16(0x232b);
+	ram_table->crgb_offset[0] =3D (big_endian) ? cpu_to_be16(0x2999) : cpu_to=
_le16(0x2999);
+	ram_table->crgb_offset[1] =3D (big_endian) ? cpu_to_be16(0x3999) : cpu_to=
_le16(0x3999);
+	ram_table->crgb_offset[2] =3D (big_endian) ? cpu_to_be16(0x4666) : cpu_to=
_le16(0x4666);
+	ram_table->crgb_offset[3] =3D (big_endian) ? cpu_to_be16(0x5999) : cpu_to=
_le16(0x5999);
+	ram_table->crgb_offset[4] =3D (big_endian) ? cpu_to_be16(0x6333) : cpu_to=
_le16(0x6333);
+	ram_table->crgb_offset[5] =3D (big_endian) ? cpu_to_be16(0x7800) : cpu_to=
_le16(0x7800);
+	ram_table->crgb_offset[6] =3D (big_endian) ? cpu_to_be16(0x8c00) : cpu_to=
_le16(0x8c00);
+	ram_table->crgb_offset[7] =3D (big_endian) ? cpu_to_be16(0xa000) : cpu_to=
_le16(0xa000);
+	ram_table->crgb_slope[0]  =3D (big_endian) ? cpu_to_be16(0x3609) : cpu_to=
_le16(0x3609);
+	ram_table->crgb_slope[1]  =3D (big_endian) ? cpu_to_be16(0x2dfa) : cpu_to=
_le16(0x2dfa);
+	ram_table->crgb_slope[2]  =3D (big_endian) ? cpu_to_be16(0x27ea) : cpu_to=
_le16(0x27ea);
+	ram_table->crgb_slope[3]  =3D (big_endian) ? cpu_to_be16(0x235d) : cpu_to=
_le16(0x235d);
+	ram_table->crgb_slope[4]  =3D (big_endian) ? cpu_to_be16(0x2042) : cpu_to=
_le16(0x2042);
+	ram_table->crgb_slope[5]  =3D (big_endian) ? cpu_to_be16(0x1dc3) : cpu_to=
_le16(0x1dc3);
+	ram_table->crgb_slope[6]  =3D (big_endian) ? cpu_to_be16(0x1b1a) : cpu_to=
_le16(0x1b1a);
+	ram_table->crgb_slope[7]  =3D (big_endian) ? cpu_to_be16(0x1910) : cpu_to=
_le16(0x1910);
=20
 	fill_backlight_transform_table_v_2_2(
 			params, ram_table, big_endian);
--=20
2.26.0


--bt6xqpo4ujszsefl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl6aIucACgkQWJzP/com
vP+JrQ//QQDKnvuUeSNX52Ee+2Z4jOS/rztOZHYMpXGGC3V1wt7+PkHuaQ9fAkR5
lf/v7lLeMj9spFWrMD+eXcWt6O94c/NFGL1QJy2j2fneLy/zfrTJrcoagTapCfH0
LmHxDxJFiI9ZsrHGYK8+8d0OOBXdiBHN6XqJrfrliXNxBvJNXTN7K52+J7KYcCzu
EyX8z/PWsGAd8zALen04m8Qcj2tba1+2ecnrnyiEeUvhHcIsr5XfVxlrqGIWCIyd
wDQCyiWNZQAHz6nkJL2ZyV+X0LMaqen8RSi5j3H9ZNOrt7iC/EFG1SCyLGvmFwqZ
LOYlURwhwdtUsqsVki9D8zw++Rh996E8bcVq1fWP3Z3MzN4fB7WnWoOF1dsvk64E
CJbCUeHu9Ls6Ih7YGNIp3f39RUjVNysI7dCfvHGttduvWRxAXB8AQWRjDPcLtzSg
8eUD3MjOcdZs2oRkCjdgo/UoLzkesYZ7vVi3TLd9LOJA8waPWX544TgCmPo2IjWw
8CIaBmSciGlgE/6wu/wqJJ1di7rKzjjv2fOhs42D17Daq6cgOZHl/fvmy0Ov25vm
GepqET84V8q4tw8KZ0plgvZVgc4fWzhyg7VR5RGyQZ/+fgFnZnkgsxKcQq5XGwUY
JHv0JRC10YFhFLCBgcr29Ctz8oAdBfKMImuQzlExkT9HwJL2Lpw=
=p/FZ
-----END PGP SIGNATURE-----

--bt6xqpo4ujszsefl--

--===============1994626031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1994626031==--
