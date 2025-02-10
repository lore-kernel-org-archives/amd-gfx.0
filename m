Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F647C0219E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 01:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12B410E0AE;
	Mon, 10 Feb 2025 01:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="njyo39d2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3F910E0AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 01:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvcMeqpU55vfTruXpdoUoRGfIRR6GAKOFcLgTQFoEKK7zioOhOMvlBaWHZLNl4Jhc23H5uIM+3RboLX2EC3rITPF8N1pdrDSPfTRIbY2iHPVokmAPxjh9gCHVO9qmIqqaW/UIkD+agxBQoTVF+ItRHkfkxnDaZhQHoyS1KkQifZnmdVVXbn3A6+Y7RIZK+6+64SBcBobUlJzQkHa+A1VU7lCvLSzzjjgPftCjh6Qd0m79D6Ftgfcdc1w++UubYikYll7A3bDs2RyWslGf39gPBBew3NVzEEyNVfdGqDgGhqmxrXFURpu0L64/NWmLIyUoEZk59SYiyN8YDfC42DAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMe7OvZtV6Llb/fH+z9SU2pj7DNNrT5TUh0yGPgNBzM=;
 b=FXNCcOBsGhWKkp+/NIVOWZ1dNaygAVOkPpZejJWZpykQ3b7uln+6hee3l0roYjQecc59GTZdffOWMLMd/UTJ4X9corf7ClbWKxSvdlOlr8L7DKzOBSuOTPO66v3HpHLOKAoohWnDudbxI+S+5YWkH4V+0DfQJP84WmW6zK7gEMCno1WPaaD9YPBQNz7H73MSyRMjnBnnO/LAcOw4A+MDmziI5my+hSn9B9K0ywi3P3TzDabwbTXgWnihPgtj+HFKjaCUPJG+xAl6k0SDgt4mhS3FK4kOL5nYO3rFMTTlIk/VwoZ2YBJM4/Fx2WY6bPFZZjnURjdVSLFRWf0Z525JlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMe7OvZtV6Llb/fH+z9SU2pj7DNNrT5TUh0yGPgNBzM=;
 b=njyo39d2zIXaLSm2j8uIWP7uqJo5EXh+6xRoFMYqR7iLcC/2wUF+eO1gnvTgUVJIh9NPBMBUWlqIwz/hX2tmGdCY2+NTigYmuqAM+hRoEsP/TcG4GMyxt90dufLP4GB2hnUkfCBaPzItXIVng/Ls0eDFGzgtDjSvtrowa9cXc7Y=
Received: from DM6PR05CA0062.namprd05.prod.outlook.com (2603:10b6:5:335::31)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 01:08:03 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::de) by DM6PR05CA0062.outlook.office365.com
 (2603:10b6:5:335::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Mon,
 10 Feb 2025 01:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 01:08:02 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 9 Feb
 2025 19:08:01 -0600
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YuanShang <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdgpu - Put the fence returned by amdgpu_gem_va_update_vm
Date: Mon, 10 Feb 2025 09:07:50 +0800
Message-ID: <20250210010750.93033-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 20aed565-bb20-4bcf-cc04-08dd496f5e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H0GmT4n+l9DElPGM6ywtoxX+HWnJz1SCbLhV2LLxwTAPafzMY8uAvBNcwLrN?=
 =?us-ascii?Q?ZQ+F4VU0IucPQUU3VHx6nDTPEbdV16M9veapG+CfdrTBYCSmsAd0AKZQlvKc?=
 =?us-ascii?Q?TpBOOUlIIEkw508E+KAJLM6vL0S1LAXm0qEo5hbcEsCSvhQ4fiOvdbLoqlq4?=
 =?us-ascii?Q?KeRtTzJ974ZqAT4QAG52+PeZ09ZWT9K/F0dBarCNxk/sD0+CV97qpQtDvAsJ?=
 =?us-ascii?Q?UPQbtrqsUzpRJ48KXObxF0wFK2s5OQozmJjZEdtL2F5U0+j8yzmsuEtBqcXG?=
 =?us-ascii?Q?77ZhJlPQf8sim/Zarr+rqFlwaNc35igBWUh4PSCIOHCoQE4lwYG8Kvixg2ew?=
 =?us-ascii?Q?L2JYrpemLYrwKWT42UyssVOTOvMIYDM0p9aP1cGJJYGeGdH6ogD7S+qNV8mV?=
 =?us-ascii?Q?FsJcQ4OC7Hn+swk+yGSYCbHXQ5gBZtZ8+CSRU/C/IPsQWlPxGLp7F1k33IHM?=
 =?us-ascii?Q?DXDMssQCOIySe32RLpdGo2rOgvvzxsZehNLxJf8iVCanKP2eNKwxgD3fBQVw?=
 =?us-ascii?Q?XYGE1eIe9N4EMeDDK4Vh/R4wa+S8yjWgROW9rkCBlGcBEEs/eyYclBxMqNOJ?=
 =?us-ascii?Q?x9cXxSB/p672HNbFX6f3oW4dwzpggULViiryECZdrzbQhlm2iZ4SeZivbBwA?=
 =?us-ascii?Q?H33wo6RM9LMwMTUdNT8mMGC7F+xKOTJmTUWFzi6pQPEKTTSCJECnZ70BIv/c?=
 =?us-ascii?Q?mx7Q1DeFfDlZZ8kdOnX74F2O0ccZ45uaWuCUmZW6JVEygxWSd9WmMPeuhNEg?=
 =?us-ascii?Q?iObjSKgxjqF2JhzShjnY7LymBakzEcwvNqv9jd6Qlq+WAg9XeMYPxSh5Ux4J?=
 =?us-ascii?Q?OcRWAEvxoY6IYn1YwBXFuEg0Y8mO44cg6Tm/SUwvdpQhgVFy7GC83nTIL12d?=
 =?us-ascii?Q?OHA2ZyODTX6PK11YD0NqFWypWSVAko/IhdMyx2Z3lz4CyZGBegAu/1w0vzVG?=
 =?us-ascii?Q?pPyJDbwdeg4uFYpEVz/33RHx12PjLuBokh8DFSYYbGY80/K26T2dw+Ndgqi8?=
 =?us-ascii?Q?oxbI3cOAiXX9qu5thtIYSUTSFNAnLE0Wvzg0Q/3FzQFUx6DLmG4PC8KrNUFA?=
 =?us-ascii?Q?o+srTIBUTrxXfQhzRhU/gtA5LL7x5NIliu7vjNyde96I0S20TpVwZ+fQzZNr?=
 =?us-ascii?Q?5qQEBOs7q5vaslnOBK9WjReRiNV0oxZ7538zR3M292+cROyoP25E7bP6hUn/?=
 =?us-ascii?Q?bp2z17zlMyQopBI9OJMq7jkgavl4JN79K5cdivdny2EUfbqVq+ImwYyRTF7E?=
 =?us-ascii?Q?Aj2Pp7B2DzCEKl+L0r7E+6/kItVBCajNUgu16SUuVSa6OyDBItJZrwY6XD0K?=
 =?us-ascii?Q?1m/CF1Xtqc0eHovkTkpBhu/IJxqsTEdRsEXH+NzaJW75dzRttzK6QFWIYsGq?=
 =?us-ascii?Q?yjNRJZac89Pqgiyl6sFBsA/6V5rHFTyKoS7PtQI1rkTo5CnQUxpf1fbmMW9L?=
 =?us-ascii?Q?b2R8w5O2N90p6qiVk2ZtI7EeYGONflE5XldqIoOSCFxH+p/WNdnppJB5EonJ?=
 =?us-ascii?Q?VHZHZQ2S+ciNHik=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 01:08:02.8187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20aed565-bb20-4bcf-cc04-08dd496f5e5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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

The fence in amdgpu_gem_va_update_vm is not used after
amdgpu_gem_update_bo_mapping.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8b67aae6c2fe..aedc0c8ee469 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -973,6 +973,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 						     args->vm_timeline_point,
 						     fence, timeline_syncobj,
 						     timeline_chain);
+		
+		dma_fence_put(fence);
 	}
 
 error:
-- 
2.25.1

