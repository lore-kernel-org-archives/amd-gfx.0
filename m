Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76D5C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 22:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255C710E592;
	Fri,  9 Dec 2022 22:08:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0B410E592
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 22:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGlTNyuXhPwpmQAe4wIKuVaCe9jK9LLa9YT2C/j3H204H8YYrIedtUZzHWN3kshzFyV3X0fTLw8GP5Y0+QqJv8Gm/JMLJWdzp0GcO6395ci9rZm3H78fwEATMjqePjti/pjBgRxWyumVIe/qrKpX5Yj7200GkbkIjOQZ9imTwrXD0u9/vl3OTa0AKWkYptzNRibckB+YmgRgNOLnsqDOvkEQTI2NT3kgc6nHr9vxSPPT2d/+/lN/kot/PgU3ONJOx5xIV/GL2IuI+lWzoMkgjhLoZ/UBWO7LfR5WaHQ5WnHvZUPnbsKh5DOtHPhFhofwCk1YkE7rjeG9kCbj28Ve6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjNFk8P7dAo6sCToJ5rJH7SBhqlhl9EVTJeilP+hppU=;
 b=Mfs6p+Zb+zbC3Xs3Jf7h4rJvKb9NDOe3Oo83QYycoiKBRasJgjs+A0bfNBjlZw3hWTOUTMH6tYxhBxNy/LWIQHMfsvT9eiKHygO7vxdcklloKIIIxHGzauaDUcG9tkLf+pinHMzpXdhqM4yQXMXsT0KL8qqH2ron9KQcAv3LLdyrpK7IJ1pdLpIPSbU2HGr+3Gk2vGWZCuBL1QBZtzZSPYrqc2SFlKoE6ENPDRJyCxajUh8tc/KYE/uTU5IpDp7Kg5aqVK6MtpF4eQmm4nmzfHsBhlcRSdNiOtTvpjsMyVkEdkKuZCKzXKbEKusqByb2mOZH42LUBvE1wNXAJxJfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjNFk8P7dAo6sCToJ5rJH7SBhqlhl9EVTJeilP+hppU=;
 b=rs5F6j1vFK55PAfcLkFJA7V95G59STzkX1NWsJk1RS4GcEDsAcv4hbtzQxGARsAIM4jZ2BVYem52/rZs4pkBfD9gUYREjfoxYZYJlsXbWm1UVyjkYHy8lA2BWg8UlsE27zuOI8Hp1wL5eS5lrVxfzbbSQ9zT/gP6KFcLJ+ii0W8=
Received: from BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 22:08:26 +0000
Received: from BY5PR12MB4211.namprd12.prod.outlook.com
 ([fe80::595a:55f2:cb35:fdf4]) by BY5PR12MB4211.namprd12.prod.outlook.com
 ([fe80::595a:55f2:cb35:fdf4%8]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 22:08:26 +0000
From: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 11/23] drm/amd/display: Check for PSR in no memory request
 case
Thread-Topic: [PATCH 11/23] drm/amd/display: Check for PSR in no memory
 request case
Thread-Index: AQHZC+yJTasZiaBUNku+tBs6dTIycK5mFReAgAAIiHg=
Date: Fri, 9 Dec 2022 22:08:26 +0000
Message-ID: <BY5PR12MB421197AFC8FB60D9A388D3DDFB1C9@BY5PR12MB4211.namprd12.prod.outlook.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
 <20221209163647.25704-12-jdhillon@amd.com>
 <CADnq5_MPvhf-u14zUEqOtwKeFZEuHNqrks=gJfT9FrVZXbHpqw@mail.gmail.com>
In-Reply-To: <CADnq5_MPvhf-u14zUEqOtwKeFZEuHNqrks=gJfT9FrVZXbHpqw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4211:EE_|DM4PR12MB6037:EE_
x-ms-office365-filtering-correlation-id: fb15c8c8-4d58-4206-eee5-08dada31e57b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MnrzU0IN082KJaDm1Oh9vzHL0kjfNXeDz46lTc+AMTAPUK6qeDuUyyxol8U8E86hY7R9AQpCwkZvq8sSBRrMceEhoZfhUndaFMQ3RhV1BYmhn5wD2aceWwt8HtnvLc/8KS2cvJz01WkwSij/iZR8s6zlWsEno8qTZgthVspChmvOFEocWWVCejMvs3FmkcOCJ+kgcWWFVR9/7zmTTZ/i/wzwMBWlsNIr3Cb7rbjEGFIS/5n1tpGHxmOwbRbxE8jD2yykphGwfS7vu9K3lc9ce7yxKj2zJXHYgfMnD++89apQwnf7YBXDsws59j+cdhH1k+WBmD2pO6ZBDeOX/v2n93YsaZI9XjSJR08b4gF5vQKQdYps28nIj6dY6Djz+NCiIobTRfdKWpseRiLQcq1VDFqkJ1DVBWZSWevRg/Nt/CHwA7hfEPPbr6e90X/4xBLU3osIKRGoW6pwmcWsX5LGJLs/dM9fby5AALNqmrnTLMXH1TGIPhOaT+yo4YbmVgF1GlwaJsaTu5KoKdTwRfXBYGTR4/oGeWwKHr2eOAcEsJNhQN1+p3PG4SfGsxG6qAitRFuHIGqHF3iR5vZq9Snl4IqLkrJhjGNf/uO11ICivtTFK61Rp5uuFdqVKkuTDK+zZBZ/p80M1Il+Pq26UToXSex9dGjaVO3/owtjB+oQO0o8ka075446JLajx0Tabx82t1gKlJptNhJMr/MtB8tMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(83380400001)(38070700005)(2906002)(478600001)(71200400001)(5660300002)(52536014)(316002)(7696005)(53546011)(6506007)(8936002)(186003)(86362001)(26005)(41300700001)(38100700002)(6916009)(8676002)(66476007)(64756008)(4326008)(66446008)(122000001)(76116006)(66946007)(66556008)(9686003)(91956017)(33656002)(54906003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+mnsTW2783FDWDtJxKf4kzgXx6i+2gGbB/mhFqqcUsmIuHBG/R/jCX+s6O1O?=
 =?us-ascii?Q?ot2ff62q4JpjfybS479Wa6l2Ig7zZak7YufGhHHble6jVNv55/Re8hiu7zPn?=
 =?us-ascii?Q?GABXapHBEYKI4ytA2dRlkLtNDDc+94uy9y5rRoDhiMCKVZ62ytzaViI0OrZG?=
 =?us-ascii?Q?cdFF6dx2an9+PEG5onz5Y/gHN+oNdZxrCV7YYfXz52NhanI7oFPu3mATnIo+?=
 =?us-ascii?Q?T/8w7Rnk26EiLzjwaYeJuF2pB/UGhKmGVrAAJvukXgQFLr1PvmQYiSVnLLtR?=
 =?us-ascii?Q?O46+mabjp18YJib/4my/U1yYOtIY5F5VU2xTMnLkxpFycj1MhfbZiDC9C/99?=
 =?us-ascii?Q?rPBZhHltpyDMrS8MDBk9P9dfJctafIhxt/NwujEimdQXvC1Go9IU/c9iGwGH?=
 =?us-ascii?Q?i0ZWw3knpQDMtI24g9O/IvgvNR19RwGu2XD+TKLCpeKRBGGqiIlJcUUDBJTA?=
 =?us-ascii?Q?BZ5r9l1bFDMVf1yQmj54n1v0W/MdT/3E0p0IbVfz0IBT6HWaaROoSKXAlpxF?=
 =?us-ascii?Q?r0GkMStfUv2tWRaG+fUXScSZyc7yn28IMpD78nLt/aQgehBK39GnEf+iiSSG?=
 =?us-ascii?Q?1NlIBktVO3+7rIWKPreixFVns3pz6wnTxgaCKuUWe9Kq3WCQ5OSmzu7hSXS4?=
 =?us-ascii?Q?L4EDzhGNsoB5usH6tqxzefLuI8Ibbj2MbfFkE30/Z+k+3OxLtjZiwb504mMc?=
 =?us-ascii?Q?qRIzOqd77d3WkzS1l8cA+kARTKjWZ4sqCENG385cVONcyy/PukjRApFF5Dxy?=
 =?us-ascii?Q?yZTmd/kpqlSO1WJBGOEmRsUoqgQ982mM6wAj5D41OuajQFF+GPb2H+VSL311?=
 =?us-ascii?Q?tL7f2rkHVc5iqQS6WijhcGkBIMn0c6SSv9qrcX2lrDQtCst7HD99rCFrpHu5?=
 =?us-ascii?Q?zAmUbnnMOPhcUGhDZr4PSv7y53wNkwCaF/ncEpvzlyCIgvCVpzMAoHZqcUTz?=
 =?us-ascii?Q?vQANFVH6peXrqvDSwSFzj6vPaqJwa4n29ywVTvT2tibKF7K4rOaBQrWkjVhy?=
 =?us-ascii?Q?4X4c4tCbLbi9XIG37p0hqcFgSgX7FnAtCBOUoC6vy4maHkSql091tP+K28m7?=
 =?us-ascii?Q?3DHbXT2TB1P0VKds4fZ5/gnZvEmETRXG1067kAHX/WizszLmjgvIKI4w1mQ8?=
 =?us-ascii?Q?XLACH90jtq+B/auiizmt+KFVWKf6O06TWfrgkD2v5OC5YzagvtSolRj/uPOB?=
 =?us-ascii?Q?jiZfu9/iUeCS3+mgTbaLrppX+oelXUB8QJvAitEquV+Zi0H9c1ewWKQvEa9+?=
 =?us-ascii?Q?bpPiXS59Cz2csMLh6bTzkREBRARyF5uwXHLvvJ96b7AdiET/232KxGEvt3ul?=
 =?us-ascii?Q?o+yQ1x6SkiZ0DH0wHLRu6AoHRFvxrYESBRUBuU69m+Pb+4NXlTVkxZqyKW10?=
 =?us-ascii?Q?cANJS8SjaBqxw4zsP2ttHIXYhO6OJnpkesU+U69CtWnxQewRKTteiRcuwILh?=
 =?us-ascii?Q?JFyCj7rvq2suPVZt/b/H58mXwQkjl5tmOC4Tep36+IOSJybwyy4NJHKfEllf?=
 =?us-ascii?Q?AKrkUMMJfYBbdxWdfOnBWxq6acN7yxf5iqQpstluxnMVsxsCfuCHiSVziL8+?=
 =?us-ascii?Q?ZGjOmBC3+rXRmHWC4YI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB421197AFC8FB60D9A388D3DDFB1C9BY5PR12MB4211namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb15c8c8-4d58-4206-eee5-08dada31e57b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 22:08:26.4236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppsX4GQrka552bxdTI6NcN/mUp/PwEXOBor1iFB8yJB3KmkdFAE0CtwGWY9HTUJyOFUQaWJjOKGMr5JiYULnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Tam, Samson" <Samson.Tam@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB421197AFC8FB60D9A388D3DDFB1C9BY5PR12MB4211namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fixed

Regards,
Jasdeel

________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: December 9, 2022 4:37 PM
To: Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Wang, Ch=
ao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.c=
om>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qi=
ngqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Rom=
an <Roman.Li@amd.com>; Tam, Samson <Samson.Tam@amd.com>; Chiu, Solomon <Sol=
omon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lee, Alvi=
n <Alvin.Lee2@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet =
<Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>=
; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: Re: [PATCH 11/23] drm/amd/display: Check for PSR in no memory requ=
est case

On Fri, Dec 9, 2022 at 11:38 AM jdhillon <jdhillon@amd.com> wrote:
>
> From: Samson Tam <Samson.Tam@amd.com>
>
> [Why]
> When we have a PSR display, we will not be requesting data from memory an=
ymore.
> So we report back true for no memory request case.
>
> [How]
> Check for PSR by checking PSR version in link settings
>
> Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
> Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
> Signed-off-by: Samson Tam <Samson.Tam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 9 +--------
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ++-
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dc23801de071..6a6e4c844316 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8359,10 +8359,7 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_state *state)
>                         new_crtc_state =3D drm_atomic_get_new_crtc_state(=
state, &acrtc->base);
>                         old_crtc_state =3D drm_atomic_get_old_crtc_state(=
state, &acrtc->base);
>                 }
> -<<<<<<< HEAD
> -=3D=3D=3D=3D=3D=3D=3D
> -
> ->>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple disp=
lays)
> +

Please squash these in with the patch that added them.

>                 if (old_crtc_state)
>                         pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c=
-chg: %x\n",
>                         old_crtc_state->enable,
> @@ -8425,10 +8422,6 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_state *state)
>                                 DRM_MODE_CONTENT_PROTECTION_DESIRED)
>                                 enable_encryption =3D true;
>
> -<<<<<<< HEAD
> -
> -=3D=3D=3D=3D=3D=3D=3D
> ->>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple disp=
lays)

same here.

Alex

>                         if (aconnector->dc_link && aconnector->dc_sink &&
>                                 aconnector->dc_link->type =3D=3D dc_conne=
ction_mst_branch) {
>                                 struct hdcp_workqueue *hdcp_work =3D adev=
->dm.hdcp_workqueue;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index b8767be1e4c5..2f0ebe1f6c45 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -188,7 +188,8 @@ static bool dcn32_check_no_memory_request_for_cab(str=
uct dc *dc)
>
>      /* First, check no-memory-request case */
>         for (i =3D 0; i < dc->current_state->stream_count; i++) {
> -               if (dc->current_state->stream_status[i].plane_count)
> +               if ((dc->current_state->stream_status[i].plane_count) &&
> +                       (dc->current_state->streams[i]->link->psr_setting=
s.psr_version =3D=3D DC_PSR_VERSION_UNSUPPORTED))
>                         /* Fail eligibility on a visible stream */
>                         break;
>         }
> --
> 2.34.1
>

--_000_BY5PR12MB421197AFC8FB60D9A388D3DDFB1C9BY5PR12MB4211namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>Fixed</div>
<div><br>
</div>
<div>Regards,</div>
<div>Jasdeel</div>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> December 9, 2022 4:37 PM<br>
<b>To:</b> Dhillon, Jasdeep &lt;Jasdeep.Dhillon@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun peng (Leo=
) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt=
;; Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira,
 Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&g=
t;; Tam, Samson &lt;Samson.Tam@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@=
amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Lee, Alvin=
 &lt;Alvin.Lee2@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Lakha,
 Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Gutierrez, Agustin &lt;Agus=
tin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;Pavle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 11/23] drm/amd/display: Check for PSR in no memo=
ry request case</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Dec 9, 2022 at 11:38 AM jdhillon &lt;jdhil=
lon@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: Samson Tam &lt;Samson.Tam@amd.com&gt;<br>
&gt;<br>
&gt; [Why]<br>
&gt; When we have a PSR display, we will not be requesting data from memory=
 anymore.<br>
&gt; So we report back true for no memory request case.<br>
&gt;<br>
&gt; [How]<br>
&gt; Check for PSR by checking PSR version in link settings<br>
&gt;<br>
&gt; Reviewed-by: Alvin Lee &lt;Alvin.Lee2@amd.com&gt;<br>
&gt; Acked-by: Jasdeep Dhillon &lt;jdhillon@amd.com&gt;<br>
&gt; Signed-off-by: Samson Tam &lt;Samson.Tam@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c&nbsp; | 9 +---=
-----<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ++-<br>
&gt;&nbsp; 2 files changed, 3 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index dc23801de071..6a6e4c844316 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -8359,10 +8359,7 @@ static void amdgpu_dm_atomic_commit_tail(struct=
 drm_atomic_state *state)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n=
ew_crtc_state =3D drm_atomic_get_new_crtc_state(state, &amp;acrtc-&gt;base)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o=
ld_crtc_state =3D drm_atomic_get_old_crtc_state(state, &amp;acrtc-&gt;base)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&lt;&lt;&lt;&lt;&lt;&lt;&lt; HEAD<br>
&gt; -=3D=3D=3D=3D=3D=3D=3D<br>
&gt; -<br>
&gt; -&gt;&gt;&gt;&gt;&gt;&gt;&gt; 667f52144b9a (drm/amd/display: phase3 ms=
t hdcp for multiple displays)<br>
&gt; +<br>
<br>
Please squash these in with the patch that added them.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (old_crtc_state)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
r_debug(&quot;old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o=
ld_crtc_state-&gt;enable,<br>
&gt; @@ -8425,10 +8422,6 @@ static void amdgpu_dm_atomic_commit_tail(struct=
 drm_atomic_state *state)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_MODE_CONTENT_PROTECTION_=
DESIRED)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_encryption =3D true;<=
br>
&gt;<br>
&gt; -&lt;&lt;&lt;&lt;&lt;&lt;&lt; HEAD<br>
&gt; -<br>
&gt; -=3D=3D=3D=3D=3D=3D=3D<br>
&gt; -&gt;&gt;&gt;&gt;&gt;&gt;&gt; 667f52144b9a (drm/amd/display: phase3 ms=
t hdcp for multiple displays)<br>
<br>
same here.<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (aconnector-&gt;dc_link &amp;&amp; aconnector-&gt;dc_sink &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_link-&gt;t=
ype =3D=3D dc_connection_mst_branch) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_workqueue *hdcp_=
work =3D adev-&gt;dm.hdcp_workqueue;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
&gt; index b8767be1e4c5..2f0ebe1f6c45 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
&gt; @@ -188,7 +188,8 @@ static bool dcn32_check_no_memory_request_for_cab(=
struct dc *dc)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* First, check no-memory-request case *=
/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; d=
c-&gt;current_state-&gt;stream_count; i++) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dc-&gt;current_state-&gt;stream_status[i].plane_count)<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if ((dc-&gt;current_state-&gt;stream_status[i].plane_count)=
 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dc-&gt;cur=
rent_state-&gt;streams[i]-&gt;link-&gt;psr_settings.psr_version =3D=3D DC_P=
SR_VERSION_UNSUPPORTED))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
* Fail eligibility on a visible stream */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BY5PR12MB421197AFC8FB60D9A388D3DDFB1C9BY5PR12MB4211namp_--
