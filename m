Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D3C5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 08:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42162166E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42162166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D6A76F391;
	Thu,  7 Nov 2019 08:59:40 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750045.outbound.protection.outlook.com [40.107.75.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441BE6F391
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 08:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f21Q+lLE8yfP0cPtasJUe3VxHXkHwysfXl/GGUopH1IURmL6ev6u9oi0mBuR8VS6zJHRklm/7YJem/ijaS4syP+MUtEilN7GlFyH4ZAg85M6agMStP8nYRHFkRlf5FgRgp2zqo0mrVphZNoCG1dOnBv2ogBc81f41Kb/Uy8ZQ9He40yvO+QbZTVkUflqRlWTBaClwlnWW9DWO0Wx6HjY/oI6Esgj+PEmPErkiKgNDI9r/VMIeA0pblaObEmqZpJ+t3rMlsot53UrSmbiz2F0woTXPXZ27MyGLUYDSiKMwFFXYkW8rGFkI4Bcw2g7vo8t9Cc4vwl5uh9L4DDHDc5W+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eidFrXzvpwtjhbJ6LsT3NZvocvmwHbqrJCcrSbFjVs0=;
 b=fWwAZ58sQ4S4hnjXtAgpjcjdGuq9pAF9qunCRnEUQWGAqEygrY1Oep8336Af4kl0Xf75YeMNF8nS9X6GGquIc9SV5n+GYBDqqum9AKm5j8HPFTliySyE0XHr8wjhlnLax7Z1qCdgI3GYZaCqUDiLfIMG3re9OWjVf1nCF2JWpU6dFworZAwdVen6DqoM79oW9ba6UU4ZtNqlwpR/oQd3NbXO02mbk7pHk+VTgeWkseaQsg0yDdLxJD5ffkJmOFMle0THXkGIMsafPv3o8+xPKQ8BM0Z09K/eZTwqfcsAEtT11BDJRiME8D92R4TnCVs758qDK4AZ6ODtmtplU1gbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN4PR12CA0014.namprd12.prod.outlook.com (2603:10b6:403:2::24)
 by DM5PR12MB1817.namprd12.prod.outlook.com (2603:10b6:3:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Thu, 7 Nov
 2019 08:59:34 +0000
Received: from DM3NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by BN4PR12CA0014.outlook.office365.com
 (2603:10b6:403:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 08:59:34 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT025.mail.protection.outlook.com (10.152.82.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 08:59:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 02:59:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 02:59:32 -0600
Received: from lnx-kenneth.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 02:59:31 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: disable ds and ulv for compute
Date: Thu, 7 Nov 2019 16:59:27 +0800
Message-ID: <1573117167-25742-1-git-send-email-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(428003)(199004)(189003)(6666004)(305945005)(81166006)(86362001)(8936002)(4326008)(8676002)(5660300002)(2351001)(36756003)(47776003)(356004)(16586007)(53416004)(70206006)(44832011)(316002)(70586007)(6916009)(336012)(426003)(50466002)(14444005)(486006)(81156014)(186003)(48376002)(126002)(2616005)(476003)(2906002)(26005)(7696005)(478600001)(50226002)(51416003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1817; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76fe7983-bb40-4628-665d-08d76360cf1e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1817:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18171BAB190D45D23371290C8E780@DM5PR12MB1817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vciv90OJ0LZArDiVUr2Z/mjT/bA0zQz667+FMLJjDnq7MO+YMTi/E48+XvEAfgCFqiGqyd9DmJLPRuhlqCkQjjntOzQghpA9dIGVziDANH5LaQL5LqWcizC/fYSDMrtVTWH7+lv7xWmik17yX7GUYbiRp8WO8Q/cXyqTlEdkqgab9ved3ybF75hZVLYIhzFvSVhO0XhT0O4vabdMJZnj3qIqys6nUNrKSpAf/dOJ73/M3aCz3f3Dt8pEB08LcHEPUtOce8cbZOlzKEZoo0aB4uBnn4tAKVJVnhUhjnGH9Z5E0URh9rF6vIUuIkMU9okkHCcGqm4bzCF0ZRRZ/p5zGfiz/SKTERWNcAIOJGiUSiBSj2PoiHhnCXYVg/EODhuIqHuPl3RZP2kAAAHyS8qvLCTcYk3pORtzGB6cYviGkhfviNkhaVc2tLrDtcOzUWv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 08:59:33.8129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fe7983-bb40-4628-665d-08d76360cf1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1817
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eidFrXzvpwtjhbJ6LsT3NZvocvmwHbqrJCcrSbFjVs0=;
 b=JjlrTVaFEtY7A05FPmScHjWtmyaAGOSBxYmXvSa53+qQ/JWiSFkegaJzXhElBO/94Zc0GLfYtswNlELD6Sk/+F/OWBnPwL/N9ACY3FwPP4ghu2K2XP3/hIELVzCjeg1/qn28cyJnP10+3CFvBQ8Mv7UPrM55Yd15UVGcihUZidc=
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107085927.KgBW6f_8HD7l1RNSPx4jFuin1euJP2QP5XzoGIiVhf0@z>

VGhpcyBpcyB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBpbiB0aGUgY29tcHV0ZSBtb2RlCmZv
ciB2ZWdhMTAuIEZvciBleGFtcGxlLCB0aGUgb3JpZ2luYWwgcGVyZm9ybWFuY2UgZm9yIGEgcm9j
bQpiYW5kd2lkdGggdGVzdDogMkcgaW50ZXJuYWwgR1BVIGNvcHksIGlzIGFib3V0IDk5R0Ivcy4K
V2l0aCB0aGUgaWRsZSBwb3dlciBmZWF0dXJlcyBkaXNhYmxlZCBkeW5hbWljYWxseSwgdGhlIHBv
cmZvcm1hbmNlCmlzIHByb21vdGVkIHRvIGFib3V0IDIxNUdCL3MuCgpTaWduZWQtb2ZmLWJ5OiBL
ZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIHwgNjIgKysrKysrKysrKysrKysrKysr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdt
Z3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5j
CmluZGV4IDRlYTYzYTIuLmMwZGJiMjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCkBAIC00OTQwLDYgKzQ5NDAsNTkgQEAgc3Rh
dGljIGludCB2ZWdhMTBfZ2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3
bWdyLCBjaGFyICpidWYpCiAJcmV0dXJuIHNpemU7CiB9CiAKK3N0YXRpYyBpbnQgdmVnYTEwX2Rp
c2FibGVfcG93ZXJfZmVhdHVyZXNfZm9yX2NvbXB1dGVfcGVyZm9ybWFuY2Uoc3RydWN0IHBwX2h3
bWdyICpod21nciwgYm9vbCBkaXNhYmxlKQoreworCXN0cnVjdCB2ZWdhMTBfaHdtZ3IgKmRhdGEg
PSBod21nci0+YmFja2VuZDsKKwl1aW50MzJfdCBmZWF0dXJlX21hc2sgPSAwOworCisJaWYgKGRp
c2FibGUpIHsKKwkJZmVhdHVyZV9tYXNrIHw9IGRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX1VMVl0u
ZW5hYmxlZCA/CisJCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9VTFZdLnNtdV9mZWF0dXJlX2Jp
dG1hcCA6IDA7CisJCWZlYXR1cmVfbWFzayB8PSBkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19H
RlhDTEtdLmVuYWJsZWQgPworCQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5z
bXVfZmVhdHVyZV9iaXRtYXAgOiAwOworCQlmZWF0dXJlX21hc2sgfD0gZGF0YS0+c211X2ZlYXR1
cmVzW0dOTERfRFNfU09DQ0xLXS5lbmFibGVkID8KKwkJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxE
X0RTX1NPQ0NMS10uc211X2ZlYXR1cmVfYml0bWFwIDogMDsKKwkJZmVhdHVyZV9tYXNrIHw9IGRh
dGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0xDTEtdLmVuYWJsZWQgPworCQkJZGF0YS0+c211X2Zl
YXR1cmVzW0dOTERfRFNfTENMS10uc211X2ZlYXR1cmVfYml0bWFwIDogMDsKKwkJZmVhdHVyZV9t
YXNrIHw9IGRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0RDRUZDTEtdLmVuYWJsZWQgPworCQkJ
ZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfRENFRkNMS10uc211X2ZlYXR1cmVfYml0bWFwIDog
MDsKKwl9IGVsc2UgeworCQlmZWF0dXJlX21hc2sgfD0gKCFkYXRhLT5zbXVfZmVhdHVyZXNbR05M
RF9VTFZdLmVuYWJsZWQpID8KKwkJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX1VMVl0uc211X2Zl
YXR1cmVfYml0bWFwIDogMDsKKwkJZmVhdHVyZV9tYXNrIHw9ICghZGF0YS0+c211X2ZlYXR1cmVz
W0dOTERfRFNfR0ZYQ0xLXS5lbmFibGVkKSA/CisJCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9E
U19HRlhDTEtdLnNtdV9mZWF0dXJlX2JpdG1hcCA6IDA7CisJCWZlYXR1cmVfbWFzayB8PSAoIWRh
dGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX1NPQ0NMS10uZW5hYmxlZCkgPworCQkJZGF0YS0+c211
X2ZlYXR1cmVzW0dOTERfRFNfU09DQ0xLXS5zbXVfZmVhdHVyZV9iaXRtYXAgOiAwOworCQlmZWF0
dXJlX21hc2sgfD0gKCFkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19MQ0xLXS5lbmFibGVkKSA/
CisJCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19MQ0xLXS5zbXVfZmVhdHVyZV9iaXRtYXAg
OiAwOworCQlmZWF0dXJlX21hc2sgfD0gKCFkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19EQ0VG
Q0xLXS5lbmFibGVkKSA/CisJCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19EQ0VGQ0xLXS5z
bXVfZmVhdHVyZV9iaXRtYXAgOiAwOworCX0KKworCWlmIChmZWF0dXJlX21hc2spCisJCVBQX0FT
U0VSVF9XSVRIX0NPREUoIXZlZ2ExMF9lbmFibGVfc21jX2ZlYXR1cmVzKGh3bWdyLAorCQkJCSFk
aXNhYmxlLCBmZWF0dXJlX21hc2spLAorCQkJCSJlbmFibGUvZGlzYWJsZSBwb3dlciBmZWF0dXJl
cyBmb3IgY29tcHV0ZSBwZXJmb3JtYW5jZSBGYWlsZWQhIiwKKwkJCQlyZXR1cm4gLUVJTlZBTCk7
CisKKwlpZiAoZGlzYWJsZSkgeworCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9VTFZdLmVuYWJs
ZWQgPSBmYWxzZTsKKwkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5lbmFibGVk
ID0gZmFsc2U7CisJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX1NPQ0NMS10uZW5hYmxlZCA9
IGZhbHNlOworCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19MQ0xLXS5lbmFibGVkID0gZmFs
c2U7CisJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0RDRUZDTEtdLmVuYWJsZWQgPSBmYWxz
ZTsKKwl9IGVsc2UgeworCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9VTFZdLmVuYWJsZWQgPSB0
cnVlOworCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19HRlhDTEtdLmVuYWJsZWQgPSB0cnVl
OworCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19TT0NDTEtdLmVuYWJsZWQgPSB0cnVlOwor
CQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19MQ0xLXS5lbmFibGVkID0gdHJ1ZTsKKwkJZGF0
YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfRENFRkNMS10uZW5hYmxlZCA9IHRydWU7CisJfQorCisJ
cmV0dXJuIDA7CisKK30KKwogc3RhdGljIGludCB2ZWdhMTBfc2V0X3Bvd2VyX3Byb2ZpbGVfbW9k
ZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCBsb25nICppbnB1dCwgdWludDMyX3Qgc2l6ZSkKIHsK
IAlzdHJ1Y3QgdmVnYTEwX2h3bWdyICpkYXRhID0gaHdtZ3ItPmJhY2tlbmQ7CkBAIC00OTQ4LDYg
KzUwMDEsNyBAQCBzdGF0aWMgaW50IHZlZ2ExMF9zZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVj
dCBwcF9od21nciAqaHdtZ3IsIGxvbmcgKmlucHV0LCB1aQogCXVpbnQ4X3QgdXNlX3JsY19idXN5
OwogCXVpbnQ4X3QgbWluX2FjdGl2ZV9sZXZlbDsKIAl1aW50MzJfdCBwb3dlcl9wcm9maWxlX21v
ZGUgPSBpbnB1dFtzaXplXTsKKwlpbnQgcmV0ID0gMDsKIAogCWlmIChwb3dlcl9wcm9maWxlX21v
ZGUgPT0gUFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NKSB7CiAJCWlmIChzaXplICE9IDAgJiYg
c2l6ZSAhPSA0KQpAQCAtNDk3NSwxMSArNTAyOSwxNyBAQCBzdGF0aWMgaW50IHZlZ2ExMF9zZXRf
cG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIGxvbmcgKmlucHV0LCB1
aQogCX0KIAogb3V0OgorCWlmIChwb3dlcl9wcm9maWxlX21vZGUgPT0gUFBfU01DX1BPV0VSX1BS
T0ZJTEVfQ09NUFVURSkKKwkJcmV0ID0gdmVnYTEwX2Rpc2FibGVfcG93ZXJfZmVhdHVyZXNfZm9y
X2NvbXB1dGVfcGVyZm9ybWFuY2UoaHdtZ3IsIHRydWUpOworCWVsc2UKKwkJcmV0ID0gdmVnYTEw
X2Rpc2FibGVfcG93ZXJfZmVhdHVyZXNfZm9yX2NvbXB1dGVfcGVyZm9ybWFuY2UoaHdtZ3IsIGZh
bHNlKTsKKwogCXNtdW1fc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLCBQUFNN
Q19NU0dfU2V0V29ya2xvYWRNYXNrLAogCQkJCQkJMSA8PCBwb3dlcl9wcm9maWxlX21vZGUpOwor
CiAJaHdtZ3ItPnBvd2VyX3Byb2ZpbGVfbW9kZSA9IHBvd2VyX3Byb2ZpbGVfbW9kZTsKIAotCXJl
dHVybiAwOworCXJldHVybiByZXQ7CiB9CiAKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
