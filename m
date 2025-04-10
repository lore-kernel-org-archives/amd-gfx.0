Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19184C369AA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7ED10EA23;
	Thu, 10 Apr 2025 18:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xxrq0Z6S";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1E910EA07
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHlL/6fp9gS23MbPtCy/ejve8NcW1tZYogBybZL11Qu3+veL5No7ZZstoJs2mvGX3VQ2GCg4fgSwJDl4VaSNBZG2yE00YC4vhbhIjvHrmG6y9Y5ir1UYZ/SgVxzNu0aPmaKNAQJlMtllyXCwq2VcYQTqvlh/DwF9YQtz2MtAunwqIfcDmp8i6mJN2A/2XxZ9qywT/Qkt8FnQJRkd1gKuiSbkbtdF/cBMqU8upFmGx4ZwpVK8SQFHDfD4/MyFKx6p9v9iuizj5dimW43KKADJ8F4zFq1N5L4Ojv8q3T6/t1EJhJPaG3uST8SAenEmArBskzGRPi4Y+Ipi8QP2xcLGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiJY35GpOgR+mC3SpwxLz0/7f4EyVaxNcvNaOQn3HPI=;
 b=vjocLpjgXTX5T5yvs+JrGs2ZIiwcFntc9Xlz9e7WTKkpevIsIz8uOjjRRK0P2Dao51CTIPoK6w7HQEc1ot2Kkgb7n0hhAzlebufqZmtLedx6BUteFI5GfxZaxuAcQMvP91bUYpnjmSylKAEDO4po9ndnlbHPkTjaZH7byL3Jtf9Pg8NSVzIkfM60av2qAvIvXxRAKFfeNI4X9JAzJI9Dl1Iwvr2Zfp/TkBl0psksQnj/bNFirxXxY6C26Dmg94jwKfnKdfgKdYbuA/tyIpEK9kYJsjZeWyaN2jbMCAKIglVXQ+569TSCGt3TpHOfPQzeI7pU5aLNNMYBXsnXU4FTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiJY35GpOgR+mC3SpwxLz0/7f4EyVaxNcvNaOQn3HPI=;
 b=Xxrq0Z6S9HlJbX3ZnZY35pApMfsfDQmwAckEDlYNE2v+R2qSVmVXvTapT4uvKyHtu+/1eLIK6PRXm5JjXzqhijO40T99PN1qrM9usd/OEBF9S30k2slzhBfXIFt8axd/6ygWwHPisVsRTdDcqFkloQSLWSvin3P5yXzOP38pvTU=
Received: from BN9PR03CA0927.namprd03.prod.outlook.com (2603:10b6:408:107::32)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.37; Thu, 10 Apr
 2025 18:54:20 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::5f) by BN9PR03CA0927.outlook.office365.com
 (2603:10b6:408:107::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 18:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/13] drm/amdgpu: add tmz queue parameter to mqd props
Date: Thu, 10 Apr 2025 14:53:58 -0400
Message-ID: <20250410185402.2352109-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c36f21-3620-43a8-a017-08dd78611992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DNAkh2aofPK0yaU5VVnCRwnR/Qzhzabr+y0nuQe+0ZUpRNWvCbUWHPb9XwTX?=
 =?us-ascii?Q?SQKhQlOaUmlXYF49KnnLXPIKUDik6bzfrYeGaf1RjBSSkTZtxmr+ij7trirD?=
 =?us-ascii?Q?p6UdH1mXQhsHqJolQlgzK551ePkKo+Qe4eXDepHAJnDs5QnOtlAAI5CQN3AC?=
 =?us-ascii?Q?omXM4gWkshkJ0Fd0NDSBYJCJytv+FCtoDlNLoujpemFxbuNNVcC70ssc2VT1?=
 =?us-ascii?Q?H1DtJJ4vODAKoAQbi3HM+1LbnZsNozSTAgi1QRFxQKNIPPa5H+/afXZOlTdg?=
 =?us-ascii?Q?IfXOHa/XgYxfewk+Gs92RvJc6bh95c/Xld9lxhQFoNJOUjR9fnljdooF9rEn?=
 =?us-ascii?Q?8uVYFVOdyiibEXwYhYeoX93wBCjc/1lm1f9gpikZQp5xTzIMz7u7/MwcbnQT?=
 =?us-ascii?Q?uVBnrm6wS73ZROgAbatRjNVNMbrH60h4CsEQ4xVj1SXjMHWdSfV0MR9cfMJ6?=
 =?us-ascii?Q?9vSzUflSMCIJ3wg4k+JiIKD3guKodNmoBM1n0RB/+4DQacgQ7qQLqzyEwF1h?=
 =?us-ascii?Q?Vq2OYu8sy0Xb54KXpirTjZRFQJSkoC//WmTQdYtsEODepvMNgaYLO/YLetqm?=
 =?us-ascii?Q?rFIA++ZWU0Mn/mKWM5FFDqEl0A55WUQbW2oqlwS76X7jo1rigOkGtEhu2Yte?=
 =?us-ascii?Q?K9qKMKKgv+t5498Vn8YU6YIiIdSxPO1LrObv0lchaT9Nn81bPYg/zNWSNd5d?=
 =?us-ascii?Q?7rAvm68/Zx/+Fjk5wo4l8p3dnt2hhOrEfpe4wDB0vvd0N/7W5NrLPxJ1sNuS?=
 =?us-ascii?Q?UW2sq8VR3K9F1AZ+q+cxr5tXQxbXNkjzdDpwSL8k+wuok3V7QtCpwywhqGXy?=
 =?us-ascii?Q?50twuI98fjk2QAexVtCEJsEnB7avE7MB+QexLoiXpUIZKXmZBu1YklqV3waW?=
 =?us-ascii?Q?3urQpzoxHHcbYQjfZY78Yvc4iBjH8+uU/SM7yJctKuO6eOmnOQaIFccvTmkc?=
 =?us-ascii?Q?59EBvGm7wqWpns7aXgCibPP2I2dRLfFXnKwIcAfiRjE2Lo8QRNxyw8VLqOV1?=
 =?us-ascii?Q?KUJ7p9WoiOGn7GjbvV+/tBDYbJvV28pQ7TYKZXBppd/r2ZulSGVuy48KpD0n?=
 =?us-ascii?Q?Fy9Rxbz9UElKRzYBuII0UTncjuTaexysaCoq2iSAO113w3OTSFsFdYDOPSwT?=
 =?us-ascii?Q?ZpWK11neaeE6ig8Bcr02Jy26ZqNRpgt92oujy5y+Qa9+4iU1hrQOD+8Cc7Nw?=
 =?us-ascii?Q?nOVqMCcpJelSIEmo5tTgbtX0bcI6wxIvdT5qrb3Z7OMpLLGsdlWf4+QJWZC7?=
 =?us-ascii?Q?eLyT4ASFwM+L5ZgWi1bVlQP9MzXf99Fmen3SrMo5rOU0Vc49rb3O4oX8yduW?=
 =?us-ascii?Q?xS1+1EGQgd9ZBuqs1DE7FPcN0gnh4ok9mbprB4xjNnq3D8bmEzLOx/rJRLLc?=
 =?us-ascii?Q?8yIteAYuPILx4vbSWDiIxMIa/iTCqYVH3H0Ha4sD9gY6lcXPPEMdix/v1r1Q?=
 =?us-ascii?Q?ak8DLoVKy9WATCGDay7U+rDr8j3Lewu8w/IuqK6Mr+Qq5YFta+sx7cCmya4w?=
 =?us-ascii?Q?FPkbgJyghcVDTpz7N23zomNYAe/Jsh9mhua7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:19.2245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c36f21-3620-43a8-a017-08dd78611992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
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

Use this to track the whether we want TMZ for queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b818ad63dc84f..364a65524cfdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -835,6 +835,7 @@ struct amdgpu_mqd_prop {
 	uint64_t gds_bkup_addr;
 	uint64_t csa_addr;
 	uint64_t fence_address;
+	bool tmz_queue;
 };
 
 struct amdgpu_mqd {
-- 
2.49.0

