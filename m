Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD5CC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 10:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530052067D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 10:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530052067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA4289D99;
	Mon, 18 Nov 2019 10:28:51 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740070.outbound.protection.outlook.com [40.107.74.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C57389D99
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 10:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltod1DG5PRZNTl2MxaX5Y1wGe9waCtERTTejG6YUxVdkOB00BsqFGQOgZARkunHNe4xqiV4jgF1GII5wZbir9MK70GtyAf/7363NcaILgC5spDiKiXUJ/CMBaoMNVD0iXji/HIvUebiMPm8S/REl3XwmR3gtm5X/QoZ6T++xKnxN2M1Vu3RtJZuPl9znh398Y5Zph9igQeGyGg+NprSxIlLSDAcPfFPN4Hz6tdz4We8Ndnaii8jQpic2kRbYI2Cxhe8k1z98u52ytn8Lfa1bEtXaEH87ivPcLe1Q0+nwJvjHjd5S0kXJLyLGHgpltKJlxsgc1cHEm586GKjGY7Fuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTy65uaa7OpqHbsYzm2QhxkicgJIkLVv8gzz2Ws/oZQ=;
 b=gvLPDCliflzUZEEdGlzpOLC1fZcqKCzSyVkRVqWOQBOWVHN67u9a0+/RKpl7hNDp0pSNEVL0J1YfN4dpcGhFaFUxfDxEw4D0ZgwW5SqcZKFeeqDFc8IFIWMI2U8U7uW2HkItO/VMHuXe2EU5N4E4tbPMregeqLdC/01HeA9hyR/SwjBdCK+zYOchLQiWaO+y3zufs509sFV+vN8R/FfTa6Fm7o2xAqEi1qcpfgyoGxMqOqU589ydRWvbdbDJxCfnl6Sg0hrZgUmip0AVIhq/Sq7COME9Ynl5BeOy+EyDSl/vGiOaDAKHrrKmoMpp6mcVxRVNqzA7wjO2soIRfay0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB4144.namprd12.prod.outlook.com (10.255.224.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Mon, 18 Nov 2019 10:28:49 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::b4df:f954:fd7b:2062]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::b4df:f954:fd7b:2062%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 10:28:49 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: pull ras controller int status only when ras
 enabled
Thread-Topic: [PATCH] drm/amdgpu: pull ras controller int status only when ras
 enabled
Thread-Index: AQHVnfnF0bsfV0c+Bk2LjbpGJUN2HKeQufPA
Date: Mon, 18 Nov 2019 10:28:49 +0000
Message-ID:
 <MN2PR12MB3663DBE19FC8EA8DE6256A1FFB4D0@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <20191118102010.21727-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191118102010.21727-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bd0ec00-dc18-495b-bfd8-08d76c1219b3
x-ms-traffictypediagnostic: MN2PR12MB4144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB414409C965ECFC3A44FAEA9CFB4D0@MN2PR12MB4144.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(13464003)(110136005)(71190400001)(71200400001)(4326008)(9686003)(52536014)(7696005)(478600001)(53546011)(6506007)(33656002)(2906002)(2501003)(6246003)(66066001)(229853002)(6116002)(256004)(6636002)(81166006)(81156014)(8936002)(8676002)(76116006)(305945005)(7736002)(66946007)(86362001)(66476007)(76176011)(25786009)(3846002)(66446008)(64756008)(99286004)(486006)(476003)(11346002)(446003)(14454004)(26005)(74316002)(102836004)(316002)(55016002)(186003)(6436002)(5660300002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4144;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggmDKhAIXSOpDgAhfBOCA01Ce8JkA0BRZjLnw/QjSZIZTWc8G/gRnE5DoGfn87pG0nRsyslaEtUeGYbIYBh/PIRw69OGTY84cWu6eJ6CWOyF859WtqSCa58yCcb4ArzRLCgu957KpzQX2rc5M9Ee3qRTb69evNxNiYIa49Mpcl9QSnrGTcH1a6vZhrycksShTiQrfgjYI14ulZDLVykM5o6ZwxKZdXmpZqFQqtNiiVmyw3s2/TNnLumgbP4ltjB+MsKZOy1Vs0O2EMSSswoWS+jNmjI+ZwZnKID/Zmzw2rpy0wu+bJDjUWkYuhLgroScUk8IUauDHsEQdbEPQoNXLAz3hJPRQO7UFkhyb8B821orAQdNQ/zpZHUx/nctjDD7nX4lNpCOAMr2TYaV9VTE2YJvQbXkgTLn8+NHuBtIzaqdXId884eQjxQm25HAUpW8
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd0ec00-dc18-495b-bfd8-08d76c1219b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 10:28:49.1916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvXHZVwLNTlGsp/t+EiZgHajipQFomUeXrl00Rll8FxCfFSvHvnq/wj91/ew42JvtPHudFuXyLxPd8FA+DXX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTy65uaa7OpqHbsYzm2QhxkicgJIkLVv8gzz2Ws/oZQ=;
 b=07H2nI8A+qLVALvP9Jey9VIMITSuDFbx9AGulnolB5CRSV8aVmj+Hk4C9iapifIym03wjfAYXtphouaMXUbjVgB6lF+d92uiSfSONqhUKLg/fB/pHeGfHnxEICzQ3HK2zLSUVDan/8+Rv8VHGudezyYSszaCYN3jZNtRIVJCEdo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118102849.ddRAHBEPPrh3ynHkArJkVdi4hHcVYBaGVqtsf-eITeU@z>

UmV2aWV3ZWQtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZyb206IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT4gClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTgsIDIwMTkgNjoyMCBQTQpUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRz
QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
CkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWRncHU6IHB1bGwgcmFzIGNvbnRyb2xsZXIgaW50IHN0YXR1cyBvbmx5IHdoZW4g
cmFzIGVuYWJsZWQKCnJhc19jb250cm9sbGVyX2lycSBhbmQgYXRodWJfZXJyX2V2ZW50X2lycSBh
cmUgb25seSByZWdpc3RlcmVkIHdoZW4gUENJRV9CSUYgcmFzIGlzIG1hcmtlZCBhcyBzdXBwb3J0
ZWQuIGFzIHRoZSByZXN1bHQsIHRoZSBkcml2ZXIgYWxzbyBqdXN0IG5lZWQgcHVsbCB0aGUgaW50
IHN0YXR1cyBpbiBzdWNoIGNhc2UuCgpDaGFuZ2UtSWQ6IEliZDFmMjliZTI1M2UwZTYwZjliZTdm
ZjIyMDhmNWNmMmI3OGE1NmE0ClNpZ25lZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcu
WmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJx
LmMgfCAxNyArKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2lycS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5j
CmluZGV4IDBkZmE3MzkzNmE3Ni4uNjYyM2ZlNDJjZTRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2lycS5jCkBAIC01Miw2ICs1Miw3IEBACiAjaW5jbHVkZSAiYW1kZ3B1X2Nv
bm5lY3RvcnMuaCIKICNpbmNsdWRlICJhbWRncHVfdHJhY2UuaCIKICNpbmNsdWRlICJhbWRncHVf
YW1ka2ZkLmgiCisjaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIgogCiAjaW5jbHVkZSA8bGludXgvcG1f
cnVudGltZS5oPgogCkBAIC0xNTksMTMgKzE2MCwxNSBAQCBpcnFyZXR1cm5fdCBhbWRncHVfaXJx
X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqYXJnKQogCSAqIHJlZ2lzdGVyIHRvIGNoZWNrIHdoZXRo
ZXIgdGhlIGludGVycnVwdCBpcyB0cmlnZ2VyZWQgb3Igbm90LCBhbmQgcHJvcGVybHkKIAkgKiBh
Y2sgdGhlIGludGVycnVwdCBpZiBpdCBpcyB0aGVyZQogCSAqLwotCWlmIChhZGV2LT5uYmlvLmZ1
bmNzICYmCi0JICAgIGFkZXYtPm5iaW8uZnVuY3MtPmhhbmRsZV9yYXNfY29udHJvbGxlcl9pbnRy
X25vX2JpZnJpbmcpCi0JCWFkZXYtPm5iaW8uZnVuY3MtPmhhbmRsZV9yYXNfY29udHJvbGxlcl9p
bnRyX25vX2JpZnJpbmcoYWRldik7Ci0KLQlpZiAoYWRldi0+bmJpby5mdW5jcyAmJgotCSAgICBh
ZGV2LT5uYmlvLmZ1bmNzLT5oYW5kbGVfcmFzX2Vycl9ldmVudF9hdGh1Yl9pbnRyX25vX2JpZnJp
bmcpCi0JCWFkZXYtPm5iaW8uZnVuY3MtPmhhbmRsZV9yYXNfZXJyX2V2ZW50X2F0aHViX2ludHJf
bm9fYmlmcmluZyhhZGV2KTsKKwlpZiAoYW1kZ3B1X3Jhc19pc19zdXBwb3J0ZWQoYWRldiwgQU1E
R1BVX1JBU19CTE9DS19fUENJRV9CSUYpKSB7CisJCWlmIChhZGV2LT5uYmlvLmZ1bmNzICYmCisJ
CSAgICBhZGV2LT5uYmlvLmZ1bmNzLT5oYW5kbGVfcmFzX2NvbnRyb2xsZXJfaW50cl9ub19iaWZy
aW5nKQorCQkJYWRldi0+bmJpby5mdW5jcy0+aGFuZGxlX3Jhc19jb250cm9sbGVyX2ludHJfbm9f
YmlmcmluZyhhZGV2KTsKKworCQlpZiAoYWRldi0+bmJpby5mdW5jcyAmJgorCQkgICAgYWRldi0+
bmJpby5mdW5jcy0+aGFuZGxlX3Jhc19lcnJfZXZlbnRfYXRodWJfaW50cl9ub19iaWZyaW5nKQor
CQkJYWRldi0+bmJpby5mdW5jcy0+aGFuZGxlX3Jhc19lcnJfZXZlbnRfYXRodWJfaW50cl9ub19i
aWZyaW5nKGFkZXYpOworCX0KIAogCXJldHVybiByZXQ7CiB9Ci0tCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
