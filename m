Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B4EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 01:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4853A10E336;
	Tue, 11 Jan 2022 01:51:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC20A10E336
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 01:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmYLC0P2V+TaHAn7Db+MBrnUqi3KAlAyIucQC+T/S7i6XMWgVdUWJqbUETU88lUoLZQ3agc5KdbP6fVfCOAnMTEisGJzYrMOe+2NeLpNdLhyLJ54BYyks3msJJJtK+lcx80ujT3oWA+qwkDOtuXPtaVYIkxaQPZ0occcKoA3fx4omn5RZMgeLoYrySOD2RwXyUPMSHtVKNW51zq84z14akLS/o3LpAObST98OjVFuO27wZc4YM7n4t5zZBjR4Y6HcXRmFISLZDP8wG1VuV766ZVvLCVWg52cRyDdBmcAp+O0asY0XVoKCRG2hMKejAfctgjRmm+3v/+W94ONDvAU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFlryF3pVVWoz1fATrbBPW0DYlS4OLb+or77K7mdyy4=;
 b=C1d95EEzjJiUMZN4PfgJSiHe13RLi007085hcfBkI5/d/YCjT4kVHypjFSnEX0XFo2AluemXS0LJe4jnFRAegFCu/07JwgoMxWMxMM7DZyzxdSSCD0kKX9hMoCRTabj5MFjlfivgBUrrCvwb2WXayU65G8yGeMiyZlmXPE5/5Y2Fc9oQsdLaOliBHnu1gK8L2my/qIQaKgux5UDMBaEnuWQsPPGKdvthNW0ig8h1rPUwMB+FKWzjcptIyLMiGQVp//Q4TZWjzS5KuF8WPFO3mhpXHuaT0QkYu9HC9IXssYwT7Qh22ZGYZlRTnjSMwO6v8egiLCe0CR4EWhIqKuS1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFlryF3pVVWoz1fATrbBPW0DYlS4OLb+or77K7mdyy4=;
 b=y/T80KshZmZZ6kOMwglXz5XKfgoRjDI/+RjUf75xo7mDdWRKccD4RP0SkbQ3tjpOZQiQmZ/l6uB6ul6kM1NuYhYht6nNBEk+l+27TDolB/xG1oO2xYCbnaeHMUNNBUxgMBvJ4at0mdKUZbxJGAB4SBKtcGPawbpVQejQ0tIFljg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2987.namprd12.prod.outlook.com (2603:10b6:5:3b::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Tue, 11 Jan 2022 01:51:55 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:51:55 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: bump driver version for new CTX OP to
 set/get stable pstates
Thread-Topic: [PATCH 3/3] drm/amdgpu: bump driver version for new CTX OP to
 set/get stable pstates
Thread-Index: AQHYBl+OyULYmxBTYkSwrFbJuO1eQaxdDqsQ
Date: Tue, 11 Jan 2022 01:51:55 +0000
Message-ID: <DM6PR12MB2619E08A36B27E9C9A12401DE4519@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220110202027.1949684-1-alexander.deucher@amd.com>
 <20220110202027.1949684-3-alexander.deucher@amd.com>
In-Reply-To: <20220110202027.1949684-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-11T01:51:52Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=14fa1dc1-177a-4ec2-a5b0-8ba45c33a467;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 202cab1f-12e9-4cd1-42eb-08d9d4a4f23b
x-ms-traffictypediagnostic: DM6PR12MB2987:EE_
x-microsoft-antispam-prvs: <DM6PR12MB29874EBD71F832177E4DDF3AE4519@DM6PR12MB2987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25qnzGwliN7+CYEjM7wq2RxVMDC+W66fxHJCFJmihrp9rchaQTi72321L8E7tkpLbQTG0G8C9l+C1qVvXiV2a/iA47CMEnenHMIlIhBSfF4Ud5Ga94Y7O0QzWADJ8ZjNvBBJgpPavMl9dWTf3fH/hVntWRnHK1H8N2/ccrOAYkboh44DdxjTVJBubAWIaI1QHptZxQPH4K5XNJxZK5RjlH1dwrO3EAoqejZYTv+qwncwg/BKZaiVEmRlVK/dBdlTS3FjxWI6+RGK8AWabius3ivv4r45wgEmWz4AUFZiiAXQFuMPHkROYJKSZrZuAy/L3jrNYn6wXIgyYxjHyRxJPo5nrraie2ezFbh1+Dh2+4MQ9bqVxWmlkD0kMVF4QAeDA/pPuyzKQlGDTI1OzC+ziFLkISAJ28EGnlSHtfXdClQUZ+L1+/oELg8cENnyRG+66UhlE48e+8BlcCaKwSMbD5Rs1GZSUAIFrq+mHLKrT6lka2CpkyehTmFXkCC/6GvIvRV6zAy4gBHzy00bRaycwm0Pm5k59/mc7BkOZ442DlG9e2XkUKIDTSNKC9o1wgyEf+1t/Y5NUNAGYfkalLVbMtxG1pMaK6OVTXK2+3Cc7ggdr/tecQAY6bmq9VlgR9bzhoUGabr6QRRUMU1xdzPWzVz+GbfzvZtZiA6DusR4kl+ia5Q9/UmFqy6QwR6ArrYq6YwalNuH9dgm0vftU4Bohmwh1OheA20j1kVFNuqpz2GfjJ/SJb5RhivinjtJHDfT2iwldqcfMVl1d+kpkYiXXwx2cwuQIqV9Sc7n5i7QM2g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(76116006)(316002)(38100700002)(55016003)(52536014)(186003)(9686003)(5660300002)(71200400001)(86362001)(122000001)(64756008)(66476007)(8676002)(110136005)(66556008)(38070700005)(66946007)(26005)(2906002)(4326008)(53546011)(6506007)(966005)(45080400002)(508600001)(8936002)(33656002)(83380400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tYvWWhG4mg/+dyOvMAVINYLDkK80gHIUenWoM/RBB0V5bKV95CaeXwgURCfg?=
 =?us-ascii?Q?t5hpksQBz2cwGleu03iizcEVDYjpkp0CxwQxUgD+IqbicM8tndclb+DdVIu5?=
 =?us-ascii?Q?Sm0dnKC7Q7Dayb+EVckWWEOImW4rqgGWXcNphPkoQgZGnJDdjyzZqN35AWGT?=
 =?us-ascii?Q?vhUnZt5IX1Dr0s2tgi21GFGArAgALehTdNVlBYIIHW6RiEP2tSIeZ9+GyW8g?=
 =?us-ascii?Q?WGdNjBnNTrZchpKwmnXv+Z+gkct9PYnK2n2EXMngSxK5luX4bQO6shNeEKKT?=
 =?us-ascii?Q?5z1aDI9PLARRnjo5KIq3lFzpOwxzjwdd+OJIyd3T7xCn7dOS2rkvxlgXa8aV?=
 =?us-ascii?Q?7vMgsTXMmnBahiOwt+a+GZrR3yESqbXuvlDQ6MHkwlRgs8wd2M/W+Y46JC+g?=
 =?us-ascii?Q?pmvvrqfcSd7SclQwzA8j31clbITt7UVLBf2dV/eWHBnPE42OqvlwyIH5aNmv?=
 =?us-ascii?Q?X3PZ+xrEhkIQqRSTYYYwutLWeDHbcPuhVWWOAJLdQbn56VLN8mpiWs8IFgmZ?=
 =?us-ascii?Q?lQw8VztUxh7OkEYkr7j6w0bRGX/mfkpICCRIEjYx+qeExlj+UEEQS+6XM2k0?=
 =?us-ascii?Q?hTTIpC+VxSjSXRqbPlmKn8Q77JDPEKzr+iqePTCufqxCO5C1PLMHFoUaX/T7?=
 =?us-ascii?Q?SYOi5gWhpLIiFpqiDK67DkBimCw0b0GfTqHl5vBZNfgUrffyir0gJhEiELNm?=
 =?us-ascii?Q?w/gihOzoK8t6YDFJvoH1Db2hOQNBIDW/W13zG3HOU46OP9k+SKlgqoRedRLE?=
 =?us-ascii?Q?RpJpdaGTlLtRarWxb8jX48a7jSqOHPiRQWPVmr1lDeATg4IJoMAWjzUiECZf?=
 =?us-ascii?Q?rI4tTHAhfrvsqjtApr7Syo2GEZ0X2wP9BqgoemLpUdq8cBXEqjUhcK6H4V5J?=
 =?us-ascii?Q?S+2zSIEBMVAh6l/F7t3ppMrygjHjZ/RbdtGy8qqRSo3TME+Vxat9/k1mQHRs?=
 =?us-ascii?Q?un3RZbLFQuOxdGsYZ/fTKg9GQye93c0QAmxibr1Hs0I7riohmawxPL0W9ty6?=
 =?us-ascii?Q?j7dB9Gn449NMdMZydQO2eRSJyu2dGFH/FDIFzv0MDY9tI3WFzrd9JOotei4/?=
 =?us-ascii?Q?oeOb2xK1FBcXOx+AQesb/DbDNSmx382Fnz6nkn9sCe6fh6dIfGmE1iFQSwyi?=
 =?us-ascii?Q?Z5rVGkjWjP7Ut2T5+FGMZDEjd4ttm9G+hkvaQ/rc7J2oUJEk4vOUpeIdWTh0?=
 =?us-ascii?Q?i3uCh75dnr+/OE78onPvFLHhRBPoERy+/lj31L26pEeGxMSRDkUEi6Gsr+mR?=
 =?us-ascii?Q?CNMl98JUkqQP1AMrJKa5hU82Yo1O/QNSlI5tUUIZDd7iGf8vxNY+cn8BP/z/?=
 =?us-ascii?Q?j6hKb/NIoTW6JlYNtNOmAeaPz9Ne1slkfA8kA8ZG9anRSbJcTJJGvlLDVXlO?=
 =?us-ascii?Q?sFmJ80AbCkCKU+6a7rXLd36YW8sdpzmZqyNWNSVrD2em5RbH5I4CivnaQ4d7?=
 =?us-ascii?Q?8j2g3fbA+xRlxV9pFZu8/Mu1KfYtmCNkaGdM7oJIMdZCFI9xYQyB+LcxKvla?=
 =?us-ascii?Q?QTN0VgKvVDYGVCB5l6bhYiQwEwzDqX0nv9Suf8Pw65GO4X40QLuiMaBDEebU?=
 =?us-ascii?Q?20fegije7DqiwooVREg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202cab1f-12e9-4cd1-42eb-08d9d4a4f23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 01:51:55.2081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5XtKaqwiPdQM5lKCMCVSxG08qQ4LqDx/XFgkSPBtcu52Ub/yirXKrtVoGz8CmNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2987
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

[AMD Official Use Only]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, January 11, 2022 4:20 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: bump driver version for new CTX OP to
> set/get stable pstates
>=20
> So mesa and tools know when this is available.
>=20
> Mesa MR:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fmesa%2Fdrm%2F-
> %2Fmerge_requests%2F207&amp;data=3D04%7C01%7Cevan.quan%40amd.co
> m%7C2c0626cabecf4fe0056008d9d476afce%7C3dd8961fe4884e608e11a82d99
> 4e183d%7C0%7C0%7C637774428494652078%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000&amp;sdata=3DYqpsYhXD24uIFjntEAkeWvEMPAuCP42kbh02aqEPHO
> 4%3D&amp;reserved=3D0
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d3ef99d7d117..5e3de111ae0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -99,9 +99,10 @@
>   * - 3.42.0 - Add 16bpc fixed point display support
>   * - 3.43.0 - Add device hot plug/unplug support
>   * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B=
,
> 64B && 128B
> + * - 3.45.0 - Add context ioctl stable pstate interface
>   */
>  #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	44
> +#define KMS_DRIVER_MINOR	45
>  #define KMS_DRIVER_PATCHLEVEL	0
>=20
>  int amdgpu_vram_limit;
> --
> 2.33.1
