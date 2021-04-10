Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17DFC433B4
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0F7610CB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0F7610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2056E0D0;
	Sat, 10 Apr 2021 02:04:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB2B6E0D0
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDRqOwQyxZEHEMFvHSAYPFs1dQE3FnaDFZsGue5tNF+TE4KVKoMMI/FLp6NLH3jZml0U3ypdxZ3/IPkueJvXl9FSuBOV9VCr8gI4W+LWm+VkCf95oDyQ69RScBIpX1I5ujjGGBbOqGOlqdaUyVweqbpaZ7Z2x6PG/p/V7/NS/krArfKGwD+crVbf0BUN2c25AEmnKX/vhM9/fG4Ry+aHN4u0PeV8ITGIVxSsz/2vUOEVyBgpL0Q8zIOCX3tf7thH9zX2va8iiAL27hfU5PBzwszFv1CSFqVzKYP5EpeidVsn9p/XGHnHCnokCLQZrQIm7FifmQEkTRjsHpkcd/mPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC7zDQCayO5dBnY6IXrY2RStyMDfHqo8KufZrtTfyL0=;
 b=e8/weDLUwLEXeBP541gglCBOLdiMcmfKgyukN+P17kvrbG0Ni5g6NCPVfmTOzxYiO1TwJhOIPhmjY2R7tdG2pwYfUWfiKgccELoNeS+jK2ypenenRXkcton3HUeteT56m2zBvl+XepHrgoLNleIgUeVbsr4Dxm0Ohbo//mDvjr+Y/KgpBwMavOJAgwxqrvC/I7y1UfmSbjVU2dfO75Uv8BoI3N+lyrKRGruTUA878JLP+XtdIKeN+eW3tDh6Lk3R/LF/4qKJ/0YO64O4pdo5RAfjp9TsTMFNS4BqGnntkg+Wl47n/8gYXbEmmophzNZvMp6z3ubn1hX9Pu6iXRNgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC7zDQCayO5dBnY6IXrY2RStyMDfHqo8KufZrtTfyL0=;
 b=k2tFxPLobHFMLGi9eETF8zCQKt6LzbRw11M48wZ0EZ8y9O/6j/cEI5osLKkqG2/QxlCDwNdhwJfBxPBGM7hNw2Zz7j6UOtMbrWi4sbtpaERLbBBJ1XkDIjsPo65Kk75HLTVnnnV1Q6iEkFCd+YiCQTtlXZuvB3cb0HXgQIc6UEA=
Received: from DM5PR07CA0157.namprd07.prod.outlook.com (2603:10b6:3:ee::23) by
 SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Sat, 10 Apr 2021 02:04:28 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::11) by DM5PR07CA0157.outlook.office365.com
 (2603:10b6:3:ee::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:27 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:26 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches April 12, 2021 
Date: Fri, 9 Apr 2021 22:03:45 -0400
Message-ID: <20210410020401.1100228-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 090c13e0-2c35-4cff-f25b-08d8fbc4f8ed
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2365E817804D746549383B8CF5729@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxUMnpMtDm6Y4rGReABWvON7ULDwfH7qlYqn3C70ZoLXapwv67Fmdb8bJduWJXqLOQF3XJTRBTvMbGTAJPXn5a9Bs1I+hNnsRo7WZlTWND6yAhUra/tsie+u36+PpdhJExv7JwhGozVvbQBYg5agThVjRT/EQ90/BPnvQTHTRnz47gTAPChz1nvH6D/2awW6sDT7/reVnLzQ1by3Gbmy8mLqkqy/aPzYtez8WMgGb6lLV5Zrg1ZWmPvPTkFMl3HIVAtzqFkRPHovRmnjM84579iT2K8a2/NE/rmfFqsSOeb0KcZC4rStZ9cEXs97LbvDZ3tzXJICcW7tzK/CYtyKxUzjfCL9We7V+T98fpEBOF7Obdt4zeu8TchPJh3d1PfzjLdIPxXN0OkT7oDMKswFsLPVmcAY06Vr67lRQNvqANQqkKK1sYwkq/qLArx6LXVCgV9UUNAZl6PKPXpf7buzIEsTMfhzrxcRAB77opetEtZktxpRJkA/CnHS1O1fNHclXy9jW1zyRyRKAtcvWcluwDnDvh8/uOl8RUL/yB1Wjb5r0AJ3xmAXbDlv64LgseTTQCH15ehegp7dzti6H/OiUXOWaG0hRjPQKqYABpuFa8uXMzf6ltd7RMXZzDluunnEQlxOPlD22Ux07RIH0Y76nh/wMDHptDlkNGCxe9p8xzivfrgQB0vRmjPyEetdxHIF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(2616005)(7696005)(82740400003)(426003)(316002)(36860700001)(4326008)(1076003)(83380400001)(336012)(86362001)(8936002)(8676002)(2906002)(47076005)(81166007)(186003)(6666004)(26005)(356005)(36756003)(5660300002)(6916009)(70586007)(4743002)(82310400003)(478600001)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:28.0501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090c13e0-2c35-4cff-f25b-08d8fbc4f8ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Enhancement for multiple eDP BL control.
* Add debug flag to enable eDP ILR by default and debugfs to repress HPD/HPR_RX IRQ.
* Connect clock optimization,Set LTTPR mode to non-LTTPR, Fix DML validation of simple vs native.
* Fixes for DSC enable sequence,Force vsync flip,hang when psr is enabled etc.
* Firmware releases:
  0.0.60
  0.0.61

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.60
  drm/amd/display: [FW Promotion] Release 0.0.61

Anthony Wang (1):
  drm/amd/display: Force vsync flip when reconfiguring MPCC

Aric Cyr (1):
  drm/amd/display: 3.2.131

Harry Wentland (1):
  drm/amd/display: Add debugfs to repress HPD and HPR_RX IRQs

Jake Wang (1):
  drm/amd/display: Added support for multiple eDP BL control

Lewis Huang (1):
  drm/amd/display: wait vblank when stream enabled and update dpp clock

Michael Strauss (3):
  drm/amd/display: Add debug flag to enable eDP ILR by default
  drm/amd/display: Disable boot optimizations if ILR optimzation is
    required
  drm/amd/display: Remove static property from decide_edp_link_settings

Mike Hsieh (1):
  drm/amd/display: Fix DSC enable sequence

Mikita Lipski (2):
  drm/amd/display: Remove unused flag from stream state
  drm/amd/display: Connect clock optimization function to dcn301

Nicholas Kazlauskas (1):
  drm/amd/display: Fix DML validation of simple vs native 422 modes

Roman Li (1):
  drm/amd/display: Fix hangs with psr enabled on dcn3.xx

Wesley Chalmers (1):
  drm/amd/display: Set LTTPR mode to non-LTTPR if no repeaters found

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 35 +++++++++++++
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 10 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 22 +++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 +++---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 49 ++++++++++++++++++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  9 +++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  2 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  6 ++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  7 +--
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  2 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  8 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 31 +++++++++++-
 17 files changed, 191 insertions(+), 24 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
