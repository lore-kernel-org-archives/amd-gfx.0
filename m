Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD6EC27C44
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6371410E3C2;
	Wed, 16 Aug 2023 21:29:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E4A10E3D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSWkN7gHeJKMv76JFBrSGF5gt/WyU8S/bK1RV5w0fpE+1oQVfE+Kqq7KgtJq/RAbf8/2b+kvvJph2OjDBJ2295ubO+/Es9CP3VTdKqig/AMYG9W7bXr0jPuf2qRaqM9VnjrevSz+S6RlTx2lBpWcVq8En+H8Lp9I1O0uu7UA6IMLpzDnlKLds4O/tsM2aK0JWbHG7lxK1SCZIVB2jYLJh3xkxqUtNXcwXd0xOjyMzXH1PHK4mvzpjyVy9c5RX+sPdi46YI6Oj9ZSDQUgNOCPtOskuxxD4Ck1bYzbNQlRmxhrbLo9k+MdhHZrBA8CjeiQduErSAfmni7SYXmffNRpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uSQS5opt7UzW6itX+HBo7g4TwLEU0WK1ByaFFR55PE=;
 b=D8wO1wP70Cjy2dh+R4ATmQeqMXW84xfKHJ1zeYU8VNvpccBPXCcaxPWigMUXV2emjwbP57CeHFcU1aGYpAYXu+pg2oZpsW9WSPxRdFl0d+cyBQTcEQy4JavDAFuAcVGW+G3U74YPJkNI70cpifnSCVe7maV5uZ2nk/64H5C1HEOxtgMxdrXnrIy+fmoHiZhI94hbFfdxFnphCn3QS2FNXsQrAlXF1/ZTTWA/pPJ2hAyLth9sqoPWp5PHZeZ76dmtkIEVIGWDv+XlVIJkQ7Dq3YUk10W8XLcHAeInZgTQ4eN+nKkWwAP99eN/VJAKR/rvo+dhHzwfYfz7Km8pbr/79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uSQS5opt7UzW6itX+HBo7g4TwLEU0WK1ByaFFR55PE=;
 b=JVBLPBQO3C509FK8GzEiHYmML53u+w3YMNzVxFutAF/jEUkJojMpVZqejDyQfjaiGSzGh6y3Y4oSi8lPjv+9TXP3S00uFXcNxapGXPM+GhwkPq2pZiDwDI/suMr1nSZqexov7C0FQNt/t90ogunbiob9X6EVwRdXpBxRKV63tJc=
Received: from DS7PR07CA0022.namprd07.prod.outlook.com (2603:10b6:5:3af::24)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 21:29:00 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::c5) by DS7PR07CA0022.outlook.office365.com
 (2603:10b6:5:3af::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 21:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:28:59 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:28:58 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/18] drm/amd/display: Create one virtual connector in DC
Date: Wed, 16 Aug 2023 15:26:10 -0600
Message-ID: <20230816212626.987519-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 76263738-9017-42eb-4e45-08db9e9fcdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLR5h/pn50GDhgi/Qaz0BNlY33QVxOHR4jXPF7Uu+T0RpXm9B5gEX98Kar6NQDrFGwx9d2zw/YRAOrAObBcMW3UGnqF3qyeJfKAGzNBlllmZesNSVlDYrc1QtWdJXOaA1IBtMjWgSpYuFSRLGgcWIvtTrF7vOhSzbO97Q/FoqL1P7YCYIHt+TW4xvZY0DYdL1Hn1DvTTo8MpLZsGehcQt9tDYzQMx7MiqFgS25TDJjoI2+im/ljEBFlcStpRFiDG71P+KNDw4HgUeKr/urBzulxJE+fy+EdvR4oIZ2korCO7bIdULx1k/YEAOEt9hgqjCigjO6T5lrjwbr7EPg/uW936i1hDIIAbE9FeYtzThtSvsXc2oswgIFB7WYoeuHcH6oSotF1168yZoVyQSTHy9Cb1sYVTLjekyAzcpGwgX4zLJCx4G2nCHoHdoEBMZysbDNLFn6r024hpH3PvNuCA8XhkGm3IPcJf/59SWUNgdJ1CjyqaLVNt3ZGDJn5ip8BGNubXNahXz+bU2UqXt17WNftu6T5Z5Vo/v3C2vA9DAjfuvDZhpdfgDQlepwhHxL2JdeJ4AB/BWZJUyQLeF1Y9u3JLfX5ZquLKqXgfEojtx9wkya1wt9h0roIpMFcXjPpOo7CtEV1NCIqAjYdMkyJpuyzOigvCvAnv8nAaqr2DhFUG/WANuANPgkIPT0xHHZVcQ4n9qNlttP1ZlJpBit2i8W1EfxbBJKp8KjJhwigbJS83NORZ0wGjP5kGXakcWexRXRiLFOR2AvMNGqur4UYFsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:28:59.4317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76263738-9017-42eb-4e45-08db9e9fcdf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHAT]
Prepare a virtual connector for writeback.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 11 +++++++++--
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b1245b732cc9..00254fdfa1f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1675,6 +1675,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	init_data.dcn_reg_offsets = adev->reg_offset[DCE_HWIP][0];
 	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
 
+	/* Enable DWB for tested platforms only */
+	if (adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0))
+		init_data.num_virtual_links = 1;
+
 	INIT_LIST_HEAD(&adev->dm.da_list);
 
 	retrieve_dmi_info(&adev->dm);
@@ -4385,6 +4389,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			continue;
 		}
 
+		link = dc_get_link_at_index(dm->dc, i);
+
+		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL)
+			continue;
+
 		aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
 		if (!aconnector)
 			goto fail;
@@ -4403,8 +4412,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 
-		link = dc_get_link_at_index(dm->dc, i);
-
 		if (!dc_link_detect_connection_type(link, &new_connection_type))
 			DRM_ERROR("KMS: Failed to detect connector\n");
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 2a7f47642a44..65e8504e6063 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -96,7 +96,8 @@ static void enable_memory_low_power(struct dc *dc)
 	if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stream_enc[0]->vpg->funcs->vpg_powerdown) {
 		// Power down VPGs
 		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
-			dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
+			if (dc->res_pool->stream_enc[i]->vpg)
+				dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
 #if defined(CONFIG_DRM_AMD_DC_FP)
 		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
 			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
-- 
2.41.0

