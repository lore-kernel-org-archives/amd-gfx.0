Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8891BFCB61C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEE610ED62;
	Fri,  6 Mar 2026 15:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCm1zTfc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0259910ED65
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZLzi++uu9IwNttX6ZYQqdKmCDNsJJ9dQWbS1XNnIx996TjFjcsNOH66QrSuldtXCrFUJs3jWOn2lqnHwUPKzY3KPLaqUtJDRRrddXe6qJQ1oVz4I7wJDHibnXE/P19I7AIIQIvFC9+0XsYZ0kbiVLaS7o6fcshacJ6YJ+G0sIPnecmEdeaoSpaH9DFv6GivyCmqrRb9rod5W4ZzSGNwo1ukrrU64Qozh9kbXrDEGrqHux+ZzE1cRYHMkWQozmObgK2BZp+n+Tv6LNPzEpxaZy5URsz7aCsu0SEgHeSzGQZ4VcyzQblXKicYx8yzyc9tqjpLv5PhDcKR+FhMB2dJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/0Jtc7q269i3N+kD857i6/fDjnVHvcd9FA2f3nbR98=;
 b=WsbCECmofoIYYeHqtYlC5RyMYM232KvRZwLEAGH/6XkTFQC8T6bobJL9lYE2ZSqx9BLTGUK/0JTa1ydqqWuQ1MrG0g+jOEw7mAhJKsuxQacHowiY1NTnd7JftGLsNfRlnALSdIRX7eNsrjvH/7XNqsggPgCiLhUrW8F5DPAUwbZpU5iESbw5J8cCKAQ6gXpQO7I1Di5MBDs89/XNhV0keow4+eKKDfbn881bY6pf/HtSzb8GTL6Vz+bOO8rP42c3GhXW/1oVrJGd7ze3EQ/1DeZzzVyPdMI956tj8w2rZfmL1aqnB0zKUjsKXFmtrA8RHHn+2Wn5X4GhnAvuDchP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/0Jtc7q269i3N+kD857i6/fDjnVHvcd9FA2f3nbR98=;
 b=hCm1zTfc494xeY48AISdQpzVr93733YLFdRBb4RUTRKfzzokBR6nGYrANb8ZZOO9+2M+efkyZTP9/dTIudswiLTWYpP0XsZC3EYRkbX4uiRuSICHPJB4roK8tWA29R+Ib+4YYsFnzKjrVFIhu/n7StPibFCjMoazGmQ/ZAw8UYY=
Received: from IA4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::8)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:40:30 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::b3) by IA4P220CA0004.outlook.office365.com
 (2603:10b6:208:558::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Fri,
 6 Mar 2026 15:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:27 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 07:40:27 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix sysfs ip base addr with 64bit
Date: Fri, 6 Mar 2026 10:40:11 -0500
Message-ID: <20260306154012.22525-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 38716bb2-5e77-45dd-4056-08de7b96b26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: mRTpV1ZWP7VL3Kq5q2J89HflmqvEVdzIk/GWo6OrT3KLqBeO8MXY6uW3X+OfaVWQ/RQE5vtSA0JEDFZGa3AlLV/rqv+ya1VA1hVPUhzRf7fHnODuMlYHp9jsq/MMKmRomX4t2EWlsYY2I+2aknfMuf1lIxAky+8+ZYjPxwuzjnxar05lAPM7NaPP+lRJOtdXgk4E8qNWyt1CfbIb6LMBPA3UlsIPiTmDISdaPfgoErjUGB6PBqEkyR8E82cm8vjUNoi+Yu+HinP3hWmBYOXeSxP0luHZdFT9WHon3g5gjds22/qc0qbeSK0kZwm0NprXqogaXhB9hN5CZhZTo5bCcfpOjdqkwcs2BwgQHt6ZpkH+JLiQ9XOSfvoqoM5t6MCUcia9g1ys/qbe9vMpu0jOcAVcedVVeaIBlpB6p9v+IZHegsfwBqlLBOmade9fWeryUA31QVYcb/+ufuLoIeo8VeL1J5RiELsqEm6wM68KPignaGpZ1Z7o4aumnsqrsRVu9Door4FC2AGkvP/Na+PYDCJykno0HYgHSF9hE8pmFtpcR+HKZZGsH7GE3Ak9racWoU8W50RLe0riYAuiV2fS8X3vSWXz49qF6mzDmOqstC35Qpg6YZjQPNv3Av8AELIjj/0HHNIMa/rv7gmg8JBlKFvWpkVkwmqydD6nmXWbEnr/XOBo2t0NdXd/y9QU8fbg8W6elldtlnw4lQQtEJDnFeB2bqAnQw5KVW5Y2J5cnJcmMNUWeO72hqrzFhjrnlncFUi36lcSB/AjCrRpFz8Reg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nkapJ+NlrTfqyo+J5JEFvR9ya3J9yxaDCqs+L6E3lazhuqMVFteDxLnpL+7uRoZ7vgKBk9OA8YeAQQgCcUf4m9Q7U+Mm5JncP94tiFGMSwfrOjh+3R42qGMBjof/tRPQ5YOnkcsuabMl3eGYf+fmjM7paXYuI7cn+0zA2cUP/9TKfqR489CQ+Gp08pm/7yHEU1VpDFMAvKvnH6D+1iQHzrCUxa8nNc/mSVRVwkWUtKqEy2sg4iHvv0Rz9jjmhmk0oTRSEryCxPtbGdIcaGeKoBFuO8FzK2+X5vxAZ3MXkTQGW9ID0L4ta2d2eWCTb95uF2mOGxES7ipHHrC6QDaHEIhgEojlhe6SoRCaLyCT3AitL3/XS1ndME+rkSKX5UoFtgRLMg4yM/dV3SOrjF2iNtGC8G0kOPtDPdHKZKfePaGdmO2371oCwOW4BzW3r1ly
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:30.1712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38716bb2-5e77-45dd-4056-08de7b96b26f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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

From: Likun Gao <Likun.Gao@amd.com>

Correct the base addr value shown on sysfs with ignore reg_base_64,
since the base_addr value have been over write when discovery_init.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3a03e024ba443..6f9e2b9d80da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1216,13 +1216,8 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 					ip_hw_instance->num_instance);
 			ip_hw_instance->num_base_addresses = ip->num_base_address;
 
-			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++) {
-				if (reg_base_64)
-					ip_hw_instance->base_addr[kk] =
-						lower_32_bits(le64_to_cpu(ip->base_address_64[kk])) & 0x3FFFFFFF;
-				else
-					ip_hw_instance->base_addr[kk] = ip->base_address[kk];
-			}
+			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
+				ip_hw_instance->base_addr[kk] = ip->base_address[kk];
 
 			kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
 			ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
-- 
2.53.0

