Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19446C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 19:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D90210E1E6;
	Mon,  5 Jun 2023 19:47:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D188B10E1E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 19:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHw+d+iSoWoCBZCCtAM2FHwbsi0RwZ074sR3z0TEyg1adwkNTmPIwLv+dYIYpzkoXM/aNLL1aKc3I6go9Zt/xFgaUN8Aje0n/w0ttIA1zYAndg/NQTvvBR3vmRNlivLvA0IJy7E1gg60vpPzJGkwDcjf0WuGzNFBQmUma940GsX/AUxJBOGg2l/QwfJp4DrAPcyvJZDhjVkX38k20DQ8VyJYWVuemoSrlNLWLoUS8YsCd94pYO1/yYIv8fnYifJl0x7vsk6C/NTX1wjt0l4RgLUP0CC5wc40l6aoH8EIdqzGUmH0puGc0wjrGQmNR/RMb4IH8U5UlXdlj7crv/ayHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI3PDYv53UfioK55DG9+gzpUJJC2axvT4aH4uzE6xuc=;
 b=fcq6FcDQ53Re1UYChA4xtk2qncqhugYgC+8qlQepopSSi5PDI2iykthPHUiCXqz6nAuioZb+tTaOBrmcAS4aw74U9kccGWEk339QKQmGzC+rw4Y6a/mwzhKXT6tMdlOpuSrc0qZiUK5yv+YiZSoFEFSx5DZhUybiBTaeDCJuymJeVmXEyRXTjOAM7FbUiIl5dcxC6B8C/vrEJBXxgYHqY8BAsuYxiB+4zR6ewxkknWLTrrfigan/q8qPoxrsFDUjd0/Fylszjs9PPKhtDD8kda6/R2FwSzhsrfhFZ0mL1Su/KnzaaN7/R2SOZlRnfUA2ojk3RRq931bqbpawLY2K0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI3PDYv53UfioK55DG9+gzpUJJC2axvT4aH4uzE6xuc=;
 b=KqXAslJ+VLddwNwxr9Ujj3NrKmyJQtlF5y1VAwaDzaT0eH8mg1tgpCe/qqLm0+3Cc9IJUvpt+kZhB8ntjgDpewfUfXxyorgneyMLB7hbzjEBGdsdfzpxDOpXA1O+tLdKKBpOXRCt2dsn+Z6/eUinK771AqHeBvv6ifTQv4CtJg0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 19:47:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 19:47:50 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Check that a system is a NUMA system before
 looking for SRAT
Thread-Topic: [PATCH] drm/amd: Check that a system is a NUMA system before
 looking for SRAT
Thread-Index: AQHZlcGxTvULxH/41E+PhMDFPT3bR698oRiAgAAATwA=
Date: Mon, 5 Jun 2023 19:47:49 +0000
Message-ID: <MN0PR12MB6101EEDAB491C10E8332461EE24DA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230602121806.25441-1-mario.limonciello@amd.com>
 <2395f465-fd8b-8b9a-5ea3-82157ddd4fa9@amd.com>
In-Reply-To: <2395f465-fd8b-8b9a-5ea3-82157ddd4fa9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=441c32aa-b1e5-4cb8-96dc-da394a15f100;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-05T19:47:20Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB7347:EE_
x-ms-office365-filtering-correlation-id: c9e8c3ed-88fb-4d16-6bf5-08db65fdbe86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymQGXgUrnA9sgmXCX21CSNJWlOMMbmaYDVtjsBmZukqmpegXD9QiuD7Z0w0kVTB9ngYYYvLNOYOqo/mbki5D7V5Rw5dmRQf71jLbOBQPrO2WJ8b7bXlaGwrWY1t2a9L+CVpMAAXknhHXIzFjm7Ndx7CbQcHWB939hf5g/BFdFRm6RfT7m8CDNij0LD6YHPFQufaaSEaFTB9qR/wLxGJWafCSWcfEVJum/N4W2TVjcHRnYUNnZuOASwVtbef0ynm05hVZ7TMZUWEhQi07eLRCGbYbRL3qvy13RlQsks5PiafQGWkOoj5hdq9znnVrTmAI49LzIIXiw3K+F6sBGgfOikBA/g2fNEdwXc1EuyEYNnbeBdUbCljGY+th+JA0EPbNs4vX7eY89LNEMdIaDyqQPPymbaS0tsWYe9ka0jcrV/PfFbcDvlmddnRWJ5ekBMK4Mfd6yAZ9dPirXeC2utr9VBSNFw8WMJXiymo7XGS0kxqAofMXg+dKhEKgYc09xOW1FhxSH5cEMRf/dAYt9XCaXL18ch42HDNd8YkfURq++znRdWiJVXYNvb3tMzm2c8MmVQGjzIpvgkPEkfW20CHtyZfHBvyaLC+lVFODZPRzn/j4ZuHgen9XEszBS8ohhvzV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(8676002)(66556008)(76116006)(66476007)(5660300002)(66446008)(64756008)(8936002)(66946007)(316002)(55016003)(41300700001)(52536014)(110136005)(2906002)(478600001)(122000001)(38100700002)(186003)(9686003)(53546011)(26005)(6506007)(86362001)(33656002)(71200400001)(7696005)(38070700005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm5zOWhLeDJFUTBBQmRYTTNvRENybHNDQ3pOWnE3QTJsRWtiZGdWYUxkdGVM?=
 =?utf-8?B?ODRpckgreUpIM1F4SERadTFoWWFoWC95RFFxYzgzcU5KTitadHVKK3EwYXBK?=
 =?utf-8?B?QlRTeDNPZWphLzVsN05SU0lMaWg2ZkUxRFdkYUNRR2Q1SnNFVGtuNzExMlJR?=
 =?utf-8?B?VHlTM3k3bENERjJKSmdqQjVYRi9yb2dOcEh3ZFdFblR4T3hFcUovVkdwQnY2?=
 =?utf-8?B?MVNaTEJnQ011aER2RE9mVm1tRVJJVitjdzNNVnl0Rm9NY25TOHhNb0c4TFFy?=
 =?utf-8?B?ZTJHcDhvN2VVbHZmSHpVSThHS2hxaUJxWkZOdDNQOGJLMzFudjlUaFlHYzlB?=
 =?utf-8?B?dWhmUE5oeUk0dWNTSjVma29CbkM0aXBpQi9TUWtlcGQ3ZXgxTTdpUFhGak9C?=
 =?utf-8?B?Sjc3dndteDFNSDNyQmVHZ3NnVXpYOUUrdUI3alNuc1V6VEF1dHRta0g5TG1G?=
 =?utf-8?B?aWdUT3kxZStPNHZJSFNrTlpYRk5qTVpEYUI0b3F4U1V2SUwzaHhtd0pTa2FK?=
 =?utf-8?B?YjhZdG43Z1JtYVFlQzR2Z2RYaGxwNDg3UHU2S2MxeG0yWFlaYXowbjl3ZVR4?=
 =?utf-8?B?UU4rQzFrY1pWM2xlUzRBWDUzNzlSMEM1OTltdzJjUXIyWTdwVUZOdXpocTNG?=
 =?utf-8?B?cnZ3YS9jVlc4aUFYUmVBRzdYNkNBcXhZWkR3WVp5MWk1SEduRkh0YXRQK3Y0?=
 =?utf-8?B?M2ZqQVpBb09nMDVnQ1NTQW5INHBJQkRKc1BBOXh2R1dRN1NRYTdHeDB5V0Fi?=
 =?utf-8?B?azZxbGZvQTQycjcwTkFWOU40d29LUzFmSzlsMDhvYzAwSWhSK0g3b1ZZYzZJ?=
 =?utf-8?B?NkF5dDIvT0lqdmpJU0lsVWZodmhCdE03OEdQRUpJbC9GSE8wbjhyaEU4d1J3?=
 =?utf-8?B?Vk03UGprMFltM2dvbll0MzBMM2kxU0VSK1NnZmZtNlZqcGxvT0xXMTlSUlJV?=
 =?utf-8?B?WklNTU8yeDM2dUp5MXdmVkllb1E1akM5QXVSL2NyaFNxM0l0TzVDanRMblpI?=
 =?utf-8?B?QWowSDVyRytzQkVOdVhiYkM3cjdWbWVzTG51YUN1S01zSEkvYzh2OGhLYUNn?=
 =?utf-8?B?MzVwQmpMYk9OQ09mbWFHZzBTbmVZOTFBeWo4Q0lVelUvNWhrT2psb0g1eXp1?=
 =?utf-8?B?bE1BMUJUWGVhZEx1clNZNERIcjVJZUphTHJMa1NJMm02eGU2VFZIQlJaWWpR?=
 =?utf-8?B?Z2NhVU9mWi9MenR4OVBTclk3K0o1cU5pYjljMUd1NEdUQmtPNmhWenNFZGVK?=
 =?utf-8?B?b0N3cTFWSDgvMGpIUlp5OVlSY3hOUHBaUGd6bktId2liRldCOGJjUXJOamFX?=
 =?utf-8?B?ckI3c1pjNmJncXY2bU5FdWE1S2wxSDVhTjd0UjUzSy9kS1VyT2RXWUprMGFV?=
 =?utf-8?B?SElScDg3QTVJQUxKOEI4a01hdVBvdXgzTUZrdmsxY3RPRVZ2WStvbUJpMmFP?=
 =?utf-8?B?RUFOWGhyM2ZuWTRQQnhjODZBWXhPck1UZGdkWHZURllsYVdsUlNMa1hrT045?=
 =?utf-8?B?d1lCREVBclJwZ1lGRnYwSkwyc2JoV0hpSERDZmdNREhKWnlkTGVkZDEyVmow?=
 =?utf-8?B?dHp5MFBMLzM1WVYyTGpoODNZVE1jREwyc3FYQS91ejUwSXVsODdTWkpTcWYx?=
 =?utf-8?B?ejNpSVU4NVpkK1VCWXpHYjJJR3laVTllRWlWSjBON2NrUlpTcUxLVE1zc2JG?=
 =?utf-8?B?RmJXNG9tZUJtYTlqMmZYaFJ2UVpXaGRIc0EzbTFlMG1hMmJhcGFMMkZZMlFw?=
 =?utf-8?B?QXVJcmNIR2I2UGM4OEZXUFdZY094WlVqVGxxa2p3cWRNUVA4bXhxZlEwNWxK?=
 =?utf-8?B?WW44MDArU0tWVDBFZWdLZ2dXRWtuWmdJRks2ZWZ4OGZvcitsM1U4aG1UeFBp?=
 =?utf-8?B?SEZPZ0hXMUFJdHhKU3ZlbGIyYk5zQ01IOUQ0cklxQmFVU05qdkV6SXZWaHh0?=
 =?utf-8?B?STF5ZkxJQm5vM3hjUmlxWmN3RVkxN3BsOXVMSjVuM0oyV1YyS3FFRWt2UlNh?=
 =?utf-8?B?S3RGV3Bhb1o0WDJZUFVxVEdGN0xHdnhLYjZFZ3QySHgxZjVxSElUVUdQL2wv?=
 =?utf-8?B?ckIwT2U4YnJHa2pwVnZxYTBDSEloZFNRYUJ1bjR5eHNUeFVLZTE1WlBnTno5?=
 =?utf-8?Q?TNq4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e8c3ed-88fb-4d16-6bf5-08db65fdbe86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 19:47:50.0267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuQdvUGD7bFnTsenCaZAbLB3Ng91i8BbD6TBSuORYZUou9czauAMTXmjKd9McJRg67ZMO8MwX1urqkG2BWpvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

W1B1YmxpY10NCg0KPiBPbiAyMDIzLTA2LTAyIDA4OjE4LCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90
ZToNCj4gPiBJdCdzIHBvaW50bGVzcyBvbiBsYXB0b3BzIHRvIGxvb2sgZm9yIHRoZSBTUkFUIHRh
YmxlIGFzIHRoZXNlIGFyZSBub3QNCj4gPiBOVU1BLiAgQ2hlY2sgdGhlIG51bWJlciBvZiBwb3Nz
aWJsZSBub2RlcyBpcyA+IDEgdG8gZGVjaWRlIHdoZXRoZXIgdG8NCj4gPiBsb29rIGZvciBTUkFU
Lg0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGlt
b25jaWVsbG9AYW1kLmNvbT4NCj4NCj4gSSB0aGluayB3ZSBkaXNjdXNzZWQgdGhpcyBhIHdoaWxl
IGFnbyBhbmQgSSBkb24ndCByZW1lbWJlciB0aGUgZXhhY3QNCj4gaXNzdWUgdGhhdCB3YXMgbWVh
bnQgdG8gZml4LiBXYXMganVzdCB0byBnZXQgcmlkIG9mIGFuIGlycml0YXRpbmcNCj4gd2Fybmlu
ZyBpbiB0aGUga2VybmVsIGxvZz8gQW55d2F5LCB0aGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4N
Cg0KWWVhaCBJIGZvcmdvdCBhbGwgYWJvdXQgc2VuZGluZyBvdXQgdGhlIGZpeCB1bnRpbCBJIG5v
dGljZWQgaXQgYWdhaW4gcmVjZW50bHkuDQoNCj4NCj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KDQpUaGFua3MhDQoNCj4NCj4NCj4gPiAtLS0N
Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgfCAzICsrLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jDQo+ID4gaW5kZXggOTUwYWY2
ODIwMTUzLi4zZGNkOGY4YmM5OGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NyYXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9jcmF0LmMNCj4gPiBAQCAtMjA0MSw3ICsyMDQxLDggQEAgc3RhdGljIGludCBrZmRfZmls
bF9ncHVfZGlyZWN0X2lvX2xpbmtfdG9fY3B1KGludA0KPiAqYXZhaWxfc2l6ZSwNCj4gPiAgICAg
c3ViX3R5cGVfaGRyLT5wcm94aW1pdHlfZG9tYWluX2Zyb20gPSBwcm94aW1pdHlfZG9tYWluOw0K
PiA+DQo+ID4gICAjaWZkZWYgQ09ORklHX0FDUElfTlVNQQ0KPiA+IC0gICBpZiAoa2Rldi0+YWRl
di0+cGRldi0+ZGV2Lm51bWFfbm9kZSA9PSBOVU1BX05PX05PREUpDQo+ID4gKyAgIGlmIChrZGV2
LT5hZGV2LT5wZGV2LT5kZXYubnVtYV9ub2RlID09IE5VTUFfTk9fTk9ERSAmJg0KPiA+ICsgICAg
ICAgbnVtX3Bvc3NpYmxlX25vZGVzKCkgPiAxKQ0KPiA+ICAgICAgICAgICAgIGtmZF9maW5kX251
bWFfbm9kZV9pbl9zcmF0KGtkZXYpOw0KPiA+ICAgI2VuZGlmDQo+ID4gICAjaWZkZWYgQ09ORklH
X05VTUENCg==
