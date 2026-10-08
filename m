Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E296CA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956B510E356;
	Thu,  8 Oct 2026 12:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UgpKSjD7";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010069.outbound.protection.outlook.com
 [52.101.193.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552F110E356
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKIEjMfwaj5zLmoTOfrOx2Q1okWcSal1Z0TYbdCRZPaZlKTA9sCpEzZebnDcgwteV1bYOcdMfCNf5M2KlmvKyS37GdipPPR+TvUDGeCU0kRksagsOzeo5WCLl13VnCkA6pGKH+0bYtHa/XzuacXS/VtYp6xc0xMPsGETZdjxB4qco516q2ARfkg2tRZlro8UxJhG4nb3xr7n2KrF0dK2Wf9B6uG7PRxqckqBCtD8qZsOWWjLi4omAaKaeFLqZu+6LBl7LsOv26wKEDZt1cNPOhDwgQYtToPBX28pXdJxf+C+o98uFnKcvk6ZEOOlMDZnZKaaow2Qr5aKbMMi081vxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gD5Tp80QnpKuRBbnXne0XHI8PdfQw3ONUkyjFMys8U=;
 b=NHo9A6BXDnlUQlp/sksXxGWL84gu5EUmlgO3QU4Au3VTn2I//GcpZJ3ApBgF4sxTI49XzkisCCBCeBI5FEYV+ImEBHJ+xlK29St1Ao9r9TnlTOS3t8pKQCI/edatZeIi2CzM1ywOuRv3jNBaJSlAf8WKl2217Ed+KPa0N0UiJUWGow9GXGlEhOOFqfnn8ZIc3MUsvV0PPjN1rILmmPlYdTjUsvs8CWG5k4oUGZsAke4wUb16cJTN3T+Q6/Q3Z5070mkN/rB2auraLsSN4pifkSa4/sGQDLV1qbw4B2L0IXbCaA5iJBPjYSWJTxkGbGMFTe66H9bhWcadhuJ4rOqm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gD5Tp80QnpKuRBbnXne0XHI8PdfQw3ONUkyjFMys8U=;
 b=UgpKSjD7fDq13e80pWOY5bSwVQKGAViraJaZ4Da0QiLp9HuPvv60+JaFD4j8r/jwRJjFW3EMfhpAbAD73xXsRlgMJzK0LdESCMyZO0yAGxIYH00+srhGweKohP/5KZUCBIA0/w4xijvzkx8NduFrVHKDCcuqc9DkcCt8uw8dYSU=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 8 Oct
 2026 12:54:33 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:54:33 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2 07/14] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
Thread-Topic: [PATCH v2 07/14] drm/amdgpu: finish GPU recovery callbacks
 before restarting schedulers
Thread-Index: AQHdT8U+LNW7ccs0B0SfA28Y30v16bbzqIIA
Date: Thu, 8 Oct 2026 12:54:33 +0000
Message-ID: <PH7PR12MB600019164FED291B0E33C63EFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-7-Prike.Liang@amd.com>
In-Reply-To: <20260929034650.2393125-7-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T12:53:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MW3PR12MB4393:EE_
x-ms-office365-filtering-correlation-id: c2fc1903-42e7-48e1-fc44-08df253b4ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|6133799003|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 3dAjtDlGCi9kKr42xngn6EeCjT1jiv0l6JyrzbK2108Yz5kOKWWTzFzKWL5SdtgRl6iu84MZUOru+PCTdaWACmKIkixh245TxGy2kUykWxyZIkFvEbsahpEUv2J0MYYVrG6lX4pni9VLky9s7PfKu9H0vqrf+Ljb0dkAeE251yuYLArGHXYetlHZysbx1WtyFtmJ7TYg+hqTjiUTDP8Ed3Qvmi3kW2VMIC/CfWHUdhp9yCO9QIV/2KLIyQWXe48DogwFuarqq2itve9niYj4MKyLeNiM60Ik9Iv1tmyo943h0yHoZOtxkOWp3FP/vdbVZ0JF4B6ybbmGtf8L2DFWSxOnqo1rzYlg7wgCAdHB/Z/nmAUY2Roex1Y+t5BIvEi+WIj8cicIQ33C78yipQzZDPibvVQq7APKAgDX/M8PQQrMzXyUnnLQnBlllN51g7og4ijvEaQJp1hMFHdRk2icKSTro/z6TAznF0MiNowVrZEqz4SnpcU2hQ1VHuemgZolbv7L7wbQAoXBhNRrjfFLyTl1J5hetDT7I/hRqgAt8OM+f66uXN54mgOHRtMJ81AdtrxaNly4mznrzjnSJrCsrMxQhooISyrvZPmE9cuL2SBM0cJkmKH/cZhWHFrn6DH9JfI+nNh/MC2lPE6Qf4iMZK7wHNubooFUzjSqWfXL5eExqZhbAGJXFV9EiEIXYwJnxSuDW3ph9CJXVPEh3BAQ+fJF6pmtfyVjF/f4yIJJc0M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FRz4P8TMUQqxAe2uQ5M6x7RZQ9q2p1a1cVJUIGzLipzbKBifepW4Dmsa4Etm?=
 =?us-ascii?Q?/GONxe/A1pq1A2+yMoaauSWX1k667rlDrnAMcsrVAj/1hNgIU0gT0/6r9Mmt?=
 =?us-ascii?Q?1ew/3bWGDePXE2Y3meNtpCPKMhhN589RC0PagQfz+ba/Cx7gBwpcbr0rDTtJ?=
 =?us-ascii?Q?G8HD3WOB9e7Ngdw7tKMzzbB3EgE6uBUaXE9IBsS35ZiwlnFmj78OPdrwgbqR?=
 =?us-ascii?Q?exI2pSuQAF49v5RdN+aBkiGtAlvUTqGopjpNa4f59pf8axhoqSHDWAgPIdrd?=
 =?us-ascii?Q?QA7OPxPXqy9gulnGXwRyzukiVzPkoaW6s3GMweruBi2Yuksuq82lnsVLtOcJ?=
 =?us-ascii?Q?1SqermfLiQ7qoryj+wjflZPxN09FCh1VM901eZ3/jl8F4mgMQSCt4bSKWafO?=
 =?us-ascii?Q?822EiLzhXLlW658IlOnFwU9s59y4OfNGVjkdRyPjtifbnpB322FRCbIc4i2E?=
 =?us-ascii?Q?C8t/48MZPG3zREY2O0GKVQp0hdr9WH6PQS+9dSlfa2fkcs7FD06dV3K6FdPg?=
 =?us-ascii?Q?goNpwfa+mRhqmHQqhKwR+HjWQ5T0JJX4dGhwVkrJQJ9Nm5Yys43y26+nYVd3?=
 =?us-ascii?Q?rnCT0iBCJWLKdYO+Mle7Z9amZ8OiErRxcnaVHHWaoAs/UYTb1VoCSqjP41/7?=
 =?us-ascii?Q?l52tasPqIMLRmHFv7OZiwHNSVNHmhe7EfkvuUehC19NETZWrNig6nRHdf3x+?=
 =?us-ascii?Q?ScPX/1WCPmSye2Yc+YAqQcxsUXovYD6tkve8utPut7MLvN9fzrBE8kl9XL+3?=
 =?us-ascii?Q?Saa3kfPEWDXGRyvYJdrZGjuSZVjChlxFNsxpo/He9PRyml9yz5SJh7D+kooE?=
 =?us-ascii?Q?7zgSoTsMb+LjOWN45CF9l/4kLYopTYTeTk+uskP3zNicajaLDGd2TLTMDqbE?=
 =?us-ascii?Q?3/XLGfzVpvu9TQ8LiXYh93R7C66sro7mayt+VOFGjoJxlV4WK9Id7Ad20rt/?=
 =?us-ascii?Q?ZfG1yCSEv+9Ogny830FxKczVYLbVlVf/u4DUxGP74ISgQCUzza1Hu4RGCuUm?=
 =?us-ascii?Q?SwgY8B2qqwJS4RY7XxRrgBzfQdLdB4VIsTVJvQbxzOrFCBlHkIjq6+p0hq86?=
 =?us-ascii?Q?RfXri2Yl5g/xXitQzpwGBhX5XusNvJYcsaEmlc6YmSGQBMjpYv/zUuvXOyZX?=
 =?us-ascii?Q?fWa7A1XCCfJ7sKfxOONjYAwdFNIR/etZ9Fhcv/bfZwCTFl3FE95yMQp7Gi0W?=
 =?us-ascii?Q?23pIV/71JW/7qoQd3AJf6qG1ybkKefzzuuObRfo6Y0ONPymtghIn0s9vjpL5?=
 =?us-ascii?Q?f2JqumEw2TGRCLEzXsxabN/ZOjmpu0ElrGUp9NeHrPS60akF8xyNk+HRx+Zz?=
 =?us-ascii?Q?yPdaf4DRpzjEW+bGtbOKLlI6B3RuyxdOimuDJaB1Uu/xlJQzPKQC7s4l702d?=
 =?us-ascii?Q?pU6czJJAShx24wI9KjjS2KjdIiEldPsFeTnh1QHdvpDEczKVTBa0Cb9bFezi?=
 =?us-ascii?Q?UFIupAXkKZLqwSckBdEWsg6E2eW8QuRfXvQpe4Pl2ttx6WONTUuzJbQ0W9FQ?=
 =?us-ascii?Q?z4P/nWAPguV4drRCoCQRQbz+qAwidk6rnr2VBRh/E/pK8z9PS2BM/SFE2ZZR?=
 =?us-ascii?Q?G6gmLXufP2P+zFOcvBKibbRSM1B1D6e42P4TKfiDkpSO9MkJbk2YHds1ONUT?=
 =?us-ascii?Q?PeXEFQkSpH+SUJ0VrS5DkJ5B86vQBrE3B1ac4qW9h83+tTD2OyISSZdOFhXu?=
 =?us-ascii?Q?KtmbOSWyZRQrmrUXXCoxcRqtSRrcpZY4rD+z2AbQXCXe46h+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fc1903-42e7-48e1-fc44-08df253b4ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 12:54:33.1269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEzTs6bEfhQTGL7/uY4oelHfK2Ul2M6t9NHv1p9n0rm2Hr8jDsgwlgomZ9pf4UXN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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

AMD General

Ping, reviews are appreciated.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, September 29, 2026 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Lia=
ng,
> Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 07/14] drm/amdgpu: finish GPU recovery callbacks befor=
e
> restarting schedulers
>
> Run GPU post-reset callbacks, including KFD and display-audio resume, bef=
ore
> restarting DRM scheduler workqueues. IP hardware initialization already h=
appens
> inside ASIC recovery; this change orders the remaining callbacks before n=
ew
> scheduler submissions. Preserve the emergency-stop and guity job completi=
tion
> path's callbacks without starting schedulers,
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fa67de6d066c..83d98c9191b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5783,8 +5783,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>
>       amdgpu_device_halt_activities(adev, job, reset_context, &device_lis=
t,
>                                     hive, need_emergency_restart);
> -     if (need_emergency_restart)
> -             goto skip_sched_resume;
> +     if (need_emergency_restart) {
> +             amdgpu_device_gpu_resume(adev, &device_list,
> need_emergency_restart);
> +             goto reset_unlock;
> +     }
>       /*
>        * Must check guilty signal here since after this point all old
>        * HW fences are force signaled.
> @@ -5794,18 +5796,17 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
>       if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
>               job_signaled =3D true;
>               dev_info(adev->dev, "Guilty job already signaled, skipping =
HW
> reset");
> -             goto skip_hw_reset;
> +             goto post_resume;
>       }
>
>       r =3D amdgpu_device_asic_reset(adev, &device_list, reset_context);
>       if (r)
>               goto reset_unlock;
> -skip_hw_reset:
> +post_resume:
> +     amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart=
);
>       r =3D amdgpu_device_sched_resume(&device_list, reset_context,
> job_signaled);
>       if (r)
>               goto reset_unlock;
> -skip_sched_resume:
> -     amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart=
);
>  reset_unlock:
>       amdgpu_device_recovery_put_reset_lock(adev, &device_list);
>       amdgpu_ras_post_reset(adev, &device_list);
> --
> 2.34.1

