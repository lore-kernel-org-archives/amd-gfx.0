Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54ADEB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 06:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F86510E657;
	Fri, 11 Aug 2023 06:03:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1B610E657
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIG39snkufHTskqcVfRXG0GDt0DaYFn1jfqyznUOFbMop1v3HCi2t5jkupmTduis06nh33ST8gsz31LrUy6Y8snzf8QEcENHztrHlIGew+FmD3Gglb2tYw2lbRlBU9l0PcJAPFX/2q0HYhodD7uOGjjcqWIBHaiyQiBUhRWUtpQwmGBYMNwRRI0FO/X2bP7AQqBQ6Ony8twNNQpSYAxTzk1pSbngzNoFrinoZ1t9/ACUFaAUTpzkLx+IGqtpTm/sYaz6Eelan6u37ar8uP2dxmzaiYWekDgZThOvSmKUqOmrfqzp0B/IWSfyOuTT+aY8vxpKBc0JlB4DdpsOciRrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpfKWUwltPKPvAd3uM+SM3KwvZsCSTqmWiwGwY3AfvQ=;
 b=TIGyu6So2ZRMWSSITG732zC7njPD+Ob3SuCAcs0O2qpfot1+ia9+EvJltk/ZHdOxZFoGUfTyeiJA/TgYppDbHJoUyoELoLXGmJDcrNOlpX61u34iuTRP7aRA8iKvkdHxI9ZZyZvzUrnu8O9o+PpbFxRddNhD/jI81/0fJRJv00HU/B4WzD9j4K+gSuXbcKF/+ywR31qu2LNcdkGnEZEjJ31nwcjPuepXp3HmwTDDcdCouOoPysRZ6frv0JInZaVvwB3LwaOXgSPenYMtaNfejsOsD4kGpCVnVuLqiBClYa4f2x3+ZlPElFpa6JdH+NN3WFWitu1MvbYLiELmYSTGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpfKWUwltPKPvAd3uM+SM3KwvZsCSTqmWiwGwY3AfvQ=;
 b=MJ16v3GBpyZL9crt9mxvn09IBOU16eevX0kAyuzBG/LzRfP1B5wP1s7EHkp2l3oB8P5er9tFSyxJ7BVKGc6nhnOz23pXP5ZAmUsHH7ih7XU2JbW9Pi1/QqYexgONoYbHTxzXHKtIwcKIpoEQkwvjjWPxwKmRkX9WZpYq02WGObw=
Received: from MW4PR03CA0250.namprd03.prod.outlook.com (2603:10b6:303:b4::15)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:02:53 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::95) by MW4PR03CA0250.outlook.office365.com
 (2603:10b6:303:b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 06:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 06:02:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 01:02:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] Add work pool to reset domain
Date: Fri, 11 Aug 2023 11:32:29 +0530
Message-ID: <20230811060234.663789-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: bf51fe35-6c6e-4808-73ef-08db9a3099a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAq06u0AdZ3tevd3F3msalxKYKkKrtjjSEpFsz3P6n34rAYEJZd3kGm6XQfKnd7kudgEPexIf/2prxxzyeKdBNmc4fi7auZJWmV6PtBbjH9nbbF9goKhhV5nTEhwuSdPEgo9x7ujSMu3zPNcsD0La4whsYukng/J6VlK/AElcxSqbYTuqxSNh/CEK1tlOGjz6tnWJTPQY6usmG8ZGzAmo5gugYslvSR1L6S9vKpBCn097Js1T0dnTxKmjQSUNTf3VyFu2hmGuDGJrYs91r7c4ve3MIXHXD5pt0l8lUuT97nMYCfycQD5opY85/a3XlKTT1TSwROMkcy8AOoGEgD3qDOYN2VpXWzzh4W0QB+8CzaZYUMDm7CogV9vT3C33x5F783woG0UimCmsD6CibzWzob2lYqHzu2O6XM4PB6GxBRhU3jR/SQXKY/QagXULWG6aC8hMYxWcRRcjFKsbROKiDkXhyNi7zJmhBhDEcTaXXWcu1GwbSd8LKxTuVj67nN2WmGnvtzVp8OAlduMfyfNfvVkHDJacg1B8rZSkdGIhiX5RmxVMKWooxE20NhT2r8ByactO6NVfDFcWVQ6SPnGc55uFIg5CP4pVp9bbN6eDt4sHx/k1FqMx7fk6WeL0P1MD9TZ0hDf41geCuBrj9qcoNqFx/1VBLE1RJctdo9aCNR36HsfDYqy/TU/iL1VOETLiVocsVPp9gGWpIfP0QlVv+PBJuoK8jW8DeK2vCGJgLYekulZtV1oy/QgyYtuZRMjtg/Lo2B4rPVB+Wf4NrymUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(186006)(82310400008)(1800799006)(451199021)(46966006)(40470700004)(36840700001)(70206006)(47076005)(36860700001)(83380400001)(6916009)(44832011)(70586007)(4326008)(26005)(1076003)(2616005)(336012)(16526019)(426003)(7696005)(6666004)(81166007)(356005)(40460700003)(36756003)(54906003)(2906002)(5660300002)(478600001)(40480700001)(41300700001)(8676002)(86362001)(82740400003)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:02:52.8490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf51fe35-6c6e-4808-73ef-08db9a3099a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Presently, there are multiple clients of reset like RAS, job timeout, KFD hang
detection and debug method. Instead of each client maintaining a work item,
reset work pool is moved to reset domain. When a client makes a recovery request,
a work item is allocated by the reset domain and queued for execution. For the
case of job timeout, each ring has its own TDR queue to which tdr work is
scheduled. From there, it's further queued to a reset domain based on the device
configuration.

This allows flexibility to have multiple reset domains. For example, when
there are partitions, each partition can maintain its own reset domain and a job
timeout on one partition doesn't affect jobs on the other partition (when the
jobs don't have any interdependency). The reset logic will select the
appropriate reset domain based on the current device configuration.

Lijo Lazar (5):
  drm/amdgpu: Add work pool to reset domain
  drm/amdgpu: Move to reset_schedule_work
  drm/amdgpu: Set flags to cancel all pending resets
  drm/amdgpu: Add API to queue and do reset work
  drm/amdgpu: Add TDR queue for ring

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  32 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  24 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  40 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  16 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  71 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 122 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  32 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |   1 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  38 +++----
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  44 ++++----
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  33 +++---
 15 files changed, 285 insertions(+), 177 deletions(-)

-- 
2.25.1

