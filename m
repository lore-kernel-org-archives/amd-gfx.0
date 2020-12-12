Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C01C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0713822AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0713822AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B806E868;
	Sat, 12 Dec 2020 15:46:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B443F6E868
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU0kzthj2g6xDQXPyIpdC5im3ubOCSoUeIvRlLEvUFFoNJRzsaY71JbFYvAEViEfCq/Cba2IUHG5bt7Y1xyx1Gt2HyvQUQU/BYIUjZxMkYhkAL+DIYxupbzHtL4Mo00tqLHNMXW1SRutucNtcBKTMLX4lK1L9uK1CXFB50b/O7AahhUN5ZZJNY52Dj08VTdzGz1hq5PGl4ZGbSMAp1X1E57ktyGFzCa38X4yqbT/7sHcxbTL3kbTyVReZ5DXvz7Yd/6HjcWyNl/N+uSk+ovy05j+cWMwgXHjIjyj0Sqlv23Jv5ssUfWmWdLsiFKmcx8yOrVh0BVaSrbvhYhxCPyJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91EArk8EXijrq1yLkb7RoXlR2q7O7zeExsNmTyYl4Lg=;
 b=NO12VtY9ZkSCL4Y7cM41Zfw15N0ywXc51yRG7t46y33wOraVVYJ2eAJ+oe1nWmKrymxN2WOcP2OfszBUVTpsffmllHfTASPE0FO8/NdPfYviuWvQQkTI245u9fmamOuFcmJEzhluEKCdjcXoV0TQKbS54dfJLhxP5Gm9S8frwdQEFZN4+Zq2oTQ0ZM+2mrF2LWo5pi22FmF+EQcbGZqCj6gIAK8IaZ1PWMAb4C5VtpO2OzUjFWPonD80HnJ93CAzQyZpxOcPmCIKmtXV6so59JfMikRWyJc2bTX1WalaE8/HiVylG9kad6yUG7Go3d+i5p7SYjT0bvmvwkl5NFJnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91EArk8EXijrq1yLkb7RoXlR2q7O7zeExsNmTyYl4Lg=;
 b=Yv5L9HQwhhk3LPLAPnmqLJpc5brytox3WFSN3zVKQ32BAMcYe0BrWrl0B/eyrzPOD0H1dTL23V/bLnWqx9vTwZ2ARyQt6Tg2+aUpVrFgCQBTSpMnAIELrzrCBgke6QQmvQuW6jGYpaJAsfLEUAPxtxFsICVzipbRLgQ3SXlC+1U=
Received: from BN9PR03CA0206.namprd03.prod.outlook.com (2603:10b6:408:f9::31)
 by MN2PR12MB3312.namprd12.prod.outlook.com (2603:10b6:208:ab::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Sat, 12 Dec
 2020 15:46:33 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::fe) by BN9PR03CA0206.outlook.office365.com
 (2603:10b6:408:f9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:32 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:31 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:29 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 08/27] drm/amdgpu: use cached ih rb control reg offsets for
 vega10
Date: Sat, 12 Dec 2020 23:45:41 +0800
Message-ID: <20201212154600.21618-8-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b9dfcb3-4964-493f-3e47-08d89eb519e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3312:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3312076C3F5FD8A10CF47DE9FCC90@MN2PR12MB3312.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A21BNvIR/62u3FTeBe7h7lQQMq7Dmxh76x/OoTpAnsxnoeshU/UAEW44EU6ib3S1ZOZOYUUsoDwNBtN3U9sfXX8X7m42WEiTPwZes3XNu0Y7N5SXC/KaO0aELkYgcniD0wnvkfB4Cbq4comfcn6SzwLcNbyBF8AgVxn009CE51nSD87FD7WcrY+apy5y/Pyep62izC9UVHeBBEh2bxPRhELG+WqOV/NNVpKpXquQD7Yvz9K2ftcFwzMnHJsGq0g7F0TfxYcH5KcjEX35bqt2B9fc0/uM66mMgj02glUPG4CZDgj7OMCDDwx+gom3l9glaYGVM4vmgYX9SQJWlZbhr8MEXxZJMJgvTzGxtGfgfbH6qVNxh4m/0yly3sqogse8J/DqEpFD1w/Vc+7JyY9oa24vNMoC5PaAgfG7dGDk5lc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(46966005)(47076004)(82310400003)(5660300002)(7696005)(81166007)(508600001)(4326008)(70586007)(6666004)(336012)(36756003)(83380400001)(2616005)(1076003)(110136005)(8676002)(2906002)(86362001)(8936002)(356005)(186003)(426003)(6636002)(26005)(70206006)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:33.3208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9dfcb3-4964-493f-3e47-08d89eb519e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3312
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

YWxsIHRoZSBpaCByYiBjb250cm9sIHJlZ2lzdGVyIG9mZnNldHMgYXJlIGNhY2hlZAphdCB0aGUg
YmVnaW5uaW5nIG9mIGloX3N3X2luaXQuCgpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+CkFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+
ClJldmlld2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIHwgNTQgKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCmluZGV4IDcwZWRkNWUxNWUxMS4u
NjI5YmE0NjAxM2FhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdh
MTBfaWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwpAQCAt
MzQ0LDI1ICszNDQsMTcgQEAgc3RhdGljIHZvaWQgdmVnYTEwX2loX2lycV9kaXNhYmxlKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogc3RhdGljIHUzMiB2ZWdhMTBfaWhfZ2V0X3dwdHIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgICBzdHJ1Y3QgYW1kZ3B1X2loX3Jpbmcg
KmloKQogewotCXUzMiB3cHRyLCByZWcsIHRtcDsKKwl1MzIgd3B0ciwgdG1wOworCXN0cnVjdCBh
bWRncHVfaWhfcmVncyAqaWhfcmVnczsKIAogCXdwdHIgPSBsZTMyX3RvX2NwdSgqaWgtPndwdHJf
Y3B1KTsKKwlpaF9yZWdzID0gJmloLT5paF9yZWdzOwogCiAJaWYgKCFSRUdfR0VUX0ZJRUxEKHdw
dHIsIElIX1JCX1dQVFIsIFJCX09WRVJGTE9XKSkKIAkJZ290byBvdXQ7CiAKIAkvKiBEb3VibGUg
Y2hlY2sgdGhhdCB0aGUgb3ZlcmZsb3cgd2Fzbid0IGFscmVhZHkgY2xlYXJlZC4gKi8KLQotCWlm
IChpaCA9PSAmYWRldi0+aXJxLmloKQotCQlyZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywg
MCwgbW1JSF9SQl9XUFRSKTsKLQllbHNlIGlmIChpaCA9PSAmYWRldi0+aXJxLmloMSkKLQkJcmVn
ID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfV1BUUl9SSU5HMSk7Ci0JZWxz
ZSBpZiAoaWggPT0gJmFkZXYtPmlycS5paDIpCi0JCXJlZyA9IFNPQzE1X1JFR19PRkZTRVQoT1NT
U1lTLCAwLCBtbUlIX1JCX1dQVFJfUklORzIpOwotCWVsc2UKLQkJQlVHKCk7Ci0KLQl3cHRyID0g
UlJFRzMyX05PX0tJUShyZWcpOworCXdwdHIgPSBSUkVHMzJfTk9fS0lRKGloX3JlZ3MtPmloX3Ji
X3dwdHIpOwogCWlmICghUkVHX0dFVF9GSUVMRCh3cHRyLCBJSF9SQl9XUFRSLCBSQl9PVkVSRkxP
VykpCiAJCWdvdG8gb3V0OwogCkBAIC0zNzgsMTggKzM3MCw5IEBAIHN0YXRpYyB1MzIgdmVnYTEw
X2loX2dldF93cHRyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkgd3B0ciwgaWgtPnJw
dHIsIHRtcCk7CiAJaWgtPnJwdHIgPSB0bXA7CiAKLQlpZiAoaWggPT0gJmFkZXYtPmlycS5paCkK
LQkJcmVnID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTCk7Ci0JZWxz
ZSBpZiAoaWggPT0gJmFkZXYtPmlycS5paDEpCi0JCXJlZyA9IFNPQzE1X1JFR19PRkZTRVQoT1NT
U1lTLCAwLCBtbUlIX1JCX0NOVExfUklORzEpOwotCWVsc2UgaWYgKGloID09ICZhZGV2LT5pcnEu
aWgyKQotCQlyZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJ
TkcyKTsKLQllbHNlCi0JCUJVRygpOwotCi0JdG1wID0gUlJFRzMyX05PX0tJUShyZWcpOworCXRt
cCA9IFJSRUczMl9OT19LSVEoaWhfcmVncy0+aWhfcmJfY250bCk7CiAJdG1wID0gUkVHX1NFVF9G
SUVMRCh0bXAsIElIX1JCX0NOVEwsIFdQVFJfT1ZFUkZMT1dfQ0xFQVIsIDEpOwotCVdSRUczMl9O
T19LSVEocmVnLCB0bXApOworCVdSRUczMl9OT19LSVEoaWhfcmVncy0+aWhfcmJfY250bCwgdG1w
KTsKIAogb3V0OgogCXJldHVybiAod3B0ciAmIGloLT5wdHJfbWFzayk7CkBAIC00NTAsMjIgKzQz
MywxNCBAQCBzdGF0aWMgdm9pZCB2ZWdhMTBfaWhfZGVjb2RlX2l2KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogc3RhdGljIHZvaWQgdmVnYTEwX2loX2lycV9yZWFybShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloKQogewot
CXVpbnQzMl90IHJlZ19ycHRyID0gMDsKIAl1aW50MzJfdCB2ID0gMDsKIAl1aW50MzJfdCBpID0g
MDsKKwlzdHJ1Y3QgYW1kZ3B1X2loX3JlZ3MgKmloX3JlZ3M7CiAKLQlpZiAoaWggPT0gJmFkZXYt
PmlycS5paCkKLQkJcmVnX3JwdHIgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9S
Ql9SUFRSKTsKLQllbHNlIGlmIChpaCA9PSAmYWRldi0+aXJxLmloMSkKLQkJcmVnX3JwdHIgPSBT
T0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9SUFRSX1JJTkcxKTsKLQllbHNlIGlm
IChpaCA9PSAmYWRldi0+aXJxLmloMikKLQkJcmVnX3JwdHIgPSBTT0MxNV9SRUdfT0ZGU0VUKE9T
U1NZUywgMCwgbW1JSF9SQl9SUFRSX1JJTkcyKTsKLQllbHNlCi0JCXJldHVybjsKLQorCWloX3Jl
Z3MgPSAmaWgtPmloX3JlZ3M7CiAJLyogUmVhcm0gSVJRIC8gcmUtd3dyaXRlIGRvb3JiZWxsIGlm
IGRvb3JiZWxsIHdyaXRlIGlzIGxvc3QgKi8KIAlmb3IgKGkgPSAwOyBpIDwgTUFYX1JFQVJNX1JF
VFJZOyBpKyspIHsKLQkJdiA9IFJSRUczMl9OT19LSVEocmVnX3JwdHIpOworCQl2ID0gUlJFRzMy
X05PX0tJUShpaF9yZWdzLT5paF9yYl9ycHRyKTsKIAkJaWYgKCh2IDwgaWgtPnJpbmdfc2l6ZSkg
JiYgKHYgIT0gaWgtPnJwdHIpKQogCQkJV0RPT1JCRUxMMzIoaWgtPmRvb3JiZWxsX2luZGV4LCBp
aC0+cnB0cik7CiAJCWVsc2UKQEAgLTQ4NCw2ICs0NTksOCBAQCBzdGF0aWMgdm9pZCB2ZWdhMTBf
aWhfaXJxX3JlYXJtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogc3RhdGljIHZvaWQgdmVn
YTEwX2loX3NldF9ycHRyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJICAgICAgIHN0
cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpCiB7CisJc3RydWN0IGFtZGdwdV9paF9yZWdzICppaF9y
ZWdzOworCiAJaWYgKGloLT51c2VfZG9vcmJlbGwpIHsKIAkJLyogWFhYIGNoZWNrIGlmIHN3YXBw
aW5nIGlzIG5lY2Vzc2FyeSBvbiBCRSAqLwogCQkqaWgtPnJwdHJfY3B1ID0gaWgtPnJwdHI7CkBA
IC00OTEsMTIgKzQ2OCw5IEBAIHN0YXRpYyB2b2lkIHZlZ2ExMF9paF9zZXRfcnB0cihzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKIAogCQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQogCQkJ
dmVnYTEwX2loX2lycV9yZWFybShhZGV2LCBpaCk7Ci0JfSBlbHNlIGlmIChpaCA9PSAmYWRldi0+
aXJxLmloKSB7Ci0JCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfUlBUUiwgaWgtPnJw
dHIpOwotCX0gZWxzZSBpZiAoaWggPT0gJmFkZXYtPmlycS5paDEpIHsKLQkJV1JFRzMyX1NPQzE1
KE9TU1NZUywgMCwgbW1JSF9SQl9SUFRSX1JJTkcxLCBpaC0+cnB0cik7Ci0JfSBlbHNlIGlmIChp
aCA9PSAmYWRldi0+aXJxLmloMikgewotCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JC
X1JQVFJfUklORzIsIGloLT5ycHRyKTsKKwl9IGVsc2UgeworCQlpaF9yZWdzID0gJmloLT5paF9y
ZWdzOworCQlXUkVHMzIoaWhfcmVncy0+aWhfcmJfcnB0ciwgaWgtPnJwdHIpOwogCX0KIH0KIAot
LSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
