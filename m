Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B931EC61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 13:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3720B10ECC5;
	Tue,  1 Sep 2026 13:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECR+AADt";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE0A10ECC5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 13:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuuqI33ahjLuqNQucDjXmXUzWjuI5AXbsc+6VSldsAbpztOz1pIxr5x4d7j6xyj7T/hZ/d2/2sCPkzK3J1vARo3E2A7Ou0qL5BqWqfn8gd0H/Bfz17neEmF1eH2xUQxpPxMjrNdtQDqqKA/6ww8sG6+5ExIQ86UarZ9D9nnQmbyCI2cS6hC6GUNKs4egWrixuX0oG2vu2aldmNDxkwCSWasqk/6aGJ27c3Fn9QgBprJ4INrQhjLCptSwrHEVjYj+j5ciHOU4U5f7Hpl+8guSQqQEG1wtXMjMx1FMlGkYKttXliS8Zcjv/pFJoIn7Ahv+I57O9Tsj6tvszyb7zUQBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYHSnEfocTItnh7dJ77k7TSaywBg6jx2Cb9pkeTTYHk=;
 b=r7kN52eGEDoi0x8sWds9lwYt8gGifbBcIdtrttAzY4YdkMgbnu6bdMcQXKK+sH9qZLiiNlmlD6oK6A1ZZt+UJwqr3b33suJFXThd+jqN2vRRno8N3YWv1rdApgjlrcWrZwep8HKJv7Z1opQLr6nhoW0+Gc5rggAXWrib1M312tN/+MI9LsHQVk1Daeekr3AuyB2Sk/eNwShLvgI58HKuX2RIRFkJQlB3wjvFl3EqeuT3my7sZME7zjy3SRehRY5wdTQNcsMTtm4ojj5nKv5j7YcljwFRGNFJpcF+39GzKhZBIymYDTZpVGCq66vehO+xRQFGBjXUKRCu47ikupkwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYHSnEfocTItnh7dJ77k7TSaywBg6jx2Cb9pkeTTYHk=;
 b=ECR+AADtfLGaN7G19foyM8vJQqV0IrgI7JgjHMcdLgLx7bOs4NOsrt0bmtMCdmYbjPT68Jix1cbOyOS3Ytx1MlbKKQupfmEMtyRPfT3O5ZUUOHQPZG4qAn7i+DMDRmO9TvGo02T/eraSOogGqJXf50Gx+HMaDduYuWoIJa/11qM=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 13:04:10 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%2]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:04:10 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Ba, Gang" <Gang.Ba@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race
Thread-Topic: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race
Thread-Index: AQHdOYp6M4QcvhzNZUOfgJZ0BKRqG7a5saJw
Date: Tue, 1 Sep 2026 13:04:10 +0000
Message-ID: <BL1PR12MB5898416E809BE5392EA63D9A85A82@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260831205059.1803721-1-Gang.Ba@amd.com>
In-Reply-To: <20260831205059.1803721-1-Gang.Ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-01T13:04:01.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|IA0PR12MB7508:EE_
x-ms-office365-filtering-correlation-id: c98a83ad-95c4-4d93-4bc6-08df0829839f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|11063799006|10067099003|22082099003|18002099003|3023799007|56012099006;
x-microsoft-antispam-message-info: 2YFz5cY1BA7v2o8TEDYuiPgBIkKFMOB0BB8a+iSyEH45Vc+VzcuKUfTTy5WYS/vo3edqHfwjOX+BXJJrCjs57mjQiPJB7Ks+CVRBa0kGrjxRZge1EBT5+uXHpXH2xddSBcSTCkte+PAGOdbP5xPACgLbxw1so8xeIE9Iulsegb8xbRG7efyRFkv0ULoE9H+kNqX6Fk+qDq1G9+O4ZRM9w85rk8Q/gl0u6lJ2sVhlDXHvKtHRHYPZZ7ozCv1w79JN0g77vBUQJiZog6ncgtR3z03iyZ73eLJ0Dcqt0ZzaJ4UO7oXFNqqX168KgMqviLajI/NG/W8irl4KnLjSH1VDx4L2Ka5dFxRejR7mddEKFwCV6ch13cvC7Rs/mu6IPkhzwYvA9pWMo4skCyqHa66Sz06NkL6Ud8X6Q0aDQFhms+IKIqIhZMft7zr98WyXWxOZm9BTHMQR3j8qLIX58zPRDdRkb+5mVfRU13sOKFm4UeDx3K44fefW0Z8SJ5sfB4wAdfazsnjCUVcTqhfoMAIOYkG3WpuSU3+N4L1/+IkAp7TzWw2GjJDhQv+xgUNtZo4R3CD2XbvCGlbF3NCDsGbmhg/0EaFj0UzBTPdg+N/Fw2lcXGFz26bfhONsX4dflRazggqAMF9sJw2ZEeER4BfsVy9fBwSgdkQG/cfvSEQ1wx3Gx85S9nqiV5Qxn+UqW14GB1dHg9gbqMuZVQprfupDtt0NqA0PP3GHUrjZnIHplbU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Om7gWESUzVljx5W9ueFbHAc6NRFAAcbQhdINDdEeKb1lSsoK7Q1NpiM62pRR?=
 =?us-ascii?Q?LEpWONG2LcHJGUyTA2Jxcvrem45qrX15/zXspcCfR7QyN73u1QYzfOJbIZyY?=
 =?us-ascii?Q?Jm/31sXddrAZqC10QsX7ZeQEUyWx5MWoBUYWuCZAqT/5OJl2F9nH27dpPkjx?=
 =?us-ascii?Q?b6yrshOOeCAqMYZAmf5HdYL9mqzI9CEXbiYoxsjdXu3k44l/atlsxHnD6kG0?=
 =?us-ascii?Q?ul0wOZcWgoF8QcttTogP9V/9QyPMVCR8oHwMSO+C4sWrWvnzBwcEr4+nyX7o?=
 =?us-ascii?Q?yQfIHFhnD4Zm4UpFrWNs8g0fUSiFW6DCqpLf6o+/d7cmAVq3IidtCtwW8yDB?=
 =?us-ascii?Q?ZXBbYH8Hvd047tEqz6PmS1CqNuDFFRPQFTVKVnPZ1+YO8clBTBhq7BQDKwQE?=
 =?us-ascii?Q?YsHE08CWAD5VO2mz4+qSUXY98yC8V+DBWWFMDRHTho+ld/hWpOlrh+cfEldE?=
 =?us-ascii?Q?j/Ynb8ihNQcC5LfseUlXkTKFRP4U/o+d8hlVasB8JJd3CdBErBcaVzh3oYPI?=
 =?us-ascii?Q?aRnvOgLQ5/9u/JS22VeiR+tsZs+IoScF+pyqlJmFD2yNCF5u9rge8ZvWKV/N?=
 =?us-ascii?Q?Iu4DVWOvVQChIaBj6pnj/9Y0KOZWQY8uUpVgxrHE1MWIfV3ggLsGNuB/pbqA?=
 =?us-ascii?Q?ffvlX8tAer2dazRVc2dCrzGvAKfmqpr/A41QJpkYi8xj6a1FM2xU1LCBlXC8?=
 =?us-ascii?Q?0GN7s4r09Ec9DZRPIDYrrEVYO8EVCBerUpUFQ1PFYN+d5JFcrNfmsDdfTbyd?=
 =?us-ascii?Q?18/JtiR1ahJbSzepJ6cBEEFJ/IUsdETzv58eoNtBCgdu2isDJHK5qCb3UUJM?=
 =?us-ascii?Q?NpnnwgzSIWz22MdH8/lZS1kqr4i/M4yGAsrICobQjBi7QD2LD0gODUKI9OyX?=
 =?us-ascii?Q?3eptvn1hGqMm8rjWYnp+6eHDIubV7TuGjm/7fg4rhXhTADJIrqNICogSlkFd?=
 =?us-ascii?Q?msF6h4hs46NKKRWqktY1069fCMh59+jFG/yyP4Hnl2fpSMnsluUQ5VTzbDR1?=
 =?us-ascii?Q?JDzgcszAuj6xKmXZjy0QeC1/oWPtazUz+u+bk6VKf7/Ij1tx8J+FDuJca+Lo?=
 =?us-ascii?Q?262akZ2yDKBkKWD70XXtkg7uLiNPNRvJs0o6fTTMDLStA+yQMARndpqFPdue?=
 =?us-ascii?Q?XtoXKjq+YIvhOvtdyHwyhdZErkFgrmpw7+f7BIunk3jxOIi2FZf4JiRZi5N2?=
 =?us-ascii?Q?HyWMq80/Vh78SXuQlBbaPASx3j4ug1A1UNG7HZA3HYndMNI2Z0v2wHkALqUP?=
 =?us-ascii?Q?YpVg5E7XTEVQO9sb9UZ6LMSDUmlUv/nsDfr0KTWKmXL5OMX21DYlp9TJj5nB?=
 =?us-ascii?Q?kPiEk9sDvIu9hKwgokYsej+Tk7GCOJjSB3nwmgXzmSNdRd8iU7iuqeZoabDD?=
 =?us-ascii?Q?AfnuiurJVpIhpe3tzOQQWijC2sNNrNrt8a+4bEF3BpZCWLVRb6Bpj4PoAOH2?=
 =?us-ascii?Q?4d7Xc6O8JJzcBUl1EICl0EbjmellA90LpPz8xXKyPg/LSs2ummbIwvswXkkG?=
 =?us-ascii?Q?DXyITnatGg7JZPvsrnwgCfavuZd4CRBBNMLFntO0RnIwRM+Z4NG+VSBz9NMd?=
 =?us-ascii?Q?WRqD3AXnIW+2v1yWErtulkqbq4QAMapQqkFuA5b0EzrAV1jdWZdEzooB6Tsa?=
 =?us-ascii?Q?1fTXesRc6LNcPvZyq2W/fGBHYMyksshux7pvdmb+w7qbbHazAcwSaIO834SI?=
 =?us-ascii?Q?cCZLWBavn6vJU9wH+/BQsdvy/vQGCzXsXRrHhm7MGcnIhRZ+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98a83ad-95c4-4d93-4bc6-08df0829839f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 13:04:10.4632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uG+ujRXH/C/vFI18ciWWg1JsSixg2whjVfjDX34j2sD+Jhc1FyYeAcSWCY1zEWOxTXbVwIAPOEhb5NlCcMxmWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
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

+Jay

> -----Original Message-----
> From: Ba, Gang <Gang.Ba@amd.com>
> Sent: August 31, 2026 4:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race
>
> Fix a hardware RTL bug in the TCP XNACK scoreboard reset path where a wav=
e
> receiving a no-retry FAULT from UTC and subsequently terminating may leav=
e
> its scoreboard entry uncleared when reset events arrive back-to-back.
>
> This can cause a later, unrelated wave using the same slot to incorrectly
> inherit the XNACK error state, resulting in its VMEM operations being
> dropped even though the wave never faulted.
>
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  3 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 10 ++-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       | 83 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h       |  1 +
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 54 ++++++++++++
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
>  7 files changed, 150 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 7e9f7a280c1b..2aaa9826c8f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -193,5 +193,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
>       .hqd_reset =3D kgd_gfx_v9_hqd_reset,
> -     .hqd_sdma_get_doorbell =3D kgd_gfx_v9_hqd_sdma_get_doorbell
> +     .hqd_sdma_get_doorbell =3D kgd_gfx_v9_hqd_sdma_get_doorbell,
> +     .hqd_gfx_cleaner =3D kgd_gfx_v9_cleaner
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index b30ad9701bce..81f1945c4090 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -37,6 +37,7 @@
>  #include "soc15.h"
>  #include "soc15d.h"
>  #include "gfx_v9_0.h"
> +#include "gfx_v9_4_2.h"
>  #include "amdgpu_amdkfd_gfx_v9.h"
>  #include <uapi/linux/kfd_ioctl.h>
>
> @@ -1226,11 +1227,15 @@ uint64_t kgd_gfx_v9_hqd_reset(struct
> amdgpu_device *adev,
>
>  uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
>                                         int engine, int queue)
> -
>  {
>       return 0;
>  }
>
> +void kgd_gfx_v9_cleaner(struct amdgpu_device *adev)
> +{
> +     gfx_v9_4_2_shader_cleaner_workarounds(adev);
> +}
> +
>  const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>       .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
>       .set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -1261,5 +1266,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
>       .hqd_reset =3D kgd_gfx_v9_hqd_reset,
> -     .hqd_sdma_get_doorbell =3D kgd_gfx_v9_hqd_sdma_get_doorbell
> +     .hqd_sdma_get_doorbell =3D kgd_gfx_v9_hqd_sdma_get_doorbell,
> +     .hqd_gfx_cleaner =3D kgd_gfx_v9_cleaner
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 9f43f16a1ace..3b8b7bd2377f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -115,3 +115,4 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device
> *adev,
>                             unsigned int utimeout);
>  uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
>                                         int engine, int queue);
> +void kgd_gfx_v9_cleaner(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 8b84bba58752..d3e008134afb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -343,6 +343,28 @@ const struct soc15_reg_entry
> sgpr64_init_regs_aldebaran[] =3D {
>       { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
>  };
>
> +static const u32 fault_cleaner_compute_shader_aldebaran[] =3D {
> +     0xbe8000ff, 0x00001000, 0x80808100, 0x86000000, 0xbf85fffd,
> 0xbf810000
> +};
> +
> +const struct soc15_reg_entry fault_cleaner_init_regs_aldebaran[] =3D {
> +     { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS),
> 0x0000000 },
> +     { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
> +     { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 1 },
> +     { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
> +     { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xaf0000 },
> +     { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0xc8 },
> +     { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0xea4fac },
> +     { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
> +     { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
> +     { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
> +     { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
> +     { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
> +     { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
> +     { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
> +     { SOC15_REG_ENTRY(GC, 0,
> regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
> +};
> +
>  static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
>                                struct amdgpu_ring *ring,
>                                const u32 *shader_ptr, u32 shader_size,
> @@ -692,6 +714,67 @@ static int gfx_v9_4_2_do_vgprs_init(struct
> amdgpu_device *adev)
>       return r;
>  }
>
> +static int gfx_v9_4_2_do_cleaner(struct amdgpu_device *adev)
> +{
> +     int r;
> +     /* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
> +     int wb_size =3D adev->gfx.config.max_shader_engines *
> +                      CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
> +     struct amdgpu_ib wb_ib;
> +     struct dma_fence *fence =3D NULL;
> +     u32 pattern =3D 0xa;
> +
> +     /* bail if the compute ring is not ready */
> +     if (!adev->gfx.compute_ring[0].sched.ready)
> +             return 0;
> +
> +     /* allocate the write-back buffer from IB */
> +     memset(&wb_ib, 0, sizeof(wb_ib));
> +     r =3D amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
> +                       AMDGPU_IB_POOL_DIRECT, &wb_ib);
> +     if (r) {
> +             dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
> +             return r;
> +     }
> +     memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
> +
> +     r =3D gfx_v9_4_2_run_shader(adev,
> +                     &adev->gfx.compute_ring[0],
> +                     fault_cleaner_compute_shader_aldebaran,
> +                     sizeof(fault_cleaner_compute_shader_aldebaran),
> +                     fault_cleaner_init_regs_aldebaran,
> +                     ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
> +                     adev->gfx.cu_info.number * 32,
> +                     wb_ib.gpu_addr, pattern, &fence);
> +
> +     if (r) {
> +             dev_err(adev->dev, "failed to clear MI200\n");
> +             goto pro_end;
> +     }
> +
> +     /* wait for the GPU to finish processing the IB */
> +     r =3D dma_fence_wait(fence, false);
> +     if (r)
> +             dev_err(adev->dev, "timeout to clear MI200\n");
> +
> +pro_end:
> +     if (fence)
> +             dma_fence_put(fence);
> +     amdgpu_ib_free(&wb_ib, NULL);
> +
> +     if (r)
> +             dev_dbg(adev->dev, "Clean MI200 Failed\n");
> +     else
> +             dev_dbg(adev->dev, "Clean MI200 Successfully\n");
> +
> +     return r;
> +}
> +
> +void gfx_v9_4_2_shader_cleaner_workarounds(struct amdgpu_device *adev)
> +{
> +     gfx_v9_4_2_do_cleaner(adev);
> +}
> +
>  int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  {
>       /* only support when RAS is enabled */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> index a603724c1dfc..5c911f0f5d01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> @@ -30,6 +30,7 @@ void gfx_v9_4_2_init_golden_registers(struct
> amdgpu_device *adev,
>                                     uint32_t die_id);
>  void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
>  void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
> +void gfx_v9_4_2_shader_cleaner_workarounds(struct amdgpu_device *adev);
>  int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
>
>  extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 1688d8e595f2..3a963e2da649 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -359,6 +359,57 @@ static bool event_interrupt_isr_v9(struct kfd_node *=
dev,
>               !amdgpu_no_queue_eviction_on_vm_fault);
>  }
>
> +static void gfx942_workaround_cleaner(struct kfd_node *dev, uint16_t pas=
id)
> +{
> +     struct kfd_process *p;
> +     struct kfd_process_device *pdd =3D NULL;
> +     struct device_queue_manager *dqm;
> +     int i, ret;
> +
> +     p =3D kfd_lookup_process_by_pasid(pasid, NULL);
> +     if (!p)
> +             return;
> +
> +     /* Evict all process devices before running the workaround */
> +     for (i =3D 0; i < p->n_pdds; i++) {
> +             pdd =3D p->pdds[i];
> +             kfd_evict_process_device(pdd);
> +     }
> +
> +     /* Run the GFX cleaner workaround on the faulting device.
> +      * Only run once per page fault (evicted =3D=3D 1 after first evict=
).
> +      */
> +     pdd =3D kfd_get_process_device_data(dev, p);
> +     if (pdd) {
> +             /* Only call cleaner once per page fault. Run the workaroun=
d
> +              * only on the first eviction (evicted =3D=3D 1 after evict=
 above).
> +              */
> +             dqm =3D pdd->dev->dqm;
> +             dqm_lock(dqm);
> +             if (pdd->qpd.evicted =3D=3D 1 && dqm->dev->kfd2kgd-
> >hqd_gfx_cleaner)
> +                     dqm->dev->kfd2kgd->hqd_gfx_cleaner(dqm->dev-
> >adev);
> +             dqm_unlock(dqm);
> +     }
> +
> +     /* Restore all process devices after workaround completes */
> +     for (i =3D 0; i < p->n_pdds; i++) {
> +             pdd =3D p->pdds[i];
> +             if (!pdd->dev->dqm) {
> +                     dev_err(dev->adev->dev,
> +                             "Invalid dqm for process %d device %d\n",
> pasid, i);
> +                     continue;
> +             }
> +             ret =3D pdd->dev->dqm->ops.restore_process_queues(pdd->dev-
> >dqm,
> +                                                             &pdd->qpd);
> +             if (ret)
> +                     dev_err(dev->adev->dev,
> +                             "Failed to restore queues for process %d de=
vice
> %d: %d\n",
> +                             pasid, i, ret);
> +     }
> +
> +     kfd_unref_process(p);
> +}
> +
>  static void event_interrupt_wq_v9(struct kfd_node *dev,
>                                       const uint32_t *ih_ring_entry)
>  {
> @@ -547,6 +598,9 @@ static void event_interrupt_wq_v9(struct kfd_node *de=
v,
>                       return;
>               }
>
> +             if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2))
> +                     gfx942_workaround_cleaner(dev, pasid);
> +
>               info.vmid =3D vmid;
>               info.mc_id =3D client_id;
>               info.page_addr =3D ih_ring_entry[4] |
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 01c2631bbdff..a82afc613ef3 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -343,6 +343,7 @@ struct kfd2kgd_calls {
>       int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
>                                   void *mqd, uint32_t
> num_sdma_queues_per_eng,
>                                   uint64_t *val);
> +     void (*hqd_gfx_cleaner)(struct amdgpu_device *adev);
>  };
>
>  #endif       /* KGD_KFD_INTERFACE_H_INCLUDED */
> --
> 2.55.0

