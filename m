Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D604DC47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9E110F318;
	Wed, 31 Jan 2024 20:12:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D46310F318
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhlZ1mvJwSApRQADWM0smOPN4kjgugES6tjT2yolLmmq4vpRrPcm5V0YfRZkNZKqzBWALoE2m226wPXIFOBCo91zY7GfTW7Yl5C2xf4Gyf9bckLUCdE7hCoKP5YTU+jROcD9LXFTQnUNk2jqW0JSsxj1rdOx1bTKERiT5bPM/PQgdNuTsVvGkVFVJtcQ991fNisJ1s2v9JyIgNvnwxNhPy+PEJgSGk/oWlF331DDNXxeP/VcQyr3IbgsCvaUcMI8RKVAr+aMQntFVZl2vgaSpGlrIfY9dAaAL2iUXDguCStbZ24HjYvDzYzRxVa3ICxArXBfsLCDj94j2cER54be7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuJ8yvWO6hHYSwQG1gQ/AE0qGxtvtgQSwmZk+GutvbU=;
 b=hEdvG8NEdCaxtsw66tNHUcPX2nUyTUFawMPtdMH70GriN/qlMceOtrkILYLA7s39oMnIKyG88lGL0tARld0/1w74WEknVfu5FPZTKOTq+Yh8O0Ga9rvj7RKXmRQ4GPZ1/0+LpepT/NNBWLwbDZ+kx1lInl6uHnKHom6aKM5XfBTHP3E0k5CtbNxWbTlRdwnVkE6TEay/qz0Ndq79qu6fYFpBSTbE80kNrvkPLkA1g4y9CRQ4+RijdgbD7H5bOTdD7JkDN/8V4VFn/OCnXsruQZsbuxlaiQJ5wwqbot4PrLRnurnqKXgpBRrumyLXujleHeqSj2Lyr5BPEmml/gYvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuJ8yvWO6hHYSwQG1gQ/AE0qGxtvtgQSwmZk+GutvbU=;
 b=J5XQbYbnP59nr+xQifO0eWMghADB2AjlGMMl8ADXZzci3RfsvjJ/DsSizdHqeZ8IY4KCDoLhIBtv6oPnwAQNfN6CyarOzt/TsOitEhRy78RcnKF1C95ACWdAriWnnOvNPna5VTa8623EJBoJXYAf7jLW4zKRihNBHgh3pPseBJA=
Received: from SA0PR11CA0100.namprd11.prod.outlook.com (2603:10b6:806:d1::15)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Wed, 31 Jan
 2024 20:12:42 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::73) by SA0PR11CA0100.outlook.office365.com
 (2603:10b6:806:d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 20:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:12:42 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:12:40 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/21] drm/amd/display: correct static screen event mask
Date: Wed, 31 Jan 2024 15:11:10 -0500
Message-ID: <20240131201220.19106-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bcd6d4-0e2c-436a-1b1d-08dc2298fb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+jLNroV1zEBW94BMm7SbRrn8GLsM1EIvFIPAPG0cEhvWiQrTAW4fWdPZmqi9gjtPR+mRvySX81LfgLjtj7L5WvaSri22id1+7G/1XY0Xjo5EcPjXKHTxrxpmvZ5+yMsHP76NQko3hCwlcHOjUBFBiisDn+pZJpigyiEno2BjRDsVePYzvkvo3AkZ1zb4hMRrIGZ6FtGcOFvm8Ev7tIuzoRBGnttyAW2ogZDYSJjq46LH195k79FtRbNVAmU1mjTrzlLRZCY3H4WX8NJqVn8XSgJySP0LVNLSbi+0ElHxIw725IBlkEdVH1l/3Lg03uQerZKwMfOr4DcozPwYqbQQmoMGiD2pRqXxQ0Rm60KWHlVYQxBzdtzjs/tcZx9SBYLFwy/edoUqXdfxr9twzFRopmduwqWZkPkAMOeRCgHpfhLIdRwGOYe5lXQrmCjImVqWXWSjChreQLXpzvYXnKWR+mLC84PP1kw+8o1bOXDQ3YJYR5A+f2MsXExTHG1dXS9UcfqntF3kUpszEKFdEQACdX4qUQe/nfqPy1RyMmfgbbfhbAzNjFmiiGWADN7rxg+c+TnzMPlZC/wrn56mMaC6zWvsHHcLEMfYiA/cXo7yOcagWNZh8eX7vAlo+VzhQdixDWRtOpHu+KpJHGs4MkJldHCWhLZzHhGdS209orPOXHX1HgdHya1D/D6osgVbl8UtiA7MlvzVu3bhSX5pqwxUOx8XUZDTGzODMp08tMQ9oLOuu2i9hhfc0l8CN3ywPuNboEDuww1w4XnhYjQ+EMtb6jN5c8QKA3vdm9yxi2IaDWLe9kZ2PJtmfPW0j4mVgk9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(41300700001)(4326008)(44832011)(8936002)(70206006)(8676002)(2906002)(5660300002)(86362001)(70586007)(316002)(54906003)(6916009)(356005)(36756003)(81166007)(47076005)(82740400003)(478600001)(6666004)(36860700001)(83380400001)(1076003)(26005)(336012)(2616005)(426003)(16526019)(40480700001)(40460700003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:12:42.3528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bcd6d4-0e2c-436a-1b1d-08dc2298fb2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
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
Cc: Charlene Liu <charlene.liu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Allen Pan <allen.pan@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Allen Pan <allen.pan@amd.com>

[Why]
Hardware register definition changed

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 21 +++++++++++++++++--
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  3 +++
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 8b6c49622f3b..4b92df23ff0d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1342,8 +1342,8 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 {
 	int i = 0;
 	struct drr_params params = {0};
-	// DRR set trigger event mapped to OTG_TRIG_A (bit 11) for manual control flow
-	unsigned int event_triggers = 0x800;
+	// DRR set trigger event mapped to OTG_TRIG_A
+	unsigned int event_triggers = 0x2;//Bit[1]: OTG_TRIG_A
 	// Note DRR trigger events are generated regardless of whether num frames met.
 	unsigned int num_frames = 2;
 
@@ -1377,3 +1377,20 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 		}
 	}
 }
+void dcn35_set_static_screen_control(struct pipe_ctx **pipe_ctx,
+		int num_pipes, const struct dc_static_screen_params *params)
+{
+	unsigned int i;
+	unsigned int triggers = 0;
+
+	if (params->triggers.surface_update)
+		triggers |= 0x200;/*bit 9  : 10 0000 0000*/
+	if (params->triggers.cursor_update)
+		triggers |= 0x8;/*bit3*/
+	if (params->triggers.force_trigger)
+		triggers |= 0x1;
+	for (i = 0; i < num_pipes; i++)
+		pipe_ctx[i]->stream_res.tg->funcs->
+			set_static_screen_control(pipe_ctx[i]->stream_res.tg,
+					triggers, params->num_frames);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index fd66316e33de..c354efa6c1b2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -90,4 +90,7 @@ uint32_t dcn35_get_idle_state(const struct dc *dc);
 void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 		int num_pipes, struct dc_crtc_timing_adjust adjust);
 
+void dcn35_set_static_screen_control(struct pipe_ctx **pipe_ctx,
+		int num_pipes, const struct dc_static_screen_params *params);
+
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 29a93dbc6631..a93073055e7b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -70,7 +70,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn35_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn31_set_static_screen_control,
+	.set_static_screen_control = dcn35_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index e5cb7fb8b2d4..ab17fa1c64e8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -69,7 +69,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn31_set_static_screen_control,
+	.set_static_screen_control = dcn35_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
-- 
2.43.0

