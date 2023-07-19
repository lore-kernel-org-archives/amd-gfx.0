Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F6CC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 05:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D229F10E184;
	Wed, 19 Jul 2023 05:10:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA4410E184
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 05:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXFnleTbzn1uFAwXCkchmbU1IUDslK4NdXXDRCcktk9Gk8KzPALQb/F0l5CA7B/3IIDYr/FDG+sknQxE2yzsMl7BVDyZMkwwcs/3Hu4e30/PdX6U8ak5trZdjNUgPhHdMt5sVi5DEMBEoHSszRVrhZP1u45cM1ntZg+ei2Z6KEfNoTH4ylTs3lGucvCj2ShkIWHXL5R3ADQTxen/PiC0UVVwplrwxoYSb1mlOVlzHpis9uKvPzOa2ISi450CLD7pXR+tZBR9kVeQKilqMwvqAVVRl0wlIXGRDH6DXiHSO6rwLG1LAcpshjxZSXRnuDK9hoa3Z9ls9C6H6cs+/Iz21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQsr9wfx1LUHiVikSMzf3Qyc0u3TyWcb7MkZDT4C2f0=;
 b=CqnDnXZXp87st8Bsh8egx52QdgE1gla2eNwjK2qYXf4unJN6icDh42ICzC2v6Hmxq5WrpkzS83yzj0spvTntv2luSP1e3RBZDHlgjfhxNX3vbI7z1vdLWV2DeNAq1MgMESpkkCqJoIeTBnuGzvMILQkvkDBhB7ZCATtI6p3IV592Y8lbT1fpFU15ijC1UHpkKnpgFY1AAAlWcvCG4e6T/kbYyFSrCtFPpX0iK0cL1v8orb6sY0aNRuzMuMMNewHM2J/pNxkj5lTypH1q0OvYhgW5/B5rI6ixygxambUlFu32sQPLZGpMKaARzXAZgeJmyA6mvA/QOQfwIFQBVaW7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQsr9wfx1LUHiVikSMzf3Qyc0u3TyWcb7MkZDT4C2f0=;
 b=01CdCfS2IQXsuqkKo4sDkwNLleO7vwD45ua/Ej/e+6XkQoHIYN4FAfJYDrlVHGLQ4vJ0heLDrS7lT0u5zLvz7S+r0HPi7bztWCLRJoLSQ5MxDjbOsdsIFHn3ouMn0kSuZtG4vcSVNFKToda8ldKsxdo8wlm4zwYATB7Lec/Jjak=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 05:10:37 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::7794:8bfc:194d:583f]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::7794:8bfc:194d:583f%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 05:10:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update sched.ready within kernel drm scheduler
Thread-Topic: [PATCH] drm/amdgpu: update sched.ready within kernel drm
 scheduler
Thread-Index: AQHZufzQcPVgijIaf0y/LSKcdeM+U6/AipWQ
Date: Wed, 19 Jul 2023 05:10:36 +0000
Message-ID: <BL0PR12MB246573E82242E33B84C1B577F139A@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20230719045204.789223-1-guchun.chen@amd.com>
In-Reply-To: <20230719045204.789223-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5935ae96-a7a4-41e6-adbb-8efae7bc7d8d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-19T05:10:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2465:EE_|BL1PR12MB5827:EE_
x-ms-office365-filtering-correlation-id: 652e1476-abba-407e-039c-08db88167cda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoLECYmvF6IWWMG0/9zZmaG3ijPv95py8nbw8HX2Lw35ZvWhhBk5ZN2yUU+NX+X044FtrEXyLvDKLYl44MJ/a5GgDUVn8GFpUnHTFROjX8uKoA6US6b7eV2Z3g0uUlUDfqiLmd+W9ScwchtykmzZQcmANmx2BxakkH6QRRgq0JBFyjkKB9QIBrvzxKTSvtJozinCCMft8yEzEGSBqGavOL0K4xeduK72ZfGcJtRzslS/gJzgkQ8FhOd6bTFQ9D6kmNey40/0X4scm0qwNC6g1MHSfp/ImSivpHAhjIKL+73W7trq7/h7HolKEPVYCxdCHTKaxzDEych4BBsJiXulWTjnSt7zKTUHLAV1JsfOr+J7etIvqpFGM5WYjkMMnFKaZsjM0lfcLM4y9wjBgA/5Zjm2vPzfbK860XJrO+q6GHPmwDQee+1EvYj6cqiNiFO4EJchI+Z/QsjZJgIZX2zeeoooDE9CAz/sBDF9H2KCfmfwIW3QCUOsHSfFRfd6JLWpEsjQkggnoP5Ch1WNr5vF+WkNS1xdntSZcMg3DceZxa7lSgWdai2jlj0s1uYEh/npuPKevL3pws/abBXXptcxGb2zKQ6QxK+y7Iufs5Qt4yRagZKrvcsFpZuxE5D5dQsN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(15650500001)(110136005)(122000001)(55016003)(71200400001)(7696005)(66476007)(478600001)(33656002)(52536014)(2906002)(8676002)(8936002)(86362001)(38070700005)(5660300002)(66556008)(6636002)(38100700002)(66446008)(76116006)(64756008)(66946007)(316002)(41300700001)(6506007)(26005)(53546011)(83380400001)(186003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HOSrKEJVEFpN9xoPiTUd/XUov9+LPgarFVJcnZ0a5K/uA7lkmuWyHroIrYtS?=
 =?us-ascii?Q?IV42fAexN7npTHgoSo2U/MaEBshcBOf8OHekRSOoASVAGJEewo0gmmqnuwor?=
 =?us-ascii?Q?wlxWgTLBzr0FX9Z7alq+v3QA9TYsLW+xaRdaMg9gHqGjrgutS3E4m/LYBptO?=
 =?us-ascii?Q?+c2/8j3iVTUPvjzGCLVL2gfAvfrlhsmUcZ4ZMF7rs0791oFbvrFkV+4taO1l?=
 =?us-ascii?Q?/3DKS6g/zJesBO9Tkq87asZTIM92zv2qRyTvMTGzQMEEv+IhluMngmGOOoSj?=
 =?us-ascii?Q?FTz3d9xqpjvpaCVQJ4I7B93NXPSpA1n6T3jhEjK1uj5dsgJCNRQX6r1qys1Z?=
 =?us-ascii?Q?bb4vD6A1WN7K+2og1ja3m3G3S9yQBOLWYBSY3R5m93UrwtkGeAffiX1WYlGF?=
 =?us-ascii?Q?vA2fLqyNlDJ+tmhA+pHgH0KdZgQC9jOyOA5dWP00bcQDVniO0ZdgqvOEBT8n?=
 =?us-ascii?Q?opffRNAUh4cUcesMBcJAkGpTatWbdCE6z/GrV++7vxURvR2lVJmD98vd+2Ms?=
 =?us-ascii?Q?JRVevxeZQYpaL7IKH/KToNcMUQVAnInZgIpzxtEd2CqHhUKEYTmr7jddAxvp?=
 =?us-ascii?Q?O4nwzlwu7BOmBZW2dpm/jjZTDB34+QNHiHkLXXTuyx6YbOCWXlGh0uXISpXI?=
 =?us-ascii?Q?q365uNYWNXwAEc8SmrTLoUPh8wtZPW7U/3AGzn+wDyroSKZTsVEamdq/BnnI?=
 =?us-ascii?Q?KwiYmckDkdI5i8pnDUhQ6M2lPeYxo/R3BRghagcTohRxKjasn+hJOhvdDn/m?=
 =?us-ascii?Q?1PX63vVjiilN2g/HR0WPoK2AaNoicTm9F1evAiA7KDf3WnPuQYyRAAXJSnSn?=
 =?us-ascii?Q?06skK+lGHDGGwUef7bI3XKRrWjff8Dq3rGbm/bo00qrhjElpJ6PJoGK3kD5X?=
 =?us-ascii?Q?GCGTBbrs6Q3CUfwMgiPukFH9FA/r7kd+hA6zuHMETdBrNmv71SBx4Ra1TYeg?=
 =?us-ascii?Q?UE2YotuLkYVzC7XGz3u4MnnXnJNvfpAmQ7Fp5Zc7OpCR8tCC7LrEFQ3Ju+1g?=
 =?us-ascii?Q?yyBnPQM5mMRGaY4u32V2BdwfqptLcHD5ELnh09ER1V0j62nAjEvs7VNfnGJB?=
 =?us-ascii?Q?ecBogV8mvigDjYiiIn6MOPim9ku/4/K7QRuHM14lK8AozItUDbP1HPmNRvg0?=
 =?us-ascii?Q?owaH/+dvN0RW8R2+RvIqyDhE86nobSpjuNe11OmRXzZ/g5eeZAelbvDyS0gQ?=
 =?us-ascii?Q?Ez+JMoAJgmoXTX74jdbAkFp/TCK9oqO+wsTpyEDAdqvZZTb/JaPptyp3Bhmf?=
 =?us-ascii?Q?dx9n67cJRvSxLG3BAdRvVumHvcZxb/mgRsMxj58tRcXHb5vVffaAyhU2Y2mX?=
 =?us-ascii?Q?1xzB/E2/k1urTf7gVCx7Tby6NY1ZzesSzEN6x6fPYbepKMvcZPe+qVp9aVQb?=
 =?us-ascii?Q?tbtQgm+NbrCVmP0K+mnL2qv4JSQP6gJCoPUmXDCo1dso4MfybjCb3IQyiQY6?=
 =?us-ascii?Q?123Oe3/uc7r/Kshm4yj6dge9POvZYfhTYTaPt/FV5Md1ib9dNKsxQFExv7s7?=
 =?us-ascii?Q?dEd5MFzRG22fcfz4scdvIKh0ttioGevjoSp9FFSdfuR0DqhD6zuMAgKg7uMi?=
 =?us-ascii?Q?J09wRMMVAL6iZdVXEaA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652e1476-abba-407e-039c-08db88167cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 05:10:36.7954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSJXUkVVLtfoHpE8wD743O2HV5RKY3iYM+UcPDcrZt7DrI16ThTdlxIOSMSIQYGiTqB0neK0t49kbGfDCoYHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
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

[Public]

Please ignore this patch, will send another one after more rework is done.

Regards,
Guchun

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, July 19, 2023 12:52 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: update sched.ready within kernel drm
> scheduler
>
> amdgpu_test_ring_helper will set sched.ready unconditionally based on rin=
g
> test result, this will lead value mismatch between
> ring->sched.ready and no_scheduler for those rings without a kernel
> scheluer, after they perform ring test. This will be confused as kernel r=
ing
> no_scheduler is true, but ring->sched.ready is true as well.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 80d6e132e409..afa76d069d94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -630,7 +630,9 @@ int amdgpu_ring_test_helper(struct amdgpu_ring
> *ring)
>               DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
>                             ring->name);
>
> -     ring->sched.ready =3D !r;
> +     /* Only set sched.ready on top of kernel scheduler. */
> +     if (!ring->no_scheduler)
> +             ring->sched.ready =3D !r;
>       return r;
>  }
>
> --
> 2.25.1

