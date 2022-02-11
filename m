Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68247C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 17:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A16B10EADD;
	Fri, 11 Feb 2022 17:15:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA8C10EADD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 17:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp8qEQi0CN/MHTxQRmrNACwrA9wg9X2U1yv+s8LYfB/SquTYwSDZfyqIqm78AJiyFYS1s9UHLJR3SlylTjgAds0NDm0/RGQWpf7Rycw5DJr+lQ541QkQM14VLuy9JVvmkxpVJqtXob5l1IYoUwH9XJGsZnNFpMlwItamJMg7qx40D0bYCieKCQ08fWFcbRSZiMwnmwohGwIj9h485zY5Y7MgK6+UqN/IQKWl40dBAWM6Lz/5w8Z28d1NCUG7aI326cfkJfrkvVWBNy90D/AfVdRiCmRqr4Q++wTGy+PIVpZ9oPgAKi4IhI8oU19fVLw4mTuQ/F4IWOnVVvxWMmNC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac0llfa2RreSMROI+PzBbXhsoM9NTPDkXU2py4tERWQ=;
 b=N5bxK+sBLopWj5I/Y2/pro5jzRgyvw30cHoA7gvSJycI8jQ5/D1RZeJ4L0NNc6OddfXifC/ecYL02RaQAVsN3Vw4J/AcG47dFHhgh+AW0WPRascYgrTvLzOOdq2PGzChNyyOhBqMKWQ/6/IYxlj29gHrqGeDdigcEJOr2PHwGB33z7yu2XszxfHvvEUMRlAWDEBlAYHYQlPSC3KTfUmztmK1M+vm04sjIgfF7oU0z3cca/dQ2/2m53ToAeF5kVtBabuiIvHlYhDsC/qdZDCJz1M+8POnRShNdnIwdCBxoMhLRRKrSYsIP4gDT9hHptOe7rphaSQaV1wgAoxGi+rYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac0llfa2RreSMROI+PzBbXhsoM9NTPDkXU2py4tERWQ=;
 b=lx4dnyI/BDOd53lrrT4V39IROGmjZs0FAtv3dJZk6ISW49yOoq669aWg2mofxYxx2Kn436B5SfwABTitc5Y9cUkvzmeS3YnQjlIT0yhFHMREbOfwQ/haZ5d4Abgwh/hJTC4JiKXvjya4qiWT5rgHQeysy7LcRLpEqzAlOixEVbM=
Received: from DM5PR18CA0050.namprd18.prod.outlook.com (2603:10b6:3:22::12) by
 MN2PR12MB3791.namprd12.prod.outlook.com (2603:10b6:208:167::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 17:15:42 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::71) by DM5PR18CA0050.outlook.office365.com
 (2603:10b6:3:22::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Fri, 11 Feb 2022 17:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 17:15:41 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 11:15:40 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: navi2x requires extended engines to map and
 unmap sdma queues
Date: Fri, 11 Feb 2022 12:15:29 -0500
Message-ID: <20220211171529.923453-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211171529.923453-1-jonathan.kim@amd.com>
References: <20220211171529.923453-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f724cb10-1ff7-488a-3db4-08d9ed8221a3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3791:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3791FCA5E6A970746385056685309@MN2PR12MB3791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEDikiTwleVh51M5kXnP7zCTR40LH1Qjsa3fJTQs9ajYIhYUMn553sjlrNIz45dbljAfsW/Y1pHI3HvKtr4KNVHn/a0SAt078QToLaZ+80fRcPjk0yrrqtqWfTfhypMiy7+tdguPcNjpyXCSYPnuatFbS51ooiGqERtmuRG5vVkz+OQwGV9EAiDgJkx76bphlAHeR1UBS8Zz+PqFO+xQkOVD/e6MuzMiEte2BAXiDTRVO2ZM7jlmpfVGvo3J7vY7kD4Fe1lSU/gwRsZEdSe6lFa2A0ukY/wPeprt29DyqGR+aYrTU4HTuo1mscXgKjViCEaj3ae3PRANAAETKMyOpmgek0nXXRyjb9tk3qmDSFE0pTM+fmWvkNS+l0eVC0be5sjX9i4gluoF2Vus9X0jVNtXVnBnwTfOQwxwf7HCIvatYaYE6Rn4doeAvsFFtnij52tdhSOgAJjP0yF93bKWExNd3XJzV08uloI/nBoTqKED3SdZdeQ4xdA3/Rzi4HMhZ1IM4M6nXmbmfq4pdUg6sp/nfm2qzzg212QSaqoE6BaJ/wLVOjY1uvKmvsUqdPNx8WPzHMBldIq1n2cPT27caUT8k1mIAmdrZxA9/naWXmSRPhYO2F4Z7V2Rp6Ll8JGeUvbKHHZVlRwbfVM6nuq5YeObsuh2ebM03AWhF7Wbku2Q44yDQaO0ugUdhPnHu7LT1o3o/iUoERfGuQEkGrWnOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(82310400004)(186003)(5660300002)(54906003)(316002)(1076003)(36860700001)(7696005)(47076005)(8936002)(86362001)(26005)(70206006)(16526019)(70586007)(6666004)(8676002)(4326008)(81166007)(508600001)(44832011)(6916009)(2616005)(40460700003)(426003)(336012)(2906002)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 17:15:41.4419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f724cb10-1ff7-488a-3db4-08d9ed8221a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3791
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA 5.2.x queues are required to be mapped and unmapped from the extended
engines.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index ed4f2d3c6dcc..645d42af8849 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -183,6 +183,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 {
 	struct pm4_mes_map_queues *packet;
 	bool use_static = is_static;
+	bool use_ext_eng = q->device->adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 2, 0);
 
 	packet = (struct pm4_mes_map_queues *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_map_queues));
@@ -214,7 +215,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		use_static = false; /* no static queues under SDMA */
-		if (q->properties.sdma_engine_id < 2)
+		if (q->properties.sdma_engine_id < 2 && !use_ext_eng)
 			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
 				engine_sel__mes_map_queues__sdma0_vi;
 		else {
@@ -250,6 +251,7 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			uint32_t filter_param, bool reset)
 {
 	struct pm4_mes_unmap_queues *packet;
+	bool use_ext_eng = pm->dqm->dev->adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 2, 0);
 
 	packet = (struct pm4_mes_unmap_queues *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_unmap_queues));
@@ -257,8 +259,10 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 	packet->header.u32All = pm_build_pm4_header(IT_UNMAP_QUEUES,
 					sizeof(struct pm4_mes_unmap_queues));
 
-	packet->bitfields2.extended_engine_sel =
+	packet->bitfields2.extended_engine_sel = use_ext_eng ?
+		extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
 		extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
+
 	packet->bitfields2.engine_sel =
 		engine_sel__mes_unmap_queues__compute;
 
-- 
2.25.1

