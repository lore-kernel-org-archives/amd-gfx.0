Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD25C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 15:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93F02053B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 15:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93F02053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1DBA6E093;
	Wed, 27 Nov 2019 15:20:00 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AC86E093
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 15:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIp1Zg3PdoyWxIQbCl9ALy33AqTPakoD7ngXrN9DUw5jxIjalGqutYa1d39bg+R/62Hm5Lnw9qdTC1gC35K74Sy/Z5UZu6tHKglC5DZDl1BDVA7Arxn8ELqcRBMpaxYfNmu11TTb1WJX98fu34VcGXBM2/G8GGklJ09mi36bpinsElcPiXzrzydlH5y1j88GxD2Cg9Q+TxTqjdFE5RMzSU71d0+z4bvRaFrBjywxlBSF5Lq4yc1oa41YT3YjCEODG6HqkmSPDnfRzYiRgRhexDWaQqP+pkTiPnHb2uivBROZnBaNbHTN/5dI1tZoBboEpK1U4FUpbRRisSDWNYgc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgB03kn1nth13B2prysUgkrFF0D7mDw8ABKd/hJlOqk=;
 b=PoDbsJUBlPWf+PlN5Anx2Mj5prasRWV1UX6deWfYfrJrMUNR0pC3NWU0KzMs3yxMfE2DQE4VuFyXG0chbPQApD6m4O9g2bnuPSSz8VLbqhpD/ZTgqGyhy5nuMW7BRY+erpbdNDnAYChseFyWfSqJwvfWq0/XuDetR/Mi5tKFEBm8CVWRjXscz1/eZcYoD0YK3YcCx86bdC+iwzfc9jbQSCiq+XjTlIwPQ2826V1ghc/2ZHAu20O30i84ahgD/jTHJEf6++ZDq4BfX78IJhQNwOfz3rODeupkJI1pfO6Jccr+3MLvbz0gpU2rYVRxAkfPX79ZKyWg0Q9bITpmpXTiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36)
 by CY4PR12MB1319.namprd12.prod.outlook.com (2603:10b6:903:41::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.22; Wed, 27 Nov
 2019 15:19:57 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by BN8PR12CA0023.outlook.office365.com
 (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.18 via Frontend
 Transport; Wed, 27 Nov 2019 15:19:57 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 15:19:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 09:19:56 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 09:19:55 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 09:19:54 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10 v2] drm/amdgpu: add concurrent baco reset support for
 XGMI
Date: Wed, 27 Nov 2019 23:19:51 +0800
Message-ID: <1574867991-30683-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(428003)(199004)(189003)(336012)(70206006)(8676002)(86362001)(2906002)(426003)(44832011)(8936002)(305945005)(48376002)(50226002)(47776003)(6916009)(81156014)(54906003)(70586007)(478600001)(50466002)(316002)(36756003)(4326008)(81166006)(51416003)(14444005)(2616005)(16586007)(186003)(2351001)(5660300002)(6666004)(356004)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1319; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23b4709d-59cc-40eb-b8d7-08d7734d4309
X-MS-TrafficTypeDiagnostic: CY4PR12MB1319:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1319A4F3C9448C44D8A6083FF6440@CY4PR12MB1319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: me3p/U2hIHne9L084OZfdfJO3XAT6itT2YCS9tbNdLXm1OH/p5kgCzMy0nNJQI8oxDDK/ZKY3gCQ1fISE8cNRPA/qCgcBAT8kMeyyWD8YaOZWfR+4213+V8+MCJLY1B7mSWzuajKQIx2IYY0GQW2k1YsfHXAtz82D/J3sKvr4Ye7zDGdWu7CrrdLWxSMaTzRez7JDPOUshK6dKUnbRT7K1erHDuVfDV0MrgSXpYdIOiVpRpciPrF1iH/LjxcPP2UrkbwvCdZHG2PntZTiJz+6o996JN1vs7ZSNX8ptEbaEIQKDiWQE0afDVdSPvC1PcUpyF7mM10942xa0ETLVY7s8jc0kbXehQ3sNAV6KV1qsRY73+KNvPjy0kwQUokGRFjhsHplqVeiU2oq9ecQw/Uk4Pad+fDUtdZ6ZOIpk5GAffEKZ0vKZ1zgPcMRJ1e5gXj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 15:19:56.8980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b4709d-59cc-40eb-b8d7-08d7734d4309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1319
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgB03kn1nth13B2prysUgkrFF0D7mDw8ABKd/hJlOqk=;
 b=T8l3SLj1ETuBVQvgpzC2fAgcTrT6Tn1tETskcfA38DYYTPkMGm2EKZIIYlPuZ3kBqwrSiJafgxz2jJMpVPgB7AH5YcCUa7/jFVOm7szZSLgHN+kI9KuWkjr7R9FFJxsic4DsfS6h2iyGe85PeMEQ61WUtaIcgkc4mGUHcTmKt6g=
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
Cc: alexander.deucher@amd.com, Le Ma <le.ma@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127151951.4XVQtxLmrafclcx3J8xc0R3s_dXbTbHwVhsilNSKYnY@z>

Q3VycmVudGx5IGVhY2ggWEdNSSBub2RlIHJlc2V0IHdxIGRvZXMgbm90IHJ1biBpbiBwYXJyYWxs
ZWwgYmVjYXVzZSBzYW1lIHdvcmsKaXRlbSBib3VuZCB0byBzYW1lIGNwdSBydW5zIGluIHNlcXVl
bmNlLiBTbyBjaGFuZ2UgdG8gYm91bmQgdGhlIHhnbWlfcmVzZXRfd29yawppdGVtIHRvIGRpZmZl
cmVudCBjcHVzLgoKWEdNSSByZXF1aXJlcyBhbGwgbm9kZXMgZW50ZXIgaW50byBiYWNvIHdpdGhp
biB2ZXJ5IGNsb3NlIHByb3hpbWl0eSBiZWZvcmUKYW55IG5vZGUgZXhpdCBiYWNvLiBTbyBzY2hl
ZHVsZSB0aGUgeGdtaV9yZXNldF93b3JrIHdxIHR3aWNlIGZvciBlbnRlci9leGl0CmJhY28gcmVz
cGVjdGl2ZWx5LgoKVG8gdXNlIGJhY28gZm9yIFhHTUksIFBNRlcgc3VwcG9ydGVkIGZvciBiYWNv
IG9uIFhHTUkgbmVlZHMgdG8gYmUgaW52b2x2ZWQuCgpUaGUgY2FzZSB0aGF0IFBTUCByZXNldCBh
bmQgYmFjbyByZXNldCBjb2V4aXN0IHdpdGhpbiBhbiBYR01JIGhpdmUgbmV2ZXIgZXhpc3QKYW5k
IGlzIG5vdCBpbiB0aGUgY29uc2lkZXJhdGlvbi4KCnYyOiBkZWZpbmUgdXNlX2JhY28gZmxhZyB0
byBzaW1wbGlmeSB0aGUgY29kZSBmb3IgeGdtaSBiYWNvIHNlcXVlbmNlCgpDaGFuZ2UtSWQ6IEk5
YzA4Y2Y5MDEzNGY5NDBiNDJlMjBkMjEyOWZmODdmYmE3NjFjNTMyClNpZ25lZC1vZmYtYnk6IExl
IE1hIDxsZS5tYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oICAgICAgICB8ICAyICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8IDgyICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQogMiBmaWxlcyBjaGFuZ2Vk
LCA3MiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oCmluZGV4IGQxMjBmZTUuLjA4OTI5ZTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oCkBAIC05OTgsNiArOTk4LDggQEAgc3RydWN0IGFtZGdwdV9kZXZpY2UgewogCWlu
dAkJCQlwc3RhdGU7CiAJLyogZW5hYmxlIHJ1bnRpbWUgcG0gb24gdGhlIGRldmljZSAqLwogCWJv
b2wgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnVucG07CisKKwlib29sCQkJCWluX2JhY287
CiB9OwogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZGV2aWNlICphbWRncHVfdHRtX2Fk
ZXYoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKaW5kZXggYmQzODdiYi4uNTM2NzEzNCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjY1NCw3ICsyNjU0LDEzIEBAIHN0
YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfeGdtaV9yZXNldF9mdW5jKHN0cnVjdCB3b3JrX3N0cnVj
dCAqX193b3JrKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0KIAkJY29udGFpbmVyX29m
KF9fd29yaywgc3RydWN0IGFtZGdwdV9kZXZpY2UsIHhnbWlfcmVzZXRfd29yayk7CiAKLQlhZGV2
LT5hc2ljX3Jlc2V0X3JlcyA9ICBhbWRncHVfYXNpY19yZXNldChhZGV2KTsKKwlpZiAoYW1kZ3B1
X2FzaWNfcmVzZXRfbWV0aG9kKGFkZXYpID09IEFNRF9SRVNFVF9NRVRIT0RfQkFDTykKKwkJYWRl
di0+YXNpY19yZXNldF9yZXMgPSAoYWRldi0+aW5fYmFjbyA9PSBmYWxzZSkgPworCQkJCWFtZGdw
dV9kZXZpY2VfYmFjb19lbnRlcihhZGV2LT5kZGV2KSA6CisJCQkJYW1kZ3B1X2RldmljZV9iYWNv
X2V4aXQoYWRldi0+ZGRldik7CisJZWxzZQorCQlhZGV2LT5hc2ljX3Jlc2V0X3JlcyA9IGFtZGdw
dV9hc2ljX3Jlc2V0KGFkZXYpOworCiAJaWYgKGFkZXYtPmFzaWNfcmVzZXRfcmVzKQogCQlEUk1f
V0FSTigiQVNJQyByZXNldCBmYWlsZWQgd2l0aCBlcnJvciwgJWQgZm9yIGRybSBkZXYsICVzIiwK
IAkJCSBhZGV2LT5hc2ljX3Jlc2V0X3JlcywgYWRldi0+ZGRldi0+dW5pcXVlKTsKQEAgLTM3ODks
MTMgKzM3OTUsMTggQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX3ByZV9hc2ljX3Jlc2V0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXJldHVybiByOwogfQogCi1zdGF0aWMgaW50IGFt
ZGdwdV9kb19hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlLAorc3RhdGlj
IGludCBhbWRncHVfZG9fYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJ
CSAgICAgICBzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSwKIAkJCSAgICAgICBzdHJ1Y3Qg
bGlzdF9oZWFkICpkZXZpY2VfbGlzdF9oYW5kbGUsCiAJCQkgICAgICAgYm9vbCAqbmVlZF9mdWxs
X3Jlc2V0X2FyZykKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqdG1wX2FkZXYgPSBOVUxMOwog
CWJvb2wgbmVlZF9mdWxsX3Jlc2V0ID0gKm5lZWRfZnVsbF9yZXNldF9hcmcsIHZyYW1fbG9zdCA9
IGZhbHNlOwogCWludCByID0gMDsKKwlpbnQgY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOworCWJv
b2wgdXNlX2JhY28gPQorCQkoYW1kZ3B1X2FzaWNfcmVzZXRfbWV0aG9kKGFkZXYpID09IEFNRF9S
RVNFVF9NRVRIT0RfQkFDTykgPworCQl0cnVlIDogZmFsc2U7CiAKIAkvKgogCSAqIEFTSUMgcmVz
ZXQgaGFzIHRvIGJlIGRvbmUgb24gYWxsIEhHTUkgaGl2ZSBub2RlcyBBU0FQCkBAIC0zODAzLDIx
ICszODE0LDI0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RvX2FzaWNfcmVzZXQoc3RydWN0IGFtZGdw
dV9oaXZlX2luZm8gKmhpdmUsCiAJICovCiAJaWYgKG5lZWRfZnVsbF9yZXNldCkgewogCQlsaXN0
X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsIGdtYy54Z21pLmhl
YWQpIHsKLQkJCS8qIEZvciBYR01JIHJ1biBhbGwgcmVzZXRzIGluIHBhcmFsbGVsIHRvIHNwZWVk
IHVwIHRoZSBwcm9jZXNzICovCisJCQkvKgorCQkJICogRm9yIFhHTUkgcnVuIGFsbCByZXNldHMg
aW4gcGFyYWxsZWwgdG8gc3BlZWQgdXAgdGhlCisJCQkgKiBwcm9jZXNzIGJ5IHNjaGVkdWxpbmcg
dGhlIGhpZ2hwcmkgd3Egb24gZGlmZmVyZW50CisJCQkgKiBjcHVzLiBGb3IgWEdNSSB3aXRoIGJh
Y28gcmVzZXQsIGFsbCBub2RlcyBtdXN0IGVudGVyCisJCQkgKiBiYWNvIHdpdGhpbiBjbG9zZSBw
cm94aW1pdHkgYmVmb3JlIGFueW9uZSBleGl0LgorCQkJICovCiAJCQlpZiAodG1wX2FkZXYtPmdt
Yy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsKLQkJCQlpZiAoIXF1ZXVlX3dvcmsoc3lz
dGVtX2hpZ2hwcmlfd3EsICZ0bXBfYWRldi0+eGdtaV9yZXNldF93b3JrKSkKKwkJCQlpZiAoIXF1
ZXVlX3dvcmtfb24oY3B1LCBzeXN0ZW1faGlnaHByaV93cSwKKwkJCQkJCSAgICZ0bXBfYWRldi0+
eGdtaV9yZXNldF93b3JrKSkKIAkJCQkJciA9IC1FQUxSRUFEWTsKKwkJCQljcHUgPSBjcHVtYXNr
X25leHQoY3B1LCBjcHVfb25saW5lX21hc2spOwogCQkJfSBlbHNlCiAJCQkJciA9IGFtZGdwdV9h
c2ljX3Jlc2V0KHRtcF9hZGV2KTsKLQotCQkJaWYgKHIpIHsKLQkJCQlEUk1fRVJST1IoIkFTSUMg
cmVzZXQgZmFpbGVkIHdpdGggZXJyb3IsICVkIGZvciBkcm0gZGV2LCAlcyIsCi0JCQkJCSByLCB0
bXBfYWRldi0+ZGRldi0+dW5pcXVlKTsKKwkJCWlmIChyKQogCQkJCWJyZWFrOwotCQkJfQogCQl9
CiAKLQkJLyogRm9yIFhHTUkgd2FpdCBmb3IgYWxsIFBTUCByZXNldHMgdG8gY29tcGxldGUgYmVm
b3JlIHByb2NlZWQgKi8KKwkJLyogRm9yIFhHTUkgd2FpdCBmb3IgYWxsIHdvcmsgdG8gY29tcGxl
dGUgYmVmb3JlIHByb2NlZWQgKi8KIAkJaWYgKCFyKSB7CiAJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5
KHRtcF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsCiAJCQkJCSAgICBnbWMueGdtaS5oZWFkKSB7
CkBAIC0zODI2LDExICszODQwLDU0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RvX2FzaWNfcmVzZXQo
c3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUsCiAJCQkJCXIgPSB0bXBfYWRldi0+YXNpY19y
ZXNldF9yZXM7CiAJCQkJCWlmIChyKQogCQkJCQkJYnJlYWs7CisJCQkJCWlmICh1c2VfYmFjbykK
KwkJCQkJCXRtcF9hZGV2LT5pbl9iYWNvID0gdHJ1ZTsKIAkJCQl9CiAJCQl9CiAJCX0KLQl9CiAK
KwkJLyoKKwkJICogRm9yIFhHTUkgd2l0aCBiYWNvIHJlc2V0LCBuZWVkIGV4aXQgYmFjbyBwaGFz
ZSBieSBzY2hlZHVsaW5nCisJCSAqIHhnbWlfcmVzZXRfd29yayBvbmUgbW9yZSB0aW1lLiBQU1Ag
cmVzZXQgYW5kIHNHUFUgc2tpcHMgdGhpcworCQkgKiBwaGFzZS4gTm90IGFzc3VtZSB0aGUgc2l0
dWF0aW9uIHRoYXQgUFNQIHJlc2V0IGFuZCBiYWNvIHJlc2V0CisJCSAqIGNvZXhpc3Qgd2l0aGlu
IGFuIFhHTUkgaGl2ZS4KKwkJICovCisKKwkJaWYgKCFyICYmIHVzZV9iYWNvKSB7CisJCQljcHUg
PSBzbXBfcHJvY2Vzc29yX2lkKCk7CisJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBk
ZXZpY2VfbGlzdF9oYW5kbGUsCisJCQkJCSAgICBnbWMueGdtaS5oZWFkKSB7CisJCQkJaWYgKHRt
cF9hZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7CisJCQkJCWlmICghcXVl
dWVfd29ya19vbihjcHUsCisJCQkJCQlzeXN0ZW1faGlnaHByaV93cSwKKwkJCQkJCSZ0bXBfYWRl
di0+eGdtaV9yZXNldF93b3JrKSkKKwkJCQkJCXIgPSAtRUFMUkVBRFk7CisJCQkJCWlmIChyKQor
CQkJCQkJYnJlYWs7CisJCQkJCWNwdSA9IGNwdW1hc2tfbmV4dChjcHUsIGNwdV9vbmxpbmVfbWFz
ayk7CisJCQkJfQorCQkJfQorCQl9CisKKwkJaWYgKCFyICYmIHVzZV9iYWNvKSB7CisJCQlsaXN0
X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsCisJCQkJCSAgICBn
bWMueGdtaS5oZWFkKSB7CisJCQkJaWYgKHRtcF9hZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxf
bm9kZXMgPiAxKSB7CisJCQkJCWZsdXNoX3dvcmsoJnRtcF9hZGV2LT54Z21pX3Jlc2V0X3dvcmsp
OworCQkJCQlyID0gdG1wX2FkZXYtPmFzaWNfcmVzZXRfcmVzOworCQkJCQlpZiAocikKKwkJCQkJ
CWJyZWFrOworCQkJCQl0bXBfYWRldi0+aW5fYmFjbyA9IGZhbHNlOworCQkJCX0KKwkJCX0KKwkJ
fQorCisJCWlmIChyKSB7CisJCQlEUk1fRVJST1IoIkFTSUMgcmVzZXQgZmFpbGVkIHdpdGggZXJy
b3IsICVkIGZvciBkcm0gZGV2LCAlcyIsCisJCQkJIHIsIHRtcF9hZGV2LT5kZGV2LT51bmlxdWUp
OworCQkJZ290byBlbmQ7CisJCX0KKwl9CiAKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2
LCBkZXZpY2VfbGlzdF9oYW5kbGUsIGdtYy54Z21pLmhlYWQpIHsKIAkJaWYgKG5lZWRfZnVsbF9y
ZXNldCkgewpAQCAtNDExNSw3ICs0MTcyLDggQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292
ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCWlmIChyKQogCQkJYWRldi0+YXNpY19y
ZXNldF9yZXMgPSByOwogCX0gZWxzZSB7Ci0JCXIgID0gYW1kZ3B1X2RvX2FzaWNfcmVzZXQoaGl2
ZSwgZGV2aWNlX2xpc3RfaGFuZGxlLCAmbmVlZF9mdWxsX3Jlc2V0KTsKKwkJciAgPSBhbWRncHVf
ZG9fYXNpY19yZXNldChhZGV2LCBoaXZlLCBkZXZpY2VfbGlzdF9oYW5kbGUsCisJCQkJCSAgJm5l
ZWRfZnVsbF9yZXNldCk7CiAJCWlmIChyICYmIHIgPT0gLUVBR0FJTikKIAkJCWdvdG8gcmV0cnk7
CiAJfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
