Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C56CFD376
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 10:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C3E10E60D;
	Tue,  2 Dec 2025 10:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sYGAed6b";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23EF010E608
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 10:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc+P5S2bw0RO2bq26ZqwcHHEyy8YsKBTwPN9Z9IzZWP1Odgaj8g/q0yrZzrYjz4+yZQKQxNHiBM8/wzupU/6y7hgNb60H0m19tbEtogx7Tsh8GwQRc7+ikAck6TnevqJIN2LbOLC250shEODgkYhlSE4ysxNTdQeS69Dl9lTU3p7Kow/QZXZCA5UzhR1dgBEoo8gjqwuRQA5bKDLrzvG+TS8Y3x+V4KNK890YxNZuLMpptyRgBbRcj4jMMBFgiIOtAjSmvJVBRlNnNWU8XWR976I7ZAGxgVpe3L0R7YP4ib9ZgvefdPTwvICZUjqyPk+e2HKFntDBm6/U14FfdGW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n2ng15sNl7W5ikUg/j9ByTcCWJUW6r52TdXQioRmCU=;
 b=ZJZfQ3VzPBoaoIHjJu0snbiHZRFqR8UXmRl4tS0WuNcLltXwsZT2dqvg8VVqc0sZQknclu/s4Uz3/mTtwtIbEg46cwf15USx2p2jnb9uoIgXHbEG42JEgZLJM1ltkzBjwP+MPDrIO+gmCVyO9HkIqgyE/6SaFXbDI5U8w7+rlkswC4QMcPIq591p3lA8RNKe++qC0EgtUd4sH0/PEZXCU4yXjW7/LIjBmezemqoDhYPw7RiO3gF4BMnx92EA+uUJ9ISoWh4MyxdwEwkQOeXTpO2Cgk61qYs3ZbHG318tA/H6IjBRpzfJp0Ypp6CBQb/cYUHH8DcxnjfrmprJ1rVHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n2ng15sNl7W5ikUg/j9ByTcCWJUW6r52TdXQioRmCU=;
 b=sYGAed6bzDeFMUHC/MvCUdodFH6sP6yKFHjTyXebwTRdZCKDYHCr2f0nsSU6uZes2NhmHxuK3gCZKnDyH8i+DNxyMLl88AZ9lxFcsQyGj8Zv79DEh6h+7IpIquuBeGktiNe9dvdvQDB/ucV/2adnYtgwZ6VCKJHr+c29sNosrjg=
Received: from BL1PR13CA0307.namprd13.prod.outlook.com (2603:10b6:208:2c1::12)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:29:03 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::e1) by BL1PR13CA0307.outlook.office365.com
 (2603:10b6:208:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 10:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 10:29:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:29:01 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 02:28:58 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 6/6] drm/amd/display: Promote DC to 3.2.362
Date: Tue, 2 Dec 2025 18:21:08 +0800
Message-ID: <20251202102437.3126523-7-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202102437.3126523-1-chen-yu.chen@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0988c1-469c-463d-7434-08de318d9d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vNGPcz9cwzVIpDkpw5HbsiXSc+MOX2DPYIZBkGuWYYhtg+dZFjwozWt2LOZb?=
 =?us-ascii?Q?a6oqmSAo960OJf+43b0IFR0PnjJ1QeicHVI4oRm0GAOxeSQLfFtUSJz9ScPy?=
 =?us-ascii?Q?lPEG/ax+mh4Y2wxa4t5RNPUMQJ/2n1l92ze3GQ+KkOh3leHSgThSx2vZvEZm?=
 =?us-ascii?Q?BhvStreIOzMadnpn6fGvZUqXSdRctjnOYrpkaQmeevxXh7fo34TuDcQdRQzl?=
 =?us-ascii?Q?LrUCraGp5Yi4q66XNi6yyUFlygk+XET/7XrEC7JLtGYUCp9u3Z1vWGtSCzN+?=
 =?us-ascii?Q?5BLEErCRrfF26oGGIpq3Ur53u5sV/UH0X47AcwSiH1oAoVwFQM1WeSQ9kEic?=
 =?us-ascii?Q?f/fNS6PuEgbxQqc4S7xu/Z7ElVYJHoc3nvkL5ArXfWzs/Zf3PajD9zCfKn9Y?=
 =?us-ascii?Q?FImenN6j6ufwarqB21NMiJGzVC/3Bly5i4W6cD1hhXQRSlzUR+1t7bTJA4YM?=
 =?us-ascii?Q?xld8XyjYvuqoneDRzoFfqwlVY3Re4CX0mrNWbO7M36VSpw4H4J61qnZpvlL8?=
 =?us-ascii?Q?m6r9T3Y/ze0Lhcn5SyuvOf0mOEZc+EXKAj8N8E1UZeykKJJIQqLsyfkCIj3q?=
 =?us-ascii?Q?Fwd876FEu4mcLOH5WqrZTIixGG6UEKMhCNTQ9v6qM8HrQ8T7kSoFVN5SiHYK?=
 =?us-ascii?Q?PSOLO7FdsUjqspEfQ6u69FuGo7lcuwuvc8dtu5UoZY18/ca59ump91SY989l?=
 =?us-ascii?Q?FE/QZPsgjSEC0OKLTA0dfuDJIxNL3JRBaRQLikgF51oMkdbd7MM2mdhrzmpT?=
 =?us-ascii?Q?dhm4B7Q0kQ4hCRTmKPPatXa1JCNB+Ti1HhFbKPIS4xzUC5VpovXpcR2dQ+Rw?=
 =?us-ascii?Q?p94gUY7IbOivqGKbqcSkoYLiTOftEQmVMgBBDY+IKyMkUy55nSp6v9IFJpwg?=
 =?us-ascii?Q?EX3Zb+DvCOy/kig6A53EvdGTrX00vhMNWEL4RuEa0qferTG61aTz0eWw2raA?=
 =?us-ascii?Q?WTRLqWt2ljN3lbs9GAuvaZIqIbyHTOy2UyncIdHKV8tR32Ox9s6JnKlxdk+g?=
 =?us-ascii?Q?yc8bJ3cxBZX/W3R2sFKpVU8hD1/Wq4W+lNtTmaSngwUi7pjjz3KmzEq/ra+L?=
 =?us-ascii?Q?jv1jWYVGqGEKpOBB+3CRRE9ZFU67ePjCdUnDEkUgCUN0Wo1yIdgzhMPaaHqF?=
 =?us-ascii?Q?mxLqhrPp5souR33z9HvSlRoP/uqc9bAqnwsdPY8YVIY5cdy7k4OWqoPIaZBL?=
 =?us-ascii?Q?xrqIWwwHRVzltLY/1eLwhr56Xq26SEIWS1rDRWAMo5RuqD5Hot/7DRnyObzh?=
 =?us-ascii?Q?jBV4iFjLwjPt6lXW00ADdIeZ1pJtiXd0skLOVDtSjEmRVyV0ViYEyFfV27UR?=
 =?us-ascii?Q?ZR4RQ0tdoy7CMWBIbMJ0sf5S7tqZ1KEV7Cn35H8vKjoophZX9uCiVBpxqLxE?=
 =?us-ascii?Q?BfbPWAvPYK1EuVKJeODyx8w3qnbYXjObelwxbjr6UYNxyPLuJtR3dQmj1n3E?=
 =?us-ascii?Q?93L3HbKgDGbtqOhX4jc3tMOBYoRzui+1ywAjcFp7J/4FD8Elti0StQ8Lhl6p?=
 =?us-ascii?Q?usXelUyYx6lQhooWcRNK+eUvCEW0a9haelB5aPlYWu4//SGBrWVcPQSErIaS?=
 =?us-ascii?Q?+axjBhQMpEfGMRNaPkc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:29:02.9596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0988c1-469c-463d-7434-08de318d9d27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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

This version brings along the following updates:

 - Defer transitions from minimal state to final state
 - Remove periodic detection callbacks from dcn35+
 - Fixes for S0i3 exit
 - Refactor dml_core_mode_support to reduce stack frame
 - Add additional info from DML for DMU

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d926bf54185b..93a60fd9a08c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.361"
+#define DC_VER "3.2.362"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

