Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C08CCF885D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 20:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117F010E7D3;
	Thu, 20 Nov 2025 20:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rihoS8La";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE7210E7D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 20:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOKFWyB/VJL6UU5cgGidseh8Crurlbh0AxNDg922fyvTVMsp5rNHnpEaBi1/8vdrySWVu8RCq84bYCq+iel7QgACe8me1wdk9Ozmf44W4zKqhG9qDGonhxIxgeFORecv7uF3WT3QvMGiEusAmDM7KVWpGcJZvNU8fhv5cmUPvNLLjV2Bs57aePX1mz5SdjmURifaKaciVZAxAVwu2+fNUznDQrzqf/MwlO7Wb3gOwfNlvHlGVdrL/8x5lEfM022P/tvRaS7FtvhCwGp683P8jsNhGShs9Lgh08aSYurWHn0yKnxz9YMSqPuxWcYY/jtdypGrpia4FmIi/+nkapY2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9c6GjBvO+6IHKWXV5cmXYDQC/iC/+c/5SlfNYTpT7E=;
 b=NFT7xe3YJC3ijQTHN+XArWMU9zOCw75XW9TngYknJNctWkNl73cR80O2KAGDSF3X22nxP9bdBZWV+M6Z7Vubu3dhoFM/TLtGmtGJ8VhSwIRnvxxFOCmB0VgUv+hu4/IiIppB9FrL1BB6FwxkbOMpNmFl9gyiRx9a7ol0+pQbogDLZGYKTgNEa+Dxq2jenrGya82Cd8vGwoUlKeI0ZDax1qNLdjfwXeyfOGjMzWvxOXZMDvcuMyft/WogA4+dJzB5XxB6UHhtwwstu6mEMp4+N7qmxhKJ7ZJ2kJTOu80JXT5HvyjaH4P2vnCJ2kmfwEX19me8XETt8NaeWQ29BetGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9c6GjBvO+6IHKWXV5cmXYDQC/iC/+c/5SlfNYTpT7E=;
 b=rihoS8LawDBZMhkiDmWc72awq3EJQjt7GK5g7cM/G6E62Lbj7TNdgqQA/4/5734I9kyH8hUkj4PmyUM8RbgJIeX4gQ+2yHEH9niSSIC471XHvPgN/mr/yj66dOFOGuQPh31UwHjz+RqAUHoXymWj1ZIYDbReN9UnnVHedDa+ot4=
Received: from PH7P220CA0147.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::21)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 20:53:09 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::b8) by PH7P220CA0147.outlook.office365.com
 (2603:10b6:510:327::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 20:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 20:53:08 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 12:53:04 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add soc v1_0 common block for IP discovery
Date: Thu, 20 Nov 2025 15:52:51 -0500
Message-ID: <20251120205251.6727-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120205251.6727-1-alexander.deucher@amd.com>
References: <20251120205251.6727-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e4c173-f949-4970-f806-08de2876cfa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2pRJHagy5PjHiNm74mYkzpOYJrL2+wlAsZfDbXANmXSnXu9BVPJWTltL47iB?=
 =?us-ascii?Q?e0mOrlp3NeEmLkRtdJsLPWmEEyNYpCsIovYj13S4cCdXgiyTC81dUlqo+BL2?=
 =?us-ascii?Q?2Kzdb3m3k+AlUt293kxFjT+69wwLV1l8Q9A0pzaUcOU5WG8bmr8GAOyZyItb?=
 =?us-ascii?Q?vPMclFiWQrtdQdM7IFcgl8m0EhEvBiYyNzVCx+ssNO41tnTQP0ETZBdVFNmH?=
 =?us-ascii?Q?a8eZDmqeu6XDKIoAWj1YTJgXGI5D+oYGZRGrTpE1gSXTHlLu8J0ekTgAZV+B?=
 =?us-ascii?Q?1qd+g1Fqfw6Jwfq8zsaytB+S44oPvRLEI86zFIQMeJ5NZAoqTWTpIvDizUqi?=
 =?us-ascii?Q?Wsn/Z8uh2i3puHAZpof26C/xKRf3B7vGRdUMBHLK74a6KRcXw4XbAS4kdIPU?=
 =?us-ascii?Q?uKM8ZQUr+A9qU0bUE5I+eCALs2sqLPUwnobWyvniKRbMeKSapjodGsjshRWe?=
 =?us-ascii?Q?oqN/fR2guQFZEEYHxPv2tYgaFBQcHzz+eXXTNTktq54IaQ7+wE+cF2SnS0Gz?=
 =?us-ascii?Q?tOSn1xhGE9rwhPqHlBX0x97DgP4WpG2yiBeQRSeeY0DsjT+iVvPBxLntDLKF?=
 =?us-ascii?Q?vlvZev0U6NCaLSewwGzGkr4zVzubTEmlm+I5n0anefpQwXYo8Iyd96cykLWP?=
 =?us-ascii?Q?UfDpnx+lok+ZGP5bDbqMJ/+UfCrXSfPSyj55/zToN1py2GoA3zf88tyN2hmv?=
 =?us-ascii?Q?jcX29pYfGmr+qYIuYZ6Q+MdYPiSqNMsyCX59ByTg7ZBog2EuAJN4Hr0JKOKK?=
 =?us-ascii?Q?0RR4Bi1Ddx4/uTOJBjyn4ti8u91riY08gLqvSJ5iiqW7XH/6EZofHPG+wuWt?=
 =?us-ascii?Q?M4cElr2EnL3lCDOnRkWeLl1TY4EPgEIu4eBUuRZ7diyH3+iRNl9+LVDb/zsm?=
 =?us-ascii?Q?uzfHWT3d23PsFOhve4hEJDmbbA3sMgCOjGx3MypeZLtii/j5+y9shD2UbPKb?=
 =?us-ascii?Q?3lQbhwpvwk8jgRx8Dp686bxBRJpEd0ij62503Bf/9kwVwXkpVUvglew8MCmO?=
 =?us-ascii?Q?QSI3UMtHGI93l7FY2AFyKXbqR8OFRyB0/NMVE+P0QMTlog6T9zmLoX6sdVPz?=
 =?us-ascii?Q?3BZaHFfKt4Go4M5Zo9EcatXoxZVS0kR03DtDGG/smEAdUoXOl38uOsDaSmBG?=
 =?us-ascii?Q?WGH3B9MioA6xEHdmlNBtIQ2f82vYOoLTPMHyOUl7aq1jcD121tmtnzY74sr1?=
 =?us-ascii?Q?LjlKDaFVxVc4MxnnE2/VOmIWeB5MBtLIWSWT56BunmcG9uJ7YYTWtCUQnpbZ?=
 =?us-ascii?Q?N8LuMcff6tUkjf8xm/JauDpowtSZazcgWugOnLYCnxyS27ZOi3BUj8DIUug2?=
 =?us-ascii?Q?imqrJsvk2g8SlhesSNxeUxro9niKVgtR5RS0diaKyhmpa0KcGrG8TlYhswcf?=
 =?us-ascii?Q?JxTRX6pzY4xvzx6/k+2ZI+e0A9rNEQQ7YZhrt2LH22dvp6DYA51+CDnnuvUO?=
 =?us-ascii?Q?8SZRdi5d3uh10JBVeTR/GTQp6aL5eI+6FOzDGbX1WWjU2B/giW7Idujygrm0?=
 =?us-ascii?Q?Kewzt8Fweh+jAc2O7Eqy/O6KoDBHwNtHUk6V0vLlNPzDX24XV+APrihQn2+i?=
 =?us-ascii?Q?Nnyuxo5gxrdVQMTohCQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:53:08.7527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e4c173-f949-4970-f806-08de2876cfa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
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

From: Le Ma <le.ma@amd.com>

add soc v1_0 common block

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0e743f6ff90ae..4e123af894e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -71,6 +71,7 @@
 #include "nv.h"
 #include "soc21.h"
 #include "soc24.h"
+#include "soc_v1_0.h"
 #include "navi10_ih.h"
 #include "ih_v6_0.h"
 #include "ih_v6_1.h"
@@ -1990,6 +1991,9 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(12, 0, 1):
 		amdgpu_device_ip_block_add(adev, &soc24_common_ip_block);
 		break;
+	case IP_VERSION(12, 1, 0):
+		amdgpu_device_ip_block_add(adev, &soc_v1_0_common_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add common ip block(GC_HWIP:0x%x)\n",
-- 
2.51.1

