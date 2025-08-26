Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85361CA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D7B910E5EA;
	Tue, 26 Aug 2025 07:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CvLFUkP2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686A610E5EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F84F7jDnHzEUQ7ybqctt5EuuiHzSgfNrJmFA1I1URk0r7plVn2RKDOFNPPrPB7DVNfthYN+NyUXFAvVsfG0UGg7Htr+DmM4YtxO7GB2LsFdRN2ah/N2ZaUjU7GDjIstyrfUm3YryNDgu7HB61BX9IxVlFBPzpNAiCPkU4vCDrM2Dcf0saa4Anmsut0zPW4mtV7yBWsyALJoViZlFVgFpX/V0xEmRwBoGxCh6ijXIwHFfkXFUnGEZpwSwE6vUgpaSqoN0jyc+f5ZFgLAvcZdR0P3aGN7cUHTnVXHAl84Qv1ezVgST8NceYzlycCU720YZFetfTRgSgA3MqLxNqW/uPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fqXyZVQFX/ZBh/ML/luGKld4KvPRG9Mv56GshTOrbc=;
 b=qXj8iyLJpw60ZIFT+0Aziq+IOoNxlvnVGQQ/TWPAlSgPhB2jUfTOPiRXAFy74lcQHYDrMbO2loUbp/xEvbr70n9HCmuEOJLQ8ixyhFXzfUrCDUd8buSx1EQt09O6GLOWfcNYp74Q8iSpGvR7sQ6ysUkLUC5j8UR5GP/GDgqs4LFMuJQ3SedvIphGOxlc3kuHFlcbhEuH3yeUUoNSV4u4fPrXgZUmaIz+hgfUk2uLQIWCh7KnKLvZWpo1NOl5WVqIMPIyShJ/aOZ+5MaJOSRTmuE37HvvQdGj8B6zO49jOarV4Cd80VZj/fKR6rYvrW3/kv3zSyHQlZFdg2WSQD0BBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fqXyZVQFX/ZBh/ML/luGKld4KvPRG9Mv56GshTOrbc=;
 b=CvLFUkP2180S/WV20AHL72fM9Nny/N4126P2Wr/IeV2ZtOt8JgSpn47tHosDNbrZVQN3VAlN7Yvnn9TXzzPfulPa4bQsOH+Zy8jNAhCMA0a8/LmwUGpB73VFAWyP59Kz0VzVQrHqoEoc8C/PzcsJ0L3kne1F4IoO/LxVAYB+wzc=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 07:46:59 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::76) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 07:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:46:59 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:46:57 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v9 02/14] drm/amdgpu: validate userq hw unmap status for
 destroying userq
Date: Tue, 26 Aug 2025 15:46:34 +0800
Message-ID: <20250826074646.1775241-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: e4596dbc-bcda-4bb9-de56-08dde474bd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lG1+ZEED2Hli5DLlGG2/m+BRxRNOfZ4hrVifrqQQARZsSYhw6sbEm5Dm4YzS?=
 =?us-ascii?Q?Vd2gzPpuJo8I557f8mtxPPPV5IoW80jG/7nKzvyTsH6H/vtNpOkE/5n3YdrK?=
 =?us-ascii?Q?RWjxVglthZ20wJsV1a9NlAOMWabIbAOJfP1KUWXu5IMbDniniKOJB1S/M4uT?=
 =?us-ascii?Q?WOzMnoZ06L/wDtkikuXXeLarVJ6AU+gLs1LHJS3PLHCc36EO3fhslRPwkw0E?=
 =?us-ascii?Q?9e1qm2RqAIBKmMKLBHofGDUPmOD+PFkK6xesmQ/xl2L5RttRs0+IvSKX24Np?=
 =?us-ascii?Q?PtBFeXztAObVWWfFOKg1dKiNg4HiF3uCMln7B60SeWKtMrw00OBKJ7fPFkHI?=
 =?us-ascii?Q?W5UajWG9LFDT041l2SBZ1zP4g2v526CSzqMsyQo9x8ZsC0NfNGSE/CwivhJs?=
 =?us-ascii?Q?0cowDASq8GLdgsvchm87Wi6vJ/VAhoxz+c+4/KxhmRVD1ReScW7vzkZiGh9g?=
 =?us-ascii?Q?+BZBFHgHJt0R0Qab9N4IG6EYQzcQS38bId0Ky9buhnSMJN530pUGF2v3kcyD?=
 =?us-ascii?Q?JaIHC1koV+xC7KOWraI1eyktYnm2eH/FdV8DiJxDAnujNuA3A4+//Q7YGWfG?=
 =?us-ascii?Q?jh8FaPj1zZZ8gdUgDwUAt4ZoVYaIsn84aHYojZSzddrOdLxXcKiTfw9Hlphk?=
 =?us-ascii?Q?CAZYUGSOvQo7pQML6TQ/vwbDV9nJhpmT4I7SePZoN4s0SaojF9jb7JCOD6DQ?=
 =?us-ascii?Q?C7m72y935Ru+kB3XYx8xZP13fci0sSi4WuIFvGloLWpXMgvHU9Y1diJU1b+P?=
 =?us-ascii?Q?g6/UUZRexDnviimebaAFeE0ngSbG9kUFGh50MyygSfXeCXRWyMLYRGHRY1L2?=
 =?us-ascii?Q?hQYbPnyD8ztIp8JqoSBagTXqgnHKcCvJN842krzOJJz68+hFMwvB5ihzwsYW?=
 =?us-ascii?Q?6V5o26m0oPeivWtfWuaCF5vv43tzV1WKoIT1j/V4KUDLL2Uqtlemg3lMC9Sh?=
 =?us-ascii?Q?Z9+OkqyRK6ZjHAXqg9GBynLfCOQe+GEk7DmrYXe20Nf6RC0uCZ5zue2dhqCn?=
 =?us-ascii?Q?hiBsm6se/DGRkZihDfFQnKIMI1uW/aHw3nqpNYMynTrLvUFYncnzqF+mGRxf?=
 =?us-ascii?Q?/JBB4qHeL4aVM8zZeZ8tyOotSW8Dtd7YuA6xnEcvcqhPZB8weoSLvF0Q0Enn?=
 =?us-ascii?Q?dR8rv3OeGqIB90is5C+DJbDyz/jYKqQaxG1oWUzttWo7V6n1KXMs3bRSVj79?=
 =?us-ascii?Q?3zQbHCIl/EUoAbBSokyi20Xd2Zsk8ZyIwlhg/12wg7Zm0BoqEpe9PKZo5m4+?=
 =?us-ascii?Q?kz0vOawNmnD6uLycegkdGioZd1YplejEfpqGDMMFyMc0hz9SDQ/FlKDIuAx9?=
 =?us-ascii?Q?kHcLdxh3uD7bXtKEtKrSsWySt63EwMw8Jv3Py6ibPXGLIBWPuf1egugC48WB?=
 =?us-ascii?Q?WutijSeJhPMclqEo4PDx+5YnM5aejKhs328XU38oj6cEAk5E33iwUUzfqXN+?=
 =?us-ascii?Q?9d0jndrYVfw1JZ68TEzUddDRWlEL6shxC0xJGJsw8zzyBYLxX64wJtBynh40?=
 =?us-ascii?Q?dfTvGHfO5BsRFaHYxUI2u0P7S/swp7M5m8Xa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:46:59.7987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4596dbc-bcda-4bb9-de56-08dde474bd38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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

