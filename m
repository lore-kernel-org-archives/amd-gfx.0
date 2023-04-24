Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E68EC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E488610E1C2;
	Mon, 24 Apr 2023 17:39:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C9610E070
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EveTK64COoMkwikIBrDVDdSgjXzSAnkOO3ugY/gNOYHRbPd0TsjrgaF+Casnl//mem2UwMQAnO2EQdZTi5NXi7RAxmWX8+92HlgGAhZaehExbITBTID+ylQQB3kGMgUM/UH2Nff3KbeJYEccZuj5NcgZsyH+uiH1cKqC1v6wz2umf/FSlz3MebyLJMRvqPyaZ3lGbPIjmjo2DMvhmME1BHxAhAndGDrdrKxIzVKJrCI31a1JtPPPumQNnBZUsuleptfCL9Ff6aTwFpFXLVYBeslStcgPoOmoxS6mIHR/rr1F1Hxh3vh4XEbJ2YadirpkufwA0YnskI+MDWnyl8TIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd9HoJzYKswT1iVyMJFkcB573zHC47RgTvp0o113J9E=;
 b=gH8lTWPJFieDFIN3JM8YPCVTvf3+fDRq1zKSk2RJy/odSnft6an4BxUIwY0c4TEbdSUWOq/244th9zDUYu23Po0mmIZ9/B8CkHJ7W3KT7fjSOoQkiPaaRHO50riBvfPYlfI0w6A6LQDNEO2s3uT7/nzyy8l/i9XpNPpq5A7LMPHr9bpvOqx0BpmplC7cHww2K+5Ecfr2+XXhZMykHB5FKYXPM4Ayxu1J7Xk3slNHIYpxUSuYoS884P+cLz5RzgSpXW7TnnVJSu53D9NJ5qKfKmBjP8hgqavTH4OIoPP1x2n1TAb8VxD0ysgk1kOFXXsXBY1L8XYnd8l0FvGJrWR+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd9HoJzYKswT1iVyMJFkcB573zHC47RgTvp0o113J9E=;
 b=13rQ1A7jlqZZgRTCrK2z2oyEbN8O3bj4KoWXhSSbUUO6tZlRondiyj23kHk+zZBWghvJFQyawMzrW80MQIDaTVnUNhhMKfhytSD7baS66x9vA1U20cgE2pER0lVETTERwMHGekk5ShL0BLebiiG17AixEIlTnHQziB7hpDVqqVk=
Received: from MW4PR03CA0192.namprd03.prod.outlook.com (2603:10b6:303:b8::17)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:39:04 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::8) by MW4PR03CA0192.outlook.office365.com
 (2603:10b6:303:b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:03 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:01 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 00/10] AMDGPU usermode queues
Date: Mon, 24 Apr 2023 19:38:25 +0200
Message-ID: <20230424173836.1441-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b12791-b998-41af-244a-08db44eacbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oePVeRoPr7Xkj/MKv2DMA/gVKdt5Ao7l6iMRzTpYMhWXvfPtnskmhRdr1voJtG0iIOwkyxHPi0FEF3VWTTMOY4PRPbu3fQ9zJ6O+oGvci8rllEebn6VE824fKhHIOpv2zkrmfRstSwYD9stv7ehJtmHuxjqZwBlaEGVtD6RWEpIcDaW5L2+gwCqFbSnO0KQxaT2RT55aNbex5Qm3lFi31cVf08bDHhyA7kHdVN13vDfDddY5DC/Ax8CYVDZ+xZgDm0z5K1DF7hoSfPk+gAZWqx+hU8iZ0rjGxJpn+3AHVVQ5MCZIS/ZU6HG2qvjbElCPhUcBxv63lU94rLGdv5RFtp615MXSQJlmSksnM9UKtGVElr0OP3FxuzK4NRq7p/EGgPy/zpEMyvGpk0vapYVhKXLD83teDk9SBpt4v8kaQvVHdqQphV6j4liRPcDROqfDItHBzoPzyr5GUBNSadFcJ9oi92deyVQahulQ1dQ824UrdOt8IY0CKadbRh/VKgn6F4PRUFHGdBHogD3ecvib+vQSyhvIJx43BeTFNUk5AB6dNym9QjMh4uQ5XAIr4ts2XMKB6paxYfot23ohl6XZZbjRhU9Q689Xzg6WKgFXOalQt9b6uqBKIU57sh4DGrI/KrH3nPLUKjMqF4EmZ7hnEzkHrWvDcZNk9mt+RZKVP/HgvsoVswppv6ky3Egi3HcV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(8676002)(8936002)(54906003)(40460700003)(478600001)(4326008)(6916009)(70206006)(70586007)(40480700001)(356005)(44832011)(81166007)(316002)(41300700001)(82740400003)(2906002)(5660300002)(2616005)(86362001)(36860700001)(186003)(16526019)(966005)(336012)(426003)(26005)(1076003)(7696005)(6666004)(47076005)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:03.6961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b12791-b998-41af-244a-08db44eacbfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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
Cc: pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com, Shashank Sharma <shashank.sharma@amd.com>
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
- The application picks a 32-bit offset in the doorbell page for this
  queue.
- The application uses the usermode_queue_create IOCTL introduced in
  this patch, by passing the GPU addresses of these objects (read ptr,
  write ptr, queue base address and 32-bit doorbell offset from the
  doorbell page)
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

Arvind Yadav (1):
  drm/amdgpu: set FW parameters in v11_struct

Shashank Sharma (8):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: create GFX-gen11 MQD for userqueue
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES
  drm/amdgpu: map wptr BO into GART
  drm/amdgpu: generate doorbell index for userqueue
  drm/amdgpu: cleanup leftover queues

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 333 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 195 ++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
 include/uapi/drm/amdgpu_drm.h                 |  95 +++++
 8 files changed, 708 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.40.0

