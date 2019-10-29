Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08909CA9EC3
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 01:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE9820717
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 01:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE9820717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC4C6E059;
	Tue, 29 Oct 2019 01:36:52 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750045.outbound.protection.outlook.com [40.107.75.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FE26E059
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 01:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI4T1VDV6FXMAZJSdmATb7D3UiIf3RyMzanfPx8fdOlnqpq0dL464yGhPrVT1rGuRTt4gB7+Qt9ABbRZysuXkK99DA+cSVmy097R1rw5mBnZzcYd2RWFV/ocFCdsNRJq6GSu75/6p2do+iqBL0kPBWygU7wFreH18Mj1pcZ+wBzJihZbZgxiVXu3lR6/6ymv3aT2C1Tt/eC3NEOA2lI8gtfEYEuVX26Cc7ZkAElWh24ohYUcjHY2cOv/d7jLJLIiD6T4kM3iDJJZLWHFHx3RSpj5A8I7wnyvgj/h51LA0ijpFMpVPOIhsvHGslpVWwM8aI0UrNaroH4kOzfwwjhciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro6uUsutVNjP5bfYvVSwpxZ7oj6wkg2j69j4+FoM+lU=;
 b=SaRVOApMdquLRmNKAUhGj7XuS30M2j4oSTOgq5wE/4FOV5CnxIYPCQx4aQ7QLrUxDpd4reSYrmYQGGgNQ71wuBY1788yiEIkWvOSwt8j3gPtlkDEWYGKJ61AdiWMRmNFzDwRUKQSSHcehgVTEot4GNcb8a7QmjWl0AbAX2SJTLuSmC6oEnafF9o+lisOygsJ/xZIjeC3CyR+AW0ohUUoyvFauZ0Htyr9YAWalM+BMxbjYsP7pJWyzRlQfc1lRU+KlROFckuDUJ5g5aPq5MZIab5fXvtY9MrJaeT4WcBz9m9xwLYpxSwOeau5dZ6C8GzfIdZoQeu/z6owFvcjnPZvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3591.namprd12.prod.outlook.com (20.178.54.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Tue, 29 Oct 2019 01:36:45 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::cd:2613:ee29:5acb]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::cd:2613:ee29:5acb%7]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 01:36:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: remove ras global recovery handling from
 ras_controller_int handler
Thread-Topic: [PATCH 4/4] drm/amdgpu: remove ras global recovery handling from
 ras_controller_int handler
Thread-Index: AQHVjYM8kWpTy1MAkk2P4laqIXFZ8adw1vFw
Date: Tue, 29 Oct 2019 01:36:45 +0000
Message-ID:
 <BYAPR12MB2806A8C355785EFB07D88E2EF1610@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <1572262269-14985-1-git-send-email-le.ma@amd.com>
 <1572262269-14985-4-git-send-email-le.ma@amd.com>
In-Reply-To: <1572262269-14985-4-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0af66af9-0798-4ae1-ea14-08d75c107569
x-ms-traffictypediagnostic: BYAPR12MB3591:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3591AAC977E225B3504AC5E7F1610@BYAPR12MB3591.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(13464003)(446003)(76116006)(476003)(486006)(5660300002)(76176011)(14454004)(11346002)(6116002)(4326008)(74316002)(86362001)(3846002)(966005)(7736002)(99286004)(229853002)(305945005)(8936002)(316002)(478600001)(110136005)(71190400001)(71200400001)(14444005)(7696005)(33656002)(2501003)(6506007)(53546011)(6306002)(52536014)(66446008)(64756008)(66556008)(66946007)(9686003)(102836004)(25786009)(66476007)(6436002)(55016002)(2906002)(26005)(8676002)(6246003)(81166006)(256004)(66066001)(81156014)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3591;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1CbeNstKnsHhreHKJcyAG2rqJVWcUBuYgJZXFNj7YDYZ8H04S6bxaq74bUzjy84L/1mNYue2rgAgfrCgtW7B18EGJoPr/4VISkKuJWzEf0XAmis1vvFwQZmHaDFtNCOiPhtAXdRHYOIpzwL+vqr5uBwpmTmTGPMyYaqlizrT3btiduiZ2Wq4b9h75KAX4WUoT4wnKUIrEGCExqhi3fKpYKu0eUrz3Bwl8frC/0jjg1o1GgATRCH787YBX25US07jgq+gvTgha16XFut39PN6q6/OcgH11mUFzJjU5KJ/ETe173k46m7NpkwjLpP4POIFoOBi4Oc++v7QhQbLWd7Twk7oSRvWRwfB4uQlwYjMyCAAqXwy3n1Qd8naVnbFpoV4NVeYB6TyGBimdDXIMt80EuI2/zR3Y/kOUSVoznTP6OP2BkV9fsm+eoplOcIONZhS6/FhsVjKa5MyV0BpDj4qh7d6hXL3QP4sblgQg/mm2b4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af66af9-0798-4ae1-ea14-08d75c107569
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 01:36:45.4184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17m9vI62uzcahVbpfctS72V1B/PMCMyD9/UOAC7nVErFCfksjNKTGdBPZ7nqIk/5H3TZa+iYHMPtIIAEX913ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3591
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro6uUsutVNjP5bfYvVSwpxZ7oj6wkg2j69j4+FoM+lU=;
 b=w+GbGNB1cNOE8EEF5WK0lXtgl0pjfB943o26GVG4IwPriUgr3gmZKmQls2afn2faSPtjteCA2IZYiAgfwM6aE/lSX/3ngfZ339ZVVVGKDN7caBukPrNo4fAwWlPgFe6kfIUXnsBEuZYro+NVrG2vgg4FybiV2RGHeAf4ZACJ284=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
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
Cc: "Ma, Le" <Le.Ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029013645._2V-0VI0BPW3zuaOxdNNNbZG2Og0_lr0zBexU4cdE_U@z>

DQoNCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVo
YWxmIE9mIExlIE1hDQpTZW50OiBNb25kYXksIE9jdG9iZXIgMjgsIDIwMTkgNzozMSBQTQ0KVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTWEsIExlIDxMZS5NYUBhbWQuY29t
Pg0KU3ViamVjdDogW1BBVENIIDQvNF0gZHJtL2FtZGdwdTogcmVtb3ZlIHJhcyBnbG9iYWwgcmVj
b3ZlcnkgaGFuZGxpbmcgZnJvbSByYXNfY29udHJvbGxlcl9pbnQgaGFuZGxlcg0KDQpGcm9tOiBM
ZSBNYSA8TGUuTWFAYW1kLmNvbT4NCg0KQ2hhbmdlLUlkOiBJYThhNjFhNGIzYmQ1MjlmMGY2OTFl
NDNlNjliMjk5ZDdkMTUxYzBjMg0KU2lnbmVkLW9mZi1ieTogTGUgTWEgPExlLk1hQGFtZC5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYyB8IDYgKysrKyst
DQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYw0KaW5kZXggMGRiNDU4Zi4uODc2NjkwYSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jDQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYw0KQEAgLTMyNCw3ICszMjQs
MTEgQEAgc3RhdGljIHZvaWQgbmJpb192N180X2hhbmRsZV9yYXNfY29udHJvbGxlcl9pbnRyX25v
X2JpZnJpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UNCiAJCQkJCQlSQVNfQ05UTFJfSU5URVJSVVBU
X0NMRUFSLCAxKTsNCiAJCVdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9ET09SQkVMTF9JTlRf
Q05UTCwgYmlmX2Rvb3JiZWxsX2ludHJfY250bCk7DQogDQotCQlhbWRncHVfcmFzX2dsb2JhbF9y
YXNfaXNyKGFkZXYpOw0KKwkJLyoNCisJCSAqIHJhc19jb250cm9sbGVyX2ludCBpcyBkZWRpY2F0
ZWQgZm9yIG5iaWYgcmFzIGVycm9yLA0KKwkJICogbm90IHRoZSBnbG9iYWwgaW50ZXJydXB0IGZv
ciBzeW5jIGZsb29kDQorCQkgKi8NCisJCWFtZGdwdV9yYXNfcmVzZXRfZ3B1KGFkZXYsIHRydWUp
Ow0KW0d1Y2h1bl1XZSBuZWVkIHRvIGFkZCBvbmUgcHJpbnRpbmcgaGVyZSB0byB0ZWxsIGF1ZGll
bmNlLCB3aG8gYW5kIHdoeSByZXNldHMgZ3B1PyBBbmQgbW9yZW92ZXIsIGluIHRoZSByZW1vdmVk
IGdsb2JhbCByYXMgaXNyIGhhbmRsZXIgYW1kZ3B1X3Jhc19nbG9iYWxfcmFzX2lzciwgd2UgY2Fs
bCBhbWRncHVfcmFzX3Jlc2V0X2dwdSB3aXRoIGlzX2JhY28gcGFyYW1ldGVyICJmYWxzZSIsIGJ1
dCBub3cgd2UgdXNlICJ0cnVlIiBoZXJlPw0KIAl9DQogfQ0KIA0KLS0gDQoyLjcuNA0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWls
aW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
