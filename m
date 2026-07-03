Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4C1C43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 10:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56C810F798;
	Fri,  3 Jul 2026 10:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dqqaSWv0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A8E10F798
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 10:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqgDGiwqvXIFW76rM0c/vDO0Zxfine23zA87Qb+g0zd2kxu5nosvDeAhcMD9rf4XdO+QJUHSQgpkeDb0gQT6KQw5uMsINHpD7FsXPb0alFzZFiegZwnJGZ9kwq0Pq7g0rtRqJWEHoFb0jaOfOQsPXY4wHHpVg62Q6UxE/l+o8imDVeKXamhzuJF0xaZqmkedfxI8ZSIWCH5Pv3iufEGjYrlkxiWp5a2WMzIcnPBFtJfkKEOZJ7VA8t8NfFdmXS3qAK/MESQQXrR0Gna4hWPE6aWQNWZGtPVw1QLVAzXJNNIDJCxBPLnrSKMR/r+45rPJa0FC91sY1VPvOyCjM3iuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpQ0LHX3HnrxYYZ3/kMuW58ATg+9RFhLQrOmkSlUVEc=;
 b=h0Jwwv9StpioLmWsoNLGO+Mv6LnbtVflIrNptVCxz6A2n/aFf5tBNkzRKFuIXLZ6H9MxvrsuM+HY804DmQs4UoXS02BREBHjiMdAbDwYqmNp0/AHXFlJwP4pYuYOp1cGV7lK5YmoHBqv9OQWFYJLBnEns+O4mKg/iwHqRKLlCu4rd2Xj9Ti7KIYhuV7JvmS0X93+4MRdvQc/V5X6LXsSJvMijA187lFURlEfKd8rXuApklvWPxNa2Qq3GKkfBNB4Um6cUojTRpZVGW6BKeZDwaclMhimTNIibhhf/TxBIpPy5rDK776lcTXkvOTaG1pdsuVdPIhMsnw9zmSHWrMFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpQ0LHX3HnrxYYZ3/kMuW58ATg+9RFhLQrOmkSlUVEc=;
 b=dqqaSWv0UoOc4ItV/ITiXI7icEp8tiSlN5lE4wqABD2j/MLLy2yDzfjkHru4PNSl4so6/e3WOxDDmdL7J+k/6QlHzbYyd8CajVZ8BaGturru4aavxWDyFdlFm1zMZyozyQsTvkPbCJ5Bt6JBZyGgZciinRNQNAXB1bZLFZsoKus=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 10:36:40 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 10:36:40 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4 3/3] drm/amdgpu: Drop vm_manager PASID to VM mapping
Thread-Topic: [PATCH v4 3/3] drm/amdgpu: Drop vm_manager PASID to VM mapping
Thread-Index: AQHdCrPYlOdrJBdlTUaSotroDQU7h7ZbagyAgAAv5XA=
Date: Fri, 3 Jul 2026 10:36:39 +0000
Message-ID: <IA0PR12MB82085C8E4A1E00B94B602B8B90F42@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
 <20260703061833.3163913-4-srinivasan.shanmugam@amd.com>
 <3f732fbc-5a36-4818-9247-4539ed791872@amd.com>
In-Reply-To: <3f732fbc-5a36-4818-9247-4539ed791872@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-03T10:35:31.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SA1PR12MB8859:EE_
x-ms-office365-filtering-correlation-id: e3b67f1c-234d-4c48-1e07-08ded8eef7a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|4143699003|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: mrC/fotg8e7ggM+vHirG6SiLV5f4iOPrfeVlnnMrp9vj0wK6/hhhMJRyeie0uFPO4UD1aQnM3OE5kl/EqjBBnXUppk0fYaLjq2kaAccHqYFXe2U2aEIHp1Y6k9V5kOlKv/92tc7wN1AwozL1hh9sPjDy654YNsnnC2CT3n3MvMz2jblTn0CuMTQiwdszTqMdpyoYquNr8P9e0jNELv1YslC/z5Yi7HZMbLpXI0d2Ew99vyMgDmETn1sQGttQtT5wdbwhwX/GnbKqIRXjLETKEdPLQTVg9r5VmOdgXhuLFgwh/AmiisW+f2g9jP4G/P3zXPOXLBuTRs/U+mSOj3DdUDFQ2KL19BGjL17z4HwJJOvZk5TXJoNbz1AX92N0IW8ZrPUssi1v74hR+MoUQ90KUWK5TYmG2+cOhvsx/CHvth6TFpJ3PLASIn/qKkRrgDi1AY/KbtpftLygJ5eo0Hpnpr1T6G6rsbKJdYLjLxbLYbOB2bKILE2wrQzm+XO0rBkaq5Vb44gMbFJ0T7mGw/VOc2vj3LZ8pl7gP1IZiiviXcMqfdHf6UVb0ZfZ12xo37afZcHU9PgL05z9JPlEJnRH7eI6pYkqGDHjEP9ddhwobssKsiDJJgab1Z4P+kVzN1wvEC0LeB8cFE/NOm4c2zR/hYYseS3P6LqdN3R7L8yWlvviztG5Bvrj3HS5FgZLkGbSmnG7Rj/jvaOmhRHQ6IFCQElXGvjDyUu/CW0IEPLLJug=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU51QWw0MDkxQWRRVkF4N3UveEhTbENSRmlZbHpPRitQK1NRclA0ZzBUWkN3?=
 =?utf-8?B?MExRcFhjRUFVYmNONUlBaUh5Um5Melh3YkcySmJUQ2w1RUtvYUlnL3hFWUtM?=
 =?utf-8?B?MjNDOXhIQU01YmpjUU0vWGFCRmxaS3RJbUZhbHpmR3hRNytPcVlneDl4Qi82?=
 =?utf-8?B?R3pXaDVLR3BXVFBXbVZWbDBHVFh6U09zZGs2Umk2ZUIwclZQYnNkeVRNbktM?=
 =?utf-8?B?aG9jQXNpbFJvckNmSVJJaytibW9hc3Q3SnpNY2IraCtXaDJTMmU4R2JJclBN?=
 =?utf-8?B?Vm9kTkZMY1FrZVN5NTc0eGhLZEFacVlwK0ZQVjJqS3pqN0x1aG1uK0FVQ3hG?=
 =?utf-8?B?c1QzcFk0U0FkYmV3R3FVZENEQ2ljSm43SWNDQmwxN04vWjY4TjVSbUo3NFFQ?=
 =?utf-8?B?YzVHMHJickdzWWNhdFJ5cXNETGxFU2ZvVklVQUZVTEtkcVpzNGNWMk1HOFU3?=
 =?utf-8?B?c3RzdXFDYzc1SUlSNEU3MDdzV0RRU2lFRmRkaDJ1WnM1R0Z1STFkblNoZlhu?=
 =?utf-8?B?cmR0K2VYaFhZc0N4a3U2UVJKTU9hTTROdUQwdWU5V3NPaU9hd3dYeFVKS0Er?=
 =?utf-8?B?UVlUM3plcjFYOXlBU0VnQ0F2R1MwUFJ2VUc2R1hzcDNveHUzdllDMEhHdWRh?=
 =?utf-8?B?SENBcyswTjBjL3FWdDdjUm5pNTZDc2pqVEkyOFdibFVGWGQ0aSt3OHA1V3ky?=
 =?utf-8?B?OW1hNkRSV2FEQTErRzJkZ0NBcmFZMXkyay94elZYRHNqZDZJZlQvL09kaVRn?=
 =?utf-8?B?WU1WV29zb1YrNndFOWMrRTlIMjNTWktZYXEwa1Vqa08zUTR4S0twbklZb0xv?=
 =?utf-8?B?M0NCMzRBdThWNDhlczR4SkVadmo4bDhqd1ZKeDN4R1Z5cVBJSG90bHltdkoz?=
 =?utf-8?B?T0pPb09wbVRuZ09WYVJIVXFMTjZXYUp6NU1LbFFZbzNVTjYrYjZCblRuK2xo?=
 =?utf-8?B?OVllR1g2QnpiR09keTVhWDdSU2RUVXRXSUFIMldWb3ZiakhIOC92NHVUVWF2?=
 =?utf-8?B?TnROL0ZNS016c3lreDZHVjJ5OXFSK0d2c2k4MURCWWNPS3FSYkNXVG1QdWhr?=
 =?utf-8?B?Qll4UUJrM2h1NTUxWUZURUhIV1NLaENzclp3SC9kVVVhcjYwVURnbFdYdWps?=
 =?utf-8?B?bEl2Z01mazd3eWNTK1YxM3FNdGI0YVZoMURFNFdhNmJUS1IvTnRrUnBUTEJy?=
 =?utf-8?B?aHZmY0oxbjZzaDk1d1NhQmJTeUlNOFRhbk5pR3VlR3B5UzNVUW82OVUrdDVm?=
 =?utf-8?B?WGlPZWx5NUh0MVJlVndRQzJmU2o0UE50VkdnT1phVWJXd3hMTzRQemFFSHpn?=
 =?utf-8?B?bUxoK3E3bzU5ZzZJNUhybGF5WnBjVmJTUW9sNllUTzZZa2hacEhmcWNCK010?=
 =?utf-8?B?dUtkYjkvMGVnNEUzaGFZL2k2Q09xWE04NUhqaDV1dDJ6aUFDaTduTlZGc1pr?=
 =?utf-8?B?L0YweW42M2JiTUZpT1ZqYUY0bWhWdm9sQk5pZXBNbUV3MjJ4dDlDUnR5RnU1?=
 =?utf-8?B?dWlzcFl4d1VQMSthL3FBNjd1MXJrV1RjKzh0L09LSHJ0YjViYzJYQnVZcE5H?=
 =?utf-8?B?Q09ERHVNcGtabXU1dDRRdnl6WFNMODRmZm1waUZvZ0M4dUVZbkdpQjlMTnY0?=
 =?utf-8?B?OXdLYkQ4UHNhVG1CR3QwTmJtbkpDYUs3cnlkVlVZWm5oUU16SHRBMjkyZ2R0?=
 =?utf-8?B?blI5V1RFV3htajkvOWZBSkRqa2hkV09QS09nQmtVZGorc2hBSEJIQWRCZUJF?=
 =?utf-8?B?UFhGbkxBMmZsRU5tZVhNMHg2Zi8zU2pHNjZuZithUkF2QlhPVlh0TDZ5bzhG?=
 =?utf-8?B?OGY0RW5DcENKTUlYcVJCNWRIRGVpYXBmR2JhUGlDRzA1OHBTOWw2RUp0c1I5?=
 =?utf-8?B?bkkvU1RoM1k4NTBCcXJua1ZlOVc5dXVzQSsxUUo1SlY3R3NmcHY2Y0tTWXRL?=
 =?utf-8?B?Mkw5RThlODNsUW10eWRvT2srRUFzWWcrRkgzMnl6ak5PRXFXUWVsY1lPZU5L?=
 =?utf-8?B?bEJkcFc5RXVEd1V3VHkzR3J1d1VadlBPOTJjcnZXLzJxT3RIMnJZU0RHakVT?=
 =?utf-8?B?Y21uVVV0MDdnWHJCMDdPSnE0MXVMWjNpVFNMT0Vqc0dHeUR6cHhCYlFCTUdH?=
 =?utf-8?B?TnhpeWQ5WkFQK3ZjYWFhbm5SL1lxTmoxbjVtanNpSDIwOC9zMW9HTUxsSTU2?=
 =?utf-8?B?RnVpZjM2TE9YMlZ0MkVKZjcxOHI3dFVoeDB3dk1qckUzY0tyM1MyY3RBN2hB?=
 =?utf-8?B?TmxGUXEyem9tQThYNW81T3NsMVFhQ1E0MFNsTHBxWVJ2ZHVKK2xWOXlXcjJS?=
 =?utf-8?Q?BNetuKUpXH5v9Rr7Gf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b67f1c-234d-4c48-1e07-08ded8eef7a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 10:36:40.0802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31txNS6ugajuj8QunrazmXfRV0hkcUcUsogEbGnK/BqpCMyT+LIMvPUKyiK2Na0mJkIiV34JJ8KcUxNPwoZbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
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

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAzLCAyMDI2IDE6MTQgUE0NCj4gVG86IFNIQU5NVUdBTSwg
U1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy8zXSBkcm0vYW1kZ3B1
OiBEcm9wIHZtX21hbmFnZXIgUEFTSUQgdG8gVk0NCj4gbWFwcGluZw0KPg0KPiBPbiA3LzMvMjYg
MDg6MTgsIFNyaW5pdmFzYW4gU2hhbm11Z2FtIHdyb3RlOg0KPiA+IFZNIGxvb2t1cCB1c2VycyBu
b3cgcmVzb2x2ZSBEUk0gUEFTSURzIHRocm91Z2ggdGhlIGdsb2JhbCBQQVNJRCB4YXJyYXk6DQo+
ID4NCj4gPiAgICAgUEFTSUQgLT4gZnByaXYgLT4gVk0NCj4gPg0KPiA+IFRoZSBwZXItZGV2aWNl
IHZtX21hbmFnZXIucGFzaWRzIHhhcnJheSBpcyBubyBsb25nZXIgbmVlZGVkLg0KPiA+DQo+ID4g
UmVtb3ZlIFBBU0lEIHJlZ2lzdHJhdGlvbiBhbmQgdGVhcmRvd24gZnJvbSBWTSBpbml0L2Zpbmkg
cGF0aHMsIGRyb3ANCj4gPiB2bV9tYW5hZ2VyIFBBU0lEIGluaXRpYWxpemF0aW9uL2NsZWFudXAs
IGFuZCByZW1vdmUgdGhlIHhhcnJheSBmcm9tDQo+ID4gc3RydWN0IGFtZGdwdV92bV9tYW5hZ2Vy
Lg0KPiA+DQo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cj4gPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdh
bUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYyB8IDI1ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCB8ICA0IC0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiA+IGluZGV4IDkwOTJmZjIyN2E1NS4uNzQ4
MzYyNDBlZGJiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMNCj4gPiBAQCAtMjY0NywxNCArMjY0Nyw3IEBAIGludCBhbWRncHVfdm1faW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4gc3RydWN0IGFtZGdwdV92bSAqdm0sDQo+ID4gICAgIGlm
IChyKQ0KPiA+ICAgICAgICAgICAgIGRldl9kYmcoYWRldi0+ZGV2LCAiRmFpbGVkIHRvIGNyZWF0
ZSB0YXNrIGluZm8gZm9yIFZNXG4iKTsNCj4gPg0KPiA+IC0gICAvKiBTdG9yZSBuZXcgUEFTSUQg
aW4gWEFycmF5IChpZiBub24temVybykgKi8NCj4gPiAtICAgaWYgKHBhc2lkICE9IDApIHsNCj4g
PiAtICAgICAgICAgICByID0geGFfZXJyKHhhX3N0b3JlX2lycSgmYWRldi0+dm1fbWFuYWdlci5w
YXNpZHMsIHBhc2lkLCB2bSwNCj4gR0ZQX0tFUk5FTCkpOw0KPiA+IC0gICAgICAgICAgIGlmIChy
IDwgMCkNCj4gPiAtICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfZnJlZV9yb290Ow0KPiA+
IC0NCj4gPiAtICAgICAgICAgICB2bS0+cGFzaWQgPSBwYXNpZDsNCj4gPiAtICAgfQ0KPiA+ICsg
ICB2bS0+cGFzaWQgPSBwYXNpZDsNCj4NCj4gV2hhdCBkbyB3ZSBhY3R1YWxseSBzdGlsbCBuZWVk
IHRoZSBwYXNpZCBpbiB0aGUgVk0gZm9yPw0KDQpJIGNoZWNrZWQgdGhlIHJlbWFpbmluZyB2bS0+
cGFzaWQgdXNlcnMuIEl0IGxvb2tzIGxpa2Ugdm0tPnBhc2lkIGlzIHN0aWxsIG5lZWRlZCBmb3Ig
ZXhpc3RpbmcgaGFyZHdhcmUgcHJvZ3JhbW1pbmcgcGF0aHMgKFRMQiBmbHVzaGVzLCBQQVNJRCBt
YXBwaW5nIHBhY2tldHMsIHRyYWNlcG9pbnRzLCBldGMuKSwgd2hpbGUgdGhpcyBzZXJpZXMgb25s
eSByZW1vdmVzIHRoZSBzZXBhcmF0ZSB2bV9tYW5hZ2VyLnBhc2lkcyBsb29rdXAgdGFibGUuDQoN
Ck15IHVuZGVyc3RhbmRpbmcgaXMgdGhlcmVmb3JlIHRoYXQ6DQoNCnZtLT5wYXNpZA0KICAgIHJl
bWFpbnMgYXMgcGVyLVZNIHN0YXRlDQoNCnZtX21hbmFnZXIucGFzaWRzDQogICAgY2FuIGJlIHJl
bW92ZWQgYmVjYXVzZSBsb29rdXBzIG5vdyBnbw0KICAgIFBBU0lEIC0+IGZwcml2IC0+IFZNDQoN
Ck1heSBJIGtubyBwbHMsIGRvZXMgdGhhdCBtYXRjaCB5b3VyIGV4cGVjdGF0aW9uLCBvciB3ZXJl
IHlvdSB0aGlua2luZyBvZiByZW1vdmluZyB2bS0+cGFzaWQgYXMgd2VsbD8NCg0KUmVnYXJkcywN
ClNyaW5pDQoNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0K
