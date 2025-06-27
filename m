Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAF7C83029
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF84B10E958;
	Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="akxyOw1H";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DAF10E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mT2kZ/bJgi/TdNT5JEs2iaNFHVmZC2gldQUkZkXXk/ogUbg4uezMsoSb5I+xw3GuvYEPUQEayLuNbAcI5uRfRm74L27RRW2aCBS2hbu2F7cAjEPl1B5tjW6O3NBMwG1AIui6DQtUVXtrF7dIEyuR7KFXHjvpFu/E0P/i9P3iSYXdynvY6HrhtEceVZiFMqIVFL2tiiUHCuz7yW/xxqGSygAK9eLRBsMiahDwcIEGsUFmcrjNSqOT8xA105cSMcIYbYb7t103vKG2zUXTCjCouBD75UBD/UoNQZGxB93nGJP+GRAszpMI1lSMVuItXnczYZDOCol5igQBQA1V1SS05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEfvl7gBfYyZ9t2ZhvSSlRj664kmzFOWlLW5L3oy29A=;
 b=ZAtSHmA6wYryB0n7Pa7Eng3KQVLYv8mEd5sdamlvOmB6H3oOTSEv4izQU3i2S+VPHDLAsI9UZoYiVly5HQ0666H0vCVHs6MVc3VfV/QIaBH3uLSXeJYvdXOeki7x48fVhJEfVHG5KhRZMFCrAcaD9c3q5yVdCcMKa3XZd3dtUF7bNCxOfm1c5FzwSKn9crZ6hN6Ml6Lw30c6imE+hniD6MQnilR1XOpPuFezOZok9/PXtVAFDWQhRRILTFeU7lvIuaCJeIetcxb6sG7TplJJLo+aQh5D0YlbD6wFugPjNido0Bm7KabRitnUofHFDBKFOUXScu87uOJxAQjiwpP0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEfvl7gBfYyZ9t2ZhvSSlRj664kmzFOWlLW5L3oy29A=;
 b=akxyOw1H4smbaA6vtjhBEruZ4TymHzuWzVBvov2KDo1f9QJ+6izxRyaGzWc2pAqbHDYT3A76kHxNcC79/s4Aq1lI6ZN82nKuyKeQOagk5s90Z6P2GX8tVBGBB8uxv5nedsq1Gt0NJ7nhPWSqIgjXqUh+iTiItzQStG0QkhnOMRI=
Received: from MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 03:40:37 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::b6) by MN2PR08CA0006.outlook.office365.com
 (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 03:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 23/33] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Thu, 26 Jun 2025 23:39:52 -0400
Message-ID: <20250627034002.5590-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaebb40-646f-49c2-0f0a-08ddb52c6112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jfalTOibngSTYTCBlR9N3LpV0z5/BxjlPW5aDN65isaCysBPCU8whGCokz+d?=
 =?us-ascii?Q?d5XAf5YnhKFTQ0LrY44tybAdDg8BqdZp9yxRxXqvI4N1eoZZTsBwhWD/JYqb?=
 =?us-ascii?Q?HDmM4rd1Oc5ZU77w6KCAnTh4WC/t+Ya/SPSOZYiVq+wJpmA7nF/+PQelw85y?=
 =?us-ascii?Q?rvRlsrl9O9Su+WosrCArUF9i/DtqqeO4oS4K5UOrWSlWqqqvTlTBs+Zi6zr8?=
 =?us-ascii?Q?+chbt+ZFsxGM2DH5RH653V0si7T1yGWcxV6B9MN754N63mFW6Qd1+3ZZtPjc?=
 =?us-ascii?Q?ZRVWPQuCtERyMywa2+uPpibwy1D0UoldBX9snOYcpp46f5e7CiLklhP6r+U8?=
 =?us-ascii?Q?Z2iqWksPIC8ffM7O7lJlZ3LxvNecxxgO9jYFbKOa+aInbi0YiUFqev7aNHNS?=
 =?us-ascii?Q?09s6w3fzI2QbEjLmdIOHXAw6udQMWyA0FZFcx+PIvf8xI2LQDvqPKfoNykND?=
 =?us-ascii?Q?lhyIOW2EmmFKQvDvdLMlCOKiq7LcJ92Gi71q4aR0uxxtAdmT8eyxEqlLCDeO?=
 =?us-ascii?Q?KNXLA6z99VT9CHsyY92MlCwYc732/+rOKRSgg/jdpm0+5ahohtP1W/SoJ3xv?=
 =?us-ascii?Q?1jv87iEv/DQbNIg+u5I7oRbI06y2qkouqTBa7aEODWZs8ZP4fmEEAbFgAPgF?=
 =?us-ascii?Q?Qt1PfC2eeg2QoG1kkNgUWNm4ngoBN+UKkkxX1pAg1nEL2/cxc2ltJeIM5M+g?=
 =?us-ascii?Q?v4F3v9Uy2vaYDxX/+NWfK96LkO/etSmNhdUbAO8595lxvHDIMRXccrEPO2Z+?=
 =?us-ascii?Q?BfVN6gvtBVsgwsbroO8LHPqc0vsVTlAAJwJZgVgvqtAOhckalGwljdnDefZE?=
 =?us-ascii?Q?PQ3996l7s9v0EDS2XIWtDAvwpJ7UK1GVb81Zvpfz9/2AaZhQ0kvAryT8+Nqb?=
 =?us-ascii?Q?pGiVU5452LX7g/WTo7FDTSc2D6/HjKXL32BoVlc4KO61B1h5PBsuv/gWH+eD?=
 =?us-ascii?Q?9MmuJnThAnOw+XUaYK2PelD34oVmo1BU4VYgtWiHN5AT3xlnjWDf3zOfXXA5?=
 =?us-ascii?Q?eETOlDJoU0rxe/cHHEB75zLQyW8NP3EF9JXForYVP+vmRFkHCWyFbNx0oFUu?=
 =?us-ascii?Q?jIGJZMo8bp779i1LVFEGJKqan9zFxCwotD2qAmTrOnzUpFsoVB3DGPCIyQWZ?=
 =?us-ascii?Q?O21fEIHVJuhGyetAgQhwcIvejw3qtmXRK4yxFOtdhIJEOE1uZNHQPmGOSLp+?=
 =?us-ascii?Q?2N8w2B6tuXuJDXlnZ8yHqXimuIjKVl7rx+V2Ztw6lTtfGyMQ7GgidfmLsyyY?=
 =?us-ascii?Q?TwoGCc1tr+7VJlWMoaw2NA+cuGkntrLk396SULQR3qcthOlCGDJkaDUo5AtM?=
 =?us-ascii?Q?YB5sJB1cIB5+Pu63PHKWqwHNYMkur0Y2roKkNvVU8R1NGKzI6wnXFSHKzCCG?=
 =?us-ascii?Q?chcV81SJgaDQuNI/PCMPR+mgj7Wr9Lkjv3CB4eLbFTk/Z1QuDxs8oLSGT+yH?=
 =?us-ascii?Q?jfQ2lEALO8/mZhB4WJ/hj9pB+1Vk6V3ipefQ6XmmiT0MU525F0WLo3M1vN4t?=
 =?us-ascii?Q?7esAJFv2bQ8gO3aE5xYEvSWG6BYknH3Huqzn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:36.7800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaebb40-646f-49c2-0f0a-08ddb52c6112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

Add queue reset support for jpeg 4.0.5.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..e6e90496135b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -767,6 +767,16 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	jpeg_v4_0_5_stop(ring->adev);
+	jpeg_v4_0_5_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +822,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

