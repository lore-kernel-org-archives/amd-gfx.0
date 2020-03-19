Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A90C55187
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 11:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703ED2070A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 11:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BBCc6SGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703ED2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1BC6EA04;
	Thu, 19 Mar 2020 11:42:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C83E6EA04
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 11:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnFnJaIpktTJRE6RiWfwwX+HB4fjIKIN9G2Dj+65la5U+DNMG9UqPx6PnEA/ZxNhO3ktHcFZCPm8TEgDIa3xy2pSgLcQHDEIkcj6nqan2HhqeWMUbk/yy8v233vABbNt6wWMB1jFyHnfeFdkzYa0OV5w6/Huxr2E0aPb5CiJq876+ZecBJoe4Fl7uKnOb6LcSZX1HdeLbR4WNfqWkoSX1YJTQX1LI+mGP4z8YCV9+Dv7+Luw9Dig5xXjRWh9+bV1pddvMQVyAq6RceJ8Y/DBCCZQPy12UP1yTElzHJ0eEPshzXMejEntc/3/oZi/iiK45M7C+8uZH8WJsbdS0nOofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/neUaPrNXpOu844eFIaBsZyZffu6xZ/1paQTPsXRE8=;
 b=lJ0qDtYMDzPR+TV3jq4h4Liv0W6JxBdTOks99DqwUEGYFQWWfNBg8WesfSA918ki9uZ9pli0JyOXs6QDeANYCihxx+88tlD9NmSV6CE3PyfoEvjM5qWA7jaTKQf+HPw077gD0nGE8U4ERs2EgfgSaRnpDSbdwl+xBR5zrAZk37/Jwz5MRLFHDl8k1SsSjmvHUnZib2huNuQKx2n6C752CLtTyAUuY1HRIDxrT80iO037Fb3XM1cN+2h7k5kseYgGvYK3dbU2OIA4x0qgP9Zx3J8rulJaWS3GXZUbmJNt26xETn0kjso9UWgJOAU73CEBvAlUG+ihJTVK7tUa3hwigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/neUaPrNXpOu844eFIaBsZyZffu6xZ/1paQTPsXRE8=;
 b=BBCc6SGYspO1UeuZUfu48wSqtswZqFaSE8afvAQMVkAmHlWkBOmoSXVGfkoDQi0RIkPMpI0ayqL+0eU2rofkosrDCuEIz76WIfeQqEz6BcputmlswQZLr0WUoVd/YtTvl3C6F/Y+crvRrlRhJZYv3PDHzkKpJ/c6HHJhFqogCZ0=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Thu, 19 Mar
 2020 11:42:05 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.023; Thu, 19 Mar 2020
 11:42:05 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amdkfd: fix the wrong no space return while acquires
 packet buffer
Thread-Topic: [PATCH] drm/amdkfd: fix the wrong no space return while acquires
 packet buffer
Thread-Index: AQHV/dyXZOk8h1fr9UGb0EgQvcOQH6hPyxkA
Date: Thu, 19 Mar 2020 11:42:04 +0000
Message-ID: <7E5FA008-9DFF-445E-A82E-DB825A3DE614@amd.com>
References: <1584615099-8115-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1584615099-8115-1-git-send-email-ray.huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5125098f-62af-4822-73a3-08d7cbfa8c37
x-ms-traffictypediagnostic: SN6PR12MB2845:|SN6PR12MB2845:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2845220FB069E98D87FEF5BF87F40@SN6PR12MB2845.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(36756003)(6506007)(966005)(4326008)(5660300002)(6862004)(86362001)(2616005)(81156014)(8676002)(8936002)(81166006)(33656002)(186003)(2906002)(66946007)(91956017)(76116006)(66476007)(66446008)(66556008)(478600001)(6486002)(45080400002)(37006003)(6512007)(54906003)(6636002)(316002)(26005)(71200400001)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2845;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +S7ZdshSNsfbcPO6w9S9RlZWM9OqyfZFCFCQ4CT+0BZ5mZh2g8uhD4zR2JRATz+cGJ5b4rhOf+YcK6M1UXRg90jTytkJxG60iz6qEfIPy3WeOs9ZJRrZhIpALQO5sNmzTFVXRdEOPU+Z9gTpKOhVlZwFbtzH6CFRjup+l/1GmTCLZaJ2hx+YJ6zTQkq8RWKszHTfuvdBNA676aybdE7zOaV3mFbMS+6Bze0oEI/53xlQuUYltklu26ImSEEkat+v+EvxAVdsCv2pvNEUpWcF4aJ5Xs3/X3I3YkDhlNzzMJmoF3mqEtIf5yailR9EcjoYXYrs3QON496U/yiS3QayjW51ATDbcOVYqA+tEXVRsLLyCba+5Jwl8zw6oQWSQvk1IM3QWY1gt+VAv9yu3ldBqCdYcczSMVtwORO3Zja9hKE5NdL0k6jCVjtCwOmMHrvlU5TfukMkkDN++y949nC9gD224khO95Z1eRNWJ3io7Ug=
x-ms-exchange-antispam-messagedata: c07tA0pZFyueeAJBPwmrwC3JqYVj4hTbacWAAuEnrC7gZbCg8ZifczwI419/vs0Pq83ci3ccSytGrrGcmkhScouq/rkn+S3ZGZ2sTeVfRHiSr89JRdqqs9Ri2ON9P1U5daQ9VFVgiKeu4pO5kRViJg==
Content-ID: <2C0C1963B222354A945BD5A3EA04909F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5125098f-62af-4822-73a3-08d7cbfa8c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 11:42:04.9332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsF9B5ZgmIbrjHFsSXXMnpiX4CsdZ2hAfovEar8MXh6B5t+Ekm97oaBrLbQ5A2MH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMOW5tDPmnIgxOeaXpSAxODo1Me+8jEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5j
b20+IOWGmemBk++8mg0KPiANCj4gVGhlIHF1ZXVlIGJ1ZmZlciBpbmRleCBzdGFydHMgZnJvbSBw
b3NpdGlvbiAwLCBzbyB0aGUgYXZhaWxhYmxlIGJ1ZmZlciBzaXplDQo+IHdoaWNoIHN0YXJ0cyBm
cm9tIHBvc2l0aW9uIDAgdG8gcnB0ciBzaG91bGQgYmUgInJwdHIiIGluZGV4IHZhbHVlLiBXaGls
ZSB0aGUNCj4gcGFja2V0X3NpemVfaW5fZHdvcmRzID09IHJwdHIsIHRoZSBhdmFpbGFibGUgYnVm
ZmVyIGlzIGp1c3QgZ29vZCBlbm91Z2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkg
PHJheS5odWFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2tlcm5lbF9xdWV1ZS5jIHwgMiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfa2VybmVsX3F1ZXVlLmMNCj4gaW5kZXggYmFlNzA2NC4uNDY2N2M4ZiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYw0KPiBAQCAtMjYz
LDcgKzI2Myw3IEBAIGludCBrcV9hY3F1aXJlX3BhY2tldF9idWZmZXIoc3RydWN0IGtlcm5lbF9x
dWV1ZSAqa3EsDQo+IAkJLyogbWFrZSBzdXJlIGFmdGVyIHJvbGxpbmcgYmFjayB0byBwb3NpdGlv
biAwLCB0aGVyZSBpcw0KPiAJCSAqIHN0aWxsIGVub3VnaCBzcGFjZS4NCj4gCQkgKi8NCj4gLQkJ
aWYgKHBhY2tldF9zaXplX2luX2R3b3JkcyA+PSBycHRyKQ0KPiArCQlpZiAocGFja2V0X3NpemVf
aW5fZHdvcmRzID4gcnB0cikNCg0KcnB0ciBzaG91bGQgYWx3YXlzIGJlID4gd3B0ciB1bmxlc3Mg
cmluZyBpcyBlbXB0eS4NCg0Kc2F5LCBycHRyIGlzIDQsIHBhY2tldF9zaXplX2luX2R3b3JkcyBp
cyA0LiBUaGVuIHdwdHIgY2hhbmdlcyBmcm9tIDAgdG8gNCwgdGhhdCBpcyBpbGxlZ2FsLg0KDQoN
Cj4gCQkJZ290byBlcnJfbm9fc3BhY2U7DQo+IA0KPiAJCS8qIGZpbGwgbm9wcywgcm9sbCBiYWNr
IGFuZCBzdGFydCBhdCBwb3NpdGlvbiAwICovDQo+IC0tIA0KPiAyLjcuNA0KPiANCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0x
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlz
dHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0
YT0wMiU3QzAxJTdDeGluaHVpLnBhbiU0MGFtZC5jb20lN0NkYjk4Y2ZkODRiNzY0ZTc3ZDIwZTA4
ZDdjYmYzOGRmZiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2
MzcyMDIxMTk5NTAxMTk5MDcmYW1wO3NkYXRhPW1xcmwydW9vUTk1RG5zNGw2Q3RtbU9CQ20lMkZx
Wnl3MXBYNDhWQTIwbWxaWSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
