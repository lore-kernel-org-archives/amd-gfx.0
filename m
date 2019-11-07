Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5518EC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29219206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29219206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C146F741;
	Thu,  7 Nov 2019 15:56:57 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700075.outbound.protection.outlook.com [40.107.70.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D906F733
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 15:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah+bm3HOVgcLAfrwii4RNmE0xqZyoco96uP4ItSSZGjKUVaWeQJ721MejqtPE9uA510oh2JWjA8GcF8cglrmZREHwSRGKoJ36NdeikHBmNO0tn2kUN49hqvAZDQArvJp+PyNbn/4vyYv4uv5znhI9bn28UVM25RgbKbzxIItMwNIyCmxz1NaaUnTBv5ZosnKw0Q6y02bYik/qS89XBmKqM5/D+8psE1v5ogHRhxWX2SWPo9vnQv2e72dziZemcNKOegrb9yzMSX44lX4I6n7tRFbv0JVOqBTJY3yYa4gW5bInFR478/hARyvHt1gYuENno4XOngYrSQGYquLMoTjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+G61SrznpaYefO/C9TyV0lEu+IDTgVM0tZREjlZro4=;
 b=lzyYGmShMB4X2RxPLtHlY2tIHaHixQxo9bT7FHMOUOmWXrmzB5vGfKHW89KB2tavY7ai36++B7e2eVAkTgX5edBWvj16Oxpe10bGlPYNCzmFxo27kmMMmutBErZqFwEPM2CMeqkdeit7RS1CCJfFtjlhAAAa6VNB5oH9NR1aw+nC9Ozb7cvM82C+pUsIDCQBi3G91G5Q5mr0LQ9mbPIe68JSllhzmDdogYIa4j2dAA5bQ0Ec/O9cFL2Mlx3dnQEPZg3757HCQwRqVG81lm7LgdQYyUYay/gzo8UR72+aNB7+X1xOLKibHkK+jqR4sSCAjDMqb+1h8IwFjAsMI3ABBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0057.namprd12.prod.outlook.com (2603:10b6:3:103::19)
 by DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 15:56:52 +0000
Received: from DM3NAM03FT051.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by DM5PR12CA0057.outlook.office365.com
 (2603:10b6:3:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22 via Frontend
 Transport; Thu, 7 Nov 2019 15:56:52 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT051.mail.protection.outlook.com (10.152.83.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 15:56:52 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 09:56:47 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 09:56:47 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: Fix static analysis bug in
 validate_bksv
Date: Thu, 7 Nov 2019 10:56:28 -0500
Message-ID: <20191107155628.19446-15-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
References: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(428003)(189003)(199004)(47776003)(14444005)(54906003)(11346002)(26005)(4326008)(305945005)(7696005)(478600001)(86362001)(81166006)(8936002)(50226002)(476003)(486006)(6666004)(15650500001)(8676002)(5660300002)(81156014)(356004)(2351001)(2906002)(426003)(316002)(2616005)(126002)(48376002)(16586007)(186003)(70206006)(76176011)(70586007)(50466002)(36756003)(1076003)(336012)(6916009)(51416003)(53416004)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1578; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8409a723-3a56-4a50-0225-08d7639b1b20
X-MS-TrafficTypeDiagnostic: DM5PR12MB1578:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1578EEA9EE724EDFFE18CD88F9780@DM5PR12MB1578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SXBl2gofwSNqrXzRQXX/GxfkgSY1pjJEj5f0kZC2U2oF8okgHAeiskFXg6qXheDpH3pUwP6ufUHHj7B4+qNAvApPm+ZwWYUh6wPf5+/bwA2ygdm9mdMMY3ymPPnGFqLWuTwL3On/k0qMae3SKTaRQGm4vnYzJtbrDINuJzHXEqRxbv9odjhQtI9dVyrtBzDxhnfA6AIQSFERGS7XbTJridbSINoNvhKb6ud8SmRc2/BbVJggWihbbLRpwJiaa9E0HLAyX7fkyty/oCF7da/YpPNbQC4gTR4WI05TN2ozHdqY+FxSZWCKnhUn9eUEqvMckJU4kl9EfklcvJUneKogGeeGzUuAEZxatKZvzkCB47z5mLodA/ijX3xuJpgR4pTEAvB/HeEq8Znbr8NDUm9wxnRbpt8g8TPtuK2/8QQEomHogNJLunmWJbNHfUmYDye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:56:52.1397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8409a723-3a56-4a50-0225-08d7639b1b20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1578
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+G61SrznpaYefO/C9TyV0lEu+IDTgVM0tZREjlZro4=;
 b=wRcsXrbZH8ndo0S02M4Jgl6h3Di2uuIu4cHMdy83X2OBLC1yGvg0sB2b4xJZ9usY3RHbZwlMX71aCMxZ6t7T6wbnTG5LT4wzyl04VAWmMKHod0Z/cRCL0IybpjbqrBk5lD92b1g2jYYN30t1j+LET+cl8W0WmsT5I9eJ/iY5HZk=
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Wenjing.Liu@amd.com,
 harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107155628.AAAXU6WpVa-eZABrZta-drADvkBXwhxhvga_Tf4ij9w@z>

W1doeV0Kc3RhdGljIGFuYWx5c2lzIHRocm93cyB0aGUgZXJyb3IgYmVsb3cKCk91dC1vZi1ib3Vu
ZHMgcmVhZCAoT1ZFUlJVTikKT3ZlcnJ1bm5pbmcgYXJyYXkgb2YgNSBieXRlcyBhdCBieXRlIG9m
ZnNldCA3IGJ5IGRlcmVmZXJlbmNpbmcgcG9pbnRlcgoodWludDY0X3QgKiloZGNwLT5hdXRoLm1z
Zy5oZGNwMS5ia3N2LgoKdmFyIG4gaXMgZ29pbmcgdG8gY29udGFpbiAgcjBwIGFuZCBiY2Fwcy4g
aWYgdGhleSBhcmUgbm9uLXplcm8gdGhlIGNvdW50CndpbGwgYmUgd3JvbmcKCkhvd10KVXNlIG1l
bWNweSBpbnN0ZWFkIHRvIGF2b2lkIHRoaXMuCgpTaWduZWQtb2ZmLWJ5OiBCaGF3YW5wcmVldCBM
YWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3AxX2V4ZWN1dGlvbi5jIHwgNCArKystCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwMV9leGVjdXRpb24uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcDFfZXhlY3V0aW9u
LmMKaW5kZXggNGQxMTA0MWE4YzZmLi4wNDg0NWU0M2RmMTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcDFfZXhlY3V0aW9uLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwMV9leGVjdXRpb24u
YwpAQCAtMjcsOSArMjcsMTEgQEAKIAogc3RhdGljIGlubGluZSBlbnVtIG1vZF9oZGNwX3N0YXR1
cyB2YWxpZGF0ZV9ia3N2KHN0cnVjdCBtb2RfaGRjcCAqaGRjcCkKIHsKLQl1aW50NjRfdCBuID0g
Kih1aW50NjRfdCAqKWhkY3AtPmF1dGgubXNnLmhkY3AxLmJrc3Y7CisJdWludDY0X3QgbiA9IDA7
CiAJdWludDhfdCBjb3VudCA9IDA7CiAKKwltZW1jcHkoJm4sIGhkY3AtPmF1dGgubXNnLmhkY3Ax
LmJrc3YsIHNpemVvZih1aW50NjRfdCkpOworCiAJd2hpbGUgKG4pIHsKIAkJY291bnQrKzsKIAkJ
biAmPSAobiAtIDEpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
