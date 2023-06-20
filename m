Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742BAEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24D710E24E;
	Tue, 20 Jun 2023 17:16:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F292D10E0A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpTSnaaahMgw0nEbiYLXKI6aOVj6wZ3rfuxXr63Gb40zlyxQl+NRRuFM2njFVXbgV7J6NLhhNh/AGQdqn3BuOJ0TMsn6YP0q86m6Zrv03Vu8xbtkZgp2wHiePbWZQkozEBeSM/D8MrWZzdA2h7khNUBCrvbyHucNxK34UMABkTpsuDhnHiGB9NSmX+ccCHFV06SCSYA29uwf+EQ93fYvpgvdAQ1O/yxqbcHKUA4DwLVypEkf3SK7BmDwL0ArmpC9mqrKASlRyN5LKxtQZ+WhQ/2DI1DJp0cbciZjEQNGD8yIdRS7N2u2GY7UQJa/K7YiZRbpeuhsy3QtqsnGOu4j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ0unEM4LbTtRVrRHsvImxcdDcYgXjoLCG6//qM3ZEU=;
 b=e70JpXDE/JZgwuNlrYSXOVY8W3jQZiFt6PkH8rIHvspqPMxZ3+Sm0JG0n5qKYzNImC9L/+GRRRvj/SRI350UhpPs3A+WrdswwOSLD5j8iahYOoa9hSQop8cZx5ba2JwJ/QruNKN5Qm4W/Vy04nzUEKZkGov94YhFARF3UTqddMQTqTKRRchAUtfkJSjktgtydAB4g9om2hwHA5KohTTjmi7Rr8Pjfora/ZzP58nCh2z2hRe2J82tnIOGAuk34tpZtNjKb8NTal9GmKiW0w4u0pTeLgjP8voejfilreyVa/JVpvockY/gh3mGHFK0/YIh2ZpyZycd7/uGcfNvOpUK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ0unEM4LbTtRVrRHsvImxcdDcYgXjoLCG6//qM3ZEU=;
 b=xMtClrFIF6WTMRJMpLHGN0hOptUOboI7Riif/PE3xFSc/fMFjKJJw4fRSf2gtxyHU4Vmyo6bGmrr+sRhMkhglehiPz+8+W/3QDmchwWbjcAsk6BTOpqObUJgrtex4JHpMhWpo4/bgEE569tWAbUdnmiPAETkmWJ5VeN080nrdWU=
Received: from BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:25 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::37) by BYAPR07CA0062.outlook.office365.com
 (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:24 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:22 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 00/12] AMDGPU Doorbell manager
Date: Tue, 20 Jun 2023 19:15:56 +0200
Message-ID: <20230620171608.2131-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 34473e66-a340-4b17-4966-08db71b21391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCob5a9pBE4gM3/7ZuBBg9rBdcoKqAPm19tA9AoyE044XOw1brCEFO2cWyjpDFq5oCwRNvTdy9/ubuQEEatguIYKknaS1W9iiIKrKd5dYtyeRO/VbNTRbR48SQMx0phku3AEoht0WtjIsiGc//uKrat823kITvVa91Afgeqz6m8SQpebhRcB1NoAB9DDktq0RyBn0HpCmOggXy5BlM5rbADC52AQ/AK6zevez56lT7WsyBhq2OO7D6ZPoMMBCg/+3Ob3SqhHIEq3558woXsikZYjFuHUWW6oRzN5VtIvoIBEe9MjA+ULQ9xPBVajFdtn62LJXbUvHLHriOiBPuPlsrmAQ9foM4gVJlXmF6TuxwjIHnXO3p4BgcqG+zWsbri6BErX21IL7MkJ6MunU2S6FpCGxRsxz3Z7PX/IuW1nfbCZtFKNb2sidd7KW/zHfnjl5CxbE/IPl+yjHT06xsm43WONoaNSU4pIreOTUeaBqxXsRc9G0s3lr0ojtW1JNQFB742YFKTO+y3kDZ+CNTxO05of7OYpoNmkJCEBvSZt+VVgEPd0k4urPedNICYo4Etx27uldtscwVma0ZWRHaU6jguUsjkgsQ0kYkbit0IJRIZbJjsEhUwhK0Y6aKzIDOAziQl/Uf4Trr4L0Nc1UV6qmU4hgyfmR6QfcJl7CkOI4HdzxmMo3S6FAjpEOxw1i52n88ZU3/hAXcdse+2j1cEeRk+ZtPZIXNvMlGAo/cGRPty+teWd2Ywnzn0569Jh1nhU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(966005)(40460700003)(7696005)(478600001)(47076005)(83380400001)(16526019)(186003)(1076003)(336012)(426003)(26005)(2616005)(86362001)(82310400005)(36756003)(82740400003)(356005)(81166007)(36860700001)(40480700001)(8676002)(5660300002)(8936002)(316002)(2906002)(41300700001)(4326008)(6916009)(70586007)(70206006)(44832011)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:24.8838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34473e66-a340-4b17-4966-08db71b21391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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

Doorbells in AMDGPU drivers are currently managed by different clients
in a scattered way, across may places. The existing clients are:
- AMDGPU graphics driver for kernel level doorbell writes.
- AMDGPU MES module for kernel level doorbell write (MES ring test and
  aggregated doorbells).
- AMDGPU MES module for MES process doorbells.
- AMDKFD module for KFD/KIQ kernel doorbells.
- AMDKFD module for KFD process doorbells.
- AMDGPU usermode queues for usermode doorbell writes (upcoming).

This patch series introduces doorbell-manager to keep the doorbell
handling at a central place. The fundamental changes are:
- Introduce and accommodate a new GEM domain for doorbells.
- Prepare the AMDGPU ttm backend for handling doorbell allocation.
- Create doorbell BOs for kernel-level and process level doorbell
  opertations, and place it in existing structures.
- Modify the existing graphics, KFD and MES code to use the
  doorbell-manager functions.
- Remove the existing doorbell management code in KFD/MES.

The idea is that:
- a kernel client can call doorbell manager functions to allocate/free
  doorbell pages.
- a usermode app can directly allocate a page from the doorbell bar just
  like a GEM object and use it for different usermode queues.
- There is no direct UAPI change in this series, just an additional flag
  for GEM_OBJECT_DOORBELL, here:
  https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

PS: This series has been sanity tested with kfd_test_suit to ensure
    it is not introducing any regressions due to kfd doorbell changes.

Alex Deucher (2):
  drm/amdgpu: add UAPI for allocating doorbell memory
  drm/amdgpu: accommodate DOMAIN/PL_DOORBELL

Shashank Sharma (10):
  drm/amdgpu: create a new file for doorbell manager
  drm/amdgpu: don't modify num_doorbells for mes
  drm/amdgpu: initialize ttm for doorbells
  drm/amdgpu: create kernel doorbell pages
  get absolute offset from doorbell index
  drm/amdgpu: use doorbell manager for kfd kernel doorbells
  drm/amdgpu: use doorbell manager for kfd process doorbells
  drm/amdgpu: remove unused functions and variables
  drm/amdgpu: use doorbell mgr for MES kernel doorbells
  drm/amdgpu: cleanup MES process level doorbells

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 174 +------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  17 +-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 230 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 148 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  30 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  20 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   2 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 232 ++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  27 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  40 +--
 .../amd/amdkfd/kfd_process_queue_manager.c    |  23 +-
 include/uapi/drm/amdgpu_drm.h                 |   7 +-
 19 files changed, 487 insertions(+), 505 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c

-- 
2.40.1

