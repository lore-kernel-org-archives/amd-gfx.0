Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EB606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IXTcLJMz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8342F10F96A;
	Wed, 21 Oct 2026 06:28:35 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F316D10F96F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ+PR/JDHugtXD8NVKc4mnbkW8EQ/NCkTWFx+0AcW6msojtkh3UrO089Q6DYnw3gq2rh0OXNw7iXzX1CvHBI2i6fje6r6nWZ4npdV1TYquz/4Ue7Tt/La9Ex1jrKH65LDXnO+zBTqRz8hELgu+TeU3AhryZ6ca5FZVmLFkhTahukQ1JeY2YK4xWUM8PLLzPUu0xPLm8OhoZv7uKZu1R7OI96cD62GFk6p9x3FrKldLgHrv7flNFbNxmPU3Fz+VMKVK1zgT9CewZsbfdxNd/5WqBeDB16CuLVUFF1YjB+04eN6WkpnKp6vkDztlkO/OwLFMAWk7lhmNcGvrO/4ocNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD6OMuMh31c7lKkiesOElmmeqPWkPuzUEPkQ2DzEyl0=;
 b=YfAuHIMWifGVraqsZCzvP1mQFEQVXTuFYu8k0c7d+IOAkMPM8ex1brB5ITwydlGdo6l0qNtKNOwMPaVhGYLJnntEnrqktR6lGx4HZs//AkdIH4hz4UON+XG8dtupHBTUetV3BaG1IsCPCm0q/eL8oNVjCrWKBqhDBaYrrRcslSRp404QyNUirbqbDjdnIvzKDzdMZZx5o8kTZrNkHqWrB+92XS0S2388G//nuz8Gu2xa+sK55Izg/cDIv6pz2YTXRlnKKbBPHmav5vixmz1uEyQw1oFpaatpqXXDPKVmMPuIE1lYcakAmdAxBsLI5tSDY3cDXNv4vDAZIQS10OJ9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD6OMuMh31c7lKkiesOElmmeqPWkPuzUEPkQ2DzEyl0=;
 b=IXTcLJMzhRJvgmABBdpoarO3KWy8sQIsEybRkS/vytfeMjACOLYWvrnykVez2hgmkVIZF9H1MXsPRWvu26F83MX3H8eGeCNQbTz35YJp2EL7dfMIYmjkdwmfXIK2qblYnQzTBIXrnmp8aLKm98ITykp2AcDardOlNja4K6Gt5ds=
Received: from SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 06:28:23 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::58) by SJ0PR03CA0052.outlook.office365.com
 (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:28:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:28:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:22 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:28:19 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 48/49] drm/amd/display: [FW Promotion] Release 0.1.81.0
Date: Wed, 21 Oct 2026 14:22:54 +0800
Message-ID: <20261021062519.674697-49-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bb55d5-de5d-443a-86d9-08df2f3c8220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ibop8s64SWaB00dbSsRHqlTlR4xeb+8pLQ19GrfepWK5UPzD7CVdGnlVflxv7gf5nxhnIdQCMxVwJb9e5vmiitQQwsXrJyue0gFRxeW1qZod2opoETeH+0NrnjcEWCgDdUNY3uoTY6ENc7x4Djj6PpFKIAhhcRmsIQGJLoPdDajBibqMmD4FqQZmxbIVyR0W9kGRxujoJUt6XqiCBE/S7rQ8FPgP85oTL2cxDm4bDN4+24sPFjwV+9lyP6H43n6RCwaq05W65qKPv1v0W2HgzVBLbMIxThK3AEB11fWwyHurQBpGXSO7yY0QfSPAmajoBSj8VAcfWaxU00Hqb0DHQVKKF8IICsw9LsZO7F57B7fAlFVY5JNc9nkV/BRsXzCQUF6F4zW6QUbsTts8NcGn1SiYD6IGHg9vYkSsvyjnis38UgZdWuMvsebL+ftVWOm73D2EFIkJdq11F/f6sT6FcDdfp9cHvXEtqYZst1jKP06JZJRvtnc8cXxO3HlXGJiznXEOo4IyzSVFAPSSI40S1wJtU2PtKM7mcBhU9dUXDJKfPP8gBUOwg7kWymixhCd9NPsr9k8T5dY6vP8v36K6xEhPru0EkNCcCylVLhKi6xQWR4h8ZJVUUVdviuhNLV+h9pzR5u/OLt/wqgGw+Jpni/+7/dGEfF/2wRSDUCzXMjGNnwYmnkXnmkaYMQbOKP6uKJIJYQufBaojFm5cZtrjDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 01dDSa0GhG9mySJD13hg+C7CEL7LkKHTyEHGpWRF+GgZpZrTg2Yqo2IGIyMXfbamKNziZZeh+l471vdC3gRcU3fz6e2jPCJ1polPIiuL8gh6chTyRf2awIbJUj1eRdrgVwjyebEgpqt4mCGVaLqbTcc2vMpfOa9vZnnc3uMnOZ8O2YZqFcUZxYeL3ScaXY/p++abWx/pE7JjxLF713R+VwAqgCLq6FTD3Zfiq9gdqffb+M9neL8IvMDHdKNzOAqRyAEzvGw5PMiQ6cxCcgsx1U0Z9fqotcbf+H2nqi+3FGryPIBn6kGYQ/xe2QQ6JgdYpkp6Gc3iE8GaJ3LVihjY1A4+jeBWTtJIxBnSw4SEns/D0Wc4gGT2VLzth6KlVI3UpMoMd3a0l+NlEjziBHe00D85GqOPYZBZPDExgoCVnwrt94udmWAww4sFEE8PEp4O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:28:23.6329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bb55d5-de5d-443a-86d9-08df2f3c8220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

Updated DMUB interface
- Add disabled pipe mask and per-pipe viewports to FAMS2 alternate
  stream dynamic state
- Add frame update interval to replay copy settings

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1df67376cca8..27723ccec6ac 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2625,7 +2625,8 @@ struct dmub_fams2_alternate_stream_dynamic_state {
 	uint16_t vstartup_line;
 	uint16_t vready_line;
 	uint8_t cursor_size[3]; //  Cursor array per plane for now - if we assume a single cursor, then we don't need an array
-	uint8_t pad; // to maintain alignment for below fields - re-arrange structure once all fields are finalized
+	uint8_t disabled_pipe_mask; // bitmask of pipes with RECOUT_HEIGHT == 0 (disabled)
+	struct plane_pipe_rect pipe_viewports[4];
 	/* outputs: */
 	uint16_t subvp_start_line_a[3];
 	uint16_t subvp_height_a[3];
@@ -4804,6 +4805,14 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * @pad: Align structure to 4 byte boundary.
 	 */
 	uint8_t pad[1];
+	/**
+	 * @frame_update_interval: Frame update interval; 0 disabled.
+	 */
+	uint16_t frame_update_interval;
+	/**
+	 * @pad2: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad2[2];
 };
 
 
-- 
2.43.0

