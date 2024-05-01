Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4970BC10F1A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B551130C9;
	Wed,  1 May 2024 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n4P+4QdW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A361130C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnyishwiQ4V2uueWR331hR+1QxMy8zdjXMbHTzQ0h+q3ONN1+5Q2aArpNSeSg8dlq9lJ1oDt4FQ6f6zKVYZ71CnkHHSBhjIlT0W3rpJ6h81LsLLHgpoA4/TKHpCNiu4D6pnZejfsN5x01NlkVifHFbQxa5tkTtYKaY4G7/N+Xy1Y0MBbPijXJzvhIu17i+gmatxn3f7eQImIEC3ozjDI8cAoSB+NI0MUAnl/zKPGx/A7tVzezmA2MBrqMTuHc2CXnLVE3gdTwiKx5AnMeF/9FHodWzHskIDubPh2hquRY9JLzke8aT+bG0HTkkuuA/wkrFoB5nkcVfb+RBU2MTpFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i3dSzw0X0YV82i9fS/frYyT05EjJFrGmxEaoRwO5gE=;
 b=dz4U/jnm98fgalojaa5oRVrABeu20GHVjZ9PEYWmGYALU733qqUoyH1aR9Fksys5y2lvN8SfADfF4/o03LYhJa3quUD8ZLMrT7KstRWScbzajTXlTd6H24sBzyEZM7DhemNy2dfQC00gllMoMJnqj46clIwe0IFK5VHJ45q03xRvn3J/ISzq8rc7HXrycbQH/uA761yYrwGxw6yq0eXEBxrMpYAEukBrMtvUJSKgcSAhqvG7c/kEojDNn1YrGSbW+pXEFFu7K8fUG/8BKxKriNGsz5NgxLT4Ml+CjNQ/owjKe4Koo+zwsFKOXxDSRxYrMYAlgyeAJzNiqhXAqYF87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i3dSzw0X0YV82i9fS/frYyT05EjJFrGmxEaoRwO5gE=;
 b=n4P+4QdWdNpO3qfGSKPK6YfzL74RCm+znGMHM6VCIv6Il1TFXsqMeg0/GyZYqDQ/ynBdYTlDfPrA2feOQMGr4ETp3vTvUfvKUfpx3GbQmRsLY1sZ/RPcFYVC6qfHIlPJMaVrsbVz1tLPNovyUwIAJs1wZpFmGKc55dcJFfi6LDo=
Received: from PH0PR07CA0056.namprd07.prod.outlook.com (2603:10b6:510:e::31)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:19:45 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::c0) by PH0PR07CA0056.outlook.office365.com
 (2603:10b6:510:e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 07:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:19:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:41 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:19:33 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 26/45] drm/amd/display: Check link_index before accessing
 dc->links[]
Date: Wed, 1 May 2024 15:16:32 +0800
Message-ID: <20240501071651.3541919-27-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a5d531-06b6-4fac-15e1-08dc69af1247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qn/38Tb/XvnyTpKya1bgxOuZfRKGL9yEwch9xXhpq6AQ4NRz53cMRRQnRQnF?=
 =?us-ascii?Q?33pOBfVVYF291SRI+V2KiOLHZy/nSoclxgnr4WOCG98uW1RzHCvLe7rZqpiE?=
 =?us-ascii?Q?KcdvDEIA/iSOiAzkWWlD6agVN5RbIQ3Le72oEL1ejpWFpVw3NxOoAQ1hp6Rf?=
 =?us-ascii?Q?s4kS1xOYDzV4z6deATWdBIOuRdHJD7xdw3dNg2qbf6/c9CL4eXJDG3qeFJ9c?=
 =?us-ascii?Q?FUW18bv8tSXhITpedarF+BgAL5N+W2D/+SSPgBINxggmcuL7VFyR3Z0v6OPi?=
 =?us-ascii?Q?CY63w5yM86rCp/URTjiwTBLamUECVqFBYWR6baEnIBUNbpTm/0AjQHRunrai?=
 =?us-ascii?Q?I9g5wpVkRHYvFCnl+wsFXbn46FWpAM6camheW0y4nFpLhyaa5iYECmDnxfFk?=
 =?us-ascii?Q?yGXCWjjTJbViMS3ofEZx1IwxG5JDan7K+gCC1iP0ezLTVicxxg9gA5SoNSqv?=
 =?us-ascii?Q?Ct/Y36JM1lwYU0XWLonSM/cZUV/pZeMxxn2uNxJDlRZ7LEsDLfUcbZ7UlIB9?=
 =?us-ascii?Q?5bgJbH1ve7pbrJjTCKYg0eN8e3TAPl4K7vdWSWYaGNteyangemrkGU1xrXrc?=
 =?us-ascii?Q?cEyqgLDq01MdX+foNTEu2GyijflGw7XdAj6vlWiGG6yX9a2QSXf97a8IVREf?=
 =?us-ascii?Q?wra8fCE3kjJy6Svfe6cfBd3t1b5BARbDzInP95O5qmqPFQVTD2haoNMXz0hY?=
 =?us-ascii?Q?9pmERIZUb92HyTAnfuKXNhXiJyj4uEDQA8aVaX+1YyYEDeIiw+A2abEHIocs?=
 =?us-ascii?Q?q7OpMbOl+aNXlKbb2RTRlrCMhCJ16+tFj4aYRlnOrOopF626A87cgvVjQID2?=
 =?us-ascii?Q?4X8FMNtQqc27Kd3udQtQpuvAUiwI7YfQ4wWx40HKCqg0+Ypk0M1Xc5AwLURp?=
 =?us-ascii?Q?etpoJU8k3kbVrphiuRg5Vr0g32KURPuBZ4a4qyZ10OF+qTiThp7UbNkhrVZA?=
 =?us-ascii?Q?jctb3QcoohHGX17GpffTE3uEzc6uogELk3hsFDbiFZOhWp99jtogWN05J2xJ?=
 =?us-ascii?Q?4G9QWXVhJ1ChZljf8NM/nSTgfosGrYLTKzjMUtccoBbiE+fll3+7H66etU5X?=
 =?us-ascii?Q?U5ol7WrcRZwbra6jSCyZFNa2B+Gq0iAL8xhB6HmziLD3SOaayoPb+LWt18Q5?=
 =?us-ascii?Q?Gl2luJGgNQNZaqtn2JhCaMsepTvF7mD+8GYgFdp76lxKXSxwXpE6bwhso4bz?=
 =?us-ascii?Q?0uOF7DfrwlyWvhLV4Vk5AOmeSQyd7FQ4/5/BzcvLJve50aM+t2C/NepUltBJ?=
 =?us-ascii?Q?1cXL7uzUpDiz9FVgFgZNdJM4b/v2O/HLYVEwR9F5KCC/sQ6iPyqAze8aseRI?=
 =?us-ascii?Q?XMYfZu3g1CV7T3+wVrVAdvdyZp1Jihb+AreI7rdaukt1DUAjR+UgXynYoD2P?=
 =?us-ascii?Q?AH+tT1DS76y24f9UY4um++nmjlxs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:19:42.5828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a5d531-06b6-4fac-15e1-08dc69af1247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
dc->links[] has max size of MAX_LINKS and NULL is return when trying to
access with out-of-bound index.

This fixes 3 OVERRUN and 1 RESOURCE_LEAK issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index c6c35037bdb8..dfdfe22d9e85 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -37,6 +37,9 @@
 #include "dce/dce_i2c.h"
 struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_index)
 {
+	if (link_index >= MAX_LINKS)
+		return NULL;
+
 	return dc->links[link_index];
 }
 
-- 
2.34.1

