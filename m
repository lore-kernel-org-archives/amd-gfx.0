Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDB9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A6310E1B6;
	Fri, 10 Nov 2023 19:07:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9749C10E1B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ppw4GmI1vMxzwk4g7g5IAwjUBzy27LliSlcsjNN9nNd4kd6b5LQYoL2o5BCSZ8LYAMiqMMGgtKO6fXoEOeN0kdEpISJr4U2xFBuUCikmXZM7kMpprPDHE+WOgq7ydEl0sNkzP317v4K0Hv2xDy1H2XgCk7fNLVhoeJQbAGdGYlht/SWI4QFs3H9vXlMv02iCM1ivvD0eTr7yU2A9m8YlHLLH0kg4vntDP0J1JGv3q4u6zVspuxokG2TBPHwXizpLUJPQxE3MDNGdn0DwauZGUCsBslmhbtu5HoX3M9uIlsa4qTOMnFq94dDphz7JZleQ1ctlbfjcQKn8PMvz4y73Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyrAMZ5q8mRh/4qF9KFWvLBBtS37WkFEJ0J3LAqaUn0=;
 b=Pg6wbbC6Zf4xAsyAsl8xmftbE1BZilwcViicNAFW5yX53Vmk0+2BH6/1UoPwNCML+56TH4bpQyq6A2l6QMGboh3LrK3d3tRs0d72sf9lD/q+nb4I57ogQzthnRKFLJo6AoT3kjK5z9M8PnZZgxsIsG32oSRUuJWd+55L9PLLcLqpaIMb964LNLleaX2qELdqx3I9PZOfZk6BlJr6BIhL+d4RuWfsaL10AysXETOeLgW+wazsT02kVF58IhRDbZg2ZvjZnxh8TkFbu0hGtizL5NPf5DBI1Ade97zOvLwnQvNeSUGdJcZY7mTLmtpp21zjhkQXn7vAWs31VmnvYCYf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyrAMZ5q8mRh/4qF9KFWvLBBtS37WkFEJ0J3LAqaUn0=;
 b=pzwbNxyeoh8CEsj4SphLFi/LOO4uwHhIKvqqgYTrJmbeAqXBogp4j5Fml2hJhwlkNV6xCz6RZne3P6OoL6Y1d797GQsRGDnvfpvPP8GPXJJWvXENf55Ayxl0Ph7iQFjgGOFyix8iEPCK6ogV1nAFQFMdhaCHlOpfTyBtwyp6570=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 19:07:26 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:07:26 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 13/24] drm/amdgpu: add sq host trap status check
Thread-Topic: [PATCH 13/24] drm/amdgpu: add sq host trap status check
Thread-Index: AQHaDldZ5dHYa+hBnkKOJsBMGM188bBzxE8A
Date: Fri, 10 Nov 2023 19:07:26 +0000
Message-ID: <DM6PR12MB50213DBB95A1EC1FB4C45A9F95AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-14-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-14-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=556e86e0-395d-4ac1-98f6-3db1c1fa11f1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T16:11:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|SA1PR12MB8721:EE_
x-ms-office365-filtering-correlation-id: 94495d01-1076-419e-d0ee-08dbe2204762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yRlTUqr6DAtSPlUH2sADnftLsXs5S2nnHgxHJtQob+hTmIho5ErfWLdQSKGlr7TN/sGDhJ2ficHC88pZSr7hchh3wu+HYqXxRHksPdSZdP6R/VCIA+azr0WRcH5TUaqZHVm97CzsWU6j94eBrMp4Nfq6ccbV3W1AAGxgtkHGdbAFOiRelLLXzyFYD641/TQa/VjYxYvmbzXOOxssnejhpoM3C3MPEP/EJtATcA95Q9wTJYsW73v845+fSkT5JoHtzEcMrM9361O/u7U2kr0qGay0DZVUXiMP7TF+Grz97SF/kA6ojlaNOrzh+EVGgqTu6foI9NeKO0VNARRHixjYql3tIxl4BCHstaSikOZ4NQfIhCgpojGm5aKqhNFtqe1ZjUE88l+pzy0WY9friJWIckc3SAJj55VGEJbJ8vaqZ7wWtY0hLhXRaMh+pPBPzNbUmfcV8zWsBVW1fPqKTG3UyYU7UB5bXJtfFBGen2Wdl70ug/T86/63bKre3JgrtM5PQQTN7ADhf+rj87lziPRklTWlE4N5VtgHSQVFE63ifuoNc63jD8mVGhq564ee0eCqaaBMKBjcSfPeqtjJ5JmIw6BNov4/CSemHEPxuBhvYflYwVnjI96yML65XL4JFxMne4JIWWZ5ibQFWWlIJtp75SEiRMQwLxWuo25VHpN9m7U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(451199024)(64100799003)(33656002)(38070700009)(8936002)(83380400001)(316002)(26005)(66476007)(66446008)(64756008)(76116006)(66946007)(54906003)(110136005)(66556008)(2906002)(52536014)(4326008)(55016003)(5660300002)(478600001)(53546011)(8676002)(71200400001)(7696005)(6506007)(9686003)(122000001)(38100700002)(86362001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZgJLYXe9eG/JYl7kdp+yaubfDIJB+j4a8vexe0JzfgrZFkQh6ighNcfFUNE2?=
 =?us-ascii?Q?vlMJuZYpvqq9P+QdWSAh9PODTx4BCxNO4mwfmxixZsJHaaT6jWWOEN4I6ovb?=
 =?us-ascii?Q?0XJ6RJ6hJCWq5s5n2o98YL5Crl2R7t69Kfan8PfUEHF7JW55Ij/X7MhDIAJW?=
 =?us-ascii?Q?IVqpRd5w7un+D1VPA7fmQdwKgQkqcBynHDTTu8qnmD8TZmqcwbufwE+jJW9T?=
 =?us-ascii?Q?5aSLXU0QaqAzNlJ59eDMbk0QZwA1gyxY1GC3gU+boZLfhErnNsbWLdn3amu+?=
 =?us-ascii?Q?KlfNIlM7GWEDNmuxG4JiXoI/CS4MhK26sQcgMWmYqdIRyUJH+L1u+1TrMOKM?=
 =?us-ascii?Q?VKHJZRKdN4ZQZS43THZPey7Q88yLH6P3wjFKXWFNcBpN6rIYdjeNxNqVeY0i?=
 =?us-ascii?Q?AZG5BHhpeYrge3OXYwkMoF7ux2hS+Mkif8uKuiSq4BK5SUVaNIsJ4gMEOFtV?=
 =?us-ascii?Q?k/BxvJFkiC1LAkhBm8lQUb1qYeX1UQ3G/dngG7SMIQSbypHIwRXm0bCBXLZJ?=
 =?us-ascii?Q?A35rC1TxC3ODAf/Bc56quGoiFTakrn8D9xQ/pZ1MiuvCeBEsOggKVkLBNWXw?=
 =?us-ascii?Q?Ee5ArkdEJ7aLbULMyxa1C4X4v9R3CBILbgNS5zv5QnlF8Jyu/tDw7BmmsRAa?=
 =?us-ascii?Q?6rln/9n/EZabcGm7N7mQMb/X3lStbiv/jGR/RpGmi1CfORPGqbBJeVoIPHCa?=
 =?us-ascii?Q?ZjvwlAznqnuPCwTRlcgedyHN16BBS2OSt1UvlG5MjVU1ZAUo/raPsivCnnAq?=
 =?us-ascii?Q?EMC13YpYVyx1lOACy7mz6O9gE1RREldFMHTpYT1zh3W1UDdMgxzFw+BCc8D0?=
 =?us-ascii?Q?glqlCnjTcwW/iVISNt/HoLEeOMg3dmuTuI7zrSGtTr7R7s+FsP8oUwyEaI1U?=
 =?us-ascii?Q?uEKqVBn3pcNbkysViwLq3hXeSI18BVEyLqTD3cQOIJ2SHVSJypIDQ1XsjCTy?=
 =?us-ascii?Q?6kSt5eWUSn2EHrUnPcL5n9W2PtPxeGwyFuBdd4P1rr+PlZlQHYXlb6lnjdWZ?=
 =?us-ascii?Q?k6bm8AUr52FCjZMCypBd78jOriheQR8STpAPJq5uMxpNkrCyA+8p0xcQ7ZYG?=
 =?us-ascii?Q?kLyydToqT5m8pAbzveb+4hgPvkLTNXAdD+NM2EgxO3JyVwnd/sD7DCFkrb85?=
 =?us-ascii?Q?tgq79yQjv/bYG75EIhzXWlp4+y0lzpitT8XjfGRqdLflwqGdm+TkzzgPKQPI?=
 =?us-ascii?Q?RqmrM0LZdOUHhbipdZPNq/ys0xU6Too+Y+s8ZpIaU4kKZw8sxl9YS1wmq9to?=
 =?us-ascii?Q?VoJX6Pv7ESnGlvJEqG/s0UBf/ogMkRCveaTA4w1cm5DUwyN4GypTSSJ9pBRy?=
 =?us-ascii?Q?cPSepvZJ+yxAtQSWLwbqgqW4fEGU8iAgg4K1v+jwy991NvtWY7+VZ79fCONA?=
 =?us-ascii?Q?kR2g7MZkZgdgiIAhpbWo8ymR6ZYuLCkLh28vVWSP3vxm1UApujzEtjmhLlD7?=
 =?us-ascii?Q?cyCpOX4Pt3p1VoZiXJ1i2+aPkUIob2tgC/dqJaOby7Ec8o8r4pdMhU3UNFG5?=
 =?us-ascii?Q?e25cZubAYpZ1Z4ZtkJrUFPDyWaIDVd5f6uAz83jLpNyj8lXY8Ig87u8IujqS?=
 =?us-ascii?Q?oMjM9kXrlJYWHROAeWM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94495d01-1076-419e-d0ee-08dbe2204762
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:07:26.7124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dg/B8fEas/gTP8LZ5flV+zFs/0BEKqrUOULG8WHmoQ5iwTWepTK3bRVI7400rbvs+V4FdigjPrfhNdZXg6Qpbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Friday, November 3, 2023 9:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
> James <James.Zhu@amd.com>
> Subject: [PATCH 13/24] drm/amdgpu: add sq host trap status check
>
> Before fire a new host trap, check the host trap status.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 35
> +++++++++++++++++++
>  .../amd/include/asic_reg/gc/gc_9_0_offset.h   |  2 ++
>  .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |  5 +++
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 740d8a0c9252..2c5bbbb7e34e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1146,6 +1146,35 @@ void
> kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
>       kgd_gfx_v9_unlock_srbm(adev, inst);
>  }
>
> +static uint32_t kgd_aldebaran_get_hosttrap_status(struct amdgpu_device
> +*adev) {
> +     uint32_t sq_hosttrap_status;
Initialize to 0. Some static code analyzers may raise warning because it is=
 possible to return an uninitialized value.

Regards,
David

> +     int i, j;
> +
> +     mutex_lock(&adev->grbm_idx_mutex);
> +     for (i =3D 0; i < adev->gfx.config.max_shader_engines; i++) {
> +             for (j =3D 0; j < adev->gfx.config.max_sh_per_se; j++) {
> +                     amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff, 0);
> +                     sq_hosttrap_status =3D RREG32_SOC15(GC, 0,
> mmSQ_HOSTTRAP_STATUS);
> +
> +                     if (sq_hosttrap_status &
> SQ_HOSTTRAP_STATUS__HTPENDING_OVERRIDE_MASK) {
> +                             WREG32_SOC15(GC, 0,
> mmSQ_HOSTTRAP_STATUS,
> +
>       SQ_HOSTTRAP_STATUS__HTPENDING_OVERRIDE_MASK);
> +                             sq_hosttrap_status =3D 0x0;
> +                             continue;
> +                     }
> +                     if (sq_hosttrap_status)
> +                             goto out;
> +             }
> +     }
> +
> +out:
> +     amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> 0);
> +     mutex_unlock(&adev->grbm_idx_mutex);
> +
> +     return sq_hosttrap_status;
> +}
> +
>  uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
>                                           uint32_t vmid,
>                                           uint32_t max_wave_slot,
> @@ -1156,6 +1185,12 @@ uint32_t
> kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,  {
>       if (method =3D=3D KFD_IOCTL_PCS_METHOD_HOSTTRAP) {
>               uint32_t value =3D 0;
> +             uint32_t sq_hosttrap_status;
> +
> +             sq_hosttrap_status =3D kgd_aldebaran_get_hosttrap_status(ad=
ev);
> +             /* skip when last host trap request is still pending to com=
plete
> */
> +             if (sq_hosttrap_status)
> +                     return 0;
>
>               value =3D REG_SET_FIELD(value, SQ_CMD, CMD,
> SQ_IND_CMD_CMD_TRAP);
>               value =3D REG_SET_FIELD(value, SQ_CMD, MODE,
> SQ_IND_CMD_MODE_SINGLE); diff --git
> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
> index 12d451e5475b..5b17d9066452 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
> @@ -462,6 +462,8 @@
>  #define mmSQ_IND_DATA_BASE_IDX
> 0
>  #define mmSQ_CMD                                                        =
                               0x037b
>  #define mmSQ_CMD_BASE_IDX                                               =
                               0
> +#define mmSQ_HOSTTRAP_STATUS
> 0x0376
> +#define mmSQ_HOSTTRAP_STATUS_BASE_IDX
> 0
>  #define mmSQ_TIME_HI                                                    =
                               0x037c
>  #define mmSQ_TIME_HI_BASE_IDX                                           =
                               0
>  #define mmSQ_TIME_LO
> 0x037d
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> index efc16ddf274a..3dfe4ab31421 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> @@ -2616,6 +2616,11 @@
>  //SQ_CMD_TIMESTAMP
>  #define SQ_CMD_TIMESTAMP__TIMESTAMP__SHIFT
> 0x0
>  #define SQ_CMD_TIMESTAMP__TIMESTAMP_MASK
> 0x000000FFL
> +//SQ_HOSTTRAP_STATUS
> +#define SQ_HOSTTRAP_STATUS__HTPENDINGCOUNT__SHIFT
> 0x0
> +#define SQ_HOSTTRAP_STATUS__HTPENDING_OVERRIDE__SHIFT
> 0x8
> +#define SQ_HOSTTRAP_STATUS__HTPENDINGCOUNT_MASK
> 0x000000FFL
> +#define SQ_HOSTTRAP_STATUS__HTPENDING_OVERRIDE_MASK
> 0x00000100L
>  //SQ_IND_INDEX
>  #define SQ_IND_INDEX__WAVE_ID__SHIFT
> 0x0
>  #define SQ_IND_INDEX__SIMD_ID__SHIFT
> 0x4
> --
> 2.25.1

