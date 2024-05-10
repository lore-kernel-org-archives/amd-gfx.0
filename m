Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04964C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D7E10E05F;
	Fri, 10 May 2024 02:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="At3vZFSy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C683310E05F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2ZRWm0T15AfM3oSIW2s0jWtSPMSLemc5UdRrtCzPJ09GUPK4z3OmYz5j7FiArDwjwf5snZxWVY7/guLkxIZUTDO0ccglx5mQuF/E9UQoFNvwH4LxKSfhfrWjUIQ7znthhLNX1JEQDlbezkz4BPo/Gyxlh3lxiDv4pId+cR2KAKGSh0Grg/jU5applGa2GrWrhCbbR42q1YsU1pklLtI9kHtibYN4wG6T3gdKUU3l2vqt+AnI69S4HhiRYFw6VawknzZ+DsTNEwYld/dywlJxmAE7TzPXWRkX9O0Du9mbRi5vTxLVJzYzu1ZOXe7vGzMbFoXvKMlzPpWJN2Ngb9/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgHFtn9nIDNctfl5xj3VLLdXrkZJ2CPTz3HJUUVSohg=;
 b=ZbAj3fspAVj5e5ddUnNYwrg47twKl1P8vSF2sDL2CzYRfsCw0d4HvWzkBsalmmEfFXE0xzVXR1nUdLug0y6cGyy1OLPDlfZk+eW1od9YBe4t6pxrkOOiX293E/LEDC7JY2Wx5TggUk88eGmsiifLZ08/9o/oSEGMg1t5v0GLPafR4uJV8jlD3wDVzRXzHuLDvD0txWPBzFC61yHIU3q7t9kYGTr3t/cPxYj8Y4taQV3EI6FVdBJtXk3A883PlisCaHCuJ0A9DsQQFjj03/UxdU1SIXwZRKNvFms4TR1224ix8VSNXTu7JatcMGowORwGUbW2pS1tDtKQpxXh2BQ8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgHFtn9nIDNctfl5xj3VLLdXrkZJ2CPTz3HJUUVSohg=;
 b=At3vZFSymhpf3NvXetSYcTlXFO5vqXrSecRuhehaNgimxjWxYmCuy09Q8mVKGAeR8b8WKtKE4bsmhOFObtPVlhlWtnXvJ1H3Gg2dIohHtkMLFUexq5tatGnTWKd92P3QKdMiDh+xPleUbPoOp4+DbYRlw/8Qv1kcVJkEsHTOKvQ=
Received: from BL1PR13CA0288.namprd13.prod.outlook.com (2603:10b6:208:2bc::23)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 02:51:06 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::57) by BL1PR13CA0288.outlook.office365.com
 (2603:10b6:208:2bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Fri, 10 May 2024 02:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Fri, 10 May 2024 02:51:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:51:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:50:58 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for nbio_v7_4
Date: Fri, 10 May 2024 10:50:18 +0800
Message-ID: <20240510025038.3488381-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: cdce4a39-caef-4057-3774-08dc709c098a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmuYwh53jRv3mjrSI0ksbbpzcN8S9e5ffemHRskTCG7mVcOHBr+NX/kNkjk1?=
 =?us-ascii?Q?7ebHlslz/0vpv7s344U7bPv3sVkKZgviSrhjXDloTZc1f5Gs21NhUGhsPowU?=
 =?us-ascii?Q?XQJn6UE1qNYcjEshdEawHtZsb+SYICWkquSgzEDtyydW7fmn0Lv2Umjk6Y+t?=
 =?us-ascii?Q?svQeI6X+tQUpmUJSof5nZDgivVcEPtQ+9Neoac1ZvdFMbYH7bxmdz/uv4Iba?=
 =?us-ascii?Q?yM1B3HTn124OPDVlPLkOJ1hp/hnbGuR3uwe+GThYseUnXRRBodnTON6CtJyj?=
 =?us-ascii?Q?VeJkagblBhN+TdjQHElIqTaZYNN9UrGokNLcfo+f2JgGIYhW++HNAx2Si+Df?=
 =?us-ascii?Q?eOZESXHMMnz2byi4wRWjJoATmlzWD/gtRekTfpbEhFYO/6y5RrfUYZd+Ev1d?=
 =?us-ascii?Q?U/iWW5M2yMtBBCJIm14szfmF8Vxno+9Rk+gEOCCREfakGlTwlpNLV/exWpvn?=
 =?us-ascii?Q?WtTNG5Kw7rIKdi09lJYOz9TiLspWGcW2KbOj1UPqZFA2sDh41ulthO7OWbEh?=
 =?us-ascii?Q?EHCM0HcSHeRwqkDSJ4zK1Tj4rKO9jT5PXmrTeU3UVhbrYaZn5icKQdfKQMpf?=
 =?us-ascii?Q?SHD6C5uJHFFR/ZOuIVd+C/0GhAqQODY3faLHoCRS9tSFsVqThv8+pixFFOc4?=
 =?us-ascii?Q?LUxI31q0eCtdE6w50eI+IeYNM71IUSia08WwBkdxnCOQvhbR7tRxamgTebWL?=
 =?us-ascii?Q?KlIRgs87D6ArZ0sVL448CepUBohiycI/oxWsf4Xv3Ur9Tcts1SlJF0BS0RQr?=
 =?us-ascii?Q?ixovQ4HSRVi3MpwOZ23c+jVs/vmGLdVVed2+zCoacXhtvWUX1kfmdoZpiqnK?=
 =?us-ascii?Q?UJBF/EBfL+NrrJ5OCV4za46ks3GFo+cYrZMEbq1M4aHuqQkJ3I86UXCGElSP?=
 =?us-ascii?Q?FrTuRz9HvnyfXJt2Oli3BjhFclsR3FWtqQAX0TFOkOzA6136hsJO+KzBq6+E?=
 =?us-ascii?Q?CiybRqQ4FB3hGzEm39EQ1QIYTAOTsxtiloJcEEGU2W2K0quPzM/yoJIdwBou?=
 =?us-ascii?Q?406acIcqJDrpojXjRqt9bMEWGpMBapb25YcFingjuM36J4Hs7r68teBu47ZP?=
 =?us-ascii?Q?3JkPo3tZcq7WCaE6TZ0nYAl5h1yVhvPzNM8HQjpBOyKfkcaqIS8H2wiOqyvE?=
 =?us-ascii?Q?B6cLuC07SJmM1xeeMPhKNTMTLHmNuC2OHWGoq/fzFoK4UHum6DNIYgrtdCmz?=
 =?us-ascii?Q?cSZKJGVuU+1vxh8gEH0liN8pLc49XyccmDWWMsmZfIEfyf2OGr23jx5IXiZL?=
 =?us-ascii?Q?qdhtQNkzAQHRgKOPbFCkzFJj7CJdJBHRSJfm45eYLEO0yJCkQDuXiEyV/xqS?=
 =?us-ascii?Q?0NIJZEF9QnQ6phH/fUY7D7gEagJRVpa7e6Dnbxn/WC2TqbBGjER95koRoUFK?=
 =?us-ascii?Q?2NEg9YpL2IWKyzpwTg2cG7AI9gIL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:51:05.6561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdce4a39-caef-4057-3774-08dc709c098a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
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

if ras_manager obj null, don't print NBIO err data

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index fe18df10daaa..26e5885db9b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -383,7 +383,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		else
 			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (!ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
-- 
2.25.1

