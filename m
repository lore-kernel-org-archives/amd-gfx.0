Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC286CCF9F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF8010E75C;
	Wed, 29 Oct 2025 08:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="loODC9As";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7900F10E75C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdDa57g0ow6rHO23lAEqTuSo93SLqiehwBDdxRsO4IJrjRUp5YWi3fl7AyeDlnoGbe4IXkumwDq6Sw9pGvW6I3Krf9HS0J/gqW0WIFmnNI/ng8/jQSOBKNEOF+Z5gyJ5ES63EFYqjHP5gEvvknWnCjFhbmVMjKkbGk5P9xAZl8GcY/EDImxRwWDD4+AXl/fqCcpx7G+en/9X041aGNvr2HylSBEbNSSdRwPUukLr/RrWp1Gccvv6aRb3RkoA3xbiHsY0Uzvyoh51vrZyW6X6evcn0tfIyKxXiFY6sVCCuUAsZYBzkR4SQ3gdEstlX9ylrBrZ8rukp2zVfeQM885iTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEKcN3xy2YqV9++i0bnnzbj3QzqZugAdNiU3AZ+xEwc=;
 b=fmoL/j9FzNdHvzQwhpyN+A1Rz5n/TyzFafZZHrUHHFH/krc9UeQiGBPFYLURWOxkRAJfFyZccQfpqhedKmSxDkg/OTdigetD/AhyjPN7/BvJuzaE08ZpQUXa/y4aM1uq0ngkZwakHSEkvADOAO9wrDG6txTcvgvKpxEUfLMLKjMD1EDL2PmoZwGtbbKCXCMywLW6diUxuKRXE9gXyX655I9RB4nf2FD8WR6giTq5jmp0epwWitN5MsK/XUXwfH3vuHN0zcsQn5CP3HNfHZe+oJflQSi9JTFex1a/PH2FWSPHysExaxz7e0UWSLvl8oRCBBBg20sG6l7bgDeQLsiMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEKcN3xy2YqV9++i0bnnzbj3QzqZugAdNiU3AZ+xEwc=;
 b=loODC9AsSc8NY98mnJ6tIbkGkZVfiYNE+JtIkDJBgQh37wEENg4JVRMmj6UxPzpNDov+08m5eqzBmfMf6I3q8djwpjD787SywEBQ6jixb2hjLs8NO6VvIYQD3ULAOFyzWiqBfZ/nY6N5DBQTGGCUDIslbWC5oyeSulfTAnM4a7c=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by BN7PPF915F74166.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 08:48:13 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::13) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:13 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:09 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 02/10] drm/amd/pm: remove smu response check
Date: Wed, 29 Oct 2025 16:47:43 +0800
Message-ID: <20251029084751.1701305-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029084751.1701305-1-ganglxie@amd.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7951c3-896f-45a2-9c93-08de16c7e585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xJgz2Hj055n8xYjpxWIz0pWZ2+9372Q/pzL7yLH6cpsHgz9JzZgQT/+zOWpG?=
 =?us-ascii?Q?sy0OzUItkVs4FfnsFc+lcpUNvK/WXdq08QaJUqoJK9t4HjOavW0ffJaEE0tk?=
 =?us-ascii?Q?kFqoGCZQqA1fgmmnqn8Lvwj+HJlPRGEWr0gStNsTKlJTPZb870PiHbSKBijK?=
 =?us-ascii?Q?tlxZUisoE+GCc/qQU0e4d9iMkazOwE7A4isLXE2bwnI8DGhf/+1WZBtcm7Yq?=
 =?us-ascii?Q?1uvgFDkRPgUpRUuXZpn8p9Ql+pNaqLYHn9peN0c0SmVqYBqylva+IfxMrFQ8?=
 =?us-ascii?Q?ch/SsYqT/r+jpTHRx/pRxpVsJ6K/omYdcNMprboDuF9WdbwbqW5hpIte4jgI?=
 =?us-ascii?Q?wuv7vlbYSQ8sKavhAvQS48lf4xhyWvQUUOul/3BpVermuCMqsdI3YC0Nn8Yp?=
 =?us-ascii?Q?yaX59GZTXupem2gao6IH0+3SrnnVN4fFoaqXEa3NSAlfg5VcUc3Yt4xL6KuV?=
 =?us-ascii?Q?JXVJ8IIxavxiaLIdHFyd2lwrOM5ticneo9e5BhgSRfi9FnrCWRd/VN8ZZY4z?=
 =?us-ascii?Q?7ofVUAIuIP1ajaTzWYRPbhb962FVokF+/EqxxhSpmZdrIuKQ8cuNtFl7m3Wh?=
 =?us-ascii?Q?VP7ALTpB/dCDlw1djeXhcDaqTl0X30z9rk7eLk2tbUukUvB9diBsuIyn8SPI?=
 =?us-ascii?Q?BMy3zZOzeNKkB4PdohPPYP2LzW5zq8E1vAkoh6wIB5IjA1w0NL8FiKT4sBZR?=
 =?us-ascii?Q?rI/d4QdbGdUPhf7euX5QkBb12Z6FZZaN003kh1dkQ7p/CtWV6RrfmfUXvnwH?=
 =?us-ascii?Q?Vlnnx3wwKhF1777i824S25Gml4aanmaD7TvOYKzFFJ0Ss5Y/8Ii353LJaD15?=
 =?us-ascii?Q?n+QUAjQ0ThdCQ0SDbzXmmdpDTvFEQn/xSvxfGpwWPfyjP6Ew4CSjfyC2p5sb?=
 =?us-ascii?Q?Kgocbrv27JNBQybC9JE22ga9/XJOrovi/sS9r9HAaZtKv3PuspS54Z3Ln9GA?=
 =?us-ascii?Q?i3nl59VGUfoOBoizW2v2THnCgQ21KgvN+jTxMLwJAJQICA0pVSsmHDhxADkf?=
 =?us-ascii?Q?Vfy0GXuRBnp0nbPqGqjes0UlV+ILn3hjENdZ1CSR7607SWx1DebB3TDYTBox?=
 =?us-ascii?Q?EbPdRTAl8bg5IPNFqMw9jgIzdRdyQCYcXsvnG2m85mFuHCJkHXuTZ3CXRV1D?=
 =?us-ascii?Q?qO6LPflIJnZHm3gsNFDCXgcTI8ZFxXGoUSF4O81QcTEMw6MOp9JzI9EyVR8p?=
 =?us-ascii?Q?K0b/mMK/pSFNq4+CkAogHhtkw7kYJqMYcpC9VAin1x9DoPFZQmHDvbUBpta2?=
 =?us-ascii?Q?MYRNuSDbJwdfFX6P0V4VtOfdutvZJvi02Np6w1OnGA1aDllaB4ZzMia4MzVa?=
 =?us-ascii?Q?I8C3TPlV96MkydS8+2zZHhEanP+RbwBeatyqa7t6kf5uZNstgoFtuGcv6FUd?=
 =?us-ascii?Q?jSjX1SsSUTjoopB/06MGA2wPynIPAcp/lX/u2CAt4lmHZqmHdKlL2LesUpX6?=
 =?us-ascii?Q?hrDRyzqgLruQli/Zeis+1Y80NZfd1LAzJLLZyJHR65m8p20e8EIK5Os3jTIz?=
 =?us-ascii?Q?u7uoEWqCPXMbU/RBLOUP0hIKlU372ekGR6stmtWjxmWbN1QxIMKKNcXmVTum?=
 =?us-ascii?Q?zU5Z+OyBqUmGRPioiik=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:13.7807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7951c3-896f-45a2-9c93-08de16c7e585
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166
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

Remove switch entry for SMU_RESP_DEBUG_END to process it
in default entry as a generic error, because its meaning may
varies among different socs.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a8961a8f5c42..eea5ff69e5ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -168,10 +168,6 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 				    "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
 				    msg_index, param, message);
 		break;
-	case SMU_RESP_DEBUG_END:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm debugging!");
-		break;
 	case SMU_RESP_UNEXP:
 		if (amdgpu_device_bus_status_check(smu->adev)) {
 			/* print error immediately if device is off the bus */
-- 
2.34.1

