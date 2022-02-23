Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE75C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 02:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4DD10E23A;
	Wed, 23 Feb 2022 02:29:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4558410E23A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 02:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzm35o1+vl0vstcJr2Pf+xg1d9KOokHMjdxXy2VKuP2OuO8X49AB4Rz5jxRdA/qZKVgMmiCkkYGWesadMcBnnmM4zz4ViNRI8MWFKYyHXjp80PEW6HHnfHJTeWX+r2Sw9U2zsF+ewDfYCVfsINZDpu225skjrvZMk0kMCZBUFz243UTOp4azHVVRkkUDkzlAXP0Z9pc6tiBvz3S+29tFBJGqT4NJsoCBcPrOVMPJ1/RxnujujK8s0EbVVOKyx2vxFSziu7bn9e0k+JT/22RLfcjbJn8R5tYS8+rcxocuAaHpqcgUSjs5irHz2nRUwg82SBFrB4bhpEXPXlfD897KNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWn15JaS4yKHH38AvfY1HQ+lqJJZ7Jc97vxE7YOD3UM=;
 b=X6o/jHj1u8TU8j8BRNVU9LIz5+fbi0CN2FsmX3cQ5ZpEsOCgk9NDDw0Ca2pJZbdAFQpXdGUxVUORkTlO87sbS6xN66TV3UmPIcI2vHAiHuvsWrPyJ9l+rLEp+DWTIylK1DAFQ8YAo3bOplO72nSMBTb0tLCvqrg33aP/isqY7jO/NK+0oUQYlrmUy7YMvXOzNpRdkP1RYnb/uh3I67jh4pMjMBZSEFTsykfMSLK8mmgacUrp+NHR6GTI0b9Qmnt53rPUXYEv67LlE0IJVNgEmzVRgcCnH9BwIOLPYRbXyI20MXYusRXaWp7vsgqN19NMJgFIGBqEZRHahPbvD1IIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWn15JaS4yKHH38AvfY1HQ+lqJJZ7Jc97vxE7YOD3UM=;
 b=05bSBAinJKVyg8wdagoBtqkjW0wfTrjSVx7+D9kEsyWE895WYZDe+Wd3Vn5+6BDp/zCTR62q76IxJGhcvRfE+MrhGUgdi0d2ZLV0aM8rwDT5kCu9y85Tx7iAsGLhpE5/I4IYc47tp3HUkM4/ZuzSLmF68yOOIILc0etbT5hjnCA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BY5PR12MB4819.namprd12.prod.outlook.com (2603:10b6:a03:1fd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 02:29:47 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 02:29:47 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Thread-Topic: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Thread-Index: AQHYJ/32a7kG4n5k10KbmxqPExm2rayfy1uAgACez6A=
Date: Wed, 23 Feb 2022 02:29:47 +0000
Message-ID: <DM5PR12MB2469DCED1EAAEB56B57C2698F13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220222150731.16954-1-guchun.chen@amd.com>
 <CADnq5_PRn-G0FC46Wh-8HJs=EL+hLNfYz=NNC-PGKosDrPXrsQ@mail.gmail.com>
In-Reply-To: <CADnq5_PRn-G0FC46Wh-8HJs=EL+hLNfYz=NNC-PGKosDrPXrsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4c9b78f-b48a-4464-6acb-08d9f6745c49
x-ms-traffictypediagnostic: BY5PR12MB4819:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4819C9484254F7D203516228F13C9@BY5PR12MB4819.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZfcx18TYy5jm3SKVO890dmXcbGDr7YkI6l2h49S+mUjcHdL7QLWQuxR1EaMbNxdGVkoGXkGk5KArLWUuk9lv+YUQNEM01JFDifgB446b9i1nitm8sJ77R/ky+3tYS4gOBDDDUsrbh4dXeZSTB7UwUe9IBeSQlYAQ1a9xzTD+FIiBMsWSEXXQgSzSQIFFwGshr8LFN+KT8uPHCxB0+lY6hlFXkFavD21pt1nmGsP4LPSew2E/h/4gMENnU4L7VqMBKzXP4OnCOg1PdhzaPl2FM9059Jx6Xl56m64Tg/uDPzHlmq52s3zEj8ZDxiiLFBsA0YbIBq5zod7dPp5GiqziKJxchES/0p9HJktxS70V7n45UXCNdL6XHEYu2z7H36y3G9447b6rJj/C8/sw9FFkQWobGLdz5Ipqtmle413HjKUuufX5GI2kO3ijzzGWK4pTSW5VnuTEtqY2+6eryJQN5KCmjVLxSfVEokbSABOdXSMtAUV8o12YhbrgaP0xeC9m/D97fq+KL8oqDSbUizfjyEC0KhhGhboL0L/TdeCuTcaLTFHRAcbGLPyG2ycJBVJ4LUMMjoh7Qejs7QfmQWFQ8VXXcHikbjlmS/CaQabVgqU1o3KTp7WMwHdtjEf04SzBCxeni246TVmAYxyo69nVxfm8LyEABeA6AICDFzAZCU6J9lOQkilAe2bn5zdXOk/dxsw4CQDGgcdr0HwB3Nv4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(6916009)(66946007)(26005)(316002)(76116006)(9686003)(53546011)(7696005)(8676002)(4326008)(38100700002)(64756008)(66476007)(2906002)(186003)(66446008)(66556008)(83380400001)(5660300002)(8936002)(54906003)(122000001)(33656002)(508600001)(55016003)(52536014)(71200400001)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWhlR25oS0ZRUWo3VGs2elZtR0VrYkNsUjNvbkdyT0N3dDJsWmZHZHEyTEc2?=
 =?utf-8?B?b1F1YmN2QXAwaDVmTjk0UjJQdnc4K1QyTGRLVllvN1NvcDFTQlVrZU9tUlpL?=
 =?utf-8?B?NVluQUllZTZsRjdrM1BpbTZ5MFJHS2VsZjA1SXhYSzllRjF5cXFOU29TOFdT?=
 =?utf-8?B?VWJLd1A0a1hGZ0s3T204Z3JHQjZuU0hoODdFZXdIY3RkRkxqWmloNlBrbEFS?=
 =?utf-8?B?aExUWm14Y1p6Wk5XK01YcVRuVXZvWmFuYllpbkNMcjNZNyt6a2FpWEVaOXVX?=
 =?utf-8?B?Um1GQmpFUk5qSVRaRE9Sc3hvVUExMzdpQXNYL2wzWUVrQThxTmUzckwzejZ5?=
 =?utf-8?B?ZDlhNUU4Nld4SzBYMXJuN3NsRW9pY0l1TmoxTjBMYzdVYS9SMkQrTmljeldS?=
 =?utf-8?B?L0Q4SHlRNXVnQldYWDlWcW5PUGlOYkw3SEY4UTFOOFVvNjN2SHBscHFlem5Q?=
 =?utf-8?B?ZTZMbno3U0Fnb0I5eGM5eGNiU1U2Qk1UakpKR1loSkIvNFc5Y2ZTdEpoMGc1?=
 =?utf-8?B?bFNET1B3NllidHM1NVd1K3cvbllhN1MzS2E0dUZpVEE0MnNHSDR6UnE2Y1g5?=
 =?utf-8?B?MXNIcmFFTWlDbWp6SVkvTjI0SGx1aUJVd3BsOVlVNVlRZFV3a3dmczcvUWd1?=
 =?utf-8?B?NmNqczVFR0RnRTJ4cGdQTktTV3hrL2kxT0pwNndlNUFwbVM0NWJ1d3ZFb3k3?=
 =?utf-8?B?SFVibmRKOS9KZlBwWWxZTHpRd3BBYXZITkJ0U3U0Tk45NWo3T3p5TWtEbkRJ?=
 =?utf-8?B?VXBCUExZMGZFUVlVelViQm5HaDVseVlVM0FFY1ROSzhhM2RHa0Zwc3hYTVNQ?=
 =?utf-8?B?QmFMNE9tMDc2NW1aV1FoRVlYSUlMMmRJV2JEdXBFNjM1ZERkb21NVzdyL2pV?=
 =?utf-8?B?WmljdmxMUXBVVEhzMkRtUDBaTmlEV3pkSGozR3JvMk42YkpRbTZmeUVFcXg3?=
 =?utf-8?B?dEtxb3RjaldYOFF2YzlGbzBBZW1XK3NnTzB2TjVFVTVwNnZYTk5EdjNRaVJW?=
 =?utf-8?B?UDIyOXNpMEgxTVJuVGoxWDRKbjkzdG96a2pFdm84ZFVqOXdTb2gvT0NSdnli?=
 =?utf-8?B?K3pmNm9EdjVVMlBUN0hOOG5tUzF0RUtNRWlubkpRNDYrWmIxYitzc3dMQ0pO?=
 =?utf-8?B?VFVEcmJsZGxtTVg1Ujd3Y3J0aU5oUEFEUldwZkJhVjJqVzBtME4vRzBwNEVL?=
 =?utf-8?B?Sy94c2hpTEhWT01PU1BoZjkwYlJVSXFFOGdLcTk1TGhzbG1LaU1saGVETG9w?=
 =?utf-8?B?ckZ0cHZzUUZxNzJhQ0tIQXBWdzdBcG1YUGJqOTVCRDRtSWtxNkRIMUJldVZH?=
 =?utf-8?B?NUpkU1RlUHFlN214c09zNmdSU0Qra1liRG10eXZqS2xqMGJ4ejBXT3Z3MzFY?=
 =?utf-8?B?TmU5L0FqUEt0bE9WWmx6N042TTV1NW55a2c3RUlCcXhDbG1XRHUwVG9lSlRY?=
 =?utf-8?B?TG5PT2dkRGZyRDZFVmlVOUxZMElKTHZINEpZcTVmaFZCTDJET2h5REtZZ0d5?=
 =?utf-8?B?dDBMWExWKzN2YnVtSmkzcEt3SDFBQjM5RENSellIQVdXb3hLSmRCUDlqV2Q4?=
 =?utf-8?B?NlpQT1Fab0pwbWFFaXVTU3ZMYnV1dkhqRXJEMW43RXR6dHNqS1MyK2tYaUlG?=
 =?utf-8?B?RUVSdEMwNzNOVjlIemtZMk1pYmhyNlJ1UVdXcEZSdWJWaDFxYjlFL2RCcnNq?=
 =?utf-8?B?Nzh0SmM3alRxTzR0SVJGZkQ0eDM2bnZpdytSQkZVeFRPbDJzSzdzUSs2ZHZD?=
 =?utf-8?B?S0ovUUs4ZVY0c1FiVDlJVHdtZDVCdDZ6bGU1N0w1d1A1YnB5Ulg0NkRKZ3FJ?=
 =?utf-8?B?ZFZvbHNobmxwMmRkQkcvbFNkdDVqTmdOK3czdW44eFNlOCsxSmMvMXBnR0RI?=
 =?utf-8?B?MlF5VFNieDQ4aFFnd3RpOXFsRXNlK2owd0FSZDRWUDY4SHlIak5XeWNRd0tF?=
 =?utf-8?B?bEhMQWxaYTRpN0E1Y2pEeFRHeFZtb05FUklIU2pkY29CSk9aK2JncUhxc1hm?=
 =?utf-8?B?Zk50SC9CN2FObUFQeHJ4b1ljUXZQV1liM3hrOXk4eVVzWmFQRXUzbXRZRC96?=
 =?utf-8?B?YVhyZDFtZW90ajJmR2VlVnJEQ3pNalBRV2RWQWV2MEtSaGpDazdDZVBFL1BC?=
 =?utf-8?B?M3I4cDc2Z2FIUTlYRUtHUkxKNDZtSy9DdmdvTGdIWGxCNzBXRFBMemcrdmJV?=
 =?utf-8?Q?4HdCXWUtzylyN6bD59FnjM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c9b78f-b48a-4464-6acb-08d9f6745c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:29:47.3028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUHvrZ+gmqykLkbs1pphQPbLYBbVZ5e7hfPpYZVKJy8VG1834Ur1c3uqMHoiQAFoUmvoaX+eBVZFx6IHkj/QNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4819
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxleCwNCg0KVGhpcyBwYXRjaCBoYXMgY292ZXJlZCB0aGUgY2hlY2sgb2YgVkNOIGFzIHdl
bGwuIFNvIHlvdSB3YW50IG1lIHRvIG1vZGlmeSB0aGUgY29tbWVudHMgdG8gYWRkIFZDTiBhcyB3
ZWxsPw0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gDQpTZW50OiBXZWRuZXNk
YXksIEZlYnJ1YXJ5IDIzLCAyMDIyIDE6MDAgQU0NClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5D
aGVuQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpo
YW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNv
bT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGxpbWl0IGhhcnZlc3QgYml0IHJl
YWQgb24gc2V2ZXJhbCBBU0lDcw0KDQpPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCAxMDowNyBBTSBH
dWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4gd3JvdGU6DQo+DQo+IER1ZSB0byBmYXVs
dHkgVkJJT1Mgb3V0IHRoZXJlLCBoYXJ2ZXN0IGJpdCBzZXR0aW5nIGlzIG5vdCBjb25zaXN0ZW50
bHkgDQo+IGNvcnJlY3QgZXNwZWNpYWxseSBmb3IgZGlzcGxheSBJUC4gU28gZmFyLCBpdCdzIGhh
cmQgdG8gd29yayBvdXQgYSANCj4gc29sdXRpb24gb24gYWxsIHRoZSBsZWdhY3kgTmF2aTF4IEFT
SUNzIGluIGEgc2hvcnQgdGltZSwgc28gdG8gYXZvaWQgDQo+IHJlZ3Jlc3Npb24sIGxpbWl0IGhh
cnZlc3QgYml0IHJlYWQgb24gc2V2ZXJhbCBBU0lDcy4gV2lsbCByZXZpc2l0IA0KPiBsYXRlciBv
bmNlIFZCSU9TIGhhcyBjb3JyZWN0ZWQgaXQgaW4gbG9uZyB0ZXJtLg0KPg0KDQpMb29rcyBsaWtl
IGl0IG1heSBiZSBpbmNvcnJlY3QgZm9yIFZDTiBhcyB3ZWxsLiAgRG91YmxlIGNoZWNrIHRoYXQu
DQoNCkFsZXgNCg0KDQo+IEZpeGVzOiBiM2Y0ZWE4ODdkNWYoImRybS9hbWRncHU6IHJlYWQgaGFy
dmVzdCBiaXQgcGVyIElQIGRhdGEgb24gDQo+IGxlZ2FjeSBHUFVzIikNCj4gU2lnbmVkLW9mZi1i
eTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIHwgMTggKysrKysrKysrKysrKy0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNj
b3ZlcnkuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5
LmMNCj4gaW5kZXggMTEyNTUyOTBmMTE3Li4yZTBmZjFhY2U2ZmMgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gQEAgLTExMjksMTIg
KzExMjksMjAgQEAgdm9pZCBhbWRncHVfZGlzY292ZXJ5X2hhcnZlc3RfaXAoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgICAgICogc28gcmVhZCBoYXJ2ZXN0IGJpdCBwZXIgSVAg
ZGF0YSBzdHJ1Y3R1cmUgdG8gc2V0DQo+ICAgICAgICAgICogaGFydmVzdCBjb25maWd1cmF0aW9u
Lg0KPiAgICAgICAgICAqLw0KPiAtICAgICAgIGlmIChhZGV2LT5pcF92ZXJzaW9uc1tHQ19IV0lQ
XVswXSA8IElQX1ZFUlNJT04oMTAsIDIsIDApKQ0KPiAtICAgICAgICAgICAgICAgYW1kZ3B1X2Rp
c2NvdmVyeV9yZWFkX2hhcnZlc3RfYml0X3Blcl9pcChhZGV2LA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2Y25faGFydmVzdF9jb3Vu
dCk7DQo+IC0gICAgICAgZWxzZQ0KPiArICAgICAgIGlmIChhZGV2LT5pcF92ZXJzaW9uc1tHQ19I
V0lQXVswXSA8IElQX1ZFUlNJT04oMTAsIDIsIDApKSB7DQo+ICsgICAgICAgICAgICAgICBpZiAo
KGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDczMUUgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgKGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4QzYgfHwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4QzcpKSB8fA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NzM0MCAmJg0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgYWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHhDOSkgfHwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgKGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDczNjAgJiYNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4QzcpKQ0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZGlzY292ZXJ5X3JlYWRfaGFydmVzdF9iaXRf
cGVyX2lwKGFkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnZjbl9oYXJ2
ZXN0X2NvdW50KTsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgYW1kZ3B1
X2Rpc29jdmVyeV9yZWFkX2Zyb21faGFydmVzdF90YWJsZShhZGV2LA0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2Y25faGFydmVzdF9j
b3VudCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICZ2Y25faGFydmVzdF9jb3VudCk7DQo+
ICsgICAgICAgfQ0KPg0KPiAgICAgICAgIGFtZGdwdV9kaXNjb3ZlcnlfaGFydmVzdF9jb25maWdf
cXVpcmsoYWRldik7DQo+DQo+IC0tDQo+IDIuMTcuMQ0KPg0K
