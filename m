Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4950DC87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C893910E1C5;
	Fri,  8 Aug 2025 06:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TK6Iv5ks";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6E210E1C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q35XbzQsTxWA/ck1iR8LLUIoifl0LUQctLxs8GLEMaSdwhAaG3beVVHepq5P04aq65fDspg08RQ8fVSDwfsm6xhSxDuqXyIAwEb/wkxkgN60dnOe10vsAK6nkXyrgJKCQsl6aunQXzO6pLB6KIoXX6xFZqBjEcYCBSQQg3oubFjccTykYcM7rz5OW45ThODioAH9XFwsYyY+2vHDIwV0W/O0Rk4Is7V3HpqZMcfuH5Tfd9QodUM3p5TBxvTwr75q5NnKUYDusJjCFWXLEvCAKBulzgnphoYTSMgqt0+ffbNJrXrx8slb/b059pDqexRGLhxgSZ8w4pH9pZWiZwgwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fqXyZVQFX/ZBh/ML/luGKld4KvPRG9Mv56GshTOrbc=;
 b=DfJnWV+WobsnzY8LBILpqXmFipvuUHshBpGd19lpm7Men8pE3NCs5kSH2mWwz7nAO2YlZmLjWd6uBQWG9wb7Z+TCeC1uS9tHJANnCfTh40+29u657avx1QvcXpKbwokgZSCM+aOabd/eJVl4ryQWIbhpB+6UmtbeFgGegY59gHvirM7D2kVqJbuPUueYuRKrjUzYrD2rzLO2tneugdDjfgJPCU1ZBYUN3z7BrAMnxxYYDcFVanihLxYanS8fqtPfrEPleqahlFg7qvNqHkKvO3SDsZHBs7FKUEZ4BBL/IXV18cMFjnKsPwVGe6XEkTsYiumAEyP/hA62YhhuC2c6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fqXyZVQFX/ZBh/ML/luGKld4KvPRG9Mv56GshTOrbc=;
 b=TK6Iv5ksw59f0DPkbfOw9w6jm6GJ84s9FiH1LBSvm0P6IzcShocJ3g7AsAJDm7uWx32zfjw7dbwpfMEQWTgGx8y3uknVssKbxUCJCc5YCe8SOvzLJHZDG2VEiUPh1favy1wul2R4QUKN4TgD/oW9+6m+zk+vut4Q2qZiKkE42Eg=
Received: from SJ0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:a03:39c::34)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 06:29:34 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::97) by SJ0PR03CA0359.outlook.office365.com
 (2603:10b6:a03:39c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 06:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:28 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v8 02/14] drm/amdgpu: validate userq hw unmap status for
 destroying userq
Date: Fri, 8 Aug 2025 14:28:58 +0800
Message-ID: <20250808062910.1613453-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: f70f6279-431b-441b-20bb-08ddd644f10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?57B/dSJhmCZuPz7nMgjmJPNneqeULIiUN4aLkl9Eig6JyPBN4+DjAag4g5dh?=
 =?us-ascii?Q?xoQnV8lRMp5jfzNRgP7ON0SrSbPBFaLzihecmYqLD4QC0MikW/WjLtafnENO?=
 =?us-ascii?Q?8/0V3HdaCbssl8TyNpCfp74/eL6nu+OYftni7oRAP2oRraAc9ySneA+QxFI4?=
 =?us-ascii?Q?ce64juI98GvLe2NRLgjD0Nr2G/tuOZqrEtkBzH8MweCnts2NhG2QM0DJ2LUy?=
 =?us-ascii?Q?T7oV3fz4S1tTYTgAuNh4vZwqunXYazNk+iTCNIUabnVVqaU8QTl/VmC3lH8c?=
 =?us-ascii?Q?Ts71PtEDdwkJKhElAvQk7mKMWX8lyFmJRU5I2VpBXEBiPh/PughIEQVi4y1N?=
 =?us-ascii?Q?vzr0p1foSgmSU6VwQzkPRvouvQwRw/vuH51021OCkxsc3VJYodsjfCBtUaml?=
 =?us-ascii?Q?kecebkXiwGRVJliSYeyGmkwe+1nLQeAs9ANfNIIQ4q8f7I738E/0vpsYI11b?=
 =?us-ascii?Q?Eh/ywjDejOHTXK1WxRdvlArtEM+79bnTvY5PJhAZC1iImneeMSQjfHr8LT9b?=
 =?us-ascii?Q?bE7pxAlH4MMASKAXiknsdXGcYCYpQuKNLpH0i1cysXqqqBetfxFtJvKCLD1J?=
 =?us-ascii?Q?asRz4tSCaOBv77Ze7+EGdLgxWbc5P61iKsGhj7kHjeXt/Y7rtmKFodZ6jG1g?=
 =?us-ascii?Q?2w0S2fwln5Ijp/ApcjD7Xuh2thrB75pwrovHP3QIVfh0NX+x//9Q9WPg2vi7?=
 =?us-ascii?Q?slupd5zAjGvlYMQoKZ1iMl0PPONZ+eK4Sq3j0PrwaHcZK/uUXodKGnxZvjKZ?=
 =?us-ascii?Q?p/Sy/GqFJONrryOiv3uzr+CtOHitAwv0pdT+CDRQtxSoN0DDVxZPXX/Rh1Q+?=
 =?us-ascii?Q?N09sXqEkXVIsRX5Z/qvoRnnDABPKrEBSzhu10K5QnawXxPazMs6JD955Cc1R?=
 =?us-ascii?Q?Jzx5HFkxb8H3s1iWZcPTonvuIeUOCypsAWqYT00C6S1gHAfG0Jtg3aDuGkSy?=
 =?us-ascii?Q?qrHS2vWNz3prxvlLRZbjq62mt9NY2btkxuLMaxkie+T/79D36zxl5fnrKi7m?=
 =?us-ascii?Q?S9/x+1IRsiZCvhJLECkg0IABzNL/GXSw0yZIlatIdrAGWXUjfd/CmDwi/8yB?=
 =?us-ascii?Q?0rccM7dw/QbcB6gaz2oUTwyWnft52wX22Whl7M2L4CGehVGSUN2wzcbXV26Z?=
 =?us-ascii?Q?bKA/MoFPqtCttpE3+7ZHknN4tka7/E/6ts4vif1BByj7xfeZ3jfQkdG44LU7?=
 =?us-ascii?Q?AVurvQGOEcqtpyBnkIhEX6qKD8u+UvmvDcIjI72gYjyZvXbv8XSmZQIWpoPl?=
 =?us-ascii?Q?wqlOk3yJiLmUaicoP4PIICcdjCRFVraMdCEiqwp1eiaodNCg9ancPkmt0x3q?=
 =?us-ascii?Q?acFuhzoKkk/gTkkh50nYF7KjG0qa4JyqxoIsitgrbzlUOD8S5kM0XegBEvEh?=
 =?us-ascii?Q?rsJfp8NA13m8jXwg07GzD/nwz4M9G7w6Y/P+RRZ/CnjFsJxxKAQzazcL9yC1?=
 =?us-ascii?Q?+UovgJs9c60J4EQAj5sPDxaUfMaVL06QUL3+kSYv7SCrmq3Uqetvu+aNQt33?=
 =?us-ascii?Q?CAw2z0sEa3nO98l1j+SoJrqcjGCMKj8Wjdlp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:34.5349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70f6279-431b-441b-20bb-08ddd644f10c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

Before destroying the userq buffer object, it requires validating
the userq HW unmap status and ensuring the userq is unmapped from
hardware. If the user HW unmap failed, then it needs to reset the
queue for reusing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7f9dfeae4322..2b35198608a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	/*TODO: It requires a reset for userq hw unmap error*/
+	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
+		queue->state = AMDGPU_USERQ_STATE_HUNG;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

