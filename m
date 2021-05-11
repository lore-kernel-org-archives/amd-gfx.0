Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E550BC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 18:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1006186A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 18:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1006186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B476EAA7;
	Tue, 11 May 2021 18:14:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2238C6EAA7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 18:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE1QGKJtbhEiziwBn6P+BwzRMivb4JNkUs+7QjRqqM+iW3gI6tCW3f7XQmYgtnICeV8IRyS2g0pRYecGdMLfu6JHbxC+I07bVLopwMaWeF4xuHNBhlIaIP8kSEPSVh/jeBYpDrJnzZE2IDzULdEvlQ2/c9qYJLpEdR992m+8O061xXq5esldTU03aIY4WYTL5R5a1hUZhQS59sUChKBNHMp7HrvoOdEAzbrxR1Ns5lu2T+INwHHTP+t0o3RWC2OUAtVqYZjhzsDbzURU39QI08+xxxyJH92z/SZEvFgD2sqaFGDyKBPa3LDS1cKDi6HjfMck6zaBzQeYegbPzbN1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7eLPW0xik5uGn2DWRQjk/vv8RwKY8RBQDr0x9hzEIY=;
 b=GmMYBsvElLcBgQmah9rtPZgMWBEYSFjJZye5croPmyO9uWFvlB3hdh41KIO6ZSCdWCj76PFxnWXLwCTjy0xn2R3hCCNgwwFVbnIVo3TwUqQJthxFcfy9KkjqumFxjuUGXUxRf3m8ijJVPsONbfZ3/rTxPS56wPnrSXVcLW4QG05N1y4Hw1ON77gPUkoPxgk/LzO0yYj2glBC0QZQlj+aKoxm2QMqLE5haHhCB0wmF6wdI084NPRb7+hxhBSSVGQ6AP6A4X8XrrGUSkBaiW1/whPbMyshVynUmFKKgDSn707alIcK5/NXuxq3qImcIVC0ZZcx7TmyiDaxyeNH/wk4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7eLPW0xik5uGn2DWRQjk/vv8RwKY8RBQDr0x9hzEIY=;
 b=wVRrBwD7NS3FjfwbtQxjdQcsGQVMSLgFV4TLbaX1FaJl3t47GQE5dfDfDsGOGSrzMq+w+K5qpLyQEueOceMzGrWSnY6O2SeOg19uAViL89+Cp4qGxS0dOw2lbXTlPaVOuxthRwXSvZQgILNpXLRqgPOXCqk45zxUyU092QvwD1Q=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3335.namprd12.prod.outlook.com (2603:10b6:a03:dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 18:14:40 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 18:14:40 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix fence calculation
Thread-Index: AQHXRdsyILgvLWkSJUyuTo5sQyI/V6rd6aKAgACtdQQ=
Date: Tue, 11 May 2021 18:14:40 +0000
Message-ID: <BYAPR12MB284099C33725C0BB0FDD8D48F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <c1b6f68f-4b96-8752-c406-564e2b98ce41@gmail.com>
 <20210510202915.30502-1-david.nieto@amd.com>
 <20210510202915.30502-2-david.nieto@amd.com>,
 <7579fa92-ad25-323a-0c41-ac07ac47fa42@gmail.com>
In-Reply-To: <7579fa92-ad25-323a-0c41-ac07ac47fa42@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-11T18:14:42.833Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.53.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b130738c-d83c-409d-c705-08d914a8a52b
x-ms-traffictypediagnostic: BYAPR12MB3335:
x-microsoft-antispam-prvs: <BYAPR12MB333591355BD1191D07A3D3A0F4539@BYAPR12MB3335.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2K3WfV69OfyJY5LNUncTUgm3rjkX/U6u0HQrilLE0liscBHGZrhNg/shEdhpGqG32tv8+/79fG/gvtWkXTOg1NtsJyQ+Hk10HggvpgSvJNR5iFxmklWkqeNtNT7g2Gb7JKXJzIWrlwxnmDIGuk4UGBOspjzUI24yze+JARlM4t6Mf7sNRqZCAMrWD20ei8QkAlEoChsygXSTXKIokJhiM9tydu7xPdBFdl7wONM0HKHoiP7+/gQmD3PBaKUvncwF3O6mSpWnj7wEuzZsOk/ipkilKyYjQlQv3OsPidJD306jeVEyjGuQpw5JswJTaNgKFplu6LDAbxoxUTaESCcZJPpQyB6KuAu7uVtwJeXq3sBsuiWTy/nR0eHBR5nwKSge1YxJJsSJFhzve5rZw/YS2gipLP5R+0DjyNquAHEYSOq307aCg2uKL3fh2bov/1ZFMvSHhBTRD7VM5UzyW5rFApp2ggqmJRHb1j1TBAFDOEq4f/xcuUP/LCU7zy5GfIFiGyzvlgYhtS2mxGdes7zV04JgOn+ZAM/0uwPLrnNq5OlVe9UE9DTlClXIYpT/AOA7ij1DgQt6V+lHcCbNFiPV66CztEpETAHDRi5gn0wsmH0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(122000001)(33656002)(53546011)(6506007)(2906002)(86362001)(66476007)(38100700002)(26005)(7696005)(66556008)(64756008)(76116006)(66946007)(19627405001)(8676002)(66446008)(71200400001)(5660300002)(66574015)(55016002)(83380400001)(110136005)(52536014)(8936002)(316002)(478600001)(186003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?I7Ah66rKLv3R4y4bNs7/ncCcsAIa5sSLkuYz5C0/zSOJJY0c2zNOPBd9jw?=
 =?iso-8859-1?Q?0+3ZRhZ7gstvMUNgtikr32SJFrbfxWRdPecwENO9L81Z1gx09k64NZfx9f?=
 =?iso-8859-1?Q?3osXMGfcB3B42akYcSgJ7IfFO69vIZ+KWgAVE5cN4UFYsWidS1LHN30Bcs?=
 =?iso-8859-1?Q?Ke/WRbK46mDX5UKtf13+CWY30KUtVRDjXIAss+klVKNAKY+wrLUnY4lzG9?=
 =?iso-8859-1?Q?ehYbx4qPxnEOmqTANOAI5rGUW9KOY7QSPbsA5sXGSOgoM8WOgGE3+kMuQP?=
 =?iso-8859-1?Q?V77l/m2v7HO3wHzduGI/f1pfaGuf3FL75UfOkmPqr5G1YMKi5wURVMKMjU?=
 =?iso-8859-1?Q?iRW1mczLyY9FxSgjb+zcDZK53iX+ZRQxEj9VUbh/37mLV9Dseuw2uh2kuD?=
 =?iso-8859-1?Q?DduuxdrZEBL+UxKxZqngaemxPhi9+ZFmCBckWQA6XdXjRK2o0DUvsoIfE0?=
 =?iso-8859-1?Q?ryRlO+9U7zilA5hOrj/a6XrKp8Xr9pH5heO5PjZV2AiujsClQkIn6sUKl4?=
 =?iso-8859-1?Q?lVxiO0K33N00W5MWlkv6kBhql90n0wFMWANAoD/moH7NAX/bK7VqSX/m3S?=
 =?iso-8859-1?Q?E/Xw7OZEjqXppraCW3Q2CXD79t/8ILOhsTgbgCUiIaRJ29lZkgZoRx3F+R?=
 =?iso-8859-1?Q?UK7sdD2gPrdIf/BkNBVC6FUh3akDc/iX5Ae0KEeMRUMKo+NQHaGzOkcnML?=
 =?iso-8859-1?Q?BlpjOtQm6B6oJLtQAdW8ccLP3Wk3sw3Me8tKEyMrWsjhu3xqHQsfPw8FXk?=
 =?iso-8859-1?Q?PWdpFW6UeiW5btKUF/3IWeYcQ4nnSQqqO+JwwicMjRBIsEUH4ynw+QSaeJ?=
 =?iso-8859-1?Q?+ilqn3EAMgptMW6SL9NKpedf1VZ9tgub5ZS72keRz7EuGxOgHVmXw2Tw97?=
 =?iso-8859-1?Q?waxMiLpowGbUU2SrdbakaJC1epmbdAutPWkzlNIEOkG5Psy6T9+OZ0gBx8?=
 =?iso-8859-1?Q?Y1Os2lLaHyLpncbwS13+//DVtUHEDUP0J9NPPyQrfZpwr7a2PuPMweT4cY?=
 =?iso-8859-1?Q?MoC8GMQjuK//ICzJcHoNXA//leNxihW+F6JNO7QU5bIDg3n35cLH/g2uur?=
 =?iso-8859-1?Q?Z9OFrHFwiKNmmSoA4MHbOgQc+oE3wK74RAByIsZAThkWbmXpKa2L0GBlEp?=
 =?iso-8859-1?Q?gmKeGazzS43wijVETvauUFOTOnk2n0yoJm7yW8m0TrV0QONkiYUS6SujvW?=
 =?iso-8859-1?Q?hP50ZkjjZCd50NM9IWK57GFbtzryynoEvySoYILLwovi6PQHF1lSqeRQwj?=
 =?iso-8859-1?Q?DUcevd9eDdSyuU9UWG2tGG5agCn597bSHRStiNIADKaPouNNDPYAMSuQPB?=
 =?iso-8859-1?Q?udg2I9S6UKDB45Vy/yhA+Gb1/U8WdH2XJwrUGyhL9Uewa8tHaxzEHdk4nk?=
 =?iso-8859-1?Q?a3gS2+erUo?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b130738c-d83c-409d-c705-08d914a8a52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 18:14:40.6277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azAFi6pvhNWCPB0RuWxeWFaQVsAJjqxS/t9L2ztBAkajB4IyNnX6j7iad1I+4o6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
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
Content-Type: multipart/mixed; boundary="===============0882364846=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0882364846==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB284099C33725C0BB0FDD8D48F4539BYAPR12MB2840namp_"

--_000_BYAPR12MB284099C33725C0BB0FDD8D48F4539BYAPR12MB2840namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

The local variables need to be initialized to zero, since amdgpu_ctx_fence_=
time accumulates and does not initialize

David
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, May 11, 2021 12:53 AM
To: Nieto, David M <David.Nieto@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation

Am 10.05.21 um 22:29 schrieb David M Nieto:
> The proper metric for fence utilization over several
> contexts is an harmonic mean, but such calculation is
> prohibitive in kernel space, so the code approximates it.
>
> Because the approximation diverges when one context has a
> very small ratio compared with the other context, this change
> filter out ratios smaller that 0.01%
>
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 9036c93b4a0c..89ee464b9424 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -698,16 +698,27 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ct=
x_mgr *mgr, uint32_t hwip,
>        struct amdgpu_ctx_entity *centity;
>        ktime_t total =3D 0, max =3D 0;
>
> +

Unrelated white space change.

>        if (idx >=3D AMDGPU_MAX_ENTITY_NUM)
>                return 0;
>        idp =3D &mgr->ctx_handles;
>        mutex_lock(&mgr->lock);
>        idr_for_each_entry(idp, ctx, id) {
> +             ktime_t ttotal =3D tmax =3D ktime_set(0, 0);

There should be a blank line between decleration and code and please
don't initialize local variables if it isn't necessary.

Christian.

>                if (!ctx->entities[hwip][idx])
>                        continue;
>
>                centity =3D ctx->entities[hwip][idx];
> -             amdgpu_ctx_fence_time(ctx, centity, &total, &max);
> +             amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
> +
> +             /* Harmonic mean approximation diverges for very small
> +              * values. If ratio < 0.01% ignore
> +              */
> +             if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
> +                     continue;
> +
> +             total =3D ktime_add(total, ttotal);
> +             max =3D ktime_after(tmax, max) ? tmax : max;
>        }
>
>        mutex_unlock(&mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.h
> index 10dcf59a5c6b..3541dfb059ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -30,6 +30,7 @@ struct drm_file;
>   struct amdgpu_fpriv;
>
>   #define AMDGPU_MAX_ENTITY_NUM 4
> +#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max > 16384ULL*tot=
al)
>
>   struct amdgpu_ctx_entity {
>        uint64_t                sequence;


--_000_BYAPR12MB284099C33725C0BB0FDD8D48F4539BYAPR12MB2840namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
The local variables need to be initialized to zero, since&nbsp;<span style=
=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI =
Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSys=
temFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667=
px; background-color: rgb(255, 255, 255); display: inline !important;">amdg=
pu_ctx_fence_time
 accumulates and does not initialize</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-si=
ze: 14.6667px; background-color: rgb(255, 255, 255); display: inline !impor=
tant;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-si=
ze: 14.6667px; background-color: rgb(255, 255, 255); display: inline !impor=
tant;">David</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, May 11, 2021 12:53 AM<br>
<b>To:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: fix fence calculation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 10.05.21 um 22:29 schrieb David M Nieto:<br>
&gt; The proper metric for fence utilization over several<br>
&gt; contexts is an harmonic mean, but such calculation is<br>
&gt; prohibitive in kernel space, so the code approximates it.<br>
&gt;<br>
&gt; Because the approximation diverges when one context has a<br>
&gt; very small ratio compared with the other context, this change<br>
&gt; filter out ratios smaller that 0.01%<br>
&gt;<br>
&gt; Signed-off-by: David M Nieto &lt;david.nieto@amd.com&gt;<br>
&gt; Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++++++++-=
<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; 2 files changed, 13 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ctx.c<br>
&gt; index 9036c93b4a0c..89ee464b9424 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; @@ -698,16 +698,27 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu=
_ctx_mgr *mgr, uint32_t hwip,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ctx_entity *ce=
ntity;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t total =3D 0, max =3D=
 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +<br>
<br>
Unrelated white space change.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (idx &gt;=3D AMDGPU_MAX_E=
NTITY_NUM)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idp =3D &amp;mgr-&gt;ctx_han=
dles;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgr-&gt;lock=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_for_each_entry(idp, ctx,=
 id) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ktime_t ttotal =3D tmax =3D ktime_set(0, 0);<br>
<br>
There should be a blank line between decleration and code and please <br>
don't initialize local variables if it isn't necessary.<br>
<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!ctx-&gt;entities[hwip][idx])<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; centity =3D ctx-&gt;entities[hwip][idx];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_ctx_fence_time(ctx, centity, &amp;total, &amp;max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_ctx_fence_time(ctx, centity, &amp;ttotal, &amp;tmax);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Harmonic mean approximation diverges for very small<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * values. If ratio &lt; 0.01% ignore<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; total =3D ktime_add(total, ttotal);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; max =3D ktime_after(tmax, max) ? tmax : max;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mgr-&gt;lo=
ck);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ctx.h<br>
&gt; index 10dcf59a5c6b..3541dfb059ec 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
&gt; @@ -30,6 +30,7 @@ struct drm_file;<br>
&gt;&nbsp;&nbsp; struct amdgpu_fpriv;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define AMDGPU_MAX_ENTITY_NUM 4<br>
&gt; +#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max &gt; 16384U=
LL*total)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_ctx_entity {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sequ=
ence;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB284099C33725C0BB0FDD8D48F4539BYAPR12MB2840namp_--

--===============0882364846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0882364846==--
