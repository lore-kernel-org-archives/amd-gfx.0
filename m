Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC95C4167D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6980C10E9C5;
	Fri,  3 Nov 2023 13:12:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F7710E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzJCm5ANJF1TL4sqfWU3rPFY5MTzTycLx8bBLxTppwKcJ+KR2ELa9qRBpiyXbCuC01CQ/LO/7UcWbtdof6y69MkxWhF4d5BBRFiCODgx1oTn1Sp9cHyJNU1t5Bzs9dIDsardCGyIJPo7j5qcvDMoj8O9czcdF664HIBAgAfquDnMnCzXhpLS3hpOD5l68cDYDiYAy7/De18mTHihH9ZueY46Qqi1JwOeLyQAAABbLgHOUcjHh8LIB9JC5U38L3mEdbgkdhxk91EOR1B89doU5hUrLzRG+62Ftqh+rVl6OamMFY4SDZ/g51XBXqBVGE2hTN3s36EFkEepsi5wadlptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPyKUqUMLCmqsmny8lOkBfE3HXJypfIj2iAMvpTu46k=;
 b=XvLg2V/vBE6aMky6K1sz3jmxMTOH3cYG1pflWZRoiRvv4N4VfoSSRADfaANo/tVkD3+VEt1yMIJLQ7XV20zfkKYR7+or0GRo3W4RB2LmNz9yO41Exjl4eZUYjY6iFVYe0lg2O3JZugQO26Pl4WBk8KqBo/fCyPa6h+vIr0EouBKMFI78IydKh4x0SdI5y9tPP+ubsZJRHT7tYNaqsryHTfUuE3FZBrEvub+bi7KzasTmdZ8dlQM/NJh19LpwxPefBLtsX5hxpYHNVwxHmsSL6SXb8+Sc0SuoyrZy/d0lEAtBza6snG3QCRF6a5BatEiZcMoGipfGd9ZKen0hIA1UgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPyKUqUMLCmqsmny8lOkBfE3HXJypfIj2iAMvpTu46k=;
 b=xpzbGi/9Clw9zFaVxafG/6jLnyUlqkBTYTcdqiJwk/t1oyZreqTNXX4RIQ3BHVzgx900dLMG+f0y0HzF4xLv1QsFOPgHPE0xLt3M74qpAu6sO5dyKjyxg3DINN1rAN69B2cptvmPLbDcfdCFDud9L2Fv6aTNZkWLAKxu9xhSuRs=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.24; Fri, 3 Nov 2023 13:11:59 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::fd) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:11:58 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:11:57 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/24] Support Host Trap Sampling for MI200
Date: Fri, 3 Nov 2023 09:11:15 -0400
Message-ID: <20231103131139.766920-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CH0PR12MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 434a2fd3-afd2-4f89-07ee-08dbdc6e760f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0voVKzXkfVnDoGZsO9eGjkGw5JRpLpn/du2D5E/02iBxiEJLyhED/SdpC6VACyowuH+gFa7rIIyPxJSjO5MbzCGCBiOXUqRzKZiZhwrLJH2KIDC2AVEklbIAaG8y/ZB91KRcoDO+2IvmqfcaeGYiGIE3Jt1PQ+l1Ru2V3iD6uG13xAaSxhth/Ux6Wv21rCkj6gZ0Zs4VSXikbZtsZsp+gXUGZp+EcWcNrucz+mvtMoTifgXq7qkblb9LNzsSQqFvZF+lmW+h70KlbkJdoBowol2RyJluyeDe+ji3s4UZwaKapzcjEyUXJzd1zn9qqM6YFR2QP91tsh0WDHXkgHavKr7DHAOtOu2+4Kuaf5gzxW+9sNaL2gX+yKZnCxHfhT8PRMy4KPwlZxw1RKJmZ/jjH+0cn3ZZpb/2SiNKl2G3RZMDZCZXXYmSVejyMej1ScREvZYSUCkJu6m5J9RsG6VVJ1x1lvdrsl+9oFMwxXR3JBmRZ4J6hNGGA3K/JbRwXKebxqBlFt3U6/qiWGsnFzRUJQSp+kLraaif7AAmnO1A/1DamqkvevVCSsklfV/dMtUgNfeAIZf4v4Ala2FVpIDcbgi5MiXD36IrsHh8b5REdirc3BrWjfFP7FWPoLaDj5kzFbjeJUfsDQR+tOSaZ+cJuz0p1R3XauRZRV5I5zc1XMIlV8dOoJa1s0Ui87jmAxXfRenExjdH8HXxUHN6uGihCtDFsnK+vRL3mtdW+OsRDwkyxlyhfwxUj1dbBMIeN5y+nBwl1WAj/uIPMudTbLUFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(2616005)(1076003)(82740400003)(16526019)(426003)(336012)(54906003)(70586007)(6916009)(70206006)(316002)(4326008)(8676002)(8936002)(6666004)(7696005)(478600001)(36860700001)(83380400001)(81166007)(47076005)(356005)(41300700001)(26005)(2906002)(5660300002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:11:58.6548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434a2fd3-afd2-4f89-07ee-08dbdc6e760f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
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
are periodically interrupted and the program counter that the thread is currently
attempting to execute is saved out for profiling.

David Yat Sin (5):
  drm/amdkfd/kfd_ioctl: add pc sampling support
  drm/amdkfd: add pc sampling support
  drm/amdkfd: enable pc sampling query
  drm/amdkfd: enable pc sampling create
  drm/amdkfd: add pc sampling capability check

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
  drm/amdkfd: enable pc sampling start
  drm/amdkfd: enable pc sampling stop
  drm/amdkfd: enable pc sampling work to trigger trap
  drm/amdkfd: add queue remapping
  drm/amdkfd: add pc sampling release when process release
  drm/amdkfd: bump kfd ioctl minor version for pc sampling availability

 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   11 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   14 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   72 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |    7 +
 drivers/gpu/drm/amd/amdkfd/Makefile           |    3 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 2106 +++++++++--------
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   29 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   44 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   17 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   11 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c  |  348 +++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h  |   36 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   43 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   32 +-
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |    2 +
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |    5 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |    6 +
 include/uapi/linux/kfd_ioctl.h                |   60 +-
 19 files changed, 1792 insertions(+), 1059 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h

-- 
2.25.1

