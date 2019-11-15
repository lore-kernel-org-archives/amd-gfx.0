Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84008C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 23:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A19B206D6
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 23:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A19B206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C23A6EB40;
	Fri, 15 Nov 2019 23:03:38 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730049.outbound.protection.outlook.com [40.107.73.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A2C6EB40
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 23:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC6rQI65lWDAHUMdCqRE6XWQzoEou0Shry+dmF1jp4YP8O4sya7MK/x0RfzMXaWiCOY9QBN22T6pRGp6HazFX4d54ZgdO4YKH+qcTTLYTQVm5RUxwFvxVFjzTALUoDDT8Fbwncvns1Q5GqHeuKKt8ahuHtIKEnYS1g1q8SicFv/vC5970lxHlLJWArhJfFptATxuuGFvhAaFqgDHcqd8DyZuFlzogagDlM+/XiHNn++xrDeqJUgHx2oiIwTTjBi7vb8hdB7trGm2SQi7iT2RCyFV0F6bT2R69Fq36tqjWVnkvG8Jhem/6NmnSdt9uIA5f3OzV0KzgdoVDoxHRSY4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VGqsrriEyWOfjpEEl5Tkggfz7Q0zNB1bJvOIrDxHu4=;
 b=J0ZCkG1PbH2v3sKAPU35ffIaqZ4x3/j8kUROZ8jQZLztfZrp/nymptPOcuiOkuF3/ZqEPLvrJuA2VBfORYz/stZRVRJV7AZIvVGTiZ+KYSsKe2i2UgWJREoPq0WSvC14iG8j9iqW5mioiNZJffvzwD28Z+xpTMmGPmdIYBS7SQTL9pk96jSnoYsEPGlfik/1ZNfAry86cOw6y6cLKQ3nwAdh6CA79hyqKzPZJbtdvrb6uaPnGGbYhDxHW1+bGbl105Jshpi+dtRQ/p45awrKJuPDAibaVB0a74qUO4EUTtAZzNjpNxKD/oX7s9H3z2PbKOEROIwYUl8hmKXJM1dnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0117.namprd12.prod.outlook.com (2603:10b6:0:51::13) by
 CY4PR12MB1318.namprd12.prod.outlook.com (2603:10b6:903:38::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Fri, 15 Nov 2019 23:03:34 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::201) by DM3PR12CA0117.outlook.office365.com
 (2603:10b6:0:51::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.22 via Frontend
 Transport; Fri, 15 Nov 2019 23:03:34 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 15 Nov 2019 23:03:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 15 Nov
 2019 17:03:33 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 15 Nov
 2019 17:03:33 -0600
Received: from a.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 15 Nov 2019 17:03:33 -0600
From: Zhan Liu <zhan.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhan.liu@amd.com>
Subject: [PATCH] drm/amd/display: Modify comments to match the code
Date: Fri, 15 Nov 2019 18:03:21 -0500
Message-ID: <20191115230321.4628-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(428003)(199004)(189003)(356004)(5660300002)(50466002)(6666004)(1076003)(51416003)(7696005)(48376002)(186003)(8676002)(8936002)(50226002)(26005)(86362001)(47776003)(316002)(16586007)(336012)(426003)(36756003)(476003)(110136005)(486006)(126002)(44832011)(2616005)(81166006)(4744005)(81156014)(53416004)(478600001)(14444005)(70586007)(70206006)(7049001)(305945005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5eb1d89-cd7a-46ca-184d-08d76a200a43
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1318B47D4E3859E7CF4699009E700@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diloBmKMi/07Lg5U7+bn6bgpFaS7AnzpbAO1YDJd9i+i40VJOxhlGUbR0wAQR9m8stvJvIPaReDEHeu2OHP+6q5rJ/dSffJ5o9wfK6qr6Y+Dn9JGWQq5K8PSo/NfpHf37w3+kqVWhHneMcGjuHs3fvzdQ7BGezPSHVR/QB0gzssQfYqjzuNvSVed8a3lcwiQ3+pzba1nkvorfiA+Gd3fB4FXpmlA4RbN0yC+lGXjvuQpp0ZNpS6tRhlxQkizUNyOPZbpB18dyz2rSU/dWjO6xw8l/owWmblI0tFtrLYOPr6Dz2S2PSCDMwUD2xoIH/K+65I7oD9nf7HRvsj95H54UmX83Q5eNQr/GXfkDH53tvopUEEeRf4XlqrED/L+aJkSSaxbXJBWP4xiM6z1RVboC2LDJ32dcS7k6fU7cNc02vl2i6TfmLZrWc0otEspauD6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 23:03:33.9461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eb1d89-cd7a-46ca-184d-08d76a200a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VGqsrriEyWOfjpEEl5Tkggfz7Q0zNB1bJvOIrDxHu4=;
 b=j7rEYcpDtlX4PvYuPVPmfO/GQm7tXntA8NecAM7LvTbQQXi4fmRi3Md2UxriYmDkzULrgLOR86/EQIZREqYAY/HTSIJ+IQiXCTGZl6vfo6ddsiNUcdpf1q+zO+MbJzA0Xuffeh4cYUWwpyU6t78IgdlK+TSQk4Kvy34oQBUGYng=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115230321.7j3118UKCyRLLfHVKoZ5CpSF-c2EIUEat7MpWUdYHGA@z>

W1doeV0KVGhpcyBsaW5lIG9mIGNvZGUgd2FzIG1vZGlmaWVkLiBIb3dldmVyLCB0aGUgY29tbWVu
dAp3YXMgcmVtYWluaW5nIHVuY2hhbmdlZC4KCltIb3ddCkNoYW5nZSAiMjAwbXMiIHRvICIzMDAw
bXMiLCB3aGljaCBtYXRjaGVzIHRoZSBjb2RlLgpBbHNvIGFkZCBhbm90aGVyIGxpbmUgb2YgY29t
bWVudCwgd2hpY2ggdGVsbHMgcGVvcGxlIHdoZXJlCnRoZSB2YWx1ZSBjYW1lIGZyb20uCgpTaWdu
ZWQtb2ZmLWJ5OiBaaGFuIExpdSA8emhhbi5saXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNfaGVscGVyLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY19oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY19oZWxwZXIuYwppbmRleCA4ZGE0NTc2ZTI5MDguLjQ5NzNkNTBjNGZiOSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2hlbHBlci5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19oZWxwZXIuYwpAQCAtNDg1LDcgKzQ4
NSwxMSBAQCB2b2lkIGdlbmVyaWNfcmVnX3dhaXQoY29uc3Qgc3RydWN0IGRjX2NvbnRleHQgKmN0
eCwKIAkJcmV0dXJuOwogCX0KIAotCS8qIHNvbWV0aGluZyBpcyB0ZXJyaWJseSB3cm9uZyBpZiB0
aW1lIG91dCBpcyA+IDIwMG1zLiAoNUh6KSAqLworCS8qIAorCSAqIFNvbWV0aGluZyBpcyB0ZXJy
aWJseSB3cm9uZyBpZiB0aW1lIG91dCBpcyA+IDMwMDBtcy4KKwkgKiAzMDAwbXMgaXMgZGVmaW5l
ZCBieSBTTVUgdGltZW91dCB2YWx1ZS4KKwkgKgorCSAqLwogCUFTU0VSVChkZWxheV9iZXR3ZWVu
X3BvbGxfdXMgKiB0aW1lX291dF9udW1fdHJpZXMgPD0gMzAwMDAwMCk7CiAKIAlmb3IgKGkgPSAw
OyBpIDw9IHRpbWVfb3V0X251bV90cmllczsgaSsrKSB7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
