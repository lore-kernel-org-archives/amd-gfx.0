Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77DBC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 09:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F69610E7F8;
	Thu, 15 May 2025 09:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5pxpJr5U";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC6710E7F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 09:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdKf7ELqg9JHiJJ19G7zGVFU0OGc+bEYI29485T268eGmBi/kbuoAwayfA/WLb0+gpurMp/1g49WBubYA+e+054mNGuIqo5P1FiriU38dAfwDrIGT/aPVhDlxmeED5+k9WXcw0+cJ8FWJs3qAffKA8v04P5NQHQk8q8HucI9uiW2t1Nkdyvk5hHyRZ7aa0rGUN94GzFNuP0Yt72I+sZxWOb7GIQPlkfjkXcOjUkWXnAM20YDV+GRq3LwMwYleDukZzpJ6YIUZcCMvNlVhNVsCo8Wh7Bdsgcx/ibdhEl0kYcbjkmnKNKIegK6ejdMTDwvyhi8014NgV1/HA8elevqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAS6TpI40myi86MtWLbbWrawiqtO7pAp0BKe+l+8Hfo=;
 b=Durhu4sNMLD0Cu6lUf9AqghxY03hCYp4gxoNo0NMkM1bcn7BYYerfjjeX74B/iar1W+Svg0t6ZmiPBQ5h1ThhF78uy9bp3Zznif3sFeeiXF0FGiUn0k4GzmMzFUCWxfJ5GaOpKYPFr8Je4W0TEqJT//dnBZuzFB+3F/IZY6qqBn/knTqhLMOFN2o75K0H0YcDt3+0SVENuXZzcwfuPtOPfA+xlhDW+Hgl+8X4O199dBOZo7yUIxyfVh/mjx0RosiV1ULG1oX0ri4TcLMqr4fPhdzjldzXjP0+XUVPJLiDiZiaXFKfI9vsRmzCb+OpBKqKSZ9IuWwXDGQesDZwhc+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAS6TpI40myi86MtWLbbWrawiqtO7pAp0BKe+l+8Hfo=;
 b=5pxpJr5UzoR2Xy/GQkefV/YQ+WGD2eJygWEpAtwcB6UwJdMzEwd5FGnLnGZ2kkEcNFDYjyKpJbsdLgLtLkd1UHkJHEv3VSBkE3URC+7WpJYO5JOK9tXrEfNPxFYU9qO2SK0NqM7AS6YWh7Y4yU+bQuHbvYu/1nMnQsH0SZ4xkJs=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 09:48:01 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::8f) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Thu,
 15 May 2025 09:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 09:48:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 May
 2025 04:48:00 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 15 May 2025 04:47:58 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix eviction fence worker race during fd close
Date: Thu, 15 May 2025 17:46:57 +0800
Message-ID: <20250515094758.501650-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7516b9-7f6a-479b-b476-08dd939594c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JRjIKOKtOqtxRlXmQJnDiiy0EPST58S+Z0OdsqbiRsF5puYbado8zengv/9V?=
 =?us-ascii?Q?baT9cmZIraObQf+r9Amqj0tW/ZjJJS6hT1dS/wtI6ljA6P4CeZC+HjspudXT?=
 =?us-ascii?Q?zIhX/8PuAInuBEgRRnXWh96HDlM4NRfTfMxdBr2VR4YOulhv4Bh7IAjEYQjm?=
 =?us-ascii?Q?FyvYS6wF5ZjPLvtJeSRFOCaRSKq+TuWbsyVTSO+tIDS3ffz1snanqJ5FiXgN?=
 =?us-ascii?Q?TC04X9Dn3KHAr1QNBdcM57zawCCcF5E9XETv6Rpb+HX3CfEzrenj6EanEi/A?=
 =?us-ascii?Q?ThVheiudBQYvnrmFIMXgFfIt2JCkej4VJgFMhifQg31PRunmKiqcHizIOzCa?=
 =?us-ascii?Q?7R/ww7DvEP8X85G0Hi1BAMaM9LMS6YTh0cQDGJ9RgZGZE9DZEDVUhfjqOdZw?=
 =?us-ascii?Q?FBDyZs4taDDwpnljo/CxraDuJDsoLOSId1tSIXkDTGRLAvVnBoc//hJcPYYb?=
 =?us-ascii?Q?YVmPj2b9tQ7on+8jVlNtcVldhtjsKK8FU82z479FzsLVcCKmb4eWXxtVGWu7?=
 =?us-ascii?Q?s2V1ibuf4Snqgl7WkWwKJ7oaUNA/hB69wBs/1zulXXh8rxsrEwBQIrQpFhJ9?=
 =?us-ascii?Q?W3OjObOE1+BMSuBSf1Uqdss+kW58rh5FWG8owX01FQ7d4PiMwcWAhCBOKNig?=
 =?us-ascii?Q?xcRULAN9L34PESqwPAo/4PnEt+Tq1xeMF+bYlDiimtMpijj8zNeucH98hQe4?=
 =?us-ascii?Q?qRtBrH8SC4D7ErhImsw1PTgNbbT2PCVmJFBGEyl/xyoiJXTZzjpHKIwCLRS+?=
 =?us-ascii?Q?RQ1hwCiBYmpe0tgx6GQno4fnHo3hChxWy9fvKGf+WwWhTt5iU67+mBqAGMeT?=
 =?us-ascii?Q?vWUcPFUdTXAyk2+Awq3DOkmAEM86VeWE98fs82Y2XCpcUtzQz6yLswnO6H9d?=
 =?us-ascii?Q?b0zF2vBMnY9YVvcL3BMWzVv/sFZhqBBokpG7souI1GjW2Lf/eiKbWolhCn/Q?=
 =?us-ascii?Q?94v3mrD+SBa7dyXdICCtMgLvihaWayi7MWjeYiveQMhXYnqRlmg/R9Gynl0D?=
 =?us-ascii?Q?v4Zf0nbI8tn/b9aGqM531p7l4W21kwJwsDSt3dUzX2jxuvFtnkwM6lXEkBux?=
 =?us-ascii?Q?pvqW0b7FSgH55aaFviZdTwpBjiQiqfDSoDRlFNbqCE1miu6NS2XQO9oWWcP8?=
 =?us-ascii?Q?SszAKjfEj35qz15mL4dTCz4IKHV80/klAVmL4z1yiBSozaRvkaaTAfWllqYm?=
 =?us-ascii?Q?/1BnQIVr/tairfW4VlITOGFuFHJrGLlb6z64Iyv7RSh9NMJYcRONCvknYmyq?=
 =?us-ascii?Q?ITInwI85cULbWIZ2LqFmo8aiWtAcp4/zwoi0Dn1DaRB1hpGKj0xap62nRRVO?=
 =?us-ascii?Q?P02gu+VcgtibcNmCGRKSBpjWcdWytYUrWjvI1utE9yYMpJnTbXoA5puK3wTb?=
 =?us-ascii?Q?ZeQRXltW03wve76KV+lez2tRY+4MKWMZwbdkEEYz+CS4N2kFQTV79QF8XT2g?=
 =?us-ascii?Q?1RjncsrJHNmwUCxGbiFakieNVQNM1th1+F/7W1TTEsfblohQdOaSbr1EUYyy?=
 =?us-ascii?Q?YBN3QzQE5aT7Y7RWFwkH/gRUdOnM4QcuXzd0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:48:01.0786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7516b9-7f6a-479b-b476-08dd939594c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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

The current cleanup order during file descriptor close can lead to
a race condition where the eviction fence worker attempts to access
a destroyed mutex from the user queue manager:

[  517.294055] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[  517.294060] WARNING: CPU: 8 PID: 2030 at kernel/locking/mutex.c:564
[  517.294094] Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]

The issue occurs because:
1. We destroy the user queue manager (including its mutex) first
2. Then try to destroy eviction fences which may have pending work
3. The eviction fence worker may try to access the already-destroyed mutex

Fix this by reordering the cleanup to:
1. First mark the fd as closing and destroy eviction fences,
   which flushes any pending work
2. Then safely destroy the user queue manager after we're certain
   no more fence work will be executed

v2: remove the copy in amdgpu_driver_postclose_kms() (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4ddd08ce8885..4db92e0a60da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2913,8 +2913,8 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 
 	if (fpriv) {
 		fpriv->evf_mgr.fd_closing = true;
-		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 	}
 
 	return drm_release(inode, filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9fbb04aee97b..d2ce7d86dbc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1502,11 +1502,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(pd);
 	}
 
-	if (!fpriv->evf_mgr.fd_closing) {
-		fpriv->evf_mgr.fd_closing = true;
-		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
-	}
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
-- 
2.49.0

