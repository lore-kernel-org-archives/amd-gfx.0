Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF0CA9EC3
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 07:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF9F2083E
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 07:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF9F2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AABA6ED88;
	Thu, 31 Oct 2019 07:22:45 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700081.outbound.protection.outlook.com [40.107.70.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F4C6ED88
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 07:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMqOm52PIjpDSUdnX0Bq/Am+FCg2TDLRSjflZinhnfrT5wqnN+WPoEX1/NxunM61A2csp4sudzWBd5yYaln4+tKCGRRRR51j/iS9mxCMdKeRuV6ueTrN+EQDqBLjjAma4GZiByzcRFuocY+FVDEqCXt6tJK3POMKRVWinpJq3sjKLtFtE2R6/dwEgymqAbvnyIrXwGuNkYYEnZiRN2si6vF2oxptnmqOhqagiAF1UreWT+/TAalvhGeYipcTgFPEfka6Td4ZnYrOrdQXAQX/EApXZWlVbTKr7CPJj5S0brA3yy5xoztOJlNnpPcUm3ar84uTQRExb8jgA283bT6g3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDNC7JX3hyrkbWVCkTd2v7nnwHYb9okWvtP69kSQE5s=;
 b=gBl4+orOqjLiss2Ol9h79ETyDAEZAre6ccXxbyjtXziybAgkbVgrTCN1xuw0nb7NkYXaFfktPeYqR+ULFeuzyURJk/rMwydNWVPziElR1zc2ZogKa2VJWcZ3hn2SvqyKeSer6GKK5VSKzbbbzNO5zs9kFRaEfC04wTV27rGB3FB/le9nk/Wx3Q4o62jvOllYyCuizPTvsxL7XnyGwFpq3xUQhFxsB1aK3YsXqRCn2DiUXdg/ISNAd7uIadN3U+TqLIfTaC7jVgK2b6YKWhOimpRars5IxdQGNZ2wHAoQPVBXdvxNNWrXp29PmKo+DbR4j6JYRND/WmINYl0fDpp1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3853.namprd12.prod.outlook.com (10.255.236.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 31 Oct 2019 07:22:38 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 07:22:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/powerplay: update is_sw_smu_xgmi check
Thread-Topic: [PATCH 2/3] drm/amd/powerplay: update is_sw_smu_xgmi check
Thread-Index: AQHVj7v51O7zf+ucjE+aGhmJRVHGng==
Date: Thu, 31 Oct 2019 07:22:38 +0000
Message-ID: <20191031072205.27537-2-evan.quan@amd.com>
References: <20191031072205.27537-1-evan.quan@amd.com>
In-Reply-To: <20191031072205.27537-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:2e::19) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10f58ec1-f6dc-4005-4839-08d75dd31b81
x-ms-traffictypediagnostic: MN2PR12MB3853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB385329E593D691832B376B9EE4630@MN2PR12MB3853.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(5640700003)(36756003)(102836004)(14454004)(478600001)(81156014)(1076003)(81166006)(305945005)(99286004)(25786009)(6486002)(4326008)(316002)(6116002)(186003)(2906002)(66066001)(5660300002)(386003)(6506007)(86362001)(6436002)(3846002)(8676002)(71190400001)(71200400001)(2501003)(6916009)(14444005)(66446008)(8936002)(52116002)(6512007)(256004)(2351001)(50226002)(2616005)(11346002)(64756008)(26005)(476003)(66946007)(486006)(66476007)(66556008)(446003)(54906003)(76176011)(7736002)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3853;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6qI5Z7E7picIDWBVAgSgNJjhzm9KMtWqygIeczlDAaGMi64+A2/QHQoC6LVC+vx3ByvLXc4Znn0i5RdL5cUPur2UtEfHKH3I+fxsXMVNHllY7hBkHXc2ysdX9pQam0g5mcXLZ9uCwiD9Xyjm0kGVQ6NzlcAbesXe56AbtVmI4xzHN7dSH1UKzsSk9+h9QiU+QuSic75/3t8ejUmkLtzxKQzZMzex10Lp4L6X15dwAgwmI3W5YygVzPvlljPvQau6zW8H9SY/u/2kp5GrhIQNUqAJ+CynWA0jxquAJxo31+OEVmmDxrOud6oQFWHMzz3oNxQkMiM5ggeZ7vv4fx/EQnllNOR0IHxx1Kt+K5sXQ2znsHuXeoohocNkn/EXQHiiXpjw/HnIdPkeYTeBAn1o0iI4oF9oJQse4uwN+CyS3D2vCD8IGv2d7GZX6ZvfIXJ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f58ec1-f6dc-4005-4839-08d75dd31b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 07:22:38.1342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1x9iA5TH1G0HkuaVSoIp1kePAk8m7Aa+jIrPbT4rSmKdiwFZbQ3ya0gYvxMtIkaw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDNC7JX3hyrkbWVCkTd2v7nnwHYb9okWvtP69kSQE5s=;
 b=R2b5S6qwOAhjhHa4URvbki9qgigUd4ASPbYDl5DaqWg8MClg7QbyYQKoWEpKl8OTfAWRQzWfS3Q0CBKXbqLLiWi3jffRGOEJS+a1854QAJtWNBsjJ1fYoD01oPC2hdW89X+n8YXngwyy9W6npiTBcYz432aSnXRbPIHQCFtZqXY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031072238.vWikk-Z_QXkV0eIWAvRbwH7pxLXxBMVlKUCW3Yi8eFE@z>

QWRkIGNoZWNrIGZvciBpc19zd19zbXUgcm91dGluZSBhbmQgZHJvcCBjaGVjawpmb3IgYW1kZ3B1
X2RwbSB3aGljaCBzZWVtcyBub24tc2Vuc2UuCgpDaGFuZ2UtSWQ6IEkyYjY5NGE2MjU1YTc2ZDM1
MzA1ZmM2NGNhMzk2MjU3MzBlMzQ2M2RiClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5x
dWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3Nt
dS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IDNjZTAx
ZTE5OTRmYy4uZGMyMTMwYTMxNjhjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jCkBAIC01MjYsNyArNTI2LDcgQEAgYm9vbCBpc19zdXBwb3J0X3N3X3NtdShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogYm9vbCBpc19zdXBwb3J0X3N3X3NtdV94Z21p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewotCWlmIChhbWRncHVfZHBtICE9IDEpCisJ
aWYgKCFpc19zdXBwb3J0X3N3X3NtdShhZGV2KSkKIAkJcmV0dXJuIGZhbHNlOwogCiAJaWYgKGFk
ZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
