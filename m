Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F50C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001B8217F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001B8217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982BB6EE12;
	Wed,  6 Nov 2019 17:26:59 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F21B6EE12
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 17:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeISBxBx/M1RIpXQcVZVa8vYX7cJaf+933MqlFYAcBXRXnbQ8xkgVKjfH1bYyCSfFchkcrg5RmiEy+42GK39UtBE6M5+Xag+1DDg3cvXlrGhA95sbk+m4WBvpbJptIUS6aBTCv/QKGAKIjnYvhOACRuNhevLT7pJU0G6PuhNsdFLJJE5koKrgK1UJX1wO9ZXUOeVQMkhUeE0R9w7wlk8afxb330TSYRGJSk7ZpuE2+HTDnlDIBu1iTIhrYK3FSYpn3ZZVA82rGRTvq6ZsgrDAZFvswClSH9BsiQLymw4DJkXItviC3+7tw6zsEya/p2fdKveWRxydmI97kZeKQ+fWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWJNCPsgDRckprUu8QV3b1PDA/xfYSNFZRTzxsQOgGM=;
 b=Ooy2XCOI+sImev/LYR1tYjgkF/ECwjji9f9WUsiD/p6PiD2E8pLP01chjUdSt4j2MltcNhXG7b31EXtEAk8u6c8yN9Y7k5/cFoSopfY7v3w5u/enp3klKis/QIBTpwPcGF0+nQ9RY4JorGsmMqo+OWA02Z+JYWEQWDp/TF1bwi96HpBahc+WTspV6R7XQJqdsdE0V+24PX88JPO3T8JWnxaSc+qk+ShrpwzAXmpoDHt0MXEpIn+8c2/+2+RnX64gaUW+IIX4LXZaamhvEmVo7PL3yqoJ5WGOsriKrzQBbR0wib0ebzzZt46yEcI1tyEW7frg6m5pbx2Wk5AT2p4+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2817.namprd12.prod.outlook.com (20.177.207.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 17:26:56 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 17:26:56 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Topic: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Index: AQHVlMdj9LKXevQ1Yk2iPklewez+ug==
Date: Wed, 6 Nov 2019 17:26:56 +0000
Message-ID: <1573061209-13148-1-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To BL0PR12MB2580.namprd12.prod.outlook.com
 (2603:10b6:207:3e::19)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36773485-85ae-4b2e-8483-08d762de85a2
x-ms-traffictypediagnostic: BL0PR12MB2817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2817003461B03D454690CB4F80790@BL0PR12MB2817.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(36756003)(316002)(71200400001)(54906003)(5660300002)(52116002)(26005)(102836004)(86362001)(2616005)(6506007)(81166006)(6512007)(99286004)(66946007)(66556008)(66476007)(2906002)(64756008)(305945005)(66446008)(7736002)(8936002)(386003)(486006)(476003)(5640700003)(71190400001)(14444005)(256004)(8676002)(81156014)(14454004)(4326008)(6916009)(25786009)(50226002)(6116002)(3846002)(2501003)(66066001)(6486002)(478600001)(6436002)(2351001)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2817;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+B9U1wbAFAuONWEH14vwLTpz7q7NbKUmQlq/+/b82LccNDcLWKqovtLXO4FAylXuHnb22ogKBW8jLMRhaklWsptkb8aSAFquLFCw/AXO7vnBQHrnwfEJXcW/Pemzb1LZvP4vlVb5HejT6ABW3TRQz43SzyScdYg3o8dJ4y/4DgZlzsfSbIURWV+UkxUcSaY1x+XHirg3kb+D32AVytfRSkt35bAyfsTZyiMR2pUL6nf8ItCcL19r++c5Q2YhwfUEg9ClI1Zo595cHpt1dryNxSvH1CeYJ0Q9ryH8PHc2sFzaXcQ0AYY0EUeiwvyhhgPmxDTwP2g1HoPsG4wCcIbJRMf1SIrOIHF5D1O0WIiDOBnM+UH05DlY5sE87etINtV+vOBP8VQ7OZSBTFaKEwLM2SXFZG8TMAroRbShi1V2JnPA5mGMK9m9YIpEAerZXAA
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36773485-85ae-4b2e-8483-08d762de85a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 17:26:56.3045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcihZD1kcHVab4TCbTssvkW2XafRM7Hs1fpXFBRIPpcVJ3AAuVJFtf0isP9LF+qb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2817
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWJNCPsgDRckprUu8QV3b1PDA/xfYSNFZRTzxsQOgGM=;
 b=cFFXEXXAUAYEeV70WoaTP+nIpte/9c05JUEKvXjGha7Blz0GU78HvKGuhXbdKEwwH/orPG72XmA7I+pCh1LubPSd7UzLEZMO7d9D3gKSkC0G9JHnifLV9RrCJo0aSMEEgFS++0POWtgv/b7SsmTVgP0jHRxRNtOe/pJ/Jrs714o=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zeng, Oak" <Oak.Zeng@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106172656.ZVejlUDMvIE_h6XmxSI0hadAjZ72I2Xqs1Y7sq_0DF0@z>

RXhwbGFpbiBmaWVsZHMgbGlrZSBhcGVyX2Jhc2UsIGFncF9zdGFydCBldGMuIFRoZSBkZWZpbml0
aW9uCm9mIHRob3NlIGZpZWxkcyBhcmUgY29uZnVzaW5nIGFzIHRoZXkgYXJlIGZyb20gZGlmZmVy
ZW50IHZpZXcKKENQVSBvciBHUFUpLiBBZGQgY29tbWVudHMgZm9yIGVhc2llciB1bmRlcnN0YW5k
LgoKQ2hhbmdlLUlkOiBJMDJjMmEyN2NkMGRiYzIwNTQ5OGViODZhYWZhNzIyZjJlMGMyNWZlNgpT
aWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCAyNiArKysrKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmgKaW5kZXggNTU1ZDhlNS4uMTM1NmZmOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaApAQCAtMTI3LDE4ICsxMjcsNDQgQEAgc3RydWN0
IGFtZGdwdV94Z21pIHsKIH07CiAKIHN0cnVjdCBhbWRncHVfZ21jIHsKKwkvKiBGQidzIHBoeXNp
Y2FsIGFkZHJlc3MgaW4gTU1JTyBzcGFjZSAoZm9yIENQVSB0bworCSAqIG1hcCBGQikuIFRoaXMg
aXMgZGlmZmVyZW50IGNvbXBhcmVkIHRvIHRoZSBhcGcvCisJICogZ2FydC92cmFtX3N0YXJ0L2Vu
ZCBmaWVsZCBhcyB0aGUgbGF0ZXIgaXMgZnJvbQorCSAqIEdQVSdzIHZpZXcgYW5kIGFwZXJfYmFz
ZSBpcyBmcm9tIENQVSdzIHZpZXcuCisJICovCiAJcmVzb3VyY2Vfc2l6ZV90CQlhcGVyX3NpemU7
CiAJcmVzb3VyY2Vfc2l6ZV90CQlhcGVyX2Jhc2U7CiAJLyogZm9yIHNvbWUgY2hpcHMgd2l0aCA8
PSAzMk1CIHdlIG5lZWQgdG8gbGllCiAJICogYWJvdXQgdnJhbSBzaXplIG5lYXIgbWMgZmIgbG9j
YXRpb24gKi8KIAl1NjQJCQltY192cmFtX3NpemU7CiAJdTY0CQkJdmlzaWJsZV92cmFtX3NpemU7
CisJLyogQVBHIGFwZXJ0dXJlIHN0YXJ0IGFuZCBlbmQgaW4gTUMgYWRkcmVzcyBzcGFjZQorCSAq
IERyaXZlciBmaW5kIGEgaG9sZSBpbiB0aGUgTUMgYWRkcmVzcyBzcGFjZQorCSAqIHRvIHBsYWNl
IEFHUCBieSBzZXR0aW5nIE1DX1ZNX0FHUF9CT1QvVE9QIHJlZ2lzdGVycworCSAqIFVuZGVyIFZN
SUQwLCBsb2dpY2FsIGFkZHJlc3MgPT0gTUMgYWRkcmVzcworCSAqIEFHUCBhcGVydHVyZSBpcyB1
c2VkIHRvIHNpbXVsYXRlIEZCIGluIFpGQiBjYXNlCisJICovCiAJdTY0CQkJYWdwX3NpemU7CiAJ
dTY0CQkJYWdwX3N0YXJ0OwogCXU2NAkJCWFncF9lbmQ7CisJLyogR0FSVCBhcGVydHVyZSBzdGFy
dCBhbmQgZW5kIGluIE1DIGFkZHJlc3Mgc3BhY2UKKwkgKiBEcml2ZXIgZmluZCBhIGhvbGUgaW4g
dGhlIE1DIGFkZHJlc3Mgc3BhY2UKKwkgKiB0byBwbGFjZSBHQVJUIGJ5IHNldHRpbmcgVk1fQ09O
VEVYVDBfUEFHRV9UQUJMRV9TVEFSVC9FTkRfQUREUgorCSAqIHJlZ2lzdGVycworCSAqIFVuZGVy
IFZNSUQwLCBsb2dpY2FsIGFkZHJlc3MgaW5zaWRlIEdBUlQgYXBlcnR1cmUgd2lsbAorCSAqIGJl
IHRyYW5zbGF0ZWQgdGhyb3VnaCBncHV2bSBnYXJ0IHBhZ2UgdGFibGUgdG8gYWNjZXNzCisJICog
cGFnZWQgc3lzdGVtIG1lbW9yeQorCSAqLwogCXU2NAkJCWdhcnRfc2l6ZTsKIAl1NjQJCQlnYXJ0
X3N0YXJ0OwogCXU2NAkJCWdhcnRfZW5kOworCS8qIEZyYW1lIGJ1ZmZlciBhcGVydHVyZSBvZiB0
aGlzIEdQVSBkZXZpY2UuIERpZmZlcmVudCBmcm9tCisJICogZmJfc3RhcnQgKHNlZSBiZWxvdyks
IHRoaXMgb25seSBjb3ZlcnMgdGhlIGxvY2FsIEdQVSBkZXZpY2UuCisJICogRHJpdmVyIGdldCBm
Yl9zdGFydCBmcm9tIE1DX1ZNX0ZCX0xPQ0FUSU9OX0JBU0UgKHNldCBieSB2YmlvcykKKwkgKiBh
bmQgY2FsY3VsYXRlIHZyYW1fc3RhcnQgb2YgdGhpcyBsb2NhbCBkZXZpY2UgYnkgYWRkaW5nIGFu
CisJICogb2Zmc2V0IGluc2lkZSB0aGUgWEdNSSBoaXZlLgorCSAqIFVuZGVyIFZNSUQwLCBsb2dp
Y2FsIGFkZHJlc3MgPT0gTUMgYWRkcmVzcworCSAqLwogCXU2NAkJCXZyYW1fc3RhcnQ7CiAJdTY0
CQkJdnJhbV9lbmQ7CiAJLyogRkIgcmVnaW9uICwgaXQncyBzYW1lIGFzIGxvY2FsIHZyYW0gcmVn
aW9uIGluIHNpbmdsZSBHUFUsIGluIFhHTUkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
