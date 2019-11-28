Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69497C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 16:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAF521774
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 16:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAF521774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3EF36E85E;
	Thu, 28 Nov 2019 16:33:26 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790051.outbound.protection.outlook.com [40.107.79.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085FC6E85E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 16:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhzdaB5QHvlF7SchDzqITPlKNj6npiLSMywhlC+OloSyfeLeR9Nrr93oFeviy6/HJUvKhRNOZnTcew9CjzNW6pk23a//z+PQyLcOGUKzUEZ8CpMyYwqNgVPinhtoMIPVnHKAyCkY+KJRgFvVyw/ZEW/qjzmESB+0dfbvI/X6N9F1lTVv3z1eiqA17OrK47mb0f6krXfMd6ZFR9MawTJ6phZ5Rx27Ap7CxYSfOADRDt63jhsw1zqhYWzO5ojHUESVmApnHx76DaRHeEdxEWkcYmgZPb7aTXEbLXOHdMqYXRAQa+McDPuopUyg0Ml8xQK3pwdnVMzqZ31DhCrX4SpplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmn1kAISCri8WetHZaST/iDJprp26i705ncllNee0AY=;
 b=FNsJpAnQWLzrVMpQTL6kwoCmLemJVIZeT08z35T/3KQ/CEy3im6ks34Ud+gMtxlntRn6GAubC95sRynvkaHmR2HJC9+RxHEtGLN2zW5xHlsAPcmAzljPLZQnvuQJQPqTKHBzns4tgkGcu0XYlZYcKzAhLwvCG9Zj5HHx6hBey4oJSUxoHungaZ8z5fXiS5n9D1AxOQy9ZUOGoG5wONFevLQOQcJSUArrqEtvceIZ2C4sOmZU8tPVRHOkAQWEIabfYZISTSfDsk/wyf+UI/3gDi1H1hc9NEuJoU9FVg/+gU3yX3RSFVxJidKQK+JBGD70JA20uELz8hEd+mhVBq72pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 MWHPR12MB1536.namprd12.prod.outlook.com (2603:10b6:301:6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 16:33:23 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.18 via Frontend
 Transport; Thu, 28 Nov 2019 16:33:23 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Thu, 28 Nov 2019 16:33:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 28 Nov
 2019 10:33:22 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 28 Nov
 2019 10:33:22 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 28 Nov 2019 10:33:22 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Drop AMD_EDID_UTILITY defines
Date: Thu, 28 Nov 2019 11:33:20 -0500
Message-ID: <20191128163320.20092-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(428003)(199004)(189003)(70206006)(6916009)(47776003)(26005)(305945005)(86362001)(70586007)(50466002)(1076003)(51416003)(2351001)(48376002)(36756003)(478600001)(8936002)(316002)(5660300002)(2870700001)(186003)(4326008)(50226002)(2616005)(2906002)(426003)(356004)(8676002)(81166006)(44832011)(81156014)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1536; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16e137bd-f834-48c3-fee7-08d77420afd4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1536:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1536872596BF1FFE02F744938C470@MWHPR12MB1536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0235CBE7D0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J370gEDgmX9Am849gaiskNCllT2nQSKjD6Fk+OPnM2otqFNFeBIB/4Fzf4K+xl1SAJFZB4hdDsap7KrCvV203WLYQarmSfwpLMhDfsFDI2q6uQ4kKbMMoQYMtCPhIqoE84/HpN30nCg76mx2uxfy779RQA+/ocLJLnSesKB/4iUYig7Cxm8cCu9twee9jl5Rx6bRWQo/Z7QyCMSp7zUOlfbXpEgYavEDqDllACGmgkVg2U0SjLqObSn4Fuy8eQYpY7uKmCicpSaKuegauq1ttNn+ri/nm7gfl8EukdNxFkYaFiA/5iQjQgS5sMt0RMdXi+fFWDHyZ3Wm7ms0+nQfSIqNcVVW8TP99fcLlqg4RKJ/kWJ6ehdU2AXijl8jjFgfVhE8ByeM+jwdlO022v115Rhq5UfspOqo76Tgh+qLigpTHPl2heEHEF+Y3aPMLNPv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 16:33:23.3113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e137bd-f834-48c3-fee7-08d77420afd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1536
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmn1kAISCri8WetHZaST/iDJprp26i705ncllNee0AY=;
 b=Kq9YLJOWhi5XP8/Nn2a/X2Q1b3nNxU9ajtom9JmhPQ8/SFXrZJeauj7qZUrvaULv3mG7+ULRBj6CGV31SuHKr6m4PRXSNUmf2oRXedGXSm5aL1LBNd6FhrhxxXoT1bEXgQ8HP8cQe9ZKrZ2npfkPEZ51K1f52cwBTcox4HxE0HA=
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
Cc: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128163320.fKD4YfjBw4xOegAOaLS7z063d0wEiTdZCufQWTZUibk@z>

V2UgZG9uJ3QgdXNlIHRoaXMgdXBzdHJlYW0gaW4gdGhlIExpbnV4IGtlcm5lbC4KClNpZ25lZC1v
ZmYtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19kc2MuaCAgICAgIHwgMiAtLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2h3X3R5cGVzLmggfCA4IC0tLS0tLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaCAgICB8IDQgLS0tLQogMyBmaWxlcyBj
aGFuZ2VkLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNfZHNjLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNf
ZHNjLmgKaW5kZXggYTc4MmFlMThhMWM1Li5jYzk5MTVlNTQ1Y2QgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19kc2MuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNfZHNjLmgKQEAgLTQxLDEwICs0MSw4IEBAIHN0cnVjdCBkY19kc2Nf
YndfcmFuZ2UgewogCiBzdHJ1Y3QgZGlzcGxheV9zdHJlYW1fY29tcHJlc3NvciB7CiAJY29uc3Qg
c3RydWN0IGRzY19mdW5jcyAqZnVuY3M7Ci0jaWZuZGVmIEFNRF9FRElEX1VUSUxJVFkKIAlzdHJ1
Y3QgZGNfY29udGV4dCAqY3R4OwogCWludCBpbnN0OwotI2VuZGlmCiB9OwogCiBib29sIGRjX2Rz
Y19wYXJzZV9kc2NfZHBjZChjb25zdCB1aW50OF90ICpkcGNkX2RzY19iYXNpY19kYXRhLApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2h3X3R5cGVzLmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfaHdfdHlwZXMuaAppbmRleCA4NjA0M2Q0
MzFkNDAuLjI1YzUwYmNhYjllOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjX2h3X3R5cGVzLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjX2h3X3R5cGVzLmgKQEAgLTI2LDggKzI2LDYgQEAKICNpZm5kZWYgRENfSFdfVFlQRVNfSAog
I2RlZmluZSBEQ19IV19UWVBFU19ICiAKLSNpZm5kZWYgQU1EX0VESURfVVRJTElUWQotCiAjaW5j
bHVkZSAib3NfdHlwZXMuaCIKICNpbmNsdWRlICJmaXhlZDMxXzMyLmgiCiAjaW5jbHVkZSAic2ln
bmFsX3R5cGVzLmgiCkBAIC01ODQsOCArNTgyLDYgQEAgc3RydWN0IHNjYWxpbmdfdGFwcyB7CiAJ
Ym9vbCBpbnRlZ2VyX3NjYWxpbmc7CiB9OwogCi0jZW5kaWYgLyogQU1EX0VESURfVVRJTElUWSAq
LwotCiBlbnVtIGRjX3RpbWluZ19zdGFuZGFyZCB7CiAJRENfVElNSU5HX1NUQU5EQVJEX1VOREVG
SU5FRCwKIAlEQ19USU1JTkdfU1RBTkRBUkRfRE1ULApAQCAtNzQyLDggKzczOCw2IEBAIHN0cnVj
dCBkY19jcnRjX3RpbWluZyB7CiAJc3RydWN0IGRjX2RzY19jb25maWcgZHNjX2NmZzsKIH07CiAK
LSNpZm5kZWYgQU1EX0VESURfVVRJTElUWQotCiBlbnVtIHRyaWdnZXJfZGVsYXkgewogCVRSSUdH
RVJfREVMQVlfTkVYVF9QSVhFTCA9IDAsCiAJVFJJR0dFUl9ERUxBWV9ORVhUX0xJTkUsCkBAIC04
MzcsNyArODMxLDUgQEAgc3RydWN0IHRnX2NvbG9yIHsKIAl1aW50MTZfdCBjb2xvcl9iX2NiOwog
fTsKIAotI2VuZGlmIC8qIEFNRF9FRElEX1VUSUxJVFkgKi8KLQogI2VuZGlmIC8qIERDX0hXX1RZ
UEVTX0ggKi8KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
X3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaAppbmRl
eCAxMzYzZTg5MDdmYmYuLjJiOTJiZmEyOGJkZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVzLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjX3R5cGVzLmgKQEAgLTI1LDcgKzI1LDYgQEAKICNpZm5kZWYgRENfVFlQRVNfSF8K
ICNkZWZpbmUgRENfVFlQRVNfSF8KIAotI2lmbmRlZiBBTURfRURJRF9VVElMSVRZCiAvKiBBTkQg
RWRpZFV0aWxpdHkgb25seSBuZWVkcyBhIHBvcnRpb24KICAqIG9mIHRoaXMgZmlsZSwgaW5jbHVk
aW5nIHRoZSByZXN0IG9ubHkKICAqIGNhdXNlcyBhZGRpdGlvbmFsIGlzc3Vlcy4KQEAgLTc4MSw5
ICs3ODAsNiBAQCBzdHJ1Y3QgZGNfY2xvY2tfY29uZmlnIHsKIAl1aW50MzJfdCBjdXJyZW50X2Ns
b2NrX2toejsvKmN1cnJlbnQgY2xvY2sgaW4gdXNlKi8KIH07CiAKLSNlbmRpZiAvKkFNRF9FRElE
X1VUSUxJVFkqLwotLy9BTUQgRURJRCBVVElMSVRZIGRvZXMgbm90IG5lZWQgYW55IG9mIHRoZSBh
Ym92ZSBzdHJ1Y3R1cmVzCi0KIC8qIERTQyBEUENEIGNhcGFiaWxpdGllcyAqLwogdW5pb24gZHNj
X3NsaWNlX2NhcHMxIHsKIAlzdHJ1Y3QgewotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
