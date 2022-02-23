Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F24C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 02:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C4410E418;
	Wed, 23 Feb 2022 02:30:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F6010E418
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 02:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MieiEczKT6QUWhtKN0t84DHOXmr5OT/XRJGuZi0TMqKGm0iAo9irG6KeateV2Taotf31JHmBgxWFDwjR+5iVYsATPzvfoC3diZO8Cs8ONae9lOQ2o9kID//rZSoHTVVeseupvayvVWTp+CaFu0ZpXZBt24hPJxVtsgN5OmYin9NQHbT8U/aPwLVfp/I1jGO8KuBfwf7h6dz1h9lUGYOLPcZQe+47NyXy42O31B8H/eMcf+rjHWqFVMsQjYYtC2zNmpO7YY9AkdZ81DsXXfWjINwD9GFN/3PEK8SA4Ye5RhYhDiwgh13rnrUvdf/TS7HCHwIAsM+mi7pdAv8MXsu+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipvXcGiwCx2PRe2TQzNdZ1m9OtoX5nYO9YdEVxEFfS4=;
 b=ehHrfFsniMGJC+V6cWeTOM1s1RedTHwscQXtZoFiGv9q+kEXMKStl9xa9YXRZDlGvzfkxUBHt2y2NileHxM4rB8JUudIBwec1IZSlSOFS7tsymrxwaJ//BZq2RMgJFrACsbO+C1haq2vtGcCf0JExQdWp1NU8uuQ6fkYFJzVyZ+fpfuAlWnBPAbWF1aRQzOKoSOx5OCKsYALTIINvumOAbyZmQOeK0Oau5RA6+BKaXVJWjarE3Mx+UAJr1xJq9KITWSEe3AWG1AXbN89RtJ4RMu/zeFWo0kfKnwleVldgAemvkP7a6XQosGx3g6lmfiJ1mLVeEEYaGzw3Elrld7GZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipvXcGiwCx2PRe2TQzNdZ1m9OtoX5nYO9YdEVxEFfS4=;
 b=m5IGQ1/E6OASFLnr91nEHz3deL/sbRH6WlREMaXFoKwjMFkzjmS7+VEqtqqn2GWBzC9l4vexM3/gZ0i+mxHNkrEiVN093IOCHbGwzbVmWxS1TUxaXR0NL+QuZm/07ucU1EGWA+XR+vSJGbnFcr2vcAG1fc/IID7d/qOOeTeFJ+w=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 02:30:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 02:30:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Thread-Topic: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Thread-Index: AQHYJ/32llQ81uKIkE+Iyz546Etxxayfy1uAgACfHICAAAAWpA==
Date: Wed, 23 Feb 2022 02:30:21 +0000
Message-ID: <BL1PR12MB51440516DAC35799C9555243F73C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220222150731.16954-1-guchun.chen@amd.com>
 <CADnq5_PRn-G0FC46Wh-8HJs=EL+hLNfYz=NNC-PGKosDrPXrsQ@mail.gmail.com>
 <DM5PR12MB2469DCED1EAAEB56B57C2698F13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469DCED1EAAEB56B57C2698F13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-23T02:30:20.916Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: ba1e9489-09f9-9536-2047-0a745994bb8f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7886106f-33ce-4d15-c980-08d9f67470c7
x-ms-traffictypediagnostic: LV2PR12MB5942:EE_
x-microsoft-antispam-prvs: <LV2PR12MB5942AB3632663163FE53CB92F73C9@LV2PR12MB5942.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APLM2d0JbIPkSwh+xlGn1+SFWQcuoB6Cpz2WiaPsmEToHMOzfOnclmPF25asb8/Dm21TjYSfKg0Wuk+5vj3PE0hx0UZGQxjKycvYfcbEBycH/njcty0UW+AlZYOTciuFs1zAwuNJX/Vqx9tfiu7qOVjGWKuDh36fAR0vDPQmBFU7riRypGJZqHLuo0L6YDsD6/TtzL4XFnN3GiMHlvaxfB8068h4DhU7fYUyExyjqk1Aq+7QrfyQ49YrtvbnNvQ3OFcnhGvfpeZIQ4DPoB2aITdz+maUuS39g42XIbGKvkU6YjKJERdCmTlf5C1b91bDdhBdNMvfLIbU+SbnRknKP5BTNXQR97oRPn+Xrtg215cArS7SzdTvAdD471xDWVGF96Rc2OMGHMuYSEUQlWoNUUt9ZhUZoFbnNl6NscrSfTjVeM7yZqNFPtvjmSBK0Tex9fSOPsJqo7uyHbdGy+Edn1iM/+XRgBykTrbi5xm8wolxUSLC2K3QFZUjayDtwC/sZnPDBh9ZL3VGEB4ftu50wU2BEjEsR5dVI2VrmMvw3Ic0+uodr/VZSgrvEDwxGmM43OIeLt08rAXW5K3wZXrSGBkzmIU2OA2pdLmvgrzY6zHttCOUpYgHYNdt51IOW5Y0kcG7D8fLfKQW4nn1AW8MNTKKuLHfrG62uQC0bqrKOQsVADuQzG+BbnudDqDNd2bkYSCyGe/lS1sGegCgWt+Juw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(2906002)(186003)(26005)(83380400001)(33656002)(55016003)(76116006)(8676002)(66946007)(71200400001)(4326008)(8936002)(66446008)(19627405001)(53546011)(66556008)(64756008)(5660300002)(508600001)(110136005)(54906003)(7696005)(66476007)(86362001)(6506007)(38070700005)(316002)(9686003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Q5DwfxrvWbaXnNKE9n2XLCP/VRMeFAVtL1MczGV+gBr2dM8gSlAW/XZGaFG?=
 =?us-ascii?Q?eSvSKTkQJqo4UHYmZrCqPwUWBZ2mdJIjXOuCGKYH5kGeDZ8GR1kW2Bcd13GL?=
 =?us-ascii?Q?toN2atkPzNfTqG5KKz8q6Jtb/KtrFcePfgmwvV58Tffg2xEJhr8dO/eWtnpf?=
 =?us-ascii?Q?vPnGqOpdYRXnpMC6NiWfg/0cXQGLOVqUkrzHc33Th1aLO6ZtTfpH4tLBBQS4?=
 =?us-ascii?Q?0FIOtBk5yTnkBsACgTve1mYe36tiNi1gKdppfXGQGm5wDep+MaYDMCg81KPQ?=
 =?us-ascii?Q?u22juxWmmh2OI3tQdu9bV5NZiJoBG3kFNnaF72kG/2Aedtd1tgzZvgQ/upfk?=
 =?us-ascii?Q?pyy9VWLJ7k6ntvsG/qmiJorQvDXurTABUKB+Qx51OIlYsQ3IXbiFL8JJRv6I?=
 =?us-ascii?Q?/qnpFQyfPHelmPWb4auYRAXtWM5Ev+VXSVCsW/ZnGg6nhIl0Usa4H91QaC91?=
 =?us-ascii?Q?0OzuBlMEBlGQTr53uGqftG82p4tyjjSTIJg5QMZ3PaRiEyOpuK2AnAow+KsL?=
 =?us-ascii?Q?Jpx4iTJjZMUP+m+e8vzm3W1pnRo6rqJ/vDTHeY5PDpZF5c1H2yPjG1/5LNgH?=
 =?us-ascii?Q?LC8lflXmTzXLbM2Ajw2AwCpmXvhqiKHQaPE5i7zPhVAkv4y97kjlPzfrYptL?=
 =?us-ascii?Q?LyqtJWl/j22cROiRQxsQWXvptmWgc4KCr/AMOgFWrf0Wb+VuwowAbQ69bk0N?=
 =?us-ascii?Q?fZytER2g4fvgsLUXi/yTDGL63QuAxKJSEwOUktbj35YP4NAqMeFkOSHTV6BM?=
 =?us-ascii?Q?Eub9WFDn78IKIJAQVEg0NBqQwNJaj22mDGglChqyPv7C1ayueZnZevu8D47C?=
 =?us-ascii?Q?Do51tbjUNd7VfFHZnVaXbUHw8SV2PwNX3UiyaS4X6+aKK7G/W0QiDtHJWcqv?=
 =?us-ascii?Q?UbrRlMGnuVsD7ftM/B4wdOrlvbSG+0msBWporBRb31YMpGuiAl+tKsDC/oil?=
 =?us-ascii?Q?xy+NT6EarcqNVnCwi2Pe9+hGKC3JxROyzJMIQL5Nt0fBToCu3ojOXq8ddrZV?=
 =?us-ascii?Q?nyffiziIBg8R4+x/5ChS+I2hnVIMYmz+BzVJCks9n36ZOhYfYxgV8Wa/nOBK?=
 =?us-ascii?Q?sqEL8ys6rp5aIW2o/0qrGy24kfIf4HWyUAuJTDgWionGpcIoWn9STn3m+OVH?=
 =?us-ascii?Q?zItDqN14xvT2D4+dscRvcd5OHQcA/4/T686xDff4PQDgkIpbWNetXktLFzBX?=
 =?us-ascii?Q?C62zsIqeMxAAD4GxK9y1UEqyOXg6E45m26cNlR/Vp9J3UZNT3KFBZ+UQJzeH?=
 =?us-ascii?Q?re8szUm15RYwZbzKe2IN9MqYSmAPQPsYqmKmRiEJzv6KUgZiEAQ5Rt+zCZDc?=
 =?us-ascii?Q?12jHdsysVqH1vZm/JuBDeq7nwqn8+9wQtdrjO9ZMEm+lmjfhHQy52Zbg/t7U?=
 =?us-ascii?Q?UDQHAch+X94ZzuGzyouWARG2362bHKveWHSRMD9db+PSHEaYZCN45uWGaYTg?=
 =?us-ascii?Q?b/lYKUGFrcV+RS8MTQLIQxL24BGsU8hRHl3S+RsUoIOV534RcWBqNfapcrGJ?=
 =?us-ascii?Q?PzrJ3Dd4hALFInyiD38dZrveyZx3IMJSJ9+48KPfpznkLXVKpq+myIqVaqPb?=
 =?us-ascii?Q?6iRMHJL0qqqv0MCW6wrf+Dl1pRmbDLJvs72z+sNw5HOkF8bycN4HzaIXVIoF?=
 =?us-ascii?Q?unsn1h/rORP/j0YUBLP2Qag=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440516DAC35799C9555243F73C9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7886106f-33ce-4d15-c980-08d9f67470c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:30:21.5917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrQPNTOi0cOkr6MPlWngL2TsrhzXBeCenqdj5Dt1xs1nA5NEHMo0EfgeIe1vJTKfasT1/oTw5jnXRFSKVBVGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51440516DAC35799C9555243F73C9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

No that's fine.  Just checking.

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, February 22, 2022 9:29 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Chri=
stian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs

Hi Alex,

This patch has covered the check of VCN as well. So you want me to modify t=
he comments to add VCN as well?

Regards,
Guchun

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, February 23, 2022 1:00 AM
To: Chen, Guchun <Guchun.Chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Chri=
stian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs

On Tue, Feb 22, 2022 at 10:07 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Due to faulty VBIOS out there, harvest bit setting is not consistently
> correct especially for display IP. So far, it's hard to work out a
> solution on all the legacy Navi1x ASICs in a short time, so to avoid
> regression, limit harvest bit read on several ASICs. Will revisit
> later once VBIOS has corrected it in long term.
>

Looks like it may be incorrect for VCN as well.  Double check that.

Alex


> Fixes: b3f4ea887d5f("drm/amdgpu: read harvest bit per IP data on
> legacy GPUs")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 11255290f117..2e0ff1ace6fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1129,12 +1129,20 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_de=
vice *adev)
>          * so read harvest bit per IP data structure to set
>          * harvest configuration.
>          */
> -       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0))
> -               amdgpu_discovery_read_harvest_bit_per_ip(adev,
> -                                                       &vcn_harvest_coun=
t);
> -       else
> +       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0)) {
> +               if ((adev->pdev->device =3D=3D 0x731E &&
> +                       (adev->pdev->revision =3D=3D 0xC6 ||
> +                        adev->pdev->revision =3D=3D 0xC7)) ||
> +                       (adev->pdev->device =3D=3D 0x7340 &&
> +                        adev->pdev->revision =3D=3D 0xC9) ||
> +                       (adev->pdev->device =3D=3D 0x7360 &&
> +                        adev->pdev->revision =3D=3D 0xC7))
> +                       amdgpu_discovery_read_harvest_bit_per_ip(adev,
> +                               &vcn_harvest_count);
> +       } else {
>                 amdgpu_disocvery_read_from_harvest_table(adev,
> -                                                       &vcn_harvest_coun=
t);
> +                       &vcn_harvest_count);
> +       }
>
>         amdgpu_discovery_harvest_config_quirk(adev);
>
> --
> 2.17.1
>

--_000_BL1PR12MB51440516DAC35799C9555243F73C9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
No that's fine.&nbsp; Just checking.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 22, 2022 9:29 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhu=
i &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: limit harvest bit read on several A=
SICs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Alex,<br>
<br>
This patch has covered the check of VCN as well. So you want me to modify t=
he comments to add VCN as well?<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;alexdeucher@gmail.com&gt; <br>
Sent: Wednesday, February 23, 2022 1:00 AM<br>
To: Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander =
&lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com=
&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;X=
inhui.Pan@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs<br=
>
<br>
On Tue, Feb 22, 2022 at 10:07 AM Guchun Chen &lt;guchun.chen@amd.com&gt; wr=
ote:<br>
&gt;<br>
&gt; Due to faulty VBIOS out there, harvest bit setting is not consistently=
 <br>
&gt; correct especially for display IP. So far, it's hard to work out a <br=
>
&gt; solution on all the legacy Navi1x ASICs in a short time, so to avoid <=
br>
&gt; regression, limit harvest bit read on several ASICs. Will revisit <br>
&gt; later once VBIOS has corrected it in long term.<br>
&gt;<br>
<br>
Looks like it may be incorrect for VCN as well.&nbsp; Double check that.<br=
>
<br>
Alex<br>
<br>
<br>
&gt; Fixes: b3f4ea887d5f(&quot;drm/amdgpu: read harvest bit per IP data on =
<br>
&gt; legacy GPUs&quot;)<br>
&gt; Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++=
-----<br>
&gt;&nbsp; 1 file changed, 13 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; index 11255290f117..2e0ff1ace6fc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; @@ -1129,12 +1129,20 @@ void amdgpu_discovery_harvest_ip(struct amdgpu=
_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * so read harves=
t bit per IP data structure to set<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * harvest config=
uration.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP=
][0] &lt; IP_VERSION(10, 2, 0))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_discovery_read_harvest_bit_per_ip(adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest_count);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP=
][0] &lt; IP_VERSION(10, 2, 0)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if ((adev-&gt;pdev-&gt;device =3D=3D 0x731E &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;p=
dev-&gt;revision =3D=3D 0xC6 ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pdev-&gt;revision =3D=3D 0xC7)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;p=
dev-&gt;device =3D=3D 0x7340 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pdev-&gt;revision =3D=3D 0xC9) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;p=
dev-&gt;device =3D=3D 0x7360 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pdev-&gt;revision =3D=3D 0xC7))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_disc=
overy_read_harvest_bit_per_ip(adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest_count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_disocvery_read_from_harvest_table(adev,<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest_count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_ha=
rvest_count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_harve=
st_config_quirk(adev);<br>
&gt;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440516DAC35799C9555243F73C9BL1PR12MB5144namp_--
