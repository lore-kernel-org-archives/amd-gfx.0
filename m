Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D685EB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DA710E602;
	Tue, 10 Feb 2026 21:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2mnFTvEX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA37E10E602
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZU3V4FMD2pTBsPZl6EIhNTCd03F7F6XTew/0Ucnlb1w1BWiZHyRyAq9FYDR5P/IS8La5ctsdW4VqraENV+HIvfOa1az09j4P99dCQXK8k959ptKpeJu2++hNJpQht0T9q16JPALiVlZTIGn+Zw97d2yHKi4RuMAMASrAJZCx7GS2KB8fMwMqaDd4iDP8Gu71+U+Y1akHWjUUcCKaQxFE1dgWR99IVOZKjZeINdgpCP23R+ee1KG+bx25QXTYYzMfkD7HwJ/O+0i8NTftLylyYAfJXg9Dq//kky/jO+qeArprVPitxN9cl6Y6nDfA03ZNDu77XEDAaf50aCNzgQQdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P452fZCjICgw8uBst7aaF+6B/sK0njX6VX0OUOsfeU=;
 b=PIUwnA3iAwUq+gWYRF9rL7MhWu0R40ppdW+58oYz2NeqkGPDzmg0v2wSXWtg1EfGG0VCGdf5OiEmPCpGGL9g7nazSvrrAswMINFnSFsatNbQeK00f4Owu2DVVl4H9OyN2kmSV8nIqxC+qNogD76yemgiJqN1+RHzyhF1vBjjWaj2dqrbRUbJ+uDM8rOd/Sa7qDf5h7jpGn/Gd4Slbn5wYEAu+LXOc2762r0Q9Se8hQvnwegJOrGq3hSbe9eFQJHTdeW8WCiqC92Hrm0LZRaYRR2qGNQYrZOnhLSkG27FYFEf3JtWa0b34+FwOH//OX8d+dfUHqvaWMbPYts7E7gvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P452fZCjICgw8uBst7aaF+6B/sK0njX6VX0OUOsfeU=;
 b=2mnFTvEXf98nwOEXqdFLSefXUT/fqo8BuUVeV6oBEryHOAyhcNybmY9eORd1d/8+8TWqQ2IcfOdfuhhnWpcu7JSUlOcQuue1AuHa2k0VHkI6hKBWwY5LSCTWt8SXJ7KBB71Q+OIuXdfeuJnu77D4cGgZcZCDncJ73y7CIRuQCPY=
Received: from SJ2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:a03:505::10)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 21:48:11 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::9) by SJ2PR07CA0004.outlook.office365.com
 (2603:10b6:a03:505::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:10 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:48:01 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 "Saleemkhan Jamadar" <saleemkhan.jamadar@amd.com>
Subject: [PATCH 12/14] drm/amdgpu/vcn: handle interrupt received from fw
Date: Tue, 10 Feb 2026 16:47:27 -0500
Message-ID: <20260210214729.80964-13-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e1efd4-da81-4d38-398a-08de68ee1596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vb0c8Kf94CKPeXzVbjpkpRHsjpl9NmP07LGvUlLy1psgmdVmuJSg17PxgfF4?=
 =?us-ascii?Q?WRuOT98TqyL2pGua13IHjbDK2ra+QyTBEUmS02lYkXlRIHCwMmAhynGptr4X?=
 =?us-ascii?Q?RPAO7v+AjJjKAMUQMQiOXR8ps3kYyr4tsu3hhiHD3m2DC0XzyC26L6hqpKKa?=
 =?us-ascii?Q?SZiwV0b20a3Mf5DF9fnNsbo2D7kTZ/jB6BxOHVCdaowQYPXqoobdwwzYYZf4?=
 =?us-ascii?Q?TsNEJefr22ATUuC48ZgRVduFRf3CO+OIqEs1XMUb1rTztxahw7n/njDFWu7U?=
 =?us-ascii?Q?w2XPyuSOXapF1cp5hBgoWHStTbLEhhqjHYS3A8fSwiMDKlXfCcUWCm7U6EO3?=
 =?us-ascii?Q?INB7qZsay/AMtw3lKQiyfQNtegEk7zGyXYmTqVkO4xQx94ThtRWtStDTnA1M?=
 =?us-ascii?Q?b6BI2FeQ6RKoIx1w7Vw3XGLYglH+fDpH9xdHM1ktbs/+lIdcrR//KWmSjeYD?=
 =?us-ascii?Q?w/J9QPLwNYScWr9zmI5lcBzo/A5FGmuVHeGT0dabegQLNRXTxUgV9w0/qVbf?=
 =?us-ascii?Q?FrPW905p0DkaDsXFF3tFQMRJlkRUU+bqiu1ZcVgKCs79md8XNcR8h5k2bf+a?=
 =?us-ascii?Q?dcLIigwAIie7jlL3nXKtPVhrU3uIzj9G3ll9Krr9RAWwRJdPlRbekZc/f2GW?=
 =?us-ascii?Q?M+7CcsgR7jBNdcgsX2TPG81fRfmPaY+ojMg9KOFQ0z2BgUO5SJ2pGSNAe5IV?=
 =?us-ascii?Q?Gkf+SA6jSpvmfkXZ8M1B6tRW+v3WbJkHkHIMEws1nGPRvm8PTUXxUgaURR9d?=
 =?us-ascii?Q?vQfOet2cdpt0Q4YFtkE2OlYvVhmHBFMXKRf7u6weHTf7qmP1cDmeWwb84GWe?=
 =?us-ascii?Q?V06vahT4d3egW2QHsjG2QIiaZ5zOrL+tB8oRMPVhdlRTw4M+qT3tiQ09H6u/?=
 =?us-ascii?Q?TLu017Bfs0NXKmYAtjjQZpohbcsCE4SvGAWA+jI4gtPJE1zGZKm6V92qbb+w?=
 =?us-ascii?Q?0m0S6EYwI7kjufdewzmtT8985RW8m2lSC8bDiMZTGveN+2Pe1PAq97ACU9IH?=
 =?us-ascii?Q?Dr31q2mOWOuheErH3Lo99NFYmVvdxHDzw/PSXVSkmZ4tvg2Y2T2/OOTti6Yc?=
 =?us-ascii?Q?R97csSsroBfrpVMAkQHKRoe5C+/iGXQ4CKKcplKrRKsRL7k8fTxLVibnO6hl?=
 =?us-ascii?Q?zG3TPxPRr0acCLf99jYWTbraSH27A5l9nbXaOIe9nvC/Jm6SsZBF3UwcoxiN?=
 =?us-ascii?Q?RY+rv1FUDsqihC5jv9SlXlYOkG1NhVzMv3JzfsDEAQ7WpHUsGc4xbu8w94pd?=
 =?us-ascii?Q?yEZ813xgmyNd2nJYHHxNykwgh9bYd9N0dV3hXKH9hai7FYKYwE9MUw/TCzEv?=
 =?us-ascii?Q?ZQNqLsW+vMqO7w7Tfun72sgqeFOPHKj0nICzcUfPdBOVdMTPBENtUKEJisDi?=
 =?us-ascii?Q?IsjH6eTxCkwVg7mgO/bjE5aXCKx5BuBs3nqak+ICcpUcfFDExSHzwQtGRAZ0?=
 =?us-ascii?Q?UFC+QNML/xn0w79ZFeaGaz+NN/1bmvjflffvJp+Tbw93uz3vweJpGqypsYZc?=
 =?us-ascii?Q?IBATdeEitR9uW/c7GcycjxMo1dlSMYStydwr+HPGZVbEPp/ACHJJWOiXdN7U?=
 =?us-ascii?Q?zNI5zwevPo+/myGJ1Hk/zxj6GPjgjxREkoWUClOKIVh/lpr5LJY+nS8bOQTm?=
 =?us-ascii?Q?9/7FhjPjK4Cb1hoXMnV+TjzIq6uNiuBGEzyD4NJ3CuDaLPTRhj/vvvxzgvsR?=
 =?us-ascii?Q?8rCu/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PTe+hmHpcETt4KvTEta7cJ/+XCdl4FQMtDJOx8VNT2MZDfqUGyFbxf455Kab/pbI5mbquEZRF0hUN+DQqHwK6oGA+5W3+F9JPz8WdXF/LIpdyIpWyRZSFwRfBHTE8pmcWiUBRX942yJLZDeAfnR/NV8WscMosyd8J04u7mpwEb83jL9bI9ZXmM3r+Z7UhJEZgCne5dcpJbmPxfvA9rWYPD0pSf7satxoyUEFw6bf/RFaLZZhpqkxU7g8lVjQV31ntdTMa1IAQ8cIJSSG9yKcQ56n+3enKGx1FF7bEuYMX96o9VtLCkn5LGh0Z++K47tE0C+0ATAADfv1k0ztNH13De6NRVezxmNAz8uegr7Y/cTAytpLGD0Ue2pIT7TZlEUgio+iElPEz4gKNeSaGgXT1CwLE849L/nx/8R5kw68RXKspeDoljgh4jbp7hjs242y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:10.5524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e1efd4-da81-4d38-398a-08de68ee1596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901
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

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

User queue fence driver handles the interrupts received
from the VCN firmware in case of user queue submissions,
changes are done in VCN interrupt handler to process the
received interrupt and pass to appropriate fence driver.

v2 - handle the case when kernel and usermode queues are active
     to service the interrrupt. (Alex)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 37 +++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index d2744cd4c865..c246a932a4e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -32,6 +32,7 @@
 #include "vcn_v2_0.h"
 #include "mmsch_v4_0.h"
 #include "vcn_v4_0_5.h"
+#include "amdgpu_userq_fence.h"
 
 #include "vcn/vcn_4_0_5_offset.h"
 #include "vcn/vcn_4_0_5_sh_mask.h"
@@ -1666,6 +1667,7 @@ static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v4_0_5_process_interrupt(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry)
 {
+	u32 doorbell_offset = entry->src_data[0];
 	uint32_t ip_instance;
 
 	switch (entry->client_id) {
@@ -1682,17 +1684,30 @@ static int vcn_v4_0_5_process_interrupt(struct amdgpu_device *adev, struct amdgp
 
 	DRM_DEBUG("IH: VCN TRAP\n");
 
-	switch (entry->src_id) {
-	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
-		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
-		break;
-	case VCN_4_0__SRCID_UVD_POISON:
-		amdgpu_vcn_process_poison_irq(adev, source, entry);
-		break;
-	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
-			  entry->src_id, entry->src_data[0]);
-		break;
+	if (doorbell_offset) {
+		struct xarray *xa = &adev->userq_xa;
+		struct amdgpu_userq_fence_driver *fence_drv;
+		unsigned long flags;
+
+		xa_lock_irqsave(xa, flags);
+		fence_drv = xa_load(xa, doorbell_offset);
+		if (fence_drv)
+			amdgpu_userq_fence_driver_process(fence_drv);
+
+		xa_unlock_irqrestore(xa, flags);
+	} else {
+		switch (entry->src_id) {
+		case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
+			amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
+			break;
+		case VCN_4_0__SRCID_UVD_POISON:
+			amdgpu_vcn_process_poison_irq(adev, source, entry);
+			break;
+		default:
+			DRM_ERROR("Unhandled interrupt: %d %d\n",
+				  entry->src_id, entry->src_data[0]);
+			break;
+		}
 	}
 
 	return 0;
-- 
2.43.0

