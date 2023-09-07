Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A33EE14D0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 07:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0210D10E77A;
	Thu,  7 Sep 2023 07:34:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE59610E77A
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 07:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jswdv/GYvTvvM3AOEn0KbOJVY+KeaJ2AHX9+u4SVt64Hw33UDtmrkByPaijIJAEH2c4vfTqbEZSk7Ejd2UYXUVqUZG608PT8COKtMLQ1HCG86kh0HFNqqSl2FW1UtGZ9QHK9InfVj+dA81ZBA8DEa+ec21ioSvCatWBx4dN1WKFRj75LEqYWJ6xPx5vyinaaeQ1dKmY8bAfonyjlvQNYpymIXd1wcY5SKQ2p29XcQnloxqdvcNJ1gXR7u9mxSLXH+UqtDPVsBHx41d96YAo7ah5Lv7h7iJdNkJmTF18UKG0nvgK+9Qmxjgh9vYDKCt3c5WI1VdEfuKTwE85sMf/U/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hcjsm91ITyWWbjPXLNtqHysQOQLl9sLnTqXDEkfVm4=;
 b=cBZrxhOLhN+WiHsuIYQuHvQVfEJYw+VfvzVX6LtLg2kGYUudMOBhD0K4r1h5X8i+hcOjGEZEugsbGlbHLPedK75zo8ZeBcxAYAbIP24+14oIcN+I8Kv1K1RpmWevux+4KiJ8MVYGac/4appNZXf09l+9G0piaDvkB7RKxwjh8YSgXqRpxl3MdyraJ/amCzr8BlIe4kx98fM8/BiWHTAXYchWlCg/LXEy7kAemmtUwqFwc+BSMeGdOente1yF/u9KOjddWP6TzfoRZkUhzAKnNb88+kWmLIaPY0De3KgnrNIY/aJGp6YDLNEPA/csP7Li5y2TxLlv8gRlt3zKIh44/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hcjsm91ITyWWbjPXLNtqHysQOQLl9sLnTqXDEkfVm4=;
 b=dDtAQXPa6hcDN801DSEvaYPaCCj9bEobNzBSPhBrB5OQWJgTslmDAd0izMnqbWtXrHGA7UH9UslThSCFzY6jD/cNIYcS20Z3ZTrUAjVXEHS2EqTxvzefaJU1s5zE5vqs+lQ7jIFmxffsYgzr2rXnAB0O0VI7D2mysjutBJ+Jdaw=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 07:34:06 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 07:34:06 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use default reset method handler
Thread-Topic: [PATCH] drm/amdgpu: Use default reset method handler
Thread-Index: AQHZ4LT9yJQQ/q2RkUaZQTbPs1Gr/7AO+TvQ
Date: Thu, 7 Sep 2023 07:34:05 +0000
Message-ID: <DS7PR12MB6071691C187EEB1CC1C7E29B8EEEA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230906112611.966038-1-lijo.lazar@amd.com>
In-Reply-To: <20230906112611.966038-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=07804193-7d30-4347-a7dc-787011735453;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-07T07:31:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS0PR12MB7582:EE_
x-ms-office365-filtering-correlation-id: a866146a-bc6f-49ab-4316-08dbaf74d100
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Nhu4VBAFX2GjvYC0fmvvxw0oi4YiBwvaS5BvGxpgMT1va0GMWOr/KwjAc5m7y8der+kFCFbwEd8uQtgEQLjksjt3qYTJxvfP/m4TCGbBc7fYdGhmFjAj8jS5YPSAekz/nXWK5B5rinPHaxjElJUKRzWgQTKw9V4lKZgBgwkrrqCzSx/m1y+94iBSvI6lkCpApOzqEo6Q23dB1nipEiMYfBdK5KypJbVj9wVPqrOzuDK+SWOCcrCG/VFc0USnXa2NQhPuhohUAUiAhWrO8cTgM0d3k/LINQolfMCCJqZqs78lKVWct2xlhhxmSuTuTUtOdGa66Mufqs/KRAis4sQ/ZK3vun8CpcIEnILUgDc4zLyiKHX5Kkh4Yu9VLxpsvdL2gDVj5YyhF762rATydBfo3kkc5ZWEXavfjk+bKTyMn0YUEu7w61Nen6YMZ6RGA9A8lTcU971WGXYUYErwpLY3pc3WI4Z8LDQiFLTX/8AEhZKSG/j4+0uVBri1jZtBi5J7jYuqLvQhwwk5tNv9NaqiYpZgWKKFolSMe6mhIsI0tt6l7OSTpWstswjaMcYd+75Ib/RsTh5TuVT1Lu0gZmQUGcf6wK1RGuJJM1DLhlamST+bMZVy7oDvpaQoP+4AzrR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199024)(1800799009)(186009)(66476007)(64756008)(54906003)(316002)(66446008)(122000001)(33656002)(71200400001)(86362001)(110136005)(66946007)(76116006)(66556008)(2906002)(8676002)(41300700001)(52536014)(8936002)(4326008)(5660300002)(55016003)(38100700002)(38070700005)(478600001)(9686003)(26005)(6506007)(7696005)(53546011)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FBCr7GHPW5/YYQYKHM+S3fpcLW1i2cltYKRA9r3iSl4g2QfSKCpNAZYnSwNW?=
 =?us-ascii?Q?FCszUsMb865ayuYwh0KfKvac+0Lbe6OKS3HYgdQF7c3wY9crecGo3z7vL8Xh?=
 =?us-ascii?Q?vr9CHRNlnlWuEBn3UPaw78v/Cz62khKAPV5IN9h1qmlpx6KXp2BxfBpa57xZ?=
 =?us-ascii?Q?3iPOX7gYuoeu46raB7hTujPMWiTsTEc7WdWgFmfR895aYWaFegsJiuADJ+TZ?=
 =?us-ascii?Q?kWJAlgNjs+fF/z44VTEj32BMkTQg0/C0I98uGzVKSijf265XSmBlh95u+UrH?=
 =?us-ascii?Q?EFxgHTGfRRZWmSgTi4sEWi6FVTzQPjGifKf35ZousCo3tiTT3PjYDcG4yqJm?=
 =?us-ascii?Q?YQLBtZGC+ks7/j/cbY9VtKoXNA/ZoDDIwi6V6j/2/xY8fMAhWQzgMd8YJhcG?=
 =?us-ascii?Q?qxX11+nW6Qm/4t8youiMLa77D9ixZEnpaxmiuyQ03tL31oMbYv3MSyVpuXHE?=
 =?us-ascii?Q?8lDg9dg9qyYV/f9bNyuaDGd1FaZQCXT/86RKoM0mUb9X5ktd0fEyBwaG7Bis?=
 =?us-ascii?Q?Yd7vstXR5UGAI2s27hVqj5ZsN1be48XcgzctHvvuQeFH14NhPlTNJMlHo3F/?=
 =?us-ascii?Q?OLG2BZea2s+/E/sX/2IphfjAoIChi6RsC2/WnyrQSuATGee/T10Aj5WCcAW+?=
 =?us-ascii?Q?S3PLE/OjPMph52ydA4XZ6HosCyNvEaHE164rV5L+QnflnTGK6gQZRwvQIJqv?=
 =?us-ascii?Q?l2wOVRPkamThqrWqFPcj6btPqa/brDsO2jFI/ct3B5VXlwfczw/sn5TPUIJJ?=
 =?us-ascii?Q?VO1UTIEKqq6yl/89cHXPq5XhfdLokYLTuVYJadgv+9ZGJNN2KnbqPLzM6KGB?=
 =?us-ascii?Q?JGAfNo8Nr4PP9eZv4CBfNvdKwyQjqIfv/fvexPDs92I0oDenBXdXCfWBiXym?=
 =?us-ascii?Q?iw5dUJUxbBDxYGtS6xF/wjSoLX6UO+OMMFmrja3HbEbvFfQQggrlGAzaIg7z?=
 =?us-ascii?Q?baa6hqLYoq3Hh+JbXD8piSZG8+svG/6vM2pvbuHGdqY/m3pK4lMeKi3+dK2i?=
 =?us-ascii?Q?Hls8UIFUjehL69jRcjF1HOrZ9zxloggKovqTJdbwPmooAC3nB6sscU7hDkYv?=
 =?us-ascii?Q?inaqkx1+gSidCMiXbFV0sudo4zQQh/SxOmr6HVRWnBJsG9eexLN1fZuTC11Y?=
 =?us-ascii?Q?EbPni6kCBBVoBUlNKNpplaE6Bo8UkqZ3xkuLqGYIPmOXil3PGNezGKrvxtPX?=
 =?us-ascii?Q?mzO1BZ5j0/Db+owe0nc9J1KLlFzHQ1azi+G7r0GmtMh4SuB1TycFMMe/nveH?=
 =?us-ascii?Q?Rf1imcXYaTSwXpckAWBLGPx9aRZA2MufpLdxRGeO+zVEUtmA0fttpq4hKX2v?=
 =?us-ascii?Q?Y7r9uXfaH3AklugMEftRKlGWmTbk5cGnFZdAUrjMlfi/ghGUs5mZ4KsA0YGW?=
 =?us-ascii?Q?F621YRN8wP29DsjOF2sh1Rvayc4yTpgVlWVywPl9x+ZAMYKAYX2V2lP1TJPZ?=
 =?us-ascii?Q?8mPqaOAVWvd57d6PbXTemqsZeMXQYvYeRgvWg2GQu2EdDV6Sa4lF2jewf1La?=
 =?us-ascii?Q?57n1ds0HGlLDSKp/NgNb9nkMsvgngdn5ygHNbNTOKK7ZxkBhMkNbbEDB0Z1W?=
 =?us-ascii?Q?5PmYwHOQMKhPzuDi7fo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a866146a-bc6f-49ab-4316-08dbaf74d100
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 07:34:06.0194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfzYJnkMnX+SvjrwntiT3nECVyKymFK+WUBD6JtgolEcsAc+Vy8ju7jX2NKAtK9k7r26ssFydftjl9Mtz2JdRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 6, 2023 4:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Use default reset method handler

When reset method is not passed in reset context, look for the handler for =
default reset method. On Aldebaran, default reset method for SOCs connected=
 to CPU over XGMI is MODE2.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 82e1c83a7ccc..5d2516210a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -50,6 +50,13 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control =
*reset_ctl,
        struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->h=
andle;
        int i;

+       if (reset_context->method =3D=3D AMD_RESET_METHOD_NONE) {
+               if (aldebaran_is_mode2_default(reset_ctl))
+                       reset_context->method =3D AMD_RESET_METHOD_MODE2;
+               else
+                       reset_context->method =3D amdgpu_asic_reset_method(=
adev);
+       }
+
        if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
                dev_dbg(adev->dev, "Getting reset handler for method %d\n",
                        reset_context->method);
@@ -59,15 +66,6 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control =
*reset_ctl,
                }
        }

-       if (aldebaran_is_mode2_default(reset_ctl)) {
-               for_each_handler(i, handler, reset_ctl) {
-                       if (handler->reset_method =3D=3D AMD_RESET_METHOD_M=
ODE2) {
-                               reset_context->method =3D AMD_RESET_METHOD_=
MODE2;
-                               return handler;
-                       }
-               }
-       }
-
        dev_dbg(adev->dev, "Reset handler not found!\n");

        return NULL;
--
2.25.1

