Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B4606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HeaIXLT5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B09710E47B;
	Fri,  6 Nov 2026 21:44:46 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A45F10E47B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 21:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRmBNYODlGlSjORGbbSmivXsL6EfAAtgDcfc7dbeukhnz1/WDA82JtvouDyXaeR1Zj4P1U5oGQj5bUnusfVIv18/1K5EEm60ge/CpTeW7IWPRMsvF9X1LAzpWP+sOSgKO4ccVZfUYPun5SBx/3HeKO5ngK2Xo7Zb3HqtW1H8UB3Z52Vf30Z8DNAIGO8a2x4UNSOTiuff01W8RnjFhmMaYrYM4fr9yGZCzlqr9X0vi23K9h2qpf1JrXTpYAdGhqM+yT0gDFZ3AOv8I2PYMOMuJP74VA5n0yQjHbuWXNWyjnTXMbL48rCDWD+hJvhZX/R7HEZJ+4IJLsk0cQS4FR4JHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjDQ/E8CzYPpK/XYsKVfUsMLnlQZ7x21SDSaCSxTFXE=;
 b=lYk2xubOBFjbJC23Z5pTo/q+HnS1RHy/7it4GoX9yZxTVPa5MLMHpaHE2SBx4uHiWGOAp2nRlBhOc/lOi6VPkISnK9CC3tbbRSzcf6NEoxeMMozpTXSinIZfy85p6QuO2uN6gsd8lAV8B5Mc97FAPhA3JEqoxGzkhmsVUxHsXNvuV+ZpPPFCNdx84Xb1exg0k+eUynvKmg6oA4RUFihww2LJA7fkr1gDO+msMSlRS7Bpup2ODVeMN+8W9EscHID93OChTiU8LNaHCKl+GPDSBGOnuPpa3UNUvpeNArtQXGMTFKF8RpXXrbCZgSadetDzBiIGZU1/P3/fTiRA7kMHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjDQ/E8CzYPpK/XYsKVfUsMLnlQZ7x21SDSaCSxTFXE=;
 b=HeaIXLT5X3E+3Ipi+TJI2K1idzvb8L2y4xM3jhN+/Q6Eb0/HUchnNmYyO4JaauRchByclqphSxJEbv/Lofr4b6t5g9O1V1AQpcbH+OCEDesUO+LB1l1sgbLxmOZldmqwm6zzkggvMOTvK9T90Omaolr3QiIlDwCDheazDYl8z5s=
Received: from PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 by BL4PR12MB9534.namprd12.prod.outlook.com (2603:10b6:208:58f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 21:44:36 +0000
Received: from PH0PR12MB5607.namprd12.prod.outlook.com
 ([fe80::26e0:df91:f91:c41]) by PH0PR12MB5607.namprd12.prod.outlook.com
 ([fe80::26e0:df91:f91:c41%4]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 21:44:35 +0000
From: "Six, Lancelot" <Lancelot.Six@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Indic, Vladimir" <Vladimir.Indic@amd.com>
Subject: RE: [PATCH] drm/amdkfd: gfx12.1 trap handler LDS store ack workaround
Thread-Topic: [PATCH] drm/amdkfd: gfx12.1 trap handler LDS store ack workaround
Thread-Index: AQHdbjXz7Cem3SAGiUug64mokV80j7chk2VQ
Date: Fri, 6 Nov 2026 21:44:35 +0000
Message-ID: <PH0PR12MB56077EBDEF662A52392FF38E83762@PH0PR12MB5607.namprd12.prod.outlook.com>
References: <20261106212932.9400-1-jay.cornwall@amd.com>
In-Reply-To: <20261106212932.9400-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-06T21:43:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5607:EE_|BL4PR12MB9534:EE_
x-ms-office365-filtering-correlation-id: 83cb5bc6-c0a0-4658-e268-08df3c4f26aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|261102123227099003|261026140227099003|56012099006|261021123027099003|38070700021|11063799006|261028144727099003|261009223027099003|261021121427099003|261022105027099003|261026121527099003;
x-microsoft-antispam-message-info: lsH9FGFZSN2p/vVqGFv186fZzMkfWm1hwYYDNW4rwBj33Ly94Oq+zZllvMOwEmrW7kwW2CBwEqXetnmQkBXnDdje1/rvjHWksIYNV1N2rilWJxYhV+fUi/g0vX3XxWImyPbpW4EMV1/FtgW0yimZrljEj748wKRJqstWCB3/Ne0XDoXLzwy+5SkfJY+24cJbbACVh/ODl3mz3M2+1FbgDlJOC/4gEdGuqTO87c6kO7urL3X0KAWf2BKTit2wYrT5ZXg9nWmUNRohzoOQnYot6XrIEKyodyk+qpLJnzMZY5FKbcM5/rJD8/rGoxq4lIiGakz/lotrTrKRACLGPKwuhSLA+RlWrTWVjqqQP0jnkygj/XpjXPOINSIEyHRSiZjQMxxBfz/YKjR9/vRLQLSR3fe/wuSMTBEHqwlq+oWjYOge5eOnyrPHha6FR1ZmtSVoi+enoXqGYoCNhu/xO/MV55T6NWKbKvdctPD4aRYhftME9ecI9lmRpN0KK5h/S6KCrKkSSCp4hZYPPMi1oUJonshLeIVD64L4Bd3/coDytYmuKTSCUHmIg1cC3k2JsreOWpN5knrDWq3N+DRKOOiSmzVWqu2P4QvEeaoU+YJT3SAJwSgCMIyfvvVqSkhxhhKCvhLXlV0PLAbmqoR8wD9Do5UmkaAlm1aUD5ZzjXfousEBQMFArjQQZI7QKhkKzfY8zBTKwPN/ztR2v4EMsx8atCN6uAKExnQisPvrWEPcvQE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5607.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(261102123227099003)(261026140227099003)(56012099006)(261021123027099003)(38070700021)(11063799006)(261028144727099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TNTM1ImDHH9rDl4djyAD3d7oFBTUY2HNWF35AjKurwlxUSl32xmnIcvYU4Mx?=
 =?us-ascii?Q?3uX6ngByx/G2UolFUiYjYs5AnssHTwhL7fHM2qo4LENGVXD807DpwwMLIqNe?=
 =?us-ascii?Q?zzKZd5mg04PzZC1tdHgywO/5qvzuVG0OxeyCjL3abCGhVoslpexfYeDkqJXW?=
 =?us-ascii?Q?GsWTvmj82YkBVuu7umZwefHV7DbzdXKLveh9XWFq0Wh+mvjq10v9fIlTX1iF?=
 =?us-ascii?Q?8RrROKBSsjpLK1BgXsoteC6lcREsLVIhSwFsd2HHkBo+MSFqgDjJUmXPXTfH?=
 =?us-ascii?Q?Jxhz3O/XMMu5vQ0zSU/AyZGkh9lCpQ8qz+fjTqyV2sar3G94rtIlX1LWoZHX?=
 =?us-ascii?Q?L5EDR4ou0y/zFYP10pN3okieV1cA6tDWF+yBI7hXncCUqJX76Lw4VGPlJxD3?=
 =?us-ascii?Q?ktUg/sBzaepEE0nYjH83E/9CLSdgturIE+/VKBjJVk0NDtI9f5s2o3X/D7GU?=
 =?us-ascii?Q?uQdNPN81jVOpfdGmsfdJhXZ6gPC3bIAAo+X4Mz9lpqXM9Zv4aLRfOz9m7jaW?=
 =?us-ascii?Q?MoUOF2dHwS4rC1Q5U3sYjbNuDxyuQCXiMWcO43WQQy4L7o2cQBha/fJWdMVG?=
 =?us-ascii?Q?QSn4Y/Pv3qMlzj0gcjjyKjRxUdaCjemGjofyUgiWDc/eQwU/o5Rt4c5r0jQI?=
 =?us-ascii?Q?WxCcF2m4xp0RS13n2emhzZ+HFTLcEYMtJxSielwSG1K+mYZj2O99b4TDvEx7?=
 =?us-ascii?Q?QZB4MVkEH0Ymze4cSPNf8Yvkb4lj+dsDTu8bPlVrm0BCbOC9ltUDwFqUKj3k?=
 =?us-ascii?Q?HLXumskVoI3DzC2J4JroMijfMngRZqSSQ7T/6nrhmLL1rM5XpCK32S6XPUvC?=
 =?us-ascii?Q?/1ApJO5j1Tv44a2xIfuppABP2yMWrYmf+Rz+gRWhLESWCDYyZ0OrMu6pjL/p?=
 =?us-ascii?Q?olE8yT6CbKbq/TkZFixaDKR/4l+G5gJcwQka0WXxUe4IQos4vSrZU1Rtecyb?=
 =?us-ascii?Q?n5+Ps6d4qlGI2BaYAIMGNUFO7WwnJdqxUrUqtubzwCs2jYHnhCjTzcYQo/5O?=
 =?us-ascii?Q?NApkkNoIQX+4RQY60hm7R9XtwdhNbxCi4lSVbg3dAZYYqtixlz4Gly53m6rB?=
 =?us-ascii?Q?wYGGOBVUR4pkYtJdeM/nPKxte1YwGDhkTeZmnDba9e0RjZ9+XagauZRv97Qz?=
 =?us-ascii?Q?oPD8TgeB/V8GT/Ahn5r+tz5UzaQqNbsmPIuhB+/BKRer4MZDNlDlmUHIjiVC?=
 =?us-ascii?Q?oADz9FBqBY2loKVnZ4mqIf08xYW9fLSkfKzE4nu4kckcPylemiAdoiJ5C9s6?=
 =?us-ascii?Q?8fHvK5kmhUBzUIFpFk9KagHTdIM6e0MHz8UAI0MK426VCuINuk0TcP+9fouI?=
 =?us-ascii?Q?5rfaDUChAj3bz/8XkdUa80AHEBgflF3eYPIw1MJnvONNeQomRrDguhnPbMzL?=
 =?us-ascii?Q?3021Oz+0sWG8CBsAcIlRwtlxDWvU2aqJI407ypbbphzRNW3exJmGk2YL75zT?=
 =?us-ascii?Q?VwTIGMiMWgPYFBRW7SLxkQFvZ5f/n/K9DhxONk/VQIl1klgbS7jv2Y958ejn?=
 =?us-ascii?Q?/zwEQLSjYa0WCXHpx84HW78fRXowT1Ey4uNWS+X68Og6kmYjEWK6Yz9/YKPH?=
 =?us-ascii?Q?qHnGr5djQ/pWGMJ3V0HDRELILwyEGj066giBN+JMRqoCi5lUoz/JHYbLCt5k?=
 =?us-ascii?Q?VW30stjSWRS6/seZduCWt+Lf0ocQ5ldd6ZYFo2ZaUnBQ8CO7q/RWFiAOdzB1?=
 =?us-ascii?Q?8BgTchopod7lc8iwe0Qs1Cct0wGtlNNih/+h9G7ZN4gVrvgn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cb5bc6-c0a0-4658-e268-08df3c4f26aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 21:44:35.8478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuIcFsbFw17hPXKJV7l9nPfaZJU0D/dM+Mrcg0APhU1S7g468FrgIkQkTlXcsMraIJr+pqZ9DUOCskrn5TTRrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9534
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: Cornwall, Jay <Jay.Cornwall@amd.com>
> Sent: 06 November 2026 21:30
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Six, Lancelot
> <Lancelot.Six@amd.com>; Indic, Vladimir <Vladimir.Indic@amd.com>
> Subject: [PATCH] drm/amdkfd: gfx12.1 trap handler LDS store ack
> workaround
>
> DS_STORE_B32 does not serialize correctly with S_WAIT_IDLE.
> Use a LDS no-op atomic to enforce serialization.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>

Hi,

This looks reasonable to me.  Thanks.

Best,
Lancelot.

Reviewed-by: Lancelot Six <lancelot.six@amd.com]>

> ---
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 656 +++++++++---------
>  .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  11 +
>  2 files changed, 343 insertions(+), 324 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 5d468460f532..0e7bcfa487ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -5098,17 +5098,17 @@ static const uint32_t
> cwsr_trap_gfx12_1_0_rev_0_hex[] =3D {
>       0x018c0000, 0x00030000,
>       0x807d847d, 0x8070ff70,
>       0x00000400, 0xbf0a7b7d,
> -     0xbfa2ffe9, 0xbfa00184,
> +     0xbfa2ffe9, 0xbfa0018b,
>       0xbef4007e, 0x8b75ff7f,
>       0x01ffffff, 0xbef1007f,
>       0xb8f20742, 0x84729972,
>       0x8b6eff7f, 0x04000000,
> -     0xbfa10044, 0xbefe00c1,
> +     0xbfa1004b, 0xbefe00c1,
>       0x857d9972, 0x8b7d817d,
>       0xbf06817d, 0xbfa20002,
>       0xbeff0080, 0xbfa00001,
>       0xbeff00c1, 0xb8ef4306,
> -     0x8b6fc16f, 0xbfa10039,
> +     0x8b6fc16f, 0xbfa10040,
>       0x846f8a6f, 0xb8f83b05,
>       0x80788178, 0xbf0d9972,
>       0xbfa20002, 0x84788978,
> @@ -5119,7 +5119,7 @@ static const uint32_t
> cwsr_trap_gfx12_1_0_rev_0_hex[] =3D {
>       0xbf06817d, 0xbefd0080,
>       0xd71f0001, 0x000100c1,
>       0xd7200001, 0x000202c1,
> -     0x30020282, 0xbfa20012,
> +     0x30020282, 0xbfa20019,
>       0x80767874, 0x82778075,
>       0xee0a0076, 0x000c0000,
>       0x00000000, 0xbf8a0000,
> @@ -5128,178 +5128,182 @@ static const uint32_t
> cwsr_trap_gfx12_1_0_rev_0_hex[] =3D {
>       0x00000080, 0x807dff7d,
>       0x00000080, 0x8078ff78,
>       0x00000080, 0xbf0a6f7d,
> -     0xbfa2ffef, 0xbfa00011,
> -     0x80767874, 0x82778075,
> -     0xee0a0076, 0x000c0000,
> -     0x00000000, 0xbf8a0000,
> -     0xd8340000, 0x00000001,
> -     0xd5250001, 0x0001ff01,
> -     0x00000100, 0x807dff7d,
> -     0x00000100, 0x8078ff78,
> -     0x00000100, 0xbf0a6f7d,
> -     0xbfa2ffef, 0xbef80080,
> -     0xbefe00c1, 0x857d9972,
> -     0x8b7d817d, 0xbf06817d,
> -     0xbfa20002, 0xbeff0080,
> -     0xbfa00001, 0xbeff00c1,
> -     0xb8ef3b05, 0x806f816f,
> -     0x846f826f, 0x857d9972,
> -     0x8b7d817d, 0xbf06817d,
> -     0xbfa2002c, 0xbeee0078,
> -     0x8078ff78, 0x00000200,
> -     0xbefd0084, 0x80767874,
> -     0x82778075, 0xee0a0076,
> -     0x000c0000, 0x00000000,
> -     0xee0a0076, 0x000c0001,
> -     0x00008000, 0xee0a0076,
> -     0x000c0002, 0x00010000,
> -     0xee0a0076, 0x000c0003,
> -     0x00018000, 0xbf8a0000,
> -     0x7e008500, 0x7e028501,
> -     0x7e048502, 0x7e068503,
> -     0x807d847d, 0x8078ff78,
> -     0x00000200, 0xbf0a6f7d,
> -     0xbfa2ffe8, 0x80766e74,
> -     0x82778075, 0xee0a0076,
> -     0x000c0000, 0x00000000,
> -     0xee0a0076, 0x000c0001,
> -     0x00008000, 0xee0a0076,
> -     0x000c0002, 0x00010000,
> -     0xee0a0076, 0x000c0003,
> -     0x00018000, 0xbf8a0000,
> -     0xbfa0002d, 0xbeee0078,
> -     0x8078ff78, 0x00000400,
> -     0xbefd0084, 0xbf0a6f7d,
> -     0xbfa10018, 0x80767874,
> +     0xbfa2ffef, 0x7e000280,
> +     0x7e020280, 0xbefe00bf,
> +     0xd8280000, 0x00000001,
> +     0xbefe00c1, 0xbfc60000,
> +     0xbfa00011, 0x80767874,
>       0x82778075, 0xee0a0076,
>       0x000c0000, 0x00000000,
> -     0xee0a0076, 0x000c0001,
> +     0xbf8a0000, 0xd8340000,
> +     0x00000001, 0xd5250001,
> +     0x0001ff01, 0x00000100,
> +     0x807dff7d, 0x00000100,
> +     0x8078ff78, 0x00000100,
> +     0xbf0a6f7d, 0xbfa2ffef,
> +     0xbef80080, 0xbefe00c1,
> +     0x857d9972, 0x8b7d817d,
> +     0xbf06817d, 0xbfa20002,
> +     0xbeff0080, 0xbfa00001,
> +     0xbeff00c1, 0xb8ef3b05,
> +     0x806f816f, 0x846f826f,
> +     0x857d9972, 0x8b7d817d,
> +     0xbf06817d, 0xbfa2002c,
> +     0xbeee0078, 0x8078ff78,
> +     0x00000200, 0xbefd0084,
> +     0x80767874, 0x82778075,
> +     0xee0a0076, 0x000c0000,
> +     0x00000000, 0xee0a0076,
> +     0x000c0001, 0x00008000,
> +     0xee0a0076, 0x000c0002,
>       0x00010000, 0xee0a0076,
> -     0x000c0002, 0x00020000,
> -     0xee0a0076, 0x000c0003,
> -     0x00030000, 0xbf8a0000,
> -     0x7e008500, 0x7e028501,
> -     0x7e048502, 0x7e068503,
> -     0x807d847d, 0x8078ff78,
> -     0x00000400, 0xbf0a6f7d,
> -     0xbfa2ffe8, 0x80766e74,
> -     0x82778075, 0xee0a0076,
> -     0x000c0000, 0x00000000,
> -     0xee0a0076, 0x000c0001,
> +     0x000c0003, 0x00018000,
> +     0xbf8a0000, 0x7e008500,
> +     0x7e028501, 0x7e048502,
> +     0x7e068503, 0x807d847d,
> +     0x8078ff78, 0x00000200,
> +     0xbf0a6f7d, 0xbfa2ffe8,
> +     0x80766e74, 0x82778075,
> +     0xee0a0076, 0x000c0000,
> +     0x00000000, 0xee0a0076,
> +     0x000c0001, 0x00008000,
> +     0xee0a0076, 0x000c0002,
>       0x00010000, 0xee0a0076,
> -     0x000c0002, 0x00020000,
> -     0xee0a0076, 0x000c0003,
> -     0x00030000, 0xbf8a0000,
> -     0xb8f83b05, 0x80788178,
> -     0xbf0d9972, 0xbfa20002,
> -     0x84788978, 0xbfa00001,
> -     0x84788a78, 0x8078ff78,
> -     0x00000200, 0x80f8ff78,
> -     0x00000060, 0x80767874,
> -     0x82778075, 0xbefd00ff,
> -     0x0000006c, 0xf460403b,
> -     0xf8000000, 0xbf8a0000,
> -     0x80fd847d, 0xbf800000,
> -     0xbe804300, 0xbe824302,
> -     0x80f6a076, 0x82f78077,
> -     0xf460603b, 0xf8000000,
> -     0xbf8a0000, 0x80fd887d,
> +     0x000c0003, 0x00018000,
> +     0xbf8a0000, 0xbfa0002d,
> +     0xbeee0078, 0x8078ff78,
> +     0x00000400, 0xbefd0084,
> +     0xbf0a6f7d, 0xbfa10018,
> +     0x80767874, 0x82778075,
> +     0xee0a0076, 0x000c0000,
> +     0x00000000, 0xee0a0076,
> +     0x000c0001, 0x00010000,
> +     0xee0a0076, 0x000c0002,
> +     0x00020000, 0xee0a0076,
> +     0x000c0003, 0x00030000,
> +     0xbf8a0000, 0x7e008500,
> +     0x7e028501, 0x7e048502,
> +     0x7e068503, 0x807d847d,
> +     0x8078ff78, 0x00000400,
> +     0xbf0a6f7d, 0xbfa2ffe8,
> +     0x80766e74, 0x82778075,
> +     0xee0a0076, 0x000c0000,
> +     0x00000000, 0xee0a0076,
> +     0x000c0001, 0x00010000,
> +     0xee0a0076, 0x000c0002,
> +     0x00020000, 0xee0a0076,
> +     0x000c0003, 0x00030000,
> +     0xbf8a0000, 0xb8f83b05,
> +     0x80788178, 0xbf0d9972,
> +     0xbfa20002, 0x84788978,
> +     0xbfa00001, 0x84788a78,
> +     0x8078ff78, 0x00000200,
> +     0x80f8ff78, 0x00000060,
> +     0x80767874, 0x82778075,
> +     0xbefd00ff, 0x0000006c,
> +     0xf460403b, 0xf8000000,
> +     0xbf8a0000, 0x80fd847d,
>       0xbf800000, 0xbe804300,
> -     0xbe824302, 0xbe844304,
> -     0xbe864306, 0x80f6c076,
> -     0x82f78077, 0xf460803b,
> +     0xbe824302, 0x80f6a076,
> +     0x82f78077, 0xf460603b,
>       0xf8000000, 0xbf8a0000,
> -     0x80fd907d, 0xbf800000,
> +     0x80fd887d, 0xbf800000,
>       0xbe804300, 0xbe824302,
>       0xbe844304, 0xbe864306,
> -     0xbe884308, 0xbe8a430a,
> -     0xbe8c430c, 0xbe8e430e,
> -     0xbf06807d, 0xbfa1ffef,
> -     0xb980f801, 0x00000000,
> -     0xb8f83b05, 0x80788178,
> -     0xbf0d9972, 0xbfa20002,
> -     0x84788978, 0xbfa00001,
> -     0x84788a78, 0x8078ff78,
> -     0x00000200, 0x80767874,
> -     0x82778075, 0xbeff0071,
> -     0xf4601bfb, 0xf8000000,
> -     0xf4601b3b, 0xf8000004,
> -     0xf4601b7b, 0xf8000008,
> -     0xf4601c3b, 0xf800000c,
> -     0xf4601c7b, 0xf8000010,
> -     0xf4601ebb, 0xf8000014,
> -     0xf4601efb, 0xf8000018,
> -     0xf4601e7b, 0xf800001c,
> -     0xf4601cfb, 0xf8000020,
> -     0xf4601bbb, 0xf8000024,
> -     0xbf8a0000, 0xb96ef814,
> -     0xf4601bbb, 0xf8000028,
> -     0xbf8a0000, 0xb96ef815,
> -     0xf4601bbb, 0xf800002c,
> -     0xbf8a0000, 0xb96ef812,
> -     0xf4601bbb, 0xf8000030,
> -     0xbf8a0000, 0xb96ef813,
> -     0x8b6eff7f, 0x04000000,
> -     0xbfa10022, 0xf4601bbb,
> -     0xf8000038, 0xbf8a0000,
> -     0xbf0d806e, 0xbfa1001d,
> -     0x856e906e, 0x8b6e6e6e,
> -     0xbfa10003, 0xbe804ec1,
> -     0x816ec16e, 0xbfa0fffb,
> -     0xbef800ff, 0x00000080,
> -     0xbefd0081, 0xf4601bbb,
> -     0xf0000000, 0xbfc70000,
> -     0x80788478, 0x937eff6e,
> -     0x00070004, 0x847e907e,
> -     0x8c7d7e7d, 0xbe80517d,
> -     0x917dff7d, 0x007f0000,
> -     0x856e906e, 0x8b6e6e6e,
> -     0xbfa10003, 0xbe804e7d,
> -     0x816ec16e, 0xbfa0fffb,
> -     0x807d817d, 0xbf08907d,
> -     0xbfa1ffec, 0xf4601bbb,
> -     0xf800003c, 0xbfc70000,
> -     0xbf0d806e, 0xbfa1000c,
> -     0xbf0d9a7f, 0xbfa10002,
> -     0xbf068180, 0xbe804fc4,
> -     0xbf94fffc, 0xbfa10006,
> -     0x856e906e, 0x8b6e6e6e,
> -     0xbfa10003, 0xbe804ec3,
> -     0x816ec16e, 0xbfa0fffb,
> -     0xf4601bbb, 0xf8000040,
> -     0xbfc70000, 0xb96ef81a,
> -     0xbefd006f, 0xbefe0070,
> -     0xbeff0071, 0xb979f822,
> -     0xb97b2011, 0x857b867b,
> -     0xb97b0191, 0x857b827b,
> -     0xb97bba11, 0xb973f801,
> -     0xb8ee3b05, 0x806e816e,
> -     0xbf0d9972, 0xbfa20002,
> -     0x846e896e, 0xbfa00001,
> -     0x846e8a6e, 0x806eff6e,
> -     0x000001c0, 0x806e746e,
> -     0x826f8075, 0xf4605c37,
> -     0xf8000010, 0xf4605d37,
> -     0xf8000020, 0xf4601e77,
> -     0xf8000034, 0xbf8a0000,
> -     0x856e9677, 0xb96e04a1,
> -     0x856e9577, 0xb96e0421,
> -     0x856e8e77, 0xb96e3021,
> -     0x8b6dff6d, 0x01ffffff,
> -     0x8bfe7e7e, 0x8bea6a6a,
> -     0xb97af804, 0xb8eef802,
> -     0xbf0c8b6e, 0xbfa20003,
> -     0xbe804fc2, 0xbf94fffe,
> -     0xbfa10001, 0xbe804ec4,
> -     0xbf94fffc, 0x857a897a,
> -     0xb97a0244, 0xbe804a6c,
> +     0x80f6c076, 0x82f78077,
> +     0xf460803b, 0xf8000000,
> +     0xbf8a0000, 0x80fd907d,
> +     0xbf800000, 0xbe804300,
> +     0xbe824302, 0xbe844304,
> +     0xbe864306, 0xbe884308,
> +     0xbe8a430a, 0xbe8c430c,
> +     0xbe8e430e, 0xbf06807d,
> +     0xbfa1ffef, 0xb980f801,
> +     0x00000000, 0xb8f83b05,
> +     0x80788178, 0xbf0d9972,
> +     0xbfa20002, 0x84788978,
> +     0xbfa00001, 0x84788a78,
> +     0x8078ff78, 0x00000200,
> +     0x80767874, 0x82778075,
> +     0xbeff0071, 0xf4601bfb,
> +     0xf8000000, 0xf4601b3b,
> +     0xf8000004, 0xf4601b7b,
> +     0xf8000008, 0xf4601c3b,
> +     0xf800000c, 0xf4601c7b,
> +     0xf8000010, 0xf4601ebb,
> +     0xf8000014, 0xf4601efb,
> +     0xf8000018, 0xf4601e7b,
> +     0xf800001c, 0xf4601cfb,
> +     0xf8000020, 0xf4601bbb,
> +     0xf8000024, 0xbf8a0000,
> +     0xb96ef814, 0xf4601bbb,
> +     0xf8000028, 0xbf8a0000,
> +     0xb96ef815, 0xf4601bbb,
> +     0xf800002c, 0xbf8a0000,
> +     0xb96ef812, 0xf4601bbb,
> +     0xf8000030, 0xbf8a0000,
> +     0xb96ef813, 0x8b6eff7f,
> +     0x04000000, 0xbfa10022,
> +     0xf4601bbb, 0xf8000038,
> +     0xbf8a0000, 0xbf0d806e,
> +     0xbfa1001d, 0x856e906e,
> +     0x8b6e6e6e, 0xbfa10003,
> +     0xbe804ec1, 0x816ec16e,
> +     0xbfa0fffb, 0xbef800ff,
> +     0x00000080, 0xbefd0081,
> +     0xf4601bbb, 0xf0000000,
> +     0xbfc70000, 0x80788478,
> +     0x937eff6e, 0x00070004,
> +     0x847e907e, 0x8c7d7e7d,
> +     0xbe80517d, 0x917dff7d,
> +     0x007f0000, 0x856e906e,
> +     0x8b6e6e6e, 0xbfa10003,
> +     0xbe804e7d, 0x816ec16e,
> +     0xbfa0fffb, 0x807d817d,
> +     0xbf08907d, 0xbfa1ffec,
> +     0xf4601bbb, 0xf800003c,
> +     0xbfc70000, 0xbf0d806e,
> +     0xbfa1000c, 0xbf0d9a7f,
> +     0xbfa10002, 0xbf068180,
> +     0xbe804fc4, 0xbf94fffc,
> +     0xbfa10006, 0x856e906e,
> +     0x8b6e6e6e, 0xbfa10003,
> +     0xbe804ec3, 0x816ec16e,
> +     0xbfa0fffb, 0xf4601bbb,
> +     0xf8000040, 0xbfc70000,
> +     0xb96ef81a, 0xbefd006f,
> +     0xbefe0070, 0xbeff0071,
> +     0xb979f822, 0xb97b2011,
> +     0x857b867b, 0xb97b0191,
> +     0x857b827b, 0xb97bba11,
> +     0xb973f801, 0xb8ee3b05,
> +     0x806e816e, 0xbf0d9972,
> +     0xbfa20002, 0x846e896e,
> +     0xbfa00001, 0x846e8a6e,
> +     0x806eff6e, 0x000001c0,
> +     0x806e746e, 0x826f8075,
> +     0xf4605c37, 0xf8000010,
> +     0xf4605d37, 0xf8000020,
> +     0xf4601e77, 0xf8000034,
> +     0xbf8a0000, 0x856e9677,
> +     0xb96e04a1, 0x856e9577,
> +     0xb96e0421, 0x856e8e77,
> +     0xb96e3021, 0x8b6dff6d,
> +     0x01ffffff, 0x8bfe7e7e,
> +     0x8bea6a6a, 0xb97af804,
>       0xb8eef802, 0xbf0c8b6e,
>       0xbfa20003, 0xbe804fc2,
>       0xbf94fffe, 0xbfa10001,
>       0xbe804ec4, 0xbf94fffc,
> -     0xbfb10000, 0xbf9f0000,
> +     0x857a897a, 0xb97a0244,
> +     0xbe804a6c, 0xb8eef802,
> +     0xbf0c8b6e, 0xbfa20003,
> +     0xbe804fc2, 0xbf94fffe,
> +     0xbfa10001, 0xbe804ec4,
> +     0xbf94fffc, 0xbfb10000,
>       0xbf9f0000, 0xbf9f0000,
>       0xbf9f0000, 0xbf9f0000,
> +     0xbf9f0000, 0x00000000,
>  };
>
>  static const uint32_t cwsr_trap_gfx12_1_0_rev_1_hex[] =3D {
> @@ -5791,17 +5795,17 @@ static const uint32_t
> cwsr_trap_gfx12_1_0_rev_1_hex[] =3D {
>       0x018c0000, 0x00030000,
>       0x807d847d, 0x8070ff70,
>       0x00000400, 0xbf0a7b7d,
> -     0xbfa2ffe9, 0xbfa00184,
> +     0xbfa2ffe9, 0xbfa0018b,
>       0xbef4007e, 0x8b75ff7f,
>       0x01ffffff, 0xbef1007f,
>       0xb8f20742, 0x84729972,
>       0x8b6eff7f, 0x04000000,
> -     0xbfa10044, 0xbefe00c1,
> +     0xbfa1004b, 0xbefe00c1,
>       0x857d9972, 0x8b7d817d,
>       0xbf06817d, 0xbfa20002,
>       0xbeff0080, 0xbfa00001,
>       0xbeff00c1, 0xb8ef4306,
> -     0x8b6fc16f, 0xbfa10039,
> +     0x8b6fc16f, 0xbfa10040,
>       0x846f8a6f, 0xb8f83b05,
>       0x80788178, 0xbf0d9972,
>       0xbfa20002, 0x84788978,
> @@ -5812,7 +5816,7 @@ static const uint32_t
> cwsr_trap_gfx12_1_0_rev_1_hex[] =3D {
>       0xbf06817d, 0xbefd0080,
>       0xd71f0001, 0x000100c1,
>       0xd7200001, 0x000202c1,
> -     0x30020282, 0xbfa20012,
> +     0x30020282, 0xbfa20019,
>       0x80767874, 0x82778075,
>       0xee0a0076, 0x000c0000,
>       0x00000000, 0xbf8a0000,
> @@ -5821,176 +5825,180 @@ static const uint32_t
> cwsr_trap_gfx12_1_0_rev_1_hex[] =3D {
>       0x00000080, 0x807dff7d,
>       0x00000080, 0x8078ff78,
>       0x00000080, 0xbf0a6f7d,
> -     0xbfa2ffef, 0xbfa00011,
> -     0x80767874, 0x82778075,
> -     0xee0a0076, 0x000c0000,
> -     0x00000000, 0xbf8a0000,
> -     0xd8340000, 0x00000001,
> -     0xd5250001, 0x0001ff01,
> -     0x00000100, 0x807dff7d,
> -     0x00000100, 0x8078ff78,
> -     0x00000100, 0xbf0a6f7d,
> -     0xbfa2ffef, 0xbef80080,
> -     0xbefe00c1, 0x857d9972,
> -     0x8b7d817d, 0xbf06817d,
> -     0xbfa20002, 0xbeff0080,
> -     0xbfa00001, 0xbeff00c1,
> -     0xb8ef3b05, 0x806f816f,
> -     0x846f826f, 0x857d9972,
> -     0x8b7d817d, 0xbf06817d,
> -     0xbfa2002c, 0xbeee0078,
> -     0x8078ff78, 0x00000200,
> -     0xbefd0084, 0x80767874,
> -     0x82778075, 0xee0a0076,
> -     0x000c0000, 0x00000000,
> -     0xee0a0076, 0x000c0001,
> -     0x00008000, 0xee0a0076,
> -     0x000c0002, 0x00010000,
> -     0xee0a0076, 0x000c0003,
> -     0x00018000, 0xbf8a0000,
> -     0x7e008500, 0x7e028501,
> -     0x7e048502, 0x7e068503,
> -     0x807d847d, 0x8078ff78,
> -     0x00000200, 0xbf0a6f7d,
> -     0xbfa2ffe8, 0x80766e74,
> -     0x82778075, 0xee0a0076,
> -     0x000c0000, 0x00000000,
> -     0xee0a0076, 0x000c0001,
> -     0x00008000, 0xee0a0076,
> -     0x000c0002, 0x00010000,
> -     0xee0a0076, 0x000c0003,
> -     0x00018000, 0xbf8a0000,
> -     0xbfa0002d, 0xbeee0078,
> -     0x8078ff78, 0x00000400,
> -     0xbefd0084, 0xbf0a6f7d,
> -     0xbfa10018, 0x80767874,
> +     0xbfa2ffef, 0x7e000280,
> +     0x7e020280, 0xbefe00bf,
> +     0xd8280000, 0x00000001,
> +     0xbefe00c1, 0xbfc60000,
> +     0xbfa00011, 0x80767874,
>       0x82778075, 0xee0a0076,
>       0x000c0000, 0x00000000,
> -     0xee0a0076, 0x000c0001,
> +     0xbf8a0000, 0xd8340000,
> +     0x00000001, 0xd5250001,
> +     0x0001ff01, 0x00000100,
> +     0x807dff7d, 0x00000100,
> +     0x8078ff78, 0x00000100,
> +     0xbf0a6f7d, 0xbfa2ffef,
> +     0xbef80080, 0xbefe00c1,
> +     0x857d9972, 0x8b7d817d,
> +     0xbf06817d, 0xbfa20002,
> +     0xbeff0080, 0xbfa00001,
> +     0xbeff00c1, 0xb8ef3b05,
> +     0x806f816f, 0x846f826f,
> +     0x857d9972, 0x8b7d817d,
> +     0xbf06817d, 0xbfa2002c,
> +     0xbeee0078, 0x8078ff78,
> +     0x00000200, 0xbefd0084,
> +     0x80767874, 0x82778075,
> +     0xee0a0076, 0x000c0000,
> +     0x00000000, 0xee0a0076,
> +     0x000c0001, 0x00008000,
> +     0xee0a0076, 0x000c0002,
>       0x00010000, 0xee0a0076,
> -     0x000c0002, 0x00020000,
> -     0xee0a0076, 0x000c0003,
> -     0x00030000, 0xbf8a0000,
> -     0x7e008500, 0x7e028501,
> -     0x7e048502, 0x7e068503,
> -     0x807d847d, 0x8078ff78,
> -     0x00000400, 0xbf0a6f7d,
> -     0xbfa2ffe8, 0x80766e74,
> -     0x82778075, 0xee0a0076,
> -     0x000c0000, 0x00000000,
> -     0xee0a0076, 0x000c0001,
> +     0x000c0003, 0x00018000,
> +     0xbf8a0000, 0x7e008500,
> +     0x7e028501, 0x7e048502,
> +     0x7e068503, 0x807d847d,
> +     0x8078ff78, 0x00000200,
> +     0xbf0a6f7d, 0xbfa2ffe8,
> +     0x80766e74, 0x82778075,
> +     0xee0a0076, 0x000c0000,
> +     0x00000000, 0xee0a0076,
> +     0x000c0001, 0x00008000,
> +     0xee0a0076, 0x000c0002,
>       0x00010000, 0xee0a0076,
> -     0x000c0002, 0x00020000,
> -     0xee0a0076, 0x000c0003,
> -     0x00030000, 0xbf8a0000,
> -     0xb8f83b05, 0x80788178,
> -     0xbf0d9972, 0xbfa20002,
> -     0x84788978, 0xbfa00001,
> -     0x84788a78, 0x8078ff78,
> -     0x00000200, 0x80f8ff78,
> -     0x00000060, 0x80767874,
> -     0x82778075, 0xbefd00ff,
> -     0x0000006c, 0xf460403b,
> -     0xf8000000, 0xbf8a0000,
> -     0x80fd847d, 0xbf800000,
> -     0xbe804300, 0xbe824302,
> -     0x80f6a076, 0x82f78077,
> -     0xf460603b, 0xf8000000,
> -     0xbf8a0000, 0x80fd887d,
> +     0x000c0003, 0x00018000,
> +     0xbf8a0000, 0xbfa0002d,
> +     0xbeee0078, 0x8078ff78,
> +     0x00000400, 0xbefd0084,
> +     0xbf0a6f7d, 0xbfa10018,
> +     0x80767874, 0x82778075,
> +     0xee0a0076, 0x000c0000,
> +     0x00000000, 0xee0a0076,
> +     0x000c0001, 0x00010000,
> +     0xee0a0076, 0x000c0002,
> +     0x00020000, 0xee0a0076,
> +     0x000c0003, 0x00030000,
> +     0xbf8a0000, 0x7e008500,
> +     0x7e028501, 0x7e048502,
> +     0x7e068503, 0x807d847d,
> +     0x8078ff78, 0x00000400,
> +     0xbf0a6f7d, 0xbfa2ffe8,
> +     0x80766e74, 0x82778075,
> +     0xee0a0076, 0x000c0000,
> +     0x00000000, 0xee0a0076,
> +     0x000c0001, 0x00010000,
> +     0xee0a0076, 0x000c0002,
> +     0x00020000, 0xee0a0076,
> +     0x000c0003, 0x00030000,
> +     0xbf8a0000, 0xb8f83b05,
> +     0x80788178, 0xbf0d9972,
> +     0xbfa20002, 0x84788978,
> +     0xbfa00001, 0x84788a78,
> +     0x8078ff78, 0x00000200,
> +     0x80f8ff78, 0x00000060,
> +     0x80767874, 0x82778075,
> +     0xbefd00ff, 0x0000006c,
> +     0xf460403b, 0xf8000000,
> +     0xbf8a0000, 0x80fd847d,
>       0xbf800000, 0xbe804300,
> -     0xbe824302, 0xbe844304,
> -     0xbe864306, 0x80f6c076,
> -     0x82f78077, 0xf460803b,
> +     0xbe824302, 0x80f6a076,
> +     0x82f78077, 0xf460603b,
>       0xf8000000, 0xbf8a0000,
> -     0x80fd907d, 0xbf800000,
> +     0x80fd887d, 0xbf800000,
>       0xbe804300, 0xbe824302,
>       0xbe844304, 0xbe864306,
> -     0xbe884308, 0xbe8a430a,
> -     0xbe8c430c, 0xbe8e430e,
> -     0xbf06807d, 0xbfa1ffef,
> -     0xb980f801, 0x00000000,
> -     0xb8f83b05, 0x80788178,
> -     0xbf0d9972, 0xbfa20002,
> -     0x84788978, 0xbfa00001,
> -     0x84788a78, 0x8078ff78,
> -     0x00000200, 0x80767874,
> -     0x82778075, 0xbeff0071,
> -     0xf4601bfb, 0xf8000000,
> -     0xf4601b3b, 0xf8000004,
> -     0xf4601b7b, 0xf8000008,
> -     0xf4601c3b, 0xf800000c,
> -     0xf4601c7b, 0xf8000010,
> -     0xf4601ebb, 0xf8000014,
> -     0xf4601efb, 0xf8000018,
> -     0xf4601e7b, 0xf800001c,
> -     0xf4601cfb, 0xf8000020,
> -     0xf4601bbb, 0xf8000024,
> -     0xbf8a0000, 0xb96ef814,
> -     0xf4601bbb, 0xf8000028,
> -     0xbf8a0000, 0xb96ef815,
> -     0xf4601bbb, 0xf800002c,
> -     0xbf8a0000, 0xb96ef812,
> -     0xf4601bbb, 0xf8000030,
> -     0xbf8a0000, 0xb96ef813,
> -     0x8b6eff7f, 0x04000000,
> -     0xbfa10022, 0xf4601bbb,
> -     0xf8000038, 0xbf8a0000,
> -     0xbf0d806e, 0xbfa1001d,
> -     0x856e906e, 0x8b6e6e6e,
> -     0xbfa10003, 0xbe804ec1,
> -     0x816ec16e, 0xbfa0fffb,
> -     0xbef800ff, 0x00000080,
> -     0xbefd0081, 0xf4601bbb,
> -     0xf0000000, 0xbfc70000,
> -     0x80788478, 0x937eff6e,
> -     0x00070004, 0x847e907e,
> -     0x8c7d7e7d, 0xbe80517d,
> -     0x917dff7d, 0x007f0000,
> -     0x856e906e, 0x8b6e6e6e,
> -     0xbfa10003, 0xbe804e7d,
> -     0x816ec16e, 0xbfa0fffb,
> -     0x807d817d, 0xbf08907d,
> -     0xbfa1ffec, 0xf4601bbb,
> -     0xf800003c, 0xbfc70000,
> -     0xbf0d806e, 0xbfa1000c,
> -     0xbf0d9a7f, 0xbfa10002,
> -     0xbf068180, 0xbe804fc4,
> -     0xbf94fffc, 0xbfa10006,
> -     0x856e906e, 0x8b6e6e6e,
> -     0xbfa10003, 0xbe804ec3,
> -     0x816ec16e, 0xbfa0fffb,
> -     0xf4601bbb, 0xf8000040,
> -     0xbfc70000, 0xb96ef81a,
> -     0xbefd006f, 0xbefe0070,
> -     0xbeff0071, 0xb979f822,
> -     0xb97b2011, 0x857b867b,
> -     0xb97b0191, 0x857b827b,
> -     0xb97bba11, 0xb973f801,
> -     0xb8ee3b05, 0x806e816e,
> -     0xbf0d9972, 0xbfa20002,
> -     0x846e896e, 0xbfa00001,
> -     0x846e8a6e, 0x806eff6e,
> -     0x000001c0, 0x806e746e,
> -     0x826f8075, 0xf4605c37,
> -     0xf8000010, 0xf4605d37,
> -     0xf8000020, 0xf4601e77,
> -     0xf8000034, 0xbf8a0000,
> -     0x856e9677, 0xb96e04a1,
> -     0x856e9577, 0xb96e0421,
> -     0x856e8e77, 0xb96e3021,
> -     0x8b6dff6d, 0x01ffffff,
> -     0x8bfe7e7e, 0x8bea6a6a,
> -     0xb97af804, 0xb8eef802,
> -     0xbf0c8b6e, 0xbfa20003,
> -     0xbe804fc2, 0xbf94fffe,
> -     0xbfa10001, 0xbe804ec4,
> -     0xbf94fffc, 0x857a897a,
> -     0xb97a0244, 0xbe804a6c,
> +     0x80f6c076, 0x82f78077,
> +     0xf460803b, 0xf8000000,
> +     0xbf8a0000, 0x80fd907d,
> +     0xbf800000, 0xbe804300,
> +     0xbe824302, 0xbe844304,
> +     0xbe864306, 0xbe884308,
> +     0xbe8a430a, 0xbe8c430c,
> +     0xbe8e430e, 0xbf06807d,
> +     0xbfa1ffef, 0xb980f801,
> +     0x00000000, 0xb8f83b05,
> +     0x80788178, 0xbf0d9972,
> +     0xbfa20002, 0x84788978,
> +     0xbfa00001, 0x84788a78,
> +     0x8078ff78, 0x00000200,
> +     0x80767874, 0x82778075,
> +     0xbeff0071, 0xf4601bfb,
> +     0xf8000000, 0xf4601b3b,
> +     0xf8000004, 0xf4601b7b,
> +     0xf8000008, 0xf4601c3b,
> +     0xf800000c, 0xf4601c7b,
> +     0xf8000010, 0xf4601ebb,
> +     0xf8000014, 0xf4601efb,
> +     0xf8000018, 0xf4601e7b,
> +     0xf800001c, 0xf4601cfb,
> +     0xf8000020, 0xf4601bbb,
> +     0xf8000024, 0xbf8a0000,
> +     0xb96ef814, 0xf4601bbb,
> +     0xf8000028, 0xbf8a0000,
> +     0xb96ef815, 0xf4601bbb,
> +     0xf800002c, 0xbf8a0000,
> +     0xb96ef812, 0xf4601bbb,
> +     0xf8000030, 0xbf8a0000,
> +     0xb96ef813, 0x8b6eff7f,
> +     0x04000000, 0xbfa10022,
> +     0xf4601bbb, 0xf8000038,
> +     0xbf8a0000, 0xbf0d806e,
> +     0xbfa1001d, 0x856e906e,
> +     0x8b6e6e6e, 0xbfa10003,
> +     0xbe804ec1, 0x816ec16e,
> +     0xbfa0fffb, 0xbef800ff,
> +     0x00000080, 0xbefd0081,
> +     0xf4601bbb, 0xf0000000,
> +     0xbfc70000, 0x80788478,
> +     0x937eff6e, 0x00070004,
> +     0x847e907e, 0x8c7d7e7d,
> +     0xbe80517d, 0x917dff7d,
> +     0x007f0000, 0x856e906e,
> +     0x8b6e6e6e, 0xbfa10003,
> +     0xbe804e7d, 0x816ec16e,
> +     0xbfa0fffb, 0x807d817d,
> +     0xbf08907d, 0xbfa1ffec,
> +     0xf4601bbb, 0xf800003c,
> +     0xbfc70000, 0xbf0d806e,
> +     0xbfa1000c, 0xbf0d9a7f,
> +     0xbfa10002, 0xbf068180,
> +     0xbe804fc4, 0xbf94fffc,
> +     0xbfa10006, 0x856e906e,
> +     0x8b6e6e6e, 0xbfa10003,
> +     0xbe804ec3, 0x816ec16e,
> +     0xbfa0fffb, 0xf4601bbb,
> +     0xf8000040, 0xbfc70000,
> +     0xb96ef81a, 0xbefd006f,
> +     0xbefe0070, 0xbeff0071,
> +     0xb979f822, 0xb97b2011,
> +     0x857b867b, 0xb97b0191,
> +     0x857b827b, 0xb97bba11,
> +     0xb973f801, 0xb8ee3b05,
> +     0x806e816e, 0xbf0d9972,
> +     0xbfa20002, 0x846e896e,
> +     0xbfa00001, 0x846e8a6e,
> +     0x806eff6e, 0x000001c0,
> +     0x806e746e, 0x826f8075,
> +     0xf4605c37, 0xf8000010,
> +     0xf4605d37, 0xf8000020,
> +     0xf4601e77, 0xf8000034,
> +     0xbf8a0000, 0x856e9677,
> +     0xb96e04a1, 0x856e9577,
> +     0xb96e0421, 0x856e8e77,
> +     0xb96e3021, 0x8b6dff6d,
> +     0x01ffffff, 0x8bfe7e7e,
> +     0x8bea6a6a, 0xb97af804,
>       0xb8eef802, 0xbf0c8b6e,
>       0xbfa20003, 0xbe804fc2,
>       0xbf94fffe, 0xbfa10001,
>       0xbe804ec4, 0xbf94fffc,
> -     0xbfb10000, 0xbf9f0000,
> +     0x857a897a, 0xb97a0244,
> +     0xbe804a6c, 0xb8eef802,
> +     0xbf0c8b6e, 0xbfa20003,
> +     0xbe804fc2, 0xbf94fffe,
> +     0xbfa10001, 0xbe804ec4,
> +     0xbf94fffc, 0xbfb10000,
>       0xbf9f0000, 0xbf9f0000,
>       0xbf9f0000, 0xbf9f0000,
> +     0xbf9f0000, 0x00000000,
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index 1e248af0e9e9..89844d08f3ce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -48,6 +48,7 @@
>  #define WAVE32_ONLY (ASIC_FAMILY >=3D CHIP_GC_12_0_3_REV_0)
>  #define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >=3D
> CHIP_GC_12_0_3_REV_0)
>  #define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY >=3D
> CHIP_GC_12_0_3_REV_0)
> +#define HAVE_LDS_STORE_ACK_WA (ASIC_FAMILY >=3D
> CHIP_GC_12_0_3_REV_0)
>
>  #if HAVE_XNACK && !WAVE32_ONLY
>  # error
> @@ -1015,6 +1016,16 @@ L_RESTORE_LDS_LOOP_W32:
>       s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 128
>               //mem offset increased by 128DW
>       s_cmp_lt_u32    m0, s_restore_alloc_size
>       //scc=3D(m0 < s_restore_alloc_size) ? 1 : 0
>       s_cbranch_scc1  L_RESTORE_LDS_LOOP_W32
>               //LDS restore is complete?
> +
> +#if HAVE_LDS_STORE_ACK_WA
> +     v_mov_b32       v0, 0
> +     v_mov_b32       v1, 0
> +     s_mov_b32       exec_lo, 0x3F
> +     ds_or_b32       v1, v0
> +     s_mov_b32       exec_lo, -1
> +     s_wait_dscnt    0x0
> +#endif
> +
>       s_branch        L_RESTORE_VGPR
>
>  L_RESTORE_LDS_LOOP_W64:
> --
> 2.43.0

