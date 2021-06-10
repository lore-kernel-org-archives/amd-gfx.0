Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09897C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 12:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EC8613F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 12:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EC8613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686EE6E062;
	Thu, 10 Jun 2021 12:48:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DCA6E062
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 12:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR9ailfH3MqG71OtTYv6UcQQWfmTr1bqpKGSLIpdizZ6oQ+X7QwM8mXvcn6ZdOZwBluAcT697J3CXook1T3Sh2BPi8z2tXrwmElYSJ1WgTaoPrTgpPibBJkqCRhtC6zubn+K4s/Km99jsrt1iU+o44QptqHpeIWX5uv15p7YhpoNpjeOehGnZRRigDAeMNBW1mdKTI+l/lV+8Iqf9FpLCQ2iKm+HXbhuu1IWrC2SWSFseq+dkZ4vlL5kzZ6dX81GcwNwyEA/7Oxo7Prb6UE2DUaZYKiXvTl7YO2aixD5NPMGjoOFu0jR8dqAASkNcJxAQT/Y0e76EzDqfoTbNRcZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXVXWXBulTbKfBmFYp2XFX8GK2E0YkiNryYkr/pdBcE=;
 b=a9vTP8KkXRjzp6bpJd8FEfOT7wbDrSaIgKkd7LcnMiYTuC1pkhCWA7HCfhAMkG4rgry4kK9EYTSj2ONK3mKlc7o0c4YHml3TkQ4hM5nvEvi9NQEqJm7AXq09YZcyZnH1B+XK5ItwsbPW6OZNwu3kUL6YU7kz9SWhoU5DYqFApAIXsXls8GmTmc8ktNxgdefRnDrT0iRazkdvEwNVPsbTNG9nWGOZzOrvbFBPhpCJjItWSesFVsplHZO7EQXNUvzpNMw7nCzsygdxkdAaU3bOVs4eOmSPBokiJGDg6SKGyFme1unDeck+pYAfBODwi2jYnldTaN7scK/cPW+65feS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXVXWXBulTbKfBmFYp2XFX8GK2E0YkiNryYkr/pdBcE=;
 b=EfmiTj7L3lsivwnYKqBnat2pQOgYoXk3jdLGxseLj9IwQ5iXqEg1n2U+fVIK0a66JCykYwdRQvErrosZ1vALRRqzkeGPrhBL03bkfAVmB4x3J3giXu9NOZNLGRnz6UR/wI1uaDoycD/ov+EK+h65aMgHzKXDSC7Q49vSWGsJKLY=
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 MWHPR12MB1407.namprd12.prod.outlook.com (2603:10b6:300:15::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Thu, 10 Jun 2021 12:48:29 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::b) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 12:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 12:48:29 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 07:48:28 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Sean Paul <seanpaul@chromium.org>
Subject: [PATCH] drm/amd/display: Add Freesync video documentation
Date: Thu, 10 Jun 2021 08:48:18 -0400
Message-ID: <20210610124818.216221-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 328c061f-6b23-4fe6-db8c-08d92c0e0c47
X-MS-TrafficTypeDiagnostic: MWHPR12MB1407:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14078BED5DAAEE70394084FD98359@MWHPR12MB1407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYD2+ELfxaXN+WqGGsRMpbzIKy1MZhepwszNXP/GAvgz6+CTTf/FXh+bI6uIBVNkKoCTVuA6o9Zv7A8/+Sgu4QU0LRpi4oNHqw1sSLaWLyrMhNzk75gSsEh3Jdpn4wlf06N4LyeoD8S4xeOk4pWdF8XJAVHCSd55n2OC/ZdMR5QQT6Ba+5ju5g4Pj/XyYB/KL4VhQbs7rFvIh0QXh5O9U892+kfPbcM3Xp1qbSTRSfIfFz47FCgSs7DstqXFs3lvcm+fSv+tTx7d/XKkArhZneDhhWN7GqbySEEkd8hcCR+jOi0eZeTts9PRDZixHy1MCv0N46UdauUh7KiHsS2AOO0iKcjC09NaB3Xn6BGbQxE86fmtuvD8B0B8WAVmbo4FglYLtq/ucr+VkPYRdq2kTsd7FbPM3YtH5dVFDGFyLdAwQOFdQ3KfPHlpQnNfl1FlFqW9xyOzbJ8hlrvLrwIF2MS107BMUfVpFMas5xKJHdjmr/8R+j54aINBghR0hPPgqJM7VLrHfK+QoKJnISHw870b3HUm1OkNlTJpxlRqlRzMKxhTS9lLtliap+nViLfK7+/lqLDjhjuAXgdEh3h3a9znmR2OXGA3itqsWUuDLZMTGNgnyooysAkNKNKr38guTJJpsN+NslOSKFxUfvEZs/0lGhGDus8zKo3k6sbUN7vcv/6T4D0JKt0KGzm6F9PT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(186003)(336012)(316002)(2616005)(16526019)(82310400003)(6666004)(47076005)(70586007)(478600001)(1076003)(6916009)(83380400001)(426003)(26005)(2906002)(356005)(86362001)(70206006)(36756003)(8936002)(4326008)(5660300002)(36860700001)(54906003)(82740400003)(8676002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 12:48:29.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328c061f-6b23-4fe6-db8c-08d92c0e0c47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1407
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recently, we added support for an experimental feature named Freesync
video; for more details on that, refer to:

commit a372f4abecb1 ("drm/amd/display: Skip modeset for front porch change")
commit 952bc47fb2ca ("drm/amd/display: Add freesync video modes based on preferred modes")
commit d03ee581eee6 ("drm/amd/display: Add module parameter for freesync video mode")

Nevertheless, we did not document it in detail in our driver. This
commit introduces a kernel-doc and expands the module parameter
description.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu-dc.rst               |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 17 +++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++++++++++++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu-dc.rst b/Documentation/gpu/amdgpu-dc.rst
index cc89b0fc11df..f7ff7e1309de 100644
--- a/Documentation/gpu/amdgpu-dc.rst
+++ b/Documentation/gpu/amdgpu-dc.rst
@@ -66,3 +66,9 @@ Display Core
 ============
 
 **WIP**
+
+FreeSync Video
+--------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+   :doc: FreeSync Video
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3de1accb060e..561c7ead4a5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -836,8 +836,21 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 
 /**
  * DOC: freesync_video (uint)
- * Enabled the optimization to adjust front porch timing to achieve seamless mode change experience
- * when setting a freesync supported mode for which full modeset is not needed.
+ * Enable the optimization to adjust front porch timing to achieve seamless
+ * mode change experience when setting a freesync supported mode for which full
+ * modeset is not needed.
+ *
+ * The Display core will add a set of modes derived from the base FreeSync
+ * video mode into the corresponding connector's mode list based on commonly
+ * used refresh rates and VRR range of the connected display, when users enable
+ * this feature. From the userspace perspective, they can see a seamless mode
+ * change experience when the change between different refresh rates under the
+ * same resolution. Additionally, userspace applications such as Video playback
+ * can read this modeset list and change the refresh rate based on the video
+ * frame rate.
+ *
+ * Note: This is an experimental feature.
+ *
  * The default value: 0 (off).
  */
 MODULE_PARM_DESC(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 54dfa245b656..710ee3954062 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5718,6 +5718,36 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 }
 #endif
 
+/**
+ * DOC: FreeSync Video
+ *
+ * When a userspace application wants to play a video, the content follows a
+ * standard format definition that usually specifies the FPS for that format.
+ * The below list illustrates some video format and the expected FPS,
+ * respectively:
+ *
+ * - TV/NTSC (23.976 FPS)
+ * - Cinema (24 FPS)
+ * - TV/PAL (25 FPS)
+ * - TV/NTSC (29.97 FPS)
+ * - TV/NTSC (30 FPS)
+ * - Cinema HFR (48 FPS)
+ * - TV/PAL (50 FPS)
+ * - Commonly used (60 FPS)
+ * - Multiples of 24 (48,72,96 FPS)
+ *
+ * The list of standards video format is not huge and can be added to the
+ * connector modeset list beforehand. With that, userspace can leverage
+ * FreeSync to extends the front porch in order to attain the target refresh
+ * rate. Such a switch will happen seamlessly, without screen blanking or
+ * reprogramming of the output in any other way. If the userspace requests a
+ * modesetting change compatible with FreeSync modes that only differ in the
+ * refresh rate, DC will skip the full update and avoid blink during the
+ * transition. For example, the video player can change the modesetting from
+ * 60Hz to 30Hz for playing TV/NTSC content when it goes full screen without
+ * causing any display blink. This same concept can be applied to a mode
+ * setting change.
+ */
 static struct drm_display_mode *
 get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 			  bool use_probed_modes)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
