Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4C3C19F2B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 21:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A679C73CF;
	Wed, 27 Jul 2022 21:03:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A29FC73DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 21:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAIVrCTXJThgvlPsv/3GytIE757omA9MkYMvYkMN1hZjuF+zJ4/Zmdsq7yu5F8zwkAzR2P/2njpS/2jhYhCay8CW7JbNEfl/pn/rgvWr0IrM0G8WJ9sdU5MEovngPw8Z4/H+oyLgHZ1Cuwn/mLFdbyKz/s1UPD8eWUbmUh6HrAqExVKhq/od8Op4alUUawkey2BcTNpKmnn+ZSzVxIXHtHHa+hceIxbtE1CKI+3As2ra18MgolaMS48UGNplVGjVWMOhiyZDbPU28b4rQR3bOX14e68QMmjDWh2Y3Vec9dzBc1zuKQu1j+JTGeXLOLITcmqmyRMRq/qZvRlP++v8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YABoQBFUwY1hHYgopU5qK7Z+228kdVG12LJZjjnfQ7Y=;
 b=G5m6PtZQSJvA+aGIUE8+gYFNkQ0bdZib8BeNRdHKpdfXUxpIfiS2nh1Iu/H9QpWgXLAdTJohiY156I3EaJG4/HbKUYPCvwV7jui5GXS8CqG+/Mk/Bi6QNe8tYw5KfU+jiOaNE4SoMwfv5+i2C4XNj+KJkSNUMZ/0lWmhvzL1mZfFWMDL0qQBexmDnpoQsey25lKPiC8DE55t+MehBgeHKxJmUmgpWVsyIxTBNrtET5867x2jV4LZ9p4B6uCxucMfEdUG9z66qACfmvEYCsSU9t8BvwdOiIRfDfy5ctpQ/BFQrKrPvu4Cw5lgtVw6AjWHUNsRVjPBCnTgYIPiLmcrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YABoQBFUwY1hHYgopU5qK7Z+228kdVG12LJZjjnfQ7Y=;
 b=dSjwdAuEkQZuugoImWaNIhI6BeeZE922WcEbTzaVq7PuM2flIBZ3ihe7KwrqfHWWg8y701ClIk2/8i6S7U6IdL1StzHBhPNtxTfgz3iPnhbLvH7r6N+xWhj9TE7Ac1pPa2e8FRYtu7fKy2EduIYWkaER7qXqvVbkq/njuFNlzzU=
Received: from MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::35)
 by DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 21:03:54 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::9e) by MW4P223CA0030.outlook.office365.com
 (2603:10b6:303:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 27 Jul 2022 21:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 21:03:54 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 16:03:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 14:03:51 -0700
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 27 Jul 2022 16:03:51 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix vblank refcount in vrr transition
Date: Wed, 27 Jul 2022 17:03:40 -0400
Message-ID: <20220727210340.53672-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a14788-3a67-4dd2-e6bb-08da701383ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3163:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPafunCKsiVcB6THEpF35NFchZdKZmkcaiFwJzQW+7z5rXjgkT1v8vEwIzXoNJQkUApkDE3IetJN3q0MrxeW4dL6ysg6f1Bh5tfNfGqrv2heJpaB/MjInPonh0zBk2f/8o09DXu1njxg0tYxVBL+LXY5qu3s5jDZW9wCJNcGeT2Hvoq71X5ne5dT6O8ZGuKbdNbv9aWLrUoujtpujeit1b41iljven0geI1HsNTTGMOYgS5a19RwpwwRMOvJcReoDaVDK3CvIz/iawQEaEb5lZWBWuXsXoN8v8AhAR6j5nc009cz1imVGwMxeCz6gXUyOHvzplZaGadNpnJE10oC7583ST2DNQPJki+z47EAOh+4IECiSBPC71VpAoTpxvkdaNxiYp9vfUoxd90Ub25njeDX4E9Oc2S6MnkiKCpFtdXiybg4Mrz7tyy97oD5kgbuZ/ew6R31uvkbr6UsmfC7vOD4Vj3ix1Tnq5i2T0JqsMrNjRPSFmKGiFmNDx8ZyF2JFnDk0FnCs40ZdNjC1kE7PV7AQyxlbhmJhN+mE7cReTQE/h6OK3A5GbOqXbBOuZZz4vFg0aqwmvfxfpj9S0Q9bdrFHcWYUW/tHmr5h/4VGCAsJ4zzVzaR/JMSeDj3rhYscCd+wyLFKXae5FHn7uQAk6MoRkRl5NslDbq8zDwSKrwAlDL9SxRb0BS4HHggETPUKn1hpQygP/fdWoYSAVkCjf0uOhBk5d9qcFlRM9Tnbpy/r8molpL1k+06pj+gKZGc/VM7fdM3uWby8WuuiCasw1ghH8E+ZCc1eV4ULmQtYAI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(40470700004)(36840700001)(46966006)(2616005)(336012)(1076003)(47076005)(2906002)(186003)(41300700001)(7696005)(40460700003)(426003)(6916009)(6666004)(86362001)(36860700001)(26005)(82310400005)(83380400001)(82740400003)(5660300002)(81166007)(40480700001)(8936002)(8676002)(70586007)(4326008)(70206006)(356005)(36756003)(478600001)(966005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 21:03:54.2535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a14788-3a67-4dd2-e6bb-08da701383ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3163
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
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

manage_dm_interrupts disable/enable vblank using drm_crtc_vblank_off/on
which causes drm_crtc_vblank_get in vrr_transition to fail, and later
when drm_crtc_vblank_put is called the refcount on vblank will be messed
up. Therefore move the call to after manage_dm_interrupts.

Unchecked calls to drm_crtc_vblank_get seems to be common in other
drivers as well so it may make sense to let get always succeed during
modset, see
https://lists.freedesktop.org/archives/dri-devel/2022-July/365589.html

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 ++++++++-----------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 92470a0e0262..2107b2aef076 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8252,23 +8252,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		mutex_unlock(&dm->dc_lock);
 	}
 
-	/* Count number of newly disabled CRTCs for dropping PM refs later. */
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-				      new_crtc_state, i) {
-		if (old_crtc_state->active && !new_crtc_state->active)
-			crtc_disable_count++;
-
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
-
-		/* For freesync config update on crtc state and params for irq */
-		update_stream_irq_parameters(dm, dm_new_crtc_state);
-
-		/* Handle vrr on->off / off->on transitions */
-		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state,
-						dm_new_crtc_state);
-	}
-
 	/**
 	 * Enable interrupts for CRTCs that are newly enabled or went through
 	 * a modeset. It was intentionally deferred until after the front end
@@ -8287,7 +8270,15 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		cur_crc_src = acrtc->dm_irq_params.crc_src;
 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 #endif
+		/* Count number of newly disabled CRTCs for dropping PM refs later. */
+		if (old_crtc_state->active && !new_crtc_state->active)
+			crtc_disable_count++;
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+
+		/* For freesync config update on crtc state and params for irq */
+		update_stream_irq_parameters(dm, dm_new_crtc_state);
 
 		if (new_crtc_state->active &&
 		    (!old_crtc_state->active ||
@@ -8324,6 +8315,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					DRM_DEBUG_DRIVER("Failed to configure crc source");
 #endif
 		}
+
+		/* Handle vrr on->off / off->on transitions */
+		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
 	}
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
-- 
2.37.1

