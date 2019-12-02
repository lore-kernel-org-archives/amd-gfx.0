Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A716C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254C020833
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254C020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75936E25A;
	Mon,  2 Dec 2019 16:44:58 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720041.outbound.protection.outlook.com [40.107.72.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0E76E25A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 16:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPxABY8x2sR5GKHs+SIJSjKKnTANphn/XOllGUrCX9oSKXneSfb4HpGN13Wr+NsQdQ3Zo5V2awZx17UK2Ch2A7pCPGf/3oKLiNP7XhZPEtltLlY3VbHniOSwGmxEV/lt2wzY2qWNRo/jL+J+TY/mGXHf+gSmy86YxQWQM3Ya5Kt1mV+YTfZxduIw1OuWNs3glUsMnbnij7EvepXe6jrjglmFNmjt53+bxLTaY1SoHl+Qsq3cEFRYSECTH9LtvTiA3oL1XMEq+spuxJZoL6iZGM9pjVGMha6hgzPBV8ioygMqcGHs6xM/86RrkgW3uZEuQoFaR7j9riNRYcEWpMlrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwxhp0UTnt6J6JJHPeb+m5Ao9A9eKOOyOVh6BtysQBk=;
 b=WEEyieh8nxotSA/hgBqVxALsWmjRngfb83mErzXVrUzxNXERriQShfZhtHtKEdjemfaWLvu/QTXecKu4KMsgEAOvGY8Jidh3w9IQPt4TshiScA0WecUMjz59CWz0OReavosfcEuvOSQzbXSQGTqFHMNN5tZILl8a40GAndKhNeF2BwGOpNNjNK+Z7KP8h8RAkgIQjxfY8VjNISHP302DxZBmiLrdhyQVngRSfyXwQf6RbdmiqjFKEpIfnJ7UphzCxGpwvmJRpFW8uzQS1WwJMF8vVK742BmTJoFN6KvoRjeBBVJewPKTnA+Es1xwuK+9epSAwDUsg5xAH2L/h7TJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1600.namprd12.prod.outlook.com (10.172.55.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 16:44:55 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 16:44:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: unload asd in psp hw de-init phase
Thread-Topic: [PATCH 2/3] drm/amdgpu: unload asd in psp hw de-init phase
Thread-Index: AQHVqNZLAAWd/UOB6k+TH7ZKbNTRZaenDcHg
Date: Mon, 2 Dec 2019 16:44:55 +0000
Message-ID: <MWHPR12MB135873A2ED3EA42829707A5CF7430@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191202060337.22435-1-Hawking.Zhang@amd.com>
 <20191202060337.22435-2-Hawking.Zhang@amd.com>
In-Reply-To: <20191202060337.22435-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9c9a231-89d1-49b8-8347-08d77746f601
x-ms-traffictypediagnostic: MWHPR12MB1600:|MWHPR12MB1600:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB16003320239763699D7F1E78F7430@MWHPR12MB1600.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(13464003)(199004)(189003)(316002)(3846002)(229853002)(66446008)(66556008)(64756008)(66476007)(66946007)(76116006)(53546011)(33656002)(74316002)(305945005)(7696005)(8676002)(81156014)(6636002)(2501003)(14444005)(256004)(71200400001)(86362001)(71190400001)(66066001)(6116002)(7736002)(2906002)(5660300002)(14454004)(6246003)(76176011)(8936002)(81166006)(52536014)(4326008)(6436002)(9686003)(478600001)(446003)(11346002)(25786009)(186003)(102836004)(99286004)(110136005)(26005)(55016002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1600;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYzKo3zCpGEQ+3woo1QA/hV9z9ycEfwg8xHi4Ecvsf0D1ij6Q0A6g6ihXb8D6RtF1PLeAAbOjQZnTC3t9gMbIUnlEO11T5KLtW9/dKxTsmEz38yLQw3YzQ+wUahQV+Hot/AWcNRJJdyc56psVjKX8lB2jkXB1iEw6l32i+v+dr/tu62zZdlbrG4CevKWGWoIfHv44pxmN7JGfOpQHUqJAs7cB64FPxFgl4yAabC6CSWe1W27Xwqty1LPWrbmIbrXA/aXsJDYMY4rsHrAbdaA2NFYd4ermb9BeLRSDxwM7dEXEgchbm6lEJ2rqHzTVNFsve/dL/FWohf0x3n6jZZaZPipkOzuyJyUC5bPTnCud+k+w4wxFCZJq31728QtZlRqWhHSSbpRsjjqb++7+0OwWUxjbmNzaN/+9vZjZGxneAhQ2plKfsPr+zq7FJdBf5gF
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c9a231-89d1-49b8-8347-08d77746f601
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 16:44:55.3635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paiI8hXUd9MRse0w09xugjnB1t2zxjLU9zEF6yg+onDBwGctQNufSlp6JQe5kwsH2EExZgRCbvIQXmBddiDXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwxhp0UTnt6J6JJHPeb+m5Ao9A9eKOOyOVh6BtysQBk=;
 b=ROqxdksk5VbR23ESpxSOMJADbJQ5vQ+t+9xsSRxlISmxyro6WP6Npvq+NnpkAmpY3tL+YajWFAWMnAAd8pLisTFkYyhgkPvuxvb9uyGSZ17MY3uAJmlX2SdtMQMRvD1r0mF2ucoAkK4fXqR8uWCSemoXJFRfXaESTEScyeuYXao=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEhhd2tpbmcgWmhhbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT4KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDIsIDIwMTkgMTowNCBB
TQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTWluLCBGcmFuayA8RnJhbmsu
TWluQGFtZC5jb20+Owo+IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIKPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4KPiBDYzogWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTdWJqZWN0OiBbUEFUQ0ggMi8z
XSBkcm0vYW1kZ3B1OiB1bmxvYWQgYXNkIGluIHBzcCBodyBkZS1pbml0IHBoYXNlCj4gCj4gaXNz
dWUgdW5sb2FkX3RhX2NtZCB0byB0T1MgdG8gdW5sb2FkIGFzZCBkcml2ZXIKPiAKPiBDaGFuZ2Ut
SWQ6IEk2OTdjZmMxNzc0MjA1ZWQ2Y2JlMjJlYjNjMTYxNDNiNjAzNTQzNTY0Cj4gU2lnbmVkLW9m
Zi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgoKClJldmlld2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgoKPiAtLS0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMzYKPiArKysrKysrKysrKysr
KysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gaW5kZXggYmRjOWU3YWU0ODky
Li4wZTg5MDcxNzllMDcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bz
cC5jCj4gQEAgLTM1Niw2ICszNTYsNDAgQEAgc3RhdGljIGludCBwc3BfYXNkX2xvYWQoc3RydWN0
IHBzcF9jb250ZXh0ICpwc3ApCj4gIAlyZXR1cm4gcmV0Owo+ICB9Cj4gCj4gK3N0YXRpYyB2b2lk
IHBzcF9wcmVwX2FzZF91bmxvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcAo+ICpj
bWQsCj4gKwkJCQkJdWludDMyX3QgYXNkX3Nlc3Npb25faWQpCj4gK3sKPiArCWNtZC0+Y21kX2lk
ID0gR0ZYX0NNRF9JRF9VTkxPQURfVEE7Cj4gKwljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Np
b25faWQgPSBhc2Rfc2Vzc2lvbl9pZDsgfQo+ICsKPiArc3RhdGljIGludCBwc3BfYXNkX3VubG9h
ZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgewo+ICsJaW50IHJldDsKPiArCXN0cnVjdCBwc3Bf
Z2Z4X2NtZF9yZXNwICpjbWQ7Cj4gKwo+ICsJaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYp
KQo+ICsJCXJldHVybiAwOwo+ICsKPiArCWlmICghcHNwLT5hc2RfY29udGV4dC5hc2RfaW5pdGlh
bGl6ZWQpCj4gKwkJcmV0dXJuIDA7Cj4gKwo+ICsJY21kID0ga3phbGxvYyhzaXplb2Yoc3RydWN0
IHBzcF9nZnhfY21kX3Jlc3ApLCBHRlBfS0VSTkVMKTsKPiArCWlmICghY21kKQo+ICsJCXJldHVy
biAtRU5PTUVNOwo+ICsKPiArCXBzcF9wcmVwX2FzZF91bmxvYWRfY21kX2J1ZihjbWQsIHBzcC0K
PiA+YXNkX2NvbnRleHQuc2Vzc2lvbl9pZCk7Cj4gKwo+ICsJcmV0ID0gcHNwX2NtZF9zdWJtaXRf
YnVmKHBzcCwgTlVMTCwgY21kLAo+ICsJCQkJIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwo+ICsJ
aWYgKCFyZXQpCj4gKwkJcHNwLT5hc2RfY29udGV4dC5hc2RfaW5pdGlhbGl6ZWQgPSBmYWxzZTsK
PiArCj4gKwlrZnJlZShjbWQpOwo+ICsKPiArCXJldHVybiByZXQ7Cj4gK30KPiArCj4gIHN0YXRp
YyB2b2lkIHBzcF9wcmVwX3JlZ19wcm9nX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3Ag
KmNtZCwKPiAgCQl1aW50MzJfdCBpZCwgdWludDMyX3QgdmFsdWUpCj4gIHsKPiBAQCAtMTU4Myw2
ICsxNjE3LDggQEAgc3RhdGljIGludCBwc3BfaHdfZmluaSh2b2lkICpoYW5kbGUpCj4gIAkJcHNw
X2hkY3BfdGVybWluYXRlKHBzcCk7Cj4gIAl9Cj4gCj4gKwlwc3BfYXNkX3VubG9hZChwc3ApOwo+
ICsKPiAgCXBzcF9yaW5nX2Rlc3Ryb3kocHNwLCBQU1BfUklOR19UWVBFX19LTSk7Cj4gCj4gIAlw
cHRyID0gYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikgPyAmdG1yX2J1ZiA6IE5VTEw7Cj4gLS0K
PiAyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
