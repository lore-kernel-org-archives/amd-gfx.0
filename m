Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBB5CAC5B8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD7010E826;
	Thu,  2 Oct 2025 17:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V9hwDxzR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F67E10E826
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5xAJoPjwJf5YQsHOLV5aZuRozxI0Inz/ipyeY1D4DgxaIYFkJih/2NiHiJp7vMKA0QXTjeYJC/ALJZRg5xA1aOQHka9doOwkbPxwf82+kUI0LWBRVcwfO+zU4m7L33+l47JV5vZxCTq2bMEzveS5BT5lBtdFmYlwu2gl8imPgRSNM0CyNq1bem0Qf2FoyG89vpUmPEzn4g2qodGtlwp1QSyd/rfD/bEwP8QNV+cBoxVKym7GbySg7RhZFgeKt9px5KS5FrdnUTGc6TzhKD4oUqD15yv0L+U3cOC57ALbzYQqqWK0PPClvnaVXKtAjJBQ6nIJlYtXVdyhYz/YMmEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5Xy/xyv1hMTxqycE7nEal2y0SRG43MTi+Tr2m6KByQ=;
 b=YnMdn9coz4EFbmvbU8r74DNM3zp6xmRpocq49Ykx96GttEwILiQ165JC3F/r9qTfwZFpSVSf5EtuWKa7aw1ZvnWxbievPp4ptAWDFVYkZm+UE1zcAU0BOs2hwbZTnaGEE5J3wMpLpBo/EaAKOYSl2ETG/yXjh2pCMePAFhTRsoBKhJYjxKDBXb3FkPoHhBKcDrvX3cYvFywQXKjJWt809jHXpHLIlqgct44cipIwu8iDoQiGneJuRkTk6XGESW/lpHXnZKFZSqNENT9cy/NC8gT5wYVoql2wN3L0cFXEKvxK3vnzmO44Shqb2q1eJglRTj/MALT2TCve2UjxF3y9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5Xy/xyv1hMTxqycE7nEal2y0SRG43MTi+Tr2m6KByQ=;
 b=V9hwDxzRyJvP5WoDuCJh2AldaMxTwAARHxpg6rNHq+ZlDR6j9lmmqttFt1/ee3I9xiHrer2PMxv1KoP8341eNU6Ar+pgb6zFw7mDFpHMGtlrjqzKpQVia6xNyltADLiOPIVV1o+ejJDlyx25jX313oCW0i5pQRV3WBCqWqNpdRs=
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:43:53 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::2d) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:52 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Oct 2025 10:43:49 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd: Remove comment about handling errors in
 amdgpu_device_ip_suspend_phase1()
Date: Thu, 2 Oct 2025 12:42:41 -0500
Message-ID: <20251002174245.1691343-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002174245.1691343-1-mario.limonciello@amd.com>
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: f44a99c2-535f-4f51-540c-08de01db40a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KFZBr6jXxb2cB3wFEtX9HZZSY+pezQmSK94fWKv+VLOTbExyve751LgTh+BP?=
 =?us-ascii?Q?z4NMY83Hznm+2gvU/NQtHaFouwBiTlidQXTf1ps29iubNLkECwRXA9ghYjwh?=
 =?us-ascii?Q?B2CpZi/hc91QbRiZxwZ7Z6x1FtwCMyTZU/hl5Aw5tDF+sLI1s6+uAfxAmuUq?=
 =?us-ascii?Q?qyqefhQI+tmPzG0sXRjtsq1yhjvIRHDCoHoybWOioPd2j4m3f+MGTIjyohO7?=
 =?us-ascii?Q?iFxaU6OValabPmQCZ7DMNc3sUSNCdFyGoCIui64AxgceMur1YwepT04SLOgH?=
 =?us-ascii?Q?mge4hkvZqhpgNu51pc3hD3WEmOtpgacFcGO5Vg8bLtW+V5vZ2vnaeXQdHYv3?=
 =?us-ascii?Q?v0knh20O+J00veiV63lpy7IMsTuBGre8lmojGwwaC6+W/8/ktpQadm3b5wAV?=
 =?us-ascii?Q?rbJnD7G+QVlD9oEFZl+eCRKC25tD7W9LakBEp9ffambfi9H5K9i2vevbZZC2?=
 =?us-ascii?Q?y61I923xBrJvK3ZlkjBHoVwJqdaTac3yApfrPOD2mdWAsPwvtJNWlY35petk?=
 =?us-ascii?Q?qEt7imOzmFbWW4G/cm83CJc7h6EIg39PN9TSw4QOC8Z09bKKnrvvLmDyaF1R?=
 =?us-ascii?Q?d/lyorVTD0zFepm0c42rNRGT6N1vwGHVRGJuOgqihYUDopn3jxSyxA0tVDH9?=
 =?us-ascii?Q?9b65df8dDbY2lhpudikBShanIVW3fb1AJvrHa6/CeqEdJVeT/Q/9yIoC0Ds3?=
 =?us-ascii?Q?MIlHGNvOJ+ZJg9BbJePf1I5+amOrj5mId6ms28689JpESPBU42EqMoF1jTkI?=
 =?us-ascii?Q?VmYJ+iPguEfd5uBCR+q9LD867vYqlM4z/U+POYH+5UuaL6Vp6sSCC7+ipPs4?=
 =?us-ascii?Q?Xm0fD0bBHdzVnQSKNvIIj8zKskacSP4WznUyMm6PiRFO63IQkv2R7pBfyBHS?=
 =?us-ascii?Q?fcNxHYtJ6HFsMhf3RGJispdJEPy1ojp4oHO58aziwCycO23ibonc1A+wpM5v?=
 =?us-ascii?Q?hBF9ysGL3npsWQAm1bvdQbsOsUEu2/7iVZdDcsDbthKZQAJ/ihORWVvKBHSO?=
 =?us-ascii?Q?6fjxUV6E2s6M/zN1zSxi5dbIO7UWCdZhXza5GuUxKWD0oEUHEkYj12bcQamt?=
 =?us-ascii?Q?qWU+PGVRd6e11hK1qiGWrDOPZgwAYe4rPhxvJ9ZsSPpgOmZZCdR0wATuCitw?=
 =?us-ascii?Q?JVhe0spfgEsovtA9a6/4ehEYkmytrT7EGLImtcWQrwu1FjTKUTW+5XkUxGas?=
 =?us-ascii?Q?nuaUqtN9ZChwMQXfB5IUPG0WZ4ro2sN7utS4iAIgDDlSz4P/wI1MOSm/AKbu?=
 =?us-ascii?Q?M4zKCucoMPthwO/2P4+slyusEAtTrSSyhm9jdQVjdNET6GMVzMpJ+QAV7pLc?=
 =?us-ascii?Q?nDoY/j7qCXrlI+z5W+4PrcWzvg6QPq3Cwn9ddOlBXPvX8xooY19NANN/LgQi?=
 =?us-ascii?Q?FTyGud/mceKVdqDG9U6h57fd5M3376zUVV5nd74MwkXqcT1ocPaW16rWOaht?=
 =?us-ascii?Q?ihG4nOLdwZMj1aiq6DfLOVhf98xbUqUnez5SFZxIs2W1erANAVqFQnNXkTJ7?=
 =?us-ascii?Q?bKAGJRNnAb5VOGho4ttyMTaOVODkT0xgzslg4EMOKPKANlf0auY9CbEWg8/c?=
 =?us-ascii?Q?0cRptG05yszvLgFUNl8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:52.6128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44a99c2-535f-4f51-540c-08de01db40a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

Error handling was introduced in commit e095026f0066e ("drm/amdgpu:
validate suspend before function call") so the comment about TODO is no
longer needed.

Fixes: e095026f0066e ("drm/amdgpu: validate suspend before function call")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 870969f15735..d8cbfb094920 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3773,7 +3773,6 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_DCE)
 			continue;
 
-		/* XXX handle errors */
 		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
 		if (r)
 			return r;
-- 
2.51.0

