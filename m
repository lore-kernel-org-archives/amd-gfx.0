Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810B2C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 15:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D1D10F587;
	Mon, 11 Mar 2024 15:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="blDNaL+7";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E91D10F587
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 15:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIynfv2kMi8+a2GLNETENZtSdZElFYif8gFdeFGOwcVFCL8Hl7PixmtEqTh+g/esa3qeD7JEU1fYGcz8wk/nwo2tLQ3Maf5TJ8ergiKzbe+nQgad1bWiYguTqhJ3nCqgJA7YePWhsjCo8uVruLWYSvG7mAqSJd6i21scOAkzY+QkRSttnQtxyXUv+nO9Q1ZQZppT4C/HFpKB1UULqK25uoj8grk1rJJkqPBNeQotIo+RJj56z5EVOfJWHjPkj0qQJgdoDhd+rwVedX0wTfHuwXkay6oCWcYBFt1NBIBMGrbpcU8ooLhSnXM4hjcXLbTBYCfAQzx65ViV+9IHL4p0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeFhSSWdLxdeXovYkhb7KhY3I28HLCAyBQMna4IoR1g=;
 b=JExXga9bZHyO7mLLP0mzM6M+di4q4O3Q5zEJUM7L3EmmlNsOQPPuennhRUvCjyYVG2lZCoTk1+u5Cx5OIrmsOzrFiQK/FQ91dp93fE6Iev4lkZE9AM9KV5UxNJ2PGY0wcR5kCPPElcmxRaXdPoNxG3JFZ8x/c5D170b+8ySggUa+Dj0sRBLCMSpxveTm4iZUvlY+ZEyrvQQ7T2ysjPFFrACT5WpO0DNp3nhBjkLDrGmoQpOn2ZiDVGuZTd/T8CYhiJBsa4RGBWEkBZQ2VnGq+5z1R5P4Lqgsmaa1lUfRbCkIWPH39TIjgBMKqCLsWB78+amEkx16sGXK5T/IxYRRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeFhSSWdLxdeXovYkhb7KhY3I28HLCAyBQMna4IoR1g=;
 b=blDNaL+73JN8elMBtzxNuxQ1PKP8kH1SdGJncli4IYXYcm9bg61W634cOXsEpjAuoAy48WHrZGOlD8/NBAyYzFjqYUyAU286Cgre6bQa3IvAyECKKtaNlWBBZf9XhMDeKO6hdZdv2retrwaBXSlNlDgb7eRd8++y7UOjvbhJUIk=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 15:26:03 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:26:03 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Thread-Topic: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Thread-Index: AQHacXToxD1WfV5D80+X2y/tzgqIYbEuDdeAgAQnE4CAAHjhwA==
Date: Mon, 11 Mar 2024 15:26:03 +0000
Message-ID: <BL3PR12MB6425EFC66B88FFA7D0A8F931EE242@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240308162253.264154-1-mukul.joshi@amd.com>
 <b9b7b00d-57e9-4d35-a713-f922f5e19402@amd.com>
 <ad61e40f-4a17-4700-bb8d-085a87f20ee7@amd.com>
In-Reply-To: <ad61e40f-4a17-4700-bb8d-085a87f20ee7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e71ad3fb-23b1-454e-bfc5-7586e222708c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-11T15:25:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|CY8PR12MB7683:EE_
x-ms-office365-filtering-correlation-id: 6b5bda52-4028-4a23-8e91-08dc41df9078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZZW/tq2q4dmA9hA2tfoezAo2dGzuZC4kcvTHUASswiQePtvVu3v78t9Ew42jFt6R6ILjRxTvfI55bSqo9vkBztlaH+vGFgBtst/V+bmr0RghgMsaM5PGRZ9Dur/J7nvVmQKmkRSrU1Kx7oSb8/s99c33GjPJx/5mDpgjHZE3WIzVjpoRXxouEbqyv57K31h1kaQ7mLw5LuEfppT2/wDzxNaKhHm5fzT9z0q2wKtsbuU1dp9HHPW9yUniLTq49eOgoUM5JkFIQ2mJYLAj4421tbgRzsx4NW9WJMtNslP5l/UmCsYCNDqz6pCxOyzYU/u7rq70pVgwNZrPuCEf43m7ESfTQmBpvZXsgO8IV5g4czrtUrui+ufPOkv4EPGXdhVjJJAqICogIJUbmJgfcIQx3VFqM3rVML81WZFqXjCXpwvW5KPSVaZyGdVXKZOxT+cSm11hIB5WKQuQyuAlHkAyzUmbvlhoepPiY+8npMyA76iQ0jglTirThV14LpiyJ7P7z9xfwIm0F0Q4ITeWsUzLb/YNPuzYMpuXxBpW/z7WUPLO4Fo4+dTAkhRsWA8JWgWlae4b2STG9ywfdZYzGtAuSKnE5+yTuH2d13LQTyQFOc7OYpRxNH6VzBIFz2kTA13nVBqAIqgF5vcrpvfM+1/RaqWqZOYupCfDgsOxBofMouARtlvhBQ4TNsGsfeDs55JDglKV6HzsZU2wZGS+jEq8PPKeLqpX5ZrZa5rqSrvqe0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDAxdjdLa0x2S3JmRHZvSmRBV2ltWjMvSE9LQThUemppTTN4VldydmhWUmNh?=
 =?utf-8?B?MTRld2lGSU1mVFpGVm5acUcyNXhvdm0wK25BWndJazU1RWt1eWpHT1Y4aWxz?=
 =?utf-8?B?WlJyaCswZUlaWG13ZEhnOWV5Qy9pdHlxL2d4LzNMalh1TEw0RE1nVzBNbVdH?=
 =?utf-8?B?NDhwdWJhRmpZNG9jS0tqVG1UbUQ4QzJVK25NWjlrUnRFVjgyVk0wK2Rhb2FH?=
 =?utf-8?B?Tk5PSGxPemxuTEw5WnAvNjlQa2xaY3F1M2E1R0FQby8vYmFwcnhGOVVWVWxB?=
 =?utf-8?B?b2dxSmR2M1FEcEkxZzVpZkxoWllYVjJoVlpCYlZvYkpWcGVTRzlsMlgybmww?=
 =?utf-8?B?VGd3OXhiQk80STFzbUR3dDlQRGlmM0FMdHNNb2MyNzFvcmN0WkNTeFh4WkVx?=
 =?utf-8?B?OVd0YXBBSDF2M2lnU0cxUmFjZUNqWnRveG5iS3Z1aHphM1ZRUkpGS1I0emIv?=
 =?utf-8?B?OFZRMTk5M3k1SUZJckdOQlZRMmhQeTNTUFdIcTh4Zk9VMWxkc3EzK3BRYXlJ?=
 =?utf-8?B?cjl1NWo4eFFVSmNWZ3BWV2MxangrdHZ3MTBKMWdoR3JCR096djcvVTRaanNm?=
 =?utf-8?B?V3hGVjVyRUtzSW83QlNjZG1CbkFFVVhHdXkvclZoWTFPMVpnU1dDUHhXSC9v?=
 =?utf-8?B?Lzc1ZVdhWjd2VTFtY0lmejVUMWJEUnBiTnlPSHRpdjJkZmdZQlFwSTNWUVlM?=
 =?utf-8?B?cnZ5NEhoQXlvOEFZL2o1YkUrcEVKbFBaUWJmU1NhNVBkVnBWZVpyMEhQNDV0?=
 =?utf-8?B?UGpSbWsyNXNWd0drOGRnRFArV3FLdmhKcm4vNDlRcWdBbHNpVlFMdWZhMnU5?=
 =?utf-8?B?RnJIR2l5S0xwdkpycTBiL1gvQ1BmZDNFeHdmUUc4RVpMajlaakRnZ0srVmp5?=
 =?utf-8?B?QXNPSEFSRzJnTW5zcFI3dzdzZGJlb0pWL0xKbytPUk5Nb0dMNzJUU3B0Qm5N?=
 =?utf-8?B?Y1pmYUE4ZFZtazllTlQ5czFyaHlxdGlMLzFNTUFxREYwRzVYQ0d2ZHNhbXFM?=
 =?utf-8?B?QXg2aVYwd3RoLzJlS1Rzd2lYd09NQVZaV1hIbXliTUg0aGIvU2JWR3JEMUMv?=
 =?utf-8?B?V0hBUU5wa0ErM2NzbmhDTDdib3VkQ0lWdXdxODNJcEVIOU9XREorUEtyeU5a?=
 =?utf-8?B?R2tCaGEycXZGdXJVVnFlRmpkTXlOYllOOUFUVlVzNjZGV29WMFdJQ3BVYnRL?=
 =?utf-8?B?aHNBS1hXTUk3Qlg3WUZ3MTdoSkFBK3hkRGhoT0lsdlkxaG5PeTZydmtMcjZU?=
 =?utf-8?B?aml3N3Q3QTl1UElJeXpac1lMeEVIQUFVUnIrMlJwM2wxcnBVZndmamg3UzVR?=
 =?utf-8?B?TG1LL2RrTmVENU1FQ1p1SjJ3WGtVYkdCcUs5Rk14NjVnZlVCVHlwNDJ0SXJu?=
 =?utf-8?B?ZFBFV3VTTVRpMDR2Sm9wN3Q1emF0RXBKazRYTk9yNDh5WFg3cGdWdVlkRWt1?=
 =?utf-8?B?TXA4U1dEbmRvQ0Uwd1FWUmliK0h1azBzbFdtaCttL3ZEWFNGMEpFMXRFWnpB?=
 =?utf-8?B?K2ZFV2dsWWVIVktNMENIYUI4VzM0WGkrWmFJMEN1dndQeG9DS1E3cDg3V3Fw?=
 =?utf-8?B?dFhpTnd3Y09JbW5RUE8vd09SaGp4SlRxWVBXNnJBK2k1S1ZQOHpnamFzUlNh?=
 =?utf-8?B?QVJJTFh6ZkJuVXBkeXBhSjB6VmJZTUsvSTEyUUhXcVhqY0ppSGxOT3YrVVVT?=
 =?utf-8?B?ZGxyd3l4dlNRUUJsM1RQUy93SHR6d1pYQ3lUK25XbGkwblhIaXgwRnhxUEtJ?=
 =?utf-8?B?RmwwTEk2Ukh5UnZaSGhndk1kb25jcmxwN2FuSE1Ndm85OXhRK3JKY1YxbnU1?=
 =?utf-8?B?TXpYWlpNVlZQNG1FandmdVlsNWdpWnlxWEVBSlBrTWtHOHRON2xaS0NCQUF0?=
 =?utf-8?B?NWp4U3FlMERUQlVaSGVEd1kvWUJZdmtmdGF0MmNNVXhBcTQ4ZTNkU2tNNHRl?=
 =?utf-8?B?RGJ1eUhSTHRsT1hqZXJyWnJzM2lSeHdFTUxyclIzWmV5MkFqSVNnMGpTTjNy?=
 =?utf-8?B?elFFMEhDNERUaXhxb1VIVDlYRE52Q0x6NzZyVHB0TjhVajdxMktSb2JiNFow?=
 =?utf-8?B?NW5VNEhwRm9HWENNMkJ5NS91TU9rNDFJRjhpeGx4dzhpME9TcTJVUkZSQVlL?=
 =?utf-8?Q?F5dw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5bda52-4028-4a23-8e91-08dc41df9078
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 15:26:03.6485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 879AQ6kF4tBhBtrH1WavDvZisIYHBsI1K6p2LmARPlpqWH99Bub43MjgzqMvoSpxduDXf4ExbpJ9tf1mAWzBew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
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
YWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBNYXJjaCAxMSwgMjAyNCA0OjEzIEFNDQo+IFRvOiBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBKb3NoaSwgTXVrdWwNCj4gPE11a3VsLkpvc2hpQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1kZ3B1OiBIYW5kbGUgZHVwbGljYXRlIEJPcyBkdXJpbmcgcHJvY2Vzcw0KPiBy
ZXN0b3JlDQo+DQo+DQo+DQo+IE9uIDMvOC8yMDI0IDEwOjE3IFBNLCBGZWxpeCBLdWVobGluZyB3
cm90ZToNCj4gPiBPbiAyMDI0LTAzLTA4IDExOjIyLCBNdWt1bCBKb3NoaSB3cm90ZToNCj4gPj4g
SW4gY2VydGFpbiBzaXR1YXRpb25zLCBzb21lIGFwcHMgY2FuIGltcG9ydCBhIEJPIG11bHRpcGxl
IHRpbWVzDQo+ID4+ICh0aHJvdWdoIElQQyBmb3IgZXhhbXBsZSkuIFRvIHJlc3RvcmUgc3VjaCBw
cm9jZXNzZXMgc3VjY2Vzc2Z1bGx5LCB3ZQ0KPiA+PiBuZWVkIHRvIHRlbGwgZHJtIHRvIGlnbm9y
ZSBkdXBsaWNhdGUgQk9zLg0KPiA+PiBXaGlsZSBhdCBpdCwgYWxzbyBhZGQgYWRkaXRpb25hbCBs
b2dnaW5nIHRvIHByZXZlbnQgc2lsZW50IGZhaWx1cmVzDQo+ID4+IHdoZW4gcHJvY2VzcyByZXN0
b3JlIGZhaWxzLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBNdWt1bCBKb3NoaSA8bXVrdWwu
am9zaGlAYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgMTQNCj4gPj4gKysrKysrKysrKy0tLS0NCj4gPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPj4N
Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYw0KPiA+PiBpbmRleCBiZjhlNjY1MzM0MWYuLjY1ZDgwOGQ4YjVkYSAxMDA2NDQN
Cj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2
bS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYw0KPiA+PiBAQCAtMjg2OSwxNCArMjg2OSwxNiBAQCBpbnQNCj4gPj4gYW1kZ3B1X2Ft
ZGtmZF9ncHV2bV9yZXN0b3JlX3Byb2Nlc3NfYm9zKHZvaWQgKmluZm8sIHN0cnVjdA0KPiBkbWFf
ZmVuY2UNCj4gPj4gX19yY3UgKg0KPiA+PiAgICAgICAgIG11dGV4X2xvY2soJnByb2Nlc3NfaW5m
by0+bG9jayk7DQo+ID4+ICAgLSAgICBkcm1fZXhlY19pbml0KCZleGVjLCAwKTsNCj4gPj4gKyAg
ICBkcm1fZXhlY19pbml0KCZleGVjLCBEUk1fRVhFQ19JR05PUkVfRFVQTElDQVRFUyk7DQo+ID4+
ICAgICAgIGRybV9leGVjX3VudGlsX2FsbF9sb2NrZWQoJmV4ZWMpIHsNCj4gPj4gICAgICAgICAg
IGxpc3RfZm9yX2VhY2hfZW50cnkocGVlcl92bSwgJnByb2Nlc3NfaW5mby0+dm1fbGlzdF9oZWFk
LA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgdm1fbGlzdF9ub2RlKSB7DQo+ID4+ICAgICAg
ICAgICAgICAgcmV0ID0gYW1kZ3B1X3ZtX2xvY2tfcGQocGVlcl92bSwgJmV4ZWMsIDIpOw0KPiA+
PiAgICAgICAgICAgICAgIGRybV9leGVjX3JldHJ5X29uX2NvbnRlbnRpb24oJmV4ZWMpOw0KPiA+
PiAtICAgICAgICAgICAgaWYgKHVubGlrZWx5KHJldCkpDQo+ID4+ICsgICAgICAgICAgICBpZiAo
dW5saWtlbHkocmV0KSkgew0KPiA+PiArICAgICAgICAgICAgICAgIHByX2VycigiTG9ja2luZyBW
TSBQRCBmYWlsZWQsIHJldDogJWRcbiIsIHJldCk7DQo+ID4NCj4gPiBwcl9lcnIgbWFrZXMgc2Vu
c2UgaGVyZSBhcyBpdCBpbmRpY2F0ZXMgYSBwZXJzaXN0ZW50IHByb2JsZW0gdGhhdA0KPiA+IHdv
dWxkIGNhdXNlIHNvZnQgaGFuZ3MsIGxpa2UgaW4gdGhpcyBjYXNlLg0KPiA+DQo+ID4NCj4gPj4g
ICAgICAgICAgICAgICAgICAgZ290byB0dG1fcmVzZXJ2ZV9mYWlsOw0KPiA+PiArICAgICAgICAg
ICAgfQ0KPiA+PiAgICAgICAgICAgfQ0KPiA+PiAgICAgICAgICAgICAvKiBSZXNlcnZlIGFsbCBC
T3MgYW5kIHBhZ2UgdGFibGVzL2RpcmVjdG9yeS4gQWRkIGFsbCBCT3MNCj4gPj4gZnJvbSBAQCAt
Mjg4OSw4ICsyODkxLDEwIEBAIGludA0KPiA+PiBhbWRncHVfYW1ka2ZkX2dwdXZtX3Jlc3RvcmVf
cHJvY2Vzc19ib3Modm9pZCAqaW5mbywgc3RydWN0DQo+IGRtYV9mZW5jZQ0KPiA+PiBfX3JjdSAq
DQo+ID4+ICAgICAgICAgICAgICAgZ29iaiA9ICZtZW0tPmJvLT50Ym8uYmFzZTsNCj4gPj4gICAg
ICAgICAgICAgICByZXQgPSBkcm1fZXhlY19wcmVwYXJlX29iaigmZXhlYywgZ29iaiwgMSk7DQo+
ID4+ICAgICAgICAgICAgICAgZHJtX2V4ZWNfcmV0cnlfb25fY29udGVudGlvbigmZXhlYyk7DQo+
ID4+IC0gICAgICAgICAgICBpZiAodW5saWtlbHkocmV0KSkNCj4gPj4gKyAgICAgICAgICAgIGlm
ICh1bmxpa2VseShyZXQpKSB7DQo+ID4+ICsgICAgICAgICAgICAgICAgcHJfZXJyKCJkcm1fZXhl
Y19wcmVwYXJlX29iaiBmYWlsZWQsIHJldDogJWRcbiIsDQo+ID4+ICtyZXQpOw0KPiA+DQo+ID4g
U2FtZSBoZXJlLCBwcl9lcnIgaXMgZmluZS4NCj4gPg0KPg0KPiBUaGVzZSBraW5kIG9mIHByaW50
cyAtICI8ZnVuYyBuYW1lPiBmYWlsZWQgPGVycm9yIGNvZGU+IiAtIGFyZSB3YXkgdG9vIGdlbmVy
aWMNCj4gYW5kIGlmIG1vcmUgbGlrZSB0aGlzIGFyZSBhZGRlZCwgaXQgd2lsbCBiZSBkaWZmaWN1
bHQgdG8gZmluZCBvdXQgZXZlbiB3aGVyZSB0aGVzZQ0KPiBhcmUgY29taW5nIGZyb20uDQoNCldp
bGwgc2VuZCBhIGZvbGxvdyB1cCBwYXRjaCB0byBwdXQgYSBtb3JlIG1lYW5pbmdmdWwgbWVzc2Fn
ZSBoZXJlLg0KDQpUaGFua3MsDQpNdWt1bA0KDQo+DQo+IEl0J3MgYWx3YXlzIGJldHRlciB0byBo
YXZlIGEgY29udGV4dCBzbyB0aGF0IHRoaXMgdHJhbnNsYXRlcyB0byBzb21lIHVzZWZ1bA0KPiBp
bmZvcm1hdGlvbiBpbiBkbWVzZyAtIG1pbmltdW0gY29udGV4dCBpcyB0aGUgZGV2aWNlIG9yIGJv
IGRldGFpbHMgb3INCj4gYW55dGhpbmcgb2YgdGhhdCBzb3J0Lg0KPg0KPiBUaGFua3MsDQo+IExp
am8NCj4NCj4gPg0KPiA+PiAgICAgICAgICAgICAgICAgICBnb3RvIHR0bV9yZXNlcnZlX2ZhaWw7
DQo+ID4+ICsgICAgICAgICAgICB9DQo+ID4+ICAgICAgICAgICB9DQo+ID4+ICAgICAgIH0NCj4g
Pj4gICBAQCAtMjk1MCw4ICsyOTU0LDEwIEBAIGludA0KPiA+PiBhbWRncHVfYW1ka2ZkX2dwdXZt
X3Jlc3RvcmVfcHJvY2Vzc19ib3Modm9pZCAqaW5mbywgc3RydWN0DQo+IGRtYV9mZW5jZQ0KPiA+
PiBfX3JjdSAqDQo+ID4+ICAgICAgICAqIHZhbGlkYXRpb25zIGFib3ZlIHdvdWxkIGludmFsaWRh
dGUgRE1BQnVmIGltcG9ydHMgYWdhaW4uDQo+ID4+ICAgICAgICAqLw0KPiA+PiAgICAgICByZXQg
PSBwcm9jZXNzX3ZhbGlkYXRlX3Ztcyhwcm9jZXNzX2luZm8sICZleGVjLnRpY2tldCk7DQo+ID4+
IC0gICAgaWYgKHJldCkNCj4gPj4gKyAgICBpZiAocmV0KSB7DQo+ID4+ICsgICAgICAgIHByX2Vy
cigiVmFsaWRhdGluZyBWTXMgZmFpbGVkLCByZXQ6ICVkXG4iLCByZXQpOw0KPiA+DQo+ID4gSSdk
IG1ha2UgdGhpcyBhIHByX2RlYnVnIHRvIGF2b2lkIHNwYW1taW5nIHRoZSBsb2cuIHZhbGlkYXRp
b24gY2FuDQo+ID4gZmFpbCBpbnRlcm1pdHRlbnRseSBhbmQgcmVzY2hlZHVsaW5nIHRoZSB3b3Jr
ZXIgaXMgdGhlcmUgdG8gaGFuZGxlIGl0Lg0KPiA+DQo+ID4gV2l0aCB0aGF0IGZpeGVkLCB0aGUg
cGF0Y2ggaXMNCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3Vl
aGxpbmdAYW1kLmNvbT4NCj4gPg0KPiA+DQo+ID4+ICAgICAgICAgICBnb3RvIHZhbGlkYXRlX21h
cF9mYWlsOw0KPiA+PiArICAgIH0NCj4gPj4gICAgICAgICAvKiBVcGRhdGUgbWFwcGluZ3Mgbm90
IG1hbmFnZWQgYnkgS0ZEICovDQo+ID4+ICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkocGVlcl92
bSwgJnByb2Nlc3NfaW5mby0+dm1fbGlzdF9oZWFkLA0K
