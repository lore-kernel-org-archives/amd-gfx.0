Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7789D33A3F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 18:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B43B10E420;
	Tue,  5 Nov 2024 18:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TBu6m4+a";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE3C10E420
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 18:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FInlI07C3Qc1btoR0b4dFtZiVTr93Ja1Y82J6wAjJZY9nhu6225ezRhVypFCCFclDcVT+lMH1BsZE27QVqR3zIvBfrDETuSSA1HOzu9PoEzUsvL+Orpgc3mg6TfawgzlmcXwSWz6BcZny8emK4rDcbK5+kTXvGsy6gnhHOlLs7Y0TI0g+7ZvRM++71mZhmIAdzACGnfNJ4QMrIhAY7fN7GItAAKU5G+H+IIhytdXse6Eu5LDdp3xvEdsnCNn0owk9N2PB8Q7eDDyMJ+2uoFpRdP0plUO+bpipujwOgk7kQJomxZcWJoChpA7edEv507Y49wb89qZbIQeaxNtZgekLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CM7uzuQOHNms72fj/s34MlDOCBYv8ajUN7PqsVRBNY=;
 b=RTkYQ/z7x66MuNtdQtexq//6OQb2ytb/M1EekNUVoYdTt8fg3NMFPFYLf785KUAQcoGqr0fvqB4DCBrYGo7pbi2ji9+p4tI02aSl5+71xu93yCFiq0U/D6O4fBAIzDaH/eyn0p602eDEhcMadKLgnN7VzRkMpNDsmjrvygy9FVnLWE231AzuYQzY+0g9ZohV3pHkytf/pyTRPqCa3XrzAbScga42LTRiFpl+DM1ZJGSW2gIq79U1ApUSzj5Ve0/egukpF3rBr+IcKUFjGyBDwxwY9qQatCkmTcrUPb9Zui/mkGKFcWTfc0i95P1K1rPZgZBafvwlvSvFJpP9Ai+HZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CM7uzuQOHNms72fj/s34MlDOCBYv8ajUN7PqsVRBNY=;
 b=TBu6m4+aNY8b9Qbab4Ik2tAYuVX1u+k6LV4wnqP+8epvReDu4+XyIA5/2eySkGlQ9OP+Gp3qvQxWGngz5bJi5axQKi6vIkpyPxzPZ3EQHAQ6AD0SuFlIDdqIY7vW1aqNfuV4ZC8hO9dvS4UNm7pZ9TW+qSWHQnejpaLq1udN95Q=
Received: from SN6PR05CA0008.namprd05.prod.outlook.com (2603:10b6:805:de::21)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 18:45:55 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::73) by SN6PR05CA0008.outlook.office365.com
 (2603:10b6:805:de::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 18:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 18:45:54 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 12:45:54 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <David.Belanger@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: remove gfx 12 trap handler page size cap
Date: Tue, 5 Nov 2024 13:45:46 -0500
Message-ID: <20241105184546.333948-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: e1415c16-ff68-44dd-0678-08dcfdca1469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MBGmNCnZvpS8F9x6Qfctm3NXWAo6/+lVfmA3ZcLXbvA9dIuBZ1xXWBsNit2m?=
 =?us-ascii?Q?ggOfyX+mTlxeaGP4G9/vU6sG24TRPo5Py0u3q7RF+LGUygCtl2tKpT7uKOiL?=
 =?us-ascii?Q?xwll3/Mb18YSBEEzQ5DqImb7F6/2opcVemACT3l6jAFUkMz2Jz2vmLFsh3RO?=
 =?us-ascii?Q?3boiA3m0PsGienUCn2FWZOr3rA+C2e7pmJWllbguzDm5aVrgSKaEP9Ewhj3+?=
 =?us-ascii?Q?n5JgYVKjui1/auZ+yl7VR6TiT8bKz022bjQ9gV4+j82Suh9k8/kIjAnNZybv?=
 =?us-ascii?Q?HJo0z1r3THgcE9+WHCdwegwVI1/SICEWX1j/63y8cLTUcxp7U95cEdyWlVEM?=
 =?us-ascii?Q?e83xjAJp9M8bPZC6wvnljIIOM6vzz0iJI/zG4rICDI/n3qgTx0wuiZXlxmKX?=
 =?us-ascii?Q?sj9hlmyFJIvvSWWxtJN7DC2ZrHN8O1djeCyJjIIofplyDeAYQxLCuu5YhMQu?=
 =?us-ascii?Q?r5YYVfNcEumOgoo6rxTvqpT48bYo2If2FAY0CIA3ivuNIA9ZMHFQi1x00Jv8?=
 =?us-ascii?Q?FreDgL3qAMYXRxz4ekc5BJP6oyDzSDwoFikL4qEwFgTNp7hutf5dhIF9ZMo3?=
 =?us-ascii?Q?9WHzUFP9XfRPJ2z82gt9Anhnc+n/TB6TW5oTUDoudmxIKMOas3uDl7dKJ2zr?=
 =?us-ascii?Q?JhMapRfM0XH0rdOfOFB46JMAqvqEcSoS7+q9YFUf4BerFcmyup/oaYuYPA6U?=
 =?us-ascii?Q?/+NMDoYxDoStXacr/KW8b5w4qQLV28IyiwaiDtq9d1ycr6+9OlrQcFGISYce?=
 =?us-ascii?Q?NmgARNuK4/QYoVfShbdBdXmxMtvY+8zWkN91wwdkUWFgt2S/pAHtyrNtg4nj?=
 =?us-ascii?Q?HGYnI0JfrjBrnZVkibD8JTfutq874fgpJrz9ZRHIkh9wIfiv3kgGFEuB6xBU?=
 =?us-ascii?Q?VhiEfEOgsuGrHsdmd81DrIR8lkwnbx4ul0ILVYwkwSdqb7NSPg7eW+8gt0Ax?=
 =?us-ascii?Q?IM8yBwwIcKByV0dotmR6dX0bZ83VzyduvoU0yG2p2+fqi1vTnxRWHtU0VEqK?=
 =?us-ascii?Q?vTzpSIuGb2sxZqZjibr3lxDI4Q1ofIuiJStViwSrI+KYmt1sEzXk6hGrDDfD?=
 =?us-ascii?Q?/v1vqwDHxovnt6qvC8pzHrAu1kc4p2tg0lEjvrFZcrhqViQSDjC6NFXoCrjk?=
 =?us-ascii?Q?3+FbIf/hGCh7iXVwFgxG5StStIvQmr+uBuUrMvb2+Iz/jfQn55eGOO8Y7eEF?=
 =?us-ascii?Q?xXb4PcNQYVfdiomMeScmc5HHyfIg1iwifiwKr+l7AfBxOGvYX2+kCOQtsGtm?=
 =?us-ascii?Q?miz7HoDg+IamGU/jf4veXZ4aNbzhfFTqZUHBP5PIpWQTcDUHYkqzC9+qVgzt?=
 =?us-ascii?Q?1HgFSGla2xQT0OyRV4hLYpiju5yQy/j4DBkfZnozGQYhDuwpP8f6OyzFDWzV?=
 =?us-ascii?Q?pgB9d1CyCkP0FnoBqzW0dYNZThx9lufkdkSjy9Q6qwvIBrRbMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 18:45:54.6478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1415c16-ff68-44dd-0678-08dcfdca1469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936
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

GFX 12 does not require a page size cap for the trap handler because
it does not require a CWSR work around like GFX 11 did.

v2: set default cap

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 348925254bff..956198da7859 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -534,7 +534,8 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
 		} else {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx12_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_hex);
 		}
-- 
2.34.1

