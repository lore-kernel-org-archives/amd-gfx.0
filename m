Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F44C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 04:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA86F2178F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 04:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA86F2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7705C6E34D;
	Thu,  7 Nov 2019 04:03:30 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820051.outbound.protection.outlook.com [40.107.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BEC6E34D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 04:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJypSfve6Oh55HIdppJ+gR7V9+IVp5LOmn6sCZYzUVud5/IA1QMBn/z2FqfMKxxwqsYu0nhZgaPN3dtstS/yaS4ZRg4KAbZOVVv/xl7EIzbP3Pj/OJdHX64UOCd85WVi3ortTaCW9Sd+d8iIaE/ppPaF9c+rGaLLaiUloYL+bB4Kfd4glxVbrVU+lekvpK8gcteR6AnhmCO7OSLLDgw86im4yER4X+mu5FzH9HHH2TAqUxtAinQZH//kBfNggxap6zak/eiHcewK5YHtUik2sYDgUXO6g5O+W2TUs+rGTnI3tYWzEMJXmnjdHAM/PbgsAFs5cP+W6yglcndurqd5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LMDnw8rBMe2v+JBYZW+nCQMu4Q4yxY8TjaiZMkPneI=;
 b=RAi560aIiNHBO6aLShBoqrdayiE2qTAlmrX/vrTixqbqgkDo59i1X+qc9rEW5xqFNgJRY3eYXjlvKdiXfLy76ehLDtFQGzykNnkHGJOoE0uwkdqhqArBwA8YRwbH1hWkJQCXuD1+YgtHO8pNqT8KipbnqBdCaQlQOuXWOhk4DzyloP2PPiLdFhmiUog/XN9MU2p8VTb8u/1FO3XHCNG+vAeKATCtWhzUTg5RRowM3eEZtoX10iulbdnWG4OLx6yuJilYKKzJL9+qhbrBX9U6oJRHf3moA65iX38pDkZ7qf2iX80Jwat4DVXEatrAQKNr2Wj06hMQ9DcWGJNnfzKfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3584.namprd12.prod.outlook.com (20.178.242.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 04:03:27 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 04:03:27 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix vega20 pstate status change
Thread-Topic: [PATCH] drm/amdgpu: fix vega20 pstate status change
Thread-Index: AQHVlKsN6bKM8GOI9k2oUvJy2j0txqd/FyIA
Date: Thu, 7 Nov 2019 04:03:27 +0000
Message-ID:
 <MN2PR12MB33445EBE6FBC8500FBC393FCE4780@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191106140351.36350-1-jonathan.kim@amd.com>
In-Reply-To: <20191106140351.36350-1-jonathan.kim@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed2e2588-7793-4302-a9e3-08d76337718c
x-ms-traffictypediagnostic: MN2PR12MB3584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3584866BCAC4177BFBD8DCD1E4780@MN2PR12MB3584.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(13464003)(199004)(189003)(25786009)(102836004)(7696005)(74316002)(6506007)(99286004)(76176011)(446003)(14444005)(8936002)(6116002)(81156014)(476003)(53546011)(256004)(66556008)(66476007)(26005)(4326008)(186003)(229853002)(9686003)(55016002)(8676002)(71190400001)(71200400001)(2501003)(5660300002)(33656002)(2906002)(3846002)(486006)(76116006)(6246003)(14454004)(64756008)(66946007)(54906003)(81166006)(86362001)(305945005)(478600001)(66066001)(316002)(66446008)(6436002)(11346002)(7736002)(52536014)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3584;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l+11r9EcRpxHptA4DFLYQM60/b1JkCQvAk2yJEn8cvPYnzlDfXJRh+oyKYZEZEBO9sheA1ZipFfziJjlR4Zf2we+4aj/HSWsSjofxHNhwFYREVNF+AxqDDA+NYLxq6+WiTmLMCY4Fzclgd4a+zmbvYwNoTKBCUpOvDpFc6RLixsLbQ4izQgLw6VxGcKekSJjKePQUc4amRQhX3L6udjwag08IEGBC1LJjwB6n1Dn39Z5SiPhvrHetw6dxfol0RgLOEVS7ZDcHmannFn6xwloIOuau6HnHunyZZMLKOYJATJ4raslxYHTxvvav4Ix3WANduPwi6vO9hQdgFgjvYcG1/kx/cXFF3KhbCPia5J8cKtMttChlp1p0Qmi/rcUUK6MrXkxE2dpAqzEBlq8KIxdotxHz3/ev7ndTTH5HHnS7g/gQIdg0w5GYXYq+cpZRJLS
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2e2588-7793-4302-a9e3-08d76337718c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 04:03:27.3620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1wTjIpbdXGE6l5cxayi7XTzXgLUAQRvLqLsvGNxw97scx8ohY6FPmAMqY4bE0Qu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3584
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LMDnw8rBMe2v+JBYZW+nCQMu4Q4yxY8TjaiZMkPneI=;
 b=u6xtNnMwoTH3LvNqEbgomANg3Y7anrA058Wp0DAm2qMmgmesrZY6wAcSxNS2YHDOMis/0SNJ21NgDJQwqQmlMPsWa0JuN5lg6FcKUe95jAovbJZRX0i/Sdz1X61lI9GI/ZdDzyfbKUslu3SFYrNUfcsC3UQQvoCt9QvSa78bEXs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Strawbridge,
 Michael" <Michael.Strawbridge@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107040327.eaVwhlIgvaFNkChgcbgHyerFeQGKlunGXLNSGYsRXyI@z>

UmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Cgo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5j
b20+Cj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA2LCAyMDE5IDEwOjA0IFBNCj4gVG86IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT47IFF1YW4sIEV2YW4KPiA8RXZhbi5RdWFuQGFtZC5jb20+OyBTdHJh
d2JyaWRnZSwgTWljaGFlbAo+IDxNaWNoYWVsLlN0cmF3YnJpZGdlQGFtZC5jb20+OyBLaW0sIEpv
bmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47Cj4gS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4u
S2ltQGFtZC5jb20+Cj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggdmVnYTIwIHBz
dGF0ZSBzdGF0dXMgY2hhbmdlCj4gCj4gdmVnYTIwIG9ubHkgcmVxdWlyZXMgYWxsIGRldmljZXMg
YmUgc2V0IHRvIHNhbWUgcHN0YXRlIGxldmVsIGZvciBsb3cgcHN0YXRlIGFuZAo+IG5vdCBoaWdo
Lgo+IAo+IENoYW5nZS1JZDogSTM5OWM4NGE0N2Y2ZTI0YWJjYTkzN2NlOTUwNjg1YzBjN2YwZTMy
NzkKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBLaW0gPEpvbmF0aGFuLktpbUBhbWQuY29tPgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jIHwgNyArKysr
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMK
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMKPiBpbmRleCBkZTIw
YTlhMWM0NDQuLjYxZDEzZDhiN2IyMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfeGdtaS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3hnbWkuYwo+IEBAIC0yNzYsNiArMjc2LDcgQEAgaW50IGFtZGdwdV94Z21pX3NldF9w
c3RhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UKPiAqYWRldiwgaW50IHBzdGF0ZSkKPiAgCXN0cnVj
dCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlID0gYW1kZ3B1X2dldF94Z21pX2hpdmUoYWRldiwgMCk7
Cj4gIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqdG1wX2FkZXY7Cj4gIAlib29sIHVwZGF0ZV9oaXZl
X3BzdGF0ZSA9IHRydWU7Cj4gKwlib29sIGlzX2hpZ2hfcHN0YXRlID0gcHN0YXRlICYmIGFkZXYt
PmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMDsKPiAKPiAgCWlmICghaGl2ZSkKPiAgCQlyZXR1cm4g
MDsKPiBAQCAtMjgzLDggKzI4NCw4IEBAIGludCBhbWRncHVfeGdtaV9zZXRfcHN0YXRlKHN0cnVj
dCBhbWRncHVfZGV2aWNlCj4gKmFkZXYsIGludCBwc3RhdGUpCj4gIAltdXRleF9sb2NrKCZoaXZl
LT5oaXZlX2xvY2spOwo+IAo+ICAJaWYgKGhpdmUtPnBzdGF0ZSA9PSBwc3RhdGUpIHsKPiAtCQlt
dXRleF91bmxvY2soJmhpdmUtPmhpdmVfbG9jayk7Cj4gLQkJcmV0dXJuIDA7Cj4gKwkJYWRldi0+
cHN0YXRlID0gaXNfaGlnaF9wc3RhdGUgPyBwc3RhdGUgOiBhZGV2LT5wc3RhdGU7Cj4gKwkJZ290
byBvdXQ7Cj4gIAl9Cj4gCj4gIAlkZXZfZGJnKGFkZXYtPmRldiwgIlNldCB4Z21pIHBzdGF0ZSAl
ZC5cbiIsIHBzdGF0ZSk7IEBAIC0zMTcsNwo+ICszMTgsNyBAQCBpbnQgYW1kZ3B1X3hnbWlfc2V0
X3BzdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50Cj4gcHN0YXRlKQo+ICAJCQli
cmVhazsKPiAgCQl9Cj4gIAl9Cj4gLQlpZiAodXBkYXRlX2hpdmVfcHN0YXRlKQo+ICsJaWYgKHVw
ZGF0ZV9oaXZlX3BzdGF0ZSB8fCBpc19oaWdoX3BzdGF0ZSkKPiAgCQloaXZlLT5wc3RhdGUgPSBw
c3RhdGU7Cj4gCj4gIG91dDoKPiAtLQo+IDIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
