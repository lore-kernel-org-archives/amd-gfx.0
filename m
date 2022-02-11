Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC073C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 220F410EAF4;
	Fri, 11 Feb 2022 18:59:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BE010EAF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibSMI3ia7067J2ykd+XwpLruCrunqveMGrE5f8QztqZSc9WRDGSIXFK8swJ15JoUlicRjqIaAkehLPphYA4rhnOYUM1GZDPwwX9eN9mAcArOtZrSi4vD/nLQRWfhlAWFpsjexZ024IUjafS+pCUFO6Uj86NRRVYI+ePsjdEWpN7qxFn5Omwo3EQtfIT7+jV+jgYamSZdeITdWSEzo0CAiMrDdak0g08wCWBstiOxDM0f7YyEUrGHhDgYYWLmkWLUuVn0cMr3ML9NVSPrcCjlONUkwgcaYcxlgC3nQPLPVOpxgjyChSBrtwrWMcsryvEIMBE4XfeG1m08fe7QiPgv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H69xwrYtt1P8iTFL9gmnUs1qqXPDsWY7HAXP4zDOPY=;
 b=nif4pngR8UGp0PV+AnzXkARyCIY/7YtsZbS0fj5C50KpFmfnOAzHZh+ONsMqPj317CLk4F4gcB2k3YlRBo2t8b6UzLy54Pm6icAqaUB32nQkMsuqOtjXf0hEPW1HfTy+tqNwAHFJ8cx5jSHZ8zb+q8AedXeXbDa44vOClKJJctNHD50hcclJmYx3tecPaP24s8vUdwHi/ad3SDjuO92ergG17J91MnGM5poJ+4wIrv+Ae0LSbD622pcfv8Lv0fIRXV9dmTqy3kQgdbAhyjcSjX8ZPSH1ZPShoZP1zFAezcJGsU30er/KEMpnaMF/xrxMMR5IhUCfv2OH0iebTPx0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H69xwrYtt1P8iTFL9gmnUs1qqXPDsWY7HAXP4zDOPY=;
 b=eX4pYCZC4r6KfSDo7b8upoN86hUnQGMxB+nJZ8kNLY2d0EigAOBNrNr0nV216sKTsLBWgriXjKgqCVyXSJtUJlyvfCSZLBbirVdAi+7UXsiL800REoinKu1E8q787TQLfMXVJAb3STnhIUu5LeJd+lsfSW9zGNpTFCQse2uZHDc=
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 18:59:38 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e2) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 18:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 18:59:37 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 12:59:36 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] General cleanup and SPDX update
Date: Fri, 11 Feb 2022 13:59:21 -0500
Message-ID: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a1a704-df13-491c-f21d-08d9ed90a6c3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4193:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41930F764E5BF3E1DB6DD966FE309@BY5PR12MB4193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYaTn8ewjjUUB+puFcAvA7Gbp82rKwYz81DeY2iVegDyiuRpKK6V6KGKlki22Ec8VG0pDUJIfM17XSHRgLPdUBBXHVXfAWa6uQXhY54kcGXRW9EjCuFbsqnWKoyRqabRverId1br5++x+W3NpYZL7y+i9tFYD+InXtYPEqdGIASSA4S+gpfHun7E1MIiVAddDRxZFIEfyjuKBFYF7OfcCT03l4kcz/otAvcRmzcCzPotsd50DNm9Yy472hnet+mncCbOOfENyasjz3bsCX5fIhZotvZe8+8XgkiRAA+uwIN8u5i1nxff7sKEqrvACi4JVRNcC8sa47CNvhP+7DtUJTMiuH1PoGvxrps/skLzkHv5N5hZib2UsvXIZdJYnUYvh/KNZ8EaAEMC9V1+IQW4V2a/On1eVzkTm8T5Npka7ONXUa6wj09DSoT5ze1WsJwsrolWT20yt3gSUq/y7t9V5prfnQHmaWEdpenNcXqwvcebWj4x8HZ531ouXN6WBA1DK+9MMzpuxHXYZBXPkmibDERGvROJHr9WqUkQ7yO+Vu7CCBB9q1w8TwpaO5f7ucSHx9WfHrG+yF/Y0Ueqw81dR+spYaWVn4lpxd0kh2fA7Yyx8KdvQSgqh5Qq9uSlgQlq60ow2PEx18ZBT1jTUNZIiY297M1dIx/IqcA7rwd5V93+b2CqgzRl04ySsFqmY4LPE+POtvw3bFsq6fkr3iw8bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(26005)(70586007)(2616005)(8676002)(54906003)(6666004)(8936002)(508600001)(356005)(6916009)(186003)(7696005)(82310400004)(426003)(316002)(1076003)(15650500001)(86362001)(40460700003)(36756003)(2906002)(16526019)(83380400001)(81166007)(36860700001)(5660300002)(47076005)(4326008)(336012)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:59:37.6693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a1a704-df13-491c-f21d-08d9ed90a6c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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
Cc: felix.kuehling@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are a bunch of warnings from checkpatch and kerneldoc style issues
that this cleanup series tries to address and also update the SPDX
License header for all the KFD files within amdgpu driver.


Rajneesh Bhardwaj (4):
  drm/amdgpu: Fix some kerneldoc warnings
  drm/amdkfd: updade SPDX license header
  drm/amdkfd: Fix leftover errors and warnings
  drm/amdgpu: Fix a kerneldoc warning

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  4 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 14 +++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h         |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  8 +++++---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 +++++++++----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 +++++-----
 .../amd/amdkfd/kfd_device_queue_manager_cik.c |  3 ++-
 .../amd/amdkfd/kfd_device_queue_manager_v10.c | 12 ++---------
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  3 ++-
 .../amd/amdkfd/kfd_device_queue_manager_vi.c  |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h       |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  5 +++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c    |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h        |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c       |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  5 +++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  4 +++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 ++-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  3 ++-
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c        |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers.h  |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h   |  3 ++-
 .../amd/amdkfd/kfd_pm4_headers_aldebaran.h    |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h  |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h   |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_opcodes.h  |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 ++-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  9 +++++----
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |  3 ++-
 50 files changed, 137 insertions(+), 94 deletions(-)

-- 
2.17.1

