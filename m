Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4D0D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 15:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F3510E4A0;
	Tue,  9 Dec 2025 15:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fvShn4IU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013070.outbound.protection.outlook.com
 [40.93.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DF310E4A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 15:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTd1Hm85svScH2rj9jm8Ywp138EuW74uEOivTJYaSraoY+BZ0VyJwGIZwI+tCQv9/N9A2O0QWDdWMbgKuhPU/+F4VfEF8KB0JUK/pYlsb67Drql+pmzpuu3elUgBWlxgO5tT7nZppBbnwka5SPVT0N2+T4WrYLV23yLhat30Q/0BuMzwESmqCh4/YvvaWTGmr20+WQOaWk6WHr2zH3MQvZP7BPGCLB19IHxN743VydxTuE8Q1GKLZ9Wpx7HHH7wyxr/9c7sSbGfkIBH3A2U8KZNwhO7ESr9y6zsyjpBpeuP9AvA0R8l7B+eEjAwFu9wxxFnb/9Kze5U/9X705nfuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5Vv+AFSgGVyNjiyrfIVNEYXyT6qQQkg3kNaSC9avFE=;
 b=o2jx6ufSqbb8W/33RpCfrv5HOhwVUWfio1VPU1ggqCPf/cxB/v77J248R0Q1zcD39S3NEUeka389jAnrcCSTUd1hk+W0AfzASYognPPpClA7R+hU94Nt4zuRMSMsII7FkWUiXiIJ4ZvwTCPmrWvyNDaTLDiTLRjIIOrAljxlSzMWhtEkj4dV18ZMUcHH8HMv0+vsK8Ab/2KXyJo01Qr6Hs4I0KruzbiK/+5qY13A+jPm24ipk+JhNavwxipzJjpchZS3KE8DVH5Ef9zrv5rkuH7ylz+Cw0BllRUQj+wPibbYXiTDfsM0tCgUL1pLqdFsAtZ3U0Zz7N9IXATO2fY3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5Vv+AFSgGVyNjiyrfIVNEYXyT6qQQkg3kNaSC9avFE=;
 b=fvShn4IU97yaJoBt3pkSbFk7B+5n5saUuXXP68NIwrBJm0uiasDyUAvT1yXrF9+ySZKym4xDA8HmjeHvHkf3lTP1zb+mFhgNiPkvl4dSnX/zVysSFk3wHzSApRWwL+xS+fefdo/YtCFKf/Y/Z9spXl/Bfv+Rd9XdcKPebm8tvY4=
Received: from CH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:32::15)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 15:37:19 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::af) by CH0PR07CA0010.outlook.office365.com
 (2603:10b6:610:32::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 15:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 15:37:18 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 09:37:18 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, <lijo.lazar@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Handle GPU reset and drain retry fault race
Date: Tue, 9 Dec 2025 10:37:06 -0500
Message-ID: <20251209153706.195420-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acf7017-9bd5-406e-f2e4-08de3738d67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m6EnahBYVcf86A8oaXFnbkIv+95ixj5tlPI3dQ6GXOQy4/hL0WDdfTpPyzTk?=
 =?us-ascii?Q?wFSXzXPAcszCGalnHTWPgLUKOXKRQQyWOWk/aVNxlBZSLK0VN841Funy12r1?=
 =?us-ascii?Q?pStSNPoDkrb6dUTG7L5lwQ5Bo1AsHL4nRZsAk8td2AACUueia02ishOwSLOk?=
 =?us-ascii?Q?whWNceqlon2xLV2tQYZDHj3pmUKwS565F5e6gNgS1hPhiyom+4er+dTWULkO?=
 =?us-ascii?Q?6odL5K5caQ26SxmYwP2V2WNwOjVPFAS8bAVRgh7fhIH+URzddi6C6W5fL0Hg?=
 =?us-ascii?Q?FnkLAOFD7vFzVAKJ5prLBHowhvG6sleyO/tVQiK1BpvAAoykmQZa8A9OJBXj?=
 =?us-ascii?Q?MeqkA3+0H4aQb0y23bXYfJMwyJEleVOsqLJRxPAv+1GALW41sTBbJ2gynfc/?=
 =?us-ascii?Q?SyqgzBEHTOoq4FsfEHpb847FRzYLjKjm/JFpjlchXoi0G5W7PX/vGWgdVRMe?=
 =?us-ascii?Q?jOkPhgwcfeXjMb0sPlnzwAvccjvx50EPWgCEhEwVSgEEiq7UQflgEWKQbRQS?=
 =?us-ascii?Q?4Yiav0o/cRocY5n+7fH+jf9AK3C7aHJP4aerjiA3lREIRpwEvH49fVoZgHVC?=
 =?us-ascii?Q?eckAAOCvkeZEYylaoBSMyX6Ye8A7TvpjXA0BHHFDWYUZIbzcJweTZ/LO1OjY?=
 =?us-ascii?Q?eYTYra36beucpjTCYrqewrzqTmM5EggESBi/x/q4QCx4cpj3THjyPxi5s17j?=
 =?us-ascii?Q?LZ/uNT6YDIuliaDqu6Jqnkc0bRDbweg2ZInwqQgRQopvXHm2aUHVy5X0m+ja?=
 =?us-ascii?Q?iq4YfHNm5K90Zw9qmojJZRau1AAC8oaZv6UzqEaLIaKFGZmnMWXslz1oWgzf?=
 =?us-ascii?Q?eEJcR5q/KkQJjb+gXCG+szxKn1/BPO/BvoOc7+iHvBVm+BMAFfuCG3yvr6pQ?=
 =?us-ascii?Q?5PvoRHpB/XKelKARrUevAhZmkyyV3WqoCztaLZLg/75IOe2tDGlY4ggZu4am?=
 =?us-ascii?Q?l+Jm3cmWrmH1BHitYVmxDLrYBHzryBwIno8DMKVtv6YopGAMaEDBTVSlwhZK?=
 =?us-ascii?Q?mcLkcY9ayjcOdpXRlbN1avtRkkEc5wa5jDCYEPjqf3dd0YFpxPss5ZVn48YR?=
 =?us-ascii?Q?ryU5ML/99Eyq2ZuJQJUUDYho14WeJiMwCbZe5H8K9Up3fMsfj1EHQNCXWkQN?=
 =?us-ascii?Q?Xzdbg1ps7WUeu8CsLyh/Z8EWfjZW91B5yMR3VYRzrv3EBcOTKj3CsXnnxftJ?=
 =?us-ascii?Q?fuW+0cywPDRX/IB9vWNP8i4EublGEajX8rmd5FaBpst7o0F1wWX35CXIRfpp?=
 =?us-ascii?Q?052Z5mKPJcqTLsSAPkQYCGPHG/7EHUjSrZIDoAkdyeygfFcxvmMgxKqbJrZu?=
 =?us-ascii?Q?NHG8Er7dAMMlAQr6lF68pk6GKZAOZHs4hlGR19h+fQ4oS/eE5AxP3mD4vNNi?=
 =?us-ascii?Q?xZG4tz/zz+qCPscMQMI/ORhYzTrKwsaZypB3p/sMhfP7fZk+dJgAjoS4VwCr?=
 =?us-ascii?Q?E9KZcwHGQ9P3AJsopyOR0vM6y0tt4vL4PvZHj4+iYnMBJLyFmCAJfPf4E27K?=
 =?us-ascii?Q?JdQqi/z1l9BfaJPAaxL8WhA1lLyFi58Ufi0NgdNPwKIHz5OBLIyGnmqRHhb0?=
 =?us-ascii?Q?ILhHe3qvJq92bShYGyE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:37:18.8899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acf7017-9bd5-406e-f2e4-08de3738d67a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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

Only check and drain IH1 ring if CAM is not enabled.

If GPU is under reset, don't access IH to drain retry fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 377dd75f026b..89c5163b867d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -33,6 +33,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_reset.h"
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
@@ -2367,6 +2368,9 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
 
+		if (!down_read_trylock(&pdd->dev->adev->reset_domain->sem))
+			continue;
+
 		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
 				pdd->dev->adev->irq.retry_cam_enabled ?
 				&pdd->dev->adev->irq.ih :
@@ -2376,6 +2380,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 			amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
 				&pdd->dev->adev->irq.ih_soft);
 
+		up_read(&pdd->dev->adev->reset_domain->sem);
 
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
@@ -2559,7 +2564,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		adev = pdd->dev->adev;
 
 		/* Check and drain ih1 ring if cam not available */
-		if (adev->irq.ih1.ring_size) {
+		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
 			ih = &adev->irq.ih1;
 			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
 			if (ih->rptr != checkpoint_wptr) {
-- 
2.50.1

