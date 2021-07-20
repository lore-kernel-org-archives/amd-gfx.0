Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EABC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775CB610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775CB610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF5689A9F;
	Tue, 20 Jul 2021 15:44:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BA289A9F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONs4soDKa9S+AffJVmDlOQnVu32XVv3q7RySq7ZBzKIF85GFvEr5D8DMKH2LtR0sD0nHK/PQZtwgqOeMkP7cVbd19ok/07Ykr70qEjLzdha67aU7q4sLFiEgEfk7/IzSdmk3x3xQpYfoS+RnJqzkSYjMGkQ8VMFcyvKYwJCbSScXZOdgGksYgT9e1j5A9p1sm1SLm/mOjM0wQeBgW6eW8n0KNGLYOWNdmwF1xjtU7T2UuIkvJTPui0RIAwmyyzBynHaPRoSev9uxoap+uXvCla7I/ykl44V1+LYQYxxVJP/CYS8+n53RY1FXEUcD4w23GXnPn6VG8pksExsVvoxQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJsESBS+oMA2sV3CHttDRXvM393SSAwJI1P1GnFjCDE=;
 b=T1eyKhW9bcZGdSzw16AZVSQPC877pLXXZ1Amw2prEBzq/MTswuOvAvxYbY1Wml0NO/6+mP0hPC1j1cxsmO4Hmpff8hFpeMblOSN2yZOZN8vb+O5br6EM0qMqx4smbBd9NJIB9HxuszWg7vSoQI+s4qZ8pjBl72L642pMII2V1A5uZslaJ6KSGT22Ed+fUqhk3GgFreslqhmRaW+gak1UlWVrcUrPz2Y/2QyaQhvVOilxTfte3uDGXEGKsHrP797EwrYqXBsOl4gYIXS8WWFqQ7e8Hpb4nYwPNMRWmwZOoe2qCA6ppdh45s+0t8tNmkCiZol8ZSC2/tTdGMCikoFpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJsESBS+oMA2sV3CHttDRXvM393SSAwJI1P1GnFjCDE=;
 b=174dll0VCQ4q3XCuGl/Tq7zMYESacb9QmSNbRYK1WeLGCCN2xfqNA0/6iQTvdtSMVrBdLqemMm+1se9NNy9gFO2ox9JYhsOJVI1Fccv96rYjF/VzGXKboO8oozhGmYyDPrqjNY7NdI3Z44qXYPdUOIiLO/tTQIa5b5rI7KY9zoA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Tue, 20 Jul
 2021 15:44:03 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:03 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/29] Cyan Skillfish support
Date: Tue, 20 Jul 2021 11:43:20 -0400
Message-Id: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a59f5d14-68ad-44ff-9319-08d94b953311
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50469BE8DC4E613315082AAFF7E29@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LksRfOY7ysWBsL2W6BNmpOEy3gAk5ijhkqSxqcogDsfc2zbIo+4doCHCodnq1pkiHtWMHl18vdX/en37u5vQFxT28LYgUK5qgPi6/HcSQ29J9AgO+LgJxZXwVn0ct4lEMPA+NgrSzluMAwXorUZhYU0kSsXFN9nTnrUS2IMKQi+o4NodcCh3Q9S8gUeP6FKosCQKR2XHHLGpwIOP30e3kq0BotERWj+DqRigiBB72OgPM0dPy7+F4kjtjGlQgvUV++mTX1xtUGx+6we1gH2OSVyNPACbI+zp+Bqy3H4kYs/VlosOsSkcdtg8Jlif/OqkLCHxe13u3XBCvjQvrM56z4KztBmyUSbZyLhnwpyIXgAoIMyIx3Co+TOD8gxS0tIyB/JDuqlYy+b3Qjb1gL+uyyueyK7VfRQ+PowqWy7pMlduTjG1EiRSQ9+cxwAf/YRKcUZkMqlhEXeUUwYwFvlO8FUscJr/e/4dgTe/lYRXnFyfYQsUZc+yE9sUVAPrh4WyC46U0cjGD5aut/JRLCB183PsEDlsbgz1KMsRTXeOLDergE+IM++bKdhhNSB74AA4exy3+qhqDMIJ5bFUYW6hyLO3NhvH0zZ5VW+ktlfT45gl9Hbh8FWGo/3rWzqiil5GkvIJC00X8UETZEacn+6F5UhEYXs3uu4s7GudEJCYvdaPyIu+gKfXYVZ3bZ53Pc33
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(38350700002)(4326008)(478600001)(1076003)(316002)(956004)(86362001)(5660300002)(2616005)(6666004)(6486002)(38100700002)(36756003)(26005)(8936002)(6916009)(66946007)(66556008)(186003)(66476007)(52116002)(83380400001)(8676002)(2906002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCFmgoBtI9nGkEwp2AxK8BicpKdwVuSAWIY7hHiJMhiEZkldgjRWVYh6G7Fm?=
 =?us-ascii?Q?wurI+1m1HJVMxdbMVZZat5vPK66YwRKWq3Oz+68K0TqfNNlD1QPnPPvRje+q?=
 =?us-ascii?Q?soJAdoQ5XJwFjUp9JU774bUDAdRUaAZZivonfCcUlC4V8x4BHi+YzDnR/zrQ?=
 =?us-ascii?Q?mGj7FgxhOWixABCLHUZ7Dc/CR5B1HT9jth/q6mTsTyzeSePROgeo8MnL8Jt/?=
 =?us-ascii?Q?ZrzdnWtj9BxNhbpm5ZxORp7OqUIRUypvBh/rcThbzGGD2Nwhm/NBa6CVoQhj?=
 =?us-ascii?Q?YXt/MuaHqRicu92PhlDqeoNwUBp6SCGKeXRsZ3G9yrDlBmOBiy3E5bv6LNpY?=
 =?us-ascii?Q?a2wcPMqNF4l/yaywISgr1175ZOiV0WERa3m7FyGAM73BrW3PeLJFAMoQQaou?=
 =?us-ascii?Q?NU4pmmQ5OpHXARvAogi0eliQHa0vWAAbomboj2MZgovHhKChhIYyFEgDaxE3?=
 =?us-ascii?Q?FC5Mr/2/NTASXuUtmk7qGuDXTz7BeF6woLBJg/ahHdPAiVjaFkkW8z+upjpY?=
 =?us-ascii?Q?t4kC4349RtXonpixAqLAoYJ39TSA9FlIu8eUjm3aVKt3CtfuxXdBabPLyRjS?=
 =?us-ascii?Q?U9gmFl0NketuxTVLbRikVTCjGbchU4zTp3HAFWRwLEVw4vl8bqwHGmQU068i?=
 =?us-ascii?Q?rCqWlR6yh00qqOR1FFx82fjuWUdo/rRPtLt8adfkeVL3cpC3tU9M5vOLxdEl?=
 =?us-ascii?Q?ifsQfEvQ1xye9V9DHO2zmufKyGaz6WnnbVEKi4yBXLlc4FH7+W1067DVP3aM?=
 =?us-ascii?Q?uwN8YNatH0qwUF2mdEBMDPa9fkTqY4OZA0PhWzWS4/ZJ7KKnBt3XJEMogLvU?=
 =?us-ascii?Q?gdtuSe6LBxWmMilIMfrSpahiHToPGKQlklL+kTeuITM8X636AIV6zAVQTs9y?=
 =?us-ascii?Q?bAvq8erf4vwRvayVM+JYU3hQ6MpI8o/vgq17KhsOhOj6UvHgizJTxiYPasC7?=
 =?us-ascii?Q?UIVFbM5o3k0GfryQlHKtWxEMkeDUAJ0nb5qFbhQ9gY1F47s8CR/00vKhyO7p?=
 =?us-ascii?Q?VVZGoX6cYf3SAT2fWP9bA+PLcFM4+PLB9raYW6NfTYBRT+EALpEeuRKdxU6I?=
 =?us-ascii?Q?YXeQ25JFP7LwsCEo7osVzdDSazloXHFsGvDicMM5TCWLLK91BBDiCByFkoqV?=
 =?us-ascii?Q?BCdpUssHs/v08pSYVFc55MCsImR1m/DFGe/iV/ZCKnzC1S/B2kLQRp45HJi4?=
 =?us-ascii?Q?xczo1YiajhN2VL/MEMDXf950fLF6SEe5XG1Tni7d1NRoRfU8aogUamX/fc+v?=
 =?us-ascii?Q?ex+NMsSDqqJRpjLrrIJiv3hKN6HPLdltSI7T6RJy8TRk9IJmcqB04D8nIK5W?=
 =?us-ascii?Q?gZP0pAdaYFAeQijYHfEaJP4C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f5d14-68ad-44ff-9319-08d94b953311
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:03.1692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2rwn//iOfNOM20ubTQRp1e8wHdg4VwS8D6p7ese+AZnPeBK+vWX4nkKBbpGqfXvy5P/WH+g+3Z5QdnaV/GwnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set adds support for Cyan Skillfish,
a new GPU from AMD.

Lang Yu (13):
  drm/amdgpu: adjust fw_name string length for toc
  drm/amdgpu: add mp 11.0.8 header for cyan_skillfish
  drm/amdgpu: add psp v11.0.8 driver for cyan_skillfish
  drm/amdgpu: init psp v11.0.8 function for cyan_skillfish
  drm/amdgpu: enable psp v11.0.8 for cyan_skillfish
  drm/amdgpu: use direct loading by default for cyan_skillfish2
  drm/amdgpu: add smu_v11_8_pmfw header for cyan_skilfish
  drm/amdgpu: add smu_v11_8_ppsmc header for cyan_skilfish
  drm/amdgpu: add smu interface header for cyan_skilfish
  drm/amdgpu: add basic ppt functions for cyan_skilfish
  drm/amdgpu: add check_fw_version support for cyan_skillfish
  drm/amdgpu: enable SMU for cyan_skilfish
  drm/amdgpu: add autoload_supported check for RLC autoload

Tao Zhou (16):
  drm/amdgpu: increase size for sdma fw name string
  drm/amdgpu: add cyan_skillfish asic type
  drm/amdgpu: dynamic initialize ip offset for cyan_skillfish
  drm/amdgpu: init family name for cyan_skillfish
  drm/amdgpu: set ip blocks for cyan_skillfish
  drm/amdgpu: add cp/rlc fw loading support for cyan_skillfish
  drm/amdgpu: add sdma fw loading support for cyan_skillfish
  drm/amdgpu: load fw direclty for cyan_skillfish
  drm/amdgpu: add cyan_skillfish support in gmc v10
  drm/amdgpu: add cyan_skillfish support in gfx v10
  drm/amdgpu: add sdma v5 golden settings for cyan_skillfish
  drm/amdgpu: add gc v10 golden settings for cyan_skillfish
  drm/amdkfd: enable cyan_skillfish KFD
  drm/amdgpu: add chip early init for cyan_skillfish
  drm/amdgpu: add nbio support for cyan_skillfish
  drm/amdgpu: add pci device id for cyan_skillfish

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   5 +
 .../drm/amd/amdgpu/cyan_skillfish_reg_init.c  |  51 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 103 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   3 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |  27 +-
 drivers/gpu/drm/amd/amdgpu/nv.h               |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c      | 208 +++++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.h      |  30 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  50 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  20 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |   1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   1 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   1 +
 .../include/asic_reg/mp/mp_11_0_8_offset.h    | 352 +++++++++
 .../amd/include/cyan_skillfish_ip_offset.h    | 714 ++++++++++++++++++
 .../pm/inc/smu11_driver_if_cyan_skillfish.h   |  95 +++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |   1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h   | 152 ++++
 drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h  |  70 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   4 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile   |   1 +
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  76 ++
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.h   |  29 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   3 +
 include/drm/amd_asic_type.h                   |  17 +-
 33 files changed, 2035 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.h

-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
