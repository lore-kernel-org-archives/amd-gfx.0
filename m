Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B19C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 07:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6E710E11F;
	Tue,  2 Jan 2024 07:07:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46ECF10E11F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 07:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeJYfL2BtDI2KCczP2HqAwglxSWR6bzofYTAvQwtt7anfgTqaxSYYQK6j/LQbm8pa5huG/NN2dGIuItcTacWJNQXKuI6YWofKgJBJ7k30OxJxT4uwDF802VogNUL9oEFDI0SD4BL3fPQBnJbLEjOh8itI3F8Ij+0noWU/XywcPYQK4wNQNWtwGzsy38KGvTDDvEKz9/9CNJFgUW/21pHtA60ls2QyEHKh8Jo6pU4/qHDZ8kNNLXFikpnaTB+P6oh/gFkX1DOhuaDJFBMjtrZJN/ZQd2dltufcAGij5EHfeTWr0TFTQkK712dtFC+OgY3zIsIFrQIgjx26oPffWU8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fl06UPtK+pq0xyObFMbk6C8WvzPuNoyzzo4PmIokk0=;
 b=RlsAZjeRhPonon4Kv1EKLkI9N/mAkIN3vwM1yUIFYbGZEib4q4yntBdmMtMp/XHg9QTCNDcs6uQ0UnTiG5PcIOl/MI0ocQG88ZnDE42zUFjUP+VGR3OoidbIpnahNczs6aJtdSge0TOrtIUPCgLcF9qEapg/SblvaF+VKHAZxAQLzEhqulE583968s9qBmpKILZ9ak6JHgioyLXfDhOre/4pwqKDZPYC64GtSa3pJu0ZJuNqQ1Eq8ctE0AgVDjP+4O+j7pLOk4J1H3o/gLKcwVZseJV5iX74Lt8nxJhgqSfIG2lZhvsLJUhzM5mGGUn5vN6pR3Va4AB7T4MNz3WztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fl06UPtK+pq0xyObFMbk6C8WvzPuNoyzzo4PmIokk0=;
 b=JiOo4aR24WI111cPSD5VGQ7w9EuNkJN+whC4Br3PWu/7v8yukpIAwS51GYU0jT02zKrRTCWSanv9WOEzsu1jYtwZHCqXkYINEMVesL2Yl26MmdE12nphGXPezlN8xS6LhK/4LHN7UBt5iM/xN6CzHaj+aamj20CqZ3PiV1Tn1Ko=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 07:07:39 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 07:07:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Thread-Topic: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Thread-Index: AQHaPS35IdYNba+H4kiPq/eslIAH57DGFBwAgAAGG+A=
Date: Tue, 2 Jan 2024 07:07:39 +0000
Message-ID: <BN9PR12MB52577C0AE902E3C8835BF445FC61A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
 <20240102034341.16321-4-Hawking.Zhang@amd.com>
 <PH0PR12MB5404E107542E0272338B7D2DF661A@PH0PR12MB5404.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5404E107542E0272338B7D2DF661A@PH0PR12MB5404.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e5a43124-0c8b-428c-83d8-f9ce9122f86e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T06:41:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4322:EE_
x-ms-office365-filtering-correlation-id: 2d781f67-296b-43cb-0c01-08dc0b6181ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YKmP4UVehQ43HuRfVL86TtH+4zl4aezAUeetVzfq+5jYzD0S/Mp6yzSYKjrnNTRNdqygtF2xdmuL1DT1VvVu0jdRKH/DLI0UEf7Qd0xQhZVg0DclAnGXF5l/9LCjwP3GFpqVLZSZton0vOlAnVfth5Y1kG4XCSNiNJQLIvOmlXunUnNNw/gg5Wi4MzBFhFOL++wnjFhuCdBq3lyIDSNJ0H/viilAuRyRnvDvs2tbhynIYTYFEIrpD+n/y7Opww0tb9w4hSmkosLnyqlZcGUKGqSYN4gqGwQrWu2+UjtOYYtuyPckKaI3CoTuNv7JfP6FD1fVoGjjcgirVUNH+MBTjRmt6o0y2w5NmRHzojnYJ12zxXRx1T8lmqcoPev94TsyNdUAJiL/rIWHL6XpmpdADqWPE1voF3JiCzXWDT/e5Lh4VKbO0zZjd2CzmA25V9HaEGhrA0u+GGBs8s0gcHlm71DCKy1lSm5HeM4KWzvDnMjELgF8UJyqKkZYA0+ZkqA2ppZ1UZj0wtU5rs6sxHoJb+1WCP/Xp0ZlbG7/6wTkpHqNXVR9eSrfLd2dPzmcCPPFpuHPFsBzVrbKpbEQ+sJ5kwlWoTNikyOot9MrCgxHnD43y9/YKYLI1p511QxY2dfpN6i7djqSyAUW8bZVbCTMwg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39850400004)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(9686003)(83380400001)(53546011)(26005)(8936002)(41300700001)(5660300002)(8676002)(4326008)(52536014)(7696005)(2906002)(478600001)(66446008)(71200400001)(6506007)(66556008)(316002)(66476007)(122000001)(64756008)(6636002)(54906003)(66946007)(76116006)(110136005)(38070700009)(33656002)(86362001)(38100700002)(921011)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZypJxoe1Qs8VueoeeAD2QJCNK+TCytfa5gZJ7Cs8PkPyabMLRUqL3L/JxY0h?=
 =?us-ascii?Q?cfVfnY6h76XGlu2YGZoTuUNXkQ9PFL+sXik6MettdDRc7hPTYVMM28EGiT2V?=
 =?us-ascii?Q?U8KbJrHRKwUdn712BC4IWyZRXc0Po3nVW0IBhUVLj0ua5iQH+PgoDNMhUXYa?=
 =?us-ascii?Q?uL/ppZqgTnenBzEFY5SfK26SozyKQABi0h67oMXYmxb70iaT3iddsBHVNs6S?=
 =?us-ascii?Q?MhrndNV3pu/FGStkJ2yIpPkUMYXCBMpmImTLN2rcE7gGvKZ8OtaXt5CRYIdh?=
 =?us-ascii?Q?Ij41qvMwsVzL/bvzp7uyAVKkUgqk0jR50u+/gsfBFfctAqZFxPmcGBipqwu5?=
 =?us-ascii?Q?wMY1FfIJKeYyjVy8EMYDq+xoGO7Qh6zn065nlKVCBUw0sR6exci1NMnUwo5R?=
 =?us-ascii?Q?qZJaed8mEmclLAWjjSrmJLENHNeBRgkzOa8L2qxVIbLlADmAScb3BZ/VokeA?=
 =?us-ascii?Q?/dFpmedk+RWVxWMZoYuTNRmS1BcxwxLQyM5RvMs5Lf1LV23zyTWo0TkS9YWF?=
 =?us-ascii?Q?F+s4ISFmj9pxg669T4piiT4VtimiKRICPNDjebh0Db/W+LEO9tHFSSPt+jbK?=
 =?us-ascii?Q?vnskRZanwWV59HqiUe95QgEJgasndD09DFupgacJP63nyMJ6SpVSB+et1WG4?=
 =?us-ascii?Q?xWgPUGIPhtKUMGxx38Pm1h92JJ1El9wCR+cQnx7Vu9qZYQeI2AltQ/+UXiXD?=
 =?us-ascii?Q?uDUX8JPo114S1yUx2QyaWgp31sQyN1vaKToaT26Rkaka6Armgg4cf2q9qOUo?=
 =?us-ascii?Q?dK1dsSMWlcubrSquj+DxULt/F+y3CpQZ63hT+rKnGKJuZM7KBHc4TLqDDebj?=
 =?us-ascii?Q?R481d7Y/H3eYPXcY6dYi7CYsgaxY1gMRBIDhGDn5TUQ8SVlu0bWeu7KlkJl4?=
 =?us-ascii?Q?FQMWsbD7dv4wdia1pyt19cjPNywut17D5N2AyCW56gvz7P5b+fJM8e5UgQQi?=
 =?us-ascii?Q?5/UKSKgmLCQnoWB3XLvB0pSGHGY9f/hN3Xagh3MQx0f72eqEIsp9s50Ow9jC?=
 =?us-ascii?Q?KKjLWzv3epSk66kPIwXL6Syrp/zsBNUaCFZ6VA43yBnA42FBUXjaDDQXQBWw?=
 =?us-ascii?Q?bCFE+ofAtu+eqxM6AUZSTGklBpcY5a1mGm+SCArw1DeTQuJU4kfX4nRkZzPX?=
 =?us-ascii?Q?npKPteu54CFdOSAMR6qdEQm1s8exN/j3BIzsb9O9fEEqX+ExAq3rN8Y+JicM?=
 =?us-ascii?Q?gcXfmzGmet0+on9w73klTKKVQGQeA/LOygcY1TTp/la7GcZqyFOo4erM8R40?=
 =?us-ascii?Q?b3uSw9GT9GHvGvTXvxA1fbJptu/X7eMj9RH1J0vZpfChhRx7eRo8Ur60PDXv?=
 =?us-ascii?Q?B75qSgDpA3oQSbKEhwQyVVmi3qf4JTSAbwYZe9LqJgFhFpUj9yzbgs9N7x2T?=
 =?us-ascii?Q?uWc7vhP/RIzOsf7rSX98uPDLgiR1jhknlza35sVnojTvXmH4qY93Vu1VwQ4W?=
 =?us-ascii?Q?LsJ6S9G4KjrjVYJh1qyhwXIau1/ooQqvoxjlUGLsW/4IOfzaMYrUT3nRry9Z?=
 =?us-ascii?Q?tL7WMI6ejxlmV7uHM+jR23zCDgL/5F1jVJx7EHQigdgL8lI93HAklfB15wdd?=
 =?us-ascii?Q?RK+YUNQ2u+oHBMLs9pU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d781f67-296b-43cb-0c01-08dc0b6181ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 07:07:39.5345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vsyf5MWOCM4U8N+wmO2uhOyAzJvqOktNZP1+y8TYnwy1SL1ZnAs1g42CXTGlzNewtTJGJaVqR3cEXb/LVQMTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Good point, Le, will switch to the existing helper for the cross die access=
 in v2.

Regards,
Hawking

-----Original Message-----
From: Ma, Le <Le.Ma@amd.com>
Sent: Tuesday, January 2, 2024 14:45
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Li, Candice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors

[AMD Official Use Only - General]

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, January 2, 2024 11:44 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le
> <Le.Ma@amd.com>
> Subject: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
>
> Add ras helper function to query boot time gpu errors.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |
> 15 +++-
>  3 files changed, 112 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616b6c911767..db44ec857a31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1328,6 +1328,9 @@ int emu_soc_asic_init(struct amdgpu_device
> *adev);  #define WREG32_FIELD_OFFSET(reg, offset, field, val) \
>       WREG32(mm##reg + offset, (RREG32(mm##reg + offset) &
> ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
>
> +#define AMDGPU_SMN_TARGET_AID(x) ((u64)(x) << 32) #define
> +AMDGPU_SMN_CROSS_AID (1ULL << 34) #define AMDGPU_GET_REG_FIELD(x,
> h, l)
> +(((x) & GENMASK_ULL(h, l)) >> (l))
>  /*
>   * BIOS helpers.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 39399d0f2ce5..5f302b7693b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3764,3 +3764,98 @@ int amdgpu_ras_error_statistic_ce_count(struct
> ras_err_data *err_data,
>
>       return 0;
>  }
> +
> +#define mmMP0_SMN_C2PMSG_92  0x1609C
> +#define mmMP0_SMN_C2PMSG_126 0x160BE
> +static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device
> *adev,
> +                                              u32 instance, u32
> +boot_error) {
> +     u32 socket_id, aid_id, hbm_id;
> +     u32 reg_data;
> +     u64 reg_addr;
> +
> +     socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
> +     aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
> +     hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
> +
> +     if (instance)
> +             reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2) +
> +                        AMDGPU_SMN_TARGET_AID(instance) +
> +                        AMDGPU_SMN_CROSS_AID;
Hi Hawking,

We have asic function "aqua_vanjaram_encode_ext_smn_addressing" for this st=
uff, maybe it could also be re-used here.

Thanks.
> +     else
> +             reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2);
> +
> +     reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
> +     dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed,
> + fw
> status is 0x%x\n",
> +             socket_id, aid_id, reg_data);
> +
> +     if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d,
> + memory
> training failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, firmware load
> + failed
> at boot time\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, wafl link
> + training
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, xgmi link
> + training
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, usr cp link
> + training
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, usr dp link
> + training
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm
> memory test failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm
> + bist
> test failed\n",
> +                      socket_id, aid_id, hbm_id); }
> +
> +static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
> +                                          u32 instance, u32 *boot_error)=
 {
> +     u32 reg_addr;
> +     u32 reg_data;
> +     int retry_loop;
> +
> +     if (instance)
> +             reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
> +                        AMDGPU_SMN_TARGET_AID(instance) +
> +                        AMDGPU_SMN_CROSS_AID;
> +     else
> +             reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2);
> +
> +     for (retry_loop =3D 0; retry_loop < 1000; retry_loop++) {
> +             reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
> +             if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
> +                     *boot_error =3D reg_data;
> +                     return 0;
> +             }
> +             msleep(1);
> +     }
> +
> +     *boot_error =3D reg_data;
> +     return -ETIME;
> +}
> +
> +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> +num_instances) {
> +     u32 boot_error =3D 0;
> +     u32 i;
> +
> +     for (i =3D 0; i < num_instances; i++) {
> +             if (amdgpu_ras_wait_for_boot_complete(adev, i, &boot_error)=
)
> +                     amdgpu_ras_boot_time_error_reporting(adev, i,
> boot_error);
> +     }
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 76fb85628716..5785b705c692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -32,6 +32,19 @@
>
>  struct amdgpu_iv_entry;
>
> +#define AMDGPU_RAS_GPU_ERR_MEM_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 0, 0)
> +#define AMDGPU_RAS_GPU_ERR_FW_LOAD(x)
>       AMDGPU_GET_REG_FIELD(x, 1, 1)
> +#define AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 2, 2)
> +#define AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 3, 3)
> +#define AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 4, 4)
> +#define AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 5, 5)
> +#define AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 6, 6)
> +#define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 7, 7)
> +#define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 10, 8)
> +#define AMDGPU_RAS_GPU_ERR_AID_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 12, 11)
> +#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 13, 13)
> +#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)
>       AMDGPU_GET_REG_FIELD(x, 31, 31)
> +
>  #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS                (0x1 << 0)
>  /* position of instance value in sub_block_index of
>   * ta_ras_trigger_error_input, the sub block uses lower 12 bits @@
> -818,5
> +831,5 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data
> *err_data,  int amdgpu_ras_error_statistic_ue_count(struct
> ras_err_data *err_data,
>               struct amdgpu_smuio_mcm_config_info *mcm_info,
>               struct ras_err_addr *err_addr, u64 count);
> -
> +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> +num_instances);
>  #endif
> --
> 2.17.1


