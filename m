Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB01C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 09:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FEA2073B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 09:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FEA2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCF46F8D4;
	Wed,  4 Dec 2019 09:04:10 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4E26F92A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 09:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjsA/3MC0dQrWLeMU3v/m8OItw0yRt0dy/JzlWuCIEly2wyrDVgyPisOz3hrQbcANOeUCRIFXhHhmw5Ug3HwhsXeK5rp7hXktMV//c2EOA6l747Jno4GoaKBas+uj+UypiQqNrOKVtVxU6NZHTZJqvROeZQ+rVLclckuO4yQdgTdNjEdfW2E0PLZobATB21iFOOCeKT3NtW7l6grFtHjZzZXj3QvMKeklpopT/CYB3YGXUpGIwglrCT7gslqDAeOyBXB0fM/DzfdtQ4sHpVk6tK/fqdSzlkDiwmwbXeB7pFOe4TkAFkagIBL8YoLC1sK1SrgHlBVSxpF6FheamWhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRvuK37ddx9OSKESudhCXIj4hjOFF+OAKJvYA5tTQJ8=;
 b=ASL3eFxuPuG1uPqmArhn5bds1oV9cmRd1hKb+UYt1k768H7tg4VnlyLgBMFRFTOPouqmK++m1aGeMGTTYgFKMGX0TLnQsXH6Da8T9kxwXCcJgDVfESqmNggzIxXaVd776GVQ/A5W8El0tSRsdOeAoJoPpZXJnaXR0VBP+0uZVVbVdEumaEBX4kuZhFDrRW8C9MZQIxyqRI2L/fH/InqyZDul8082z64fn9ewFZ5ov3f6wybMxsBIGIDhs+/Z1/uYSnglNgeeG3MKsnIo6fwe/wRxheV98C1DB2qtVz4puvC4ST/2ME9ETEDZO/VfZArS3CvYyX+RZkkNEHkZonYlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4031.namprd12.prod.outlook.com (10.255.239.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 09:04:06 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 09:04:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: drop unnecessary warning prompt
Date: Wed,  4 Dec 2019 17:03:44 +0800
Message-Id: <20191204090344.17334-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8eb133da-4ab8-45b0-91a7-08d77898ea63
X-MS-TrafficTypeDiagnostic: MN2PR12MB4031:|MN2PR12MB4031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40315B1F15034BA3B01DE733E45D0@MN2PR12MB4031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(2870700001)(5660300002)(186003)(316002)(48376002)(6512007)(8676002)(50466002)(7736002)(81156014)(81166006)(305945005)(2906002)(6666004)(1076003)(4744005)(66556008)(66476007)(14454004)(66946007)(36756003)(478600001)(6436002)(52116002)(51416003)(2351001)(86362001)(8936002)(3846002)(2616005)(50226002)(2361001)(4326008)(386003)(6506007)(25786009)(6916009)(99286004)(6116002)(6486002)(14444005)(26005)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4031;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yf6jLCgNzqOVkldO40QLYlqVGJDCB0BO2O+yIXK3HgMNg5KzH5nWRYDTIXleaWOLi56VwTAe2f6EHJW6Lf4o6SlM6skfJtGtkFOABuGkB6aB8GClGTk7nMo0TpQxU3/yW55Wrm6z8gy0h3L2fkZVetCLtRQM/JfgEA75KOsM0AEDKLIFHKQuuSmPMB3Y1Y6ccEoKhulbWcRBlhC3n9NYXTvh+yHKdMxa0iQtfnjKUwMq6ZMoCs4ZeLLTLseFYUCfcReVNI+jtUNlKPMPeztmerp9Q0nT+UjZUL+h01S3hYDHJ9TYhcEcG3Pf4V0+QhABDG9E6XoT7d5yU90H3LkRMNw5nqCBPoRVv5dl0AvYyOk/FiA8ISVrfi1VBp9LiU2h1x8Qw9cIIcpcWAivUMwem3w9JYaBDp/BiIBcpzWkKlnqsjVBUD1vZI1TFD9K0MND
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb133da-4ab8-45b0-91a7-08d77898ea63
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 09:04:06.2858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXZWXeE5l/74pbNbn7d/kf/pj0uUeliXycoS5uqzz6WdKqMs6mNk93BZrsi1CwUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4031
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRvuK37ddx9OSKESudhCXIj4hjOFF+OAKJvYA5tTQJ8=;
 b=tVN2RRbbhMBkZurQTA6kDPR5Lv+wjy0TMFJUsPRyIeIAAkObrxMZzs7ixMav8gzICGzBNu1Z902RVQScJF3OHlWup3biS/6942mIHvjrC7cdnNHqHIxiE8VCahvHSVQIpX1amO4nGKEx38kjU8vNfK7WAER/e2MNbNqFMU3jRjk=
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

QXMgdGhlIGNoZWNrIG1heSBiZSBkb25lIHdpdGggcHVycG9zZSBhbmQgdGhlIHdhcm5pbmcKb3V0
cHV0IHdpbGwgYmUgY29uZnVzaW5nLgoKQ2hhbmdlLUlkOiBJZTA5MjhjMzI0YTgxNjFkNDQwNjhm
OGNlNjQ4ZDU2ZjZkOWU4Y2QzZApTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5j
IHwgNCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwppbmRleCAz
ZjEzOTg2ZDhlNTAuLjcwYjI5NmE4ZmVmOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYXJjdHVydXNfcHB0LmMKQEAgLTI4MCwxMCArMjgwLDggQEAgc3RhdGljIGludCBhcmN0
dXJ1c19nZXRfd29ya2xvYWRfdHlwZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgZW51bSBQUF9T
TUNfUE9XRVIKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAltYXBwaW5nID0gYXJjdHVydXNfd29ya2xv
YWRfbWFwW3Byb2ZpbGVdOwotCWlmICghKG1hcHBpbmcudmFsaWRfbWFwcGluZykpIHsKLQkJcHJf
d2FybigiVW5zdXBwb3J0ZWQgU01VIHBvd2VyIHNvdXJjZTogJWRcbiIsIHByb2ZpbGUpOworCWlm
ICghKG1hcHBpbmcudmFsaWRfbWFwcGluZykpCiAJCXJldHVybiAtRUlOVkFMOwotCX0KIAogCXJl
dHVybiBtYXBwaW5nLm1hcF90bzsKIH0KLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
