Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A245FC54E4A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 14:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480D92075E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 14:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aa4WciCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480D92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055726E104;
	Tue, 12 May 2020 14:01:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4786E922
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 14:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqW0WiqfaNomgll7fBfyFLgrbKhpEKe7GaE+wX3fJdKm7/H8C5POXlzY2GISVPNqCv5zjMZaxaHDP3jRzfkSFrKVieH1RO0niUAjXKpN/wF47df7pSQopTOdXOBt3ZUqM0IF5ObOzghaKwwKtr+DS8fnMI7M9x+olTlw2OE6niPzHoBpTvU8xH5/6DfnJIKAQQypTur/QD8VlsVp7HIeNZZSg4cYkPKBE5hVoXf682pB67KSo6fEVaeOefdpDCrw2zUU9NXdSMt+VBdB5bWbfKRAMGPNHCIwsfebnyDgyycXYgxVxo7Ryr+kCIL7wsV+j9I96bE7d32XOB8kunnEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzLstElmY3esR4tL0K0BrWIM1our9a95ClLjmK/NASQ=;
 b=kGpQ8JovSrHFS6Wn+76WRIHPw9P00xqpEL68831HjdGKLmFVjxYPs0WJtLlFz55HtNz9CPVQ9SIcy7/SKTB8klIZqMGRFN5+AvgMOnk2UEA5mqUlRHsmWicylBrJK1JC4WWCr5cI/Ldt6JLXsbZil0x5Xhoc8wu3NYe1+ZezGb03WarnpNy4N57S6aS/taTAIdWrVJPtZovxdQFOj0yplMKer2bMG/SC5uXftXQoVCH37PQGJr8rNqdGIrCoukEIil5OiEKKVsJRUZFQsHi2loPS+XOVIjQYVjDOC5Ov9oYTmAcjx+394B9bACx+i4c8X2XXiZSxv+XgciiMXgKr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzLstElmY3esR4tL0K0BrWIM1our9a95ClLjmK/NASQ=;
 b=aa4WciCaPqVTFt+zDFhwDwWZMouFP90+qjYb8nhnCVRhaIUUjQULzAZ5PMngN7inE+Y18Vco1JWGIU33Upaq5WIQP97ujQNL+qx1JnD7bzxsNU9VJmfuhJil5/yRWGR/xzzoaGoDMyg9DR1hKqoI/hXRX1VZh5uHCdWhNjnkfV8=
Received: from MW2PR12MB2378.namprd12.prod.outlook.com (2603:10b6:907:f::15)
 by MW2PR12MB2507.namprd12.prod.outlook.com (2603:10b6:907:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 14:01:27 +0000
Received: from MW2PR12MB2378.namprd12.prod.outlook.com
 ([fe80::5432:f753:765c:6b39]) by MW2PR12MB2378.namprd12.prod.outlook.com
 ([fe80::5432:f753:765c:6b39%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 14:01:26 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10
Thread-Topic: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10
Thread-Index: AQHWKEaPDzcN7vZk/ke+fnRV7APgjaikew2g
Date: Tue, 12 May 2020 14:01:26 +0000
Message-ID: <MW2PR12MB2378D5104E86E3DCF5C55216E5BE0@MW2PR12MB2378.namprd12.prod.outlook.com>
References: <20200512101721.12164-1-yttao@amd.com>
In-Reply-To: <20200512101721.12164-1-yttao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74851bc9-bb59-4c12-25b3-08d7f67cf68b
x-ms-traffictypediagnostic: MW2PR12MB2507:|MW2PR12MB2507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB250781AC3CE1D6D6965CA881E5BE0@MW2PR12MB2507.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCja53R0+Ds7sTV4EIM50K8ogQWd8M3DLtw4nPQ70mS7OfpxBzqOdqR9x8aD/O4vZsWzTjxlwwTQk0M8N2pQgSgEHHmfWMUR4AWBycViT/B7WS2Fuhlk00oMMFUtojOcPRXzl8IyIwlX3cAbrVq3S77DeaxaWzuqBW4c643opNl3/D7YIl3v1wAO+8gDzuGgF+Zwlan9s4oEbI76LP86CXWwaEuyN6kFxqzrIhN/hylSRdUbDAtT0SXmkSuGFyBcv6msG5C0R/swYyh3S7lnfKAqR+Jfk9pH5OqD7oVzBigVV6Ffw6GAoQZgTq1WuD4d/l0GP/Y/VUoYWJeuqsIiRFPKGSCP2birgXckvfJ8nSdz5q6Vd8WppunAcTNz7o5ohpZoFTTGp4sheBBPNs8Yvh91KITSL3tKcCwfCt1phYUgl7zozAbxRF3gcpwdFdK06V87AkvEWkRZ05Nhk8cdjgLizaEzGf4LZ2PofEau1JvRpEDTAjg6Uir0QpJCGoob9J6ke7in+j+1T1WANeM62w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2378.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(33430700001)(64756008)(66446008)(66556008)(478600001)(2906002)(9686003)(76116006)(7696005)(6506007)(26005)(53546011)(186003)(52536014)(86362001)(71200400001)(33656002)(33440700001)(110136005)(4326008)(66476007)(6636002)(316002)(66946007)(5660300002)(8676002)(8936002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 6qU7CMJSQ3QPZoCPim+ASYxfrOpSgsMdDnU/vcBfRh3eSnC1C0et5cqGxjOahBYeV9j6KRULGqzDyEfuu5j01R8CQGrrF1wF4Ix6UjJccfpzGNytFcz6ovgR3917xC1uLaP/DDlHj8C1DJy1agkJWxE8c8tAmMsS5NMhwRkfAmKoHGlEXfiBLE0qqlfBHCovAGc9jRpxDNoyBnNVk5oMRQ2EFRfcSLmoe+E4ZdfTdNx6O6vee5QYi4LsmH8nX3ZyeCWxEJ/EadToGGagpexPVj9dQ5Z4u12nTpJH4zSx7l2hSvxws9U0uLi8XeGT51TVlBqSEo4rx3y/dJ9Bb41HiAPS4BJFjipiZ7XT8uASnf81B6vtV3EDzSp0asJAXIHxW7xnzYnwOd9Fan91wTemjWFSyCoGwPPuY8N/pNP0Xi2d2jKNFjL0o+r/jRa+I/OBTWKUEYn5HbrA9zfIbXfN/4hRfZzNyOR/3Y/w9jdLEmLjHD/Q8UJ45hEVEX49AChD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74851bc9-bb59-4c12-25b3-08d7f67cf68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 14:01:26.6997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZAfWWCMwjWv3grFHbBF1fzxVxRU8FNkZ07Hy/wEtY6KcgCbTWalWSx0mVUs+xca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2507
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZy4uLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWWludGlhbiBUYW8g
PHl0dGFvQGFtZC5jb20+IA0KU2VudDogMjAyMMTqNdTCMTLI1SAxODoxNw0KVG86IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5M
aXVAYW1kLmNvbT47IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT4NCkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgVGFvLCBZaW50aWFuIDxZaW50aWFuLlRhb0BhbWQu
Y29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiB0dXJuIGJhY2sgcmxjZyB3cml0ZSBm
b3IgZ2Z4X3YxMA0KDQpUaGVyZSBpcyBubyBuZWVkIHRvIHVzZSBhbWRncHVfbW1fd3JlZ19tbWlv
X3JsYygpIGR1cmluZyBpbml0aWFsaXphdGlvbiB0aW1lIGJlY2F1c2UgdGhpcyBpbnRlcmZhY2Ug
aXMgb25seSBkZXNpZ25lZCBmb3IgZGVidWdmcyBjYXNlIHRvIGFjY2VzcyB0aGUgcmVnaXN0ZXJz
IHdoaWNoIGFyZSBvbmx5IHBlcm1pdHRlZCBieSBSTENHIGR1cmluZyBydW4tdGltZS4gVGhlcmVm
b3JlLCB0dXJuIGJhY2sgcmxjZyB3cml0ZSBmb3IgZ2Z4X3YxMC4NCklmIHdlIG5vdCB0dXJuIGJh
Y2sgaXQsIGl0IHdpbGwgcmFpc2UgYW1kZ3B1IGxvYWQgZmFpbHVyZS4NClsgICA1NC45MDQzMzNd
IGFtZGdwdTogU01VIGRyaXZlciBpZiB2ZXJzaW9uIG5vdCBtYXRjaGVkDQpbICAgNTQuOTA0Mzkz
XSBhbWRncHU6IFNNVSBpcyBpbml0aWFsaXplZCBzdWNjZXNzZnVsbHkhDQpbICAgNTQuOTA1OTcx
XSBbZHJtXSBraXEgcmluZyBtZWMgMiBwaXBlIDEgcSAwDQpbICAgNTUuMTE1NDE2XSBhbWRncHUg
MDAwMDowMDowNi4wOiBbZHJtOmFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyIFthbWRncHVdXSAqRVJS
T1IqIHJpbmcgZ2Z4XzAuMC4wIHRlc3QgZmFpbGVkICgtMTEwKQ0KWyAgIDU1LjExODg3N10gW2Ry
bTphbWRncHVfZGV2aWNlX2luaXQgW2FtZGdwdV1dICpFUlJPUiogaHdfaW5pdCBvZiBJUCBibG9j
ayA8Z2Z4X3YxMF8wPiBmYWlsZWQgLTExMA0KWyAgIDU1LjEyNjU4N10gYW1kZ3B1IDAwMDA6MDA6
MDYuMDogYW1kZ3B1X2RldmljZV9pcF9pbml0IGZhaWxlZA0KWyAgIDU1LjEzMzQ2Nl0gYW1kZ3B1
IDAwMDA6MDA6MDYuMDogRmF0YWwgZXJyb3IgZHVyaW5nIEdQVSBpbml0DQoNClNpZ25lZC1vZmYt
Ynk6IFlpbnRpYW4gVGFvIDx5dHRhb0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAxNCArKysrKystLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jDQppbmRleCA0NDk0MDhjZmQwMTguLmJkNWRkNGY2NDMxMSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KQEAgLTQ1NzcsMTMgKzQ1NzcsMTEg
QEAgc3RhdGljIGludCBnZnhfdjEwXzBfaW5pdF9jc2Ioc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQogCWFkZXYtPmdmeC5ybGMuZnVuY3MtPmdldF9jc2JfYnVmZmVyKGFkZXYsIGFkZXYtPmdm
eC5ybGMuY3NfcHRyKTsNCiANCiAJLyogY3NpYiAqLw0KLQkvKiBhbWRncHVfbW1fd3JlZ19tbWlv
X3JsYyB3aWxsIGZhbGwgYmFjayB0byBtbWlvIGlmIGRvZXNuJ3Qgc3VwcG9ydCBybGNnX3dyaXRl
ICovDQotCWFtZGdwdV9tbV93cmVnX21taW9fcmxjKGFkZXYsIFNPQzE1X1JFR19PRkZTRVQoR0Ms
IDAsIG1tUkxDX0NTSUJfQUREUl9ISSksDQotCQkJCSBhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRl
X2dwdV9hZGRyID4+IDMyLCAwKTsNCi0JYW1kZ3B1X21tX3dyZWdfbW1pb19ybGMoYWRldiwgU09D
MTVfUkVHX09GRlNFVChHQywgMCwgbW1STENfQ1NJQl9BRERSX0xPKSwNCi0JCQkJIGFkZXYtPmdm
eC5ybGMuY2xlYXJfc3RhdGVfZ3B1X2FkZHIgJiAweGZmZmZmZmZjLCAwKTsNCi0JYW1kZ3B1X21t
X3dyZWdfbW1pb19ybGMoYWRldiwgU09DMTVfUkVHX09GRlNFVChHQywgMCwgbW1STENfQ1NJQl9M
RU5HVEgpLA0KLQkJCQkgYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9zaXplLCAwKTsNCisJV1JF
RzMyX1NPQzE1X1JMQyhHQywgMCwgbW1STENfQ1NJQl9BRERSX0hJLA0KKwkJCSBhZGV2LT5nZngu
cmxjLmNsZWFyX3N0YXRlX2dwdV9hZGRyID4+IDMyKTsNCisJV1JFRzMyX1NPQzE1X1JMQyhHQywg
MCwgbW1STENfQ1NJQl9BRERSX0xPLA0KKwkJCSBhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX2dw
dV9hZGRyICYgMHhmZmZmZmZmYyk7DQorCVdSRUczMl9TT0MxNV9STEMoR0MsIDAsIG1tUkxDX0NT
SUJfTEVOR1RILCANCithZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX3NpemUpOw0KIA0KIAlyZXR1
cm4gMDsNCiB9DQpAQCAtNTE5Miw3ICs1MTkwLDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfY3Bf
Z2Z4X2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpDQogCXRt
cCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9NRV9DTlRMLCBNRV9IQUxULCBlbmFibGUgPyAwIDog
MSk7DQogCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9NRV9DTlRMLCBQRlBfSEFMVCwgZW5h
YmxlID8gMCA6IDEpOw0KIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfTUVfQ05UTCwgQ0Vf
SEFMVCwgZW5hYmxlID8gMCA6IDEpOw0KLQlhbWRncHVfbW1fd3JlZ19tbWlvX3JsYyhhZGV2LCBT
T0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbUNQX01FX0NOVEwpLCB0bXAsIDApOw0KKwlXUkVHMzJf
U09DMTVfUkxDKEdDLCAwLCBtbUNQX01FX0NOVEwsIHRtcCk7DQogDQogCWZvciAoaSA9IDA7IGkg
PCBhZGV2LT51c2VjX3RpbWVvdXQ7IGkrKykgew0KIAkJaWYgKFJSRUczMl9TT0MxNShHQywgMCwg
bW1DUF9TVEFUKSA9PSAwKQ0KLS0NCjIuMTcuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
