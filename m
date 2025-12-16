Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189F3D637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD0610E8A7;
	Tue, 16 Dec 2025 21:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JvLADReq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD2310E8A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOXSIBLux5RN8rfwjJ40GsUdbJxPKeWZMI+SlR3VMibfqojK3laqOlVVYgJ0ZfX6iRM7We5na+Bfq7vxfLmbubG5t7nYZbB01XJGcSSCJe5lzlhzmTIWn6RcZImNl/KrzcD/EzEvCwJSqw8zA+qMU0A10N/xtNntabHDr50Z7yKqLC7hCavWMRt3A7G9Cq/PC2cyTyIYhu5Hmf4Jemum6tTE+elaCBqF+HW4rOs6+51ehWI0WRTq/hOCVoL+U6RmC9JS7Tl7+Ah4QBZoIuzWsI11e53vei7b8bxVOlGXh4MdI0EUxaot4ju+72EEWWJgSVJ4d6vHC1zXeWqpQA4K4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH0b1utCrfpSiyyKoV2MDbexlHPyRoWSdVKn2U4My5c=;
 b=JsMK+4Ty4SvFMncchFeYqJBWCZAIL25KvwJfsWwKHiJV9cFE12NuQZcWxCMDkcQ2fnud5i01RhTHNrJUSGt6CakNLxzt6suOroFMGdOgjddVuV+lEjfdLKPqpprevGHl726nOmcdInNwr1iAxnYnhF7n2/VyuckircNOlfRMwadGbqMFMKjfqQH2a4c1+IzllXiuxmyWP7qyuaQD/Nr+Wr9ulA22KU2AQhwNiMBK58uoTWF4v6FsgN9ezhDrrhk6K8BnaOrrzmb+Lw63LE7po0G6bAalFrBFyz8BhRY109v+FjcEUDsY7cbOaMCceBn1+NfKEP+B57hkEUOg0+Sz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH0b1utCrfpSiyyKoV2MDbexlHPyRoWSdVKn2U4My5c=;
 b=JvLADReq6uKseQflb/sz9an4i8XkeNueJkvYbsiTYt9YQkrpMpShB1Z0LG7mIpPPidUuI6u5WiUJGOG7o1wf7R0W3GaMuZMR5F1B/WGgCK14v1UaaRsVM9WYb94rkvqFFn5lJwGcfouU5Hgts4J07N29yYZhxfzvZSw2zwHuR70=
Received: from BN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:e4::31)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:10:31 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::38) by BN0PR02CA0026.outlook.office365.com
 (2603:10b6:408:e4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:10:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:10:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tim Huang <tim.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add support for HDP IP version 6.1.1
Date: Tue, 16 Dec 2025 16:10:08 -0500
Message-ID: <20251216211009.1963990-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216211009.1963990-1-alexander.deucher@amd.com>
References: <20251216211009.1963990-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0cf24f-d5e3-4370-dfab-08de3ce78bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+RnqrafDRaJVipt7mRu34d7SJCymTtiLU0XGvLhMv3o9NFvMANohkiCcy7Fa?=
 =?us-ascii?Q?Inh2hFVj4A5MrAmM7ODl09KZkJUKuZ7CCvNzDaCFAqpUsw040vNHzhjAETHV?=
 =?us-ascii?Q?AcX0tERcgnQVmWBP+MVpsDtKDl5LpBAao7ZWVtAbsPIGKM1C/U1ti1GRdSoK?=
 =?us-ascii?Q?/1kJsNKsvv+AOODan9sNKVNCWgeWOM+yAprRFFnAYaGguNt6IXVRoZj8rvKg?=
 =?us-ascii?Q?vvT1R5yMIN3xeOE5qI9fdCpt0DExZVy3N9e5PFfK8FSp7wOqP+YpjW1svTSN?=
 =?us-ascii?Q?w2XwgjmWg3UYN2b9oTtiInDZH7qiF93aDfG05TDCtXjav1lGyYa1jlF5poLT?=
 =?us-ascii?Q?f2KqbK7pGiTahvChGtiSlHp+dF575qWdguqy36Olc11lEASnUVRubLTTRIxQ?=
 =?us-ascii?Q?3+Uu6gDxBqNLBtvvXc/ZLqibwAKSPN6S45ERVBajji7Zdqu+vPFXwex1TlbH?=
 =?us-ascii?Q?tRzjz5UKdtqR4+H+r8szIZPANtig1uSgZfLxIgBm0RVSyfVanv461ymniRtM?=
 =?us-ascii?Q?2vaOcX3xK6rjcDktpNPgmi85nSwU77zGxFdOVtNsQ3KtrWeliMEL+7hlk2MN?=
 =?us-ascii?Q?R4Ju0JkcBrFGVAlikmpSX2uTJ+CgafjHBfx0mptYBfo4c6PlFvOGQOQWyl3t?=
 =?us-ascii?Q?D1dDm3jblmgC8npzS3jcrsZY+x/sGDOuPAF2wRUOcXVVP8YB2oSmdzXo7pBw?=
 =?us-ascii?Q?hRnxzb4FhXRHO8LTuElGI1DCCqrlrIVB0bEZptCr7B6VK4zDAOFkF8zUUFEO?=
 =?us-ascii?Q?aM7OWa8QfQkZYNLrJFQOWQAo7uQOqwoG8vUqfQzDKG4Q9iM7YRgdQHTBwACi?=
 =?us-ascii?Q?EACftoMohjFHVCQe27kNtITLxKA48SM+3Ew3KNqudeDKSbe+LIUUCRLHXXjQ?=
 =?us-ascii?Q?CWyVttBze+YSFXjhGpZ9+wqNCK8qTfc7a3c4vWUU9VGmZDNIhlIDr4fw4vGL?=
 =?us-ascii?Q?v3qinyA17/l8O9pDJr6C5koI5gHAzcIyxtHwgCgXGt3GNe0EF8X1zEuwdtnW?=
 =?us-ascii?Q?H/8FvDzB+o5pEITY2CTNXyHfeZY/rrrO6elXcUwRAXXARatp5R+mC81IeKLt?=
 =?us-ascii?Q?9SAtgFU0NQuj2aEZToLxUId5Txhk5X3AJ0M2//CBn1rI/7oc36he3CZjlOFe?=
 =?us-ascii?Q?gc2U4LLsq2nfcbeeaxo8JTIrwX4EuwbYGaJigbG4dA5QFl5fnXNj+WLuh68K?=
 =?us-ascii?Q?Xwqf+qkt0/NasouG/HOs0m118AV2aPCHqZZOEE9yHXRZlGP00WxvTT8OMX7x?=
 =?us-ascii?Q?oDzIE9OJ6oRV7i1/mygvO/02OXkL2OBpFP4VwzHTsfvCOkK7pDl1XqpFq3EE?=
 =?us-ascii?Q?lmOZjWlVKvvgmYo+Ns8ERIsZRvZdWRr75u902gvk1Iw18t+uCAGqvsAAV7k9?=
 =?us-ascii?Q?aMuAQDZglkzilQMglJtqMrSDSD3L2K+kvytPISWdhlSoCLjhZJo+WikGGZ5V?=
 =?us-ascii?Q?DpR7HviaZqpPJS+FwtfOAhF81bBsEWA+o+Nj+0LBQziTkwCWhxRdrGxIVMRb?=
 =?us-ascii?Q?xpTEX4NvfDm7Lzw1UcgkOIegC4pYsjKymDhMhfvDkU8gndjIDS3fchyNqZ1+?=
 =?us-ascii?Q?862SKnGHZcd55q1sxmw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:10:31.1225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0cf24f-d5e3-4370-dfab-08de3ce78bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
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

From: Tim Huang <tim.huang@amd.com>

This initializes HDP IP version 6.1.1.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9f8ba97c3c148..ac1b95b9a4f6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3101,6 +3101,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 1, 1):
 		adev->hdp.funcs = &hdp_v6_0_funcs;
 		break;
 	case IP_VERSION(7, 0, 0):
-- 
2.52.0

