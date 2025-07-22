Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B7DC83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A04010E72E;
	Tue, 22 Jul 2025 22:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OnaUIyej";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1DD10E722
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/WWgY+K7lMP1bNiZIFGvR/y+9cd2hZweZAjEtvvDLgR5fkeOy5GLFHrIS5u7hpz4ZH6DKFe03q24mH1A6SKxgyGRNkwSg/2Idy6rb3X8+CTNgC7zqxBGcQpx+vb7qcSkjqLiHFfovknbyFZxRS4yn9fG9o3rptzaPgbFsST3zTXHhsvYfBO/gdcZnsY25t2N6uu3JW+eVcE1sS+qItHJy+kpS3a3PDJQZJtMP7X4m0JGHPcVUFspxNMtGu1bz8oJntrbDWYT0wpaQqCpnEePtnTR4piMY8Xv3t/CfxVkljmVHYV/NXXekPos/2udhyK45++SDLrXkU5QyoixinsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4dO6zl2o3tHkQxLr7CsJ8t3dPCfSnUxXRUfcEjhPzs=;
 b=dBxtXr/jUwSnZXz3Ea6mT+fmjfQq01OPN52AHt04U/Nms6fnRie9113Ph+9Hlm6DCvHVYltnmDqWhUCp20+GYwsRT48cy2y6LGn37+mhYiJMz2t0kNpgpueMbl/LUtwc3xEU6eFdNX5IaKV8QU55nznEPu6aeVw8fhhzwA8bJgdyaNZ3Wu3dwuW01hX87zDA4+K8s0xqGIsSj9zFU7TZJ4CYV8/O1sob9DoD/f8+9zmDDQxpp6llrNI+/19Vejaum09lNoHa0ka1y1tPyag7EchpId6XOhPP9G6XhTzy54KceG+l6u3ADDQoSBccCwctaSgX5/Db3IiCHZgCBQWk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4dO6zl2o3tHkQxLr7CsJ8t3dPCfSnUxXRUfcEjhPzs=;
 b=OnaUIyejJid3RIQaAo2bx+SBk75UYov9JgC9Axnl6HqvLGqxOVyNOS+Rdn7EXpwaf4J69g5+kG1lzw83xuWF2x5wm/XM40NRefgjo51d962LyKPtZNB/q4MnsM5o9/XOsirpuMFgrXyjtz8GlguEfu+BHJw9G3CDQNkvlkCDRDU=
Received: from MN2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:c0::14)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:39:26 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::fa) by MN2PR05CA0001.outlook.office365.com
 (2603:10b6:208:c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:25 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:24 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 08/25] drm/amd/display: Drop unused include
Date: Tue, 22 Jul 2025 18:36:14 -0400
Message-ID: <20250722223911.2655505-9-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 0491117f-c8de-4d0f-c1aa-08ddc9709d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YL+PP/uwr+YU6FcS7CUiaWEICrqx7VZ9rDCrAKO3dT5sQh5yCBttGyyMyiuW?=
 =?us-ascii?Q?MYGtrlQThFTl1O+s5Y3XbseUdSrzJa2E1eVChjg+e8t4NANTpTXQjZsqqQf2?=
 =?us-ascii?Q?05HQZbo8r7n2i7mfMl2U+gaKCSSZC/sUylZyf0NxW+ve13AE9No9eDYmMfOM?=
 =?us-ascii?Q?96ESYirpSTP6y/w+qcx24u+NYWzyd15GPysK0vcf3JXH2JBxiuJAIdm/KaDI?=
 =?us-ascii?Q?RNCbrDw6Gdjx7i5wLX8VWSBJASTq5p/9zEa6zTkjmBMKPInTefkokDuXIS0H?=
 =?us-ascii?Q?dAwhJW+cS0zSwNZm4qIWEhsxvCkGeiIIpnv2xUfQEY93FF+dij654iox7ddH?=
 =?us-ascii?Q?KN1dsG07EkQhqUeygL3SFN6Y9H69GliVCWhF4S70d3GLGWL3G5FQwVaTXtId?=
 =?us-ascii?Q?JWdnkpHOufYioxKCh8FAtuHZhVoi/KH1RH+tD+tgTOsO0UnoQ2AI0i4OuzsB?=
 =?us-ascii?Q?jRgzGUlsO4gBgsH5hvEdTwpaQ6ww9gDPhw8Xxpg+x7K5m7nf63OQeBbBRrl9?=
 =?us-ascii?Q?1Ib3ZrkmXIicz/yGP4ZasgClOS2c2uWaeQ7FuRcPF0l8lwfzp95kMobXwVpu?=
 =?us-ascii?Q?28raL0WYbMhhwf4wvzbT+Atv8G3xY6xe5GAh6NjSXQ0DZJes8cOixXrCXCYO?=
 =?us-ascii?Q?cs6jgW59T9P7l7su757/glIUSdPkRoTXpO68xN09Q0pwn4YTaiIcm/PYLQVZ?=
 =?us-ascii?Q?mZAeQX6t/curEHQe3V+bzoabnaDn2tWSKzq2HigZ3roh9cEFAyOg43kWpbwx?=
 =?us-ascii?Q?7kjAeuEt/tM0RM7uoeynvXyp9haJZDxi/4/hq6rlZaBBHIPqTwUEoeltlrpz?=
 =?us-ascii?Q?iVmtqormAzQgJq63YkZK8lTN1boKVIj9GCn2wbkVu+XgpdVaoUEfNYPr7ryC?=
 =?us-ascii?Q?L/LqIPr0/PXSIHLTIp1dsqBc/2qulPsVVz9BFp7YsQAYrJoTn8pbr+doLF4i?=
 =?us-ascii?Q?jHHqml0AnN/XwUGisNTPIPkKti1oH/Qoj7yF5kvyEWc4EVFyg8oSzExcXEE7?=
 =?us-ascii?Q?c8/IWheIofrW9gmNHYmmqhOxxeusxxFjAG3TXCFIQojMbUGixzZJlmjU7tXI?=
 =?us-ascii?Q?HIl7ox4erkewM8fFhbG2p53eU546segWk9k1sJoRXV5Zp+L5OeLxvZGRJ0W4?=
 =?us-ascii?Q?NA9cYuwtSQomgBnE842mUfQJIySmxFoU+S+tYPZOqYQZ5CWcKUxayJAC3R17?=
 =?us-ascii?Q?ggd71A8FdYKdNQcPzH1QyUU4wbKnF9SW+tn+Mqk9NmZuV4MBqcpMZeXKD718?=
 =?us-ascii?Q?8VYNhSgnq/akeoffbgbEJ7MZP14YVSfh7NohEVuMwlIvRu9LXzoImyndZ6Ub?=
 =?us-ascii?Q?5M9K8FQwg1RlsbvVRaq8rzYlp2TbTPn4eWK64T+p6IJgjhOrYZQ955D7q6G6?=
 =?us-ascii?Q?RkCqRB42Llw0jralqbiO+GN+QXuY6m5xO2sBYArO9wCK/dBv8rjqjDndQQgr?=
 =?us-ascii?Q?Q1G20YfR4Y9PiQvDYJDgokxrlKYPO2Rcu03uK0THONKwxwvgCwjQBfLU/p8u?=
 =?us-ascii?Q?CoZ9P7Pe4Pc6BYSrPi7at3hlW0Re3AXUtvme?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:26.4636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0491117f-c8de-4d0f-c1aa-08ddc9709d11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
Extra includes slow down compile time.

[How]
Drop unnecessary include.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 5d7098c337d0..d5a3768bf002 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -27,7 +27,6 @@
 #include "amdgpu_dm_psr.h"
 #include "dc_dmub_srv.h"
 #include "dc.h"
-#include "dm_helpers.h"
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
 
-- 
2.43.0

