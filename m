Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F826C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C98910E40B;
	Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="beZyO4Rg";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB24110E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9DYj9ZfD6iWYjxwqsyF0n81G/X/KIOm870z1xEmszBE/7ay8gOr39djr0EaZN7nBKkQnvGwDuCLVUONkj1tVDZneNyAhnsPDc6pKuK5Eh4jr/+gymtJjrqOvb2ZeebYsMSo9VZWkLiAE5tD6VDumcKqw3+1kNPum26lQciRCd8a/BUenKr9qIhGGCfnYQTdzio6VVszhK3kiW1MVmLhsQOe+8sdVTYJ2t2hzIa6CbRq420jPjjn4TFj82DbCS0/0dYbRyd9SbCf5QSaW60zt3gdN4vOjnraWQ/idI5b4dS+20b9gNkN6IcVDNNk2az9ymWmfMdFOUrTJDdwELRT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FFmp29toHiLI/+aFO0kkkrh6I5TT8cr0jvZWkVDgeA=;
 b=hmdUJzTsas7PkdzxiZ+CE4lU1CthDstJ9Md+7UdWakMQsLKZXfwjTrQhpsahmVA7wZvza0ZbxFptq+t5kwOPKLgf9GakWy789Q+ql7C5s78p1x/UzpS/VxVnJUHpJV02EgOYpowlzFHXmpNFphEj94t0gRL7F3QR6vweuMJC5sEWJEDX4K9x+VxXHNA4I+tsJqhqIeoMDECZ6HcvvECZO/iDYUEbEhN6usnPci21u2FOEqlLGD3tj/Pzv94Yn9PvDH4VhBDNDPTZXDngvyIvaEWZxwTLLW5mnPW6XOWdoXWrlSi6r6EQuEh//ZqYVCgds3+L7oJTYUUO0nS/a1OE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FFmp29toHiLI/+aFO0kkkrh6I5TT8cr0jvZWkVDgeA=;
 b=beZyO4RgO8D2FbDKeg57gneBY1rY2XhHc02FW2GHxdG0dZhpHcLMUVy3v9aP8vcr5TE413Gx/TIJPQeEFETxkL3sO/SwcbmCisMOuc46FgG7xhqLngyabtafS7ZiqAyPg359cCaPGxV1lFJ/hPIbUUVnX/mm+K/PFp5wxcoS/sY=
Received: from BL1PR13CA0222.namprd13.prod.outlook.com (2603:10b6:208:2bf::17)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Mon, 23 Jun
 2025 16:14:56 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::25) by BL1PR13CA0222.outlook.office365.com
 (2603:10b6:208:2bf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Mon,
 23 Jun 2025 16:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:14:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/31] drm/amdgpu/sdma5.x: suspend KFD queues in ring reset
Date: Mon, 23 Jun 2025 12:14:08 -0400
Message-ID: <20250623161438.124020-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: d93d86ff-e7e9-4b4e-82fe-08ddb2711853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZnwDfj+h7kOV4K9OKyrKrHmXD22xDxA+jYi4AObz5UG/+f+l/XWlQPvNeW9g?=
 =?us-ascii?Q?3+yEbRSpfCoVfTnSVHfNNe590kc2xS8VhF1sHQweAt7hYkdQ2No42oggqAMl?=
 =?us-ascii?Q?XdEq0TCs8tFjFgu/2m2yp88PYQWid2qbBZeeCW/nTOsTEvfphWcN1nF3jWkc?=
 =?us-ascii?Q?uX+FcVs1N/T4VJhSV18KmVX2VLLGlMRKnLoCN/zYM4sddpR4pxtBLga5S/I7?=
 =?us-ascii?Q?dYWQViYGTGZadybqlpltMa1g4UyrJcZY5dGydSXRCpNBDVNoOOHo/fVeaNZy?=
 =?us-ascii?Q?u3tvpsomrRbNDdPHuAZD9TAg/UKEzYVsZqAePxvn74k5W+rBGAy58eVTvUjX?=
 =?us-ascii?Q?iLHZAqO1YhBrY8b2fyktahztwzcbGlbe1jxdGruZiG0zSgHrr1MxrN2Zeq2E?=
 =?us-ascii?Q?2OOSiHYq67TfbwGvFwL1zIGPIl8iWBIkI1yepJj2lOkz3IfoMdf6y6kYPCyt?=
 =?us-ascii?Q?V6XbAg3HJ7r/4jnc13Bbsa+YVRnpknTd7qGFhSm/PlrS+Yq8oF8i3+qo3+DF?=
 =?us-ascii?Q?uSN3gdVE7+JrIqWxHyhqilHmw29Fe6vWDJ3ecAmVEXbK2v8+9ILVAx/DeRgu?=
 =?us-ascii?Q?6sLxkGgBTV0MrzzFZo9jszn9Kd1S2SxE5xWpNcKzw5w1BU7qby9uemflQnRO?=
 =?us-ascii?Q?z7aomugHXRiA23Ix5y1+RcFFV/TpA2M0rRV/a4ldfzI8D5+PzS23gTrxJ5K7?=
 =?us-ascii?Q?14zJ4xUtAl0fy3Z5l5POMwbxO1FWOjIl/kkMAPIgLLE/w4xUGJEP8zoEvdKR?=
 =?us-ascii?Q?dfAjvFwsEE2x5lGQZWvW9WgCUZnZ91Eg0s9Vufaye4EDflOTehPUZ8Zodzlz?=
 =?us-ascii?Q?Hz62MQ0DvgFTJWAOeHiuqmhj+J1BC3s/nWmp8Gi5sXlNRFtiZiieULDN/nZE?=
 =?us-ascii?Q?O2LIGYBmVs4Rq1PwQwJTS0Kt5+i0E7Mdzcezk53YPC5dGN15XAiD0lMFu6Mm?=
 =?us-ascii?Q?621E9XZjdiautO8UtYYKET3Vv6Trid6c5Tb3CMWgTfjMPpq5qclMK9V1Jpvm?=
 =?us-ascii?Q?qsagxydeCCVw7U8S0qQ+Xs+eWVwvC1Rn87Qy20gKX/0YYw/P/tTUGJBGpRY7?=
 =?us-ascii?Q?bHdkkU+AgpVwUWz1yf6rT751yaeJpdP++9hfgomG8zXab1iJD59FWPBJOkgo?=
 =?us-ascii?Q?koY94IfoBeBcn1ak7gAeYMVXGSBy8WOJ/8+GCOPTb5D3sDqfyB0QPP9dyVf0?=
 =?us-ascii?Q?/FoTZstqjRUnruHRW/zNtFpByBqQLVFbvq+H5GJwI0gxe8F21jx2ZccDfsDP?=
 =?us-ascii?Q?tHZnfwkBYuF6IXz9j3iB8iKTY+G3lNZTL/19H+8Fkaww6SC7IpL0BkryC7Tk?=
 =?us-ascii?Q?l8fsvfqLpZ8iv71ElwOSOTD0soIM8Ghq2vl/FjL3c3HoqvMTNnDZciBIjPaE?=
 =?us-ascii?Q?rhCvcwxpKUMHJTphhHcv9xRgspVfF/a9IoyoXQXq/76/xjsXD9xsXMSQG9PT?=
 =?us-ascii?Q?PDZc5i7lXsFZa8q8YhNi0b7YSv+z78+5ysjFueQMN1NpJTdVGd8U5a+5uftS?=
 =?us-ascii?Q?YvKWgX0/YKwJiCDkonDUue6ixlS0uEkysgRz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:14:56.5240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d93d86ff-e7e9-4b4e-82fe-08ddb2711853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

SDMA 5.x only supports engine soft reset which resets
all queues on the engine.  As such, we need to suspend
KFD queues around resets like we do for SDMA 4.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1813c3ed0aa60..37f4b5b4a098f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1543,8 +1543,13 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	int r;
+
+	amdgpu_amdkfd_suspend(adev, true);
+	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_amdkfd_resume(adev, true);
 
-	return amdgpu_sdma_reset_engine(adev, inst_id);
+	return r;
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 23f97da628087..0b40411b92a0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1456,8 +1456,13 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	int r;
+
+	amdgpu_amdkfd_suspend(adev, true);
+	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_amdkfd_resume(adev, true);
 
-	return amdgpu_sdma_reset_engine(adev, inst_id);
+	return r;
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
-- 
2.49.0

