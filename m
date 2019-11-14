Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2BEC432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 02:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5A3206E4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 02:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5A3206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057206E091;
	Thu, 14 Nov 2019 02:41:06 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820081.outbound.protection.outlook.com [40.107.82.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB40C6E091
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 02:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXEHq34PmCDzhXBMGjpSgX+zK/to7Te2PCGm/rjhRoEh5CfpwNxBguDRBWgNiinOtlMEn48YY+/j5LaE7td/w/YGeqUdJsO0IuKmsJqNUVTGmCP42QfmkxefhuicJGxDmsApoxhU9Lgb3I3wyzzpIRCBGo5Qq+ipuqhKgePULv2NRv0UcD/PjL824lg33+D7+Nk3VVJ7xErh3qiiPH8Xa289sMq9wAIZFCPYlHQ2GlpqBrEkHW7rIY9AmIfAZ+l3h9jpdpKLjgWInnk/LtpxT2pPH7muZv1Mw9JV0ENKWBkINHRoZ/6xHSGr935RkiKUjKsRTBnmqSsokhfTZeYdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/tZV5ZTSFMpe1AAuX/I0MF31EVXFDKOSOSPPd5IKws=;
 b=ZODbbzJMfHois24FP5FZwSEevO6Ztcy0pbq5CcrT6pQtcMyzKEAJoO6sRGsOOlB//96Rj4G3mtqrfxdJZZqizOrtGZ3S/mHCkKo2oFQst3eUtNkRBbS7zNOyTNeIjf0W2B4hFWaHEwTxDSst80wcyU+37vIWyvNfI6eAhLnQa7nbhuTEw7VeZ5/Fl+nCKngFbfG8c5qfA3whrtcpNqAWvOr3gy+5hN/I6bMjhVY0CeVG1EDeL4p7bpGHdpezm8y40cNA8Gwog6RgbCexVe4A1amONhH3yW9Q5RSnicqSXROfjpuHUb7S2K92G4f+v9q2PmF7c81FNY3fijbXKwxH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3390.namprd12.prod.outlook.com (20.178.242.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 02:41:02 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::b4df:f954:fd7b:2062]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::b4df:f954:fd7b:2062%7]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 02:41:02 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: init umc functions for arcturus umc ras
Thread-Topic: [PATCH 2/2] drm/amdgpu: init umc functions for arcturus umc ras
Thread-Index: AQHVmjKq2ShDdIlvq0q/iSZtnvs5NqeJ9UPw
Date: Thu, 14 Nov 2019 02:41:02 +0000
Message-ID:
 <MN2PR12MB3663F9FE0446E6C4C8D037D7FB710@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <20191113145705.12298-1-Hawking.Zhang@amd.com>
 <20191113145705.12298-2-Hawking.Zhang@amd.com>
In-Reply-To: <20191113145705.12298-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12a33cdd-7165-4503-2f02-08d768ac16f3
x-ms-traffictypediagnostic: MN2PR12MB3390:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33909BF49258C9416984B223FB710@MN2PR12MB3390.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(13464003)(199004)(478600001)(25786009)(2501003)(53546011)(256004)(14454004)(33656002)(102836004)(99286004)(6116002)(6246003)(7736002)(74316002)(305945005)(2906002)(3846002)(446003)(11346002)(71200400001)(71190400001)(76116006)(7696005)(6636002)(26005)(76176011)(186003)(6506007)(486006)(476003)(5660300002)(52536014)(316002)(6436002)(81156014)(66066001)(66446008)(66946007)(86362001)(4326008)(229853002)(66476007)(55016002)(8676002)(66556008)(110136005)(81166006)(64756008)(9686003)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3390;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sgp1ingyvrMT2bxwB4I1TVrr6OKv0OeeCcnPkEmZx3hAW1a/pVeXEMo8xtyZm5PbNZPDDN1XoYhgJqeYhEOsrNXvnK3tL5iaT2hruNJ72Z7zGGep4R/MWdmqoxrsX1njHHLhj9eAwQUzmEhRi4LXNddk9vDCD2FuWz/Svg67B3mIdwkjpgw9tlAyEN0gVqtMtEHFZ5WeMBmCi1sn+ksjEvNL8wD7BmGqI2Sby9vA2io+gloOzpFKNndHTgJOQfDFcpeC3+YNbSfZbN908glZocFKLdDmMat8T9rFDebnPbsC/oa6MjV2z3QvmhblRIvOQH8pYUh6VevmAz66JbMi3ohCIpcQxiExk2l2k0+8iOTq1bChxuxYnFt6K2ZrWFD1JTgCMTs5aG8LF1+vNE9mAvnCQTItHhiNGjhmukSoNDe8/g6mPJtodeCPZ5507YEj
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a33cdd-7165-4503-2f02-08d768ac16f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 02:41:02.3225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkaRc4+8jvcJbCqGJzIf1xMMYjB5rhd6RoK5d451ULh87cudG0rnBUQamjadyzPOe7X6sIswuYvNZYbOOhS/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3390
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/tZV5ZTSFMpe1AAuX/I0MF31EVXFDKOSOSPPd5IKws=;
 b=3GT/ucrFvGU2Uv9RUxGF/M1EJfpK9OnS1CQePKGWRojU/MnPFFp0X2IQjyouwBQn7ATisr7JY5c/nxoKRzyEPSiHAmgcSMXjbJ852KTL/xwOuS+DVYy1Ke82N31JQHAYyedhwaoGv/0pCJekotLU7JT5C3V6AZJAALuMer2swiY=
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
Message-ID: <20191114024102.QDWlL0vFwRaTi9E_DufK_3WP-JGlKSc8bJmfGvasQ74@z>

UmV2aWV3ZWQtYnk6IEpvaG4gQ2xlbWVudHMgPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT4KCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZyb206IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT4gClNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMTkgMTA6NTcgUE0KVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47IENs
ZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+CkNjOiBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBp
bml0IHVtYyBmdW5jdGlvbnMgZm9yIGFyY3R1cnVzIHVtYyByYXMKCnJldXNlIHZnMjAgdW1jIGZ1
bmN0aW9ucyBmb3IgYXJjdHVydXMgdW1jIHJhcwoKQ2hhbmdlLUlkOiBJYThhZjNjMjBhNzE3Yzc2
ZWMxOGFhNWZhMzMyY2ZkODFjYTYwZmY2OQpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCAzNzg0YjYyMjAxYjAuLjhhNWI3MjJjZTVi
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCkBAIC02MzUsNiArNjM1LDcg
QEAgc3RhdGljIHZvaWQgZ21jX3Y5XzBfc2V0X3VtY19mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAkJYWRldi0+dW1jLmZ1bmNzID0gJnVtY192Nl8wX2Z1bmNzOwogCQlicmVhazsK
IAljYXNlIENISVBfVkVHQTIwOgorCWNhc2UgQ0hJUF9BUkNUVVJVUzoKIAkJYWRldi0+dW1jLm1h
eF9yYXNfZXJyX2NudF9wZXJfcXVlcnkgPSBVTUNfVjZfMV9UT1RBTF9DSEFOTkVMX05VTTsKIAkJ
YWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW0gPSBVTUNfVjZfMV9DSEFOTkVMX0lOU1RBTkNFX05V
TTsKIAkJYWRldi0+dW1jLnVtY19pbnN0X251bSA9IFVNQ19WNl8xX1VNQ19JTlNUQU5DRV9OVU07
IEBAIC03NDgsNiArNzQ5LDcgQEAgc3RhdGljIGludCBnbWNfdjlfMF9sYXRlX2luaXQodm9pZCAq
aGFuZGxlKQogCQlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewogCQljYXNlIENISVBfVkVHQTEw
OgogCQljYXNlIENISVBfVkVHQTIwOgorCQljYXNlIENISVBfQVJDVFVSVVM6CiAJCQlyID0gYW1k
Z3B1X2F0b21maXJtd2FyZV9tZW1fZWNjX3N1cHBvcnRlZChhZGV2KTsKIAkJCWlmICghcikgewog
CQkJCURSTV9JTkZPKCJFQ0MgaXMgbm90IHByZXNlbnQuXG4iKTsKLS0KMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
