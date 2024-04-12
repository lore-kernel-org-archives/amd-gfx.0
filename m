Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0B3C00A94
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 20:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626CE10F851;
	Fri, 12 Apr 2024 20:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1mj366ay";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B725E10F850
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 20:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxuCLvvKWjRuc5NBy9QHRG53+QBqveNT1kuFXKiZITZeKZpTx6AbdVS/nIjSApyYY43P2EaZ+QOHshflO49KaU07YSGs/sqEN5+28Bbn7pr4tBHhA+1ELY8Y3CWXgUVnhVQrJYXZOSBkR3tw9KFXwLe2WFGNe+MhR7MvGhAlxzb2uxu+IniO8mm1U/i1eSS7+R+r/MPNvltQTXOxgP2P35Qm8B+ZvencSPDtTAqDc7psnHIOX90XTpL8blEW7Kl5CbBC2eDc0TglQ6uQRbSHibOvoawsyMlur8p+PO5v1QEJ/UPybIgizlJ7bAsVWU8H8vw0u+5cu5ZyG5ZlHX6yeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvSbrn0Q21TpJ3OuzyDwEQ5OK2dcWliMSB4wuO8sexg=;
 b=ONAF5mvzWsCAemxO73XvV2YMN9vrwX68z5jNkK5iWVvZJFP8zlmKEhriAqtDtaC+GGd9TnW7jlhprGZwWZiLnOAa6q07IkRAogmeyp4j4Avx80ZiYjDEVbC+ko47OH/YMOA2MlJ4jSUimdr6uKxjf13oyVvfXmA6TGgQzinIkRF3md2CiLUxr9q6fxX/DaPuFbAVAAAgVm/ULtkd6l+3jPedge92Uf+2NRasNS7aQxdsfBmK7rrb5+hY1Cy/cJoQwtapc9tcGqcfwIBJf50iz/pQkUCs2C/sZOcI7Hec1nY9xNO3FTid/9hMHrV2YFXifciUxY2tyGgwiIhG4Ex1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvSbrn0Q21TpJ3OuzyDwEQ5OK2dcWliMSB4wuO8sexg=;
 b=1mj366ayUUVc0TU+vgNRhdiAT8pGI9DyrpchEgXU/PgIhVpDj8B7WCaGzJME5jm5WvcIHXC95cqv5EImw4Aw23906KCwSn5H68NdzRaTT2pdIRlXvg2QpoWh1SA73/mTZrDvvlVnPrvme8Ve7LzChpNo6SyOu9QgpU1rAg+to28=
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 20:13:42 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::97) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27 via Frontend
 Transport; Fri, 12 Apr 2024 20:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 20:13:42 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 15:13:39 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 4/6] drm/amdkfd: Increase KFD bo restore wait time
Date: Fri, 12 Apr 2024 16:12:59 -0400
Message-ID: <20240412201301.14154-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240412201301.14154-1-Philip.Yang@amd.com>
References: <20240412201301.14154-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 3603d853-f800-446d-fd7b-08dc5b2d0cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmrT6xT+yz2F1zmAjIlBCKom0jie2yikZ528myLpHrOthuZ8uqq9BsCoBI+qI71vei53izIuT/s9R0IJ+o5FJ3xKFzzcLFyHyA7yAwKtPz1ey9qNhy5Zcd5nyLEaxQU9EL1nmCIFDvmadB0hy4ZZ9rzSCGkc7Zryv0wt2hLMFNyju4ZLQy16LMsjNgnK18obvL7wP+41rV3NUKysBESZZN9E3+k5yLnOH1jcnBZuh6DnEpiztapiSoE1u+R+VccExAVf4C1UcoDL+KOdK76gHvBUDNYRYUUAq2dN2nNJdHCujTy6FVtiabwyPvfqYd4E3tBS0HTNsS7oa8sd3yqff4JwdDyZCJ75yV2KsRX/iPUEU2V/DQB8WrS5i7BST1sJwelNz6SWudT1L/laHQh8AMl9Q0fAbtcFgvvzuJTRMB7pGQHN5OKkg6rEknu+OUBO8aDz2BjIMIfXgcmHjLBV3/vfH98umafYcT3WiF0mxiiVDKZILcbwPxKe50PxHd2lm5O38DJlwGldjZQbq2nyGORKNrjC4Ys5HNR63h3A14EOT5bccpdPmhuK0/nS+pzg8ksIXvzAubQLsskQbeCGgP6wWEv5YIludcJfymg02zwXMLJTXJIXRb8X3PhP9iUaGHe5MYq5PkK/KY1jJWh9YrNNsBMKNVcdqs8XvGiYyCn1FFha0J8WTSGssgov2PrSSdTjm5eGe8gsxoi6xSZ99yS1aln3uPkUa4eXBnZfyKWSP+2bOso4Dcmirl5cghGY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:13:42.5171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3603d853-f800-446d-fd7b-08dc5b2d0cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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

TTM allocate contiguous VRAM may takes more than 1 second to evict BOs
for larger size RDMA buffer. Because KFD restore bo worker reserves all
KFD BOs, then TTM cannot hold the remainning KFD BOs lock to evict them,
this may causes TTM failed to alloc contiguous VRAM.

Increase the KFD restore BO wait time to 2 seconds, long enough for RDMA
pin BO to finish the contiguous VRAM allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a81ef232fdef..c205e2d3acf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -698,7 +698,7 @@ struct qcm_process_device {
 /* KFD Memory Eviction */
 
 /* Approx. wait time before attempting to restore evicted BOs */
-#define PROCESS_RESTORE_TIME_MS 100
+#define PROCESS_RESTORE_TIME_MS 2000
 /* Approx. back off time if restore fails due to lack of memory */
 #define PROCESS_BACK_OFF_TIME_MS 100
 /* Approx. time before evicting the process again */
-- 
2.43.2

