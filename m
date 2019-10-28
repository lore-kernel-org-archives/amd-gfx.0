Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1944CA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B161B20659
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B161B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB956E8A5;
	Mon, 28 Oct 2019 14:08:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770073.outbound.protection.outlook.com [40.107.77.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB9F6E8A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn8U0r/brrSQ1aTlh00mMAvcCRfP8mns3t7tYtR2yJ/bwPpqFVpE8cjrFp68O+vH9pRp26fODb+mBh0B+z0fGMpYTyDRgyLH5E2PgBHtZU3EFGhWcgBeH3pPKWDFy5ipj+8MmynWhtM94TSADEcw0CMKeXAARj4LETHjG4s24j/nL/KS+0bxIwitEJLE9JFM5r91uF+L14JUe39gLqPC7fY/7KcCjcatj+gLmWCNxcMWRROEk3L4tdIabCGb4AkterVrUbUP2/ly+suU81QowSJ3mktoxFOg35t/jQHqh6mWHSiN7fuU38d6VXdHFq2slqElXijfBagXkEkR5+7baA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoOhRgDzs1Dfsc9HB7JkuZYpa8jp4BNPuJ6JV91njsA=;
 b=U+NO7kvxB/yF8Fyo3v6el2xQTk6b3iEWIi4D5HfcMebNP+x3j8DY3DGfD2zBa39cHx9zx/zRZL+HKJx2hk3S5wNugH4pW0x5ARCVZNtbpcvfkeuwvpJcdmJ6hfStbzFb9p61sRG1/ri6CLkpCQ4eTWh1bR175us0iDqQoGTqIyCBNgoXaqUUzzernPmZkQGK10JjTKxc/CQavPhZCU+fZBCG3trSaeqIpokruXoshIZ/F7T+t3R3r7J2SCOvv4lszVTQqVwwSQ/R2DCy2U79w4yxLprB+/un5kWcC1IR1Fxe6nb9MEtfRlCVuiTKB9LOQ9Q4ciN012RW3Ij1eP4cGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:405:4c::13) by DM5PR12MB2552.namprd12.prod.outlook.com
 (2603:10b6:4:b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Mon, 28 Oct
 2019 14:08:57 +0000
Received: from CO1NAM03FT027.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by BN6PR1201CA0003.outlook.office365.com
 (2603:10b6:405:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Mon, 28 Oct 2019 14:08:56 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT027.mail.protection.outlook.com (10.152.80.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 14:08:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:55 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:55 -0500
Received: from kazvm.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 09:08:54 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amd/display: Add PSP FW version mask.
Date: Mon, 28 Oct 2019 10:08:32 -0400
Message-ID: <20191028140837.7908-7-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
References: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(428003)(199004)(189003)(316002)(6916009)(305945005)(70586007)(26005)(86362001)(36756003)(53416004)(4326008)(1076003)(44832011)(486006)(126002)(50466002)(2616005)(76176011)(11346002)(446003)(51416003)(186003)(7696005)(48376002)(356004)(2906002)(70206006)(50226002)(8676002)(81166006)(8936002)(476003)(81156014)(2870700001)(478600001)(14444005)(336012)(47776003)(5660300002)(2351001)(426003)(6666004)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2552; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a5792a-7781-4228-8c0a-08d75bb05f4c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2552:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2552165ED645162ED1A938A9EC660@DM5PR12MB2552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6eGRpQTZ0AJ6XKQZRSot23NpYpABO2EYvWXbYcAJLgEvInuV2q9JC7EdGdG71qmpqCjp0fPsEUzPeqL6NjkTRT93pura0MDrjfidOEJrEKmceIRdeS+tMJ4+9ZJD+EhOtgK96KCa4bVwZpSo4Ki3sLRILdxxEDdsBUrx6JTBth38Y4iXcYHrjH21DwAWTa7YRyqazCAerF6HVtflsnII/YLsDg7V59dWX7O8kVSJ9mW39HPfCbJrm6K4e/d5RoGzfRHqO2k5vuux0Alpa5J+HECQA08GoNeVbjqJoffgjYBv85AR1FnTjTb76EExAzoEjhagBs4CorRgujMMkthp1YgdndwCDcZ5zzp0cyR61LX6edvmJ/g3I1JefgD6snrjtdVKDxUoliGTdLFko0fCCE4IK36m10+tTyHbomBE2+vPRClU0LLKXNXjSpKuVL9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 14:08:56.5837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a5792a-7781-4228-8c0a-08d75bb05f4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoOhRgDzs1Dfsc9HB7JkuZYpa8jp4BNPuJ6JV91njsA=;
 b=qFX0fQzGWAiKisDaobfA2VRCBoq5fkT7m4UmmNUiPvUMoNWxmkyh/+P1ivnLmQXuh6du8Jler11I61AN1WOEThsC+NPiFETOa4LcA0zE6TKavASTaZtKFMFDf4oDbLACy/52Degqv6ikpzO3cplZWr0RXoh/bDaAmXwGb4qWRh4=
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>, Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140832.cjqcYzrR0592efij126ppHnUj6wUw4H25H9sBSFHp68@z>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKW1doeV0KUFNQIHZl
cnNpb24gZm9ybWF0IGlzIEFCLkNELkVGLkdILCB3aGVyZSBDRCBhbmQgR0ggaXMgdGhlIG1haW4g
dmVyc2lvbi4KY3VycmVudCBwc3AgdmVyc2lvbiBjaGVjayBmb3IgZG1jdWIgbG9hZGluZyBkbWN1
IGNoZWNrIDB4MDAxMTAwMjksIGluCmNhc2Ugb2Ygc29tZSBwc3AgdmVyc2lvbiBlZzogMHgwMDEx
MDIyNyB3aGljaCBtYWluIHZlcnNpb24gc2hvdWxkIGJlCjB4MDAxMTAwMjcsIHdpbGwgcmVzdWx0
IGluIHVuZXhwZWNldGVkIGRtY3ViIGxvYWRpbmcgZG1jdSBGVy4KCltIb3ddCkFkZCBwc3AgdmVy
c2lvbiBtYXNrIDB4MDBGRjAwRkYgZm9yIGNoZWNraW5nIHZlcnNpb24uCgpTaWduZWQtb2ZmLWJ5
OiBZb25ncWlhbmcgU3VuIDx5b25ncWlhbmcuc3VuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255
IENoZW5nIDxUb255LkNoZW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZS9kY2VfZG1jdS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZS9kY2VfZG1jdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZS9kY2VfZG1jdS5jCmluZGV4IDM0MTcxMDBkNTFlNC4uMzI3Njk0NGU2OTk3IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfZG1jdS5jCkBAIC04ODYsNyArODg2
LDcgQEAgc3RhdGljIHZvaWQgZGNuMjFfZG1jdV9jb25zdHJ1Y3QoCiAKIAlpZiAoIUlTX0ZQR0Ff
TUFYSU1VU19EQyhjdHgtPmRjZV9lbnZpcm9ubWVudCkpIHsKIAkJcHNwX3ZlcnNpb24gPSBkbV9y
ZWFkX3JlZyhjdHgsIG1tTVAwX1NNTl9DMlBNU0dfNTgpOwotCQlkbWN1X2RjZS0+YmFzZS5hdXRv
X2xvYWRfZG1jdSA9IChwc3BfdmVyc2lvbiA+IDB4MDAxMTAwMjkpOworCQlkbWN1X2RjZS0+YmFz
ZS5hdXRvX2xvYWRfZG1jdSA9ICgocHNwX3ZlcnNpb24gJiAweDAwRkYwMEZGKSA+IDB4MDAxMTAw
MjkpOwogCQlkbWN1X2RjZS0+YmFzZS5wc3BfdmVyc2lvbiA9IHBzcF92ZXJzaW9uOwogCX0KIH0K
LS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
