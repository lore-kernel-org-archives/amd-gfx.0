Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F422C77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 14:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C411110E101;
	Mon, 29 May 2023 14:56:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D506C10E101
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 14:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGIatasV5pmTSLofcFc6k+mF/2COKlZB+u8Z1SSP9iR+A8e0Y82V86DnQLdkpBH2AUe44r87Pz88fx47ipnthTAPcMbPj3/Y0fMterNBcvwoJPVDA5gJF0E4j5AaCMdHEKultjxoZjkSlpcEamHqOh+tz0RsRi6h9xk9BPpV3juirWU4s2Vdzoco/MD3Cia6QelZUJZtOifvkmpPnUHesaIFxCr3n7zxONJ9IV/gysR35ygkzgVPmFpRT66W+0DwM768qa1bvSrRwgErKh2KFI05N+IKxjCY4Od0fqaPNAQdbfRjN4ulZGCKr+0a3Ql0BvmXMB1yTGFJsGIxuMo10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geye2LYoh+SBkLfflbrNIox/HaMZT+WHKH6F2LU95Ks=;
 b=Tjvsm170S2YmAi7W2/UzzTPsalm5GzDx/H8pbmQ1qh2MTkqWXzetMl21tvAJPsIuN5pGKU/pVlQ/M0RlnQ+0x42ZcXmhLsm32Tx18BOtrGrQP5boeFvpIxP9PqAw5K9HspHmlDhLprErencMfYFJ19l2NnmXH9kUCyq0s+1QXhf/b21Np11t3X2l/xKWAbPVmj96VUHLFZna6XZAHIqrIVVEFlTggsB1HxD2FJCDioTBHZdGGDY0MjEy9dqIJdwT34bAUNxIUwYsOfI3iMKt9HK7RYFm9LhFQ4us8YIlMR89YTYP1cK0hYw7ur7+L8TgrWHnM/R5K2Ih3LRgZRHJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geye2LYoh+SBkLfflbrNIox/HaMZT+WHKH6F2LU95Ks=;
 b=aM8di/JUoQW20gCGVC6b6AGK0DfCEZmcL8feKnaYlDUws0+2YYpCrNpN4AIsDHZENyGbCzdSCSh+DuTF8HYoAatU9tTKhrTPLXRM2GIP/DOlLPRP+SYyHpRLwYSP3o5Pi6MiLY8F5sOOoyAzjv91NfIIayUkqViIztCGxydA8TM=
Received: from BN0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:408:e4::28)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 14:56:27 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::51) by BN0PR02CA0023.outlook.office365.com
 (2603:10b6:408:e4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 14:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 14:56:27 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 09:56:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing parameter desc for 'xcp_id' in
 amdgpu_amdkfd_reserve_mem_limit
Date: Mon, 29 May 2023 20:26:06 +0530
Message-ID: <20230529145606.1914552-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 888cacd7-5369-431b-1093-08db6054e149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYeEVsH3eLTIw904HRSHiVdJ+rirm/+EyCGrNiVhWB4Xs42m0mWeI0jOHG+pf79FGRA8YkvC4DALFAukZvvs0w/hv6uQWnJVutWmWBabPD97v1IJllxkvQGC7Y0l3+zi9rvIS6z1AStxMitEc+8zMqv/5E45ucjPbpSlMwxmor0lRpcJgg9HavO1EspfxRo5NNSnpWWYe+ZptyaNBi4avsC/FmYTsbHhY5e3/BLLOw5HTy/r0AnPtrY5/AKwSlP05IDNMulL+w4mshbjbi0SkNwFpGGgTHRw24ifAdT/omnAMbHlp1rkYHjvID3vlHmk7ZD0dnF5lmk2Vv6WAndcU9QKbi2yDjMmpfen6iSiHpqPFdSJpNRtrrYRelh6DzXzCDmoSUB2524JxrZSQikfSAI/kTtNX56Abn0u7uMi/voqX2GBHMzD4Yhj//jaGpW3wpM2mf4k+/CcfuDJJJb+54WlEW1AKDwl3G7CTApExwA2uoJ99WBA/B/3jVqDz0u7/ZxSz+Dp94dVvV/C8x9GP4UFLM/04mabAS2zrkODLP2s/1Wy05JPwqbWAo61U22uue1gy/6E0COP99iAAv78zDildPFWZpwUUj8eYFeV7dhJ0onwkkqGeXq5aIXZAEVNRmUGvX2Hbm9Yd3OjwYKke1MSB8VZ/3yIDsHwPSmPKwuZQrmTjxsXRbZ94RJb75/8zl5UiSpDuUwydyGbf0C1JG5MWzG8x3QhTUFblr+G+s4bgKxkx+opHOUe9sRtc5DM3hJdY9LJzrVY9hhOUX9skw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(478600001)(70586007)(70206006)(110136005)(54906003)(6636002)(4326008)(316002)(36756003)(86362001)(83380400001)(47076005)(66574015)(36860700001)(1076003)(26005)(336012)(426003)(16526019)(186003)(5660300002)(41300700001)(82310400005)(8936002)(8676002)(44832011)(2906002)(7696005)(6666004)(40480700001)(2616005)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 14:56:27.5925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888cacd7-5369-431b-1093-08db6054e149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix these warnings by adding 'xcp_id' argument.

gcc with W=1
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:160: warning: Function parameter or member 'xcp_id' not described in 'amdgpu_amdkfd_reserve_mem_limit'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index fa4057da0d7f..cd5d7a39ad0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -152,8 +152,11 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * @size: Size of buffer, in bytes, encapsulated by B0. This should be
  * equivalent to amdgpu_bo_size(BO)
  * @alloc_flag: Flag used in allocating a BO as noted above
+ * @xcp_id: xcp_id is used to get xcp from xcp manager, one xcp is
+ * managed as one compute node in driver for app
  *
- * Return: returns -ENOMEM in case of error, ZERO otherwise
+ * Return:
+ *	returns -ENOMEM in case of error, ZERO otherwise
  */
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id)
-- 
2.25.1

