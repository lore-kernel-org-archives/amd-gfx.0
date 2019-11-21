Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0883C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 06:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6F42089D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 06:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6F42089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62AD36E7B0;
	Thu, 21 Nov 2019 06:17:05 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820051.outbound.protection.outlook.com [40.107.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E57FF6E7B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 06:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG/pbi/NIsSL4xs3iM2E/DaO1jVTyQKC7/vHUooHB6D9AuY2IAxWz5cWQLVeywm8saNsmt7d4/vEOyjxd14u0BsR0M5gUu08jbkpcIezx1i6Xsdb2qCWg2jIK3RFFTYbCYR8PlZn6MzH7qpOsHfrEm6CysG0Pa8bPHXTl3dmoVhfZeVzePPfUcgGbCJK9CIMLUGNn24SDBo55kU81Sw2Oosp6PzaeVfy+UtPjLiSIg3L8+CzNCEtLExx3I8GNjcN6e1irUA8nm73imrlQPX8F0IAy951jgAoMSeSmG3lME47M1u9hPC1sxb29o/30oDLZd59EU/0Ud8XyQStfnRlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOCVljxLsYgUmCzx84kdXbLNKYjwqsMCHbCuKXUix7s=;
 b=F0SUsf8jckMnIGGhaONiVjjroYQ5qTarOLZGW2EdTbnlD/miVjSG53PHPtB4FmGc+ceY2xxoO2zPR+LBG7qx7Fe7UotijwMwlEGWeSnst2VABUvztRjJDLa1f2dyUqCgygjXMeN+pMe04AI9z1yS4mQtbGChlOk+EzxWuLAF+vTvuydYAoHiPB0IamQmFOEHRG+Mt+IS8P2zJ7CUVlh6K7G8EZwbUGHb9nUpze5WicALk2Z0Puw9gdMn2zDRyEW2vAIl4a1DbC/TpvkAY5gn4BDhT4jfbssAXXTAHRgWdX94A3FktNfoKlLlX0HXDRevEOxsOoShW31tKP8av7gVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0068.namprd12.prod.outlook.com (2603:10b6:3:103::30)
 by BYAPR12MB3477.namprd12.prod.outlook.com (2603:10b6:a03:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 21 Nov
 2019 06:17:00 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by DM5PR12CA0068.outlook.office365.com
 (2603:10b6:3:103::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Thu, 21 Nov 2019 06:17:00 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Thu, 21 Nov 2019 06:16:59 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 21 Nov
 2019 00:16:59 -0600
Received: from ubuntu-mi100.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 21 Nov 2019 00:16:58 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu/sriov temporarily skip ras, dtm,
 hdcp for arcturus VF
Date: Thu, 21 Nov 2019 14:16:55 +0800
Message-ID: <20191121061655.25904-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(428003)(189003)(199004)(8676002)(336012)(426003)(51416003)(4326008)(2351001)(486006)(476003)(14444005)(7696005)(2906002)(26005)(186003)(50226002)(8936002)(126002)(5660300002)(2616005)(81156014)(305945005)(1076003)(316002)(86362001)(36756003)(16586007)(81166006)(6916009)(356004)(6666004)(53416004)(48376002)(47776003)(70206006)(70586007)(478600001)(50466002)(142933001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3477; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eacc5d74-593b-4bb2-0a52-08d76e4a6b12
X-MS-TrafficTypeDiagnostic: BYAPR12MB3477:
X-Microsoft-Antispam-PRVS: <BYAPR12MB34777E3C1935D6278F4FD67EBB4E0@BYAPR12MB3477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0228DDDDD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRjxsCjVPyiRXNgxmZXHZrEMk/2gLfrZjwvsB49Uji1k69+rQRw2ZP5R7uHa99ZbuunTKDI/23TDuOXLJbK5s65RtPbzGOsct2vYKhkPgeyBmKLBUUEUjtE+Jz6D+PAGM3BWJ+2qkJcBbPhIDFLwhAnmfsNGU42a8lWh+X/ptJ/A2wN0XLhjElWBqQH7r8IhWeA+KxlYj6frn5L8Y+/yk3S1CMvYVEeU7pttg/l02bwhOHV8VtTtU7Z+GZQ4lbpsD9QKGui/MPqpEuR5ypRRPd3m0MMabPNcpUsSLmOgRTjmnoUazcwXaWs2M8IUpcOnCtNfdupW57NV5CoavOnkQbayyT9RUH0ItBsYYuMSzWmTZA7ucQPK7Ddtp07QyUgn5tqoguy47inILOg2wa2m8fSr8Zr7QoIGoQ+0H8X7ZCw3Ps81IUsAOgdupl2fKY7O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 06:16:59.8773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eacc5d74-593b-4bb2-0a52-08d76e4a6b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3477
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOCVljxLsYgUmCzx84kdXbLNKYjwqsMCHbCuKXUix7s=;
 b=PY7/5VXt5FVDnZyOfVkWauDob5JzK48CSpIWdSvsixyyQSg9ucoRJB0umc09o5ZTecLfIbpqmZXfhpguYo+LtngDT8El1N1wRX0u0vIPXLNa1io69ci4q3N28Fub3+3CCM92sTNuqcDGRqnPjTszK+jfKNwlTqhlVe6Ixltgrfw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121061655.Cb9nHdq2L5yRAVtbDxXHcpR6GQbdLIJPGJ_CYNMD1jE@z>

VGVtcG9yYXJpbHkgc2tpcCByYXMsZHRtLGhkY3AgaW5pdGlhbGl6ZSBhbmQgdGVybWluYXRlIGZv
ciBhcmN0dXJ1cyBWRgpDdXJyZW50bHkgdGhlIHRocmVlIGZlYXR1cmVzIGhhdmVuJ3QgYmVlbiBl
bmFibGVkIGF0IFNSSU9WLCBpdCB3b3VsZAp0cmlnZ2VyIGd1ZXN0IGRyaXZlciBsb2FkIGZhaWwg
d2l0aCB0aGUgYmFyZS1tZXRhbCBwYXRoIG9mIHRoZSB0aHJlZQpmZWF0dXJlcy4KClNpZ25lZC1v
ZmYtYnk6IEphY2sgWmhhbmcgPEphY2suWmhhbmcxQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCAyYThhMDhhLi5jM2E0MmQzIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC03NTYsNiArNzU2LDEyIEBAIGlu
dCBwc3BfcmFzX2VuYWJsZV9mZWF0dXJlcyhzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAogc3Rh
dGljIGludCBwc3BfcmFzX3Rlcm1pbmF0ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKKwkv
KgorCSAqIFRPRE86IGJ5cGFzcyB0aGUgdGVybWluYXRlIGluIHNyaW92IGZvciBub3cKKwkgKi8K
KwlpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikpCisJCXJldHVybiAwOworCiAJaW50IHJl
dDsKIAogCWlmICghcHNwLT5yYXMucmFzX2luaXRpYWxpemVkKQpAQCAtNzc3LDYgKzc4MywxMiBA
QCBzdGF0aWMgaW50IHBzcF9yYXNfdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQog
CiBzdGF0aWMgaW50IHBzcF9yYXNfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkK
IHsKKwkvKgorCSAqIFRPRE86IGJ5cGFzcyB0aGUgaW5pdGlhbGl6ZSBpbiBzcmlvdiBmb3Igbm93
CisJICovCisJaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQorCQlyZXR1cm4gMDsKKwog
CWludCByZXQ7CiAKIAlpZiAoIXBzcC0+YWRldi0+cHNwLnRhX3Jhc191Y29kZV9zaXplIHx8CkBA
IC04NzIsNiArODg0LDEyIEBAIHN0YXRpYyBpbnQgcHNwX2hkY3BfbG9hZChzdHJ1Y3QgcHNwX2Nv
bnRleHQgKnBzcCkKIH0KIHN0YXRpYyBpbnQgcHNwX2hkY3BfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCkKIHsKKwkvKgorCSAqIFRPRE86IGJ5cGFzcyB0aGUgaW5pdGlhbGl6ZSBp
biBzcmlvdiBmb3Igbm93CisJICovCisJaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQor
CQlyZXR1cm4gMDsKKwogCWludCByZXQ7CiAKIAlpZiAoIXBzcC0+YWRldi0+cHNwLnRhX2hkY3Bf
dWNvZGVfc2l6ZSB8fApAQCAtOTYwLDYgKzk3OCwxMiBAQCBpbnQgcHNwX2hkY3BfaW52b2tlKHN0
cnVjdCBwc3BfY29udGV4dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpCiAKIHN0YXRpYyBpbnQg
cHNwX2hkY3BfdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogeworCS8qCisJICog
VE9ETzogYnlwYXNzIHRoZSB0ZXJtaW5hdGUgaW4gc3Jpb3YgZm9yIG5vdworCSAqLworCWlmIChh
bWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkKKwkJcmV0dXJuIDA7CisKIAlpbnQgcmV0OwogCiAJ
aWYgKCFwc3AtPmhkY3BfY29udGV4dC5oZGNwX2luaXRpYWxpemVkKQpAQCAtMTA1MSw2ICsxMDc1
LDEyIEBAIHN0YXRpYyBpbnQgcHNwX2R0bV9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQog
CiBzdGF0aWMgaW50IHBzcF9kdG1faW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkK
IHsKKwkvKgorCSAqIFRPRE86IGJ5cGFzcyB0aGUgaW5pdGlhbGl6ZSBpbiBzcmlvdiBmb3Igbm93
CisJICovCisJaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQorCQlyZXR1cm4gMDsKKwog
CWludCByZXQ7CiAKIAlpZiAoIXBzcC0+YWRldi0+cHNwLnRhX2R0bV91Y29kZV9zaXplIHx8CkBA
IC0xMTA5LDYgKzExMzksMTIgQEAgaW50IHBzcF9kdG1faW52b2tlKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpCiAKIHN0YXRpYyBpbnQgcHNwX2R0bV90ZXJtaW5h
dGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CisJLyoKKwkgKiBUT0RPOiBieXBhc3MgdGhl
IHRlcm1pbmF0ZSBpbiBzcmlvdiBmb3Igbm93CisJICovCisJaWYgKGFtZGdwdV9zcmlvdl92Zihw
c3AtPmFkZXYpKQorCQlyZXR1cm4gMDsKKwogCWludCByZXQ7CiAKIAlpZiAoIXBzcC0+ZHRtX2Nv
bnRleHQuZHRtX2luaXRpYWxpemVkKQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
