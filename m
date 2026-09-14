Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B369AC88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 07:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4485F10EB9A;
	Mon, 14 Sep 2026 07:10:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vcr3AKgr";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C176210EB9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 07:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbwJl8uYd05K5goTOhQhfPeRJYxw1YmtbarpGiTGtaKO0xSeKOpI//KbU+iOPBjkasyik5JGvN3ARMzdZR7egbhzw9BR43khihGYiWnBKIcw2MayuOFSXshQ1eXIii7dqqSklifWDe0AUwyVhaaaO8R0d4PgFNHxTVIF9ndwVn75Rbbjct9iMAQZp4BZQ6zBht48oCqC7ZSqsQYWysmlNrIwEJ/bbB2floOMT1sCI33fNLryLB2aUiwgGuEwuy/72QkrAveZw4smyMqjJlQ5V67LJI26mQ//Ask/aRDM0ZSVPHQ3M8HJX5LVyT4rJMqCPG/Ey4RgNJwNALJNLUlysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smp7zh6A6XgF2nnqz5XDcDbMe1I4AfI3ksoy9cGoRGM=;
 b=miJ2hbTfDLv99AiuCvXUZUeAkGMNJmBul6U8SQe7AbFKy/s1betj1yLSrKh9OO413rBibW+RgxjqIrmmSsqYH9XvXuIncRYPG4r68S/hkDB3C7mgaya4ZEkAKZr4OAltiH41P10Jh51HgzOY6/kgwr3kH1a5+eVWPo2+d3VM98idNhlXdld2NUGd1EcyezzbfiyW+9NXyE+P66WMw0/y/l8bn2SkkMFYxw+uLTqOrUrJxaXFdVna8bLOC709YKotKHPGLDE1s2VCIrJ9/eUIu/Rgim2k/xDDQkmfj/Lrkwvdyjlhtr2VkryJBe+wnVRUAifGIaWMThClObemlW9wnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smp7zh6A6XgF2nnqz5XDcDbMe1I4AfI3ksoy9cGoRGM=;
 b=Vcr3AKgrszkO7t6fPeh7HYNwRlHJoL2C4IScCAN+xkxFCAokWnhJnozwZ4trDH2xySJbcOevC4q4Rpwv560yuCLKA91tD7CdYpWnkWlLejTeaoG/KUePEz1SmhBu+d39ER+O67QcDPyXto/X4KKe7I96iFXzdTjnuiSM2Eh8KVA=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 07:10:12 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 07:10:12 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add GetRmaStatus message
Thread-Topic: [PATCH] drm/amd/pm: Add GetRmaStatus message
Thread-Index: AQHdQb5PG3WLs2ZP2Ue4PcISe4nq9LbNrJMQ
Date: Mon, 14 Sep 2026 07:10:12 +0000
Message-ID: <BN9PR12MB52118766BD251D94FDA93F9F93BB2@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260911072156.1698346-1-YiPeng.Chai@amd.com>
In-Reply-To: <20260911072156.1698346-1-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-14T07:09:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|SN7PR12MB7322:EE_
x-ms-office365-filtering-correlation-id: 5f72f267-ed22-4f92-4308-08df122f383d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: k8zfQx0HmOyLVi8klwCWZOPp33H8FpXXzEfPokj09PdmuuGdQeQK5rHL7XvVO6TOWc+fojkAfO+usbJRYIw//Ki/0y3lw+m3wONAHj6uqdYJj841ffFP2CdwLA+pRN9ceUqtyJcksVzCJ3ru0c0tSvTtQ5WSFg1J11A7tp5AdsW49uufOYikK4Nw3LJezXFC75zmeUtyn35Rd+N8RZw8k4Uus89j3sBwlHEiXvk7xrLKOw2mf0LS5n/oQZawF+bYHc6rzxKLmGHWtu/JHzf25nPHFL4HoabCwTqtqjZkkeC5NJqi+y7svqYiWvuVw9bm/PT7rgVG2AmSCtbWmTLfJwHHfIKdSBFDUO/sfoliPTRJyOnz3mzYm0pvzUwj7a2ZkLGpsQqYPadL5jNpbrmMOzMyNSeuZHVFv0U7X1YiloFECOjgXr/e3N0K3UYBHGzrdPgDomcWAQxSY45vndVTObmVU54dwgBz4GwI5kTiI3auoQ7c/DuVl0PHgLIdjEvmuvoSI8F30dkVY+vN50+jlu1t8KTPGl6XAabFxVzHp2oDI5IMLnazjewV7HFcCgB5aU3FVVRBiER8oBJNK+XGWCK/exgQS+5m7WZuZiFSdZktGNgAaw1HoZt8mGbLPX0hkfjm0KovP7HMuyrlA0kb2pF6ZAk5KThKOjpQmV3intmhwABm4uiHvYRoAaKfnX/M1TXPpoicH0uVGvY3DERnx+fEDnO/XT//nK2Ar38g7Og=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hWgn5GHRxZs7sP54pYc5gHkPh7/M23jR0ozaP9ZVRo9j/p0NFnmx3kycR7vR?=
 =?us-ascii?Q?yq9mpdZzYmeiwnGvhWmDOsuzAm0ZaNIQ/h+k6+i4Nq2OOoWDgO6IFvarSpjm?=
 =?us-ascii?Q?JpzNuUeJTD/juItYJyMr4QUhcf+p5u9NGfslZU+00pd8kG02sEcbhwkEyiHF?=
 =?us-ascii?Q?i+4LXeFczhBtAxaXzRq/23EGYrTy+AVB0skMHWenOlPxOExn+164wwkamhNm?=
 =?us-ascii?Q?FCRkQXFnbscTBJGr1wK6NfFPmfLRiifqahDSfgfAU8JXj6S7v69IdOFXDVIB?=
 =?us-ascii?Q?7zU7iv0WitbJWAKY5XQrROl1e69ogqDdF1zUoKM5hAJ3QtEVN5c94a6L9Ys6?=
 =?us-ascii?Q?OuaG0xmrINEL9ddt8kX1YGEa58CdLYeqze74JuHB4qhscQ1scbyTbawMcv68?=
 =?us-ascii?Q?N2FIcf5XmY7p4U9chAG5WpKU6u3p7GJspmFKFhYVX0PqoYU/k+H9z6rZ1atw?=
 =?us-ascii?Q?EjCJIv+jRUkezilWpE3bxdghM0P/fPWk2BSGvLm7hB0NCzdM7NtEzbgUPZ47?=
 =?us-ascii?Q?G0QiRU8E+MuvRQoD9YM22VyxlZ2tMhtlkTeDzU9DWyuVYHibkvyTRf9fnmmh?=
 =?us-ascii?Q?ddhNBX2Cg7Qe/1auY0eJwBdpHB0iYfp/i3UA29PiLoR6bUNN8IxQeqsYQUb2?=
 =?us-ascii?Q?pxoWdhi2xZDGlq6Iadbd0q4N3CdfaY8/dE2VoqVuYSppid8ppVRDmrWLnsgI?=
 =?us-ascii?Q?oF6YFK6D7JCHY7yoRgEGZKNhO3stId6/IwprNZo8ZGDAJP4kuJN4mkCaZNry?=
 =?us-ascii?Q?8cYCuC1HvOuD87Ln4QA60w7yoKoIqGIh1kkFa5fFpXcZO4eV+66PX3yEvJbw?=
 =?us-ascii?Q?8UETSiW0X2tdVmDU2F3YLqewv2+03R7PQ4CyC8VN8C4dNWgQpzOVh1WYyJrB?=
 =?us-ascii?Q?wUvc5aX+F3p2lWy0q7j4CPGd2mdw+2S8QKTZwWeCuMY03O1cXZRFod9/QmYu?=
 =?us-ascii?Q?QPStX4GEXwur0OTyko81it3PPb4pTwhUrBXOunMDesr2nf8in7vwiP9yrmau?=
 =?us-ascii?Q?eXmRCWlUFT3667ey+NzwuukEQBSRMB3O4g1PjJ6HlEldtp3ooQNqZDe09/fY?=
 =?us-ascii?Q?PTBmghJhs3praw2YdleswTP+jF5lJGlo2cQHOM5EMSExLnGMPfa6DKazMmZo?=
 =?us-ascii?Q?2TobcIwjhfzoayLPYHNTM1aFYV/KRlveWPUw0h6vTiSl8ziDJJ/FiAkwq5/M?=
 =?us-ascii?Q?E+6XizvtYrJQevaHNIwOESlFHvJgJg6aJx2wanGUxsZioO+v7UflRD5E289c?=
 =?us-ascii?Q?C6MB2eyCdlMvQHICHuyDUL/83NykDZLk2HCCKSdQCUdmenphBc89mwJb5X68?=
 =?us-ascii?Q?4p8AAByC1H7LECUQEsqEqsVzmsymfZvzOCOROLCrwd3jCDaaFdq0Uo24fy7q?=
 =?us-ascii?Q?uBN9BUKezZIdYWUmimmOIbYb4HdjrHHLhuHgr0w7D6drKoVls+kMX7iKpDvj?=
 =?us-ascii?Q?guiPQEoi1qtfVWmtzWTJfShN3P8/50bOU2kDHmEYL1YpJGoMURyjLX5FaMKs?=
 =?us-ascii?Q?IJB/HWO6udsniexorHzwJhFMVPz/9K8ab7DRa7vlyLDJO3GyTFlzRZJHiih1?=
 =?us-ascii?Q?cKNh8h7K/JzvqX9hpsUPB+bXQQTjsXzCq3G3qu1Y54a3fMlB56iaGAZY5eKw?=
 =?us-ascii?Q?/fp9FH5AJMIcRaWOSaU7TwWZq8c94SStDu1SuwcE4H8w7XmvB8yyK3oVqYl8?=
 =?us-ascii?Q?SHHY5PBl474Mq/JTmGFXkg9SsLhzGtVjAXn67e5g/SpFkcRS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f72f267-ed22-4f92-4308-08df122f383d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 07:10:12.5960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRSv3m6MwGN3bZjXDCLmPcnNOlx1vPJChLEniZy5j3MZd7tc/TFmVZxGKUioQ8we
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
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

Reviewed-by: Kevin Wang <kevin.wang@amd.com>

Best Regards,
Kevin

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Friday, September 11, 2026 15:22
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Wang, Kevin <Kevin.Wang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amd/pm: Add GetRmaStatus message
>
> Add GetRmaStatus message for smu_v13_0_12 and smu_v15_0_8.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                  | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c         | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c          | 1 +
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c              | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.=
h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> index d09b6ae9827e..ac7e617e64ad 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> @@ -105,6 +105,7 @@
>  #define PPSMC_MSG_UpdatePccWaitDecMaxStr            0x4C
>  #define PPSMC_MSG_ResetSDMA                         0x4D
>  #define PPSMC_MSG_GetRasTableVersion                0x4E
> +#define PPSMC_MSG_GetRmaStatus                      0x4F
>  #define PPSMC_MSG_GetBadPageCount                   0x50
>  #define PPSMC_MSG_GetBadPageMcaAddress              0x51
>  #define PPSMC_MSG_SetTimestamp                      0x53
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 1edef38c9209..35ef95a820dc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -292,6 +292,7 @@
>       __SMU_DUMMY_MAP(GetStaticMetricsTable), \
>       __SMU_DUMMY_MAP(GetSystemMetricsTable), \
>       __SMU_DUMMY_MAP(GetRASTableVersion), \
> +     __SMU_DUMMY_MAP(GetRmaStatus),    \
>       __SMU_DUMMY_MAP(GetBadPageCount), \
>       __SMU_DUMMY_MAP(GetBadPageMcaAddr), \
>       __SMU_DUMMY_MAP(SetTimestamp), \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 0033453f27e5..4f3d59897aae 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -152,6 +152,7 @@ const struct cmn2asic_msg_mapping
> smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =3D
>       MSG_MAP(GetStaticMetricsTable,
> PPSMC_MSG_GetStaticMetricsTable,           1),
>       MSG_MAP(GetSystemMetricsTable,
> PPSMC_MSG_GetSystemMetricsTable,           1),
>       MSG_MAP(GetRASTableVersion,
> PPSMC_MSG_GetRasTableVersion,              0),
> +     MSG_MAP(GetRmaStatus,                        PPSMC_MSG_GetRmaStatus=
,
> 0),
>       MSG_MAP(GetBadPageCount,
> PPSMC_MSG_GetBadPageCount,                 0),
>       MSG_MAP(GetBadPageMcaAddr,
> PPSMC_MSG_GetBadPageMcaAddress,            0),
>       MSG_MAP(SetTimestamp,                        PPSMC_MSG_SetTimestamp=
,
> 0),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index b886208ad93d..b69efaecc1bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -126,6 +126,7 @@ static const struct cmn2asic_msg_mapping
> smu_v15_0_8_message_map[SMU_MSG_MAX_COU
>       MSG_MAP(GetTimestamp,                        PPSMC_MSG_GetTimestamp=
,
> 0),
>       MSG_MAP(GetBadPageIpid,
> PPSMC_MSG_GetBadPageIpIdLoHi,              0),
>       MSG_MAP(EraseRasTable,                       PPSMC_MSG_EraseRasTabl=
e,
> 0),
> +     MSG_MAP(GetRmaStatus,                        PPSMC_MSG_GetRmaStatus=
,
> 0),
>       MSG_MAP(GetStaticMetricsTable,
> PPSMC_MSG_GetStaticMetricsTable,              1),
>       MSG_MAP(GetSystemMetricsTable,
> PPSMC_MSG_GetSystemMetricsTable,           1),
>       MSG_MAP(GetSystemMetricsVersion,
> PPSMC_MSG_GetSystemMetricsVersion,            0),
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
> index d8a446d0179e..7ca2f33f2cf0 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
> @@ -36,6 +36,7 @@ static const enum smu_message_type
> ras_smu_msg_maps[RAS_MP1_MSG_MAX] =3D {
>       [RAS_MP1_MSG_QueryValidMcaCeCount] =3D
> SMU_MSG_QueryValidMcaCeCount,
>       [RAS_MP1_MSG_McaBankCeDumpDW] =3D
> SMU_MSG_McaBankCeDumpDW,
>       [RAS_MP1_MSG_GetRasTableVersion] =3D
> SMU_MSG_GetRASTableVersion,
> +     [RAS_MP1_MSG_GetRmaStatus] =3D SMU_MSG_GetRmaStatus,
>       [RAS_MP1_MSG_GetBadPageCount] =3D SMU_MSG_GetBadPageCount,
>       [RAS_MP1_MSG_GetBadPageMcaAddr] =3D
> SMU_MSG_GetBadPageMcaAddr,
>       [RAS_MP1_MSG_SetTimestamp] =3D SMU_MSG_SetTimestamp,
> --
> 2.43.0

