Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82725C3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 21:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC9910E025;
	Wed, 14 May 2025 21:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O6P9y5Uj";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C36210E025
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 21:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVNyw24/uowFG/ZjMr+FgVq6HSqzKtOlhdf109ksN3Wwi23hSTcmam/ckJxRKiqNY7l3EoxCnONYXyioGzcE9ObtFnWK34SSwPg4Qq4/7YQlnpagwNdiwHp+QVGo5ohDoJhfFb4s2piqf3UraSmTB/PsEgyS1k4qIVMPevY7DLYZEooGk5JQVi22kzFnkByqeHnVG6OJecaDz4SU/bXZphbH7eVRW1IXbDHmY6RBLwYt8R+2d/j0oUmUtAlVZMGTxUwOLP9ptlihrbGrni71xcCMpTxj3GpNqVQLDI6+PZbvCzHdEb9fJx44YhJd7/YFrv2tGrBQs3haz+s2bl+++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs0Vie6ETagyzEY5BJkacICyUFZ2pIgOeK2qGmZU4zg=;
 b=Gnqq6fZyZxFuNRNMn+/1OUFWkXSUItNQiPG68qZF0LzBYc9BH/QvvgxEB78WKax3oiaZG99OaKnm4tMZ25IldruGvjr4+jpHgtxOi/FcSm5J0XlbePrDBnWY6TZHIpb2FfFlo90WMZ8tQQ8S3b7alAcmmBwMSUrKvnDytKNHNNTD5uF+yjHkIdEoEdR5qknbiw8qxfZyFWsKYgcAuVtsGD/ykXptdpzGMf76E+0lv0u5jy90Uv01NosUbdqO2Kd5RHivA5N/XFFkMQYhZZxSlzczoKX97YegAx8q0Ll4O7KAzOnN05vqpvonx4bITBCaOAEiGxonRp5b6R+TtrYgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs0Vie6ETagyzEY5BJkacICyUFZ2pIgOeK2qGmZU4zg=;
 b=O6P9y5UjmEwWdlAY4mwo5JR2VRjj1xzddnSrNA3qlEDmoy/3FuSlRlEwY+UoITRyLO4Q434Bpcatx9+WJn7q1JiZ7Y07s0bDwyEidWLumGy29yOvZesUMG/EjMGhVOHPdyNKHBgT32PuO74NEk19RG01tb+G+bwExFW/EGdi9NY=
Received: from MW4PR04CA0369.namprd04.prod.outlook.com (2603:10b6:303:81::14)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 21:37:50 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::e) by MW4PR04CA0369.outlook.office365.com
 (2603:10b6:303:81::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 14 May 2025 21:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 21:37:49 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 16:37:48 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add GPIO resources required for amdisp
Date: Wed, 14 May 2025 17:35:57 -0400
Message-ID: <20250514213721.519943-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 979e291e-7c1d-4d97-e77c-08dd932f92fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oMBmwn9EgO9CkhQFZuvuATIXxRNo6q2KnxsifhIOtp7jwso60V4172ZKW6lm?=
 =?us-ascii?Q?Q2cnQYElSxSleddUt5SrVoUAHdzjnSJhGBRoGWkPCM3z/ZImGBX0pkeJTt41?=
 =?us-ascii?Q?H+pEqLCmB1o2pAlnAtyJhDI7jQHNdzSxrflMASon5BntuC0cyNeUYj3CBSH/?=
 =?us-ascii?Q?c17N7grVpUf85i5kLcwkvDGIykjya+TfUT1uZ7AKP9O1hYPW20wxHGSdXCK4?=
 =?us-ascii?Q?aZhZXaGxIgv3c7o0HvhavwwfF+TUDd+r6NZ0712GrghgCIjc0zspFHvGHOSN?=
 =?us-ascii?Q?CYj6+GsUiu7dFjqtg9xYI9CwLEkyc2fRITZwS2lGVpeuCysZd4v3AAkdrRjA?=
 =?us-ascii?Q?UTaZMLqnpIiPFGx62zyoo4ujZ9NCbxjZeaSIQxDQE6uLcVTkNvBwUhlCV8HL?=
 =?us-ascii?Q?eOQeeAk0E+2QV6zSseo4RGzNAJTauhAPO/MpgBexWSmSumcSAqdrXvH0eRJy?=
 =?us-ascii?Q?jArNeSsNLpnzkmp53tr7ooykCCMRNei/JLRFfStn/5jTQSB6t6QJN+P8nzwB?=
 =?us-ascii?Q?IqhNTmIGuvHseo0s2Rb0LdXbE8wcZI8CFpWsSU4GvOpXWA34jRbU8sW8JcD/?=
 =?us-ascii?Q?Kt24DVPHlMLzlbarppEBO4/KVdhxsXpgN6OFqJLpp3Uo1AA+zTIFYiSdpXkb?=
 =?us-ascii?Q?bfUHg85ZbtEnjTZNSZsuSix/ToWCpDSRgEqYtCjHTAVqHegS4mVy5/JeoypJ?=
 =?us-ascii?Q?33E7L+Hr4mvsDJGcD9Nrmgt759sifI55FN48jwv60cVIbBC1ipRnDqrs45Dx?=
 =?us-ascii?Q?/4EmnkyXSZIPUhsOeydjytgceLScjqPhtXMjScGcnCeB4bt20G+nQoBFZapj?=
 =?us-ascii?Q?tdT4XK4s4eAiikxHno/1/wLCERAr2vn51VULLTw/RvwBk9Zg7elgs+hjITGV?=
 =?us-ascii?Q?G+t16A0Lvvm3mhQKY7OrfO3Zdpekm5780Njio8swylMgh/FA4OJhCeE6vDS+?=
 =?us-ascii?Q?vV5FRXEjUDMP/L10a6hI87jsqzYx1EaS30y1tk2LRdKQr10MY53s7+tuCe/0?=
 =?us-ascii?Q?rJcOVoE3ShO8OTbvU1P7S8lxVt3vjV01UEojaOMzyi0i+Fq+bMZlwKRUoBSE?=
 =?us-ascii?Q?9Ero23j07nmjWn/fR8Job+YtUzCv3K36q5Jb6Idc8V5Ws5NXeCF61abru/P0?=
 =?us-ascii?Q?UWY2LxTvmaNHrV0JdVQ6eGqKpyO2E9X5jMhYDc+WUuYiiSGAI56YjmwLNhYo?=
 =?us-ascii?Q?uZBramjmzC8hTHPzwcBnKgAKBFeTYQHJvrNDwH6GQdvJkXJikiFNCrMyxmvy?=
 =?us-ascii?Q?EUS8KdpDCHpkn2QzwKCMrZDcCpBBcOFqkOe4UbSyK6rZ9xUTllKA6aMzMxZV?=
 =?us-ascii?Q?93wEf/G9/dCcwRphxO/ovspUQCkQXC+t1whpvheu2CvMmSFu+hqH1uWUPGQn?=
 =?us-ascii?Q?Aajvc4aaw6LiSprAQfrqqy2y1bky+33hK3TvcKi4Mssw/c5ZaRuYNSdrZkw3?=
 =?us-ascii?Q?VLIajYXNjCjCHEf891Nl6vdgqlMPTbYGkPmx16IaqfQnzyZpd7TplDiuOOB+?=
 =?us-ascii?Q?FZkJVlsvEKLnvhDcgSF/z+M2iHQMwJ9NZ3SX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 21:37:49.4067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979e291e-7c1d-4d97-e77c-08dd932f92fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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

ISP is a child device to GFX, and its device specific information
is not available in ACPI. Adding the 2 GPIO resources required for
ISP_v4_1_1 in amdgpu_isp driver.

- GPIO 0 to allow sensor driver to enable and disable sensor module.
- GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming mode.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 69dd92f6e86d..c488af6c8013 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -25,6 +25,7 @@
  *
  */
 
+#include <linux/gpio/machine.h>
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
@@ -39,15 +40,60 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
 	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
 };
 
+static struct gpiod_lookup_table isp_gpio_table = {
+	.dev_id = "amd_isp_capture",
+	.table = {
+		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static struct gpiod_lookup_table isp_sensor_gpio_table = {
+	.dev_id = "i2c-ov05c10",
+	.table = {
+		GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static const struct acpi_device_id isp_sensor_ids[] = {
+	{ "OMNI5C10" },
+	{ }
+};
+
+static int isp_match_acpi_device_ids(struct device *dev, const void *data)
+{
+	return acpi_match_device(data, dev) ? 1 : 0;
+}
+
 static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 {
 	struct amdgpu_device *adev = isp->adev;
+	struct acpi_device *acpi_pdev;
 	int idx, int_idx, num_res, r;
+	struct device *pdev;
 	u64 isp_base;
 
 	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
 		return -EINVAL;
 
+	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
+			       isp_match_acpi_device_ids);
+	if (!pdev) {
+		drm_dbg(&adev->ddev, "Invalid isp platform detected:%ld",
+			PTR_ERR(pdev));
+		/* allow GPU init to progress */
+		return 0;
+	}
+	acpi_pdev = ACPI_COMPANION(pdev);
+
+	/* add GPIO resources required for OMNI5C10 sensor */
+	if (!strcmp("OMNI5C10", acpi_device_hid(acpi_pdev))) {
+		gpiod_add_lookup_table(&isp_gpio_table);
+		gpiod_add_lookup_table(&isp_sensor_gpio_table);
+	}
+	put_device(pdev);
+
 	isp_base = adev->rmmio_base;
 
 	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
-- 
2.43.0

