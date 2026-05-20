Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63114CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FC110EF86;
	Wed, 20 May 2026 08:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v+vDLr4E";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBE810EF86
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUjtlrj8qR+m7DRRy6/tT7YFD4a3n2FBl+5GqB2WCYMslMsZEgXS6MQp1uVN0mkuxk3sYY6G4AH9DRobaMy1Jwgt9+aD7Fz7eWtS18ICcebbxJuL8Luv4qU7HpszhMd+b5YbepJDmNf6Gbb12MDRtNZat/sgWClH7SgE0SHabiBQLn74IVvi6hBE8S+xhtbj5c9lSJf47qqzTkU1IlpGxOoFVzhd+0eJIikZ9Hz7faFpJHnyIJWoM7K3BB62fAJkZ6+9gmJ0RhX50fl09dwa5ByVF7ADeQoL2nxfcTXJVj8WMHOocpFjKwl1Zlv4KzZLUFUtCNvOsBQtoP+dKGkY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIFvYy9EjewBTtoFaXHcc0Xt7CdQiZgR2qOWq/YkTeg=;
 b=iO51XofgeBNmYjzYV/ruPlofOx3nkT5UIBAtcb+gBwxyjkpqqxwXOAXNIR6atHJe/lQDJOJyhb6qQ5iDLG8UPRTlanWjZfwQuN6iNUD9Dl/9v+Dsn01rohyQWqkl1dLsh+go85bFk7yENqGwNU0LSoQmfIE6bW7zI3fEb+0MOO0yM0VRQMIxiEKLJmxF2hNDBNflc6RjkDi96VbvAWWGI1eOc7iaRoYENvskuwtoDBi/3+SuUsKpAWULNNC/DXPC2a2/p796aYO2S9y7KrufOwup+s+K8uKASUO8mRQ+7M28AUr2lbTbiTIZ7sq4hYelZfq0BYnLwrlZS7cRqCNQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIFvYy9EjewBTtoFaXHcc0Xt7CdQiZgR2qOWq/YkTeg=;
 b=v+vDLr4Ekdk5Yq2dzdCqT4XXFXr6kUBnK/SBadEbiHfai3n7xELj6EcXNZDS7cgl4MRidM6sMx7W9puNGVzBL1WUpLLHMqNCEpeJdk0Or8Y0uZtVYMdjtJetrCD+mYEIiRGp0R2TazqI3+qW0UPf8dV8OofdKOXdkth05z6vPJw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:36:20 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:36:19 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Topic: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Index: AQHc4585QHymMJ9kqUu5GNrLN/0ywrYOXkAwgAAnyoCAACBMwIAH9M+g
Date: Wed, 20 May 2026 08:36:19 +0000
Message-ID: <DS7PR12MB60050F9ED45DDB1058F0AE15FB012@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
 <20260514124250.3833711-2-Prike.Liang@amd.com>
 <DS7PR12MB60058DE56534CDD21A0817D3FB042@DS7PR12MB6005.namprd12.prod.outlook.com>
 <82242212-0878-40c1-b6c4-73d02c25ad82@amd.com>
 <DS7PR12MB6005ED72EF2E1E040BF268F2FB042@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005ED72EF2E1E040BF268F2FB042@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-15T06:48:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB8917:EE_
x-ms-office365-filtering-correlation-id: 4e318e19-c8fa-40d1-9b6f-08deb64addcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|4143699003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: xVgYHCsx8CPLoP2UdHp3w+2oNirxUTF+yH9fRsm2jG7Sw05ZTxqt9p6oknqkY+ES+ngK3pF4GHP/S8gEd46LECTaEQV2PS0ydEgOrO8Ddt1njVDd6NTT+pQ/6/cd2/ZX4Kr42cXRa+UwyXiXwAP7JmBmUrlSXchjn9lL4jcB40WRtYp3sJhCY2kQTvQiwH7q+wiJtcuCoZB1OJcSNbm3CorqjvTIjwXH/EdDSncTo+VR0+z3+C+/Tp2+C1Ez99CGOWRnrfruRCpqyq/1qtRHtd3/EPWauUFBegmwBOmJnBW1IZtVzqXHQKIZlJcsoMKcdVWE6a0OZLQ4NDgH512uE9WwSledKZUL80kU5c1bKx9GFSJwlSnYWXUPo81rvoS7MHXFgVnoa2XkbAzoa4gc0uyY28FaM/GyluDBz2aYjK8ykWW5tOgKdZbeBA+6KtYCcZ3hL8389vznA1BBVHPKdNL75Tj4+39gt19OztbDIBNb0Fz/nJXxywYnryLuHFtkEsQMlKRqXlKE2nTECJwmNbMramPlaBnCPHv5KT0wLwfdJEMCd6+2rdXpbJ56Z6fTt5h1RJNFwAzVefCt8nQnOODYnzQkTwJH9SM/bW+15qatzc6UMYFx4U4Zj56LzQY9Iwb8sa0WiUhI8A5ZNYg1OCpOaBF+KXJDMy03+Zv08vq48cNT2vJeYhTWkHzCeQRBQsD/9WAibe5HuVlghTc+BYa5TmiGOGHkptnP8jNW079HZUkiIY504r2fzX49Bj/I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(4143699003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K29BdkZ0VzVZcDFkaUZLQ0gvNmpIakdWak5hZTRGMGdXZHJ5ZEVNSkdOSVYw?=
 =?utf-8?B?M0cvMWViTWF3anZldjFtL1A1Z1FNaFpPMDJxN2FRT2NwejFyRURJeDFVbWl3?=
 =?utf-8?B?UUQvVWFhVXJMRG9FeC9URmN5Qk1Hd3d2OU0raTVVTkdTS2t4bWlyVlYxQTU0?=
 =?utf-8?B?TzlCN2N2TEh0K2F3K1RPc1VTVjhBRDF1eDBMQWNMUFpsb05BbGRJZTU5QmlH?=
 =?utf-8?B?SGhsd0l5N2J4ZDRPVXZ2VEhEQzlIaUR2a0NSRGJMcG8wUHFsOEFNSCtsQm9v?=
 =?utf-8?B?aDVrVHpmMEhzNEk1Q2xFVVJDSFpGakFHWHJqWVh0d010VWllKzJVYzBWQlNt?=
 =?utf-8?B?TVRnQS80TFBVOU5RRElCRFZLbmVZdmNQQTV5ZUk4Sm9CTWZQUEhURVFEdVdo?=
 =?utf-8?B?YnhCMUdacW13K0ZpQjhRZmR0YU1qaVcvZWVRQndKQ3ByelZMa2xleE55bmto?=
 =?utf-8?B?cHFYYnFjcG1aV2MrdFliWThvczFqUzVYTlhscUxoYi9JdnBwWGFIcVUyZ0NS?=
 =?utf-8?B?NDgvcDhYM0lyVzgwRWZUR1ZhNHArM2hqYzA3d3NKRSsvMCt3eEd4MjZMdHox?=
 =?utf-8?B?UXptTFlFbTFvaFMxUkViWEsvQTU1K1FwUUowdXoxYjBQVThFTUIzUjliV0JU?=
 =?utf-8?B?U29zWkFUcEV3TEd5NGlielMyMjMyekZvRG1iNnZUTndyc1pRTVRYcUNqckJV?=
 =?utf-8?B?ZmVaM1VTQ3ZaRlF1VjFQV2dhOFpvamN6Y2JFajViM254SE43WU1Nc0dUaGo3?=
 =?utf-8?B?VUlxbVpTUmNCakpjeXlhV3dBSjFTQlV3SE0rYk1STUJUVUxJa1pNWlE3OWpL?=
 =?utf-8?B?ZFZjL3FQMHJaOHJVcmZ6akw3dWcyQ2djbktqamlFMXFjeWtXc3Z2TTliYWxl?=
 =?utf-8?B?Szg4cHVjWmFQaXFiajJvY1dZbW1jTHR3bnM5OEFwVS95OHdHQ2xNUFdFbENn?=
 =?utf-8?B?ZGJ3RGRYbUtuTTh2RTQwTXZNdHMzdDJsa2ZtcUJzWmtyVnRyQWxETEFaK3VO?=
 =?utf-8?B?M2UrN001ZHFGUE0rMWI2SGk3N1A0Zkc2Yk1lekwyM1ptT21STUxIa3RWT2tD?=
 =?utf-8?B?S2JmVHVUYlV1Z01pa3lXcG5CTC81TnZaeHRsZWRvRUhseElXeHVvWThmRW4x?=
 =?utf-8?B?ejB1V2l4SkkxazdtOFBkTm43cGVWOHUyNUVRVElrSkVhRTBYSElkdjhxNG56?=
 =?utf-8?B?OTBGejF4aUtiWHNHMS9QQkVWSnZ3V21zd2E5RGpNWEQ5VXRNU1luRi90R3hl?=
 =?utf-8?B?Q0xkdlh2NVZneVhtWTFNdFBGaG5YMmpmVmtmUE9yd3pMSXpucHAxUjY3K20w?=
 =?utf-8?B?MC9MU3d4akNUU3R2R2pUVWNwamV6Q3RRZHdveTFnUjJjK1huNWprdXE5T1ZC?=
 =?utf-8?B?Q3hlNmFIYllzbGxOOC84WkV0cXpvOXpNWGR2QlFRUXR6YU5xM1p5Si9qUUNl?=
 =?utf-8?B?cHh2LzROMUw3ZlhSY3BzNWE3aHJlZ1hMdVdET0drbldNZlM5RjR2b0lWTEFF?=
 =?utf-8?B?blhBWEZBOTlSbzVzdVZRNWF3NEhQUDlwSEZNVDBYZU45YW1zL2pEOTRQOExS?=
 =?utf-8?B?aUtKa2NQeFdCVzhIYVovUEw2RzRwYU11REhSMHF3ZEhULzkrbGZoYklHcGtj?=
 =?utf-8?B?YUEzTVVlZWlneW5TRVlBQVBDWTd4UHk2Qk43TGU4ZGpGYlp3czRDVE94YUJD?=
 =?utf-8?B?RmhvUUZFWmVLREFPemxNU0dEVFhLSWFCWldFZVIwQTB1ZTBKaDVOYjhuYkFU?=
 =?utf-8?B?K09CZFJTOE1WZVZFSFJtb1l1dGlzTTFJYUZ6d2FaWUhHYlRtditIRC9CcStF?=
 =?utf-8?B?L1hJd2dMck9yN3ZBazVSem9sY1ZnL2ljQTdOcE12ZjlhbEVUNE1pSmpuM3VX?=
 =?utf-8?B?OTVBTnhXbTNrL01QaE9ZckxuVTBham1jVjRtVERtVFNSL3QrbFdUMmhxU3Jj?=
 =?utf-8?B?Q3pBbEF4YXNvTzJCbGQzdVJiU2oyc2hwZVBXTTlhOEZSK0llaTZpLy8wOEhr?=
 =?utf-8?B?WElRR3Zud0NzTUtxQTV6YUxlNE92VmdzMGJsdk12ZlBQeUZLdEZvOFl5QkJI?=
 =?utf-8?B?WFpZdU5SRitOa0xxVjN6MkYzKzdJYlNJN3VpTVhQb3lOL1FFRXhPc1FOaWxO?=
 =?utf-8?B?YnpINUlMUGc2L3dORWhvQm1jRHJzeEg1ZFIxM0UyeEM0NGtvOEg1dDk0dG1D?=
 =?utf-8?B?MklXeU1KdnlMM084TStHS3dOTThMV1pGTGgwblQ1R1g1dktObFpkdjd0cFlu?=
 =?utf-8?B?NXkxVk1UdmZCeE1nM0ZQT05mdXkvdWVod1picUloQjVKeXhPblRGdGNLdmZE?=
 =?utf-8?Q?aVoByECTZzqkggViIa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e318e19-c8fa-40d1-9b6f-08deb64addcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 08:36:19.8030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88HQKA1gsCIJD8A6BY1v/n3hK0gkYY9OWTBZgvsS1K3nog6wVZn7QFwsJD8MQ+6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIExpYW5nLCBQcmlrZQ0KPiBTZW50OiBGcmlkYXksIE1h
eSAxNSwgMjAyNiAzOjI0IFBNDQo+IFRvOiBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvMl0gZHJt
L2FtZGdwdTogdW5tYXAgdXNlcnEgZm9yIGV2aWN0aW5nIHVzZXIgcXVldWUNCj4NCj4gQU1EIEdl
bmVyYWwNCj4NCj4gUmVnYXJkcywNCj4gICAgICAgUHJpa2UNCj4NCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQu
Y29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgTWF5IDE1LCAyMDI2IDEyOjUzIFBNDQo+ID4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+ID4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+ID4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogdW5tYXAgdXNlcnEgZm9y
IGV2aWN0aW5nIHVzZXINCj4gPiBxdWV1ZQ0KPiA+DQo+ID4NCj4gPiBPbiAxNS0wNS0yMDI2IDA4
OjAwIGFtLCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+ID4gPiBBTUQgR2VuZXJhbA0KPiA+ID4NCj4g
PiA+IFdpbGwgcmVzZW50IGEgbmV3IHZlcnNpb24gZm9yIHVwZGF0aW5nIHRoZSBjb21taXQgbG9n
Lg0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiAgICAgICAgUHJpa2UNCj4gPiA+DQo+ID4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+PiBGcm9tOiBMaWFuZywgUHJpa2Ug
PFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gPj4gU2VudDogVGh1cnNkYXksIE1heSAxNCwgMjAy
NiA4OjQzIFBNDQo+ID4gPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4g
Pj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtv
ZW5pZywNCj4gPiA+PiBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExpYW5n
LCBQcmlrZQ0KPiA+ID4+IDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+ID4+IFN1YmplY3Q6IFtQ
QVRDSCAyLzJdIGRybS9hbWRncHU6IHVubWFwIHVzZXJxIGZvciBldmljdGluZyB1c2VyDQo+ID4g
Pj4gcXVldWUNCj4gPiA+Pg0KPiA+ID4+IElmIHRoZSBkcml2ZXIgb25seSBwcmVlbXB0cyBxdWV1
ZXMsIHRoZXJlIGNhbiBzdGlsbCBiZSBpbmZsaWdodA0KPiA+ID4+IHdhdmVzLCBwZW5kaW5nIGRp
c3BhdGNoIHN0YXRlLCBvciByZXN1bWUvcmVkaXNwYXRjaCBwb3NzaWJpbGl0eQ0KPiA+ID4+IHRp
ZWQgdG8gdGhlIHNhbWUgcXVldWUuIFRoZW4gdGhlIFZNL1RUTSBzaWRlIG1heSBwcm9jZWVkIHRv
DQo+ID4gPj4gbW92ZS91bm1hcCBxdWV1ZSByZWxhdGVkIEJPcyBkdXJpbmcgZXZpY3RpbmcgdGhl
IHF1ZXVlIHdoaWxlIHNoYWRlcg0KPiA+ID4+IFRDUCBjbGllbnRzIHN0aWxsIG5lZWQNCj4gPiB0
byBhY2Nlc3MgdGhlbS4NCj4gPiA+Pg0KPiA+ID4+IFNvIGZvciBldmljdGlvbiwgdW5tYXAgaXMg
c2FmZXIgYmVjYXVzZSBpdCBtYWtlcyB0aGUgcXVldWUNCj4gPiA+PiBub25ydW5uYWJsZSBiZWZv
cmUgbWVtb3J5IGJhY2tpbmcgaXMgaW52YWxpZGF0ZWQuIE1lYW53aGlsZSwgZm9yIGENCj4gPiA+
PiBpZGxlIHF1ZXVlIGl0J3MgbW9yZSBzdXRpYWJsZSBmb3IgdW5tYXBwaW5nIGl0IHJhdGhlciBw
cmVlbXB0IGFuZA0KPiA+ID4+IHVubWFwcGluZyBhbHNvIHNhZmUgbW9yZSBwcm9jZXNzaW5nIHRp
bWUgdGhhbiBwcmVlbXB0Lg0KPiA+ID4+DQo+ID4gPj4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlh
bmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gPj4gLS0tDQo+ID4gPj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDQgKystLQ0KPiA+ID4+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+Pg0KPiA+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0K
PiA+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiA+
PiBpbmRleCAyZTNlZGI2ZGQ1MDYuLmE2M2RmZGZhNDE5NSAxMDA2NDQNCj4gPiA+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+ID4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gPj4gQEAgLTEwNDgs
NyArMTA0OCw3IEBAIGFtZGdwdV91c2VycV9yZXN0b3JlX2FsbChzdHJ1Y3QNCj4gPiA+PiBhbWRn
cHVfdXNlcnFfbWdyDQo+ID4gPj4gKnVxX21ncikNCj4gPiA+PiAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRpbnVlOw0KPiA+ID4+ICAgICAgICAgICAgICAgIH0NCj4gPiA+Pg0KPiA+ID4+IC0g
ICAgICAgICAgICAgciA9IGFtZGdwdV91c2VycV9yZXN0b3JlX2hlbHBlcihxdWV1ZSk7DQo+ID4g
Pj4gKyAgICAgICAgICAgICByID0gYW1kZ3B1X3VzZXJxX21hcF9oZWxwZXIocXVldWUpOw0KPiA+
IEFzIHBlciBteSB1bmRlcnN0YW5kaW5nLCB3ZSBhcmVudCBkb25lIGZvciB0aGUgcXVldWUgYW5k
IGFsbCB0aGUNCj4gPiByZXNvdXJjZXMgb2YgdGhlIHNob3VsZCByZW1haW4gaW50YWN0LiBBIHF1
ZXVlIGlkZWFsbHkgc2hvdWxkIG9ubHkgbmVlZCAiDQo+IG1hcHBpbmcvYWRkIG5ldyBxdWV1ZSIN
Cj4gPiB3aGVuIHRoZSBxdWV1ZSBpcyBjcmVhdGVkIGFuZCBvbmNlIHRoYXQgaXMgZG9uZSBvbmx5
IHRoZSBsaWdodCBwcm9jZXNzDQo+ID4gb3Igc3VzcGVuZC9yZXN1bWUgc2hvdWxkIGJlIGdvb2Qg
ZW5vdWdoLiBXZSBkb250IHdhbnQgdG8gdGVhciBpdCBkb3duDQo+ID4gb3IgcmVidWlsZCBhZ2Fp
biBmb3IgYW55dGhpbmcgdHJhbnNpZW50Lg0KPiA+DQo+ID4gUmVzdG9yZS9ldmljdCBpbiBtb3N0
IG9mIHRoZSBjYXNlcyBpcyBhIHRyYW5zaWVudCBzdGFnZSBhbmQgb25seSBhDQo+ID4gdGVhciBk
b3duIHNob3VsZCBiZSB1bm1hcHBpbmcgaXQgb3IgZHVyaW5nIGEgR1BVIHJlc2V0IHdoaWNoIHJl
c2V0IGFsbCB0aGUgaHcNCj4gc3RhdGVzLg0KPiA+IFNvIHRoZSB3YXkgaXQgaXMgc2VlbXMgbG9n
aWNhbCB0byBtZSBidXQgaSBsZWF2ZSB0aGF0IHRvIENocmlzdGlhbiB0byBjb25maXJtLg0KPg0K
PiBGb3IgdGhlIGV2aWN0aW9uIGNhc2UsIGl0IHdpbGwgYmUgYSBwcm9ibGVtIHdoZW4gdGhlIHVz
ZXJxIEJPcyBtaWdyYXRlZCBkdXJpbmcgdGhlDQo+IE1FUyB0cnlpbmcgdG8gc2F2ZSBvciBhY2Nl
c3MgdGhlIHJlc291cmNlIGZvciBwcmVlbXB0aW5nIHRoZSBxdWV1ZS4gQWxzbywgdGhlDQo+IHBy
ZWVtcHQgb3BlcmF0aW9uIGRvZXNuJ3QgbmVlZCB0byB3YWl0IHRoZSBxdWV1ZSB0byBiZSBpZGxl
LCBzbyBoZXJlIGNob29zZSB0byB3YWl0DQo+IHRoZSBxdWV1ZSB0byBiZSBpZGxlIHRoZW4gaXQn
cyBtb3JlIHN1aXRhYmxlIGZvciB1bm1hcHBpbmcuDQoNCg0KRXhjZXB0IGZvciBtb3N0IGNhc2Vz
IHRoZSB1bmJvdW5kIHdhaXQgKyB1bm1hcCBzaG91bGQgYmUgZmluZSwgYW5kIHRoaXMgc2hvdWxk
IGF2b2lkIHRoZSBTUSBlcnJvciwgYnV0IGZvciB0aGUgbG9uZyBzaGFkZXIgcnVuIHRoZSBwcmVl
bXB0IHNob3VsZCBiZXR0ZXIgYW5kIHRoYXQgbmVlZCB0byBkcmFmdCBzb2x1dGlvbiBmb3IgaGFu
ZGxpbmcgdGhlIHVzZXJxIHdhdmUgY29udGV4dCB2YWxpZGF0aW9uIGJlZm9yZSByZXN0b3Jpbmcg
dGhlIHVzZXJxLg0KDQoNCkhpIEBEZXVjaGVyLCBBbGV4YW5kZXIgIENhbiB3ZSB1c2UgdXNlcnEg
dW5tYXAgdG8gaGFuZGxlIHRoZSBTUSBlcnJvciBpc3N1ZSBmb3Igbm93PyBBbmQgbGVhdmUgdGhl
IHVzZXJxIGludGVybmFsIG9iamVjdCB2YWxpZGF0aW9uIGR1cmluZyByZXN0b3JlIGFzIGEgVE9E
TyBpdGVtPw0KDQo+ID4gUmVnYXJkcw0KPiA+IFN1bmlsIEtoYXRyaQ0KPiA+ID4+ICAgICAgICAg
ICAgICAgIGlmIChyKQ0KPiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gcjsNCj4g
PiA+Pg0KPiA+ID4+IEBAIC0xMjg1LDcgKzEyODUsNyBAQCBhbWRncHVfdXNlcnFfZXZpY3RfYWxs
KHN0cnVjdA0KPiA+ID4+IGFtZGdwdV91c2VycV9tZ3INCj4gPiA+PiAqdXFfbWdyKQ0KPiA+ID4+
DQo+ID4gPj4gICAgICAgIC8qIFRyeSB0byB1bm1hcCBhbGwgdGhlIHF1ZXVlcyBpbiB0aGlzIHBy
b2Nlc3MgY3R4ICovDQo+ID4gPj4gICAgICAgIHhhX2Zvcl9lYWNoKCZ1cV9tZ3ItPnVzZXJxX3hh
LCBxdWV1ZV9pZCwgcXVldWUpIHsNCj4gPiA+PiAtICAgICAgICAgICAgIHIgPSBhbWRncHVfdXNl
cnFfcHJlZW1wdF9oZWxwZXIocXVldWUpOw0KPiA+ID4+ICsgICAgICAgICAgICAgciA9IGFtZGdw
dV91c2VycV91bm1hcF9oZWxwZXIocXVldWUpOw0KPiA+ID4+ICAgICAgICAgICAgICAgIGlmIChy
KQ0KPiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gcjsNCj4gPiA+PiAgICAgICAg
fQ0KPiA+ID4+IC0tDQo+ID4gPj4gMi4zNC4xDQo=
