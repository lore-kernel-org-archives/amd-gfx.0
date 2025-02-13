Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAB8C021A8
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CE910E9F0;
	Thu, 13 Feb 2025 05:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Psahqr5X";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2863310E9F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dePaQltVbggR7giQDKiZ49UL4oOFeItBzgJH6OWh58KxMhJoiNT6vsTzVbfCQedonwQfWqlbcbVTeMPPAHbyRD5ADqSfJhk5qibx+hqlmCRtbtsiqAkzyDea9gcjs9DInktnVfWWUUveuY7ux9Lzc2e/WALKaIbmWKQYB2PtMJ/bGxCC6FUoSCzydYYsGcQ36r8SHXiFK5PJJevAA28ABdDaEOUFK8K5qqrQbugT+BzKWgb8aP9YA3l8IUFVk3xR7HTqV5Yx16FvWLyQK4ahiC8FaypCKbizPt91IXCb6ySk3ka12QvjEAiEJE892AxGzjAa46OczmiYyfGk0um/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbyGbwyyD6P13KxteD49dZUsTIUUET7sEy63KU7BVxg=;
 b=s1AINxyXAYIkFN23CCIZNIKWijCjs+5b470DF7UTfRC29TsVbcggh3Jhu1muljy52Fxy3FK8waEl2NUrl3l+q9mzz+O0Fz/X4hmSIiX9cUHtyC5fzqHoCqjkszVcnUNUJh95b0jBgzb3yGIijANM8A1p8LcsjUei4MvEe5tAwae4vrhMmQu/VoG65L7pjVUhyf2BS2PD0gqT4YR5eKSSDDt8nR/xQBueIx3d6t/UaoRqiYXWztMYphXk6lxAkHasMcxHtepb73kDWb4cxqXE4e4OOZ1hSsHVf/U4pF0VmREB8kJUpq/AyR2jKkRMg4dEmrQufo51ikxgMPfpbXRPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbyGbwyyD6P13KxteD49dZUsTIUUET7sEy63KU7BVxg=;
 b=Psahqr5X2z0A3S8QcaD9Tzgmga25b6wrHO5YSrqKIZtUQ7fAh9wTl/VTQfaQismtzWeN79AZvYWN9zlnM0Sp6KbAsd7YfLmYS6ZJ11IL5VZduVscX+VFxi3TERzy8BnlRsnxj29JsiBkDvj00M3ZaedZN9zmssaBPjfqOHY9QVA=
Received: from DS2PEPF00004563.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::519) by CY8PR12MB7339.namprd12.prod.outlook.com
 (2603:10b6:930:51::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 05:48:50 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:4) by DS2PEPF00004563.outlook.office365.com
 (2603:10b6:f:fc00::519) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.3 via Frontend Transport; Thu,
 13 Feb 2025 05:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:48:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:49 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:48:42 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH V7 8/9] drm/amdgpu: Add reset function pointer for SDMA v4.4.2
 page ring
Date: Thu, 13 Feb 2025 13:47:14 +0800
Message-ID: <20250213054715.3121445-8-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1495fa-476a-4bb5-b745-08dd4bf2176f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LnhnVMGqgyUblwhQ7Ss6e0+NQnhHZLrPU2WWH4+GcNBJgb7/5pUlj/vFBAKT?=
 =?us-ascii?Q?ZaKii96iIn0VOyO26hca79Wc9XqSIh9Z1EY7q3VNglpn/V+tF+A0BzjwumGA?=
 =?us-ascii?Q?S0kIEcRLgKnRU8hSzbOYPVXqv5D7GpVNrYYTPb3F5QXYAQi4wPQt22Sk8CVf?=
 =?us-ascii?Q?ZpqsZ5TBnfJqwnQdyf8pMJ3bHHj46CFF5nYha7pcPAP/OQWPd5h4fudJs0Wz?=
 =?us-ascii?Q?9sDNJPpMlduRSgKFPt7+vyc00EvgD9lAO4VKlprOohxlaHfyETFGJa3ZtlPb?=
 =?us-ascii?Q?N9cRp0sgDsYzCuOVr6fdaftYzuJ3XavVADMe2QODBPz5Jbjlz8gAEuwS4+Ir?=
 =?us-ascii?Q?saAXR5ZwK4dxP8t89cuZ5zQjZc3MxWKP/sA1B5POOs0XN7OhLg9I4zs/Hnsc?=
 =?us-ascii?Q?jLfUQsT5uBHGNKX1+38ZMfVZ/RDjCzqovZxUBPj3AfvU/TlMUzoUKXSyJQKA?=
 =?us-ascii?Q?NuZ2K8/swC/NZu/HTvpOeR8RgH3AZ4T6twyZ0QiBa5GudPqO1Bfj9FOiGyri?=
 =?us-ascii?Q?kMLFUPJrqsmcRaLv9bvFy4oIQynbtVd4NbXtsPYp6p1HQVFFKqu/bkJJh9pC?=
 =?us-ascii?Q?+n3OdvEktWRaWTgyzSwTKhF9n050gkaVQc0ijyCvQUrCX9Jpa8NqjjgQxer+?=
 =?us-ascii?Q?ZH+RrpvZ94b5/FwH9ocHHVhkhOxvXOB0PRFZbSVIyrgk02mwEh2hut1nRtcf?=
 =?us-ascii?Q?EioBASbep0t2mYJMxI07v25yHBFA4PE5t2tWT37xTIRgtyTw8YhArRNzJ4wM?=
 =?us-ascii?Q?LNkrHw0imq2slcfDqiiPRLL09Ak6w4PAeEpQ4+kWQgzbShRacymapIcs3bxa?=
 =?us-ascii?Q?a5DhU1IWmHPsZeAqITP7rQNaeljwkTCkMAsNU8hB4sa1YWQane+FoyXgy5Ga?=
 =?us-ascii?Q?8iYa808HUqY9O+7M78dbe01F5+vceN8AhGvC04wTbC8qwbgzECh42lW92NGj?=
 =?us-ascii?Q?D4cexdBtXtckKgGlfsJT4ZV7HtOE537oCAbBRz1yIAcUqOxmzBoJzOtMEg57?=
 =?us-ascii?Q?7kLfIURjt3EJ9dWu66uxeamLKkYkkCQVkJ69ONnwCSC8cqsUovXK6KNzIUiQ?=
 =?us-ascii?Q?Oo+bRgy5S1sK5GIwwaTO28FDifLMmTsZu59AMyKHDGKXMeXnz5ijvlwfoHCG?=
 =?us-ascii?Q?lGy52N3BQORm9U31DQVPE0MXfPmm4WVJMn1AuDnkgzYL7vxsoZffWli4179l?=
 =?us-ascii?Q?snksofeWVwTAOQFePyAXDmrWsaJFsH2KPF+WdHG0dRmoOxhEZoMw8GmnmO/y?=
 =?us-ascii?Q?Pu7w8+LD9100dGYltDmMi/Tsz1J2BmT9WFSgGmq+5gKJ6WxKGLXAcHbaLL3Y?=
 =?us-ascii?Q?f7cBArFojSigFWsDv7DYU1CkHBd3pcUOmPVBXKlmkz4fJDlfllMUMn1GYS2H?=
 =?us-ascii?Q?6x+918At5NHo5mtHrqWtNynAjg8CnYE+Hf7sGHaItl9pBXSxVF8ZBiTx5gKB?=
 =?us-ascii?Q?T+vmgY448GPl8SHJgb4wsVpXnblp+q4vQBbsriZJgMfbb1rwRHRww2XiPjNS?=
 =?us-ascii?Q?PBfTyNMCLIPY14w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:48:50.2750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1495fa-476a-4bb5-b745-08dd4bf2176f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch adds a reset function pointer to the SDMA v4.4.2 page ring
functionality. The new function pointer `reset` is set to
`sdma_v4_4_2_reset_queue`, which is responsible for resetting the SDMA queue.

Changes:
- Add `reset` function pointer to `sdma_v4_4_2_page_ring_funcs`.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 350506b65cb4..b24a1ff5d743 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2155,6 +2155,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = sdma_v4_4_2_reset_queue,
 	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
-- 
2.25.1

