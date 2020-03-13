Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA5C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 11:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAFB206EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 11:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JgxuPryE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAFB206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035FA6EBCE;
	Fri, 13 Mar 2020 11:53:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407B76EBCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 11:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV0I1ZxEC+8FyuJ85ilwXfpt5/L/hYpORIaASFl3tn9Fthllk/i/KStSlfuuGLw/TfLdnJtbO2bUZSCkhOWQRRQQbvvw3qNythKVb+2lPSe3smWn+DjxC5Hvwrd6b561v7xG3AMy/tGoda3QVkHOYNM8ZPYEtID4ppFLLxDp6WQSM8wKW/823GZuHtzLjWdPW9WvR2h9XDVm0LX7oTF/9UxKIUZqtGmbvx87QKwGFxAVwOirpzZZ+hEQ9x8Ob+5HKfwBUcNHrwZxhC/veuUSSKzoFiwc8bkeQ7tV1RG5qXkcBfOX5ZSuh4lCAQxo6KGF1bzIeLeJmZ4dpZH5bTIS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2DvKzPTas4twa6xs6Nm1zgdbMQCeTM+4j6pf21YAyA=;
 b=Td1K6FogeBijhQ5oKcsp9PwQulPvDP7B6NnczffVPUO/rJ4sPXLG/SqOhMVfBUUwllmX5T82huVABEgzk7hOnMHBElTkyFidwonA/ywDOjepjZ82TS59OwprIHNdsf7PhpCZ+HMbOUPd/xDqAYpBb2E25UjZ6Mf8uOFUx6fMLwXm2Z/9YnwvmkbTb0bhwSBuLHgMA76xFHeJN7/RXs9dtwxU2E0HwFbjLwgunW9r/cu/PZab2Rwjk0tgX+q8+quYLuH5e0U8KqQT/cp5WSsIgLmMFP+Yaus5+uvM+gWGAZMWqg3GjrCvBzjpUM7wOmSy9dr7OD5/ZcEdN1+VjmZ3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2DvKzPTas4twa6xs6Nm1zgdbMQCeTM+4j6pf21YAyA=;
 b=JgxuPryEv0/M1N6/rwHODvAMtqS+kr4HIdijH87RO0Cqn3j3mGZB2mqH8nDa9zmkP33T5cWKUSU9ooGy5gGhCxu75+Oz95xLtLlomZa9oFTJxqlmdqDNHlJcKkjFkTd2nRWOb0HiNqD5NE6QF2lN8RvngS5ssGv8gYKBPIfNSJI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2734.namprd12.prod.outlook.com (2603:10b6:805:76::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 11:53:25 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 11:53:25 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
Date: Fri, 13 Mar 2020 19:53:04 +0800
Message-Id: <20200313115305.32325-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.10 via Frontend Transport; Fri, 13 Mar 2020 11:53:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a889c5f-f723-47e6-5d5b-08d7c74522e6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2734:|SN6PR12MB2734:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27342825E3D24D458C88F79687FA0@SN6PR12MB2734.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(1076003)(26005)(86362001)(36756003)(5660300002)(6916009)(478600001)(66574012)(6666004)(81156014)(4326008)(52116002)(7696005)(81166006)(2906002)(8676002)(8936002)(66556008)(66946007)(16526019)(6486002)(2616005)(66476007)(186003)(316002)(54906003)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2734;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2SH2uWHlLvmBG84kDe/HtUpMpzeLVt1QZo39cm9omKypMRVQscCJ1PAZDXrX8oe+zcbXK239ZUmE5932LMYoNdWOHlwcf9KO1tlNEq0aTRxFldletuLel+ldF1u4iCadEitGu7CQaEDlxaK9MGxUULiVqerj+sIfHFxrojsiYZlErlcabi3vZmmTfXOQ+MniI6hGGKFD3fTiFCdFS8HrLqYDQKb2BNEcy51IpeSZankJwi3x7BDUaZsWMrgiIc5GcOdsT9fujTaXuDPVuDEZbY8HGyFRMbUTX9drm4vwR0Puh90IxVA4X3LrJgqXFTLgWhymm9cxm/FBwHYx7bGJBEcmZ31i3Dc0/EKgwjUiz+5f2Cp1ERY8htpEsd18LVUfSg85Gip5/RD026XccfwfdM2a71JDn+vOF/HsoH/VF2CTZKTFdmoHlXr0+xGSkgi
X-MS-Exchange-AntiSpam-MessageData: VlMGiX2k4SzTj1y76OpVKNIPsEyTpPBLQzyMcc18DPc9fih/r8gp1Px69woCpHLCUWcsd6zmj3/AXVk+2SvHZpZ2cfB9svYceVBoziV2SrSPVBidzFnLOghDUcrjU2MVqWtJ6t/8RryyfN+YJtCXyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a889c5f-f723-47e6-5d5b-08d7c74522e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 11:53:25.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5AhNpwNCEO7skAa4y1Fo2DAZ1mR0CovX8URGqDQzFjF7q5FZbapXqTuVo3WzQsA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2734
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SWYgYSBqb2IgbmVlZCBzeW5jIHRoZSBibyByZXN2LCBpdCBpcyBsaWtlbHkgdGhhdCBibyBuZWVk
IHRoZSBqb2IgZmVuY2UKdG8gc3luYyB3aXRoIG90aGVycy4KCkNjOiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CkNjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4KU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+ClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCAgICAgIHwgNSArKysrKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyB8IDkgKysrKysrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5oCmluZGV4IGI1NzA1ZmNmYzkzNS4uY2E2MDIxYjQyMDBiIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaApAQCAtMjI2LDYgKzIyNiwxMSBAQCBzdHJ1Y3Qg
YW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgewogCSAqIEBudW1fZHdfbGVmdDogbnVtYmVyIG9mIGR3
IGxlZnQgZm9yIHRoZSBJQgogCSAqLwogCXVuc2lnbmVkIGludCBudW1fZHdfbGVmdDsKKworCS8q
KgorCSAqIEByZXN2OiBzeW5jIHRoZSByZXN2IGFuZCBhZGQgam9iIGZlbmNlIHRvIGl0IGNvbmRp
dGlvbmFsbHkuCisJICovCisJc3RydWN0IGRtYV9yZXN2ICpyZXN2OwogfTsKIAogc3RydWN0IGFt
ZGdwdV92bV91cGRhdGVfZnVuY3MgewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bV9zZG1hLmMKaW5kZXggNGNjNzg4MWY0MzhjLi4wY2ZhYzU5YmZmMzYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwpAQCAtNzAsNiArNzAsOCBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV9zZG1hX3ByZXBhcmUoc3RydWN0IGFtZGdwdV92bV91cGRhdGVf
cGFyYW1zICpwLAogCiAJcC0+bnVtX2R3X2xlZnQgPSBuZHc7CiAKKwlwLT5yZXN2ID0gcmVzdjsK
KwogCWlmICghcmVzdikKIAkJcmV0dXJuIDA7CiAKQEAgLTExMSw2ICsxMTMsMTMgQEAgc3RhdGlj
IGludCBhbWRncHVfdm1fc2RtYV9jb21taXQoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1z
ICpwLAogCQlzd2FwKHAtPnZtLT5sYXN0X2RlbGF5ZWQsIHRtcCk7CiAJZG1hX2ZlbmNlX3B1dCh0
bXApOwogCisJLyogYWRkIGpvYiBmZW5jZSB0byByZXN2LgorCSAqIE1NIG5vdGlmaWVyIHBhdGgg
aXMgYW4gZXhjZXB0aW9uIGFzIHdlIGNhbiBub3QgZ3JhYiB0aGUKKwkgKiByZXN2IGxvY2suCisJ
ICovCisJaWYgKCFwLT5kaXJlY3QgJiYgcC0+cmVzdikKKwkJZG1hX3Jlc3ZfYWRkX3NoYXJlZF9m
ZW5jZShwLT5yZXN2LCBmKTsKKwogCWlmIChmZW5jZSAmJiAhcC0+ZGlyZWN0KQogCQlzd2FwKCpm
ZW5jZSwgZik7CiAJZG1hX2ZlbmNlX3B1dChmKTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
