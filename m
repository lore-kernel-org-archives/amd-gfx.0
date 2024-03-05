Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6981C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 19:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6257D10E47C;
	Tue,  5 Mar 2024 19:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QAn4lWPP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6EF10E47C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 19:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnmy+4lRr2x4FGdZVhnuajS8cDMQZ3aiGJiKnX0b6fX9wgrphMXHp77Z2ePFKNz0NaXcCvSLGXtaph0ueN+FQnOEuu4n7/9SFsLFJB3GZufFOxZTOf3yq0NXCeRvTLTtDwuzPtidzJ7qU3cLYLE3ex4A4GCWgRwBO/5N1/wKPyXKb4GSNgRWR8U3GeSshSc3DZWsVQRiKDr3hfkBwdP5mFBUtMNvHdrBJNnmaxCCWHn8v6ckqJrw0MeVQhus9a+dGl7Frvdh+xIlTEWMux/Uuefg8pd5HLZYc1OLRtOk1WPqpjhlWdHixMaG3wr8JydZpI1Is7HLSmWIumALXS3zLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qleSSdgyhkzlcsqJ1EBJenUHVTu6w5ARoDqKm5ub1U=;
 b=lXQ/90AYwflGxvtzLsAKJd6J2qRFDTbzh/0WcwjgO8XgKT1S6oOuhsHIyQJ7UIy9QkzRfMjvh7MZVg/eihsQi/qa9uL5GxOWy3syQX6SlnAc1qwsJlpKDsdgQyHAfrhztE09VnslWPABL21SrBlpaClC74QPE/ak27nw9P5KBN5VmGQK07dGnefzfS3tE9Vu15ChLTN1Dt46tJUmgSLkTiaJttvma3octy1t7AohNBNs7sM5lyPUDUGQ4MlBVHJvr1dqiTBzHd7dc4oCNmFokcgvyz6Bc5v8tc/oZw9rK2ZRGkIiATE8sWz1WtLb7A+IvvI48QLx7N31iQjMqfmLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qleSSdgyhkzlcsqJ1EBJenUHVTu6w5ARoDqKm5ub1U=;
 b=QAn4lWPPBaKm10TI0pL9nvyq8h4nYOllpQ/Vaxt4mR5cMWfyqIbZHG29bPtnOIghV5M7GN1e5eBwJQcH8BuChxPGJ8nZsSjLyTctR/mPz9u/oP+6cpgP2yrgET1kOLuR/5FxVuyQQo1zL4BeC/JPGOUdXG1LxILODa0L3/QUEIc=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 19:49:01 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::e16:1e31:7c17:75cd]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::e16:1e31:7c17:75cd%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 19:49:01 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: sdma support for sriov cpx mode
Thread-Topic: [PATCH 2/3] drm/amdgpu: sdma support for sriov cpx mode
Thread-Index: AQHabkdsVbdkxNpKxUigM2UtcvrdYbEoP+2AgAFNllA=
Date: Tue, 5 Mar 2024 19:49:01 +0000
Message-ID: <MW5PR12MB56002CED0987A31B15225044E6222@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <20240304151931.802397-1-samir.dhume@amd.com>
 <20240304151931.802397-2-samir.dhume@amd.com>
 <5958ccab-35a1-4802-be50-77e9a7d80c10@amd.com>
In-Reply-To: <5958ccab-35a1-4802-be50-77e9a7d80c10@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4396f40a-2c85-4929-b171-d1578e9f5921;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-05T19:40:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|DS0PR12MB7510:EE_
x-ms-office365-filtering-correlation-id: 57ab93ea-4c8a-4bef-e727-08dc3d4d4e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlzmymtWTzmECHOfSq4H5OgP5LLdzmm82GX26wcpH0hz3Id4cTrMWhQ2TvpJWltfoc9/p8/mOmaheYguyiC88rsoxYu+smYojMd/ljq2osSOlM4g7wbMvEG3Aixpui8t3gtXDrMTbWWRkb9yGwyRqzhZ53DPP3YzfgPj5+J2//IrpiYvkQWcSGZhUXga+6xF/PVoZvAepg+vqdTcz/ouSpwI9MdsLY9U66W4MSgt1cgwTZN+d4FA4/my+LH0WFzfFbOh/I8h0wTBKJoI+jPWY01g0wIc4AXOLnxHRHGSzwc0YIZBVwYOjPdlgj3ByPhpd1t3o0mYD3BKDkXNyUB0KTJInVGqYiUT2BB70eTdUxatt/+ifSrCRBNQ4LAD+LlMMP/yqHRQlzI59D88+t39I3H40+qf0FJAfyGm/rr3CFrz0Jzbh0rH1GbznJ1U+RhXKS969iU3cCJFHV44P3aBukx5AqM+AIkGUmAYHkb/tV8QJHhY/KQkOJPH8S8mN6K4a8nX/VpYju+yN17GEJ+Nqhb/g7LSDqOB4DX0V4KJSFeCCQDsTxCstMv/fyUbZYEy/rC3sXlYZg0+SnI62CBx5JsStpj1rVbxknvTnCqdUUq3gWgypLDxkeojSy2rXDlDA2H0+Dgg2wgqSFNKnKCEwPVau+5UWrjoVdy2w2uZKZm6QfZsuOCAvv48fQPjIwQyOL5tYmLDN67VfJ4t1qQSxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nld4bzY5cklCOEdPeXJFY2dZemdFdDZva3dCKzk5bnRlSUNyV2cvZXhiZ3pN?=
 =?utf-8?B?YU15eDllNHBFRC9ZWDdIcENuRDFpcGVoRzZYK1RSeHRFbCsra3FjbURIUTRj?=
 =?utf-8?B?ZkJnUzEvZEpDYnp1bWRBNWg2dkI5OFgySStFWHZ2NWRuTGxZUExMNXJmSXRN?=
 =?utf-8?B?Ri9ldDBDV1dxM3R1OThnNGlJWFhHWE01Tk04REMyaFVBR0hNS2Y1SUF6YldE?=
 =?utf-8?B?MXpsdm9zMTBrSDRNZmFjNTZjbjMxTmp5YUJ4ck1RdGJUN09WcnJKbEJFdEVQ?=
 =?utf-8?B?M013ZFJEMjB5OWt3RFhHT0VmK280aWc2WGlrbHdIb2xPUys1VUF1Sk5EYUgx?=
 =?utf-8?B?YXlQV1pZV01qUlA2UG12Y2pULzAvcGVNdzdSVTFRVmpGajRpVWZ1alV1b0VJ?=
 =?utf-8?B?MkxjSTdYaFAyalcwdmMyZUZFWjBWem5CamR2WGRkZU9zNUhHTXZhclVSODhX?=
 =?utf-8?B?d1pPK0RKbjRyN0VCczdURk9WR280Skl2OGhNMnV1cWxwVCsvOGFiU1ZtTmVW?=
 =?utf-8?B?dlZvZTMvTGFyQ083SmpQUWRtWjFEN0FEWmNxNVc2VldpUSt0bXArdGlhUjdY?=
 =?utf-8?B?M1YwRWdOd0hrZ1FBbTExR29XNHFsMjBjK1o4ZUQwN09NWGRGa2dTY21Ybjds?=
 =?utf-8?B?Nk16WXU2YnNiSjdtaUtmTkJCSjR4YkNpUjhmbzU2N0xOMEdLa0t4L1NHRTgz?=
 =?utf-8?B?Y2F4TnpmSG1aZWF5TUpZUHgzSHZYNy9TUStpRlhQM3R3YjN2TE85aXYxSHY2?=
 =?utf-8?B?TE9FWTFGSnUwR0t5RzRlZlc0bXE4d0Z2N0pJUjBWcVVDYlU3N0ZwcG5QeDVm?=
 =?utf-8?B?dmJZb0VycUQ5WFoxd1JuS3daanRjSTRxbzdFaWtWYStwWWxoZ1M3ZU1yVnM1?=
 =?utf-8?B?cmxaUTFqS21EUXFqbS9XRU00eitIaGtnTGR0TlZDSFZCaXBabkYrMllnZjBx?=
 =?utf-8?B?bWhiZTdHalVGYWZqdHFFZzBGRnQyV0ExODNQQkZLT0hLckE2U2JINkg1M3Jy?=
 =?utf-8?B?L2ZEWGV0V3BBaTBWRUt3aUN3VUFHZ1djb3ZNSzhZZDgxZXlYaS9KYXVLL1NM?=
 =?utf-8?B?d2x4VWNrZm44c2o2MUhoOGpWdDNQUVBjRitBeDlJTXZibzNCaFZBS3JWOGxH?=
 =?utf-8?B?d0d1S2Rvb1JzemRuVG9kT1MyckZqMHU2NE9nYnZQV25jekFJV3FWYWJjY1Q3?=
 =?utf-8?B?OStKSGswcUpoMk8zczZHK3F0aXBlNGwwMzFvckQrNS9tY3BFMHBJTGxUREdz?=
 =?utf-8?B?QmlhbWNrSWJZY2hOQ214MUlvY0hSQUJTckxFZ3loNGJHUVZJSXRQYWF1ejBv?=
 =?utf-8?B?VDRUbGV2Sk5MQTVLTE9abUlud3VGazBhTzAvZ2lRZGVBZXBwRnlTeDZBclhC?=
 =?utf-8?B?RjA5M0NzQ0ZuU2E5M2lpUllWNFRDTUlDalBaVDB5VlQrbmdMNEJCZlU4L2Vx?=
 =?utf-8?B?YzI3ZElKa1IxcHBYWTZieW1JUStySVQxYzBHYmVxNHhPdjM0L1UwTW5PU1Bi?=
 =?utf-8?B?YUVHR08yRllKcTF5blg3dmlxV29BTGxXMXpxUy8xWmdUbmg2dVZHK0lHQ2ky?=
 =?utf-8?B?eERLUE04TjUybFlOTTl1OFQvUVpyWkFVRWFzU2JORkJmN05GNTZNTGZkRUtE?=
 =?utf-8?B?T1JUWFJ3bXpWTEZadlpQbjFTWDNteit3c0NmSTdESHcyd0VUUVVvK05LVTlF?=
 =?utf-8?B?QUpObFZ5dG1uWGEyT1dXZFg3ci81RjdDQ09lUXRVK3VEV0cwcnhMVCtkQk9G?=
 =?utf-8?B?c21qQk54RUtxMitKSkZ0YW8zb0REcEZTRWs2bTRDb1htWDloM0lZd1FkSmRh?=
 =?utf-8?B?aDhXaStQQStVVFhpNU5FcGY0MlFHYXlMaUtXNHlRVVhhcE5MU1g5MXNIQ05E?=
 =?utf-8?B?MGo0N0lLMWNFY0t3NnZXRldNdDVhcnVxKzIyc0k2YW1yV1c3L3dxMnBJWUs4?=
 =?utf-8?B?MTNWNGdrbmFmZmJVb25udWVNVFFUZng4SER6eXFEcVRJUmlpTElkdUZaa2Vy?=
 =?utf-8?B?SXB6Um13a1dtWjRyZUJEbk9tY2R0Qm1hazV6MDJXR1ZtV2FqeVN2RDNySm9M?=
 =?utf-8?B?WGg4bjQ4Q2dZTG1BZytoMTBtTjZTMVVCSk1PcFBTeDNwdG1UbUozQ0VZdE5n?=
 =?utf-8?Q?13oA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ab93ea-4c8a-4bef-e727-08dc3d4d4e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 19:49:01.5837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ragfmyTEZ9HmcsJW55uzbkTAwCz2rk8/OSZM4AYO1Xqbu1N4O7UtqvRFKhPfXXeU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDQsIDIwMjQgNjo0NyBQTQ0KPiBUbzogRGh1bWUsIFNh
bWlyIDxTYW1pci5EaHVtZUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBXYW4sIEdhdmluIDxHYXZp
bi5XYW5AYW1kLmNvbT47DQo+IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+OyBEZXVjaGVyLCBB
bGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMi8zXSBkcm0vYW1kZ3B1OiBzZG1hIHN1cHBvcnQgZm9yIHNyaW92IGNweCBtb2RlDQo+
DQo+DQo+IE9uIDIwMjQtMDMtMDQgMTA6MTksIFNhbWlyIERodW1lIHdyb3RlOg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNhbWlyIERodW1lIDxzYW1pci5kaHVtZUBhbWQuY29tPg0KPg0KPiBQbGVhc2Ug
YWRkIGEgbWVhbmluZ2Z1bCBjb21taXQgZGVzY3JpcHRpb24gdG8gYWxsIHRoZSBwYXRjaGVzIGlu
IHRoZSBzZXJpZXMuDQo+IFNlZSBvbmUgbW9yZSBjb21tZW50IGJlbG93Lg0KDQoNClJpZ2h0IQ0K
DQo+DQo+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0
XzRfMi5jIHwgMzQNCj4gKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzRfMi5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF80XzIuYw0KPiA+IGluZGV4IGZlYzVhM2QxYzRi
Yy4uZjY2NmVjZWNiZTdkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NkbWFfdjRfNF8yLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
ZG1hX3Y0XzRfMi5jDQo+ID4gQEAgLTgyLDE3ICs4MiwzNyBAQCBzdGF0aWMgdW5zaWduZWQgc2Rt
YV92NF80XzJfc2VxX3RvX2lycV9pZChpbnQNCj4gc2VxX251bSkNCj4gPiAgICAgfQ0KPiA+ICAg
fQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQgc2RtYV92NF80XzJfaXJxX2lkX3RvX3NlcSh1bnNpZ25l
ZCBjbGllbnRfaWQpDQo+ID4gK3N0YXRpYyBpbnQgc2RtYV92NF80XzJfaXJxX2lkX3RvX3NlcShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gdW5zaWduZWQgY2xpZW50X2lkKQ0KPiA+ICAg
ew0KPiA+ICsNCj4gPiArICAgc3RydWN0IGFtZGdwdV94Y3BfbWdyICp4Y3BfbWdyID0gYWRldi0+
eGNwX21ncjsNCj4gPiArICAgYm9vbCBzcmlvdl9jcHhfb2RkID0gZmFsc2U7DQo+ID4gKyAgIGlu
dCBtb2RlOw0KPiA+ICsNCj4gPiArICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KPiA+
ICsgICAgICAgICAgIG1vZGUgPSB4Y3BfbWdyLT5mdW5jcy0+cXVlcnlfcGFydGl0aW9uX21vZGUo
eGNwX21ncik7DQo+DQo+IFRoaXMgcXVlcmllcyBhbiBNTUlPIHJlZ2lzdGVyIGZvciB0aGUgY3Vy
cmVudCBtb2RlLiBJcyB0aGF0IHJlYWxseQ0KPiBuZWNlc3NhcnkgdG8gZG8gaW4gdGhlIGludGVy
cnVwdCBoYW5kbGVyPyBDb3VsZCB3ZSB1c2UgdGhlIHBhcnRpdGlvbg0KPiBtb2RlIHN0b3JlZCBp
biB4Y3BfbWdyLT5tb2RlIGluc3RlYWQ/DQoNClRoZSBkZXNpZ24gYXBwZWFycyB0byBiZSB0aGF0
IGV2ZW4gd2hlbiB0aGUgaG9zdCBzZXRzIHRoZSBtb2RlIHRvIERQWC9RUFgvQ1BYLCBlYWNoIGd1
ZXN0IHNldHMgaXRzZWxmIHRvIGJlIGluIHRoZSBTUFggbW9kZSBhbmQgeGNwX21nci0+bW9kZSBp
cyBzZXQgdG8gU1BYLg0KQnV0IEkgY2FuIHVzZSBhIG5ldyBmaWVsZCBpbiB4Y3BfbWdyIHRvIHJl
ZmxlY3QgdGhlIHN5c3RlbSBtb2RlIHNldCBieSB0aGUgaG9zdCBhbmQgcmVtb3ZlIHRoZSBNTUlP
IGFjY2VzcyBmcm9tIHRoZSBpbnRlcnJ1cHQgaGFuZGxlci4NCg0KVGhhbmtzLA0Kc2FtaXINCg0K
Pg0KPiBSZWdhcmRzLA0KPiAgICBGZWxpeA0KPg0KPg0KPiA+ICsNCj4gPiArICAgICAgICAgICBp
ZiAobW9kZSA9PSBBTURHUFVfQ1BYX1BBUlRJVElPTl9NT0RFKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICBpZiAoYWRldi0+Z2Z4LmZ1bmNzLT5nZXRfeGNjX2lkKGFkZXYsIDApICYgMHgxKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzcmlvdl9jcHhfb2RkID0gdHJ1ZTsNCj4g
PiArICAgICAgICAgICB9DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gICAgIHN3aXRjaCAoY2xpZW50
X2lkKSB7DQo+ID4gICAgIGNhc2UgU09DMTVfSUhfQ0xJRU5USURfU0RNQTA6DQo+ID4gICAgICAg
ICAgICAgcmV0dXJuIDA7DQo+ID4gICAgIGNhc2UgU09DMTVfSUhfQ0xJRU5USURfU0RNQTE6DQo+
ID4gICAgICAgICAgICAgcmV0dXJuIDE7DQo+ID4gICAgIGNhc2UgU09DMTVfSUhfQ0xJRU5USURf
U0RNQTI6DQo+ID4gLSAgICAgICAgICAgcmV0dXJuIDI7DQo+ID4gKyAgICAgICAgICAgaWYgKHNy
aW92X2NweF9vZGQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiArICAg
ICAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1cm4gMjsNCj4gPiAgICAg
Y2FzZSBTT0MxNV9JSF9DTElFTlRJRF9TRE1BMzoNCj4gPiAtICAgICAgICAgICByZXR1cm4gMzsN
Cj4gPiArICAgICAgICAgICBpZiAoc3Jpb3ZfY3B4X29kZCkNCj4gPiArICAgICAgICAgICAgICAg
ICAgIHJldHVybiAxOw0KPiA+ICsgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAg
ICAgIHJldHVybiAzOw0KPiA+ICAgICBkZWZhdWx0Og0KPiA+ICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPiA+ICAgICB9DQo+ID4gQEAgLTE1NDEsNyArMTU2MSw3IEBAIHN0YXRpYyBpbnQg
c2RtYV92NF80XzJfcHJvY2Vzc190cmFwX2lycShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRl
diwNCj4gPiAgICAgdWludDMyX3QgaW5zdGFuY2UsIGk7DQo+ID4NCj4gPiAgICAgRFJNX0RFQlVH
KCJJSDogU0RNQSB0cmFwXG4iKTsNCj4gPiAtICAgaW5zdGFuY2UgPSBzZG1hX3Y0XzRfMl9pcnFf
aWRfdG9fc2VxKGVudHJ5LT5jbGllbnRfaWQpOw0KPiA+ICsgICBpbnN0YW5jZSA9IHNkbWFfdjRf
NF8yX2lycV9pZF90b19zZXEoYWRldiwgZW50cnktPmNsaWVudF9pZCk7DQo+ID4NCj4gPiAgICAg
LyogQ2xpZW50IGlkIGdpdmVzIHRoZSBTRE1BIGluc3RhbmNlIGluIEFJRC4gVG8ga25vdyB0aGUg
ZXhhY3QgU0RNQQ0KPiA+ICAgICAgKiBpbnN0YW5jZSwgaW50ZXJydXB0IGVudHJ5IGdpdmVzIHRo
ZSBub2RlIGlkIHdoaWNoIGNvcnJlc3BvbmRzIHRvIHRoZQ0KPiBBSUQgaW5zdGFuY2UuDQo+ID4g
QEAgLTE1ODQsNyArMTYwNCw3IEBAIHN0YXRpYyBpbnQNCj4gc2RtYV92NF80XzJfcHJvY2Vzc19y
YXNfZGF0YV9jYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgaWYgKGFtZGdw
dV9yYXNfaXNfc3VwcG9ydGVkKGFkZXYsIEFNREdQVV9SQVNfQkxPQ0tfX1NETUEpKQ0KPiA+ICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+DQo+ID4gLSAgIGluc3RhbmNlID0gc2RtYV92NF80XzJf
aXJxX2lkX3RvX3NlcShlbnRyeS0+Y2xpZW50X2lkKTsNCj4gPiArICAgaW5zdGFuY2UgPSBzZG1h
X3Y0XzRfMl9pcnFfaWRfdG9fc2VxKGFkZXYsIGVudHJ5LT5jbGllbnRfaWQpOw0KPiA+ICAgICBp
ZiAoaW5zdGFuY2UgPCAwKQ0KPiA+ICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+DQo+ID4gQEAg
LTE2MDMsNyArMTYyMyw3IEBAIHN0YXRpYyBpbnQNCj4gc2RtYV92NF80XzJfcHJvY2Vzc19pbGxl
Z2FsX2luc3RfaXJxKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+DQo+ID4gICAgIERS
TV9FUlJPUigiSWxsZWdhbCBpbnN0cnVjdGlvbiBpbiBTRE1BIGNvbW1hbmQgc3RyZWFtXG4iKTsN
Cj4gPg0KPiA+IC0gICBpbnN0YW5jZSA9IHNkbWFfdjRfNF8yX2lycV9pZF90b19zZXEoZW50cnkt
PmNsaWVudF9pZCk7DQo+ID4gKyAgIGluc3RhbmNlID0gc2RtYV92NF80XzJfaXJxX2lkX3RvX3Nl
cShhZGV2LCBlbnRyeS0+Y2xpZW50X2lkKTsNCj4gPiAgICAgaWYgKGluc3RhbmNlIDwgMCkNCj4g
PiAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+IEBAIC0xNjQ3LDcgKzE2NjcsNyBAQCBz
dGF0aWMgaW50IHNkbWFfdjRfNF8yX3ByaW50X2l2X2VudHJ5KHN0cnVjdA0KPiBhbWRncHVfZGV2
aWNlICphZGV2LA0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X3Rhc2tfaW5mbyB0YXNrX2luZm87DQo+
ID4gICAgIHU2NCBhZGRyOw0KPiA+DQo+ID4gLSAgIGluc3RhbmNlID0gc2RtYV92NF80XzJfaXJx
X2lkX3RvX3NlcShlbnRyeS0+Y2xpZW50X2lkKTsNCj4gPiArICAgaW5zdGFuY2UgPSBzZG1hX3Y0
XzRfMl9pcnFfaWRfdG9fc2VxKGFkZXYsIGVudHJ5LT5jbGllbnRfaWQpOw0KPiA+ICAgICBpZiAo
aW5zdGFuY2UgPCAwIHx8IGluc3RhbmNlID49IGFkZXYtPnNkbWEubnVtX2luc3RhbmNlcykgew0K
PiA+ICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAic2RtYSBpbnN0YW5jZSBpbnZhbGlk
ICVkXG4iLCBpbnN0YW5jZSk7DQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo=
