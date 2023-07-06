Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB5FEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C584410E050;
	Thu,  6 Jul 2023 12:36:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D3E10E050
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0My8yRc1Cqfy4vC+b1yFXo/Bh+peq2ajsp/+t/jyg7d0SBS6Clfaqw4DuQapIStcRZWZjnJv/z4oI3tcc4xzDaDTGbUAJ3Y65Bh6xx0rr0TLdkNH/5XIfC1Yp24LIYdjj8JC6fyyko+3U/dP0fgSDnPf0E+UP75oU6GL3Ix+pPGHuAgAGEEsEtD+f0xlnPPp22hLkd9XWdBVnk565H6gwMrRblrwBdUhVITHpDVKeV2WSVoCIBUCa+TBFCTfmquTD5XNezJJobw3A7c6qpqdsYbOwhZDJAeZFrQ1KmUn8c2UiLRro9h+xdH9v+/RYFie353sHEJpy+ac+T6MiifIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi8gV21LOnqC6KR1CywRtmIIqZZQCaYI10OBgTTWI64=;
 b=DYxm7S5g69+P7B7W0BpwPKCujkoFgBPENmsbWURzLP/xLHZsG24ENRN2tCqAyWE/3gJ7725l/hfmbzvDpP0kjUAzorxt/XROhJHJGHHB3Bfmq0zIMfWy3eB35Jpxrm1hWX7TPCy+kVhEJ5N/+9XYkvkig64W43rBu5yO0+qzRqOMJ34oLXPbmEzbrRAw7wfjE5Vrr3b0G3fSJmrOHBmZ87RFjulBAnp84ejEiT4zBIGENicieeyMgIQNNDQzK/08fDhg7modbMFp+qicyOuVqoFNgkO2JYfm6WEShLnm66l0bHu5OlYNL3v57l/vI6kAzdvaW6N/dZUIvb5lbrHVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi8gV21LOnqC6KR1CywRtmIIqZZQCaYI10OBgTTWI64=;
 b=3gpl1vNeWCpJk4DuxZtSMawR5EB/tqzR8HWabGdHxiAJjA7yWlpoxSrYuCPFncoatV2dSHD0+DZz1Qqn3uEIIl+4rCbpno6Kxr1viEKyRh++wJusLeBqMaoZlObclp6hKv23q20y4ks0pgV7uXQw0S5YxxcWNaqZpauIZ0KJi8U=
Received: from DM6PR12CA0001.namprd12.prod.outlook.com (2603:10b6:5:1c0::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:36:29 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::14) by DM6PR12CA0001.outlook.office365.com
 (2603:10b6:5:1c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:28 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:25 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 00/10] AMDGPU Usermode queues
Date: Thu, 6 Jul 2023 14:35:52 +0200
Message-ID: <20230706123602.2331-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c042fb0-c499-4abc-4885-08db7e1d9efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rS5t02LpGPLw0JzDPAiNpo0jZyX5M54RfdTfCnfti2d9T+IvmlfNhmTvDdw+RV7D9NV6WQRRXZzuf+AdlET5yqNgF9tLgpYMkdEsKjg9v6p01VVxBpTR16H6P7/szpFWyoTnpvHC6GEhQKefalMwZhj91gPKJ8+TC8PXz6Eweqs1Df0sD5Vi+dWOpVbe/jiZfxuW4xPiHLzyKOGr0nHqqtRu6TKsUPh3kXdIxeQ4KGHCH6/WxC/QfCzIcqyNFCdu5V+q69QxmwLZWOTWs7fGZgbsQRxECjfsfznub4l4fqb4w3WZrcazbolMmqWbRDcnXdRU5OQUSk3HJdSH/WlYkdlmvo4zs3geJN20rB/9fMc1qZK7LXQZMcmZM/4kOnSZY+17DLXNjHEf4PILL+OOaHBazSTHh7B3GpZy9hvzSrpIJhGOd8XngpFgnvb427OqpjA0cnAVKbcG2x3G+d7HNDszl8JarsgVqiUvUZHTo5Fqnz8bO+K1vYXHwKLzS7yESBWdhTX+HJCnZ5n7BrAD1HLmZlobb2uR3IfaAms3DiXb5ghMwnhSr3SFFmSM9EQGI0eBq62lqfKJQ/9J3c9oAU6tT/ggnvOklpEUT8eBJA3BaAWg9+hMW3mUnwrD6/qM7AdpfBI6bFWDvfzNMTy/Qejl4dMVmiB1734oFb9jkX9+MRQV12Ub2Mvy0ztozFkjRcc/Yz2x2+HTpqccE1qro2Fa6NKSaZ8ZoAQPk0otsLHxoNTpzlox7rV0Onx4js+Me0LVRG4l/4fvLBE9J/ERqwCHuciQP6SA/ysU3nw1HXU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(186003)(70206006)(81166007)(16526019)(2616005)(82740400003)(356005)(26005)(8936002)(36860700001)(40480700001)(47076005)(426003)(44832011)(336012)(8676002)(41300700001)(5660300002)(83380400001)(36756003)(6916009)(86362001)(7696005)(6666004)(966005)(4326008)(2906002)(70586007)(478600001)(316002)(54906003)(40460700003)(1076003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:28.8761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c042fb0-c499-4abc-4885-08db7e1d9efc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
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
Cc: arvind.yadav@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series introduces AMDGPU usermode queues for gfx workloads.
Usermode queues is a method of GPU workload submission into the graphics
hardware without any interaction with kernel/DRM schedulers. In this
method, a userspace graphics application can create its own workqueue
and submit it directly in the GPU HW.

The general idea of how this is supposed to work:
- The application creates the following GPU objetcs:
  - A queue object to hold the workload packets.
  - A read pointer object.
  - A write pointer object.
  - A doorbell page.
  - Shadow bufffer pages.
  - GDS buffer pages (if required).
- The application picks a 32-bit offset in the doorbell page for this
  queue.
- The application uses the usermode_queue_create IOCTL introduced in
  this patch, by passing the GPU addresses of these objects (read ptr,
  write ptr, queue base address, shadow, gds) with doorbell object and
  32-bit doorbell offset in the doorbell page.
- The kernel creates the queue and maps it in the HW.
- The application can start submitting the data in the queue as soon as
  the kernel IOCTL returns.
- After filling the workload data in the queue, the app must write the
  number of dwords added in the queue into the doorbell offset, and the
  GPU will start fetching the data.

libDRM changes for this series and a sample DRM test program can be found
in the MESA merge request here:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

This patch series depends on the doorbell-manager changes, which are being
reviewed here:
https://patchwork.freedesktop.org/series/115802/

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Shashank Sharma (9):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: create GFX-gen11 usermode queue
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES
  drm/amdgpu: map wptr BO into GART
  drm/amdgpu: generate doorbell index for userqueue
  drm/amdgpu: cleanup leftover queues
  drm/amdgpu: add delay after userqueue mapping

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 221 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 294 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  76 +++++
 include/uapi/drm/amdgpu_drm.h                 | 110 +++++++
 8 files changed, 713 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.40.1

