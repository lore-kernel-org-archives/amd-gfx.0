Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8642C5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848EB21848
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848EB21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541466FA02;
	Fri,  8 Nov 2019 16:34:21 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700058.outbound.protection.outlook.com [40.107.70.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA55C6FA02
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 16:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcd5aAe2E0rA9XC4sSiz3BODXu0ztjEy61E4aNFc7MZo5T0ijOJVIJ/JyC8QtLe10q8KsfTY+6dqvuapOO0LdgWQH2kDDsou2LeFSZqdeu3zJ6xPU+SP/NR78Dex8pREYwF9KIjTvhGetpDuSR/zqnpaz+J8edoY9/HXmCE8ei0BI9IedmYc32ZlFWIYI61/C8or5xzB215fnrE2yZY0ZJt+6EEa+5+9d+JAvj5uXDMIQELEQfe5/snjhKICCEkfqzkTFWMQWjSsxnbl5eZKnaYykxpF+YYr+yqzPkmTCYghhKu/akxOtDrtYwDpBvZvSdK/I+CYPtWfk4Hg860EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4pu3IsrGb9L+bPeckNPOsNBGsIhI3YWwFwi/RYpBLw=;
 b=hL3XGY1QlhMGNUpL4lR0qqQkRtEQFxtCUEnWx+luzy3A19o2mkaX8lzxrB4Ob5ORMLkmybdcfrvVWFFzSkO5NNMXob/TzgO/aPLgQfoKgTb84ForOE86ewNt5UczhdJpkrUlBLe4ynS1nDN+kXaW1vqzndlWNpO3cGzOxPK8609HaATfWgLPJ58MsAO+dA+TNFjnHvdha21Pj+3z789wqLqD8MMnbAGeQZWmOS44KpHKYOCuEKa07Z+EsBgUNQrA6U4R/17SkIn6GpzbjJndfyMhU024oKciDODf/YtQHu7966DTlVDxpD/JQosT0XS4yOhfFpftX0nh4dt0kf3PhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2982.namprd12.prod.outlook.com (20.178.55.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 16:34:17 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.025; Fri, 8 Nov 2019
 16:34:17 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/display: fix warning when
 CONFIG_DRM_AMD_DC_DCN is not set
Thread-Topic: [PATCH] drm/amdgpu/display: fix warning when
 CONFIG_DRM_AMD_DC_DCN is not set
Thread-Index: AQHVllEG4mGRZZI3Bku8394KxbFSw6eBeBWA
Date: Fri, 8 Nov 2019 16:34:17 +0000
Message-ID: <95cb7a97-f8a2-19b9-5365-bca74d08cf42@amd.com>
References: <20191108162425.2150451-1-alexander.deucher@amd.com>
In-Reply-To: <20191108162425.2150451-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::28) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 654485dd-ed74-4c05-95ca-08d764697f81
x-ms-traffictypediagnostic: BYAPR12MB2982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2982B07AD6DBADA3C1A0C350EC7B0@BYAPR12MB2982.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(2906002)(71200400001)(316002)(14454004)(2501003)(52116002)(102836004)(6436002)(76176011)(64756008)(110136005)(4326008)(229853002)(66066001)(7736002)(66446008)(66476007)(3846002)(26005)(66556008)(186003)(8676002)(53546011)(478600001)(386003)(6486002)(66946007)(6246003)(6116002)(6506007)(81166006)(256004)(86362001)(14444005)(25786009)(8936002)(2616005)(486006)(31696002)(99286004)(11346002)(305945005)(5660300002)(476003)(31686004)(81156014)(71190400001)(6512007)(446003)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2982;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qqc+QVHEE8CfW4UVJA+zuvCzt81x06gN2GalsqTkYqNk55HiFv2zNWFLnkqxJFkIVY+9D62HgRKUVU2T5N8BW7A5j159Ur6z/vbkVnE5Iu2Dlx9ymAF36MGxwwWpWlhCKeJKVKhJB13qkm1E7dC1AlCRJBYNdqzK/Ovpi0KPnyY47S7uMPf3WHP9Smno6G80Z2rIBKiq1dIBAJIbxHWN5I4FzhYRbXSdv2A3gujKflcjOaWhxVwU2th5e9oM0w1xSs8uqWOzxDXpXeH8Pi1r7RiBoE/Rxhh8XW9PNaVRwtyqesFZIA8eeM00kOyZJO6AGIDq3jeOOX6ZNHn8ISbfAJ1MVUAm6fYYXR415xpQgi5YPHymS5raL8zbr139qdcJaA15mVY12HqlaffradijbUPV036XZkO4PFE3IR7jxs5Bgir7CHljpT6tK6I0sJzp
Content-ID: <ED5F0D5F81417D48ABE968647B55D1CD@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654485dd-ed74-4c05-95ca-08d764697f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 16:34:17.2965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpsnS/IeV22jz0de8qZTiv+f0mNUe0ZPtC1Lm0iUp8YknbqYNRscqZtCjR3B/sjifKH/TMlXgNiD1wQ4qoiZRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2982
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4pu3IsrGb9L+bPeckNPOsNBGsIhI3YWwFwi/RYpBLw=;
 b=mIUwZgFQDs99zGrk/5bdh3LF0E00vQAZqPXo8IDTtA5HZWsqqxetBCZ0r8W4ws37q2AHipKj1rcrd0lym2rmyUTRAUFASavau4IcdLxS36My7tW1TW+P84jGTBTBqOeOaubZ/+kj/zvLuDwUjj8DH7Dw1Qx7G3oUKuji9vqD1Zo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108163417.mCwt6nGcXwx6TA57_lgGBJJlnud46YuR0PSMNZPNvVs@z>

T24gMjAxOS0xMS0wOCAxMToyNCBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IGRtX2Rjbl9j
cnRjX2hpZ2hfaXJxKCkgaXMgb25seSB1c2VkIHdoZW4gQ09ORklHX0RSTV9BTURfRENfRENOIGlz
IHNldC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFz
LmthemxhdXNrYXNAYW1kLmNvbT4NCg0KVGhhbmtzIQ0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICsrLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiBpbmRl
eCBkMmMyMzY5NDY5MDkuLmVmNDBhZGYxODdmNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IEBAIC00ODUsNyArNDg1
LDcgQEAgc3RhdGljIHZvaWQgZG1fY3J0Y19oaWdoX2lycSh2b2lkICppbnRlcnJ1cHRfcGFyYW1z
KQ0KPiAgIAl9DQo+ICAgfQ0KPiAgIA0KPiAtDQo+ICsjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FN
RF9EQ19EQ04pDQo+ICAgLyoqDQo+ICAgICogZG1fZGNuX2NydGNfaGlnaF9pcnEoKSAtIEhhbmRs
ZXMgVlN0YXJ0dXAgaW50ZXJydXB0IGZvciBEQ04gZ2VuZXJhdGlvbiBBU0lDcw0KPiAgICAqIEBp
bnRlcnJ1cHQgcGFyYW1zIC0gaW50ZXJydXB0IHBhcmFtZXRlcnMNCj4gQEAgLTU0Nyw2ICs1NDcs
NyBAQCBzdGF0aWMgdm9pZCBkbV9kY25fY3J0Y19oaWdoX2lycSh2b2lkICppbnRlcnJ1cHRfcGFy
YW1zKQ0KPiAgIA0KPiAgIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT5kZGV2LT5ldmVu
dF9sb2NrLCBmbGFncyk7DQo+ICAgfQ0KPiArI2VuZGlmDQo+ICAgDQo+ICAgc3RhdGljIGludCBk
bV9zZXRfY2xvY2tnYXRpbmdfc3RhdGUodm9pZCAqaGFuZGxlLA0KPiAgIAkJICBlbnVtIGFtZF9j
bG9ja2dhdGluZ19zdGF0ZSBzdGF0ZSkNCj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
