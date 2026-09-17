Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45D7C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 15:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D0C10E519;
	Thu, 17 Sep 2026 15:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TVTBlU6/";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C81510E519
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 15:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlojuhhEBPDSL1xHgK2QpH7iRVaE9x9hip/Fm4unWu3moaKbcQnBhm2ri4lRPV7W+tn0rxVdjK5Se/GpgN4fEYPer03XDV4RwC5usG+Z0wGH3VtdUOGZvlClcEy6V/I1ydCkFMzIAaDGC2SiCOmY0ZBMqkB2H5gPN4OMAp3dZva4w2SaM/GQ2D37D1zjxtd2NiDVC32lIWJUWOFZRzh+Nh5czRv3HSlT/6Romw1X45L+Js01oZbOdyRGvbbp3VBj4RYPMPYIFbkA8b0PR+p+JFKaSUQXYVoI+KU2ASS4OSB4XOXdDdxOV4GXd25xVlZ3QvyjkIne1bSOoMrWlUNGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZeCdQCIjIB/+0ZZ6QyrRMfSlAjLybKvQkYvQRugHWQ=;
 b=yhFBmzCY0uB9gBh1/8GrYZTdxgKBWZTZ20zExKD1k8XQWceIei05L7ycpfaoLF2y7tZZg0DbEp0fL9Y5dW6brLeB3fF4jKOq0vIWpENnm+ImA8cWDeUuGnYkQkhtBrh0BYztv8KJM3DYMEHz9RClJtK68m0ju7ORMr60Psun6Y8GNCUlh9LcVjzdoLMGuylp1nfjtLYMno0foND7S/JoMJjM9SZlA2PY/LZz4VNYZbvxhPuVhNySYI39m0XJNKDmdu/gVNFwOMGq86z6iABdf8SUZjXBsTdiMAcMSoKJVAAnNFhu2dG4MiwAZV0j2vlb1BpqqOMw4eGl1/05L4aITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZeCdQCIjIB/+0ZZ6QyrRMfSlAjLybKvQkYvQRugHWQ=;
 b=TVTBlU6/csah4HeIbCVK4u7p+F0HFEprR6PxdCevmWoJKrQRAbTfvCs1Y007fCyJO5YEo39lr000JYSSeB4zF4M7gDZ2gptqLukvr1Cy5WV63KbxJ353PVum7ct5s2liksKpInNcEKBCZTpioF/e4V4qcXWPlhVK+guAfJmzkBM=
Received: from BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 15:34:12 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6d) by BY3PR05CA0047.outlook.office365.com
 (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 15:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 15:34:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 10:34:08 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 10:34:08 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH v1 0/3] drm/amdgpu: fix userq eviction-fence rearm reservation
Date: Thu, 17 Sep 2026 11:32:03 -0400
Message-ID: <20260917153404.17610-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: e47af265-76cd-4b0f-0c7e-08df14d11e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|6133799003|18002099003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: dM6EQsVBbORc78PR6/3fl8wGBVtZUU4N9pcsyYv2LEyimkrRM2EnPj4hSlzgeHb33e9VMEPo4zcps1iRis4RdA6/KgO5kXIj3EU9tcZne4Q1L1e7Q+uucbTe7V22WUB2xQngY2m6jL+vmy2gBgsTW4s+Wy4OsKqMRHPu04ee+mCr74jNtwuUvEQJKKHfP9Lx9fxkdbP3r5XdvDP28XR6YpyFooMz+Gx7yUynFt/uqo7QgS+/vdGvule4Ia93yZc8eUNcKm8gn87cdkfLAcsAXMQ+o/tSgDwJTLGTP33rtanRsT1oOboLGEdNJ3/ivVQL8s5CiyA2i+fkKTAjyaDePVzUjtd20shH7XekPo3Tih3qA0Dv8DCkUXmv0i7/oHhzdMuJhlpRj4Z8isJ08Rz2PTuXwZZgXke4aUYTPBGGlch/Nv64UNnBtwM4HTV8jLMTyQeav6zZSWObOGc7zwKOXH91odkXFs1sepOXykU/dYxn4iMzKKOOvvnkZsccR5d5/ViWj5mQcYNHRCWDL2sv/KeqQUCFNQ/z+a+Uftzn8VHE/DkcX4eyrXM1UJAPkPoIQU4IobElXbgHH1r7JJBxv1OO4qhDXlhmojYiiCSPHz33+nf9QyEyj2ZUh+SJiFpx4SFRAdWidaRBJ4VoFWy0RocjYjnydQBTxEpKiYEYDCDZ07qs1Z4FBj3rrh9Hw1gpV6dB2xiHUI3Qf1Kwp5oPIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(6133799003)(18002099003)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SetvwbRTUkPm22CzDz7zVN3jY656TPW4EkZ53sFalFr/h2YNhQHZJgeLK8cdCUoIRVUs9JaeQ5ruMNpZYyftvzklv35XliEJ986J+nTYaaKMMXKvX7lVd5A+6dmFIBiWQr4UNeJUCxyly2piMTOaqZkXjMhxYCErLf91a8eMJEQFVhvb/cRRnckJ+QKHA7fa/LJ6WunjZ6wWIRl9UPb68cNP+6cKB7l2GtY232b4Nv3gI5sXNMkTWQ5j2NlysJYjSAovKEL575gwQKAlppSl6i/nWsBPc8xJTbz1t3XyWrQt/t5q2t4+lFpyL2jsX0T+c7sBzKUfeG9Ht8dmPANhoU3H1WiahPbrxOFHHygTdpn0ylSbarvsovap500eDB6D7210dAgU0b+NFO7ffV24/CKHo4fYzq3vXAwKWU+02lYWXDS5ze8YWlLKFQOXR6Cy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:34:09.3710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e47af265-76cd-4b0f-0c7e-08df14d11e12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

During user queue restore, the eviction-fence rearm path can attach a
replacement BOOKKEEP fence after the BO reservation has been unlocked.
Because dma_resv_unlock() discards unused pre-reserved capacity, a BO
with no remaining fences can reach dma_resv_add_fence() with max_fences
equal to zero. This triggers the dma-resv BUG_ON at dma-resv.c:319 and
can crash amdgpu_userq_restore_worker.

The first two patches revert earlier caller-side reservations. The root
PD reservation and the WPTR-caller reservation are no longer required
once the slot is reserved at the operation that actually attaches the
replacement eviction fence. Removing them avoids retaining redundant
fence capacity and keeps the reservation accounting local to the rearm
path.

The third patch reserves one fence slot in amdgpu_evf_mgr_rearm(),
immediately before amdgpu_evf_mgr_attach_fence() is called for each
locked BO. The BO is already held by the drm_exec context, so the
reservation remains valid for dma_resv_add_fence(). The reservation is
kept explicit in the rearm path rather than hidden in the attach helper.

The fix was validated with repeated amd_deadlock runs, including the
userqueue restore reproducer.

Vitaly Prosyak (3):
  Revert "drm/amdgpu: reserve root PD fence slots for userq
    eviction-fence rearm"
  Revert "drm/amdgpu: reserve eviction-fence slot at WPTR caller"
  drm/amdgpu: Reserve eviction fence slot during userq rearm

 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 6 +-----
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         | 3 +--
 3 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.55.0

