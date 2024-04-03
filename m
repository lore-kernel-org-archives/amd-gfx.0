Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B35C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 07:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6025A112651;
	Wed,  3 Apr 2024 07:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LwSUyCFF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0011C112651
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 07:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOJ8M/uf9c9bsRdwqoECJFj7uURfaFqey5TOSKzCfRk/gqunSlBD6K2xZO3nEgpWzlfPNc0mciWs2SBSUQrcp2gEezTdar/0wcvH+CxzYpMRO84opXvjfoujRWFmJWD6AMQh2DAbhmGJrLKrToDrDXeXt/mFqmcaq+7EGJIYIP10lae+f5eV5rOFZ7umprk5W8dSkfXQt6WJty5sykwfmjqIzuTj/2RCg400QvKh3oGKfIIZK/bJahI0HqsMSnyrySs2A3jxVvkEl/OArOZTCrF+XA398yTQXH2pXkGK2T8zIsb/rXmEcvRcHHqmSAWhDkLxXwzGuy1W+DhleRAT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxkILRGFIYonHbZRg4WWOk1s6cGdEwTG7eq438F/c9Y=;
 b=Wuf1afXB7gh8qT1cXtT6qzNMiETV98pNN/oSdCfN0TE8XOME021N6EXGh7qSpYIQYfL4Xc0XUxEu735XgPxP7RdAHFGmi2DrZB8PypfVyF5cZwgO+9Pl/qX2P78vRm4ilpY4r4ojbA//IHSst516QxpmgESL6N8Br1sb33in4//WmgkT8cjkSBMamateFng5WySt98Eph5TOEXDbN8mmh5IBlV199uUmcA0oVPBNCpP2esTHqYaT/0UFzRWs68+xRsHphPmgYtzUXxBaVeZHw8BBLU/1zcu4yYJghsnjahEwo3Rwq0Tr0mUvH4HzvBDmx3noDUME6jc/YJwn+Ow7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxkILRGFIYonHbZRg4WWOk1s6cGdEwTG7eq438F/c9Y=;
 b=LwSUyCFFViEAGJkqt0k0VLbhuJFFF2nalxcUrOLrKxEN9TV0Gu6nqLRejEZUbcxKe9BowGiIWLw8rvo3yhEK51xfDIrvB1yjn5OAc7t+SzRxjLLJV9L3LcmbrJ1x5Jk6P/v+RvH76g/RfAWnOgOTVuyjKKaq1BBFRGjO6sIXvrc=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 07:31:04 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:31:04 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add post reset IP callback
Thread-Topic: [PATCH] drm/amdgpu: add post reset IP callback
Thread-Index: AQHagMoRh8yAeQygPUK7fOTrq+2pC7FVBIIAgADccUCAAEvXAIAAAJow
Date: Wed, 3 Apr 2024 07:31:04 +0000
Message-ID: <MW6PR12MB8898C23F7466A6B0F12BFD18FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240328044014.3278891-1-Lang.Yu@amd.com>
 <d3581afc-4bc4-4e42-a4f5-5b4be5f10ed3@gmail.com>
 <MW6PR12MB88988E7D5DB5D5E9C4ED1A45FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
 <c037df2f-bca9-ffb6-a569-603f4d8edb29@amd.com>
In-Reply-To: <c037df2f-bca9-ffb6-a569-603f4d8edb29@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8991d3f-39bd-4022-ad2a-78767c5e6396;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-03T07:21:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|SN7PR12MB6792:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFFZ1GF3nwAWJExbAKpSyG6fJ0HrDUmuICq0XOuX/MwpvmpEMs57nld3DTC+/i+tN4F8kgh4TqsVdlk2gr7d6ujPaT19H8dxEbxPOAJFNL4lTNS4VZAKAo8u+A5vmfdXUthc1HVjyEdUkMKC4Igq/aIM0IGzJNCzqFPgOs7P6Jvxs7LotY+5img3jmTLwufjCRgz2UWyC161jtpSyaMIH6q5shXMMT0Lc/87lcBGYzTXSk76Zu+K7swSbntEcU/Jx1TUf66rwYP2gLFxHYkH8cMR3kteupbrQobH4kagGHZBlhyttD8jw+THJefOZt9fQ5VrszmdUDjBaEhfgBmS3qTV8juJ+mk+49FJFb+aqth+uwxwZf7pJaG+ddumVsjwVVq56CgIhg57p582KNiU/NX/8Vka7moXNcvEmuXuD+FRbv8CT4/yUJRSGqPERBHMwC9uhIoarD7c2pEbFahcE3wEmKz1rd5G7yCS4gJgVKNFHesOp/kJ4eovGbq+09rJIC20xHfIvYietnFWCaYMBF4Y6HLl5nV/xHZR8h9FiLP+R/vYkGYZO9uGXn+oiJ1hwbIzIIVa2gwfYtnaowRrxfdC0+C5R3IwH6Jl4gEEa/91uLe7InfBaW2lI7oLvmmzS6SflzrBhMyA7OzPkoLKlkLRJ/FmcDSwLGpDKyVP2Z0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnZ6dEdKVHBVNkd4MGpXRkdhb0tWQlNyYk5CSGZqNFdwVFRxR3hnaDJyVkpW?=
 =?utf-8?B?OElaekdEaFA5WXkxWFBwcUpNMGJTRDJocjV1RWxOekJFcjZtSHVmNzlLZW84?=
 =?utf-8?B?UitjNGZmenF6Qk8wTjBuYWxGV01GQStIbU1DQ0RmNGk1U25QS0FOTFdBdXUw?=
 =?utf-8?B?eU8zU2xFcUpZdUk3YUJzQTlSNFlnbGRXNHZUMmI2VXF1UCs3bDN1eXo2QUMy?=
 =?utf-8?B?SVJLSDhWenNnZWJ1b2JKTHpmQXhzMlNodDdTZXFFcVBoT0ticW0zTmYyOUN5?=
 =?utf-8?B?cTJwVWEybGRzY0tpQmFVR0xnQjNsRW9JeFJHUWhxL1dreU9pZkFFY1BkVjlP?=
 =?utf-8?B?c0pnTVdua0RPanZNcU1ydEdtS1VpTEVKWWE1ME5CYUhmUVZVdUxnQVFqR21r?=
 =?utf-8?B?R096UENJd2c5MXBKeHpMM21ZNnkySHp4dEFwMzJaMk1nV01WQWlOMEJUL3p3?=
 =?utf-8?B?N0QwTkE4dWs5UnB6UHdSbEhWaGl3c2VuTFpBQ1RUZHhpY3dscVdoaWRwL1hp?=
 =?utf-8?B?dldTaUlkZkh3Y2dCbEkybDA1QzBjNElScS8xS3lOeEhER3gzNlJCY3cvT0ho?=
 =?utf-8?B?RTB0LzFpQmtzam1aZXpUQk1PbmZKTzNZd1ozdmxnVjVscCtqVW05b2p0S2ZK?=
 =?utf-8?B?ckp6U2Z4Y3Qvc0p3TVJHN01CZTB0ZVdVQTA5UUZTU2xRendzMmZDWTZGdFI3?=
 =?utf-8?B?YjU5c2psNWRJWWVSY0t3VlNhdytNRGpqTkZjdTJYQTJYY3BXdjdWN1VCaVJs?=
 =?utf-8?B?a3Y0aDZ4WDVRbmNMbzkwWHBkOGYvZWMzZkpSMzNZamVKSWJLQnhLSzg4bjFR?=
 =?utf-8?B?SXNkN3Brd2x6OUhMT1VJcU9XV3ZzaHhya09zaTZlNHZER250Ymp2VnVGYk9z?=
 =?utf-8?B?dyt0N295NnU4T2hKYlpXdC9zVUpwUzVCWnlYSm5YK1BweWRhZWp1WUNKQVpl?=
 =?utf-8?B?MWMzd3hlT2NzNEhUc2VlWDlvbXNBSW1PSGRDTUJONEdRcWFmazZVTDBGTGxF?=
 =?utf-8?B?V3NDdlViZW9pTTdhVkhuUTk1ZWQ3ZmRCR1UrRjU5Uit1NXMrSkVvUmVrZFRJ?=
 =?utf-8?B?NHFHQmtWYlBWNjE1VU5sR1FBQmYyQ3kxaGhwYVRRMUk4bXlqeXM4QXh5ZnFT?=
 =?utf-8?B?a2FyMDFxTVcrOWNlMENMUEdJQ0kvdW42Mllhb3NrOWI4MWV4Vlc4TWpBTmtE?=
 =?utf-8?B?U3FNUTJQOXpUODkydkJDY0VadERNcmZWVUgzUW5zeXhXVXFEcTJudFM5SWRB?=
 =?utf-8?B?K0xLZE1pNkRKZ1lYNy84QTlQMTJ2REFCOWJ4a0VET0pLai95bnB5UHY3ZDZC?=
 =?utf-8?B?K3RWRm9HMXVsVjI0aTI5UjF6cGFWR2Rxc01NVnFGdUFLMXZJSSs1STQzYnZN?=
 =?utf-8?B?RjFFRUdkUERNVjl0eWl6dEZqbTF5cDRLQlJudGQ5bHNBZ0J4a1V1VlBZV3lL?=
 =?utf-8?B?Z0FoVkk0S2RBa1RGODZ3ZmR5WlArWlNQZzlRZnJlMmNxSnUwRE15cnFQWTFp?=
 =?utf-8?B?TjhTWERSbU94V1NPUTNjYjhwSWhkWTlQb0VaTGNaR3dvNG9tbWlxYUFnNUtq?=
 =?utf-8?B?MVIvWVhPWGFJdmcrdXErZmZsWGFuc2NuWU16R3d6cFJsNFJYelZGZktvUUZR?=
 =?utf-8?B?ZlBDTDlQSDJ0K1VOcExUZWZOQkg5czBqM3JlSjFyZnFnZldHUnhKamFkVjN3?=
 =?utf-8?B?YUNPMktpSXg1U0tiSUpMMkNsL1lmeWZnbE4rRE1KQW8xV2ViajVJWXVtMUJx?=
 =?utf-8?B?bXF0U3oxVjI1cnFZTnVSNkErNWJwcGpVR3V6SnZDWXIybjIxbm5MTHNOeW1C?=
 =?utf-8?B?eWlNNEVoN3ZrRzJrVlBNWlhkOFY4RnNET2FNYlREYkFZemNqdVdCeVJDUnR1?=
 =?utf-8?B?ZzVDQ0ZuT0F2eU1JUzVJT25aK24xRk9keStPUWVSRTB3bVBqNER0YnBVOEVM?=
 =?utf-8?B?U00zR3RHaFdMNlpIbmVTeXlJREFHa3F1cFhtT2kxcjlzRms0SEpxMG5MNHNk?=
 =?utf-8?B?S092UGtIZ2VlMFlrNEVhL0NXMGpQdkJjbHlxK2dPNFJ2NWJSU1I0aHhzTWR1?=
 =?utf-8?B?NzN5NGlrNlozZnhqRUN6TEZSZzVML1doc1VKSFRmVFFibWlJcVFQZXVFZWkx?=
 =?utf-8?Q?J3UI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620c188a-4539-46f8-79a9-08dc53b0054e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 07:31:04.7813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ul4omMjpjXwBN8PaQqt9V55HRBTNRY+p0387/aFHH2m4aNWUtJu8TftR+QxWEOTx+pNyffYbevCGHke3zaC51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPkZyb206IFNoYXJtYSwgU2hhc2hhbmsgPFNoYXNoYW5rLlNoYXJtYUBhbWQuY29t
Pg0KPlNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMywgMjAyNCAzOjE5IFBNDQo+VG86IFl1LCBMYW5n
IDxMYW5nLll1QGFtZC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnDQo+PGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5DYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJp
c3RpYW4NCj48Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWRncHU6IGFkZCBwb3N0IHJlc2V0IElQIGNhbGxiYWNrDQo+DQo+SGV5IExhbmcsDQo+
DQo+T24gMDMvMDQvMjAyNCAwODo1MSwgWXUsIExhbmcgd3JvdGU6DQo+PiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWls
LmNvbT4NCj4+PiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyLCAyMDI0IDk6MzggUE0NCj4+PiBUbzog
WXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+Pj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IEtvZW5pZywgQ2hyaXN0aWFuDQo+Pj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFNoYXJt
YSwgU2hhc2hhbmsNCj4+PiA8U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+DQo+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIHBvc3QgcmVzZXQgSVAgY2FsbGJhY2sNCj4+Pg0K
Pj4+IEFtIDI4LjAzLjI0IHVtIDA1OjQwIHNjaHJpZWIgTGFuZyBZdToNCj4+Pj4gVGhlcmUgYXJl
IHVzZSBjYXNlcyB3aGljaCBuZWVkIGZ1bGwgR1BVIGZ1bmN0aW9uYWxpdHkgKGUuZy4sIFZNDQo+
Pj4+IHVwZGF0ZSwgVExCIGluYXZpbGRhdGUpIHdoZW4gZG9pbmcgYSBHUFUgcmVzZXQuDQo+Pj4+
DQo+Pj4+IEVzcGVjaWFsbHksIHRoZSBtZXMvdW1zY2ggc2VsZiB0ZXN0cyB3aGljaCBoZWxwIHZh
bGlkYXRlIHRoZSBodw0KPj4+PiBzdGF0ZSBhZnRlciBodyBpbml0IGxpa2UgcmluZy9pYiB0ZXN0
cy4NCj4+PiBJIG5vdGVkIHRoYXQgYmVmb3JlIGJ1dCBqdXN0IHRvIHJlcGVhdCBpdCBvbmNlIG1v
cmU6IFdlIGNhbid0IGRvIGFueQ0KPj4+IE1FUyBvciBVTVNDSCB2YWxpZGF0aW9uIHdoaWxlIGRv
aW5nIGEgR1BVIHJlc2V0IQ0KPj4gWWVzLCB3ZSBjYW4ganVzdCBlYXNpbHkgZGlzYWJsZSBpdCBp
ZiBpdCBkb2Vzbid0IHdvcmsgd2VsbC4NCj4+IEJ1dCBpdCBkb2Vzbid0IHRha2UgdG9vIG11Y2gg
ZWZmb3J0IHRvIG1ha2UgaXQgd29yay4NCj4+IEl0IGNhbiBleHBvc2UgaXNzdWVzIGFzIHNvb24g
YXMgcG9zc2libGUgYW5kIGlzIHVzZWZ1bCBmb3IgZGVidWdnaW5nDQo+cHVycG9zZS4NCj5JTU8s
IGl0cyBub3QgdGhhdCB1c2VmdWwgZm9yIGRlYnVnZ2luZyBhcyB3ZWxsLiBJbiBjYXNlIG9mIGEg
cHJvYmxlbSwgSXQgd2lsbCBqdXN0DQo+dGltZW91dCB3YWl0aW5nIGZvciBNRVMgcGFja2V0IHdy
aXRlIGFuZCB3ZSB3aWxsIHN0aWxsIGhhdmUgdG8gZmluZCBvdXQgdGhlDQo+YWN0dWFsIHByb2Js
ZW0gd2hpY2ggY2F1c2VkIE1FUyB0byBnbyBpbnRvIGJhZCBzdGF0ZSBpbiB0aGUgbGFzdCBHUFUg
cmVzZXQuDQo+Pg0KPj4+IFRoZSByaW5nIGFuZCBJQiB0ZXN0cyB1c2Ugc29tZSBwcmUtYWxsb2Nh
dGVkIG1lbW9yeSB3ZSBwdXQgYXNpZGUgZm9yDQo+Pj4gdGhlIHRhc2sgZHVyaW5nIGRyaXZlciBs
b2FkIGFuZCBzbyBjYW4gZXhlY3V0ZSBkdXJpbmcgR1BVIHJlc2V0IGFzIHdlbGwuDQo+PiBJZiB1
c2VyIHNwYWNlIGNhbiBjcmVhdGUgYSBWTSBhbmQgYWxsb2NhdGUgbWVtb3J5IGR1cmluZyBHUFUg
cmVzZXQsIGl0DQo+PiBtYWtlcyBubyBzZW5zZSB0byBwcmV2ZW50IGtlcm5lbCBzcGFjZSBmcm9t
IGRvaW5nIHRoYXQuDQo+DQo+SSB0aGluayB0aGUgb2JqZWN0aW9uIGhlcmUgaXMgbW9zdGx5IGFi
b3V0IHdoeSB0byBkbyBpdCBhdCBhbGwsIHdoZW4gaXQgaXMgbm90DQo+aGVscGZ1bC4gSXQgd291
bGQgYmUganVzdCBhIG1haW50ZW5hbmNlIG92ZXJoZWFkLg0KDQpJZiB5b3UgdGhpbmsgaXQgaXMg
bm90IGhlbHBmdWwsICB3aHkgZG9pbmcgcmluZy9pYiB0ZXN0cz8NCkkgZG9uJ3QgdGhpbmsgc3Vj
aCBzYW5pdHkgdGVzdCBpcyBub3QgaGVscGZ1bC4NCg0KSSBvbmx5IHRhbGsgVU1TQ0ggdGVzdChk
aWZmZXJlbnQgd2l0aCBNRVMgdGVzdCkgaGVyZSwNCkkgZG9uJ3QgdGhpbmsgaXQgaGFzIGEgbWFp
bnRlbmFuY2Ugb3ZlcmhlYWQuDQoNClJlZ2FyZHMsDQpMYW5nDQoNCj4tIFNoYXNoYW5rDQo+DQo+
Pj4gQnV0IGZvciB0aGUgTUVTL1VNU0NIIHdlIG5lZWQgYSBmdWxsIGJsb3duIGVudmlyb25tZW50
IHdpdGggVk0gYW5kDQo+Pj4gc3VibWlzc2lvbiBpbmZyYXN0cnVjdHVyZSBhbmQgc2V0dGluZyB0
aGF0IHVwIGlzbid0IHBvc3NpYmxlIGhlcmUuDQo+PiBBdCBsZWFzdCBmb3IgVU1TQ0ggdGVzdCwg
aXQgb25seSB1c2VzIFZNIG1hcHBpbmcgZnVuY3Rpb25hbGl0eSAoaWYgd2UNCj4+IGNhbiBjcmVh
dGUgYSBWTSB3aXRoIGNwdSB1cGRhdGUgbW9kZSwgdGhhdCdzIGVub3VnaCksIGl0IGRvZXNuJ3Qg
dXNlDQo+PiBvdGhlciBzdWJtaXNzaW9uIGZ1bmN0aW9uYWxpdHkuDQo+PiBJdCBpcyBhY3R1YWxs
eSBhIGNvbXB1dGUgY29udGV4dC4NCj4+DQo+Pg0KPj4gUmVnYXJkcywNCj4+IExhbmcNCj4+DQo+
Pj4gQWRkaW5nIFNoYXNoYW5rIGFzIHdlbGwsIGJ1dCBJIHRoaW5rIHdlIHNob3VsZCBwcm9iYWJs
eSBqdXN0DQo+Pj4gY29tcGxldGVseSByZW1vdmUgdGhvc2UgZnJvbSB0aGUga2VybmVsLg0KPj4+
DQo+Pj4gUmVnYXJkcywNCj4+PiBDaHJpc3RpYW4uDQo+Pj4NCj4+Pj4gQWRkIGEgcG9zdCByZXNl
dCBJUCBjYWxsYmFjayB0byBoYW5kbGUgc3VjaCB1c2UgY2FzZXMgd2hpY2ggd2lsbCBiZQ0KPj4+
PiBleGVjdXRlZCBhZnRlciBHUFUgcmVzZXQgc3VjY2VlZHMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IExhbmcgWXUgPExhbmcuWXVAYW1kLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDI0DQo+Pj4gKysrKysrKysr
KysrKysrKysrKysrKw0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3No
YXJlZC5oICAgfCAgMyArKysNCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25z
KCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMNCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMNCj4+Pj4gaW5kZXggMTJkYzcxYTZiNWRiLi5mZWVhYjkzOTdhYWIgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4g
QEAgLTU1NTYsNiArNTU1NiwyNyBAQCBzdGF0aWMgaW50DQo+YW1kZ3B1X2RldmljZV9oZWFsdGhf
Y2hlY2soc3RydWN0DQo+Pj4gbGlzdF9oZWFkICpkZXZpY2VfbGlzdF9oYW5kbGUpDQo+Pj4+ICAg
ICAgIHJldHVybiByZXQ7DQo+Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBpbnQgYW1kZ3B1
X2RldmljZV9pcF9wb3N0X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSB7DQo+Pj4+
ICsgICAgdWludDMyX3QgaTsNCj4+Pj4gKyAgICBpbnQgcjsNCj4+Pj4gKw0KPj4+PiArICAgIGZv
ciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxvY2tzOyBpKyspIHsNCj4+Pj4gKyAgICAgICAg
ICAgIGlmICghYWRldi0+aXBfYmxvY2tzW2ldLnN0YXR1cy52YWxpZCB8fA0KPj4+PiArICAgICAg
ICAgICAgICAgICFhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MtPnBvc3RfcmVzZXQp
DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4+PiArDQo+Pj4+ICsgICAg
ICAgICAgICByID0gYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPmZ1bmNzLT5wb3N0X3Jlc2V0
KGFkZXYpOw0KPj4+PiArICAgICAgICAgICAgaWYgKHIpIHsNCj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgRFJNX0VSUk9SKCJwb3N0IHJlc2V0IG9mIElQIGJsb2NrIDwlcz4NCj4+PiBmYWlsZWQg
JWRcbiIsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5pcF9ibG9j
a3NbaV0udmVyc2lvbi0+ZnVuY3MtPm5hbWUsIHIpOw0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcjsNCj4+Pj4gKyAgICAgICAgICAgIH0NCj4+Pj4gKyAgICB9DQo+Pj4+ICsNCj4+
Pj4gKyAgICByZXR1cm4gcjsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiAgICAvKioNCj4+Pj4gICAg
ICogYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlciAtIHJlc2V0IHRoZSBhc2ljIGFuZCByZWNvdmVy
IHNjaGVkdWxlcg0KPj4+PiAgICAgKg0KPj4+PiBAQCAtNTgwNSw2ICs1ODI2LDkgQEAgaW50IGFt
ZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0DQo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwN
Cj4+Pj4gICAgICAgICAgICAgICBhbWRncHVfcHV0X3hnbWlfaGl2ZShoaXZlKTsNCj4+Pj4gICAg
ICAgfQ0KPj4+Pg0KPj4+PiArICAgIGlmICghciAmJiAham9iX3NpZ25hbGVkKQ0KPj4+PiArICAg
ICAgICAgICAgciA9IGFtZGdwdV9kZXZpY2VfaXBfcG9zdF9yZXNldChhZGV2KTsNCj4+Pj4gKw0K
Pj4+PiAgICAgICBpZiAocikNCj4+Pj4gICAgICAgICAgICAgICBkZXZfaW5mbyhhZGV2LT5kZXYs
ICJHUFUgcmVzZXQgZW5kIHdpdGggcmV0ID0gJWRcbiIsDQo+Pj4+IHIpOw0KPj4+Pg0KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaA0KPj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgNCj4+Pj4gaW5kZXgg
YjBhNjI1NmU4OWY0Li4zM2NlMzBhOGUzYWIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgNCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaA0KPj4+PiBAQCAtMjg3LDYgKzI4Nyw3IEBAIGVudW0g
YW1kX2RwbV9mb3JjZWRfbGV2ZWw7DQo+Pj4+ICAgICAqIEBwcmVfc29mdF9yZXNldDogcHJlIHNv
ZnQgcmVzZXQgdGhlIElQIGJsb2NrDQo+Pj4+ICAgICAqIEBzb2Z0X3Jlc2V0OiBzb2Z0IHJlc2V0
IHRoZSBJUCBibG9jaw0KPj4+PiAgICAgKiBAcG9zdF9zb2Z0X3Jlc2V0OiBwb3N0IHNvZnQgcmVz
ZXQgdGhlIElQIGJsb2NrDQo+Pj4+ICsgKiBAcG9zdF9yZXNldDogaGFuZGxlcyBJUCBzcGVjaWZp
YyBwb3N0IHJlc2V0IHN0dWZmKGUuZy4sIHNlbGYNCj4+Pj4gKyB0ZXN0KQ0KPj4+PiAgICAgKiBA
c2V0X2Nsb2NrZ2F0aW5nX3N0YXRlOiBlbmFibGUvZGlzYWJsZSBjZyBmb3IgdGhlIElQIGJsb2Nr
DQo+Pj4+ICAgICAqIEBzZXRfcG93ZXJnYXRpbmdfc3RhdGU6IGVuYWJsZS9kaXNhYmxlIHBnIGZv
ciB0aGUgSVAgYmxvY2sNCj4+Pj4gICAgICogQGdldF9jbG9ja2dhdGluZ19zdGF0ZTogZ2V0IGN1
cnJlbnQgY2xvY2tnYXRpbmcgc3RhdHVzIEBADQo+Pj4+IC0zMTYsMTENCj4+Pj4gKzMxNywxMyBA
QCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIHsNCj4+Pj4gICAgICAgaW50ICgqcHJlX3NvZnRfcmVzZXQp
KHZvaWQgKmhhbmRsZSk7DQo+Pj4+ICAgICAgIGludCAoKnNvZnRfcmVzZXQpKHZvaWQgKmhhbmRs
ZSk7DQo+Pj4+ICAgICAgIGludCAoKnBvc3Rfc29mdF9yZXNldCkodm9pZCAqaGFuZGxlKTsNCj4+
Pj4gKyAgICBpbnQgKCpwb3N0X3Jlc2V0KSh2b2lkICpoYW5kbGUpOw0KPj4+PiAgICAgICBpbnQg
KCpzZXRfY2xvY2tnYXRpbmdfc3RhdGUpKHZvaWQgKmhhbmRsZSwNCj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGFtZF9jbG9ja2dhdGluZ19zdGF0ZSBzdGF0ZSk7
DQo+Pj4+ICAgICAgIGludCAoKnNldF9wb3dlcmdhdGluZ19zdGF0ZSkodm9pZCAqaGFuZGxlLA0K
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gYW1kX3Bvd2VyZ2F0
aW5nX3N0YXRlIHN0YXRlKTsNCj4+Pj4gICAgICAgdm9pZCAoKmdldF9jbG9ja2dhdGluZ19zdGF0
ZSkodm9pZCAqaGFuZGxlLCB1NjQgKmZsYWdzKTsNCj4+Pj4gKw0KPj4+PiAgICB9Ow0KPj4+Pg0K
Pj4+Pg0K
