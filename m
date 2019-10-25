Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC53CA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 22:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3109621D7B
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 22:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3109621D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8B16EBBD;
	Fri, 25 Oct 2019 22:59:57 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680050.outbound.protection.outlook.com [40.107.68.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E760A6EBC0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2019 22:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0t3tZJRmhfdvrbL4OF6BkC+NJRBqlaGLfNzn8BfOE0hxKYaBDIjTcugfZ4vr2Oa4QyrBygkoHBnFG3sclc+SKXwvTloAOAtcSvft6eQZ3PadBZfxD64kMqyfRqlm+rUAhpjyDxxyESEP0wUaWYgrc9XaXrLIopWKjiQtEnrjjhK1sAZKEtPgzWo353vj+J2VUtLAETz24OO7jMln1ODTmv0oePIgf+WOpOWCHfh9XpHbuOIpN4dMpHS/U9b5G3iTeffc8psSlFuh2aLh6ufrdftTg2Hp64ZReLYnKOPETtKUayff8mfi6kSPMwhLmJYgWqLT67qrh8aMESMCg4Mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/TtpvVQLIJcfrNN8Hb4JbZIYXWWLOCK20GAfqe6z5o=;
 b=oYLhN6IcaSl0uzZ2x2zfCGGUbxDPL6m6RV5tnSMvqe+jZwFKmnaPyqBsJxn8Bl6rTzxGipYxuwbIOF3+V4gjN7JzWGK+pH41DYNg4rZvpZS5EDsliijvqq5sw8Z2YN4IFYbJzA/PweAnEw0JUqupOMiMVYm90VpxOvaOuU/rRKWVxfYgHFB53q2ermF8hU4CTBZc9Fr+X4DdYj2ldSkI/PE2RZut2QVTNB6WAvz+3ChPTtRgi6kBGgbzol1uTim9tqGT196CkvEsbH7kV0Egn5wMLRBtXf8jg9iiuT5cHqMf43UMlKp+60SLYwEp6LpPfMXS4GAfG6kHE6gsy1EDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.198.10) by
 DM6PR12MB3580.namprd12.prod.outlook.com (20.178.199.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 22:59:52 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::58fb:d29:4e24:b487]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::58fb:d29:4e24:b487%6]) with mapi id 15.20.2387.025; Fri, 25 Oct 2019
 22:59:52 +0000
From: "Tuikov, Luben" <Luben.Tuikov@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: GFX10: GRBM requires 1-cycle delay (v2)
Thread-Topic: [PATCH] drm/amdgpu: GFX10: GRBM requires 1-cycle delay (v2)
Thread-Index: AQHVi4fpLtg5KT91t0a23zJ2G37sVQ==
Date: Fri, 25 Oct 2019 22:59:52 +0000
Message-ID: <20191025225930.15074-1-luben.tuikov@amd.com>
References: <b40c78f1-17a5-f0f9-183e-0c78fd7163e9@amd.com>
In-Reply-To: <b40c78f1-17a5-f0f9-183e-0c78fd7163e9@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:38::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0.385.gbc12974a89
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a8095d6-4b0a-470e-f5a7-08d7599f0b91
x-ms-traffictypediagnostic: DM6PR12MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35805FD60304BE86E92BEA8F99650@DM6PR12MB3580.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(66446008)(6116002)(6436002)(99286004)(2906002)(5640700003)(6512007)(14454004)(8936002)(4326008)(50226002)(81166006)(81156014)(478600001)(316002)(8676002)(25786009)(54906003)(36756003)(66066001)(14444005)(256004)(86362001)(305945005)(7736002)(6916009)(6486002)(5660300002)(446003)(486006)(2616005)(11346002)(66946007)(476003)(66556008)(66476007)(102836004)(64756008)(6506007)(2351001)(386003)(26005)(52116002)(3846002)(76176011)(186003)(1076003)(71200400001)(2501003)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3580;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l49l8e0tedttLgE0GX5om/MMlOjNcyBupLdaUYdyn8Q7X+665QmNY9b9bce17QtCRpGGwu0teqY1LjR/mmG0FlPsCBB7XEWfL+ZnWDBYFNczcVtr6SJe7jKWo527O7ngYUgP/66Gl62VdpGwZhDOOtfoBXycoZK04zgaabwEmgaoVvNRzY3gbgjxbr/9yyoMGmV+S/MFPLiJoet3Mes1N7YvV3rXY4ngPopvxhRDaFXLA/CpMffx4lQUswxq+wM3f4NMAoFwMV10tSOsHhrsO7MZYO4Z3Zymzs/Rnj5Odr53XpCc1pW3kLIyNjpr7OmHP4IqfxGYqbUj9nL12Y3tHPs8BnAYIbxRnsn901yli2xQ1ulMbLNGlI7shScm79tOLTP/M9w9cyBh8BVuhOZvMXjIYbWq/mUJzrwOlKsKufq6VxI/cEWwiBnHj7+HnTiw
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8095d6-4b0a-470e-f5a7-08d7599f0b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 22:59:52.6960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+5M3zp/M81tH8dIMT1vuZ8UV3COVfaxsweCKvYdInvnpfmziM5s6xWKumLJVU2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/TtpvVQLIJcfrNN8Hb4JbZIYXWWLOCK20GAfqe6z5o=;
 b=PDohp/dBbbF99MB43aMHGqGWMot2NMUJVPh9UABTQIWB4Xs18DgoPP56mSydrxK6U0hwIsErWZDCeW9AUruQrXSmjQzxINSAeAXDQ40+YZjJNlv67n5fwYLEAl9Y1YaWbMdSBBp3Y/xXarqR3FJTHD+UiTNU72uotu4dfx6vV9U=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025225952.IX9_UJ8uu9i2OFkTobAK5Ncn87h3Cl32D3i4BxuL9CY@z>

VGhlIEdSQk0gaW50ZXJmYWNlIGlzIG5vdyBjYXBhYmxlIG9mIGJ1cnN0aW5nCjEtY3ljbGUgb3Ag
cGVyIHJlZ2lzdGVyLCBhIFdSSVRFIGZvbGxvd2VkIGJ5CmFub3RoZXIgV1JJVEUsIG9yIGEgV1JJ
VEUgZm9sbG93ZWQgYnkgYSBSRUFELS1tdWNoCmZhc3RlciB0aGFuIHByZXZpb3VzIG11dGktY3lj
bGUgcGVyCmNvbXBsZXRlZC10cmFuc2FjdGlvbiBpbnRlcmZhY2UuIFRoaXMgY2F1c2VzIGEKcHJv
YmxlbSwgd2hlcmVieSBzdGF0dXMgcmVnaXN0ZXJzIHJlcXVpcmluZyBhCnJlYWQvd3JpdGUgYnkg
aGFyZHdhcmUsIGhhdmUgYSAxLWN5Y2xlIGRlbGF5LCBkdWUKdG8gdGhlIHJlZ2lzdGVyIHVwZGF0
ZSBoYXZpbmcgdG8gZ28gdGhyb3VnaCBHUkJNCmludGVyZmFjZS4KClRoaXMgcGF0Y2ggYWRkcyB0
aGlzIGRlbGF5LgoKQSBvbmUgY3ljbGUgcmVhZCBvcCBpcyBhZGRlZCBhZnRlciB1cGRhdGluZyB0
aGUKaW52YWxpZGF0ZSByZXF1ZXN0IGFuZCBiZWZvcmUgcmVhZGluZyB0aGUKaW52YWxpZGF0ZS1B
Q0sgc3RhdHVzLgoKU2VlIGFsc28gY29tbWl0CjUzNDk5MTczMWNiNWZhOTRiNTUxOTk1NzY0NmNm
ODQ5Y2ExMGQxN2QuCgp2MjogUmVtb3ZlIEdGWDkgYW5kIGFwcGx5IG9ubHkgdG8gU0RNQSByaW5n
LgoKU2lnbmVkLW9mZi1ieTogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyB8IDcgKysrKysrKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgfCAyICstCiAyIGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3YxMF8wLmMKaW5kZXggNmUxYjI1YmQxZmU3Li5kZWRkN2UxYWIyZmIgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCkBAIC0zNDYsNiArMzQ2LDEzIEBAIHN0YXRp
YyB1aW50NjRfdCBnbWNfdjEwXzBfZW1pdF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZywKIAogCWFtZGdwdV9yaW5nX2VtaXRfd3JlZyhyaW5nLCBodWItPnZtX2ludl9lbmcw
X3JlcSArIGVuZywgcmVxKTsKIAorCS8qIEluc2VydCBhIGR1bW15IHJlYWQgdG8gZGVsYXkgb25l
IGN5Y2xlIGFmdGVyIHRoZSB3cml0ZSBSRVEsCisJICogYW5kIGJlZm9yZSB0aGUgQUNLIGlucXVp
cnkuCisJICovCisJaWYgKHJpbmctPmZ1bmNzLT50eXBlID09IEFNREdQVV9SSU5HX1RZUEVfU0RN
QSkKKwkJYW1kZ3B1X3JpbmdfZW1pdF9yZWdfd2FpdChyaW5nLAorCQkJCQkgIGh1Yi0+dm1faW52
X2VuZzBfcmVxICsgZW5nLCAwLCAwKTsKKwogCS8qIHdhaXQgZm9yIHRoZSBpbnZhbGlkYXRlIHRv
IGNvbXBsZXRlICovCiAJYW1kZ3B1X3JpbmdfZW1pdF9yZWdfd2FpdChyaW5nLCBodWItPnZtX2lu
dl9lbmcwX2FjayArIGVuZywKIAkJCQkgIDEgPDwgdm1pZCwgMSA8PCB2bWlkKTsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMKaW5kZXggYjhmZGIxOTJmNmQ2Li4wYzQxYjRmZGM1
OGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCkBAIC0xNTg4LDcgKzE1
ODgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIHNkbWFfdjVfMF9y
aW5nX2Z1bmNzID0gewogCQk2ICsgLyogc2RtYV92NV8wX3JpbmdfZW1pdF9waXBlbGluZV9zeW5j
ICovCiAJCS8qIHNkbWFfdjVfMF9yaW5nX2VtaXRfdm1fZmx1c2ggKi8KIAkJU09DMTVfRkxVU0hf
R1BVX1RMQl9OVU1fV1JFRyAqIDMgKwotCQlTT0MxNV9GTFVTSF9HUFVfVExCX05VTV9SRUdfV0FJ
VCAqIDYgKworCQlTT0MxNV9GTFVTSF9HUFVfVExCX05VTV9SRUdfV0FJVCAqIDYgKiAyICsKIAkJ
MTAgKyAxMCArIDEwLCAvKiBzZG1hX3Y1XzBfcmluZ19lbWl0X2ZlbmNlIHgzIGZvciB1c2VyIGZl
bmNlLCB2bSBmZW5jZSAqLwogCS5lbWl0X2liX3NpemUgPSA3ICsgNiwgLyogc2RtYV92NV8wX3Jp
bmdfZW1pdF9pYiAqLwogCS5lbWl0X2liID0gc2RtYV92NV8wX3JpbmdfZW1pdF9pYiwKLS0gCjIu
MjMuMC4zODUuZ2JjMTI5NzRhODkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
