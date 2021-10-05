Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D83C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB4C610FC
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BB4C610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 447726E334;
	Tue,  5 Oct 2021 07:52:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1FD6E334
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4qIYWtPA3GtdNG4H8QJJlfzo4uuZksqBJazONQT5rEKJ/a/mmsBTQtcxoEawnjRP+kaw1pzClUe+wCgRStDuOyCLyLZ7COHu1RhYjRsG7Ee6iALzYGvyvs7FBuvRqRgEF+Z5QlWEWislXqIiS888PHrr7ZKHQkEBxZzy3Y0iIz+vXfJo3c44zLsiZ0rT1Eoinkvm2mRstO5G8iSbVKpHtzxQExzX/B8SEjWPCCr3djHBwDDUeciryLDlQEiAKu93jEa41YrqamHH5c9+kvp/1C83+e3l7Uxg21RgghPWgxWPb8eiAzBQ/wWBuiAjWNZsrA8FB2KHqde2Tg8KJwrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Si0R9z6isdToJEx4RzdUpoKB4iASzsuAVUdQdlRsR8=;
 b=EStzLHv755GzuQ48AWr3rqJDl9CvrNjlvo1s5oiB8yA/EZfrrPjIy6IJKPnXwLl5usQdzdT5W5YDittxJapvhsM6ZmwVdfg3ISvZOl1yTn31pEyHd6bDTEPmdXsOCM43hSiqgCulQPoriLwCTt9LIySX1rkYbS9inSZqQrPDvku1HMOC2hrAOVWMDzyWsG1NBN/Il33eY2fIJe4TJ0m8hAep0hvCnQPuX5D1XCTUJctxm0KJh/jabrq4rRPZR/hflrKN+/n2/255we9FmpHYZsHsw2co14QBfzmxBC5IvwdKN1Zh8eG4jW4nEPMYTP+kAA53/RysKBPSyj6QKePhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Si0R9z6isdToJEx4RzdUpoKB4iASzsuAVUdQdlRsR8=;
 b=2rOZItsic46bPy9Hk1N1sPA3o62zN2sWGNpcDzoHqcDU71uWrk7Y7B45JuDO3ycr3TvaOoI30dHTnotU+Quqj9JYOIizYmfsK2F1voTXsUjaBJyjQGYc6kdlmv1zaYS0Qy2t4w+UEo3JNLh8+6kMPuLs5W8v0hfpxmfLk5UJgPk=
Received: from MWHPR18CA0070.namprd18.prod.outlook.com (2603:10b6:300:39::32)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 07:52:18 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::1) by MWHPR18CA0070.outlook.office365.com
 (2603:10b6:300:39::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 07:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:52:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:52:16 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:52:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 00/23] USB4 DP tunneling
Date: Tue, 5 Oct 2021 15:51:42 +0800
Message-ID: <20211005075205.3467938-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5da3b58-4b12-4b5b-83a7-08d987d50d9e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4329:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4329B8C90DEE5A0DD40D011AFCAF9@DM6PR12MB4329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYwRVm2JkAoIXdKuDxxvjpWVEGJUUSLxDfrP6nZPj8knyY1+xXAAbAWkKEh0vsajuB64uityqHZ/lx5riXpGUj8BsyfBKJFpN3D3LNGLHfw/oKQzLxzQ/w73elLEegvjUzB0j4KKTvechWj3iMbXZXFzqLhhMCiMhuJJ0rbkXolY2f/qXaXxeQOGcHB1uRREs7uqYnLmc8/kYF1KMylhfCMRsBvpTQ4gXCs/UjwyA5A+jG28uQelEPN1VpSJHoR+ZsYPhiA3afM2pKztMz6eX8RvJHuM8gW/xqIyGnwuk/FYWBa3bFYmI+Tr0PCfd4jl0EINe1eXDLsS/7C1XakWjUq3hmBxR4aLwMaN1hBvkuTg8do1bXNxHRXF01k+rF8rbmgN2Nz+m7FV4cbf/AJD6WZe7kHGvnHHa4ERYQ3Fr9Zu+DOrqxbqz1q51o5z5m/C/sDuX63Zv2061Uzo/Tf8N0V8Ctkj7Sq4VEmM/CgW8NAz6ixIvPXfSaF0yU4XQen3u2I2TSdxV5g9ioDRPUBuFheXC6CkrFUPMbsWge5iA63VYNatmfSNghZ1SmEWuX6MGUCJnamYGWpJLI5W2Vv7BZHHizX7jv8iKPNHlifagyrKxeUeMYeZiq4iKq0eov3KJjk0zAcfmzQVaMftWUVnNguHpyAl0RGMBbZOefIHG6NaLMuqyP/DgLqcR5X58M2buHVkr84EUrUUK5C67FC2Kfc3XGZRNbcXqOhgRI5UClg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(86362001)(6916009)(66574015)(1076003)(47076005)(2906002)(8936002)(508600001)(6666004)(54906003)(4326008)(83380400001)(82310400003)(356005)(336012)(316002)(186003)(8676002)(36756003)(26005)(5660300002)(2616005)(70206006)(81166007)(70586007)(426003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:52:17.4452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5da3b58-4b12-4b5b-83a7-08d987d50d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

USB4 runs over USB-C and can tunnels USB3, PCIe and DP protocols.

A USB4 router is responsible for mapping Tunneled Protocol traffic
to USB4 packets and routes packets through the USB4 Fabric.
For this patchset, we have native DisplayPort able to be tunneled
over USB4 Fabric.

E.g.
DP source -> DPIA (DP In Adapter) -> USB4 host router -> USB4 port ->
USB4 device router -> DPOA (DP Out Adapter) -> DPTX -> DP sink

Briefly, there is a CM (Connection Manager) in USB subsystem which 
handles relevant USB4 channel configuratons. Our DMCUB is responsible
for interacting with CM to control DPIA to enable Video Path & AUX 
Path. Once DPIA gets into Paired state, DP source is then having a
constructed end-to-end path to interact with DP sink as the
conventional way.

From DP Source perspective, the USB4 Fabric and the Adapters are 
either totally transparent or act as an LTTPR. Besides, due to
constraints of USB4 protocols, AUX transactions under USB4 now is
handled by DMCUB to meet USB4 protocol requirement.

Changes since v1:
* Give the description of rough working flow of USB4 DP tunneling

---

Jimmy Kizito (14):
  drm/amd/display: Update link encoder object creation.
  drm/amd/display: Support USB4 dynamic link encoder selection.
  drm/amd/display: Support USB4 for display endpoint control path.
  drm/amd/display: Support DP tunneling when DPRX detection
  drm/amd/display: Update training parameters for DPIA links
  drm/amd/display: Support USB4 when DP link training.
  drm/amd/display: Implement DPIA training loop
  drm/amd/display: Implement DPIA link configuration
  drm/amd/display: Implement DPIA clock recovery phase
  drm/amd/display: Implement DPIA equalisation phase
  drm/amd/display: Implement end of training for hop in DPIA display
    path
  drm/amd/display: Read USB4 DP tunneling data from DPCD.
  drm/amd/display: Fix DIG_HPD_SELECT for USB4 display endpoints.
  drm/amd/display: Add debug flags for USB4 DP link training.

Jude Shih (4):
  drm/amd/display: Support for SET_CONFIG processing with DMUB
  drm/amd/display: Deadlock/HPD Status/Crash Bug Fix
  drm/amd/display: Fix USB4 Aux via DMUB terminate unexpectedly
  drm/amd/display: USB4 bring up set correct address

Meenakshikumar Somasundaram (5):
  drm/amd/display: USB4 DPIA enumeration and AUX Tunneling
  drm/amd/display: Support for DMUB HPD and HPD RX interrupt handling
  drm/amd/display: Support for SET_CONFIG processing with DMUB
  drm/amd/display: Add dpia debug options
  drm/amd/display: Fix for access for ddc pin and aux engine.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 106 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  17 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 179 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  81 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   9 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  36 +-
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 945 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |   8 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  22 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  31 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   3 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 126 ++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   6 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   7 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   5 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  98 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 drivers/gpu/drm/amd/display/dc/os_types.h     |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 113 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |  16 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +-
 28 files changed, 1793 insertions(+), 42 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h

-- 
2.25.1

