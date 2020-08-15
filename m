Return-Path: <SRS0=E5ou=BZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A7C433E1
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Aug 2020 01:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5758622E02
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Aug 2020 01:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FGx8yB3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5758622E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D716B6EC55;
	Sat, 15 Aug 2020 01:25:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B3D6EC55
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Aug 2020 01:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrtywA+WWPny8pCH/7GCU/gZk2eV4aBgncz24/ffLpvTOLJ5dLgjr9s2ZF2EQgXe7c4sjX+E9rbLhevY7seAWaprFC2Sfn7IUWuuoQ2ePE7LTk+HFAULnyN4f+vTwyaNkH63cxsw+/gKEZ+eGhgbazCUkYnoYbLeznPL+X34jFosppb5Ew9YuTZicST8NO5DYqq4q8U7+vIC49i7+KY2iMxH4y2FiaBDiuYLFqnpvxO8+orJLVnZ5hCB5g1G2cwu0UhhxI1tEJzVKzi4AW/FhoK6MAYaowZFJYBwWmwA2Md3EPXOtZbqjP71jzaf9q77FBBwniE0ZsdViaAtgkKi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Qb1LSyNOsQawFHK1QkHqfXCflWZO3YBVSE/zRmHiI=;
 b=bwARV1J23BUOkuKf8bDweXgsZLacRwMpA7AwJQup6h1x2/BiecWbhKllXddWx2p8BjeETq/+ZB+g4K5sRxE0gxBfsCCW3sAyvRcRVbaclxIWsJUP35yKWPjCucHf2qv66VoBF9uPoOjacg+8vLVLr53dd62F0bgrVq2eGyHfpZ+KWVqyPpEHldF6P2V+cSjfEZzySWCxLtcrdukQVeK9chmr3bc++cn4LMCO7llNQroEmQulBJBKUkQEaRyqRbtS66u5t5EcMMFp5sB8eyYjknbgyhkDMarQv+9b130LR7RodYqTjCYhGSmzqmwpyTZW8zSo+32AAQWJB0GosM8voQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Qb1LSyNOsQawFHK1QkHqfXCflWZO3YBVSE/zRmHiI=;
 b=FGx8yB3xtwDsJFLIeVGzdL7cbh8EeFHsxif85uo99x/qZykpXWs0rtnt5Zp0ZXWMyl5+Dh7INZCyIaITTzl0++ZfTqosGeG3oy/GFXs/F11zLbYJX6Kfs8rtLnLWHQOSzL/1fJceuM0/eyXDtdYlp7S1FyEGPIm7HooNZPWSUPE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Sat, 15 Aug
 2020 01:25:47 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3283.015; Sat, 15 Aug 2020
 01:25:47 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] Embed drm_device and eliminate use of dev_private
Date: Fri, 14 Aug 2020 21:25:31 -0400
Message-Id: <20200815012533.7677-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.215.g878e727637
X-ClientProxiedBy: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Sat, 15 Aug 2020 01:25:46 +0000
X-Mailer: git-send-email 2.28.0.215.g878e727637
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d41ec4d1-cffb-4e44-4708-08d840ba22cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4436F1E1F08B4A7D48633AF699410@DM6PR12MB4436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEUTT+a7J13c6hDuVrDnPXNgb0LNKl+Dnq4jHsDNUNee/zaljxyzYBC22Ecu/5jY7jf0n0S9DgevEz11B6mVsV+syVide1+NkdM3NKVLk5XuRHEC3FiD4y+SAezaNDFmYUGZoHMrYTxiXCdwgLkWkfU8Nqpy/C8S/2LGpDJZ9H6DUe8yzSxrh35MUQC/RF4yoYLQcgp1t1uOo65X0iOELTv0anS734OlEalHfu7yTfjm1jCeIP8IQKMcsL02O0IlTzRL6fJcSGrzZpn6qXovoBt9//t5ZenMo1fmflqVYMTofRKB4qEj66C4e5Svrqx4y2nfiQfV/ZK2sMP/kCIq7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(316002)(66946007)(86362001)(36756003)(52116002)(66556008)(66476007)(7696005)(16526019)(956004)(478600001)(1076003)(44832011)(6486002)(26005)(8936002)(2906002)(186003)(5660300002)(6916009)(6666004)(8676002)(4326008)(83380400001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gZVmFKpCeMUBR1SiPfN/kr0ZuLlCXVp7uCyhvf8o6byFWbwAhIhA3RIK2IZw9SWfm/klkeycbFI3AKqsfmH39BvHsi9Vdt7e5uX/mjE1QtkiZMBUw2q0HrNW4A1okFbpu+hrCcJb9RKTV+jTQeHIrc9uMOfZDB8pJxtaq+/kAryIjFhTlC3gF/7CoUZEKALM2JXQgIi2pGQiCUMC3SRnoGRZUYGeqT5vwh9fwK6uShUFfg582AjbsGO8dluseqjdyBoqW/sMbbE/s3aD3Yi7yW+dQSBnWks4fEvunSLlzXST6I8SI9G6Q43Xd3CCSWP8XHoE+299nvku68PtFM6txQxdwMtuDq/u56SdtVTB14boPhAma/inf6fyTRV8p107/7Of2QcMcwc6co6CyvcYvNmt5xx9ZUKTeXzYK8Ls2y4ytBIIAZOTKYBHv6yIkT1BiSTfxf1zZQaJpNdS3uLcqypi9ia5JvFGkgPHCqZ5vkN5wb4AlpJd4MyxhfYjgiAbr5DeCAEcPNSNtBr3v2XLJdd+UEz8gWp5vgrmhZwM+twTgHe6iYislj7kabb4vw+JYAir9MiMynY98zMJPdgEA/VeQCNBADsFA5Rw7nIL6uUQc3KwL8U4ns0+KogqyEkuE+1rxtEnc4BCqY8Vcq1c+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41ec4d1-cffb-4e44-4708-08d840ba22cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2020 01:25:47.0024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sh4e41IiKdr+hN+r1S4dCX8T0Kq72k1w4BZmZgd6yk40U0HgjbDR4dhpiPieP2sv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As per the comments in include/drm/drm_device.h, struct
drm_device::dev_private seems to be obsolete and it is
recommended that drivers embed struct drm_device into their
larger per-device structure.

This patch-set embeds struct drm_device into struct
amdgpu_device, adds accessor macros for both structures from
one another, adds a DRM driver release callback to free the
container struct amdgpu_device, and eliminates using struct
drm_device::dev_private.

Luben Tuikov (2):
  drm/amdgpu: amdgpu_device from DRM dev by macro
  drm/amdgpu: Embed drm_device into amdgpu_device

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c   |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 186 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  61 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  45 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  61 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  36 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 274 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c    |  22 +-
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c      |   6 +-
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  36 +--
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  94 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  96 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 104 +++----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  94 +++---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c      |  40 +--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c          |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 139 +++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   4 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   8 +-
 54 files changed, 774 insertions(+), 766 deletions(-)

-- 
2.28.0.215.g878e727637

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
