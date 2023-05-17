Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7029BC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2029610E1A4;
	Wed, 17 May 2023 16:13:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C942010E1A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJZ/ACm92ElAtB99TPXdWXNLmI+cCQ/fBT120TcmOPGr8hoZCE80a0Y2BgzP6axAFb1h7+yUwLbCjA2dKLMYNxdZDuR8EZRiVUeMYoA9dqaNok53W+39ND2iGlIUqQZckmNxMcu39DtrURAmtVIGBrIMPX/CsFAMeORc0IVUwtwqvyj2FtcmqyJlkzTTxY00uCySL1vSZszziXzzD4/jVgV7Vp7+RzYFVWqPXNw5CGdmYyGRo6rFi/hche5XOjjCXsVtodjo7wNixuSN/AikTV5xVkUJLR27qtvwzqejAMe7eDGp3SdUHPKDpDWYZ+oJgKHslMbY8Q/mX85K1f+BeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFcGRb5GzL7mfO1J5V3ELFul0Phsb4/h8syzC1bszQo=;
 b=CHMo9Xw33E0Q8/qJ5w03hDQxrlWMIxeYj6ua0zLBnI6ROI6+fzOHBTHmj4ThK5Jwh2ypajTjGayuI3fvrl+E/8BPNxJidw81NmYg3/poQzBlewtgsMQuuqZ5QNZ4w4PFmg9h7yu+x6gV9pWxa2Sog+WqML3Z9zkPTAH9zKF/1suYrFdbcfs9L2fUptT/cClYQnAL326uFNEXKsFj1B5wdRrGHpUV6ZH2tSP9yKK5AcgRN7Rtjcj/BX1EOr/+3iayxwY10CPpjOt0LoGFtDvPtYzTJF+Zg23daXArkwcB4NZA7hr83EwIqm3e7UmqJxcerRAcZp6zorKqD5wNKsdK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFcGRb5GzL7mfO1J5V3ELFul0Phsb4/h8syzC1bszQo=;
 b=y6lBMs+Uv/Fh3u0xOMnBBh0Je5ohRc2F9VR4kAr4NJnsa4uKjzbv/KrqyNA8Sbe4/ydZvyyk4XvUm+LtzjuVFT/cYnUMzdAuzNUb+SjFdwdORAR4DqlvHHfBgMU0v0HCso383oH17QMVquzO5wg0fZmtSxc4GnkGpQgt0/UbuVY=
Received: from MW2PR16CA0072.namprd16.prod.outlook.com (2603:10b6:907:1::49)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 16:13:47 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::df) by MW2PR16CA0072.outlook.office365.com
 (2603:10b6:907:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 16:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 16:13:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:13:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/4] drm/amd: Flush any delayed gfxoff on suspend entry
Date: Wed, 17 May 2023 01:08:17 -0500
Message-ID: <20230517060820.5499-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517060820.5499-1-mario.limonciello@amd.com>
References: <20230517060820.5499-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab66199-9677-4aaa-8466-08db56f1b1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vj5+yfoBJlgR7Tw/ChEgMhyjPgiDxSq9kLFhNNn0phubgik8JtmR2m1mNfluTHx6I+ODFb9azzIqnIL//MkNiICAhiJ/ESj/xsFJqjLNHCugaKghMq9SIerc/GzEy1PhFRqPTCxdPD71jgXCWeB4GSTDj9rXFv7M0pNAY1p9srVhodbbBTwt8SURNodsm/6Mpa6d0T598sFCL6HtzoCdRXcRvS/Eh0xuKem+Lj24MLXspK9JaOE+Ueg0vEvYElzezfV9udlqoP82gwkvpJzlcfDWQf5UPs0lMyh4rzDjpDcGlAiRCFTKMJYD5EvKB1RtnjTLLGHBOWZialf1JfH2iuzYRY44n+gLyZJKkjr//ItQP7kSk5xIN5G1/6iy7phhzWDl/RowXj59evKiMN5yrB57N3NlkV0+ecjb302aLfyRgR1Z4zOgfPMjp3OGVFeFOqFoF38IT+KgJcNQMJigwCYFzpZP9QxEvGARrY2a0Do2IpYn/dzfimhrVSlB6KxrGnEg7OeKpOhC3LziAcXx/zVblH3UTCtSmX7x1unZ5bZREvhzxKrX7Pi52FYixVV3v/wxq9kxef+uE60qnkR/D2jWsvvcoR2MEEU5ZME0/paqiDB7aLR6NhBjuLI7ZyGfJpIT8VYzZtqEemvr1v2cYB1k9U0oRNYfFFRTbPiemcFSaSSLkeT/3Yin8m+oe3+Port80SxUN9E/ZKEre8JQEWsxIuIPyd89r13GI9iJ6mh+d/tDUjeQ8xmF6aEJnlZNUHMdw/LaoZ4SHHyY3HKyZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(44832011)(36860700001)(5660300002)(83380400001)(15650500001)(41300700001)(8936002)(8676002)(82310400005)(336012)(426003)(316002)(81166007)(70206006)(356005)(6916009)(36756003)(70586007)(82740400003)(2616005)(4326008)(54906003)(16526019)(186003)(26005)(1076003)(478600001)(86362001)(47076005)(40480700001)(6666004)(40460700003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:13:46.9540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab66199-9677-4aaa-8466-08db56f1b1ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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
index 8883d5ee13cb..c31c2d3b5bf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -688,15 +688,8 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
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

