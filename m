Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C106E732E9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 20:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A176A10E3E8;
	Thu, 28 Sep 2023 20:06:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66FB10E6A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 20:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP9fMJxAXfxtYrn7DyPhCDvzQ7MxMXpxvQ6P3bwPX8Siiv9+wbjKSRNCaaqOF7mKk5675jGK55ITFLdksOnVIbb9iNjQdBQVZq3EONH/QUIYXgguGb7Iy6HNhNC0zS6IlMqaIO8WiFhKxNcicUHge3+qWy/BPxH/hPwrnN00jwggr04cqu8cbgs7i0/Efv+/ouZGOAt0ZX1pYTHCb9hDOps1SpdqzACBfvAXWI67PpcTr3ccN+PiJaHLr2ZmGbDCLugG4KrleyPxNpnpx4bzCbMjSCZfKrNSOyzbiWBmaE5BkS0Jz4PrE70XrtcaDq4jIsIgGDJyXLba8cMucmsfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOlvf09Inxwr4cbw5yp8X0K17Ooh+1PFssYbdA+RW9I=;
 b=JncrYVZnAIDqiZ4HBIJoKb3tgGC2HU75oMQmaU8PfZ+W3KAQWetxW+2FXig051Lkd33XY1Jr963NFZbzL8grjcq48FWsz8B8hx4Arx/6nBX/4XVaxu+yVDw/YYTS0l6YaCl+54vmp92tKS2/5t0PK5ieeUKffovm31vE3kHaFzOG4er28AlILOwmyvf1GqSE9AVHuwjNrTCcBtFo9I62NhOXJzfJS28qiUk86lLcvQ2HXUq5/tFmqUI/g+n+JNg33sMorFVrMmMzo0NyCP34y6C9qV2/6GYuA3lqaWPIoPCwIWarv152hE9d1BQAI6C+Hah9Jmaf+uWMRt1Na08Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOlvf09Inxwr4cbw5yp8X0K17Ooh+1PFssYbdA+RW9I=;
 b=1tmlgV1YqZxmP+kJzZw7CboxTtp5iYTE9Hb9F/3MEQmMoIJvAaVnAg6uit9OPXco7C5p0ZsKLfp70EckEx4e6racnOjRN15SorbZK0bLXqaSkCnHkANfKtxjYj2gUdNK0QnXK1FAPNC2UFqZwrfcWgoYqVAa5iFExb8PTQCxye0=
Received: from MW2PR2101CA0023.namprd21.prod.outlook.com (2603:10b6:302:1::36)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 20:06:22 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::69) by MW2PR2101CA0023.outlook.office365.com
 (2603:10b6:302:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.14 via Frontend
 Transport; Thu, 28 Sep 2023 20:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.25 via Frontend Transport; Thu, 28 Sep 2023 20:06:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 15:06:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 0/4] Add GPU page fault query interface
Date: Thu, 28 Sep 2023 16:06:04 -0400
Message-ID: <20230928200608.2857534-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfe6ecc-870b-4c49-9b5b-08dbc05e6286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFFcop6uT+OVqd960NJoAq3lPxHKo/oevrIRMskE5gaQFDtLm7D9nIMJu/BiE18KNmMsPWmHRELE9yoeG7TQb6Sy2qRbuHoghFdKOolVGTGTrlReqPzuQeYq6RE3WGJlBuMjPplRsgjf4VpHcuolxMd5S9HsckABCEbFPtYLDaqgqXSQjUp2CmVqz/EY5Y6Yrz8L14AxYbTDaLv8RSQZ6JUFx6UIyxW0FIG1dPnv0KBbq6pOQ6Oo6bg3HGcJBmIvs9RHI6Z/HZnhwydomcxwbs114a9+tkmlXy83e0FZI8HdUw6vLTLeDGEEDbE+xa5j6La/ITR+bqxpiORnhu0ItRgVM8fi3CCKEZKCDMO8V/3iw5mc3c4NKskScXU/nPC0KrUSKZrSCAKSP2rkJTnjcDoDgDWYuNBEVB8kfCoAwV616qiPp7iVWPx1ZLNzL5CrOafrAX9HH7BGYNdgwy7kuIHQCt+zr6T3JdobEzcW8xkQMkqUUO+IkkcW2t7qRDYJGHYXxQwFTZ4il4l/7EEF5ke4OiajW7eJI+dYdpndI3d3tevrHfuI8zch1TtYVXMZQPbLAXCYTurSG+pfGFsP5VP1B8TcI7otsYwNYE/gL/pjrf47zO4qiF1uobpqreoCOaF+0T/LVAD0U+c8UW3rSU96M1pyHEar0TnrNVT0OWaE4q2TE4suoyrRMBAFoehbo2N+PyftVkoEdK8p2aCfZ3KbIIFSMXHr0AMWWbsM78QEF9nA3S+oKO8ELwDhFijqkTrHp9E9Cn2jFGbvGyt1Lzc3qRM54g0LScRzQw3TTmA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(40480700001)(41300700001)(4326008)(316002)(8676002)(8936002)(5660300002)(36756003)(70206006)(70586007)(478600001)(86362001)(7696005)(1076003)(6666004)(2616005)(426003)(82740400003)(356005)(16526019)(336012)(26005)(81166007)(83380400001)(966005)(6916009)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 20:06:21.3942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfe6ecc-870b-4c49-9b5b-08dbc05e6286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set adds support for an application to query GPU
page faults.  It's useful for debugging and there are
vulkan extensions that could make use of this.  Preliminary
user space code which uses this can be found here:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/298

Note, that I made a small change to the vmhub definition to
decouple it from how the kernel tracks vmhubs so that we have
a consistent user view even if we decide to add more vmhubs
like we recently did for gfx 9.4.3.

I've also pushed the changed to:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/gpu_fault_info_ioctl

Open question, currently we just expose the raw GPU fault status
register value for each GPU so UMDs need GPU specific knowlege to decode
it, although it's largely the same across generations.  One option would be to
translate to a generic GPU independent fault status.  Opinions?

v2:
- Fix spelling typos noted by Guchun
v3:
- Add locking in IOCTL query
- Only update cache if fault status is valid
v4:
- Rebase and resend

Alex Deucher (4):
  drm/amdgpu: add cached GPU fault structure to vm struct
  drm/amdgpu: cache gpuvm fault information for gmc7+
  drm/amdgpu: add new INFO ioctl query for the last GPU page fault
  drm/amdgpu: refine fault cache updates

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 50 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 31 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 ++++--
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++
 10 files changed, 135 insertions(+), 8 deletions(-)

-- 
2.41.0

