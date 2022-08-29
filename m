Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6A8ECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A395110F172;
	Mon, 29 Aug 2022 21:18:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFED810EFC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2xi4GMimLRwb2RHyyWzVOBBJs9XG7lMMT5ixo1d9RJP0QmFYQ5iRRTBZzQU1bvMsKS6N+sMMRe2TRyLNo13ORBJ04m7gpeglbJ9bq/GsgR9zpFYugrgA+HutCPYNG+sREmPV+EFNgl8VQGCrA+g85KAFjea8wgglEjdzStb9rQiuZ9f7VTuJNbciMcVwGGYxldz4LsBTUT1lAPH1BfKCU0RYddFdgkr8H7N15/MsDXoK18Xqmg7LnG2OpJtwXE/pdVFfZ3kBzOy3TikJ2XRblxNNr4A2mvNu1QMvKyna89wVLjlcTn5ilTy0locO4ifgwEAePioeBV7sH9b9Dhnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAR79wxygkQ/dJlu8s1EX+W+ov5CfDlAT9di6zkcVag=;
 b=kMzeDiRV/OMknBmQKL6mxilhNNn4/gimTCwmFbm9tl3o0+HXWKLzFOsU4xtdLN0JnmfWfXvr1H6+u9o6lHhLe/P4uzm53WUN1TcYI3XvZzRc0PpWZhlPhMb2mPg1IInRzpSe4JP16kpJ/XVqp0nYEz4TiRS9Wq/UWqGMjHMtN6t4laJPFQocC/pBWZ1uDCaFpLr29IqA16WxeljloDAR6lSqNetdt1cAEtN2iYJs0/SWfJUAbWCcGs5rX6IpUmHRhz2tLCtRPvH7eDYJntR6HQrTp8ZCqjhb7WU2glzC2UXjJUxLz+4wW0VIOCZsMLtC9bdPOA0X5W2MCg5Fdc893w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAR79wxygkQ/dJlu8s1EX+W+ov5CfDlAT9di6zkcVag=;
 b=o/VZh0xD/ufpi34uufDqLFCPgcnJ5ALkwP0BEok/UbMMe7rRG8SJCsA0wta+8XjPv5WeRve9C974m7tlQ9rT4y3QbBmkJjLevPqJtYmYokUv+9bd7zBRtdITtCMyYNIITrmXAyvgWgBSQEZtn0sLcNE1LGvL6SEvX9rOyJzD9kY=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 CY4PR1201MB0261.namprd12.prod.outlook.com (2603:10b6:910:1c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 21:18:27 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::76) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 21:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:18:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:18:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdkfd: Added GFX 11.0.3 Support
Date: Mon, 29 Aug 2022 17:17:52 -0400
Message-ID: <20220829211756.1152505-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211756.1152505-1-alexander.deucher@amd.com>
References: <20220829211756.1152505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bff7a1d-d23f-40e7-6a75-08da8a0403c8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0261:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JB1gNvdWz8cNQEbewVaqPzT4GhaDe0OP0avhpWjoZdS8ZZxzIGac7NshrI7mtxWnCMDLvwI5A/bqxnWb205pn/EJ7O/c7flsXMktiBaV/zvC4ydotVqb41/mTUt6KKaFA2ISleXnzd5B91m30x3SH0tIL5+V0GVJeRXxZJ8/EUGAf2udWpcCyM8FSaCxFxzfHzQ2Y73ZeCrueZvpLTr3gfC52UgRtPs0S1AOZZK8u9e+wIJW2HI0Roe658oh+B3X65sY59sz5K53koIG6Esp1aCq8kTdwWKb8DaOuOipqEey5koyI1ZGaIDbyZ1+jqcbbcJ0vmz/NblZMyMxyhKs/uRVyaLyhBE8KhTxEOIsQLuK1eY503OL9ivmuEX6PliZfiVX8mNFMpxYXFrUWkno60sS6S2ubR3mqL0eYMnczoM7xd6LzqaNNSBRcGS0FGNXCGYphXDvYxqhYHUnocu7tpUoos+R8keuThl3tDChwzF3VeQ0nZ3e67w4BZi4VkHywiqi9e8rZ1a2rqvfyCgGvnrnYzuMbXo9nvcY0LD0LBLdkXj/KWr1J0RpN8Zpsl1PSvExbPZ/uGktSCLyhtu8Q7UAdp4IkzxenUnhxN80UAA9CrUMOsIFnWKRS2gQtuzRAJaRLFdkNWhuUecrjOjAp6MIDMu28anp4hIOcoerpmg8QDMK8msPPrU//z7or04yi4X8ZiZykLoCDGnH+TuW/LdJiohRuidyZCg8Bef/JxBUJfaqhGzfxEqfbgVL0dmuDNJ2ibKkwxdyBiN4Axr38FTrq/V8B7+JBqfx6BUaif8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(40470700004)(46966006)(7696005)(6666004)(86362001)(26005)(36756003)(16526019)(426003)(336012)(186003)(47076005)(478600001)(41300700001)(2616005)(1076003)(82310400005)(40460700003)(4326008)(70206006)(70586007)(6916009)(54906003)(316002)(82740400003)(81166007)(8676002)(356005)(8936002)(5660300002)(36860700001)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:18:27.3221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bff7a1d-d23f-40e7-6a75-08da8a0403c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 David Belanger <david.belanger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Belanger <david.belanger@amd.com>

Added missing cases for GFX 11.0.3 code in a few switch statements.

Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a5409531a2fd..24b414cff3ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1522,6 +1522,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
+		case IP_VERSION(11, 0, 3):
 			pcache_info = cache_info;
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0f163909296b..be7a0b5a2dbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -92,6 +92,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 		break;
 	default:
@@ -104,6 +105,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	switch (sdma_version) {
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
@@ -151,6 +153,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	default:
@@ -400,6 +403,11 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 110002;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 0, 3):
+			/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
+			gfx_target_version = 110001;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		default:
 			break;
 		}
-- 
2.37.1

