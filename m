Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3784DC43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 16:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14EA10E62F;
	Fri,  3 Jul 2026 16:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vL69nxpA";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C021710E62F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 16:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB30IaycDs306OwIG/HwhhjuI744PupW0vhwgNtM1cgMItazn+7ejJM3ZnFZQhUI+qP6gP/GGQta6woNR9SQOG5p/NRsKHn+tIaZS8n/o8t7saVq4oBMrHYzZPui1QBosJoD1wAWByEM2fb4bOOsQWWM6TEjMUmygib5v9NhfsmUnFxY9xXnBdubiwr35RBQH4K6SZt7iAyOU+2A3/JgCpiTuRbhCVMGKfDj/YnZcwzQfttGZcTWcFcmsFAE6mptdRWNTuwbNAxqhqtol12qfq1HiNKP+4Y3DNvJk3ThMpbQ9pMCJJhLXh2nM1XnyQysyQrh1rsjesbLNyrW8krIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwvJfp9IStjqpAUD11RXmXnAVzaGlEkrePXY+zDnkH8=;
 b=CJgX6PMcV1l30E/TLs+gVxRTFfHnu2Ll/BX8IyvIpTkdpvuZK7g3M9OY38H91xanMCr2EDS1UOyJa1JUYSMqIcW3g7uqricbTPRAuRQJK7Y066mxcodu3vrUgr7HD71GhqwPRx1D14si8/u0ydYmEZjqpOuvHm+HW/CnbdE8ggEz79+1sFrePAB+29u6woUVMYqeDFLXQEVFlvprKU8hPlsXVNWZo+OYxvGo1kgB1DKsSJXLY6TfyRzpgVONoWxLXedHGpFDlCKinnd/IMjkbKe4UWfr0S7xy7nzXJU6bmpYz1qyvIjXGjAMt9A/Z2yCc5h4xdpOG135d0yivzr9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwvJfp9IStjqpAUD11RXmXnAVzaGlEkrePXY+zDnkH8=;
 b=vL69nxpAY5g1MhHFNNtD4EzC8wcO5sOV2Zpv97ZG/nOSX0dEcNTbIXQhqErVo339mRd4TBm3fe9kngoU3enHA7NNzvGYqnzcihX5r1ODaAD32dAaVrWrfDvf5m8LvuSqaOifo6P4RsHACFHjbJq8FYSR5QBWe3JgBGXrpOfBtt0=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 16:31:13 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 16:31:13 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Natalie Vock <natalie.vock@gmx.de>, "Shetaia,
 Amir" <Amir.Shetaia@amd.com>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "He, Siwei" <Siwei.He@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell
 for retry CAM on IH 7.0
Thread-Topic: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell
 for retry CAM on IH 7.0
Thread-Index: AQHdCXUveB3zQ9WQh0KlDFNEzCPVhbZb/tEQ
Date: Fri, 3 Jul 2026 16:31:12 +0000
Message-ID: <BL3PR12MB64256E6E84188CD2CCAB6C09EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-13-timur.kristof@gmail.com>
In-Reply-To: <20260701161721.85681-13-timur.kristof@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-03T16:27:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|BL3PR12MB6593:EE_
x-ms-office365-filtering-correlation-id: 7c56f74d-b8e3-40b3-6b12-08ded9207f2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|4143699003|18002099003|11063799006|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: EZHxxp5VD2L1xfkSjkQFdjQ2Toe8GEwbXTO+kjQQBBDC+YRTKlRz1pp4etK8OHUM8cCKYqAlTtfjRnITZTkTrnukBtSPxjywtDoJUIScphRG0XwWa4Lna8tfJegwpu1GfSLZJPTILSFqMYwLti0Ys/POjpjxKgKF1qlxk7Ch5NLT943gAH+3efVSojaPxu63GVMCOu3/F2ztWr9TedJWhn1d7yCa1WVuKR2/8BgHLt49tqkAMueb4eo47eH0pPnPUETwQwPR82cd+CF+lv4fmI3pR0zQWeUAHbUoZmzKGCbIrPOyIx/xjoW6kXP3DpCdNVhxEm+uGGZK1u12GKY1ZbaWuk4TuW3hH57qu6G3mv0xxXbfODX+B9vM/i9wFve9IPuzHIMIF8UGJQpUrd9AkTdzzFt4DfDl38Bzcs+11LqsBCELdX21vuUE+i1/xhbWb2Mgx7HV/eWmx8t3/CGcdMF1d6xsWtjCBvkXi5UZa+sMD9+GOgEMaBn76q5flRMT826QZSEcxmuMTqQut20wYBEQ5eOsSb+LA3/FkG4kIP3PZXORQD+yaup28HfistD7tKKq5VIbxEpAB1JLA4PVMHpr98HTXsXSjmLxUpQW6SZIUSMxbJ/DofBZUchF4/GzKvYgfFM1xk13qB2pCVFCBMYSZLJZ6ysTC9qyz0uN0oyMvAKyj6cQTmF2zH/73UcB1dqMgytn6kIxiIEL4UY8M7JxtybNyOu/19QhoER3UeJcuGwa3OY1eauo6m63ii8u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTY2VWdlcU9qZFhHTkcwY250L1MyOUtJd2xicTVZdWFBRkpPdTVNempEazZm?=
 =?utf-8?B?SDhHZVZ0cDM5aG9rNFVVQSt2dFVOUEtIcmVIQkw5MGtXVTdkY3pYNnBtblZ0?=
 =?utf-8?B?dXpaalliUEJLeElhNXlkS0hwWkJBSWZ1WS82dVoyQXlQSm82aU5INzFuWThu?=
 =?utf-8?B?cG8yaFVGSHNNVURWWCt6OEtPOVU1cFlPelc5Z1orZEo1UGpOVmNhd0E5VHJL?=
 =?utf-8?B?MkYweXlvd0JLUng3RFpEa21nY2pYeHNqdHpyOGVORW9WQ0E3MDVvTVJFUVQ5?=
 =?utf-8?B?OGlLOTJxY3FjSVBYRDEvdGhiVmZGdzdiSG05dXBVcDRMd3lINW1hVWFuYlRL?=
 =?utf-8?B?Nk5vZkF0eCthZTZteVk3WTdUSVpHUDJRcmkyTWxpZ3BpRVRzcnpHd1VXai9H?=
 =?utf-8?B?MG5UaFFGWkhoVFlPaGRyN1FGU0N6TlNpQlltRGpvMENtSkxvVkF5Qi9uWUdG?=
 =?utf-8?B?SFM3elc1cjl0U1NEUGd4VS9rZFFKc0RSMkhkRWtPaEwwQktOT3RySmowVk8r?=
 =?utf-8?B?cnJyU3IxMzdOVHY5ZHhyUnh4ekswMng2bGV1ZExLckx1cUcxQStzcWtGNU84?=
 =?utf-8?B?bmNwUjVyTDd4ZXVBS2lqcjNqQ1RQTDFVbjdKMDBlNEdxTUo3QnZFajBaZHdW?=
 =?utf-8?B?azFJTUZ6aUovSlZtajR4WFFST092MGdTcDl5NzdKd2tYelRXM0ZwQ3piSS9s?=
 =?utf-8?B?enRxTnlRRGlWUE9BOTRvRWJtbnNKUjNVdStHNGJna0ZsekR5Rzk5TEJTTDZR?=
 =?utf-8?B?eTVnSkNOV2IwMW90YU9uOWJmMWtFdStaMVNUUFpvNUN5MFU2VEREYVJtR1lw?=
 =?utf-8?B?MStzcDQrdGttalBZVml2ZGdkWkE0MVBZRmUzS2QvUmMxZDk2cGIwZSszRzJV?=
 =?utf-8?B?ZHd4NnBIUDFiczUrbDExY0ZnWWVTQ0ZOSmNPNVh0VDF6cmh2WFJOY3plT3V4?=
 =?utf-8?B?Y0NTbEZqeHNSazZaR1RZYXlBazA5K1hHdXNNeFpOYVpJSG1DUk9qQ05ZMmNX?=
 =?utf-8?B?eFdmZEV2UjcrT0RKelROKzAybzNaOXZHeFpBN2V5dDlMeStKeWtEc0hMUTRq?=
 =?utf-8?B?Q1c4RXdwODdzTmZtVVFVaHZNKzlqcC9pQm9EYytUYjhnZ0RxK2ZHbTI2N3Rt?=
 =?utf-8?B?V0YzcWN3aHFhbkw2ZnVReENMVGZQVENwRk5DbFVLWVdmVWZvRFZvLzkvakxz?=
 =?utf-8?B?Y1U5U3lSVUFEWVh2MEIxQzhJNXJHK2VBVkpIekF3VmkzWGZRTjdGVFV0LzYx?=
 =?utf-8?B?UHVQTXRBN3BlNGpXZkU4OWdwVGxmRnh5RFVTQkUzemIyOCtJMnorZWxLci9x?=
 =?utf-8?B?eVdYaUV0Y2E2MU5YQS9GcjBWYXJzeDVkZSt6SVJWUDk5WVJzQ3RJS2ZyY0tz?=
 =?utf-8?B?ekhYYi9mdWxRWXpBcTFicmNGa2gyYSswZFFHSG14UGx3MFFHTE9TbFoxaEgz?=
 =?utf-8?B?ZmxGc3dveUlaN3FUa1ZDWXJXangwajQ0V3NDNjROUDgvUXc1RkF3UkRUNndx?=
 =?utf-8?B?aU1Bdm1pUHRBcTNQM1kwL3lZRklta3hMWGN2SHc4NUJXTzBMREU3aGkxbTBm?=
 =?utf-8?B?eCs4aDBpc1d3V1h3YW8yVE50N0lVTUZrNnZNV2Y4eDhFNVlJMXBDWDNjWTRD?=
 =?utf-8?B?Yk5EeG5aeWhUTTd2dEwwMkJLa2lSa0xGMjdHNmxJMmw3dGJNdXJYRWNNVmVq?=
 =?utf-8?B?V25PRzdmalNnYjc4Nmp1UHY3TUI2bDJ2UlNFMzNRaElMYzM4d1VYN0t1VTg1?=
 =?utf-8?B?eFFwUjFBdXh2VnZWWnJobkptYzNUaFZNN1pybitqSmpXcmdlazBmaU9yaDBY?=
 =?utf-8?B?dDFGdmN5K010eGdXUU5KSEljc3BET0djS3V0cUIrUWx4WHRUV2dwVWZ1VjdE?=
 =?utf-8?B?cDc0cGNRZzI3NTMyZnlLU2NkOEs3cUtQOS9lMkFtUmpESzdZMGhmeU04YkdF?=
 =?utf-8?B?bWF5NmZRQTdPSUZxRU90RVVHZHhQUWtPcHhkWDU3T1R3Ylpwdk85S2s5elRQ?=
 =?utf-8?B?eEpaUjliTzBrYWlqNVFsNkNCU3RCcXdRZkhSdEczK0xhRWtndDBYV05TdHJu?=
 =?utf-8?B?VDE5TWEwWUtCTjlDaEpwbXBBQzYybHhxOWZRUkd5N21QUW5PaXBOdHhLaW9k?=
 =?utf-8?B?TkFhS0laNC9iMXhtQlNmWGRzYk45U25HSFdSWmlwT1M3SHZhb3JkNitlVVZJ?=
 =?utf-8?B?bnkwOUt5Yk8zSG5uVmZ6cHNkbHc0Z0ZBVnplRFJsV3Z5cXJpQ09uTW5jQmcz?=
 =?utf-8?B?M2VGazlKc1lSZnpyYkxRMTNUT1dLOGl1bHI1V2xUZnZNbXRDNjdCaHRSd0hn?=
 =?utf-8?Q?tKfpjZHpYew+Yt6r+i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c56f74d-b8e3-40b3-6b12-08ded9207f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 16:31:12.8773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lykGL3kq1mnyPYEkQrTxoTbTRhNRo9sElEz5v7cgKk8VVGu2cvnzSswJD0OqHvu8030amNrYR7UT63oIIZE60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQt
Z2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2Yg
VGltdXINCj4gS3Jpc3TDs2YNCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDEsIDIwMjYgMTI6MTcg
UE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTmF0YWxpZSBWb2NrIDxuYXRhbGllLnZvY2tAZ214
LmRlPjsgU2hldGFpYSwNCj4gQW1pciA8QW1pci5TaGV0YWlhQGFtZC5jb20+OyBNYXJlayBPbMWh
w6FrIDxtYXJhZW9AZ21haWwuY29tPjsNCj4gTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1v
bmNpZWxsb0BhbWQuY29tPjsgVHZydGtvIFVyc3VsaW4NCj4gPHR1cnN1bGluQHVyc3VsaW4ubmV0
PjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgTGF6YXIsIExpam8N
Cj4gPExpam8uTGF6YXJAYW1kLmNvbT47IEhlLCBTaXdlaSA8U2l3ZWkuSGVAYW1kLmNvbT47IFlh
bmcsIFBoaWxpcA0KPiA8UGhpbGlwLllhbmdAYW1kLmNvbT47IEpvc2hpLCBNdWt1bCA8TXVrdWwu
Sm9zaGlAYW1kLmNvbT4NCj4gQ2M6IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlzdG9mQGdtYWls
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEyLzE0XSBkcm0vYW1kZ3B1L2loNy4wOiBVc2UgTU1J
TyBBQ0sgaW5zdGVhZCBvZg0KPiBkb29yYmVsbCBmb3IgcmV0cnkgQ0FNIG9uIElIIDcuMA0KPg0K
PiBUaGUgZG9vcmJlbGwgaXMgbm90IHdvcmtpbmcgb24gTmF2aSA0OC4NCj4gVXNlIHRoZSBJSF9S
RVRSWV9DQU1fQUNLIHJlZ2lzdGVyIGp1c3QgbGlrZSBvbiBOYXZpIDN4Lg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBUaW11ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjdfMC5jIHwgMTcgKy0tLS0tLS0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTYgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9paF92N18wLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9paF92N18wLmMNCj4gaW5kZXggZjFkZTY0
NTBhMzFkLi4yOTEzMjZkMmVlOGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2loX3Y3XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9paF92
N18wLmMNCj4gQEAgLTI3OSwxOSArMjc5LDkgQEAgc3RhdGljIGludCBpaF92N18wX2VuYWJsZV9y
aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiAgICAgICByZXR1cm4gMDsNCj4g
IH0NCj4NCj4gLXN0YXRpYyB1aW50MzJfdCBpaF92N18wX3NldHVwX3JldHJ5X2Rvb3JiZWxsKHUz
MiBkb29yYmVsbF9pbmRleCkgLXsNCj4gLSAgICAgdTMyIHZhbCA9IDA7DQo+IC0NCj4gLSAgICAg
dmFsID0gUkVHX1NFVF9GSUVMRCh2YWwsIElIX0RPT1JCRUxMX1JQVFIsIE9GRlNFVCwNCj4gZG9v
cmJlbGxfaW5kZXgpOw0KPiAtICAgICB2YWwgPSBSRUdfU0VUX0ZJRUxEKHZhbCwgSUhfRE9PUkJF
TExfUlBUUiwgRU5BQkxFLCAxKTsNCj4gLQ0KPiAtICAgICByZXR1cm4gdmFsOw0KPiAtfQ0KPiAt
DQo+ICBzdGF0aWMgdm9pZCBpaF92N18wX3JldHJ5X2NhbV9hY2soc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHUzMg0KPiBjYW1faW5kZXgpICB7DQo+IC0gICAgIFdET09SQkVMTDMyKGFkZXYt
PmlycS5yZXRyeV9jYW1fZG9vcmJlbGxfaW5kZXgsIGNhbV9pbmRleCk7DQo+ICsgICAgIFdSRUcz
Ml9TT0MxNShPU1NTWVMsIDAsIHJlZ0lIX1JFVFJZX0NBTV9BQ0ssIGNhbV9pbmRleCk7DQo+ICB9
DQo+DQo+ICAjZGVmaW5lIHJlZ0lIX1JJTkcxX0NMSUVOVF9DRkdfSU5ERVhfVjdfMSAgICAgICAg
ICAgICAweDEyMg0KPiBAQCAtNDAxLDExICszOTEsNiBAQCBzdGF0aWMgaW50IGloX3Y3XzBfaXJx
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYpDQo+ICAgICAgIHBjaV9zZXRfbWFz
dGVyKGFkZXYtPnBkZXYpOw0KPg0KPiAgICAgICBpZiAoYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwg
T1NTU1lTX0hXSVAsIDApID09IElQX1ZFUlNJT04oNywgMSwgMCkpDQo+IHsNCg0KV2UgYXJlIHJl
LXB1cnBvc2luZyB0aGUgSUggNy4wIGZpbGUgZm9yIElIIHY3LjEgc2luY2UgbW9zdCBvZiBpdCBp
cyBzYW1lLg0KVGhlIGNvZGUgYmVpbmcgcmVtb3ZlZCBiZWxvdyBpcyBmb3IgSUggNy4xIGFuZCBu
b3QgNy4wLg0KVXNpbmcgZG9vcmJlbGxzIGZvciBhY2tpbmcgSU5UIENBTSB3b3JrcyBjb21wbGV0
ZWx5IGZpbmUgZm9yIEdGWCAxMi4xIGFuZCBJSCA3LjEuDQpJIHdvdWxkIHJlY29tbWVuZCB0byBk
cm9wIHRoaXMgcGF0Y2guDQoNClJlZ2FyZHMsDQpNdWt1bA0KDQo+IC0gICAgICAgICAgICAgLyog
QWxsb2NhdGUgdGhlIGRvb3JiZWxsIGZvciBJSCBSZXRyeSBDQU0gKi8NCj4gLSAgICAgICAgICAg
ICBhZGV2LT5pcnEucmV0cnlfY2FtX2Rvb3JiZWxsX2luZGV4ID0gKGFkZXYtDQo+ID5kb29yYmVs
bF9pbmRleC5paCArIDIpIDw8IDE7DQo+IC0gICAgICAgICAgICAgV1JFRzMyX1NPQzE1KE9TU1NZ
UywgMCwgcmVnSUhfRE9PUkJFTExfUkVUUllfQ0FNLA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpaF92N18wX3NldHVwX3JldHJ5X2Rvb3JiZWxsKGFkZXYtDQo+ID5pcnEucmV0cnlf
Y2FtX2Rvb3JiZWxsX2luZGV4KSk7DQo+IC0NCj4gICAgICAgICAgICAgICAvKiBFbmFibGUgSUgg
UmV0cnkgQ0FNICovDQo+ICAgICAgICAgICAgICAgdG1wID0gUlJFRzMyX1NPQzE1KE9TU1NZUywg
MCwNCj4gcmVnSUhfUkVUUllfSU5UX0NBTV9DTlRMKTsNCj4gICAgICAgICAgICAgICB0bXAgPSBS
RUdfU0VUX0ZJRUxEKHRtcCwgSUhfUkVUUllfSU5UX0NBTV9DTlRMLA0KPiBFTkFCTEUsIDEpOw0K
PiAtLQ0KPiAyLjU0LjANCg0K
