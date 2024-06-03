Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8EDC27C50
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85D910E217;
	Mon,  3 Jun 2024 01:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xtG79/jb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CB610E1FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAwTpvEnOyW0RWO1jPDQSOvPrbMikkJTwxpV6dBmEUww9q7wtlYhprHy/1GvuSNGfmQbXgc0lk2I9FgRaJ9BpjTIe3dSpjhA/KKNmlIbrjLkPpKWeF0VD3eoHwOM/wo0XBRZhcbmm2Sm5v5jBMf8T/2/6MU+AfwlKGzlOP4xGea6aEJ4KBjnuYYEO9IYUUq2DeRmAiZakA8Ppe2mVdDbTDBtVP9tS3/dP2+xdfHvgdP1n60hc3z8/pvxhvJsUb510uiY+JIeje5KPjclmHAfzMGcjyUIRzxbLVLIV6dijsz0r2W5RRjqjr3jlSKBghzV+v2rMZ38O1pZPoiy0HkVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv6EJLo0Gy5zBeBYPfp1tZBZVrR6tnHhMjo1GYKDL+8=;
 b=VX+aU5mgWN8UxxdJPGyXGfcX46qSHoWJC1l4qsNmDHlvE3eOljPIGKrcC4q0NiQ4+KIIju3Vy6IDeeT8V6WNTLkkCDqH1ZJYszPRPMbymeoqsqo6Wk0MK5ZNmhrqOKnl1aEundhTVsWhBGepIHMFwdqUhQc3uJ70fkL2pKvvZvTnbELpmy5rXn0q4/MS2ChdpzqlutfLBxwzHih3Cjsi0p4nt7IvKsjI0l5C8+8uKHtAQ0AZ5TZHnjHTIphRRKfjrim7kKWKZEPA/7YWq88xlR3kBesZde0TqNuEcpSswIwA2IKjmjaPa+PDtxW5d3AWdQshz2aR5cRdRLwBBO3jKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv6EJLo0Gy5zBeBYPfp1tZBZVrR6tnHhMjo1GYKDL+8=;
 b=xtG79/jbcCqKdIKWL8fsbS4M1D3WsBPk6qDCG7kHjEaZFoW8y1TgMI1hOIB7g7e+Uz3PaI853ZlgZ6O5zSqC7cHUN1oY9gYfthKDKMpaVDnZHvNfZSyX5okb/6Vff9sdhm+ljTto4wGiZsXKiXgx+7URFy4vnZWrGSSJRlwvPz4=
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 01:42:56 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::2a) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:55 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:54 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 10/18] drm/amdgpu: refine vcn firmware loading
Date: Mon, 3 Jun 2024 09:42:04 +0800
Message-ID: <20240603014212.1969546-11-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db8fdfd-bfef-44e2-e739-08dc836e7dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?78AW2fiEr4NYatVMliOpK3d3OnHn9uPaWdObQqskdRz3TdSPab7e/dON9jTW?=
 =?us-ascii?Q?RxSqCp+Zml0WQ3d6nZS/afKdDS0NPs7eNWXr9XXIcdLatppXb4ts//t56r1S?=
 =?us-ascii?Q?28UL7gQK7PzclIEpQVEWrvMM5J4EBPnC5rhi3qnEqJDhXESdaByUMHRYoCLd?=
 =?us-ascii?Q?PdfunsxeQWSzQuL4Piu/6c3BahdekW5Y7ZqCLJZvp4OcFkW4VYNyRMjcotqE?=
 =?us-ascii?Q?1FwCdzjm5Htl/6w6vm37e9QGMN8a7ysSGGZbqMwH65KejPHlZG4PDUsLf+LC?=
 =?us-ascii?Q?k10ZkrJD8oqN69IuN/H/4+qoPec17Lta/CAgem06IRBFCbeXKOLIw1NXrZlI?=
 =?us-ascii?Q?txKYkIzgM00qCAzWl4iVpd76S8NBs15edDDmkpTwxO/lFNNtN4Wys8qgZBSf?=
 =?us-ascii?Q?elO1llNYMxJ+yedxx9Nx4YnQDDMj4J4qfFcFYWMS7iLhRcLDAeZYwAjmCRfL?=
 =?us-ascii?Q?Gn8kwzv2JQ6+g9guhKaUpVuC2uEPi5v/TIA3k4b8TtUSy9BiWFx5s/yphO+2?=
 =?us-ascii?Q?zCdRHNPAi2/DLKgTpRB65QpG7xb46K7jsqkZ6mwhJk8TkEe/2ivDj6Q/JJU9?=
 =?us-ascii?Q?orAAf6iBAfLPxQG8FPzH2pzVnI+lqXjPdzmVWA9GzyklMjv6m9epA8HYHU09?=
 =?us-ascii?Q?xI7uyKCbzFraoVQ5O8tUQ7ZkrJPP7oUzNfZDBLxy5X5mBEDrBEDsBWi8NhXj?=
 =?us-ascii?Q?0g+hleTzeFhESFzJ3tUCwr4YGtSVAIschLt1NlWnVj5QQ1+D91nxgvfTWXJI?=
 =?us-ascii?Q?8fINqQEp0jelMJZG4riUmiJRzc3ozZk2nQ5od8FdFKtMUNOakd6kP51XfTIA?=
 =?us-ascii?Q?uSjtFi074vSZtEpHmUxy2i5vTFO7z2rGvS1n1gfvHi7ZSoyLqlcqYynoqvnl?=
 =?us-ascii?Q?Z2WqFnuqXgH+KWZjZfWm3rydRPAdP7PnJHa8aVpErw7TGp5PrbWUIlUQAfaW?=
 =?us-ascii?Q?GUjeAk7ZRZHG3PtKP3tc/23JQQMnjbd3BGkKVNeglugEfc0jmo4Sakvnyqrx?=
 =?us-ascii?Q?k7aPVVUefKy8AzdQehhUmdpowJnjt2wEET9X4tF560SdEnxjAwkIJOtxjvN0?=
 =?us-ascii?Q?VQytZgZ9SwFWz27Yve/trWbPH6n52RXn4Vn0MhfVl2+TGdYKnz48O1ar4YHn?=
 =?us-ascii?Q?QjM2fFm6DRaqsUN1FNuZ+YOPLw77LHbzfrEceqYC9XJip9IklaKf0ouG5vFl?=
 =?us-ascii?Q?1+kTsxgt0OuG3CxI+09y5kEpUaiYP+JUCX0jcwmMrpWlzr3aLW6iKYahSIaX?=
 =?us-ascii?Q?sMx/wBy81hXCh1pp/ipdR9v3Eotl5nkKo8HWLobbwobyn4EgJA3k+8zHcstq?=
 =?us-ascii?Q?dKp7QSwouwgIHB5Uln6RA2i6VSiDCO28YM9umNoCPj4Hl2xHa2UDs9bMBBe/?=
 =?us-ascii?Q?qOlHwnM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:55.9329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db8fdfd-bfef-44e2-e739-08dc836e7dd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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

refine vcn firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 5e2b7c340724..8d65b096db90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -94,18 +94,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 {
 	char ucode_prefix[25];
-	char fw_name[40];
 	int r, i;
 
+	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6) &&
-			i == 1) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
-		}
-
-		r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], fw_name);
+		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
+			r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], "amdgpu/%s_%d.bin", ucode_prefix, i);
+		else
+			r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], "amdgpu/%s.bin", ucode_prefix);
 		if (r) {
 			amdgpu_ucode_release(&adev->vcn.fw[i]);
 			return r;
-- 
2.34.1

