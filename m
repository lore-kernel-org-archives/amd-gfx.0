Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FCDD15DAD
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 17:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C3510E186;
	Wed,  3 Dec 2025 17:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="swiBF8gF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019B610E186
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 17:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw/shwvB3UkNEpbVNnk5+t3rRsVAADPX5+InfYAvr7nZwOm+2a+m3b/S1su4rFRRwFEubBkBX5JpzyjlszQIeeGjLgzdvFkmr2qjUgh12ZgXNQcvej3y9UgjBwvD44IyMDqZFv+3qDRx0X0HRmLKTtZxUPh3hrnu17Bmw9qaAt0k1ZVcRElX7SnvqB+/l8/VV4j1d6+dzRzpWdIgJZxcUW7vjC5DEZ+Ayo07QkVw6la2ZFNwC/e4a8rKRANJ4VDZ9ztZ7ITuHUCq8Xgm6T7IlOznKCcbN4Yp62JNDPLugXyCOEYufjRS59iv7OAUiCRsyMNq3+hfHYDmsR2uul3D1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UDAnkHNNSgBXS5HBv7kgAKxcs573kLZa4DiZBPl5z0=;
 b=rJBWcCRyzdJJDtW9ypKxFOdGxcs/SZB2j2qlc9xk2O0yS8XCycuLBXfSgl+UY/ypNrIixyhHivhkvUSMhhoRQY21XzZb6inAEC25JoOLCRPSRgnQqfVxovzzzvMQbODDxOYZ/0Yw+J3n/ZXvOeEekAQkt5PapTCL7nC59Ks2YkoGuhHjI8eHsmSROpzwrJfcUuuK8m80RpMjvlBE1vNqd0UzzqR3fUF2O4g1UUASfWB5ZaKpQp2J22Mt1McoOdLvs/zkewqFBlSgS7gzBBljSwmbYw1UAvBXg+yWGXUUmKC1n5GpypCXAHKbAZs+p5ovoNKL7DrG1XLM2VLPC0NawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UDAnkHNNSgBXS5HBv7kgAKxcs573kLZa4DiZBPl5z0=;
 b=swiBF8gFf2GZoFK9CncTM5NkittMcZZ31kjIWgJl8YZ1b04t9fHdIZWMqDc7ZRC7GsqLiP7quDsxmdLZNGGHegV1zXgT5X5AWUUFUif3EmL/UOmRZoZnenPDR8b243EO4QT8yODuIi4UpaC6lSF9euSamftJsQOz07Ft1c+Hd70=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 17:35:35 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 17:35:35 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Martin, Andrew" <Andrew.Martin@amd.com>
Subject: RE: [PATCH v5] drm/amdgpu: Ignored various return code
Thread-Topic: [PATCH v5] drm/amdgpu: Ignored various return code
Thread-Index: AQHcZGNrUcyx9QvoZUmBQMM9YyyStbUQLTcw
Date: Wed, 3 Dec 2025 17:35:35 +0000
Message-ID: <BL1PR12MB589874A177F717DC7956CAF285D9A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20251203144435.62300-1-andrew.martin@amd.com>
In-Reply-To: <20251203144435.62300-1-andrew.martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-03T17:34:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH7PR12MB7427:EE_
x-ms-office365-filtering-correlation-id: 5aa4d55a-eb07-46a0-1653-08de32925e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?adVJ+zrBDz+rSIefNSwg8mIzgc4wWKCjBg+F8CHn+bduuCgWfrtcK02yNifz?=
 =?us-ascii?Q?51g+/jYmiTbKJihFLwGI+DQPk0YyNqZP0Wvus97S7V1FKF0cey3feWGelgfU?=
 =?us-ascii?Q?O/WMhCFiyjxbnLfZfjT3+26TCIpoFKsIdmYH0gO7U2NmmXqmRv7YfOjSgCGl?=
 =?us-ascii?Q?48OdCNmIZdJj4ep5ynjsBCMNxDHeSQh/E84dsKtSbPrAmIQj5T7XLn/IelIp?=
 =?us-ascii?Q?CT1U98RmJ2vEM4R50sUKHvryDUPLnZFZxrvc0Eao3S4E5D4KKP+ZSpVWnr3O?=
 =?us-ascii?Q?8NBHIZmlpQKT5XQEe8FC8YbTZLe2uh/NJGaLpYkWFKAqgfFWn2IJXtoyOzJv?=
 =?us-ascii?Q?kvGmJ1zCpveVD8jEI9GAOiHa0v5K6YD53XpHuAxnDWDVtMneTkKfV9bUlgwK?=
 =?us-ascii?Q?2H7p2X3d8n+0NqzYCG+RCQD/T2LPyvyTjNevdpuziqV0bQl+KxUGF5iR8iQe?=
 =?us-ascii?Q?xuFNmTmEvriyyw3vSihccBDjre2Id8cpmXzevZpT+02eBV/DF9Wz/MwPWatZ?=
 =?us-ascii?Q?4OIUJCvNTF/+H6Ri0BEECjTJBEFNduHmY9HSoromRLbc/2SPmLtr/n8CvsWX?=
 =?us-ascii?Q?hYlsQGevuIFz0kxQo53+bSLyvxQdSshFUYO4UAxGkSxNAOMES7GkybC7POx1?=
 =?us-ascii?Q?RmHckQdtrC8FPwshCmcq5VQ/YStJva0tpmwHTBbTtva20Sl+40CgUcsbiMDg?=
 =?us-ascii?Q?iI1hIB6JfnDKCBs6/7em5TZGv+kGHjIUhQLiVjverIkhFagC4El4ZKQU/6+T?=
 =?us-ascii?Q?Z5o0RDHtWZQ2lNGCcyl0c5u4WionlejqYBlBQfZgOkT8GXH8AkuuGSA/y95D?=
 =?us-ascii?Q?QbeJyIIXLmrn0GKkf/xplnNr0PsBkU9/2WpLwhc68B0LF+ZckG4eJtkMKr/g?=
 =?us-ascii?Q?o/77f1VcgzeL9jaaDkJHH66cu1/pyQGlDV9stPEmoAlhafSD9LmMl77SipCu?=
 =?us-ascii?Q?WRC6cH+3L3YXww+ltBtnX+A4VeLBDxPHtEkJ6t1NW0HRWfphcXGWggwqNHsw?=
 =?us-ascii?Q?QDyWUI+RuZvTae7l+WKiC0CJHgSoJLbRQ9evE2qmlGlyaC454yVU/tAla9hX?=
 =?us-ascii?Q?YaFLu2ehgdkMttIn1YZuBBNuUo8VIL7HTv7OlI2rVRyYZyqExF5G99dPx/Tv?=
 =?us-ascii?Q?sIZi1tvcOKPWz35HZ9YQE07fBx6Ow1JVwnxCSPbz3fGAMheM03cWlAIK4j8l?=
 =?us-ascii?Q?kav5QeOzd3SkC9nBdvczUdHi0thvTzsc/pmoKnn84MeZKjfsXYm8quMiEQ11?=
 =?us-ascii?Q?wSh2MZD2t2jZ7TIUL6XKeReY0rXIeCgyyQGA0tNx4CvKS7n8nA/iC4hib7S+?=
 =?us-ascii?Q?+TldQXuqa1dqN/a6lBdz7mqRKDul1CFT6jPBuqG86DWz0HuzQs/zFw/oSaWg?=
 =?us-ascii?Q?JgfTs8Y211shKwnWqsMjuJs7h6BDUNFwy+JG5vO698mraoNhh7u2IZRCCF75?=
 =?us-ascii?Q?efn0M15GtzSuUyuxZdCmyPr6OdYRq/8N/BeNWjrNVjVCS2EgpKOA5oCthTkX?=
 =?us-ascii?Q?zw9v4PEpztE6RW02LSqPUBpL0p7LkRFwTALj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HrIlZv4TaVngrGjRW+notEO7UUo+bW9AD/YXCv6r27BeFr92mFILEK2LoLIK?=
 =?us-ascii?Q?Ehlv4pAMugVHPefXpRQvzrjLmhk8eUMN6ky+eXDyv5d4DNJLtVwuwum5TzkU?=
 =?us-ascii?Q?4cpUgDJ4D/yYl3HORrm0bywfSX6nbKXULyOKAprAtSWMY2VLoAqcqmp7Qhtd?=
 =?us-ascii?Q?cnc1jPEsnybgmJ1tFkINYbNle1K5cXAiytEBLIt1IvwmY2yNTlcQcLpoQso0?=
 =?us-ascii?Q?g7vYKio0ApIsUFRdNFd/P3W6gcUxJBwDiivImxBB8K+6ccJlzFsVkoU0JMLF?=
 =?us-ascii?Q?fha0X/+xPrGsWdB+2ZIsCsJnBtKGnWUbTJA2P5vWh9fMcEUc+Wagos8c9gZc?=
 =?us-ascii?Q?WyCk5PtP/obIE9byYliBFX/1b69n+WZ3rRbleSI272wYj3ELGJZS8r6khSTf?=
 =?us-ascii?Q?wo0Miy/RcqY0vdsYginMLXjKs3uKHRKaoe6kQPffC6mT9hzdHiNVrSgZUhpN?=
 =?us-ascii?Q?rP8A9S8O30VAyj9bkv0choWGFPtOj4LBhgCr2ydX+tKwzTI9YkyWqE2IkkHC?=
 =?us-ascii?Q?e9RradRUP36xb3tQOKoXeoT6y1uhYx5UX4KaDRsthcr8gBccF0tDDUjvtI5a?=
 =?us-ascii?Q?IeeEA97NdLS5Zx8Xq3lKnPSubcyI+w5fK6Xn2XnhQiXuGWk/hNpyNj+lWnRw?=
 =?us-ascii?Q?RR9QsbHZhkJ5MQlOK1oKWn5rK1qBnZcp51VnsPejva1M8MxKZmI1TW25RtFG?=
 =?us-ascii?Q?siqqEpn3iPKCUkVEiW/5f6ynkaEhBLVc4JLd7EqZ93uPxU+vnba/Mb8C3tNo?=
 =?us-ascii?Q?pW7y0VxMdkZMlPjHnicK4qsQt1cdaJE+qpFycwB0gHnjgzqSRb1i7FOmJVdQ?=
 =?us-ascii?Q?U+/lFzlnrWqpwLxQTRQaXlO6lW3/dqgXYDyeIUBYm2omtH7FDRwg5etOIh6Z?=
 =?us-ascii?Q?YKNLOUGhYVc+n89ejGqIDGhLnOxxV+xjt1LNt2ICR35HDXUoEJmUS//dNqeq?=
 =?us-ascii?Q?FlBja/Rh6BILKGDQE5XJxdtZyRv6IH8FW0M1mVA3xANvitGbddpEOUg+sv7E?=
 =?us-ascii?Q?fxXxGC3oLbUJmEhp1v3QUr/j3R/bm4+z9+FrbF01rvnkoUty0CVRUoRJLguF?=
 =?us-ascii?Q?4VGoija84N3Ve47R/KPsbc0ThrEsR1MavHrYlSV+9M0qV/yhww6LO0B+uTju?=
 =?us-ascii?Q?mHdyDx7LP3km6SOAzOSyjNPxQJ2U34QQD387f6rWmRrJNPGrD7QF2f0Dm+yX?=
 =?us-ascii?Q?lWK5qWrX7iwzizmIIsFR7ThfBv7Kl3Y/9en/V+57urkSm/kYobylQ+Db2/x/?=
 =?us-ascii?Q?SO5X5CPLc4im07mmxVCmQgKZhRRGg3iRFStajqGVXGBltqvSMAXn1REoVCgU?=
 =?us-ascii?Q?k/vVltIFO7QdvbBOeI5Qasp3XTB3eo1U86T8HDTJwYJWC4I2xhDBFOlRdWKK?=
 =?us-ascii?Q?1Jq0kEfjshHufzU6RWgaN2gvvuLP26WoB8JuHvfD5TRt7x9Lg82wJjtxd7in?=
 =?us-ascii?Q?+6CsivCTf7rNCIkE0vCyLjA3aFeNKxB8pcIbrq92WQOCybNlaUdfXohyzFz+?=
 =?us-ascii?Q?mizbpeuH5CdUuU5FnI/MGYGZ20PcFw14MxaLi3u5aR3MDBd9KJV2AX8TQ4iT?=
 =?us-ascii?Q?6f7FZZ+nZqmcAP/lbcc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa4d55a-eb07-46a0-1653-08de32925e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 17:35:35.7011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xopDN7rodatvLPQdRVQIt64auGaWJh/cS8uV5vj3z6cxrxsI4zvZqsY6gOPP2yfpPpMTQFfwwHRAEjij2ZTGlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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

Can we try to keep it to <80 characters?

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrew
> Martin
> Sent: Wednesday, December 3, 2025 9:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Martin, Andrew <Andrew.Martin@amd.com>
> Subject: [PATCH v5] drm/amdgpu: Ignored various return code
>
> The return code of a non void function should not be ignored. In cases
> where we do not care, the code needs to suppress it.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 +++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 8 ++++++--
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a2879d2b7c8e..02259886f93a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -312,8 +312,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device
> *adev)
>  void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>  {
>       if (amdgpu_device_should_recover_gpu(adev))
> -             amdgpu_reset_domain_schedule(adev->reset_domain,
> -                                          &adev->kfd.reset_work);
> +             (void)amdgpu_reset_domain_schedule(adev->reset_domain, &ade=
v-
> >kfd.reset_work);
>  }
>
>  int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> @@ -714,9 +713,8 @@ void amdgpu_amdkfd_set_compute_idle(struct
> amdgpu_device *adev, bool idle)
>               if (gfx_block !=3D NULL)
>                       gfx_block->version->funcs->set_powergating_state((v=
oid
> *)gfx_block, state);
>       }
> -     amdgpu_dpm_switch_power_profile(adev,
> -                                     PP_SMC_POWER_PROFILE_COMPUTE,
> -                                     !idle);
> +     (void)amdgpu_dpm_switch_power_profile(adev,
> PP_SMC_POWER_PROFILE_COMPUTE, !idle);
> +
>  }
>
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 041237861107..66ded3c07eef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2796,8 +2796,12 @@ static int runtime_enable(struct kfd_process *p, u=
int64_t
> r_debug,
>                * SET_SHADER_DEBUGGER clears any stale process context dat=
a
>                * saved in MES.
>                */
> -             if (pdd->dev->kfd->shared_resources.enable_mes)
> -                     kfd_dbg_set_mes_debug_mode(pdd,
> !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +             if (pdd->dev->kfd->shared_resources.enable_mes) {
> +                     ret =3D kfd_dbg_set_mes_debug_mode(
> +                             pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev)=
);
> +                     if (ret)
> +                             return ret;
> +             }
>       }
>
>       p->runtime_info.runtime_state =3D DEBUG_RUNTIME_STATE_ENABLED;
> --
> 2.43.0

