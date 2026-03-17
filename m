Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BE8FD8741
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 11:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6573010E60A;
	Tue, 17 Mar 2026 11:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIjk1Lxx";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E7EF10E209
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 11:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v85xeicem7QrI++RIQch0zJLmm8xEiBdBhskKgscnhKpgtUEmyq9KwO6fN0MI5BZopoJPHclKlDO7jp7EVmxDN1mmuXMUPWYFxJ5H4bjy8j27Kj36IqXgtEwRdYB1OL4zrx01So/y6zbqfy9BxL4MLy1rRuf9eHNV8EoOb1eAoDOIE5Bz0K+Ki6/CxP/dWO6UFmWjrFoLPc7+P5uxfYFg3VLUvUAoBiSw9xATGDoUvomywN435sAzgpNRNfobYFVUSUF+4OEFxixB1d1OGQ2Jmakk3siW3LRPVkUSsc3vcjNGIFC6vjqfb2QciUqRXEhXTA4MB2ujfvngRsH86aRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xcGnRehmmB+dBambCdinQ1j0EXhm6fR2wYdXIMByqE=;
 b=fJpzEBQ1LabNNDDFOoZGZ81Divnf2v9R1e7PUs97YV7HhRj2SMaxM/PwgK1YNftWZXOICgdr3hu/irjjhdvEkB281fn/eqyuhWDlihneuOkvMnF9SMUvRFqQsIWDlokGKYdZJ4+9qBT+ldPJ7zoZCw6hmRrDEVrEfZJKSG2KU/qP5SbQ/9POrRjJpQyfzraOxhMYqkzmh0lQdPed82mCAweTmB778+B5SIMRCgWwGX1Ob/fLVjwwsk0mnfgcZkC5cwEwW2tw+yyYVNvX6WxJBKRCrZoR3X5GPUcvrBLCSbWj4cm/yEVsJyftfC0E69l/PvuTMeCN7LT2xhiFgPYI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xcGnRehmmB+dBambCdinQ1j0EXhm6fR2wYdXIMByqE=;
 b=uIjk1LxxzuQFKkHPFEy9VUDqMX1ggl/AX+IocfmV3ZXilsp0OMPXlvBauOn98c5IDZGhQWg19v5rRner9awH6Ranm7XSSWyHYy2i0JDVGkfB+X2E4+1XAHlP2W0L+J476vpkl/jOah9i92I+PznRX2fC7RmL/bzGP3TyLcsnIHU=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 11:21:10 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 11:21:09 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>, "SHANMUGAM,
 SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
Thread-Topic: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
Thread-Index: AQHcsMICsYz9P8UxbE2MvZq1Ifr0IrWsGghAgAZtW4CAABR/YA==
Date: Tue, 17 Mar 2026 11:21:09 +0000
Message-ID: <PH7PR12MB60009290374F2995C51FD4A1FB41A@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-4-christian.koenig@amd.com>
 <PH7PR12MB6000407BC326A3D9ADB2AC48FB45A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <074594f1-59d1-4cd7-9b2a-997106b76167@amd.com>
In-Reply-To: <074594f1-59d1-4cd7-9b2a-997106b76167@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-17T11:10:50.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH7PR12MB7380:EE_
x-ms-office365-filtering-correlation-id: eb13b91b-4e39-443b-453a-08de84174a41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: nSC2XNAHB8kCRxWoUekh9Ws7MyqugVmas+7/wsNzzcBoC41mnHvp20qh5qUtdUoyaGyxRYOtSBwoPvhmjUw9aQfUbPheJEQBsPLRvCaClN8IRS1r6GLvkYckkU+udQySxMQLnKvuG3p/joqtzFL4MIA6f4cRoMsmma50kkKUpcjFmd8Bp5/HC8zIajTAiiwh6/UVHQsEEdvX3i2AsVvG/ANYR2KkHA0RSB+TzLibEN/jjs200VDuYVtv9C9cH66hbRsVWbaR0oI6egt74g42Zs0r6wSkttE2K9e2B+OEEB4IHmHW2RYjE2VOlW151wFWGUQqnTomM0+O0Kusyreulpawg4iH3USVInHCu2US4/W9ozVYkAC/ktjK0rx/juPGbtqUgXYXv5thWyhki/RXbdNDDmeq+H0TR9Wc4q2rol5qo0lpPU6Mtl+GiIefcYvTmrnzGx3HRB8UxRDj3uRnyhY/IPLA/p5ElXLZ5me6rZVm6JUgqQFuUklgxJf88VXSLm3btu5QjvJ6m3nc6xuKcPyZeKs0XNTKzqiWwAseaLziQUMyN5WHE60Nv202KEH/ImQiXl1Aj1vKlhhd1z9ZZo3HoAPz/BQuAqgYIB2kqCj2FDocj4T6T+p2tJCp6yOoO+BC1Jv0Fq5rLPxXbGmXaGZ/YHh37m3HHjiibOV5yxSCc0cLPydp3QKr/GJyORh4567RWVmQlWnCoPAYDUX37YJ9MhAsR/8i+L1ziJNAgaGN+27QTqH1dH4smDaG7F0Bf0YIuWFx0fQNSygIVTj6Zl1S6506w7KzILZg6b6M5sYt+rFuo1GCagJMgoWri95o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ri8zVmJhSUsvTklrVFd1OHJ1VXlFcldkTW9zdHd3OWg1N0d5bWg5azNWTVNq?=
 =?utf-8?B?SUQ2OUh1elhnbjVsWEViYURKUVFiU0FDM2p3MVpqa3IwZER1QkF4T1RxajM0?=
 =?utf-8?B?emNJQzRVWjB0c2E3YjZpTW5jT3h1bVhGajZwQzBVRjhlTFV4czFiUlZlTTlo?=
 =?utf-8?B?T1Rsa3JEeU5CSytKNjNhYjBXSlFQd0ZiNjZjc2VZVTM4cXU2cTBPaU9ET1Bv?=
 =?utf-8?B?U1NGU2hJNXM1NDMrdmNDWllxZVJUWDZ0V2JrNnN3c0ZhVFRBR1Jrb1BRVk10?=
 =?utf-8?B?SFJXQWJ5aTdQc0J6bkRUbHc3WjJyTFE2dVVybzltcGp5VEhXTzRzSVdKamNr?=
 =?utf-8?B?RTdyUDBFVzFIbi84TWxGemZ3WW5SclAxZVdNTWNSNE0zM01IcWZTbWZ2N1NG?=
 =?utf-8?B?cytyMU4vcmtndG9OTnRPSjJqVVFnUDliZ2t5N1FTdkwxQ1VHZFA2T1pyNzVO?=
 =?utf-8?B?KzdzempxcTZnQ2NhNnd5V09aSGhRdk1mQS9HWDRRUlZxMkU3MGIzeGdaQ0pG?=
 =?utf-8?B?ZzZubmFmN0tmZXo1dlJlNlcyS2c2Szluc3FUVTR0bGJzS2RpU2pmQ1k3VE1w?=
 =?utf-8?B?NGdCdm9uWmVoUFBVZEJIR2p5MTdFajQ4U2RXZGRNTTdqMXYybnBkNFF2TnRW?=
 =?utf-8?B?d1VMWEhKRElPTWdPMlpwUjZFK0VCYUo2YkRsUWcyNjB4YlZJanE2U2plZzk3?=
 =?utf-8?B?dUFVSDBzQUNDQ0VhbUU3ZzgvOVg5Z0dhclgzTjkxTDRkTzhNd0RvUGVUZ25w?=
 =?utf-8?B?U0VXcG14TVRYbVIyYW1yb2FrT3g2Q2FiZHpuQ21yUmhCMmxWUmxPTkFnMkJG?=
 =?utf-8?B?Y2ZSeUxUMVVBWEYzUW5vRXM2YjdtaDAxa3VtSDFxajc1ajNjWHlwaERXWlo2?=
 =?utf-8?B?TDdxTDBDS0NORGNpdWhsRllaSy9UdW5sUWxtU1F0YXJCaUd1NDhtRFdtNisv?=
 =?utf-8?B?SkJwYUhvQlN1MXhqVGN1Z0pvbkhUdUk4alFWcnA2OXFtZjNYbFdqTWVrYklJ?=
 =?utf-8?B?WlhJN05nV3ZwUVk2b2VqdUVHZkorWklMVjVuY0xTaUdIQ3hvQngvSkx6bGRu?=
 =?utf-8?B?M2hqMmdML3cyeUNMN251UzlpR1crZ0M2dkF3Y0QxbnFkcndWclFFZ2J5WVV4?=
 =?utf-8?B?WjE5VmM3bm9sTXJUak9RS0U0b0V3T2RKdDdTZDNmRkN1d2xZdEhGMmhXMzRN?=
 =?utf-8?B?WVNJVGQwWG5FUTY1ejA0bVhjZ2lhTXJPQnFOUzd3akp2ZWh0clU0OW00eTRN?=
 =?utf-8?B?R3pTenZEV1RwSFVIZDVaUGVneGJvMEVNOFdscVBoY3JQT2Ird25NU1BxMGtm?=
 =?utf-8?B?RFowblhyOExTcDZwZloyQ0VwdThleWM2T3FlT244NlgvSTNFcE5iL2dlMzl3?=
 =?utf-8?B?RWdEVVVHQ3F5MUxuQ01xcVpvWUV5eHBLMFVEaG1acnZpSzd3eGZZYjRjOWI0?=
 =?utf-8?B?a1puUUkyOGNTdFNRMDl5NHQ4bzg2ZkNnYnFKMXpNSE4wdWNhZkxpb2FNS01L?=
 =?utf-8?B?SlN2MFo5MVQwcGdrYzcwTzNzd0JzNUpka01wZUxFdm5WZHJOaDZMMld3ci9P?=
 =?utf-8?B?cHVxSWUvc0kvZWtxWEp6OFFQdkh5RkEvMmo4QWpreU1ZOWllcXdCOU96WW9B?=
 =?utf-8?B?a1RERk84VzFzQUo4bnN3T2RGVGpFalBPOGhUbzhpQlFGRUJKazB1ZTFDbzZJ?=
 =?utf-8?B?MlVndDB6SkNLSG9rT2JyQng5dG9KcUFZZUQyVXQzOTNQYVNrNFVlSG9vdHVa?=
 =?utf-8?B?RFhyTVRWMWtldmx4SkluMWFnY0t4ZnFabnBURG5WQ3dXdVlhZUJ5R0NsNFVR?=
 =?utf-8?B?SWpTWHdYL05HS3JaMlZLc1BTUmNNZDdKQXp0d3BkUWl0QmU0K29ia0NUcFIv?=
 =?utf-8?B?WkpuYmhCNzlVR25lanZtM1lIODRHMkIwbm4ydXUvWnBCM0I1NFFmRThXR2x4?=
 =?utf-8?B?WkNxWUVTRENYY3RLTG5WRHZNSlpUS29DbW11bDFRak1ibzVlNXNQUnZyTmth?=
 =?utf-8?B?TmREV21OODY4N3VLUmRlSDFNZkdPbmFZQk1IVmdwWGE0dGpvU0d2aFVYMDl5?=
 =?utf-8?B?bDkzL00zcEs2bUNKb3ZXbUd1OEZlTndyc0E4L25RZjdYaU9QSGlwWFRaWFlN?=
 =?utf-8?B?bUZsL0N2N2xoeDV2MytiQVFqdmJXU1hLMHpyNWlZWGdSUjZ3SHM3UmdEL3da?=
 =?utf-8?B?QzFFSWpQK3FlYm5HVmorbWJkMGV2SWVSbGc5Qyt6ZzlLdU1odHlvS280RFpU?=
 =?utf-8?B?dGFZc1hjWjNpaEpWM0N1aDNvUlBIUEl5OGlEckQ3ckJBbDdXUFlkd2JnYm1h?=
 =?utf-8?Q?q7AhIvuHQYDbOO4bqN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb13b91b-4e39-443b-453a-08de84174a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 11:21:09.7863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2Phz/qsg0TEHfZ8/6yt5wUJ45JiAxM633SPxj7CaZyasIpMdxHoYVP1qdjveSvu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTcsIDIwMjYgNTo1NyBQTQ0KPiBUbzogTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgdHVyc3VsaW5AdXJzdWxpbi5uZXQ7IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IE1vaGFuIE1h
cmltdXRodSwgWW9nZXNoDQo+IDxZb2dlc2guTW9oYW5tYXJpbXV0aHVAYW1kLmNvbT47IFNIQU5N
VUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IEtoYXRy
aSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPjsNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNC8xMV0gZHJtL2FtZGdwdTogY29tcGxl
dGVseSByZXdvcmsgZXZpY3Rpb24gZmVuY2UgaGFuZGxpbmcNCj4NCj4gT24gMy8xMy8yNiAwOToy
OCwgTGlhbmcsIFByaWtlIHdyb3RlOg0KPiA+PiArdm9pZCBhbWRncHVfZXZmX21ncl9hdHRhY2hf
ZmVuY2Uoc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9tZ3INCj4gKmV2Zl9tZ3IsDQo+ID4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpibykgew0K
PiA+PiArICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpldl9mZW5jZSA9IGFtZGdwdV9ldmZfbWdyX2dl
dF9mZW5jZShldmZfbWdyKTsNCj4gPj4gKyAgICAgc3RydWN0IGRtYV9yZXN2ICpyZXN2ID0gYm8t
PnRiby5iYXNlLnJlc3Y7DQo+ID4NCj4gPiBCZWZvcmUgYWRkaW5nIHRoZSBhdHRhY2hlZCBmZW5j
ZSwgdGhlcmUgcmVxdWlyZXMgYWxsb2NhdGluZyB0aGUgcmVzZXJ2YXRpb24gZmVuY2UNCj4gc2xv
dCBmaXJzdC4NCj4NCj4gTm8sIHRoZSBjYWxsZXIgZG9lcyB0aGF0IHVzaW5nIHRoZSBkcm1fZXhl
Yy4NCj4NCj4gQWRkaXRpb25hbCB0byB0aGF0IGl0IGlzIHdheSB0byBsYXRlIHRvIGRvIGFueSBt
ZW1vcnkgYWxsb2NhdGlvbiBoZXJlIHNpbmNlIHRoYXQgY291bGQNCj4gY3ljbGUgYmFjayBhbmQg
d2FpdCBmb3IgdXMgdG8gYXR0YWNoIHRoZSBldmljdGlvbiBmZW5jZS4NCj4NCj4gU28gYnkgcmVz
ZXJ2aW5nIGEgc2xvdCBoZXJlIHlvdSB3b3VsZCBqdXN0IGNyZWF0ZSBhIHBvdGVudGlhbCBkZWFk
bG9jay4NCg0KSXMgcG9zc2libGUgcGFzcyB0aGUgd3JvbmcgZmVuY2UgbnVtYmVyIHRocm91Z2gg
dGhlIGFtZGdwdV92bV9sb2NrX3BkKCkvZHJtX2V4ZWNfcHJlcGFyZV9vYmooKT8gSSBzYXcgdGhl
IGZlbmNlIG51bWJlciBhc3NlcnQgZXJyb3IgZHVyaW5nIGF0dGFjaGluZyB0aGUgcmVzZXJ2YXRp
b24gZmVuY2UuDQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0K
