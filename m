Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D6C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 06:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DA220715
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 06:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DA220715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C7A89F53;
	Mon,  2 Dec 2019 06:04:02 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5BF89F53
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 06:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQbbK9kzR/OOBe/4KMezrjSDCqvHOJy/Spg28MUc5U8dle9/Lq9A1R95pdnEi5cuFLTpklfJb5lE4BqL+9Ju4hazZkRsHQgsKP2A5xJBsmfHc2gavVXxBU1yigzk7ObfLLyOXyVVacPsA1vZidbD7sMUlDSZvEVPQL0r5Bsu3tl1l2buKFYJelchqDQIgblJ8aGFa5Fw0Cs8bPWaq1QlGG7SQYx42LyRsKt5sCfwCoMy6uU7F50S1J3WWebeQOC5HLG0zn1or8Csk7N3EECUeadOUR920i3UDgPLBJtKNCW73cqwzontGQ1CM1fYdcPGh0el4T7yyxqabK7ivbvrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrDT9ODaKCOg51BsC+FoEcUhy3csgdRfYXO03t/vn4I=;
 b=PeiJZmS8zfisQw/ZLLFGJ2NhfevToNZ5jvkzDoWxbqHFkdbgVHJxMAfSMcbxTAmtvyAiL5R6cDFf/quwv55FzxXmvzU5W9IPHVhWcwKaZTjhiwZDsq0JkaGL8Ma9mbGIptKi2s/ihohp6lVRE5KHVRBvisuE/e+PHOsznrQ487SmsH4ZGnZ7ozgRRYK3sKvR4SCl4cG7ElQhPJvLOlFaKe3aHtzPDzQTXrROlTd35E1QXu+dEdSPdGiobHnMPFUHCFBOrvKKMf3iJb99bUOhtrcJT/iO3DUt4PmIEX3/lCWTHuuRB+WSqsNIuU4OCIPV4bceteWt804rDLjEoeQfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR1201CA0009.namprd12.prod.outlook.com
 (2603:10b6:301:4a::19) by MN2PR12MB3069.namprd12.prod.outlook.com
 (2603:10b6:208:c4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Mon, 2 Dec
 2019 06:03:58 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::206) by MWHPR1201CA0009.outlook.office365.com
 (2603:10b6:301:4a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.18 via Frontend
 Transport; Mon, 2 Dec 2019 06:03:58 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 2 Dec 2019 06:03:58 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 00:03:56 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Dec 2019 00:03:54 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Min Frank <Frank.Min@amd.com>, "John
 Clements" <John.Clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: load np fw prior before loading the TAs
Date: Mon, 2 Dec 2019 14:03:37 +0800
Message-ID: <20191202060337.22435-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202060337.22435-1-Hawking.Zhang@amd.com>
References: <20191202060337.22435-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(428003)(199004)(189003)(110136005)(478600001)(16586007)(50226002)(53416004)(48376002)(4326008)(7696005)(186003)(86362001)(51416003)(47776003)(26005)(70586007)(6666004)(356004)(1076003)(6636002)(5660300002)(70206006)(305945005)(316002)(8936002)(76176011)(2906002)(50466002)(8676002)(446003)(11346002)(426003)(2616005)(336012)(36756003)(14444005)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3069; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83ea7f7f-0a8b-4864-b3dc-08d776ed6ba6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3069:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30699349D7D3C7CE704495AAFC430@MN2PR12MB3069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0239D46DB6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jx+pt47GNhzULMuu89VXZ432CruLzd8SWCkQLiWufzuHuAmEDTj13zbbdohyisu0YnJvke3N7ll/JyBH36c3SykIPUQ48HHzeoakMzqmy4MGhxDx5P/PmzxMnWA0Qe8yQrLhRt/Wr3HKXhoEmReZ6w2JlszRv2EBFCeuXPzygdg0CRG9DVQU9/5NmKHxjLrM9dHD89gRcoTjZJ0mBfsl1s66AMqWrVHFjwLVqsQKijClJigGhgjiQ1rIJqMzwX07Sw89A+ZbS6V1SNTr6XSIyPEWqZrVTi3ceUGkmpPtITOxr1GPtmEaHNfE43ltdyUs6C2dHZxamuYzowDqyW4vQ71xiNzBdy3TI3Zh8iDhTRKUzmUzAenvO6YUAegLLE3NMMB2nkoFFCZYOo4l1F/Gb5vTeVrKDQ4Hqo6V9a4Zj1ST652AgWc9iMW2M5kVzgwL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 06:03:58.1188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ea7f7f-0a8b-4864-b3dc-08d776ed6ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrDT9ODaKCOg51BsC+FoEcUhy3csgdRfYXO03t/vn4I=;
 b=uhHSvA5PBAzELNNtlztCKwlJenreoFTYGJudLFegYclFA3gJnbaanFRK0ljreE8WAIyTjFhrb1hfP3vYHQ62K+7mEdFCIh0qtisBbWNlB4APJCivvyN++WTITbleyl5gwknmTuz5KpjPkHEniGWw6u8dcrEsW7sOY7mT7Kerym4=
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGxhdGZvcm0gVEFzIHdpbGwgaW5kZXBlbmRlbnRseSB0b2dnbGUgREYgQ3N0YXRlLgpmb3IgaW5z
dGFuY2UsIGdldC9zZXQgdG9wb2xvZ3kgZnJvbSB4Z21pIHRhLiBkbyBlcnJvcgppbmplY3Rpb24g
ZnJvbSByYXMgdGEuIEluIHN1Y2ggY2FzZSwgUE1GVyBuZWVkcyB0byBiZQpsb2FkZWQgYmVmb3Jl
IFRBcyBzbyB0aGF0IGFsbCB0aGUgc3Vic2VxdWVudCBDc3RhdGUKY2FsbHMgcmVjaWV2ZWQgYnkg
UFNQIEZXIGNhbiBiZSByb3V0ZWQgdG8gUE1GVy4KCkNoYW5nZS1JZDogSTgzZGIxYTIyNTc3YTg0
YWU2NDdlN2U1NzBjMjAwMDU3NjUwMDk2YzUKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYyB8IDY2ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAzMyBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMKaW5kZXggMGU4OTA3MTc5ZTA3Li5jZWVhODMxNGQ4OGQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTEyMTgsMzkgKzEyMTgsNiBA
QCBzdGF0aWMgaW50IHBzcF9od19zdGFydChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAkJcmV0
dXJuIHJldDsKIAl9CiAKLQlyZXQgPSBwc3BfYXNkX2xvYWQocHNwKTsKLQlpZiAocmV0KSB7Ci0J
CURSTV9FUlJPUigiUFNQIGxvYWQgYXNkIGZhaWxlZCFcbiIpOwotCQlyZXR1cm4gcmV0OwotCX0K
LQotCWlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7Ci0JCXJldCA9
IHBzcF94Z21pX2luaXRpYWxpemUocHNwKTsKLQkJLyogV2FybmluZyB0aGUgWEdNSSBzZWVzaW9u
IGluaXRpYWxpemUgZmFpbHVyZQotCQkgKiBJbnN0ZWFkIG9mIHN0b3AgZHJpdmVyIGluaXRpYWxp
emF0aW9uCi0JCSAqLwotCQlpZiAocmV0KQotCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKLQkJ
CQkiWEdNSTogRmFpbGVkIHRvIGluaXRpYWxpemUgWEdNSSBzZXNzaW9uXG4iKTsKLQl9Ci0KLQlp
ZiAocHNwLT5hZGV2LT5wc3AudGFfZncpIHsKLQkJcmV0ID0gcHNwX3Jhc19pbml0aWFsaXplKHBz
cCk7Ci0JCWlmIChyZXQpCi0JCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LAotCQkJCQkiUkFTOiBG
YWlsZWQgdG8gaW5pdGlhbGl6ZSBSQVNcbiIpOwotCi0JCXJldCA9IHBzcF9oZGNwX2luaXRpYWxp
emUocHNwKTsKLQkJaWYgKHJldCkKLQkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCi0JCQkJIkhE
Q1A6IEZhaWxlZCB0byBpbml0aWFsaXplIEhEQ1BcbiIpOwotCi0JCXJldCA9IHBzcF9kdG1faW5p
dGlhbGl6ZShwc3ApOwotCQlpZiAocmV0KQotCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKLQkJ
CQkiRFRNOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBEVE1cbiIpOwotCX0KLQogCXJldHVybiAwOwog
fQogCkBAIC0xNTYwLDYgKzE1MjcsMzkgQEAgc3RhdGljIGludCBwc3BfbG9hZF9mdyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAocmV0KQogCQlnb3RvIGZhaWxlZDsKIAorCXJldCA9
IHBzcF9hc2RfbG9hZChwc3ApOworCWlmIChyZXQpIHsKKwkJRFJNX0VSUk9SKCJQU1AgbG9hZCBh
c2QgZmFpbGVkIVxuIik7CisJCXJldHVybiByZXQ7CisJfQorCisJaWYgKGFkZXYtPmdtYy54Z21p
Lm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsKKwkJcmV0ID0gcHNwX3hnbWlfaW5pdGlhbGl6ZShw
c3ApOworCQkvKiBXYXJuaW5nIHRoZSBYR01JIHNlZXNpb24gaW5pdGlhbGl6ZSBmYWlsdXJlCisJ
CSAqIEluc3RlYWQgb2Ygc3RvcCBkcml2ZXIgaW5pdGlhbGl6YXRpb24KKwkJICovCisJCWlmIChy
ZXQpCisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LAorCQkJCSJYR01JOiBGYWlsZWQgdG8gaW5p
dGlhbGl6ZSBYR01JIHNlc3Npb25cbiIpOworCX0KKworCWlmIChwc3AtPmFkZXYtPnBzcC50YV9m
dykgeworCQlyZXQgPSBwc3BfcmFzX2luaXRpYWxpemUocHNwKTsKKwkJaWYgKHJldCkKKwkJCWRl
dl9lcnIocHNwLT5hZGV2LT5kZXYsCisJCQkJCSJSQVM6IEZhaWxlZCB0byBpbml0aWFsaXplIFJB
U1xuIik7CisKKwkJcmV0ID0gcHNwX2hkY3BfaW5pdGlhbGl6ZShwc3ApOworCQlpZiAocmV0KQor
CQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKKwkJCQkiSERDUDogRmFpbGVkIHRvIGluaXRpYWxp
emUgSERDUFxuIik7CisKKwkJcmV0ID0gcHNwX2R0bV9pbml0aWFsaXplKHBzcCk7CisJCWlmIChy
ZXQpCisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LAorCQkJCSJEVE06IEZhaWxlZCB0byBpbml0
aWFsaXplIERUTVxuIik7CisJfQorCiAJcmV0dXJuIDA7CiAKIGZhaWxlZDoKLS0gCjIuMTcuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
