Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCF5CF8856
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27FC10EA8A;
	Fri,  4 Oct 2024 18:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4KdV6kC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5559610EA8A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4y2ucV66jLak971TWp7AuFwYRZyQAxeH13YlcyZoVmZS2IZPbkGnfFTagn1bcsIdUZg6l7UMBVTRvD61BwjEOrKDUIa34T/9lTNeo9FTFth38TMj4gXfe2LgUD8cO3kslUNeAtpZ1ZZQ9DpvJGKRXLKjsyHoLJZ8aiRnQ2EkwfRy4ufU9opzI94uATocPCrubTt8Sv4irNyr7JishChInNpu5Vqagc4ipuwd+i4UiTmJq+wzPvqaVSt+aVOGclq6ciLHGgkQ+vsr/RfBgNwZppot+r5DuMJNFkbVs62LHlppyA3bFAS6iCfFJGpcPuSza0mv9ssIpT+KMsn7S9TsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApMlSM9eu55VgNnkqQDDOjMgSkCgrLjKXATu1C/NeMA=;
 b=d/CCSJULEQjdF6ToWYQ3Zb11qMuJtvvTJMGf8lITTeXUKEjipDP2gYHNIBpujDux0i1lhxdH5YnP9dRNL4sF+1YgbPRIyao5/7cSU7FyfNvCrPdBchnhJx0/RgNQks2yg36VrZ0wxRhjlE2xA6x+NfCGXPdoMovF66iEYNSrP+PitaZW28g0ft4PVMJXbqxhtC4XmiUaW3VLoC3ZMvNwzQ0gHRTONNUJ1As3H2YaOS8gdoCHq+i/ihPL8ZVDAvBIaTg0Q3/Mz7ll7v1DuyE1LLGfJoYgQ7b2UwWmQrbTnLqbtDv9lXJWBn9r0ryR/Z6C5xMw32Zy4JbdWZxbc4LyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApMlSM9eu55VgNnkqQDDOjMgSkCgrLjKXATu1C/NeMA=;
 b=t4KdV6kCewUi92+AmeIrrTPumdLygglUU5cNUQrRa1ihv8OBhZiKgmrayRFhfaQ/4fq1w8ZZy66BOpmNlqPCoQ1sV1w4ZfOoSBSl860ITg08QILqCW7/A9PckWbcieRgVZY3bSd7R1HjkxTwNZoWElOqP5ChFI28maHz3XevqzQ=
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 18:45:07 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::62) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:06 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 09/18] drm/amdgpu: add set_powergating_state_instance
Date: Fri, 4 Oct 2024 14:44:35 -0400
Message-ID: <20241004184444.435356-10-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 05137c48-c918-44e3-0b0e-08dce4a4aabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+UXwqCkTYvO/SZQHVM4ON13w2EgE0i0JeJgw9iCcxvy0X9FTcleG7FHY0dXF?=
 =?us-ascii?Q?+YDTVMd/Ze2RvrafpGFa1pIKt+vsj2jDbtwoGWPzDMVH+LPQgFwaEyrTAQqd?=
 =?us-ascii?Q?xYpOFHsKN6ljfqJVKLFDypsRIvLa6LMMJAwEe58SxdZ4Ehae9deU+pWYqbnT?=
 =?us-ascii?Q?A8BTxQlBjPrqI82cHAgNOOKkeqcEg9t+x36UN6t/j/F7X8kM0aHvC1GfO1PX?=
 =?us-ascii?Q?NM3EeOWN1otzVhd6Hxdmo1cso81TGl/JDHGHLO/T0gxJ/+vw/E/eHtJxUwuc?=
 =?us-ascii?Q?b4wf0mFabbK81vUaVxWsj4pzixU8oPk5DmWvxMpZS6/Zsly/yiTLrmw14xhu?=
 =?us-ascii?Q?80OuEjiAIlUy2E/K70oHNkqKNpqWfvRnU/jwEzHDrYatjgu/bT0bCSKvv72x?=
 =?us-ascii?Q?SSBzBMGjuRfff+ihWDADqdx3wvYgCk2k1Gna/dI0roF2DidfA6CSNWKliScy?=
 =?us-ascii?Q?T180CwyPjelTMVLYnVcZd02g2RHAmTfdBoD2cnUbTq9i/b2mv0DLMtdWtzAy?=
 =?us-ascii?Q?GGFHv7Or22vjjsgLKpGVYSIIQ7dLINk5sw3rKWX7euoaonqySgV84LEgv/zo?=
 =?us-ascii?Q?XETtc/ffzEGDtDJiNsNLV/k88SJYyfy+rHt/0tkf3tgUaO3ip185fr+Dz9WK?=
 =?us-ascii?Q?mx1XI+RLk2hlNpK2uNoJ0jueZC3AeTyQqPlXe+bNH+abll4hYfGG45BKnFTK?=
 =?us-ascii?Q?gofpUlRQsDg7ni32sJBjgYWxJsRCzvwktbyfPkRy+863//Wu+tOn9BazK97B?=
 =?us-ascii?Q?UL5u5DVTjdj9aDthZyp0pxWvWSMFm2jLwIEyxPSQD9puTf6Gq26L+dTKv72+?=
 =?us-ascii?Q?K2vm4w7pcWkddMsmzM629y1XzNZYQRgbSUUIai0BEYwJo5mIKRQN+B6q2V2g?=
 =?us-ascii?Q?5s58xJJC06UvPcw+vIkuwp5FyeqxJToHyNPzrYhxoxy+FVOJ/B7iid43zCTR?=
 =?us-ascii?Q?48tlS6p/3LU6wcoznQUd/7Uvnkrb5W7EkCILjHvzr1+kgC4Ou8wcnmFR12IX?=
 =?us-ascii?Q?suNvtrpI+4xv9giwPzr9ybj4Qy6psDeVTzUD0WNeU0NuG7SOb5+9xl7JSnYs?=
 =?us-ascii?Q?NG2GqmbQ9riXwINJkffcT9YBCfSzTLBGBRsj3dSqSDRaf2dPhJuCusKJFTiz?=
 =?us-ascii?Q?tSw2iO8AHCzmOck8+zQnRgb2IQ1GOFzXw7nV7xb6Bdu+X/W97/PP6k1T1Cnk?=
 =?us-ascii?Q?cn7OE0FpjiGMhvgUMTJ5pt9wozyXRcqcJ9cUyrQP14NHpg4tt5p/tWHZY5g4?=
 =?us-ascii?Q?8lOY2sCn9HMhqJodkBLgmrnBjLekoZQSS4LGlqe7cMWnkP5BuJyzkDkgNHIs?=
 =?us-ascii?Q?OVXIxemnmLvxWMGY3FVbwYJCGz5lfTnBGJ4O1X8AFPmYT9/gxFbLwdflAsca?=
 =?us-ascii?Q?+9s60VY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:06.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05137c48-c918-44e3-0b0e-08dce4a4aabf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add a new function to allow setting requested powergating state for the
given instance. If the instance value doesn't match with the one inside
ip_block, then do nothing since this request is for other instances with
the same block type.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3442564fe174..ae59497f3074 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -358,6 +358,10 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
 					   enum amd_powergating_state state);
+int amdgpu_device_ip_set_powergating_state_instance(void *dev,
+					   enum amd_ip_block_type block_type,
+					   enum amd_powergating_state state,
+					   unsigned int inst);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 35a3e71a5a84..f0b6a9675405 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2162,6 +2162,43 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 	return r;
 }
 
+/**
+ * amdgpu_device_ip_set_powergating_state_instance - set the PG state
+ *
+ * @dev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ * @state: powergating state (gate or ungate)
+ *
+ * Sets the requested powergating state for the given instance of
+ * the hardware IP specified.
+ * Returns the error code from the last instance.
+ */
+int amdgpu_device_ip_set_powergating_state_instance(void *dev,
+					   enum amd_ip_block_type block_type,
+					   enum amd_powergating_state state,
+					   unsigned int inst)
+{
+	struct amdgpu_device *adev = dev;
+	int i, r = 0;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (adev->ip_blocks[i].version->type != block_type)
+			continue;
+		if (adev->ip_blocks[i].instance != inst)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
+			(void *)&adev->ip_blocks[i], state);
+		if (r)
+			DRM_ERROR("set_powergating_state of IP block <%s> failed %d\n",
+				  adev->ip_blocks[i].version->funcs->name, r);
+	}
+	return r;
+}
+
 /**
  * amdgpu_device_ip_get_clockgating_state - get the CG state
  *
-- 
2.34.1

