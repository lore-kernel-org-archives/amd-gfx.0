Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526CFCD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 04:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B1010F40D;
	Fri, 26 Jun 2026 04:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="onc8D/0h";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6828010E2F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 04:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea9+VyVgRqgdgvPZnptuqfM7e/8ufV1DOm6HZ+yYv8aZxuRGYspSptRZFDZGJz5/WN3JfSodzQxXJkujPcpYmJZrzDrMCnXrZfG7Znj6VhGslHdO7K+EpbyxJ94+A7oSTbK6cIPiFMauALLlZqQgn1cVyPlJntHa4+aMOchVs/ak0XL3kwoAsYfV5BnnY39GgsWLDmSGIW37wsDdE8tIOyre8YnhLRbunS5+V8T3wdpb6uAYr6Yb5dTLGUviZ5xFLeNtFayImftjeVMRoFholOixVGkvmbvoymUnZWUqCwxScMt7iwT/qvtm1MWkou0n3NtctQGMRvJa9wF6dTzrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1hNJ6Z8wknzPWfLDoE1OSfi386IS3p04KpP0zPuqo0=;
 b=G6RkpGRIOi99lttMy4R+iC3JCpSk9s3ZzsfGrdcvJTHgqaB8bOPFToBxzArBmfkysx7BSg8v2YuEx1oEQBpmsbbXGgo+XoVrwKOVCGZAvd25dCSRt6ERxTKOz8V9nY+A9inIgA3KhOHOHprx9wLtySawc0TVxou3zDDmg7zltOktkYj2J8s46W5yeylwWF6Ibgq7JT6PvhdUSkUyNwG67nb2KwfBypWLFz14wdEOykeXwHFlEhKO9cekpF/RE7cTKag37knYBcaSexjr9aHoegOZUBMi1ACJ0r0tIt55Zx1dlud7vLi3WCJD9aM6f83rD5FWZFjQHU8NjnP3eX2Y8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1hNJ6Z8wknzPWfLDoE1OSfi386IS3p04KpP0zPuqo0=;
 b=onc8D/0h5i7eqlsQUBMJ+lSswlBxnRyA6OVqnJW60vBTxJ1VB82B5vi4KDaa9qBekeBHj78oSDtnqb8NKBrnxokyZHBbP9dzpAjw6GJZz6C8zqmmnJuLBNtOfQqt//DnTEvuzmCf4VwUqAAqlE9QHbHZSauq7K/+npdv4jqRyiI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 26 Jun
 2026 04:25:25 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 04:25:25 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix false error return to non-KCQ
Thread-Topic: [PATCH] drm/amdgpu: Fix false error return to non-KCQ
Thread-Index: AQHdBRmHVRGaCr0EhUKMFBHs1XYcxrZQPWEQ
Date: Fri, 26 Jun 2026 04:25:25 +0000
Message-ID: <DM4PR12MB5152F31A6EDD4A7E7F32FB1DE3EB2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260626031116.104290-1-amber.lin@amd.com>
In-Reply-To: <20260626031116.104290-1-amber.lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-26T04:25:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB7101:EE_
x-ms-office365-filtering-correlation-id: 1fedda69-cb7c-4120-0da5-08ded33af1f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|6133799003|18002099003|22082099003|56012099006|11063799006|3023799007;
x-microsoft-antispam-message-info: dGNQVwCYBR8txaqvN6bsE4sb5UT11oAcXuSvqKsKbNgbAIBHgMFtMm1ig25vBQXt7fb+GOf9jR7mBUwG0dbaa8735wTNaeKrX5GiOxy4nxRWCnohD6sUf6tjlt+wAH7lXdZo+XfXa1S0S0+4++P29kgNyk1HjIQJJvqTi58GJW6gz901jTOAfRVCDo3uqOtuJ6rnRbKHfVIsHkAZARJ2I0vz/HHRjwhG+9H4X7RUwj9uT69bTAPkWItTXYXbqsE3JGo2rvRZmRBSumBltpA3BtqeVAxw0ZbJE8NCuFvr8mKLmz2O+8ljRkt3nZei/8f8PA8p2Aef775frys5l4efMPT4Wuwj0/fvBk7kS7/6V8+ncC5CYCqYdebSXZX7aqAD+CP/krvNRogFgPqsCIz66EV2Bbk4Vz95cnCODLTgaZ2kD5xRo1nZujThBTBPOSerHLmQTTwJsHV9CD6zIPz2Xg5uqAGMCoj41x8xepTS8eYRAH1U55Mv59q5h+G4YV9F0XgmxfQ765XujRi/R9Y3EdTTl/wOdtsEjw2f++n9JGaXtWLANtRzI0UiqhwfgB4cEX3CHN1uJd6gzuYneeY7WqTWYM2ZVOClRIuQglRZtDp8Dlr6jGlv/AKv3/eFcbpYrT/2UTdAKdXGBziBKDlvvth0zdjjyW2bkatfZc6LPUhKUoOI20BLPZR6YCVx/i7T3EG9LPCA5qi0A9rnE1eb+B331b8XBlNzj7rLzBEjZQ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVZCOXVWNjA2MkErNmJnSU5kNmpHUGYvRFk0Y2VnVG43dmdnT1J2UlhiNXVF?=
 =?utf-8?B?eUJnMnE0ZjFBei9YWlRDYUZHVFUvUWhqb0t4YzZYYmxITzVMZTRYbmtJQ1Y4?=
 =?utf-8?B?Wi9ybjNxQWxacnZERmU5SC9SSURhK1I5SEt1MmtPQndBbno3VnUxek9GZGJG?=
 =?utf-8?B?V01Zci9jRDVNZTBPT2N5bFkrT0xRaVBTWXpHUDdkMmxsQjVpRlUzQ0p4YWc1?=
 =?utf-8?B?ekthV1JHVyswRHdKWCt0WjlodlE3Y3VCMGZvRnRDTjJtUHA2cWdlZng4VW9Z?=
 =?utf-8?B?b1RHdlRQZTExQ3I3Ty91TzlpNFVaTmpWVUZ2dHd3RTNVVlBWcnVZNDF6Nk1v?=
 =?utf-8?B?dFZvNlFXZ09WYXkwU3NUSndJaVJtV0JtdS9NMVRLeFJkc0pRdTRiUllWZ3JV?=
 =?utf-8?B?L3hTYzhFdjJQWC9DYmN3OTRPbVNhdENIdFo4YVRxcjdKaFhyNkRzWnFiMnBq?=
 =?utf-8?B?UWtTZWpJMm5mb01NQWNnZkMrNnFKUFRneDRTUks1eWtjOXBjUTJJZE1LVWs1?=
 =?utf-8?B?cmZOQzdPMlNIVlp1Q0t4STR5K2J5ZXZSZGJhenJQaUE2THZxOVozcE9UOUk4?=
 =?utf-8?B?b0ptdmhlNFJaMTd4aFhIeWRBaWU4Nkxoc2VaaWRnU3JTQVJkSHFXSXFrODdj?=
 =?utf-8?B?eTMza0R5YkZEOVBsMGVvMG05RDFHOERRN1dORHdsTkRKR2o5Q1JvQnltVzR1?=
 =?utf-8?B?TGpFUTM3NHlpd2JTZU1tbEhCbFpDc1c4djRwbzRmeVEyNG44eGlmQ3E4d2w4?=
 =?utf-8?B?WTFncUc3S2cxWFhSb2IyZmQ0WWpETHRQQThiQW1XNVBwZ3UyTE1IeTZDbXdG?=
 =?utf-8?B?Q3FuN3VpTHM0ZllwR0l5aVVoMHNMWjJXSzVHTDdmUlJhN1QvK1I5b213V2tn?=
 =?utf-8?B?OUppUnFIYjFsU2JKdnpYcFl3UmgwUkpTOGRjZ09HQ2lrVDU4UUFFRTVrUWtB?=
 =?utf-8?B?RENmVGxOaE9KekI2YklWRlBrRG5VS2twV0NFWkx3L2dkakhHVmVLUHRLTmdr?=
 =?utf-8?B?Z0J0b2M0V3JXSU9NdWJVRll2dXBueWE0c3NvTWNweFhHam1jdGtuZ3NTTFRW?=
 =?utf-8?B?WTY2cXJhYzA0dDB3Y0kvUkdFL3FMYXV0ek5LRmt6MHA5VVFFS3hBWmFJWlBR?=
 =?utf-8?B?Q3NVTzNpZXdzK2dvVllxZDA1ZGFvNmNzQVJRZ1FQUStiMHBNckR4cGRtNHRK?=
 =?utf-8?B?RXJCSEVIRmJJY0wxcFpPaEN1QjF2WENnTENlVUJsTndJdlFTdkZtMDdxcWkw?=
 =?utf-8?B?dkhCejZtbG5WTXlMWHhBaVljMDhqQk1DV2t3ZG44WXZBQm55NS93Sm1ROUg1?=
 =?utf-8?B?cWx2NTd4enFtL2w0WndvRjFxdGNoQTZRZmVmNVVTL2xoOGxXcGVlTHVySy85?=
 =?utf-8?B?ZmpFZkp2U3V4ajhsYmF2SksycnpXT2dtb1k1ekplbi85TVpZQm5yazYzYitU?=
 =?utf-8?B?eEJhaThZOXhETFhONHhRVVpMbG9QRUNlcnNDa0FpSGlWT20rMHdnOEtsVjFQ?=
 =?utf-8?B?RGU2OXhhNUdxR0Y3ZnoyeGowUjBTdmxrRHNaSHk5N0xPSG14TDFOazdGWjNM?=
 =?utf-8?B?c1RHcFA0Nkp5T1ZnazNkRXJ6SEtPZjN4TkFGQld1ajdicHFZREYrendwUjhv?=
 =?utf-8?B?RlpZK0o3OTBkclBQcjBNRkNVM2VraGJ2S0lyQzVYL2xrRUtRRDNOTUFZMTRZ?=
 =?utf-8?B?S2RUK1JrQWVid3dLdDF3dHJ6Q2RqMTR5WHZLTFBJRzFtKy9WcXlWY0FUczJE?=
 =?utf-8?B?TWp0bjhpd08yUlZyZExvREsrVmFZSEkxcGl2c3c5SVBZK01VUmZ2bXBmMUwy?=
 =?utf-8?B?di9VTy9TT3U3cG1FT044eTV1dTlnbGRtYnlTMnJlSXowbzFlWTdhYnJIVmZn?=
 =?utf-8?B?WDdabUhlTE9yNytEb1NTNkwrN2Vsb3V4cko4TWtKTmNVNUpiSWFCbkx4SGRa?=
 =?utf-8?B?b2FHajRVUDltM2J5dEFzV2dKUG5vRHA0UmNYcGNQa0VyeHZJbXF1c0YwcnhC?=
 =?utf-8?B?L0NUOXBXTjVoMHZqaUNhTWhzMk9rY1F6WnZSU2ZHVERmS1Q4UW8rTTVZL2VN?=
 =?utf-8?B?YjRXeitVU3BsQ0Q3ZnpxUG5icXk5cVdTcGxtOC9YNGhYQ28xd1llaXJLM2dq?=
 =?utf-8?B?NUVBb0hvd2pVWTVYL3FNL0lrUGhmWXUvTHZMdXhjeEZ1YU80QWV4bU55TXlp?=
 =?utf-8?B?VkpsNnNFUEE2cWs3VU5Xa1N4dWF0ZnhCcDNQL2swbVplSWtzaHhxa1hOWS9z?=
 =?utf-8?B?ei9kUzNEbVJJeERVREZJVHpSdWZOVjJmbllIbWp4dUdDNEY1ZVdYVkZpRU5v?=
 =?utf-8?Q?z56yjYWaWrvVUCB2EW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fedda69-cb7c-4120-0da5-08ded33af1f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 04:25:25.3538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvU6lqkkLnkUH2RbOryBKqObDDEZGxfWuS7yHyW1CbCUTOpar+cKhS1jCfEZrRMytciAgSDtAE/hY8Si8KesnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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

QU1EIEdlbmVyYWwNCg0KQWNrZWQtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29t
Pg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbiwgQW1iZXIgPEFt
YmVyLkxpbkBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMjYsIDIwMjYgMTE6MTEgQU0N
Cj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSmVzc2UoSmllKSA8
SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gQ2M6IExpbiwgQW1iZXIgPEFtYmVyLkxpbkBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBmYWxzZSBlcnJvciByZXR1cm4g
dG8gbm9uLUtDUQ0KPg0KPiBhbWRncHVfZ2Z4X3Jlc2V0X21lc19jb21wdXRlIGlzIHVzZWQgdG8g
Y29vcmRpbmF0ZSBzdXNwZW5kX2FsbCwgcmVzZXQsIGFuZA0KPiByZXN1bWVfYWxsIGJldHdlZW4g
S0NRIGFuZCBjb21wdXRlIHVzZXIgcXVldWVzLiBXaGVuIGEgaHVuZyBxdWV1ZSBjb21lcw0KPiBm
cm9tIHRoZSBjb21wdXRlciB1c2VyIHF1ZXVlcyBhbmQgdGhlIHJlc2V0IGlzIHN1Y2Nlc3NmdWws
IHRoZSBLQ1EgZmFpbHVyZSBhZnRlcg0KPiByZXNldCBzaG91bGQgYmUgc2VudCB0byBLQ1Egb25s
eSBhbmQgbm90IHRoZSBjb21wdXRlIHVzZXIgcXVldWVzLiBDb21wdXRlIHVzZXINCj4gcXVldWVz
IGNhbiBvcGVyYXRlIGFmdGVyIGEgc3VjY2Vzc2Z1bCByZXNldCB3aXRob3V0IGEgbW9kZSByZXNl
dC4NCj4NCj4gRml4ZXM6IDJkY2Y5YTVhMjM1MiAoImRybS9hbWRncHUvZ2Z4OiBkZWZlciBwZXIt
cXVldWUgaGVscGVyX2VuZCB1bnRpbCBhZnRlciBNRVMNCj4gcmVzdW1lIikNCj4gU2lnbmVkLW9m
Zi1ieTogQW1iZXIgTGluIDxhbWJlci5saW5AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgfCAxNSArKysrKysrKysrKy0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+IGluZGV4IDk4MmI0MTYwNmQ0
OC4uNTJkZDI2ZGQ4MmQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2Z4LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dmeC5jDQo+IEBAIC0yMjgyLDYgKzIyODIsNyBAQCBpbnQgYW1kZ3B1X2dmeF9yZXNldF9tZXNf
Y29tcHV0ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgc3RydWN0IG1l
c19yZW1vdmVfcXVldWVfaW5wdXQgKnF1ZXVlX2lucHV0ID0gKHN0cnVjdA0KPiBtZXNfcmVtb3Zl
X3F1ZXVlX2lucHV0ICopZmF1bHR5X3F1ZXVlX2lucHV0Ow0KPiAgICAgICBzdHJ1Y3QgYW1kZ3B1
X2dmeF9kZWZlcnJlZF9lbnRyeQ0KPiBkZWZlcnJlZF9lbmRbQU1ER1BVX01BWF9DT01QVVRFX1JJ
TkdTICsgMV07DQo+ICAgICAgIGludCBuX2RlZmVycmVkID0gMDsNCj4gKyAgICAgaW50IHJpbmdf
ZXJyOw0KPg0KPiAgICAgICBndWFyZChtdXRleCkoJmFkZXYtPmdmeC5tZWMucmVzZXRfbXV0ZXgp
Ow0KPiAgICAgICAvKiBzdG9wIHRoZSBkcm0gc2NoZWR1bGVycyBmb3IgYWxsIGNvbXB1dGUgcXVl
dWVzICovIEBAIC0yMzc1LDE3DQo+ICsyMzc2LDIzIEBAIGludCBhbWRncHVfZ2Z4X3Jlc2V0X21l
c19jb21wdXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgICAgICAvKiBOb3cgQ1Ag
aXMgcnVubmluZyBhZ2FpbiDigJQgcmVwbGF5IGJhY2tlZC11cCBjb21tYW5kcyBhbmQgcmluZw0K
PiAgICAgICAgKiBkb29yYmVsbHMgb24gZWFjaCByZXNldCBxdWV1ZS4NCj4gICAgICAgICovDQo+
ICsgICAgIHJpbmdfZXJyID0gcjsNCj4gICAgICAgZm9yIChpID0gMDsgaSA8IG5fZGVmZXJyZWQ7
IGkrKykgew0KPiAgICAgICAgICAgICAgIGludCBlciA9IGFtZGdwdV9yaW5nX3Jlc2V0X2hlbHBl
cl9lbmQoZGVmZXJyZWRfZW5kW2ldLnJpbmcsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkZWZlcnJlZF9lbmRbaV0uZmVuY2UpOw0KPiAtICAg
ICAgICAgICAgIGlmIChlciAmJiAhcikNCj4gLSAgICAgICAgICAgICAgICAgICAgIHIgPSBlcjsN
Cj4gKw0KPiArICAgICAgICAgICAgIGlmIChlciAmJiAhcmluZ19lcnIpDQo+ICsgICAgICAgICAg
ICAgICAgICAgICByaW5nX2VyciA9IGVyOw0KPiAgICAgICB9DQo+DQo+IC0gICAgIGlmICghcikN
Cj4gKyAgICAgaWYgKCFyaW5nX2VycikNCj4gICAgICAgICAgICAgICBhbWRncHVfZ2Z4X3Jlc2V0
X3N0YXJ0X2NvbXB1dGVfc2NoZWRzKGFkZXYsIHJpbmcpOw0KPg0KPiAtICAgICByZXR1cm4gcjsN
Cj4gKyAgICAgLyogSWYgdGhpcyByZXNldCBpcyB0cmlnZ2VyZWQgYnkgbm9uLUtDUSwgdGhlIEtD
USByZXN1bHQgYWZ0ZXIgcmVzdW1lIHNob3VsZA0KPiArICAgICAgKiBub3Qgb3ZlcnJpZGUgdGhl
IHJlc2V0IHJlc3VsdC4gSXQgY2FuIHJldHVybiBhIGZhbHNlIHJlc2V0IGZhaWx1cmUgdG8gdGhl
DQo+ICsgICAgICAqIG5vbi1LQ1EgY2FsbGVyDQo+ICsgICAgICAqLw0KPiArICAgICByZXR1cm4g
cmluZz8gcmluZ19lcnIgOiByOw0KPiAgfQ0KPg0KPiAgaW50IGFtZGdwdV9nZnhfY2xlYW5lcl9z
aGFkZXJfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gLS0NCj4gMi40My4w
DQoNCg==
