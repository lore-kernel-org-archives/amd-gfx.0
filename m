Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA64CD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 11:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9D010E0C1;
	Mon, 18 May 2026 11:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZQJ7uDB";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF49410E0C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 11:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CM/fS2AAo9Q2ZSR0+5Occh4F38tWYeHa8I8MrFfEKrMuD4tUgGC9lBZHj3uavrc+iSwxKXnXEcMFKcAZkZl0sNp0wfQ3WFaxmtdIWnwWnGMaI7T0tKgdCoxyfVJHXFGGaSVJVK8vRUqszuJkfTTS6wG9ic2Jw1lRdVfg9uqZBJz2BHsl3jRLrKELZY2cu7bs3yeXdo6E8QJJsb2/tdTCnsCmmeEU2Qy4tknehGXGgPliqOrLEVgetmEYn2nVHscHlPmVgolLYmKptq1NDoHl2ZMRHOF75pEgl3YceKo1sRPEBZvD87Q0YI35Z+lsIW71pWfbAi27nTykNuJgg4/OLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elm6zQNp0yIbxMuaI/8ZQUgWLyOx+Bl6ulEullL1SKo=;
 b=Svj5P8uZfg05pngnQFPr+bkTkaUSL7SYngPOQ9789XZWNYp9Zo+VPL4mKPuqzCJBoEd3vwCV//Ra6r7qS4auR9ofl6l4UFRTNTUgJLUoIxkd/taxM0sf/Zo7WZPVxyg0yjzT7wtOaM18tdx3jKgrVEZD+VQuFFWfHchixF/clTSHpS1hz/tKHhu3VKmNb7N6QvgFRbl3Xt8RVCdgvHmVGuhpVRYv0qapVVWPwVU2YkmbvPp4HMA9CVPLu/iQ4RryHpL7j/mbRf1BmorFZpxRyB9xWRYSB0dbszyl6dYwcjaOvD7R7Hll+Y+XW30Bd8C3uULoT4XuRmELe/rO3UbuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elm6zQNp0yIbxMuaI/8ZQUgWLyOx+Bl6ulEullL1SKo=;
 b=YZQJ7uDBBN3IPytK1n92xriLjYGyeeX+yH2VLzu2G5dXy59+P6Ehsp6q3jsRLpHq06m2jHTLRqOymQLHKa6UftHyDFXQ1S7gZUPuHK8y/wu37yZ4iTu0EEFNTVsMIT7bVUg8k1nuAyM3TRpZcIIHOwAEAf1ZjwNaAIj0zI+Dx2E=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 11:52:00 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 11:51:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: return error when converting records to
 nps pages fails
Thread-Topic: [PATCH 3/3] drm/amd/ras: return error when converting records to
 nps pages fails
Thread-Index: AQHc5pFtNAwvWn+mWkux/YE3eVJMkbYTq9LQ
Date: Mon, 18 May 2026 11:51:59 +0000
Message-ID: <PH7PR12MB87968C198CFB0E3C5B94EE36B0032@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260518064053.2778626-1-ganglxie@amd.com>
 <20260518064053.2778626-3-ganglxie@amd.com>
In-Reply-To: <20260518064053.2778626-3-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T11:50:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB9221:EE_
x-ms-office365-filtering-correlation-id: fa712453-f05e-47aa-755f-08deb4d3de74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021|11063799003|4143699003;
x-microsoft-antispam-message-info: ewcyCMsWbf6U8EonjZ6qDAfAB6M9r1V1NEhs1TwOzSajZ3O104FHwE7dlsefVEEbJEBUrLrzFGuYXnMgLsOVXiDjepryODgBqyeAbbdMSZRJrNGzRPyS/eREPcVvVyv8m+/3/E9a4vKwucvKtnDBOt9IHtNxhr1c8Ff4k86+ZQgJL1FjsOMUQW62XiaQ70g8XgiKLXJ+iH8D7T2CldYOlUZs1nCHT8FDLNzqpUp+aOIBgppkM4f934o5zyaJVDLY+ELbRstx1aW1XNYdrMnUB/u/HKcV+iCLz5dbeJIe3fRQPqwU77PLJicSGTEIQLKko7zyuiRvlQI1mcOEPiMLV5vcSKcTk742zSlaVWjjPTjsKSgTd6k6G5skhXZ4ZcPqdCu1Dh0kEjduTFTA+byS5wLvG6tMvPpYPSQwhHrLlADgmust/h83Q8OOheTYBbDde1c9H9f8E52hOwNN2RdmfBlLS7jUER2+YJ8HKH5LIlkEaC+C5at/ab6MPOUEJazhOGkNbCUNsonH+5e3Llci97P2y6nAVZEn7poIbFUcJ1v/a83A7Gd1Wj7SK/iLTw1a87Ux3j9SR4/92Tb087vnaGP+uYTBOIkBQMmpL2fpkzlBhI7HGoWRYMQEggB5Nyub7Y6OBob2Ukk4tRMmJ3HdFCFh9Lle/rdK/l2NB4ROF2ApX4U2szcSg1Q7M6Y9TcXPKV0aft+w30T7bJRiyj8zxK/kX0Vu4XjStVL+QYOIJvb3IbTuH7juvtIJONIP4kM1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jsX+p1OPGKWaq15SJWB+hwbzPMsEKAz43b9x7Z4CSbvQcsJJa3R9wbHlF2zw?=
 =?us-ascii?Q?mX5nSPnjE/ftn0PIAYbMiG7jUB61U6r5OYyZ1BfpvLC3LZOei0sMSOHqyMM8?=
 =?us-ascii?Q?ZB0c5uOmx/YliWpwWncVDFO55iXp3uQCpxQuKJyVFjmJnmXPdZiXMWDdSrvL?=
 =?us-ascii?Q?YGTlwX0J0ILFAIZtu8tFktahd371lr4iEDTq2xoGr26xwU1OrbwnEB8yXRlz?=
 =?us-ascii?Q?ZBPYGHIfPp4XJtSSXvYYlDUDoEdJEUTOZl1cjKVjlGcCjxs9wAE/IE7JcDpt?=
 =?us-ascii?Q?m/LVhtdASUaCi09HSeTaItlV8/dkQ/WJnMC2PDrMLFVveL51cETYeraBPk1H?=
 =?us-ascii?Q?pyADrhK0fVOtahbmCqSVNq8GKHM2w0DcVd+JwjEOfkHYj0o1R39ebBLgej0g?=
 =?us-ascii?Q?nR6TF64ip6q1Em1Bb53hPo18zqhWqD3Bo30l3NOAIsw7TJyRzrewqLMQKxJO?=
 =?us-ascii?Q?XLXhYw9AXsCBB6A6QQQ0+8WTwJkhTtafQQFcsbnGbBLVyjOfROh0YkF+wyRo?=
 =?us-ascii?Q?uGwIJTThM/+4NmEqaDF6sHdqQ0kwkdsDQHMRDevEyc70pBpraOQNsm4KPIqG?=
 =?us-ascii?Q?lnQJbS+8S8HSZXqw6/O5npkEGVUzWu2MCm9vDvOH2qSVOgpeIxisWPROCUm1?=
 =?us-ascii?Q?bMO5NbQLFjU71XafOq1el9ZabAzLO7WCBQIvBDWdR8fIxAv+GF27zov5pJwX?=
 =?us-ascii?Q?qPhs2vw0meFzcwvF4b6jYXfMRoVYwKO2IOpJ7VyGxxcwTNnwnYGExNAEpW6T?=
 =?us-ascii?Q?iLtyA1QrFoJnNUvZ6pZ1zYTwkTs4nV1cqJ9Cnrd15/73/EVEzaje0g8+4C0F?=
 =?us-ascii?Q?qwiORlwNG9n4Jxd8jwWOCobkF51nH2IhxmRSOawGrnySpAYnojbhocvDaIR1?=
 =?us-ascii?Q?cIrvvUbAO2NfifKNvv+Rk9IogQvd690fMOVbHLIJLC+Q50wk4VsfEYXOzJAW?=
 =?us-ascii?Q?kmu3kmeDSeMTNZ+XsnLEk/uK4tUfhRg6DY4Anl4XKE+IrXREGIjqYzYwEv9a?=
 =?us-ascii?Q?Nr4p3TT57USVjdT0051XXzByYT6UomWievgVC99tn3pFxyC1wgfuuH15Cs68?=
 =?us-ascii?Q?JwGxMb6xzPzd8MwiaM3a/5cXaQqOK8f1YAsgfAdCFmYvdt8f5qHVBh4T1stv?=
 =?us-ascii?Q?/B9xQZDECeRC5/RuTo8W/w3Zg2JJXF5jkjrhNvlarvm0HijNLdTUjqBnUR3o?=
 =?us-ascii?Q?KWsVnbooo5QuvJfG13kVCi/ipflFO0jAdU+IG/Tr5c4SX7Iz+VshzzLAw9Bg?=
 =?us-ascii?Q?0loPlrl8aY4WzV7oxvCwm/VRJsYFct/r4fyueVc7qTuR3VvbLXm4Jt+vYeEw?=
 =?us-ascii?Q?qk88IP7gWRf/vRAtKobMWpVFXKGmkBU8yrDXgENiat9wmqmStEMle5r7Ij2q?=
 =?us-ascii?Q?LZ7aXY699u4iyfrYfGaBOwXPbr679vZwESTAUxGdCU5K7D6QBPDgd2WOLJz3?=
 =?us-ascii?Q?zSdvu5RWD7N74P9uYsL7XzAZhkoDQptdrlm3U2WScSa2vN6OD/6tiPSVkywF?=
 =?us-ascii?Q?BFbXn+QPoEYWMUGm/e2LbcCPG/sc/N3NVSap0CK+09nhkfFAHhjEq7EATmUj?=
 =?us-ascii?Q?dIJH3d6oeGhdElSWnupShHqX1gGtDWIzGVQAYRo69MW9k+1H4rxVGL4NxvWV?=
 =?us-ascii?Q?FGTbsPDKxo0xgF0+zlICdKazwLqwsUa2ziCZne2LkH8UY+YAshctnkVPRh+3?=
 =?us-ascii?Q?v8jE7XetehKOaV4QNgioHJBbr8yweieXSSV7+M7BhYkzM8Aq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa712453-f05e-47aa-755f-08deb4d3de74
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 11:51:59.5905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tBSspWljSoKYVoLSsLJjqfKgaaWvywGUpGf36nLBDgxl+V8VFs2vcg+zP5eH/p6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, May 18, 2026 2:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 3/3] drm/amd/ras: return error when converting records to
> nps pages fails
>
> return error when converting records to nps pages fails
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index d4072350f48f..78db402182f7 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -391,9 +391,8 @@ static int ras_umc_update_eeprom_ram_data(struct
> ras_core_context *ras_core,
>                       data->space_left--;
>               }
>       } else {
> -             memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
> -             data->count++;
> -             data->space_left--;
> +             RAS_DEV_ERR(ras_core->dev, "Failed to convert record to nps
> pages!");
> +             return -EINVAL;

[Tao] are your sure the error is also fit for the condition of count =3D=3D=
 0?

>       }
>
>       return 0;
> --
> 2.34.1

