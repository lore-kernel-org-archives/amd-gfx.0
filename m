Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A7CC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2329420722
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2329420722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A856E25B;
	Mon,  2 Dec 2019 16:43:54 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760080.outbound.protection.outlook.com [40.107.76.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CE26E252
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 16:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvRh70TzHnJs9oo02LCoUMYYt6wxhlSFYD9n4A6fLHWiEoxBWmAvgeySW08aEafMnDM2r4SQMMuUpiuTzOv6yJ1ZP8s29kAEFB386fWmAeRgfS8bDiygNahWkrYgKF83ZJTpvt4TCURmmBEAc8miNZYUgZYr64deagDKSDk3Esiu3nLe3hIqh6i2LrrhQNei24W6DTWrB7DtHWKMuRsUXll5pgl3aca+W3duMgh289i+eCypzjotA8NXo4dHUJP15r8uN0mhfT++QQnetnlHPwVoTaEIaZu3Gqf/wewh0sYsddDkx97LIxwv+HtbsHpPKPYTKvRf0MffdWvfkz+Gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQYPiGpWUXIwt7xIlWu+saS0wwHVZ5S0eopD6c+BQ/o=;
 b=RnoHE1+9HojZO7bQ2c7gOBy5iz8S83P0M7eonxntD6vb+MrUOmkNJlk7NjNHyLoZnHMj678knB5TXtoRD4u20b1n7iR1vg6aXbLN1wm4Eo0hkivZ1D/OdJwkllNER+oggd38mel2qrlOy761JpP3Ee7/15n4moqjL/tuLuCTv66fedS+cjYNwSGDc1wuSPZeaIlCQUV58GqSXT2dVp5U4BwmLp2tA/6+Kctc2kvBX7UCmFwXDSI6Nd8KgJBp8TDt8azbXHmI5ipuQm9T3/aoTiK/Wj7jBSWcDwd3y6Q+mwchkgzgoed3tqfVjBJ8d8LUsNg6O8luLLXI6Jn1GInyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1600.namprd12.prod.outlook.com (10.172.55.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 16:43:50 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 16:43:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: drop asd shared memory
Thread-Topic: [PATCH 1/3] drm/amdgpu: drop asd shared memory
Thread-Index: AQHVqNZDbtkJ2OI2aE+2ODFXCHrJJ6enDV5A
Date: Mon, 2 Dec 2019 16:43:50 +0000
Message-ID: <MWHPR12MB13583586E501DB7FCF4E0783F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191202060337.22435-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191202060337.22435-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25ef8716-8475-496c-eef3-08d77746cf48
x-ms-traffictypediagnostic: MWHPR12MB1600:|MWHPR12MB1600:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB16004358DC1D0D889752EC94F7430@MWHPR12MB1600.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(13464003)(199004)(189003)(316002)(3846002)(229853002)(66446008)(66556008)(64756008)(66476007)(66946007)(76116006)(53546011)(33656002)(74316002)(305945005)(7696005)(8676002)(81156014)(6636002)(2501003)(256004)(71200400001)(86362001)(71190400001)(66066001)(6116002)(7736002)(2906002)(5660300002)(14454004)(6246003)(76176011)(8936002)(81166006)(52536014)(4326008)(6436002)(9686003)(478600001)(446003)(11346002)(25786009)(186003)(102836004)(99286004)(110136005)(26005)(55016002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1600;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xY1OFsy7WMMKruxMCfCljT5b1Xa7jbGymAIsZ+18N4tn7qf1673s0KcgxawZ7kxlkOQbHOEPqOZ6gagHmTk6+4R5dPVhE8scSRIAKjCqPBbJVkj7P/3exJ4OoiP2zahc/qISW9GCzr5vDX+UH68EM7EXgJNGq0GoPXTKJ6sWaEPcv01+0+xadRDRvMDC82YamCxDt7ssIRznzni5ovUlzRh3mJcRfoAvKahe/eHiV2umcFxa+QUpNQBerhdospSKZDfCAOo4cx8k5mHLTbFCGD411Wm4//b8tQuT4orXm9J5enc7jj4fNhhq4BArkIBCro0AkkRpn0chAF4ZAxiNXUX+TggwEvdTey6An+DU4KgLwyfMiI2DpGnCu0A6V6KLGei2u3mMuiBRHBRnnW2YZtSzhDvbUCXUkWy0KGCnGCCR3SIWBJCIjCtJZ4m38JLh
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ef8716-8475-496c-eef3-08d77746cf48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 16:43:50.3294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZWJ0wqM/xt3sPeQ69KYINbyOTOl/d0m+zm7yc9d52PwdzGEt1lQ2Fi0Zo7QWXX2IIf1CtKppaxS6ABPqNCGFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQYPiGpWUXIwt7xIlWu+saS0wwHVZ5S0eopD6c+BQ/o=;
 b=Q+3J4JiGESghakcViwXeLYEyHZTw+S91+QIac8m8taLceuRlu/Idemw+o8WVcwnq1lq/jOerHVySQcabs2b+9plqtSKKJoIMZALNCFkwC1uEcOcZ1iy0cYTS0YJ4noiIWyWKsmYb3oppAfrmu5f4CdLEX7UfZa7LPGVeJu2ac3A=
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
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTdWJqZWN0OiBbUEFUQ0ggMS8z
XSBkcm0vYW1kZ3B1OiBkcm9wIGFzZCBzaGFyZWQgbWVtb3J5Cj4gCj4gYXNkIHNoYXJlZCBtZW1v
cnkgaXMgbm90IG5lZWRlZCBzaW5jZSBkcml2ZXJzIGRvZXNuJ3QgaW52b2tlIGFueSBmdXJ0aGVy
Cj4gY21kIHRvIGFzZCBkaXJlY3RseSBhZnRlciB0aGUgYXNkIGxvYWRpbmcuIHRydXN0IGFwcGxp
Y2F0aW9uIGlzIHRoZSBvbmUgd2hvCj4gbmVlZHMgdG8gdGFsayB0byBhc2QgYWZ0ZXIgdGhlIGlu
aXRpYWxpemF0aW9uCj4gCgpEbyB3ZSBuZWVkIHRvIGtlZXAgdGhhdCBtZW1vcnkgYXJvdW5kIGZv
ciB0aGUgVEFzIG9yIGRvIHRoZXkgdXNlIHNvbWUgb3RoZXIgbWVtb3J5PwoKQWxleAoKPiBDaGFu
Z2UtSWQ6IEk3MjhhZmE0YzdlOGI2N2JjMDY2NzhiMTBlOTJhYzA2NGJhMTAxNzNlCj4gU2lnbmVk
LW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+IC0tLQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCA0NCArKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oIHwg
MTIgKysrKy0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDM4IGRlbGV0
aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+IGlu
ZGV4IGQ4ZWY3MDk4ZmZkZi4uYmRjOWU3YWU0ODkyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuYwo+IEBAIC0zMDksMzUgKzMwOSwxNyBAQCBzdGF0aWMgaW50IHBz
cF90bXJfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKPiAgCXJldHVybiByZXQ7Cj4gIH0K
PiAKPiAtc3RhdGljIHZvaWQgcHNwX3ByZXBfYXNkX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21k
X3Jlc3AgKmNtZCwKPiAtCQkJCSB1aW50NjRfdCBhc2RfbWMsIHVpbnQ2NF90IGFzZF9tY19zaGFy
ZWQsCj4gLQkJCQkgdWludDMyX3Qgc2l6ZSwgdWludDMyX3Qgc2hhcmVkX3NpemUpCj4gK3N0YXRp
YyB2b2lkIHBzcF9wcmVwX2FzZF9sb2FkX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3Ag
KmNtZCwKPiArCQkJCXVpbnQ2NF90IGFzZF9tYywgdWludDMyX3Qgc2l6ZSkKPiAgewo+ICAJY21k
LT5jbWRfaWQgPSBHRlhfQ01EX0lEX0xPQURfQVNEOwo+ICAJY21kLT5jbWQuY21kX2xvYWRfdGEu
YXBwX3BoeV9hZGRyX2xvID0KPiBsb3dlcl8zMl9iaXRzKGFzZF9tYyk7Cj4gIAljbWQtPmNtZC5j
bWRfbG9hZF90YS5hcHBfcGh5X2FkZHJfaGkgPQo+IHVwcGVyXzMyX2JpdHMoYXNkX21jKTsKPiAg
CWNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9sZW4gPSBzaXplOwo+IAo+IC0JY21kLT5jbWQuY21k
X2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9sbyA9Cj4gbG93ZXJfMzJfYml0cyhhc2RfbWNfc2hh
cmVkKTsKPiAtCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfcGh5X2FkZHJfaGkgPQo+IHVw
cGVyXzMyX2JpdHMoYXNkX21jX3NoYXJlZCk7Cj4gLQljbWQtPmNtZC5jbWRfbG9hZF90YS5jbWRf
YnVmX2xlbiA9IHNoYXJlZF9zaXplOwo+IC19Cj4gLQo+IC1zdGF0aWMgaW50IHBzcF9hc2RfaW5p
dChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgLXsKPiAtCWludCByZXQ7Cj4gLQo+IC0JLyoKPiAt
CSAqIEFsbG9jYXRlIDE2ayBtZW1vcnkgYWxpZ25lZCB0byA0ayBmcm9tIEZyYW1lIEJ1ZmZlciAo
bG9jYWwKPiAtCSAqIHBoeXNpY2FsKSBmb3Igc2hhcmVkIEFTRCA8LT4gRHJpdmVyCj4gLQkgKi8K
PiAtCXJldCA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKHBzcC0+YWRldiwKPiBQU1BfQVNEX1NI
QVJFRF9NRU1fU0laRSwKPiAtCQkJCSAgICAgIFBBR0VfU0laRSwKPiBBTURHUFVfR0VNX0RPTUFJ
Tl9WUkFNLAo+IC0JCQkJICAgICAgJnBzcC0+YXNkX3NoYXJlZF9ibywKPiAtCQkJCSAgICAgICZw
c3AtPmFzZF9zaGFyZWRfbWNfYWRkciwKPiAtCQkJCSAgICAgICZwc3AtPmFzZF9zaGFyZWRfYnVm
KTsKPiAtCj4gLQlyZXR1cm4gcmV0Owo+ICsJY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9w
aHlfYWRkcl9sbyA9IDA7Cj4gKwljbWQtPmNtZC5jbWRfbG9hZF90YS5jbWRfYnVmX3BoeV9hZGRy
X2hpID0gMDsKPiArCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfbGVuID0gMDsKPiAgfQo+
IAo+ICBzdGF0aWMgaW50IHBzcF9hc2RfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgQEAg
LTM1OSwxMSArMzQxLDE1IEBACj4gc3RhdGljIGludCBwc3BfYXNkX2xvYWQoc3RydWN0IHBzcF9j
b250ZXh0ICpwc3ApCj4gIAltZW1zZXQocHNwLT5md19wcmlfYnVmLCAwLCBQU1BfMV9NRUcpOwo+
ICAJbWVtY3B5KHBzcC0+ZndfcHJpX2J1ZiwgcHNwLT5hc2Rfc3RhcnRfYWRkciwgcHNwLQo+ID5h
c2RfdWNvZGVfc2l6ZSk7Cj4gCj4gLQlwc3BfcHJlcF9hc2RfY21kX2J1ZihjbWQsIHBzcC0+Zndf
cHJpX21jX2FkZHIsIHBzcC0KPiA+YXNkX3NoYXJlZF9tY19hZGRyLAo+IC0JCQkgICAgIHBzcC0+
YXNkX3Vjb2RlX3NpemUsCj4gUFNQX0FTRF9TSEFSRURfTUVNX1NJWkUpOwo+ICsJcHNwX3ByZXBf
YXNkX2xvYWRfY21kX2J1ZihjbWQsIHBzcC0+ZndfcHJpX21jX2FkZHIsCj4gKwkJCQkgIHBzcC0+
YXNkX3Vjb2RlX3NpemUpOwo+IAo+ICAJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVM
TCwgY21kLAo+ICAJCQkJIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwo+ICsJaWYgKCFyZXQpIHsK
PiArCQlwc3AtPmFzZF9jb250ZXh0LmFzZF9pbml0aWFsaXplZCA9IHRydWU7Cj4gKwkJcHNwLT5h
c2RfY29udGV4dC5zZXNzaW9uX2lkID0gY21kLT5yZXNwLnNlc3Npb25faWQ7Cj4gKwl9Cj4gCj4g
IAlrZnJlZShjbWQpOwo+IAo+IEBAIC0xMTk4LDEyICsxMTg0LDYgQEAgc3RhdGljIGludCBwc3Bf
aHdfc3RhcnQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gIAkJcmV0dXJuIHJldDsKPiAgCX0K
PiAKPiAtCXJldCA9IHBzcF9hc2RfaW5pdChwc3ApOwo+IC0JaWYgKHJldCkgewo+IC0JCURSTV9F
UlJPUigiUFNQIGFzZCBpbml0IGZhaWxlZCFcbiIpOwo+IC0JCXJldHVybiByZXQ7Cj4gLQl9Cj4g
LQo+ICAJcmV0ID0gcHNwX2FzZF9sb2FkKHBzcCk7Cj4gIAlpZiAocmV0KSB7Cj4gIAkJRFJNX0VS
Uk9SKCJQU1AgbG9hZCBhc2QgZmFpbGVkIVxuIik7Cj4gQEAgLTE2MTEsOCArMTU5MSw2IEBAIHN0
YXRpYyBpbnQgcHNwX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQo+ICAJCQkgICAgICAmcHNwLT5md19w
cmlfbWNfYWRkciwgJnBzcC0+ZndfcHJpX2J1Zik7Cj4gIAlhbWRncHVfYm9fZnJlZV9rZXJuZWwo
JnBzcC0+ZmVuY2VfYnVmX2JvLAo+ICAJCQkgICAgICAmcHNwLT5mZW5jZV9idWZfbWNfYWRkciwg
JnBzcC0+ZmVuY2VfYnVmKTsKPiAtCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmcHNwLT5hc2Rfc2hh
cmVkX2JvLCAmcHNwLQo+ID5hc2Rfc2hhcmVkX21jX2FkZHIsCj4gLQkJCSAgICAgICZwc3AtPmFz
ZF9zaGFyZWRfYnVmKTsKPiAgCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmcHNwLT5jbWRfYnVmX2Jv
LCAmcHNwLQo+ID5jbWRfYnVmX21jX2FkZHIsCj4gIAkJCSAgICAgICh2b2lkICoqKSZwc3AtPmNt
ZF9idWZfbWVtKTsKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5oCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmgK
PiBpbmRleCA2ZGUwZWU5Nzg2MWYuLmE0ZDc2OTBlYTU3NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmgKPiBAQCAtMzIsNyArMzIsNiBAQAo+IAo+ICAjZGVmaW5l
IFBTUF9GRU5DRV9CVUZGRVJfU0laRQkweDEwMDAKPiAgI2RlZmluZSBQU1BfQ01EX0JVRkZFUl9T
SVpFCTB4MTAwMAo+IC0jZGVmaW5lIFBTUF9BU0RfU0hBUkVEX01FTV9TSVpFIDB4NDAwMAo+ICAj
ZGVmaW5lIFBTUF9YR01JX1NIQVJFRF9NRU1fU0laRSAweDQwMDAgICNkZWZpbmUKPiBQU1BfUkFT
X1NIQVJFRF9NRU1fU0laRSAweDgwMDAKPiAgI2RlZmluZSBQU1BfMV9NRUcJCTB4MTAwMDAwCj4g
QEAgLTEzMCw2ICsxMjksMTEgQEAgc3RydWN0IHBzcF94Z21pX3RvcG9sb2d5X2luZm8gewo+ICAJ
c3RydWN0IHBzcF94Z21pX25vZGVfaW5mbwo+IAlub2Rlc1tBTURHUFVfWEdNSV9NQVhfQ09OTkVD
VEVEX05PREVTXTsKPiAgfTsKPiAKPiArc3RydWN0IHBzcF9hc2RfY29udGV4dCB7Cj4gKwlib29s
CQkJYXNkX2luaXRpYWxpemVkOwo+ICsJdWludDMyX3QJCXNlc3Npb25faWQ7Cj4gK307Cj4gKwo+
ICBzdHJ1Y3QgcHNwX3hnbWlfY29udGV4dCB7Cj4gIAl1aW50OF90CQkJCWluaXRpYWxpemVkOwo+
ICAJdWludDMyX3QJCQlzZXNzaW9uX2lkOwo+IEBAIC0yMzgsMTUgKzI0MiwxMiBAQCBzdHJ1Y3Qg
cHNwX2NvbnRleHQKPiAgCXN0cnVjdCBhbWRncHVfYm8JCSp0bXJfYm87Cj4gIAl1aW50NjRfdAkJ
CXRtcl9tY19hZGRyOwo+IAo+IC0JLyogYXNkIGZpcm13YXJlIGFuZCBidWZmZXIgKi8KPiArCS8q
IGFzZCBmaXJtd2FyZSAqLwo+ICAJY29uc3Qgc3RydWN0IGZpcm13YXJlCQkqYXNkX2Z3Owo+ICAJ
dWludDMyX3QJCQlhc2RfZndfdmVyc2lvbjsKPiAgCXVpbnQzMl90CQkJYXNkX2ZlYXR1cmVfdmVy
c2lvbjsKPiAgCXVpbnQzMl90CQkJYXNkX3Vjb2RlX3NpemU7Cj4gIAl1aW50OF90CQkJCSphc2Rf
c3RhcnRfYWRkcjsKPiAtCXN0cnVjdCBhbWRncHVfYm8JCSphc2Rfc2hhcmVkX2JvOwo+IC0JdWlu
dDY0X3QJCQlhc2Rfc2hhcmVkX21jX2FkZHI7Cj4gLQl2b2lkCQkJCSphc2Rfc2hhcmVkX2J1ZjsK
PiAKPiAgCS8qIGZlbmNlIGJ1ZmZlciAqLwo+ICAJc3RydWN0IGFtZGdwdV9ibwkJKmZlbmNlX2J1
Zl9ibzsKPiBAQCAtMjgxLDYgKzI4Miw3IEBAIHN0cnVjdCBwc3BfY29udGV4dAo+ICAJdWludDMy
X3QJCQl0YV9kdG1fdWNvZGVfc2l6ZTsKPiAgCXVpbnQ4X3QJCQkJKnRhX2R0bV9zdGFydF9hZGRy
Owo+IAo+ICsJc3RydWN0IHBzcF9hc2RfY29udGV4dAkJYXNkX2NvbnRleHQ7Cj4gIAlzdHJ1Y3Qg
cHNwX3hnbWlfY29udGV4dAkJeGdtaV9jb250ZXh0Owo+ICAJc3RydWN0IHBzcF9yYXNfY29udGV4
dAkJcmFzOwo+ICAJc3RydWN0IHBzcF9oZGNwX2NvbnRleHQgCWhkY3BfY29udGV4dDsKPiAtLQo+
IDIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
