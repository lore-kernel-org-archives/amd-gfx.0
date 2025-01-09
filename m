Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5329EE77199
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 10:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02AFB10ED51;
	Thu,  9 Jan 2025 10:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gqnmecH+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2283D10ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 10:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7YHIb87P5ddUmL5xN4glSW+rKrClmAB6Yu6rjGIkTg3UqowCBuYKF9Xxd8fvow5e2jTed95SEbwUVOf8ccvgjDyfuTD+v/7Ej5NY9qyBk4QXAPufJ9JRVVJhkdZxM9m9AfH8Ysw4Vw4egDFjHu+tGU6zO/eDo5LkBgDR56xPsInR1iFb2r0bYWan5JgkK63QaSEFRCi17gWRkeSysfjax22Jxk8Vt5X094hl41J7x49vQUDP/VP7eXX4TV74JZqFcaVnd1YD9p6dmfQw4DgE98W0AGgBowGIE8qprXyog60IdCiIgODUm1zXDrgSgkI0qYN/uejXtLi9dKM980iqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHPKurppH6oosZNxe1usJ0Gn9bZI4BNmxMT2jybs1Qg=;
 b=PEi+jFKLPaOrZF+dUg3PLPLJlleBpn2svH3vnXhWV6pQyfR2SdUwgeEBaztEp24slLkexAU+aXCWKDvDEfr5a7T0J34ZyhKQuBnz2VPdVTwp/65D8+y7Rm0+bah9nbkN/l+vUXemjlZVFpISDQCeAhOdEnWBF0VAuXaXhH82pp+q2XDzqGMsNgO1O439n4x/L/uALM9NR/K/1E8XZMwGBmAO1Ka5uWiL8xQIq8yFXFjxCuZdJnfljJrdWsGiu8iWlRGGXVcf84IDjzFgWyE9yQy1UAIs4CwaewPQWe1z52XkscSI/AWhsHCxwJnxUFt77YOwPN47/27nSuYCl+nKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHPKurppH6oosZNxe1usJ0Gn9bZI4BNmxMT2jybs1Qg=;
 b=gqnmecH+/3NB07PY8/2fBGhS9R8XUsvBQLrMBKqLMCTgQQmZFOcWKUb/bZHhSjdnRm1MlscOo+GKh0gBk3xFMNVmjVshwGO6rjXZYoZvAmWo2gnB5xpNmBkGSU3Kw79XgRXaRuUeyI376PRfcP57NnkuTkYpLsBFddN+qhm1TsQ=
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 10:35:41 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::af) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.5 via Frontend Transport; Thu, 9
 Jan 2025 10:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 10:35:40 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 04:35:36 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <shashank.sharma@amd.com>, <veerabadhran.gopalakrishnan@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: add db size and offset range for VCN and
 VPE
Date: Thu, 9 Jan 2025 16:04:50 +0530
Message-ID: <20250109103450.870169-3-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109103450.870169-1-saleemkhan.jamadar@amd.com>
References: <20250109103450.870169-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 851b0616-57c7-4c92-ce19-08dd30995d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sGqGhG/XBa4jbt4SuunyBLfI4NGw4ja+MgQTkkY9dERS+2SZROx1clj/gmWu?=
 =?us-ascii?Q?wLux1xKtMnDt5ikRAD4PXZpKPBhhttNbsFtqp65wXJQnG24oS+5st7yncAyb?=
 =?us-ascii?Q?PghenkGOY6CW3GuE9gI1fNE8jIR0gdNaDK8W1EfYOcveySzMgT4kKCVmMXZT?=
 =?us-ascii?Q?YvCasy6PXc15+dyGXVi+dzJqFgAbYPHrg/fn3ndbCOmQOV6TaRjb6e+hPqy2?=
 =?us-ascii?Q?BrY++hCm6kbM1vKgKBk7wvU66oFGcXcemGUp5jtsTV1vL1O0qss8XAYHCb4g?=
 =?us-ascii?Q?deZYQAKhVv8XCcvUoLPMwwfyj1O7McVVYBMYzO6QLt3040g56eV5Zja8wBoC?=
 =?us-ascii?Q?ZrysolCg9ZPMKLM4DqGy457Q2yOMcVXNFAO6NBcaRdW5vZmYvckWMhbPhFQi?=
 =?us-ascii?Q?nnxoXurAILxOThn/M/3jdtpn2zA8m7MDNOAhJDf3dIUOsZ/MAkziJlHvYNkj?=
 =?us-ascii?Q?Nt4EEKIE58vpLybN91d+RJYATE5PeDPzFhVNOYgC2mqz75bGbSCHC/kGn5Xv?=
 =?us-ascii?Q?+fvqsH0O5HH4pLozgLGeLI0bPhUPZ2Jvb6rzHCMGXexkhf/l/nCR8b2mcSfd?=
 =?us-ascii?Q?vRW80KJb6HvGsU2jTcXF5toNJvfJdD3aFdvcqPex8J2zPaujo3Umz1HzEOZi?=
 =?us-ascii?Q?63PW1kskj7QpBqtScsj38eYKzzILEgF1RMLhJkWoBVRBhm0UgAvIMuUSDX4q?=
 =?us-ascii?Q?UmsfUDHtIrZcOqGQzof8vuzd5yogj2uOyEmveP6i6ScUW58AfcX/Zpb8/3FS?=
 =?us-ascii?Q?x6TCG2ubameGUORU47BrcFeGfEeiYzAc2QibnsVjS32UlS+a6egV1AHcz4yl?=
 =?us-ascii?Q?ydhyDmqhmz17BxzQZnqRkOyKs+c/oVOz/0DGKxmN2Ja3V7vNnfejCHHqjHRb?=
 =?us-ascii?Q?mzJfW8mHjYzldEUVf/zzcEf/YXE6kEG7nMS54SXjWPQEF50XQ8DxBDSl6lRN?=
 =?us-ascii?Q?DiC/866e1pS+OvMEoeTfsi9CTBADvwin52udjot6w7t8uyrXy1Lepubs12vO?=
 =?us-ascii?Q?pw/cGbi/7uSZSs2ra7GiP2yWT+zmQBa1Z3dO6YB2zl25y32q3gIZfom9UQm+?=
 =?us-ascii?Q?tC0vXn6zXwHJiwTne8LtVPhl9uGBt1FBmJxfN0lYlpjxwGsZqAX7dimrYsbT?=
 =?us-ascii?Q?9SzJmgYYZi3YBCS+ELadwzw9A90eBKpKvrQyzeTz/tjPBy305oaCa7yysHXJ?=
 =?us-ascii?Q?Ejq4OHoPAZ62qUl1uf380vr3SgOkBKY5tn35nlEMW5Te8fmuBeZyHE0Y/9LM?=
 =?us-ascii?Q?W+RDxyaAydpON8uCYzOFHRtOJ3mc1fJvX5586UuaAAlXSaLKRCU7urbucH6n?=
 =?us-ascii?Q?Ov4dQcFciAF7nWF2BpRfNbEMvvq7KZUzrX2akic6mIcWGJ+WZ5eG+SzKT4Pz?=
 =?us-ascii?Q?21b7p/wLrWZDLe15HIzy5uoaN/T+j5Z5Ln2N5Ath7f4xHc3gipl7S4i/nFoT?=
 =?us-ascii?Q?w/o2EgXgvNa8xNVlKMVQQ3ph/S7US7hmhw1Ij7VSht5p3zBGI3H7n5MDEh54?=
 =?us-ascii?Q?IfpcGs1hQ+h0cN0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 10:35:40.9474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851b0616-57c7-4c92-ce19-08dd30995d5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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

VCN and VPE have different offset range, update the doorbell
offset range repsectively.
Doorbell size for VCN and VPE is 32bit .

v1 : add gfx switch case and fix checkpatch warnings (Shashank)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 769154223e2d..acda3f3bf3e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -221,7 +221,29 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 		goto unpin_bo;
 	}
 
-	db_size = sizeof(u64);
+	switch (db_info->queue_type) {
+	case AMDGPU_HW_IP_GFX:
+	case AMDGPU_HW_IP_COMPUTE:
+	case AMDGPU_HW_IP_DMA:
+		db_size = sizeof(u64);
+	break;
+
+	case AMDGPU_HW_IP_VCN_ENC:
+		db_size = sizeof(u32);
+		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
+	break;
+
+	case AMDGPU_HW_IP_VPE:
+		db_size = sizeof(u32);
+		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VPE << 1;
+	break;
+
+	default:
+		DRM_ERROR("[Usermode queues] IP %d not support\n", db_info->queue_type);
+		r = -EINVAL;
+		goto unpin_bo;
+	}
+
 	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
 					     db_info->doorbell_offset, db_size);
 	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
-- 
2.34.1

