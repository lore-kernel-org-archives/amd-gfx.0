Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1488C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 12:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39DF110EB8D;
	Thu, 17 Mar 2022 12:50:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F06110EB8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 12:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knsblpwMgGkaDf5forQBYFcTIJ1pP6kuxb2AdVbjIpCCS5QRsWXc+0u1VwtRcT9l0Z9Fuhj7xKQhiOh8dhSaqujGLWkatIdmNc1UsgBMM5vRYAoU4vAkBD2O/I8uylKtFjo0Gcs+hjBfCUIgjK2XtgGPcY4Fa0C4j9ljOnmhlUSMlxHs36fSOIy818W/yY1LfqWvCCVtKau9FZn5M4Lirw85g5omPiTWBtxiIxDc0sTtYVL5JnC24dPKN3mPGyNsmQBytkwxpXKfWe+k/McBT7zlpXkThAG/gRny70prI2LvKlmcAyU07RUZPk6wiItCzzmZNtl2SdrA7soKZ9MT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaSbKPbiMYzs1xyaP51VWZfpXRBq+jtNfqGNxk+aDAY=;
 b=mK2vC7Utrs8sF0c21Cc924+e3bHfPunQaihKlQaeTyLgqg+tRw+2tyyXdPWag2VewLW66L8F4aTl8gKXoZ/dQ4Js0w9u0r3j1nKa1coOP/s5oXCCLuVpiztwnQGVuEP2XWvHkhKWcZYcBG3SHE8Jp7NJPoTt7HlO9KVWYY/VDvqxEcjA8Sw9MfSRQpBksE1xvBuTqDBz5Qr6QcP86skoY84yLjx43vXtDU0r3NXIhS+NcAlgd8PUsq0B4oy7iKl+zrnXTPm+LCrwwxUufVy2LA0/QSKuGtipPewAx9jIwT/YdVe6Wtzc/Q+u1iNvL7ibs/ctuamwzFdQRVzLrmobDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaSbKPbiMYzs1xyaP51VWZfpXRBq+jtNfqGNxk+aDAY=;
 b=IrPlLeK78Urr3DiAXNiyz+aEHFhOXIZTIZ8Sks4/f4XMj1m51yjffvSk+jPoG6usGWOCHAgc31pUx/YjF8U+NRo+0iE26HYzmgJ7TrdCtj+05MlObxs/VEwFk0oJmu2z/kKFs/8JM52Als0/IQAvy+hf3MqdwkrXfBL2+42D7D4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 12:50:01 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4%7]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 12:50:01 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move PDB bo release into a generic gmc
 function
Thread-Topic: [PATCH] drm/amdgpu: move PDB bo release into a generic gmc
 function
Thread-Index: AQHYOfEtBB6ZkwM61UGeE6kvIrPU66zDfTWAgAAIINA=
Date: Thu, 17 Mar 2022 12:50:00 +0000
Message-ID: <DM5PR12MB24699CF6EC99DCE0BA4A5EB0F1129@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220317112118.7411-1-guchun.chen@amd.com>
 <4b9f67aa-8cff-5e7d-7d01-a382dbfb5ae6@gmail.com>
In-Reply-To: <4b9f67aa-8cff-5e7d-7d01-a382dbfb5ae6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8612fe9-2c38-4dc1-bbb9-08da0814a671
x-ms-traffictypediagnostic: PH7PR12MB5951:EE_
x-microsoft-antispam-prvs: <PH7PR12MB5951F78FE516DEFFC1BA7B3EF1129@PH7PR12MB5951.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xBv6jt57y1yIDSN6GtRni/ejrBb2mAZA8gV+lMYBK0DwZ+r4INbOQjrdTeQDr7eeRMA2MwsETpwUrr3R+wtDk1OFPAAHp5h6QzOEcs7crXg+VavVLybII9VTeKTp0XhKzFPcGyDgjLK5VsoiDZ+jAgEkcF2W+NkkEhnQ9/1/c+jkY9UCMoK1zH7HVJBz/3ySLbo1OnNcqeyKYv5ZBjpPAC/7Kz2zMNlKsVMBJIuGBFssG9kyLmrPjucE4HYL2yvwZ9U42Ysq39OFfaN0BSdZTfI1rYHzaUAaOFAO7BZKcSfHycgx0CE4KnAe6l1INH9u766GU9U0r2+tpUhGfgJUmVA/IT+/Zu6mU3wiiV/zCZGIHXPBxWNr45kgAJdcYLzec6fz0ghnZyrNfDQx6mr+0seXSC01gH3w4z545fLjFxWL8dIanF2fRVL3eTn+Ysw3dMStcJ5KVOxwXA+8Cod0GZ2KwRaLC+oISN3HHoqlBSwha1dsy7KRr9hRFiTLvzaPTIdz3wl5N3ivqplRqe7mTt7HAlAPadVrpForM6HN2qATGmKhBR/IyPVEIJkR0plOaiA+ApboCrReycQ5Uex9LjmwIUS22fmdUnYUd9BjKO79c/f/OFU7knNFK6yom/wwL11VnoY2D1jMQImmT9cL+xgEh5L38njp3R394rRNhhaSRoa/VHAubQYP74F2cNYJ/m6L2HQt431PuEr12d3qtjkBHxuopYSnt4QLxJkrC72NwgihlHSQeWLLxEHRqhZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(6636002)(66946007)(26005)(110136005)(38070700005)(71200400001)(8676002)(53546011)(55016003)(64756008)(66446008)(66476007)(9686003)(66556008)(7696005)(86362001)(76116006)(6506007)(508600001)(5660300002)(83380400001)(66574015)(186003)(8936002)(2906002)(33656002)(122000001)(921005)(38100700002)(52536014)(41533002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm4wS1pNU2o4a2dFSnNaVVl1c0hMaXJKbFM1QTNLZUdKVnM3RnJ3OUY3RWo3?=
 =?utf-8?B?TGZLSXNrM25qeGtTam9lZmJKYjBTRmR0c0JyS1l0WHQyUUl6T0ZKSjVTcGMz?=
 =?utf-8?B?SkptNlBMRTQraTZjVjBBeVVYRjRCRDVzWmE0bVg1NVFUSTdUbVRqNjNiRUtG?=
 =?utf-8?B?RElzUk12QWtRSG5pQzdYTTB0amhBMC9JY1dXMVZaZXRTRENPZTRBNjZyVklO?=
 =?utf-8?B?Mjk4UUVMYmwwRzRtTEtIeFo0WStxZ1g1ZHZsQUZKL0ZBU3FhRXFiRDZxTytB?=
 =?utf-8?B?c2pPOWQ2K1NuNGRlMkdQdEZJd0ZBTDlRV210RGFCcmg2d0xLZHRobDN3NS8x?=
 =?utf-8?B?MWZXa1NzVUFRYlZWZm9zV3RkVzRLSXp3R2VsRndzTFZWVDUzbm5HYU5wRlJN?=
 =?utf-8?B?OWhDRXdRblZXQVl2L3E0WDhGcHpmUThaOTEwNTZiMzhDaitNV0g0QWdiMUN2?=
 =?utf-8?B?VUJWWEhQQm1TMmpaaitiZEhCd3NGRFZ3NzB1VmFxVGZFWW1tc3VaUXRtQVdQ?=
 =?utf-8?B?U3M0MGhLTWlVeGFKS1RuZ2NUUWNMNTVTTnNUUlFmK3AwcGlEY1JMc2ZuVGtG?=
 =?utf-8?B?dkwvVlNDL1pEb2RPamNmZm9pUHMra1YwekVpZDg4Q3VUUzFtcnhpaFIzdk52?=
 =?utf-8?B?clAzUTRYN0tsSUxZc0ZveDdYbVUwSDZYcDk5NFh1cTNObHprV0tVdTR6WnNp?=
 =?utf-8?B?c2hEL3RyWUJEdjBtWmtZYzBnYzl0OTdGemNFUGpwNHg3ODlVK0lyUUc5Ulha?=
 =?utf-8?B?NmpkWmQxeklTOVNvTjM2TGs2aktHbVdwVXBGWTc1THhWYmFHeW9JdXJYYTZE?=
 =?utf-8?B?aWhFU3J3cWdsUEttSnNOQXFtQkpTc3JUOWt1UkxvT1hoMC81R0JSa3p4UVZS?=
 =?utf-8?B?dU1Xb2p5VGdmU3c5MVhRbG4zTDNYVW5naVhaQ3MvQWNSQUdUTWE1MThpa25K?=
 =?utf-8?B?YytSRzEwSUVyaWJXQmgyanJTbXgvNnEzUnpvRDdZcEI3N09WcmM4RTRpaC9a?=
 =?utf-8?B?MFdVMGdwKzRWQmVtR3dXMk9LRkJNZlBYaVM2MzFhL0FReWszS3JPS3hBQXZO?=
 =?utf-8?B?d2dKT1hmbjFXSnRrdHBZNXprNTNXekVjOTR5WllYbGc2SytnblhLdW40OUtB?=
 =?utf-8?B?WjlldTFGWE9CcHQvNzY1azQ5dE1vZzVnUFBiVGhPSGZsNUVBUWNmR1pCTFBh?=
 =?utf-8?B?TmhVYVhucFNBQmJJdVlHK3lIYjlQaE1rTWtmU0VuZEhHRS9ESGpnVGZZTUlD?=
 =?utf-8?B?MHVHM0NBMC9EQUl5OGJhbnRzczZnSXdzNnI4Q3BqRlVBaHo0dHFUMUE5a2FJ?=
 =?utf-8?B?UzVJTUg2YllSMlpzaS9JZ0Y1Tkg5SnJuOVkwaW5pZ256bDNuYi82RThwMW9p?=
 =?utf-8?B?dmNYMW1QaW85aVVkRGhVbFpJN21Lb1dHNnB2SE1DYVErL3pIQTVXV21UKzRO?=
 =?utf-8?B?ZDdVRGVWZ0tWc2x5VmVscWZRZnVPdVVVdytKOHk3elVXbEtIVFJmZ0E3ZGNt?=
 =?utf-8?B?THFLUHpFQW5nUWpFSnQ2dVRQUjZjKzhkNWpKSEVNTUEvRG5pR05JM01POTJQ?=
 =?utf-8?B?V0tVQ3pRcmJWditSaGtGOWUwQ3VIdE9NekZkRjNIWHJqT0dJc3pCek1UNnR5?=
 =?utf-8?B?Mis2Q1d1Y0lHNnJoMytUWEZGbXZ6ZklHYWpSNHBXR1MrMEVMTkE3NXRyS3lp?=
 =?utf-8?B?SlIxM3FSOVM1dnJGTko5bjBJMTR4SmFqM25Oc3ltbUpNaGQzNkJLOE43VTdy?=
 =?utf-8?B?WTlYdnZzMm95T2J2R2JDRmR2ZlF6Y1hxTEtzQnlPam1zTXZ5bVB5aERCMnlR?=
 =?utf-8?B?WGVpTG0yTjRqUjhCVVNKazJOeDdVZGVHK1hRdzAvajAzQTQ1OThlRDlqbVBM?=
 =?utf-8?B?T0tHRS9ETGpDYUlJUHhTWjdnWlFCMWgwU1hXa0ZWdTZLZ0psQ0I3UmZ1WWtq?=
 =?utf-8?Q?R+ROihPsWfqeaj21UfEbGyLY2Y5WqWar?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8612fe9-2c38-4dc1-bbb9-08da0814a671
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 12:50:00.9779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cf7QWfdYn2Wryg4yazfCLrEGko6OADJZRNJ17p2qMWa7fm2PkJSQBnK8ItApSa/FAWRBZpza1O+0ki2Sx0/XIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

SGkgQ2hyaXN0aWFuLA0KDQpNeSBpbnRlbnRpb24gaXMgdG8gdXNlIGEgcGFpcmVkIGdlbmVyaWMg
Z21jIGFsbG9jL2ZyZWUgZnVuY3Rpb24gdG8gcHJvY2VlZCBQREIgYm8uIEN1cnJlbnQgY29kZSBp
cyBnbWMgdjkgY29kZSBjYWxscyBhbWRncHVfZ21jX3BkYjBfYWxsb2MgdG8gYWxsb2NhdGUgUERC
IGJvIGJ1ZmZlciwgYW5kIHJlbGVhc2UgdGhlIGJvIGRpcmVjdGx5IGluIGdtY192OV8wX3N3X2Zp
bmkuIEkgZ3Vlc3MgUERCIGJvIGlzIG5vdCBhIGdtYyB2OSBzcGVjaWZpYyBidWZmZXIsIHNvIGl0
J3MgYmV0dGVyIHRvIHVzZSBhIHJlbGVhc2UgZnVuY3Rpb24gZnJvbSBhbWRncHVfZ2VtLmMgaW4g
ZmluaS4gVGhpcyBtYXkgYmVuZWZpdCB0aGUgY2FzZSB0aGF0IHVzZXJzIGRvIHRoZSBzYW1lIGlu
IEdNQyBuZXdlciBJUCBjb2RlLg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgTWFyY2ggMTcsIDIwMjIgODoxNCBQTQ0K
VG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFBhbiwgWGluaHVpIDxY
aW5odWkuUGFuQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBtb3ZlIFBEQiBibyBy
ZWxlYXNlIGludG8gYSBnZW5lcmljIGdtYyBmdW5jdGlvbg0KDQpBbSAxNy4wMy4yMiB1bSAxMjoy
MSBzY2hyaWViIEd1Y2h1biBDaGVuOg0KPiBUbyBwYWlyIHdpdGggYW1kZ3B1X2dtY19wZGIwX2Fs
bG9jIGFzIGEgbW9yZSBnZW5lcmljIGhhbmRsaW5nIGluIA0KPiBhbWRncHVfZ21jLmMsIG5vIGZ1
bmN0aW9uYWwgY2hhbmdlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVu
LmNoZW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5jIHwgNiArKysrKysNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ21jLmggfCAxICsNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
ICAgfCAyICstDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nbWMuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4g
aW5kZXggNzAyMWU4ZjM5MGJkLi4zNmY2YjMyMTQzOGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gQEAgLTEzNiw2ICsxMzYsMTIgQEAgdWludDY0X3Qg
YW1kZ3B1X2dtY19wZF9hZGRyKHN0cnVjdCBhbWRncHVfYm8gKmJvKQ0KPiAgIAlyZXR1cm4gcGRf
YWRkcjsNCj4gICB9DQo+ICAgDQo+ICsvKiBhbWRncHVfZ21jX3BkYjBfZnJlZSAtIGZyZWUgcGRi
MCB2cmFtICovIHZvaWQgDQo+ICthbWRncHVfZ21jX3BkYjBfZnJlZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikgew0KPiArCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+Z21jLnBkYjBf
Ym8sIE5VTEwsIA0KPiArJmFkZXYtPmdtYy5wdHJfcGRiMCk7IH0NCj4gKw0KDQpTaW5nbGUgbGlu
ZSBmdW5jdGlvbiB1c3VhbGx5IGRvZXNuJ3QgbG9vayB0aGF0IHVzZWZ1bCB0byBtZS4NCg0KV2h5
IGlzIHRoYXQgYW55IGltcHJvdmVtZW50Pw0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+ICAg
LyoqDQo+ICAgICogYW1kZ3B1X2dtY19zZXRfcHRlX3BkZSAtIHVwZGF0ZSB0aGUgcGFnZSB0YWJs
ZXMgdXNpbmcgQ1BVDQo+ICAgICoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuaA0KPiBpbmRleCAwMzJiMDMxM2YyNzcuLjZmNDI1ZTNhOWI2ZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaA0KPiBAQCAtMjk5LDYgKzI5OSw3IEBAIHN0
YXRpYyBpbmxpbmUgdWludDY0X3QgYW1kZ3B1X2dtY19zaWduX2V4dGVuZCh1aW50NjRfdCBhZGRy
KQ0KPiAgIH0NCj4gICANCj4gICBpbnQgYW1kZ3B1X2dtY19wZGIwX2FsbG9jKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KTsNCj4gK3ZvaWQgYW1kZ3B1X2dtY19wZGIwX2ZyZWUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiAgIHZvaWQgYW1kZ3B1X2dtY19nZXRfcGRlX2Zvcl9ibyhz
dHJ1Y3QgYW1kZ3B1X2JvICpibywgaW50IGxldmVsLA0KPiAgIAkJCSAgICAgICB1aW50NjRfdCAq
YWRkciwgdWludDY0X3QgKmZsYWdzKTsNCj4gICBpbnQgYW1kZ3B1X2dtY19zZXRfcHRlX3BkZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdm9pZCAqY3B1X3B0X2FkZHIsDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiBpbmRleCAwOGNlYWJkNmM4NTMuLmFkNjAwZjcy
YTUxYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+IEBAIC0x
NzIxLDcgKzE3MjEsNyBAQCBzdGF0aWMgaW50IGdtY192OV8wX3N3X2Zpbmkodm9pZCAqaGFuZGxl
KQ0KPiAgIAlhbWRncHVfZ2VtX2ZvcmNlX3JlbGVhc2UoYWRldik7DQo+ICAgCWFtZGdwdV92bV9t
YW5hZ2VyX2ZpbmkoYWRldik7DQo+ICAgCWFtZGdwdV9nYXJ0X3RhYmxlX3ZyYW1fZnJlZShhZGV2
KTsNCj4gLQlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmdtYy5wZGIwX2JvLCBOVUxMLCAm
YWRldi0+Z21jLnB0cl9wZGIwKTsNCj4gKwlhbWRncHVfZ21jX3BkYjBfZnJlZShhZGV2KTsNCj4g
ICAJYW1kZ3B1X2JvX2ZpbmkoYWRldik7DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KDQo=
