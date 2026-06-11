Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA22CD98C7
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 08:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC8210ED6A;
	Thu, 11 Jun 2026 08:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cWEHgFON";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A00510ED6A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 08:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKDkZCk9qsbFtJU8f1U2QSiHhQK2raZR+uOV+YN/uuvdx4cORURJ7W6+Q3R7wJYDo3EIW5L02WApPUcjv8t85MvUq7t62emCBU4ZwtLD7fJLU6QxTgfRsnh+cL4qKhG8vCHXpRp8/oE9Tc5CwWd3P8h9kBmh2mHNhj8w8CMsJSa/Sdband7/t5+Tk4WugIr7lkUr7NQUeLYe6Cx6M8fweo2mH16/JupyT/yOHjWyzae9qsHcwzumx7G5oAzAkCeMiWFFMEuN0McLcKrpi7uPZ+dIaqn8pmvTuV1IezYqT0MeLrwExmlwP+5kQqcYQWgyM9BYNQN9FHyOtddlfeI3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+FWjcGTbX8r82hw3IFetwfRFB+DZwjTwC6EAOYa7/0=;
 b=XPjwQ4tYuqSu9SnuONdkfQ0LJMH2gDls3Prw8aQscUChHIVTTq9trEVOFwW0CX3IzM3x7rzGBK6MlMOZJGdi/vcg49XSCf9xn9b/uAeYUR1ABPtepLK0LshZdlsGyisdlLFMNkxYINSkOGkZiwXMM8iK7xAvqWtpmiCdSV6sD0xW5NLPMt6ZWRcLoCdyTKEcgxqTI408AHIczBuP0/ECq5Dj38HgbZTphdVbZb0k16IhftfV+Z5meuvJ4L737pFYrJPl07lr6Mz0Vjxg0oqJ9+2c6GJF+G0+j8NU3QfIGnLAmBoj8mWkFG7ohQjoMWcp+TWqaq6M2SQn+jWeugGsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+FWjcGTbX8r82hw3IFetwfRFB+DZwjTwC6EAOYa7/0=;
 b=cWEHgFON1Tu6vkU0N7g20rsN6Fqskzqk8zOg9p9WDTtfyvtHeJKgd5qaF+HUyM42bMaobdh7QFMowlkdceYhsvQmxMvwkE39JZryn/aos7MCwudm3U0LyB+Tr0jgDBSQGa8R4CIZwzqGnkzhiBLfhFiDoNYUMNz0K1CI4D5cLj4=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 08:19:07 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 08:19:07 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/ras: Add address sanity check for uniras
Thread-Topic: [PATCH v2] drm/amdgpu/ras: Add address sanity check for uniras
Thread-Index: AQHc+XYulXZFGVlTk0Wbr2ZgHZgYVbY5AoGA
Date: Thu, 11 Jun 2026 08:19:06 +0000
Message-ID: <PH7PR12MB8796642A6631CFFFF8644D21B01B2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <fef4383d214d9f82eb2f5426aecf5f3a27e33b6a.1781163712.git.cesun102@amd.com>
In-Reply-To: <fef4383d214d9f82eb2f5426aecf5f3a27e33b6a.1781163712.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-11T08:17:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB7269:EE_
x-ms-office365-filtering-correlation-id: 0523d0b7-0fc3-4053-8642-08dec7921b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: lZKOD+0NkXpv//oI9laIIBSv1vBeJxmG7KnoF6tbqZwfXXzse82+JSFX+k8iSmSD6d3VHUbLW8Bxzd6X1mNVySSp4CrnFsu19O6gZ8rI0tDpyVm/dCH9SBJ9olAmUIuueDimV434nMhYrxZ3jxPa0D+irr49QhT9RldsKq7oBe7gZ2K2E3G//jg0lU8nE4yCF83VsHFE70jCJH2mvdUXE87I476YOIqODDlitcaJoBaKqfxLllIwsgKg7/p2Lsi6wjIOtn/aHQkn+tz4cXh1pTuGaH7lMmgZYks5BxHQlGk90klt3CFf/GL5dNra3hgnwgMPGjjgOa3YJRwqmWdsh8Xb9KsEPDr3yDakZHgR3EQHYz4H0AtBZzZzPY6qr0DqMA0pFj2WaGHCeLeHVcsCsvpmOAl/sYAxjjIJUIx9sRwLuAM2np/7504yM5L/vcum1PfEDozcA6v7nILuYDiV2xBMQnOT+U5AjFbvbpgjKdCFbpFd5jiQMJMlNOMpviuDh+XEATesQozaH3RPSCrXJkL1YQ/4f/2c5kPEDVO5w0OIWdtlu35e7UboleJ6LzHn3IFpQI2iiKLpD4nfToCiZ6jB02tqJ/6GNdIBgacWrLeb9ct5IpmN/c73RbQE4cH/cDS1jgN/A1YK8XPG8RzsuWrb8+fyWC6lRpr17p6DXb229DEyAbFeen8trGp4IubEQVmFPY2lCxccE+zvbWgiVzxmbT3AaBp23ueBnt8ml2h2hCyM3KkQU93RQDkaqCVg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ECqEkGaPFobsJLahZuRA0bc5pe4D0IPE80ZN1EvAQmsLtdkBoWgb8GfAAl0E?=
 =?us-ascii?Q?Esm/oDho45sNAxHFhgYoNpTw90mJsaq+0IWNfKjt/T/dSaQr9JO9yZHRrubK?=
 =?us-ascii?Q?l/DoLhz/CGS8jO7Kv/UmqclK+1tjOowF2tnMMOnGy9ddk+WmmYuZ9n5cLOW7?=
 =?us-ascii?Q?c+CbISG0cDiaAZn0vsygZVbmO95vbQDoA4GFcna7fAKmf1lsBItdgqzUcDgj?=
 =?us-ascii?Q?SDVOkgH9ZF3fasPko9Wh3hvgcLELKGbO8xLeY0mdBnvt81T9Y5JbDOEUaGtD?=
 =?us-ascii?Q?dQZRjf7dpxgb7UHflcU30tiYpdzEnUN+sxd9q9T449pM2ys+hHIeufAKn5b6?=
 =?us-ascii?Q?bFDuiw4NQpDtWPVVTAcm+fnntpAetP/WFtJLacfmabzQIY0aVTJuBFzlmgYa?=
 =?us-ascii?Q?AEW/L9/hTpO+KyVd43l9fjTxe/B2Uq09k9zabdPpuDP6WzTIruVe60ZAnw3S?=
 =?us-ascii?Q?JZgLry7GKh0lfIlvXDVd9y5k5BLLi/RoOyRfC4vBM/GoZJNddw3VVX+PJoMl?=
 =?us-ascii?Q?S791dmCPR3G/Nq1v80TWfnpaUSeCrWLVAAOPjCyuhr7NnRwBBCK3tVx5XezJ?=
 =?us-ascii?Q?G0YMjTqOaYKkk/0dTfsgmZCDQuaoBRdfe/V7CiqZCfTbNsouOTbU76u1X+LD?=
 =?us-ascii?Q?gu5ACNLJqV2hiV8EHvRMx4S4y4ji1u0VOth6t6EPuT/0yUeP0mWlr7FMcCsd?=
 =?us-ascii?Q?sYiG+/M13eXoaL7tRoJDdNcCFGpTwZ+SRYvKGtJKzINhbYvJ4ne5kSD+t8DJ?=
 =?us-ascii?Q?pyNoCVyKWC8Xv5Qv+UwGBKqTceX5wbGrs/+kMfdUbXSWv1hoZzjPjCXOY4gn?=
 =?us-ascii?Q?YFGyzIz1N2g2EaBgHLeEABiVjdVgTrJ6RCbfJOgkhCR1BsKrL2LuPUmU+LvJ?=
 =?us-ascii?Q?ZyLo6H66745pKmRdbeNi/8Eq9hTkcsDqdCwAzZRlIfeQshtv6g/Lg14XmWBq?=
 =?us-ascii?Q?bdbinSZhizVXYuQtuXV5ZC/6k3FuKoF38iPOCHOhOQCG+A6n7DU9A3F9ZDcq?=
 =?us-ascii?Q?w+ZC0cNY6zhK4VlN0UASmzJRgzshybRMshkBqwOzRtRWZG6suFlPcBQyjgT4?=
 =?us-ascii?Q?V3c+o++EGyQjGOM5z3PVTfx5yTONRyPUayK13MGeiOQJH418uvq5YzOg3zgX?=
 =?us-ascii?Q?PfWxA4zfByJQ8d3Wodzovkb4n/dSJSutJz6fKgJ82R+OJF1G9xlHTOy3GEtl?=
 =?us-ascii?Q?3os2phnkofnIA0VZje4wa7ZwKhVQHpQDUtLuYo/gQdCC+u3ZJutv+A8OKYr5?=
 =?us-ascii?Q?S5hOYvMJK5UfMHvkP3viCJmGswFXecgNdf6J1pQ0UE1F1hZSWjaNolqc44ts?=
 =?us-ascii?Q?dDy8EqmlBfeCq4p+dtG7u5anH5u1v8JQzfpyRu64wt2PkrlRDxdWSt8haxiW?=
 =?us-ascii?Q?oiBQcvXIp2ZF/dSgQyiHArAbMx5yxKyD0RAhZrgACtYNNkqkHe0MKfukgCLf?=
 =?us-ascii?Q?XTzCrzpJc7m0Td15G/1uEl45B5YmRNfO5NxkRD3hdntSNJPspLvvlW626Kha?=
 =?us-ascii?Q?4kfdM5yIzkV+T7E6rZ72avaCfIzBkA/Ee2y25e2m7BJr0aFbPRMpbU2xxTCt?=
 =?us-ascii?Q?syBtzeeWk16PI2xKvgJOBXZMf7R8a9vceWASsoQmG04wsqpN1KF5LFHibF0A?=
 =?us-ascii?Q?wc4d8ykNnxp3zUu7KYYHaQeM+an2j0I6YtVj1nnRQwbbxkxE2wLbloJAYOGn?=
 =?us-ascii?Q?wSeg6m6YtA98OXU/4YsPRvHbWU3qwL14YFgei9+83gUM5xML?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0523d0b7-0fc3-4053-8642-08dec7921b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 08:19:06.9996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3IhiMHtseLkEAV4fL5O/Z0NfHbQ0WE9lf8BlU113lwWGz+or7irk03XFJNrdUjX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
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
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Thursday, June 11, 2026 3:45 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord)
> <Ce.Sun@amd.com>
> Subject: [PATCH v2] drm/amdgpu/ras: Add address sanity check for uniras
>
> Add address sanity check for uniras
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  3 ---
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 18 +++++++++++++++
>  drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |  3 +++
>  drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 10 ++++++++
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 23 +++++++++++++++----
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  2 ++
>  7 files changed, 54 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> index 658bf3fdb66b..bfbfdffbfbe6 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> @@ -30,9 +30,6 @@
>  #include "amdgpu_ras_mgr.h"
>  #include "amdgpu_virt_ras_cmd.h"
>
> -/* inject address is 52 bits */
> -#define      RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
> -
>  #define AMDGPU_RAS_TYPE_RASCORE  0x1
>  #define AMDGPU_RAS_TYPE_AMDGPU   0x2
>  #define AMDGPU_RAS_TYPE_VF       0x3
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> index 7d728e523604..eb840f0861fe 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> @@ -266,6 +266,23 @@ static int amdgpu_ras_sys_put_gpu_mem(struct
> ras_core_context *ras_core,
>
>       return 0;
>  }
> +static int amdgpu_ras_sys_check_address_sanity(struct ras_core_context
> *ras_core,
> +                                             uint64_t addr)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
> +
> +     if ((addr >=3D adev->gmc.mc_vram_size &&
> +         adev->gmc.mc_vram_size) ||
> +         (addr >=3D RAS_UMC_INJECT_ADDR_LIMIT))
> +             return -EINVAL;
> +
> +     if (addr >=3D adev->gmc.real_vram_size) {
> +             RAS_DEV_WARN(ras_core->dev, "Recorded address out of range:
> 0x%llx!\n", addr);
> +             return -EINVAL;
> +     }
> +
> +     return 0;
> +}
>
>  const struct ras_sys_func amdgpu_ras_sys_fn =3D {
>       .ras_notifier =3D amdgpu_ras_sys_event_notifier, @@ -277,4 +294,5 @=
@
> const struct ras_sys_func amdgpu_ras_sys_fn =3D {
>       .detect_ras_interrupt =3D amdgpu_ras_sys_detect_ras_interrupt,
>       .get_gpu_mem =3D amdgpu_ras_sys_get_gpu_mem,
>       .put_gpu_mem =3D amdgpu_ras_sys_put_gpu_mem,
> +     .check_address_sanity =3D amdgpu_ras_sys_check_address_sanity,
>  };
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> index f34dda7ce87b..2775c7bf41b7 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> @@ -30,6 +30,9 @@
>  #include <linux/mempool.h>
>  #include "amdgpu.h"
>
> +/* inject address is 52 bits */
> +#define RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
> +
>  #define RAS_DEV_ERR(device, fmt, ...)                                   =
            \
>       do {                                                               =
       \
>               if (device)                                                =
             \
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index c059fcebaf00..5869bad978b0 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -231,6 +231,7 @@ struct ras_sys_func {
>               enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
>       int (*put_gpu_mem)(struct ras_core_context *ras_core,
>               enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
> +     int (*check_address_sanity)(struct ras_core_context *ras_core,
> +uint64_t addr);
>  };
>
>  struct ras_ecc_count {
> @@ -398,4 +399,5 @@ int ras_core_get_device_system_info(struct
> ras_core_context *ras_core,
>               struct device_system_info *dev_info);  int
> ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_cor=
e,
>               uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);
> +int ras_core_check_address_sanity(struct ras_core_context *ras_core,
> +uint64_t addr);
>  #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index ad6fffaa42de..61d100b074b9 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -676,3 +676,13 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct
> ras_core_context *ras_core,
>
>       return count;
>  }
> +
> +int ras_core_check_address_sanity(struct ras_core_context *ras_core,
> +             uint64_t addr)
> +{
> +     if (ras_core && ras_core->sys_fn &&
> +             ras_core->sys_fn->check_address_sanity)
> +             return ras_core->sys_fn->check_address_sanity(ras_core, add=
r);
> +
> +     return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index e5971c3dd7da..f56d37d09044 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -406,7 +406,7 @@ static int ras_umc_update_eeprom_ram_data(struct
> ras_core_context *ras_core,
>       struct ras_umc *ras_umc =3D &ras_core->ras_umc;
>       struct eeprom_store_record *data =3D &ras_umc->umc_err_data.ram_dat=
a;
>       uint64_t page_pfn[16];
> -     int count =3D 0, j;
> +     int count =3D 0, i, j;
>
>       if (!data->space_left &&
>               ras_umc_realloc_err_data_space(ras_core, data, 256)) { @@ -=
418,10
> +418,23 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_cont=
ext
> *ras_core,
>                                       bps, bps->cur_nps, page_pfn,
> ARRAY_SIZE(page_pfn));
>       if (count > 0) {
>               for (j =3D 0; j < count; j++) {
> +                     if (ras_core_check_address_sanity(ras_core,
> +                             page_pfn[j] << AMDGPU_GPU_PAGE_SHIFT)) {
> +
> +                             for (i =3D 0; i < data->count; i++)
> +                                     if (page_pfn[j] =3D=3D data-
> >bps[i].cur_nps_retired_row_pfn)
> +                                             break;
> +                             data->bps[data->count].cur_nps_retired_row_=
pfn =3D
> U64_MAX;
> +                             data->count++;
> +                             data->space_left--;
> +                             continue;
> +                     }
> +
>                       bps->cur_nps_retired_row_pfn =3D page_pfn[j];
>                       memcpy(&data->bps[data->count], bps, sizeof(*data->=
bps));
>                       data->count++;
>                       data->space_left--;
> +                     data->bad_page_num++;
>               }
>       } else {
>               RAS_DEV_ERR(ras_core->dev, "Failed to convert record to nps
> pages!"); @@ -521,7 +534,8 @@ static int ras_umc_save_bad_pages(struct
> ras_core_context *ras_core)  {
>       struct ras_umc *ras_umc =3D &ras_core->ras_umc;
>       struct eeprom_store_record *data =3D &ras_umc->umc_err_data.rom_dat=
a;
> -     uint32_t eeprom_record_num;
> +     struct eeprom_store_record *ram_data =3D &ras_umc-
> >umc_err_data.ram_data;
> +     uint32_t eeprom_record_num, logical_count =3D 0;
>       int save_count;
>       int ret =3D 0;
>
> @@ -534,6 +548,7 @@ static int ras_umc_save_bad_pages(struct
> ras_core_context *ras_core)
>               eeprom_record_num =3D ras_eeprom_get_record_count(ras_core)=
;
>       mutex_lock(&ras_umc->umc_lock);
>       save_count =3D data->count - eeprom_record_num;
> +     logical_count =3D ram_data->bad_page_num - ram_data-
> >ras_num_bad_pages;
>       /* only new entries are saved */
>       if (save_count > 0) {
>               if (ras_fw_eeprom_supported(ras_core))
> @@ -547,8 +562,8 @@ static int ras_umc_save_bad_pages(struct
> ras_core_context *ras_core)
>                       ret =3D -EIO;
>                       goto exit;
>               }
> -
> -             RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM
> table.\n", save_count);
> +             ram_data->ras_num_bad_pages =3D ram_data->bad_page_num;
> +             RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM
> table.\n",
> +logical_count);
>       }
>
>  exit:
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> index 237525b46b9b..ad12796a048f 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> @@ -119,6 +119,8 @@ struct eeprom_store_record {
>       int count;
>       /* the space can place new entries */
>       int space_left;
> +     int bad_page_num;
> +     int ras_num_bad_pages;

[Tao] better to add comment to explain the usage of the two fields, with th=
is fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>  };
>
>  struct ras_umc_err_data {
> --
> 2.34.1

