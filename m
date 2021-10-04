Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490DBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F3E61372
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11F3E61372
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E7B6E9D9;
	Mon,  4 Oct 2021 14:41:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362B46E9D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD4Igm70hKbG4uBaUQxw0s+L83hjasQWKdxjjwJ/JVu3Vvm2NzBJGZWdmR/IOiW5KotpUcqbDcoQHPI3h6Qm9/GvM2uy3FBp4sSPnlljcXS8icoF5ouFVz8I0/LKlZy1qkPM39TUIinLj2kjBLwJcsnmkPXTGpkdexge4gyeMrIUK8umuXMRDO6kF5qrkEXI7Zp5Y1Q27v7OWleq4Mvy6wyyfuXugmKAABnwI1ux4uEAH4HQ9vyXatGKNNuckDKTHiwKd21J0WpwoO2rotncG2GuazbKaDHVbk82eE76nJ1okXy79EdgDJRbU766IyruFJJIBgB/XeomUivvWZ3bYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQsnqkZ3XK+ZIt3MDJ7zsWks4JbNlPCbYkVgcuP1weU=;
 b=KdCYCwYrhdrcl/gDtNGeQt57xyfJ30ItTkUSm+oZIOLZj1aELHPQzZKm0TCubPzJiViGPAnyrPsX8Q+cTUNx4/L00wsdZjxI7/LPcy9nVpXE3t4VC2b8w6fITXyuXqg/hVUwHiHpO5wt3QvDNwhYHtXhri/PYf6I3aA3AVk00vOfBOoyMX4LnVQxjZElVui7xjG1Mt4nRxxlNYi3hUC60rCtfmeYqJIll9IOKc1E59S4IsEMJKsU6lJW9H9ioblqP76+oNZVOaRSh+Ll69smvlzzmqI+93xzmYY8ToRLAR7yflXYkeYXEWSgNrgMRfT+q8wp8AECGkExMb87PRva5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQsnqkZ3XK+ZIt3MDJ7zsWks4JbNlPCbYkVgcuP1weU=;
 b=NfeR9KMgfq8b6b663XUNwoIkG2VbVdJl8EATwlzZxQEaxIweQgKL2Ei6VI5yz51JupmhFTTR0JeldgmYToppg2t2vLttq004N0tgjzG0bSOXyq8t0xQzd1b4DEN1NHkYfjmKyNajysNHB/O2+H90BAdgcGtWhuUCtxk/YQWen8c=
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by BN6PR12MB1153.namprd12.prod.outlook.com (2603:10b6:404:19::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Mon, 4 Oct
 2021 14:41:05 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::c7) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Mon, 4 Oct 2021 14:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:41:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:41:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 07:41:03 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:40:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 00/23] USB4 DP tunneling
Date: Mon, 4 Oct 2021 22:40:27 +0800
Message-ID: <20211004144050.3425351-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f86d558b-6c58-401d-643f-08d98744fe73
X-MS-TrafficTypeDiagnostic: BN6PR12MB1153:
X-Microsoft-Antispam-PRVS: <BN6PR12MB115377B16F08DC683DE9A839FCAE9@BN6PR12MB1153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+R5QiDgEFRfQXFM+6fbCP1F+QZICv+TPVmEuYNMkJqfe7mI4qyUhfgT/MhDBXYj+ujycnhBu+gcQ/jnPVfD5d160+C76L+bOX6K/qGBfBi4OUljo/JzEWaRkipNlhTXV2lgWTQC0lico0i7BkWFTlxn7V+B42bQGmVLs09Q1xe4AWgpp54lDXph/hohwbBw+J4QamevWlfhfftc32zNh8sAbwAgpDQGXD0ubYIDhQDYWzbJ607LE3xXVF0liWFR1gt5JeqreeanNwlmU4QyGIfjIHg31NOvYse9TdJy2kQxmu5pnq3qpBdqe45jfPRwFJd1gfjigL0s26MEnbBDqVHc5NCFqDSZAr0MTOyzPJ4Ta7ZGB76M5vowiGr9AWwQfu3qXvC1ZIBBc1pq3TFgugv5EWlVIrAXD1RdhqUoniYFHkC9Y3DZ4j42gjU5rXiurSesXGJT4f5oRmDgZ2ZJaOwj117dupjBkpHpEulnuMdHK9DFnjCbOhzzKR5q/g1gYYUPJMWzYmvm0mUyrgadYgK9ameM6kQD0b/QYgrJ0T+l8QqayFQ4VRLGUNHCWBbpAIsZ6EVTYH10I4E1mbYZpqT5g17W+gZhJLEKxlDSl3V7ldOxJk+kMdEVjXuKZPRC8sGVlwJ4rlTapEgjWVQ3RZ4QxnKTCzvZ0eXEwjXSCbOhZdhy3+Q7Gioe3Ae8BALS5XB3wSAdSyGr6NcwJBQDbnFA7AeMjwiePkAzZje0aNQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(186003)(4326008)(2906002)(508600001)(54906003)(82310400003)(70586007)(8936002)(336012)(70206006)(83380400001)(6666004)(86362001)(36860700001)(8676002)(81166007)(356005)(426003)(7696005)(316002)(47076005)(1076003)(26005)(2616005)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:41:04.5697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86d558b-6c58-401d-643f-08d98744fe73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1153
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

These series patches are for supporting USB4 DP tunneling feature.

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

