Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D4DC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 16:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E864D208CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 16:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E864D208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B996E395;
	Tue, 19 Nov 2019 16:38:10 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730059.outbound.protection.outlook.com [40.107.73.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88B16E9E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 16:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bORzOKg4YaTFJ8BRYbP5DoPgXcodNd3D+MTUIn+JAAQMI4RPs4OWzJAeJAyKnzTFKW3OW9IF9lWz0+wshM6ty7M+3gcC8xejAFmdFOQrUCZLqTm97QGMsd1x9LutFSY4vjnIslzf5WFtIEtqB28AgDqGH9kS7NRfn8JNQenMAjsCQOlCc8s3ecgbg7ZZAZNFJXHFENiDBW4LOMWPhisd5gXo7GrNO+nz92GzjqMpblUTZ8NJDFnavT57OLRhYWHwk+Wkmbb5J7VCOc/4EHjm700Ydveg6Or6t5pxm+qEYCczGSK/X858BWBXvN/d281ZaQLI0V/rSnyFGCKxN+uZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK23c/ecpkQ5j7ljdS0rSG6hMkPdRmyT8D29hD+yifU=;
 b=mcldYS6GZCIrEGbiArCmLxZYMc00tgy3walX7/o2zvxTKcNXOLBX0SiTQMoXkVqSiPxSO/diMP71Yy7y7mfiKENvQV8gQofF4sqKZjS6goZBULVXWe9js4J3GEDNWbv6/YnBco+MDGtJGfZpPQsE5M9XKzlktugmEpc1j4XknW445ikSvexM7PPHwomPzqwrqkAwtR+y2Eb7XYvDMhV1k8gcZ/O0suk5rb0kyNvrLTwV64UUPmDB6KXzfplM2oH/83/w2EM2QK0GXMVqh2G1/RAK6hH6MDr5Bsh7eom3p9WnWJWkn/gzamgaXNmgCpRbDL3QSA1YXZsrhpyu5mp+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB4182.namprd12.prod.outlook.com (20.180.16.11) by
 CH2PR12MB4325.namprd12.prod.outlook.com (20.180.6.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 16:38:07 +0000
Received: from CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1]) by CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1%6]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 16:38:07 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
Date: Tue, 19 Nov 2019 10:37:54 -0600
Message-Id: <20191119163754.4966-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119163754.4966-1-alex.sierra@amd.com>
References: <20191119163754.4966-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0051.namprd05.prod.outlook.com
 (2603:10b6:803:41::28) To CH2PR12MB4182.namprd12.prod.outlook.com
 (2603:10b6:610:ae::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 148e7d96-4855-4024-4c01-08d76d0edb69
X-MS-TrafficTypeDiagnostic: CH2PR12MB4325:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB43251DA2738D8BA4408010BAFD4C0@CH2PR12MB4325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(48376002)(316002)(50226002)(86362001)(14454004)(5660300002)(16586007)(66476007)(66556008)(6512007)(6666004)(66946007)(36756003)(486006)(2906002)(2361001)(386003)(66066001)(6506007)(26005)(52116002)(47776003)(8936002)(2351001)(25786009)(44832011)(6436002)(3846002)(478600001)(76176011)(81166006)(51416003)(6486002)(305945005)(8676002)(6116002)(81156014)(476003)(99286004)(11346002)(446003)(4326008)(1076003)(186003)(6916009)(14444005)(50466002)(7736002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4325;
 H:CH2PR12MB4182.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kklwnrOTgZhTUW64c2Q7/QpEhGObPdYFuQxXX7K9OkWt9wSpLv98vkWUOeRKmjGyiUoORQ0a7oSC8z5cj83QDra0eWNd0ZfIgjK+C5PI6zRHPrLCZQ6PUEJhMhvXkhzU0xUay3Fi2PoCFvcsxO6bilS7O+PGufrl0SaGkkRnwIjDEC8Ny+LxXl5NOGBRwQiZ0mHb5grkW4opOg621T6zQWM3X5qocnKzeVW1aP2lMEOomc6qQ4luAtCU4Y2bag4JGgzr2gFc+T0po8LUXHkS6bHneiDLr77h+IgnrBK3KqR+jm4N4XtMim1AB5cDF62MfyxfdSemRubNESJu+OdxjjRxeGYbueHcHftKDu7808z654NG2Ab2irh3mvz9JgEm2VEp+dmQJhL/c2ppDymo+ODo+OR+M9kQ+1NcjLRdps6hZZ7eK1REpUsO4sa6Mc9M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148e7d96-4855-4024-4c01-08d76d0edb69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 16:38:07.6654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rj3TqgUlLOxRBXri/A7u5VY6RLnxfq6wacsKAFNUWsQ1B3oGiPAj90ZOZf6zyj9QGtkjHHl7nQXkHmKI0Drhhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK23c/ecpkQ5j7ljdS0rSG6hMkPdRmyT8D29hD+yifU=;
 b=uXNvu15aebm+B7+KXKP67oyhDpUtz1+mnwu8Riq4NyrO0yh/F4xpBwyUuBOyEe2A2cN00LPXT8TbvxM3lf89p1lrgzKiSTmSUGtfaX5kuyf8VkhUU26ueOPTMrr7EGciLC4MZV2zPNVsCMRIDYOmLh4C60ay4vseKZSBRfSI0Xc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119163754.aP0pUzU0C_oomHWofV8CU9dCwVSe66-gnWssU56kJxI@z>

T25seSBmb3IgdGhlIGRlYnVnZ2VyIHVzZSBjYXNlLgoKW3doeV0KQXZvaWQgZW5kbGVzcyB0cmFu
c2xhdGlvbiByZXRyaWVzLCBhZnRlciBhbiBpbnZhbGlkIGFkZHJlc3MgYWNjZXNzIGhhcwpiZWVu
IGlzc3VlZCB0byB0aGUgR1BVLiBJbnN0ZWFkLCB0aGUgdHJhcCBoYW5kbGVyIGlzIGZvcmNlZCB0
byBlbnRlciBieQpnZW5lcmF0aW5nIGEgbm8tcmV0cnktZmF1bHQuCkEgc190cmFwIGluc3RydWN0
aW9uIGlzIGluc2VydGVkIGluIHRoZSBkZWJ1Z2dlciBjYXNlIHRvIGxldCB0aGUgd2F2ZSB0bwpl
bnRlciB0cmFwIGhhbmRsZXIgdG8gc2F2ZSBjb250ZXh0LgoKW2hvd10KSW50ZW50aW9uYWxseSB1
c2luZyBhbiBpbnZhbGlkIGZsYWcgY29tYmluYXRpb24gKEYgYW5kIFAgc2V0IGF0IHRoZSBzYW1l
CnRpbWUpIHRvIHRyaWdnZXIgYSBuby1yZXRyeS1mYXVsdCwgYWZ0ZXIgYSByZXRyeS1mYXVsdCBo
YXBwZW5zLiBUaGlzIGlzCm9ubHkgdmFsaWQgdW5kZXIgY29tcHV0ZSBjb250ZXh0LgoKQ2hhbmdl
LUlkOiBJNDE4MGMzMGUyNjMxZGMwNDAxY2JkNjE3MWY4YTY3NzZlNDczM2M5YQpTaWduZWQtb2Zm
LWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDkgKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwppbmRleCBkNTFhYzg3NzFhZTAuLmNkMzYxOTVmZjhiZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTMyMDIsMTEgKzMyMDIsMTggQEAgYm9vbCBh
bWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25l
ZCBpbnQgcGFzaWQsCiAJZmxhZ3MgPSBBTURHUFVfUFRFX1ZBTElEIHwgQU1ER1BVX1BURV9TTk9P
UEVEIHwKIAkJQU1ER1BVX1BURV9TWVNURU07CiAKLQlpZiAoYW1kZ3B1X3ZtX2ZhdWx0X3N0b3Ag
PT0gQU1ER1BVX1ZNX0ZBVUxUX1NUT1BfTkVWRVIpIHsKKwlpZiAodm0tPmlzX2NvbXB1dGVfY29u
dGV4dCkgeworCQkvKiBTZXR0aW5nIFBURSBmbGFncyB0byB0cmlnZ2VyIGEgbm8tcmV0cnktZmF1
bHQgICovCisJCWZsYWdzID0gQU1ER1BVX1BURV9FWEVDVVRBQkxFIHwgQU1ER1BVX1BERV9QVEUg
fAorCQkJQU1ER1BVX1BURV9URjsKKwkJdmFsdWUgPSAwOworCisJfSBlbHNlIGlmIChhbWRncHVf
dm1fZmF1bHRfc3RvcCA9PSBBTURHUFVfVk1fRkFVTFRfU1RPUF9ORVZFUikgewogCQkvKiBSZWRp
cmVjdCB0aGUgYWNjZXNzIHRvIHRoZSBkdW1teSBwYWdlICovCiAJCXZhbHVlID0gYWRldi0+ZHVt
bXlfcGFnZV9hZGRyOwogCQlmbGFncyB8PSBBTURHUFVfUFRFX0VYRUNVVEFCTEUgfCBBTURHUFVf
UFRFX1JFQURBQkxFIHwKIAkJCUFNREdQVV9QVEVfV1JJVEVBQkxFOworCiAJfSBlbHNlIHsKIAkJ
LyogTGV0IHRoZSBodyByZXRyeSBzaWxlbnRseSBvbiB0aGUgUFRFICovCiAJCXZhbHVlID0gMDsK
LS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
