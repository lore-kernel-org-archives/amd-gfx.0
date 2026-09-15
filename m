Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200B2C88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 03:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCC910F8DE;
	Tue, 15 Sep 2026 03:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dbERmnzI";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ED110F8DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 03:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8rjSpvQ9U0aUUGIUt4Whh8yUQqD3GjGLjiMdai98J+HVR/rf8wxOPZ4ZKWnUlQWryi0TF8aME/0F1I8byfp2nBr+d0tDsL/Zsr+VYaWxSJOtbE+ybx/847LB44iaIdv1w+T73xvfiM1L96qzy681SuPOGqEh6z02pWJN0Ax5PGk9tydJNk3h6vMjdooz019i64iWQ/kCc+QTuKFfRpQl88Y5xSW4hh1Q2MR5I++bppWEjlGqfFIq83xhTL5RURVL/rEZtHsjOx/rqvJjai0TXCQbNft8PLVxkqwi5dH51uxc/72vLDSRxOE2fW4BlYmuDAiVD4FSy21mJ9c8kh/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlillwS6YAc+vNDVjIWlvsTrgcZVvkZdCZfiG/yd9nE=;
 b=hNuYekN5Q11RqvNBPbfjfuYxbf5WFsB3DLe+f4+iAc5Wk1JW3U7ncViIW5zepC5gvjElbVzhSM2lvbARglK2FAHBGFffXhe25N9rqLy8QKNRq/YsEbYDjIygXsCXgEto83cqBfBhNYo8Y/n3zZLd16ZOHC5Ffy5kf32XHlYjeEmDLtsYEWTHpnWL8QvyGLzCZKs6mkn7iA0uhO3r3UuEbR7QbTJoKxYjlGNhZ51MvAdsTVRwllEW+ypGq5wi0tlpxp6+uUJnl+dGXF8gI2ZT9iDDFV49bf2R6U6KreK4YRVhW75VDU7pAk+5TLYsiUuY8Vif67gTxl392pLuFQKJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlillwS6YAc+vNDVjIWlvsTrgcZVvkZdCZfiG/yd9nE=;
 b=dbERmnzIO7bXvrwvuNXLs/ag8ZZ7s21QApDmZIRaeJiDvzUkFS8o3iNlENeLUnZTJ59HoJ7Hstxi/7CTS6ht5+5CgIJCOpAn0hgBhdOJthl3RqYwwMm9wY0SkFI8Vsf3Wv/P9791GU6ms9aKht6VsH9YTiTtEq/i/R9/k5nHu+c=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:38:07 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 03:38:07 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 6/6] drm/amd/ras: remove obsolete ras mp1 v13 manager code
Thread-Topic: [PATCH 6/6] drm/amd/ras: remove obsolete ras mp1 v13 manager code
Thread-Index: AQHdQbk/SMKdH5pjEUynB6BpM73GrbbPA70g
Date: Tue, 15 Sep 2026 03:38:07 +0000
Message-ID: <CYYPR12MB872908B09C9610D900ABF8F7B0BA2@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
 <20260911064410.1693567-6-YiPeng.Chai@amd.com>
In-Reply-To: <20260911064410.1693567-6-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T03:37:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|PH7PR12MB7937:EE_
x-ms-office365-filtering-correlation-id: aa471dd4-ef57-47b6-0645-08df12dac215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|3023799007|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: UHs0sgMuGdBeSXC/G+2gxlfbt+b2awDrtZZR1tkto15uA+wXuF3oN/0mI0M8J3B+EHx7brEmrv3szFKW6cbLOI+489Z+cIsPvLL5BspEOQ0VtPTGdIvMFMnJ2wc5QCK30NJ3heIL931YIyN9vFbv8SZb6nn10WiEO2yWlXcd6iWbIIwNP2oh8QVWm1kv/JoEj6YcFP4o0a866ZwCZrwTx3IdRxuped++cmkjRV3DhcaThPxd0XO9wSznmi00UQJHAixNA2UTK1o3ocf5T7gi9tqhjGN5H8awXoZk/OuGTuk7zbL9qJWyxWhaP8H3Ky/kTha0IU4dV59+EmKblYW8+44RSDqDYU99nwb8rQM01h0qZ4IjAOJ80h6N02XAkBwb+z+ktM9PGRPEDEYRcnOPRFrLzJu+3GE7BtdN4NtScpv9/PqNgYudBEpisotVLeaiMASXWbYXVAH2DPgA3+JAtysgWS9TF/w2Qo2I36VeU773dlJfnP6LC52wdBrcn7e6lyd1BjfiN5kFl9rafAtMAlV4Us0ESjyXqTQKg5GwwKwHo8ZmDljOGn3zVJsTKSUI9HlJlcJk0Kb//n2B40XlqF0u1VuCBR6dB85ucQfNM7lBZVOGjG1BSC45ro7rrtdINYka4sTpwN1/i6IXAb5AvP4X1NUUbmLT2ykXA8hMb6C1zhfQHVtCGqT9o7I4bmduK4Mm2RspPoK4Q3PRIpsHl1ILAmeM8JTqxiJ0PS84N0I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NfitOPc284RvlI+hdFvDCiDmtuyjPnoJNOyw6MFItmmgMwiyqbEcASBBeOyH?=
 =?us-ascii?Q?ha6QQlbltFGLKo+XGIQ9YdsdoRehqHsmDCH4lEiIt52czl6VUM7ZWwEnwYtX?=
 =?us-ascii?Q?rfMJEFOm8HcuPGVWM/EgaiYyi/3t0D7SNP9jpDYS0Dkz5+9Bkh5Ww4i98VSQ?=
 =?us-ascii?Q?7fbWxZYAOvchPzc/M+mGNCIyI6MSqBWtg5yn0jPdecvKROJ2EMY5W2JJ3Eh/?=
 =?us-ascii?Q?YDL2nKV6qxi40dm2RgXqQUoibhuGpOrqKX9QvGXLL1DyvvsvrNdc6SYuWPNr?=
 =?us-ascii?Q?Z2jh2dUTdJf9iVrt2VTUdVuxn/R2ZIu/Q4mp7y6r/R4PAG59oE9O3CcC8+SV?=
 =?us-ascii?Q?DgWOJnYJGPVGWk7EFeP7193pVNmUADH5adKzOwCNex8072SsJKnwnW2PTmlB?=
 =?us-ascii?Q?iRFxIcQ/KWEvbWSzzN3lx0+z2SplO+wdNFkxxebDolS5iL1KNE5qs2O7PSKK?=
 =?us-ascii?Q?jQXXmyJJUFJZ4KzIyAVfniu+HzjrcWFgN03TmHlxMo4pS5SqZDiLgXOmTOD3?=
 =?us-ascii?Q?Njv8h6fU2JTionyqXr/ysaRKSzg7yppGP1XfhdJdmJEdApeWBDDPJ5tKbQcN?=
 =?us-ascii?Q?sbx8Ky5EBLcqzE8wlMQAqAD38RbOlQTsqxB05EeAnb+OAZmnNdA5ggjccLu1?=
 =?us-ascii?Q?xqWkQBfYBZq9HEWr8DeuvmeyiayoTTp3o35uHOsijQJuq/qkXDgFtOiQdCuL?=
 =?us-ascii?Q?hQ91ulthD92lD+JxxE1JmmkGrTh9XF0z2lYG29zizNop2NXyghxzki+8ilzW?=
 =?us-ascii?Q?5XuQs9bKRCjdeT5wh3wIz+v+JbfRb61vmu71TYOHfq/0aiOJX4VwKeIpjQP/?=
 =?us-ascii?Q?+Q/6E4AfC1inskYPok9Dfwb0qQvuEJEvCrXG2pgQNdC40Zbi/rxcgKChXUGT?=
 =?us-ascii?Q?0eTw6WEOOVb5Tzy+qr/HIgSOMqbhv7+m2BYANnJzoUvP0JpzdaTEEPYQJ9og?=
 =?us-ascii?Q?8s2g/h1++ro3asa13djSxvDVyUma42E0+s33w1Em+LsYQNajUgIO3u6q2OnE?=
 =?us-ascii?Q?Xh4HJH4PeYycrVYQE/C9psY+UailmeJP0aVELZ3QWY0SxVtqzCV0vVAqAtzG?=
 =?us-ascii?Q?3qMlN6POxANVAvBmDH9wV6GXBjQK7C1pAkaq3+DsywybpE5Yt6xqaXBChDSB?=
 =?us-ascii?Q?JGDgP1XSHNdqAtTCFk5/+AMX75+2SF8fiFwd7EJF48vXOXPz6338shqBZ13H?=
 =?us-ascii?Q?niHoohEz0MI2XYD0FG5654oIR7hkI4TURyMa8TE8GH5rUC3yufYF5MDGJUKE?=
 =?us-ascii?Q?nAHSjUpF94sKPuoXWrFEnAo6Dorj64q+qUUXvt7dMCubVzOjcupJS6VWgiW1?=
 =?us-ascii?Q?I9WHWEgJOgtmfwbAZUJwGfkcqiiCvDBU2y/ATHwYNt/iOs773BH5aE8vsxQS?=
 =?us-ascii?Q?pHJYuH1rtk3Oe3YKt+gdh5kJ0AzdmrEH8YS4Hgud0M6wQWxJNcyNKAwNhbIT?=
 =?us-ascii?Q?fPgRbH+TeLXOQoh/DSyIzMIFsiqKAxqnJF31exATbTZP/1pLaUUmSPiwLZJ3?=
 =?us-ascii?Q?Rrm7njEgrvCWZzyWb6eF9J4z3cfI/eBpaZv6l+KkaJ4geCZ5KaVKCuzEO3Yc?=
 =?us-ascii?Q?gPMLoVGpN1XomTG0N7XkLDJp83RAXG0UpFx/Yjilw+wugWY4AKuMug7hYU/U?=
 =?us-ascii?Q?aOYblbR6HuBffo3wv9QMVYkzyfYNNcYOEHKkNuf6fCAlDgCYxBWi72O/0Yj6?=
 =?us-ascii?Q?5ifXbMAUGylQ2P/YSIUhWb6q834o2u3qWaEX9jqbtrpwtNz+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa471dd4-ef57-47b6-0645-08df12dac215
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 03:38:07.8086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc2UzQNVVzpiVVAy1e1dvzvgOzABgkNg2uHG4AU4YWx4lWBTFn6maJtRcpHeEgam
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Friday, September 11, 2026 2:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 6/6] drm/amd/ras: remove obsolete ras mp1 v13 manager cod=
e
>
> Remove obsolete ras mp1 v13 manager code.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/ras.h            |   9 -
>  drivers/gpu/drm/amd/ras/ras_mgr/Makefile      |   1 -
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   1 -
>  .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 161 ------------------
>  .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h    |  30 ----
>  5 files changed, 202 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.=
c
>  delete mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.=
h
>
> diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras=
/core/ras.h
> index 47fa30f94a2a..73e3960c7c8e 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras.h
> +++ b/drivers/gpu/drm/amd/ras/core/ras.h
> @@ -205,15 +205,6 @@ struct ras_psp;
>  struct ras_eeprom_mgr;
>
>  struct ras_mp1_sys_func {
> -     int (*mp1_get_valid_bank_count)(struct ras_core_context *ras_core,
> -                     u32 msg, u32 *count);
> -     int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
> -                     u32 msg, u32 idx, u32 reg_idx, u64 *val);
> -     int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
> -                     u32 msg_id, uint32_t param, uint32_t *read_arg);
> -     int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
> -                     uint64_t *enabled_mask);
> -     int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool e=
nable);
>       int (*mp1_send_ras_msg)(struct ras_core_context *ras_core, u32 msg_=
id,
>               u32 *params, u32 num_params, u32 *read_args, u32
> num_read_args);
>       int (*check_ras_feature_status)(struct ras_core_context *ras_core, =
diff --git
> a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
> b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
> index 4f94c97c15ca..c70760f10ffd 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
> @@ -21,7 +21,6 @@
>  RAS_MGR_FILES =3D amdgpu_ras_sys.o  \
>               amdgpu_ras_mgr.o \
>               amdgpu_ras_eeprom_i2c.o \
> -             amdgpu_ras_mp1_v13_0.o \
>               amdgpu_ras_mp1.o \
>               amdgpu_ras_cmd.o \
>               amdgpu_virt_ras_cmd.o \
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index 7dd8a331bd1d..07dd62ae460b 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -30,7 +30,6 @@
>  #include "amdgpu_virt_ras_cmd.h"
>  #include "amdgpu_ras_process.h"
>  #include "amdgpu_ras_eeprom_i2c.h"
> -#include "amdgpu_ras_mp1_v13_0.h"
>  #include "amdgpu_ras_mp1.h"
>  #include "amdgpu_ras_nbio_v7_9.h"
>  #include "amdgpu_ras_bert.h"
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> deleted file mode 100644
> index 548594373d0b..000000000000
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> +++ /dev/null
> @@ -1,161 +0,0 @@
> -// SPDX-License-Identifier: MIT
> -/*
> - * Copyright 2025 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -#include "amdgpu_smu.h"
> -#include "amdgpu_reset.h"
> -#include "amdgpu_ras_mp1_v13_0.h"
> -#include "smu13_driver_if_v13_0_6.h"
> -
> -#define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
> -#define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
> -
> -static const enum smu_message_type pmfw_eeprom_msgs[] =3D {
> -     [RAS_SMU_GetRASTableVersion] =3D SMU_MSG_GetRASTableVersion,
> -     [RAS_SMU_GetBadPageCount] =3D SMU_MSG_GetBadPageCount,
> -     [RAS_SMU_SetTimestamp] =3D SMU_MSG_SetTimestamp,
> -     [RAS_SMU_GetTimestamp] =3D SMU_MSG_GetTimestamp,
> -     [RAS_SMU_GetBadPageIpid] =3D SMU_MSG_GetBadPageIpid,
> -     [RAS_SMU_EraseRasTable] =3D SMU_MSG_EraseRasTable,
> -     [RAS_SMU_GetBadPageMcaAddr] =3D SMU_MSG_GetBadPageMcaAddr,
> -};
> -
> -static int mp1_v13_send_smu_msg(struct amdgpu_device *adev, enum
> smu_message_type msg,
> -                     uint32_t param, uint32_t *read_arg)
> -{
> -     return amdgpu_smu_ras_send_msg(adev, msg, &param, 1, read_arg,
> read_arg ? 1 : 0);
> -}
> -
> -static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_c=
ore,
> -                                       u32 msg, u32 *count)
> -{
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
> -     u32 smu_msg;
> -     int ret =3D 0;
> -
> -     if (!count)
> -             return -EINVAL;
> -
> -     smu_msg =3D (msg =3D=3D RAS_MP1_MSG_QueryValidMcaCeCount) ?
> -                     SMU_MSG_QueryValidMcaCeCount :
> SMU_MSG_QueryValidMcaCount;
> -
> -     if (down_read_trylock(&adev->reset_domain->sem)) {
> -             ret =3D mp1_v13_send_smu_msg(adev, smu_msg, 0, count);
> -             up_read(&adev->reset_domain->sem);
> -     } else {
> -             ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
> -     }
> -
> -     if (ret)
> -             *count =3D 0;
> -
> -     return ret;
> -}
> -
> -static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras_core,
> -                                  u32 msg, u32 idx, u32 reg_idx, u64 *va=
l)
> -{
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
> -     uint32_t data[2] =3D {0, 0};
> -     uint32_t param;
> -     int ret =3D 0;
> -     int i, offset;
> -     u32 smu_msg =3D (msg =3D=3D RAS_MP1_MSG_McaBankCeDumpDW) ?
> -                          SMU_MSG_McaBankCeDumpDW :
> SMU_MSG_McaBankDumpDW;
> -
> -     if (down_read_trylock(&adev->reset_domain->sem)) {
> -             offset =3D reg_idx * 8;
> -             for (i =3D 0; i < ARRAY_SIZE(data); i++) {
> -                     param =3D ((idx & 0xffff) << 16) | ((offset + (i <<=
 2)) & 0xfffc);
> -                     ret =3D mp1_v13_send_smu_msg(adev, smu_msg, param,
> &data[i]);
> -                     if (ret) {
> -                             RAS_DEV_ERR(adev, "ACA failed to read
> register[%d], offset:0x%x\n",
> -                                     reg_idx, offset);
> -                             break;
> -                     }
> -             }
> -             up_read(&adev->reset_domain->sem);
> -
> -             if (!ret)
> -                     *val =3D (uint64_t)data[1] << 32 | data[0];
> -     } else {
> -             ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
> -     }
> -
> -     return ret;
> -}
> -
> -static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
> -                             u32 msg_id, uint32_t param, uint32_t *read_=
arg)
> -{
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
> -     int ret =3D 0;
> -
> -     if (down_read_trylock(&adev->reset_domain->sem)) {
> -             ret =3D mp1_v13_send_smu_msg(adev,
> -                     pmfw_eeprom_msgs[msg_id], param, read_arg);
> -             up_read(&adev->reset_domain->sem);
> -     } else {
> -             ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
> -     }
> -
> -     return ret;
> -}
> -
> -static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_c=
ore,
> -                                          uint64_t *enabled_mask)
> -{
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
> -     int ret =3D 0;
> -
> -     if (down_read_trylock(&adev->reset_domain->sem)) {
> -             if (amdgpu_smu_ras_feature_is_enabled(adev,
> SMU_FEATURE_HROM_EN_BIT))
> -                     *enabled_mask |=3D
> RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM;
> -             up_read(&adev->reset_domain->sem);
> -     } else {
> -             ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
> -     }
> -
> -     return ret;
> -}
> -
> -static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core, b=
ool
> enable) -{
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
> -     u32 param =3D enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK |
> -             ClearMcaOnRead_CE_POLL_MASK;
> -     int ret;
> -     u32 smu_msg =3D SMU_MSG_ClearMcaOnRead;
> -
> -     ret =3D amdgpu_smu_ras_send_msg(adev, smu_msg,
> -                     &param, 1, NULL, 0);
> -     return ret;
> -}
> -
> -const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 =3D {
> -     .mp1_get_valid_bank_count =3D mp1_v13_0_get_valid_bank_count,
> -     .mp1_dump_valid_bank =3D mp1_v13_0_dump_valid_bank,
> -     .mp1_send_eeprom_msg =3D mp1_v13_0_eeprom_send_msg,
> -     .mp1_get_ras_enabled_mask =3D mp1_v13_0_get_ras_enabled_mask,
> -     .mp1_set_debug_mode =3D mp1_v13_0_set_debug_mode,
> -};
> -
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h
> deleted file mode 100644
> index 71c614ae1ae4..000000000000
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/* SPDX-License-Identifier: MIT */
> -/*
> - * Copyright 2025 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -#ifndef __AMDGPU_RAS_MP1_V13_0_H__
> -#define __AMDGPU_RAS_MP1_V13_0_H__
> -#include "ras.h"
> -
> -extern const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0;
> -
> -#endif
> --
> 2.43.0

