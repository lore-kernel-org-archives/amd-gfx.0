Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ADBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 13:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF12D61216
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 13:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF12D61216
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5704689E52;
	Wed, 29 Sep 2021 13:18:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6A389E52
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 13:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItTEZKvi3BFVmefDiuB9kAL15sFC9aIzpf/COiV0iJ9Hib/WIjwdz3TrDCNxRoCu8pzRlVQCHF6QXhPhinaQPsU7E8Z6GQKImpsefVnPs2T1FZ39i7f4Rtx3+ujUW8fuAf87HerSi/D6JDExbN9pPfOInslMvNuiOFZez/jjW8zUkbwsMPbVYey0AwzUpUqumh4Q2w40yMecAoq/ajIP+A+ESh6skD9lfg4s9CvhPxGxguWwbtvkrqP7oIBRB/5CFZLvVYIOAkSID8dIz1kEDV6UXkvyilO5hclDJ1N9o8D7bdW9FMoQrgBJLSwfXPfsR1XfvrDFBOmMnQOizgVeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=POt7HCQIdSGM84q8V/3UD2xXWsSh4N246vA/xrnphkQ=;
 b=ijLq6krjGm0xNsf5DcpxFkTiRrWutZy52OmCwelowCGdkP9BgVWGIvfwPP+WwSpGu5PU5sBrsfeQuXOFakmw7Ue/pFfBe2bwsz4JJo7UpBGLE3OSJ7OsQ7hyKX/XZrVEsWU3Oz6YfHJNEcVPxKb6Iq0fnxbwqYLIJ7rmw05q/URNRNbyq68V+lhJRQb1mI1CG0G5nwis9ibGrOGtL+tWhNE5FxqfxvD9klP3UJZYExHS4ktjS8FPS63U9uUMFUAnQkBmqXH4mUvNnCjILe8yefZj5LjrGuaQctkwbV3JaDoP19cUzKesapejhEc13UCNt5tjjElqzcqeW7jFfbJVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POt7HCQIdSGM84q8V/3UD2xXWsSh4N246vA/xrnphkQ=;
 b=WUgRH4oHN/8xGKBC1YisPI+bqqaQ0MAIULHLTVMOEESD3A9IptOOsKfI+UhJHD8IJdEItF5TlbXMrrlII0ljeIIDC7A2olVVmjmvJj/X/NUSFANk8AjuA2mAoIyOyCcZpbyj4PlUDbb77s8jmldTZJ8Lg6nmyrxmTDqCHenZ88E=
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 13:18:31 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::659f:9d62:f10d:292f]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::659f:9d62:f10d:292f%8]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 13:18:31 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Topic: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Index: AQHXtELezSsynhy0+UWRMSPpBG62Q6u5ljSAgAFpn4U=
Date: Wed, 29 Sep 2021 13:18:31 +0000
Message-ID: <DM5PR12MB18849F60DEE73D7FB8E20017E4A99@DM5PR12MB1884.namprd12.prod.outlook.com>
References: <20210928082819.205231-1-yifan1.zhang@amd.com>
 <20210928082819.205231-2-yifan1.zhang@amd.com>
 <11cc6ad8-5c08-6846-930b-f935c1e29936@amd.com>
In-Reply-To: <11cc6ad8-5c08-6846-930b-f935c1e29936@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T13:18:31.022Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 53d62758-1258-0b0f-c12c-5488d71e3852
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f727d84a-50d8-4a18-ad32-08d9834ba260
x-ms-traffictypediagnostic: DM6PR12MB3514:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB351486205085E52C76D416B3E4A99@DM6PR12MB3514.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECyqP3J/p+7UYjkI41HLkBehgZ8gKkblr7y4lkRk+Z6FLHdxkK+nD+FoEc8EyHREGjcvM0C90iVSv7VgD1lumabp4TaCOvkj4GvtK1vSe1xy+1OamNCbpHmtnAGXGZ34Q4aQ2XZsIQkQwRFykuTjlUqJPEXCRkEz4crSMnALLoOoTnQ78AY1ysrbK/5Bsa6Akbn8fY9MK7GLavuzTXRwpQUiiJRYr5qOdyJsoaIWpuVKJo/210cQekRiTyiCx+UXU0gVNzPJs/uodBTBbOGmDmd/fNW/EVxTOyBq5LURFSo4o6l2KwJ55DFCtVjeWNDVUISeYgmfBsG+AEaD890nxiZl5NDLFqo30cNEOWCQE17foY3g6cCeI2/k4uKah9we6FG20z2pDfPAf74rGgFMiwCVUA9DcgKsq/kl1RaYlc2UzDP4sqNMF42oZVDAOztWxa0xwt4NQ0+udDPqJNsaLbtVkLczVm25J12B+lAczON/ogaWGSF1+kk8E5kCaeo/hDEmRdl2+6cr/wGzJAjO/cs6KALM9celE3yBZP+7MtEiQZxAN2ej+u2M16Fn744hDH5OPWesBQ89MVxeiodlm7wM4077eVUP7X4vK416URzaBmbp35V9FpDTez8tS+ACiECcHCMwUbsxcLUV4AMkfMwuV3VSD3L1F6FUqpd8m4LvBHq9rv54EVHp37qx4sVIx4z+mugbLL7w1+KCDE3RVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(38070700005)(19627405001)(66556008)(91956017)(76116006)(71200400001)(66446008)(64756008)(55016002)(122000001)(83380400001)(9686003)(508600001)(66946007)(66476007)(53546011)(186003)(5660300002)(33656002)(6506007)(52536014)(2906002)(316002)(86362001)(8676002)(26005)(110136005)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?beD4VPTWBhVHlScFwrNBrESsNj8OVkmy8cTUK6NsxSXFbzPCk3BC/iyli8Ut?=
 =?us-ascii?Q?HuGN7dSDdxpEPV/uK6cPAa2znzlaXPv7+FK5VG18OKewyiJiUsCl7t6Xa2Vz?=
 =?us-ascii?Q?x9VrTb748aVfVLsO4bHkRMaPslVZLZ7kGfUFBZYnsiWrNicD4IPF/wKWJPwr?=
 =?us-ascii?Q?Iuegns9pMf0HlPxcGYV//tiBUQxS/nl5GyU4CLcPnbwAk3jBzcCfq13XRbsc?=
 =?us-ascii?Q?PgOg4Sye13fDQ6c9bbmbUHGRgTc3rAuNKzXR6wL1Jm1Ghl71i0Is6PoSvaVt?=
 =?us-ascii?Q?HTunaQsNJo8S8dRpThSv3L/xWeDeQFxzaya5XfRAZJGrdrJmYDPfgqEZZ1Cm?=
 =?us-ascii?Q?NHqxd4uunBNNqmcew4T9DCvQc0de6ZvyQsgVV61L0H5dgFIXWZ7w3BLN20Qg?=
 =?us-ascii?Q?KNAy9OG8DgrHPJMvN0EYxuwYoj7f5fWuP7MNp4fMpjykun/yeCQ6FtNvBroa?=
 =?us-ascii?Q?PIYAt2VW5jELRLv8q2gSUsn3m1nyd4MJU0lL2V9B/l/tDt8HtHVTWcyFxOg7?=
 =?us-ascii?Q?PUXF20jpkHNXQiuKznnW9XnRFO9UV+6gDf4Q2QRHzT54x0LeD9Kp4XV3Sphu?=
 =?us-ascii?Q?wGpWM7rWyx0Ntz+Gz5DjAMAuTnjMaeuhKefqUAVZUWKs2laaGHyCXNgEIuHs?=
 =?us-ascii?Q?gk6mrQGfLDrugrCAdgrvK9ascDpEGvDhdhQdDbrLPe4F3BXoFsECOsJcavPd?=
 =?us-ascii?Q?EK/SjH/idDkHx+m/u9kyaBbKhu+2s4E1snscMT92UOhnAe1uTeKxP32Gg2UO?=
 =?us-ascii?Q?s+5KK0mI6OMOQuaUj5I0uYky7eKFQUkxTNynBs/3vCB2P/hQMZEJ1qA0K4pX?=
 =?us-ascii?Q?x0JlTkwh8yMHMm1K1QRa4Immi9ySd9dZenRcq1Bb+Gxt4UWf4cysWiXNBcTM?=
 =?us-ascii?Q?6PU7rZXtclufCQwH161GedAuRhjI/8aSMHNtEzpsE7iEtVcDBnY/pWYDm+lz?=
 =?us-ascii?Q?XyWvzMEd2naMgMRUTAVpyjYi6pqLpgkJKcRA2g5SM/oroMmrfU+Bmoa8PAOW?=
 =?us-ascii?Q?7mqUurwr3+MaLT2ocuRdwdFGf2NbByy7fY8qS8deJ/3iwgYlLuqlU/xSEaSK?=
 =?us-ascii?Q?SfbttKEKSF4gfUld8tAKxCodua9caB+NRexxqbkPoFiKbyOtWpX9YY2YY0/F?=
 =?us-ascii?Q?a3HyRgZxEGXhkoH5CIC13eogP14hIjuXArSBj+c9vESUhTufmAFdPGgawwzO?=
 =?us-ascii?Q?3E4693nP/RybIX4ArMQceJgT9FcUrUFFcshOiKTLNn0EwVhncsvmWh0ki7CJ?=
 =?us-ascii?Q?Vad4SGrNjWsvPMrT9BjVKAJEd10Vn4afYdnAWkEevLTHTWPtNkbZ9cSQIYFU?=
 =?us-ascii?Q?N7LHKKQgzylOezZqN2sSeVPV?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB18849F60DEE73D7FB8E20017E4A99DM5PR12MB1884namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f727d84a-50d8-4a18-ad32-08d9834ba260
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 13:18:31.8127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhWeT9Zw+s6egE0vfR7EfLwaUMYjzRtpT2G7+9ePUAtE1mH07y1OD2dsS5CcHIaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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

--_000_DM5PR12MB18849F60DEE73D7FB8E20017E4A99DM5PR12MB1884namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

H Felix,

Since the previous patch can help on PCO suspend/resume hung issue. Let me =
work with YiFan to see if
there is proper way to cover both cases.


Thanks & Best Regards!


James Zhu

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, September 28, 2021 11:41 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd=
-gfx@lists.freedesktop.org>; Zhu, James <James.Zhu@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init

[+James]

This basically undoes James's change "drm/amdgpu: move iommu_resume
before ip init/resume". I assume James made his change for a reason. Can
you please discuss the issue with him and determine a solution that
solves both your problem and his?

If James' patch series was a mistake, I'd prefer to revert his patches,
because his patches complicated the initialization sequence and exposed
the iommu init sequence in amdgpu.

Thanks,
  Felix


Am 2021-09-28 um 4:28 a.m. schrieb Yifan Zhang:
> This patch is to fix clinfo failure in Raven/Picasso:
>
> Number of platforms: 1
>   Platform Profile: FULL_PROFILE
>   Platform Version: OpenCL 2.2 AMD-APP (3364.0)
>   Platform Name: AMD Accelerated Parallel Processing
>   Platform Vendor: Advanced Micro Devices, Inc.
>   Platform Extensions: cl_khr_icd cl_amd_event_callback
>
>   Platform Name: AMD Accelerated Parallel Processing Number of devices: 0
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 4c8f2f4647c0..89ed9b091386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct amdgpu_dev=
ice *adev)
>        if (r)
>                goto init_failed;
>
> -     r =3D amdgpu_amdkfd_resume_iommu(adev);
> -     if (r)
> -             goto init_failed;
> -
>        r =3D amdgpu_device_ip_hw_init_phase1(adev);
>        if (r)
>                goto init_failed;
> @@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct amdgpu_dev=
ice *adev)
>        if (!adev->gmc.xgmi.pending_reset)
>                amdgpu_amdkfd_device_init(adev);
>
> +     r =3D amdgpu_amdkfd_resume_iommu(adev);
> +     if (r)
> +             goto init_failed;
> +
>        amdgpu_fru_get_product_info(adev);
>
>  init_failed:

--_000_DM5PR12MB18849F60DEE73D7FB8E20017E4A99DM5PR12MB1884namp_
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
H Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Since the previous patch can help on PCO suspend/resume hung issue. Let me =
work with YiFan to see if</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
there is proper way to cover both cases.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 28, 2021 11:41 AM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Zhu, James &lt;James.Zhu@am=
d.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device =
init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[+James]<br>
<br>
This basically undoes James's change &quot;drm/amdgpu: move iommu_resume<br=
>
before ip init/resume&quot;. I assume James made his change for a reason. C=
an<br>
you please discuss the issue with him and determine a solution that<br>
solves both your problem and his?<br>
<br>
If James' patch series was a mistake, I'd prefer to revert his patches,<br>
because his patches complicated the initialization sequence and exposed<br>
the iommu init sequence in amdgpu.<br>
<br>
Thanks,<br>
&nbsp; Felix<br>
<br>
<br>
Am 2021-09-28 um 4:28 a.m. schrieb Yifan Zhang:<br>
&gt; This patch is to fix clinfo failure in Raven/Picasso:<br>
&gt;<br>
&gt; Number of platforms: 1<br>
&gt;&nbsp;&nbsp; Platform Profile: FULL_PROFILE<br>
&gt;&nbsp;&nbsp; Platform Version: OpenCL 2.2 AMD-APP (3364.0)<br>
&gt;&nbsp;&nbsp; Platform Name: AMD Accelerated Parallel Processing<br>
&gt;&nbsp;&nbsp; Platform Vendor: Advanced Micro Devices, Inc.<br>
&gt;&nbsp;&nbsp; Platform Extensions: cl_khr_icd cl_amd_event_callback<br>
&gt;<br>
&gt;&nbsp;&nbsp; Platform Name: AMD Accelerated Parallel Processing Number =
of devices: 0<br>
&gt;<br>
&gt; Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----<br>
&gt;&nbsp; 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 4c8f2f4647c0..89ed9b091386 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto init_failed;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume_iommu(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto init_failed;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_hw_in=
it_phase1(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto init_failed;<br>
&gt; @@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.pendi=
ng_reset)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_init(adev);<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume_iommu(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto init_failed;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fru_get_product_info(=
adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp; init_failed:<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB18849F60DEE73D7FB8E20017E4A99DM5PR12MB1884namp_--
