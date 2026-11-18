Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF549606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rrSpHYZ7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900FF10FF68;
	Wed, 18 Nov 2026 18:53:03 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C4C10FF68
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R924djJS4YiQmpxsY4pdPEmoct277DvMI4kd8j803yY0in8sw9FABggjsMwRB+TdNvEFYMoIbQI80929A/bJiuORT94biNQBo3qTGTbjMkXnvPdisfmUVNX+5jAE8s1Wts2yaPKOTJAWvxC+lvjEX6pId6IF/2kKgn/f2qCBj9PZSq0/lidXbJkWSCBbZYUznJPtGI12e33m7JgLESKpnXRZBzAWapbruu+mOdE0BYs6k4E8TkR+v5mQ2DjTW+8O79V+PQiTsQkCSSB50rEqTQ7Hnm4v+WuAVI0/r9VPQqo+SnEJk2l80zh07XYPnnEMscH32dcoUcGAUCAwlfuayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s55WL9WZtnLSveU2N654FwOZnG82wQ0CjZRUSG1zV9s=;
 b=vJTy5Fa3Sn0zE2zkrkBxY8T7cxWuOulK27GNihb55u0ZcP+ac14d8Mc+s8P7JzcL5hyuwJ6CnyqB92OigvR61hginKhVVo1zN0hnsSxVXWluE4v8DrbjN/e3+SdpGaWXsiAsbkI477Qp13nLoldqY4Yu+i6g0oeN4WsyjFoDM76fh4NeWruZB8Gwpou526YQ6nqs0Duh4Kfhb8/vSLdOK1t4mW5fjqAjctfOqOPpPL+oFPHrsMogJfHDKG5t7cqwVTtb0gRfDGRW148NOtD9MamvemyabKlejIatM3UR9A8uLpYsdGIgMiNoNKTI1unl+rEn2JOQo8J7RrN8VqIlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s55WL9WZtnLSveU2N654FwOZnG82wQ0CjZRUSG1zV9s=;
 b=rrSpHYZ7yzsluccmIkkIVST/VaCMagWA3FTGMNrbrt+KBHxBPc0I9m8Q3B6eqwQv+rWsltgpHRQhipCN+hmOYT6+JgY/RRRlEC1k5TSjskoi1Sph4if3GUC7PcBx3wkGGUhOGYnfoxFUiZMKYDm3eGgELINYTaxxBhnvEjgCZTQ=
Received: from CH2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:610:51::21)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:38 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::35) by CH2PR15CA0011.outlook.office365.com
 (2603:10b6:610:51::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 18:52:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:37 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:37 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 0/8] Consolidate and fix root PD fence resverations
Date: Wed, 18 Nov 2026 13:52:17 -0500
Message-ID: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea77663-4e40-4bbf-e6c6-08df45a51dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|261102123227099003|56012099006|261026121527099003|11063799006|10067099003|261021123027099003|261021121427099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: sbYXZraejMiFERNYiEMXK0+IUg1B+VGZG6UbS+lUJEWPgcPIBvLVRVT+s+fBj3vghwLvrmO73X6uHBGN1Wy05pO0XCiKsx9B6Q1Eb66HzOdQd8pXUWJAC6sa7H89DeWJ/4yBTJelQ5HWk9tQucXf7AqbSb8R5vCaJlqs2tGmgjNEdg6zeBrCfODvY/wNZ1OvjbxlvbhZpihnbk9xJubSiotUdQAuHZ03jNcNQVVHEpNGrROr+HIuspkjU6pVNKdJ+EkKzhVQfWFFnbKBLKLEusqNRcdGFlg1hiVBQoqgEC5sjzMFSdUXCO7fQVEW6Lc+UQBy+v6Qkxb24srZUG5yy4TTvR5Gy9xSqPdqE84R1PmNnC9jJ4IM6Y6Zt1ViVuXXdDIj+jz4EYu/OUTvkUAB3VD0qhLGefhz/hRJJp7JWxarW6qbeL7aG/EBlxI62PQCLA9wYnKvAkZZHpShxv2rmWErJj8cyg69ILwx3vRlpQ0uRJuikS0FwEl9xlVaQT/xmrdRpyBTIzqOqt8+mQPdQXtV8Rcl4bliTDSc3DjvXQSkIl2CDPHAlom5h60qZdfG7im6HGjwcDhCgXUJ2qfusx33r7BxAId+95w6n2P2hU0plafcUOKNjTUEYySXS/ZIio8gwtAhoysv/aPO+30QztWt8fC5a+r5mhIV9DSubF4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(261102123227099003)(56012099006)(261026121527099003)(11063799006)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: puh0P5eSt6ROzRc4n64XhBTbIiecf5TLG6gEoedIOW4EJd5k8ey0hI3yAnw5CBqRXDfmCIA40C8hhy1n7g6Dj+Upj3RAJmk8PUlabfeQOIBYTRn1Ai7MBoeabO9tbjkJAFs2rslkub9//YhERCU0aCf7oreO079DmkzwRZrIr+dcT9rUQ1CMShQb1lUbX6B9G03OCd/eSiKByNF/VuQoqC2IrZzW7ozpU92Srv1b+5A0dzmlq4p42Qwmq8mNwyTWQGOr9CH6tX4QCIjFWW/R0Me6OIdCJ0yl929jZiM2oOazG8UHa837IzQyy9bEeskQMmp2wWvPcgIS/lQg+td8XEFQ00FXIQdH+TcGBPHbt4/WcWgQB8YsO9oi5/LVGPW7dV5IQKuQTo1WOgFxgnxBT5rRSoh63C/Dxz9HFXtv7Dm3FYHKx17D/CJefzO5r/GA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:38.2014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea77663-4e40-4bbf-e6c6-08df45a51dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

In [1] I originally wanted to just stop using amdgpu_bo_fence. However
while attempting to address Christian's comment about reserving the
fences upfront when the PD is locked, I realized that there are many
places that are not reserving enough fences in the worst-case.

I went through and audited every lock of the VM root PD and I think I
have caught everything missing fence reservations in this series. I
have lightly tested this and didn't see any issues, and in general
this is reserving more fences than the typical case so it shouldn't
cause any BUG_ONs.

Patch 1 through 3 here are the reservation fixes. Basically since we
started enabling more clear/move entities to be used, we should be
reserving the worst-case space upfront. Also when the TLB flush fence
was added we did not add reserve space for it.

Patch 4 and 5 are cleanups that I found (not everywhere locking the PD
does validation or VM updates), and patches 6 through 8 are the
amdgpu_bo_fence() removal series from [1].

[1]: https://lore.kernel.org/amd-gfx/20261112164408.1748006-1-benjamin.cheng@amd.com/

Benjamin Cheng (8):
  drm/amdgpu/vm: reserve more fences in amdgpu_vm_lock_pd
  drm/amdgpu/dma_buf: reserve AMDGPU_VM_UPDATE_FENCES for move_notify
  drm/amdgpu/vm: reserve AMDGPU_VM_UPDATE_FENCES for handle_fault
  drm/amdgpu: reserve only what the caller asks for in lock_pd
  drm/amdgpu/userq: remove extra fence request when locking PD
  drm/amdgpu/vm: stop using amdgpu_bo_fence
  drm/amdgpu/uvd: stop using amdgpu_bo_fence
  drm/amdgpu/object: get rid of amdgpu_bo_fence

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 13 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 25 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 12 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  6 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       | 17 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 14 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  3 ++-
 14 files changed, 58 insertions(+), 56 deletions(-)

-- 
2.56.1

