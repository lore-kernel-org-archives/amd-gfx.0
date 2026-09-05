Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B928C624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 04:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8908310E042;
	Sat,  5 Sep 2026 04:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tee3H1W3";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A19E10E238
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 04:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt3qOfpaRBh1BamydTCpD+0IkjLyNvNdkog+wQU3Gr/boN/9ocLP23fA/Jdb2qRCYFJeSm/YxcalWhIBiprYQr5jxn+BZrYEHAWyex4zwE4JNRD56Re0L2LshrIWTCV1agh9Fao/esN4r6xWUWd/5XZlOclhFebKdU18Hx+eHEVVvAlhH0sfPeAYPAzARV8xPr7BrAYTytRNCrgVoaO6/S9qqgN5zXyVvZqn+z+WDH0oedl3EJGuVU2+xbbO2SE1fzHMBpjWYhRlqNdWQKbMfJ57CxmFQZ8skqFvOYF3NaSwTvaKKlmGl3Fz1g5NtOoK7SE79YkG6+F0MPSQs0kYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfTtrh4/xzqGNsHycXWLqn+avVLCXHqQLwyrnbQegr0=;
 b=yawoHmI00iDmgRjR06XN6f/i8UvBplgJBDmzNOGb/A3Y5G+RwJl6x2+qCW1OCYX1xM8bLTw6Kd7wmyzTM897DM+s92Tp6+PGiHJ4rZotKm21pRqxFC1r/wSZdF723rUJu6MJGsJB+KrQ/o5agYRnnf77spPchuD/KeXTPsOEPsWBRpTPBgXPaoSY4hAZfzWzVhmg2RzKdfFN/ZxGLzRt+j3t5tZSDfx/AOm+9siX/4bv65Kj2zx0efxtBYp+si+XryPsDGiI0iZ0YqI/aXHDQtdNSFnc0TBMa5NDXJtNVex07yc08TvQPhLgBo4qB45gy+L1Q1NmEajaUmse5ndOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfTtrh4/xzqGNsHycXWLqn+avVLCXHqQLwyrnbQegr0=;
 b=Tee3H1W3swvNWBuem30iPLzIO2aBiY/XlV832zgFUFt1RkzAUCLo9LschaNG9BsIApir5RcxGptUm7Y/HzvEaZUyNip67iu6JMhhf9fL8UMtMu9MDwV0WD3P859LC4WbKg1fYhprISPwOymdMdNeIHUU8XpnLsa5hKojYMQaPsQ=
Received: from BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::16)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 04:30:56 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::54) by BL1P222CA0011.outlook.office365.com
 (2603:10b6:208:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Sat, 5
 Sep 2026 04:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 04:30:56 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 23:30:54 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: skip queue restore while the device is
 resetting
Date: Sat, 5 Sep 2026 12:30:31 +0800
Message-ID: <20260905043031.1015676-3-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905043031.1015676-1-xiang.liu@amd.com>
References: <20260905043031.1015676-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: daaf39b5-73e7-4c96-6c1b-08df0b067a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y2Uh94r7Ir4+MdKrmt4DFW5DmHq4aqg69O/TSiaaMLe01mC4f3S+hD/7XtjL9H/wkHxJpUTScBV0KcFayBRX7MOtGJlpcOlcVCh2RGmFgBxvD4korGhMI3PVsGW//yez3T6i1vQ8wwcb+JG+plbZxjxWvuOTfawhJ3XzWl27VI+MqmHMXcHkN5lhzSlLUQJeeEMWz4NlrpQu3voaOwYMAi1tyPdFg2d+4FKYdsjVYqsyEznE1zFefPf1DvVTNo+Cwtk0f9HK/zc7DKR0IO+gSqBXtKgXX9Fs1bjFkRmongX7tulxgPfCIPTnHbaHmNeK7Wg+QRPRsnH80y+U35Q8ZS7lSF4QjdkZy/xeIIpFf5TqlGPqE1M4ZC+ICwtPcsYQ/oKGMutvb9NfHU+FJWT3Yn0M/ngrGazy7gTTAFHbrFMXHINDgy8PXMEnthWgr5ibzfQhR98x1WmG8IelhHP1ntgsnvSBpkg0zNMKDGTEEB+9gDWB2e+/H+bQohwjqWWi4R+OUEb1fU7dyfRakNegHcUmdYmcJp2KrHt1cqj6onIjNbpdwgExCgEodfQG97pPHVX7Cdem4/y4FuRf1tgx4kNFQ0NJUtqAKs6QR4AB4dYGdl6qmPvj7ZcFoCca6N2Q+AthBkj3PZVd6iX6SCeIVmKEiA9yTiatbykHMt61f4ZFsyGNj02OwfYSTx4C26qFN119NaxLOhMULsxhfal/Qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I1iLxWTEZANsR/X4WsHFDWu6ztHlJRZ7G5RtbnPd2zxgZCuggAUWJJrRmourBUPVKxGSjOjegG+sr+Axz1nJmAjfCHZS0ve1PBRT17GwbJE7R6PaUzdRt5EJ822jA6agTaixLim+cvV3/En/01vPp3Jd8Y1lPWpPwbiNq3F4HBGtZtKUFiJjWOzGA9DZDGZUZnETIoAIVOgj0WQP8f7+huVZLKkWV1ywMRgLIvJJDkIptPq4ieB/C0A5ij2VvRLoRKxxW8JjDdnie6LjLtz7nP6jSucrImoJJhvHib9ZupHS3M+BBg/3p0a5HTAyJRYcjsSktitTX642jFxW2MVefuxiD/D0fIIFZeRGpYH7LL/nE942n5P3jEiC5m8fs9zIUlKrzFmosvB6YQTgl7ywz+bXfZdWOXy+LsO8XAU9XirLuuDhU/IEuBMNEscmdjl/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 04:30:56.3464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daaf39b5-73e7-4c96-6c1b-08df0b067a90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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

restore_process_queues_cpsch() decrements qpd->evicted to zero and maps
the queues back, but a reset in flight is about to drop the mappings
those queues are built against. The restore then publishes queues that
point at state the reset discards.

Bail out with -EAGAIN while the device is fenced or resetting, leaving
the eviction reference held so the restore is retried once the device is
back.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0c402a685b61..0d69d261ea1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1636,6 +1636,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		goto out;
 	}
 
+	/* A restore now would map queues against mappings the reset will drop */
+	if (amdgpu_amdkfd_is_fed(dqm->dev->adev) ||
+	    amdgpu_in_reset(dqm->dev->adev)) {
+		retval = -EAGAIN;
+		goto out;
+	}
+
 	/* The debugger creates processes that temporarily have not acquired
 	 * all VMs for all devices and has no VMs itself.
 	 * Skip queue restore on process restore.
-- 
2.34.1

