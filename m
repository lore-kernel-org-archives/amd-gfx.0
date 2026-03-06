Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41293FCB619
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FB410E025;
	Fri,  6 Mar 2026 15:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2gn17hPf";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C6B10E025
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J//Lno4YGh7686jOyrAlBKC4zm7w7g6kFwNrlpbVZt07kX5Wi0o0oS5Cg3IKq0H6lAxGdnE1jCP0sJghV9zaS8xGYwfDWiTR/hAetqAkpZs809dp2ACkFOmB+HJUaunMfhDBwOtvcI572KZ68cQ7ErhhiMuYO59AnXBj0qWT6IjzGGkMWnUWhbWD241O/zknmuAfBgvkDpyhpgZSbQPm+2gCAj1rn9Q3ieXTX64vRYTLSOdw0+iaYHnPKMAh+9KOdR6ELqlXyhXwU1fLiT0n1DIwMMK3Qka/bhkv3lpE26tSrQHBXL6MRDyGrmr5DvpiYwaFZh3Q53x+1PFeuFfkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kfLHDCMx6VLs+5L5LHJa+lO9DKxqQfhmZB+z4sVyTQ=;
 b=NBmeE8th3pVj3fFgmzkDN12V+FtSv/E+lkPPiD07fhrInVQ6pgKNaJrU/OyvCcFbR86zgxkctCVPrKaA87yMb+eL4LxVSDNiiyhoc6NqWtnDAdwene0Dq+U207KVzNkDrl88RlwVSkowd0PsBgU+JigNKgknONEXaR1tFDv1oMofZ5IYPaAor6o+S+IeBx4yvl7CdYEHK7KIv5Xtjt9rlRFAkDX5sn+GnyyugLqKnWbCmWymt+LruBsDV8O+eCdXBanYimwzjTXvXRkMwhVtJ3iwqSLmDDEuLJJ+HCbAh2xbnddzitSjzkvMTQ646f9WHmrDTJ27iwrrqD6yV0pg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kfLHDCMx6VLs+5L5LHJa+lO9DKxqQfhmZB+z4sVyTQ=;
 b=2gn17hPfUFrc/3lzgdOV+xKY6r/KzrlfCiW+FDeRqAhCBPBA5LR9rXFTeZkfNplM9Fi1AypOcJ169mzkASoGUs7sIlYZGV2GV5s3/UdAdJjGA+rB4QFt1KUVdtZDcPvdlYXiv5GYDAwCWyg8Pm4Rbglg4Z9ws64j/dwO6LYdMlo=
Received: from BY3PR05CA0018.namprd05.prod.outlook.com (2603:10b6:a03:254::23)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:30:29 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::e) by BY3PR05CA0018.outlook.office365.com
 (2603:10b6:a03:254::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:30:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:30:28 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 07:30:28 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:30:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
Date: Fri, 6 Mar 2026 10:30:19 -0500
Message-ID: <20260306153019.21556-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bcb0cd-f1ab-47bf-a90d-08de7b954c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: Qacpa8gkJTQ5re+BrnmIAMlcyK7l/o2Jixo2d9VaVE3VYZcaYmeH+WtuVayr0djgaZGBmqq2m9NPbxmtGrCKB8BsBwa12FLxIA38R+/iXCurvfHZYuX0hA61c8AY8S2KepZHc4MMFx7tCrrXjcPdWs2E/dHdjIVcAQfo5/GyZA4Va1vQmaP3gEFGe4RnP4NqJkhsN6ythaIz2iLujNwFzMM6Exic1j2dp1LMon5ds5rvdfIKeaXZhQUWFlQlwijw/rGMZ6h9d1AUIu4kP5X7Xq9WEuFSITv7nBVcXCC79Y/4P3U24mkasX0sSODG5zQkLETeO9ejDHiMXqpWgdAXS0mssoIUzfBUMUZ8zQmGB997I89UuLy5wXZRygH9ZnSHj3Qj9HvkcAxTE9h6yFNp5n+NN7I1JzJagGnoLYGYWcUGf6+KlSVX+TBZoFUavSig53dYjLHqzdVkVSVVX4jZLMSadADuXn/CswivgJKvM7G1R/egEo5hZdyTe5mkwihbFHGthUCURI9CEC4sWeJlu+6mMMQdiUoUaljyLPVwx1/478ajL57tzQqjfEtoG3ll5HmXO5eYiO8nSRE/nU0S8fJGIZo8M04qjZfB6A3TeowysXowoR7dV5EgRynjRigkqFTILZxsm0m+7mNtgn6NrQ7FtRIJbH/XTGUEdJcLQ7sbjyGzItjuTU6LDwjpC/QdCDlWbdUTaNYze8OeeNjY6Yo41dOgcXx6FuSKMQLloPrHWxSL58BukgiWHUj9Mc+XhVrRiuS54PVuXLEsh8t68g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JSMadKX5WAYamZxZIe8hSXJW/5pLH8Ajsi5ME/LFjhrTCj/hLAlo6DWYqHR4SOF3QvNMhWLA4xFPeexugV/9v+5szrxhMloE1naUwtXh/jZb24r6bg7ox+TqLnxwSG8UuOfeyOPCZax5mtu2374YkZGVev+OH1eVfuCaA5KUcCU97Bym782Jqa3xuGkDVvn5PKwCj+gHZSkrHgntlu8aNrMCH5QsAOnnHES0+m9nzoKnLG3N6nC59/XWGQ4NxIrf5H5+pcTevv4EW/eXyF64D7FDLgTznH0yssudr7gSv0eIVREDOaBNUxaa6qURhV95UTn21KwLT0Qx3j8IMYIPhN6afg2B36zk2Rwc5RdZbdHRg6nq1XU0rQBHFxqQUK7na2gB2LfkeqxCZTKjLgFhsqTeSRiQ7BTep47ccBXY2G7fHq5ESk17OuRX0iKoe/+Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:30:29.1224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bcb0cd-f1ab-47bf-a90d-08de7b954c3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

From: Philip Yang <Philip.Yang@amd.com>

Error handling path should unreserve bo then return failed.

Fixes: 305cd109b761 ("drm/amdkfd: Validate user queue update")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 449be58e884c0..ef334b21bd2d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -593,6 +593,7 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 					 p->queue_size)) {
 			pr_debug("ring buf 0x%llx size 0x%llx not mapped on GPU\n",
 				 p->queue_address, p->queue_size);
+			amdgpu_bo_unreserve(vm->root.bo);
 			return -EFAULT;
 		}
 
-- 
2.53.0

