Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0843BC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 03:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CA7222DD
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 03:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CA7222DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717156E159;
	Tue, 19 Nov 2019 03:57:39 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB0B6E159
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 03:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTuu0eG16iG9kwKxHY3SJUg71ua3he/r/lBD+sTXD/KUS0gsJFNm6ffAOZ3/GxGePe8r6tIaC4r8MUpHhhmgq4+RKhwoBz/sE7Ma3jXFjyeMq/pExfcIwwfIBu5kzO0+TJ/EvjlJk27wTM2UhkITfxNaV/CVU7b0qcdDQHZ8DLSKOi9HtfHPfRJ/rsPSrE+smsavrc7uitte86R7s86Yu2vOyjjs3OCsTORcB8v1QrsHJcAJ8EUpqX3Ooo2jw8MuN1GJGv5I13BokVjnFRRlDIXFX+D/pIPTPANyM1Ul3K90rtStzPXDaTR7tUCgYk3mwS5IATcrBC+MQ5IEITpx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0N2PMsVPLeesxA1Y4GL+WKZGdqyGeSbXcJvc1109RM=;
 b=BU2KMziFQBzYtW7Ujc9OShHiXWqBb1WMVEQ/Kk4GbBPm63vmMs4KfzU8AArJssgJJQQlXkdawaAlYdLqQ6+kk5CRREKbnxjKwDebgobEHvCXzCIuzFL6JdMUAL0wdjLp6WNeVM0V1lOjER4KYCqJLlxBi6bxc7Jz4ENpLFgz9UwuPCF/C/hG9y1QaLAOlDR3hL2B9lESQcAqoFqB9pYEGewHzB0jNygPkoC9mENVu0m1Xb4lXMGH0Xm6cNn10yYscyyWio/qvcXw8Nzm/ZhM4GIjSg3BiFxGDSAGK5x6oc643yd+psZvXQTG1xBkRkNGNU401v52xT7qN1FhDXqdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3328.namprd12.prod.outlook.com (20.178.240.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 03:57:35 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 03:57:35 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: add missing header file declaration
Date: Tue, 19 Nov 2019 11:57:12 +0800
Message-Id: <20191119035712.22785-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR04CA0049.apcprd04.prod.outlook.com
 (2603:1096:202:14::17) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dcc8914-d6f6-4d15-bf6d-08d76ca49c48
X-MS-TrafficTypeDiagnostic: MN2PR12MB3328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB332840A5F77B530B0D01BE15E44C0@MN2PR12MB3328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6512007)(8936002)(81156014)(6436002)(14444005)(81166006)(486006)(4326008)(6916009)(6506007)(47776003)(316002)(36756003)(386003)(186003)(99286004)(6486002)(66066001)(50226002)(26005)(44832011)(478600001)(305945005)(25786009)(2906002)(50466002)(2870700001)(1076003)(23676004)(52116002)(66476007)(66556008)(5660300002)(2616005)(6116002)(66946007)(3846002)(476003)(8676002)(6666004)(14454004)(2361001)(7736002)(86362001)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3328;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgq3uvRi7zXuTcMxqGxSbXev1r9Tj8vlWMUd4B9oyveGPwqR0osKyeXdUcdGOhOQKW+v7J9vIDgK5l7CBjva4M8/5Y48VlbZeUxOlBFXkLtnY4lvyza1B6z6DoTT+DA3eWSeKuJbalvMcZ+6ZB9Z8d08pb6+KHJlcxflqs9GxjpM9dPKBNJyNskzL7xBIjj2SVZtylQIDMgAziMJHXVvy0nLZDAVgclnkCSeouPThnKW35Kr5RjBs/9gl6ZUdJKJCdTU6FJV5ZZ2VAhWLNRJ62In9n4l47Q24QA2Raj4J0Lc7uTBTjyQXwnkkHq5seBzDeg7/6W64xSIMZqkHNRw3AZ+Jfwk2kGHdSKGo1KfblN1vur+pO0TlrFRFg79+VqSl92zAPv5zde6mPXL43yrM3SMeTvgmH4CuYDStIchhzM6H5WelipTDmoiJymkhFWX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcc8914-d6f6-4d15-bf6d-08d76ca49c48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 03:57:35.2861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNxyGz2qg79rhBZsjg6NENkPYjQodUdXfdoFNQ5t7nVz5iIMKSQ3zaTc0/M2+XI7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3328
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0N2PMsVPLeesxA1Y4GL+WKZGdqyGeSbXcJvc1109RM=;
 b=GewgZdV9flJSXVGqGcfaoVRSKoNDnZdqmcn6TKft+pg2q4G2gIke6iFqsK3kgQ4VTPogUUPkZzG1IDyIEX8jMwSQIY7PWOZezvaun1cBCG8f4nMVtVmryOFJ6d3jYky0G6TCJfrZyTw062JFprrqwZcBq2R+E3KsgJFOSCu9/XY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: Evan Quan <evan.quan@amd.com>, Aaron.Liu@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119035712.4J2IeYIeJRRXBwNIimaNpJ1O7l-USLDqpuYWNnfkxu8@z>

VGhpcyBjYW4gZml4IHRoZSBjb21waWxlIGVycm9ycyBiZWxvdzoKZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vcG93ZXJwbGF5L3NtdV92MTFfMC5jOiBJbiBmdW5jdGlvbiDigJhzbXVfdjEx
XzBfYmFjb19zZXRfc3RhdGXigJk6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2Vy
cGxheS9zbXVfdjExXzAuYzoxNjc0OjI3OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2Yg
ZnVuY3Rpb24g4oCYYW1kZ3B1X3Jhc19nZXRfY29udGV4dOKAmSBbLVdlcnJvcj1pbXBsaWNpdC1m
dW5jdGlvbi1kZWNsYXJhdGlvbl0KICBzdHJ1Y3QgYW1kZ3B1X3JhcyAqcmFzID0gYW1kZ3B1X3Jh
c19nZXRfY29udGV4dChhZGV2KTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBsYXkvc211X3YxMV8wLmM6MTY3NDoyNzogd2Fy
bmluZzogaW5pdGlhbGl6YXRpb24gbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBh
IGNhc3QgWy1XaW50LWNvbnZlcnNpb25dCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bv
d2VycGxheS9zbXVfdjExXzAuYzoxNjkyOjE5OiBlcnJvcjogZGVyZWZlcmVuY2luZyBwb2ludGVy
IHRvIGluY29tcGxldGUgdHlwZSDigJhzdHJ1Y3QgYW1kZ3B1X3Jhc+KAmQogICBpZiAoIXJhcyB8
fCAhcmFzLT5zdXBwb3J0ZWQpIHsKCkNoYW5nZS1JZDogSTEyNDJlNjRlODI3MTU3NzRiOGUyOTMx
NTMwNzQ5NzgyYjkxMDdlMzIKU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyB8IDEg
KwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9zbXVfdjExXzAuYwppbmRleCA4YjFjNDE2NGExZjYuLmY2Nzc3NDNjYjUxMSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKQEAgLTM3LDYgKzM3LDcg
QEAKICNpbmNsdWRlICJzb2MxNV9jb21tb24uaCIKICNpbmNsdWRlICJhdG9tLmgiCiAjaW5jbHVk
ZSAiYW1kX3BjaWUuaCIKKyNpbmNsdWRlICJhbWRncHVfcmFzLmgiCiAKICNpbmNsdWRlICJhc2lj
X3JlZy90aG0vdGhtXzExXzBfMl9vZmZzZXQuaCIKICNpbmNsdWRlICJhc2ljX3JlZy90aG0vdGht
XzExXzBfMl9zaF9tYXNrLmgiCi0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
