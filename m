Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0956C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 15:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C8710FF85;
	Thu, 14 Apr 2022 15:08:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE57510FF87
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 15:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2WisEHMblwUGX3Uc8MwxY2a2ekYI3Rorp9oOTDnlXCiFOe8+q+tO2Q1afAZ/mNABuCiz5Rn1fTnw/l9qQHaUlN3JaW/jTy1ys+5LDOGfgT2LSmxesxQs/aQV0XqqgrKlKnKylhTbvtR41ylGZ2ff968tUReetIMYRcEx/SLI9VxBVTw/ej1QOUCfVOrcaoayVst8LgrCvv7WpOg7mRYRCYYEyE5SsEnHIGfoBsssnP8Ya1K+Hef7UoJDezOwGRVNdg4bTrJe26sLD3ZOW3IGIQh+OCG9kkAytAA1FCXCbu8+9MAPiVBCSgkb1rimqGuqQNdHUw5ZR6nLaaVhbM20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giSTbQTf0cf0UtWo+D3vJ/WRxvHhK3SE9pDDnf4mnMM=;
 b=UPgIf7aMlmtm8b7Y+4/MzT7mFStlSqHU0e/jeG074zfq2LasdTRSTVPQOfxbypAAOZBHNG8cHSKsEuqI0nWt7pjhFLnSLG8f6XUxozyfSlkQ76uOb0CTo8Ww1eozmaVo4j+nfq95m4VHOen2zjtcQpgO++zfCgKcYehUZnWNPsgQaB6IsUFIcqvKfdsa/4V3naZzAvtoQsty7IomDcXlNdF/LOoZ0L82JMTRKqYwNfQwjBqLWV6JSdydQYuwyhrjE4BH/ulVbYjDGmO6fL3H7yQMrfJc1fM668JHg4o/RnG9bqLGcKfUG0ToLQ9Q4V/18Yf5Emx8AL+aiKVbtcWfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giSTbQTf0cf0UtWo+D3vJ/WRxvHhK3SE9pDDnf4mnMM=;
 b=pJrDf8CeDqjMa4M0Aarnu0mr5aFgKKXzuHO0yJQVX2h2eRJXYAa5R9+IM6T3bMXTZrEI7f7kS83W6nBtQxRuE7/ldlneP5/4YPLn7bymkhnibxZxfWGWvA1R+qyJwdbnK5NpTT5p6RTh1OLM9hN2yHnxwGQJV5QLiOFSuqbOAZQ=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 15:08:08 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8d9:b576:c670:be66]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8d9:b576:c670:be66%9]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 15:08:08 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
Thread-Topic: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
Thread-Index: AQHYT05pfRBjPMkt2EqJ/tE/b1rnJKzvf8iAgAAA7sA=
Date: Thu, 14 Apr 2022 15:08:08 +0000
Message-ID: <DM6PR12MB5021A8149E735B300611A06295EF9@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20220413155145.861750-1-david.yatsin@amd.com>
 <e9eb2603-4997-30e1-ce2a-bd3ae0bec7e1@amd.com>
In-Reply-To: <e9eb2603-4997-30e1-ce2a-bd3ae0bec7e1@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1940e678-e6e5-4ca2-6fb1-08da1e2895da
x-ms-traffictypediagnostic: MW5PR12MB5651:EE_
x-microsoft-antispam-prvs: <MW5PR12MB5651B12238CABCF084123BD295EF9@MW5PR12MB5651.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VnXYxtDl3W+SFyHhKOj+2skafx2FkMwbM57B5MQ4RpyqCyyNx2qsCgeUh9bdDqvUYKWFm8PhYgKMrhHKnYzOsqsdfqCbP6kMdqww8NlBT6S5zD32HPhR8BKBtZhJ7Li3i3w4I1TS6n+pxkjmx96Jiz458TAcfLJejxxMtCXdfftYveR+rQIySqUTOSXdbnmvvYmO/IxBggkka4Of+jFZqyLHU3j5J31FeoowvPibbqxf6rxTzZaiz3H7H78U5o0Pd1OMdFTfkd/kCGkTfsldJRzBIm98qEWwIN1Uy67p/lJ0Vrh8N2rYldCL6syvjJP7gNwJG+SyLlR8DldKp1PrYPjreLPeiMJoGu6v+32WFe/MfKfEKDtcVQ8gZBNMu96xUN+wm3ZQTc+JsOmzzfsMCIno+zsfBE7/N/ENEZDWBDx1xUyZMaCixqwU0EBBOj/EEUJROEjLQ4Q54aPChzvoVSaQShUGqXbVIpeJJm8Gg4kBuNnBYD5l9Mdts7p8ETxcJS3jtJm6vll/1CdBTpWM8EpDFv7PeEhcS25P+J1toW1qEYfeMcdg7dGKxkqdwW2wZjF2ZxlcOXF6PhNEBseOXUO/iCm3CbyrVeY/2+FIdGyi/e9wil/0GHOd6KOp1BifgxQDNLpySHLDrzay7gyc3QCnH7upMoq/cMVa8uy2T0g91S+ljLBc5RA0cXBX8p9H5al5Y/TwEfC77HTH76OeVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(8936002)(55016003)(110136005)(33656002)(316002)(83380400001)(38070700005)(122000001)(53546011)(5660300002)(71200400001)(7696005)(8676002)(2906002)(76116006)(9686003)(66556008)(66446008)(64756008)(66946007)(52536014)(66476007)(508600001)(86362001)(26005)(186003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWw5bmJQTkthamVpRmRoZXBNWEl1TWJuem1rSEFTWVVLcEs3Q0MzcXZubS9t?=
 =?utf-8?B?TEVKNkhraUNxSTArZVlpLzNjaDZUQnZrbGxwbWQ5RnBTRlI4MGhxV2VWQitu?=
 =?utf-8?B?MEZtUFU2NExKWmp5N2VJZWlrOU9ZVjV3NmMrZTdtMkhRNHcyYTRJejgrZHRS?=
 =?utf-8?B?KzVTTXZZQjNQbC9DY0tqeXpEcndTemJFejdtUkdBTWN4amtvWlhXbHBZbmlo?=
 =?utf-8?B?UVVvWUxEcE9LZWZLWm5WaWhpaTRWcUkvZ2hocElsTXMwWEJMTmtsNkIrVTJw?=
 =?utf-8?B?K1UyMitQRE00UjJXZ1h3aEtIN1dEWTBpbnVQTVRJN0ZWYVhiamIydkJ0NThx?=
 =?utf-8?B?VEovZXprbnRKSTJyc203SUdnK1ZRSC92dHd6aUJybzJMSDQxNEFqL0xBYUcv?=
 =?utf-8?B?d3B4S25ZYXBPNEt3bmQwNjkzOWp0cGlBRWJlaldDZ25IeENVQjJ0eVRpR0di?=
 =?utf-8?B?SWoxU0hTRUt3RUZvQmFrVGMrclJKQ09aRzZjeWwxZlQ2OWo1bkY0TWtJMk10?=
 =?utf-8?B?K2h6Z21WZHBsY3FaamY2UCtCTzM4ZFFiZFJKWk5pb3FDS1kwY0dHMTRIUmxW?=
 =?utf-8?B?VzdVNllqOEVnSlgvMEpsY2ZCVHh1b0dNSk5FWEgxN2FuYmNGUS9jKzZ6NnJ1?=
 =?utf-8?B?aEdWaTNJZ2VncG5FWGtvU0txSEgrc0lWOW83Tm40MDBKalVobXVaOVJoVGtj?=
 =?utf-8?B?VjJJZ0JsQ2c1SlVYU3owVkMyWkFuR0xIK0VHV21pMzFuL0RLZGRGa0wvRUM2?=
 =?utf-8?B?SU5zUzRwdXN1cVhHaEI4K0t4TnpZNCtkSjd2Q0EzUllDYUVZVVE2SHJDODMr?=
 =?utf-8?B?Nld5Qkw0RzQzeCtReU1rNzN3MzAycHplYlFJRXZuQVdxdm01OWptZkJxc28v?=
 =?utf-8?B?bnpldjc2MEdmaGI2R2pmQlFoRFBWdHpDbWxvQXN0RHIvZEk4Wmo2Rms2TnlL?=
 =?utf-8?B?TW1LUWV6a25MRFpSa1BJaUFSTHNhOTNGU0pMcnFlQnhYMC9RNHkzVWpsRkZy?=
 =?utf-8?B?ZDlUVFM4UHM3Z3E0YVVXSkhSMUVSU0Z5Y0syZ1QwY2RRSFdEaEIvMGQzdmlW?=
 =?utf-8?B?NUk0K09uUFhKdHZveW1HdVdhbDAzR1dMeVh1cUxUa0h1dS82UkFGcUhIM1E1?=
 =?utf-8?B?eFlPL3JLNy9IeFNsdnN4dXJPaVFuY0JTR2o2eUdWa0ZPSHlmQzh4Q2xna0Ux?=
 =?utf-8?B?TlVod2lYOXljelE0RWU0bC8yOVd6bmhvd21aeTQrSENqc2w3cTJCL3hlSFV0?=
 =?utf-8?B?VGNvNjBVVy9zL1pVcjFmS25mdzZzOGcrZ25OK0hob2VNRVNwNXR5SVczY3A2?=
 =?utf-8?B?U1crWlJ6VXR4cldreDRydkFzY3RMWGM3M2ZZVzZKRkFtaGlhMU9iMzgzV2lO?=
 =?utf-8?B?M1pJQmljb21BeUVhZkpsT3VXVmU3U3lhdVB0STU2d01lbzR3MEk1dVYva0tC?=
 =?utf-8?B?ZktaMWM1ZFNZV2NlMzVFYjl5aitBVDRST1JvNW9QR3duUi85UFE3akJEVXJ2?=
 =?utf-8?B?QUorbkpFYXRkNUZiKzgvRXNOZ291bGhJOVlPSm1ZNHRGRTRHV1RRdHpBVTlm?=
 =?utf-8?B?UlFONytxYktXVzdDaVRPUFFKNWluaGd1OEhLc3R0bEpJcFRINTl4Y29MZTJj?=
 =?utf-8?B?NGhOSlBWYUh2NUtHZFRMN2d4YTc4ZHlYYm5UaHpjaDFaS01IWEt1c2d4RmVI?=
 =?utf-8?B?WUIrRDZrZTRRSGpGL1h0eDRsL3h6STQrZWs5UmdwVzZST3JBcVhMR1p5UzJx?=
 =?utf-8?B?RnZ0UHBNa3FLbEdQUzFYU05wVEhzMUp5WFhQV3Vsd2Q3aFlwaGpjaUpiVVR3?=
 =?utf-8?B?VHVhRTc3ZEIzWUxBbU5IUGJpQWlITEZVeVFqa2I4UjI2eGtNZmZlUXBxeDY5?=
 =?utf-8?B?RS9pMDB1Um15L21TYk9qeU5jeFNNWG1vRFdrNzRiNEdneElER2dhcmhaaWls?=
 =?utf-8?B?QkF3d1FMV1J5M01mdWJhZHVGMS9HSGdTQTRMdWNVdlFHWUt5Y2NHL2dzSWc0?=
 =?utf-8?B?czlhbVd3YjRxYnp1YkFJYldxS1VlTE5iQk9mWVZ1YVhUQVRZTlo5MVVQQkNE?=
 =?utf-8?B?QmJHc1hxa3M4b3RSTlZtNTJOaisvMzBQSkdKY3VoK2NaM3lPanVySFgwa05o?=
 =?utf-8?B?TElmTGtpMFhVa1ZBRk9tZ3RSSWphaW5zdXBtQlR6Q3ZmRVJQdlpvSm1iV3ZL?=
 =?utf-8?B?WmtrbXFpbThMaUxUeCtEM1ZQODBmcWZOL2NDeHU5N0xHNWRRajZ2dXozaUxs?=
 =?utf-8?B?MkJuckRBU0VBTjRhVGU4Zm05aTJyWjFDQk80OVlURUlWNytHWDVNZjRhQ096?=
 =?utf-8?B?Q0hwcmU5aUIzWVAwck84dGN6Wng1QlU2Yis2YlZaY0txdjQvS3lMdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1940e678-e6e5-4ca2-6fb1-08da1e2895da
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 15:08:08.7211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lq9MJM3g6cKA2KQBqZGg0cebF3zCYdq0gwR/ZTaiz0jDu1Y6jdKi7GN7vjPq/vZGGZA3YYtPwovgMlOERE1VmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTQsIDIw
MjIgMTA6NTIgQU0NCj4gVG86IFlhdCBTaW4sIERhdmlkIDxEYXZpZC5ZYXRTaW5AYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBkcm0vYW1ka2ZkOiBGaXggR1dTIHF1ZXVlIGNvdW50DQo+IA0KPiANCj4gQW0gMjAyMi0wNC0x
MyB1bSAxMTo1MSBzY2hyaWViIERhdmlkIFlhdCBTaW46DQo+ID4gUXVldWUgY2FuIGJlIGluYWN0
aXZlIGR1cmluZyBwcm9jZXNzIHRlcm1pbmF0aW9uLiBUaGlzIHdvdWxkIGNhdXNlDQo+ID4gZHFt
LT5nd3NfcXVldWVfY291bnQgdG8gbm90IGJlIGRlY3JlbWVudGVkLiBUaGVyZSBjYW4gb25seSBi
ZSAxIEdXUw0KPiA+IHF1ZXVlIHBlciBkZXZpY2UgcHJvY2VzcyBzbyBtb3ZpbmcgdGhlIGxvZ2lj
IG91dCBvZiBsb29wLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgWWF0IFNpbiA8ZGF2
aWQueWF0c2luQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jICAgIHwgMTIgKysrKysrLS0tLS0NCj4gLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1
ZXVlX21hbmFnZXIuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gPiBpbmRleCBhY2Y0Zjc5NzU4NTAuLjdjMTA3Yjg4ZDk0NCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1
ZXVlX21hbmFnZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9k
ZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ID4gQEAgLTE5NDUsMTcgKzE5NDUsMTcgQEAgc3RhdGlj
IGludCBwcm9jZXNzX3Rlcm1pbmF0aW9uX2Nwc2NoKHN0cnVjdA0KPiBkZXZpY2VfcXVldWVfbWFu
YWdlciAqZHFtLA0KPiA+ICAgCQllbHNlIGlmIChxLT5wcm9wZXJ0aWVzLnR5cGUgPT0NCj4gS0ZE
X1FVRVVFX1RZUEVfU0RNQV9YR01JKQ0KPiA+ICAgCQkJZGVhbGxvY2F0ZV9zZG1hX3F1ZXVlKGRx
bSwgcSk7DQo+ID4NCj4gPiAtCQlpZiAocS0+cHJvcGVydGllcy5pc19hY3RpdmUpIHsNCj4gPiAr
CQlpZiAocS0+cHJvcGVydGllcy5pc19hY3RpdmUpDQo+ID4gICAJCQlkZWNyZW1lbnRfcXVldWVf
Y291bnQoZHFtLCBxLT5wcm9wZXJ0aWVzLnR5cGUpOw0KPiA+IC0JCQlpZiAocS0+cHJvcGVydGll
cy5pc19nd3MpIHsNCj4gPiAtCQkJCWRxbS0+Z3dzX3F1ZXVlX2NvdW50LS07DQo+ID4gLQkJCQlx
cGQtPm1hcHBlZF9nd3NfcXVldWUgPSBmYWxzZTsNCj4gPiAtCQkJfQ0KPiA+IC0JCX0NCj4gDQo+
IFRoaXMgbG9va3MgbGlrZSB0aGUgb3JpZ2luYWwgaW50ZW50aW9uIHdhcyB0byBkZWNyZW1lbnQg
dGhlIGNvdW50ZXIgZm9yIGluYWN0aXZlDQo+IEdXUyBxdWV1ZXMuIFRoaXMgbWFrZXMgc2Vuc2Ug
YmVjYXVzZSB0aGlzIGNvdW50ZXIgaXMgdXNlZCB0byBkZXRlcm1pbmUNCj4gd2hldGhlciB0aGUg
cnVubGlzdCBpcyBvdmVyc3Vic2NyaWJlZC4gSW5hY3RpdmUgcXVldWVzIGFyZSBub3QgaW4gdGhl
IHJ1bmxpc3QsDQo+IHNvIHRoZXkgc2hvdWxkIG5vdCBiZSBjb3VudGVkLg0KPiANCj4gSSBzZWUg
dGhhdCB0aGUgY291bnRlciBpcyB1cGRhdGVkIHdoZW4gcXVldWVzIGFyZSBhY3RpdmF0ZWQgYW5k
IGRlYWN0aXZhdGVkDQo+IGluIHVwZGF0ZV9xdWV1ZS4gU28gSU1PIHRoaXMgcGF0Y2ggaXMgYm90
aCBpbmNvcnJlY3QgYW5kIHVubmVjZXNzYXJ5LiBEaWQNCj4geW91IHNlZSBhbiBhY3R1YWwgcHJv
YmxlbSB3aXRoIHRoZSBHV1MgY291bnRlciBkdXJpbmcgcHJvY2VzcyB0ZXJtaW5hdGlvbj8NCj4g
SWYgc28sIEknZCBsaWtlIHRvIGtub3cgbW9yZSB0byB1bmRlcnN0YW5kIHRoZSByb290IGNhdXNl
Lg0KPiANCj4gUmVnYXJkcywNCj4gIMKgIEZlbGl4DQoNClllcywgd2hlbiB1c2luZyBhIHVuaXQg
dGVzdCAoZm9yIGV4YW1wbGUgS0ZER1dTVGVzdC5TZW1hcGhvcmUpLCANCjEuIFB1dCBhIHNsZWVw
IGluIHRoZSBtaWRkbGUgb2YgdGhlIGFwcGxpY2F0aW9uIChhZnRlciBjYWxsaW5nIGhzYUttdEFs
bG9jUXVldWVHV1MpDQoyLiBSdW4gYXBwbGljYXRpb24gYW5kIGtpbGwgdGhlIGFwcGxpY2F0aW9u
IHdoaWNoIGl0IGlzIGluIHNsZWVwIChhcHBsaWNhdGlvbiBuZXZlciBjYWxscyBxdWV1ZS5EZXN0
cm95KCkpLg0KDQpUaGVuIGluc2lkZSBrZXJuZWwgZHFtLT5nd3NfcXVldWVfY291bnQga2VlcHMg
aW5jcmVtZW50aW5nIGVhY2ggdGltZSB0aGUgZXhwZXJpbWVudCBpcyByZXBlYXRlZCBhbmQgbmV2
ZXIgZ29lcyBiYWNrIHRvIDAuIFRoaXMgc2VlbXMgdG8gYmUgYmVjYXVzZSB0aGUgc2xlZXAgY2F1
c2VzIHRoZSBwcm9jZXNzIHRvIGJlIGV2aWN0ZWQgYW5kIHEtPnByb3BlcnRpZXMuaXNfYWN0aXZl
IGlzIGZhbHNlIHNvIGNvZGUgZG9lcyBub3QgZW50ZXIgdGhhdCBpZiBzdGF0ZW1lbnQuDQoNClJl
Z2FyZHMsDQpEYXZpZA0KDQo+IA0KPiANCj4gPg0KPiA+ICAgCQlkcW0tPnRvdGFsX3F1ZXVlX2Nv
dW50LS07DQo+ID4gICAJfQ0KPiA+DQo+ID4gKwlpZiAocXBkLT5tYXBwZWRfZ3dzX3F1ZXVlKSB7
DQo+ID4gKwkJZHFtLT5nd3NfcXVldWVfY291bnQtLTsNCj4gPiArCQlxcGQtPm1hcHBlZF9nd3Nf
cXVldWUgPSBmYWxzZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gICAJLyogVW5yZWdpc3RlciBwcm9j
ZXNzICovDQo+ID4gICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGN1ciwgbmV4dF9kcG4sICZk
cW0tPnF1ZXVlcywgbGlzdCkgew0KPiA+ICAgCQlpZiAocXBkID09IGN1ci0+cXBkKSB7DQo=
