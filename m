Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D24C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 07:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E624C10E3DE;
	Wed,  7 Sep 2022 07:53:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F2910E3DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 07:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgsXo3QsLey1qK3/Xz8+gDs7/30U1uySnIbTJC2J5LVgTWGInFDrI0xDGGf7iInNQD+Mg+1M39TXV6On5fFEcuJn6z9Ghma93pguUaRVvhZUi3+gValqqBv4u45pLLWzYkKgjnRbEv2l5E07UKHK+lvjhnGIojyNC2I6YGWXOmdL3nPBEJSywLZyD+W+G1xjI2ZpmutyqiX7b990HtsMxIlD46m72YRld6eoHr6ohPIumioYJpXS1e4Qal5UkAtY7YEbr1OriBA3v6KKF5TXqsAC20zsALJ960cggZrSI9VY5ocCnpVUOc3MkHuwdzqch7qf9hHo3wac89iT8PhSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xcdz4AZgp+IqescbvPZCYqmLUTjpSj4uifuEwScA/Y=;
 b=D2/zQDGBPmkV3K4ZjqwCrgUjSCSskTK9EFTi0YdOzTRHFBeoQHvlNd3/90d3hNtJzDzw5NDBFmiVkY/UkabM0pgmvJTDRZLyRANuoD+/lcN2KHl4IV2OXN3S6ZHnvSCt/+lKCWtm//udJ7WzeDHINJVeYxn8PnIAZB/sttaU9CgJKbhdZh7LpZ4x3dm2G/G0ubsbh2AAo8Rr6+PqBfFJPAGLnbQ26Lt9FeYloWH55VdsiuNFzkKGJO6O+8priX2lUBmBRD7U7i+nl5y0yZxStZcgM2BoD+r4uzCcNEisK7rpI9m7SP2cZJQkKihMVNYNSaOwBxAmMsowlAQUbnR0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xcdz4AZgp+IqescbvPZCYqmLUTjpSj4uifuEwScA/Y=;
 b=5ehPTdONpXOY9RQIO9I5vMQ+wekSz2KomZIQT2tpFgHrVAPTJs1eyviwvGVlBCIHV55VKDR+P4aHbTcTNd7P0ONR1GXYKDuEqXFY1OKZu2jAjKLoJtc2f2M9wjIlYdrotXMwpcIEb+ggdzmkmB6ItTGNG5QZOjGwzUOXipO7OcU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Wed, 7 Sep 2022 07:53:39 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0%7]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 07:53:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, 
 Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu: drop runtime pm disablement quirk on
 several sienna cichlid cards"
Thread-Topic: [PATCH] Revert "drm/amdgpu: drop runtime pm disablement quirk on
 several sienna cichlid cards"
Thread-Index: AQHYwnXPX6OVQOqZTU2xFo43JhrmQa3TeKyAgAAfzoA=
Date: Wed, 7 Sep 2022 07:53:38 +0000
Message-ID: <DM5PR12MB24699B77DFE8382A742B1FF8F1419@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220907045326.2881218-1-guchun.chen@amd.com>
 <18b6aeb9-79ee-2388-f7e2-342d8bfaf09e@amd.com>
In-Reply-To: <18b6aeb9-79ee-2388-f7e2-342d8bfaf09e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|BL1PR12MB5270:EE_
x-ms-office365-filtering-correlation-id: aa665905-7d9e-4264-ef0b-08da90a61351
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+Gxyt2BT0QqwnoCiLFUTWCquo920MnDgP5lPB8l4H+XDIgCqLc2iDAfibYk+evlyWxL5kPLfsLvY4SzokLQjIoaPf5xYUAenzt0ZNRYnqV/O8PQMOKIK7040PjpET1DeuwK//s+5qsXcw1uNlO2jPcCTOuJXFDNOiHG9oDyJm6YrgRXtrwBbsyk0uhVCNO3Gj9yRDwAVEKyndgx/nJd+fCRzA25TXzLReWJgyWW6oDGs/ZSU+PGrB5eI2/KPRXnfwQ/xYLqWKGq3kfpH8npUJecfHrBLPdCZR4+Iqd4qj6O/gf4OJF8bqCxgZOkowMtIqXkrk7PquU6bo9xFspYRqZEv1B/C/KfpmyXZRsy6n6izlZBcTgrcfr8H8TquzK1bD/GGFvKLyDUdKYeITqEgfK8gz49dSd7NTdCWMZqzPMYXOyLkl9f/GMwCTctZESLqWdeNJxc/X1XCeoCUYFEH0Sy6F5qUA2UDXGNvhLEaJsDa9AXtYO2XQv4FFqTzxNfqeqCiYYbq8oJDLqCASLhuM9FZYL8pVoJRBlhnPT9Rlz3ZAkBPu8TpGhRSE7kdaKsmHLGYTBXzFyYq+tRJOapQt/oxmVnawE0hNsW3MtVZ/kuHQXdYd74mjga8hpLfOlYg+GOMSuZrvYKY2Yw6U8mK5n9cbXirFJW+A43Q5pP09REtc8tW4OROSSttmKBGFwSaMYks/PegDorfaUlJsYlZjX9uU/wsvLTuolsTDEXqmimjShv3epZJ0zzSXRObFFmhh7rQodloHpuFNk95ed1u9KINLH2pGQWXppQEZJ5evw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(122000001)(66446008)(316002)(6636002)(38100700002)(71200400001)(55016003)(41300700001)(921005)(110136005)(33656002)(66946007)(66556008)(38070700005)(478600001)(7696005)(6506007)(83380400001)(64756008)(76116006)(8676002)(66476007)(86362001)(52536014)(186003)(8936002)(26005)(2906002)(5660300002)(9686003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEtpNUIveDVGZk9QZngrTnYrZ2JQUTlpaUV2b2VET1pydVJzZFQxYmNkV2Iy?=
 =?utf-8?B?Z0RsSmxUcy9WK1ZaN0hNWS9Mamp4ZVNqRmxJbFA4cWJTR3J5ZlJaTUxTS2dK?=
 =?utf-8?B?REt1aUcxUlZNM1cxYkM1N3ZZRHBxUWJWelBQd1UvSkgrVXFnbGxkbi9Ud0N0?=
 =?utf-8?B?VlVZZDYrWHZFM0wycGdOY2V2YUF2K3RRemVFd0ZjeWlwZll0SXY0akhPcXhP?=
 =?utf-8?B?RXJEd1hsMTN0QjEzcGVHb1F1YTFYM0ZTU3RaYUxNeTJDNzlQQkJNSlZ6MVQy?=
 =?utf-8?B?Q0VNem5UUW1Sa0R2WnRtbjVlUjJtWmtxa3VybVdYZm0zR2dQOUd5ZE5wdTBu?=
 =?utf-8?B?OGZraW9yY01wZUpCOHFGZ3BFdUZPWTZyWitxOGdEZFVPajBZWjJrL3VRd1Av?=
 =?utf-8?B?ZHV4dGhKNEZVdFNFbnF2TkRtL2ZPNDNXWjR2QjlxZzBqUlpmRHJwdngrdXRk?=
 =?utf-8?B?T3VuekErQ2lOdWdBazFYNWc1eUduTHh1RndUb1hMV1R2S1ArY2J1WFZZWGJM?=
 =?utf-8?B?d3VpT2tIRFYwL2pxaGVpZEtWdGFkcm0vY1IwVFJIY0FjMll4MVlrQmdhVTRW?=
 =?utf-8?B?dVpoUG9kc0pWaWlJTEtkbUg1dEpQVUdaS2lPTy9zT2RtRmpESkpOcWFFcEJX?=
 =?utf-8?B?ZDV3Mm81MDNCTnVrOG9MSk83Q3pGemlNRTJLUFQ4Wk9DOGpzT3gyTVdFY0t6?=
 =?utf-8?B?VlJydHZuanFnS3NZUDBmM2pHbkVoL2tZZWVLWlJ1cEFSOWFCMG5VcVY4bkRp?=
 =?utf-8?B?ZkQ3K2gxbnA2b2R3ZTFGMFZ3WnBzUlhieEx0cmd0NW5vbmVyMWhGaFNzV21z?=
 =?utf-8?B?c3NoVzZmd0VKYnR2TmJaaW9qTDh3SFBYbk9XRGtEc0FUK01vbFQxSnpKZkZU?=
 =?utf-8?B?NGRITTVkeXpISmNmZ3IyQksrSm4vSWhFTWxhNmZSN1hFZ1Rkek9pdE5qWlJz?=
 =?utf-8?B?RGNLQ21rVGx5VmV5MEJmcHFCRmdmWXlGcEhhMFdHYVVvcFc2VHRWSGJiQlVn?=
 =?utf-8?B?eW5qK1hBV3NJRWJMUUFSZzhCWC9TUS94cE9TaE8xTUJzRFNTcU5mbVd3cUl4?=
 =?utf-8?B?Y2hIRHphemwrclp2eTdRWGNiK25JL1VKWlVuRndEY2VXSHoyUldyaCtKUm5N?=
 =?utf-8?B?UkUvR1dzSmlFVFpHRk54TlJVaW1hLzJ2Q3prTnpQNDlBc2tDWldrMzJHV2N2?=
 =?utf-8?B?bWg2YzVncDRVeHlOZ1d2ek9MS2FTRktnTDRDSXBicW9YcVpBWlJEU2NYd2lv?=
 =?utf-8?B?eTkrcG51Vy9rZzBZajdzbzQ5eEYyRGtNbmNSKzBGT2x1VXdkZlQ0TWhDVzNk?=
 =?utf-8?B?UEJydVF1YnExNVZQQ25HNkc5aU0wanpGSzJkQytOSU5zbnR5UE82bUVua0FZ?=
 =?utf-8?B?cVJuaEF2QktsbVluc3p1MUt2UG8xSjNzdm5UaWIzSEVJbk96dEN0VEYwbVpz?=
 =?utf-8?B?bVhROVc0Q0NCWjBRMW1yd01sOEdZNTBYMEZCNHFDalUweEhFZTZ6WUxzWEh1?=
 =?utf-8?B?SkhmdlpCWnJtSjNxbjB3bW4zcitSRm5HcE1iY3VSK2J1dXJGUThiak4xQ2Z6?=
 =?utf-8?B?Z1Rtd0JsbStoYWZaZ2xITitUT1RYQVd4VjNsVW1xOW1KM0JUM3ozdW5BZFNB?=
 =?utf-8?B?T2laaWdaWXNKNXJJZnZucnRYRWpXQ3RmQ1JyeUZVY3g3UDJDZUEvTjR0OXJN?=
 =?utf-8?B?TWxLRk0wOHFobmJPajRrUHltNGlTb2JXbWxvSGlKZlJHSTFvUmFFc2tiNXpU?=
 =?utf-8?B?QktZUFFNRk5iemgrKzN1aVYvNC80ZHREeExHMGZNWFMxVjd0N1ErWEE1c2M1?=
 =?utf-8?B?S0s2c0Q4WkNLVnlRaHBINHl3K1F3cDhTbDdjY2xXOVduSHhKN0F1U0ZzQVNI?=
 =?utf-8?B?TlNZVzR6dW1SOElFZGp4anl4c25waFVraTJMVkEyMEZhSTRUM2NUTDlsTmpT?=
 =?utf-8?B?T1NqaXB5YXhzR0ptNUFBU1NKc2llSWVEMFBSeFNaLzk0KzNIQ0haeUJodEZ4?=
 =?utf-8?B?RFVUNkgxVzliR0tXSm95c0dMTW5mT2hGY0ZoWU9kQy9WMS81OVV6M2hFMjg0?=
 =?utf-8?B?aWhWbVp2aHRXb1ZDaExzalJCZW1VdGIwSXNBdnRlVHRjS0ZqeU95QzdkSll3?=
 =?utf-8?Q?QljizYdX6QIN/qvjWmD3iNgEI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa665905-7d9e-4264-ef0b-08da90a61351
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:53:38.9141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ld5Rke+nPl5Rp9ti5JxgycSnEhz5t8xEkZYo9O7e5v4g0b5dtxNri6Y6twPuphjXLiTrJtrqm8RxjOsfNo+cHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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

R29vZCBwb2ludC4gTG9va3Mgd2UgbmVlZCB0byBkaXNhYmxlIEJBQ08gZW50cnkvZXhpdCB0b2dl
dGhlciwgbm90IGxpbWl0ZWQgdG8gcnVudGltZSBQTS4gSSB3aWxsIGRyb3AgdGhpcyByZXZlcnQg
YW5kIHByb3ZpZGUgYSBuZXcgcGF0Y2ggYWNjb3JkaW5nbHkuDQoNClJlZ2FyZHMsDQpHdWNodW4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNywgMjAyMiAxOjU4IFBN
DQpUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBRdWFuLCBFdmFu
IDxFdmFuLlF1YW5AYW1kLmNvbT47IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gUmV2ZXJ0ICJkcm0vYW1kZ3B1OiBkcm9wIHJ1bnRpbWUg
cG0gZGlzYWJsZW1lbnQgcXVpcmsgb24gc2V2ZXJhbCBzaWVubmEgY2ljaGxpZCBjYXJkcyINCg0K
DQoNCk9uIDkvNy8yMDIyIDEwOjIzIEFNLCBHdWNodW4gQ2hlbiB3cm90ZToNCj4gVGhpcyByZXZl
cnRzIGNvbW1pdCBlMjk5NGQyM2Q4YWZhMmZiNDY1ZmRiOGNmNTQ0YjczNmY2N2FiOGJhLg0KPiAN
Cj4gRnJlcXVlbnQgQkFDTyBlbnRlci9leGl0IHdpbGwgY2F1c2UgRU1JIGZhaWx1cmUsIHNvIGRp
c2FibGUgcnVudGltZSBQTSANCj4gb24gdGhlc2Ugc2VydmVyIFNLVXMuDQo+IA0KDQpBcGFydCBm
cm9tIHRoaXMsIGFueSBCQUNPIGVudHJ5L2V4aXQgaW4gcXVpY2sgc3VjY2Vzc2lvbiBjb3VsZCBj
YXVzZSB0aGUgc2FtZSBmYWlsdXJlLiBJZiBCQUNPIGlzIHVzZWQgZm9yIHJlc2V0IGluIHRoZXNl
IFNLVXMsIHRoYXQgYWxzbyBtYXkgbm90IHdvcmsuDQoNClRoYW5rcywNCkxpam8NCg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgMTMgKysrKysrKysrKysr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIA0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiBpbmRleCAxMzY5YzI1NDQ4ZGMuLjRm
NjQ3M2ZhYWYyNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ttcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMu
Yw0KPiBAQCAtNDMsNiArNDMsMTcgQEANCj4gICAjaW5jbHVkZSAiYW1kZ3B1X2Rpc3BsYXkuaCIN
Cj4gICAjaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIg0KPiAgIA0KPiArc3RhdGljIHZvaWQgYW1kZ3B1
X3J1bnRpbWVfcG1fcXVpcmsoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsNCj4gKwkvKg0K
PiArCSAqIEFkZCBiZWxvdyBxdWlyayBvbiBzZXZlcmFsIHNpZW5uYV9jaWNobGlkIGNhcmRzIHRv
IGRpc2FibGUNCj4gKwkgKiBydW50aW1lIHBtIHRvIGZpeCBFTUkgZmFpbHVyZXMuDQo+ICsJICov
DQo+ICsJaWYgKCgoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NzNBMSkgJiYgKGFkZXYtPnBkZXYt
PnJldmlzaW9uID09IDB4MDApKSB8fA0KPiArCSAgICAoKGFkZXYtPnBkZXYtPmRldmljZSA9PSAw
eDczQkYpICYmIChhZGV2LT5wZGV2LT5yZXZpc2lvbiA9PSAweENGKSkpDQo+ICsJCWFkZXYtPnBt
LnJwbV9tb2RlID0gQU1ER1BVX1JVTlBNX05PTkU7IH0NCj4gKw0KPiAgIHZvaWQgYW1kZ3B1X3Vu
cmVnaXN0ZXJfZ3B1X2luc3RhbmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHsN
Cj4gICAJc3RydWN0IGFtZGdwdV9ncHVfaW5zdGFuY2UgKmdwdV9pbnN0YW5jZTsgQEAgLTE3Niw2
ICsxODcsOCBAQCBpbnQgDQo+IGFtZGdwdV9kcml2ZXJfbG9hZF9rbXMoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+ICAgCQkJYnJlYWs7DQo+ICAgCQl9
DQo+ICAgDQo+ICsJCWFtZGdwdV9ydW50aW1lX3BtX3F1aXJrKGFkZXYpOw0KPiArDQo+ICAgCQlp
ZiAoYWRldi0+cG0ucnBtX21vZGUgPT0gQU1ER1BVX1JVTlBNX0JBQ08pDQo+ICAgCQkJZGV2X2lu
Zm8oYWRldi0+ZGV2LCAiVXNpbmcgQkFDTyBmb3IgcnVudGltZSBwbVxuIik7DQo+ICAgCX0NCj4g
DQo=
