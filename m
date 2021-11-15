Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6224BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 15:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B91461A3A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 15:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B91461A3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D861C6E106;
	Mon, 15 Nov 2021 15:06:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7316E106
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 15:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSwIDmvtY6tA9PKaNQkxtmBhWdu0WtUifoPBbJ5fZzGAjziybkT1EbbGBBFbhHx9Wa7eFKVpgEKRUI62GNYOuOYEGtIkuEOWf99qQvMXVOoIG8dily3xHt6hLrn67bPZmLplIkkmRizshnhMakdflIN1VL1dtt7hnMcJoO2LQq90/5zuFnlUDyEN097/UboUtJjKUwBO+5E3oc6ROFr4yblgU0N4Bs1cleOAAiPF8Vey7LF9QrlWrdwBPjIODlpLKE70zgcHyZBEtxr1LpvCTB81fnzvlDvhBDj5KLGIn58hLPIyObl62oC16nsGsPH6UdUa//YH+KgwppbPYU5qTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mauUasNZCVfcs8/hN+xZ6DCYWmjn/CnIXyFpnJbhUk0=;
 b=GttLpQUcUUaGfXU74T18mvvy01E496GNjBL40MCwF2+7hFNbpVT9PoZMcAegb4iAc+2WFNiFBaJIX23QBrBPBDWzTF+N4VF6bHNr82jiFgKJ++m7yiChtLjDC++FBeeCiOt7eIUVFtQtETKWZHw2TKOrQg9GuwVO0VY5CLoIgDDyJ0F5N7RKXDzDphpJtxJ+iG4slxQp97w5PB1qXP6ABxOwmWhlGnPzlwGNnfEXb1OULKpvTwuLygji/IrJ2mGeO9hPQRfWIUuvjAXrkU7CsVp94ruEpvCq5TLiINFhSxydaqasYGTYJGIydV+WVwz69Vd0BaojAtHzpisMwYZjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mauUasNZCVfcs8/hN+xZ6DCYWmjn/CnIXyFpnJbhUk0=;
 b=YuyzvnVI/ef+9GdUPPsUFbFRhmEhh9gG320tfr/ocj5rcmnhyeoa4/R3o4UfNb1abjm5HB7lBABH9U0xP3sbTB0QYxs/nIajj16jEyNUA6uzFD7VmAKtzkfHzJkZqqeJ3DQS2tCQjqmPEOvmvyySQ95MyvkI5I1/3NToWaQfAuY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 15:06:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 15:06:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset the asic in suspend
Thread-Topic: [PATCH] drm/amdgpu: always reset the asic in suspend
Thread-Index: AQHX1+Da/ALKsNBhtUKtu/iRoK4hC6wAEoSAgASKkwCAABc5ZA==
Date: Mon, 15 Nov 2021 15:06:09 +0000
Message-ID: <BL1PR12MB514427984F4757CEBAF182D9F7989@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211112161737.135848-1-alexander.deucher@amd.com>
 <CADnq5_OR7u2FuTbvuysZAHJ+gEso8NzKFaMN3U4fSTOqtft1XQ@mail.gmail.com>
 <a1c4ef7e-9466-6ed3-a23e-28bc5db9d4c4@gmail.com>
In-Reply-To: <a1c4ef7e-9466-6ed3-a23e-28bc5db9d4c4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-15T15:06:08.954Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 24174de1-9a43-2818-6234-d02a47e13207
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 928b4f3c-b6b3-40b0-5929-08d9a8497520
x-ms-traffictypediagnostic: BL1PR12MB5362:
x-microsoft-antispam-prvs: <BL1PR12MB5362456FFE220B145A3AEF15F7989@BL1PR12MB5362.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmQalRrYiF7DS+gGdw3VzZZhzMgEOjworRLXi+omQa9vg+MtwUyGlHIVvNtrpXUib5FpPVB9YmOFRAF8Efk6gyS0CVZrLLHdgXTlun/cTiamQtdinhFiA6fmrzQJSwXujnrBP2afM5+EeFnkzRytAaUDvsJfnUOd2WeDNgcSzZq8X7L5KiSyDxxcH5BSl2hut8STJ5775g8IpJBQZZTh5LBQ67vffY9NG7mqU1aneavgwsMjGbQnZsTdvRGplBkpk6zCKG9aXXZ6GEo76UwhDlBKQpGhL47NFVAsPjjbXk+0CuJpeFCGTh6vP1Pf0JFzQeZzfkmkmcrWTMFURSZaKTN1agMnEY3XsTUK82MIj8h0S+tOPxQTEX9Ub/0e3WGLNhvs2fXZdOO4N2LJ8KXZo+F5KwpsMgufbWQxMjEH0fsNritvnr+2PerFG0+Mkoep89V8jVw9TwwNk/ELyVt4xkNgXyUhdvApnFkq/jlfufSPkOm21h+eK31k3uVr8OGwmQCehX01+5QPu5TvkbxWLS/SzR8ytq7EjD9PUTVXsHOh+vHr3sUmb9L+MvnfSvr5S/S5MPsSzSYs0Po1WydN+FWurnBWG0Vd8afzsYEXLBQTHBCFOXYQvEwdnmpEoqOMY77hXOppI0BDoagPjsw/w0vlb7f2bW0JYbcNHc9vcXiMVycGKbTCgvAGYeQKn97h9MPbxh3LwJfFTwnOHOgIpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(38100700002)(9686003)(33656002)(53546011)(66446008)(19627405001)(122000001)(83380400001)(186003)(4326008)(66574015)(52536014)(66556008)(55016002)(2906002)(26005)(86362001)(71200400001)(7696005)(508600001)(76116006)(66946007)(5660300002)(66476007)(64756008)(110136005)(15650500001)(6506007)(316002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dimJB5rU2TQontQczp88qFMQf5FfAFDbDPV4Vn3mj28IEUT6m/2n5ZQ2+x?=
 =?iso-8859-1?Q?juzx2uE4bQU3fhqG4KkAQoVPeyXLoxZuC6LpY9Frq01tHbygCrmcqWRTYb?=
 =?iso-8859-1?Q?EJ7A1HhlNco4hnFMwgtahw54VMVlCWbWloiS1QfeJ2+lWbt12ygy4g8Xwt?=
 =?iso-8859-1?Q?AQKJT0P+6yxg/UtRq5j7IHXJYyYGn5iY9Aszexswlq2IcSd7C1xMZTgXo7?=
 =?iso-8859-1?Q?YlXoiAXyO6QaCIduMaBF9UuDYuvOvltwvJdevjgHeG2TC0Cvzofs11PZg4?=
 =?iso-8859-1?Q?OX7JK8XjNwxsNmFAQWwn5+ZiTc6wo1RhdCMvO1lH0RrvtJWvQAS+CDOcNU?=
 =?iso-8859-1?Q?HWf40sej+nggc0z5ozMkVFm3AX9Q/7Yd0NMjrhc+Y88LeL2eA15FdItka8?=
 =?iso-8859-1?Q?XVpObWHwf+UUB5m+Eia/pzqPjNKu9UsoI+hlrN6lkt6Oov+WHGwarcMkyq?=
 =?iso-8859-1?Q?iOBUabNc4shLX5LAd94KHUSU+YVclHWbejUiaJAbUeV2Ff6dFhX4ZCDAs1?=
 =?iso-8859-1?Q?McahsoWv7Nkbk/UtabBZWKi1duQrDf2KwxR2ZRj7QJymZ2C4RciCv7HIPU?=
 =?iso-8859-1?Q?TPDARcIukmPCiuDpTsqywR70mrjPgsSxEVIDYkRZJXoKDXPL20X0wd7tnb?=
 =?iso-8859-1?Q?gqO/dZYrRNI7VhsOoKi20TojRkGv8TlKLRv/NFxKKe2u5hmr7CKrn3vB6S?=
 =?iso-8859-1?Q?BOSt+zoYasdfNlKs6qY2rwlVZu4oXmbdAfFxO1zBjvGzYwrbXgXnIg3gP1?=
 =?iso-8859-1?Q?MGJjUpAPYnRrXpObkLKCrR+hyN5feBPcOkY2TkyM5LhtPYjySOcw2ZR3L7?=
 =?iso-8859-1?Q?M/iHrho/uMnamXJrWYFxDkAFkMzv0qPBOX92sgfnrYyqxDA660iCPEGX5O?=
 =?iso-8859-1?Q?8kucawDUYP0fTpVRIehwLWUEFvHeAeYFOQAo2X1F00douSJ31kP9aPfP5H?=
 =?iso-8859-1?Q?AoCMC57hdrvsCxwl3yTjdYXBFuZ4VfESR8u/WPB8GrMa7bW5p30RDnYWdl?=
 =?iso-8859-1?Q?c0de+VlEKcT7gkszZ0lBaWh5ytj7cZirojC6m3x0ZeOXxVLoGrenZqBt+K?=
 =?iso-8859-1?Q?BLkGMgpbsSoc0X1u+BC9htv8oR8xg6G/3e81IYoVlr8aNi5teUB0tWvBTo?=
 =?iso-8859-1?Q?NyDTdqBLtdSsA9uP2W6j9XLu9HZKsSn5fSmBzIGa7AXErcRmd9xfZdzTJz?=
 =?iso-8859-1?Q?rlrSB4aDqnH/ZRd8mV7yL1/3/J1dQf5nAuF+mIZ4cWkj7i5GVpggQ76RnA?=
 =?iso-8859-1?Q?pqAsC8ksajgJEesT1sLNHIkmFM/Q0co3WzIcX1VD8tk3ZcC9ztx5pxJ9Ma?=
 =?iso-8859-1?Q?ibzajheVQkKcHq0zS5wVRO1XlkyMGKjS2Pd6BFx5Xl/9bNylyvRNZQECPc?=
 =?iso-8859-1?Q?L+TaHwnUPs7wnGXgtGJBRN+XihNyrUWxYSguEIjIEZyRfDqLCepJGEUGHp?=
 =?iso-8859-1?Q?bQu8U14aYY1+KkQ+DboZVNKMaPxFCdCkfealLirMY9EVCl41BKS5yhH9Hd?=
 =?iso-8859-1?Q?l1tUxxo4rLRHDcGVZZB6dBxVp6gbLAxghLheAhIVjXmKe0Ck3cOSv1eDKM?=
 =?iso-8859-1?Q?9N8Rcx0+c4C8MLDD7328p3aCoqHe7HpMPlkBov1G6iuXnR6KgHDNf587+O?=
 =?iso-8859-1?Q?d11XmyrbngtGifpu/twI+rBbDy/bBSyftB+Yhcrvv13hFI/TbkqhTLwQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514427984F4757CEBAF182D9F7989BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928b4f3c-b6b3-40b0-5929-08d9a8497520
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 15:06:09.9046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9a4e53fJW7NN04qkrDea9cAG5PiCbnzRPh02JP3idNCYQRS5prIvX+lS7yOczSP/1s1rEdlqLr7f9nuesWH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514427984F4757CEBAF182D9F7989BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Well, that handles the case of the GPU needing to be reset on driver (e.g.,=
 virtualization), but doesn't handle the interrupted suspend case (e.g., wh=
en suspend is unwound before the power rail was turned off).  We already so=
 something similar for hibernate to deal with the multiple freeze and thaw =
cycles.

Alex

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, November 15, 2021 8:41 AM
To: Alex Deucher <alexdeucher@gmail.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: always reset the asic in suspend

I was just about to write up my concern as well.

IIRC we used to have that and it didn't really worked that well and we
switched to resetting the GPU on driver load instead if initializing it
doesn't work of hand.

Christian.

Am 12.11.21 um 17:19 schrieb Alex Deucher:
> Actually, ignore this for now.  This will likely cause problems with S0ix=
.
>
> Alex
>
> On Fri, Nov 12, 2021 at 11:18 AM Alex Deucher <alexander.deucher@amd.com>=
 wrote:
>> If the platform suspend happens to fail and the power rail
>> is not turned off, the GPU will be in an unknown state on
>> resume, so reset the asic so that it will be in a known
>> good state on resume even if the platform suspend failed.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_drv.c
>> index 1db76429a673..42af3d88e0ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2165,8 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev=
)
>>          adev->in_s3 =3D true;
>>          r =3D amdgpu_device_suspend(drm_dev, true);
>>          adev->in_s3 =3D false;
>> -
>> -       return r;
>> +       if (r)
>> +               return r;
>> +       return amdgpu_asic_reset(adev);
>>   }
>>
>>   static int amdgpu_pmops_resume(struct device *dev)
>> --
>> 2.31.1
>>


--_000_BL1PR12MB514427984F4757CEBAF182D9F7989BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Well, that handles the case of the GPU needing to be reset on driver (e.g.,=
 virtualization), but doesn't handle the interrupted suspend case (e.g., wh=
en suspend is unwound before the power rail was turned off).&nbsp; We alrea=
dy so something similar for hibernate
 to deal with the multiple freeze and thaw cycles.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, November 15, 2021 8:41 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: always reset the asic in suspend</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">I was just about to write up my concern as well.<b=
r>
<br>
IIRC we used to have that and it didn't really worked that well and we <br>
switched to resetting the GPU on driver load instead if initializing it <br=
>
doesn't work of hand.<br>
<br>
Christian.<br>
<br>
Am 12.11.21 um 17:19 schrieb Alex Deucher:<br>
&gt; Actually, ignore this for now.&nbsp; This will likely cause problems w=
ith S0ix.<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; On Fri, Nov 12, 2021 at 11:18 AM Alex Deucher &lt;alexander.deucher@am=
d.com&gt; wrote:<br>
&gt;&gt; If the platform suspend happens to fail and the power rail<br>
&gt;&gt; is not turned off, the GPU will be in an unknown state on<br>
&gt;&gt; resume, so reset the asic so that it will be in a known<br>
&gt;&gt; good state on resume even if the platform suspend failed.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--<br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; index 1db76429a673..42af3d88e0ba 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; @@ -2165,8 +2165,9 @@ static int amdgpu_pmops_suspend(struct devic=
e *dev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_=
s3 =3D true;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu=
_device_suspend(drm_dev, true);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_=
s3 =3D false;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_asic_reset(ade=
v);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; static int amdgpu_pmops_resume(struct device *dev)<br>
&gt;&gt; --<br>
&gt;&gt; 2.31.1<br>
&gt;&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514427984F4757CEBAF182D9F7989BL1PR12MB5144namp_--
