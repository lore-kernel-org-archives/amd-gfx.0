Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B6810BA435
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 07:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CCDE10ECB6;
	Fri, 27 Mar 2026 07:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NfOJ+Zaj";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFA710ECB6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 07:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyzsNmT70wBRAUnaFXVQ+yrGdlNTYGxmUwaUF9OVHj6q6WHZ9mDk/IJ6BHkWVKY2q2gAO4o/02jFv21mc/ZPO/Mdb+2hArw73b5Z01xZPoDS90LESLBKiRW3ZBb0TVIbPJ7givmZIEzF5jPFb/MbLN50SLiYeW618RUUxutDTExRM04DBIZ4BTyWc+lo1g/A9ByTnnHDgdpixhNaCA8ArYDaSXGzBFX0A5xO7tFJu0fkTG+SdYL6PZGFX3vbuQ+yI3NXIY6GUgDP0qmKGoWFoxIMQYEgzXxDtEL5ilHuTUxhHnIVFtUiL4Wg8FW+igP9GMS6hxzuIqV+hHtgMCHAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzmLQvYrcnpL7fbTmbxBkRWBPlw8yNqDG1QfiTETdJw=;
 b=Pgvpewt7zCWWx4TITfxgqZvfXHdJwQV/Je+JAbNdeQ88RFG/4A54Ps2IB25IifEYbbCii7yCiQMUwD7aC4NTOKyIFzf/dsD7kBNnIuBbxTNDpklp2x/IpE4DDaGYaow6rnEgShnNYIx+F4jIpqFnaQYACEpQtvqKc7EqXI7U3zaftfp5Whn/haNmuP0WYHUWtA45fMNvWcf17mKIDltxRE+kTqfpJJgP/je9rgysXqYAbLOsqPlV2jtRG6dJQelbAfNAWYdHvfgPzxKpd21o0Esfr+LGVLEIw23O1ZwL/UPmt4nQbuSZXNStnKthI2zknb6T3w5M8ZxSMYFIAJAlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzmLQvYrcnpL7fbTmbxBkRWBPlw8yNqDG1QfiTETdJw=;
 b=NfOJ+ZajRkOI0/O8exvT5i7Qjm15uYpSImYPKGMIQygf10/tgI51g38t1XjwqA2RmafA96E5940LJitjaFetsqpdzFka6OBlyhJEgeW6J9ckfj5gZNn6gB4i1JUSK3AvkPSxCDqGn333WfqiCdIlfiyRxAppsgpSgriIeGhPvKQ=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 07:52:52 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::69) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 07:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 07:52:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 02:52:50 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Use smu vram copy in SMUv15
Date: Fri, 27 Mar 2026 13:22:31 +0530
Message-ID: <20260327075231.1413092-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260327075231.1413092-1-lijo.lazar@amd.com>
References: <20260327075231.1413092-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ab104f-fce7-475c-967e-08de8bd5d974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yCiFtFkqcX1pStpxnjUuT2154ClqC6YHqghQ4+z76UDRHxr11DSfHHepi49QdP0W2veDTtWrQLgnWH2gf3M8WBQhVTAgzPPGtlte6mtnodowsThCGMRRmbQQ6AzHuJ/nZVuXGn8ObsAY9fLSZ3558iljRhwuwbcVUbsnJEvsBYYWsxFzN8PAUMP+UKHrcmCqN6zld1njgnEWHUr7GFQ9DLjEvsrj1ysByM6aEi1V0jtC7ybEy3WH9DvzjXmdCVHEhp0MfMLPzHFDwurXIliJOX/jYvuq30xrFfv9CUZIMSJ8KTP1mLgwFaFe7EHUcsQqIAoAUT6GkAiiRmT1I0yv1OJGbd5jvprsSPB2rfYVI5oWqu2EwO5+3dX5gQgf1uk5nAFrrLQbSQN+lkJ90P7RE/I7cnszFe3KZIMqfYY7vS5iqB1p3UqF0CogGEdxmgMPDo1esg//HoL++vqXZilX2nWLC/mphslE5CX0v8+QLIwusQsv14RuCt6DJyaFfduFyhqLMiWSMk1x5tMxg8AeYmhj6NhMQ93LFbiS8ea39dCZBG5DCgiwe7bcwfnnEUl2bQJ1QbV3n9TaLOZTQAkb7HqClCsrg3eVgrbhDRwH7pllHEDvxfixsU2BuBLQIUuhSc9KlddPnBuCITVOsaDc7weKGzoNlKlFE0qeG4HPw0T0JA7rUwCvyhg69zs/urLpXQac1C2V/gLHnJu9ygJia06h+0vqGTPiPTl77z64PHwn2KXN5cYMcHtpoqsQr1J44X8zKUkQfJCCOIIaNBqVrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jljsl4bkwuL2qMctuedEWEsWT9YFKKro0BRVwybdNUekftAYBMOyzgPWhKxNG1MU//1GHaeVnDlJZ5GUTPkX0hhZc5D3lt+Z8Xi/npO1ue2Si07ry/HItN/v2L6+SzcfVmfAFhd4kdMy0IuDm0G8EkWzZlhqysd0+xgrduvTY/U1N77ns5lNhkrOLt8W6F7jsBsXLgMsnDkn0GJMR/DqttwZTBq2vvTufG0ORy7EKHkxJew8qleC82opB9Z9VC2fomR6MNOZFtthHrHjGgKTsuTSPSxTk2Ock9hsFkf7GqF8kBh08s+4i/H1IdYpttxMBaDvsMPK2ahsH4aJvXuIPLee2hYQBJTchfnOonLXqGeinLqZNSwkNwxojzOxsQZ0QFZkcOg3Zx53wBQeZJLNHmYdS6PUsp3/UMWo1SsUStYTS/4tVdQ3eKSpd/c2i1A3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:52:52.5034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ab104f-fce7-475c-967e-08de8bd5d974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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

Use smu vram copy wrapper function for vram copy operations in
SMUv15.0.8

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index cc2babc6a341..1682ef1338f1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -344,7 +344,12 @@ static int smu_v15_0_8_get_metrics_table_internal(struct smu_context *smu, uint3
 		}
 
 		amdgpu_device_invalidate_hdp(smu->adev, NULL);
-		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+		ret = smu_cmn_vram_cpy(smu, smu_table->metrics_table,
+				       table->cpu_addr, table_size);
+		if (ret) {
+			mutex_unlock(&smu_table->metrics_lock);
+			return ret;
+		}
 
 		smu_table->metrics_time = jiffies;
 	}
@@ -551,9 +556,14 @@ static int smu_v15_0_8_get_system_metrics_table(struct smu_context *smu)
 	}
 
 	amdgpu_hdp_invalidate(smu->adev, NULL);
+
+	ret = smu_cmn_vram_cpy(smu, sys_table->cache.buffer,
+			       table->cpu_addr,
+			       sizeof(SystemMetricsTable_t));
+	if (ret)
+		return ret;
+
 	smu_table_cache_update_time(sys_table, jiffies);
-	memcpy(sys_table->cache.buffer, table->cpu_addr,
-	       sizeof(SystemMetricsTable_t));
 
 	return 0;
 }
@@ -988,9 +998,9 @@ static int smu_v15_0_8_get_static_metrics_table(struct smu_context *smu)
 	}
 
 	amdgpu_hdp_invalidate(smu->adev, NULL);
-	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
 
-	return 0;
+	return smu_cmn_vram_cpy(smu, smu_table->metrics_table,
+				table->cpu_addr, table_size);
 }
 
 static int smu_v15_0_8_fru_get_product_info(struct smu_context *smu,
-- 
2.49.0

