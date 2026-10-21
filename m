Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EE606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BPDI9pcE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235F910E0ED;
	Wed, 21 Oct 2026 09:15:39 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B02410E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 09:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emGZHB978cldEjEEogJV+CdY2Rg0Z86GGFYP0WLRmLwx046OgncDRQ2TrBX3mqypLjALjpP01ZiwSPC7qzWhIbzuSOFSunSzhCF1eSyUihEGmtxiLSftl4L0ErZlExA+vFAZV8OoWIqj6ThGzTbdpMWyVjKf+J8Mx8Yq9GUh4LzuS692d7wcgrTwIPj5oMQVIe6Zp436QyD5D2vbgqQPCxGYpX4LNjYTftS/rV37JrNTsv9+vrVkTJkyr72c0WBT+G5uR4laA0lGc66XZvOmSjQT444N8cq/A9y/TfO8tAQCDBXdT72UexppGX6e1qTtYk0GaQHAZHy5zJfEfCvEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr6ijljHoeIttZzp9OE6idYsH9TMw+oOcJpSfMvwe/M=;
 b=tIkkrVfcU61tqbE488f1Hy7Z0a5PvzFGGfchPLf1aXUyqyxdTtfzp9fNeQhcI/yXczk5zLOnX0N5pkEFQDC6eF2wkyFvqMenwS+cyDRAnvuDa3SydJm+JGPSMu9DZyK3H3NhSwoM5Gpk0AKTSsmo/GUaug6gHIXAOV/NTDULdiemGCGLCS0adr4RgAB/I+CZ1QTP1wRbUTYNbaayrdu+JAlzFhVapNGOaBDrJRSWaUgANjEH+//XhVcwCQmCdrlnZEjtz/Pxt/Bo9H/ZWgN84KjVO/OllV1xp7dheZvLlJG96NC/wUSnTtSm4MoKTM2ApiVHDb4f4gE3IJqi2O9ddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr6ijljHoeIttZzp9OE6idYsH9TMw+oOcJpSfMvwe/M=;
 b=BPDI9pcEb0XlG8DOaceXxXcvEFR6biIIYkwVHtI67s5JzDHs4BR+XASikOFQJS7O9pmVomOux06oUnuHW2sL/AGdQKterrcPuBUaMDICHiRSjeZmnsimF7z+rt56E90is4jShYXg4AsNPyZ+qxm4AKIUK22VfhqnUr6Z5EDQaag=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Wed, 21 Oct
 2026 09:15:26 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:15:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
Thread-Topic: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
Thread-Index: AQHdWGIlEWucozmnYUWuewqTdziwCLcHyI7Q
Date: Wed, 21 Oct 2026 09:15:26 +0000
Message-ID: <PH7PR12MB60008793634464A78A3FA17EFB662@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261010025024.2453900-1-Prike.Liang@amd.com>
 <20261010025024.2453900-4-Prike.Liang@amd.com>
In-Reply-To: <20261010025024.2453900-4-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-21T09:15:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH8PR12MB7205:EE_
x-ms-office365-filtering-correlation-id: eade07e2-31a7-44b5-e693-08df2f53d83f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: /oZhmHqjWUzWfKSxI9Gs1s7n901leTyu7OtJEYiIE8wZx0erwbym0vX4SlybXcpF35+DI0d6PHJYePWIdWbxk0oGH5hC8uawdTmPTwhwZ9Nul5MmFFhdkJpvGkFH4bgs32/7iX1AWUMhxDNngMZraxycOEPJvLSw0FO6XCKslUIzuf/AYT0xJEAqrLOtxlsnRXE7EyII4Tc8f0WSUnzotrBKJTnLAcZ838ZlaBhOypY/RjvSWE68Lb8sGtWvD4wPKPaFq6vtSZGv85EpD/Uk1FBLZ0Pvl9ojIJlkW/V7cSDnnMrQ6lR2rbm4HN2mV2pVpVnEG8qACt6+nkQTTHmTALgjPGku0Md0DZHW92UX51lUz6ZeRfORT831ls1FFMzr8CEaAnHV0HDKkFaahka5xDRaMVvHBXl1yOfWXo/3ldDV3KhOQ2KINMCQR8tNslXOow1EiexEUJAyQJs9vntucvidT1YnU0yKRfXP9R/JoVO5xzj+8EXdTJg3pskZef2PQQUBtYf6hmDdNpWkOY/FfVLR24e2oKsz5gauuv0Gxh4xr6v01M9OtwMAlXGWruNlQhvhQnvqhQWzwY8+Gff+8EnZ9htXd4KAeFKdYDFsRVHmBuu3e8vIXezyq/dA4G0YL1cqgysd74xZ275s5cCXshLeSipYCYe+mCAUicflSzpxzw70KTngTOVrCpS6LupCfM+sX+dsxDFr7PJhukK8jrhZ8JKs3gzGG7aVvL9/v9s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VOg24UQrSe9rkAKLTZbGanwBBHvha9NAaBrTuEs1PWbFgFfdVadwWaLBnjVL?=
 =?us-ascii?Q?hTXg1v0j86VcoQ6UA9zWGF8MfprBXByKBPDxmnpxuXGzmIim94AQO9yiliVN?=
 =?us-ascii?Q?4j6ZRMZ+a24ajGR2/9wn/1w9YTRT4FEF64qIoPMZPYRBt32uDQ+Cpib2ouvC?=
 =?us-ascii?Q?x7kAMzgp4xK8P61Zq0w3O7t7w5vk0UfSS1hezwVTLiKhfQCLMLqtZAy9u2xN?=
 =?us-ascii?Q?BvwA1X5x+lsTdeEx63ozLoZpWtvMEQNWFyLB3mjX/VyPcEyqdcmoQJqH0JDy?=
 =?us-ascii?Q?BtyRUBzw5M31YyUbp6nRMVIzASFPZ7inHRnEBQMXA2NYsMLXu4Ffkq/eiOqr?=
 =?us-ascii?Q?rMXbn2k4ZY2FHT6FElVDZ/G/F/KQzvrNV6+ZECdQHsImq7izNii95R9CYx3M?=
 =?us-ascii?Q?wM/qdibZdXZTy5Rmp8PIpvALp0c0u5dMtoLLqCEnEo7W3Oi0EuSJlhf9CBLw?=
 =?us-ascii?Q?sMPAFchXWe0IT4cvvsLZIncan/QRh+P2oEo05cPBqgdgiIiUzs9J6ftCix25?=
 =?us-ascii?Q?5ATnbL4nLpx1mbK78NVq9hecFqY+UheVXVJDYNAPh3ePwdrx1LyUfGd5XBO1?=
 =?us-ascii?Q?u+9zrLimwWcsKjYxDlmxj9v9fIfn+ifiYjIhpiInn6FUNB6qJIRva9vscCa5?=
 =?us-ascii?Q?QEeQVQfqNhcV+NFu+FyIbJrs8npEIVZeBXWTRSr2XOZ4IP6kWtISsL5elPgj?=
 =?us-ascii?Q?qEWWZq95hYL+iq8pTs/W7R+Y65N6gDt4Xkq4u3xxK/H2nmSwFje3yLnTgX1f?=
 =?us-ascii?Q?zkVRUIE3rgtdFaYKcgJ0P98q9q7m3b5X/vXOUS7OQkKUQQzsH+CoduJd9Lu1?=
 =?us-ascii?Q?PvitywcHmTJg0mE5kr7jgKBZnYTDm3Qz5TnfuWR01YES8S9mJaMIT8teTkLY?=
 =?us-ascii?Q?glffR0l8z4dlobWyL8Ck+75cfwPk4rXBJJj1MIUX2yRsESpTi9iBoivTk0j9?=
 =?us-ascii?Q?z9DBesW9kX/9sUWapF/r8v1JmNjSO/Se9PPDI/CXHjzBY5+9xt/Z14/wjgPW?=
 =?us-ascii?Q?hVkn3ikPdi+8DY0DE8Q5i4ThjDe3dM205ep8llOTkHzMXmofB3CyZQcGzcm1?=
 =?us-ascii?Q?6EfD6qJX5O9jRoU11Mf/CKrfC5rwNq5ZSyftn5YxP5c3dlbY38kwSP7f3Agy?=
 =?us-ascii?Q?oPr71OrYB0EW9FYokZK6r/W4nHCjJ9jJCHoNx5qM+Ksa7XC8mYe01oerAld2?=
 =?us-ascii?Q?Dc8eW6Uu54PI7L3LluNjNnx5dRoOxUU0im8B000JcqigmkEx43uVXLBhT9EB?=
 =?us-ascii?Q?LA1RW7OSPHE2v8kM44OxLY2/P2ONYomaEUA2+kmMAcxipDXAbTlVOQvZfw96?=
 =?us-ascii?Q?TZmyuWG92lpaOHtDlSEHPcLy2tKVC43cyFWF8AGAruxtW0U1ZADNCGDrFMwt?=
 =?us-ascii?Q?1E3Klzs89wByalKPlNF+Y/p3jWkwhOJTMQUwEMnYhbMO4eaWkovOd4Q6AR7N?=
 =?us-ascii?Q?SLXz8LAXxM6Fh4oa/cuiEE0d9W1VI5r5bcDfO5Nd31Xv7ul+a+xU0aCp1CPo?=
 =?us-ascii?Q?FMXxk085J23I7VBaq6yiQ0+lgLlKQ9byrsVTwT0j7K/cMMhSSswMnz5wzV21?=
 =?us-ascii?Q?0JtKEndpz0fgGAkfZmgNB6Hf9LAdQRd5eA81ZanpvXgu2TOyMeDdsI8bkgib?=
 =?us-ascii?Q?4Ts5gvfngag3p/FWW3SoWVCZN+mEPMy52bVg+tiqdn27uv8fHYpDOej15xJA?=
 =?us-ascii?Q?LSSefxDA5Zbxh13L2Vt5R92vgCa6z6lj36pvUDoc+fhkMHpg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eade07e2-31a7-44b5-e693-08df2f53d83f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 09:15:26.6533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hu51AzF/CbUfuf06mr0LHuyVJ3jFlAVwvCQDTT4uSf/v0joX1oNypSMcwUiSjU79
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Ping on the series

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Saturday, October 10, 2026 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
>
> Report an ongoing GPU reset through RESET_IN_PROGRESS at bit 1, alongside
> BROKEN at bit 0, so userspace can query whether GPU recovery is ongoing.
>
> Validate query inputs using the same rules as queue deletion and document=
 the
> required fields. Drop the queue reference after releasing userq_mutex bec=
ause the
> final put may destroy the queue and acquire that mutex.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++++-
>  include/uapi/drm/amdgpu_drm.h             | 8 +++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6340e647a67d..6c4743ddf04a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -835,8 +835,11 @@ amdgpu_userq_query_status(struct drm_file *filp, uni=
on
> drm_amdgpu_userq *args)
>           queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA ||
>           queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm))
>               args->out_qs.flags |=3D
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
> -     amdgpu_userq_put(queue);
> +     if (amdgpu_in_reset(adev))
> +             args->out_qs.flags |=3D
> +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS;
>       mutex_unlock(&uq_mgr->userq_mutex);
> +     /* The final put may destroy the queue and take userq_mutex. */
> +     amdgpu_userq_put(queue);
>
>       return 0;
>  }
> @@ -898,6 +901,7 @@ static int amdgpu_userq_input_args_validate(struct
> drm_device *dev,
>               }
>               break;
>       case AMDGPU_USERQ_OP_FREE:
> +     case AMDGPU_USERQ_OP_QUERY_STATUS:
>               if (args->in.ip_type ||
>                   args->in.doorbell_handle ||
>                   args->in.doorbell_offset ||
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> 98c3fa8a4a72..32ed4c4349a4 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -355,19 +355,21 @@ union drm_amdgpu_ctx {
>
>  /* the queue is broken because it is hung, has an invalid VA, or VRAM wa=
s lost */
> #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1 << 0)
> +/* indicate that a GPU reset has not completed yet */ #define
> +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS (1 << 1)
>
>  /*
>   * This structure is a container to pass input configuration
>   * info for all supported userqueue related operations.
>   * For operation AMDGPU_USERQ_OP_CREATE: user is expected
>   *  to set all fields, excep the parameter 'queue_id'.
> - * For operation AMDGPU_USERQ_OP_FREE: the only input parameter expected
> - *  to be set is 'queue_id', eveything else is ignored.
> + * For operations AMDGPU_USERQ_OP_FREE and
> AMDGPU_USERQ_OP_QUERY_STATUS:
> + *  only 'op' and 'queue_id' should be set; all other fields must be zer=
o.
>   */
>  struct drm_amdgpu_userq_in {
>       /** AMDGPU_USERQ_OP_* */
>       __u32   op;
> -     /** Queue id passed for operation USERQ_OP_FREE */
> +     /** Queue id passed for operations USERQ_OP_FREE and
> +USERQ_OP_QUERY_STATUS */
>       __u32   queue_id;
>       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
>       __u32   ip_type;
> --
> 2.34.1

