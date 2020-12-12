Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4157C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F89922AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F89922AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA816E892;
	Sat, 12 Dec 2020 15:47:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7B96E892
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiakaZ5uuwI4hIgklI+lJFLmw6m5S9weyvDZ4H39NVsxLJ6khyRd00IzntMwUNFv+COMFBT+CDI/fJtFm/LfgtoO1ELqt/vt+QuhfpbR94VeOFLwX7ixG/o/uP+FUyoiTZ2328fPqM2hJqrM7dk8N/V4BI8shXXu7/AXIQayE1GNpVNhnG8p6Ak06P5JAjfTt2RULBL7KzuJHyFZwJM+N1SgHv7rIL25AHgJ8PCPAcsNA++s4wHMLG2EZF8X9KWLOcmXasttHO2BgV4yqRCuo1O2XHUXeOTxxRJAi4O+rZk/G0Pkntctkb6mJ/xAE0i+2qQ4HpW/3HcUw6WUhcCVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZCqvCqYPWwhTnDGt7GIUv6heicU2ldeHTBGqQVu7PU=;
 b=e9HXL+z/nCF1wbxS03K8m+syriTZkI01+6b+prm2HlrwWFUA3xYda/tgmS+mxz1eLDy7/JeHGrUIDts7S91wwbMB/criMl8a7tI3QdzvhAjkexmyIRxHGY44usJon5zy2uYvLFVnp/plhgXFIxZ/2n+MvdctHkYJjhIaDe9YRFuPJg7nkViU9W0ZwKuxzUNdruTU+ykOFB8SgYT3/YXU5KGi4uPxwIPDvRBhcLqJb6mU5H9IdxzY5qYK8xOTa4vCeqeSATzfBztT8E0CUzUmFveYF+BQjMdhy1nlAbW8ZEJORMkBM9sJDwNWsdPKoK9e0VirzDqjiwxprtk+q8V1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZCqvCqYPWwhTnDGt7GIUv6heicU2ldeHTBGqQVu7PU=;
 b=r6S7ghg1BGvGZmZWEdMGsEkRM0FOfzr9LSO40vbKf43Y1FNNP3Cueo6NMOHpTjsAI1MZSCcA8EDqpfLYpWa0cYehAnft/OPtPvvxJuvZ4fcSvvmXu8r59wGXtrrZZMdCpk46zDCv7k5PtRya70azoW4jFdliZ7q+0XNNiwWPV9A=
Received: from MWHPR14CA0065.namprd14.prod.outlook.com (2603:10b6:300:81::27)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Sat, 12 Dec
 2020 15:47:34 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::d6) by MWHPR14CA0065.outlook.office365.com
 (2603:10b6:300:81::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:47:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:32 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:31 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:47:29 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 23/27] drm/amdgpu: retire the vega20 code path from navi10 ih
 block
Date: Sat, 12 Dec 2020 23:45:56 +0800
Message-ID: <20201212154600.21618-23-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38beea78-d184-4b19-0d0f-08d89eb53d73
X-MS-TrafficTypeDiagnostic: MN2PR12MB3742:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3742B9E0933C2896A7AFD200FCC90@MN2PR12MB3742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgQVo5ZVrEt8480IfluOlV6c5y64JXKtDX2FK8QDL+kD/34ljGz4foQxj4/c///qm9m6gYRUtB3bnZjMIm9f11iW6Up4ta+ADzOv4o2niGHsMAgr/fgwQp616YOF84wYBgRv5g8HfxPaE15dQtB1ll3k6VFH5A+ziocq9WFr5WXmwx/PuDM9jPeFETcWeTjQACTBpHZF7ESyxSMZW9NDDPIVQNVFn0W1H6lIySTBuVOofTywJ8uBTYIAwaoYTIzYKkZd6MG/XDgn0Qz5wOwVCub88ERJ+/PIJJOqKUUPmRUu50DMBptKLdJkArtfS/XQCDbWx18qOmeA7ji+x5E7tOLbKejNPjM6Tv58h+AN0qSD7a2hDL+xKS5kT3ftT/C0hEE4DnnsBM4lAQR5AKTSjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(46966005)(8936002)(1076003)(82310400003)(70586007)(336012)(70206006)(2906002)(2616005)(426003)(8676002)(508600001)(81166007)(86362001)(6666004)(26005)(83380400001)(4326008)(356005)(186003)(6636002)(36756003)(5660300002)(110136005)(47076004)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:47:32.8555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38beea78-d184-4b19-0d0f-08d89eb53d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YWxyZWFkeSBzd2l0Y2hlZCB0byB2ZWdhMjAgaWggYmxvY2sgZm9yIHZlZ2EyMAphbmQgYXJjdHVy
dXMuIG5vIG5lZWQgdG8gYWRkIHZlZ2EyMCBzdXBwb3J0IGluCm5hdmkxMCBpaCBibG9jawoKU2ln
bmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpBY2tlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tlZC1ieTog
RmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBEZW5u
aXMgTGkgPERlbm5pcy5MaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWku
WHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyB8
IDQwICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAzOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9uYXZpMTBfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9p
aC5jCmluZGV4IGEyNTBlNGY3N2YzMy4uNTgwYTMyNWYwOGI0IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9uYXZpMTBfaWguYwpAQCAtMTUxLDcgKzE1MSw3IEBAIHN0YXRpYyBpbnQgbmF2aTEw
X2loX3RvZ2dsZV9yaW5nX2ludGVycnVwdHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
LyogZW5hYmxlX2ludHIgZmllbGQgaXMgb25seSB2YWxpZCBpbiByaW5nMCAqLwogCWlmIChpaCA9
PSAmYWRldi0+aXJxLmloKQogCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfUkJfQ05UTCwg
RU5BQkxFX0lOVFIsIChlbmFibGUgPyAxIDogMCkpOwotCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRl
dikgJiYgYWRldi0+YXNpY190eXBlIDwgQ0hJUF9OQVZJMTApIHsKKwlpZiAoYW1kZ3B1X3NyaW92
X3ZmKGFkZXYpKSB7CiAJCWlmIChwc3BfcmVnX3Byb2dyYW0oJmFkZXYtPnBzcCwgaWhfcmVncy0+
cHNwX3JlZ19pZCwgdG1wKSkgewogCQkJZGV2X2VycihhZGV2LT5kZXYsICJQU1AgcHJvZ3JhbSBJ
SF9SQl9DTlRMIGZhaWxlZCFcbiIpOwogCQkJcmV0dXJuIC1FVElNRURPVVQ7CkBAIC0yNjgsNyAr
MjY4LDcgQEAgc3RhdGljIGludCBuYXZpMTBfaWhfZW5hYmxlX3Jpbmcoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiAJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9SQl9DTlRMLCBXUFRS
X09WRVJGTE9XX0VOQUJMRSwgMCk7CiAJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9SQl9D
TlRMLCBSQl9GVUxMX0RSQUlOX0VOQUJMRSwgMSk7CiAJfQotCWlmIChhbWRncHVfc3Jpb3ZfdmYo
YWRldikgJiYgYWRldi0+YXNpY190eXBlIDwgQ0hJUF9OQVZJMTApIHsKKwlpZiAoYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpKSB7CiAJCWlmIChwc3BfcmVnX3Byb2dyYW0oJmFkZXYtPnBzcCwgaWhfcmVn
cy0+cHNwX3JlZ19pZCwgdG1wKSkgewogCQkJZGV2X2VycihhZGV2LT5kZXYsICJQU1AgcHJvZ3Jh
bSBJSF9SQl9DTlRMIGZhaWxlZCFcbiIpOwogCQkJcmV0dXJuIC1FVElNRURPVVQ7CkBAIC0yOTIs
MjQgKzI5Miw2IEBAIHN0YXRpYyBpbnQgbmF2aTEwX2loX2VuYWJsZV9yaW5nKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdm9pZCBuYXZpMTBfaWhf
cmVyb3V0ZV9paChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKLXsKLQl1aW50MzJfdCB0bXA7
Ci0KLQkvKiBSZXJvdXRlIHRvIElIIHJpbmcgMSBmb3IgVk1DICovCi0JV1JFRzMyX1NPQzE1KE9T
U1NZUywgMCwgbW1JSF9DTElFTlRfQ0ZHX0lOREVYLCAweDEyKTsKLQl0bXAgPSBSUkVHMzJfU09D
MTUoT1NTU1lTLCAwLCBtbUlIX0NMSUVOVF9DRkdfREFUQSk7Ci0JdG1wID0gUkVHX1NFVF9GSUVM
RCh0bXAsIElIX0NMSUVOVF9DRkdfREFUQSwgQ0xJRU5UX1RZUEUsIDEpOwotCXRtcCA9IFJFR19T
RVRfRklFTEQodG1wLCBJSF9DTElFTlRfQ0ZHX0RBVEEsIFJJTkdfSUQsIDEpOwotCVdSRUczMl9T
T0MxNShPU1NTWVMsIDAsIG1tSUhfQ0xJRU5UX0NGR19EQVRBLCB0bXApOwotCi0JLyogUmVyb3V0
ZSBJSCByaW5nIDEgZm9yIFVNQyAqLwotCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ0xJ
RU5UX0NGR19JTkRFWCwgMHgxQik7Ci0JdG1wID0gUlJFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1J
SF9DTElFTlRfQ0ZHX0RBVEEpOwotCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9DTElFTlRf
Q0ZHX0RBVEEsIFJJTkdfSUQsIDEpOwotCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ0xJ
RU5UX0NGR19EQVRBLCB0bXApOwotfQotCiAvKioKICAqIG5hdmkxMF9paF9pcnFfaW5pdCAtIGlu
aXQgYW5kIGVuYWJsZSB0aGUgaW50ZXJydXB0IHJpbmcKICAqCkBAIC01ODIsMjQgKzU2NCw2IEBA
IHN0YXRpYyBpbnQgbmF2aTEwX2loX3N3X2luaXQodm9pZCAqaGFuZGxlKQogCWFkZXYtPmlycS5p
aDEucmluZ19zaXplID0gMDsKIAlhZGV2LT5pcnEuaWgyLnJpbmdfc2l6ZSA9IDA7CiAKLQlpZiAo
YWRldi0+YXNpY190eXBlIDwgQ0hJUF9OQVZJMTApIHsKLQkJciA9IGFtZGdwdV9paF9yaW5nX2lu
aXQoYWRldiwgJmFkZXYtPmlycS5paDEsIFBBR0VfU0laRSwgdHJ1ZSk7Ci0JCWlmIChyKQotCQkJ
cmV0dXJuIHI7Ci0KLQkJYWRldi0+aXJxLmloMS51c2VfZG9vcmJlbGwgPSB0cnVlOwotCQlhZGV2
LT5pcnEuaWgxLmRvb3JiZWxsX2luZGV4ID0KLQkJCQkJKGFkZXYtPmRvb3JiZWxsX2luZGV4Lmlo
ICsgMSkgPDwgMTsKLQotCQlyID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2LCAmYWRldi0+aXJx
LmloMiwgUEFHRV9TSVpFLCB0cnVlKTsKLQkJaWYgKHIpCi0JCQlyZXR1cm4gcjsKLQotCQlhZGV2
LT5pcnEuaWgyLnVzZV9kb29yYmVsbCA9IHRydWU7Ci0JCWFkZXYtPmlycS5paDIuZG9vcmJlbGxf
aW5kZXggPQotCQkJCQkoYWRldi0+ZG9vcmJlbGxfaW5kZXguaWggKyAyKSA8PCAxOwotCX0KLQog
CS8qIGluaXRpYWxpemUgaWggY29udHJvbCByZWdpc3RlcnMgb2Zmc2V0ICovCiAJbmF2aTEwX2lo
X2luaXRfcmVnaXN0ZXJfb2Zmc2V0KGFkZXYpOwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
