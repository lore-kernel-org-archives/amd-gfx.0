Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F73CCD185
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 02:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D6410E927;
	Thu, 16 Oct 2025 02:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jU8dudaD";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA9710E927
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 02:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1kMd+gHuTM/9k0bciwIUyX+ZQdu9+US8Xz4L8nsn10fDBlTkKfVeX+cINQFdm2ONRLUbcdm2a4mgSUUvCVmLOfrENn7rbufgz29gPoY+8+tX1W/mE6I2oBsypygMJbFNEHTB7kE2PYTzHAneDB/D9fbm9vhaygUdP4s95WCDaAl3SlHMOjyhkM80HP4GK/MBk56p0VlpaOmBfTXAs+uqmDNqWiieczwMam0x1jhmhTH/RMVVpcB7BxofhzdPGGYQgd0wzD6rfByAvuKEXZkLsw+URUXydKMtM+H4kyomtO8FnZRg7Bmc/ic1X1YTvyhC7br5W+xI2wa8ndp5BJFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V9tnI7baZzxp6WALsOv0UcbFWP52WMDpSZ+gNgNZEE=;
 b=t/Ugx36VLS/IYYXmx8ghARbSzSX7g18xyZ6bcWUomiwmkKuFcuXRMHBPh/GLK9nmUDVomNQvRtcy/qImrCrcH9WeaH6HT9NQvOGgWvhKhLCz3sehVoMduG7U+J/J9MEdNlegN3uGTFaAiuK192XMLbvtzFm6/jR1PAIKtUeL5irIc2KXJctME39gmN0JjLETxIlBty7YWr7JGwF//S6BA8DtzyYGh6qwjkEXPaTQHLLByzmpeBICgKsncKfM94GQ9eoxpa39Jykm39/BT3Zbc6uFGMLN0z2cFwAv1OHZO+7Vtyqg3OPdDf1dACKR7CtG0DlsDCZjTcxCr2GI5GRxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V9tnI7baZzxp6WALsOv0UcbFWP52WMDpSZ+gNgNZEE=;
 b=jU8dudaDMrR0nX8HFew16YyfB14AdkD5eY1HekHss5YN57/KhHtgRdRPMrwbI+UTvBD3ylkEmv+dWO7KiwvU3yjnxQdGaXypkNTp+32+LxoTMEfSYQ55KqGSdYIFMfTHqjNjZshqELusoIgqXsuAbW+fcdDVdMYTkK6SAjb4c5I=
Received: from BYAPR08CA0023.namprd08.prod.outlook.com (2603:10b6:a03:100::36)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 16 Oct
 2025 02:36:58 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::be) by BYAPR08CA0023.outlook.office365.com
 (2603:10b6:a03:100::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 02:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 02:36:58 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Oct
 2025 19:36:54 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix missed lock in
 amdgpu_gfx_profile_ring_begin_use()
Date: Thu, 16 Oct 2025 10:36:44 +0800
Message-ID: <20251016023644.3143128-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: ec530521-9690-493f-79a2-08de0c5ce0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B2eRjXqT0xE07Wop7QB0/XT1eJbOC4hs+wF6QuvXdKEcS7SU7pQRFKXgEKQK?=
 =?us-ascii?Q?Sfpp7faUuzazZusoMqzKyrAeZ3aLUa/HdeFtIYsRVsK+gp+XuqhiFBIk2tyf?=
 =?us-ascii?Q?/U1hz+++Zg58AKZJ9b2LJgTMrDhVM7hKMza7tI6+AcBS3ELUuD7VfUHC1cpl?=
 =?us-ascii?Q?vRmiUPIKfFTk+2dBnDQcEfl4Qenk7N6Z005oOEjS64xVSgXKC4uiVFmhcFp5?=
 =?us-ascii?Q?goLzfUw8fAYDV4+03T+q9nr55Zo97mMzNpifyPFJ4pMSa+1jDJPXWeConmHw?=
 =?us-ascii?Q?SmkkN/gsUtunAr8j05zufl0fWT1rzj6cOFndBbSz5xE8It0JS/Kk2GIvINB5?=
 =?us-ascii?Q?gf9YW0NBXu1rSFhI44wmZMnbyfsWuQxQD103oumIwHzS/wtbO9Gc7+yeHfDI?=
 =?us-ascii?Q?AWLkuyWiqK36OaugXsSUe+EmZ4CpTnRssStYdQ/zjxy2Xku+lRBpNPyQsa+W?=
 =?us-ascii?Q?+pC1S15ubv5AK5Eu7TXGDjjntr6SO8YUd5sojHuBIbDwwAwYUAgpcSHbjbz7?=
 =?us-ascii?Q?ZdNx+9zySlg6eaEPRyzmgJckRNx603ZO2k4CR+EXOASFJmmufa1/LS5DNChk?=
 =?us-ascii?Q?hgK6ga9smdepiW5nKj50Ka30yyDK402A+Tf9kHm57Kiplh01BhKskKdb2Mrk?=
 =?us-ascii?Q?z79hIdbYNtJzyyOZ1l2Gbm9q+JyF8UwE2RLaFeznlwHhho0JJIeMUiH+n66n?=
 =?us-ascii?Q?li9cZcH4836fRbwFxieFY0+VzUjXttVCshQ9gYk7EVs6G62FYEkF9wtMR1Iq?=
 =?us-ascii?Q?yUx4LkBGjfNWh2m29b2k2nVUgt5R2vGgt+JYnKemPZEm104ibv4IQ9A+4M7T?=
 =?us-ascii?Q?NtUvHHgpupshl20eakRzXRutLUZpNVz3gsS3mplb9uhHpMx9tygNqeaW758N?=
 =?us-ascii?Q?RZbOg0U297W+yHl5v3acbpg2y6O+j72WtcAc+PRJis8wFHYf8Na2JirYsBIC?=
 =?us-ascii?Q?N3xvKLCwzD8CKKpJceLuQFDArnIu6/+djdKke/TVxh4zZLXdAUCeUh5s+iyV?=
 =?us-ascii?Q?Jv0BXgTvptvXr8Mk2sh5SthNQT4uMWwk0S7PLrqEi9w9C3910o9p3tvGSYnj?=
 =?us-ascii?Q?tyRsHGaTCDC4J0n44boF8Du9M4pnclXprXUZNnd1LmCwM9dM26zCUQLYO6dz?=
 =?us-ascii?Q?2P7pIsIhpYGEkUrgT1WWFEq3rBjp3uYat/IhS1pgIG0gJhmghyRi7y/BAesP?=
 =?us-ascii?Q?5TdwzoO52cSH1/MsNM1ApyV0irbc/VLnyT2K1yMeEAIiBWvHEx7r1v7DP+/d?=
 =?us-ascii?Q?VF5Ys1rE6hYHivEvowq4yOI3XqClXBJOWvMLlEGg3xvts+DDh4O5O3tCNTy/?=
 =?us-ascii?Q?MJMGyexuc9tvEnBf4OdqnViU8f+hkMFEr56LKASHuc9LhcCjwEQCjTjNf0XZ?=
 =?us-ascii?Q?TJ3TSCBVBmlWaRwXFyfHTMUEMaPQ8i8U7RKq4/ZtVaGBrcwXQysNWjUu2hzS?=
 =?us-ascii?Q?4QFMZjRixKM3lWknZ7kyCRL/+Fl9J1hfTp0HAgnb6RciY+bEPiOYm+SxvUrk?=
 =?us-ascii?Q?7uc+R+ySfHr6Of3h7vTqhnfz5ryiD9M6WEXlPnDv+Z/RzO7L6HP5nY8ACt9T?=
 =?us-ascii?Q?Dpiac3noJJVFF7luI6o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 02:36:58.3134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec530521-9690-493f-79a2-08de0c5ce0fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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

the gfx driver need to hold lock (adev->gfx.workload_profile_mutex) before
access "adev->gfx.workload_profile_active" varible.

Fixes: 9e34d8d1a1abe ("drm/amdgpu/gfx: adjust workload profile handling")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f02e36ccc1e..59329e8ffb86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2249,11 +2249,10 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 	 * the delayed work so there is no one else to set it to false
 	 * and we don't care if someone else sets it to true.
 	 */
-	if (adev->gfx.workload_profile_active)
-		return;
-
 	mutex_lock(&adev->gfx.workload_profile_mutex);
-	if (!adev->gfx.workload_profile_active) {
+	if (adev->gfx.workload_profile_active) {
+		goto out_unlock;
+	} else {
 		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
@@ -2261,6 +2260,8 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 				 "fullscreen 3D" : "compute");
 		adev->gfx.workload_profile_active = true;
 	}
+
+out_unlock:
 	mutex_unlock(&adev->gfx.workload_profile_mutex);
 }
 
-- 
2.34.1

