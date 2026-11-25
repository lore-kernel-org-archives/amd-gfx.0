Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E1606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GwIIvX/r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F254810F787;
	Wed, 25 Nov 2026 06:59:24 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D5710F7D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLT75G8jVCKzU7iTXSaNnNayqfxak/pHy5hW+MxKqnqLCqFUPIGmibf3oPF7wPwocN39GktXnQ9JpmLuCkiz8laOs9HJhDiXk/BpnhNwGzxHRLEj9yq4vtfL9vYpVhsvWThwyfw8dzPePRd3bpxvVnMP+eaJ1IA6AwbjZ2gX3VQzWqOGz5q2ruQcM1yCCL7T1Xmi4G8vbs5qdw8/Z0/3gspWqaHIhk5GmK0MWIHJDrghRGaBKQQn7XXkKEL/+pnIIo/5hfVomMqUKi9+yMPBC9lJYtkYzcUz81jYml70nO00sLyfpfh5awSNMbacBPoURd6ut21+R3729K+k8R+TRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHM1Z3HQFEOe1ZsYZjY0VkPavr4ertgG45FQ7ZNvhDY=;
 b=hBlwZ3MVboRA9XzBJwMtztWSGyoBCzoGO79iZ4G1LDyaaOWwGAt+lLRSm30IWiHFimnuj9VmhoQXkw2j5pxhrI8E1FaiQ59fZbU9AgwKq121i8Lz1XZ5o2qY2xr6IcZc3yWJTGzZGo5WRSNEM0c6gyp0Y/3/rFzGDHv3Qu2xZBRTEkHzJ6rHU0xuTdkLUf+42+YMWXJhDMAduKPa/h5kALnsQb7OndfdaETQX9S/GICTYij7wLf4btVoDUaO7yQ0jP6pjhJj5+6rY+jekzym/sYAlDEYUFA8P7+WuoU5Xvdb9So5AHvPDxXuNfzYcqmOG+8Wi2w0oXEeUYzPzGXqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHM1Z3HQFEOe1ZsYZjY0VkPavr4ertgG45FQ7ZNvhDY=;
 b=GwIIvX/riQZH8oVhG54FlDORVFIprbXZgfarJU+OIzM097xgt+sREU/Z05ywCyfH2uTXii571FC43V3IJBp12WgAR7CYEECjnWUkYrNY2IghZYpqr0LvuLBZY/oNnIM/2WTFxpsQQNQ8hbsVaPSW0FmGDtaNpEhNUyRst/qdiw4=
Received: from PH8PR22CA0001.namprd22.prod.outlook.com (2603:10b6:510:2d1::16)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:59:13 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::19) by PH8PR22CA0001.outlook.office365.com
 (2603:10b6:510:2d1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:59:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:59:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:59:10 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:59:02 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 26/27] drm/amd/display: [FW Promotion] Release 0.1.86.0
Date: Wed, 25 Nov 2026 14:55:15 +0800
Message-ID: <20261125065631.3889665-27-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 451b93ca-1f1b-437a-78cf-08df4ac19c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|261022105027099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JMe0+pNSezcTM8lo12Kkl1j4ZShNhhyz7CX9bW/hRETteEWCXMdQ2rHjBBFf77Djc6BHybx/M3wa7E/GP/Svazvgs2aweVMst1dPSBH3GC0JhJpuhLHYvUt2ioz6FtOZllHm+ApxN51gE9jd9t1FZTbHEqMikFqrpspJNP0Sc/1pYR5Vs604B3/aOz3/PhYM8ji58nSiZ2QH0QJv4J17FPzVnot4+E+kLmiUOVv5oCWmfxWPV5KGkmXY6HEjhhUHi/+IyK+dFEGBiuziH9JY9WpQRzVVvZmx41+sYSbkgHNwCJ86TPLTIPKCtcAwY+oJQJfXOXcvPUHgnN4A1/CGTMV+qNCl4iFaVgmNuw+koW+XtayJ0f996Hb6JudUo29qTsSAUQoF5O6Rhzf9NOgURwnj9fBnjqmAXpkPFswBxVKWre5oqQOXR8gNIy23LPDP++0t28RgLDiYZ4jrFWAvQJzenGx76+j5wYN/MJW+HjDR1CbAzRWHBeu0UJO7d1pnAK6gmOgjiPb4gqVknWTo65nbl0zvO+W6RmcI7lISfq8vcpCq3LOQxpjSvyqrRJXBf7uS5Mao26tkzjbsD+Morc7Cl2gx5GBH+knJTu6vZ3BzlzjfYffnZOTkvjAUQwqaCD1gBA3YTDeTFXeikQ7BG3/W3knFqwr4H5sxgJI+Hstcc5YNjga0rQNHV4wqXKQeJSoqdGUmbfS6mlAIDfqmSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6d3y7N9yWoMlL9iMu8KXCh8pSjdb1Tqdblp9YzGe7RaS+nUKGqPntUBfXSOU7N1TkaBjjp/Ozk5SDzXYxW7ZZg3o7MDtVFWnawfAwywfv9ThtmNd5o5zLfuadIiyBtVVx/O7bljM739+WIBqwtHUBRzMAd23QclLn3Q4M5nJNFEhaEWKDbmXtcpDRJuzLQPBkT06KLHQL6cZ5QIUhzvf2BWsWu4DCawL3p5xJpQmgXb6eHPzrvGdj/dBS/7FHjYMJPez5b51/8FJRAz+m6tmpsz6ZzwsmZXYJSCYdh5JHPCKFtS2LIGy63hU2o6sBamhj3MT4hEj/gtjAzpjYtjbGxkP3Z7oUvMZ+zrIrto3IviVEegrXcAHuiK9fccHXdmbbtM0aBeM1jqYBLKeLLthf6+raGgcSaB77qs+VGJjLd/LZK4xJdq+hehIGCpUUdTz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:59:12.3026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 451b93ca-1f1b-437a-78cf-08df4ac19c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

Updated DMUB interface
- Add the maximum LSDMA bandwidth parameter to the DCN6 bounding-box data

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8a0ef22e7e82..36c75c6a0764 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -444,6 +444,7 @@ struct dmub_soc_bb_params {
 	uint32_t fams2_lock_timeout_us;
 	uint32_t fams2_recovery_timeout_us;
 	uint32_t fams2_flip_programming_delay_us;
+	uint32_t max_lsdma_bandwidth_kbps;
 };
 #pragma pack(pop)
 
-- 
2.43.0

