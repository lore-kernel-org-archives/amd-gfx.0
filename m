Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB0BC4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FF710E3CE;
	Wed,  7 Dec 2022 15:27:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A6A10E3CE;
 Wed,  7 Dec 2022 15:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dka7/DfQCSSDcSifiztUnUByNzo64lp2QtwSxqCr4jL4FkZ4EtNOiI+egGxeTNbUwkAdchU+RCP2qRFRjowE+mjDKd+c41N27u8vDltAh0T/yxkBs4qmXrtSyLGZZOl4NGE4S3aFWTDqEsauyX1H2WacTBKg/hRg/kysGeTYZVRtvP7vHzvomrfSehEkG9CSISQdfpAQ0IQnJWFZ15/MoOkbN1GOJYHTTi1i1LVtTsVCm+mLM1ucov/KTKkzFb44VggTKFES1Wagl/4xco59679ywqF30Iz5MzQWyrPscYypM8dxobwbr5qfJ0y3XBmh8rwd/13LoqW04A593YZIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e45KkmF4lLxyYfpvY3u6QOpLagfBLW1/m65VXDcdqU=;
 b=MJSQ6xbWvAZh4JHEHGfEyHfB5SxQV+DdyWjyhqwnlg5B0v4jZhgNHLvoQ8c8b4wA71eJKwdBZUITkDThdFaVxABHLF2F7pHiiwb/tsJr3tpFwIZJx7HcMtspS1CYsQXsVvwayq1ibvw11tQtNTpt64KIZxZ59XWtgeo8C8ZvnnhTl2U6GbujHo0vEm/bkgVZf4KycMpwZNKzhpwXaXVzGZ9KYuZNSeQklqDAV58IhYfkAtxYg/UnRKQ7m/nehj7evpBRWUPbrhc+iktQDtZfJUQZef48Wv+5quVDPrUvKDpqLLiie1laiirZkb9higoMa1yjEu3Yxe0xNTxwfahOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e45KkmF4lLxyYfpvY3u6QOpLagfBLW1/m65VXDcdqU=;
 b=EFtE4JVKUtx8RpQikDkbFbEnHbAn66buhnOQ6Elv+YFmAxHlQzos/mH61UiiYB3n+O6mo4WnlAQkz4QLSVptuuH3hG2fQQNtAp89ZdXt4Oohk3kSg5xIWb2yOQy3osDrPNvKfUtJjD/isI2Px2Old0st6wsB7eSW/VPglajY3Bg=
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:27:09 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6755:9455:2407:ea3e]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6755:9455:2407:ea3e%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:27:09 +0000
From: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Thread-Topic: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer
 failed
Thread-Index: AdkKDSDFxSlpkC5gTnSZE4zebcKC0wAQPv2AAABvKoAAABYrZQ==
Date: Wed, 7 Dec 2022 15:27:08 +0000
Message-ID: <MN2PR12MB4342001578A8813259A620D3E41A9@MN2PR12MB4342.namprd12.prod.outlook.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
In-Reply-To: <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-07T15:25:53.6593316Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4342:EE_|PH7PR12MB7793:EE_
x-ms-office365-filtering-correlation-id: e6ad6c47-c705-4843-79e5-08dad8678153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52jSvrrDinLJ6SuktYTIlsDj+W3LHfTVFx+eTMd8NAUpxuzXWtGmfoTOILOGmS46c53kawKhwxsctcXYNdO7uXFD6V3txrekmv0XCds1o/ftapiO+cVxjotANpOLR83MUtCGibLG4QMhuOUWZ6cTovujSaYrqMp650DGI6lpnY3+z3cRYzlLEL8gsNIjbqOBAVtHmCsq6piZlNbf70zf6qRu4KrcG1MNc/NgO9oWQ8bp7DlbpDG12qsI1zaNyMv3e+p8Q1U6HwnUcWq0nBvMeGJneZpKSKK2n/Xy9wCIapZFJvqdHJqrcOP6B5OdRgSwdl+0y367dTczvZEs6zooP+9W9KYxK7kNr8v8To03pl/AJ1we56QWP4Nvm7xjr0AGmG9w4+dwpenTjbt/szfZ0FCs4z51wftBF5ozbTN1qwh+Nd4MtI9aCKyDgHcDWTr7q1/GP0mSznac9RVwEqBfTBfhpW2eKIDDukESFdQg3TZ/NtYiqXlyBmGI8Km3yscJTU4OaO7mZEnDxP01DfO5EwEPXjKHL1g/1TgY20Ts586MnYHgc5+HEEYEnHxjLlutRdpPJgBak1AYoN/TsXMrCPw4QB/nNOx+wdkSAhCT3/i62qzmk0ADlZFm+fOK3YllAaocETg/zXi0kbHQaQleiiOGtufGp+WAzX7eJt6tQN6T3zvAaQkfT8Tw72yNgexqbFoyFHgX0ib8P36/6tzcy5JON2uSdsc6ooiOMsAwVD2WQVOdcLlkSrKMgcDx7HWw6Pj4CoP7zF/eZ1MQ7VEx1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(83380400001)(122000001)(71200400001)(33656002)(86362001)(166002)(66574015)(2906002)(5660300002)(8936002)(41300700001)(4326008)(38070700005)(66946007)(52536014)(76116006)(8676002)(9686003)(55016003)(7696005)(26005)(186003)(64756008)(6506007)(53546011)(55236004)(91956017)(54906003)(110136005)(6636002)(45080400002)(66476007)(316002)(66446008)(478600001)(66556008)(38100700002)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A51L74/MsBnyPJuQBXSC2/c2BF2ZCPYJ91tKtg1fK6zKv9dZ655F5viCB0?=
 =?iso-8859-1?Q?UZjeC0EnrafIQ7nzYrCa5N0BhOcHa2uPkvhP0QaCLt+LxrCtj38gV3nvw4?=
 =?iso-8859-1?Q?32CWycxU2MaplvUugLvawI/zUzxxJ1o22mZKBoh/6INq+f+IZ7wOs4nZWn?=
 =?iso-8859-1?Q?aG9/BWP3zyP49g2ZKPtyrpr082wutbhaUPXkQEFWkjj73ph1s/mUPJ/Nh/?=
 =?iso-8859-1?Q?/FW2M0omngmfPSJNfbbDZ1DxkVnjXugdLlyqPVfDfLfvtBsxmClHHVTvdj?=
 =?iso-8859-1?Q?kwX4pyKiDl/JY8n2JMHM5mDGLlrr2xhlb33yjFTs+XdoF3z/U4fgKjb9vf?=
 =?iso-8859-1?Q?ciL988LynJaxVEmN5q+vEvnZJW0kpEFtdpyznHVqeEPBIYX5xFRRQT4Xqy?=
 =?iso-8859-1?Q?a+IejqQ/KeZf4MtwWR77Y4KX1SIE7YOjGmetI8Z4t0ddOXj3zf99aK/nSR?=
 =?iso-8859-1?Q?T3qLtoL0fvfwfQPtHZotvGS+AFzHgcaeo7lF+KQ2WE8TdbX+5rLlPC7GnI?=
 =?iso-8859-1?Q?ynCGr4yOSlTH8IO5ttZ+H9YiyNUpzoqU5hG3IIvaFPsgZNGAJopUosqjp9?=
 =?iso-8859-1?Q?+LuvtQjvvWglCz7GWevpeeRYjkqRlV4GoCOi127oNxQktbEXMtUOi/NJHS?=
 =?iso-8859-1?Q?ZmgxL4LvUi2cBxHm82mgZ0VWwe91dqxs/va3LP32MTjpvxrg9JpQV398pr?=
 =?iso-8859-1?Q?RBc94+OH7MsZsbCo8S2NDzPbYv1VEQpvuVq+BRddnbBVnGAQaRD30qGLUH?=
 =?iso-8859-1?Q?H/aP1J2CnBICgyzAxzgo5nLrc/cjWgu7Xmrzr1hHCgnha53cK/q9BB94oU?=
 =?iso-8859-1?Q?Z50TdTSlondA1u96Y4kLHNvbjH87MMPlNc3HrugFjFSAog+hpH4mA8P8U7?=
 =?iso-8859-1?Q?g6J0Eaj+WFiV23o+ZghljAUA02xYA9l1rVkBZo1lyKjLPggK4kESaPK8fi?=
 =?iso-8859-1?Q?pCKK8VYRJ+h8iM0uV/l98be/TtXWlOj8t4/d1c/ezgXi67naMHxo+RgZfq?=
 =?iso-8859-1?Q?EvAoj+kypwzfbfE/O4mN/8QY5EwptpvqhGzQdu1qWiXVfcEyYXtRQy4aU4?=
 =?iso-8859-1?Q?I4TUPFG/rwkyXoWozMXo1qjOZv5n3uUCtcTEF9XFYcoPUnZ5GFjkVCSPI5?=
 =?iso-8859-1?Q?DHtKdqZcHt6OZFmwa9OKIRA1cDexfqPeZ2fKv6fIYePbSC5yugvtwDtYCn?=
 =?iso-8859-1?Q?m253F52i1I0RAjU0ky0idFyxNGYx+9PnSKBWuy2Nl0FH0lUrv6eqHZqrvy?=
 =?iso-8859-1?Q?elvl8jI7fIiznxd/yuYbuLsl3g60aAWhactnZi2URgRSWr21MbS1TkJF/S?=
 =?iso-8859-1?Q?LSCJGXHhIR2odQC8/LHS0i6lZPTLLbK8t0/vcI6eOs2dDQqmho7Gd8dKNs?=
 =?iso-8859-1?Q?ZazITiEei3DOoGrNkuuWMEl8cwEwwT6mMJeDHraqVByUjxwKn8MHNNyBkb?=
 =?iso-8859-1?Q?uUyrNtwsh6oDrF1w7o875MyAcRuQHzGfJZznXPOwUPCqWkeuqIxezFbzqY?=
 =?iso-8859-1?Q?NLhb2iDu3VH8C7nrthG4BFq8SqHpRPf/7wbd12SFs+y1z8DsC4IWkvBlHp?=
 =?iso-8859-1?Q?12kJoFWow9ySlf7lUY2nxin6oHIyRnrv/n11EMHDNVMoMEtRIZO+U/OBNV?=
 =?iso-8859-1?Q?mLS4WfKW2rimJ85EKPz7y2y35w/yHs3QZK?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB4342001578A8813259A620D3E41A9MN2PR12MB4342namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ad6c47-c705-4843-79e5-08dad8678153
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 15:27:08.8996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FsxW3gP+8B3KEgCIktbdKCCBZC8CkRWMSXnuKKwWBwAXxLTRdV5jmCF995jqoO/A2lah+VV3EYs7RXS+/MxFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
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
 Yifan" <Yifan1.Zhang@amd.com>, amd-gfx <amd-gfx-bounces@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MN2PR12MB4342001578A8813259A620D3E41A9MN2PR12MB4342namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Jesse informed me that this patch solves the issue, he tested all the cases=
.

Thanks,
Arun

Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, December 7, 2022 8:53:25 PM
To: Alex Deucher <alexdeucher@gmail.com>; Zhang, Jesse(Jie) <Jesse.Zhang@am=
d.com>
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx <amd-gfx-bounces@lists.fre=
edesktop.org>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>;=
 amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@am=
d.com>
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer fa=
iled

I would go a step further and just allow GTT domain on ASICs !=3D CARRIZO
| STONEY.

I can't see a good reason we should still have any limitation here, VRAM
doesn't have any advantage any more as far as I know.

Christian.

Am 07.12.22 um 16:10 schrieb Alex Deucher:
> Does this patch fix the problem?
>
> Alex
>
> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> wr=
ote:
>> [AMD Official Use Only - General]
>>
>>
>>      drm/amdgpu: try allowed domain when pin framebuffer failed.
>>
>>
>>
>>      [WHY&HOW]
>>
>>
>>
>>      in some scenarios, the allocate memory often failed. such as do hot=
 plug or play games.
>>
>>      so we can try allowed domain, if the preferred domain cannot alloca=
te memory.
>>
>>
>>
>>      Signed-off-by: jie1zhan jesse.zhang@amd.com
>>
>>      Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
>>
>>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_object.c
>>
>> index 1ae0c8723348..05fcaf7f9d92 100644
>>
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>
>> @@ -39,6 +39,7 @@
>>
>> #include "amdgpu.h"
>>
>> #include "amdgpu_trace.h"
>>
>> #include "amdgpu_amdkfd.h"
>>
>> +#include "amdgpu_display.h"
>>
>>
>>
>> /**
>>
>>    * DOC: amdgpu_object
>>
>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, =
u32 domain,
>>
>>                          bo->placements[i].lpfn =3D lpfn;
>>
>>          }
>>
>>
>>
>> +       retry:
>>
>>          r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>
>>          if (unlikely(r)) {
>>
>> +               //try allowed domain when pin failed. just a workaround.
>>
>> +               if (unlikely(r =3D=3D -ENOMEM) && domain !=3D bo->allowe=
d_domains) {
>>
>> +                       amdgpu_bo_placement_from_domain(bo, bo->allowed_=
domains);
>>
>> +                       goto retry;
>>
>> +               }
>>
>>                  dev_err(adev->dev, "%p pin failed\n", bo);
>>
>>                  goto error;
>>
>>          }


--_000_MN2PR12MB4342001578A8813259A620D3E41A9MN2PR12MB4342namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Jesse informed me that this patch solves the issue, he tested all the cases=
.<span></span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Thanks,</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Arun</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Get <a href=3D"https://aka.ms/AAb9ysg">Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, December 7, 2022 8:53:25 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Zhang, Jesse(Jie) &l=
t;Jesse.Zhang@amd.com&gt;<br>
<b>Cc:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt;; Paneer Selvam, Arunpravin &lt;Arunpravin.=
PaneerSelvam@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.f=
reedesktop.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: try allowed domain when pin framebu=
ffer failed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I would go a step further and just allow GTT domai=
n on ASICs !=3D CARRIZO
<br>
| STONEY.<br>
<br>
I can't see a good reason we should still have any limitation here, VRAM <b=
r>
doesn't have any advantage any more as far as I know.<br>
<br>
Christian.<br>
<br>
Am 07.12.22 um 16:10 schrieb Alex Deucher:<br>
&gt; Does this patch fix the problem?<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.c=
om&gt; wrote:<br>
&gt;&gt; [AMD Official Use Only - General]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm/amdgpu: try allowed domain when =
pin framebuffer failed.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [WHY&amp;HOW]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in some scenarios, the allocate memo=
ry often failed. such as do hot plug or play games.<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; so we can try allowed domain, if the=
 preferred domain cannot allocate memory.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: jie1zhan jesse.zhang@=
amd.com<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Change-Id: I4b62e2ff072d02c515f90100=
0a5789339d481273<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt;&gt;<br>
&gt;&gt; index 1ae0c8723348..05fcaf7f9d92 100644<br>
&gt;&gt;<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt;&gt;<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt;&gt;<br>
&gt;&gt; @@ -39,6 +39,7 @@<br>
&gt;&gt;<br>
&gt;&gt; #include &quot;amdgpu.h&quot;<br>
&gt;&gt;<br>
&gt;&gt; #include &quot;amdgpu_trace.h&quot;<br>
&gt;&gt;<br>
&gt;&gt; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt;&gt;<br>
&gt;&gt; +#include &quot;amdgpu_display.h&quot;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; /**<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * DOC: amdgpu_object<br>
&gt;&gt;<br>
&gt;&gt; @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo=
 *bo, u32 domain,<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bo-&gt;placements[i].lpfn =3D lpfn;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retry:<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo=
_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely=
(r)) {<br>
&gt;&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; //try allowed domain when pin failed. just a workaround=
.<br>
&gt;&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r =3D=3D -ENOMEM) &amp;&amp; domain !=3D b=
o-&gt;allowed_domains) {<br>
&gt;&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_placement_from_domain(bo, bo-&gt;allowed_domains);<br>
&gt;&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto re=
try;<br>
&gt;&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;%p pin fail=
ed\n&quot;, bo);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4342001578A8813259A620D3E41A9MN2PR12MB4342namp_--
