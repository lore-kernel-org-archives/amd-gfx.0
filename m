Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B181A103E164
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 11:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41ADE10E7F5;
	Wed, 18 Mar 2026 11:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xCx22G9N";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0133E10E7F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 11:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHgimpm+V81VKrXynv/hN8L2SbpEXbRhZ4tfIaNEvUu5IPMmp9FBg2WYD1pPt1S1vwEVDv9fIcItYTYY1uPglv9T+VnTtI+LXvegqfIceJS+7mfYFJZkabsY3M680E0vEMxzJA06I78GSIJ94gXnGb4L0q78W7L2DwlqeWjtDgRUG9kV/ISaoT8BrYv9ThE1vkxt4IzMPt9FeBAAZ3bkv+uY8ai9mD1BnPbmPQA88ZujrQ+0y8GJsEAmlgW4jcADTuZdFT8cyMjPq01tjATcR1YejLgBm9mhcybxGPdF6h3uSDb5UR6aRg65pyQjceWJ0oU5NguXyDDEURMx7TgzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1evMbi4+aeElOuZSajdHmc0Etzd7H4qOABzRc/Zi1c=;
 b=FCu1RaKgbsPPsNQx2jCu63baSltWZEWZu1CGuxTkWv6nr8c7Ia29rMiiC2RDwCyK3WdbQIUNwdNrVgvoFXbm1CQLuc/xKn/UU/489hseanj/U5Xgs8LEEkyMhaLYttLQAl289gB5c+xh5vhcRMqB8vefsokg5W4zspcONyjIJs4/Ezf6bbp8yv/CvL1yeNjengzQNQSnOVzUFZ1SLSL0DCbYMUWkIRG1YQUHjBFDHRe+7V273l3PkxrFpz0ssczdzliuJa3iTa5d1A2rTYKBNMesPaQq1GYKnxfK2nBtY0xSXCNNMXKAoNf5xfPYOcLQYsYhn7isw3HEce4656OKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1evMbi4+aeElOuZSajdHmc0Etzd7H4qOABzRc/Zi1c=;
 b=xCx22G9NzCUCLuuNwe4fEah0S6DkmVqpuE+yF+Wt1xuyQUr0M0fwTyTbo+V0K0PChtxqRHskk6s86sXdJcL1r+NheU00Edxf4yGf6X6D2HM6blsyZLTkXV2vyt16qOt/GOIk82tp00P21x22rxh+AYyHhsQcmyTPMZ9Az5X6wXo=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 11:11:37 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 11:11:36 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v3
Thread-Topic: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v3
Thread-Index: AQHctsJkJCLB3QKgHUOUJ7BBkMOtjbW0Hp8AgAADm3A=
Date: Wed, 18 Mar 2026 11:11:36 +0000
Message-ID: <IA0PR12MB8208A7A18B8626B723B2D5FD904EA@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
 <edc9d882-76f3-4d1a-a9a5-698752984716@amd.com>
In-Reply-To: <edc9d882-76f3-4d1a-a9a5-698752984716@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-18T11:10:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS0PR12MB9422:EE_
x-ms-office365-filtering-correlation-id: 805edd4d-76d4-4f4e-9b5c-08de84df1f01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003|7053199007;
x-microsoft-antispam-message-info: U1izWZeeK4B/V1luXoJeblbnV5usveAQRvYkvl2VnC/1L8nrU2oaP0Q6vVF9APMti0cFa46L69LPglEK3kKK2Gzd6waRZFctNmtYe80Hw/MdNmLBfv5QedhbCPGOs3DT2UQ0lQ5Mockq7qBZ50HT4LkWWIsruif2QBrX4Z+3ED9IgRpIRsJ3EEvIK9LtVBBdsqv/xMORf5euUbWNjJdy3nR2Co7BrF7IdDpCVyDRdMxgQ9njHaUD4N0fUBMOKrjvAp3Sup9ns5VTUlO70AOdmR4LKOHr9jpdoucjaORYkuf58fdnn27gksljhhGNi55HkHFAgfz4s/NaYc8xNEUFIDxndfadnWFnCtcFheXXXGo93Mutz/mcIZ0skTJxc419r3n0cT1YFXbNTIHCAR3AYay5acuE/TqVGa58ofGBRf4p8tBqeYZL9ssf2TQiccqq9ykpDr8sgfcPdpfD6jJjH24LDZNtFXuaQnDphlu4m64CTgzELevCHTsy8rz7yeN3v94ZYc9v2SwWsd8FFRUr0DCgN3fUwk9KuvomnHRakBnwc/F/YX3OuKDUvwKnQbCPR+SqwCsUzN40bzRJcsxttyNTb7LZI7i5WLAncOJP4+T9lBTBMBxxyZ+2f3NiDQjFMweudEwFvOez1cUG+wpXxb3ujLC1/Szh2L+vVUrRHdIlaRrTwgrX73+AF6CToXEyFzpqy6mDGDR3ocIsIOslM7JTJqaSm82EAizsN9JlQV9TpWRR5lKTZQBwieMGiSegqNLpwt1Eueu6gzWMJLUlXOHRi1ZNzC0oEjMeXsOqgpg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ty9jNnptQllsVnE3Q3hGQkl3Zm5vdEc1SW9QYllYMGhWZkZPL0M5bytvRWNE?=
 =?utf-8?B?N3llT0xnYS9UaXQzN0oxK2RmZFlkQlB0c28rT0RVb3YzaisrN2dPSzJ0MFlB?=
 =?utf-8?B?ekhuUytMY0ZrenYrdWdGeXpiTzlGN0tBZFZUOHRhaURoaWkzOFlZSWxnUXNC?=
 =?utf-8?B?aS9EcVhpMnk2R1NtbmU2TnByckcwQUUwV3lrSG40azE0VHBqMmNITEIxaHlr?=
 =?utf-8?B?YWR5STlTemNsNm9JSFowcTFoZXJBWHFWZmtLUkQ1YTBkR1k3UFlVc01ZZmZM?=
 =?utf-8?B?K09XbzlMVC9qd29zOVhmeHpoSCszRDNqYnpiRVlXUWtqc0ZZZ3Z0bUZJL1BE?=
 =?utf-8?B?NUZEalBuVmlORjZPMndCTTcydDVNdWFzeUwvUk5ncE1WV05DNHYyQUFpeG1J?=
 =?utf-8?B?L0pOL2JLQjRYMm5DKzdLWU0rSUFaQ0VNRUU1Q0lmTTRDSFZnbkp6S1dnbGZk?=
 =?utf-8?B?Zm5WUEd6UWdpNlFzWGFCMGdDTDV1bStRZG8waFoza3AyL3pnK1JyamxJVVJV?=
 =?utf-8?B?UzZhNUZDSWJHbHdMTTZWL0xydnpUbVNQRSsvWXlSSlVNMWlTUVlDRWtUWnQ5?=
 =?utf-8?B?VHFLS0hySjdOUHRRT3BGa2ZGYU9jdXBmQVlkWkViakNnZ2VDWGppSWlVTGth?=
 =?utf-8?B?SXh2ZHFDaWt3VHg5b0dGbk55VlJEV1RkaHd5K1VmZFlhOWtnWWhNeGllSVdD?=
 =?utf-8?B?M2JyYXYrdyt2dUcxZjEzbm9NRWxUZkFDM0hkSUMxZ2ZTQmNSaTJoazZQL1li?=
 =?utf-8?B?TU1JUzZsYWtKV1lEZUQ2dkt4UHVEdDNnZmsycjdwL2tNN1o2ZkZhR3ArV05X?=
 =?utf-8?B?VlJzUHNPUlRuRGNSd3VvMjhxbS9wMk1FUnBOK20xVDJpOVNEcHJrbWt5QWFy?=
 =?utf-8?B?bzR6bzJDaS9uOXdOV095aGtEc2haZjRtdVQ3UGF1YUhvQlN5Y0hIdno2ZDgv?=
 =?utf-8?B?UXVGbFBvTitEWDd6bVNqNnl3YUlvN1VlUXVjTXRxUVVCWE04K2RWczJzVlBR?=
 =?utf-8?B?dUNBSytvMU9SZXdTeTkyZ0oyblcwZTlvK1pHVnNOcFpReTM2N2RWNHd6RVQr?=
 =?utf-8?B?dlJuMEl3RjZLck5NaWxEa1o2M0U4bFpMdG10WmVqSGE4WmpUbSt2a2FldnQr?=
 =?utf-8?B?VFUySGhueDEzZ01OQlY0NlZjR3IrYlRYV1VTdkw1OUdsSEtBYVFqeGludTdE?=
 =?utf-8?B?ZkpWbHFLa3RLbnBVVk1oWDJoRU9abXJtYks4ZTdreVpLTkhzSnY5WG81RWJ1?=
 =?utf-8?B?K2tyS2lNRWI1VE1BZkQ0Nm1NTWF5amEvNVNMMHlhaGxyNk0zbSs5S3J4aTEw?=
 =?utf-8?B?N2FrY0xPWnErVjhrQ0ZxckdDMFVwNFc5bjduVkRESmIvUGxkL292RXBrSnlj?=
 =?utf-8?B?MGZrWmJjbTA0ZUl0REhjVHJmVHBlSEE5MlZNb09Ba1pWeXkzOGoxSUVwY0RB?=
 =?utf-8?B?NkpHbjBXR2w3cTB0UFdheWlTRnJDUXNnVjhNYVFBN0kzeWI1dVAwVGxUQTVW?=
 =?utf-8?B?MmQ0OWpIK09NUE82eTNwa1NOSW43NzVQY29HbFcvUDd6T1dxODU3bVhwVWUr?=
 =?utf-8?B?ampGNmU4aFFXaE9NaW9tbnZqcy9xMXVucTI1MGhNbURva0hybVYyTTZJR3RI?=
 =?utf-8?B?ODhIalRRLzNueW9RRnFJcFZIZkxCdjAvMnp6SE9QNExMcHIxcWdtQmFUZkRS?=
 =?utf-8?B?eTlKOUk3ZEtzRTVsZGt3emVMeDF1TDBnUFpjL1FuVDlpVDcySFFkdTFrWGZv?=
 =?utf-8?B?ZXhHakRwVGRXUzNTVlUyMTVZVjluQzdLV3dCdTZTZzBOSGw3VXp2RjJzZVFa?=
 =?utf-8?B?cTJSb2RhQTdrQ2JzK001UmtoNzFGWDhuKzV0RndYSnlDZUp4cDR0SmhSMmlG?=
 =?utf-8?B?SlZqZnQ5VGZ3TGRBZUpsajdGVS9nQVpjS2FtOUtVaVdJT1hyVXIvZmxwWGVl?=
 =?utf-8?B?ZUlRM3MxTWZ4MThSZ0Zxem1mbGdIYmtOSGY2NElRak1BanRBWjd0Vkw1RE1K?=
 =?utf-8?B?cDBZckorU2tjREFtcFRGc0dZU3gxcUI2Q29BZnp5OTlMeER0RVRGYnpZSXlp?=
 =?utf-8?B?Y3lNalJFU3JjZVRXTUFVeUljUElGaXZmcUg2SHhRRDUrZDlYdzhNVUR2Y05R?=
 =?utf-8?B?RXlqSUREblpxeHZMeEZremRkTk5WQTdaWTkzT2ZlY05xb005TkRKUEdqRzRw?=
 =?utf-8?B?aGpTUWl6N29WanJHclFVWEZtMFh0TFFFVDRwWStLRFZpdXc2ZzZPdDJkaW1u?=
 =?utf-8?B?cFRaaWkvb0lUTVhYOVFJTERvV0J6dUV2VVYvdytSZUpQMWRaVUNMeHZ3MVBR?=
 =?utf-8?Q?5VOLbSMfh2JPcIfrBm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805edd4d-76d4-4f4e-9b5c-08de84df1f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 11:11:36.5496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yi8pk3CxRgDWFEA9uh74873WVPEZSJ1ILZPbPh4RA6vXo15NGx3MeiK2/0QLDT51lpCL6YEoWXHnH1rw+pOBdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE4LCAyMDI2IDQ6Mjgg
UE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1k
LmNvbT47DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgUGVsbG91eC1QcmF5ZXIsIFBpZXJyZS1Fcmlj
IDxQaWVycmUtDQo+IGVyaWMuUGVsbG91eC1wcmF5ZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2M10gZHJtL2FtZGdwdTogQXZvaWQgTlVMTCBkZXJlZmVyZW5jZSBpbiBkaXNjb3Zl
cnkNCj4gdG9wb2xvZ3kgY29yZWR1bXAgcGF0aCB2Mw0KPg0KPg0KPg0KPiBPbiAxOC1NYXItMjYg
NDowMCBQTSwgU3Jpbml2YXNhbiBTaGFubXVnYW0gd3JvdGU6DQo+ID4gV2hlbiBhIEdQVSBmYXVs
dCBvciB0aW1lb3V0IGhhcHBlbnMsIHRoZSBkcml2ZXIgY3JlYXRlcyBhIGRldmNvcmVkdW1wDQo+
ID4gdG8gY29sbGVjdCBkZWJ1ZyBpbmZvcm1hdGlvbi4NCj4gPg0KPiA+IER1cmluZyB0aGlzLCBh
bWRncHVfZGV2Y29yZWR1bXBfZm9ybWF0KCkgY2FsbHMNCj4gPiBhbWRncHVfZGlzY292ZXJ5X2R1
bXAoKSB0byBwcmludCBJUCBkaXNjb3ZlcnkgZGF0YS4NCj4gPg0KPiA+IGFtZGdwdV9kaXNjb3Zl
cnlfZHVtcCgpIHVzZXM6DQo+ID4gICAgYWRldi0+ZGlzY292ZXJ5LmlwX3RvcA0KPiA+DQo+ID4g
YW5kIHRoZW4gYWNjZXNzZXM6DQo+ID4gICAgaXBfdG9wLT5kaWVfa3NldA0KPiA+DQo+ID4gYW1k
Z3B1X2Rpc2NvdmVyeV9kdW1wKCkgdXNlcyBhZGV2LT5kaXNjb3ZlcnkuaXBfdG9wLiBIb3dldmVy
LCBpcF90b3ANCj4gPiBtYXkgYmUgTlVMTCBpZiB0aGUgZGlzY292ZXJ5IHRvcG9sb2d5IHdhcyBu
ZXZlciBpbml0aWFsaXplZC4NCj4gPg0KPiA+IFRoZSBjdXJyZW50IGNvZGUgZG9lcyBub3QgY2hl
Y2sgZm9yIHRoaXMgYmVmb3JlIHVzaW5nIGlwX3RvcC4gQXMgYQ0KPiA+IHJlc3VsdCwgd2hlbiBp
cF90b3AgaXMgTlVMTCwgdGhlIGNvcmVkdW1wIHdvcmtlciBjcmFzaGVzIHdoaWxlIHRha2luZw0K
PiA+IHRoZSBzcGlubG9jayBmb3IgaXBfdG9wLT5kaWVfa3NldC4NCj4gPg0KPiA+IEZpeCB0aGlz
IGJ5IGNoZWNraW5nIGZvciBhIG1pc3NpbmcgaXBfdG9wIGJlZm9yZSB3YWxraW5nIHRoZSBkaXNj
b3ZlcnkNCj4gPiB0b3BvbG9neS4gSWYgaXQgaXMgdW5hdmFpbGFibGUsIHByaW50IGEgc2hvcnQg
bWVzc2FnZSBpbiB0aGUgZHVtcCBhbmQNCj4gPiByZXR1cm4gc2FmZWx5Lg0KPiA+DQo+ID4gLSBJ
ZiBpcF90b3AgaXMgTlVMTCwgcHJpbnQgYSBtZXNzYWdlIGFuZCBza2lwIHRoZSBkdW1wDQo+ID4g
LSBBbHNvIGFkZCB0aGUgc2FtZSBjaGVjayBpbiB0aGUgY2xlYW51cCBwYXRoDQo+ID4NCj4gPiBU
aGlzIG1ha2VzIHRoZSBjb3JlZHVtcCBhbmQgY2xlYW51cCBwYXRocyBzYWZlIGV2ZW4gd2hlbiB0
aGUgZGlzY292ZXJ5DQo+ID4gdG9wb2xvZ3kgaXMgbm90IGF2YWlsYWJsZS4NCj4gPg0KPiA+IEtB
U0FOIHRyYWNlOg0KPiA+IFsgIDUyMi4yMjgyNTJdIFtJR1RdIGFtZF9kZWFkbG9jazogc3RhcnRp
bmcgc3VidGVzdA0KPiA+IGFtZGdwdS1kZWFkbG9jay1zZG1hIFsgIDUyMi4yNDA2ODFdIFtJR1Rd
IGFtZF9kZWFkbG9jazogc3RhcnRpbmcNCj4gPiBkeW5hbWljIHN1YnRlc3QgYW1kZ3B1LWRlYWRs
b2NrLXNkbWENCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4gWyAgNTIyLjk1MjMxN10gV3JpdGUgb2Yg
c2l6ZSA0IGF0IGFkZHIgMDAwMDAwMDAwMDAwMDA1MCBieSB0YXNrDQo+ID4ga3dvcmtlci91MTI5
OjUvNTQzNCBbICA1MjIuOTM3NTI2XSBCVUc6IEtBU0FOOiBudWxsLXB0ci1kZXJlZiBpbg0KPiA+
IF9yYXdfc3Bpbl9sb2NrKzB4NjYvMHhjMCBbICA1MjIuOTY3NjU5XSBXb3JrcXVldWU6IGV2ZW50
c191bmJvdW5kDQo+ID4gYW1kZ3B1X2RldmNvcmVkdW1wX2RlZmVycmVkX3dvcmsgW2FtZGdwdV0N
Cj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4gWyAgNTIyLjk2OTQ0NV0gQ2FsbCBUcmFjZToNCj4gPiBb
ICA1MjIuOTY5NTA4XSAgX3Jhd19zcGluX2xvY2srMHg2Ni8weGMwIFsgIDUyMi45Njk1MThdICA/
DQo+ID4gX19wZnhfX3Jhd19zcGluX2xvY2srMHgxMC8weDEwIFsgIDUyMi45Njk1MzRdDQo+ID4g
YW1kZ3B1X2Rpc2NvdmVyeV9kdW1wKzB4NjEvMHg1MzAgW2FtZGdwdV0gWyAgNTIyLjk3MTM0Nl0g
ID8NCj4gPiBwaWNrX25leHRfdGFza19mYWlyKzB4M2Y2LzB4MWM2MCBbICA1MjIuOTcxMzYzXQ0K
PiA+IGFtZGdwdV9kZXZjb3JlZHVtcF9mb3JtYXQrMHg4NGYvMHgyNmYwIFthbWRncHVdIFsgIDUy
Mi45NzMxODhdICA/DQo+ID4gX19wZnhfYW1kZ3B1X2RldmNvcmVkdW1wX2Zvcm1hdCsweDEwLzB4
MTAgW2FtZGdwdV0gWyAgNTIyLjk3NTAxMl0gID8NCj4gPiBwc2lfdGFza19zd2l0Y2grMHgyYjUv
MHg5YjAgWyAgNTIyLjk3NTAyN10gID8NCj4gPiBfX3BmeF9fX2RybV9wcmludGZuX2NvcmVkdW1w
KzB4MTAvMHgxMCBbZHJtXSBbICA1MjIuOTc1MTk4XSAgPw0KPiA+IF9fcGZ4X19fZHJtX3B1dHNf
Y29yZWR1bXArMHgxMC8weDEwIFtkcm1dIFsgIDUyMi45NzUzNjZdICA/DQo+ID4gX19zY2hlZHVs
ZSsweDExM2MvMHgzOGQwIFsgIDUyMi45NzUzODFdDQo+ID4gYW1kZ3B1X2RldmNvcmVkdW1wX2Rl
ZmVycmVkX3dvcmsrMHg0Yy8weDFmMCBbYW1kZ3B1XQ0KPiA+DQo+ID4gdjI6IFVwZGF0ZWQgY29t
bWl0IG1lc3NhZ2UgLSBDbGFyaWZpZWQgdGhhdCBpcF90b3AgaXMgbm90IGZyZWVkLCBpdCBjYW4N
Cj4gPiAgICAgIGp1c3QgYmUgTlVMTCBpZiBkaXNjb3Zlcnkgd2FzIG5vdCBpbml0aWFsaXplZC4g
KENocmlzdGlhbi9MaWpvKQ0KPiA+DQo+ID4gdjM6IFJlbW92ZWQgdGhlIGV4dHJhIGRybV93YXJu
KCkgZm9yIHN5c2ZzIGluaXQgZmFpbHVyZSBhcyBzeXNmcyBhbHJlYWR5DQo+ID4gICAgICByZXBv
cnRzIGVycm9ycy4gKENocmlzdGlhbikNCj4gPg0KPiA+IEZpeGVzOiA3MDgzZWI4OTgyZmIgKCJk
cm0vYW1kZ3B1OiBpbmNsdWRlIGlwIGRpc2NvdmVyeSBkYXRhIGluDQo+ID4gZGV2Y29yZWR1bXAi
KQ0KPiA+IENjOiBQaWVycmUtRXJpYyBQZWxsb3V4LVByYXllciA8cGllcnJlLWVyaWMucGVsbG91
eC1wcmF5ZXJAYW1kLmNvbT4NCj4gPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPg0KPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFz
YW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgfCAxMSArKysrKysrKysrLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiA+IGlu
ZGV4IGY3ZjM3ZDkzZDBjZS4uNmJlMWY5NzFhMzFhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiA+IEBAIC0xMzk1LDYgKzEz
OTUsOSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZGlzY292ZXJ5X3N5c2ZzX2Zpbmkoc3RydWN0DQo+
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAgIHN0cnVjdCBsaXN0X2hlYWQgKmVsLCAqdG1w
Ow0KPiA+ICAgICBzdHJ1Y3Qga3NldCAqZGllX2tzZXQ7DQo+ID4NCj4gPiArICAgaWYgKCFpcF90
b3ApDQo+ID4gKyAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiAgICAgZGllX2tzZXQgPSAm
aXBfdG9wLT5kaWVfa3NldDsNCj4gPiAgICAgc3Bpbl9sb2NrKCZkaWVfa3NldC0+bGlzdF9sb2Nr
KTsNCj4gPiAgICAgbGlzdF9mb3JfZWFjaF9wcmV2X3NhZmUoZWwsIHRtcCwgJmRpZV9rc2V0LT5s
aXN0KSB7IEBAIC0xNDE5LDkNCj4gPiArMTQyMiwxNSBAQCB2b2lkIGFtZGdwdV9kaXNjb3Zlcnlf
ZHVtcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gc3RydWN0IGRybV9wcmludGVyICpw
KQ0KPiA+ICAgICBzdHJ1Y3QgaXBfaHdfaW5zdGFuY2UgKmlwX2luc3Q7DQo+ID4gICAgIGludCBp
ID0gMCwgajsNCj4gPg0KPiA+ICsgICBkcm1fcHJpbnRmKHAsICJcbkhXIElQIERpc2NvdmVyeVxu
Iik7DQo+ID4gKw0KPiA+ICsgICBpZiAoIWlwX3RvcCkgew0KPiA+ICsgICAgICAgICAgIGRybV9w
cmludGYocCwgImlwIGRpc2NvdmVyeSB0b3BvbG9neSB1bmF2YWlsYWJsZVxuIik7DQo+DQo+IElz
IHRoaXMgdHlwZSBvZiBwcmludGluZyByZWFsbHkgcmVxdWlyZWQgb3IganVzdCBza2lwcGluZyB0
aGUgd2hvbGUgc2VjdGlvbiBnb29kDQo+IGVub3VnaD8NCg0KDQpTaWxlbnRseSBza2lwcGluZyB0
aGUgcmVzdCBtYXkgbG9vayBsaWtlIGluY29tcGxldGUgb3IgbWlzc2luZyBkYXRhIGluIHRoZQ0K
Y29yZWR1bXAuDQoNCkFkZGluZyBhIG9uZS1saW5lIG1lc3NhZ2UgbWFrZXMgaXQgY2xlYXIgdGhh
dCB0aGUgdG9wb2xvZ3kgd2FzIG5vdA0KYXZhaWxhYmxlLCByYXRoZXIgdGhhbiBsZWF2aW5nIGFu
IGVtcHR5IHNlY3Rpb24uDQoNCkJlc3QgcmVnYXJkcywNClNyaW5pDQoNCj4NCj4gVGhhbmtzLA0K
PiBMaWpvDQo+DQo+ID4gKyAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICB9DQo+ID4gKw0KPiA+
ICAgICBkaWVfa3NldCA9ICZpcF90b3AtPmRpZV9rc2V0Ow0KPiA+DQo+ID4gLSAgIGRybV9wcmlu
dGYocCwgIlxuSFcgSVAgRGlzY292ZXJ5XG4iKTsNCj4gPiAgICAgc3Bpbl9sb2NrKCZkaWVfa3Nl
dC0+bGlzdF9sb2NrKTsNCj4gPiAgICAgbGlzdF9mb3JfZWFjaChlbF9kaWUsICZkaWVfa3NldC0+
bGlzdCkgew0KPiA+ICAgICAgICAgICAgIGRybV9wcmludGYocCwgImRpZSAlZFxuIiwgaSsrKTsN
Cg0K
