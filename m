Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613AFC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 03:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DE111A9B4;
	Fri, 26 Apr 2024 03:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pH4X51bW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7439711A9B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 03:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8ojZT1+kKl5wQ3tVHBPAdypMO5/r6zNtGjOasQ2QhyYIeuxA7RVqMQA6gflNDBgsrcYGLBxPdmeW23Sv+04n3a0ac8hfqMWZ1IOG5BJj4iOB5jvuuXt7QODt40kALDtKRDs+6kw5gp5Y6kJ85Z3fcYtZ6gSbcmptPVLsIeTAFZIyUOr3s+XmVrcbAwpy9WSCd+F7Mt9tuRX2OxrNdpTPa2Qa18hTutXOYfviA2/QLB4nxjw9LrBu+6aEFXik54KYwQoVFLML9EC/Xf7ukQ1bNppJ0c+KxQ4akZcrX1Yn64YjE4lUI7fJxq/9tbzIuIudisxDE8EsEBHhYBUGumqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh4m9PHhpO7UAIC9Zw0ibm2tZtKVD+ICzUDgSCPzwP0=;
 b=UWkwvmt/NyelYiHoDbCsl738pNFTUjS0UEUKeocATtJnHVptMCJd/1sx6jFcVk3Ga4jfG0qFOYIYKQX0KoYgy984plDJ6/Byj9LSwtRiTBDcb9Bu5E7MVn7W72JeP1GlXkzFr2aJwvtrqOPbTDlG8CFBFh5gngkEG6aPUgFB4vrwjg3AQ+42E90uBJK/Pss36Enwn0I/5QrcHZovAkBkiXxhO5wwECPqGsUe/SSVU0iWj6/ZJqB9keudcmO+ZaO14OdTYfq2UvXcE8HUb4tu9HCh9C3+HU8C5GG9h9/aIiHEUGDzmXIYTQg6D1Z1byut5sR1BjQY+9vsOY42hqZ79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh4m9PHhpO7UAIC9Zw0ibm2tZtKVD+ICzUDgSCPzwP0=;
 b=pH4X51bWggM2gpeVgxuHEpx0IOOLSDVJwdgm/OPTlm8of7MZiCpqaLPobehEcXSbJvVgUqOm0KNMiYQdKvG8FtOaBfwL9QzJ2hATAgsuSoGGrj7q49piOlAJqSGFMS6tfoejLURc0hokZRQrdGJ17VrRSLaOzs04rQ/IKG9ZoNc=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 03:06:55 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 03:06:55 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip to create ras xxx_err_count node when
 ACA is enabled
Thread-Topic: [PATCH] drm/amdgpu: skip to create ras xxx_err_count node when
 ACA is enabled
Thread-Index: AQHalfIrOTHrDlig30+6eG1GuXYOTrF54PMA
Date: Fri, 26 Apr 2024 03:06:54 +0000
Message-ID: <PH7PR12MB87965D0BFCC94259D3659C55B0162@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240424024958.3290503-1-kevinyang.wang@amd.com>
In-Reply-To: <20240424024958.3290503-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ff0cea3e-81f2-4b81-846a-794df7403f10;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-26T03:04:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB7736:EE_
x-ms-office365-filtering-correlation-id: d6caef13-909c-47ef-b2c3-08dc659ded97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?4i50TygBDKwz6/Bky9qzAf8/FYmMPnCSQC6N7aPz14k6MRQjYeM16mDQ2S+z?=
 =?us-ascii?Q?Jvt0VCj1zXHZjjlgq1jhcv9kn9o03SAgagV/YL8k7k/clJVE5+wuAF9tH86r?=
 =?us-ascii?Q?F+E4puyn1Sm3bs9hhhq8CL9oWpEJOY/6976XFOg3sM2YNNDjINFogPz3haYi?=
 =?us-ascii?Q?ygfbrNa3JGOJBkT9zsaFFV0Bu/IIxOVIOgTKVFie9fszuOaLFKpT3WUlnFp+?=
 =?us-ascii?Q?cGayOS/LNg96PW+3AMcgnlzI20DZ6o/FsGX6f8dvJwiSOIWHPILwomJgc4WU?=
 =?us-ascii?Q?RAq6Fsm9yhifaA+eVPHTZfT2F7Rt0d1KhO+xBC1VdH1rFaEvlKeFBCkDnuN+?=
 =?us-ascii?Q?vSPkmxq2Am950P40lb/92Wa/Jw48jMJQJh+H3TaL4NLXUpVFQzlXWI96C0LO?=
 =?us-ascii?Q?xcfIJrViR41bR7upI9acHxS09oo3EZ3o0dM7gpRWhD0xToe9PzerIost6DRw?=
 =?us-ascii?Q?Bc6HXgE+a9niMpRDKhUDh++5xeY7KvZiRllaISJNnKREo774Ova6hJFude/B?=
 =?us-ascii?Q?fxnn43TvoS35qIXSqfEaBfp1vA8aIY1EAQjfGpmAojeg+stpEcwWV7LXytio?=
 =?us-ascii?Q?YR2DUVUs9TThG1zlJcZLL8YmM9pLQDE0CThlYBYYbdiSNwodMJWruoDRDyNN?=
 =?us-ascii?Q?XKf1De+UuMKoFwBgtbl1a9nLj6PSYZMM487vLXq7N04IHKRVIaGHFEcH5xvo?=
 =?us-ascii?Q?xTDh2yFz61SkBd7g+POGZpGLlQLIk4jLXGNBj9f29JkVTpfKl9U0Bs2ASqIo?=
 =?us-ascii?Q?qjbzABrOsFibDdF/xZERXxhEzLRLtGeGj0ImvywI1AfLPaY7PChFy8uLMpge?=
 =?us-ascii?Q?XKexMnxSPEVd4tj+hJdcnufDagLJs2VUyXyidRSH+OSjhJmMVs9zbJ+++aXH?=
 =?us-ascii?Q?g54GZFqDjSfzae91+TP+yJMpvAqcqVTCoxlNl9t6W7gQKBn8op2DZWDSFx4J?=
 =?us-ascii?Q?b2s4H6E3pyp8nFjIGdJD74lVsrPuKw7cC3igVL2z6SzmeTEXlxFHOWDXyfSh?=
 =?us-ascii?Q?6PyOvWmiT7isJjpyJNwBpTDrPSWRja2yRpvtxBIsuV/OaB+2PwcC/RihDuL/?=
 =?us-ascii?Q?ZizfqACK/QlPaRzVK0tT6ZfD5JMAHosj511Lyh3g6p3hcsXGN73KABRPW7ui?=
 =?us-ascii?Q?hOmCn8apW1aBuJAswNzvIzAjKR9/MzVCRNDr8szCiiQzAwXwMkFdb6HnMOX1?=
 =?us-ascii?Q?qhAziYS8ZevFBgJJ/e65Mp/MXfz3P9IUR+JVtMLV7/JLe8NNX5ggXke/cw02?=
 =?us-ascii?Q?b+AFfDAR8zXHDMS/RgRCi3BfvWJv7DSEEs9N+sRrj5VDaLJNo1BzPjNv4CyU?=
 =?us-ascii?Q?0U2r/6Kf/EuMdKz30ehLir6A?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6UjV1+S8cGZ5+MzjldcMdcRJjuMrv7sD4i7vELla9X1btYgujJYyw8TVwJxz?=
 =?us-ascii?Q?ne3DcFpSQe0+ti1iZiNdHepFk9pebQgn4mWIruo6ZI8Lmu97KLTPTr/5Cvop?=
 =?us-ascii?Q?0Fd+DKZ4XHgx3FiAwPJf0RYeFgyE+o2hPXTUIXM7Hg1gdHxXVWPRePlnng+4?=
 =?us-ascii?Q?Ph51JqLFtBMlL46MRD3WVZDcPpfuAytzYRmDFlFr/qQ6ZTcO79Qn/PZnH532?=
 =?us-ascii?Q?3URm42ksYpALo3tmjE6iCyNquBFHcygzUTicIGFgNhXl2nq/yj0QINvAkLsf?=
 =?us-ascii?Q?VqmQwJUBZO1sty24pVym5PZ+Hkq336TzhVnSMugikkNo5feceUY8dPuWmfA8?=
 =?us-ascii?Q?UYxishQf0L4A5C4HkD8CXUSM7komFIz6d7O9uXDA76py7N3iAVtBYUnLMP70?=
 =?us-ascii?Q?c5Z8exKzLRwr5GOCUMuuNXTxz6PPWsNWtBjAmCTpkzgHH/8vxzifu8d+8vq8?=
 =?us-ascii?Q?dFCDAADWqVMtVnhyXW0Pvqu3e+ziwo20ovqU2GE9vVyJiRgmhTsughpPNrFe?=
 =?us-ascii?Q?G21QBsMh6T7jB09gJETnrbnWCeeGwaLcz2gCxgdHA/QzTS5ZFh6R0+rL1VzG?=
 =?us-ascii?Q?ZfuJlqm5fvAit3jNYBtXiz9asq2QR12TyKQh88AOgYWsogg59dy2/IVxcVuf?=
 =?us-ascii?Q?6IkCXICc9+DGXruLIHNZy/AS7hGNTEoWUPfY0xViKo4urActAeWwY8p+Y1i0?=
 =?us-ascii?Q?ILlaoSACH0Gdov8qpLNxg0+JNLoZrRJSG1ulRYkM5DpMzwpLxzf4X3Aar8/F?=
 =?us-ascii?Q?0FCGXWGy7NzmcFuG6+PtKRgvTy7Kic0wwy9cjx2s/5U4aGSzFbljHyhSxsjt?=
 =?us-ascii?Q?JCDcrtPVK3D/946RmoL8+COtqX2VN/9JakjH8W7E+zG63BruGWd03EdzQBDT?=
 =?us-ascii?Q?K66hRUR8zyPe9pOlRZkP0IUPmVuN/7Fj0W5g6K/1qPXVqmeeZd3I541EwsHI?=
 =?us-ascii?Q?0qwvorT2ISvdckg6GjVokf+tVVEISZCohG1cY9IXMMP3PyIh+LuDXMSG8c5f?=
 =?us-ascii?Q?nfgNtXy5g3gt0yIvj/gdqTJKwId011Txtj/Ivzob6I04vF6P5/dCerKTwXqU?=
 =?us-ascii?Q?D8KnfGFhaXm1V+aLXjqRkJM+L1YpsHl8YcCsj14hXTPYrqKN096QEjspGENP?=
 =?us-ascii?Q?ELMlSVyhSpzLeVLqJJMWX8siPu28vV3CWafBGGs98qnGeSoYQHGtp+NHCfuy?=
 =?us-ascii?Q?WADXvbcJPwgQraIndGXg+skWoMalRR+tGPtE0BAEfLNplVLC4GiOdxS12wPy?=
 =?us-ascii?Q?flwJcllIVM5MzdWDzHqH64BUFf+0Ojz4E/8E13Va0MEVjNh7daNtwr7P61Go?=
 =?us-ascii?Q?w5VVvUXuxs9jFGijj/4+RYMrVMXqV6344RKp94+4wblVd/p30zDO9bTH0GnZ?=
 =?us-ascii?Q?Jhidclx+e5G+Y+x0uVBoEX55PgexxzWIYE+IC2UFl6Ro4NKSZlGlav9TeGZ8?=
 =?us-ascii?Q?GytzpZ8T0xlk60zaFuTDIdm8jUYUPGV2GYz7uu3Qs22a6oOjHcj04259C/wV?=
 =?us-ascii?Q?1kSfInerMSlDIx3mDR6/3OKLndgr/OTndMByQnSVOiKAg0GLARvnSuDDhaAS?=
 =?us-ascii?Q?dyhdNH65Kjd5N9bWF5c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6caef13-909c-47ef-b2c3-08dc659ded97
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 03:06:54.9775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kDCFXD5Mw6Y+kA6mj8ujGSpORhF5spkSrCwS74uH71qGkIE5lPi70aOjetgP7Ls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

[Tao] it's better to add comment to explain how to get error count when aca=
 is enabled.

BTW, according to the change, do we need to update ras tool?

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, April 24, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: skip to create ras xxx_err_count node when A=
CA
> is enabled
>
> skip to create 'xxx_err_count' node when ACA is enabled.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1e2b866751c3..96a8359b703b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1756,6 +1756,9 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device
> *adev,
>       if (!obj || obj->attr_inuse)
>               return -EINVAL;
>
> +     if (amdgpu_aca_is_enabled(adev))
> +             return 0;
> +
>       get_obj(obj);
>
>       snprintf(obj->fs_data.sysfs_name, sizeof(obj->fs_data.sysfs_name), =
@@ -
> 1790,6 +1793,9 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
>       if (!obj || !obj->attr_inuse)
>               return -EINVAL;
>
> +     if (amdgpu_aca_is_enabled(adev))
> +             return 0;
> +
>       if (adev->dev->kobj.sd)
>               sysfs_remove_file_from_group(&adev->dev->kobj,
>                               &obj->sysfs_attr.attr,
> --
> 2.34.1

