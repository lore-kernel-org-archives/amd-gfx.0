Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD14CDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 04:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2566710E055;
	Wed, 24 Jun 2026 04:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYKUoA3L";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E670810E055
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 04:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INAyFs0juOJw3EjzxpDBFsemQfo94JCGkeK3YFABrllULrKdCsTd90ikS3Ee2UuyBocBQuuKl3ulii3uBlEoENqD/d57dct6jOzijGZmCgata8NL1HDZBuUVY3Ev34s+OtB0kCORG7Ox1VACGPRWD6Syh6AS6G17Ev7F+4URCPEpXkH9hxCORCi1CSPECrFP+UHjKk4EE4sOBp+kQszNCuMCcwMQzlyVMfp5Au0F1Zsq4W8ypPquE8JXXuRG5y6hWkqOV+mvcg0XpFOuSc5JcMh8vYnppH5OC0aTs+HxTKybE4/Rm0lAAk4XOKW7/PBA8V7n5Irz9F4VyOqHl74+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oBgArc+zdixE5cBheS/klBWxjy3PQDwRkxhreUb3sA=;
 b=eEl/iQnoygX+mpKPVScxVqRQ2MmRRns+w7DVikL83ioCvfqMkwJPwk1UPNXrPYANoASlkhYIkVeenko4Yu4UbkIE2EZujur2e5H+E77E7X6tpOLoAHKWP6p5t0p8hfA8uTih2FlPi1zvI7nKwF2hs8Cc9WDmuXPuiJZ/b1x1fgNxVFdaKXgLhp5h2P+jKsXK7u4WNcc8crb8/Sj31vk2gI5uQODLoZT9XjfVqYEGzeVuXGcyY5gdu8a1vSpgGvnXdbY/FkyHyaRD2ofgDtUoOL0Z1rv3eWo5/YN49+XQeb9cHUeQCA99C24MIP8xnchrWTuwRk55ABV8ww3dj7HwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oBgArc+zdixE5cBheS/klBWxjy3PQDwRkxhreUb3sA=;
 b=RYKUoA3LAcgXK5llmoLHCrLaeViB84ldzXBipcp5cowLDuSaKcDBNZaA0NuTOaplCm2XiPHBs6t+SZbXOeXr/GjnWHAKKmJUTo3luoAnP/Q0ZH1DX0t3QxGcWxGpfKAuN58IQY3g0w/ucXI1//fTh1bVO7taxPofaIJsq0QaB+c=
Received: from CY5PR15CA0127.namprd15.prod.outlook.com (2603:10b6:930:68::10)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 24 Jun
 2026 04:49:13 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:930:68:cafe::48) by CY5PR15CA0127.outlook.office365.com
 (2603:10b6:930:68::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 04:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 04:49:12 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 23:49:10 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop and
 OOB read
Date: Wed, 24 Jun 2026 12:48:57 +0800
Message-ID: <20260624044857.101938-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 89298a85-a212-4d21-8504-08ded1abefd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: SYEonM6pbJYPxLzB1JFGpGiBCK9aqYXfPLYPtF8+zImBzcsiREa7KgubxPDNY/2iIB+np/0AWpAw5axneYgQ5p0rKU8ndMSargonnb6iKiAeKQWqHvDP2W8wWFOX9i39CbZLv3ThZwCRD3IELJ62s8KK1jh544r71NtjxTf+xSAazY6jVynUgefs3a4VnINqpcv0n9a7qdPLvYtFp0ewQuG4Ai1UIHHpfD1WK2STG52iGILbpdSgFGgbx0nNDgJItb3YnL2Lx3nNZ2nz/yAq6ReznvuCJiXuxxZ8pNup2erPOdYaFID3ytatJ/tLWP37VOcIUV+iFcuOQ8+09QOh4AUcdD8bvMAKuTAwmEFJCuYSeFkyNnqTeiZlRBzfyQPwbeW83Vhgd398TRNCGXo+ocbwf2xNYwNl+SoPUeI5MtWoHdfJuM/8YfEQr2+n/05f3jFNZhwvUi9OVnLumQuaCK2mvBnj4JzFuU3e4aRHu2mJcpsXMK0ZnB1n+4WHpHOQbiX0fKt6lsJi09e0rVerNsaK698HZVD5shvXJKfW0QRzD+Fj+in8s3dwzS6eUsBP/vVdMwyTpM3YBKa6e7S0GGcvp1B4glBea+YRANZL2Omvdqc1v0GxtvQSpHKzP4bmm35pLFgAphTev2O5x0gZDh1D1Osu5Paj+5sc/+Co4EdpnkVkV33bgrK/e3RZ2Y6U52cS674wqnrCPzBskPlO1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OA8yaB6pNI9uTeuOvUE+YR+tTzAm5KxcpkbhyOfLbGhRMRx6HdZUhYO+Mc62h1jqNjJYsmn9nARs3ysPVqEWlWp9MIOipqJj5okSvKPNW1RhkgP93PcS8KgjFNeZO+olQS8U0OeZ9aExydAQqJ45I1d8ADRxNqOuKa+ctuaRqh2SSus5XdbO6oOGsZo9mrzYpu8GNAAqvRb6kyapt/Hg9g19YufKjQjDdmB7HvpdfSxzPq6yhHSVeEexFF8bVN8FQ3n96IfSsZ3E7kyu5d0XryfHveL1m81GUm00gly9ddBXwpJHyXvTPLVTZiQco/THfjtfegjzudp+gkYUrzi/0DMRPlvMGi0Isd+jRak0i5p1Nn80SFOCVwVZKX6QOV9neQ1r4/FdhCAF+pWDcNe6ivkgkYI1kFxeRcvmkzPcs1yxn/oFnnaHgfeoi30BQiFo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 04:49:12.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89298a85-a212-4d21-8504-08ded1abefd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092
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

Reject voltage objects whose usSize is smaller than the header or would
advance the cursor past the table end, preventing an infinite loop or
heap OOB read when the VBIOS supplies a malformed VoltageObjectInfo table.

Fixes: c82baa281843 ("drm/amd/powerplay: add Tonga dpm support (v3)")
Fixes: 0d2c7569e196 ("drm/amdgpu: add new atomfirmware based helpers for powerplay")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 10 ++++++++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c | 11 ++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index ce166a7f8e42..1fff7567bca2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -268,15 +268,21 @@ static const ATOM_VOLTAGE_OBJECT_V3 *atomctrl_lookup_voltage_type_v3(
 	unsigned int offset = offsetof(ATOM_VOLTAGE_OBJECT_INFO_V3_1, asVoltageObj[0]);
 	uint8_t *start = (uint8_t *)voltage_object_info_table;
 
-	while (offset < size) {
+	while (offset + sizeof(ATOM_VOLTAGE_OBJECT_HEADER_V3) <= size) {
 		const ATOM_VOLTAGE_OBJECT_V3 *voltage_object =
 			(const ATOM_VOLTAGE_OBJECT_V3 *)(start + offset);
+		u16 obj_size;
+
+		obj_size = le16_to_cpu(voltage_object->asGpioVoltageObj.sHeader.usSize);
+		if (obj_size < sizeof(voltage_object->asGpioVoltageObj.sHeader) ||
+		    offset + obj_size > size)
+			break;
 
 		if (voltage_type == voltage_object->asGpioVoltageObj.sHeader.ucVoltageType &&
 			voltage_mode == voltage_object->asGpioVoltageObj.sHeader.ucVoltageMode)
 			return voltage_object;
 
-		offset += le16_to_cpu(voltage_object->asGpioVoltageObj.sHeader.usSize);
+		offset += obj_size;
 	}
 
 	return NULL;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
index 6120f14caab0..69aee8661d1e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
@@ -36,16 +36,21 @@ static const union atom_voltage_object_v4 *pp_atomfwctrl_lookup_voltage_type_v4(
 			offsetof(struct atom_voltage_objects_info_v4_1, voltage_object[0]);
 	unsigned long start = (unsigned long)voltage_object_info_table;
 
-	while (offset < size) {
+	while (offset + sizeof(struct atom_voltage_object_header_v4) <= size) {
 		const union atom_voltage_object_v4 *voltage_object =
 			(const union atom_voltage_object_v4 *)(start + offset);
+		u16 obj_size;
+
+		obj_size = le16_to_cpu(voltage_object->gpio_voltage_obj.header.object_size);
+		if (obj_size < sizeof(voltage_object->gpio_voltage_obj.header) ||
+		    offset + obj_size > size)
+			break;
 
 		if (voltage_type == voltage_object->gpio_voltage_obj.header.voltage_type &&
 		    voltage_mode == voltage_object->gpio_voltage_obj.header.voltage_mode)
 			return voltage_object;
 
-		offset += le16_to_cpu(voltage_object->gpio_voltage_obj.header.object_size);
-
+		offset += obj_size;
 	}
 
 	return NULL;
-- 
2.46.0

