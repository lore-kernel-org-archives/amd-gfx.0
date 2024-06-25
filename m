Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA05C2BBCA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 12:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8147210E642;
	Tue, 25 Jun 2024 12:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GmrHF17Y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0BA10E0C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 12:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4khH/qY1k8UkupTA7ZQk9p+d8S1BYFDDoMB6Am6y2wCnvoFVW4XqjmT8naE5oRikawAWt6gYsI3TqBHc6q/IA82/EIbr39YbCI7S3Kl2PDP4+15BN8jDat/+wbPGruviih/nFI9wh0TlldOTKeBG57JZdZ1LtNW+gNTtfm7GCQ/bbDpWi5cMy0+gr44vW6QZRKwqHtk0YJ9mlEsGtBXia/FUmrgQhw2DFfkVAgaYdf3+YGRLwt0ENJKrxAJ28QrCKy5JpR/gsLwvgD6v8Oa6DiqTdKxDAoi8P48Rnx/63MluQ36aPquWQYIAGxOTnTtgcjlF3UkhSPRo+LmSWkMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZtMjz58naD8Kw2SsBujnksB+P9tZPwz4zDTH1I8mrI=;
 b=KmGo2/NO8/q2PlwhRUE5cZJzvygWnDDFSUvnzGNxlXXqenk3oxdLGCnde+4mOzOMbZxCWK96x9F/geCHaa5gGYgIm7kkU6p4gQRtybYQpNucu/wy2ZBRjwYHgdM15kpwoy+GMQ7l/ycWZ9Cuy/GyZ/IVGqnGNK2QMtCMoFA/QJCqNqsfHOgZ2znOtUVrnAXgvRq5Ksm8wszjubDmJr5k+E1qWOIH3YEUMxiRPpcW4NKdLS7UsgmkbbwsQeyJnh36kk00HMmLn0OI5OLFTUzP9ElFKJDultsY8iQLT0dCYwPuWmUgiaok6eWCzI2bHg2lkoBNXIaUkGSQpK7MFo2/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZtMjz58naD8Kw2SsBujnksB+P9tZPwz4zDTH1I8mrI=;
 b=GmrHF17YqqOQyorEP/V8HWG4ISHcIoD2DElXd4wB2Qe8JQjMlqpnjra1D1HYfQ2XFtGh6EPkttwxxOrYrFYm6YchbfliTTzyYPxOD2cuunxdSaQmjrP7pAY93OpH7QCVjcRi9CTAmpH61QgsVd5DvjK2YmFLe246/OR9m7CS6zk=
Received: from MW4PR02CA0006.namprd02.prod.outlook.com (2603:10b6:303:16d::12)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 12:43:36 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::d5) by MW4PR02CA0006.outlook.office365.com
 (2603:10b6:303:16d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 12:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Tue, 25 Jun 2024 12:43:35 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 07:43:33 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Tue, 25 Jun 2024 14:41:59 +0200
Message-ID: <20240625124211.132100-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 773f4835-ca35-483d-fe62-08dc95146e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|36860700010|1800799021|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MMAikSxinXopRXGGq5QnNIwMTv1Wf8xR5Qy7pFDbDo/P0aCNwhXVwOgmo+Xf?=
 =?us-ascii?Q?JzpctMO+nlq2bLqDfjJmlDyJSCZdT+8yhMObXet/Ff6smDaIYs0f1smsLyXO?=
 =?us-ascii?Q?8laTGNgdKyrru6VFz5hmT/HJu6ijG+5wkSRRSeGBk4s2rxeHVblhZPLovnuo?=
 =?us-ascii?Q?bkVRHiRTNLY9A+0CVbuIM0A0+osTbgD6oA4SS7JQc2hbOunPV0SOcF6c6c2h?=
 =?us-ascii?Q?b1dPu9FJq2rLPdUnIYplsvpD+vHr0N6ndyE6j3u6nr1/a8b51sfUo84TOFdO?=
 =?us-ascii?Q?6UqJh82Yx38TEQ6zbd3B7KgVce8FJMeo9ahpyJGtZ++1eNg25vr6UMBU0kIc?=
 =?us-ascii?Q?FensYTTmhqA/dLim2atDJP1jnl+KZ8RPRXN3ng+dL5vO+JRG6e67se86ik1h?=
 =?us-ascii?Q?vfC/aLNPnhfVpVXYhWWb+/UbU9VtrtRRBq8PY1CppSAUMPg5HtxClaIAksOI?=
 =?us-ascii?Q?XdWuSc48VmRzWyZtXVc0UdJac1bxk0o595dLuCGZBViJySvFcyE9EECobF1a?=
 =?us-ascii?Q?zYWCQoY34J58eA8fF8hKtyWVGP8jL9yW5lWD7vdJltIRRkqYNeuaB17SWwKv?=
 =?us-ascii?Q?YiFQChjnEMTRhH4ujch2DBIt66HWpf+9wF9XIYdWpnWOsFTUgIHjxfWn8tDj?=
 =?us-ascii?Q?g2HpnoLoeMYfcDTLfZErJ8HlrehlEgf6jgyFBsyP1xgFKSwt6c0yWQp6MEhe?=
 =?us-ascii?Q?GndHg9KS2bDIiOTyxj2dd4SB5+a8AsSG9NaNl7OwId9p4KBi9kpce/InFQMA?=
 =?us-ascii?Q?/BN5nZo1hdgBwbsJ6XWY7GMBAyypBbY/ryhwGxAd1LLJK2St8HV4Tqzq34vj?=
 =?us-ascii?Q?Bf2BifN5hE41zIBux+zQRJvWgOLv/dz4CYODpE4H1a+uERYDg2avGMC6GkvT?=
 =?us-ascii?Q?WYngBEodBw6+QJL9o1wuyC2DXXq3onsQZmHfEGG0b0R9XlmYATf6bq9Aw4Pe?=
 =?us-ascii?Q?VdIRp24sEKD4VgLvoAxJo0QzmgDl/2jgW70rjj0mD0ob8/ocT1t+vME3N/4t?=
 =?us-ascii?Q?Ktvq1TDvzGWnUl6YmAMfh3LtPCi2BisQQ/Dmeky3XemTajh3CUtej6+/2wyE?=
 =?us-ascii?Q?TNy1IdJ8pWStMJ9l7hFUqu08cTOEk5v7ENmbL2XBDpS3uWuspcowu5PEqT3k?=
 =?us-ascii?Q?uQaswt968j+BSZuD+TGR+3ZIxmnu7uFpX/a9bChTvY1suMn5whX9y6T12ztQ?=
 =?us-ascii?Q?04EisDrKhZnEmJNFVH/A6Prk269NqDpnROwPuUJlL8+8H+nWdViJ5MAIKkrT?=
 =?us-ascii?Q?WTsw3arumWBplvf/N5TozEg55QIwdb7u3HccbfJ/zLtSE+hQhv3fOYsF9FfQ?=
 =?us-ascii?Q?bGriksBq+OLUGzQfPv3AvEMAC0k3lSXzKnW6W5q4K320R2nf3DG7eVupMz6D?=
 =?us-ascii?Q?SOgkqLUkxo9GFIQhZFqAYo72u+u6hrqinUXPXiplSY30ixabwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:43:35.7171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 773f4835-ca35-483d-fe62-08dc95146e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

The call to radeon_vm_clear_freed might clear bo_va->bo, so
we have to check it before dereferencing it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 3fec3acdaf28..0cf1a72091b7 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -641,8 +641,17 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start) {
+		if (bo_va->bo == NULL) {
+			/* Buggy userspace can try to use RADEON_VA_UNMAP after
+			 * closing the BO. In this case, radeon_vm_clear_freed
+			 * will unset bo_va->bo.
+			 */
+			r = -ENOENT;
+			goto error_unlock;
+		}
 		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
+	}
 
 error_unlock:
 	mutex_unlock(&bo_va->vm->mutex);
-- 
2.45.2

