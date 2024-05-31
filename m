Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0851EC25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 02:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF5710E1F1;
	Fri, 31 May 2024 02:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sABKc+e0";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB0110E1F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 02:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPSPtNeX+k+wwm3rKmPFbIkGemwbVA3nZp03dUKunJDvwpZIozoFuupGyPh7qJrjiLEZWsWbMlKabNLd81yQsEckc5yisdigj75Ffi93r+RezVLYTIW1DzteqxaKadyqXGB6BGszel1unFCAG0IcpQJbG115y5Iqlh7SYSGop64zcpvL143BV+tVT83FxiDO0+8ayVSDla7YI8K+ApAAVmHv9t2JzL6AhMpuQmt/Xr/640dXJ8S2m+wI7IcbxcP4fzghoUFhJXaF+LFkmU4+0x09ct9/zPMyBMZhQeFzxxzMTuqP6JjovUZ6aycSTdv5dDyB/NI9nx2CCTy6YF0OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L76i1i7vi7IOO87Gjxi/OHerRHdTfx+cUwzjU8qM/A=;
 b=CI1ZmebJ7Tyqo9sF7Fw5IxlZKwCzVl5ocQamDIOYkIvfzjlbV12IhDzadebuhHg9+0dZB5wA4WeMCnLnITXxT5FeNOlMP1G/63p51UpB1HhffSO90fFNFinF5i2WKHZ2I1f7Qn5z/Nx3rDWZnqRAIL8gqkhyyHXGEJMt276HXv6+pTrRV3aXwJFeLTnIG9neq2mFCcZHYpEfRpyLUdeMSSlolxgctTNwT8aqvbseMd0TddZGukfwrPmCgRAhPhKdAjFQXZ0+Rg/Y9qkc6+r2LDZgWxjXXja1OvkLjhLpUsH+nDpHJlR743/LJoJaR+CzcUZtG2xhGBeZ8bkFLae0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L76i1i7vi7IOO87Gjxi/OHerRHdTfx+cUwzjU8qM/A=;
 b=sABKc+e0RNQdOdG52NWhjT9jseA3tmZbl4d7CRXnO/3bvSrpOFSX/8/S6tounkhtDJaVH0zUF18hMWS/OoxmFCU6jNje+seC+I7U0dWvn30TiIRGbzlw5CVElvSEt9gWelIWDsbYhyNEuMMrNIe5Qq22SwJxvp4CuWqSYjqGTQ4=
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 02:51:19 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::69) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Fri, 31 May 2024 02:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 02:51:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 21:51:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 21:51:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 21:51:11 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/8] drm/amdkfd: fix the kdf debugger issue
Date: Fri, 31 May 2024 10:51:05 +0800
Message-ID: <20240531025105.2456989-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: f6874ac0-adbc-4b23-fd2e-08dc811c8c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5JVpPKrLnj6ytk6pDaBv5cGc6sVdqC+r2x7XhTooEnJd4yJfH+1nGq0c+s6j?=
 =?us-ascii?Q?Ub45pVA61gFPtLQh9kT38mveBUTKXFqAz8AilkKRk+ccxTlXWDPRvZoLRsV6?=
 =?us-ascii?Q?GpIQw8Iq8TtK+5kQ6898DVv2tjocJ2anpBTHIRTHVOo8IFkEwSX/OhyUUBUj?=
 =?us-ascii?Q?aXPv6nz5NW1EewiTNBkPkGYAp1jBe6rlmpYWwXX36mXI3ra4dxtZ38/lFOMv?=
 =?us-ascii?Q?mBnbN8Q/EtgabYD3QCb+o71huTm16V5C+umj9oLTkLpFj6OBDOVsZcy5wDb1?=
 =?us-ascii?Q?5PgFhi7ivJ2n+U+2zu/qz5amoS9cbdoOP/tpcasJ0eog1m6hqUGKo6E4bvMa?=
 =?us-ascii?Q?TYgxgKrmRAOVA9OogzrWQ+zxPcTL4NSIKeLVhhkLFr40tXAaFXPXALHQ5NI3?=
 =?us-ascii?Q?K6uH3egFy4LBgqFAyLrMZ8j2Y+93OzdK+wqAQgWwmtHI+uBjiNRN6gP/X4+X?=
 =?us-ascii?Q?k3feIWBXj9UlnwN2vs9U4iHe+ypoIrVfUZNQFWdtGPGCDRq6g6VYY21VVlmR?=
 =?us-ascii?Q?wO8pzxMoY1BaNu7mhN2e634wMKcHowzopTQ475Ch6YOOxJbCNOS4QdjoYm/q?=
 =?us-ascii?Q?LquQpgxbXodzz6JAqt8BuS2JFTmwF3d8O8phg/FO7za8Rt0dUbjZqC3cms13?=
 =?us-ascii?Q?fiBTVqhEKsUwTfTDeCTH+nrTmPLgLAzQM6SzGY2eR0nvDtBz6kkXBV45Anxs?=
 =?us-ascii?Q?Diy2JhN3f1lf6LrLP9av49sUb+kFBi4qoE9kozC1YbdRcWi53+vAh7qTIUVi?=
 =?us-ascii?Q?wexr9B4lnlgfkj3rqUIoNMq4YhX0P4m58gk+a7D82tnvxjE8/Ksajqi37MeQ?=
 =?us-ascii?Q?3HCbKocj2DZxfKzdaZ798JaDUaYFLPm3FiBM9Bkfbl+vjD6OkGqyhJlYQ9jZ?=
 =?us-ascii?Q?NLnoLlruYqb1rzacHet2Qoyg7yXCaI+M1d9Lq6q6Tzn0FSFzyyafzA8t29qZ?=
 =?us-ascii?Q?nZM7aW5BFzUUCmtl7e+4RgUmhmcfz+fHF2hed1q4HZtBg7nC9FVi9KyZ5VjR?=
 =?us-ascii?Q?6jvanXEUsTByJ6XfnwL5M22Rq5OZG8Vgui1QajnmSypCKGtyU1GkFRWuiu/l?=
 =?us-ascii?Q?XHuVk3H/9LQqHiPfypzMcwuzRRmKxnbEns3VqLDMJE429BHxqDEwx6D7Vf2i?=
 =?us-ascii?Q?LmraXD6GcBhI1r/NIYECW1O6zmaYK+RVISPzrF2rsEKrf0A0ueNHNbbqzQI7?=
 =?us-ascii?Q?7Srdj71Uobl6fIB9hEmFM/fBBouFsfDZGHuzQkR8roQKIidpXCdPG4JaQV65?=
 =?us-ascii?Q?ShNQe3WtMjLx4jVBpCML2kDgyU3FVnVYTtDcRP8oQX3O8KEXbdM7LdSvVX7c?=
 =?us-ascii?Q?OoT5BNTWyX5nRvydJnBYhMhVW/3jsWXb83Z/yhHNLupUM/dum9qig9KacOW3?=
 =?us-ascii?Q?K+FcEljrTDnLT9UZ90Fvn27uQUt4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 02:51:19.4989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6874ac0-adbc-4b23-fd2e-08dc811c8c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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

The expression caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED
and  caps | HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED
are always 1/true regardless of the values of its operand.

Fixes: 75de8428c3d632 ("drm/amdkfd: enable single alu ops for gfx12")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 3f27bab7a502..34a282540c7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -503,13 +503,13 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 				kfd_topology_device_by_id(target->pdds[i]->dev->id);
 		uint32_t caps = topo_dev->node_props.capability;
 
-		if (!(caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
+		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
 			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
 			*flags = prev_flags;
 			return -EACCES;
 		}
 
-		if (!(caps | HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
+		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
 		    (*flags & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
 			*flags = prev_flags;
 			return -EACCES;
-- 
2.25.1

