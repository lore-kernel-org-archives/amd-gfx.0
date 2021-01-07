Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A27C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC72230FE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC72230FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B456489D4F;
	Thu,  7 Jan 2021 02:28:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D53A89D4F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 02:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1TbabTcbRLazxrqPbnRRkcaWB4+QF4zY7NSxt2U8ijm+vpEwhjEur4xL2IQo0E9Ii0UnOCTD8bYlPdGlbcJYjdsEgGUbr7b+IFGeI3aP6+6oYPagZPlfUFXZ7y/GzGlr2KYlLZxTIL81LPBtz+BW0uByvi9vLMYvUAv62qrPNFFO9n7nHcNWzFz2Kw53uMshcZJGntNYZ6WdVbcBo03AdQ0O9D2yvww9IpyqDxIiVLf89GkAFFf1oJyz4bK4PBwBgvym0MP07zgjrC+XClZ4KROlr4fgDjVPI7fCgBK7wBEPGTDypnChmOeKAF7B1PLFaUc0TwL2G1VKXMLAh0bBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyIBSdUIIMk79rA9hUDPHOwAE9wqBX0yr3J6q4nqKjo=;
 b=Biv/sO0382Xab4EV9M42ZIy24eVfg6w3RnOEOn6Yv8LRS8fGOVaEkb7thTzOCjWKzkyyYA7iwjRwIBaxIMFZwHc1GqaD4kthaxxetFggCRJsGft9BlILhLSxOUHrRPk64fu61eTxaeVmiF6jj7rUJQTAn6JF49ciFX9/SPG2sPUPObkmPTN9NQ2z/8ID3Iq4S+C2KDWgb6yPES/yvIM0J2eWEgmU1nwkhZR8Yx0UqFP0P6MUweIRQpV4InR/nWS2a96hEioR+Dt3BMY49mjW/QZcWA+p7i+HiB5iCE+iQNIm/RqD7sE3uq3ouD720byQjAkdlkdfydfr5eV3Hs0KBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyIBSdUIIMk79rA9hUDPHOwAE9wqBX0yr3J6q4nqKjo=;
 b=Gt91F+0qEy8es8wgr6HK4g+9acH6ZFNiwiZfq36LwawuwpWizBxbtrULMMedvV0B8YcU+GqNg5luMo7fHFZAYLNaRFQqgOOYNFmHFvVNqXlNvJZbFHRn8mbkFNEnV0hnMbCrZcAlMij8GjPypSOzTiCBOs0uTUwRfkqLTQpQjbM=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 02:28:26 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 02:28:26 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Thread-Topic: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Thread-Index: AQHW4z4GwhrQynjb806wl7ptVhaxTaoZSHuAgAEhW+CAAE/ogIAAoSLg
Date: Thu, 7 Jan 2021 02:28:26 +0000
Message-ID: <BY5PR12MB4115AF59B6C76E2A731D9AA38FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
 <20210105083717.468585-3-Emily.Deng@amd.com>
 <CADnq5_MdF6WUTyOWs1NEO_gZtQknwTsGECs-uXVsfLPU8HOhGw@mail.gmail.com>
 <BY5PR12MB411509E4392319DED71623C28FD00@BY5PR12MB4115.namprd12.prod.outlook.com>
 <43274fba-2ba2-76fc-3f9f-b9af7658af89@daenzer.net>
In-Reply-To: <43274fba-2ba2-76fc-3f9f-b9af7658af89@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=24e48a32-360b-4af6-af86-238aaa768da1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-07T01:01:50Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76d403df-c73c-4347-7ca9-08d8b2b3e9e5
x-ms-traffictypediagnostic: BYAPR12MB2966:
x-microsoft-antispam-prvs: <BYAPR12MB2966E4092DE888E266F6F40D8FAF0@BYAPR12MB2966.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jA8NCEpBQzkVHjnI+W6liZfn+I5RjvNSYiR9Se6LZgMwkdzwxd3mOFEeHhX1NAAJ+HgICfDT1/C/0zG513p6e8kiHab18rebnlGwmiC1Ge2XnE3aWGvDpHH67WzmJWZbEOlP/tiGW0HX1TmfV0US34gUn1baGbMd62b8F0m4x4axiCIhSaEltYhN3RarkRhC2xM4bRQ4fpVogUA37yd8fB8asrkMqwU0b0RanwWGq/7sVr0BKKiyHEUv7EBtMfp14VD0H2/6GMZVOzn3toRoGNyb3nWT8yE0y2j5LR8B46PcdtDd0rcpYC9s67i5RaOFbwY0TNkWgD18FqXg0XtpehOuCwOkDTRIeeY6HFKs/TnmCp2IzsmBIYopnYx4LJTaqn5VIZzl7ufIE5Xl5ESmBxq/0NNJTNGHayX8enOsbQCIkuZi/NYW/Yjx/HsOejTBYyou27BmA22o/urJbgP5dA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(110136005)(4326008)(52536014)(8676002)(9686003)(316002)(83380400001)(6506007)(5660300002)(8936002)(2906002)(71200400001)(55016002)(66574015)(66446008)(64756008)(66476007)(66556008)(76116006)(33656002)(86362001)(66946007)(45080400002)(7696005)(478600001)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?00zWmsftbN7gfBVK37K7q2mQUFskkHa30S10X/zxew8LIDL1ZHNq2DGzoz?=
 =?iso-8859-1?Q?YFrvWO8XZDdy5dyAEzzDZFFhASRYn5+UaB5wYsZn4404yv8ln3z+SNBnqK?=
 =?iso-8859-1?Q?e+sosHIjrvNKH/CdfDsTh97dbpkRGxEDQpRaVwQJILmGV/MbQ9K1qO8MD+?=
 =?iso-8859-1?Q?yyqr1Jk3n1reAbM57tsOhWpYpU3kGgzl53pW/ayRVLyl5xiMskTOZdb9I2?=
 =?iso-8859-1?Q?6+t+QXjNdz6IbzxFUp44AWmwKENMF2pxKqgs4aMRbSOl4wO0KaTbPgE0PV?=
 =?iso-8859-1?Q?mE5Bcx/x3+ofJ2Cjg/fJcF2O8Thq5NaeaJ+HUCja08Ky8UN9dxs/xKarrL?=
 =?iso-8859-1?Q?RMQivirVEnD+xP5Mx8uGIu+1tGAgiknhMUFPhI4tTPLxAJbH274WafkZjv?=
 =?iso-8859-1?Q?rDLO302XPArwFw4b88uznwYtlPXmThOKVPeiXB/ZOgpOaRKbW8Ab4+VPl0?=
 =?iso-8859-1?Q?R2AMwk42Y8BailQmc4nxKJLsPJyLqvZzGiWTSRxPsiUktsth1JorTjFU5I?=
 =?iso-8859-1?Q?XUj9XZFa+1tHh4tStOkLKRcwtFyK6XqIDXdKOXkmtzmLh3Uk66ISOFR3Lz?=
 =?iso-8859-1?Q?h/tCuMb0Vzeeq+Hfu4c2y4ZHd4UAK9oMSUrY3HpyxOXJMcybPlfwj+bHzE?=
 =?iso-8859-1?Q?71Dn7kRorIyBUezkrcb/9ZsbY0C0e0VHVefOS0dxrrMauKpfnXrrFJa0a4?=
 =?iso-8859-1?Q?AN/+b7DPwERCGv+Xe1DkWt9RDnKRZGh0GIF4hquq6BVTPRtxHI9pv7sQbD?=
 =?iso-8859-1?Q?9M0iH1VvL/Ory7/JanTVOKI94COpbk1tZ0mwINJ46hr+Xml6UVyTlsObrm?=
 =?iso-8859-1?Q?7Y4xobJN0keetWRL2NEbnK218iXB4apBrJaMX+dzom8fvFCg/SW5HCloPD?=
 =?iso-8859-1?Q?LP/h9O0tTtJiIm80uslHh2hmTO/fiLgEHNjuUct0zyrF1b4Q2kLOB/zOnT?=
 =?iso-8859-1?Q?A5aqBsnxJ4I8d9a+iNjxGCcwoVBH5VxPpWRYGwHLCEjtCh2l/5XtKfWaSY?=
 =?iso-8859-1?Q?dndFaTMshvTh3PSeo=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d403df-c73c-4347-7ca9-08d8b2b3e9e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 02:28:26.4333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0GqR/2CExm4zVhgOQXrTr+OO6s8XZVLG+u0WftvU0Ag3BIfFtRynYAmWCXdFS50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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
>Sent: Wednesday, January 6, 2021 11:25 PM
>To: Deng, Emily <Emily.Deng@amd.com>; Alex Deucher
><alexdeucher@gmail.com>
>Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>Subject: Re: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_displ=
ay
>
>On 2021-01-06 11:40 a.m., Deng, Emily wrote:
>>> From: Alex Deucher <alexdeucher@gmail.com> On Tue, Jan 5, 2021 at
>>> 3:37 AM Emily.Deng <Emily.Deng@amd.com> wrote:
>>>>
>>>> Limit the resolution not bigger than 16384, which means
>>>> dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.
>>>>
>>>> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
>>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>>> b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>>> index 2b16c8faca34..c23d37b02fd7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>>>> @@ -319,6 +319,7 @@ dce_virtual_encoder(struct drm_connector
>>>> *connector)  static int dce_virtual_get_modes(struct drm_connector
>>>> *connector)  {
>>>>          struct drm_device *dev =3D connector->dev;
>>>> +       struct amdgpu_device *adev =3D dev->dev_private;
>>>>          struct drm_display_mode *mode =3D NULL;
>>>>          unsigned i;
>>>>          static const struct mode_size { @@ -350,8 +351,10 @@ static
>>>> int dce_virtual_get_modes(struct drm_connector *connector)
>>>>          };
>>>>
>>>>          for (i =3D 0; i < ARRAY_SIZE(common_modes); i++) {
>>>> -               mode =3D drm_cvt_mode(dev, common_modes[i].w,
>>> common_modes[i].h, 60, false, false, false);
>>>> -               drm_mode_probed_add(connector, mode);
>>>> +               if (adev->mode_info.num_crtc <=3D 4 ||
>>>> + common_modes[i].w <=3D 2560) {
>>>
>>> You are also limiting the number of crtcs here.  Intended?  Won't
>>> this break 5 or 6 crtc configs?
>>>
>>> Alex
>> Yes, it is intended,  for num_crtc bigger then 4, don't support resoluti=
on
>bigger then 2560, because of the max supported width is 16384 for xcb
>protocol.
>
>There's no such limitation with Wayland. I'd recommend against artificially
>imposing limits from X11 to the kernel.
>
>
>(As a side note, the X11 protocol limit should actually be 32768; the
>16384 limit exposed in the RANDR extension comes from the kernel driver,
>specifically drmModeGetResources's max_width/height)
It is our test and debug result, that the follow variable only have 16bit. =
Will limit the resolution to 16384.
glamor_pixmap_from_fd(ScreenPtr screen,
                      int fd,
                      CARD16 width,
                      CARD16 height,
                      CARD16 stride, CARD8 depth, CARD8 bpp)
>
>
>--
>Earthling Michel D=E4nzer               |
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredha
>t.com%2F&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7Ca822927192
>e54d50539c08d8b2574439%7C3dd8961fe4884e608e11a82d994e183d%7C0%
>7C0%7C637455435178758996%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
>mp;sdata=3D5u7%2Bz2q52PTyPEg9LWcLGVGLERYupc%2B5nKJiIHZTTKw%3D&a
>mp;reserved=3D0
>Libre software enthusiast             |             Mesa and X developer
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
