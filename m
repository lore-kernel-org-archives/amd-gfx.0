Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174CEC27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6264410EB0E;
	Thu,  6 Jun 2024 21:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ed7dCCAs";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B90510EB0E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLdnDpwJsKJF0KHfkw7TjD4xYW/YqrFDJUUO74HQzHSisTVS2l7PSU5eQFoPjImTr5EWRaL41SP2TzopMHtMQyHzETayCQhYB5dMKE4o9cQzcphMlO9DjGIqoZHPAr2s5cMQ2oaW/VLFzK+Q4y3iEhIlW4CdaEJwubzWcvBa5AhDuuYw65fJdkhiEwk2hiX9GzR4w89ASS2jDOB/wB8aJM0qp+QB2y4WH1VbR1l88kB9ViX4uG6dpukgxWdUDjkpR8UKTVFoUqp/ie143/WBtIBUm27iyH1SJtfO2tI7YzbzjgrJT30NXTxSrwjBmuBMDSXj5pPNIT3Fshtk1ZCDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNJRXHzd0cBFSIPyGiVByRdikgzYJ7YfD2eVFeWCakM=;
 b=bCb1gFQPAMf2CxFBqGu5Q0N+FBT8c3YSyYJQAqnwCiSfWF8A7Xss9ICous1v3hCYWEs0rT0l/ZBhcjzNF260e2WQkmySibNxcLdibFUXYJ5AJP3FTGNOfSXaNrCdxJT5bjUOM+PFzBXvHncjjaz8ORPqjfFUHo7G/CY+zZKWa3wfPfgor2TJ8g7DJnTbg1iOId3b1BT1Xl76YBrbpKEgGFawmgawAWPUfp2N+Qwaj1SHLncz8Rpc6OOR5nb/52n/GAnXuMRDcuA7xJCL2qDqS5lKN5hQtt6ld06u9LjrtK0cD6u82ZNAolOLNu+PMiTo51tuiP+Emc5tRuZ2s4eAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNJRXHzd0cBFSIPyGiVByRdikgzYJ7YfD2eVFeWCakM=;
 b=Ed7dCCAswV/IIuw9QAV5SCdEz8AuqEbqs/w9gm8dPZlbhSks5NGY/82XfAFENFgtoSSLMHeeGt/zpAtd03PXy0e2jkYij5YNJ1ZgAHKOZiSl65zypo+mvrauyRBRu2LFB4yUm2nGCcD8Lr2Jt4ET8AwcqQmE6lYnS0FQIWcpKSc=
Received: from MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:59:10 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::d2) by MN2PR15CA0049.outlook.office365.com
 (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:09 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:08 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 62/67] drm/amd/display: Do not override dml2.1 reinit
Date: Thu, 6 Jun 2024 17:56:27 -0400
Message-ID: <20240606215632.4061204-63-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b9b08c-7823-4dc2-d1b5-08dc8673e4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h8F1vvTTR5ponTHW06QhEDIWy94SbRDCLK3XGE5r+SzSRzplsI4Znt7CyKNj?=
 =?us-ascii?Q?Ei0LHDahHI8PLXeDmFdQ7XxxrhQz+YPVdAoZM1gMvxpwb2AWDfknXNlr16uy?=
 =?us-ascii?Q?9KgL+VuziONfDshXFoJzIOQwyKumA15uwSraL2VKyw0HCTxvmDLw/4km1uut?=
 =?us-ascii?Q?vRKHXI0+quSuf1fYYXMt2D9GKQhMUiryU7go/rW43nL6x0iNbv9/KU7nlj8J?=
 =?us-ascii?Q?OWdGn+6KKHkkCKsM5J9pO2tjn6CUoLh74weBIQqUCcbPdiIPbcs/yJMYDTYT?=
 =?us-ascii?Q?KS3sO0lTf+TGlhaR1lUGM8TPpi37AkgJfLXC207aqueZVV70eVmS1BGr7gNh?=
 =?us-ascii?Q?dEQC7Anf6ViWBXZS1lEJ/H8gp9v3PSBrD16TDk83yqVVQ7KH8Z+ZdYKjvHK6?=
 =?us-ascii?Q?BKN8nMozJWZZT01oJ8sYxqR1J0TcwmmcWreM+kUVe6djHlmW8siPpNrr3CoT?=
 =?us-ascii?Q?uovsR0k4cqPhjCda1fVFH02wSxbhHyCa4btazdB+THydtxFuSv3CgMFBM3xo?=
 =?us-ascii?Q?RzOWak6c2f2v/gkHZTbItLZFS9AgezoWxSb9U0FnSy5xtvxuFpGvM43nL35p?=
 =?us-ascii?Q?lu9UTPpoEz3Qgws5/e2HGAln1w32ZjFCS/gx6EBVvkt+t//EL3G7i0H8WuMn?=
 =?us-ascii?Q?1FsaUostGYqRl+wdxAcLuAk2HX1fCQF+yQG7X+JprdWvuTROMHSw+Poq3OJC?=
 =?us-ascii?Q?V06hdBXnzEv6NDPooYxnCmkkAkkJ5VckI5hr92/wAU1W1cFprkDpFb7rZc7B?=
 =?us-ascii?Q?XtnyWcJFq3zNd4iTVMWhamJXZ5/X+958r0UvA5i1oeeuVngemjz+2y8vAywT?=
 =?us-ascii?Q?zZHh/8D3Wmpf4+EITnHv1I3e7ng04gBuS7vIVJ9JIiLDI7KSxJ8fEpT8tZAH?=
 =?us-ascii?Q?KT5KwzAm5Oei0egmwEFRkldjD5jKV+92+Ao0h4QNFDZX9CYBWxF/EIsJPFyF?=
 =?us-ascii?Q?TMqPrlXIX9PkHjBwxgMt68wrrP9oe/zKs36N653eU7SjfWv+fcrOVrm0sb7p?=
 =?us-ascii?Q?vaAMaGwiptb8sknuAaJvQGUi0ocRmGZuaNYFf4gevL8pXgSy/qm41KIa4B1H?=
 =?us-ascii?Q?lDTCumvXDiUbN5V3G0YD3uDc9/YlC43IuAQT1Y+h1ifXvLsyEjVaeIlZzUD1?=
 =?us-ascii?Q?hl3itc5fqXm2U/IBxt4yZ/obVNe0M1bCXVB/vrLRX2zDqnOnm3VMSxrmmyRX?=
 =?us-ascii?Q?q+KSMme8NGbvgnZmZOZb/8StLPRj7nKIn/LyeXWaLf4uTSr89X1cKzhFMBS3?=
 =?us-ascii?Q?0eKbK5B+MV/WvHREwML7oaAk6e9ZoHUhmSgmCgb9121FfGOGFELPXbG+ZsgF?=
 =?us-ascii?Q?lzd2BD9tW0PFwYhMP32EVNVrIHNIctCeRoFEXz/U1VM54syspoTm1F7rn2dp?=
 =?us-ascii?Q?ae/3MzHj9YBL4q2045d6Mg9pQhVirvp/Ry00K+9c04Po8fdP8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:09.9753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b9b08c-7823-4dc2-d1b5-08dc8673e4f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Reinit should return after completing version 2.1 reinit instead of calling
version 2 reinit after.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index f5c2ab0c0d58..17ea15682d3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -844,7 +844,8 @@ void dml2_reinit(const struct dc *in_dc,
 	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
         if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version == DCN_VERSION_4_01 || in_dc->ctx->dce_version == DCN_VERSION_3_2)) {
                 dml21_reinit(in_dc, dml2, config);
-        }
+        	return;
+	}
 
 	dml2_init(in_dc, config, dml2);
 }
-- 
2.34.1

