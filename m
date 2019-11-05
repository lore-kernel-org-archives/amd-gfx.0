Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE6FC5DF61
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 16:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFC7217F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 16:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFC7217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA1B6EAE9;
	Tue,  5 Nov 2019 16:32:53 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800081.outbound.protection.outlook.com [40.107.80.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCFD6EAE9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 16:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUY/t7CSoE+vuXtNeWbSSUoYsb+prIVnzqIX/OvaCgrfikdyYB3anNjm3wQj12UPMOEM6mBlPJZ+enm5DWTQFMhcrccFTwkQdDeloEMJG1vnXjVxkleXkP6doRsBTXWZh61wwxtGN0mlVokg74aH1XJmanKVviEFOJpFoPJHh9ctLtTkCoXtcKa/Pc/ikQkmKlZupBTrP6FvYMKjbXRALl/GVL1EDvivrBMb//oCYCz+ERDXANKwljXSEcVcZP4dRcpBLHy+ckFk4PexD4Vxw8reThfkVvWu1HUun23S1UaNAHKsF6z1fgKDbCd/rrPmqJ8py/SJwRl0PT+E3v2T/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzbjK6xJCXf7V66RgMQDx9jZRYU1MQFBmOSgdfDwnb4=;
 b=RNrxulYEXGo0A85xfQqji37HhodkMRk6E1LkweaPs14pi7ORJ01pE7LjBzOqn0qF/WTwwGm4LyX0QAbkMj15z4HmigVh5OySQ7vEkTe1lu0rf4No2S/jkGin083+kRFDZLzJNEdX9cB9dAReiK/mguWnG1tWrgy2WSZRKdNUJvdjUdHH5QBp7tqgLhdINsKSmIBVi0N8bfEFwcHqxa3zseQvbKlXVRBwNwzVPqZjT/TBxmlxELdfvFefNAejEcVMVp2Rcgbazoqh00pHSS/IXHZffjWMViLxmb9bQWHJ2dwIy0Amz/fYAlZkkuFSORarBWK/ZBK/IvmiBceAxhbLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB3831.namprd12.prod.outlook.com (52.132.245.141) by
 CH2PR12MB4053.namprd12.prod.outlook.com (20.180.17.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 5 Nov 2019 16:32:50 +0000
Received: from CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::4403:1c3c:efc8:6155]) by CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::4403:1c3c:efc8:6155%3]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 16:32:49 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole
 hive initialized
Thread-Topic: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole
 hive initialized
Thread-Index: AQHVk8MYT24KBLC33UeKj0lVihThZKd8xQIw
Date: Tue, 5 Nov 2019 16:32:49 +0000
Message-ID:
 <CH2PR12MB3831CEABDD4CBA2FEB8DEFEB857E0@CH2PR12MB3831.namprd12.prod.outlook.com>
References: <20191105102310.16657-1-evan.quan@amd.com>
 <20191105102310.16657-2-evan.quan@amd.com>
In-Reply-To: <20191105102310.16657-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b375f7bf-922c-4bcc-9131-08d7620dcc64
x-ms-traffictypediagnostic: CH2PR12MB4053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB40530654B3D616A074C4CBFA857E0@CH2PR12MB4053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(13464003)(476003)(186003)(256004)(14444005)(66066001)(81156014)(74316002)(7736002)(81166006)(305945005)(8936002)(99286004)(71190400001)(71200400001)(486006)(446003)(86362001)(11346002)(25786009)(478600001)(76176011)(6246003)(6506007)(76116006)(316002)(4326008)(2906002)(66446008)(33656002)(66476007)(110136005)(2501003)(64756008)(66946007)(66556008)(55016002)(5660300002)(9686003)(8676002)(14454004)(7696005)(3846002)(6436002)(52536014)(6116002)(229853002)(26005)(53546011)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4053;
 H:CH2PR12MB3831.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mM8j+6vfwdhmQiMNR/loBHtjDe4U5caSHnd7i9mzotlMSzurfeo91pYJpNp9ODYkMCeSGI99XbeWcJHdC0nr7HVJcAwpCZTxJ7b6mdQck2ILzZJG1W89uPauhvOwcS1HaKQKC+BYbkXtvDS4sAC3RuG0RKikFVtlJMab+8Kpu4NHFqQuBANYfFOKts8HQ/kFXz8cwDUKyOtfNom7jdUuIVhPrqqgItAeFMnu7G9zt6+stj71LLo2BIyl6msaWjvSr1HiFb45Ae+ZXtMd4QlJlGzvvIsffYYABKLcXQdlTdDPitjAQaadlBjwUjMJmPMD2jWgZji9El0D7+Xhol3ZujjztTb4V44Sfjd/oN83Gl2AG2rEC74qe0adecE55CtLAw+XyeXpXRnen5SoPmOQaF/pu2zJQC17fSHZXQz7jqBxlosTR1OR3E573Amej8Wu
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b375f7bf-922c-4bcc-9131-08d7620dcc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 16:32:49.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9aqMzn/4hI8jHZdv/HGuza/wGjlci4+DInW95Ivw6V4WrQG+fK6R1a1h+Y47qRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzbjK6xJCXf7V66RgMQDx9jZRYU1MQFBmOSgdfDwnb4=;
 b=ncceAdB9fn9Xbiva4qTDSu2Rth4YTkRbOLvR15Dvuv5Cd50rb/Hi366MVMx7cLqcIK0JN2Lx3vNd7LdJVNvQswW7PQkb3NTDdi/Vx34w1Q7g3cuv5hNvobTf+fYRSBqadVat/5fr9eP5bxjN38aIWzn/OMlQ1kf4yUQoWHXg6qc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
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
Cc: "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105163249.q3nrIUNPNlBkiSRg9fi2ifmv1EMFe24frmfYjeQqdBg@z>

UGxlYXNlIHNlZSBpbmxpbmUuCgpKb24KCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZyb206
IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPiAKU2VudDogVHVlc2RheSwgTm92ZW1iZXIg
NSwgMjAxOSA1OjI0IEFNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogS2lt
LCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBTdHJhd2JyaWRnZSwgTWljaGFlbCA8
TWljaGFlbC5TdHJhd2JyaWRnZUBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5j
b20+ClN1YmplY3Q6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IHBlcmZvcm0gcC1zdGF0ZSBzd2l0
Y2ggYWZ0ZXIgdGhlIHdob2xlIGhpdmUgaW5pdGlhbGl6ZWQKClAtc3RhdGUgc3dpdGNoIHNob3Vs
ZCBiZSBwZXJmb3JtZWQgYWZ0ZXIgYWxsIGRldmljZXMgZnJvbSB0aGUgaGl2ZSBnZXQgaW5pdGlh
bGl6ZWQuCgpDaGFuZ2UtSWQ6IElmYzdjYWM5ZWYwY2YyNTA0NDdkMmE0MTJkYTM1ZDYwMWUyYWM3
OWVjClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNDcgKysrKysrKysrKysr
KysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBl
NmNlOTQ5NjcwZTUuLjJkNzJkMjA2Y2VhZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjA5MCw2ICsyMDkwLDcgQEAgc3RhdGljIGludCBhbWRncHVf
ZGV2aWNlX2VuYWJsZV9tZ3B1X2Zhbl9ib29zdCh2b2lkKQogICovCiBzdGF0aWMgaW50IGFtZGdw
dV9kZXZpY2VfaXBfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgeworCXN0
cnVjdCBhbWRncHVfZ3B1X2luc3RhbmNlICpncHVfaW5zdGFuY2U7CiAJaW50IGkgPSAwLCByOwog
CiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV9pcF9ibG9ja3M7IGkrKykgeyBAQCAtMjExNSw2
ICsyMTE2LDQwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9sYXRlX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJaWYgKHIpCiAJCURSTV9FUlJPUigiZW5hYmxlIG1ncHUg
ZmFuIGJvb3N0IGZhaWxlZCAoJWQpLlxuIiwgcik7CiAKKworCWlmIChhZGV2LT5nbWMueGdtaS5u
dW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7CisJCW11dGV4X2xvY2soJm1ncHVfaW5mby5tdXRleCk7
CisKKwkJLyoKKwkJICogUmVzZXQgZGV2aWNlIHAtc3RhdGUgdG8gbG93IGFzIHRoaXMgd2FzIGJv
b3RlZCB3aXRoIGhpZ2guCisJCSAqCisJCSAqIFRoaXMgc2hvdWxkIGJlIHBlcmZvcm1lZCBvbmx5
IGFmdGVyIGFsbCBkZXZpY2VzIGZyb20gdGhlIHNhbWUKKwkJICogaGl2ZSBnZXQgaW5pdGlhbGl6
ZWQuCisJCSAqCisJCSAqIEhvd2V2ZXIsIGl0J3MgdW5rbm93biBob3cgbWFueSBkZXZpY2UgaW4g
dGhlIGhpdmUgaW4gYWR2YW5jZS4KKwkJICogQXMgdGhpcyBpcyBjb3VudGVkIG9uZSBieSBvbmUg
ZHVyaW5nIGRldmljZXMgaW5pdGlhbGl6YXRpb25zLgorCQkgKgorCQkgKiBTbywgd2Ugd2FpdCBm
b3IgYWxsIFhHTUkgaW50ZXJsaW5rZWQgZGV2aWNlcyBpbml0aWFsaXplZC4KKwkJICogVGhpcyBt
YXkgYnJpbmcgc29tZSBkZWxheXMgYXMgdGhvc2UgZGV2aWNlcyBtYXkgY29tZSBmcm9tCisJCSAq
IGRpZmZlcmVudCBoaXZlcy4gQnV0IHRoYXQgc2hvdWxkIGJlIE9LLgorCQkgKi8KKwkJaWYgKG1n
cHVfaW5mby5udW1fZGdwdSA9PSBhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMpIHsK
W0pLXSBUaGlzIGNvbmRpdGlvbiB3aWxsIG5ldmVyIHN1Y2NlZWQuICBtZ3B1X2luZm8ubnVtX2Rn
cHUgaXMgMC1pbmRleGVkIHdoaWxlIG51bV9waHlzaWNhbF9ub2RlcyBnaXZlIHRvdGFsIG5vZGVz
LgoKKwkJCWZvciAoaSA9IDA7IGkgPCBtZ3B1X2luZm8ubnVtX2dwdTsgaSsrKSB7CisJCQkJZ3B1
X2luc3RhbmNlID0gJihtZ3B1X2luZm8uZ3B1X2luc1tpXSk7CisJCQkJaWYgKGdwdV9pbnN0YW5j
ZS0+YWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQorCQkJCQljb250aW51ZTsKKworCQkJCXIgPSBh
bWRncHVfeGdtaV9zZXRfcHN0YXRlKGdwdV9pbnN0YW5jZS0+YWRldiwgMCk7CisJCQkJaWYgKHIp
IHsKKwkJCQkJRFJNX0VSUk9SKCJwc3RhdGUgc2V0dGluZyBmYWlsZWQgKCVkKS5cbiIsIHIpOwor
CQkJCQlicmVhazsKKwkJCQl9CisJCQl9CisJCX0KKworCQltdXRleF91bmxvY2soJm1ncHVfaW5m
by5tdXRleCk7CisJfQorCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTIyMjcsMTggKzIyNjIsNiBAQCBz
dGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX2RlbGF5ZWRfaW5pdF93b3JrX2hhbmRsZXIoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQogCXIgPSBhbWRncHVfaWJfcmluZ190ZXN0cyhhZGV2KTsKIAlp
ZiAocikKIAkJRFJNX0VSUk9SKCJpYiByaW5nIHRlc3QgZmFpbGVkICglZCkuXG4iLCByKTsKLQot
CS8qCi0JICogc2V0IHRvIGxvdyBwc3RhdGUgYnkgZGVmYXVsdAotCSAqIFRoaXMgc2hvdWxkIGJl
IHBlcmZvcm1lZCBhZnRlciBhbGwgZGV2aWNlcyBmcm9tCi0JICogWEdNSSBmaW5pc2ggdGhlaXIg
aW5pdGlhbGl6YXRpb25zLiBUaHVzIGl0J3MgbW92ZWQKLQkgKiB0byBoZXJlLgotCSAqIFRoZSB0
aW1lIGRlbGF5IGlzIDJTLiBUT0RPOiBjb25maXJtIHdoZXRoZXIgdGhhdAotCSAqIGlzIGVub3Vn
aCBmb3IgYWxsIHBvc3NpYmxlIFhHTUkgc2V0dXBzLgotCSAqLwotCXIgPSBhbWRncHVfeGdtaV9z
ZXRfcHN0YXRlKGFkZXYsIDApOwotCWlmIChyKQotCQlEUk1fRVJST1IoInBzdGF0ZSBzZXR0aW5n
IGZhaWxlZCAoJWQpLlxuIiwgcik7CiB9CiAKIHN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfZGVs
YXlfZW5hYmxlX2dmeF9vZmYoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQotLQoyLjIzLjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
