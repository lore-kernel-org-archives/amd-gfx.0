Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A507C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 14:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81C510EA79;
	Fri, 21 Feb 2025 14:49:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AeFzqITx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2181E10EA79
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 14:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCWf9HyHJDt9qMn2y9Zl5wiGtxpyavQWOIjuP8biCLy1sKTm0K/3etjZV09XvHWlks1Qe1OjzMChzfBEbD6Yebtk/FAu7XXGpLNz0JpRCI6YfXf611GCRPQq0k21PCZxlgtKNB4GqpjTulRBXeSMRrRynk5jRRNdP1J9VgJ59iLc+9arJ/7hoyQBvKEqBfNMUMcTcJX9ZgohtEwri1ySdkTlWkpWylVX2SHopnxXOs0WiCv4CGlSQHGPBWc/wNxrPp2xS01u8YRGSeqriO6TI6Ga35oMjsMo7cLLS0Ku+Ym5keQDFAXUhN3riixGwnDA0TLBRSxqFDpg+muydPZoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/Qnn4rMTj5Ftkv2KxFpX3TOwbrQv3jPE8vhLSJbf5I=;
 b=a8rCBuuPgj9iU1PQiDsEuUyys2guXbDAdjOKvPvoZxARnN5FVdMqnCADI1MaSzVDXCO5uJvww/Y0NvdIp3PzTFn2WWcjDzaKcG1RsLN+Zf8OidlNZYTvlpmsWHsPCRJslHFDnTnf1w4GxFUMimYMSKrMsIP3gJf02Tq2LlFgbzJSw4cKaxcemPZv5AN7RQxo8HE+1HZCHkS1SeIKUNAJEhlJ9lqx+6ZFZpEsmycyUaXW43wPWas8b9bj6ei73J+ZofdeqN3OsHV2xyn5vf11sslAwOg7PbTB29eC8okCPQXOJPpSLp8WCMdAxZ7CF1+N4AxGkGgtn8MtBFkiRYXAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/Qnn4rMTj5Ftkv2KxFpX3TOwbrQv3jPE8vhLSJbf5I=;
 b=AeFzqITxoTWmMT64PdeLLAlcHGKqfHy2d1BEFyq2eXsUsd6FH7exV2LZm6fU1Y0JU7KIScYWRjJ+pXXSzM1noAh6vL8Pm1RqKzvK5kbF2/vQ7yHJQNU05Od0B9sSdhbBClPrdjRB5pC9b+S+nxNyVcs4OLM4+XM2oDelk+0re3o=
Received: from MN2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:208:23c::23)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Fri, 21 Feb
 2025 14:49:49 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::f1) by MN2PR18CA0018.outlook.office365.com
 (2603:10b6:208:23c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 14:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 14:49:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 08:49:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes12: drop
 amdgpu_mes_suspend()/amdgpu_mes_resume() calls
Date: Fri, 21 Feb 2025 09:49:32 -0500
Message-ID: <20250221144933.3440420-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6c31aa-d5b7-4533-3e91-08dd5286fd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0aEbNHnJbiftbYsxNCHcvXNVo4VXoTIqB28qSMxjSbafiIAPxKTbmB+ZuZmH?=
 =?us-ascii?Q?6ZyqG6nr1/UxCq74uU98wvb7k5apnHVNbW4M4O5CKaS6gA9Mbs/VloIpeoAL?=
 =?us-ascii?Q?qDwLZs2oMETUjoiqzkrmPbyawQ+hqZbeFJ9cf3BFjjIZutKCwyRRdASjoDqs?=
 =?us-ascii?Q?IFpyJrDCsFsn0f2DGRPRQuSEUd0D8hVuyk4oz3jwQKVjg6qjYYXqOD9ixo0C?=
 =?us-ascii?Q?aufT/memiVcsxS9Ph4SVTLYCFVRAc9ByJ8bcI6KoEJlWVNyCLkK4QU8WxS9M?=
 =?us-ascii?Q?hLspNRHe1MXRIRkzUOrqWXQNEb6PykZpJ5RHiIYtFcEQn5TFj0DqWVYS3YNF?=
 =?us-ascii?Q?0vRFqv/R3ig8MNPRiYuFQK5ntv1x7bsOl9HKdyQNJb46FtB8eXRixsXkiLbH?=
 =?us-ascii?Q?D6jAEfUn4zDOqCUaLc3t9ILpOd2To/mcz1tFFbtLVimH8SIGG2SgidK0zEPz?=
 =?us-ascii?Q?OaxjsPecnPxG4X3zd131jskj5ZcCmu8IJEFvOkwnI4qgI4tqlW8spif6ohgI?=
 =?us-ascii?Q?RYxeF4zQfLY0BwEjELYgP3bGLcHdrs1R0uarI1wY7ST/TOHL828lfALeMsGk?=
 =?us-ascii?Q?/uNhETJPq4B6bt8Il1n1eQRgviR/R38TLGK8/rmx2Xk32YW/viS6/NxToHQ2?=
 =?us-ascii?Q?W90ZWovZEG5AiiD3EsK2UyVn/SctO+H0JaMe2Pg2F5aOxPFTCR48M7iRk7bA?=
 =?us-ascii?Q?Cpd8JWUiPh7V8nHQJtV4MBCHj9EkCw0XPRbhHytvSWf4hdMMZV8sBf1Lp7Jy?=
 =?us-ascii?Q?ABL8+j1xGwN2WL9dd0qZlMG5IiMrUqhXfrVwTdYaXrlexJWLGHX12Cl3pn1f?=
 =?us-ascii?Q?DxSLm3zQ+kFuRQPi4/ptovfIN9Fp/p97V9VZ7zdGok/nJxIHvYoqEeCfHBfM?=
 =?us-ascii?Q?RhOJyihpyXhuRm8cP3ZfmSZ6DF7tsXoGIUgIx9imX/Bb2+9cJhVUIDWA0a2u?=
 =?us-ascii?Q?YiPccmGyCEJIxLdE0uN+SZ51RF0OABbserxALBP42eAry+75m74sNoxPUw/p?=
 =?us-ascii?Q?lOr4eQ4Qf+UzjMKv8DxwWxFMNuYeDx632HwxHQ5Yo6heeOB8913hvaiu2xdg?=
 =?us-ascii?Q?umQpNRx6ged9oOkab9kUc625rKfdBcFLut9qDSoEQe4ettRii1z1d+NKvydB?=
 =?us-ascii?Q?fkMUHCngx1ttVFtrvsaHyObRWDaEKBYurLPYy7PRX5+ShlrZGAVRmMjL7R71?=
 =?us-ascii?Q?f2vpPYW8YccsHFh/61PC3wIlEKcr3V47zY4LD9fnUFoXURHc3tpQBhrjb5dT?=
 =?us-ascii?Q?OHBYp+8VkIseHWLFHfvHxU0xN61HqCz+YQY4PAkSrty1HKUCAkWD4Hx4Svvd?=
 =?us-ascii?Q?CLTCAVAgpsTXfwWfoAB96qJ3zvP6o5j164U1AbiCHvAwwFvWzbw26ITWESEc?=
 =?us-ascii?Q?tfg7IoqYOl/jkn+Gjekv6l7hfLsps8jHOx6Snkobz2/2YtJYNfb+xRz43LsR?=
 =?us-ascii?Q?Mqw5arH2TFBgmtVjX7aUaXEr5P2hzHWKqJKG65s2/5QojfZ/mtWnpzYEzUOK?=
 =?us-ascii?Q?jDmIIKaaiZJqsx0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:49:48.6637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6c31aa-d5b7-4533-3e91-08dd5286fd69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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

They are noops on GFX12.  There is no suspend/resume all support
in firmware so the function doesn't do anything.  KFD already
handles its own queues and they should already be unmapped at this
point so even if this runs, it's not doing anything.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 85a4ff5f5137c..96336652d14c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1798,24 +1798,12 @@ static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int mes_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = amdgpu_mes_suspend(ip_block->adev);
-	if (r)
-		return r;
-
 	return mes_v12_0_hw_fini(ip_block);
 }
 
 static int mes_v12_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = mes_v12_0_hw_init(ip_block);
-	if (r)
-		return r;
-
-	return amdgpu_mes_resume(ip_block->adev);
+	return mes_v12_0_hw_init(ip_block);
 }
 
 static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
-- 
2.48.1

