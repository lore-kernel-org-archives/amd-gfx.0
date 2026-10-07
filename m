Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F67FCA5FF1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0927B10EEF5;
	Wed,  7 Oct 2026 11:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rHdjZBmG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DC310F184
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8TqSuhgQaPRz1Fi3W8yB9I1d6GYkYaEI2vVmgXZ88yuQ7i6C9whEJlcQcuT8S8wm5EZ1C0Gwp1Z3+I5LzVmFiMq+hywzv9lM/zxhG/zC33VhxSBkj75/PBPR5NeF/tbSa2xcaKSNjjLolSrQKYn91X4UUaP5aA/wm3KdGSgJHhh/oBSDNVRlO5JJ/x1Hdk97oJi48bnyOiFuuFRIX27kHJN0yyu25V38h0xCbYcxGSzypzr9cUPWqlyDf51CF2c0ACPSL8Vn3cxGKuPnB+G1Y/A4XY19EQa8JaaUhWFoYCVCRnUnvJ/AHWpi1GM6LDeUWXTvK6jN2ngDBama+xi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEAkBYT721SfP4iTiwAVVk2+VlenYHmXuW93k0XISkw=;
 b=UTGZYoQNRbsa3SSRUaZ2gLAQRlQ6Wb4S1VSkwP7EaDLkJnz6hjOCkoVKsZfXcQnCT3x0y0gL24qcau3M1TPsQOG0ew9DhWVY+Qrw6wlKdycb9dLerIgilDLX2O75g1i33mKW9E5s6Xi1AKwY9OKKvWFAgkRsDSKvcUSPK4zRs9Y+Lp/lynE2SpkDuoM8OrnTBgTW/mF6FjOCVf807rh3tE3i4MxtV1q0glom5oQ7S3WgkIxKxdxkuGMAsb6n4pLGe0UmfVrgFoQFi+/IMjhmeIXTto/bTI/GfJyQ1P++9OyY21MeVYe9H9DDpFCCPHxtu7NZwtPfmn3Nlwxf5VifOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEAkBYT721SfP4iTiwAVVk2+VlenYHmXuW93k0XISkw=;
 b=rHdjZBmGUMvnVBnPwS597B+eiBw1t4JK+7xEZ4066yhyU0qk2dRVSIRASqZ2kUctc+OJTbVd5F02G/vhfQ1r4R6eTvIn9czgWqUoQt4/ncOETNILnQHvhhwMIOSfx0wIDuCgga6uJz6DdtmI+mmjRPcax+Mge+bcm3e9Ip9t1n0=
Received: from SJ0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:33b::17)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Wed, 7 Oct
 2026 11:05:35 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::11) by SJ0PR05CA0012.outlook.office365.com
 (2603:10b6:a03:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 11:05:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: Add ioctl support for cwsr params
Date: Wed, 7 Oct 2026 16:35:03 +0530
Message-ID: <20261007110506.1065076-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
References: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6890cb33-e8bb-4709-d78f-08df2462e938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|18002099003|22082099003|56012099006|3023799007|260925021311599003|260925022911599003|260925021911599003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: dgqJaWw0AIo4VHY2c0I11o3sSisRcqadUgSZ16LADo5xEaT2zA7r8H+aAhd63HfFWL0ERb3SB0gzRkkRZS///TZ6U0A59Hcns8H5VicRJ9utWwj9OHUtU7SPLX2yny14sWUe0Tksa6lPM+M1mb3i6IoSOSqi0LTYkupxg9dVoe0r1cJzbfAVUV1AtZfNKsD/stvv8EHR0VYD/Ij2zUbG5fxzpad1DOw1zOnj9dBQit4AhuAfawxdvL2Buk7RWT5OH1Edk/cTakRA5ZHiHJ+gm6X1GCOFwyo3DPBWPYOq5wE9UgbYiLs6Ycrxw0WF9sbNFnU6dVQwHe4oCwMutPyd8iMhFcaN1PIBmy7hsNzaw8dmYR0V/Im3bPG9i5mZ0+6LMty1EfK8l0RcCw7bY+9+mnWFROvCOHeLF4ze/9vX02Tp9NwPeEj0kHfy8DspB9oj6OwjaHpaN/SB3XK+pyfXNt4wxppq21mRAWphibab7ox27R7kTIqx9yw9ubX7OXaJGqbiPeFEckq08jJAzhoDup5jgK7hq4bH9I6NuCdxbnKQaaLWeDiTfVcyJgyTDFIOGjyT3v6T6Be61VCdCUKaLDSEohWUmYCd+3zb+mhzoMu1jVfXNX7R5E84rv7ZyAAq6SW+yKLcWynS9do1ivyZolNKnCy3KwSgYrORnBKr36lqL+os/+EaJVGq1Fm6moGclRWErxeEULS7tW8+mICWhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(18002099003)(22082099003)(56012099006)(3023799007)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /yL/32Ssu4yjvdFuLSU+uIPXoBPzluOUvSh1AlelfkHzLsqc7jZf1iVTP74SQgOUVfrl7VGiFlDJWpwGQY+URMnCH7lDK7lwc6xDRMgf/MjkD7GZWg8/2Y78nndr5RR4+2xHRyPzE9lugnLjTZ8g9c7PmgZ2GhLu4IMXxz6lOmSj93tY7n+3XX4I7V+FXPsUMCZZBLLD8MvLkOaSaJiLadspYOEi1UYJZn74BtpqCRGMXpNiWiGEYGSLIr2OTy8HGIizcNbFSUDOFcbLRbeaL8HgwTHBZVJYv9B17u1Yhs7JZPZbpM4D9N7Ek1zizYVSquVRhpOzOAJi/r5/LPxcadO5hvV9c+SqXnJQSWOnTodceLaf26TQVXOz0nXXLvJGUu33Lyqp/x/eM0nqOVBeM0EFdg4QPfU0tVBOCKQdKBLmRO3BH9QNOnQICXD6sx81
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:34.7359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6890cb33-e8bb-4709-d78f-08df2462e938
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
address for save/restore buffer, and size allocated. They are supported
only for user compute queues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Ie866128243c426bf4423c01aff136fc046e84870
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
 include/uapi/drm/amdgpu_drm.h              | 11 +++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3b7a1479fbf7..5311e1ad0201 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -461,11 +461,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
 							 fpriv->xcp_id);
 			cwsr_params.ctx_save_area_address =
-				userq_props->ctx_save_area_addr;
+				compute_mqd->ctx_save_area_va;
 			cwsr_params.cwsr_sz =
-				userq_props->ctx_save_area_size;
-			userq_props->ctl_stack_size =
-				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+				compute_mqd->ctx_save_area_size;
 
 			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
 			if (r) {
@@ -480,6 +478,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				kfree(compute_mqd);
 				goto free_mqd;
 			}
+
+			userq_props->ctx_save_area_addr =
+				compute_mqd->ctx_save_area_va;
+			userq_props->ctx_save_area_size =
+				compute_mqd->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
 		}
 
 		kfree(compute_mqd);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 527199e4de9b..9317018330ec 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -470,6 +470,17 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
 	 * to get the size.
 	 */
 	__u64   eop_va;
+	/**
+	 * @ctx_save_area_va: Virtual address of the GPU memory for save/restore buffer.
+	 * This must be from a separate GPU object, and use AMDGPU_INFO IOCTL
+	 * to get the size. This includes control stack, wave context and debugger memory.
+	 */
+	__u64 ctx_save_area_va;
+	/**
+	 * @ctx_save_area_size: Total size (in bytes) allocated for save/restore buffer.
+	 * Use AMDGPU_INFO IOCTL to get the size.
+	 */
+	__u32 ctx_save_area_size;
 };
 
 /* userq signal/wait ioctl */
-- 
2.34.1

