Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FE9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778E318A653;
	Fri, 22 Jul 2022 20:37:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C7018A653
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5C+XhDg2IT5K0SqBVUi8e65gVqx4ZeTiIKvYHnZpG7cE0V7KUPdiqK4mphPWWwH/ikzi/Cb6T/pA2FTnvBnlfdCtIB0pWwNKVJ3deOWJ0UY1oVlPz9wUe1Go9hq5k2OKKdhwpxJ+tdPYPFq2+BeY8wtAVuR1/P3DS85jTmo6muZFHW6F/uYlcUHx42x13BedxcHrLLAZlUY7+sSPW1yAXIIBXmqZVvbxkgOzAhL+6pv474uJ9RBdAzrPuq9/Gvo1wSML3YS6wqslDRCvLzMnBbIvphAN2pWlcU2u4xMM/7sqiX55doLRc9wiT74EVQCuEEU0GUPboQSwNeuabndpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzlyeu0xIB2AA1Kuig6/URXxpZ3nMyL6mxB6QXY24EQ=;
 b=mTqHlGS4aoLvdKnsXanKFFiH3iF5od137ClclgHcwrm+YhLJd9VW2gzLG12r8//ldoE8jEeyjNPm0ypOQkYmZQnX0AVUr6tFfpaSO6Ss+ja9mDmOSIRkeYT7YWi/SqZD6/QRwOABbnxxqBEAV2g19LGN1glxRaOjNwQPVQzzaZ35lGFwhwa5gue+4D3o0ojQHnvbEec3P8/JueMIb7WuK6P737rQCjW8laVtsMbwNbtmpxIBsukkuxNZN6xIL5D+/SyXyJSwAXk1Jhtrc8O8BBRRSXuM2BLyDAtS6eK9uJPvU+OK3LxcT5ExVsUF9WHt5MdMtnpaNOUd00vaHj7H5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzlyeu0xIB2AA1Kuig6/URXxpZ3nMyL6mxB6QXY24EQ=;
 b=tJ2wRqbnUJ7S1TOObpS74diCxj8pTZT/hN3kxU0BN9JZrb1+GzIbTF6i3yZvMpEXR22eLpbb33YyNmCjKg5nkDYPrJH9AYs22L87tprxOGgnA07O96SVWCcD1AaDmTHTLwZdAoqisK+ffQbutMg+ljlxlhi9CvO4fKszYLUhfXI=
Received: from MW4PR04CA0269.namprd04.prod.outlook.com (2603:10b6:303:88::34)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Fri, 22 Jul 2022 20:37:25 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::96) by MW4PR04CA0269.outlook.office365.com
 (2603:10b6:303:88::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:37:24 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:37:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/31] DC Patches July 22, 2022
Date: Fri, 22 Jul 2022 14:31:06 -0600
Message-ID: <20220722203137.4043516-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ff3cca4-ee7d-4d01-4dce-08da6c21fc6f
X-MS-TrafficTypeDiagnostic: DS7PR12MB5814:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6jFR92yS4NBmVDDXSbBhLUr/voh6F3xbawthWtywmGtNjZqrBnHMsRJX4gLdfng4k1S1C9y+ZqbBNZF8zADcTM9jM0QF3Z0BsRuY1gim7eNCGq9im3VtMtoCuBCD1czT3cdbFkw4WzWFs4vvmWQh+JmXRIbAtNb1GgHOTGiMJ9GKUguXzXnoOc8RQ7WhyjDfN+1nou7C6HzVuZcFKmDtG93Aq15HFk3funiAt7J9qakG6Eskm8w70Fh8QjdJCXl81xqN3rJuKw9xByGaC4ea41Ly2wbXC7I3/VKIMP7G3tkfU3l69AfnSlTJGLLHZmIrtF6nJ+ChBrnWIw4EmGyMoumCVwg2x0cS2BjKmhT3owK2oa4+OcMKkjb7nQodtYWmOtoEdusOtUqvHDLwUDQIrm0kuocP8NJSgp32ycDu95hvS9sEiYxFlwQ993aXUEdNW+x9HscbDdbQAuedRj4CxHkTsXbAGHDBBGHDe8n5hMuU1QzDXaDHKxPMJ2sqgyOWKCctjoIFOZL5i5PetxZu6Md2dIh74dBcaMOa/Gc+Hw6nB8GffJP3FM1kKkdD10uIrOFqu/MnN79oh8rN+6q35/qnwwd5iP1CIgBHAiWZ1mzHnmo0M2sFTMQleFbfc8gtQPfpwVACn0Sllf8L2GgkQTnET6QOZymrafwItna82gy9O3yqQ91No31IuMiMsXfMX3XM4//1/Z0PrJCqqfSn6tS0Vvyux81ArDrWiyoPh/Iq5spH3mOec0uKx90a3xo/0aJ66FAwd6iiNvL6CesoSwdZfl7EeRie4q4QKgZyMEcvaQxPZVa4YpSQ4XV5GtZf+my9IrI08ltHf2p6RKQiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(54906003)(316002)(40460700003)(16526019)(26005)(6916009)(8676002)(36860700001)(70206006)(70586007)(83380400001)(36756003)(336012)(2906002)(82310400005)(426003)(356005)(40480700001)(4326008)(86362001)(186003)(44832011)(47076005)(6666004)(41300700001)(8936002)(7696005)(5660300002)(1076003)(81166007)(478600001)(2616005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:37:24.9345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff3cca4-ee7d-4d01-4dce-08da6c21fc6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Copy crc_skip_count when duplicating CRTC state
* Add debug option for idle optimizations on cursor updates
* Disable MPC split for DCN32/321
* Add missing ODM 2:1 policy logic
* Update DCN32 and DCN321 SR latencies
* Add reinstate dram in the FPO logic
* Add dc_ctx to link_enc_create() parameters
* Cache cursor when cursor exceeds 64x64
* Add support for manual DMUB FAMS trigger
* Fix dpstreamclk programming
* Add missing AUDIO_DTO_SEL reg field
* Add OTG/ODM functions
* Use correct clock source constructor for DCN314
* Use correct DTO_SRC_SEL for 128b/132b encoding
* Add pixel rate div calcs and programming
* Remove FPU flags from DCN30 Makefile
* Create patch bounding box function for isolate FPU
* Move mclk calculation function to DML
* Remove FPU operations from dcn201 resources
* Fallback to SW cursor if SubVP + cursor too big
* Drop unnecessary FPU flags on dcn302 files
* Reboot while unplug hdcp enabled dp from mst hub
* Reset pipe count when iterating for DET override
* Calculate MALL cache lines based on Mblks required
* Fix two MPO videos in single display ODM combine mode
* Guard against zero memory channels
* Updates SubVP + SubVP DRR cases updates
* Fix OPTC function pointers for DCN314
* Add enable/disable FIFO callbacks to stream setup
* Avoid MPC infinite loop

Alvin Lee (6):
  drm/amd/display: Updates SubVP and SubVP DRR cases
  drm/amd/display: Calculate MALL cache lines based on Mblks required
  drm/amd/display: Fallback to SW cursor if SubVP + cursor too big
  drm/amd/display: Update DCN32 and DCN321 SR latencies
  drm/amd/display: Disable MPC split for DCN32/321
  drm/amd/display: Add debug option for idle optimizations on cursor
    updates

Anthony Koo (2):
  drm/amd/display: Add support for manual DMUB FAMS trigger
  drm/amd/display: 3.2.196

Aric Cyr (1):
  drm/amd/display: Avoid MPC infinite loop

Aurabindo Pillai (1):
  drm/amd/display: Add dc_ctx to link_enc_create() parameters

Chris Park (1):
  drm/amd/display: Cache cursor when cursor exceeds 64x64

Leo Li (1):
  drm/amd/display: Copy crc_skip_count when duplicating CRTC state

Michael Strauss (6):
  drm/amd/display: Add pixel rate div calcs and programming
  drm/amd/display: Use correct DTO_SRC_SEL for 128b/132b encoding
  drm/amd/display: Use correct clock source constructor for DCN314
  drm/amd/display: Add OTG/ODM functions
  drm/amd/display: Add missing AUDIO_DTO_SEL reg field
  drm/amd/display: Fix dpstreamclk programming

Nicholas Kazlauskas (3):
  drm/amd/display: Add enable/disable FIFO callbacks to stream setup
  drm/amd/display: Fix OPTC function pointers for DCN314
  drm/amd/display: Guard against zero memory channels

Rodrigo Siqueira (6):
  drm/amd/display: Drop unnecessary FPU flags on dcn302 files
  drm/amd/display: Remove FPU operations from dcn201 resources
  drm/amd/display: Move mclk calculation function to DML
  drm/amd/display: Create patch bounding box function for isolate FPU
  drm/amd/display: Remove FPU flags from DCN30 Makefile
  drm/amd/display: Add reinstate dram in the FPO logic

Samson Tam (2):
  drm/amd/display: Fix two MPO videos in single display ODM combine mode
  drm/amd/display: Add missing ODM 2:1 policy logic

Taimur Hassan (1):
  drm/amd/display: Reset pipe count when iterating for DET override

hersen wu (1):
  drm/amd/display: Reboot while unplug hdcp enabled dp from mst hub

 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  34 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   1 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 136 +++++++++++++---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  17 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  20 ++-
 .../amd/display/dc/dce100/dce100_resource.c   |   1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   1 +
 .../amd/display/dc/dce110/dce110_resource.c   |   1 +
 .../amd/display/dc/dce112/dce112_resource.c   |   1 +
 .../amd/display/dc/dce120/dce120_resource.c   |   1 +
 .../drm/amd/display/dc/dce60/dce60_resource.c |   1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   5 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   1 +
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |  24 ---
 .../amd/display/dc/dcn201/dcn201_resource.c   |  11 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  30 ----
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  58 +------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   3 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  25 ---
 .../amd/display/dc/dcn302/dcn302_resource.c   |   4 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |   8 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   8 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |   2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  30 +++-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |   3 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |  38 +++--
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  36 +++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |  37 ++++-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   8 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  23 ++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |  63 +++++++-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 153 ++++++++++++++++--
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   7 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |  18 ++-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   4 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  87 ++++++++++
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |   4 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  63 ++++++++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |   8 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  71 ++++++--
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   4 +-
 .../gpu/drm/amd/display/dc/inc/clock_source.h |   7 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   2 +
 .../drm/amd/display/dc/link/link_hwss_dio.c   |   7 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   9 +-
 71 files changed, 867 insertions(+), 258 deletions(-)

-- 
2.37.1

