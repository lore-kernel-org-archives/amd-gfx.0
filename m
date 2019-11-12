Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95EC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A63D2184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A63D2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628F36EA2F;
	Tue, 12 Nov 2019 00:33:55 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800059.outbound.protection.outlook.com [40.107.80.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E7A6EA27
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8SggXqhOrLlzmB/MHuDzTqehqDFW0whjgAI4bHj8FVGpMJWLcbygqEv7v48jjicc2o+acAOKUIbqzNT4li6N/GkgREQtGGs0CxyuHaNjlSHuXvMNEWCKYFFBvnG3F+Y+0j5rK2Ae7XDPzBSbHKmwiGFELOuOX4jCDcy7cjLseuVILl0NfVCPUc5lGnnrPNwjKxCzKqtDbv8TS5PER19hLgVWKrauFPKQh46blXe9ss+CoODLxr6Q8mbZ44YQ9njg9g+7uuStxC0nS+4DscBP+UhDArEFI4aTTBOaWl55UfTb4yfw//gkz+9LYJPnfcbmEpwCVF/KeCzKunf/wSqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHw/X8S2K7P5uKoeUDICOrM/GIkzaGT5zReZibXFLrc=;
 b=koOgBbrNDw/SrlPFFG26BWR9K45q7ZBJvl9facf61CAgN9KHo+nSiXLBrxL/XglijpEtfezBmQZ+zGkxNRXL7b76TUEG6QOLlQZjrejPnQxVYNYneegzXQTBRduGdHAPPqwljLs4g214puKDp+p4G7wNeJdKixnNtpQLIwrPz8u6ZD9DngiBiBZbpSgUabJsHeuoedJCXLf/70ezjW24LdSfDLlBwLWA2KJerilU2N70LSoITLIOy17gl0hOrRTSiXrXLFxLwjr3RL9F670PYhpSboBUmc+mrrksxOqIJt5rL6B9DSiPWQ8B0uDxVIC5lE5Z2+uj732KKWZFDNAOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:51 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/30] drm/amd/display: Fix stereo with DCC enabled
Date: Mon, 11 Nov 2019 19:33:02 -0500
Message-Id: <20191112003324.8419-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 544dbe0c-ed23-4c87-d98c-08d76707fd4a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255458A67090E2AC07C0037F98770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+pmKUOwuJEUCa4Lrgg4TB5/lSY5eZRHKYCadz4ozbtGhr1h/IVfVqSXIcWXE1p34zgsojrwiNoumUtiBCPYz7DyZsD6V4vrSAdSls1nG8cNDKnKOC046s6XFRxGDHtlLvLDSeIPFjlNI9Qu3mZcGQRpzi6xF+nTkIOvvBgc6X6bkY+Ifp3XfCUFuiMb8oLbfIGoat0+7RRederfVW0ZtD/El+1QkGB6UJ58DBPjwfM7E/jzJvq57QSnFNNFcy8Aj4Ulkefvrh4I0lci94hiJS7+l143nLOYmOQbSSSnTPqqTQkJCEGH5lLwMnsFDo3QCMu5D0So6LS1/KnqChrOxrSA/8swikhuB8TW5nAnaMh/1EUr9OrpqqiSCl5aPxIey47rFekylnCyZJyvyPVpDedU2hePD77+bOMeJWGfv/u7eCfqknEPZaVkbKk8qteY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544dbe0c-ed23-4c87-d98c-08d76707fd4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:50.9976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bx8Kj58M22SHSG0JmzPcZRPRGFkuDAbI6AoBwQBegf8SdebXAxk9bfeIhBY7jWYh1b8wBWmVr35Z7DuP8pI8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHw/X8S2K7P5uKoeUDICOrM/GIkzaGT5zReZibXFLrc=;
 b=rOykg0RwiJBJov1FbgkZXJx67PRO9YC9c0csAtQ3d5FWOTeFbT0RfxHjN8rPoyCIgBDiDLUxQMUgVgFaB50bnpDxC3eMmjRqlj6jusa3DhmdjmksUDqyx29uTRt/RBbM6zmRlyohDzEXgoAVGq0WT9i9nQOstwkl+0WaHH4mOd8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Jun Lei <Jun.Lei@amd.com>, Samson Tam <Samson.Tam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003302.TJ5BJMaukp0twRsDBXD-ypIe_r8BhcmXsontDX77lqY@z>

RnJvbTogU2Ftc29uIFRhbSA8U2Ftc29uLlRhbUBhbWQuY29tPgoKW1doeV0KV2hlbiBzZW5kaW5n
IERDQyB3aXRoIFN0ZXJlbywgRENDIGdldHMgZW5hYmxlZCBidXQgdGhlIG1ldGEgYWRkcmVzc2Vz
CmFyZSAwLiBUaGlzIGhhcHBlbnMgbW9tZW50YXJpbHkgYmVmb3JlIHRoZSBtZXRhIGFkZHJlc3Nl
cyBhcmUgcG9wdWxhdGVkCndpdGggYSB2YWxpZCBhZGRyZXNzLgoKW0hvd10KQWRkIGNhbGwgdmFs
aWRhdGVfZGNjX3dpdGhfbWV0YV9hZGRyZXNzKCkgaW4KY29weV9zdXJmYWNlX3VwZGF0ZV90b19w
bGFuZSgpIHRvIGNoZWNrIGZvciBzdXJmYWNlIGFkZHJlc3MgYW5kIERDQwpjaGFuZ2UuCldoZW4g
RENDIGhhcyBjaGFuZ2VkLCBjaGVjayBpZiBEQ0MgZW5hYmxlIGlzIHRydWUgYnV0IG1ldGEgYWRk
cmVzcyBpcyAwLgpJZiBzbywgd2UgdHVybiBEQ0MgZW5hYmxlIHRvIGZhbHNlLiBXaGVuIHN1cmZh
Y2UgYWRkcmVzcyBoYXMgY2hhbmdlZCwgd2UKY2hlY2sgaWYgRENDIGVuYWJsZSBpcyBmYWxzZSBi
dXQgbWV0YSBhZGRyZXNzIGlzIG5vdCAwLiBJZiBzbywgd2UgdHVybgpEQ0MgZW5hYmxlIGJhY2sg
dG8gdHJ1ZS4gIFRoaXMgd2lsbCByZXN0b3JlIERDQyBlbmFibGUgdG8gdGhlIHByb3BlcgpzZXR0
aW5nIG9uY2UgdGhlIG1ldGEgYWRkcmVzcyBpcyB2YWxpZC4KClNpZ25lZC1vZmYtYnk6IFNhbXNv
biBUYW0gPFNhbXNvbi5UYW1AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEp1biBMZWkgPEp1bi5MZWlA
YW1kLmNvbT4KQWNrZWQtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIHwgMjcg
KysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCmluZGV4IDFmZGJhMTNi
M2QwZi4uZmZjOGIxZjg5NjkwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY29yZS9kYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjLmMKQEAgLTE3NDgsMTIgKzE3NDgsMzcgQEAgc3RhdGljIHN0cnVjdCBkY19zdHJlYW1fc3Rh
dHVzICpzdHJlYW1fZ2V0X3N0YXR1cygKIAogc3RhdGljIGNvbnN0IGVudW0gc3VyZmFjZV91cGRh
dGVfdHlwZSB1cGRhdGVfc3VyZmFjZV90cmFjZV9sZXZlbCA9IFVQREFURV9UWVBFX0ZVTEw7CiAK
K3N0YXRpYyB2b2lkIHZhbGlkYXRlX2RjY193aXRoX21ldGFfYWRkcmVzcygKKwlzdHJ1Y3QgZGNf
cGxhbmVfZGNjX3BhcmFtICpkY2MsCisJc3RydWN0IGRjX3BsYW5lX2FkZHJlc3MgKmFkZHJlc3Mp
Cit7CisJaWYgKChhZGRyZXNzLT5ncnBoLm1ldGFfYWRkci5xdWFkX3BhcnQgPT0gMCkgJiYKKwkJ
ZGNjLT5lbmFibGUpIHsKKwkJQVNTRVJUKCFkY2MtPmVuYWJsZSk7CisJCWRjYy0+ZW5hYmxlID0g
ZmFsc2U7CisJfSBlbHNlIGlmICgoYWRkcmVzcy0+Z3JwaC5tZXRhX2FkZHIucXVhZF9wYXJ0ICE9
IDApICYmCisJCSFkY2MtPmVuYWJsZSkKKwkJZGNjLT5lbmFibGUgPSB0cnVlOworCisJaWYgKGFk
ZHJlc3MtPnR5cGUgIT0gUExOX0FERFJfVFlQRV9HUkFQSElDUykgeworCQlpZiAoKGFkZHJlc3Mt
PmdycGhfc3RlcmVvLnJpZ2h0X21ldGFfYWRkci5xdWFkX3BhcnQgPT0gMCkgJiYKKwkJCWRjYy0+
ZW5hYmxlKSB7CisJCQlBU1NFUlQoIWRjYy0+ZW5hYmxlKTsKKwkJCWRjYy0+ZW5hYmxlID0gZmFs
c2U7CisJCX0gZWxzZSBpZiAoKGFkZHJlc3MtPmdycGhfc3RlcmVvLnJpZ2h0X21ldGFfYWRkci5x
dWFkX3BhcnQgIT0gMCkgJiYKKwkJCSFkY2MtPmVuYWJsZSkKKwkJCWRjYy0+ZW5hYmxlID0gdHJ1
ZTsKKwl9Cit9CisKIHN0YXRpYyB2b2lkIGNvcHlfc3VyZmFjZV91cGRhdGVfdG9fcGxhbmUoCiAJ
CXN0cnVjdCBkY19wbGFuZV9zdGF0ZSAqc3VyZmFjZSwKIAkJc3RydWN0IGRjX3N1cmZhY2VfdXBk
YXRlICpzcmZfdXBkYXRlKQogewogCWlmIChzcmZfdXBkYXRlLT5mbGlwX2FkZHIpIHsKIAkJc3Vy
ZmFjZS0+YWRkcmVzcyA9IHNyZl91cGRhdGUtPmZsaXBfYWRkci0+YWRkcmVzczsKKwkJdmFsaWRh
dGVfZGNjX3dpdGhfbWV0YV9hZGRyZXNzKCZzdXJmYWNlLT5kY2MsICZzdXJmYWNlLT5hZGRyZXNz
KTsKKwogCQlzdXJmYWNlLT5mbGlwX2ltbWVkaWF0ZSA9CiAJCQlzcmZfdXBkYXRlLT5mbGlwX2Fk
ZHItPmZsaXBfaW1tZWRpYXRlOwogCQlzdXJmYWNlLT50aW1lLnRpbWVfZWxhcHNlZF9pbl91c1tz
dXJmYWNlLT50aW1lLmluZGV4XSA9CkBAIC0xODAyLDYgKzE4MjcsOCBAQCBzdGF0aWMgdm9pZCBj
b3B5X3N1cmZhY2VfdXBkYXRlX3RvX3BsYW5lKAogCQkJCXNyZl91cGRhdGUtPnBsYW5lX2luZm8t
Pmdsb2JhbF9hbHBoYV92YWx1ZTsKIAkJc3VyZmFjZS0+ZGNjID0KIAkJCQlzcmZfdXBkYXRlLT5w
bGFuZV9pbmZvLT5kY2M7CisJCXZhbGlkYXRlX2RjY193aXRoX21ldGFfYWRkcmVzcygmc3VyZmFj
ZS0+ZGNjLCAmc3VyZmFjZS0+YWRkcmVzcyk7CisKIAkJc3VyZmFjZS0+c2RyX3doaXRlX2xldmVs
ID0KIAkJCQlzcmZfdXBkYXRlLT5wbGFuZV9pbmZvLT5zZHJfd2hpdGVfbGV2ZWw7CiAJCXN1cmZh
Y2UtPmxheWVyX2luZGV4ID0KLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
