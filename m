Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B83EC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED87215A5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED87215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B596E02F;
	Fri, 29 Nov 2019 09:16:20 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790083.outbound.protection.outlook.com [40.107.79.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E5D6E02F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 09:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlDd8Umqqx/6+EHUXBu2FwMTDVa90N/BwfRYQVZmPw8BHDJcRgYH60RDly/Mx8PaLX+rEJNyfduNEXvYr0rz+XNka8hmsM6Q5qzfHwAdeo6kMw+ErZBK1nIz3OWSJIlvA3wXVO6oqB3MBMuNrgiWdH1YHKLdqSLGeNBISQnE2WaZQlanxEiDX66TNNIwzHorSnXQ00y01jn+9swdSav4PRohl28IrOAjfz12JTZqlvEp4P+7ufRXyWgOD+zipLz3gV0JnjPRUC0furJa3KlE4gPMGPyxxtx73i2tKv1Dbbbq7EOzpNBmpIpi2Pr2neiFh2sOKa2zfeSg/ZH5wIM0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WXK9zonu8PnnbyEdsUkV2eXU8stzLV/j9+s2A15EbI=;
 b=LJy1hzQTSivq+X6F9M6YQSDJa3AC5FasHW9oZ3RXbXHkk93hhakxal8FGHMEjJK1F/msuzV25j1zfhFUSsJfFO9dmyYLpEZdsuLpOkKSI4B2G/IHsw23zqnVcANwcRQAMs498OgfAMH6IAxYlvxLPpllp+yM/rpt3aEPX9kR2tuAGqkdy8KHR8AuWmRp3e7y0nb1TO9GDCqhCHlC9aIqHBFCQYdHQBImnZPWDT9w21ogPdFFGfjZTQ/TUp61+6quweU5I4RXjCJ5fD85kbHEM1gwVWlX1KblN/d6QpAanuiWSuAq4HzFP7Np7K89JJ3lbKQL9jFxcl3wnX4EFm2haA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0021.namprd12.prod.outlook.com (2603:10b6:4:1::31) by
 BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Fri, 29 Nov
 2019 09:16:15 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by DM5PR12CA0021.outlook.office365.com
 (2603:10b6:4:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.19 via Frontend
 Transport; Fri, 29 Nov 2019 09:16:15 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 29 Nov 2019 09:16:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 29 Nov
 2019 03:16:13 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 29 Nov 2019 03:16:10 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix GFX10 missing CSIB set(v2)
Date: Fri, 29 Nov 2019 17:16:05 +0800
Message-ID: <1575018965-30828-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(428003)(189003)(199004)(2351001)(6666004)(50466002)(26005)(478600001)(51416003)(356004)(336012)(186003)(48376002)(81166006)(8936002)(81156014)(50226002)(7696005)(36756003)(2906002)(8676002)(86362001)(426003)(2616005)(316002)(70206006)(70586007)(47776003)(4326008)(16586007)(53416004)(6916009)(5660300002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3666; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d6a399f-4bad-46bc-6571-08d774acc8f0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3666:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3666C2EF7FE6396E415629F384460@BY5PR12MB3666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0236114672
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2g8DfVbiq31yCWfnJ+BmVku95qReKfoIx2ZNOk8eGjihxpPJvKjZFMaYOJvu3Q2kP9xLCbp9v7aM6IUkdMDc1TXGlvGJkfCDTAHSxDZ0jIXyKkwxxJ2YBHrTILtA0N7jIhYfUaHfdjea4hnWeodb+wcYvs0twYlaxWZ0fpa5IdAGxDJRD/tYVaI/4M/bT8JS9iQuCcYBeFs83gHiysyshQ5Bzd7jWhqoDTov/N75mkDBs8HPinXL9nal7+DxWq/4e8YzIuSNubbJuObO/QcVI0PzLEwZLp8E3Ao6cAm7DF2toDMnlad7YC53jeysfVYN2ieZasz9hXvUrmP2eb1HLa+hMw/I1QvYLFQrubU4Gc8J1p2kMxLEGFb8QCa4bVsvc75nKpfsUi6+RbJz2b0wP0zJpwYIWkXrgCibBoE/1DZ0wuRcGawj3xNgNLmXhPP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 09:16:14.9781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6a399f-4bad-46bc-6571-08d774acc8f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WXK9zonu8PnnbyEdsUkV2eXU8stzLV/j9+s2A15EbI=;
 b=yGQTr5P8JUQ8/NV+tXB84aMVFp1FDQURmiPFJnZl0NuAjMmox6z8sK4nCF1HqrY1pmc2G37cI5lhw8aWV2qAeIeVRlzD1v9X3rW2e3DgttzlB/XrxkF4LfBdmdPWnHCVHOJoLTPz7qoQKZ66D5XrB4GIrND55Ae8Fkr6SbMVC+g=
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

c3RpbGwgbmVlZCB0byBpbml0IGNzYiBldmVuIGZvciBTUklPVgoKdjI6CmRyb3AgaW5pdF9wZygp
IGZvciBnZngxMCBhdCBhbGwgc2luY2UKUEcgYW5kIEdGWCBvZmYgZmVhdHVyZSB3aWxsIGJlIGZ1
bGx5IGNvbnRyb2xlZApieSBSTEMgYW5kIFNNVSBmdyBmb3IgZ2Z4MTAKClNpZ25lZC1vZmYtYnk6
IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jIHwgMzggKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggNTNkMTFlOS4uYThlZWJjNCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAgLTE3NjYsMjIgKzE3NjYsNiBA
QCBzdGF0aWMgaW50IGdmeF92MTBfMF9pbml0X2NzYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGludCBnZnhfdjEwXzBfaW5pdF9wZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKLXsKLQlpbnQgaTsKLQlpbnQgcjsKLQotCXIgPSBnZnhfdjEw
XzBfaW5pdF9jc2IoYWRldik7Ci0JaWYgKHIpCi0JCXJldHVybiByOwotCi0JZm9yIChpID0gMDsg
aSA8IGFkZXYtPm51bV92bWh1YnM7IGkrKykKLQkJYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiKGFk
ZXYsIDAsIGksIDApOwotCi0JLyogVE9ETzogaW5pdCBwb3dlciBnYXRpbmcgKi8KLQlyZXR1cm4g
MDsKLX0KLQogdm9pZCBnZnhfdjEwXzBfcmxjX3N0b3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiB7CiAJdTMyIHRtcCA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfQ05UTCk7CkBAIC0x
ODczLDIyICsxODU3LDIxIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JsY19sb2FkX21pY3JvY29k
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JsY19y
ZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJaW50IHI7Ci0KLQlpZiAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpKQotCQlyZXR1cm4gMDsKKwlpbnQgaTsKIAogCWlmIChhZGV2LT5m
aXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQKSB7CisKIAkJciA9IGdmeF92
MTBfMF93YWl0X2Zvcl9ybGNfYXV0b2xvYWRfY29tcGxldGUoYWRldik7CiAJCWlmIChyKQogCQkJ
cmV0dXJuIHI7CiAKLQkJciA9IGdmeF92MTBfMF9pbml0X3BnKGFkZXYpOwotCQlpZiAocikKLQkJ
CXJldHVybiByOworCQlnZnhfdjEwXzBfaW5pdF9jc2IoYWRldik7CiAKLQkJLyogZW5hYmxlIFJM
QyBTUk0gKi8KLQkJZ2Z4X3YxMF8wX3JsY19lbmFibGVfc3JtKGFkZXYpOworCQlmb3IgKGkgPSAw
OyBpIDwgYWRldi0+bnVtX3ZtaHViczsgaSsrKQorCQkJYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxi
KGFkZXYsIDAsIGksIDApOwogCisJCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSAvKiBlbmFi
bGUgUkxDIFNSTSAqLworCQkJZ2Z4X3YxMF8wX3JsY19lbmFibGVfc3JtKGFkZXYpOwogCX0gZWxz
ZSB7CiAJCWFkZXYtPmdmeC5ybGMuZnVuY3MtPnN0b3AoYWRldik7CiAKQEAgLTE5MTAsOSArMTg5
MywxMCBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9ybGNfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogCQkJCXJldHVybiByOwogCQl9CiAKLQkJciA9IGdmeF92MTBfMF9pbml0X3Bn
KGFkZXYpOwotCQlpZiAocikKLQkJCXJldHVybiByOworCQlnZnhfdjEwXzBfaW5pdF9jc2IoYWRl
dik7CisKKwkJZm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV92bWh1YnM7IGkrKykKKwkJCWFtZGdw
dV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2LCAwLCBpLCAwKTsKIAogCQlhZGV2LT5nZngucmxjLmZ1
bmNzLT5zdGFydChhZGV2KTsKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
