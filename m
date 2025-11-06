Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BF3CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 08:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124BC10E12C;
	Thu,  6 Nov 2025 08:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n3z0otZc";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2EF10E12C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 08:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPVdENwXrzUjFXWWNatwYUL8rt5vYljhR+biEo3cWh2ZKKBoMM1SkfDDSkOti9v+2HgzcAxB1FyIHENIMnM23/mUkf1SqqX+IyyItMp+hQefCtRakIYoqeyHa5eYRnKoiUohSXwOSEyZRHEJvtPVsj1TYMGTOBz0v8xxSKmhPDh1AgyTLthJMgr/THDS00aef/aNoiZLVI5tYAkA2SQeUXFWqtUhiAu4OzjCkGoNYWJ+24Fxwp6Dfh/lZd5k/3PRky/JIlBHD651b7T4Mlr3VMYoEO43ftjGb0088RTmgrTKY+xAVCCr6783QibAfv40a31rd6yu9eB8EbxeGNWgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtOkyvAZoAuhOPNQak2tKQgiOTyLTdtcZLAwF/cJXWI=;
 b=JFNOBG9Ybt3t1bmimCxsBA9NYXzza22UoxE7rCSllm4sZKI+WfEKPCcTNZCd4di3Qma3isuqpq7WVvtHwuy3tY+JkE2tIB7USO2V4TfYMMoNzalGMYcbA+Ue5ofbK2cU46H9VVtAPgWJYnVHAtH7VQpU/1R2qnKJYLEDnjZja+svArTRJ/K5e9geQZ7/DeA1yzcjF3R6jAjulu9xQ4pmH1Zeq6eSunQ9PkzuQBD100pXvmbU5xL5SEjA9sdY69zuMHt4SdxEkQNoFDSah/4+YWconkNeweeeTNhGWjgah+Evl5S1CxBNOjxbov7EAmyFURLDkW8UetdcbWzdM/NJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtOkyvAZoAuhOPNQak2tKQgiOTyLTdtcZLAwF/cJXWI=;
 b=n3z0otZcTDQz+D8QASwbVxaBgPXFsXShvP7VPz8bMK0ML0zsVfqE4g93GY3jK2p4kLWjIoQ3RbCIEEXK3EC/pefK+yM22eTAUpwIjyhXXEzIvWn7irKraFvW6gfHaQWE4RjAEZi/EziXprlMDBXO9u/QLRTAR9ovvMsUtEU9Hbg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 08:46:08 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 08:46:07 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
Thread-Topic: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
Thread-Index: AQHcTvIC/X2x4iSe/kG0/KWhn+EQibTlVXIg
Date: Thu, 6 Nov 2025 08:46:07 +0000
Message-ID: <PH7PR12MB8796DB222F2AC7298ACE4092B0C2A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251106074944.1948995-1-ganglxie@amd.com>
In-Reply-To: <20251106074944.1948995-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-06T08:45:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB6582:EE_
x-ms-office365-filtering-correlation-id: cfff49d3-3f66-48da-4a8d-08de1d10eda7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vJ+6inovfs9+u3z11AHdmCDiz8hcS04q/9JO8cZavj+QnkoJR5/2LUyYdWl/?=
 =?us-ascii?Q?MI+6Ou14mVMSX4cP+RKRc3IiA9s4R65iq7W9jiN922iF3pF1qjC1xmncz28R?=
 =?us-ascii?Q?Sw42GNxSfGh81hd/HtZjwW4FbkKDLRxzM89DL93UsFRikb0Wo2gYHfJ/kXIl?=
 =?us-ascii?Q?iVVa58iWI552+bICRps+C4NBwS4nHptYhlXMrL07r+28HBUL0/r+w1hFBzvD?=
 =?us-ascii?Q?W6WcbotUE00gMEIz02ptpIt1U4lMfV2I21sBroGvL7+aKhi7DjTMYRHMRiD5?=
 =?us-ascii?Q?CzN0IfpHKq4Vut5/VaxZmMuk4pwHK4OPOZkn+8InMG1cJ6b+joN2/6drxHA7?=
 =?us-ascii?Q?MUbbxgrYHDujZL7x8gKJvEobEtkCDLIwtVE3rFXAoVwXyM8jhl0gR9Gq9V7v?=
 =?us-ascii?Q?b+mNVGheloEicG3EKaLoOjYPYXRHY/9nt3MqNtclufdeQEJ33hcoj6AUleMM?=
 =?us-ascii?Q?BYVQmoRkHpbmcDeim7zc6bz+VbEXvc7mn/Zr5gSXIHaYRBrtLLRSEic0AD1Y?=
 =?us-ascii?Q?RG+CGnUFeu0lauj71TvcOJ+KxS4d3M8X/08n6lvKqn/hZXrI11iTiEEUYNXE?=
 =?us-ascii?Q?VddkGT5E33+DVghO59IlU1xPuZ1MIa9KoL9oHE4Z4rjVUl3mW9yjVl5o/SsB?=
 =?us-ascii?Q?8RieHnNetQTtR73jKvmAQ5ynSH7uqJKFyCDcHvEISWjzY59rM4MwyIW/ZYrj?=
 =?us-ascii?Q?ycBQG+3R+xQZQC7Vqt5UCt3hG4BWlTRwndppTz7JshhadwGAmzEMGjSW+jNf?=
 =?us-ascii?Q?tYRhfpE2dTmBRCFcDlEZOxt8GhE0Mqnk1dIEmk1HogfMluWb9HzZqQMGDoxu?=
 =?us-ascii?Q?Qh33MhyJ9vtDLx9LkASnSwsIiZDws/MmK/JHUDrR/3bGgUl17f2UUAnsDpKC?=
 =?us-ascii?Q?iD6XtgkHsngm1ulVYky5P7pZi9Qp9VGDYtLqSOsdJuWCwGZuqaNcXZfqtX83?=
 =?us-ascii?Q?LirKN3DUxCL4fxCUuS/8KMaPqU6E4RHHcWIHFHriIfoOt9IQg5TdsglP0fZ2?=
 =?us-ascii?Q?E1nSLjPPjguaDuYuheQq+/gGkUI65I2bDV4pR9yd+8bwQ3jsmBjr4FjTMeFS?=
 =?us-ascii?Q?sl6P6G8tR9O0E4oKYHzf57Qd7Gwi9ithPPu5WJUwQSaxAjfv3d8Ac79D5cb7?=
 =?us-ascii?Q?xJFKVdjy9nIwXZ48zAUTiH8BNe5U7ySAjLMV9uCCVnWQk6wvNksJkvaYs+PN?=
 =?us-ascii?Q?iMlqZR1Y4ymm7fhDIklS6ALsXQIsI1PW9bbWjQgQKu/wv8t3YHSxoBCBWrLw?=
 =?us-ascii?Q?anp1TRoiULNGej62sOpq59V/cvMUq0s7lzyFJuGp8iHGfiVzHExH7Z6Q0dL/?=
 =?us-ascii?Q?nBoHNR+5Ak4ycQtAStFLzXrWu+9fC9AaGEJYVMjlr40EXp3ZxUdNt2/QWA7j?=
 =?us-ascii?Q?PHZ1pNY82kGk+6/bUua6tisY5LFt2UlS+dyPB5ypmdDVBBirn5OPDx89UJuC?=
 =?us-ascii?Q?tagBWs/25I/rtfiU7tATg+AMJMEX6pmbbOHZPR8PQIW3RazOsQu3N1CXkpVd?=
 =?us-ascii?Q?5COmhr62G6auaRH4EhsOiOyeL5GSQA/Rr3Ts?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OcuSjA9zprudAmyG9T4b2aKgEDVhbreNsGA0YzQFMwOVusHu4SX0BWqWAKbB?=
 =?us-ascii?Q?wOrBrbPVCIjpxDzLGQOHc1YLTYBDdezo/RPa+BC19oXMkqKmjSQyMLEaWcnn?=
 =?us-ascii?Q?SgntiVuvCni3nN8nFr1NNJxFPJTQvq7JUy6EWYw1JUCP/mVzHatSD/Usx9mk?=
 =?us-ascii?Q?6NlAEnPUUhTsMmRtg+tbG3+djNNQ4PDjUJ2cOg+EoguTtV1qnhcqBIYYzq82?=
 =?us-ascii?Q?sVlFDVPi9qli2tZPAnshgO7zN0MfZz8E6/qpGZhl3YZSCDMYHI9CsK/Q03De?=
 =?us-ascii?Q?G34QOKFcL8QIsjWtmhhDFJCDD5bTE8VgLY1HJ3BiwxapZE+KbJrgGlv12yDz?=
 =?us-ascii?Q?puVs7QkC89czS/0/k5esNHr9SZG6ac3TaOZiwa3LwOjU6qJAwn21unccW/qX?=
 =?us-ascii?Q?0+7rtDXaPG2qyAZugZszyBEtFv9oL23sVJVHqFgALBcV07LO366la8MIpOBs?=
 =?us-ascii?Q?s1DkS2jJ6GFyLmHfDERHr8ctG1xNdsFH8c4YAciqvRm7mhci00Tve+OZmx4m?=
 =?us-ascii?Q?4CStCqx7vhkeerxeJ845siqAYI8Ik++uv4NMbYmQjencUbzzRIBrxjy0Uhcp?=
 =?us-ascii?Q?gFvP9kcK26FPh3xUW6EARDhDibVGYsGyyspxtImF8AJeI0JIS6s7uu77FQ1x?=
 =?us-ascii?Q?iSv/snUaqWynWZo7jcVNhEZi4U5HL2WcvtzpLlZBUjjMC1SfvtyE4FG3E9Oh?=
 =?us-ascii?Q?bEPw3KoiIlYzYdfLHFrcDnZPovClrL6zmfnxNMJmRFzdj4DyCW9597lH5pbo?=
 =?us-ascii?Q?04IlyPIZBCehYH6wEKt6vARIeft5Ioc3yTZFHOa8Ei4h7yMeMg7RM7VZGYqM?=
 =?us-ascii?Q?VdbxHT91PM5COr3ZbVLGtd7D2j44HbYznYWm3vonhFBZf6w+tgNE5DOAJdde?=
 =?us-ascii?Q?zVTqNPEGbabZEIxsdet8UZCVBMaFRI8dHkraFZEuufkdj/FKsRbVLlDOD3Ru?=
 =?us-ascii?Q?/uWAH5Zv30Kih1C4qoc7BTmoOs4GBJmHOcKxsRJAL+HEZ/WzoQX351m0XYsv?=
 =?us-ascii?Q?5ZqfBCCy1p0OZhpwzY1Xq2e9ac+PVXtP7fXaDAeF2pHMnmjAfHWdNyoSMfx/?=
 =?us-ascii?Q?4XMD0EYNj3BHp68RXBRFckaxCMf4DBLnWLUUcG96LhANEA7zjHk/2lvfrxX7?=
 =?us-ascii?Q?O/7hIul/kLDK5m/rtGlziWmuOqSAUxYlXba7ZkWS0MhXExy6+y6c+KpJXuK2?=
 =?us-ascii?Q?Ntcm9EHh+bhuhUTbXgliNDU+WD9jPh/LF0Xx8tfIZQ66TyeKq+xfr3nkgJqk?=
 =?us-ascii?Q?sQlF1D/PGnwwi5WDGQxs5FYow50dul0n5BOEUOLnPYDO2PsacOH5sCR0psEO?=
 =?us-ascii?Q?TvOU+r5bis+tviGLdyHu8SlzmDjtSBhWGq3BKQEWAi4fiZShnrH+042PG0UW?=
 =?us-ascii?Q?EYS/HaIVyhAIExIiWVHfnVE2LfaZ9U34rhzee5F7KS+HjSnnRzHD6Cl5m2Q1?=
 =?us-ascii?Q?zXHVafs8DjWFo0H4z/bW6FAt534H/8hpDv+1K6TRdHontde6q/PiiIQafpyA?=
 =?us-ascii?Q?KuXKXJyMw4s9fxCHpG9X4ecfQa0v8/zoNNYFNneVH7pJw0SuvamRxb2wfsB3?=
 =?us-ascii?Q?QhGg3onP8fZSB9ejsqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfff49d3-3f66-48da-4a8d-08de1d10eda7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 08:46:07.6662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzqF71itoFH7OFOhNCN0QmS+xnqdZh9hAFnOrXVCBZSi7zdbWGTuAdUXZXa1DkXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Thursday, November 6, 2025 3:50 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
>
> smu busy is a normal case when calling SMU_MSG_GetBadPageCount, so no nee=
d
> to print error status at each time.Instead, only print error status when =
timeout given
> by user is reached.
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                | 7 ++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 0ce8cff27bf9..fc580800609c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -956,6 +956,8 @@ static int smu_v13_0_12_get_badpage_count(struct
> amdgpu_device *adev, uint32_t *
>               now =3D (uint64_t)ktime_to_ms(ktime_get());
>       } while (now < end);
>
> +     dev_err(adev->dev,
> +                      "smu get bad page count timeout!\n");
>       return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 3b98065dac1d..ca575ecbe36f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -164,9 +164,10 @@ static void __smu_cmn_reg_print_error(struct smu_con=
text
> *smu,
>                                   msg_index, param, message);
>               break;
>       case SMU_RESP_BUSY_OTHER:
> -             dev_err_ratelimited(adev->dev,
> -                                 "SMU: I'm very busy for your command: i=
ndex:%d
> param:0x%08X message:%s",
> -                                 msg_index, param, message);

[Tao] better to add comment here to explain why SMU_MSG_GetBadPageCount is =
special.

> +             if (msg !=3D SMU_MSG_GetBadPageCount)
> +                     dev_err_ratelimited(adev->dev,
> +                                             "SMU: I'm very busy for you=
r command:
> index:%d param:0x%08X message:%s",
> +                                             msg_index, param, message);
>               break;
>       case SMU_RESP_DEBUG_END:
>               dev_err_ratelimited(adev->dev,
> --
> 2.34.1

