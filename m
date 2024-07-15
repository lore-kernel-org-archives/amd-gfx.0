Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F404C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 14:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DDB10E404;
	Mon, 15 Jul 2024 14:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KLfp7Ufp";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7196510E3FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 14:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRN3TkFINFyU7++MpPhMVpunOmE7I69VyD8nSilH874YwwVXqwBLueccpaAftJ3MuRngQjYJFJs5AnDwixOXCDgfIfcmr1gpqQRyRDXoyj/UBJvY/yECBtWuaCKhaNbLx0gRVkRj+aEj5sjej2tmJtQeX6ea3X+YSCxBK6cJZIhsJxKERHhR4Se8jdb5QBo2AL8bxOxCkNPKvLcciguGiYumwIm6cFekY5DBhTSFNssT0Se6StiUGgTn2yjmuZFNA7PZL4ZiVoeU6ShrD/SZ/dmo5psFsYkNT3v4SAG7mZLqItT3rth6N+9mLIsR0MfM1JUHPqu88Gt3nWgb9VlskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj7cJiFJ4cMPW+fstPbXCOy6RofgZAMYjDtgyJUG1Cc=;
 b=JbtB7A42XkyNViyj2Pxit1T/53jOPGo/9S8LhTPCK6t2CLJzOgaLx/PCyN8TGSsLD0xHyrg4nsb4UvBUc5uuD1xsLG4Ug8JQh+OLHUO7cuJOdCPtktEBnd2BorEXAiGXMVhiR47Ttx4vNz44ZKXLs/5I0cT2oW/5p5VkRXkqtQH19ZXXmzmMdoUoZpB4ULFTcttU62hWf6BC6yZ6G0LMJBP66CmxB+URllYa5vsSBFUwRQSS6ThPO/inDHW3GnrsjxSOT8g+IGHp1XhHgPSk3QRMiuHlUaIsw+s2mjo3JtoxQuplMVO1bb/K0fBN3JgkfOMxRkGxBfoT8VF0O9Hi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj7cJiFJ4cMPW+fstPbXCOy6RofgZAMYjDtgyJUG1Cc=;
 b=KLfp7Ufpz2W2ox18jO6sK3uRTSRN1hVXoxbmVu2rnG8eAea+dEPGDl0fW5M6PzPrgNZap3LCo2U9K9gS9tQInvcKuSZW99wtTRqYbfoJSrLDwgpBpKx68UyolLS8jKALrTHdzh3QEf5/wYlL9CzD2Xk093mxDqXGkKPb3gEqhe0=
Received: from SA1P222CA0190.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::27)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 15 Jul
 2024 14:48:03 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::7) by SA1P222CA0190.outlook.office365.com
 (2603:10b6:806:3c4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 14:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:48:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 09:48:01 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 15 Jul 2024 09:47:54 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "Jane
 Jian" <Jane.Jian@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add empty HDP flush function to JPEG v4.0.3
Date: Mon, 15 Jul 2024 22:47:48 +0800
Message-ID: <20240715144748.168556-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: b821f52b-070e-4084-0902-08dca4dd212c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tggpAgen8OdsodCdSsFyjb97gbmUe1Jk+a5MMsU458QKrSAMcW2ZuLKA2/E7?=
 =?us-ascii?Q?mtfLx9a124v//68wQf8oCyx8k4bVW0/tWB7KIeQfvg10ioUd8TKHj/NgibvW?=
 =?us-ascii?Q?1oKrLgEw69Lf6UGLxT8yTiY2LkJxzdp1k7oZphLYvbfhGv/UmbjJzzfIBbJY?=
 =?us-ascii?Q?Zz+frmwoLv1vcaxwyUFzZhfshvEgykpv1BfxZSMXU1xmyriU58p1xWVkOU96?=
 =?us-ascii?Q?stMY/tI/iTIOn62/cCBbdfjrixkAbR0ZAYXcu66jWwAejuZl0zcavC3qGg+0?=
 =?us-ascii?Q?lVodTdRrrEoS4lBodTIqoQH+jnIPKGVZbLBeItVls16cX51WJKP0cdFNzC0Z?=
 =?us-ascii?Q?w4aLBCnltHk1fqBv1UDF+YBh0y3ggwN+mHVhBuEX1QHaJGLEnWP8+fqTpoDO?=
 =?us-ascii?Q?birPrZZ2ruD2YNSUWYf976mll3BTqjJeV1xZrqqppNjjTNiswWAlIadMRxO1?=
 =?us-ascii?Q?RDi0PgUPjN/feRMYOKT1RoLNxpAXFfKIqTmQHEqQhnJYNoI/KtfeBF6F9giJ?=
 =?us-ascii?Q?9SUULTmsFw0BsI7GE3n6v8D/CZJBnTUXM1eb+ECCjwqSGLVZelk3v2iU0eYi?=
 =?us-ascii?Q?vqcKMElGlxQUMDU/aRjygE2zVNEZ0V0nrrfN+KxhwM7mvemCCgoS8WgIjyxY?=
 =?us-ascii?Q?NHqQ3yyDVv9n3WxU23RaYnJp2xIplyQawpVvMqNdtxHfk410QkGmVqJcDiud?=
 =?us-ascii?Q?Hf8hDp9OLej3fvD/65+HARWXOAMCZr6KrSX+6MTvVJCBch3sKDs///DZOjOG?=
 =?us-ascii?Q?mUDGdH8hz7xhyRQBHBUJcnuznnzatJMZMxaWZxRydWEq4vXF0dHuFc1u86Tn?=
 =?us-ascii?Q?akkvJ3YDEaYayrh8R+ziROhEPJ0faCctdQGoCfmggISRSpJJgSwLNK4THb/p?=
 =?us-ascii?Q?Hew9ZM5X/KMi29JQh4yLzm4Vo+X9xUhupk8u0wWNoGLTTXNx+d69L/r3vGMQ?=
 =?us-ascii?Q?WZnAgBZVjEi46GLTgeCvBdMWZQ1PMHbaDLqMta56eGxHJLaZNdiZjBfA7ftk?=
 =?us-ascii?Q?l2MTJintc4l/3FM3d1EfmXk7LDeUo5wh5uSugEjVAwIxcxws4HxHLP/olgUw?=
 =?us-ascii?Q?0AO1ZEJHi00MlSxiMeAjsVaKTR8ds78eTeDIeRTUDuzbOdQkY/JGUvCcb3aB?=
 =?us-ascii?Q?dupVOSxY75LTVrQgHhO2cbBqdLyW18IwCiNNXv9KyJLaP8m+UA4hygCah+Qa?=
 =?us-ascii?Q?gkPNsy/POZGYLScuwO+AP3IfXf2wb6R26IldsL3B4cPZKg3ymGB1mQD1MZsu?=
 =?us-ascii?Q?Ck8TAN/kjM29ra+xFD5CVO0eHM1mWGpWrLJy5CvBr5OkGuV0A/brgwbnd92e?=
 =?us-ascii?Q?P83/Q+18reb6DyNgEnK+FEOcsiYPR1MfuuDzqVC3ZoSh3e3bJR5gkqaIrQRa?=
 =?us-ascii?Q?OLCLjhmoJ6kT/FG7yMeDedI3CSRHM1ci/YhKCW+ZhHsCcIt/p+rHVuSeGB0P?=
 =?us-ascii?Q?tpc3npqPdMi51dk3NsPkmdUBxWqHZwIJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:48:03.0091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b821f52b-070e-4084-0902-08dca4dd212c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

JPEG v4.0.3 doesn't support HDP flush when RRMT is enabled. Instead,
mmsch fw will do the flush.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 04d8966423de..ea601047dab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -621,6 +621,14 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 			ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
 }
 
+static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
+	 * This is a workaround to avoid any HDP flush through VCN ring. Instead
+	 * HDP flush will be done by driver while submitting doorbell.
+	 */
+}
+
 /**
  * jpeg_v4_0_3_dec_ring_set_wptr - set write pointer
  *
@@ -1072,6 +1080,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
 	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
 	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
+	.emit_hdp_flush = jpeg_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
 	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
 	.insert_nop = jpeg_v4_0_3_dec_ring_nop,
-- 
2.34.1

