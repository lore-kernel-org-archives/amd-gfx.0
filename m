Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E6AC010A2
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 11:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDAA20869
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 11:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDAA20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811166E9CE;
	Tue,  5 Nov 2019 11:02:18 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730046.outbound.protection.outlook.com [40.107.73.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8176E9CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 11:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz92P5iyPEcs66Tm2Fe6/vokqRx/9usZ3dNbFL+8yK9+Ybs2zAvRageSBk0kl1zssKe7gz9y5rt0oAmiCCCJTCUM4ZRmWkQLaItD/uZlnKpnP041PuaQFlyLDG3q6hUl/i0g9KwWNykVtXQyg4WBAPHuGJSFM74uCZx0i0+BXV/QuXTguucz6dYQp1U0K6KfrykTvE3OZMOIbIdh/Y2qXJ+XSEamXYaf/Oj3dvHo9uikWHAMXtdIXO9JEJFUWFUCjweFf4Jvv2KMTaco8HGD2Yvppf3oVIIJKCGd2RZiD96wfb3Sly4zg3XJMjKdYkjlfR/o+Vxb1H1oPOEk1wWeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abTxVt8st1u5oKqhuTv8CujW+MUwo2F7nSYTLw7Ulso=;
 b=M5wuZAamqaq7XYGg1sQcaAl+Vyar0l6VcmQMt9ZtAmRPfCEvRoku+w2gvmgQma4NfovHt7xQ/Ey/x1eQLUcf6dcuzjfA6I5etTERX8z7cMMm14JjCJ2Q5240aP6bG9Wop/P2JKG+VRciJz17sKD6tGEC0ufttAlUA09KtHDcDuQd04fI+CFWzp0673kNJN9FQApocZKIN+Wo0F81/wG0RvIwooA4SzoOR/x9i6cWdu8X4hdZT28hzUHqYgAocq3M+4q+JReDY1LP4tiXaAFH7Qz7ZEsixGSQJh6zaPOoF6QQx0fyHBHb4t/BDHFL/mobHaDMikMxCXSZHckoeROMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB4270.namprd12.prod.outlook.com (52.135.50.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 11:02:14 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::3db4:a949:8b89:33be]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::3db4:a949:8b89:33be%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 11:02:13 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix sysfs interface pcie_replay_count error on
 navi asic
Thread-Topic: [PATCH] drm/amdgpu: fix sysfs interface pcie_replay_count error
 on navi asic
Thread-Index: AQHVk8h6SPirv1iUwEaHj/HinRjGJw==
Date: Tue, 5 Nov 2019 11:02:13 +0000
Message-ID: <20191105110200.29855-1-kevin1.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::22) To MN2PR12MB3296.namprd12.prod.outlook.com
 (2603:10b6:208:aa::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afee9067-7abe-4cb2-5d70-08d761df9cbe
x-ms-traffictypediagnostic: MN2PR12MB4270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42708B4761B2831E0C5C4C04A27E0@MN2PR12MB4270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(2616005)(36756003)(102836004)(6506007)(99286004)(52116002)(186003)(6486002)(3846002)(81156014)(8676002)(6116002)(5640700003)(8936002)(50226002)(386003)(66556008)(66476007)(256004)(486006)(6916009)(476003)(26005)(2501003)(6512007)(71190400001)(71200400001)(4326008)(2906002)(1076003)(7736002)(305945005)(5660300002)(14454004)(64756008)(66446008)(66946007)(6436002)(54906003)(86362001)(316002)(81166006)(66066001)(478600001)(2351001)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4270;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5FebrZIIoupDQhAftvyhUt/MsxkxK1LTflZS+W8wLn5sH82ghsMndBbL4764n6xFIfc6CAsHJ4pSXp2mO1t5Hv0YHjUMwjqB/FYgPlXLUQpGkwFxHilIZWpLtOdT/mrXgtUwHvSMzPEkVEFfQ0Do3M4MTPOvKz9LXESPs34mm17JB4JJ44H7Xq/cydmkSM4MHDk6O5zBOIaYxesvgGYQ0F6baF1nThxyd/AIsMsEmBMQRS9m28PSoVG9cZ7m4SyP1QFc6HwozD+6s/gm3D7ihAsbPdUu6+R2m0qkcLyuFslyXf5JPavO704Wse+Nad8lfizGDSIcsa5cuyl7LrPldWR+ghvC076Iw2HYV1HA01X3FbUH52kN1Dy7yg0avbKoYQG4J7NLsqh9JuBEOAQ/eIxqCM1r98WY193BGlRdXZcN/Xt9whz/a8UO+JxxgNU
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afee9067-7abe-4cb2-5d70-08d761df9cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 11:02:13.6694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X40L3W3g3ymEBzaG89NBT3q06DqWlJ/8RStYTmHD3VlTL8HUmpLiHIhaGqkJnuLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abTxVt8st1u5oKqhuTv8CujW+MUwo2F7nSYTLw7Ulso=;
 b=qTHf510GmoMcp7M+YKGILjfJkmqDf53WF4CNlyqPtnpuWfPl8dqT1gEqLQi11rNCa8I4Rk8gHa7z1mrcSasr+u0UxOeGSlfU9l6idJ+neL41RsVwOq4rdphOcRvkFpuJLnlYP2ZO+Hi5qJQKavgzj1tXHQUp55RGVGzW7UDpsIw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yuan,
 Xiaojie" <Xiaojie.Yuan@amd.com>, "Li, 
 Candice" <Candice.Li@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105110213.PLI-VcF92h3WxA17aSkBoI-175YcWPA3Rou4OEDdkEI@z>

dGhlIGFzaWMgY2FsbGJhY2sgZnVuY3Rpb24gb2YgZ2V0X3BjaWVfcmVwbGF5X2NvdW50IGlzIG5v
dCBpbXBsZW1lbnQgb24gbmF2aSBhc2ljLAppdCB3aWxsIGNhdXNlIG51bGwgcGludGVyIGVycm9y
IHdoZW4gcmVhZCB0aGlzIGludGVyZmFjZS4KClNpZ25lZC1vZmYtYnk6IEtldmluIFdhbmcgPGtl
dmluMS53YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8
IDExICsrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jCmluZGV4IGE1NWEyZTgzZmIxOS4uYWY2OGY5ODE1ZjI4IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L252LmMKQEAgLTUzOSw2ICs1MzksMTYgQEAgc3RhdGljIGJvb2wgbnZfbmVl
ZF9yZXNldF9vbl9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXJldHVybiBmYWxz
ZTsKIH0KIAorc3RhdGljIHVpbnQ2NF90IG52X2dldF9wY2llX3JlcGxheV9jb3VudChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKK3sKKworCS8qIFRPRE8KKwkgKiBkdW1teSBpbXBsZW1lbnQg
Zm9yIHBjaWVfcmVwbGF5X2NvdW50IHN5c2ZzIGludGVyZmFjZQorCSAqICovCisKKwlyZXR1cm4g
MDsKK30KKwogc3RhdGljIHZvaWQgbnZfaW5pdF9kb29yYmVsbF9pbmRleChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKIHsKIAlhZGV2LT5kb29yYmVsbF9pbmRleC5raXEgPSBBTURHUFVfTkFW
STEwX0RPT1JCRUxMX0tJUTsKQEAgLTU4Niw2ICs1OTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGFtZGdwdV9hc2ljX2Z1bmNzIG52X2FzaWNfZnVuY3MgPQogCS5uZWVkX2Z1bGxfcmVzZXQgPSAm
bnZfbmVlZF9mdWxsX3Jlc2V0LAogCS5nZXRfcGNpZV91c2FnZSA9ICZudl9nZXRfcGNpZV91c2Fn
ZSwKIAkubmVlZF9yZXNldF9vbl9pbml0ID0gJm52X25lZWRfcmVzZXRfb25faW5pdCwKKwkuZ2V0
X3BjaWVfcmVwbGF5X2NvdW50ID0gJm52X2dldF9wY2llX3JlcGxheV9jb3VudCwKIH07CiAKIHN0
YXRpYyBpbnQgbnZfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQotLSAKMi4xNy4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
