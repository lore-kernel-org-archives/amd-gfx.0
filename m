Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14CEC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 14:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547FA10E61D;
	Thu, 20 Mar 2025 14:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aefls4ef";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC99710E61D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 14:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suiqoAyQIw43Ztc2ofBrxOxpcwDFF7l6r0okMLCc1QvtRM42l340PvQTxRUPVs8+Xj7PkxR6Kccw+CQ2iQQN8+DPu+eLtt79y8AvjxFo635aHBQGhBzCuLywFwfdTHPjN9KVz3QoLd9xJNLFqF/Hj5OVOfFtWc30qCeNIuHcltMQDYltJLWxUi9pg2MhLiG8nVliq1a8N8tEW/fkSeIvH3iXC5bucSqwK7HLSCXkz/w83fenWZ6Ubt2PyaDUG+2Hk4U2DaP4qoVoZFMI4XbyhU/8ESD2Cx3WCn+ZS2WIoPd6nW6kTWthbP0h2oc2h65L2ePRHKsW5oeReZ5E5/5pQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=long6QrpV8D5nA68KoC7wAeo5106Jkru8QIC9YxzWiI=;
 b=xjN9qlNW2n/w9qMB5CKAwYcwr7c1cKbXfDdkXcdu/5Iwbcr1r6Mftu5nHQK8RntwsqdIZWA7fYWkNAJGycM0v1fGNTSdEeVwRJaJFY+ry4rjRLqH2oxWmni5JFFcc5PhbsbkqZLRNEtCm0kzOZU100IrSlMgQHGUOKxshgtwR/X2dPtD1Li2AmCYmHXvp8/oN/tj5nPvHvgC8BlQ8ijVfl2GVzAmclU+9h0mWuNrIeBZ8hISlMp6aGWwKa9qbteIlKGrW1ml3lNBHJh5vkJP0eGl77K2a9SYuSuDF00gKdYs/ttAZ7x9VcL9WiNPvkjo+DBpzyNJePeLFLI6Kbn/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=long6QrpV8D5nA68KoC7wAeo5106Jkru8QIC9YxzWiI=;
 b=aefls4efzQyogccNtxC8HM+PYW4rTYsx6RDGquHheQyVsfdW83g5C4m2QdVi3whtgAVlyRhQat8Pil5LtRMRZYR3nawgKx46SWrHtQRtzTnJs4gsnTv7UEencOFfz8c6o1cl4taZFMP7/zurMrHgoofmvV7Gpc+r1qH22dzmxMI=
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:23:23 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:dd:cafe::f) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 14:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 14:23:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 09:23:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes: enable compute pipes across all MEC
Date: Thu, 20 Mar 2025 10:23:04 -0400
Message-ID: <20250320142306.1135063-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fa0516-ef50-4572-86b7-08dd67bac4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mQcC0lsTnJCDRdkpCKboVHOOTekjVixwphiRzdN4ol8OqZF9UcnJ0rLNtVZL?=
 =?us-ascii?Q?FGMMOZVikhea1C8L0cC9u8A2kusPtHPfod52uITZnyUIgJkjb6foat6ljfES?=
 =?us-ascii?Q?bhf2XmjQHzMB86Yb5L3zB89hmO7XCxSAkw3HDGKDgvQDmpP/XT//9m/mJiNZ?=
 =?us-ascii?Q?aUpyQ0CHg/QCz+3wPSUbEsMaUK5bLzDywdaZFyzYegxUWz1O2PewLXdE7EdO?=
 =?us-ascii?Q?ibxJ1R1qtRvEfHWb8BKLDFaMktOAqEWIrvlVmTU+jQxendwAfAuMYQaQnC92?=
 =?us-ascii?Q?jAv8KLru4J1ioirzsqxSiKJTAmNoNO9P0hQCZbBOrcrQ8XnHFrY80ln2kd8A?=
 =?us-ascii?Q?1fJcGRWVZ+pcSYSCtMaGg20sNaHF8Y2Dv1jy4q7aJtZxPwCWxrZnQLD96+bf?=
 =?us-ascii?Q?u0BM/Tuh0RpmVlpDaNjJyPIcZBMCQ8kBNkoj/NufmAvtf910Cm71diTf9Zif?=
 =?us-ascii?Q?3+0FKs5w5rj5SrjkcLOhqAq+gHqqgbpocCx7JW/juHq8CDv491uE3RNcqRxu?=
 =?us-ascii?Q?k4GDxbWmNNSYu5nfKA4cpi1IS8eQSDaJHGIo/0zV2tGqaxTWqNNBiBt0+nRd?=
 =?us-ascii?Q?KMu4SY+OMTtAO4c7+Q1SNBxwgGQwzpDbC8PxFP1KwhqOTTaAMQZeX9oKMQWN?=
 =?us-ascii?Q?vDpfvgNxgbEprJ5fcfpdfi+jJ4jjJE5/9mh6GmVtCXGoX6ZBHhu9hXHUYGC3?=
 =?us-ascii?Q?/NIuxMZTecTf4w8PKTP34MqIUDmmATu374yv09dDf5pd4csYgsC7THINO+Ta?=
 =?us-ascii?Q?/fQhADgAds+tbB56QzMqm+0dDQcNW27Y78hYIuS3g21fjGg5OJd09wRkmtHg?=
 =?us-ascii?Q?lRFFWkV1CAhMjaB6/DBQ9/2Lr/dY8/A4ArHint/dqGGVKAgjibKL9UMof4cg?=
 =?us-ascii?Q?Zj5+x27VRRrutVgXIhgdh1W2ycQSX5PNUjDXidePwGnZ1kxzXgolQKn/aF5D?=
 =?us-ascii?Q?VU4XSsyvODr4LBFSgZe/ut4s6wzatNXdfJB444eS/ZAfGkNmDZxXohjIv1Ez?=
 =?us-ascii?Q?vTBAKSNk1EkiNYNzbuPQBcxus8I8J1TF4Cr9C4Ul9AlCOOsrJyG2fjaygneI?=
 =?us-ascii?Q?ofOZUfJsxp5cxc+z5COdjCK6VkzqznwoZWSmb06cqGdzzN5LNyprd6zqEvTm?=
 =?us-ascii?Q?T/w1vO3riQPDSqb1vqYoHyxfloFx/WeXAp1TCN+JxjRXtKXr8nbLprScYZPw?=
 =?us-ascii?Q?ILaUAo+kGVNBCNQdRi+XH7nSZf2GhomeF2fYZ3iWz2aRFZ06/nbLoAHZU4gh?=
 =?us-ascii?Q?Sz1JuM/83iz2jU+T870R48CFS27ebAfWuVA0K8e/AySM8202NvVg+oJZ6dUE?=
 =?us-ascii?Q?PxVw3IEDVBQYgwu8BJMyt8yohW1sLVLkCjbyFb3OC4HiUmTg7EWvIXkdWMY0?=
 =?us-ascii?Q?h/fJpadHA6EzWSmz0lL8H6NzDsm6XRlfJRKcSmkYBe2rlFAo76mgTqjNRf5c?=
 =?us-ascii?Q?WkWt+/cIaHGN0ALlwAF4PlFlzRi/53AKFXUiqq3Ip14VNiEGh78l0hrCo0VC?=
 =?us-ascii?Q?A2Kwur1Ls1IKnk4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:23:22.0051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fa0516-ef50-4572-86b7-08dd67bac4e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

Enable pipes on both MECs for MES.

Fixes: 745f46b6a99f ("drm/amdgpu: enable mes v12 self test")
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6b2842de4ad87..fddec5d1f2444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -130,8 +130,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-		/* use only 1st MEC pipes */
-		if (i >= adev->gfx.mec.num_pipe_per_mec)
+		if (i >= (adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec))
 			break;
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
-- 
2.49.0

