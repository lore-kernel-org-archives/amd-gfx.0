Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FE2C55179
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FD810E60D;
	Mon,  3 Aug 2026 13:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JMWc/VYn";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8E310E60D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aykwN92W167vNY5/uFRW0Wf6LBGhp1LPexZPdbfHYp/FJrmKU6tzpoZqA9gV1R41RfuZ/nEO042F7WRjFCGEMjqRzLMbYjoWV9rnWISqqOhCuZFvQ+gfVShRnPADeEbSWUuDyWr9CE4w8FJe9EbF1JY/8jDLP0WuGHmQbTrMzcf+K3t5FjiL4lYZu1FXdq2+BhSRXJyIrN46kZZHZcK5a6JmZaVaAlx3brJ15DnusgDyVAj3UnbXoHnZnNF4q9ByADAFjwoshEdgHtv1dRW2lyBTWAv8oymbIpybwXb8yCFI3xI4Z2fLZF0ZzZkeOU4b1/P4Yz3YFYrd7R9n8wyxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzP7+oZY1b0b3/ppRVFyYAdVGOEfGIvkgiQI9xO3WpM=;
 b=x3OIapEkesOi/A3dQoKnNTwefKEBZODr3nZaflZLpZJYZ8NGT0t3PGFQYjtQ4MPheePeT8FIZf/EBDBI2MR4q12YjcGsAgATDG9V4o73NQ8azqaadXG084gkDIVDLaetqz06U63X92CJP6vhmB2L9bJRH0ovmdVDDFxGVqTmgll76pAsYaFy+CvhNCR21oiDYjEInMYOiK3d5zAwrcn6aA/FMI3hzi+Qn7FRTH5JTB8CHf5rthuJ48N6lxirr3EkZUtPzkVU3xDEOlVu9o3pzrz09EuAhy9UrxYBeh7Uo+l16IPwtOv7iGFbM473NZE8kdcJ4ic3eH+k7XD9HMRmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzP7+oZY1b0b3/ppRVFyYAdVGOEfGIvkgiQI9xO3WpM=;
 b=JMWc/VYnOYnBpIqxK75SkoUZcZcTHm/plEmi3ltg7Cc2R4mzaORTH1dy80Kd8QZNI7qLWQG/HaUXnRPYcA4/he5xTI6uvWsg0wMYAT1cUgvTQtPHTXVZSTKBoLqZUIBxj/6RowStmsrPunvLkjwnKGTJZvnyVFOSDx2yvKuOpqU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Mon, 3 Aug 2026 13:36:46 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 13:36:46 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq reset
Thread-Topic: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq
 reset
Thread-Index: AQHdFCOgnbCr85VDm0SiIcpJNE08b7Z6sLoggBF2puCAAEaogIAAATBw
Date: Mon, 3 Aug 2026 13:36:46 +0000
Message-ID: <DS7PR12MB6005E76101209F514B1544D9FBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260715063128.581232-1-Prike.Liang@amd.com>
 <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
 <PH7PR12MB60005AAE1676A52D0A72A0C4FBD52@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_MeA+koAWeUF1L5WnLCeB-c=W2n0nnLzY3fpguOQprGgw@mail.gmail.com>
In-Reply-To: <CADnq5_MeA+koAWeUF1L5WnLCeB-c=W2n0nnLzY3fpguOQprGgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-03T13:26:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CYYPR12MB8752:EE_
x-ms-office365-filtering-correlation-id: 602d4ccf-6278-4221-36e4-08def164434e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|11063799006|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: CcqvMAnl3qtvEWl44F0DNk5UMVtUmua5xts8LW8gNycQfKjqpJnaj9ZA5fPy06yvKYq14yBn3PCCDrqaRgkf0fjv4NjBj0zrTRUYeFD58rUanYWANnthBFGtVLM8V1PsbsEh+U/bORnbXxOqFF+dpAnWGGjH3dbnI8l/xyF/jnUPfLN1mUrIriLrOGnDpZCbsVKz/hPR6NdDSzhcYUOz94ZZ3VjIrF47p0MCsvvEpGoAnaZq3VhsnmwKOB+1HL7GSRZvAuc2nmOuAt3wAG55q57q/GuPKvb144H72gl5qlEW7epQqcBWfnDZoDEaEUftVhnUDkokvOYOWLfxEx0fcejuX3trl93+y2dM3ozUf711SqghooUl/2UClrSnUrDb0pgKT+4CVSON5/PRgk74O5NvFDP74IayN49PgRw8YzAQVx6RNbOmHS13pk0OZoVrdYl3FeFw5uLiJ1H+/6ztcZ3h36HHQK9O/Zrfhnm4cmxuzXbAfyClvu5iyGeXJitBk20F4K075L8qFcycVdLxHbsaAKBBk8m0tMAvhHsjSug13NQP6i5wbCMMceKtSBzLlKVv+3HahV5sK/44uvYJTaGuv3yoDV1/gR+jjH37DAvfSxUdeAqWiQVqI23ufwjlnVhs1hA7kwXDpksoLOk+vuOUkk3BXR3/g9jLxInKEaMD+N/R7AdHugAbseis8qaZeZsl5IcQnhmHsRpPrIm2WquMu3/CPBwheDQFJ0xileQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHFOMGRSREJ0UExRQ1l6MVQ2THdrV0c1dW9vc0VGQytQbHRQVW1UcStOeEZH?=
 =?utf-8?B?aEs0SSs0aHdkVEhoYjFPejZsdGFtVW1SQXZIVzZpamIrOCtvQ3dLOFdkSXBj?=
 =?utf-8?B?QVE2aEJnMisxRGpXRDFqdTliUktjNlRaVkNKODZuODVheXVMSTlkWXJmdXdy?=
 =?utf-8?B?YkxvYys3Z2UraFdIamhuOGxKTkhycit4SzdaaVdORHdVKzd0N2lEUStKRkpN?=
 =?utf-8?B?UG9kc21ubnVhMm92SlpSdExBczY1YkVxSjk4MHE1QVlZVE9YVVdxVzF4M1V2?=
 =?utf-8?B?VTNNU21iSTlPWkVjUkFMU0p2aXdwc00yMktsWUJxdkJqK3cwdjIrMEZZZEhY?=
 =?utf-8?B?L3ZGVFduWGJqWlRacyt5UWZUUFZPRjJGc09PM1hhaXFHOHhTbkl5bVNvUjQ0?=
 =?utf-8?B?Q2UvVTJLWGt0ODRGeEtRMTNlSDlZQm94TGQxSzU4WmlieFAwQ3RHMHQ4RjFM?=
 =?utf-8?B?cFVTaUdqekwyd0Rkcm9Kd0RlZlpQVFlWNVJrdXFaVmtiNm1ka1puV1ZnSDc0?=
 =?utf-8?B?RU5kYzdjSG1nQkxsdFFYTUhSVGtVWWRmYmpvN0ZORTFHeWwxWHoxVE8rU2hY?=
 =?utf-8?B?YWVpZFg2Y1BDd0M2amV5YVp0L1VRSXhjYkdHWkgvOEU3Lzd1Mzh5Vm1KTVEx?=
 =?utf-8?B?aE84SEJvd1NEcGJxeWlNUk5wNllWOFJpZU5oMzI5UExBbUM2Vm9oZGc3dngv?=
 =?utf-8?B?SjBIaERVaEVheEhkcVIxSElzeG5uVzZyRGlyUW1iUkpVbGFDSW41aWk2YzNT?=
 =?utf-8?B?SzNES1lLRnFDVHllMk02ejZiVnF5UVlya1NzMDZkMG1nMXBXTXN2UXlYZjRC?=
 =?utf-8?B?L0tlSWtDMUxBcjhPeXVmYVZDZU1XZ083b0ZRcFhiOTRINURnVFg0emZoT3Nu?=
 =?utf-8?B?OEw5Wjl3eTBoWVcwVDA2VVVrTHgwTEpGY2dQeUd6cFNNaTMycFcyK1FiNEJQ?=
 =?utf-8?B?RTlJWjIyS1E1KzRJcWozKzRoL2J3TVV6aVg5SVg5cktVdzZyQXJFN25pdzU2?=
 =?utf-8?B?ZVc1RG03Z2l4YUVteVdQbFNxL3RwRFJDaHVFL3gyOGd3cWd3cUFpdFJXZm8x?=
 =?utf-8?B?RTc2MTR6V1haTjBxRU90cWYvWVgzRy9weXpManBQLzRpbDZZZnFPMGJnQ0Js?=
 =?utf-8?B?ME80dVZnU3FTeXFld2N3WFZVQXF4b0ZhVWVyVnEzLzB2bk9iNVVxUll4R096?=
 =?utf-8?B?dHpKT0o5UjJlNVpjSVd3K1FZdmViMHNObTM4dkJ0MmMycDBQdll5Z2FjK1E5?=
 =?utf-8?B?cFBFdFVPV2wxRVJ5cDNTS2xZRkY5SklhcERON1c3ckMzWmZ0aXd5R25UOTd2?=
 =?utf-8?B?WGtNNVpOWWdYRmprc0hiY3hjaVJNaUZkTDUxNTFCTTBYeCt0NmRWMGIwc0JP?=
 =?utf-8?B?aE1VSU1MU0RhYmNPU2tuWHo1Z0pZTFhIenJnSDQyYk5pSi8vMzN5ZVJCWi9E?=
 =?utf-8?B?MCtHSm5UazBxY3ZKMjNHRlhieFVQU3dNNzgyMVBFVG9rYVZXaFVCYWhXeXRx?=
 =?utf-8?B?MDhUZXZKVEh0MEVVZnFtU2xRbCtkQURxNk9BcVg4MDVTMEVEMEgrbkdHUCt5?=
 =?utf-8?B?Sk85Z0p5Y1pVTnZQN2dNd2hDcDMrbmtJemVqK3VGY3UrOG5XVGJSMzk5QnhV?=
 =?utf-8?B?d0xGWkRDTW1sTHY1S0JBcWlQS1o2WHk5aUIzV2RFbFhxK3NWSjdKeWU5MVFT?=
 =?utf-8?B?TDYyY01GMVZ6LzFwN3I4ZVBWeW9xcHJlUENTQ3dYN3FWSUYrKzJwRHRRWjlz?=
 =?utf-8?B?S2VDSHAyVWVKNnNXbEh6dEZoaEE5V1dQbEpCQks0ZGVlQkRlTkZFeHR2YlpG?=
 =?utf-8?B?SmFjZ3JLMTg1QldKTm9waUtYcTl6VHZINEZHL2doWUovRmhDQzFtQlVScUJh?=
 =?utf-8?B?ZXlpTit5OE8zMUQ5SXNoQTYxeitVeXVhMVVSK20zWlpvQ0kxTDlqVzFoeW5o?=
 =?utf-8?B?QmVIbUlOZ2t0TzdYRVVBdlcya2xxUjRvTzNyOHhjZFJLSDBXM3BBSzljUTZE?=
 =?utf-8?B?c2c5eDJua3pWQzk4Q1lBSzk3ZHowK1R5S2lIVGNsbHRWM2N4Z0g1dEd3Ykt4?=
 =?utf-8?B?YkwzQVpyRGlMcmVDbzJlam9lT1dJU3FKdUoyNnV0R2FqQk1aemVuNWx0QzVP?=
 =?utf-8?B?a0VQVDRIZS9jWFkwUk51RHJqbFdaR1NseC84N1N0VDJaWnN1TWNSSU8yQjE2?=
 =?utf-8?B?S21uUVdpMXRNYlI5aXNRZ1k5SmNBSTFvalRQQkVHWnpNTmp5S2xUUmozWHU3?=
 =?utf-8?B?cGtQTExVYmdPNWJRS2tmbVk3cUxhNnlScTJtZldtWXVIV21TSjJaK2lqdE5l?=
 =?utf-8?Q?9a/Q7i4lie06touCNq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602d4ccf-6278-4221-36e4-08def164434e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 13:36:46.0893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69xpOMhYzGlpIUmtmncqEqLN+E6YGr5c0f/terGRW07TuKm1rPl3HS7zhnYwiTZ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDMsIDIwMjYgOToyMyBQTQ0KPiBUbzogTGlhbmcsIFBy
aWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPjsNCj4gTGl1LCBT
aGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IFJlbW92
ZSBzZXBhcmF0ZSBndWlsdHkgY29tcHV0ZSB1c2VycSByZXNldA0KPg0KPiBPbiBNb24sIEF1ZyAz
LCAyMDI2IGF0IDU6MjXigK9BTSBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gQU1EIEdlbmVyYWwNCj4gPg0KPiA+IEFzIGZvciB0aGUgaHVuZyB1c2Vy
cSwgaXQgc2hvdWxkIGJlIGlkZW50aWZpZWQgYnkgdGhlIE1FUyByZXNldCBBUEkgd2l0aCB0aGUN
Cj4gaGFuZ19kZXRlY3Rfb25seSBzZXR0aW5nLiBIb3dldmVyLCBpdCBpcyB1bmxpa2VseSB0byBt
aXNzIGRldGVjdGluZyB0aGUgaW52YWxpZCBvcGNvZGUNCj4gaGFuZyBjYXNlLCBlc3BlY2lhbGx5
IGdpdmVuIHRoYXQgdGhlIHVzZXJxIGludmFsaWQgb3Bjb2RlIElHVCB0ZXN0IGhhcyBub3QgYmVl
bg0KPiBpbXBsZW1lbnRlZCB5ZXQuDQo+ID4NCj4gPiBIaSBATGl1LCBTaGFveXVuLCBhcmUgeW91
IGF3YXJlIG9mIGFueSBrbm93biB1c2VycSBoYW5nIHNjZW5hcmlvcyB0aGF0IGNhbm5vdA0KPiBi
ZSBpZGVudGlmaWVkIGJ5IE1FUyBBUEkgaGFuZ19kZXRlY3Rfb25seT8gSWYgbm90LCBjb3VsZCB5
b3UgcGxlYXNlIGhlbHAgcmV2aWV3IHRoZQ0KPiBmb2xsb3dpbmcgcGF0Y2gsIHdoaWNoIHVuaWZp
ZXMgdGhlIHVzZXJxIHJlc2V0IHBhdGggZm9yIGh1bmcgcXVldWVzPw0KPiA+DQo+DQo+IFdlIGFk
ZGVkIGl0IGluIHRoZSBmaXJzdCBwbGFjZSB0byBkZWFsIHdpdGggdGhvc2UgY2FzZXMuICBUaGVy
ZSBjYW4gYmUgcXVldWVzIHdoaWNoDQo+IGFyZSBub3QgaHVuZywgYnV0IHdpbGwgbmV2ZXIgY29t
cGxldGUgYW5kIGhlbmNlIG5ldmVyIHNpZ25hbCB0aGVpciBmZW5jZS4gIEUuZy4sIHlvdQ0KPiBj
YW4gaGF2ZSBhIHF1ZXVlIHRoYXQgaXMgd2FpdGluZyBvbiBhIG1lbW9yeSBsb2NhdGlvbiB0aGF0
IE1FUyBjYW4gcHJlZW1wdCwgYnV0DQo+IGR1ZSB0byBhIGJ1ZyBlbHNld2hlcmUgdGhhdCBtZW1v
cnkgbG9jYXRpb24gd2lsbCBuZXZlciBjaGFuZ2Ugc28gdGhlIGZlbmNlIHdpbGwNCj4gbmV2ZXIg
c2lnbmFsLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBpbnB1dC4gSG93ZXZlciwgZm9yIGZha2UgdGlt
ZW91dCBjYXNlcyBzdWNoIGFzIHRoZSBsb25nIHNoYWRlciBzY2VuYXJpbywgd2Ugc2hvdWxkIGlk
ZW50aWZ5IHRoZSBmYWtlIGhhbmcgY2FzZXMgYnkgY2hlY2tpbmcgd2hldGhlciB0aGUgZ3VpbHR5
IHF1ZXVlIGFwcGVhcnMgaW4gdGhlIGhhbmcgbGlzdCwgb3Igd2hldGhlciB0aGUgcXVldWUgcnB0
ciBpcyBzdGlsbCB1cGRhdGluZz8gSWYgc28sIHByZWVtcHQgdGhlIHF1ZXVlIHJhdGhlciB0aGFu
IHJlc2V0dGluZyBpdD8NCg0KPg0KPiBBbGV4DQo+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICBQ
cmlrZQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
TGlhbmcsIFByaWtlDQo+ID4gPiBTZW50OiBUaHVyc2RheSwgSnVseSAyMywgMjAyNiAyOjM4IFBN
DQo+ID4gPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBKZXNzZShK
aWUpDQo+ID4gPiA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gPiA+IENjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsDQo+ID4gPiBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0gg
MS8yXSBkcm0vYW1kZ3B1OiBSZW1vdmUgc2VwYXJhdGUgZ3VpbHR5IGNvbXB1dGUNCj4gPiA+IHVz
ZXJxIHJlc2V0DQo+ID4gPg0KPiA+ID4gSSBjaGVja2VkIGVhY2ggZGlmZmVyZW50IHVzZXJxIGhh
bmcgY2FzZXMsIGFuZCB0aGUgZ3VpbHR5IHVzZXJxIGNhbg0KPiA+ID4gYmUgaWRlbnRpZmllZCBi
eSB0aGUgTUVTIGZpcm13YXJlIGFuZCByZXBvcnQgY29ycmVjdGx5LiAgQFpoYW5nLA0KPiA+ID4g
SmVzc2UoSmllKSBjb3VsZCB5b3UgZnVydGhlciBjaGVjayBhcyB3ZWxsIGF0IHlvdSBzaWRlPw0K
PiA+ID4NCj4gPiA+IElmIHRoZXJlJ3JlIHNvbWUgaGFuZyBxdWV1ZXMgbWlzcyBpZGVudGlmaWVk
IGJ5IE1FUyBmaXJtd2FyZSwgdGhlbg0KPiA+ID4gdGhlIGNvcnJlY3QgdGhpbmcgaXMgdG8gZnVy
dGhlciBkZWJ1ZyBmcm9tIE1FUyBmaXJtd2FyZSBzaWRlIHJhdGhlcg0KPiA+ID4gdGhhbiBoYXZl
IHN1Y2ggc3RyYW5nZSByZXNldCBzZXF1ZW5jZSBhbmQgdGhpcyByZXNldCB3b3JrYXJvdW5kIHNo
b3VsZCBiZQ0KPiBjbGVhbmVkIHNvb25lciBvciBsYXRlci4NCj4gPiA+DQo+ID4gPg0KPiA+ID4g
UmVnYXJkcywNCj4gPiA+ICAgICAgIFByaWtlDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFt
ZC5jb20+DQo+ID4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxNSwgMjAyNiAyOjMxIFBNDQo+
ID4gPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4gPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLA0KPiA+
ID4gPiBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExpYW5nLCBQcmlrZQ0K
PiA+ID4gPiA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiA+ID4gU3ViamVjdDogW1BBVENIIDEv
Ml0gZHJtL2FtZGdwdTogUmVtb3ZlIHNlcGFyYXRlIGd1aWx0eSBjb21wdXRlDQo+ID4gPiA+IHVz
ZXJxIHJlc2V0DQo+ID4gPiA+DQo+ID4gPiA+IGFtZGdwdV9tZXNfZGV0ZWN0X2FuZF9yZXNldF9o
dW5nX3F1ZXVlcygpIGFscmVhZHkgZGV0ZWN0cyB0aGUNCj4gPiA+ID4gZ3VpbHR5IGNvbXB1dGUg
dXNlciBxdWV1ZSBhbmQgcmVzZXRzIGl0IHRocm91Z2gNCj4gPiA+ID4gbWVzX3VzZXJxX3Jlc2V0
X3F1ZXVlKCkuIFRoZSBhZGRpdGlvbmFsIHJlc2V0IHZpYQ0KPiA+ID4gPiBtZXNfdXNlcnFfcmVz
ZXQoKSBpcyB1bm5lY2Vzc2FyeSwgc28gcmVtb3ZlIGl0IHRvIHVuaWZ5IHRoZSBjb21wdXRlIHVz
ZXJxDQo+IHJlc2V0Lg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFu
ZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgICAgfCA1IC0tLS0tDQo+ID4gPiA+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMgfCAyIC0tDQo+ID4gPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiA+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiA+ID4gaW5kZXggMWUy
NzVjMmU3ZGQzLi40ZjJkNWZmMmY3YmUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiA+ID4gQEAgLTIzMTUsMTEgKzIzMTUsNiBA
QCBpbnQgYW1kZ3B1X2dmeF9yZXNldF9tZXNfY29tcHV0ZShzdHJ1Y3QNCj4gPiA+ID4gYW1kZ3B1
X2RldmljZSAqYWRldiwNCj4gPiA+ID4gICAgICAgICAgICAgZGVmZXJyZWRfZW5kW25fZGVmZXJy
ZWRdLmZlbmNlID0gZ3VpbHR5X2ZlbmNlOw0KPiA+ID4gPiAgICAgICAgICAgICBuX2RlZmVycmVk
Kys7DQo+ID4gPiA+ICAgICB9DQo+ID4gPiA+IC0gICBpZiAodXEpIHsNCj4gPiA+ID4gLSAgICAg
ICAgICAgciA9IG1lc191c2VycV9yZXNldCh1cSk7DQo+ID4gPiA+IC0gICAgICAgICAgIGlmIChy
KQ0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ID4gPiAtICAgfQ0K
PiA+ID4gPiAgICAgZm9yIChpID0gMDsgaSA8IG51bV9odW5nOyBpKyspIHsNCj4gPiA+ID4gICAg
ICAgICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpociA9IE5VTEw7DQo+ID4gPiA+ICAgICAgICAg
ICAgIHN0cnVjdCBhbWRncHVfZmVuY2UgKmhmID0gTlVMTDsgZGlmZiAtLWdpdA0KPiA+ID4gPiBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+ID4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+ID4gPiBpbmRleCBi
NmJmYTM5NzQ4MzkuLmZhYjIxZDQyNzVmMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+ID4gPiBAQCAtMjI2LDggKzIy
Niw2IEBAIGludCBtZXNfdXNlcnFfcmVzZXRfcXVldWUoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4g
PiA+ID4gKmFkZXYsDQo+ID4gPiA+DQo+ID4gPiA+ICAgICB4YV9mb3JfZWFjaCgmYWRldi0+dXNl
cnFfZG9vcmJlbGxfeGEsIHVxX2lkLCB1cSkgew0KPiA+ID4gPiAgICAgICAgICAgICBpZiAodXEt
PnF1ZXVlX3R5cGUgPT0gcXVldWVfdHlwZSkgew0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAg
IGlmICh1cSA9PSBndWlsdHlfdXEpDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb250aW51ZTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBpZiAodXEtPmRvb3JiZWxs
X2luZGV4ID09IGRiKSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1cS0+
c3RhdGUgPSBBTURHUFVfVVNFUlFfU1RBVEVfSFVORzsNCj4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmICh1c2VfbW1pbykNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zNC4xDQo+
ID4NCg==
