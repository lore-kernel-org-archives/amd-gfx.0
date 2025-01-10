Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0304AE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B12810F11A;
	Fri, 10 Jan 2025 16:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BOaNRXXv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2060610F11A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC+eBD6/ghXKt1ADg+2RdpK0fckBwygClrkaPQtZQ8ipLixB1hZvlfJCtPH6qO6d+6cFEFN1FLyGTyF4zCWv6CKZLqmecOx1K0nUHXbzqVWWwhD2LmhMENcQhxCU2OyAJY/DaAhEXvTPjwzctf6nQ/EC3CIflfQCpWTOp0oxLB6teopOyvRULbD/0rs7veKJblMlQZf4tfvbffwKaKOArFdm2nXzMxXJB1+LA43rEaVJf8vHxB9O/F4Dkb3iQaJm7ac3/ANj4yS/ygR7qdW57+uA52y3HuOlWNNlDwthWzoYj1DyMEG9kmbrqxjjNTX18q9gVmzLUN+SBg+DoSmteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOVtIY1KiN0UTSGvcoL96LjerNaHWDC0aa7vm/oZTlc=;
 b=jFW1SLxCimnu3qwQL6d7iguSzJSt3W6Tfh9HY5MtxVB7wIDwlDJHqJeo8+KWSSalyAvFqeaPo1PvF1hLqrF4AWO7PHZ8zmjSoKwejObBO4oU+wumzWNVLPfmcGqG+GgNN753ywU/7Grp6FhSxc+B7667Shriv4g8SjkQFzLXJSzbEkGaA6aUAELKGKJg0sl4ec5ZtSlqWcy0yqzA5376GhYwLMlX2NoTR2h9TmR8oEEElvaLbYGZok3PxO+T20QKaYM7DaMajcJ1P9HTvJkpmqp4SF9Q0qw4PjZ1l0NeTJCCJQgXtcUOg2ddw9mcSrstR5bQUQ2w2Cy2WGmHwVa0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOVtIY1KiN0UTSGvcoL96LjerNaHWDC0aa7vm/oZTlc=;
 b=BOaNRXXvsQpG8zh5QdQtilcFhG9u1+CoRuevmePaaEJv5PRi2+le9OgMKJ02VfiLd/DIJPPYnvaQ5IIVPDdyzsKUKV16fv9WLA2ClhUT7KVS5XCACP19HobC7P175ET3gINL8pDURcGzWJEGFfIe7/XYr3AmYMqyV8Pup2WLSV0=
Received: from BN9PR03CA0580.namprd03.prod.outlook.com (2603:10b6:408:10d::15)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 16:18:23 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::f3) by BN9PR03CA0580.outlook.office365.com
 (2603:10b6:408:10d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 16:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 16:18:21 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 10:18:19 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sathishkumar.sundararaju@amd.com>, <sonny.jiang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add VCN v4.0.3 RRMT register offset
Date: Fri, 10 Jan 2025 21:47:58 +0530
Message-ID: <20250110161800.1326934-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1c501c-1442-4e26-57af-08dd319266b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DqJone2AJF9l+0HSp06cNhycDyYwuErnFnSoPR0PPG5Ck4A8d7dJGEGi7OM6?=
 =?us-ascii?Q?+teYz43rzDMe4To6fynhyBIxPlEti7Zm2Ru4ju2tZtkqH69/0Ay5Xl+g3V8k?=
 =?us-ascii?Q?yYYXT5HSAPbDTv2OdQ4n7Ups1i4YrLl54o8hmV3f/lQAzzf5xHZRnsJrqGj3?=
 =?us-ascii?Q?B5E4Fb4mFYNLZycBgyQhR9Bm2WeUConAtUcbBUjpiIKRefWgFwQVoFXa4Zvb?=
 =?us-ascii?Q?UWZTFezr7SlpvWj5Rni4AqKprPlkZXaj80RtGW2TZpyhSTr1MoVlxXFG70Wc?=
 =?us-ascii?Q?DKRR9LWZXQGXYmQOiJKohd1ukvax3l452vxT9bxk121/A937jfxvb2PEGW/n?=
 =?us-ascii?Q?omWUF4aM3O2n4LkOdiU3PYyRcd0NymoH1Z625UeQf9ktVi/d1Qi0s9gu0IJf?=
 =?us-ascii?Q?NFajnOgdVDO7JJ1w+70kj0b8EULmo8+byTVnMr4PGhzwKv5FP+YCg11Wu5Ru?=
 =?us-ascii?Q?RLL1GFn3+YjNYmKd3dwDbKVHLkd8kdBk4yteQLqYq64XZq9S6RfkQCY+EGw3?=
 =?us-ascii?Q?Dy5bel3KeFCJsP81cyTpkgyzqFbntjlPrjpaRIY4iTn77irBkkf4KPqBn5eL?=
 =?us-ascii?Q?QZoXnTOytDdOMbDK+7ONuPXvhiLhl2MgCqDrP+hwDsGzQm/r1RsA67rlJ7Ix?=
 =?us-ascii?Q?BVx4Hb6QpIUNNmJ0AmfsKfbeYs+UmjbupHXbpMfjaT1ycBE0TRdGM2zInJgj?=
 =?us-ascii?Q?7XzCW9IJhLnvt0+JFNCNYnT/mc/1ekgpbJFjeDvFGbXv0Otpa9mWNNEYijdl?=
 =?us-ascii?Q?/T/0sj/4e7sS8r7ao4Ox68ALiX7QzXkc4NL6ctXS1pzCOlYbV9c1BvO3f53i?=
 =?us-ascii?Q?akC6H5BsNYXVTZa/AOGa0Q+PhafzH8CfskkQLg494MdAAGCneoqSRYr6QyVu?=
 =?us-ascii?Q?geS+f0UZ9xL4Zktv+U7d3Y+za818l2fEjs2YDaaPckoy1zDS8GTZ3ENmCyyc?=
 =?us-ascii?Q?lNiBS6MEphszo0g5HztU65ZQPmkQ9B2MyZ4AOrcYGyfpbT9JWsnu5cwBpioV?=
 =?us-ascii?Q?JjuctoVyy6kMVAE/3sHp0upYpr0jj1j1VkDOIbYxCYBSAyRpDQgSHTiZqQLe?=
 =?us-ascii?Q?urVcapqXkhNjhaN3iPUuwYr4ql/HjVvfSA8ag9KOJw4tn00YZAI7SbiN+7Yb?=
 =?us-ascii?Q?bODozI4uokpYleVZe8l+eTy6ILME4UG2/L6n8F/hNrShx6a/sowUvghpgrh9?=
 =?us-ascii?Q?Kf5nC38Zl7JdYkFKZxb6sCKlqBFL7nmkh11Dbti37s8j9OU9f/tPYSkKUQFe?=
 =?us-ascii?Q?B0SZI9keQUasZRyp3cWdCiU5TDkvojCF16RfRLiGTOCo9pCEMCQMlhgGXkEm?=
 =?us-ascii?Q?6YHQ4XLDi6aLAYz+bjn4wy9JoU1CZduEZKe1p8Dal7ycvcf6T9QVUdRpFag5?=
 =?us-ascii?Q?VkvKg6GHsgf7QmS7riN8cCi9ri1qpb3YF6xZOkoNwoRZhEtYGvQY2LWH6HWs?=
 =?us-ascii?Q?tHb790N0n4gi+DMvkQBuesZ51V+umzvlrilKG6wSYHGBfzwYJ6l8IytZwJbm?=
 =?us-ascii?Q?GPib1ZKZfYT15XQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:18:21.3909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1c501c-1442-4e26-57af-08dd319266b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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

Add RRMT control register offset for VCN v4.0.3

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
index e9742d10de1c..a0e27aefb56d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
@@ -779,7 +779,8 @@
 #define regUVD_LMI_MIF_REF_LUMA_64BIT_BAR_HIGH_BASE_IDX                                                 1
 #define regVCN_RAS_CNTL                                                                                 0x02df
 #define regVCN_RAS_CNTL_BASE_IDX                                                                        1
-
+#define regVCN_RRMT_CNTL                                                                                0x0940
+#define regVCN_RRMT_CNTL_BASE_IDX                                                                       1
 
 // addressBlock: aid_uvd0_uvd_jpeg0_jpegnpdec
 // base address: 0x20f00
-- 
2.25.1

