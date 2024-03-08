Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB968C54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 17:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4A810F35A;
	Fri,  8 Mar 2024 17:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v2NqLRau";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EDC10F2F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 17:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBrQqXHXoKyECabpk6d/3QEGFAbeGNVcfwKVjawyB3Oz11rkWKJf6slNwf8NDG0mdc8nVYG7GLeE+gcI7AbhYPRdZ3vpbcqbO/vAD/QJjpCJo0Cw9OuYlioZEeF7jMApys6hPVuaQJ14u+6jZkHCbqZoIXF/angDokyXo41hFCSikfUCXWcusrHlyTC8qZTGwhicnRA5ljCPUkLJ7kzX+Z/Zeo0Umpd7Zb0gpLTxjl2jxq7sttk5OOr8kdmp9kVCsiJwNMcSsxy0pStbNxlmi3H+1Eerw//LFYQB6iK1G4T5alxbodqjqZO9se2c6g3iNdSq/Yz3YTJiNEtVKDFZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87WHYwxTB1r36fyM29+79hzsNqnwNjSnEkjDAhKySFY=;
 b=J47OxNMO4ju0VGFInYNJTlqlSedQASNhze2aKOxp3sBSH2oyv5q2buw4I5N0dDyKt957OQO9oCtPtArjx/6WT0CR4v1viGWB0kZnuuXv7trPl0bMDkq6xKS9RUwYhp01R8WILwGDDLUTuLsyZXteixyKGaALrXnXo8crXW2nJWIjbYt+antqIO2iGsYAI0/7/gLz0wEVZgMeDyDTkl8FeM05whfFZVaoz248LTJClHLBQ6oRuvK1WGxzsHi1dF1qxE+QFkymFIPI2WgCZCuUnieKsLoepvnXlapR+Wbk/+BQSiZUqjrubRIg4itp8S3HdwuF704nojWVnpXjgT2vcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87WHYwxTB1r36fyM29+79hzsNqnwNjSnEkjDAhKySFY=;
 b=v2NqLRaupVRBCi8CLtA/56Zno8J9fIg2DDFme9X6bw8mhZMmBzhXWSetIIVDxjx4FdiUWNWUPW99l7m4Hv3nXQ3KKFbYFm7mPyUv/ch0kyYNjs2clXOY2PuBKjwB1RhOC9d8UulY8J28acjmPJe5qjG0RfGmurIobrmAKv0K/JA=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 17:35:00 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 17:35:00 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Thread-Topic: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Thread-Index: AQHacXToxD1WfV5D80+X2y/tzgqIYbEuDdeAgAAM+bA=
Date: Fri, 8 Mar 2024 17:35:00 +0000
Message-ID: <BL3PR12MB64257095D285EA394AC30CC9EE272@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240308162253.264154-1-mukul.joshi@amd.com>
 <b9b7b00d-57e9-4d35-a713-f922f5e19402@amd.com>
In-Reply-To: <b9b7b00d-57e9-4d35-a713-f922f5e19402@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2a261b59-d3e4-4281-b15a-abeba36aa302;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-08T17:34:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DM6PR12MB4121:EE_
x-ms-office365-filtering-correlation-id: 613acb4c-286a-4da5-905c-08dc3f96147c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPrA/FFnojnbDzHEZXZl5SevyHyRZMZxjmdNMHIARnqQegEXjo9GeMwX0gpBYdQRUJIeSQ5GbmZshDfCwRzxbwwj4HmeVOklWPM7A8c+L6gDBpMHGAJoEvTbbGtZad+5HLU0fiUSRecwkKPOpLBJRq6xe+FZyISUOlLBx98DVYYl0x0F4QXgh0E7HyDsvleCeGF/T9UPlL0rcuYptdzcJ/umFjty2xng1goAPSIt/u85q6onllo2RTh0spCJxx7w+FcX79IIoKpt5E2Qosu0+xXo1NJFsawKGdCK1XyB+lKtSlmZLsbnxq8ryZpKfP4ITFZ99XwJIvYoyeHlLAbxA0I4d9NXLa+JK9bBRLnqqtStpAejx5CD0u7mVUaHL/tjiDsd+ioOrLl/lJWq/ogS4lyzd5Rp68xV+S+UEsEo/WhbgqzjFjvb2VzlzHIhEBg0v9rxBltcJGpV4rLJovoRnptd3OXauwELu87NYvalSyM1iE4GuWvcx9T4I1E6gvewxgWNDghKPfofbrROgARdwN8muM5fofTB4npcsd/3DtY8DGqi2KHWVgqwQkX+xmb0jUw+UAWiHtY4IxUf1XpwxZSvozsNE9zRgFdTyZxpTw+CG9CXpB7/lYJ6gAQUgICuwRnmvyzM2wHyGSfwZkVxJ9emEn9kVxsqH55N9poPkPXWSluoF0quOgl6+5G3SZwzDuuS54xLCSY00BuSGxAU5ckiEvcpEENdiTqQEdIjD9Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2o3aDVFdmRJNDNUZ1F0TGw4eXhaWVUwQnlXQkZTY1JxRVJ6eGpzL3c5OXEz?=
 =?utf-8?B?QnhGMXEzWEwvMVhKT0FUUzZPNS90Vmd1YTAvcDJJUzNOOU43TXlMOEhzUmZn?=
 =?utf-8?B?STlBLzg5Q05FWWpHcUxLZTRPSU9KK2V0Q2hXL3VlZ1lkUWptdFdaWldvZy84?=
 =?utf-8?B?bmhDNGhwUU9CYU9IZHh4VHFpY1FiY3dRTmFXanBaK2V4NTVwM1J6ZUNIeWlN?=
 =?utf-8?B?bzVZb2JhbEZWTVJnNFJmdDVsWFFxSFMycWNEVDByYjZVMERRZzF1MWI1TnRL?=
 =?utf-8?B?S0JxcWpNRE16b2ovcThhNXoxa3hlRUY1KzhOQ0Mvc0ZQcUQzRzl1Z2JWMnJw?=
 =?utf-8?B?a0NmaGZWamJEakRkNDZoeTQ0VFVScDRMc2R2KzhES3VyYUY4aGpFRnV0VEcy?=
 =?utf-8?B?anRBVDdqTHh4RFFFQUlYT2c3RGFrVTZGN2VTWkVxNkhHaG5UR05QclBFekpq?=
 =?utf-8?B?dHo1eUFQOVhSUnhoUm9Gamp5cVB5czkvUE1rSWtsb0pBTHY4VjlMd0NmUVRr?=
 =?utf-8?B?Z3BNaElSUVI2Sm5zKzEyTjBJdU1SWWhQS3lPeEtUdmJZL3N5bWwwMS9zb1Uz?=
 =?utf-8?B?MXVtbDV0UThkMTFXaDNMME9COE4rUnVLV0c1MW1JblNtRHF6d21IWGhnZENm?=
 =?utf-8?B?Ukd4WEdrNjdBamtJYk5PdXp6WUdXRmJhT3NWNEZHREFlVjh0ZzRSOW1vOUxN?=
 =?utf-8?B?UVJQaHFSRGxNOTE2TzBCb21naEVhdVFtSTgyazdMdk9ueU1xc2dhQU1OK20v?=
 =?utf-8?B?bXhXOVJidUJXNjZGNFZVZVh6a1VPeU1MU3pKWCtFKzYrUFF4UmdXbUFjV3Rz?=
 =?utf-8?B?cTdzSFVnOFJMUlBReEp3aUEvYTZ5SDhycFdidENSMkpSa2F6UWhPN29TMVZv?=
 =?utf-8?B?aGJ0ZGFadXdmeGZKTTZycXlETmNsemtUUjNscEQwNVA4N1JPVUZOblVtYnow?=
 =?utf-8?B?MUU5MWphRXlUNzdYTXJEd2ZDNFhoMkNTRFVKczhUakVWTURHTkIzejRVKzdq?=
 =?utf-8?B?dm9oYWZGTVJ4cHVBNGwzNHRYcTBLRWppenF3cHVMZGFSTDVVMzVoUGJKSUxo?=
 =?utf-8?B?dy9WNTU4VVIwZmIxNldXbXdaS3BlZUJqOTRRYkhNQ1J3dFhjQTRMWWpNeTYz?=
 =?utf-8?B?YSs3UDdGZFRKdUUrbkJzNXFMWWZZRTNiU0JHQVdBTkdmRExHU1BDb2lvWWFI?=
 =?utf-8?B?ZUF2UGhoc2FhZVB5UEVFWENEdExKNkRJaFBNT2JPUHViSFU1ZHlvRmIzTlZp?=
 =?utf-8?B?WUN1QXZJL2xmenF5SE9KekZrOVVyYVdJUENnUXgyZC9LVFk0MGMwdTk4cWxO?=
 =?utf-8?B?VXNFSUxsaUd1V1ZrLzFsYXZGQWh3Z1RtZk10eURLWStZdHc0V0J0UG9qK0JZ?=
 =?utf-8?B?eWl0K3VTUXlWanF0ZSswNnBLemRlOXV5Sjl4SGtLNzJ4TWg1WjVOUmoxeHpT?=
 =?utf-8?B?S2V0M1hCYkdXbnkxT0NrRW4zekRTeEYyaEZPYUduV2hUQVcyd05ic1lWYnFW?=
 =?utf-8?B?TnVvSmxPZ1FMSmVqTzJqYW00NkdvK3ZiMnRvUEZ1SE5ETTRpN1hESWc1MUxD?=
 =?utf-8?B?TjRDZGdXNFQzY2wyV2NHbzBaWGJkUDUvV0o1SXNqc25xMmFhSzJmajRnc014?=
 =?utf-8?B?S2s4K2J5N3A2cHp4d3ZXMllsTEZyQVNJak5xZ21GWElKNmdzOXpZenB2cU5N?=
 =?utf-8?B?NzRvVW1PeXVIVkk3NlNEVGxFSE5sUnVjNVhsU2hpdnlPcjVoaDZzNTM4Ly9o?=
 =?utf-8?B?d3dIWmQxU1I1UkVXY0FaOEpoWDdtSk9OMldEb2VWUEJiZW9NbDZtNFhNNUhl?=
 =?utf-8?B?NVZJSENMZjVkMlBEYlVJWmc1QnZRZGF1SGNEZ3FoQSsyc3g4RnRsTTdnQjBG?=
 =?utf-8?B?dFNMeFJoWkJ6OS9TOHBVVDFwMysyd2FxZ29BVVpkc1NaVDYzRVlodmZPQloy?=
 =?utf-8?B?R3Nwc1dNSjI3Q1ZBSFFBSDFJaDEvcnB3WjEwYisvTU9rSnp6bVYzVmUzc2I0?=
 =?utf-8?B?RzNRaVF6SS9nTUN4ZHhNbmtCQkduWTZ1d0E0T3d5TVlldEE2eC8wUTVRSURh?=
 =?utf-8?B?OGVTMkFoSnB1QjFRWmh4MmNaYmU5OEYwNlBpa1JUbmdrNGQyV2V1SXpGR1lE?=
 =?utf-8?Q?Fi6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613acb4c-286a-4da5-905c-08dc3f96147c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 17:35:00.0992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdG8r1pAs2og4x2jKfb9F7JL9PLEbV6F82paB6jSavSFUqRdwbruv/M+p8gWap5u1oCLenB21T3IAsxUcMeTQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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
Pg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDgsIDIwMjQgMTE6NDggQU0NCj4gVG86IEpvc2hpLCBN
dWt1bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEhhbmRsZSBkdXBsaWNhdGUgQk9z
IGR1cmluZyBwcm9jZXNzDQo+IHJlc3RvcmUNCj4NCj4gT24gMjAyNC0wMy0wOCAxMToyMiwgTXVr
dWwgSm9zaGkgd3JvdGU6DQo+ID4gSW4gY2VydGFpbiBzaXR1YXRpb25zLCBzb21lIGFwcHMgY2Fu
IGltcG9ydCBhIEJPIG11bHRpcGxlIHRpbWVzDQo+ID4gKHRocm91Z2ggSVBDIGZvciBleGFtcGxl
KS4gVG8gcmVzdG9yZSBzdWNoIHByb2Nlc3NlcyBzdWNjZXNzZnVsbHksIHdlDQo+ID4gbmVlZCB0
byB0ZWxsIGRybSB0byBpZ25vcmUgZHVwbGljYXRlIEJPcy4NCj4gPiBXaGlsZSBhdCBpdCwgYWxz
byBhZGQgYWRkaXRpb25hbCBsb2dnaW5nIHRvIHByZXZlbnQgc2lsZW50IGZhaWx1cmVzDQo+ID4g
d2hlbiBwcm9jZXNzIHJlc3RvcmUgZmFpbHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNdWt1
bCBKb3NoaSA8bXVrdWwuam9zaGlAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDE0DQo+ICsrKysrKysrKyst
LS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dwdXZtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYw0KPiA+IGluZGV4IGJmOGU2NjUzMzQxZi4uNjVkODA4ZDhiNWRhIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYw0KPiA+IEBAIC0yODY5LDE0ICsyODY5LDE2IEBAIGludA0KPiA+IGFtZGdwdV9h
bWRrZmRfZ3B1dm1fcmVzdG9yZV9wcm9jZXNzX2Jvcyh2b2lkICppbmZvLCBzdHJ1Y3QgZG1hX2Zl
bmNlDQo+ID4gX19yY3UgKg0KPiA+DQo+ID4gICAgIG11dGV4X2xvY2soJnByb2Nlc3NfaW5mby0+
bG9jayk7DQo+ID4NCj4gPiAtICAgZHJtX2V4ZWNfaW5pdCgmZXhlYywgMCk7DQo+ID4gKyAgIGRy
bV9leGVjX2luaXQoJmV4ZWMsIERSTV9FWEVDX0lHTk9SRV9EVVBMSUNBVEVTKTsNCj4gPiAgICAg
ZHJtX2V4ZWNfdW50aWxfYWxsX2xvY2tlZCgmZXhlYykgew0KPiA+ICAgICAgICAgICAgIGxpc3Rf
Zm9yX2VhY2hfZW50cnkocGVlcl92bSwgJnByb2Nlc3NfaW5mby0+dm1fbGlzdF9oZWFkLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm1fbGlzdF9ub2RlKSB7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICByZXQgPSBhbWRncHVfdm1fbG9ja19wZChwZWVyX3ZtLCAmZXhlYywg
Mik7DQo+ID4gICAgICAgICAgICAgICAgICAgICBkcm1fZXhlY19yZXRyeV9vbl9jb250ZW50aW9u
KCZleGVjKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShyZXQpKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KHJldCkpIHsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcHJfZXJyKCJMb2NraW5nIFZNIFBEIGZhaWxlZCwgcmV0OiAlZFxu
IiwgcmV0KTsNCj4NCj4gcHJfZXJyIG1ha2VzIHNlbnNlIGhlcmUgYXMgaXQgaW5kaWNhdGVzIGEg
cGVyc2lzdGVudCBwcm9ibGVtIHRoYXQgd291bGQgY2F1c2UNCj4gc29mdCBoYW5ncywgbGlrZSBp
biB0aGlzIGNhc2UuDQo+DQo+DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
dHRtX3Jlc2VydmVfZmFpbDsNCj4gPiArICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAg
ICAgICB9DQo+ID4NCj4gPiAgICAgICAgICAgICAvKiBSZXNlcnZlIGFsbCBCT3MgYW5kIHBhZ2Ug
dGFibGVzL2RpcmVjdG9yeS4gQWRkIGFsbCBCT3MgZnJvbQ0KPiA+IEBAIC0yODg5LDggKzI4OTEs
MTAgQEAgaW50DQo+IGFtZGdwdV9hbWRrZmRfZ3B1dm1fcmVzdG9yZV9wcm9jZXNzX2Jvcyh2b2lk
ICppbmZvLCBzdHJ1Y3QgZG1hX2ZlbmNlDQo+IF9fcmN1ICoNCj4gPiAgICAgICAgICAgICAgICAg
ICAgIGdvYmogPSAmbWVtLT5iby0+dGJvLmJhc2U7DQo+ID4gICAgICAgICAgICAgICAgICAgICBy
ZXQgPSBkcm1fZXhlY19wcmVwYXJlX29iaigmZXhlYywgZ29iaiwgMSk7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICBkcm1fZXhlY19yZXRyeV9vbl9jb250ZW50aW9uKCZleGVjKTsNCj4gPiAtICAg
ICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShyZXQpKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgaWYgKHVubGlrZWx5KHJldCkpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
cHJfZXJyKCJkcm1fZXhlY19wcmVwYXJlX29iaiBmYWlsZWQsIHJldDoNCj4gJWRcbiIsIHJldCk7
DQo+DQo+IFNhbWUgaGVyZSwgcHJfZXJyIGlzIGZpbmUuDQo+DQo+DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gdHRtX3Jlc2VydmVfZmFpbDsNCj4gPiArICAgICAgICAgICAg
ICAgICAgIH0NCj4gPiAgICAgICAgICAgICB9DQo+ID4gICAgIH0NCj4gPg0KPiA+IEBAIC0yOTUw
LDggKzI5NTQsMTAgQEAgaW50DQo+IGFtZGdwdV9hbWRrZmRfZ3B1dm1fcmVzdG9yZV9wcm9jZXNz
X2Jvcyh2b2lkICppbmZvLCBzdHJ1Y3QgZG1hX2ZlbmNlDQo+IF9fcmN1ICoNCj4gPiAgICAgICog
dmFsaWRhdGlvbnMgYWJvdmUgd291bGQgaW52YWxpZGF0ZSBETUFCdWYgaW1wb3J0cyBhZ2Fpbi4N
Cj4gPiAgICAgICovDQo+ID4gICAgIHJldCA9IHByb2Nlc3NfdmFsaWRhdGVfdm1zKHByb2Nlc3Nf
aW5mbywgJmV4ZWMudGlja2V0KTsNCj4gPiAtICAgaWYgKHJldCkNCj4gPiArICAgaWYgKHJldCkg
ew0KPiA+ICsgICAgICAgICAgIHByX2VycigiVmFsaWRhdGluZyBWTXMgZmFpbGVkLCByZXQ6ICVk
XG4iLCByZXQpOw0KPg0KPiBJJ2QgbWFrZSB0aGlzIGEgcHJfZGVidWcgdG8gYXZvaWQgc3BhbW1p
bmcgdGhlIGxvZy4gdmFsaWRhdGlvbiBjYW4gZmFpbA0KPiBpbnRlcm1pdHRlbnRseSBhbmQgcmVz
Y2hlZHVsaW5nIHRoZSB3b3JrZXIgaXMgdGhlcmUgdG8gaGFuZGxlIGl0Lg0KDQpXaWxsIHVwZGF0
ZSB0aGlzIHRvIHByX2RlYnVnIGJlZm9yZSBzdWJtaXR0aW5nIHRoZSBwYXRjaC4gVGhhbmsgeW91
Lg0KDQpSZWdhcmRzLA0KTXVrdWwNCj4NCj4gV2l0aCB0aGF0IGZpeGVkLCB0aGUgcGF0Y2ggaXMN
Cj4NCj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29t
Pg0KPg0KPg0KPiA+ICAgICAgICAgICAgIGdvdG8gdmFsaWRhdGVfbWFwX2ZhaWw7DQo+ID4gKyAg
IH0NCj4gPg0KPiA+ICAgICAvKiBVcGRhdGUgbWFwcGluZ3Mgbm90IG1hbmFnZWQgYnkgS0ZEICov
DQo+ID4gICAgIGxpc3RfZm9yX2VhY2hfZW50cnkocGVlcl92bSwgJnByb2Nlc3NfaW5mby0+dm1f
bGlzdF9oZWFkLA0K
