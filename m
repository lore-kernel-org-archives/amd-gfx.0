Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C74CA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445C720873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445C720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C846EEA8;
	Thu, 31 Oct 2019 14:42:35 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A126EEA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoJPyTwRvn98z2zoQnOmUTGyOlkjJWdyHYQ2arGLvMdH4SYZ1erS2yHUjSaTX/kGoxMnmNfUEo95Ugtnwh11/8hsXZtj7cW1p0WfpFnSCW8AzAlaKAaAoB1Sp8WBkM3Xkmxm1OK1Fy3Txy1Dnl/LJs8AuL+6yHvsCcpOjhR5fIt4jJdlV/aaWF2crKOHnbZutW7eKr5MFL1iK0+dTE6hE+QaCRk5wCTCaHK6m8+qsyiQuTAGIwtAepKwin40SWpSwtwn/Nn+fLnsPMsqxMnF8z1zi7wKvJ1H1+WWJ1NfCGgd4R+kLy7K2HLkaSFG1kR1IFkFVcm5pJRgClH2L2XK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2UJ6hcs03JPj6RxPQh5w7DSM0RN94D2/1i2i8REzko=;
 b=VHtt7mRktI1+yr3e5k/7Fp/ztDWbV7cj3PhhDFYjLzd3lCpWW80US0nDhw2OsyfmnJX5pObKxgOYd/UctufikDf3+9HS/7Bu+Qs5YZdSJfehIYC/ASDj7swwooGS++qs5eqMKl2puZg045WhqtUkHKJI1LICS+ZqIPg0555HxJFSQ7xZFADpIBc3frvV3OEk0U4wtdUVBeURVbAY4ZA09p5FKeGNxXukFc4ciaPY98QvCKYy2InnSmT9Bzu4mqmX1aNXuaLFxxL6ntu7gNsoGqyQLlPzC4Jpz2EwFY6MWgmRXnGVteKUgrMVlX7LmgQI+LL4ehMGCE8b0DHSQGSPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0053.namprd12.prod.outlook.com (2603:10b6:300:103::15)
 by SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17; Thu, 31 Oct
 2019 14:42:30 +0000
Received: from DM3NAM03FT043.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by MWHPR12CA0053.outlook.office365.com
 (2603:10b6:300:103::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.20 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:30 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT043.mail.protection.outlook.com (10.152.83.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:30 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:28 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:28 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/20] drm/amd/display: Fix assert observed when performing
 dummy p-state check
Date: Thu, 31 Oct 2019 10:41:53 -0400
Message-ID: <20191031144210.24011-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(428003)(189003)(199004)(316002)(16586007)(70586007)(70206006)(6916009)(47776003)(8676002)(81166006)(50226002)(305945005)(4326008)(478600001)(53416004)(81156014)(8936002)(50466002)(86362001)(486006)(6666004)(36756003)(51416003)(356004)(186003)(7696005)(2906002)(1076003)(26005)(48376002)(446003)(336012)(126002)(476003)(426003)(2616005)(11346002)(2351001)(5660300002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2605; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e4ad3f4-ebb5-4a92-b6f5-08d75e108eba
X-MS-TrafficTypeDiagnostic: SN6PR12MB2605:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26058F81A7685008C7E38952F9630@SN6PR12MB2605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZ05rXDpEAds2sy2TicHyyMo6r3nL6Alt7Z18TTkwnupRNUZZ9eGRsl1xXVEf0EoDwTrh+pSpdINt6O/wHYH/eJl8SyTv9IukyyzH86YwJBKMPelIWGl7EmsQzhsY5GkGLKcMl+M+00JGrICC5Kxmpe5Zs31EOi2DR1I6/aukDc9Vgt7JrngkMg2FmpBeOl/FzF3REXwKE8JxnzXyV+UZJ2zf97jVHX+YfuAb0y9WfrDBNHpw81Apx2q9I1ESJ2Ea15xfTyXAoaYuLio7jz4WUJu8PvbT9+h2a74hTyUQDZ27F0UaVoDr5BstknruJeV3Pu5vLxGfi2FvhuQFvos8iCLctlbgXkvAZJ4VKr3vWVnR9m+pU1OsZQ8O2z0mDvbDxjBArKiau4bSmkCVVzHHNb97atJ0K+5EnRqi/yCWlHqx9o46ifYL17fxNYjJVnK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:30.2392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4ad3f4-ebb5-4a92-b6f5-08d75e108eba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2UJ6hcs03JPj6RxPQh5w7DSM0RN94D2/1i2i8REzko=;
 b=CwjMnAGplSWDejRmtTmULph0s+b+ik702M477cpVpTBkwxWnu3FPCujX3O0UKhhOwFEkdc8U1Gbpk9nCEIP/k1+P/GDRc3YwI2RlMd6gbhA6OeW0xBFjIPgm263ugflLJ2U1O2EvSvnX1ex6eYbrUkbCME9v35rjAj3APA0hj2g=
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
Cc: David Galiffi <David.Galiffi@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144153.Og1VNBnoYNBIcYODIT9uuWGVCGi4IrjV9y5SScF2_2A@z>

RnJvbTogRGF2aWQgR2FsaWZmaSA8RGF2aWQuR2FsaWZmaUBhbWQuY29tPgoKW1dIWV0KVi5BY3Rp
dmUgZHJhbSBjbG9jayBjaGFuZ2Ugd29ya2Fyb3VuZCBuZWVkIGEgc21hbGwgbW9kaWZpY2F0aW9u
IGZvciBETUx2Mgp0byBlbnN1cmUgdGhhdCB0aGUgZHVtbXkgcC1zdGF0ZSBjaGVjayBkb2Vzbid0
IGZhaWwuCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBHYWxpZmZpIDxEYXZpZC5HYWxpZmZpQGFtZC5j
b20+ClJldmlld2VkLWJ5OiBKdW4gTGVpIDxKdW4uTGVpQGFtZC5jb20+CkFja2VkLWJ5OiBCaGF3
YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KLS0tCiAuLi4vZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMHYyLmMgIHwgNCAr
KysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV92YmEu
YyAgICAgICAgIHwgMiArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNw
bGF5X21vZGVfdmJhLmggICAgICAgICB8IDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rj
bjIwL2Rpc3BsYXlfbW9kZV92YmFfMjB2Mi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RtbC9kY24yMC9kaXNwbGF5X21vZGVfdmJhXzIwdjIuYwppbmRleCAzYzcwZGQ1NzcyOTIu
LmQ2M2NhNGNjZjdjZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RtbC9kY24yMC9kaXNwbGF5X21vZGVfdmJhXzIwdjIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjB2Mi5jCkBAIC0yNjEx
LDkgKzI2MTEsMTMgQEAgc3RhdGljIHZvaWQgZG1sMjB2Ml9ESVNQQ0xLRFBQQ0xLRENGQ0xLRGVl
cFNsZWVwUHJlZmV0Y2hQYXJhbWV0ZXJzV2F0ZXJtYXJrc0FuZFAKIAkJCW1vZGVfbGliLT52YmEu
TWluQWN0aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luCiAJCQkJCSsgbW9kZV9saWItPnZiYS5EUkFN
Q2xvY2tDaGFuZ2VMYXRlbmN5OwogCisKIAlpZiAobW9kZV9saWItPnZiYS5NaW5BY3RpdmVEUkFN
Q2xvY2tDaGFuZ2VNYXJnaW4gPiA1MCkgewogCQltb2RlX2xpYi0+dmJhLkRSQU1DbG9ja0NoYW5n
ZVdhdGVybWFyayArPSAyNTsKIAkJbW9kZV9saWItPnZiYS5EUkFNQ2xvY2tDaGFuZ2VTdXBwb3J0
WzBdWzBdID0gZG1fZHJhbV9jbG9ja19jaGFuZ2VfdmFjdGl2ZTsKKwl9IGVsc2UgaWYgKG1vZGVf
bGliLT52YmEuRHVtbXlQU3RhdGVDaGVjayAmJgorCQkJCW1vZGVfbGliLT52YmEuTWluQWN0aXZl
RFJBTUNsb2NrQ2hhbmdlTWFyZ2luID4gMCkgeworCQltb2RlX2xpYi0+dmJhLkRSQU1DbG9ja0No
YW5nZVN1cHBvcnRbMF1bMF0gPSBkbV9kcmFtX2Nsb2NrX2NoYW5nZV92YWN0aXZlOwogCX0gZWxz
ZSB7CiAJCWlmIChtb2RlX2xpYi0+dmJhLlN5bmNocm9uaXplZFZCbGFuayB8fCBtb2RlX2xpYi0+
dmJhLk51bWJlck9mQWN0aXZlUGxhbmVzID09IDEpIHsKIAkJCW1vZGVfbGliLT52YmEuRFJBTUNs
b2NrQ2hhbmdlU3VwcG9ydFswXVswXSA9IGRtX2RyYW1fY2xvY2tfY2hhbmdlX3ZibGFuazsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2Rl
X3ZiYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVf
dmJhLmMKaW5kZXggN2Y5YTU2MjE5MjJmLi44MWRiODUxN2E2OTAgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3ZiYS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3ZiYS5jCkBAIC0y
MjIsNiArMjIyLDggQEAgc3RhdGljIHZvaWQgZmV0Y2hfc29jYmJfcGFyYW1zKHN0cnVjdCBkaXNw
bGF5X21vZGVfbGliICptb2RlX2xpYikKIAltb2RlX2xpYi0+dmJhLlNSRXhpdFRpbWUgPSBzb2Mt
PnNyX2V4aXRfdGltZV91czsKIAltb2RlX2xpYi0+dmJhLlNSRW50ZXJQbHVzRXhpdFRpbWUgPSBz
b2MtPnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzOwogCW1vZGVfbGliLT52YmEuRFJBTUNsb2Nr
Q2hhbmdlTGF0ZW5jeSA9IHNvYy0+ZHJhbV9jbG9ja19jaGFuZ2VfbGF0ZW5jeV91czsKKwltb2Rl
X2xpYi0+dmJhLkR1bW15UFN0YXRlQ2hlY2sgPSBzb2MtPmRyYW1fY2xvY2tfY2hhbmdlX2xhdGVu
Y3lfdXMgPT0gc29jLT5kdW1teV9wc3RhdGVfbGF0ZW5jeV91czsKKwogCW1vZGVfbGliLT52YmEu
RG93bnNwcmVhZGluZyA9IHNvYy0+ZG93bnNwcmVhZF9wZXJjZW50OwogCW1vZGVfbGliLT52YmEu
RFJBTUNoYW5uZWxXaWR0aCA9IHNvYy0+ZHJhbV9jaGFubmVsX3dpZHRoX2J5dGVzOyAgIC8vIG5l
dyEKIAltb2RlX2xpYi0+dmJhLkZhYnJpY0RhdGFwYXRoVG9EQ05EYXRhUmV0dXJuID0gc29jLT5m
YWJyaWNfZGF0YXBhdGhfdG9fZGNuX2RhdGFfcmV0dXJuX2J5dGVzOyAvLyBuZXchCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV92YmEu
aCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3ZiYS5o
CmluZGV4IDE1NDBmZmJlMzk3OS4uNmM1OWEzMzIwOTNhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV92YmEuaAorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV92YmEuaApAQCAtMTU1LDYg
KzE1NSw3IEBAIHN0cnVjdCB2YmFfdmFyc19zdCB7CiAJZG91YmxlIFVyZ2VudExhdGVuY3lTdXBw
b3J0VXNDaHJvbWE7CiAJdW5zaWduZWQgaW50IERTQ0Zvcm1hdEZhY3RvcjsKIAorCWJvb2wgRHVt
bXlQU3RhdGVDaGVjazsKIAlib29sIFByZWZldGNoTW9kZVN1cHBvcnRlZDsKIAllbnVtIHNlbGZf
cmVmcmVzaF9hZmZpbml0eSBBbGxvd0RSQU1TZWxmUmVmcmVzaE9yRFJBTUNsb2NrQ2hhbmdlSW5W
Ymxhbms7IC8vIE1vZGUgU3VwcG9ydCBvbmx5CiAJZG91YmxlIFhGQ1JlbW90ZVN1cmZhY2VGbGlw
RGVsYXk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
