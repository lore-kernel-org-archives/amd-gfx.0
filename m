Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF35C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317DF61928
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317DF61928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8066EB16;
	Sat, 20 Mar 2021 04:18:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1552C6EB16
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0CcNyvUez3RI2YppUTg5JWPlYsRAtKWg2nrWOgbjXmSwx+kuEcqzsIiDJX7LdhEiqPkB6XaKqkFcRCfWqodAilnecyBm02PBLpyZ40GTghLAihVXt/hRlIF2RoqHDkioeZTJ1SbnTznVqPZNk7lFCra+4XmEFNuvPOfXkbrONz0cn5xFpRDUfOuChD/xaGTWxmh1e0TpdoMz0xEZoCybWs2zW9JDaFHoY9qZMqGgj4UqasGGqPzCyERawMmg7YhD7l2fqilG3U7DqduYNKBvoWQPSpJ40Jd+n2xpgn0R+rMUyHQwGcvl99+2E1+vZJvcLH88Gri8td6g4dQBVcs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN6qOWirQQgNK3ZPdGGemlCmGXJfsxVyFjOyN8Z2jmo=;
 b=AI8e/ZI7ZK5n9clsFEd0sj2VRNVjW5eJlS/LIqkGEINE7KW6KYa8j1i2PcYBvNTjHgS3OglzMgkewHylElryCtoQ8x5bkdDcx1AnDSDsFf7rAsNHcgBIylPa+Wgu2RxbQbHnb8x/kK7euuDbJLh6oE1u83IBxEi+nVOlfvxC0CJaDo7k6Bp0QpQYAVv4V+uhz/leuC1honEe+S946Wi65pNTm2kT1IqRloMyGNRj2D/g49X6MEqv2XuIvgKIqCM4wsp2aGAcg6AY/F+gH+Zl6EkZ3xx7S+ga/g+aqobySqCuWGUA87Evyt5LAZ4uFfDIUT9ZYLrbUPndY4gvJGvOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN6qOWirQQgNK3ZPdGGemlCmGXJfsxVyFjOyN8Z2jmo=;
 b=fGcPVeR4mVQj6ac2c/FFa9Tt5CckoDXIZcJ+BYhbtTjigTyQYmqalRH++rsoAVAWmIDGlhCuR32QdUNdOpZFZQph540Ws1/yUSqSqtCeNlemEIN1NaTFaUoN0Tymmmu3FX6kUEgtXd9DchmthB+4u6eVnXkcrbp7afwVLfbfgrg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:18:40 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:18:40 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/14] DC Patches March 22, 2021 
Date: Sat, 20 Mar 2021 09:46:42 +0800
Message-Id: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:18:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d885a822-8c56-4e3a-7caf-08d8eb573d4a
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704FB6EC04321F256037E6097679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lyu8S2xs4Hpnp89VuNAOsCZLaMis8FFySTPkgngl/EKWflAMzn65fERsDi0mq/xkSOeROFr/dv/RluSYEWZ/7g2hUbMeOvxIrZvzrE0928Zb58OrT/he6mDQAXADpUeqzIuykJFs4BhGBtKQSkXxifHi8Ik8JZ/i5WS8Qc6AOSvLr0fJRm0HahDXcyMT+SA21vaNHHFw658nk2ncUHi43T3gf8lHMGXsiFU1A0w6SDjfcA1WweIVxtsDfzfd+coowHdoZjPRwhrxAGxlu8iTciiH6PWf9WgNSNIH0WlJilLolP5FPvF4zY/+kjfL+qBkt7NNjS9dtV0aOoVajZBFsQbZotgDX+w1SXgLTEfC2RXzSeEE/FQPaBoZLMc+Nc3kc3b4yqfph3t58SbS9cJ1NjS+24Z4kLJUm0pMxfJYZYxNuAeUXJiXqSN10myed9HJ94lpfw10VxKAvaIaQJue68LXgcJ0c8uK4hbVPCWUjCaJly/o/iylyaeN8UPtW/OFSMo5klzXKp0IV1cZNENtgRdkDaGUh8WxxbaZgq5ruLbwnMAEpQ65Y3bAp+om38j7H+NOcFRbAEsYFfDipCASLrXYkzq9oAEvDOzL/XGJ0MkbwbY5ZN4Arce8n0a2TAmHtf/2evOYbux2WMG5RmOmRR+1PIn0jxdavAz+l4qfzvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(4743002)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DnGCFx1R5s/19mR090XPvnPg8Y6v9SAGqdYTe/hlqpA+KnmlolHwU5JtdSMR?=
 =?us-ascii?Q?txROruL0z/EyBoXXkRq2omGsAGeO4czVutHzon4kTSbxUtwTG3Q/G52vctTZ?=
 =?us-ascii?Q?jWYlwSdCbGm5HMLTveU9JhL+987QZlURZOxwWA1PB6v6cJFUb13802Lit+Lx?=
 =?us-ascii?Q?EHecMWvwLxfnhYlOzgSYC4MXUbYIz7XO8fpMY5SQ9U5bkYsIjKSOcZQb6gYg?=
 =?us-ascii?Q?l8k64rMW9O1digre40CBLpZ94rebJJAESaFDPOjaVVwMC6KaRYw74zvDM+Tb?=
 =?us-ascii?Q?JVzB+QW/7BI20umUOlD0JPic7uOMdMBrF3pWhqzL4jVNX8sczb8Qya+BvRtP?=
 =?us-ascii?Q?Ji+jFBbXoJas9BK5iD6CPMaEfe5uC9KJH3D4s+NGVQtJtX7wtiLfcAd3StS3?=
 =?us-ascii?Q?fVEPJG1uVT9ukySEpi6wNDdjcGUHON+ooC6pAT0G9UHgnXgnw1cWTHe4jk33?=
 =?us-ascii?Q?52+6/WebXA7UySPFQb4dZ9TGkvor3PBM/AZu18h7wgo2/QBLFJWDr91YHFOA?=
 =?us-ascii?Q?uCkrCR3+sWwy7eFdEyN00mgaTer3wHSJ5lN6NCEGraZqssLHU1Gc9RATTw6e?=
 =?us-ascii?Q?PoW25VhziCIe0au0AalC06N9kVYyinkbiQr+ouNN9hoxH0f5VVlTqLpyGkTN?=
 =?us-ascii?Q?KLN3ZU4MhcG45Wrv2Axkz1V9BXcoMAMxmpFJpbNP0Xu5D/pzjf1/67hDfQjB?=
 =?us-ascii?Q?TukFA6ipu3K4dcmlTqKW3bfaroUbTXTHQkvuR54ZxRr8yrCuQcpwz/HFsTFq?=
 =?us-ascii?Q?t/hckU6K0K7p2MB8XeRmIXfEI8kMkPGyrNVkKuXoOBnu8UXInosFzcdad86p?=
 =?us-ascii?Q?Ynwc1Ydjvr+ayvQUBess+TGFEQ0xpSgIX0YbaW3r2AuB0LwLnHYfe2ZLthsA?=
 =?us-ascii?Q?wZ5O6O8ItT6Qhm3X/6NnyYd4oMSGpsqJmwn0Uge8310j/5l1+L5zJb5/7Qe7?=
 =?us-ascii?Q?4DpNDzHXyye7mu6Qyq/QMnlJYu90bxvwYD5dIAGEcc1dQcifSdVODEm/WHAO?=
 =?us-ascii?Q?CukosD9/M2UFVLcWRmREKogcrun2ASFJs3WRSfzZ9NSychUiEWJ/whZtBJGC?=
 =?us-ascii?Q?UxCo4EKDKDwUE7tP9ZzI7C0JdYEiBsVXdc633jWR5DJwzRLC0CdHWLvNfTY9?=
 =?us-ascii?Q?3RX/cze6Q+MMj9EfpcsKF1g2mdXMdUPq/IW+/dUFKfCqIsK8RWydJV2MqrdP?=
 =?us-ascii?Q?AGXGJzaLEVjA7UW2eMlQt4rZPF433+XJF87aWA0cG0YHnZVdnLSHGfEk+0W6?=
 =?us-ascii?Q?3EpT7Heaf6hzOyAqTGBx+FcanJL4/8ZcA+SrsC0AkFhLtp3S+F62UWVRVpRt?=
 =?us-ascii?Q?PqBKCu3A5mKSmNSRrJCGAzg6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d885a822-8c56-4e3a-7caf-08d8eb573d4a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:18:39.9347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c67XZ7n4fE5gsQy8uCwY9lH1mkcwVFLteQ8KSZ7QYxbuiCpBWhAXB3HaEYg7+hC/+WvK+AQduJm3yXkaAbT+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 
* Populate socclk entries for dcn2.1
* hide VGH asic specific structs
* Add kernel doc to crc_rd_wrk field
* revert max lb lines change
* Log DMCUB trace buffer events
* Fix debugfs link_settings entry
* revert max lb use by default for n10
* Deallocate IRQ handlers on amdgpu_dm_irq_fini
* Fixed Clock Recovery Sequence
* Fix UBSAN: shift-out-of-bounds warning
* [FW Promotion] Release 0.0.57
* Change input parameter for set_drr
* Use pwrseq instance to determine eDP instance


Alvin Lee (1):
  drm/amd/display: Change input parameter for set_drr

Anson Jacob (1):
  drm/amd/display: Fix UBSAN: shift-out-of-bounds warning

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.57

Aric Cyr (1):
  drm/amd/display: 3.2.128

David Galiffi (1):
  drm/amd/display: Fixed Clock Recovery Sequence

Dmytro Laktyushkin (3):
  drm/amd/display: hide VGH asic specific structs
  drm/amd/display: revert max lb lines change
  drm/amd/display: revert max lb use by default for n10

Fangzhi Zuo (1):
  drm/amd/display: Fix debugfs link_settings entry

Jake Wang (1):
  drm/amd/display: Use pwrseq instance to determine eDP instance

Leo (Hanghong) Ma (1):
  drm/amd/display: Log DMCUB trace buffer events

Roman Li (1):
  drm/amd/display: Populate socclk entries for dcn2.1

Victor Lu (1):
  drm/amd/display: Deallocate IRQ handlers on amdgpu_dm_irq_fini

Wayne Lin (1):
  drm/amd/display: Add kernel doc to crc_rd_wrk field

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  48 ++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  15 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  71 +++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  21 ++++
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 116 +++++++++++++-----
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  13 ++
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 101 +++++++--------
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    |  28 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  10 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   9 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  14 +--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   6 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   3 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  28 ++++-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  28 ++++-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  28 ++++-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  28 ++++-
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |  28 ++++-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   9 --
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  32 ++++-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |  32 ++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../amd/display/modules/freesync/freesync.c   |  37 ++++--
 .../amd/display/modules/inc/mod_freesync.h    |   7 +-
 35 files changed, 581 insertions(+), 197 deletions(-)

-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
