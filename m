Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FA0C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 07:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371C410E15E;
	Wed, 19 Jan 2022 07:22:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDFC10E14A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 07:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIdgJ+ckaIl4seVXtkwT/9css1+WtndjbqkKzLD6ivo/w+O4GM2/yXvIqzwigUwSNB+6dgNbeJ4kBiVHD0hWAeBV0GAW/Bi7O/Z2aMmwbV3gHqUJ/Me2P5H3tiVbQBW8wvwjT5CEyNtXj8Qlhri1492KDuuZk54Va1Z3tbrfiGYPIdt7OGDZvAqNMIrqnAOEnnAWUZw8vC155tAbbSmz7qjBWibYfSg6TBUMfxLouEnrBpxGw8+mYaAa0qcAZPXxCIIT/CgRCTV7hrnGJEY/c1SoJ/JXZFd5/rgWA7Lq0YrcXwMWUadyw0ysfPSjyfH7lBQLMLuj9CiPTvf0KqpHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF9L8lDumHIKpwQMmR+Qvk+pi23vjywA2U9uaK63TOg=;
 b=X/2q0dDMBWoTqspyTF2pGwt5McidCIZ2+eQKsQblzcdL4lPTS1CnyB0ERMSHKHirpY/UZBu/VYjAwNYRURYNcFm6/ypO8xgFeKgvjU5DgHVEwZW9DZi+sPRLoLURjCW2VKuEd+FG4kkvS2Y7fKyl30RbJn6co1NGJFC9Cr54DQJSkSJneF0i7SNY+pkVjQ0w+bN0WepmmitorciOq/GX5VUwY2pERQGl8i/H+7Dd6TqFge4j9mjf68sbHhdfQGatnQJh51qlGayFUsNs8BwebeM+JnAhtvTxnGiXSW8pGoLCou3LXFi0/aFDDaTzGHhUDKGTCIkxcbl5cUKfsFOYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF9L8lDumHIKpwQMmR+Qvk+pi23vjywA2U9uaK63TOg=;
 b=CwRzj8Hernkf45d5O7cE/+h68qRnbSMAwiU/WYVYvRjvVLrHVhl1nj0/gB6c3xF8xuVrM8FjUlwdHPnAMSqcZeUHcmlRV37xhwZBRqOWnqL94HHMyu4CRie523LtPWSSRKQwCu45gkHrGbzEFYiWJT/8ik79iz+ztWWPc80Kbj0=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DM5PR12MB1130.namprd12.prod.outlook.com (2603:10b6:3:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 07:22:14 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e%4]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 07:22:13 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Topic: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Index: AQHYDOA4wiWWkOB2c02l7hByqRjBtKxp3MqAgAATlQA=
Date: Wed, 19 Jan 2022 07:22:13 +0000
Message-ID: <CH2PR12MB4215A87DEF4902A37258D550FC599@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220119025555.197467-1-YiPeng.Chai@amd.com>
 <20220119025555.197467-2-YiPeng.Chai@amd.com>
 <DM5PR12MB17708F8E65D9C3C669B73F4EB0599@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17708F8E65D9C3C669B73F4EB0599@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T06:00:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fb83effd-d409-48ef-865e-4c8645f27631;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20858ff3-e4a4-476e-e793-08d9db1c6a5d
x-ms-traffictypediagnostic: DM5PR12MB1130:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1130858EF58FCCEA0D9D61FCFC599@DM5PR12MB1130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r0DrLLLmbPtMgp0ldg4907EKVQkm+3584PGE/dTna+Bgq7kPVpJFhkWNLCviZpwrvMa41O++YIH+VI4NUkYQHWXzc+ze30Kn6dCxsz7MlOa4do5xY9K+mSJRoNd+ACBYoJyg062o58G2zNQTiFbyPAlfw2nMvQWskkeglpaCccluIIS/tpJiaifG0BxW/I2UPNtqwsELwE74stUxqI32LLBZiW+KqnRF18m4OBgPewk4fFqN2nsrDlPv4QPD3TdwnEiNzIO37Buk6LvW9H0Nm4LGkV/Iu9peX2Xd0QO2Qnx7OkGUZak5v00JnnmMC3uraWF3ADgqYHV4GW1vsiPtKNYA0RSF21XTWCCd8fJcmEMIzoAJWWwJrx5S1f7ZGUkqBFuo/N5AVlSwX6Xm7ttgCVXMxzhO7CKheOoY1W/QoiEX9/MEvf2QmWI6p8Xug/8kgiS4oORYKRiZmLgnL9w+wYN9oAA2gKM99AauA9vdYGLuTGKjwCWkVt2SZUFFqA7v0wKUWvuyQb6USvJvrldAcV8Qm3hmpkTmbIf95tIH65CYZqXEDwckX6yg4nIZeVauSDGWr+orbiExUKuufM4AC8aIG54ilaeZetSCqYNHaXezigiKV/NLcyd+qUhJwXTpxTvs3d4EzevasksVLXR5DIogenb+V5NhG4JaPUthKZSCxWRvSFAFT2RUrtEoZVLdFimm0dGb7XXu3u1a5FGZz0owPonfo20Ug+fDtKpkU1c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66476007)(71200400001)(508600001)(8676002)(6506007)(83380400001)(122000001)(66946007)(55016003)(38100700002)(9686003)(53546011)(54906003)(316002)(66446008)(66556008)(64756008)(186003)(8936002)(38070700005)(110136005)(7696005)(26005)(2906002)(4326008)(33656002)(86362001)(76116006)(52536014)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o4q1Ow3svfdH1+Or485ACOfb59tGpsAAhf6LrHdItGsRZb+WvYyL/oahpkg4?=
 =?us-ascii?Q?m5q0k0M+EO08bXXfRwqoUJMuFU9qzZpg/jLGQ7S8LS8u2gIqhLW8EcpZA2q9?=
 =?us-ascii?Q?S4wipeAXdHn5WGJpQouzUmMqlRyHBFgSx0ik6ssN3IcxEZ9MT/OHJs+VwqMT?=
 =?us-ascii?Q?TWze13xwTbpBp4dZTke+wsMPtwHXL83fvJtvZRCcI6+ICDkMAlSpm+r0dAtX?=
 =?us-ascii?Q?r8346am4xnjYW7EihzJQI4ALuTYwOICrB4e6coHlCPMLUPH7/pv8SRNajsY2?=
 =?us-ascii?Q?1+3m8H+gzmoNIK+viPSB14hqfQ0DE1SMdNmYwgs2axhkh/jESZ4ppu9WMAKP?=
 =?us-ascii?Q?7YR6Xdu5KqXhyRgDf1ebr2vgEMjMey5+B+iXALBJM+j+oaHICuL3WY3C6HjM?=
 =?us-ascii?Q?v/uHs9uO3PBGPbUciEyoVFsL9V0URRk3fybKPbR8wdO5vz4zQAnVtuT825Ze?=
 =?us-ascii?Q?BY+G9bzQ2dtuTxkiziE5ulhNGveEAqT5gV6FpXrQKuNGcLNKeQBRurpU+8RN?=
 =?us-ascii?Q?CGbOG6mBt9rP0YUGdoB5DWkvp9kpRwpUpfqxgkcZj71mjL1LZbhA+gChFY1l?=
 =?us-ascii?Q?qFKb4l2yj0YpBaRYx3ch0WVQYCBJ2oOsPGe3G2fCiNNrJEK/k2A5aLPHwQPE?=
 =?us-ascii?Q?ttKiB+P4vAN+DbeWUt2zis931L9XpxlLgmuTOPGPRSsHtYQgMIfyxr3eZ98M?=
 =?us-ascii?Q?xShyGB4ZrLVAaBsLmhf6Q9JNJrhftiUM3iLnTSqJFa5MFb+LlMv4MtLr3ijs?=
 =?us-ascii?Q?1X8dPxIEpMB+7oIujM/iw5NlPtTfWjz3o0ZRymnfkrRj4YPMyvm9qykBDZsO?=
 =?us-ascii?Q?AAB8AhGXVGeC9bQWV9pDWhykkOGlOlDSHQmHQArNQzqIkQ2KXO2GkAiRb+k3?=
 =?us-ascii?Q?teXGoB5p8y2EtJnyCWjxezn4UReXTI47u6GCS73D6p5896vIqvRTcejRsuk/?=
 =?us-ascii?Q?c7ZSduwGWBUZho2aDosuG/hdikIYxIunvvMs+POZkHQAmiW+ODgKV5LkaYNQ?=
 =?us-ascii?Q?67Za5hoC3VRh/JNjA71kj/Il+Fo/RAkFS+CvJx7qEKZARoxwHO6nKgp6PLOW?=
 =?us-ascii?Q?GAEX50O/whhbjjFGO+XSAEnZ3BNBbsQAy0WsELinEmx202tOeByF6NcsdjIF?=
 =?us-ascii?Q?sODeIMTThEJMIcD6ddFZS+nIykCJ8I+mJetspuiuXSWOUMAwgwOLeiusKzYp?=
 =?us-ascii?Q?y9MokCKnhGq5WTR93lq2a7OlrZ1ywPyMqA5XIXnxceL/QcnF9Pyc45UKyjpg?=
 =?us-ascii?Q?WQl81zcXGvjuO9V5tCXNfZTHxhRs39H8NhVfARFc4cIRfijoUsxM+/0Fb1lz?=
 =?us-ascii?Q?Z/s3XuPM4bbxslyP0/Owg8TVc/dWBuCrFNgrRpdnm0Ao+eH2XCrE7mvoU7M1?=
 =?us-ascii?Q?NdoVjG993yrmrRFAEgF78mRRE6ctu5WmK2YHh3NstQ0dM/E3E7hLl5eM952S?=
 =?us-ascii?Q?svpC/X0jn41hmkYExUaKgMg6TgMu5FpIR5C3I0D/B6mVJv0u6Js0ha3EpH+H?=
 =?us-ascii?Q?35ptXnQ+80lqFmlw9nt+Pe4YsoQaFSzlTSQQF1eGu5HvD86kP5EZOqfsUWjj?=
 =?us-ascii?Q?6F9IwDjw6Nw13qDVLCRgK0g84HE8E8Z28yuJdpowsjLoYW/2XIBQKAUNh3XV?=
 =?us-ascii?Q?U3A3JFnvYpn6fGjPMJiMOn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20858ff3-e4a4-476e-e793-08d9db1c6a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 07:22:13.8336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKPb/LDZ8YsWfpIqRpBAMtWchC1/OvDUe3m8aMsVZNAvsjiQI0Fhr83yTLROCTqz0phtq9p4CcukRvkxahcMVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, January 19, 2022 2:11 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from .lat=
e_init to .early_init

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, January 19, 2022 10:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,=20
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from=20
> .late_init to .early_init
>=20
> Move xgmi ras initialization from .late_init to .early_init, which let=20
> xgmi ras be initialized only once.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 -----=20
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 9 +++++++++
>  3 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3483a82f5734..d83eee1984c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -452,11 +452,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device
> *adev)
>  			return r;
>  	}
>=20
> -	if (!adev->gmc.xgmi.connected_to_cpu) {
> -		adev->gmc.xgmi.ras =3D &xgmi_ras;
> -		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras-
> >ras_block);
> -	}
> -
>  	if (adev->gmc.xgmi.ras &&=20
> adev->gmc.xgmi.ras->ras_block.ras_late_init)
> {
>  		r =3D adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
>  		if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 4f8d356f8432..5f9f82091000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -716,7 +716,6 @@ static void gmc_v10_0_set_gfxhub_funcs(struct=20
> amdgpu_device *adev)
>  	}
>  }
>=20
> -
>[Tao]: Please don't introduce irrelevant change.

[Thomas] OK

>  static int gmc_v10_0_early_init(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; diff=20
> --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index c76ffd1a70cd..8d1b11368a7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1303,6 +1303,14 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct=20
> amdgpu_device *adev)
>  	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);  }
>=20
> +static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev) {
> +	if (!adev->gmc.xgmi.connected_to_cpu) {
> +		adev->gmc.xgmi.ras =3D &xgmi_ras;
> +		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras-
> >ras_block);
> +	}
> +}
>[Tao]: Since the initialization of xgmi.ras is common for all versions of =
IP, I recommend to create a generic ras_early_init func for it.
>BTW, I think we can remove the check for block_obj's existence in register=
_ras_block now.
=20
[Thomas] I will update the patch.

> +
>  static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)  {
>  	/* is UMC the right IP to check for MCA?  Maybe DF? */ @@ -1339,6
> +1347,7 @@ static int gmc_v9_0_early_init(void *handle)
>  	gmc_v9_0_set_gfxhub_funcs(adev);
>  	gmc_v9_0_set_hdp_ras_funcs(adev);
>  	gmc_v9_0_set_mca_funcs(adev);
> +	gmc_v9_0_set_xgmi_ras_funcs(adev);
>=20
>  	adev->gmc.shared_aperture_start =3D 0x2000000000000000ULL;
>  	adev->gmc.shared_aperture_end =3D
> --
> 2.25.1
