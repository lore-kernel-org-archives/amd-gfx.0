Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7745FF30295
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 01:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E3210E053;
	Mon, 16 Mar 2026 01:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZlowha/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE1910E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 01:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCdVgRqkCnvg02DZUZbztssfQXDoKF68hDiMpe7bEio25i4r3K1Z/j7I3Ld+MibBp22xYUUGJ3lO7pBGQqzeh2QueYfm2aPlLOXC5r0eivEFqKv/lDtveL0uy4zB8cS2Oazi8AC7S0dwdC+AjwXqyKyP9IWK4Mfg1X9WJQeMF0X/Ett1licVjpvHvqMFhAb1rldKcxxM735zHc+fEP8gJqBNWG7/k2NoaCuZae7DBNDEVL/tJM7zfR6f5PSIMx/IsvSVakKCeA+cWP9egKk2AokImmJRGr+H2clcBmVYXBqbN0DqWj3HEQT3EqPgs8mJelZ7BjSQtwxcRrKqccITiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQdWgdFgLGsOCufigTpmIql9cgzdNVST65RxLAC43dA=;
 b=HHIzKBcCeyyanPKXiE0Z0jAVE52Ekt812qA4jkyvFO8esSPxNuYBQutQZhagF0b3EE/00Gz4irFKzhuu7rduorZvuvz+5dA5iwOsVsOMSrsv2ts9/mqlti60vR3gOBUHUij5XJK2wdQuwINvb1t2hHIPd0F+Udc3PuK/slg+BH4lB9K/+szyxD/UWj8j89dnSRBkjblV52HXYB7zPTRPY/WrmTX3tqJc3lbf/IuL4rkr26/XHbPOB+TGkbV3XPynJTiRSzsqMSjj8Ow+Vl2ZiiCBjGOegSZgcTm+UR5qTEA4ru4Z6dwojW6l0juQfPOdJdkB7rfUdYccGAqSmbWLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQdWgdFgLGsOCufigTpmIql9cgzdNVST65RxLAC43dA=;
 b=TZlowha/OZjXMKbdomga/pqxggz1KUDrmQKaQZQqQ9VT5MoIgIxVFCt69XW0+J2ncd37nf69XJpxm9wq4YjtrVrWcwIQqY48lKZw5txYxelLgL1LJ/+BljQglxp/1vdt6LA78xmk+8AcOBoRZLvjpqCDIgyTquyS27WqgdLPHmM=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 01:25:52 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 01:25:52 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdgpu: Drop redundant queue NULL check in hang
 detect worker
Thread-Topic: [PATCH] drm/amdgpu: Drop redundant queue NULL check in hang
 detect worker
Thread-Index: AQHctEtL9l3qgEWFbk2+PhkGE8A8srWwXwhA
Date: Mon, 16 Mar 2026 01:25:52 +0000
Message-ID: <DM4PR12MB5152E162339AD1B708FCEDA7E340A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260315071324.1933271-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260315071324.1933271-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-16T01:25:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH1PPFDA9B3771F:EE_
x-ms-office365-filtering-correlation-id: f4bfede3-3b69-4f39-e938-08de82faf697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: URL7GV4kEtQIMXiI/4kv5/hRLQpLoE498Uu5WxCiXDrYyITcdipcgsH11Ul/SvJIe66MHyIvl7EEFEB9+9+VjadSM8iosPhgQZBNbOZF0Ia1uWN7kHwnr1cbhNzuMDngYp2wD4W6RzzfzI2C2Cm536k6i3Re5zt+kMSqmFZrK++qfLNHoNkyLqGpVLJtqd38OrFp05JK/hRoXwkNjXNHmYkDYKijk7vRPaj90nmwsZThn4je+dX5iGbnTrev4y0BFSVUIRL4mM0LdrEs3N0PIKHp8RRXrs+owCYTZ+6kcnHeklaatlmQZ0UH0LC3QXzIpdA2fZjtndC1H/XZqMg5PMIItcsUWgH5/5PviyTLmehcepYfUt7PsglV0cUOOrGCWHDeAV5gkhmkGYtJ2RS54b0mz8lzXdFluw0cIei362PwjrGA3KEJ5+NVs7SeAO8fUJlKHWqQwgOZo47YX1+ezYiWGKHXPcNFIs2/Fkz8S8xrtTihGQx1fZznXyDIQziaeXeM+U1y6U4R4gncHBs9mAxXa7/aWShhi/X6W0TZvgO/aOzP3m91g358Y8cw7vrG/1y2GDUBIBGHEz65yVpfhpAgC+A6Eg37HSLOyE5ALdJ6ssxylUuw0Drz6PwHDZWngFBI9fpEy9o2Z7oBnFmhuGiKBk4ulBEe63S67S/B9OzHeZdA+Lx8qc/MqS6hRfdq05hULsVVVbZvNSG6K39oaUTO1i51iu27wgYuYfZHanzZ3pYyG4lxsuOTZ/eRS/GMX6KjmpJS9JnWozfJYSLUehMH2nt8QT0zy/myeaVWwkI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFJpV1FkSnRQbE0xUXc0Z3VJbjNsS1NBR3B1a3paeThmTnBsbVF2Nmw2aDVJ?=
 =?utf-8?B?TjkrTEc5eDkrWjJ2QllobXp2aGF0c0RKZUJBYnI1WTNhRWVmOWl3Z0E4RDdV?=
 =?utf-8?B?NStqN0k0SVpCWHR3bUduYmN1aFlhT0dFVnNmV1Y2dk5qQThrb3ZpTjBOZHA4?=
 =?utf-8?B?Q1QxTGg3cmc4RVNBT2libXVacXNFTXozM1NLMDNKT1NzdW5VVGFrQVkwN3JM?=
 =?utf-8?B?Y1lGSnc4S3QvVDNnWXh0WWk1VWpsZlR6UWNuWThGYWI2alVmUzNRZ1pja09w?=
 =?utf-8?B?UmZ5eEpEV2kvSkFnT1UrRHYrbE9iOENQME9pWlRTaUlHN0t3Vm5NVmgwSUQ4?=
 =?utf-8?B?ZU1QNkNUNGNJWDMrL0JZV2hsV0VFWG41VS82Ukd0dGZqTEd3NFR2clJBQnhp?=
 =?utf-8?B?SzdCMm05VS9FZ2tMNTQ4T2U1NHA0WHpmL3JvSnloMVZCOXBMZFFORDNhaHo3?=
 =?utf-8?B?cG11cVZmV1o5LzI2M3JOVGpXa3dJT1VyNEZDN3JvVWw5MnBZQUsrTjl2T0Jy?=
 =?utf-8?B?YmN5U2tPbnJnUmhzVWdMRzdQUStIUWQ3Z053bmFTWnFCS2Z6N3B2aklaTnN1?=
 =?utf-8?B?QmJDTkdsZG9WWmREY1hMbTlubnFTV25ZTGEwV3VMTlhwNC9hSUQ5bVFOQzFU?=
 =?utf-8?B?L2JxRmJYdlRsb1FzdmhKekVhQVVyemRLdk8xT0duamRRS0QxMmpEblZFWHRW?=
 =?utf-8?B?NGI2c29KcVVGS3BSOUQxMXU0VjRaeTlHQy8rb05jUjh1Z3l3dThPUXNMNXh4?=
 =?utf-8?B?aFYrNUR0UHhSdTlwUDQ1eHVLU2RtY2NhdllyY05TR3BGd1c0RDYzWmJENVBl?=
 =?utf-8?B?NTRTRzdHUE5lMW9ZZWZSMFEyRVh2b3UzcEJpZVNRcnVBcTVpdDIvcEJhL2pU?=
 =?utf-8?B?bXB6TGl0K1RjODZvYmxxeWZzbXhIL1BaRzB3WkZ6MWY4SkVnNWpHMFNJRFdF?=
 =?utf-8?B?eTMzV0x5RFM5RzNxczJINzVsank5U1FLdTdFdGlyY3l2V1BhZUU0UHlNL0JH?=
 =?utf-8?B?NjF2Y3ZTbHgydWVEYkNrcTVWeE1hSitlcmpwdzdXUUZISERSbHVSNVR4dmRP?=
 =?utf-8?B?ZDhJb2FSR1FyMVJQT2dCd29sSVR4ZkFLRFQ3SXRpR014dTh5a0V5R205Uzdw?=
 =?utf-8?B?Sm9WNXNPYkpNTktXanA1OTh1MnoxYS9DMnQvK3hsMUs2QTRoYmh5TDJYNzFN?=
 =?utf-8?B?WmQxVjk2aW52amVXUjR0WStMbzgxa0lmZ0pybU1wZHZ5MjJvOVRKNTFLbkVl?=
 =?utf-8?B?bmtqWHdXb1Rka3hsVVFwdUNueU4xOWU4aTJCcDdHdmhqVkxtMUhKb3gyNTFG?=
 =?utf-8?B?TkhJK1ZGbnVobDFrOUNPdVczMHp2YmNkV3hmcFhWZzVaMWRBV3JYSG5lbzZT?=
 =?utf-8?B?UFBUK0ZqcXZKZENBLzNNaS82NjRVdGRNOWtYVHhXYU03WVBLWWNQR3V5YTN2?=
 =?utf-8?B?ZC80MHFMUWsyakY5K3FKK005Wm0zZE11VlkrQWhhOXk4eHRiR2c5L2cwSWV0?=
 =?utf-8?B?WmlKQW1BcmtGaDUrcHVDNnJaU29VR1ZFWEFUOHBoN3RXY25QVzhQcVVrMXU2?=
 =?utf-8?B?SEtOUVZjSVduU3NDYUpNRXlxV3VUWXg1TlZ0VkY4dGl6S3RzUzN2dU1iZVMz?=
 =?utf-8?B?eXhxdUN5L1NXQnRYL0pLUUlQVkN2SFJic3NYaXRJWkNNUWtkS25VRDJLdnBB?=
 =?utf-8?B?MmNFYWVxTkx3OXo5TFM2ZHZCbFF4MXFjQ0NHYitRbTFQaGRzUkhydHdwVWJ4?=
 =?utf-8?B?RGt0eEFWem5ESzFNYmMzRmhaTGpZbGJESGw1NFFUMkliMXhoRTBLNFBTaHFr?=
 =?utf-8?B?bUV6RkU0UEdUanZTS2pFL3lFR3EzMmtoS2llY1UxRWFTQllxK014TXlEQ1RR?=
 =?utf-8?B?V3pUMVBTcVAvVkx4TThpOTVacmdiUk5vQUg3a1dPUHJFV0pTcERKakFhb1lO?=
 =?utf-8?B?YWI3QTZpZzR2UjZuQTk0UlRDdGJEblFOb2Erd0RSbW5UVWI5NGpISWRPR2Qw?=
 =?utf-8?B?UUttcUFVQnBENWlWSUFhcit6a2ZiUkF3ZzFCNmdqclI0VExUUUEyU1BKSEdt?=
 =?utf-8?B?QXRtN1pDRVNxVVJaRFAva2V6ZUdudFl4ZVJwWkFaVTJmV05UbTlpd2pOc3Zo?=
 =?utf-8?B?S3lFd3JUUFhpclFaaU9RcnA1QXZJdDBrTkJ0YndtRHVLL0VucktQTXJkRWF3?=
 =?utf-8?B?aU5nWGVTcjM2VUlyWlVaYVliaDRUZ2RPYmxLMVJMc1l4STVlcDVNUE5nN200?=
 =?utf-8?B?N1Vqc3N2cGZYMzhVSUErQnp0Ky9WTXVVUjZDZEdQakZXY1FtZmlrNVFoK3Zi?=
 =?utf-8?Q?u1hDggzXi2k9C3KP0V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bfede3-3b69-4f39-e938-08de82faf697
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 01:25:52.3426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvZQHOWTZvmhA65Ty2OJXzv9lsoSZGSBIDOajgcgP7WybqgzsVbetQDD5MHAF5A7OxGydpHnVijO4vfCEYLw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KQWNrZWQtYnk6IEplc3NlIFpoYW5nIDxqZXNzZS56aGFuZ0BhbWQuY29tPg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBTcmluaXZhc2FuDQo+IFNoYW5tdWdh
bQ0KPiBTZW50OiBTdW5kYXksIE1hcmNoIDE1LCAyMDI2IDM6MTMgUE0NCj4gVG86IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5NVUdB
TUBhbWQuY29tPjsgWmhhbmcsIEplc3NlKEppZSkNCj4gPEplc3NlLlpoYW5nQGFtZC5jb20+OyBE
YW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+IFN1YmplY3Q6IFtQQVRD
SF0gZHJtL2FtZGdwdTogRHJvcCByZWR1bmRhbnQgcXVldWUgTlVMTCBjaGVjayBpbiBoYW5nIGRl
dGVjdA0KPiB3b3JrZXINCj4NCj4gYW1kZ3B1X3VzZXJxX2hhbmdfZGV0ZWN0X3dvcmsoKSByZXRy
aWV2ZXMgdGhlIHF1ZXVlIHBvaW50ZXIgdXNpbmcNCj4gY29udGFpbmVyX29mKCkgZnJvbSB0aGUg
ZW1iZWRkZWQgd29yayBpdGVtLg0KPg0KPiBTaW5jZSB0aGUgd29yayBzdHJ1Y3R1cmUgaXMgcGFy
dCBvZiBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlLCB0aGUgcmV0dXJuZWQNCj4gcXVldWUg
cG9pbnRlciBjYW5ub3QgYmUgTlVMTCBpbiBub3JtYWwgZXhlY3V0aW9uLg0KPg0KPiBSZW1vdmUg
dGhlIHJlZHVuZGFudCAhcXVldWUgY2hlY2sgYW5kIGtlZXAgdGhlIHZhbGlkYXRpb24gZm9yDQo+
IHF1ZXVlLT51c2VycV9tZ3IuDQo+DQo+IEZpeGVzIHRoZSBiZWxvdzoNCj4gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmM6MTU5DQo+IGFtZGdwdV91c2VycV9oYW5nX2Rl
dGVjdF93b3JrKCkgd2FybjogY2FuICdxdWV1ZScgZXZlbiBiZSBOVUxMPw0KPg0KPiBGaXhlczog
MjkwZjQ2Y2Y1NzI2ICgiZHJtL2FtZGdwdTogSW1wbGVtZW50IHVzZXIgcXVldWUgcmVzZXQgZnVu
Y3Rpb25hbGl0eSIpDQo+IENjOiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4g
Q2M6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gQ2M6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNh
biBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gaW5kZXggY2Q1OTliNGE5ZDc1Li42
ZTBjMzY2ZjNmMDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
c2VycS5jDQo+IEBAIC0xNTYsNyArMTU2LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3VzZXJxX2hh
bmdfZGV0ZWN0X3dvcmsoc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgICAgICBzdHJ1
Y3QgZG1hX2ZlbmNlICpmZW5jZTsNCj4gICAgICAgc3RydWN0IGFtZGdwdV91c2VycV9tZ3IgKnVx
X21ncjsNCj4NCj4gLSAgICAgaWYgKCFxdWV1ZSB8fCAhcXVldWUtPnVzZXJxX21ncikNCj4gKyAg
ICAgaWYgKCFxdWV1ZS0+dXNlcnFfbWdyKQ0KPiAgICAgICAgICAgICAgIHJldHVybjsNCj4NCj4g
ICAgICAgdXFfbWdyID0gcXVldWUtPnVzZXJxX21ncjsNCj4gLS0NCj4gMi4zNC4xDQoNCg==
