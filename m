Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DCAC5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B724206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B724206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175946F734;
	Thu,  7 Nov 2019 15:56:49 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700057.outbound.protection.outlook.com [40.107.70.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF9F6F732
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 15:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZePRyqOSINswDoMLrGnH0bwLds293z58caiyU2qk35rdnybAMu7HfwhNVawD/AFFB2LdB6G52UGSUnIXy0HHiwhuJtdKmqfZol1SGrLip+Zr3lxY0IGWZIFOVK1WxCDnfiLPMIiHpp2Fg2bJUq5MABRZWruFW+tBZSSu38zpmnolFxYC5aoSFbKqooTLwbHm6t9Qmfd313UGMpxMi71oQQvU82V1fdSO8f97RQlmBbcu58o4wYFfw6cTZiCGHjPPV2wBDsiUdI+FHW1w+RYQLr9OMHE1nvqIXVZBXLbzV06/3mqSeMVf6VlNsncV18zdb+8hFMZd5D0AfZeTxPvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR+UYBOJVWWzvn66HMd6NvwEyfFw7Tsw6nYo1C5n9YY=;
 b=a6811rXO/T0Jofuy4Ai8h+a/Zl/R7W/AGLmsEzSBkuqOCHi841DGuZzxqgLPXsaR5y8QYVp1T/T0Dz7SUHX2Xtcr6QJntn1Yg/Bstv7ezU6xksiwjnCH4I/tj6dAfaATFBYR3iBXv+68kX1e5t4TWJ2C9e59YEIjoMFhp6/Qcstzm8Lc+p0nHwmc9wfRafFh09Q4TVP3okKbLLyHLnXstBS4U2QZKWYgPvQFXjFajh/6rX5gXR0Rdzzg2tp6Z4C/OkdD9Tce/CfD7kZ0xssyU1F/vKfuU0jBPZUeO49mVfYF/R66kzUH+wLg4zRlC2bWSzL9XK7nbru57j7MWx7/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:910:16::21) by DM5PR1201MB0139.namprd12.prod.outlook.com
 (2603:10b6:4:4e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 15:56:45 +0000
Received: from CO1NAM03FT037.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::206) by CY4PR1201CA0011.outlook.office365.com
 (2603:10b6:910:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 15:56:45 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT037.mail.protection.outlook.com (10.152.80.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 15:56:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 09:56:44 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 09:56:43 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 09:56:43 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: Enable HDCP 2.2
Date: Thu, 7 Nov 2019 10:56:20 -0500
Message-ID: <20191107155628.19446-7-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
References: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(428003)(54534003)(189003)(199004)(81156014)(8676002)(476003)(8936002)(81166006)(54906003)(2906002)(50226002)(486006)(36756003)(2351001)(478600001)(48376002)(316002)(47776003)(2616005)(16586007)(26005)(426003)(126002)(50466002)(336012)(86362001)(446003)(14444005)(6916009)(186003)(7696005)(6666004)(51416003)(356004)(305945005)(76176011)(1076003)(5660300002)(70586007)(11346002)(4326008)(70206006)(53416004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0139; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b4afb5-f8c5-4c99-a278-08d7639b16f7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0139:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01397178458169FBCC6FE04CF9780@DM5PR1201MB0139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICL0edTMlLIIP5j7C0cl848DWBSIPf8Be7mzepPYijJMQB+frYaqdlMAiU/MgrNjeDyofmSpyhn5zDCIN1ipa2TWzn8ZADs4VQbWdvcpEVS9fRwcm2iI/SB9dNWfe5t7tRXNptdEPNh7x5rb4W0FPShM6gEps+Cf0yb+/1WOa+qGodMORkR7YTIETcBpsaZ1b8eRAN/0NgIjgh3FQMcPwx9kl0Th+zFN7Uqf+63qSf/1ErTc+cwAuE+MNj0uo9n8Vlq4j5uuOViaIAvYg/C/5EEVrdzBXvJX1+xQdj0x8svR60Mo4yDM9lD5h0Lze0NZqsp/MMgVSGzeCacLHSDG6IUrxv9a5NY6KY8rXnTvfXM+/0wbkxL784NPJQNWJZwog4WcthgHTqZiuh11OtLGRdocHGUI8v29kzp1QJ2wfRWfRLnQJhLG7iD9ql23sxXo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:56:45.1001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b4afb5-f8c5-4c99-a278-08d7639b16f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR+UYBOJVWWzvn66HMd6NvwEyfFw7Tsw6nYo1C5n9YY=;
 b=tQij9rfaCitn0oVyiMzReQfCaOl83JlOpefoy9pi6sX3kgFFyWufC7ABprzNomINk15L5XH1WBnDIhjExNLCkCcj01QIQgP3ZoE7HJugirlgy5bnuV8x7GViTovmnG3CDw+3sl+Nw0/I8ckC18AnuhFmTvHaifp3rIv4ZCC4R88=
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
Message-ID: <20191107155620.IRgRr7DG7MqS7WTGgW-TvAaZzj0XrdU62kGdN_-L7nQ@z>

W1doeV0KSERDUCAyLjIgd2FzIGRpc2FibGVkLCB3ZSBuZWVkIHRvIGVuYWJsZSBpdAoKW0hvd10K
LVVwZGF0ZSBkaXNwbGF5IHRvcG9sb2d5IHRvIHN1cHBvcnQgMi4yCi1VbnNldCBoZGNwMi5kaXNh
YmxlIGluIHVwZGF0ZV9jb25maWcKLUNoYW5nZSBsb2dpYyBvZiBldmVudF91cGRhdGVfcHJvcGVy
dHksIG5vdyB3ZSBzZXQgdGhlIHByb3BlcnR5IHRvIGJlCkVOQUJMRUQgZm9yIGFueSBsZXZlbCBv
ZiBlbmNyeXB0aW9uICgyLjIgb3IgMS40KS4KClNpZ25lZC1vZmYtYnk6IEJoYXdhbnByZWV0IExh
a2hhIDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hkY3AuYyB8IDMgKy0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfcHNwLmMgICAgfCAyICstCiAyIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNwLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNwLmMKaW5k
ZXggNzcxODFkZGY2YzhlLi45NzBmMmQ1OGM2ZGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hkY3AuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNwLmMKQEAgLTE5MCw3ICsx
OTAsNyBAQCBzdGF0aWMgdm9pZCBldmVudF9wcm9wZXJ0eV91cGRhdGUoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQogCQl9CiAJfQogCi0JaWYgKGhkY3Bfd29yay0+ZW5jcnlwdGlvbl9zdGF0dXMg
PT0gTU9EX0hEQ1BfRU5DUllQVElPTl9TVEFUVVNfSERDUDFfT04pCisJaWYgKGhkY3Bfd29yay0+
ZW5jcnlwdGlvbl9zdGF0dXMgIT0gTU9EX0hEQ1BfRU5DUllQVElPTl9TVEFUVVNfSERDUF9PRkYp
CiAJCWRybV9oZGNwX3VwZGF0ZV9jb250ZW50X3Byb3RlY3Rpb24oJmFjb25uZWN0b3ItPmJhc2Us
IERSTV9NT0RFX0NPTlRFTlRfUFJPVEVDVElPTl9FTkFCTEVEKTsKIAllbHNlCiAJCWRybV9oZGNw
X3VwZGF0ZV9jb250ZW50X3Byb3RlY3Rpb24oJmFjb25uZWN0b3ItPmJhc2UsIERSTV9NT0RFX0NP
TlRFTlRfUFJPVEVDVElPTl9ERVNJUkVEKTsKQEAgLTI5NCw3ICsyOTQsNiBAQCBzdGF0aWMgdm9p
ZCB1cGRhdGVfY29uZmlnKHZvaWQgKmhhbmRsZSwgc3RydWN0IGNwX3BzcF9zdHJlYW1fY29uZmln
ICpjb25maWcpCiAJbGluay0+ZGlnX2JlID0gY29uZmlnLT5saW5rX2VuY19pbnN0OwogCWxpbmst
PmRkY19saW5lID0gYWNvbm5lY3Rvci0+ZGNfbGluay0+ZGRjX2h3X2luc3QgKyAxOwogCWxpbmst
PmRwLnJldiA9IGFjb25uZWN0b3ItPmRjX2xpbmstPmRwY2RfY2Fwcy5kcGNkX3Jldi5yYXc7Ci0J
bGluay0+YWRqdXN0LmhkY3AyLmRpc2FibGUgPSAxOwogCiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYwppbmRleCBhMzY1Y2Yw
MGJjNGMuLmE5NTExNjEyZjQyNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L21vZHVsZXMvaGRjcC9oZGNwX3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYwpAQCAtMTA5LDcgKzEwOSw3IEBAIGVudW0gbW9k
X2hkY3Bfc3RhdHVzIG1vZF9oZGNwX2FkZF9kaXNwbGF5X3RvcG9sb2d5KHN0cnVjdCBtb2RfaGRj
cCAqaGRjcCkKIAkJCWR0bV9jbWQtPmR0bV9pbl9tZXNzYWdlLnRvcG9sb2d5X3VwZGF0ZV92Mi5k
aWdfZmUgPSBkaXNwbGF5LT5kaWdfZmU7CiAJCQlkdG1fY21kLT5kdG1faW5fbWVzc2FnZS50b3Bv
bG9neV91cGRhdGVfdjIuZHBfbXN0X3ZjaWQgPSBkaXNwbGF5LT52Y19pZDsKIAkJCWR0bV9jbWQt
PmR0bV9pbl9tZXNzYWdlLnRvcG9sb2d5X3VwZGF0ZV92Mi5tYXhfaGRjcF9zdXBwb3J0ZWRfdmVy
c2lvbiA9Ci0JCQkJVEFfRFRNX0hEQ1BfVkVSU0lPTl9NQVhfU1VQUE9SVEVEX18xX3g7CisJCQkJ
VEFfRFRNX0hEQ1BfVkVSU0lPTl9NQVhfU1VQUE9SVEVEX18yXzI7CiAJCQlkdG1fY21kLT5kdG1f
c3RhdHVzID0gVEFfRFRNX1NUQVRVU19fR0VORVJJQ19GQUlMVVJFOwogCiAJCQlwc3BfZHRtX2lu
dm9rZShwc3AsIGR0bV9jbWQtPmNtZF9pZCk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
