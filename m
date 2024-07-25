Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF86FC52D1E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57A410E864;
	Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hoIP+WwU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF99210E29F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLAmW7D2lWs8vzL9d8Qq2L0Qeb9tkS1U9eJGU5Fo+0FcQFxBEr7Gx4if/K5Dgbqq+4Ti6E0YMHuYHKNQRXf9ZIMfGR29yfIlPBqMHgNsfL4LIp1avmGofnMsWISGXXallxYFgukpxfOMK2I6GZrznOOnPFI98sRq+9KZfyjvLkuIHkxeD1gX5vgkN5NKZd5/CQwqxax/qghYQz8VY+J38Fyz9tiCTgak3X1lbURNPYdelK6Ef3h50wrnMj/lRK6gsJDRNrPi3PIEt463uwa8wJUYdTACp7WMNT+xMiVQR9qR5jevVM1o1cVpk7ZN8oma4Pb68IsLn/jFEnkkrC3NSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msccrHYc0ITjQuXaxG/13HpK/38s3eUeBBro48RzxIM=;
 b=ZDL0bjOEG/yx5R6N0iBL3YUsBLen+gNkFEiW3ofe/BNNhqRdnsdiL1rqoqQq0mK+gKatCk+jQ9GAqC4K6cCeiCpQI2KZOBK22vg7KQIBwxqZm66nf6EmhUTSVeaKvErY7iatvXD3Y+ZkscewkUzjNJVll77B/m4DWizK2JuxdX6B5b967anXbbBtFg9ncmta3JIF7SEn8Y5N+K5dVY2vI3j2MuFnl+udurWLUyD+XuuY8vGl2HCQQNmc6SR6uaK72sl31dUBpdWFywps5ZtyfQtBgz6QpX9CKEBrDJTdg+oQF8rFufwE5d04vHBJ+ePtoTd8tKVuIe/slnO+AcahJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msccrHYc0ITjQuXaxG/13HpK/38s3eUeBBro48RzxIM=;
 b=hoIP+WwUh+d62hPmrWAAXZx31aogs4oxMiXH1Y7IdnvwRKEbo2/DyuwaOhmMLE5RPBI37Pi65Z0/JxUIiVl+xR+SVBRtuEMkFt3o8xehEXDXd9U9hs5HL0TRY9OjYo1YnZNpSYbxShOgisGRsSQkKsdMebuxw4WoPvPsP1lYg1g=
Received: from CYZPR10CA0017.namprd10.prod.outlook.com (2603:10b6:930:8a::17)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:27 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::b3) by CYZPR10CA0017.outlook.office365.com
 (2603:10b6:930:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/53] drm/amdgpu/gfx11: enter safe mode before touching
 CP_INT_CNTL
Date: Thu, 25 Jul 2024 11:00:35 -0400
Message-ID: <20240725150055.1991893-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d45030-ab61-47bd-b870-08dcacbaa8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AI2hpXBK4Pxr834UUeIPhFoW80CgDHh1SWw0M+h95bP1wvaR36/0Ww5uHPlt?=
 =?us-ascii?Q?PcFu6p0dSVADWpNrQ9Ncy1fcKHIAFG1/6lyw82c9CFjcqRIuvypki2qqU8st?=
 =?us-ascii?Q?UgsYEHj81pjs1HVBuc/de0jq6ywdBSVOrZwQ/u6ogh8mVHNOjSWOFwzRwBz0?=
 =?us-ascii?Q?jIdfanv1S38g7N969qZ/+LLkrC1hk4U5NVeoThOB9c+FmuSpp5RSxJwapMN9?=
 =?us-ascii?Q?/BCNN8XHOz6MxAHzxHxi0cLdzJrDBQcqvHdLPAZhbbNN1Tu6vj/FusNjtZJl?=
 =?us-ascii?Q?uj8Qw7Qo+V356CdAz5Pb9z44DsHK/AAPlD0Mr8PERsPAZVURlKLl0xM/rlOu?=
 =?us-ascii?Q?tOfRx5lx98NiGRBysNRN/S3h2gbBV7L1TvINiw0/nrLYUYQeN+Plj5UhLSZW?=
 =?us-ascii?Q?Je+2o1zbCBw6u9kudrsa3436EKPizDu/nDTvQWxMeEh0FMQLMblG1AwnViMg?=
 =?us-ascii?Q?WXOp51td9IxOoZDxdehey/OWrupZG7NQb+TkIUquQrYkhhs0VWhUPw8rkiPk?=
 =?us-ascii?Q?xKB0MorDrkUGH6D1qvWBPf4DHJckSZaMGuGKX7jvnsIwU8srS1Jx+/4JStK2?=
 =?us-ascii?Q?9shPAGpr2lj2Gp4X4H154DlnH202vv1ZdSMe+9TkuAVCXMUGjYF++Ttuyc5s?=
 =?us-ascii?Q?mfuVo3bqAjEA71bST6Vvq7AAqntMKfvzUy8Tvzj1eOmb9I6iROjFng47W1nN?=
 =?us-ascii?Q?q5p5ZhnvWV6ATUDhGJ1csrmU/d4oIbSIu1HrzlKevjOsqNhp/1+NyEZ9F4wY?=
 =?us-ascii?Q?xC4DjpynDY1I9WbFdSbJt9FcG/L2eDJV+hrlLYtn5dF0MFq4rb2olq3xYbYE?=
 =?us-ascii?Q?ELp1vbQposjxL21v7Bj1Kdk4UoxynHfEws0UYPlUcVMO03hY95/kNq7/42k9?=
 =?us-ascii?Q?0uQLF4qvk2LcbYwT8l81QZ7b0gOSnc2pWdtUVLzh6ps3uT0TLIgnni50dLdv?=
 =?us-ascii?Q?06ITjLl7IsTyXgikVJwtd5seSLgKSMTYIvTStMztUMQLFVXe1+76sgdX0Ur3?=
 =?us-ascii?Q?l6592vgU/2OZPY6bLck8uw2Ctm/FgdIuTs3BIgZWPEIqnRCDvfg3jeOU7NMc?=
 =?us-ascii?Q?8zfgMYWlsdLdr35W5Rklm+O/UgmjXllwXFnJ1+4NcFuYFaWkhIxY9Z4AAWqO?=
 =?us-ascii?Q?ViTENr1f/s4zBeJCOsYLjwAQpV10npEkS5fpsASUUT0sobnXjEQd4icgyrD9?=
 =?us-ascii?Q?KvC5EIC8pEfXOxG2oa/dz/fOCZ4LuCGSgj6hHdYyWSvyWPVrv/fVX9n+jrgC?=
 =?us-ascii?Q?RX+caB8waRCgEiP1k+e+GwmzcMFIl6lYAbCwPdaDB3CrWo7/xhFo3b3rJRJo?=
 =?us-ascii?Q?BCAPpX7/5c8NTD9a7aAMwnBjsZ5jC9ktkulKQnEw0Ws6aO6vmvxN467DxHFw?=
 =?us-ascii?Q?jNPZBqV7e+CrbJbiIdLURAZiKFfPud91VYQTGuf7M6A67Vn9iwtdcbju2TRv?=
 =?us-ascii?Q?8q5e++DXVfb29kJX8DUGKR/zbeMpm7q0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:27.5122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d45030-ab61-47bd-b870-08dcacbaa8d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

Need to enter safe mode before touching GC MMIO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c047e92471af..fc9659daf3da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4763,6 +4763,8 @@ static int gfx_v11_0_soft_reset(void *handle)
 	int r, i, j, k;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	gfx_v11_0_set_safe_mode(adev, 0);
+
 	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CMP_BUSY_INT_ENABLE, 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CNTX_BUSY_INT_ENABLE, 0);
@@ -4770,8 +4772,6 @@ static int gfx_v11_0_soft_reset(void *handle)
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 0);
 	WREG32_SOC15(GC, 0, regCP_INT_CNTL, tmp);
 
-	gfx_v11_0_set_safe_mode(adev, 0);
-
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-- 
2.45.2

