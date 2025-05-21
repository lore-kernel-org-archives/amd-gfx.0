Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81AEC54E71
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 17:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39DA710E707;
	Wed, 21 May 2025 17:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QhMhIx82";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1888C10E707
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 17:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJj5AMMFrcpV2Qw5FI2dIEqcX1jwwq3jICkPFnudVnbJdMZjVgqFAYWA4xsyCvvmT33onZkoMEDO26m6B4CDQzfQ4ExNQUq3g+9T7j0in1oHtRlA+qBX1xGn97xkYLesWOkz9H9rTw7HNZ4wXqig8WAwybLifwX3S5Dq2oNkVHbDXZN8M76qZykloG3bZRUKAuwyhozIQlCEFPAsLTnlPGbSGlqvM1YmDN/RXUNjWamL7EtL0AkK3Mqs+NXMpfRBW6qz+v38a4PuDSu8x1eDIEVdLZ3XXFHYUZubOzr5Oot8U6x8lMhOcD1VFGVJ++Z8bktcDC9nryBAcD+AihCLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnNVrapF6DIn+Cyt4lPDD0nAhh7hR/biASXhTZG2fOQ=;
 b=nmxq1LyCfVRPbC6yfAvKU6cZ0EKM+ypbJyfXWQRb6V5+y7Fy0RGJ6N3pr8Y3ciCJCqieJhZy8hKb/U5sgkCI0T7yc6SgiSTexXUaTwFMOqmGCIF2rZor7zbvhNSl5RIfN4rAK34/HQtUd4tBd+iZ/xaIEAZNRWf9Ou24l5sIu3bHOsGRkqkzYyNqWociJVeyqEMfcOrAoMaq2C3nYS9QzuNc7EWelpJeRUg+CIKjusfh23V8vxfQ26BUsYdBWqK4xO1q/nbcw7oSO5WHaRLjShEf5A+SXtjpqsLP4K4bDSJBYPU07oCxrQkqtYIkMfaUlX3qwM3NeCZ/m68ZeUbtIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnNVrapF6DIn+Cyt4lPDD0nAhh7hR/biASXhTZG2fOQ=;
 b=QhMhIx82L4xr2SqnEWfec54rmvpgyFWx1oWlvTw4Q/WZIWyOQwQ1rvvUXiL7gyLHWrXHKVOxW+bZVOIQF3JPeaC5NOq07T90gwWKSs9KiOaJb1dBgr31VxRK3n75N27wd0AZiOgIOQb6lJotjLSK6X94QibSA2YeYZlOAQ+KBj0=
Received: from BL1PR13CA0101.namprd13.prod.outlook.com (2603:10b6:208:2b9::16)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 17:12:19 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::1d) by BL1PR13CA0101.outlook.office365.com
 (2603:10b6:208:2b9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 21 May 2025 17:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 17:12:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 12:12:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 12:12:18 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 May 2025 12:12:17 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH] Revert "drm/amd/display: pause the workload setting in dm"
Date: Wed, 21 May 2025 13:12:03 -0400
Message-ID: <20250521171203.48711-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 724018ca-0320-48bd-baca-08dd988aa459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ba2x8QOgFyI5wvtXOdw+dVJmhmvmL0kJYXCrZpGR5UaXctXUspUxH6CisHqc?=
 =?us-ascii?Q?jn4KOhDnt4VFbp7ByHXj4ZrNYAcPibv/syHyPEt2HJL053n3WuEoqHhk+10O?=
 =?us-ascii?Q?qxTPUJX/+QtJdFRLhU4QGwibE82G/7A/N3615157EGFsxrXKQGD7XjOhPGi/?=
 =?us-ascii?Q?OkcZRrPUj5O3fj0lCQ0RMJ+2IsrL/v+Fy7/SDF8kSlpQPKwuyRDkmOIeMnfr?=
 =?us-ascii?Q?1N3wgr08j9/h9nBXb9jyTWn1439Og875MT4c/m20jHkF4AABw2USwRjCIC5L?=
 =?us-ascii?Q?c0cs/CXcNh9XB09PD1ad9j06bZbpgtR59WUw6pBvvxf/AO+r21l41DpRxvhG?=
 =?us-ascii?Q?qs6ibC5K46Gh3j1IFqEoCYlCsBmLuLnoUo3rgx6gv/cT4cdg9YtUeIyhfyjs?=
 =?us-ascii?Q?B3n6gJtxOgEUe/hCredWYRsPnGJEtg4Y77roqYhyQXGmCFDGL9VFP8E1aXWu?=
 =?us-ascii?Q?B2tg84qAor5OBPL/MxCeRUEM4kSY7ZjSQmTqd6dOas1u9ignDJzy7t4an6GI?=
 =?us-ascii?Q?zPPRzOvP12QBefvWzLsWKNFobZYe1Ylj5gFl3uSw8oBGN8DoFvpqp8/l7qwg?=
 =?us-ascii?Q?7R5fpGK2pFlg0OHLiDN+o50ZB5xhqf3kea/AHjMHHVBkUrqa2C0PL2MtAILA?=
 =?us-ascii?Q?enuTj2oqkb8Z//y6SXhZqhIBkbuOF+RtIHo4przzBA37ioj9FHkHe3aczHSd?=
 =?us-ascii?Q?7W8Sc2qK/BOAE7F5Zz5i/3uYzg1FZPwRNZV2z50Zo7aay6FzKTwOpFDVgx6M?=
 =?us-ascii?Q?dRmFFqLGRp4wECLyY0wVuDZFx6T35EHISiJPaGqs6G0vY9L8X86lIx+9yLNg?=
 =?us-ascii?Q?2rOKczNxZNv4mn4DS6bXg97wXYumPx6HOKD8UTyHqIxven6rtTh9KApXU+eB?=
 =?us-ascii?Q?p5LpTqs4KlzZdFkxV7VPJ9IZN2mRz05qkUPZb7p8ZLEOSi/Z9VFHS3X+YE5R?=
 =?us-ascii?Q?1A+TeSto6Sb2ZQc52gdh1BzIR05VqVfIYCrmZi0uVwYaDdiOX+UU2PnUe7Ht?=
 =?us-ascii?Q?VTA+N58y1vNabphQsVPeoCWIGV9rI7aM072BtQiAQ0/ooZl217T17fS8p5kD?=
 =?us-ascii?Q?ONoz+uplhxaF/kzv7rGCwNa4JQ+z1XdcM+lQ1+VU1U9zGQu+A+TMUE/yW1IN?=
 =?us-ascii?Q?2vE/LXqKi0HHtalLfwsNeKKDD7wd/m/+/Duce3aLVYwblHM4KKD9K+rPnApo?=
 =?us-ascii?Q?onv3Mxl5LlZhcKfe4DDR0/00DFHnltVPCZBu2CYIAuAYH8PCY/Jxgdld0OZ3?=
 =?us-ascii?Q?pfMT2JQyiYNIRxPhwPTdtb7/yDIPS/AT9Aff0wn/hqX9BeQNZ5nb/S8GqU66?=
 =?us-ascii?Q?FDLdXeaiWRrRxPSnHxtSiaYRtFxLTj/VBCitiDKs4UZ5Gv7JEn+uIevru+NQ?=
 =?us-ascii?Q?+McQmGwjpTvAy2Vx1WG6Q7xyTu2wYSmcoJiI0h3buECwNmrxsRp/EDP6se78?=
 =?us-ascii?Q?QWCwFOLNJ5ZJi2eoM1HDm2r+KbpsQ/jPWzqYfjhIQfCwnrosE122c/YfcA4d?=
 =?us-ascii?Q?se1uEiSGLRNebMG2UCi11ClqgzUrkAKPQQzE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 17:12:18.6297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724018ca-0320-48bd-baca-08dd988aa459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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

This reverts commit 243678df7a058f65f5f43e8026b359bcc91e0b69.

Reason for revert: cause corruption on Dell U3224KB DP2 display.
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index e8bdd7f0c460..87058271b00c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -246,8 +246,6 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
-	struct amdgpu_device *adev = drm_to_adev(dm->ddev);
-	int r;
 
 	mutex_lock(&dm->dc_lock);
 
@@ -275,15 +273,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0) {
-		r = amdgpu_dpm_pause_power_profile(adev, true);
-		if (r)
-			dev_warn(adev->dev, "failed to set default power profile mode\n");
+	if (dm->active_vblank_irq_count == 0)
 		dc_allow_idle_optimizations(dm->dc, true);
-		r = amdgpu_dpm_pause_power_profile(adev, false);
-		if (r)
-			dev_warn(adev->dev, "failed to restore the power profile mode\n");
-	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.43.0

