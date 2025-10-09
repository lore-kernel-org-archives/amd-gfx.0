Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7DFCCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FD610EAE6;
	Thu,  9 Oct 2025 18:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I93H8/CS";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FC210EAE0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM632Io0s8h+0DbOX2kTGP5+ijlEJzXR4orIkIhkejJzXqnyWip8t4NFpxtghOHTLrdeiLSY244sxTWkHGpR7qaPK+0Bq5OXavHzEPLg9Hu/Up7L2gOb8D949KMrpC8CeM1pchyZ3ZYJqlX+UUX7GgVHfyZ0jrmfFuCaVxzOOmMKvNxQAWf0Nc6c63aFO2bnRP18WXagpZMgDvSSxwRNdemSFrMGXp5zbkSMhofBXZVKpptG55XbIlY5yOFr7Xv5vR+SVmMBmdMNirfb2ZZgTHBTH1W5ZRpxHALQ1DlhZAlureR1OJCpLI3/+P2RBhNlBdxg8g976rdTo4XPaG0vYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKN3nT8JK/mvvi/A8xjpl8XFF6PyOqnD7LaS+6shxiM=;
 b=SkW/WnhoMB420sErxymzGRGIKlovHD5+HylNwcG89EEoVcRqt64kHaNTsU5Pmawx2FS8W1Jb5yX/768GAwW3usSxlG643qRY/G6p/7x9PCSPUd/RfVL9TR8TQjCe6IAkma6p0Egzgt0N6u2A07u/qikhhC9doC5bhAO+HC2YnEzxLr6N7QfuBKtBltNQ3C9Dhp0jzSFfuD9QjC9N/6MxcSopOH1CIdUzbA1HkEc+X+zBUoycc41jimIG19iSH0BXGVgalX0lxd8+inT/y5pnjibSQwm+KzTDRm6cRuGfcG2wZvMWG1VZyqJc2vEp4P4g5LGz5stJe5lBhD1zfPzWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKN3nT8JK/mvvi/A8xjpl8XFF6PyOqnD7LaS+6shxiM=;
 b=I93H8/CSuXHCFPtas8LwBF017Ey6ze9eZxUwuF90Iw7MzKjbbLtuOlmqW7O7p+BNzqG2KCO1U83k22Zpkgah8CqPENO9oqL+bFDS44uy2pvdOiv+dLFm6shP3G0rikA350FeOfu6wmuJiNvV/IrKSAUvDnhFAXg1N8jp16Y7aJM=
Received: from MN2PR01CA0035.prod.exchangelabs.com (2603:10b6:208:10c::48) by
 IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 18:49:56 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:10c::4) by MN2PR01CA0035.outlook.office365.com
 (2603:10b6:208:10c::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 18:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 18:49:56 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 11:49:53 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <Alexander.Deucher@amd.com>,
 <Shaoyun.Liu@amd.com>, <Harish.Kasiviswanathan@amd.com>, <Amber.Lin@amd.com>, 
 Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: fix initialization of doorbell array for
 detect and hang
Date: Thu, 9 Oct 2025 14:49:25 -0400
Message-ID: <20251009184929.1038298-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009184929.1038298-1-jonathan.kim@amd.com>
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: ab80111e-9381-4ced-62b3-08de0764a433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iEN+abXwXcKL2nGpajgq9sr9ePM/Q7SmGzavPhLG7BjxqAVlvT3ydzAM4Fjv?=
 =?us-ascii?Q?FQHm4XqB+hQnWFR+zLbFri1e1EqOkWKjaxkml6Fj9TOjCQFVexHORWSJ9KV3?=
 =?us-ascii?Q?8qAVV6888JHGqqKbA+P7UJ4rnbaJvbSXdpns+kQ5xJIqAb0m6EJ4fjebZ+/b?=
 =?us-ascii?Q?o8DbXXCvHo5N1evsk/fthuoeMc2H6TXNtnH/UhRqTrTjYS0XT6PZwYe4E02n?=
 =?us-ascii?Q?yb5ENsxnXBdxQMDlzPr0+8tGuzd0Cng3XfvLgGXsBSB4q3uOXLrSe8HxoZ5s?=
 =?us-ascii?Q?8Kb6zyojxWas/gGKZ7aQTA3unQdwst+FsXs8CzIHvORkA/GzGBfd50UTXyX+?=
 =?us-ascii?Q?K66j24sWgHwCGiZ3P+JpdftFhCvM/rJi8Xz9RNzvXbGuhIpK9L2tMKWz9/VN?=
 =?us-ascii?Q?QatKXKpsmU627hu/QZxH2H1e8hd5lv/6A1zsnlSfOe9CMswMsUWYCYULcK/j?=
 =?us-ascii?Q?XFC4OkDgbxxbjoH9U+8ZYU2iDM9QNvOjcB/Q2t1adPEORJMRExqG+BHFMGi7?=
 =?us-ascii?Q?1BgaIdYmkZUgL1qclsxm46zfFbmRRYqSAqog4OkXEPddIWkSA8XjgEsbxvfU?=
 =?us-ascii?Q?7zIvetGERXkMz6kpPNT0Tyg/DRyfq4N8Q2L7peof03Z9HdKWH94hlYByZBPd?=
 =?us-ascii?Q?kNtw2mdNmm3p15b15Ik2m1EuHTbxHAQs9eq6C0FjkQKpZg8vsGk33S9icbV/?=
 =?us-ascii?Q?e+h6vEIOsN+vEvZZVsL3mtmj7yFeYEA93bdnCUZDb0ss9XeMl+Jij4jtVmbT?=
 =?us-ascii?Q?Z6CFahLf3G3ytQZKoOAe1pDuzKoemNqNgUUS00RJ5TmQ9sP4Q9lqib+83C6m?=
 =?us-ascii?Q?zy512nKmpGk0jPNhCyX8meFxlqS5Z9JY7y7MqtDJjuM9GNoABjRn+o/rkqeA?=
 =?us-ascii?Q?ISK1mQ8cectOJ/7yb6QEwSy+eG+M91ggWE5c6BuNyeIYAPMXvG5Fn/dZeLeM?=
 =?us-ascii?Q?QQcm2Ld4VT73+PI81h7TmXd4cxEue2488fmoHJI0/VwXm2Lm89jYs9VX/KIu?=
 =?us-ascii?Q?NEX8yBig/1ehBdppstoJVsR7FowrXsVkYQER9vjzhaWLb6cZQFhdKSuV0oVb?=
 =?us-ascii?Q?FYfX2vVQmIUFmg8SMfoi/zMRRA6Q91c8F85HTdTtvv+PdCYn+AlV+4Oupe+G?=
 =?us-ascii?Q?Ivq+bRKyM4PauCoNxo/9S9hblWYZQu/hW/jxC3jWVP74Q13FFbo7XOr7G082?=
 =?us-ascii?Q?+NHfEBwmk3wltjQQsRXDOQq5ZDtgKIj59XBi5+w9tJPXE61EDMG1e2q+f9eP?=
 =?us-ascii?Q?nYO6gv1MSS5+LB49U/bLhKiwQkwgHm7ohHjUVV6RC9XKvZ3z63QWW6jjWhd7?=
 =?us-ascii?Q?rpp8q42ytByrVYeqm9tNx05Ortl+K51MLHy+71qTV72nYjF2zZIhZyXVRdS7?=
 =?us-ascii?Q?/0j/DJ/ofZ/RHZ28gOpR6DbBnjT0g/oeaahNpbDmdcnuzmbTb9sPhZv8SkQb?=
 =?us-ascii?Q?BPkbZmYN1wYYB5GL29HrPGpPLY9SvQrtDMO1kydmKkfTe6pxlcC/XVBpU83D?=
 =?us-ascii?Q?v0k17zK444D3ttUaPt2+Mhp6sTn2dllPPCLTjYqbNNUFaSH0pKsSoQSL60xN?=
 =?us-ascii?Q?MvJriLpSX830LqT1tcc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:49:56.5707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab80111e-9381-4ced-62b3-08de0764a433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

Initialized doorbells should be set to invalid rather than 0 to prevent
driver from over counting hung doorbells since it checks against the
invalid value to begin with.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8d03e8c9cc6d..c698e183beda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -409,7 +409,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	/* Clear the doorbell array before detection */
-	memset(adev->mes.hung_queue_db_array_cpu_addr, 0,
+	memset(adev->mes.hung_queue_db_array_cpu_addr, AMDGPU_MES_INVALID_DB_OFFSET,
 		adev->mes.hung_queue_db_array_size * sizeof(u32));
 	input.queue_type = queue_type;
 	input.detect_only = detect_only;
-- 
2.34.1

