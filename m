Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3A2D0E6FA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDE710E42D;
	Tue, 25 Nov 2025 15:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ejrm0d1v";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B23910E29F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp8PHeybWQl41Hibgt1B0PD56u7OqgUC5ESSNIrGvl3R5uG/Qbo1v2+TdHCEE54sZQnMS1FzCBpUt0IiCSpGe7B6qkny66mwPDMYBiobTA+B1YxUCiea+6Ze6pkBoklk5isIvbrkhRyN/OjQVeJzffDyqp4SXBeg37USIPiZib2jUojdP9LEQ/QUqHaXVMR3PAlWtZ7RjJnYHE3HwwmcsQfD+TkoJn9JZdXwI5My5LdDNNhzW2UUWlYWICeSUxypjDTnc2CnTNTrblDWbXW9OuxIWVpqKj3+eB5Gb5UUx7SfbhR/YLbToMon7czSJPqpAma097KRaJFbFJSzGaUuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEbw/wtPGJtkZQmdf74Da76lSpSCavvEwXuc4Esjh8c=;
 b=oCKr4eeaetkxAwy97ndNVFCv2WYT4i3lU/wrkz+XRpgNlkOqpQbJFVzDso1ZbXeZGBjwS783Ju6WRGJ6b8CqIiG5SNLG3QZq1umvnk/bN8jXjzvCwN1v7oibDRWdRB1zmWmKt1fr5Ox67cY5Pa9jF1xyyq5SinYz+T5yYis82AZmFCVe9R8ZFDUOyeb3qN1S/4Sk/HpLcrkOo4tg3BppVZJOmMbeLBfCkv9hD84yAbHJ6YV7NhIMD1jmyFqiLs58k6ob+AZ+VHZPvg7Q2lV1FDUF00RugvKry8hTuj/Q4e8pKCZFvUrPe3s7T9Q26dOoquKJccy/XBzKSeQEgXdTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEbw/wtPGJtkZQmdf74Da76lSpSCavvEwXuc4Esjh8c=;
 b=Ejrm0d1v/yTmXGgo+kSKHheM9mgvPjl0YOY5tja6hNGPKq8VrtYqo/becXo7dhlfWz2vBq9TTFStvPlG/Od9joselyWMzA0cEVrQecadQd0/xva9EhSy7ubVlX/gvBK5PNqbO+vOAN0byVGwdi8jNDEC71Jw1JTJFO7Wf+TkH+o=
Received: from BN1PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:e0::11)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 15:08:32 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::91) by BN1PR10CA0006.outlook.office365.com
 (2603:10b6:408:e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 15:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:08:32 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:08:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Feifei Xu <FeifeiXu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Include the correct pkt header for gfx v12_1
Date: Tue, 25 Nov 2025 10:08:06 -0500
Message-ID: <20251125150812.2046438-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125150812.2046438-1-alexander.deucher@amd.com>
References: <20251125150812.2046438-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a2d593-dbfd-4e30-c525-08de2c347f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dFGXA+NbuEo2kd8fY+puRsvq2SynaNWGnrOrT1cGBNaO1YKkzIsOKKijakn2?=
 =?us-ascii?Q?QhKqHby4LyJuIaHyQxtv51NXWVGAwkmYOM+29VbOZqGUZm+LhkG4+ai5O0I2?=
 =?us-ascii?Q?S6GVKa4jlJcRMMIr6EG/eGfIN3Nb8kAj6HLDlAfZDMYNUVm3uK4dZAH7J1RQ?=
 =?us-ascii?Q?/GD0eLzrMgi06yk7uriSX/GmLT+DG6OtaOdyWwMAkDxH5biDdB/A7KvdIGgE?=
 =?us-ascii?Q?E3MuCUpWUKqJLXtbu1Ek0GCVyhgLwkRgS8BZqFuweYgwLp8Qt084H4LdMqNS?=
 =?us-ascii?Q?OJboZyNphw8meIOPggAnSPNIVl0m2TogykTvF8eswoaQGYtFthR2zyRRnCN8?=
 =?us-ascii?Q?0ExljpTbiqFCQsn+yTYmLW5AT2oGZDHxNrAjOzN69T9XPChanROHvKJURlm+?=
 =?us-ascii?Q?vAvMYBb7+VJT0k+/G72dDxtt1KfFT3fEigX1NvwNKzYZzdGhQBp4p+eM0ugG?=
 =?us-ascii?Q?zqZa4dld8XID4/4XAZGasrEX70Cyl9XAFVU/kUXABtwguj72TbaLv6Gxpv5S?=
 =?us-ascii?Q?5Kilz+vc4r2XnG6B+wZG9faTJLgyoa2iNLpVLxOMX541sTqOjySt7feNngUB?=
 =?us-ascii?Q?kHRG2lBORJ3gV97jv39YCEJ6Md6SqtmORL2XOpaYXfd7eztN+RJ7k0YA/N0K?=
 =?us-ascii?Q?JRa+03Ch05KwlwPxXBZq+9QAw/Z4I2255KizVSJkJfonRIby+Nn1Nd5K6rIs?=
 =?us-ascii?Q?cyha7JWF5oeilCGuAwR5+GoKtNIYvlY0ZT7egATc2o4nJMQIorZGr2PVMTf9?=
 =?us-ascii?Q?AVQg+k5A7mQcrnPAwJPPWYidbcE7356ARHOIgxi97JdSXMoH4QMYVD7ydZbl?=
 =?us-ascii?Q?Q9lgge5f9+C06W94XdMJN6nwcTEudZ1AphcPl3jWVqmKOsztotcoRSV1vc0w?=
 =?us-ascii?Q?g+wGDH7rW+/UT4pl9+uiQsmJka04VnBaBtWJaPCqlArrIvd3CxBCXrsPiPi3?=
 =?us-ascii?Q?0NIc7QDbMGAMhuAUCGzsp6jiG8MNAEkE9iLOm3XsQumdFwBwv3sEV73ToMjj?=
 =?us-ascii?Q?arhq/xP0FCncDFec5Ra3l/dxukLRl23h9A76R80k7h+cJGOmBKuSwg5/RmRI?=
 =?us-ascii?Q?IQAxO16SPmjo+Un3DaPCga55BE7iSV1lMnS+SlUUKu5G/sr+hlGjP7kklzm0?=
 =?us-ascii?Q?+YbCC01T6wGEieK2RoFYi73ZzEl0Iyyt+ORT9GEeP29NdfqfinicSqairkk+?=
 =?us-ascii?Q?yTJfwOBB4yDg+4R7bgB1l3nYxqrb6v/p+Sk/IklrjnTPA8u6IXMN3vlUCULN?=
 =?us-ascii?Q?38HTb55sU4d2fiiyT/yANAc2fh3heQlcjKD/mUmOVWC5RwvX+ZapQr/gIqt+?=
 =?us-ascii?Q?IiGylnXDYMcC2ICUA+0b0l5dGijuRqmyKqFXzwNDSGx4uHsihDIxVIVtCSUQ?=
 =?us-ascii?Q?bVFMtKRa7TEDdrfaHcNgk1dGzx5DL0MDfpRrc1fPSzjb1xRSndvwkgyS/cqp?=
 =?us-ascii?Q?bLe0kJHVV1DLODmsntcsXXUPvCa4Q4clHfHvg4fmiNiQezFiu7tYgeOrOo+D?=
 =?us-ascii?Q?s6M6MJcvquswsjOM+l5RKgsdeHfaWbWCH1TptwF3nUpJ+BWPD/Aq6gen0p3o?=
 =?us-ascii?Q?o+yQda75l5RmL5v8Xjs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:32.3728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a2d593-dbfd-4e30-c525-08de2c347f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

GFX v12_1 should use packets defined in gfx_v12_1_pkt
header file.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Acked-by: Feifei Xu <Feifei Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h | 8 +++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 404ddfcb0e5f3..d7944d6814769 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -40,7 +40,6 @@
 #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
 
 #include "soc15.h"
-#include "soc15d.h"
 #include "clearstate_gfx12.h"
 #include "v12_structs.h"
 #include "gfx_v12_1.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
index f58ce882f2ae3..9a5c82c8db53b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
@@ -369,9 +369,11 @@
 #define	PACKET3_HDP_FLUSH				0x95
 #define	PACKET3_COPY_DATA_RB				0x96
 #define	PACKET3_INVALIDATE_TLBS				0x98
-#              define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) << 0)
-#              define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) << 4)
-#              define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5)
+#define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) << 0)
+#define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) << 4)
+#define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5)
+#define PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(x)  ((x) << 29)
+
 #define	PACKET3_AQL_PACKET				0x99
 #define	PACKET3_DMA_DATA_FILL_MULTI			0x9A
 #define	PACKET3_SET_SH_REG_INDEX			0x9B
-- 
2.51.1

