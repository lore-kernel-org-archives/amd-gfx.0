Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB711D73EB4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7232C10E352;
	Fri, 30 Jan 2026 02:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nnaqV6tC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843C310E355
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTCYJsywDLd+99KBnLnlZiDULYBsSt+s+KxDLwaJyWkGYhWy+ET8UYxLy7O7saTOD+YB84IMJh4CDBKDoU+X8rM+GyLB6z+GuwmePDTb/gdkNjF+wixgyLLNQjOqudY8faiC4ChHc3ZDI0/gcxFmcc8fMmZh/pH4qiKvJJBjn5HlzN1KeiUtpXl14+huLszvw2ylrD5xqck4Kb0D5FSwxOCFH/5OKBcsKsm0+auKH2BKF5xQmcwXb4AqQKK9Mh5IUjW7BUvBjMxPPgfk40HV5tHRxVGrYhp0wRYROf/h+seittDkA/Ewqw5AjpRJ7+s9MQGK0UfgVbQqMqkbiWqkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO4Z25MuqUxjpsJhmSGvHvbNgUFWfqEKF3yHXVF7JEU=;
 b=ocoxXMpOaQ0ZPrCwNeflffwJT/dlXXyRnoLjXc9ejdWsN/DBTDwpUCNSev8+KH1A6+70Qzzl9Pt3skNiBKuMV48yXyoXgUv6FjdyFnuhFZyCN5hgE0QZhN88LPLD9n0TowB2KW06yW/zr2iSC7xW7Ux4VJM7FKQQFay/NOioYsgkl9XYZaDrjK+m7S8VVDsSqGnkAdR7fhnvqGsuNNIQXpEVHtVgkgDIfJEU7qXdJS8kUDZN7Ug4l7km70V0gNZf3boM8OugInLbOpPyYRyT7tqw+jkkfQI6vU4R5IdbvrXvCJ9/FT48sBpBVLJjbn8sH5POeotV35q5OwkBNg4JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO4Z25MuqUxjpsJhmSGvHvbNgUFWfqEKF3yHXVF7JEU=;
 b=nnaqV6tCehKzoemLdN5p8+T+X26ocCqRcCEhDbzaxr+pd7wZeC80JRuJa91y8Pf8/olLgD0ckVlzz24useNN97erJtT3lZ22Du/7rqv88bFipWYHkJ7yliBcmadMy1BXL59m4PDhQHi3ftMF/9rhY51C0jOOAD4d0pQdvMH28uE=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 02:30:32 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::97) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 02:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:31 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:29 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 07/14] drm/amd/ras: add check safety watermark func for pmfw
 eeprom
Date: Fri, 30 Jan 2026 10:29:43 +0800
Message-ID: <20260130022950.1160058-7-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 62091463-73f7-4ae9-bd48-08de5fa78a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTq6+iWs5ssW+mVY2A3+1KGx8veL1+mOMBNwjkrnt8cvSAgZGumeaEQ7jakt?=
 =?us-ascii?Q?x/lYMfquIC53fP/XxklR3Mw917OYGhR81vxTEwNwYaRFZEPPKKXWO8BrAn0Y?=
 =?us-ascii?Q?li60zj6XdTzeeXkCxPnsaqmgwsp2bfI9M2Xr1Lo2XpMlTfeKV2ZWwSm51c0n?=
 =?us-ascii?Q?wbVvfoKxwpXlT/m+w4DX3wE+GOC+c8HjCBNQx2PQHLOUgDqmkB8dfn3vrfwL?=
 =?us-ascii?Q?eCB0q3RNxuLsQptQM4NJ8WuBaq7daiO2w2GV2gRv+L99qWdQX8csXA60U2zI?=
 =?us-ascii?Q?LDKalOAPkW7Xipve2Wvndmrt6hhJ3uEcMuuSvUNchtKkEO0OiDOzSBmhCW5W?=
 =?us-ascii?Q?EjGrd+KsC1BWGnFbNum4sXs3pxroWU/BvsfAkFKleFqg9cUjSveRJNyQISJ6?=
 =?us-ascii?Q?+3noiNzlH4vCdo//BnFqKR0zd4fBIMCOUTFFbGvKkAs75eL8uDKjs/AmRIuR?=
 =?us-ascii?Q?6ohkv3nDAND0jDvdhfondR6kN+FGrisN2cHa831f4himjUp/Ul/i7AshHV0D?=
 =?us-ascii?Q?eoOSnRsaI6J++Bm633vADxqcC5HvSanNA+I+bGPWdfUNx9+7IuDy8G0iXDfj?=
 =?us-ascii?Q?6ycDZdLHdjHIjdJmEx9c9+ydkYO/H5P0UCuqdQG6skkCa9d9nBSIP/W6tVDB?=
 =?us-ascii?Q?9T0erEy1tzuTmIDP752QtmJwdX+9QHJh9n7Lp03+5O+56Wbkto+Z/Siu+fS0?=
 =?us-ascii?Q?ocVWofO/ej3Wm6Zx5dypOJVU/fpxDra4MYSe70HXaTqkF1rB8doq6vWAMUor?=
 =?us-ascii?Q?bVB6SaVIAGMoJM8qMELgjzDf/toHjuesDHL6f8jK4Eh3kcIIb7SY32XRcxe8?=
 =?us-ascii?Q?KZa4gtFY8mwTMUHwELnI+qLirhuOWOKI7BlTUKh2QFxj5Lu5gH9PgSiBjZue?=
 =?us-ascii?Q?cVR55JQw9zsWXj53wNDpgRWtkieccb8jAqHAMeO44ZXQU2SDUlRKoUJy99Ie?=
 =?us-ascii?Q?dcUu95ZpAz+iX3xL15KT40Y2muIevR06cq6rm2NDGqIcYXNgcKKTsm+JPpbs?=
 =?us-ascii?Q?oZjc9Cmo7XWBXhCCcEGB/HQ0cbkfUIOw5Xa8s0aKocPw+dv33sgcoylVeGxp?=
 =?us-ascii?Q?gyIsrmOe5pATA0U3N07YhLiAfPzkoxCn8M9uC4K7NyrBU0zbSwUayUWp5zD8?=
 =?us-ascii?Q?rdkT+XG1TP/GEk0Lonxk72fNX8xT2b3fqmftdFfMkPeonWs7llC/H8EWiFSk?=
 =?us-ascii?Q?d/K5bVAlvvfwLhccwr/sWMmJiAwNIQ+kYU42GetnkgN31HsDlyCDYLdOuAUx?=
 =?us-ascii?Q?XvzfwjSJS3TRouqEVikFSr/Hb9xD9rgaLlMJvT2n/nzgAy3KVBJUg9rrQ/gt?=
 =?us-ascii?Q?HVUdkjOAyXF9zDVSj3ouvIk62U/QwHTo2GNdjLR6Mc3B9tkahP6ENuL4KqMX?=
 =?us-ascii?Q?NDkB9n5B3bN2rRZCMneJcNa+VnuEFb9amMefHViJk+O+ZtjCRxMV/ZfP9yOP?=
 =?us-ascii?Q?5U3KmeoBX3c7kyMMrvGHGZSacaulCL+/2rZR7Ls2Iqiq+/h6ooCSXKJryosf?=
 =?us-ascii?Q?ZTHAGxGLvqVcHMkhaQtfOfqXvzxzMH6c/Jiq3+ttcypDyQCIL7aXEU2MScxh?=
 =?us-ascii?Q?Z86MZa23nYFmCSLB+ktaa9tcZjR7zB46n8qK9b7AhGpLvn8E2Dh3oqC5NfxA?=
 =?us-ascii?Q?iGNsxH+9b4LmK0NdV4YMl02HrhOW63NFo39uEoBBX3CwdQS7XSS/QP20zsfe?=
 =?us-ascii?Q?DV9+cg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s2X0kfWTtcSq8Sg9yglNCHyJnR8EyuYtW0jhy42YFenzKFmRkPZ5iJo/PehLcPgVruMlmwY6l0g1Sx2JjIEZ2U09yB2wDvZe1+6o6cYnUULD0wBop3B4nIZB9QNU5lSMHRZVcuB6xBTECsmf846CcHmUvso0OUOSd3l1fwnuPmDrTEGtVtRKbHzOYT/mfAfGINV+tc5V/+cjJ31BC/VDPfD20argpcF4RxJQVkyVMqkNdZx7njh77UsmSF5fekC9cpoE0jKeUbaGD4g/+NNxfRb/l8+1h8DcVI2Aoq+bdfE7WQH9GjCbKmRA6imFX0Lel7+mQ0z8TT+EMjz+7kFlSu0Per2r328OU3DzX4omasp+4C8cR4CkjQeQLxYCs5iqCEvIK/XlUiItyU9l97xTcQoDUkaBydZoVF/kuGLfztU2ImLJ9SxDP6C6B3TxJyYm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:31.8331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62091463-73f7-4ae9-bd48-08de5fa78a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
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

add check safety watermark func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  3 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  3 ++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 30 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  1 +
 4 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 923bddd0af3a..36c264ab889c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -570,6 +570,9 @@ bool amdgpu_ras_mgr_check_eeprom_safety_watermark(struct amdgpu_device *adev)
 	if (!amdgpu_ras_mgr_is_ready(adev))
 		return false;
 
+	if (ras_fw_eeprom_supported(ras_mgr->ras_core))
+		return ras_fw_eeprom_check_safety_watermark(ras_mgr->ras_core);
+
 	return ras_eeprom_check_safety_watermark(ras_mgr->ras_core);
 }
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 91c883f16ae5..1f2ce3749d43 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -561,6 +561,9 @@ bool ras_core_is_ready(struct ras_core_context *ras_core)
 
 bool ras_core_check_safety_watermark(struct ras_core_context *ras_core)
 {
+	if (ras_fw_eeprom_supported(ras_core))
+		return ras_fw_eeprom_check_safety_watermark(ras_core);
+
 	return ras_eeprom_check_safety_watermark(ras_core);
 }
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index ae63e7394829..34a4161251b3 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -190,3 +190,33 @@ int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
 
 	return res;
 }
+
+bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	bool ret = false;
+	int bad_page_count;
+
+	if (!control->record_threshold_config)
+		return false;
+
+	bad_page_count = ras_umc_get_badpage_count(ras_core);
+
+	if (bad_page_count > control->record_threshold_count)
+		RAS_DEV_WARN(ras_core->dev, "RAS records:%d exceed threshold:%d",
+			bad_page_count, control->record_threshold_count);
+
+	if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
+		(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
+		RAS_DEV_WARN(ras_core->dev,
+			"Please consult AMD Service Action Guide (SAG) for appropriate service procedures.\n");
+		ret = false;
+	} else {
+		ras_core->is_rma = true;
+		RAS_DEV_WARN(ras_core->dev,
+			"Please consider adjusting the customized threshold.\n");
+		ret = true;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index a1003db3c33b..b0d3eade4377 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -67,5 +67,6 @@ int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
 int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 				   uint32_t *result);
 int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
+bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

