Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA667CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 17:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EEF10E2F0;
	Tue,  4 Nov 2025 17:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVX8rf2L";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0592A10E29A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 17:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgpIN1rj6opx56GkDe6eKKkBrhK0sojpK3+B/T4JiZHwzu3fqFdQamTdUcMD8WMTyLFmXrkxGxF7sADZ6y82KUHUgXleC11fNhlzIwSc12nr9RVEOs3Kj+9Mbsznn1fMNF22bGYs0T3PkCZ2NhwdYAPAkZ1NEWWa3NpY3N4vG2Kpfw5YwWWpgDL7fCx59+3m6t7ZoDXCOhOdbL1hZsBEFnSw1XLiBpEKcWKX+6g3AVwtGLJbcPHVPPXKUWw75AIs9X5Ozhaa3eO2bHE6vbsHgQJalYhvmZuQ/d8wMgR9KGNzfP1r3DUZZI5vBXvdM9fTO3hlz0pnlFwc7hxu/CwUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P73mdr+dAPRMX472EdAJGd7L3KMsl0uoBWUvmPEBq4=;
 b=X4snPDUqbnNDHQyw8ZjzH/CNrpdC68LOEZEFAl4+8MuM3hJWttbsjdbp1p4hqXyedGepyzE2PvCIHl+62EGOpbBIR65vM3XUBMWkKipKgX9ORNwnld/PzPBofFUuxu7+VWU7cfdo1O/NNq5dru2ncsSjcg3bMszt7/6GfufWUQMPJ/rFLAgOCZywvFYQfcd1CIk+f3UDS1f28Lr/OtTdye19HQ78AjyhU/LavcOtuAWoUFxgf4iilgS+IAivEI5xkNpeQEBFeuFtVrfvHbKoooDSNS56fvipOKZptSviVQ1kC68nbz5LtYrZ36RaS3115gcJq24ZKo4Vo4FVVcbmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4P73mdr+dAPRMX472EdAJGd7L3KMsl0uoBWUvmPEBq4=;
 b=bVX8rf2LqXjVoKTlIGdeHSwa9DgbTIGJHY3de/0JFptIP41gZ/rks8BfzITM9vgMTnsdPUo7S1ift1IoniEwo8REyrVGvmRVE8OF92Zp1fP+IQ74bYNK29g4WKScMyvtDeMu3B1QSjil0O036Z/MVJr5RFbPcau7uzCsrWhIa9k=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:33:42 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1e) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Tue, 4
 Nov 2025 17:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:33:41 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 4 Nov 2025 09:33:41 -0800
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Ahmad Rehman <Ahmad.Rehman@amd.com>
Subject: [PATCH] amdkfd: Do nto wait for queue op response during reset
Date: Tue, 4 Nov 2025 12:33:25 -0500
Message-ID: <20251104173325.1381513-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a75a374-503e-4bc7-9ad3-08de1bc84bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TtG/B49XJ3CU1YAf2UqoCHc7gILVmV2HSAx9oug9UJeYXJ6XPCe7GZaSZ006?=
 =?us-ascii?Q?oNqrJoS+HQyCivTPvVlSQDvEJJYpQaTpr2wYkxxaGHPu3nanDjsuVTHfFD8N?=
 =?us-ascii?Q?b4RKwZE8n4B44fDMo2ySjKrBcrJ6kcCdGx7odj2hpb6VO43trCxm71S3VSMN?=
 =?us-ascii?Q?bXJChoIgpUIug57/2bzrrsZeiruDAOwW4cyy1YbjYvMNYljaSN4jow5jlD2C?=
 =?us-ascii?Q?tG80VogvnOGScw/AzGGaQTRgZSrfBTi9ZHXu644OV3ZZEyJ+ZLkV9VNuZtf8?=
 =?us-ascii?Q?lfh2GVGW9S2rYNh21FuAUUY0xEB38ISSNyZmg/UelqEIlCMN2IS/QaKTT7Pt?=
 =?us-ascii?Q?y6J9ZlRrQf/wD4XZ41u9Zmp67twGqnZsneTDrVQDqv7NQoN39yIAks56zaz2?=
 =?us-ascii?Q?UZ77QKcl4qoEvvU8mhDajsMsc/OeXYXfKkVmoL3Gkv9wiZNf26Bwf+kiNzco?=
 =?us-ascii?Q?JavWaGluIZNjiTQTRZ5cksGST7tb8wkFmssrhMCyqiSM+dCCXEmYTJlLoK4Q?=
 =?us-ascii?Q?msGGyBmH2udsxFnyWKWIeIR8Lq/LdWBTZ9z5locTWrvXtjcrQkO7hB1/sDKC?=
 =?us-ascii?Q?1iHo6dXdCTc+PRD9bBnz95agMpXkLM588hmpH8TGrKw/qnr4ATXeXlh784Kx?=
 =?us-ascii?Q?bVR5xYg7+Ou63GDuDRlWDerwhgldDrUQjDPsEY0kE8Dft/zxRAaYi21WpcZO?=
 =?us-ascii?Q?r6yuI1T0e7nF8R705D4s0BxTIGRefZyqbLZqgcZ6zhL4Ze3Isyr4SJCMyPv0?=
 =?us-ascii?Q?j5Qs1qEUvTZywX+qnuqQbeKcRPjArIGX2prLq6ISbXjotVlrxH2E9SE6De2H?=
 =?us-ascii?Q?trU4oWBUnn+Dk3ggnUEzC3pyhnsHkLoN3pK+kpXkIoIEM8blDEuqUX1qHQpT?=
 =?us-ascii?Q?NCfIf9hpB5MVE/WHBA47MwUxOIrQIjI+rx9bsJn9p14FbLNJ0pqDDOgLBCf0?=
 =?us-ascii?Q?2nodzvtdiSLMUHvSQpKee/+yONMs5Y4Mh8erPiZ3XRv7AcW3OXEcUuICdG6J?=
 =?us-ascii?Q?ppDjwjaT/monpBIiiGWNSd1KOMJkSbdG4KwVhVx32RBtvkyol2XRiYNGhMY7?=
 =?us-ascii?Q?DwcsTHZ3GwUmsps11BN+FsTbriz3Bd2IcX982vf1ibnaR0vi0kB8s8oWiY/s?=
 =?us-ascii?Q?RlM4g7rrwYAAdaKPvwWsDtWOlVd/sOPkhr1a3QWZKokN/T0MDNRPxHy4demw?=
 =?us-ascii?Q?yOSY1ibmTX9rZHFR9KGYwkSlT/T9YniPiF9xg4My00s+9i1HEodh2aolfMIn?=
 =?us-ascii?Q?wjgQsvUZp4B5AE//p/9Qf6gHRqIoBv2QHngx0jMOemksHXVXNsMVVC5rY+yS?=
 =?us-ascii?Q?7JpIMqj32MwUyA3jGKhaon3jY4sZM9YLWCIPWJ1ZPlKuvxLef7f7C5zE3k4C?=
 =?us-ascii?Q?pj1qaD8UXhl51/9ioyf4YAqX63P1qqb0K/Uv+UENOgIN2VnA2pBZYepGgdah?=
 =?us-ascii?Q?JKK43iRWUd3mevhFISj7JF/surGeMUqg9iy6qP9xwe1ErWf96SDXDOdM+E03?=
 =?us-ascii?Q?18JyInmzohVOSYJwH63w82iH+639IOzZJ+fCfmbGaEbcreMdWgV8KxLrBUsg?=
 =?us-ascii?Q?LknxbIfsaePW40T9n+Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:33:41.4138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a75a374-503e-4bc7-9ad3-08de1bc84bfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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

This patch adds the condition to not wait for
the queue response for unmap, if the gpu is in reset.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4fbe865ff279..0904c36192c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2094,7 +2094,8 @@ int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
 
 	while (*fence_addr != fence_value) {
 		/* Fatal err detected, this response won't come */
-		if (amdgpu_amdkfd_is_fed(dqm->dev->adev))
+		if (amdgpu_amdkfd_is_fed(dqm->dev->adev) ||
+				amdgpu_in_reset(dqm->dev->adev))
 			return -EIO;
 
 		if (time_after(jiffies, end_jiffies)) {
-- 
2.34.1

