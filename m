Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE855C5DF62
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 15:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEC02190F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 15:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEC02190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767946EABB;
	Tue,  5 Nov 2019 15:35:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770089.outbound.protection.outlook.com [40.107.77.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8316EABB
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 15:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRIdEEb+udoOuAt7Pi99gog+pM0pBJaDlK7i5g6NHnP0iiJ9rUsXP3DOuyEHbUR9xZ88qCs7zVn5VC/9wtQUIPF3rUDNmq3/WI2n71X7/DqtkXFAMuzBj46RHG1enA5aQNYW2UVrI/rmlpxF28lzLLbt0muGKi9P05uvLGFFoq/3Wt7nR5gYrWe/Leel6bCWexQnHXFK65a3jjqKLobDdxzyZRZ74lnI7nLWENmpum7fnVWuzXoVBdg10NY9jCbsBb9btW7IRe08h/IbyKWOxYOwCVzaa/QRuBRBSjqQvaeDwR3X18KXRae98YZYR2Q8NiI9nMJsaONLt5PVQzn13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWV4TycRaSlw0YFSdYy/7iZejGjQZShssQEfNRPsG9o=;
 b=lbhsQaxlQMVcjQMP6jLFCtR64Q43TAa/m+tsjrOuHelBgMBPLukLUqih0ekpPd36z0IwVRYlujRD0HaMqYs8sTpCvrochnwoVvhbvvUWJjpfcbfCGRia9vrSejr7T+4hbmQQVUt349QHosEC2nHKQhZxn1dmA7xv4axv4mFsVxbSkuDwAbhoycF5bnULUHX0woCK0czmLw1j9t0BqP2ylyxCnbfm//+qfqs8QmNZifIsYDNiKFzWPm3MTAjSBrO0sI3qylt3TIL+RLwTYP67DY1wc9agv5fEnzIthEKtkeaTves9aVo0ZGfUdfE8YZ55i7JnKryuVH4npMLGoCOi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0034.namprd12.prod.outlook.com (2603:10b6:903:129::20)
 by BN8PR12MB3427.namprd12.prod.outlook.com (2603:10b6:408:62::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Tue, 5 Nov
 2019 15:35:18 +0000
Received: from DM3NAM03FT031.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by CY4PR12CA0034.outlook.office365.com
 (2603:10b6:903:129::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Tue, 5 Nov 2019 15:35:18 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT031.mail.protection.outlook.com (10.152.82.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Tue, 5 Nov 2019 15:35:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 5 Nov 2019
 09:35:17 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 5 Nov 2019
 09:35:17 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 5 Nov 2019 09:35:16 -0600
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Disable VUpdate interrupt for DCN
 hardware
Date: Tue, 5 Nov 2019 10:34:16 -0500
Message-ID: <20191105153416.32049-2-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105153416.32049-1-sunpeng.li@amd.com>
References: <20191105153416.32049-1-sunpeng.li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(428003)(189003)(199004)(446003)(2870700001)(1076003)(8676002)(11346002)(186003)(4326008)(14444005)(54906003)(316002)(6916009)(2351001)(36756003)(50226002)(478600001)(2616005)(81156014)(51416003)(26005)(126002)(70586007)(70206006)(2906002)(86362001)(356004)(336012)(47776003)(8936002)(426003)(305945005)(2876002)(50466002)(5660300002)(48376002)(486006)(76176011)(81166006)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3427; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cc3a74a-4e02-447d-97e6-08d76205c2e6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3427:
X-Microsoft-Antispam-PRVS: <BN8PR12MB342742A8748E4D5C8412053D827E0@BN8PR12MB3427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0212BDE3BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/5NvdxzocbXTvb6kk318FQK1Ei6moJk17pwJ38TMkLOybbU+Mz09ttdDI2J+yuEywK6a2MFHakng4gvbFVvtKSH4U1jlskQa3nfER0p9LHuI8c4L2qcpDidxGK9WOxNs+R9mJLy03RglPkKgTEP4ENiADiYbR0EDBB1B9e/STIkKMOVIOMqcqRtMMAbL/Kl8bdBWRGj0A6RbEe6xDm7jkyi/yS1ewoHsGl3GDxq31Wt/oxyDef2wRGmNBCTEqwqIUBkSFEPOPnnQXfmJLb+hdm9IvDqGP2kPwDVCaNRyc2V9muhUsg9hf8n2OVpwc4AHQWQt5t0SpGLkC31SvOfqdIao7X4sgjNgsmhsGoRTej8O67suJl9vvMhISvPi0BhIKe7PoZ5be9PtKUQGZP9h9WLro6fJaNkyG00adSA5CG2tTzMtFj35zieZbL9wy8a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2019 15:35:17.9594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc3a74a-4e02-447d-97e6-08d76205c2e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3427
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWV4TycRaSlw0YFSdYy/7iZejGjQZShssQEfNRPsG9o=;
 b=d+vy46eiABBu8yW0LEw2W6bA3O5qz/7GxApaDJwy2v/HPFr0ZkfCbcTD5bWXlprUIRAEuVFQaQKwg8jQeXop4f6QnXa4hm95rzpG62/kM5/d2tP2WV+e7OnUvIp9qWd928BqIM9fRVHe71G05O7PfLPOSMIouNC58Qh0EGBYv9Q=
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
Message-ID: <20191105153416.P8aIhkMmKLfwfodb_aECZFOVBkO5o-GZyKt9SBagVoU@z>

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
LW9mZi1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogLi4uL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMzQgKysrLS0tLS0tLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXgg
MjU2YTIzYTBlYzI4Li41NjhkZjA0NmIyZmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMjI0MSwzNCArMjI0MSw2IEBAIHN0
YXRpYyBpbnQgZGNuMTBfcmVnaXN0ZXJfaXJxX2hhbmRsZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogCQkJCWRtX2Rjbl9jcnRjX2hpZ2hfaXJxLCBjX2lycV9wYXJhbXMpOwogCX0KCi0J
LyogVXNlIFZVUERBVEVfTk9fTE9DSyBpbnRlcnJ1cHQgb24gRENOLCB3aGljaCBzZWVtcyB0byBj
b3JyZXNwb25kIHRvCi0JICogdGhlIHJlZ3VsYXIgVlVQREFURSBpbnRlcnJ1cHQgb24gRENFLiBX
ZSB3YW50IERDX0lSUV9TT1VSQ0VfVlVQREFURXgKLQkgKiB0byB0cmlnZ2VyIGF0IGVuZCBvZiBl
YWNoIHZibGFuaywgcmVnYXJkbGVzcyBvZiBzdGF0ZSBvZiB0aGUgbG9jaywKLQkgKiBtYXRjaGlu
ZyBEQ0UgYmVoYXZpb3VyLgotCSAqLwotCWZvciAoaSA9IERDTl8xXzBfX1NSQ0lEX19PVEcwX0lI
Q19WX1VQREFURV9OT19MT0NLX0lOVEVSUlVQVDsKLQkgICAgIGkgPD0gRENOXzFfMF9fU1JDSURf
X09URzBfSUhDX1ZfVVBEQVRFX05PX0xPQ0tfSU5URVJSVVBUICsgYWRldi0+bW9kZV9pbmZvLm51
bV9jcnRjIC0gMTsKLQkgICAgIGkrKykgewotCQlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwg
U09DMTVfSUhfQ0xJRU5USURfRENFLCBpLCAmYWRldi0+dnVwZGF0ZV9pcnEpOwotCi0JCWlmIChy
KSB7Ci0JCQlEUk1fRVJST1IoIkZhaWxlZCB0byBhZGQgdnVwZGF0ZSBpcnEgaWQhXG4iKTsKLQkJ
CXJldHVybiByOwotCQl9Ci0KLQkJaW50X3BhcmFtcy5pbnRfY29udGV4dCA9IElOVEVSUlVQVF9I
SUdIX0lSUV9DT05URVhUOwotCQlpbnRfcGFyYW1zLmlycV9zb3VyY2UgPQotCQkJZGNfaW50ZXJy
dXB0X3RvX2lycV9zb3VyY2UoZGMsIGksIDApOwotCi0JCWNfaXJxX3BhcmFtcyA9ICZhZGV2LT5k
bS52dXBkYXRlX3BhcmFtc1tpbnRfcGFyYW1zLmlycV9zb3VyY2UgLSBEQ19JUlFfU09VUkNFX1ZV
UERBVEUxXTsKLQotCQljX2lycV9wYXJhbXMtPmFkZXYgPSBhZGV2OwotCQljX2lycV9wYXJhbXMt
PmlycV9zcmMgPSBpbnRfcGFyYW1zLmlycV9zb3VyY2U7Ci0KLQkJYW1kZ3B1X2RtX2lycV9yZWdp
c3Rlcl9pbnRlcnJ1cHQoYWRldiwgJmludF9wYXJhbXMsCi0JCQkJZG1fdnVwZGF0ZV9oaWdoX2ly
cSwgY19pcnFfcGFyYW1zKTsKLQl9Ci0KIAkvKiBVc2UgR1JQSF9QRkxJUCBpbnRlcnJ1cHQgKi8K
IAlmb3IgKGkgPSBEQ05fMV8wX19TUkNJRF9fSFVCUDBfRkxJUF9JTlRFUlJVUFQ7CiAJCQlpIDw9
IERDTl8xXzBfX1NSQ0lEX19IVUJQMF9GTElQX0lOVEVSUlVQVCArIGFkZXYtPm1vZGVfaW5mby5u
dW1fY3J0YyAtIDE7CkBAIC00MjY2LDcgKzQyMzgsNyBAQCBzdGF0aWMgaW5saW5lIGludCBkbV9z
ZXRfdmJsYW5rKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywgYm9vbCBlbmFibGUpCiAJc3RydWN0IGRt
X2NydGNfc3RhdGUgKmFjcnRjX3N0YXRlID0gdG9fZG1fY3J0Y19zdGF0ZShjcnRjLT5zdGF0ZSk7
CiAJaW50IHJjID0gMDsKCi0JaWYgKGVuYWJsZSkgeworCWlmIChlbmFibGUgJiYgYWRldi0+ZmFt
aWx5IDwgQU1ER1BVX0ZBTUlMWV9BSSkgewogCQkvKiB2YmxhbmsgaXJxIG9uIC0+IE9ubHkgbmVl
ZCB2dXBkYXRlIGlycSBpbiB2cnIgbW9kZSAqLwogCQlpZiAoYW1kZ3B1X2RtX3Zycl9hY3RpdmUo
YWNydGNfc3RhdGUpKQogCQkJcmMgPSBkbV9zZXRfdnVwZGF0ZV9pcnEoY3J0YywgdHJ1ZSk7CkBA
IC02MjQzLDYgKzYyMTUsNyBAQCBzdGF0aWMgdm9pZCBwcmVfdXBkYXRlX2ZyZWVzeW5jX3N0YXRl
X29uX3N0cmVhbSgKIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9oYW5kbGVfdnJyX3RyYW5zaXRpb24o
c3RydWN0IGRtX2NydGNfc3RhdGUgKm9sZF9zdGF0ZSwKIAkJCQkJICAgIHN0cnVjdCBkbV9jcnRj
X3N0YXRlICpuZXdfc3RhdGUpCiB7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBvbGRf
c3RhdGUtPmJhc2UuY3J0Yy0+ZGV2LT5kZXZfcHJpdmF0ZTsKIAlib29sIG9sZF92cnJfYWN0aXZl
ID0gYW1kZ3B1X2RtX3Zycl9hY3RpdmUob2xkX3N0YXRlKTsKIAlib29sIG5ld192cnJfYWN0aXZl
ID0gYW1kZ3B1X2RtX3Zycl9hY3RpdmUobmV3X3N0YXRlKTsKCkBAIC02MjU1LDcgKzYyMjgsOCBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfZG1faGFuZGxlX3Zycl90cmFuc2l0aW9uKHN0cnVjdCBkbV9j
cnRjX3N0YXRlICpvbGRfc3RhdGUsCiAJCSAqIFdlIGFsc28gbmVlZCB2dXBkYXRlIGlycSBmb3Ig
dGhlIGFjdHVhbCBjb3JlIHZibGFuayBoYW5kbGluZwogCQkgKiBhdCBlbmQgb2YgdmJsYW5rLgog
CQkgKi8KLQkJZG1fc2V0X3Z1cGRhdGVfaXJxKG5ld19zdGF0ZS0+YmFzZS5jcnRjLCB0cnVlKTsK
KwkJaWYgKGFkZXYtPmZhbWlseSA8IEFNREdQVV9GQU1JTFlfQUkpCisJCQlkbV9zZXRfdnVwZGF0
ZV9pcnEobmV3X3N0YXRlLT5iYXNlLmNydGMsIHRydWUpOwogCQlkcm1fY3J0Y192YmxhbmtfZ2V0
KG5ld19zdGF0ZS0+YmFzZS5jcnRjKTsKIAkJRFJNX0RFQlVHX0RSSVZFUigiJXM6IGNydGM9JXUg
VlJSIG9mZi0+b246IEdldCB2YmxhbmsgcmVmXG4iLAogCQkJCSBfX2Z1bmNfXywgbmV3X3N0YXRl
LT5iYXNlLmNydGMtPmJhc2UuaWQpOwotLQoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
