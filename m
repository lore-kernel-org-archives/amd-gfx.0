Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD7CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 07:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C9510E58F;
	Wed, 27 May 2026 07:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i7D7cAaI";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E69F10E58F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 07:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOaVSu+XpxpcdbiDLiWAyY3i06PJFudBzrVQ//VRnTxa02NFHmhwh1GKm3TTMZJV81eZqeGO5EBFPMVY7BykFTVGCI82aJgE9zfn1YMF32RsxqGDtv4y2QE5J20d9G8HghTSN1ch6ov8FdtITRVnEB1Zktolk1eFtg0guQWz0TicPe6988+fleasuKmbkOzSC/nS9aq+mKgRqqivIa5VABUzuiPoybB36qoenwSWUBqCuG9v5zYLE7sSlu/gCD2eB0zkgBzF/nEhR2+dPyEH19hGcso1nsvhQnCuBBYlYvLqMvlkdMrAJ9Y/6GA0b8fsXrjvQHBZ4sNVyuBJtyb5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7eJt082T4XGKybKd8EKGGKugVP6pMQjhJv9rwI8D/s=;
 b=inf8jwr4Uw6WEDGb1ZxWtC49wqClTiHvaSCTqfM9IbLxPPjg/TLTymrvoIFBiP2AQyeKDEUgGpclYBgbEKKNbwsPRa5ZXYXh+m9q9/VzyywfBIlxRjecOq6gRvkxfoduQfy/8GkGXglj0wqsaqa8qLxHwTViOJIOskpzbzywhFZChX2xPNPr+UkF9wjvxIVE/0daGTzxUjfB/UJkfwvvNp4SFYsSKN0LsuoKyC79dBIK4I4+NtR7EyRttlVmD9cKjrLlima9Ig5osS7fviEwfZ47+ddrDDtoZeOQEDhdfblGByEHksWoycGuQZnwAyRZXbQULQDJHMkRrB1XBMmpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7eJt082T4XGKybKd8EKGGKugVP6pMQjhJv9rwI8D/s=;
 b=i7D7cAaITh9fXff34mKznZzryfBsO8bMiv+8fjD3y3Di2BAefeXA++H2I2hkXanqNT0ha/kANAYXOZ7LcvrTJwmF42lvwJsUiWu3QLJaBuWA01c3pDVxtpK2o28OZKbeg8OVUj6igWB9RoivpVkCLnxINNBL73BE1EoU0zxzFvA=
Received: from MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 07:55:07 +0000
Received: from MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::4579:c97:2cfc:1338]) by MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::4579:c97:2cfc:1338%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:55:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for
 empty wait fences
Thread-Topic: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for
 empty wait fences
Thread-Index: AQHc7PKUwStaNzpPRky6Lksvo9OH+rYgIHcAgAFWwnA=
Date: Wed, 27 May 2026 07:55:06 +0000
Message-ID: <MN0PR12MB6004CE174D0E58CC6C3BC03DFB082@MN0PR12MB6004.namprd12.prod.outlook.com>
References: <20260526093210.55565-1-Prike.Liang@amd.com>
 <78e1b3d4-5e68-43f6-b82a-353fdcf22876@amd.com>
In-Reply-To: <78e1b3d4-5e68-43f6-b82a-353fdcf22876@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-27T07:15:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6004:EE_|SJ5PPFDF5E260D0:EE_
x-ms-office365-filtering-correlation-id: 1e956f72-3aa2-4681-49d9-08debbc544c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: EOKV+5lrLnuzcsg2o/xXa280zv19EKSg2xoewBDhewACukeWdEUMEOjEIVRYiCSMALLu0yGPyZtMBgtH8Y5gCHTVxDl5B/q6uNeSLfwuujIHXtd0e10gPOuzPe928pGJ3lIW3jXt1yVfGFvIrOEq8thLOPWDGATaStCcacvhSo0wR5f1BZoA9euPmSuYquQId8nxXAOneLyuXcx6G3/0RDi4Vo2FE2q9BiqgKv3Puwl+yCqopw/u8q5W/OJ+y1EDNG3IrMyYW6GNHfnNSfDYZpMj6NlRACLGWTqKPnKhBHPktO/ien7qpy+IxHOwk9PkhgLK6hEHv1t2UF5pXD7TUDMJu7O6jWfe/dviJ0Q50OCpnAXUSMIqPz0VeefWhCgQuCscLvo9aew4f8UNJNMn4qoxgrFvY1fbFkwxCRj2c1jiIISIeFaeGBlyqLKFQouJLGnf6tmvMD49TSBoe5ono+/o5tUqhY3CUxzWmwUOZ8hoTUSKQtcbknLcoTqzm1MxagLB7TpaXbNHcWdFmDZ3V6IxtOGtRAOuYYBtJWD2zg+ySf3onbHwBpkZsKOFy9F0pfNGrhTqeBgilV7jJ/Fr7u/YazVvY26dgli3mH1JSET2kI5pegSAx/Zik6FJ0tLxQLQ95Bnkf/44ueTASv25bwDErzLrC09qDBH/XaTed9lUPP7nZzqmMTi3rHlXcgStJR4+yAzeVEMMUtn9PFUaYC1ekCJISKnHSiZXcYjj/QgZAVNy0m0WI973qn1c7H6P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUpoUXByL1haZml3RlU4aGZ1U0wrdk1DbTcyZ24yajhsK05wdXpGek9mU2Ur?=
 =?utf-8?B?a0Nhdk1jTmtvSlZySHpYUmptZ0xUTkZpaXVVYVUxQ0pjN2JSREVWRVArcXJH?=
 =?utf-8?B?cmVGUStma0QrVWNCUDQrcmo5aytLME9ULzBBajZrVnQ5VVk3KzZ6bk9rOXVD?=
 =?utf-8?B?V2Fscjcyb2w5ZVJLRVhHeS9PelRLKytYSVhmM0VSMXdTb1ZSQmdDUWIram9j?=
 =?utf-8?B?ek9oU3FHSk03QnFTcXpNdXJ5SGlOZ2V1NVMzK3hYczhhUGdGa0h0aW5WODF1?=
 =?utf-8?B?YmJYempQVGQvUHl0Mzk3TXZ5dDBBbmRoUC9aRkRLQ2x2Vy92ZUhGUE1HUnlJ?=
 =?utf-8?B?THhhd1NXa2RVQk1pNFVHVjhIQXRCSWppbE1vTUFHZitZZ0hGc0V4TGtwdjBr?=
 =?utf-8?B?M2g3Q2dKeDA3VWdIWmxIUlE2c3BObVhxTG16Q2VVY1RGRTlGbGJLenNGZWtJ?=
 =?utf-8?B?T29hV3ExYmlwczhSQXpRNHRISklvRlVPR2FSSFJrUU91WW5kMEJDTTJzUU9D?=
 =?utf-8?B?WXJLTmpRUjB6c3hud0hGVCtPR2hzNHE5aU83UWtJUmYvWUNEeEVsQUwvZU9L?=
 =?utf-8?B?Qi9Qd3pNTzZJOXJobml3RW5hdC9KMERXWnNmYzFmVnlPYXNUUTl3cDZheS9i?=
 =?utf-8?B?T0l4d3lkSFk0eGN5SWpnNWhpS2dLZWdlT2paOHdlclpXb1BEREc4MDYxRTJF?=
 =?utf-8?B?aXBMM05hell1TFRZanh2YlJuOGhxK1l1ZHdvcFF0TWUzS2pxSS85WW5hK3RP?=
 =?utf-8?B?NEgwQnh1bHloYzY5WU1Wa25BZmdYbksrY2dyYnN1aUk1Sk9hNm1VeUMxeWgw?=
 =?utf-8?B?bW1IMGttRUM1TGxpa3lIYzZXZnVDeE1GYy9ab3ZCWDJPbFdZRFZoUFZ5VnhK?=
 =?utf-8?B?MW9RTkU3SlE4WlExNk5mQVlNeG9QT2llUnEvMnpiYnNGcVJUUWlIdUIvdEJu?=
 =?utf-8?B?eG43NzRNcUVpdkZJaHMxaDdrd2pUREd5MlpNTG5HeXdqaTdlNzAwVTVwYVlB?=
 =?utf-8?B?WS82bkw0ZzB2ckZwcVZDNU1WVHd3MWlnT0tPVXJzUmV6UzdoeTl4bXB3RzFS?=
 =?utf-8?B?WlNiWmh4dVA1UjRkWWFOUGJsUEIrZ3V2dm9qMURLVkljRkJZZC9TYjA0OFRG?=
 =?utf-8?B?YTQwT2djRlVkRnNseGg5OUt6dVE4VFE3WjlBZGxxRVVjRW8rSit6WjJlYzRq?=
 =?utf-8?B?S2N1ajB2c1pVbmpEUTc1NmVVMWlVOEs3K01mVEE1akltRVc3bHpnMmE4SlZu?=
 =?utf-8?B?K08zcjM2YyttSlFaWENwRy9taHl5a1BIZFZZeE5nN2NmSTAzOUtDKzFGa281?=
 =?utf-8?B?MGtoZ0NGNkhvNU5SYjg4cjhvOEVhdUNmL1dzR3Q1QTNZZW5MRTk4NTlIL2Fq?=
 =?utf-8?B?bmFyMzJwZWtDcTdsUEZBZVFZSGd6ZEtDQ3NVaGxmWkJvZWpuWUVsQWp4SW9V?=
 =?utf-8?B?RFVvTTJyNTJjbDNtUjJqc05zd1k3YTZvN3ZUbjRGUGlub3BscWhvL2pBd0Zx?=
 =?utf-8?B?T1VxZXZiSXR4VW5UNnFLUTg1djB6UDRPTTQvY3F4Y3RjbHllTVFjdUFRMlRI?=
 =?utf-8?B?TmtTU0ZSaEF6dWw3WmkzQ201QTg5dVMyakQrOVFRK1djcDRNWkQ1aC91TFJ5?=
 =?utf-8?B?Y0pqb2lMVVVueC9VNU5WMDNCUE4xamtXbG5sUmJ4UWRXbDVsN0R5TGRsRkFx?=
 =?utf-8?B?UjBvRm15Y0JaZ1Nueng5dzFEc25qdFpIUzdOWElQZUhOcXRPckZCc3cxV2RR?=
 =?utf-8?B?REpEOHVSVVhvUm5rVzAydWtHS2VyKzhKUVYzVE9heDB4YlU2N3BVcmVDTUpL?=
 =?utf-8?B?eWh1cFprdEtORW1BbzRET1RNYVZOMDRRWUZPQTZic1ZrekJIYVQ5Um1YVDk2?=
 =?utf-8?B?RGQxZkduQXE3VjJONWFVMjVYYTNuRXZVWnk5YWZhRkk2TmJHMnRnMFpzdjZr?=
 =?utf-8?B?TVQ4Rmp0aU50YnRCSWwrYmZyb2U1NVo2NUZqL1BQMWowU05BMnBrTExpdkph?=
 =?utf-8?B?bC9laHpzblgwMVowKzBmamNadEU2VEc2dER4eUgvako4ZUtwVk1rV2dCOFBO?=
 =?utf-8?B?aTZDRDJEdnpCVVZrcnpsZ1l3ODJtVFFhdFRodDFMb2ZQRkV3cmhJSmxUZlpn?=
 =?utf-8?B?N1N3MGd3NU4xQmxrYjFubDdlMWdWVXBHZWVGNXRUNTRlZlZhWHg5MWlxN2lh?=
 =?utf-8?B?VmtoK1hsNHYvcEg2ZFdpRnc1Q2VlVDc2OFNqRmpjWS9QUGNsMWJDSjE4K0Q5?=
 =?utf-8?B?dW9zSXpxci9GUEw5Q2xjYXBqR09PVDg4MVZIdTFLbFNCUnIwRGV1REF5NVdu?=
 =?utf-8?Q?nnPnC+DiIjF7Gjp//l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e956f72-3aa2-4681-49d9-08debbc544c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 07:55:07.0028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlzJTLI2UmYDCSr3xWVo4A3bRxd3i7LsT1nLL/qCKT3IXRP/NYCsnRGEX3n5rc56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
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
YW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDI2LCAyMDI2IDY6NDggUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBhdm9pZCBleHRyYWN0
aW5nIGZlbmNlX2Rydl9hcnJheSBmb3IgZW1wdHkNCj4gd2FpdCBmZW5jZXMNCj4NCj4NCj4NCj4g
T24gNS8yNi8yNiAxMTozMiwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gQXZvaWQgeGFycmF5IGV4
dHJhY3Rpb24gYW5kIHRlbXBvcmFyeSBhcnJheSBhbGxvY2F0aW9uIGluDQo+ID4gYW1kZ3B1X3Vz
ZXJxX2ZlbmNlX2FsbG9jKCkgd2hlbiB0aGVyZSBhcmUgbm8gcGVuZGluZyB3YWl0LXNpZGUgZmVu
Y2UNCj4gPiBkcml2ZXIgcmVmZXJlbmNlcy4gVGhpcyBrZWVwcyB0aGUgY29tbW9uIGZlbmNlIGVt
aXQgcGF0aCBjaGVhcGVyIGFuZA0KPiA+IGVmZmljaWVudC4NCj4NCj4gVGhhdCdzIGFuIGFic29s
dXRlIGNvcm5lciBjYXNlIHdlIGNsZWFybHkgZG9uJ3QgbmVlZCB0byBvcHRpbWl6ZSBmb3IuDQo+
DQo+IEluIGFsbW9zdCBhbGwgY2FzZXMgd2Ugc2hvdWxkIGhhdmUgYXQgbGVhc3Qgb25lIHJlbW90
ZSBmZW5jZSBkcml2ZXIgaGVyZS4NCg0KV2hlbiBvbmx5IHRoZSBkZXNrdG9wIGNvbXBvc2l0b3Ig
aXMgcnVubmluZywgdGhlcmUncmUgbWFueSBuby13YWl0IGZlbmNlcyBhcmUgZ2VuZXJhdGVkIHdo
aWxlIGVtaXR0aW5nIHVzZXJxIGZlbmNlcy4gUmVwZWF0ZWRseSBhdHRlbXB0aW5nIHRvIGV4dHJh
Y3QgdGhlIHdhaXQgZmVuY2UgYXJyYXkgdGFrZXMgbW9yZSB0aGFuIDEwwrVzICh3aXRoIGEgbWF4
aW11bSBjb3N0IG9mIGFyb3VuZCAzMMK1cykuIEFkZGl0aW9uYWxseSwgemVyby1pbml0aWFsaXpp
bmcgdGhlIHVzZXJxIGZlbmNlIGFsbG9jYXRpb24gY2FuIGhlbHAgcmVkdWNlIG92ZXJoZWFkIGlu
IHRoZSB1c2VycSBmZW5jZSBwdXQgcm91dGluZS4NCg0KVGhpcyBwYXRjaCBjYW4gcmV0dXJuIGEg
dXNlcnEgZmVuY2UgZHJpdmVyIGV2ZW4gd2hlbiBmYWxsaW5nIGJhY2sgZnJvbSBhbiBlbXB0eSBm
ZW5jZV9kcnZfeGEsIGJlbmVmaXRpbmcgb24gcmVkdWNpbmcgdGhlIGxhdGVuY3kgb2YgdXNlcnEg
ZmVuY2UgZHJpdmVyIGV4dHJhY3Rpb24gYW5kIGZyZWUgb3BlcmF0aW9ucyB3aGVuIHRoZXJlIGlz
IG5vIHBlbmRpbmcgd2FpdC1zaWRlIGZlbmNlLg0KDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4N
Cj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNl
cnFfZmVuY2UuYyB8IDYgKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gaW5kZXggMDA4MzMwYTBkODUyLi4y
YTJiZjEzYTUxM2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+IEBAIC0yMjYsNyArMjI2LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfdXNlcnFfZmVuY2VfYWxsb2Moc3RydWN0DQo+IGFtZGdwdV91c2VybW9kZV9xdWV1
ZSAqdXNlcnEsDQo+ID4gICAgIHN0cnVjdCBhbWRncHVfdXNlcnFfZmVuY2UgKnVzZXJxX2ZlbmNl
Ow0KPiA+ICAgICB2b2lkICplbnRyeTsNCj4gPg0KPiA+IC0gICB1c2VycV9mZW5jZSA9IGttYWxs
b2Moc2l6ZW9mKCp1c2VycV9mZW5jZSksIEdGUF9LRVJORUwpOw0KPiA+ICsgICB1c2VycV9mZW5j
ZSA9IGt6YWxsb2Moc2l6ZW9mKCp1c2VycV9mZW5jZSksIEdGUF9LRVJORUwpOw0KPiA+ICAgICBp
ZiAoIXVzZXJxX2ZlbmNlKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+DQo+
ID4gQEAgLTIzNSw2ICsyMzUsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV91c2VycV9mZW5jZV9hbGxv
YyhzdHJ1Y3QNCj4gYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICp1c2VycSwNCj4gPiAgICAgICogdXNl
ZCBhcyBzaXplIHRvIGFsbG9jYXRlIHRoZSBhcnJheS4NCj4gPiAgICAgICovDQo+ID4gICAgIG11
dGV4X2xvY2soJnVzZXJxLT5mZW5jZV9kcnZfbG9jayk7DQo+ID4gKyAgIGlmICh4YV9lbXB0eSgm
dXNlcnEtPmZlbmNlX2Rydl94YSkpDQo+ID4gKyAgICAgICAgICAgZ290byB1bmxvY2s7DQo+ID4g
ICAgIFhBX1NUQVRFKHhhcywgJnVzZXJxLT5mZW5jZV9kcnZfeGEsIDApOw0KPiA+DQo+ID4gICAg
IHJjdV9yZWFkX2xvY2soKTsNCj4gPiBAQCAtMjU2LDcgKzI1OCw3IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3VzZXJxX2ZlbmNlX2FsbG9jKHN0cnVjdA0KPiBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnVz
ZXJxLA0KPiA+ICAgICB4YV9leHRyYWN0KCZ1c2VycS0+ZmVuY2VfZHJ2X3hhLCAodm9pZCAqKil1
c2VycV9mZW5jZS0+ZmVuY2VfZHJ2X2FycmF5LA0KPiA+ICAgICAgICAgICAgICAgIDAsIFVMT05H
X01BWCwgeGFzLnhhX2luZGV4LCBYQV9QUkVTRU5UKTsNCj4gPiAgICAgeGFfZGVzdHJveSgmdXNl
cnEtPmZlbmNlX2Rydl94YSk7DQo+ID4gLQ0KPiA+ICt1bmxvY2s6DQo+ID4gICAgIG11dGV4X3Vu
bG9jaygmdXNlcnEtPmZlbmNlX2Rydl9sb2NrKTsNCj4gPg0KPiA+ICAgICBhbWRncHVfdXNlcnFf
ZmVuY2VfZHJpdmVyX2dldChmZW5jZV9kcnYpOw0KDQo=
