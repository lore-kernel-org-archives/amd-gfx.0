Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AA9C44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 14:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7041210ED74;
	Tue, 14 Jul 2026 14:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5dJ2cgq/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800D910E08D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 14:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8Be0iIL/JJtxkh5nP7U3X5o+89Zia5F5ekI6sjJab811WMOG/UgH5azYIFpXnwa2OvjCwkguuBELq2R74gcSIcPG1rzNmmzhPZvKWNM662K4a47WU5OYuPNA8tO7KiNgawNdVU2V90cUL7GMLey3L3uEvEDtmE34lHit1CiN0RqI6M+eoeVgN6vTB4m9KigYprLfBqweDoO7HJESyzjpapk7sP777jgw0ltxd9e7IKhC//yA3icz6d3yYmGBJ9QEfh1JJGm7ml3rEq3MedX1Yck9ZNlWjQ+ZSD5dUA+EMPdCOFVH26JUu1HusRi6UmInfCxpb+Jtx3zBXIE35AkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAFty95Z4SPrRdLMimIorCYhmLv5JWg9Xddj9jQivLQ=;
 b=YO4Ejxi4KkOvVSBCWmA2Tx4zc2IJPJj3MdiQFX54L72DbE+Ftepa2kpEPSxfkrtKXBuP+LfrbSMK9VL/DY+9v34AlVhQ02hANlqbGAyqJSzqFNEKMhSAqCbnRDBafytWyQ+BON0/qVloevEvJpvA+zINlMMs/WnZNqaQlOyGC4UMXCte7/JxaT5DwjWzAt6fGrkuXxWXEA17D7TWP1fnRmvBAMh84STWk9XR8n//IGt80cMqyDzR32reNn8xev5ic5miU4yYNZMhyTbWrXVfjUp+DVqbYeuoFUdAJr7guLAofkiGsTidHZqEdC6oUjNPsDxgs8dyPuGALsGYfCZmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAFty95Z4SPrRdLMimIorCYhmLv5JWg9Xddj9jQivLQ=;
 b=5dJ2cgq/DUya6qnacUARUuc9yz0yfhRb71Fr2boX0vmN5bod52QUi6LXZ7GiBJkuaG0tqi/6J09NTa/8eHjf/laNi1FJt/87H6gLPqoOmna2zGRuiOyykuDkR8QHprPX1phkRRFVuN2sPh1+sSpDfEaJn9k/0MVumzBtiIth6b0=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 14:10:07 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:10:07 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liang, Prike" <Prike.Liang@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Topic: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Index: AQHdEwemLj48Zo5+FEGWvILeBy4uu7ZsZOoAgABfvQCAAAuG2oAAAbiAgAAybUCAAAaOAIAAA4ag
Date: Tue, 14 Jul 2026 14:10:06 +0000
Message-ID: <IA0PR12MB820873CAF481C1993A4913E390F92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
 <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <9d575350-c3a2-4e9c-b842-b2a68678914e@amd.com>
 <IA0PR12MB8208EB469D4C2403243D321C90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <CADnq5_PbxvfpjCDQKyeySp1fipA12YduN2t7XzgE7iacc1v-Rg@mail.gmail.com>
In-Reply-To: <CADnq5_PbxvfpjCDQKyeySp1fipA12YduN2t7XzgE7iacc1v-Rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T14:08:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|PH7PR12MB7260:EE_
x-ms-office365-filtering-correlation-id: 9000acef-dbf6-4f50-625f-08dee1b19b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|56012099006|6133799003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: MD13SJo909IFYtv35kUlxYJ7omzWj9+bRFUoUlup+AixjZgvw6PdawUShp/LrudnhLS8FKf684P80Ahr6nlD+kP4W6MjpJCFox8vYOa5CZbssyjEPCeD0QcuisXhEmf7KVzxxBDBrxWWaIT9dTmUX/4+RzJ8ZIVXlq/SGcEbfV7sqYChTkccYGwTAGJh5RRj+4rQ6rDeL/Pk02NEc8pOM7YLWa9aKhA+X334s1J/A/yMcLxTOCg11hGLSuYRS15dSNySlJE8t6HfpOEOrhm50QEmYxGwqzL2IRmCWuP+CC+CamvH7cjcpsV16Wi3AKioVo/bv9GWP8JEZ6nf1MMmAPu6R1EP8cdMulliZzZ/hGVCXNDjTLahJ/AoFpn1ePl029x6llOkwn8+cOX+40bYi/XwnGL/ajBTmRD0S5KyW1RIoglZNxDhapiz+A/OkcE738D7zrEhyR20GcFaHvYeyOLaGN/C+ZHTkSa6g8OQZf6Yxp8NhjkIqxEChvozhLa0scX89Ukf+32mLIruZfgs6en3RCatwGbPFV/Tnx176JY/0iV6muTpAmJiTOexAJctyoY/5jGsyPqCnULwMJ+MfpI+PqV83ie8d/5kYiw5qqFUpYldwkKmK1CqrGrSkjQQ9g4672hXykLUCeEyCyH9DYSKXwRH053uVKUBdRXs2vo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rjh4VzIydzdKczlFL2xnUWhNV2hhNkNRb0hWZDEzZHJJNjl2N0x2Ylp2eHQ2?=
 =?utf-8?B?a3B5em02YmYxY0hiTkhkb3AreDNvYklwMDk4VGdRdWlqeWhJbm4wcndXV0hm?=
 =?utf-8?B?WU9reDBzdDl2NVIyMlV1UGZ6T0xjRGRjYzljMkowUDhwbk9nMEYxRVBubDNq?=
 =?utf-8?B?M1M5YjdWbzAybHdMZGJrdzFhVHpyQkhSU0ZWdzF5ZmtZYnZvL0tVNzVPblFT?=
 =?utf-8?B?ZDN1UEhJU0k1SGlrWVdsd0QwZXFBbzdMSjFyWkNWNnI0RGhYQ0lCdDl3VkJV?=
 =?utf-8?B?SE4vcHEwWk5abjhzdmhHMlp6UW1UczBWTlEyMmtZRHd0THBVK2w3d3lmUUpm?=
 =?utf-8?B?MnZnSGc1YmJ0MEg5a0tITDkwN2tmSnRYaTFxc3RPOVR1bDBZUEFaa1hIdGVJ?=
 =?utf-8?B?MDZVVXhGRHhkS3FucmszM0FrOFMzTkVaSVRZRE1PYS9IdlVGclZKTnR6MHRM?=
 =?utf-8?B?bXZTcmorZi96S1NXSnVwdi9UUUZRaUZvbzNsZVJQWi9TMHpUZ2lsZ2hld2xI?=
 =?utf-8?B?OVkvVGpaZ2xXZGNCbDlPR2l5dXpJOTBVMk5mYWhHb3J6RkNwTW9EUGdqN3cw?=
 =?utf-8?B?Z1kxOFpvb3VQYlpMTUhVVEUvMlZTR0pHbGtmUXAyUFVFNUx6RzR0MDkwZklC?=
 =?utf-8?B?V2tjRUFkdnZvdFNDd0U2cGduaURxWE5EZ2h0Y252dWFUZzZ2QS9EMXlWNWc3?=
 =?utf-8?B?azYzZ3g2VmtYOFRBS0luM3FkTHJ4SFhUOXF6aUVSMk14VGc4SDVQSkZBa1N5?=
 =?utf-8?B?YTQxSU4zaHloWWFETFFyOUlTMVhiaFUvaUV0VGZWOENJMW9sZlJoTDcwK25B?=
 =?utf-8?B?MWROeWo2bzBZbGp3RHFLVkl6elhSMzRycUdnYWdSSk5qeXZMVlJtRTlJRm44?=
 =?utf-8?B?VkViZ1dHOXczblkvV3FFa1cwZGc3U2lpV3NoalhVZFQvRHNXaU5NSGZDN082?=
 =?utf-8?B?VnNlMEEybXJPQVhUYmIya2tKNy9MVVFucGp4Z2xRUUUxS0o2MFc5ejdCUXVN?=
 =?utf-8?B?NjlneWJ1S0k4czkzNUlkTUt3WVFEMmlqa1NsdW5yeGxvUVdOVE9IaDhWQnRw?=
 =?utf-8?B?azNTNHFJdFM0OUJ0NkhTTlViTHU3RXg2QWZtVi8vL0JTUDd3UDJ5YnVBdlp2?=
 =?utf-8?B?NERVQ3ArdklVRjFwSXl6eXhvN3NpUWl4eGJOTkJvdFl4TlZKaWZPUFM4Z0JM?=
 =?utf-8?B?SzFyV3FRbW0zM1p2MkdyMkVybDBlM0RVK09TWm9xMzFUZzVWNkJVcHJtdWUy?=
 =?utf-8?B?Y1pCczlNN045QjNyOFhiQjNzc2JOQ0N1Qk8vSVV3dE51bEFKRS9tM0JXYmZv?=
 =?utf-8?B?T3VBUE1TUVZ1Z2VyVW0rd2kydHo3KzVobmt1QWVRVjBmVE0yZFRTRHJsbTJz?=
 =?utf-8?B?ZHZob1oyQjkvZWZkSlNHUWZ5aXBsQnRiS1l6eUJTUm43aWQyZm55alJ4WHEw?=
 =?utf-8?B?YkRKZjErYnJ2aHJoRTEyMThNZXJwenhueDNQWFVTdUR0U2lTRXhJVk0yOVZu?=
 =?utf-8?B?S01MZnA4Rk1YWWltZDNDdGVFa1NNOGtLY29TdW5YcElWKzIxL3Rua3YrS0R4?=
 =?utf-8?B?WldQbmdSOFBMK05xN1BZd1pUR2l2Mkl2Y1RRT3JaZGhZR0FaMUl3YUU2bWo2?=
 =?utf-8?B?K2kvd0gwNHQ3czAxZUFoZFF2ZEZZYTM1MW9yREU2RytTVFJTTDc5UWRyYU5C?=
 =?utf-8?B?cThUSWRFeFFxK2YyMkFrSlB4Y0R4Q1NMUHhWMS9CN09DSERNSm53cnB4bUZh?=
 =?utf-8?B?N1NFUW9FTUlkYTRtL2UwOXp6RlFVemhzUnlEdWJLNHZ1N28vRUIyOUxKUm9s?=
 =?utf-8?B?MWxmSS9nRmRRbkorbjMvWWpTaW9xZHJ0clpxTy83K1h5YzhrRFB0NG00YjEx?=
 =?utf-8?B?czc3RlhuTjROQXg5eWFSL0MwdkhlUk9ZVGRnRHBpZVZkbWFuTU0zOC9LV0Zn?=
 =?utf-8?B?bWRZZitjYjRRNFVzUm9PZjRsazExRmtMZzRnN2c4WGVTcnRYR1RFNG9sTDR3?=
 =?utf-8?B?aFFMODFzenpQQm8wUzdvOU84T1lUckFpVlRzVlBoOVJNNWlPNXQ0NHlBWW1s?=
 =?utf-8?B?MXZYT2FTK1E5U1pMY3cxVVlYM1FscmptRmtjdWRpZGF2Mk9OSVQrcmtpQkZK?=
 =?utf-8?B?ajRidHg4V3haRUdrMG9tNUJVYjZ4VDBCbDg5dCtGRmRicHJtZ1NWS3BlWUo2?=
 =?utf-8?B?a2dpcGJjbHc2UjlBdkYvNFZ2aDlZUGR1VGQ0RitrS1FHbU4zYjk5aU9OU1N3?=
 =?utf-8?B?ZzZDWThZNlNTVFVxU3IxSHNhRXdNUnNSdmlOY1pTTXk1cXpmRm1za3FsbDlS?=
 =?utf-8?Q?fr8TJp/NctWEZDCK4P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9000acef-dbf6-4f50-625f-08dee1b19b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 14:10:06.9167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDicBxMWSyG9UtBamNLsUIM2muA1yxFvytFYSGmvH0zCnNfwAP76seh3pxAgUhS9sr4wPiOOwGy7M5EI/AUc9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAx
NCwgMjAyNiA3OjI2IFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4u
U0hBTk1VR0FNQGFtZC5jb20+DQo+IENjOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29t
PjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpYW5nLCBQcmlrZQ0KPiA8UHJpa2UuTGlhbmdA
YW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3VzZXJxOiBwcm9wZXJseSBhY2NvdW50IGZvciByZXNl
dHMNCj4NCj4gT24gVHVlLCBKdWwgMTQsIDIwMjYgYXQgOTo0OeKAr0FNIFNIQU5NVUdBTSwgU1JJ
TklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBBTUQgR2VuZXJhbA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gPiA+IFNlbnQ6IFR1
ZXNkYXksIEp1bHkgMTQsIDIwMjYgNDowMiBQTQ0KPiA+ID4gVG86IFNIQU5NVUdBTSwgU1JJTklW
QVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IERldWNoZXIsDQo+ID4gPiBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+ID4gPiBnZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiBDYzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0Bh
bWQuY29tPjsgS2hhdHJpLCBTdW5pbA0KPiA+ID4gPFN1bmlsLktoYXRyaUBhbWQuY29tPg0KPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS91c2VycTogcHJvcGVybHkgYWNjb3Vu
dCBmb3IgcmVzZXRzDQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBPbiAxNC1KdWwtMjYgMzo1
NyBQTSwgU0hBTk1VR0FNLCBTUklOSVZBU0FOIHdyb3RlOg0KPiA+ID4gPiBBTUQgR2VuZXJhbA0K
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBHZXQgT3V0bG9vayBm
b3IgQW5kcm9pZCA8aHR0cHM6Ly9ha2EubXMvQUFiOXlzZz4NCj4gPiA+ID4NCj4gPiA+ID4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gPiA+IC0tLS0NCj4gPiA+ID4gLS0NCj4gPiA+ID4gKkZyb206KiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+ID4gPiAqU2VudDoqIFR1ZXNkYXksIEp1bHkg
MTQsIDIwMjYgMzoxNDozNCBQTQ0KPiA+ID4gPiAqVG86KiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4N
Cj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+Ow0KPiA+ID4gRGV1Y2hlciwNCj4gPiA+
ID4gQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsNCj4gPiA+ID4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0K
PiA+ID4gPiAqQ2M6KiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBLaGF0cmks
IFN1bmlsDQo+ID4gPiA+IDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCj4gPiA+ID4gKlN1YmplY3Q6
KiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3VzZXJxOiBwcm9wZXJseSBhY2NvdW50IGZvcg0KPiA+
ID4gPiByZXNldHMNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gT24gMTQtSnVs
LTI2IDEwOjE2IEFNLCBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gd3JvdGU6DQo+ID4gPiA+ICA+IEFN
RCBHZW5lcmFsDQo+ID4gPiA+ICA+DQo+ID4gPiA+ICA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gPiAgPj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPiAgPj4gU2VudDoNCj4gPiA+ID4gVHVlc2RheSwgSnVseSAxNCwgMjAyNiAyOjA5IEFN
ICA+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgID4+DQo+IENjOg0KPiA+ID4g
PiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTSEFOTVVH
QU0sICA+Pg0KPiA+ID4gPiBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
PjsgTGlhbmcsIFByaWtlICA+Pg0KPiA+ID4gPiA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IEtoYXRy
aSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPiAgPj4NCj4gPiA+ID4gU3ViamVjdDogW1BB
VENIXSBkcm0vYW1kZ3B1L3VzZXJxOiBwcm9wZXJseSBhY2NvdW50IGZvciByZXNldHMgID4+DQo+
ID4gPiA+ID4+IFdlIG5lZWQgdG8gaW5jcmVtZW50IHRoZSByZXNldCBjb3VudGVyLCBmb3JjZSBm
ZW5jZSBjb21wbGV0aW9uLA0KPiA+ID4gPiBhbmQgc2V0IHRoZSAgPj4gd2VkZ2VkIGV2ZW50IHdo
ZW4gYSB1c2VyIHF1ZXVlIGlzIHJlc2V0Lg0KPiA+ID4gPiAgPj4NCj4gPiA+ID4gID4+IG1lc191
c2VycV9yZXNldF9xdWV1ZSgpIGhhbmRsZXMgdGhpcyBmb3IgY29sbGF0ZXJhbCBkYW1hZ2UsDQo+
ID4gPiA+IGJ1dCB0aGUgY2FsbGVyIG5lZWRzICA+PiB0byBoYW5kbGUgdGhpcyBkaXJlY3RseSBm
b3IgdGhlIG9yaWdpbmFsDQo+ID4gPiA+IGd1aWx0eSBxdWV1ZS4NCj4gPiA+ID4gID4+DQo+ID4g
PiA+ICA+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+ICA+PiBDYzoNCj4gPiA+ID4gU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4u
c2hhbm11Z2FtQGFtZC5jb20+ICA+PiBDYzogUHJpa2UNCj4gPiA+ID4gTGlhbmcgPFByaWtlLkxp
YW5nQGFtZC5jb20+ICA+PiBDYzogU3VuaWwgS2hhdHJpDQo+ID4gPiA+IDxzdW5pbC5raGF0cmlA
YW1kLmNvbT4gID4+IC0tLSAgPj4NCj4gPiA+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxLmMgfCA3ICsrKysrKy0gID4+ICAgMSBmaWxlDQo+ID4gPiA+IGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKSAgPj4gID4+IGRpZmYgLS1naXQNCj4gPiA+
ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+ID4gPiAg
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+ID4gPiAg
Pj4gaW5kZXggNmFhNzVkYTI3ZjkxMi4uNWUxMjYyNjM2ZTFlOSAxMDA2NDQgID4+IC0tLQ0KPiA+
ID4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gPiA+
ICA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+
ID4gPiAgPj4gQEAgLTE0Niw4ICsxNDYsMTMgQEAgc3RhdGljIHZvaWQNCj4gPiA+ID4gYW1kZ3B1
X3VzZXJxX2hhbmdfZGV0ZWN0X3dvcmsoc3RydWN0DQo+ID4gPiA+ICA+PiB3b3JrX3N0cnVjdCAq
d29yaykNCj4gPiA+ID4gID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcXVldWUsDQo+ID4gPiA+IE5VTEwsIE5VTEwpOyAgPj4gICAgICAg
ICAgICAgICAgZWxzZSAgPj4gICAgICAgICAgICAgICAgICAgICAgICByID0NCj4gPiA+ID4gdXNl
cnFfZnVuY3MtPnJlc2V0KHF1ZXVlKTsgID4+IC0gICAgICAgICAgICAgaWYgKHIpICA+PiArDQo+
ID4gPiA+IGlmIChyKSB7ICA+PiAgICAgICAgICAgICAgICAgICAgICAgIGdwdV9yZXNldCA9IHRy
dWU7ICA+PiArDQo+ID4gPiA+IH0gZWxzZSB7ICA+PiArDQo+ID4gPiA+IGF0b21pY19pbmMoJmFk
ZXYtPmdwdV9yZXNldF9jb3VudGVyKTsNCj4gPiA+ID4gID4+ICsNCj4gPiA+ID4gYW1kZ3B1X3Vz
ZXJxX2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHF1ZXVlKTsNCj4gPiA+ID4gID4+ICsg
ICAgICAgICAgICAgICAgICAgICBkcm1fZGV2X3dlZGdlZF9ldmVudChhZGV2X3RvX2RybShhZGV2
KSwNCj4gPiA+ID4gID4+IERSTV9XRURHRV9SRUNPVkVSWV9OT05FLCBOVUxMKTsNCj4gPiA+ID4g
ID4+ICsgICAgICAgICAgICAgfQ0KPiA+ID4gPiAgPj4gICAgICAgIH0gZWxzZSB7DQo+ID4gPiA+
ICA+PiAgICAgICAgICAgICAgICBncHVfcmVzZXQgPSB0cnVlOw0KPiA+ID4gPiAgPj4gICAgICAg
IH0NCj4gPiA+ID4gID4NCj4gPiA+ID4gID4gQWZ0ZXIgdGhlIG9yaWdpbmFsIHF1ZXVlIHdhcyBy
ZXNldCBzdWNjZXNzZnVsbHksIGl0IGRpZCBub3QNCj4gPiA+ID4gdXBkYXRlIGdwdV9yZXNldF9j
b3VudGVyLCBjb21wbGV0ZSBpdHMgcGVuZGluZyBmZW5jZXMsIG9yIHNlbmQgdGhlIHdlZGdlZA0K
PiBldmVudC4NCj4gPiA+ID4gID4gbWVzX3VzZXJxX3Jlc2V0X3F1ZXVlKCkgYWxyZWFkeSB1cGRh
dGVzIGdwdV9yZXNldF9jb3VudGVyLA0KPiA+ID4gPiBjb21wbGV0ZXMgdGhlIHBlbmRpbmcgZmVu
Y2VzLCBhbmQgc2VuZHMgdGhlIHdlZGdlZCBldmVudCBmb3IgdGhlDQo+ID4gPiA+IG90aGVyIGFm
ZmVjdGVkIHF1ZXVlcywgID4gYnV0IHNraXBzIHRoZSBvcmlnaW5hbCBxdWV1ZSBiZWNhdXNlIGl0
DQo+ID4gPiA+IGhhcyBhbHJlYWR5IGJlZW4gcmVzZXQuDQo+ID4gPiA+DQo+ID4gPiA+IFdoYXQg
aXMgdGhlIHJhdGlvbmFsZSBvZiBzZW5kaW5nIG11bHRpcGxlIGRldmljZSB3ZWRnZWQgZXZlbnRz
IG9uDQo+ID4gPiA+IGEgcGVyIHF1ZXVlIGJhc2lzPw0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgcXVl
c3Rpb24gb2Ygd2hldGhlciBkcm1fZGV2X3dlZGdlZF9ldmVudCgpIHNob3VsZCBiZSBlbWl0dGVk
DQo+ID4gPiA+IG9uY2UgcGVyIHF1ZXVlIG9yIG9uY2UgcGVyIG92ZXJhbGwgcmVjb3Zlcnkgc2Vl
bXMgbGlrZSBhIGJyb2FkZXINCj4gPiA+ID4gZGVzaWduIGRpc2N1c3Npb24uDQo+ID4gPiA+DQo+
ID4gPg0KPiA+ID4gQWxvbmcgd2l0aCB0aGF0LCBhbHNvIG5lZWQgdG8gY29uc2lkZXIgaWYgZGV2
aWNlIHJlc2V0X2NvdW50ZXIgbmVlZHMNCj4gPiA+IHRvIGJlIGluY3JlbWVudGVkIG9uIGEgcGVy
IHF1ZXVlIGJhc2lzIG9yIGJhc2VkIG9uIHJlc2V0IGV2ZW50DQo+ID4gPiByZWNvdmVyeS4gSXQg
Y291bGQgZ2V0IGluY3JlbWVudGVkIG11bHRpcGxlIHRpbWVzIGluc2lkZSB0aGlzIC0NCj4gbWVz
X3VzZXJxX3Jlc2V0X3F1ZXVlLg0KPiA+DQo+ID4gTG9va2luZyBhdCB0aGUgY3VycmVudCBmbG93
LCBib3RoIGdwdV9yZXNldF9jb3VudGVyIGFuZA0KPiBkcm1fZGV2X3dlZGdlZF9ldmVudCgpIGFy
ZSB1cGRhdGVkIG9uY2UgZm9yIGVhY2ggc3VjY2Vzc2Z1bGx5IHJlc2V0IHF1ZXVlLiBJdA0KPiB3
b3VsZCBiZSBoZWxwZnVsIHRvIGNsYXJpZnkgd2hldGhlciB0aGV5IGFyZSBpbnRlbmRlZCB0byBi
ZSB1cGRhdGVkIHBlciBhZmZlY3RlZA0KPiBxdWV1ZSBvciBvbmNlIHBlciBvdmVyYWxsIHJlY292
ZXJ5Lg0KPiA+DQo+DQo+IFdoYXQgYXJlIHRoZSBzZW1hbnRpY3MgYXJvdW5kIHRoZSByZXNldCBj
b3VudGVyIGFuZCB3ZWRnZWQgZXZlbnRzPw0KPiBQcmVzdW1hYmx5IGVhY2ggc2hvdWxkIGJlIGlu
Y3JlbWVudGVkIGZvciBlYWNoIHF1ZXVlIHRoYXQgaXMgcmVzZXQ/IElmIGEgaGFuZw0KPiBhZmZl
Y3RzIG11bHRpcGxlIHF1ZXVlcyBzaG91bGRuJ3QgZWFjaCBiZSBhIHNlcGFyYXRlICJyZXNldCI/
DQo+IEluIHRoZSBtb3N0IGNvbW1vbiBjYXNlLCB0aGVyZSBzaG91bGQganVzdCBiZSBvbmUgc2lu
Y2UgcXVldWUgcmVzZXQgc2hvdWxkIGJlDQo+IGFibGUgdG8gcmVzZXQganVzdCB0aGUgZ3VpbHR5
IHF1ZXVlLg0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLCBBbGV4LiBVbmRlcnN0b29k
IHRoYXQgdGhlIHJlc2V0IGNvdW50ZXIgYW5kIHdlZGdlZCBldmVudCBhcmUgaW50ZW5kZWQgdG8g
YmUgdXBkYXRlZCBvbmNlIGZvciBlYWNoIHF1ZXVlIHRoYXQgaXMgcmVzZXQuDQoNCkJlc3QgUmVn
YXJkcywNClNyaW5pDQoNCj4NCj4gQWxleA0K
