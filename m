Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B81CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF6D10ECF9;
	Thu, 28 May 2026 07:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UfyDgUBP";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD34710ECF8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 07:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAYDa5HdIAIskfluDdKK9B6npB2wtKCEOSIBGcNl7CxEreSZ0mmLCnzWXd4BYbYlT+UGGq8W/h6fErogzfz7McMyQEEb/y/4wp3H3ScM8+GSfWY8k3qjnG9gLpj+RuFHX0zprVpAeAPnyg0h7h0VWLovUhwf2QFnFbksewRI27u0blIhdidvAL8JZwxFBYuSmHLYEuubWfotCYcTchwpM71e4pBdCE8eYFdqWkyjnCYKOum2ZzbDCNEG28Uv9G+ZPFJ5nCAwOxRaKR/6Z00xS5eolB7SZIlqtZBd20ChU+RSwr3OLyugMNgKnfgbbLmj2dFMNLNyK0xXuQaF5SOEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShkY8JGOGEn2sXkaSXEwGhNS7bZvhCpsUggVJNpQnUs=;
 b=vVZp9oCgr3n5D2GF6XNVztwEQXMaiYy4bJfR+fn7BX2DXW48AQgvMBoFYb+0sgRjIOCaPIm/SXbkWayCKe/ZfepTDJ+b1dSH8N+J6+hmoXpPDv+GWswFSE8PXXdLJGBMtK5jmLFZrutYJSl61CrUA/pCRpQT52lekuA47sGGNMQpBUCHqDW/sDfqfo0b6vF0XlpGIJJ30ppqo44ZM+nSswewWqUvNRsxoWjTcy2kyMXJ/piSGUb5CIoTWHdvshwAes5uyuWrQ8bQNRrTfVVNxaravjQpvVzaLNAnLa3bXEw3K37k7KQsV9Op/voIVEL6P+kQ/74M10Ys2TpIW3/eoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShkY8JGOGEn2sXkaSXEwGhNS7bZvhCpsUggVJNpQnUs=;
 b=UfyDgUBPcR3V3xAdZQu6LheuhdL5fkPNLYRFeB36SDMl0PUUxWUmKw/AE9/tBj8YkjXjIr7wc7/pGhL5f20uQ7p/Np2LK9j91cEAUxKmmvchDykiULYQblDR5ImWruv7GDOH2RQspbe3E58TxKvfyu1le5hIx+/N7lcao++wuF4=
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 07:22:06 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:22:05 +0000
From: "Huang, Honglei1" <Honglei1.Huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Liu, Jenny
 (Jing)" <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move notifier_seq read back inside retry loop
Thread-Topic: [PATCH] drm/amdgpu: move notifier_seq read back inside retry loop
Thread-Index: AQHc7mtRbmkQY3aQ/EO+HGLgh+NgULYjAJ+AgAADzDA=
Date: Thu, 28 May 2026 07:22:05 +0000
Message-ID: <IA1PR12MB6435193DB8FBEFB4F4CEE093D9092@IA1PR12MB6435.namprd12.prod.outlook.com>
References: <20260528062902.362031-1-honghuan@amd.com>
 <1e9480eb-24fa-4d97-9e4e-7120bf668f20@amd.com>
In-Reply-To: <1e9480eb-24fa-4d97-9e4e-7120bf668f20@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-28T07:07:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6435:EE_|IA0PR12MB8325:EE_
x-ms-office365-filtering-correlation-id: 59879baa-2982-4805-c5e5-08debc89d244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|4143699003|56012099006|6133799003|11063799006;
x-microsoft-antispam-message-info: Z/qFmpC66Bw+l8746TQbvWS7N0ni2ZAjCEO8Hdm3FRHuYdLSI/5krMNyKJXso62eFH0ry8HW2pRzqznn2VqRIYmGata6xfEDPAkZGT3fImcxOirMigygRnRu+0eTHCERtTAzWxpX9xQG870GsO36xgp4cjZSkbIrTBCmtIbbxIP9WAAbyf4lNf/pWBraUDpEs86EeFNnzK9u4N0sHe/AAlmlHMvxxgFdZ45R9jS+iXjEZ6VBUM+Hue4vVVA6MI+nho2Y3oeaAyOdJ2bjzCkDD5QvTnhtCzJR6Jwtxa1wYJrp8PElYSi96Elig66JUbOaOZaVf10bR090Ew191kS73TwmcBLAOFCf0Ia2eyP59MPXpErFir/5mDqy3WOMNorpJOSXeUJ7qpCP6u9z40eZbFvLm6jVl+POUq6sMN5yEF9tBPB5HA5WQtVqoMy/6mZVuzUX2XJeSx74Nh5r+qDIjuwIRZudadGA+G73iKXQCuV7b7GiZ6RtDN0cDUjQ6gpGU8RwbmRPOn/+jExkwlVKLgBAs7CwGsDutIAYvdf1EDxQd+2+vDPyefujubClc2MejQjAReG5IEx40PdFSmzGyCqNbqRPcoD34+LTVyfJ/R8bFZNLlFoICXJ5dkrcA1BuWrzrsjzf5UzGhVOwWUgCFfWnxt8Z1r8JpEVOE29ZljBuaGW+4lUFQEu4nsZOIjeaHY028ef1S5f4rcJwgdKkEppz4QyDVSj7hm62G+FZ7ywPqjLWEUdmf2c4A93mSgHP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDUrU2p4VThpYVU4NmlsdG1RcmZDVkFtZHdMa3daSkpFWTdRaHl5ckJONDha?=
 =?utf-8?B?SXdINVZCVnF5RUlncExyK0pYQll0RHFKZVVteWZtM05lRG5wODhjWHFVeUNP?=
 =?utf-8?B?cFkvVTBKV0FFbE15QlRZd1VtcUdhM2VFQlJLaDdZcU1LbHQ3Yms2L3k2NHZq?=
 =?utf-8?B?NVZHQ29Xa3hDSHdiTUIzZ1c3SnVWM1o5Z096enRpekcycmxPK0ZuOHpabXpy?=
 =?utf-8?B?dFRXd1VlS2xTOXFYWjNhUnRCbk1UTlBqcjJKeTJQSXlWd3kwQThKV1c0R0Iv?=
 =?utf-8?B?ZTVTUzZSREFUS29yZURJK1FQanN0aFIzYUJ1dkQ2eVVWN3hkVTdxTUhXWnJt?=
 =?utf-8?B?azZFRGdmYUQ5dVFEWGVqMHZ4OWNyR2g5MHdZSFE5KzJpa0tlMjVTV24yeStr?=
 =?utf-8?B?L2xBbUpMSGxaZitaVVlpODl3andtZGNaakRtQ29XTm9JbUZicDgvTFVxa2N6?=
 =?utf-8?B?Y2lKYkRhdFBOMGFtYWREUDFXQlBZVVBac0RRTEdQRW5sZnlWUlgvbzgzUjhh?=
 =?utf-8?B?cWM5K0Q1NzhqZitrQzRYV01FdnpXZjBDTE5va1lJVE1lSTFVSXNRZUNKMWs3?=
 =?utf-8?B?Nkp3MXBZUDZURjhrbTNiY1hyYllnbGVMOVZSZEs0WDZTalNyMFpmWGpZZ1JN?=
 =?utf-8?B?ZGhNMG1hQzJpVjY5WHoxUFBuWXlQcENzTGsyVVlnL1RnT0NoOUlac0dBeC81?=
 =?utf-8?B?Vjk5a1l4QzVzeTVEMlR3Ny9zTFQ1Zy8vWUZsM25ZbTU5QVdFU204alBuNjdK?=
 =?utf-8?B?KzVqei9GZFRKeXNrTTlEKzZOUEZkV2w5MGNteUF5Rzd0aGg4Mm5sa0tnaHJQ?=
 =?utf-8?B?anVZQlJrOWVBODViMGtnL3kza0NzWE5aZWtFZy94SWdUd3hleHVWZkxoKzZM?=
 =?utf-8?B?MlRrajdlUm1LbUdGby96cUZtNTNoNnlSTk5qd0p1THd6RW5DWjByOGlSTHN2?=
 =?utf-8?B?cWJlNGhXQ1FDS3BzbjNlOEtqS0RXd0k1RFRCRVRMZlg4bG1PQWUwOGE0Z3B2?=
 =?utf-8?B?Tm93eDVsQTVNcVpYM1ZJVFNMYXpSNGxqaHJQdXEyaDEyYnIwK0NHWDJLSklw?=
 =?utf-8?B?UjRleStjN2tQYXFvL0dFb2dpUFgzbHNiNkNXWC9mUmFFWGQvTDllL1d0dXpw?=
 =?utf-8?B?MkZzN0RnUnR5WUM1aXRDaVBRWVFxTkpkdklnd2c0M0pJN0RjOGZiUGxIbUow?=
 =?utf-8?B?RU5sSEhIOVBsRGRRenlkRkpqalB0cnB6M0FFUUFjMFZ3bE83ZG1iUWpuNjJX?=
 =?utf-8?B?dUhaQmJDZWIwckVBR2Mvcy85cWhheWluWW5zWEphWDE5bjkrSUl0RGdBTHA4?=
 =?utf-8?B?Szk3ZWRSblRpMXJjcFBxazgyV2p5VzNjZjBrdTBPYWNqZFBNN1Z1bnZ4ZWhQ?=
 =?utf-8?B?QjJTU3VmYkRYTGhhQWM0Z1FpVGpLa2lTWTlmUjk2TEVwUjl5MXoyYXlwc09B?=
 =?utf-8?B?WDJ2L3JiZ3EwSFZHTEgrMW11L3FVY25hVVMyVk5kQ09PWDhwUzVpRmgyRlYr?=
 =?utf-8?B?aCtMQ3NSdUlZdTVrTzZqQlRNb1B3Ymt5RDRwVVQzZ1pvR0pySHY4dS95OEkv?=
 =?utf-8?B?VW9tZjl4RjR1dVRsdVJERVVySUNNOTYzZS9pdzB4Zm5SWFpSQjhDRS9OR2Zj?=
 =?utf-8?B?RkxpK1BpU0FHV2tqT2V6dnJ5ZERWTUZnOWJDS0szSHJ0Zmh5YU5aRThia2JR?=
 =?utf-8?B?QnNrQi9XV3ZQb3VNS2RPemNyZE1tdXA0UGd4SjhsTXJxMkRkV0QxbVA3MnFT?=
 =?utf-8?B?TWFaOU9OS0tQY3Zob3dCMnF6M3dubk5ycVVBZkMxN1R5QVZwL255WWdMczNr?=
 =?utf-8?B?SnlUSm5tdlhPcHNGeEtEYkIxZlJCVlB1aGMrVTlTbU9WTEZlQ3JWeDZXRkls?=
 =?utf-8?B?L2Rjamw5aHBmTnQ3Tzloc2hUc25XejZuRitsSVpSQlR2UmNJNWVHQWNJMjJI?=
 =?utf-8?B?Wkp4dmR2K09LSWp3VURUQWdlOGI3aWo5c0NOY3JhMHhva0VENnEwZDNsb28z?=
 =?utf-8?B?UnczakdMNGRmUEQ3RFhBYSt1V1hQaXR6Qkdqb2FTZlN1blF6Y3NlSXgvQi9R?=
 =?utf-8?B?Yld2K1pDcDJHK290STVSdXcvdmFqSndENGMzeFRRVEVuaEZFRGxjWEUvWGlz?=
 =?utf-8?B?Uzl3bTF2UUJ6ZEdjSnlyL1Q1MG9vRXNQU0VVQk54UUd0NlJnUFYzLy9tZEZx?=
 =?utf-8?B?Kzc3MlhsbU1wcGpDMmkvMWZIc2RONzhScnNxeDhwN2NLVjFUMERBOUhGa0NU?=
 =?utf-8?B?Si90aUxjc2hXWEFJTWwwSHU1V0c5bjgySXUyTnhydEZuUmhIcTRKVWlndDdF?=
 =?utf-8?Q?Gh+xRu+INXxsrIf+kF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59879baa-2982-4805-c5e5-08debc89d244
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 07:22:05.7211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQV9uBxbG8dM/imFGstxXuLsaGpPjegKnu8j4lzna09mpexLvWOsGrCT7scDva6zjPx8f2JUaGoSfkjHT3e1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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

QU1EIEdlbmVyYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgTWF5
IDI4LCAyMDI2IDI6NTQgUE0NClRvOiBIdWFuZywgSG9uZ2xlaTEgPEhvbmdsZWkxLkh1YW5nQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0Bh
bWQuY29tPjsgUHJvc3lhaywgVml0YWx5IDxWaXRhbHkuUHJvc3lha0BhbWQuY29tPjsgTGl1LCBK
ZW5ueSAoSmluZykgPEplbm55LUppbmcuTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBtb3ZlIG5vdGlmaWVyX3NlcSByZWFkIGJhY2sgaW5zaWRlIHJldHJ5IGxv
b3ANCg0KT24gNS8yOC8yNiAwODoyOSwgSG9uZ2xlaSBIdWFuZyB3cm90ZToNCj4gQWxpZ24gd2l0
aCBkcm1fZ3B1c3ZtX2dldF9wYWdlcygpIChkcm1fZ3B1c3ZtLmMgbGluZSAxNDE2LCAxNDQwKSB3
aGljaA0KPiByZWZyZXNoZXMgbm90aWZpZXJfc2VxIHZpYSBtbXVfaW50ZXJ2YWxfcmVhZF9iZWdp
bigpIG9uIGVhY2ggcmV0cnkNCj4gaXRlcmF0aW9uLiBXaXRob3V0IHRoaXMsIGEgc3RhbGUgc2Vx
dWVuY2UgbnVtYmVyIGNhdXNlcw0KPiBobW1fcmFuZ2VfZmF1bHQoKSB0byBwZXJwZXR1YWxseSBy
ZXR1cm4gLUVCVVNZLCBsZWFkaW5nIHRvIGFuIGluZmluaXRlDQo+IHJldHJ5IGxvb3AgYXQgdGhl
IGNhbGxlciBsZXZlbC4NCg0KQWJzb2x1dGVseSBjbGVhciBOQUsuDQoNClRoaXMgaXMgZXhhY3Rs
eSB0aGUgYnVnIDE0NGJhOTgxNzgzZiAoImRybS9hbWRncHU6IGZpeCBhbWRncHVfaG1tX3Jhbmdl
X2dldF9wYWdlcyIpIHRyaWVzIHRvIGZpeC4NCg0KVGhlIHNlcXVlbmNlICptdXN0KiBiZSBncmFi
YmVkIGJlZm9yZSB0aGUgbG9vcCBiZWNhdXNlIGl0IHByb3RlY3RzIGFsbCBwYWdlcyBhbmQgbm90
IGp1c3QgdGhlIG9uZSBmcm9tIHRoZSBjdXJyZW50IGdyYWJiZWQgY2h1bmsuDQoNCldoYXQgcHJv
YmFibHkgbmVlZHMgdG8gaGFwcGVuIGlzIHRoYXQgd2UgbmVlZCB0byBtb3ZlIHRoZSByZXRyeSBs
YWJlbCBvciBqdXN0IGNvbXBsZXRlbHkgc3RvcCByZXRyeWluZyBhdCBhbGwuDQoNCkdvdCBpdC4N
CkJ1dCBpbiBteSBsb2NhbCB0ZXN0LCB0aGUgdGVzdCBLRkRNZW1vcnlUZXN0Lkxhcmdlc3RTeXNC
dWZmZXJUZXN0IGFsd2F5cyBmYWlsLg0KSXQgY2FuIHBhc3MgYmVmb3JlLiBUaGlzIGNhc2UgbmVl
ZHMgUkFNIHNpemUgYmlnIGVub3VnaCB0byByZXByb2R1Y2UsDQpmb3Igc29tZSBsYXJnZSBSQU0g
c2l6ZSBDSSBwbGF0Zm9ybSwgaXQgY2FuIHJlcHJvZHVjZSBlYXNpbHkuDQpNYXliZSBzb21lb25l
IGNhbiBlbHNlIGNhbiBkb3VibGUgY2hlY2suDQoNCkFuZCBJIHVuZGVyc3RhbmQgeW91ciBjb25j
ZXJuIGFib3V0IHRoZSBzZXEgc2NvcGUuDQoNCldvdWxkIGl0IGJlIGFjY2VwdGFibGUgdG8ganVz
dCByZW1vdmUgdGhlIGludGVybmFsIHJldHJ5IGVudGlyZWx5IGFuZA0KcHJvcGFnYXRlIC1FQlVT
WSB0byB0aGUgY2FsbGVyPyBUaGUgY2FsbGVyIGFscmVhZHkgaGFuZGxlcyByZXRyeSBhdCBhDQpo
aWdoZXIgbGV2ZWwuIFNvbWV0aGluZyBsaWtlOg0KDQpobW1fcmFuZ2UtPm5vdGlmaWVyX3NlcSA9
IG1tdV9pbnRlcnZhbF9yZWFkX2JlZ2luKG5vdGlmaWVyKTsNCnIgPSBobW1fcmFuZ2VfZmF1bHQo
aG1tX3JhbmdlKTsNCmlmICh1bmxpa2VseShyKSkNCiAgICBnb3RvIG91dF9mcmVlX3BmbnM7DQoN
ClRoaXMga2VlcHMgeW91ciBzZXEgcGxhY2VtZW50IHdoaWxlIGVsaW1pbmF0aW5nIHRoZSBpbmZp
bml0ZSBsb29wIG9uDQotRUJVU1kuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gRml4
ZXM6IDE0NGJhOTgxNzgzZiAoImRybS9hbWRncHU6IGZpeCBhbWRncHVfaG1tX3JhbmdlX2dldF9w
YWdlcyIpDQo+IFNpZ25lZC1vZmYtYnk6IEhvbmdsZWkgSHVhbmcgPGhvbmdodWFuQGFtZC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2htbS5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaG1tLmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaG1tLmMNCj4gaW5kZXggNWQ3Mjg3
OGM4Li5lYzBmZTkwNDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9obW0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
aG1tLmMNCj4gQEAgLTE5Miw3ICsxOTIsNiBAQCBpbnQgYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFn
ZXMoc3RydWN0IG1tdV9pbnRlcnZhbF9ub3RpZmllciAqbm90aWZpZXIsDQo+ICAgICAgIGVuZCA9
IHN0YXJ0ICsgbnBhZ2VzICogUEFHRV9TSVpFOw0KPiAgICAgICBobW1fcmFuZ2UtPmRldl9wcml2
YXRlX293bmVyID0gb3duZXI7DQo+DQo+IC0gICAgIGhtbV9yYW5nZS0+bm90aWZpZXJfc2VxID0g
bW11X2ludGVydmFsX3JlYWRfYmVnaW4obm90aWZpZXIpOw0KPiAgICAgICBkbyB7DQo+ICAgICAg
ICAgICAgICAgaG1tX3JhbmdlLT5lbmQgPSBtaW4oaG1tX3JhbmdlLT5zdGFydCArIG1heF9ieXRl
cywgZW5kKTsNCj4NCj4gQEAgLTIwMiw2ICsyMDEsNyBAQCBpbnQgYW1kZ3B1X2htbV9yYW5nZV9n
ZXRfcGFnZXMoc3RydWN0IG1tdV9pbnRlcnZhbF9ub3RpZmllciAqbm90aWZpZXIsDQo+ICAgICAg
ICAgICAgICAgdGltZW91dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKEhNTV9SQU5HRV9E
RUZBVUxUX1RJTUVPVVQpOw0KPg0KPiAgcmV0cnk6DQo+ICsgICAgICAgICAgICAgaG1tX3Jhbmdl
LT5ub3RpZmllcl9zZXEgPSBtbXVfaW50ZXJ2YWxfcmVhZF9iZWdpbihub3RpZmllcik7DQo+ICAg
ICAgICAgICAgICAgciA9IGhtbV9yYW5nZV9mYXVsdChobW1fcmFuZ2UpOw0KPiAgICAgICAgICAg
ICAgIGlmICh1bmxpa2VseShyKSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgaWYgKHIgPT0g
LUVCVVNZICYmICF0aW1lX2FmdGVyKGppZmZpZXMsIHRpbWVvdXQpKQ0KDQo=
