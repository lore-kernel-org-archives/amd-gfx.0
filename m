Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482EBC3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F3110E2E2;
	Thu,  8 May 2025 05:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyGU8c+F";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23AD410E2E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjK06EWrAytswl5s8m4Nw61rXJR7w4Q25mzPl18ya4t7UhbhD3D2u4NCnhNjbjhaAwC06gOVI7t+euMp9yBAl16PEiOajknr1bs3gKm0BSOHklFw9JaU+RhWpIbzhbVvDPf/HjcD5e/+FfjwZWJrKe2WwlspPwrNeNwDSu3AhJCcfjCpFMefcMDIN5F5p5RyJVGXnACQm1k7vicYo4JQ4H9xILIlJmnwQi2rETyTi3txUIQpOGK4FEjD9MuY0lIntcPiK8J8kocBhfDKedsutzCCfTnYay+i9BP5RQLoBA+Hle/hNkaWrOMj3EemLJox1WsRXdu28H+KaOP2LU59LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf7unzmxBtrDF4FbYP6K6tFkVOi7MPvMh9YYuIfajLI=;
 b=JFmBWyL7uF5zjG5mC4LHR7Z8bDDGQK+16yLbVCEMQosMBKE7CXou6s1HicRQqZmdKxf6hGN+CbqJVZHNOvJWV0NxLEhRCoiWLUB6JgRLifKzRdqJ7ozoEZLoka1MLSs1SCenlbJteYdA+hVNi5hLo7bqYYoemw/9vxFEKIcpp4bt2pfdcte6CpQXuE/zZ4gIWwM8PSaB01fvASfDW3l9jzbn4bQpgpgpVX/SSzpiSslU5XJYY7pIPuPe59V1ZyLwC7cOumtgua5syqJSGb8sqFFusJWkM8EQOIDFTLO+diSLP5H5PgLE92bOUY0mj0SlSH17k+LGXUpi7u5yd3qWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf7unzmxBtrDF4FbYP6K6tFkVOi7MPvMh9YYuIfajLI=;
 b=zyGU8c+FEudA/zNbn6pLd1b0hKFfVXIPtAt+1ix/MMVhuNyIkNizAyaFyDkoxDPyIZo4YqfGwcFAXMGurETQY3l8SssVh7eoKpBIQvoCZX1xY6zsnfyPrYVVIK0pHb8RjR3iQzYNkLFQN10greBXAGjjd5z8yCBRVUiDrAGSETQ=
Received: from PH8PR05CA0015.namprd05.prod.outlook.com (2603:10b6:510:2cc::16)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 05:10:15 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::a7) by PH8PR05CA0015.outlook.office365.com
 (2603:10b6:510:2cc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 05:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:10:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:13 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:10:11 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v4 6/7] drm/amdgpu: remove cached gpu addr:
 psp_context.tmr_mc_addr
Date: Thu, 8 May 2025 13:09:25 +0800
Message-ID: <20250508050926.228674-7-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508050926.228674-1-guoqing.zhang@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b7534b29-03ee-475e-80d3-08dd8dee9db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZGD0tOCjUKgxN2qjS9pGMI0bCs6DCgHYu+WKE5kEPI0eXHb6OYAlUvVak152?=
 =?us-ascii?Q?s3ypPqCqJ2UpgBU+ssP6rFpMXn9GRB+dM2wimdI6MUrhUdpSUCZamwfOLGf0?=
 =?us-ascii?Q?HDrINJ6O4N4ShLx+xlZHmHMFyhVfGh0xJTHQq35+GutPIRB7lOJl+YLpkr4W?=
 =?us-ascii?Q?ekB5qRIFfX+B6xu9NWpnzh/SS6wm/EGoNbVuYFRKgB60Lpys1Z1XGIpcmeW1?=
 =?us-ascii?Q?3n0wIQBIDEvp3dNLfKd+eLpITEdXIAeFPks8Kjdegl+jbkXJXLaegf/Eju/W?=
 =?us-ascii?Q?H/rmphkugc21ys4/rSv+kIPhgoD8S8kqVLqxP8hO6JgJ/bynr1EtCxAbCqpr?=
 =?us-ascii?Q?Xg8DDoH5zJGgENiZSxbD7L87d5eaj2XdAgQyZz4jJaOwSnJ4w+DZbr4O9HjL?=
 =?us-ascii?Q?Ij5giXwznNe66XuIAkbvj0qJpActhhWjHZjZ/TqPB8sugAvnUl+mxmgwyDZ5?=
 =?us-ascii?Q?boWN3Ux0z3wAcwfiMJ2Io1PjzTOzMLXenqUVtKi4L497tikyrUQ3tyKCNaWD?=
 =?us-ascii?Q?gubzh2sLYER4aDDZ191g8zF10tnVYyK6zF4fTGCspJFTwfWue33H8VayLb/N?=
 =?us-ascii?Q?GegdGUQVgYqmLKTpMxog3PmUOwHlbhy0PUFpMrZz6ij/F0Ge0dsZfFWgnmGh?=
 =?us-ascii?Q?YR9cqSZo0H+0H4GzCTnHNSpZXiHP0j3dBcG36Jtfp0TbEtKsD+fYQl0FOYSJ?=
 =?us-ascii?Q?3LRL9j8iGI9iQWxdyTSZnk/SPOxHJA9Q64EYIsXkk+1k2dbh9ma3vVK/Lboc?=
 =?us-ascii?Q?PbXJmKVPYYut5y7Il+oXDGFSzq+ypQZxVvE2r9D/Lq14SbwIJgNPZx3C5Cbe?=
 =?us-ascii?Q?3MxoDLMOQI+teZWb8HeG4kz2uUEAzL7eNOwRx1ZooOVn6XSjjMJxBTvZ23/x?=
 =?us-ascii?Q?U8U7gNQ8hKx6d5dvQgyh3Ch6u514Xxmd6yDbFBoNCQ97vOnswBkTZpxlr2mU?=
 =?us-ascii?Q?pArGg9qJKwW0PUBihO8N1KA8zzCxe+LhyX8TQiMXWHUR5fZtXWn7eg1cCuR8?=
 =?us-ascii?Q?ZRnU5OQehzmynVZrLn1yM+h4N04hRa6Rx7lGfTZyiN0aAwjnabmgkqTcrypR?=
 =?us-ascii?Q?sTuS6MKe12ALkf6EJsdukRV6L/KrFbopNRsnTdNMtaByc0wHdaj2I/KkAVv/?=
 =?us-ascii?Q?47USImfUkIJFIEIsIjQitslu/oKV4u57leQm3KvVWs+Mx79jLCrIbTHDBjWk?=
 =?us-ascii?Q?Wg03opN59GoasAlu6TxKPBsrw9npCf81qJsgnot/DooJv3vtT2Ua3L7nprXf?=
 =?us-ascii?Q?j88mtuEQql6r9YjrwpeJWAmz5FxmImZ52+7/gNcVFKevHjGUL4D979tcOVlW?=
 =?us-ascii?Q?hZwV8GCwCe7HGrmDT77qazqlQBuALjLlg6Dq0C+G3aCMFmWflgdf15bgmBAP?=
 =?us-ascii?Q?/G7SVMM+uOCHcc29vpuk+g2WrJzQVXftOlMjlucA5Zkb6153zHUEf1qPaYIJ?=
 =?us-ascii?Q?Owv2MVI/9crnWGZ/fazpl9kyFxj4etAwI7dM+sN3/3cW5JNhh8xKpsTUvefu?=
 =?us-ascii?Q?ZzRMrAQT3Gd9fpptJT9FKvoV1EEablYRdmd8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:10:14.3578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7534b29-03ee-475e-80d3-08dd8dee9db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
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

When pdb0 enabled, the cached gpu addr is not compatible with SMU and
PSP. It always need to be updated. Remove the cached gpu addr and use
local variable instead.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 153c0c868546..3b71ff298f21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -287,7 +287,7 @@ static void psp_free_shared_bufs(struct psp_context *psp)
 
 	/* free TMR memory buffer */
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	amdgpu_bo_free_kernel(&psp->tmr_bo, NULL, pptr);
 	psp->tmr_bo = NULL;
 
 	/* free xgmi shared memory */
@@ -867,11 +867,9 @@ static int psp_tmr_init(struct psp_context *psp)
 					      AMDGPU_HAS_VRAM(psp->adev) ?
 					      AMDGPU_GEM_DOMAIN_VRAM :
 					      AMDGPU_GEM_DOMAIN_GTT,
-					      &psp->tmr_bo, &psp->tmr_mc_addr,
+					      &psp->tmr_bo, NULL,
 					      pptr);
 	}
-	if (psp->tmr_bo)
-		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
 
 	return ret;
 }
@@ -896,6 +894,7 @@ static int psp_tmr_load(struct psp_context *psp)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
+	uint64_t tmr_mc_addr;
 
 	/* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
 	 * Already set up by host driver.
@@ -905,10 +904,11 @@ static int psp_tmr_load(struct psp_context *psp)
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
+	tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
+	psp_prep_tmr_cmd_buf(psp, cmd, tmr_mc_addr, psp->tmr_bo);
 	if (psp->tmr_bo)
 		dev_info(psp->adev->dev, "reserve 0x%lx from 0x%llx for PSP TMR\n",
-			 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
+			 amdgpu_bo_size(psp->tmr_bo), tmr_mc_addr);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 106d07aaf8e1..d3f5c17ead7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -348,7 +348,6 @@ struct psp_context {
 
 	/* tmr buffer */
 	struct amdgpu_bo		*tmr_bo;
-	uint64_t			tmr_mc_addr;
 
 	/* asd firmware */
 	const struct firmware		*asd_fw;
-- 
2.43.5

