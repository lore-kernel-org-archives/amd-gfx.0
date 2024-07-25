Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF66C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE02210E846;
	Thu, 25 Jul 2024 15:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWlTxR57";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB2E10E84B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAg/TB5+cwlr//yN93TP+p5WTGq3RsnfO2wEvI46pQyvMnzwARZPRLIqnIazMQNKoUGaT71T0U09o4u/dc2t31EWujUBbADdq24jZd3bJ79jDG/VFaF8lFZ8YzHusjkZZq6NZIgzIP76HK+EV47D8EIZimILsSlxxQ9Ln+4QjaLUvO+SadhdPrIHP1WvXbV6mKbl3s2z8t/y2aIGefkyssy8ma8usKRlAt99YCEcAHuy6pCImT+AZ7LvG6mlGS/2+psp3kiuj5Sav7fL6GtwAhAMBsGEq7KFKhlytJchrfP5diosIHqcHCnUhZoch3ekcn6t0RW70/UkclAfu1zjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wviClx8Hi5c3eDMSOwlmuPocD8cTG8QZ51JXGCRSN4=;
 b=HSsQVwvuGLK9wutAcSZv8o2q8+j5cJtUwdl6jwFkCwObzivPkfgpp37VqnhuROFS0Y+9J/mUl+NiR1qasQpUm7QkIm8xvUCMpwLxOJZqr+25LVPqE3LrKivKkrrDB0AyemC2ERRCVMwoHnkk0ZMUjLXsxKbAB9sFuOmrU5xMH+YOqlMBv/YYlhAa2aQW1T46gbIZKle7WoVSkB7BorXefxHQjamCh6PyFsuiPJowwMoFRgJLVLSGL2+UFafbDLF5GC9DDBFAMAMruupKC6p783Wwr25HYrKWXEAIzUiyUh84Cv1cdoJ5PKKSbfTh2aRtSGRFZwC922WTQWGuX+8idQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wviClx8Hi5c3eDMSOwlmuPocD8cTG8QZ51JXGCRSN4=;
 b=WWlTxR57VI7ELSwF36wA3ITolluNO0kpBtwdUItTgvpGYYC/3n/l9FYkLwHe1hix/qg5BfM2jDKy4KRkJsrSvLY7YRNltocmRPrwJLXuxEBxWZL2Dang98dwa9R6m3s6KNbJ4c3ApxhCXT1RWCHC2paLgAafsPVhaDcU9lheDcM=
Received: from PH7P220CA0110.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::21)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:24 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::12) by PH7P220CA0110.outlook.office365.com
 (2603:10b6:510:32d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/53] drm/amdgpu/gfx9: wait for reset done before remap
Date: Thu, 25 Jul 2024 11:00:24 -0400
Message-ID: <20240725150055.1991893-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 091ac341-d7ce-4ff0-d4e5-08dcacbaa6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1E3Ql4Sk6m+gpTzvfVdGNEyM00s23RrniN4WGHNg/82OB80AyLFSUl1wsAG2?=
 =?us-ascii?Q?Hoad3ltOc+2adukrdfxIjVpd3wFh6Smj9XJHrvoEUv++QyavEJll0WrB2I32?=
 =?us-ascii?Q?o3xgMtjBWZcKUBKRh7/0q7gZWwT5DcFSG2hK+gjLdcpilcoWE+0gHiMEQP3R?=
 =?us-ascii?Q?XtRbQ25TE1OMWGtZSUW+L53tXdJE95wfb9lgUwQ1teDOjgFelzcp0IDffbmU?=
 =?us-ascii?Q?qIUNlujJsumGwFIjqysodxX1maYuv5ayJnDVUVAFu7ZG339260UlOrJP0bLU?=
 =?us-ascii?Q?E6SmSR/XKJ1eziKyLNTU0s4bA80NwXB+oasH9geRZpUS5bhhGHHEszFbnM91?=
 =?us-ascii?Q?b/GgDamGe6dlYamhB8TT/NfYSmCNhQ3/5/iN0Rewu136vT28QWdG0x/iVB8r?=
 =?us-ascii?Q?ShUot+lSl0inJi1+tEDoldBQjHUU8SQqBRw3vN1FhNG3FnOKGxPONrdQtUfB?=
 =?us-ascii?Q?Q3WVPNtfNfc2HFlwUbRP7iOqvPq/Ck2SNltReP8vi5Buuxwo9kp2FCtMi1zK?=
 =?us-ascii?Q?ypGbeCRbRgXM7BFfZcWXZXBXi3b2cfOHPLICPhrldTxp/pxZXv4L+q219Egb?=
 =?us-ascii?Q?JMDWoXJtMxU0QWw3S9I8il8V+DKCgGZvIB/j3s1QROgieAowRCAqtluUSqPV?=
 =?us-ascii?Q?M3tM3ShIalQwmqt3tXigRQXqr8PLT5xomo6bANZ2FxX/6zZQWF5yOaDIYfli?=
 =?us-ascii?Q?+ro8XXgdTuJaKps0NapU02SGN8tyYkfrwHvqutA2wFafQG1efKpCApJKjrKs?=
 =?us-ascii?Q?ocbunXt0hej55VyiFR/9ieASCyre3p5Rwpw6bTFvFSI+mpotNt6asECEu4ld?=
 =?us-ascii?Q?3xJ2ppwPnMK65XJYsx8w1RoSixJQZN7FAcLtk+WAkp20+dLv2eVaplzmN6rc?=
 =?us-ascii?Q?JjqBI7wCznKsEEP1Ee6Z+2zCYOhZz1jwVYIqTG2bHGw6NPBUGfvgTylkSaIT?=
 =?us-ascii?Q?t48WKWlVyixr4LNJvDgr28WvOI5LdgxRMs8kq4mU+xbBeYMQzwTWC7/ojskx?=
 =?us-ascii?Q?RWSZdY+mQ5H+Tes/Ga7J1yQpRzfd0ZxYTtkjY59BgPFXN0/k1sCZLx1r6bZk?=
 =?us-ascii?Q?foyWC/qzU9AdonMiCFu4w5dNKujGw9F/s7GNKq5ouuPaXgL754YkhWpwpvJ3?=
 =?us-ascii?Q?FI4uYcs64arRNVRjyTOUhbS/uNvmNrilEEKE1qLCEfADA5BLmnTL5LNzsvar?=
 =?us-ascii?Q?akU6nRFi3j33xakYQXUdGQL1DZ2Fw1dtioKGduQWYYR/EYK5WgHV4sU8KyOI?=
 =?us-ascii?Q?d7Sr2k44Le1oPGfrnSBEVDvQXyOGB4uGuDk2Jh+m75TG3n6OxkT752hQWTL6?=
 =?us-ascii?Q?huFgJ1+A3y9kwzX0y+mpE0ucQmY09vMt/OcZvZ9DaCK6GexFfh3EDr82Fdp5?=
 =?us-ascii?Q?p1PZqqSVaGgDbbZGSIqqGENBw2jQr/IiUzpG9CKL1xgIJ+Ay8lN8KfT6rEjv?=
 =?us-ascii?Q?yB7Dhpm0hhkJTzfE5+R1GCgDM4R1Tdi5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:24.1247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 091ac341-d7ce-4ff0-d4e5-08dcacbaa6d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

There is a racing condition that cp firmware modifies
MQD in reset sequence after driver updates it for
remapping. We have to wait till CP_HQD_ACTIVE becoming
false then remap the queue.

v2: fix KIQ locking (Alex)
v3: fix KIQ locking harder

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 36 +++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3a819c6923c6..9790e64ec4c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7107,7 +7107,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r;
+	int i, r;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -7129,9 +7129,28 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
+	/* make sure dequeue is complete*/
+	gfx_v9_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_0_unset_safe_mode(adev, 0);
+	if (r) {
+		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		return r;
+	}
+
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
-		DRM_ERROR("fail to resv mqd_obj\n");
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
 		return r;
 	}
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
@@ -7141,14 +7160,21 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		ring->mqd_ptr = NULL;
 	}
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r){
-		DRM_ERROR("fail to unresv mqd_obj\n");
+	if (r) {
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
 		return r;
 	}
+	spin_lock_irqsave(&kiq->ring_lock, flags);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r){
+	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-- 
2.45.2

