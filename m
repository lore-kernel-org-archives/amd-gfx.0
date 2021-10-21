Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA87BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F066120C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80F066120C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F8E6EC72;
	Thu, 21 Oct 2021 13:34:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 505676EC72
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwRTX3Xwbi3f78Cvkab5dBeYJD1SAgnxo5kgINrKWxyLibTxFFTiwb8TxlMptGMdsmKAcVdvmTqZDa3pfl/ZTcaewpZjC1G3fthJKFbfzWvpUlDBzNv19xmW26auiJ5BgnmXohKJ7VyW25wM0xg3qhi1omzH+J166IN81w1VwM231KU818BGooN/Hr5nsMLLzMHZk+Kc2SOhkLZR+15It7+ELvEZZVGKHZaEVSax+ccdg8LVErm7ee9fuhlzMV/iWaYpcOexL5NxGgWVOLg3fxu8Oglby/tGNK5tHcpagYwwCNi64AUZuz/Ey8TFtVxEZX7FZ877c5TA8XFfBpjApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWS/HeWyDZz5S1dm2LFtOPRDzCfn9Ig59SLzDliRJdA=;
 b=lknChadEVp5rY87Rg/OF5UZ7oImE3itG323CalUTVTPDu6YmJTRxkzH4Rg64KHbUzWov8DqR3L9cHhUNkw403W1Q9OIK8TM0LcnvMLKGU/YT21xJOPJllHTI0Rvmr7KckuYdvsOQ3sCdLuqeWTGAh6YX/+dYp8VrPSmhozoHZe4yMa3SNF/qQ0MWDvJKQrKYeRhPy5mHbo97BKmAn4HBnWDB0siw3+NEzYkxGwpuRSO/l3gaWJtmfzKdbt6k5i8FkGeoRBFiBt/7FdKyhwXoADpgn8+kLaNjwtgO5fn7vvcX8DXcjN7d80hxsRJj8mNG6V+vQ5NKx6bESzy63ZG4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWS/HeWyDZz5S1dm2LFtOPRDzCfn9Ig59SLzDliRJdA=;
 b=gLVSjp4GZTswDquOjVedPHJaWd+LqWLqY3tgQswZrFyDyUMnjVZrsHjTN2+8cAjy8IrKfj2cnfZVLIWxe01yg2ARmpIGl+rvTp2pd3UROC/X4+16z11l0g79SyIZKbL2j2+egwS+cJwFntBfuGwZQGa8oIR9Lwuq7CBJ/mIdm1Q=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3772.namprd12.prod.outlook.com (2603:10b6:5:1c3::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 13:34:25 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 13:34:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Topic: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Index: AQHXxktx1DjGstD6vkidsjU3klQZCqvdbB6AgAAATzCAAAWU4A==
Date: Thu, 21 Oct 2021 13:34:25 +0000
Message-ID: <DM5PR12MB2469B136862C34B770761404F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211021071512.20034-1-guchun.chen@amd.com>
 <CADnq5_PJZDfNJOrFLsn5+FeWPm=eS4CE2d4FTdTSUKkDkDZg6g@mail.gmail.com>
 <DM5PR12MB2469DF82D13B3FE947FCCC82F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469DF82D13B3FE947FCCC82F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa3c8a7b-76a0-4107-8812-08d994977fbc
x-ms-traffictypediagnostic: DM6PR12MB3772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37721AF686AC155BEE610C45F1BF9@DM6PR12MB3772.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPy9Y0GwvJm+90bU4Cja5snXlWrH4oZdotS/i8hdvTNMSKq2JquzSFwwjhHqhxXrXzZd472yESH6AtHU4o5a0NtMnDcDIKitHeRvvKb7jBjQQWNo/yX/axHRJDt/2uZx1lQ/w9iT8bw9E+r4n+Ip1ZBMf7Mb3dWYaxffFmPHFxjn4oxkS9FCPz5rfPkDgt5EyhnASsT4m6Lg/a/oO/+ZJ+6gSYa4DU/kxx+AW4OfyLXUHebsKTH6+B+xJogjvrVfpupzVBzLr+YB5l5IOONaywp/Kl8WRFRSnNwdnAf68aoskeoWvsJ1qh5paA2ioRtFrho64BEBFrp7GIJjwKEbbBzGWIdINTjkMNxuGVHDV21QuqkpNLQyMpeKBqTLgGxfqWQ69tnhZhGmP3M07+yXjc13s8gx7/dMeGeLoPCV4hMaveJPsoMfVx4iDkaggJXj6Mm51wnPN/loJI5SGoy/qyMMKb8LN7s7io2h3r2nldO+4oP7Wc/6GpjWo7K9QTw8g6mBSJerZvHLXaIzKFrau/BAJ3TlBnph456HJCNqrJrLXBplpBqm4S5YmQPHNWBwREXFlDfz4N+TFaC7GDbrY6w1qpcER9tB1jr1vq00ak640ymy+98cUxrsJ+NZfZsR6Ut7a6B6IW6k1wRTJa4IJM9QfS/hoJmhnNIRctveKuDnJeXnshvc8kuBCx8EOC+f7zVgb4JpmQlPPKc1r20vkK0UyMEoFA02q1/P2jZR5Fesmyj6E02IqCz7dhZwYZ5O+hI/O+Pd/mgj6yhD1LtCAcvHJMqnFton06I1VCDaQDo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(33656002)(5660300002)(316002)(54906003)(966005)(7696005)(9686003)(2940100002)(86362001)(55016002)(38100700002)(8936002)(83380400001)(66946007)(76116006)(4326008)(66556008)(66476007)(66446008)(38070700005)(71200400001)(45080400002)(53546011)(2906002)(6506007)(52536014)(64756008)(6916009)(8676002)(508600001)(122000001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y2OctZA9oEa1vrewaj71CnUMoAMTlH2u4Ha1tHTFr4wcJjDGHexwqUYTYnQx?=
 =?us-ascii?Q?ZmO3QFVY0A0rCsNTXts/MIfZXm4WX15DbxciGIvitxaPoWi9oUALw/UwhPO4?=
 =?us-ascii?Q?2aKkY2C7qg3qsHSBj5rF6FkEhFrMXrkG5EsX5GOWoi38BLpB7hj2CYvx4oGY?=
 =?us-ascii?Q?BKJT+pnZHeTKiD7pqwgld8np6nREAbqhI4/Paazp3FJ6+c9jIPNwkvFyQoOt?=
 =?us-ascii?Q?8bX/rVViGWA3wXA0qXiOuIO7IwnmukXBC5rUtm38hdiFb6al8PV+94S3B8RA?=
 =?us-ascii?Q?d73RmklQv/xWKEzrWadzgJq/9KKw9m2LZaxDbCS/9GFzfYQKvws8DR13wRX/?=
 =?us-ascii?Q?P2uqD/WiuTT3gdYWkZ8T7WHYPhpXd2Zyz4JqgVoH4uMeSALPnXsI/liSlYdP?=
 =?us-ascii?Q?IDBSOGktV1yHxviGk/5HKhzo9eJK2ahrUafBRPvJXK+rFWiCdBPRh7X3YeYq?=
 =?us-ascii?Q?6J1ki2EVmlEetrLKr4oDP8lYMxC0gkG5V5zmzzVcSgsYyy7K/s2lW1m1L3RS?=
 =?us-ascii?Q?NmO7MiRv11qNDgn436/vjRnJGQVx0OoM7y7tvX7avszVYk7mpVFs1p4I47Lk?=
 =?us-ascii?Q?9cmyYg04cA4RoeBy1eonvLURwFqGQjjKHTlvuAenLqe69B/Ipqpal4ecN0RL?=
 =?us-ascii?Q?Zg7MQdn1G8y6VnCWjtxmM1c9E5KFCpVjxgqWLAN1PTqE2jLUoHc0e+3slPCz?=
 =?us-ascii?Q?BYb80V299ITr68Vozqxgb+xMNJsdGqkvIT5xYTuQg9WuTDxWAq24CEHkya7c?=
 =?us-ascii?Q?R8gWDZeEbHIlmNJ7RNb8Pw7JqZbxcIw+Q/vGbZRm/mwMHlAchzS9/vRv2CCu?=
 =?us-ascii?Q?2PL+rBT6DQ10oDok31g8u07UHHlNKRrKTyiWc1JG+mXF+63KPD+/CU6PaSua?=
 =?us-ascii?Q?qI2EbyNaYn9ZIYMSWcl/DgNIoZbh82tzEyb04j+H/lJqcomrgn5ys9NHJh4I?=
 =?us-ascii?Q?3iXodZhgSRIsFDSZ/iFZPmIpd8KptQyO4WHL8Ks6X73DA7tVUGPiYmb6lrFK?=
 =?us-ascii?Q?eNUsHBHY5RQ+CAY62LZYMT4Ylv+yu1VQwLuPDtDOiwWE69F4he+740ysVgvE?=
 =?us-ascii?Q?ZaDd4bnEypjUunQVEct7mAXi/xrJGvEHtdPPu0DvjCpKC76/nhP60SbwbC4C?=
 =?us-ascii?Q?J/AHsWeHsN7mHjh2aOv0B2CkL4UbMjA+OAgl9WeJGy4lAyRiKAQrlzpq3/st?=
 =?us-ascii?Q?z8E5opYUslc6bFl3snqXjRMHeT8R+0mZVoE/hXjtLC7oOpy89H0+tUnPmWeK?=
 =?us-ascii?Q?mfoLvCQ1CIu6vyGA1gIyQyQnwgv8+Z97vWtaqKNRGwLIsC0I9LNmiq6lfsVy?=
 =?us-ascii?Q?IU/96nqFuTYGnL6MZV1wYKxQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3c8a7b-76a0-4107-8812-08d994977fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 13:34:25.1681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3772
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

Additionally, in sienna_cichlid_dpm_set_vcn_enable, we also use num_vcn_ins=
t to set dpm for VCN1 if it's > 1.
The main problem here is VCN harvest info is not set correctly, so vcn.harv=
est_config is not reliable in this case.

if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
                        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MS=
G_PowerUpVcn, 0, NULL);
                        if (ret)
                                return ret;
                        if (adev->vcn.num_vcn_inst > 1) {
                                ret =3D smu_cmn_send_smc_msg_with_param(smu=
, SMU_MSG_PowerUpVcn,
                                                                  0x10000, =
NULL);
                                if (ret)
                                        return ret;
                        }
                }

Regards,
Guchun

-----Original Message-----
From: Chen, Guchun=20
Sent: Thursday, October 21, 2021 9:14 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Koenig, Christian <Christ=
ian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <=
Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: limit VCN instance number to 1 for NAVY_FL=
OUNDER

Hi Alex,

No, it does not help.

adev->vcn.harvest_config is 0 after retrieving harvest info from VBIOS. Loo=
ks that harvest info in VBIOs does not reflect the case that VCN1 is power =
gated.

I checked several navy flounders SKUs, the observation is the same, so this=
 is likely a common case. Perhaps we need to check with VBIOS/SMU guys.

Regards,
Guchun

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>=20
Sent: Thursday, October 21, 2021 9:06 PM
To: Chen, Guchun <Guchun.Chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Koenig, Christian <Christ=
ian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <=
Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for NAVY_FL=
OUNDER

On Thu, Oct 21, 2021 at 3:15 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> VCN instance 1 is power gated permanently by SMU.
>
> Bug:=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl
> ab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1743&amp;data=3D04%7C01%7C
> guchun.chen%40amd.com%7Cda80a308a28049d543ad08d99493847d%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637704183581593964%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=3D2vNLj9bXE2oV97rxBiUOiaFNpKopVSJefL%2BMcQE%2BSfo%3D&
> amp;reserved=3D0
>
> Fixes: f6b6d7d6bc2d("drm/amdgpu/vcn: remove manual instance setting")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Doesn't this patch effectively do the same thing?
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fpatch%2F460329%2F&amp;data=3D04%7C01%7Cguchun.chen%40a=
md.com%7Cda80a308a28049d543ad08d99493847d%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637704183581593964%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DjPu3Yh%2B=
6OHR4F1BS5MWL3VyZ3pui6c0dP97Zl7yBJKY%3D&amp;reserved=3D0
Where else is num_vcn_inst used that it causes a problem?  Or is the VCN ha=
rvesting not set correctly on some navy flounders?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c=20
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index dbfd92984655..4848922667f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -103,6 +103,15 @@ static int vcn_v3_0_early_init(void *handle)
>                         adev->vcn.num_enc_rings =3D 0;
>                 else
>                         adev->vcn.num_enc_rings =3D 2;
> +
> +               /*
> +                * Fix ME.
> +                * VCN instance number is limited to 1 for below ASIC due=
 to
> +                * VCN instnace 1 is permanently power gated.
> +                */
> +               if ((adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, =
0, 0)) &&
> +                       (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(=
10, 3, 2)))
> +                       adev->vcn.num_vcn_inst =3D 1;
>         }
>
>         vcn_v3_0_set_dec_ring_funcs(adev);
> --
> 2.17.1
>
