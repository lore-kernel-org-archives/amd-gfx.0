Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A7DCA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB3E2084C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB3E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DC36E986;
	Fri, 25 Oct 2019 11:06:58 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720077.outbound.protection.outlook.com [40.107.72.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B656E986
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2019 11:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msD5XYWAM8b4X1acsuVHvamFaUE/PVquvk3LJZW/Xt3c8CGW3mba8eH3sgqv5ZD3rFllOHVBZSP0UJXaUkxw9DQH2XY3hKW+OvwV0/Oadt9VUbbTv3sZFUGavhowCvWcJoNgE7yHwNTascDNtF1TWt4hPRe6++3p7VVLSDFbhia+r7OM9bg1TqjJ0c/YnDquJUNje9TDcSA06gr30w3Up2wxHK8Ljs5puqoaRwNT1UEryBpffLQv0h/omjDthat1DWqlFK2lLnAYYOiDtoSqHK2L4Bbz08rpRgNvBHoVH1dlbXfNkkJTjKUP8SsSiIDUEtsYULXIvvmKMJ/pjqaMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXn7y0EaroefhbbcVZycNR8zQbe/g5xht1zJp5uBLGU=;
 b=mk0AIptiIhhSWu3c16Pg8dgByT9JW3Jpiq5907EbumnBRi73mKBxnqX3oyjg/Bxt/vHb4YtbObV01kIgNlcZLzaTmOiKsKtXNuVPAw36KrXPPRXpdkNm64v90XAFaZPSRdlwI7d6YyUN2u2RlLNxKa0Khp/LBlJuMb2H6SKjlOnsAyEXXweb88LkrUSw9bDDG8btqlP7/LSkt8OYPVlf3JLPTbc/SgxLsLUVwDfdi0GXkiZdhhWpJgQPanPKK/LDFcNRR9JLFK/6lMzj7YGhe6zHHp/S6+tRQZhXB+ccdJ/RsShgNsIlukVU2sf/nRNhoNWGOboGWmt9cdiill21tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:910:16::15) by CY4PR12MB1767.namprd12.prod.outlook.com
 (2603:10b6:903:121::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Fri, 25 Oct
 2019 11:06:55 +0000
Received: from BY2NAM03FT003.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::204) by CY4PR1201CA0005.outlook.office365.com
 (2603:10b6:910:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Fri, 25 Oct 2019 11:06:55 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BY2NAM03FT003.mail.protection.outlook.com (10.152.84.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Fri, 25 Oct 2019 11:06:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 25 Oct
 2019 06:06:54 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 25 Oct
 2019 06:06:54 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 25 Oct 2019 06:06:53 -0500
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Date: Fri, 25 Oct 2019 19:06:50 +0800
Message-ID: <1572001610-9599-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(428003)(199004)(189003)(8936002)(50226002)(2906002)(36756003)(7696005)(51416003)(48376002)(50466002)(336012)(2616005)(486006)(26005)(126002)(186003)(53416004)(70206006)(5660300002)(4744005)(2351001)(305945005)(14444005)(86362001)(70586007)(426003)(356004)(81166006)(316002)(16586007)(81156014)(478600001)(4326008)(6916009)(47776003)(476003)(15650500001)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1767; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ed7d0c6-89f7-43e1-d6b0-08d7593b725a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1767:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17677276FA6DFD81DD7916D39D650@CY4PR12MB1767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-Forefront-PRVS: 02015246A9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANcNJFFYKqQB4OQgu2YtkyFB2C93O/a8pyiupzkref02u/mwxqmaHww08bBdP2Mb5CWyjf4BDCfBpIKhgrDdRWhisCH/Ra4ZReSuzp+5xBHJSLGjHExxvcda6HbrfxcG8Zr09jM2JN9pH4rN7fz+WoRRNx/qEm/How0I7fmA2QMIiSh6mGDu6Wj2kSi/Yc/QBxfmcoIPI8dVM6ocrFYMTCMPaD68hfOs+TgBgNtZ79AGbVxWuq+vX1HSAHAORcYfwGaKeWtc8pToCIsM79WKkioXBKQcMagb3yIqlGn/0Dig+EiGcflwxmd/alAGq29xdZK9OkHMnvdz48KiTqRLXEo1tkKiq6Xhpt8RS6uJWDxr43a4MiZ1S6R13ozMPr4W1/0k42s5EFxU3AnOzdrSBYTibPE4etUSc1stE7AqQ5ro9lfzLEpUAvjVFwev5HRx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2019 11:06:55.1421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed7d0c6-89f7-43e1-d6b0-08d7593b725a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1767
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXn7y0EaroefhbbcVZycNR8zQbe/g5xht1zJp5uBLGU=;
 b=VSqi45GzPaYEp76QBJl7KyuVjDoE5DOB7/XQAt6mkCP3WBfEOtwwKEyXGOMhm0sMhsbUlfHVZQaegi7mc3o7jxKNaeBf+gmW8sHXhBFKAW3GYTFw7zdhqth4UvRO4LQatft19eH+/EJliPNETpxIPs9IrRuUYfYTx9YtfzHLtnw=
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025110650.FEU1xpoIBvQSlUQqz6Il0D5dPSKtB-VWz87mbCTlQdI@z>

aWYgbm8gZGlzYWJsZSBnZnggQ0dQRyB3aGVuIHN1c3BlbmQgc211LCBlbmFibGluZyBnZnggQ0dQ
RyB3aWxsIGZhaWwgd2hlbiByZXN1bWUgc211LgoKUGxhdGZvcm06IFJlbm9pcgpkbWVzZyBsb2cg
aW5mb3JtYXRpb246CgpbICAxNTEuODQ0MTEwIF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBTTVUgaXMg
cmVzdW1pbmcuLi4KWyAgMTUxLjg0NDExNiBdIGFtZGdwdTogW3Bvd2VycGxheV0gZHBtIGhhcyBi
ZWVuIGRpc2FibGVkClsgIDE1MS44NDQ2MDQgXSBhbWRncHU6IFtwb3dlcnBsYXldIEZhaWxlZCB0
byBzZW5kIG1lc3NhZ2UgMHgyZixyZXNwb25zZSAweGZmZmZmZmZiIHBhcmFtIDB4MQpbICAxNTEu
ODQ0NjA1IF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBTTVUgaXMgcmVzdW1lZCBzdWNjZXNzZnVsbHkh
CgpTaWduZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5LmdvbmdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1k
Z3B1X3NtdS5jCmluZGV4IDI2OTIzYWEuLjRlNDY4YjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRncHVfc211LmMKQEAgLTEzNTEsNiArMTM1MSw4IEBAIHN0YXRpYyBpbnQg
c211X3N1c3BlbmQodm9pZCAqaGFuZGxlKQogCWlmIChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9O
QVZJMTAgJiYKIAkgICAgYWRldi0+Z2Z4LnJsYy5mdW5jcy0+c3RvcCkKIAkJYWRldi0+Z2Z4LnJs
Yy5mdW5jcy0+c3RvcChhZGV2KTsKKwlpZiAoc211LT5pc19hcHUpCisJCXNtdV9zZXRfZ2Z4X2Nn
cGcoJmFkZXYtPnNtdSwgZmFsc2UpOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
