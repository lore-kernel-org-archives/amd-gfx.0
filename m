Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD89ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBCB10E858;
	Wed, 14 Sep 2022 05:21:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5178610E858
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogfX0WfxRdJV2MzTdaF4J2xJpgF8fNyiNKLkL8ebZiiV7FqKVkLAe7C8vMO4j+D5f9eclJYK0hKrI+vkapGuxKtfgJM9hSKSREXoE/77CE/AGP62dboViGl01TVHBQQGCljNlqdTRiPKW6oOFEuA1v/I3fccdZrW/ElF3lI1Y0601xXbGO9lG7QL+0n4CyZyUCwU24RVfXcP07b7eTVkl39ffwgQPV5oCjPd5YT9nOtR82aKNboTgrhj5Z8cXU/BUcl5AuFfL25Kx4N6NcK5WbCbEHcOxNK+oa1N73TQbZ1Tub94yLIbcRq51poeL9VI24i0NqeA1nJIcmykgHpTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnVBWhHYoaV9prpRhNpjkAg6ZDHPSPCw0hEqgl/W2p8=;
 b=nYlTFiSdrWreKpsrppBb3UK7YXg3UtQWNWYI6k1KqlsDBEHmEtS8yFioRNu+Qbd/4CRSEG+m5a7DkOqlvF2dz/neuHQKFoVD/ualIiw+5oXGptdkXBClDCtF2kouev7oRcnegjkYpXa2eRRUjH/t6cFs8y/d7LnnVCvjN6dvNDiR6t2zfEcFl/0w88vFdAVBX19zum00M/kipbIMJ7AU/7ERotZeCY+paPxWXBcYCh0sXh6rPxcp53+PCBciiiZ1+1gmM7q/lTKsjjQ1ZU4t7/2fQ3WKQkwHbun4B5iSXNYA/nUxUKQElHuie5/2IGPgjxrcbCKbywZQMYAOJnnVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnVBWhHYoaV9prpRhNpjkAg6ZDHPSPCw0hEqgl/W2p8=;
 b=QTppCU4/vLFh6tWqwB8611WDZt3DbNIqZn4AT6fe1SKxnJEFSJAY/OVw3bUx3SFnD+Im2XuJKT8D0TM51nMWGQSQWWT+sCC/iiLLCEu5JKrWcjGvUnyU1VDn2SXfgVKp+DR5y92+R8glZXIOrQqwBygX+kPFEWB6UwBX0GRxU3E=
Received: from MW3PR06CA0009.namprd06.prod.outlook.com (2603:10b6:303:2a::14)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 05:21:13 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::aa) by MW3PR06CA0009.outlook.office365.com
 (2603:10b6:303:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:21:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:20:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:19:19 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:19:14 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 46/47] drm/amd/display: Fix failures of disabling primary
 plans
Date: Wed, 14 Sep 2022 13:10:45 +0800
Message-ID: <20220914051046.1131186-47-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b28591d-6b91-47df-5a5e-08da9610f09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fu2MGkyQBLMwQ10q9P8Js9eaHhBUTOSkCeyGBsVIaAi5OwSMN9t7o8KVSHlyFd3hsGfrFKIHZEF2jXlEtRCuHGCKV46MlyaedENN3KsE8zKLvn+kst53URV497CNXSA4Hd4Vg5DwOClhhXOlYtDOx4HIpU2VfX4oSMBp7QzH7nAf0rZPVZvnjFD1K2kBsdpVbuM1EDhqzQcRqS+jkCjlW0BTbcuYJ+V21soSbUWRrffKW2p9PPg/ZTzSdujW1sxw5xzfsvgkW0wi63FZcKVT6+A6sPnDaGfo0mMrf26oZYj/ukIi9/zZDpxK4SJ/OWBOPIl6XKX85yJ92exMprzOMDSKtawXLm0SOML7sJn1acaSSemQoinvVVHlRTbPPEFGrlLFFDCx1S7E/gBXPhCA95wkSUDBjZ5Fz5nzAQEItIzA8X0r/q1y0D59UjO0d/NwK57nh2fS7WyhsTHlBMUD2KewAmykv0RZfUAlqzfT2kYWZ/OKOUsR4mDRw80z3vvCipGVVOnYD8B0L5IZFdOUR8rh6SFEuX4gjeL8qMtVrApKvn8oH1/Wr+0WvBlqVs9HsRIv/vx3WlRVBZ+rcko278BDUcGparA4NYKw8mkKfvSvBgplyoOEgY6qABJ9FaZ7v0K8kYnwBKp0gb8ivRblhpLLOR7LXoTtNJfGRsl8sONZCnmCBeQz+r6So9t82BokTdN42dizseEwEl9hUUuGWzFtkHfHwu9S4L3EG4wev1j8nUKwGJGRa9aTuQ1ag1GfneFhfszwc2idsu8Cf2viqnhJl0FI+LqADaUgSFneo75hn+IvCT1ddmbzMCSHKkuE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(7696005)(83380400001)(82740400003)(316002)(47076005)(426003)(4326008)(36756003)(81166007)(5660300002)(26005)(70206006)(8676002)(70586007)(356005)(86362001)(41300700001)(6916009)(2906002)(1076003)(6666004)(336012)(40460700003)(478600001)(40480700001)(2616005)(186003)(36860700001)(54906003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:21:12.5024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b28591d-6b91-47df-5a5e-08da9610f09e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why & How]
This fixes kernel errors when IGT disables primary planes during the
tests kms_universal_plane::functional_test_pipe/pageflip_test_pipe.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c   | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index c89594f3a5cb..099a226407a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -376,18 +376,6 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 		return ret;
 	}
 
-	/*
-	 * We require the primary plane to be enabled whenever the CRTC is, otherwise
-	 * drm_mode_cursor_universal may end up trying to enable the cursor plane while all other
-	 * planes are disabled, which is not supported by the hardware. And there is legacy
-	 * userspace which stops using the HW cursor altogether in response to the resulting EINVAL.
-	 */
-	if (crtc_state->enable &&
-		!(crtc_state->plane_mask & drm_plane_mask(crtc->primary))) {
-		DRM_DEBUG_ATOMIC("Can't enable a CRTC without enabling the primary plane\n");
-		return -EINVAL;
-	}
-
 	/* In some use cases, like reset, no stream is attached */
 	if (!dm_crtc_state->stream)
 		return 0;
-- 
2.37.3

