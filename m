Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0C7C1747C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 14:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A32A21D6C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 14:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A32A21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF33C6EA97;
	Tue,  5 Nov 2019 14:35:53 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700079.outbound.protection.outlook.com [40.107.70.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B9E6EA97
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 14:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFsiG5LWL5sJCyYHznKUqJel2W+oMFM20RX7vQA6+cz7Cr6yLqPK7pWV1XWZv1pSwdkklC80Y9/EyMGleJ3nGns3KycQCaWyltBzMuivpJqxlvetPNm+rrN0U0coRw0HORtYSexsF+SCnMSSijxkOkpAXJtMTm5aVlj5Q47r08xsd8uWdx9sRuxY6h68kTna72xvdxQYmkERU7nWD9f4nGMAwo9AvYTG+j1ciDPw58YEo1wc2Vzrw9GOtzQL+3VT6EHrTeNh+yy87l5gU9KQdRM7xLhnDOTxyoPsQMhLwXfMaZsP8biSyNM9ifnPxWmR3jGZPmB9aiYBEamPw/sxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NE/nHyQCSw425rBntprahWF4BpCgakP18EpQU0aM+Y=;
 b=PZKwQlk+2faJmPmk8w0yuqwYuWCuVFmd52/LXeQiWjuZGAmTtfAqZBTO+QI3Ilcu8iK1JdCB+K99X83Skuplq7iORXZL9k8UCZSa16qjXDuBD/UmisilnWZ749v+zJMoYNOf9rh1+VN9OuQ7xk1iFw5WWE2jS0M7rWBRYdH360/8AdtPpjm34tMQxUDVEF1lbhxKbz4EWNdFEhsGWHSV1XS6REKuPFgrVBsf9ZPOjiwy3ixiNTaR4b7H5prKMFD4rN5wiLuDSYHFYd6++n8R1nsR7bUrm4wuylYThNA4cS77drbNpdH4SAy9Cur43u94Ogc+Njcc6Q01QyQ9A+0I7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB2533.namprd12.prod.outlook.com (10.172.120.151) by
 CY4PR1201MB2519.namprd12.prod.outlook.com (10.172.119.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 5 Nov 2019 14:35:49 +0000
Received: from CY4PR1201MB2533.namprd12.prod.outlook.com
 ([fe80::7d54:3475:ff9b:694b]) by CY4PR1201MB2533.namprd12.prod.outlook.com
 ([fe80::7d54:3475:ff9b:694b%10]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 14:35:49 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix sysfs interface pcie_replay_count error
 on navi asic
Thread-Topic: [PATCH] drm/amdgpu: fix sysfs interface pcie_replay_count error
 on navi asic
Thread-Index: AQHVk8h6SPirv1iUwEaHj/HinRjGJ6d8pMaA
Date: Tue, 5 Nov 2019 14:35:48 +0000
Message-ID:
 <CY4PR1201MB253391EB8C15F4FC3DDC1D53857E0@CY4PR1201MB2533.namprd12.prod.outlook.com>
References: <20191105110200.29855-1-kevin1.wang@amd.com>
In-Reply-To: <20191105110200.29855-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3482636d-a163-4ac4-3fdf-08d761fd73b4
x-ms-traffictypediagnostic: CY4PR1201MB2519:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB251920785035C1B01676AEB1857E0@CY4PR1201MB2519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(189003)(199004)(13464003)(76116006)(486006)(66066001)(186003)(53546011)(6506007)(6246003)(71190400001)(229853002)(3846002)(14454004)(66946007)(66556008)(64756008)(256004)(446003)(11346002)(8936002)(25786009)(99286004)(6306002)(8676002)(33656002)(4326008)(81166006)(7736002)(305945005)(2906002)(5660300002)(86362001)(6116002)(6436002)(7696005)(102836004)(476003)(55016002)(74316002)(76176011)(9686003)(316002)(66446008)(81156014)(66476007)(110136005)(54906003)(52536014)(26005)(2501003)(478600001)(966005)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2519;
 H:CY4PR1201MB2533.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +H4VHkD2TRHMcPMLQQ4Q8MSoFJDuf1qYPuxKHi0HNvW94uQpyodUNUMf1d/1d0nX3TG+aq0OpR+JEnwbuAyZwl9UvZK71RT62gpXfD57OjAkfc8yFZ/YrRn2yv/5C4NriSvWo83W9cv4a7gD4Rut086Iu1VSgD7cRFKdu3tBH5KnrjO2o1/S1mb3Azt/WLcWYQleAZC1Ya9Ps50gt+WMDiuENTLDE5m76g0hLCVnRgoi8lJy58BfVLoU9XsaXV5Xp4y13We5YL4p5jhfGwHuoIJZvuuPDBjA9DJIYqJ8krClYVgXxEbrvo5MyFik76hjRJ1K3Je+452H9FK2dgMya9iy4PJH6kTg/zGv9lsXHT8wLtONdG7IvP3fruGrm18qQSk2iaWj00o8ZAD+j7A18L9AGIZOjw7y1OGLg3Yvqh2Xcxd0Ruw2ThWT/qIKrfg9xUnA5nk4mCCOe43gactjiC0M1WYHKqIebWpwsAYy24I=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3482636d-a163-4ac4-3fdf-08d761fd73b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 14:35:49.0068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFsgvpbNGr5ngqy+8qC/2k7Q/5UcYDnkJnVreDs5s58FF1zXSQgfvxenu/hcD+AjggCd96b4F1hJwWT9o0Sa7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NE/nHyQCSw425rBntprahWF4BpCgakP18EpQU0aM+Y=;
 b=FDWyw5Q0OqLinMZE7Zi9+tLBYUtuRmPD3/Dqmo9mRgXz5CbEEQGVkLYbfE/t5y4ndWwJ7WeE02cvJWQaRismzZG4VCDdIi03I7yUa95eKKXPHl7EnzBPPPhY7PtLACMFiudP6BjnJU28sb56/vy5Bcf0pnebvuQjRBVV201heyA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105143548.L0nh-f6uZCbHQbcSMih_34IvzVoSst-97RjPfXqBdvk@z>

UmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+DQoNCkknbGwg
dHJ5IHRvIGdldCBvbiB0aGUgYWN0dWFsIGltcGxlbWVudGF0aW9uIHNvb24uDQoNCiBLZW50DQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5j
ZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgV2FuZywgS2V2aW4oWWFuZykN
ClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMTkgNjowMiBBTQ0KVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgWXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+OyBMaSwg
Q2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsgV2FuZywgS2V2aW4oWWFuZykgPEtldmluMS5X
YW5nQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3Vi
amVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggc3lzZnMgaW50ZXJmYWNlIHBjaWVfcmVwbGF5
X2NvdW50IGVycm9yIG9uIG5hdmkgYXNpYw0KDQp0aGUgYXNpYyBjYWxsYmFjayBmdW5jdGlvbiBv
ZiBnZXRfcGNpZV9yZXBsYXlfY291bnQgaXMgbm90IGltcGxlbWVudCBvbiBuYXZpIGFzaWMsIGl0
IHdpbGwgY2F1c2UgbnVsbCBwaW50ZXIgZXJyb3Igd2hlbiByZWFkIHRoaXMgaW50ZXJmYWNlLg0K
DQpTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0BhbWQuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8IDExICsrKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIGluZGV4
IGE1NWEyZTgzZmIxOS4uYWY2OGY5ODE1ZjI4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbnYuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYw0K
QEAgLTUzOSw2ICs1MzksMTYgQEAgc3RhdGljIGJvb2wgbnZfbmVlZF9yZXNldF9vbl9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIAlyZXR1cm4gZmFsc2U7DQogfQ0KIA0KK3N0YXRp
YyB1aW50NjRfdCBudl9nZXRfcGNpZV9yZXBsYXlfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpIHsNCisNCisJLyogVE9ETw0KKwkgKiBkdW1teSBpbXBsZW1lbnQgZm9yIHBjaWVfcmVw
bGF5X2NvdW50IHN5c2ZzIGludGVyZmFjZQ0KKwkgKiAqLw0KKw0KKwlyZXR1cm4gMDsNCit9DQor
DQogc3RhdGljIHZvaWQgbnZfaW5pdF9kb29yYmVsbF9pbmRleChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikgIHsNCiAJYWRldi0+ZG9vcmJlbGxfaW5kZXgua2lxID0gQU1ER1BVX05BVkkxMF9E
T09SQkVMTF9LSVE7IEBAIC01ODYsNiArNTk2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRn
cHVfYXNpY19mdW5jcyBudl9hc2ljX2Z1bmNzID0NCiAJLm5lZWRfZnVsbF9yZXNldCA9ICZudl9u
ZWVkX2Z1bGxfcmVzZXQsDQogCS5nZXRfcGNpZV91c2FnZSA9ICZudl9nZXRfcGNpZV91c2FnZSwN
CiAJLm5lZWRfcmVzZXRfb25faW5pdCA9ICZudl9uZWVkX3Jlc2V0X29uX2luaXQsDQorCS5nZXRf
cGNpZV9yZXBsYXlfY291bnQgPSAmbnZfZ2V0X3BjaWVfcmVwbGF5X2NvdW50LA0KIH07DQogDQog
c3RhdGljIGludCBudl9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpDQotLQ0KMi4xNy4x
DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQt
Z2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
