Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3161E77199
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2152510E9F7;
	Mon,  6 Jan 2025 20:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1MbDKoTg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FEF10E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfocpFyves5jnFF0EA0ld8Umx/pXm1CZ3qsVHbyNN8YZ1pd5Z8Kkea0RYBMxkPvsZ2IOq7/VA93q8KvstlgPTKgetaPpbWQcD0fClXEhbt1l1eTK2H3wOCi8zKMBJ/IH40cicuBFy+lA7ZjbfjrRTbfPAC+mtMRd3pMj2AGbv3jB99a6AszZa67/8QwkWTbyVpHt8l1zBiPDyRpuDElvz9F0wfZk5/zMMksI7/oW3nk1uA+7l3ilxAKcm2fyHRa1q9mt4pOxe+ApCh6NB3g/G4FaW3nYIWXfVoZ7/i7Ta2iJsih3Dudw9ZETE6ryb4lM4jEwMpFQ+l9wr9RpP+pK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw+oi8177MWBKr9KBV1zNQ9d+GpoIiwsbwhq+HTtkkc=;
 b=ODL1hwXO/5axaSkiGS0Wg2VK34LK/55t8D8dMk5hzM2Jm/h/WJgKlioaJoprtMltO/c7VnhGyAssm9nNrFax/JL1I6VEFhnmkMOlQ3M3vqCLwcR7MLYiRHERlXaPKb401gAvhOwY1q95nkO06Xee+YUjuTdiPiTZruUQ5tBaxXFleqH/g5u9cK5FejY69N+6hptRAcKjOLmylqr5JSS8t5ifhseB3n4YwmsVwD+OwC5baYqB/3WWt2wCzUL2sv7KmDr2w091DfTevgCt+U5bpfG0AipBkqTovmf7qBpOvCcDtoSIGa/El7JjzRbLvIvc3RyvaPJrez7U0IWxmN9+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw+oi8177MWBKr9KBV1zNQ9d+GpoIiwsbwhq+HTtkkc=;
 b=1MbDKoTg5aVwrKE16UXoUrtKYEoGvAbw2+SAlujSDEiFyDM5+dNJB7Ay0q7aRfH9xn5hX2Z+/RYlyqQYyGt0q08ZyKQcDDPlPt5lO4860/PYUNUletMb25Y3MR+2a65/ZJDT79HdoDfvjm7QO7UdC7FjypHNSZw5aBXzWNbPYHo=
Received: from CH0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:610:33::16)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:33:26 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::5b) by CH0PR08CA0011.outlook.office365.com
 (2603:10b6:610:33::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Mon,
 6 Jan 2025 20:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/10] Add additional i2c buses
Date: Mon, 6 Jan 2025 15:33:00 -0500
Message-ID: <20250106203310.3349585-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c4424d-cf14-4580-143b-08dd2e915f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H6OWqQyiPasaqeexdUklkgTnZtDpuiYYHa/LUwQPdFAFE/MRRubb0BjsF7wh?=
 =?us-ascii?Q?rNW+DYML+5i3HnTxt/St1bQZz27Yn6AOwhNjkutxrXkx/cUCE565pLLkeQtw?=
 =?us-ascii?Q?st5F109vh22kyyfEO2aR8eH0XyUtmbZH1i1cJzCxImBZyE15BeEgwaFvd886?=
 =?us-ascii?Q?jyJZPeVaKX3sdAJYz64UiQYVmTQbOOEAD4K74iXjXnOefOkQ5CgtuVd1+P1Y?=
 =?us-ascii?Q?oJ8W4lntPPB6p8t21emVWzkHC+PyEq/a8u+A2MB4FqLSS6vgsG5MVJfh3DHx?=
 =?us-ascii?Q?QTjxTmtOaIGyYNd/hYsBeFzNTgI9vs04JOtMPq1VLSIIj1/K/QBVB3cQw46f?=
 =?us-ascii?Q?KfocYWir4KRFKhaNC89j0sCe7cfFssNG+qiKFDk83Whv7KxkjP41xOgN3rVv?=
 =?us-ascii?Q?mtwUyFmlPItw9Zgu3z69NmbfZtNiGhZpbN86snTf95KubxHj2LiMg+i6955Y?=
 =?us-ascii?Q?PJejDwrJZgJ9eprkD04L0isxrquL5W/6IPz3Cbyid0oNsqPcv51zgm2WEoRW?=
 =?us-ascii?Q?OWNgUKir+ybRPCLNKZW9JC/n3gbKOQLMAPyDIkCayof6VooMhNaA/ZzbJyaO?=
 =?us-ascii?Q?V1YxWtENAlTQCc/CBeRNmZj/nRfVA9BabrO8VLGBZj7mvrAbmKeB5FswL/tF?=
 =?us-ascii?Q?ZQtgQYPkoulqpiZcQRKAcA8A1Cj80TuMpnxtpJb3/IOgUBEaRRcsa+aKFlph?=
 =?us-ascii?Q?WeSDmzX7jfh3JQb/GN2yAwtKm5S6aoOcEpEXwisZ8NPpZKOoIp6RmrJpEYq7?=
 =?us-ascii?Q?cR9DwXca9rnNvh/XIs09qgKswEuV4zNGtDF2smmb8iSZYDWgSpiGX+2WIuDO?=
 =?us-ascii?Q?fSIwbq2hd6y5scoGCXv0MQI03VaUeEpwoHzpXTvlO84KRH3zke/AAxMpHVef?=
 =?us-ascii?Q?/DS+A8dENtMLIhLm/euBrbqajGhQmy0JRHXckdR8oTsFFvRKttMv3MiOw+V7?=
 =?us-ascii?Q?/VdWbMw3bI3R+jaHhlkaIui5YeiAUsdVzNw0mYVk7GRu2sIeNZ7t+I3GPP1Y?=
 =?us-ascii?Q?Eas6jakvqBwXobgBNjqF11BxbMjEshwldtTvYRcGDHpj+fiYaofUYrsgByxv?=
 =?us-ascii?Q?C3HPbtr7z6+WYPq5X/wldWgZF3Ei5blocuyTVms+Fhpvk7JkNpII1Xoh6Rvk?=
 =?us-ascii?Q?B6ijK476a4pGA5CXEwAPBLaR5/5U2MifhCi1xzENC+U5I7y3+zYPURaP6NtY?=
 =?us-ascii?Q?4YzhtZ8zMhm0xrPpSuuEoy/4oWGJF5198ftJ7UWrn8/T2Dq4Py9o0gJ/YVTE?=
 =?us-ascii?Q?mZqeHGPt8Mpq3f/QTDsi+3QciSTllBuSQr8gFNZdvjwrkbOtoLsUPyoiAFzV?=
 =?us-ascii?Q?I6PnC1lJadwfnQjfCXyYC/2k+zExeQhxa7+Mso+u4kH3NtZ3PP/S8frG4K0L?=
 =?us-ascii?Q?l5k8Zxf6mwCObDMqXKFEZNluCf6s6/EeLUTyf+KffiaHBG3TfqIbCVctQH74?=
 =?us-ascii?Q?ZeoUrLbEt8xXB7BPCvFIYIw1NxC0qF+vc1zV11tQFAo7zx3LrMNHywRc1JmW?=
 =?us-ascii?Q?oTEyPZAfifmJqUA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:26.3455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c4424d-cf14-4580-143b-08dd2e915f86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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

At the momemt we only expose the i2c buses used by the driver
for displays or EEPROMs.  However, some OEMs/AIBs use extra i2c
buses for things like RGB controls. Expose the extra i2c buses in
case the OEM uses one of them.

Alex Deucher (10):
  drm/amd/display/dm: drop extra parameters to create_i2c()
  drm/amd/display/dm: drop hw_support check in amdgpu_dm_i2c_xfer()
  drm/amd/display/dc: add a new helper to fetch the OEM ddc_service
  drm/amd/display/dm: handle OEM i2c buses in i2c functions
  drm/amd/display/dm: add support for OEM i2c bus
  drm/amd/display/dc: add support for oem i2c in atom_firmware_info_v3_1
  drm/amd/display/dc: enable oem i2c support for DCE 12.x
  drm/amdgpu/atombios: drop empty function
  drm/amdgpu: rework i2c init and fini
  drm/amdgpu: add OEM i2c bus for polaris chips

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  | 44 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 19 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 67 ++++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 ++
 .../drm/amd/display/dc/bios/bios_parser2.c    | 13 +++-
 .../drm/amd/display/dc/core/dc_link_exports.c |  6 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +
 .../dc/resource/dce120/dce120_resource.c      | 17 +++++
 12 files changed, 157 insertions(+), 28 deletions(-)

-- 
2.47.1

