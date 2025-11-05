Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F67CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 12:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAF010E2C6;
	Wed,  5 Nov 2025 12:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oEWvzG2W";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916E210E2C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 12:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNdH+JSiQVpjUP1Jh8LdBo03P4NRchw6A9JQ3LYsz4yJs5WmsYhAKAZvqlK91iVSwpIH1w20/hl/uZhC+aRR2mglk4WDWnmRAsWOEz0MffZc8trUkBlklqoic1uCPtc74I3CErFC1JPCsVh9tZQuhPIb7lqLDhooIQuHzSnuvE6/GHe1fSP1w3bLWv6VnWy4mVO1m7Gg55Tdu+jJWBuDiFrpD8c6Md7Cwv3FWcL/sFAhfbcxOXZR8xpRq9fydAvjUrYr2dZnB4+nxIj+ducHQTfGnF8hX/Fut/bPrEcK/XSFC43OD+lf3Qsl5aiS0ijhajrthlnx8xAR+OcOdYXfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAB2KcxMJHHTQn1qT7k4unt9Y/hOPc7AjTPW7kBKBWw=;
 b=N486SBpQS//SfGODS97zK+TiIDTKfpA+T1eaFW2P2wRpzSn691n2KWVY8eWwhKw0L7KRmG0goDd5fKbWC7h/lMocrTwCKRIGTPcvwPnx6MC1oezKQH9lxSg9gJpdNJF4U8Xj3cUsCSuTdgXuDLgPbIoHKDbsAhnLeQCEbbRHXiL6uKyFvLiLPX1cu+LcfpEYRh/MP6iBDndAQPv3YKxNaJ4PXfSJyAe/7xkDwOSINZt2+kn0uWaTkdLwRB4sM+J2Or/DfEYBrR5wKhVLH2H34P4ZWw6gDIUYqdcRR1wZbZx72XrqvEOJTeJdwkzbFWT6sSw6sIypii5yyebcVYcg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAB2KcxMJHHTQn1qT7k4unt9Y/hOPc7AjTPW7kBKBWw=;
 b=oEWvzG2W5sTMEQppkH4dZ/naCC2SZaoiFeMITi4RMy8wKK2N/FuZTu65DqrTZxHX4pMoATHuFKJZo+YsFF9aw1PuZkV8JxEh8HoImgEfaJyQmG8uZ1/CeI+neXPKDI90ER5pehH+QBEsV1PN1GBDKZBPKKsXrtvymp0ADLWYPgs=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 12:24:08 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::f3) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 12:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 12:24:08 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 04:24:03 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amd/ras: Fix the issue of incorrect function call
Date: Wed, 5 Nov 2025 20:23:36 +0800
Message-ID: <20251105122337.4066923-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d87046-1fde-4b91-617e-08de1c66381c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ETw7gAJqHe+hE+D4gVzrvwkSdjar1nFBip3TUPajenHWFTrcxmYg1yEZ0uqA?=
 =?us-ascii?Q?880me8zg36CZ6opQvohudst6W5ArQHJ6pGZ9C5Fzapq53gEz0GT1Om8XZaGL?=
 =?us-ascii?Q?MuFrCVrQoq5rrO2alieyb4q1LWuoLzt+14cX2mLsHrpDMlLYKDBHkFI15D1D?=
 =?us-ascii?Q?LnTrXUQNP5qpukqmzxVmvjiede6Jho3i4iMg4DUmrff7rdAuCQuyIlXQUOvK?=
 =?us-ascii?Q?/F19jtA5+0DlojTmwAziBatbxEFW2avn8gZp5LuTQ0LStVLNafP0XeLg4TIE?=
 =?us-ascii?Q?0S5uTMnBaEy2VExXSbxKm4N0tYMSbcMHm6h6wKDIgbm+elrb/4Sj3vmfHS/H?=
 =?us-ascii?Q?hyrd90ft7BKH6t570KDN/dUQrasa2G5fx755KCVQoLLPrGiycFPuXF8M4OB2?=
 =?us-ascii?Q?u8Hjj9xjrqXzoziJgXjeIUZ0kkkBzTYBLzknmS1icpxeU4fhGtmNUBwWyMY1?=
 =?us-ascii?Q?Dui0QGKuf/2/III83/bovEXVwtvIdJUNSRHfSbl4E/nsuOSStuCl9FpRYmcG?=
 =?us-ascii?Q?9yL1S6WzvZEXfWzk8JhJTwo1EfwiwV832TogbY0fYl3A9K14M9nBjIi9FrFI?=
 =?us-ascii?Q?boufrz5P33fh+80+nLQJSKrNdZdgqvSef+vFvGIRzJ9p/4/23LEf3tsXU+wU?=
 =?us-ascii?Q?s5J2GzxPeW6g+HgX2ZHlBaqvzihYuacSqHvafcNc0geg5lknuHWZL3yq3PnU?=
 =?us-ascii?Q?L/iZs2sb+6shOcBvyXUjCYOEJz1/8E7EFvPsV98zwbowYn9K5D4skutc3wJD?=
 =?us-ascii?Q?PtVXoxUvg8Ms2MRciVTajY1xIvtuuVYpOTjI3mL2VkvWInmxesFhHPz63Uvv?=
 =?us-ascii?Q?Hj8ARYDc7zl0MkXsKVwYVkzMpJq1XNCwvuJWQekr6lI2WEMnybXsYoB2eHki?=
 =?us-ascii?Q?PrcKJyygzSuOHTYM6PKIcZtb/N2D5Ate9ZIDvVny6SLj/xqmLG5TKciF0T6a?=
 =?us-ascii?Q?6vNGikA6u7A8sLzQ0Cs2PDRZnhU6t8bVC8mavrQpN8ZsEmN4lWqqblw88uL0?=
 =?us-ascii?Q?pQgmOOJTRE0xeVm+9na7JhLDmmTpOQH8cxjxbklzYF/DC8XCsYlCd4eSut0z?=
 =?us-ascii?Q?wtKQJ0ekgOm0MMc5tqC27xCedvExIIR0bHhexrx6H5NZVpjMgBPUvNPVzVlD?=
 =?us-ascii?Q?h7XePjDLWAiDVcFzdpNLOmsE31KmT52RLmUBuIcVT/zmG6jm4bdBlliGqaM1?=
 =?us-ascii?Q?Y4YcQaieu0gIgn2opQfmyWnG00WQsdruY33rN8ExNPtmFy7cWGy5i+kPHIrc?=
 =?us-ascii?Q?cWAsus4YZjq/fxpYoB/DQiZLyvoF4P27jHdnk/9jn2rX9CAqewGeVXYy2xeX?=
 =?us-ascii?Q?KNjEqiSAJyZZmDvje1OTzrpfHvRr8EBMEEhCmBq51fK9Sn1/DE7onf7bs3fr?=
 =?us-ascii?Q?DbjtJctf7Ug6ZJt+TYCdi22sVlzT1wqDlaYJX9dYGSmHrzFV9x6oCGX7/FsQ?=
 =?us-ascii?Q?QG8TNsQKlD2h+DQeJjftj0yMrDiAB4+LL3u+WKb9fUFYWbU7l/w0DBs8F1mg?=
 =?us-ascii?Q?H1j3IQXtnG0GUo8RL5Ffyr14g6l82YY2pDL9gfigKzon2+v1Ar+dkBe58tn4?=
 =?us-ascii?Q?74jv/taS4ub2gSdpCBE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:24:08.5480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d87046-1fde-4b91-617e-08de1c66381c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
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

When amdgpu_device_health_check fails, amdgpu_ras_pre_reset
will not be called and therefore amdgpu_ras_post_reset
cannot be called either.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ee3dabc0cf5..eca11fbc637a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6751,8 +6751,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
-end_reset:
 	amdgpu_ras_post_reset(adev, &device_list);
+end_reset:
 	if (hive) {
 		mutex_unlock(&hive->hive_lock);
 		amdgpu_put_xgmi_hive(hive);
-- 
2.34.1

