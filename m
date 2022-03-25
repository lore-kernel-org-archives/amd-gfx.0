Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C111BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 20:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6D889F43;
	Fri, 25 Mar 2022 20:43:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492F889F43
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 20:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP9qiyp2HgZ5zn/Zkqx8IBCG+qsRwKslnf5STZVNmeN6n/0dWm1Dj9BD0JOtfUiSODMnfGYln3QCTeRGpVd2BUIsDwuAAzjlcQkhrKU1CD7Ax88FhMjxDyDtvD98OKszCaWCKYwLLpex71t2zNp+nvVXU7FIYVhgeGpZB3Ndyw/KvTg3F1INcUGcbEhSEqS+QtgHWlKW6Z6Np/61RnLLkxix6laYcYJyZUtHO7CyWDUBTh6YfRYfA0ibKPNLTPyiPOQeX8ACOuW5EVXhTknGh/blCWE4K19OI4jgvUwNIL7cQ/SQ4ivedwUZD+OMrF3eZMc7xyRFU5+6WuZ9shk/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5iIUlSmIjvbwV2hsvjQE1iJn4/Rlx351gnJv5yHR94=;
 b=mCq0ImHcjcu8I3tsSryIIDxe1XiYGrY0ryYcuyIZGOWvAH1bWUPW9aUOV8YPgXgRway8fdZ/Dql2mCvnU2UEZkkfK+RxmFZoteSgb4tLMGm4DKNjM5pa2GjECGXIfu1Z7PKZL+i0x+EBrDkmT7855aeb/biqh47lspGEm65q06zlGhBZPodjStiMCLobu+moQJpFbVquT3VX6uEY34dHyadMgfg0zLFHAQC3AcIPcbkO7Js88pMutli3HwmJrdA6bATNRogLdBLzn/aaNuLjkKTTk0jpVgafkgJX2KpP6kfMYx1OcAxm0FTdVT5W2AwL6Hxj1MvQZu3yIOrg3CWvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5iIUlSmIjvbwV2hsvjQE1iJn4/Rlx351gnJv5yHR94=;
 b=x5WXL4TD7+6LxU3yezfqPIO+w9Fv6FhrGbhqwQPye0LayBudvcIeYon+CdW0qAepXCrBsKdRHl+Cl4+cSf0qZu5s31fQjfb0/yRO2Sjfqq3I5D/sGQZbe8KZfR7tWuSV9UbBV4feVQPs2qD1cOQlyYRh9lCgiCRecEfv8KMZFDE=
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 20:43:00 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::c458:f902:1a9:cd1]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::c458:f902:1a9:cd1%7]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 20:43:00 +0000
From: "Hung, Alex" <Alex.Hung@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 01/13] drm/amd/display: HDCP SEND AKI INIT error
Thread-Topic: [PATCH 01/13] drm/amd/display: HDCP SEND AKI INIT error
Thread-Index: AQHYOxHozWv6QX0h606O1tUxK+B0GKzGTH0AgApN7rU=
Date: Fri, 25 Mar 2022 20:43:00 +0000
Message-ID: <BYAPR12MB3048EBCE33104856A122B89BF71A9@BYAPR12MB3048.namprd12.prod.outlook.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-2-alex.hung@amd.com>
 <7efe6fd0-9dd2-fa80-54f7-2186b4d64721@molgen.mpg.de>
In-Reply-To: <7efe6fd0-9dd2-fa80-54f7-2186b4d64721@molgen.mpg.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-25T20:42:59.582Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: a2911e44-4db1-32e0-85af-acc52ced736d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13ada33c-2817-4ece-2717-08da0ea00d17
x-ms-traffictypediagnostic: BN9PR12MB5260:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5260DEBEDE3FEC403C082587F71A9@BN9PR12MB5260.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6PI3YQ8a77MiGee7iiA7Vf/N2HJ2ybzVGfnN53+xP1O64XFpldmImkSUlAOzTNFNG61z4cjqpauhNkzwRzgaYXwSe3TkJz+dd8bjUuadsU6fhi0rfV02turkcbGdak0HczTUhVbjqK+3O1ldrGU3cQw0JACAT4wCfhW4v6nFydjbrsEoo61Q8jT+Si9wu4iVsO9WZwuvdbMz1IsMpNxKv7SFww6QbpXsqF4hS0uhL3Dm6Lwy7Il3Qpxw8kTn1XfQkmmEl8P8WINFAXSBCF1gXuQTvO/4eCL5AoKP3rxRqMmFwRe7JWUA+qNm6dkiMHP1IO5MPqCBm7MADddXYIpghUj23GTK/ESZk+AlNae6ZanPDngxG+FwtowganCmAM9AhnzMkMYkgf7Aiyd4aJYeCd9M2MlCsQD4FcDR2OTSS9KJD/HtAqAl2pGydpCIIaA+kPY57MiHBAq6FmrQAHZ3rWJ5RpKgcfpE+s6LlMJp6IQm1mB0XgEK5EJLLut1q+efONxPM9wyWvDjvn5Uw6j9zEiHIDPkGOqqWnyVoAYw/ZjtdbVJX52VnCfkz9d8i7PyazsRelsJQ98dIY8tWY+esiCIsgF7UrsVUBdbaIvX5RoE1IWMiIb4ok6lTjyIrMpmQXzGQpepCZQf8q10z7xt8yz1tKj1sbtHqm/ZSMIELSWDY7hXD2PWnASzXwN/2KiRzmD+C6hDbA64N1JEsEp5TwnL48+WrLWGbKfyH0yziz4gAQo+2VRT+Jnwk+ngXihhf2oZs0MtaIvOEKfZbK5gO/xlO2I1+DAvkhDppTBLlk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(5660300002)(83380400001)(7696005)(66946007)(66446008)(6506007)(66476007)(66556008)(316002)(19627405001)(186003)(38100700002)(166002)(45080400002)(2906002)(508600001)(8936002)(4326008)(38070700005)(33656002)(966005)(52536014)(8676002)(6916009)(86362001)(9686003)(55016003)(71200400001)(91956017)(76116006)(64756008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?zTsdX+vVIoh0UraiXbV/vFVGhl7PUs1S6sCRra3xyGAuCAsx9fPW6Je3?=
 =?Windows-1252?Q?j9wOPbdkQd2SxDfpXuB2pYGt5JNWtxMYjbHZi8jihtth2Epai1g/uK3q?=
 =?Windows-1252?Q?q4BR2YhciXEP32hflOUut61rvHegTYD8XqhgDUPxJIiF+KXGOblERfNz?=
 =?Windows-1252?Q?JBFV2gbRis6m5EjM7bwi2WFbU5qkqoPe5r7mPu61tpOZtBHpU00+TsT+?=
 =?Windows-1252?Q?Ud0LEu7GxaehJC9zT3caf7ZFEBs92BiNN4EWaJLYZAE2C2XnHWBQ+KU3?=
 =?Windows-1252?Q?YTfjbhcIccSiuuhbkYMjQxkUxXcc3UvY2B5C98TLnW/Xr6BEbPqKwPMW?=
 =?Windows-1252?Q?HWs3MImIsvNc+fb1EQo6VqiQi7Sc9MV/JulALuh5s9vYVUWgo+gQi49Y?=
 =?Windows-1252?Q?fMpn5Rz30G7ro3TZiMGNy6HyMzgWst4HXMQzglh0av1mHH/+QVKlLWck?=
 =?Windows-1252?Q?iM1tcQq7PEPH4NlR48awkgg0hj6JQ9Bo8x/9zCkjEG/YgsKmdyCPKV0q?=
 =?Windows-1252?Q?0q8pVccwkPY5bTE9wVOXlLMl0C+mmxxMblKkh74BsU32qUqsyUWkqfy0?=
 =?Windows-1252?Q?CtvTXyS+gR2Rlarf9RyEq3714JKzjRSiJGFg5X/yGIPnoWgHPtFvcYmP?=
 =?Windows-1252?Q?hSJwCt4vKSv/ykBb/P0ib0oDr137s9rTgLvbs3NTwJAeZ4FhybNdf4ZR?=
 =?Windows-1252?Q?hSEiKlfU/6MpTQ3RGE3ZJRx82gFUtzuAax96jj4HQiVWjet0opGi5abU?=
 =?Windows-1252?Q?t0Mg0i2s4KdTLQNKSGApsHNi3AhbZpnvAZg4UwTDd0vrtWR1cvuoGlor?=
 =?Windows-1252?Q?H8u53yQhY4LSeljdx0LSYM+9q2M1NoOQfezBLcR3i2weOuYGKQ9TrYuZ?=
 =?Windows-1252?Q?H8IOwlmvYdV3MjgPoCh8wOMeD8LNjmYmmZxrDZ3nGj98IT0dRh+o4US+?=
 =?Windows-1252?Q?xiOJkgTzXj3HKgIioc41M0UsciZ5LVB3oGBwcKiJaLuPNqCcuTHiNspy?=
 =?Windows-1252?Q?TWXDeZvFw4V88EK8j3YErPJoFidnKoZiqJF7imSCP2huc96bzVWXdX8f?=
 =?Windows-1252?Q?1ojXxi6L2EZFCy+QpebO/B80NunPuRy4uZ3/8t8ZQv5dhLYxIYH3vevh?=
 =?Windows-1252?Q?AUK0bT0HQS8+i7IR6l70TcZmgUtgF3NEDhjCQzDaKhCkxEPSQhKXRX9T?=
 =?Windows-1252?Q?QKUGbITo2NVRur8uzaF0UcN6TDCx1aomEDyxfwLHWFZaXrX6aMfpuwsC?=
 =?Windows-1252?Q?DRx/rkEtkg1PfV4Bey4gJ5/fLzSWDXq+EtDFEvYp1FGhQYK36WEthUW8?=
 =?Windows-1252?Q?sM2DcsMSsmUm2DdDGtj0LK/bS48X/hJFyLKh6nPejyJzrCVjSSwvuG+4?=
 =?Windows-1252?Q?rHBVXTQQBkyRWsXB9gvaBnuIjRzsDqeUpvaN/H5PTEKMd4s3HHSUj51v?=
 =?Windows-1252?Q?TY5bQ+YABLNOoDAdMXwYG7yvImRN8u4dYLGJkLD1TlOAlrdh7cYOgdyf?=
 =?Windows-1252?Q?OoQPAfMX+BEBwIU0graV59vjTyphEXzAlzCVJBvN1s3OMUbnvUfsixM2?=
 =?Windows-1252?Q?FlQ9wt/A9Da9UGWd5o+XzAhxcWWZ8Uy++032UqHep7HGLMUnhYudDSv3?=
 =?Windows-1252?Q?n6Vp38uES9D5XyhuMy+ywhNPU2WmzaxaPW6RNK4ccsEwSiGk3Ophnmgi?=
 =?Windows-1252?Q?IBzohQpFSsY/+hOCd3ICnor7KBDZ626rDxt29haYGiaDlrSXWpjAtLKe?=
 =?Windows-1252?Q?UorAhmi0uJYw5+ybgZ4NksBH3reCopXrFTcOeFOicm2a1WjixjzHWJnF?=
 =?Windows-1252?Q?TCMR8Rp1z5fUUK1PXtiu/iwJk6TbA+SsUeIY738wpe6NnQkWCnWhbclS?=
 =?Windows-1252?Q?O4KueV+AEQSuTpZzztZ0yPsrLeQkC1517Fw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB3048EBCE33104856A122B89BF71A9BYAPR12MB3048namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ada33c-2817-4ece-2717-08da0ea00d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 20:43:00.2898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ePoEk5C4CNKOY5+OCJunEaS6wRexVw7WozXW2trSFsRYrFmze9YZm0XKrQREixxgsSJR63t+utD/c9coVHIN5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB3048EBCE33104856A122B89BF71A9BYAPR12MB3048namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Paul,

Thanks for your feedbacks. I fixed many errors and typos you highlighted in=
 this series. In cases where modification requires re-testing we or anyone =
can have follow-up patches in the future.
________________________________
From: Paul Menzel <pmenzel@molgen.mpg.de>
Sent: 19 March 2022 01:16
To: Hung, Alex <Alex.Hung@amd.com>; Othman, Ahmad <Ahmad.Othman@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Wang, Ch=
ao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.c=
om>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qi=
ngqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Rom=
an <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabi=
ndo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Liu, Wenjin=
g <Wenjing.Liu@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gu=
tierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac=
@amd.com>
Subject: Re: [PATCH 01/13] drm/amd/display: HDCP SEND AKI INIT error

Dear Alex, dear Ahmad,


Thank you for the patch.

Am 18.03.22 um 22:47 schrieb Alex Hung:
> From: Ahmad Othman <ahmad.othman@amd.com>

Could you please make the commit message summary/title a statement by
adding a verb (imperative mood) [1]. Maybe:

drm/amd/display: Fix HDCP SEND AKI INIT error

> [why]
> HDCP sends AKI INIT error in case of multiple display on dock

What is the test setup exactly, and how can the error be reproduced?
Does Linux log something?

> [how]
> Added new checks and method to handfle display adjustment

s/Added/Add/
s/handfle/handle/

> for multiple display cases

Why are these checks and methods correct, and what do they try to
achieve? Is it the HDCP(?) specification?

> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Ahmad Othman <ahmad.othman@amd.com>

Could the order be reversed, so it=92s clear that the Signed-off-by line
came first and not after the review? Or is it actually signed off after
the review again?

> ---
>   .../gpu/drm/amd/display/modules/hdcp/hdcp.c   | 38 ++++++++++++++++++-
>   .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  8 ++++
>   .../drm/amd/display/modules/inc/mod_hdcp.h    |  2 +-
>   3 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gp=
u/drm/amd/display/modules/hdcp/hdcp.c
> index 3e81850a7ffe..5e01c6e24cbc 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
> @@ -251,6 +251,33 @@ static enum mod_hdcp_status reset_connection(struct =
mod_hdcp *hdcp,
>        return status;
>   }
>
> +static enum mod_hdcp_status update_display_adjustments(struct mod_hdcp *=
hdcp,
> +             struct mod_hdcp_display *display,
> +             struct mod_hdcp_display_adjustment *adj)
> +{
> +     enum mod_hdcp_status status =3D MOD_HDCP_STATUS_NOT_IMPLEMENTED;
> +
> +     if (is_in_authenticated_states(hdcp) &&
> +                     is_dp_mst_hdcp(hdcp) &&
> +                     display->adjust.disable =3D=3D true &&
> +                     adj->disable =3D=3D false) {
> +             display->adjust.disable =3D false;
> +             if (is_hdcp1(hdcp))
> +                     status =3D mod_hdcp_hdcp1_enable_dp_stream_encrypti=
on(hdcp);
> +             else if (is_hdcp2(hdcp))
> +                     status =3D mod_hdcp_hdcp2_enable_dp_stream_encrypti=
on(hdcp);
> +
> +             if (status !=3D MOD_HDCP_STATUS_SUCCESS)
> +                     display->adjust.disable =3D true;
> +     }
> +
> +     if (status =3D=3D MOD_HDCP_STATUS_SUCCESS &&
> +             memcmp(adj, &display->adjust,
> +             sizeof(struct mod_hdcp_display_adjustment)) !=3D 0)
> +             status =3D MOD_HDCP_STATUS_NOT_IMPLEMENTED;
> +
> +     return status;
> +}
>   /*
>    * Implementation of functions in mod_hdcp.h
>    */
> @@ -391,7 +418,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct m=
od_hdcp *hdcp,
>        return status;
>   }
>
> -enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdc=
p,
> +enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,
>                uint8_t index,
>                struct mod_hdcp_link_adjustment *link_adjust,
>                struct mod_hdcp_display_adjustment *display_adjust,
> @@ -419,6 +446,15 @@ enum mod_hdcp_status mod_hdcp_update_authentication(=
struct mod_hdcp *hdcp,
>                goto out;
>        }
>
> +     if (memcmp(link_adjust, &hdcp->connection.link.adjust,
> +                     sizeof(struct mod_hdcp_link_adjustment)) =3D=3D 0 &=
&
> +                     memcmp(display_adjust, &display->adjust,
> +                                     sizeof(struct mod_hdcp_display_adju=
stment)) !=3D 0) {
> +             status =3D update_display_adjustments(hdcp, display, displa=
y_adjust);
> +             if (status !=3D MOD_HDCP_STATUS_NOT_IMPLEMENTED)
> +                     goto out;
> +     }
> +
>        /* stop current authentication */
>        status =3D reset_authentication(hdcp, output);
>        if (status !=3D MOD_HDCP_STATUS_SUCCESS)
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gp=
u/drm/amd/display/modules/hdcp/hdcp.h
> index 399fbca8947b..6b195207de90 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> @@ -445,6 +445,14 @@ static inline uint8_t is_in_hdcp2_dp_states(struct m=
od_hdcp *hdcp)
>                        current_state(hdcp) <=3D HDCP2_DP_STATE_END);
>   }
>
> +static inline uint8_t is_in_authenticated_states(struct mod_hdcp *hdcp)
> +{
> +     return (current_state(hdcp) =3D=3D D1_A4_AUTHENTICATED ||
> +     current_state(hdcp) =3D=3D H1_A45_AUTHENTICATED ||
> +     current_state(hdcp) =3D=3D D2_A5_AUTHENTICATED ||
> +     current_state(hdcp) =3D=3D H2_A5_AUTHENTICATED);
> +}
> +

The compiler is probably going to optimize the four `current_state`
calls away, but maybe use a helper variable, so it=92s clear for the
reader the same function is each time. Also, why not put the helper into
`drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h`?

>   static inline uint8_t is_hdcp1(struct mod_hdcp *hdcp)
>   {
>        return (is_in_hdcp1_states(hdcp) || is_in_hdcp1_dp_states(hdcp));
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers=
/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> index f7420c3f5672..3348bb97ef81 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> @@ -294,7 +294,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct m=
od_hdcp *hdcp,
>                uint8_t index, struct mod_hdcp_output *output);
>
>   /* called per display to apply new authentication adjustment */
> -enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdc=
p,
> +enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,
>                uint8_t index,
>                struct mod_hdcp_link_adjustment *link_adjust,
>                struct mod_hdcp_display_adjustment *display_adjust,


Kind regards,

Paul


[1]: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fch=
ris.beams.io%2Fposts%2Fgit-commit%2F&amp;data=3D04%7C01%7Calex.hung%40amd.c=
om%7Ce0754902cc3545234c1508da097874f2%7C3dd8961fe4884e608e11a82d994e183d%7C=
0%7C0%7C637832710221132603%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DnixPwZB4AwGHz=
YIF3euukbDQcgJ0zE0GwzBQVIlUe2U%3D&amp;reserved=3D0

--_000_BYAPR12MB3048EBCE33104856A122B89BF71A9BYAPR12MB3048namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Paul,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for your feedbacks. I fixed many errors and typos you highlighted in=
 this series. In cases where modification requires re-testing we or anyone =
can have follow-up patches in the future.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Paul Menzel &lt;pmenz=
el@molgen.mpg.de&gt;<br>
<b>Sent:</b> 19 March 2022 01:16<br>
<b>To:</b> Hung, Alex &lt;Alex.Hung@amd.com&gt;; Othman, Ahmad &lt;Ahmad.Ot=
hman@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun peng (Leo=
) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt=
;; Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira,
 Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&g=
t;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Pillai, Aurabindo &lt;Aurab=
indo.Pillai@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Liu, Wenjing=
 &lt;Wenjing.Liu@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.=
com&gt;;
 Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;P=
avle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 01/13] drm/amd/display: HDCP SEND AKI INIT error=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Dear Alex, dear Ahmad,<br>
<br>
<br>
Thank you for the patch.<br>
<br>
Am 18.03.22 um 22:47 schrieb Alex Hung:<br>
&gt; From: Ahmad Othman &lt;ahmad.othman@amd.com&gt;<br>
<br>
Could you please make the commit message summary/title a statement by <br>
adding a verb (imperative mood) [1]. Maybe:<br>
<br>
drm/amd/display: Fix HDCP SEND AKI INIT error<br>
<br>
&gt; [why]<br>
&gt; HDCP sends AKI INIT error in case of multiple display on dock<br>
<br>
What is the test setup exactly, and how can the error be reproduced? <br>
Does Linux log something?<br>
<br>
&gt; [how]<br>
&gt; Added new checks and method to handfle display adjustment<br>
<br>
s/Added/Add/<br>
s/handfle/handle/<br>
<br>
&gt; for multiple display cases<br>
<br>
Why are these checks and methods correct, and what do they try to <br>
achieve? Is it the HDCP(?) specification?<br>
<br>
&gt; Reviewed-by: Wenjing Liu &lt;Wenjing.Liu@amd.com&gt;<br>
&gt; Acked-by: Alex Hung &lt;alex.hung@amd.com&gt;<br>
&gt; Signed-off-by: Ahmad Othman &lt;ahmad.othman@amd.com&gt;<br>
<br>
Could the order be reversed, so it=92s clear that the Signed-off-by line <b=
r>
came first and not after the review? Or is it actually signed off after <br=
>
the review again?<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/modules/hdcp/hdcp.c&nbsp;&nbsp; | =
38 ++++++++++++++++++-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/modules/hdcp/hdcp.h&nbsp;&nbsp; |&=
nbsp; 8 ++++<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/modules/inc/mod_hdcp.h&nbsp;&nbsp;&nbs=
p; |&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; 3 files changed, 46 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers=
/gpu/drm/amd/display/modules/hdcp/hdcp.c<br>
&gt; index 3e81850a7ffe..5e01c6e24cbc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c<br>
&gt; @@ -251,6 +251,33 @@ static enum mod_hdcp_status reset_connection(stru=
ct mod_hdcp *hdcp,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static enum mod_hdcp_status update_display_adjustments(struct mod_hdc=
p *hdcp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct mod_hdcp_display *display,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct mod_hdcp_display_adjustment *adj)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_status status =3D MOD_HDCP_STA=
TUS_NOT_IMPLEMENTED;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (is_in_authenticated_states(hdcp) &amp;&a=
mp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_dp_mst_hdcp(hdcp) &a=
mp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;adjust.disa=
ble =3D=3D true &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adj-&gt;disable =3D=3D =
false) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; display-&gt;adjust.disable =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (is_hdcp1(hdcp))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D mod_hdcp_hdc=
p1_enable_dp_stream_encryption(hdcp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else if (is_hdcp2(hdcp))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D mod_hdcp_hdc=
p2_enable_dp_stream_encryption(hdcp);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (status !=3D MOD_HDCP_STATUS_SUCCESS)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;adjust.disa=
ble =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (status =3D=3D MOD_HDCP_STATUS_SUCCESS &a=
mp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcmp(adj, &amp;display-&gt;adjust,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; sizeof(struct mod_hdcp_display_adjustment)) !=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; status =3D MOD_HDCP_STATUS_NOT_IMPLEMENTED;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt; +}<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * Implementation of functions in mod_hdcp.h<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -391,7 +418,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struc=
t mod_hdcp *hdcp,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *=
hdcp,<br>
&gt; +enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint8_t index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct mod_hdcp_link_adjustment *link_adjust,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display_adjustment *display_adjust,<br>
&gt; @@ -419,6 +446,15 @@ enum mod_hdcp_status mod_hdcp_update_authenticati=
on(struct mod_hdcp *hdcp,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (memcmp(link_adjust, &amp;hdcp-&gt;connec=
tion.link.adjust,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct mod_hdcp_=
link_adjustment)) =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcmp(display_adjust, =
&amp;display-&gt;adjust,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct mod_hdcp_display_adjustment)) !=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; status =3D update_display_adjustments(hdcp, display, display_adjust);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (status !=3D MOD_HDCP_STATUS_NOT_IMPLEMENTED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stop current authenticati=
on */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D reset_authenticat=
ion(hdcp, output);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status !=3D MOD_HDCP_STA=
TUS_SUCCESS)<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers=
/gpu/drm/amd/display/modules/hdcp/hdcp.h<br>
&gt; index 399fbca8947b..6b195207de90 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h<br>
&gt; @@ -445,6 +445,14 @@ static inline uint8_t is_in_hdcp2_dp_states(struc=
t mod_hdcp *hdcp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current=
_state(hdcp) &lt;=3D HDCP2_DP_STATE_END);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static inline uint8_t is_in_authenticated_states(struct mod_hdcp *hdc=
p)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (current_state(hdcp) =3D=3D D1_A4_AUT=
HENTICATED ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; current_state(hdcp) =3D=3D H1_A45_AUTHENTICA=
TED ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; current_state(hdcp) =3D=3D D2_A5_AUTHENTICAT=
ED ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; current_state(hdcp) =3D=3D H2_A5_AUTHENTICAT=
ED);<br>
&gt; +}<br>
&gt; +<br>
<br>
The compiler is probably going to optimize the four `current_state` <br>
calls away, but maybe use a helper variable, so it=92s clear for the <br>
reader the same function is each time. Also, why not put the helper into<br=
>
`drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h`?<br>
<br>
&gt;&nbsp;&nbsp; static inline uint8_t is_hdcp1(struct mod_hdcp *hdcp)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (is_in_hdcp1_states(h=
dcp) || is_in_hdcp1_dp_states(hdcp));<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/driv=
ers/gpu/drm/amd/display/modules/inc/mod_hdcp.h<br>
&gt; index f7420c3f5672..3348bb97ef81 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h<br>
&gt; @@ -294,7 +294,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struc=
t mod_hdcp *hdcp,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint8_t index, struct mod_hdcp_output *output);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* called per display to apply new authentication adjustme=
nt */<br>
&gt; -enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *=
hdcp,<br>
&gt; +enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint8_t index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct mod_hdcp_link_adjustment *link_adjust,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display_adjustment *display_adjust,<br>
<br>
<br>
Kind regards,<br>
<br>
Paul<br>
<br>
<br>
[1]: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fchris.beams.io%2Fposts%2Fgit-commit%2F&amp;amp;data=3D04%7C01%7Cal=
ex.hung%40amd.com%7Ce0754902cc3545234c1508da097874f2%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637832710221132603%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sd=
ata=3DnixPwZB4AwGHzYIF3euukbDQcgJ0zE0GwzBQVIlUe2U%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fchris.b=
eams.io%2Fposts%2Fgit-commit%2F&amp;amp;data=3D04%7C01%7Calex.hung%40amd.co=
m%7Ce0754902cc3545234c1508da097874f2%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637832710221132603%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3DnixPwZB4Aw=
GHzYIF3euukbDQcgJ0zE0GwzBQVIlUe2U%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB3048EBCE33104856A122B89BF71A9BYAPR12MB3048namp_--
