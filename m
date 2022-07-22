Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2479ACCA489
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55AE935BA;
	Fri, 22 Jul 2022 20:44:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4964D935B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+owcVYwx2Yu1Dk7lfpTHZIoWfL7tMMFfD39TVP1hGkA5MYsSfqLMHauG6ZVWAdVOguReCXJ2z2G3jJEmsvPm636vi/dGMNBwq40TM5/OWxWzLlkMQU7GN4nT1jJLqxAwzbNBrHw0t5tjoTWxj7QK3cFQ9zc9fV/rqb2TLsqtj6K+blKZUBkQsgd8A+jKpt21i8NE6KRyxypv0dXTMUaL4sHxx56h0GF+h5OMPUnBernGdaOVQya9a4WAzKfsKbqNX2wAgX1WMkOXgF5GceB7OrmOdzL6M7WWfQqWCFa1JE6yIVlGkfaB98/UwIixgYQ9cLyilPYSqerYv6b71s4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZE+1KES5i/a6VvQHLUULEemWoKm+RHBiyBg4eMrTC8=;
 b=Ra9mIxbmmCT+0OGNXsqyP3o/WiidUdFw/FELp0dkTJobN73vKhd3YnGwHv6tZFwvhRmirwlaIOMi3Tb3CtWPw2MsdOcxOwh0F2F/yUfWZvgKa13VLbgVfFPtkitFjsBBNjvTjfJbYAekpbUSG08wdcJM+yGkTf4ApR71XvdXnLDMfQ/zekkBAhqpickriMphulDH/CzUbN7n4wm3M+JLeGhe2kzrno00ijqjvdGc7YN0kjGEGQQ/IYpDpXWfGZlca1WFxh6S7q/FUfAtXlsopVIoTCUFx7oPwUg0lTlMW1CW09Dw6IDS7472e5fnPidFhneZlwW3fP5IitssFg0Cgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZE+1KES5i/a6VvQHLUULEemWoKm+RHBiyBg4eMrTC8=;
 b=fQn+IGomyEUJGYY1/7VJMIc0vu1A8DMw8hk14rcgXUCySlJUxjH0WtIvH2fYBrf9BRJEl53nX2MW1rxzBArIJ5/lpL4Ks3etWia+5TGx2L3JRNp7USIO9msT9IQx5Lq141jg2qfYYfqtvvagk4C9Wl6c62KdvbIuwOiNMDG0vJM=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Fri, 22 Jul
 2022 20:44:11 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::fb) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Fri, 22 Jul 2022 20:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:44:10 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:44:08 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/31] drm/amd/display: Copy crc_skip_count when duplicating
 CRTC state
Date: Fri, 22 Jul 2022 14:31:36 -0600
Message-ID: <20220722203137.4043516-31-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b30e2b7-87b4-4ed3-f7d5-08da6c22ee76
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RqCLPIOUwAcCDtgRUOUHQlquUNmkEbnvyIDvqlPPnrFoGV+9Aulg9jlQEMaJu1FCqDlql8fq0Wi2+cT6iv0roV4WBOBlYvoX3weALJXZYXxkOiqxnRoMYIihhYBiuWkoGTzj/GgilnvEyLCTvAYbITV8XBJzJ4fJe4MVhIjlVvWk9VYg4/bGEQyoMu5aBaqgVy4UnDgDUc+EADZoqwhZlZO3BQJusZ9B6shJoRziNgLAv2W9DlhN2buxmGoaSK+olZNZkL9hgQs1esxPU2Iopg+/flhaImB249Y0DJvxYr7nyxT8PR4qvyuo53P/k0xqmX0IiA8L9jLEhG+70oYprrp8N6EhkFJjhD1j05ePH7WEJXeRremN3t6wJPONYRTLsORb5VX6aaAoo4o5ZFr36wi5pnPNv2PtNQXTeiu7zj+kbV6L8a+Dyto3vZdrblm2OSKei5Rpqmol5viCalDNleo4+IQyoI2kHbtTqvA82s9wuHcHMmcujU2iKHff+yltWuUzgE8CGy4yLSWyR2PjlurqPqHc2UTSB2k7nzGOan/uGKZgP5eKWK2oEHPgtjr8c3rhmi24eH8e3d7kQJRgQlurl7R3FfvQzG2tkZHpUA8A4FbrE6fjIQS1XZwsiCOxT6uYVR7I3JBpIRD0UA2edhaZdyEvnsKqofyppG+MlNygMwRVoK8FqDhqxW9A+BravCcn1CyK7wW91YpwSK45F6xtr7yLvomffMgWGlacrRYyuUDvIC5vR1E0bvK+cnEDPJyjaOUN/xaOYJ/8eUbZMyHXylM4ShpI81WkkwgEmmpEv5K4x26YyZgtqJH7Cs0IJ3t3NUCcpsG4iSbTeLzTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(16526019)(478600001)(1076003)(356005)(40460700003)(82740400003)(81166007)(26005)(7696005)(41300700001)(6666004)(336012)(186003)(47076005)(6916009)(316002)(54906003)(36756003)(2616005)(82310400005)(40480700001)(44832011)(8936002)(70586007)(426003)(5660300002)(4326008)(70206006)(83380400001)(86362001)(2906002)(36860700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:44:10.9933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b30e2b7-87b4-4ed3-f7d5-08da6c22ee76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Leo Li <sunpeng.li@amd.com>,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

crc_skip_count is used to track how many frames to skip to allow the OTG
CRC engine to "warm up" before it outputs correct CRC values.
Experimentally, this seems to be 2 frames.

When duplicating CRTC states, this value was not copied to the
duplicated state. Therefore, when this state is committed, we will
needlessly wait 2 frames before outputing CRC values. Even if the CRC
engine is already warmed up.

[How]

Copy the crc_skip_count as part of dm_crtc_duplicate_state.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index a9413acfe4dc..c89594f3a5cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -243,6 +243,7 @@ static struct drm_crtc_state *dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->freesync_config = cur->freesync_config;
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
+	state->crc_skip_count = cur->crc_skip_count;
 	state->mpo_requested = cur->mpo_requested;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
-- 
2.37.1

