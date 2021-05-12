Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48CC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F362561420
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F362561420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2206E0B6;
	Wed, 12 May 2021 17:31:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9E06E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0fB2l/sAPavbwpAbvO7Ww52AlsDKSwqUU9WhJJFseE3phSNarFy3XMQbGtpIIPF9A+Kkk1N9gkWa7P0DYXWGijq/PRmwoPsaU2BpgcEufdthJvrS0LTOry+BHINkmHR1HQz1EDmu2VCiZXIC0X+PM1PL6AY2QT7oxZdVgNvqcbM6OXWHGa00Ietxy/x9DPIwh0KSLiGQTS4XEt2y5w75XYSy0hFQJYf9zxxT3L72TPQ6fIviCvZMM7YXP3C1BtaxhS0WFfKkbEdm5j+Y71QmkzYZqDoq0yMZ0sUjXGHHH9bkA88Tr+PpV+Pr4b4VvJoVCo5YxeCuWnfO3ARJrAi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLPwGwW0/WMCaUxAG1O5K8dEYKA9AbCFmVDqUmWOGok=;
 b=P/zLw095cOpqyh/WgbL4T+eQ1R5ee6L2DK08ZXdlUTMaa+jM2C77TO5mboBq6BocF9q4qGVyGwjiNGCG2XDad7jHvRUB+2gPGTA2Z5RWHhmyeYHXP5QcOQ7hRfe8RZQcJ8EbUwKk9Bk7fwkOwoH15sZG4o6Jh07ydgQrmjoMukoSgtAhpdA997/p+k5oz10toLGOZQWpkBo4RUql8Om72PALnobEIm5lenqOB/El2zEqYNuUo5cYdWNRKO68wOEhnLSvudjAa4/vYL86TuKY/CRgb8fWMI8ix2dlju2XaC9jUHEtSV8/buYvJkMpiKFYDqZDNjHOvgWoxxabuakVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLPwGwW0/WMCaUxAG1O5K8dEYKA9AbCFmVDqUmWOGok=;
 b=r/u+Ui+uuf3QNQSrrl8SOkYy2KCA/gHnmuUm6gdkdYQkfybRty6vZWq46rYr7OUbjF8/COmNwwfbvlVVmNw4//LjNgo0Za89avJkYU3W8cJ0WELPOLSxG1Ba2xPiV/E1U98+abV4Uwl7IIMdCol3JBSvVLgbXneqerzpPIBCgYE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:12 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/49] Initial Beige Goby Support
Date: Wed, 12 May 2021 13:30:05 -0400
Message-Id: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55ca7b7b-100b-4120-124f-08d9156bbcb9
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4915016308304C71B8BCC23DF7529@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xT4Q8wDbJ6rQF3npEP3L5vJwVaua5WaY42HJyF721FqdmqRQIjO8NrZ8wjVKMp25SbweHRfLxR4Pebm+65WrLUhr7sMlrw59xocxIGYnfJZNl+VH8tEaA7ST5i7Jzk3wEEaAjZrikCdIJ6YUT5asXCwChXVKaUgZtAv8igWKEhQNXyxLbL9ylH8cfU4J5hlUG5uXXsBomMUvPapF4xH6We5MkEE7u+cc2AWpYIbslqFbdLLFVy33AylwuKTxtt2ewFwIg7N2aZPB8HhJhlAF9Oue+7Hjj0bXfqiIvsva70JWCAsaEJ+Pp2aH2DcnYf6vUyYeI0utmKe9wxvfTrL341nbrl1lqgkV/B8eXmSqbRIG3x4cXSv2WLcbxQW6O3d0wuygAkKvl9olt+AzM8bdsJ3BsW25hvWt9/YjRdYZHDaK8NT8UnprT/ZiGTsSaHApWkbQBRDqpCkFycx5nnXCk1SqNJ0MhNsanx2WYKYtdv0QtulEM2cBWQ2EcPnKfvkZk9I1VUwM9nT6EkQwxw/Dc67af78UedD4mdjC/j5oyqyQ05ISg6NwlJdwTqM/9iP6vq9BLYOdSg6y+2A3ihThbc0wFvKFsJ4rpsCdx7c71X2PibNDTdVklVGDeDA4CChWmu/1LKEhHftk0fMODFFnddu5c3C/WLrvQe1WnkKwrFSuxoqbrhmvi5JJakZbdHiHtIWKkiXANHNAt6gD6birijLsomW0pQn59pj2aqk6O4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(8676002)(186003)(16526019)(8936002)(6506007)(66556008)(478600001)(52116002)(6666004)(66476007)(38100700002)(6486002)(956004)(5660300002)(6512007)(26005)(36756003)(66946007)(6916009)(2616005)(86362001)(4326008)(966005)(1076003)(2906002)(83380400001)(316002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vn4+Og/NLcDjH/KPYQfa1ysLpZfaKZuIrQwt+QkJAlZLvy2urmjCGprqpouy?=
 =?us-ascii?Q?Cru8flcgpG02Z797+vtjK7V8Drbww7kFziWGomYaoLpe7H13KeJIdZ5D93IH?=
 =?us-ascii?Q?vaE5FVvtpVRsel0tayWOINzi8g8nsKT/SHdtlkldoK9dl75cJPfA5SIjZ4go?=
 =?us-ascii?Q?BnPv7Hcw6WDXgmFz81Mfoqt3+L4IARLl0x/b/CsQhbhn30Qezo6icjP1ud9E?=
 =?us-ascii?Q?bW+cFm3+KVOpaMYg/mXz05BH9VkdLZoW8blMmHSJLJwF6t6+oC33DEnpbmFM?=
 =?us-ascii?Q?Euwd9LYFoiEIyMEYAJMPiHL5xs3hH+g2NGuaGiY1CQ7/9qG+AUKJOW/2PtN3?=
 =?us-ascii?Q?2zzd9jZVGseU9AlZL6TwbpZ9un8FBW8sMdJ500M1B0SsfO51+zKKVC56aQ4G?=
 =?us-ascii?Q?zsjxghUOTA1wxbqH8z3qhDJ+AUj/TAykqPON+1mLwolTsUOP2Zq35lSStQcQ?=
 =?us-ascii?Q?U7eBnlfhAs0awunYJduQSJzbdW2aamTdD0/JCDHZ7WVkHz4zB5G42cLEVhcK?=
 =?us-ascii?Q?LaFrIqim84fUl9+sUUw1qDwKZQTcdbsW+HH4T7jNpKlzI4PfS+rzgiqJQAuC?=
 =?us-ascii?Q?vPtC7K4hhe22wDg+RvuyEWo0sz59Mx2SOnZcCVtPIhvzgNRauc5lHauQo3Y4?=
 =?us-ascii?Q?JQP3H1d8tDPpvNq6xWIIbtxv7dq2cTB17Xl2uVwHnt1PLBOJCDmlcxARKOjG?=
 =?us-ascii?Q?arRSw+9mAftIm+6K2LMLxY0/zbW5mXaL0YG18CI8iZlx/9qGFsOp6CYiNKmk?=
 =?us-ascii?Q?7SYq4jg1Y/xc6ux/gfr0+OMCmjJFz3liWSrIXo0ZU6pbrrwLtiY2emK4T6gD?=
 =?us-ascii?Q?I+wSS4vaz9wb5+MXuiVVi16ydI/+v/TOn6bHkDshcMl84Z6Hc5XaacQWrvBJ?=
 =?us-ascii?Q?ZcPmvYUW5OeyAU04T2WJHY4K7wz9luPjx0JSlBaNo/LRIhNlbSZe/3NQ2+BM?=
 =?us-ascii?Q?yyO1G4xVAcXwvDwkyK/B/r6PynG6fQmYm/R0KW/A8N64UHT0cECPCVzGjGNk?=
 =?us-ascii?Q?6C4J5b9Sji3e3NOycZDKq9sa0+KLDBArcbmBUFQ0vhghkQorhIXWKS8UbFtb?=
 =?us-ascii?Q?B9p5H+cwnWAbtda1euhZJTxl5hZ97Ro04rJfX08LRS8YcJWYekU7fbLUvjSr?=
 =?us-ascii?Q?zVRrdxKDGr+yoJ2KJx9Pr5XcrHbGtdfP9dTY3JfuHawLZref/5wt4CLPpLmD?=
 =?us-ascii?Q?8wHkWdfCKPw4qbCePJW8TEGuAXchKbLtxYIIRSllHQPSVVQoaz8eHoua9gJ0?=
 =?us-ascii?Q?pKsuYFbC8Gb6e/duQNQXHN3lid5ii+B4N9oliY6z37aVIuEtJHmOAO8N/77+?=
 =?us-ascii?Q?SHC14FXb4Fhl6vXLEGJbxsPN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ca7b7b-100b-4120-124f-08d9156bbcb9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:12.2710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CIX01AjccVaoGPgBD5EXh35PEXzpUkzEY/KmAGf2GeUL36erfShhUEtzb6EWUOV20Pay38rdA5Kd8Tg+rDiWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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

These patches enable initial support for Beige Goby, a new GPU from
AMD.  This includes support for GFX, compute, multimedia, display,
and power management.

Due to the size of the new register headers (patch 41), I didn't send them out,
but you can view the entire patch set in my git tree here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/beige_goby


Alex Deucher (1):
  drm/amdgpu: add mmhub client support for beige goby

Aurabindo Pillai (8):
  drm/amd/display: Add register definitions for Beige Goby
  drm/amd/display: Initial DC support for Beige Goby
  drm/amd/display: Edit license info for beige goby DC files
  drm/amd/display: Add DM support for Beige Goby
  drm/amd/amdgpu: Enable DCN IP init for Beige Goby
  drm/amd/display: Add callback for update_soc_for_wm_a for dcn303
  drm/amd/display: Enable HDCP for Beige Goby
  drm/amd/display: enable idle optimizations for beige goby

Chengming Gui (28):
  drm/amd/amdgpu: add beige_goby asic type
  drm/amd/amdgpu: set fw load type for beige_goby
  drm/amd/amdgpu: set asic family and ip blocks for beige_goby
  drm/amd/amdgpu: add support for beige_goby firmware
  drm/amd/amdgpu: add gmc support for beige_goby
  drm/amd/amdgpu: add common support for beige_goby
  drm/amd/amdgpu: initialize IP offset for beige_goby
  drm/amd/amdgpu: add mmhub support for beige_goby
  drm/amd/amdgpu: add common ip block for beige_goby
  drm/amd/amdgpu: add gmc ip block for beige_goby
  drm/amd/amdgpu: add ih ip block for beige_goby
  drm/amd/amdgpu: add gfx ip block for beige_goby
  drm/amd/amdgpu: add sdma ip block for beige_goby
  drm/amd/amdgpu: configure beige_goby gfx according to gfx 10.3's
    definition
  drm/amd/amdgpu: add virtual display support for beige_goby
  drm/amd/amdgpu: support cp_fw_write_wait for beige_goby
  drm/amd/amdgpu: Use IP discovery table for beige goby
  drm/amdkfd: support beige_goby KFD
  drm/amdkfd: add kfd2kgd funcs for beige_goby kfd support
  drm/amd/amdgpu: add smu support for beige_goby
  drm/amd/amdgpu: add psp support for beige_goby
  drm/amd/amdgpu: update golden_setting_10_3_5 for beige_goby
  drm/amd/pm: add mode1 support for beige_goby
  drm/amd/pm: update smu11 driver interface header for beige_goby
  drm/amd/pm: use macro to get pptable members
  drm/amd/pm: Use the PPTable from VBIOS for beige_goby
  drm/amd/amdgpu: Enable gfxoff for beige_goby
  drm/amd/amdgpu: Enable memory training for psp HW_REV#11.0.13

Hawking Zhang (1):
  drm/amdgpu: add gc_10_3_5 golden setting for beige_goby

Jiansong Chen (1):
  drm/amdgpu: fix GCR_GENERAL_CNTL offset for beige_goby

Joshua Aberback (1):
  drm/amd/display: Update DCN303 SR Exit Latency

Tao Zhou (7):
  drm/amdgpu: enable GFX clock gating for beige_goby
  drm/amdgpu: support athub cg setting for beige_goby
  drm/amdgpu: enable athub/mmhub PG for beige_goby
  drm/amdgpu: enable mc CG and LS for beige_goby
  drm/amdgpu: enable hdp CG and LS for beige_goby
  drm/amdgpu: enable ih CG for beige_goby
  drm/amdgpu: add cgls for beige_goby

Veerabadhran Gopalakrishnan (2):
  drm/amdgpu: Enable VCN for Beige Goby
  drm/amdgpu: enabled VCN3.0 CG for BEIGE GOBY

 drivers/gpu/drm/amd/amdgpu/Makefile           |     3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |     8 +
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c       |     1 +
 .../gpu/drm/amd/amdgpu/beige_goby_reg_init.c  |    54 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |    66 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |     4 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       |    33 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |     1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |    44 +
 drivers/gpu/drm/amd/amdgpu/nv.h               |     1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |    13 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |     7 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   101 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |    61 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |    20 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |     1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |     1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    14 +
 drivers/gpu/drm/amd/display/dc/Makefile       |     1 +
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |     7 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     6 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |     9 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |    43 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |   175 +
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |    39 +
 .../drm/amd/display/dc/dcn303/dcn303_dccg.h   |    30 +
 .../drm/amd/display/dc/dcn303/dcn303_hwseq.c  |    40 +
 .../drm/amd/display/dc/dcn303/dcn303_hwseq.h  |    17 +
 .../drm/amd/display/dc/dcn303/dcn303_init.c   |    19 +
 .../drm/amd/display/dc/dcn303/dcn303_init.h   |    15 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |  1675 +
 .../amd/display/dc/dcn303/dcn303_resource.h   |    17 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     1 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |     8 +
 .../dc/irq/dcn303/irq_service_dcn303.c        |   262 +
 .../dc/irq/dcn303/irq_service_dcn303.h        |    15 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     1 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     1 +
 .../drm/amd/display/dmub/src/dmub_dcn303.c    |    37 +
 .../drm/amd/display/dmub/src/dmub_dcn303.h    |    19 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     8 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |     4 +-
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../include/asic_reg/dcn/dcn_3_0_3_offset.h   |  8427 ++++
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  | 35330 ++++++++++++++++
 .../include/asic_reg/dcn/dpcs_3_0_3_offset.h  |   204 +
 .../include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h |  1192 +
 .../drm/amd/include/beige_goby_ip_offset.h    |  1274 +
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   |   366 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |     1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |     1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   799 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |    10 +-
 include/drm/amd_asic_type.h                   |     1 +
 62 files changed, 50382 insertions(+), 117 deletions(-)
 create mode 100755 drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/beige_goby_ip_offset.h

-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
