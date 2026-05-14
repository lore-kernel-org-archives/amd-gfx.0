Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3802ECD4F21
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 02:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C786D10E124;
	Thu, 14 May 2026 02:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kuf1Ai0x";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5205710E108
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 02:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgbuFKRKrHqJaosWo52tXlgSY6Mw/vWtzK0bmQltWyLZiKHgv/Np9RfPAuk76e9RcygoARWwK066FUPtM1KOWvTjIqzkBh/8C0tA8Twf7uPklWXTmwi374/hK8NmmVGm/GPAOWdchrnyIHtpdIZNCMIyIhfJmSzkWEK/+qPdY6Cx4j16B64R7pS3Ty9TjqwLbLUwcw5jcQPW7zjZhcG9rGefXDXCJ3v2nvoU71B+o1eYEoIioaRe7Zj/sYuk+9SdJjyYcNmuWL7mz4ZgKd9V3UuKi+iFj6zN/Edg4yInNfjkKV5S/VnNaxWnwzpy/zlkRsOBaS4FQjNKIopaXsFOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GAG7HbHY6w3TGfMkz01VYU6hMdQaKRvSKtDDBlT0Do=;
 b=PWApAVzuzm905Ll8jznNwYlPzRxQmMtQuvsfONyK1+gbzWZsQj+UTlSHU4EeLatFyDFFgH5YEX4f8ok2/PI0oA6eeiOTqNNkEt7jvH/wP28qMdkMpCqRjYygswzEecQK0ecweVhFhKwdz57g7vFfZuSUyV9BngWuxQcmfkXuiC4CCkyDgVOcAApdAWaJd8SdxM/CqlnMdmJV8ZdGP3iZQ4r54T2ZcxSbaScFhBmJHYKeFdKHz9/owAO5zop18RKpIFD8klEMpWCfs1SWSVkrlXMWyNPET9h1pPNuOeEWkPF+pZr2OeFnniaJOtYHimMq0/wmRjzpkXUAjT1Ci53n6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GAG7HbHY6w3TGfMkz01VYU6hMdQaKRvSKtDDBlT0Do=;
 b=Kuf1Ai0xMQ8QA01lDIqVBv7h+kGtTG+q1WqGG3RbYmfCNNbdeiraJOmL/IvB/oGS9CdQnSVBdehSeoaW0FHI8piRaS//5bUb1ncgUcSJ5m7aDbZ2K0KorSUBBZAG6WTql/pH9HKBFvvEpz3MJZ0gGCJ++Ab/akOJh4zIU42vZwg=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 02:53:56 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:53:56 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: add userq fence emit and signal
 tracepoints
Thread-Topic: [PATCH 3/4] drm/amdgpu: add userq fence emit and signal
 tracepoints
Thread-Index: AQHc4U2+hxdNFaO3n0a88fEgR5z4HrYLr44AgAEnAMA=
Date: Thu, 14 May 2026 02:53:55 +0000
Message-ID: <DS7PR12MB6005ABC0E0AE3157B4FF7ACFFB072@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
 <20260511135435.3818345-3-Prike.Liang@amd.com>
 <81f4c3d9-a7ea-47b4-9f39-3c78e7d51a5f@damsy.net>
In-Reply-To: <81f4c3d9-a7ea-47b4-9f39-3c78e7d51a5f@damsy.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-14T02:51:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB6493:EE_
x-ms-office365-filtering-correlation-id: 17771328-cf11-443f-bb4f-08deb1640a2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|11063799003|56012099003|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info: NGxSuxggmY7SPdVvwRz/8KYDmyUIktsmuLWrhF5+7S+xUWkObegvLSBvu9ZlEx6vA2968hEf7c4ajxxcCH+8wznDnsYISBLi9wX/0oJMuMGTrlZ/oeHc99C+MGXX4/Oypasa5RpdDXVZYq57fxCq6+jgsT/E9qHGo1PNF+vEug1pRj2u1lwORlYChhFG0tuPDcXOHkSQdnEtQx0aCFIn/mRzYk3CEZ3PwTfcaQ5vVoTHM3BzlTG0HF12V+VZ0mrJL9BpCT8Jr1U/F182YLEWHFXtne/xseeF2jSWYY58qliraUCSx7OiD4QepNMuqyX493ht4te8tSRe/hI25boy8B4SLulECPB2fJ+i4PaysGHLBmK0m7y80GsABgWhBXvPJmzfFXCAXXXgOH6kyzyX8+7VKS3DzRXNRMvIZ3XISDvQ6YI8a3QwoacazruZZ8q9VZRKYWeJnjx6oYE0a6JAl6C6Rc5tKLZyeeNT7rXMKbJYRVewcq9NbQ+8+BT0/OvXjqRAw8l7i9a/fz/f4Tj9B/snURByRIKqokrUZcR3R+lavXc1yJgNPnG/UlMC25VxC4LVdhtDoHolyZhq/IdGagsDt5gD68rKuoa5PvZHLUaAF3Fq+qPwVu+zYqBaf+MwmA9/93Y1LLk+BvJIvrGt8KqQwinRrboxRK2WgiFQip5H79XpuxRJdrNgOpKVZzez4tcgaLi+hW1tsPpvW4UHJI0Qytqh0UeC5bvsYgQRWmMHwwGbVBGk/YPmOgzNwuEt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akxKUVB6UEZ2UmxaSmxhUGRZaXZSSmhjL0krYm9DZDhRNHg3Q2xaV3lmN3c3?=
 =?utf-8?B?aXVwVE01cjBuTDVnL0JIT1Zsc0NVSzJJMDFGejJwNFRoVVZaYWVHYTBZWnUv?=
 =?utf-8?B?RlBiVFhxL3lLSk9Gay8zK1ZsTzYzdlpUd28rbk5pd01RSTBwc3QxTlBMMmlL?=
 =?utf-8?B?WkVoQWYvMmcvVlVSbldhMGMvN1llNDZMSHhFT3NtY25wdklxc1R0VGR5S2hC?=
 =?utf-8?B?VmxOYU55Sy9CUlVnLzJ0UzdqTVBEN29YeVlqRFQrdDU1anlQc2ZpM043VG5t?=
 =?utf-8?B?amZlQWtIZEF0UldCM1BPY1VCSjVYazA1RjNIWHBPMXBRSERnZVVMNWtsQUc4?=
 =?utf-8?B?T2ZyblhkbXRRMlUvMWlhSDYyMGNKcG91bEFIRWtpenk4UjJkM2tuTnU3eFdJ?=
 =?utf-8?B?QldjV1RxQjZvWG9CdXhMMWNVYlNFY0RwYkkrczVlR296LzFRN0U4UWhnTmVS?=
 =?utf-8?B?TmdnL0ZzOEVYaVNFdlAzdG5yUGVibEZLMUxIZVp2aFJIVU5QclFScEF3WVRh?=
 =?utf-8?B?REVaWXBDVEh0dWRDZjZLcmZybTd0SEJvSEJ1L1FZZVVMTWhiRlBvOHo2YlN1?=
 =?utf-8?B?NTdLTHZ3VFRFZEdTdkJveHhWMlhjU3NsUVpEQ29NRTN0MDVOUTRqSTBIQkJM?=
 =?utf-8?B?eUpjUkYyY1kvRnVIL1kwdlV1bGxWbnBza3VZdG1NeU05c1VlT2JvWldhSU44?=
 =?utf-8?B?WDQ3Q1JiZmpsd3dBSjk5alFUQjJsOUhIVHVNeG5mZHovT3BNMFlreThpNUxa?=
 =?utf-8?B?UUN1SVNmYVNnbVVLZEVqTHIzaVpUUFk1bFphalhXL3U4VHN0dTd5dk4rc21w?=
 =?utf-8?B?UENaaEIxSjR6RTVlMjlVcjRSV2NRVVd3WmRLQ0RDL2xlS1ZTL3lyMENLbFVy?=
 =?utf-8?B?eFhuNFZqYTl5K3A4SzZuZmNLUXlESlhiallhUkJHZmtVUVYzQU96eFMrWHM2?=
 =?utf-8?B?TUN0NlYvb0ZEV29nTm5OTWdvRHRpbkJVZDMvNzdUNnhNV2p6dTRnMHM1eWUr?=
 =?utf-8?B?cHpFUlB2U0NaWmIxZldRRm5IOVQ0NkFaZ0k2dTkxS0crWC9pS1k0L090YnAy?=
 =?utf-8?B?aHJDNTFRa0J6ZUdIM3J1WkoyY3U2WVNJb0J1SzdMTEJWcUZ0TDduZDFlVVZL?=
 =?utf-8?B?WlViUEQvMS9iMnptQVhhVHdyVkhyZWJ6ZUtCd3JiZGdiU0ZvRGRrYUgrc1Fw?=
 =?utf-8?B?Vk9ucG5BaVE1dTJLeGl0STAvVnEwaUtaZkNaek03b3hhMEpMTityQWt2YkM5?=
 =?utf-8?B?SEhjcTZ1WS9WdHM5WFNDN2FMb1VXeVRDMGM5M2JGa28zdll4NW1vT0phMmor?=
 =?utf-8?B?VFlKckJMVUF1WGVpWkJJRm5kTFRXakhPV0ZHOHpRMXZVWllDb0FwZXRDbVN6?=
 =?utf-8?B?RWROZDB2K3RZRzVhUVhlNmxvQjFJdGVscXhVOUpEME51b1ovSVppbGUrSlZx?=
 =?utf-8?B?WlpPbnlxWUg5TjBJOGpaM2pndjNUTUdpRXV3Q3M5N3cvUDZtalJDOEV4YkFB?=
 =?utf-8?B?YzhhRTIzOTJrSm8yQWdKek1BQmpxQTJoRHpEblZrNGRUNkxnVTBXMFFOdUZ0?=
 =?utf-8?B?NDBqWkV1a2VETVZOWWtkSmJQOG1hL0h3a1UyaVpTY3ZURnNSUXc2Q05kNzlw?=
 =?utf-8?B?d1hWTEF4QTBPSW9EOWoreHBWZ3c4dENlS3JHUkFXL0lIYVRiWnFvbnk1a0pV?=
 =?utf-8?B?a2M2TDNrRUxaZUsrVFJZNjdXelBoWmthRXNheEZMYXhUamV1Y3N5WS9yeUgr?=
 =?utf-8?B?eFJNM29SZ1oyaG4wUVZwZDRxaWNSenl2dm9hOUtyeFFKNVQ0Z29xRC9RajNu?=
 =?utf-8?B?SkxpQUNVTlU2NzlZdEp1TlM4aExzRUVsV2JQdENFSU1lZ1VpRVJmV3h0S2tr?=
 =?utf-8?B?cUgzbWNYOXdXUGR4VWVNSi8wR0JMODkxcWhENzhpL0tlSEhMVUdQYnJlRE5u?=
 =?utf-8?B?S25SRjhiL0NSQm9UT01aakdvZGdtc05kdTFjaTBkSFV3U3JXNHprc2ZkV1JH?=
 =?utf-8?B?Z1M5RXd1SUgranY2c2hXd3JUT2FRSHhLamcvV0wyODE5dFRtckFqWnBBdmNL?=
 =?utf-8?B?OVBSaEFVaEpIcC9SOStpb2xLYm9HbVlaWlcxVFQ2d1k2dW5ZUzQ5MVBTTDBt?=
 =?utf-8?B?NU1NZCtXWXpqNWNXdG91Q0dibE5UZkRmTXBjdTIvWGM5Yi9yUys3SVlJMEZQ?=
 =?utf-8?B?ZmpXTEFWTHlYRm8yNnBiZlh1N1hLRVo3bXV2WHZnOG1xdzFjTjFYWGRhT0tn?=
 =?utf-8?B?ZzB5UE9hK1B0UVQzaVZGQWJONm8ySUkxR01rcWJXeUMxUzc1S0gycEQ1aDNu?=
 =?utf-8?Q?1ZjPSma53k7C/ISh2u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17771328-cf11-443f-bb4f-08deb1640a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:53:55.8442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqmAH0GHdW0f0ftYeRQRwTm2JOrLYQIDy9tpB7yJ0gDvqk+Rgw8rlq9pmUmwrMG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgPHBpZXJyZS1l
cmljQGRhbXN5Lm5ldD4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTMsIDIwMjYgNToxNiBQTQ0K
PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy80XSBkcm0vYW1kZ3B1OiBhZGQgdXNlcnEgZmVu
Y2UgZW1pdCBhbmQgc2lnbmFsIHRyYWNlcG9pbnRzDQo+DQo+DQo+DQo+IExlIDExLzA1LzIwMjYg
w6AgMTU6NTQsIFByaWtlIExpYW5nIGEgw6ljcml0IDoNCj4gPiBBZGQgZnRyYWNlIGV2ZW50cyBm
b3IgdXNlciBxdWV1ZSBmZW5jZSBlbWlzc2lvbiBhbmQgY29tcGxldGlvbi4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggICAgIHwgNDgg
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAgLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnFfZmVuY2UuYyAgIHwgIDggKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3RyYWNlLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90cmFjZS5oDQo+ID4gaW5kZXggNDg0ZmJiMDAwNjhiLi5kNDIxYTQ0ZWY5MzMgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaA0KPiA+IEBAIC02
NjEsNiArNjYxLDU0IEBAIERFRklORV9FVkVOVChhbWRncHVfdXNlcnFfcXVldWVfcmVzdWx0LA0K
PiBhbWRncHVfdXNlcnFfbWFwX2VuZCwNCj4gPiAgIERFRklORV9FVkVOVChhbWRncHVfdXNlcnFf
cXVldWVfcmVzdWx0LCBhbWRncHVfdXNlcnFfdW5tYXBfZW5kLA0KPiA+ICAgICAgICAgIFRQX1BS
T1RPKHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlLCBpbnQgcmVzdWx0KSwNCj4g
PiAgICAgICAgICBUUF9BUkdTKHF1ZXVlLCByZXN1bHQpKTsNCj4gPiArDQo+ID4gK1RSQUNFX0VW
RU5UKGFtZGdwdV91c2VycV9mZW5jZV9lbWl0LA0KPiA+ICsgICAgICAgVFBfUFJPVE8oc3RydWN0
IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAqcXVldWUsIHU2NCBzZXFubywNCj4gPiArICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCBudW1fcmVhZF9oYW5kbGVzLA0KPiA+ICsgICAgICAgICAgICAg
ICAgdW5zaWduZWQgaW50IG51bV93cml0ZV9oYW5kbGVzLA0KPiA+ICsgICAgICAgICAgICAgICAg
dW5zaWduZWQgaW50IG51bV9zeW5jb2JqX2hhbmRsZXMpLA0KPiA+ICsgICAgICAgVFBfQVJHUyhx
dWV1ZSwgc2Vxbm8sIG51bV9yZWFkX2hhbmRsZXMsIG51bV93cml0ZV9oYW5kbGVzLA0KPiA+ICsg
ICAgICAgICAgICAgICBudW1fc3luY29ial9oYW5kbGVzKSwNCj4gPiArICAgICAgIFRQX1NUUlVD
VF9fZW50cnkoDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIF9fZmllbGQoc3RydWN0IGFt
ZGdwdV91c2VybW9kZV9xdWV1ZSAqLCBxdWV1ZSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgX19maWVsZCh1NjQsIGRvb3JiZWxsX2luZGV4KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICBfX2ZpZWxkKGludCwgcXVldWVfdHlwZSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgX19maWVsZCh1NjQsIHNlcW5vKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBfX2Zp
ZWxkKHVuc2lnbmVkIGludCwgbnVtX3JlYWRfaGFuZGxlcykNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgX19maWVsZCh1bnNpZ25lZCBpbnQsIG51bV93cml0ZV9oYW5kbGVzKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBfX2ZpZWxkKHVuc2lnbmVkIGludCwgbnVtX3N5bmNvYmpf
aGFuZGxlcykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKSwNCj4gPiArICAgICAgIFRQ
X2Zhc3RfYXNzaWduKA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgX19lbnRyeS0+cXVldWUg
PSBxdWV1ZTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIF9fZW50cnktPmRvb3JiZWxsX2lu
ZGV4ID0gcXVldWUgPyBxdWV1ZS0+ZG9vcmJlbGxfaW5kZXggOg0KPiAwOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgX19lbnRyeS0+cXVldWVfdHlwZSA9IHF1ZXVlID8gcXVldWUtPnF1ZXVl
X3R5cGUgOiAtMTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIF9fZW50cnktPnNlcW5vID0g
c2Vxbm87DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5udW1fcmVhZF9oYW5k
bGVzID0gbnVtX3JlYWRfaGFuZGxlczsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIF9fZW50
cnktPm51bV93cml0ZV9oYW5kbGVzID0gbnVtX3dyaXRlX2hhbmRsZXM7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICBfX2VudHJ5LT5udW1fc3luY29ial9oYW5kbGVzID0gbnVtX3N5bmNvYmpf
aGFuZGxlczsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICksDQo+ID4gKyAgICAgICBUUF9w
cmludGsoInF1ZXVlPSVwLCBkb29yYmVsbD0lbGx1LCB0eXBlPSVkLCBzZXFubz0lbGx1LCByZWFk
PSV1LA0KPiB3cml0ZT0ldSwgc3luY29iaj0ldSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgX19l
bnRyeS0+cXVldWUsIF9fZW50cnktPmRvb3JiZWxsX2luZGV4LA0KPiA+ICsgICAgICAgICAgICAg
ICAgIF9fZW50cnktPnF1ZXVlX3R5cGUsIF9fZW50cnktPnNlcW5vLA0KPiA+ICsgICAgICAgICAg
ICAgICAgIF9fZW50cnktPm51bV9yZWFkX2hhbmRsZXMsIF9fZW50cnktPm51bV93cml0ZV9oYW5k
bGVzLA0KPiA+ICsgICAgICAgICAgICAgICAgIF9fZW50cnktPm51bV9zeW5jb2JqX2hhbmRsZXMp
ICk7DQo+ID4gK1RSQUNFX0VWRU5UKGFtZGdwdV91c2VycV9mZW5jZV9zaWduYWwsDQo+ID4gKyAg
ICAgICBUUF9QUk9UTyh1NjQgY29udGV4dCwgdTY0IHNlcW5vLCB1NjQgcnB0ciksDQo+ID4gKyAg
ICAgICBUUF9BUkdTKGNvbnRleHQsIHNlcW5vLCBycHRyKSwNCj4gPiArICAgICAgIFRQX1NUUlVD
VF9fZW50cnkoDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIF9fZmllbGQodTY0LCBjb250
ZXh0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBfX2ZpZWxkKHU2NCwgc2Vxbm8pDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIF9fZmllbGQodTY0LCBycHRyKQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICApLA0KPiA+ICsgICAgICAgVFBfZmFzdF9hc3NpZ24oDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5jb250ZXh0ID0gY29udGV4dDsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgIF9fZW50cnktPnNlcW5vID0gc2Vxbm87DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICBfX2VudHJ5LT5ycHRyID0gcnB0cjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICksDQo+ID4gKyAgICAgICBUUF9wcmludGsoImNvbnRleHQ9JWxsdSwgc2Vxbm89
JWxsdSwgcnB0cj0lbGx1IiwNCj4gPiArICAgICAgICAgICAgICAgICBfX2VudHJ5LT5jb250ZXh0
LCBfX2VudHJ5LT5zZXFubywgX19lbnRyeS0+cnB0cikgKTsNCj4NCj4gQ291bGQgeW91IHJlcGxh
Y2UgdGhpcyBwYXRjaCB3aXRoIG15IHZlcnNpb24/IFRoZSBldmVudCBuYW1lcyBhcmUgbW9yZSBj
b25zaXN0ZW50DQo+IHdpdGggdGhlIGtlcm5lbCBxdWV1ZSBvbmVzIGFuZCBpdCBhbHNvIGhhcyBv
bmUgZXZlbnQgZm9yIGRlcGVuZGVuY2llcy4NCg0KU3VyZSwgSSB3aWxsIG1lcmdlIHlvdXIgcGF0
Y2ggaW50byB0aGlzIHVzZXJxIHN1Ym1pc3Npb24gdHJhY2tlciBwYXJ0Lg0KDQo+IFBpZXJyZS1F
cmljDQo+DQo+DQo+ID4gICAjdW5kZWYgQU1ER1BVX0pPQl9HRVRfVElNRUxJTkVfTkFNRQ0KPiA+
ICAgI2VuZGlmDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gaW5kZXggMzY5OTE0Y2FiNTU1Li41MGQxYzM2Mjcy
NzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vz
ZXJxX2ZlbmNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnFfZmVuY2UuYw0KPiA+IEBAIC0zMSw2ICszMSw3IEBADQo+ID4NCj4gPiAgICNpbmNsdWRl
ICJhbWRncHUuaCINCj4gPiAgICNpbmNsdWRlICJhbWRncHVfdXNlcnFfZmVuY2UuaCINCj4gPiAr
I2luY2x1ZGUgImFtZGdwdV90cmFjZS5oIg0KPiA+DQo+ID4gICAjZGVmaW5lIEFNREdQVV9VU0VS
UV9NQVhfSEFORExFUyAgKDFVIDw8IDE2KQ0KPiA+DQo+ID4gQEAgLTE2OCw2ICsxNjksOSBAQCBh
bWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX3Byb2Nlc3Moc3RydWN0DQo+IGFtZGdwdV91c2VycV9m
ZW5jZV9kcml2ZXIgKmZlbmNlX2RydikNCj4gPiAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZl
KHVzZXJxX2ZlbmNlLCB0bXAsICZ0b19iZV9zaWduYWxlZCwgbGluaykgew0KPiA+ICAgICAgICAg
ICAgIGZlbmNlID0gJnVzZXJxX2ZlbmNlLT5iYXNlOw0KPiA+ICAgICAgICAgICAgIGxpc3RfZGVs
X2luaXQoJnVzZXJxX2ZlbmNlLT5saW5rKTsNCj4gPiArICAgICAgICAgICB0cmFjZV9hbWRncHVf
dXNlcnFfZmVuY2Vfc2lnbmFsKGZlbmNlX2Rydi0+Y29udGV4dCwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVzZXJxX2ZlbmNlLT5iYXNlLnNlcW5vLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnB0cik7DQo+
ID4gICAgICAgICAgICAgZG1hX2ZlbmNlX3NpZ25hbChmZW5jZSk7DQo+ID4gICAgICAgICAgICAg
LyogRHJvcCBmZW5jZV9kcnZfYXJyYXkgb3V0c2lkZSBmZW5jZV9saXN0X2xvY2sNCj4gPiAgICAg
ICAgICAgICAgKiB0byBhdm9pZCB0aGUgcmVjdXJzaW9uIGxvY2suDQo+ID4gQEAgLTUzMCw2ICs1
MzQsMTAgQEAgaW50IGFtZGdwdV91c2VycV9zaWduYWxfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UN
Cj4gPiAqZGV2LCB2b2lkICpkYXRhLA0KPiA+DQo+ID4gICAgIC8qIENyZWF0ZSB0aGUgbmV3IGZl
bmNlICovDQo+ID4gICAgIGFtZGdwdV91c2VycV9mZW5jZV9pbml0KHF1ZXVlLCBmZW5jZSwgd3B0
cik7DQo+ID4gKyAgIHRyYWNlX2FtZGdwdV91c2VycV9mZW5jZV9lbWl0KHF1ZXVlLCBmZW5jZS0+
YmFzZS5zZXFubywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnVtX3Jl
YWRfYm9faGFuZGxlcywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnVt
X3dyaXRlX2JvX2hhbmRsZXMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG51bV9zeW5jb2JqX2hhbmRsZXMpOw0KPiA+DQo+ID4gICAgIG11dGV4X3VubG9jaygmdXNlcnFf
bWdyLT51c2VycV9tdXRleCk7DQo+ID4NCg==
