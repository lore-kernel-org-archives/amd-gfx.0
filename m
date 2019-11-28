Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2F1C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256B92051A
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256B92051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADCA6E5EA;
	Thu, 28 Nov 2019 02:21:24 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800054.outbound.protection.outlook.com [40.107.80.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB4C6E5EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 02:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqScdPweDWR00OF/HF7R9IlD700WVT46CwNW+GE8rmtSsndJ2VSZ+6xXxtRNasaJQrtvYwcOvJtmhaJIHxjRlTEsqIdXUEP73bnu3um+UXZL3slTU3aHVv2LAsQUWAfWVQYdhtagKzqncuNGLlqvQGkU6qmNtwnBm9TCCrU7R0tWPXLWpxd2gup0qYUDqiDqNlbhqe0+2XhiEMJAZZAsHdurhOxTc21dchCKy1ZljST/XPzU7mldgRonyLiL/eRg7UxOImE4Og0G+6NgoR7YkVKMYQSBpomm+6hNvU+z0bTZkp6xVubuu40V5DBsXRQ+4tvmkvYOjuSGrHZy05rrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whp3NdyRGRdh+O5a2KtYeD3iVrp1Ee0kgTuo/eqHb/M=;
 b=GhE+ee4daoD47NJoWVT4hhi29MnP3vnI+ionEvrpT90bOi70qm4y6nbmHRI1eA4yFvWAlO8XrBCIBjkFqLfY0z4r9Wq1YgMi/tjKLoyNBnc0uMalGO07UAQov9YnWzxuAaGd5oxR+fPFHWBd7bD8+IgiFELzJoJfFEDLEXAc6EbQV8wKmgumB464s8QVmBf+xwI8o4b2YSGz7GFw2zE8WouHfNbAwRw1+RKGYANGVGv2342A7j/YxnNDAc0w9Ht+JKAArSybFAHsWKsnLKOTNYl0hf23dWwlMYbqOU/JQ9kjuVMdCiqQGg3UcdcbMOxPqY6VTdaby/Sj+d6nzrXdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB4256.namprd12.prod.outlook.com (52.135.48.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 02:21:21 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 02:21:21 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/5] drm/amdgpu: skip rlc ucode loading for SRIOV gfx10
Thread-Topic: [PATCH 2/5] drm/amdgpu: skip rlc ucode loading for SRIOV gfx10
Thread-Index: AQHVpE+3oruwqDWHKUWl3Ftq8j8VI6ef3GWQ
Date: Thu, 28 Nov 2019 02:21:21 +0000
Message-ID:
 <MN2PR12MB3933CA4DA1FA95255FB3A37884470@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-2-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1574769024-30611-2-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28104f0a-818f-43dc-4049-08d773a9a8df
x-ms-traffictypediagnostic: MN2PR12MB4256:
x-microsoft-antispam-prvs: <MN2PR12MB4256714273ED966DD7FD6F6484470@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(13464003)(5640700003)(6506007)(11346002)(229853002)(6436002)(66066001)(53546011)(9686003)(5660300002)(55016002)(6246003)(99286004)(446003)(316002)(86362001)(26005)(52536014)(2501003)(186003)(14454004)(33656002)(2351001)(2906002)(256004)(76116006)(3846002)(6116002)(478600001)(71200400001)(71190400001)(25786009)(66946007)(6916009)(64756008)(66476007)(66556008)(66446008)(81166006)(8936002)(81156014)(8676002)(14444005)(102836004)(74316002)(7696005)(76176011)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4256;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IX9k+UT8dQme79DiIsyh/iRXLuM7PQwOgJnYhYJmGEFn+xu/RL8drS8DH5oJOS4xLexYg7+6aZnfsiq+m8a688/5YvQbANNWAVBpt6lEhv2orHrVTkU5fZEaOiaaY9vhK9lNRbJpMLwXYY8w/6IF1s0avQtpBtAd8cH1RQkrUgmicsdnOdg7XktSe1gf/5u6SmNixxATVv/7zKkNuHaImDghtaN7SMjP3il+GSg7H9gf6qx6ByLyCl5M3r9q+ZhwB3DfERHyNEjVq7skVNMWKLLgFgYfPM32bhtG+slkDp9yE4WnmvtST12cuLtAVRW4jq2aap95pzjY2JTxjPqhhcSuMPoPuZfsse8su2KrDbMBITAI5LXVRH1DO4fvmHku9l5bwQqtHfogYujkPFjDHQ/nfexLGNSmu6sAPDSt/pGIeSMAf8DQtnjOpXcfBeBh
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28104f0a-818f-43dc-4049-08d773a9a8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 02:21:21.4406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmkCdnqVKSbwX6iO5BXVVjhOWjPecGpuLfLyoqtohcF7l+T8h0GRbqkVNwiTRE2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whp3NdyRGRdh+O5a2KtYeD3iVrp1Ee0kgTuo/eqHb/M=;
 b=4cX/kfQZrzu1LF8tdsuY0+Et9DPJpIMKwqUxI2OfSbKjv1s3I1cdDsx1ioom091zfEk+5aiuBIxwFhgw1xX0KGktnm4QJTHwP6svr8m/OJ9QhkILcdsw/7fj4SVHQTtSL/uuHJEHjRpD/YdMIrkQptZ5hxtOOBbu9i04ZSN5Yfk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128022121.pHB3jr0tpBCRc0-8p17-Avc3Y9sX6EQ9BC1SdwvamH4@z>

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk1vbmsgTGl1fEdQVSBWaXJ0
dWFsaXphdGlvbiBUZWFtIHxBTUQKCgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQpGcm9tOiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4gClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI2LCAy
MDE5IDc6NTAgUE0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBMaXUsIE1v
bmsgPE1vbmsuTGl1QGFtZC5jb20+ClN1YmplY3Q6IFtQQVRDSCAyLzVdIGRybS9hbWRncHU6IHNr
aXAgcmxjIHVjb2RlIGxvYWRpbmcgZm9yIFNSSU9WIGdmeDEwCgpTaWduZWQtb2ZmLWJ5OiBNb25r
IExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYyB8IDgwICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IDg3OWMwYTEuLmE1NmNiYTkgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC02OTEsNTkgKzY5MSw2MSBAQCBzdGF0
aWMgaW50IGdmeF92MTBfMF9pbml0X21pY3JvY29kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAlhZGV2LT5nZnguY2VfZndfdmVyc2lvbiA9IGxlMzJfdG9fY3B1KGNwX2hkci0+aGVhZGVy
LnVjb2RlX3ZlcnNpb24pOwogCWFkZXYtPmdmeC5jZV9mZWF0dXJlX3ZlcnNpb24gPSBsZTMyX3Rv
X2NwdShjcF9oZHItPnVjb2RlX2ZlYXR1cmVfdmVyc2lvbik7CiAKLQlzbnByaW50Zihmd19uYW1l
LCBzaXplb2YoZndfbmFtZSksICJhbWRncHUvJXNfcmxjLmJpbiIsIGNoaXBfbmFtZSk7Ci0JZXJy
ID0gcmVxdWVzdF9maXJtd2FyZSgmYWRldi0+Z2Z4LnJsY19mdywgZndfbmFtZSwgYWRldi0+ZGV2
KTsKLQlpZiAoZXJyKQotCQlnb3RvIG91dDsKLQllcnIgPSBhbWRncHVfdWNvZGVfdmFsaWRhdGUo
YWRldi0+Z2Z4LnJsY19mdyk7Ci0JcmxjX2hkciA9IChjb25zdCBzdHJ1Y3QgcmxjX2Zpcm13YXJl
X2hlYWRlcl92Ml8wICopYWRldi0+Z2Z4LnJsY19mdy0+ZGF0YTsKLQl2ZXJzaW9uX21ham9yID0g
bGUxNl90b19jcHUocmxjX2hkci0+aGVhZGVyLmhlYWRlcl92ZXJzaW9uX21ham9yKTsKLQl2ZXJz
aW9uX21pbm9yID0gbGUxNl90b19jcHUocmxjX2hkci0+aGVhZGVyLmhlYWRlcl92ZXJzaW9uX21p
bm9yKTsKLQlpZiAodmVyc2lvbl9tYWpvciA9PSAyICYmIHZlcnNpb25fbWlub3IgPT0gMSkKLQkJ
YWRldi0+Z2Z4LnJsYy5pc19ybGNfdjJfMSA9IHRydWU7Ci0KLQlhZGV2LT5nZngucmxjX2Z3X3Zl
cnNpb24gPSBsZTMyX3RvX2NwdShybGNfaGRyLT5oZWFkZXIudWNvZGVfdmVyc2lvbik7Ci0JYWRl
di0+Z2Z4LnJsY19mZWF0dXJlX3ZlcnNpb24gPSBsZTMyX3RvX2NwdShybGNfaGRyLT51Y29kZV9m
ZWF0dXJlX3ZlcnNpb24pOwotCWFkZXYtPmdmeC5ybGMuc2F2ZV9hbmRfcmVzdG9yZV9vZmZzZXQg
PQorCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CisJCXNucHJpbnRmKGZ3X25hbWUsIHNp
emVvZihmd19uYW1lKSwgImFtZGdwdS8lc19ybGMuYmluIiwgY2hpcF9uYW1lKTsKKwkJZXJyID0g
cmVxdWVzdF9maXJtd2FyZSgmYWRldi0+Z2Z4LnJsY19mdywgZndfbmFtZSwgYWRldi0+ZGV2KTsK
KwkJaWYgKGVycikKKwkJCWdvdG8gb3V0OworCQllcnIgPSBhbWRncHVfdWNvZGVfdmFsaWRhdGUo
YWRldi0+Z2Z4LnJsY19mdyk7CisJCXJsY19oZHIgPSAoY29uc3Qgc3RydWN0IHJsY19maXJtd2Fy
ZV9oZWFkZXJfdjJfMCAqKWFkZXYtPmdmeC5ybGNfZnctPmRhdGE7CisJCXZlcnNpb25fbWFqb3Ig
PSBsZTE2X3RvX2NwdShybGNfaGRyLT5oZWFkZXIuaGVhZGVyX3ZlcnNpb25fbWFqb3IpOworCQl2
ZXJzaW9uX21pbm9yID0gbGUxNl90b19jcHUocmxjX2hkci0+aGVhZGVyLmhlYWRlcl92ZXJzaW9u
X21pbm9yKTsKKwkJaWYgKHZlcnNpb25fbWFqb3IgPT0gMiAmJiB2ZXJzaW9uX21pbm9yID09IDEp
CisJCQlhZGV2LT5nZngucmxjLmlzX3JsY192Ml8xID0gdHJ1ZTsKKworCQlhZGV2LT5nZngucmxj
X2Z3X3ZlcnNpb24gPSBsZTMyX3RvX2NwdShybGNfaGRyLT5oZWFkZXIudWNvZGVfdmVyc2lvbik7
CisJCWFkZXYtPmdmeC5ybGNfZmVhdHVyZV92ZXJzaW9uID0gbGUzMl90b19jcHUocmxjX2hkci0+
dWNvZGVfZmVhdHVyZV92ZXJzaW9uKTsKKwkJYWRldi0+Z2Z4LnJsYy5zYXZlX2FuZF9yZXN0b3Jl
X29mZnNldCA9CiAJCQlsZTMyX3RvX2NwdShybGNfaGRyLT5zYXZlX2FuZF9yZXN0b3JlX29mZnNl
dCk7Ci0JYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9kZXNjcmlwdG9yX29mZnNldCA9CisJCWFk
ZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfZGVzY3JpcHRvcl9vZmZzZXQgPQogCQkJbGUzMl90b19j
cHUocmxjX2hkci0+Y2xlYXJfc3RhdGVfZGVzY3JpcHRvcl9vZmZzZXQpOwotCWFkZXYtPmdmeC5y
bGMuYXZhaWxfc2NyYXRjaF9yYW1fbG9jYXRpb25zID0KKwkJYWRldi0+Z2Z4LnJsYy5hdmFpbF9z
Y3JhdGNoX3JhbV9sb2NhdGlvbnMgPQogCQkJbGUzMl90b19jcHUocmxjX2hkci0+YXZhaWxfc2Ny
YXRjaF9yYW1fbG9jYXRpb25zKTsKLQlhZGV2LT5nZngucmxjLnJlZ19yZXN0b3JlX2xpc3Rfc2l6
ZSA9CisJCWFkZXYtPmdmeC5ybGMucmVnX3Jlc3RvcmVfbGlzdF9zaXplID0KIAkJCWxlMzJfdG9f
Y3B1KHJsY19oZHItPnJlZ19yZXN0b3JlX2xpc3Rfc2l6ZSk7Ci0JYWRldi0+Z2Z4LnJsYy5yZWdf
bGlzdF9mb3JtYXRfc3RhcnQgPQorCQlhZGV2LT5nZngucmxjLnJlZ19saXN0X2Zvcm1hdF9zdGFy
dCA9CiAJCQlsZTMyX3RvX2NwdShybGNfaGRyLT5yZWdfbGlzdF9mb3JtYXRfc3RhcnQpOwotCWFk
ZXYtPmdmeC5ybGMucmVnX2xpc3RfZm9ybWF0X3NlcGFyYXRlX3N0YXJ0ID0KKwkJYWRldi0+Z2Z4
LnJsYy5yZWdfbGlzdF9mb3JtYXRfc2VwYXJhdGVfc3RhcnQgPQogCQkJbGUzMl90b19jcHUocmxj
X2hkci0+cmVnX2xpc3RfZm9ybWF0X3NlcGFyYXRlX3N0YXJ0KTsKLQlhZGV2LT5nZngucmxjLnN0
YXJ0aW5nX29mZnNldHNfc3RhcnQgPQorCQlhZGV2LT5nZngucmxjLnN0YXJ0aW5nX29mZnNldHNf
c3RhcnQgPQogCQkJbGUzMl90b19jcHUocmxjX2hkci0+c3RhcnRpbmdfb2Zmc2V0c19zdGFydCk7
Ci0JYWRldi0+Z2Z4LnJsYy5yZWdfbGlzdF9mb3JtYXRfc2l6ZV9ieXRlcyA9CisJCWFkZXYtPmdm
eC5ybGMucmVnX2xpc3RfZm9ybWF0X3NpemVfYnl0ZXMgPQogCQkJbGUzMl90b19jcHUocmxjX2hk
ci0+cmVnX2xpc3RfZm9ybWF0X3NpemVfYnl0ZXMpOwotCWFkZXYtPmdmeC5ybGMucmVnX2xpc3Rf
c2l6ZV9ieXRlcyA9CisJCWFkZXYtPmdmeC5ybGMucmVnX2xpc3Rfc2l6ZV9ieXRlcyA9CiAJCQls
ZTMyX3RvX2NwdShybGNfaGRyLT5yZWdfbGlzdF9zaXplX2J5dGVzKTsKLQlhZGV2LT5nZngucmxj
LnJlZ2lzdGVyX2xpc3RfZm9ybWF0ID0KKwkJYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9saXN0X2Zv
cm1hdCA9CiAJCQlrbWFsbG9jKGFkZXYtPmdmeC5ybGMucmVnX2xpc3RfZm9ybWF0X3NpemVfYnl0
ZXMgKwotCQkJCWFkZXYtPmdmeC5ybGMucmVnX2xpc3Rfc2l6ZV9ieXRlcywgR0ZQX0tFUk5FTCk7
Ci0JaWYgKCFhZGV2LT5nZngucmxjLnJlZ2lzdGVyX2xpc3RfZm9ybWF0KSB7Ci0JCWVyciA9IC1F
Tk9NRU07Ci0JCWdvdG8gb3V0OwotCX0KKwkJCQkJYWRldi0+Z2Z4LnJsYy5yZWdfbGlzdF9zaXpl
X2J5dGVzLCBHRlBfS0VSTkVMKTsKKwkJaWYgKCFhZGV2LT5nZngucmxjLnJlZ2lzdGVyX2xpc3Rf
Zm9ybWF0KSB7CisJCQllcnIgPSAtRU5PTUVNOworCQkJZ290byBvdXQ7CisJCX0KIAotCXRtcCA9
ICh1bnNpZ25lZCBpbnQgKikoKHVpbnRwdHJfdClybGNfaGRyICsKLQkJCWxlMzJfdG9fY3B1KHJs
Y19oZHItPnJlZ19saXN0X2Zvcm1hdF9hcnJheV9vZmZzZXRfYnl0ZXMpKTsKLQlmb3IgKGkgPSAw
IDsgaSA8IChybGNfaGRyLT5yZWdfbGlzdF9mb3JtYXRfc2l6ZV9ieXRlcyA+PiAyKTsgaSsrKQot
CQlhZGV2LT5nZngucmxjLnJlZ2lzdGVyX2xpc3RfZm9ybWF0W2ldID0JbGUzMl90b19jcHUodG1w
W2ldKTsKKwkJdG1wID0gKHVuc2lnbmVkIGludCAqKSgodWludHB0cl90KXJsY19oZHIgKworCQkJ
CQkJCSAgIGxlMzJfdG9fY3B1KHJsY19oZHItPnJlZ19saXN0X2Zvcm1hdF9hcnJheV9vZmZzZXRf
Ynl0ZXMpKTsKKwkJZm9yIChpID0gMCA7IGkgPCAocmxjX2hkci0+cmVnX2xpc3RfZm9ybWF0X3Np
emVfYnl0ZXMgPj4gMik7IGkrKykKKwkJCWFkZXYtPmdmeC5ybGMucmVnaXN0ZXJfbGlzdF9mb3Jt
YXRbaV0gPQlsZTMyX3RvX2NwdSh0bXBbaV0pOwogCi0JYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9y
ZXN0b3JlID0gYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9saXN0X2Zvcm1hdCArIGk7CisJCWFkZXYt
PmdmeC5ybGMucmVnaXN0ZXJfcmVzdG9yZSA9IGFkZXYtPmdmeC5ybGMucmVnaXN0ZXJfbGlzdF9m
b3JtYXQgKyBpOwogCi0JdG1wID0gKHVuc2lnbmVkIGludCAqKSgodWludHB0cl90KXJsY19oZHIg
KwotCQkJbGUzMl90b19jcHUocmxjX2hkci0+cmVnX2xpc3RfYXJyYXlfb2Zmc2V0X2J5dGVzKSk7
Ci0JZm9yIChpID0gMCA7IGkgPCAocmxjX2hkci0+cmVnX2xpc3Rfc2l6ZV9ieXRlcyA+PiAyKTsg
aSsrKQotCQlhZGV2LT5nZngucmxjLnJlZ2lzdGVyX3Jlc3RvcmVbaV0gPSBsZTMyX3RvX2NwdSh0
bXBbaV0pOworCQl0bXAgPSAodW5zaWduZWQgaW50ICopKCh1aW50cHRyX3QpcmxjX2hkciArCisJ
CQkJCQkJICAgbGUzMl90b19jcHUocmxjX2hkci0+cmVnX2xpc3RfYXJyYXlfb2Zmc2V0X2J5dGVz
KSk7CisJCWZvciAoaSA9IDAgOyBpIDwgKHJsY19oZHItPnJlZ19saXN0X3NpemVfYnl0ZXMgPj4g
Mik7IGkrKykKKwkJCWFkZXYtPmdmeC5ybGMucmVnaXN0ZXJfcmVzdG9yZVtpXSA9IGxlMzJfdG9f
Y3B1KHRtcFtpXSk7CiAKLQlpZiAoYWRldi0+Z2Z4LnJsYy5pc19ybGNfdjJfMSkKLQkJZ2Z4X3Yx
MF8wX2luaXRfcmxjX2V4dF9taWNyb2NvZGUoYWRldik7CisJCWlmIChhZGV2LT5nZngucmxjLmlz
X3JsY192Ml8xKQorCQkJZ2Z4X3YxMF8wX2luaXRfcmxjX2V4dF9taWNyb2NvZGUoYWRldik7CisJ
fQogCiAJc25wcmludGYoZndfbmFtZSwgc2l6ZW9mKGZ3X25hbWUpLCAiYW1kZ3B1LyVzX21lYyVz
LmJpbiIsIGNoaXBfbmFtZSwgd2tzKTsKIAllcnIgPSByZXF1ZXN0X2Zpcm13YXJlKCZhZGV2LT5n
ZngubWVjX2Z3LCBmd19uYW1lLCBhZGV2LT5kZXYpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
