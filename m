Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55611F8D75C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 18:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F3910EA8F;
	Fri, 17 Apr 2026 18:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b3QDAF25";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD7610EA8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 18:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC5OdOBPeyq7DCD/nirB+4c/z0GOTZO+ZhjuSo68CYr5L0+C7i5aAiCG/oftfmK4RL+GEmNfpAjaO44ItrNw3BO96YVR0bre8J7TA/+nLG2BxBxRXG3k8/DQ2U7AyArT8MilUR7F/7mnlwdBEDr5D+iykJIkHmkmRuLwAhKJUKUAsmSOjuiNw81sdyoKFv1d/Sor/j/8iVvcbf8t/LeqWzgofAZ8aE1S2Kl4AegQT4x4/pbZc2HSFtTq4O70uViY0ZS0AeyAeap2125xcy4P4KG2mTY2TzuNOhNluVDmiwussXAx4iXnwTdiG5+u7vSxglOf/OXesO1YtDho8WYiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at1AJuVo0lIoEP7VHI5IScVoQW/E1SvxyuFuTBMU+b0=;
 b=cnOTI4Iktcu/QJDwPebVlbdT7TcT2iigTsbBdXlICmmGnhxGbHFJ9I9Asd096IHBLnTXBAkbzFhHrZ+Ia/0bmyKVwqDvWDbiNK7hH4dEaF/AvxxK8HKXxD5OePeujTKmSNEZMKVwpb9ldIRnDCshtOpqnBPLOK4iBd1tPoutGeGkuvZ48J2o1dD/HwaEYj+uJpXcZ0YPkaqi21rERf+MnEtc9pFMEHpFSFFBR3y4lITy8Dar+3yKg3JdPwlrs/GQOVjsK7j7SapzJlQS0omNcogscyFe7B2Q5IFGtXD5fKVnQ3D4z4aWysnOW5LTyNa8eLgGxdxd9zOW96IliNfJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at1AJuVo0lIoEP7VHI5IScVoQW/E1SvxyuFuTBMU+b0=;
 b=b3QDAF251Ktv4mWusQYkkjGeqh/elFkOiwp1y3OX0gfwOWtbs0RZJzSD5UDAjyYo+wWaVAfyP8g2DVBD9rLp25Meq2r1uLa/cqiAaZ82gyiSOYGRnL91tyml59XmddAFKnybMNYuH93Czlq5oq15KlkZTMpr3WMt7Mufw1T1PCU=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 18:51:29 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 18:51:29 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 04/16] drm/amdgpu/gfx9.4.3: align mqd settings with KFD
Thread-Topic: [PATCH 04/16] drm/amdgpu/gfx9.4.3: align mqd settings with KFD
Thread-Index: AQHctuDV8d98eGodb0uNFHj6APsEpbXNd5+AgBZBM4CAAA+/MA==
Date: Fri, 17 Apr 2026 18:51:29 +0000
Message-ID: <BL1PR12MB589861DF6C91B8DD7BF7A79085202@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
 <20260318140837.582776-4-alexander.deucher@amd.com>
 <CADnq5_Md5RSUKZyAq8edL4hbwc1r2uPA7jiC6zn+MKi9KzDY6w@mail.gmail.com>
 <CADnq5_OV391Vj80-2xehYzqK0SLkf3f5dwsK0ybDYcxryBQ03w@mail.gmail.com>
In-Reply-To: <CADnq5_OV391Vj80-2xehYzqK0SLkf3f5dwsK0ybDYcxryBQ03w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-17T18:51:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|LV2PR12MB5944:EE_
x-ms-office365-filtering-correlation-id: 2d107cdc-bba8-422a-03c3-08de9cb255ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: uQoGoMR+OuR7rRkc5raBYjLpflYtN0VTWeefzJsoL2EoqkalhHVgmJ+1+aXqZU50pD3ok8fImQwHqzGoAvj0YcLPn/TvcZiE1BmbPraCUrbYVhEjdz2rLNeXkayyp2N9EnXce9OdEjbAPxjdYt20O2OaYUVz4FTZYXzeG54oY1I09SMynMowdRoJxM8v8IdRJI1LlhsyY/E44ouOOqSrtR0XmtRCwhZiHDK87rQzIb3CKunqHOBc9R1AhqjNHL/RblFBo5wLbO0vGcrT41NTLgnED+JKfz1nAztIYdZU/2I4mN9nqtI0usYNVGBBTpNuPO9yfFo+sIVjWC847lkozcAqy0ZNYexZaThVEfG39Z1IxRKBuv8xErZbHA0+fJPdymdZ00Hn64ni8V2L9mRmV5ondUHc2uxj0R0pvPtZ5Ey79BU5KFeeDh568KngQsyi2FV3milkilyOqvdtbQEYrJVxPHXFHcym41LfDimwyS0IFhjHeehwZEWwXPNdrHtImNtddWRkfV+sf5XB96UOYT2djSMGUge7RMKOXQGy/OuGIjVxENJOptvBlBFeTFFSlG4tgXZxCH/lVyNwOeSmlgkriiXJpXqdH7LDrLcn7S1wp7vCoE40aXLwfaHLCl1iO19+p9yMpRQoQnoo8x94Qw4U7NRJNYJSVOcTR7fZzdMpnuf0BwjvjEY+p/+fupR46Yv2dEnyZjS1HyeVJm03Btbu8JyPr+4lIayvi+Q09vDpyIaBf+TKl5NowswZ4V0Pn2rSu5avrWWXJ4reVYsRdWNdVfLL1ui2IrbRrHVa93k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1Fqcy9xOUZ3OGZiWjFiQUJFWFZIc2JGTDd1UGdTdjF5ZXBHK2FGWWc4Ujhl?=
 =?utf-8?B?Y2NQcUsvU3BjQlYyVEI1dlpwNkM2S3hGakhvYmp5V0lJSlZ4OTA1UDRpZHRn?=
 =?utf-8?B?Tndwb2h0bDVSS0JYOUd6QmJCTG00bDFiSWFKZUU1YXo3alJIVmVOUzcvWjlo?=
 =?utf-8?B?dDlyakhodG5xVHE5YXBpWVlsRGJyQzVFOUFqRHZ6MWtJK0podzNEb1Y1eXJr?=
 =?utf-8?B?WmU4ZkpQZWo5OHBBYjQ1MkVMUmFyYzIyM3I1bGZxMFZCUElraDcrTmI0NjZI?=
 =?utf-8?B?QVNnNzZnTWNad00wVXpKYU84Tmt4UGQwWXFPN0JWQnNzbVV1ZkFwWGhnekM1?=
 =?utf-8?B?NXJqa1Q4STA4V0FWV3BkS0QzVENNZEw4bEsxZndHNEMzakYxalFTNkt5ZjZC?=
 =?utf-8?B?WkdaK0RYeGs2aFVFZ0Ivd1dGNTZtVTkxQlR3N1V6ZXNwbkNpNjJvWEtRU2dX?=
 =?utf-8?B?SEcrbDA1bGpwVDZIR0YrbjhBRVZHcVorM2xyeHRya25wZWxld3RRcUxTRGFJ?=
 =?utf-8?B?MlZxbkdTRCtoZVRQS3ZSWEE4emc0dk1BVG4zQnUwNWZSYU5Va083QkFLczg3?=
 =?utf-8?B?Tkt4Nk9yYnZJa09XY0J5Ty9DVTlldllFRlY5Q1pERjhKZWVWSStvODI1ZzY1?=
 =?utf-8?B?R0djWHZlalBCeTRlVnBwalVxTGdVZVcrK09RdGEvaUNWSWhyb24zc044dGtj?=
 =?utf-8?B?alVoaTIyMlZTQWZMQU5JUlFCbVZyVTdydXp2Z1ZxVUtjaGloTGZKMGtSZm9k?=
 =?utf-8?B?enF6cURmalYwaWoyTFovYmRnV0hMZm1Vdk9lVThBTGdaSFVsNVZjZEo2RVdI?=
 =?utf-8?B?OS9Cb0JRQTE4OHVqVDFCNlRURFNFalRjWnJCc1oxc3JpMDNjTGRlVVBYcjN5?=
 =?utf-8?B?eUkyZldXQzZyQjdFL1hOSVd1TncrclptNHMreDVVRGRxanZuazhPT1lvUnhB?=
 =?utf-8?B?K3hmdUtMM1hYbGVqSE1vb0Q1UHFTN0VtcWZCUnFCQVg3eTdnTlZsVXZ6UXRu?=
 =?utf-8?B?UkQxVis0YW1FUnVkTkJ1L01wTjZTRytJeHZGbERHeGhtT3BiTGlNL0hpNXl1?=
 =?utf-8?B?NXpmbkd0WnNnZHJXQjg0QlppallvdUhhcGNKQWowYjB0SVAvdDB6cmVnOTcz?=
 =?utf-8?B?Nkp3MlJaa0VNUlBHbGtSWVJZL1BlaS96TTVWd0ZKV0FtVnFHUDdHcXJpYlRV?=
 =?utf-8?B?dU1tSmlhTy9BWStUV2g0RGQxTlhMTGdsUWNwUXFPb1k5aEF4TWd2RGppb1JG?=
 =?utf-8?B?N2ozVDROUnhraXkvQ2Z1aXJCb0tVWk80YldCVHVGRGRTNjBoVW85VVlDYWRR?=
 =?utf-8?B?QXVMWkxoeThwdVdqZ0ZRSzhnVjBsVmdZY0VUdXp2ODk5Njk5SDZZWExRWjVT?=
 =?utf-8?B?RlppcmZkb2hNTzd5TjBFYTZ5Ym1VNFczbkpXRkc0Y3JWNXRqeUJHcU5sZUJK?=
 =?utf-8?B?SVZvZlNEdUU5SGhMVDRhZW1yNnMrMFRUNmxzZHd0SWNLdEh1SlMrSWlzM2tN?=
 =?utf-8?B?RElEa2xrZXBwVTZDN2dHL1FQaHA5eC96c1ptdG5BM1NTak9BTjBSRVhNdEZB?=
 =?utf-8?B?VGlLcEVNU3pwNlk2TGdNQmhGd3ZidzAxSklzSGo4eW5UQWlERjh3NzlPOUZH?=
 =?utf-8?B?K3REQU9ONVlUZ2lKVm1HcmhkZWhBK3ZwSE05TmZ5b1ZCYzllRFJUTFMwd0ow?=
 =?utf-8?B?UWJXT2prcFhqa3hUVlhWWlZuSEQ4T2w2WHBxZVM1ZDRvcjY1QkFnMlZVTk9o?=
 =?utf-8?B?RjdiYnpsRHpyL2JOWkFnWjExeTFRM3lWZ0E2QW03Y2RycWI3a0o3S3E2T3dJ?=
 =?utf-8?B?b3drendmSmtmTHRkK0ZmaGE5bWVKbElQUWFNTFlSZXNxTUFuWmdiRDB1T2E2?=
 =?utf-8?B?TkxSUU1vdWdGQUNwdHFDVDVIVGViZ3RyT0d5K2lvUTlZSDJGOW5Nbm1Gb1cv?=
 =?utf-8?B?c2UvLzdMSUhYbmtZUFVjcERjK3llc0pqWkNlYVBTOWJrbEFLWjlQWElncHJD?=
 =?utf-8?B?a3AxYTFFQXpxMDRsSnZ5Z1dOd2M2VG9vOUxyLzlyZXNUOGw2Y09abk93NWpN?=
 =?utf-8?B?NlJxMnNyTjY4dXl1TU5JeFBUWFljalRmYlVQSWdGVmdvaUk5QWZ2aVNyRlFw?=
 =?utf-8?B?cUhkV29wdkZnM21QK1dGeXU3cjFhV1JyK0lXQzJQMzBjMDU2SEpzNkZuSENj?=
 =?utf-8?B?M1hGWEtIZTZYVXA4N09PaVNUWTVxN080UVkwei80Mk81VUZEa1NtckhMbFFt?=
 =?utf-8?B?SUtyREVua3B2M3RCVVQxVmtvZ3lKeFpPSjZzYlZ5MWlJZjcvRVNTZ2ZQblc2?=
 =?utf-8?Q?ZVcMWpza0lNqYNAFOS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d107cdc-bba8-422a-03c3-08de9cb255ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 18:51:29.2121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R/VBWOYeFW6OUsltMw5R8bXSeokeK2IOrtePVrybB8tIfotC386OkGw9ALlKdz5a84kNSF5e5nhh594PmHlgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5j
b20+DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZngg
PGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4
DQo+IERldWNoZXINCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxNywgMjAyNiAxOjU1IFBNDQo+IFRv
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA0LzE2
XSBkcm0vYW1kZ3B1L2dmeDkuNC4zOiBhbGlnbiBtcWQgc2V0dGluZ3Mgd2l0aCBLRkQNCj4NCj4g
UGluZz8NCj4NCj4gT24gRnJpLCBBcHIgMywgMjAyNiBhdCAxMDowM+KAr0FNIEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IHBpbmc/DQo+ID4NCj4g
PiBPbiBXZWQsIE1hciAxOCwgMjAyNiBhdCAxMDozNOKAr0FNIEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gTWFrZSBzdXJlIHRv
IHNldCB0aGUgcXVhbnR1bSBiaXRzIGluIHRoZSBjb21wdXRlIE1RRA0KPiA+ID4gZm9yIGJldHRl
ciBmYWlybmVzcyBhY3Jvc3MgcXVldWVzIG9mIHRoZSBzYW1lIHByaW9yaXR5Lg0KPiA+ID4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80
XzMuYyB8IDYgKysrKystDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjlfNF8zLmMNCj4gPiA+IGluZGV4IGFkNGQ0NDJlNzM0NWUuLmQwYjhmYjkzMTcyMDEgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYw0KPiA+
ID4gQEAgLTE5NDMsNyArMTk0MywxMSBAQCBzdGF0aWMgaW50IGdmeF92OV80XzNfeGNjX21xZF9p
bml0KHN0cnVjdA0KPiBhbWRncHVfcmluZyAqcmluZywgaW50IHhjY19pZCkNCj4gPiA+DQo+ID4g
PiAgICAgICAgIC8qIHNldCBzdGF0aWMgcHJpb3JpdHkgZm9yIGEgcXVldWUvcmluZyAqLw0KPiA+
ID4gICAgICAgICBnZnhfdjlfNF8zX21xZF9zZXRfcHJpb3JpdHkocmluZywgbXFkKTsNCj4gPiA+
IC0gICAgICAgbXFkLT5jcF9ocWRfcXVhbnR1bSA9IFJSRUczMl9TT0MxNShHQywgR0VUX0lOU1Qo
R0MsIHhjY19pZCksDQo+IHJlZ0NQX0hRRF9RVUFOVFVNKTsNCj4gPiA+ICsgICAgICAgdG1wID0g
UlJFRzMyX1NPQzE1KEdDLCBHRVRfSU5TVChHQywgeGNjX2lkKSwNCj4gcmVnQ1BfSFFEX1FVQU5U
VU0pOw0KPiA+ID4gKyAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1FVQU5U
VU0sIFFVQU5UVU1fRU4sIDEpOw0KPiA+ID4gKyAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRt
cCwgQ1BfSFFEX1FVQU5UVU0sIFFVQU5UVU1fU0NBTEUsDQo+IDEpOw0KPiA+ID4gKyAgICAgICB0
bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1FVQU5UVU0sDQo+IFFVQU5UVU1fRFVSQVRJ
T04sIDEpOw0KPiA+ID4gKyAgICAgICBtcWQtPmNwX2hxZF9xdWFudHVtID0gdG1wOw0KPiA+ID4N
Cj4gPiA+ICAgICAgICAgLyogbWFwX3F1ZXVlcyBwYWNrZXQgZG9lc24ndCBuZWVkIGFjdGl2YXRl
IHRoZSBxdWV1ZSwNCj4gPiA+ICAgICAgICAgICogc28gb25seSBraXEgbmVlZCBzZXQgdGhpcyBm
aWVsZC4NCj4gPiA+IC0tDQo+ID4gPiAyLjUzLjANCj4gPiA+DQo=
