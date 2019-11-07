Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181C5C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D7E206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D7E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DDB6F73F;
	Thu,  7 Nov 2019 15:56:56 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820081.outbound.protection.outlook.com [40.107.82.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C414F6F733
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 15:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGVM5meUR5bdRv3ops8YUO0kOzHt52mUkRsnwwZz9W4Jab6rLOe0ouPS/Nd+5h8r3qvAgnZHwac7j1/Bc0rSvyK2tcCGGvzTIROJNzmbA0e81TH85zTrRQj1ISScS9IRONas39P5mFebuGPmli/tD1K0FB+0pgfB+bGyO36OqpS2k6Ql4Ra085O6Ykh0gvHjp5sHEsWYUGV+blwwFp/B+DhiySINWuc1bpnweVR0xy8NfGnP6CSvJSryv2BYEg2vRZQHi46fN9ZZIuH+8jHr6JRX5idZOxfpgpnCMLACU4OxJ+Cf6eUVU8QXNAghg91k0LoTiy0KbSyHTDFwGtd/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mvbXqAL+0VujZwwdI8cYFLZcDMl7rlLZbDeVXEFZEU=;
 b=Z49kpNj2T0Awx+TjkStULvicLtmT5O99jemA/SrnVy7ZWryQ4RQGOh4rr3oCG2fxyy257+KPKY2dwkUm1kK46E56zw0R3IuRHzJnCtpA1Ipe+McJFNDhPPbZMqniVhmgsL0aH73ttxHe25aiCxQCSVugCgPaQ+l36/0wmzrMo7y/lodEomkvHWtEPr8rWaOj5BPy45zPtbcQB2petHLpgYTtgLrxfqBUojARyLOr9o/n5bBXNvf1zDNhA+zbSEYbCHXqZ48fG0I5+dDeJUMyGEHjURnzURtHLddzbKzB9FjPkxxXr78S5ge72EAWSoEpx6Rc93z2BqyW9OFEqhM+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:2b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 15:56:52 +0000
Received: from DM3NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Thu, 7 Nov 2019 15:56:51 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT025.mail.protection.outlook.com (10.152.82.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 15:56:51 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 09:56:46 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 09:56:46 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: use drm defines for MAX CASCADE MASK
Date: Thu, 7 Nov 2019 10:56:26 -0500
Message-ID: <20191107155628.19446-13-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
References: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(428003)(199004)(189003)(5660300002)(47776003)(486006)(336012)(476003)(11346002)(356004)(126002)(53416004)(2616005)(14444005)(54906003)(6666004)(446003)(16586007)(426003)(70586007)(316002)(2906002)(26005)(478600001)(86362001)(4326008)(186003)(70206006)(2351001)(6916009)(50466002)(36756003)(1076003)(50226002)(51416003)(48376002)(8676002)(7696005)(76176011)(305945005)(81166006)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2559; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfe277e5-7f0d-4608-5e60-08d7639b1add
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25594890A2DCDD0507FD1216F9780@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsQkNwydfB9y6J5SC6O7IKHknoVgjZKIWk/zsoo7kiHRaWzOCuG/5YROh9WDdvGBd/zFyj9+FBnP37/HqTARFMrsu7fNyGwNpHXr+WFv3P0seT6Cig0DcbGdIhEC5/z3MFtfl8izSytlngNdJI5sabIAJ35bHMEcx16pxzuRi5JI8UMgaSZG1h2ZgyAZi4+2ks9g4E0pwixVigOfT30i3O4EufFDRUKeGYbYGg3AQISeJMCnfSndtzdhhwy9BbPIUnemul8YJhxCVYUegfN23HFWoltOPXaeycjL+wCCZsX0TZfwtxIr21cJ9/LHwoTj6WRMSV3ezqZoF6C44DmqasSKKnZ04FUPyetwmrEqMHByslY4KaRlstJzGDw4242t6n+QS4bLTGm/wqZVmkI4W0vqhEip+MLENa+PM7sojtdNHMSPFPfjJGnzaFVUI0EE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:56:51.7149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe277e5-7f0d-4608-5e60-08d7639b1add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mvbXqAL+0VujZwwdI8cYFLZcDMl7rlLZbDeVXEFZEU=;
 b=PEX5vCReqLb+LNTFr0SJbCoLhCxt0fp62Vvlctz9YQU8UiX3ZfXVsnVZoN3Q3AmVKjhb3UvraMmL5ZWN1mRvM8QxSHjUAvw65Jcrc5LCRu7CbOCi8ZypDziar4wMjSPevrx98I3uzYgA4T8ywYvEC0JmetKKr2QcGC+8ua3XkuI=
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
Message-ID: <20191107155626.H8CHwt87Jes6mYQxCJKsYgeriE_dOclYqUbnJXtvtV8@z>

W1doeV0KZHJtIGFscmVhZHkgaGFzIHRoaXMgZGVmaW5lCgpbSG93XQpkcm0gTWFzayBpcyAweDA4
IHZzIDB4MDgwMC4gVGhlIHJlYXNvbiBpcyBiZWNhdXNlIGRybSBtYXNrCndvcmtzIG9uIGEgYnl0
ZS4gICAgICAgIF5eCiAgICAgICAgICAgICAgICAgPT09PT09PXx8CiAgICAgICAgICAgICAgICAg
fHwKU2luY2UgdGhlIGZpcnN0IGJ5dGUgaXMgYWx3YXlzIHplcm8gd2UgY2FuIGlnbm9yZSBpdCBh
bmQgb25seSBjaGVjayB0aGUKc2Vjb25kIGJ5dGUuCgpTaWduZWQtb2ZmLWJ5OiBCaGF3YW5wcmVl
dCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3AuaCAgICB8ICA0IC0tLS0KIC4uLi9kcm0vYW1k
L2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3AxX2V4ZWN1dGlvbi5jIHwgMTQgKysrKysrLS0tLS0t
LS0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3Au
aCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcC5oCmluZGV4
IGJmYjMyYWZjMTg2OC4uZjZiYmE0ODdkMWQ0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3AuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3AuaApAQCAtMzUsOCArMzUsNiBAQAogLyogVE9ETzoK
ICAqIFJlcGxhY2UgYmVsb3cgZGVmaW5lcyB3aXRoIHRoZXNlCiAgKgotICogI2RlZmluZSBEUk1f
SERDUF9NQVhfQ0FTQ0FERV9FWENFRURFRCh4KSAgICAgICAgKHggJiBCSVQoMykpCi0gKiAjZGVm
aW5lIERSTV9IRENQX01BWF9DQVNDQURFX0VYQ0VFREVEKHgpICAgICAgICAoeCAmIEJJVCgzKSkK
ICAqICNkZWZpbmUgSERDUF8yXzJfSERNSV9SWFNUQVRVU19NU0dfU1pfSEkoeCkgICAgICgoeCkg
JiAweDMpCiAgKiAjZGVmaW5lIEhEQ1BfMl8yX0hETUlfUlhTVEFUVVNfUkVBRFkoeCkgICAgICAg
ICAoKHgpICYgQklUKDIpKQogICogI2RlZmluZSBIRENQXzJfMl9IRE1JX1JYU1RBVFVTX1JFQVVU
SF9SRVEoeCkgICAgKCh4KSAmIEJJVCgzKSkKQEAgLTQ2LDggKzQ0LDYgQEAKICAqIHNwbGl0IHRo
ZSBIRE1JIHJ4c3RhdHVzIGludG8gMmJ5dGVzIGJlZm9yZSB3ZSBjYW4gdXNlIHVzcHRyZWFtIGRl
ZnMKICAqLwogCi0jZGVmaW5lIEJTVEFUVVNfTUFYX0NBU0NBREVfRVhDRUVERURfTUFTSwkJMHgw
ODAwCi0jZGVmaW5lIEJJTkZPX01BWF9DQVNDQURFX0VYQ0VFREVEX01BU0tfRFAJCTB4MDgwMAog
I2RlZmluZSBSWFNUQVRVU19NU0dfU0laRV9NQVNLCQkJCTB4MDNGRgogI2RlZmluZSBSWFNUQVRV
U19SRUFEWV9NQVNLCQkJCTB4MDQwMAogI2RlZmluZSBSWFNUQVRVU19SRUFVVEhfUkVRVUVTVF9N
QVNLCQkJMHgwODAwCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9k
dWxlcy9oZGNwL2hkY3AxX2V4ZWN1dGlvbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L21vZHVsZXMvaGRjcC9oZGNwMV9leGVjdXRpb24uYwppbmRleCA0NjE4YWJkNjUwNGYuLjRkMTEw
NDFhOGM2ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMv
aGRjcC9oZGNwMV9leGVjdXRpb24uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
bW9kdWxlcy9oZGNwL2hkY3AxX2V4ZWN1dGlvbi5jCkBAIC05MiwxNSArOTIsMTMgQEAgc3RhdGlj
IGlubGluZSBlbnVtIG1vZF9oZGNwX3N0YXR1cyBjaGVja19ub19tYXhfY2FzY2FkZShzdHJ1Y3Qg
bW9kX2hkY3AgKmhkY3ApCiAJZW51bSBtb2RfaGRjcF9zdGF0dXMgc3RhdHVzOwogCiAJaWYgKGlz
X2RwX2hkY3AoaGRjcCkpCi0JCXN0YXR1cyA9IChoZGNwLT5hdXRoLm1zZy5oZGNwMS5iaW5mb19k
cCAmCi0JCQkJQklORk9fTUFYX0NBU0NBREVfRVhDRUVERURfTUFTS19EUCkgPwotCQkJTU9EX0hE
Q1BfU1RBVFVTX0hEQ1AxX01BWF9DQVNDQURFX0VYQ0VFREVEX0ZBSUxVUkUgOgotCQkJTU9EX0hE
Q1BfU1RBVFVTX1NVQ0NFU1M7CisJCXN0YXR1cyA9IERSTV9IRENQX01BWF9DQVNDQURFX0VYQ0VF
REVEKGhkY3AtPmF1dGgubXNnLmhkY3AxLmJpbmZvX2RwID4+IDgpCisJCQkJID8gTU9EX0hEQ1Bf
U1RBVFVTX0hEQ1AxX01BWF9DQVNDQURFX0VYQ0VFREVEX0ZBSUxVUkUKKwkJCQkgOiBNT0RfSERD
UF9TVEFUVVNfU1VDQ0VTUzsKIAllbHNlCi0JCXN0YXR1cyA9IChoZGNwLT5hdXRoLm1zZy5oZGNw
MS5ic3RhdHVzICYKLQkJCQlCU1RBVFVTX01BWF9DQVNDQURFX0VYQ0VFREVEX01BU0spID8KLQkJ
CQlNT0RfSERDUF9TVEFUVVNfSERDUDFfTUFYX0NBU0NBREVfRVhDRUVERURfRkFJTFVSRSA6Ci0J
CQkJTU9EX0hEQ1BfU1RBVFVTX1NVQ0NFU1M7CisJCXN0YXR1cyA9IERSTV9IRENQX01BWF9DQVND
QURFX0VYQ0VFREVEKGhkY3AtPmF1dGgubXNnLmhkY3AxLmJzdGF0dXMgPj4gOCkKKwkJCQkgPyBN
T0RfSERDUF9TVEFUVVNfSERDUDFfTUFYX0NBU0NBREVfRVhDRUVERURfRkFJTFVSRQorCQkJCSA6
IE1PRF9IRENQX1NUQVRVU19TVUNDRVNTOwogCXJldHVybiBzdGF0dXM7CiB9CiAKLS0gCjIuMTcu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
