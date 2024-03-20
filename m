Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD502C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 19:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB3910FEFA;
	Wed, 20 Mar 2024 19:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1KJyS+Hq";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75A810FEFB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 19:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ia0+Nv3XaJytuKvODdIrSnSha7zf5SY6Z3GVZksgNWw4dul3wnENojkJ5RQJpZnm0yID7CJmr0RJVa2Q1SbnubPx2WRRxb3aFk01i36DlUPiAgFa2JbqFg8FU7+Nty2xZ0iTVVwRUmyWRINeJzBhLerYKNRLyJWd5dWp5UYzXYUMCXvrNOd3UtzBDzTVdrLS0SYyUARtegzKIRPQxGvX64QtnMsnooTa4jF+JnFH0sx5GLCDW7Wepq3j/hwSeOJGKs2094m1vqSDjIk0ga+/CwbfdjN3V8F0VPhwFcmNPjM3Y8s88AMAHqk9KJYGVtMiNuIoraWUwRWmryMQK7Q4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f75sRc2nUX7SSeFLJ0HX8r4Uf9PZwPvL1n3rJKypwEo=;
 b=lyBoG2l/hw/FmzatOLrgEVviCwijrrAo2zd8/WrPVZjy95C3QzdMJ5LJo2rm/Yn0yHCqbJXfue6qZ6pvFgtAFUoa6aVsYkgwssNvObBJ2ddhkHi0tdUpBEnlxGngHuSj0Ww4mWplhWc91Q5rI+TXZ6f6lkK9j/+vw6osqFuc2CdvEnTlgYXAnxPK5BkG57Qd1aMv5AqMkC//nc7yw2HDbOLJgaF1WvPDWKgzWlpjqTeahbUKpzVHUAloB80Vqd8PLb5Lut5hP0n9KgT+Fga98vQh8Kmrzx/S+s+/WA2UeT197asjli4GhBaKHvixeHs+PTHbXe7A/s2BBnJnm/GdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f75sRc2nUX7SSeFLJ0HX8r4Uf9PZwPvL1n3rJKypwEo=;
 b=1KJyS+HqQ54e9cBktFKHZUuwzmtbcQbMx+B/mPKMU6RvZxf5IsgDMONlzGRyB42LvZfNpUIR9utxqQWczPfjIlsFa5mkn8hzawwDTc8bja+XbDtnUIgjtQZlnAMWupUG5bjgit255bOen20sptoT6XHsnDVu0clVbxOq5hCd7BA=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 19:09:11 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 19:09:11 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
Thread-Topic: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
Thread-Index: AQHadwUjojiieaO15U2Bov9k599SB7E98zWAgAA8ueA=
Date: Wed, 20 Mar 2024 19:09:11 +0000
Message-ID: <BL3PR12MB6425081828B93697A317ECE4EE332@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240315181756.685335-1-mukul.joshi@amd.com>
 <48148998-5124-4a66-8d1a-767d94f6c284@amd.com>
In-Reply-To: <48148998-5124-4a66-8d1a-767d94f6c284@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1251a562-b7e6-4a42-98f7-92be299e6ae6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T23:49:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DS0PR12MB9347:EE_
x-ms-office365-filtering-correlation-id: 63024ef3-9b6e-482c-4028-08dc49113a1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZGkaMjOtlR+biimsNXl+2WvP0720ewC3S8wj4d+LmbvXofNq0NnzuGuLHNjqg0j9NQhVKVp3C41CkB4iylheQ4vNnzOohsY+LEywIcyqY17af4pkzfyDV6KMaSFQa+DHhjK5el/x+JP71qa2aj9HlN4OEvbajRcYv6TvEyzr2fDyuR/SdnIGG3NChRbBlfJYtM5izNCsQjbA3YO/RMYla9OyNRm/sWzvQty+R0RBuYKDWWYibCYWBs12GS0cZlct8q5mc4yZAOCwUlVa7h5j+vvl4wwkeNYmXOs9YPrLk2qIOLbxBnyYtyBBqeFRkIbHLvk7d5zm1fQGK+X6cw/nXiL/Xmn56UQnTzOvLAN8OEW8GUrJi6BaQqbxHdlgyjrojwZ671zT2N7U/znJ5GoU3SpOXMyoV0LkP3N9aWkG8FITfuPJMy0g+XPUzhq7SkHFS0MKQTNas7nUHtzL0tQj+WKN8Ml2eCbF9BEMlm3bno+Yxvcfad0KFI6RIh4gjcK/mwMo/7+8g9IPRD+yizQFZLGkN+SQXYvpM1tdwP20H8SFrh7TvfOk3vmpS2WeTwSTW43wF0RY9YNyuq43fCaR2X3HStzixYp3LD9K2q0j6B2k7hij6UyhMf0+LYxartRVZ7zx9wihhIwJI+E8wPC9VGtzaCnvMqpSwLokMdgqDSrHViB5vtu1v+Ng6gt8cPx/ylpzjd+v4a3BoJk3X+awf4z8mtcXyaoDd3sfEIkVhQk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVpwVDMvVUFnRnRYRVoyK1FOME9WY1VwVWd1NWVhMzI4ZEN0L3VQdzBNVS9E?=
 =?utf-8?B?Qlhldjc1VTVvUk1Zb3VITnhpK25wc1NrTmtpUFZXbmV2QlQrdDFPWFdNZERF?=
 =?utf-8?B?bWZrZng0SGduaXpUbkNLVlpibmlHTlVzQnBxSExtN0ZwVnphcFNsbVlGQ2dh?=
 =?utf-8?B?VGJ0bDJZc3BIcytsazBJbEh5aGR2Zy82MStFRld2dU82U0dadXd5algyL09Y?=
 =?utf-8?B?L1lVOGR2bER2ZU1oWkRLT3lYWWxRNDJKc1hVS0VtbUhOWVZCdUxsMFRySU82?=
 =?utf-8?B?bldBZ29WeDMyaytabkNTNS9Vd211S2JpV3B5TGx0bGZWZnU1bWlqd25kb1U0?=
 =?utf-8?B?bVc3MDkwYkNHYTFWYWluU1Ric1dXMml3a1lkWklSUVdMeGxXNlcyRitXdWZP?=
 =?utf-8?B?WHJ5L2hNUnVEbUJvZSs4VzljSTVzYloydjBCMHdYMkxvYlFNM252dk1yY2dM?=
 =?utf-8?B?Y3VZSlF0Nk5ES2dmb05ldDJsUm0xVko4T2daWTZrdTNVZFI4ZGFSRHFRSElw?=
 =?utf-8?B?aEc4U0xXUThSa0ZkRmE3dnhCUWVJdnFxUUNpdDhucXloemxjMHNVLzBSTGlj?=
 =?utf-8?B?UlV6d3NlcC9zdWU0RFdZaURydWtSQlhjcTdOZ2FqSXk2WURGYUJwNG9qQm9k?=
 =?utf-8?B?RFFlZ3c2cktneDVjV3pJZ3NXRXhSL1daS1l2QjBXQk1tcU54SVFJVklYcVVC?=
 =?utf-8?B?bHA3WGp3Z2lWL2dpU3FXcnRrQWdwOHlVTFd1UGVpR0QzbUhIU0plczdUN3Z2?=
 =?utf-8?B?VVMzNnRvalZhZWNYMFBUVWJkMVQ2VW1RSlhKTTZSSENlVzdIbldpdnMxM05w?=
 =?utf-8?B?UGNrbVdCQ2pZN1BXVmdsUlNXcnVLc1JwcjZpRUZoU2U3bHhDU1kyYmhHMFlv?=
 =?utf-8?B?eEZEb1B2a0xjcjVnaGlXUkZKTm9jdDBFUTZvelNFRi81U2IxdjBjT0ZjOGNV?=
 =?utf-8?B?MUFNQVc4Wm5LWUFzUXZjTmZCMzhtZ2JkN2ErRFRpM1prOTlYREt1RjluU09N?=
 =?utf-8?B?L1ZZcGJkUFJNN0oybGlya0tIVFF4blU3cWxwZElyL2pham4rUms5dTduVTRq?=
 =?utf-8?B?bmJsSWJqZGVvYzAydHZXTGN5aldqcVk2Sy9KcTdDTFNjR0xKSWFGODFIUTdu?=
 =?utf-8?B?b3ozNTZoUlRXb081eTRJNzlzeTMxS2ZEd2lYZmtSN3lhL0hZVjdlWnBocVhZ?=
 =?utf-8?B?a0NRRzUwVG9Ga21rZnMzOGF2TWdlVGQ2UjBYNFJJbUZEelA5NWdseml4ckdp?=
 =?utf-8?B?cFkxa05IQm1oSy9Pdm9FWUIxQTVJNFo1cGVqM2lSeTIrc25nSFY1MWNERmRZ?=
 =?utf-8?B?RjRoREZONGMzaDZhNGFZNlVvelQ1UVgyOHJtL3JkamR0b3RwL08rVXZLeWtF?=
 =?utf-8?B?bEgyQjB3aGFMbnZJR21GMlRYcFMxSDlubitLQnE1QS9CaFZnbHV5UmpLRTFn?=
 =?utf-8?B?SnBkVGxNdjZIVDNBRnNseTNweGhCZ2g0R282K2MxdkpJY1NGaWFYK0Z5bUxF?=
 =?utf-8?B?dGVpaHRiTUtqMTJxWjl0MGtlYWw2SlRYem5QRlZYbGxtNURFQlNTd1p4K2Zp?=
 =?utf-8?B?SG1ucDIwL09XS25ab00vTkl3UVg3ek5pNFhuRnBkMnRtOUpNSUJLVUlVeXk4?=
 =?utf-8?B?WVllaDdnUWNxeG02b0xzcmhwOENQQ2hNaG1DUUp3a0ZMbzB0eDY2VWFqZ0Er?=
 =?utf-8?B?Z2hFbVlqYithTnRGZFNWMkJJMktVTFBjdFdmaDVnWUU2NUtJMW5DTC9OTHdU?=
 =?utf-8?B?dC91ZlV0REtwajZKbi9GZy9hSXE4QXUyR2RMdjV2ZWgwV0g1RkV5Smw2Z3lC?=
 =?utf-8?B?RisyZTdlVC9GUkVBd3VLV1Fza1ZSdnBxQWNGNUswK2t5S2NQVzkxRjdNNXVE?=
 =?utf-8?B?a08rOXpCUEovQzh0TmhvSnU1bmgxTmMvUnUwTW9NeU93ZGpMaXYyKzU0T3po?=
 =?utf-8?B?TmU0RUhoN25DY2kvSmVZMXM5dW03bU1TN2VaRG5oZjJjaHFwcVVuNHBwQVRR?=
 =?utf-8?B?VTNXcGgyZzI3T0M4UEJqNjljMzdiL0VDK2lrbXFBT2tIWVZYYVV0S08rSVpQ?=
 =?utf-8?B?WUV4b0FnZWNKcTBqZmJ2aDdrVnE5cjUrQkpBYzQ5VFZtMFg5OVpBclRDMnA5?=
 =?utf-8?Q?ArjY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63024ef3-9b6e-482c-4028-08dc49113a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 19:09:11.7536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZXf4MxgHkb7tztCfR+0rkEEJM0VomX9PwpDOZ20vrFpiKj8MGiy+xndDB9EUJO1SWNrilvAe2V/80PI33OQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE4LCAyMDI0IDQ6MTMgUE0NCj4gVG86IEpvc2hpLCBN
dWt1bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IENoZWNrIGNncm91cCB3aGVuIHJl
dHVybmluZyBETUFCdWYgaW5mbw0KPg0KPg0KPiBPbiAyMDI0LTAzLTE1IDE0OjE3LCBNdWt1bCBK
b3NoaSB3cm90ZToNCj4gPiBDaGVjayBjZ3JvdXAgcGVybWlzc2lvbnMgd2hlbiByZXR1cm5pbmcg
RE1BLWJ1ZiBpbmZvIGFuZCBiYXNlZCBvbg0KPiA+IGNncm91cCBjaGVjayByZXR1cm4gdGhlIGlk
IG9mIHRoZSBHUFUgdGhhdCBoYXMgYWNjZXNzIHRvIHRoZSBCTy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyB8IDQgKystLQ0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4gaW5kZXgg
ZGZhOGM2OTUzMmQ0Li5mOTYzMWY0YjFhMDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4gPiBAQCAtMTUyMyw3ICsxNTIzLDcgQEAgc3RhdGlj
IGludCBrZmRfaW9jdGxfZ2V0X2RtYWJ1Zl9pbmZvKHN0cnVjdCBmaWxlDQo+ID4gKmZpbGVwLA0K
PiA+DQo+ID4gICAgIC8qIEZpbmQgYSBLRkQgR1BVIGRldmljZSB0aGF0IHN1cHBvcnRzIHRoZSBn
ZXRfZG1hYnVmX2luZm8gcXVlcnkgKi8NCj4gPiAgICAgZm9yIChpID0gMDsga2ZkX3RvcG9sb2d5
X2VudW1fa2ZkX2RldmljZXMoaSwgJmRldikgPT0gMDsgaSsrKQ0KPiA+IC0gICAgICAgICAgIGlm
IChkZXYpDQo+ID4gKyAgICAgICAgICAgaWYgKGRldiAmJiAha2ZkX2RldmNncm91cF9jaGVja19w
ZXJtaXNzaW9uKGRldikpDQo+ID4gICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAg
aWYgKCFkZXYpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gQEAgLTE1NDUs
NyArMTU0NSw3IEBAIHN0YXRpYyBpbnQga2ZkX2lvY3RsX2dldF9kbWFidWZfaW5mbyhzdHJ1Y3Qg
ZmlsZQ0KPiAqZmlsZXAsDQo+ID4gICAgIGlmICh4Y3BfaWQgPj0gMCkNCj4gPiAgICAgICAgICAg
ICBhcmdzLT5ncHVfaWQgPSBkbWFidWZfYWRldi0+a2ZkLmRldi0+bm9kZXNbeGNwX2lkXS0+aWQ7
DQo+ID4gICAgIGVsc2UNCj4gPiAtICAgICAgICAgICBhcmdzLT5ncHVfaWQgPSBkbWFidWZfYWRl
di0+a2ZkLmRldi0+bm9kZXNbMF0tPmlkOw0KPiA+ICsgICAgICAgICAgIGFyZ3MtPmdwdV9pZCA9
IGRldi0+aWQ7DQo+DQo+IElmIEkgcmVtZW1iZXIgY29ycmVjdGx5LCB0aGlzIHdhcyBtZWFudCBh
cyBhIGZhbGxiYWNrIGluIGNhc2UgZm9yIEdUVCBCT3Mgd2hlcmUNCj4gdGhlIGV4cG9ydGluZyBw
YXJ0aXRpb24gd2Fzbid0IGtub3duIGFuZCB0aGUgYXBwbGljYXRpb24gZGlkbid0IGhhdmUgYWNj
ZXNzIHRvDQo+IHRoZSBmaXJzdCBwYXJ0aXRpb24uIEkgdGhpbmsgdGhlIHdheSB5b3Ugd3JvdGUg
dGhpcywgaXQgY291bGQgYWxzbyBjaGFuZ2UgdGhlDQo+IGJlaGF2aW91ciAocmVwb3J0IHRoZSB3
cm9uZyBHUFUgSUQpIG9uIHNpbmdsZS1wYXJ0aXRpb24gR1BVcywgd2hpY2ggaXMNCj4gcHJvYmFi
bHkgbm90IGludGVuZGVkLiBNYXliZSB0aGlzIHdvdWxkIHByZXNlcnZlIHRoZSBiZWhhdmlvdXIg
Zm9yIHRoYXQNCj4gY2FzZToNCj4NCkNhbiB5b3UgcGxlYXNlIGV4cGxhaW4gd2h5IHRoaXMgY291
bGQgYmUgYSBpc3N1ZSBvbiBhIHNpbmdsZSBwYXJ0aXRpb24gR1BVPw0KDQpSZWdhcmRzLA0KTXVr
dWwNCg0KPiAgICAgICAuLi4NCj4gLSAgICAgZWxzZQ0KPiArICAgICBlbHNlIGlmICgha2ZkX2Rl
dmNncm91cF9jaGVja19wZXJtaXNzaW9uKGRtYWJ1Zl9hZGV2LT5rZmQuZGV2LQ0KPiA+bm9kZXNb
MF0pKQ0KPiAgICAgICAgICAgICAgIGFyZ3MtPmdwdV9pZCA9IGRtYWJ1Zl9hZGV2LT5rZmQuZGV2
LT5ub2Rlc1swXS0+aWQ7DQo+ICsgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICBhcmdzLT5ncHVf
aWQgPSBkZXYtPmlkOw0KPg0KPiBPciBtYXliZSBhIG1vcmUgZ2VuZXJhbCBzb2x1dGlvbiB3b3Vs
ZCBtYWtlIERNQUJ1ZiBpbXBvcnQgd29yayB3aGVuDQo+IHRoZQ0KPiBleHBvcnRlciBpcyByZWFs
bHkgdW5rbm93biBvciBub3QgZXZlbiBhIEdQVS4gVGhpcyBjYW1lIHVwIG5vdCBzbyBsb25nDQo+
IGFnbyBpbiB0aGUgY29udGV4dCBvZiBpbnRlcm9wIHdpdGggM3JkLXBhcnR5IGRldmljZXMuIFRo
aXMgbWF5IHJlcXVpcmUNCj4gdXNlciBtb2RlIGNoYW5nZXMgYXMgd2VsbC4NCj4NCj4gUmVnYXJk
cywNCj4gICAgRmVsaXgNCj4NCj4NCj4gPiAgICAgYXJncy0+ZmxhZ3MgPSBmbGFnczsNCj4gPg0K
PiA+ICAgICAvKiBDb3B5IG1ldGFkYXRhIGJ1ZmZlciB0byB1c2VyIG1vZGUgKi8NCg==
