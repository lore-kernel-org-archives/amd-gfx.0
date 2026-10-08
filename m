Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FB4CA6004
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 02:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC9510E712;
	Thu,  8 Oct 2026 02:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XRCZCB1I";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B1310E712
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 02:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+uX4herRKNUD+vtG6d805p/tOdBBwTbJtxPex2dOWQe8IhvRH+ApbGICGv7jnz4pcco5pTmBy8OvL24Mn0vlX3P7GDoji4EAk+yztzPTYRDsh/oC3ZKsDF0w0Lhvvh/PggC81fM4/1IOqVxdokChzuLsGXLI5nvUJbbWWTPmjdaSAdx4ZqlKLN6E6CtfD+hPRK1a4uvjX1W0f8RSoLiQhZslUUkSzR1HPqopEesOzbM30nxemGql7aaZjry2gITJbLb3lRQs9f5FySNoKEyE1hJ8ebIo1hVzOI2AksHfiZKlIznM6pknID+hFKJHMHez7IrjagyBGGnDIY0BfsXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMMtVGgxt4Ypb5ARvluhOLy7LhjLwNO5PKWwbHB0AIA=;
 b=tHUq7t7J0gP1+676qmgqaXX5RGz5JGhytkEQ0Rk+GlbhdPd3zcD6J42K/27I7IthYeIOBPDlPsaVPCToeM59r2q/OGEo4EGmLYc3UpslD/+5UzPRxtbYfr0eZB8wgn+eToz9qeZWMbMQdG8tRoIOou/ZRWJoizGhU3SUAUFv0/nk9r3yypSjg9aH8Wi+PcvgSNHPhVJ2nKddvhrpWDWoGFPb1G1SLSuIBgQ8oy2opoxKPP9e/5SzEzyyn/rXP29Jtv1WwX6R+s+BLk4kduKEAUVDxTyRSXKHpTN7EXAGdnkQynMsgUVB7/thU2dTw47rS+uUwe+oqaQdwiidMC81dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMMtVGgxt4Ypb5ARvluhOLy7LhjLwNO5PKWwbHB0AIA=;
 b=XRCZCB1IXsL+lPA+NboMNx54Ivb+fSX1s2K8/FUg7Uy3cNKuUychaFqTvwYgvzFVBe4BBmCw6lf/HmTTmuteR2lwG0AUifDXwzVAeQsaVF8zuBuBawE1aoecvW7/VtxdMLTog2iQpYphIBsFYYeTU7pHdxTTUEvmog/CrkCxbDw=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 02:35:08 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 02:35:07 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Hong, Chi" <Chi.Hong@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhang, Tiantian (Celine)"
 <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
Thread-Topic: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
Thread-Index: AQHdTxBKx3oj9c/6U0e5DdvUJGHDQrblKTKAgAHVmACAC/S0gIAACWUA
Date: Thu, 8 Oct 2026 02:35:06 +0000
Message-ID: <BN9PR12MB5306053369B18DAC739F98A5FC932@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260928061148.117428-1-Chi.Hong@amd.com>
 <LV3PR12MB9235640A364B16BA772702889F8C2@LV3PR12MB9235.namprd12.prod.outlook.com>
 <1ff26404-19cc-42d1-9792-e6e557b2fcc8@amd.com>
 <LV3PR12MB9235B6BCB43D50E20413D21B9F932@LV3PR12MB9235.namprd12.prod.outlook.com>
In-Reply-To: <LV3PR12MB9235B6BCB43D50E20413D21B9F932@LV3PR12MB9235.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T01:58:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|BY5PR12MB4258:EE_
x-ms-office365-filtering-correlation-id: f96c3a47-70a7-4a7a-d7cf-08df24e4c3f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|4143699003|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: C8nj/VybR5OUe1JlERy4aEV6IRcn3cJ3NlF60u4U0/UWJjAx0UEtkjj+0y3ihnBD9MndW1sjg0WcejbybfdTPGCdI6y5wlEn6aVhOAptoNefq47gxe6PVuMTAE8G076K2K+90hxiHnKJg4QTQj32L8tXw3OIU2QEcmRdECXUXxOMu91m1wynfl/dvtAIeAaztNBcXDvISBacs8nCp47yUAcy7pv+avX590KypQV2jsSKX1lZB59Pt39Oq0b+V3rrF8nuZ0OAn0Jh2r3kIwuqzYzScRXP3atggaasCsNCglPJS3vqa+zWoLjsTKSTk73WUiWllpR2+yofUB1e+Dqt+dxsk1DaXCn44q4WC0lXvRmKuCftWHK70Ua+yi7Yc58H9hulLg1QYzzI1TaUXjP79oAE+fwAWGjQlWjhyYnnpOJazOp6NBSmNvrVWiEZX93eqqAQvaOyIWWA3vS8YZzfEECNFcgkZ1XFhy9bb4/icYQq5epCw83zTEo77x96MHaOhXGYRjhay2IFG7np4ITm2oRK9nlUdUcQSC8cx3rYskVddGEFjtHFV3K8+Hnb++VA8w4E7KKKorFfClXU4YkbJqB9IxPtCcq2ktqYWT5VuqI/jWHSVldWiJgYw5/oZLVByiVbgoK9ffXaFBoTJDrK0o/J8ynXBZyn34uOd/t4f/bje4Cw7XUwowQ9sZWRekCtRErfQZk6TqsN5z/wFwnz0k9E4uOnGD14RY9ngQXwv28=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE9qNzJXdUEzdTRmekV4L1ppVnFvZUwzNVQ3eHRydFA0NXh5b0g0RlE5MTlx?=
 =?utf-8?B?amdBSUhLbDhYUHFBWkdPYStkV3FJcDROSmVOdisxTmtNdm42clhkV2NSZVlz?=
 =?utf-8?B?VlphTUUza0g3RjBPV0RKTVFEaUIzckJkenJ4ZmlKMy9WNHJacUUyS1hsTUxr?=
 =?utf-8?B?eDNFazU1YkxPQjAzQnVzMnpNL3dyOVRsOG40RUE3ekp6djJyQjZOM1dwaDZP?=
 =?utf-8?B?NE1ySlJxZ3d3YVBObFZmNkRDNnA4NUpwWGcvSDJXRkRXWmhIQ1ZoN0hldm9Z?=
 =?utf-8?B?WlNVNzBGb3BTaEZuTzdQa3luWFlLZHRERXkxa2l5QWFWZ1JxanEvYmZhUjFG?=
 =?utf-8?B?L3JqVWtBSElNcko3dFh3Q0svc2oxeFMyRnBJZ1N0MUx1eFY4cEdKVDVObGpx?=
 =?utf-8?B?dm9lQjFzOHMxMWVzQlhkTXcwdS9HdU1vTGU4ODgzckVLZm1TWkhONG5qa29B?=
 =?utf-8?B?YlpnNnA0d0RVd2k1R0pWbE41aWF5dkdlTUlrUXN2QVFIVGwzanpDeDRKajF0?=
 =?utf-8?B?WTE4c29SeDZrQmQ2ZGJxVDNxOEdpampzOVBhTDZNdVVqUmtaMlA0bTNyYXgw?=
 =?utf-8?B?czd0VktTVEhIYkdlc1djTllINGNYa0JURE90eWNPMEprUG12ZHRYUGpFMUMy?=
 =?utf-8?B?Z2EvQlJWSktLRnZPSC9pYjJkVEdjMG1hT1VheUVCKzQ5cGpsUGMwRjhGeWpH?=
 =?utf-8?B?Sk8yeTM0VVV1WFRqRm05ZEh5VFZMWkFOY2VKemFBSWxIVzZ0S0RKN25Eekhx?=
 =?utf-8?B?WU50RlBNdncxU04rYWo4ekFEeXE0NU9VajlZZm53NzNyZnpSN3VlVHkwdlQw?=
 =?utf-8?B?TDNCM2gxUjgvSXR4dXk4c2czTUtpdWJGOHFaYzI3Vm55VUFaK0NDUjVNRStV?=
 =?utf-8?B?YnZreGxONWxOMTArQjN1SkM1MCtvbU1pb3g1S0had24xSURyeDNXYitaWGJS?=
 =?utf-8?B?bmZta2hINUdhRU42V1dMWE51b2FRYnN4RkhwYVl3UksrMW5RczA4VVlQMTFS?=
 =?utf-8?B?Znd1NUZrU1FOUFBmbmlDdFIxTUtKcmFPZUd2eWZIOGFBVHFNUmdXR0RJWklO?=
 =?utf-8?B?UTZGcFZnQ2R3U0d6NEs0Q3k4WXFkajRoY1lNOGZ4K2ZYbFBvMy81WFI2eFV5?=
 =?utf-8?B?TnRORzZ3QStpcVU5enNHN2J4bjlEK0ZodUNwTEwrUHUwaXlZeGk5TjNYdDl2?=
 =?utf-8?B?SUdEc004aldaUGFQamlhZGZnNnFqMFdPRUh3SU9mN2NYSG1FaGhCK0xJK3hZ?=
 =?utf-8?B?OFBzWURxRXVOTGh1Q2c3Wm5JMElKNHBRR0RrSk9Ib0Ixa0g4aU9aMWFlTXdp?=
 =?utf-8?B?YytlR012SHovSVp2eVhrU2FMbmtQd0RFTFUyck1nK2NBOWlWTnVQY0FnVHEr?=
 =?utf-8?B?VGovcDM3OUs3VldIa3RtWmdLOVFHUUcyY3FqRG5mYXZnbHpoUzZRQlVIODhX?=
 =?utf-8?B?dFBrS1ZKbEYrMCtwR1Rrb1lsL2svNVArVXRPbDcxanRpTC91aFZOWVdoUGFM?=
 =?utf-8?B?N0JyZ3l4RHVsU2xlMjcyRlJNWG83N3ZvcU5Dc1hVcWxrWW1jVzZWcVE1a2Rq?=
 =?utf-8?B?cE5CV3pOV0Naa20wWDIvYStTTDdXRE1lOFZ1YWh5Yml2Umx2RS8wd0JkOWVK?=
 =?utf-8?B?RWl5NHU4RVRDRnFyMjRGWGVmdzRuenZJakpTYVR0VTFQdy9tUjBzVjJmMU1Z?=
 =?utf-8?B?MXU0VFIvWW1DOEVkalNBMUp3eGlQN1hSbjIzclFkcGg0TG1FUnFMS2FaREhO?=
 =?utf-8?B?cXhucUY0a1RuZnF0S2NNMzFVZ1RIOTR5WlFMTm5vV2pPbXpRajF5Sk45STFz?=
 =?utf-8?B?RVdqb1lFWnU5NGM4dmhXOVdXSHdqRnVhVWEzd0sybXRTM3M2RE5YOS84Z0RF?=
 =?utf-8?B?OG1FTFpHdFN1WjZycUcxb3N2NituSjByRksrVUNIMmZMRXB6Y1JON0YxelFx?=
 =?utf-8?B?aE5ZU20zVTJlbDZVdEQ4Y3RYRE5UNVFCMnl1KzR2cWY3dHd1U3Fyd1dxTzlB?=
 =?utf-8?B?bEo2bDFDTDF4RXN1cDRaU243VTZQK2pDVE1jSlNiRlExejFCM0taVGNtcGpR?=
 =?utf-8?B?aS8wT21uTjIxbHVmT1lpWHEyem44Q3gwMXQybkNyMHJseTRoSXduK2xFM2Jr?=
 =?utf-8?B?YnFHbFBndXB3Y09nYzZ4TXBHRm5GZkprbzYvSjBoUytYeC9ESEN4SUk5KytD?=
 =?utf-8?B?ZVlQS2RnKzB0ZFR6OWluV0xSbUgwVXNBYW9ualVBNzZQZnR3SWh2U0hHNjJv?=
 =?utf-8?B?eVpjZXE0ZzgxVjRwNG5QZE0rWUNrdENCM0FQdHBKbGUwY0JIaHV1VzEwUldp?=
 =?utf-8?Q?TiLrs5KpfAunBM1yfs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96c3a47-70a7-4a7a-d7cf-08df24e4c3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 02:35:06.8462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJSEnyGRxlw5Eqmonb/GB+hPgg88q7R762Gr8q7CdGes4yKDzcKEGb6JlH2UxB+NglSAvjOxwS0hjLlRu5xYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

QU1EIEdlbmVyYWwNCg0KUmV2aWV3ZWQtYnk6IFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQu
Y29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpUaG9tYXMNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBIb25nLCBDaGkgPENoaS5Ib25nQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgT2N0
b2JlciA4LCAyMDI2IDEwOjAxIEFNDQpUbzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaG91MSwgVGFvIDxUYW8uWmhvdTFA
YW1kLmNvbT47IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCkNjOiBaaGFuZywg
SGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWmhhbmcsIFRpYW50aWFuIChDZWxpbmUp
IDxUaWFudGlhbi5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZC9y
YXM6IHNraXAgUkFTIFRBIGZpcm13YXJlIHJlbG9hZCBvbiByZXN1bWUgZm9yIFNSLUlPViBWRnMN
Cg0KQU1EIEdlbmVyYWwNCg0KSGkNCg0KQENoYWksIFRob21hc0BaaG91MSwgVGFvLiBQbGVhc2Ug
dGFrZSBhIGxvb2sgYXQgdGhpcyBwYXRjaC4NCg0KVGhhbmtzLA0KQ2hpDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0K
U2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMzAsIDIwMjYgNzoyNiBQTQ0KVG86IEhvbmcsIENo
aSA8Q2hpLkhvbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFpoYW5nLCBUaWFudGlhbiAo
Q2VsaW5lKSA8VGlhbnRpYW4uWmhhbmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBh
bWQuY29tPjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZC9yYXM6IHNraXAgUkFTIFRBIGZpcm13YXJlIHJlbG9hZCBvbiByZXN1
bWUgZm9yIFNSLUlPViBWRnMNCg0KY2M6IFRhby9UaG9tYXMgdG8gdGFrZSBhIGxvb2suDQoNClRo
YW5rcywNCkxpam8NCg0KT24gMjktU2VwLTI2IDEyOjU1IFBNLCBIb25nLCBDaGkgd3JvdGU6DQo+
IEFNRCBHZW5lcmFsDQo+DQo+IFBpbmcNCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogQ2hpIEhvbmcgPENoaS5Ib25nQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2Vw
dGVtYmVyIDI4LCAyMDI2IDI6MTIgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBIb25nLCBDaGkgPENoaS5Ib25nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SF0gZHJtL2FtZC9yYXM6IHNraXAgUkFTIFRBIGZpcm13YXJlIHJlbG9hZCBvbiByZXN1bWUgZm9y
IFNSLUlPViBWRnMNCj4NCj4gU1ItSU9WIFZGcyB1c2UgYW1kZ3B1X3ZpcnRfcmFzX2h3X2luaXQo
KSB3aGljaCBza2lwcyByYXNfY29yZV9od19pbml0KCksIGxlYXZpbmcgZndfZ3B1X21lbSB1bmFs
bG9jYXRlZC4gcmFzX3BzcF9yZWxvYWRfZmlybXdhcmVzKCkgdGhlbiBoaXRzIHRoZSBOVUxMIGJ1
ZmZlciBhbmQgcmV0dXJucyAtRU5PTUVNICgtMTIpIGZvciBldmVyeSBWRiBvbiByZXN1bWUsIGFi
b3J0aW5nDQo+IGlwX3Jlc3VtZV9waGFzZTIgYmVmb3JlIGFtZGdwdV9mZW5jZV9kcml2ZXJfaHdf
aW5pdCgpIHJ1bnMuIFRoZSBuZXh0IGhpYmVybmF0ZSBkb3VibGUtcHV0cyBJUlEgcmVmY291bnRz
IGNhdXNpbmcgYSBXQVJOIHN0b3JtLg0KPg0KPiBTa2lwIHRoZSByZWxvYWQgZm9yIFZGcyAtIHRo
ZXJlIGlzIG5vdGhpbmcgbG9jYWwgdG8gcmVsb2FkLiBUaGUgcG9zdC1yZXNldCBwYXRoIChhbWRn
cHVfcmFzX21ncl9yZXN1bWVfYWZ0ZXJfcmVzZXQpIGlzIHVuYWZmZWN0ZWQuDQo+DQo+IEZpeGVz
OiA1ZTViZTU2YTViNzYgKCJkcm0vYW1kZ3B1L3JhczogcmVsb2FkIFJBUyBUQSBmcm9tIHJhcyBt
Z3IgcmVzdW1lIikNCj4gU2lnbmVkLW9mZi1ieTogQ2hpIEhvbmcgPENoaS5Ib25nQGFtZC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc19tZ3IvYW1kZ3B1X3Jhc19t
Z3IuYyB8IDMgKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21n
ci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21nci5jDQo+
IGluZGV4IGEwMjE2NzM5N2NlMi4uNWJhYzc5MjU1NGY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Jhcy9yYXNfbWdyL2FtZGdwdV9yYXNfbWdyLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21nci5jDQo+IEBAIC01MjksNiAr
NTI5LDkgQEAgc3RhdGljIGludCBhbWRncHVfcmFzX21ncl9yZXN1bWUoc3RydWN0IGFtZGdwdV9p
cF9ibG9jayAqaXBfYmxvY2spDQo+ICAgICAgICAgIGlmICghcmFzX21nci0+cmFzX2lzX3JlYWR5
KQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPg0KPiArICAgICAgIGlmIChhbWRncHVf
c3Jpb3ZfdmYoYWRldikpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgICAg
ICAgICByZXQgPSByYXNfcHNwX3JlbG9hZF9maXJtd2FyZXMocmFzX21nci0+cmFzX2NvcmUsIDAp
Ow0KPiAgICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgIFJBU19ERVZfRVJSKGFk
ZXYsDQo+IC0tDQo+IDIuNDMuMA0KDQoNCg==
