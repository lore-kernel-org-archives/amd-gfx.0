Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5C2C0219D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB9F10E426;
	Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nI2zzt1L";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5A610E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbfU4QWdp6Yte8NB094GA6Ze6a5zedsCqmADu7Y6a4srQumAplft76cKUMSAUVLvcDl8lLtDAFA8udwMfniijcaE/var04nxOVyQNvZCCI1KifS8EpwSOt22Tznic27PrtWue5HTBPdM7TWdhK92ogHiUmQf3OvYQf6TXhNX7A9nSbaJXVHrlk3L/LrvYCt0Y+owvN9rMltmt0LRVmn6eQe1gjyk0EiAm8VZiKkpjINB0412orRNVHyKnNftl2PrvchreC2W0JdVfyGKkq64MW1MwWZ4LjcGvDZ8noJhTXQaOvzlftoGIDOZpltd7a7Pf2Nvx3eAm84GNfXTi/+oZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23OenvTQEhPBeqixZ5G1toD9uIomelQbGlTwqPPzJEc=;
 b=fQ7rKUEkluHQrOOOeWY2DcBFzl6ZHvBYPMXdW+Eyx003O4t6QPuSIZovoUc9GLheV5FXwFO1e6NORpJgSjh56BCyBc0QtJr2TTqXihZ306lx3Ui7xlcUq0RapAdXbgwxNQ8dwFPVjvI1mIpd1imLgnBEQQ75SYfmxjy/kw+1Z7sJv7evKGBPTyZLqRgaXNJX+G5IcYheFYkq6PUhyvsyZ+4lTtSpKqEDu1050Im10N7dPR+IC0wigO2/BWUmtUXU5udWFVFdG8B507uW6AnqhSDPc0reU/l+XnPNJ0hyg2wM4U2D/TySETJ76JmYZMoFUDTtMCQNeD62pSYDQpEZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23OenvTQEhPBeqixZ5G1toD9uIomelQbGlTwqPPzJEc=;
 b=nI2zzt1LrgEFnoZT9KBdUQ9b87WiPJckF24sNIDHmTFnsg13h6HIZmB85q1e9NneidW48xTnOmB4LN8WRrvWCwmbzYMGAZaWVJBg6AO1tGd6OLyUea+8RE7oUXxujbKCQWarTPSjRfKJlyVTWoOnsMfAW6Fx3FGLuKOMgJJA/zM=
Received: from DM6PR05CA0042.namprd05.prod.outlook.com (2603:10b6:5:335::11)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 31 Jan
 2025 16:58:27 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::d1) by DM6PR05CA0042.outlook.office365.com
 (2603:10b6:5:335::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/44] drm/amdgpu/vcn4.0.5: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:36 -0500
Message-ID: <20250131165741.1798488-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8c84d3-7307-4bfe-ecf9-08dd42187b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5CFCEoCXVCf7XFZl8tSlxGXfaqZiZ/Q07N9Vo5SF3G4NKltSE1bJPPCbSaLG?=
 =?us-ascii?Q?PBmtmSIgMzGRI73Sl+SOECHRYcXrDkkKWlBv8P7cCKAv1bLfoxMDsv09O5OS?=
 =?us-ascii?Q?mXOYYR1ZORU/eqbl1YuoNn7UsyPztiWnPm35Al+elH51b4kkdpHO2Evl3SvX?=
 =?us-ascii?Q?u3zZAcp0Y7GK32g6/at2zqqoUcN8EoBGmUHeHuS19M2MzJPmxsMN7XsnMPXa?=
 =?us-ascii?Q?qb7457izI1wNsEhTEncVM73jFMzJLKIGPFtnC6AK812jczDqrXY3b8XY0v8s?=
 =?us-ascii?Q?DLSKFsVuV4wKI0DlVtuiS7RmKZx0kLucxDml5NxMIc7U6b8jiufLnFGlwBlP?=
 =?us-ascii?Q?KP3Lb4o1ZpW1yh132W71fbIXupBz2jgedbHRviRD7LHWKOoPwN7ZMIzHjA0W?=
 =?us-ascii?Q?f+M5Tg37MyYBWp2PCTHanHMiDdOb5Cx3bmWGBOTqrnB32CHHJydrqbSrnfPu?=
 =?us-ascii?Q?MQs8w/M2JTjXsuqFkuO7aaJizG/ee4X2BagCGFTIS9VV3N3d4MG3RJ5eTs2z?=
 =?us-ascii?Q?amtDVMhhHPeT5aSO/5iFJf9g51AfSkDe/EAu0Cfpdzeyuje4QEySZ/0qs4T/?=
 =?us-ascii?Q?wGsjII+Yuc8Em4oVDVBqRYhovHRjgD5vYp0vpnxHIVuMXsaTPq7AiIA1HGwG?=
 =?us-ascii?Q?9bAA/hm8QQvrSHQamcu9vymd8fY7M3YUtGBSyLupRTNeEGSYA6OsGFibIpKf?=
 =?us-ascii?Q?67kRsxciJuAAFse0No7CnvrlnSKeqzWSTnixyc5o9wIF36niUQKfEhmTnoad?=
 =?us-ascii?Q?mtGV8AT1i7wpRkekOA7dEgALXGwruRssRh6XlzGVWA+7VNCx3TsmuMi32b+X?=
 =?us-ascii?Q?bRy95s/oOzCWzY0yQEGS6wbF6qcnR8oil8HWLOiS7kwG6p6fFvqTCS7CZMVf?=
 =?us-ascii?Q?lOqAPVqC4pzKIJ4M1dKW6AKQCF3r4DifUz88/6oWejHgs0rsNkhhf4DW/qva?=
 =?us-ascii?Q?GxMWRdEe1Uu8hi6MSGJYkBrApYuND0f4CFvwBtYu6rZ3DGZk0PloVP7qfVRa?=
 =?us-ascii?Q?cNhgUAMEQFaaaX0D0KJnu4r6zddOtWNDZYztNHDkM0HMq9JFJMWeX/jvppUg?=
 =?us-ascii?Q?axs+9NB0P1I0ogQzWZnlPIsEH4jD2KvpJAp9aIWj5J9iUkmy5BPdFIyxbjSj?=
 =?us-ascii?Q?NkND5U+gyHM2idFLYr2XURDmqJHi2o1wNhFt/4qznBvmK2e6OoqorRjVEZ0R?=
 =?us-ascii?Q?jRpWcevAcb86wLvJDeHL3dsb0yEdyz7xhagODKAxNoUjrX0G92/yS/RlI005?=
 =?us-ascii?Q?v+37p9owdijNf3cQrb0vYP2qp2oBBz8uZTTPQ1KD7oT8b6jTihzMplJasZF5?=
 =?us-ascii?Q?YmA0eWzS+66PDqlGh/NPOzKQ+K/02O1R4MX1w/51KehR6fVki3VfrrTVDqZc?=
 =?us-ascii?Q?XYbq0xMMi8kRHR/kpWeSufTvF6vjUeFxgPZgyEKH7ppg74d6+t9gEK0JAUk9?=
 =?us-ascii?Q?k9Jm2yABBG/KeLjLefK/afHtAldS0ZEuH+8ndb5wgTeXtMQpwNTaWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:27.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8c84d3-7307-4bfe-ecf9-08dd42187b8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 27 +------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0ac41249755db..0d6a97c4bf8f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -97,8 +97,6 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
-static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				     struct dpg_pause_state *new_state);
 static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -1580,29 +1578,6 @@ static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v4_0_5_process_interrupt - process VCN block interrupt
  *
@@ -1744,7 +1719,7 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.is_idle = vcn_v4_0_5_is_idle,
 	.wait_for_idle = vcn_v4_0_5_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_5_set_clockgating_state,
-	.set_powergating_state = vcn_v4_0_5_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v4_0_5_dump_ip_state,
 	.print_ip_state = vcn_v4_0_5_print_ip_state,
 };
-- 
2.48.1

