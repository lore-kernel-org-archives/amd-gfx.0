Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A765CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 16:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F015208C0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 16:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F015208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88206E98C;
	Mon, 28 Oct 2019 16:49:24 +0000 (UTC)
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr810073.outbound.protection.outlook.com [40.107.81.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB946E98C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 16:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxfhtS96B//+jdtbO7c1iQ9YVxIp3qTekyzKMH/os1S967/5XQCniMqUOeSbXx4RSVproMrKLBUuQJ2rZiQZobzSTDH1+aYUXNRSWrLPbtqLv6Y0Zbz1G0+WA1t4S1K1WHaY5UmauITFwOvsoeezKMFyQpazH15jXV91nzSMjWdEKdiUxW4pF3jHJ7dj6r56mmqpNN4UUy9mBmf+Jij9vMdbSep7A8plYK9w+LtCRUSP2jlzHA4UFPQ51GIxAtRZiQ9AUfx3i0ll1E9q8UdWtxGVpeebguVmXEEbceLbk9hSfs7X5lNqn0k3setixrHPuG/elL5FNj6ZZPdIEjYgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDWSRBMkvRQtOF+sXU01WyuXnNQ/bele23Gx30Zvtvw=;
 b=bk5jSL9u28gvDs26MbYoeeCtWnKLzuUMpCyToMfaaodqk6QJLIvDMc2KUI0h3W39WjkMoyQT1UaEWSD23rYtZvJc9JzQIIf4DSjMSuxJgCAZrGL1GkA/FQeXHjA5dHICSNLDTlI3esvFPSGRyOHaYS9COMXjUrIIbvbF7XN7x71xNCMMJ5zqsr0I0rBBlJEVrg2s3cpffP+K6eNWUAVpirVUFGzrSLR7r0ZIJ0nKW2cKVqjv91PDjt99ulxGY33IafL2wChFgVmMGelYVE5cFNfAQQGChhsdZ97M39XCBs1ZInIWaSY+XA5cjLVEDHgtql8MY0c2CTxHcR6R9LK5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB2793.namprd12.prod.outlook.com (20.176.114.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 16:49:18 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 16:49:18 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Delete duplicated queue bit map reservation
Thread-Topic: [PATCH] drm/amdkfd: Delete duplicated queue bit map reservation
Thread-Index: AQHViq/+pfN5s8nB6Uef1g1LFxHsWqdwSeQA
Date: Mon, 28 Oct 2019 16:49:18 +0000
Message-ID: <aaf8a526-0b98-23af-f345-f7f9738435f8@amd.com>
References: <20191024211402.29915-1-Yong.Zhao@amd.com>
In-Reply-To: <20191024211402.29915-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d938dde6-14b5-4cb1-46c1-08d75bc6c658
x-ms-traffictypediagnostic: DM6PR12MB2793:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB279387A73BF72CADBA4B50B592660@DM6PR12MB2793.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(199004)(305945005)(26005)(36756003)(71200400001)(186003)(86362001)(11346002)(478600001)(6436002)(71190400001)(7736002)(66066001)(65956001)(65806001)(6246003)(31686004)(31696002)(476003)(8936002)(81166006)(2616005)(81156014)(25786009)(4001150100001)(446003)(8676002)(229853002)(64756008)(66446008)(6506007)(66476007)(6512007)(66556008)(66946007)(76176011)(2906002)(53546011)(3846002)(486006)(316002)(6116002)(386003)(52116002)(99286004)(14454004)(5660300002)(58126008)(6486002)(102836004)(2501003)(110136005)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2793;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/sMO5y1sIZ3DE5Alj6xXY4xAallsvIu4YajfrNITjMIbfUKQfNtFQKwFITNt7q5XDxC0cUm5mHBS6j6zaHSnHMKgiMpMW+yerHyEpjR2eyQW3saViEnhhwZPnjF2qPN6Yt/2bk2dpIyyfQ7DGEY2aO+2NDSOgs8OBVPdjtX2ruk65APAxVO2wJ0jOuU6F/G5mnciFTgpPkteaLKa4KP4nPgHgcgLaT9OhrPK7MY8JaceR/0if5kawsT2Tg/jhTSPGWffO0By9yO7tE7ZwxSiNb6vB2yBsoqzbEFDHCB9TXl9i7n6vQ1C3BjQS9kKjwWPWBpAzM8wntg6IJqZixLKdxFOR9W7LedeLwxQ0/RChksfWqOtjRGv2sHugA/ykHb7+Bovx/SD9ZtyT34tOlTI1jXNfpcMznddq4fdH4WdKhM6G2nAqhj7M4X3D2ddW4t
Content-ID: <B824EE0E2D04AE48B794789E496B405C@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d938dde6-14b5-4cb1-46c1-08d75bc6c658
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 16:49:18.7169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTMpbwKZyRRogRrfB/i1+j/JN8F8CgvM31hoAWZy6IiPQQdphLn8Cr3ty6tSBrfuAm3D0PkeqWXNj7fb0CP/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2793
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDWSRBMkvRQtOF+sXU01WyuXnNQ/bele23Gx30Zvtvw=;
 b=Ffw4gblY6XLsWa9xQw27JFshrYFphHZRu5aOS7cVWUMdwP832b3EdO5D3bYatH6HLuvkxlSuyHBwR2f6DaMkT/XXuDuR9aNeuVgCXCYWWgxuLh4kG47Eg+0WUib1gKR4C6bD1G+FCwu20QOIgDwXnGB/Zk6ghcl99K2XMGIsC4E=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Message-ID: <20191028164918.S7OHh1dQ9afOVsmhXO1EJRF6yXIRpha4eHDV9ZLGCqo@z>

T24gMjAxOS0xMC0yNCA1OjE0IHAubS4sIFpoYW8sIFlvbmcgd3JvdGU6DQo+IFRoZSBLSVEgaXMg
b24gdGhlIHNlY29uZCBNRUMgYW5kIGl0cyByZXNlcnZhdGlvbiBpcyBjb3ZlcmVkIGluIHRoZQ0K
PiBsYXR0ZXIgbG9naWMsIHNvIG5vIG5lZWQgdG8gcmVzZXJ2ZSBpdHMgYml0IHR3aWNlLg0KPg0K
PiBDaGFuZ2UtSWQ6IEllZWUzOTA5NTNhNjBjN2Q0M2RlNWE5YWVjMzg4MDNmMWY1ODNhNGE5DQo+
IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+DQoNClJldmlld2Vk
LWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCg0KDQo+IC0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDggLS0tLS0t
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KPiBpbmRleCA4YzUzMTc5M2ZlMTcuLmQz
ZGE5ZGRlNGVlMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmQuYw0KPiBAQCAtMTMwLDE0ICsxMzAsNiBAQCB2b2lkIGFtZGdwdV9hbWRrZmRfZGV2aWNl
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgCQkJCSAgYWRldi0+Z2Z4Lm1l
Yy5xdWV1ZV9iaXRtYXAsDQo+ICAgCQkJCSAgS0dEX01BWF9RVUVVRVMpOw0KPiAgIA0KPiAtCQkv
KiByZW1vdmUgdGhlIEtJUSBiaXQgYXMgd2VsbCAqLw0KPiAtCQlpZiAoYWRldi0+Z2Z4LmtpcS5y
aW5nLnNjaGVkLnJlYWR5KQ0KPiAtCQkJY2xlYXJfYml0KGFtZGdwdV9nZnhfbWVjX3F1ZXVlX3Rv
X2JpdChhZGV2LA0KPiAtCQkJCQkJCSAgYWRldi0+Z2Z4LmtpcS5yaW5nLm1lIC0gMSwNCj4gLQkJ
CQkJCQkgIGFkZXYtPmdmeC5raXEucmluZy5waXBlLA0KPiAtCQkJCQkJCSAgYWRldi0+Z2Z4Lmtp
cS5yaW5nLnF1ZXVlKSwNCj4gLQkJCQkgIGdwdV9yZXNvdXJjZXMucXVldWVfYml0bWFwKTsNCj4g
LQ0KPiAgIAkJLyogQWNjb3JkaW5nIHRvIGxpbnV4L2JpdG1hcC5oIHdlIHNob3VsZG4ndCB1c2Ug
Yml0bWFwX2NsZWFyIGlmDQo+ICAgCQkgKiBuYml0cyBpcyBub3QgY29tcGlsZSB0aW1lIGNvbnN0
YW50DQo+ICAgCQkgKi8NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
