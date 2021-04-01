Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA5C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32CE6138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32CE6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9186ECD8;
	Thu,  1 Apr 2021 16:45:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586EB6ECD7
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVd22O1Bm/88IVG4pFaKZo0G00866m8yo7+s1z4AI0JFsjWRU5sozQNFbAVslUsWia71EVcMAdnMrG3QGkMor3U+dobYQijbFqYj/gyNJ9jxr2ULhRsxMtF0vg1ofHt8OgDW7MmGIR+vh9Fyuzb5Y1NQdG/A+2zmzn0EtR0nIOkVNmOUDu03skZxZS+ztEv6lBqdiU0CVPFovNnwXReYJCkAigrzZFwMIICDzeSANDgCmeZlj3ALzCQbbndtVQh45tpi036jF7yQhFvOrnhGWT7oBZ5m/72YqjaMFDkR2bRbq8rx9TWhrgdTdEnz3A5TbD2ICSowcosmJPi4UlHSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCAH2D/47lcIaaOYNmfpbJCO3KOUzp4we6Llrk8APIY=;
 b=Sj8QUsw/Leo2bpjQIgKxn9wGhbYu56ybk0HpaxTlXcFJTcnOSkW19LHNELO5aH9mQ6fbMR8n5awg82TkIr8ASF8oQS/igQueTtaRdwJvFQA8BuHMgh6IyY20Ds0mFHB5gUpCqtbl7V9DOO3+Ps9NkTnKCqY+qOT22rMxGgWXDYCtyxcZUMDNgh1aCWfYh3/5sDhEbvdUE2NDhDCq0Cu3+dB7/zT/CGFkHCOhIqepPcv515GemOBUj99wwkLDu5JUs01YrQBAG6JHNTA7lp7FqHyfHD0r8VrPdae+lp7Oc7Lt7SNt/C5DW4FOFEJ/g6SjdKfX12Sx6VrtQ3PZHkQ3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCAH2D/47lcIaaOYNmfpbJCO3KOUzp4we6Llrk8APIY=;
 b=MqP2vWgxCFNewK1rsX7jy4gSUTXBSJU6S98XHNbK1GqMAVQbO5fGxxHrrXa4GFPr1+MQ6jIAMTGDlRZrelAqVb2OCVBacxq4Lly8OCh2oVswjacyEddIdr0mkQvQkesQOPbmJ5MxXXX0d4/DEPB3MMYZYnE47UAq9vFpyD//7Y4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.33; Thu, 1 Apr 2021 16:45:55 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:45:55 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/21] DC Patches April 5, 2021
Date: Thu,  1 Apr 2021 12:45:06 -0400
Message-Id: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:45:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fd1f161-5918-47b6-095a-08d8f52d9e18
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1514BC92BAC609A1A099AF4CFB7B9@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLzwO2xiyW60uFs24B4rPqYqEfI4n+q8cpPSCiZl3XirkL0JdAaSKGaPwznGGYeOUHefb3goc0FBsz35dgzhNInC1zY8fcKzuDzdb2/lesHR2rThMU6D9y9nL5PRUuM0wcp56C37ngOWhhkli2y/3sriWuSvKz/UNPYlUZ98fjAsPEl6UNP/aQ0tQJjORaa9Ng7Hma0Bn9yr+B9qOljjIxplxz1Jb3UGpox+nNR4rbyUI82sum6yXr9waZYbT09iW90Ld76Y9WsVtTWxo1o7MTU9mY3Zwiwju5tv1jrUbP1w5+LzRb/6beD/kCbZsu+0rCkyjd4WW8TegcueubjpvgiYgD/ZJ2E4RHnk9eyDabsRXsa7wLVdrw7ajRhvnyjvVKjl7VrysPN0cn4Jm/4tX9ac1kJRUsEVMz3zcjOo0L/rYvprQcr9PySKGmjuvZnIccrYNmCXUvKo3fpaQRxUllxEoQzhDCMw2rfxn6rvTIHFo0laA2WsjKpvPjM20gKB28sM0DYlkeiblY60dksL2r+bBhn8/zs62kdyhEn+Ht8l6Wo4vfvkJue8XJAUlBHZxoM3aeaLEfSscysjW7MCBQnSJ7EurQ+CWLXE8E9OSs9P2IIjQkKR7uAEDyhH3mnEEUuj/EiGGuJKDNJodMrf5LYrqZVWzti4If83P6iqD00kUUxORKcqHg9YE26td7/o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(8936002)(86362001)(69590400012)(478600001)(44832011)(8676002)(1076003)(6512007)(956004)(16526019)(83380400001)(38100700001)(6486002)(6506007)(2906002)(6916009)(52116002)(5660300002)(186003)(66476007)(4326008)(66556008)(26005)(66946007)(6666004)(316002)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gf/F6AOGV3DfRyZDv8AaWxFGVe8FV3Dhnt/+oCxAcNnAB/lQTGg9LoM/VQ0x?=
 =?us-ascii?Q?F2NpRniYCIRhd8X7xx0l1A6ntX8W9YSLAJgtU1b/xiVOxWvJtAY7a8J6UjH6?=
 =?us-ascii?Q?Yr0lxiB8OIIIkubgZZEZEwDQyVul4NerZPqS5rafBDQJjP8MeFap8qRmBU4V?=
 =?us-ascii?Q?zwmxoAR7C+TEKmhD3f/PhUQQtS8lLe2Mj1uNvcHSaK+bLlhLNY8X3ajjgvRw?=
 =?us-ascii?Q?xcbs6cnIzUub4JcPumuz1GJvuCuG37pa5Jhc8QVj6Uwg5wKrIEqSpP4VeRnb?=
 =?us-ascii?Q?X9gaXBNqLJO2b78U/g1mYp0sfQig7jyYLcubvrm4HcUazC8O9ty/sGK77lmr?=
 =?us-ascii?Q?Uf6ZVxpHa2uFv9zhAbGvdQ09+32bWOgiExV3Qj4mtOFcxOh8vbq366fH2OUq?=
 =?us-ascii?Q?WrG4J3ECMAfnjTXcFWOTzjlrPDbbdHPDimLNPPXD3P9r4eVJja8AdThMAOeZ?=
 =?us-ascii?Q?MKEpTpK8ybPA+A3AQ17Dq9lFlkpGsISN8mGVNtekj4457o95GTRscc2vohRb?=
 =?us-ascii?Q?lqJIqsxbjN3bDQtd63gIUBWgHGhcM0ksKKt/+/cqItCzMT9hF8Dvghs0AzRU?=
 =?us-ascii?Q?FbQ/l6U05vASQkANP/oL7klWGfYz5YwXfVD1/Qs9GLyI2OrUrv9L1Xj5TTRb?=
 =?us-ascii?Q?sWNVxo1KYaUZJNxmGz9r01+ednqJA5D6gbu2cjewK10SvrIfVKvO3APLHC17?=
 =?us-ascii?Q?1QUcdcC4rE0maEDWnDJ7Fm/Zr8f/+PSVCefsaY2QyU790YLRS50mytn2ve+p?=
 =?us-ascii?Q?w+tjplyjD+wi0+EqAhQDGUGfn8l2npvKaoy2SOgyOetwxZHbcFb2rrO4eDyz?=
 =?us-ascii?Q?967+Gv1u5K8zDWQycC8rtq0rnstUZVGb4Dq8r2RJ+S+vl4bjngZfxhgkcAOC?=
 =?us-ascii?Q?wChutMuDQ7vRDNCI44Z8qnVghM49PSabaFZdSzxk7xxnxzLro1QkDZT0kvqT?=
 =?us-ascii?Q?ztEyygcedGP/Eyn42f5MNBKSIMDutJoiYRi2d9crCRsiGch3/5cj6gFOzrbh?=
 =?us-ascii?Q?2G6RULN3F4E9/GW7RAOYh3TtyVXNonrKtyCnT3udfaCsdJ0vr7BwNdnnlHQC?=
 =?us-ascii?Q?3B8frtKj8BYBpo6FwAuHUNR+Tg8aPUApz+X6U1cAnu27ZVd5mR12NyR98kGi?=
 =?us-ascii?Q?6D85aU/QA0+A2aIDaK1KqzZ4NQTAY8uhNPC81kIovuywbwyafiKK9wH4thGC?=
 =?us-ascii?Q?Gco0AwK7Lr+XH8bUZMXSc5o4t7qbpogKhVv1HuxPE2WcX1+XCBNNa58edZkB?=
 =?us-ascii?Q?82g1x45UDfTS81DuV/PPiN022V+zWlDQ1NRRlWEeLJXHsOQO3aKmYWdGgw5S?=
 =?us-ascii?Q?ejdyrJJASWmamBg5EtNGtvMm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd1f161-5918-47b6-095a-08d8f52d9e18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:45:55.0062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jr1HxdIl2XuzIxyQIphyxosXYgOSfMoH2FNJGoMmOVXe2POuNBL1VIDN04yQ2WNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Firmware release 0.0.59
* Fixes on display experiences for 4k TVs, register mask missing, etc.
* Enhancements on MST, code cleaning and debug messages.

---

Anson Jacob (1):
  drm/amd/display: Fix 32 bit compilation of dmub_srv.c

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.59

Aric Cyr (1):
  drm/amd/display: 3.2.130

Aurabindo Pillai (1):
  drm/amd/display: Add debugfs entry for LTTPR register status

David (Dingchen) Zhang (1):
  drm/amd/display: use MST downstream AUX to dump DPRX CRCs

Harry VanZyllDeJong (1):
  drm/amd/display: Fixed corruption on 4K tvs

Harry Wentland (2):
  drm/amd/display: Add debug prints for SMU messages
  drm/amd/display: Add dc_debug flag to disable min fclk

Jake Wang (1):
  drm/amd/display: Added dc_edp_id_count to dc_context

Leo Li (1):
  drm/amd/display: Move vupdate keepout programming from DCN20 to DCN10

Mikita Lipski (4):
  drm/amd/display: Set initial value to a divider
  drm/amd/display: Directly retrain link from debugfs
  drm/amd/display: Add MST capability to trigger_hotplug interface
  drm/amd/display: Determine synchronization edge based on master's
    vsync

Nicholas Kazlauskas (1):
  drm/amd/display: Cleanup DML DSC input bpc validation

Qingqing Zhuo (1):
  drm/amd/display: Add missing mask for DCN3

Robin Singh (1):
  drm/amd/display: add NULL check to avoid kernel crash in DC.

Victor Lu (1):
  drm/amd/display: Add function and debugfs to dump DCC_EN bit

Wayne Lin (1):
  drm/amd/display: Tweak the kernel doc for crc_rd_wrk

Wyatt Wood (2):
  drm/amd/display: Retry getting PSR state if command times out
  drm/amd/display: Add delay in dmub_srv_send_gpint_command

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  21 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 207 +++++++++++++++++-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  29 ++-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  29 ++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  16 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  16 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   3 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  16 --
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |   3 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   3 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   3 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../drm/amd/display/dc/dml/display_mode_lib.c |   2 +-
 .../amd/display/dc/dml/display_mode_structs.h |   4 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  17 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +-
 .../amd/display/modules/freesync/freesync.c   |   4 +-
 32 files changed, 364 insertions(+), 71 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
