Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EEAC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E42021774
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E42021774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A51126E89D;
	Fri, 29 Nov 2019 09:36:33 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740078.outbound.protection.outlook.com [40.107.74.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216236E89D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 09:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzUTC/BKJdwXTf0fKmOuqGUlhbWqFJPHv9XHuLegRn+jDXVSomesRbCAOQem1p2FXUPVd0ckGfHdTsNfd0ZhDvlOby03xVE2QLci+ut/vMvPH3yXxSqxSdvAar568ivWzUg0aL46fu2oTLGALLrcjJRdDk9PdtyVhTsZF5ofYg+p/3+OvWCIAtCaMHtwjc2+LDErYXhRA5xscLS2IsaT+SjQORlP+G1l4fGREdTiqwjnALNzvcnHyX5Rt5BjmkgPK9heDLu4sTZshCEC5tu6bCcEHYoKP1W75r0vQGxTILdRa4BixcCkSeeL5U8CbJF1ejBVmuzz6KeoEhCc3TQNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3T38G+syYLAc1xFJ2Vb4+gl9hmEY+k6iqaMz5v8WaA=;
 b=AohijmayTbL3KVYGk8D6XhB5KshfYQ7WrYm1yjxPSM+Tkps72aSIuv0RZBxcBWXndoLg148dNICGAA5ZrZ36NqS7aMDOLhLxhqorgHF12G5zhEvfKSsNDI/B+svlXFc9+MApcy0OgNOkbpBrQM+DKyO/P67Rsq0mcAnFV6kL36jFnpSm5vAqaF7cCQE6Ves7wNGQiAGo88ZML1EqrU2m5XoiEpp6aPp1Bs4Dlxjra11ThsMtIr9ohGPQD3Qgkp6H8lGBlg18zh/6y0dPcdTOoAaYnnxgJ5T0QacYZn8gv5htgaBIG65erV6pr/Tje2ARxnAiYkrPoUlWgKwDgeGyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3901.namprd12.prod.outlook.com (10.255.238.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 09:36:30 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 09:36:30 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix GFX10 missing CSIB set(v2)
Thread-Topic: [PATCH] drm/amdgpu: fix GFX10 missing CSIB set(v2)
Thread-Index: AQHVppWsEJ/hSYYc+ESYqJw2sZztJqeh4awAgAACGKA=
Date: Fri, 29 Nov 2019 09:36:30 +0000
Message-ID: <MN2PR12MB393358A523EA0A417BFA4F0284460@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1575018965-30828-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1418FE37301D02C34B9A9FD3FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418FE37301D02C34B9A9FD3FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-11-29T09:23:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=31c6b16b-ad06-412d-a65f-0000758c8b98;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad2f0485-bdab-4578-ff74-08d774af9d79
x-ms-traffictypediagnostic: MN2PR12MB3901:|MN2PR12MB3901:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39010CF23489C832606B7A4384460@MN2PR12MB3901.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(13464003)(76116006)(966005)(33656002)(25786009)(66946007)(64756008)(66066001)(66446008)(2501003)(478600001)(6116002)(9686003)(66556008)(11346002)(66476007)(45080400002)(55016002)(74316002)(256004)(3846002)(6246003)(99286004)(86362001)(71200400001)(71190400001)(316002)(81166006)(8936002)(6306002)(81156014)(446003)(102836004)(110136005)(26005)(229853002)(52536014)(186003)(6506007)(76176011)(7696005)(5660300002)(53546011)(2906002)(14454004)(305945005)(8676002)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3901;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3TuKgjhwLReV8CzfqUkwWc/oj8N8jDFjpPocCkVVimnJIPRpfjIzt4m7JpB7ij/5EWPMsYoYmsEJHX69GikjVrLd4zdHJ1kJiVZwHw3hcB8lqVMH37mO0ZRnqu06GzPQq5IFtWW+RBRvmvdjC95YLUeFqBpDO+K/9jVX8TXsj5iQ5iWO5Y+DSnHJa7ACaIEBVjTduIcZoK2wpZLunZjj8X8fsSxnRiXiGAnJ05XebeKj2ZuzO+Vx1GiLlwyLR4j+spJKiAzUu27qekPYzxxPx0QUr6d04E9iJ0tTKN9R/y9tDllYU9FMNmTkJVIyNUfMA/vISknTqsh1PJWF8cYOiehXnke6/7oeZW51MfZaHuBfDKDbAVF9Np8WAYu6AqfCvsgenj0eKvUiq9ACsXnhgvY7PcsKsBs2oeTApJ42E6tehEB7qkZCf3f6zezsk2PrudyHG5PHCglL4uSGQxAsxSQdzk0NJHMsUlEVqq7+Rg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2f0485-bdab-4578-ff74-08d774af9d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:36:30.4142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E74jN0Ne0R/ExnQAClqfaa4j4PzOBIvkzm85uSJbegG7jCsyvx9pyyuFTTwgMdUB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3T38G+syYLAc1xFJ2Vb4+gl9hmEY+k6iqaMz5v8WaA=;
 b=bAIVJzOxQ+nE2gSgcJBB5XIW/3SqYR+7PRBKmsGBhYvduH2jBv3TwIospSJHNqTPRBsM43h4DHfgKopX9fWLwCwwkr+uu0Czb7UhKvz6NJSk4Iege18Jf9NSJiwCCFI1Kp1jhyG+G8sxP/yRnlVHKl3xPE56PHGF4mhqTZwJgBM=
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

VGhhbmtzLCBkb25lDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCk1v
bmsgTGl1fEdQVSBWaXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQNCg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4g
DQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI5LCAyMDE5IDU6MjkgUE0NClRvOiBMaXUsIE1vbmsg
PE1vbmsuTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IExp
dSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRn
cHU6IGZpeCBHRlgxMCBtaXNzaW5nIENTSUIgc2V0KHYyKQ0KDQpbQU1EIFB1YmxpYyBVc2VdDQoN
ClBsZWFzZSBhbHNvIGRyb3AgdGhlIHRsYiBmbHVzaC4gSXQgaXMgcHJvYmFibHkgZnJvbSBjb2Rl
IHVzZWQgZm9yIHRoZSBlbXVsYXRpb24uDQorCQlmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX3Zt
aHViczsgaSsrKQ0KKwkJCWFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2LCAwLCBpLCAwKTsN
Cg0KV2l0aCB0aGF0IGZpeGVkLCB0aGUgcGF0Y2ggaXMNClJldmlld2VkLWJ5OiBIYXdraW5nIFpo
YW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIE1vbmsgTGl1DQpTZW50OiAyMDE55bm0MTHm
nIgyOeaXpSAxNzoxNg0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTGl1
LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBm
aXggR0ZYMTAgbWlzc2luZyBDU0lCIHNldCh2MikNCg0Kc3RpbGwgbmVlZCB0byBpbml0IGNzYiBl
dmVuIGZvciBTUklPVg0KDQp2MjoNCmRyb3AgaW5pdF9wZygpIGZvciBnZngxMCBhdCBhbGwgc2lu
Y2UNClBHIGFuZCBHRlggb2ZmIGZlYXR1cmUgd2lsbCBiZSBmdWxseSBjb250cm9sZWQgYnkgUkxD
IGFuZCBTTVUgZncgZm9yIGdmeDEwDQoNClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxp
dUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMg
fCAzOCArKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYw0KaW5kZXggNTNkMTFlOS4uYThlZWJjNCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KQEAgLTE3NjYsMjIgKzE3NjYsNiBAQCBzdGF0aWMg
aW50IGdmeF92MTBfMF9pbml0X2NzYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJcmV0
dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2luaXRfcGcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpIC17DQotCWludCBpOw0KLQlpbnQgcjsNCi0NCi0JciA9IGdmeF92MTBf
MF9pbml0X2NzYihhZGV2KTsNCi0JaWYgKHIpDQotCQlyZXR1cm4gcjsNCi0NCi0JZm9yIChpID0g
MDsgaSA8IGFkZXYtPm51bV92bWh1YnM7IGkrKykNCi0JCWFtZGdwdV9nbWNfZmx1c2hfZ3B1X3Rs
YihhZGV2LCAwLCBpLCAwKTsNCi0NCi0JLyogVE9ETzogaW5pdCBwb3dlciBnYXRpbmcgKi8NCi0J
cmV0dXJuIDA7DQotfQ0KLQ0KIHZvaWQgZ2Z4X3YxMF8wX3JsY19zdG9wKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KSAgew0KIAl1MzIgdG1wID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19D
TlRMKTsgQEAgLTE4NzMsMjIgKzE4NTcsMjEgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmxjX2xv
YWRfbWljcm9jb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgc3RhdGljIGludCBnZnhf
djEwXzBfcmxjX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsNCiAJaW50IHI7
DQotDQotCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQotCQlyZXR1cm4gMDsNCisJaW50IGk7
DQogDQogCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQ
KSB7DQorDQogCQlyID0gZ2Z4X3YxMF8wX3dhaXRfZm9yX3JsY19hdXRvbG9hZF9jb21wbGV0ZShh
ZGV2KTsNCiAJCWlmIChyKQ0KIAkJCXJldHVybiByOw0KIA0KLQkJciA9IGdmeF92MTBfMF9pbml0
X3BnKGFkZXYpOw0KLQkJaWYgKHIpDQotCQkJcmV0dXJuIHI7DQorCQlnZnhfdjEwXzBfaW5pdF9j
c2IoYWRldik7DQogDQotCQkvKiBlbmFibGUgUkxDIFNSTSAqLw0KLQkJZ2Z4X3YxMF8wX3JsY19l
bmFibGVfc3JtKGFkZXYpOw0KKwkJZm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV92bWh1YnM7IGkr
KykNCisJCQlhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGIoYWRldiwgMCwgaSwgMCk7DQogDQorCQlp
ZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgLyogZW5hYmxlIFJMQyBTUk0gKi8NCisJCQlnZnhf
djEwXzBfcmxjX2VuYWJsZV9zcm0oYWRldik7DQogCX0gZWxzZSB7DQogCQlhZGV2LT5nZngucmxj
LmZ1bmNzLT5zdG9wKGFkZXYpOw0KIA0KQEAgLTE5MTAsOSArMTg5MywxMCBAQCBzdGF0aWMgaW50
IGdmeF92MTBfMF9ybGNfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIAkJCQly
ZXR1cm4gcjsNCiAJCX0NCiANCi0JCXIgPSBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsNCi0JCWlm
IChyKQ0KLQkJCXJldHVybiByOw0KKwkJZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYpOw0KKw0KKwkJ
Zm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV92bWh1YnM7IGkrKykNCisJCQlhbWRncHVfZ21jX2Zs
dXNoX2dwdV90bGIoYWRldiwgMCwgaSwgMCk7DQogDQogCQlhZGV2LT5nZngucmxjLmZ1bmNzLT5z
dGFydChhZGV2KTsNCiANCi0tDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFu
JTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NoYXdraW5nLnpoYW5nJTQw
YW1kLmNvbSU3QzBhM2M4ZmVlMGM5MTQ3YzUzZjU2MDhkNzc0YWNjZDk3JTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzEwNjE1Nzg0MDc2NDAzOCZhbXA7c2Rh
dGE9eWI5cDdFZTlUM245eE5VN1JwZ0UxY1hPdkVPZTlPU1Jnb0Jma1pXSFZUSSUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
