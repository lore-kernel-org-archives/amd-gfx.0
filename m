Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8095EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 10:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1E42313B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 10:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1E42313B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894B589AEE;
	Thu,  7 Jan 2021 10:38:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CE789AEE
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 10:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUJ2K2kHBEdF5sqSUbcStSycsGehMo4vUS4qk8rIdZSBv7Bz2o925LORbcK0qhAWUwxHESd7Jsa2KTeaPIhgRMgjcNiPyhMpOWptgXIQOyj+qPoomlHC3N947Sw0doazsObQjP/fUZ1oioy28mb/g123qexcJI2/bwD8h1biQPVadfOf6r9CZE+JGLwLDogbQUYe1qIzbfqrIXJvzWWSRzPpuSi4QCtsD7NgdzLi9q+YFlAEDfQpR49jDKwuyDd4BRvnj3cGZRkSLySsocmW7C4uORjt1TJOBZBbz4n0sOhAgmP8uRR6r1cZlS0IpE4ylSCyHpfP8FzGYBQO165hUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7+SIIPkyyX9EGfa9RblNnS06YL/GLJQ1fEfLZwfvGQ=;
 b=mJ+OuU3/KlaGRXryjkf64vgvBxGlelmCdeufasj+DKLo1+gZrAr+fe4lv2kaAPHXygl+Qs7WOsTZ9+doJJYK4Ns+BbHneyigWGhTDfOohRpiEsDQErN9q8k/09+E1iPqBJN1vZ0l2CVlsvQytGFjQB5LeGohPqhnZb2982RrWvBsBH2WykpYZuXVYqa4en0KPw9UQoz0V4TtmdQ1fOyRk1Mgi+oEOl1o210afpyjT4KYdEWPf4iFEBlGFWcF+NE0+qynFNpYkJidPWT0VlLDeDjfOB0OC1/5MM60tFlSS6pj255IytqQiHPjBWCoZvGFNOUCJIoIzGyyD1gi6mc4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7+SIIPkyyX9EGfa9RblNnS06YL/GLJQ1fEfLZwfvGQ=;
 b=ZXS+8vEHuMp0gOqswvTuJaTv1DM/LeCgnFELd3qU2JGYX+cE9zpss46YDRh9hF61AnCesTHNb+Fr3mbTjGIh7fRnGgDIKrKfsasqd3FPBsciwSlXE18U7V8l1IZ0k8bPdUka1VBB87iwixhRIpBLwzE8XnPLaf9+zONjttJHCBI=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 10:38:02 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 10:38:02 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Thread-Topic: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Thread-Index: AQHW4z4GwhrQynjb806wl7ptVhaxTaoZSHuAgAEhW+CAAE/ogIAAoSLggACAnICAAB+R0A==
Date: Thu, 7 Jan 2021 10:38:02 +0000
Message-ID: <BY5PR12MB411598E0ED97B84486D66EEB8FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
 <20210105083717.468585-3-Emily.Deng@amd.com>
 <CADnq5_MdF6WUTyOWs1NEO_gZtQknwTsGECs-uXVsfLPU8HOhGw@mail.gmail.com>
 <BY5PR12MB411509E4392319DED71623C28FD00@BY5PR12MB4115.namprd12.prod.outlook.com>
 <43274fba-2ba2-76fc-3f9f-b9af7658af89@daenzer.net>
 <BY5PR12MB4115AF59B6C76E2A731D9AA38FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
 <50fd49e8-e1dc-ceaf-8bf5-f50ae65a3339@daenzer.net>
In-Reply-To: <50fd49e8-e1dc-ceaf-8bf5-f50ae65a3339@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b94b35d9-b2f0-4899-9d99-145aca6dd223;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-07T10:35:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 456ca4b8-6b6a-4ced-2e20-08d8b2f84f64
x-ms-traffictypediagnostic: BY5PR12MB3876:
x-microsoft-antispam-prvs: <BY5PR12MB3876CB6DC622EC43C10358E78FAF0@BY5PR12MB3876.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9nPNj/IhyPEMQTAYfADDitts2VBRCekBtOMaoE0uXsVUEpgu3PV/gg++skr3SEAwbBwuX8dFn/8KAZOg00MBANbkgxV35sKExBrKeJ+zNuNyaoAUTq7aTy8HJR3V+1kx6GDlxpsxqItCLJq5QzhIMCQYuPK4lyf63iA/BVuS1eIQRfhhicvgE4lar+M5zyoG3GUNhigTaCyZXmowYwL69GqUqWbcuxvSNvHPcJtOygJZH0qyRNx2YHFcxu6enr5KdiNdw4noX2Kb5WEcMK7gvu5mVyntpDUWwvLTsc1aIOxDkz1i8JXWSjr7eXKzLH/IReHFOUfU59QIsz2nqWv1tMbwP191U0+KoYAxO3ORs/TiHXwHaFUul26/VOjYHjTjOoyh2VJrmQDi5+LxiiXkNMYrT7B+oH1mXP/XQhStuAE6E9IM5vcl5wykylIz1z9jDcgi3UPfdzcntKcScLgMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(45080400002)(66946007)(110136005)(316002)(53546011)(6506007)(66446008)(66556008)(478600001)(64756008)(8676002)(33656002)(66476007)(8936002)(66574015)(83380400001)(5660300002)(76116006)(4326008)(52536014)(71200400001)(55016002)(186003)(2906002)(7696005)(9686003)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ZPbknkviFVhGKw6elJAmorR03rO7Cm4j/zeDpL31kdJJrA6PsLuB4OJAZc?=
 =?iso-8859-1?Q?8yk7PbuVhTWXZ8gyTKZvnz036OlcTenCMc6mVPQ7yt5EEuX8XOtlru8UUq?=
 =?iso-8859-1?Q?FQ9gC9fIlttTz4hLgZdzatVXrPMYcm3Kfx+o12wUXwF9oK2wz+nYHiC7WN?=
 =?iso-8859-1?Q?qm7ataIf4676cJ/wEGGQxULRBEX4M/O8xsHQ/PEwNTcpNciwmaDsIjlBMy?=
 =?iso-8859-1?Q?ZUVGIiR6DU9rr8/ZHGIb+p8CbnYE1vtjMRoY6bxUkSOgB3wlDbCJ41GkcY?=
 =?iso-8859-1?Q?J3ufQNbIyh9retWf3+PUaG7jA+eWrZRjOfd3+2vqvTtLplwyqMK+vgwt5y?=
 =?iso-8859-1?Q?eakZk8EVZfAJHaA//ZpNc9BYGKVpsMF8Udp+emibVevLhjKfAaUwkYZU3G?=
 =?iso-8859-1?Q?ClvN52InVEYEDonUqh3+5hJeV3AxeCSSCUPCgF5sQFW3bDuH0sNRB/5pwz?=
 =?iso-8859-1?Q?rjGDdxXTVdueaIgKwAhq12JApyzeSNFFDj2qAninAjB+ui4XVw4YJbn2bW?=
 =?iso-8859-1?Q?cT/Zveyn+eDNJEtOT31Lrs9MTcf0kZE5PvHfJuHLMcAqcI27x5DdStYyOO?=
 =?iso-8859-1?Q?NibPduhip8TTSRUaXd4BlYdac0jxXri4GH9OKw2BGz/UkAH4O1qbJPRQiJ?=
 =?iso-8859-1?Q?wuUeM4gWVAOMUNqfFV9keHL6hVUEIaOt23y4v0dVxl1Yp7VmGr6ZeP+Qht?=
 =?iso-8859-1?Q?VX8bmsVzg7vHzxPTp7qM5n1ocJE7j3emQLdk+17L+G8KqxaXHASkII15NA?=
 =?iso-8859-1?Q?Gc+DvKEK6k18Bk46kYVtprYWAnHEA0PKfKpWlREZhxFe79esHOmXnc6pLf?=
 =?iso-8859-1?Q?QvpnuDMen+PXv59wy4PgWmPwKQTdzeNrMDrwmXtxXKpj+DKTOc3OHpmczT?=
 =?iso-8859-1?Q?osBt6txQZUT/Grh/ZOyh+Fl0xvTX3ReoGv4rkKC8nbicJT5ezlcMsHoqon?=
 =?iso-8859-1?Q?xLkZhZmRmKLx7iX/RyrI/v0P4vnGoxLv8LcVMSp7bviLOqdI//4gFnu8xL?=
 =?iso-8859-1?Q?2RKq+bOa2mp05g8is=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456ca4b8-6b6a-4ced-2e20-08d8b2f84f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 10:38:02.4951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqIxK4RPJ43Ck24XAuRBEk7RzRd+9KP/cmGN7jvhpwDiJx2ipvNsTV7TRQCyaATA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3876
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

>-----Original Message-----
>From: Michel D=E4nzer <michel@daenzer.net>
>Sent: Thursday, January 7, 2021 4:42 PM
>To: Deng, Emily <Emily.Deng@amd.com>; Alex Deucher
><alexdeucher@gmail.com>
>Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>Subject: Re: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_displ=
ay
>
>On 2021-01-07 3:28 a.m., Deng, Emily wrote:
>>> From: Michel D=E4nzer <michel@daenzer.net> On 2021-01-06 11:40 a.m.,
>>> Deng, Emily wrote:
>>>>> From: Alex Deucher <alexdeucher@gmail.com> On Tue, Jan 5, 2021 at
>>>>> 3:37 AM Emily.Deng <Emily.Deng@amd.com> wrote:
>>>>>>
>>>>>> Limit the resolution not bigger than 16384, which means
>>>>>> dev->mode_info.num_crtc * common_modes[i].w not bigger than
>16384.
>>>>>>
>>>>>> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
>>>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>>>>> index 2b16c8faca34..c23d37b02fd7 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>>>>> @@ -319,6 +319,7 @@ dce_virtual_encoder(struct drm_connector
>>>>>> *connector)  static int dce_virtual_get_modes(struct drm_connector
>>>>>> *connector)  {
>>>>>>           struct drm_device *dev =3D connector->dev;
>>>>>> +       struct amdgpu_device *adev =3D dev->dev_private;
>>>>>>           struct drm_display_mode *mode =3D NULL;
>>>>>>           unsigned i;
>>>>>>           static const struct mode_size { @@ -350,8 +351,10 @@
>>>>>> static int dce_virtual_get_modes(struct drm_connector *connector)
>>>>>>           };
>>>>>>
>>>>>>           for (i =3D 0; i < ARRAY_SIZE(common_modes); i++) {
>>>>>> -               mode =3D drm_cvt_mode(dev, common_modes[i].w,
>>>>> common_modes[i].h, 60, false, false, false);
>>>>>> -               drm_mode_probed_add(connector, mode);
>>>>>> +               if (adev->mode_info.num_crtc <=3D 4 ||
>>>>>> + common_modes[i].w <=3D 2560) {
>>>>>
>>>>> You are also limiting the number of crtcs here.  Intended?  Won't
>>>>> this break 5 or 6 crtc configs?
>>>>>
>>>>> Alex
>>>> Yes, it is intended,  for num_crtc bigger then 4, don't support
>>>> resolution
>>> bigger then 2560, because of the max supported width is 16384 for xcb
>>> protocol.
>>>
>>> There's no such limitation with Wayland. I'd recommend against
>>> artificially imposing limits from X11 to the kernel.
>>>
>>>
>>> (As a side note, the X11 protocol limit should actually be 32768; the
>>> 16384 limit exposed in the RANDR extension comes from the kernel
>>> driver, specifically drmModeGetResources's max_width/height)
>> It is our test and debug result, that the follow variable only have 16bi=
t. Will
>limit the resolution to 16384.
>> glamor_pixmap_from_fd(ScreenPtr screen,
>>                        int fd,
>>                        CARD16 width,
>>                        CARD16 height,
>>                        CARD16 stride, CARD8 depth, CARD8 bpp)
>
>I assume you're referring to the stride parameter, which is in bytes.
>
>This function is only used for pixmaps created from a dma-buf via DRI3.
>It does not limit the size of other pixmaps, so it does not limit the size=
 of the
>screen pixmap (which corresponds to the framebuffer size in the RANDR
>extension) in general.
>
>Also, this is an implementation detail, the limitation could be lifted by
>changing the type of the parameter (though that would be an ABI break for
>Xorg).
>
>Xwayland isn't affected by this:
>
>Screen 0: minimum 16 x 16, current 1920 x 1200, maximum 32767 x 32767
Yes, openGL driver will refer to the stride. As we have tried resolution bi=
gger than 16384, the screen won't display well.
And seem no body has verified this. So we want to limit the max supported m=
odes to not bigger than 16384.
>
>
>--
>Earthling Michel D=E4nzer               |
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredha
>t.com%2F&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7C6279eb2390
>0b436337b408d8b2e82635%7C3dd8961fe4884e608e11a82d994e183d%7C0%
>7C0%7C637456057455424961%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
>mp;sdata=3Du%2FuKB%2ByxJMzCr3nfU8rkFyjjI37gc%2BZ2rmHP9riZB5w%3D&a
>mp;reserved=3D0
>Libre software enthusiast             |             Mesa and X developer
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
