Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A7CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBA22084C
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBA22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC2E899B7;
	Thu, 24 Oct 2019 10:35:51 +0000 (UTC)
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr780044.outbound.protection.outlook.com [40.107.78.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE7D899B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 10:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRwIGU66kjfaDCX2eTtmHOqrNmC6NXBnXNtpjXSumiINWQVsZRNs2NJ5dGLGYjCwQ6t2kEJiXTDIZoBNQ/R5qGc86DGQ4QFj/qj+Hw/oXBD8GUfYw9L7WdOApTIcsDc2sFbTunsG0srxL7DsucyFuWSqw7v2wl/lcKWkfP16KSTF5F8BGC97Q2+6mI/OyjBfMMTpYIy7urE9Hl0fUvy/LqAd8LWLGh/PBtL33P1v9E+bkabA78S9HWz0stwUdCC035aK86h9/k9FbOU8k5aiUBPHAMaEUtfgHXJrKlk9xnV2DGeJUHcC2158Ff5MuQkvgBFEedkY+w1Tiz4L7u5vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrgtDixoCqPXN+CsyyixCZq/pcwAGU6i+AUsLK0hCBM=;
 b=LMSYDcZeuVXouRuhKCBTkjbVNlm/cEEhji6WmBYNHvz+N/eCQq+PZ/eUh7YklPMecDjShuJV0+QTmZfsCK0DLMI4HhdwkP67lxkQnDSGYVL6Aobumd23Qaw0p0RQJJXK0PXcPaM6dUJ1kJqXQhI1QainRxPJiTVUAudpPgA4JHBuz2syCliMXZq2pXjOhEjlbrUPaCZrh1REep1kX48gcaOFWsHvquS4JY5aRpLiPtvNlAH7R0uFbTOycq8elHATqOw1XEspXjnst5PxDrfYO5aeuw9ki6rmf5/0Rz0hVTgEPeOT895RnFvfgdB/v8FsHsziEd+elmYIz+S/fZdxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0058.namprd12.prod.outlook.com (2603:10b6:3:103::20)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Thu, 24 Oct
 2019 10:35:46 +0000
Received: from DM3NAM03FT048.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::202) by DM5PR12CA0058.outlook.office365.com
 (2603:10b6:3:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23 via Frontend
 Transport; Thu, 24 Oct 2019 10:35:46 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT048.mail.protection.outlook.com (10.152.83.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 24 Oct 2019 10:35:46 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 24 Oct
 2019 05:35:44 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 24 Oct 2019 05:35:43 -0500
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: add one flag to show that no one
 message be sent yet by SMU
Date: Thu, 24 Oct 2019 18:35:40 +0800
Message-ID: <1571913340-25656-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(428003)(199004)(189003)(51416003)(2351001)(426003)(336012)(26005)(356004)(6916009)(7696005)(53416004)(126002)(305945005)(486006)(186003)(86362001)(2906002)(2616005)(476003)(5660300002)(70586007)(36756003)(70206006)(50226002)(4326008)(81156014)(81166006)(478600001)(47776003)(8676002)(16586007)(8936002)(316002)(15650500001)(50466002)(48376002)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1280; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed5ab3fd-2c2a-4d7e-d621-08d7586dedd9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:
X-Microsoft-Antispam-PRVS: <MWHPR12MB128082DE036EE46CE4E97F799D6A0@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0200DDA8BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pazyydYYPgVxutQUTdRi62986jVohqAp9qvxtZefo0p1hjCtwOxyZeQEMu7eklbaQ4Ucv6NG7hbz/hXYJR0+9eoYtD+bqfJx6DqyMgylfH3XkfPKIBTVqFPHnIKT6xK0kNseFWXb8nmYz1Oyk/KBhTiwkKS4vXW14oGFwsRn1MKHFUgQwGiIfjHn2xBhqgy3mg0Ve+u8xhhCotIH8ZhewsAHwnx4b1G7xNj3fTLpN6pZMp+0+9GCZyiaTs93cFzs9of6c55yd6KaKFWzvlRJ/lEMFN4SzxDPQCL6tUMDTwdVKzQK32IGLv+yNk8D/1PBbl6XwP7e5FDdGZGzHSMf9bn8eM4bkLHPNQyfhM0jB66dHANTUHaxgwBOSgd1KdjSyfewTYl28CnxcSFWkHJWI9OcJ5EIRQJkeQeWoVMSkKSrt5w056KHztWmSifxroZO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 10:35:46.0519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5ab3fd-2c2a-4d7e-d621-08d7586dedd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrgtDixoCqPXN+CsyyixCZq/pcwAGU6i+AUsLK0hCBM=;
 b=owhPGxqz1Rc8CCzHTyZLlETn3m5i9eFgo2ibHO21WocbscND7UnmuITBf5Lp3fqVVwuYTOZQ0fp4SFcBvoZTZP0L9uH4sm0NZV/5pMpl7mcEb/56iDWg1AV/L0Q4xNllv2IDHRRME22bVGAlc5s37QdqXZQ9vmDIiUKrJOnTM8k=
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024103540.DCoMTEMZEVVph8LwGCP0UmmiC6bmRBkh79jMHWIaHz8@z>

VGhlIHZhbHVlIG9mIHRoZSByZWdpc3RlciBtbU1QMV9TTU5fQzJQTVNHXzkwIHNob3VsZCBiZSAw
IHdoZW4KaW5pdGlhbGl6aW5nIHNtdSBhbmQgYWZ0ZXIgcmVzdW1pbmcgc211LgoKU2lnbmVkLW9m
Zi1ieTogY2hlbiBnb25nIDxjdXJyeS5nb25nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jICAgICB8ICAzICsrLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaCB8ICAxICsKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jICAgICAgfCAxNSArKysrKysrKysrLS0tLS0KIDMgZmls
ZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKaW5kZXggM2NlMDFlMS4uZDkzMDQwYiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwpAQCAtNzM4LDYg
KzczOCw3IEBAIHN0YXRpYyBpbnQgc211X2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCXNtdS0+
YWRldiA9IGFkZXY7CiAJc211LT5wbV9lbmFibGVkID0gISFhbWRncHVfZHBtOwogCXNtdS0+aXNf
YXB1ID0gZmFsc2U7CisJc211LT5ub3RfeWV0X3NlbnRfb25lX21zZyA9IHRydWU7CiAJbXV0ZXhf
aW5pdCgmc211LT5tdXRleCk7CiAKIAlyZXR1cm4gc211X3NldF9mdW5jcyhhZGV2KTsKQEAgLTEz
ODEsNyArMTM4Miw3IEBAIHN0YXRpYyBpbnQgc211X3Jlc3VtZSh2b2lkICpoYW5kbGUpCiAJCXNt
dV9zZXRfZ2Z4X2NncGcoJmFkZXYtPnNtdSwgdHJ1ZSk7CiAKIAlzbXUtPmRpc2FibGVfdWNsa19z
d2l0Y2ggPSAwOwotCisJc211LT5ub3RfeWV0X3NlbnRfb25lX21zZyA9IHRydWU7CiAJcHJfaW5m
bygiU01VIGlzIHJlc3VtZWQgc3VjY2Vzc2Z1bGx5IVxuIik7CiAKIAlyZXR1cm4gMDsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oCmluZGV4IDgxMjBl
NzUuLjFjMDMxNjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2lu
Yy9hbWRncHVfc211LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2Ft
ZGdwdV9zbXUuaApAQCAtMzg4LDYgKzM4OCw3IEBAIHN0cnVjdCBzbXVfY29udGV4dAogCXVpbnQz
Ml90IGRlZmF1bHRfcG93ZXJfcHJvZmlsZV9tb2RlOwogCWJvb2wgcG1fZW5hYmxlZDsKIAlib29s
IGlzX2FwdTsKKwlib29sIG5vdF95ZXRfc2VudF9vbmVfbXNnOwogCiAJdWludDMyX3Qgc21jX2lm
X3ZlcnNpb247CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dV92MTJfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMKaW5k
ZXggMTM5ZGQ3My4uMjE5OWEzOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvc211X3YxMl8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211
X3YxMl8wLmMKQEAgLTExMywxMCArMTEzLDExIEBAIHNtdV92MTJfMF9zZW5kX21zZ193aXRoX3Bh
cmFtKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCB1aW50MTZfdCBtc2csCiAJaWYgKGluZGV4IDwg
MCkKIAkJcmV0dXJuIGluZGV4OwogCi0JcmV0ID0gc211X3YxMl8wX3dhaXRfZm9yX3Jlc3BvbnNl
KHNtdSk7Ci0JaWYgKHJldCkKLQkJcHJfZXJyKCJGYWlsZWQgdG8gc2VuZCBtZXNzYWdlIDB4JXgs
IHJlc3BvbnNlIDB4JXgsIHBhcmFtIDB4JXhcbiIsCi0JCSAgICAgICBpbmRleCwgcmV0LCBwYXJh
bSk7CisJaWYoIXNtdS0+bm90X3lldF9zZW50X29uZV9tc2cpeworCQlyZXQgPSBzbXVfdjEyXzBf
d2FpdF9mb3JfcmVzcG9uc2Uoc211KTsKKwkJaWYgKHJldCkKKwkJCXByX2VycigiRmFpbGVkIHRv
IHNlbmQgbWVzc2FnZSAweCV4LCByZXNwb25zZSAweCV4LCBwYXJhbSAweCV4XG4iLGluZGV4LCBy
ZXQsIHBhcmFtKTsKKwl9CiAKIAlXUkVHMzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNH
XzkwLCAwKTsKIApAQCAtMTI1LDkgKzEyNiwxMyBAQCBzbXVfdjEyXzBfc2VuZF9tc2dfd2l0aF9w
YXJhbShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgdWludDE2X3QgbXNnLAogCXNtdV92MTJfMF9z
ZW5kX21zZ193aXRob3V0X3dhaXRpbmcoc211LCAodWludDE2X3QpaW5kZXgpOwogCiAJcmV0ID0g
c211X3YxMl8wX3dhaXRfZm9yX3Jlc3BvbnNlKHNtdSk7Ci0JaWYgKHJldCkKKwlpZiAocmV0KXsK
IAkJcHJfZXJyKCJGYWlsZWQgdG8gc2VuZCBtZXNzYWdlIDB4JXgsIHJlc3BvbnNlIDB4JXggcGFy
YW0gMHgleFxuIiwKIAkJICAgICAgIGluZGV4LCByZXQsIHBhcmFtKTsKKwl9CisJZWxzZSBpZihz
bXUtPm5vdF95ZXRfc2VudF9vbmVfbXNnKXsKKwkJc211LT5ub3RfeWV0X3NlbnRfb25lX21zZyA9
IGZhbHNlOworCX0KIAogCXJldHVybiByZXQ7CiB9Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
