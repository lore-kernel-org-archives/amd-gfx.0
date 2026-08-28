Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC0BC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFCA10F23B;
	Fri, 28 Aug 2026 04:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oWb3R6uV";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC5610F239
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ny7Mdx+tlVPxsvJQHRS7CJtlbJwp58EK54Aem+l3C4RVCRnHE7Oo61AdpmqKGwMNanF41esHrp4OxoSbncBoprG3VmQe2TN+6Xz1lfcfafxGYTcolZ8ujyBQDXk2cMAeJkb8p4chM8pX8gHYa50ZMvels9J3FvcmgiP8S3h8JFUkq30G6pj9OQyKCxmjhKFjIEg6NH7PXiBX4i/fo5l7wWT53+lEuARQ+tehaE2UBf+gN8OKv0hoZoCI7s3P2wAv5jNuOoJveiFx64+HIU4AXuQzdqNd2Dxg9PW4kvsq9LdbNVWD1kTgeKmihIGY3cNNhZJxeKzFlKBBn9MlCvbQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQkmkR3Mn3j/sCsBs467NCWzsmaG3suE3ddPp9hT0xk=;
 b=J+r51zMs2DlAjnlOYl+nHIzMz56uWsaYXWAVB5o3MToX3A1yTuLNYE9W/DFx4K4S+dOmueZ8CYX1wUYeHJ+MByw756avd/i8Xwl//GqvH+CmamUsNFOYudaMgRBYT2lQwRSrzTsHMs1MZdwoxhQFyYPv8QOoyQ0VCUGWgKGE4qbZrQGBs4JySZ6MSg5YroztcL1DPb2q7hlnTHq3vTpQUcRvZ3akhrg3a89uTG7uadzo0yAHqvDVC5k5xd631z+YWJIbiaa9CY9u3H4GHwx91kKwEW8nqmYhyDYp1B+nJS/3pQFqWOZruWGnHa2BzoE2qVe8CGXqXD93bYIca7KRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQkmkR3Mn3j/sCsBs467NCWzsmaG3suE3ddPp9hT0xk=;
 b=oWb3R6uV9ijTDxWRR8UkyQEn2+CgYHxDxrsxquAXGk1VMoHf6cgW+1GrUBTt7hAF2tktizihpaThW5itk7j72yP4nS+OqgW2zj2d56YPR42fGv82awzJvp209/UNTjUbKlJF00ZzFDesmA++avyFTTjWBlXJ2JgpjLXJUTeaS2g=
Received: from BN9PR03CA0193.namprd03.prod.outlook.com (2603:10b6:408:f9::18)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:15:55 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::a9) by BN9PR03CA0193.outlook.office365.com
 (2603:10b6:408:f9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 28 Aug 2026 04:15:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 07/10] drm/amdgpu/sdma7_1: implement update_mqd
Date: Fri, 28 Aug 2026 12:15:13 +0800
Message-ID: <20260828041537.3464782-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 01687284-cf97-4a77-7174-08df04bb0dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8nwzS1RYacA93oWcTH9usjvP7DBh5Ob1U5L2o54F68eO70I5xb1gBWOQ6gA8LAbknsKq3Qgpg+bVYnpAC1Rn3bGElzBeo1vM3u5xU5DJe1xiVcAaY3xQXtjYaHk9jWVg+acpxPWrHXinX0IMeOOd63FmslYjhrHpkbLYpKpx38h1hvvTJVOzUaaW2uaCjL+7SiJQVgD3qzYyDhXvXWzq8XWUEva5sQExpShX5QQ0aK/DGiB0Jx1Td+sMTxk53rsgWK7dn5TAwCZ9DwfeVTtA7m0M2dSrfbBiosnRGgwZpKfjLb8otVhpkB5a9torot87cH1iYiVwoPWUn9n/eAd1DBiJh9N/5J2c2hStyUgeagpoVAy63Z10VCkI0U+x94DLAr8MIjJ1tRZzLqaw0a2wXwsJXmbDdqCYgBN2cUwXpJbgNn+B2uufpnlLc8xZDSlrhqFWd56GsgvyK9nWKk45nXKkxOoPuvlK9C4TcIQV91CQ/KoMEbJi3cgCVnD+i5OuLJP5a1LHauLAM4m+npFePfC99kF+dkcIbzM90TKSzOiniizxR77qjM6OATZiTHN7Q3/WYb1RHPggVIBypA402VgPfw73Y1HN4T+qwShugsdYpxmFTLzjdQpZQ9Kd7aUSaOxUtgNVaxAoKnxrLVucpcV63bZfWbtpZ/wSkyQp0uL3CZRqTLiih9P6NGiyvjk5U9vG8Qdz9+QUnTVnRAyocA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n6dvRbtUIuPKREaH1Fwz5a+dRO93LbtwJA+tr932cDSwqm8hWIcAv43NMUoG84MI126xEXfWQF3MTlSJI/9ZCosSd6QsPWK5BHU8GZuwVnpIryKLju4XdX/8F5DITHckciL+EmNmcivBOukeXlYPfC43tf0jid95qxvrpwYf/I7ebxag6D4nTHi+wHEsxOaBpkmPZqROrl4Z5xRyyU74UixlyabdHjEsSZVMs7Gd5osQU0ZSa4e444Vm1WOaie2UGJ/SHZ/2B8WtHco0OkoilcMwDLIXEd63cssdu9/T3BfJk8my1e6yN076TqFmtk5RFRnJjtwYXD58Xlkja4KC9Yi07vCwsUYfsneQaExpoxHXHcGVLPKx5ZPDLC057+RZubN0Ho1jOfSjnA5aBizez2ZbUyEgJlsL1V86Tups2mdnDXYg7R3uyNANNT1k8kO1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:54.6494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01687284-cf97-4a77-7174-08df04bb0dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
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

Implement the update_mqd callback for sdma_v7_1 user queues. SDMA init_mqd
leaves the ring rptr/wptr alone, so re-run it to rebuild the HQD, then
restore the saved read pointer and forward the user write pointer. Force
IB_ENABLE on, since init_mqd seeds ib_cntl from the live IB_CNTL register
which reads back IB_ENABLE=0 on a stopped queue.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e9a3bcfd7775..e74ab8112d50 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -889,10 +889,39 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
+/*
+ * SDMA update_mqd: init_mqd leaves the ring rptr/wptr alone, so re-run it to
+ * rebuild the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int sdma_v7_1_mqd_update(struct amdgpu_device *adev, void *mqd,
+				struct amdgpu_mqd_prop *prop, u64 user_wptr)
+{
+	struct v12_sdma_mqd *m = mqd;
+	u32 saved_rptr = m->sdmax_rlcx_rb_rptr;
+	u32 saved_rptr_hi = m->sdmax_rlcx_rb_rptr_hi;
+
+	sdma_v7_1_mqd_init(adev, mqd, prop);
+
+	m->sdmax_rlcx_rb_rptr = saved_rptr;
+	m->sdmax_rlcx_rb_rptr_hi = saved_rptr_hi;
+	m->sdmax_rlcx_rb_wptr = lower_32_bits(user_wptr);
+	m->sdmax_rlcx_rb_wptr_hi = upper_32_bits(user_wptr);
+
+	/*
+	 * init_mqd seeds ib_cntl from the live IB_CNTL register, which reads
+	 * back IB_ENABLE=0 on a stopped queue; the re-mapped engine would then
+	 * drain the ring without executing the IBs. Force IB_ENABLE on.
+	 */
+	m->sdmax_rlcx_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+
+	return 0;
+}
+
 static void sdma_v7_1_set_mqd_funcs(struct amdgpu_device *adev)
 {
 	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v12_sdma_mqd);
 	adev->mqds[AMDGPU_HW_IP_DMA].init_mqd = sdma_v7_1_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_DMA].update_mqd = sdma_v7_1_mqd_update;
 }
 
 /**
-- 
2.49.0

