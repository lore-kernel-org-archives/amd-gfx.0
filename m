Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B458810BA432
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 07:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AD210E0FC;
	Fri, 27 Mar 2026 07:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S8n3Nnfu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013068.outbound.protection.outlook.com
 [40.93.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B983E10E0FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 07:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCy0qO1FRjwJMvj0MkJ+7SsR3G9+C2GN1F9+/PoUw0SggQ9WCE4YtJXtj7Rc9vc7kwGIa4sIh5U0pROftTqi8fYxQOo8nx4gWnqYPDn87Rm+XSVlBvl2vkkGL0ND/NpNEloCNdd6siIV0AMF69tXueQbaXZ8/EcLjce145t7IDTuQFRcCgPJFG9l8j5xrFlyyERkdswqZ8TecQLZ/zqp7g0jNtejYysf6vvhcNM5DafpWww4o9mzpbajGN4ZLo0Lpby58+SrVTzroDpU3PAk7PkNdOPoC5wyPMwGxifJKscV2dbnZ6TzH1Uv/lzEC4OJNZfLo2eAv+Z5lSDVcq2P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zo8u/Yd7xOYlem3KxsHBbrfnoAFQ5OZo60kpipuD78=;
 b=AFPyoZ0ZZFNJtN/gO2ehvzIMF4sNnsULY0Kj6NISSdFS1sWI0cMOf3RkBdCtmTG6cjyROXFsjRqXTG/Wkwe+Bd6xzDD+jZ1wluhlc8GMlWPL6oQalxcA9exEmq0ktRHWFwWWybo0bPjk1fVsr/iLomzVglaJHVH4CDbyxp/2k8q2OVOlZNryWsjWLPX2pjUGzKWiBNpfKr76g3MPA2NFxPd4hwyzGQxbgIvkz89ycdzt92ELx/3Yd7sMyxFyOq7Q24u+WNK6MCIyPiLV4qSmVSBe+1osd5S0mxul1EOG4Js0rJei+hPPmnSOLDbEVWzRYHRe0oQ3lYsZ1kYuLvbC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zo8u/Yd7xOYlem3KxsHBbrfnoAFQ5OZo60kpipuD78=;
 b=S8n3NnfuDVC+ih/xG1oMen04DH3cTUu0PyZECoMF/FCzEeV29tKep6iAAapaVx6E0QowoSueVyvVvjizTcNkN5+HEtl95ejpAZ0Q4rNnJwzakUCII4joHyCjI4eQxPeaR+x/wxJIEyEL+eII81IHinj5FzrQMA6JQHbWfbfKp8s=
Received: from DSSP220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::8) by
 CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 07:52:50 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::dd) by DSSP220CA0013.outlook.office365.com
 (2603:10b6:8:3d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.24 via Frontend Transport; Fri,
 27 Mar 2026 07:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 07:52:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 02:52:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Use smu vram copy in SMUv13
Date: Fri, 27 Mar 2026 13:22:30 +0530
Message-ID: <20260327075231.1413092-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 416fc931-ca96-4056-07b0-08de8bd5d86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8E7ncMLC4rYXypqDKO6Km1c5NsCyHHOWTe36euWfLoJPAUZI3DG4LEhYtxRGPN1FplnYjvC2sAro4IDY77UmXX1+VCOjJI8HghAWFhd1IERhY1RFvQMd5VeKp806q50atzJNvBkXXp8cA7ilaSolkSVYQ9kTFP7J/sYBnnQUEleLc4ih7Z9HdRpSlxlLswm1+Dm96nuQYFkU13+K5pC7KVfF/ewwIu8LFGuUVwHBgYPLWTvnoNFx/yIhCjK5ULJjwEeR9YAcGptj/yvLhy2CpCDmQndeDDedTrQuNYYaNIQ5zbnYNhsXpgYnIYmz04AfaoMINZkALqHBa1KoGX1qFIA+V76RppNY4+oQudyApHB3CalIXJSujhBqwuyhWYk84gX2fsNnx2yY0Rd/2D9XNJUDlEQT+9e3pJUPMnof/hZLqXE2U18bosjWGFyvSG+8VlhmszMbniJhcXkXuaxspsjBWbPu1v8VlSODcOEejGFUrxvJSnGrvMU9sfC2OyG/+a/NAZATwb7M0vENKv4ARTsYYhhSH7iiTQPhV5AF16qmPfQ4xj4AByDgrmIl9bVBTB8++Ky3+Gou13T3+zuHProG/kNjQT+sa5ABz2YcR0U5kKd3F+FShueJjLLXLjFXxcFgBsHYr/acn5EL0FyTDOcueflxcyI46GEncJOCpoSVy+lCH93TjMkJkeB6Jx6uLqjzGKqf69UD8skXgN2/w7wlBPJukzINZ/nQQIdx7NCfb65RpneJEr7HIb/qzS2avQNSf5CFZAvg4IwpgR5dmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0qXZ8ojEIIA6VprRFcjdsFhHx0Nu2xyB5JrrihGNh73yrWaTzEZnBKo14w435ogXUS1DlEVxVw4+C6lM0D+YiKLSoB5al55l8HhEqEEPhpERX68rNcooM7gf4WyMqDhtpo7+MHYilRAE4ljM7GLNt7KxBLRiFm8x/2rbDQ3U4OORfsInYupkR7eQWWbI7Qe3pX3wVtkb2cSCEX4WQn6FqtYaTSmbJIVHzYedFp9bPVFh3KC8LPtjrjKwS8E57ppF+SlGnJZcRcjx/02MLci0QlNwuXgMDEAZitNV/JJ9sW9fIeOeY1VwdATCGiRjQjpkLWEeuKCgr7RxQ6Nb8pw8/JdOXLdNZQqmNMWJA6yhPtS3oFpcWUIicbJoWY5/2JNGKNurKLnwvTlcuRM/NxZnBzBgozKrGpLoHqiNzGdBHdNlm77lEmNIaqdd1x/4XA4L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:52:50.7718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 416fc931-ca96-4056-07b0-08de8bd5d86d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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
SMUv13.0.6 and SMUv13.0.12.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  9 +++++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 ++++++++++++-------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 67cd186bd263..7193e3e4946a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -479,9 +479,14 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu)
 	}
 
 	amdgpu_hdp_invalidate(smu->adev, NULL);
+
+	ret = smu_cmn_vram_cpy(smu, sys_table->cache.buffer,
+			       table->cpu_addr,
+			       smu_v13_0_12_get_system_metrics_size());
+	if (ret)
+		return ret;
+
 	smu_table_cache_update_time(sys_table, jiffies);
-	memcpy(sys_table->cache.buffer, table->cpu_addr,
-	       smu_v13_0_12_get_system_metrics_size());
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a5c2509bf673..03a4a3513228 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -778,7 +778,10 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
 		}
 
 		amdgpu_hdp_invalidate(smu->adev, NULL);
-		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+		ret = smu_cmn_vram_cpy(smu, smu_table->metrics_table,
+				       table->cpu_addr, table_size);
+		if (ret)
+			return ret;
 
 		smu_table->metrics_time = jiffies;
 	}
@@ -857,9 +860,9 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 	}
 
 	amdgpu_hdp_invalidate(smu->adev, NULL);
-	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
 
-	return 0;
+	return smu_cmn_vram_cpy(smu, smu_table->metrics_table,
+				table->cpu_addr, table_size);
 }
 
 static void smu_v13_0_6_update_caps(struct smu_context *smu)
@@ -2404,13 +2407,15 @@ static int smu_v13_0_6_request_i2c_xfer(struct smu_context *smu,
 
 	table_size = smu_table->tables[SMU_TABLE_I2C_COMMANDS].size;
 
-	memcpy(table->cpu_addr, table_data, table_size);
+	ret = smu_cmn_vram_cpy(smu, table->cpu_addr, table_data, table_size);
+	if (ret)
+		return ret;
+
 	/* Flush hdp cache */
 	amdgpu_hdp_flush(adev, NULL);
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RequestI2cTransaction,
-					  NULL);
 
-	return ret;
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_RequestI2cTransaction,
+				    NULL);
 }
 
 static int smu_v13_0_6_i2c_xfer(struct i2c_adapter *i2c_adap,
-- 
2.49.0

