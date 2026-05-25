Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDD2CD5BC8
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 09:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BE610E04B;
	Mon, 25 May 2026 09:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iPXXd3Bq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C432810E084
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 09:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGy54LZUEAlVtRz1nU644MKc4M9M8I8qu3MOmmjkQ8/m1SoQWw5WOLoPizlxJ4jGKXOef0/6JlfcOVk+joXJToOYYH9BaEvM8UnUtY+/cMpHi+hSdnIqGPOo6j9XmjBnwPogSz7JIUsIexsvoIKNKi9ZXJXn1yi2wZZ3wW5806k8+1JV9n4oNpw2QJGxNtGQyPQeWlJnSA7VqdJTIocoQODjaSedpTbu6wc7jEeD70bR6LpLHVc39wvOfqEmSW5iVdNT+/BG3+i+VNsIG6mpczkDJsEUx7B8dhU/PSVwDgSVrhbhsY9LvXAXSLm3PNMkPRrT+sL9kzdzUSkkeWbCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obDU6FfUDlSqSWN8lemz3anv39GvAOHBkp1cSRQ8rw0=;
 b=bFiwTy0rHfOIv2CZabH8GVcg5B9nvaimh44Lweqwa/EQmZ+eduWczDdLoN1V8Kh90N8A17k0APGNK55Y0mHlTnHiEuvPgOMeyjxR0fqy6r962bPf8Ep+RdLZgQqmOD21TNCdg4b9e9ejwlIWZn/RyUMqBfFN8I1B51omimFBtTe6x6weuHeQxEFsfQo3f+wZBsZl6ydEgmsszFPLGxV3RLP+LKS+f/isqZafs5PMaomknvu+ARlixxeU7s79h3UJf79BLknuz1wWpALuRdWEdc9Z26xH/F/BVOvbnK6ulJLUjcwHISyas6MPv1E857gym3WWtBh4P31LuMJbGn/Iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obDU6FfUDlSqSWN8lemz3anv39GvAOHBkp1cSRQ8rw0=;
 b=iPXXd3BqJkmDYsve6ZtRRzDlFmkTssEEWUZHqZmQux8qKy1/ZXPY9ZTbE74SCOu8lsDpihJRO2KbIsHXWfYLNk1yfxIyKO+PI5WJxzUH/GPuT+EaAJ+D6Q8yR8TPdueZiT7cmvvpe9JixWVEzl9VJ+WbU/+jNa+6P6YufcAnP04=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 09:39:27 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 09:39:27 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 15/42] drm/amdgpu/mes11: move pipe reset to mes use_mmio
 patch
Thread-Topic: [PATCH 15/42] drm/amdgpu/mes11: move pipe reset to mes use_mmio
 patch
Thread-Index: AQHc6YEI5/pZLCpFdUmSmxT3aShzuLYegaew
Date: Mon, 25 May 2026 09:39:27 +0000
Message-ID: <DM4PR12MB51528283F84DE77C768B2FF5E30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-16-alexander.deucher@amd.com>
In-Reply-To: <20260522002048.98506-16-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T09:39:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB6008:EE_
x-ms-office365-filtering-correlation-id: 0cc3fd66-3e48-47c8-68c8-08deba418382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|38070700021|6133799003|4143699003|11063799006|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 5KKuiAhsDlbJG7//5T1a/S69BingwVTSHv43atmUsDHzO8LLM1G99PY1sCpk5lrsLT80fbgotZPVT3+5d6lg/6eyxpvP2Sohx3yD+jNVTLAGHv5ml3iOd4OV5Q8GToKJZ1bLpyKmoMH1VhsZqj9zmrVRuhETIDzbJdRUUwb6Lm1pkvUhq4hSZhl+a3NRlTbR6fTTBCKRy3EcJmzdOT3mY2xc7itRHgJ/6+z+T4KwInGAPC4mxmE7jIpDPwPk13P0VESNvtBNbP1YP0SzFZPkLAw++6Ah3V1ehKK0WiA8c1iIbYaiTBwUGahrTzhhK9o4+G7zI3jfJksQOr8dl90uIGuZB0aUVLe/6n07p+OydxlmGC88vqU3Q1aW6uerW3iZqHfUAbYRJg3Pf7gdwwxSoHapM/HaOoZ/Be/qjIZ876H6G/VH11UYCejZcBPgU+KJlaV4PwowsPu5OfYH9qhqkwx+RUFuhSpFd84Tf+mDnpKjzxbCwp+wkPlP7WSBxQwgAlKhWf+uDGyhw2UDkgx/NZqdyKkfWqUQxqPvnNlmxhqbzc/A6XxiTIHer2ZKJYj+Fh2Yk7TJpc5JmDecUTl8lDve2IAS0Tk8o1OQnMzMI+AeVSWkckxd+uU0Zq6CgDooQ4Y2SXsK2TZdMFVfyBpBINBsljrTX4qFOYHpxjKOapUpA1JMY2IzxpKT+wiCdMgqhqACIrnXaL6hJVT1zVT+4BMCUHuq06eMK8uMvtZX1uuA66nku9wGhmKG5ZZ3/CLoXlasG2GRNC2AxVmmG4BaDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021)(6133799003)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IdwnZzwS8R8xHKaFni7ufRm0fG5XheI2msPjizdVBCKE3vc2LILgtQzMJxpv?=
 =?us-ascii?Q?qMFkNpoPQyok9d7FuBucyGe/9uAbfzbi3nB9Yo5lDQJs5LgNM3F7Uw6qTKZ9?=
 =?us-ascii?Q?vd8qWuKF1AKfehHNk+HKfwt90uRTjGBlSJDKsdmo+jofGGXhxAQwCj4jqLwT?=
 =?us-ascii?Q?nS2OZRYu1UfTHgBjdWrZxyurB4dPTeQcYHhZlLYNfRuNFU/nBAMX7i6Cfpy0?=
 =?us-ascii?Q?cB0weh6Ec80Jms3mlMb7wYryDtqXankfe0f9rOnIQmQklbkWvenvvyI9eOST?=
 =?us-ascii?Q?iNn6OAQBmCS9uDul+4yhizdmXkg7EoeDGbC5V1fCBLKgF2pBBRxnwXUBdihh?=
 =?us-ascii?Q?N7WAilD0T0s9SvDclkGtWfIpDXiY9iVPseAO1Csrv5BiuctaFGbwcxFgCiNP?=
 =?us-ascii?Q?+C5yHWfdFx2zXbH4WZCYmC3Qu1mIj8wO2y+vS+sjPOS6OmHYUU2ho2hxpIYf?=
 =?us-ascii?Q?HOka7tHzb+EfnGGl/Pt5OelYHorlKUcYC40HPE+lT3ak51/9RE0+IwRba+Ti?=
 =?us-ascii?Q?8vuMqNCylmsF+A8MYn2/c/5W9ulDwmhRJIwPRduz5cC9ipC05/LNfPRrufHh?=
 =?us-ascii?Q?tixbHnxGXT9yM3z9yaILRfhG9245lshW8x4oPqP5ZR0VHHwCEhS0jgA0D3ps?=
 =?us-ascii?Q?Y09ncPMDB6tMXzi89DfhLnQEPa0EIwn/sLhGFf8q8a8kh5rsVUzAp4M/mgqI?=
 =?us-ascii?Q?m65X6SeXRluVcDtew8Dz8GJtHD37qCBcZ7jg2b1TQ8j8Jl0KVQQtDmF/pv7/?=
 =?us-ascii?Q?+rCH84u0jFI6E+opRlfCfrzFlnWd3yqyN1Y+rYhGbCwNsgYCsD/vOdKbwApm?=
 =?us-ascii?Q?edbs0ZAEeVGfMw51hC48wnMzuLPRMdmnODyEFhStKPTVDIuRV3YWMC5PiPrC?=
 =?us-ascii?Q?muuA16tencMoIqN/vwhciX6kO4nuOpkGHF15Zm1YdaLMRBmQILbFv3RryaWL?=
 =?us-ascii?Q?5dZxsrZTdRKmEd685bzlkxO3LO3ojYJk82OZaY3IMb8yBMgaE2JTsCac1ytB?=
 =?us-ascii?Q?yYI2qo3fEby6GkFPYQ5Ckyv+UaB8nsBgeAuiaalJkc+FXnOGlLTlegjZDqtx?=
 =?us-ascii?Q?H75jGNnI0ckHejOnl/joYgEo7rIA3ib6+w5HbZXCsQBIKS21TVqxGhF79zUk?=
 =?us-ascii?Q?gDJOKxmmXJupRRHPBh0rqjaYB7Jz7jcGcntvi6auiDv/r+EgxnhU0xQhFdEJ?=
 =?us-ascii?Q?8KwDPEwFF/amIa1qzJkq1vQviNFsp88Vbuoo0LFEN/aDEmLc+97k4wgIAzHi?=
 =?us-ascii?Q?6wMWkbsVeXswfqyfL85NDbSs3Cytq3KmA/QZ/hq6DtgmeWIV0ITz83YgKyu9?=
 =?us-ascii?Q?AkL5vVyfZVjZSrsRGNaTaNFukiNRyIdR7yUxrods9clWsZ4U4V4fykr/c7n5?=
 =?us-ascii?Q?pf0bKv/Lsa6cN5xNsedaAqTayYLtSIhT4H/y4wLmuIgoIe8u1OPAugjFgEOR?=
 =?us-ascii?Q?URW793OI5TdzOf0yXrdJbiV9zvXOjV+Nyze+/+F+rSB8jqIPff6tyUcWe8U/?=
 =?us-ascii?Q?5FB4WPkJ80H9pZV0DYD33TTDaaFf1VyPn0FNSVtPrJMAK3gZyJymEY6HDaeb?=
 =?us-ascii?Q?AFjh0RNZYIGb4LT/AwThXw5tUj3ljorbRKFiPFlj5PUPMNd6F/TZIgtJGrfo?=
 =?us-ascii?Q?9WX34W7OCl0USKyRptI/IpMRSu4/oXPwUpHo//amD2xbsm2GO/97M5k45DE2?=
 =?us-ascii?Q?uQPzpUJKg5MYm6aXD3inObi2WeeW2izBzYOgSd4Fe23+BEmO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc3fd66-3e48-47c8-68c8-08deba418382
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 09:39:27.4607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4g++7nf7p6KuHSttmQHopl1wEx0fwqAAiqnTVqn+MhVp+8+oisKcgENgzZ9X/f4p5ZgaQREWR8WMUGENcRsBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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

Patch 15/42 to 25/42
Patch 27/42 to 33/42
Patch 36/42 to 42/42
feel free to add test-by: Jesse Zhang <jesse.zhang@amd.com> and Reviewed-by=
: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, May 22, 2026 8:20 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Am=
ber
> <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 15/42] drm/amdgpu/mes11: move pipe reset to mes use_mmio
> patch
>
> This makes the code flows cleaner and it's only supported on the use_mmio=
 path.
>
> v2: fix typo
> v3: fix typo
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 244 +-----------------------
> drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 253 ++++++++++++++++++++++++-
>  2 files changed, 253 insertions(+), 244 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 1995de5e69991..f268d46e07598 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6775,69 +6775,6 @@ static void gfx_v11_0_emit_mem_sync(struct
> amdgpu_ring *ring)
>       amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */  }
>
> -static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev) -{
> -     /* Disable the pipe reset until the CPFW fully support it.*/
> -     dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n=
");
> -     return false;
> -}
> -
> -
> -static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring) -{
> -     struct amdgpu_device *adev =3D ring->adev;
> -     uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> -     int r;
> -
> -     if (!gfx_v11_pipe_reset_support(adev))
> -             return -EOPNOTSUPP;
> -
> -     gfx_v11_0_set_safe_mode(adev, 0);
> -     mutex_lock(&adev->srbm_mutex);
> -     soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> -
> -     switch (ring->pipe) {
> -     case 0:
> -             reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> -                                        PFP_PIPE0_RESET, 1);
> -             reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> -                                        ME_PIPE0_RESET, 1);
> -             clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> -                                        PFP_PIPE0_RESET, 0);
> -             clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> -                                        ME_PIPE0_RESET, 0);
> -             break;
> -     case 1:
> -             reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> -                                        PFP_PIPE1_RESET, 1);
> -             reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> -                                        ME_PIPE1_RESET, 1);
> -             clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> -                                        PFP_PIPE1_RESET, 0);
> -             clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> -                                        ME_PIPE1_RESET, 0);
> -             break;
> -     default:
> -             break;
> -     }
> -
> -     WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
> -     WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
> -
> -     r =3D (RREG32(SOC15_REG_OFFSET(GC, 0,
> regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
> -                                             RS64_FW_UC_START_ADDR_LO;
> -     soc21_grbm_select(adev, 0, 0, 0, 0);
> -     mutex_unlock(&adev->srbm_mutex);
> -     gfx_v11_0_unset_safe_mode(adev, 0);
> -
> -     dev_info(adev->dev, "The ring %s pipe reset to the ME firmware star=
t
> PC: %s\n", ring->name,
> -                     r =3D=3D 0 ? "successfully" : "failed");
> -     /* FIXME: Sometimes driver can't cache the ME firmware start PC cor=
rectly,
> -      * so the pipe reset status relies on the later gfx ring test resul=
t.
> -      */
> -     return 0;
> -}
> -
>  static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>                              unsigned int vmid,
>                              struct amdgpu_fence *timedout_fence) @@ -684=
9,13
> +6786,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>
>       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmi=
o, 0);
> -     if (r) {
> -
> -             dev_warn(adev->dev, "reset via MES failed and try pipe rese=
t %d\n",
> r);
> -             r =3D gfx_v11_reset_gfx_pipe(ring);
> -             if (r)
> -                     return r;
> -     }
> +     if (r)
> +             return r;
>
>       if (use_mmio) {
>               r =3D gfx_v11_0_kgq_init_queue(ring, true); @@ -6874,170 +6=
806,6
> @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>       return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }
>
> -/*
> - * With MEC pipe reset asserted, clear CP_HQD_ACTIVE /
> CP_HQD_DEQUEUE_REQUEST for
> - * every queue on (me, pipe). HQDs must be torn down while pipe reset st=
ays
> - * asserted; only then clear the pipe reset bit.
> - * Caller must hold adev->srbm_mutex.
> - */
> -static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev,=
 u32
> me,
> -                                          u32 pipe)
> -{
> -     unsigned int q;
> -     int j;
> -
> -     for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
> -             soc21_grbm_select(adev, me, pipe, q, 0);
> -             /* Start from a clean HQD dequeue state before forcing HQD
> inactive. */
> -             WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
> -             if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
> -                     WREG32_SOC15(GC, 0,
> regCP_HQD_DEQUEUE_REQUEST, 1);
> -                     for (j =3D 0; j < adev->usec_timeout; j++) {
> -                             if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE)
> & 1))
> -                                     break;
> -                             udelay(1);
> -                     }
> -             }
> -
> -             WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
> -     }
> -}
> -
> -static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
> -                                        u32 me, u32 pipe, u32 queue)
> -{
> -     uint32_t reset_val, clean_val;
> -     int r;
> -
> -     if (!gfx_v11_pipe_reset_support(adev))
> -             return -EOPNOTSUPP;
> -
> -     gfx_v11_0_set_safe_mode(adev, 0);
> -     mutex_lock(&adev->srbm_mutex);
> -     soc21_grbm_select(adev, me, pipe, queue, 0);
> -
> -     if (adev->gfx.rs64_enable) {
> -             reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> -             clean_val =3D reset_val;
> -
> -             switch (pipe) {
> -             case 0:
> -                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> -                                               MEC_PIPE0_RESET, 1);
> -                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> -                                               MEC_PIPE0_RESET, 0);
> -                     break;
> -             case 1:
> -                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> -                                               MEC_PIPE1_RESET, 1);
> -                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> -                                               MEC_PIPE1_RESET, 0);
> -                     break;
> -             case 2:
> -                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> -                                               MEC_PIPE2_RESET, 1);
> -                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> -                                               MEC_PIPE2_RESET, 0);
> -                     break;
> -             case 3:
> -                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> -                                               MEC_PIPE3_RESET, 1);
> -                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> -                                               MEC_PIPE3_RESET, 0);
> -                     break;
> -             default:
> -                     break;
> -             }
> -             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
> -             gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> -             soc21_grbm_select(adev, me, pipe, queue, 0);
> -             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
> -             r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR)
> << 2) -
> -                                     RS64_FW_UC_START_ADDR_LO;
> -     } else {
> -             reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
> -             clean_val =3D reset_val;
> -
> -             if (me =3D=3D 1) {
> -                     switch (pipe) {
> -                     case 0:
> -                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME1_PIPE0_RES=
ET,
> 1);
> -                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME1_PIPE0_RES=
ET,
> 0);
> -                             break;
> -                     case 1:
> -                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME1_PIPE1_RES=
ET,
> 1);
> -                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME1_PIPE1_RES=
ET,
> 0);
> -                             break;
> -                     case 2:
> -                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME1_PIPE2_RES=
ET,
> 1);
> -                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME1_PIPE2_RES=
ET,
> 0);
> -                             break;
> -                     case 3:
> -                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME1_PIPE3_RES=
ET,
> 1);
> -                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME1_PIPE3_RES=
ET,
> 0);
> -                             break;
> -                     default:
> -                             break;
> -                     }
> -                     /* mec1 fw pc: CP_MEC1_INSTR_PNTR */
> -             } else {
> -                     switch (pipe) {
> -                     case 0:
> -                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME2_PIPE0_RES=
ET,
> 1);
> -                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME2_PIPE0_RES=
ET,
> 0);
> -                             break;
> -                     case 1:
> -                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME2_PIPE1_RES=
ET,
> 1);
> -                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME2_PIPE1_RES=
ET,
> 0);
> -                             break;
> -                     case 2:
> -                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME2_PIPE2_RES=
ET,
> 1);
> -                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME2_PIPE2_RES=
ET,
> 0);
> -                             break;
> -                     case 3:
> -                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME2_PIPE3_RES=
ET,
> 1);
> -                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> -                                                       MEC_ME2_PIPE3_RES=
ET,
> 0);
> -                             break;
> -                     default:
> -                             break;
> -                     }
> -                     /* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
> -             }
> -             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
> -             gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> -             soc21_grbm_select(adev, me, pipe, queue, 0);
> -             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
> -             r =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> regCP_MEC1_INSTR_PNTR));
> -     }
> -
> -     soc21_grbm_select(adev, 0, 0, 0, 0);
> -     mutex_unlock(&adev->srbm_mutex);
> -     gfx_v11_0_unset_safe_mode(adev, 0);
> -
> -     dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW
> start PC: %s\n",
> -             me, pipe, queue, r =3D=3D 0 ? "successfully" : "failed");
> -     /*FIXME:Sometimes driver can't cache the MEC firmware start PC corr=
ectly,
> so the pipe
> -      * reset status relies on the compute ring test result.
> -      */
> -     return 0;
> -}
> -
>  static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>                              unsigned int vmid,
>                              struct amdgpu_fence *timedout_fence) @@ -704=
9,12
> +6817,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>
>       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmi=
o, 0);
> -     if (r) {
> -             dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe res=
et\n", r);
> -             r =3D gfx_v11_0_reset_compute_pipe(adev, ring->me, ring->pi=
pe, ring-
> >queue);
> -             if (r)
> -                     return r;
> -     }
> +     if (r)
> +             return r;
>
>       if (use_mmio) {
>               r =3D gfx_v11_0_kcq_init_queue(ring, true); diff --git
> a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index a926a330700e9..385dbb1680b3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -390,6 +390,245 @@ static int mes_v11_0_remove_hw_queue(struct
> amdgpu_mes *mes,
>                       offsetof(union MESAPI__REMOVE_QUEUE, api_status)); =
 }
>
> +static bool mes_v11_0_pipe_reset_support(struct amdgpu_device *adev) {
> +     /* Disable the pipe reset until the CPFW fully support it.*/
> +     dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n=
");
> +     return false;
> +}
> +static int mes_v11_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
> +                                      u32 me, u32 pipe, u32 queue)
> +{
> +     uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +     int r;
> +
> +     if (!mes_v11_0_pipe_reset_support(adev))
> +             return -EOPNOTSUPP;
> +
> +     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +     mutex_lock(&adev->srbm_mutex);
> +     soc21_grbm_select(adev, me, pipe, queue, 0);
> +
> +     switch (pipe) {
> +     case 0:
> +             reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                        PFP_PIPE0_RESET, 1);
> +             reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                        ME_PIPE0_RESET, 1);
> +             clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                        PFP_PIPE0_RESET, 0);
> +             clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                        ME_PIPE0_RESET, 0);
> +             break;
> +     case 1:
> +             reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                        PFP_PIPE1_RESET, 1);
> +             reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                        ME_PIPE1_RESET, 1);
> +             clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                        PFP_PIPE1_RESET, 0);
> +             clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                        ME_PIPE1_RESET, 0);
> +             break;
> +     default:
> +             break;
> +     }
> +
> +     WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
> +     WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
> +
> +     r =3D (RREG32(SOC15_REG_OFFSET(GC, 0,
> regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
> +                                             RS64_FW_UC_START_ADDR_LO;
> +     soc21_grbm_select(adev, 0, 0, 0, 0);
> +     mutex_unlock(&adev->srbm_mutex);
> +     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +
> +     dev_info(adev->dev, "The gfx pipe reset to the ME firmware start PC=
: %s\n",
> +                     r =3D=3D 0 ? "successfully" : "failed");
> +     /* FIXME: Sometimes driver can't cache the ME firmware start PC cor=
rectly,
> +      * so the pipe reset status relies on the later gfx ring test resul=
t.
> +      */
> +     return 0;
> +}
> +
> +/*
> + * With MEC pipe reset asserted, clear CP_HQD_ACTIVE /
> +CP_HQD_DEQUEUE_REQUEST for
> + * every queue on (me, pipe). HQDs must be torn down while pipe reset
> +stays
> + * asserted; only then clear the pipe reset bit.
> + * Caller must hold adev->srbm_mutex.
> + */
> +static void mes_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev,
> u32 me,
> +                                          u32 pipe)
> +{
> +     unsigned int q;
> +     int j;
> +
> +     for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
> +             soc21_grbm_select(adev, me, pipe, q, 0);
> +             /* Start from a clean HQD dequeue state before forcing HQD
> inactive. */
> +             WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
> +             if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
> +                     WREG32_SOC15(GC, 0,
> regCP_HQD_DEQUEUE_REQUEST, 1);
> +                     for (j =3D 0; j < adev->usec_timeout; j++) {
> +                             if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE)
> & 1))
> +                                     break;
> +                             udelay(1);
> +                     }
> +             }
> +
> +             WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
> +     }
> +}
> +
> +static int mes_v11_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
> +                                          u32 me, u32 pipe, u32 queue)
> +{
> +     uint32_t reset_val, clean_val;
> +     int r;
> +
> +     if (!mes_v11_0_pipe_reset_support(adev))
> +             return -EOPNOTSUPP;
> +
> +     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +     mutex_lock(&adev->srbm_mutex);
> +     soc21_grbm_select(adev, me, pipe, queue, 0);
> +
> +     if (adev->gfx.rs64_enable) {
> +             reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +             clean_val =3D reset_val;
> +
> +             switch (pipe) {
> +             case 0:
> +                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE0_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE0_RESET, 0);
> +                     break;
> +             case 1:
> +                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE1_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE1_RESET, 0);
> +                     break;
> +             case 2:
> +                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE2_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE2_RESET, 0);
> +                     break;
> +             case 3:
> +                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE3_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE3_RESET, 0);
> +                     break;
> +             default:
> +                     break;
> +             }
> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
> +             mes_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +             soc21_grbm_select(adev, me, pipe, queue, 0);
> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
> +             r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR)
> << 2) -
> +                                     RS64_FW_UC_START_ADDR_LO;
> +     } else {
> +             reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
> +             clean_val =3D reset_val;
> +
> +             if (me =3D=3D 1) {
> +                     switch (pipe) {
> +                     case 0:
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE0_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE0_RES=
ET,
> 0);
> +                             break;
> +                     case 1:
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE1_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE1_RES=
ET,
> 0);
> +                             break;
> +                     case 2:
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE2_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE2_RES=
ET,
> 0);
> +                             break;
> +                     case 3:
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE3_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE3_RES=
ET,
> 0);
> +                             break;
> +                     default:
> +                             break;
> +                     }
> +                     /* mec1 fw pc: CP_MEC1_INSTR_PNTR */
> +             } else {
> +                     switch (pipe) {
> +                     case 0:
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE0_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE0_RES=
ET,
> 0);
> +                             break;
> +                     case 1:
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE1_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE1_RES=
ET,
> 0);
> +                             break;
> +                     case 2:
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE2_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE2_RES=
ET,
> 0);
> +                             break;
> +                     case 3:
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE3_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE3_RES=
ET,
> 0);
> +                             break;
> +                     default:
> +                             break;
> +                     }
> +                     /* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
> +             }
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
> +             mes_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +             soc21_grbm_select(adev, me, pipe, queue, 0);
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
> +             r =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> regCP_MEC1_INSTR_PNTR));
> +     }
> +
> +     soc21_grbm_select(adev, 0, 0, 0, 0);
> +     mutex_unlock(&adev->srbm_mutex);
> +     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +
> +     dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW
> start PC: %s\n",
> +             me, pipe, queue, r =3D=3D 0 ? "successfully" : "failed");
> +     /*FIXME:Sometimes driver can't cache the MEC firmware start PC corr=
ectly,
> so the pipe
> +      * reset status relies on the compute ring test result.
> +      */
> +     return 0;
> +}
> +
> +static int mes_v11_0_reset_pipe_mmio(struct amdgpu_mes *mes, uint32_t
> queue_type,
> +                                  uint32_t me_id, uint32_t pipe_id,
> +                                  uint32_t queue_id, uint32_t vmid) {
> +     struct amdgpu_device *adev =3D mes->adev;
> +
> +     if (queue_type =3D=3D AMDGPU_RING_TYPE_GFX)
> +             return mes_v11_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id,
> queue_id);
> +     else if (queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE)
> +             return mes_v11_0_reset_compute_pipe_mmio(adev, me_id, pipe_=
id,
> queue_id);
> +     else
> +             return -EOPNOTSUPP;
> +}
> +
>  static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t
> queue_type,
>                                     uint32_t me_id, uint32_t pipe_id,
>                                     uint32_t queue_id, uint32_t vmid) @@ =
-762,10
> +1001,16 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,  =
{
>       union MESAPI__RESET mes_reset_queue_pkt;
>
> -     if (input->use_mmio)
> -             return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
> -                                               input->me_id, input->pipe=
_id,
> -                                               input->queue_id, input->v=
mid);
> +     if (input->use_mmio) {
> +             int r =3D mes_v11_0_reset_queue_mmio(mes, input->queue_type=
,
> +                                                input->me_id, input->pip=
e_id,
> +                                                input->queue_id, input->=
vmid);
> +             if (r)
> +                     return mes_v11_0_reset_pipe_mmio(mes, input-
> >queue_type,
> +                                                      input->me_id, inpu=
t->pipe_id,
> +                                                      input->queue_id, i=
nput->vmid);
> +             return 0;
> +     }
>
>       memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
>
> --
> 2.54.0

