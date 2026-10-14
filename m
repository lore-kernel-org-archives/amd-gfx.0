Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A8ACC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 09:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B1F10E4CB;
	Wed, 14 Oct 2026 09:02:24 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D596D10E4CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEzra1h/ICgxWv1D+XjcM4uqzwIs7+s2/2D+wCFkO5XnggWG3XlEVHrg37lZB8QRGD5ZsnM9bGNiJp7XSkGQIIcLaIGs+0FKcCicAyt7c57BJO5HljhYNawtq4OAzWvR7vfKtIfcOSt0bOx9CuLO61PztqIhINoH0KwnBiLkiGBDdCraLL9esx/247ZJh1OpZpHOrpvBuWqmHwBEeiHZO1bM57q9Tz+nk8BCxvncq18BFMYu7EFshEXgkTTQao+fV/uwAV7qU4g5CzSNW5OietexIIKF2ZvMs4UJ7BYmADNzPDb8+NGJevOjES2Eqx2ix0rTd1W4yNSK/RjqzULqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/JSZTJyB/GdiWjwtr+ya3t9sTEf13ktlXkKLbGJlqA=;
 b=oWAhT8fUf/vrTyssnwP60DAUbq8nyUff7kzVGe2va42EGmwbuS3PvMP3IqCsVY9egvDy9aVOqrdTdTr575xtE9vgNXOfZwtCc+CPR7/8RiPg7fs4D0Bi6nX7XQJsj6fjLNmMoOyGW/x2F3sNF82NlWBYsFijONtnLuTKCdeu9Nf3ZjKkRVfJJBOejhmx0Y5u1TtDiZmU7Bcr1MWG6O1EPYFdEqEC3JMALiI2kCU5Wzj1MGIcUk42Cr84yjXLO2RrpxTKTZJM6d4vvH2b4QFeK7SQ73BQnobc+/jpD+64BP96NVkQam7W/NgeRO3ydZdQG2QZ069asQudQ24mwPzNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/JSZTJyB/GdiWjwtr+ya3t9sTEf13ktlXkKLbGJlqA=;
 b=PSmV7jQHHEJ/4qNmFyE18UBX+WYJWd+PeTXeE4M40z4x6SAY7ftV2knX4uy/Z4VH2fRFVJViDzGnXxO9kEGGrT/6hAl1PzZh9QABWYkvAoNSjLGA/+cns+zox1MN6bXAYd3AWE3I8zvmA9s1BLDRfWoITSKsdolxmC4c+X/ki8g=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 09:02:14 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 09:02:14 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 1/9] drm/amdgpu: defer GPU recovery after userq eviction
 failure
Thread-Topic: [PATCH 1/9] drm/amdgpu: defer GPU recovery after userq eviction
 failure
Thread-Index: AQHdWuxkPnDG32/MQ06NTEnWmJvHP7b7M+8AgAGEJLA=
Date: Wed, 14 Oct 2026 09:02:14 +0000
Message-ID: <PH7PR12MB60001D76F73B9883506282A8FB9D2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
 <639f5147-1694-49af-8ac4-dea9ccdd7f89@amd.com>
In-Reply-To: <639f5147-1694-49af-8ac4-dea9ccdd7f89@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-14T08:35:26.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SA0PR12MB7464:EE_
x-ms-office365-filtering-correlation-id: cc0cf303-c3b2-418b-adea-08df29d1d71d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|11063799006|4143699003|261009223027099003|18002099003|10067099003|22082099003|6133799003;
x-microsoft-antispam-message-info: gC8bhe6dYvzmxEq/zjbGUaYH4JngbFtVpqZyL28WaHd+J+cxiZ+H/bCMbAdIoZJxKlDjwaB3nZVKGSAD3j4O38Yklxh5ZX/MrYPNRnl+7WQjATir7eVt5+n0OqDIGuZpfLxnCY5v43by5mBXcMFeXOMK/w1qn5TyUIzj7uqpdtbtVtAevqsjuKHnb1qX/A1FMwntTnYtVrBW/0MAVjbUOeQLrE2PRGB5+aOgNT+8xJamCtAxbM1z/CkrkKqWpwup/n/7+4GIQIbsNjU0G+GMwFcZu7/EApWfZk6HbAm8j+Ume19/iXsI9V9N2lz9zqvNfd3pfAyZI3YVCxu1dr5KiQv3popIvFli0Up38yH9HEdRv2PVFQI8yuhR643bstWREkcTwBh9inK2wz4fmL7UaV8vU/cYUIkdayt8l/PHE4wUlWF9RIhowL8R45PXtJ3NHcxg0joZDjGriYFi5T/89MWv4Gw5UGUcmmIzJ7lI+2gZww3ZBcc5drtGQ19Xv1ac4oI1k8BWGzlElqDsf7Bk/BRM0hMOpYszqk0lmqoybVtB/r6BX5W/J0eytoiuXxs3C1RBv3ANz7v7f1eyjloTFhPi2uFaiPw46Ml7dbYN4U5EemkGq8LYykEPZbXtyDQRin+NP6pW4pMB4VBxDIlWokvGCT27uxFHW8pN1B168cO+hFgOBK96VhQn10ysPwx67MZV2MdJRNohs4MApnJ2jW02okeN73QaCgFxxSyjGtc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW56MW9XNFRTZjc2WUZQMHZWYU5kUitwN1EyeVZIYzkwcmtyenRwd3hQeS9m?=
 =?utf-8?B?bUNNL3VONGxaam1raUptUjBYbnU1NUlYeldYQm0wYkptL2pIa2tiaCtZV0l3?=
 =?utf-8?B?U0doelE2aEZLSE5VTTBPakdMRDU4bityQXczT0grV09EVDhVYnJ6anQra1Ar?=
 =?utf-8?B?NlFqMVA1L3BYNEwrTWh2M1lSeWFsTmYwS05Da05UVUZUUlM1OThGNkhsVG11?=
 =?utf-8?B?VFFaQS83V1ZuOUFYazFTSlhIQWhlTTFUWEFPNGpIUzNQVlJpdU1rbzNoUFV3?=
 =?utf-8?B?blZqV2FzaVRpUGd1RDBUMHYzdTdmcnoxSkp6dmV2dkxoaWM1QmNxNW1yeWNI?=
 =?utf-8?B?WHV3VldSMXhxdHdiK050TE43OUpBOFJhZWpaeTBIR2JNRnNselNuclVEdnc1?=
 =?utf-8?B?c3FqZVdtbEpHalBwMjRZaTdlNzE1U3BiRGZUK2NadXIvVzlXb2NmTnIvR256?=
 =?utf-8?B?WUVVV1hOSHdyZ2pTQ2ZjQVhrdDFseGlHZ01IeHp4dU1UMzJ5YytIL2k3Vklz?=
 =?utf-8?B?ZzJNTDV0YzBSbkxnZWVlN1p0WW1zQ0hDQ3JuRGxUaFRiZjNnMUx4NDIwN2Nr?=
 =?utf-8?B?RG55Nk41THlYeGxUbms5MWREa3pGdTY3aGJaejd5ZFN0NjE1MTVqN1poUkhH?=
 =?utf-8?B?M1U5cURGVHVzVzVEdFRJcjFYNmN4ZEpCeTljYnRZOGZDN25qTnMvcm9XdDJJ?=
 =?utf-8?B?MDNCOW1qY2l5SExRR3Y5MmcvWGNBRjAwMUg0UGRLNExoUnZVUEVsd05CV01n?=
 =?utf-8?B?WWtuN1ZHcDRKUGN0YTFIVzNIZ1lWSlMyS014TjZkRktkUUVaNy9BVkV4YWNm?=
 =?utf-8?B?ZDcyd0VlOUpiazJqWjVJR3JuaUFnL1FpSC9YY3RNNTMwVzBKdnFlZDM4ZHFx?=
 =?utf-8?B?N3BEWlVsTWxDbVJXcHhSUHc1Rjk5TllrbHE5TkhFN0pwazJubXI1V2FETFJX?=
 =?utf-8?B?VG9FNXB1cC9Wci9ReHViejRkWmRicCtKY1A3RnlzQkZQR2VCVGVBZVcxRGhK?=
 =?utf-8?B?bTNxdTMvUFBpLy9oS2F4NTFZMkFVTUJQSk40UnA1RVpNcFdwMkVhNWJYNm9L?=
 =?utf-8?B?c3NvTW9id3I3OEZRY3hIbFVCbFBQbDVSUVR2N1RQdUFCSko3ZHowMUcxYWU0?=
 =?utf-8?B?U3hDcUgyL2VxUkpkcXVFajZBZWdTb0ZmSGoyWXlQZHVwb205MmVlRkkzSnVs?=
 =?utf-8?B?VzJRTUVteWRUblU5b0dYUFJxRHJGM0VyS1VaR1dpWkgrMHlVa3pwSnZneFdX?=
 =?utf-8?B?eE45YkxxS3dWZENHU1dkQ21jWVQ4cC9GaVg0dEhqNFhFUE5iVE0zZnMvd0hI?=
 =?utf-8?B?YzJ2SjRMZVVCWXFqSThuOHUxZWVETThRTVFGWm4wMG0wZ1RCM3JpUU5mNjJQ?=
 =?utf-8?B?dzNtTVFTcXNyTEZId1ZUN2NBdFZOb3ZXNTI2K3BCYXNYZE9QanNTQUtGaU9C?=
 =?utf-8?B?M2I3YnRZZzVIL1FHNDI5SzZPenBTS3UzRTBKUlJhU2pJUzZtclJleWFlS0VH?=
 =?utf-8?B?QW9TQzRSYVRKVXVyNkkxajlEY1NwN2xNMFdPc1BQQkFOVVNrQzlJcVNqTUp2?=
 =?utf-8?B?anJkem9VNS9hdjF6Mlhqb1FreiswWk01Lzh1NExka09JMnNYb3crRDZKOXlB?=
 =?utf-8?B?VEF6bTdvRXJHYmZ6dGl6OVJzRTg2ZXZYcUxNVkVTd0NnekZWdDVsS0QyUVVa?=
 =?utf-8?B?bHl5dCtFc01oWEhBNVlBMGNnTUNYNVA1WG9tY2RUVTAxYWxvQXZFOWYrTkZr?=
 =?utf-8?B?ZFd4Vkx3SEl2UVJnUjNHMXFJQTZpNTErWFF5a0FXdUkxSk1jeWJvN3NsVmRT?=
 =?utf-8?B?cHB4dGJibkM5OTJjODI1UWNpVmNscXIvWUZkZUdKcUdHMytneHR2QzhnNmRO?=
 =?utf-8?B?Z1c0SG5od09jTFNHNjk0MFhMUHp4aTR6UzBpbStuRytmWldreUhGcGoxTnQ1?=
 =?utf-8?B?Qnlib2xldE1pT1hkNzlxWEFBTEdwdUUrQnQwTk9OMVY2dUNGbDJXNGpHOEZ0?=
 =?utf-8?B?S1o0aXczYThyVjFEU244NjRDTU4vaXc2ZGNSdm1tSlJQckJWVEM1V0JoclJi?=
 =?utf-8?B?NGY0YmU1dHFSSmhtVUdOeFJjZUp5dUN6cUdqVjIyVDZXbi9Jc1FWd3RTUmxn?=
 =?utf-8?B?Y3FobnZCVmZhVnZTY1hQangrdU5jZW5kUktFSWVFaElNWDJuTytQMVREYnMy?=
 =?utf-8?B?TUlZVEZlMmhFTGxjZTNFSjRpRlh4TmlhZXNSbmFiV3krUFkyUytPMHQ4cjAx?=
 =?utf-8?B?SU5yTlNzMGpTMmJIR0tKL3NRTUxZQ3YwQ2lxdE42YjZsMytrSGwza2szekR3?=
 =?utf-8?Q?1CwHr+zfgzrW3T6tBi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0cf303-c3b2-418b-adea-08df29d1d71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 09:02:14.3737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Bu8ZYtthobOnH/j77L4nUEeMv/lnlhvN2QY8UvAYNYDgHo8hS7wBo1jQYoEDALM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMywgMjAyNiA1OjI2IFBNDQo+IFRv
OiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgTGF6YXIsIExpam8NCj4gPExpam8uTGF6YXJAYW1kLmNvbT47IFByb3N5YWssIFZp
dGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzld
IGRybS9hbWRncHU6IGRlZmVyIEdQVSByZWNvdmVyeSBhZnRlciB1c2VycSBldmljdGlvbg0KPiBm
YWlsdXJlDQo+DQo+IE9uIDEwLzEzLzI2IDEwOjI0LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBP
biB1c2VycSBldmljdGlvbiBmYWlsdXJlLCB0aGUgc3VzcGVuZCB3b3JrZXIgd2FpdHMgZm9yIHJl
c2V0X3dvcmsNCj4gPiB3aGlsZSBob2xkaW5nIHVzZXJxX211dGV4IGFuZCBpbnNpZGUgYSBETUEt
ZmVuY2Ugc2lnbmFsaW5nIHNlY3Rpb24uDQo+ID4gVGhpcyBtYWtlcyBldmljdGlvbi1mZW5jZSBj
b21wbGV0aW9uIGRlcGVuZCBvbiBHUFUgcmVjb3ZlcnkgZmluaXNoaW5nLA0KPiA+IGFsdGhvdWdo
IHJlY292ZXJ5IGNhbiBpdHNlbGYgcmVxdWlyZSBtZW1vcnkgYWxsb2NhdGlvbiBhbmQgZXZpY3Rp
b24uDQo+DQo+IEFic29sdXRlbHkgY2xlYXIgTkFLIHRvIHRoYXQhDQo+DQo+IEdQVSByZWNvdmVy
eSBpcyB0byB1bmxvY2sgbWVtb3J5IGFsbG9jYXRpb24gYW5kIGV2aWN0aW9uLCBzbyBpdCBjYW4g
Kk5FVkVSKg0KPiBhbGxvY2F0ZSBtZW1vcnkgbm9yIGRlcGVuZCBvbiBldmljdGlvbiB0byBjb21w
bGV0ZS4NCj4NCj4gVGhpcyBwYXRjaCBoZXJlIGlzIGp1c3QgdXR0ZXJseSBub25zZW5zZS4gV2hh
dCB3ZSBuZWVkIHRvIGF2b2lkIGlzIHRvIHRvdWNoIHRoZSB1c2VycQ0KPiBtdXRleCBhbmQvb3Ig
YW55IGV2aWN0aW9uIGZlbmNlIGZyb20gdGhlIEdQVSByZWNvdmVyeS4NCg0KWW91J3JlIHJpZ2h0
LCB0aGUgY3VycmVudCBsb2NrIG9yZGVyaW5nIHVzZXJxIG11dGV4LT4gcmVzZXQgc2VtYXBob3Jl
IGluIHRoZSB1c2VycSBldmljdGlvbiBzaWduYWxpbmcgcGF0aCBkb2VzIG5vdCBuZWVkIHRvIGNo
YW5nZSwNCmFzIGl0IG1hdGNoZXMgdGhlIG9yZGVyIGRlY2xhcmVkIGluIGFtZGdwdV9sb2NrZGVw
X2luaXQoKS4gT24gZnVydGhlciBjaGVjaywgdGhlIFZDTi9VVkQgSUIgdGVzdCBtYXkgcGVyZm9y
bSBhIG1lbW9yeQ0KYWxsb2NhdGlvbiB3aXRoIEdGUF9LRVJORUwgdGhhdCB0cmlnZ2VycyByZWNs
YWltIGR1cmluZyBHUFUgcmVjb3ZlcnkuIFdlIG1heSBuZWVkIGEgZm9sbG93LXVwIHBhdGNoIHRv
IGFkZHJlc3MgdGhlIHJlc3VsdGluZyBwb3RlbnRpYWwgZGVhZGxvY2suDQoNClJlZ2FyZHMsDQpQ
cmlrZQ0KDQpSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4NCj4gPiBGaXhlczogYzhlZDJk
ZTBmMmVlICgiZHJtL2FtZGdwdTogcmV3b3JrIHVzZXJxIHJlc2V0IHdvcmsgaGFuZGxpbmciKQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVu
Y2UuYyB8IDEyICsrKysrKysrKy0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXNlcnEuYyAgICAgICAgICB8IDEwICsrKy0tLS0tLS0NCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmggICAgICAgICAgfCAgMiArLQ0KPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9m
ZW5jZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25f
ZmVuY2UuYw0KPiA+IGluZGV4IDA4MmQwNDVlZGY0NS4uYzJkMWJjN2RlY2JhIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2Zl
bmNlLmMNCj4gPiBAQCAtNjUsNiArNjUsNyBAQCBhbWRncHVfZXZpY3Rpb25fZmVuY2Vfc3VzcGVu
ZF93b3JrZXIoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3JrKQ0KPiA+ICAgICBzdHJ1Y3QgYW1k
Z3B1X3VzZXJxX21nciAqdXFfbWdyID0gJmZwcml2LT51c2VycV9tZ3I7DQo+ID4gICAgIHN0cnVj
dCBkbWFfZmVuY2UgKmV2X2ZlbmNlOw0KPiA+ICAgICBib29sIGNvb2tpZTsNCj4gPiArICAgaW50
IHI7DQo+ID4NCj4gPiAgICAgbXV0ZXhfbG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQo+ID4N
Cj4gPiBAQCAtNzksMjEgKzgwLDI2IEBAIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9zdXNwZW5kX3dv
cmtlcihzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gICAgIGNvb2tpZSA9IGRtYV9m
ZW5jZV9iZWdpbl9zaWduYWxsaW5nKCk7DQo+ID4NCj4gPiAgICAgZXZfZmVuY2UgPSBhbWRncHVf
ZXZmX21ncl9nZXRfZmVuY2UoZXZmX21ncik7DQo+ID4gLSAgIGFtZGdwdV91c2VycV9ldmljdCh1
cV9tZ3IpOw0KPiA+ICsgICByID0gYW1kZ3B1X3VzZXJxX2V2aWN0KHVxX21ncik7DQo+ID4NCj4g
PiAgICAgLyoNCj4gPiAgICAgICogU2lnbmFsaW5nIHRoZSBldmljdGlvbiBmZW5jZSBtdXN0IGJl
IGRvbmUgd2hpbGUgaG9sZGluZyB0aGUNCj4gPiAgICAgICogdXNlcnFfbXV0ZXguIE90aGVyd2lz
ZSB3ZSB3b24ndCByZXN1bWUgdGhlIHF1ZXVlcyBiZWZvcmUgaXNzdWluZyB0aGUNCj4gPiAgICAg
ICogbmV4dCBmZW5jZS4NCj4gPiAgICAgICovDQo+ID4gLSAgIGRtYV9mZW5jZV9zaWduYWwoZXZf
ZmVuY2UpOw0KPiA+ICsgICBpZiAoIXIpDQo+ID4gKyAgICAgICAgICAgZG1hX2ZlbmNlX3NpZ25h
bChldl9mZW5jZSk7DQo+ID4gICAgIGRtYV9mZW5jZV9lbmRfc2lnbmFsbGluZyhjb29raWUpOw0K
PiA+ICAgICBkbWFfZmVuY2VfcHV0KGV2X2ZlbmNlKTsNCj4gPg0KPiA+IC0gICBpZiAoIWV2Zl9t
Z3ItPnNodXRkb3duKQ0KPiA+ICsgICBpZiAoIXIgJiYgIWV2Zl9tZ3ItPnNodXRkb3duKQ0KPiA+
ICAgICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdXFfbWdyLT5yZXN1bWVfd29yaywg
MCk7DQo+ID4NCj4gPiAgICAgbXV0ZXhfdW5sb2NrKCZ1cV9tZ3ItPnVzZXJxX211dGV4KTsNCj4g
PiArDQo+ID4gKyAgIGlmIChyKQ0KPiA+ICsgICAgICAgICAgIGFtZGdwdV9yZXNldF9kb21haW5f
c2NoZWR1bGUodXFfbWdyLT5hZGV2LT5yZXNldF9kb21haW4sDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmdXFfbWdyLT5yZXNldF93b3JrKTsNCj4gPiAgfQ0K
PiA+DQo+ID4gIGludCBhbWRncHVfZXZmX21ncl9hdHRhY2hfZmVuY2Uoc3RydWN0IGFtZGdwdV9l
dmljdGlvbl9mZW5jZV9tZ3INCj4gPiAqZXZmX21nciwgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IDNmZTkxZmRhZmU1NS4uNWZlZjBjYzc3
MDNjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
c2VycS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
LmMNCj4gPiBAQCAtMTMwOCwxMyArMTMwOCw5IEBAIGFtZGdwdV91c2VycV9ldmljdF9hbGwoc3Ry
dWN0IGFtZGdwdV91c2VycV9tZ3INCj4gKnVxX21ncikNCj4gPiAgICAgICAgICAgICAgICAgICAg
IHJldCA9IHI7DQo+ID4gICAgIH0NCj4gPg0KPiA+IC0gICBpZiAocmV0KSB7DQo+ID4gKyAgIGlm
IChyZXQpDQo+ID4gICAgICAgICAgICAgZHJtX2ZpbGVfZXJyKHVxX21nci0+ZmlsZSwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIkNvdWxkbid0IHVubWFwIGFsbCB0aGUgcXVldWVzLCBl
dmljdGlvbiBmYWlsZWQgcmV0PSVkXG4iLA0KPiByZXQpOw0KPiA+IC0gICAgICAgICAgIGFtZGdw
dV9yZXNldF9kb21haW5fc2NoZWR1bGUodXFfbWdyLT5hZGV2LT5yZXNldF9kb21haW4sDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdXFfbWdyLT5yZXNldF93
b3JrKTsNCj4gPiAtICAgICAgICAgICBmbHVzaF93b3JrKCZ1cV9tZ3ItPnJlc2V0X3dvcmspOw0K
PiA+IC0gICB9DQo+ID4gICAgIHJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC0xMzM0
LDEwICsxMzMwLDEwIEBAIGFtZGdwdV91c2VycV93YWl0X2Zvcl9zaWduYWwoc3RydWN0DQo+IGFt
ZGdwdV91c2VycV9tZ3IgKnVxX21ncikNCj4gPiAgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiAtdm9p
ZA0KPiA+ICtpbnQNCj4gPiAgYW1kZ3B1X3VzZXJxX2V2aWN0KHN0cnVjdCBhbWRncHVfdXNlcnFf
bWdyICp1cV9tZ3IpICB7DQo+ID4gLSAgIGFtZGdwdV91c2VycV9ldmljdF9hbGwodXFfbWdyKTsN
Cj4gPiArICAgcmV0dXJuIGFtZGdwdV91c2VycV9ldmljdF9hbGwodXFfbWdyKTsNCj4gPiAgfQ0K
PiA+DQo+ID4gIGludCBhbWRncHVfdXNlcnFfbWdyX2luaXQoc3RydWN0IGFtZGdwdV91c2VycV9t
Z3IgKnVzZXJxX21nciwgc3RydWN0DQo+ID4gZHJtX2ZpbGUgKmZpbGVfcHJpdiwgZGlmZiAtLWdp
dA0KPiA+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmgNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5oDQo+ID4gaW5kZXggNDg4
ZGMyMWQ3YzgxLi40ZGNmNjE1MWRlNmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXNlcnEuaA0KPiA+IEBAIC0xNjMsNyArMTYzLDcgQEAgdm9pZCBhbWRn
cHVfdXNlcnFfbWdyX2NhbmNlbF9yZXN1bWUoc3RydWN0DQo+ID4gYW1kZ3B1X3VzZXJxX21nciAq
dXNlcnFfbWdyKTsgIHZvaWQgYW1kZ3B1X3VzZXJxX21ncl9maW5pKHN0cnVjdA0KPiA+IGFtZGdw
dV91c2VycV9tZ3IgKnVzZXJxX21ncik7DQo+ID4NCj4gPiAgdm9pZCBhbWRncHVfdXNlcnFfd2Fp
dF9mb3Jfc2lnbmFsKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IpOw0KPiA+IC12b2lk
IGFtZGdwdV91c2VycV9ldmljdChzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyKTsNCj4g
PiAraW50IGFtZGdwdV91c2VycV9ldmljdChzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdy
KTsNCj4gPg0KPiA+ICB2b2lkIGFtZGdwdV91c2VycV9lbnN1cmVfZXZfZmVuY2Uoc3RydWN0IGFt
ZGdwdV91c2VycV9tZ3IgKnVzZXJxX21nciwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21nciAqZXZmX21ncik7DQoNCg==
