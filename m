Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DB5C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 19:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1E361183
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 19:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1E361183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CAF6E117;
	Tue, 13 Jul 2021 19:18:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C40E6E117
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 19:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEb9G8jA/6ZEdC3Fv7TkqlgXIS0K97PjsKFAMYj7OtZWhE/H3g1dn4wj2++RYDgrN3+Gn6Q0OHtG+1yWzW49LXSpyni737e4ZQQylsr+Al/BC+R1jDkvvs9c+P7BqMANn//H1a9y6i+eMKVsDp477UJSICPP0GyTAbvj+px0WveN6DlCqCy4ogISNBilfXSSYNk8sl/uqP8T0BI3ADjvUocz8SjXZEEGHMWXojryfYk0g950I0EDtFONBnpYtaGyAg9Uwmbf6k2WS6oUREFGRmEKxWCP/UrJRbLd8AGTvYlo0lYPVMUbl3Gb/++ngY1CXjHOxhQVcpmC99isZPLBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQQzQl1uPsTcF0uw907ewiPeGhKz7eqR3oAnhssjk9w=;
 b=GdgUMbDAIfm7rVoD1j6M4W8BjSGKCaWwXI1X8g4FlcA9ktNSzxXeb9Tc8b0JEG/ae2YJ7sPBsjbPyzo3AA1q//SzU4jgv3c3e6XA/IvaWIHrddQ8smGaBxxT8uT7ADpchoKob7CPx18FcRHqlRc51dZs5Z2WEWBVC837+M5r6Ls0jXoS/9eZF3w1MsEUbENws3qzml9z5PBNNu7E3NdpDwLMXHaPy/qVioksF8GRuQR2q4jXNNQRfoRmw1p9poqi083h/ZTJMRzTvk9R+EbDydrtvrFtnAT9ZOHo9FsxfAmFwRSbU37+bUoF6Qo/wHU8xS10MR3VEJWC8cvoYKtggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQQzQl1uPsTcF0uw907ewiPeGhKz7eqR3oAnhssjk9w=;
 b=s6Vd4UWxIClbEDrEZkICkkJZVFJjg5Eq9Kfn0jpT0kjj0QYZz+f/5O3H4j/ZS77snjgRBYM4Z2jDZfiaXkHue6AiULwc4WnbVLpVptbwe/fhAvBEwAwRI3kwhcGht561b55iKN7TcKN3zQ+Fts8EgMfJUthXpIjAj7hg057cI+I=
Received: from DM5PR19CA0059.namprd19.prod.outlook.com (2603:10b6:3:116::21)
 by MWHPR12MB1486.namprd12.prod.outlook.com (2603:10b6:301:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 13 Jul
 2021 19:17:56 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::16) by DM5PR19CA0059.outlook.office365.com
 (2603:10b6:3:116::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 19:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 19:17:56 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 13 Jul 2021 14:17:54 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: further lower VRAM allocation overhead
Date: Tue, 13 Jul 2021 15:17:39 -0400
Message-ID: <20210713191739.458131-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 164ef3b2-ba41-42c6-e975-08d94632eb79
X-MS-TrafficTypeDiagnostic: MWHPR12MB1486:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1486B8A68E88189258C95E1D82149@MWHPR12MB1486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dE4Xf3UgCEYat2l7SuCja5Ku4PtYcXO2Pe9x9XVHdaKiqYVR99qSo9u+TDZTfKYMuT0owpvXV5IrbnjquxKAbkXvZO1DYzGxX7gUgh++QYydfInAcEe6eqWrS+KCsnXO3dD2NU8jWXWv0WVLqgeitKycU1AykVDvUGbq7eOfwi43+NrT7GzSRXrPzzsjczvCEo1ETRPdvyvG2OhHie4HdgHPGi22WwpdTdQFwve4gJ1hhBVUtbN6/DgdGD5gHckatFM45Iv4bII0ZNDlVP/wY/Avcihxvuc8X9tbHWfTJFyLnioASapbi8IBl97b55N8npAi5T+W2+eufT4CKG4Xpu1Xj7wn8ScdTppnhzQ5yFWnx2GQbSvfV0SxsgPJGpUwHq8OP/pLKfcl1eMWSj52c4eGjAPsBZgibzw1tQonziaeiHpxtmGFSM44flHUUnqsHa2+FIt84mZeUU4dTHbV1LAch94wYar72fdH3dL11SVLX6eBoXfpi9dCCvH4dxyg4dXNA2S0NIZIgJzoLbk8osqknK13OAQa38Bu/gvPwFJ/h7QaDshIwNxqpwcEvbjUkaFpu+BsI74ovfH4rqYR0U/ymC5b3uzaTCYTGZBmkKMcePu0QKOyd8a7WaKydm3nFiHeCUbTUdGaVbPMc7q5D+9/SBe6/JMz/G+9I4YUTr5/z46mROk4kgVf9rCMSE+yB4rmThT0jRAo9LJHf9wuqrpNKNyEBmeiaU14FuDJU98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(83380400001)(7696005)(66574015)(70206006)(426003)(70586007)(82310400003)(82740400003)(356005)(316002)(336012)(2616005)(47076005)(478600001)(36756003)(36860700001)(6666004)(54906003)(6916009)(186003)(4326008)(2906002)(16526019)(1076003)(26005)(8936002)(86362001)(81166007)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 19:17:56.1540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164ef3b2-ba41-42c6-e975-08d94632eb79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1486
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rm9yIGFsbG9jYXRpb25zIGxhcmdlciB0aGFuIDQ4TWlCIHdlIG5lZWQgbW9yZSB0aGFuIGEgcGFn
ZSBmb3IgdGhlCmhvdXNla2VlcGluZyBpbiB0aGUgd29yc3QgY2FzZSByZXN1bHRpbmcgaW4gdGhl
IHVzdWFsIHZtYWxsb2Mgb3ZlcmhlYWQuCgpUcnkgdG8gYXZvaWQgdGhpcyBieSBhc3N1bWluZyB0
aGUgZ29vZCBjYXNlIGFuZCBvbmx5IGZhbGxpbmcgYmFjayB0byB0aGUKd29yc3QgY2FzZSBpZiB0
aGlzIGRpZG4ndCB3b3JrZWQuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1aWVy
aWMuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFt
X21nci5jIHwgNzEgKysrKysrKysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNl
cnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92cmFtX21nci5jCmluZGV4IGJlNDI2MWM0NTEyZS4uZWNiZTA1ZTFkYjY2IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwpAQCAtMzYxLDkg
KzM2MSwxMSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdnJhbV9tZ3JfdmlydF9zdGFydChzdHJ1Y3Qg
dHRtX3Jlc291cmNlICptZW0sCiBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0
IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCiAJCQkgICAgICAgc3RydWN0IHR0bV9idWZmZXJf
b2JqZWN0ICp0Ym8sCiAJCQkgICAgICAgY29uc3Qgc3RydWN0IHR0bV9wbGFjZSAqcGxhY2UsCisJ
CQkgICAgICAgdW5zaWduZWQgbG9uZyBudW1fbm9kZXMsCisJCQkgICAgICAgdW5zaWduZWQgbG9u
ZyBwYWdlc19wZXJfbm9kZSwKIAkJCSAgICAgICBzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0pCiB7
Ci0JdW5zaWduZWQgbG9uZyBscGZuLCBudW1fbm9kZXMsIHBhZ2VzX3Blcl9ub2RlLCBwYWdlc19s
ZWZ0LCBwYWdlczsKKwl1bnNpZ25lZCBsb25nIGxwZm4sIHBhZ2VzX2xlZnQsIHBhZ2VzOwogCXN0
cnVjdCBhbWRncHVfdnJhbV9tZ3IgKm1nciA9IHRvX3ZyYW1fbWdyKG1hbik7CiAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSB0b19hbWRncHVfZGV2aWNlKG1ncik7CiAJdWludDY0X3Qgdmlz
X3VzYWdlID0gMCwgbWVtX2J5dGVzLCBtYXhfYnl0ZXM7CkBAIC0zOTMsMjEgKzM5NSw2IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIg
Km1hbiwKIAkJcmV0dXJuIC1FTk9TUEM7CiAJfQogCi0JaWYgKHBsYWNlLT5mbGFncyAmIFRUTV9Q
TF9GTEFHX0NPTlRJR1VPVVMpIHsKLQkJcGFnZXNfcGVyX25vZGUgPSB+MHVsOwotCQludW1fbm9k
ZXMgPSAxOwotCX0gZWxzZSB7Ci0jaWZkZWYgQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFCi0J
CXBhZ2VzX3Blcl9ub2RlID0gSFBBR0VfUE1EX05SOwotI2Vsc2UKLQkJLyogZGVmYXVsdCB0byAy
TUIgKi8KLQkJcGFnZXNfcGVyX25vZGUgPSAyVUwgPDwgKDIwVUwgLSBQQUdFX1NISUZUKTsKLSNl
bmRpZgotCQlwYWdlc19wZXJfbm9kZSA9IG1heF90KHVpbnQzMl90LCBwYWdlc19wZXJfbm9kZSwK
LQkJCQkgICAgICAgbWVtLT5wYWdlX2FsaWdubWVudCk7Ci0JCW51bV9ub2RlcyA9IERJVl9ST1VO
RF9VUChtZW0tPm51bV9wYWdlcywgcGFnZXNfcGVyX25vZGUpOwotCX0KLQogCW5vZGVzID0ga3Zt
YWxsb2NfYXJyYXkoKHVpbnQzMl90KW51bV9ub2Rlcywgc2l6ZW9mKCpub2RlcyksCiAJCQkgICAg
ICAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOwogCWlmICghbm9kZXMpIHsKQEAgLTQzNSw3ICs0
MjIsMTIgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVzb3Vy
Y2VfbWFuYWdlciAqbWFuLAogCWkgPSAwOwogCXNwaW5fbG9jaygmbWdyLT5sb2NrKTsKIAl3aGls
ZSAocGFnZXNfbGVmdCkgewotCQl1aW50MzJfdCBhbGlnbm1lbnQgPSBtZW0tPnBhZ2VfYWxpZ25t
ZW50OworCQl1bnNpZ25lZCBsb25nIGFsaWdubWVudCA9IG1lbS0+cGFnZV9hbGlnbm1lbnQ7CisK
KwkJaWYgKGkgPj0gbnVtX25vZGVzKSB7CisJCQlyID0gLUUyQklHOworCQkJZ290byBlcnJvcjsK
KwkJfQogCiAJCWlmIChwYWdlcyA+PSBwYWdlc19wZXJfbm9kZSkKIAkJCWFsaWdubWVudCA9IHBh
Z2VzX3Blcl9ub2RlOwpAQCAtNDkyLDYgKzQ4NCw0OSBAQCBzdGF0aWMgaW50IGFtZGdwdV92cmFt
X21ncl9uZXcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCiAJcmV0dXJuIHI7CiB9
CiAKKy8qKgorICogYW1kZ3B1X3ZyYW1fbWdyX2FsbG9jIC0gYWxsb2NhdGUgbmV3IHJhbmdlCisg
KgorICogQG1hbjogVFRNIG1lbW9yeSB0eXBlIG1hbmFnZXIKKyAqIEB0Ym86IFRUTSBCTyB3ZSBu
ZWVkIHRoaXMgcmFuZ2UgZm9yCisgKiBAcGxhY2U6IHBsYWNlbWVudCBmbGFncyBhbmQgcmVzdHJp
Y3Rpb25zCisgKiBAbWVtOiB0aGUgcmVzdWx0aW5nIG1lbSBvYmplY3QKKyAqCisgKiBBbGxvY2F0
ZSBWUkFNIGZvciB0aGUgZ2l2ZW4gQk8uCisgKi8KK3N0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdy
X2FsbG9jKHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuLAorCQkJCSBzdHJ1Y3QgdHRt
X2J1ZmZlcl9vYmplY3QgKnRibywKKwkJCQkgY29uc3Qgc3RydWN0IHR0bV9wbGFjZSAqcGxhY2Us
CisJCQkJIHN0cnVjdCB0dG1fcmVzb3VyY2UgKm1lbSkKK3sKKwl1bnNpZ25lZCBsb25nIG51bV9u
b2RlcywgcGFnZXNfcGVyX25vZGU7CisJaW50IHI7CisKKwlpZiAocGxhY2UtPmZsYWdzICYgVFRN
X1BMX0ZMQUdfQ09OVElHVU9VUykKKwkJcmV0dXJuIGFtZGdwdV92cmFtX21ncl9uZXcobWFuLCB0
Ym8sIHBsYWNlLCAxLCB+MHVsLCBtZW0pOworCisjaWZkZWYgQ09ORklHX1RSQU5TUEFSRU5UX0hV
R0VQQUdFCisJcGFnZXNfcGVyX25vZGUgPSBIUEFHRV9QTURfTlI7CisjZWxzZQorCS8qIGRlZmF1
bHQgdG8gMk1CICovCisJcGFnZXNfcGVyX25vZGUgPSAyVUwgPDwgKDIwVUwgLSBQQUdFX1NISUZU
KTsKKyNlbmRpZgorCXBhZ2VzX3Blcl9ub2RlID0gbWF4X3QodWludDMyX3QsIHBhZ2VzX3Blcl9u
b2RlLAorCQkJICAgICAgIG1lbS0+cGFnZV9hbGlnbm1lbnQpOworCW51bV9ub2RlcyA9IERJVl9S
T1VORF9VUChtZW0tPm51bV9wYWdlcywgcGFnZXNfcGVyX25vZGUpOworCisJaWYgKHNpemVvZihz
dHJ1Y3QgZHJtX21tX25vZGUpICogbnVtX25vZGVzID4gUEFHRV9TSVpFKSB7CisJCXIgPSBhbWRn
cHVfdnJhbV9tZ3JfbmV3KG1hbiwgdGJvLCBwbGFjZSwKKwkJCQlQQUdFX1NJWkUgLyBzaXplb2Yo
c3RydWN0IGRybV9tbV9ub2RlKSwKKwkJCQlwYWdlc19wZXJfbm9kZSwJbWVtKTsKKwkJaWYgKHIg
IT0gLUUyQklHKQorCQkJcmV0dXJuIHI7CisJfQorCisJcmV0dXJuIGFtZGdwdV92cmFtX21ncl9u
ZXcobWFuLCB0Ym8sIHBsYWNlLCBudW1fbm9kZXMsIHBhZ2VzX3Blcl9ub2RlLAorCQkJCSAgIG1l
bSk7Cit9CisKIC8qKgogICogYW1kZ3B1X3ZyYW1fbWdyX2RlbCAtIGZyZWUgcmFuZ2VzCiAgKgpA
QCAtNjkzLDcgKzcyOCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92cmFtX21ncl9kZWJ1ZyhzdHJ1
Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKIH0KIAogc3RhdGljIGNvbnN0IHN0cnVjdCB0
dG1fcmVzb3VyY2VfbWFuYWdlcl9mdW5jIGFtZGdwdV92cmFtX21ncl9mdW5jID0gewotCS5hbGxv
Ywk9IGFtZGdwdV92cmFtX21ncl9uZXcsCisJLmFsbG9jCT0gYW1kZ3B1X3ZyYW1fbWdyX2FsbG9j
LAogCS5mcmVlCT0gYW1kZ3B1X3ZyYW1fbWdyX2RlbCwKIAkuZGVidWcJPSBhbWRncHVfdnJhbV9t
Z3JfZGVidWcKIH07Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
