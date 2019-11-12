Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E3BC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D6A2196E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D6A2196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A1B6EA26;
	Tue, 12 Nov 2019 00:33:52 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800058.outbound.protection.outlook.com [40.107.80.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8086EA24
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6PEhH6vD+5s/9h37acppuL5Fn7jkklCqW9nlY0yv5r1JzIko1w06Fic2JuzMJZu4GcLIsXFfJkOVEHNhq6Dww8jZt2sOo58WMeXZNiM5COPK44hGUC3lhTdeXjzT+UxrY7WJIHdceOg83xnBS5imOkUykw3MZ04FBFg1mg4c1kAxf7ChOIq+Mq3bISjjF4s3XiFxU/uydgQ9ad+47N8XoXL4fgMGIGQ7Htv+4SomPF8PFvjflF0SV9o8/ahkfg8IWXOtYTCuj6n0c5NS/HDD71AcJ4oVwUbfO+lRh/faO61arW6QYPiNzmcLQBxCouf0rV4GfJp6X1qjEBmBdRk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wykHxfion7yMpEL+X3RMydF4jRKPlTD5u1DDvVZPYOQ=;
 b=B5gA4ZpM4dcxA8nLCsWW+vFt2NO45RTgk/lIb0PU6uxc8tSUKSC1PY6wdFbQVtpN+EHLh1CLSRAWmBawat4MoI32BHJ1LKNgtuo93QJ9O1bJS27efHBfiBS7u1BmnwOVaeZmg9CYTEktYM9IEzzoRz/rmou2jE7dlieCrI6gV8dHwpYlaVYXv2z6vKpM6DdEORZ6XDjnx8Q1CCPI9pYtmoTdQF00CwyWDsYMJIecyxPofUl5nTaqm3DpX0QHUX5Q2chdoiPvPjZgQCrVK+RaNd7NLeGCRy5IKgqnz6prT3W7R5csw/iLzx+RzShQARZFbYPHHGXxL6fnugUp7NYxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:50 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/30] drm/amd/display: Fix incorrect deep color setting in
 YCBCR420 modes
Date: Mon, 11 Nov 2019 19:33:00 -0500
Message-Id: <20191112003324.8419-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf55ed81-ae33-4468-289b-08d76707fc82
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25543A57F5EB733EBDEFE93998770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pp7zw38e6emB+s5zSPlHD7McQZE2oa9tG2SLviQlvU9BextISWioXPihrDLw4qYvP25PbHkgucVnUGZtVRVk6Hv+h4/O396p1PxlAcbpZ++e+QonSik4q6SdkpZWPsYclOoXmIJVENhYds3lx4SR5Nr0se9PzrV3h+h2X7w55FDgbO/6dpInmWMRPjgnaJC4HNlbUvCR0KrKXOx2y9zQMrwhbzNl2du3+Vd/wscNV+xGGJEzm+diB3BdIuw+yBf97xIR55Xwr63aBuL/302S73jHR5nGb/lbgYOuywnyK6DauZu77LVi5Nde/l2BtJpqeamD9ZCAYHsru7YZqa4TmGvE8QHfTdGs4se34XEnFCKTR/Othcj65judRotBJqM+hdf4PNNYXhq+yba15qtOtn7KhYkwbKZ2K5Hm5P+VCKoheil1Jd/GAdCXnfu4XC6p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf55ed81-ae33-4468-289b-08d76707fc82
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:49.6684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfNc6OlbaUzIPfg3aS58HpUIXv4XQ/8/Sp/74eKlLMDMCAWiFW7hVWddzvRkENJ1PDsYjMFN0D9EOmMLhe8dAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wykHxfion7yMpEL+X3RMydF4jRKPlTD5u1DDvVZPYOQ=;
 b=UO6kWmsCfYVaR2z3W6bdE3oodfX+1NjpayRKQIJ3YcUWmb3ER+NSjQKcVxRhhvxzp7hW6E9mJPXIoHXqFBIGcL6oaGSCjtJn0H+n5t5wjnQxBG/oIhto+teHAXjHe0cMYt1btvwhLjfYxaVltWb/NTjW0t1knuBd1FzJDUIkJpE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003300.wUetc3dzoRfQMwjCrsbAgiwsdXiZUolIkQ--Y5nK7fU@z>

RnJvbTogU3R5bG9uIFdhbmcgPHN0eWxvbi53YW5nQGFtZC5jb20+CgpbV2h5XQpIRE1JIDIuMCBI
Ri1WU0RCIGluIEVESUQgZGVmaW5lcyBzdXBwb3J0ZWQgY29sb3IgZGVwdGhzIGluIFlDQkNSNDIw
IG1vZGVzLgpCdXQgd2UgZGlkIG5vdCBob25vciB0aGVzZSBiaXQgbWFza3Mgd2hlbiBjaG9vc2lu
ZyBwaXhlbCBlbmNvZGluZy4KSERNSSAyLjAgY29tcGxpYW5jZSB0ZXN0cyB3aXRoIGRlZXAgY29s
b3IgYW5kIFlDQkNSNDIwIGZhaWxlZCBhcyBhIHJlc3VsdC4KCltIb3ddCkNhcCBjb2xvciBkZXB0
aCBiYXNlZCBvbiB5NDIwX2RjX21vZGVzIGZyb20gRURJRC4KClNpZ25lZC1vZmYtYnk6IFN0eWxv
biBXYW5nIDxzdHlsb24ud2FuZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogTmljaG9sYXMgS2F6bGF1
c2thcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPgpBY2tlZC1ieTogUm9kcmlnbyBTaXF1
ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgotLS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDMxICsrKysrKysrKysrKysrKy0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGVkN2Nh
ZDRhMTgyZC4uNTU3M2M1ZDliMzI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTM2MTEsMTIgKzM2MTEsMjYgQEAgc3RhdGlj
IHZvaWQgdXBkYXRlX3N0cmVhbV9zY2FsaW5nX3NldHRpbmdzKGNvbnN0IHN0cnVjdCBkcm1fZGlz
cGxheV9tb2RlICptb2RlLAogCiBzdGF0aWMgZW51bSBkY19jb2xvcl9kZXB0aAogY29udmVydF9j
b2xvcl9kZXB0aF9mcm9tX2Rpc3BsYXlfaW5mbyhjb25zdCBzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAq
Y29ubmVjdG9yLAotCQkJCSAgICAgIGNvbnN0IHN0cnVjdCBkcm1fY29ubmVjdG9yX3N0YXRlICpz
dGF0ZSkKKwkJCQkgICAgICBjb25zdCBzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSAqc3RhdGUs
CisJCQkJICAgICAgYm9vbCBpc195NDIwKQogewotCXVpbnQ4X3QgYnBjID0gKHVpbnQ4X3QpY29u
bmVjdG9yLT5kaXNwbGF5X2luZm8uYnBjOworCXVpbnQ4X3QgYnBjOwogCi0JLyogQXNzdW1lIDgg
YnBjIGJ5IGRlZmF1bHQgaWYgbm8gYnBjIGlzIHNwZWNpZmllZC4gKi8KLQlicGMgPSBicGMgPyBi
cGMgOiA4OworCWlmIChpc195NDIwKSB7CisJCWJwYyA9IDg7CisKKwkJLyogQ2FwIGRpc3BsYXkg
YnBjIGJhc2VkIG9uIEhETUkgMi4wIEhGLVZTREIgKi8KKwkJaWYgKGNvbm5lY3Rvci0+ZGlzcGxh
eV9pbmZvLmhkbWkueTQyMF9kY19tb2RlcyAmIERSTV9FRElEX1lDQkNSNDIwX0RDXzQ4KQorCQkJ
YnBjID0gMTY7CisJCWVsc2UgaWYgKGNvbm5lY3Rvci0+ZGlzcGxheV9pbmZvLmhkbWkueTQyMF9k
Y19tb2RlcyAmIERSTV9FRElEX1lDQkNSNDIwX0RDXzM2KQorCQkJYnBjID0gMTI7CisJCWVsc2Ug
aWYgKGNvbm5lY3Rvci0+ZGlzcGxheV9pbmZvLmhkbWkueTQyMF9kY19tb2RlcyAmIERSTV9FRElE
X1lDQkNSNDIwX0RDXzMwKQorCQkJYnBjID0gMTA7CisJfSBlbHNlIHsKKwkJYnBjID0gKHVpbnQ4
X3QpY29ubmVjdG9yLT5kaXNwbGF5X2luZm8uYnBjOworCQkvKiBBc3N1bWUgOCBicGMgYnkgZGVm
YXVsdCBpZiBubyBicGMgaXMgc3BlY2lmaWVkLiAqLworCQlicGMgPSBicGMgPyBicGMgOiA4Owor
CX0KIAogCWlmICghc3RhdGUpCiAJCXN0YXRlID0gY29ubmVjdG9yLT5zdGF0ZTsKQEAgLTM3ODcs
NyArMzgwMSw4IEBAIHN0YXRpYyB2b2lkIGZpbGxfc3RyZWFtX3Byb3BlcnRpZXNfZnJvbV9kcm1f
ZGlzcGxheV9tb2RlKAogCiAJdGltaW5nX291dC0+dGltaW5nXzNkX2Zvcm1hdCA9IFRJTUlOR18z
RF9GT1JNQVRfTk9ORTsKIAl0aW1pbmdfb3V0LT5kaXNwbGF5X2NvbG9yX2RlcHRoID0gY29udmVy
dF9jb2xvcl9kZXB0aF9mcm9tX2Rpc3BsYXlfaW5mbygKLQkJY29ubmVjdG9yLCBjb25uZWN0b3Jf
c3RhdGUpOworCQljb25uZWN0b3IsIGNvbm5lY3Rvcl9zdGF0ZSwKKwkJKHRpbWluZ19vdXQtPnBp
eGVsX2VuY29kaW5nID09IFBJWEVMX0VOQ09ESU5HX1lDQkNSNDIwKSk7CiAJdGltaW5nX291dC0+
c2Nhbl90eXBlID0gU0NBTk5JTkdfVFlQRV9OT0RBVEE7CiAJdGltaW5nX291dC0+aGRtaV92aWMg
PSAwOwogCkBAIC00OTI2LDYgKzQ5NDEsNyBAQCBzdGF0aWMgaW50IGRtX2VuY29kZXJfaGVscGVy
X2F0b21pY19jaGVjayhzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsCiAJc3RydWN0IGRybV9k
cF9tc3RfcG9ydCAqbXN0X3BvcnQ7CiAJZW51bSBkY19jb2xvcl9kZXB0aCBjb2xvcl9kZXB0aDsK
IAlpbnQgY2xvY2ssIGJwcCA9IDA7CisJYm9vbCBpc195NDIwID0gZmFsc2U7CiAKIAlpZiAoIWFj
b25uZWN0b3ItPnBvcnQgfHwgIWFjb25uZWN0b3ItPmRjX3NpbmspCiAJCXJldHVybiAwOwpAQCAt
NDkzNyw3ICs0OTUzLDEwIEBAIHN0YXRpYyBpbnQgZG1fZW5jb2Rlcl9oZWxwZXJfYXRvbWljX2No
ZWNrKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwKIAkJcmV0dXJuIDA7CiAKIAlpZiAoIXN0
YXRlLT5kdXBsaWNhdGVkKSB7Ci0JCWNvbG9yX2RlcHRoID0gY29udmVydF9jb2xvcl9kZXB0aF9m
cm9tX2Rpc3BsYXlfaW5mbyhjb25uZWN0b3IsIGNvbm5fc3RhdGUpOworCQlpc195NDIwID0gZHJt
X21vZGVfaXNfNDIwX2Fsc28oJmNvbm5lY3Rvci0+ZGlzcGxheV9pbmZvLCBhZGp1c3RlZF9tb2Rl
KSAmJgorCQkJCWFjb25uZWN0b3ItPmZvcmNlX3l1djQyMF9vdXRwdXQ7CisJCWNvbG9yX2RlcHRo
ID0gY29udmVydF9jb2xvcl9kZXB0aF9mcm9tX2Rpc3BsYXlfaW5mbyhjb25uZWN0b3IsIGNvbm5f
c3RhdGUsCisJCQkJCQkJCSAgICBpc195NDIwKTsKIAkJYnBwID0gY29udmVydF9kY19jb2xvcl9k
ZXB0aF9pbnRvX2JwYyhjb2xvcl9kZXB0aCkgKiAzOwogCQljbG9jayA9IGFkanVzdGVkX21vZGUt
PmNsb2NrOwogCQlkbV9uZXdfY29ubmVjdG9yX3N0YXRlLT5wYm4gPSBkcm1fZHBfY2FsY19wYm5f
bW9kZShjbG9jaywgYnBwKTsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
