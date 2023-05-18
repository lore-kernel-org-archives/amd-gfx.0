Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAD3C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 16:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD8710E103;
	Thu, 18 May 2023 16:53:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC9E10E103
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 16:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjX9d2G2xC2Mdi14rv7DpZLwM3e192/unXKBEgTgNV6SEcf9vWyfO5m2CuHhOtTuDoG8+4ScJkuYbXGBsnoxfwcLlaXTYCQjGfuJD8xoVpwfk0F/TgC1mjerNFs7VBGjqNyfURke10vJgRj2PrD+6L9w0fRzmlok+9dtVPz3lj8xRyRu3/e4oGaTGlZVR7i9w7VnQ4xIiHY9oA1zBaVxWseAnM0EfLqeU9Tp5IElnG3epNY6tdMbQ8PWWfKPryUIV6F5J/+fXtcs6xwTt5kwCKQLnjTkr/SJ1FtzRo0HNOowjz7DB7Zit2LhYnZiIbRfmnrSeVrFpM+dTJMXn/IbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWBOzkyEVp77PqyYa8AcO9SOENg9TIeQguUk/hnsujY=;
 b=Tl3Xgz3RgXz9fRc+GgP/UQEA0LfbMADpsS9XBRhEml9AtJgqUck71n9shEeU/baQAWbYJm3jehw2VFIMB3W/uAArPOZss7KMCQs9/z6r5a/6PW0Tktb8I4eAajVlwFQW8QeqyElqe5q66/EsGXkd96y+ft/OxbZ8HsBzj1XDnbu3xR4/uNmEgR6XMT3bsDVsxPGxS/5fCqrz+rF8cW/UIoOYm2+y5Pgw/RUkCBpcuA9LTyEtLs3tskClmLENeVD1NtLOGBwFtt2CGxCpAKneKa/yTnI5aORN/5GwddzKoY8HTr/zfuMPaiM+jZhokM4sOOXgves/5QXrGW6S4jGHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWBOzkyEVp77PqyYa8AcO9SOENg9TIeQguUk/hnsujY=;
 b=1vtQ/TCeNL/Du5dw9JcaZsd2HSv0YYtcVTGbqkFP/p11piJYMEAb2H97GNhT6r477IVOXv0tp33LaLPUawkZB8xJ690zmsApVqcNslrygeMxjja8ZT0CXWAVYgujGNg62CIP2G5lYYUupTgKtQ3swH415nRfkd0VgYaGrlF2phw=
Received: from BYAPR02CA0011.namprd02.prod.outlook.com (2603:10b6:a02:ee::24)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Thu, 18 May
 2023 16:53:12 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:ee:cafe::b3) by BYAPR02CA0011.outlook.office365.com
 (2603:10b6:a02:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 16:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Thu, 18 May 2023 16:53:11 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 11:53:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
Date: Thu, 18 May 2023 11:52:51 -0500
Message-ID: <20230518165251.93229-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae85c69-19a1-42f9-adce-08db57c05dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpGqxwLRuyKA1V1VqVgAaVczFOMeljyLuf6myDS1S2Y3iZSR2voh5F7+x9GNxtQgvdrJKIUrvwKUP3zWg0DIwO0+avTuvy2my4vQnYGwwtuq8FB7ToOgndydY78QGzG7qpm2/cxASqvQCKV4SYNNMvB+xkiDwkLk4pHEJIUCQRd43wsSUA2BLfq/DA3m6at1jKFuvX1QYEQaJFLFxIzJAJf8UW434KetLmRZfm1LGtWLPiFvL/THTBlOkj8a8dk1NLZIG/Z7dGJ5SpJc5q6499DhAB559ppkAUwKVOYKQLQOpSbGfnsc9Ei3LX3VpToQSnZNbSiNGduWfqqJIvoXsiEUUkAURmSNYNA5e9H327cEK9wA00Nb+RiCot8K7Ajine/OqyppozPS5WUiu9+5oWrr2576Wrk0ZyjAM2xRRZxuh/ifwiyZMZIJmLqoVfGxukjXR159/5/02901XGYa6uYnf2e5KZMvwbSiyYLTcaM2Lzl2r4B/KnspL756qfLftZ8uVF8WZC85170SeVhG9uRzlcmxJDhDvY6/nVTxvqgEYjEcFUqj1rZZ9RewFXJn3/M8RQjtNOf29K7CEIVw+lPHvfmfX10bit6THLTkb9DMketBvj9+RwkTuyC2DMpiOQd81lfJPI3TbUrh6mHF3oG25+ghcDXZDHWnMiJojcFVLeN9HDWNjWjzDBvidCxcvdE6x59MoAy5RVo+zxqihJReCxt6iAOu8VMfRe9cJeGpX7P6nHf9ITEgOVB2WIPQ/glhlRaMuTD7TzqgO1sX5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(478600001)(4326008)(40460700003)(54906003)(44832011)(86362001)(316002)(5660300002)(82310400005)(36756003)(15650500001)(8936002)(82740400003)(2906002)(40480700001)(81166007)(6916009)(70206006)(70586007)(356005)(1076003)(41300700001)(2616005)(186003)(16526019)(26005)(83380400001)(7696005)(6666004)(47076005)(336012)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 16:53:11.9301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae85c69-19a1-42f9-adce-08db57c05dab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DCN 3.1.4 is reported to hang on s2idle entry if graphics activity
is happening during entry.  This is because GFXOFF was scheduled as
delayed but RLC gets disabled in s2idle entry sequence which will
hang GFX IP if not already in GFXOFF.

To help this problem, flush any delayed work for GFXOFF early in
s2idle entry sequence to ensure that it's off when RLC is changed.

commit 3964b0c2e843 ("drm/amdgpu: complete gfxoff allow signal during
suspend without delay") modified power gating flow so that if called
in s0ix that it ensured that GFXOFF wasn't put in work queue but
instead processed immediately.

This is dead code due to commit 5d70a549d00d ("drm/amdgpu: skip
CG/PG for gfx during S0ix") because GFXOFF will now not be explicitly
called as part of the suspend entry code.  Remove that dead code.

Cc: stable@vger.kernel.org # 6.1+
Suggested-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Drop patches 2-4
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a9d9bbe8586b..059139f1f973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4316,6 +4316,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
+	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	amdgpu_ras_suspend(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f2d0b1d55d77..b1190eb0e9c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -692,15 +692,8 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
-			/* If going to s2idle, no need to wait */
-			if (adev->in_s0ix) {
-				if (!amdgpu_dpm_set_powergating_by_smu(adev,
-						AMD_IP_BLOCK_TYPE_GFX, true))
-					adev->gfx.gfx_off_state = true;
-			} else {
-				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
-			}
 		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
-- 
2.34.1

