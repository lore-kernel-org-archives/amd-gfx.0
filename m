Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6BDC0015E
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 18:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8542210E256;
	Tue, 15 Aug 2023 18:21:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE0A10E0F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 18:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmLkKOwZAPU1ddwYp5vK2XUk2DQUJgSVQq6qObGRGBiojYwWU4J4t6COglpG+przvbjxLwpZXkwLxL8oMMM1U0G1WORHR3UkjrfDCJHAEledlJU3cbQdxRUud3iQIuVmqRZBSVFrNx+FTy1qZGf1KtRkJ0Wz7fH6W2bqIGIV/HhHSV1EWwBHPCiawkOsli7nUqaTBm270afjg+L7wtTxMUfnWjD/Hv3HgF7iT5qPyAFp5bKvtDTz/yeCkoftRPXE8JjrxanO5Iigr/caOXG8qXIRwefyzSqoluvSm4F3pI60NABiugEkvwy5AD6jZx5V/ZI9vQUK7eD+4vycezdvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb7qTj7qHk1nDxJLyEh9ktdBF4RGUqYokehlUMM36iY=;
 b=e1lXYD3b/tSk7Tzcem8T5DaDKhAk/UGIJL27U8dhtdwFSg2ru/Qxb+SRblxNPV7YJwoQ4NjyhLT+gTOaoeQ5sarViOssB8qgbuZTR9vRXSnY3GoAo49wGy+FdKloh6UkJj11bdI0Zm6S0r7grdcT8/Q+7291XHuTnv00i6rfnKX3n8xmkJr2kb8DpTq9aqBrUFDltHjZcZt0jsn2rIsg/l0dTKPSuaFxCF6WIX4fYc1h3ce4eRDB6tLDkefNZBMmjGaCgSjwRhXFasQJQEmbFKLCrb7+QTdy8ixSQQvT9JY3jpk9weBT8FkhTgnFMDMh1BLnPQ1PU0OSBVq0pUzhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb7qTj7qHk1nDxJLyEh9ktdBF4RGUqYokehlUMM36iY=;
 b=DrhWEclELh1Gt3KFYCu9xdOfW+oAQISmvWRRAkp0WetiXhqMlYk8mrmrmM4nLbdOgUxFCoQC8KaOFsnYKpLi2WJ5BYFGvY4QPuwixohpzZl3lZorZghVIFjbqPqLYH+66C905sV1jWqq+PPoYrfm2Py4TEUhS4MURaUnVklZ/iI=
Received: from DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:21:35 +0000
Received: from DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::f5f7:aafa:756c:f31f]) by DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::f5f7:aafa:756c:f31f%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:21:35 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
 support
Thread-Topic: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
 support
Thread-Index: AQHZz5BRTzOa6DNcxkK3YYfDsW5e16/roM0AgAAFoQCAAAElMA==
Date: Tue, 15 Aug 2023 18:21:35 +0000
Message-ID: <DS0PR12MB88132032DF5DEFF30EA57922F414A@DS0PR12MB8813.namprd12.prod.outlook.com>
References: <b737e90e-10f2-4ef4-b49a-2eba5f83afef@amd.com>
 <20230815155026.197131-1-bokun.zhang@amd.com>
 <BL1PR12MB514470FC4AD4C833397FBBFEF714A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BYAPR12MB4614E6A2747E8A1D8BE138F79714A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614E6A2747E8A1D8BE138F79714A@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-15T17:41:50.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8813:EE_|BL1PR12MB5174:EE_
x-ms-office365-filtering-correlation-id: 1fbc65a6-4a44-4b7e-de9a-08db9dbc758e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kv3V5PNRyWuhr8hVNmSGy8+M/2szJOTC9qFsIhifN/vkFztEyh8SCwCUObfNgTlFC3HjlB1maiTiPpBSFmFhq1oV+yfT6T4WvOw5g6qx3H34B72dqIpXgkZuMSSrVQs7FflRC7Dyj6OqYieL9kLLg8XrpOtNEiqttDxoGQkp/M04WVC4Tf3MFX3VFWIwgPtoACivgxHzPmst6hzGFklSiIgDfjhhGNEJ9fSg9ct5+TbFjgKAfBlwmHduqhC8xIjcb+mwNIaN+H0oc9QvwwMx8Jbkmu82cmh2PaM6bPErTfYHz09d4BBqbSjU1sw17Oui/FsYbEr/onDh4jT6vrswQPjBZvvmn5Xav6lkQdCJMtO0lQvY447IV60AQUC0IxV/DgmmU/BKGJ8BDF7jhmdcomepiAcw5n+p6DBuBpFSO43yhsh7I81oIiscuXXjaFBWcRVcTStMPCA9PS+A4DjFuxUKxpPpfWCBbsDgSg8ecpZuWz0+2cq5cUlYX/anThgttSP8rtOLQHmFthUsdTpEDXsbN/bVePmEbLrpAaVk1bN7gfi4iTbksZHq8TvyjVUjqjZPmoPQkFuq7o+EGTLr/Evv9NS4WoSQ3tBzka5MPxY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8813.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199024)(1800799009)(186009)(4326008)(38070700005)(66476007)(15650500001)(52536014)(33656002)(86362001)(64756008)(66556008)(66946007)(66446008)(7696005)(122000001)(71200400001)(53546011)(316002)(8676002)(9686003)(478600001)(26005)(6506007)(83380400001)(55016003)(5660300002)(2906002)(38100700002)(110136005)(41300700001)(8936002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BlgIP5ZcDa0xiVccLRfHRdOTxhJzX/EJeyR03dRCAb05/9u7qwb7xjyujHds?=
 =?us-ascii?Q?1diCBS2VHLtBnkb5UYcdCiNC5S0KFeVVDpXh7HBdiTVSex7tK//NOcHcTqGe?=
 =?us-ascii?Q?wqJNPBQKuAQaU7zkBbxWvA8fbia2CFdimZUMPtZ0WvsOwoDdM3PCpHVn70w6?=
 =?us-ascii?Q?+iIuEUVsas4jAXMWLruxWZ1iTAMFE+MYAH3YUpemkW0RwANHXY87y6U7V7I4?=
 =?us-ascii?Q?A+23oPTmXTEVP4hKfFPrOMp6+0zmBvAIOaPxPvO5pgoViPsV+iGxk3xrza1m?=
 =?us-ascii?Q?4WbHiwE/7/1+/pDYFZ5L0HuXtYIcOy2UX3aLw0flowMkbaCz9SBXpfsqqG0+?=
 =?us-ascii?Q?xnmF5gebkSOxcZmTTh0KmBVzdWWFFBwTdmJGqwQ8xu7vJSMTGZZeIcP/0+dM?=
 =?us-ascii?Q?faF4oGGVXJgq2ktiIvPJuFdqW3MkQqYeXGp/EfU6WeuzlxeGW5NjFbTU7q9G?=
 =?us-ascii?Q?yvfvS1cPTnGXWi3iC6wU7jkmeNvCeX1JaN+lMC5EfByJnBvmdt0Z5tlR4Ycx?=
 =?us-ascii?Q?90n7i0I8RHa9auALtLEhhlsvUPV8rB3Trf+t6y9hujbWYrvqNZ2b6yGyegnm?=
 =?us-ascii?Q?9hqzvVOY7hPXJ5ecNf7JEveStUWigecfqmL4Q8yfQiQMPMY+f8bcju28sKpi?=
 =?us-ascii?Q?e5iMp60UGp+PupedxdYZ+Z+y8E79aMQ68ZwCWE83p5+QkFe2+c8qC/ZAH8Zu?=
 =?us-ascii?Q?zRkEPnyxMo6mWHOTOqReN1XhZJRUfz9PNqPIvb9TODPdCrvvjIYzHCWIRJ8a?=
 =?us-ascii?Q?WB5WaR7O2rhVHtSfcrMG/ztL/zAiUf7Hbze3ZK51gCG/LCc2amKo/JWDTHT1?=
 =?us-ascii?Q?N+sfDncjYiaATBK5ozL+PqqcUMKQj9GgQnuLZkDf1DdU/slw12btr2X2+asU?=
 =?us-ascii?Q?R6SBkQ0aEmkQLfTplrGrSgbc4NT2j3u00X7+YMXO072vtplOCzc+1Thu6hnI?=
 =?us-ascii?Q?1lwy1z+YOC2zMGx9KTxXY39d1P4CddZV/VleY9/fc89CM0aYgdk8pXycULH0?=
 =?us-ascii?Q?T7TwyW/kNc68AGtLGGiELmThYKVZ4dpJ74Wjs5rzNz/IKApeWN+PdpnhE0L7?=
 =?us-ascii?Q?OdaCkHZ560trK0hSSo5fAxCCNF4+F+BXripZ77yVSxsxZ9IgF+xj2qy6bpNb?=
 =?us-ascii?Q?E6JqU2djM3K+5Z+slCAX4eBYHV3ow0P5aMgZlSFZi9Oe78i2ktCXtJfswGv4?=
 =?us-ascii?Q?7A+0h6dDWRmLHzfKsax5GW8TnyMYfP/kGsxLDMO4Kf1cCQXjtpO2XQCJlBu1?=
 =?us-ascii?Q?cJxTKpRgHsW9wdbVwWjK7cXZJ8yDigAjv9Wl/L3NXVOTUiGVQ+IaV13hjk4n?=
 =?us-ascii?Q?0f8HafXVlh0fXHuPMvZhsXDfXnYqADdjheEPRPMqVjcNS4tJRm0rJfjb1d0f?=
 =?us-ascii?Q?v3tIbjCweSvrSMAwhdL7vtTbXxtk6BSb4MQbMljFeC1+s6z8BZgU9u2C+Qp8?=
 =?us-ascii?Q?L3sSHslxEFIxD+y1s5bD13HMEox9+llzJhQroPQLCWhzIEbCVdAkwFjqaJ7w?=
 =?us-ascii?Q?UlwRVeOc4rsOq2DWfhQKP4FA7NKG6o84odKwomKTqaTlH2//r/E6hGi0Nant?=
 =?us-ascii?Q?cHra2m0FRjweizXAUhc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB88132032DF5DEFF30EA57922F414ADS0PR12MB8813namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8813.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbc65a6-4a44-4b7e-de9a-08db9dbc758e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 18:21:35.4445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AM80XxZinowcgZlN1CV8/i6n0f2lJ1l4jkBBfW6qTwYB52cYB7V3spnRxDTusZi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DS0PR12MB88132032DF5DEFF30EA57922F414ADS0PR12MB8813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hey Lijo,
I have considered to combine the function. However notify_display_change() =
may serve for another purpose as mentioned in the comment:

                /**
                * @notify_display_change: Enable fast memory clock switchin=
g.
                *
                * Allows for fine grained memory clock switching but has mo=
re stringent
                * timing requirements.
                */

This function is implemented as smu_v13_0_notify_display_change() for SMU 1=
3, but not included in smu_v13_0_0_ppt_funcs struct and therefore not calle=
d at the moment.
I am not completely sure about the purpose of smu_v13_0_notify_display_chan=
ge().
If it makes sense to combine them, I can make the change accordingly. But I=
 would like to know if I should add a new function smu_v13_0_0_notify_displ=
ay_change, or extend smu_v13_0_notify_display_change() and add it to smu_v1=
3_0_0_ppt_funcs.

Thanks!


From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, August 15, 2023 2:03 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Bokun <Bokun.Zha=
ng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC =
support


[Public]

There's already another smu callback - notify_display. This can be accommod=
ated there, no need to add another callback.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com<mailto:Alexander.Deucher@amd.com>>
Sent: Tuesday, August 15, 2023 11:13:14 PM
To: Zhang, Bokun <Bokun.Zhang@amd.com<mailto:Bokun.Zhang@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com<mailto:Bokun.Zhang@amd.com>>; Quan, E=
van <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
Subject: RE: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC =
support

[Public]

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of Bokun
> Zhang
> Sent: Tuesday, August 15, 2023 11:50 AM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com<mailto:Bokun.Zhang@amd.com>>; Quan,=
 Evan
> <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
> Subject: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
> support
>
> - There is a DPM issue where if DC is not present,
>   FCLK will stay at low level.
>   We need to send a SMU message to configure the DPM
>
> Reviewed-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com<mailto:bokun.zhang@amd.co=
m>>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                  | 6 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h              | 5 +++++
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   | 5
> ++++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       | 7
> +++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h                | 1 +
>  6 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f005a90c35af..c65bebdbec11 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1410,6 +1410,12 @@ static int smu_smc_hw_setup(struct
> smu_context *smu)
>               return ret;
>       }
>
> +     if (!amdgpu_device_has_dc_support(adev)) {
> +             ret =3D smu_notify_no_dc(smu);
> +             if (ret)
> +                     dev_warn(adev->dev, "Failed to notify no dc support=
,
> driver may not reach best performance\n");
> +     }
> +
>       /*
>        * Set min deep sleep dce fclk with bootup value from vbios via
>        * SetMinDeepSleepDcefclk MSG.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..c8fdc3d0aa25 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1356,6 +1356,11 @@ struct pptable_funcs {
>        * @init_pptable_microcode: Prepare the pptable microcode to upload
> via PSP
>        */
>       int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +     /**
> +      * @notify_no_dal: Notify SMU that there is no display and SMU
> should control DPM

Fix the function name in the kernel doc comment here.  With that fixed, pat=
ch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deuch=
er@amd.com>>

> +      */
> +     int (*notify_no_dc)(struct smu_context *smu);
>  };
>
>  typedef enum {
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> index 10cff75b44d5..e2ee855c7748 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> @@ -138,7 +138,10 @@
>  #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
>  #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
>  #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
> -#define PPSMC_Message_Count                      0x4D
> +
> +#define PPSMC_MSG_DALNotPresent                  0x4E
> +
> +#define PPSMC_Message_Count                      0x4F
>
>  //Debug Dump Message
>  #define DEBUGSMC_MSG_TestMessage                    0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..f71fc99447f2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>       __SMU_DUMMY_MAP(AllowGpo),      \
>       __SMU_DUMMY_MAP(Mode2Reset),    \
>       __SMU_DUMMY_MAP(RequestI2cTransaction), \
> -     __SMU_DUMMY_MAP(GetMetricsTable),
> +     __SMU_DUMMY_MAP(GetMetricsTable), \
> +     __SMU_DUMMY_MAP(DALNotPresent),
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)        SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 48b03524a52d..41412cf891a7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D
>       MSG_MAP(AllowGpo,                       PPSMC_MSG_SetGpoAllow,
> 0),
>       MSG_MAP(AllowIHHostInterrupt,
>       PPSMC_MSG_AllowIHHostInterrupt,       0),
>       MSG_MAP(ReenableAcDcInterrupt,
>       PPSMC_MSG_ReenableAcDcInterrupt,       0),
> +     MSG_MAP(DALNotPresent,
>       PPSMC_MSG_DALNotPresent,       0),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] =3D
> {
> @@ -2601,6 +2602,11 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct
> smu_context *smu,
>       return ret;
>  }
>
> +static int smu_v13_0_0_notify_no_dc(struct smu_context *smu)
> +{
> +     return smu_cmn_send_smc_msg(smu, SMU_MSG_DALNotPresent,
> NULL);
> +}
> +
>  static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
>       .get_allowed_feature_mask =3D
> smu_v13_0_0_get_allowed_feature_mask,
>       .set_default_dpm_table =3D smu_v13_0_0_set_default_dpm_table,
> @@ -2680,6 +2686,7 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>       .send_hbm_bad_channel_flag =3D
> smu_v13_0_0_send_bad_mem_channel_flag,
>       .gpo_control =3D smu_v13_0_gpo_control,
>       .get_ecc_info =3D smu_v13_0_0_get_ecc_info,
> +     .notify_no_dc =3D smu_v13_0_0_notify_no_dc,
>  };
>
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index bcc42abfc768..9b9a13fdcef8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -97,6 +97,7 @@
>  #define smu_get_default_config_table_settings(smu, config_table)
>       smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP,
> smu, config_table)
>  #define smu_set_config_table(smu, config_table)
>       smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
>  #define smu_init_pptable_microcode(smu)
>       smu_ppt_funcs(init_pptable_microcode, 0, smu)
> +#define smu_notify_no_dc(smu)
>       smu_ppt_funcs(notify_no_dc, 0, smu)
>
>  #endif
>  #endif
> --
> 2.25.1

--_000_DS0PR12MB88132032DF5DEFF30EA57922F414ADS0PR12MB8813namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-CA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hey Lijo,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.75pt">I have considered to co=
mbine the function. However notify_display_change() may serve for another p=
urpose as mentioned in the comment:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @notify_display_change: Enable fas=
t memory clock switching.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Allows for fine grained memory clo=
ck switching but has more stringent<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * timing requirements.<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.75pt">This function is implem=
ented as smu_v13_0_notify_display_change() for SMU 13, but
<b>not included</b> in smu_v13_0_0_ppt_funcs struct and therefore not calle=
d at the moment.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.75pt">I am not completely sur=
e about the purpose of smu_v13_0_notify_display_change().<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.75pt">If it makes sense to co=
mbine them, I can make the change accordingly. But I would like to know if =
I should add a new function smu_v13_0_0_notify_display_change, or extend sm=
u_v13_0_notify_display_change() and
 add it to smu_v13_0_0_ppt_funcs.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.75pt">Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.75pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;
<br>
<b>Sent:</b> Tuesday, August 15, 2023 2:03 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Bok=
un &lt;Bokun.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;; Quan, Evan &lt;Evan.Qu=
an@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdgpu/pm: Add notification function for=
 no DC support<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">There's already another smu callback - notify_displa=
y. This can be accommodated there, no need to add another callback.<o:p></o=
:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexa=
nder.Deucher@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, August 15, 2023 11:13:14 PM<br>
<b>To:</b> Zhang, Bokun &lt;<a href=3D"mailto:Bokun.Zhang@amd.com">Bokun.Zh=
ang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Bokun &lt;<a href=3D"mailto:Bokun.Zhang@amd.com">Bokun.Zh=
ang@amd.com</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Ev=
an.Quan@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amdgpu/pm: Add notification function for=
 no DC support</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[Public]<br>
<br>
[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Bokun<br>
&gt; Zhang<br>
&gt; Sent: Tuesday, August 15, 2023 11:50 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Zhang, Bokun &lt;<a href=3D"mailto:Bokun.Zhang@amd.com">Bokun.Zhan=
g@amd.com</a>&gt;; Quan, Evan<br>
&gt; &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.com</a>&gt;<br>
&gt; Subject: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC=
<br>
&gt; support<br>
&gt;<br>
&gt; - There is a DPM issue where if DC is not present,<br>
&gt;&nbsp;&nbsp; FCLK will stay at low level.<br>
&gt;&nbsp;&nbsp; We need to send a SMU message to configure the DPM<br>
&gt;<br>
&gt; Reviewed-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.q=
uan@amd.com</a>&gt;<br>
&gt; Signed-off-by: Bokun Zhang &lt;<a href=3D"mailto:bokun.zhang@amd.com">=
bokun.zhang@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; | 6 ++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 5 +++++<br>
&gt;&nbsp; .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h&nbsp;&n=
bsp; | 5<br>
&gt; ++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 3 ++-<br=
>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 7<br>
&gt; +++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_internal.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +=
<br>
&gt;&nbsp; 6 files changed, 25 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index f005a90c35af..c65bebdbec11 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -1410,6 +1410,12 @@ static int smu_smc_hw_setup(struct<br>
&gt; smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_has_dc_support(adev)) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_notify_no_dc(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, =
&quot;Failed to notify no dc support,<br>
&gt; driver may not reach best performance\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Set min deep sleep dce fcl=
k with bootup value from vbios via<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SetMinDeepSleepDcefclk MSG=
.<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; index 6e2069dcb6b9..c8fdc3d0aa25 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; @@ -1356,6 +1356,11 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @init_pptable_microcode: P=
repare the pptable microcode to upload<br>
&gt; via PSP<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_pptable_microcode)(stru=
ct smu_context *smu);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @notify_no_dal: Notify SMU that ther=
e is no display and SMU<br>
&gt; should control DPM<br>
<br>
Fix the function name in the kernel doc comment here.&nbsp; With that fixed=
, patch is:<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">=
alexander.deucher@amd.com</a>&gt;<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_no_dc)(struct smu_context *smu)=
;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; typedef enum {<br>
&gt; diff --git<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h<br>
&gt; index 10cff75b44d5..e2ee855c7748 100644<br>
&gt; ---<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h<br>
&gt; +++<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h<br>
&gt; @@ -138,7 +138,10 @@<br>
&gt;&nbsp; #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A<b=
r>
&gt;&nbsp; #define PPSMC_MSG_SetPriorityDeltaGain&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4B<br>
&gt;&nbsp; #define PPSMC_MSG_AllowIHHostInterrupt&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4C<br>
&gt; -#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x4D<br>
&gt; +<br>
&gt; +#define PPSMC_MSG_DALNotPresent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4E<br>
&gt; +<br>
&gt; +#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x4F<br>
&gt;<br>
&gt;&nbsp; //Debug Dump Message<br>
&gt;&nbsp; #define DEBUGSMC_MSG_TestMessage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x1<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; index 297b70b9388f..f71fc99447f2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; @@ -245,7 +245,8 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(AllowGpo),&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(Mode2Reset),&nbsp;=
&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(RequestI2cTransact=
ion), \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetMetricsTable),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetMetricsTable), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DALNotPresent),<br>
&gt;<br>
&gt;&nbsp; #undef __SMU_DUMMY_MAP<br>
&gt;&nbsp; #define __SMU_DUMMY_MAP(type)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SMU_MSG_##type<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; index 48b03524a52d..41412cf891a7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; @@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping<br>
&gt; smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowGpo,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetGpoAllow,<br>
&gt; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowIHHostInterrupt,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_AllowIHHostInterrupt,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ReenableAcDcInterrupt,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_ReenableAcDcInterrupt,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DALNotPresent,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DALNotPresent,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT=
] =3D<br>
&gt; {<br>
&gt; @@ -2601,6 +2602,11 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct<=
br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static int smu_v13_0_0_notify_no_dc(struct smu_context *smu)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg(smu, SMU_MSG_DAL=
NotPresent,<br>
&gt; NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_allowed_feature_mask =3D<br>
&gt; smu_v13_0_0_get_allowed_feature_mask,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D smu_v13=
_0_0_set_default_dpm_table,<br>
&gt; @@ -2680,6 +2686,7 @@ static const struct pptable_funcs<br>
&gt; smu_v13_0_0_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_hbm_bad_channel_flag =3D<br>
&gt; smu_v13_0_0_send_bad_mem_channel_flag,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gpo_control =3D smu_v13_0_gpo_con=
trol,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ecc_info =3D smu_v13_0_0_get_=
ecc_info,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .notify_no_dc =3D smu_v13_0_0_notify_no_dc,<=
br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
&gt; index bcc42abfc768..9b9a13fdcef8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
&gt; @@ -97,6 +97,7 @@<br>
&gt;&nbsp; #define smu_get_default_config_table_settings(smu, config_table)=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(get_default_config_t=
able_settings, -EOPNOTSUPP,<br>
&gt; smu, config_table)<br>
&gt;&nbsp; #define smu_set_config_table(smu, config_table)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(set_config_table, -E=
OPNOTSUPP, smu, config_table)<br>
&gt;&nbsp; #define smu_init_pptable_microcode(smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(init_pptable_microco=
de, 0, smu)<br>
&gt; +#define smu_notify_no_dc(smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(notify_no_dc, 0, smu=
)<br>
&gt;<br>
&gt;&nbsp; #endif<br>
&gt;&nbsp; #endif<br>
&gt; --<br>
&gt; 2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS0PR12MB88132032DF5DEFF30EA57922F414ADS0PR12MB8813namp_--
