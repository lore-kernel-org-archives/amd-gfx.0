Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675CCC25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 19:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEBD10EA32;
	Fri, 27 Oct 2023 19:06:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A49E10EA32
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 19:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQxc0kQeaWOaOj14JIaQbuE1l/BY/WmwE5WpmJW3UjcoReS0nBhTqaCGwAJ8J38TEgVW1M9g4sD2jJw4ARIKYzxZXv4ACHHhtGmvqW2ZDH2Pjj1048KQ2ULIH71hDUF0ulcvUoj+EzdCbzJIQUEjuhD9rghjv2xHuLZWVUkaevw+fRZPu7qw8Kwey4B3THwR1Cx8kAz1N3kKj4PTgN1kTjHOARfHMQjrHPNpJAV3AC9XTzGIMcz9TcDBkPyI+bXUkObOFk31aBrn0+Ul4RBRNA5sXM1lMyPS+qedKdc07P7e6w5LcR1nMRRBqK76ZVmRm9YdwJPiqxrf0HaRFI9wIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYNEcu4ZbqNWfBSxeE1fEFqWRO8sXoJq/8IPJ72SC98=;
 b=IiKBQz+kixwFRhvFmQQsLj0xIrwA9yE8daRIXh8kFp0lL/bX1lKj4P1jcqiqsQu8AAiCoFPr41mYGXsgXX56YvIAalJRvHQzLnTU2AKCsLYoRbmcoP703bfCA/auNWPKzttrPSEOoIa8FiO+LSF6Uu5/FuHH3vvTlgCHuIv4zMBBWEVWEkhWYqedQacTZrbWXTMEguliPBav4hm8eTpUBx+Uwp4tlq3WI7oHCe4ta8oPy0gf5ilGceLMdmrvnYFQzMhscw/mEhQG5MWjlJbGb3n2GIa+YcyNaOFJy4sczx1XtAYl5NTVNj28HqmQStFKYfYXr92PabEBSJ8JZ1+sZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYNEcu4ZbqNWfBSxeE1fEFqWRO8sXoJq/8IPJ72SC98=;
 b=dfOfNEcRf2iLLXUEEXNGMzZk9E4q0ZOKgvJgcErFHPxJm9nWDT8aCA4hldYIz6Kawrd0JM07VgFv4a2fxqrBhoUkrplto1QEoveqx9c6BIxeImVVkb0Ac+v2dobW7BoDAFKViekq7b7lWwwCPR1IetGaUYWxckbZUYWn0D9m+UE=
Received: from MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 19:06:01 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::17) by MN2PR16CA0041.outlook.office365.com
 (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 19:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 19:06:00 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 14:05:59 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2 2/2] drm/amdkfd: Update cache info for GFX 9.4.3
Date: Fri, 27 Oct 2023 15:04:01 -0400
Message-ID: <20231027190402.553203-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231027190402.553203-1-mukul.joshi@amd.com>
References: <20231027190402.553203-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3b9d9d-7981-44bb-0d43-08dbd71fc257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZ/XhgD+q0lKWmtTiEZMgwrrlh08ezJAsZdvCdtKSbJxkuWwRB/HPmLtqZr0EFE6U4HosKkJ4IazgpLC111l3g26M2ruMbqgeLowBf+M9D2BdOr+CViRGYIrhFnmCdJfgH4OBRLzgXGDSCyqNtuHUMmeEskyLmsRRGLOMANtpj4i2keAzYxljDIrYBWswmoR80GAdAZTeFBGGdHDmVYIGyWMDoiN8hfRw+qOvdcSBotraUu3Nx0bdpM1ZFzmCMByt9SPbwWi5mraRktVC4NA3Fdmg/S+kUbnVkC6ndb+xZUOQ1mzaZXPTWfrMn55mNtlPc2MXnyDqeh2oCZNH4DeR4KdBq7cWi14GBbT3cvS8v7ISr+5saowywskudXJKcuWHbTCptLlJWK1UD/TNv1AzlBTYoepuHCLUmp2xeT8e83H8+f2v5Rfn8XARXPUaOerFgGxDM6wG5x7U1GPoSbk0DxtuPgipHERZNrdF57GtRcjIUEArQKFIBjBxMvfaX4xskR61hVk5IN1HsysI9c4v2gVMC2bKr16htVg+UJ/6g3M2+3eIMUj9jmYZglSOeh0rlOklveY8KFTGLAyGzcOTg8PWhnoQ1dTN+TjclYrSKSi/Ms3j+a9yAtd/ED/IPsiEQuXqmfSQqL9+4vdt2Aa+lYuWtThl3kosP/rgbvtquJC746n/wtr0JuRYkDyjMvxkmusGusKw8q+QWBDqu4hLlNJdKqbGdzCAK+Yu9S9/X5boPaD1s2o/IeveVKaztq1RhF7cWPnzw5o4lENFchy4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(44832011)(40480700001)(41300700001)(4326008)(5660300002)(40460700003)(86362001)(2906002)(15650500001)(8676002)(83380400001)(6666004)(7696005)(54906003)(1076003)(82740400003)(26005)(356005)(478600001)(81166007)(16526019)(426003)(336012)(2616005)(6916009)(8936002)(316002)(36860700001)(47076005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 19:06:00.6250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3b9d9d-7981-44bb-0d43-08dbd71fc257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update cache info reporting based on compute and
memory partitioning modes.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Separate into a separate patch.
- Simplify the if condition to reduce indentation and make it
  logically more clear.

 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4e530791507e..dc7c8312e8c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1602,10 +1602,13 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 	unsigned int cu_sibling_map_mask;
 	int first_active_cu;
 	int i, j, k, xcc, start, end;
+	int num_xcc = NUM_XCC(knode->xcc_mask);
 	struct kfd_cache_properties *pcache = NULL;
+	enum amdgpu_memory_partition mode;
+	struct amdgpu_device *adev = knode->adev;
 
 	start = ffs(knode->xcc_mask) - 1;
-	end = start + NUM_XCC(knode->xcc_mask);
+	end = start + num_xcc;
 	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
@@ -1624,7 +1627,18 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		pcache->processor_id_low = cu_processor_id
 					+ (first_active_cu - 1);
 		pcache->cache_level = pcache_info[cache_type].cache_level;
-		pcache->cache_size = pcache_info[cache_type].cache_size;
+
+		if (KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 3))
+			mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+		else
+			mode = UNKNOWN_MEMORY_PARTITION_MODE;
+
+		if (pcache->cache_level == 2)
+			pcache->cache_size = pcache_info[cache_type].cache_size * num_xcc;
+		else if (mode)
+			pcache->cache_size = pcache_info[cache_type].cache_size / mode;
+		else
+			pcache->cache_size = pcache_info[cache_type].cache_size;
 
 		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
 			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
-- 
2.35.1

