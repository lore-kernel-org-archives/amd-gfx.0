Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3093FCB619
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832B910ED65;
	Fri,  6 Mar 2026 15:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HJRvke9N";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8376E10ED64
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaPvBtCEe6Gyd3BBLu0ulHNq4TzYpSnkA8qPZN1GJWsZChvKeuYVSFTOvuFaWZZiHdzHDLatwpmgNKKJNto1j5ptvChickbtyQySk08AhSVTDW2tCCbj2uO3kXbtI48coMrGeTvgXbM48BYKa46JOTWf5Ka4+wKZH1YUAQskXsLUL8gG47S9HazfqScuZ8yWX5qaPUXPmvRYH8RyusU6mQEBfj+49n5cmeTr7hh08Fp0LEN4MnW1jR0yYOcRfB73vrLMTUlGX8lvgd+Mx//5EavJkEmkuUQ1LQAWoOViQmWSLLsVpXN7QtiLBMK9xyKZr+KruYq7XhE0C3FzI8SqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynYK9MmyDXcatVM0t/Btzi4vcnrrsyE53CpizfmtZhc=;
 b=lCpAMBCbU3iQgKkr5b4Q6UsrYYOePuhH3yvAoUu0QtYSTJeYm37c4oAJUMc9cxfsI1KeRHv7Vy66lIsXKX+3NBYZKs6pA7FNgVn6R/A5p+11YD5sFXD3xl2RLyeTn+KCTmM+EtBD+1MKgwvjJJ4XWye035wMFiKIvVHi6rPa9P7qaAusNWEefs4arlPk00Wp7tinqcCwpCDJwh6BvEhZK+LfEiUyDpQG7tqhBGnwlaW6rdwwkBwiGDnS847D8fU5nnTgk8yfWrjDzQQMzK5sKTaNDnv3UYv5Xyt4Zp8c//5e4079r5RrlhWcT/qZIGA4cGfcQVZbl6uKKavT866X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynYK9MmyDXcatVM0t/Btzi4vcnrrsyE53CpizfmtZhc=;
 b=HJRvke9NonwFPlIr+YcfMhdPEj9d2wQ4OjtZbvOx6pZgS+52rAtjIZYaQJ63EaSg51GxziJTxfKFxphXfdY3qCoGA4xWFPzZgiOYT2aMkw3wUQBbf8LuycaMxE6K8Ok+s9KVE0Y3CEYdUAo3AxMxhi0oejhqqTbP883g69oPaQA=
Received: from MN0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::8)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 15:40:23 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::c0) by MN0P221CA0011.outlook.office365.com
 (2603:10b6:208:52a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Fri,
 6 Mar 2026 15:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:23 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:23 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix shift-out-of-bounds when updating umc active
 mask
Date: Fri, 6 Mar 2026 10:40:07 -0500
Message-ID: <20260306154012.22525-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 90bc0060-156c-49c9-b646-08de7b96ae76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: hwps2TPlC1SZrlrLJ+sTFTP4gJFIEB8Pcay5JW6cRJBt9gECvezccZP/QX3BVDegcLTRhOGADN1VUn+wEgwfDQAlBFBc/Z3mRd0YB+xDRCDVDg1qDt3cpi5Un2onB87ztoKPe0r+LjZw4jG8J2v1kGrgUG1zX1BcWz6FbNzCgG/u3jeRbKon43Fvru8XF4Irc4/H6Kw0sfi+dPy0t/0m6SWo6V2FMcdHPd7dAaQAkrE1oiCO94h/Xen+0PO8iLyKcsV5ExWGPxBsw27yY+xu5zn9g5MOpLd13miz8qtIX4TB30WK6PIZ/ZJP7oVRhJt02ZlTfLd2fsa2jzlC5NHttetkG1n665eECJIvumlfwJL3qO2PqSs9bnpxAjLdcCv7CaI0opKppAR4Vp8PmQh2dkvtlIhkcQbTCbyu56cYb/akQS/RDYoOFasF86mnCRzC5c3yTK3k8KW1cvRLNqHIn2FSxipZLr69T86eM2y4OU3B3AdnZCpIvGKNDqJQqY/c5byGnao/hJBkpNJRou+NmwQugQ3Als3algo+u0fab7khWlg26UCv/i7mXrxP5Ytu/70W2XdiL7527DbbQbdGkoFPChPDuYWfLeSX9Q5K4sTEQAazGPutmSBY/A0gFnkhetZEeRhnnT8JIdsIrxNbvhMny7qINSEl0pxCtb+sfkjrUqdnO1F/dtyk1KZjD4GDfhXEhAsLNWVAkOLVDJY0LwT5ic0neMRjA7sPnTHsvsdVQh1hax/AhB0RhZdKpWLFqHK/dMLf8VT7F+jOqNW04A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JEHrRqd/OvcCMaVOE4DVxpnOt8dSiIZgsdw1+8Gsb5ilGtfJfuRQZxg9YuamQkYkovxTIFJuVxlhGAVsCRqQLe2FSuOrw9cDcFVaISFKgfCoCqklwKSL/zI7S3fmCSmcdEH+kLCLFL7/KYgV86AhfajVE3Ef9Lvcl6NedaKUX/SzPGDallbC16T84x4JKVX56WizsWu0MznGIFaZh/K0bpr3aOg6owrQkzKckYkjMfYT7npqarIChcEU1NIWh/SfcV7NUEg+BMXaJWOqU1xLP0p+jmMn1xy2fpMR2Ntnw72DxhAV17c6qZ15w7EVixpmvs6XUQGm9O/wRJtLdted8dpSmf+r/9nD8/km+/StF58ecKyx9iwK/cSee3ViLrgv4KrK8awLhuO6XGI8FIYVyDsWKBhLG0PyKz8RwXQLARW4vANHrPU8v9FjbJzyiRSw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:23.5080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bc0060-156c-49c9-b646-08de7b96ae76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

UMC node_inst_num can exceed 32, causing
(1 << node_inst_num) to shift a 32-bit int
out of bounds

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 79fc224687039..3a03e024ba443 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -793,7 +793,7 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 	struct harvest_table *harvest_info;
 	u16 offset;
 	int i;
-	uint32_t umc_harvest_config = 0;
+	u64 umc_harvest_config = 0;
 
 	if (amdgpu_discovery_get_table_info(adev, &info, HARVEST_INFO))
 		return;
@@ -850,7 +850,7 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 		}
 	}
 
-	adev->umc.active_mask = ((1 << adev->umc.node_inst_num) - 1) &
+	adev->umc.active_mask = ((1ULL << adev->umc.node_inst_num) - 1ULL) &
 				~umc_harvest_config;
 }
 
-- 
2.53.0

