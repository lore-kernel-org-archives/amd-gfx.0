Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DA2C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 02:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C4C10E250;
	Fri, 11 Jul 2025 02:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rbDqlpUn";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149BD10E250
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 02:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMS0U5wDeY/elwFKCchZeX+FZZyDB9YV8DyrJb4HtlGvezxTmRJFvguxv9Ipr/oS8DtGjFgqO7mFsfjEawcRCILZaxNsZn6EM5J8SzJolAF6vnGfXBPaicVVoATnRDqIbJFywefDSgZQ1qQi38cAo1CkxvEP/RLfB7XXgvSlG7UAfnX7xV6KDmmuE5BsXi7avsMup4oIyHUBZpXgdohB+yJ9hBF/h1I0YCYRDUqgqXN0cy5vzqvOFraYf5iwi4kND5RJQbz0q54RLubmXW3Z+xHPi6X0dMi12Tkqc7td4N5yvO8ddXxfoBbNLmIt+mdbVwnAva9e09YsPmt669Da3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqhXPI3juafnD2AxphAV4chfNebMlOXIMI37VRK4W6E=;
 b=EkKLrqvyN0ESEnPCTobufeVMxl46sKlsmK5bqBPBHAJFcKk86TyZgufyIWGRibOsGnW/TBMUqX+rb8Gb/6DenveC4/sHNX/aKBtUHj1H/XVnRKbfJwahwrLxxnCzHxibOrDK51XR2X4SNk+kUOO93p4OjBod4Te/rD9/lkHIg9Af/Vg2Q4b34pBZX2zgmy79FpxaN5LAXW1hw/ESdSQS6FkUT8OxKSk9EUFSG+PLuOOZdU0g5t3GzgmOkwpDkfXcr899bKF1WNAsLAOaJvdNwBPfqJ66z7xOcfXX93qSD8TldKiZFPcx4rqDjlbRCq5ExjT2PFUkTGvru8OxRX8GeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqhXPI3juafnD2AxphAV4chfNebMlOXIMI37VRK4W6E=;
 b=rbDqlpUnkvtybzBW7SlkCq/XPqGIbjHB400/x18m6jo9z+lZvvEHBChyd3gv3fFh2FITfU3uu/k62Ssp5Q+W+b183vIbL9w86ADwgheUjHOiZXzflPgUjA/WPKHsThgMT3eZeHXbgARulNEQqx2WSYqyo4wTNi4jM+JPP4TOIhE=
Received: from SN7PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:f2::28)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 02:41:22 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::16) by SN7PR04CA0023.outlook.office365.com
 (2603:10b6:806:f2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 02:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 02:41:22 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Jul 2025 21:41:20 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: refine bad page loading when in the same nps
 mode
Date: Fri, 11 Jul 2025 10:40:59 +0800
Message-ID: <20250711024059.25658-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711024059.25658-1-ganglxie@amd.com>
References: <20250711024059.25658-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f877422-f1bc-4379-bcce-08ddc0246c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?neMIzTHjKLTFcA6ijvgVaKul206WcK1JQVJRW1NaLi3u27l6pUifb11iRlaf?=
 =?us-ascii?Q?IomRnvDyBuUQYraVJ5McNrLl4OFXSWwbPNLLFKFR3RP/CIQtQ40vqZB+UTsk?=
 =?us-ascii?Q?rzjC2lZyiPjUVRwWsKnSjsWaFNRy+HIndVDZMw3Ac9WpcYQPTtBlIgjStxQu?=
 =?us-ascii?Q?qn3y6f6S2mIzAc/p8US2NOfx13vbmBQQZC9Ua9P0nBjILXYCn2aT0IiqDisA?=
 =?us-ascii?Q?4m7+eZnIqcJg6BtWqRrpDf3OWgFKU4snHwMrhE0AEQHHUCvS4hS0R+pbaVm8?=
 =?us-ascii?Q?e8VY4dv6basv5OsFhvOv8ypOSZXc672WkdXYiYmonvczTClod/7PY3qvlWTc?=
 =?us-ascii?Q?mqw8U+1Zyv6myrm4LDHN85Fg3ZoJCIVfyDIPWwKVSuobF4l8Y38zmXk+xQzX?=
 =?us-ascii?Q?JpNHK/TkT3nj+6Ak/oLN/Ypi96jyjJzWcb/Yl4+cP+fL2dVSIfsaZqqKJp0o?=
 =?us-ascii?Q?H7VXUokFCT1k/qmcvQpUTl8lbgxH2ukZCcVMs0+tsrUxoFZoiab1BlIosyKp?=
 =?us-ascii?Q?g5BhyAUMpJACQcOer3uTnrzRU4nFR9Ir73wqRJpQJ16/sjVBAy0zky0M6JmH?=
 =?us-ascii?Q?2jvymBa/6CF0JJC7NaIcZj+uUMVl+OUhyqM7gQvJK+JF8SxlsKIxpjpaWVYq?=
 =?us-ascii?Q?eZJzj0A8OjRquYHEwBk8URav4grcsjn0uEqDSsgfZb+w1/YSlDNjjZbWtJmj?=
 =?us-ascii?Q?b3UHpLQvBoL93mh/Z8V2+2ATCV+bs8ZzsQ8z/zflNGkCkTvyZCHXZxR9Ihn1?=
 =?us-ascii?Q?1ZQ/fAl9aOghkIr9ICVK5R7+eaiz5f6fkW3ykeqtoqiq6mGiZiu+pb8o9m9o?=
 =?us-ascii?Q?iCMEfxA5FlSCcO+ZeRP5Bn0I8tJI3kBfCnr+llqhvNfUaIaO11spGGbtl1W+?=
 =?us-ascii?Q?Rb0la+hwyh7B3a8VUcvRw5qnRHpvcMhx8aAmDuPy/R9SjZdD/JcKREJyYgAF?=
 =?us-ascii?Q?TFagPOwIkJZgxEfLhXKzmWjpXsQ/C8Zo74Lljgx7nGxGfsZWvbvRJIb95inG?=
 =?us-ascii?Q?l5U3LJ/Gje2kuVBTetMiTPs2ymSwH+1g0nMSSxzOhIDFxjNG1X2aJo0P2POQ?=
 =?us-ascii?Q?vh3sLzCwf+x42cl/lP1SpWwYbJ3bYbgOdtwq+UGPYIU8MIXcB39hoXnLCJrs?=
 =?us-ascii?Q?FkEusf8vF42O4kF1EicvfKlw6cEKWmTlugBr1SGy+aAmx+9PUvQKJqSgiGTe?=
 =?us-ascii?Q?JEleccySwtDGafcgOXoL6O9iQF82/xBFWG2egMvIQ0Bzw09TXC9vQz0gir9A?=
 =?us-ascii?Q?4w+Ny18dMJA6XKvDRrQOjBthYnUnn9vdlYC+OqMxZ4oIXcypS7iHwtJejjd6?=
 =?us-ascii?Q?S+9HrgdEEelFc8M3xIe6AhZLqw6KwiWXOgPAUYzEYZ6iRJ02VvJv8Tq3nDL2?=
 =?us-ascii?Q?QhvN5m2k8SU335OeU3rJw1P6S+phl+amv9FYagnJzbimNoeJ76JlDeP0GUcl?=
 =?us-ascii?Q?1U5rgPiPOPv0tPoZR4njB3H4R7wvAmSeu4mDrdJeJfH73Osv2I8UhZ2phT2/?=
 =?us-ascii?Q?az1KiBWCiJguOleO1MiMf8I7KbM8XmsK5+/F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:41:22.0089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f877422-f1bc-4379-bcce-08ddc0246c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

