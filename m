Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D5C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3548D20709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3548D20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1116F3E8;
	Fri, 15 Nov 2019 03:35:26 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690065.outbound.protection.outlook.com [40.107.69.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E606F3E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRdLtMF/05WTxoQ8eyTjiKTr1O0CNhdeILf8lIVssrUD7S4DUfDFG3I3kTPCw/Cwn2nX1x+ff+kW07OaTipg/7EIUpGXqPKE+l8Az2DJN2WLMY2PJxVxefXLH0oWlgu6AWNCttenoABawFksdA8HFOhKkc+pq7DqeWuzp13DwJXIibBIU4jbJihqWdw6Ku4f/faDCjFVVilbv99NG9tI5cTVa6iXc6USKvcPdn9qTVP4tSVK62boJTcM8nD+roaaM1HpRrh6f2IAZRiTomEG6B4nvL136z9+A4tRclrh3v12ybWQVoF5xnBmXC036/KK697nubrMNi03kgw8vFasWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgXa7jNJ8TAAEAu3rnPWYdRLVQiw2I7CUrr8W66sQuY=;
 b=i1zUWNny0mjL/U/kAasHe4Q2YvADvZO4kitZ6B4DEJCYGSqmyHwCcP7VIxDroWPnC5n8Qc5xt37qViY7NMGHuckVp7qsGu8Zor2rDAEXBxeCNRIbzcKKGCEMCzb6vg/ZlAXPTxUTAQr4xbPeN9IEhRIW8i5nB95i0jU+KHJ/yG/78B8GynZl2JAyvlRSCHt1c5F/N+euw8fA/Jy6DSgF1sayHWAR59CyrDUIsY/i6drBfHetx15E0tJ+Vu74r/Liek/4uUgiF6xC5obRweFLEQtNocmf1A/C/jieYSoU2RT9ZUDGJyJ9vLzrb3fm3naBbHEg784ZzX/npRHYPXrL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:25 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:25 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/12] tests/amdgpu: add secure buffer allocation test for
 invisible VRAM
Date: Fri, 15 Nov 2019 11:34:47 +0800
Message-Id: <1573788895-3936-4-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b177495-a91a-4341-6157-08d7697cd9d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36637F9EE3B6F23B2990BCD6F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(4744005)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3Ci6QGGl0f5fr3KZL3LvANxvNF84KDZYJm5N625RRQ63G9ZDmOyEdKo2Vtcp/kaUDwI3UBmo0LmOL2Q1bYh6ht5bpkuM1exX01CkjPeBd89GIiCJ5fkhbS3Gq6YuRdG0Kg3TjWB4Mft080LXz21tRzcIZNTMtbvaLyxmQtVlURb/P+bXvItoqAbplQX5T5d5LJo0pUsNovW2rgv16Vt8y2bZ0B0Pry4sfmBqC9J7+9S1x7XTTgpKovCJCD07MYzTnWD+6vJn8uOQuCIoiGP+mUS3Yq3Ek+EexYSLqGe6vosQNxXZC13tC5AbSlGvEHHfcP520SxVZU5YWVGPlZfStek5N5EVx4jKso6Ft66QGDyukSfd1+8KnciHPJGkEXumTnguDqAyOvO+E9/y1oiOe0DDwk/q3l03uolhdzHcboVFxdLshnM6+Lz4DEv2oX1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b177495-a91a-4341-6157-08d7697cd9d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:25.2385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycWzqgdBWLt7+vB+eCkrdqQExoMl9F/1OEa5yc6E3DxfDp5eP7k5FD8FL3Dpi4pC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgXa7jNJ8TAAEAu3rnPWYdRLVQiw2I7CUrr8W66sQuY=;
 b=cpfRp7wbVdKHA+NoIQUbe7lA6eqQblc/gyvcu5WAyHBJQ3IkxQq9oTHA2WkuBwzT1ZN9XQhFvloRVHuvhUKerdxJDY4NMbDz0jsScYpL43VPkOA1vZg1cD/4PnGPcyd/OsDTu1T5YV4Ju3dt9UP/bkoHFinTslOjdXI/ErdYHYk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Marek.Olsak@amd.com, Huang Rui <ray.huang@amd.com>, Luben.Tuikov@amd.com,
 Alexander.Deucher@amd.com, Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033447.voiMesVpjAqjz0EeOSIrWmL5eFI-F-EHfpNnEUd7eUg@z>

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClRoaXMgcGF0Y2ggaXMgdG8gYWRk
IHNlY3VyZSBidWZmZXIgYWxsb2NhdGlvbiB0ZXN0IGZvciBpbnZpc2libGUgVlJBTS4KClNpZ25l
ZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogdGVzdHMvYW1kZ3B1L3Nl
Y3VyaXR5X3Rlc3RzLmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jIGIvdGVz
dHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKaW5kZXggYWZlNzllNS4uYTM4MDdlZSAxMDA2NDQK
LS0tIGEvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKKysrIGIvdGVzdHMvYW1kZ3B1L3Nl
Y3VyaXR5X3Rlc3RzLmMKQEAgLTEwMiw0ICsxMDIsMTQgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Nl
Y3VyaXR5X2FsbG9jX2J1Zl90ZXN0KHZvaWQpCiAKIAlyID0gZ3B1X21lbV9mcmVlKGJvLCB2YV9o
YW5kbGUsIGJvX21jLCA0MDk2KTsKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CisKKwkvKiBUZXN0
IHNlY3VyZSBidWZmZXIgYWxsb2NhdGlvbiBpbiBpbnZpc2libGUgVlJBTSAqLworCWJvID0gZ3B1
X21lbV9hbGxvYyhkZXZpY2VfaGFuZGxlLCA0MDk2LCA0MDk2LAorCQkJICAgQU1ER1BVX0dFTV9E
T01BSU5fR1RULAorCQkJICAgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEIHwKKwkJCSAgIEFN
REdQVV9HRU1fQ1JFQVRFX05PX0NQVV9BQ0NFU1MsCisJCQkgICAmYm9fbWMsICZ2YV9oYW5kbGUp
OworCisJciA9IGdwdV9tZW1fZnJlZShibywgdmFfaGFuZGxlLCBib19tYywgNDA5Nik7CisJQ1Vf
QVNTRVJUX0VRVUFMKHIsIDApOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
