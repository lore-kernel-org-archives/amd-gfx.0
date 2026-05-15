Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF26CD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 07:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09E310E096;
	Fri, 15 May 2026 07:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aQ8bYWqg";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010051.outbound.protection.outlook.com
 [40.93.198.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B6410E096
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 07:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBxxgkE451BXOF9Re46CI2xNXGvbYXJlpXvOBzEjhN7ow7Ftjpu4dq5xiY2LIurzM/fj6BpRWbfV8/RfjqV7ZShkXVJBIVLkfB4LRIAVVC29m2mvitjkVpVfwttL2ClvkdoeW6UhcdL80oVVJqAEOCeuvrUNOMdfaoyXeJpXbhQkcTdFIIEdPu3xAMz7ZfVXmkDbeRNShR+jopN9p95On8e8V350EGUd7nlk2Nj26CTI/pcvcMH/yTeem3HSjY20iaVZyKv0u07XXANaitRMdrFjbfRep2yVduBYd4SdcbPXU+K1JNZsN5qMrr73Ou32iBm8xyKFN1rSGLjvz4WHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i0U7I1+KZfeJ2fGg5xMOCFI/GVjRexkyEcm36frSR4=;
 b=lUhkUiKdmyUx6T84gxOpx8YsEXjEjYiVpsOddw4TGsRoGPc/+iOxL1hBOGqmR/xLi/pb64q+VhmVusU8XsUDheb6mYuFDYxh/aM3yH2kpXfs98RGdJdp6e3aoo4u0bKmbw/tj3fn+Rp9xYBICRf0jcX+sb0ZcF/bwwXhJjEjNffrfv8t1qLq7N6PWR5YJUT+jy0nGfDYH/O7NWlygzS61qqrklOlaAqWBhB52Zf616R+78ORqSz08pU+MsKOeRdlsYVnHrAOzdKoNGaWDv0eYB22EsAsbpkBc3XLRZ4i7vDM2j+SQ1iZbzuM3d8uu3kfjtfMp1VTvzgZjSXCnpgHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i0U7I1+KZfeJ2fGg5xMOCFI/GVjRexkyEcm36frSR4=;
 b=aQ8bYWqgCCY/ngRxkgZd6OxfBymF3hQvG9OC4DwfkgKmwQKC7KiqGEy9TeHYXzFNpWTGHZAqf5XuQOkZw5NQBq0CPZheomoMsFtLikE9HOY1ayqf1Tk5GHRwVanApYIa2EbSkdG+wPCRKQSUGdVk4xIfC227CTk5xqTNGysDp2g=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.19; Fri, 15 May 2026 07:23:36 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 07:23:36 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Topic: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Index: AQHc4585QHymMJ9kqUu5GNrLN/0ywrYOXkAwgAAnyoCAACBMwA==
Date: Fri, 15 May 2026 07:23:35 +0000
Message-ID: <DS7PR12MB6005ED72EF2E1E040BF268F2FB042@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
 <20260514124250.3833711-2-Prike.Liang@amd.com>
 <DS7PR12MB60058DE56534CDD21A0817D3FB042@DS7PR12MB6005.namprd12.prod.outlook.com>
 <82242212-0878-40c1-b6c4-73d02c25ad82@amd.com>
In-Reply-To: <82242212-0878-40c1-b6c4-73d02c25ad82@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-15T06:48:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN6PR12MB8543:EE_
x-ms-office365-filtering-correlation-id: 8b73d136-9f2e-44a5-5be8-08deb252e0b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003|4143699003|11063799003;
x-microsoft-antispam-message-info: e0/fyiTU365VRVtsBdTtf/dMZ7XY6ikz3ymjC6TxadoP0uHXq6uxuRbxv6iPrEFhdsNYfhWuoT93vIAFt0db+wHu0MwqxDtJraIrVB3Aqtf14sVmu0DTRYPxdxdY4uCRD+ws1w8jk3WSDL2sq0tHm3vcq7SKos5/bcsDFdgvANwgfpkYixkA3dv9NZzDSo1YKonEGgACZoQwlWlG7RqEhtHnD1L3TZgw0wkdCI5CB1nAeCDql+G3wAnUmhlGzueXubf7qGrEO9Cs3UE0Fn2AGQsR16m41654hM9u+t6Af0VqDly8jQfOTc8uGjGCUcvHjW1EDnxynypQFzduQtpeyksUejfsl0kUok54NdKTGewEnsBoEqFrdWzd0W2wOX6GUavU4pw41C4aQ1VS0yVBBGx/x2I1AgvKQkLjMQ86sAAI7IPsZaEu6qzYqKSmdpkloG+wn3NUzR7g2byDf7cUYRVaG6bBQxgC+eaLmAn+S1NnwpJeOHBAVsnn+nKSS/aZ7miVVZM0ajLafeOB4fn9dHOptq6jYm2h1txJzzOQWsD5NR2uHDOzhEtldu30zb1RAiSj9LLRsxQUvLPl+a7chMLv4ittjIQLRR70jaZH7XEV1soTkL763G4MIAtQZ+JXoEYh7a6z4xQNfth65y2uSTrlO6kzd+GnCBDzas4q9OnKYdeYdJt8V+acrivgWTmwqgOaM5fbyASAM0/8geApPT9KMbf6OEg1G4WpjXZEPX6R1SkpvbfZtR4F2paScLSe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTgrakNUU2FBOW03akh0L1VEVE1FVml6eU43TnJiME84WElUZ0VSNHlOZzhM?=
 =?utf-8?B?a05FU05RaHBFYU1jYmhlN3RFSWNYMi80djlIV0dQVlVRRnA5Z2J6dHViMU5W?=
 =?utf-8?B?c3NKSy9SVzlocnZOMExuRzF3SmFORWlzcHU0emhZRGRueUxUdmoyTUk3TElG?=
 =?utf-8?B?Y0hsb3pteWdBak1KZ3UzamthRlpManhEL2RFYThUamEwM05FanFFVHlaaUh3?=
 =?utf-8?B?TENnZ1NZdlQrc3liMlZjU2JwZnJWeTVBUHVaK3ZxYmc1UXdhWlA3RVAyZVJo?=
 =?utf-8?B?YS91QXh0Z0xWeDRaNGVFMHkrZkI0WER2M2N0US9ydmo2TGpmcHlkSTVHdVli?=
 =?utf-8?B?aFlIQWF2TmlzSE9vTkxmS2xiejJDYXd1anh6QXZqc2ZUSldqeXpWV0Q2WXIr?=
 =?utf-8?B?emwzYWhLWExkQ016THc3YjIvQTFJN05JVCtCN0hjNExyTVpiNmRtNU5Gbi8v?=
 =?utf-8?B?emk4aW54SGRwV3VoakpjY3JnUlA2ZS94TENHODk1cFloQUZNNktuR0tGYkNx?=
 =?utf-8?B?MGlNZUw1YW00eVlLMC9HRTRYUitJSjBwZmo4bjU3bUFsUVdlaVFuSHVZTlg0?=
 =?utf-8?B?MlNOTVNtMENaSElwNnBvN0JTS05uNlowZzd1anljR0htQmxDL0p2RnVhTURP?=
 =?utf-8?B?OERKNWhPQXBCcmQxZGxHbE5rNmxWb2VZcDd0Nms4OHdTcnA5aUxRU1VvZW9v?=
 =?utf-8?B?R284UjJUbS96SHhrTHdQSk5KVG15aitVR1BKTHR6VmNxdEpDWnYzalF0c2Nw?=
 =?utf-8?B?QTFWbXJrSW02RzNITlZOaVRRZjJlQ0Zpcy9OR3BUa3BtcEl6S1NFQnhuMUs3?=
 =?utf-8?B?MU5MZGNjSS9JNFhiNWdIUk1iM0xBR1M2ZFY1S2tZSDdxTDd4VzArWlQxUmpy?=
 =?utf-8?B?ZmQrRkFKVkRXa05ZQzUyTjlqc2dyZ0EwNzhUbXorblJ4S2x2Qkl4U0V0NUNP?=
 =?utf-8?B?KzlyQVc0bjhTTXZNL0E5RHdpeWVFUnVxY2JZY0xCWE94dW5IR1VOUmdKWkk4?=
 =?utf-8?B?VWpWS1JMRG01bkxQZFhoZGdqdnFSZmJSR0MyMEtPRWp4S1VVbE4vZjRpZjd2?=
 =?utf-8?B?YzMvOHNLYnVDRDZnb1BkM1d2a3ZqUkFObU5kZXl6MnBjaEU3UjJuVEJBaHdr?=
 =?utf-8?B?eFdxcHVNV1NLMitWdmpwMW5XNFlyRkFCYUtBUlF1dGkxaDZzUGlmVXRvYzJn?=
 =?utf-8?B?Z0t3TEY4ODY5VHJqbW9KOE5vZVp6YzQvL2pvc3g4aWVoalcva20rdWlLK25L?=
 =?utf-8?B?cWJXNktOZDRIZGx2MjZwakZUa2Y1T2lWQlpqQUNNRVJPempWNzJYVElFVmE2?=
 =?utf-8?B?Nk5HWXRvOENFUWZwRDRFK1FmSUhBMzJXRk1LVzlvTjJTUnF2UHFhZEkvQlBl?=
 =?utf-8?B?elp5MVRSOXJTa3JhbnU1NFA2bHFwOXEyVXlKQXZCQjNJdnZJSEkySEM1YjFM?=
 =?utf-8?B?UitqaURYMTZUbUlwUEY5cjNXNWhnOHcyT1NWQU8rTERwaUNEM1Flb1pwYVo2?=
 =?utf-8?B?ajBLM3pqYnNmMlBCN0NJMkVraFpsL25oMmRiN0ZxRjg3S25yTWNMalo4WnpR?=
 =?utf-8?B?K2wyT0VCVlVQaHVnUWdKbTgvbmkrYVlBSURoajdOaVp3Rk81djJsRnJkUitx?=
 =?utf-8?B?U2l1TWdUcE5ObXdiN2MxQ29MczlMenlWWm9CTGxBRTVYbVlxT20ySDFXS0dH?=
 =?utf-8?B?ZXg5RU9LRFJQNGEyS01ucWoxeEtzY3lLTEtaUCsxbFlDS0xla2ZmbVVEbmtw?=
 =?utf-8?B?Y3NIVUo0a2J4Um9CZEViV2lIaFJqdzNsSzV0S0xoaDdJelF3TnBQVFZQSUNV?=
 =?utf-8?B?bmxkNWxtWHRSUmVKVGZYYW1JOWs1Mlp4dkV0YS9jRjYvam1RUlQwNnYvMGFD?=
 =?utf-8?B?QTBuQzZPWXJneUpDaG5oT09EWDFhY2FHM1lqdlRKZUV3OEwxOE5wSGRTVHpp?=
 =?utf-8?B?TUFQWHZvV01Xbk1UR2VlQVN2VG9kbEdzbHJQMjV2d0R3ajhGUWNVK3E0QjQy?=
 =?utf-8?B?Y3Q0VUFLK0JtUEhBTDd6WUZhb21IVHoxZFNrVkRVaThpMDlkdEIyN0ZScDRV?=
 =?utf-8?B?MjA4cEIzUDY0RDNYM1dKNDRTNlZtOU5pR0ZPN1ZXeTVZZ25COG5mVmM1QUMy?=
 =?utf-8?B?OVF6S1ZFVngwRk5YejRkTjJwcXl6NnlxRVBrQ2NMeGxzUHBsb0xaYkJ6RnIr?=
 =?utf-8?B?SWVoS2VnMSs2VXVTY3VtejRRV1N4Rjh2RjdnTDhCS3c4S2MwVzZqRGIwemNk?=
 =?utf-8?B?WEsybzhCUTlUVUw5SmxWTTRmdUNRNVBNcElCSEdRUlNYYU1yZ1dvLytObnZG?=
 =?utf-8?Q?+jwDzBqTLfCIkXKLtH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b73d136-9f2e-44a5-5be8-08deb252e0b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 07:23:35.9807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpHKejHTuAlkrIdXQ5fK3oBYl9WN78ENiPCBiL08NOXTqqLNrU7xDlxlpEzHuIHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+
DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDE1LCAyMDI2IDEyOjUzIFBNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IHVubWFwIHVzZXJxIGZvciBldmljdGluZyB1c2Vy
IHF1ZXVlDQo+DQo+DQo+IE9uIDE1LTA1LTIwMjYgMDg6MDAgYW0sIExpYW5nLCBQcmlrZSB3cm90
ZToNCj4gPiBBTUQgR2VuZXJhbA0KPiA+DQo+ID4gV2lsbCByZXNlbnQgYSBuZXcgdmVyc2lvbiBm
b3IgdXBkYXRpbmcgdGhlIGNvbW1pdCBsb2cuDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+ICAgICAg
ICBQcmlrZQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXks
IE1heSAxNCwgMjAyNiA4OjQzIFBNDQo+ID4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiA+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENI
IDIvMl0gZHJtL2FtZGdwdTogdW5tYXAgdXNlcnEgZm9yIGV2aWN0aW5nIHVzZXIgcXVldWUNCj4g
Pj4NCj4gPj4gSWYgdGhlIGRyaXZlciBvbmx5IHByZWVtcHRzIHF1ZXVlcywgdGhlcmUgY2FuIHN0
aWxsIGJlIGluZmxpZ2h0DQo+ID4+IHdhdmVzLCBwZW5kaW5nIGRpc3BhdGNoIHN0YXRlLCBvciBy
ZXN1bWUvcmVkaXNwYXRjaCBwb3NzaWJpbGl0eSB0aWVkDQo+ID4+IHRvIHRoZSBzYW1lIHF1ZXVl
LiBUaGVuIHRoZSBWTS9UVE0gc2lkZSBtYXkgcHJvY2VlZCB0byBtb3ZlL3VubWFwDQo+ID4+IHF1
ZXVlIHJlbGF0ZWQgQk9zIGR1cmluZyBldmljdGluZyB0aGUgcXVldWUgd2hpbGUgc2hhZGVyIFRD
UCBjbGllbnRzIHN0aWxsIG5lZWQNCj4gdG8gYWNjZXNzIHRoZW0uDQo+ID4+DQo+ID4+IFNvIGZv
ciBldmljdGlvbiwgdW5tYXAgaXMgc2FmZXIgYmVjYXVzZSBpdCBtYWtlcyB0aGUgcXVldWUNCj4g
Pj4gbm9ucnVubmFibGUgYmVmb3JlIG1lbW9yeSBiYWNraW5nIGlzIGludmFsaWRhdGVkLiBNZWFu
d2hpbGUsIGZvciBhDQo+ID4+IGlkbGUgcXVldWUgaXQncyBtb3JlIHN1dGlhYmxlIGZvciB1bm1h
cHBpbmcgaXQgcmF0aGVyIHByZWVtcHQgYW5kDQo+ID4+IHVubWFwcGluZyBhbHNvIHNhZmUgbW9y
ZSBwcm9jZXNzaW5nIHRpbWUgdGhhbiBwcmVlbXB0Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMgfCA0ICsrLS0NCj4gPj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMN
Cj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+PiBp
bmRleCAyZTNlZGI2ZGQ1MDYuLmE2M2RmZGZhNDE5NSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPj4gQEAgLTEwNDgsNyArMTA0OCw3
IEBAIGFtZGdwdV91c2VycV9yZXN0b3JlX2FsbChzdHJ1Y3QNCj4gPj4gYW1kZ3B1X3VzZXJxX21n
cg0KPiA+PiAqdXFfbWdyKQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0K
PiA+PiAgICAgICAgICAgICAgICB9DQo+ID4+DQo+ID4+IC0gICAgICAgICAgICAgciA9IGFtZGdw
dV91c2VycV9yZXN0b3JlX2hlbHBlcihxdWV1ZSk7DQo+ID4+ICsgICAgICAgICAgICAgciA9IGFt
ZGdwdV91c2VycV9tYXBfaGVscGVyKHF1ZXVlKTsNCj4gQXMgcGVyIG15IHVuZGVyc3RhbmRpbmcs
IHdlIGFyZW50IGRvbmUgZm9yIHRoZSBxdWV1ZSBhbmQgYWxsIHRoZSByZXNvdXJjZXMgb2YgdGhl
DQo+IHNob3VsZCByZW1haW4gaW50YWN0LiBBIHF1ZXVlIGlkZWFsbHkgc2hvdWxkIG9ubHkgbmVl
ZCAiIG1hcHBpbmcvYWRkIG5ldyBxdWV1ZSINCj4gd2hlbiB0aGUgcXVldWUgaXMgY3JlYXRlZCBh
bmQgb25jZSB0aGF0IGlzIGRvbmUgb25seSB0aGUgbGlnaHQgcHJvY2VzcyBvcg0KPiBzdXNwZW5k
L3Jlc3VtZSBzaG91bGQgYmUgZ29vZCBlbm91Z2guIFdlIGRvbnQgd2FudCB0byB0ZWFyIGl0IGRv
d24gb3IgcmVidWlsZA0KPiBhZ2FpbiBmb3IgYW55dGhpbmcgdHJhbnNpZW50Lg0KPg0KPiBSZXN0
b3JlL2V2aWN0IGluIG1vc3Qgb2YgdGhlIGNhc2VzIGlzIGEgdHJhbnNpZW50IHN0YWdlIGFuZCBv
bmx5IGEgdGVhciBkb3duIHNob3VsZA0KPiBiZSB1bm1hcHBpbmcgaXQgb3IgZHVyaW5nIGEgR1BV
IHJlc2V0IHdoaWNoIHJlc2V0IGFsbCB0aGUgaHcgc3RhdGVzLg0KPiBTbyB0aGUgd2F5IGl0IGlz
IHNlZW1zIGxvZ2ljYWwgdG8gbWUgYnV0IGkgbGVhdmUgdGhhdCB0byBDaHJpc3RpYW4gdG8gY29u
ZmlybS4NCg0KRm9yIHRoZSBldmljdGlvbiBjYXNlLCBpdCB3aWxsIGJlIGEgcHJvYmxlbSB3aGVu
IHRoZSB1c2VycSBCT3MgbWlncmF0ZWQgZHVyaW5nIHRoZSBNRVMgdHJ5aW5nIHRvDQpzYXZlIG9y
IGFjY2VzcyB0aGUgcmVzb3VyY2UgZm9yIHByZWVtcHRpbmcgdGhlIHF1ZXVlLiBBbHNvLCB0aGUg
cHJlZW1wdCBvcGVyYXRpb24gZG9lc24ndCBuZWVkIHRvDQp3YWl0IHRoZSBxdWV1ZSB0byBiZSBp
ZGxlLCBzbyBoZXJlIGNob29zZSB0byB3YWl0IHRoZSBxdWV1ZSB0byBiZSBpZGxlIHRoZW4gaXQn
cyBtb3JlIHN1aXRhYmxlIGZvciB1bm1hcHBpbmcuDQoNCj4gUmVnYXJkcw0KPiBTdW5pbCBLaGF0
cmkNCj4gPj4gICAgICAgICAgICAgICAgaWYgKHIpDQo+ID4+ICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0ID0gcjsNCj4gPj4NCj4gPj4gQEAgLTEyODUsNyArMTI4NSw3IEBAIGFtZGdwdV91c2Vy
cV9ldmljdF9hbGwoc3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4gPj4gKnVxX21ncikNCj4gPj4N
Cj4gPj4gICAgICAgIC8qIFRyeSB0byB1bm1hcCBhbGwgdGhlIHF1ZXVlcyBpbiB0aGlzIHByb2Nl
c3MgY3R4ICovDQo+ID4+ICAgICAgICB4YV9mb3JfZWFjaCgmdXFfbWdyLT51c2VycV94YSwgcXVl
dWVfaWQsIHF1ZXVlKSB7DQo+ID4+IC0gICAgICAgICAgICAgciA9IGFtZGdwdV91c2VycV9wcmVl
bXB0X2hlbHBlcihxdWV1ZSk7DQo+ID4+ICsgICAgICAgICAgICAgciA9IGFtZGdwdV91c2VycV91
bm1hcF9oZWxwZXIocXVldWUpOw0KPiA+PiAgICAgICAgICAgICAgICBpZiAocikNCj4gPj4gICAg
ICAgICAgICAgICAgICAgICAgICByZXQgPSByOw0KPiA+PiAgICAgICAgfQ0KPiA+PiAtLQ0KPiA+
PiAyLjM0LjENCg==
