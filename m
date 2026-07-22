Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA18C4452D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 03:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A880110EC02;
	Wed, 22 Jul 2026 03:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0rIYw+s";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D997A10E405
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 03:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK2leOqtAioBdkyIi5/zdQo4bH7HBSiOaonJrTThfrAv4HfsEA0CzSzbUSgKzua+etvE9S4zzXGgX/W7t8uKxle5vKrTCUvffOGJPR6tcPoZrLdxe9LKHmOZWSC3smspctriW2zoyirKGMPVnFzShiztdnOlayTEKagrEpCHvX+AQpA3CCwlB+FpdZDge3efemthBy+RNxAnGGVy0fPCtXPSM9j7or70SE26J+aAmHjfkGOG4WhZQsLWyxTbLMhO5x4bgooUx1wWx0VDPhFP34qPEKVTUF5LJ8dNveYlZf+Th9Ng34qhuis+FRV3kqZ34WV1s3rE4QnIFFg3cRnL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE27Af4My5MSq1Ks9aoFNn01gY0+L8uBJn3Ab5yaNFI=;
 b=PA1GNIOrFK6Zl/HxbNXep2zJLR2aBsIZutnoQ+ftWCm3UhpgfO71pjjdgMxRFlX3EBYwT1u+ZGO0W1DCwLKybSZOS9A736IKox45UAszOro8gcjG3V59GrWxl8dmquELMb+SPiHRUx+T2nabAZcef2hp+D4Xg4KT6mMZ5nSDEk3eyGSHaf2cbP+ElbgZyZMQZBZ2wrQkUvjWlUuCRcwCVrNwzHzEAtSzBoMllQ/RegWmwTtTPioEOvFlFLF3jYQvbRl8ENfk2u1leWN704tBDhAs6RaTIVoT2eEs89Aj606b+sB6gkwR0iGLE4Jz5JP1S2eKvRCB/Zau5vbfYzvAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE27Af4My5MSq1Ks9aoFNn01gY0+L8uBJn3Ab5yaNFI=;
 b=V0rIYw+sKiSZidWHpYV1ZYTioTE2dG6TJELPNIGstFS3AUbS02ESu+STGatTVuo3TK0jWeO4utIpgXSrVx4hx8db7tIY/HbY9x5bvBgJwKyps+1eXCJhpfZyZ25QlGHJj9RjQSMK9wF2xXSlwkFJw7ibkQhU14m+0Itu+QZF6/Y=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:22:01 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:22:01 +0000
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
Thread-Index: AQHdFcno/vE+AMxPbkO89jaTg2SEG7ZxaYuAgAAUMtKABdc5soAAQU2MgADroACAAABVgIAAYx/H
Date: Wed, 22 Jul 2026 03:22:01 +0000
Message-ID: <SA1PR12MB73432D05527388F774BAB3E5EBC12@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
 <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
 <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <1b4941e0-b2dc-4506-a40c-937c3de37084@amd.com>
 <5b457aea-892e-4df6-bd1d-5fae0f15c5ff@amd.com>
In-Reply-To: <5b457aea-892e-4df6-bd1d-5fae0f15c5ff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-22T03:22:00.564Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|DS0PR12MB9421:EE_
x-ms-office365-filtering-correlation-id: d25afac1-9ffc-4658-d309-08dee7a0653b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|22082099003|18002099003|6133799003|8096899003|4143699003|10067099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info: +G4xcicfYWJv6lhlaL0eb+LQClF9+X7sgQpNK/CNyECCrYSyC/ntpzTx6C60sI88GMxQ17L2nmU1dsYcKwXUHI8oFFgMHvZDPUpW594navQ7DLmoRFuVoQppEdOUNaDrC1vmBp0Euv8c9KlGQnvDIz2qZ66XkR7NkyolwNP3Osn803gqKG8KL5rfD87XYeCgWUJjPYozU992YPFwRYqr/a+tCW69E7uhB2hISrrSNJq3pvQZD7m41WH0/nJdZG5uE08UTem5IOCaw2GG3qZBFVYDteCHiELb1aHKdaWEfUvGxmHvxuReIVyqJ1h02YIKVI83pg6/BSa78w1cNnpvr0L+yeShUMwARhmaFx4t4JRzE7SKk+n3YfLhAWPmhouJI73FWWTaopsZy/bC0ZXjNgGdfHdDl9gLO3KNlQprHPjIKWJool9UYx2Ae7G0VNrJqEFEWvQBSSWNSM4a1Ezdf1Q9/LVNPHON0ARMDKdOEQYBgvYmIwP+3p5C91PXSuZM7ygzB6zg0lMpECRNN7qi4kJ220um98I6tYaxr0V+wBh/lHOhmlK68giW1Z/A0DAiDMQUP1/NkFhUERRgBfzP102KYDfYLu3TitRG7mBtQcF2eomh4mivCkOu4SQSQ/lvZ2FuY6LTfLYIq9mS4NeLRJuz3sPI+E53eTeIgx9ieGrqGyancIOZVCuo6n0159Y7r7Hob1Uh/TbAyob6OwwVMqxnN4LZUZUWv65U5Q2sMRY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(6133799003)(8096899003)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?MiDpb0krkjRJPYMzeEHiMziM3ItNaRqUzuaL2IT/2YGcMJWY+c0F1uE4?=
 =?Windows-1252?Q?t/8sA6kfTUGHkAP9M/5bIADFdQYE6//4mZHq7qSjwQ5deSRfQg6S0egF?=
 =?Windows-1252?Q?c8jHRMBwdSP6XtVI7OUWqpR1RlCGH4K0Y+ujlaUxjeaasJ+ZWutuy52b?=
 =?Windows-1252?Q?BRbIqKAmtyvQ8vr3eW3v40TJRaAOJACXdI2bBKUxplNzJLEPXYUymXWU?=
 =?Windows-1252?Q?js3/nadTR0h0RsV8wfPmSZRrGhgbhzHLh1LoTszgK9GNumQgXBE3iSGQ?=
 =?Windows-1252?Q?1wgJH3rHx5hciBNM3aO7LquDeF31OOhoiww61vQkjsY8dLwRBFT89AJD?=
 =?Windows-1252?Q?MMhfGVEVAFsgBWldn83v7WrBleyySfNvYP+dziDg1vMcFyT6MGrj92Ja?=
 =?Windows-1252?Q?03oOb2qvU/mKL0qbxYjuvYPWDZKaNaSL6v3J/ygVgIsn66qTybr1vsBZ?=
 =?Windows-1252?Q?w7ym5s2sOk9Xuq6RHKc9JMAJvlBFTru6+4cvvndPRgnIEucEcAcHIz6Y?=
 =?Windows-1252?Q?yh71ASYiGsM54aKLLfSKMiD5hdJbWHrpmUcilGy1TAB24zIHgeYXezVg?=
 =?Windows-1252?Q?azYeCk4dV54wZrhYlAlX6NKsptNpWUBUA4uawonWtCofZTRhZto8PTwN?=
 =?Windows-1252?Q?Bh893GKnlgdZRdd/luXouh9EvObhaEx1+X5ZfVOKU2U8L2pPeSslGbvl?=
 =?Windows-1252?Q?0BnCr1hXfuIrypt5GpwpA4FGAj6Ba5KhJD7CKeIGQmJjJA8CyG2scZph?=
 =?Windows-1252?Q?HWJ7FvSGgN5AoBX5szIHD/2EALy7v66v+M9lM5LXZIw0ERG+8HSmT1EG?=
 =?Windows-1252?Q?JRBu+eWyq75Gq1jnFRdZu7QoFRr+Q6A9ByW9il8p7rxHIaydoZuiWlfB?=
 =?Windows-1252?Q?8keiAZOocflHD6KE0/bItiCrnNQ2+ABww9ITBERwTye0T4H2wrVz54QF?=
 =?Windows-1252?Q?LaA0K/Zb43Gu4z6FmpwatWIEaVRJk7Y+s+V3o4qtQjJdHakm2DAQP9UE?=
 =?Windows-1252?Q?Z75dn8IAYBeOPTjnDrvEhfkz9w7bxFawABnYBQazhU6yJ4FZPltaRgRf?=
 =?Windows-1252?Q?Ih7BKBtgAjcNP3SE51U2KhsVRkBIY3B36s8fAWcs9RbHmYb+Z75FkZx9?=
 =?Windows-1252?Q?gmKFvqpThq1XF80cNjj0nnaiavJyB/VBt7p58qPwQbiF/e3Q2gjFVg7+?=
 =?Windows-1252?Q?LBcCwdLAHoJMiwlAEflI7LjKXmffa/87+qT3oj1brq2J+pRsvQ+puzqd?=
 =?Windows-1252?Q?2J2bE8RkSosxSwDOaIDeizLaGtb11ew0jNYeU4hN0VOy9L8lJ3gSNHvL?=
 =?Windows-1252?Q?4s9ggXG6ytYh7CnlB5slV+LQtgKlz/L9jnslIDJihcbuEfTrpRfJKcTe?=
 =?Windows-1252?Q?Yj5pmsWUvlNA4uffROf5mv2y6ccSk7eyoIgk4wEuNTA42bMhZkD68M5L?=
 =?Windows-1252?Q?7H5rjCQYLF5xu3WBN3EqBtKVXgywwuEPgo7d6WSQzZFRYdeIvhaVb/Fm?=
 =?Windows-1252?Q?EQiMMK5w4ZCjwghBp51ZDeN0IYtNjkxoe7/9fqOOctTjPu7LSRbP/GBb?=
 =?Windows-1252?Q?67/TfhaGrqx2QxzxtzeIpP49E+VbOU4TRBLw0/eAfu/CilwnJXKGVBpM?=
 =?Windows-1252?Q?4T43AP+Sehi5zAM/lpUiRZB7EnwYr4KGt0zcyo/Jh/CJ+VUKFUrZySBo?=
 =?Windows-1252?Q?4gpKU4/8agYK12ErJGy63jiCLWHOpGZSF+5BminmGpjfsxILjReQ1XJG?=
 =?Windows-1252?Q?5yC1nNNTHlRONsuXbwcOEq6cF4af9rIEMBAsQaqBkWjes7HsdDwVFPWD?=
 =?Windows-1252?Q?pomq2aNfJCCVaJMzdsaw8tQLwvdLH8Ho+Fq8M/G/WVy2VK1E?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB73432D05527388F774BAB3E5EBC12SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25afac1-9ffc-4658-d309-08dee7a0653b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 03:22:01.1778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5EzUoGq9b/qqKlCM9jxLbFuYOcjF025bE9IgHwif/XCQvOMTU0VBXPYe6vrd/9WSxkEfrrxqzf6BTbj2GRSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

--_000_SA1PR12MB73432D05527388F774BAB3E5EBC12SA1PR12MB7343namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

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


--_000_SA1PR12MB73432D05527388F774BAB3E5EBC12SA1PR12MB7343namp_
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
This is for virtual machine migration feature, especially under the SR-IOV =
scenario.</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Shikang</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
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
ion when MQD is in VRAM
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">IIUC you need to go throu=
gh these flows as part of guest migration (which system goes into S4 to acc=
omplish).</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<div>On 7/21/26 16:20, Felix Kuehling wrote:</div>
<blockquote>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">These are all server GPUs=
. Is system suspend really a requirement here? Or is this for runtime suspe=
nd? But runtime suspend shouldn't kick in while user mode queues exist.</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Regards,<br>
&nbsp; Felix</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<div>On 2026-07-21 03:20, Fan, Shikang wrote:</div>
<blockquote>
<div style=3D"text-align: left; margin-left: 5pt; font-family: Calibri; fon=
t-size: 10pt; color: rgb(0, 0, 255);">
AMD General</div>
<div><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
+<a href=3D"mailto:Victor.Zhao@amd.com" id=3D"OWAAM420325" class=3D"x_tWKOu=
 x_mention x_ms-bgc-nlr x_ms-fcl-b">@Zhao, Victor</a>,
<a href=3D"mailto:Tiantian.Zhang@amd.com" id=3D"OWAAM394558" class=3D"x_tWK=
Ou x_mention x_ms-bgc-nlr x_ms-fcl-b">
@Zhang, Tiantian (Celine)</a>. &nbsp;And also <a href=3D"mailto:Mario.Limon=
ciello@amd.com" id=3D"OWAAM671300" class=3D"x_tWKOu x_mention x_ms-bgc-nlr =
x_ms-fcl-b">
@Limonciello, Mario</a>&nbsp;to help with the review.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Shikang</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Fan, Shikang <a href=3D"mailto:Shikang.Fan@amd.com" id=3D"OWAb=
0212dc5-abf9-2457-03a9-172b3ae4df06" class=3D"x_moz-txt-link-rfc2396E OWAAu=
toLink">
&lt;Shikang.Fan@amd.com&gt;</a><br>
<b>Sent:</b> Tuesday, July 21, 2026 11:25 AM<br>
<b>To:</b> Koenig, Christian <a href=3D"mailto:Christian.Koenig@amd.com" id=
=3D"OWA2ba6da45-8b2d-7b69-8e8b-963a272eca41" class=3D"x_moz-txt-link-rfc239=
6E OWAAutoLink">
&lt;Christian.Koenig@amd.com&gt;</a>; <a href=3D"mailto:amd-gfx@lists.freed=
esktop.org" id=3D"OWA92029759-6d03-8014-370c-871c7fe51412" class=3D"x_moz-t=
xt-link-abbreviated x_moz-txt-link-freetext OWAAutoLink">
amd-gfx@lists.freedesktop.org</a> <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org" id=3D"OWA073116fb-634d-a0d2-33d8-301ad5720333" class=3D"x_moz-txt-l=
ink-rfc2396E OWAAutoLink">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; SHANMUGAM, SRINIVASAN <a href=3D=
"mailto:SRINIVASAN.SHANMUGAM@amd.com" id=3D"OWA33fd6339-cec9-9ace-3ad4-4ca3=
afef6944" class=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a>; Kuehling, Felix <a href=3D"mailto=
:Felix.Kuehling@amd.com" id=3D"OWAf5ec45ce-e4a7-0d26-6078-0ada21c7fd26" cla=
ss=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;Felix.Kuehling@amd.com&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang@amd.com" id=3D"OWA873=
14b18-3d0f-b23a-5589-7efe9442e7c5" class=3D"x_moz-txt-link-rfc2396E OWAAuto=
Link">
&lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Alexa=
nder.Deucher@amd.com" id=3D"OWA6b336082-fc53-cddc-90a0-60368798a067" class=
=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM</div>
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
+<a href=3D"mailto:SRINIVASAN.SHANMUGAM@amd.com" id=3D"OWAAM517752" class=
=3D"x_x_tWKOu x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b">@SHANMUGAM, SRINIVAS=
AN</a>&nbsp;and
<a href=3D"mailto:Felix.Kuehling@amd.com" id=3D"OWAAM431627" class=3D"x_x_t=
WKOu x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b">
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
<b>From:</b> Fan, Shikang <a href=3D"mailto:Shikang.Fan@amd.com" id=3D"OWA0=
8cec092-314c-f504-cc77-385dc8b1c196" class=3D"x_moz-txt-link-rfc2396E OWAAu=
toLink">
&lt;Shikang.Fan@amd.com&gt;</a><br>
<b>Sent:</b> Friday, July 17, 2026 6:25 PM<br>
<b>To:</b> Koenig, Christian <a href=3D"mailto:Christian.Koenig@amd.com" id=
=3D"OWA7d39dc95-5fd0-55cd-8208-7c9d1c1bf21e" class=3D"x_moz-txt-link-rfc239=
6E OWAAutoLink">
&lt;Christian.Koenig@amd.com&gt;</a>; <a href=3D"mailto:amd-gfx@lists.freed=
esktop.org" id=3D"OWAff18d3f4-04f8-564c-cf93-051d00eef269" class=3D"x_moz-t=
xt-link-abbreviated x_moz-txt-link-freetext OWAAutoLink">
amd-gfx@lists.freedesktop.org</a> <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org" id=3D"OWA4a4f79c3-f874-0d97-0857-b4ec466026f6" class=3D"x_moz-txt-l=
ink-rfc2396E OWAAutoLink">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang@amd.com" id=3D"OWAeb9=
7ff5d-44a8-1ad5-b321-6ba37a6673ba" class=3D"x_moz-txt-link-rfc2396E OWAAuto=
Link">
&lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Alexa=
nder.Deucher@amd.com" id=3D"OWA012bbe5d-e4d7-9c87-e9f1-8fbc1173b201" class=
=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix <a href=3D"mailto:Fe=
lix.Kuehling@amd.com" id=3D"OWAf4f12489-79d6-e1b3-c1ee-34d84d58bcf1" class=
=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
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
id=3D"OWA97eafd91-1958-3c7d-5954-a1d68cee8499" class=3D"x_moz-txt-link-rfc2=
396E OWAAutoLink">
&lt;Christian.Koenig@amd.com&gt;</a><br>
<b>Sent:</b> Friday, July 17, 2026 4:59 PM<br>
<b>To:</b> Fan, Shikang <a href=3D"mailto:Shikang.Fan@amd.com" id=3D"OWA581=
899db-c59b-d410-e9d4-079cbaf50433" class=3D"x_moz-txt-link-rfc2396E OWAAuto=
Link">
&lt;Shikang.Fan@amd.com&gt;</a>; <a href=3D"mailto:amd-gfx@lists.freedeskto=
p.org" id=3D"OWA9c8e3bd5-ca3e-949e-f02f-1eabc17f6cb2" class=3D"x_moz-txt-li=
nk-abbreviated x_moz-txt-link-freetext OWAAutoLink">
amd-gfx@lists.freedesktop.org</a> <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org" id=3D"OWA80d8477c-d33a-d4a7-e2e2-449eb4a9300f" class=3D"x_moz-txt-l=
ink-rfc2396E OWAAutoLink">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang@amd.com" id=3D"OWA3e3=
13cbe-a93c-7397-12da-97346aa31e90" class=3D"x_moz-txt-link-rfc2396E OWAAuto=
Link">
&lt;Philip.Yang@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Alexa=
nder.Deucher@amd.com" id=3D"OWA8c8f61c2-ac82-6a5f-e31a-6ec656174fb0" class=
=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix <a href=3D"mailto:Fe=
lix.Kuehling@amd.com" id=3D"OWA87542527-237e-c296-dff8-ed43e296dacf" class=
=3D"x_moz-txt-link-rfc2396E OWAAutoLink">
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
=3D"OWA89eaf602-17c3-e4e6-4d57-a934f87b0ff4" class=3D"x_moz-txt-link-rfc239=
6E OWAAutoLink">
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

--_000_SA1PR12MB73432D05527388F774BAB3E5EBC12SA1PR12MB7343namp_--
