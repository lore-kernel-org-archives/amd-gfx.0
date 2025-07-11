Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E330C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 08:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2555810E9C2;
	Fri, 11 Jul 2025 08:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="opiHrfim";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6CF10E9C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYbElts0mNuMoX0Ts9S8qQpoup6YhJQDhdiXUxx98FwoPXYWcRiHpFhZCAcAzzYC869G6o+dcxFZbTy2UoTU2acO74WWwiX8DW9oGCGQQz8XH+SYhs9RImK6xKdz0XQgdWwrTJ2gVOmdj5CyCyrKVs3LQ2qlCwGWmw24a3vo8smnFgwk+Rhzu0CaNdyr5bOjbQaBrYuXNSnbVv2Q0ckpSNjr41SZfCBJP8Wvl3dhZ1SQrWpljXon+TV1jxlSBnPeVQHWYap8ljnJpb7JFxab924rUU2RuoC/hQc9gl9ukaSohFhkHeELUzPzx8JCBWqF7srrigncoE8j15+T5d1QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqhXPI3juafnD2AxphAV4chfNebMlOXIMI37VRK4W6E=;
 b=FUBBiLA4rQvB30eYEXtl41lQozDhBHl6EKD7n+pwC9hKklzHNWFbfPHX3ZtqknTfHmZY53UtT+ZdooFC2qZqUH+AnLupyV9m9Hyzs4T2k9lUtGyrmnP+86u0OLgEytKYiUOw8MNDMQCCSWv52CMroknV+kZNbOQ9b1NiWXe1m5LnIkk7Mulm+vpiDg+2VsQwtPqq8fJdkEuooCATy7cm2We5yLs+GNJGOZbq8ILTVNs8xyq5j5txgcsDbSSDsd6Gb9ezSRnHeEEHVjVRfbmUZN4PwamKftJotSrz/Qt+1P+z3/DV43uTSzKdUbIcPSHTCKVfMcosgf3gdAirOKUxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqhXPI3juafnD2AxphAV4chfNebMlOXIMI37VRK4W6E=;
 b=opiHrfimZ14PTurc1l5SOw/2wu9qH+rc1/s/ys+HWlcESEdHZRbdPO6rcxgv3fVdnpEC+i720q1ip/sjLuFe9FXE+314PU93i7HeAHIXRLW7Ddbqh2O7GU4LTgjJCntl24MkTD1J5VfV1WDbzwoDYDnwi6tkG2+OiXzKdDstxzI=
Received: from MW3PR06CA0028.namprd06.prod.outlook.com (2603:10b6:303:2a::33)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 11 Jul
 2025 08:00:24 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::8e) by MW3PR06CA0028.outlook.office365.com
 (2603:10b6:303:2a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 08:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 08:00:22 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Jul 2025 03:00:16 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: refine bad page loading when in the same nps
 mode
Date: Fri, 11 Jul 2025 15:59:58 +0800
Message-ID: <20250711075958.27835-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711075958.27835-1-ganglxie@amd.com>
References: <20250711075958.27835-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: 620cff90-5a97-4325-971f-08ddc050fc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NrjhVacCoVhXOU9DvANwcpaL3TZRwhO0LJY21fTYFpEGar48lMfVOP10oRV6?=
 =?us-ascii?Q?gxMsxMThJyd4vWNZioPlLaT9obcbKekW+Cu/sKavLk7+hB1vcrTxbTo4GkP/?=
 =?us-ascii?Q?4GlE39TAFQ95lZgwOfolgFotpTSzbx8uJpb5HgBh/DsycAalvHtq+/K0pneL?=
 =?us-ascii?Q?Qogb5d3u10YqumwQ53pTakkdUpRy85cJ8A460281eAtHXtnDJ9qtQUcTuJHB?=
 =?us-ascii?Q?5sNWoQqlPolJohs6vtX9fwlmm5ZqPPi83HENGoPwrVTKBtkfwcWdHaLucZ1Q?=
 =?us-ascii?Q?1f33Gfy1sZEL2AGI601X9bfFrReWuG53Cx1h80gsNTY5jtMKmMCEGCYOa7O0?=
 =?us-ascii?Q?6dELRiTZk8OTSCb+VczAUTIyWfaih53RixWsoHsNDAur7xOPk4ugBOZw0ZNF?=
 =?us-ascii?Q?C/nrlSeeByPtSL30YMK+snsKtgKaYZVoQH3X7fUBH6RxqMJEYkVujDkhsQ16?=
 =?us-ascii?Q?j+sqXJHgbaYZiY+wM8XcKpH9mGoh1svQpO2iAEpMzlQcc5b4Dm3CAFDtjafv?=
 =?us-ascii?Q?2Snrj5smyEvZoXtk+aAuI3+62Qm6HUl0bVNsKf2EMFOiwZWUkER0je+qoEJO?=
 =?us-ascii?Q?V50kNrWC5fUhQehgwxhHDEek1BMX4orKYkb0Z06e4U9T85T2BDojqEyOF22F?=
 =?us-ascii?Q?wyTcbNQhcGYTV+D+ldzyKuuxqGzqVlBuPYJ0KUXTmlS6l1NeSz+O0oSNQyfS?=
 =?us-ascii?Q?sN1WfQY5Pa29+xhz2qaFn/P/jKJ9Y9AFp5J9Ql3wtXf4IIGyr0yor8cMrXkw?=
 =?us-ascii?Q?3qDFGFsIq+eQsrzffBioWq0NLEay174wRENqGxPPnldOAx+BQnQabWNkBtB+?=
 =?us-ascii?Q?CyGIpVXOZl7tlIVTHXCJq72Lk7VwGu0wRVrFW5B5vuI3+Su2lIc/Vx0zgDba?=
 =?us-ascii?Q?PCIVBVZNULydgG4MB0M5oBpASwX+h9Pj9LWBdlZHOt+3hBEKyJCjEsPLeE+S?=
 =?us-ascii?Q?5/18x+OPf0Addxcb4UcfL7cfpq4+GMbI1n2mBQOwuIlWMIBx+sEknCw16r2r?=
 =?us-ascii?Q?aJDBY58zy3/bBtZbA0nZqkOyFB3BbnEagIWqT825fI2sBOEVoPpwG2iAf18d?=
 =?us-ascii?Q?ALWYEYBV9PpBN+GcS1kuz6AOu1ApSKye7VK8fBjMXy2b4EAg4LHUF30F/eDr?=
 =?us-ascii?Q?cUGv3k/HuKz4ykx78ofhF5p0aIpdsSsxTzHLqRuIb1VjwaHlFoWwBBhIBMab?=
 =?us-ascii?Q?RjEd4Spp5FIm8ud1lQsnlEgBNelsuiOUj0Yfm7wdqCgsP30+P3VENxCdtk/A?=
 =?us-ascii?Q?Kzj74f65KYc7Wx3eb4AnifLoOLv457kjzAU3Uf+lfjwndz5nXbxpGIAdnqla?=
 =?us-ascii?Q?xLTE+mVAC6ZMP0iWlxFrCjmBW6l7uK+hqX5KwlY9i4+K+eWIi5Olk0q4bbrL?=
 =?us-ascii?Q?E7F5rxohKKSmbvl4587yQk85Lis/mUrxmjoP2Kqa436r50GdO4i0mY0Mrnpk?=
 =?us-ascii?Q?nBK+wo9TqW4+btRpzv1VDQHG/q8QADXolI1Iqqrn115gFnyLTVnD3OqGhQRW?=
 =?us-ascii?Q?0W4AX/NZM7MhuIvHBY6wNv5t6iptB32e0EUZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:00:22.1141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620cff90-5a97-4325-971f-08ddc050fc73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8
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

when loading bad page in the same nps mode, need to set the other
fields in eeprom records manually besides retired_page

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f8a8c8502013..94d4639c68df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2860,6 +2860,13 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 			if (amdgpu_umc_pages_in_a_row(adev, err_data,
 					bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT))
 				return -EINVAL;
+			for (i = 0; i < adev->umc.retire_unit; i++) {
+				err_data->err_addr[i].address = bps[0].address;
+				err_data->err_addr[i].mem_channel = bps[0].mem_channel;
+				err_data->err_addr[i].bank = bps[0].bank;
+				err_data->err_addr[i].err_type = bps[0].err_type;
+				err_data->err_addr[i].mcumc_id = bps[0].mcumc_id;
+			}
 		} else {
 			if (amdgpu_ras_mca2pa_by_idx(adev, &bps[0], err_data))
 				return -EINVAL;
@@ -2891,6 +2898,7 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 				struct eeprom_table_record *bps, struct ras_err_data *err_data,
 				enum amdgpu_memory_partition nps)
 {
+	int i = 0;
 	enum amdgpu_memory_partition save_nps;
 
 	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
@@ -2900,6 +2908,13 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 		if (amdgpu_umc_pages_in_a_row(adev, err_data,
 				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
 			return -EINVAL;
+		for (i = 0; i < adev->umc.retire_unit; i++) {
+			err_data->err_addr[i].address = bps->address;
+			err_data->err_addr[i].mem_channel = bps->mem_channel;
+			err_data->err_addr[i].bank = bps->bank;
+			err_data->err_addr[i].err_type = bps->err_type;
+			err_data->err_addr[i].mcumc_id = bps->mcumc_id;
+		}
 	} else {
 		if (bps->address) {
 			if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
-- 
2.34.1

