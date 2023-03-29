Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D09C761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11C010EB09;
	Wed, 29 Mar 2023 15:25:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C5D10EB09
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwTOyj0NCg/CfEHsMQp1SOFo+GCtPg0SkPMVKmixJoL4pMkwip2TB3obmNLowR2/NAdIrW8z/WGpA/rQiJCqSt0ZsnQzGf+Y3MnYmy2Q13BVTz+YrvuT/5GrCIwfJMavzQAVAbKhIlx05gIyUcpGfQ33lREtjq2DFfhE3TsCPG4+xgzVcv2lrn84b0cX/Rw00M89tmh4OAj7dqCLNfQ50omVSSwtr/Oq/+i1Ud/XZNOj7S0i5ppJnUKxri+S4CxqMMJpPOmVL2T6Ab0vXfofPxYTJQSykCmGDg3qvrRGfwz6qkRTbAo8RrVcFMr49Gm7azYXhYls61cJrknI1o/+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+1ZWqaWFRqKar6ASUoGtUhvh8kFMNKHJJxvQLfScUg=;
 b=K3c2rP8Q2HWbj/0NV2/XQpVrAdA4ZF9CU9iVUJSV5UaY7DcyQQ5pkfeOIsFoBUMY8rxzGIjNVwntQvwUGlnXas0uAV9mx19nFkypkEEK71JbwZ8pSBxVrMcCFzgTehR2tCMbt+z29/IDSbKMF6i84kPEXIJUerEa/XFYat1avKA5UDqcRnMxMe//na4L4soKd+otOZpNzgPHrClkyqUxK4LM3ovDEHUWhMksVmL/mpkosvmqCYC6DeZeLEyNxtHKYeRXTvVmAWXQMudD5RXz+RZbfzY4xR2hlp5rdCqJnjXhuM7Ahhk/vwXcAnBnoDDYnfb3/HE5ExkfqwcDeoS22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+1ZWqaWFRqKar6ASUoGtUhvh8kFMNKHJJxvQLfScUg=;
 b=GZu+nmCwlS6i92bt7BEwuLvwy005X3uR/O4i2e8HQf1qg5rr9p+uvmT7bsNK6HdOZsw7nJjMlXQ0X6Xl9Zq/lLbxidpShgu9MPFl4JaUzt2vL+Gyf2wF8NJlvSvpGzhola/DcxMbORxuJ8vqaY+43c0XAq4PgWxEmBMQgpAYFek=
Received: from BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 15:25:35 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::11) by BL0PR02CA0124.outlook.office365.com
 (2603:10b6:208:35::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 00/13] Enable FW assisted shadowing for GFX11
Date: Wed, 29 Mar 2023 11:25:08 -0400
Message-ID: <20230329152521.1980681-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: a30f7150-49f7-4d04-b388-08db3069d78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmY+spLd0hx5MAKxrpgQvla6auqJlpFGjmUZdY96t56UkuHdn3tJvJOO0mYhjFbQL5EH4jWTUgEYR7kasRjJxS+xsSuWCuYwZaG0EJK10STD8BXnZ2dCP3iMNKqGKVo5IfNarqr4VmCYZPeOz9hhAX//crDXKrfFMTmLuUHNhbPSRUUhnY9kegDvjSrOgQnPRcNHm7Af8x6a0BF7Tb5D6XbHmeVvQeTCoSaEYVuVXtzX5MzEfisiluUljT/kcPWF740ZKgfeJqUiNJZbTcBNmAMSyNh80P4yW+2+KfyMo1TbhnDUpBZgS74qZVEcBkJ+nquPPkhsqdjqH6MGkEtzsJSkCwH/u9/8noe1k1IuT7ipvpEuQeXDIGG2b6eDLcZCe3mtDC5hA6fiRgVv8OzbKmacW6Dowzi4YKzTPr2KaNdHcvXm9Xjw8sbAARTgnfluV0y7ytOwd0OAAwBQel/ijdpuNtBDreBOwO6rHO4+HDMnZZ5H8QbJNUny4uTbC6Jv5xLxzH4JmKefWe0rFuu2wlCJszMxI4leSQBISjWlMLP9sMhB86FPKt4RWxquGLKGdQWeCnFj6LXpjcJmvtOemaCEKsL2JNUuoa0+U3DvkU7vSvAJoId10ZqCgd9fdhdS5ioKeaGngnxnk39sr7SzErOrrei4x/ekUf5/mS+jL0G3VzEfohEiagCc/p8UwabS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(356005)(1076003)(81166007)(6666004)(26005)(966005)(336012)(5660300002)(2616005)(36860700001)(66574015)(47076005)(426003)(16526019)(186003)(2906002)(40460700003)(8936002)(82740400003)(36756003)(7696005)(478600001)(316002)(6916009)(4326008)(40480700001)(41300700001)(82310400005)(86362001)(8676002)(70586007)(70206006)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:34.8806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30f7150-49f7-4d04-b388-08db3069d78f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set allows for FW assisted shadowing on supported
platforms.  A new enough CP FW is required.  This feature is
required for mid command buffer preemption and proper SR-IOV
support.  This also simplifies the UMDs by allowing persistent
hardware state when the command submission executes.  UMDs
that use this will have their state retained across command
submissions.

The mesa MR to implement the user mode side of this is:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21986

v2: Integrate feedback from V1.  UMDs now need to specify init_shadow
    on first use.
v3: switch back to legacy mode before fence signalling, fix debugfs
    subsequent MQD access.

Alex Deucher (11):
  drm/amdgpu/gfx11: add FW version check for new CP GFX shadow feature
  drm/amdgpu/gfx11: check the CP FW version CP GFX shadow support
  drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
  drm/amdgpu: don't require a job for cond_exec and shadow
  drm/amdgpu: add UAPI to query GFX shadow sizes
  drm/amdgpu: add gfx shadow callback
  drm/amdgpu: add get_gfx_shadow_info callback for gfx11
  drm/amdgpu: add support for new GFX shadow size query
  drm/amdgpu: bump driver version number for CP GFX shadow
  drm/amdgpu: track MQD size for gfx and compute
  drm/amdgpu: add debugfs interface for reading MQDs

Christian König (2):
  drm/amdgpu: add gfx shadow CS IOCTL support
  drm/amdgpu: add gfx11 emit shadow callback

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 26 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 31 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 14 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 60 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 72 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nvd.h         |  5 +-
 include/uapi/drm/amdgpu_drm.h            | 18 ++++++
 12 files changed, 248 insertions(+), 5 deletions(-)

-- 
2.39.2

