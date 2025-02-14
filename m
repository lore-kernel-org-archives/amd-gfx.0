Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8881CC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 11:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E9510EC7C;
	Fri, 14 Feb 2025 11:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kFfvdBDj";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA45F10EC6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 11:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFXWWu8dhz+4gQT6qt7C+MpNQKfgwaHuENtcwuUBNsveTu8Z+d0lK9/W9KaNIHio3YNxu56I38GfPTK3bkH26m7KJ+QbE8mwtQiqoZp0GJHR3Nqk32kQOIgc6NdO1XGhjEdNOUDvy+pn5zk+5oXsnCLCHJIVQgnoDtfpmGrDryPPrqbDdxVCueWmpw/vjDotEr3MsCcKuF7NzKvzPAT5ayVDPEBdI+demSo2K+HI62wipkqksw5t4Smx+tYSby8yMudAKBvDgtAR951XI6YHpHkxd/dQrAGTuX1PDTDiUfaQlKAmPs6LzOm1fn1F6WR9BRHYMgcUcHPaImyA/083+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho56xqez1PcCjRFn87DDd7tBjMr6d6xn0vEBrflNe+M=;
 b=AJXiI9D8O9b2zoEMqh8pyzCg9K2EscinHGD3JetAo7dByRK+4EQVVmNiEAfnqg0wPFJCd1ZHGgSCAqO3AZEune6j3xUdfwn1MRPcrivezHPd4QZdUpyBIdWy7Yf8SmG33nNXQfSM9QFZcajzgf8AZA18LDeT27M4cvXTiaWhQWdSM0lIxzP1WA5Nh3EdbcrC9i2twNtUmMDx1+k9Mfqo22UMbz7g3iibtjgJZSLaSHvhRX6NIDfmTNbsJpR9BSsyFL/JEJdLKRAWSC8fnEiTrzeXg3ZorcG19mrQlzlSGRiNGM9YnpV0eBhyWnWB767avkz0U0EiI6XdK8e/EOjAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho56xqez1PcCjRFn87DDd7tBjMr6d6xn0vEBrflNe+M=;
 b=kFfvdBDjmSer7hTQNs8QheOjryo51gVwLSs8owTTBZfv1DPOXKKhfnYc/CquleputRpwK0XTFqXy3uFc+U7kbJyXrjL6Yy5WOiusoY5+myQXwGk+z8f0uZD2RaTlX6P9fSJqErVAQNMa0ZU8Vemf9kTa61ju2mwETYNG7Foy9LY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.17; Fri, 14 Feb 2025 11:50:04 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%3]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 11:50:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe reset
Thread-Topic: [PATCH 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe reset
Thread-Index: AQHbb82YujFaReMcFkW+fcrvOi+6o7M6JzUA
Date: Fri, 14 Feb 2025 11:50:04 +0000
Message-ID: <DS7PR12MB60056CD1398B0FED3BF04C23FBFE2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250126083733.3331474-1-Prike.Liang@amd.com>
 <20250126083733.3331474-4-Prike.Liang@amd.com>
In-Reply-To: <20250126083733.3331474-4-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f2938400-8c81-4fa8-9391-4962a9dec12c;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-14T11:09:26Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: 3939d9e3-2a7a-46d0-59f1-08dd4cedb8a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EDVi4rjz6PhtILmdaQWyZyltqZ/yMNOLsyLasmYqENET0uiw0xxAVjYtzgdD?=
 =?us-ascii?Q?sAI8Tsf0mY9mr39x4jwKF6Cu0xGOIr8gDX195BwiFE6KxYElRdW/O+NaDoaO?=
 =?us-ascii?Q?cw0RCYschSbshUaITU1vOrSSqzCdIbY66oAI/I3TG9lW7II/qC+b5wIudRz/?=
 =?us-ascii?Q?vt8SlLd4LX4FaCZ2d0gqG4a+8rk+YCns93QwC15VeLVHzXy8HNQbgfCYwi5R?=
 =?us-ascii?Q?XVLOssQn+3AldhXTaC3tbfds//3AGGJx9Ot0bcDJxK5y6lBJn8hvB9n+rm43?=
 =?us-ascii?Q?LJYhuqyEMPnwe0cV8V/huUTHOyfKC8dphqs5cL3E+urZSGcwy9REMxkI003q?=
 =?us-ascii?Q?F1f8rn26jW9YQaH0RNrGBD7QF22QeLBfRcq2me3+ROiO0LDi23tLSvZYJtL0?=
 =?us-ascii?Q?fvgsyVaWverf5IhCT30bmj8deziIHHLX184hbXIYC6wV021zfoH7zwoNJHtI?=
 =?us-ascii?Q?DpJ2nxdi+f0dPOFkXsL/cVlunzwcrHQO++HWOKL28+UKCCjWc1Ae7O62kR5G?=
 =?us-ascii?Q?LZ+NMrOcRjS6fzsHCuLpcfV4fjNhR9UjFAQKW/e3FzIYe/3rsklAn/W9FkLf?=
 =?us-ascii?Q?Fhd8y+xFvIrGcpGwD5Abz+wUVNCUr8O3CBcn0qauHvzeZFiMXTDst5zDi+5N?=
 =?us-ascii?Q?hgUUZ23JGUkkvlqZoJu6Q+yZmzBaCorJXtaqBxP5mJWL+uCXq7Zymulzw0gd?=
 =?us-ascii?Q?vIOavRH0QOjnO/eehuerBALpD4WDHhd67VttegkLvZoL5drToxYohTd6hHlZ?=
 =?us-ascii?Q?utU9mMMtWPUZ+gU2iq+cfhFo3ANLYRCSUEAiwzHFsEaZI6e17p4ElnYnPvg5?=
 =?us-ascii?Q?dDmXbhvqyjfXWyetQhuyAKK6RhOY6DX30rVxAXsWSF+3BevxMCgE+KR0tMjf?=
 =?us-ascii?Q?M79wkfO/6SZFwL6CskDaQbm7eM3xIDSddXbhJXaM7hAlW7oRwNqSn6/C6RAI?=
 =?us-ascii?Q?3gnY55p6VzBmCjPHFv7WMb4H7oQeqPG7Q2qxOL7C0hE8IoA7MIlJDOXhHNQL?=
 =?us-ascii?Q?PqQskowKxbePXbb0JIcLrCk9gGguz5N4+cwMLaQulyf3Cei2Z1GAlLy4oCJ4?=
 =?us-ascii?Q?Hqy24koKxRaFKqNo3fDqUMW6hLNqaMPSkCsay3X6Xly3OyJ71mpVEpOxyhUR?=
 =?us-ascii?Q?GDWiKb4oG+TpHlxQUXnQN05BiQKg0lulsFJ6ozI1JBdWeQgEtLtphCARlOow?=
 =?us-ascii?Q?CnK0nFvvg5tMFHsuhACpyCKHC9MXaOu04y7rg/CZCH86oAbhDk67/sFXiTTc?=
 =?us-ascii?Q?eFEmgcze8LGK3xebicOL2LFAy4OsjHcKrbuXGPQCMRzVQSSsJVnyjnxbrWFc?=
 =?us-ascii?Q?xdKF5ITODdQvk3CXRZ9gStXA1xoBItcayDSGIbrgS0izvpuIEQDZY2heQGuk?=
 =?us-ascii?Q?24ZMV8glmsb530lLgVeP/0bRDpQVoe9TFYt/JCi/rIOU8L1B4uq3/C7f1auz?=
 =?us-ascii?Q?EN++/a+2uRRPOcHomrNqQwH3mPCqXNGj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BIO6PBUnck/hfFhBYWsab3W26wDs2PgdWTysx42M8i93d1RiqRgtcmqBS0NV?=
 =?us-ascii?Q?ZHH62AFSK1sxLwXnN2u1hYpbOwDZl+0JOOws2BGgCtscJF+arVlbsdVMqjmj?=
 =?us-ascii?Q?41DnoRjK93kSHwhSZfnuMCX8HdOb4aG6Y2z84WtCdOPlyqyl+NquvQg78BBB?=
 =?us-ascii?Q?Qfw0asJt0Fz4OqvaqLTTYuLNqFOSsmMZuZLh3IFN8vWkdmteZgC+mwSTUAOa?=
 =?us-ascii?Q?1urGu3v+PtLsDC6Pu1duRrymFZZpQ5QK8QicXKlNiIZKimwph6mX5ksetyTE?=
 =?us-ascii?Q?+TMcCMQMWU4oUr7hafoPjEeH4eJrm5mNYgYjQHmpcR54msdKMihgJ9X7p1n3?=
 =?us-ascii?Q?tcKFOvvn6xL4RECdHJSSJd5n1wpbN2BM2oXH9I2MJ7OzQOww34kKwuZFCbnV?=
 =?us-ascii?Q?FpCp2wjHDjvQSDTsuAa7xYNF0N8DRIxVHvw+Jv6r58IddrB7I5c/U7SyMLNG?=
 =?us-ascii?Q?ndlsOAC2cjqvM0ISm0yZi9nvAF2I/VKt2TtlndDfI7LPX8UHJ2tbgwfpxowe?=
 =?us-ascii?Q?5ZL0161ocj+toTrKGd0ss/AdZwYyX5FpcGjsuBCo+LRhLw8M5/XhEC6eivDb?=
 =?us-ascii?Q?Q5AQHNqbI6oGHyRzG9LU2UbDFCJS6WOWAR5Ufw+AGhb9Eq+xEK96zuBdu+mX?=
 =?us-ascii?Q?VmK4XOd+eTfr7jAxX4RMW5ypIJ+CAh3TfrdABXt3dzgJVxTanQBsJF67hreO?=
 =?us-ascii?Q?56ypmOB/XHqRnOwOIRB+P0S+ptV0Rw9i+XoWREqT0Zp8JsfurgH4AoYmEaEQ?=
 =?us-ascii?Q?BQOzYuKZ1T+j41iEWMO5nBTv6B5Fw1yxto3ohSX+VqM1Zl7g1HBn41ZOzU1Z?=
 =?us-ascii?Q?P+bXvWg071gpumeRtzMD7p3h/A6fUtt6gub4zDe05KRUrr3bDLL5sPHN4z4B?=
 =?us-ascii?Q?fDBVOip1yaZJzB5hH94edsm9ky3S6faAmc2lLG4maod2I0Qj47mR6P3gDtb8?=
 =?us-ascii?Q?Me0g8i2jSV8maYtSRcWrS2JmjF4Ro+ed9AaVSEOFEfj2H13fhWdd+chzVMvy?=
 =?us-ascii?Q?WBH62qvo4c114W5O3dzbxgwjQkdqiffzefzsh9l5d7Vh3luJoDlQ7Wjj8/6+?=
 =?us-ascii?Q?5I6K5MNuvRXFsO5MfaXgl4rmhCQzYVHxCuIKqyTWE+gyjdb48DmcAlG+S/5e?=
 =?us-ascii?Q?LCNFsmShSLeOf9/eU77WfTzNXJC80J+JIdy2BSKK1D5L51uRC5ioYXM7wLDr?=
 =?us-ascii?Q?t6/J0VgmH8no+bP8MDulLNVzi7Yqpx4eR3ZN2Z9zxg0DuNF6Mf2isUwXF90/?=
 =?us-ascii?Q?gh0zjfx2uRDGLnIfCdVhpPB83WpjMoQf2QxqBVUdMbkcr+aRzK4PMuNO5owe?=
 =?us-ascii?Q?iTrXF1sJ4iKGcEZhu+lrpiSGQDXT6FOrg2ZLydV3Kfx79CLGrQXMTVz5hZZx?=
 =?us-ascii?Q?Z8zUlugpKpIabzVSviXFKHH8nEB5WhhKsCBr/iM53mPZy1wHtfYs2vBJIqDR?=
 =?us-ascii?Q?bB7I+p23XFw9/r8UKuhfraeS3m+DWC+FP5HEm0RAkBfQwJSxQssHwsVAkLNe?=
 =?us-ascii?Q?hKY7yorzknt1dhpvaRMHweGwFFUwhOV/zM3QiKMy1u66XsgDbXsaSyLQD8iO?=
 =?us-ascii?Q?fQJJ/QT44ynJFYwV6k4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3939d9e3-2a7a-46d0-59f1-08dd4cedb8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 11:50:04.4777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcs5BWyUE3hVFLS+ehIMwWgptwF/G3fsQwUdhHrttC1Dk/VC5dHXDJuZRZ7n732m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

The implementation of the gfx11/gfx12 pipe reset is derived from the gfx9 p=
ipe reset sequence. Consequently, the driver sequence may not undergo signi=
ficant changes except for incorporating gfx11/gfx12 firmware support for th=
e pipe reset. To reduce the effort needed to address merge conflicts, could=
 these series implementations be advanced to upstream?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Sunday, January 26, 2025 4:38 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Liang, Prik=
e
> <Prike.Liang@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe reset
>
> Implement the GFX12 KCQ pipe reset, disable the GFX12 kernel compute queu=
e
> until the CPFW fully supports it.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 89 +++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 14ea7c1e827e..c5d07d5aa495 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -53,6 +53,7 @@
>
>  #define RLCG_UCODE_LOADING_START_ADDRESS     0x00002000L
>  static uint32_t me_fw_start_pc;
> +static uint32_t mec_fw_start_pc;
>
>  MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
> @@ -2127,6 +2128,7 @@ static void gfx_v12_0_config_gfx_rs64(struct
> amdgpu_device *adev)
>       tmp =3D REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL,
> MEC_PIPE2_RESET, 0);
>       tmp =3D REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL,
> MEC_PIPE3_RESET, 0);
>       WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
> +     mec_fw_start_pc =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> +regCP_MEC_RS64_INSTR_PNTR));
>  }
>
>  static void gfx_v12_0_set_pfp_ucode_start_addr(struct amdgpu_device *ade=
v)
> @@ -5356,6 +5358,87 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring
> *ring, unsigned int vmid)
>       return amdgpu_ring_test_ring(ring);
>  }
>
> +static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring) {
> +
> +     struct amdgpu_device *adev =3D ring->adev;
> +     uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +     int r;
> +
> +     if (!gfx_v12_pipe_reset_support(adev))
> +             return -EOPNOTSUPP;
> +
> +     gfx_v12_0_set_safe_mode(adev, 0);
> +     mutex_lock(&adev->srbm_mutex);
> +     soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +
> +     reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +     clean_pipe =3D reset_pipe;
> +
> +     if (adev->gfx.rs64_enable) {
> +
> +             switch (ring->pipe) {
> +             case 0:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE0_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE0_RESET, 0);
> +                     break;
> +             case 1:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE1_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE1_RESET, 0);
> +                     break;
> +             case 2:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE2_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE2_RESET, 0);
> +                     break;
> +             case 3:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE3_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE3_RESET, 0);
> +                     break;
> +             default:
> +                     break;
> +             }
> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
> +             r =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) -
> mec_fw_start_pc;
> +     } else {
> +             switch (ring->pipe) {
> +             case 0:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_CNT=
L,
> +                                                        MEC_ME1_PIPE0_RE=
SET,
> 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                        MEC_ME1_PIPE0_RE=
SET,
> 0);
> +                     break;
> +             case 1:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_CNT=
L,
> +                                                        MEC_ME1_PIPE1_RE=
SET,
> 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                        MEC_ME1_PIPE1_RE=
SET,
> 0);
> +                     break;
> +             default:
> +             break;
> +             }
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> +     }
> +
> +     soc24_grbm_select(adev, 0, 0, 0, 0);
> +     mutex_unlock(&adev->srbm_mutex);
> +     gfx_v12_0_unset_safe_mode(adev, 0);
> +
> +     dev_info(adev->dev,"The ring %s pipe resets: %s\n", ring->name,
> +                     r =3D=3D 0 ? "successfully" : "failed");
> +     /* Need the ring test to verify the pipe reset result.*/
> +     return 0;
> +
> +}
>  static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vm=
id)  {
>       struct amdgpu_device *adev =3D ring->adev; @@ -5366,8 +5449,10 @@
> static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmi=
d)
>
>       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>       if (r) {
> -             dev_err(adev->dev, "reset via MMIO failed %d\n", r);
> -             return r;
> +             dev_warn(adev->dev,"fail(%d) to reset kcq  and try pipe res=
et\n", r);
> +             r =3D gfx_v12_0_reset_compute_pipe(ring);
> +             if (r)
> +                     return r;
>       }
>
>       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> --
> 2.34.1

