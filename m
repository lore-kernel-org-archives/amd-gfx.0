Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400A1CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 09:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE43C10E568;
	Mon, 22 Jun 2026 09:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MwAFb8Ty";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012028.outbound.protection.outlook.com
 [40.107.200.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53BE10E568
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 09:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kP/diTfUIEKnRZ5qCk+e6OAeAYqXwhjAW6K6zuVq2JJGJ+8JSJNbRNpDC1bfy5YqIR/fvCyK1Oc3s1uWY9FO6gyYaAl7r0GUxZitwaa7/lmJSNo/luwdAcGyoJid6YFggkrPROH/DgQpD7aK+BKenZyEfmnifWKYs/YwOBxSk2ARy2jK+vYWDanz6kgW1OyP4mj75LUGesMBLjhH2XOKRPg1UqDeOmuomg5KENyGut33eG5qv6YW+WdopAyi3hpSLReCJQdGOt+fNsoxOdkxRwy4+hkQxOa+NiSO2iOawab7bzh8UWcMot7l+/t8pbIJ4Q/tfotSSe4WqLDTqj+rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJSFueT6HH0y+51dmaf3VR01uPa1mo8rONcq7oO9kZQ=;
 b=jwGm/Z8EmTnPxc65GUlKIax4mu2p3CNqADS6iBvNlgjjvXbaktLb3OyAnc/GUiQJll8bGeXLSUfpBZ9XCeQjWwGnIa6BMj5Qxo9VX0Xzaa19B6rdJ0pgyUwbZPZWxH1ldTGRbvWbbhqAlk4cldd5bDvKDWh0UZE9nmkNOgNZoBDriQKzVVHjc64iCMp1zlDc73mWpB/gHH7NV4g6jyy30EfxLMrbcUjG/VfEFIC4dMZQgBzIq5m8TYCmy/LT6BrSOSJCZB+Wn8A4yBInL9F8EzlRBuS+SzPridZ+th2n5Zg1bzPPgnI9AEQ0vHufe+ISHpza7hBo1RsjbOR/IgIStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJSFueT6HH0y+51dmaf3VR01uPa1mo8rONcq7oO9kZQ=;
 b=MwAFb8TyjFBWw0vgUHoum4+3/14+zmxRPKJcwKhH6okqauaVrscK8jdr9KfZgD6pCHYgvt9VG4my8rI9GcYjJFtVQXkBePQsuEsYC5wsn7F57Szb98TFwZiMK20v2o2KK0oSGsmAnRa6I05Ze4lgdYTdzKXr0xVOzzx0qPo0T/k=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by LV0PR12MB999070.namprd12.prod.outlook.com (2603:10b6:408:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 09:01:42 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 09:01:42 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Thread-Topic: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Thread-Index: AQHdAA+QIv+XVhj5VEWKsTwNX70BhrZKPm0AgAAMQFA=
Date: Mon, 22 Jun 2026 09:01:42 +0000
Message-ID: <IA0PR12MB82087A22BE651E5AE05C3B6390EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
 <5eadae57-bc7c-4c22-9e02-04c32d7e6e97@amd.com>
In-Reply-To: <5eadae57-bc7c-4c22-9e02-04c32d7e6e97@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T08:59:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|LV0PR12MB999070:EE_
x-ms-office365-filtering-correlation-id: c0e996cd-fff9-4da0-00bb-08ded03ce101
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info: 9tx1+PcMSfQH8ZgmdEJC0eqvOEy99mG6+/ErL4k0CZrgjqdgvmLSsdvvXwIH/YBpillw9dA/8KI3aupNLlDAv0QKok3ITeWddxRSB/DbbbvPogZJkbPwMDk4tWqgSOVr5G5YV76gJjmGEIwdLpGvcJ5dlW6OK/GBn2w6VcTzwtZ2uq5C3HUxKjwhhJfEEVF3WXGP9foNCfg/NfMtYHob77t/ekmUjm8kBXUZAXJsM/ESCz0/0co3I2orgwwtvr/a4eZ7i/pS3b3ZPO1HtEVa+F7ZIoo/SMi60GFrCW20Js3fhK7zjzBa9HvXHe5y/GtO6IA2vCFcmXyRFwH2OGhQxfQiuy+nKmfiFt7+f82vLGVy7PpDRFr7iXTg84r9pphjr+aug7bYZy75BA11LYtpvpoNV+jyhT3vLVCBf9vwXP0wYlDwccKhz18J19ReauYwXwagwfHDvYZb+z5d7HjXyQC15hFTdSfDbhuPUtiteWkyqJSAUn9KAuDeD10cydrGHm8jEFQPqSthza01c3nzqECVMbK16SU2wcim/ry66s5Q5DvSwqxWsXB3edFddcGrqoQcVdU4TvxXUzMbnbwcIS+KjLuuaOlEF3oNUtndRAk9UHQNe8vDT9NYWCN9j/LH7Q6f/RvdkNkr5KdCQxsYIXxpf/83p6FTg+kJfdzq7Yf9v9vcq5+l3slfAJi/w4LxPgUElxhqt+WZFIZjkTyf46ezdDrbEVdsxeRUNdeN1LA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEpYWnE0MzA1QktxVkhKOEM2MWlHeHAyQjl3MWxzY0daZ2RGcVNKSkdUcGw4?=
 =?utf-8?B?ako3ZDZIYjAyMUwyTmZTeDJTRzVEY2JxRmkrd0ZSbE9UVWp5MG9BVWNFQzNU?=
 =?utf-8?B?TTduNnJJT25mQjdocGRtamxxem56MUlIUm0yZGtWbHdXQllDcUJEc2xIRkZo?=
 =?utf-8?B?WWhtUnFBNWlxQm9wQmowbWlIS1RMT3BmSkIvb1JrQ1lySTFTM1BPMjRDdmNs?=
 =?utf-8?B?UzFTWlRSUzZ0Zm9MWVRZYXFjenpoRHFubjBhTWh4L0VNZzhZVndvRFRXS2wz?=
 =?utf-8?B?R0p1NlRXdEtDa2NEbmR2N05xaVVMSDlqdzZKanpBMFJqcEpYd1pIaXJLTnA1?=
 =?utf-8?B?UTY3Z0hqQm5Zc3MvZjlRaElvRzlyUndqNlZnK2NEemFRMnV6ejNCbmg1L3JE?=
 =?utf-8?B?RVRua0ttLzNQMkIrdEFWdkxjMGk4em9aVTJTUERycWxzd3NlM3dKajZQSWdr?=
 =?utf-8?B?YVhZS3gxdU0xbVQzQ0UyanRuMHVkTDNic056cjhmNUhvVElXNmpVb2s0Vzkr?=
 =?utf-8?B?dFR2clYwYzVpNVU0YVhmbklHblhYeXQ5d3VUOGJVeGxhc1htVWFURUdpTy9Z?=
 =?utf-8?B?RUsyZXlhRVUrbEhRMjlsa000YWVzbmZQenBLZW5YWHU1VGF0YUQzVnhRZUZZ?=
 =?utf-8?B?YTJNTmZJOVV4WU1IbTF0UlR4QitiY1VJdS9UQWZiZXl1aXlsZHNwa0hxQVpI?=
 =?utf-8?B?UkhyV2g0a1ExcXZvTTR4SmkzSFZPNVRxZktNdzdZcTlYT09zS0dSTEZHK2p1?=
 =?utf-8?B?Tks5T3A5SHBrTUVmalBLWDhVdmx3VmFIOVdmYWJDc1F2dGV0R1ZteHpBRUNE?=
 =?utf-8?B?UEVzSEZjUDBnbFcra0VjeElKVmtNQUVEenNKVmVnN1pOMWQyRG11Z3QwTUdY?=
 =?utf-8?B?ejBpQXI4TEdvWk01UmJ3eUtDSU1RakI1K2FZOEl1SkxYZkRSS2RsZjFhWXhL?=
 =?utf-8?B?OFRJYlcxTmFiMnBxcjU1VFJEekVSUlNtSVZXTUZFQldXRmtQeDZ1NFN3aWdu?=
 =?utf-8?B?QXloanVPeUZvbVhuZ2VvcXduRitZdkV0Y3Q1MzlHcW9NeDNjckU4VnlncmM4?=
 =?utf-8?B?RzAwVmNYeEw3YnJaSkRIL2x3enpmWmtjRFEyaE83R1NWVURXNXUyWVlCa21w?=
 =?utf-8?B?SVVZVm9iQ01JZG9PV3JCQlNqaHdNMVVuMGhiMDR0L1JKcDQ4akNDVThCNURM?=
 =?utf-8?B?ZlpsR1IwWnFzRCtuaXI1Y0V0U3ZtellPVFVVQjNCa0xFYmtJa3JlazBObGZp?=
 =?utf-8?B?dFNsT1JGa1RLdDlpTHRBK1lKUS9VeU11QzlvaytJM2djbGxjSml6b3ovTE1r?=
 =?utf-8?B?QUJ1V24raWR5TDB6S2tvNkRrK0ZUS0c0K3BMTEtYL3lFckZ5WVhaR2VwWFB1?=
 =?utf-8?B?Zmt4UG4xeWZ6TXZiVERpZWEwN1lJaGhoM1pRTkFYeXIzTlRnYWovTGFhZXhU?=
 =?utf-8?B?UjR6bXRYd2ZpRUQrZ3NmNXVDbW1OeXZqUkRWUjRzSGVMa2l5bEZGdVYxMlZ5?=
 =?utf-8?B?Q3ZvaFU1dzZKdUtUZ09jcnZHdFVTUjlNUHJOWEtzS2l1OWdTZFowZTZFKzkx?=
 =?utf-8?B?RjRkM0EzU0JZcWZUK2JlT0RzL1Bwc1FOdlNDMVJzeHhOQjlLcGRQNVdzdVZr?=
 =?utf-8?B?Rm5IQ3pOR2lpdVpHSnRObkV5TnpqRGxhdVNDdjhKeTQrQXhCVHphUFdoelcy?=
 =?utf-8?B?NGl0QW5JQTVrMWp2M0F3UjVUZUo5V1ZiaXhveXgvR0gydFpvZ3JZYjV5UHl3?=
 =?utf-8?B?Vmh0Q3hwdXhEdnJmcDdpa3BCYWhSb29EN0swbXUxUVJiRytGaHNyK0lGQVdZ?=
 =?utf-8?B?STZIWi9jQWRCK240TE1lZVRlcFpqM0pGS3JNTlJibjhqczVlYU5GRmNmeVRo?=
 =?utf-8?B?MStCcjJwWk5zS013aEZmczVYaHkyNFFjS0thYlhBeDlHcEVFN2V4S080TGJk?=
 =?utf-8?B?STM5cmRNY3VnYllTTGdhdnVHbFhtWnpVU2dwTUdSMlJTU1pFN1piQWtLcUU1?=
 =?utf-8?B?TUpCVjZSZzdTQUhuSVVMQytUY2FjNS9qU2t1NzFneUdLTEJYcU11WmRkVFFJ?=
 =?utf-8?B?T0lHZFZoeXlOa3BzbzdTNVI1ZUlYNDVUMzgxWXFSY2EreVpmaER4YllvN2NG?=
 =?utf-8?B?bHRnUEppSDQyei9SS2JCVXF0MDBjekluVHc2T05MZmFyUEY0RnQwcFhJcDJk?=
 =?utf-8?B?Mm1YZGdPV01FQkx6Sm53YVpjcFQ0OE8xTWJRVCtTRGR2ZE5yeC9yaUl6d2Yz?=
 =?utf-8?B?T09Na2FVQ1ZudTRDL3VaeENLeE02T0JISUlOQVl0VHdjRVRXS21KTzE0d0R6?=
 =?utf-8?Q?K5jKDlBy3snMojfH8w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e996cd-fff9-4da0-00bb-08ded03ce101
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 09:01:42.4237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPSTF4db9MK8OZDPlG80pN33kOd2r8/e9p2N6TXS1jmspTI9lVAbxXGWqQjqui3Kg8dQDJ8c1JpfU7tsp3wDPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999070
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXks
IEp1bmUgMjIsIDIwMjYgMTo0NSBQTQ0KPiBUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklO
SVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlzdG9mQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZGdwdTogUmVkdWNlIHN0YWNrIHVzYWdlIGluIElQIGJsb2NrIHNvZnQg
cmVzZXQNCj4NCj4NCj4NCj4gT24gNi8xOS8yNiAxOToxNywgU3Jpbml2YXNhbiBTaGFubXVnYW0g
d3JvdGU6DQo+ID4gYW1kZ3B1X2RldmljZV9pcF9zb2Z0X3Jlc2V0KCkgYWxsb2NhdGVzIGFuIGFy
cmF5IG9mIEFNREdQVV9NQVhfUklOR1MNCj4gPiByaW5nIHBvaW50ZXJzIG9uIHRoZSBzdGFjay4g
T24gNjQtYml0IGJ1aWxkcyB0aGlzIGNvbnN1bWVzIGFyb3VuZCAxMjgwDQo+ID4gYnl0ZXMgYW5k
IHRyaWdnZXJzOg0KPiA+DQo+ID4gd2FybmluZzogc3RhY2sgZnJhbWUgc2l6ZSAoMTMwNCkgZXhj
ZWVkcyBsaW1pdCAoMTAyNCkNCj4gPg0KPiA+IE1vdmUgdGhlIHRlbXBvcmFyeSByaW5nIHBvaW50
ZXIgYXJyYXkgdG8gaGVhcCBhbGxvY2F0aW9uIHRvIHJlZHVjZQ0KPiA+IHN0YWNrIHVzYWdlLg0K
Pg0KPiBDbGVhciBOQUsuDQo+DQo+IEdGUF9LRVJORUwgYWxsb2NhdGlvbnMgYXJlIGZvcmJpZGRl
biBpbiB0aGUgcmVzZXQgcGF0aC4NCj4NCj4gWW91IGNvdWxkIHVzZSBHRlBfTk9XQUlUIG9yIEdG
UF9BVE9NSUMsIGJ1dCB0aGF0IHNob3VsZCBiZSBhdm9pZGVkIGFzIHdlbGwuDQo+DQo+IFdoeSBp
cyB0aGF0IGFycmF5IG5lY2Vzc2FyeSBpbiB0aGUgZmlyc3QgcGxhY2U/DQoNCg0KVGhhbmtzIENo
cmlzdGlhbi4NCg0KTG9va3MgbGlrZSB0aGUgdGVtcG9yYXJ5IGFycmF5IGlzIGN1cnJlbnRseSBv
bmx5IHVzZWQgdG8gY29sbGVjdCB0aGUgc3Vic2V0IG9mDQpyaW5ncyBhZmZlY3RlZCBieSB0aGUg
SVAgYmxvY2sgc29mdCByZXNldCBhbmQgcGFzcyB0aGVtIHRvDQphbWRncHVfbXVsdGlfcmluZ19y
ZXNldF9oZWxwZXJfYmVnaW4oKSBhbmQNCmFtZGdwdV9tdWx0aV9yaW5nX3Jlc2V0X2hlbHBlcl9l
bmQoKS4NCg0KYW1kZ3B1X2ZpbHRlcl9yaW5ncygpIHNpbXBseSBjb3BpZXMgbWF0Y2hpbmcgZW50
cmllcyBmcm9tDQphZGV2LT5yaW5nc1tdIGludG8gYSB0ZW1wb3JhcnkgYXJyYXksIGFuZCB0aGF0
IGFycmF5IGlzIG9ubHkNCml0ZXJhdGVkIG92ZXIgYnkgdGhlIG11bHRpLXJpbmcgcmVzZXQgaGVs
cGVycy4NCg0KTG9va2luZyBhdCB0aGUgaW1wbGVtZW50YXRpb24gYWdhaW4sIGl0IHNlZW1zIHBv
c3NpYmxlIHRvIGVsaW1pbmF0ZQ0KdGhlIGludGVybWVkaWF0ZSBhcnJheSBlbnRpcmVseSBhbmQg
aGF2ZSB0aGUgaGVscGVycyBpdGVyYXRlIGRpcmVjdGx5DQpvdmVyIGFkZXYtPnJpbmdzW10gd2hp
bGUgZmlsdGVyaW5nIGJhc2VkIG9uIHRoZSByaW5nIHR5cGUgbWFzay4NCg0KTWF5IEkga25vIHBs
cywgd291bGQgdGhhdCBhcHByb2FjaCBtYWtlIHNlbnNlPw0KDQpSZWdhcmRzLA0KU3JpbmkNCg0K
Pg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo=
