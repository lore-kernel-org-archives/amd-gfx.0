Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ED1C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 01:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BE420726
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 01:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h4ceCpGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BE420726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B4B6EC50;
	Fri,  6 Mar 2020 01:58:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680063.outbound.protection.outlook.com [40.107.68.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29C66EC50
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 01:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx2Kj08PjknwIELdMsl/g3XP7BxJjvKW887Hq7qyOcT7ceYVi1PXikPV7JQhK4YICsf3FhSyvUjxy2UcUXJU/YcCe9hn5Fn/rFH9EXjnNB3z6uBW8Wa6PhLeYRPeaSKGJN4xLjAjF7mBdko+eX9Ha+QL0TsLJH9Zo+SLoRO7EWGSQtG8E6dqrJX8gei1HzwJhZPAMjHMcUy0+2wGWHJKeD75mnD/oYs8ixD+MR0UPKVJb51Qo7dW8AsR4DLW70O5T6Ft20F5CvBkKfDY/C5q8jJaQEihxmy/I83b/R+1Ym7z7kxGz4pcsiB6U+wDGu4Bm+521GYXubF5k9Nr1E29Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXvR7R8b1jvRRsVJeT32/y9YK9/Ju1nfXXjeDCfKIwA=;
 b=Pnt18B2Wxlh81NCaib+cJE7bqBwSL1u0Nps0OUWa7NWjfdt8mD7e4IwZEkqEaaiM2EajhAUqPvVaygb4p/jGvDhBjrLGDpqNb5sQtiEjemlz4T80GjhfzD1pDSzILhZx80kJj4yNBXy/mjjABqRFqQg1YjWmznvq9CWrrJ9q/dm3f7z48c0h12VzT6KEU27rTRkbv484hYXzHi0hjIrH8pbQ/+oqd2+h6PiAUpo36WmYYgtv8y7Jlq9X5REaqOw11U4NatJrutYqX6StLtkQV4ESfo4//XoE09mUOisBf7Kye7R1+Q+pWSZJlvlEaBTIW9h+85BMKHm+67SCO9RGNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXvR7R8b1jvRRsVJeT32/y9YK9/Ju1nfXXjeDCfKIwA=;
 b=h4ceCpGR3PxCHHmxFVUt7y50lbYtps8it9SExnjJSqVhm+F33djGe2HjbM/X5Icp4CUlN0olbha31hgzxZ0gBQBv9tQ+eaFMvecwIbG9fRJoNRFEQEvJsloi3JssTzeIHoC4BNWuLV36uhtIEMvf+cYfuDJf5VwR4ywiyF5n8Lo=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21)
 by CH2PR12MB3765.namprd12.prod.outlook.com (2603:10b6:610:25::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 6 Mar
 2020 01:58:19 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321%3]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 01:58:18 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>, amd-gfx
 list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Thread-Index: AQHV7Bq468Vjz2GRSUea0X3otJp4SKg5hAkAgAAASmCAALGxgIAApbwggAABWmA=
Date: Fri, 6 Mar 2020 01:58:18 +0000
Message-ID: <CH2PR12MB376749AD5C3042768D0823E2FEE30@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20200225203224.1129396-1-alexander.deucher@amd.com>
 <CADnq5_MGixxj8tdOhb7Tg1hNEGGd7Ue0bgCEtKOYaD7n-u0K8A@mail.gmail.com>,
 <CH2PR12MB3767A6BF43D694CD494E0B58FEE20@CH2PR12MB3767.namprd12.prod.outlook.com>
 <CH2PR12MB39124A0D056AFD1C8534C92EF7E20@CH2PR12MB3912.namprd12.prod.outlook.com>
 <CH2PR12MB376755ED4A8DF89CEAC1DAB0FEE30@CH2PR12MB3767.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB376755ED4A8DF89CEAC1DAB0FEE30@CH2PR12MB3767.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-05T15:59:54.607Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD Public;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-06T01:58:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ca79831f-ffb6-4f2f-9707-00009176495d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 705d8203-5426-4e42-4de0-08d7c171d7aa
x-ms-traffictypediagnostic: CH2PR12MB3765:|CH2PR12MB3765:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3765BC9B61CD71EFB89050BBFEE30@CH2PR12MB3765.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(110136005)(316002)(26005)(66476007)(6506007)(76116006)(5660300002)(64756008)(66946007)(66556008)(53546011)(33656002)(7696005)(186003)(52536014)(66446008)(2906002)(4326008)(966005)(2940100002)(9686003)(86362001)(55016002)(71200400001)(45080400002)(8936002)(478600001)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3765;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VfFwbk27bp3HfaOSMD8Z9wDZlzdD1GyCfvpWkoyEF2kF+/umNkPY07kAI49TKo4JjaioibQsPfi8ToP6UaG+SKpUti1XlwAsW9/g6ON3cwDzsAUVVKsLOYnIQzBWkCqf3lrxfJsWqdJHm/WFdlo2sVyg7inSIRPJjwGcKOiK/C0gAs2Q2fscb/wexIgRwWyZ1O2eECSg52PIpy3/LVeCwVbxDXuzEuhelJ2lG6gZz+N2nFilb8A/IV3yp0LQuHUeuChoLpSEgFK5Y5tEqwkexiU8CAdG0eGWxJjqvOIajhBXzmYLzTEGpPMXUp7bwcZRwc+XLFW4LkN0MrZ1QxRIw0SLyhVNUlCGycDQr6KSb6KBEBrN6iLCdbBgx7Wx+oA4sMs3xmSxw52DDVLTbGjQ9XvpNwG/0ebhXTQE1QqU+B+xxLGMXR+XswEdOEZj/cmJYwyvFo+LGUEqFhnKYF8kex+5pnAmrZd8cHWO+zDOp8k=
x-ms-exchange-antispam-messagedata: yTNhHEUnGW5+Cg3kVYm2d/4ilekSLaYqsP/FRbz/zb+Hp6m4pMvXY2JLyEDfuJUnEWH2hWBXGpzuwgL3bJ3KrUMfxYI3ilTQsCtH1lPNiw8jiOquxc0jcanm+vH96M/VZbKymn/EKe5tm20JQDyTjg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705d8203-5426-4e42-4de0-08d7c171d7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 01:58:18.8523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6W57aHcG2TfL0qwGyLgGPmuGXh2xsSxpRQGZV0N+VSZQjM+OshCexp/LzJIq9HYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3765
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
Content-Type: multipart/mixed; boundary="===============1863407187=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1863407187==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB376749AD5C3042768D0823E2FEE30CH2PR12MB3767namp_"

--_000_CH2PR12MB376749AD5C3042768D0823E2FEE30CH2PR12MB3767namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBQdWJsaWMgVXNlXQ0KDQpQYXRjaDM6IEFja2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5Y
dUBhbWQuY29tPg0KDQpSZWdhcmRzLA0KRmVpZmVpDQoNCkZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBYdSwgRmVpZmVpDQpT
ZW50OiAyMDIwxOoz1MI2yNUgOTo1NA0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsg
YW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCkNjOiBUYXdmaWss
IEFseSA8QWx5LlRhd2Zpa0BhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIGRybS9h
bWRncHUvZGlzcGxheTogZml4IHBjaSByZXZpc2lvbiBpZCBmZXRjaGluZw0KDQoNCltBTUQgUHVi
bGljIFVzZV0NCg0KUGF0Y2gxLCBQYXRjaDIgYXJlIDoNCg0KDQpSZXZpZXdlZC1ieTogRmVpZmVp
IFh1IDxGZWlmZWkuWHVAYW1kLmNvbTxtYWlsdG86RmVpZmVpLlh1QGFtZC5jb20+Pg0KDQoNCkZy
b206IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbTxtYWlsdG86
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4+DQpTZW50OiAyMDIwxOoz1MI2yNUgMDowMA0KVG86
IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPG1haWx0bzpGZWlmZWkuWHVAYW1kLmNvbT4+
OyBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbTxtYWlsdG86YWxleGRldWNoZXJA
Z21haWwuY29tPj47IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8
bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPj4NCkNjOiBUYXdmaWssIEFseSA8
QWx5LlRhd2Zpa0BhbWQuY29tPG1haWx0bzpBbHkuVGF3ZmlrQGFtZC5jb20+Pg0KU3ViamVjdDog
UmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHUvZGlzcGxheTogZml4IHBjaSByZXZpc2lvbiBpZCBm
ZXRjaGluZw0KDQoNCltBTUQgUHVibGljIFVzZV0NCg0KSXMgdGhpcyBmb3IgdGhlIHNlcmllcywg
b3IganVzdCB0aGlzIHBhdGNoPyAgVGhhbmtzIQ0KDQpBbGV4DQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KRnJvbTogWHUsIEZlaWZlaSA8RmVpZmVpLlh1QGFtZC5jb208bWFpbHRv
OkZlaWZlaS5YdUBhbWQuY29tPj4NClNlbnQ6IFRodXJzZGF5LCBNYXJjaCA1LCAyMDIwIDEyOjI0
IEFNDQpUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb208bWFpbHRvOmFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT4+OyBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4+DQpDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPG1haWx0bzpBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPj47IFRhd2ZpaywgQWx5IDxBbHkuVGF3ZmlrQGFtZC5jb208bWFpbHRv
OkFseS5UYXdmaWtAYW1kLmNvbT4+DQpTdWJqZWN0OiBSRTogW1BBVENIIDEvMl0gZHJtL2FtZGdw
dS9kaXNwbGF5OiBmaXggcGNpIHJldmlzaW9uIGlkIGZldGNoaW5nDQoNCltBTUQgT2ZmaWNpYWwg
VXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KDQoNClJldmlld2VkLWJ5
OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPG1haWx0bzpGZWlmZWkuWHVAYW1kLmNvbT4+
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPj4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDogMjAyMMTq
M9TCNcjVIDEzOjIzDQpUbzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+Pg0KQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbTxtYWlsdG86QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4+OyBUYXdmaWssIEFseSA8QWx5LlRhd2Zpa0BhbWQuY29tPG1haWx0bzpB
bHkuVGF3ZmlrQGFtZC5jb20+Pg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHUv
ZGlzcGxheTogZml4IHBjaSByZXZpc2lvbiBpZCBmZXRjaGluZw0KDQpQaW5nPw0KDQpPbiBUdWUs
IEZlYiAyNSwgMjAyMCBhdCAzOjMyIFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPG1haWx0bzphbGV4ZGV1Y2hlckBnbWFpbC5jb20+PiB3cm90ZToNCj4NCj4gRnJvbTogQWx5
LVRhd2ZpayA8YWx0YXdmaWtAYW1kLmNvbTxtYWlsdG86YWx0YXdmaWtAYW1kLmNvbT4+DQo+DQo+
IFVzZSB0aGUgcGNpIHJldmlzaW9uIGlkIHJhdGhlciB0aGFuIHRoZSBhc2ljIHNpbGljb24gcmV2
aXNpb24gaWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFseS1UYXdmaWsgPGFsdGF3ZmlrQGFtZC5j
b208bWFpbHRvOmFsdGF3ZmlrQGFtZC5jb20+Pg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb208bWFpbHRvOmFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jDQo+IGluZGV4IDBjNTVkNDRjOWQ1Yi4uOTIxNjYxNTBiZjlmIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmMNCj4gQEAgLTkwMiw3ICs5MDIsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kbV9pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPg0KPiAgICAgICAgIGluaXRfZGF0YS5hc2lj
X2lkLmNoaXBfZmFtaWx5ID0gYWRldi0+ZmFtaWx5Ow0KPg0KPiAtICAgICAgIGluaXRfZGF0YS5h
c2ljX2lkLnBjaV9yZXZpc2lvbl9pZCA9IGFkZXYtPnJldl9pZDsNCj4gKyAgICAgICBpbml0X2Rh
dGEuYXNpY19pZC5wY2lfcmV2aXNpb25faWQgPSBhZGV2LT5wZGV2LT5yZXZpc2lvbjsNCj4gICAg
ICAgICBpbml0X2RhdGEuYXNpY19pZC5od19pbnRlcm5hbF9yZXYgPSBhZGV2LT5leHRlcm5hbF9y
ZXZfaWQ7DQo+DQo+ICAgICAgICAgaW5pdF9kYXRhLmFzaWNfaWQudnJhbV93aWR0aCA9IGFkZXYt
PmdtYy52cmFtX3dpZHRoOw0KPiAtLQ0KPiAyLjI0LjENCj4NCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPg0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDRmVpZmVpLlh1JTQwYW1kLmNvbSU3Q2RkNDky
MzIyNjFhYzQyNjdhMzNmMDhkN2MwYzU0YWQ4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0
ZTE4M2QlN0MwJTdDMCU3QzYzNzE4OTgyNTkwODY4MzgwNCZhbXA7c2RhdGE9c04lMkJHU3ZybW56
NVFkcmY0SlIwc0ZVRFdNV3l1N3RzT2g2Wkc5bGI5STVZJTNEJmFtcDtyZXNlcnZlZD0wPGh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngm
ZGF0YT0wMiU3QzAxJTdDRmVpZmVpLlh1JTQwYW1kLmNvbSU3Q2RkNTdjNjBkOWEwOTRmNzFmMGNk
MDhkN2MxNzEzODgwJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzE5MDU2NDkzNTU4NTcyMyZzZGF0YT1ONzlOb0E3MnZaOXpaUllzUzkyVklZMGZvZWpaRzZp
Z3E1N2JieDdESXNJJTNEJnJlc2VydmVkPTA+DQo=

--_000_CH2PR12MB376749AD5C3042768D0823E2FEE30CH2PR12MB3767namp_
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Patch3: Acked-by: Feifei=
 Xu &lt;Feifei.Xu@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Regards,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Feifei<o:p></o:p></span>=
</p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-fareast-language:ZH-CN">From:</span></b><span=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-f=
areast-language:ZH-CN"> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&g=
t;
<b>On Behalf Of </b>Xu, Feifei<br>
<b>Sent:</b> 2020</span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;font=
-family:=CB=CE=CC=E5;mso-fareast-language:ZH-CN">=C4=EA</span><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast=
-language:ZH-CN">3</span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;fon=
t-family:=CB=CE=CC=E5;mso-fareast-language:ZH-CN">=D4=C2</span><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast=
-language:ZH-CN">6</span><span lang=3D"ZH-CN" style=3D"font-size:11.0pt;fon=
t-family:=CB=CE=CC=E5;mso-fareast-language:ZH-CN">=C8=D5</span><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast=
-language:ZH-CN">
 9:54<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Alex Deuch=
er &lt;alexdeucher@gmail.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedeskto=
p.org&gt;<br>
<b>Cc:</b> Tawfik, Aly &lt;Aly.Tawfik@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fet=
ching<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.Xu@amd.com</a>&gt;<o:p></o:p=
></span></p>
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
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;<a href=
=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;
<br>
<b>Sent:</b> 2020</span><span lang=3D"JA" style=3D"font-size:11.0pt">=C4=EA=
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif">3</span><span lang=3D"JA" style=3D"font-size:11.0pt">=D4=C2</span><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
6</span><span lang=3D"JA" style=3D"font-size:11.0pt">=C8=D5</span><span sty=
le=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
 0:00<br>
<b>To:</b> Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.Xu@am=
d.com</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">al=
exdeucher@gmail.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Tawfik, Aly &lt;<a href=3D"mailto:Aly.Tawfik@amd.com">Aly.Tawfik=
@amd.com</a>&gt;<br>
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
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CFeifei.Xu%40amd.com%7Cdd57c60d9a094f71f0cd08d7c1713880%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637190564935585723&amp;sdata=3DN79NoA72vZ9zZRYs=
S92VIY0foejZG6igq57bbx7DIsI%3D&amp;reserved=3D0">https://nam11.safelinks.pr=
otection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2=
Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CFeifei.Xu%40amd.com%7Cdd492322=
61ac4267a33f08d7c0c54ad8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63718=
9825908683804&amp;amp;sdata=3DsN%2BGSvrmnz5Qdrf4JR0sFUDWMWyu7tsOh6ZG9lb9I5Y=
%3D&amp;amp;reserved=3D0</a><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB376749AD5C3042768D0823E2FEE30CH2PR12MB3767namp_--

--===============1863407187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1863407187==--
