Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B18C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 19:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE2A10E1C4;
	Fri, 23 Dec 2022 19:37:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D88510E1C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Dec 2022 19:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knzy8jInpXFhzgFtR4lLT6aq0UrLo2NxWMiu4yovfb7Z88hd+noVEOh/mfUCiLad0cgDVWgkKSamH0/VDNKLh7468YQIKjnHdQh6fn28CgRn7Q/9+4CflvaniGjkEZEGoFNC+HhHvrqvfyo3AKry/s0CVsP4xcD0wytNUPtR6qMwy7JKqsKFum0vhpH2FGUk+Avr3oeZh/l8oDLSpZuCa4DmM90UpBQJasLPCGj/EHp5rFFa/2r/zYysRMSJv4VYcc4pPQSz+UIHDiLdZjXmSGlD48WHr1NEETX/Zfr78O6i0V24qkhVIdTUzxgmyGhP3u0ViXfvgblMRXRDbEXlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uufj9eF3wTtSSITDuKN0efh996cW3zuRC1LIquG2Eu8=;
 b=GxaxKl2L1j7qh5LP8WehAt2l4MZ9RnHBlrb5K7tsNRxMHUvD/b8MNnMMHCrkJ3N5Ove5lqnM//KS5N+aNrrXE+/nYj5bOCjTu8oOHl84pQFswTu9sXClkPal+fScvucRKjrBG/MbyJPvx980yCy1yg7GLxBlQVYrTgk1tED6J5z+9m5YhgdqETn8ESgTYdPURgJy66fLvqzWfXQFbQx9cUtY4ncpjUzrTTDfH3rR7hRi7XFanXc5/smrc9Ue+UYxMqqHACcsszIYDES8lhhgPIIdzOoL1UIbYh8mslWO46jXEUTWdO3MQ/j+BUDxrrgnOQiWNARweg2m8W3jlAROPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uufj9eF3wTtSSITDuKN0efh996cW3zuRC1LIquG2Eu8=;
 b=ii8LW2IxiIWFDyPr2mvy9slb6v0FoN6w7v5zQmhkGtQ1nOl1N7Jsv8HsihdLC6c3ddeZkoJX9vJPDOC2dN1SiPFY6wEPfj5q4D8RW23P2+wMgSuUslk+XtTMsJhNGKjWO4GiNFLvc2xJdx50s/JC5PAErIZf5AXa3+npcBjmVXo=
Received: from MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 19:37:25 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::50) by MW4PR03CA0226.outlook.office365.com
 (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 19:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.14 via Frontend Transport; Fri, 23 Dec 2022 19:37:24 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 13:37:21 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 0/7] RFC: Usermode queue for AMDGPU driver
Date: Fri, 23 Dec 2022 20:36:48 +0100
Message-ID: <20221223193655.1972-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ab8790-f9a3-4950-3b11-08dae51d1dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUVGYwu/yfd5EafiPKiIZ2ksRfjAOAAs/D7UW8xIEBUp1UykiUkDtYsolbSdJnVQNKGT1okS+iy379to3GjEUcvYmhrwOrq7vn7u/xrkjgr9VZoOqNNTzKWPnH2iYtxYIT4kxzax3VyY5iDyoK3rCUDili2THLZThD0DullLA1PQIGGBGH4HmtA3z8s00v0Hy+WJJ0CLsV5qqh/IGMRP0l//438VEqqNy1d1vyWnkkl/kE3o1Yl7FdLDy+G+zleE4KOoIZm2DVZqFWjyFuVC4NraIqKbgX9kKsDawTOlD1GnlealB3NeMbLW2/hdJJT+OiYQjGXjf4gAXfwMX2ZuC4dFBuujAJeW5/O+xrio59uhxQrXfY29zJl7Yhf9bS9g1WDWN5XD4FZj3St329shJ87E1MvWu3gw71s6SSjkYdCIENweIGaRTWpeTISEYdMxTEmKliftg2jjifZSmlEAQfXTjuCJfZlEMAF/pEe2JEDqPB5Jr0qSJWXr4qJmY4CbGb1uP5z7Ogn/wE1Ogp2rMvVgFfV+eoKp6l4zD8SxGMSsRwM0RR4lTLuCazwgfOYOFGN1ZdDYBy4jfoxgOHYX5bhmZT43j3Rfzr2sM8dUaS3KTVI/JeTaxPI3eABGfRB1UZqXqq57HitePga+1b+bN08RtnGv3P1L2AfX5BGUDFsPFYgcYUlEwnEO3m+UAO9bBhtl05VxSmwc2C6RqgMO16Okm9yZP0rLJDKWbC0RakY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(70586007)(26005)(36756003)(36860700001)(8676002)(4326008)(186003)(16526019)(41300700001)(70206006)(478600001)(6916009)(7696005)(316002)(426003)(54906003)(47076005)(2616005)(1076003)(86362001)(40460700003)(82310400005)(6666004)(40480700001)(336012)(82740400003)(8936002)(356005)(81166007)(2906002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 19:37:24.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ab8790-f9a3-4950-3b11-08dae51d1dcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a RFC series to implement usermode graphics queues for AMDGPU
driver (Navi 3X and above). The idea of usermode graphics queue is to
allow direct workload submission from a userspace graphics process who
has amdgpu graphics context.

Once we have some initial feedback on the design, we will publish a
follow up V1 series with a libdrm consumer test. 

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Arunpravin Paneer Selvam (1):
  drm/amdgpu: Secure semaphore for usermode queue

Arvind Yadav (1):
  drm/amdgpu: Create MQD for userspace queue

Shashank Sharma (4):
  drm/amdgpu: Add usermode queue for gfx work
  drm/amdgpu: Allocate doorbell slot for user queue
  drm/amdgpu: Create context for usermode queue
  drm/amdgpu: Map userqueue into HW

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 486 ++++++++++++++++
 .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++
 .../drm/amd/include/amdgpu_usermode_queue.h   |  68 +++
 .../amd/include/amdgpu_usermode_queue_mqd.h   | 544 ++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h                 |  52 ++
 8 files changed, 1413 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h

-- 
2.34.1

