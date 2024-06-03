Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE04C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD3F10E048;
	Mon,  3 Jun 2024 01:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3F84MJ2z";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1450510E1B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN6zrCpiMKKre08/OmcM66tHXXmM9XUGxP/OV/YsDsjl6xsZj0n51sjgiskpfimExShF4wY1IxqiZZ478sQKk6ZwrawHA30F06bmp0SusXeRxrkulcZ4BMq5x/+Ew+DHOc52T4Rbk6JXgVv4yfP7giXOSqS9dsj9BSaiChLoGGZnVYB6mzmVHfTXPWNmCTSqCOljnk0701o2u8Q+BRo9BYQJQc7iS8Pm6d1I5kkJQln+JiTb1XuNKUetFWLonCuXqgeidx07y03CDSShMoCnZ8M9Aq2AsfDrrgS31xEqpH2Z6fPw7Yk4u/bAAftsBupAUYAc9JD4bp8J/h5woVJ5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUNX449iSsoM+1IH/fDl97WrY4B/MzCZuR0SvwqVhQg=;
 b=nYUbiSbDtNtqrr22K1FzSu0wWnCTYdv3wPEgl+2OLpVx4x/ThuuXmQsaF53px9+COep3Ah0gNmU/3ETMG7/AE/0dLY7PLVkjR/a10s+fleIVZRiXUp3MNQyEccL2JH6wRfufkHEAm8SVtqj2y6/g6vh/zGVQG030gpnpiJ+o+DeJo6qeaXREC61H8B1nheABEoph5qbhsGPYwm7SWoi/K471m4s2Qgid65Hy25jz5nsPggtJw//PRyxpJ+vy6A2KCAKKUrKgFGJrR6eBpXylUe/KJMgDXk53aqV85PqRkOX6K4QEgvU2QhINQj2JP1RrkmrQvjBLffTsv4id+DyfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUNX449iSsoM+1IH/fDl97WrY4B/MzCZuR0SvwqVhQg=;
 b=3F84MJ2zsjcwmrLcI8SQ9m1dRsJOHFaJwGyul70y8hkahBT14lofVRfV7ylsGVMvveb2/nKgyf5R/Fmn8hYEYrH41BdGhKlpjzKi/IJ0+fX/tWp5OoQPOUbVi385+Z77npRD+gaIdYp/IdEp/X6nA/vspXU5m6U823WRZOTLXDk=
Received: from BYAPR02CA0062.namprd02.prod.outlook.com (2603:10b6:a03:54::39)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Mon, 3 Jun 2024 01:42:43 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::14) by BYAPR02CA0062.outlook.office365.com
 (2603:10b6:a03:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:42 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:41 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 02/18] drm/amdgpu: refine gpu_info firmware loading
Date: Mon, 3 Jun 2024 09:41:56 +0800
Message-ID: <20240603014212.1969546-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 2891c6c1-a2b0-426f-a9d7-08dc836e75fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x9juaEtQxld6eaL9bZTxwPHMVO5QfT899NuJ4/yJptjC9qfryrNBxS0baIkm?=
 =?us-ascii?Q?fr2br637tRquu69AMiLajDgRGv6wkBOGcSDUnexfbphh84EwYehg5k4IcJcQ?=
 =?us-ascii?Q?uBm0/i3VTrfwR0ktFfXP9KlEsJjtkLo05K58MqGnhSTATgXT/rUhvMkNNwRd?=
 =?us-ascii?Q?UvoieE2Z04Cq6k4sDoWIcUjA1LPWkv99p30D1UmqGVlNdZCHoaX1Zxa5jSV8?=
 =?us-ascii?Q?OeDeF3hmL1zCMNEcnql0Z+fOZ8gBtivHKLg5LBVofM1KLbyMPSSTQPm6Um0h?=
 =?us-ascii?Q?21k2EA4l+LXG6aTkX3hvmwts6APlq7qn8ucWOmjk+6dQCILq/ZBnQq6fZ6Yv?=
 =?us-ascii?Q?xxqZhaJraHvzexkiOrdZA0kbTE7U0MJ5Gyz+r9Ne/nYbg7Im8jR+K9yodl3J?=
 =?us-ascii?Q?eUqEdO8DuNUeKQYJwbOfEC4TgY9Od3xVcWj5d9jqtYWSIApeBgojMu32KzVb?=
 =?us-ascii?Q?50yu9UNcqtZTwveGWogA9SzSKCR1tTtQkCiPv0zqq1G1gmOetH3xU77wwSRF?=
 =?us-ascii?Q?om2Gzfx2kdTETt32BiiNsGMHdLpUgPbfjC5W26kmtRgAk24hrxrluIGJwd2x?=
 =?us-ascii?Q?7OZclh2bJbRdnS4GlLhBsBZg+x0Va4MMJsjGs1+DxGxOrLn7KVZG78k/abDt?=
 =?us-ascii?Q?x0xx7BfU0OyKkN3/TNLDqWpoEjXJ7PY7SHmk4QfDULEi3gNZ8/afR57/Zk6N?=
 =?us-ascii?Q?g/UxBz4KGX94TOsia79PXjolOshRoGTRoonRjzKR//47QO9z7O7OtercnFtI?=
 =?us-ascii?Q?ZgYRL2Fl/62bkvdriVaFrEE3E2hDfP2eB0iVxLPnZqxoY404tQyne3oSLLeX?=
 =?us-ascii?Q?5Uv+uuXBAmQbNTNfke28NdhEw0C698gC4Fjt3T5MVtmWpiNA7GsYZxaLSkmm?=
 =?us-ascii?Q?905V9HYRUX0aiW+Eh40kofblNT/0/Qfxf5jP/U7uzLyHkc699a59WlSID6bj?=
 =?us-ascii?Q?7dSoOmbWYapqd5s5iSZ87ONFXwUvzb5k+S8gnL+W47IcwfqJcCuf2cai8VPf?=
 =?us-ascii?Q?tO5y533xHGNi7jKLuhh42wIvxtX7xAIuxG2NzwCK8/OWp/KW+R5Cj64KOBak?=
 =?us-ascii?Q?JjQN6k0w2u0hx62+Hc5sxfA75Zb4Kr+7WSCPVoPUFPKENVsXGJ0+UJo0EivY?=
 =?us-ascii?Q?H9cvqaT6dYmN89c4SgVvBm+woA6+r9q0oH17Ke5Yd74h9nSHgTZogwWOJOlD?=
 =?us-ascii?Q?5K6HF8EGDZpUeKzCHkH2cZ+lqzTCOYZL3BhlAkflfERxgYtT+y+eIYj7AQr3?=
 =?us-ascii?Q?/kYAlHr9NKUGl2+QYJQTM3B5FGHGmwrwgt4yM8V8MyRYzCOMapy4oheIV/N+?=
 =?us-ascii?Q?0Lt16mZb2egp21ZYPfQjaSPmC0tnnMJrspsQI/tlZN8danbEVn9f1OYdTn1E?=
 =?us-ascii?Q?pd3JjOMrBzI6EzEC/jyLZor693EV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:42.7782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2891c6c1-a2b0-426f-a9d7-08dc836e75fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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

refine gpu_info firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6711836054f9..a6af15fb203c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2350,7 +2350,6 @@ void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev)
 static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[40];
 	int err;
 	const struct gpu_info_firmware_header_v1_0 *hdr;
 
@@ -2384,12 +2383,12 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		break;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
+				   "amdgpu/%s_gpu_info.bin", chip_name);
 	if (err) {
 		dev_err(adev->dev,
-			"Failed to get gpu_info firmware \"%s\"\n",
-			fw_name);
+			"Failed to get gpu_info firmware \"%s_gpu_info.bin\"\n",
+			chip_name);
 		goto out;
 	}
 
-- 
2.34.1

