Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3F0C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 05:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A8F10E384;
	Thu, 20 Mar 2025 05:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1+FBLLO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D39F10E384
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 05:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTMUr+oFKyeVOKoDQVaxLi+cPbKbr9BwDmMLkHLhQfpmR3UwbZQE7S773zpCn6xqv8wPqFt1ZXt+SrTqddDhG7tWg3byMTMVGnqiyDy8flYQ5IDCeGeBKZP6dFcPBFRY8sRD3ciR2DnbnDqfv2aPVAeRRj6Cdsbir50RSpMx/itmw3Pd+NJV23vaflW7MHz/6qpfifNSc3/butxy25P0/u+6g8FScQkq+mu5QS7l4ef0dYjz3FG2Hw5bI2NKIqx27qhyNJV7uby9U609ElOt2LZzRs70/tzYdRxkrBN+X1pLB3UnVYKso4OEkuFPDL8cQniIHueuIm1QujIcokkkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4XIsLcNViRrN6l1IdRgXReVzAG9ujYjIaufZuCcL6w=;
 b=TENrjAjL9ndMq1AxEGzCZlwiPFzHo0QY7X+/EX1ljMUc8rFVhXrhpdkm8Fb/QVZk3K7xJSPJpGNF5GXW0jyV8fxFswHkH5KVHK4cZHltwy3IX2oWqjTt4H1zFY+JDwaXGqUjmR1nFT03xMJSwHDvrUqxo0EPcxovmNd7+n8viEpTGkV29rls2YXActZamhqjjtSMzrTEu+Dn9zJaW5ZOHIcYa9OWg7lmg1/w/oI3AMLZjnyKaFXDT9j3Hi0TGqGYoaCKA84QdyEilcDhh5Vevyvs3NxnjC+8Dwik+JENYDZrX7mfnsCgJkWh4v1fvhfFGWPkCT4f2DNZ9pj1ccd+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4XIsLcNViRrN6l1IdRgXReVzAG9ujYjIaufZuCcL6w=;
 b=x1+FBLLO1BJiCqRya9F5PoDDvvELcSvHfk0slpnzdQr7TU8D9bNUHq63fhIYu2M27Ib+siPktLwuPHiR2vLx3dN8YFFGUWtYua+f2tGek5s/oDtPBGEeW5/TCDTTGhzzk44ScnbcSnZJhka7bH2ZmVZjKlFU5S4wtMJRfT3NYkc=
Received: from SA1P222CA0143.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::19)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 05:09:55 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::e2) by SA1P222CA0143.outlook.office365.com
 (2603:10b6:806:3c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 05:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 05:09:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:09:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:09:50 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Mar 2025 00:09:44 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH V9 1/3] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Thu, 20 Mar 2025 13:09:41 +0800
Message-ID: <20250320050943.4161194-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: a03649de-2a4b-48a2-590a-08dd676d73a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xRuCN/XeX/NxF3vK2GkIXMgxHZQbSn1RzEGTCJ/QNSizqYObEsTC2o3xbRPd?=
 =?us-ascii?Q?Ip3KCqf+XFzL7DmbGpflBADcOwhoSF25saPBmMY87QyeH2HvogJ16hRNiIMF?=
 =?us-ascii?Q?jwVfaEsjSt6P11nskLV6iyTc333ODqOuOB9v30xdg4cIGvvC1bNvnMBxyz2c?=
 =?us-ascii?Q?Pyizx8C5HPrqf0sU3VN2vnOCZJsK05QQyYTM8c27dzyVeyrbuLgPtB8lVKFo?=
 =?us-ascii?Q?LnXoB/8Hq4c8w8e2GWtUR6fBuFe+RBSimmz0u3nhjlx9MsGPPFiEKIDPFlzW?=
 =?us-ascii?Q?Y71VKgbodirimc9EKtITJLxXzOTzIsAkSzj3YIHFeMcf8dbCRkrEkxFTFpSI?=
 =?us-ascii?Q?H6bOtXNqkBQcRMGIpD/FJIf8sWTDFuh9X3uCiJ9gAUPoOTzdlYclFjAKxUqI?=
 =?us-ascii?Q?8KpDOuJRre5W1AFEXzeKTUe43qSaTIQKh32U4Pilm7vUh1Wq1XsKqbZYI3oP?=
 =?us-ascii?Q?Ee5ADFU+QzXtXEUIbOZNC+VrZoygdS32pyMKSiWXp51feXZrzruN3vVx+HJp?=
 =?us-ascii?Q?cTyNitUoM0doFw0FX0z/srnuIIbVGR6sQuKkCTgiKq7Pb07z9AJ/d0BbIY+a?=
 =?us-ascii?Q?Tz6RUM+RNQKHbTP/g7AkcRxKX9AJC+dwyfSrPXHSzwGzRaWkvkPjuXOLSwI+?=
 =?us-ascii?Q?v+fZ9ypBMhr7O04d2+G/jR8hud4deMiK1UWF71c5tpVhHQWBN0pVIa4kAAqP?=
 =?us-ascii?Q?GJEQATswlClSHvX4Wsp34zxnVZ2+FaG0RTh94jDgcK1GGqLFNBOuQJhysVwH?=
 =?us-ascii?Q?dJlaIzxy4Gb+oqXhb6ZqoJ+dHJKWgyhzpQGOm6KfMscSolJpFsRVxq2ojC0X?=
 =?us-ascii?Q?gw7B7DQlWMML957bgomZqM8wOGsfdIdw4ADX3ktD6vk2Tk8k00ozJsph3UXa?=
 =?us-ascii?Q?6KYtsuS/mj+K3KRj2O1zoMVuQbqw1m8IIyQSo/sO/DdP0p8GZTy23pwEAhd6?=
 =?us-ascii?Q?xGGuOjXADsVKL8m/CIEjS0vtEVYFaqCapbZXtbfmqUMKAyMiBlvPQCov9jwW?=
 =?us-ascii?Q?GbFP9hKLhRCqS8LOIG5XMEYVOgXstMFPqr/qWL8f+Pe1iJXmxU0nqnjIpQWm?=
 =?us-ascii?Q?gEVzemL5mnVgII59G7GT1R1gBwClfvPuDT9n/WdbTheWGkjoRt/lJgVFH/v2?=
 =?us-ascii?Q?i1vqEZg86QPklmt/YBuBzgSYEgKIdOJj2mg16w8IZ+KfW0inJUkqWLSvlOm6?=
 =?us-ascii?Q?QOtxL52hMnf1UdpOAhqfZgUgFLz2KQsaT86gvBLLJXLqNmVlJI/ft87HjXqb?=
 =?us-ascii?Q?7l/cUgn3tOW6uA4apX5tQhiHaIGTcsFuqFT1nZxRRZ8Azqt8bTN3szB3hcxF?=
 =?us-ascii?Q?lXqEo/gjdO2kLgmfGo0s/TvFTesVBnR6W6M48NorE6NvWwLMib4XLH+non8V?=
 =?us-ascii?Q?sMNkS3mpjsnXozrSvrgES79/Wln/0aF7YTSfsVrwjAWOQBZEt18aCHDIiDL1?=
 =?us-ascii?Q?d4mWDK9Z7f3ONySuYrafF0OIhJPqIsIW1bsBOFoCtzyhuVi9FrR1qmE4xuY9?=
 =?us-ascii?Q?PVg70XXuqaNf5Ok=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 05:09:54.5362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03649de-2a4b-48a2-590a-08dd676d73a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Increase the maximum number of rings supported by the AMDGPU driver from 133 to 149.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b4fd1e17205e..bb2b66385223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		133
+#define AMDGPU_MAX_RINGS		149
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

