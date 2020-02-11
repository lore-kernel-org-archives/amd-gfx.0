Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4BFC352A4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 02:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DC520714
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 02:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KZ+OkM1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DC520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402FE6E290;
	Tue, 11 Feb 2020 02:33:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9546E290
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 02:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCnhGV4RaXqPHSNiVr84skNUSjn/rAlKAVkJATkPJprmPNne3Z/uO3UGY71rtf/4Cc/bTbBIXKvr4BuRIocG4Z5bfetLvnI3aH1j4Vog/bw3wQTH3jc8Epx33LEMw6N+4ncLnh23kbNkyQD92ba67E2/q6bsCJCycRZiW61B4CC63JeiBhNaHy+fEhhmV0Vg495qH377T8OeAnZtN7BO9SU1VD+cOPpayK7y6vQDPYsFHcdMoujqdXg9ZD66d3nPfj9zb8nRuS4Om0M5Fl6/9nIwKUNnfE6MFpJ16G8fPIQYlUAp3z5cepXxDEShAzkdaTXnJj6u5FeBUerUGOPtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnWt7NgSwEctAy+Aea6ZWdeUfrGiiMS10sRmTBnlzbA=;
 b=bygOykIufPddUarg+CR9el5dRPmgr3yKIHbElcLOaoCei1X888BEwxJXqrvtBrGma+6V2qn8XWQPQ3XUW8OVa/s86WWBNAcgg3nGQ4LldLQryM8DIkwLmiTn3w2nn4ZpygFTwDfRX3M3sYQY1FciNpmomC5ts7ko95O7WBLA7AhIS6ZKoacxI0Y2Si/uMTl/daUNTWi9dRLVI9OP6PFdydeqVDghgbWvBzYgzLcpWPgg6HYmJjMjaeCu8lI4HRsqJGPDu4E3t7hVnRJ2dzzjYJx2+5qeunehfEmLnnbfNDBltUHHQ0xVGbYfqvBUumhLMU84Qm3WGftmoqaHalrLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnWt7NgSwEctAy+Aea6ZWdeUfrGiiMS10sRmTBnlzbA=;
 b=KZ+OkM1GRtYErZgkG31HtvjPpmk+tmRFG3AkpKbW6a/a3d/eziwatb1D1/vDETZRmM/i7I1DB0fSooe7Fz051ePUudiGPp6vt6vdKEgYUgA/GeFFxhS5Lwb8SPRjgRG2Ydn94TppGJo48C7k2jQqY4FVRDJfUtPfVPwPi307p/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2750.namprd12.prod.outlook.com (52.135.107.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Tue, 11 Feb 2020 02:33:27 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 02:33:27 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Do not move root PT bo to relocated list
Date: Tue, 11 Feb 2020 10:32:45 +0800
Message-Id: <20200211023245.3092-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0216.apcprd02.prod.outlook.com
 (2603:1096:201:20::28) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0216.apcprd02.prod.outlook.com (2603:1096:201:20::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25 via Frontend Transport; Tue, 11 Feb 2020 02:33:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dccf98b5-f171-4be6-2ced-08d7ae9ac64d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2750:|SN6PR12MB2750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2750CA25EBF5BD243B2EC02887180@SN6PR12MB2750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(2906002)(6916009)(6666004)(4326008)(36756003)(316002)(54906003)(956004)(2616005)(186003)(86362001)(16526019)(26005)(8676002)(66946007)(81156014)(66476007)(66556008)(81166006)(66574012)(6486002)(478600001)(1076003)(8936002)(7696005)(52116002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2750;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIW4Ej8L3X3xDVeLchElZxJMrtrbBgV4soa4R2/OkP0jWMratovA/OBbIbQWNd974OsgF8avz2sxYx0JQw6mQT8Ob21z/PICIfqKvwZy6siIb1IjHLGGlQSyysJpnpI6Mi59AqOYwBstwXOrP+QlvpujBVdh0Da/47IA186pUn4uVjkcKrDiB8yVATEShgeG+iulk4vM70UPMT4MSNHwhjPCgU8cNhcPsN5xpZs7DMgovB2MEBT9cO1fvljoqFfPi6BGN9rdWMEDaEfWOCZ5dzGVurlhZCEcieHxpuuavT5FuGpWerwg6+xz3AmZZbSR/cYUhQeR6w7wVCTWUDuHNSAYtrIflc4Evi+6XPRfHHk9iSRcg31723IQRvFmcsDRt9XLo2H0HEMx/Lxuo3BEVfpOBa3qeGystYnPlbenIM8/e+UyFnNGhPcdmntHdvb1
X-MS-Exchange-AntiSpam-MessageData: WU5Njmqq1KPfBcpBiKaFkt1owinry2Dpb5ZWGFFYcxcwzacrZyBjEgcAlHmAdE4g1p0EuKiEq5SB6J1UNVUKMef7RsLXJu1cLxPadmvMnqHbMrqTPmPkChP8ypgNwFwi5nJpUGj+xplEqjhmUm4Miw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccf98b5-f171-4be6-2ced-08d7ae9ac64d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 02:33:27.3706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNfwS0V+4mDtgMWspXf8CTOQaEQ4CzkC4vU4MkU+rbrLDYAasCXVJPeeKPuLTetw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
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
Cc: xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXMgcm9vdCBQRCBoYXMgbm8gcGFyZW50LCB3ZSBqdXN0IG5lZWQgbW92ZSBpdHMgc3RhdHVzIHRv
IGlkbGUuCgpTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgpD
QzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMzQgKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IGNjNTZlYWJhMTkx
MS4uMGJlMjkzZWIyNzczIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpA
QCAtMjI5LDE5ICsyMjksNiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdm1fYm9fZXZpY3RlZChzdHJ1
Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2UgKnZtX2JvKQogCWVsc2UKIAkJbGlzdF9tb3ZlX3RhaWwoJnZt
X2JvLT52bV9zdGF0dXMsICZ2bS0+ZXZpY3RlZCk7CiB9Ci0KLS8qKgotICogYW1kZ3B1X3ZtX2Jv
X3JlbG9jYXRlZCAtIHZtX2JvIGlzIHJlbG9hY3RlZAotICoKLSAqIEB2bV9ibzogdm1fYm8gd2hp
Y2ggaXMgcmVsb2NhdGVkCi0gKgotICogU3RhdGUgZm9yIFBEcy9QVHMgd2hpY2ggbmVlZHMgdG8g
dXBkYXRlIHRoZWlyIHBhcmVudCBQRC4KLSAqLwotc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2JvX3Jl
bG9jYXRlZChzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2UgKnZtX2JvKQotewotCWxpc3RfbW92ZSgm
dm1fYm8tPnZtX3N0YXR1cywgJnZtX2JvLT52bS0+cmVsb2NhdGVkKTsKLX0KLQogLyoqCiAgKiBh
bWRncHVfdm1fYm9fbW92ZWQgLSB2bV9ibyBpcyBtb3ZlZAogICoKQEAgLTI4NCw2ICsyNzEsMjIg
QEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2JvX2ludmFsaWRhdGVkKHN0cnVjdCBhbWRncHVfdm1f
Ym9fYmFzZSAqdm1fYm8pCiAJc3Bpbl91bmxvY2soJnZtX2JvLT52bS0+aW52YWxpZGF0ZWRfbG9j
ayk7CiB9CiAKKy8qKgorICogYW1kZ3B1X3ZtX2JvX3JlbG9jYXRlZCAtIHZtX2JvIGlzIHJlbG9h
Y3RlZAorICoKKyAqIEB2bV9ibzogdm1fYm8gd2hpY2ggaXMgcmVsb2NhdGVkCisgKgorICogU3Rh
dGUgZm9yIFBEcy9QVHMgd2hpY2ggbmVlZHMgdG8gdXBkYXRlIHRoZWlyIHBhcmVudCBQRC4KKyAq
IEZvciB0aGUgcm9vdCBQRCwganVzdCBtb3ZlIHRvIGlkbGUgc3RhdGUuCisgKi8KK3N0YXRpYyB2
b2lkIGFtZGdwdV92bV9ib19yZWxvY2F0ZWQoc3RydWN0IGFtZGdwdV92bV9ib19iYXNlICp2bV9i
bykKK3sKKwlpZiAodm1fYm8tPmJvLT5wYXJlbnQpCisJCWxpc3RfbW92ZSgmdm1fYm8tPnZtX3N0
YXR1cywgJnZtX2JvLT52bS0+cmVsb2NhdGVkKTsKKwllbHNlCisJCWFtZGdwdV92bV9ib19pZGxl
KHZtX2JvKTsKK30KKwogLyoqCiAgKiBhbWRncHVfdm1fYm9fZG9uZSAtIHZtX2JvIGlzIGRvbmUK
ICAqCkBAIC02OTEsMTAgKzY5NCw3IEBAIGludCBhbWRncHVfdm1fdmFsaWRhdGVfcHRfYm9zKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKIAkJCWFtZGdw
dV92bV9ib19tb3ZlZChib19iYXNlKTsKIAkJfSBlbHNlIHsKIAkJCXZtLT51cGRhdGVfZnVuY3Mt
Pm1hcF90YWJsZShibyk7Ci0JCQlpZiAoYm8tPnBhcmVudCkKLQkJCQlhbWRncHVfdm1fYm9fcmVs
b2NhdGVkKGJvX2Jhc2UpOwotCQkJZWxzZQotCQkJCWFtZGdwdV92bV9ib19pZGxlKGJvX2Jhc2Up
OworCQkJYW1kZ3B1X3ZtX2JvX3JlbG9jYXRlZChib19iYXNlKTsKIAkJfQogCX0KIAotLSAKMi4x
Ny4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
