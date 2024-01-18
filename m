Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EBBC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CC310E826;
	Thu, 18 Jan 2024 14:34:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA10C10E82E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBDlVLJw53Wa9oSLwp1ieC+oJWTJ85h8UksgSUNjP172ACig4dqhLBEMRJqdCpYyKma6FQRYZol0f8pHCwycdfxqubrqnDkGuVnk9TvEhNVsaQw8hVG1F1VyZBeS+GCqONU6JhI2+cXuBf/g9eByq4KNPayBp1qsTIwFUbHjF44eXlRtEzqCWrORLZ7lHxI4i4RRWovYL9ai+CoWDjktrH4kyRvAsMrd4Xl9uwlWsZ0Xqoq4qda4MwqP8E2egaiyu721RK3cj9ev9eRf/E7mqIDS7WhWxbkkp3Gy/XDuK9xlX681OmdwKAUJlHsynwy1sU1qK5/6EPsARvo1Ia8QBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3zbWHu7RVrrFhoJFGNfQiHHIhiou0m205NoOcUPAQM=;
 b=dAT/SWKLcOc6Y+u3H1Bb/i7HKdwJsZge+ryy0WtVoTA8oDLSqeg1fEzyXH6602ctGz7PHSmbmmggjjOoK1laWVFR5PQS65Y/zORNg/iAowDtZE5ZnYxeS8ZB7SV4ykwwS+Ew4UF9ENrLPBtP0RtQNn9nxybfgop4+6JiEDdXA+3BAlQRKDDZsc0OIcqNLsoHh01qszOx/KGYqYqFsjMgF4vDmFJXsBkqCXNu5rJYmZeLh+0O19OP/o/OXzEPniuENkjnR/UJRQy0YBXXw9Hs90LzCCKvAXW4qYPU9N7PKQ4GTOwGb1fZPTvUltkJUdAhr4GADab6+x+nxUdFd01pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3zbWHu7RVrrFhoJFGNfQiHHIhiou0m205NoOcUPAQM=;
 b=apS5yIwEX7Vc7ROYre8WAJccXg2+3XK7jpFq+A+IDybhJB1Uj8Rd4Epuf7GjNmF1sYYzef1jh9GAT3UlFUg2G6/YqxJP5rKksPV8W5k0tjVq1S1PuI1jb39XiwD/QpAkqoECcHTJ8QCTs716Elu/lxcy5DjTVRRiPlHpdGhoBbU=
Received: from PH0PR07CA0091.namprd07.prod.outlook.com (2603:10b6:510:4::6) by
 PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Thu, 18 Jan 2024 14:34:49 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::a5) by PH0PR07CA0091.outlook.office365.com
 (2603:10b6:510:4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:41 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:41 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: Add IPS checks before dcn register
 access
Date: Thu, 18 Jan 2024 09:33:53 -0500
Message-ID: <20240118143400.1001088-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: d215500f-6f71-49df-5d05-08dc18329ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvbXH1f+Csix1KfRIr869bAd/uQtmFbUmx4SzK6vokoklCnMrryxAQXaRljcnHqFOfz/fl1cTtXTJE18ZnN+OO7qmXNGK0P8HgTzVAQbOP3uwo3jyDRrQqy+1fmWEWEXyb/NA5KHcnLiBNeSO//8Fdo7Q4EnU0cPWz/ogSTn0ccxR35K/HuBHJvl6j8wCApYYpj9T0UQCG1zzsSaF4/h8lp1KbyVvUkW0I6c0v4Ery7hgVKwU3jxizpyGnp9IT0KNePbllVfEzs0hwztpPTOTTV+bHhONLHVGE9QXGehvF+CBsTZYekRhDz9knWfmg6Ji6G5yzk17jPjAeRxaFdXIxxJ8LBtCBg8ZUy5YBe5dxRfxgGatBRiXhVIRjdaSBWWG+P6i+5jOoGCE2lN1FXJ0F2vHcN2TDwwBdLbc5Le+Ma+hM6TkDB1WvEZBMAJYosjIpNShKQQMZYqwP7Ts1Im6OJmdwsvV73JjfVlzFNcOJYLnL/oxwBZj4eqeOfS4AweVi2ejLfKLZHJGx7q6W8reEbLTXXFaEn9MXL6T5dlfR4aKQWvMW/tVv+AtRKB3SV+EWQEK9supcl8WipdRdTsVG8uanZPIVZvfI1ddstEuudAZ6YUnpWE9hJl1PfMCfiMp7h59yLrBTG8hGXBbDHZr9AoqejvLm5f8UmlJ/4d+BJT0ZOFnrlpUvdv/xXq5HsTpgHtfC6de1lmndLdhLeXD9MkW+Mrbdry0oXtz3BHI96Pt6kwQHO5fMHqwWKGKmjkZMYNaRkBXmXai25AylQ/7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(336012)(82740400003)(81166007)(36860700001)(2906002)(41300700001)(36756003)(86362001)(7696005)(356005)(2876002)(47076005)(54906003)(70206006)(8936002)(70586007)(316002)(8676002)(6666004)(6916009)(83380400001)(478600001)(5660300002)(4326008)(1076003)(2616005)(26005)(426003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:49.0166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d215500f-6f71-49df-5d05-08dc18329ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
With IPS enabled a system hangs once PSR is active.
PSR active triggers transition to IPS2 state.
While in IPS2 an access to dcn registers results in hard hang.
Existing check doesn't cover for PSR sequence.

[How]
Safeguard register access by disabling idle optimization in atomic commit
and crtc scanout. It will be re-enabled on next vblank.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f9e41006ac87..a9a57ba2b256 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -272,6 +272,7 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 {
 	u32 v_blank_start, v_blank_end, h_position, v_position;
 	struct amdgpu_crtc *acrtc = NULL;
+	struct dc *dc = adev->dm.dc;
 
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
@@ -284,6 +285,9 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 		return 0;
 	}
 
+	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
+		dc_allow_idle_optimizations(dc, false);
+
 	/*
 	 * TODO rework base driver to use values directly.
 	 * for now parse it back into reg-format
@@ -9010,16 +9014,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	trace_amdgpu_dm_atomic_commit_tail_begin(state);
 
-	if (dm->dc->caps.ips_support) {
-		for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
-			if (new_con_state->crtc &&
-				new_con_state->crtc->state->active &&
-				drm_atomic_crtc_needs_modeset(new_con_state->crtc->state)) {
-				dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
-				break;
-			}
-		}
-	}
+	if (dm->dc->caps.ips_support && dm->dc->idle_optimizations_allowed)
+		dc_allow_idle_optimizations(dm->dc, false);
 
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 	drm_dp_mst_atomic_wait_for_dependencies(state);
-- 
2.34.1

