Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A18C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CE710E575;
	Mon, 28 Apr 2025 13:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PYTsr3UG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E05410E575
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cll5xM/dL9DTPDMyKmO5IM4cTzAJ2vBZcE9PS3gJki3W/9qPvythWk71ezNzJM2s79Q4XTUDgvMmb1B2Djbngh+VVOtmZtgmMmzadCJQz1u0yKh073Yi/m24ohb3a9lfim49Xed+rmWwdwCARg7nTJxm4JjknpzNl1rsVY261xpJHxFfZeMzAguX4QleK2lAvjq17LpfXe/6bSMX8SgdYeCw4NnntEcJ4IewoVpfrrWD3VG/Basd4lYrEdYF11cEpnqLr3Kd6PMMQ+Cr9dG1t0EBErViz6d44lVuoz3Z97958h1XWWg7Yyu8zxlhKl4zbzbpvHg5ZzQrvq8jbHANPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPE84XRIdA3QihCkrne8zFjn7KQ95+wuIh6z4j44o0s=;
 b=axA6jyYXyUZ465A0MKCW6VDTwQ8Fg5hIom0Xr8PHu0b8/8/YbscEtX7UqI4vQiIreHRWzt6jHu7Y5OF1L21Pp2lXZKeCKNFwFSp7fNQcTG6LrQd8WgWvZrEX7nELeJeZZRvZzKzuxw2jXbokrclj2hSRucvrMTW0azKqKvchoXYZh4qj4NmLQsT+Avt0MqzK8gt4W0W97SA27HlMuDQOS/6uPspsOoalnWr8Z5IfIcicYdfGPJSmiAPrIaYhx5sFAGpYDbLKxLA9RB4d4wYOSm0AeNHmW5xKpikhTJWs4c5Io56ljvdUCYtsuA42FLnJBtYpLnUzBH5sYO8qHOJTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPE84XRIdA3QihCkrne8zFjn7KQ95+wuIh6z4j44o0s=;
 b=PYTsr3UGOoCrnjuYCEk7IGn6hdVyvdRp1eZavL1FV3pcxRgZbj6Ogq+9yWvobCEUcrJrwY3514ARnlzx4tJJSGgqDX6b0WNsvaKHZ75qP6FctL5DPiGriryg9Ec2KkW8NRNvRxstrycycbJgKrfH+jjIFsrnoAKda0+KH6ghzk8=
Received: from CH0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:b0::13)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::992) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 13:57:26 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::4b) by CH0PR03CA0008.outlook.office365.com
 (2603:10b6:610:b0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 13:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:57:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:22 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:57:14 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 23/28] drm/amd/display: Fix the checking condition in dmub aux
 handling
Date: Mon, 28 Apr 2025 21:50:53 +0800
Message-ID: <20250428135514.20775-24-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: d28683d4-2d9e-454d-c237-08dd865c9bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U18FS8K89fqq6WxZq1bkEWiRFcGh1T1wynj8CLVOYKI/907UvMPxNyBbfJ+n?=
 =?us-ascii?Q?ORD7oceskeV1Mrv4yntW530yYJeY2tObIEOVnyoFKUGH1UnNjK0Da/3FohAO?=
 =?us-ascii?Q?61eKHSrSgZsxFDYNJa0AKvi1SIC9YK11RM1inCvfvPsXJUA9m5U4aXD974E+?=
 =?us-ascii?Q?nkOq0gTDzjfijsI/WJhmsCZoau1r8kHfkAoHj8VzQxPmTU7bqEu8O0nrawis?=
 =?us-ascii?Q?zRvgUhSl6ukdav0T00MsCUwpEJfgPQlD2EdS4B6cxPqv6kFklUvGqCBpt0TO?=
 =?us-ascii?Q?N2+6fk9L3apLbWspb0YFAW1Q1ThrAoa2yZ7Ah2VmkLh/GDu16knwz/joaOCw?=
 =?us-ascii?Q?z/jALgr8PTHP8U/D6qaPGOa2D84ue7ItCWh19uMyzaTCyHvFdE/FBIgzQzO5?=
 =?us-ascii?Q?k78oG41OET/JNVL6BqUugUZXvhKgi4lvAWnbHfsbtdG2e2QvN3jWZ/W9L/yq?=
 =?us-ascii?Q?Zvs9q2D8LiHewk6dvf75gD4H7jebQQlwg5em1Cjcccb/GFlFFLvRFdV/T1s5?=
 =?us-ascii?Q?tMhJS5MvGae/bpmZXGy2o6ToJ/LgiF2NkckM01rh55nsdK6CpPA2HGAqnzXk?=
 =?us-ascii?Q?/ZRuSgRMXszo0uDpe5Qdq2sbI3yXnKJiVeQqnmACDt7ALI0eVn8QJJPEjn/2?=
 =?us-ascii?Q?1yvEQSG9IxxNVpDnzwL0pLdqVnk9w+36mOPaafpEwrHXXUjA4CpbM6dMBgYQ?=
 =?us-ascii?Q?rqVVEcKOg2hLiYN1BWJTces6iid0vRxgfM1WKXtAUIzb9w2DsM6BkTWnoYfO?=
 =?us-ascii?Q?QMnyLQu3R8YEjVf3B5HW6X4BifW+tDJcKuUfdW5yIqzis0xcIh6PRQX8vx+N?=
 =?us-ascii?Q?tygeM7dhMBwDVzjS8l2MfzGxq9wDYp6KWaIrwd6InCtuw7h7NSmQUprq1SML?=
 =?us-ascii?Q?3kXvCQf0JxcXHGmQ2SBOVBqUIF5Gtg3KuiBk2h58XdOsZnMPCkITtGebkG/J?=
 =?us-ascii?Q?/NvmbxPrSleEwK8aukK9xxQco51peoRp7jxvtPG8An4XmG9Q/617RVT7g1ba?=
 =?us-ascii?Q?UMgKTK1eoVMTjuFwI9woKMs3BjstiACRZhz/qWG7TWu44HzL4XV3E706m9RJ?=
 =?us-ascii?Q?H+tEton0yJkJ0epEUa1ajP7EX2YgG1UkNN9gilRJgm8Nv+DXFZg0tk/vkL2l?=
 =?us-ascii?Q?HDlU6H3XqXma2QMnju0HVAda9bfLNn1dkHOx/eaUboPI0wN1YVl6fare+z3q?=
 =?us-ascii?Q?ZSXZkbmIcMhxK0Obh6u4e2xArNH/MfA40uG4uP92PAzymf8VuMYvI5cu6RY7?=
 =?us-ascii?Q?cKQtliNT7GLaz2pDukw32Nni/Eb5zfegDyi6xQ5TDfRzUwc8GzclolUKIvwU?=
 =?us-ascii?Q?q6OaLJ1nQiN6f1M4ivLXXdh1faDZCQzaV6z5EqCAn8BhjAlPHFHWaxJNLKId?=
 =?us-ascii?Q?cLfFsT0/7LyEirSDUOoty/2ECqaZ077DSO24yHKIRU5ndoaXq5iRQRRvQyHR?=
 =?us-ascii?Q?517le65rsgkO9NpryT2srH/fyG7fdXBQJe/a5WzNBB3uMeUuvdGYZo4xrUxi?=
 =?us-ascii?Q?8ijOuNGFs9TzYJJRYqAj16lz5d67vJH6+oQT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:57:26.4690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28683d4-2d9e-454d-c237-08dd865c9bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Fix the checking condition for detecting AUX_RET_ERROR_PROTOCOL_ERROR.
It was wrongly checking by "not equals to"

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a59d0ff999e9..ae71ff3d87a7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12843,7 +12843,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		 * Transient states before tunneling is enabled could
 		 * lead to this error. We can ignore this for now.
 		 */
-		if (p_notify->result != AUX_RET_ERROR_PROTOCOL_ERROR) {
+		if (p_notify->result == AUX_RET_ERROR_PROTOCOL_ERROR) {
 			drm_warn(adev_to_drm(adev), "DPIA AUX failed on 0x%x(%d), error %d\n",
 					payload->address, payload->length,
 					p_notify->result);
-- 
2.43.0

