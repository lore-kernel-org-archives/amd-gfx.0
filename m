Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C21C0219D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A6D10E72C;
	Wed,  5 Feb 2025 03:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hycJdjPz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A1B10E721
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3RasrfzkO6Sg2l7MQktWgYPouS38CJszgdFZy+NjjQZu+MqbKTgMUf1Q1JhIg1vydWKziZSttrssjhtC2V7CPYeoCz/GK68Ul6wBlnNK4B5HvYUgGCSxCUVNf3qP3gVLk78Q4tZ2MD3is7gWsBxOJqqX5ACfVNM3hX9NFsfAV3ZoYJRhzhQqvwAYU2mFqaX9PrYsYmM4FnE3ZwXzgG3hQ/HSVJytLnVCJzP1UwJha1KLEH1kRr2qXl4mR57b0L5VwC49DuUYTQew4ekfWyultKzJrM6/IEdYmATLk04s4GwGH52HFv4O08sLjqdtZE5sQiUyLfSzMJcwTQP4IhA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a/BZiL26zWSobVE7yCodHUSNAvjyOBQbmBIejQtag4=;
 b=RSXEUW2zeRU98JFstS2OdvdGW1tP/ClVt7gEM1yUkpz3uHsRRkstut3PMFX/IWGvtWAyvosXgotx7UaLBx33qsvgZ+PigVU9b6lhqnNuZJmMnEt/FAcPAfKYIpe85/rRZJ7Z+1PfzmWWFR8mf/qA958MD03AX/dkB6byVJgAhuaNpQ0vosMpXifDy2iixTczVFAFMviZKXEmlhFyNpq82uo5I9H8cJaT3G1b/37nRF/nd2CDsZujadvvVfFNW5Bx037wMCAbat1LW5xoDhsSCNUZlReIysTbu83AHeODGX4oPyvZC0DKLHW9qtciAeusBn1TGa8zh1OW3vI45M3UKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a/BZiL26zWSobVE7yCodHUSNAvjyOBQbmBIejQtag4=;
 b=hycJdjPz6IGT++bg76B6RzwIIAbTVnqZwKvvSFD9/5jxT2nSG9CLyqmPb5jqvHL5MJm5pB3WqNPmcukcNCB7bNgeE6wAWi8Thk/isGB8gzrjKuyDeV63gQJj5/JGhO2fwyuXg/G7P7egIfpsGlqQo+ul99Bt7AzU7kkqvzuH0DY=
Received: from CH3P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::34)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 03:10:37 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::4b) by CH3P221CA0014.outlook.office365.com
 (2603:10b6:610:1e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 03:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:10:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:10:35 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:10:31 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Zaeem Mohamed" <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, 
 "Wayne Lin" <Wayne.Lin@amd.com>, Martin Leung <martin.leung@amd.com>, Taimur
 Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 03/12] drm/amd/display: Add DCN36 BIOS command table support
Date: Wed, 5 Feb 2025 11:08:48 +0800
Message-ID: <20250205030857.2608094-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7877142f-5803-4778-4509-08dd4592a9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oNEq262Xv08qHg08FsJAhuDSq7Vtn89m1/9IafB5w+I8juaDkExaW2eZDtiQ?=
 =?us-ascii?Q?BS18AVtVpVxz7hs3QWoicWW7WoPqhXqxKXr4CZ2elvLM+hT7ZWgH0awmHSVA?=
 =?us-ascii?Q?FOYPIl8Mo+hdcdv97Y5yV5WisEJpJ7R7jeuqYB25DT5EV41XwWoh/56axi94?=
 =?us-ascii?Q?wLhieAGCum8ux95Igud5MMRjzWzNlBqo3skpqhzrOg4kFykGfljookP0IZMo?=
 =?us-ascii?Q?mtvQT9LMltWvmzxx2uHzCFlcd1dWVILY8dUGpnc8C7dFi69pNlkbX4LKWoXz?=
 =?us-ascii?Q?tR4kP6JiIlU28k5jYB7BeDyioqYy7j2NXmsVz41ej5rashfZWzCOGU4uSYkT?=
 =?us-ascii?Q?RSw8sAjvqKYDjxcXCTi7sDjGeh3eZjxxWP+n9gfHS4Qm1usiYAGQPKUobO8i?=
 =?us-ascii?Q?VYlc+qAegXMbJLjz4xGoOwiHhqOTtibAt522hdRZyYoULsLL4Emec8VkOcOa?=
 =?us-ascii?Q?xTSrTQ4kwUdLedNRywT20RhaYLU2gKnBOnfVbp4umKYn/E7d662NyZvu9AVd?=
 =?us-ascii?Q?nBWIYZ1ZQo5gnQVRuGZVpmyWZkyLeacuueSrl8MxHv7mhCECHFjZowijdzfN?=
 =?us-ascii?Q?auq+u9S6Fso2DyVa2NQk4T8v/zKHXr403s4uK+ca8OrPtr1+GPlXO16UrPeI?=
 =?us-ascii?Q?qsiZmngnwZgfp0JLbmgmgHvU3Hq0qlq9cY9pDZ3iVdHKQE5z/h0eF+ymNkvp?=
 =?us-ascii?Q?qHaV0MOksFgzae4geL9QSv0YHBQGNVnmn57ZwOkLlAFZNoUvrrk+Rvu2qA7Z?=
 =?us-ascii?Q?L56399ykoIUXj/JDER/WrdPNGgRcKpQijv7jl9l+O89Acua+Vwr01+18e3Yx?=
 =?us-ascii?Q?aSNneFXVbCP6ON2jRiYjW4JJDyK5ntnIef2LCewDbJukDEiPe1KzyyOdOUkm?=
 =?us-ascii?Q?V904HuoGfiwmfAtbuXQKKZkJ/+mBrpzNn1InmD2yJ5Es4VWyCI6GjgwY6XwT?=
 =?us-ascii?Q?U5uu6Ccd0lfdOnahf6QrhZfXu/Pt6ffzRJ3gDKJQ3f5f8ZuGhWhSqBN0JitS?=
 =?us-ascii?Q?zZEzE8eUAE2TK1/Hbg4ZYtQCsy2f+FrYl0zQdJFSB2WyHMNThQ7Dn3VqcXy/?=
 =?us-ascii?Q?1r6V9+929Q/PcmOo2YvwmMJCKh6QYUGoB6RY5JfCDl3O3LXBNZf/2gQ6dLKT?=
 =?us-ascii?Q?7SK8xtXg+Gz0ZQIEBYPAo6qIal/HLUkZTECs8M2wQRBB7z/w+GOThyEZgkFx?=
 =?us-ascii?Q?1WK8t9W1k3GDc/pcXr5u8UYtCUwchsfYBTM00qWIabeS8yXrdjYjPt9GOgpK?=
 =?us-ascii?Q?6/QGRv13FPiXUws4wo/Ln61dydQxkMuOp7LTggBILZZBorYwmF8zWykmObik?=
 =?us-ascii?Q?du5adtttncyThN+dLjV0SGIF03G9sOAe9CjLzLxasxA5SJWHzHNCpn8FjloF?=
 =?us-ascii?Q?MVfUP9pMpJ1NHpOMbkuFqkarfuOPD5dFFHEGew9xA3dIxc+tEZa6n9w+Ms+0?=
 =?us-ascii?Q?d4R7fxERazepMuWMRzi04DKnn/QQI9jLB+p+ZvWjWe39hj7AjEKVMjkL1yiP?=
 =?us-ascii?Q?7XKIVmOTP7JHKmM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:10:36.9091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7877142f-5803-4778-4509-08dd4592a9a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
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

Add case for DCN36 in command_table_helper2.c.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 73458e295103..bad4e4711b4f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -82,6 +82,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_3_21:
 	case DCN_VERSION_3_5:
 	case DCN_VERSION_3_51:
+	case DCN_VERSION_3_6:
 	case DCN_VERSION_4_01:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
-- 
2.37.3

