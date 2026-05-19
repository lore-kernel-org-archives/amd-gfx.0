Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBD7CD4F54
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 07:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CAC10E0C8;
	Tue, 19 May 2026 07:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hKwRy8Yd";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B3910E0C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 07:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmwUNpHnUF0YW2Ur6K7nPUf3nQ1yd02PBLaQPqoK/9NbaBgcaQ77e4LVkiLqg2QBiT1BWjfm42vPuqm9HR7NKWDB/+lBLM4aCYeZDEDrTkgewvI6Kl5cxynsZxDuOjdDLJ9goM9stQIw5ISic6V+0zj9C64R8AsIERU4sAFvGKggWLdRyyrKYIh0XysfEGQGgeKmY5HHMBlFdkbf5yz0rsl4lRPSAw70LIeo8L+eFsZdxAM8kVSs+TeyTEgUFZ89eU0ivKt3SiyRcRhuQvOz56V0Dg83yW9xtWJfd7tHiDS5Swht2weok8rr7kyY8LS6OG2gGye+qwxNmEmV547Sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE/uTIrgy6T6b8ssWBEIx0JYdt0pUJ68nRcebPPZjYw=;
 b=fM3bLHsioD+Bj2YVby36F3P+BRim7yOvopeLf4WWulW+IhpKFO6894rktA610BZSswKEB9TqSGdgY1Pqff4MJdy8Q7WMnof8yNA85oZX2++7OGZCW2rgYycLOh8UJA2cxYPXGlpnfO1fGvQHU+S5wf+ekYyNQvIHJRUU7DwR+48P5bdNd4aezXdeXmybT9Idd8r3LQY7JxpZoU80K8psKl73B6wts8mHem9jbj1MHmpMtmeh+ALxtd4m+N0Co9RjqUJKPDh8B8SEz+bkBPWNgEUrkO3Lt+WP5CsaIrhHnVqv/dbrKYdljjgSYDJQTwG0o18Jsst3TjjKCrsLo52q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE/uTIrgy6T6b8ssWBEIx0JYdt0pUJ68nRcebPPZjYw=;
 b=hKwRy8YdJc7mF30qIydkwNCC753vNirQxJIPzrvqBcjTvjPISM+NYfcegu9h7DrFwzFMV3fXl8K3g3NDNpLL8kd/W8SbPEJ+E2pAdZAqMfZnaIfDS7lxnwjkIMw2gcAHJAcv6ebXIyERAWfhiZ2u9yvabEqvKFJ55sMik1VMdWk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 07:00:02 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 07:00:02 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: harden FRU PIA parsing with bounded
 helpers
Thread-Topic: [PATCH 5/5] drm/amdgpu: harden FRU PIA parsing with bounded
 helpers
Thread-Index: AQHc5qqQkPAXPy1jMEK2+70r4X7JW7YU7J8Q
Date: Tue, 19 May 2026 07:00:02 +0000
Message-ID: <PH7PR12MB8796868ABDCAD3909A603DE4B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260518094021.280968-1-Stanley.Yang@amd.com>
 <20260518094021.280968-5-Stanley.Yang@amd.com>
In-Reply-To: <20260518094021.280968-5-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T06:59:03.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH0PR12MB7907:EE_
x-ms-office365-filtering-correlation-id: 9c579537-fa22-4bc7-3856-08deb5743fd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|4143699003|22082099003|11063799003|18002099003;
x-microsoft-antispam-message-info: mvT77Di2xo+Br73zzzSWVq0RcGSngy4/U4ps6iqvBPIus6AsbmesLK80DEKVZbbhfZL0ZEngtRrTjbTow8PDnHnM0bESjYjBplua+0SBp20vBPFjDJY12a2+lZs7eR68iqE+yhF4lXnndDlcxR4Ux9CLIkBAw8ZeRw2hUTRMUNZ7O3X29pbod1Sfgq2zaDakZXEBpTh9FWzNveXxtxhtOPk4noGSCBCPikUhve+wfPv7YVL8ll/Fi/jgNaS7Fp1ckjgYUBDDVSk+yAyWQL/yVdk+5eaP8tCZhsYKyr80JTUU8d6v2t6l2VtNCJ1iKI2MrQw6laKEoIyyQwfAQTfVPWnBxboM+ck9PXMhJkcjq1wRrHnTpMcsDRCf0k3+YGtOTSpLgMnpRXOL9+TtxDhsyifiBWyJCkd6X9KbEU9IFAqEGaQeq9iLr+scd4ikuBnpQjz9Ztvr8gz/CCJBg4VsNGDTvk6igPpnb7r3UIYlTeHznwmmtJFCb/6mREoBrLQhIXHPEIIs9GHrYhHTjp8MJTKo5Nbe3HtrKp04vJKpiCb0xOVG+m/dMieJiqtarwXaqHoOYkWvbeG4d6JNMya4dui2SJvZh1kWw7ELyKLm3j1u4nRhcefbqCGVqKdvca8TMSsx3QesTLI3vznDSnQ0a46kHFnbmbdsnpnmchG9Sctq1azC6sj+reoYB7LxmYAUFHfcnXfetMmWAMRrFCfREZ01IXwF9o11N6WOlR43sXprBrsJiMGODYYauas5rMEH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(4143699003)(22082099003)(11063799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZVXsJGuuY2aXneltpIxjJerB0NHOiyDf56LzaYng3UmpSR0VJRzff1TRIpld?=
 =?us-ascii?Q?Ccg0/0SVyeD/+VdqWpcq1OsC8v5zgaAdUIx8RsNwWCqn1JZ0L0MuU/0ihh0O?=
 =?us-ascii?Q?gHLGPhPivMpwn2KRVpQusg8sRpmFoWbArn5tXq7SGYE/hXRnkbwS5Mw8tqRZ?=
 =?us-ascii?Q?9/kDN4VrCrN0zrjmdmWDV9IvScJ4jWrKqCZHKLWEJHH3Gq5SfZxY58LTQWP5?=
 =?us-ascii?Q?0LmqCOQr6FS6R42MQdPpxYm5D/cjK1oJPfcgODfYf9akqURqLSN0Pm2Fq4Sc?=
 =?us-ascii?Q?JFUMUAw4cAOxPLxUCmpCn/tb+5npr2sEGVTgknBtjRcvRFx4pkHZEKRaGfD4?=
 =?us-ascii?Q?IiaCIPRJCt52Zfg6SxJE8LrMQ81UrQMz2UAMZazN+GhUQU5vs9Y7vqwI8WQ1?=
 =?us-ascii?Q?reGn6JpH2Bj6lGAEOfF8aGoFh4FvHoLhDKcb+fO4twO0go7vigE/JmuiVVsx?=
 =?us-ascii?Q?9RUF2WUd4K8wFm0El6x07G6NIx8u4aV/mEFA6+5Tn8VtfLKTCBsy/QjvIgcT?=
 =?us-ascii?Q?58dqhLdVFpqNIZYzNwrFUIacm8eQKx8WWc3LgUOHCXjpRW1kSkvvL6w5pMNc?=
 =?us-ascii?Q?PmQi1eRR4FJPoz+UVTAsXN5Hx3PxIG29C/UHrXzBk1wxZ23oc07brQJYh7pA?=
 =?us-ascii?Q?XXvmqzhE9yb8Jbv5nczyTNKc/U1RC5JRaGcwZ0pnTmp577Fi1J6ksCyi9BZP?=
 =?us-ascii?Q?ScGabFfzPQOwtqUjH7I+CjhWaE/HQT4w3Jh+ErSE1YXq6COnyrejDLgVrXau?=
 =?us-ascii?Q?D7PE5CJ+HuIUfZTlv+Ir6lWJGNF9BSL0rKumMp8318bDrBNDYxnqP6BZpl3y?=
 =?us-ascii?Q?9NhFBFhRBsjOowuS8Wn1W8LOjk4xpxmUF1tfTi0xZcNJbJd65T9gV+rJWy+H?=
 =?us-ascii?Q?NdbxhN5yAuwkyUfySJ4G5Qv89wGUlDhxYKzZVqOjoHK7VC6NaSI4Uz5Sgj8t?=
 =?us-ascii?Q?8X/xphTCoumjqR/d46sI2kgsJwIgyf8sMC/QQLKNS2qc7KFjpX1DIwf7Bf36?=
 =?us-ascii?Q?QMJ2uSK8ezknqf4zSt2VvHzdbiMF2zlIqrcxyf5AXkbu77PKhfvrLeEUqLXV?=
 =?us-ascii?Q?5VFOqhbZatr/SXSieNayYFremVnkbi8btbn5hOqW052cSRRx+RhC2cB1iXe3?=
 =?us-ascii?Q?bUKKh7SoYzcDKK9A0YFon2ocqk5kDEjBg4/jgexKEqvK6k+Edipwfp0fC7m7?=
 =?us-ascii?Q?B9T8KssORAPY5AUMFE//A7A9ndPSVJBPr8brm6zwFcTosqyPbEwoSFtoT3zA?=
 =?us-ascii?Q?Y3dmjPaczIe6QUCMYH4eMrss5cm5FgeCv3SLxdeNAguKDrD6jHd0VypHRP7j?=
 =?us-ascii?Q?JR7ew3EHXA1lJtDT4v/P1MjhZXLcvU3ETYYNO0U3J13iRd9r/9MD67a85xrC?=
 =?us-ascii?Q?GeqfUdqQUh8DTvYmAb8gOcpM5wxH7AQd/JCG73RmMpPhJFMNKfqgmFjSjTzo?=
 =?us-ascii?Q?MvG+QrtoEfOmZoDe04cqxv/NRs7KArxM46S5k3Ht+JiITYYddYOcqjSGFz5y?=
 =?us-ascii?Q?ivXvhltubaWcXvN5lSAacusrEjvVs92PKZD07RnqJY/DfCKBQqFd1/Sy5KHG?=
 =?us-ascii?Q?o9jyzcTc/MJeBzJ7vhTYsJaAGKQq5O2Hjx/tcmnDqrw6zJvvrZstJ0koMZBc?=
 =?us-ascii?Q?a9rvUBPVGCse4RlRbXVfPSvtBUzD3abVrC3jJ5F1U1NorEaY00CUCNL9ECt2?=
 =?us-ascii?Q?/kaU+BxWCTJs8mczcMQjyIU6iq4TtTw3YKMPf6Bz+WaF1Pi4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c579537-fa22-4bc7-3856-08deb5743fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 07:00:02.4220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeoa0pDT9SavsTgWbfAKoZrSbVpAKm+bAqf+GxxUi6AjsRHisWE0n5qM4ZxGiaBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Monday, May 18, 2026 5:40 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH 5/5] drm/amdgpu: harden FRU PIA parsing with bounded
> helpers
>
> Replace the open-coded TLV walk with fru_pia_advance() and
> fru_pia_copy_field() helpers that bound every read by the actual EEPROM
> data length, preventing out-of-bounds reads on truncated or malformed FRU
> data.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 95 ++++++++++++-------
>  1 file changed, 63 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index c5178e2b794d..86b2d5a79993 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -115,6 +115,43 @@ static bool is_fru_eeprom_supported(struct
> amdgpu_device *adev, u32 *fru_addr)
>       }
>  }
>
> +/*
> + * IPMI FRU Product Info Area fields are TLV: one type/length byte
> + * (low 6 bits =3D data length) followed by that many data bytes. These
> + * helpers walk the cursor and copy a single field while bounding all
> + * accesses to the actual buffer length read from the EEPROM.
> + */
> +#define FRU_FIELD_LEN(p, a)  ((p)[a] & 0x3F)
> +
> +/* Advance cursor past the current TLV. Returns false if no more data.
> +*/ static bool fru_pia_advance(u32 *addr, const unsigned char *pia, int
> +len) {
> +     if (*addr >=3D (u32)len)
> +             return false;
> +     *addr +=3D 1 + FRU_FIELD_LEN(pia, *addr);
> +     return true;
> +}
> +
> +/*
> + * Copy the current TLV's data into dst (NUL-terminated). Returns false
> +if
> + * the TLV header or data would read past the end of pia.
> + */
> +static bool fru_pia_copy_field(char *dst, size_t dst_size,
> +                            const unsigned char *pia, u32 addr, int len)=
 {
> +     size_t fl;
> +
> +     if (addr + 1 >=3D (u32)len)
> +             return false;
> +
> +     fl =3D min3((size_t)FRU_FIELD_LEN(pia, addr),
> +                       dst_size -1,
> +                       (size_t)(len - addr - 1));
> +     memcpy(dst, pia + addr + 1, fl);
> +     dst[fl] =3D '\0';
> +     return true;
> +}
> +
>  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)  {
>       struct amdgpu_fru_info *fru_info;
> @@ -223,52 +260,46 @@ int amdgpu_fru_get_product_info(struct
> amdgpu_device *adev)
>        * Read Manufacturer Name field whose length is [3].
>        */
>       addr =3D 3;
> -     if (addr + 1 >=3D len)
> +     if (!fru_pia_copy_field(fru_info->manufacturer_name,
> +                             sizeof(fru_info->manufacturer_name),
> +                             pia, addr, len))
>               goto Out;
> -     memcpy(fru_info->manufacturer_name, pia + addr + 1,
> -            min_t(size_t, sizeof(fru_info->manufacturer_name),
> -                  pia[addr] & 0x3F));
> -     fru_info->manufacturer_name[sizeof(fru_info->manufacturer_name)
> - 1] =3D
> -             '\0';
>
>       /* Read Product Name field. */
> -     addr +=3D 1 + (pia[addr] & 0x3F);
> -     if (addr + 1 >=3D len)
> +     if (!fru_pia_advance(&addr, pia, len) ||
> +         !fru_pia_copy_field(fru_info->product_name,
> +                             sizeof(fru_info->product_name),
> +                             pia, addr, len))
>               goto Out;
> -     memcpy(fru_info->product_name, pia + addr + 1,
> -            min_t(size_t, sizeof(fru_info->product_name), pia[addr] & 0x=
3F));
> -     fru_info->product_name[sizeof(fru_info->product_name) - 1] =3D '\0'=
;
>
>       /* Go to the Product Part/Model Number field. */
> -     addr +=3D 1 + (pia[addr] & 0x3F);
> -     if (addr + 1 >=3D len)
> +     if (!fru_pia_advance(&addr, pia, len) ||
> +         !fru_pia_copy_field(fru_info->product_number,
> +                             sizeof(fru_info->product_number),
> +                             pia, addr, len))
>               goto Out;
> -     memcpy(fru_info->product_number, pia + addr + 1,
> -            min_t(size_t, sizeof(fru_info->product_number),
> -                  pia[addr] & 0x3F));
> -     fru_info->product_number[sizeof(fru_info->product_number) - 1] =3D
> '\0';
>
> -     /* Go to the Product Version field. */
> -     addr +=3D 1 + (pia[addr] & 0x3F);
> +     /* Skip the Product Version field. */
> +     if (!fru_pia_advance(&addr, pia, len))
> +             goto Out;
>
> -     /* Go to the Product Serial Number field. */
> -     addr +=3D 1 + (pia[addr] & 0x3F);
> -     if (addr + 1 >=3D len)
> +     /* Read the Product Serial Number field. */
> +     if (!fru_pia_advance(&addr, pia, len) ||
> +         !fru_pia_copy_field(fru_info->serial,
> +                             sizeof(fru_info->serial),
> +                             pia, addr, len))
>               goto Out;
> -     memcpy(fru_info->serial, pia + addr + 1,
> -            min_t(size_t, sizeof(fru_info->serial), pia[addr] & 0x3F));
> -     fru_info->serial[sizeof(fru_info->serial) - 1] =3D '\0';
>
> -     /* Asset Tag field */
> -     addr +=3D 1 + (pia[addr] & 0x3F);
> +     /* Skip the Asset Tag field. */
> +     if (!fru_pia_advance(&addr, pia, len))
> +             goto Out;
>
>       /* FRU File Id field. This could be 'null'. */
> -     addr +=3D 1 + (pia[addr] & 0x3F);
> -     if ((addr + 1 >=3D len) || !(pia[addr] & 0x3F))
> +     if (!fru_pia_advance(&addr, pia, len) ||
> +         !fru_pia_copy_field(fru_info->fru_id,
> +                             sizeof(fru_info->fru_id),
> +                             pia, addr, len))
>               goto Out;
> -     memcpy(fru_info->fru_id, pia + addr + 1,
> -            min_t(size_t, sizeof(fru_info->fru_id), pia[addr] & 0x3F));
> -     fru_info->fru_id[sizeof(fru_info->fru_id) - 1] =3D '\0';
>
>  Out:
>       kfree(pia);
> --
> 2.43.0

