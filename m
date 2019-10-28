Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF714CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A130214D9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A130214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482856E605;
	Mon, 28 Oct 2019 11:53:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35926E605
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 11:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO61vSovj0SM6j29kMnEYmnRXOT5FgEmCxp3Lyu7ar1VLviqnUJ20E9KMMsRWQL/Odlt2qSVl4MD4Kv7+oiY0GmSQItaa3PxXVTBjDtbw/B9Lx2fg6v13cC4uyxp0ZXPztr27GPmB2csl33VQVMAAYdvYrNTq3wLTHVx+cR85DiMAkWBKLFdekg92VGE2QNMifMSYUsndVclYBe8Nw02sAI/xpXelHIHvUEiAB30S9ZgZiqCywamxCRu5a5kKzAoZsV892nveSqHIIrgWk3eyRVRn8v7hL7FhRKiMHAzNGUXRgrt8nqQXMu2JvAaPBxVMe8MkNnlDsvQGtMoxAmrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6bKUTNTkxPzorMM69E545l6A2VLxbl4+jjRaLreY7E=;
 b=jAT671/ntvzUyym3LaXJdKP3FC79V4Ne96hN2y7HwPYFsaytHsFTkf3KfyQsgK9yikn1T13G0mD5IphUQL6Jhd9o2qH2l0VvzUEjxzoFK1impQvCbvn/gr/r74PYbBfIQ+3i9xqzidYNsv5XT6RstztIJHmjiMpdn2Rqfq8ZvrfAZBhlIFaQ7QoQLr5Xhs4lYsP7PIPFheO/Wn/pmfinb9m7fO2TTVscnUbpYTZ1aXSu0XCtO3eKtmzWpCFScqOhUoodAMTOAPZocBl03U4esKAb58GpVrQpnUQcIof9kxP3XyKsWn1VZnDMhOIDmlXvUkvS/DQaeGqCi5ZiXf2XhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1689.namprd12.prod.outlook.com (10.172.33.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 11:53:06 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f%5]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 11:53:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: clear UVD VCPU buffer when
 err_event_athub generated
Thread-Topic: [PATCH 1/4] drm/amdgpu: clear UVD VCPU buffer when
 err_event_athub generated
Thread-Index: AQHVjYM5dj06M3JXIUyzlIVc036Eeqdv77Ug
Date: Mon, 28 Oct 2019 11:53:06 +0000
Message-ID:
 <DM5PR12MB1418C6FCFC6F88C3569BFABCFC660@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1572262269-14985-1-git-send-email-le.ma@amd.com>
In-Reply-To: <1572262269-14985-1-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99d3934a-0576-495f-7bea-08d75b9d658f
x-ms-traffictypediagnostic: DM5PR12MB1689:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1689BB423B9D2382AB223AA5FC660@DM5PR12MB1689.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(13464003)(966005)(6306002)(55016002)(52536014)(305945005)(6436002)(9686003)(6246003)(76176011)(110136005)(99286004)(7736002)(7696005)(74316002)(8676002)(316002)(4326008)(81156014)(478600001)(8936002)(66066001)(81166006)(186003)(5660300002)(476003)(66446008)(86362001)(66946007)(229853002)(66556008)(64756008)(14444005)(76116006)(446003)(25786009)(486006)(6116002)(11346002)(3846002)(2501003)(33656002)(71200400001)(71190400001)(102836004)(53546011)(26005)(66476007)(6506007)(256004)(2906002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1689;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHnW7jp64ddrJBwO1mJmZYLZyAJpVdxgVMLcLhEEh+ANHAxNSWklfO6lbAbUd6Y7ImlWtfdmPG9IKWsrJaUFE8Yyqx+kFFNY2lrC+KcRyJuN213GAuvAxY9SD/mmx6rz5b2qRu6Jw+wkkVLgXvEG60amYaau8Sq0KJoevCkEtwowefZWSb7vuDHZOLI3kucaQhX0cPs/C+u3StJbFrLRPZ1Fl8D2qNK6239MxkACfdMQOWSZNdUllDoGj8cUVw3ZucTrIaGm3J7sEs+rvPqmABELWjAq7ngJqnp5FCMXXvZmEAkIrd135uodcXmcEQjOISnzqGOilz5ndMCHkXm8PzL8qiY2SmHbFtKmqYeNH513dN1J9QXF5onB1Ro+JEam9XpoZD9g99A8phZfMfXJkN4Wr5XTUkR8hKOEtMQBEtwS/e9E94BfH2wFBf/iSlOHoihsk4+RKF0SJUGtkdv7kHIvmE/3ReuFpQQ8/To0W64=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d3934a-0576-495f-7bea-08d75b9d658f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 11:53:06.5790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HerUcSA5trrkkwk9aQ8Ryjv9dperWKpv4kFr+9FGV7ZG5TPrW5oeP980SYtiN5RoHWTzsIaWiEs+vv8uU7owTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1689
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6bKUTNTkxPzorMM69E545l6A2VLxbl4+jjRaLreY7E=;
 b=oONuIi44HUDCAzd2YJtp2PJpcwWz6oOXCN5ebAkEllemTnjjsls3NpSN2/4gOhSDXzrmxRz+HB2Td7T/V74UsZubHQPufelWxwpM/PnE4vtmPVNxh8HOte8lkPnpgGy2ip4JnQ4I/uUreTGmD3h9vWWtWEhX+49A2AnnhZMW9k8=
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
Cc: "Ma, Le" <Le.Ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028115306.IufysjnhfBmeeaoG9uKwcJ-fhbOSe8SXsIw6zRUdxeQ@z>

V2Ugc2hvdWxkIGhvbGQgb24gcGF0Y2ggIzIgYW5kIHBhdGNoICM0IHVudGlsIHdlIGhhdmUgYmFj
byBiYXNlZCBSQVMgcmVjb3Zlcnkgd29ya3Mgc2luY2UgY3VycmVudCByYXMgcmVjb3ZlcnkgcG9s
aWN5IGlzIGNoYW5nZWQgYnkgdGhlc2UgdHdvIHBhdGNoZXMuIA0KDQpPdGhlciB0aGFuIHRoYXQs
IHRoZSBTZXJpZXMgaXMNClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g
T24gQmVoYWxmIE9mIExlIE1hDQpTZW50OiAyMDE55bm0MTDmnIgyOOaXpSAxOTozMQ0KVG86IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTWEsIExlIDxMZS5NYUBhbWQuY29tPg0K
U3ViamVjdDogW1BBVENIIDEvNF0gZHJtL2FtZGdwdTogY2xlYXIgVVZEIFZDUFUgYnVmZmVyIHdo
ZW4gZXJyX2V2ZW50X2F0aHViIGdlbmVyYXRlZA0KDQpUaGUgZXJyX2V2ZW50X2F0aHViIGVycm9y
IHdpbGwgbWVzcyB1cCB0aGUgYnVmZmVyIGFuZCBjYXVzZSBVVkQgcmVzdW1lIGhhbmcuDQoNCkNo
YW5nZS1JZDogSWYxN2EyMTYxZmI5YjFiNTJlYWMwOGRlMDBkMmU5MzUxOTFiZGJmOTkNClNpZ25l
ZC1vZmYtYnk6IExlIE1hIDxsZS5tYUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3V2ZC5jIHwgMTAgKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91dmQuYw0KaW5kZXggYjJjMzY0Yi4uYjRkZDg5YSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jDQpAQCAtMzksNiArMzksOCBAQA0KICNpbmNsdWRlICJj
aWtkLmgiDQogI2luY2x1ZGUgInV2ZC91dmRfNF8yX2QuaCINCiANCisjaW5jbHVkZSAiYW1kZ3B1
X3Jhcy5oIg0KKw0KIC8qIDEgc2Vjb25kIHRpbWVvdXQgKi8NCiAjZGVmaW5lIFVWRF9JRExFX1RJ
TUVPVVQJbXNlY3NfdG9famlmZmllcygxMDAwKQ0KIA0KQEAgLTM3Miw3ICszNzQsMTMgQEAgaW50
IGFtZGdwdV91dmRfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJCWlmICgh
YWRldi0+dXZkLmluc3Rbal0uc2F2ZWRfYm8pDQogCQkJcmV0dXJuIC1FTk9NRU07DQogDQotCQlt
ZW1jcHlfZnJvbWlvKGFkZXYtPnV2ZC5pbnN0W2pdLnNhdmVkX2JvLCBwdHIsIHNpemUpOw0KKwkJ
LyogcmUtd3JpdGUgMCBzaW5jZSBlcnJfZXZlbnRfYXRodWIgd2lsbCBjb3JydXB0IFZDUFUgYnVm
ZmVyICovDQorCQlpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKSB7DQorCQkJRFJNX1dB
Uk4oIlVWRCBWQ1BVIHN0YXRlIG1heSBsb3N0IGR1ZSB0byBSQVMgRVJSRVZFTlRfQVRIVUJfSU5U
RVJSVVBUXG4iKTsNCisJCQltZW1zZXQoYWRldi0+dXZkLmluc3Rbal0uc2F2ZWRfYm8sIDAsIHNp
emUpOw0KKwkJfSBlbHNlIHsNCisJCQltZW1jcHlfZnJvbWlvKGFkZXYtPnV2ZC5pbnN0W2pdLnNh
dmVkX2JvLCBwdHIsIHNpemUpOw0KKwkJfQ0KIAl9DQogCXJldHVybiAwOw0KIH0NCi0tIA0KMi43
LjQNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFt
ZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
