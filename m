Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ADEC072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 19:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A6010E776;
	Fri, 17 Nov 2023 19:58:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72B610E776
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 19:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmF31qmEacfmD3eFJOVz0eoteefWoRXDuE6kpeiD1CaVY6ta9O+Nbd8SJ2M3P6TCFTCwQ5XjDxYnFJZ+qsp3v6suxJnCkwwwAuskSDj4SU93fPpqVwgGKRX0L6qNbAROhOzfxktotqamyvcc5Q66/lbkzYM/7tFyM5j0hTqvBECy5On5TrWw2BOg8c8yJB6SSoUbkqPNdOIROQ5F77j9i/q6SYnGFy+QYfMZOLo3tCvZe57H+JsxWw+4/2mYgZZMolGzhDeJTWfaMxIWhlEsPhEjAG2q6BqmUsVpgZ9z40QY0nswqRO8GHBPtWzNh3IHfwy/2CjRvBtuS2EbHVVYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doKtWt4Y2lI/fR4tfaCBweLmHbQ6jR505TYGihKGMQ0=;
 b=Qx71nOp+Lrga53eoZGNLrdjblXBvtGzrvb57Rs5PPmyMd5nCQ9N2EmXS/xelogFcV2p528t9vq/x2wYpD7WHTsignWbpRkZgqtTfYrJ3haAAFiw7YbT0gK6qTgcCPXMv/jLnARGaSQazvKV5jTH9whfsXN6moMlD1ybX+HvABWlGKhK/IKBB0Q6KxRU61ig8TzRUnPdL+q4IwqZh8CxhWJPjxvS83gGtauxk/eEceeKQxRDVcXUVHwTremesJ6G5jkuB1B6WyaggOeiCxRZ8Oo0xpxoRAIs1p6itOEYcNREAImcMwTExMKVFIcIVYr+H8I8Tj9YUXEAmFRpsS9VHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doKtWt4Y2lI/fR4tfaCBweLmHbQ6jR505TYGihKGMQ0=;
 b=Ib6y+4QTRnGypwTZVc6VQWH1ySzlZwmfwE0vqt5olaLIcBEizU5xATjbj6q5kDaRmCRkj6rH9MU7yyx5xi7tX4t8otJMLIMWJsKTZCNSmGmI8qLsBTVRxuqIoK0e6Jdhy5rTJWHEi8jbMTzJ01f1GN9LQLMRU4VFRnht1QhgVRA=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 19:58:16 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 19:58:16 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Copy HW exception data to user event
Thread-Topic: [PATCH] drm/amdkfd: Copy HW exception data to user event
Thread-Index: AQHaGRXGcKia9FK2+kq1vHWiLfbsfbB+7DqAgAABpxA=
Date: Fri, 17 Nov 2023 19:58:16 +0000
Message-ID: <DM6PR12MB5021F6285A5009DE24B476EF95B7A@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231117052010.3166816-1-David.YatSin@amd.com>
 <3a6feafa-f264-43ef-ad41-98cb77a2d669@amd.com>
In-Reply-To: <3a6feafa-f264-43ef-ad41-98cb77a2d669@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7c6a14ee-46e7-431a-bc33-7efe027ee4b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-17T19:55:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|LV2PR12MB5752:EE_
x-ms-office365-filtering-correlation-id: 6a49a57c-d8ef-497d-4d53-08dbe7a78a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDHilRbHysQenkGwODm2QM6B84g8uOmAEmJ3G/RdTxpGdiv+Z8+C9tx/pIvM7rTM3f+v2BfUqBKa9/RjOsDLVh9ChNIxbpsbGaC3Wvv89erbI5W4sQgL2dbamC1mTNJ5JQdpZhJDyae9Nz3/Mwtak32lwXlHmyqb+9RgFbULi5/4iCGVt1uQA9GUGDpibBJprIinPf6BqCoRVE8hNrlIuuVGH/mfZOwBDwS+mqXiHyZ4VVT84kjifkETIIuJJRJJXFtHhq3saveWHTzpBKzAfb/K6FdSPHv7EkY4hIRROB7oFY1uTEq801dXg2JofhPhlKAib5eVLcjC6JzOthbSqsaTE2svuJs/K2OK638q0r/K6z4wMLUMed7mhUo7jTV1gsOwfMOdW+efUWjhanLpsoGfSZ1L93G/c3HJNTF7mlTpBUWlggvtI24bhnIO1EYEAWowpzM5lNUlAFIBO1oHq3NV5c9Ls76kunnTzAWRgNA3F0rpXPolHDZv0dp56klnt9uSAE0BKPhQ7qnN/pmr9lexul6HAwN/85OMlBQuc/rI+SPJBuGIlQdYmjyABFXoWM9pREcxo2Tvf8r/AbHiEsb2zstf8PbsHX4gFWklOM5NCgo6dL9yas3REVHhLMJt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(9686003)(76116006)(66446008)(64756008)(66476007)(66556008)(41300700001)(86362001)(122000001)(110136005)(66946007)(316002)(26005)(33656002)(5660300002)(8676002)(8936002)(38100700002)(2906002)(83380400001)(4001150100001)(52536014)(38070700009)(53546011)(55016003)(6506007)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW5GRVJmUmQyekRKZ1dEcittd1NreTBCQk5ycTBUbHNnd3BhY2JaVzV6bmI2?=
 =?utf-8?B?ME1EVkZiMDdqMlUyVG5MSVNnMldhVHZCL3ViNmFuellDVjVhMzQyUzdMV1pk?=
 =?utf-8?B?OVNPSEV4WE1vZ2ZlbGg3Mzl2eUVBa3ZuaEtjR3ZIeUFMZitxRGpYKzhqOEda?=
 =?utf-8?B?YVJQNWNMaHdxVk02bmJFK3cyeXpzbE1xVUlaa255WDJyckdoVlVHdWVBOUZI?=
 =?utf-8?B?UmRUQ2RYK1A4akxhbHFQR1VZdEpKQjdLRlV0QXJVb1o3ZkNPM2tDK2cyYks1?=
 =?utf-8?B?SWY0SDE2RTREbzZGRlZhenRHTkdwdEdpTGF5NTZwaksxR1ZQTDk3TUxBN3BT?=
 =?utf-8?B?aC9hOGcvVjZvYnFDTHhkQ0MrcUxXRUlmRTQwdWdoRzhtRitsZGowazRhYytk?=
 =?utf-8?B?UWJ0OFlXanQwY3NLTnhnSk05b0VyVThqQlRYdjZrZ2pTdGt3N2MwbVEzWHRK?=
 =?utf-8?B?bHJ3V3M0YXNwL1V2cUllY0kxTzY0QTM0dVZrei9QV09ZZEJOYjlVZG54VGN0?=
 =?utf-8?B?eGljQzBIcTFRbGNwekxkQktHZlBFWWV0RDRQVDVDQUViSnZOZ3JJRE5leC9t?=
 =?utf-8?B?Wnd4ZUFWbE9VVVZqZkw3alJVR1FnQ2hrWXI0WDN0QUlLdEZBcGFDOCtVNFda?=
 =?utf-8?B?aDdLakwvaGFvWU12MzduK2NTclBwK0trNnV4TmI1QVFhVzlaMDRRb1FVQmhm?=
 =?utf-8?B?V3ZVRVNVc25VOE5ZbzkvaEtZWmdjRUxHVmdrZGVrY3VGdTJEa1k3cXNueSsy?=
 =?utf-8?B?T3ZSR01YaWdqVjlJaWg2UFhuMXBUU283UEVWdHZNQm1lMUgxajZSdHc0MWZO?=
 =?utf-8?B?MkFIcHgrWFc1ZmdSeVVZNjVjM280UitBc1ZUYU1CaXAxQ2FONHY0VkhScE9P?=
 =?utf-8?B?UXRCZDFnK1B6ZlRnb1RNY2Rib3U1YksrNDNhVlE0M0ZvYlhtRGFhMVdyWkdT?=
 =?utf-8?B?QVp6TFV2SlJtaHFzMnRrejlhb0dFWkxOWFJ0L2JJWThuZ1RsMlNqNzVxaHJM?=
 =?utf-8?B?NjVNRi9rYXc5bmZvYnluV0VUcnFCL2tnQ3haY0FjaVdjSUJ1bGZpOEdMeDdC?=
 =?utf-8?B?M0V1eFZIMnpTWExuVkE3SjMzbjNMa04vWEEybVFMTU5BUmdVZGQ1N1hxTVB0?=
 =?utf-8?B?UmdwZHpINE1rbG5OZm5MTUNwUVdoQXdVQitmQjFEVjA3MFBpRlJ2TnNFZzJ5?=
 =?utf-8?B?bU1tSmNyNGlRTE1IZjBmVkt2RzRYdWtIL0FkVC95NjJEekV3ZlBOTkw2VU12?=
 =?utf-8?B?N1djUzM2VXgzekdPZDhQWk92eXhBNzRsTzBCdjV3RlZKYXlJTXoyNmdQd25L?=
 =?utf-8?B?cmZ0aWVQeXJxK1hyQmI2aW9EcUN6RGpMMjU2ejQzTVA0dVl4VWdMQ205UG1F?=
 =?utf-8?B?OGtYbFoydk1DbHdCWktoUW01S25SUDl5STRUZGQrdlZ4SDlKQ0FvMzZaYm5H?=
 =?utf-8?B?SEpST2I1Y01zUUl0RkRxbkY1cTNmTVIzN0QvaUFSc2Z1d1VtQmErM21OTXVP?=
 =?utf-8?B?R2I3bnNrbTZGWEhLZzVGbzYwNzFlQlNDRlJBeldkQmNOVGtlOElyelFkMDFX?=
 =?utf-8?B?V1FxN3F1eHdNdGI1UmhxcmJBTm5UdlNQcVdrTk5tYXo5NFVxMkVvRnRqS1A5?=
 =?utf-8?B?VGN6SXhKUmllY1RWRVlCVG1LV1QzQjdNTlo4WHNudlVqMnlqdFRnUGFZcEZY?=
 =?utf-8?B?cEVLNEtqcTNtUmQyYzB0Y3hSd1M4aFdKOSt1U3ROblBNRGFrOGV3YzNmZHEr?=
 =?utf-8?B?WTQ2SWFZN05QcVpkd2hMNERpOThlWkdZL3p5aUc4M3EwZmF5Y0pTNVhrMXg3?=
 =?utf-8?B?SmZUODlrWXNJdUE2TFlBZEI5VktvSFdLdmhQVzYzaGlGY1hUZHRRZWVpdEpK?=
 =?utf-8?B?OVhpSjlGV2Z0THY5aE1jcmtDVnVSTE9WaVMrNHFKK3hIRnpCMW44cXh5cmFK?=
 =?utf-8?B?bDN1Y25JYzJhdnRKNjNGa1ZUQXBVaUhLYTV6Vm9tTzB3S1JPS2hyTzg4SU14?=
 =?utf-8?B?emFWU3FOaXFVa2pyb3QveGRzMlhyRUpxelFHVkl4cVNTbytTa1lpdTdqczlp?=
 =?utf-8?B?OVpKZWRRd0d0MXpSQzd3WVZwUkFxV2NpSlRVendsaGpWNXJVK05ZV2RTUVF4?=
 =?utf-8?Q?q+nk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a49a57c-d8ef-497d-4d53-08dbe7a78a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 19:58:16.4605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iY9jmRdn2RmJjPkMjvf70xIatOkaaUFX8gwjAbH5guSOFrCMFI3PyEvrpc/2da8JfWWq9pYrNw/HxYi1ZVn4EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBFcmljLg0KVGhlIENJ
IGJ1aWxkcyBhbHNvIGRldGVjdGVkIHRoZSB3cm9uZyB1c2Ugb2Ygc3BhY2VzLiBTbyBJIGZpeGVk
IHRoZSB0YWJzIHdpdGggc3BhY2VzIGluIHRoZSBwYXRjaCB0aGF0IEkgc3VibWl0dGVkLg0KDQp+
RGF2aWQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgRXJpYw0K
PiBIdWFuZw0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE3LCAyMDIzIDI6NTAgUE0NCj4gVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9hbWRrZmQ6IENvcHkgSFcgZXhjZXB0aW9uIGRhdGEgdG8gdXNlciBldmVudA0KPg0KPiBPbiAy
MDIzLTExLTE3IDAwOjIwLCBEYXZpZCBZYXQgU2luIHdyb3RlOg0KPiA+IEZpeGVzIGlzc3VlIHdo
ZXJlIHVzZXIgZXZlbnRzIG9mIHR5cGUgS0ZEX0VWRU5UX1RZUEVfSFdfRVhDRVBUSU9OIGRvDQo+
ID4gbm90IGhhdmUgdmFsaWQgZGF0YQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgWWF0
IFNpbiA8RGF2aWQuWWF0U2luQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMgfCA0ICsrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9ldmVudHMuYw0KPiA+IGluZGV4IDBmNThiZTY1MTMyZi4uN2QzZGIwMTdmOGQ3IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYw0KPiA+IEBAIC04
ODAsNiArODgwLDEwIEBAIHN0YXRpYyBpbnQgY29weV9zaWduYWxlZF9ldmVudF9kYXRhKHVpbnQz
Ml90DQo+IG51bV9ldmVudHMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRzdCA9
ICZkYXRhW2ldLm1lbW9yeV9leGNlcHRpb25fZGF0YTsNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3JjID0gJmV2ZW50LT5tZW1vcnlfZXhjZXB0aW9uX2RhdGE7DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpemUgPSBzaXplb2Yoc3RydWN0DQo+IGtmZF9oc2FfbWVt
b3J5X2V4Y2VwdGlvbl9kYXRhKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNl
IGlmIChldmVudC0+dHlwZSA9PSBLRkRfRVZFTlRfVFlQRV9IV19FWENFUFRJT04pIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkc3QgPSAmZGF0YVtpXS5od19leGNlcHRp
b25fZGF0YTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcmMgPSAmZXZl
bnQtPmh3X2V4Y2VwdGlvbl9kYXRhOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNpemUgPSBzaXplb2Yoc3RydWN0DQo+ID4gKyBrZmRfaHNhX2h3X2V4Y2VwdGlvbl9kYXRh
KTsNCj4gUGxlYXNlIHVzZSB0YWJzIGZvciBpbmRlbnQgaW5zdGVhZCBvZiB3aGl0ZSBzcGFjZXMu
DQo+DQo+IFJlZ2FyZHMsDQo+IEVyaWMNCj4gPiAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSBp
ZiAoZXZlbnQtPnR5cGUgPT0gS0ZEX0VWRU5UX1RZUEVfU0lHTkFMICYmDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHdhaXRlci0+ZXZlbnRfYWdlX2VuYWJsZWQpIHsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZHN0ID0NCj4gJmRhdGFbaV0uc2lnbmFsX2V2ZW50X2Rh
dGEubGFzdF9ldmVudF9hZ2U7DQoNCg==
