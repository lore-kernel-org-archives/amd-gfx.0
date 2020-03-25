Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F0C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 11:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB79B20772
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 11:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LzT1Qk9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB79B20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFD56E7F1;
	Wed, 25 Mar 2020 11:07:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2574D6E7F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 11:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxvEXzvH5EhpjQQGIbtBIKbia9RcjPiZxDdiR6qHiaezmMA4sswIkT9IY4rS4+j9fLbfp4XbC5DfJElKRHsZWzNmL8gFdKVsGEU3UiZ6sIc00f36rAqLk+l3N8w/tCI+AhCLoouAs79Ky2zrDjUUDlUqBamB95TVVWbcdl8HUED4GCdZUIoVm4vY5TA5BkCdPN5S25lStTwaMhWLe3q0SdqaQIe+rQVILbDIpS+feB1GFVRWl0QI7AvTfBPE1Bx7i2/TqKHLmZp/oBoy7Wsl38S1wt2XfzU9ytyw/OvRk4RdKygKkBT68RjkOuLzwLCfClX/n9b17dF9ZRWKjI6k1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F59djrP0cx8joczQ1mSKf1QUxLtzC+25YYD/uzmOaIo=;
 b=DZUFML3pseqebrts3T3cLjq+4yBGgBmiiZVgqpi0OrMVtbz2Vtb16qLSJwgf39GS8psrFb7wV+/lcnF8CN7N3Ai1jrJtBwfKGUxhN/7mV616bGSX1S+fVxA+eeiji/VWBrcsvCJMV0NOGom6OtvrPdJb7YnxE1EX96vgrgku0HaKIBSjti5k7s2YPSs7LFB0HJYXLJlZjXOWcv5Dz4FhF4sgjMv9SxcavDzmqDMQP/6HZUmiXkvWorYU0vrzxk5JVyOqp1KtFtucnkrk0WnOWTJfdnep+AQ66pYeTkyY0roGKcgwAcHdMIiGuGSgHVskLN8llaIassbcWUnZp40heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F59djrP0cx8joczQ1mSKf1QUxLtzC+25YYD/uzmOaIo=;
 b=LzT1Qk9pqom+1tyyRx5epwvgpjv+Hzoe1xre/IsYggtWc1Rd0D0kGgqYOWd2bv9GvTuEr3/CfQ4IpLRayPOtS0iXT1eDZGCculymkgDRNB3+Wbe990+DwTUrX4YOkO3Czj5CMHhFqkD6iPfacHW6LeQkImEtngPqVj98OdeW49E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2831.namprd12.prod.outlook.com (2603:10b6:805:ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 11:07:26 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 11:07:26 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Check entity rq
Date: Wed, 25 Mar 2020 19:07:02 +0800
Message-Id: <20200325110702.30919-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0198.apcprd02.prod.outlook.com (2603:1096:201:21::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 11:07:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 870df27f-ab73-438d-9070-08d7d0acb371
X-MS-TrafficTypeDiagnostic: SN6PR12MB2831:|SN6PR12MB2831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2831A3C587DC02287CF18F7087CE0@SN6PR12MB2831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(66574012)(54906003)(6916009)(36756003)(956004)(1076003)(6666004)(4326008)(478600001)(2906002)(5660300002)(2616005)(6486002)(52116002)(81166006)(26005)(7696005)(8676002)(16526019)(81156014)(186003)(86362001)(66556008)(8936002)(316002)(66946007)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2831;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8bqfgVANXCuhTuYI9KSParp38BYnlqaHVveO6JjEhfrAHbwflCDpkzKj3wsCpGBFJ3CoseGKvxhBh5kXNN+SkDq6UVzupv4OMkVLHXuHMNHlvNR1Qq7zB6IE3ohPjkdJQJy6RpsO8uu/weSTDdV6+KYE25mmLxb1PMiI/heQyV4DRucDAgjo2NUuuStUAncurbuVl+Co5cmVgBOYTaKRHdDzu+HmRfQ15hNfJee2fBslZTGsQHcy7GSpFN2k/42Ury8X8VPt5jGOQykxrdD0wLd9pgM6qoDuU1w5TCZwgZ/EGr7a2/RM5t1BYK+wUYoBP4C/fhONGREzd9Bh+eGQ58RXrTOH/b1UgSs4iCmGNF4qdxtZJbnzJIe++IQNQQwIlfdor+AFw+dWvOgYcHTI4pDbROrZ6vr8HTTmk94Pakr3vFG50SlGed4SSNb7hG7
X-MS-Exchange-AntiSpam-MessageData: hpJ4wVE3VoLtSp/GUloLBxNtrN+RGBXysI32HDL1GFsLhYeSaGcFpAJF5XwF+OUChiYGDOxH1huhq0K9iDHCvcLWXXIX3Zzw9SFCjbhE36l6mQ4lVgP2rL647V/y6kkibLyDjMFJlHgPv7yPLcq2lg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870df27f-ab73-438d-9070-08d7d0acb371
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 11:07:26.3428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKdXdlQFxiP0UFeiefOZn81aABBWc242n4zsdxHlmecI03I9zaMKfMyQXUG4XwB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
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

Z3B1IHJlY292ZXIgd2lsbCBjYWxsIHNkbWEgc3VzcGVuZC9yZXN1bWUuIEluIHRoaXMgcGVyaW9k
LCByaW5nIHdpbGwgYmUKZGlzYWJsZWQuIFNvIHRoZSB2bV9wdGVfc2NoZWRzKHNkbWEuaW5zdGFu
Y2VbWF0ucmluZy5zY2hlZCktPnJlYWR5IHdpbGwKYmUgZmFsc2UuCgpJZiB3ZSBzdWJtaXQgYW55
IGpvYnMgaW4gdGhpcyByaW5nLWRpc2FibGVkIHBlcmlvZC4gV2UgZmFpbCB0byBwaWNrIHVwCmEg
cnEgZm9yIHZtIGVudGl0eSBhbmQgZW50aXR5LT5ycSB3aWxsIHNldCB0byBOVUxMLgphbWRncHVf
dm1fc2RtYV9jb21taXQgZGlkIG5vdCBjaGVjayB0aGUgZW50aXR5LT5ycSwgc28gZml4IGl0LiBP
dGhlcndpc2UKaGl0IHBhbmljLgoKQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
Q2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5
OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm1fc2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwpp
bmRleCBjZjk2YzMzNWIyNTguLmQzMGQxMDNlNDhhMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCkBAIC05NSw2ICs5NSw4IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3ZtX3NkbWFfY29tbWl0KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKIAlp
bnQgcjsKIAogCWVudGl0eSA9IHAtPmRpcmVjdCA/ICZwLT52bS0+ZGlyZWN0IDogJnAtPnZtLT5k
ZWxheWVkOworCWlmICghZW50aXR5LT5ycSkKKwkJcmV0dXJuIC1FTk9FTlQ7CiAJcmluZyA9IGNv
bnRhaW5lcl9vZihlbnRpdHktPnJxLT5zY2hlZCwgc3RydWN0IGFtZGdwdV9yaW5nLCBzY2hlZCk7
CiAKIAlXQVJOX09OKGliLT5sZW5ndGhfZHcgPT0gMCk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
