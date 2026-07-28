Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5818DC53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 03:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F0B10E505;
	Tue, 28 Jul 2026 03:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h0TQp8yF";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4272510E505
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 03:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWMScV/YCOxzqrX7QETGMjK096QTamKSRC6LextVIOA+PG4dFAoWcYvUx8qofusL519IjDIswaoZ4kXNzaRTCaYhX1/wNyP+zoCLOYDopSkYO/64Ok1zwysBSc46HW8ofmhjgEjvryzEsDHIQT4MyzH9Q45rHGhLfmrxhfrAS7G0BnE6QxslvMmVEig6b/ONe+ltit3sAqmJugIV15sWNtlfA+JSUPhDNuJTeW6XpWU83JSuUZ+hQZwPT9lfzXwetipLwojWt55eVUgb06aJmzQDj6yVBWuJQcLVu5DLaqC51HX1bH5EfiE5H8UkPjGqQuSc9xUonpCrZEJqs4Wmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFIBcfOFeLpy/JwyK1joqSDpFggsERxLN/oi6JM4eeo=;
 b=jIHxCUevRJraTf/n15O92nPGD6bxF0K+U399FFSJ/vYMQkOwyX86jipM42hCj9znVnG/VloCwmxzWvs7ZO815qhDNg1xfaaW98OGSNePDssB7zyNOfJB6vdJMnnSiIxIKV3hN+TPdWxwtpoYZqo+arKjDvMJ5vmG219c+5B86KOaa03TWD+ufiK/xqVqqj/y5F4M6MnVEuLhm9NeybUOAmhOPwbxAivjRQe5KmnHC8F1gvphSNDCdInTJ54/KmOyNl2GFjXcgqIiUrXIgCmtbGxk6LHdZ24G2wLrlBGP9OBYE01ICXwGzRnS+xJPyDYyNJuqJ6JET6dw9vEPgJYtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFIBcfOFeLpy/JwyK1joqSDpFggsERxLN/oi6JM4eeo=;
 b=h0TQp8yFS2IetgajI84Q9MlaqF4tyKWUkPTqen/M5QWMlT9jo1cbQmk7Cm4jIIEKnQszVK0FOWnuTbQL9zlho0BQyZXGScHN6ijMLXEeoFw7CWeUJ+JY3IAIQCjeoo8AtbC0hrWVSPpYDWCSOEfxwLsLaSZqLUOJsMME7IEkXIc=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 03:10:06 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 03:10:06 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "SHANMUGAM,
 SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, "Zhang,
 Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Thread-Topic: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Thread-Index: AQHdFcno/vE+AMxPbkO89jaTg2SEG7ZxaYuAgAAUMtKABdc5soAAQU2MgADroACAAABVgIAAYx/HgAlr+k8=
Date: Tue, 28 Jul 2026 03:10:06 +0000
Message-ID: <SA1PR12MB73434AC08F3012E7445E23CEEBCB2@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
 <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
 <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <1b4941e0-b2dc-4506-a40c-937c3de37084@amd.com>
 <5b457aea-892e-4df6-bd1d-5fae0f15c5ff@amd.com>
 <SA1PR12MB73432D05527388F774BAB3E5EBC12@SA1PR12MB7343.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB73432D05527388F774BAB3E5EBC12@SA1PR12MB7343.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T03:10:06.489Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|PH0PR12MB7864:EE_
x-ms-office365-filtering-correlation-id: 1925d7f9-6d86-4e46-4f07-08deec55b9a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|5023799004|11063799006|56012099006|10067099003|6133799003|8096899003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 8LOMPjWt8wX3m6c/H3Qo7Oxo2oWeAH4lcrGBS9k6bAHFlFexR9wkvag99YOE/thaYWj1Ar0WmaQ5Dl6nQvdgzWcUCEMpyycnObxGCbzDYYjUKIZ1b3oFXNMZwmrqDgEJarqtm/Un2PqdZNfRYNsUjHLtVUiZzYp1vNxwquFFhWa7uHeCE7NjElsGIN9TF87/7ceXYAAboYbZsDxW0AYeD1rIhhomFx/Jy0usxoz4liRM4qsX6HLPGgYFzMZkeRp/kWUxunS5u8/T+FAzWwfw3dvDumiUNKBYuA/N+CKZZpALMjxPVcd6p6JCRac6flaRpzJXtHkqxJ0no+aMqGASLutyi3390KMIN5mJI3qR53VRaVZrXBDUH7J1iVehrkxHT8ZzoQJBjRdajVWD6PyWzHIRR5/cMjG/XzQhA/GyWsJ5t6dgZHm+KGGkY7saNgyRH2kG0RL1sEFAGExHwEj1al1ZIILrRTpw154kLlauVMY6m+n9/8d5Ad6R57PB8xrL691WFTW9yNnIvMU69H8s16+ei9q+sUaY7kLNzx+DcGLuaqhpZ560R77fUvkPIwlmH3zTzZspdCgzfaf7tZL0ckMeHgVDaq+jYwVznwvWAsZt7AyjXclkmWy04LZxdCVyi8JC+XsPsVLpnes2tfIQqg5RrDjmMrdYyo+MTTM+2xxR3dwvawHaddryAvjcdE7p82TVHWcls5zaT/ccfX/NtHWeZeH/NyUfflvtAdWmx+o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(8096899003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?A3mavqGZCTgUWkgoxYNM54AjBXX1/l9L/CMr6tCNzyj6790V+f3RElRw?=
 =?Windows-1252?Q?WeTjIshI7O5YbJWppH0vHKO6MIoR8rGL4KqKhij55Cawhtffb8Cu24Y4?=
 =?Windows-1252?Q?TSRc1XoUpgishnGFiH0kLmUUQPkceBM/1xiKIR5gpRNAeQm8rJStsd+W?=
 =?Windows-1252?Q?YI7bdfmGlW0QYOd6S8wtMf8aQvLmFU15Ry2b+NyiB6aI9M5gwqwsHUcA?=
 =?Windows-1252?Q?lvcrTsvUkx2DRjDxHLDBJB8z2ghROf5TLcXL8os/jbAflc/uoB0UKc9H?=
 =?Windows-1252?Q?u2os+WHnuu/TSzzNPsGqkPtz3FrP6NW9b/hKVczUR9clEt9caHbcIXxf?=
 =?Windows-1252?Q?AxXhmMLqpVctPN7fJCHHKcPsLP9+wei8HikAUW4ah7VBLVhVxHALleQG?=
 =?Windows-1252?Q?khhl3VMcy9RnBBQJ9fxeXp16srjTKt47DRpsQpRsIqjoODow/6nHhUoI?=
 =?Windows-1252?Q?gaQgSgAFUVS/0460JTs9KmKQ7vRK7rbNFhJnQqxViP0rXxv1GbA2ulH0?=
 =?Windows-1252?Q?npCUJz13ebmY6v/gkPv1c/OuTKaeks6v43rUr73z/Bvuz/dmFWWOItRh?=
 =?Windows-1252?Q?AMl5CZ56G964KzAgHqS7Ej6Buc+pUcGNMHLZzSSxy3fK7T1RkV6R09/e?=
 =?Windows-1252?Q?H+BzLrfkyrQTAeWRnN2M37575YRxyDcIjC2RwBuqJHvmsHllZmgYNm4u?=
 =?Windows-1252?Q?+iIJWjgvip6TkBz6bocnVavDzqBExOGKvZgPKsUkmYzYF4yoVGi8N4PZ?=
 =?Windows-1252?Q?F9rJ520Gvp6tXuoI2kk9b9ekb1+gbubqqTO43/3x5FZbNIY+tQT5xS3y?=
 =?Windows-1252?Q?htSWrkmrjDD0h6WIxqBc4g4GrbWdnICh38wJcn8+CRB+Mlwhq76RJUML?=
 =?Windows-1252?Q?B0rLB/+JNAZgkCfUGASoVgXlFsXyWLXwbs622RKeASjuttnW7aMcYvLB?=
 =?Windows-1252?Q?U0OHUJpdZJ93JiVHxHi1u7r1974749COkmEr0mPD+b9OpBl4CusWZSTq?=
 =?Windows-1252?Q?PPt89Opk35CfJtLtkz62g9jakctt3ZM9XA0aY2Xpu0c2UMzyC/hVFdrl?=
 =?Windows-1252?Q?xHatDbqg63spvfERpgGo2ezKbyEkMEocyioEYvmeELLImis3JJthNzDd?=
 =?Windows-1252?Q?K2uWsOHN/bp0GtaynEMeUsTmI3WEcKtIDYUPa7mzl/IBm2MpLx0cur+l?=
 =?Windows-1252?Q?CKYj8jQ7nR5zpxJVCkVIWoLVdc/kM/q3QkAM/hqm5dyTnx01sV9F3FNb?=
 =?Windows-1252?Q?KPNSUHn7SYzHE0b398x9KlVMqqCzvLyYDFh0E2IjzIOgWBFrZwKN6QRY?=
 =?Windows-1252?Q?HpLZz4K5TNTpC7pWk37AqNtYEoHKJy1djMPWCKGJZdFqgmsldgdB2LXn?=
 =?Windows-1252?Q?EtwYq7I5GBNLFqrj4y/EGKULEMWXLlGP5UeC9gcAUa38IYrkgiMHsLa0?=
 =?Windows-1252?Q?niFdFuv9AfS4yH0jleOh63BvQvs5k9ABky6S2PYZ62pHsPjblbra6WUO?=
 =?Windows-1252?Q?IhTUJ0rjKlsEWzd2zohiR8i9JSqCOgtpG2rSiAUWrblLCJ907RUu3pQH?=
 =?Windows-1252?Q?k8vlCm8tCj86EcExAfw/QzGUqZ2MrXbOqhk6Kvg4EzLdb34FHX/a4IuR?=
 =?Windows-1252?Q?8XRh4fj3Df/V4wAqhg0Au3k9tfsYjmsp7gjhtz+aCoESNfgYxhiqWC+O?=
 =?Windows-1252?Q?KqOHc8AboOHqDcpVNdSUJuSsbiRJW9D0zTYOLgQZEDvrrhPzvkXVWsVL?=
 =?Windows-1252?Q?JlN5XS78wkByNNp0Jb0R1MY/8Ezjh8j0srYlRyaZDpY0iOPwtqz04RJW?=
 =?Windows-1252?Q?gfF6h3otVGWQ/z4ZJjKlrJ74pWcZwJk8q7YcSVDIx00/9e3U?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB73434AC08F3012E7445E23CEEBCB2SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1925d7f9-6d86-4e46-4f07-08deec55b9a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 03:10:06.4068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/SS51ZeL6ongN5KtpV936/++HMyMargppidP2bhFNytC3CxVzEMq5IoJql/SKPC4QuPOov72lxDAH11/SephQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

--_000_SA1PR12MB73434AC08F3012E7445E23CEEBCB2SA1PR12MB7343namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi @Kuehling, Felix<mailto:Felix.Kuehling@amd.com>, could you help take a l=
ook for other comments that you might have?

Regards,
Shikang


________________________________
From: Fan, Shikang <Shikang.Fan@amd.com>
Sent: Wednesday, July 22, 2026 11:22 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@li=
sts.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGAM, SRINIVASAN =
<SRINIVASAN.SHANMUGAM@amd.com>
Cc: Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Zhang, Tiantian (Celine) <=
Tiantian.Zhang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

AMD General

This is for virtual machine migration feature, especially under the SR-IOV =
scenario.

Regards,
Shikang

________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Wednesday, July 22, 2026 5:21 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; Fan, Shikang <Shikang.Fan@amd=
.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesk=
top.org <amd-gfx@lists.freedesktop.org>; SHANMUGAM, SRINIVASAN <SRINIVASAN.=
SHANMUGAM@amd.com>
Cc: Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Zhang, Tiantian (Celine) <=
Tiantian.Zhang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM


IIUC you need to go through these flows as part of guest migration (which s=
ystem goes into S4 to accomplish).


On 7/21/26 16:20, Felix Kuehling wrote:

These are all server GPUs. Is system suspend really a requirement here? Or =
is this for runtime suspend? But runtime suspend shouldn't kick in while us=
er mode queues exist.


Regards,
  Felix


On 2026-07-21 03:20, Fan, Shikang wrote:
AMD General

+@Zhao, Victor<mailto:Victor.Zhao@amd.com>, @Zhang, Tiantian (Celine)<mailt=
o:Tiantian.Zhang@amd.com>.  And also @Limonciello, Mario<mailto:Mario.Limon=
ciello@amd.com> to help with the review.

Regards,
Shikang

________________________________
From: Fan, Shikang <Shikang.Fan@amd.com><mailto:Shikang.Fan@amd.com>
Sent: Tuesday, July 21, 2026 11:25 AM
To: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@am=
d.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>; SHA=
NMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com><mailto:SRINIVASAN.SHANMUG=
AM@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling=
@amd.com>
Cc: Yang, Philip <Philip.Yang@amd.com><mailto:Philip.Yang@amd.com>; Deucher=
, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

AMD General

+@SHANMUGAM, SRINIVASAN<mailto:SRINIVASAN.SHANMUGAM@amd.com> and @Kuehling,=
 Felix<mailto:Felix.Kuehling@amd.com> to the review discussion as Christian=
 is currently OOO.

Regards,
Shikang

________________________________
From: Fan, Shikang <Shikang.Fan@amd.com><mailto:Shikang.Fan@amd.com>
Sent: Friday, July 17, 2026 6:25 PM
To: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@am=
d.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Yang, Philip <Philip.Yang@amd.com><mailto:Philip.Yang@amd.com>; Deucher=
, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

AMD General


I do have a few thoughts on the unpin-repin approach and re-building the MQ=
D from housekeeping information.

For unpin-repin: the MQD's GPU address may change after it's moved back fro=
m GTT, and several places hold the original address, so we'd need to update=
 all of them and be careful not to miss any =97 but overall it's doable.

For re-build: the one thing we can't reconstruct is the control stack. It r=
esides in the same BO as the MQD, and the driver doesn't preserve its conte=
nts.

Separately, I'd like to raise a potential pre-existing issue I noticed whil=
e writing the patch. mqd_on_vram() covers gfx942, gfx943, gfx944 and gfx950=
. gfx943/944/950 are all registered with the _v9_4_3 implementations, which=
 call flush_hdp() in init_mqd, update_mqd and restore_mqd. gfx942, however,=
 uses the base MQD functions, which lack the flush_hdp() call.

Regards,
Shikang

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Friday, July 17, 2026 4:59 PM
To: Fan, Shikang <Shikang.Fan@amd.com><mailto:Shikang.Fan@amd.com>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Yang, Philip <Philip.Yang@amd.com><mailto:Philip.Yang@amd.com>; Deucher=
, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

On 7/17/26 10:53, Shikang Fan wrote:
> On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
> BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not saved
> across S4 hibernation, so the MQD is garbage on resume and the first
> submission faults. Save it to a system-RAM shadow at suspend and restore
> it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.
>
> v2:
>  - Also snapshot the MQD when a process is already runtime-evicted at
>    hibernation start. The qpd->evicted refcount early-return previously
>    skipped the save loop, losing the MQD across the VRAM wipe (both the
>    cpsch and nocpsch evict paths).
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com><mailto:shikang.fan@amd.c=
om>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
>  3 files changed, 129 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..d168686ee324 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_manager=
 *dqm);
>  static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>                                struct queue *q);
>
> +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q);
> +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q);
> +
>  static inline void deallocate_hqd(struct device_queue_manager *dqm,
>                                struct queue *q);
>  static int allocate_hqd(struct device_queue_manager *dqm, struct queue *=
q);
> @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct device_queue_=
manager *dqm,
>                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>                                        &q->gart_mqd_addr, &q->properties)=
;
>
> +     retval =3D dqm_alloc_mqd_backup(dqm, q);
> +     if (retval)
> +             goto out_free_mqd;
> +
>        if (q->properties.is_active) {
>                if (!dqm->sched_running) {
>                        WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
> @@ -1263,8 +1270,16 @@ static int evict_process_queues_nocpsch(struct dev=
ice_queue_manager *dqm,
>        int retval, ret =3D 0;
>
>        dqm_lock(dqm);
> -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> +             /* A process already runtime-evicted when hibernation start=
s
> +              * skips the save loop below, so snapshot its VRAM MQDs her=
e
> +              * before the S4 image is taken. dqm_save_mqd_backup() is a
> +              * no-op outside S4.
> +              */
> +             list_for_each_entry(q, &qpd->queues_list, list)
> +                     dqm_save_mqd_backup(dqm, q);
>                goto out;
> +     }
>
>        pdd =3D qpd_to_pdd(qpd);
>        pr_debug_ratelimited("Evicting process pid %d queues\n",
> @@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct devi=
ce_queue_manager *dqm,
>                         * maintain a consistent eviction state
>                         */
>                        ret =3D retval;
> +
> +             dqm_save_mqd_backup(dqm, q);
>        }
>
>  out:
> @@ -1304,6 +1321,88 @@ static int evict_process_queues_nocpsch(struct dev=
ice_queue_manager *dqm,
>        return ret;
>  }
>
> +/* MQD software-shadow save/restore across S4 hibernation, reusing the C=
RIU
> + * checkpoint_mqd/restore_mqd primitives.
> + */
> +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +     uint32_t mqd_size, ctl_stack_size =3D 0;
> +
> +     if (!mqd_on_vram(dqm->dev->adev))
> +             return 0;
> +     if (q->properties.type !=3D KFD_QUEUE_TYPE_COMPUTE)
> +             return 0;
> +     if (!q->mqd)
> +             return 0;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
> +             return 0;
> +
> +     mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
> +                NUM_XCC(dqm->dev->xcc_mask);
> +     if (mqd_mgr->get_checkpoint_info)
> +             mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, &ctl_stack_si=
ze);
> +
> +     if (!q->mqd_backup) {
> +             q->mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);

Please note that you need to be super careful when allocating memory during=
 suspend. The amount available is really limited because both swap and OOM =
killer are already stopped.

Instead you should probably consider unpinning on suspend and repinning on =
resume, for this we have memory put asside.

Additional to that it could be that backing up the MQD is overkill, we shou=
ld be able to re-create the MQD after resume from the housekeeping informat=
ion we still have around.

Regards,
Christian.


> +             if (!q->mqd_backup)
> +                     return -ENOMEM;
> +             q->mqd_backup_size =3D mqd_size;
> +     }
> +     if (ctl_stack_size && !q->ctl_stack_backup) {
> +             q->ctl_stack_backup =3D kzalloc(ctl_stack_size, GFP_KERNEL)=
;
> +             if (!q->ctl_stack_backup) {
> +                     kfree(q->mqd_backup);
> +                     q->mqd_backup =3D NULL;
> +                     q->mqd_backup_size =3D 0;
> +                     return -ENOMEM;
> +             }
> +             q->ctl_stack_backup_size =3D ctl_stack_size;
> +     }
> +
> +     return 0;
> +}
> +
> +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +
> +     /* in_s4 is reliably set at evict/suspend time; skip normal runtime=
 eviction
> +      * (pinned VRAM MQD stays intact then).
> +      */
> +     if (!dqm->dev->adev->in_s4)
> +             return;
> +     if (!q->mqd_backup)
> +             return;
> +     if (!q->mqd || !q->mqd_mem_obj || !q->mqd_mem_obj->cpu_ptr)
> +             return;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd, q->mqd_backup, q->ctl_stac=
k_backup);
> +     q->mqd_backup_valid =3D true;
> +}
> +
> +static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +
> +     if (!q->mqd_backup_valid || !q->mqd_backup)
> +             return;
> +     if (!q->mqd_mem_obj)
> +             return;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     if (!mqd_mgr->restore_mqd)
> +             return;
> +
> +     mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd=
_addr,
> +                          &q->properties, q->mqd_backup, q->ctl_stack_ba=
ckup,
> +                          q->ctl_stack_backup_size);
> +     q->mqd_backup_valid =3D false;
> +}
> +
>  static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>                                      struct qcm_process_device *qpd)
>  {
> @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct devic=
e_queue_manager *dqm,
>        int retval =3D 0;
>
>        dqm_lock(dqm);
> -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> +             /* A process already runtime-evicted when hibernation start=
s
> +              * skips the save loop below, so snapshot its VRAM MQDs her=
e
> +              * before the S4 image is taken. dqm_save_mqd_backup() is a
> +              * no-op outside S4.
> +              */
> +             list_for_each_entry(q, &qpd->queues_list, list)
> +                     dqm_save_mqd_backup(dqm, q);
>                goto out;
> +     }
>
>        pdd =3D qpd_to_pdd(qpd);
>
> @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,
>                                goto out;
>                        }
>                }
> +
> +             dqm_save_mqd_backup(dqm, q);
>        }
>
>        if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1423,6 +1532,7 @@ static int restore_process_queues_nocpsch(struct de=
vice_queue_manager *dqm,
>
>                mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>                                q->properties.type)];
> +             dqm_restore_mqd_backup(dqm, q);
>                q->properties.is_active =3D true;
>                increment_queue_count(dqm, qpd, q);
>
> @@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct devi=
ce_queue_manager *dqm,
>                if (!QUEUE_IS_ACTIVE(q->properties))
>                        continue;
>
> +             dqm_restore_mqd_backup(dqm, q);

Those are the wrong point to call those functions if I'm not completely mis=
taken.

Regards,
Christian.

>                q->properties.is_active =3D true;
>                increment_queue_count(dqm, &pdd->qpd, q);
>
> @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct device_queue_=
manager *dqm, struct queue *q,
>                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>                                        &q->gart_mqd_addr, &q->properties)=
;
>
> +     retval =3D dqm_alloc_mqd_backup(dqm, q);
> +     if (retval)
> +             goto out_free_mqd;
> +
>        list_add(&q->list, &qpd->queues_list);
>        qpd->queue_count++;
>
> @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct device_queue_m=
anager *dqm, struct queue *q,
>        list_del(&q->list);
>        if (q->properties.is_active)
>                decrement_queue_count(dqm, qpd, q);
> +out_free_mqd:
>        mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>        dqm_unlock(dqm);
>  out_deallocate_doorbell:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 88191a4c1657..1f728f13813e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -637,6 +637,15 @@ struct queue {
>        void *gang_ctx_cpu_ptr;
>
>        struct amdgpu_bo *wptr_bo_gart;
> +
> +     /* system-RAM shadow of a VRAM-resident MQD (+ control stack)
> +      * for hibernation snapshot/restore
> +      */
> +     void *mqd_backup;
> +     void *ctl_stack_backup;
> +     uint32_t mqd_backup_size;
> +     uint32_t ctl_stack_backup_size;
> +     bool mqd_backup_valid;
>  };
>
>  enum KFD_MQD_TYPE {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index 98a5512b701b..cbc90bf87792 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_pro=
perties *properties)
>
>  void uninit_queue(struct queue *q)
>  {
> +     kfree(q->mqd_backup);
> +     kfree(q->ctl_stack_backup);
>        kfree(q);
>  }
>


--_000_SA1PR12MB73434AC08F3012E7445E23CEEBCB2SA1PR12MB7343namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi <a href=3D"mailto:Felix.Kuehling@amd.com" id=3D"OWAAM448351" class=3D"tW=
KOu mention ms-bgc-nlr ms-fcl-b">
@Kuehling, Felix</a>, could you help take a look for other comments that yo=
u might have?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 22, 2026 11:22 AM<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;; Koenig, Christian &lt;Christian.Koeni=
g@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.=
org&gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; Z=
hang, Tiantian (Celine) &lt;Tiantian.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; margin-left: 5pt; font-fami=
ly: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
AMD General</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
This is for virtual machine migration feature, especially under the SR-IOV =
scenario.</div>
<div id=3D"x_appendonsend"></div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
Shikang</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 22, 2026 5:21 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Fan, Shikang &lt=
;Shikang.Fan@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt=
;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; SHA=
NMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; Z=
hang, Tiantian (Celine) &lt;Tiantian.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px;">IIUC you =
need to go through these flows as part of guest migration (which system goe=
s into S4 to accomplish).</p>
<p style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<div style=3D"direction: ltr;">On 7/21/26 16:20, Felix Kuehling wrote:</div=
>
<blockquote>
<p style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px;">These are=
 all server GPUs. Is system suspend really a requirement here? Or is this f=
or runtime suspend? But runtime suspend shouldn't kick in while user mode q=
ueues exist.</p>
<p style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px;">Regards,<=
br>
&nbsp; Felix</p>
<p style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<div style=3D"direction: ltr;">On 2026-07-21 03:20, Fan, Shikang wrote:</di=
v>
<blockquote>
<div style=3D"direction: ltr; text-align: left; margin-left: 5pt; font-fami=
ly: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
AMD General</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
+<a href=3D"mailto:Victor.Zhao@amd.com" id=3D"OWAAM420325" class=3D"x_x_tWK=
Ou x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b">@Zhao, Victor</a>,
<a href=3D"mailto:Tiantian.Zhang@amd.com" id=3D"OWAAM394558" class=3D"x_x_t=
WKOu x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b">
@Zhang, Tiantian (Celine)</a>. &nbsp;And also <a href=3D"mailto:Mario.Limon=
ciello@amd.com" id=3D"OWAAM671300" class=3D"x_x_tWKOu x_x_mention x_x_ms-bg=
c-nlr x_x_ms-fcl-b">
@Limonciello, Mario</a>&nbsp;to help with the review.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Shikang</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Fan, Shikang <a href=3D"mailto:Shikang.Fan@amd.com" id=3D"OWA0=
2b22b33-39af-f641-8648-b333c5f75014" class=3D"x_x_moz-txt-link-rfc2396E x_O=
WAAutoLink">
&lt;Shikang.Fan@amd.com&gt;</a><br>
<b>Sent:</b> Tuesday, July 21, 2026 11:25 AM<br>
<b>To:</b> Koenig, Christian <a href=3D"mailto:Christian.Koenig@amd.com" id=
=3D"OWAe98c7c1f-11d8-1c6d-cfdf-72f2a1fa0716" class=3D"x_x_moz-txt-link-rfc2=
396E x_OWAAutoLink">
&lt;Christian.Koenig@amd.com&gt;</a>; <a href=3D"mailto:amd-gfx@lists.freed=
esktop.org" id=3D"OWA9f4b9188-3db2-6b12-083c-90441030da3c" class=3D"x_x_moz=
-txt-link-abbreviated x_x_moz-txt-link-freetext x_OWAAutoLink">
amd-gfx@lists.freedesktop.org</a> <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org" id=3D"OWA9a64c66b-e05d-a83f-21de-2be9900f4c41" class=3D"x_x_moz-txt=
-link-rfc2396E x_OWAAutoLink">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; SHANMUGAM, SRINIVASAN <a href=3D=
"mailto:SRINIVASAN.SHANMUGAM@amd.com" id=3D"OWAcf7bb245-3281-1470-d92a-7a46=
272cb222" class=3D"x_x_moz-txt-link-rfc2396E x_OWAAutoLink">
&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a>; Kuehling, Felix <a href=3D"mailto=
:Felix.Kuehling@amd.com" id=3D"OWAbe061beb-654e-04cf-047c-dd09e2f4d429" cla=
ss=3D"x_x_moz-txt-link-rfc2396E x_OWAAutoLink">
&lt;Felix.Kuehling@amd.com&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang@amd.com" id=3D"OWAde2=
01da7-3c81-a9f6-9b50-47a59298822b" class=3D"x_x_moz-txt-link-rfc2396E x_OWA=
AutoLink">
&lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Alexa=
nder.Deucher@amd.com" id=3D"OWAecce1e0e-2f09-f717-632d-4a2801086d10" class=
=3D"x_x_moz-txt-link-rfc2396E x_OWAAutoLink">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; margin-left: 5pt; font-fami=
ly: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
AMD General</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
+<a href=3D"mailto:SRINIVASAN.SHANMUGAM@amd.com" id=3D"OWAAM517752" class=
=3D"x_x_x_tWKOu x_x_x_mention x_x_x_ms-bgc-nlr x_x_x_ms-fcl-b">@SHANMUGAM, =
SRINIVASAN</a>&nbsp;and
<a href=3D"mailto:Felix.Kuehling@amd.com" id=3D"OWAAM431627" class=3D"x_x_x=
_tWKOu x_x_x_mention x_x_x_ms-bgc-nlr x_x_x_ms-fcl-b">
@Kuehling, Felix</a>&nbsp;to the review discussion as Christian is currentl=
y OOO.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Shikang</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Fan, Shikang <a href=3D"mailto:Shikang.Fan@amd.com" id=3D"OWAd=
1f60d95-10b2-018a-dd15-494d2468ebf1" class=3D"x_x_moz-txt-link-rfc2396E x_O=
WAAutoLink">
&lt;Shikang.Fan@amd.com&gt;</a><br>
<b>Sent:</b> Friday, July 17, 2026 6:25 PM<br>
<b>To:</b> Koenig, Christian <a href=3D"mailto:Christian.Koenig@amd.com" id=
=3D"OWA1a67261d-6af0-18f3-5ed4-f12fe5e5f0ef" class=3D"x_x_moz-txt-link-rfc2=
396E x_OWAAutoLink">
&lt;Christian.Koenig@amd.com&gt;</a>; <a href=3D"mailto:amd-gfx@lists.freed=
esktop.org" id=3D"OWAcdb990bf-abc1-3b1f-3394-9bbbba72aa80" class=3D"x_x_moz=
-txt-link-abbreviated x_x_moz-txt-link-freetext x_OWAAutoLink">
amd-gfx@lists.freedesktop.org</a> <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org" id=3D"OWA74e78773-7123-ef66-ceda-b9f7411af9e5" class=3D"x_x_moz-txt=
-link-rfc2396E x_OWAAutoLink">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang@amd.com" id=3D"OWA124=
f7a4f-5760-12bb-9630-69bbb007e61f" class=3D"x_x_moz-txt-link-rfc2396E x_OWA=
AutoLink">
&lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Alexa=
nder.Deucher@amd.com" id=3D"OWAaa86e3bd-1596-914a-da56-488abec8020d" class=
=3D"x_x_moz-txt-link-rfc2396E x_OWAAutoLink">
&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix <a href=3D"mailto:Fe=
lix.Kuehling@amd.com" id=3D"OWA37866c81-bcd9-9a8f-4154-12b69efbb4ac" class=
=3D"x_x_moz-txt-link-rfc2396E x_OWAAutoLink">
&lt;Felix.Kuehling@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; margin-left: 5pt; font-fami=
ly: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
AMD General</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
I do have a few thoughts on the unpin-repin approach and re-building the MQ=
D from housekeeping information.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
For unpin-repin: the MQD's GPU address may change after it's moved back fro=
m GTT, and several places hold the original address, so we'd need to update=
 all of them and be careful not to miss any =97 but overall it's doable.</d=
iv>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
For re-build: the one thing we can't reconstruct is the control stack. It r=
esides in the same BO as the MQD, and the driver doesn't preserve its conte=
nts.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Separately, I'd like to raise a potential pre-existing issue I noticed whil=
e writing the patch. mqd_on_vram() covers gfx942, gfx943, gfx944 and gfx950=
. gfx943/944/950 are all registered with the _v9_4_3 implementations, which=
 call flush_hdp() in init_mqd, update_mqd
 and restore_mqd. gfx942, however, uses the base MQD functions, which lack =
the flush_hdp() call.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Shikang</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Koenig, Christian <a href=3D"mailto:Christian.Koenig@amd.com" =
id=3D"OWA516eb1aa-2a55-b38f-6558-7c2ce3dac644" class=3D"x_x_moz-txt-link-rf=
c2396E x_OWAAutoLink">
&lt;Christian.Koenig@amd.com&gt;</a><br>
<b>Sent:</b> Friday, July 17, 2026 4:59 PM<br>
<b>To:</b> Fan, Shikang <a href=3D"mailto:Shikang.Fan@amd.com" id=3D"OWAe39=
3f983-6307-ce41-1f62-3715da437c32" class=3D"x_x_moz-txt-link-rfc2396E x_OWA=
AutoLink">
&lt;Shikang.Fan@amd.com&gt;</a>; <a href=3D"mailto:amd-gfx@lists.freedeskto=
p.org" id=3D"OWAd567c281-c89f-42a0-d202-aafa6bf0615c" class=3D"x_x_moz-txt-=
link-abbreviated x_x_moz-txt-link-freetext x_OWAAutoLink">
amd-gfx@lists.freedesktop.org</a> <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org" id=3D"OWAeb0aabba-c230-7b6f-cb3e-0978ea3f3aa5" class=3D"x_x_moz-txt=
-link-rfc2396E x_OWAAutoLink">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang@amd.com" id=3D"OWAd77=
b7cd7-d81c-2b0b-cb9c-ae80bb48462e" class=3D"x_x_moz-txt-link-rfc2396E x_OWA=
AutoLink">
&lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Alexa=
nder.Deucher@amd.com" id=3D"OWA77fe07d2-2502-fec3-9953-3aacef051c44" class=
=3D"x_x_moz-txt-link-rfc2396E x_OWAAutoLink">
&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix <a href=3D"mailto:Fe=
lix.Kuehling@amd.com" id=3D"OWA2becc8d5-ec55-bbfc-5fda-f8033ba48876" class=
=3D"x_x_moz-txt-link-rfc2396E x_OWAAutoLink">
&lt;Felix.Kuehling@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">On 7/17/26 10:53, Shikang F=
an wrote:<br>
&gt; On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VR=
AM<br>
&gt; BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not sav=
ed<br>
&gt; across S4 hibernation, so the MQD is garbage on resume and the first<b=
r>
&gt; submission faults. Save it to a system-RAM shadow at suspend and resto=
re<br>
&gt; it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.<=
br>
&gt;<br>
&gt; v2:<br>
&gt;&nbsp; - Also snapshot the MQD when a process is already runtime-evicte=
d at<br>
&gt;&nbsp;&nbsp;&nbsp; hibernation start. The qpd-&gt;evicted refcount earl=
y-return previously<br>
&gt;&nbsp;&nbsp;&nbsp; skipped the save loop, losing the MQD across the VRA=
M wipe (both the<br>
&gt;&nbsp;&nbsp;&nbsp; cpsch and nocpsch evict paths).<br>
&gt;<br>
&gt; Signed-off-by: Shikang Fan <a href=3D"mailto:shikang.fan@amd.com" id=
=3D"OWAb3f8330c-185c-df7d-bebb-b5e1016115ba" class=3D"x_x_moz-txt-link-rfc2=
396E x_OWAAutoLink">
&lt;shikang.fan@amd.com&gt;</a><br>
&gt; ---<br>
&gt;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 ++++++++++++=
+++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_queue.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&gt;&nbsp; 3 files changed, 129 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index 51ee9c39104b..d168686ee324 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_mana=
ger *dqm);<br>
&gt;&nbsp; static void deallocate_sdma_queue(struct device_queue_manager *d=
qm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
&gt;&nbsp;<br>
&gt; +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q);<br>
&gt; +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q);<br>
&gt; +<br>
&gt;&nbsp; static inline void deallocate_hqd(struct device_queue_manager *d=
qm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
&gt;&nbsp; static int allocate_hqd(struct device_queue_manager *dqm, struct=
 queue *q);<br>
&gt; @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct device_que=
ue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q-&gt;mqd, q-&gt;mqd=
_mem_obj,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm_alloc_mqd_backup(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto out_free_mqd;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_acti=
ve) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON=
CE(1, &quot;Load non-HWS mqd while stopped\n&quot;);<br>
&gt; @@ -1263,8 +1270,16 @@ static int evict_process_queues_nocpsch(struct =
device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval, ret =3D 0;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evi=
cted, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already e=
victed, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* A process already runtime-evicted when hibernation starts<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * skips the save loop below, so snapshot its VRAM MQDs here<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * before the S4 image is taken. dqm_save_mqd_backup() is a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * no-op outside S4.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry(q, &amp;qpd-&gt;queues_list, list)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm=
, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D qpd_to_pdd(qpd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;E=
victing process pid %d queues\n&quot;,<br>
&gt; @@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 maintain a consistent eviction state<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 retval;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_save_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp; out:<br>
&gt; @@ -1304,6 +1321,88 @@ static int evict_process_queues_nocpsch(struct =
device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt; +/* MQD software-shadow save/restore across S4 hibernation, reusing th=
e CRIU<br>
&gt; + * checkpoint_mqd/restore_mqd primitives.<br>
&gt; + */<br>
&gt; +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_size, ctl_stack_size =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type !=3D KFD_QUEUE_TYP=
E_COMPUTE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;checkpoint_mqd || !mqd_mgr-=
&gt;restore_mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mqd_mgr-&=
gt;mqd_size) *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; NUM_XCC(dqm-&gt;dev-&gt;xcc_mask);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;get_checkpoint_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mqd_mgr-&gt;get_checkpoint_info(mqd_mgr, q-&gt;mqd, &amp;ctl_stack_size=
);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);<br>
<br>
Please note that you need to be super careful when allocating memory during=
 suspend. The amount available is really limited because both swap and OOM =
killer are already stopped.<br>
<br>
Instead you should probably consider unpinning on suspend and repinning on =
resume, for this we have memory put asside.<br>
<br>
Additional to that it could be that backing up the MQD is overkill, we shou=
ld be able to re-create the MQD after resume from the housekeeping informat=
ion we still have around.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!q-&gt;mqd_backup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;mqd_backup_size =3D mqd_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ctl_stack_size &amp;&amp; !q-&gt;ctl_sta=
ck_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;ctl_stack_backup =3D kzalloc(ctl_stack_size, GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!q-&gt;ctl_stack_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup =3D NU=
LL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;ctl_stack_backup_size =3D ctl_stack_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* in_s4 is reliably set at evict/suspend ti=
me; skip normal runtime eviction<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (pinned VRAM MQD stays intact then).=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd || !q-&gt;mqd_mem_obj || !q-&=
gt;mqd_mem_obj-&gt;cpu_ptr)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;checkpoint_mqd(mqd_mgr, q-&gt;mq=
d, q-&gt;mqd_backup, q-&gt;ctl_stack_backup);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid =3D true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, =
struct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup_valid || !q-&gt;mqd_ba=
ckup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &amp;q-&gt;=
mqd, q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;q-&gt;properties, q-&gt;mqd_backup, q-&gt;ctl_stack_backup,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; q-&gt;ctl_stack_backup_size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid =3D false;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int evict_process_queues_cpsch(struct device_queue_manage=
r *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct qcm_process_device *qpd)<br>
&gt;&nbsp; {<br>
&gt; @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct de=
vice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval =3D 0;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evi=
cted, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already e=
victed, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* A process already runtime-evicted when hibernation starts<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * skips the save loop below, so snapshot its VRAM MQDs here<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * before the S4 image is taken. dqm_save_mqd_backup() is a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * no-op outside S4.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry(q, &amp;qpd-&gt;queues_list, list)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm=
, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D qpd_to_pdd(qpd);<br>
&gt;&nbsp;<br>
&gt; @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_save_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;kfd-&gt=
;shared_resources.enable_mes) {<br>
&gt; @@ -1423,6 +1532,7 @@ static int restore_process_queues_nocpsch(struct=
 device_queue_manager *dqm,<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_ty=
pe(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_restore_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, qpd, q);<br>
&gt;&nbsp;<br>
&gt; @@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!QUEUE_IS_ACTIVE(q-&gt;properties))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_restore_mqd_backup(dqm, q);<br>
<br>
Those are the wrong point to call those functions if I'm not completely mis=
taken.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd, q);<br>
&gt;&nbsp;<br>
&gt; @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct device_que=
ue_manager *dqm, struct queue *q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q-&gt;mqd, q-&gt;mqd=
_mem_obj,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm_alloc_mqd_backup(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto out_free_mqd;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list, &a=
mp;qpd-&gt;queues_list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count++;<br>
&gt;&nbsp;<br>
&gt; @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct device_queu=
e_manager *dqm, struct queue *q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_acti=
ve)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, qpd, q);<br>
&gt; +out_free_mqd:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr=
, q-&gt;mqd, q-&gt;mqd_mem_obj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
&gt;&nbsp; out_deallocate_doorbell:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 88191a4c1657..1f728f13813e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -637,6 +637,15 @@ struct queue {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_ga=
rt;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* system-RAM shadow of a VRAM-resident MQD =
(+ control stack)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for hibernation snapshot/restore<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_backup;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *ctl_stack_backup;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_backup_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ctl_stack_backup_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool mqd_backup_valid;<br>
&gt;&nbsp; };<br>
&gt;&nbsp;<br>
&gt;&nbsp; enum KFD_MQD_TYPE {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_queue.c<br>
&gt; index 98a5512b701b..cbc90bf87792 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
&gt; @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_=
properties *properties)<br>
&gt;&nbsp;<br>
&gt;&nbsp; void uninit_queue(struct queue *q)<br>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;ctl_stack_backup);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q);<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
<br>
</div>
</blockquote>
</blockquote>
</body>
</html>

--_000_SA1PR12MB73434AC08F3012E7445E23CEEBCB2SA1PR12MB7343namp_--
