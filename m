Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A463C3F2D1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 01:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D891320726
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 01:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uh8Cv2N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D891320726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E7F6E3F5;
	Fri,  6 Mar 2020 01:53:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B193B6E3F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 01:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jylq9VYl1vTYj1C2H2suxARPuc4rYlKo2PMfqEq8f+uFMhHrBY9havYe/ZXbObYvKmUepbFys1wtTKtitasd0zrfGfWKZi8I2sGBAh3bA81ybj8jeX67mcWGbFiERHBt6oZXl6olIXPAg/mDGuevjUUN1h0Qub76KDMkyCcdZsMwK0sY/F2hGqBNRwa7lEzV+jU1cLMsFkZ0f8Ye4/gxzuHsjk8OywYTsYZvPSxE3DnC5ETTQAvdE/VgvSULI2j3FQY+rbesz44v4MeZKzsv8rVa7GQY/C5R0D9LZVyp3zsDFxFclnR/T941MBf7h5Q6TkWr+tQ73L/y1nHyEtEsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC2B56lAcTqUh3oK/hDOQr5Cg8jFiBW2l6WKbbtJDus=;
 b=GWfRI3/Zhohu/h5ReThRj3m36kOxh+amOSbMBpE3yKdhM8Wzj14kNyzyZGiBoU13To+tXAFiIDeCcQY/e6sMOv2srZbSEJxjbCbbmIhBtP2j2XmXc8ipbkC6uYvCbdqZ+OAWLyWojeqThGipbyboGfBWWIqh7MrcyP+o95PgokgmlfFzQRctXrD2vFdk92Us9U2qXTYa6O2SYgDrzbBV7JWwBIwT6wzBgLQ6hQXJ0wdcNf94mBUVNI3fi1TV0/KOZa8hWnJeAprMxT0jmP69bLD66K42+TUEzjVajnLn64kyT/rEBfCcocsgJpkE/v8po8COe1zIq1HZxQ4ZsSNvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC2B56lAcTqUh3oK/hDOQr5Cg8jFiBW2l6WKbbtJDus=;
 b=Uh8Cv2N/nv4JVYvhL99H9v07b9U2rTVEFL7PC5pD/wIte6yD8gd0H9XcLsgq0jcrxWH62JE84+jrmsBtuNExlNl2FGJYPm/fP97A3ggjBzgo8ri27ygD85M/X7h3Jy5PShVBdaEP55hXEGwKioyKgNLOM9xyzHxJDg5ivo7gdEU=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21)
 by CH2PR12MB3799.namprd12.prod.outlook.com (2603:10b6:610:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 6 Mar
 2020 01:53:45 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321%3]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 01:53:45 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Thread-Index: AQHV7Bq468Vjz2GRSUea0X3otJp4SKg5hAkAgAAASmCAALGxgIAApbwg
Date: Fri, 6 Mar 2020 01:53:45 +0000
Message-ID: <CH2PR12MB376755ED4A8DF89CEAC1DAB0FEE30@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20200225203224.1129396-1-alexander.deucher@amd.com>
 <CADnq5_MGixxj8tdOhb7Tg1hNEGGd7Ue0bgCEtKOYaD7n-u0K8A@mail.gmail.com>,
 <CH2PR12MB3767A6BF43D694CD494E0B58FEE20@CH2PR12MB3767.namprd12.prod.outlook.com>
 <CH2PR12MB39124A0D056AFD1C8534C92EF7E20@CH2PR12MB3912.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB39124A0D056AFD1C8534C92EF7E20@CH2PR12MB3912.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-05T15:59:54.607Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-06T01:53:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 382be886-cf38-4c6a-a057-0000fd846a56
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dab56cdd-f063-467c-3c38-08d7c17134ce
x-ms-traffictypediagnostic: CH2PR12MB3799:|CH2PR12MB3799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3799B5DEC4EBB0E6B359C7B7FEE30@CH2PR12MB3799.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(6506007)(7696005)(53546011)(8936002)(86362001)(81166006)(8676002)(81156014)(66556008)(64756008)(66946007)(66476007)(66446008)(76116006)(26005)(186003)(33656002)(52536014)(4326008)(5660300002)(110136005)(55016002)(2906002)(9686003)(966005)(478600001)(45080400002)(316002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3799;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSzOYnSakRjNAM5B/0nMjA9yqF1avYUrTSi4CerY5R2BG18+A61pw4wLU6lpiQAh6Leo+WETc06YmLwwxs4hlbXlKotjS2SIXP39hwFeUrPcZGeb0uA1w1ZKs0UQ78/4zU72adYPmnwAernU6xfCJef7Jdb6mZUWZpVOqK8H2y5XQVyTfKqYK7c60RKBCilbFaS25zXJ6yhmkk/IYfU7k98wI1BwkWR4XpFd6N34d8KLLg/eh2hSJy05JUBMaby9qe5G9w7scb+BxzAI9hzX76MZtgzwmI6EE/CRF8pywSgRZSadMYZC4jMm3HtgE4PExar69PUJ5PUWLtZYff3I0n0AVP5axVb8xPX+D+uiiqs+uBsJqxOLV907tbQ6EwvBpgzOGhepYAdHXWNX1xGLeccKsLQqKY1k1oTyncpHpE8SskkJ4wIWcTIXlVkWch0V57EmE+SLrtBMS4eByzPNatwwPg0NvebMR97R3ipofNM=
x-ms-exchange-antispam-messagedata: NtuZiDZJzUBHh/lWupt5qK8kA+9adp/4XNUgFc2HrTD93UszKWz4V7g5MYQ5BfNt25wePRI+BINy4vXzlHSdKF4rUPSuP+qoFFXMvhGBfjcYiY5veXZDOInx0IMdEzp38/q6Nxa7X7EH15/u88I0xQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab56cdd-f063-467c-3c38-08d7c17134ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 01:53:45.5522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrwyCzXiuUdn6pn+03s9kREPcYqEbJiHPATFLPupmLyQrREwv4R0h8i5BtAxAGeM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3799
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
Cc: "Tawfik, Aly" <Aly.Tawfik@amd.com>
Content-Type: multipart/mixed; boundary="===============1481782194=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1481782194==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB376755ED4A8DF89CEAC1DAB0FEE30CH2PR12MB3767namp_"

--_000_CH2PR12MB376755ED4A8DF89CEAC1DAB0FEE30CH2PR12MB3767namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBQdWJsaWMgVXNlXQ0KDQpQYXRjaDEsIFBhdGNoMiBhcmUgOg0KDQoNClJldmlld2VkLWJ5
OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPg0KDQoNCkZyb206IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClNlbnQ6IDIwMjDE6jPUwjbI1SAwOjAw
DQpUbzogWHUsIEZlaWZlaSA8RmVpZmVpLlh1QGFtZC5jb20+OyBBbGV4IERldWNoZXIgPGFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT47IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+DQpDYzogVGF3ZmlrLCBBbHkgPEFseS5UYXdmaWtAYW1kLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1L2Rpc3BsYXk6IGZpeCBwY2kgcmV2aXNpb24gaWQgZmV0
Y2hpbmcNCg0KDQpbQU1EIFB1YmxpYyBVc2VdDQoNCklzIHRoaXMgZm9yIHRoZSBzZXJpZXMsIG9y
IGp1c3QgdGhpcyBwYXRjaD8gIFRoYW5rcyENCg0KQWxleA0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCkZyb206IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPG1haWx0bzpG
ZWlmZWkuWHVAYW1kLmNvbT4+DQpTZW50OiBUaHVyc2RheSwgTWFyY2ggNSwgMjAyMCAxMjoyNCBB
TQ0KVG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPG1haWx0bzphbGV4ZGV1
Y2hlckBnbWFpbC5jb20+PjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+Pg0KQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbTxtYWlsdG86QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4+OyBUYXdmaWssIEFseSA8QWx5LlRhd2Zpa0BhbWQuY29tPG1haWx0bzpB
bHkuVGF3ZmlrQGFtZC5jb20+Pg0KU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHUv
ZGlzcGxheTogZml4IHBjaSByZXZpc2lvbiBpZCBmZXRjaGluZw0KDQpbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNCg0KDQpSZXZpZXdlZC1ieTog
RmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbTxtYWlsdG86RmVpZmVpLlh1QGFtZC5jb20+Pg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IDIwMjDE6jPU
wjXI1SAxMzoyMw0KVG86IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc8bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPj4NCkNjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb208bWFpbHRvOkFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+PjsgVGF3ZmlrLCBBbHkgPEFseS5UYXdmaWtAYW1kLmNvbTxtYWlsdG86QWx5
LlRhd2Zpa0BhbWQuY29tPj4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1L2Rp
c3BsYXk6IGZpeCBwY2kgcmV2aXNpb24gaWQgZmV0Y2hpbmcNCg0KUGluZz8NCg0KT24gVHVlLCBG
ZWIgMjUsIDIwMjAgYXQgMzozMiBQTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNv
bTxtYWlsdG86YWxleGRldWNoZXJAZ21haWwuY29tPj4gd3JvdGU6DQo+DQo+IEZyb206IEFseS1U
YXdmaWsgPGFsdGF3ZmlrQGFtZC5jb208bWFpbHRvOmFsdGF3ZmlrQGFtZC5jb20+Pg0KPg0KPiBV
c2UgdGhlIHBjaSByZXZpc2lvbiBpZCByYXRoZXIgdGhhbiB0aGUgYXNpYyBzaWxpY29uIHJldmlz
aW9uIGlkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbHktVGF3ZmlrIDxhbHRhd2Zpa0BhbWQuY29t
PG1haWx0bzphbHRhd2Zpa0BhbWQuY29tPj4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPG1haWx0bzphbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPj4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYw0KPiBpbmRleCAwYzU1ZDQ0YzlkNWIuLjkyMTY2MTUwYmY5ZiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jDQo+IEBAIC05MDIsNyArOTAyLDcgQEAgc3RhdGljIGludCBhbWRncHVfZG1faW5pdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4NCj4gICAgICAgICBpbml0X2RhdGEuYXNpY19p
ZC5jaGlwX2ZhbWlseSA9IGFkZXYtPmZhbWlseTsNCj4NCj4gLSAgICAgICBpbml0X2RhdGEuYXNp
Y19pZC5wY2lfcmV2aXNpb25faWQgPSBhZGV2LT5yZXZfaWQ7DQo+ICsgICAgICAgaW5pdF9kYXRh
LmFzaWNfaWQucGNpX3JldmlzaW9uX2lkID0gYWRldi0+cGRldi0+cmV2aXNpb247DQo+ICAgICAg
ICAgaW5pdF9kYXRhLmFzaWNfaWQuaHdfaW50ZXJuYWxfcmV2ID0gYWRldi0+ZXh0ZXJuYWxfcmV2
X2lkOw0KPg0KPiAgICAgICAgIGluaXRfZGF0YS5hc2ljX2lkLnZyYW1fd2lkdGggPSBhZGV2LT5n
bWMudnJhbV93aWR0aDsNCj4gLS0NCj4gMi4yNC4xDQo+DQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz4NCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0ZlaWZlaS5YdSU0MGFtZC5jb20lN0NkZDQ5MjMy
MjYxYWM0MjY3YTMzZjA4ZDdjMGM1NGFkOCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2MzcxODk4MjU5MDg2ODM4MDQmYW1wO3NkYXRhPXNOJTJCR1N2cm1uejVR
ZHJmNEpSMHNGVURXTVd5dTd0c09oNlpHOWxiOUk1WSUzRCZhbXA7cmVzZXJ2ZWQ9MA0K

--_000_CH2PR12MB376755ED4A8DF89CEAC1DAB0FEE30CH2PR12MB3767namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:=CB=CE=CC=E5;mso-fareast-=
language:ZH-CN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Patch1, Patch2 are :<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Reviewed-by: Feifei Xu &=
lt;Feifei.Xu@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;
<br>
<b>Sent:</b> 2020</span><span lang=3D"JA" style=3D"font-size:11.0pt">=C4=EA=
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif">3</span><span lang=3D"JA" style=3D"font-size:11.0pt">=D4=C2</span><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
6</span><span lang=3D"JA" style=3D"font-size:11.0pt">=C8=D5</span><span sty=
le=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
 0:00<br>
<b>To:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Alex Deucher &lt;alexdeuch=
er@gmail.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tawfik, Aly &lt;Aly.Tawfik@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fet=
ching<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">Is this for the series, or just this patch?&nbsp; Thanks=
!<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Xu, Fe=
ifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.Xu@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, March 5, 2020 12:24 AM<br>
<b>To:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.f=
reedesktop.org">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Tawfik, Aly &lt;<a href=3D"mailto:Al=
y.Tawfik@amd.com">Aly.Tawfik@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fet=
ching</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[AMD Official Use O=
nly - Internal Distribution Only]<br>
<br>
<br>
<br>
Reviewed-by: Feifei Xu &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.Xu@a=
md.com</a>&gt;<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: 2020<span lang=3D"JA">=C4=EA</span>3<span lang=3D"JA">=D4=C2</span>5<=
span lang=3D"JA">=C8=D5</span> 13:23<br>
To: amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-g=
fx@lists.freedesktop.org</a>&gt;<br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;; Tawfik, Aly &lt;<a href=3D"mailto:Aly.Tawfi=
k@amd.com">Aly.Tawfik@amd.com</a>&gt;<br>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching<b=
r>
<br>
Ping?<br>
<br>
On Tue, Feb 25, 2020 at 3:32 PM Alex Deucher &lt;<a href=3D"mailto:alexdeuc=
her@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Aly-Tawfik &lt;<a href=3D"mailto:altawfik@amd.com">altawfik@amd.=
com</a>&gt;<br>
&gt;<br>
&gt; Use the pci revision id rather than the asic silicon revision id.<br>
&gt;<br>
&gt; Signed-off-by: Aly-Tawfik &lt;<a href=3D"mailto:altawfik@amd.com">alta=
wfik@amd.com</a>&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@am=
d.com">alexander.deucher@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 &#43;-<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 0c55d44c9d5b..92166150bf9f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br=
>
&gt; @@ -902,7 &#43;902,7 @@ static int amdgpu_dm_init(struct amdgpu_device=
 *adev)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.chip=
_family =3D adev-&gt;family;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.pci_revision_i=
d =3D adev-&gt;rev_id;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.pci_revisi=
on_id =3D adev-&gt;pdev-&gt;revision;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.hw_i=
nternal_rev =3D adev-&gt;external_rev_id;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.vram=
_width =3D adev-&gt;gmc.vram_width;<br>
&gt; --<br>
&gt; 2.24.1<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CFeifei.Xu%40amd.com%7Cdd49232261ac4267a33f08d7c0c54ad8%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637189825908683804&amp;amp;sdata=3DsN%2BGSv=
rmnz5Qdrf4JR0sFUDWMWyu7tsOh6ZG9lb9I5Y%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CFeifei.Xu%40amd.=
com%7Cdd49232261ac4267a33f08d7c0c54ad8%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637189825908683804&amp;amp;sdata=3DsN%2BGSvrmnz5Qdrf4JR0sFUDWMWyu7=
tsOh6ZG9lb9I5Y%3D&amp;amp;reserved=3D0</a><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB376755ED4A8DF89CEAC1DAB0FEE30CH2PR12MB3767namp_--

--===============1481782194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1481782194==--
