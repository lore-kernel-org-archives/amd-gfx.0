Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9EBC11D2F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 11:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FC62080D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xQ+1n4Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FC62080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9907F6E42F;
	Mon, 24 Feb 2020 11:00:21 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750081.outbound.protection.outlook.com [40.107.75.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444F46E42F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 11:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqlkvCgcikgr8jDGknjvDZ9LScY0Ga1X1XRhKhBdneq2Y/d+mkQsL2YC1Bu0/g8PCu3BP1QKONrgbj1mcbJtxR65BaXlnCB+Xpit1dOU/LwB99AA0OcqACxVoPdpqeZtqABRw73/7vVoGmrlT3UmtmyEuI08eFR2wXHitus+wFlZO3mG8nUFSQ+JPJPbSB03UzjhCbefjbCsdq44KapC5JM8HpGedp/AgOIc4Qn6SqmhmLRUHpgpQgkTXe6JCrt/ZKg4W67Ff6Lv1VJRFRL0X7XsI2eU6rx/8nZBKo77DHDAtv0eQn05JwW3iFpVSjVtxK5EFFwLRvEB9LGQjbekDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxFjHi+BZaIggb5Or+Di+ArlDAIjkH/qKyaPzAkK8tk=;
 b=k3Xw6pK1kZ5CgOJo7ntLKXk8t7YAGFRGMXIDtsBSVJau6ko5XMo60JYWzjFIUUv+sM7QcTap/XkS0kN931Zj7oGFlnqDJonXs72+r8DMm10UGurphFU5TZ8+7ETm/Mq5feA+BKhLSaoLhrbDbYXXuJ3L+Nb0nEgo/aMGX3T2JCAxlHiPyxYx5s64bvJndUtRYhOMDokle/M8VEzyGSRbV+1b0Xaj65QLEntN3RFg0Zv9Ew6rT0q6CLIHT12WgF15gHnbobKJ4xpmCAev/DxlyKrMRYWSP0X9pw4FjJKdi6SLfGCajEZO0qfTWwl08JyOoeGZ/B0ZTj+3Pvfc9mz6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxFjHi+BZaIggb5Or+Di+ArlDAIjkH/qKyaPzAkK8tk=;
 b=xQ+1n4TqYovRRXIaLbOG+SvAmCcFSWgBg8E4TXSNgZwUomyIItDL5FIhX6kz+FPGzHZ+2ImES0gX0Q7JWuKgi9c8Bx1i5MgtYkwhawRoTZkdrYgO/IJXmKWNWIFGShWVX7YnGAyV3b7SM2GaVVQm28fJDDMMtuc9qy9e61Rr5CU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32)
 by MN2PR12MB3341.namprd12.prod.outlook.com (2603:10b6:208:cb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 11:00:17 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:00:17 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	tom.stdenis@amd.com
Subject: [PATCH 2/2] add DST_SEL=8 field name for WRITE_DATA packet
Date: Mon, 24 Feb 2020 18:59:53 +0800
Message-Id: <20200224105953.29906-2-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224105953.29906-1-xiaojie.yuan@amd.com>
References: <20200224105953.29906-1-xiaojie.yuan@amd.com>
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c0.amd.com (180.167.199.189) by
 HK2PR02CA0177.apcprd02.prod.outlook.com (2603:1096:201:21::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Mon, 24 Feb 2020 11:00:15 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30e03d12-0204-4c4e-f436-08d7b918bb83
X-MS-TrafficTypeDiagnostic: MN2PR12MB3341:|MN2PR12MB3341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3341DDD39427477AE3309CC289EC0@MN2PR12MB3341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(199004)(189003)(81166006)(81156014)(16526019)(186003)(8936002)(86362001)(26005)(5660300002)(6636002)(6666004)(52116002)(7696005)(36756003)(66476007)(66556008)(8676002)(2906002)(1076003)(956004)(2616005)(66946007)(4326008)(316002)(44832011)(478600001)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3341;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qGk3TK7daz0YOZm3tX+OMd43IJ4Ml7angdWVMEN+1Z+pY9gpVDgwC/3vk8IDZrfK1Zs+pLsSNS04lmJF0gifx6xHT3+hCC6advyg6vcECuDKZKCu/Yqxy0cjJe78+SVY1liuYQL9sLEfujm4PrQ8RZQErHllDb38E7dJzk9I+D3oVvVf2tQSdURiIv86N5rMCeenD0BaZ55PUDIAyLhygUpyDJpoEqVLSXZpBc+RFRNXSNNDQ+udlCq1QKsEGDNM8xSkz/qzxDVmSp53pZb04NZpO4Y5NdQvl1xI8AfZZRoPIjDuFG5Gv52pQZzlw0WBt7sn3mmKWtxXxkWWJwli4uGdNpPlUNPkPiTqm3//hp+k56YwOzvjE+4yiOOSRZ3Lw3SX3VH5FWpA9wukhweaNh7AQH1VDMxYlKZP6IIhvfS5HmmN7ur4n4kUqlassTH
X-MS-Exchange-AntiSpam-MessageData: fmgB0RBL57pGWxnLHG3NntjCo727MtVswfR0mFG4IPcGiH176dOG1e+Wt+Nz9jxpWxygh04XVoFhXA9dvJltdNhrhH7bAgbHatXcuwFvV+Gj+O1ZRTaIm96QQGrkuZE6iv5kFvM6uhKytANnZkw/jw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e03d12-0204-4c4e-f436-08d7b918bb83
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 11:00:17.5513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6UAh9Ro7GLcUb+ZCrHQCTOasC33vTQ39UusDIbErf9I5Zx/5Ef7DdvyNjXDLlTp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3341
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
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

otherwise we'll out-of-bound when accessing op_37_dst_sel[8]

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c            | 2 +-
 src/lib/umr_pm4_decode_opcodes.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index c5582f5..f26cf0d 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -465,7 +465,7 @@ static void print_decode_pm4_pkt3(struct umr_asic *asic, struct umr_ring_decoder
 {
 	static const char *op_3c_functions[] = { "true", "<", "<=", "==", "!=", ">=", ">", "reserved" };
 	static const char *op_37_engines[] = { "ME", "PFP", "CE", "DE" };
-	static const char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved" };
+	static const char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved", "preemption meta memory" };
 	static const char *op_40_mem_sel[] = { "mem-mapped reg", "memory" "tc_l2", "gds", "perfcounters", "immediate data", "atomic return data", "gds_atomic_return_data_0", "gds_atomic_return_data1", "gpu_clock_count", "system_clock_count" };
 	static const char *op_84_cntr_sel[] = { "invalid", "ce", "cs", "ce and cs" };
 	static const char *op_7a_index_str[] = { "default", "prim_type", "index_type", "num_instance", "multi_vgt_param", "reserved", "reserved", "reserved" };
diff --git a/src/lib/umr_pm4_decode_opcodes.c b/src/lib/umr_pm4_decode_opcodes.c
index a823ecf..c4ad5ce 100644
--- a/src/lib/umr_pm4_decode_opcodes.c
+++ b/src/lib/umr_pm4_decode_opcodes.c
@@ -351,7 +351,7 @@ static void decode_pkt3(struct umr_asic *asic, struct umr_pm4_stream_decode_ui *
 {
 	static char *op_3c_functions[] = { "true", "<", "<=", "==", "!=", ">=", ">", "reserved" };
 	static char *op_37_engines[] = { "ME", "PFP", "CE", "DE" };
-	static char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved" };
+	static char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved", "preemption meta memory" };
 	static char *op_40_mem_sel[] = { "mem-mapped reg", "memory" "tc_l2", "gds", "perfcounters", "immediate data", "atomic return data", "gds_atomic_return_data_0", "gds_atomic_return_data1", "gpu_clock_count", "system_clock_count" };
 	static char *op_84_cntr_sel[] = { "invalid", "ce", "cs", "ce and cs" };
 	static char *op_7a_index_str[] = { "default", "prim_type", "index_type", "num_instance", "multi_vgt_param", "reserved", "reserved", "reserved" };
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
