Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D201DCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12D520659
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12D520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C566E8AA;
	Mon, 28 Oct 2019 14:09:03 +0000 (UTC)
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr710048.outbound.protection.outlook.com [40.107.71.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE206E8A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn5Twk+iXgcn/Qlllmi/FryaW4wwcwPIgB9RiEFz7WgcLfs9K9JZY/hHPRuHVUeol/RTJXv2BBNXRErmKgEc7YH9nmsR+irZadWakn5pbrB1RqDDTvcviDx+ns/xpkkeBqunixPy9EcFNa2DvLpcPT3oi8vyaK3kezY1FGgrlh+I0D4iKsZtF7ysdPvongznSN2e38DA+0VZpu+n2XxMdfFyFrfu1n0Re/9VrUItpCsTU+kgkjFvz+rqmnyi6WsVdItYX+QG6Wcm+HcE5k9/S2c3NRy0i/rzudNhVG7FLwGFmgqN33CgCH97/aOhdVJNKreIiHRw1fo4WT/1Lg7Wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxK0aOguULRvHkjaVD3QCuw1PCr8q95mzwkkH68AyJQ=;
 b=Rq0Rlfn8yDaoQ0S1QI9sEmPIzBfydn+NDbUffEpT7kQAVPEmUNkKEdb18yiiOwaHsYYnFkWIBhxhmHm/RPMiErSJHf+8I7O1xm7ncuSs9K4hKO/ICmkIRpydc1ycQP35EL+tX4awl2tEILOnN/d/9nmezkQAAw/sspmBMSyqiGmXanKfhxEqC+KNW14WyUk1aAGjz/IjUeJvfLUJOylmdwAoHMcUMKz+hfB/HVSXutBU5Vp6I/YuyBTs4mCFjuUZeoGlGPZ6+dM+9NIHN1SyG3cBilu8Kp9tVL3GG79TWVkSE7+bIu3T9Gea7YZdNThJgUDsIeuKpoVEu/myPAYxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:60::15)
 by DM5PR12MB1466.namprd12.prod.outlook.com (2603:10b6:4:d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Mon, 28 Oct 2019 14:08:52 +0000
Received: from BY2NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::205) by BN8PR12CA0002.outlook.office365.com
 (2603:10b6:408:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Mon, 28 Oct 2019 14:08:52 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BY2NAM03FT045.mail.protection.outlook.com (10.152.85.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 14:08:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:51 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:50 -0500
Received: from kazvm.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 09:08:50 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amd/display: Drop DMCUB from DCN21 resources
Date: Mon, 28 Oct 2019 10:08:29 -0400
Message-ID: <20191028140837.7908-4-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
References: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(428003)(189003)(199004)(305945005)(2351001)(70586007)(53416004)(47776003)(1076003)(76176011)(36756003)(5660300002)(486006)(8676002)(81156014)(70206006)(6666004)(356004)(4326008)(44832011)(478600001)(81166006)(126002)(8936002)(2616005)(476003)(446003)(50226002)(426003)(7696005)(11346002)(26005)(50466002)(2906002)(48376002)(51416003)(336012)(86362001)(2870700001)(186003)(6916009)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1466; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f845454d-26dc-4761-f187-08d75bb05cbc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:
X-Microsoft-Antispam-PRVS: <DM5PR12MB146683C8FA7726FEE876CAFEEC660@DM5PR12MB1466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIH5+KD7RmudyUdUOQHzPCCw7ZfRVpL/bwW/Gq0r04njloJKKSFEdj0Z3fhjqnqJsXIUQRP/ZRS/0cqHkV+sfp2Ekl64bb+euiYYJDBkuD4e9e/IK0MUkXr+YVo1f4I8Lt94zks159iqlyUVPBDNmiP5GJQ8EDseFkJ2oAVJQKSUpbfkUu7RMr8L+AB9osRmONNYbptHJRZQ7aOQUbQsWW4UDMtJ4dNG9YItQYlDAOBneL2A2z4k6I00do9h1HfxAZAwuPmJD56vwYFOQVODn9H3KQbquSDvHmvDFbmjCYf5YrRh5TyBPts8DjybS2bCns0uEZ4FdVErSMOmRFslsb/Ulg0I9pua099JoJARisMIvBzk6fMMLvc8aoNMnedwhyiTj0slGdPGl5bn2kqQtPDZmGQNoFi50HpuFauo4gEpCy1vvzFc1PPhZuBx5pA9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 14:08:52.3151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f845454d-26dc-4761-f187-08d75bb05cbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxK0aOguULRvHkjaVD3QCuw1PCr8q95mzwkkH68AyJQ=;
 b=q04shCNlIWa47YjTlUxit+e9wvCWLm/0X3wY3N8kTYRb1xGZemB3t5eXaWRyFoPjGASUqYe8+qF4ROta2xQlNzwD4Q0sLjAw2HMucCK76+yAP8T7NsVqt7WFzGUd7YxBJQneVPzxsTcLrGfKvnjCa8y6PIY7sSsgsQHLC66+iOU=
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
Message-ID: <20191028140829.z5dMI8FYZeW_D4sEZXN9U1biAw6PWNFonAB53c64YLM@z>

VGhlIGludGVyZmFjZSB0byB0aGUgRE1DVUIgd29uJ3QgYmUgdGhyb3VnaCBEQyBpdHNlbGYuIERD
IHdpbGwgaW5zdGVhZApjYWxsIGludG8gdGhlIERNVUIgaW50ZXJmYWNlIGludHJvZHVjZWQgd2l0
aCBhIGZ1dHVyZSBjaGFuZ2UuCgpUaGUgQ09ORklHX0RSTV9BTURfRENfRE1VQiBkZWZpbmVzIHdp
bGwgc3RpbGwgYmUgdXNlZCBmb3Igbm93IGJ1dCB3aWxsCmJlIGRyb3BwZWQgYXQgdGhlIGVuZCBv
ZiB0aGUgc2VyaWVzLgoKU2luY2UgdGhpcyBkZWZpbmUgd2FzIG5ldmVyIGNvbmZpZ3VyYWJsZSBp
biB0aGUgZmlyc3QgcGxhY2UgdGhpcyBjb2RlCndhc24ndCB1c2VkLgoKU2lnbmVkLW9mZi1ieTog
TmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgotLS0KIC4u
Li9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYyB8IDMxIC0tLS0tLS0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jCmlu
ZGV4IDQ1OWJkOWE1Y2FlZC4uMTA0MjE5N2YxODU5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwpAQCAtMzczLDIwICsz
NzMsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRjZV9hYm1fbWFzayBhYm1fbWFzayA9IHsKIAkJ
QUJNX01BU0tfU0hfTElTVF9EQ04yMChfTUFTSykKIH07CiAKLSNpZmRlZiBDT05GSUdfRFJNX0FN
RF9EQ19ETVVCCi1zdGF0aWMgY29uc3Qgc3RydWN0IGRjbjIxX2RtY3ViX3JlZ2lzdGVycyBkbWN1
Yl9yZWdzID0gewotCQlETUNVQl9SRUdfTElTVF9EQ04oKQotfTsKLQotc3RhdGljIGNvbnN0IHN0
cnVjdCBkY24yMV9kbWN1Yl9zaGlmdCBkbWN1Yl9zaGlmdCA9IHsKLQkJRE1DVUJfQ09NTU9OX01B
U0tfU0hfTElTVF9CQVNFKF9fU0hJRlQpCi19OwotCi1zdGF0aWMgY29uc3Qgc3RydWN0IGRjbjIx
X2RtY3ViX21hc2sgZG1jdWJfbWFzayA9IHsKLQkJRE1DVUJfQ09NTU9OX01BU0tfU0hfTElTVF9C
QVNFKF9NQVNLKQotfTsKLSNlbmRpZgotCiAjZGVmaW5lIGF1ZGlvX3JlZ3MoaWQpXAogW2lkXSA9
IHtcCiAJCUFVRF9DT01NT05fUkVHX0xJU1QoaWQpXApAQCAtOTcwLDExICs5NTYsNiBAQCBzdGF0
aWMgdm9pZCBkZXN0cnVjdChzdHJ1Y3QgZGNuMjFfcmVzb3VyY2VfcG9vbCAqcG9vbCkKIAlpZiAo
cG9vbC0+YmFzZS5kbWN1ICE9IE5VTEwpCiAJCWRjZV9kbWN1X2Rlc3Ryb3koJnBvb2wtPmJhc2Uu
ZG1jdSk7CiAKLSNpZmRlZiBDT05GSUdfRFJNX0FNRF9EQ19ETVVCCi0JaWYgKHBvb2wtPmJhc2Uu
ZG1jdWIgIT0gTlVMTCkKLQkJZGNuMjFfZG1jdWJfZGVzdHJveSgmcG9vbC0+YmFzZS5kbWN1Yik7
Ci0jZW5kaWYKLQogCWlmIChwb29sLT5iYXNlLmRjY2cgIT0gTlVMTCkKIAkJZGNuX2RjY2dfZGVz
dHJveSgmcG9vbC0+YmFzZS5kY2NnKTsKIApAQCAtMTc2NiwxOCArMTc0Nyw2IEBAIHN0YXRpYyBi
b29sIGNvbnN0cnVjdCgKIAkJZ290byBjcmVhdGVfZmFpbDsKIAl9CiAKLSNpZmRlZiBDT05GSUdf
RFJNX0FNRF9EQ19ETVVCCi0JcG9vbC0+YmFzZS5kbWN1YiA9IGRjbjIxX2RtY3ViX2NyZWF0ZShj
dHgsCi0JCQkmZG1jdWJfcmVncywKLQkJCSZkbWN1Yl9zaGlmdCwKLQkJCSZkbWN1Yl9tYXNrKTsK
LQlpZiAocG9vbC0+YmFzZS5kbWN1YiA9PSBOVUxMKSB7Ci0JCWRtX2Vycm9yKCJEQzogZmFpbGVk
IHRvIGNyZWF0ZSBkbWN1YiFcbiIpOwotCQlCUkVBS19UT19ERUJVR0dFUigpOwotCQlnb3RvIGNy
ZWF0ZV9mYWlsOwotCX0KLSNlbmRpZgotCiAJcG9vbC0+YmFzZS5wcF9zbXUgPSBkY24yMV9wcF9z
bXVfY3JlYXRlKGN0eCk7CiAKIAludW1fcGlwZXMgPSBkY24yXzFfaXAubWF4X251bV9kcHA7Ci0t
IAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
