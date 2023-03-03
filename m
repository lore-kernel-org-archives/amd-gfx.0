Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3E8C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A79710E6D4;
	Fri,  3 Mar 2023 15:47:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC7F10E6D5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdI6QGTXF5OThjE27QkSlhX0vD5SXtAWIPQ3/g68xlGm4AgzL3uGWBAAD8NGngnyfUrsBRhvjf6Shhm8oFbCQyARMuEZ37EmNxFjShf9M5a0LbrjOmejTFKhgfW7dVdUUsXWlMuY954joLS8j9VnmoFUcWF1EmFj8nLRJ6sCcyc2ed7fiAaFQZcX1idKtz7PBDyZ/q4dIXiMlWBrwDfHlUdTa3S+irAvN1G5/F6nkg8dl7t00gVrqd+b+UIcW2k5vrsVh3eKqUaSh6oV3VW0MhCerjJsjKMXAqQlDTV6tK4g0yjkSHM8bfCiSez8UJgQpYt2KDOXbt5PJpkhyit9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+p7V2AnY0jKffHN6uzRiEy7JIzcLtyxx0q9d4Y0bAU=;
 b=bPiTOSXQ3HjIrP9KBI7I9hYtRBpS5L0JAqznjPSPXSfNHuiu2d7xCi2mRjGIg7hnta+UEEPJ03uTH1frEg0aK5aVPoJPJs2yFoEHXej+BD23Mw+qzn93GbrTXjP0HiBHWNL1aDKcylQ5DeaaHegONpAEEwMMzBqVDdiHrO+yHVDxih1Kn2kBURViV/YAOpBuaVzUVycXbDsOBfRPY4fp7Wy3oCf6MPVAVFi5scT09+5nqpuQRtECeA4KVf7ptXGDAqL23BQtkcsXpxScttRKsXmarvvGQr0adYgY7v6fXp+WyQFiCZbL8jcihr65DCCA1hx1/jvRovjaQaJK08R42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+p7V2AnY0jKffHN6uzRiEy7JIzcLtyxx0q9d4Y0bAU=;
 b=Smo8f8/xxVkR1VG7l2WdDUPPo1YsRgi0EcGk94Kw2sNiM4FTBTLw0rNca7HsUZ3mTSm4tUP7l9KHAu87G3OR6N6W/zzFGIFH3uZojQ8dxE4JHbE3N6oHmfljeM1CTaSVhpSoyfN04emt7Z+dHN/rO8+CqHo3XpGqOWxNHQQ/dZU=
Received: from MW4PR03CA0215.namprd03.prod.outlook.com (2603:10b6:303:b9::10)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 15:47:17 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::7b) by MW4PR03CA0215.outlook.office365.com
 (2603:10b6:303:b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:47:16 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:47:01 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/33] drm/amd/display: call remove_stream_from_ctx from
 res_pool funcs
Date: Fri, 3 Mar 2023 10:40:00 -0500
Message-ID: <20230303154022.2667-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: c357cc61-7536-49a4-4f44-08db1bfe90ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgITI76JNycNw4eUoDRm5CbNdeJaUSVfAc6ZqZx2EfWBXBz1v8c0rPqGjv7JaKDKJ0IWlL0Yw4LMvXVLZ95hDEj1nSHxDjUzMFXaXLKYIU2WKeZfdWOfEm9XgYvEBuUnf5go9aTw8iXICdNu+wn5/cT43z3VDRwl0ZckmlEA9VLFKrtXjmBfN1OVEZyVmyb+FpFeB1dfrai/o+51Q3pHPHyc8Y6HYqow933zMcI66vt0abu6ioSK5Xxnkg8o6eYM10zHa0x+ffDgUyRRRriVby2aoQhXxNoeOXjDajSOG1FFbGSfmVp4dtzp6/d4V1fURf3uzrOmgXAxWvEnKsECqG+nUKIFCYG9XXn+6OQfDjL/Mtdam6zvoPJNbRZ6uNlHwvIb9CWFGJHkl+fltP0+TJxdvNh1FkaVmdFIw0odmIE1JK+jL2oMQTS5yHY4qVyonOX1YzEhigLvTqZwy8STWeW0I26KyYidSc/cTupWtu+7K6DqmdZmf6S4AsbnEq97JjwuQs5oF6RMzCb1sobo6S+12CviFTGRWDP7eoODC8KWrnquUUc6IZtECyNKopKyZke42mCYLvI6i1mXccVI+JM35cPaMuBELUptulj12fjYD2VpatSVqgZTfQtxxwYj0YNH/SaKsBph3XkJHlgn1IVE6MIEhzq15kZUTsZMGBlbt7lprEpZuaPTDoTDm02JL/Z7Fhy41vEXCRNt88kKaKzgcqHAthIYwyHx03Pu5dg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(336012)(426003)(478600001)(47076005)(70206006)(70586007)(2616005)(1076003)(4326008)(6916009)(8676002)(41300700001)(36860700001)(8936002)(16526019)(5660300002)(26005)(186003)(82740400003)(44832011)(2906002)(81166007)(356005)(86362001)(83380400001)(316002)(54906003)(36756003)(40480700001)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:47:16.8296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c357cc61-7536-49a4-4f44-08db1bfe90ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
DM should never use a non-interface function to call into
DC. The original code is incorrect on ASICs that don't
use DCN20's remove_stream_from_ctx function.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1579c2839ce3..248f25943748 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1153,6 +1153,7 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 	bool computed_streams[MAX_PIPES];
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_dp_mst_topology_mgr *mst_mgr;
+	struct resource_pool *res_pool;
 	int link_vars_start_index = 0;
 	int ret = 0;
 
@@ -1161,6 +1162,7 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 	for (i = 0; i < dc_state->stream_count; i++) {
 		stream = dc_state->streams[i];
+		res_pool = stream->ctx->dc->res_pool;
 
 		if (stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
 			continue;
@@ -1176,7 +1178,8 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		if (computed_streams[i])
 			continue;
 
-		if (dcn20_remove_stream_from_ctx(stream->ctx->dc, dc_state, stream) != DC_OK)
+		if (!res_pool->funcs->remove_stream_from_ctx ||
+		    res_pool->funcs->remove_stream_from_ctx(stream->ctx->dc, dc_state, stream) != DC_OK)
 			return -EINVAL;
 
 		if (!is_dsc_need_re_compute(state, dc_state, stream->link))
@@ -1214,6 +1217,7 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 	bool computed_streams[MAX_PIPES];
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_dp_mst_topology_mgr *mst_mgr;
+	struct resource_pool *res_pool;
 	int link_vars_start_index = 0;
 	int ret = 0;
 
@@ -1222,6 +1226,7 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 	for (i = 0; i < dc_state->stream_count; i++) {
 		stream = dc_state->streams[i];
+		res_pool = stream->ctx->dc->res_pool;
 
 		if (stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
 			continue;
-- 
2.34.1

