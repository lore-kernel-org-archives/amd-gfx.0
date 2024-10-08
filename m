Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D893CEFC56
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 20:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF8D10E5B9;
	Tue,  8 Oct 2024 20:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZKlMGWYm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A891F10E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 20:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZSUrxQVohiLuUyC+hSRV93vS9u9og2Ov629ddi4LAhazYcHS4AjZwpTCxalvzkBvmMlBv46fG2gbZo9LBjy2WXulKl5dqDuY3rxD61ejL+xjLdDyUxlRkwAP0vMgwIpRKNJqNQDGnRf5MqhQnztlteGtCf2oPCnbMPYyn5KPSeEJARJ0gTZ05e7axHwoZx5zZG4DnOMPHZAK5+L2FbVvQKDaXL4dsJ8XNCcpKApCL/UgmKB0rViyEjiy1eGS5UGJQA/yIDIMEaqUP16XN+00SQvAUm2bNdGC0Tagwq5BCsBOErlVsNA/4GOv5fsAJSnhR1sD+1S65Vgao5SAaAX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Aa1JSMZT7Djgf/a7T+XlJGNeoiTG8xBe86EphwMVPA=;
 b=eLNpOS2U/KiPozpbMVZsoMX4KI2SJs1bffpoAMTNHzCNVngweImndpVm/+dh/Yv14ZdkG2xAHiVscANM9PJk70JEfSKnpjXy89TNz3IbG63T5YyyqqhJbPfqi70jFO/T3rg8jJXzD2tg1DigslLSm1aedcAjBs/0/GsLiaaPXGsMtD9E6Zz9xQKRjVFbRd00XU2ub1UpIygtyPc7ZjQSkwsaU3A7CKku55vXka98wu82SkFWr+aaMR6CSu7VBS74bNf3t5Wa1xB73dWpqwhr726vSoJzHHiSgxZqPSRosTTiJZW9RjKApuWClZVfOojMAmE1dgT2EeHS4iW9Ae8Y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Aa1JSMZT7Djgf/a7T+XlJGNeoiTG8xBe86EphwMVPA=;
 b=ZKlMGWYmPgBEzXAlmQuUHT/kEnc2ioyo9HubqwQ91xHNVTTZRZhEJDO+aW9iJCtNwxeN4QMHH3nJ7kZHKWItCcenO0uGJvhSWZKaYhC/ApR3omEWtcdDU3HAPPt/jqmcMOdgeofHM0iMbw8IS9jCVNxyskCL3ByVpeoyKfqp7Bc=
Received: from BN9PR03CA0378.namprd03.prod.outlook.com (2603:10b6:408:f7::23)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 20:42:33 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::a9) by BN9PR03CA0378.outlook.office365.com
 (2603:10b6:408:f7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 20:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 20:42:32 +0000
Received: from mchen-linux-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 15:42:31 -0500
From: Michael Chen <michael.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <jack.xiao@amd.com>, <michael.chen@amd.com>
Subject: [PATCH] drm/amdgpu/mes: fix issue of writing to the same log buffer
 from 2 MES pipes
Date: Tue, 8 Oct 2024 16:42:08 -0400
Message-ID: <20241008204208.603265-1-michael.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 4710095b-15c7-45a4-f5e9-08dce7d9bbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?68jSVmO9ST9OqJNRHT9wb6ffGIYLkKTEZGleefR0dK4/NylN7UA4vY+i5wJk?=
 =?us-ascii?Q?3me7dPmiqUJ8WO+7gRvrxr+3Jj9lUvUbzskwQ3KGUgvWeU+9CSii1DY6YWS1?=
 =?us-ascii?Q?qUegrUWlIVGs6XhY9D1aLGlVUQ+o+1A8E0s1EZJu++m3BgB3Nz8OWAEvRPOM?=
 =?us-ascii?Q?8ad0R18JxbfNn7HJycv4VQ3PqyYwjq/gYLeuq/chUYu3M6uJLB5PXXkez8ed?=
 =?us-ascii?Q?DSQ5+anugZXwOHRgvL2H73H3wLHHlZEKYs8IMQH8qbA1HJd+AE5//tP+Cjpr?=
 =?us-ascii?Q?sdCdCbpqzhaeuFdq17jATBnAGh/YXaTZnZ1GWEvt3ImAZDiHyuGOxyTpUgIT?=
 =?us-ascii?Q?8LWoE2o474ApZSSC3LuVmg5Xtwx8ZY98KloK3eoqzOwHDXsooRC01ZOwdF2g?=
 =?us-ascii?Q?ZTNi3s2IX+cKSUsETRQVkeTWQVVO4j+2XZakVGeakGqBDidxwWWHknacxjB1?=
 =?us-ascii?Q?wQYYTOKN7fo32HLDtu5lpISpnIM+06vUfKnr+M/LiObK6kdxyEF4+1bsoKev?=
 =?us-ascii?Q?61xRcsm1Suq8viHb4Q4re/pi1VXjVchsIB7Nlf+WoTLQ1igxiimH2aNZgMuh?=
 =?us-ascii?Q?3N2x4rMyEtNDo26PGyeNlzuTAmt1s2pTCoN9KeG2VwvCosuFD19bKpVQbes9?=
 =?us-ascii?Q?KxpscHCWGGEiAM/xNIUxXRddmVcke/qFHtwEDU5u3gx0nSf7k3P03cKxfq/A?=
 =?us-ascii?Q?4zGAm0nY1tezIXLa7aMmcMaW7ssP8FUQo/u6GRAkqJpoCSOYIvuhsU8O4kzk?=
 =?us-ascii?Q?WyM8nSFJxP6iuCJvCc6b4Nrt+8aJyqzbYnlrXwhBefTtyYbhFBM+uwJryu71?=
 =?us-ascii?Q?fRLUe2VMp0/X1pAimB4wGgzgsJyn0JFMH6TwjVyl0x6BMz/EaxSHRiN2UAeb?=
 =?us-ascii?Q?gfP70EI0p2bXZNYZrB5Dd+E+pSCRUQedC4w8y2qOCrnCJuwjHZIdxm0krqhd?=
 =?us-ascii?Q?mB7WL6UxPbSksaOQBX4ER0J8m2QYYH4YaW4NmSM9SAgz+hGlSkg376gAiq2y?=
 =?us-ascii?Q?Ji3xUYOwaLKS/TucIyuzQG3MCyKrbjPSYi8cnBwyeHrwOL/1Cgl/jm/LJLcP?=
 =?us-ascii?Q?YA/IjzvMzRYrOanCHVq1K7s07tvD1qzUZbF9xzO19SyagZX3J/NlJ1adR/Xt?=
 =?us-ascii?Q?k8cvgaUo1o7nu5OB36ngJm6+5eob+Axcu1dGCvI0mp9ClQCOFsjgSC605/CF?=
 =?us-ascii?Q?sREV/n9UJd90GDEQES/+BjUMSJxVZs4uIvinVfmeJcyml5u1iz9RVNGZ/s+T?=
 =?us-ascii?Q?HVVHihqlPLpoVkgDf2091LlcfKkmpAW5W9LhWwL68PThMXUVe7aioEE5y4tb?=
 =?us-ascii?Q?f1o5IjTvvCHbPzJGm8mWFJxIpSYfxUgjfueTiWhKRbC+dDx87NIQXi+cW706?=
 =?us-ascii?Q?NUo+KRM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 20:42:32.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4710095b-15c7-45a4-f5e9-08dce7d9bbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
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

With Unified MES enabled in gfx12, need separate event log buffer for the
2 MES pipes to avoid data overwrite.

Signed-off-by: Michael Chen <michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index f50071cf95b9..3daa8862e622 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -621,7 +621,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
-		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
+		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr + pipe * AMDGPU_MES_LOG_BUFFER_SIZE;
 	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
@@ -1336,7 +1336,7 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.kiq_hw_fini = &mes_v12_0_kiq_hw_fini;
 	adev->mes.enable_legacy_queue_map = true;
 
-	adev->mes.event_log_size = AMDGPU_MES_LOG_BUFFER_SIZE;
+	adev->mes.event_log_size = adev->enable_uni_mes ? (AMDGPU_MAX_MES_PIPES * AMDGPU_MES_LOG_BUFFER_SIZE) : AMDGPU_MES_LOG_BUFFER_SIZE;
 
 	r = amdgpu_mes_init(adev);
 	if (r)
-- 
2.34.1

