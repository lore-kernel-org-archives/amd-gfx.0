Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D358C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5208710E884;
	Fri,  3 Feb 2023 19:09:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5701910E884
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuRIiF7s2ZQ/z5Ef1EpN0VEomaFD0msbga8Ce2sZWAL63fYPPP4TH56F01w99TR7dxGc64rrZNqOVdNf/L7DCEzxw0HYDnDzwK3TN+1YfYLjt4eU8mFBmvlyBc+8L0eFC0WPsIaiqZpR1wgYPDlmXxp1LBDXYqjIeUBdf7qVCvoH9lCnKfBwxIVLlT6DPdj7g7XYhE4BLyf1rEFsX0FiqZd3NjQftKBPffAWCfdfKDSHDhCmB8G674u0gyRWsGSnlyDM9Uo/pJhorUbwxaFUMeUfU6t1d6/Qn++ESaZyuqO8YQ7/COi3azF3k8MyzskntsKQ82BCwpmSmyYhW/xLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YZbd+MXakd5Vnxf9agtasp/J+kqYR2Dk5alNWssBjg=;
 b=JSW5W2jRgbf2+WjEB6rFdnxbVOuEwiGOEJpvKTLnQ75CvDZvy8pZgCTjn0ufhccELrmghCWwLJBoEXD5k+1I6h1yIJ2em47iwDqmHMxEm0BAKkA1umVLFSSrDeZBp6xKuv2rlKHPo4O4HVf76TIc4lPkOHGExBKv57Io75Qrh1KC5ilDQf/laKS+ESboTrgQ+YfFd9d3RCcC5z0HEq7AJkFSFQ7gRRCjavd3tR2tbt+gaUxWhgmYRhyhH80M8WFHU/BQ+phioY3189bV7w5coa+d9R9hgVlb+k5nRZqRZpPFCTlw/a15sbJl0JJSExOZsyq8dSJgkh3o5vWhhkaPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YZbd+MXakd5Vnxf9agtasp/J+kqYR2Dk5alNWssBjg=;
 b=LaKqBL/LtceiskcPdrUQhIYw7+AgxCmkA3niqBEUbrCCZmQQQG2uvbdwN1Osoy81BBNsrC8wao2BURf4XUjsvtctn1bVbjNY+Hv9svERVkIB/XvEmU/Yu0f6J8XHxWr97kvAjMeq5fHyOlDUyqBsJXf2f6oy9UoXo3IQTS7opHQ=
Received: from DM6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:5:80::46) by
 PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31; Fri, 3 Feb 2023 19:09:13 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::3c) by DM6PR08CA0033.outlook.office365.com
 (2603:10b6:5:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:12 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:10 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] Re-design doorbell framework for usermode queues
Date: Fri, 3 Feb 2023 20:08:17 +0100
Message-ID: <20230203190836.1987-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7a426e-1bb9-49d4-70fd-08db061a22c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNEZzlGwtrud4QJSKqiwxI13qzHEUp9bMyvh9S7XeewxQSYP1cmRE/BBwya7hGTZN2FXlT7+XXjcKxpfzj2rAgY/iKT+IIaqw5HGcoWvnUBx83L/H8vIPXB+Cye3OKiYjZ5QqbWuzyhLI0Bdr9OptgxcQTXhUbMp3iOfG0dUEdxA1v1brY4E2E1y3STyAEuNDrNbCfkcfKOS46TcKb02UDnr0dUz+Cu47avc2eJ8rF79ShLGVmdh90Z6Dijypdb83C9k/KZ+/RLoGfHdUOIrRCYsr32yrTyY9ivvMEor1c1pgT0+nwLIqD+8Cr1Qaa77kuuyjwxRSNkpeClwwv1QFCy/6WCta2rBe++0E3bFvrfRhSG/CdAP893jBH7ZB4Cdw3A4yZdJWoqxtSYhFP0Po4RT02fEO56/hShEwzO8Rgzx+MytzAKE4CkEDYuqWhZNrmfXaLiAgPWlDltWP4n/VJboSOPC0eliao4XkrHO/P8pOnKxf2zfVGU4e5qqmYwD9gl8vG/rKWVO5U9XV75+nAn/bwBYbXQrBDb8GjUnzMtncMN38syllTYym3S19gdlFb2hERkY57xim1RrqN0Efg8syPvUf83FLM0SJ9iA8ica1T8R8oUm60vKAaKwZ88hiz2Kl7zO907/KrbpgN0JynIw2m/qIk+Jbk0X+4zQnMJOq1150dPRjUGeQwVvyCrT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(316002)(70586007)(70206006)(54906003)(4326008)(6916009)(82310400005)(8676002)(5660300002)(41300700001)(8936002)(36860700001)(82740400003)(356005)(36756003)(81166007)(86362001)(1076003)(186003)(7696005)(16526019)(26005)(44832011)(2906002)(336012)(426003)(83380400001)(40480700001)(40460700003)(47076005)(2616005)(478600001)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:12.4309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7a426e-1bb9-49d4-70fd-08db061a22c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
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
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch series re-designs the current doorbell handling of the AMDGPU
driver and prepares it for Usermode queues. The fundamental changes are:

- Introduce and accommodate a new GEM domain for doorbells.
- Prepare the AMDGPU ttm backend for handling doorbell memory.
- Rename, move and re-arrange some existing structures to differentiate
  between doorbell handling and VRAM handling.

The idea is that a usermode app can directly allocate a page from
the doorbell bar and use it's offsets for different usermode queues.

Corresponding libdrm changes: 
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/286

Alex Deucher (11):
  drm/amdgpu: add UAPI for allocating doorbell memory
  drm/amdgpu: rename vram_mgr functions to bar_mgr
  drm/amdgpu: rename amdgpu_vram_mgr.c/h to amdgpu_bar_mgr.c/h
  drm/amdgpu: replace aper_base_kaddr with vram_aper_base_kaddr
  drm/amdgpu: add doorbell support to amdgpu_bar_mgr
  drm/amdgpu: rename gmc.aper_base/size
  drm/amdgpu: store doorbell info in gmc structure
  drm/amdgpu: move doorbell ptr into mman structure
  drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
  drm/amdgpu: doorbell support in get_memory functions
  drm/amdgpu: introduce doorbell bo in kernel

Shashank Sharma (2):
  drm/amdgpu: initialize doorbell memory pool
  drm/amdgpu: add domain info in bo_create_kernel_at

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  13 +-
 .../{amdgpu_vram_mgr.c => amdgpu_bar_mgr.c}   | 300 +++++++++++-------
 .../{amdgpu_vram_mgr.h => amdgpu_bar_mgr.h}   |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  68 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |   8 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  53 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  71 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  50 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  12 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   4 +-
 include/uapi/drm/amdgpu_drm.h                 |   7 +-
 41 files changed, 482 insertions(+), 303 deletions(-)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_vram_mgr.c => amdgpu_bar_mgr.c} (70%)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_vram_mgr.h => amdgpu_bar_mgr.h} (79%)

-- 
2.34.1

