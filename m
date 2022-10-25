Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29331C67871
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 02:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19ACB10E0ED;
	Tue, 25 Oct 2022 02:51:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6DB910E0ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 02:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4g8754a/YOu4eyZY3uibJoUlwyB7zwlpSsUxDvmZgi4y69yGCG5XAovomcUesF5+7YjZrAFDCfBKvUjGcEpb3Uw7RQuoKmIV54LCg8BEv574Iu3qXmbSN+99B+tJqxKOPuOhP9aLxXQYx7OgFe7wawjaoji0/jze5UilYWM35uReUW+Bgdw95zZK2AyNPic0SMGAZz8bft4Lmzmrf+HY1c6mYeGVkzbhd2BLnmjp98oUxNxhoodbNL/xZ73K/Tu8dPWXHXQjCV4a8zraQynLd7Cgx5r0t1ZQBSZcD8yrxitLT+zGH0G4STyBQfFWiVCtLB1HlDTXyjplK62CMUjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s9fbp45/kLjmiaufVfQAxTAAhraHoHeGyE1JectCIg=;
 b=Etg8YPaVtHoJVRZ6nJ/uPbmF5kG82bvJ51YPyX0gtCtnWODnOEKfRDKM2ceO5AWENNlhQnUDUANhr19hOQKojNIC81BM8FIzYhr0angUiC4jAv/FsEleMuqNELrww1vW3a8QlGXfD3HR4yQUb+Yh8eYU/9eJdAMH9Gaknv3TRTlzCTj+4FmEJukNL9oEKyDFTDQh5wXpeV5mbmAvl0NdV2A+wBMjBpITSlahfnO8JzdhGR3Xa/WMA1OXiaybZF6TnJ/2mTY4jVEVrDhS198ZQ9u6DfVYRHji1oOYQbOT7Vj+Sd0+Fn/JcOqQAEtV9zv8zl+C2rKH68Mfhz5WfTUIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s9fbp45/kLjmiaufVfQAxTAAhraHoHeGyE1JectCIg=;
 b=wcJd414U4WQlIeTA+XS8sv/f0OopVQO3AjsZS+BmGrFahFT7sCFwnABe30nzsd/6Lg26PzRc41nhcLhrqaTpdh1F4sLJTXm9vnkgN7nCLBcj6wD7BNo5qlN/Pm6zd1UxB0VRWRBfQBCFN5q1yP8Hpxw4CyBY6xBJcfNMk+x5JA0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Tue, 25 Oct 2022 02:51:45 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::922d:e78b:3a15:9098]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::922d:e78b:3a15:9098%5]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 02:51:45 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks
 complete s2idle resume
Thread-Topic: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks
 complete s2idle resume
Thread-Index: AQHY5VwPHBvhfAv1cECfZUshlJDq9q4dGaQAgAFUbMA=
Date: Tue, 25 Oct 2022 02:51:45 +0000
Message-ID: <DS7PR12MB6005B91EFE5C56A014DE3C59FB319@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20221021144728.2798803-1-Prike.Liang@amd.com>
 <DM6PR12MB26196D74CBD6D1D8BFF5F3E5E42E9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26196D74CBD6D1D8BFF5F3E5E42E9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f78d7ad1-ed73-4a3a-a1e2-81d83674c75a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-25T02:49:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6153:EE_
x-ms-office365-filtering-correlation-id: 5d88fad7-5596-4621-9df1-08dab633da97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PN4BpQwCg4dP4sjEE3+W+8/AQa7hLMTwkkyzhxVeJmTnnAT/U+J2ZllPpFzdrMg0UurbbjXEHASsRPV4C5qGl5HlA//luIgwG8CsS4bnQYzlVzFItToFGSRvSU3e/fKYJl6xcFFOFVTbEPtgWgj7u3RjORAV2/HMEMkfrXW633swR1ehtoSxtS4CytHE0OqCpvoEO4CAMav6x5wDLtFM+WHPbmZtW8hZb0gkmvYvvNAtWSvAdtQpvfT50JFPhQoOtpQQBjnYTTNOJgRFWAstGTpjYRIjdLbYGmKEle0izP8Cw54fWmw9bBL/rDarefvuWMcjmgewDGJHpHFsQki0UwI+6a4045gnaAsWCvdcLpzOvQ2QQ6blOZBwByb/b0Mv6FvLlrnBRiitnGvayx3Fuow5i4VyPqNcKXJZfU9Z/OPvFG31ddS7N/L9rZRrsoBvk9GwYJfK+KpGnac56bPGSdOiG0LIpZdZecmWjrj6YZyVRDyT/B7tKW5OCpsSH9CZAybFuByML/4raugppGVET6ziftb0DR+4GtVkVm5/gvRkWO495kr0ggLlxmt+yJfRrS+ykRrIIuib4lfSKdoCvM3sw2Ix6Ova6AaNJrCpBwEzcZzi6m3GSvhtfTEsaHzLjCWdJto41M6rrNmc1t9XNmR9Zfm2Nm4l+YzIH5HX/i9b6WQWmbgeGq3hLT5Akw5pLZD7hQEFFQhffQMHKA0d5Uyhvbxf+8jAY4wLvLeXEx4UHVDJB+8SJq4R5fvR6tCep9Xw5Cmt9QBZr5fZugFWzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(186003)(478600001)(6506007)(9686003)(7696005)(52536014)(26005)(110136005)(53546011)(4326008)(316002)(33656002)(86362001)(76116006)(71200400001)(38070700005)(122000001)(55016003)(38100700002)(66946007)(41300700001)(5660300002)(8676002)(64756008)(66446008)(66476007)(83380400001)(8936002)(66556008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RY3Jx9WNevb1L7KRbXm+z6yFXVF0xokpwFck56zQnQobPdqMQ/wrkLEkjdNT?=
 =?us-ascii?Q?VJ4XTjzPBq9nNO3ZLja9oEe18PjySohonuTLR4ppGsE5F7r9xXg+G5AjwMsq?=
 =?us-ascii?Q?ZNxC6UCi5YlgA1Lsjz4fZChegPERVJcOKIYLYAk/obiLE2mYI1rrKCc+/EV5?=
 =?us-ascii?Q?RYLCwEO/KTJ9ldLNveEhzFSIQhrztAO7Ko/zsS88T3QApR/DN8F1GNTKjXM6?=
 =?us-ascii?Q?NYlJ2TuZdZ4PS5HaM2+pwBJ4pgrFQ7pP9Yr0/2CqLpfVX5ojorvGDubxHsxS?=
 =?us-ascii?Q?uQJAllrAduvzgYDfay3XxyTYFcozEZ8oL6qNyrwcJh95HNeRTROdTxgZMope?=
 =?us-ascii?Q?fPzYv97MFw9XVU5PAHjiK5UzGl4bBA7CguC7P1GH/vRIsKCrEe32J9l1D4m1?=
 =?us-ascii?Q?7fUOs2KTRdk69VVg5Si+zowkpPMTGNLaS4MkOe+hRPd8mlFPwJ+WFLrm1ZVR?=
 =?us-ascii?Q?AsIUOwsQhSs9lPZNuRKu0A+omHdfTKK/YeadHAJTRO6FhVp+KMq6VAQ+gbB2?=
 =?us-ascii?Q?qCI2etzvrSEHJfTmZs3sQTnFkvml9LQUT+Hsxpne3AskEf3eXsOM/jr8CE2A?=
 =?us-ascii?Q?Pdus1PG+XFG9kf3lTaa2Gc8xUZceEIMhR+TSgi4wsYEhS5vK6uKL8rpFblJn?=
 =?us-ascii?Q?ijT7SA7eJjWS8hNoOd9lY02RH7kcxmjbJtSbQGIK7Yr5Lcp3dV7rB5ayxnXY?=
 =?us-ascii?Q?YsIHabbHhtWSSwBLNrw99hOmWZ0vUy8D4bkp7bqBgzXKYk2+F9Q8bKih42F/?=
 =?us-ascii?Q?OItwqrYImuaXZ4R9ju3lJkz1jduOtzU9BpC4CG1ruX/gAhSECB2sHALssLVj?=
 =?us-ascii?Q?FmgXcnFh7N0Y43A9yfLetY3gbSntDJtuI2X5uzbDhERaf1dD5vZxUDe4k+4Q?=
 =?us-ascii?Q?IedtOZypH5FB1cRpf4wylzRLDZNvO80OYVLmYuW+PUU+F7MsvGeveYV/lY8h?=
 =?us-ascii?Q?drMyCajbCU4qAKoc2bpph9RVWNFu66h84rGOgWjdI7ePdyX961gKKwt7ZnHq?=
 =?us-ascii?Q?LeVWtw/jkTT5k1OuqAjlTK75zqxPbF65Km/EiCLS15xifHpYI4oT+O17HPNN?=
 =?us-ascii?Q?cKWO1HzyhxQyI/pkk9O9dFVhZcpCMc3RaPXaAyc6ULIGeJmp7WXu7cky+Imh?=
 =?us-ascii?Q?b5nB/mbb2KV7zP+8PX9HwuENFC2Skm6Px/HUplUE10bdOgykGauHL79pXFRZ?=
 =?us-ascii?Q?ecL2yfbr9lLAmWSn22oXMakPp0M15zILBMt4w0c3BPhbN1MoQpnU4YLj5ZaR?=
 =?us-ascii?Q?qAFw8ikmBsZK4ANKakjMfG2xXgCI9giW1eTjEUjJSK+tdXwa5ZPa+4lgqUab?=
 =?us-ascii?Q?RREk5dCZcq1ye9etXKwKU+o8ej1WVVFO43oIztY+p5CdGaJrh1Kve4qYswaI?=
 =?us-ascii?Q?h7GxToF3P9RQnSq1HRs26JyBirv+HSK0bdgJmXpoC2l+TP9tElb8ECY7L+4F?=
 =?us-ascii?Q?MMhepaxpjTMH8k+57N6XcsGpLZIId5VZOEXt7Eyrqgt4oxJeQ8QfRi3fIcD6?=
 =?us-ascii?Q?g3p1OmDUrPPSQU7Zn9OsAsbLRIZYFbtdm1aWXAYkwX0kaNooJOxWanKDfH3Q?=
 =?us-ascii?Q?FnxBtjuyBfffIeREcr4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d88fad7-5596-4621-9df1-08dab633da97
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 02:51:45.2920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmd+cXaecpyb6Plj84sCHAzKuAJ/6isM/8WkupMY/Sl6HS4AosO8I85INZUmID62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, October 24, 2022 2:31 PM
To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Lia=
ng@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks comp=
lete s2idle resume

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Prike Liang
> Sent: Friday, October 21, 2022 10:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks
> complete s2idle resume
>
> In the S2idle suspend/resume phase the gfxoff is keeping functional so
> some IP blocks will be likely to reinitialize at gfxoff entry and that
> will result in failing to program GC registers.Therefore, let disallow
> gfxoff until AMDGPU IPs reinitialized completely.
[Quan, Evan] It seems the issue described here has nothing related with sus=
pend. Instead it happened during resuming only. Right?
If so, I would suggest to drop the confusing "suspend" from the description=
 part.
Other than that, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan

[Prike] Yes this problem only observed on the s2idle resume period, but tha=
t's true the s2idle suspend and resume keep the gfxoff being functional.

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
> -v2: Move the operation of exiting gfxoff from smu to higer layer in
> amdgpu_device.c.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5b8362727226..36c44625932e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3210,6 +3210,12 @@ static int
> amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>                       return r;
>               }
>               adev->ip_blocks[i].status.hw =3D true;
> +
> +             if (adev->in_s0ix && adev->ip_blocks[i].version->type =3D=
=3D
> AMD_IP_BLOCK_TYPE_SMC) {
> +                     amdgpu_gfx_off_ctrl(adev, false);
> +                     DRM_DEBUG("will disable gfxoff for re-initializing
> other blocks\n");
> +             }
> +
>       }
>
>       return 0;
> @@ -4185,6 +4191,10 @@ int amdgpu_device_resume(struct drm_device
> *dev, bool fbcon)
>       /* Make sure IB tests flushed */
>       flush_delayed_work(&adev->delayed_init_work);
>
> +     if (adev->in_s0ix) {
> +             amdgpu_gfx_off_ctrl(adev, true);
> +             DRM_DEBUG("will enable gfxoff for the mission mode\n");
> +     }
>       if (fbcon)
>
>       drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
> >fb_helper, false);
>
> --
> 2.25.1
