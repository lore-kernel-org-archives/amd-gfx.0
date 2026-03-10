Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D8FCC9DB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 08:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A683410E20C;
	Tue, 10 Mar 2026 08:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NaAN37X2";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBA510E20C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 08:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrJu8+SKBXnUuWytQEONXUBzT5TiTskSVZSK2rOfizgxUJV56N7Vpq3trvC7BCBceZTm7l5JdJrUWmZdwPt8GMhDi5FLYW/ybL31XihcXMYrcbVsOjIj9Htg7p+Px8NEUTXhTuf2lh4yKdpq7Ia2CpXRqed/nlHGuNapgVZD/lHLhJlMNKFY0sUfWKcAdzPDY9JYVtUe46y2dHvdptwzIPuKO3Hx54BdbrjmAGgnnEDJOMxC1zTx2rWR2onTfjyCbHZaoHHSdLdzFR2FodK4+AKJCFNeS+w4GzVpyaEjX2rNfPh2aOVGLKiWqmN7WwbNZ0pGkqQzEw0ZRtV7UVzO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZFXYLc3rOq9lw91REul5t0x56XzllT3sPVb8bXiSnQ=;
 b=J83vzzN1prY73D8RlvFOTzCMHe2njuWcAsqHqYCh+/gacDdAUTLcduaHgOrlpWk7tX/Pk0fcnGdT9BjTAqvyydfib/rz35wYcARPz5UFNLzQ+iYDTy2yEW92CJXOyn63NT89Hy2H4Z5bO31Cqh07BxGbLAbmphRE8MuwfNZbfis3vDMon0St7maNuEFXqzJEfRTj0TTBrBqjrKgWnWFvCimGEC3kWGpVAN8RQNThgJQvG+WHjyDwqLOjhufNQbWi2pDUPGvHF2P9Ug9eiGArn6OVqvbbokYc5OjxNWsiM9HrP9NatSf6+8GsWMlsD45F0y6uBMP8dLwqT46bTQJHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZFXYLc3rOq9lw91REul5t0x56XzllT3sPVb8bXiSnQ=;
 b=NaAN37X2el1e+YOUfwOSeMBkgAkK/7cuRUU6GIIWkWmqGItCMKelD+z32hWu0XztvA0Kf1alTpCzgOTLwmsWOYEz/Mr5WenYjeyirmhpeqUz8hQ+CA29nXxrvZb8mjxEoSZ41oyUF+6gtZhu/065LIxtwfJIrK03GCKdWE2uI7A=
Received: from DS7SPRMB0018.namprd12.prod.outlook.com (2603:10b6:8:78::7) by
 MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.9; Tue, 10 Mar 2026 08:47:34 +0000
Received: from DS7SPRMB0018.namprd12.prod.outlook.com
 ([fe80::3603:32e4:68b8:639b]) by DS7SPRMB0018.namprd12.prod.outlook.com
 ([fe80::3603:32e4:68b8:639b%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 08:47:33 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove the WAIT_FOR_SUBMIT flag under lock
 context
Thread-Topic: [PATCH] drm/amdgpu: remove the WAIT_FOR_SUBMIT flag under lock
 context
Thread-Index: AQHcsFvxfI3mDugs8UWM2hLaE5UearWnbSKAgAADqQA=
Date: Tue, 10 Mar 2026 08:47:33 +0000
Message-ID: <DS7SPRMB00183B0CE49B4CB23A7B0F82FB46A@DS7SPRMB0018.namprd12.prod.outlook.com>
References: <20260310070252.3217741-1-Prike.Liang@amd.com>
 <92a288f6-26c9-4b74-ba11-3b4d6a94ca4c@amd.com>
In-Reply-To: <92a288f6-26c9-4b74-ba11-3b4d6a94ca4c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-10T08:41:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7SPRMB0018:EE_|MN0PR12MB5809:EE_
x-ms-office365-filtering-correlation-id: 7ccfc64d-0bd7-438e-ffc2-08de7e81ac25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: qRgj+y+1QNXrss/T0/owHY2XNKFn+Dk/1aeowYBYnUQSJtwvtbGaBGTDHyQgDzaBQ82aKq7wJOTiZEOlFVXUFpgU6/DB1VediML0K911AJSLwCLbDgRCpt+EhBaLQLaN/g6ckTFPpjMo3U+MX3GRM+pqz8Zxj7bb2JL2MOFZVuPx18BNp7oHMmyCIeepm86Om209VhbFmByeLp3/faEHkoyUMMJGn7aZmuRi1ZXJxqHLd6cCk0sAZLTV0J3jvFIrU7x4tkdTC5Ri8sIEXewdbFtzV2uxwafmYKfDNZLYtJze9PFZKsEUPX+PKuEIhuJVq62B1xlgeGvSQObNAsHeUZ6cJ8k1hhUH6JGfZvku4HcX8L07J5/Ddi04KxcZfonQqH4Vr1uVJ9HSW4VSxjZ9+B6fU4fYxIKYea3tAyu1q/TcK7eKnf6M0jlfWJD/TGgZ9h5Zy1U0YBYjsqrwU8lDOZUpEuDFwnx2/uBLZDE+rSWFezgaYD/1mRp5eF1cFJdNgIm1HNAavyvjo4SoevYmZQ/569hTxFraNZU51ba3YnD/wy8rOvNjsylUWAAM22h8aM7bOBdR8Frj7zK1EtVQo/WaLHpa9g+N/aYj/8BBxcKEL7ztwECJUtBHqcwMFek1L9VpGIAJ0eIVd9aQG3FMp58iOhpyOKhSwxZASYq/qyeCLOMOFY/rW7b6NIA2IEBle+XhHZtp5SDYZqEP55c0FcCKXD6MlHAQA6w87TlLSi2p5NUfyJl9ta1LHnwd7gP6AHjLI5qXqIHzxov59MWAEHFBm+WHXsK8GHGPAxLAe6U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7SPRMB0018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0lBL1ZiTWJnZ3I4MldhVWhlaWhwYWhlYkFVMFBobExHWVBZNXJjRVdxcnE2?=
 =?utf-8?B?dDROdjVOTmtUc2h6di9xSXBDTjNwSHgvSE9BeS8rMFloL0NqcUVERnRJNHd4?=
 =?utf-8?B?elFLM0p5ak10UW5NTU10TlQxVzZNYVl5ejBpYWVhQzdWYUQ2MUthdDU4cktp?=
 =?utf-8?B?UHVUYm0vdkpQcFlJRndxVE5PNU43YzB1V08wTzhUbEdHeVhHcjJHSk5wTENK?=
 =?utf-8?B?SjNWZU1HcTUwUmdrU0doOGprakowM2o0eStZbkQ3a3ZMNmtTRHpVQ3VpczNu?=
 =?utf-8?B?ME1DQ2FFRlBkcUF5c3FUYm0xa0dSRGhzZU1hZ1FBSllJdlR1MGFsZi83TFlC?=
 =?utf-8?B?QTZ3dGk1ZTNlQ0RUcFJ6QnRZdWpkRlArTFpWbWJSdzB3SFlNZTF6amN0VXZV?=
 =?utf-8?B?b2tOUkRTWE9iVTF3SitkMFVCR0hKWFQ4RitTZ0JrN0tVdGRTdzFCd3hBM1Y5?=
 =?utf-8?B?RVQxR29lV1pOdW1vYlhiL0ViNXFwYWNnYnQ5NVhOSmhuaW9MYnVSdXVLWVJs?=
 =?utf-8?B?c0Y5Q0ZHTFJTUkQ0MmtvQWMrVHhCSVZYUVZnVWMrbGdOVTFiY2FpR2diUnY3?=
 =?utf-8?B?SVdMaWh6SGx6Ymh6L1pIZTZVZnJKTVFpb1Z5N2wvMHdhdzJsanVpVmd4V05r?=
 =?utf-8?B?c3NXWTlaZnhsbGU3ZDk2MUxWOWozQS9KS0pOTy9JMTAvdHQxa0R6M2R2UHBP?=
 =?utf-8?B?YXJ1aC9ZSkVwTzZqNFBMRk9LMVUxQXNyZ2hhY3Z3WWhhUUtWWWFxdWEzQTU1?=
 =?utf-8?B?eWZ4OFJGc1hwS04vYU1zejBrM3ZHQUlidlRvSURTU3hCZUxyMG5Rc1RZS2wy?=
 =?utf-8?B?YlZXeGRpS3hyYzlJUTNoQUJyQjh4eEZCKzFkNVQ2MEVHMnIzdTEwL21jK0Qv?=
 =?utf-8?B?dmFnVjJrQ2hUY1NmQ1E2SlJEeUU0cE0wVXJqd2FrMGJrbldBeDVFb3BnQ1ZY?=
 =?utf-8?B?VU9IWEVRVTNQL2EzbktvYUIybUNhUGRmblVEVXpDSUtNQWw1My9mZ3NvZDRG?=
 =?utf-8?B?bG1hK3J2Um1vTDBmaHdjTTVpNDJiTE44SjNLWlZndHVhYWt4bGVESTZ0S3Yy?=
 =?utf-8?B?ZC9wcmR5dkhsUFB3cVJSTnRxS2xJZVE5VzlpWWNYUW1SdEtlbVJ5UStUY2F4?=
 =?utf-8?B?TVc4N1dQWUthWWYvMk9GU3ExaEFwUWU5c1BQYXNFNktsRndYKzZvcDV5NGtZ?=
 =?utf-8?B?a1dKaVpqLzk0eFBaT2V2YkIyUWN3YmE5U21sVEJTRkNiNmpqdUdSMVc2QUcx?=
 =?utf-8?B?SFpBNmQvelBWV1NQNEl1V1VEY0N0Y2V1VnN0U2RKYmxqMkdyS1RsNGMzVDA1?=
 =?utf-8?B?MHRYSm84MnB6clVjTWZlK1ZWUDRyRElFM1c5RnhNbWF6VXA2RnRnOFAzRXFY?=
 =?utf-8?B?UDEzUzZLdzRTUEtnQ25vWjZpM1N1N1BEcW8xMTJzNXJmT25QUURIcEprdGNH?=
 =?utf-8?B?Wm4xVXB5b3lsRDVnQmNzSXRaTWdnUnQvVzY5Q0x1TkxaY21UOCtIajB6VGRL?=
 =?utf-8?B?U0RyUEtuVW5rYWg3R2RzUk1YOGFpMDU5NFhIR0dLTnFEcUVvYUwxOUVHWnVq?=
 =?utf-8?B?bzRPYUFTdUVoSWl1dVBaQzg3WS9uYWM1UHFxc1hpb1VyNU9QZ0dpbGpLc0pF?=
 =?utf-8?B?MFI1YUdGaVQ0OU1XR1Z3RlZBNVpqb1VYSmUzQlhrTEtVbVdLSE82dG9GNTJp?=
 =?utf-8?B?M3ZvS3BMUm5PWGZhZEN5MDVpUHJkU3VVUFUzWUoreWNtYkdTYkJyU1dhMkJp?=
 =?utf-8?B?d0NIWithR2NncWFkMDdxZDg4OGtZaGV6UzhhNUkrU0VhK3JldWxPcFpWdTFB?=
 =?utf-8?B?UVNDZ0xvZkNMZFhGUU1IcDBDcnZmbWRtTVJEUGdXQTZvZC84anp0dTh2RThy?=
 =?utf-8?B?elh5enVsNTA4OS9QS2wvQU5vNG1qNUVYWXR3RHVsWlFqcHpqZkdzR3JVeXRC?=
 =?utf-8?B?MFY1R3A5TVBUNDNqOU9nN3Mya0dhYzhFa1hkTzJYQ25OVysvamdVQTg4OG9F?=
 =?utf-8?B?QkpxNzFCeDRHdUtnTU4xSU8zdXFMMm1FcUtLZDBEQ09LYm1aRjFCcjB0ZEtx?=
 =?utf-8?B?SlRqSlJGWGJRb015a2J0U3A2TDc4MTZHWE83K1JoWEFoSERQNm1qRUR1bTVz?=
 =?utf-8?B?bzdJeGd0NFNxckxYY0VvWEJLMnc1ZGVqd0VrcHgrUXlIQ0E5L2xHR3hnTk9r?=
 =?utf-8?B?L3pWQndob1o3SVQzN0NHSXQ1T2xOVndpaFo4RjdJd2JzOXdDaVB6b2F2YWll?=
 =?utf-8?B?MVdRMHV6THFxaytBOWFCd1ovOVh2c2xna21QUVB1eTM2YmxmV1lJVWl5eUVo?=
 =?utf-8?Q?PA6ReYTj+q0N9Rw6f8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccfc64d-0bd7-438e-ffc2-08de7e81ac25
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 08:47:33.6675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUSSLhUVyf+HwZW90YEM+wO+tv5FMVFZ6JkI6JfoaikhOqxceEu8bnFtJ+T7JV9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTAsIDIwMjYgNDoyMiBQTQ0KPiBUbzogTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVtb3ZlIHRoZSBXQUlUX0ZP
Ul9TVUJNSVQgZmxhZyB1bmRlcg0KPiBsb2NrIGNvbnRleHQNCj4NCj4gT24gMy8xMC8yNiAwODow
MiwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gSW4gdGhlIHVzZXJxIGZlbmNlIGdhdGhlciBhbmQg
ZW1pdCBJT0NUTCBwYXRoIHdlIGFjcXVpcmUgQk8gbG9ja3MgKHZpYQ0KPiA+IGRybV9leGVjL2Rt
YV9yZXN2X2xvY2spYmVmb3JlIGNhbGxpbmcgZHJtX3N5bmNvYmpfZmluZF9mZW5jZSgpLg0KPiA+
IFRoaXMgY2F1c2VzIGRybV9zeW5jb2JqX2ZpbmRfZmVuY2UoKSB0byBjb21wbGFpbiBiZWNhdXNl
IGl0IGlzIGVudGVyZWQNCj4gPiB3aXRoIGxvY2tzIGhlbGQgd2hpbGUgdGhlIFdBSVRfRk9SX1NV
Qk1JVCBmbGFnIGlzIHNldCBpbiB0aGUgY2FsbGluZyBjb250ZXh0Lg0KPiA+DQo+ID4gSG93ZXZl
ciwgdGhlIHVzZXJxIHVzZXJzcGFjZSBwYXRoIGRvZXMgbm90IHJlbHkgb24NCj4gPiBEUk1fSU9D
VExfU1lOQ09CSl9XQUlUIHRvIHdhaXQgb24gZmVuY2VzIHRoYXQgYXJlIGRlcGVuZGVuY2llcyBv
ZiB1c2VycQ0KPiBzdWJtaXNzaW9ucy4NCj4NCj4gVGhhdCdzIG5vdCBjb3JyZWN0Lg0KPiA+IEFs
bCB3YWl0aW5nIGlzDQo+ID4gaGFuZGxlZCBzZXBhcmF0ZWx5LCBzbyB0aGUgV0FJVF9GT1JfU1VC
TUlUIGZsYWcgaXMgZWZmZWN0aXZlbHkgdW51c2VkDQo+ID4gZm9yIHRoaXMgSU9DVEwuDQo+ID4N
Cj4gPiBUaGVyZWZvcmUsIHdlIHNpbXBseSBjbGVhciB0aGUgV0FJVF9GT1JfU1VCTUlUIGZsYWcg
Zm9yIHRoaXMgcGF0aC4NCj4gPiBUaGlzIGF2b2lkcyB0aGUgbG9ja2RlcCAvIGRybV9zeW5jb2Jq
X2ZpbmRfZmVuY2UoKSB3YXJuaW5nIGFib3V0IGJlaW5nDQo+ID4gY2FsbGVkIHVuZGVyIGEgbG9j
a2VkIGNvbnRleHQsIGFuZCBoYXMgbm8gZnVuY3Rpb25hbCBpbXBhY3Qgb24gdXNlcnENCj4gPiBi
ZWhhdmlvciBzaW5jZSBEUk1fSU9DVExfU1lOQ09CSl9XQUlUIGlzIG5vdCBwYXJ0IG9mIHRoZSB1
c2VycQ0KPiBzeW5jaHJvbml6YXRpb24gbW9kZWwuDQo+DQo+IFRoYXQgZG9lc24ndCBldmVudCBy
ZW1vdGVseSB3b3JrLg0KPg0KPiBTZWUgdGhlIHBhdGNoZXMgSSd2ZSBzZW5kIG91dCBhIG1vbnRo
IGFnbyBvciBzbyBmb3IgdGhlIGNvcnJlY3QgZml4Lg0KDQpPSywgYWZ0ZXIgY2hlY2tpbmcgdGhl
IE1lc2EgY29kZSwgRFJNX0lPQ1RMX1NZTkNPQkpfV0FJVCBpcyBzdGlsbCBpbnZva2VkIGJlZm9y
ZSBjcmVhdGluZyB0aGUgdXNlcnEuDQpJIGhhZCBhbHJlYWR5IGNvbnNpZGVyZWQgcmVzb2x2aW5n
IHRoZSBzeW5jb2JqLWRlcGVuZGVudCBmZW5jZXMgYmVmb3JlIHRha2luZyB0aGUgY29udGV4dCBs
b2NrOyBub3cgZ2l2ZW4gdGhhdA0KdGhpcyBmbGFnIGlzIHN0aWxsIHVzZWQgZm9yIHN5bmNvYmog
d2FpdCBmZW5jZXMsIEnigJlsbCBnbyB3aXRoIHRoYXQgYXBwcm9hY2ggaW5zdGVhZCBhbmQgZHJv
cCB0aGlzIHBhdGNoLg0KDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYyB8
IDggKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiBpbmRleCA3NmYzMmZkNzY4ZmIuLjdhMzA5YjAxMzBk
OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNl
cnFfZmVuY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
c2VycV9mZW5jZS5jDQo+ID4gQEAgLTcwOCw3ICs3MDgsNyBAQCBpbnQgYW1kZ3B1X3VzZXJxX3dh
aXRfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZA0KPiAqZGF0YSwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBudW1fcG9pbnRzOyBpKyspIHsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IGRybV9zeW5jb2JqX2ZpbmRfZmVuY2UoZmls
cCwgdGltZWxpbmVfaGFuZGxlc1tpXSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdGltZWxpbmVfcG9pbnRzW2ldLA0KPiA+IC0NCj4g
RFJNX1NZTkNPQkpfV0FJVF9GTEFHU19XQUlUX0ZPUl9TVUJNSVQsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZmZW5jZSk7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyKQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXhlY19maW5pOw0KPiA+IEBAIC03MjYsNyAr
NzI2LDcgQEAgaW50IGFtZGdwdV91c2VycV93YWl0X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlDQo+
ID4gKmRldiwgdm9pZCAqZGF0YSwNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgciA9IGRy
bV9zeW5jb2JqX2ZpbmRfZmVuY2UoZmlscCwgc3luY29ial9oYW5kbGVzW2ldLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwNCj4gPiAtDQo+IERS
TV9TWU5DT0JKX1dBSVRfRkxBR1NfV0FJVF9GT1JfU1VCTUlULA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZmZW5jZSk7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICBpZiAocikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBleGVj
X2Zpbmk7DQo+ID4gQEAgLTgxOCw3ICs4MTgsNyBAQCBpbnQgYW1kZ3B1X3VzZXJxX3dhaXRfaW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZA0KPiAqZGF0YSwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBudW1fcG9pbnRzOyBpKyspIHsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgciA9IGRybV9zeW5jb2JqX2ZpbmRfZmVuY2UoZmlscCwgdGlt
ZWxpbmVfaGFuZGxlc1tpXSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGltZWxpbmVfcG9pbnRzW2ldLA0KPiA+IC0NCj4gRFJNX1NZ
TkNPQkpfV0FJVF9GTEFHU19XQUlUX0ZPUl9TVUJNSVQsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZmZW5jZSk7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9mZW5jZXM7DQo+ID4gQEAgLTg0NCw3ICs4NDQs
NyBAQCBpbnQgYW1kZ3B1X3VzZXJxX3dhaXRfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UNCj4gPiAq
ZGV2LCB2b2lkICpkYXRhLA0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICByID0gZHJtX3N5
bmNvYmpfZmluZF9mZW5jZShmaWxwLCBzeW5jb2JqX2hhbmRsZXNbaV0sDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLA0KPiA+IC0NCj4gRFJNX1NZ
TkNPQkpfV0FJVF9GTEFHU19XQUlUX0ZPUl9TVUJNSVQsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJmZlbmNlKTsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgIGlmIChyKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGZyZWVfZmVu
Y2VzOw0KDQo=
