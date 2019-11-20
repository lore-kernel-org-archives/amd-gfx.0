Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD25C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED5621852
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED5621852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462F46E116;
	Wed, 20 Nov 2019 08:40:38 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790084.outbound.protection.outlook.com [40.107.79.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649E66E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 08:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzD5F92kGDSrgVpZwD2TzbCsgrUNKk71PZoOokcaHJNlXe/9KVyB1xN1mRvjdEEKe0ymSnPMndclGf8DSIDvG1APm2tMlgIQ/2T7DQFjYGBfbh1XGs+sfbKouENsxuDCpIZj430nRSUWzmlwGWHQmfJz3vyCpasJ/GkU7c6TbuFUTINdU6nn0rvm3VqO2TdALkKJ9fG0Lzh0TUuS9PtExBPo6Ce5jUfcr+v67kI+XHFTvYDxcSsoGOaNJXCuz4LU/1N8lfAHEHwrb4NJw+FbckfTcKjuD4M4NqqJjzt0SmmHG/MdabCL9WI6XWwzdeIYOiNEAO/1roS9ervZDrBUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQJreku+9lYHfaEvp9L8zpL+nDXmo2Cz27nZ8EEOQHc=;
 b=SG/RpWFUngE+BM46HbRo9AXfEzKvBvBA69nOrDDvd6oyYfXf/a3Cx9g6EPYsEjF7uppRGXiNEpMeD4dYPqP+cHehTALXqTKkGE6wBDe6zlOsA8gN0x1nnBYAq+BAyZN+BqU20j7ZL1cDBST9ggrAUprajGlltOWfkSm7ooR9xG4HjxMerjWxwugBluhIw7CJOpkLIZGf0TGpdtMuMERs2rxr6z53sIBULDjuBIyRwvmvbOwnSLNykPy4ztvuHW+8IjhrDs4UaxgpaScXapa5Dnw4C85sq3IoNHQb3R5pJ3m3VZ/wqUBeYWvUXuyx33YqhA8Zunhvm8W6ZgmO/GQpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2424.namprd12.prod.outlook.com (52.132.142.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 08:40:35 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 08:40:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: fix out-of-bound mqd_backup array access
Thread-Topic: [PATCH] drm/amdgpu/gfx10: fix out-of-bound mqd_backup array
 access
Thread-Index: AQHVn25+gzlpDSeQPE6XyelaHZZOT6eTvWLQ
Date: Wed, 20 Nov 2019 08:40:35 +0000
Message-ID:
 <DM5PR12MB1418BBE5BA1C6D7FFC0C5052FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191120064753.3020-1-xiaojie.yuan@amd.com>
In-Reply-To: <20191120064753.3020-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d72a65a3-f441-4c43-c668-08d76d954fca
x-ms-traffictypediagnostic: DM5PR12MB2424:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2424C2361A1D4EED88A569A1FC4F0@DM5PR12MB2424.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(13464003)(8936002)(33656002)(2501003)(256004)(81156014)(8676002)(14444005)(81166006)(229853002)(6436002)(86362001)(7736002)(14454004)(2906002)(5660300002)(52536014)(478600001)(966005)(76116006)(3846002)(6116002)(25786009)(66946007)(64756008)(74316002)(186003)(66446008)(66556008)(66476007)(305945005)(6506007)(316002)(4326008)(53546011)(26005)(71190400001)(110136005)(71200400001)(102836004)(6246003)(76176011)(66066001)(99286004)(446003)(11346002)(476003)(7696005)(486006)(9686003)(6306002)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2424;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4divuhgVwtqr3zItOVe46b72Ukxn30Xv4IEW6i82z+5f+vao716G1nyivLPqmZaShQsn7YHr/V4DnIodBwBt3D3AxdC7E4Rpa2fMf8tylw5fdqQHwuwoujxpt48tKjs5hzcxes/M3CgLSaT86D/nC3jQwz1rJJSFuCyZgTMdr+Y9JCOWqrw1TzsVgERp1bfgd3vGPQMC1Dwnjvqgve0edG/c5GaF6IZ6+HRBYqEpTm6lHjqDBLmSjF3waxw60nwnmxwj9A6qnEdLDNn6CInUC3pOoGMatzuq28J5U+jvApQiGiL2C7pc8PcfyHN9S39YnEfnF89ZM55iHNP9BCD/jSBU9zWkRPZNqjJTZCojti4zpnJiUT61q7ZWgmtUKDvmaSxCYIzNibTn/72QaH0u4HiS06aEfZBAiw294vIKy18Rf+vNq96Xv9qppsx8uHvQw00gVqF0ld2yQ5NAZpT5S6RDMtRIsWuOX+qRmEVPxkE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72a65a3-f441-4c43-c668-08d76d954fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 08:40:35.0819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lg8dnTtM816gVHnhYCjC5WRN4ZRL/rdzxtcQGCoTZa6dZVv46S69oaxV7zgBpVWA6502mEAlzqztnGE8ttG0vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQJreku+9lYHfaEvp9L8zpL+nDXmo2Cz27nZ8EEOQHc=;
 b=nLElXJhQhKBak3TucU4PRG84Jf/fYlGi+6QgVJYmJZS17uxFiEOpRcf3HHtPlZfFU/uKI6+pqfNEJMA3MovtwZllSHKsHiUarpZOnhzJBl8n0Gd/oLwBBrblalsAZDn43dIRGlyGSEaEX5btX2m33LY++vAylXVQIOqd4dNJ8ug=
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
Cc: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120084035.-gEi4Qnlj-zGw7ODlBN7WHc-_jwi3gEevLOlwtI3sJY@z>

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVn
YXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgWGlh
b2ppZSBZdWFuDQpTZW50OiAyMDE55bm0MTHmnIgyMOaXpSAxNDo0OA0KVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5j
b20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHUvZ2Z4MTA6IGZpeCBvdXQtb2YtYm91bmQg
bXFkX2JhY2t1cCBhcnJheSBhY2Nlc3MNCg0KRml4ZXM6IDQ5OTBmOTU3Yzg0NSAoImRybS9hbWRn
cHUvZ2Z4MTA6IGZpeCBtcWQgYmFja3VwL3Jlc3RvcmUgZm9yIGdmeCByaW5ncyIpDQpTaWduZWQt
b2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgMiAtLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dmeC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5j
DQppbmRleCBhNDkyMTc0ZWYyOWIuLjUyYzI3ZTQ5YmM3YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQpAQCAtNDU0LDggKzQ1NCw2IEBAIHZvaWQgYW1kZ3B1X2dm
eF9tcWRfc3dfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJfQ0KIA0KIAlyaW5n
ID0gJmFkZXYtPmdmeC5raXEucmluZzsNCi0JaWYgKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX05B
VkkxMCAmJiBhbWRncHVfYXN5bmNfZ2Z4X3JpbmcpDQotCQlrZnJlZShhZGV2LT5nZngubWUubXFk
X2JhY2t1cFtBTURHUFVfTUFYX0dGWF9SSU5HU10pOw0KIAlrZnJlZShhZGV2LT5nZngubWVjLm1x
ZF9iYWNrdXBbQU1ER1BVX01BWF9DT01QVVRFX1JJTkdTXSk7DQogCWFtZGdwdV9ib19mcmVlX2tl
cm5lbCgmcmluZy0+bXFkX29iaiwNCiAJCQkgICAgICAmcmluZy0+bXFkX2dwdV9hZGRyLA0KLS0g
DQoyLjIwLjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
