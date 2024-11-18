Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84129D591A3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 16:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDEF10E453;
	Mon, 18 Nov 2024 16:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FPQTDZvS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B3D10E453
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 16:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft5Q+kGP4ITLn31RjERPJ1OGwMsO4Q+82NM44SWRHeYnXu4M/Y/4RS+Cfi6tc0B/5mHW+VB5xfQLOcj8sXu4kbB4MGsiec8O26FxvBYNf0SLrp99ybOXpwaax7YYi9NnALqDeUVsoPpkYCAH0Fmi17r5qTL2yvQ6mGr9KENa+3ekAg3/eKPYvUPqnDXvuDtgE3c8vXa59OLTJhA7rvSByplji1PmAkd0w0A8EIRVUyywU6rlO5YVL8DvYgMwzCf2LLuPNVV4UXsYCg7Xkhh4jk1HrBUbuIcN7LjizzHiAyq+aeSFl5uVSkbwbSvBU/0clxPx5lKZy8r7Y7Yo6ng4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0uFJi7N38kDj+ZGMyGB3R0iKqF1kPozBQJT6iTHrsQ=;
 b=qpT8u5Jbyn2DmnjiTiUrZwCQpi8PhyCd1dfn9Evq4L8Hx4RUHzcqfHK5Irf2XK4KZDgQbygJB/iSeGJBZNVG2BXaw9HIWaIEsiv0ZS0xV2I5Q/30f1EpghmudkDRbrlEP2+WGW6zDIypshW2qAygFYczt3+PffyWQl3ekMFBzNXrtmy2STp6QsEx1eQ7eJ0YWXmmYTyEZLMHtTZUh2HRWKxwgcCV8CvzeKANDUkZ0WdyVHE6vKkJu2kejgHznhuTLi3K3iaK6NBsCSHYD5emJ/iLoeV7DNm9x80jsBxBVMPMQoV5rVOlvKyJAKDcfa8dH81yZc70r2nVJxQrjuTNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0uFJi7N38kDj+ZGMyGB3R0iKqF1kPozBQJT6iTHrsQ=;
 b=FPQTDZvSBaYfAj8sSUPUcIOnJ1tuH/8p/BMMPhJ0vFIbVu4pYJj8Cx5iZahAJVP4OPdGavDFNDpxc4DR6bHfSoaz3xRlKb78bWTva3M2ZmEiWIZqiayCS8vGWHDn+SgYl/ofgmzZ8/OM5YOnDtjIIa3PJPc0xzuiQmgn3Ra0x6k=
Received: from CH0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:610:e7::24)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 16:46:26 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::a9) by CH0PR03CA0229.outlook.office365.com
 (2603:10b6:610:e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:46:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:46:24 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Fail the suspend sequence if GPU is not going to
 s0i3 or s3
Date: Mon, 18 Nov 2024 10:46:03 -0600
Message-ID: <20241118164603.3794-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bc023b-1d12-4c5b-6def-08dd07f08aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mT60nWO/ph9dFUhxsDKykoRDALUlIcN/7BVoB+g1gwm5HzLsmRE9KunyKbC/?=
 =?us-ascii?Q?9zM9nF0hnK9Wwp65h0LpPMNz+p48MixmOMJI/1Djho48JOE2C823aT+/3YIj?=
 =?us-ascii?Q?a0OLz2KY6qUA301fi2/7LeNbYCLq1m+x+f66OsxYSmXVCW5L7RqwfWh/Kqxc?=
 =?us-ascii?Q?OJIDK9AGtrF4gX2JYCt51kjc7CayWZHX4eQ0JiCWfTTogsb1goPCM6FfmO9B?=
 =?us-ascii?Q?L8aVD4r1zg+LU3UD2N7GrbHCfrAQWBqTknwUqxzU+Ospob13WTGcZGHrg1JF?=
 =?us-ascii?Q?ICI8lDg0VYMDEnwV2HjmMTG81t7WLUZIf7ZLpXMM0OfS3PKYPsttx8D8rO8g?=
 =?us-ascii?Q?1jRSTUsOMJm9/0QbyyxJGfgjwCRM4uFxjuk+Pr7Qy4T95VG9gpqmTGfr1BAT?=
 =?us-ascii?Q?2xbza8RFPhzIrDmrIxyqsqxNOPipkg0ag98UmFJbAf473vEQEQEgxAHD1Dgk?=
 =?us-ascii?Q?XLERG+xHEs93gXARDDzXu2rfBoJCF/mcqiyLzdEEnRS8aUbf668I1e+UAsut?=
 =?us-ascii?Q?qam8yFUGWp8caPe72OEQx9G0Wsj0+tLn6lxvx2rn7Jk9SqqxsGyBNNQ7ov7D?=
 =?us-ascii?Q?tkMnCVh5TV9MCiFIAd1hdrh1UQvQdewAxNkwQRChWXhO96jllrksgmqbtf5s?=
 =?us-ascii?Q?mDuaxUZbd3xpcxjm3OxtgEr5WkUv0QK5hK8/YE2ZgLeXqSwcM8G9MureMJEH?=
 =?us-ascii?Q?6KV0LecAskb4EHBTChLb2kHWEo7YHc3sjNpq7scjdoCh59BdmwTrJ0PMq8WB?=
 =?us-ascii?Q?EactO7Hl35dr25VnA6wQGMhoWz749DQxYyXkafZU6UtkuYmz+uINEysra6aM?=
 =?us-ascii?Q?MLBcCNthYammc4Yf626Osu+jBgR5zpIQEYaMKnTG5ASvOeIlNuT0K+8tNR8A?=
 =?us-ascii?Q?JtrAXrdbgv812SrSNbST+0zM2YokiQLRn8LtPcmpO3n8uwPQoc+CF3UwN9bx?=
 =?us-ascii?Q?GzQRAdFi50iE15ZucDVm1hvUI+62znEfi2fXfni+/R7pEecRxubDiHmQfLib?=
 =?us-ascii?Q?4Bol9FDRp7bh3ugsfWCHDXn4mjfZIr6/err0qLeYiZ9eZW1PyDXvQ5xosxnC?=
 =?us-ascii?Q?Rj63aHdOnxY/ZVKxu6tuhDvFQQNbUUAtA85/inCvOrhbV96m0Gio/6Zkwiv0?=
 =?us-ascii?Q?KqwlYPzMYrF4t7PtPODdR4EMfzuZSworTpUE/fstIZkFKcqyrCsBhtU8bKvS?=
 =?us-ascii?Q?RkHZak92r4v7+Xr5jZhvsLTlZQtaDV4iWnpwCtL6WN9ymU65g3qNPt9f1BV/?=
 =?us-ascii?Q?BQjvcOaj1eKMAlVtZ/TCr6h6muiEmsWdbCuZCbIzQAPf8tZm6/xoRttbqKSU?=
 =?us-ascii?Q?54WkBCtuCffKfvNzQQXXv6A2IEXqq2XuKvQRxCExX5m+4XDqfgjQKacqki8/?=
 =?us-ascii?Q?qJP/3cA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:46:25.4987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bc023b-1d12-4c5b-6def-08dd07f08aa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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

Before commit ca47518663973 ("drm/amd: Don't allow s0ix on APUs
older than Raven") there were combinations allowed where a user could
attempt to put a device into s2idle even if the platform was misconfigured.

The idea was just skip the whole amdgpu suspend and resume sequence.  This
however doesn't work properly for dGPUs.  This is commonly triggered by
a behavior in systemd that it will first try "deep" followed by "s2idle"
if "deep" fails for any reason.

In this fail the suspend so that the system doesn't get put into a bad
state.

Link: https://github.com/systemd/systemd/issues/25151
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5224077bbdd8..1df6796e323d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2506,8 +2506,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
-	if (!adev->in_s0ix && !adev->in_s3)
-		return 0;
+	if (!adev->in_s0ix && !adev->in_s3) {
+		drm_warn_once(drm_dev, "Unsupported suspend state for device");
+		return -EINVAL;
+	}
 	return amdgpu_device_suspend(drm_dev, true);
 }
 
-- 
2.34.1

