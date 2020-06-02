Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FBC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7A3206E2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qPwpGk3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7A3206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B394489817;
	Tue,  2 Jun 2020 18:27:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC64A6E450
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 18:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo1q82QJtPp/GQYYSHjOjAX1LrT5kGH2CF/p6lS8XXbbbbdGH2CXcx4L/8vyfWgzO7CT8vLVeYojH/vR+ByIzHflGaH1adYKzGdx30x72yVWiYgqeu/xAnfuYRKtIr5yTuHf4ABdpSl/cy563gUo206sgBcsHHP68U7usWYX3pn6fFTcuUth27wFvRdG6teJgAQXGTZvllmUdYMHxpdbG/Rvi3jnxyw9S73ENyq7yqVXsHoEvBIx2XXfV4HTw4kJ7co2Nf4KuNPl9Qy6vPV2wA+gJFn4tYqadp9AUCCwQUj8MYFCfbyFBSJmmymXn+wB/wvsyY9QFHSFp00NbptgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saonnp0RSPVx/h3KUm6wZYyf/hXngx151i5k/N1mcz4=;
 b=FjXQQAbLXlb1Z+pcNKBUK0/cm97iLYjnCn/HCMTAedVGWvLSi5aUO+pTvxvD3pNYm3+ERjkBUyRBdqoY/FqMV0sQh/YxkA+DcY2686TXKt9PWk/uqsZ9LWrxFqmASsq/Wc209/zj2ohhQukVgCKZzWr3Te6qcWM/HMEWy9BePXmFQEuxADAuZEpAwbBtJlQLZQP3bw84yX6hD3i+4uDfLPKgbNC55XF0yu5bzTE/pmrF738tR4Wkdqeiaz8mFycSIbvKVV1IpwWbQeaUNXYAx/IsPNiUPHHZ/PijR4sAn/+Mxe/+yGqRL0cbItOufnAQv5Kzz0Fljtnd2ru0kyef8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saonnp0RSPVx/h3KUm6wZYyf/hXngx151i5k/N1mcz4=;
 b=qPwpGk3CcUAASf910t4nOYOpFyCMKq3aIk8fmbasJGn+ffJhdyT9wE2+mfeBqKX8C7+uiJKzbnYgU1Ct/LOcI3IdS0aRU4+WAgxPOgz0GUIUN07vorB4GPtDDqc6WC9OnodD+qR1erTTT13xMFYtWAKp6jVR5T0/Lmt4zJm3YHw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 by BN6PR12MB1217.namprd12.prod.outlook.com (2603:10b6:404:20::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 18:27:49 +0000
Received: from BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2]) by BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2%12]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 18:27:49 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: restrict bo mapping within gpu address limits
Date: Tue,  2 Jun 2020 14:27:35 -0400
Message-Id: <20200602182735.5940-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To BN6PR12MB1155.namprd12.prod.outlook.com
 (2603:10b6:404:1b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.22 via Frontend Transport; Tue, 2 Jun 2020 18:27:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d4e4661-b09c-4f10-2643-08d80722a756
X-MS-TrafficTypeDiagnostic: BN6PR12MB1217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1217484010C8E333000EF668FE8B0@BN6PR12MB1217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0O0egsifWnO12EBIrbnNDXkM4Le5rzy10G99yoEdf9tCqQ08N1UNGoOeE1V7IwmM0M8U8irjGsMoIwJRqSS6ViGHpQncDjuZ1/XZE9WW09wFy7vaSyjXQdN4vPkkPZLr6O+ccmgDOx9vK1CS22PDoNnSTZ6SccvIVVr1AGlCA0P0Akv89Gv7YZxYVrU2mZULqNpxE3WY7zr7g+4AXT4qUeZr4PR8Dp1Q9yjW1R8I0T0WvVeqn3E/LW+muYnMxsYyKQMx0zXX3U6wFtDWRsOlUXUapEloKuHWU7epiamVu+JDB4zah4/kKOGTzu0PcFsBjGGbqcgT34BHWHy83pa+RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(8676002)(2616005)(956004)(316002)(16526019)(7696005)(52116002)(8936002)(186003)(86362001)(44832011)(26005)(66476007)(478600001)(4326008)(6916009)(66574014)(6486002)(83380400001)(2906002)(6666004)(36756003)(1076003)(66556008)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8cBD0l1a9UZExEs8cnIbC4JMAonB+6xmB5mmovUKYAvtAp+TkNTQmjWbjFLG0GhYCZHIbiP9xomxV/K8TeL6j581S7CNBU/ekraEbqeE+ZyVbw73dx8SwXyhGVllZbOOIi5xjQ0+0XuQhrznzz6XYuXM4aI6L/tn2omC6JwFNTj4JUskqeoLNxLpO9w3SYAPWrGP8QFAcP8g69o3ofBB/YdZKC4ubSc8N/Pn3qrb/1/Crg7DDKBTlFj3GXjgP8Jw4Su/6xe+G/zpSQBT6NHLxPzwPYK3WL4F+T1e92t6mjIaV0q5wAdAEbSBeWD3X4ATpnz7QZTNpHqj+gxTmmj1QsmhQh7k5Gzno2AB2Dt34rvmhu/2cZ6gh9p4LwzkfpeH+z7NSswBYLeg26xiDBN03yq8zL1nlfzI83wxpFoYZ7KGRBNNQ1c1LZIBGojiVMdVomXKa3VQL6TEknuQ1lxdZPAJYUBBvr4O81Zef4LIg5QYnXgthhPG9uYIRffXn76B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4e4661-b09c-4f10-2643-08d80722a756
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 18:27:49.3267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KliLSFADsM01MFKz4NyWenRRQAz4sdPfnToQGZY3YNV+XFpVsfNiyqlbJMOxMDsWn/GpLpCjw8cXuAgw5mWevQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1217
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGF2ZSBzdHJpY3QgY2hlY2sgb24gYm8gbWFwcGluZyBzaW5jZSBvbiBzb21lIHN5c3RlbXMsIHN1
Y2ggYXMgQStBIG9yCmh5YnJpZCwgdGhlIGNwdSBtaWdodCBzdXBwb3J0IDUgbGV2ZWwgcGFnaW5n
IG9yIGNhbiBhZGRyZXNzIG1lbW9yeSBhYm92ZQo0OCBiaXRzIGJ1dCBncHUgbWlnaHQgYmUgbGlt
aXRlZCBieSBoYXJkd2FyZSB0byBqdXN0IHVzZSA0OCBiaXRzLiBJbgpnZW5lcmFsLCB0aGlzIGFw
cGxpZXMgdG8gYWxsIGFzaWNzIHdoZXJlIHRoaXMgbGltaXRhdGlvbiBjYW4gYmUgY2hlY2tlZAph
Z2FpbnN0IHRoZWlyIG1heF9wZm4gcmFuZ2UuIFRoaXMgcmVzdHJpY3RzIHRoZSByYW5nZSB0byBt
YXAgYm8gd2l0aGluCnByYXRpY2FsIGxpbWl0cyBvZiBjcHUgYW5kIGdwdSBmb3Igc2hhcmVkIHZp
cnR1YWwgbWVtb3J5IGFjY2Vzcy4KClJldmlld2VkLWJ5OiBPYWsgWmVuZyA8b2FrLnplbmdAYW1k
LmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4K
QWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVk
LW9mZi1ieTogUmFqbmVlc2ggQmhhcmR3YWogPHJham5lZXNoLmJoYXJkd2FqQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA2ICsrKystLQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IDc0MTc3NTRlOTE0MS4uNzFlMDA1Y2YyOTUy
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMjIwOCw3ICsyMjA4
LDggQEAgaW50IGFtZGdwdV92bV9ib19tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
LyogbWFrZSBzdXJlIG9iamVjdCBmaXQgYXQgdGhpcyBvZmZzZXQgKi8KIAllYWRkciA9IHNhZGRy
ICsgc2l6ZSAtIDE7CiAJaWYgKHNhZGRyID49IGVhZGRyIHx8Ci0JICAgIChibyAmJiBvZmZzZXQg
KyBzaXplID4gYW1kZ3B1X2JvX3NpemUoYm8pKSkKKwkgICAgKGJvICYmIG9mZnNldCArIHNpemUg
PiBhbWRncHVfYm9fc2l6ZShibykpIHx8CisJICAgIChlYWRkciA+PSBhZGV2LT52bV9tYW5hZ2Vy
Lm1heF9wZm4gPDwgQU1ER1BVX0dQVV9QQUdFX1NISUZUKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAK
IAlzYWRkciAvPSBBTURHUFVfR1BVX1BBR0VfU0laRTsKQEAgLTIyNzMsNyArMjI3NCw4IEBAIGlu
dCBhbWRncHVfdm1fYm9fcmVwbGFjZV9tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
LyogbWFrZSBzdXJlIG9iamVjdCBmaXQgYXQgdGhpcyBvZmZzZXQgKi8KIAllYWRkciA9IHNhZGRy
ICsgc2l6ZSAtIDE7CiAJaWYgKHNhZGRyID49IGVhZGRyIHx8Ci0JICAgIChibyAmJiBvZmZzZXQg
KyBzaXplID4gYW1kZ3B1X2JvX3NpemUoYm8pKSkKKwkgICAgKGJvICYmIG9mZnNldCArIHNpemUg
PiBhbWRncHVfYm9fc2l6ZShibykpIHx8CisJICAgIChlYWRkciA+PSBhZGV2LT52bV9tYW5hZ2Vy
Lm1heF9wZm4gPDwgQU1ER1BVX0dQVV9QQUdFX1NISUZUKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAK
IAkvKiBBbGxvY2F0ZSBhbGwgdGhlIG5lZWRlZCBtZW1vcnkgKi8KLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
