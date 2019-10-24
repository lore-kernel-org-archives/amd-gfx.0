Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62390CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AB520679
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AB520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECA3893BC;
	Thu, 24 Oct 2019 10:58:24 +0000 (UTC)
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr780072.outbound.protection.outlook.com [40.107.78.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC50893BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 10:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOCAX/R6hY7HuO9V1pz8HMV96wppogDciwVQ8/NhBWOIHnBaB3pBzaaWgeG7TymLMr0dEyybwYId0SFXfBC0xMyHfEowUQz4qRpmaYKwcX9yn0R5c8q3K6XCBVVZ99FQYLGYIJ+4qNQthkb5fa7T2/acjb+WOU2MsVC9hr0ernycHyx56NfMY5kXLRIOiMhQsbn0r2yPLABj+GiPsIhmNZ4VEiy301lkWk+9RoAtTxNUx0pX1mxWgf7BfUSNdBKZRJeqK5Tw4KUqgUPRxksZ60/JY981SSjtSkYyLEKlepdPDme3lnsRAEjjXIQrml1Fh0vbhOhmdtrDg7CrNYEK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ebZ3IiVcYMqFNOoxsvayH7iN2Sb0zNWBUrkbaPmx2Q=;
 b=W8d+J9/mfpXOL8gZv/OVunfzMsyuLSnB3mS6gdgdIoHe0p3X0o8zVvQI/grq88RX3grs1UZLeylgN7ZrHUasD+WWemvgNOJzMVhD6zLnHqnsKmxKaScRPW4Lzv9Ubq+YRB7thsz5wThgBKCleMBr/9+dVsCfHb/u9QvOLvrDDEzoD7M1qdEWIgKXVGgZteu5HsEzRBT74nwm3pdLoc7ezdcFCN7UJIxM3oeDdvX29MTmDkm0Lc1feAPKVCHy4PT+vj8MW9Mew+yQvpIKZJllJEGxrBu4oKDm39fgPtvtsUVMlUfYhcBWO/M5G+LZgyjO9GIzZAtZ3yiFkDQKyEKwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.80.74) by
 MN2PR12MB3327.namprd12.prod.outlook.com (20.178.243.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 24 Oct 2019 10:58:21 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::dd77:dfe4:1913:9d7e]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::dd77:dfe4:1913:9d7e%4]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 10:58:21 +0000
From: "S, Shirish" <Shirish.S@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Topic: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Index: AQHVilnzZQjKfUg1H0yk/qIOzcWqzQ==
Date: Thu, 24 Oct 2019 10:58:21 +0000
Message-ID: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::30) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:a9::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 949cbb7c-818d-4983-68ff-08d7587115a0
x-ms-traffictypediagnostic: MN2PR12MB3327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3327B62C3BDCAE599AFD8977F26A0@MN2PR12MB3327.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(199004)(189003)(66066001)(25786009)(316002)(5660300002)(6436002)(66446008)(66946007)(36756003)(66476007)(305945005)(7736002)(14454004)(71190400001)(71200400001)(6486002)(66556008)(478600001)(6636002)(6512007)(81156014)(81166006)(186003)(2616005)(8676002)(26005)(64756008)(4326008)(486006)(2906002)(86362001)(50226002)(8936002)(54906003)(110136005)(476003)(99286004)(52116002)(386003)(6506007)(102836004)(14444005)(6116002)(3846002)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3327;
 H:MN2PR12MB3248.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auec/cToxbra6VCM6cVSZaFNVK5TGeIUMqjBsP2qKMrT6oMfZ3RXbJ+kmGTnR2FYsO3asekUr83FChGRn4VN8Vygl10WHztLlOzJ3lGZN8SB1MKd6xCd3SwnPeRhObmWSQ2D0UwWICEz4rmlro4ekb8scFuiLhBLcJNQZ/NF+hV5KVbk2fY63zN2bvFNC8npBVDFaVFrsQqvEfJKVvn3ch+Ioac7ihoo/Y3sCKYsaVY/rfu/I/LeAJnjWDamgawBmPWs5s8fdv/ywQP5qd758XclW/AXiP4FlNWwusgfszQvZAsYLRkrM+xctwPbZ5OQuZnJJVF/4xAZu3iWs7KgkZzv4oT/nqa0Y+SDG6/mSDOty/W775IHmB4RP3avtU6BIsBOOGXK5lpxPtFXgTOey5W9VFmtePkFeVAjNm5lrvr+IVVxANKWim9TZiiahJvK
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949cbb7c-818d-4983-68ff-08d7587115a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 10:58:21.6495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYoYMdodpWSYeZchQjieznRHzm6FO+XDiBoHLUO2QyvF3SPW3RFDmWwIt+I1O9EOxCF0kKcLaGP9BIuG92uhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ebZ3IiVcYMqFNOoxsvayH7iN2Sb0zNWBUrkbaPmx2Q=;
 b=c5lLDJWD0GJSU2ebuTOrC8gF43TH7fiM88x399RuMBxbGUyJmeVHfSpZrizM2ihBk64aPw72GfZ+yKGRBaCp1hDV3+DxIi6ewZnFUGPSNpMzrsS/ZRC54tHRizqFgZoOgwR+buhMgr/lKHfVrRQWTBdSG3VN027nIN+GQXYXnTQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024105821.tHl2XfaEN3wI3q3f3zuaCFnVBMhPUDIRwJFRkwMZI-s@z>

W1doeV0KVXBvbiBHUFUgcmVzZXQsIGtlcm5lbCBjbGVhbnMgdXAgYWxyZWFkeSBzdWJtaXR0ZWQg
am9icwp2aWEgZHJtX3NjaGVkX2NsZWFudXBfam9icy4KVGhpcyBzY2hlZHVsZXMgaWIncyB2aWEg
ZHJtX3NjaGVkX21haW4oKS0+cnVuX2pvYiwgbGVhZGluZyB0bwpyYWNlIGNvbmRpdGlvbiBvZiBy
aW5ncyBiZWluZyByZWFkeSBvciBub3QsIHNpbmNlIGR1cmluZyByZXNldApyaW5ncyBtYXkgYmUg
c3VzcGVuZGVkLgoKW0hvd10KbWFrZSBHUFUgcmVzZXQncyBhbWRncHVfZGV2aWNlX2lwX3Jlc3Vt
ZV9waGFzZTIoKSAmCmFtZGdwdV9pYl9zY2hlZHVsZSgpIGluIGFtZGdwdV9qb2JfcnVuKCkgbXV0
dWFsbHkgZXhjbHVzaXZlLgoKU2lnbmVkLW9mZi1ieTogU2hpcmlzaCBTIDxzaGlyaXNoLnNAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgfCAx
ICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDMgKysrCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgICAgfCAyICsrCiAzIGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgK
aW5kZXggZjRkOTA0MS4uN2IwN2E0N2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
CkBAIC05NzMsNiArOTczLDcgQEAgc3RydWN0IGFtZGdwdV9kZXZpY2UgewogCWJvb2wgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW5fZ3B1X3Jlc2V0OwogCWVudW0gcHBfbXAxX3N0YXRlICAg
ICAgICAgICAgICAgbXAxX3N0YXRlOwogCXN0cnVjdCBtdXRleCAgbG9ja19yZXNldDsKKwlzdHJ1
Y3QgbXV0ZXggIGxvY2tfaWJfc2NoZWQ7CiAJc3RydWN0IGFtZGdwdV9kb29yYmVsbF9pbmRleCBk
b29yYmVsbF9pbmRleDsKIAogCWludCBhc2ljX3Jlc2V0X3JlczsKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA2NzZjYWQxLi42M2NhZDc0IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yNzU5LDYgKzI3NTks
NyBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CW11dGV4X2luaXQoJmFkZXYtPnZpcnQudmZfZXJyb3JzLmxvY2spOwogCWhhc2hfaW5pdChhZGV2
LT5tbl9oYXNoKTsKIAltdXRleF9pbml0KCZhZGV2LT5sb2NrX3Jlc2V0KTsKKwltdXRleF9pbml0
KCZhZGV2LT5sb2NrX2liX3NjaGVkKTsKIAltdXRleF9pbml0KCZhZGV2LT52aXJ0LmRwbV9tdXRl
eCk7CiAJbXV0ZXhfaW5pdCgmYWRldi0+cHNwLm11dGV4KTsKIApAQCAtMzc5NSw3ICszNzk2LDkg
QEAgc3RhdGljIGludCBhbWRncHVfZG9fYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5m
byAqaGl2ZSwKIAkJCQlpZiAocikKIAkJCQkJcmV0dXJuIHI7CiAKKwkJCQltdXRleF9sb2NrKCZ0
bXBfYWRldi0+bG9ja19pYl9zY2hlZCk7CiAJCQkJciA9IGFtZGdwdV9kZXZpY2VfaXBfcmVzdW1l
X3BoYXNlMih0bXBfYWRldik7CisJCQkJbXV0ZXhfdW5sb2NrKCZ0bXBfYWRldi0+bG9ja19pYl9z
Y2hlZCk7CiAJCQkJaWYgKHIpCiAJCQkJCWdvdG8gb3V0OwogCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfam9iLmMKaW5kZXggZTFiYWQ5OS4uY2Q2MDgyZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwpAQCAtMjMzLDggKzIzMywxMCBAQCBzdGF0aWMgc3Ry
dWN0IGRtYV9mZW5jZSAqYW1kZ3B1X2pvYl9ydW4oc3RydWN0IGRybV9zY2hlZF9qb2IgKnNjaGVk
X2pvYikKIAlpZiAoZmluaXNoZWQtPmVycm9yIDwgMCkgewogCQlEUk1fSU5GTygiU2tpcCBzY2hl
ZHVsaW5nIElCcyFcbiIpOwogCX0gZWxzZSB7CisJCW11dGV4X2xvY2soJnJpbmctPmFkZXYtPmxv
Y2tfaWJfc2NoZWQpOwogCQlyID0gYW1kZ3B1X2liX3NjaGVkdWxlKHJpbmcsIGpvYi0+bnVtX2li
cywgam9iLT5pYnMsIGpvYiwKIAkJCQkgICAgICAgJmZlbmNlKTsKKwkJbXV0ZXhfdW5sb2NrKCZy
aW5nLT5hZGV2LT5sb2NrX2liX3NjaGVkKTsKIAkJaWYgKHIpCiAJCQlEUk1fRVJST1IoIkVycm9y
IHNjaGVkdWxpbmcgSUJzICglZClcbiIsIHIpOwogCX0KLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
