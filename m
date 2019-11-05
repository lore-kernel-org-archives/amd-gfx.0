Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC9C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 15:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CEA217F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 15:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CEA217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A807A6EACB;
	Tue,  5 Nov 2019 15:58:37 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820041.outbound.protection.outlook.com [40.107.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F22F6EACB
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 15:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiZjkWw04MtvPJBC7xFTooVPwXJefdzEYt85TH34nt7s7PgkIldgTKjeAuYHtWgNOaUlWmeHv64nHJ+XVCvuhf/jwkj5VFnGucPd46mkU3xuShqmyCxZQ3AQYkgGoXVhaTCQcf8uwDJNhlHq9u75yxb+m/S3wsmEClxJqsq0RyFyQCRY259Fzy50wbFCgSOpX1v7PpT+xhmaPCVtDgvAlmJqWy14JIstxg490PEJahRVqiQ/TDaSr6DZ68NW8lVmRbQ2X+Q1jgdji2SEbZDT6J8eDwH+8WvwihipnBp/jxnzOiRctntc0ifMzTyYHj4sSQmrbKsjsvB8BKO40+ATZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR9WtLgp0fCB/lHQd8RocZGWplyaCg1qciPHln6M83I=;
 b=HygOCBp5TUo+jD6lFMJflEFMlV2tNX47o382e8QjP6gRwiWQRaRJIxnsHFEZz0aRUwBSxv9c5J1w4a5p08MG/sa3pxtG19BUCVNmwWdIPztRQi9PKWQm+qH2E91YUt3jUmhFM7EFpjv9fsZbtmpXseTyfEHtpVM0oXvCBQrdACPiNdD8t3VFUVgkcaeFKWxL+WoTF+Bw+PKzd+pf09iC+YMO+eUQm592kNN4axqgiBEfTCeUdXX4tk+XVWvJ43KEJ0ZYUG8j2m3S+Jj+eT+b+t1xCbNOVX1AUGkKM3nWM1RUpnLqd15CbrZlMXDCWLkA2i63DfjZWCWBt9xYrPr6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0065.namprd12.prod.outlook.com (2603:10b6:3:103::27)
 by CY4PR12MB1509.namprd12.prod.outlook.com (2603:10b6:910:8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Tue, 5 Nov
 2019 15:58:35 +0000
Received: from CO1NAM03FT054.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by DM5PR12CA0065.outlook.office365.com
 (2603:10b6:3:103::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Tue, 5 Nov 2019 15:58:35 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT054.mail.protection.outlook.com (10.152.81.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Tue, 5 Nov 2019 15:58:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 5 Nov 2019
 09:58:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 5 Nov 2019
 09:58:33 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 5 Nov 2019 09:58:33 -0600
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2 v2] drm/amd/display: Disable VUpdate interrupt for DCN
 hardware
Date: Tue, 5 Nov 2019 10:58:03 -0500
Message-ID: <20191105155802.1302-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105153416.32049-2-sunpeng.li@amd.com>
References: <20191105153416.32049-2-sunpeng.li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(428003)(199004)(189003)(6916009)(8936002)(486006)(47776003)(51416003)(76176011)(86362001)(336012)(186003)(26005)(2906002)(2616005)(2876002)(11346002)(2351001)(446003)(426003)(14444005)(8676002)(50466002)(316002)(305945005)(4326008)(70586007)(478600001)(1076003)(356004)(6666004)(70206006)(2870700001)(126002)(476003)(81156014)(81166006)(54906003)(50226002)(48376002)(5660300002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1509; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce194df4-11bf-4a15-a75b-08d762090348
X-MS-TrafficTypeDiagnostic: CY4PR12MB1509:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1509F865EC7E99DA789C251D827E0@CY4PR12MB1509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0212BDE3BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSnlzWAlNm3ML5RpQ7GKs9Kr7sWKsKeHzjoOy1zafEaIMldb5QFojiZkyeLSOj9hQFYhmW0uh8Lp5GOC054DpVzl4ahljjcY9fUwlqJf2o7cnEyxuGyVDH2rxlgm7idRy5auFGOFpAjvAi+oYDI5c64bJcBJNetLC8HldB4N62ufEBpiTN/3c63eEIzxdeV2e6AI4dVrNi2wLGVUBQ1Ut7PUB8L65Td95bbqnvBwTYVqdfZWJBkdlDJe3wJmmztxjwRJoifGbI74WMywA//dBtZRa5k5nx7mCdcNMilIser/W1wokj85dMGdvwBBjQx/ndAavetZrFc8w4NCdO+LM+7Fih2xd52Dg8jJEOqAkXj5R95GOSt0V4b811HdNtLPBUFBWC1AWVekDa4D2cZkJFSQUPKZrjRcL3OTw+XQQer362h3FO3szZEGYTGuGP+h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2019 15:58:34.3924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce194df4-11bf-4a15-a75b-08d762090348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1509
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR9WtLgp0fCB/lHQd8RocZGWplyaCg1qciPHln6M83I=;
 b=XiluI0s2HU9bjfbtmPGDdESWzP9xgj3Knj3CXrjTEtW909X08fm+FnD+AfSklV/SN3KyTocpCjHQMzBE0YIO3m1l2Dphk6U55ZqtKuan0u41olh/JJmLLMlDWVgyvyg6N7fmWJGi7oljeuV8QZTk6j8nZ1F1RfOSH00Prk8lyyQ=
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
Cc: Leo Li <sunpeng.li@amd.com>, mario.kleiner.de@gmail.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105155803.UxBYqJp0T_d6varvLdi0FtBQIxlb__ogyRdC7V9TgSQ@z>

RnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpbV2h5XQoKT24gRENOIGhhcmR3YXJl
LCB0aGUgY3J0Y19oaWdoX2lycSBoYW5kbGVyIG1ha2VzIHZ1cGRhdGVfaGlnaF9pcnEKaGFuZGxl
ciByZWR1bmRhbnQuCgpBbGwgdGhlIHZ1cGRhdGUgaGFuZGxlciBkb2VzIGlzIGhhbmRsZSB2Ymxh
bmsgZXZlbnRzLCBhbmQgdXBkYXRlIHZycgpmb3IgRENFIGh3IChleGNsdWRpbmcgVkVHQSwgbW9y
ZSBvbiB0aGF0IGxhdGVyKS4gQXMgZmFyIGFzIHVzZXJtb2RlIGlzCmNvbmNlcm5lZC4gdnN0YXJ0
dXAgaGFwcGVucyBjbG9zZSBlbm91Z2ggdG8gdnVwZGF0ZSBvbiBEQ04gdGhhdCBpdCBjYW4KYmUg
Y29uc2lkZXJlZCB0aGUgInNhbWUiLiBIYW5kbGluZyB2YmxhbmsgYW5kIHVwZGF0aW5nIHZyciBh
dCB2c3RhcnR1cAplZmZlY3RpdmVseSByZXBsYWNlcyB2dXBkYXRlIG9uIERDTi4KClZlZ2EgaXMg
YSBiaXQgc3BlY2lhbC4gTGlrZSBEQ04sIHRoZSBWUlIgcmVnaXN0ZXJzIG9uIFZlZ2EgYXJlCmRv
dWJsZS1idWZmZXJlZCwgYW5kIHN3YXBwZWQgYXQgdnVwZGF0ZS4gQnV0IFVubGlrZSBEQ04sIGl0
IGxhY2tzIGEKdnN0YXJ0dXAgaW50ZXJydXB0LiBUaGlzIG1lYW5zIHdlIGNhbid0IHF1aXRlIHJl
bW92ZSB0aGUgdnVwZGF0ZSBoYW5kbGVyCmZvciBpdCwgc2luY2UgZGVsYXllcmQgdXNlciBldmVu
dHMgZHVlIHRvIHZyciBhcmUgc2VudCBvZmYgdGhlcmUuCgpbSG93XQoKUmVtb3ZlIHJlZ2lzdHJh
dGlvbiBvZiBWVXBkYXRlIGludGVycnVwdCBoYW5kbGVyIGZvciBEQ04uIERpc2FibGUKdnVwZGF0
ZSBpbnRlcnJ1cHQgaWYgYXNpYyBmYW1pbHkgRENOLCBlbmFibGUgb3RoZXJ3aXNlLgoKU2lnbmVk
LW9mZi1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQoKdjI6IERvbid0IGV4Y2x1
ZGUgdmVnYSB3aGVuIGVuYWJsaW5nIHZ1cGRhdGUgaW50ZXJydXB0cwoKIC4uLi9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDM0ICsrKy0tLS0tLS0tLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4
IDI1NmEyM2EwZWMyOC4uMzY2NGFmM2I0MWExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTIyNDEsMzQgKzIyNDEsNiBAQCBz
dGF0aWMgaW50IGRjbjEwX3JlZ2lzdGVyX2lycV9oYW5kbGVycyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAkJCQlkbV9kY25fY3J0Y19oaWdoX2lycSwgY19pcnFfcGFyYW1zKTsKIAl9Cgot
CS8qIFVzZSBWVVBEQVRFX05PX0xPQ0sgaW50ZXJydXB0IG9uIERDTiwgd2hpY2ggc2VlbXMgdG8g
Y29ycmVzcG9uZCB0bwotCSAqIHRoZSByZWd1bGFyIFZVUERBVEUgaW50ZXJydXB0IG9uIERDRS4g
V2Ugd2FudCBEQ19JUlFfU09VUkNFX1ZVUERBVEV4Ci0JICogdG8gdHJpZ2dlciBhdCBlbmQgb2Yg
ZWFjaCB2YmxhbmssIHJlZ2FyZGxlc3Mgb2Ygc3RhdGUgb2YgdGhlIGxvY2ssCi0JICogbWF0Y2hp
bmcgRENFIGJlaGF2aW91ci4KLQkgKi8KLQlmb3IgKGkgPSBEQ05fMV8wX19TUkNJRF9fT1RHMF9J
SENfVl9VUERBVEVfTk9fTE9DS19JTlRFUlJVUFQ7Ci0JICAgICBpIDw9IERDTl8xXzBfX1NSQ0lE
X19PVEcwX0lIQ19WX1VQREFURV9OT19MT0NLX0lOVEVSUlVQVCArIGFkZXYtPm1vZGVfaW5mby5u
dW1fY3J0YyAtIDE7Ci0JICAgICBpKyspIHsKLQkJciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYs
IFNPQzE1X0lIX0NMSUVOVElEX0RDRSwgaSwgJmFkZXYtPnZ1cGRhdGVfaXJxKTsKLQotCQlpZiAo
cikgewotCQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gYWRkIHZ1cGRhdGUgaXJxIGlkIVxuIik7Ci0J
CQlyZXR1cm4gcjsKLQkJfQotCi0JCWludF9wYXJhbXMuaW50X2NvbnRleHQgPSBJTlRFUlJVUFRf
SElHSF9JUlFfQ09OVEVYVDsKLQkJaW50X3BhcmFtcy5pcnFfc291cmNlID0KLQkJCWRjX2ludGVy
cnVwdF90b19pcnFfc291cmNlKGRjLCBpLCAwKTsKLQotCQljX2lycV9wYXJhbXMgPSAmYWRldi0+
ZG0udnVwZGF0ZV9wYXJhbXNbaW50X3BhcmFtcy5pcnFfc291cmNlIC0gRENfSVJRX1NPVVJDRV9W
VVBEQVRFMV07Ci0KLQkJY19pcnFfcGFyYW1zLT5hZGV2ID0gYWRldjsKLQkJY19pcnFfcGFyYW1z
LT5pcnFfc3JjID0gaW50X3BhcmFtcy5pcnFfc291cmNlOwotCi0JCWFtZGdwdV9kbV9pcnFfcmVn
aXN0ZXJfaW50ZXJydXB0KGFkZXYsICZpbnRfcGFyYW1zLAotCQkJCWRtX3Z1cGRhdGVfaGlnaF9p
cnEsIGNfaXJxX3BhcmFtcyk7Ci0JfQotCiAJLyogVXNlIEdSUEhfUEZMSVAgaW50ZXJydXB0ICov
CiAJZm9yIChpID0gRENOXzFfMF9fU1JDSURfX0hVQlAwX0ZMSVBfSU5URVJSVVBUOwogCQkJaSA8
PSBEQ05fMV8wX19TUkNJRF9fSFVCUDBfRkxJUF9JTlRFUlJVUFQgKyBhZGV2LT5tb2RlX2luZm8u
bnVtX2NydGMgLSAxOwpAQCAtNDI2Niw3ICs0MjM4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgZG1f
c2V0X3ZibGFuayhzdHJ1Y3QgZHJtX2NydGMgKmNydGMsIGJvb2wgZW5hYmxlKQogCXN0cnVjdCBk
bV9jcnRjX3N0YXRlICphY3J0Y19zdGF0ZSA9IHRvX2RtX2NydGNfc3RhdGUoY3J0Yy0+c3RhdGUp
OwogCWludCByYyA9IDA7CgotCWlmIChlbmFibGUpIHsKKwlpZiAoZW5hYmxlICYmIGFkZXYtPmZh
bWlseSA8PSBBTURHUFVfRkFNSUxZX0FJKSB7CiAJCS8qIHZibGFuayBpcnEgb24gLT4gT25seSBu
ZWVkIHZ1cGRhdGUgaXJxIGluIHZyciBtb2RlICovCiAJCWlmIChhbWRncHVfZG1fdnJyX2FjdGl2
ZShhY3J0Y19zdGF0ZSkpCiAJCQlyYyA9IGRtX3NldF92dXBkYXRlX2lycShjcnRjLCB0cnVlKTsK
QEAgLTYyNDMsNiArNjIxNSw3IEBAIHN0YXRpYyB2b2lkIHByZV91cGRhdGVfZnJlZXN5bmNfc3Rh
dGVfb25fc3RyZWFtKAogc3RhdGljIHZvaWQgYW1kZ3B1X2RtX2hhbmRsZV92cnJfdHJhbnNpdGlv
bihzdHJ1Y3QgZG1fY3J0Y19zdGF0ZSAqb2xkX3N0YXRlLAogCQkJCQkgICAgc3RydWN0IGRtX2Ny
dGNfc3RhdGUgKm5ld19zdGF0ZSkKIHsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IG9s
ZF9zdGF0ZS0+YmFzZS5jcnRjLT5kZXYtPmRldl9wcml2YXRlOwogCWJvb2wgb2xkX3Zycl9hY3Rp
dmUgPSBhbWRncHVfZG1fdnJyX2FjdGl2ZShvbGRfc3RhdGUpOwogCWJvb2wgbmV3X3Zycl9hY3Rp
dmUgPSBhbWRncHVfZG1fdnJyX2FjdGl2ZShuZXdfc3RhdGUpOwoKQEAgLTYyNTUsNyArNjIyOCw4
IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9oYW5kbGVfdnJyX3RyYW5zaXRpb24oc3RydWN0IGRt
X2NydGNfc3RhdGUgKm9sZF9zdGF0ZSwKIAkJICogV2UgYWxzbyBuZWVkIHZ1cGRhdGUgaXJxIGZv
ciB0aGUgYWN0dWFsIGNvcmUgdmJsYW5rIGhhbmRsaW5nCiAJCSAqIGF0IGVuZCBvZiB2Ymxhbmsu
CiAJCSAqLwotCQlkbV9zZXRfdnVwZGF0ZV9pcnEobmV3X3N0YXRlLT5iYXNlLmNydGMsIHRydWUp
OworCQlpZiAoYWRldi0+ZmFtaWx5IDw9IEFNREdQVV9GQU1JTFlfQUkpCisJCQlkbV9zZXRfdnVw
ZGF0ZV9pcnEobmV3X3N0YXRlLT5iYXNlLmNydGMsIHRydWUpOwogCQlkcm1fY3J0Y192Ymxhbmtf
Z2V0KG5ld19zdGF0ZS0+YmFzZS5jcnRjKTsKIAkJRFJNX0RFQlVHX0RSSVZFUigiJXM6IGNydGM9
JXUgVlJSIG9mZi0+b246IEdldCB2YmxhbmsgcmVmXG4iLAogCQkJCSBfX2Z1bmNfXywgbmV3X3N0
YXRlLT5iYXNlLmNydGMtPmJhc2UuaWQpOwotLQoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
