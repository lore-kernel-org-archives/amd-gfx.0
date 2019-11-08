Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFAEFC6196
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 21:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8A1215EA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 21:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8A1215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E866FA9A;
	Fri,  8 Nov 2019 21:57:30 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800040.outbound.protection.outlook.com [40.107.80.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9E26FA9A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 21:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrtzbPtsqkjF1OqDeNhdNof0fY2lEoll9dqA/qCKFBXPY0hykU7iMQjK71X3hskhBppnat/ryZvABo0KsZKdHK+KydTi6j3WylE/jIFfpIJ+ckTLIIIpjlIwBwYzL7Dp8K8uaqtkYJYfv9GjOUVTic7dCUoMjIrrReKAYbIlvA1Hlfb9sIGCFnoL+YUQyn8kL32fSzyjpeG01bMrs1Sl4FIi0h5jUUOVw8Q7VS6SZkyCnltLSIOA79QYBF8Gioe+l67IzAMythUpyfeKFjA1sI/0vJv9ldYKbvBdBTQBPjJKcHm/Nh094Pia+TajwNCdrG6m1LfeWO+eJnbc9PIhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD3aWyMmT/oCk0bVsBtNdOVfiRaqANDvIbrWy1wC6Ok=;
 b=UDhEf9bci7p7nxincpp62IS20hbI/v1lVMtXjWNRc82ypyZiqaJ+sws1mo3dIsRDCvgctOzCxAbcbR7YYwInTXQqrt0PKHlEXgj4IULeur9aSbetjZbVuo388xee06IDQlBcRe6okuoRmGPO1wZ+LIvynRX4D5/FNKiMjJBi2gsD8laMXNHGFRO1IkSeajFNOlrYubKp1HbpYHDkyMuwPd6gl673WhiFLKVN0s5UMZh40wqmvX/22wCg8WICDG5N8eHALj1tfasGs9VDquw4a/4VI4wKDgfr0cr+GcIGbaazoc6cS4KIc0nAakIdqaGcgnUJ3aUfoBez5SVsywPfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0137.namprd12.prod.outlook.com (2603:10b6:0:51::33) by
 BYAPR12MB3398.namprd12.prod.outlook.com (2603:10b6:a03:aa::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 21:57:24 +0000
Received: from DM3NAM03FT022.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by DM3PR12CA0137.outlook.office365.com
 (2603:10b6:0:51::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Fri, 8 Nov 2019 21:57:24 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT022.mail.protection.outlook.com (10.152.82.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Fri, 8 Nov 2019 21:57:24 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 8 Nov 2019
 15:57:23 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 8 Nov 2019 15:57:23 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Load TA firmware for navi10/12/14
Date: Fri, 8 Nov 2019 16:57:21 -0500
Message-ID: <20191108215721.13316-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(428003)(189003)(199004)(70586007)(5660300002)(70206006)(476003)(305945005)(86362001)(356004)(50226002)(2616005)(126002)(51416003)(8676002)(81166006)(81156014)(426003)(1076003)(486006)(7696005)(2351001)(16586007)(336012)(47776003)(4326008)(36756003)(48376002)(478600001)(6916009)(8936002)(53416004)(26005)(50466002)(186003)(14444005)(2906002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3398; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71f6c105-d366-4d29-a743-08d76496a379
X-MS-TrafficTypeDiagnostic: BYAPR12MB3398:
X-Microsoft-Antispam-PRVS: <BYAPR12MB339812318E2C611A93F803EAF97B0@BYAPR12MB3398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-Forefront-PRVS: 0215D7173F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIDdTjfrSIJV33zz7C7GtIYTIsgUhXmgkFkNujUrIVXOgM7S+QBZbplO7a6QICIcD/wGrciQ+sIIc4C+1oHArnkYWXUIfhsZy7s3tdT7XaNnfuZ8iOrHY0vXqEJJoMkhfUXFaK0EkgWYDmmMCNYD2gYQSyEHZiL6s0uNWjtqAk7ghXbyYYoSXc/r/TS7Zk3+rm2QxK5Q1s7qhWUdEd/xoMVSTnM8vuw2IiRlW6yb2lSI0sn3abA1Pz2TLKMY/kT1wGF6ObrSrH2dY1P9l8JwFydQ0YxugCEZi9G/HTY6q4YQ82EENUQxdCwkw+WVoKOvb0n5ikvSRHL8yEasuQlhnIUTVRdhF13As4ZkE8YhJAz6mYmpwItL4icR+HHlHt3wJy/SnXqo6Eh9w+mA63r8exzKM4SLdErTlC+KXYYp72npbhoJHrewsXfhWfxz+/rY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2019 21:57:24.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f6c105-d366-4d29-a743-08d76496a379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3398
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD3aWyMmT/oCk0bVsBtNdOVfiRaqANDvIbrWy1wC6Ok=;
 b=3XPn2ofY6z7PzK/9peyu9TtlamAbASj9aZuV8LuovByvl+pgNUBOgsT4ZN9D1i7CQb7fSK5OYU/z45NLhnrZnbFarQ2sWar4qp2CgEYbzBFSQkFCyOLJX6M6f3XkjubJQXRMrCYwFYIRxHtgFoSQGUtqqeLHP1ONzATcBV4dzC0=
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108215721.j3Cxvt5JbLbPu-qgjVaGUAWptuShato2zCrAzsO6w24@z>

bG9hZCB0aGUgdGEgZmlybXdhcmUgZm9yIG5hdmkxMC8xMi8xNC4KVGhpcyBpcyBhbHJlYWR5IGJl
aW5nIGRvbmUgZm9yIHJhdmVuL3BpY2Fzc28gYW5kCmlzIG5lZWRlZCBmb3Igc3VwcG9ydGluZyBo
ZGNwIG9uIG5hdmkKClNpZ25lZC1vZmYtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5wcmVl
dC5MYWtoYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFf
MC5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDI1IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3Bf
djExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jCmluZGV4IGZm
ZWFhMmY1NTg4ZC4uZGFmMTFiZTU0MTZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9wc3BfdjExXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3Bf
djExXzAuYwpAQCAtMTg2LDYgKzE4NiwzMSBAQCBzdGF0aWMgaW50IHBzcF92MTFfMF9pbml0X21p
Y3JvY29kZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAljYXNlIENISVBfTkFWSTEwOgogCWNh
c2UgQ0hJUF9OQVZJMTQ6CiAJY2FzZSBDSElQX05BVkkxMjoKKwkJc25wcmludGYoZndfbmFtZSwg
c2l6ZW9mKGZ3X25hbWUpLCAiYW1kZ3B1LyVzX3RhLmJpbiIsIGNoaXBfbmFtZSk7CisJCWVyciA9
IHJlcXVlc3RfZmlybXdhcmUoJmFkZXYtPnBzcC50YV9mdywgZndfbmFtZSwgYWRldi0+ZGV2KTsK
KwkJaWYgKGVycikgeworCQkJcmVsZWFzZV9maXJtd2FyZShhZGV2LT5wc3AudGFfZncpOworCQkJ
YWRldi0+cHNwLnRhX2Z3ID0gTlVMTDsKKwkJCWRldl9pbmZvKGFkZXYtPmRldiwKKwkJCQkgInBz
cCB2MTEuMDogRmFpbGVkIHRvIGxvYWQgZmlybXdhcmUgXCIlc1wiXG4iLCBmd19uYW1lKTsKKwkJ
fSBlbHNlIHsKKwkJCWVyciA9IGFtZGdwdV91Y29kZV92YWxpZGF0ZShhZGV2LT5wc3AudGFfZncp
OworCQkJaWYgKGVycikKKwkJCQlnb3RvIG91dDI7CisKKwkJCXRhX2hkciA9IChjb25zdCBzdHJ1
Y3QgdGFfZmlybXdhcmVfaGVhZGVyX3YxXzAgKilhZGV2LT5wc3AudGFfZnctPmRhdGE7CisJCQlh
ZGV2LT5wc3AudGFfaGRjcF91Y29kZV92ZXJzaW9uID0gbGUzMl90b19jcHUodGFfaGRyLT50YV9o
ZGNwX3Vjb2RlX3ZlcnNpb24pOworCQkJYWRldi0+cHNwLnRhX2hkY3BfdWNvZGVfc2l6ZSA9IGxl
MzJfdG9fY3B1KHRhX2hkci0+dGFfaGRjcF9zaXplX2J5dGVzKTsKKwkJCWFkZXYtPnBzcC50YV9o
ZGNwX3N0YXJ0X2FkZHIgPSAodWludDhfdCAqKXRhX2hkciArCisJCQkJbGUzMl90b19jcHUodGFf
aGRyLT5oZWFkZXIudWNvZGVfYXJyYXlfb2Zmc2V0X2J5dGVzKTsKKworCQkJYWRldi0+cHNwLnRh
X2Z3X3ZlcnNpb24gPSBsZTMyX3RvX2NwdSh0YV9oZHItPmhlYWRlci51Y29kZV92ZXJzaW9uKTsK
KworCQkJYWRldi0+cHNwLnRhX2R0bV91Y29kZV92ZXJzaW9uID0gbGUzMl90b19jcHUodGFfaGRy
LT50YV9kdG1fdWNvZGVfdmVyc2lvbik7CisJCQlhZGV2LT5wc3AudGFfZHRtX3Vjb2RlX3NpemUg
PSBsZTMyX3RvX2NwdSh0YV9oZHItPnRhX2R0bV9zaXplX2J5dGVzKTsKKwkJCWFkZXYtPnBzcC50
YV9kdG1fc3RhcnRfYWRkciA9ICh1aW50OF90ICopYWRldi0+cHNwLnRhX2hkY3Bfc3RhcnRfYWRk
ciArCisJCQkJbGUzMl90b19jcHUodGFfaGRyLT50YV9kdG1fb2Zmc2V0X2J5dGVzKTsKKwkJfQog
CQlicmVhazsKIAlkZWZhdWx0OgogCQlCVUcoKTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
