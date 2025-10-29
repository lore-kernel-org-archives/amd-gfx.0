Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B35CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E9610E75E;
	Wed, 29 Oct 2025 08:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HHrrb9Jv";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013039.outbound.protection.outlook.com
 [40.93.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92AF10E75E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyvrnLBhvG5eQM6Z5s3CB8jnSVgjCZQvPIB6eJgh2SPV/faBvuQ2J2CEgkzjUrqbnOAHtXGcF/SNeVxAxLY4R5w30TCbIDYskZL3gv/BzFFj39K/DTUO2cGbLkLDXDqs6ijP8Np02CAhJrkLLKl9/lIhFxywRIOBZbNCfQ6O8L6i/lwGcXm4vBl169SMVF7UQLcdAs8GWo0X4baDanRaoXkkb1BmSp1+hQK/uS8iBTxxrWrJ+6Ch5YsafDggXh+hnO0fzgb1fyqY09l/Vmww3hN0O4mume/yhgFcyv8j2dIXvadXe0xkQlevMB1Uj0Bs1qe62zZ7wLhve4VGsZ63gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgD70ANQXj5Cs//YYI0JtbLmN8fvyT2Wx2JbgW2B7yI=;
 b=TukzT91fbdsKKc+XErhNiueGkblEqQU34k7Cvt/o/pakBIu6pu4yABkfX5xLU876bXIUOlgeViZoOxYylk0djzBT9e0jz2fZGvVtSTRSXJvB7w/M3LEjrqIHzGFWv9Hih+YYdfdqOi4YEnE/wHfqYmTnDLYuWHjC46eYd3HcZtbXWDLoKoy1oO4N1ILfx+eONtDyhyODpnH6d+SHwjYau9hoQW83upETG+U72MqJkoZHnBmq+2Cx5QvWqOL5lqgYGMCILod0pl8moQWoIWiVKVxXDmavrEwycnlogXl5C0llR9FhvbXtUbjRPggOKra6g+nHUA3QJOqLX/9T0qo7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgD70ANQXj5Cs//YYI0JtbLmN8fvyT2Wx2JbgW2B7yI=;
 b=HHrrb9JviGXYTBPH4ZCFlP58Jzs1/B0vhToySFQg5g3J/A6fsvtNPUKOWK060mxU0gBXrQ4F+Lkn0+7SuyvkFb0uYIbIANw+tIWxSCZMxWlawk3qDfPi26Kn4H4wfER81B46XvMrCY/lu/CsPyk9NZMyQ5PkJUOlmmAC/rkoDio=
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:48:17 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::1a) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:17 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:16 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: add function to check if pmfw eeprom is
 supported
Date: Wed, 29 Oct 2025 16:47:46 +0800
Message-ID: <20251029084751.1701305-5-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029084751.1701305-1-ganglxie@amd.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 046d6d61-36b0-4b18-09fc-08de16c7e7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dZ3PG54b6h08y+exeolssUbUTmcGFvZ35cZeaoC6zfmhm3R0p3PHD5GK+et8?=
 =?us-ascii?Q?DEYbV5QzvDe2wUbWSnLKo7xKzBiBJfy5RqFqN0T+Y9e+W/5oBFuZwQKav4nA?=
 =?us-ascii?Q?8K4IClDDvVHcAeQn8aeLsTiOwo6tuiA7RXrhq4ki63s5m1dxApDKKSPu8G2T?=
 =?us-ascii?Q?nBMZaHZ2czGdGoUa6Az9b49y9c8CHH2DNmdP6OzyNt8k+GW4n5Mf8oRBiCDK?=
 =?us-ascii?Q?eel4XQNP2yGUaSrNLcOuEDMP/oGvxSM5Nsvo3pDuco96EptRdsVrIP2KsXh4?=
 =?us-ascii?Q?dtknKTwvL2BIOkvIkEW/UYVVQ7Jw9+MER1QB3xHlBmJz8t4M9YnXrGqQoOR9?=
 =?us-ascii?Q?JJR2DYbxcrRk/Yc0H70cKuwLRb/i0sm0uYSX4+58zNjBuZ2Oov17rzQ8j8wk?=
 =?us-ascii?Q?HEddKNQN273AdpY2Bfn2Qwe9GBYiYm4ITWTU2ce/tPa1tS1gwdQCk3rM42CB?=
 =?us-ascii?Q?+fjBrWJo0lqrk4iCu6/85kezt6iUuloqzv5sB0fP+i5FLagF/N9N0gH44iNu?=
 =?us-ascii?Q?PWjzU+WNpKttGft1SOAUiTpzag4PKMRVwTYbA2mzJ6MwCVK8Rvfrwp7AEqGk?=
 =?us-ascii?Q?wia+Exu4SRCMraJ91anUlKzfCYRb/yatrwEB5sHwdFBA3Y9nUmsiwmv2fluS?=
 =?us-ascii?Q?pYgBsnmnmHG9PkTHG8VQlUhscKBhTNvGoM4FaaOXBHJEgone58TLdRM2v/c6?=
 =?us-ascii?Q?1owP9TL2sOuyfENAhXGvapcvKkwKOuTsCMmp5it8S7da1vfn+bADnoCxAw/C?=
 =?us-ascii?Q?wLEzoAzY3zWoETMJJIYC/TuI2UCZC9usLX7JyszMSw2hxxh2RfW1NpBD5ep+?=
 =?us-ascii?Q?9YMe1fQYX3IqS/6t0Z+W2nP65uJWmzHBeb5aMONfz2FkXPIXcrQ3auympcyn?=
 =?us-ascii?Q?XEA7W7gbpZPHKEZYXcTBVABZ0YSYlHjQRJZ48TzFrX+ufvsu3Rq4vK/hNrqm?=
 =?us-ascii?Q?ZOT2b/yUjzk5ypJkzzVRB6HffRWlE6pYBahTRPZxjmy5kx+StH97Uo0pteVf?=
 =?us-ascii?Q?L+rsrLmM6+kwzKm+fT8pYadGqSQgRtBeSrXBisC15UzLh/Hm0yehjnAz7EZF?=
 =?us-ascii?Q?vHggCX418irpP9qRUOUwglrpJbZwat2VSY8mzvZyFetDAoWJsnTxHJAKmEX0?=
 =?us-ascii?Q?9Df1R2a5xtiTQTu0QpF2BqqOkitN3wVWMid2VHWtB9PWYFWKhhfYtyEXpdWw?=
 =?us-ascii?Q?DpNvDPtWetibbbMTGxjDYWTQH5oNsVY3mUV1/ShhFx3/Lo+n6D1NiY9Au6eH?=
 =?us-ascii?Q?8REGbcJwbbjX5/cM5T/gFpOzpaJorbmtJyC31zMrP/NUooAk/S9MeBRqroef?=
 =?us-ascii?Q?hyP5tPUAqXIRm39X5BTxKAZOQxOw3XlGhvco82VOmEmbBIkR/FM11WvzUWUK?=
 =?us-ascii?Q?J4XipzfTFbjlDCYpE76KI3YMVbne385eK6DuigF+ASt+hIttIe1BeBvKhzEr?=
 =?us-ascii?Q?X/lTTWALWDJ5+wU8BZoAI29CmmYUMqiRBKwbZLopFScfh9t8YGabAv6Rg9al?=
 =?us-ascii?Q?1gsKIZtqO5nbDjUQx3EJ05fXl4y2z/GKLQt8cevIXRL5ByHcgmFQ3rT+LUdh?=
 =?us-ascii?Q?s9BMTXfXT1SthfGMe3Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:17.5719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046d6d61-36b0-4b18-09fc-08de16c7e7c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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

add function to check if pmfw is supported, skip eeprom
check and recover when pmfw eeprom is supported

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 46 ++++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 719991e99161..e84887fe29a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3767,6 +3767,8 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		return 0;
 
 	control = &con->eeprom_control;
+	con->ras_smu_drv = amdgpu_dpm_get_ras_smu_driver(adev);
+
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 5a7bf0661dbf..c38d88a60c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1545,7 +1545,8 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 	struct amdgpu_ras_eeprom_control *control;
 	int res;
 
-	if (!__is_ras_eeprom_supported(adev) || !ras)
+	if (!__is_ras_eeprom_supported(adev) || !ras ||
+	    amdgpu_ras_smu_eeprom_supported(adev))
 		return;
 	control = &ras->eeprom_control;
 	if (!control->is_eeprom_valid)
@@ -1565,4 +1566,45 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 		control->is_eeprom_valid = false;
 	}
 	return;
-}
\ No newline at end of file
+}
+
+static const struct ras_smu_drv *amdgpu_ras_get_smu_ras_drv(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (!ras)
+		return NULL;
+
+	return ras->ras_smu_drv;
+}
+
+static uint64_t amdgpu_ras_smu_get_feature_flags(struct amdgpu_device *adev)
+{
+	const struct ras_smu_drv *ras_smu_drv = amdgpu_ras_get_smu_ras_drv(adev);
+	uint64_t flags = 0ULL;
+
+	if (!ras_smu_drv)
+		goto out;
+
+	if (ras_smu_drv->ras_smu_feature_flags)
+		ras_smu_drv->ras_smu_feature_flags(adev, &flags);
+
+out:
+	return flags;
+}
+
+bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+	uint64_t flags = 0ULL;
+
+	if (!__is_ras_eeprom_supported(adev) || !smu_ras_drv)
+		return false;
+
+	if (!smu_ras_drv->smu_eeprom_funcs)
+		return false;
+
+	flags = amdgpu_ras_smu_get_feature_flags(adev);
+
+	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index ebfca4cb5688..feff46b22b6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -163,6 +163,8 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
 void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
+bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

