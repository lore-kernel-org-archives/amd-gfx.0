Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54456C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 00:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B761E10E72F;
	Tue, 21 Jun 2022 00:46:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5C810E7D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 00:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHoIgSgWW65v/W8mni8mu2ThWE6IaUVhRaYLLS5+G/WGL8edmK9NTjL2kYhkTW0PMKMhQNqrjR83SL+GMPj65CvgkVffwfR3W0+nZnYgmXBBfhOHBGj7q+XDeZz2/gWPWb2L7ZSiN8pztVBSONMuzIBKwXm7G4clqSKzU//cxiVjbTpiih0K4zKVkDUiR0AQNbRjIAtZ+Vn/LnO3sNw3NXc/RW54Z626zpr12OTHEMO6DbnN+9tdlYv8BrkdTwtWv6topTv9lESUAfyjD/oKAiZM4x+0ydM4DqykKBuD1Mp2uFhe0e13wEonH1cxMqcL9TGDaudLFJyC2LNGt4HLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaS6qG0iGNC+9mZmdG+PphQRN0zeqJBaR+5NsagNtfw=;
 b=XNCabLiDAcEFFWp5XeUBEn4gGUDdSjsVWDITpsP3amoblHKNJH48Z9lydm7afFIuTcnzX9HJvvlXRbT3E1M1/TBg0N7nzYGhvXut3EUV6GCM21a+pDRfSE/+GAOtHjtdjyMQqS5nF8aOI+aSW7DH1j6bASaxoL9rlsq0RvLD7P0ycubXnTPEwuG25+KyYGejSRJTFPkjgdin0YciuwfYmI1QlcDfiwpyjjjZ9lr/qYjRxDE1zDlinidETQPL38661Y4o3osRE5MrmMnnKf3JH8D+h1tUwkbKyddLIhT8ZXuIjODo+jBEk+mg9Q0sp9KQTxWhDc8fBgtuMYjgvSIfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaS6qG0iGNC+9mZmdG+PphQRN0zeqJBaR+5NsagNtfw=;
 b=1J7K44Y8SUyd57BJ/zzznj3aS/VNxBAG+tGEqAfKUGkmBXd8VeXcvKDBeJO9uxKVBiZYCe2+gzmvqsBTOsmqKiwGfBl3DX7QHQ5VYUDxrSrYLT72kPZxCaGY4vVsBxPXA+YjxuBrtVpqyWDOIdYhsLYvhAitUio89t5OUkeTKAU=
Received: from MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 by BN6PR12MB1650.namprd12.prod.outlook.com (2603:10b6:405:3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 00:46:23 +0000
Received: from MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::a4a5:3b2f:9c38:54b7]) by MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::a4a5:3b2f:9c38:54b7%5]) with mapi id 15.20.5353.018; Tue, 21 Jun 2022
 00:46:23 +0000
From: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Joshua Ashton <joshua@froggi.es>
Subject: RE: [PATCH] amd/display/dc: Fix COLOR_ENCODING and COLOR_RANGE doing
 nothing for DCN20+
Thread-Topic: [PATCH] amd/display/dc: Fix COLOR_ENCODING and COLOR_RANGE doing
 nothing for DCN20+
Thread-Index: AQHYgR9tN0SF/uo4OkyZeO71BOytka1Y5mmAgAAnKZA=
Date: Tue, 21 Jun 2022 00:46:22 +0000
Message-ID: <MW4PR12MB5668626C2F2357142755239896B39@MW4PR12MB5668.namprd12.prod.outlook.com>
References: <20220616012127.793375-1-joshua@froggi.es>
 <CADnq5_NdAmAJ93A8ADVYzvYN=-hdWACxJyeBAfgmxc6_-RUq-Q@mail.gmail.com>
In-Reply-To: <CADnq5_NdAmAJ93A8ADVYzvYN=-hdWACxJyeBAfgmxc6_-RUq-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a3be71d-caaa-4f88-f77c-08da531f76d6
x-ms-traffictypediagnostic: BN6PR12MB1650:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1650FDFB02C67B70FFDEF45A96B39@BN6PR12MB1650.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JzjKEjdw72fB9HFhEOs0TSmtbScjO389y8jc6bHedeEP1L7JZ8wlkXK6CUqsN+mq9JsOW/G20YJOgckiTtApDOJxAG7GlVonpB9yNNFZPf/r9RLNEdivfjTh+JbU3AKCIlpk13Nnw/SYShQ3wEudjlNtcG1Wgj/ZkcsSTT2D/ebkbgEKRpmlxPF8ur52oRpkXTYQnuCajb4SUWdjJzlhtF4wdw+uUm8XAwPiDgR0xdhb1+wqRtjR9kE/UYjNooDMNhPNjz3ym1bvysVi6bTsTSu8fal1UG2oRX2Frozwy/axvwFIsealnSRwDiIZ0Q3H4SZ17FFFzrHvQ2YpPLiz2liznRpgVppFwkCHPEg8NVEnOXlP2aPigzlNGV+MkxLMsqox4pXuVMXGPezJNEyqAap2d+MjMhaqm0mW0EyA9rle6MgZpTqwIXkeyzFoVQI4Umv/oBG84gPEeutd96qzIzgckbzvsBK/Td/v2701/hRFUkatHnC6Q0EJK4IrIalxAY6dh5ug5F6RRqlgfLrrehjuXDFmySH7t+T92ai3qCJuSLN6nHuyOEPHZ1uO248Olro00BcQ4gisSNPF3fQC/3ng2c8vr1vK5Dt7GacDQV0rnolpcCOKfQ2cLsnJRhc8NTHLdfH77Rs7mRz3eg1YhvDmCgUGZCku2kz4/roUKQuhjVIg9meCMtnQbMPtNWWJEpgLCcXUjelmjiWrkYonph8Sfxf7FZXnyjT5CY2yfyY8P+Qa517gCE8jUhHVfWi8v6VjEGdbHdbPeClVi/eScVUYoh9hYaFLxUwa4fRukw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5668.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(6506007)(5660300002)(33656002)(41300700001)(55236004)(316002)(38100700002)(7696005)(2906002)(86362001)(122000001)(9686003)(26005)(4326008)(55016003)(83380400001)(76116006)(66476007)(66556008)(66946007)(66446008)(478600001)(64756008)(71200400001)(52536014)(966005)(186003)(110136005)(38070700005)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjRxWUZnWHd1VFpKMklsNXU0bXZxZWw3Vm5RY3pvWVM4S0FKVzhGTW5Md2VS?=
 =?utf-8?B?THBxOUJsSG5mQUxsZFJTQ05xSG96QlYxK1ZyRzYzQlhXRDRObzdQZ0g2bHZr?=
 =?utf-8?B?dElYWTJ1YWlTcTEvUTNpYS9kSmRTOTQ2b043N3lLY1E1WHZibGsya0JHS1FU?=
 =?utf-8?B?L2NuR0lhTXdSdG55UGJNbHI0UDJDelllVTlhWnphazRsbS85cjA4TVBkdXk0?=
 =?utf-8?B?cjBYMWxaaUtnL2VYNzVQRlozYXh1NFZvaEZUN21WRmtESmpTQUFsZGZ3VWdY?=
 =?utf-8?B?Y2xzT2NlamxTSDBCZDhFelFvbHdpUXI4bkZmNDZLSzQxZ2pyT2gyT1JadTV5?=
 =?utf-8?B?eGhIajlGTTB2d2dwYjcydWJLQ3RabzNTdjNzcWtXbzNuYXlDblBsdDhkYTRJ?=
 =?utf-8?B?RGJFWTg0UEQ3Zm84Z3RuNVBWMFF6aVR0UTdzNmNxTC9tZnFhc3FTbEJubGhJ?=
 =?utf-8?B?Q1BTM2xPN04xOFRBNllheS9mZmJJNGsrSlBFaTFveFB5aS9MYW9RT1ZCT3p3?=
 =?utf-8?B?dE5ZSEZPaUMrT1MzWGFOUEZ3VVFEV0RkU0htTVdXcTV5YlhTRHNzU0RxS0h4?=
 =?utf-8?B?RExyTnBwOE5ETHRENG52ZkRZSnNtbDlTcEFWa25PcmsrQnorRHpoVDJmK0FI?=
 =?utf-8?B?WStHWnVNMCtkL3NLZXh3VmFPZTJhaytxdHdrOWhSZWlEK21CbjJ6d1BSejZr?=
 =?utf-8?B?SFJtU0RlVkdmd1FhRUd0aS9CdmlnZFBZa1R0Wk1sRDVGbGNHa1llUDNTMVYw?=
 =?utf-8?B?eVJFcUw4UzZLbCtXcEpHR1VZZ05SWDluRTVVOU9KZFBLOGhkZFJUVFovQzV5?=
 =?utf-8?B?bXZyMndQRysrT2hSVTdhN2g4SkEzOFdRdXBPeGMralV3ZkRwdkpkcUxZdEJS?=
 =?utf-8?B?UVROMXlSTnJxYXdqR0lKNDFrdzcySzR5dDBLM0FYSW9OTk42RXJmTUdUZHpW?=
 =?utf-8?B?YjlMK1ZpeFN1N1hzNE92bEFoRkwrMTF1VjNTZU9JL2QzVDlCK1lRNVN4VSs2?=
 =?utf-8?B?Smh0OFc4bTB0dnFXMHFqUjRnN1c1bTRoY2hRYzVhbit2SzhieTVENVpWWit4?=
 =?utf-8?B?QW5HRGhBTkdkdFh3d3VSNVJKMUpQNzU2c2JIY1FTQnJJWDBWSVpZZ2xLRjNh?=
 =?utf-8?B?RjlPUjNrVHR1R0V1QkV1RmdBSnpoY3YzT3ozbXp5UEszcGJkc0g0OWlFWmpq?=
 =?utf-8?B?YkhVSE9qeHFCa0IzSC8wUDFkUGd3dWhjL0ErdiswOC9FaTNDb1BBVjh1UGdG?=
 =?utf-8?B?K1p3YXJTL21PdDVPMmlzOTZBbHo2MkJCS2V4YlltZU56TWNuc2JDNTdCQ2dW?=
 =?utf-8?B?cHJDdDFIQ1ZuTy9BTHBOTUY0M3QzY3puREdNc1J2UCtXZXJsRkdiNkhmcEN2?=
 =?utf-8?B?S25YS1hCSjgvR0RVR0pqZVg3c0Q1WDBKNmptNE9xZExXNENrQm9JRGNGRm5N?=
 =?utf-8?B?ZFQzam9IYUpNWGNSOVo3OUpaTTJnV0grcnFBYTNqSTV4MUJBekxtOEo1SHB0?=
 =?utf-8?B?dHY3MDdOZG9aZk9KMzhEZEZFMGJMTEdHNkI5eW5kaGo0M2RiTUVkdlNjanFV?=
 =?utf-8?B?MFJpR0dFN1g3cTF4ek9lL3hWUTNBWUlKdHYxa05oTHdLdzlnV1duN045UHo5?=
 =?utf-8?B?TDFldGVBZnlhMXFUZFFNVWgxZStFWHZWVlVJWlE5VlVRb1krd3lwVDREdXg3?=
 =?utf-8?B?aUMzNmVRM3pTY01rS05RQmdVWktPRlJvQWZHbWczemtqSHE2a2ZlY2ZDRGcr?=
 =?utf-8?B?Vm1vSWpPdm5wUTVrM1I0Y0lBVERvdXdEdi9uc1VKYW9xQWRiSDZORzN0RU5L?=
 =?utf-8?B?Rk9jSnVaUUIra3NLekh6cXhGQ2NUMEl5OVBYeTFNSVdBeEI4bEZkRzhnY25C?=
 =?utf-8?B?QWxEY3Qwd0NWSmJyWFVuZ284UklzQStSRTROOTFHc3dabG1wMDB5MUJLdS9H?=
 =?utf-8?B?R3hCM1dLWTJWWS9YcTYweTlxOFVnd2w0THFVaElKeEJ5UHhCcW1JM3lyTDI2?=
 =?utf-8?B?T3dWemMyTWo1TVJRUlFiSnJRbGdoSGhiNGNwd2xHYjRUNnZjSkhvVTBXWUFJ?=
 =?utf-8?B?WlY0VVJzb0xqY0RwRW8rQWdxSEhyWnFBT2Z6dFJYVjV5MWszSUxZa3dkdGF3?=
 =?utf-8?B?bGV0NVNnaThKWlpKeUhKL1BRTWlOb3ZWUVc3dkEvMW5BM0xldkt6R0Nrbmh1?=
 =?utf-8?B?MmVPK1owbjJKQVB1akE2QjAxRllEWmR6dzFnb1RzbGZMZ21WcU9ZT3lSRTJQ?=
 =?utf-8?B?TThzYjNLRDhoYnpnQS9EaEZ0K0tWdWhNdUdiVGt3cmp6dGZVOXFRbVkySmw2?=
 =?utf-8?B?RGRHSGJ0dnluTjNjSEIwaWhkbHBHOGFYM09hekFaYzhvdjZoYndtdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5668.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3be71d-caaa-4f88-f77c-08da531f76d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 00:46:22.8612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yffVYxXw0T5ZXJhMqBbAaykBRbEQ0rUo9XuwbS7qgbGbcynGeXQ2W0KHFMpSSEU+WyVr8+mAjOcNVn0YJ+i5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1650
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxleCwNCg0KSSB0aGluayB0aGlzIHdhcyBwdXNoZWQgZWFybGllciBieSBIYXJyeS4NCk5v
dCBzdXJlIHdoeSBpdCBkaWQgbm90IGdldCBtZXJnZWQuDQpodHRwczovL3d3dy5zcGluaWNzLm5l
dC9saXN0cy9zdGFibGUvbXNnNTQzMTE2Lmh0bWwgaGFzIHRoZSBoaXN0b3J5Lg0KDQpCUiwNCkNo
YW5kYW4gViBODQoNCj5BcHBsaWVkLiAgVGhhbmtzIQ0KPg0KPkFsZXgNCj4NCj5PbiBXZWQsIEp1
biAxNSwgMjAyMiBhdCA5OjIxIFBNIEpvc2h1YSBBc2h0b24gPGpvc2h1YUBmcm9nZ2kuZXM+IHdy
b3RlOg0KPj4NCj4+IEZvciBEQ04yMCBhbmQgYWJvdmUsIHRoZSBjb2RlIHRoYXQgYWN0dWFsbHkg
aG9va3MgdXAgdGhlIHByb3ZpZGVkIA0KPj4gaW5wdXRfY29sb3Jfc3BhY2UgZ290IGxvc3QgYXQg
c29tZSBwb2ludC4NCj4+DQo+PiBGaXhlcyBDT0xPUl9FTkNPRElORyBhbmQgQ09MT1JfUkFOR0Ug
ZG9pbmcgbm90aGluZyBvbiBEQ04yMCsuDQo+PiBUZXN0ZWQgdXNpbmcgU3RlYW0gUmVtb3RlIFBs
YXkgVG9nZXRoZXIgKyBnYW1lc2NvcGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9zaHVhIEFz
aHRvbiA8am9zaHVhQGZyb2dnaS5lcz4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9kcHAuYyAgIHwgMyArKysNCj4+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAxL2RjbjIwMV9kcHAuYyB8IDMgKysrDQo+PiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMwL2RjbjMwX2RwcC5jICAgfCAzICsrKw0KPj4g
IDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9kcHAuYyANCj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2RwcC5jDQo+PiBpbmRleCA5
NzBiNjVlZmVhYzEuLmVhYTcwMzJmMGYxYSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9kcHAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2RwcC5jDQo+PiBAQCAtMjEyLDYgKzIxMiw5
IEBAIHN0YXRpYyB2b2lkIGRwcDJfY252X3NldHVwICgNCj4+ICAgICAgICAgICAgICAgICBicmVh
azsNCj4+ICAgICAgICAgfQ0KPj4NCj4+ICsgICAgICAgLyogU2V0IGRlZmF1bHQgY29sb3Igc3Bh
Y2UgYmFzZWQgb24gZm9ybWF0IGlmIG5vbmUgaXMgZ2l2ZW4uICovDQo+PiArICAgICAgIGNvbG9y
X3NwYWNlID0gaW5wdXRfY29sb3Jfc3BhY2UgPyBpbnB1dF9jb2xvcl9zcGFjZSA6IA0KPj4gKyBj
b2xvcl9zcGFjZTsNCj4+ICsNCj4+ICAgICAgICAgaWYgKGlzXzJiaXQgPT0gMSAmJiBhbHBoYV8y
Yml0X2x1dCAhPSBOVUxMKSB7DQo+PiAgICAgICAgICAgICAgICAgUkVHX1VQREFURShBTFBIQV8y
QklUX0xVVCwgQUxQSEFfMkJJVF9MVVQwLCBhbHBoYV8yYml0X2x1dC0+bHV0MCk7DQo+PiAgICAg
ICAgICAgICAgICAgUkVHX1VQREFURShBTFBIQV8yQklUX0xVVCwgQUxQSEFfMkJJVF9MVVQxLCAN
Cj4+IGFscGhhXzJiaXRfbHV0LT5sdXQxKTsgZGlmZiAtLWdpdCANCj4+IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwMS9kY24yMDFfZHBwLmMgDQo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMDEvZGNuMjAxX2RwcC5jDQo+PiBpbmRleCA4YjY1MDVi
N2RjYTguLmY1MGFiOTYxYmMxNyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMDEvZGNuMjAxX2RwcC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNuMjAxL2RjbjIwMV9kcHAuYw0KPj4gQEAgLTE1Myw2ICsxNTMsOSBA
QCBzdGF0aWMgdm9pZCBkcHAyMDFfY252X3NldHVwKA0KPj4gICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPj4gICAgICAgICB9DQo+Pg0KPj4gKyAgICAgICAvKiBTZXQgZGVmYXVsdCBjb2xvciBzcGFj
ZSBiYXNlZCBvbiBmb3JtYXQgaWYgbm9uZSBpcyBnaXZlbi4gKi8NCj4+ICsgICAgICAgY29sb3Jf
c3BhY2UgPSBpbnB1dF9jb2xvcl9zcGFjZSA/IGlucHV0X2NvbG9yX3NwYWNlIDogDQo+PiArIGNv
bG9yX3NwYWNlOw0KPj4gKw0KPj4gICAgICAgICBpZiAoaXNfMmJpdCA9PSAxICYmIGFscGhhXzJi
aXRfbHV0ICE9IE5VTEwpIHsNCj4+ICAgICAgICAgICAgICAgICBSRUdfVVBEQVRFKEFMUEhBXzJC
SVRfTFVULCBBTFBIQV8yQklUX0xVVDAsIGFscGhhXzJiaXRfbHV0LT5sdXQwKTsNCj4+ICAgICAg
ICAgICAgICAgICBSRUdfVVBEQVRFKEFMUEhBXzJCSVRfTFVULCBBTFBIQV8yQklUX0xVVDEsIA0K
Pj4gYWxwaGFfMmJpdF9sdXQtPmx1dDEpOyBkaWZmIC0tZ2l0IA0KPj4gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzAvZGNuMzBfZHBwLmMgDQo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24zMC9kY24zMF9kcHAuYw0KPj4gaW5kZXggOWNjYTU5YmYyYWUw
Li4zYzc3OTQ5YjgxMTAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMzAvZGNuMzBfZHBwLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24zMC9kY24zMF9kcHAuYw0KPj4gQEAgLTI5NCw2ICsyOTQsOSBAQCB2b2lkIGRw
cDNfY252X3NldHVwICgNCj4+ICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAgfQ0K
Pj4NCj4+ICsgICAgICAgLyogU2V0IGRlZmF1bHQgY29sb3Igc3BhY2UgYmFzZWQgb24gZm9ybWF0
IGlmIG5vbmUgaXMgZ2l2ZW4uICovDQo+PiArICAgICAgIGNvbG9yX3NwYWNlID0gaW5wdXRfY29s
b3Jfc3BhY2UgPyBpbnB1dF9jb2xvcl9zcGFjZSA6IA0KPj4gKyBjb2xvcl9zcGFjZTsNCj4+ICsN
Cj4+ICAgICAgICAgaWYgKGlzXzJiaXQgPT0gMSAmJiBhbHBoYV8yYml0X2x1dCAhPSBOVUxMKSB7
DQo+PiAgICAgICAgICAgICAgICAgUkVHX1VQREFURShBTFBIQV8yQklUX0xVVCwgQUxQSEFfMkJJ
VF9MVVQwLCBhbHBoYV8yYml0X2x1dC0+bHV0MCk7DQo+PiAgICAgICAgICAgICAgICAgUkVHX1VQ
REFURShBTFBIQV8yQklUX0xVVCwgQUxQSEFfMkJJVF9MVVQxLCANCj4+IGFscGhhXzJiaXRfbHV0
LT5sdXQxKTsNCj4+IC0tDQo+PiAyLjM2LjENCj4+DQo=
