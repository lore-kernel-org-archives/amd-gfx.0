Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90803CA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7008220873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7008220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3126EEB2;
	Thu, 31 Oct 2019 14:42:43 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790055.outbound.protection.outlook.com [40.107.79.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE07C6EEAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjGNtT+JjSg+vp1WGEa5dScb//89bHpHpEYIwG4/z9tJ9ls/NtwFkJ02AuKO+d3JyGI0b2KIIRKOPd0mxFNLsN6AjxXASC2AwBQDjqu0fBCZA/WzxT4/PoHD+aqVVpFOq+Fo1ojwwHdHWU8jswklVlI6YO9ZrSAB+0bWr24tsNKFCpDaZDw4PnDXK+Elk5F0X92zKYLPYrbmaVClaV9yyznZ9MlrB3tysv9yXzq2PXLdkvR3GFjJKN+rCC32pQ8916Pg7A+AjBV8Kjo03sjfyX4qG6QF5R7oe4gj+UKSJq1XzerUQd4M2wGRC3k3iFS+9gbelGwVRuW2yfF0Qdx1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96sjvAF7pFSyOW8690vwYwp42aNUpnIJKvXlNIbstOc=;
 b=QufUEVos7NUlm8UHZSa6v+xxw57iDxsZ4hdOhehUaMZCfBEjfHHrS3j8UQqD43j3UK5D8T1Cy4BjpGjYJDFz96V5eHwIuxcNvfqAP+mtnXJ2nh2oU/BHsbqSehP5nEyVeVfvReRwtcUn4V7lkv2m3VXkDppem6nARl4SF0U3PJhw19wm1AQyJ+TjJJ6qxDgnGZmfXyOjQ/NUrKaXjTk6Tv5xtoBV6KJlt2ZSCrQ5COBrj7Cm4oFihM/k9jhOD+yzPAMYMdcXIrGUomrdKraDbfsYvS1eTHV0TbozSZJf7zNVpqFqmSmtUaA78duyi3odSIAP/JsvE0Y3eBP8nyJ5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0053.namprd12.prod.outlook.com (2603:10b6:300:103::15)
 by BN7PR12MB2595.namprd12.prod.outlook.com (2603:10b6:408:30::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Thu, 31 Oct
 2019 14:42:33 +0000
Received: from DM3NAM03FT043.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by MWHPR12CA0053.outlook.office365.com
 (2603:10b6:300:103::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.20 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:32 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT043.mail.protection.outlook.com (10.152.83.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:32 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:30 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:30 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/20] drm/amd/display: Add a sanity check for DSC already
 enabled/disabled
Date: Thu, 31 Oct 2019 10:41:56 -0400
Message-ID: <20191031144210.24011-7-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(428003)(189003)(199004)(476003)(426003)(126002)(446003)(2616005)(186003)(11346002)(478600001)(26005)(336012)(356004)(6666004)(4326008)(486006)(14444005)(2351001)(86362001)(47776003)(1076003)(36756003)(5660300002)(70206006)(70586007)(51416003)(6916009)(76176011)(7696005)(305945005)(16586007)(53416004)(8676002)(81166006)(50466002)(8936002)(48376002)(316002)(2906002)(50226002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2595; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4da7e23d-fa41-4482-5421-08d75e109004
X-MS-TrafficTypeDiagnostic: BN7PR12MB2595:
X-Microsoft-Antispam-PRVS: <BN7PR12MB25954FD05BE23DB54EB5001EF9630@BN7PR12MB2595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnON9MAEoXgkCqv53oQs1OFMCBak+c71IH7AVmqvtdU/fv7MYsjZoCCrRP6nLv+FO8ClFRgyjgkIc2DbkuQK6Z6CMuZTtmzK/rFAkJyAdmflOmCxEouKt+svnhkJut7qzEhtdhrSAnAEU0J4YDlAqlV/Ebq3SPhxF9FzTgwuxIdKiCM+3mxm4XzyF+jyIL4s4dJS/ce4K+2vRuK448NncqNjv5AQv4woBcFXGarrYvJ/s9HwLbU0E/5LHcnj7WEY7GvmB/WXnJpZ0AMv7VDQZu6WwkMogOZVU+2ubQKDVzs8xW22eKucGGL/q3uzHVIcRl6wOZn5Ty2sEWw7xAkfrYmd+JpnygkPnO/OZdCivrfJP7W2+pYXLhUbN9htOmfEc0OYaXqIyuV/r5Nc9xUW+FDAn9fgCC7926bh9jk6xpTx3tqTom8/H3mBjWZjMfIJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:32.3984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da7e23d-fa41-4482-5421-08d75e109004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2595
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96sjvAF7pFSyOW8690vwYwp42aNUpnIJKvXlNIbstOc=;
 b=G5tJVn1RYikBmlo2jtyip6mXrvU2yufrnLUE8e0PMgCXvj+Vx0heT4UB+zvKOx8ELXUgKQJJkQnBaAHmLh6NkF1zGZVXmtE20hAtgalc0Wjryl9X8+OCOs1N+QkF5Ex3+VzZr1W503xwMSHWj1vru2o1iSnvILjWeZv5RqtG5dw=
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
Cc: Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144156.7TAXhqt9BMZShqs3Eaa1r3_n1NzZOW9wVOxQxmFR3tk@z>

RnJvbTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgoKW3doeV0KSWYgYWNx
dWlyZS9yZWxlYXNlIERTQyByZXNvdXJjZSBzZXF1ZW5jZSBpcyBhZmZlY3RlZCBieSBhIHJlZ3Jl
c3Npb24sCml0IGNhbiBoYXBwZW4gdGhhdCB0aGUgYWxyZWFkeS1pbi11c2UgRFNDIEhXIGJsb2Nr
IGlzIGJlaW5nIHdyb25nbHkKcmUtdXNlZCBmb3IgYSBkaWZmZXJlbnQgcGlwZS4gVGhlIHJldmVy
c2UgaXMgYWxzbyBwb3NzaWJsZSwgaS5lLgphbHJlYWR5LWRpc2FibGVkIERTQyBIVyBibG9jayBj
b3VsZCBiZSBkaXNhYmxlZCBmcm9tIG90aGVyIGNvbnRleHQuCgpbaG93XQpSZWFkIGJhY2sgdGhl
IGVuYWJsZSBzdGF0ZSBvZiBEU0MgSFcgYW5kIHJlcG9ydCBhbiBlcnJvciBpZiBkdXBsaWNhdGUK
ZW5hYmxlIG9yIGRpc2FibGUgd2FzIGF0dGVtcHRlZC4KClNpZ25lZC1vZmYtYnk6IE5pa29sYSBD
b3JuaWogPG5pa29sYS5jb3JuaWpAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERteXRybyBMYWt0eXVz
aGtpbiA8RG15dHJvLkxha3R5dXNoa2luQGFtZC5jb20+CkFja2VkLWJ5OiBCaGF3YW5wcmVldCBM
YWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KLS0tCiAuLi4vZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24yMC9kY24yMF9kc2MuYyAgfCAyNSArKysrKysrKysrKysrKysrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfZHNjLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfZHNjLmMKaW5kZXggNjNlYjM3
N2VkOWMwLi5kYzk5NDQ0MjdkMmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24yMC9kY24yMF9kc2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMjAvZGNuMjBfZHNjLmMKQEAgLTIyMiw5ICsyMjIsMTggQEAgc3RhdGljIGJvb2wg
ZHNjMl9nZXRfcGFja2VkX3BwcyhzdHJ1Y3QgZGlzcGxheV9zdHJlYW1fY29tcHJlc3NvciAqZHNj
LCBjb25zdCBzdHIKIHN0YXRpYyB2b2lkIGRzYzJfZW5hYmxlKHN0cnVjdCBkaXNwbGF5X3N0cmVh
bV9jb21wcmVzc29yICpkc2MsIGludCBvcHBfcGlwZSkKIHsKIAlzdHJ1Y3QgZGNuMjBfZHNjICpk
c2MyMCA9IFRPX0RDTjIwX0RTQyhkc2MpOworCWludCBkc2NfY2xvY2tfZW47CisJaW50IGRzY19m
d19jb25maWc7CisJaW50IGVuYWJsZWRfb3BwX3BpcGU7CiAKLQkvKiBUT0RPIENoZWNrIGlmIERT
QyBhbHJlYXkgaW4gdXNlPyAqLwotCURDX0xPR19EU0MoImVuYWJsZSBEU0MgYXQgb3BwIHBpcGUg
JWQiLCBvcHBfcGlwZSk7CisJRENfTE9HX0RTQygiZW5hYmxlIERTQyAlZCBhdCBvcHAgcGlwZSAl
ZCIsIGRzYy0+aW5zdCwgb3BwX3BpcGUpOworCisJUkVHX0dFVChEU0NfVE9QX0NPTlRST0wsIERT
Q19DTE9DS19FTiwgJmRzY19jbG9ja19lbik7CisJUkVHX0dFVF8yKERTQ1JNX0RTQ19GT1JXQVJE
X0NPTkZJRywgRFNDUk1fRFNDX0ZPUldBUkRfRU4sICZkc2NfZndfY29uZmlnLCBEU0NSTV9EU0Nf
T1BQX1BJUEVfU09VUkNFLCAmZW5hYmxlZF9vcHBfcGlwZSk7CisJaWYgKChkc2NfY2xvY2tfZW4g
fHwgZHNjX2Z3X2NvbmZpZykgJiYgZW5hYmxlZF9vcHBfcGlwZSAhPSBvcHBfcGlwZSkgeworCQlE
Q19MT0dfRFNDKCJFUlJPUjogRFNDICVkIGF0IG9wcCBwaXBlICVkIGFscmVhZHkgZW5hYmxlZCEi
LCBkc2MtPmluc3QsIGVuYWJsZWRfb3BwX3BpcGUpOworCQlBU1NFUlQoMCk7CisJfQogCiAJUkVH
X1VQREFURShEU0NfVE9QX0NPTlRST0wsCiAJCURTQ19DTE9DS19FTiwgMSk7CkBAIC0yMzgsOCAr
MjQ3LDE4IEBAIHN0YXRpYyB2b2lkIGRzYzJfZW5hYmxlKHN0cnVjdCBkaXNwbGF5X3N0cmVhbV9j
b21wcmVzc29yICpkc2MsIGludCBvcHBfcGlwZSkKIHN0YXRpYyB2b2lkIGRzYzJfZGlzYWJsZShz
dHJ1Y3QgZGlzcGxheV9zdHJlYW1fY29tcHJlc3NvciAqZHNjKQogewogCXN0cnVjdCBkY24yMF9k
c2MgKmRzYzIwID0gVE9fRENOMjBfRFNDKGRzYyk7CisJaW50IGRzY19jbG9ja19lbjsKKwlpbnQg
ZHNjX2Z3X2NvbmZpZzsKKwlpbnQgZW5hYmxlZF9vcHBfcGlwZTsKIAotCURDX0xPR19EU0MoImRp
c2FibGUgRFNDIik7CisJRENfTE9HX0RTQygiZGlzYWJsZSBEU0MgJWQiLCBkc2MtPmluc3QpOwor
CisJUkVHX0dFVChEU0NfVE9QX0NPTlRST0wsIERTQ19DTE9DS19FTiwgJmRzY19jbG9ja19lbik7
CisJUkVHX0dFVF8yKERTQ1JNX0RTQ19GT1JXQVJEX0NPTkZJRywgRFNDUk1fRFNDX0ZPUldBUkRf
RU4sICZkc2NfZndfY29uZmlnLCBEU0NSTV9EU0NfT1BQX1BJUEVfU09VUkNFLCAmZW5hYmxlZF9v
cHBfcGlwZSk7CisJaWYgKCFkc2NfY2xvY2tfZW4gfHwgIWRzY19md19jb25maWcpIHsKKwkJRENf
TE9HX0RTQygiRVJST1I6IERTQyAlZCBhdCBvcHAgcGlwZSAlZCBhbHJlYWR5IGRpc2FibGVkISIs
IGRzYy0+aW5zdCwgZW5hYmxlZF9vcHBfcGlwZSk7CisJCUFTU0VSVCgwKTsKKwl9CiAKIAlSRUdf
VVBEQVRFKERTQ1JNX0RTQ19GT1JXQVJEX0NPTkZJRywKIAkJRFNDUk1fRFNDX0ZPUldBUkRfRU4s
IDApOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
