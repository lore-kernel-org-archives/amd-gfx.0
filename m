Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C7C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 09:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426472243F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 09:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426472243F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CF66E0B7;
	Wed, 20 Nov 2019 09:03:10 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720086.outbound.protection.outlook.com [40.107.72.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C5F6E0B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 09:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlVsyC/A0pGIPt7j6LG2Uy/OYUupiMGwb3sqirNTou1toaIIDD5ytSqYfN8x3MlbDZB6C8CyBAe+tk7VRkuHrmqnU/Q7OcoNWbDPru/+KHgwWiomQzMbLQGnFJdATW23F0NJM4vQmjiMcyd45uIkOi3N+yuhhlIqtygKVNSEpLROV1nageQjdg9Wi46WeN2DhjgONJuDgz698W7IH8rML8cVknVuBekIHB7MMmHFpL2BTU/KfJYtgkSTMwjoABRUkbDD3RJAAYXz0wDBAJ6OwHLcVYnB4uG+GCQzQDaSxMk4gHtASnEQvmzmyvzFPr5jrNAoPtT+TuxDkv/rrvAcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU6EOlJBfF8zpxepIazQyEhiaZanSOKSh9x+ySvNBtM=;
 b=KG3bCyKGnWHbkJHenntF6DnIq9IPIzhxMu2gQWhXUwBf+UJV14wltRUR2YQSL/9hVpq2E9q5/PyB2zE18sKcYOF2hjn9UCoowuOGVTfkpZa18jdGocR8Ou52jYfUVhwahc7oZx2G0GpCkBtgqcEqznOO6mSsi0QlCk9lwQ4TKX4uVJ6nhQS1Y1iZgQV6Zd/GCi6fIQxTQC+1YLsIQX1XfveejBXB4LEmSoMSKaFTYmBLwEGHfJ7BFbh1a9ASiNiXhwwWkOj3hZKUrSg8ownkDkmWLeChEGUqRTLNe9FRH/o7JvvAaXnub8YnXHwci186sUPi3uJKpWgsBj/QyV4jVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1898.namprd12.prod.outlook.com (10.175.88.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Wed, 20 Nov 2019 09:03:06 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 09:03:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Topic: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Index: AQHVn25hgnJp5nBSs0qXI2gya/dmz6eTvYcwgAAEVQCAAAETYA==
Date: Wed, 20 Nov 2019 09:03:06 +0000
Message-ID:
 <DM5PR12MB141841B249541968B0962085FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191120064701.2765-1-xiaojie.yuan@amd.com>,
 <DM5PR12MB1418A32EB8199ABFFCCAEC04FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <MN2PR12MB308747C45983374E17E1BD17894F0@MN2PR12MB3087.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB308747C45983374E17E1BD17894F0@MN2PR12MB3087.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cea88125-8245-434e-4ac3-08d76d98754f
x-ms-traffictypediagnostic: DM5PR12MB1898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18989C49D296356AFF9D529DFC4F0@DM5PR12MB1898.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(13464003)(51914003)(26005)(186003)(6116002)(3846002)(14444005)(256004)(486006)(55016002)(2906002)(6246003)(7736002)(66066001)(86362001)(9686003)(11346002)(229853002)(2501003)(74316002)(446003)(76176011)(99286004)(476003)(316002)(7696005)(6436002)(305945005)(71200400001)(54906003)(25786009)(110136005)(71190400001)(8676002)(102836004)(81166006)(81156014)(66946007)(8936002)(66556008)(66476007)(76116006)(52536014)(33656002)(64756008)(66446008)(5660300002)(14454004)(6506007)(53546011)(478600001)(4326008)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1898;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xW5nz1NBIxaLJZQwXJ6Noq06Y+CUavZOevVNiqkU+5SWQIWKRuq/+HP8+S9UBttEHVLKTOy6zYPS0TdFPvs3M5/6dGtoet5V5+xZWgdnQxYovj4Sc1vrM7hMR5rHVw/NUvddzhejuIq3NuPqBOg4W83JovyNcusCFzhZKSibUuz7iWf7D/f7jQKHv6t/vg1ShmQV53HEIbP4f1jmlJyp2zKeSQ1VfKZ3OvvDzwK9aVB7w2lYOJv+zxff13n9yLZNRB2a4V1vOeD/XgasyoXRZcz9z+jIQQnJuxGRXCEmBWnYFiaGq+JlfZglCpP+DaheuZx77fHEhKjAsScYu95/XoFSMXtDg6s0w0XtbbuUZOPWNJ8deo+NhlrGbTjEBpnZKhTL83l4JQgnLsJdmOUXgdwxx8wbRUEF6k4g4d9ENwR2LopE3+shdjq7VvCZTudJ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea88125-8245-434e-4ac3-08d76d98754f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 09:03:06.5382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYYP7fsiKZbhjGuqXzc9GUF9vcbsxO+IH4D7ZvswoCFNGMrCylt2fQwaIBWTI7dhMv+TlVf550d+ryRpqbaYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1898
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU6EOlJBfF8zpxepIazQyEhiaZanSOKSh9x+ySvNBtM=;
 b=tuPPH5DzPcZ4J92e+9yB09gdpDxo7lwIfp/xUeLTZNXUod6+mO3YYfLMhqjwmy1L8L9uNQxu9e4ZG9ZljEkB/KTBhbWM0qPVRkgTeeWLbWp2tFYT1Yki/stKRsaOLidEofvYPl8ZOw3b/SKtsjxCaXlvcjucZuBgIawzyv1dClM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120090306.A7A0tnNllHds3nxd7euCrJ62Q-kjqlWz0p-vna6vBpA@z>

SSBzZWUuIFRoYW5rcyBmb3IgdGhlIGNsYXJpZnlpbmcuIFRoZSBwYXRjaCBpcw0KDQpSZXZpZXdl
ZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KDQpSZWdhcmRzLA0K
SGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFl1YW4sIFhpYW9qaWUg
PFhpYW9qaWUuWXVhbkBhbWQuY29tPiANClNlbnQ6IDIwMTnlubQxMeaciDIw5pelIDE2OjU2DQpU
bzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpDYzogWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+OyBMb25n
LCBHYW5nIDxHYW5nLkxvbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHUvZ2Z4MTA6IHJlLWluaXQgY2xlYXIgc3RhdGUgYnVmZmVyIGFmdGVyIGdwdSByZXNldA0KDQpI
aSBIYXdraW5nLA0KDQpUaGlzIGlzIGEgZm9ybWFsIGZpeCBJIHRoaW5rLg0KQXMgeW91IHN1Z2dl
c3RlZCwgSSB0cmllZCB0byBkdW1wIGNzYiBpbiB2YXJpb3VzIGxvY2F0aW9ucyBpbiBncHUgcmVz
ZXQgc2VxdWVuY2U6DQoxLiBhZnRlciBnZnhfdjEwXzBfaHdfZmluaSgpIGNvbXBsZXRlcyAtIGNz
YiBzdGlsbCBjb250YWlucyBjb3JyZWN0IGRhdGENCiAgICB8DQogICAgdg0KICAgYmFjbyByZXNl
dA0KICAgIHwNCiAgICB2DQoyLiByaWdodCBhZnRlciBnbWMgcmVzdW1lIC0gY3NiIGNvbnRhaW5z
IGNvcnJ1cHRlZCBkYXRhDQoNCkluIHRoaXMgc21hbGwgdGltZSB3aW5kb3csIG5vIGZpcm13YXJl
IHRvdWNoZXMgY3NiIGFuZCBpdCBzaG91bGQgcHJvdmUgdGhhdCB2cmFtIGxvc3QgY2F1c2VzIGNz
YiBjb3JydXB0Lg0KDQpCUiwNClhpYW9qaWUNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KRnJvbTogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNv
bT4NClNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjAsIDIwMTkgNDo0MyBQTQ0KVG86IFl1YW4s
IFhpYW9qaWU7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWGlhbywgSmFjazsg
TG9uZywgR2FuZw0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdS9nZngxMDogcmUtaW5p
dCBjbGVhciBzdGF0ZSBidWZmZXIgYWZ0ZXIgZ3B1IHJlc2V0DQoNCkp1c3QgbWFrZSBzdXJlIEkg
dW5kZXJzdGFuZCB5b3UgY29ycmVjdGx5LiBTbyB1bnRpbCBmdyB0ZWFtIHJvb3QgY2F1c2UgdGhl
IHJlYXNvbiBvZiBjc2IgY29ycnVwdGlvbiwgd2Uga2VlcCB0aGUgd29ya2Fyb3VuZCBpbiBkcml2
ZXIsIGNvcnJlY3Q/DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogWXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+DQpTZW50OiAy
MDE55bm0MTHmnIgyMOaXpSAxNDo0Nw0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFhpYW8sIEphY2sg
PEphY2suWGlhb0BhbWQuY29tPjsgTG9uZywgR2FuZyA8R2FuZy5Mb25nQGFtZC5jb20+OyBZdWFu
LCBYaWFvamllIDxYaWFvamllLll1YW5AYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2Ft
ZGdwdS9nZngxMDogcmUtaW5pdCBjbGVhciBzdGF0ZSBidWZmZXIgYWZ0ZXIgZ3B1IHJlc2V0DQoN
ClRoaXMgcGF0Y2ggZml4ZXMgMm5kIGJhY28gcmVzZXQgZmFpbHVyZSB3aXRoIGdmeG9mZiBlbmFi
bGVkIG9uIG5hdmkxeC4NCg0KY2xlYXIgc3RhdGUgYnVmZmVyIChyZXNpZGVzIGluIHZyYW0pIGlz
IGNvcnJ1cHRlZCBhZnRlciAxc3QgYmFjbyByZXNldCwgdXBvbiBnZnhvZmYgZXhpdCwgQ1BGIGdl
dHMgZ2FyYmFnZSBoZWFkZXIgaW4gQ1NJQiBhbmQgaGFuZ3MuDQoNClNpZ25lZC1vZmYtYnk6IFhp
YW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDQzICsrKysrKysrKysrKysrKysrKysrKystLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQppbmRleCA5Mjc0YmQ0YjZjNjguLjhlMjRl
YTA4Y2EzOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KQEAgLTE3
ODksMjcgKzE3ODksNTIgQEAgc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX2VuYWJsZV9ndWlfaWRsZV9p
bnRlcnJ1cHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogICAgICAgIFdSRUczMl9TT0Mx
NShHQywgMCwgbW1DUF9JTlRfQ05UTF9SSU5HMCwgdG1wKTsgIH0NCg0KLXN0YXRpYyB2b2lkIGdm
eF92MTBfMF9pbml0X2NzYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCitzdGF0aWMgaW50
IGdmeF92MTBfMF9pbml0X2NzYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiB7DQorICAg
ICAgIGludCByOw0KKw0KKyAgICAgICBpZiAoYWRldi0+aW5fZ3B1X3Jlc2V0KSB7DQorICAgICAg
ICAgICAgICAgciA9IGFtZGdwdV9ib19yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVf
b2JqLCBmYWxzZSk7DQorICAgICAgICAgICAgICAgaWYgKHIpDQorICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcjsNCisNCisgICAgICAgICAgICAgICByID0gYW1kZ3B1X2JvX2ttYXAoYWRl
di0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmosDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICh2b2lkICoqKSZhZGV2LT5nZngucmxjLmNzX3B0cik7DQorICAgICAgICAgICAgICAg
aWYgKCFyKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5nZngucmxjLmZ1bmNzLT5n
ZXRfY3NiX2J1ZmZlcihhZGV2LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFkZXYtPmdmeC5ybGMuY3NfcHRyKTsNCisgICAgICAgICAgICAgICAgICAgICAgIGFtZGdw
dV9ib19rdW5tYXAoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmopOw0KKyAgICAgICAgICAg
ICAgIH0NCisNCisgICAgICAgICAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKGFkZXYtPmdmeC5y
bGMuY2xlYXJfc3RhdGVfb2JqKTsNCisgICAgICAgICAgICAgICBpZiAocikNCisgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiByOw0KKyAgICAgICB9DQorDQogICAgICAgIC8qIGNzaWIgKi8N
CiAgICAgICAgV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DU0lCX0FERFJfSEksDQogICAgICAg
ICAgICAgICAgICAgICBhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX2dwdV9hZGRyID4+IDMyKTsN
CiAgICAgICAgV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DU0lCX0FERFJfTE8sDQogICAgICAg
ICAgICAgICAgICAgICBhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX2dwdV9hZGRyICYgMHhmZmZm
ZmZmYyk7DQogICAgICAgIFdSRUczMl9TT0MxNShHQywgMCwgbW1STENfQ1NJQl9MRU5HVEgsIGFk
ZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfc2l6ZSk7DQorDQorICAgICAgIHJldHVybiAwOw0KIH0N
Cg0KLXN0YXRpYyB2b2lkIGdmeF92MTBfMF9pbml0X3BnKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KK3N0YXRpYyBpbnQgZ2Z4X3YxMF8wX2luaXRfcGcoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpDQogew0KICAgICAgICBpbnQgaTsNCisgICAgICAgaW50IHI7DQoNCi0gICAgICAgZ2Z4
X3YxMF8wX2luaXRfY3NiKGFkZXYpOw0KKyAgICAgICByID0gZ2Z4X3YxMF8wX2luaXRfY3NiKGFk
ZXYpOw0KKyAgICAgICBpZiAocikNCisgICAgICAgICAgICAgICByZXR1cm4gcjsNCg0KICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX3ZtaHViczsgaSsrKQ0KICAgICAgICAgICAgICAg
IGFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2LCAwLCBpLCAwKTsNCg0KICAgICAgICAvKiBU
T0RPOiBpbml0IHBvd2VyIGdhdGluZyAqLw0KLSAgICAgICByZXR1cm47DQorICAgICAgIHJldHVy
biAwOw0KIH0NCg0KIHZvaWQgZ2Z4X3YxMF8wX3JsY19zdG9wKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KSBAQCAtMTkxMSw3ICsxOTM2LDEwIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JsY19y
ZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogICAgICAgICAgICAgICAgciA9IGdm
eF92MTBfMF93YWl0X2Zvcl9ybGNfYXV0b2xvYWRfY29tcGxldGUoYWRldik7DQogICAgICAgICAg
ICAgICAgaWYgKHIpDQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcjsNCi0gICAgICAg
ICAgICAgICBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsNCisNCisgICAgICAgICAgICAgICByID0g
Z2Z4X3YxMF8wX2luaXRfcGcoYWRldik7DQorICAgICAgICAgICAgICAgaWYgKHIpDQorICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gcjsNCg0KICAgICAgICAgICAgICAgIC8qIGVuYWJsZSBS
TEMgU1JNICovDQogICAgICAgICAgICAgICAgZ2Z4X3YxMF8wX3JsY19lbmFibGVfc3JtKGFkZXYp
OyBAQCAtMTkzNyw3ICsxOTY1LDEwIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JsY19yZXN1bWUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiByOw0KICAgICAgICAgICAgICAgIH0NCg0KLSAgICAgICAgICAgICAgIGdmeF92
MTBfMF9pbml0X3BnKGFkZXYpOw0KKyAgICAgICAgICAgICAgIHIgPSBnZnhfdjEwXzBfaW5pdF9w
ZyhhZGV2KTsNCisgICAgICAgICAgICAgICBpZiAocikNCisgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiByOw0KKw0KICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5ybGMuZnVuY3MtPnN0YXJ0
KGFkZXYpOw0KDQogICAgICAgICAgICAgICAgaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9
PSBBTURHUFVfRldfTE9BRF9STENfQkFDS0RPT1JfQVVUTykgew0KLS0NCjIuMjAuMQ0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
