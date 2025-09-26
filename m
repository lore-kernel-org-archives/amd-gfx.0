Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC79CCAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 06:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E51E10E2FC;
	Fri, 26 Sep 2025 06:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNQk3i2y";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A186E10E2FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 06:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgbSCHkf2mGM8yZsPxTSPiyem5pNGz28hwIgJlQ4sK5h2A24G8yeZljt1ZtDwzmA5xt3yYfWs7umk70tmPVRALd1COyw6yOJKf5WMVX8FIx3nFpd7Ib5ORWf5J+VwD4azfjANqZrIQ1ZSWEoaP4ltmdBYJcnCmGU4XKaG8O+NcelLZd/DD7+fJnx315om9dM5KI7T+oPHNLaCi6Hr3XlNQnaCx/pt0ZoDT3uSNzgc6uGpE+AYyPLfEWdPMQtBmW5IlKudVPtAMVI3v6ts9tyD1Bf1HiI1IBHuCsZFDfnlBil65xec8clIpv2Un2/s/Sza7BPhHByDz2oAmTy96aVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGSsAH0AgXIZ4ERq3pgUvXuj65LRwEBPNGMv9kQZJow=;
 b=F0YT4L6NBaxBbHvOcNcRafZq6LAdMp+LGnqu2mZVqffxI5zAzby/PW1eqAG9RsH7VQvM6b/QIzvOWGQkOVuk6PdwwLnLYAYjP3qu/4HwH5KEM7C3Va+sPc9jtsw/DOIIyL++BXOUj4VVdIRiu1miVJ3YGGVrLTOoLNq26+U3qk6/yX/UC1oFNNSmNz4q6k9gdQj8Bo/lWaXDuYq7Z1etOneOKe2lDwNqG2kZUKAm9Hpdeh43wwuL2IP4HmpuO/EIUAwzqKJBYG+FjfA1yr6rebVTM9NpAu/piVAJIdlq3JNzI5iIbRiKoPNDRRXSfgT/oHVqxcgwIuKiGIhuonS9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGSsAH0AgXIZ4ERq3pgUvXuj65LRwEBPNGMv9kQZJow=;
 b=pNQk3i2yT3yjI5ZvSKpCWhXNyy7iY+Ko/7AbJNZIPNp3JKOwIL8tNmjm0INRD6p0T0DvzhaVlqXSBludkkQHGNtsHcTMcgSfFAuZn8ghvEmPQHHzjapmj1MHlk0dwaDBnZSb2TGwNZkTIs9gM42sR2V6Q8ksqpTfUk9Iki3SpcA=
Received: from BYAPR06CA0066.namprd06.prod.outlook.com (2603:10b6:a03:14b::43)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 06:33:58 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::34) by BYAPR06CA0066.outlook.office365.com
 (2603:10b6:a03:14b::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 06:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 06:33:57 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 23:33:55 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Date: Fri, 26 Sep 2025 14:33:45 +0800
Message-ID: <20250926063345.1131635-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2f51e8-3a81-4e5f-dcc1-08ddfcc6ac1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KE/zPkeAFRobGnphzDVUbLbpi78XWAGNM+kIvVXopk5rMtuLmQQKQljKjvV/?=
 =?us-ascii?Q?UdL/GvtL8tmVi6CqjB/M3jpTqbaPCryWPNSvKb8XJsa+g60MJvB5U1aBoc4E?=
 =?us-ascii?Q?sXz0yJx6GdAFDaWLL67H6p6nZ3KNz6hlJH8Vccf433yf5q0OWhCGWaAz2Y9z?=
 =?us-ascii?Q?pMbG0WhCQixpRD8EONuqvfrp/1C4n8D9qXjsTWVRW54CUn78/5Y/ATsRX9aa?=
 =?us-ascii?Q?uhMvJV9jiVWbPpTOo5O0ArgUUVJRVCG6PX0SZDLynv/LYxhNMNjOK+lglgb2?=
 =?us-ascii?Q?f8H3F0yMhkQKRELfzq56Sljwc0Aeao7CCZOu+ORfXpjWd2TbY81ajMfXOGcI?=
 =?us-ascii?Q?df3M/ObmDTROEgPGbe1fCLhentsupZZSCJFC54SOscqG02g04WRyDv7+POW9?=
 =?us-ascii?Q?JVqUwKORJAgo1ku6+7kihM76Y2qzrSkzK0S6rgeQCG0z8kh5KETU5Vo68aO/?=
 =?us-ascii?Q?LgTNuTx/AFODfbaY4svroVHz6IAlRnwiQSqUqtrK8T7nvZbpbhuPk0fG+PyG?=
 =?us-ascii?Q?fxPrUUBUtLegwZKos8AFVjbmisntU5CqKdhwojazda/uj8an+8jkyq/iatTd?=
 =?us-ascii?Q?GpIIhYhk/2y06exvTlxZnuPt8lSV+AJHGCRj/V7wldFFjdFRwjdWeEV/NEUj?=
 =?us-ascii?Q?WbAWd3zw7bYeK1DVcJWQ+vC94oLI/w6BqDJNCgITxBUBy+IDWonrNznbXknL?=
 =?us-ascii?Q?NgJjJfGXkTR4hYsaoNc22+s2Hd42F8t2decXLzWK9eEPvnZXIiauqJkpb3ZC?=
 =?us-ascii?Q?dmEtPIWbr87wI55VBav2iZZAApbCTY26VpM2w88/bIV1GxQYzCPabHe7MBXz?=
 =?us-ascii?Q?tD8GB8xJT6hLW6ctrveow6mfvlwVcOlraZ41Cm+1MJNryj+9Lfq64JUCVHYl?=
 =?us-ascii?Q?a11Fp7e1s43S+j5ix2kfBu7NWV+rf8IQyT1LYlpsGRmdhsMWbtZZyvc8wWsM?=
 =?us-ascii?Q?rwW7tpLQ6QDFmqUHuqM8nTIbGEfAW9TsZqZfinVykcYYvB5N1qst9X3LlUGl?=
 =?us-ascii?Q?esX1ymosL4WY/mB13tZ90k8s4Mpx/YcSZVtrUjlndzzdiGEuvM9Awgiv2ida?=
 =?us-ascii?Q?HibFKKTrS+2qWhA2SE/vInN5Y6e0hcSrJ0WukZkEmivZ7fAQGYxV40aNFUZQ?=
 =?us-ascii?Q?jgoUhDBv9EtIuAC4n44x8o061/OAQ/ZPpGRyOWUDndMDa2ZvnDm0qg6YgNJ9?=
 =?us-ascii?Q?E5GJt/PbTI6tgl7rHpWuAYrhDO5npbzhxoNSqLZSVetQNGhDcxLq2azf7xWL?=
 =?us-ascii?Q?iB/M3mrXWK+r6su1nTaO52lRbaO/L5FzwiKrDYKXOTha8atdTVgZdoa+CTIV?=
 =?us-ascii?Q?e0XtYk684DaTGEhbO9qhxK4jJgPfd+apOOTwwkhtqby+dr0pmgHF+gFk+cgQ?=
 =?us-ascii?Q?Byiee2M3Y+mkxI4rrPf6Rrz/bo7UrYpnJ6b9/gAnAGFDtDQ++XB3rTwMYW+0?=
 =?us-ascii?Q?SctwS2k7aIwmgYVgy/APUUWHNTE9Kz6gY8QJg1jmyNGZnrioDypNPqjq5CKA?=
 =?us-ascii?Q?i82kc1r6NvSJs4lq6C2AXHdCawB5rWwN+UEm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 06:33:57.6494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2f51e8-3a81-4e5f-dcc1-08ddfcc6ac1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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

Use the uevent mechanism to expose the GPU reset state,
so that the system tool can more accurately monitor the device reset status.

example:
$ sudo cat /sys/kernel/debug/dri/<minor>/amdgpu_gpu_recover

KERNEL[172.053149] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0 (pci)
ACTION=change
DEVPATH=/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0
SUBSYSTEM=pci
RESET=1
DRIVER=amdgpu
PCI_CLASS=30000
PCI_ID=1002:73BF
PCI_SUBSYS_ID=1002:0E3A
PCI_SLOT_NAME=0000:05:00.0
MODALIAS=pci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00
SEQNUM=6235

KERNEL[173.137681] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0 (pci)
ACTION=change
DEVPATH=/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0
SUBSYSTEM=pci
RESET=0
DRIVER=amdgpu
PCI_CLASS=30000
PCI_ID=1002:73BF
PCI_SUBSYS_ID=1002:0E3A
PCI_SLOT_NAME=0000:05:00.0
MODALIAS=pci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00
SEQNUM=6236

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..73c946d9cbe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1805,4 +1805,7 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
 			   uint64_t uid);
 uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
 			       enum amdgpu_uid_type type, uint8_t inst);
+
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a77000c2e0bb..300cc22dad91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6318,6 +6318,7 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
+		amdgpu_device_uevent_reset(tmp_adev, false);
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
 		/*TODO Should we stop ?*/
 		if (r) {
@@ -6362,6 +6363,8 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 		 * in before drm_sched_start.
 		 */
 		amdgpu_device_stop_pending_resets(tmp_adev);
+
+		amdgpu_device_uevent_reset(tmp_adev, true);
 	}
 
 	return r;
@@ -7669,3 +7672,39 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
 
 	return uid_info->uid[type][inst];
 }
+
+__printf(3, 4)
+static int amdgpu_device_uevent_emit(struct amdgpu_device *adev, enum kobject_action action,
+				     char *fmt, ...)
+{
+	struct kobject *kobj = &adev->dev->kobj;
+	char *uevent_env[2], *tmp;
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	tmp = kvasprintf(GFP_KERNEL, fmt, ap);
+	va_end(ap);
+
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	uevent_env[0] = tmp;
+	uevent_env[1] = NULL;
+
+	ret = kobject_uevent_env(kobj, action, uevent_env);
+
+	kvfree(tmp);
+
+out:
+	return ret;
+}
+
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done)
+{
+	int val = done ? 0 : 1;
+
+	return amdgpu_device_uevent_emit(adev, KOBJ_CHANGE, "RESET=%d", val);
+}
-- 
2.34.1

