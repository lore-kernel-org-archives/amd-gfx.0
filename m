Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA79CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C5C2086A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C5C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116C56E2DD;
	Tue, 29 Oct 2019 12:43:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700046.outbound.protection.outlook.com [40.107.70.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322F16E2D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 12:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt9y6kBrKhNFnlvZNrZ53oHuKF6O6n886xt6M3MjTseD47Pk4DKjTJlYZIhtF3mf8BJtfhznfeBtcSsOuUkPSufFzLm66X1wXEnE5rgwMC3gMH2kVuJxJseCZ81MARnKU3gx5jHZywL1hAhJU2KCtdrIn/WPj0h1ixHGwsKsTuNQmQvcv0uKzTBBLy4hnio/96ATdqDpsgRSuRSrgjwo+zBOBCHbp5WH0M+KxgeQ2m0hxYS4WNSUf/6PuhRxDUF82PEuJmr/5q85u+E9CcKlWYPenuCK6Q9mU/bec/IvvEgBxSAM8eNuBo1kqiIf/kXwMJi/6HEf2nFso6itZ5p77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DTHZDblfxeGp6KY1/X8Q5plL2+TjbvgVkfqL5gXnHo=;
 b=BfvlENt8wx5mobpXAklkqBAdKYqD4GUhHueHNUFulcI//xXbSGAC6C3uXlyTZG8DLqSDq9fT2Ygt22rYkQDxm1Ctl4ysy4SOm/F+Entb4lVhIBL/tHGksGFQVxkPsfK4gEzZJ/ClO5Wimqo0JsFgnOqSofFzk90yNbNYQ+JG2gwsGDdGi6Cdksfzt53pi8YvLAU0cmAbqZp1zcwPDriOGN6hX+5/jWJhYIpka90ZI7mUTBPnTpx/tm07j9wMYt6E5k6YuK7NsPRFbk9hDTIPwJ0hPL/3FL6ZeABqFHSYKmwGQOnosU1KGf7hj2qgXtb6+0hGsm1vswsu10FgnZD+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0069.namprd12.prod.outlook.com (2603:10b6:3:103::31)
 by DM6PR12MB3226.namprd12.prod.outlook.com (2603:10b6:5:185::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Tue, 29 Oct
 2019 12:43:01 +0000
Received: from CO1NAM03FT020.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by DM5PR12CA0069.outlook.office365.com
 (2603:10b6:3:103::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.17 via Frontend
 Transport; Tue, 29 Oct 2019 12:43:01 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT020.mail.protection.outlook.com (10.152.80.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Tue, 29 Oct 2019 12:43:01 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 07:43:00 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 07:42:59 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include
Date: Tue, 29 Oct 2019 20:42:56 +0800
Message-ID: <1572352976-22963-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(428003)(189003)(199004)(36756003)(186003)(4326008)(51416003)(476003)(6916009)(2616005)(86362001)(8676002)(47776003)(2351001)(126002)(305945005)(44832011)(486006)(8936002)(81166006)(336012)(81156014)(316002)(16586007)(54906003)(356004)(26005)(50466002)(48376002)(50226002)(70206006)(6666004)(5660300002)(70586007)(426003)(478600001)(4744005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3226; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c52416b-9d08-41ce-023d-08d75c6d88da
X-MS-TrafficTypeDiagnostic: DM6PR12MB3226:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3226207D8A99E45B5102D050F6610@DM6PR12MB3226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSEms4pCGyEIWHMPe9fkmeKsNGU89r9XE2ANrPDrjEc3G3f1V26KR2vN1677FJQ62qNLMJhorTfjs9vcHJWkkW5rQINq+RBtpOXbOtKe/ef3RcmVHIIVwjv7CKGmcykGZU9+CLsGEbInS9yauQuUAKypiRqKWX+sjkupukXJ5HSwAQjQk0x4g5hF9WTXUdvxvmgvJeZpHLk6yueDV2Gh//HIpKigTmIrfcfGZvIIzYo0MVIUn8H5lkf014GcPeI+C9sB9l4RxJgFZ2iMrcYcdqEaUl8u8JNKwJeVFwYW5AuWAZ5hbyqvtJmvSSY+l0WDIAPSBzYbKL9EfcZ2s4j92HEgoGNlTGfdQEOTrZCR+xOvv5jGzhekIFilk9VuN2pIfFiPf0CkvknjLEXaoq8XlPge0Wsi7oW6m7QAz1I3m34JXEw/uNSJ5sWcVYCn0WjN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 12:43:01.1762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c52416b-9d08-41ce-023d-08d75c6d88da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3226
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DTHZDblfxeGp6KY1/X8Q5plL2+TjbvgVkfqL5gXnHo=;
 b=bMN1z83hI5um+a7PoD/Zq/0l+gRgC9y9oh9j1yrRkoZyCBBDpUB5JDq98MxpV7KAnIylaC94y/7wgblPvrCaqN731a7I0Yh4y5dNbrFm/UI/v0/AMdhCqlNTQh50EwXtCFzC/SfYg6IfJ+0aEEMogCgNHXsrcGYs+0mWK66YhZw=
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
Cc: Tom.StDenis@amd.com, Le Ma <le.ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029124256.UlvwmrD-92uXzYEDQmPNzRvsNXfbRP8vqUCKCiw5GCw@z>

Rml4IGNvbXBpbGF0aW9uIGVycm9yLgoKQ2hhbmdlLUlkOiBJNDYxYzU1ODc3OGY5YTUyMzc4MjY5
MzI0ZGM0MWI4ZDYzOWYzY2NiZQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAyICsrCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jCmluZGV4IGZjZTIwNmYuLmJiZTlhYzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMKQEAgLTM0LDYgKzM0LDggQEAKICNpbmNsdWRlICJwc3BfdjExXzAu
aCIKICNpbmNsdWRlICJwc3BfdjEyXzAuaCIKIAorI2luY2x1ZGUgImFtZGdwdV9yYXMuaCIKKwog
c3RhdGljIHZvaWQgcHNwX3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiAK
IHN0YXRpYyBpbnQgcHNwX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
