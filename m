Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C6FC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84CF10E922;
	Thu, 18 Jul 2024 14:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yUOknBtL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C85F10E91D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1LbyxkiceTewvs4u16GohN0giF8cN1x5z0y6z54WC6IlO/UQ2oYrbnNg41qkALxFGrcRT2dRbZoHjUFTKFyCQmiPAzx6UewueSS6lumsRAY7+eMuXHuAUiI99BPD+YMVMAdF4X6IuIdEJQs99ePzORG5P4Zh8RzEn3SVnB0brOWYZAAH1H3Rcakc9gPoW4HTiyi2hl/GxZWYYNqr7kWonR+pRpmkBA7Skkp6fHixna3Gbm/wA+RCijOAGVUMBweG0QQ4s43jEzg44l9VxubpnpCwKNOfapP7nQpfKSLL6Xa/vN5Byo3M5zr9GOjhhIH/C29rqXlfJE1vwYbPhCldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLZ5AbtUgnt2D2vHBNVLhNA84eoJNuQ1VvcvM4cAMvI=;
 b=bDOciJsZ842OWjQkhFlvfiXaHsP2WzYVbkDQ8Y7oZHIdWKv+sXmyQmvaw0berHlE7Jq1EWl+vfe78VWBlv5cAeURh0sy3EOV15D/CHj36jp5kPUv9LN+sacMUgZ2MmPWaGPjpkx/4lNIDdXbv/+mde/bRDVRgpwG2h8u9dgh/H+B1qzE7gylJdE9rBbFfPtdzEZhGj87vG6mk/RytGT6n+JNU1b/2EXiAIfXp22mKpN/jPmGbqTCvWV0H0d5IViGZVZL2n55wnh+6eSOtKxP2MkT1tlc3yDxYfjQGJwZOiCDEzbZNj+9e47rM5z/tQFTuSgevBwVGSvO49gOIfD7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLZ5AbtUgnt2D2vHBNVLhNA84eoJNuQ1VvcvM4cAMvI=;
 b=yUOknBtL60WZ/SzsvhltBqMOaZpbDuNgpuI8G5DqhZCBffEmu8wAJ3o30P2H/BD6lEcAdBrAlTaTx208SZ3q1iDAHu1b6HzpBdyS3JqOUAbQB7sg5Atmh28ExELecElYkr1yKCaPJvPIMfMGCvcLB+CJZdmP/gVS/WeGTnJHXCQ=
Received: from BLAPR03CA0045.namprd03.prod.outlook.com (2603:10b6:208:32d::20)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 14:08:10 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::54) by BLAPR03CA0045.outlook.office365.com
 (2603:10b6:208:32d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/34] drm/amdgpu/gfx11: export
 gfx_v11_0_request_gfx_index_mutex()
Date: Thu, 18 Jul 2024 10:07:32 -0400
Message-ID: <20240718140733.1731004-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8e9ba7-1c78-409b-7dd3-08dca7330df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UpVsk4GTDYLTXNju8wJzvGqls4cEpIBtbvlYzLQuKNqZa5bGvR5rwKjwiv8a?=
 =?us-ascii?Q?Yzr/uQ1zawXi/ArXzl24Mh4HIiVvxQXRDUgQlJUcjyRFsya6zRruTZM7wMBE?=
 =?us-ascii?Q?G43dVexEXx89RP9H41W0/J/NQNwjPupZksBT87sgcu+mokmf9YY44sMjUxoH?=
 =?us-ascii?Q?9LVqe+laoOVYipeGqtLNHEjxNuJjCj66jEHzvInNKmexCPoplaXXGvhiVtna?=
 =?us-ascii?Q?/DUxogBT0qO5grIBv0d7KlhhQQbx3RWmnmEOMyIlgXhSTUVCNjG0XwjjZ4mP?=
 =?us-ascii?Q?sxFa5Rx7CobojONn/AtGAM8EePAKCKXCRFDaQQ/wDE/Ox738cSqblkBGnj0n?=
 =?us-ascii?Q?wUJnO/kSZV2oj7eYAF1d8YzNgF4rcdKy8WFo5k34FJMQS2M0U34+eTlBvxoA?=
 =?us-ascii?Q?etwr1Z1FgTGn4GEbQowuZ3sSTsHNSc492rfWkt/8eHol/V0e50L42H35mShq?=
 =?us-ascii?Q?0hB9SMbIi5YgTuRkit4IVS76rjnbAtm5RQb/E6L0ehDjOqW3XySb8+4LobQ2?=
 =?us-ascii?Q?IhZDbQH/EhwkKsPvr6vCO1QVhwDBY2o8V2WOR1T95G3PLkOvncCWY0VUmjg3?=
 =?us-ascii?Q?RYtQFxiG1MSZQcL9K1cc7FpePyp5njXcaO3ylRdzKbEQPSo/4ji1zYx2KgL+?=
 =?us-ascii?Q?bR5QkPnrE25EU/Xp/8wcudh1/tjobQIL3qT76EFmsehEra0H1sI9aACrlMGO?=
 =?us-ascii?Q?rcaCezeEWk/S1i3kAY/L+r6AnOoRDIwfQ/1dO64RcSCqL+cuSDAb4vzhTlZB?=
 =?us-ascii?Q?iOMx2650PhSNfKNcU6kTlK4n/w6NQ718JU1Y6UBCmb2BfipaWxo27gbpgnFr?=
 =?us-ascii?Q?EPk7nHv5WwfEftWLNzAWNvEvTmxxhcT8cbWHIlvOWxx/mW7JGBtX4qiS+zab?=
 =?us-ascii?Q?VlCM3vZzG4abyuFnRhtkGzxp+Vn3mm8qMSLc58DnLJDLLP74pOPl4bDFRQHO?=
 =?us-ascii?Q?yuV5gr9x+88O8kyZIdrRFXjXVo0A3jMPR3yxCkLmqfmW/NTnSWVeQSjZYIB8?=
 =?us-ascii?Q?2Q/DAoc/b+ykOmtBJtYIBePB8oBapMgR7rH3Xluvc/lkAglgKnhRXw+8rumb?=
 =?us-ascii?Q?f0sf5O4qwgbUi1Uu3Ppk1sTCptD54Ppxou6u1ff+5Wq+3dVdrbBeQtkAQ7K7?=
 =?us-ascii?Q?HXaa46iw6PSmvu+qGUiez3by9JOeltU78Kd0wuxEcPAFTAQxkL4LYy+3+oRA?=
 =?us-ascii?Q?FIzqbJiEzdwUe8Qzhyx9/GCHnZEOjNi6T7eE9kvUWH4LN3LDK3Dck325OJ3a?=
 =?us-ascii?Q?tkWdiGpTvBQXz18vvVaPOncpyanNVAEJtWH9Xq9hRnhlo0uuuwRctCGMer0w?=
 =?us-ascii?Q?7wE/1ap+khi2g3HWsLxjMeTYCgaeBxwoz+I6aH0E/29/aT4o4NH6i/wJ1ckQ?=
 =?us-ascii?Q?nsbdUXXbWYH5UhZCuGzjKU62ITtg4MhdcPThrg6P6TiWQUOliZBHgOJgNNuh?=
 =?us-ascii?Q?q73pOPMiRTg8faQwooFJZBP83BKXKDAB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:09.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8e9ba7-1c78-409b-7dd3-08dca7330df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
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

It will be used by the queue reset code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 37af298d0918..20be1b9ecdc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4724,8 +4724,8 @@ static int gfx_v11_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
-					     bool req)
+int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req)
 {
 	u32 i, tmp, val;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h
index 10cfc29c27c9..157a5c812259 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h
@@ -26,4 +26,7 @@
 
 extern const struct amdgpu_ip_block_version gfx_v11_0_ip_block;
 
+int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req);
+
 #endif
-- 
2.45.2

