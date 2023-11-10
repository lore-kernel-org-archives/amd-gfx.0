Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C90C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4357A10E1D7;
	Fri, 10 Nov 2023 19:08:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6A810E1D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXC0LseuKzpxr9+JkHRYWs3XzM4hMlOizZz87wHAWXbZjPvB1nTXmEj4ePQXRUO4AjWFu8tmiY2sHldj7fLAi9oGQf6gJO40WNwVrozIHUgTIDDmUeF4jCASSVlVegfB2mde1VsVNrc6CR2vOu8NVGjQbgbm8JgJlQyyV51gxhXM792aEoyPnM2GHhC9orslXygS2R/dluffb7J1n2wZ1BuuwEB1e2/AlCwX77CyKl6+o0s3z4eShoBY3FOz6bKLEtdq5Ez2iIeQ1+r9k9VpIIH0XrA0aX6TiNnkuSxkeXpCc8Gp865QTJBOMQHwpedA1IQmCLYmlmxc1Q44p7fUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCqZetQ81MkMhhrp5mlPGyTTL8ZA2MTUAOpokUlblUU=;
 b=Bq36hUycmbv1pT6tZejtVZgdJ7yb71s6wYALYq/GCob/U9XIDA6s3/YGFFcUup3Ew3lgMQwdqIs9OxPCrbtiGgDukB+DVhI3iuNknGAyu95QvtGbcXrHZRJauU6T3fYHoqMTIFwPEtApqXSdObkklItnym+juE+KfJlrbLnNEWChDma5kLuWGfbUki5olY7qbVlVJs6Zc5Yugg4KwytVGlJn91XmbIVea9lkYcmxWFClHTdyoZUcasEwOsD3ZcQu0zH/gUgoXHWjOd7yiPVit4im7qc32XXk3MH8+zh1Veow1x4tf8GumZ81ulqkjhp9QS0849tU4SMyjrH407bUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCqZetQ81MkMhhrp5mlPGyTTL8ZA2MTUAOpokUlblUU=;
 b=Kao0Bzgailww8QIQbcbrkenq08skZ9Sq7flTDlcwCpIrS7ZUha52jTz5zs4UgNgla1twq2mN90Za+cvO+41sXXuXHhde6cVZZXdaLeDbHOMPafu199tdoHNxxfGaBK7AW+zifQG+K/+MRIQPoCKhUCK/13Haa9JX6pPMroHIq5s=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 19:08:50 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:08:50 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 10/24] drm/amdkfd: trigger pc sampling trap for gfx v9
Thread-Topic: [PATCH 10/24] drm/amdkfd: trigger pc sampling trap for gfx v9
Thread-Index: AQHaDldYzONro2nC606LAZqlWlAKtLBzvcKg
Date: Fri, 10 Nov 2023 19:08:50 +0000
Message-ID: <DM6PR12MB502177F97B6EE8DEAB3F4F4895AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-11-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-11-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8f61831b-5e10-4e77-a49e-522f80efe723;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T15:47:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|CH2PR12MB4311:EE_
x-ms-office365-filtering-correlation-id: 9d6e5671-733f-45bc-7ef9-08dbe220798a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7f+9aG2FKyVpBRvFsj8g3JjPG/VvK+WdAPVh80SNcpeIW61Emvda/8l1tGecflm4nILdy7wTwAcxYmENKFEFSv/RuywD70EFcySP/yXucQTDr9kfOHYViZFUMNcHLBohJF3W0JUtFTIEZqyxpNoCT0eI6q9rVlfKSzJ7HosFNkLQbUYbeXiEWZFJASH5Sp5WPbdWQs/ozJaysgeSl5X+ChoZj/Joj2jolGrjeY1tNyqNbRXxrJUaLnmtDm5gTKwt5k2AhpCAs8ivydBNuJqVdKBMkyOWAJHD/B+dg0pZWFBUOM69fpHAivVYbZ4eFMBpeJvRDtPv8yJvZoU8cgUj8McxQCXkYUwZFywgbAnb5oVANKgScM9dvv1/xSls0iDm9WDrS5QyfcFQ+5oDjQRn51h4fU1HAZ3r4YbILS5MFGNMeyQFSo8s9KCmLXt3SQgb9u6GTokVKmDHcmBaLPPeO/sJ9O/5c2lPxBNeabtw44oHQ7oyKoCMrdPGcgKWJ1yseQ/1BHKFbDCpgD0AlBKFdK/EWTnqdmCyNntPlSRplVTbXccBUuj7sHpYpgETR2flQwrER7MZE3r/N/WlID8+XgiW0/F24Y43JFH0/mdbZrSS/XOuRnwDimOyFbRuXxG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(110136005)(8676002)(478600001)(52536014)(4326008)(8936002)(55016003)(83380400001)(6506007)(53546011)(5660300002)(76116006)(66476007)(64756008)(54906003)(26005)(316002)(66446008)(66556008)(71200400001)(41300700001)(66946007)(2906002)(122000001)(86362001)(38100700002)(7696005)(33656002)(38070700009)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HGSoKXSMwIYvLBzYmgJiESh4xXLmNDNQh4wgSwXxkkF9bSaF9KsVmt4xUS8k?=
 =?us-ascii?Q?igrhgvqtQOtvGJ3Xs64llKDfjlFL39qThuGZ5k4AXgU5a4VkhL/lIUkl62qV?=
 =?us-ascii?Q?0iRlqafypXCjiQNe/TlaJkRdxM1pjipr634g+i+pz8NDbjwjcgg+BMSlhAnJ?=
 =?us-ascii?Q?IonOtslRyYzPJBNgUeN9NqtNPXvp+FaINvFBCVvj/Xw3VGsAbxK2GQDcWCXV?=
 =?us-ascii?Q?TzeVwge/f+o+oHAl2OqEi7XyqW76tqJy9Ug7UGlNlyynE3Hutw5/BG+z/4hL?=
 =?us-ascii?Q?cubYaDFtocYJrFKISAZrJvM1uFjt2JGEl3oGel2ajMWb4Oa49LEyGvLbFroI?=
 =?us-ascii?Q?0nzlDlbhhfv1uC5wvRRW6m+1mOpphWYwTbjiftNZisnl1jsccC0KQNHtqJZi?=
 =?us-ascii?Q?kzsRj6U6ax8ZQYEn3/P9uWk+bigsVJqQ2ICg23w8mTthhcdOFdT0yztU7qB/?=
 =?us-ascii?Q?JRK2kDMdFXTDCKi8dexoN+KdwCgmDnRs5ooiVJ1wu6Nb9LjRqyCBeKKoOS7c?=
 =?us-ascii?Q?5lARQoyhdzdnH8H59IzF8zK6x+LDT1JB8vCcpiK1BCigRRoczNb7LAGolKIa?=
 =?us-ascii?Q?DiekteuS7O40X/oNM5NFj++2dEttAmd2d0Ukbf/j/hPQY999DsiutV8S7AAZ?=
 =?us-ascii?Q?BbSO16SiqF2q2srrdyYp3lgHcaBVk73WWEsgFnk7TJkUfkXqJQ6tT0lKyM1/?=
 =?us-ascii?Q?iwylNAt8GU/PFgfhPzxK384J8ECzquw5+mRTqW4k0IE5fe/HyRh7NP8c1Vf2?=
 =?us-ascii?Q?pUD3AIxO8uB5oQCtbn0LHv7EjPWyKnpEW+7N6YgPedIt5QdoSi1xO7sKO4yi?=
 =?us-ascii?Q?me7VIAg9K4TBikUvrVZSj/K37a9gRkdZirmXMvT32in4a/4GoRLSeCTusE0r?=
 =?us-ascii?Q?EMLOsycoKIy3BtlmtISSzq+1epk1a4doP+/Ppj7DKiOBPnnG1GJ8MeQLi0Cs?=
 =?us-ascii?Q?Z5IjhJVCYFRgwIMeWANGcUMe6Sgkja7se2gTANDVpKlKWkOB4CdFja/6Es8d?=
 =?us-ascii?Q?T8UcRrHiNbPfs8DGo7uf/AsEGFfSnJcUpjAFHSl+MnbpQG2DqUpPVaj+n2nh?=
 =?us-ascii?Q?zPzixN4crnxaZaB0KDBdUfsQaqFY9sbi8kCgJNDAEIhKUzeK10u+0LtIC4aE?=
 =?us-ascii?Q?j5FnhHsUk37eYE+1+11C3ECCoxML9OylgMcEOtR5JqOpLhyNldApf/Mmo0zV?=
 =?us-ascii?Q?TP+QIiI6+9cVuRFeagRXw38nOltAVftGO6YOyHddY/XYo4jilGzHjMdk4Vqy?=
 =?us-ascii?Q?Jam/y1D/M0EQ+EB7VG3a8qgRc6kz9UqyttcilWJA0ojDkE5O+77AJQPnkoVP?=
 =?us-ascii?Q?cjAxyus9xHKQKzXHt6HRvy7jGvnOPqbTLY2bdyYQVkF6Zn0TlXYzy9qWinuB?=
 =?us-ascii?Q?0RopPOfWGEjQ4vl9+Zgxv+CRS5eWcddU4ROajAUKY9eG6RxfeMy28/OBRBjV?=
 =?us-ascii?Q?E/pzgo4MgV3z/ij5ubMOqD9F5A3LZlVWRVV+89aWWmOYLqDC01AwA2GbD5q2?=
 =?us-ascii?Q?Vu72/o/Goaq9L3CNsFPwNaRgtFYaszLNbPcYKtOh0ItDRAfRgZStkPDxh/Ui?=
 =?us-ascii?Q?KE+5I79WckS2cu219HM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6e5671-733f-45bc-7ef9-08dbe220798a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:08:50.8970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHYjrD5gzXGM2N7GBE4foIFbfWTzDd4PPdsf0pZxQQkA2P/LfUH7xE0RQNCpxyjFExt+avGgGNPIJsgrPVKjjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
> Subject: [PATCH 10/24] drm/amdkfd: trigger pc sampling trap for gfx v9
>
> Implement trigger pc sampling trap for gfx v9.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 35
> +++++++++++++++++++  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> |  7 ++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51011e8ee90d..723fef2d45d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1146,6 +1146,41 @@ void
> kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
>       kgd_gfx_v9_unlock_srbm(adev, inst);
>  }
>
> +uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
> +                                         uint32_t vmid,
> +                                         uint32_t max_wave_slot,
> +                                         uint32_t max_simd,
> +                                         uint32_t *target_simd,
> +                                         uint32_t *target_wave_slot,
> +                                         enum kfd_ioctl_pc_sample_method
> method) {
Function should return void if it will always return 0.

> +     if (method =3D=3D KFD_IOCTL_PCS_METHOD_HOSTTRAP) {
> +             uint32_t value =3D 0;
> +
> +             value =3D REG_SET_FIELD(value, SQ_CMD, CMD,
> SQ_IND_CMD_CMD_TRAP);
> +             value =3D REG_SET_FIELD(value, SQ_CMD, MODE,
> SQ_IND_CMD_MODE_SINGLE);
> +
> +             /* select *target_simd */
> +             value =3D REG_SET_FIELD(value, SQ_CMD, SIMD_ID, *target_sim=
d);
> +             /* select *target_wave_slot */
> +             value =3D REG_SET_FIELD(value, SQ_CMD, WAVE_ID,
> (*target_wave_slot)++);
> +
> +             mutex_lock(&adev->grbm_idx_mutex);
> +             amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF,
> 0xFFFFFFFF, 0);
> +             WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> +             mutex_unlock(&adev->grbm_idx_mutex);
> +
> +             *target_wave_slot %=3D max_wave_slot;
> +             if (!(*target_wave_slot)) {
> +                     (*target_simd)++;
> +                     *target_simd %=3D max_simd;
> +             }
> +     } else {
> +             pr_debug("PC Sampling method %d not supported.", method);
> +     }
> +     return 0;
> +}
> +
>  const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>       .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
>       .set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index ce424615f59b..b47b926891a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -101,3 +101,10 @@ void
> kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>                                              uint32_t grace_period,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
> +uint32_t kgd_gfx_v9_trigger_pc_sample_trap(struct amdgpu_device *adev,
> +                                         uint32_t vmid,
> +                                         uint32_t max_wave_slot,
> +                                         uint32_t max_simd,
> +                                         uint32_t *target_simd,
> +                                         uint32_t *target_wave_slot,
> +                                         enum kfd_ioctl_pc_sample_method
> method);
> --
> 2.25.1

