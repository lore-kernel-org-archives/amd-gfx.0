Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC36DC54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 23:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690F210F4DD;
	Tue, 26 Mar 2024 23:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLsgw+YZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6065810F4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 23:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJ+U/8oWngTCLhjcFOoe5w7wMP7h8PxA/KPDe94cI9kLApBNMExHs/UCZ27ypKMzOTkoo9YlDoq6uR+bIzcBjpVOsR4ZkDY9MVU9FaosnBL/+7MdWTY/IGhws5ulIrNQ5vC9apHvKey96bKpZG6g+ZQ9hMCSWBNP9WdZt056ePYgtN89e8srB1gke4iGIHGAIIGg/PGwiDh0KlhWdJZ1B+wqNhzI980lvWy/GhVX4VyDMxt3OiJaCv43aLdMNltNolyXyRApo11dDlF2sC3OGWGOmMP0KtMmQIq5RfqPXPyOhkbbePX3YjVUcHGsUfhvLx9VNz9OkScHdYl2K5PzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/WSmi3no0mm+xbtaM9Kbe4IWtT4Sad4HuqFFZZpWqA=;
 b=GsKdAo0OmNSu2KplRXsarfXvcXxpCykAl1cKp2RX+lZstVCvHAGKdDEEMdr4JjbHo25OkzP+L7t5kLUp1Aqd6vrPF0xIm+armBPpU+nC2BlSW/3fJ4lNVV1Zw7CJz4adcnIZgtjbDzMwLL5nEUkUmioUNXoarVGkxWgnjKRSmtt/HM6bApo4vUg4O4MWK68/+6mqVzXyo7P/oGFEohyqMuDC09HIyQRorgiKpoMjkPPCA4dXuY+fe6vDm8+MuRDU7EQHKoO1oBTvHW1zHIPu7oqjBtQ6WYTJd+aj2mec1UvLYZo7MwllmCW1y4HtkJzGxBrcp8dfsqyHDAD29XNa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/WSmi3no0mm+xbtaM9Kbe4IWtT4Sad4HuqFFZZpWqA=;
 b=jLsgw+YZ19jarZyX1CJ4mo2MFsy+GglHEt2BKpCzcO5nPr1NdwlYyO1h9rxDQn4YRdmtnC/SuhEhhp1oGFcrTfE7QWRLf70B54Ks0mKv/Le6DhAY/UoPsQJoW4l9iPi7RX5iWe1V/9hz20Mcj/MCAHj9iIXjSzvkJYWdnmaY7kU=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 23:31:38 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60%3]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 23:31:38 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Friedrich Vock
 <friedrich.vock@gmx.de>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: always force full reset for SOC21
Thread-Topic: [PATCH] drm/amdgpu: always force full reset for SOC21
Thread-Index: AQHafYWgUZb8JrrnLU2k9G1s+3k7W7FGrbQAgAHhxYCAAiDjwA==
Date: Tue, 26 Mar 2024 23:31:38 +0000
Message-ID: <CY8PR12MB70991CCFF15BFA1EB1ABD6858C352@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240324005220.2649840-1-alexander.deucher@amd.com>
 <7eefc428-16b7-4f88-a99b-510203a244f9@gmx.de>
 <CADnq5_O6Vu3bh_P6vt2sOSxuwh0OoZqXdtLtzMehbnQv=uYo9w@mail.gmail.com>
In-Reply-To: <CADnq5_O6Vu3bh_P6vt2sOSxuwh0OoZqXdtLtzMehbnQv=uYo9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fdf2263d-4f7f-4b86-a5b7-da2095969993;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-26T23:31:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|CY8PR12MB7540:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KtxnwFxind87tYI7uUavp/7LFFXep/MCOItQTMo9o3TaDZqFsSOVyO8QkGKwGKahwgRcI3qwKg+4ipTLrbQT0GZ2yxe917f0AklWokYkure+ir+DUutKDwKOd01M/wFYGIvuHQxLWdElDRjD03ihTZQIPESZLqjqxEj8KvuvQGmqxb8RXnGLRTRQaiOCNcJhuRs+Z6Oi1PAbTXyVBrEZ7Qu2ODmUpIIM7fBhYmiyburbk3iXGqCNEWlhsYDds1G/ol8AWeD4qT5sF7RD0epLD9jUTZvGbJJmTcnaPRCwPz3I7GWC4HA8EJmfej+WzDNFKdK3+TjyOPleF8b8UGVb93dEHosxh7+Yyss5UDz7/JHO0kYevVQjtw+AslBf9YCoHH2aKHcfQTxyuGiILnuLSk/S3ZEn4NjPnBSX+1INb7YcgCkxGDTXwS0A9KgjIpDZCgRoKjq71fKhRDmvOCjkjFLcxwJkCOwom2BBd7lymWEL0wmmIGTDp64zyOPVLM87Lrs2aXeYKOlGpl7PfhxFQDV0W61H64fnrvNFQDu5o+EJueLiPUC7OLLhXl1xC/DY9wItfdCuqcXVOVnJOJJdsdDsAjMikLaR81xW73NGo2EQCKPwFBb3s01ZIDKYNnyUGmX8Zy2nVlw5vjoq48XA9W6rGh+unFDvG0WwdHzQBSs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGNNRFVJVlQzU0QxSWJQeDVpM2VzSWF5TVNqZDJOaTZnbE5JQ0oybHBSZk9T?=
 =?utf-8?B?TGJMZFJrUFdrSEl4UEFlbEI4QmRPNTN6c2NWb2llQWpTamFUaml1REptU1VO?=
 =?utf-8?B?V0ZCVFowTmtjcDluZDgwSjlwam1TclNMQzRaR1lOL2dOOXQ4SlFtRGNjK05O?=
 =?utf-8?B?ejN3cFIvYllHZVBtR0REdzJSWUpHcy91SDJpclUyWlF0N2V3QmQ1QmgvWkY0?=
 =?utf-8?B?b3k4NWJvMXRRNyt6RG5JL3o0R0E3eWFOcmh0SlhDc0UwVy9UbmFuV0N2K3k5?=
 =?utf-8?B?Z2swb3NKeGpHLzZ1VnBZbTFkWENFam5abkZYbHUrNnJkZFJCVmRRM0R5aDBO?=
 =?utf-8?B?YWJ6eTlxYkk5UUowNGc0MjNKQVNyTm1Na3JuL2Y1RmlTc2JHNWZVQUh3c2R4?=
 =?utf-8?B?N2VJOU10VDFMVVo2TUhKTytuSDh4VGhTK3pNL3Y3TmJyczBuRi9zUlIzbk1i?=
 =?utf-8?B?QnUxZ1RicXZSL0ZLRzZDcG8wUDhHa0N3YjF2NlpVVnh3clVmNHFCUitTYVpD?=
 =?utf-8?B?aXdBTzhmS0F2YzRFSEdtVVZsbFVoK29VREVGUHZJL1F3eFp0MUhRZ1ppcEhC?=
 =?utf-8?B?VE9jc08xK25TWFJ6WEdrNWVwYVZ4dUF2SnYyOWFQMGtuTEJzZ0NjUXNtMlQ3?=
 =?utf-8?B?VlZRQzd6REliSTZJZXFuN3h3aWthVE9jYjJNcXlScFpmMVBzS0g4NlJhODRB?=
 =?utf-8?B?VzV1V3hMQ1Zka1lNQjF6Z3lzcjdsVjFmNVBUTWRmcnZWSHFodDNDSUJKYmR0?=
 =?utf-8?B?L1UwNkdzYUZGZnhPYTc4alhFYm9pckQyK1Rra3Q5NVZDRjZuZ2NqdGNFT1pn?=
 =?utf-8?B?RHVYS2kzbnVoNWM2SWZLSUluRFl3eTJNenRSelNRMzE0a2Y2SkU1cEhSVmdV?=
 =?utf-8?B?a0RRNHFIS1pCRlNFK3QxQkUrdmVGTitLK0ZYZ1V4R3FMaGZaR3E0NG9Va3ps?=
 =?utf-8?B?Q0N4VFh6eUErK1c3eUYyOUNRdnE3YjhRdHFyODZuS2NndkFwejBtMGZ3b0Uy?=
 =?utf-8?B?Y2pZU0ZyOU03b29nUFc0NUdFZHF2T1FKN1N0M3RpTi9SK2NIYVk5WDgzRjAx?=
 =?utf-8?B?dXVrRTY5bjZ4Z3VESm5iZi9GYmU0NlRXMWxyZHdnQ0lOLzJRTG1SVm5UblN6?=
 =?utf-8?B?S1pZZ2dURTZkMzlMVk13bXl2YXFwTmgzV1RUMVdmNlF3NDVWNU1LV0IzeFlN?=
 =?utf-8?B?S2plWS8vY05xN3diekpYVjdEeWxxS250YVRVcEFZWlFKMHVqL1VJdGRVcXAr?=
 =?utf-8?B?a2FobUlad2xpTGNFUlppOU5OMlJ4L0dHWE9mZ2RVK1d3Tm0wMHN4eTVPbHBK?=
 =?utf-8?B?OG5hV0lBNkMxeHdJSXpNY3FlMjhLcktLenVGYWtXQkwxaStqRFg4SldBdFlG?=
 =?utf-8?B?UjdiZHRtSDcvVENSOXNoV0ZMVTZGL3VvT3VEcmlxblArY3pnam9xM2VZdnMz?=
 =?utf-8?B?aDZLcTlhZ1QyZGlqOGsxbFpiWCt5cTdBSUltS2owYlA0aFc4SDFvNlZrdkhF?=
 =?utf-8?B?alhIS1Vpbk5mSTY0OS9CYzh5dmxBcHpmUGQ2bUptRU1aYjY0dTJydFE4VzUy?=
 =?utf-8?B?eW4xSi9oazVpWkFJL0hFVzltaThsNFoxd0poQ0orYjRxaTJwUHpoUnZPM0p1?=
 =?utf-8?B?N2Q3bW9yVWlkVlBTUkJWT1dJaFE2WTRpRXE1ZUQ5dDFYWTNGdCtCWnpKUk83?=
 =?utf-8?B?WlZLaWJmSnNLZnhQc2J4SThnWG9jK0ZVSU12Y1dNdm5aM0xhUnBVRHB4Um9v?=
 =?utf-8?B?MnMrOHI1Tkl2SE9nbXJmempldjNXNDMrckNPSDJZbU5ySmFMb3NtNVplMExa?=
 =?utf-8?B?TEVycjVXL0J3MnYrMzBXTldiOHZ1cjl5WWcveW5sZEdnR0Z0bnJDVkxrbDdm?=
 =?utf-8?B?YlMvalJzOGVrOFp0bElyMTdNUDF4eDJVYWtKd25xajdvWWxqQ21ndXFiWHA0?=
 =?utf-8?B?eHlPeXVGa25kc2dPSld2UzhBcTJGejlJamxaclRjZjdZcy9KV1dXV0l5bnlZ?=
 =?utf-8?B?TFR2Y0RCWDcxQmUzT2JYc1haQVN4ZVhpZFQwa0s4RUtOcVJKZTJKUzlKaHBt?=
 =?utf-8?B?UnpwUXJ5NzA0YVArRVYrR1N3T1IzckhnelRtYXlrZ2dHWmlGVEU2SWd3SEFm?=
 =?utf-8?Q?NTfs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d16ce0b-65d8-43ef-5415-08dc4dece263
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 23:31:38.5251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVObvT4ip8R6bGJWcXRlcjytqK9V+hsxg2OzOH64SXuYehGAX/RjDxbzhyIVhSLyguW96nuhl2utr/VuAJWj1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBIYXJpc2gg
S2FzaXZpc3dhbmF0aGFuIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBNb25k
YXksIE1hcmNoIDI1LCAyMDI0IDExOjAxIEFNDQpUbzogRnJpZWRyaWNoIFZvY2sgPGZyaWVkcmlj
aC52b2NrQGdteC5kZT4NCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogYWx3YXlzIGZvcmNlIGZ1bGwgcmVzZXQgZm9yIFNPQzIxDQoNCk9u
IFN1biwgTWFyIDI0LCAyMDI0IGF0IDY6NDLigK9BTSBGcmllZHJpY2ggVm9jayA8ZnJpZWRyaWNo
LnZvY2tAZ214LmRlPiB3cm90ZToNCj4NCj4gT24gMjQuMDMuMjQgMDE6NTIsIEFsZXggRGV1Y2hl
ciB3cm90ZToNCj4gPiBUaGVyZSBhcmUgY2FzZXMgd2hlcmUgc29mdCByZXNldCBzZWVtcyB0byBz
dWNjZWVkLCBidXQNCj4gPiBkb2VzIG5vdCwgc28gYWx3YXlzIHVzZSBtb2RlMS8yIGZvciBub3cu
DQo+DQo+IERvZXMgImZvciBub3ciIG1lYW4gdGhhdCBhIHByb3BlciBmaXggaXMgYmVpbmcgd29y
a2VkIG9uL3dpbGwgYXBwZWFyIGxhdGVyPw0KPg0KPiBJbW1lZGlhdGVseSBmYWxsaW5nIGJhY2sg
dG8gZnVsbCByZXNldHMgaXMgYSByZWFsbHkgYmFkIGV4cGVyaWVuY2UsIGFuZA0KPiBpdCdzIGVz
cGVjaWFsbHkgY2F0YXN0cm9waGljIHdoZW4gb25seSBNT0RFMSBpcyBhdmFpbGFibGUuDQo+DQo+
IE9mIGNvdXJzZSwgc29mdCByZXNldHMgc3VjY2VlZGluZyBidXQgbGVhdmluZyB0aGUgR1BVIGlu
IGEgZmF1bHR5IHN0YXRlDQo+IGlzbid0IGFjY2VwdGFibGUgZWl0aGVyLCBidXQgSSB0aGluayBp
dCdzIHByZXR0eSBpbXBvcnRhbnQgdG8ga2VlcCB0aGUNCj4gYWJpbGl0eSB0byBkbyBzb2Z0IHJl
c2V0cyBpZiBhdCBhbGwgcG9zc2libGUuDQo+DQo+IElmIGl0J3Mgbm90IHBvc3NpYmxlIHRvIHdh
aXQgd2l0aCB0aGlzIHVudGlsIHRoZSBwcm9wZXIgZml4IGlzDQo+IGF2YWlsYWJsZSwgSSBob3Bl
IHRoYXQgYXQgbGVhc3QgaXQgY2FuIGJlIHJldmVydGVkIHNvb24uDQoNClllcywgaXQncyBiZWlu
ZyBhY3RpdmVseSBkZWJ1Z2dlZC4NCg0KQWxleA0KDQo+DQo+IFRoYW5rcywNCj4gRnJpZWRyaWNo
DQo+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5j
IHwgMiAtLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gPiBpbmRleCA1ODFhM2JkMTE0ODEuLjg1MjYy
ODJmNGRhMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2My
MS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYw0KPiA+IEBA
IC00NTcsMTAgKzQ1Nyw4IEBAIHN0YXRpYyBib29sIHNvYzIxX25lZWRfZnVsbF9yZXNldChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgIHsNCj4gPiAgICAgICBzd2l0Y2ggKGFtZGdw
dV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hXSVAsIDApKSB7DQo+ID4gICAgICAgY2FzZSBJUF9WRVJT
SU9OKDExLCAwLCAwKToNCj4gPiAtICAgICAgICAgICAgIHJldHVybiBhbWRncHVfcmFzX2lzX3N1
cHBvcnRlZChhZGV2LCBBTURHUFVfUkFTX0JMT0NLX19VTUMpOw0KPiA+ICAgICAgIGNhc2UgSVBf
VkVSU0lPTigxMSwgMCwgMik6DQo+ID4gICAgICAgY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAzKToN
Cj4gPiAtICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAgICAgICBkZWZhdWx0Og0KPiA+
ICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gICAgICAgfQ0K
