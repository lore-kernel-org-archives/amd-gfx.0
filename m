Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E016FC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 16:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D20110E90D;
	Tue, 14 Feb 2023 16:15:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD4B10E90D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 16:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqBEqjYOVCySUsNodkd7nH5gdtXj1d6LCyzIwup7AJYwa4Jv9RtrItuWqYA9qL92ojl+kGmiO9f/Cn9HMFy+ohTiJzPelaIVpuWaoC0gW3eFQhrzAaeAuPS8cm+r5Z6w2OXibYh3Jrt0hCfJgGoXqSW7N4OZO9uwCimXeNOjEOR91/Y2xinmGNK2jRcxmNPZshriqYFL9Oog8cP/ePm56KKycLe/X/IN65cGFEW7ysJVG49et78FeqffY4Pp5ODdWO5uteL+q/vzkK9Mn1wHnIf8mEuDMSZOunprMIyHQB86KHhrGiRU73fZrXyPqMf7HEiJNahKdBZPl6XOgPpBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYcG4bkQoGV8Ho/oZKDpw/woA8IA2LzA2Z0egCPeyXw=;
 b=c6ZcL6rpF/JwQA6bqWMrtgDOzlTNnui0UeWZunuKMPai45V4go+m07yPh9DbYmjQMcv+jagOYXEIaV1MIH423j1Scy1mGT9Cq2OktIkVWzr3a2464mJ1LGjLf7G7y0F2czwbgSg8GGGPAE6EJj7ndkIZmV9Qmll0qiwN5eCufOrH6ZjMKbIbB0XRXbIDvq6WsbezbKGBw+c7crJrP82ImUZCZSj1SQTPURFHrECDJS/qW7Q43AdQCX3nVi2ChzUSY5DV9pyPlNvoLoBYL9ZF5/t37Npei2389o2PcQVgB8PgayhErlNZYdV46WPed+OQvFL2NhJtTK+l+o1Um1rCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYcG4bkQoGV8Ho/oZKDpw/woA8IA2LzA2Z0egCPeyXw=;
 b=qgo6tkM2yHj0dTgwqu5aZTAzYDxYvOM2vIUq+oLKgyJ0uzOdiDS5nHlYjKNplPQFJWiQ7D8s6ov0pF5ixIvB+o2CNAfF65t1SxBoWdPRMXttemwuxMtADXpL1eF4+MjjgJKN5hSbl93NkOVdLZyZxfn/KAdxwO23XXataNecFdo=
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 16:15:45 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::f5) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 16:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 16:15:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 10:15:42 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/8] Re-design doorbell framework for usermode queues
Date: Tue, 14 Feb 2023 17:15:02 +0100
Message-ID: <20230214161510.2153-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f44e0e4-a421-42c3-65e4-08db0ea6b9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twGlpXkbzsOT3aU8eyHY7DNNWQ5eKED9lrCL3baoF7E6Chg4rejQE/98IrzDJKewLiSDRRKz7uQvYzbAh0CZd4PBmY/CknfcqEsCSE4YdDTu8+HDQqWQkozyCaVvIVbyy5AbaQ0In6VPLQ3f6yY8h+XszXxTxtMbI25YvdNuMbecZeojr0OfABvtIfVH1AuQY4vOjDTIVh9hTpblaD83vwFiRnUv6EXL/nXhHobY937SnLlI2nbz4y/JDHMqqV5RGYUzFffi52qfry6Hh7WOSzuXHQ1c/hMKI2uC+HmVlkIjUWUVtxiMQ6opPPgPvWG/41FHPjw3lcFakUf7nE5ZYIOy7y83gObOfPneHWfOZC5Xv9blvqLrm2K0FDbWdvdId6X4dkTebASkdhjyqRmooiEvqxKCBiP5fPy0+4sgXIvSQ+O+mvWrTv9Q5u9SLmBmIZbov7GMmJQsdm9bvTaZeQyy/7GcBbA3r7S3iTW7EnUpnNTvNEcAFwE6bzfeL/L+kjnfLMuYn/5j6D6QFygCTaVRqLseIZsIlqMZG2zQrBKwXFgU5oCJuAaaJT+RwSTtph+/F3fo4zWSVGnZ5jD4CGxitjbrhNyvFj5hgGwqVCWv3cKKXfDZckYo2lgGGtTgFvqvwnmXj561lyFFsu5xwi+69n9yVDoJcoEtpf6rjIkf5CTzUQixvbTGCfvAnFUd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(54906003)(36756003)(86362001)(82310400005)(186003)(26005)(1076003)(426003)(47076005)(7696005)(40480700001)(40460700003)(16526019)(2906002)(70586007)(44832011)(70206006)(4326008)(8936002)(36860700001)(8676002)(6916009)(41300700001)(2616005)(966005)(478600001)(336012)(5660300002)(6666004)(81166007)(82740400003)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:15:44.6599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f44e0e4-a421-42c3-65e4-08db0ea6b9d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 Arvind.Yadav@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch series re-designs the current doorbell handling of the AMDGPU
driver and prepares it for Usermode queues. The fundamental changes are:

- Introduce and accommodate a new GEM domain for doorbells.
- Prepare the AMDGPU ttm backend for handling doorbell memory.
- Create a doorbell BO for kernel-level doorbell opertations.
- Rename, move and re-arrange some existing structures.

The idea is that a usermode app can directly allocate a page from
the doorbell bar and use it's offsets for different usermode queues.

Corresponding libdrm changes (just addition of this new flag):
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/286

Alex Deucher (6):
  drm/amdgpu: add UAPI for allocating doorbell memory
  drm/amdgpu: replace aper_base_kaddr with vram_aper_base_kaddr
  drm/amdgpu: rename gmc.aper_base/size
  drm/amdgpu: rename doorbell variables
  drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
  drm/amdgpu: get doorbell memory

Shashank Sharma (2):
  drm/amdgpu: create doorbell kernel object
  drm/amdgpu: start using kernel doorbell bo

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   | 13 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 67 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 32 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 51 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      | 11 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       | 15 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       | 10 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c       | 10 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c        | 12 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c        | 10 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        | 10 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c       | 10 +--
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c       | 10 +--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c     |  4 +-
 include/uapi/drm/amdgpu_drm.h                |  7 +-
 31 files changed, 193 insertions(+), 137 deletions(-)

-- 
2.34.1

