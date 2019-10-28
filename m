Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B8ACA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409EC20659
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409EC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076376E8B6;
	Mon, 28 Oct 2019 14:09:06 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720074.outbound.protection.outlook.com [40.107.72.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E503F6E8B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAZE8XFahFtfUQAaRQv3sFxZlzeppwgW+CABdTWgs+ssT45ORM3c1qjGh6GTPb1KLU08GNE0HXOWjmeawyfDhUf+N/HF254R04EBTBFcO6Jqcl5TaybQFzMmf0ABa0TLcUMEIP/KzoMXEMGQ7UkIPwrOTSuuUAQdxD7NSqraUznwdxxDbmBaNesSmKVzluENxLhakWIW6wi2qRlJRSJT4Ga+4zmOaO0oycVHjMjlwHkIWt8FN3xSGlxXDRVwAZgwAAyBzVLk643SJgtoefpNgHiqSHlcqIWOTqB6G8Tuq2N47ZHF9tEdxkgSF28UmOJU3ev6ulASrAo0Hlfv+DiJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7tDUl5B+JMlpFEbnJjyQPsUA+tri2L3xRSTe2wD7LM=;
 b=j4a15YSqgC00Ovzy946AhFt/f58HKMrq2enLg6KJjbmu4uNVwNkI6rBcQuuQwnyrVLc+h9cdib0e/a66kOmD6f5iAsOtCpXtOrkfbTlQBI/BmSw6O25S3V0av9TdCSUPw9sW0TCcVWxNjcsnsJFziNgTOd1hHVBZxZBc+q2DwLhnBruUIlxy3ZOZptSNPAdBoTUkZY058f6+WqJWlRnbpgYC8LfYBLtYdHU8v8buIKUy9/hTmk1/QjWyMfqAHnVJzuuP4UvLgg3kUpaWWXBnhBvZWpyu/Z3NiZY88QaW9P0GoVtEigxfBPpIGp6wmrRg/8YLDrnBpNZS3R9EHUWKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0065.namprd12.prod.outlook.com (2603:10b6:0:56::33) by
 DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 14:09:00 +0000
Received: from BY2NAM03FT063.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::201) by DM3PR12CA0065.outlook.office365.com
 (2603:10b6:0:56::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Mon, 28 Oct 2019 14:09:00 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BY2NAM03FT063.mail.protection.outlook.com (10.152.85.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 14:08:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:58 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:58 -0500
Received: from kazvm.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 09:08:57 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amdgpu: Add DMCUB to firmware query interface
Date: Mon, 28 Oct 2019 10:08:34 -0400
Message-ID: <20191028140837.7908-9-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
References: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(428003)(199004)(189003)(6666004)(356004)(86362001)(316002)(4326008)(305945005)(126002)(336012)(11346002)(446003)(2616005)(8676002)(486006)(44832011)(6916009)(476003)(2351001)(426003)(53416004)(81166006)(81156014)(47776003)(36756003)(478600001)(70206006)(26005)(50226002)(2906002)(8936002)(76176011)(7696005)(51416003)(186003)(2870700001)(5660300002)(50466002)(1076003)(48376002)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4266; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76808ff8-4ef4-49e1-1dcb-08d75bb0612f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426677AA1D5C983903BF0126EC660@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtaWiF4KRsK6C8tVk9W91w0fMAZ/cEt/Pp6wNgd3KmhKB4Wx4TiUXw8VXp0UT5dflL64UOTGUsjt1wcr5lBft5Vm3FhItAsdSIsT0Gt/mzWVfv28yTMa0tzliXoKcrJK3wz+28oDvc+OWhx2EkP7M21ARu0Wnriw3Qb5jx6TSEnwcFf2yRY9NtFu+tFXhqlFAB1athUviUZ6tK4YkF7TKxnVyMZsqgvyswCMj6NYNSP3PRD/iupqya71k/yHChdfQmg4wDKV1nqakyoDWDB5CO4AVBbL5M/s1yHySOZ48fSX+sWCWeXecO0KMF4/sZzRr4mNesIQdulSHoILX58JQ3QVflFx/ICeAAw+B0t9Uxv0O/J20ezaPQoru4JWV8J2WRDYsagjqw06vjhBihBalWfBwvQd1CP4gfweQzH1j8dzWyzQHXAA0zviHtIQdyOd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 14:08:59.7742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76808ff8-4ef4-49e1-1dcb-08d75bb0612f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7tDUl5B+JMlpFEbnJjyQPsUA+tri2L3xRSTe2wD7LM=;
 b=dHqr+HfEegohs+IeRuHzwCDLp5Cuk6xRk3Dk/PXR5UFsMsGTM76klmOLE/V3S2N9J3GB0AwWw7yXrcwgAzaFudL81077dxXUmw4PMAnQadQSPBdThb5eApLH/lTuCO2SV/I56qDPaB8nBfm/rUjjatVKdvowXx+auZnn5uTIM3s=
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
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140834.R33I1GybXWneQqCP_U2VBuNWO3qwk7kz03uaXlrZ0uU@z>

VGhlIERNQ1VCIGZpcm13YXJlIHZlcnNpb24gY2FuIGJlIHJlYWQgdXNpbmcgdGhlIEFNREdQVV9J
TkZPIGlvY3RsCm9yIHRoZSBhbWRncHVfZmlybXdhcmVfaW5mbyBkZWJ1Z2ZzIGVudHJ5LgoKU2ln
bmVkLW9mZi1ieTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDEyICsr
KysrKysrKysrKwogaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggICAgICAgICAgIHwgIDMg
KysrCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfa21zLmMKaW5kZXggZTM2MzI4MjViYmMyLi4xZmYwMjAyYTkwMGQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKQEAgLTI5NCw2ICsyOTQsMTAg
QEAgc3RhdGljIGludCBhbWRncHVfZmlybXdhcmVfaW5mbyhzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZv
X2Zpcm13YXJlICpmd19pbmZvLAogCQlmd19pbmZvLT52ZXIgPSBhZGV2LT5kbS5kbWN1X2Z3X3Zl
cnNpb247CiAJCWZ3X2luZm8tPmZlYXR1cmUgPSAwOwogCQlicmVhazsKKwljYXNlIEFNREdQVV9J
TkZPX0ZXX0RNQ1VCOgorCQlmd19pbmZvLT52ZXIgPSBhZGV2LT5kbS5kbWN1Yl9md192ZXJzaW9u
OworCQlmd19pbmZvLT5mZWF0dXJlID0gMDsKKwkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJcmV0dXJu
IC1FSU5WQUw7CiAJfQpAQCAtMTM5Miw2ICsxMzk2LDE0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rl
YnVnZnNfZmlybXdhcmVfaW5mbyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKmRhdGEpCiAJc2Vx
X3ByaW50ZihtLCAiRE1DVSBmZWF0dXJlIHZlcnNpb246ICV1LCBmaXJtd2FyZSB2ZXJzaW9uOiAw
eCUwOHhcbiIsCiAJCSAgIGZ3X2luZm8uZmVhdHVyZSwgZndfaW5mby52ZXIpOwogCisJLyogRE1D
VUIgKi8KKwlxdWVyeV9mdy5md190eXBlID0gQU1ER1BVX0lORk9fRldfRE1DVUI7CisJcmV0ID0g
YW1kZ3B1X2Zpcm13YXJlX2luZm8oJmZ3X2luZm8sICZxdWVyeV9mdywgYWRldik7CisJaWYgKHJl
dCkKKwkJcmV0dXJuIHJldDsKKwlzZXFfcHJpbnRmKG0sICJETUNVQiBmZWF0dXJlIHZlcnNpb246
ICV1LCBmaXJtd2FyZSB2ZXJzaW9uOiAweCUwOHhcbiIsCisJCSAgIGZ3X2luZm8uZmVhdHVyZSwg
ZndfaW5mby52ZXIpOworCiAKIAlzZXFfcHJpbnRmKG0sICJWQklPUyB2ZXJzaW9uOiAlc1xuIiwg
Y3R4LT52Ymlvc192ZXJzaW9uKTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRn
cHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAppbmRleCAzOTFjOWMxYmRi
YTQuLmY3NWM2OTU3MDY0ZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJt
LmgKKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKQEAgLTcxNCw2ICs3MTQsOSBA
QCBzdHJ1Y3QgZHJtX2FtZGdwdV9jc19jaHVua19kYXRhIHsKIAkvKiBTdWJxdWVyeSBpZDogUXVl
cnkgRE1DVSBmaXJtd2FyZSB2ZXJzaW9uICovCiAJI2RlZmluZSBBTURHUFVfSU5GT19GV19ETUNV
CQkweDEyCiAJI2RlZmluZSBBTURHUFVfSU5GT19GV19UQQkJMHgxMworCS8qIFN1YnF1ZXJ5IGlk
OiBRdWVyeSBETUNVQiBmaXJtd2FyZSB2ZXJzaW9uICovCisJI2RlZmluZSBBTURHUFVfSU5GT19G
V19ETUNVQgkJMHgxNAorCiAvKiBudW1iZXIgb2YgYnl0ZXMgbW92ZWQgZm9yIFRUTSBtaWdyYXRp
b24gKi8KICNkZWZpbmUgQU1ER1BVX0lORk9fTlVNX0JZVEVTX01PVkVECQkweDBmCiAvKiB0aGUg
dXNlZCBWUkFNIHNpemUgKi8KLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
