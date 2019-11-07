Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A090DC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFFA206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFFA206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C936F733;
	Thu,  7 Nov 2019 15:56:55 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4EF6F73B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 15:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edUnbzgUWS0t8F+aAwxrpexEm4SXMKEeX8zaVbPQSRHNg+nyfZAuYMOi9bdg425bWN+JHBYsWWxvkSJIS9d1RzqSlc/PqOMuVFOxONZya/PWqkcbwGPLvx900CS5IbA7iYDjoMu/FxFYwg6JPtIKtb6snc+Qyki52UpKMTwqZRv4fp6AiH/DM79Jo52gnGSjdzozHGjAR2Sauf8exEKYOe9y+CG90VJ6/3nwE8X7TXAlPlee87voF2VmljJa09AxLBckJLakfzzxGRXuS4MGKjmFkG5NJFZpL6YNQ09aZK/PMnfb9oCe1jdPaJATTX8pBY3U1xfRGfxR5EWzcAhHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O+eY4JhFJtLzAjpfGmkrm1w6bJzqx9WQd4sLlwzVnM=;
 b=Q4iyKutOe3hw84z3m9T2OZjp9sqz0ko1RXvfYIN9LSkzQqnnLaCE9+GaaIkm6PTvFxW8Bb7sW75Bx8UTipsy0Eda7hzZDJo+OIj3tBIZTsx0DfggiR/uv44kdA4ivnJRTHb6XVA8lecW8c9OE6lZ7nD3Urw8TxVRzi4k8dUkJdpVYmauONV6//qbLRpMWwfZLl0m8nPrxPN322t0l+/2XE4JUt6osf8h1+V0qhIbaBfnRKUkufM7OXneoYS/GLhuVxaThwJ8/F0Vz+Ig2umM6SeVJtIsmyjAhCqBIWHQyLyRFlyUQR8ZQcIkOZ9ivmGxeZcCCaKXMLjjkMpYYridIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:60::30)
 by MWHPR12MB1245.namprd12.prod.outlook.com (2603:10b6:300:13::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Thu, 7 Nov
 2019 15:56:46 +0000
Received: from DM3NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::203) by BN8PR12CA0017.outlook.office365.com
 (2603:10b6:408:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Thu, 7 Nov 2019 15:56:45 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT025.mail.protection.outlook.com (10.152.82.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 15:56:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 09:56:43 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 09:56:43 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 09:56:43 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: Change ERROR to WARN for HDCP module
Date: Thu, 7 Nov 2019 10:56:19 -0500
Message-ID: <20191107155628.19446-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
References: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(428003)(189003)(199004)(486006)(2616005)(478600001)(11346002)(476003)(126002)(186003)(48376002)(6916009)(81156014)(446003)(336012)(14444005)(51416003)(50466002)(50226002)(2906002)(76176011)(426003)(7696005)(26005)(8936002)(4326008)(8676002)(36756003)(2351001)(5660300002)(86362001)(305945005)(81166006)(16586007)(70206006)(70586007)(316002)(53416004)(54906003)(356004)(47776003)(6666004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1245; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d84dde74-f6f0-49d4-525e-08d7639b173e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1245:
X-Microsoft-Antispam-PRVS: <MWHPR12MB12458CA41D36DB3D47828C0EF9780@MWHPR12MB1245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t98pSqm7tVg0bY1gV2pEujyOXnlGmcaHf0RrJE606psE+JVrdc+4g5vkGcQQD/K1rvMvDLilfu/+Y0e2sfHSLIbkzOvtT2zTFGoWUBmzpvFJ4rYF0j2eC9pamawB+C94MUV3m6MvOFUEstOvdjSsRBFQG3d0xHGBiQRAYSCUa1+UG3iJ7lclnkF3mP6St6YPhhBqbkQcFViqNIhV2xtYmvFuFtoxN7SqIgQ8uGsDdjdx/rDnaoEYRBgtryXusLmW8AZ8yDPh/ija9T68wNXq0fYcPKMcwB7KQRYUak+wnZDh57w68lTSKZRQfTtg9ogGHWyT/lmnyqWxL0rHpUPv8N0WqV/a/5NH6+Hq/htlpXVEOAdP78bm6tl8jFLvlYCat+bz7FpF1V5uoRX0dr9eJZ3jl3XTepxtBJJWPfmlsuJOZlEf/eOSjtpepzRd3GJ5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:56:45.6404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84dde74-f6f0-49d4-525e-08d7639b173e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1245
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O+eY4JhFJtLzAjpfGmkrm1w6bJzqx9WQd4sLlwzVnM=;
 b=zHuu990m3ONXxSae6auK2vnwo+unNbB5tvRdmUUpcK02NLhpHh01PWzh8HyCo1jozahNyjbMImVOKKLj1Jf/x1b+bgXmWqjnwNvfmYdfe7sfTS3DaCtBQ2FzO0b0amqkAx/LO0eIzDHTPbU4cMUSjGfze9nu7FkOTWYSFpy7db4=
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Wenjing.Liu@amd.com,
 harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107155619.ZFWYpz2t5yQGZDuvVKAbDLWRcmiBrtfCV1q5D2vmvl0@z>

W1doeV0KSERDUCBpcyBhIGJpdCBmaW5pY2t5IHNvIHdlIHRyeSBpdCAzIHRpbWVzLCB0aGlzIGxl
YWRzIHRvIGEgY2FzZSB3aGVyZQppZiB3ZSBmYWlsIHRoZSBmaXJzdCB0aW1lIGFuZCBwYXNzIHRo
ZSBzZWNvbmQgdGltZSB0aGUgZXJyb3IgaXMgc3RpbGwKc2hvd24gaW4gZG1lc2cgZm9yIHRoZSBm
aXJzdCBmYWlsZWQgYXR0ZW1wdC4KClRoaXMgbGVhZHMgdG8gZmFsc2UgcG9zaXRpdmUgZXJyb3Jz
LgoKW0hvd10KQ2hhbmdlIHRoZSBsb2dnaW5nIGZyb20gRVJST1IgdG8gV0FSTklORy4gV2Fybmlu
Z3MgYXJlIHN0aWxsIHNob3duIGluIGRtZXNnCnRvIGtub3cgd2hhdCB3ZW50IHdyb25nLgoKU2ln
bmVkLW9mZi1ieTogQmhhd2FucHJlZXQgTGFraGEgPEJoYXdhbnByZWV0Lkxha2hhQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX2xvZy5o
IHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3Av
aGRjcF9sb2cuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRj
cF9sb2cuaAppbmRleCBiMjkzMjJlN2Q1ZmUuLmZmOTEzNzNlYmFkYSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX2xvZy5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9sb2cuaApAQCAtMjcs
NyArMjcsNyBAQAogI2RlZmluZSBNT0RfSERDUF9MT0dfSF8KIAogI2lmZGVmIENPTkZJR19EUk1f
QU1EX0RDX0hEQ1AKLSNkZWZpbmUgSERDUF9MT0dfRVJSKGhkY3AsIC4uLikgRFJNX0VSUk9SKF9f
VkFfQVJHU19fKQorI2RlZmluZSBIRENQX0xPR19FUlIoaGRjcCwgLi4uKSBEUk1fV0FSTihfX1ZB
X0FSR1NfXykKICNkZWZpbmUgSERDUF9MT0dfVkVSKGhkY3AsIC4uLikgRFJNX0RFQlVHX0tNUyhf
X1ZBX0FSR1NfXykKICNkZWZpbmUgSERDUF9MT0dfRlNNKGhkY3AsIC4uLikgRFJNX0RFQlVHX0tN
UyhfX1ZBX0FSR1NfXykKICNkZWZpbmUgSERDUF9MT0dfVE9QKGhkY3AsIC4uLikgcHJfZGVidWco
IltIRENQX1RPUF06Il9fVkFfQVJHU19fKQpAQCAtMzcsNyArMzcsNyBAQAogLyogZGVmYXVsdCBs
b2dzICovCiAjZGVmaW5lIEhEQ1BfRVJST1JfVFJBQ0UoaGRjcCwgc3RhdHVzKSBcCiAJCUhEQ1Bf
TE9HX0VSUihoZGNwLCBcCi0JCQkiW0xpbmsgJWRdIEVSUk9SICVzIElOIFNUQVRFICVzIiwgXAor
CQkJIltMaW5rICVkXSBXQVJOSU5HICVzIElOIFNUQVRFICVzIiwgXAogCQkJaGRjcC0+Y29uZmln
LmluZGV4LCBcCiAJCQltb2RfaGRjcF9zdGF0dXNfdG9fc3RyKHN0YXR1cyksIFwKIAkJCW1vZF9o
ZGNwX3N0YXRlX2lkX3RvX3N0cihoZGNwLT5zdGF0ZS5pZCkpCi0tIAoyLjE3LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
