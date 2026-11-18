Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40437606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zxGf4fHk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9EE10E891;
	Wed, 18 Nov 2026 08:05:41 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8CB10E74E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 08:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mor5Axq4pia5UhWMDiA1koI31oU5FCT4DZBK0apmaqauyfmJrFo0uL+5fjqTIWjoaeYDRUDBgerbUavF2ng8e93j3JE80XhQM37bGEeOwJFAy0uMRAWVagL0ozPkh5oZMUJ2nOu5Uv63PKS6Ic3KOFF+eOQxVBWZZDfTInxa54Br3yLrs4t7Z9UkCbUhIq4f8NQPxz4lu9JyGsbeKyj6fckQYt4kglpaA43GBtJUr6Ju5FuJE2Y5OmeD/cS8vcDWZEoUJqww1ty9Na2P+NFo2S+8xvPpCa0kbKdfyrlRenFids1gfI0lqTjV3AVoLQuYdJmws+7DN1N3GJ7BCpriMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXemimZPL6nSconlcpDuKuZs2biETUYGwLuXfR7cnTg=;
 b=AHhxRZhahLeVTLiphn1qat7jmFq/r1g6HIg0kArC/tbplG/ZBYuVx5+nNet6RnaI5eUQQ3RkdWTCNmf5P61KkgDq5/aeJGtR4vRLzLzVizXlyH9mwhQu846sfZ9mvFNCkfbh8kfONZxLgCT/mylEuhn7bZHGMv7clfYuiqkNbFZFc6HIERZ3lj1A2OgT4gsXfJFAjwZxRC26F+B3G6fllZdOfZwDNlhO7gnvZCjwFnXZoKg5H76ZaadJYYYuY4cvQQ1aEuvgCUOTgaPfd7M9OzkQDgnznU7D8nvsA2hzfwvvOmwuWkaHwTU2xetyZf97yWal8dhG0BhwtL/pmtBzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXemimZPL6nSconlcpDuKuZs2biETUYGwLuXfR7cnTg=;
 b=zxGf4fHkpFffSoZNJX/MXZ5VVK1v1cC9BtqYT29lCDwMnJkkTUJFsziZHw3vcIwgfn8+UPjpL9qPVc5yKWZOSySw765tanb+xhFpPw9Rp6AD+epmCYzpdLdP3C3ZH+/olr6KFL4DDeMJx7Dz4Mh/96TSWqYLliSpcEUuyFkwCXc=
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 08:05:31 +0000
Received: from CO1PEPF00018865.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::8a) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 08:05:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018865.mail.protection.outlook.com (10.167.249.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 08:05:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 18 Nov 2026 02:05:28 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 0/4] drm/amdgpu: Add CWSR and second-level trap handler
 support
Date: Wed, 18 Nov 2026 13:35:09 +0530
Message-ID: <20261118080513.1677783-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018865:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 3687aa31-032b-49dd-218e-08df454ab6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|18002099003|261009223027099003|261026140227099003|56012099006|11063799006|261102123227099003|261021121427099003|261028144727099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 4Qq+1IFQkeV/2uug+vYSnl58FYp4JBFyaMuJfYXd4Gb8hAvVdmgOF+Q4jsl+1Dsl2x6AmxrkLm0sY3yGyxEQ5BpEDg0PoO+putDajKtDN+oG8oyh9zPcXRoHK+H+k11XVZbCo/K+aQSJbbNg3w/7pfjriLlKxqYPog8/obAKyuMp4IoKsf6CyFNVRJevS+FrVOsE6jWdYK39t+l63/Xm8QsWRxCuidHcvY7gbGCIhPKzqOA3qTccSAgPleVLy0PyJJXLFctv75Jr9z1mkip9icPdWIm8oAyeWLA3/HwPsg1fnONGdeRJ1goZ5EDuTe5JrurX1xhS7k+yzQq0SoyqV1WKxda7+l//YHGn/dcIX8SF0lvOCl7B77ol1YmLysYj/AlA9DyQOpM3iSypO0S4SuwwWyp23fvNcTgRSSzBdmrbYAep3rPMKGjD+23I/yewCwjEwpWso4+Om5D59XytnJCqpNL049tIomQud+IfNi+qkG5g/HoDkzdqZaBH6mtfC2h2hOU15vB8NAU26Jn8KSFcqtJWlKi7DhffIZoCg4gmk8fyLQwtEvqT9usmodXwjzcjjIDw85fTEmKgrwPZR7R3+vdh7GmeopjPCldCYRr2Gp2SkZbWpRER8sC1xumHjAW/In3vJGc2sgardfQmGPXqx7XCSDs6gresdpUe+7wEy+hpgiSmOf/EREQDsdzTylHBK93BwWOlPmk/i+3LGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(261009223027099003)(261026140227099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261028144727099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8TJ+wTq9UfXCBqDgSDhy8iGpcOZh9c9iMDDeP485PmsUvQzczF5cwFkZpeb/YcbR60dziTqfn8o7uBZr1qxvfG3iAXdZ5iWW8nL60FVqlFsfjeV98wKwEbMMUOs3fGloE88s5tfKoKNS/0rxe4jjDdNTO3lb9l3CDZFZEs9dKAL5WqNbDwJW66T43QFHDKL8otg60tTf/I1kEh4EmizR/KJPgG0uCKSRfB968UgW6V82loCAfIQRheb1WqPUxdDumorkA0lcaIIs63gwb6DQZ6C3/rrxzQUKuUUlIO6bNgd6jw+D9uGfdmZfumyxB2rx2b8JOfnP284/YoA1Puh5ukkCkq6Jd0EPJQhDBp3trC9pzmOm6gGujFCfuS/6GPEnsYCllz/U8ki6vDw2HFeID0tjWcJc8t+bDrNOR1UpM6Vx/XOxyQr7NW0tEao9piTx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:05:30.6768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3687aa31-032b-49dd-218e-08df454ab6e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018865.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes since v5:
- Restored missing trap programming and initialization paths for kernel-managed VMIDs and rebased the series.

Lijo Lazar (1):
  drm/amdgpu: Add CWSR and second-level trap handler infrastructure

Srinivasan Shanmugam (3):
  drm/amdgpu: Make first-level trap state GPUVM-owned
  drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl

 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 771 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    | 148 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  98 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  14 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  28 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  75 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  61 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    |  47 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    |  59 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  55 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  |  55 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  | 107 ++-
 include/uapi/drm/amdgpu_drm.h               |  90 +++
 27 files changed, 1885 insertions(+), 62 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h

-- 
2.34.1

