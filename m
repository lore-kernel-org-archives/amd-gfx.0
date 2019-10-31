Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31386CA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FC120873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FC120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BD76EEAB;
	Thu, 31 Oct 2019 14:42:51 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820085.outbound.protection.outlook.com [40.107.82.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF9B6EEB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSi9ALKaW+p334F8PoIwbZJzwc4vO3oyCJPA5o/ut72vUYg45rlBeiGCt6ROo574gk0HWC4pJ/s6tsMxhxCMQgEjsd5OVkAEaAtTfEvo6/smYxTIlPjiA2f+jfdUc9mnJSPFogpkHLXkXRQwATXCmyYA8I0kRRDwbcSecgZUOmKNv5VnI3+3XbBBjnneFUbrC84W4kFSxRG2ZaMVtemgnFZFiMG0TBZEOvleRqijIcVD4IMTgJT7913KptSF+wb6hkdMEUObQHTXHPUA2ywlVmVianZZdLSlqdixuLueQagvIl2zOJIFgicjLg82+rwMMeHwCYiErQNQf0WPFqZxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BmPfR5ONUgj4yB52qjOCbNhxjzv3Ifq69Zxrf85vS8=;
 b=PJNKWaAVzcNf1QbDjgomDTKagiIRQoA0SQbcRPViYccma8/ySjDtS0kAo1+R9vaUGtInnLqc3wHJwhOsZFJHwAklHgCesCzef2BRfSMHiHGZ/sAf60QFqzhXshIKe4Ix9VRtUVT8WhSQpXzqhqcqykqj5K0Oq5HcqBzpgSyirVzDbyAZNTbaMtaCCeITuClK1MImmywl55FoklmwidWU74J5koMcwN6H95NDYDU6wUl9Ncm4Hj+9zw9ag4y8mQwGvs4lntdJax8ddVUsjY+FxzgGV3A62Ok1U1xxoPqs5tFiT0iuK4ftCIRUrXMY3cRikj8HwNhuenI6xhi1mEDDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0035.namprd12.prod.outlook.com (2603:10b6:903:129::21)
 by BYAPR12MB3621.namprd12.prod.outlook.com (2603:10b6:a03:db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Thu, 31 Oct
 2019 14:42:42 +0000
Received: from CO1NAM03FT024.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by CY4PR12CA0035.outlook.office365.com
 (2603:10b6:903:129::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.19 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:42 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT024.mail.protection.outlook.com (10.152.80.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:40 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:39 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:39 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/20] drm/amd/display: Add PSP FW version mask.
Date: Thu, 31 Oct 2019 10:42:03 -0400
Message-ID: <20191031144210.24011-14-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(428003)(189003)(199004)(305945005)(478600001)(426003)(86362001)(336012)(48376002)(14444005)(2351001)(316002)(50226002)(8936002)(50466002)(16586007)(26005)(126002)(486006)(70206006)(81166006)(81156014)(36756003)(5660300002)(1076003)(53416004)(476003)(356004)(2906002)(70586007)(6666004)(2616005)(51416003)(11346002)(76176011)(47776003)(446003)(8676002)(7696005)(4326008)(6916009)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3621; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f7d1c7-09ac-45d0-f7fa-08d75e109601
X-MS-TrafficTypeDiagnostic: BYAPR12MB3621:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3621CEB589FD9005EC2E763FF9630@BYAPR12MB3621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ob0eqv0ZEnATE/zYoxScNEYtCJYfHCU5F0CpN0eOqiSDQ0qlCo2oR/4PI3XufaWbqoPHS49IZVUky+eQ65W2YV3yQTkdKfzYhvXeyzhu6xZ4iarXF/j8cnszhJ1HK18veG+H6nk04U+373vQzgjVjcX0HhcoJug2pvU8ijMtiPThRVctg3r0gV0HsHKXig3RW3mp6zXLJbGl86tWXbMrKEq3tc98rn2+7OOobCLuMrLxsXDFgdrvgNRTS8JuGXNEzRw/VtP/8EnD2gk6dObWeVFUXxURnPvRrG4GRgE1fQgf8jGLsWpCG/7LmT/prUgsXnB/bCIQ9fCNGbNm/aPextIvszrlEa6zaMc/PoB5exq2l3FT146q45KlSRhKH160uMWKcOSAoO7PpQ+sPFYgmByw/xswTA6Q2+IWgQkroq1lQk7HpG5mOYE71XqeUEI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:42.3772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f7d1c7-09ac-45d0-f7fa-08d75e109601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3621
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BmPfR5ONUgj4yB52qjOCbNhxjzv3Ifq69Zxrf85vS8=;
 b=B6dpES2tu0LU3p/v2/0ZI/tdI36Svxf3CVr9uyR65OK+VrybrGnq6JPf6ImJpTh4B/EoXwcTRWAmq9N3urZFp82yAS+2gW2qBnV9thr0HBBK0q31hu4s8J/i5Jgt1P6i5+4piWyTw6dkLvAYIv7EELxyA4EwEkHGj+viem2S41U=
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144203.CL7N6rgnstFI_JI0ikyqwtmWTd_GBOj7o6_ZAHJZl4M@z>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKW1doeV0KUFNQIHZl
cnNpb24gZm9ybWF0IGlzIEFCLkNELkVGLkdILCB3aGVyZSBDRCBhbmQgR0ggaXMgdGhlIG1haW4g
dmVyc2lvbi4KY3VycmVudCBwc3AgdmVyc2lvbiBjaGVjayBmb3IgZG1jdWIgbG9hZGluZyBkbWN1
IGNoZWNrIDB4MDAxMTAwMjksIGluCmNhc2Ugb2Ygc29tZSBwc3AgdmVyc2lvbiBlZzogMHgwMDEx
MDIyNyB3aGljaCBtYWluIHZlcnNpb24gc2hvdWxkIGJlCjB4MDAxMTAwMjcsIHdpbGwgcmVzdWx0
IGluIHVuZXhwZWNldGVkIGRtY3ViIGxvYWRpbmcgZG1jdSBGVy4KCltIb3ddCkFkZCBwc3AgdmVy
c2lvbiBtYXNrIDB4MDBGRjAwRkYgZm9yIGNoZWNraW5nIHZlcnNpb24uCgpTaWduZWQtb2ZmLWJ5
OiBZb25ncWlhbmcgU3VuIDx5b25ncWlhbmcuc3VuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255
IENoZW5nIDxUb255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBCaGF3YW5wcmVldCBMYWtoYSA8
Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KQWNrZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMg
PE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNlL2RjZV9kbWN1LmMKaW5kZXggMzQxNzEwMGQ1MWU0Li4zMjc2OTQ0ZTY5OTcgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2RtY3UuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMKQEAgLTg4Niw3ICs4
ODYsNyBAQCBzdGF0aWMgdm9pZCBkY24yMV9kbWN1X2NvbnN0cnVjdCgKIAogCWlmICghSVNfRlBH
QV9NQVhJTVVTX0RDKGN0eC0+ZGNlX2Vudmlyb25tZW50KSkgewogCQlwc3BfdmVyc2lvbiA9IGRt
X3JlYWRfcmVnKGN0eCwgbW1NUDBfU01OX0MyUE1TR181OCk7Ci0JCWRtY3VfZGNlLT5iYXNlLmF1
dG9fbG9hZF9kbWN1ID0gKHBzcF92ZXJzaW9uID4gMHgwMDExMDAyOSk7CisJCWRtY3VfZGNlLT5i
YXNlLmF1dG9fbG9hZF9kbWN1ID0gKChwc3BfdmVyc2lvbiAmIDB4MDBGRjAwRkYpID4gMHgwMDEx
MDAyOSk7CiAJCWRtY3VfZGNlLT5iYXNlLnBzcF92ZXJzaW9uID0gcHNwX3ZlcnNpb247CiAJfQog
fQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
