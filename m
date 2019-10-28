Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6FDCA9EBC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 10:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F83208C0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 10:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F83208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C6A6E53E;
	Mon, 28 Oct 2019 10:23:40 +0000 (UTC)
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr710050.outbound.protection.outlook.com [40.107.71.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DDD6E53E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 10:23:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkrRaPkCkavyrgkAslRhzuUigVmVyal4OdBtS4KFM6qoImJh76d4Zq4r2x6hXcKVhaUHAx43vRB4qb8gSLyn9jBD/Bi57gY/g5pIN9dQ4ZIf3ZHWGy4S9cQ4XGghblLLcWSdPaJr5TJiX6FLJ0w/gDjthzcjO8GNvJ/fSj+YSOwTRPs5+I5QF4DvA09ofuT5wwSIgVp8FhzExTIGEiw0h5XXX81HOL2hTnhwlQ1yAYSMp7PM65Juj68zetJMDY8ClpmjDUidYwDWIA4I9y6k4G5sL+eay6b83PAYVTNZQWjzNzMQxprubvCXLC0ofyUK54mFn0FB0Az4kY0LFgGkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHF7T1LHgj7u0gvbnRYNGC3AJ9I0yDuAqWgZ44LK9zQ=;
 b=bbDOvbbJbHOW7aoicgymIBaQhKp+qKXCS464JqdEV2VgYCZ00q80/YjGTxxSQWdlINVL6exqO7m9YGJSwget7Eww+BdORBdmjYxMkOJ5g5n12Y3brHDCfbaOJWmUD6O6Brs+/e7i+6EDl3PV5m7OtZDeumDE36tUqZmIsUpWVr0TJj9pzMYRl1pXpjFLP9+mGur2xmkAkIeTgc+uw4WDkVFvgVEmw6VRAMbpgjd1AaBcngBt3wRyYEzBFSyLZcVQraWknWhQcPFBPUYyfzBNmKUTXwYz8lRc4Iq6UvJUucnzhmkoetCXkMvQDkUc9R3fD3sGrdkBV7Lm5cIOrPedaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3056.namprd12.prod.outlook.com (20.178.242.143) by
 MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 10:23:31 +0000
Received: from MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::f951:43eb:5b8e:2a31]) by MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::f951:43eb:5b8e:2a31%4]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 10:23:31 +0000
From: <jianzh@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/SRIOV: Reorganize hw.status for SRIOV re-init
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: Reorganize hw.status for SRIOV re-init
Thread-Index: AQHVjXm/Eky73bJX+0qCX76Yu/qdJA==
Date: Mon, 28 Oct 2019 10:23:31 +0000
Message-ID: <20191028102311.16849-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To MN2PR12MB3056.namprd12.prod.outlook.com
 (2603:10b6:208:ca::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f2bb8f4-069d-4ced-3caa-08d75b90e16d
x-ms-traffictypediagnostic: MN2PR12MB2878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB28784182260FB9F4894ABF0BE1660@MN2PR12MB2878.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(64756008)(54906003)(486006)(66946007)(71200400001)(66066001)(71190400001)(5640700003)(6436002)(316002)(2616005)(476003)(6512007)(102836004)(6506007)(386003)(478600001)(1076003)(4326008)(26005)(186003)(5660300002)(256004)(14444005)(7736002)(99286004)(305945005)(50226002)(36756003)(25786009)(3846002)(2501003)(14454004)(52116002)(6486002)(2351001)(8676002)(81166006)(81156014)(6116002)(8936002)(2906002)(6916009)(66556008)(66446008)(66476007)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2878;
 H:MN2PR12MB3056.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVn06EMC13V8Wfsr+5WA9JcaRyiEMPyB0zg4NGGn3Tw68knsNTpfwa0dNAdJV6rX8Ib3g9Y6kF84BejWMWm+H4y1SdfNdGWrRPWk8MY9JBpGrtPNrHIXeXA1BVu8tF8dFju+7JDwiUXqGwPUJc8P74hvuzDQXwA9zEShaUIuMzKftvkffIHFFduUXaTXFT5CgvBkpefM8H+LSxygmKrezrciiphun2jrRJ/mtBHekFJKJqfIxaGg+sYwVofZKY3JVZQ+MOCcAx9DfZO/TBP8U5U/4xwmTo86r23j6TSBjeNE883kPukiWex6LxYO9fI4MxvGNO9h0S/lt0yZ75X/xKrqYW6iUdV6a9gyeuYWBshHkv2eYiXaLVGNGJHtGBAUFJ+H8t2HsFjQdu6ENlKw56Hb2+CxKhVArt0AsQuKOdpYOsKVZofrQ8Js7vqIPhHP
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2bb8f4-069d-4ced-3caa-08d75b90e16d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 10:23:31.3884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHHadbMe/KfpYydsz3D0Zijb6ixpgAebPjd2wU/E5vVM+3U1vJx4ng3H8jDOHMi0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHF7T1LHgj7u0gvbnRYNGC3AJ9I0yDuAqWgZ44LK9zQ=;
 b=N2wokhojEW+Hja3uUXQC2jdM5dVH+uiAmitJYD5oBVc2BzExTKJ3pmHZNbqNJJs74l+X/bvZtXa7Xg9jFQxczkeqiBT8zfvIjQC2M2TbWIdgzAfUpuhnN2vMySPhsdSnJX63FtxzjEr1x5OkhUyxVg77q1zbXzZI6jzaWYR6GoQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028102331.6AK2R34FI2H0v_gn336_6D3ua27AY5HWHucPiThVeU8@z>

RnJvbTogSmlhbmdlIFpoYW8gPEppYW5nZS5aaGFvQGFtZC5jb20+CgppbiBhbWRncHVfZGV2aWNl
X2lwX3JlaW5pdF9lYXJseV9zcmlvdiwgYWZ0ZXIgSUggaHdfaW5pdCwKb25seSBJSCdzIGh3LnN0
YXR1cyBpcyB0cnVlLiBPdGhlciB0aHJlZSBJUCdzIGh3LnN0YXR1cwphcmUgcmUtc2V0IHRvIGZh
bHNlLCBldmVuIHRob3VnaCB0aGV5IGhhdmUgYWxyZWFkeSBkb25lCmh3X2luaXQuCgpUaGUgbmV3
IHdheSBpcyB0byBkbyBod19pbml0IGZvciBlYWNoIElQIGluIHRoZSBsaXN0LApyZWdhcmRsZXNz
IG9mIGh3LnN0YXR1cy4gQW5kIHNldCBody5zdGF0dXMgb25seSBhZnRlcgpod19pbml0IGlzIGRv
bmUuCgpTaWduZWQtb2ZmLWJ5OiBKaWFuZ2UgWmhhbyA8SmlhbmdlLlpoYW9AYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA0ICstLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggNjc2Y2FkMTUyMzlmLi5kY2Nl
NDk4ZTg0ZTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMK
QEAgLTIzNTIsNyArMjM1Miw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9yZWluaXRf
ZWFybHlfc3Jpb3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCWZvciAoaiA9IDA7IGog
PCBhZGV2LT5udW1faXBfYmxvY2tzOyBqKyspIHsKIAkJCWJsb2NrID0gJmFkZXYtPmlwX2Jsb2Nr
c1tqXTsKIAotCQkJYmxvY2stPnN0YXR1cy5odyA9IGZhbHNlOwogCQkJaWYgKGJsb2NrLT52ZXJz
aW9uLT50eXBlICE9IGlwX29yZGVyW2ldIHx8CiAJCQkJIWJsb2NrLT5zdGF0dXMudmFsaWQpCiAJ
CQkJY29udGludWU7CkBAIC0yMzg5LDggKzIzODgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZp
Y2VfaXBfcmVpbml0X2xhdGVfc3Jpb3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQli
bG9jayA9ICZhZGV2LT5pcF9ibG9ja3Nbal07CiAKIAkJCWlmIChibG9jay0+dmVyc2lvbi0+dHlw
ZSAhPSBpcF9vcmRlcltpXSB8fAotCQkJCSFibG9jay0+c3RhdHVzLnZhbGlkIHx8Ci0JCQkJYmxv
Y2stPnN0YXR1cy5odykKKwkJCQkhYmxvY2stPnN0YXR1cy52YWxpZCkKIAkJCQljb250aW51ZTsK
IAogCQkJciA9IGJsb2NrLT52ZXJzaW9uLT5mdW5jcy0+aHdfaW5pdChhZGV2KTsKLS0gCjIuMjAu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
