Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82612CD98C8
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 07:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F107510E79B;
	Wed, 10 Jun 2026 07:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VXrhbXr3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F8F10E790
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 07:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9QNiGXb69jcJ6YI/xvxKqcmyBHJdP/wVhYVBRy0Leevb/WExDOIrwMfJFZ1/fHFWUxTnm/ebGdxNZgA8s0XgUaEX14VamRNczH3rCXWX5Ydd2vCh1IytnDgGfzXyBC/eZjk08iP/R6lhhh7Po7Sj8M+yKygu6QYR2WP1Vsx4Q0K3j4Rc1y2kDTDL52bdHHn8izAzMEednKAQSZcXePiGW+g7EPs0CEILJ9kTGiMyV6Wi410YRC/lYQiMFUIAhngD3YYsS9rCTcncuPUQkB6Ti0DZK5D+iSkqRLP+imLjVDk/YRHLcL0Rp94KRcVRWsI86g4K+2kkalRO7z6sT5lyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBWpINQ2WmqANJpKEhmPjNbYUiJoQeM7Hhu2ZvBmpgg=;
 b=i2vzcIOMlLpIXj3bS5NzCni3Eza/pPwJEteYTdoc5pi9f2bvy/c5/0V1od+/Ww7PIG/UNLYrfvImr3C8a/7Tl24JnvYo1vE5JwPnmflKesurwWD3LchcF6CbdG6DLzrph/9CdmlveLNeWn8uJjBhcZKzpzbU5VXBpekkEK0gdSNBBwzCMv0y8xAxabKcBVfARHmQlfUzaRu2lKO79yz/Kdx+U/j2ZNUcj+qGluCjP694iI23piS2N76BK/fO/MS4JdDGSSv/2BYC8Rr7TIAwYHvWkD8TRfNlsfh+kKpf7gCXfOOiqSdBcqw+X08GG2lhqRvNTpT7SIwfqduM+Q2VzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBWpINQ2WmqANJpKEhmPjNbYUiJoQeM7Hhu2ZvBmpgg=;
 b=VXrhbXr3c8nD8kUFlC87lKzN0pmvXoOCGcGlo/QR32mClEg4FAM4UQJWCCr6Zpo4WbQQTE6gZpB7miCi1kSoEudkkDkyuKnQUsSxQjCIidQXVIxxysdwseQgvVA/4FNHDFq+BjMecgUUCtcfzQmIDKT8El7Rn/HQL2O/qAXLh/o=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 07:58:55 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29%5]) with mapi id 15.21.0092.014; Wed, 10 Jun 2026
 07:58:55 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Trigger" <Trigger.Huang@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
Thread-Topic: [PATCH 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Thread-Index: AQHc+J4XCBgeWze5TkWSE/RQ9Grs47Y3XDaAgACWcwA=
Date: Wed, 10 Jun 2026 07:58:55 +0000
Message-ID: <BL1PR12MB5849050972E9B03F45EEEBC3E71A2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20260610055736.951241-1-Jiqian.Chen@amd.com>
 <aikLYxMZpzhcBKrf@amd.com>
In-Reply-To: <aikLYxMZpzhcBKrf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.21.0092.005)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MW4PR12MB8611:EE_
x-ms-office365-filtering-correlation-id: f314d69e-6386-40e7-c1cf-08dec6c61ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|4143699003|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: Vo7OtI7t4IinNQ55IEtv+yISg1YM8UdAVzrYM6cDSyYTgS0zy5kYeEIinWFsK1tb+sYvdYy+vs+JckqYzG7DHlAkEHUlnvdpm8bBF6ADaoYS4p0RHA86EDBgpsKT42oYTRL9Lbi9eJznd49uJyKn2jJ6CNhWkEG53WV680rAosOdQSRpDjYE/bIPf4s4cVQN2ZjcrcjouMfU335rdJuaxi/YmwYh0NhlwvJQF92tV5kflGFwq5UdbfjYPCEHhLmM5z7gfXT1Y70qzmcL7Kfm3+A+ZjX7NhasWjCvjjCOdtq20yiFIbzAXzQK1zoX9vHKpOdTeGkJftiFaIEaxJz0ty4iYbkKtidb6KG6y++C1Gx/mFzJrDD3UiSXN/QsmzRBwPoNzrb98NbFY+K1Jsg/p9cR6EM3Iuhsx0DGTN1LtyKwf+LloSOApP6639XWdKytM2NJFzfB5VgTHKqMNVV3Ne5F9JNOBva2zwNvjjhTUjo6cct30/V2whM4Wiu+nx2yXwPaLjmGqfn+Q0PkdNGyhrymcQH7jA8wCBC7l/maU1mGlGOznsK2JsMDX2yV1zZEa09OOSuVj4BVx2eAxCeI+TLEJwKwYMw4tabYrAThy0RRDKB35BCWKb/vHtDjFAR3V/pE9vAnfgPVTJ9h5/T3TfipkNWh7w1KD5xSw9TUYnerSuVGy83pAMNGEjKb9AoH32o/YuX0kcXntEMRLZOqRtdRa/AjrQmXLo492FtqkM5HQyBoInrF902wobe82LZk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0dhM1NsZDJCOTlOcVpvcG0vL3FjcHlCN3M5SHAvd1BnTFJlditaZE1hMEdK?=
 =?utf-8?B?aXg2Nmp3cngvdWVEUVBpcGFJNnViNElPSGRVb1BIa25OR3BGU2FZVElHMndu?=
 =?utf-8?B?aTZjNHR3YXR5UE5TQTNSNThmdjgyaTVIdmJFTFpYM2grcDdIQmVhNmxVSmJX?=
 =?utf-8?B?OVJOdWdvVit5ZUVnVTZMMUlWY1JxaWZmYmN1ZDVqQjU5NHRQSkdrU3Bub0RG?=
 =?utf-8?B?azdwb1JzcmZLTHhTeG1WdlFVTnQyQW13eVk0K2c2cmtsVGRCYndqR0xKQTdD?=
 =?utf-8?B?ZXdUNStnVjBEc1pLdXZiczcrM21CQkV1M2s0Tko4STZlUHBNNWgyU1lqTnF5?=
 =?utf-8?B?YTVGVWtTYVRqWWRuZEJxM2RYRVZLaGhvcmZ2U2lnNC9TVjR1dDExV09WdDh0?=
 =?utf-8?B?VGZuQ3BCVzZDUmdkaWNvQWM1NWdXSXhHUHcyRjd0UlRTb1p3NitieElQNmVE?=
 =?utf-8?B?UXlrN0FRaUgwVGh2V0s2RDRGVkRFdm9uWGZJcFU4YktFVW1TWFZ2eWh1VFZI?=
 =?utf-8?B?TmR5VmJLQnhmUGdwKzMxRFN4V291andqb29nK3JDMVUwYzRqVE1wR2JHRTJj?=
 =?utf-8?B?U3htclp5U3kxbDVkZUVGMmFBejA3RHZsNFdvRDl2dlA0bnNzOTIzejF1R0tB?=
 =?utf-8?B?VjhkK015Z3FNbWJPL2ZKUm1HVGw3aFc2eTI5QWJheWdDczlGV2svSVBYbHl0?=
 =?utf-8?B?MmR5QXJsT3h5blErZXRibEVJMDRieFNwcGNpcFRNK2lwM0tpaVVhV3VNaWsv?=
 =?utf-8?B?eGMwYm5sZzBISzNYbGZWWFh2dDdnMENWL2lkRVJxRHBCOGJjUWhuVlhOQ2NR?=
 =?utf-8?B?dU5SVlR2SHNiem5wd0krZzZYejEwdjZ6Skl4VVhwclRtN1oyWWsvMmpnWnk1?=
 =?utf-8?B?VkVhdncvQkdqTVlkMzZSaHJFVEdkLzEzZWVGSXVPOTFwTFo2Z1hMUW1CVHlp?=
 =?utf-8?B?M3hDT0xUcGlvdXZScVMyNlkrMFlGS0FrclNhU2JCY0ErVU9MbUN6SXphdlZt?=
 =?utf-8?B?Vi9nZ1dqejNVd2FNRVplNVVycUptaUgvNTVhRzgwK2Z3V09HZ3RsZy9jUEF0?=
 =?utf-8?B?WStLSmF1M05MeVo5RzdqM1RTdUxyejF4V3JFWTZyL1N3bEJnNVk4TE5uMTZw?=
 =?utf-8?B?aTF4bHB5bnl0SXBtNEpXNnlnSlFzbTd0bndOT3VRc28zUFR5TUJFc3hXVm1i?=
 =?utf-8?B?SWVCZW1xWUtRNFlxQ3RKZlZic1VGVjV0YThWV0VydlhVdjRSbERWQjBvdnhB?=
 =?utf-8?B?S0JaRXRiOUkrWldEb0k1OFhEL3B0ekpqTnhJVktHeDhIaTJ5V2puZFFGZFhF?=
 =?utf-8?B?M1J4SlV3NFF4NUc0UDgvWlkrdDVETnRORGt3b0lOdVhxTi9yTTlUSjJtME93?=
 =?utf-8?B?eS9vNTJkRFlHdktiOC9FSEJKWjQvcnNsOG9KYTluUzdIQWpqYzJvNy9TU09q?=
 =?utf-8?B?VXp5eEpQMWtZSzU5L2ZZVEZXMEdURGE3MS8zemxDWHY0K29KeC9aazFJRGo1?=
 =?utf-8?B?WmZzVzF0SWo5MWVPc20zbkxqUG9pVlpQYTBLVG1jdDkwaDdha01NR1p3c2pm?=
 =?utf-8?B?Z0pLci8waTB0Nk5naG5XWGo3eGJ4VnlkUi84Q2R1Q2cvV2xoSEFmcGF1b2FS?=
 =?utf-8?B?YURtcy9lSlk2WEtoWWdyT05IT0QreVQzQkZIMHBYOW44eUIrUTd3RGZMYUlh?=
 =?utf-8?B?VVpScWRDbi8wMm8wQTBvMnFpWTRra2YwRVB6ckxxc1BuWkxnT2ZLaTh2QkhK?=
 =?utf-8?B?aDB4ZnFuMlNveXB4WGZZZVJNSi9ndlNjaXFISzNMbnhaVFFBZGpBaHFNWTlp?=
 =?utf-8?B?enYrUFlMdUprQzFCNSswb0p4QnNHNFAyaU5yUHhDaEVuVTZIbVlzUm9EazVs?=
 =?utf-8?B?eVNzYkVqVDBjbnlhSDB4T3VzRHF4YTJnaFQra0pRN2VsY0ZIQ2RSaWdiSXNs?=
 =?utf-8?B?NzRtNHo4ZHgyZCtucnpEZW5XUHlZaWdSdmtoaXBwT0h1L29ZcTQ4VG9VVm8w?=
 =?utf-8?B?MTVyc0lXSVRPR2VhZmNKNHkvcmFCTzluUjFLNTdnWlNlcjVJNnREU1VZd0ZC?=
 =?utf-8?B?eXVFR1hOeDBETVB4RXdZYmtCLzk0dk0wazdiRFE5Wk83d2IwZWs5UTdRa0lP?=
 =?utf-8?B?U0NYMDYvVC84NTE0TjJEUHpyRS9QTERKMlMvMzcrMVpJRFVDQmErQ2dqbjZ0?=
 =?utf-8?B?ZzhsbGUvM3VCVldpc2twS240V1cyL0xmOHVJRmp4M0JCY054WitrQTJicjFj?=
 =?utf-8?B?cHEvYVZCWEpRK3UvUjAzUGJGREJaWGljNWw2bGpleEo1V1BsZXMrSThJU2JD?=
 =?utf-8?Q?loGbCwax9iT2sRbW41?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <331167E1A65A4247A4B77828DDBE41CF@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f314d69e-6386-40e7-c1cf-08dec6c61ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 07:58:55.3347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G32/BXbHJ900YKqppYMbuXIxjS8Znj9+LCnL0Mj1DCVo6rADsQbHxaM0HV92fK1e+EbFJXn9JKPqGFOU+Q0mMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611
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

T24gNi8xMC8yNiAxNDo1OSwgSHVhbmcgUnVpIHdyb3RlOg0KPiBPbiBXZWQsIEp1biAxMCwgMjAy
NiBhdCAwMTo1NzozNlBNICswODAwLCBKaXFpYW4gQ2hlbiB3cm90ZToNCj4+IEZvciBSZW5pb3Ig
QVBVIHdpdGggZ2Z4OSwgaW4gc29tZSB0ZXN0IHNjZW5hcmlvcyB3aXRoIGRpc2FibGluZw0KPj4g
cmluZ19yZXNldCwgbGlrZSBhY2Nlc3NpbmcgYW4gdW5tYXBwZWQgaW52YWxpZCBhZGRyZXNzLCBp
dCBjYW4NCj4+IHRyaWdnZXIgYSBncHUgam9iIHRpbWVvdXQgZXZlbnQsIHRoZW4gZHJpdmVyIHVz
ZXMgTW9kZTIgcmVzZXQNCj4+IHRvIHJlc2V0IEdQVSwgYnV0IGFmdGVyIE1vZGUyLCB0aGUgQ1BD
IGFuZCBDUEYgYXJlIHN0aWxsIHN0dWNrLA0KPj4gdGhhdCBjYXVzZXMgY29tcHV0ZSBSaW5nIHRl
c3RzIGZhaWwuIFdoYXQncyBtb3JlLCB0aGUgSFFEcyBvZg0KPj4gTUVDcyBhcmUgc3RpbGwgYWN0
aXZlLCB0aGF0IGNhdXNlcyBNRUNzIHVzZSBzdGFsZSBIUURzIHdoZW4gTUVDcw0KPj4gYXJlIHVu
aGFsdGVkIGJlZm9yZSBkcml2ZXIgcmVzdG9yZSBNUURzLCB0aGVuIGNhdXNlcyBjb21wdXRlIElC
DQo+PiB0ZXN0cyBmYWlsLg0KPj4NCj4+IFNvLCBhZGQgc2VxdWVuY2VzIHRvIHJlc2V0IENQQyBh
bmQgQ1BGIGFmdGVyIE1vZGUyLCBhbmQgZGUtYWN0aXZlDQo+PiBIUURzIG9mIE1FQ3MgYmVmb3Jl
IHVuaGFsdGluZyBNRUNzIGFuZCBtYXBwaW5nIGNvbXB1dGUgcXVldWVzLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gLS0tDQo+PiBI
aSBhbGwsDQo+Pg0KPj4gTXkgYm9hcmQgaXMgUmVuaW9yIEFQVSB3aXRoIGdmeDksIHNtdTEyLiBJ
IHJ1biBhIHRlc3RjYXNlIHRoYXQNCj4+IGFjY2Vzc2VzIGFuIGludmFsaWQgYWRkcmVzcyB0byB0
cmlnZ2VyIGEgYW1kZ3B1X2pvYl90aW1lZG91dCgpDQo+PiB3aXRoIGRpc2FibGluZyByaW5nX3Jl
c2V0LCBzbyB0aGF0IGRyaXZlciB3aWxsIGNhbGwgbW9kZTIgcmVzZXQNCj4+IGRpcmVjdGx5LiBB
ZnRlciBtb2RlMiByZXNldCBJIGZvdW5kIGNvbXB1dGUgUmluZyB0ZXN0cyBhbmQgY29tcHV0ZQ0K
Pj4gSUIgdGVzdHMgZmFpbCByYW5kb21seSBvbiByYW5kb20gY29tcHV0ZSByaW5nLg0KPj4gV2Ug
Y2hlY2tlZCB0aGUgc2NhbiBkdW1wIG9mIEdQVSwgd2UgY2FuIHNlZSB0aGUgQ1BDIGFuZCBDUEYg
YXJlDQo+PiBzdGlsbCBzdHVjaywgdGhhdCBtYXkgY2F1c2UgQ29tcHV0ZSBSaW5nIHRlc3RzIGZh
aWwuDQo+PiBJIGFkZGVkIHByaW50aW5ncyBpbiBkcml2ZXIgY29kZXMgKGdmeF92OV8wX2NwX3Jl
c3VtZSksIGFuZCBmb3VuZA0KPj4gdGhlIEhRRHMgb2YgTUVDcyBhcmUgc3RpbGwgYWN0aXZlLCB0
aGF0IG1heSBjYXVzZSBNRUNzIHVzZSBzdGFsZQ0KPj4gSFFEcyB3aGVuIE1FQ3MgYXJlIHVuaGFs
dGVkIGJlZm9yZSBtYXBwaW5nIGNvbXB1dGUgcXVldWVzIChyZXN0b3JlDQo+PiBNUURzIHRvIEhR
RHMpLg0KPj4gU28sIEkgc2VuZCB0aGlzIHBhdGNoIHRvIGZpeCBhYm92ZSBwcm9ibGVtcy4NCj4+
IFRoZXJlIGFyZSB0d28gbWFpbiBjaGFuZ2VzIG9mIG15IHBhdGNoZXM6DQo+PiBPbmUgaXMgdG8g
cmVzZXQgQ1BDIGFuZCBDUEYgYmVmb3JlIHJlc3VtaW5nIEtDUS4NCj4+IEFub3RoZXIgaXMgdG8g
ZGlzYWJsZSBIUURzIGJlb2ZyZSB1bmhhbHRpbmcgTUVDcy4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA0MCArKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4gaW5kZXggNDc3
MjFkMGMzNzgxLi5kYzA5NzhiYzMxMmMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jDQo+PiBAQCAtMzk0NCw3ICszOTQ0LDggQEAgc3RhdGljIGludCBnZnhfdjlf
MF9rY3FfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gIA0KPj4gIHN0YXRp
YyBpbnQgZ2Z4X3Y5XzBfY3BfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4g
IHsNCj4+IC0JaW50IHIsIGk7DQo+PiArCXUzMiB0bXA7DQo+PiArCWludCByLCBpLCBqLCBrOw0K
Pj4gIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7DQo+PiAgDQo+PiAgCWlmICghKGFkZXYtPmZs
YWdzICYgQU1EX0lTX0FQVSkpDQo+PiBAQCAtMzk2Nyw2ICszOTY4LDQzIEBAIHN0YXRpYyBpbnQg
Z2Z4X3Y5XzBfY3BfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gIAkJZ2Z4
X3Y5XzBfY3BfZ2Z4X2VuYWJsZShhZGV2LCBmYWxzZSk7DQo+PiAgCWdmeF92OV8wX2NwX2NvbXB1
dGVfZW5hYmxlKGFkZXYsIGZhbHNlKTsNCj4+ICANCj4+ICsJaWYgKChhZGV2LT5mbGFncyAmIEFN
RF9JU19BUFUpICYmDQo+PiArCQkoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SRU5PSVIp
ICYmIGFtZGdwdV9pbl9yZXNldChhZGV2KSkgew0KPiANCj4gSXQgc2hvdWxkIGJlIG5vdCBvbmx5
IGZvciBSZW5vaXIsIGFuZCBJIHRoaW5rIGl0IHNob3VsZCBiZSBhbHNvIGZvciBhbGwNCj4gZ2Z4
OSBiYXNlZCBBUFUgc3VjaCBhcyBSYXZlbiwgUGljYXNzbywgZXRjLg0KPiANCj4gQ291bGQgeW91
IHVzZSBBTURfUkVTRVRfTUVUSE9EX01PREUyIG9mImVudW0gYW1kX3Jlc2V0X21ldGhvZCIgYXMg
dGhlIGNoZWNrDQo+IGNvbmRpdGlvbj8gQmVjYXVzZSBpdCBpcyB0aGUgaXNzdWUgb2YgbW9kZTIg
cmVzZXQuDQpUaGFua3MsIEkgd2lsbCBkbyB0aGVzZSB0d28gc3VnZ2VzdGlvbnMgaW4gbmV4dCB2
ZXJzaW9uLg0KDQo+IA0KPj4gKwkJLyoNCj4+ICsJCSAqIENQQyBhbmQgQ1BGIGFyZSBzdGlsbCBz
dHVjayBhZnRlciBNb2RlMiByZXNldCwgdGhhdCBjYXVzZXMgbGF0ZXINCj4+ICsJCSAqIGNvbXB1
dGUgcmluZyB0ZXN0IGZhaWwgYW5kIHRoZW4gbG9vcCBNb2RlMiByZXNldCBpbmZpbml0ZWx5DQo+
PiArCQkgKi8NCj4+ICsJCXRtcCA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1HUkJNX1NPRlRfUkVT
RVQpOw0KPj4gKwkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIEdSQk1fU09GVF9SRVNFVCwgU09G
VF9SRVNFVF9DUEMsIDEpOw0KPj4gKwkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIEdSQk1fU09G
VF9SRVNFVCwgU09GVF9SRVNFVF9DUEYsIDEpOw0KPj4gKwkJV1JFRzMyX1NPQzE1KEdDLCAwLCBt
bUdSQk1fU09GVF9SRVNFVCwgdG1wKTsNCj4+ICsJCXRtcCA9IFJSRUczMl9TT0MxNShHQywgMCwg
bW1HUkJNX1NPRlRfUkVTRVQpOw0KPj4gKwkJdWRlbGF5KDUwKTsNCj4+ICsNCj4+ICsJCXRtcCAm
PSB+KEdSQk1fU09GVF9SRVNFVF9fU09GVF9SRVNFVF9DUENfTUFTSyB8DQo+PiArCQkJCUdSQk1f
U09GVF9SRVNFVF9fU09GVF9SRVNFVF9DUEZfTUFTSyk7DQo+PiArCQlXUkVHMzJfU09DMTUoR0Ms
IDAsIG1tR1JCTV9TT0ZUX1JFU0VULCB0bXApOw0KPj4gKwkJdG1wID0gUlJFRzMyX1NPQzE1KEdD
LCAwLCBtbUdSQk1fU09GVF9SRVNFVCk7DQo+PiArCQl1ZGVsYXkoNTApOw0KPiANCj4gSXQgd291
bGQgYmUgYmV0dGVyIHRvIHVzZSBhIHNwZWNpZmljIGZ1bmN0aW9uIHRvIGltcGxlbWVudCB0aGUg
cmVnaXN0ZXINCj4gcHJvZ3JhbW1pbmcgbGlrZSBjbGVhcmluZyBDUEMvQ1BGIGFuZCBhbHNvIEhR
RF9BQ1RJVkUgYmVsb3cuDQo+IGdmeF92OV8wX2NwX3Jlc3VtZSgpIGlzIGhpZ2ggbGV2ZWwgZnVu
Y3Rpb24uDQo+IA0KPiBUaGFua3MsDQo+IFJheQ0KPiANCj4+ICsNCj4+ICsJCS8qDQo+PiArCQkg
KiBDUF9IUURfQUNUSVZFIHN1cnZpdmVzIE1vZGUyIHJlc2V0LiBEZWFjdGl2YXRlIGV2ZXJ5IE1F
QyBIUUQgdG8NCj4+ICsJCSAqIHByZXZlbnQgTUVDIHVzZSBzdGFsZSBIUUQgd2hlbiBNRUMgdW5o
YWx0ZWQgYmVmb3JlIHJlc3RvcmluZyBNUUQuDQo+PiArCQkgKiBPdGhlcndpc2UsIGxhdGVyIGNv
bXB1dGUgSUIgdGVzdCBtYXkgZmFpbA0KPj4gKwkJICovDQo+PiArCQlmb3IgKGkgPSAwOyBpIDwg
YWRldi0+Z2Z4Lm1lYy5udW1fbWVjOyBpKyspIHsNCj4+ICsJCQlmb3IgKGogPSAwOyBqIDwgYWRl
di0+Z2Z4Lm1lYy5udW1fcGlwZV9wZXJfbWVjOyBqKyspIHsNCj4+ICsJCQkJZm9yIChrID0gMDsg
ayA8IGFkZXYtPmdmeC5tZWMubnVtX3F1ZXVlX3Blcl9waXBlOyBrKyspIHsNCj4+ICsJCQkJCW11
dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOw0KPj4gKwkJCQkJc29jMTVfZ3JibV9zZWxlY3Qo
YWRldiwgaSArIDEsIGosIGssIDAsIDApOw0KPj4gKwkJCQkJV1JFRzMyX1NPQzE1X1JMQyhHQywg
MCwgbW1DUF9IUURfQUNUSVZFLCAwKTsNCj4+ICsJCQkJCXNvYzE1X2dyYm1fc2VsZWN0KGFkZXYs
IDAsIDAsIDAsIDAsIDApOw0KPj4gKwkJCQkJbXV0ZXhfdW5sb2NrKCZhZGV2LT5zcmJtX211dGV4
KTsNCj4+ICsJCQkJfQ0KPj4gKwkJCX0NCj4+ICsJCX0NCj4+ICsJfQ0KPj4gKw0KPj4gIAlyID0g
Z2Z4X3Y5XzBfa2lxX3Jlc3VtZShhZGV2KTsNCj4+ICAJaWYgKHIpDQo+PiAgCQlyZXR1cm4gcjsN
Cj4+IC0tIA0KPj4gMi4zOS41DQo+Pg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVu
Lg0KDQo=
