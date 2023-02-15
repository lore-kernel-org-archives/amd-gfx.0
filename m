Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F3DC636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 19:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6700510E076;
	Wed, 15 Feb 2023 19:06:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660DB10E14B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 19:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyn10pd907cjjHX5/XgtWU7zeikmP1Yw1Bjy55lgQ3CERBs3AEFbiSZsylpOadDeVRzIVYHdlUyrXUmvIGXuP7XCi+akrmXVWdrthIuleDcXbYsZ9+CKlBOPRAXbxtMOXjOnCMv5ok1uztSsWO2njhlTOf3wNQMo9VCxonxzvyo9QtNBHJWiShy1lGunfEhxn79j12Z7lkhq/e4eIyng3aYYFD7xQjzp4ifY7QFawxrPm7zm+q4x75vBA6lP16rrB/IM6WOLG0zfPxRcIGJ+oZ1oXBxgf2D3YYWhbXATcdCVvX+BM36icE601FNmp8C/wSepeAa5FW0terDm8cJh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hkkDl4CMpQ4FvLR0wWAWYIClLSaPUyhgamtnEY652E=;
 b=f8J94+k+KgUCihfB/YHdVz3E6ZwfjIpHJDTrpf5FmiNJd4jKWb+VrA8XWqK/bOZdfyICQKxAokau9zlTH+ULidqiYEf2G1CHgUZ1f7KT/Y3sDwZHSUCp73Lifu4UVGvbvamMXd/mMn04QEijG1urvgShcMuCWHsd6LhSgq7SZyXkivBnOMeTwWvvtWMinEIF2Krd7b5g/7ByNtw6QZkgYIeQ9HmGmXEAf2vm96eHuEV3rW8lprQy52HTkP85/EDPFUP0wJ2nc8up+9k/EYXor3XDAKMlIFdauO6T//cZIppwdmlorpe2cNVlQZ0zQ9Q+CUhnruDartmEUqK9gFZUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hkkDl4CMpQ4FvLR0wWAWYIClLSaPUyhgamtnEY652E=;
 b=yTLSUBuObWxHnlb48SUC0iYJLlkMeRQ8vNjdTYyQNc8dZ6yiAqP3X/T/Am/91bxZHewOO71H5qDKG61Hmp/JG1l6diGiLFKOa1yJJ1JuVSeT7z5MFuVqxL9jPDhhKeIB1NNfab0jUfOyy4EfILtu1aX2M0beANCd2+8mw0bycv8=
Received: from CY5PR22CA0075.namprd22.prod.outlook.com (2603:10b6:930:80::18)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 19:06:04 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:80:cafe::3d) by CY5PR22CA0075.outlook.office365.com
 (2603:10b6:930:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 19:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Wed, 15 Feb 2023 19:06:03 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 13:06:01 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/9] AMDGPU usermode queues 
Date: Wed, 15 Feb 2023 20:05:35 +0100
Message-ID: <20230215190535.2265-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230215184356.2205-1-shashank.sharma@amd.com>
References: <20230215184356.2205-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 326c5381-6197-42a1-f2e2-08db0f87af26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4NRE7QNZzRpqNP/v+rP2B945zjdK8lwfvHcPf1M+7k2Z59AMnGAVFhu3NO+u5Bvr9lsEvWL9Zuzlvdw0nPuutQhLAIvbpxXQiADevf2MKeiAWQM3X1j2S6ivAsQrzd9HEIUisaeCOEdr62Ba96hpMIwcf2rgpZvRbuF0KHPCjdu1EB9++rvY5ePDKAf8PQlw0Ak1m/O1DiS/wwXI/O9zhIr4VVev3jyESDzyT+/fY0WNC7kgXbMND+vSbhr9wB2kZPLCtWuPmM9/LdGe1t4QQTuNpHDxfo4m/WeEPngVnUOSzrr9aMfdaUFZSbwABM/lGMPAo0bHzez/tKXxGixzY03AgYZ4WHKa6PWlwAYx0QCFeQIhYBOJ9egSj+d3s8lsHT0qqcGp6NAav2oEFqKLbk1Bs4cv8agEeoElcH0sA9+O/squpbRk0wTMAkX+/5RSls0Xgy4nG6BFcbhze4BIa0mhy84uRfzDtPc3kVmVorUQn/+DUdwMPOxYDVUw2hrUdxqid/mmqoxL9Ogft1FS5q87bXSdgeDI9DTB8Y+LNIwXb327fevQY1bKRYsDc+KcYADvwxUINgsWLBe2u25bwrXGLWrZjSxcCLv+gVx1+nTWgEZuKroolJpmqVXrmSnzWxC4dxJ0dMS3Ab/BZ0+p+hg3LW1sKWGI6EVYyqqwFq7tRR6xupzmQKmL78YczSH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(426003)(47076005)(41300700001)(336012)(8936002)(4326008)(70586007)(8676002)(6916009)(40480700001)(81166007)(70206006)(83380400001)(82740400003)(86362001)(82310400005)(36860700001)(36756003)(2906002)(44832011)(5660300002)(40460700003)(356005)(316002)(1076003)(478600001)(16526019)(186003)(4743002)(26005)(966005)(2616005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 19:06:03.2548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326c5381-6197-42a1-f2e2-08db0f87af26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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
Cc: Shashank Sharma <contactshashanksharma@gmail.com>
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

Shashank Sharma (5):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: create GFX-gen11 MQD for userqueue
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES

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

