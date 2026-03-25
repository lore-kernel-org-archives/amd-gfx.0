Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB02FEA819
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA03910E7B5;
	Wed, 25 Mar 2026 07:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Cs6D5XW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D0710E7B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awt3XPRFg5kPq9o5dpN+TrcNAEhXLT4a79zG6f6X1wryRgXccs7F7vpDtjp5raLHz+b6HeDZFKXZHD7xaQBD5Pe/Xq5Us+ZdZNf5kBWlgM2dWpa1RdVNjIiVbRaRi8yXbMiB6KH+Z4zb57ZkFawwuuFFstEMuB3v+FIEK+pN/4RvAdhs4/3vIt45o8csQYHDP/o80PkHS1AeFlB1KIfZgzGQBlkskZAfK59NUpKEe+iKK1QQv3QfSixaMqsk9TrylJDtMHwhoBpXx0xOJgTJVj0bA1npXWU/ulEX6o2FhYWDa5kgzVC1F/PJYSZ4mA2Jz3/dV1r1dZ7arnt+hVXgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zgo32S+NurOSwu27us7iKAM/h0uKlNe9+XJxCf8vb+4=;
 b=UMnC229wwjlRBNK3Aia8Ewc9zCjWlLyCVhHynhdxYwwmhO/0MBmIUu3CVjEr9g/bY9Tmrs16NRlRUkA/PrqM9WlA4kDkS32rwdEo6E+OFjUYZ6Lz8mMkDJkkoR222sy9n1FQmDDAcYNC/cYj02n7jTYiTqG5k3RdryI+Qgf4Mld8ovu4gaGmNedIKbweOCfE+rIMIPz2aVyzGYZVQLKkCk7/brCCntNI9o9/v9sHKlAnhHf5XHw2XsKQ/lLwdHgxyyZhCQ0Swc95QnzIVkuaxw4x7D5e6e458DISdZj50wSULQ/UXPTkAMGGjD1zvAhn3OmpM2LamXMMqO4gjeZukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zgo32S+NurOSwu27us7iKAM/h0uKlNe9+XJxCf8vb+4=;
 b=4Cs6D5XWpVKguPyMXPu4WaGJp/kaAIMOx53YPvPzFkGi/wufLmGOPtJuUa0EnS1LMe/SbRTk7BaXG8NYM0P2+0QTWKRL0kirLjFgSAO6h7a+jbqEwQJhLKXEQd+eFNNQ95LLmAjtlhTCwSyVoBRIYRm9X6BkUDapjkE9fnRAGdE=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:10:55 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::4a) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:10:55 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:10:52 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 28/29] drm/amd/display: [FW Promotion] Release 0.1.53.0
Date: Wed, 25 Mar 2026 15:06:34 +0800
Message-ID: <20260325071003.4022594-29-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3bdb07-5e4c-4816-503b-08de8a3da88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 34WWXri+ZR0386SXEw5oREadG5NNZjGog4Za68oRAqLHvRnCZ7tPX9HvYBycDzhHIPVXAJlk+7M2OqIysyfaCbWOtl8/HRXUrqV+OJQTz4Am73Wvfw0DF6uy76Kd/QAaitxbBHUM98Mftm6PgXNSTmyB7gC2uYjkDCripD0TTbdcyXngmzMgo0I32vu783WwiA4s/mL7+rWQFCKOmfmsGAGmgme/oiUHuLznYLfGN3Uf9z//oYav9T3h4DmJ/LS1Otg//PmshG5uOzdkC+1dsBKHm8JjFKETTVhk7+ufk2eww9RL62vFv/VYojiBHELmY/3aiapRxs4ods6oV4/0gJ4j0UNJeaiUoontJLPjNFGRUIfL77LRhFTWw4PjYWFGtBNFdtE8RBTR6J3bBmfwhu5Ax+Q1xgy7m12V6XLGfocd1RyMH1V6l9c34z+E6liit9HfyJ6rNrUdtsh0EXfLGSqLJJpRTRbSnpTu8SLC1dfuE8IxWq5ml8WxA+xNC7DUx4WlaC4/fMpYTAHTgHaK8FDrAjnW7HRk82udAqqH6gB2lb1ya/d+P/axfA7zazLX+6l2WwG4M/pGef5xVjzhMgWaFIRFKXHQpkRuOtjEKh7LmsjEp8nJdDSYrq0MKL/j6ZvlKHUyv+kkoI1Cb5DScVRrDQn0k0w7f0xSaI6qwWINrgIbcpQqWN0uhxqXyUIwU4F+2DnAqlhf5IPnIo6CchhbbFgcaFoNWCU5APAL5jqhexyengWFvzwAvTWiRG1XadC71uJ2dQzbXqr6uYyP1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ESQZJnZunzCDvTWibBPEDvvcv/XgyS4aEodU+Ikc1pd4UaRRhbxGrKhoqzYqeBffDHqGmB0qMhM4bnuMNYNXx7SUdYSWXREFybKvLyUjGQihlVqBiCKimvQXPl4mMjgSJJrruK1J2Gb0K91e2MptMQuJeegj75FNQrn95ud1d9+kP/+l2tvTTbElrXwKj0AI8nLN1JE0kqnIorb4IgqkyEWE21LEuk1is1L/r4GDTRWqUGI1UsngHmuXCO6t2pn4c4quyIx9AiYQPyAsKdZ6dlu9FDlqTMq4/UbaZR0SMTkGvwbzvGKL233Q7qCF2jMfFBdcpfxazaaH0dhB/tQjAMGYjLH0/Kf323SnULfQcI7sm334jWQEUk/VjFkYmA82dW1Z6PBFHT7AUGVdx4bVb+KqEJYLHeZ5FRqf0xPUeJ7uSKGk74ylZnDIQLZt44se
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:10:55.8236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3bdb07-5e4c-4816-503b-08de8a3da88c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
dmu: Parse freesync mccs vcp code

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8fbd179a4c87..fe9431cea3e5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -6272,6 +6272,7 @@ struct dmub_cmd_edid_cea_amd_vsdb {
 	uint16_t amd_vsdb_version;	/**< AMD VSDB version */
 	uint16_t min_frame_rate;	/**< Maximum frame rate */
 	uint16_t max_frame_rate;	/**< Minimum frame rate */
+	uint8_t freesync_mccs_vcp_code; /**< Freesync MCCS VCP code */
 };
 
 /**
-- 
2.43.0

