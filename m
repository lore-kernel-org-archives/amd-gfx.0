Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F30CC4167B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D2522AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D2522AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852F26E862;
	Sat, 12 Dec 2020 15:46:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9264B6E861
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkkbgZDTlp6F1PFtkzgQLwd7pVlLt7e2AblrFnLsDpjtI+fpQ9DaPZXjXpgTdkOfnJvOuHMydpUSIqdZxneSQIDudB4SBltHekX5QxZHL4UEsbV+BCOCdfkFitXTECb2f6s9wCMNscmMeh3ikNoMebuevb/UAkt+OrMsKon9VATau/I1+DCb/ycTSmGxbOrjs5caIZ5CR8Ri+HbeNsJEKxfmi7FdA7bfA6Wl+WA+FcXNJ4SbaOIfNqUEmwHjH4NNaHQQXPdIpzsoxRSmJ0KwFth6rbhR5ddx/6Vwd0U+606SU/6djoPbPQUsK0NTqBQ2dr7qGkMOeMzs93RaXoHspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0+uVFqTwFSeRYw0izCSduUMD/KUp8vY4LRyfgY3zEs=;
 b=El9R6PU2NFl7yNe3xJ3avMOJuaRl94dGyyte3wLaCK43Ut6Y3NGt/7KXnu8TDZmkUCww2ZUHAZOjkC4RrurTxhCCU+lVPzZFiM8HGplu5BMxr4RUEuqEYEd2UzqfQgcdi2r350Oed0xNgkyOZyJVESqWFa960SXStV4Nfy3+8XXbU9vgkJ3MhAElFoWzBzQAlOpmNgEe8HF/IOwveIMcZj6KWKsqDz6QHYjM6ODGETB3VfApbOLvXBIxJm72P05yGhDNqwImAn3zSDoyjKO55feCvqB90sPs/m+VwotmpRAiKqweymRAx7f8ABegYkB2JRQHV9UlY8QVNiPNLec67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0+uVFqTwFSeRYw0izCSduUMD/KUp8vY4LRyfgY3zEs=;
 b=vGYlziwk3l1Ss9edEjI05sNpwiYUPn3Cqa4vv6bMhny/8LwHJoDOLSGrtJ45Xl9K2jNMGYAZpUmrvA223ivv6NRPx9wB7pWPqQUBtcZS2Elanl3onrbJFYzFp18SeJ01tKaDuRPyakWBqiyWpNrUR4tIOBUfxrPiF2THZE95axY=
Received: from BN3PR03CA0075.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::35) by DM5PR12MB1481.namprd12.prod.outlook.com
 (2603:10b6:4:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Sat, 12 Dec
 2020 15:46:20 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:7a4d:cafe::d2) by BN3PR03CA0075.outlook.office365.com
 (2a01:111:e400:7a4d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:19 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:18 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:16 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 04/27] drm/amdgpu: add helper to toggle ih ring interrupts for
 vega10
Date: Sat, 12 Dec 2020 23:45:37 +0800
Message-ID: <20201212154600.21618-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccfde470-c05a-4b4b-961e-08d89eb511a0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1481:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1481B5B29C2F2B489BA0220DFCC90@DM5PR12MB1481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+3CASAj7iTjXwuNZFVsd451wuhMqi4gJdvn1d6WsVp4UGCiOppPhcAtR1/lsklEDcIlH88EXvBir88iBtg6+96o5+qDFTvKDOnTyHF43zp2rDb5MFq3HeWQG0KoLEIZf/OCIBqGZ/39NUReZiaSNp0dVTb09T96v4ZAr8keC/i9ND4xYi6LU4QX+bqkpXeojy3tm3/XD7vkyiGKda8hAeuFpswMdmRzbkct016hGEp8iFJLCfSSbkdCjDZgEEDizn0LqA5dp/M116Yzl5V4/XC9pECeTPYIMgPZjN/ISB8gVFChWAh0EcGO1Q7HoBAZq3ObBDlXIUrXO0JrC7qCAugOquLR6XlenXonBULzgYRp7zFEH0O34C97IZl4yekemlfgSW/4WVxBYb/KHTVScA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(46966005)(186003)(83380400001)(356005)(82310400003)(5660300002)(47076004)(81166007)(70586007)(8936002)(6666004)(66574015)(2616005)(36756003)(7696005)(426003)(2906002)(86362001)(70206006)(110136005)(26005)(508600001)(6636002)(336012)(1076003)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:19.4491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfde470-c05a-4b4b-961e-08d89eb511a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1481
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

dmVnYTEwX2loX3RvZ2dsZV9yaW5nX2ludGVycnVwdHMgd2lsbCBiZSB1c2VkIHRvCmVuYWJsZS9k
aXNhYmxlIGFuIGloIHJpbmcgaW50ZXJydXB0cyBmb3IgdmVnYTEwLzEyLApSQVZFTiBzZXJpZXMg
YW5kIFJFTk9JUiBBUFVzCgpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KUmV2aWV3ZWQtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+ClJldmlld2Vk
LWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
ZWdhMTBfaWguYwppbmRleCA0MmU3ODk3ZjJiYmMuLmZhNGM0OTAyMjlhNCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKQEAgLTIxMyw2ICsyMTMsNTEgQEAgc3RhdGljIHZv
aWQgdmVnYTEwX2loX2Rpc2FibGVfaW50ZXJydXB0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAl9CiB9CiAKKy8qKgorICogdmVnYTEwX2loX3RvZ2dsZV9yaW5nX2ludGVycnVwdHMgLSB0
b2dnbGUgdGhlIGludGVycnVwdCByaW5nIGJ1ZmZlcgorICoKKyAqIEBhZGV2OiBhbWRncHVfZGV2
aWNlIHBvaW50ZXIKKyAqIEBpaDogYW1kZ3B1X2loX3JpbmcgcG9pbnRldAorICogQGVuYWJsZTog
dHJ1ZSAtIGVuYWJsZSB0aGUgaW50ZXJydXB0cywgZmFsc2UgLSBkaXNhYmxlIHRoZSBpbnRlcnJ1
cHRzCisgKgorICogVG9nZ2xlIHRoZSBpbnRlcnJ1cHQgcmluZyBidWZmZXIgKFZFR0ExMCkKKyAq
Lworc3RhdGljIGludCB2ZWdhMTBfaWhfdG9nZ2xlX3JpbmdfaW50ZXJydXB0cyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKKwkJCQkJICAgIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgsCisJ
CQkJCSAgICBib29sIGVuYWJsZSkKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2loX3JlZ3MgKmloX3JlZ3M7
CisJdWludDMyX3QgdG1wOworCisJaWhfcmVncyA9ICZpaC0+aWhfcmVnczsKKworCXRtcCA9IFJS
RUczMihpaF9yZWdzLT5paF9yYl9jbnRsKTsKKwl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhf
UkJfQ05UTCwgUkJfRU5BQkxFLCAoZW5hYmxlID8gMSA6IDApKTsKKwkvKiBlbmFibGVfaW50ciBm
aWVsZCBpcyBvbmx5IHZhbGlkIGluIHJpbmcwICovCisJaWYgKGloID09ICZhZGV2LT5pcnEuaWgp
CisJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9SQl9DTlRMLCBFTkFCTEVfSU5UUiwgKGVu
YWJsZSA/IDEgOiAwKSk7CisJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgeworCQlpZiAocHNw
X3JlZ19wcm9ncmFtKCZhZGV2LT5wc3AsIGloX3JlZ3MtPnBzcF9yZWdfaWQsIHRtcCkpIHsKKwkJ
CWRldl9lcnIoYWRldi0+ZGV2LCAiUFNQIHByb2dyYW0gSUhfUkJfQ05UTCBmYWlsZWQhXG4iKTsK
KwkJCXJldHVybiAtRVRJTUVET1VUOworCQl9CisJfSBlbHNlIHsKKwkJV1JFRzMyKGloX3JlZ3Mt
PmloX3JiX2NudGwsIHRtcCk7CisJfQorCisJaWYgKGVuYWJsZSkgeworCQlpaC0+ZW5hYmxlZCA9
IHRydWU7CisJfSBlbHNlIHsKKwkJLyogc2V0IHJwdHIsIHdwdHIgdG8gMCAqLworCQlXUkVHMzIo
aWhfcmVncy0+aWhfcmJfcnB0ciwgMCk7CisJCVdSRUczMihpaF9yZWdzLT5paF9yYl93cHRyLCAw
KTsKKwkJaWgtPmVuYWJsZWQgPSBmYWxzZTsKKwkJaWgtPnJwdHIgPSAwOworCX0KKworCXJldHVy
biAwOworfQorCiBzdGF0aWMgdWludDMyX3QgdmVnYTEwX2loX3JiX2NudGwoc3RydWN0IGFtZGdw
dV9paF9yaW5nICppaCwgdWludDMyX3QgaWhfcmJfY250bCkKIHsKIAlpbnQgcmJfYnVmc3ogPSBv
cmRlcl9iYXNlXzIoaWgtPnJpbmdfc2l6ZSAvIDQpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
