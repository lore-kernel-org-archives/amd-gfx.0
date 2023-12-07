Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E92C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0121410E0D4;
	Thu,  7 Dec 2023 22:54:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0FD10E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y47bNh6Bo2Me4tYLhVym8vtnfUWE9X+v5CM8YmVb5j31mL6QtkFJiPke0+6jh9FUEcx5mPSslYbJGjKM//jJoZ+0G2mnwQctV+MA4cbOfAgx3s1YfQnyt1/BefUfIlsNy8ZRVYInMfbpPcC+NrvJGcFDl5ScbjpFVD7CzIoSPfYZoFxTK2jpOGKUv5orfkykBsmR8Xxrq1O4JB2wrgOtDv4PobNvZStkyJ+pFi2O9zBtv2BTRpabbH58KDWY1ZX0KwFgSsyZumuC6/ddXHSGs9czpk1XGnVA3YP5TAhwubmo3IJw3ve6X9NNqhqUKWsQXEBX3WIzILCVnh7m0VtkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GHMJEjBBWiWwho17VcLen/UGG9J7Cvs631emhX1Jx4=;
 b=TpSWb49TyYfrQqOdYCG/Z4nY4iqvmMuIIVU4ZuSIUESXUGHh3thf+i9EMrXJPQJUK0accvMURsBzneko2el52qQY+VEyGTqgiha6FNf4p1dqeoDv+YCdL7zQhmB4sWQcYeXicnFEF8UE1Hsn5PHE3eo6CNLlQ6xsyIjzQtsJGosV8S/g1g+Vy9C2Q/6i9txEHjXJ/eKVq6KYGTuXmiX84QH9XwKRbSq9AeVyEPpCfxo30nqEUx9Lxndsnd/7Bw0IC7/dMHgDlYvllSgAg6lXqIUu1SoQwQiiw1TfXPBU8R3qfAwll4ivSsrPIZQ6IuSTu+syA+t6i6/ddoD2BCzc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GHMJEjBBWiWwho17VcLen/UGG9J7Cvs631emhX1Jx4=;
 b=VHbjmq5Z8DWL3VkcLa2XBJ5mNqewwxxvJGDfOMfqQI4XkYII0mH9bFvF2bitanx9yEXtqKJUPSbAjg/RCnVZ6x1J6wzkAhl/rZI4GDZHzNnVBRW5a2I6OmxlW74A+Qii4MYBiOTmQhLSWpVEZ55i6MlQDH6Ebayg6BPRg3thTL0=
Received: from CH2PR20CA0025.namprd20.prod.outlook.com (2603:10b6:610:58::35)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Thu, 7 Dec
 2023 22:54:35 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::e1) by CH2PR20CA0025.outlook.office365.com
 (2603:10b6:610:58::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:34 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:33 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 00/23] Support Host Trap Sampling for gfx941/gfx942
Date: Thu, 7 Dec 2023 17:53:59 -0500
Message-ID: <20231207225422.4057292-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa0177b-328c-462b-496a-08dbf7777b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWKSu1aSHP2OHU/e2n2mdzrE/VpY4SwLwk5mqWmlLUiP3tPHL36lWo4/QKSnz6L45LYCY5zCXXgS0QEjoPFBGTa7I2K6x2NcoK0bPsJLevFcIMv9PSEA10/AEhXHN/7VPYiku+d7egjdapkYe7SMxSgoPY91qZePF+GEBwDGpTpMCiXahZ7JB5bm+inWvUXXoDByuQLAw4zm5o+1RdCR+7q/2SU6vYmMbhEqMwDZCAxx1u3ERU1K0A4ob3NT7OQyTecWolo2xx7XQXJMoH72S32eZe8SgkyOAACT5FG1KzNpmW9N/sJGz/HiNB9G6Bp3EVDcWA8yjFIgSL2hs5Xs2PFp6IsOma0yfuf57q2rgHmR2cew35mExwRiSjUgg44hXKU0najFa2YSJV30m2x6V18AUXstUAMxf0MZHU6oDW7oQ6QHARzpjrQG/J/vmk7VKQ3Qa7Xu4OEbLEJ14q2Pjtz3WXzBju9NE1XSJtoVTPJW1pd0rrZrFrpolYGlFXWdfQf4IKRIiLTqMdMqk+8xRwOGvRFy6sM657D7+DMQc81sLKsLQwZQ/uqL2DKZAAY7uC9CfSRBmLOL+9W7DxTZiehrZPXQvwfOYUJKVUHbyUqWEwwHtPVofSizW+0eWPQ4UTRLQcnmSGUKo1TAG5RQlPRFbDtfqPReae5L5PopLSpeTnSh7Uy7S486OUb3r39GX9iN7vy5mZK8Er3iNgEkvdckrfKjFaNir73ZEdFIaBxU2kJnq+t99rcvqKTxnbLyPK9e0XR6NazWO4YIJwEfew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(46966006)(36840700001)(40470700004)(41300700001)(36756003)(2906002)(5660300002)(40460700003)(26005)(47076005)(81166007)(6666004)(356005)(82740400003)(36860700001)(7696005)(40480700001)(1076003)(16526019)(426003)(2616005)(83380400001)(478600001)(4326008)(8676002)(8936002)(336012)(86362001)(6916009)(70206006)(70586007)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:34.8432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa0177b-328c-462b-496a-08dbf7777b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PC sampling is a form of software profiling, where the threads of an application
are periodically interrupted and the program counter that the threads are currently
attempting to execute is saved out for profiling.

David Yat Sin (4):
  drm/amdkfd/kfd_ioctl: add pc sampling support
  drm/amdkfd: add pc sampling support
  drm/amdkfd: enable pc sampling query
  drm/amdkfd: enable pc sampling create

James Zhu (19):
  drm/amdkfd: add pc sampling mutex
  drm/amdkfd: add trace_id return
  drm/amdkfd: check pcs_enrty valid
  drm/amdkfd: enable pc sampling destroy
  drm/amdkfd: add interface to trigger pc sampling trap
  drm/amdkfd: trigger pc sampling trap for gfx v9
  drm/amdkfd/gfx9: enable host trap
  drm/amdgpu: use trapID 4 for host trap
  drm/amdgpu: add sq host trap status check
  drm/amdkfd: trigger pc sampling trap for arcturus
  drm/amdkfd: trigger pc sampling trap for aldebaran
  drm/amdkfd: use bit operation set debug trap
  drm/amdkfd: add setting trap pc sampling flag
  drm/amdkfd: enable pc sampling stop
  drm/amdkfd: add queue remapping
  drm/amdkfd: enable pc sampling start
  drm/amdkfd: add pc sampling thread to trigger trap
  drm/amdkfd: add pc sampling release when process release
  drm/amdkfd: bump kfd ioctl minor version for pc sampling availability

 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   11 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   14 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   73 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |    7 +
 drivers/gpu/drm/amd/amdkfd/Makefile           |    3 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 2106 +++++++++--------
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   29 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   44 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   14 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   11 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c  |  372 +++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h  |   35 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   43 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   32 +-
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |    2 +
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |    5 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |    6 +
 include/uapi/linux/kfd_ioctl.h                |   60 +-
 19 files changed, 1813 insertions(+), 1059 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h

-- 
2.25.1

