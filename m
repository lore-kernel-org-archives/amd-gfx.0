Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE35F94CA0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD1110E8EC;
	Tue, 21 Apr 2026 17:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sNtd/FQt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012028.outbound.protection.outlook.com
 [40.107.200.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886B810E90F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gk4VnP2qsYaWVffR4NIZFEq1E1fqLGNfL7Qvldfo3EAdze8ozrFkx7/tqkdqCkBH/t/C+crGsa+4Zbn0Uw3q1vJ6cbx/rsyXH1OqCj08pqiwr6GClEf9l0GpN3NBjf7QuUuU9cBUO4G7vUxtHO3XRFfHajUz7NMAJ4Icj7WGnA068vL72esfsBq9AGhLpyFS6yz0aPWSaXsYDBQkovtGoKmcEuKlJzMkH/QACp49uWqKrnk3Nwoqc45YeFHI4MGBg8CujEIEXIdW7SC0/meJ/p263BgFsFFNjXn5drGs1r1mZRIV9aJ3mpGDo/Ht9gLOMrDMhxNL60/JW99VLIMABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsH5s5UFSlsFAGxu9plcZxudSfzIjjUVuHi1gHIQVCg=;
 b=OSenNmPp79bHA6zPiFTJQ6UKU5m8YEunkurX2Y6Twci/Mpr/2g/LskImLQMDPSLAXcfil87mz1GUsJsNfXo8EcAxW1FMtSebTsO8pFpRZ9N736wKDAhShfm6BvekOYCZygZ6Aw3Ai6elvz9R7d1Pb9u8XjmABZ8uvnIENwrLeT0Tg2u5jPIHSG1AmI8nEhZtRx+49SD0ISkkSAdxtPmYI+Gs0IX6a/cK5kBJpCJDzSJWLN86RiW9CM1Git9J87H5+M7EIVu5nvri1VIWKE+FQPEwydFxUREABoefj1+1cGHVtiaL/Jbive6JhbKBh+KgBhKmXLHzTyaCjdag9AUenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsH5s5UFSlsFAGxu9plcZxudSfzIjjUVuHi1gHIQVCg=;
 b=sNtd/FQtE8guwSdoVvGrRdpTu5jlyD5JSvYDN0P8CuhW42KC/nkvf0AFwYdZGiAn18G7xOjiLaYc13trPJewF6+y3SG1QZwF/rO4U2YqLNKU4UTbxTBq3gjoQwKctYsFXQ85iBxWCCefuFLrltPEGi7D64A+tDYOkiyG973AchA=
Received: from CH2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:610:4f::20)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 17:59:26 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::41) by CH2PR18CA0010.outlook.office365.com
 (2603:10b6:610:4f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 00/11] drm/amdgpu: Render-node EVENTFD subscriptions
 (toward KFD/KGD event unification)
Date: Tue, 21 Apr 2026 23:28:57 +0530
Message-ID: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: d15fa3e3-f610-48fa-dec8-08de9fcfb9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2wwcejLYlCeM17+LmHRYhl51dQOLvfxhGPuyHF71/EKmpVDHax7Nu7euN/IZvp5OmUYnLJiCLJ7/EPpgC4RBQURZ4nbL+SQphTnIiXBvpLcsWZTCy2+DLN1OIobZNC+jTdYoOfL+Ddr4EpuHJadDGJLVjd2ifYqNNdv3tr/pHG2Mm2euVjLGwIWN0MPoj4J6eJLnHDURRw7C4WsgD9sIdD1+E2fgILb7U84wTrQ+MDSchKaAaTlg2Uh1wh2DQZvwJJz63/XcTXgy8YX20AaeQ6FLd+I+ZKE3r4UuB7tM7S4BV2LOtfeYp0XExfeDv1OekiGvVtvMIExWz3AIYMbjTLCO7mfmZXiIjMNegdr+WWmBdy9UycOXZVdicNdRcSaOvJ0Em1vuVETfbnDjSDC5xcur0hG/Ie8EYlkxmQkONgUfGV5ynCaKkGNro26Ju2eofCa9tg9nQWKV/wpSBncdVbDGp8IHBUvYdG90fm31IjU4UWs7OVIMQs8zy9OKXDkX7Yv6yLVmHTUdQuiflksmIlD2a4D3IR1ndXPRnmB3JpC/g4/fv1nOummS8YVKdYyuS+oRjMlAi8XuNxAROxy8Ksa/mfEoVJnIexXqiFLscXyOtcyGU+XS2wT02EPJgHvSHQkLVNu6JXRLgqCnlKxD7SIyZ2rS80dHPkPLvnaRPX6a8Ik6dZK2z8LA9fOSICa2970ZPwu3dPr2TbM+3LAmlVt0yhJxdZLCSq9Qoww4vgSLVz+K8kzMHoC0Y9HRHwlJaADSQ311YYjSgc6qTINhzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: thdGGcDIU9VPKFCnRxS92C1hgWoO3Rrz9H7y+kLdKYJMiOb1mB8xVdfxOCGGkUUf7rnp1gBLpXemPB7tuZrLlr/EklUBjQySe8Xx3HveVFOsXRTskASVk7vzCPs0PL1K9HSvOjlQNKJ7xsfhqLmi9GB370NXqjQJDKfexH3gFHM4LVRfPM2htRIPBf5mDQqljSc7xCZvaR0p8ZFLskZcZ8raK8HnYgePLPxJwcgggAyO4YZnaBo2mo/V2xefS9nf/oOFYdggnps86NShqQ6zVWcHImcfI8a2mgAoguutzl0O1wwi9bYVkWFr+/W3f5VB+Pq9qjyXguQYcU1+84qoBv0dqp7O/1a/+BsWmEEgTF2/giwn/hEVOG/l/gR2HUMZseASNYKLFxW3n+cJNiwYqOkVGfvSiijtwU7rz37J+ACejrCwuo2yQ4FuNF+zY/aJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:25.4889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d15fa3e3-f610-48fa-dec8-08de9fcfb9b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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

This revision updates queue-scoped handling to use a stable queue
identifier (qid) instead of doorbell_index. The qid is stored in the
queue object and used consistently for both EVENTFD signaling and
WAIT_EVENT handling.

Changes in v8:
- Use queue->qid instead of doorbell_index for queue-scoped event handling (Alex).

Srinivasan Shanmugam (11):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu: Wire userq manager to fpriv eventfd manager
  drm/amdgpu/uapi: Add unified EVENTFD ioctl for render node
  drm/amdgpu/uapi: Define kernel event types for EVENTFD subscriptions
  drm/amdgpu: Make EVENTFD subscriptions queue-aware
  drm/amdgpu: Store user queue qid in amdgpu_usermode_queue
  drm/amdgpu/gfx11: Signal USERQ EOP eventfds via userq manager
  drm/amdgpu: Signal QUEUE_RESET eventfds
  drm/amdgpu: Signal MEMORY_EXCEPTION eventfds
  drm/amdgpu: Signal SCRATCH eventfds

 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 417 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  67 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  44 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  19 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  13 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  |   8 +
 include/uapi/drm/amdgpu_drm.h               |  43 ++
 12 files changed, 635 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

-- 
2.34.1

