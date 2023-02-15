Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F303BC636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E878910E28C;
	Wed, 15 Feb 2023 18:44:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A184D10E28C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGgjTuuG+G4irLCJTojU0giZAn97yq//wqxkWv2FjTAYhTeZ26d7Hzv4SG+QHSTpkwQgpNBGsK3oGZo2bhXwPYcPm8TxdUUJQiKYUr1a/wpwtScddPS8DS2AVrErzDjDo3aMSyQfpnOCk58Mod6b0d9GCry5S1kZNAI2hYDHS8P8VmjP5oyvVCdpv8u9LuGev9FdA7cvtR+LJ/nrpMELhHVS5kYvfMC4nFRiJHj7uFbMYUPoH4PMHsksZY0b5YHjcsJUjQAP028qRSna7C/q1e3ddPR2ChTw3cy/jsxHtpUCPeqjPd0ebNxIbh+D0Y4oSRINSX8ak8xAauKSt4scgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BzL6yVJs9RZyDEmbdhHfOmRUSOKT0GeRgCjreGDuNw=;
 b=Pc7iXdiBOGba/EhCM+mYoLF5b4kO/vGY8LCLUhQFYfJQ5G0IDGtYTVrWa9CGeEJJ1ohoG5jyKzfiG3EpAeQyYzma2hA13oIa8Bsr501MTJUWXWzgHPRn4F+2xsV95QxM6LzcD2F7p1OsKCM9Q8q/mS1xTk8Ils5BoXPJqAlo/wPqYJOS4aynDoAvDWbkWQ4hVAFcevdHiWIiglvtE0MqucYqpo61HpD9HQiN1tX6uBgrsHvYhg2zn3J/Lws41bJ+fZj5/pKF+Y43dflT3mO4q0lhNOe1FRypnnvQGiJnnK7yXksDB5hbCbMJBtKd898SYXH15qeMPot+uXchFlLbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BzL6yVJs9RZyDEmbdhHfOmRUSOKT0GeRgCjreGDuNw=;
 b=fRSq90dRzpofqZTCgSHITPQwiqen4CwQnT5EyUKcGZ58xvXl+VrMXLGM+02pCYMXgU0/xXqFpHt7Qvva+P0Y1HuVJ3Mr1liWVNTVVBKhHBJzZVgsL45q463JMkfRdYtpSUz5DCEJcVVsfMwkEG6TfdGaY8I4HoewD0QS/XExwHw=
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 18:44:28 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::f3) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:28 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:26 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/9] 
Date: Wed, 15 Feb 2023 19:43:48 +0100
Message-ID: <20230215184356.2205-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0a048c-7ca9-4d2a-f1d5-08db0f84ab08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kdiw4qfyJgR4xrQuBf/LznZKZBYh5wW/wj1Qf61JZ+bFVDXp3SHxDGkakLpFDdZukddISTLgy+wUjvC1uZnYa+5M152R7m7VgzT1RMbcx8DCQv1Wj6RLzqQBewR0zqX+OiUbZUsh2pyGn6gQI74KxW/SiNj3bTMJwbtoex4Hn6k1Yk+vHsb33tA9UyaOZvKbURFJRZB0PSTI/T9DwGXEXmeBhgyC9NzfIJl47rs1ObwY+DrptzyBN2nkftn+d6PMgKeZBaiHrdHrNs1mSTjg+yVoW9lIO/X0aXO0pkTeTTlgFTG7iGaQj4OhtoU6fn18iODMhC0p2z6ROWahZfaDfG3wmzkdSF/RS3jXNg6Lp5xFnvjbYo8i3l1zVHbh0Qs3bLcNPyjPw6lC0GKWD58uJfs9TumG2aXh7KBwLA9hXKbcfsJXTlNT3ZVy7OmV7Jy7/s2XRMdyAXdv6YjhE/u/6Urk5ymZQXiJsPJKcN5MIzvDjuwlGaN+DNN7kOEeWaqsBoOwO2CDjisy93NTaSHvcVQGNaJJp8cOoHcw3dwqDaZk0AXM6w4pE2Rc8SD5zWEjo3UL8ovzL63lU2/QgTfUcFteCweB4DxXBJMCRKh+2ruFgxYTSwHicgntjf6kesBz8OvKVV7KB9MABh8bYs67uUXuuukBL/YCCTQbGQuefbKOgOQgIjCkZTzrSawlPAcg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(316002)(8676002)(6666004)(40480700001)(2616005)(4743002)(83380400001)(336012)(86362001)(82740400003)(81166007)(356005)(36860700001)(426003)(82310400005)(966005)(54906003)(1076003)(40460700003)(16526019)(26005)(36756003)(7696005)(186003)(478600001)(47076005)(5660300002)(8936002)(41300700001)(2906002)(44832011)(70206006)(4326008)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:28.1865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0a048c-7ca9-4d2a-f1d5-08db0f84ab08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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
Cc: Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch series introduces AMDGPU usermode graphics queues.
User queues is a method of GPU workload submission into the graphics
hardware without any interaction with kernel/DRM schedulers. In this
method, a userspace graphics application can create its own workqueue
and submit it directly in the GPU HW.

The general idea of how this is supposed to work:
- The application creates the following GPU objetcs:
  - A queue object to hold the workload packets.
  - A read pointer object.
  - A write pointer object.
  - A doorbell page.
- Kernel picks any 32-bit offset in the doorbell page for this queue.
- The application uses the usermode_queue_create IOCTL introduced in
  this patch, by passing the the GPU addresses of these objects (read
  ptr, write ptr, queue base address and doorbell address)
- The kernel creates the queue and maps it in the HW.
- The application can start submitting the data in the queue as soon as
  the kernel IOCTL returns.
- Once the data is filled in the queue, the app must write the number of
  dwords in the doorbell offset, and the GPU will start fetching the data.

libDRM changes for this series and a sample DRM test program can be found
in the MESA merge request here:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

The RFC patch series and previous discussion can be seen here:
https://patchwork.freedesktop.org/series/112214/

This patch series needs the doorbell re-design changes, which are being
reviewed here:
https://patchwork.freedesktop.org/series/113669/

In absence of the doorbell patches, this patch series uses a hack patch
to test the functionality. That hack patch is also published here at the
end of the series, just for reference.

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Arvind Yadav (2):
  drm/amdgpu: add new parameters in v11_struct
  drm/amdgpu: map wptr BO into GART

Shashank Sharma (6):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: create GFX-gen11 MQD for userqueue
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES
  drm/amdgpu: create doorbell index of the userqueue

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 325 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 230 +++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
 drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
 include/uapi/drm/amdgpu_drm.h                 |  55 +++
 9 files changed, 704 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.34.1

