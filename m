Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FC2CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3C310E780;
	Mon, 15 Jun 2026 23:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N5HUBX66";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEE310E77F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCgUlJKAceqVo7JMtg/1gRasBSItTMNUjQs8NsQrBPZ73cemN6enhj3eOelpHre+mYHUgo6Gfr7AKNYZbxA8uctH3xt733fdZ4BQyoLmvPSFhnJXF/mbpG/aWadMh6M98l+inxsCV6CMvsHv/0/fdpwGzcDzJXzZp6zo65/5Wtiennu1o3qrJvftWXrBPKAEKQFQq2wmR47D8EKUauyjgyIpKU2aoP7k4LpOTuH5XD+C1go0pym1n8NO12NJhdgh4iOM1EIM1FKzZkTXvmJkUlov8cvxPfC315oPAMdBl5PfidRxE487i41B0xth8D7e7Zcfy5bd1cfWQjOsaqzQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wYmnMCQPfeMXMXuRtQDDcE8gHlFM/wnxq+QVXjGP0s=;
 b=sPqr8/pDmiOmoJDYJ1tc4un3k0cf8Q/4xc+mbPsMCxohihq//Ab/pdfNHf+HHDnUZwRPTqEOpn0G2tfqpljLVNo9HJXKETXZBCeUcMxGkne+1rFLT8Jahb7MIQmkGi02x/LxPYlSRWDnnu5zbwZOgCS8QoTalPXEOi3UrGgU1xArl4MgfEgX8ukGvOdNybE6ymZ4MSJXqtYZXxnJyOYRVA1BKFRabSkwIKavNF0e0E5bLffFkpBry0OHuUWjlopu/ED1PkjsMTmZZdhMIwUOV5zgeQAW0lUBhj259kHQP1ndbymGhTGQGAi1JhU97cmguoepG9Bsud/XMeyH4G+AOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wYmnMCQPfeMXMXuRtQDDcE8gHlFM/wnxq+QVXjGP0s=;
 b=N5HUBX66v+OUAW0iSyggyJV8k30Mr4yYhFg+Un5GDH82z/yOmK0NjOtJbrfJErfn0ZhXxn/p9+4+h6Nj9fX39ijRtWXzLq1YlttXd3IJANKDXMgrjs6hdGCAehQtsOpBUN25teCMZzE/kXX8vGzt8BI76JjqLuiEUbnCtuWj6lY=
Received: from CY5PR22CA0057.namprd22.prod.outlook.com (2603:10b6:930:1d::31)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:15 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::33) by CY5PR22CA0057.outlook.office365.com
 (2603:10b6:930:1d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:57:09 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/43] drm/amdgpu/psp13.0.4: replace BUG() with an error
Date: Mon, 15 Jun 2026 19:56:35 -0400
Message-ID: <20260615235645.737189-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 476b0294-911d-4a69-a832-08decb39d317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TPOPs0l1Q5VkUx5EpgC4R0cNnJtPFY56u76eNhz+v/S3NVNj1Uhe96aYryQ+6vBPUFCd5gu+MtngiWl9aW59yEVeP4IK3R47FOVoaHIfLGdMhN3QLnFDzlOhyn1oq7AKxTAfUeQA4hgUrEgayFQ8IUbJ7zm0jLY/ARz8E0ccgw8FrOI0WVkqoD4fRexjPyH8sfeEQnBF5WgsmuMoPGBwBxhv387vQFRSeK+0otIXF7HzwbOAdHX7igiXejTJinfBA+Mr4sIJ5MxLIMMUYLJdB+JAelvtuHf/uir/Z3YIU9QkdqrdatNv466hbxCi2io54/kAWYGlMh6ROcSWV/x1tOoQmYOQCXPIL4BzKNe8XUQSeWiwQnCOV5qzd2aQfU0JatVykFuKD0Or34eN5PvIGz3ve4OQA11qds42zQux7wTi42Zaltb4kGCgPY4txwWuwG7nZBAFCf/gVy2G40ADRQHpulNGoyhf4EwsrMp8sjifOwvdBkmDSokccLU5ATjZ68Z6FeoSU6lGq4CUGUkpNb8cWp5jkP5nBX/02mzgdndhdI/AU5G4Cethy/oWMrAbj3SEXYFIuo9Mfd5vbt2krS58aA+lt77nIC6dVqhh5EFUSfDynxxOHA5B5VZ9wWLIzDIa18uzp+51kQRh1hjkNAb9yzHEdJTwLPD5MD5t3+Sh6D9U8tAyDqWOjAqHjBL5MJAvTFk2fbTQh8sa0zYBoFSjt2hWlIA8dLols9IURuo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xsZCf7NPz67om9v0W9a6jKJf3zL9QxIyZ+ry3S/nWFSzyAj+6p3Iwob90eI38XTVL4Tcs25uOs49E4QC+IR0hoW86+QMKaA0/r46wKEYXxZrnZfVJc7srU6YNigtd6867uRNdVEDL3EWkFk64HmmmGHvXywk0sxACIQk9sU0/x/jruReoOUQtb9NSPeYtGkLiZkNGo4OwfuX2V+ErxHN88FexW8CQGZfupZY3Asee2LI2VlJMJfYXDtwzL/yucDqgR86bljGxN9oq/NbYLqQFIjb5dLDAyXZ5srfJQ+go+3Fn0fKld15JM9KY/VyuUCSMMtY3n7U5xpwVuwotS+LzkdVrYiedfhf1+6uhgE1ggNU+DdmVl0F/mK1mQHdd5MP/B9tavUvnv+D9fVBotUmQfB5vDfPDeqqgjeeHr+CtAemUchiiJLJFk6vpKQCWGL5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:14.7762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476b0294-911d-4a69-a832-08decb39d317
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
index 3d5e26b3fa00a..caaeeef27544c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -50,7 +50,7 @@ static int psp_v13_0_4_init_microcode(struct psp_context *psp)
 			return err;
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.54.0

