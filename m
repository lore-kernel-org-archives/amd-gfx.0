Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EE2C04FF6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 07:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3FB10E591;
	Fri, 19 Apr 2024 07:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RTguRJs6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909DF10F8A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 07:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jds3SDXNqv4BVYorTnuGG+P+s53wxUsKV2qTFaGrUnz6JE5Xbsi+V777aS2zOJ/soZwd9jvf+RlqyyssO6DQ5DhefaYHRt9B/Ph1lIV5DuHLqQ/OFXiwo85efE3nkWkDjnqXWSYUt/sgzrEndac3bru0aZ/egCHsPh0SgHZuyZ43Lsbj1YF0geZRvg8H6nRI1RsugLgi/bELQVM1Trnf9O5lV2s7awjGy1Tl6CYAuHYWYbMOh7a7/K9LCupTP3DbNx76bL3PBiTU7/0ankrRTC/6u3KjkZEw/vem2ZRjuOz9oe7HOjhyr4KkOaV0Int15MJr1+eT6fS26vB7u040ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOTsGWlilDdN+9vpR8wwTVu9JNYZbOddNXC5U0ZPar0=;
 b=MzkW1iWFrOzVQZ5ZWeYNUcMxzZk2HuD+iq8/ENgao4vkFJPyWLAJWiRHlh40C3EO2v3Nl/hQU7ChHBBIH5MkmVu72VKXdZrYxmCISp+uPRnC1USOuQQdgC1Ih+w6SzcvYWKNL6+MHYBC82xRW0i8Y/MYweGa51aumoA/MV2PN9+MRETiVBgZgV9/l/IJBxPq1FzzrG8PknyXp0/qU1TDupdns5F0eaBDzTL8yetbxdrMHMJRamigdapiKYvfpr+JXpW4V53XymClZU+/MKVGqvk478Pegfi40M1ppmNUQOTVu58dLoLfTjVaXudSztVlKuwxh/1uFuZ9q4oiRC9CgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOTsGWlilDdN+9vpR8wwTVu9JNYZbOddNXC5U0ZPar0=;
 b=RTguRJs6c8e6mV7IqsQ/wvp8WQLvQsc+q4zrNwCzJ27+cKvZja8hdaIo+N5KFd6fGG/rZ1pOcHN64YJzkg3vriu0Xu/jwJ1eiN28CmVD7rHo993WcSgVq1/cKu5rjQ2wErmnNypvwEC+tO1tX1i60wDaKIx+74jupd87gH6rmp4=
Received: from SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::22)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 07:52:25 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::75) by SA1P222CA0045.outlook.office365.com
 (2603:10b6:806:2d0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.29 via Frontend
 Transport; Fri, 19 Apr 2024 07:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 07:52:25 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 02:52:23 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu/umsch: don't execute umsch test when GPU is in
 reset/suspend
Date: Fri, 19 Apr 2024 15:52:03 +0800
Message-ID: <20240419075203.37194-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: c49cde3e-2b01-4761-8f27-08dc6045a721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kf+A+A6xva/3wArWoVNiPp60tWLEA+HfEOqyHoaN5fuKm8BuFd5eQdrwBB+5?=
 =?us-ascii?Q?FDFWMoWmW8xE/Ar1TgPmu1GwjTSvkb//2X4ToP7x0t8GXSSq9Ol0APWpopix?=
 =?us-ascii?Q?7akpC47wb36TRuJKVtYgP3BFPBtxWd/NhJcB7GRfH8/U6d0q9zIcdamTotlH?=
 =?us-ascii?Q?37/u4UGXLr/lSi1JbnxveglfheZRAVBXxKUleCbM9I/AbOYpz/QE7cxi9AT7?=
 =?us-ascii?Q?SObDPCiBS2sT9iFq/Ia2tuBHWsljsQh/yPaFYhge78O23VZyKHOZVlO8QZBf?=
 =?us-ascii?Q?odgCkI2Efg5mRYvCm3DJghOAxVhZ7os7C6RiFWR+PFFki2kD1/e0qXUE7C32?=
 =?us-ascii?Q?nPDRR6FdZaHHZ+RQShB9OO88otjZD0RQPEM0H35kVndpGSAfC/Xo4uGMWQ0V?=
 =?us-ascii?Q?M1t//TGi+6Clf8FpksKQjOTYobVWSJFx2fkhV9zuBXIY0PaPDtW7QL8VNy03?=
 =?us-ascii?Q?o3NhMMDrUrrds02bme+Odyt/PH335v95fcjshjpGptyGzwyCbfUcHaLjbfDA?=
 =?us-ascii?Q?K5ilKtl81BsODeNmdAENbADSByk3CRpY8y3jpAG8esMiYFTk/be5wBZ8aJ4T?=
 =?us-ascii?Q?VWFmKt4yG067jNtcsTlFUEwlrCUotez8t5Mz6sp7+Kw4MfMgPjAVb/y8BuMD?=
 =?us-ascii?Q?iDS0/XW36R5S0aO5hXttBxVHq9wl9Fl3ENa6jWHKCrrIUUnTx+s3wSpjCJI/?=
 =?us-ascii?Q?FswVK81kD0vMDLkryeipt0bjyEOGripBqsrqp0VOuTlux5g1QGrriFNJ1LhT?=
 =?us-ascii?Q?IgZZfQGnmR2LPwfo782PFO/99eLZSHWMOIii4OdWbWpl5fqZsugS5HBO7LAM?=
 =?us-ascii?Q?BtabgXGoD1qyaH5UkbNzrjK/YNZjT4v9GTPkTMZBRgut/sjdEFUJtctlEACb?=
 =?us-ascii?Q?441MOFaHX8Mrpxx6bb3ljbZvOvjO+bLFqEKswh5c5FbYQFeTvFnLk9WA2dzC?=
 =?us-ascii?Q?5XErS1NakA6UHHDdKdYbtISLX7lYiZxJM0xd38ovGBNrlaMAXpk44FEOCc68?=
 =?us-ascii?Q?gJr65A5+94t+kDevo0bXj9i3JHyJrG+rgtvUYGRrsplNILpvQ/xsMB1CevJ/?=
 =?us-ascii?Q?JnIyGsOfqzgVBzpAUcw9n9UKmcJMzc9a5BzXOO/IfrDoa5/9A7uLZgXvv7EX?=
 =?us-ascii?Q?2w0YKr3wFPj+F8c/R8/vlxRbhQQUc7CJzD45QGkS1UmaNJ0l8ESZn1p9Uibj?=
 =?us-ascii?Q?AGDeOsGIsRQCkcNiRL3T9x+KVZpW/u0CVeBZ5A68DSD3QF8jZg2RlGlDwTpd?=
 =?us-ascii?Q?7FcQlAEoBkrGTQgiJxE4u0smSghDPw1re9p+rOC98lwJxSCVy6ONokfGG/Me?=
 =?us-ascii?Q?PjH6sg6VpfFeiR67ESys49HRHyIzJ5N2tSrqzSL8dxtuQFoZ4SVyXl/Z8/cq?=
 =?us-ascii?Q?h+BkFVguetKc8dxIr2hoT7D/ql85?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 07:52:25.2147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c49cde3e-2b01-4761-8f27-08dc6045a721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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

umsch test needs full GPU functionality(e.g., VM update, TLB flush,
possibly buffer moving under memory pressure) which may be not ready
under these states. Just skip it to avoid potential issues.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 06ad68714172..9f9d6a6d5cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -774,6 +774,9 @@ static int umsch_mm_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (amdgpu_in_reset(adev) || adev->in_s0ix || adev->in_suspend)
+		return 0;
+
 	return umsch_mm_test(adev);
 }
 
-- 
2.25.1

