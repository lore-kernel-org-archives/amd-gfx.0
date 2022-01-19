Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19567C4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 08:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B2B10E665;
	Wed, 19 Jan 2022 08:25:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2714110E665
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 08:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOqHYpvbL/lhWBXoeZfe3NewyLEw+EMkn6KqplitQlldUawMN2NklfPqz2VP8AqKaVXpdntuRyXaH4tvJaty+0dfp+T/50uOqShUPUGxOVOENLnnbaaIxcZhMVLBDxtUKxCkTU2r3ucuPCacBmkNwoQbFxaHrEFkvSrFiSZeLN+Yo8+bI1S+nrDFlet4kepT+VPI+hcNLxoo3tI/LqoYxmDyQ6cGsBlBP2OS3UzwMQATzWXQGt0ZtNzCBbose98Ku0liT/fO2LmY6JJ9kc+idlRNsIC5HCdwFqDEIHRxR2v/jA6nSiW8CqrX+xXnm+M3cwLBdtkn1RhlKsUkaWWOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZsuQl44M9ve7DSnum6Y7bGd0hKxLPU8LROzlNAixRI=;
 b=CH92zF6KTBH2HWxNZoajxwanTWnFRb3EXet92oLo5+S5oj3tIshX5GxOLn8FciVqzeW3jZMSlG+klmJyx9Ouk1XEJd9+lEVITx11nffsgGlEsUpXz4HmtyonD+B5YUMPlcnnFK0gD98f6avRJ/r2pke82o7V/gGraDSTQPdLaKIViSh7FmMgsWWtIzR3rqVV/wrQeJyjzvGc6kn6lswtP1Gu6aH/ZH9SkqgaotoRoPxAaQ6pdbPb8HWpV7S1DDK2O+vto7Ew37IpeIVsY+2PvgFV09esxWnCPcXx3BsAyBfS73D0/eoUfsvQzOL0weVeoXUzS5T6s/mpEJmfEipqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZsuQl44M9ve7DSnum6Y7bGd0hKxLPU8LROzlNAixRI=;
 b=wLlAS0dBQDoTEza3K7tKjJcWQFGQn4Ojz3n+ABFkCYqWsSoxCeLZ2uPGtSqDrFIIENPIHwK0gz3atD0neDgXKfjsw6nfS9DviQYOuM1MumwqYGz4cqXPGXQD6JGrIkxpeidPKzuMsSelgzllz9RwXV1Z7VvUNtnyXldC3C8OMto=
Received: from BN9PR03CA0581.namprd03.prod.outlook.com (2603:10b6:408:10d::16)
 by CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 08:24:59 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::7c) by BN9PR03CA0581.outlook.office365.com
 (2603:10b6:408:10d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 08:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:24:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:24:58 -0600
Received: from wayne-Celadon-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Wed, 19 Jan 2022 02:24:49 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] DC improvement patches
Date: Wed, 19 Jan 2022 16:24:35 +0800
Message-ID: <20220119082443.1046810-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be24301-adf1-4560-bd68-08d9db252e5e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0118:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01188E026828C9D04A0260D1FC599@CY4PR1201MB0118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2qTxVr45980asNmCPjWKIMewuJg1EJJzmMTPOW5uN+/7Q/Oe/RjWtydliom0qYLNtz+K9wDUKhLDyUQ/oPtWdk3ENCggAsUPN4L+kwSGvpMjnxJeRAHv2+9Z5eyMlaUlJz1ZOhCQ5E4Nn6hsjvdWLKDQREyNBqOcaij80ir76JvsEwB7dJVPgcq7DIuhn3ivZFv4irOjUin1+GNWt3y3PqiSgMF/S7x5XFYGbBt4f2qNJTqD6MX10SwIT84X84rZRHQpbZ3nSLC111Gcj655z+erndUdOIV/+YpGXJdyZCpA60mhiJp5ynH1/kIfOr50EnoMrxnzOvb3KDG2RtdpQ5GKXkFEZrJtB9kl5w+jWH4GyZijke+fgL4ftnQOgtWIdTDmdhkEv3rrZHuXQGIB4q+8e32nUGhTxazJyyCby9AMP1tRzmtAq+mqJiVQpap50hq6Db2VfMcfzoLocXeEKYxZBpE3kgIlXBn0uor9qe7eEiJ44/1btQd8C5pyDlMtz9vHgr4dOvNDhqZD2G78srV5KbtBWR+3VRql9VxAHy5gNYFu9CtG3dGWaY4V4+mz7pVrU1akm266DrhrxNeQRGlMdSya468OViRQcxt+hGxcPb1ocpZj8OwuZJ27g3lhGhHE26+GggTF2dUoSErwRNhKwQVZRBPzyvN0LkLMaZ1vtqKpUFZjV3wiENHFdPgH8+92cytFoUDGuZGLoMaJoaf9qFmkoDA7p9YRs2nk0zIkrOqcZv1xc4X4kn/BKxaSOug5npjjkIdrrmcwov0xWrYPteImUe3Wd6ds2CD/uA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(316002)(1076003)(36756003)(6666004)(508600001)(54906003)(2616005)(6916009)(7696005)(4326008)(40460700001)(426003)(186003)(2906002)(336012)(47076005)(86362001)(36860700001)(82310400004)(356005)(8936002)(81166007)(83380400001)(26005)(70586007)(70206006)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:24:58.7557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be24301-adf1-4560-bd68-08d9db252e5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements mainly on dc layer. In summary, we have:

* Refactor codes under dc_link
* Improve TBT3 compatibility
* Fix DP2.0 flow logic

---

Jimmy Kizito (1):
  drm/amd/display: Add work around to enforce TBT3 compatibility.

Wayne Lin (1):
  drm/amd/display: Don't update drm connector when read local EDID

Wenjing Liu (6):
  drm/amd/display: factor out dp detection link training and mst top
    detection
  drm/amd/display: Drop DCN for DP2.x logic
  drm/amd/display: abstract encoder related hwseq across different types
  drm/amd/display: add more link_hwss types and method to decide which
    one
  drm/amd/display: rename dc_link_hwss struct to link_hwss
  drm/amd/display: fix a coding error causing set throttled vcp size
    skipped for dpia

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  14 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 -
 .../drm/amd/display/dc/bios/command_table2.c  |   4 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 734 ++++++++----------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 431 ++--------
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 210 +++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  14 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  27 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  43 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   6 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   6 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |  54 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  12 -
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   7 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   2 -
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 -
 .../amd/display/dc/inc/hw/stream_encoder.h    |   6 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |   2 -
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 -
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  22 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 -
 .../amd/display/include/bios_parser_types.h   |   2 -
 .../amd/display/include/ddc_service_types.h   |   2 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   4 -
 .../amd/display/include/grph_object_defs.h    |   2 -
 .../drm/amd/display/include/grph_object_id.h  |   2 -
 .../amd/display/include/link_service_types.h  |  12 -
 30 files changed, 554 insertions(+), 1092 deletions(-)

-- 
2.25.1

