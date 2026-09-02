Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DE6C624D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7373F10E3FA;
	Wed,  2 Sep 2026 12:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nelcjlNU";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9D110F1C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twmQZZwlO2XM9Ucx6bqM06P+TWSxSVt5KKTuhcmPZG9wQszHPLEkymAYiq6ocdKhIDHH+uq9FGuQu/l+y6dyAg2qVs/6hNKc8UL93Bf5irBhJWvxdwbeLra+ltYKG9w2N1omocwPfBEggsBR6lucsBfZ2lgIhJPeG63GAePblc2yCsSqJmG59AEdCmvgHvTS9rohcS/AXhqy3gJ0UeXGR81H2YZmq97myYPdrqs/WW5c2+hZDDKIOim26HGo8A4znimtbMY8GopqhBdWinaa618OGYz06SOTtqo5NiXVpvcDW2u2SetWGM70XqmDazIYbTY3W57AmhJbWOERzjBAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg0IOv+4/rURdcaBv+myNBzXaEND/51uK1CmSIqqaLI=;
 b=rPKvgxypJHnz5n4cIejHsqFGswNDLFElhd4wS2vfYPXAZgn6Bo9U3nzWCrLsh8/loVBWt66m/CjLz67DFWiSvzgwQKuB6kNzWU/TB3oudYv8XFofVZMXw+eonwOk/T3gdb2d0z/giwcblmfDgwRD9/rJF9SGNqg8nj93NZWpr5OBqR5EJO/B8GOBQCUj0l1iO3FaRRJK6FR6iFRci5HR+NRtJy/u1vsND4eGKzS1G3nz0bvfR/3zMOsZ42JkGEz8iHS7nFXZ+yrzdsM5yMIBqAt+H+POiFPP/GcoGuDs/o0mgCtZG6rZGd3yPVS4KjDUnecHsAJH/BtV5+VQnLQACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg0IOv+4/rURdcaBv+myNBzXaEND/51uK1CmSIqqaLI=;
 b=nelcjlNUabaW3dCm2PEOyU6p/avoP8u+upL/deDmy+l0duzrdlb14Pq8oMV6ZJ6j0UTBo9ob8sAj+zoNd39hR0UEE6O6gpEUX1sexy2ZsY2PfjfnhlrRNnnct8Re7GBCJS5l6EId7WSh49va8BXTr5nipW722Ciil9mIMA9UOec=
Received: from SJ0PR03CA0141.namprd03.prod.outlook.com (2603:10b6:a03:33c::26)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:22 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::86) by SJ0PR03CA0141.outlook.office365.com
 (2603:10b6:a03:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 12:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 03/18] drm/amdgpu: remove drm_client suspend-resume in the gpu
 recovery
Date: Wed, 2 Sep 2026 20:49:46 +0800
Message-ID: <20260902125001.621629-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: c50014aa-6fe9-46b9-d869-08df08f0c05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vo2ZazeW+a+8tRnkZnF6dLO6wU5DKciaSEgfVre8ZDu032N0w2Y0QH1Z5exrrar3IKx+0ylsMbBPV3cIRg8d51xUmfvnYMc1Gv1NhtTl0bNI48DpgtfWdA9vJxHw0EijDwT27p2XiDLvowrwhbJnQegWAN2d15OING1swcRsOmE0w8KQN9SQFNAj7O0/euNN2i+lQMW8guZsfxvt3KxP6+NaNOWOx8hyLpCCXAa0Hh3Krt8L3ot6sSpaqaj0GxF9U93+M7iem2Lv+/BHmjQSkO3x4QrAIHWEMctqbIqWW6FRZTwhJ8wDGcWy2zvAwbl8loTKAh7jXLvb/QIqhtZtV9zYA0XyDGYkmbI6is22LlEIxTnWg1bt7kjSgccC/wASLwf7lbCQQfOMUYQqcSkCEXPeGKjt1HRr+v/NCH9nAmTvPalJbMuszuxBCQ27T2bqTQVlvuratjnqstOHkfnkKhbteVT4eI+dfPEJxx85fzeGlI09LHVMXCjHV91hNSCLsXgs9fWt93TEJeoEs4WkXsoVwmfmT3FtY8sPKh/FgwbgCW6ofu+d30U1HCUqqgHZbOorWyHvga9grrH2GS6o6nh0oebB1H8qbp076hYyjybenE3z30G9LIRKYlqmv+eov/JFBY2uXRFQlfl9motblOeNFDNR2wbYRBZ6AaB6FMBQsf3sgu2ATmQJl3ULwSyCqFQrJO6UXZRqmEaf/V8rHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LcraSzPlqMwoGli1bBtxa2p9wta38lWsfVGpzrCwTDWpSxMeXmPlbgu80p9IKp6xQijlxaOA2iitn27NjCCJzX6YEM7UR8sh5Hs1Adwl+73x2CHFvEZujUaPwqidrThoDA6HH5sSUcEbYEH0NLGas2EKVnWF+Gk4QOqVGKd9dky9lEr+jG5UJj79qIEGJ/GB367n/CInIQlDRD6DXreOm90DEGqQ56XOsVJwDLeOPXNWfycf3Wry/dNDwCuOKgEaCFyObXypbSPVIJDBND3XMu9TQpN5h6XUGsPThaslhqNxNOvi+J9O7AJpDAqU8g6miOq/bNAFIVZ6sAh7MQzoLgmmWQy9chO7nkYEKb9rjNVjtPjAwakFIIYygIaYF2ICMpsB2JETrfSdmrozLzqaw/tBReRwymw68HVAq1rpvurtp3DLeANCA5F/72YRZCkT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:22.1104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50014aa-6fe9-46b9-d869-08df08f0c05c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206
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

Suspend the drm internal clients has a deadlock risk as acquiring
it while holding the reset domain lock inverts the ordering
established elsewhere (clientlist_mutex -> ... -> reset_domain->sem).

Reset AMDGPU can prevent the user space clients further accessing by
using the reset semaphore, so removing the drm_client_dev_suspend() |
resume() in the reset path.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d7640da9f6de..bd4eb97336b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5210,8 +5210,6 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
-				drm_client_dev_resume(adev_to_drm(tmp_adev));
-
 				/*
 				 * The GPU enters bad state once faulty pages
 				 * by ECC has reached the threshold, and ras
@@ -5544,8 +5542,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		 */
 		amdgpu_unregister_gpu_instance(tmp_adev);
 
-		drm_client_dev_suspend(adev_to_drm(tmp_adev));
-
 		/* disable ras on ALL IPs */
 		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
 			amdgpu_ras_suspend(tmp_adev);
-- 
2.34.1

