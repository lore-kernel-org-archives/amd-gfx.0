Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DCECC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 13:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034D410E0B7;
	Fri, 16 Oct 2026 13:39:22 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A632710E0B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 13:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkHTi8uKSQtbNBHh2j6InpOm7ouVKK6P02l97j3g+37DKGTCGxvUczB6N39ol4CzQG8qnyOs5Gk8W6zJsaX/B+X/F0i9EoA3EaXSekEqErd+6NrdEnbrISqjzGB9ZDlZD1HfIClcdg1ZpOz+wh3HO0bZgukRlaLSJEo7bw8VwBoatBTTXGsLW2+zDr/ylDa20HR5SOHn28a4WtF+FOXBpmUn9cNckLqUUyjPrqZBG1DvjhW71sTOcedxnBkgibrhtl+qlUxeqlK3x39k6YCxAIAHtrK9sZLbJBDC2BkCaJ39lXz3XLWFOqwtf9QuwEK+99j8wemASkLogx0oHA+RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSIbM88gCD6sw2sziAjfSfutUvs1StLhJRue7Tn/RCE=;
 b=xmQhluixKfHv8qS+O0o3BuiFlQtqPDvqIlkxGkjDWTVBleTmFWHTICGwuQaiYfcYFcVIfPkRrB22uv2qi8ljs1+rgvJ+8DeA9Tyx3b/IcaTx9c2VDZi9J50jHI28o6liEE9QsVat3yARrtozB+1thMbbQ6jD91HoEvB99Dpvk1SPMVeNERkvWXjwuQDdKmgSVP4FtzPo/LUQuzITOWddaHY+LKLPu+Q2l4SJy0Fc5bFtNjTgWzu74OaFWqMmGYfLJ0FROxj+I5jwr24qbzc/mU0PDycMD8c76kaDbdgkC2PiQvUH+Mjy8HaRKrdfRWdCCA71afZvfb6msj0kF5Fh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSIbM88gCD6sw2sziAjfSfutUvs1StLhJRue7Tn/RCE=;
 b=s3u3nbUP55iA/pUlX67ifV1aGVfzfy2S6z/0ZZNf91pwzURslHIkEvTUBXMth0abnOjZ4LBDzaUFE3v/8/07TqIzXKvEBdJFo1NSlHIMFek2k6roi7eqDI5W/848/xnkp55teQJFCoPRUqNNWaY5BlOS6W2JpDDnCLgxELvHdLQ=
Received: from CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 13:38:11 +0000
Received: from CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1]) by CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 13:38:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ming, Davis" <Davis.Ming@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: RE: [PATCH v4 2/2] drm/amdgpu: Read SMUIO GPU clock on GFX12.1 VF
Thread-Topic: [PATCH v4 2/2] drm/amdgpu: Read SMUIO GPU clock on GFX12.1 VF
Thread-Index: AQHdXVQUER9s5bnu4EGw7r19oLCYPLcALB/Q
Date: Fri, 16 Oct 2026 13:38:10 +0000
Message-ID: <CH0PR12MB5139DA16B3329B1FB999375BF79B2@CH0PR12MB5139.namprd12.prod.outlook.com>
References: <20261016095224.461911-1-Victor.Zhao@amd.com>
 <20261016095224.461911-2-Victor.Zhao@amd.com>
In-Reply-To: <20261016095224.461911-2-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-16T13:36:46.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5139:EE_|DS4PR12MB9636:EE_
x-ms-office365-filtering-correlation-id: 7ae5c9b8-11a8-420a-90e3-08df2b8ab87e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|10067099003|38070700021|4143699003|261009223027099003|11063799006|56012099006;
x-microsoft-antispam-message-info: JBKtw2oHbkLVxOwrXdmVxgRqv2SWTBzoHGcj9ybpFSF/Xt9c2EdYnQX665n7ZlT5UaQm29bJBeIN5abydc+cUbibhMkRiUepJl43jqtK90LU7g9UekBievYQrpupriirsJUQXxHoQ+SWHy2wy4NR1PcG1Zn9AFtpHZEREhP1YE297NITluaD5hCA/UxNT4NBATRddWiUhXTQRwGm29DXHZKDRK3Iy8E2evbxEpUslYMGOwjnSIYSLODlZHq1fP0CSIAbpDQyz4HqSVPej31D9/Kz9XYXFb2IxbVdEf/AlZyc2IASvlFkEFTdrFyhTAnaR/k1BdG1dMEiT1kWfK7tWf7YJpXhWo2uIKWJ95xRBevoaGrMwvvNgV9xLGUPx8iiMT6jFFrQ4DCV6P1szWqTjRg5qoTXn2zCGPApsJPnqXSeA1+oTByDHfnq1sTqIj6gfg5KSB3lLP8TKWG4VMkLKComa0GSskbcLh11ULrhvliBRFajN/x4Hc9D8YlcfJ9V8U02B6if2RH+5tlPoogrESVbmuoz1uAUvpipT5NJTIvjZ+AikvaV5QiTJsm1f+XmWvigf4geuYJZgu+qF2pAT36GSBh0mz5vUZdwic9M9Mvuzfet+oUjEtf4HPOhO8E4NkbEqSJo06tZ1qOJBJzO1MfKZL9BWFhDP9O3vAocar55sNzxn8Pl7R3VRCFe8b2ptkaj6iq9mSOAHAJzzsy4Sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oz+IFyJAStZwNfwm/N9u2otzUoom3FYPdeO0xTn3xkhsdwxvtl6Zp0I2TezS?=
 =?us-ascii?Q?fy6YfcU5OK4geyyYfCwgDFjXkrAKw6hgTQmI/ugQn7O0azXTYUkKIlm/BLhq?=
 =?us-ascii?Q?oIyUtaF5ZXtnwxAe4bFk3vbM5B2u8jC4x0sq7WzfM2lwef0sA3TPEDXUzKuA?=
 =?us-ascii?Q?XjpISphbJ1AuwXgvDlaalq5y0J6pP4KrVoFxSPl4QpPaTljm6YyAO04TaPAI?=
 =?us-ascii?Q?GdDijtarlvgtB9FV1oMi59gNS0+ZfCRfHAMCXK3iwYLw+Xu4SM6v+h4HnAlD?=
 =?us-ascii?Q?aGkAO1jNe/dUuXPvnhv6bbYpAcy2uvMwt8q2+4b7libgi7gQwOqUznEknDG2?=
 =?us-ascii?Q?GGezvqrT8vcmbYv6RR5PvcHpPB6w0BkeWqowkLX7hQjAowKaUZSiK4UF8IKb?=
 =?us-ascii?Q?yyZb656I+5St86/PxzIUZ++LzbhNdKas2PyTPI5RWYLtrZ43uggxNTwEW2sO?=
 =?us-ascii?Q?pyPZRVnMYt7E+gNZy80MJ10cN14enUkJ7CsJJSU49VftKpSToHBQwRdpNTZa?=
 =?us-ascii?Q?eCRmKHxzAsRKV2rCZAJTUgLfqLOxl8dSTmgyxQS0PCo66GCcVa3PkbFH6Jsk?=
 =?us-ascii?Q?XN/0UVx2Ze/LGCGVDoVsSPVFnWv3wrENJORTlbIR8TMVcFVpYwZbhmys/xt3?=
 =?us-ascii?Q?q4P9+K2k7IMYeYDbdxlQRoyhnIBJt9swTNoIdZqmFSFA1K7nTPE3toeFFzeR?=
 =?us-ascii?Q?AdKq032yllp9YzEwFzsPFDC4fMh3b7XPebfoB0aL7dIN9n4Tor3MGZEAQfhA?=
 =?us-ascii?Q?6wCrEYKkvaZj4Fivm/7DWGQoZAGToG1yepfnUNxmGlrxbanXWdJRBaewYodd?=
 =?us-ascii?Q?ZiTbPy+deQUsWtNsmT14elAWyd1gmpBYKbIiFaQhsuj+9znX/KuV10CVe482?=
 =?us-ascii?Q?hDi0OzUb5pT1iORzpdB6xTqxj2VDPQPGOI57KDO9qbVY4SujiW7iqpf62OEP?=
 =?us-ascii?Q?Ekpqv3m6A98F+briVWR4b2Sl9eqrzKaKjOpz6fHCyWNB52yg9NSbDUY/h+q0?=
 =?us-ascii?Q?cTVY+d92J/HFDYCzn4hCjqeqHRuJTPbavY6TaO/NIqsrbpLNtGKHJPbagmfv?=
 =?us-ascii?Q?16qbmc6KaFil/bdB8KjfqsEH3VPBc+opoXJ4gnQq6BDkg26MnOGhW9M1Z6rf?=
 =?us-ascii?Q?vc6nf/IXTfZMYCLP6CGljLB9Ilb4NKQhpRXFqLgEDOMDNvV8rAr7wDWxYf+B?=
 =?us-ascii?Q?k+TBbJqFfBPOgH0QdRz655CW4XqR7uW6GhLODrzhxU5J6gxfkvW8LmqrtEkT?=
 =?us-ascii?Q?UGGiOxQ1go0rTBo/igCMPpCuo2k56bdEbhs+zjdS+Cdy2ODrDkpwtcA+6vbu?=
 =?us-ascii?Q?k7IfmmZ/QUEZc+FR2Y4zBC6RAqE3I40YDzlNRLqUy4KN6hnf3/4AhpLxdZ6/?=
 =?us-ascii?Q?i9QQE7d6gto0PPfvNWqt79ZT77Djb0eSzCPBF81/R2Zmf6DS+22ISof92+qM?=
 =?us-ascii?Q?Ud1+C3boYZBHHSNVWQXSJw10G4n12tZtRHV5k16G0Pk9EbBrX/zTqFz1H9Bb?=
 =?us-ascii?Q?V2wgXnPl5A+Ymb3GB6GhDTq4JBVjAug5THDUsShfVS2a7uqghT8JVSPlDonX?=
 =?us-ascii?Q?RoEb4Y/Y21DnU8YTo5bmDI3MJIWStRqLXE5eKg2Hx3RRwlrurxHsvG2thJEx?=
 =?us-ascii?Q?7vA/1iUQzohMXEAw+ZZ3lsX7bS+2YoSnpn/Bb0YhnuuMsFbnyJjRDkcs85qD?=
 =?us-ascii?Q?92hSJXaR+DxJwUkxjoKMzqfF+aKKFb5Z9W0ygGSCDxSqdwpm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae5c9b8-11a8-420a-90e3-08df2b8ab87e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 13:38:11.0228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EV7cGGgQCoXe4qHQyzS2QT4HaKjSgkg3W6co5oi4q1VYAVyOIoxNU1iLVGvhW4aVvbw9hWA+i4hhpxyRfKLzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636
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

> -----Original Message-----
> From: Victor Zhao <Victor.Zhao@amd.com>
> Sent: Friday, October 16, 2026 5:52 AM
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Ming, Davis <Davis.Ming@amd.com>; Wan, Gavin
> <Gavin.Wan@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Subject: [PATCH v4 2/2] drm/amdgpu: Read SMUIO GPU clock on GFX12.1 VF
>
> [why]
> GFX12.1 VF timestamp queries need a SMUIO Golden TSC sample, but direct
> SMUIO MMIO access is restricted on VF.
>
> [how]
> Read the consecutive SMUIO Golden TSC upper and lower registers with
> amdgpu_mes_rreg64() on GFX12.1 VF. Swap the returned dwords to
> reconstruct the counter value.
>
> v4: use SMUIO Golden TSC for GFX12.1 VF timestamp queries
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 26
> ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index d6f70d33201a0..93c8f8e449bf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -37,6 +37,7 @@
>
>  #include "gc/gc_12_1_0_offset.h"
>  #include "gc/gc_12_1_0_sh_mask.h"
> +#include "smuio/smuio_15_0_0_offset.h"
>  #include "soc24_enum.h"
>  #include "ivsrcid/gfx/irqsrcs_gfx_12_1_0.h"
>
> @@ -3168,10 +3169,35 @@ static int gfx_v12_1_wait_for_idle(struct
> amdgpu_ip_block *ip_block)
>       return -ETIMEDOUT;
>  }
>
> +static uint64_t gfx_v12_1_get_smuio_gpu_clock_counter(struct
> +amdgpu_device *adev) {
> +     uint64_t clock =3D 0;
> +     uint32_t reg;
> +
> +     if (!down_read_trylock(&adev->reset_domain->sem))
> +             return 0;
> +     if (amdgpu_device_skip_hw_access(adev) ||
> +         !adev->mes.ring[0].sched.ready)
> +             goto unlock_reset;
> +
> +     reg =3D SOC15_REG_OFFSET(SMUIO, 0,
> regGOLDEN_TSC_COUNT_UPPER);
> +     if (amdgpu_mes_rreg64(adev, reg, 0, &clock))
> +             goto unlock_reset;
> +
> +     clock =3D (clock << 32) | (clock >> 32);
> +
> +unlock_reset:
> +     up_read(&adev->reset_domain->sem);
> +     return clock;
> +}
> +
>  static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device
> *adev)  {
>       uint64_t clock =3D 0;
>
> +     if (amdgpu_sriov_vf(adev))
> +             return gfx_v12_1_get_smuio_gpu_clock_counter(adev);
> +
>       if (adev->smuio.funcs &&
>           adev->smuio.funcs->get_gpu_clock_counter)
>               clock =3D adev->smuio.funcs->get_gpu_clock_counter(adev);
> --
> 2.50.1

