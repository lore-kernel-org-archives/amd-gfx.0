Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD9C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 06:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC72A20674
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 06:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC72A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AFB6E7B0;
	Thu, 21 Nov 2019 06:18:45 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730088.outbound.protection.outlook.com [40.107.73.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6BF6E7B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 06:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTWXf16t+rSUAM00AtdFMz67YEu+mqwCQ89YzVBlYqZ4+6Np7NOTpeUFmNAigV+NURlK8FcBLW0IYczdzrMfASkoNeHm+N/oj8Yh+CoqlMthf5EI4tjxlNxtlum3Ob5tI+eSaXqMK4t4zbklWGg37V96Pfu6zUXBujxDf+VVbdop7JkpNQ/8dTEvw5GwToGFqoY94gJmGXoRexratZEZ3e2f8HuhAYxYh/Uu9tsJIQXYJFx9canSrSyU4H38RDAzd51wEo7HJpnxZx0mArPZeW4LQa7kUNoPxi4I/ytOWmNbQbReWR88o/4LnECbrqpYoD1wzdSPD3qWtRBHLbedow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N6NX5XjVgV+AugctaApLoSkGItZr8O2G9J0nGx/2Vw=;
 b=ncO+Xoia2ib0085kQ5fdvCxsFgJZcZ1YeiFc3AvqQ+VCN4YHvqMha7dg4GVn5pvqgmNdc9qE2nqav/Kn+bRALlBm5IJ55ZCsLxRv9cHvNBqcNZgUy5OWAdPymtSCDD9hbh06bOEBMDWabuh1qMQWRImtC2TkgsvPAL9y6okek+oSEVuMmVcUrMFLJhGqNaDossaZzesHujkHtY/d8PKW57oVbByYCTuLS3k4g7YKJ9L525EJbc8NdzgeThXIE2gAJdHZ+ZoA7l+ZmAEncCrQg2ewvHO/q4mbncorBoWmtLyn4+Ek1NDrIRWj0U2LUqU79XvcQGXFvbuWsgwrv9TY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3675.namprd12.prod.outlook.com (10.255.76.80) by
 DM6PR12MB3835.namprd12.prod.outlook.com (10.255.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 06:18:40 +0000
Received: from DM6PR12MB3675.namprd12.prod.outlook.com
 ([fe80::843a:9b15:db63:1159]) by DM6PR12MB3675.namprd12.prod.outlook.com
 ([fe80::843a:9b15:db63:1159%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 06:18:40 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Cui, Flora"
 <Flora.Cui@amd.com>, "Zhao, Yong" <Yong.Zhao@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/amdgpu/sriov temporarily skip ras, dtm, hdcp
 for arcturus VF
Thread-Topic: [PATCH 1/2] drm/amd/amdgpu/sriov temporarily skip ras, dtm, hdcp
 for arcturus VF
Thread-Index: AQHVoDNO9+notBs7C0eWQJve871CBqeVJmDg
Date: Thu, 21 Nov 2019 06:18:40 +0000
Message-ID:
 <DM6PR12MB3675FC4EA5D5FECF84C88029BB4E0@DM6PR12MB3675.namprd12.prod.outlook.com>
References: <20191121061655.25904-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191121061655.25904-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be2b6fa4-54e0-4d4b-3055-08d76e4aa73c
x-ms-traffictypediagnostic: DM6PR12MB3835:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB38353D6AB4911D0B152C7C48BB4E0@DM6PR12MB3835.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(13464003)(189003)(199004)(110136005)(86362001)(7736002)(305945005)(7696005)(229853002)(76176011)(4326008)(52536014)(6636002)(316002)(53546011)(6506007)(26005)(74316002)(186003)(55016002)(6436002)(9686003)(6306002)(102836004)(6246003)(256004)(14444005)(5660300002)(99286004)(2906002)(3846002)(6116002)(71200400001)(446003)(11346002)(486006)(71190400001)(476003)(66066001)(966005)(478600001)(33656002)(76116006)(8936002)(81166006)(81156014)(66946007)(66446008)(64756008)(66556008)(66476007)(14454004)(25786009)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3835;
 H:DM6PR12MB3675.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HK+BgITdM7qguw4jvBXQ2IMPNz2F4FxEdG+ETmvILrc36G2XtU/vnjkJG36RMN+enAF1mR14NR2ie2zLIHvQFjZ4GV9MAA+U7qQWr1LugOUli3aGKIsWcMu6V4lz/0U8plbs3eWp7Nj4wwRd0XSWhstOLIyNP3ABcHChpDJ/w1eC7nz+vt5H3NfUonamSO6+TAfUfzuNDZqEXYxpNMBgq30/LfZc74SkWYIT1IxnyTFtSTmhD7IM3XGS6BqI5E5kfBh091AKjJ2dv3Qy93QJhYlgApukCMUrA7QNpucGaAXc4Gq4Msw9JUNtPT+kwXIlVneX8RIeWPHTuGvrkYsW3EBCSpEpeAottZUsH/X53l0PdLDTznc2BStNIUFITIVNEhpuIW8fpNskRcle/1mzdRAp9dGKuaW7lKGkUCYgPDZEJNau4NImH0UpeWnqUwJFTiE3ebGNe4B2H4z3Cys4qNlvXVKdVnjUeV6OtsB/LN0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2b6fa4-54e0-4d4b-3055-08d76e4aa73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 06:18:40.7180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwjFjgp6DrreBF5oyG1gUcj8xweMmJrnFfzWXFL0tLEb2TA+MjdzwKfkqb5uscwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N6NX5XjVgV+AugctaApLoSkGItZr8O2G9J0nGx/2Vw=;
 b=w1IF9lzi93x+G9wzKsVWhAjO52MGPuG5iY0rrGRPh6XUdiKfNWOQffhkPlgyxjvwNdIrhja9+XwYl4Y4QFQ2RNWH6hVrSclv9suVngYqIlw2VyZaOASi7x5iTWmTF5bJAeXla++dhWnEPp6UTFCKlxFCXhLjXA/6sGo+mN3L20Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121061840.orq3V6JjFcszW0nIVr4k8hSnz4Xq8aikTxGbCwwO_xI@z>

SGksIFRlYW0sDQoNCldvdWxkIHlvdSBwbGVhc2UgaGVscCB0byB0YWtlIGEgbG9vayB0aGlzIHBh
dGNoPw0KDQpCUg0KSmFjaw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IEphY2sgWmhhbmcNClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyMSwgMjAxOSAyOjE3IFBNDQpU
bzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSmFjayAoSmlhbikg
PEphY2suWmhhbmcxQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vYW1kL2FtZGdw
dS9zcmlvdiB0ZW1wb3JhcmlseSBza2lwIHJhcywgZHRtLCBoZGNwIGZvciBhcmN0dXJ1cyBWRg0K
DQpUZW1wb3JhcmlseSBza2lwIHJhcyxkdG0saGRjcCBpbml0aWFsaXplIGFuZCB0ZXJtaW5hdGUg
Zm9yIGFyY3R1cnVzIFZGIEN1cnJlbnRseSB0aGUgdGhyZWUgZmVhdHVyZXMgaGF2ZW4ndCBiZWVu
IGVuYWJsZWQgYXQgU1JJT1YsIGl0IHdvdWxkIHRyaWdnZXIgZ3Vlc3QgZHJpdmVyIGxvYWQgZmFp
bCB3aXRoIHRoZSBiYXJlLW1ldGFsIHBhdGggb2YgdGhlIHRocmVlIGZlYXR1cmVzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBKYWNrIFpoYW5nIDxKYWNrLlpoYW5nMUBhbWQuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMzYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KaW5kZXggMmE4YTA4YS4uYzNhNDJk
MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQpAQCAtNzU2LDYg
Kzc1NiwxMiBAQCBpbnQgcHNwX3Jhc19lbmFibGVfZmVhdHVyZXMoc3RydWN0IHBzcF9jb250ZXh0
ICpwc3AsDQogDQogc3RhdGljIGludCBwc3BfcmFzX3Rlcm1pbmF0ZShzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkgIHsNCisJLyoNCisJICogVE9ETzogYnlwYXNzIHRoZSB0ZXJtaW5hdGUgaW4gc3Jp
b3YgZm9yIG5vdw0KKwkgKi8NCisJaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQ0KKwkJ
cmV0dXJuIDA7DQorDQogCWludCByZXQ7DQogDQogCWlmICghcHNwLT5yYXMucmFzX2luaXRpYWxp
emVkKQ0KQEAgLTc3Nyw2ICs3ODMsMTIgQEAgc3RhdGljIGludCBwc3BfcmFzX3Rlcm1pbmF0ZShz
dHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkNCiANCiBzdGF0aWMgaW50IHBzcF9yYXNfaW5pdGlhbGl6
ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgIHsNCisJLyoNCisJICogVE9ETzogYnlwYXNzIHRo
ZSBpbml0aWFsaXplIGluIHNyaW92IGZvciBub3cNCisJICovDQorCWlmIChhbWRncHVfc3Jpb3Zf
dmYocHNwLT5hZGV2KSkNCisJCXJldHVybiAwOw0KKw0KIAlpbnQgcmV0Ow0KIA0KIAlpZiAoIXBz
cC0+YWRldi0+cHNwLnRhX3Jhc191Y29kZV9zaXplIHx8IEBAIC04NzIsNiArODg0LDEyIEBAIHN0
YXRpYyBpbnQgcHNwX2hkY3BfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgIH0gIHN0YXRp
YyBpbnQgcHNwX2hkY3BfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgIHsNCisJ
LyoNCisJICogVE9ETzogYnlwYXNzIHRoZSBpbml0aWFsaXplIGluIHNyaW92IGZvciBub3cNCisJ
ICovDQorCWlmIChhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkNCisJCXJldHVybiAwOw0KKw0K
IAlpbnQgcmV0Ow0KIA0KIAlpZiAoIXBzcC0+YWRldi0+cHNwLnRhX2hkY3BfdWNvZGVfc2l6ZSB8
fCBAQCAtOTYwLDYgKzk3OCwxMiBAQCBpbnQgcHNwX2hkY3BfaW52b2tlKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpDQogDQogc3RhdGljIGludCBwc3BfaGRjcF90
ZXJtaW5hdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApICB7DQorCS8qDQorCSAqIFRPRE86IGJ5
cGFzcyB0aGUgdGVybWluYXRlIGluIHNyaW92IGZvciBub3cNCisJICovDQorCWlmIChhbWRncHVf
c3Jpb3ZfdmYocHNwLT5hZGV2KSkNCisJCXJldHVybiAwOw0KKw0KIAlpbnQgcmV0Ow0KIA0KIAlp
ZiAoIXBzcC0+aGRjcF9jb250ZXh0LmhkY3BfaW5pdGlhbGl6ZWQpDQpAQCAtMTA1MSw2ICsxMDc1
LDEyIEBAIHN0YXRpYyBpbnQgcHNwX2R0bV9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQ0K
IA0KIHN0YXRpYyBpbnQgcHNwX2R0bV9pbml0aWFsaXplKHN0cnVjdCBwc3BfY29udGV4dCAqcHNw
KSAgew0KKwkvKg0KKwkgKiBUT0RPOiBieXBhc3MgdGhlIGluaXRpYWxpemUgaW4gc3Jpb3YgZm9y
IG5vdw0KKwkgKi8NCisJaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQ0KKwkJcmV0dXJu
IDA7DQorDQogCWludCByZXQ7DQogDQogCWlmICghcHNwLT5hZGV2LT5wc3AudGFfZHRtX3Vjb2Rl
X3NpemUgfHwgQEAgLTExMDksNiArMTEzOSwxMiBAQCBpbnQgcHNwX2R0bV9pbnZva2Uoc3RydWN0
IHBzcF9jb250ZXh0ICpwc3AsIHVpbnQzMl90IHRhX2NtZF9pZCkNCiANCiBzdGF0aWMgaW50IHBz
cF9kdG1fdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKSAgew0KKwkvKg0KKwkgKiBU
T0RPOiBieXBhc3MgdGhlIHRlcm1pbmF0ZSBpbiBzcmlvdiBmb3Igbm93DQorCSAqLw0KKwlpZiAo
YW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikpDQorCQlyZXR1cm4gMDsNCisNCiAJaW50IHJldDsN
CiANCiAJaWYgKCFwc3AtPmR0bV9jb250ZXh0LmR0bV9pbml0aWFsaXplZCkNCi0tDQoyLjcuNA0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdm
eCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
