Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE507D172DA
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 06:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD4510E3BC;
	Mon,  2 Feb 2026 06:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TOyCtjPQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8E610E3B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 06:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/u/XgPCy8hSbaN0FIvBdOpgfgKJGrv8cYUoqHSvTFXAuMV2CSKnmUC2joEprhgoRQ3hgPb4dAhGOX90/+E38yr2pDKQv54Gj7GHQlIU7/9fTNXyrUmp7vpLfe18TqkHg6cErsOCxnTsTkUgUNAWnH6SxZfuR8UxKW0+Bep/+VxS+JB5DnOTDCumLWRTmLI7+h/KdL39oGvx1sl9+RMZ13JvHqpkNT7EM+To5xtn/KhU5WOIQ7qt+XtR1zzoHMCS5J0wJd50dsuE85ldBuQ1CunJHHNi7ABKqWHpzaRohf/AMDAfMa6nna7XK14/BONZwI4SFpGA/Yg6Z5WM4dZZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KczqtV59CUXtJP5jadMzVl3hpGroS5zTY9yYSiat0Q=;
 b=P8SVkuDNukUmRM9w+JLg0eFwitwJKQZ1Fq0NVS2aaKQGBuAtGM8z++g9fjnfg/WsHtIO/5LzictzMRV+ptjhx1qLisT+fuP6lGKmvonE3+58Frx2LEb/FYqY0HgQ2zKWluxhHvGREvRHQYXnnb2Sy32ocrQs6nLCHSYNR8vUT4u+c5qDXDpouitViCnHb6HHI2bQZlQjC3a+/XC7NYGlHLbfkrpBsS8XgTEWQeg5+lLe7zjuRACzZpAXX5Upx48w39Pl0bwkUO+DLgt+G63I7cT6k+MFJ60gjx8j6r/OTDh6DYpqYodVbieLgaLeM9Wl9ewbJs99m6niwvE+O2WX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KczqtV59CUXtJP5jadMzVl3hpGroS5zTY9yYSiat0Q=;
 b=TOyCtjPQviRv7qYNzkQHUsAcxDqis32w4c3wAorJjNpa0w3VR5cnVcGlj+PQwitV9HBir/cdREUX3T8zXWGJrf31mjnlrhcghWsn9d/1JPkDufEPVL0ugaz2st4LZRQb+C/C+On5AHk5hgfMxDfO+LEAzNLDaUs2rcilKDhPh5g=
Received: from BLAPR03CA0043.namprd03.prod.outlook.com (2603:10b6:208:32d::18)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:32:08 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::9e) by BLAPR03CA0043.outlook.office365.com
 (2603:10b6:208:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 06:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 06:32:08 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 00:32:06 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Put GPU CG/PG ungate in device_fini_hw and
 device_halt
Date: Mon, 2 Feb 2026 14:31:51 +0800
Message-ID: <20260202063151.2363659-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: da2c62ce-5c47-4014-5aa6-08de6224ca3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3EfVTR4eJCJKVHp/P+FwBN79UUSzKM+8XERmSOrU8xExk0HNFkv9GRDVJqRc?=
 =?us-ascii?Q?nO4SoGiG4P12+d9ypD5utwG1aqrETic78Ei6a9W7KgFgp+b97teq9JAP9ccQ?=
 =?us-ascii?Q?mmzVxNFGhrHxe8bR9RQ9nv60AqGSZobKttJlGnwe7IyYQsBvQ8WxZUWM6TVC?=
 =?us-ascii?Q?Nd3RqJSGieNVdtOwH6LvyA25vi6n6Kwe4Wa2kgFasJ3SESlNPK2S8n9tVXLr?=
 =?us-ascii?Q?zx3CRUYkxTbCexqghvxY7i55swXTku1fjjKB/QoktUwTVqWrxTNeM4cVRcmd?=
 =?us-ascii?Q?JhB+4PxOhebRTaSRONxfIOtOAwxWDWnjFvc9jOYJI7AWXJP62ej+gJ1a4oED?=
 =?us-ascii?Q?3txsnSnchYo8+GsmHb7W/g9UBPKlJEzu2e9vfleg/tEpUyu+jGQ6Dztrv+6d?=
 =?us-ascii?Q?tIcOsUohEcjth2qJCoMQjPo3wRsSAf5PMRBUa8qXyUuNW7a9GfVLG5MRcE8m?=
 =?us-ascii?Q?EjFWg8yubGTHtQd3FJfmIJNuNhFqYJhyzurjtiYW00w5YT61DqhZhZ6WWOfE?=
 =?us-ascii?Q?cjr0+MJ2Bb6Fc19M4WZ+plhgnN/DmfiZlo94hOpT1qAopsY1inlZDDRqJnjI?=
 =?us-ascii?Q?lCeK0dKvXTVFseh8JVEVITvw0wG6UZZ+t+vUPhpkxIlJywXHLDQLnWDPnJCc?=
 =?us-ascii?Q?uKH8oYd4N6e9AMdD7hgqrkJXhwNiHYs+5/oe3JNWA4IhFwElEy4X0imLswKV?=
 =?us-ascii?Q?5jbFpUmzgG6fPVo77xEpD2e8WrvS15Q1R2knqFnY480+JIs924nJ4H4JawPC?=
 =?us-ascii?Q?Jz2ONvf7rnFI3hcSkMxXN7WEuYEYaRiCqMyP2ZfVgJBintefUuUgEBGCTy1B?=
 =?us-ascii?Q?QRxEv+zkPYZt/bfZv3cy4R1+Vvk81hNvogoM1Yf8R0CcwN4BC14u2LnQhFcr?=
 =?us-ascii?Q?7oUD/FGU91qCm79RvQ6K6IkWym5xolZ6336zLCDejSFCTDAyTR7DmCj/eJX9?=
 =?us-ascii?Q?9MZh8ytGlXv6UexjWrTZ5canA6kve3yjp+VAf9N4lSOTmQviVnPY7IMFhKoJ?=
 =?us-ascii?Q?KXRx8FvlEAYk53ZoMaEuQ1+nrYi9pFG6qw/Ma5/Hj74Ke9i1PK8Uh/yfcyz5?=
 =?us-ascii?Q?tbbXfTkNzbTGLkS7UAjL5i7rfC5UMhRNcqtD0s6Oe8z3Z9dZizmG/MlhjXVk?=
 =?us-ascii?Q?LIUGjOHi5wSisS1GVv0dkorhovAVhszuoIUvyRVAjIPYMpCED8Urmwi2v6JZ?=
 =?us-ascii?Q?fkLkinYRfJFzDlZN3sNuavlkOcdJvVpY7Y5BRNnQ/ocJyPV4ixrX2ljayOyv?=
 =?us-ascii?Q?4nuMYKblgPHqSzTvQoCwIFEIqj+IoSLoo7nBgdWIcBQKo4FwUrQXB95YpIYL?=
 =?us-ascii?Q?JMlsnPhHXok5jHk/EorSukojMybu+40I63kkL0kzPwVg08LelXagxg3kPIiW?=
 =?us-ascii?Q?dh/fCV4s06/fHDpEdTRqFjE3P8b/WJipsaF3T0MNS+faEsZ/9KAsvoIU8qqd?=
 =?us-ascii?Q?KV7BmqYuYrrS4B4yx5l3bl97saXMjaZFN+Qa7mCEoeR32Lz9CLReVBdw7GkS?=
 =?us-ascii?Q?K/0q7uUTs2I2fNNkWxXSSDAUF4hyuyRyRIFDeyLffprA3YGqrhurqxBN6U13?=
 =?us-ascii?Q?n2ES8i0sMQyFp31vsQTrtrFr56+CyLUcDaFlStL7eXV7N0p0Ir2AFpio7V3e?=
 =?us-ascii?Q?QTBugq+iaHU5CKv2x1YnqcBQCTnKUqdbpI7yxBIVtuLIaRFp9ytPGbc1N84R?=
 =?us-ascii?Q?2zBdEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yU64SuCq93RjQ6ZRTNYDbqpGlsJdtggC1VmMWGplQwYoL0imSYcQoI8/NBpCCo3Wf5hKx5W9zIbOePPe0Kx3ggU0K0U/HA2HaJJIbaSxvzA1xdHz83Bz5C0mxaWGIiNZVWXyHxF9aWoX8ZJQFtEmawHo9hJq+AtcSxmDcmytq6Qnofa9tw967ePR1hy9iNSyGJcckb1xZh75soMsbcGbWFbPB3R1UfjYHcyFRA6rG/CWEAq6lkJFhfcqMfziOQPsb1BhN2qj7lFoGrnwXVRcy8JHBMFdHUb7jN8s2syMRSSpcNTJLVHuUbNeP3LhPOwSsjTg+4hUwRZ1L6cVOTZ/0jl0ZJj1crpij3aKnC2Py2dFjkm1Hs514rk6hJlVbV4/tawJ5x8l3rgyQZ1cajZJ2mBj2KodfVuDg+xf3t4STdJt18euQybOH6zxTEV6jP6m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 06:32:08.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2c62ce-5c47-4014-5aa6-08de6224ca3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
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

Protect GC registers in amdgpu_irq_disable_all() and amdgpu_fence_driver_hw_fini().

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e69ab8a923e3..095730c7ef8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3506,9 +3506,6 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
-
 	amdgpu_amdkfd_suspend(adev, true);
 	amdgpu_amdkfd_teardown_processes(adev);
 	amdgpu_userq_suspend(adev);
@@ -4904,6 +4901,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_virt_fini_data_exchange(adev);
 	}
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
 	if (adev->mode_info.mode_config_initialized) {
@@ -7362,6 +7362,9 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 	amdgpu_xcp_dev_unplug(adev);
 	drm_dev_unplug(ddev);
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	amdgpu_irq_disable_all(adev);
 
 	amdgpu_fence_driver_hw_fini(adev);
-- 
2.43.0

