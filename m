Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07557C5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 05:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E382085B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 05:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E382085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4225D6E5BD;
	Fri,  8 Nov 2019 05:43:00 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE6D6E5BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 05:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5wyCo1gnsihx0SCzv2C7CAJs+NzmX9kO6e1lDUjfLl+cvLOUdTqQYWr5frYUbowoClKMT9IPbf9I6FuCSgcGRAwttYZ8jzRJqJ4AoLccEtWcF0A/l7dfuzOSGFRdNzBM56AoQdExP09HdjDiS0NlyUOBReqlv9raMMQjJ2pkz16PnV4V516o/TNvOjBX97bOU91EQHYEJzhJycxQ5br6PLomJkOnd2B4DwAz09KnX1P+yS1iDrryFRzzVkAQtwgt0QkT6Xujs9IdEdT4gZomb/4gjktacLQzDzKRP3W9S/QzqWhRmyRBFETxt0FFw2czByJtxTyG1EhR78/zBELNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmzQ2QjlVWcBvtFj4yWc3a3H3Twnu7WrpbKSg3bBekg=;
 b=H5IVfyrjIkrwL2fFQ4oc2M5Rl0G9ZAE974nEBGojvDDupWm3jjf/xc8YQF3mCfXJTPPBWgwgzlfXF3gxpISp+mWCvi7POfgntcINqdTiycmR47+qcRHXHO5WW15fX+0YT3aFVZrr/8fQLbN8AFoVH0n845ee4FqUQbi2Ql7BxF/fuKLB/E7IPrTcKh2P6anpnVsXQ/jXApXAhBDEbfxnsQKPulXDcErHGwtZQlXmIbKLHbVh+SCFG79z6WyqAJME90B3q3P7wuVsP6ACw3ANPVY7FFJ/VkXe6Bv8sosrZ4f9hdRq2vv6mJgztIfHKN8vnlcp3vhLqDvRe0VNrDQ0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0106.namprd12.prod.outlook.com (2603:10b6:802:21::41)
 by DM5PR12MB1177.namprd12.prod.outlook.com (2603:10b6:3:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Fri, 8 Nov
 2019 05:42:56 +0000
Received: from DM3NAM03FT034.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::203) by SN1PR12CA0106.outlook.office365.com
 (2603:10b6:802:21::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24 via Frontend
 Transport; Fri, 8 Nov 2019 05:42:56 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT034.mail.protection.outlook.com (10.152.82.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Fri, 8 Nov 2019 05:42:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 23:42:55 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 23:42:55 -0600
Received: from lnx-kenneth.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 23:42:54 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for
 compute
Date: Fri, 8 Nov 2019 13:42:51 +0800
Message-ID: <1573191771-8071-1-git-send-email-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(428003)(189003)(199004)(426003)(2616005)(336012)(316002)(70586007)(126002)(305945005)(16586007)(186003)(36756003)(50466002)(48376002)(14444005)(44832011)(476003)(486006)(8936002)(81156014)(51416003)(81166006)(8676002)(50226002)(356004)(5660300002)(86362001)(2906002)(53416004)(6916009)(7696005)(70206006)(4326008)(6666004)(2351001)(47776003)(478600001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1177; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3835aa43-5127-4c6c-a67c-08d7640e8165
X-MS-TrafficTypeDiagnostic: DM5PR12MB1177:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1177EB8A3184E265F5D62B0F8E7B0@DM5PR12MB1177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 0215D7173F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ozmayh/gXtWSp/UrLn33KlzCWtjkLj6BVYFPweQG5f+5jdXdWFQmbepT3X9krwp+ojt4+GosGwEmMz3KIFg0mr3J+2Lq1at/G/vHwFiFM/FI34J54JDpY0oh4iGBQ/Vxu3Y6LKVzfnbO+Ef9sypAJ3TLA2gAC9urkqYa+SgrLvnEFCbCI3jGH8RuRBJ9b3eqCMRYByFUgeg4Z76YZOyLDjBKt3MiQ9rbmqIJ54goG7VusaIp3y/fwEb8c6K7aTeEqJPWNLX4TuEtDatb05NNgmO3feTUzykVpaQ9lFgDxkB+5i0Z+GJQDWsZjGT/YnN5d0s1TrbJPCaGbt8h4d1i4MzwQXCd7Gm2D3CWRApnoJAykGleZYdFgt7Vo/X3zYgq+BRxPvcQdMpiYMErHeuBrg5jFFbIM24GJvwXQQyuGDd2G53udr9QbPI8uMxLdlG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2019 05:42:55.8536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3835aa43-5127-4c6c-a67c-08d7640e8165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmzQ2QjlVWcBvtFj4yWc3a3H3Twnu7WrpbKSg3bBekg=;
 b=jr9CO+u9YqWyI04yw/eQq3Rn273/eDEUAhBIdcjFwTWBE/bfzByZ1utA8hu5RyeXYbl4R3Bdxde/4dnuHEQJJ+LJZ5EttJUAyRR/Qp+8Gv9dCFhsUrE2n6oyg+feIExP45Rh5C1KYekHf4ccY5vy6FUzyn7aRjGzBn07EbFP84w=
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108054251.H-TY1Fu9wBDSN9y3tzc3xLBBDU7HproacleYxwlsFTU@z>

VGhpcyBpcyB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBpbiB0aGUgY29tcHV0ZSBtb2RlCmZv
ciB2ZWdhMTAuIEZvciBleGFtcGxlLCB0aGUgb3JpZ2luYWwgcGVyZm9ybWFuY2UgZm9yIGEgcm9j
bQpiYW5kd2lkdGggdGVzdDogMkcgaW50ZXJuYWwgR1BVIGNvcHksIGlzIGFib3V0IDk5R0Ivcy4K
V2l0aCB0aGUgaWRsZSBwb3dlciBmZWF0dXJlcyBkaXNhYmxlZCBkeW5hbWljYWxseSwgdGhlIHBv
cmZvcm1hbmNlCmlzIHByb21vdGVkIHRvIGFib3V0IDIxNUdCL3MuCgpTaWduZWQtb2ZmLWJ5OiBL
ZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYyAgICAgIHwgIDcgKysrCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyB8IDU1ICsrKysrKysrKysrKysr
KysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9od21nci5oICAgICAg
ICAgIHwgIDIgKwogMyBmaWxlcyBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jCmluZGV4IDAzMTQ0NzYuLmJk
MzVmNjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dl
cnBsYXkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5
LmMKQEAgLTk2OSw2ICs5NjksMTMgQEAgc3RhdGljIGludCBwcF9kcG1fc3dpdGNoX3Bvd2VyX3By
b2ZpbGUodm9pZCAqaGFuZGxlLAogCQl3b3JrbG9hZCA9IGh3bWdyLT53b3JrbG9hZF9zZXR0aW5n
W2luZGV4XTsKIAl9CiAKKwlpZiAodHlwZSA9PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRF
ICYmCisJCWh3bWdyLT5od21ncl9mdW5jLT5kaXNhYmxlX3Bvd2VyX2ZlYXR1cmVzX2Zvcl9jb21w
dXRlX3BlcmZvcm1hbmNlKQorCQkJaWYgKGh3bWdyLT5od21ncl9mdW5jLT5kaXNhYmxlX3Bvd2Vy
X2ZlYXR1cmVzX2Zvcl9jb21wdXRlX3BlcmZvcm1hbmNlKGh3bWdyLCBlbikpIHsKKwkJCQltdXRl
eF91bmxvY2soJmh3bWdyLT5zbXVfbG9jayk7CisJCQkJcmV0dXJuIC1FSU5WQUw7CisJCQl9CisK
IAlpZiAoaHdtZ3ItPmRwbV9sZXZlbCAhPSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9NQU5VQUwpCiAJ
CWh3bWdyLT5od21ncl9mdW5jLT5zZXRfcG93ZXJfcHJvZmlsZV9tb2RlKGh3bWdyLCAmd29ya2xv
YWQsIDApOwogCW11dGV4X3VubG9jaygmaHdtZ3ItPnNtdV9sb2NrKTsKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMKaW5kZXggNGVhNjNh
Mi4uZDMyMjljMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdt
Z3IvdmVnYTEwX2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdt
Z3IvdmVnYTEwX2h3bWdyLmMKQEAgLTUyNjMsNiArNTI2Myw1OSBAQCBzdGF0aWMgaW50IHZlZ2Ex
MF9nZXRfcGVyZm9ybWFuY2VfbGV2ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwgY29uc3Qgc3Ry
dWN0IHBwXwogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IHZlZ2ExMF9kaXNhYmxlX3Bvd2Vy
X2ZlYXR1cmVzX2Zvcl9jb21wdXRlX3BlcmZvcm1hbmNlKHN0cnVjdCBwcF9od21nciAqaHdtZ3Is
IGJvb2wgZGlzYWJsZSkKK3sKKwlzdHJ1Y3QgdmVnYTEwX2h3bWdyICpkYXRhID0gaHdtZ3ItPmJh
Y2tlbmQ7CisJdWludDMyX3QgZmVhdHVyZV9tYXNrID0gMDsKKworCWlmIChkaXNhYmxlKSB7CisJ
CWZlYXR1cmVfbWFzayB8PSBkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9VTFZdLmVuYWJsZWQgPwor
CQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfVUxWXS5zbXVfZmVhdHVyZV9iaXRtYXAgOiAwOwor
CQlmZWF0dXJlX21hc2sgfD0gZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5lbmFi
bGVkID8KKwkJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0dGWENMS10uc211X2ZlYXR1cmVf
Yml0bWFwIDogMDsKKwkJZmVhdHVyZV9tYXNrIHw9IGRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RT
X1NPQ0NMS10uZW5hYmxlZCA/CisJCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19TT0NDTEtd
LnNtdV9mZWF0dXJlX2JpdG1hcCA6IDA7CisJCWZlYXR1cmVfbWFzayB8PSBkYXRhLT5zbXVfZmVh
dHVyZXNbR05MRF9EU19MQ0xLXS5lbmFibGVkID8KKwkJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxE
X0RTX0xDTEtdLnNtdV9mZWF0dXJlX2JpdG1hcCA6IDA7CisJCWZlYXR1cmVfbWFzayB8PSBkYXRh
LT5zbXVfZmVhdHVyZXNbR05MRF9EU19EQ0VGQ0xLXS5lbmFibGVkID8KKwkJCWRhdGEtPnNtdV9m
ZWF0dXJlc1tHTkxEX0RTX0RDRUZDTEtdLnNtdV9mZWF0dXJlX2JpdG1hcCA6IDA7CisJfSBlbHNl
IHsKKwkJZmVhdHVyZV9tYXNrIHw9ICghZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfVUxWXS5lbmFi
bGVkKSA/CisJCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9VTFZdLnNtdV9mZWF0dXJlX2JpdG1h
cCA6IDA7CisJCWZlYXR1cmVfbWFzayB8PSAoIWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0dG
WENMS10uZW5hYmxlZCkgPworCQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5z
bXVfZmVhdHVyZV9iaXRtYXAgOiAwOworCQlmZWF0dXJlX21hc2sgfD0gKCFkYXRhLT5zbXVfZmVh
dHVyZXNbR05MRF9EU19TT0NDTEtdLmVuYWJsZWQpID8KKwkJCWRhdGEtPnNtdV9mZWF0dXJlc1tH
TkxEX0RTX1NPQ0NMS10uc211X2ZlYXR1cmVfYml0bWFwIDogMDsKKwkJZmVhdHVyZV9tYXNrIHw9
ICghZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfTENMS10uZW5hYmxlZCkgPworCQkJZGF0YS0+
c211X2ZlYXR1cmVzW0dOTERfRFNfTENMS10uc211X2ZlYXR1cmVfYml0bWFwIDogMDsKKwkJZmVh
dHVyZV9tYXNrIHw9ICghZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfRENFRkNMS10uZW5hYmxl
ZCkgPworCQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfRENFRkNMS10uc211X2ZlYXR1cmVf
Yml0bWFwIDogMDsKKwl9CisKKwlpZiAoZmVhdHVyZV9tYXNrKQorCQlQUF9BU1NFUlRfV0lUSF9D
T0RFKCF2ZWdhMTBfZW5hYmxlX3NtY19mZWF0dXJlcyhod21nciwKKwkJCQkhZGlzYWJsZSwgZmVh
dHVyZV9tYXNrKSwKKwkJCQkiZW5hYmxlL2Rpc2FibGUgcG93ZXIgZmVhdHVyZXMgZm9yIGNvbXB1
dGUgcGVyZm9ybWFuY2UgRmFpbGVkISIsCisJCQkJcmV0dXJuIC1FSU5WQUwpOworCisJaWYgKGRp
c2FibGUpIHsKKwkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfVUxWXS5lbmFibGVkID0gZmFsc2U7
CisJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0dGWENMS10uZW5hYmxlZCA9IGZhbHNlOwor
CQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19TT0NDTEtdLmVuYWJsZWQgPSBmYWxzZTsKKwkJ
ZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfTENMS10uZW5hYmxlZCA9IGZhbHNlOworCQlkYXRh
LT5zbXVfZmVhdHVyZXNbR05MRF9EU19EQ0VGQ0xLXS5lbmFibGVkID0gZmFsc2U7CisJfSBlbHNl
IHsKKwkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfVUxWXS5lbmFibGVkID0gdHJ1ZTsKKwkJZGF0
YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5lbmFibGVkID0gdHJ1ZTsKKwkJZGF0YS0+
c211X2ZlYXR1cmVzW0dOTERfRFNfU09DQ0xLXS5lbmFibGVkID0gdHJ1ZTsKKwkJZGF0YS0+c211
X2ZlYXR1cmVzW0dOTERfRFNfTENMS10uZW5hYmxlZCA9IHRydWU7CisJCWRhdGEtPnNtdV9mZWF0
dXJlc1tHTkxEX0RTX0RDRUZDTEtdLmVuYWJsZWQgPSB0cnVlOworCX0KKworCXJldHVybiAwOwor
Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHBfaHdtZ3JfZnVuYyB2ZWdhMTBfaHdtZ3JfZnVu
Y3MgPSB7CiAJLmJhY2tlbmRfaW5pdCA9IHZlZ2ExMF9od21ncl9iYWNrZW5kX2luaXQsCiAJLmJh
Y2tlbmRfZmluaSA9IHZlZ2ExMF9od21ncl9iYWNrZW5kX2ZpbmksCkBAIC01MzMwLDYgKzUzODMs
OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwX2h3bWdyX2Z1bmMgdmVnYTEwX2h3bWdyX2Z1bmNz
ID0gewogCS5nZXRfcHBmZWF0dXJlX3N0YXR1cyA9IHZlZ2ExMF9nZXRfcHBmZWF0dXJlX3N0YXR1
cywKIAkuc2V0X3BwZmVhdHVyZV9zdGF0dXMgPSB2ZWdhMTBfc2V0X3BwZmVhdHVyZV9zdGF0dXMs
CiAJLnNldF9tcDFfc3RhdGUgPSB2ZWdhMTBfc2V0X21wMV9zdGF0ZSwKKwkuZGlzYWJsZV9wb3dl
cl9mZWF0dXJlc19mb3JfY29tcHV0ZV9wZXJmb3JtYW5jZSA9CisJCQl2ZWdhMTBfZGlzYWJsZV9w
b3dlcl9mZWF0dXJlc19mb3JfY29tcHV0ZV9wZXJmb3JtYW5jZSwKIH07CiAKIGludCB2ZWdhMTBf
aHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2h3bWdyLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9pbmMvaHdtZ3IuaAppbmRleCA0MDQwM2JjLi5hZjk3NzY3IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaApAQCAtMzU3LDYgKzM1Nyw4IEBAIHN0cnVj
dCBwcF9od21ncl9mdW5jIHsKIAlpbnQgKCpzbXVfaTJjX2J1c19hY2Nlc3MpKHN0cnVjdCBwcF9o
d21nciAqaHdtZ3IsIGJvb2wgYXF1aXJlKTsKIAlpbnQgKCpzZXRfZGZfY3N0YXRlKShzdHJ1Y3Qg
cHBfaHdtZ3IgKmh3bWdyLCBlbnVtIHBwX2RmX2NzdGF0ZSBzdGF0ZSk7CiAJaW50ICgqc2V0X3hn
bWlfcHN0YXRlKShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1aW50MzJfdCBwc3RhdGUpOworCWlu
dCAoKmRpc2FibGVfcG93ZXJfZmVhdHVyZXNfZm9yX2NvbXB1dGVfcGVyZm9ybWFuY2UpKHN0cnVj
dCBwcF9od21nciAqaHdtZ3IsCisJCQkJCWJvb2wgZGlzYWJsZSk7CiB9OwogCiBzdHJ1Y3QgcHBf
dGFibGVfZnVuYyB7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
