Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD4C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 18:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834B510EA9C;
	Fri, 28 Mar 2025 18:24:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DST9M5yB";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5783210EA9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 18:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp/zU/ZhW0VgOLJ/mUF1hz+sD76hR/HiN7tJ/yZCA4F9P3++nmzDJhLvkOmL/Gwq7/Rm/jt1G2PcaGsqNIGv58AEMY6drkQQ3bDnsX2RcsmKRvcbcQtr+zqHk2/4knmFagCX39Yb3TBTtzk0w1t0n64gAynbh3qGxuTaABTMobhT/p3eH8FUCPdcQd3sd2cMdj60zWjAzeb/0B78F4WVdYBmk1FzRYteIz3WAidWbC+gEB2uxFAHuF7RgVW5kxbimhBHU7CgVe78WXXYvdfuM0pA4tTaVL1Yp4znJNosQs29a3rVvjb4yHWJsh6n7JMrCiUsn0EfKYRXf3zNLHhfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlnRAbZdXAUVDbBXT8boEuxdPiK8fCkOF881JfmR44c=;
 b=G8+FoFVD59gjqMPGZ2jKWmwo1ImvCzDfSab8bjOKpUNEQWIDoru6+MUKXmCYdwEZiztbLL5dT1sQtBLEYZeIYi/vrURpSyfPC5OAkN2nEp9Vm9N2XraTfSrWzYb10XypncJRJhvidQCwtHNlMT39JCDNpNa/QuKEamPJeyQ5bWgHsYnKFqeqyiXpQq1u6QS/QKz+065ggUapDEradq6TUhXKorQbvyO5w11Ue36lk+ObRtDAjArTq+BHHGzRENVrGfxJTP8aPkdvjlI1EG7J+3HMARpeA+iT6/d4gVxv3w4b4IB21urT8KIpszm8Lk3f9mZX/xvAn63XtdTWXFBdiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlnRAbZdXAUVDbBXT8boEuxdPiK8fCkOF881JfmR44c=;
 b=DST9M5yB7KwUKwbVPbKdbe5YhSpBO09YQJtDz6q+IHfYUr8lq94aOfuil2bEHCWAnOQHLSC5TPXZFulxxxQ5mvuhDEBmC9UodbrSLAzijLyapaS3iNQQYRQ0Tcg8vP/Rg58HTZonH1XrfAAWaqfOidPApuU24d6VsN4CD97cuSQ=
Received: from SA1PR02CA0003.namprd02.prod.outlook.com (2603:10b6:806:2cf::9)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:23:59 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::e) by SA1PR02CA0003.outlook.office365.com
 (2603:10b6:806:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.45 via Frontend Transport; Fri,
 28 Mar 2025 18:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 18:23:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 13:23:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amd/display: pause the workload setting in dm
Date: Fri, 28 Mar 2025 14:23:42 -0400
Message-ID: <20250328182342.17110-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328182342.17110-1-alexander.deucher@amd.com>
References: <20250328182342.17110-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9589b9-2fdc-4bca-8a7a-08dd6e25b562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|34020700016|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yaR6VepeUnRoSF/2YeKWy6TM79y2ZD+gN5yt71s+Ot4YG5N47QI34VXgKj3C?=
 =?us-ascii?Q?6VF3EOVbGtt6IozmGzS7+sIGwyHTaiqtCqK5b6sNIsgEyYP+IQvaOb3nToyp?=
 =?us-ascii?Q?S94b7hMKopJ/AJ46nEmtujZ0DtSCItQXWqWSCXQs33IfZ25UHixOcwzWOyBG?=
 =?us-ascii?Q?k7DNUSteDQlnMdiUnO4ZLsicsacJWCUnf2AbFH9OvXm/8m3RiDtF1y7VirGc?=
 =?us-ascii?Q?Hgyl7zSy/9nIIXjZ44WW3rvBIpjUtl4U16wGyEfmV4Ym0j7g9L7w9uqnuqfy?=
 =?us-ascii?Q?YO/BM4q9/vHRoyppgb7PM7Hsw5iZAYeb4wGciDz3BGiMby7u/jDQErC/2fAS?=
 =?us-ascii?Q?vwtsZYo3lFyrovfZFm16jTG2X5SCsZwo81nsBZ66ROrzTKUUVHOmOlNCqJbM?=
 =?us-ascii?Q?sc2YPmszEDzxZwYhg6sKHeTH0fwQmTwiH76Vki5qoQKhwu+NOctIb/2Jk+z7?=
 =?us-ascii?Q?1IDPxBMQhEilCbOpj1pzgAnnlOjFzEgZSowhYxJKmS4Z6XaDCvwx5+7hX004?=
 =?us-ascii?Q?NAssAM6mynrfll4p3qLkZyMcNMO8qvdYeuCKb4dJkwQv4GPN9t2xijas1HxD?=
 =?us-ascii?Q?7g62CI+HUFNEnil3zaRq8ps7d5v694mSJNWNNCHtAKQfLxzVxanZYHvTbE9c?=
 =?us-ascii?Q?3VrBPYtZ72UZARo8Wj5uW4/WLgvzDJntXtVFpJKsvZ912Jv1yY15GhMH41ua?=
 =?us-ascii?Q?iA3qXzbSj73E5ZbAGHGCAPR01Z8O69r/eGxvKZH+1RMW8i9fUVt1MmedNxv7?=
 =?us-ascii?Q?x1ImyZwIXcaELHicNlfIBeuKwK636xnXtJJ/lyNAWQ1rBvpeNUy+SuCNVm+8?=
 =?us-ascii?Q?VgmqLL+28ndlnbpz9rCxV7LgN0bvzU3vizQDa/gsHgiRXorBxc5O9i+6lLsK?=
 =?us-ascii?Q?7Mg5ZeBJ8bzRP+1OYceAytf7pYKgbzrHn9VbGO68tMlfhtH/3y8GNYHBVkCM?=
 =?us-ascii?Q?DqlrrNgZYDiNubOK776NO46NJDbS/Ys+EeUZb538xEy9eur5KwrxI/Mm9OWU?=
 =?us-ascii?Q?G1rTColuCRZISPW/ZnykbJrL4RjqvcUoPqWLIMyGUAlz/goRVhx3bRZcGYg0?=
 =?us-ascii?Q?mRMNtvNFmIEVsBK2DoVEO2yllel1XVQ+x/bCJssy795U+P/jM0oBO++ekO1g?=
 =?us-ascii?Q?U4zjMOoMVevCEugstczDvxkXYJjeneDE4Mz4x8poueca79BjqUpkERYMcXWV?=
 =?us-ascii?Q?h9xI5aXa83Gc6uKrdwb8A4d64LX/GM5hsf0LH1aGPh4uCkUA7uehRD0ZoRBV?=
 =?us-ascii?Q?t1/lZdaM2GR9WgzHmhMe33jMyhWhFmfzdVXcEMCUqXigb5iSlFxjznc+952r?=
 =?us-ascii?Q?hy/Ta78224zD/Kq969rm0r5VoTNrhhJBBC4LUYMXQjk06czcdbHz/w2lfKmb?=
 =?us-ascii?Q?rVOc2sdUPhdqUkeWEaGAKW0z6rY5H8+gfhhDRRcEKqSwcFU8a9V96XM8be7a?=
 =?us-ascii?Q?pJw4tkmEnmOiUt0g06ShjgheDxfILRrflaLviUzbyRqvpBIX4C67FX1WPSpi?=
 =?us-ascii?Q?pAQb2LVJzcm6Xa2SMqoP8phXp65H1gDem3y6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(34020700016)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:23:59.1832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9589b9-2fdc-4bca-8a7a-08dd6e25b562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

pause the workload settign in dm when doing idle optimization

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 87058271b00cc..e8bdd7f0c4607 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -246,6 +246,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
+	struct amdgpu_device *adev = drm_to_adev(dm->ddev);
+	int r;
 
 	mutex_lock(&dm->dc_lock);
 
@@ -273,8 +275,15 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		r = amdgpu_dpm_pause_power_profile(adev, true);
+		if (r)
+			dev_warn(adev->dev, "failed to set default power profile mode\n");
 		dc_allow_idle_optimizations(dm->dc, true);
+		r = amdgpu_dpm_pause_power_profile(adev, false);
+		if (r)
+			dev_warn(adev->dev, "failed to restore the power profile mode\n");
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.49.0

