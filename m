Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5CFC43215
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598E0206C0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598E0206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020A26E4FB;
	Thu, 14 Nov 2019 09:07:50 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790041.outbound.protection.outlook.com [40.107.79.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568EA6E4FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 09:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AokwQwJljQTW2Lpcp6DbGq+jBaQF4bdx24lVhD+C9uF73xGvJ/gYSRlCAH0xnGKYd02sf8wlyECGvICk1PDz4rThoW/RF7cphSvSg5X+IDcqlY9iIZnOEKtLqZzmKq3d4esYspHgP8uKtwR73BuAJNSgCR9yXM0DfwD0S1xM/ZPt44ki9E4xHTK0SHRCRnsexb4HlcAKzaZZfzudB4xo/cNlc+46agWdMhrW0TLWwdZcbcMT62q616s+BKizNQK86s+W/62kGD1HK+Jy7Vj0wSUyB8rjEroGigUO3R++csPhRtVwcPT+5JjQTSLHLCfNPxcDad6gshCVEFPaGIongg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bddDJkV2FvJ4kRYVsMviswxRBa6TSoI7gv1vwsAWuxQ=;
 b=b8JBclFuqPRQ4EaTVC2rSsiPTxC4eFOplntwFDtgeehReSiekZDG53HAQnqLmbFtMd4/oUnhB54BLTuIIYjKyxD75y+IGPL/srZBi1bgMY31z/7lvvzC1ddjwVdXrMRNy10NvpgAdN6XAWa546s56sOl4QRPyajUVUKG5f9o/rt2fg/gpgN2E6tEft6z0kEm9qIiCjTgs7k+DU1yc+H+GuYiMhlCEdEH9NWIlFTfDwkx90KW5PsVYtJZ6/qye1kXj3t8+59V5iORpYjncXw5Zw8394W/EEOg67n2VgdfgjOwK8cUeHc9R/EY0+2LYwLH3Qx4d20mrTkPZOVK7kMV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4000.namprd12.prod.outlook.com (10.255.238.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 09:07:48 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 09:07:48 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: correct fine grained dpm force level
 setting
Date: Thu, 14 Nov 2019 17:07:20 +0800
Message-Id: <20191114090720.14342-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a35603b5-2097-4247-522d-08d768e21e35
X-MS-TrafficTypeDiagnostic: MN2PR12MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB400020E149EF8648BD4DDB31E4710@MN2PR12MB4000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(66066001)(2616005)(4326008)(386003)(50466002)(50226002)(305945005)(26005)(14454004)(7736002)(186003)(476003)(86362001)(48376002)(44832011)(6436002)(47776003)(486006)(8936002)(6512007)(8676002)(6916009)(81156014)(81166006)(6486002)(99286004)(2870700001)(478600001)(66946007)(1076003)(6506007)(316002)(66556008)(2361001)(6116002)(3846002)(52116002)(6666004)(2351001)(51416003)(2906002)(25786009)(5660300002)(36756003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4000;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyPzW9b3qjntcXr1HRELlg5jKX/PtgasOTT7i2D/Ou09RQdJaP+50p9jFMyg3RsLPuhLKJJQKh8anrq0ZfwbU8xkN4ws9aJjPxotDiL8/1SE6LpCcCZzi+iGr393jQ90/nrOyam4mDOSOIvBi0METIu6rNfEKYUOoKRe3DzHEKDS7p2WNkCUxY2wF66L4coxnEE5Dl6EjoWRUZre9qFZb55OhSY+inRa1gSZEbkDtHvchagqaYRKP2Sa2xiCM9Vi4MjcvF5fCfVomb/xrzGrcDb5boP2u40ESl3NJ4YQr4O5A+cieZL//9JM4JikDFuOQkhbnpOouzqj3Wf+ASapn6lq4I666I2NEBQVYLdSrpSwXeycomp53L0xw4OHvfUGbxS0khPY0gzFjKX2IM979qvwM/Y7T2m7yIXIKlx4FvLAMfBB0SxkBsmJfX0vesSl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35603b5-2097-4247-522d-08d768e21e35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 09:07:48.0579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBn5OyNcyUwlXnLxJ46+pTEJD6uKOhFQTjs5rJ593YDsjYLDhdkRWW1PCFvQJ33N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bddDJkV2FvJ4kRYVsMviswxRBa6TSoI7gv1vwsAWuxQ=;
 b=fGn9PSpiWIGZH5lFCDgmUhT3+G16PYsh5IikxRn1sGEuP3LCUrMdpIBakTzdf3ztheztmtTlAzhg6y50vV3wnU24NR50pjHuVHND7YSzfyX9eNb946HGaCT3AMtmyCsZ/Fg84fcQo0N3oNPvQf72by6AIkHbJqmmYVC36D7Xmzw=
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114090720.bb2ihJcqZBMowq9plFUjRQn3vrlbi4aOfd5pNb0K7Is@z>

Rm9yIGZpbmUgZ3JhaW5lZCBkcG0sIHRoZXJlIGlzIG9ubHkgdHdvIGxldmVscyBzdXBwb3J0ZWQu
IEhvd2V2ZXIKdG8gcmVmbGVjdCBjb3JyZWN0bHkgdGhlIGN1cnJlbnQgY2xvY2sgZnJlcXVlbmN5
LCB0aGVyZSBpcyBhbgppbnRlcm1lZGlhdGUgbGV2ZWwgZmFrZWQuIFRodXMgb24gZm9yY2luZyBs
ZXZlbCBzZXR0aW5nLCB3ZQpuZWVkIHRvIHRyZWF0IGxldmVsIDIgY29ycmVjdGx5IGFzIGxldmVs
IDEuCgpDaGFuZ2UtSWQ6IEkzMmY5MzY2MzZmMjdlYjhkOGQ5MDAyYmVkZDcwMWYyYmIwZDMwNjBh
ClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jIHwgNiArKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9u
YXZpMTBfcHB0LmMKaW5kZXggYzRmODQ2MjdjZmQ5Li4wYmJlMzQxMmQ5YjUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKQEAgLTgyMyw2ICs4MjMsMTIgQEAg
c3RhdGljIGludCBuYXZpMTBfZm9yY2VfY2xrX2xldmVscyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwKIAljYXNlIFNNVV9VQ0xLOgogCWNhc2UgU01VX0RDRUZDTEs6CiAJY2FzZSBTTVVfRkNMSzoK
KwkJLyogVGhlcmUgaXMgb25seSAyIGxldmVscyBmb3IgZmluZSBncmFpbmVkIERQTSAqLworCQlp
ZiAobmF2aTEwX2lzX3N1cHBvcnRfZmluZV9ncmFpbmVkX2RwbShzbXUsIGNsa190eXBlKSkgewor
CQkJc29mdF9tYXhfbGV2ZWwgPSAoc29mdF9tYXhfbGV2ZWwgPj0gMSA/IDEgOiAwKTsKKwkJCXNv
ZnRfbWluX2xldmVsID0gKHNvZnRfbWluX2xldmVsID49IDEgPyAxIDogMCk7CisJCX0KKwogCQly
ZXQgPSBzbXVfZ2V0X2RwbV9mcmVxX2J5X2luZGV4KHNtdSwgY2xrX3R5cGUsIHNvZnRfbWluX2xl
dmVsLCAmbWluX2ZyZXEpOwogCQlpZiAocmV0KQogCQkJcmV0dXJuIHNpemU7Ci0tIAoyLjI0LjAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
