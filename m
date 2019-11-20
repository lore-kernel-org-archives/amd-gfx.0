Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDDDC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 11:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6C6223D0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 11:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6C6223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D166E264;
	Wed, 20 Nov 2019 11:15:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680084.outbound.protection.outlook.com [40.107.68.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A369D6E264
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 11:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgbefAaO5oPJ4x6MkGXDdv50YcQrJFc8z8DA4eXjv5o76hJAgTP7YZttAY/P+aoxMghf6jlSnaVICNLglc9UBKzaWlO7TGAIAx2eZLChOyTOR4kUYDsFrPS5qDfrmSbR5An3WP2W0Yk3WxCmUoVg8+C3+NwVNlk0G5E9Vj/v0bCrG8IF7+uWWZg2Dt1zYYlS7XXRKT/oTuqjGsBzJwEs++EHBbZyBbUYzAwogWdSMPChg6MgbZvVTwvHmo10H6A9CoqcSsIAA8TTjXTF9udZJPmosp5pFHpAoD4lqe2ureVBacZWn7EJXA2NdO2LCFIXqaso5Ap4MqXyrReN0OBf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg6g9uWP/WCgG16gm/6mNn/Hk8RTZzKo8Yl9o9kSSrQ=;
 b=euh0OLfQ37ugq827FWqJJGYc5ghbKU06vI4jmm/RcIV8PSMI6obz4ys9xbbCbZ3172d/0bX0ugmcrv+97pegp83MjjD+T9yeU42SeTBKnPa6WpnDaJVABRxGtCyu+pT8ACR0HY02r/JC/5E4+zWcwhnwhmSERhXmlT8cFGNQB9jyZZckoHeEAXkc2zG4MBrHKi+T48sJVwTBHPmTpDQ3dfBfGjjNuikX5lFD5r1NrlpkoXPzs7tAMckwkmlsHgYGfL7oEcZpkYANknFun6GgTPRdyZtdxTuC5SAVAwPgQ5J3pRzRX2XaUy+oh5tsAYIpo+RIINxBkc7/c+So4Ia1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2567.namprd12.prod.outlook.com (52.132.140.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 11:15:17 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 11:15:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH v2 0/3] RAS support for mmhub
Thread-Topic: [PATCH v2 0/3] RAS support for mmhub
Thread-Index: AQHVn5A5iMvlwFR0pkKV2jV6qrgr7aeT6FLA
Date: Wed, 20 Nov 2019 11:15:17 +0000
Message-ID:
 <DM5PR12MB1418B16291B9322554C2BCC2FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191120104932.16257-1-Dennis.Li@amd.com>
In-Reply-To: <20191120104932.16257-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c317dde-5cf5-49d3-26e0-08d76daaeca6
x-ms-traffictypediagnostic: DM5PR12MB2567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2567A9CD6857766E6057F71CFC4F0@DM5PR12MB2567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(13464003)(2906002)(2501003)(476003)(55016002)(99286004)(110136005)(8936002)(316002)(76116006)(102836004)(71200400001)(6506007)(53546011)(26005)(14444005)(486006)(66066001)(186003)(5660300002)(256004)(11346002)(52536014)(81166006)(81156014)(446003)(33656002)(86362001)(6116002)(3846002)(66946007)(76176011)(7696005)(305945005)(74316002)(71190400001)(6636002)(7736002)(8676002)(9686003)(6246003)(478600001)(6436002)(4326008)(66556008)(64756008)(229853002)(66446008)(66476007)(25786009)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2567;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNF+ibbNEUUH8VRRtFkJWBwuySJD32W3DLlFX+Kq/pKqrXgO8p+KlrP6CGpWk9A4UpaAp3KJWPZU7L3+0jaQeLV3hawKp5WsQMT65KhKp52pfPBfOGWrlwUu7k1pJh18ZqvVxNGLT07eOqRTB1pf7emKtRcsZQyabenZMMKvDCcYbF5zWglBoXOztKtY7HdnLttovjsqySCEjkGm8lNiKO1X/igwNh6Sb77eVPN5oq7VShOnMcmBkLjjlKPrWuhGN8KcPK6zVl2WzGyP+5wxf9arBt+k7xfeAnC9EIA68iYuO8oCvLsaZQnUMmpF533lm/rXOD3E/X8ahHbJ6TVJFH7PkQm9picPN2GQRLbiHF6luEwysztctP8I3KKPNJNZ08fUF8ZQ7lsKGPpUKQPvBGsQMz2FqmjIXy2JA5RTcgmVyk4AH7e2rW782xVWGXua
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c317dde-5cf5-49d3-26e0-08d76daaeca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 11:15:17.7414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKYTtw60VpEwVPITxXOHi902A5INCESLsX2UdGfCWZQMUV+f/rW3ncdHTVSUbrw8XS28NjWxwhULjx5jC486rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg6g9uWP/WCgG16gm/6mNn/Hk8RTZzKo8Yl9o9kSSrQ=;
 b=KQDord857aszfHWbHlbvzXnTthrkZqc4fDPEWPR0YvO3hEvq7S/Oh+MmJqh4DDBVLDIXDYiAxUAJKoWODaRYhSO+72zFigWq1QVAvoD180+VHiHoimR1oMKV+dxZyl6NSAuatP0jQx2UCoES3DIaxh44/sUQ9UgBGaqMm1yvxqA=
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120111517.B-96csr705EKaQmsUJpkq35olwL2jjHEnuI-9her_Mg@z>

U2VyaWVzIGlzDQoNClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogRGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNvbT4gDQpTZW50OiAyMDE55bm0MTHmnIgy
MOaXpSAxODo0OQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhv
dTFAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBDaGVu
LCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQpDYzogTGksIERlbm5pcyA8RGVubmlzLkxp
QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggdjIgMC8zXSBSQVMgc3VwcG9ydCBmb3IgbW1odWIN
Cg0KVGhpcyBzZXQgb2YgcGF0Y2hlcyBpcyBhIGNvbnRpbnVhdGlvbiBvZiBSQVMgZW5hYmxlbWVu
dCBwYXRjaGVzIGZvciBBTURHUFUuIA0KDQoxLiBUaGUgbmV3IHN0cnVjdCBzb2MxNV9yYXNfZmll
bGRfZW50cnkgd2lsbCBiZSByZXVzZWQgYnkgZ2Z4LCBtbWh1YiBhbmQgb3RoZXIgSVAgYmxvY2tz
Lg0KMi4gUmVmaW5lIHRoZSBxdWVyeSBmdW5jdGlvbiBvZiBSQVMgZXJyb3IgY291bnRlciBmb3Ig
VkcyMCwgYWRkIGNvZGVzIHRvIGhlbHAgdXNlciB0byBsb2NhdGUgd2hpY2ggc3ViLWJsb2NrIG9m
IG1taHViIGNhdXNlIGVycm9yLg0KMy4gSW1wbGVtZW50IHRoZSBxdWVyeSBmdW5jdGlvbiBvZiBS
QVMgZXJyb3IgY291bnRlciBmb3IgTWkxMDANCg0KdjI6DQoxLiBGaXggc29tZSBjb21tZW50IGlz
c3Vlcy4NCjIuIEFkZCBJUCBuYW1lIHByZWZpeCBmb3IgdGhlIGxvY2FsIHN0YXRpYyB2YXJpYWJs
ZSBhbmQgZnVuY3Rpb24uDQozLiBNb3ZlIHRoZSBFRENfQ05UIHJlZ2lzdGVycycgZGVmaW50aW9u
IGZyb20gbW1odWJfOV80IGhlYWRlciBmaWxlcyB0byBtbWh1Yl8xXzAgb25lcyBmb3IgdmcyMC4N
Cg0KRGVubmlzIExpICgzKToNCiAgZHJtL2FtZGdwdTogZGVmaW5lIHNvYzE1X3Jhc19maWVsZF9l
bnRyeSBmb3IgcmV1c2UNCiAgZHJtL2FtZGdwdTogcmVmaW5lIHF1ZXJ5IGZ1bmN0aW9uIG9mIG1t
aHViIEVEQyBjb3VudGVyIGluIHZnMjANCiAgZHJtL2FtZGdwdTogaW1wbGVtZW50IHF1ZXJ5aW5n
IHJhcyBlcnJvciBjb3VudCBmb3IgbW1odWI5LjQNCg0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMgICAgICAgICB8ICAzNCArLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jICAgICAgICAgfCAgIDMgKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L21taHViX3YxXzAuYyAgICAgICB8IDIzMiArKysrKysrKysrKystLS0tDQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jICAgICAgIHwgMjUzICsrKysrKysrKysrKysr
KystDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5oICAgICAgIHwgICAy
ICsNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5oICAgICAgICAgICAgfCAgMTIg
Kw0KIC4uLi9pbmNsdWRlL2FzaWNfcmVnL21taHViL21taHViXzFfMF9vZmZzZXQuaCB8ICAxNiAr
Kw0KIC4uLi9hc2ljX3JlZy9tbWh1Yi9tbWh1Yl8xXzBfc2hfbWFzay5oICAgICAgICB8IDEyMiAr
KysrKysrKysNCiAuLi4vYXNpY19yZWcvbW1odWIvbW1odWJfOV80XzBfb2Zmc2V0LmggICAgICAg
fCAgNTMgLS0tLQ0KIC4uLi9hc2ljX3JlZy9tbWh1Yi9tbWh1Yl85XzRfMF9zaF9tYXNrLmggICAg
ICB8IDI1NyAtLS0tLS0tLS0tLS0tLS0tLS0NCiAxMCBmaWxlcyBjaGFuZ2VkLCA1OTggaW5zZXJ0
aW9ucygrKSwgMzg2IGRlbGV0aW9ucygtKSAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9tbWh1Yi9tbWh1Yl85XzRfMF9vZmZzZXQuaA0KIGRl
bGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvbW1o
dWIvbW1odWJfOV80XzBfc2hfbWFzay5oDQoNCi0tDQoyLjE3LjENCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
