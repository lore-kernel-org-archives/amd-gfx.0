Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466F4C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD9461447
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD9461447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618406E14C;
	Fri, 14 May 2021 04:50:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5981E6E14C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5Zxqzgpc+teQMt+WW174lcp9123pWIr0xsjvhmoeaHPVAp5AmXi7t1HP7h+jG0Bc5biqYHhnvI88KPzSwVz0JXXhTO0ewh2wKGPeZH+q6QpoGdDF+rAbzv5Ixo4dQxLpl2REnPAfVWtgiqnsJfbms7/4X/fygnHj/njpOJHyZbvA+TR3w+BrFedexJzmY+O8aaRew9ep8keLAVhW5Z//ee+5x7huPTeyFjQ8g4qL5zhppign5jgw0JRhxkd75jy6ltrj8GQxS3c6fjhwgeCkAE7t8zndUi9gIOCF/OYt7F1/dN77KrewDEPG7G/OhGJHwBWsnP3H7PhqIbX58uZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW60szlPVei/JCGyzbzxIb38ug/49t4FATwq2MqXsO8=;
 b=I7KavSgq0CGOaE3f1RVswhM8cKZIp9aksWQ3HESkHm1B6kjP1K2oqGhWjNpOxHflj/vVEgY5Pu744JmdejDS/Mu/mk2OIHH7z1Wj31NJF8TcAUCUM07r5KRUa4iEV4viytg2IYUGubNgg1sxUZ/KGkltU9/j19T20TOKGLkHz8QXs9d3Hc+7YJVZpqZGIaXDq+x4K8Nvsy2mxKnMp24GXiM8hpnTFICr+3J7wNT43umvp/oHunWRbCKOud6Y1FecCG87DXtmptSWJf2aU2VVGhG9Bwp/1oy6X6K7cq3moAcEwYrT7rEoC1Nn2UU+U6bSmZxaEcuwFruU++5n6yczaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW60szlPVei/JCGyzbzxIb38ug/49t4FATwq2MqXsO8=;
 b=gN2gxbhAAW1iPiIBAKeW2N72QAZ2MiFo9HtANuJdzZLaHonsKD7pHLwQ7s7QK+Zia0dla78epN1p/N3IzDDNHRCwPU4MlkF64pSXbQxbKiho0ITOpYI/2/VeB4ql97t5ciN5a8UfRnLr5POVvsWLnWBxTZ0lCgAX5++ihh1FXgk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:29 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:29 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/20] DC Patches May 17, 2021
Date: Fri, 14 May 2021 12:49:43 +0800
Message-Id: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb5336a-9d72-4d2f-2499-08d91693cbef
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB312979462F4BB4127A60D4B3FF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgRJkq6/+EZXVq2SRSD5u0Z4nG97FekfwWdljSv+FLxmF0vPzr4A9igySub0cyCbd98+BhaW9n3plEyxk9sSBAnnTX3Mij5tlVQ/aObjVGTCY5v5apUFzIpmh2mRKJOQuD7v2Q8AfGCm2vq9fh9AxbhuXXuZhk/dF1IlXuxgBk7Cs/B+4iGt4h1zvlMvGvHU6K5jhOIu6De0hgKMhXmIf7U6k9sEwowuPXdW8YPUARzZIDApc4vVrK05pzHvvyD2tlyXdYuoj44ob8ONk0PmBz13H85wMTM5c5PEUlUktaGj1Al5aZLgUGyuChpQhuibrb34RXs12VOgQ3s9T3ho74jasbtGJLn3Lpjd1KKYexTiM6fpQ8D2wA9FtU+iDBbTgiZ3Tv4Pec3LLmuZAl+ezNGc3XPhaPL0A8sxn4GLVCG8ACHiK96yIky/+Zjl/b2Tobbh71GvjhuZBFo8Nehw1Zl79lLTjbA12wrAhOfw+ezNeUNcUQtT6QbVOAqSzwmMO8X1bsqacbTyKX1WlFiupAUGoARIOI6zkPxpuN/qoC4nI12G5T0nfpTyL7qYzWB4RoeBrn4q/I56/MNo32nviJck96t+Q0OM7noDxJarwhCik3xo3hmBg6z9Hu0YtK+LMbBcaO0/8cXxqkpP1TxdJUyo/rq/dpzeimK+hycb8p8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qkwwKSM47xzdszNBkQpasoHYjoOnajQSrq/+e49jVTh11CQK6Fc8a4uDPFV7?=
 =?us-ascii?Q?dfPu4vk5OHPYT2dr9klCOy/ea9M/38CLpvq1JMopYMJjpTiAzdK4ExjEMhp1?=
 =?us-ascii?Q?cB7mg+2rEqdyE3c5tMX0CijBpzeotrLoHgGSOc7HkCy+jPaLZdT2YsOvz0C4?=
 =?us-ascii?Q?FWoFmmncEsk4aeKiqgEqGV//8micGYYBNnNtkxwZ3eXGE6018NNIKyv4XO8b?=
 =?us-ascii?Q?No5wiqrRqp8yMwrzXuuqrubGq+vFpy0KmavFwePpbm5uwfeMvpL3z9UpeOea?=
 =?us-ascii?Q?vC/hKGAjw7PBobz7wxH0Mv6KwOc4uKvkeTuWnFaQUzJ4r8gpS1TXCuukrRXG?=
 =?us-ascii?Q?nKXFGFfpWAMDoEmawbtOH2lVXJGW3YCjfdbbAsFMlhyu10V7cbVP5+ci/KQn?=
 =?us-ascii?Q?+X+x7whcgpvlm63Z2LfeNqDHrDo1bF7n5Fr47TB5mLYZNl6w1Ef3cnfm04gu?=
 =?us-ascii?Q?Ly5SyI23gsJQHrCU+/2LdZj1XckQhfSIy8oP8RGeh2090/UiAmRW0OAoQmCo?=
 =?us-ascii?Q?Kjg7Fhu4HXgYJD+WqixCSLkpUp0KWZfl2XfcayawAVZkVU5RMGIRWnaVfodB?=
 =?us-ascii?Q?5BOoV4WrCNIgUbWCdA5d4McFfMLXhW3qHLDJVkeCGDX68W86Kpj7P8brN/mf?=
 =?us-ascii?Q?yYxFclmwFW14hRJEXipr0FJjfvpuHUyskAfIjxfPddENtv72lmrQnSfJFSnB?=
 =?us-ascii?Q?5lVvYNnkUWRPfzHKmrVdUuPIZu8khnm2Rn9dap/+v+QmDqzMG2EAgkmAFHdO?=
 =?us-ascii?Q?NhtEetnoqKZuRg+Bp0tZLD2rVezcToIcTSnlP5gVe2a3pjPlLrQwCtYiykn1?=
 =?us-ascii?Q?hzCAgq1igW1i1WBEXCjCEuTJi3FThE+KZBpjN72dmag6ZKS/ev0knY9of+l+?=
 =?us-ascii?Q?TKYnKg2orn3GJV70G5s/VtqFOXKCop6JjF+LaKlHwDMALhePHaQUHXSEqhe/?=
 =?us-ascii?Q?RBLztllPR+rchk3FpWYEl/PqSDsFe5IRz6wlp95g4veoE6LHVAd8pjQg/V5V?=
 =?us-ascii?Q?7ndpHh5MOAASw37Tegzeux0aYPcAHHkVvRmfXK0QWjqE7hE2CFroHGxE7ADT?=
 =?us-ascii?Q?g1dsXYHdmlDSyHOAVAYVLLCMyrQ8Pj/wZRqqaWZxDrS1QmlYtRoMkHSWeC87?=
 =?us-ascii?Q?wxCJRF7gPIi3K6NNNR85XtJU/p53h6rlHH40UbtxQ2VCRmAq7e/ItPeM9K1t?=
 =?us-ascii?Q?Kh7ZcPYHEhm6BL6fIWOEFPJB36FbKcAMbHwsNSpitFEyAfCZKoYa9Khi0mVE?=
 =?us-ascii?Q?RPbxQM+ACQiAuarPGks2H9IYolwlQor6zEfB80RNFjvc57m5C43MzDRxtdc3?=
 =?us-ascii?Q?kN4UTHziu9biuI0Bgj3YWv65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb5336a-9d72-4d2f-2499-08d91693cbef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:29.0035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLKbK0mkJmn2otp6F661eWI7MMuQe3HSVTdsNW3XkZx/rlszDSEIbCxgDSfnzezj6PVZjMtw8oy+dKuvOI4sDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC v3.2.136
* Improvements across DP, DMUB, code documentation, suspend/resume, etc

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.66

Aric Cyr (1):
  drm/amd/display: 3.2.136

Bhawanpreet Lakha (1):
  drm/amd/display: Add Overflow check to skip MALL

Chris Park (1):
  drm/amd/display: Disconnect non-DP with no EDID

George Shen (1):
  drm/amd/display: Minor refactor of DP PHY test automation

Hugo Hu (1):
  drm/amd/display: treat memory as a single-channel for asymmetric
    memory V3

Nikola Cornij (1):
  drm/amd/display: Use the correct max downscaling value for DCN3.x
    family

Rodrigo Siqueira (4):
  drm/amd/display: Add documentation for power gate plane
  drm/amd/display: Remove legacy comments
  drm/amd/display: Add kernel-doc to some hubp functions
  drm/amd/display: Document set RECOUT operation

Wayne Lin (2):
  drm/amd/display: Refactor suspend/resume of Secure display
  drm/amd/display: Avoid get/put vblank when stream disabled

Wenjing Liu (4):
  drm/amd/display: determine dp link encoding format from link settings
  drm/amd/display: decide link training settings based on channel coding
  drm/amd/display: rename perform_link_training_int function
  drm/amd/display: consider channel coding in configure lttpr mode

Wyatt Wood (2):
  drm/amd/display: Add get_current_time interface to dmub_srv
  drm/amd/display: Refactor and add visual confirm for HW Flip Queue

Zhan Liu (1):
  drm/amd/display: Correct DPCD revision for eDP v1.4

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  32 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  63 +----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   4 -
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  39 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  18 ++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 106 +++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   5 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  49 ++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |  13 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 229 +++++-------------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   5 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  28 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   5 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |   8 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   9 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   7 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   1 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   7 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   7 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   1 -
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   5 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 +
 .../amd/display/include/link_service_types.h  |   1 +
 39 files changed, 380 insertions(+), 353 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
