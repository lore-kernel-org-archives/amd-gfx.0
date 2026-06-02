Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98224CD6E4A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 08:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C2C1138F5;
	Tue,  2 Jun 2026 08:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h8WYeoMu";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C171138F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 08:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiftHzbANITVSSaSek/U5NfOam2PNyPDV6s1LmIvPYjnFI7EEBM/QinosZsAbiGjXALHC8sLzJMg+9J8696OlJ4XUShL2cnhvjf8iCR/r2eAkJZgTDmL1Oaa1yf0ROd2WZ6XHZYUMk+/0Zg4CD33gQnuHnIq3ygfB9YREpapygqahLJs9LwPlh+IGj0EMX+RdCzZvA1AgePI7XDt1MaIxEjC68zBVYn6S++epEsCbJ1ROTuIJkH2po5Y02k6FqJl/in+Jmz78X3pNl/KrLWzNWdptJW0aZI9gHB/4FTFjPSTcnPvfTRowKFnwzjxLSVvTvFprmUUCVxy+r+5gePJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfS+RBktZHKK7De0CAnVb7dbS5vuJqE8l61Zxuy85jE=;
 b=thv9C08nhoMi0fPQCciNsdZb8Bi7eXAsWVABwyq8c4H90KbvXm0VlBJ6fMYXmeVjdBm0MXxoUI0AYiC9MYSSOIxbeezl9O5MYtPBkQ/78k04I8y01zKE57s2087iw8Z7Cxk0vb7kaNuDY0Qp2gKds+ceVAMKAXfx5UPfIt0B8Yf5JOy1LDoQCs7EyczsDCJCFeEFA75efye2hdPeNGtHPc44Z+pyl6BffEZP/qAiK/o3aQ86n5YxMGV7qMrY6jZwrs7DXDETcaV4Mtx0wUgRncvkWXjbt/emEBuLfogxM19wtc4iwTm0f+a74hN8PktmkegEJq+Z0LtWlhYNRbdo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfS+RBktZHKK7De0CAnVb7dbS5vuJqE8l61Zxuy85jE=;
 b=h8WYeoMubYfEiRg0D3n+136RRngouJEimhPJeeldOXixYHwzrL+Hq2cPxrCFjVXYO4WMM8OrtGzFwOXTRYLcsfiaTNtcbH++tXV1TZGHgJx3eYxbSRFqUDRZckSV+d/yZbbiFRZAN07i6QtwQzJYgXfT7p9egAEevDVwN3ho06o=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Tue, 2 Jun 2026 08:18:50 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 08:18:50 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for
 empty wait fences
Thread-Topic: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for
 empty wait fences
Thread-Index: AQHc7PKUwStaNzpPRky6Lksvo9OH+rYgIHcAgAFWwnCAAAwkAIAC205ggAaU1rA=
Date: Tue, 2 Jun 2026 08:18:50 +0000
Message-ID: <DS7PR12MB6005F33326259B5A0B2C0CF8FB122@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260526093210.55565-1-Prike.Liang@amd.com>
 <78e1b3d4-5e68-43f6-b82a-353fdcf22876@amd.com>
 <MN0PR12MB6004CE174D0E58CC6C3BC03DFB082@MN0PR12MB6004.namprd12.prod.outlook.com>
 <ca870fb4-1a61-4108-8e4a-94cdcf67efe0@amd.com>
 <DS7PR12MB6005E15B0AFF25A5B365C547FB162@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005E15B0AFF25A5B365C547FB162@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T03:36:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CYXPR12MB9428:EE_
x-ms-office365-filtering-correlation-id: e605c7e0-f4a7-4d81-8134-08dec07f939b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info: s6cqePSh8f6jyQ9iVKmanWpb6RWaOw9cr4R6diEQtrVFeGgAVgevOZV9VCv5wdRcf3/VGISuuTKZOoDVf2q6wQejQcRswxCddMqAIHwHaPjbdyO4rs9ehO9nLJw8KPjH2GfmRTRu2ypelFCZltFGJRxcF+U43xi1abHaEhO1mg3dQcrqwtgqA0JaIdap7gjZKpjMT2Sema9R0Jx60IBjA1GnqZLTvvcZtMgOMU352i8u9REt5OXz6AMhkzCpPb4rKAfc0+poQUknnd/k6HAy+Kpfg7m/q5qmxayKBdHXKu1qqbEG51r4Rp4B3IN2y2oX6R37O4SAMSlpxw7SDcSmH8Hm0ZVfmTWea4R/9pPkcs88XxMxv2X8GVTKQicEMyl/KqNZB9O+9oABNiYG1hXJt/QSWs5XXLVeC8i7TlYtha47kuQPF/9ZgIaJKQXxsoLtNfF5M6m65VG+XLETUIgnmbjznN8ID8gOMQOKni01U6DK8FRllTlwe5mEDFHOsUPDQJA0riVnA8p8zKhbSOiptpbahawrahF86GKGPa0E62N/djIfzh0gVs4+v7W2APOHEaTI0G/psslklgDhBpNXkpuod4j9uKRY14js2N/GwpcdaUaFXrt7TyoI7o3KT3g/GKmQXJLj4GsAPHJZQXs2iC1+JHAyp4y4l/L8PbHyZeDcJBY7fZ8g4CIaKp+tFu2eoaknrbGmBWezpjrus2pakEngWgW8BDKTqPUz6zgKxOOkrdWg0xkkWSE8du7lRmS0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkZKNnVlT1l0NjNNbnlGNGw4QkxCNHRxblVZUGJFMzQwbGdTMEk1azdXQ3pN?=
 =?utf-8?B?VGZUNjR6N3l6VWNHL2VRZmJ6UHZ6bDZCakdiTkV2N21vWkk2eS9YdkROVmpM?=
 =?utf-8?B?L0RhTWZWV1RUd0YxUzVFKzdCQXVnQUNTaFFmQzk1aEIzVTdxMFZWd3F0OGk0?=
 =?utf-8?B?WFF6d2Q5bWFTWkUrZDRCeFQ4eXZMWWNiWlBsRjZVazRMd0RUNnREeE1yalJW?=
 =?utf-8?B?U21EODNGWS8rZHJXdElqQ3N4dUQ2ejZQMFJEeHh4SEVTTnJDUWsrSTJtZWV2?=
 =?utf-8?B?b1pnNmEyZW9rZCs2M3JCOEdmbWgvNzhrZjBFYTFRY2RiNk5ibE56dklPbmRB?=
 =?utf-8?B?ZmhBdHNObGN1cVJlejBKOUUrK05pVGt0MkRlK2RJcmhMTWpKbktpamRRSDho?=
 =?utf-8?B?NHVmbXYwbmRaMnBiSUpUa010MGh1UXhFQ0pVVTFCd25UeTRKaWQ5VGtnODdh?=
 =?utf-8?B?VWJzQmRObWUvWUphSGFpbjduZDRBa2hNNktKUFIrcDl2aCtQTHpqejhld3Fv?=
 =?utf-8?B?YTROWWhERWNNSHBqZmp6bHVGS2FBOTBNVkFLQldUM2xZNXFwZjZJV0NKeGlD?=
 =?utf-8?B?YSsxY3h3WTBwQ2F6YzREZ2wvcDllZzJHemhUUnlzeDd4TEpjQm8zckVtOHBJ?=
 =?utf-8?B?NWVSMHlWeHliMmdJMVEzbGpWZFFVcWdLSWptOUU3SWppb08ybFRqK1d4MXBC?=
 =?utf-8?B?aDNHYnJKQXc1SVFsZzBUenBJTSs1aUw3YkJXOGNpbCtMTFhVaUJ1VWQ3b3Z3?=
 =?utf-8?B?eW9wd0JxTjRTcmUrdE9VQmFzOUdONElMbHBleGFiQ2w2aE95dkhrSGx6TmZP?=
 =?utf-8?B?b0UrRHdndlFaZXh0Z2R4Ulorcy9qUERpV2JNcEFGVFU5MThvRksyTmxpOVdQ?=
 =?utf-8?B?N1lLTGFSTytkZWlkaUxBaWtsYTNkYVI4M1FBUUZTZDJNOHM4aFVaRVhPOVdO?=
 =?utf-8?B?MFJQbzZEenlIRlhFR20xOHBzdmQyT1JobWpPWGZKTkpjaU5US1ArZkExU1Fa?=
 =?utf-8?B?TE4rYkVOVnRDdmxyTjJzc0dzV2g0UHBUWHJsNmhJdFZGa01MdlZpWEVrYVMw?=
 =?utf-8?B?M3p2WU1rQUM4ZHA3dEZNUnNwWVdRcGlUK0orSTF1ZmJETXhGRGgyUGtENWwx?=
 =?utf-8?B?dFAraE92R29BSldEYmMrcFI3V2lHM3JYUlNEM0NTcHQ2N2l6S21PRGVGbXVm?=
 =?utf-8?B?WG1kNmEwcUM5enl1N01ZM0Zld0JoUVlhaE5ERk5SQkJuRHVod2dVQk9pUUYz?=
 =?utf-8?B?RWEwMzdyNGZ4M0pyUEVKMTFWcXdSTjhQbmw3cDJlM1ZKMzFvVFFrU1U3dHl0?=
 =?utf-8?B?V1VCOFp3Ly9Tb2tTajMrOENiNzNsM3pEbjcyenVzaWVsM0tmWEVWQ21vcTAv?=
 =?utf-8?B?RDdhR3pXNWxDWlU4czdCRitVa0JVdFhraTZkell4UVNHdTlpaVZDUVgxQ0hj?=
 =?utf-8?B?V1lQYlU1VzhPa1JwZWlUNVRvNEphZnpTVDhITWV3a0R2SFJWR2lIc0JBNTZK?=
 =?utf-8?B?TkpBYjF4ODcrUDluaDk2QUNzNnZyQXE1eE1XNERPTmx2WHNKenZKNVQrMjAz?=
 =?utf-8?B?YkQzVGlJRmVKZ1ZkVnhEOUZibEFCK2lhNGVjZS90R2Mvei91ZWpmUnF1OXRP?=
 =?utf-8?B?RTc3MzVyc3J6RG5ycDYySGxpZEhUUXhLZHUxaExoNTFQS3JsSnVJcHNubkZz?=
 =?utf-8?B?czZWRXRLZ1VjLzFhd05OZnE5bXZ4K3k3ektWektzT3Z5UnZYdDlsbmVQVW9B?=
 =?utf-8?B?T2FQZjlhb0poWTU4blhhWGFZdVpnVW9HVXQ3eThheTIzYmFpMUdqb0tVbjNJ?=
 =?utf-8?B?OGtCTzRzakw5NTVxbzhzck1HZDZlT2xLbWpVeVNMQnh0S2N0d21ZOXZzWGgz?=
 =?utf-8?B?bUI1Y3lEZEJzK1V1dmhaNWRiYzRReUVtcHdFL0w4RVVJbVIzWVZnMTZsT1Fw?=
 =?utf-8?B?dm1CMnIxMUptNSt6S2RXVWtLN2JzQkgwa0lWY2U3YVh5OURDWjJ3OWFkN0xT?=
 =?utf-8?B?dVc4SDFTVFBuSVB0SHJVM2Z3c2c3ajFWN2ZKcjhRZzFzOTlEWWlhbWp2TTBs?=
 =?utf-8?B?OWNCd2tyVHpVVzlmYTlmRmdwUEdBYzNxQU55Z3Q2WE14bFlkSFNZb2FFVXZB?=
 =?utf-8?B?OTVxeG84dnkwTGJ4U2VNeDllOGlCNmk3elNMbzVrcjJ0bDBJaXU3cHBDT09t?=
 =?utf-8?B?S1B2alpEaVYrbmdFTlZYWEF6QXJ2M0ZLaVFLc1ZJREhOWlZTYkpDa3NHeG1X?=
 =?utf-8?B?K2lDOEpSaEVxWjRGNVdMZzgwQ3ZBZ2NWM0hFaGx5QlJsZGZjZG1uR3hqUy9m?=
 =?utf-8?Q?+RZyOI7JHDwNiL/2nK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e605c7e0-f4a7-4d81-8134-08dec07f939b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 08:18:50.2787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGJgv9Cb/vBwj0dwXcRnGhdaKFxJr7u3YeL74enJ4a7BDrvEmphjHHhvqg/ajz27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIExpYW5nLCBQcmlrZQ0KPiBTZW50OiBGcmlkYXksIE1h
eSAyOSwgMjAyNiA0OjIwIFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUkU6
IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IGF2b2lkIGV4dHJhY3RpbmcgZmVuY2VfZHJ2X2FycmF5
IGZvciBlbXB0eQ0KPiB3YWl0IGZlbmNlcw0KPg0KPiBBTUQgR2VuZXJhbA0KPg0KPiBSZWdhcmRz
LA0KPiAgICAgICBQcmlrZQ0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
RnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPiBT
ZW50OiBXZWRuZXNkYXksIE1heSAyNywgMjAyNiAzOjU5IFBNDQo+ID4gVG86IExpYW5nLCBQcmlr
ZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
ID4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gZHJtL2FtZGdwdTogYXZvaWQgZXh0cmFjdGluZyBm
ZW5jZV9kcnZfYXJyYXkNCj4gPiBmb3IgZW1wdHkgd2FpdCBmZW5jZXMNCj4gPg0KPiA+DQo+ID4N
Cj4gPiBPbiA1LzI3LzI2IDA5OjU1LCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+ID4gPiBBTUQgR2Vu
ZXJhbA0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiAgICAgICBQcmlrZQ0KPiA+ID4NCj4g
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4+IEZyb206IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4gPj4gU2VudDogVHVlc2RheSwg
TWF5IDI2LCAyMDI2IDY6NDggUE0NCj4gPiA+PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFu
Z0BhbWQuY29tPjsNCj4gPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4+
IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IGF2b2lkIGV4dHJhY3RpbmcN
Cj4gPiA+PiBmZW5jZV9kcnZfYXJyYXkgZm9yIGVtcHR5IHdhaXQgZmVuY2VzDQo+ID4gPj4NCj4g
PiA+Pg0KPiA+ID4+DQo+ID4gPj4gT24gNS8yNi8yNiAxMTozMiwgUHJpa2UgTGlhbmcgd3JvdGU6
DQo+ID4gPj4+IEF2b2lkIHhhcnJheSBleHRyYWN0aW9uIGFuZCB0ZW1wb3JhcnkgYXJyYXkgYWxs
b2NhdGlvbiBpbg0KPiA+ID4+PiBhbWRncHVfdXNlcnFfZmVuY2VfYWxsb2MoKSB3aGVuIHRoZXJl
IGFyZSBubyBwZW5kaW5nIHdhaXQtc2lkZQ0KPiA+ID4+PiBmZW5jZSBkcml2ZXIgcmVmZXJlbmNl
cy4gVGhpcyBrZWVwcyB0aGUgY29tbW9uIGZlbmNlIGVtaXQgcGF0aA0KPiA+ID4+PiBjaGVhcGVy
IGFuZCBlZmZpY2llbnQuDQo+ID4gPj4NCj4gPiA+PiBUaGF0J3MgYW4gYWJzb2x1dGUgY29ybmVy
IGNhc2Ugd2UgY2xlYXJseSBkb24ndCBuZWVkIHRvIG9wdGltaXplIGZvci4NCj4gPiA+Pg0KPiA+
ID4+IEluIGFsbW9zdCBhbGwgY2FzZXMgd2Ugc2hvdWxkIGhhdmUgYXQgbGVhc3Qgb25lIHJlbW90
ZSBmZW5jZSBkcml2ZXIgaGVyZS4NCj4gPiA+DQo+ID4gPiBXaGVuIG9ubHkgdGhlIGRlc2t0b3Ag
Y29tcG9zaXRvciBpcyBydW5uaW5nLCB0aGVyZSdyZSBtYW55IG5vLXdhaXQNCj4gPiA+IGZlbmNl
cyBhcmUNCj4gPiBnZW5lcmF0ZWQgd2hpbGUgZW1pdHRpbmcgdXNlcnEgZmVuY2VzLg0KPiA+DQo+
ID4gVGhhdCBzb3VuZHMgbGlrZSBhIGJ1ZyB0byBtZS4gSW4gYWxtb3N0IGFsbCBjYXNlcyB3ZSBz
aG91bGQgaGF2ZQ0KPiA+IGFsd2F5cyBhdCBsZWFzdCBvbmUgd2FpdCBmZW5jZSBpbiBoZXJlLg0K
PiA+DQo+ID4gT3RoZXJ3aXNlIHRoZSBzeW5jaHJvbml6YXRpb24gYmV0d2VlbiBYL1dheWxhbmQg
YW5kIHJlbmRlcmluZyBjbGllbnQNCj4gPiBpc24ndCB3b3JraW5nIHByb3Blcmx5Lg0KPiA+DQo+
ID4gQ2FuIHlvdSBpbnZlc3RpZ2F0ZSB3aHkgd2UgZG9uJ3QgaGF2ZSBhIGZlbmNlIGRlcGVuZGVu
Y3kgaGVyZT8NCj4gPg0KPiA+IFdoYXQgY291bGQgYmUgaXMgdGhhdCB3ZSBmaWx0ZXIgb3V0IHRo
YXQgZGVwZW5kZW5jeSBpbiB0aGUgd2FpdCBJT0NUTA0KPiA+IGJlY2F1c2UgaXQgaXMgYWxyZWFk
eSBzaWduYWxlZC4NCj4NCj4gV2hlbiBvbmx5IHRoZSBkZXNrdG9wIGNvbXBvc2l0b3IgaXMgcnVu
bmluZywgdGhlIHdhaXQgZmVuY2UgaW9jdGwgZ2F0aGVycyBvbmx5IHRoZQ0KPiBWTSB0aW1lbGlu
ZSBmZW5jZS4gTm8gdXNlcnEgZmVuY2VzIGZyb20gZ2VuZXJpYyBzeW5jb2JqcyBvciBCTyBpbXBs
aWNpdCBzeW5jIGFyZQ0KPiBwcmVzZW50LCBzbyBubyB1c2VycSBmZW5jZSBkcml2ZXIgaXMgcmVm
ZXJlbmNlZCBkdXJpbmcgdGhlIHdhaXQgcGF0aC4gSW4gdGhpcyBjYXNlLA0KPiBza2lwcGluZyB0
aGUgYWxsb2NhdGlvbiBhbmQgZXh0cmFjdGlvbiBvZiB0aGUgdXNlcnEgZmVuY2UgZHJpdmVyIHdv
dWxkIHJlZHVjZSB0aGUgcGVyDQo+IHN1Ym1pc3Npb24gb3ZlcmhlYWQgb2YgZW1pdHRpbmcgdXNl
cnEgZmVuY2VzLg0KDQpIaSBDaHJpc3RpYW4sIHRoZXJlIGlzIGEgY2FzZSB3aGVyZSBubyB1c2Vy
cSB3YWl0IGZlbmNlcyBhcmUgcHJlc2VudCBleGNlcHQgdGhlIFZNIHRpbWVsaW5lIGZlbmNlLg0K
U2luY2UgdGhlIFZNIHRpbWVsaW5lIGZlbmNlIGlzIGEga2VybmVsIHNpZGUgZmVuY2UgYW5kIGlz
IG5vdCBwYXNzZWQgYmFjayB0byB1c2Vyc3BhY2UgYXMgYSBGV00gcGFja2V0LA0Kd291bGQgaXQg
YmUgd29ydGh3aGlsZSB0byByZWR1Y2UgdGhlIG92ZXJoZWFkIGJ5IHNraXBwaW5nIHRoZSBhbGxv
Y2F0aW9uIG9mIHRoZSB1c2VycSBmZW5jZSBzdG9yYWdlIGFycmF5IGluIHRoaXMgY2FzZT8NCg0K
PiA+DQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPiA+IFJlcGVhdGVkbHkg
YXR0ZW1wdGluZyB0byBleHRyYWN0IHRoZSB3YWl0IGZlbmNlIGFycmF5IHRha2VzIG1vcmUNCj4g
PiA+IHRoYW4gMTDCtXMgKHdpdGggYQ0KPiA+IG1heGltdW0gY29zdCBvZiBhcm91bmQgMzDCtXMp
LiBBZGRpdGlvbmFsbHksIHplcm8taW5pdGlhbGl6aW5nIHRoZQ0KPiA+IHVzZXJxIGZlbmNlIGFs
bG9jYXRpb24gY2FuIGhlbHAgcmVkdWNlIG92ZXJoZWFkIGluIHRoZSB1c2VycSBmZW5jZSBwdXQg
cm91dGluZS4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGNhbiByZXR1cm4gYSB1c2VycSBmZW5j
ZSBkcml2ZXIgZXZlbiB3aGVuIGZhbGxpbmcgYmFjaw0KPiA+ID4gZnJvbSBhbiBlbXB0eQ0KPiA+
IGZlbmNlX2Rydl94YSwgYmVuZWZpdGluZyBvbiByZWR1Y2luZyB0aGUgbGF0ZW5jeSBvZiB1c2Vy
cSBmZW5jZSBkcml2ZXINCj4gPiBleHRyYWN0aW9uIGFuZCBmcmVlIG9wZXJhdGlvbnMgd2hlbiB0
aGVyZSBpcyBubyBwZW5kaW5nIHdhaXQtc2lkZSBmZW5jZS4NCj4gPiA+DQo+ID4gPj4gUmVnYXJk
cywNCj4gPiA+PiBDaHJpc3RpYW4uDQo+ID4gPj4NCj4gPiA+Pj4NCj4gPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gPj4+IC0tLQ0KPiA+
ID4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMgfCA2
ICsrKystLQ0KPiA+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiA+Pj4NCj4gPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gPj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiA+Pj4gaW5kZXggMDA4MzMwYTBk
ODUyLi4yYTJiZjEzYTUxM2QgMTAwNjQ0DQo+ID4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gPj4+IEBAIC0yMjYsNyAr
MjI2LDcgQEAgc3RhdGljIGludCBhbWRncHVfdXNlcnFfZmVuY2VfYWxsb2Moc3RydWN0DQo+ID4g
Pj4gYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICp1c2VycSwNCj4gPiA+Pj4gICAgIHN0cnVjdCBhbWRn
cHVfdXNlcnFfZmVuY2UgKnVzZXJxX2ZlbmNlOw0KPiA+ID4+PiAgICAgdm9pZCAqZW50cnk7DQo+
ID4gPj4+DQo+ID4gPj4+IC0gICB1c2VycV9mZW5jZSA9IGttYWxsb2Moc2l6ZW9mKCp1c2VycV9m
ZW5jZSksIEdGUF9LRVJORUwpOw0KPiA+ID4+PiArICAgdXNlcnFfZmVuY2UgPSBremFsbG9jKHNp
emVvZigqdXNlcnFfZmVuY2UpLCBHRlBfS0VSTkVMKTsNCj4gPiA+Pj4gICAgIGlmICghdXNlcnFf
ZmVuY2UpDQo+ID4gPj4+ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ID4+Pg0KPiA+
ID4+PiBAQCAtMjM1LDYgKzIzNSw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3VzZXJxX2ZlbmNlX2Fs
bG9jKHN0cnVjdA0KPiA+ID4+IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAqdXNlcnEsDQo+ID4gPj4+
ICAgICAgKiB1c2VkIGFzIHNpemUgdG8gYWxsb2NhdGUgdGhlIGFycmF5Lg0KPiA+ID4+PiAgICAg
ICovDQo+ID4gPj4+ICAgICBtdXRleF9sb2NrKCZ1c2VycS0+ZmVuY2VfZHJ2X2xvY2spOw0KPiA+
ID4+PiArICAgaWYgKHhhX2VtcHR5KCZ1c2VycS0+ZmVuY2VfZHJ2X3hhKSkNCj4gPiA+Pj4gKyAg
ICAgICAgICAgZ290byB1bmxvY2s7DQo+ID4gPj4+ICAgICBYQV9TVEFURSh4YXMsICZ1c2VycS0+
ZmVuY2VfZHJ2X3hhLCAwKTsNCj4gPiA+Pj4NCj4gPiA+Pj4gICAgIHJjdV9yZWFkX2xvY2soKTsN
Cj4gPiA+Pj4gQEAgLTI1Niw3ICsyNTgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV91c2VycV9mZW5j
ZV9hbGxvYyhzdHJ1Y3QNCj4gPiA+PiBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnVzZXJxLA0KPiA+
ID4+PiAgICAgeGFfZXh0cmFjdCgmdXNlcnEtPmZlbmNlX2Rydl94YSwgKHZvaWQgKiopdXNlcnFf
ZmVuY2UtPmZlbmNlX2Rydl9hcnJheSwNCj4gPiA+Pj4gICAgICAgICAgICAgICAgMCwgVUxPTkdf
TUFYLCB4YXMueGFfaW5kZXgsIFhBX1BSRVNFTlQpOw0KPiA+ID4+PiAgICAgeGFfZGVzdHJveSgm
dXNlcnEtPmZlbmNlX2Rydl94YSk7DQo+ID4gPj4+IC0NCj4gPiA+Pj4gK3VubG9jazoNCj4gPiA+
Pj4gICAgIG11dGV4X3VubG9jaygmdXNlcnEtPmZlbmNlX2Rydl9sb2NrKTsNCj4gPiA+Pj4NCj4g
PiA+Pj4gICAgIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfZ2V0KGZlbmNlX2Rydik7DQo+ID4g
Pg0KDQo=
