Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14382CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 20:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0E910E9C7;
	Thu,  6 Nov 2025 20:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZFWj98W";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B12010E9C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 20:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP/SnMP4lLtZp04gPtLKF83avJygMwErc4U7dL9Y30EhCmP1A5u3ggvwAahaA0C0mmvbBjrh86yo7AUPCEnJdlP0Ig7iNzevpVlYwRDUBBWpVOdVVDh8pHpGppHZoZwEdZBftWookkVcAJvHKoIGxgUd7PAC/rbQOFlA4FpfSYsJSDgZiP24itZpb5m/rMbfn3d8n4k1hHKNu5m2GryCcMPyPQTBvKOkxX//RK2BkdUcy+2adMMs8H3BvNVIksa3ImbzuVhg0qOTB5n7ez7nGkum9IdZ+Oz4kd2sl1tQOJQrh1pu+n0VLu6OAPCodDVQD/ZKX1S0NWds/kCwB5LteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/Eax32LmtPxQdH8KJ/j4vK1kD4HLPeh6+jEmYvPzPw=;
 b=s3G0NQx8Yvrm5NeSDFUo8EkOORErJgmkq664hRryukO+AkO3+gHvMQKK9F2sXW5iaHNgzaTWKDkTkexMjskrdP4eZrh+ePOPyeINVGPbDO/1lhM6tbxKN+NnQVBzerEoabAP0x/p5489Xipa3zj0QNw6a3PR0W8/PPsLCRPD5AENPDpFADxT+taM+M+0fVRXQ+G4IXDELPef7FqEyfAfbG8X+6pbT3peJoyaU+cH0rf7DBR8SFDTxgPFz7lT96fJzsL51vPn6AGMljH+fCii5+ntGAywlvMvvtnBAcJsTWYnlfcaFy9JNmgFXR2yWMwnjyQcyxIJ96SfxiWePvPT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Eax32LmtPxQdH8KJ/j4vK1kD4HLPeh6+jEmYvPzPw=;
 b=TZFWj98WaXkUdbTw5uCGw1S3djphWi5IcBZKi8N25bdWvRNMqc5oGWYIlq2ne1upnQV1yW7E086HbPygW/YRfa2zB1beWbF4+kDWVHtC/HHcijcJYdeJHveicuL7zu+FvZn0Gzaa+3r0HFxMONcxKOkgVeYDNlH1dP7q+Y7DBp4=
Received: from BYAPR11CA0054.namprd11.prod.outlook.com (2603:10b6:a03:80::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 6 Nov
 2025 20:27:21 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:80:cafe::a3) by BYAPR11CA0054.outlook.office365.com
 (2603:10b6:a03:80::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 20:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 20:27:20 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 12:27:16 -0800
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lancelot.six@amd.com>, <Philip.Yang@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: relax checks for over allocation of save area
Date: Thu, 6 Nov 2025 15:27:09 -0500
Message-ID: <20251106202709.3242005-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f67a966-e847-4e6f-97ac-08de1d72e30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cPq6LzgkSXdLqFFZnxeEOYm7Noe06ir5GtwcAd5gQ53M1MjgEf/kVBVSBnta?=
 =?us-ascii?Q?UV36cbtlaxFz8A57/p6YXxsbvbnUzaYqUiBMd+L39L+sEKpF91GJ/zDrsNOD?=
 =?us-ascii?Q?ch7YmLwiqFgTmNlGpZblacTL0PnWSnkh92rDDDfY5IIsa86UlYQ9O4ivKLbJ?=
 =?us-ascii?Q?IUFkLnFCXecQiVrxYEut2HF0B4S71SCZMB5iK4UalLGANN/bEePwfZYey5AY?=
 =?us-ascii?Q?YbLGVcFk4tgchiMcGw07TkcHOE7baoIFzcTXooenPsMufQgryvI0mjEOQpNy?=
 =?us-ascii?Q?wai8doe8Q3sgtWhgdnSOd/zNsFPqHrNWZETRv6Rr+kGd7UugHlAvCzVQgKUd?=
 =?us-ascii?Q?xDvvvzEhhSpImu8c4bU8sgX0Usyb/vBp/YJH9P8HX/LD9qzxKQXowEy77beK?=
 =?us-ascii?Q?vvdIXcv65sGpboqxMiCidAxrluvL2vLTP5a5Cqcxyhf9PyUf734y3BAxWDCz?=
 =?us-ascii?Q?DF0MYDM0UCvhC7jzZolS966+EhOgTngHzUmnaqBwrBvCqkicuPChnRjt/KgW?=
 =?us-ascii?Q?kBDweB6MPoimY7pjrtmFBsg/+X3Z/K1t11RCkjWeTyy96cL2S0IoPd9FfRMZ?=
 =?us-ascii?Q?WubeNVE2qh7baqmSTs/iC9HMSR0p8kzrugsM/UufeBuWbnSxJr68gdvaA1d3?=
 =?us-ascii?Q?CdPXgtdlL5/+FGsc+q/5xtRknInGkx09hd1fP9/TKoFohAbqvej/kgMveINz?=
 =?us-ascii?Q?6II73dxxA0mAF5B0VzsQ9ONra0/q9jADV+kJ89+POnjimwdVEk58UCOhnmkj?=
 =?us-ascii?Q?B3vLABNYcdU6gRdcusHltgluNj75fo5C4H25hNxGNdsg9h9XRoItzKtOLfPH?=
 =?us-ascii?Q?ScUW2TViW1aNz3/fgXGnjnP3rvC6qxFA+7KhFOz5UvC7EhOB+ewHnSrEvmhr?=
 =?us-ascii?Q?J2CWfWXxCG/906FjcE704zGL5QEbw/RHpyaG9btHDaRoqtqTnjKfknWetB2J?=
 =?us-ascii?Q?TDc65+rF/cAbl6Q5WC6+4tpNOwvrHrGc/3tyQL+yNeCTitPcnBkJZoPbyZFT?=
 =?us-ascii?Q?oyUbvo2mjnKKU1XloeI9NbUtk4arttiYKNG8t2YiW2QrMB4Tf+xHPTRkc14A?=
 =?us-ascii?Q?Q0Qo6RHGGtIdey1fvwWjT1QH+jyc9xlk4X4OSjnc0+bUoxP9r0RNypGl2tRD?=
 =?us-ascii?Q?M1DPj/TDdJLP3rMXxWGfcg5o+vhbmwX71o1w3ENtMYUK+YRBHO/4rkq18e8K?=
 =?us-ascii?Q?H3w8RugqcuA0OOEtoQ3ofNeLf11KJjcwTTnH38O7/JEUrJUOBKU0BwisEJpN?=
 =?us-ascii?Q?ozStsv5sYUoe8vfKeSPuoRYXnSgII/DHfudSHR9WRFQpz3VKAULVDEOLY3aR?=
 =?us-ascii?Q?fvwTXQS/mn4M+j8PFuZ/GRW94yCMAOBY/n3niDBPybh1wmfS/c/rIGtsaUGk?=
 =?us-ascii?Q?vtdFhwIy1OPbIkpFGbkcjs7500OgCj6hMwnXV+RLqhf5c7mIFwcZHoCYQui5?=
 =?us-ascii?Q?fTdUKtUB+Ay0zd7z1SAjfkyaAQ8dxae9hsnzH0RkLRsg48KvH9oMx//EWyyK?=
 =?us-ascii?Q?vTbn5Aq7V6E0fkC4kRllWk14s9fYWV1Wz62/Wp/S60j7ATf6sz4b9NW/KT8v?=
 =?us-ascii?Q?+j5xmxI2qSUoUoxIGbg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:27:20.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f67a966-e847-4e6f-97ac-08de1d72e30e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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

Over allocation of save area is not fatal, only under allocation is.
ROCm has various components that independently claim authority over save
area size.

Unless KFD decides to claim single authority, relax size checks with a
warning on over allocation.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index a65c67cf56ff..448043bc2937 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -297,16 +297,21 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 	}
 
-	if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
-		pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
+	if (properties->ctx_save_restore_area_size < topo_dev->node_props.cwsr_size) {
+		pr_debug("queue cwsr size 0x%x not sufficient for node cwsr size 0x%x\n",
 			properties->ctx_save_restore_area_size,
 			topo_dev->node_props.cwsr_size);
 		err = -EINVAL;
 		goto out_err_unreserve;
 	}
 
-	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
-			  * NUM_XCC(pdd->dev->xcc_mask);
+	if (properties->ctx_save_restore_area_size > topo_dev->node_props.cwsr_size)
+		pr_warn_ratelimited("queue cwsr size 0x%x exceeds recommended node cwsr size 0x%x\n",
+				    properties->ctx_save_restore_area_size,
+				    topo_dev->node_props.cwsr_size);
+
+	total_cwsr_size = (properties->ctx_save_restore_area_size +
+			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
@@ -352,8 +357,8 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
 		return -EINVAL;
-	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
-			  * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = (properties->ctx_save_restore_area_size +
+			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
-- 
2.34.1

