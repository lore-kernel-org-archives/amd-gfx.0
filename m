Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F279C4346E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 03:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328BA20872
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 03:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F5x71HEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328BA20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03776E090;
	Fri, 25 Sep 2020 03:39:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1546E090
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 03:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUXSmqHAXzYpzJS6fK8D+NaFFaAmUrThShlmceOpDd1RcjgNvXjMxdnjFsWTRfTD4CKUKpBMpgY9/MMi8xZU/k0vt+UWWID1Nm2Qt9pBdjnh7YIjuqskrWFQZH+oVmqIlCpr038nVNEB/bSvmKJPimUYX29XLAjbkkvXbI4sZMd+huczb3oudZZdbUlnXYzxT3DSJFLkS8yIr/AflXNo1V+Mr1rkiVivSd5fRRbgb52NWTBhy5PDx90tFxeWHelnoLFsqXvQp9ESDvvLQnAT9PZhLooimjCqH1uX0mWvtPEeILalLIFdhs13e1gbvQ8FNxi2HYBiwNvK2XOA6x2ZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI8VA6FinZQ+6RpOPOLw/ZtdppwKgFP4+ttpz/I+JQ0=;
 b=JZUkVtbyuyfLTK5XhnW6KAy6ciX+8gWr2V+94R6ZpiOikh367irGRjfIeNJYfBjFrPq4KPbsa5D0RM+RqNCPk6zZd/hp2mYfYjRwgwxy8UWXoMGimgdwCqRHIjVXkD/SvhJms76saVoVzQz4ImRxcL7lxP74JQ0ON+eJIs2rU6YOIzTOvpyAPb3BYzb4aFP/3R4IPbIwBW0c20EaJ7Lnmn/5b/6YCVjEujWNSn68sJ902dOLZoB4o60s5+RCGNjaGXeJs3dI5+zuZEChsUID7ajs0M4/hK1w+xOB7ehP1X09dkcdo1TeIFIux1HToc0O1flYNbgR1IXeUt1hNyJbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI8VA6FinZQ+6RpOPOLw/ZtdppwKgFP4+ttpz/I+JQ0=;
 b=F5x71HEqpyXhQb327I2V+KXCtq74MsecFn4l38yRTaHsmlPwKprZJiKHGxP983H/svCXFJTGPglHikvtRsid2B7y9VhRXlFIBe2/ylFZoX7kehG/UdnBbLOc1LutalrRN72D8FUlysXWRJL40EKIw5hSkpqVADRRXrtfDWNWgeo=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 25 Sep
 2020 03:39:50 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3412.022; Fri, 25 Sep 2020
 03:39:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
Thread-Topic: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
Thread-Index: AQHWklrw9kDTG7Nm1UqHOXrdQl3HTal3wLQAgAD1OACAAABLJQ==
Date: Fri, 25 Sep 2020 03:39:49 +0000
Message-ID: <MN2PR12MB44888D48661A683E4FFEC6B9F7360@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200924101012.22845-1-evan.quan@amd.com>
 <CADnq5_Nw6mdj38FVqg2Y67_eN04YSm1mSsS04RC09v7BHWNiWA@mail.gmail.com>,
 <DM6PR12MB2619DA9B85A535D12D63E915E4360@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619DA9B85A535D12D63E915E4360@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-25T03:39:49.299Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebca98f4-a876-488f-5ced-08d86104a81e
x-ms-traffictypediagnostic: MN2PR12MB4406:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB440663BD3C6E4B392C695092F7360@MN2PR12MB4406.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Act4D+YPmr+mHHI1dWvzZVBBMu5kGoZDfSzpkoY5j5YzVHKlJQNy9ssd76xTtOk+5NYyC66KAKwMzFgcwKCBbSbwbhNTMpQOYYqnv9TM4eAvBftFCzNVCfH639UhZ+VSWiNPSk6o3qpvG40remYGrBj1RIqHe7gUmCJiEuu1GdxddAqzwtX3FP0CrRMS17Oqt1onSGrQv0L/qe93EHGZG+yD6GDr1acYqxHr2LiGrNF0IHsQCRRFRmT3kimGBWhTnGgsx9ZVFb8XaK6l8rkivC3qtkCA/JvQrM5SmBf1OtVFwzBmzZvDqrkCq/c/MGd1CQLa0fR1NgcHQGDr/Y/nLIXooxXL72TRj58CAp3FNgFNaq+lFRhKlGMumidOPIeo7WuBkHEl6YKVIUjf6Disew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(71200400001)(76116006)(83380400001)(45080400002)(8936002)(53546011)(166002)(2906002)(33656002)(6506007)(5660300002)(7696005)(86362001)(478600001)(9686003)(26005)(66476007)(66946007)(52536014)(966005)(4326008)(8676002)(66446008)(186003)(316002)(110136005)(66556008)(55016002)(64756008)(83080400001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5qHTMSSaHql/dWrCArilOKBteEkpODyBp8Fpd9OxNkOgJGySxm7o0jEuTEwUSYfUKk9vBzaDs7RNC3uN4SagO7uWDIIFLM+S82cD7rEfkSq9HX/V0Ekff5KRpaCJRVqZaQ8tMQxlBn0uq1d3ztQYjjc5YGSMjdN0dHR4gJLjGcBlpXVe0yffsYkzUKbgFurmDOBWhIGNA0ocMkd3YGIlwfXvv3sgNdD54O9QSEQRIN+VeBkmkfcbBpKqzzt7d9canqcT7NfQvwR9oCJSIbq0RVYo2AQswV89Qva9fYwPvl0gUoIc8/ZIdLXl4gEvqrgN+EaUZwxkQPVzDhxxm7kEwopDcvq1Alrr3oShuUjGnTUYe1S3fQxXELKQYiumw31E47Tdd/2lWSYUncEBnByT0AaJ/4MV8gZRL/4/Dzyj546LxjzLs1WSm2zIxwmoPwZGL3EmdGV8nrajz0AgokBW1uou9ahS1iJmI0dHYYSxPRHYr/jKrtSi4WrBR7kb1LVfTh29chVLz7JjkBVGH+ExdLcefA6si36ZvscIWH7MTHKrAaha3WJVBdZZW96/7P8ZNU28g03p34AdxORBDcM8jhnXzuLFpz5rP/EeEac9kTh9fGZ4DB1qHFLOVJ3WCoR5OGlPJWqZXI4/DAxsPSAf1w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebca98f4-a876-488f-5ced-08d86104a81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 03:39:50.0026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGykwl5XJYlzAmanF42fugoOYsZ+ywSDM7xFR50IDjnbRXLvTTnlan6Rv78erN7mALkmgPVSIUeR/c+ijJJc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1702876760=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1702876760==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44888D48661A683E4FFEC6B9F7360MN2PR12MB4488namp_"

--_000_MN2PR12MB44888D48661A683E4FFEC6B9F7360MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks.
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, September 24, 2020 11:38 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4=
K monitors

[AMD Official Use Only - Internal Distribution Only]

That(postpone SOCCLK/UCLK enablement) will be revised and added back after =
confirmed with DAL team.
For now, we just revert it to get around the screen flicker issue introduce=
d.

BR
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, September 24, 2020 9:01 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4=
K monitors

On Thu, Sep 24, 2020 at 6:10 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Revert the guilty change introduced by the commit below:
> drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL
> initialization(V2)
>
> Change-Id: I0cab619ffdf0f83b14ba5d2907e1b9c02a984e2f
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Won't this effectively disable the potential fix for multiple monitors at b=
oot time?

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 ++++++-------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 1695b36dc23c..be44cb941e73 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -316,6 +316,18 @@ navi10_get_allowed_feature_mask(struct smu_context *=
smu,
>         if (smu->dc_controlled_by_gpio)
>                 *(uint64_t *)feature_mask |=3D
> FEATURE_MASK(FEATURE_ACDC_BIT);
>
> +       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> +               *(uint64_t *)feature_mask |=3D
> + FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> +
> +       /* DPM UCLK enablement should be skipped for navi10 A0 secure boa=
rd */
> +       if (!(is_asic_secure(smu) &&
> +            (adev->asic_type =3D=3D CHIP_NAVI10) &&
> +            (adev->rev_id =3D=3D 0)) &&
> +           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> +               *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM_U=
CLK_BIT)
> +                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_=
BIT)
> +                               |
> + FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
> +
>         /* DS SOCCLK enablement should be skipped for navi10 A0 secure bo=
ard */
>         if (is_asic_secure(smu) &&
>             (adev->asic_type =3D=3D CHIP_NAVI10) && @@ -2629,43 +2641,12
> @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
>
>  static int navi10_post_smu_init(struct smu_context *smu)  {
> -       struct smu_feature *feature =3D &smu->smu_feature;
>         struct amdgpu_device *adev =3D smu->adev;
> -       uint64_t feature_mask =3D 0;
>         int ret =3D 0;
>
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       /* For Naiv1x, enable these features only after DAL initializatio=
n */
> -       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> -               feature_mask |=3D FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> -
> -       /* DPM UCLK enablement should be skipped for navi10 A0 secure boa=
rd */
> -       if (!(is_asic_secure(smu) &&
> -            (adev->asic_type =3D=3D CHIP_NAVI10) &&
> -            (adev->rev_id =3D=3D 0)) &&
> -           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> -               feature_mask |=3D FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> -                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_=
BIT)
> -                               | FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_B=
IT);
> -
> -       if (!feature_mask)
> -               return 0;
> -
> -       bitmap_or(feature->allowed,
> -                 feature->allowed,
> -                 (unsigned long *)(&feature_mask),
> -                 SMU_FEATURE_MAX);
> -
> -       ret =3D smu_cmn_feature_update_enable_state(smu,
> -                                                 feature_mask,
> -                                                 true);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to post uclk/socclk dpm enable=
ment!\n");
> -               return ret;
> -       }
> -
>         ret =3D navi10_run_umc_cdr_workaround(smu);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to apply umc cdr
> workaround!\n");
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cev
> an.quan%40amd.com%7C3899143b7990458f882c08d86089df67%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637365492561293539&amp;sdata=3DJ%2FM6YSLX6d%
> 2BMO%2B%2FWzdKAW7JlVZM%2FMFRDpTfi6UHkozk%3D&amp;reserved=3D0

--_000_MN2PR12MB44888D48661A683E4FFEC6B9F7360MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 24, 2020 11:38 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 w=
ith 2*4K monitors</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - Internal Distribution Only]<br>
<br>
That(postpone SOCCLK/UCLK enablement) will be revised and added back after =
confirmed with DAL team.<br>
For now, we just revert it to get around the screen flicker issue introduce=
d.<br>
<br>
BR<br>
Evan<br>
-----Original Message-----<br>
From: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
Sent: Thursday, September 24, 2020 9:01 PM<br>
To: Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander =
&lt;Alexander.Deucher@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4=
K monitors<br>
<br>
On Thu, Sep 24, 2020 at 6:10 AM Evan Quan &lt;evan.quan@amd.com&gt; wrote:<=
br>
&gt;<br>
&gt; Revert the guilty change introduced by the commit below:<br>
&gt; drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL<br>
&gt; initialization(V2)<br>
&gt;<br>
&gt; Change-Id: I0cab619ffdf0f83b14ba5d2907e1b9c02a984e2f<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
<br>
Won't this effectively disable the potential fix for multiple monitors at b=
oot time?<br>
<br>
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; | 43 +++=
+++-------------<br>
&gt;&nbsp; 1 file changed, 12 insertions(+), 31 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; index 1695b36dc23c..be44cb941e73 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; @@ -316,6 +316,18 @@ navi10_get_allowed_feature_mask(struct smu_contex=
t *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;dc_control=
led_by_gpio)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D<br>
&gt; FEATURE_MASK(FEATURE_ACDC_BIT);<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp;=
 PP_SOCCLK_DPM_MASK)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D<br>
&gt; + FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DPM UCLK enablement should be=
 skipped for navi10 A0 secure board */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(is_asic_secure(smu) &amp;&=
amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;asic_type =3D=3D CHIP_NAVI10) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;rev_id =3D=3D 0)) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&g=
t;pm.pp_feature &amp; PP_MCLK_DPM_MASK))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM_UCL=
K_BIT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALI=
NG_BIT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; + FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DS SOCCLK enablemen=
t should be skipped for navi10 A0 secure board */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_asic_secure(smu=
) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;asic_type =3D=3D CHIP_NAVI10) &amp;&amp; @@ -2629,43 +2641,12<b=
r>
&gt; @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)<br=
>
&gt;<br>
&gt;&nbsp; static int navi10_post_smu_init(struct smu_context *smu)&nbsp; {=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D =
&amp;smu-&gt;smu_feature;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *=
adev =3D smu-&gt;adev;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_mask =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(ad=
ev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For Naiv1x, enable these feat=
ures only after DAL initialization */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp;=
 PP_SOCCLK_DPM_MASK)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; feature_mask |=3D FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DPM UCLK enablement should be=
 skipped for navi10 A0 secure board */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(is_asic_secure(smu) &amp;&=
amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;asic_type =3D=3D CHIP_NAVI10) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;rev_id =3D=3D 0)) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&g=
t;pm.pp_feature &amp; PP_MCLK_DPM_MASK))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; feature_mask |=3D FEATURE_MASK(FEATURE_DPM_UCLK_BIT)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALI=
NG_BIT)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_MEM_MVDD_SCALIN=
G_BIT);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!feature_mask)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_or(feature-&gt;allowed,<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;allowed,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long *)(&amp;feature_mask),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_FEATURE_MAX);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_feature_update_e=
nable_state(smu,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; featu=
re_mask,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true)=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to post uclk/socclk dpm =
enablement!\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D navi10_run_umc=
_cdr_workaround(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to apply umc c=
dr<br>
&gt; workaround!\n&quot;);<br>
&gt; --<br>
&gt; 2.28.0<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flist">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist</a=
><br>
&gt; s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C0=
1%7Cev<br>
&gt; an.quan%40amd.com%7C3899143b7990458f882c08d86089df67%7C3dd8961fe4884e6=
<br>
&gt; 08e11a82d994e183d%7C0%7C0%7C637365492561293539&amp;amp;sdata=3DJ%2FM6Y=
SLX6d%<br>
&gt; 2BMO%2B%2FWzdKAW7JlVZM%2FMFRDpTfi6UHkozk%3D&amp;amp;reserved=3D0<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44888D48661A683E4FFEC6B9F7360MN2PR12MB4488namp_--

--===============1702876760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1702876760==--
