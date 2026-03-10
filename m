Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4626FFCC9D1
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 07:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D465810E204;
	Tue, 10 Mar 2026 07:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u8tg8MzM";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013047.outbound.protection.outlook.com
 [40.107.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5596510E204
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 07:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgybKE3u+Yz6e5NEDKj1pt6m/2Uz7NvpUWvWTivj6HdBo1GaYE2YuZyIFK2+JxHAxIDwmM+foyk6wy23UIbozJGMIltFXH0gVF10qV4PsF/Hn6X3lghKLt2f4yN2gmUKlusq8k/WDQzCFC0423HuEtLsUj8Al1vxhkvakzT0z7FGJ+jAO2RhHITj0fnsvHu/BBdFSQraBbEWmqaKpDcHu7z3SvtbTRxHRNkuiN+ETEjZNIqA8VHtk9F4sp7MYP/uMjEk+AOoQUC7odOQDPQUEuHA14W/7V/jzsMWrApOsfVfO1dG33xXWbeXyr/aasahSlrfmrgE+LNQWJ00QPojHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMj4MJS1aLPmnMM0R5ndv37zyqHrFmux1pcckYB66fo=;
 b=xch/qQlGCnkijrHimKKiqhzTilY5P99HLmRBCAv5HVB1zFERumXdfZN/4+HTl4V+NYPwQv5r028r6vbdWUi7T+mIQsYOxDgTz5t1L23yXwykl1PWxdZYSIvO/+5Rtjkc3rwySeHhDXkCYq2SNY+vhUk7bvx8mRLla6xHhLHtjt8C27Y+3k4SztY0FESxgUZSHE3R9voMzR97ummIGGAqK2tl1BCTaw8p2PMFREbOo3hHLNSVNu8MCRtuYtWJawP9sAEjvqQs7QIfaZaXXbJX29oFncIjlKXuQY0G9NlA9cXQ9lORbO97ocUB2zUlTCON/44IOMJEj9yV7Ez3J6gLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMj4MJS1aLPmnMM0R5ndv37zyqHrFmux1pcckYB66fo=;
 b=u8tg8MzMd4wqQUNmsh+yOoL1D2aVz4tkRuOJj327pDGmmS1o8tRl6pWRGrpSZb8aemkJAb9Y//MTs77d8LqQQRDc7fxQbbYqM8dxssyPYs/RDGNpXlp1lbF8lDMGt75UZAv3u1AvQjMAxpD0evD0u8cn1MVwCTzjunkk1pnihm8=
Received: from SN6PR05CA0009.namprd05.prod.outlook.com (2603:10b6:805:de::22)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 07:03:02 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::a) by SN6PR05CA0009.outlook.office365.com
 (2603:10b6:805:de::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 07:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 07:03:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 02:03:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: remove the WAIT_FOR_SUBMIT flag under lock context
Date: Tue, 10 Mar 2026 15:02:52 +0800
Message-ID: <20260310070252.3217741-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 272147ee-a0c1-4270-2942-08de7e731228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: sWpdrcWqZqv/P6ZkUrE5xW+eyZGdW2PS6ZCzSCkxFf7ZQZNFS0K6sKD4d5s3GCf4wNr4MNC3YRdAUNfUuQrxhZmflD+A/uDwl6N7xiA/DKHtOmjVogEHGxwqLFvtkoRHi5EW++G6Mnw8TRQruc3Eqr6l2bcINyfJOIBp4k/IG68XsXRi+do7rvvUcZ4d/s3u+OrL3V5Y9UyARUr+Td0TPNFegPnhqts39GvsGoQNd4hJidfNRcOV3asruuySdTQ2mGsDytYsNXyD9FmwjLBas8uOvJk3jhEknC8NwYIsheEDbn/Q7tuKPCb5uuZ9BSMy0zu+eCkeEn5RQrbGjwCI5iyoArjA9q+BRA8mi0EQbSJnb2YtZ6keo/kaHjKKiscl5x+uAmVpKSH5Xe2yHTnDlTGPcqhp/JNdrVWs5aYqrddZKGSJoA2+TuzHXVhR9f1hMyN82zLG0DAli0nuVvcAA/xkVd4dsPPai+w2ZzuPSxtbJy06MISdAcXd9sdEAnP/WhNgDTBNdIXQiCQWKh8dfJh/kU3JbB+CY0fRobnahpAwjqrZLlFerompkYBK2RhxQ7v+VTsQuKFE3fkXOGzrbdEvsosjbOln2BpkIm7sDMWrEkNNUAv+l03Y5+5X3CLZ2ItVQzACiVhs480SE2cLeZN80H33xwmqc8M0MueB7REVFbRDZEtgIS6D8YpDgHDHYnfwvUp66EiIpo72ebvrz91eotCCwmV6BcWiLySuO+Gv1t7AQRYwv7DBT39z3js87zUOZ2n6HjdDw444lZkUSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 78cnxL3PM0CPZK/DdwFlXjjPaG5ZYsDKjudhan87OMdR5WpyKbNUrtK6GzvgU4aJv5LsjBpDu6qFsvfRDpxPhn5IG3SoYajFBJDMeZVYKCIPa44vM4hDOzEZZceqo+WxQbypxGqBzJndlQJAlNcUdJsOaCwZ2cc4VcWJKooIFluP3AmGHUw8GQnTcuf4kFYHO3zHGdqG2UqjPBCwYvLIjGoRZXuzfou/2BeqsY0BB4a1LaeFnFU6i6ImJPRRrKyw+g4qpqGeenLr1j9AZBeNm+biL5tXPGrxloyg8kTYgIOR5QMlnAvgpzfeapd8ZJhTvo4h+yirGGh3gZ6iFaw5+BLi7hSrj7NPKPsIpSbScymGF4e/b7NquJPR0sHcAqgr7lqG9VBMI2VXO8dfBNxT+2japqw8xEBUqVi5WVtwNgAQJXje2ZrL/ip0DNQuS/I/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:03:02.3659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272147ee-a0c1-4270-2942-08de7e731228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
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

In the userq fence gather and emit IOCTL path we acquire BO locks
(via drm_exec/dma_resv_lock)before calling drm_syncobj_find_fence().
This causes drm_syncobj_find_fence() to complain because it is entered
with locks held while the WAIT_FOR_SUBMIT flag is set in the calling context.

However, the userq userspace path does not rely on DRM_IOCTL_SYNCOBJ_WAIT to
wait on fences that are dependencies of userq submissions. All waiting is
handled separately, so the WAIT_FOR_SUBMIT flag is effectively unused for
this IOCTL.

Therefore, we simply clear the WAIT_FOR_SUBMIT flag for this path. This avoids
the lockdep / drm_syncobj_find_fence() warning about being called under a locked
context, and has no functional impact on userq behavior since DRM_IOCTL_SYNCOBJ_WAIT
is not part of the userq synchronization model.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 76f32fd768fb..7a309b0130d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -708,7 +708,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			for (i = 0; i < num_points; i++) {
 				r = drm_syncobj_find_fence(filp, timeline_handles[i],
 							   timeline_points[i],
-							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+							   0,
 							   &fence);
 				if (r)
 					goto exec_fini;
@@ -726,7 +726,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
 						   0,
-						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+						   0,
 						   &fence);
 			if (r)
 				goto exec_fini;
@@ -818,7 +818,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			for (i = 0; i < num_points; i++) {
 				r = drm_syncobj_find_fence(filp, timeline_handles[i],
 							   timeline_points[i],
-							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+							   0,
 							   &fence);
 				if (r)
 					goto free_fences;
@@ -844,7 +844,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
 						   0,
-						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+						   0,
 						   &fence);
 			if (r)
 				goto free_fences;
-- 
2.34.1

