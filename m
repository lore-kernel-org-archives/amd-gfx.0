Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22307C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 23:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0046021655
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 23:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0046021655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A410B6EA03;
	Mon, 11 Nov 2019 23:25:43 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730058.outbound.protection.outlook.com [40.107.73.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1290E6E0C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 23:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nwy/fwE3xQYVlMU3l2dxdfAeTEbe3c8p7VsgCslj/UOrAFiA1NG1xIPDUytmqScbQqfgAefweOYAhNWxfzk8ltO1LlEAxYTsJq9DKJX8U+X+nYivHj/nz3u+IKJX1M5Y/1em0CX5DycMdldsmbzBfCwyRe7dfXK0IaNuQ2WOEREl6TKSg8xdOLFnXtW6/RmaiwkJyy2kYCAO99RmT54FAvTE41sCqWZVR5EcM2uca/RPh1NazwciFX3kDUymEz5YHSGyCtqMEfzA9vc/+PQTdcolKjfsU5RiaB8rzl4c7eySP16CViPV3vPEV6TXgHaJiY54Pvz787nxmnZc5cFKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWtfygUn/2mCo/UzponjpRQKbzD4FumFfRcxj4lSr+A=;
 b=BAbA9/8O6xJurLfr42I/cbkJTJy4apzPFtcuaIKJh2dzVeI1U1c9lS2UNc/BOL3OlpU5HGgUoYt1JSLx8ZgWxNtALf5JuAyYfrrdjRzFM2RfpwdVtfMdUVqk4JfHIh+ZhWSKqXdCAJ6ucvIEHmAVupvArQJZnkZQOH0HYJl51wEIv6Wx+r5hkbLlYc0MqOjsrto8NDY7U9dr8+/jrYfUrKU6xiP0y8tKRxO67+I7svscgQhVSXEmcET3DTokjGgXmeE52CJvqvrmQg7mxaPNMcW9FYmhB/NC8VzyxnOVdq4iBBfk9UOujfz3JTLL/3ykM9RcqgVbOBYuZsGBvEye8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3452.namprd12.prod.outlook.com (20.178.29.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 23:25:39 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 23:25:39 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Jay.Cornwall@amd.com
Subject: [PATCH 3/3] drm/amdkfd: Fix a bug when calculating save_area_used_size
Date: Mon, 11 Nov 2019 18:25:21 -0500
Message-Id: <20191111232521.10528-3-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111232521.10528-1-Yong.Zhao@amd.com>
References: <20191111232521.10528-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03fd293e-7f3e-4c17-baa5-08d766fe7696
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3452BD16850B9F30DE2156C1F0740@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(6116002)(14454004)(1076003)(6512007)(66476007)(25786009)(7736002)(305945005)(66556008)(66066001)(3846002)(47776003)(4326008)(36756003)(66946007)(50466002)(6486002)(486006)(6636002)(50226002)(48376002)(478600001)(6666004)(81166006)(81156014)(8676002)(99286004)(6436002)(4744005)(446003)(14444005)(86362001)(11346002)(476003)(8936002)(2616005)(76176011)(316002)(26005)(6506007)(386003)(5660300002)(2906002)(16586007)(51416003)(52116002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3452;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mADndp3ctFONeL5MEQASUMQ1rDjIIFByFEvRt6xVsv4FrzxCT8LKix5tDvzFVyHFswPXOzkLkvxLpo524HlLKQZ0ovl0ZHk/iUV4DRs6vYNgmeKTdmsLpobs2/JFd7YfG9pznB76AIMI0mPDUhxUxgaKOKOAqxTdCv8pXeBL3AYyZE86MF+WotdC5+iQQuwz+iPtBX3F3TDf5LE4hS1m7+O1ScF0izvU+sNWRXyVhmhuKYyptw3arg3mDckV0tdcDW+/GaZcliLg8MlDmxJU9xqqQa3wv2Ld1C6lJBjiDifct+ZI6Sec5ZW9g/OzUL1pruxgMDewbO5blhSEot63uGz9V7xM+L02LNHAr32doeTJ2LX3PmhI37puNJJuNCw6h+90rrr5lIRR1V4rXP/UYGtlC4dwe1erjEff0GX6QgPKDrFLiAvgEOdO9Lat5f0Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fd293e-7f3e-4c17-baa5-08d766fe7696
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 23:25:39.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA9ukzmr/gN8WZiTaLf5zuGA4bgl4pa1t1iMKgSInnn6GL8MOgixtjh6SoJJ30HK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWtfygUn/2mCo/UzponjpRQKbzD4FumFfRcxj4lSr+A=;
 b=jEhVH0dUucPEgj/PTUp93AEnBxDSWhqBRmPQcMubyLPTSMguG49nnrk0+aL24SQ3OgHrjzuST9JdOYnPeUlMnSsyQA9IoUOcV59pFobLPW6p4fnkqP8yfB0g54K4d/PyqItOONYZch5xLxdJoh0o1h8WYYTafEpz31PgnJGDj6o=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111232521.AFToUStbu6_LmUbieNmLUFmfohJriNfF4xVKEOx75cM@z>

d29ya2dyb3VwIGNvbnRleHQgZGF0YSB3cml0ZXMgZnJvbSBtLT5jcF9ocWRfY250bF9zdGFja19z
aXplLCBzbyB3ZQpzaG91bGQgZGVkdWN0IGl0IHdoZW4gY2FsY3VsYXRpbmcgdGhlIHVzZWQgc2l6
ZS4KCkNoYW5nZS1JZDogSTUyNTJlMjU2NjJjM2I4MjIxZjQ1MWMzOTExNWJmMDg0ZDE5MTFlYWUK
U2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYyB8IDMgKystCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwppbmRleCBkMzM4MGM1YmRiZGUu
LjNhMmVlMWYwMWFhZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X21xZF9tYW5hZ2VyX3Y5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21x
ZF9tYW5hZ2VyX3Y5LmMKQEAgLTMwMiw3ICszMDIsOCBAQCBzdGF0aWMgaW50IGdldF93YXZlX3N0
YXRlKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKm1xZCwKIAogCSpjdGxfc3RhY2tfdXNl
ZF9zaXplID0gbS0+Y3BfaHFkX2NudGxfc3RhY2tfc2l6ZSAtCiAJCW0tPmNwX2hxZF9jbnRsX3N0
YWNrX29mZnNldDsKLQkqc2F2ZV9hcmVhX3VzZWRfc2l6ZSA9IG0tPmNwX2hxZF93Z19zdGF0ZV9v
ZmZzZXQ7CisJKnNhdmVfYXJlYV91c2VkX3NpemUgPSBtLT5jcF9ocWRfd2dfc3RhdGVfb2Zmc2V0
IC0KKwkJbS0+Y3BfaHFkX2NudGxfc3RhY2tfc2l6ZTs7CiAKIAlpZiAoY29weV90b191c2VyKGN0
bF9zdGFjaywgbXFkX2N0bF9zdGFjaywgbS0+Y3BfaHFkX2NudGxfc3RhY2tfc2l6ZSkpCiAJCXJl
dHVybiAtRUZBVUxUOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
