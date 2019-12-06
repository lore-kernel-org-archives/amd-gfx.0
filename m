Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A899C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 10:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278F72173E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 10:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278F72173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C04146F9AF;
	Fri,  6 Dec 2019 10:25:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4526F9AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 10:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzIkZjfshqOInH+AVFLFNdstZ45R7FE7Q+XwFVK6nrxxEFwddRwi0bcRL3s9jgiO3NZOF2ue647mvUZwub3ymolsN77b36vVY/dS373auuXlFnE3pQFnEsh7RthuH7LixMYCDbKD/jcK0JUKGZkEAIkKGu5rOpmcEdfDIppAAvS52X6HAm6IX16+tdZIv5hOSf7ZsefvrfAUIgsOKDTacHTxG+XHi1Mub5F290ONvO17BUx3B2+yqil2Mdf210nsXYNecjsE7Nr0CSt4q/zxiSv12W7LMuTP1ay3N9zaUgT2RIayM+6AuoA/de0rkvD3uxk4wEwRlaIBMgosu39qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z93jNyq9lrFbOhYa3heJwC4TxlOZUp/+BBZOrXvsU5c=;
 b=LzwY5UBzr5CUPQOsqpEvEp2/NX5UimJM/PIo2HEfLcgYVwOQe4dj8EYeHyEE4d/wVhEkQbWk1XJzjLVPjtglYECv2nCEVIZgneI5Ek3SLeMqYYytTpR3Nuwnxmwrh0YRBDJiy8jF+wPV8GItJ8CZ+o4YNZ4SzKjce8ucSHDO8ZRmzKUwI8YKku2PygP+orP5gLIsjyHvJrm0dah1BFcSLXFQffIyiDW0HBUCzsn2mqYpw030Gmh0hA9AoYhQS1CKkv9vN7fdmpog3PieN+TP1Oq8JhgbIvH6WwmvAj9NGOwC/YHcMjYrBS8xuR7NeA91v708pkWtRAvu3lok5+lCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB2709.namprd12.prod.outlook.com (20.176.254.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 6 Dec 2019 10:25:09 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:25:09 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Ma, Le" <Le.Ma@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v3)
Thread-Topic: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v3)
Thread-Index: AQHVrB2ihOgPZLnKQUOQmWFDlbexmKes5oLA
Date: Fri, 6 Dec 2019 10:25:09 +0000
Message-ID: <BYAPR12MB2806EA9134A6531F52BFCC76F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20191206101204.5374-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191206101204.5374-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-06T10:25:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4ce840df-07a6-4cf6-918f-0000c85625b5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-06T10:25:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5061f464-905d-463b-9bf3-0000accbdf60
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad629a52-cc24-4173-e874-08d77a3691e7
x-ms-traffictypediagnostic: BYAPR12MB2709:|BYAPR12MB2709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2709C44D8DC3F1E6C8D264EEF15F0@BYAPR12MB2709.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(13464003)(66946007)(4326008)(64756008)(305945005)(66476007)(66446008)(33656002)(66556008)(14444005)(11346002)(52536014)(5660300002)(71190400001)(71200400001)(74316002)(99286004)(81156014)(86362001)(25786009)(6636002)(229853002)(81166006)(8676002)(110136005)(8936002)(316002)(102836004)(76176011)(478600001)(2906002)(26005)(53546011)(6506007)(186003)(55016002)(14454004)(76116006)(7696005)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2709;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/usez8Z2zy/qn/yi8nOrtkDlCTen3SpKgOSYOP39p4MkIl/4NhKGZuCyixOYOEYVRQ37LSt2Sps52Qtc1yDDqgLSst4MDQh/GBu3TN6VmGAL4A7nth4IbZcngQrh6hAT/pikxo2Xbx8QzAPPB46S5ScLjo6kLwhWHKLRpuATBQIXT3gBjkPP+2/qEkAj6XpWiWkxKc/RHNi1ifrI+tBKHVjcqYhQYDpPyosG2vHORRWr/OMHDTEX6diJNoSBz2wdneEv96lsrTw1hu6O9Ylp12o6OMZLmm3j6fOx7wPt+iC2joDQS24ewLaSgWVd6mHsSOUc0SZAbxn1mXpnXXbAOoEpcmhwS3Ybo0EvLjYVrRKMyKhs9Vf1heRaL2JoOXcaAyngbGTDJDYC9epjggfPp198Hc7Oxo3a/SSUrMZM9vpOPogNsor1gcLz02U2+Hqtl0rYm+pS4KcII9Qy5UbTHIOaUxltbbcyvTXzF0OVForjD69sJwhaULu+e/IV4gX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad629a52-cc24-4173-e874-08d77a3691e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:25:09.0362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmMahRhL7TRS0RUYfZNHWHMZuM/ggtNcAHi8LjAP/o97NxYZO5Ezh8LSKPWNw7UenNPoE3XLf43RIPqI7IeSYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2709
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z93jNyq9lrFbOhYa3heJwC4TxlOZUp/+BBZOrXvsU5c=;
 b=MpdYEqPu+4gYQfGyAlUa89vvM6+K+b7+t3Kw6DoTtQa+7wJ2V3sNkvaYxsGxxyaSchNg1PO4H/H+6U9kCSAv7GzuxIbMQWpS3ReC7ZElavf37EX0+jB/obDwEnB9vsYsb1VgZe0Sf/HG5SNsjt1yturhPt0UjPhvV3QJs60zQtY=
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQoKUmV2
aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPgoKUmVnYXJkcywKR3Vj
aHVuCgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQpGcm9tOiBIYXdraW5nIFpoYW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+IApTZW50OiBGcmlkYXksIERlY2VtYmVyIDYsIDIwMTkgNjoxMiBQ
TQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IE1hLCBMZSA8TGUuTWFAYW1kLmNv
bT47IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5D
aGVuQGFtZC5jb20+CkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpT
dWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCByZXN1bWUgZmFpbHVyZXMgZHVlIHRvIHBz
cCBmdyBsb2FkaW5nIHNlcXVlbmNlIGNoYW5nZSAodjMpCgp0aGlzIGZpeCB0aGUgcmVncmVzc2lv
biBjYXVzZWQgYnkgYXNkL3RhIGxvYWRpbmcgc2VxdWVuY2UgYWRqdXN0bWVudCByZWNlbnRseS4g
YXNkL3RhIGxvYWRpbmcgd2FzIG1vdmUgb3V0IGZyb20gaHdfc3RhcnQgYW5kIHNob3VsZCBhbHNv
IGJlIGFwcGxpZWQgdG8gcHNwX3Jlc3VtZS4Kb3RoZXJ3aXNlIHRob3NlIGZ3IGxvYWRpbmcgd2ls
bCBiZSBpZ25vcmVkIGluIHJlc3VtZSBwaGFzZS4KCnYyOiBhZGQgdGhlIG11dGV4IHVubG9jayBm
b3IgYXNkIGxvYWRpbmcgZmFpbHVyZSBjYXNlCnYzOiBtZXJnZSB0aGUgZXJyb3IgaGFuZGxpbmcg
dG8gZmFpbGVkIHRhZwoKQ2hhbmdlLUlkOiBJMjBkMzY1MWYzMjVlNzkzZTFlYTdlNzNkZjFjNzYy
MTllYWEwYjVhYgpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMzMg
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKaW5kZXggY2VlYTgzMTRk
ODhkLi4yZGZkYTU1OTBlNzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMKQEAgLTE3MDIsNiArMTcwMiwzOSBAQCBzdGF0aWMgaW50IHBzcF9yZXN1bWUodm9pZCAqaGFu
ZGxlKQogCWlmIChyZXQpCiAJCWdvdG8gZmFpbGVkOwogCisJcmV0ID0gcHNwX2FzZF9sb2FkKHBz
cCk7CisJaWYgKHJldCkgeworCQlEUk1fRVJST1IoIlBTUCBsb2FkIGFzZCBmYWlsZWQhXG4iKTsK
KwkJZ290byBmYWlsZWQ7CisJfQorCisJaWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9u
b2RlcyA+IDEpIHsKKwkJcmV0ID0gcHNwX3hnbWlfaW5pdGlhbGl6ZShwc3ApOworCQkvKiBXYXJu
aW5nIHRoZSBYR01JIHNlZXNpb24gaW5pdGlhbGl6ZSBmYWlsdXJlCisJCSAqIEluc3RlYWQgb2Yg
c3RvcCBkcml2ZXIgaW5pdGlhbGl6YXRpb24KKwkJICovCisJCWlmIChyZXQpCisJCQlkZXZfZXJy
KHBzcC0+YWRldi0+ZGV2LAorCQkJCSJYR01JOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBYR01JIHNl
c3Npb25cbiIpOworCX0KKworCWlmIChwc3AtPmFkZXYtPnBzcC50YV9mdykgeworCQlyZXQgPSBw
c3BfcmFzX2luaXRpYWxpemUocHNwKTsKKwkJaWYgKHJldCkKKwkJCWRldl9lcnIocHNwLT5hZGV2
LT5kZXYsCisJCQkJCSJSQVM6IEZhaWxlZCB0byBpbml0aWFsaXplIFJBU1xuIik7CisKKwkJcmV0
ID0gcHNwX2hkY3BfaW5pdGlhbGl6ZShwc3ApOworCQlpZiAocmV0KQorCQkJZGV2X2Vycihwc3At
PmFkZXYtPmRldiwKKwkJCQkiSERDUDogRmFpbGVkIHRvIGluaXRpYWxpemUgSERDUFxuIik7CisK
KwkJcmV0ID0gcHNwX2R0bV9pbml0aWFsaXplKHBzcCk7CisJCWlmIChyZXQpCisJCQlkZXZfZXJy
KHBzcC0+YWRldi0+ZGV2LAorCQkJCSJEVE06IEZhaWxlZCB0byBpbml0aWFsaXplIERUTVxuIik7
CisJfQorCiAJbXV0ZXhfdW5sb2NrKCZhZGV2LT5maXJtd2FyZS5tdXRleCk7CiAKIAlyZXR1cm4g
MDsKLS0KMi4xNy4xCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
