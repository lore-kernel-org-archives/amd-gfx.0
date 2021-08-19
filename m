Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DEEC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7719F610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7719F610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA1E6E90F;
	Thu, 19 Aug 2021 13:37:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F096E90F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+qMTDSRlsU1RTl2QGu6+OvGk0fs0JzdTJP+lr6ZzXEolQdtYc791iGJY+ZPclmIcdqbMQBkC4vt0QajMwc3PJu5+j7n2IrWKQyadbzRdIzGfsnDl1d85Z/1PXpWOmTyKBzQ5nRqhkqrtIIqWkGEVf+PWTVunEG/TpkPy+oIs5shbaD1Yp2obNWG2wcTwOjsbCeI+fT1UYMBLbmZW7DVdx2U+ggP2ytzTHXv03ghxDhMCsPGbeUOeDV7pGO0sCxYimrDOqhGRxO4es3jEK51BnVz7soCpWL5JSqjKs7pKXWaq1KbDsUVjryIMiqpIN2NiRYAmAyxGRA9U2FzQLbs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLAy2BgvOcCA7zg0ZaHfiFoomA2B8X9xRxYEf1Cnf9k=;
 b=irfDkGVIkW55f2I386M43KiXRb21wmGR+21jWqUNp4d32z4nYLw+CTdmXjTxjhIqOigTFgFHRCj2Jze8HuqTfwZoFSzFnL/D4zRYKPycRGYXXTEwb9J7nNAIEkqJUBRuAjNKmv/qtAVPEX5VlwnkhkZZQI2HPZhYu0PZSiQHtKrnL+FWzLv4JJ+FfxhJNS7JamMnQpicW1QXQkpckCheO8wbD4h14ZxxuqiBsYG6EO3HH/7N4iK/6AfA5x4o9Mlvyywm8rOmRvhxnTqtngppD25eN5b25pMV4VFaIyarQn5eCAM13zvPMtltq2n21PXPTWvh/h9sg5zZcdxIWElsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLAy2BgvOcCA7zg0ZaHfiFoomA2B8X9xRxYEf1Cnf9k=;
 b=T8ySrzrkF3iwGUXAym2fXPbK6tW3XXdBbsoT8dbWRe4EElr4qFKVPCrjklGaw1DHATRBPsJuQGGqmzI5hR0FEngMlaqCtrgbN6gnaVeTOPYNPB76cvWWRRmng/U2RuWqW/RvNfXnn0njBlZfatK/Sw4VtllOCoH3eoYwKRKALas=
Received: from MWHPR2201CA0057.namprd22.prod.outlook.com
 (2603:10b6:301:16::31) by DM6PR12MB4714.namprd12.prod.outlook.com
 (2603:10b6:5:30::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Thu, 19 Aug
 2021 13:37:46 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::90) by MWHPR2201CA0057.outlook.office365.com
 (2603:10b6:301:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:46 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:44 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 00/18] CHECKPOINT RESTORE WITH ROCm
Date: Thu, 19 Aug 2021 09:36:55 -0400
Message-ID: <20210819133713.4168-1-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c70205e-6263-4c68-b384-08d963168782
X-MS-TrafficTypeDiagnostic: DM6PR12MB4714:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4714B74731898221D10A51AF95C09@DM6PR12MB4714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOdDBuc1f5TCZq4tmIKU1OWzg3Ipi5XZ9B0isq70bHDwmxmTHLmHyU5wdam08Qae8QJE4k81HN77/YHgMNdKaDoGGQfv7JF1Fm42gfs69Wk13fV5JdJNj5sYmxxF0BOD3Na9jwfTqqsMbVnbncSvNwUkajOB7UgwM62rticRTmO9+2J4j3VirMPPzF3T+uKuVbIFe18IOhnLzkNDyl9OdOKH+XbKZ/VWpW35QsjBWr3ZwnybH9PlnyvJA9ezpJtohHDXht+img0sEGYDHrgNP/8DItwAUtUoQmsbMmQqkyRGCskvMxRnB2Q5dFr9BJZp2Ai7ajaxKPn3L4GiVgUcXtdNMapWpAigBCza0ZU6LNxjRO/ef/ZVPJ9fMW00+Fc5kfQSmyfUw7e0cJ1S9FkFlfIBGjLZvc55TGWIulGqDTpXnTk3uJObCpM9dKqlTWteThuVyjO3Rjbg0EE76VLEiVEUZvARkM0tx/qiCzI3GSkoJFv8TguVQX8IUlEddad2QjfAvYjF/76VQ2MWrFMLyQj2CwQ21ks7dO/4xLWkBOc77SJJPCnl/i2vsLJGf4Tglf5qWc9dEE6Dv0KVlkp6TnZZYH967ECSNDlY3gCCtgOg5L5x21SPqYyAIJ5dQ0EVov4ofhGqab5eJIF2Or01X3a1h7+0lq9y5VltnF5fJ7zPGqppNibHPVau0uEuDb3zK1Z7pJ9YlWhP6BD5s4/PDFh6iw4g4xGs5tJ8It1NbMwM+61CH9ba63bd2znK7qVmnHTTI2ZQ60E7x1gsgE4t9cYvmfOYSyNjv3mRhZ1EK9mhHs85XxCLJ3yeQhbX29KSoaoPXhfiBk6CTGDQQ5namvsNqAN2NUyMMen+drO77gQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(6916009)(26005)(2616005)(36860700001)(1076003)(336012)(186003)(82740400003)(34020700004)(82310400003)(7696005)(36756003)(5660300002)(2906002)(83380400001)(8676002)(6666004)(8936002)(86362001)(47076005)(316002)(478600001)(426003)(966005)(356005)(16526019)(81166007)(4326008)(54906003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:46.1976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c70205e-6263-4c68-b384-08d963168782
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4714
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

CRIU is a user space tool which is very popular for container live migration in datacentres. It can checkpoint a running application, save its complete state, memory contents and all system resources to images on disk which can be migrated to another m
achine and restored later. More information on CRIU can be found at https://criu.org/Main_Page

CRIU currently does not support Checkpoint / Restore with applications that have devices files open so it cannot perform checkpoint and restore on GPU devices which are very complex and have their own VRAM managed privately. CRIU, however can support e
xternal devices by using a plugin architecture. This patch series adds initial support for ROCm applications while we add more remaining features. We welcome some feedback, especially in regards to the APIs, before involving a larger audience.

Our plugin code can be found at https://github.com/RadeonOpenCompute/criu/tree/criu-dev/plugins/amdgpu

We have tested the following scenarios:
-Checkpoint / Restore of a Pytorch (BERT) workload
-kfdtests with queues and events
-Gfx9 and Gfx10 based multi GPU test systems
-On baremetal and inside a docker container
-Restoring on a different system

David Yat Sin (9):
  drm/amdkfd: CRIU Implement KFD pause ioctl
  drm/amdkfd: CRIU add queues support
  drm/amdkfd: CRIU restore queue ids
  drm/amdkfd: CRIU restore sdma id for queues
  drm/amdkfd: CRIU restore queue doorbell id
  drm/amdkfd: CRIU dump and restore queue mqds
  drm/amdkfd: CRIU dump/restore queue control stack
  drm/amdkfd: CRIU dump and restore events
  drm/amdkfd: CRIU implement gpu_id remapping

Rajneesh Bhardwaj (9):
  x86/configs: CRIU update release defconfig
  x86/configs: CRIU update debug rock defconfig
  drm/amdkfd: CRIU Introduce Checkpoint-Restore APIs
  drm/amdkfd: CRIU Implement KFD process_info ioctl
  drm/amdkfd: CRIU Implement KFD dumper ioctl
  drm/amdkfd: CRIU Implement KFD restore ioctl
  drm/amdkfd: CRIU Implement KFD resume ioctl
  Revert "drm/amdgpu: Remove verify_access shortcut for KFD BOs"
  drm/amdkfd: CRIU export kfd bos as prime dmabuf objects

 arch/x86/configs/rock-dbg_defconfig           |   53 +-
 arch/x86/configs/rock-rel_defconfig           |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |    5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   27 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 1730 +++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |    2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  187 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  254 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   11 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |   76 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |   78 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   86 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |   77 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  140 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   69 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |   72 +-
 include/uapi/linux/kfd_ioctl.h                |  110 +-
 20 files changed, 2743 insertions(+), 314 deletions(-)

-- 
2.17.1

