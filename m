Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 01:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A4E61132
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 01:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85A4E61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25826E0EE;
	Wed,  8 Sep 2021 01:28:15 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33AA6E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 01:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuYVG4K8wSejexmmElh/A/ufoH4HRQtL9//IoU/mMjZViookvnbRYiS1ARBWz6D8G4tdEU9C7XVCF9UOAXABHRs37nsXq8TRxcn1GXaInLlsHfmM91ipJYuBSbMLwNForB4c84+Q5mfU4nJ96XudJMaPSK/iZZlMmqexdZtcUMVw+uGDl8vCHRM3hEN+zeE8cnCmBv4QSy+uzL1MD7zkPTBovVp0LIjQha9K5sh3Ic8ISnu8AJG7rr/dZ2ho+zmN6EaI5VyRkffxyuuJ5Afo7X69p5V9AK1N3xVK49PxTthKfTbMZOVCMnRI05TFSWn7mFdmNqHjL5ejym2Y4hVpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=KMP0NDxZuPx4WD5SGb4/meIkCM/ipe1xNX39qA0PBfM=;
 b=H6ciWddTanwty3qDOEwPhlBRNQLf/pDReUMK2AM6581L52X95KESJ31rC2Fr1ywXvyChpkRLA3nEulpdjjEZ4mINoO4RhSB23taXsFcmNCCIN4nbqTSzyqY4IV/bsdEFCNNUb7wl5Tng0Z5+rd4agwtSAE0rIgzwltcPmNkhcnyxPdKMrTcUX8ibSwidoZuKza4Bszae2FUSTB/fX32t9AFmce3pSKQyskI4rwIu0jvKkUHb5rQcrLnK4wPwcYTWQ0+kw15NybYSvyankUpP8hayPiBv78hdHSgrn/HhN6qAgX+gIBlRfyWzFQ0Vy+ALzrKa1oKRQ3BXgtNT8HJzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMP0NDxZuPx4WD5SGb4/meIkCM/ipe1xNX39qA0PBfM=;
 b=AwMRtA7xCvZp21Pz7D+ITQAqBhwbU0A8pZ6HAD/N2Wyqefv9FuTlsT78tS55oKzW0pUVtms/P1QRBH/FyJGa3KuF3d3zZUOKYZ/dvIUYDYA6JrAQvCIOj6iMUPI+S9fVJMqY4ZwNYDgcMOafKmjfkV/KgVU74OBEKI3Yeoxexyo=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 01:28:10 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::391b:ddef:5374:5832]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::391b:ddef:5374:5832%4]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 01:28:10 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Sun, Roy" <Roy.Sun@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Enable some sysnodes for guest smi
Thread-Topic: [PATCH] drm/amd/amdgpu: Enable some sysnodes for guest smi
Thread-Index: AQHXox7xHyR/+Sag30WiPC3QgdUG16uZWxOw
Date: Wed, 8 Sep 2021 01:28:10 +0000
Message-ID: <PH0PR12MB5417DF13F3AF25E88AC3B7B58FD49@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210906125841.40876-1-Roy.Sun@amd.com>
In-Reply-To: <20210906125841.40876-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=116ae22c-f51d-431d-8297-f29420d82bcb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-08T01:27:16Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2bd7729-74ca-42d4-4511-08d97267eb80
x-ms-traffictypediagnostic: PH0PR12MB5497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5497CCB88CCBEF5F00B43D338FD49@PH0PR12MB5497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:366;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1U/us+wNhPQ3iPQBZCV58vOSCcHnSQKvYADEsIQbATKRNZRTV1r52/4ThJCzavJbHpygypfVbvfE5RukvXVmf7i/U/OtQXXA9yQ7GylpSzrOGxViN5Uc36mMKnqZ2JFJWIHzc1tg17I839ltsyYgPLqmihdON0zpNHxGovBB3GBrSHxvwsu5ZG/xye9E7NuGtewU4zc2FUeqTc5DzT8mnUTbK1VsWJOQt5A+Qwa1Stjj0HEBbnQOvp718yUp8v5UaIsXTgdWkOwq+23pW5yoUDVpy+RkXL0UEfdEO8jRBvfNqK6vrYYl9MY0h0B6yQLvaqPGshPGpEUvdWWLb6o0RGnrd4RjLD9y3457C5+TUp60KxMvqpdrhmdJWc3j4x7jpjHis11h/5w0n82++XGSdE+S6CA2e/JnucP6Umg+GFMpkdh0AyaihPiIynJ697Z5cQkHFQPoKh6spkE0ZQwM1PllD/ld8jR6GH6NQj3T/ZI7V2xEoaPpAer28qsrzHgtv3rVlEKtEP7gEiA6p/FcAFvN1Fnjx6XdAIACNgA6ZrVSHT56Cf40qdS4pbm/5+eIpoMPp4++3rZAXcsQq5ZuPYTM57qJp5POyRvcyHpeLJ1ZAzuwqqbDzpT2/OSqqZwcUm12n9GCq7bf06iPm11EpqaCr56yPkJcXZLLQbgRaXpifHfmK4DWQ1ulK6JsJizRc90c6T2YaKJ7AH9KFeyV9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(55016002)(66946007)(66556008)(66446008)(478600001)(64756008)(9686003)(6506007)(8676002)(66476007)(33656002)(8936002)(5660300002)(26005)(186003)(76116006)(4326008)(83380400001)(2906002)(316002)(52536014)(7696005)(86362001)(71200400001)(110136005)(38100700002)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cyzhXE7cyZLCNEilMJPHpt0zDVyyQRfQ4vOuUiooBQtnO8dU7XheitnXg3Sm?=
 =?us-ascii?Q?HgJI1iMo8ME+InARUGjCIq/S7aomI2X8KOdGW54/S2OhoU1Hi4bd350XsAAK?=
 =?us-ascii?Q?fsjBz+Qosk1RIsFlgbPeXwdu0u6yUDlzWDe/erONw/LpCnms5b7wh38OrYGj?=
 =?us-ascii?Q?Yd8TQU7dIDj181fl84V9nnQKCDFdZUkCEIXN44BrZJx2T+bjiNWMzIExMmg7?=
 =?us-ascii?Q?Ez9d720SrzBfaJX7SW8VD1P4MY6u80IrFiP0etdhYiG+PZG1y99y8jGinpjM?=
 =?us-ascii?Q?CFOhrRjNzMuSxC8r57fDSMHqh1ajriT0Ry340R9Ss9ceNav8kF3eeWOnuI8D?=
 =?us-ascii?Q?Li+bXgKKJzaVe4VyyzuQdFNpi8JnoH6obKQKk1aDgXNdqxpc6kGEWMfSQwPG?=
 =?us-ascii?Q?FlTLXY06+rxgqvYPnr539OwJV9d+FLsay2mfsdFVbDK/Uo8+yGHVrfQXVmGu?=
 =?us-ascii?Q?iwjEgNnAPKaIyEBLk/xDl1tLekyPUKKp9RLO2B0sl/qO8F9LJsRTNXfOIQMa?=
 =?us-ascii?Q?pg1rl7Y5XtghuLE3VDOIPCD0kuiu4eTYl9VZUARGRT/OtpgC2W6s4w/GoIct?=
 =?us-ascii?Q?N+AZRToQ7GUgWKG/YllkFshTiYV1GX7z/5oJeRF/EbP6MIDc1NLmnSkIYlJ6?=
 =?us-ascii?Q?bdYshlnUWyzVUnQrTi4SZhuwGnjIKKAtPtL2VG1JK3Yxt5ONhK4elrJI96aq?=
 =?us-ascii?Q?OmlocTk2FTXX5u/W7rjaxNTpz2TrBR4SUW5o3AD3l/0f2Gxb18oRyaSRdLjw?=
 =?us-ascii?Q?Fjovap8XyYn8pv7/AKPKUddYxr11RIFpjKPQhFbHQrGRqoHvpBYdGMu8aH82?=
 =?us-ascii?Q?/BzvTBibXQ7c0Ew+Xk2OfKcPvbcBiYtua4tS8UO/J8ned1+MdnYwrY6INmVW?=
 =?us-ascii?Q?1u3XPjuJubQKFN15JVzW08/JJIi8qTpNsObA8Q6ph5kMIj9K14jZyKQ4vw6o?=
 =?us-ascii?Q?t9JdfkdZ9sebFWE1PBOIefheDmLVgES44kAVHw1kidFLdB6uuclMjYU+D8xW?=
 =?us-ascii?Q?ecLlbL+YuhmHDtV0CVLFtCxYmvoxI7X9L9vYja2KzL62eLISUYZyzeRkMBme?=
 =?us-ascii?Q?RHqK2TrfGC7XaWGEvXiulnTctHoNsaI8ju6uKde5oeMk66YtTjpMqUke7+ym?=
 =?us-ascii?Q?gPufdyn1XQ3N/SsAlmGTFQENKGUNW0gI634XBwf98ct7of4cy28FMso8KOPa?=
 =?us-ascii?Q?a1NyQXFRjFdlbJko0FUNdzaMyD2+T4j4hoIEFD9MJ2owMDT1FhCYGpMHkIsF?=
 =?us-ascii?Q?OZhaE+ldbn/L1rZieLx8qjr+VmKeWjeYBF0mhFvQWwBMzRJvBKVokf9S8KMa?=
 =?us-ascii?Q?wvM0rgbAzvPl1tQ742we94zv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bd7729-74ca-42d4-4511-08d97267eb80
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 01:28:10.7089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8DReJNzwOqYu0EZky8txR939Onmd5FVRXJ/Y/tzI1RPfD09vMCRPw6c49WIU6I7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
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

[AMD Official Use Only]

Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Roy
>Sun
>Sent: Monday, September 6, 2021 8:59 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Sun, Roy <Roy.Sun@amd.com>
>Subject: [PATCH] drm/amd/amdgpu: Enable some sysnodes for guest smi
>
>Enable sysnode vclk and dclk on Navi21 asic for guest smi
>
>Signed-off-by: Roy Sun <Roy.Sun@amd.com>
>---
> drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>index 249cb0aeb5ae..c255b4b8e685 100644
>--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>@@ -2087,10 +2087,10 @@ static int default_attr_update(struct
>amdgpu_device *adev, struct amdgpu_device_
>               if (asic_type < CHIP_VEGA12)
>                       *states =3D ATTR_STATE_UNSUPPORTED;
>       } else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
>-              if (!(asic_type =3D=3D CHIP_VANGOGH))
>+              if (!(asic_type =3D=3D CHIP_VANGOGH || asic_type =3D=3D
>CHIP_SIENNA_CICHLID))
>                       *states =3D ATTR_STATE_UNSUPPORTED;
>       } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>-              if (!(asic_type =3D=3D CHIP_VANGOGH))
>+              if (!(asic_type =3D=3D CHIP_VANGOGH || asic_type =3D=3D
>CHIP_SIENNA_CICHLID))
>                       *states =3D ATTR_STATE_UNSUPPORTED;
>       }
>
>--
>2.32.0

