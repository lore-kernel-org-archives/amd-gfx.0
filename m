Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E471C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF4F223B0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF4F223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AC86E0EF;
	Wed, 20 Nov 2019 08:43:42 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740053.outbound.protection.outlook.com [40.107.74.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A706E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 08:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibmqH6aTV6IzMqMiUwXzs0SUWyw7F6RwuQ83c7wPX+P7q2nfE7qYp0cMiXoSAuVsywsnQJWPV7gH0f5L8Xth5COW2XRKPEGl+p0yacVy8NW+0GNkQ0FXb5icm8XRqTSC7djc6cxvZly/wlFyaV3WNA4+6YCdTlDXT1Atg3aF20++5D6U+GIVuNXqaoLv4e7y9H+BAh9D1IZ04FmiHSSsTLyjF7Tc2Pv+OQ03gH1Xg565KJpc30CToowCxZZom/wKOiflI8GDZbI1VgC0jG98Vg3FxSkXKH1YJnrduCjLlnkV6P7gZqdklyLXK/h7JFhKo1q4pATOh4I31wWuQi3fMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvBfl9U7EpzRvjcCiDJSsBt/hNFWxq4oxhiuSyEZaac=;
 b=HyDdRqn9/6WIFoFiHoZZHQNakM52lReNj0E/Fw7J8gNoSAvqnsNdwOUpHrHNrRjLzfwilh95biuum7JVJiYRWWSWyH06Atbo4FagupGEPmiZ12WpRfNekhHcPbhGekfACUwT3MNqqo4sv40WjCdlPKqmr35xtUkBvMnBHOGgEi+M9BwqHl3E4pnTFa1y5ThAh6KDuVt5eHuB16nQcoCoR2aoQR9rxiSD3/x+XUvlEKZrZ2AJ1+UudPEvGktA0DOHoun7dd9lkMxcVKS8JUINczGuEF8CzXLXnDjT/eznR8KCwR7R1IWOYIU/c8JxvocOTOl+q2i6MkFJWDBPVG0AEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2424.namprd12.prod.outlook.com (52.132.142.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 08:43:39 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 08:43:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Topic: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Index: AQHVn25hgnJp5nBSs0qXI2gya/dmz6eTvYcw
Date: Wed, 20 Nov 2019 08:43:39 +0000
Message-ID:
 <DM5PR12MB1418A32EB8199ABFFCCAEC04FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191120064701.2765-1-xiaojie.yuan@amd.com>
In-Reply-To: <20191120064701.2765-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1155b3e1-00c2-4423-6b62-08d76d95bd98
x-ms-traffictypediagnostic: DM5PR12MB2424:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB24243E18842D99990C7048E2FC4F0@DM5PR12MB2424.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:200;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(13464003)(8936002)(33656002)(2501003)(256004)(81156014)(8676002)(14444005)(81166006)(229853002)(6436002)(86362001)(7736002)(14454004)(2906002)(5660300002)(52536014)(478600001)(76116006)(3846002)(6116002)(25786009)(66946007)(64756008)(74316002)(54906003)(186003)(66446008)(66556008)(66476007)(305945005)(6506007)(316002)(4326008)(53546011)(26005)(71190400001)(110136005)(71200400001)(102836004)(6246003)(76176011)(66066001)(99286004)(446003)(11346002)(476003)(7696005)(486006)(9686003)(55016002)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2424;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mE5MQlh4n5GeNVIKoolko8yrhQ1OEfyFfY+e65S0LXKvAGSbsD24ql8QpHEapDn6VCyn4hNswcX2H6A6GPp5yEaisMz4REgHrC0c8valSSUPwhOeeHqMJhlQCD0Hs4qoe9xsYloWyVg9Irh6M+8+LVkS4XOA8Wo/mNfu4Ru9qOEqXo2z6htoyqwReDBTSwPj9eBjcqwBdtFViyiMfIvi/tCFojuP5uKIssOwJWHFu0lBnEXXyQFByoAx47T29SLNeM+VTgnK7/Q9UUG4kbb8l7Zrk+7/a78d6OLf3UL91yvGPEjyWFt+EvzWBJvIDKDxlp39fGQdECMqW9jQ3Q6FG7zvuuyDIEmPg+cZbqsPoCauHQMJCIJZZdqH1PCtuOrtJdzCzJv847rQ2TCIVTJvyadwunZ76RA8EaRuI9wNEQAj/CVXyxXfwiOVSgTa97Wh
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1155b3e1-00c2-4423-6b62-08d76d95bd98
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 08:43:39.2462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/xYjD/Q6da1mmnuao6NTRPbKFUR5VDYhFDaNjlCjOq0gCO+iSMw4MEGRqISuKTvVwLsKK6wxDQxGIKlPE41zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvBfl9U7EpzRvjcCiDJSsBt/hNFWxq4oxhiuSyEZaac=;
 b=vPu/BdCk6r+GAu/GUazrRx3uRXkEBkM7ADff72tKd6JLnGubuG2Xf/yBg2CacXBzZHQJXB0JZ1pciffc7VQFU3/PgrW83qD44wQufSgyVlTeBpsjsb/bbFtHuSQitcs32q7xFmJPqVYF05IH0WZu17Btk0ycnce5pDzPTi4mt44=
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
Message-ID: <20191120084339.A3G75D1tN-IVv0RiHOZffXYHfm81Inp4ypHEFqcxZPk@z>

SnVzdCBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0bHkuIFNvIHVudGlsIGZ3IHRl
YW0gcm9vdCBjYXVzZSB0aGUgcmVhc29uIG9mIGNzYiBjb3JydXB0aW9uLCB3ZSBrZWVwIHRoZSB3
b3JrYXJvdW5kIGluIGRyaXZlciwgY29ycmVjdD8NCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBZdWFuLCBYaWFvamllIDxYaWFvamllLll1YW5A
YW1kLmNvbT4gDQpTZW50OiAyMDE55bm0MTHmnIgyMOaXpSAxNDo0Nw0KVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1k
LmNvbT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgTG9uZywgR2FuZyA8R2FuZy5M
b25nQGFtZC5jb20+OyBZdWFuLCBYaWFvamllIDxYaWFvamllLll1YW5AYW1kLmNvbT4NClN1Ympl
Y3Q6IFtQQVRDSF0gZHJtL2FtZGdwdS9nZngxMDogcmUtaW5pdCBjbGVhciBzdGF0ZSBidWZmZXIg
YWZ0ZXIgZ3B1IHJlc2V0DQoNClRoaXMgcGF0Y2ggZml4ZXMgMm5kIGJhY28gcmVzZXQgZmFpbHVy
ZSB3aXRoIGdmeG9mZiBlbmFibGVkIG9uIG5hdmkxeC4NCg0KY2xlYXIgc3RhdGUgYnVmZmVyIChy
ZXNpZGVzIGluIHZyYW0pIGlzIGNvcnJ1cHRlZCBhZnRlciAxc3QgYmFjbyByZXNldCwgdXBvbiBn
ZnhvZmYgZXhpdCwgQ1BGIGdldHMgZ2FyYmFnZSBoZWFkZXIgaW4gQ1NJQiBhbmQgaGFuZ3MuDQoN
ClNpZ25lZC1vZmYtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+DQotLS0N
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDQzICsrKysrKysrKysr
KysrKysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQppbmRleCA5
Mjc0YmQ0YjZjNjguLjhlMjRlYTA4Y2EzOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYw0KQEAgLTE3ODksMjcgKzE3ODksNTIgQEAgc3RhdGljIHZvaWQgZ2Z4X3YxMF8w
X2VuYWJsZV9ndWlfaWRsZV9pbnRlcnJ1cHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQog
CVdSRUczMl9TT0MxNShHQywgMCwgbW1DUF9JTlRfQ05UTF9SSU5HMCwgdG1wKTsgIH0NCiANCi1z
dGF0aWMgdm9pZCBnZnhfdjEwXzBfaW5pdF9jc2Ioc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
DQorc3RhdGljIGludCBnZnhfdjEwXzBfaW5pdF9jc2Ioc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQogew0KKwlpbnQgcjsNCisNCisJaWYgKGFkZXYtPmluX2dwdV9yZXNldCkgew0KKwkJciA9
IGFtZGdwdV9ib19yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqLCBmYWxzZSk7
DQorCQlpZiAocikNCisJCQlyZXR1cm4gcjsNCisNCisJCXIgPSBhbWRncHVfYm9fa21hcChhZGV2
LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaiwNCisJCQkJICAgKHZvaWQgKiopJmFkZXYtPmdmeC5y
bGMuY3NfcHRyKTsNCisJCWlmICghcikgew0KKwkJCWFkZXYtPmdmeC5ybGMuZnVuY3MtPmdldF9j
c2JfYnVmZmVyKGFkZXYsDQorCQkJCQlhZGV2LT5nZngucmxjLmNzX3B0cik7DQorCQkJYW1kZ3B1
X2JvX2t1bm1hcChhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7DQorCQl9DQorDQorCQlh
bWRncHVfYm9fdW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsNCisJCWlm
IChyKQ0KKwkJCXJldHVybiByOw0KKwl9DQorDQogCS8qIGNzaWIgKi8NCiAJV1JFRzMyX1NPQzE1
KEdDLCAwLCBtbVJMQ19DU0lCX0FERFJfSEksDQogCQkgICAgIGFkZXYtPmdmeC5ybGMuY2xlYXJf
c3RhdGVfZ3B1X2FkZHIgPj4gMzIpOw0KIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NTSUJf
QUREUl9MTywNCiAJCSAgICAgYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9ncHVfYWRkciAmIDB4
ZmZmZmZmZmMpOw0KIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NTSUJfTEVOR1RILCBhZGV2
LT5nZngucmxjLmNsZWFyX3N0YXRlX3NpemUpOw0KKw0KKwlyZXR1cm4gMDsNCiB9DQogDQotc3Rh
dGljIHZvaWQgZ2Z4X3YxMF8wX2luaXRfcGcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQor
c3RhdGljIGludCBnZnhfdjEwXzBfaW5pdF9wZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikN
CiB7DQogCWludCBpOw0KKwlpbnQgcjsNCiANCi0JZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYpOw0K
KwlyID0gZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYpOw0KKwlpZiAocikNCisJCXJldHVybiByOw0K
IA0KIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX3ZtaHViczsgaSsrKQ0KIAkJYW1kZ3B1X2dt
Y19mbHVzaF9ncHVfdGxiKGFkZXYsIDAsIGksIDApOw0KIA0KIAkvKiBUT0RPOiBpbml0IHBvd2Vy
IGdhdGluZyAqLw0KLQlyZXR1cm47DQorCXJldHVybiAwOw0KIH0NCiANCiB2b2lkIGdmeF92MTBf
MF9ybGNfc3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgQEAgLTE5MTEsNyArMTkzNiwx
MCBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9ybGNfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQ0KIAkJciA9IGdmeF92MTBfMF93YWl0X2Zvcl9ybGNfYXV0b2xvYWRfY29tcGxldGUo
YWRldik7DQogCQlpZiAocikNCiAJCQlyZXR1cm4gcjsNCi0JCWdmeF92MTBfMF9pbml0X3BnKGFk
ZXYpOw0KKw0KKwkJciA9IGdmeF92MTBfMF9pbml0X3BnKGFkZXYpOw0KKwkJaWYgKHIpDQorCQkJ
cmV0dXJuIHI7DQogDQogCQkvKiBlbmFibGUgUkxDIFNSTSAqLw0KIAkJZ2Z4X3YxMF8wX3JsY19l
bmFibGVfc3JtKGFkZXYpOw0KQEAgLTE5MzcsNyArMTk2NSwxMCBAQCBzdGF0aWMgaW50IGdmeF92
MTBfMF9ybGNfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIAkJCQlyZXR1cm4g
cjsNCiAJCX0NCiANCi0JCWdmeF92MTBfMF9pbml0X3BnKGFkZXYpOw0KKwkJciA9IGdmeF92MTBf
MF9pbml0X3BnKGFkZXYpOw0KKwkJaWYgKHIpDQorCQkJcmV0dXJuIHI7DQorDQogCQlhZGV2LT5n
ZngucmxjLmZ1bmNzLT5zdGFydChhZGV2KTsNCiANCiAJCWlmIChhZGV2LT5maXJtd2FyZS5sb2Fk
X3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUkxDX0JBQ0tET09SX0FVVE8pIHsNCi0tDQoyLjIwLjEN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
