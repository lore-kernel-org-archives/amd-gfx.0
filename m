Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A55C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4662A2067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4662A2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6B06EBA9;
	Tue, 12 Nov 2019 18:04:09 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790087.outbound.protection.outlook.com [40.107.79.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5F46EBAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMEmL3SPNMByVMcEjwRYr9i7ZZEze/GTzEintq6wzFp5So8vQMJbAJg1itojVPFMoqc93/01bwA20rqDLIxBnHe0PqwdYANQCsurd0ml/Ih4kOA2Mj+B87x6UhpyBgW1u0DsUAh/SbjOL3qOMFokFWb34fbLG5EFqeY1Qetwn63DeVz7dzA9Eunk6SLsUlCf+3CT5RewkoktGKikazPKC9zfdQinKSzQtbe38PAwJctRJ4+BAokFYnoTlvCKuetlhrPRo1GDoRYH03oWf6GlNczxT2fJ1tdJm3jCmkG+HcIWbcMPSJzq7r2y8QJcCy8gY9NL01MCtqs4DgecEuO8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmX17q/7hSV6d2jkRz4kJGD0Hiv9ikKsdFTjQ/DZ1WE=;
 b=EprGwJWPWpHeN4nZuEOkQHGDXLS9rt/XsYtAQa2MRSnQzddwN4Z5HFgfB+Z5P8dOzmKl2fozAPOSKmFEUZhF8BwjAcQ0T32c5sQGe8HpXBkFSSEhywf0XgeRrnTgNRbcj5+mJ0tbLfTI6TJ35YBEX8KHvapecqOMAonup7JSOxUOVwF9gFnHaXQfI8ZdG1ln8qPYL22UfVXsBigTvw6RjmB3UHGKySbFmuZROhd4ljGpvUCQuIK6w656cYMucXHfxgX5I1rfdgroRJ0N/h7nBw6YKCVqmJsHOY1dlkCuDxNkl4DId3OxKJPHH5RXYJaTZcMFpkgRKjV/YULPqjy6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 18:04:06 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:06 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/21] drm/amdgpu: add JPEG common functions to amdgpu_jpeg
Date: Tue, 12 Nov 2019 13:03:14 -0500
Message-Id: <20191112180329.3927-7-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a74d9c8-0a2a-4cbb-59f0-08d7679ab555
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB240549F0364CBF39EA4760C2E5770@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(4326008)(6512007)(76176011)(66066001)(47776003)(6666004)(2351001)(478600001)(51416003)(52116002)(14454004)(6916009)(44832011)(486006)(186003)(476003)(2616005)(6506007)(386003)(7736002)(26005)(25786009)(2361001)(14444005)(36756003)(86362001)(305945005)(446003)(11346002)(6116002)(8676002)(3846002)(99286004)(16586007)(66476007)(50226002)(66946007)(2906002)(6486002)(6436002)(8936002)(81166006)(50466002)(5660300002)(316002)(1076003)(48376002)(81156014)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2405;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrYsV9ryL+X4v0B4rAMYc+WQp/ppXVuK1fNpjJCqu9TZMW6wTs3wnpUFKLdc2fbXF65A3ZKCaf0/vCMvoEcOTPLznW2QP6sf9cm+D/U2626kK0t2C99Vm4G/kCUwC7vwPt51YIUfDpIGCVgSjv2+R+pB1Q8ZlzV/mwaQGzSz0HxLJOPuUUIjVpwvCE3rspTjpgLAqnzuUS5QO2obm5pp8jdkBR7PB7OHI3JpnpHPu18Zt0nNlH8GgeOvYGj4uZ/iLExKziUymZXYFZhh6nCL50rhtBf1SNBspWaYk9Y37t1hKp+lphyiRs4+UEiK6JXBDCvQzGSrCefKtEe8Hm0EP7+tLIHZfwrShQuRcIqsvkZ6AYJddHUIuwfBZheO8FhJGrs9Ch2KyWEjPrn1BIDWD0ykc3aK2ZlE3CJt5pHAhjKMDYyoH1o3FxhCPmaZucFI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a74d9c8-0a2a-4cbb-59f0-08d7679ab555
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:06.3987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTjsu8J1hgF0JFC6IQ/2vth0diJ45W+OCRwNJ1Ut9rt2hxecvkj92BJekln9hqrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmX17q/7hSV6d2jkRz4kJGD0Hiv9ikKsdFTjQ/DZ1WE=;
 b=wIcqkez1PooIrmhy767q81dMD+GyAyD15lhKCzRDRnzy4lxNizNDlAPGYqmmXWt4+uyhSb9wRcG3P71jYl/R4aCoAob1UYkdhB2wYH04lxs/CelZyupQ2kzjMVfs4rQln7CLTLHcc6Caf1tf2Whcrk0cb7Ibruze1IBmv8El4XM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112180314.B5ydOn7aqr5RnJzTZlJLKoSzTOx9gZ-fPBZYbQO_Bm8@z>

VGhleSB3aWxsIGJlIHVzZWQgZm9yIEpQRUcyLjAgYW5kIGxhdGVyLgoKU2lnbmVkLW9mZi1ieTog
TGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9qcGVnLmMgfCA4MCArKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmggfCAxMCArKysKIDIgZmlsZXMgY2hhbmdlZCwg
OTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9qcGVnLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5j
CmluZGV4IGQ5YTU0N2Q0ZDNiMi4uNTFmOThhYjkwZDdmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9qcGVnLmMKQEAgLTI2LDkgKzI2LDg5IEBACiAKICNpbmNsdWRlICJhbWRn
cHUuaCIKICNpbmNsdWRlICJhbWRncHVfanBlZy5oIgorI2luY2x1ZGUgImFtZGdwdV9wbS5oIgog
I2luY2x1ZGUgInNvYzE1ZC5oIgogI2luY2x1ZGUgInNvYzE1X2NvbW1vbi5oIgogCisjZGVmaW5l
IEpQRUdfSURMRV9USU1FT1VUCW1zZWNzX3RvX2ppZmZpZXMoMTAwMCkKKworc3RhdGljIHZvaWQg
YW1kZ3B1X2pwZWdfaWRsZV93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsK
KworaW50IGFtZGdwdV9qcGVnX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7
CisJSU5JVF9ERUxBWUVEX1dPUksoJmFkZXYtPmpwZWcuaWRsZV93b3JrLCBhbWRncHVfanBlZ19p
ZGxlX3dvcmtfaGFuZGxlcik7CisKKwlyZXR1cm4gMDsKK30KKworaW50IGFtZGdwdV9qcGVnX3N3
X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7CisJaW50IGk7CisKKwljYW5jZWxf
ZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmpwZWcuaWRsZV93b3JrKTsKKworCWZvciAoaSA9IDA7
IGkgPCBhZGV2LT5qcGVnLm51bV9qcGVnX2luc3Q7ICsraSkgeworCQlpZiAoYWRldi0+anBlZy5o
YXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQorCQkJY29udGludWU7CisKKwkJYW1kZ3B1X3Jpbmdf
ZmluaSgmYWRldi0+anBlZy5pbnN0W2ldLnJpbmdfZGVjKTsKKwl9CisKKwlyZXR1cm4gMDsKK30K
KworaW50IGFtZGdwdV9qcGVnX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7
CisJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT5qcGVnLmlkbGVfd29yayk7CisKKwly
ZXR1cm4gMDsKK30KKworaW50IGFtZGdwdV9qcGVnX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKK3sKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgYW1kZ3B1X2pwZWdfaWRs
ZV93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQoreworCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0KKwkJY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBhbWRncHVfZGV2
aWNlLCBqcGVnLmlkbGVfd29yay53b3JrKTsKKwl1bnNpZ25lZCBpbnQgZmVuY2VzID0gMDsKKwl1
bnNpZ25lZCBpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5qcGVnLm51bV9qcGVnX2lu
c3Q7ICsraSkgeworCQlpZiAoYWRldi0+anBlZy5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQor
CQkJY29udGludWU7CisKKwkJZmVuY2VzICs9IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZh
ZGV2LT5qcGVnLmluc3RbaV0ucmluZ19kZWMpOworCX0KKworCWlmIChmZW5jZXMgPT0gMCkgewor
CQlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIHRydWUpOworCQlhbWRncHVfZGV2aWNlX2lwX3Nl
dF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9KUEVHLAorCQkJCQkJ
ICAgICAgIEFNRF9QR19TVEFURV9HQVRFKTsKKwl9IGVsc2UgeworCQlzY2hlZHVsZV9kZWxheWVk
X3dvcmsoJmFkZXYtPmpwZWcuaWRsZV93b3JrLCBKUEVHX0lETEVfVElNRU9VVCk7CisJfQorfQor
Cit2b2lkIGFtZGdwdV9qcGVnX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZykKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7CisJYm9vbCBz
ZXRfY2xvY2tzID0gIWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+anBlZy5pZGxlX3dv
cmspOworCisJaWYgKHNldF9jbG9ja3MpIHsKKwkJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBm
YWxzZSk7CisJCWFtZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFN
RF9JUF9CTE9DS19UWVBFX0pQRUcsCisJCQkJCQkgICAgICAgQU1EX1BHX1NUQVRFX1VOR0FURSk7
CisJfQorfQorCit2b2lkIGFtZGdwdV9qcGVnX3JpbmdfZW5kX3VzZShzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcpCit7CisJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZyaW5nLT5hZGV2LT5qcGVnLmlk
bGVfd29yaywgSlBFR19JRExFX1RJTUVPVVQpOworfQorCiBpbnQgYW1kZ3B1X2pwZWdfZGVjX3Jp
bmdfdGVzdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKIHsKIAlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfanBlZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2pwZWcuaAppbmRleCBhOGQ5ODhjMjVmNDUuLjVlMmUwNmVjMTNkZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5oCkBAIC00MSw4ICs0MSwxOCBAQCBzdHJ1Y3Qg
YW1kZ3B1X2pwZWcgewogCXN0cnVjdCBhbWRncHVfanBlZ19pbnN0IGluc3RbQU1ER1BVX01BWF9K
UEVHX0lOU1RBTkNFU107CiAJc3RydWN0IGFtZGdwdV9qcGVnX3JlZyBpbnRlcm5hbDsKIAl1bnNp
Z25lZCBoYXJ2ZXN0X2NvbmZpZzsKKwlzdHJ1Y3QgZGVsYXllZF93b3JrIGlkbGVfd29yazsKKwll
bnVtIGFtZF9wb3dlcmdhdGluZ19zdGF0ZSBjdXJfc3RhdGU7CiB9OwogCitpbnQgYW1kZ3B1X2pw
ZWdfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CitpbnQgYW1kZ3B1X2pwZWdf
c3dfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CitpbnQgYW1kZ3B1X2pwZWdfc3Vz
cGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CitpbnQgYW1kZ3B1X2pwZWdfcmVzdW1l
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKKwordm9pZCBhbWRncHVfanBlZ19yaW5nX2Jl
Z2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOwordm9pZCBhbWRncHVfanBlZ19yaW5n
X2VuZF91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKTsKKwogaW50IGFtZGdwdV9qcGVnX2Rl
Y19yaW5nX3Rlc3RfcmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOwogaW50IGFtZGdwdV9q
cGVnX2RlY19yaW5nX3Rlc3RfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVv
dXQpOwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
