Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD386D232D0
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 02:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6118A10E7DB;
	Fri,  9 Jan 2026 02:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZr5YLU2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB4010E7DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 02:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8s4P8tEpAGILXf2GmaJJEciM5Dc1jcDjGbyj4nJ6bZCqodRab+ImX/0hPyi0rKTw5f3G7awsOceU0Nvb5r2Rs/Q4/P7Ikc/+ZBvuVYdkaE9552TNHy6+4ro8M5ehOgVgFmILs0azCTteFtacnezpPSJeEDsJ32v4iID8+fVQNFyGvETWiQTJa0B1Brjj5kBphsq9/IVT6G6/q3woT03PbEb/XN8LC3ijJKhI1NkpRfTBKUYzKLPXsFe+vfzRDQnIkSQjx1lW6vNsTy6Chhw45o5zMdDVpO3wolnFvCw2eTKgtjMG7C9ZhJL//CpHZHbO9OVfIULO0l+s01xwZBy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM/60OVOMAe9Mqq3Oqmi+EB9YG528mJndzxF0ezSix0=;
 b=rsIB/nMHL79DAeF/OTBxe+OcfWhIMfAE2mE5JUmH0m9bQzCf5IxZKXZVrrXWYvKpu/v7eGGf70OFX3v5ddtCe+JUgEAHBtxNaR3FfvGrgy0USdUPGY/JsZtatRyAaHp3ZViOBz3wRnT/VLbwc61CcnNBPhi/kTDWdRZq0tK7Z1Aa+PBmNQNSFt13/rLaAad/sXT/p9Ga8BVNBwDMk0yPqzOi9ept9vXqXZjIVlQXlZ8uKdNo0j+SHB2Ff4V7kU04EuJL3coTE+36KYjJz1ijP4iH88ECOCuDT9zc/lx7NewSTZTkaCrVuTC211S5DsWBWYi3tG5QsUW1xstUC1+vZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM/60OVOMAe9Mqq3Oqmi+EB9YG528mJndzxF0ezSix0=;
 b=BZr5YLU2NdZzsO06oHnH75tcA6UOscXpADYThqmqvJtIBjjCqTYKkrHbY3c5wTQHK0k+y0o68fj9HPYdKCpZ1tA+uHK9dz04Hka1bZrJBM/8xy2yR3sy+uzo0qcVkOVn7zDvoAO6EMHAIgO0Dcd4hO0PRmbhDsjAClStPWbrICM=
Received: from CH0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:610:e5::28)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 02:35:00 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::d2) by CH0PR03CA0263.outlook.office365.com
 (2603:10b6:610:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Fri, 9
 Jan 2026 02:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 02:34:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 20:34:59 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 8 Jan 2026 20:34:52 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix user queue destruction ordering in
 amdgpu_userq_destroy
Date: Fri, 9 Jan 2026 10:34:28 +0800
Message-ID: <20260109023440.4188487-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260109023440.4188487-1-Jesse.Zhang@amd.com>
References: <20260109023440.4188487-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b16a73-3366-4a43-0672-08de4f27af74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TCzZ9T6ccfrgt5ik8nMwo7FA6YQ9pw7mdztRZvjVID6HNdDhlpsbsyZ/sjkH?=
 =?us-ascii?Q?bFRK1jj4n0ShTel2nptnBPWGsIwNaw1kQFwoIX1TsfKBzuNIhRQUbTDsOE2S?=
 =?us-ascii?Q?QRr04DocAhXqO9GmoUlT8h9snhh8lS07fkXQax18/13z8e9FmEMYkr5muB7F?=
 =?us-ascii?Q?1atM3E4oR9z3YunViGSuitgAtm/NsCLho3xB6AeX+eIpq+8fyProDtUtt6VW?=
 =?us-ascii?Q?6KV5U7IZ4Yg3LdTkryLS3kNolP6cRL1WAxHhCm0dSpN8kFcZVdgUf1Ea+Uce?=
 =?us-ascii?Q?NbyqY1DODDGPc9sjeLokEvBObBEytyrLNzSaZAxaKLn1hEZE8w6YMVgjJN/4?=
 =?us-ascii?Q?Kl9bHilfWhdP24znpe2cyYIW/Q5U9NQePubK7n4e6iu9RI0pleku0WbBKu8F?=
 =?us-ascii?Q?AFW6Ne/pFTiXaa+sX/Z/Aq8riUxqf3nvkubij3Z5ROqUtCa5nqbNW0S+4RLR?=
 =?us-ascii?Q?F7DSKAniNxMDUFh1ypKDTURXpN9CENMn2QIMKyU2Oj+jUj7nLav4qBcf/V8o?=
 =?us-ascii?Q?T71bGosuELILH6X1tl+oKuGOUvFL0oeJgS+bsMzc7lMuC09uEeTIHq8Hhqnw?=
 =?us-ascii?Q?Aw0glrW9TVODWOYa0ePXQ8jVM7cMJFuTsriEktAbBDYkPqQ3EFo+odLyPuHM?=
 =?us-ascii?Q?MLDTs7p+bTH4E9KMtS2w5dEdyT1hC1SJuIMGyECn52tmFfH4pfBOOMcC4817?=
 =?us-ascii?Q?XMBbM9Nmc6MoRDCa1W2suxoS+x83wJ6oTNKOkYtTieMDgMVPNZMlCF8Wd353?=
 =?us-ascii?Q?eaKoM9y3aF0zbjZqjqAVes6UQN//74YLvBU3g6lIFG9GPHveG1FwmeWoVuLS?=
 =?us-ascii?Q?X9miC07eQeyy8/mL+TA1WTeIb13NRbLIPVKS1MN6QmnkNZKCwNU0hFL3Ijdc?=
 =?us-ascii?Q?zRKnJR+tJL3YbeIdAIiGXw+M7IDPoExCXvraTGUHwnhjCbDQCDh87sEJ8bDk?=
 =?us-ascii?Q?iSLv4q1mmBMKhoO1GhkAy6zUh7sAgqErb2pBn02l+nzau8sJF6y9lS/ObduU?=
 =?us-ascii?Q?Q6SrrhfzRGCefiDmG7tV3V/wfv4//6HO6MPsL4wtcZQvSTV5KAbzGbS8neRb?=
 =?us-ascii?Q?m6cdOFR/U5C3W/EzCrYhdVZiAM9qCnFnsW7qdIo4mngOp3PfzpQ5B3tF3Ov4?=
 =?us-ascii?Q?jP6643KTLNzcTSy0xv/0j8eb3TrTKhq1hYjDEuhbeEONIaLI5SICUOwldnfm?=
 =?us-ascii?Q?ekm7OKoD2pRc/HsxhZuazKrw7nP177fNprtDZ+LE+Cw5DXm7cEvGQklbOlJ3?=
 =?us-ascii?Q?UOBMYjv6n5wFMIAVe17iup8xoBoyP8gNioYBuN1g4z+30kym9198Wv52lkgg?=
 =?us-ascii?Q?nYhNTZlfgRNXniDXU9PEakYy5hyZ647AifCM29ZBoXwrgoFhzG53NepdCEc+?=
 =?us-ascii?Q?u4mzRkYm8g3CG4Ptc0RpYLsPlV1ISxpYwFRaTGyxySu/H2VdBOc3yj7nKZMn?=
 =?us-ascii?Q?Soy8YDvGfrBQOIUnCmcrsqOujaFK4N2yzX+sdNTfVeDIWd7qkuthV+UX8c6j?=
 =?us-ascii?Q?+qRMNKU74qhPfjqccMuoZmj5igyO3v7u+P4XUKU1Lm1L1bvVsRxdDFjejXYl?=
 =?us-ascii?Q?/VlGly6Hg4GbDRoJ1rI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 02:34:59.8397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b16a73-3366-4a43-0672-08de4f27af74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
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

The queue is being destroyed (entering the `amdgpu_userq_destroy` function).
The counter is decremented prematurely.
The concurrent reset detection in the `amdgpu_userq_detect_and_reset_queues()` function skips this queue type because the counter has already become 0 at this point.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 402307581293..83b85dc0b735 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -612,7 +612,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
 
-	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
@@ -623,6 +622,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
+	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 	amdgpu_userq_cleanup(queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.49.0

