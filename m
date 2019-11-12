Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24E7C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8BA2184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8BA2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A75F6EA3D;
	Tue, 12 Nov 2019 00:34:14 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800087.outbound.protection.outlook.com [40.107.80.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABBC6EA24
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlARfrgSZCV69FY49+TLTih89sFkNy5TJt0oM5ETz3gUk7pUpKhI3BufH1/OQV/bsg+yN908eBx7T3O+HT5gm43R4figkmYKaipQ2Q8RWnj4UtIB1qfAsCIGtL1HAK1hOl279vGAu6VJ/5itAlMazxOfMGfFtX9EOIMu8r5wrjdlSfpHhHDb/yAiHhjxdJPbKKMxW6CrPNxxQkBiPXljsz3wppoo9hNMpAaPX8n4cMU8AQ6SrVrAyD+zN/aArM+6/XD5VkoZIECLsLDTYS2mVOwGmJvVKU0Qa8qC7+NFqHySamT2fK34l8N4gymZHR5BzUlCh1JgjS6mrx9hnn1TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grk30mYxqM1u5YGHKkFth6+O48FEwUXjJSKiiGJyGFI=;
 b=QFnGSF99z1tUtXUyOaxtOlYpqvkWFIDJ32aVwJyxaznCmDiBc8vxqIerCgHmvG5y/YtPnt+q/YNhg74RD1ugLkZ79wNj0fJwMg40ppp1ShJOiKa8ilXE7CrVKL8qdvyxLD6T2vEVmvzL1PxuGF4OonaXhJctbLI+M4Qeh//v0gbeHCQNogVPdAezhDDQJu/WoHi+8ykC5uORY//fhhpB/+7ooHVUbK0AAhEGYlpH4zya9EARnGyGBUMhueVmj8v1jHy/furFV8BOD9JmW8pbQk+giz7uloyLBAx0QN8rHQ7dlYyBD0xqsysVz8f1kqExV9jPzjq6+Ef4E4KJpLP7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:59 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/30] drm/amd/display: Add debug trace for dmcub FW autoload.
Date: Mon, 11 Nov 2019 19:33:14 -0500
Message-Id: <20191112003324.8419-21-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7358a87b-5038-4b99-5c00-08d767080224
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25543E053270C555E086E54E98770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgrQPSmxs+sTq5fao4SWNnx0ZYCsL9GlCLhtGsGxC+BnC/uiKZjrSiLPM70z4fwO5/qyloD8QA0JrkmdMVIZzx5efYH8BjkdGm/5haKKxRUFXuVEFHayXy+VwBPVr1AbFHrMpoc6CE8xEOftgvhfGNeTGowZzjHhyXtUscjKvRR4/lUFtuf/0HKMqQDY0py/ZREjpwKZy0un5j6JLNIovg2i2ro5axnfXqQs0O2EKckYKtIvmenoNNVrCa2HW8199+pY25sV8Z/EsoXlcKmyfQjh7veuC3gvpFl3yev4EHi10L5g2yaENfFXg7tAqF4yhG5Ct91LF6Uo0/o0CNRdS16ECd1UEelAorLspVNK6WGbUsDodrQ7j0JZo0aG+FVkesN7heQMGqfyzrM1M+2jFyqYKJvk94iGPMaYIIr6Sh3nJLT+s/iUOwBBsmOVq1DV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7358a87b-5038-4b99-5c00-08d767080224
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:59.1989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZBvSuURMZo7shQ3mceHBd/fOy5M00YnEh6NsnwrgAThAli7miD7GPz72IHpXHe4gQQHmrNGtlDJYL4BZt1Pww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grk30mYxqM1u5YGHKkFth6+O48FEwUXjJSKiiGJyGFI=;
 b=yORf9uFU8o9YPu+wo5S/sXIAoLVlcffsNVeuRU5vGa9bECm/x/5YQLYF6iZ2NulInSa8zVgM4uA0ALUSKy2Yb4US/9NdzkK8akPHpzW3paFvISmwmvnZo2fvsuPDGrUt/qy094han10v8Ul8FQ1YhtH+QzI412ZjiwDUFPp71SY=
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>, Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003314.cj1ssXCiegNghkw96DJkVX6zQ1Ec9mbozC0b2jkmk-o@z>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKW1doeSAmIEhvd10K
MS4gQWRkIHRyYWNlIGNvZGUgZW51bSBmb3IgZWFzeSBkZWJ1Z2dpbmcuCjIuIEFkZCB0cmFjZSBk
dXJpbmcgdUMgYm9vdCB1cCwgaW5jbHVkaW5nIGxvYWRpbmcgcGh5IEZXCiAgIGFuZCBkbWN1IEZX
LgozLiBDaGFuZ2UgY2FjaGUgbWVtb3J5IHR5cGUgYmFjayB0byB3cml0ZSBiYWNrLAogICBzaW5j
ZSB3cml0ZSB0aHJvdWdoIGhhcyBpc3N1ZSB3aGVuIHJlc3VtZSBmcm9tIFMwaTMgMTAwJSBoYW5n
IGFmdGVyCiAgIDMuMm1zLgo0LiBDaGFuZ2UgQ1czIGJhc2UgYWRkcmVzcyB0byBoYXJkIGNvZGUg
dmFsdWUgdG8gYXZvaWQgbWVtb3J5IG92ZXJsYXAKICAgd2l0aCBjdzEuCjUuIENoYW5nZSBwb2xs
aW5nIHBoeSBpbml0IGRvbmUgdG8gaW5maW5pdGUgbG9vcCB0byBhdm9pZCBkY24gaGFuZyB3aGVu
CiAgIGRtY3ViIHVDIHN0YWxsZWQuCjYuIEFkZCBkbWN1YiBGVyBkaXMtYXNzZW1ibHkgZmlsZSB0
byByZXBvc2l0YXRvcnkgZm9yIGRlYnVnIHB1cnBvc2UuCgpTaWduZWQtb2ZmLWJ5OiBZb25ncWlh
bmcgU3VuIDx5b25ncWlhbmcuc3VuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxU
b255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNp
cXVlaXJhQGFtZC5jb20+Ci0tLQogLi4uL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfdHJhY2Vf
YnVmZmVyLmggIHwgMjEgKysrKysrKysrKysrKysrKystLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZG11Yi9zcmMvZG11Yl9kY24yMC5jIHwgIDIgKy0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RtdWIvc3JjL2RtdWJfc3J2LmMgICB8IDIwICsrKysrKysrKysrLS0tLS0tLQogMyBmaWxlcyBj
aGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMvZG11Yl90cmFjZV9idWZmZXIuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX3RyYWNlX2J1ZmZlci5o
CmluZGV4IDk3MDc3MDZiYThjZS4uYjBlZTA5OWQ4YTZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMvZG11Yl90cmFjZV9idWZmZXIuaAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMvZG11Yl90cmFjZV9idWZmZXIuaApAQCAt
MzAsOCArMzAsMjUgQEAKICNkZWZpbmUgTE9BRF9ETUNVX0ZXCTEKICNkZWZpbmUgTE9BRF9QSFlf
RlcJMgogCisKK2VudW0gZG11Y2JfdHJhY2VfY29kZSB7CisJRE1DVUJfX1VOS05PV04sCisJRE1D
VUJfX01BSU5fQkVHSU4sCisJRE1DVUJfX1BIWV9JTklUX0JFR0lOLAorCURNQ1VCX19QSFlfRldf
U1JBTV9MT0FEX0JFR0lOLAorCURNQ1VCX19QSFlfRldfU1JBTV9MT0FEX0VORCwKKwlETUNVQl9f
UEhZX0lOSVRfUE9MTF9ET05FLAorCURNQ1VCX19QSFlfSU5JVF9FTkQsCisJRE1DVUJfX0RNQ1Vf
RVJBTV9MT0FEX0JFR0lOLAorCURNQ1VCX19ETUNVX0VSQU1fTE9BRF9FTkQsCisJRE1DVUJfX0RN
Q1VfSVNSX0xPQURfQkVHSU4sCisJRE1DVUJfX0RNQ1VfSVNSX0xPQURfRU5ELAorCURNQ1VCX19N
QUlOX0lETEUsCisJRE1DVUJfX1BFUkZfVFJBQ0UsCit9OworCiBzdHJ1Y3QgZG1jdWJfdHJhY2Vf
YnVmX2VudHJ5IHsKLQl1aW50MzJfdCB0cmFjZV9jb2RlOworCWVudW0gZG11Y2JfdHJhY2VfY29k
ZSB0cmFjZV9jb2RlOwogCXVpbnQzMl90IHRpY2tfY291bnQ7CiAJdWludDMyX3QgcGFyYW0wOwog
CXVpbnQzMl90IHBhcmFtMTsKQEAgLTQwLDYgKzU3LDcgQEAgc3RydWN0IGRtY3ViX3RyYWNlX2J1
Zl9lbnRyeSB7CiAjZGVmaW5lIFRSQUNFX0JVRl9TSVpFICgxMDI0KSAvLzEga0IKICNkZWZpbmUg
UEVSRl9UUkFDRV9NQVhfRU5UUlkgKChUUkFDRV9CVUZfU0laRSAtIDgpL3NpemVvZihzdHJ1Y3Qg
ZG1jdWJfdHJhY2VfYnVmX2VudHJ5KSkKIAorCiBzdHJ1Y3QgZG1jdWJfdHJhY2VfYnVmIHsKIAl1
aW50MzJfdCBlbnRyeV9jb3VudDsKIAl1aW50MzJfdCBjbGtfZnJlcTsKQEAgLTQ3LDUgKzY1LDQg
QEAgc3RydWN0IGRtY3ViX3RyYWNlX2J1ZiB7CiB9OwogCiAKLQogI2VuZGlmIC8qIF9ETVVCX1RS
QUNFX0JVRkZFUl9IXyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RtdWIvc3JjL2RtdWJfZGNuMjAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXVi
L3NyYy9kbXViX2RjbjIwLmMKaW5kZXggODlmZDI3NzU4ZGQ1Li5lMmIyY2YyZTAxZmQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAuYwpA
QCAtMTM4LDUgKzEzOCw1IEBAIGJvb2wgZG11Yl9kY24yMF9pc19zdXBwb3J0ZWQoc3RydWN0IGRt
dWJfc3J2ICpkbXViKQogCiBib29sIGRtdWJfZGNuMjBfaXNfcGh5X2luaXQoc3RydWN0IGRtdWJf
c3J2ICpkbXViKQogewotCXJldHVybiBSRUdfUkVBRChETUNVQl9TQ1JBVENIMTApICE9IDA7CisJ
cmV0dXJuIFJFR19SRUFEKERNQ1VCX1NDUkFUQ0gxMCkgPT0gMDsKIH0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMKaW5kZXggMGRkMzJlZGJiY2Iz
Li41YWUxOTA2ZmYxYjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
bXViL3NyYy9kbXViX3Nydi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXVi
L3NyYy9kbXViX3Nydi5jCkBAIC0yNiw2ICsyNiw4IEBACiAjaW5jbHVkZSAiLi4vaW5jL2RtdWJf
c3J2LmgiCiAjaW5jbHVkZSAiZG11Yl9kY24yMC5oIgogI2luY2x1ZGUgImRtdWJfZGNuMjEuaCIK
KyNpbmNsdWRlICJkbXViX3RyYWNlX2J1ZmZlci5oIgorI2luY2x1ZGUgIm9zX3R5cGVzLmgiCiAv
KgogICogTm90ZTogdGhlIERNVUIgc2VydmljZSBpcyBzdGFuZGFsb25lLiBObyBhZGRpdGlvbmFs
IGhlYWRlcnMgc2hvdWxkIGJlCiAgKiBhZGRlZCBiZWxvdyBvciBhYm92ZSB0aGlzIGxpbmUgdW5s
ZXNzIHRoZXkgcmVzaWRlIHdpdGhpbiB0aGUgRE1VQgpAQCAtNDQsOCArNDYsNiBAQAogLyogTWFp
bGJveCBzaXplICovCiAjZGVmaW5lIERNVUJfTUFJTEJPWF9TSVpFIChETVVCX1JCX1NJWkUpCiAK
LS8qIFRyYWNlYnVmZmVyIHNpemUgKi8KLSNkZWZpbmUgRE1VQl9UUkFDRUJVRkZfU0laRSAoMTAy
NCkgLy8xa0IgYnVmZmVyCiAKIC8qIE51bWJlciBvZiB3aW5kb3dzIGluIHVzZS4gKi8KICNkZWZp
bmUgRE1VQl9OVU1fV0lORE9XUyAoRE1VQl9XSU5ET1dfNV9UUkFDRUJVRkYgKyAxKQpAQCAtNTMs
NiArNTMsNyBAQAogCiAjZGVmaW5lIERNVUJfQ1cwX0JBU0UgKDB4NjAwMDAwMDApCiAjZGVmaW5l
IERNVUJfQ1cxX0JBU0UgKDB4NjEwMDAwMDApCisjZGVmaW5lIERNVUJfQ1czX0JBU0UgKDB4NjMw
MDAwMDApCiAjZGVmaW5lIERNVUJfQ1c1X0JBU0UgKDB4NjUwMDAwMDApCiAKIHN0YXRpYyBpbmxp
bmUgdWludDMyX3QgZG11Yl9hbGlnbih1aW50MzJfdCB2YWwsIHVpbnQzMl90IGZhY3RvcikKQEAg
LTE4MSw3ICsxODIsNyBAQCBkbXViX3Nydl9jYWxjX3JlZ2lvbl9pbmZvKHN0cnVjdCBkbXViX3Ny
diAqZG11YiwKIAltYWlsLT50b3AgPSBtYWlsLT5iYXNlICsgRE1VQl9NQUlMQk9YX1NJWkU7CiAK
IAl0cmFjZV9idWZmLT5iYXNlID0gZG11Yl9hbGlnbihtYWlsLT50b3AsIDI1Nik7Ci0JdHJhY2Vf
YnVmZi0+dG9wID0gdHJhY2VfYnVmZi0+YmFzZSArIERNVUJfVFJBQ0VCVUZGX1NJWkU7CisJdHJh
Y2VfYnVmZi0+dG9wID0gdHJhY2VfYnVmZi0+YmFzZSArIFRSQUNFX0JVRl9TSVpFOwogCiAJb3V0
LT5mYl9zaXplID0gZG11Yl9hbGlnbih0cmFjZV9idWZmLT50b3AsIDQwOTYpOwogCkBAIC0yOTEs
NyArMjkyLDcgQEAgZW51bSBkbXViX3N0YXR1cyBkbXViX3Nydl9od19pbml0KHN0cnVjdCBkbXVi
X3NydiAqZG11YiwKIAkJY3cyLnJlZ2lvbi50b3AgPSBjdzIucmVnaW9uLmJhc2UgKyBkYXRhX2Zi
LT5zaXplOwogCiAJCWN3My5vZmZzZXQucXVhZF9wYXJ0ID0gYmlvc19mYi0+Z3B1X2FkZHI7Ci0J
CWN3My5yZWdpb24uYmFzZSA9IERNVUJfQ1cxX0JBU0UgKyBzdGFja19mYi0+c2l6ZTsKKwkJY3cz
LnJlZ2lvbi5iYXNlID0gRE1VQl9DVzNfQkFTRTsKIAkJY3czLnJlZ2lvbi50b3AgPSBjdzMucmVn
aW9uLmJhc2UgKyBiaW9zX2ZiLT5zaXplOwogCiAJCWN3NC5vZmZzZXQucXVhZF9wYXJ0ID0gbWFp
bF9mYi0+Z3B1X2FkZHI7CkBAIC0zOTQsMTkgKzM5NSwyNCBAQCBlbnVtIGRtdWJfc3RhdHVzIGRt
dWJfc3J2X3dhaXRfZm9yX2F1dG9fbG9hZChzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIsCiBlbnVtIGRt
dWJfc3RhdHVzIGRtdWJfc3J2X3dhaXRfZm9yX3BoeV9pbml0KHN0cnVjdCBkbXViX3NydiAqZG11
YiwKIAkJCQkJICAgIHVpbnQzMl90IHRpbWVvdXRfdXMpCiB7Ci0JdWludDMyX3QgaTsKKwl1aW50
MzJfdCBpID0gMDsKIAogCWlmICghZG11Yi0+aHdfaW5pdCB8fCAhZG11Yi0+aHdfZnVuY3MuaXNf
cGh5X2luaXQpCiAJCXJldHVybiBETVVCX1NUQVRVU19JTlZBTElEOwogCi0JZm9yIChpID0gMDsg
aSA8PSB0aW1lb3V0X3VzOyBpICs9IDEwKSB7CisvKglmb3IgKGkgPSAwOyBpIDw9IHRpbWVvdXRf
dXM7IGkgKz0gMTApIHsKIAkJaWYgKGRtdWItPmh3X2Z1bmNzLmlzX3BoeV9pbml0KGRtdWIpKQog
CQkJcmV0dXJuIERNVUJfU1RBVFVTX09LOwogCiAJCXVkZWxheSgxMCk7CisJfSovCisJd2hpbGUg
KCFkbXViLT5od19mdW5jcy5pc19waHlfaW5pdChkbXViKSkgeworCQlBU1NFUlQoaSA8PSB0aW1l
b3V0X3VzKTsKKwkJaSArPSAxMDsKKwkJdWRlbGF5KDEwKTsKIAl9CiAKLQlyZXR1cm4gRE1VQl9T
VEFUVVNfVElNRU9VVDsKKwlyZXR1cm4gRE1VQl9TVEFUVVNfT0s7CiB9CiAKIGVudW0gZG11Yl9z
dGF0dXMgZG11Yl9zcnZfd2FpdF9mb3JfaWRsZShzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIsCi0tIAoy
LjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
