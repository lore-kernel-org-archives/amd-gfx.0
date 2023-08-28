Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8535C83F11
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 18:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D68410E327;
	Mon, 28 Aug 2023 18:06:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADE810E324
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 18:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwUsD1ZcyCX+JlUVlhqXMbSMEXO7ipw2VTTNzYg5JBn+7IYDF4ypPh/sUqFLeYqyI1jFa0293UM8W3dstSGQHTkbzzQhtOpXgMNX7F9qnpmZWQc6IEUlPIjzAnavyvDSTYX4ydDCAOafixygA8SOX3B644wNShp5AuyD62rPbxj0DJhCGFkdlAnEFnENO1DyjcctUmPPXjM+iBpaqs57lvNacom4iGVW37v33KukQsyIMIjdT/eOHOfhl3Pbm2yCny9noezbCIHhUwGrDvuQiBaKa5VdzYlmQjLsMN/P5UZjGDW9+Es5qbjRju+2NWTHiBqioPTDoBWSJOg4ETyfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpI+lmjKVLazUf8AwuehaYx2B0co5qJierKbvkgJ5iA=;
 b=VMJeMY2QMWbMK+4SfoeC92UIEXEMQw1eUnF5uXvovlzyyc+FoRUGDhIDwexsbHu/mvqyJWXSE4iGe57dAf+Dl+/ug0o8asHCh0dEubwasG7Xgg4oMNxqytLOVkQmfLLQEmmzgLYcEEquPhOJCszm5uMQrDO2fVqlbbiHv2B2a0rlDChn6RsB3aQt7GouxG20SN7hUMFot0zQfz3ei8qTVjnU4+M3DsHFM5bVpw7CZZVsbK7ecMhSEjIKjAxgmN8cWhR5ONKdKAwolvKlV6kKiTdPWS47htbSGffnQxkTRxt+VyauV8CTOS1OAGnIY+F0OBeBaRIzUIT/ZZ6I9nxfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpI+lmjKVLazUf8AwuehaYx2B0co5qJierKbvkgJ5iA=;
 b=dhmqEmmpgsQ3epXqnNwWZnRGrldUSNnSBqvjEYc0epcRON9o3pAVSR1VnqW5I/eQvXw1GlTPy/X2RXJlUVpMpNzzutyAF9e5eCTQLMjZvhezusoyPoVoZYUnlVItnKaDmg9dE0R2+OHDR941+5skV7IQ+trsyp+qzGGI+4cQ0jE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 18:05:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6208:cab6:bc19:7aa3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6208:cab6:bc19:7aa3%2]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 18:05:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Thread-Index: AQHZ1uvvix2dIwLBAUGYyhM/h3wkEq//ba0AgAAL7ICAABzIgIAAAgOAgABtXYA=
Date: Mon, 28 Aug 2023 18:05:55 +0000
Message-ID: <BL1PR12MB5144A8C64BA08B326BEFE330F7E0A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230825003348.3978418-1-yifan1.zhang@amd.com>
 <20230825003348.3978418-2-yifan1.zhang@amd.com>
 <IA1PR12MB635664DEA385477CF3996C8DC1E0A@IA1PR12MB6356.namprd12.prod.outlook.com>
 <4f64681c-11de-7c9d-c71c-d96b4099a9bf@gmail.com>
 <CY5PR12MB6369567CA37A1148A55BC2ACC1E0A@CY5PR12MB6369.namprd12.prod.outlook.com>
 <a7d9611d-32a1-df24-2d7b-0031dde56cb4@amd.com>
In-Reply-To: <a7d9611d-32a1-df24-2d7b-0031dde56cb4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-28T18:05:54.672Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4218:EE_
x-ms-office365-filtering-correlation-id: 1563c621-9784-4251-07cf-08dba7f16cca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HlTj/ZaH0RbBeQgbqOM5nhycUH2HWK3tZKJ/Na41hIvtp5EAuZvBHo0PnQv69LxZTSXMK+ejOfJnCveSO0YDhPd0CYL/JrUFCu7+a/DRIg/Y0awwxYjjlar9x0TqqAAVPnXQOXIzA+ZfsCy8HieaymTvqRs0x7vFFMQxUQWqrh1m3QKgshjWRLCLjfbgTJA3r7uwLCKYNxvae6efd7xc/HCMYfUfAfoBmsfots6zVFStjlEw9o473+QBWePZt7uTM37l9Q3p05ocwqq0/xPDgKfOkodRyURY4MU7YW/+c3Y3aBAWpgAEfiamWdIO8xkOJ7dvmVIvL/gcNbWqbDp86KKv2qVkMW4IOeDmfbgid49xxapbUJyAJjhx099kdwQ9DFVVGeLSkF6wU7ndm67XB9q02lSYwgFkd12jBahKHBXy6sKgKxaCkleXHBcEWpQt9csfHBqTgnwHhJqG3lvYsE+cdi7rO/WUUXh2DwqpCa8DKjPsxPxHqrb0t+8Q5Yq+LB1VCchiW8yx37CScTDcwN1Bu0c1G/jdOKoZgrpkWo+Jqme8fuTV7mcQLtBeWhPf/+4v2hkhjioQUW5qZ6s4ij0uVRef//zIIYPptiA1HRJLnYVQ0eaiYfIFv08D8u72tZcSIvr0orFpPZMcfa2JJPCv0dxgXr9KFxKd41Ivnu4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(19627405001)(7696005)(9686003)(6506007)(71200400001)(33656002)(55016003)(86362001)(38100700002)(38070700005)(122000001)(2906002)(26005)(83380400001)(53546011)(478600001)(76116006)(110136005)(41300700001)(52536014)(66556008)(66476007)(66946007)(8676002)(8936002)(66574015)(5660300002)(66446008)(64756008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A2fg+7PNBTaRtknp/iWATLNeDEvbDbsdC/HMh8yWfDxz1UJsIJPdbEi8Ll?=
 =?iso-8859-1?Q?s94moxbz/RObqYdvKM7hOgivRGhV+XWNvgJIPdZZ7Qk6gfBrGf7AVbCUR9?=
 =?iso-8859-1?Q?GNR8cS+KlQRpJW8DkREnpNt28x73rX0MlNj/CU1QgY0AKIPBZ770Sqlim0?=
 =?iso-8859-1?Q?Mng6LBwllRHEQb2KQEthIsrwjUrM2ZLOiWUP/pzuLwBqYSSKVHbecoT/Uh?=
 =?iso-8859-1?Q?bc27duxz6nInzjWAFErP13UY8I/L7yjnKyHQeIZ2JMwn6Gy7a9FF6upxNf?=
 =?iso-8859-1?Q?PrGKUf+P/lHd3xxsZmAT4hbubF+Xbc9LkPi0CP6JIqJTeKrFUS2DECTMGG?=
 =?iso-8859-1?Q?UDunfd64PU0NNNPNCuoi/M1RofARdZBhXbQwFUgOq8LusqQjbJebBzqV76?=
 =?iso-8859-1?Q?DNY4QYvt56EIUENHZvSxzukXPNA4KCcR/cipAklCttjIqm5wozBw9eOB3r?=
 =?iso-8859-1?Q?SxI4tuov4YhhRHAbEONPaB1qo7ZB78iL7ESLUvVHRzZtiArNYzpp7V+Jq5?=
 =?iso-8859-1?Q?+Gjz2hOvnmM7Kmymgjw+FusiC4q81kJ6EFZybxYV3Ajvv8tsoO4Azsvctg?=
 =?iso-8859-1?Q?j+GKEx5oAVf8ORkoCruTQ9sWwx0b+/4BSagiTjDsJehx5IH5HRccAeGE73?=
 =?iso-8859-1?Q?CPY8TE+JCVBttJnBmRXKpZVwuA5TJkpATDrfuEuyMaHg5Vpkn/TuxUC3WM?=
 =?iso-8859-1?Q?a1B1twQiVtYh07/x2YsvUwXhEJeVUgN+86xihkSh35aeB7b4ZG8t33nDHS?=
 =?iso-8859-1?Q?60bcAd0dSPwYlKBD1555WNKUfuoc8eHYfuXPFUTq2376K7JQXaK4l4Um/R?=
 =?iso-8859-1?Q?zcHvSFOo2y1SkYlA3zBei/QEpKaaiZyRPhjDtLzi42IEYRDc3W9LX1hHSO?=
 =?iso-8859-1?Q?6J1NVHQc4w91t45nCIyI4So5us8GWa/ZyxrTwiLZRnICzBMG5rp2GxUAlc?=
 =?iso-8859-1?Q?RqY9Hx7UQEsSncslu3COCWREim+y9wXduUI+JUzbVoTfG0ur7blaRaE3tn?=
 =?iso-8859-1?Q?iDOzAFJgAUsg6TPCH90YFqt1Oufwn2sMoJjnOem/SytV/+qfElQ7UO7yeA?=
 =?iso-8859-1?Q?VlMrUJq87LlB79YtIyxZS3yXstvEOup8119S/I792mNzGH3FmrsngIpPq/?=
 =?iso-8859-1?Q?YWOoRuYr5e3JpeIYXrmj9wXN3e5qkSTuFAmWhv6PHAW/+2WkGScXfws0RP?=
 =?iso-8859-1?Q?vdRM9sPuXPSY1+m+UnGau7nMFyLQWelmV2NZV8rB73jjsx+bY+ESGAeEl4?=
 =?iso-8859-1?Q?RbD+fWUM4W4g+CPOffGwWIPkGMbHFt1HJam3YNbqBs4xxMIwc28OAZm/4q?=
 =?iso-8859-1?Q?WNisHobxU4hZIpHPVj7EXkgVlfEuY1adrUey55s3h3QEjp/MtWCIx3rmCZ?=
 =?iso-8859-1?Q?6t8tzqs2QGb6uFM8YCRVh16KNU/4oQAAD0SkVeo7kXQ7rmEB7oj87Iu9fO?=
 =?iso-8859-1?Q?xGv3DCzGAJ8pPW+csCjGRCrkeEbNDye10oUPtNp5zPdV5c3+lvwELzrOMR?=
 =?iso-8859-1?Q?VWYtbiAy4QzEPXXAjFIW3I4oRjf7NM7Rd9um4Ywamp3t0EcQAU1FNo6HRf?=
 =?iso-8859-1?Q?S6vbLbiIcWigXMHZeYGge3R2loTaVnkWAFrc1+Jkf8/icHU1Zte6g3lIh+?=
 =?iso-8859-1?Q?+uAd03mkPo6xM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A8C64BA08B326BEFE330F7E0ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1563c621-9784-4251-07cf-08dba7f16cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 18:05:55.5967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFlf5d15NddApYyKlvsm/qaEQlfcPiuNnHDhelYihoxBuSX98e6rz30PzbdNk8/MAl6cs0es1cYuLut/FojcHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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

--_000_BL1PR12MB5144A8C64BA08B326BEFE330F7E0ABL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Technically the AMD IOMMU uses direct mapping mode for any device which cla=
ims to support ATS in order to support the IOMMUv2 functionality, but that =
was also the case with Raven systems which were problematic when remapping =
mode was enabled.  That said, now that IOMMUv2 support has been removed, th=
ere's no reason to use direct mapping in the IOMMU driver so that may chang=
e.

Alex

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, August 28, 2023 7:30 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Christian K=F6nig <ckoenig.leichtz=
umerken@gmail.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedeskto=
p.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for g=
fx10 onwards APUs

Well, there seems to be a very basic misunderstood here: The IOMMU
isolation level is *not* ASIC dependent!

Try to set amd_iommu=3Dforce_isolation on the kernel command line.

This is a configuration option customers can use to harden their systems
and when this isn't properly tested we can't allow page tables in system
memory.

Regards,
Christian.

Am 28.08.23 um 13:23 schrieb Zhang, Yifan:
> [Public]
>
> Not yet. It will be only enabled for gfx10.3.3 and later APU initially, I=
OMMU is pass through in these ASIC.
>
> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, August 28, 2023 5:41 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>
> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for=
 gfx10 onwards APUs
>
> Is that now validated with IOMMU in non pass through mode?
>
> Christian.
>
> Am 28.08.23 um 10:58 schrieb Zhang, Yifan:
>> [AMD Official Use Only - General]
>>
>> Ping
>>
>> -----Original Message-----
>> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Sent: Friday, August 25, 2023 8:34 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <C=
hristian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for gf=
x10 onwards APUs
>>
>> To decrease VRAM pressure for APUs, put page tables to GTT domain for gf=
x10 and newer APUs.
>>
>> v2: only enable it for gfx10 and newer APUs (Alex, Christian)
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++++++---
>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm_pt.c
>> index 96d601e209b8..4603d87c61a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
>>           bp.size =3D amdgpu_vm_pt_size(adev, level);
>>           bp.byte_align =3D AMDGPU_GPU_PAGE_SIZE;
>>
>> -       if (!adev->gmc.is_app_apu)
>> -               bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>> -       else
>> +       if (adev->gmc.is_app_apu ||
>> +               ((adev->flags & AMD_IS_APU) &&
>> +               (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 3)=
)))
>>                   bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
>> +       else
>> +               bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>> +
>>
>>           bp.domain =3D amdgpu_bo_get_preferred_domain(adev, bp.domain);
>>           bp.flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>> --
>> 2.37.3
>>


--_000_BL1PR12MB5144A8C64BA08B326BEFE330F7E0ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Technically the AMD IOMMU uses direct mapping mode for any device which cla=
ims to support ATS in order to support the IOMMUv2 functionality, but that =
was also the case with Raven systems which were problematic when remapping =
mode was enabled.&nbsp; That said, now
 that IOMMUv2 support has been removed, there's no reason to use direct map=
ping in the IOMMU driver so that may change.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Alex</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Monday, August 28, 2023 7:30 AM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;; amd-gfx@lists.freedesktop.org &lt;am=
d-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memor=
y for gfx10 onwards APUs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Well, there seems to be a very basic misunderstood=
 here: The IOMMU
<br>
isolation level is *not* ASIC dependent!<br>
<br>
Try to set amd_iommu=3Dforce_isolation on the kernel command line.<br>
<br>
This is a configuration option customers can use to harden their systems <b=
r>
and when this isn't properly tested we can't allow page tables in system <b=
r>
memory.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 28.08.23 um 13:23 schrieb Zhang, Yifan:<br>
&gt; [Public]<br>
&gt;<br>
&gt; Not yet. It will be only enabled for gfx10.3.3 and later APU initially=
, IOMMU is pass through in these ASIC.<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
&gt; Sent: Monday, August 28, 2023 5:41 PM<br>
&gt; To: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedeskt=
op.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Chri=
stian &lt;Christian.Koenig@amd.com&gt;<br>
&gt; Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory =
for gfx10 onwards APUs<br>
&gt;<br>
&gt; Is that now validated with IOMMU in non pass through mode?<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt; Am 28.08.23 um 10:58 schrieb Zhang, Yifan:<br>
&gt;&gt; [AMD Official Use Only - General]<br>
&gt;&gt;<br>
&gt;&gt; Ping<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
&gt;&gt; Sent: Friday, August 25, 2023 8:34 AM<br>
&gt;&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt;&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, =
Christian &lt;Christian.Koenig@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zhang@a=
md.com&gt;<br>
&gt;&gt; Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory =
for gfx10 onwards APUs<br>
&gt;&gt;<br>
&gt;&gt; To decrease VRAM pressure for APUs, put page tables to GTT domain =
for gfx10 and newer APUs.<br>
&gt;&gt;<br>
&gt;&gt; v2: only enable it for gfx10 and newer APUs (Alex, Christian)<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++=
++++---<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 6 insertions(+), 3 deletions(-)<=
br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt;&gt; index 96d601e209b8..4603d87c61a0 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<br>
&gt;&gt; @@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device=
 *adev, struct amdgpu_vm *vm,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.siz=
e =3D amdgpu_vm_pt_size(adev, level);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.byt=
e_align =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.is_app_apu=
)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.is_app_apu =
||<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10=
, 3, 3))))<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_G=
TT;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&gt;&gt; +<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.dom=
ain =3D amdgpu_bo_get_preferred_domain(adev, bp.domain);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.fla=
gs =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
&gt;&gt; --<br>
&gt;&gt; 2.37.3<br>
&gt;&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A8C64BA08B326BEFE330F7E0ABL1PR12MB5144namp_--
