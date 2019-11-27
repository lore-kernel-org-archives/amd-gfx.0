Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B4C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 11:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3343C206F0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 11:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3343C206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBC86E51D;
	Wed, 27 Nov 2019 11:38:43 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2366E51D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 11:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkKu3jh+FgFQ3GLsYsmz9PK/s282quNBIx4b6/oAx+ptrH+Swg8dny0jMfJsFQdQA8m6B6h9TvTEGu1ooceV1QfUH2nc7cTz4eosCrZ10LsWE2BEgGj1eK1KxSPnn3FZ+DDabYe1iNyGlpsqeaKAq34G82uzU42mTCuiOY+G1GHkz9wfO8Ty+Te5nqXj33uQh4Ehm4px5T/oDPnGEW/mYRXdZBH3/VNBA1wNycvdWXqX77jwi4i52p/YPnsVXKj1marZ35hHqszD+SQilGUoX1wuLRSjaxYwKSoOn2DRfXgwdKlve49KwK+CcDCPEUAWKK4rFIik+NRSkN5l8pc7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++cr9vxfCpMKeI+btamoKGXaGmaGPRz8R5SfxcJA4D8=;
 b=hR3Wz95TWuQtbkBqz07tJ9+g5CXJE2ieebMwsdNRVpOA9wl4aQ53fVjB/BTuXJyPVAHZ92MX+J73+VA4fpQboVJpc2IwE9fCzFr4aplE/MAps77+989jhQzjBPjJQR2Uq3PODOIOp65Q9B0de05diIusyb74ZJnIAfGrSWC0aa2UZqVaoHR+/PpZ/Xl9ySBfsObfAUeRijPl4fkzP95k3BakzdJTA32IdjljZ8fF5SkF32+w5fjeCLMoLy+IVsU8b0EbpRPWwi8TgkaDIEMf6piSj3AFuVHIr4IctntrOWTkqmNk498fuNA9vrzGlzwQEK3SQDNhZUwp5ZQYfEdCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1900.namprd12.prod.outlook.com (10.175.89.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 11:38:40 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 11:38:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Thread-Topic: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Thread-Index: AQHVpQNF7sQDwMPhqkCeX4PVICusHqee42Ew
Date: Wed, 27 Nov 2019 11:38:40 +0000
Message-ID:
 <DM5PR12MB1418D76FD9E6E7748C2F9997FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-5-git-send-email-le.ma@amd.com>
In-Reply-To: <1574846129-4826-5-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-11-27T11:35:06Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5a3f667d-0c74-4872-8fe3-0000444d8756;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2019-11-27T11:38:37Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 51f4c0ea-0054-42a8-a59d-0000f8cb2a15
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ed68714-e840-4337-2f74-08d7732e59b9
x-ms-traffictypediagnostic: DM5PR12MB1900:|DM5PR12MB1900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1900AA88C97353A6FD79CFA4FC440@DM5PR12MB1900.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(13464003)(71190400001)(71200400001)(5660300002)(6436002)(52536014)(99286004)(6116002)(229853002)(66066001)(3846002)(86362001)(33656002)(478600001)(53546011)(55016002)(81166006)(102836004)(2906002)(14454004)(81156014)(186003)(26005)(8676002)(8936002)(446003)(256004)(14444005)(4326008)(54906003)(7736002)(305945005)(11346002)(6246003)(7696005)(74316002)(66556008)(66476007)(2501003)(64756008)(66446008)(76116006)(9686003)(66946007)(76176011)(316002)(110136005)(6506007)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1900;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZc8A+U5cxwxiGfihyWLPzT7q1JexWoNqCb7DwOSgDb+bGTiLJk0Go0kz7cwkyQ30Fn6+lLlTZnVC2bFBHzHQw+uw5o13nfAxPuoEmVYdx9pJL2eIQRzFmFIYGEvIPiovJrEO6xl+fuM3cVfige1UbuoK4VcOZD5wP9KR6gkobGo904szz5SKeSXkf+UHlLmf846bpF1tvVhXGED4kiwF/Ct/Uly8VT6Of1R+lB1EKGEaYszS4W12Tsj/lioz9FygJHtijJIXQFV5/YoGx875k34e/KMdToaPWfNF6RZfQFOdL1qtkSJBYTJ4YwsVi6mo6Fdy5dJikWq9zygmvmP0OCZ2tYqkDYKwnwxPbfpiXmGvDxTOdKsyh7ennqA1/aw+Mu+qNNK2O+88nTR/w1mrw0xAFFaFN1QVNUtaePF/+I2yFn84S2DqfDhMs9h00BY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed68714-e840-4337-2f74-08d7732e59b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 11:38:40.5753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydbTJgeDPLzHx6vtgJs/qFMlbMvPw5UdYPWgJIxgI5qt66HfYMs4UkdlnLdPsL4OSanY2H8JQeir51/HZiJXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++cr9vxfCpMKeI+btamoKGXaGmaGPRz8R5SfxcJA4D8=;
 b=xlh6FrNb8qjWKkWDEYHha2ey+TPkvEaNeg5Kg7kefyrcruKVHcBftFASGC4gDDvUiZGg/1awe7TehvwfMqibeSFZ9IoAXgVlBdReOBxdBvZfwU7o9ORtrs8dWySLhxkGk2ZdNtVxO5TlsZ8cg5HSP1nNAeMr7gI+A886DLkDRGY=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127113840.Cl4qe_Acf_0QVhFPwT4V6stcaII4fuGi93EX12j0WNo@z>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpBbmQgSXQgaXMgc3RpbGwgbmVjZXNzYXJ5IHRvIHB1dCBhbGwg
dGhlIGNvbmRpdGlvbiBjaGVjayBpbiBhIGZ1bmN0aW9uLiBJIG1lYW4gYSBmdW5jdGlvbiB0aGF0
IGRlY2lkZSB0byBnbyByYXMgcmVjb3Zlcnkgb3IgbGVnYWN5IGZhdGFsX2Vycm9yIGhhbmRsaW5n
LiBUaGUgUE1GVyB2ZXJzaW9uIHRoYXQgc3VwcG9ydCBSQVMgcmVjb3Zlcnkgd2lsbCBiZSBkaWZm
ZXJlbnQgYW1vbmcgQVNJQ3MuIEN1cnJlbnQgdmVyc2lvbiBjaGVjayBvbmx5IHdvcmtzIGZvciBW
RzIwLiBJbiBmYWN0LCBvbmNlIHJhcy0+c3VwcG9ydGVkIGlzIHNldCBhbmQgcHJvcGVyIFBNRlcg
aXMgZGV0ZWN0ZWQsIFJBUyByZWNvdmVyeSB3aWxsIGJlIHRoZSBiZXN0IGNob2ljZSBubyBtYXR0
ZXIgaXQgaXMgc0dQVSBvciBtR1BVLg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGUgTWEgPGxlLm1hQGFtZC5jb20+IA0KU2VudDogMjAx
OeW5tDEx5pyIMjfml6UgMTc6MTUNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Q2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBDaGVuLCBHdWNodW4g
PEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExp
LCBEZW5uaXMgPERlbm5pcy5MaUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgTWEsIExlIDxMZS5NYUBhbWQuY29tPg0KU3ViamVjdDogW1BB
VENIIDA2LzEwXSBkcm0vYW1kZ3B1OiBhZGQgY29uZGl0aW9uIHRvIGVuYWJsZSBiYWNvIGZvciB4
Z21pL3JhcyBjYXNlDQoNCkF2b2lkIHRvIGNoYW5nZSBkZWZhdWx0IHJlc2V0IGJlaGF2aW9yIGZv
ciBwcm9kdWN0aW9uIGNhcmQgYnkgY2hlY2tpbmcgYW1kZ3B1X3Jhc19lbmFibGUgZXF1YWwgdG8g
Mi4gQW5kIG9ubHkgbmV3IGVub3VnaCBzbXUgdWNvZGUgY2FuIHN1cHBvcnQgYmFjbyBmb3IgeGdt
aS9yYXMgY2FzZS4NCg0KQ2hhbmdlLUlkOiBJMDdjM2U2ODYyYmUwM2UwNjg3NDVjNzNkYjhlYTcx
ZjQyOGVjYmE2Yg0KU2lnbmVkLW9mZi1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+DQotLS0NCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgNCArKystDQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMNCmluZGV4IDk1MTMyN2YuLjYyMDIzMzMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MxNS5jDQpAQCAtNTc3LDcgKzU3Nyw5IEBAIHNvYzE1X2FzaWNfcmVzZXRfbWV0aG9kKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIAkJCXN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpo
aXZlID0gYW1kZ3B1X2dldF94Z21pX2hpdmUoYWRldiwgMCk7DQogCQkJc3RydWN0IGFtZGdwdV9y
YXMgKnJhcyA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7DQogDQotCQkJaWYgKGhpdmUg
fHwgKHJhcyAmJiByYXMtPnN1cHBvcnRlZCkpDQorCQkJaWYgKChoaXZlIHx8IChyYXMgJiYgcmFz
LT5zdXBwb3J0ZWQpKSAmJg0KKwkJCSAgICAoYW1kZ3B1X3Jhc19lbmFibGUgIT0gMiB8fA0KKwkJ
CSAgICBhZGV2LT5wbS5md192ZXJzaW9uIDw9IDB4MjgzNDAwKSkNCiAJCQkJYmFjb19yZXNldCA9
IGZhbHNlOw0KIAkJfQ0KIAkJYnJlYWs7DQotLQ0KMi43LjQNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
