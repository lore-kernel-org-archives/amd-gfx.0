Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D947CD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 22:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896BF10E421;
	Wed, 20 May 2026 22:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHFdx2IQ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D425210E421
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 22:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EECkVpjX7wH7Nl4YK8yxlpzcllcNToPjUF6GpR3M5Ib4leYibrUPPpW5Hjrr5n3ymcYbYXPRcLAiK3xGswYIlt9JzPf7QKNIOWNNBEwRwqTREknkn/Fhh1tmxEEtoyYYh1jxS4QrW5PBgdIX2K/rdV2hvGg3rmKs2cDitILAxBQeeBmsPXO2QxvE1MPw6axJE6Oh8vZjokYGwWz90txoxTHb2fuMcM2zvcDuLspeAOBjHCNyr16a5DhrmcjfZ6VTvHVZbGt1Y7tIQxM0nl4qc5Oa350QcjijamZFVT7tTCgrekdNQX9NfZqVtUhb/1Tk/hkR2iBMO3sGksHFS3f0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUbEV+YZ6Y1eXVcTfhJUWmho7sZDZm2M4DLrndsJOYg=;
 b=KqZux3s+yX/tcIzk2C0spNp5+7nOoiCsI4MOUuy2yNnFSzBZjFsdI7adw7sPOjcsXrLdfsu5GTDgl5lDtOcmEtXb70xOvTCNz8XO4QjDALJHInT73KR09/MYa2B8cDfw2HG6OhqGh4sLPtcTZkP1/vBVwAFksvY27jt+ek6La//PQutDg1d7G38vFQjgkzixNLvTgvO9OXPr/AfmB/AGuRImNz2r9FKyGujiFRKWEKbSsEQXSkRrc9j7KaYdM0UuKTkrjKF49mSjUDiBR5rab9lBTwtmUBs11Qla6gzG7jHQbShHaoIY0XaviDymxvB63I9ACAoBJLvDgwdOOrMZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUbEV+YZ6Y1eXVcTfhJUWmho7sZDZm2M4DLrndsJOYg=;
 b=UHFdx2IQhrPQ5cufMtBbqwT005xvkx0SLRLTXvvbXOGYPKscD494Q1KotM+sekhrdzI7MOluBPmRlZlmnLZzGBGmwx33eCwDon38iTnv93zhy106DvAXpoCkVaN8F4sRn6HCZjP82tymODXPKcduEHB4LJ7kZm1tNbrpo3vDFl8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:00:48 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 22:00:48 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Topic: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Index: AQHc4585ot1t5jJr2k24OA/1GKe53rYWz4AAgACw7bA=
Date: Wed, 20 May 2026 22:00:48 +0000
Message-ID: <BL1PR12MB5144F90F81E91323361BF09EF7012@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
 <20260514124250.3833711-2-Prike.Liang@amd.com>
 <cff0a9b1-5e02-48ee-bd1c-bd0f31d89bae@amd.com>
In-Reply-To: <cff0a9b1-5e02-48ee-bd1c-bd0f31d89bae@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-20T21:58:55.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA0PR12MB4366:EE_
x-ms-office365-filtering-correlation-id: 5d3d7d80-29b5-420d-e3a5-08deb6bb3ff8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|22082099003|56012099003|18002099003|38070700021|11063799006;
x-microsoft-antispam-message-info: VV0A+ZyY7cx7llB1jEPV6DdFStEfIT0LyWR0EKdfWUuzMaeqIQ1gF1sjlHGcPCJxsExTfjVesYksoioy5gVYiJ5vGkvlSjHXsEh74r9AloFOyxzp0tHX4OZLU2tqU5imPAnZDwKH1eKQGfdbhHPGX/R+6Erg01JusPplOwERF0dKSoOWz5/jsC9MzPZw1m4OZ2kjv5aVMTyuWdMrv8/l9n6k/q+r99o/SEVhoQDaYFp2ib5BOKMVCZAZGrkG8PU84heHWkfnw2F/cmC9QMnmOZXFv0tbEchjetLZ1JQtt2RynqUBhEoNNKRRAv/Uk6i2+KH1UGtkvCop005bfmsQKBxf8e78BfaPHHgKSs8Ufn1q5suTbA9U3xPo/4LtPp6C4qxxDLnwi5TshTsUeASbSnLlv2j7gZV7oqotMYZt1n4XQftnLHvITqzAUhrGbk0/F+y3HWN4DYp8QDcWJWvk6OAGDxtg5mH0xCkj5jvSX9Ae3Jxi7XNLqZVTpokT36X7yTI/n9osdCDnz44RZHyYJ6PzFZ/pU1onPHYtN3tQsIG1CFWLfCwLd1hj2nrXiranD2r1KgaNldyG6f0KiiDP/EMAH+kicHgpzMJl/bXgBCt73v/+ty1zUSYq8bXlIa9rNmwYQOaXA4TYO0uSMmawrNU36NiTcop+2WcXU8rPuKBtsk+CZypoPYgGaf5+bdjUnNSq8V4MVnCzg5X04vSphx17XWRn+5YNoe6n33XyjUxvd3SfG5zQxH+1TsZ0zzMm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(22082099003)(56012099003)(18002099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3E3NUttM3lpOTl3amxhZUxZZ1U3SHErdHhTbkFhWHVsNFpBMVRNdHJnMGxo?=
 =?utf-8?B?ais1TURWeEg0VlUyTjAwRVpOYW5zZjA5WFpPU0lQSlRtZFhFUGI5OUpLWXlV?=
 =?utf-8?B?OXBSK0ZHOStlOThXRGNWSDdkcjNmWWxoY0tscEdwZHhtY1JIRTNtZHVibk96?=
 =?utf-8?B?TWpTc2w0V21VanJjdDRZVDcrNW16Mmcwc3IzQnBqdGtrTElIc0pKWXRZSURZ?=
 =?utf-8?B?OXRBbnAyWGFuOU1vSWdzTjNZUk1OSGdkTy9wTEczR3lGRHYrb1NKcnBXN2gz?=
 =?utf-8?B?QnM0SEtSaktnNm1FT3NmWXYxWkh2ekxzRmE2OGVTdEpCYlV2ZFphL0t5Y3Vr?=
 =?utf-8?B?Z0psdHh0R3RIMUZSYlpIczRtclJoVzI1U2MvdzZFT2JNRXFqaUJYS0Mzd1ZE?=
 =?utf-8?B?Qk9HakRIdmo5VXF5TUVOd2VrUHZpaVkrNGI1UXhFK1cvWHBtZVY4SytPK0J5?=
 =?utf-8?B?MzdzZjd6aStnUjZlN3BkamtSMmExcWR1V1lJN2o4c0lBako1ZWw0czFUejAz?=
 =?utf-8?B?NjBSZVpIWFdXWFVVNDJ3THZnREw4YThZSG1lY0V6UEhkMFFUdGkxRmxsV3cx?=
 =?utf-8?B?SFBxNTdMM2piRjEvaW5Xa3ZsditEK2pRS3dwblNFZS9scU1aQk8xWXpaQnY5?=
 =?utf-8?B?cFprNlp1blFPTXB5Y2FweHZrRlZqa0I5cEpvekRLVlNnaFNZdHVPbGtLR21Y?=
 =?utf-8?B?WngxNjhJcCs5SFdobmZVNVdKSlVwTU1RU1FhYXdxMGlMZER3WTlMaC9MUWN3?=
 =?utf-8?B?ZUtZYmptbzZoZ0gybEphMGE0cTFPenhsU241M2NvZEphc1NvajVRb2FHaWtW?=
 =?utf-8?B?NXVxSlNOTzB3NzlodkZ3RGdBZEhJVWxJYVZpa2VZSE81dlpHL1ZwWnpwQ1pX?=
 =?utf-8?B?RTdKUTNFZm1sSjg2aElIZHZZU1QwNmpSeEV1MWdPODdxZHdxSFhaMStZU3ZQ?=
 =?utf-8?B?ekFMdXpBalpFYmt6NHRLVXhIejNqL3BhemNGbTZQR3NSQ3VhOGFudmVheFJZ?=
 =?utf-8?B?RFk5MlBkUDVOb1Y2MEthVkZUMk1nOGRaejErSStQVFd6dnh0NloxSERvalZq?=
 =?utf-8?B?bGFrUTVHS0N3NGU0ck5qZjYybTlwVGNEUEJmaERnZDY4ZVFUOFpZQWh6TnEz?=
 =?utf-8?B?TjdpenRCMStYQlk5YTd1VHpicy9kRGJNSUNaazBtRW9WUU9KZTM5OWNSVzl4?=
 =?utf-8?B?b3ZUVUE5ejhEZ1AvZmdDQUNHRSs0MkJiRiswZEJHdEVmT0NBUlBKUWtYVkpD?=
 =?utf-8?B?SkZwN2xPNkUvTnBqeHNwVDJuTmF1ZGVnWkpXbHk0Y0JGd2RMaVZaSExtS1pC?=
 =?utf-8?B?THU3YytuSVlEUnVVN1haL3B4R1hDdkRtUFJvTU01aFluT3FocWN4aWVUWnRz?=
 =?utf-8?B?L0srbzFzY0FVME5xM1FqaHI0UFUxaW5WTjA2ZGY0djcyRjEvTlRVR1d0VnFa?=
 =?utf-8?B?dGVzc0p2aUhmTkJvY0l5ZVZzTmlLWVgwTTMwcEsrbGV1Y2RzQlVoVmRYaiti?=
 =?utf-8?B?RFlrR2QvOUhEbkIvbCtPc1R1UjJ0SzFjeGdnVWNuczdjWXVCQWdmc0Vqb3Rn?=
 =?utf-8?B?ZnQzSTNTVmtKTG9jdlA3bDJGUkE1eVRscnFKZUhEb3NPOERDdlN0enhIa3lT?=
 =?utf-8?B?QkU4V1hsYnJCN0ZPamNsKzRPZlN6bDFSZnpSN1c4azMxYTZXMTZHRDF4cFFP?=
 =?utf-8?B?Ry9ZY1F6Vk9raE5SY2FHNmg0RUp0SE8yWGxEL0hJUlY2ODlaMVVMT08rYk5E?=
 =?utf-8?B?ZzJGaU1ZQzdOOVNFSkh2VVdXTVdVNHVnODlUOFprRDdmMXZsVUJMNU1OOWZO?=
 =?utf-8?B?VHV4WnBRNmphWVhmbnNxdUZiWFRkREthb09OUFYwbkVUcjc3U1lyTDUzSTJN?=
 =?utf-8?B?ZXYwc09RclBCN1ZKL3V6NW4rWDZ0RnA5VmxrQ1BKZTNmTDFzWFBkWUVpdlhq?=
 =?utf-8?B?UVdTKzFWWVEyRjgvYmFHSitQOUhBSURNd2l0dVdqYzVTb2RDS3RCcE9Cbm5i?=
 =?utf-8?B?WlltZlpHM0hyVEpOdWJjWWJZd25iRG40Vm5VMVpidFBONnZlK1U0clRoRW5z?=
 =?utf-8?B?cERjbDZhVXY3WU41NmZCNXR4VEV4Z2dMcnFyTU9hcHd6UVFvd0ErT2JmMita?=
 =?utf-8?B?Q3M0TkZ1U05rNlEvcHBFOG5RMmVqQUtPK3JZa0JFSjQ2TGVLcXo0Z216TjdO?=
 =?utf-8?B?ZHZIc1l0OStpZW5sRW5hNzY2YTBPK0NielJuazh2eEJpa2R1SVg2TVJReERa?=
 =?utf-8?B?OVZnNnRNcWNxbHFIVmFvRnJQOFAyZDlyUEtoUWNCZ3hTNVNib09zaHlJOWR3?=
 =?utf-8?Q?WWcLenWM4xq8QdWtyU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3d7d80-29b5-420d-e3a5-08deb6bb3ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 22:00:48.1395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hr0NibCzavQBBg6bmA02VL1s+LgO+X7dg81IKwnRJgwsnwco1ZFboDupx53tBBKqXoa3kgukt8UZ+4A5ZUmkNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBN
YXkgMjAsIDIwMjYgNzoyNiBBTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzJdIGRybS9hbWRncHU6IHVubWFwIHVzZXJxIGZvciBldmljdGluZyB1c2VyIHF1ZXVlDQo+DQo+
IE9uIDUvMTQvMjYgMTQ6NDIsIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IElmIHRoZSBkcml2ZXIg
b25seSBwcmVlbXB0cyBxdWV1ZXMsIHRoZXJlIGNhbiBzdGlsbCBiZSBpbmZsaWdodCB3YXZlcywN
Cj4gPiBwZW5kaW5nIGRpc3BhdGNoIHN0YXRlLCBvciByZXN1bWUvcmVkaXNwYXRjaCBwb3NzaWJp
bGl0eSB0aWVkIHRvIHRoZQ0KPiA+IHNhbWUgcXVldWUuIFRoZW4gdGhlIFZNL1RUTSBzaWRlIG1h
eSBwcm9jZWVkIHRvIG1vdmUvdW5tYXAgcXVldWUNCj4gPiByZWxhdGVkIEJPcyBkdXJpbmcgZXZp
Y3RpbmcgdGhlIHF1ZXVlIHdoaWxlIHNoYWRlciBUQ1AgY2xpZW50cyBzdGlsbA0KPiA+IG5lZWQg
dG8gYWNjZXNzIHRoZW0uDQo+ID4NCj4gPiBTbyBmb3IgZXZpY3Rpb24sIHVubWFwIGlzIHNhZmVy
IGJlY2F1c2UgaXQgbWFrZXMgdGhlIHF1ZXVlIG5vbnJ1bm5hYmxlDQo+ID4gYmVmb3JlIG1lbW9y
eSBiYWNraW5nIGlzIGludmFsaWRhdGVkLiBNZWFud2hpbGUsIGZvciBhIGlkbGUgcXVldWUgaXQn
cw0KPiA+IG1vcmUgc3V0aWFibGUgZm9yIHVubWFwcGluZyBpdCByYXRoZXIgcHJlZW1wdCBhbmQg
dW5tYXBwaW5nIGFsc28gc2FmZQ0KPiA+IG1vcmUgcHJvY2Vzc2luZyB0aW1lIHRoYW4gcHJlZW1w
dC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPg0KPg0KPiBJIHdhcyBhbHJlYWR5IHdvbmRlcmluZyB3aGVuIHdlIHN3aXRjaGVkIHRvIHBy
ZWVtcHQgaWYgdGhhdCBpcyBjb3JyZWN0IG9yDQo+IG5vdC4NCj4NCj4gVGhpcyBwYXRjaCBoZXJl
IHByZXR0eSBtdWNoIGNvbmZpcm1zIHRoYXQgaXQgd2FzIG5vdCBjb3JyZWN0LiBJIG5lZWQgdG8g
ZGlzY3Vzcw0KPiB3aXRoIEFsZXggd2hhdCB0byBkbyBoZXJlLCBidXQgZm9yIG5vdyB0aGUgcGF0
Y2ggaXMgY2xlYXJseSBhIGJ1ZyBmaXg6DQo+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCldoYXQncyB0aGUgcG9pbnQgb2YgaGF2
aW5nIGEgcHJlZW1wdCBvcGVyYXRpb24gaWYgaXQgZG9lc24ndCBhY3R1YWxseSBwcmVlbXB0IHRo
ZSB3b3JrPyAgU2VlbXMgbGlrZSBhIGZpcm13YXJlIGJ1Zy4NCg0KUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KQWxleA0KDQoNCj4NCj4gVGhh
bmtzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91c2VycS5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gaW5kZXggMmUzZWRiNmRkNTA2Li5hNjNk
ZmRmYTQxOTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3VzZXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnEuYw0KPiA+IEBAIC0xMDQ4LDcgKzEwNDgsNyBAQCBhbWRncHVfdXNlcnFfcmVzdG9yZV9h
bGwoc3RydWN0DQo+IGFtZGdwdV91c2VycV9tZ3IgKnVxX21ncikNCj4gPiAgICAgICAgICAgICAg
ICAgICAgIGNvbnRpbnVlOw0KPiA+ICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAg
IHIgPSBhbWRncHVfdXNlcnFfcmVzdG9yZV9oZWxwZXIocXVldWUpOw0KPiA+ICsgICAgICAgICAg
IHIgPSBhbWRncHVfdXNlcnFfbWFwX2hlbHBlcihxdWV1ZSk7DQo+ID4gICAgICAgICAgICAgaWYg
KHIpDQo+ID4gICAgICAgICAgICAgICAgICAgICByZXQgPSByOw0KPiA+DQo+ID4gQEAgLTEyODUs
NyArMTI4NSw3IEBAIGFtZGdwdV91c2VycV9ldmljdF9hbGwoc3RydWN0DQo+IGFtZGdwdV91c2Vy
cV9tZ3INCj4gPiAqdXFfbWdyKQ0KPiA+DQo+ID4gICAgIC8qIFRyeSB0byB1bm1hcCBhbGwgdGhl
IHF1ZXVlcyBpbiB0aGlzIHByb2Nlc3MgY3R4ICovDQo+ID4gICAgIHhhX2Zvcl9lYWNoKCZ1cV9t
Z3ItPnVzZXJxX3hhLCBxdWV1ZV9pZCwgcXVldWUpIHsNCj4gPiAtICAgICAgICAgICByID0gYW1k
Z3B1X3VzZXJxX3ByZWVtcHRfaGVscGVyKHF1ZXVlKTsNCj4gPiArICAgICAgICAgICByID0gYW1k
Z3B1X3VzZXJxX3VubWFwX2hlbHBlcihxdWV1ZSk7DQo+ID4gICAgICAgICAgICAgaWYgKHIpDQo+
ID4gICAgICAgICAgICAgICAgICAgICByZXQgPSByOw0KPiA+ICAgICB9DQoNCg==
