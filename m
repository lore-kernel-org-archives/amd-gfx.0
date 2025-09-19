Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD52CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 719C710E964;
	Fri, 19 Sep 2025 08:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HiiHQxfm";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA7710E95F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5nnSIXww/b4pM1UJZcONuXjBij+efzHVisCzRVM2Qpk1YPaSUF2DOQamzb2/V03WoJvWxM2+sGrSm1h7U6rs75Vl3il0plB2O5tPfka7MgddVEMA+FfCym3HR6cdsAfm0d1FKEQA2PHwzbtUOQ64z+bDX0WaMGpOzO2yRk1cgMXK9P3QZJ9AndSaRGS8cgzXw0wT0zOn159tyMg1Oi9Qo9tG+TTrfnRq+Y4oxWFQq4+epNIIe42ZTPvkbsehnKAxa06VvZDss29WzT3pFY0wqCqDmYahTHXsSwmUZ7sKohxP4n4r6R7zDq1BXUIaAqMxVQNU44Fxpki2rXzqMW8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI4YiGoV3YQSyC5VSEyBpcrwEk49x54+VxFlZtSRBBw=;
 b=qvJ4UgaA7pBNfXwjSI/Hkd1sc6jTQNx+6i2T90KcZCu1vRKhy+TkVTn0rngyzwGRKrbLhnk1KbjRRm9cnuriQli/KfnCljPNP0s71UTgDFvs0XKKVrV9yRwAPa9WoflqUnfF/lHyJ8FjLH8I+aFfPuVWxm/R3XAgLg1bvgrFASXTDuqpeap1bNIkxJnDxBdZo21yqRmJ+/9Afw+G8LzSeMogSIS+oeiFMpwW+mLaSvZyNpRC52Nem3GXRhzFHZfZshn3yPtXPhRe9BqJ7qEefPMarEHvD3RZW3PAltg2pyrXfbmvptoiyCoRthn1noJ9f8fHXFK09o6/TeObI8jZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI4YiGoV3YQSyC5VSEyBpcrwEk49x54+VxFlZtSRBBw=;
 b=HiiHQxfmmaFAEYaATcL5rX13YPQ/xSWIb363vDpdDI7HFCpojeV04OVxcNbRiX1EQfYxwwFW5SSOCGXeF/PqjhzvGhSrQ1c70J7GNilFGU5K8JFXEfwctXV2WC1Q8GzX/bZdOonhwv2EYaUkHs04BllvYB2c+We7D0MuPSHOyfg=
Received: from SA0PR11CA0079.namprd11.prod.outlook.com (2603:10b6:806:d2::24)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 08:11:30 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::9b) by SA0PR11CA0079.outlook.office365.com
 (2603:10b6:806:d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 08:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:29 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:27 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 04/10] drm/amdgpu: keeping waiting userq fence infinitely
Date: Fri, 19 Sep 2025 16:11:07 +0800
Message-ID: <20250919081113.2797985-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919081113.2797985-1-Prike.Liang@amd.com>
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0f6d5e-f5af-4281-5b1f-08ddf754235a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u+Y1Z6qicOg38invvZlAunRbBie+nZcJPC8e0fyoerDh4FfVVfTKq92Nr/wu?=
 =?us-ascii?Q?GTi9OgMYYKVuuMSqiaVwpgzj69miAMOrr7Ow1grODEa6Sag6oSTNfs0c6rXV?=
 =?us-ascii?Q?7wWjh7xo8UMOj9plxCCd8RgZjm2YdiUwitkhTzwbh1TsAmhYHa022nSWGH8R?=
 =?us-ascii?Q?YxRm80L49tUC13AhOmUeKoU2W77SAQtWmPe46XIOzehvezO6Zq47PH7IfjJu?=
 =?us-ascii?Q?gR8MtU6pKgHa+Dgx3DmY1gdfinR4x6xMOaMf1hteA1J9nQlcBG22CbppFT0d?=
 =?us-ascii?Q?Z3+0OmqvaAG6ccT6HOSMVk8MIGRfDGuHYYPFMiTWfnCzSF21TWmTnU74bXoy?=
 =?us-ascii?Q?pRiOA7eYXA3ua1mVerZ8Rbk2ECeMgy2pJLSInOgwE/44wQZDcyEVQsP+tKef?=
 =?us-ascii?Q?/d+PJlZFQdRjEXfuyQxfESvn8IhEBcNtUHiKUs5zmYyjbT4Du+ZVNmWGnzLi?=
 =?us-ascii?Q?bWtb7y3hzaaSOl8I+vovg54CXL3aMiCes5kDM1QfSoxTyzqFYux+Llyyjpoo?=
 =?us-ascii?Q?hbYq29wtl7BBzPQmGtSkOPpfNROt0h/CgUbZ6X18yIx8BIdpnz0Xf62psjUS?=
 =?us-ascii?Q?VlgE3ehySQAURcd16pmvWYra+t33e6x9u0bu8U/9gg8dB7pJFMgiBjk+4Qs0?=
 =?us-ascii?Q?1DBdJ896ejRPj16hNsciOWM2UQ9Q6XIbIbN5k0h4/fcumoIhxLhY/iSezwY2?=
 =?us-ascii?Q?YZ9J5M1R9jmty/vaILl4oK+V1GAsMSig/5FBfVCSS4ECNN0p4bEafZNGWItH?=
 =?us-ascii?Q?hpt80Eot4J7P06YAgxFOw06Odd8IJL/cTSlPGP+1vBDilPNTJh76d0LbV95d?=
 =?us-ascii?Q?ha2bP3ZnewXQqsA25HzTOPlvnOYmFab44t1zo92A4s42KqEU1RGqsw5Is/bX?=
 =?us-ascii?Q?rXhYwGj/R0AgBk/B9pecHyHkkbhcop016eJaO4FrLmZopVtH2nUWbvxynOv3?=
 =?us-ascii?Q?zXWvypSV1JOK5HihzEHVzq7+zchXdjhO9Ko8TlbE8wd6gBuXHHxM5jS4CpMg?=
 =?us-ascii?Q?PFT5iEEqNnzSQ5fD8DBX/usnnKg8gcCfXgchUxKgtMJIjTnGHUYif+jopETl?=
 =?us-ascii?Q?EGtaXHn3SqpLCCL3d6Cv7cwgdo6oz8uC5/mlg+H2Zy5QpO47eO6Jg1Ub5hVL?=
 =?us-ascii?Q?6e9Rs6kKRg+J2RX2fW2kkt07FUGHRaVuiJVm4Obw1nnssOkDRUnV8ZYiJN3C?=
 =?us-ascii?Q?+mGa/qnicjyAaRMcyWnKITDbK4zZ4TLaBQqtwZCF9/AgOEo4PyHyHw/vN+NJ?=
 =?us-ascii?Q?UyORq2VZbFxsBCeBSdX57D9iA2nk5LcGgBugQlCTzpyBGF1pebW+pjBUmSlw?=
 =?us-ascii?Q?K/sPV0aE6playafe/KmBmOTxddpbjNIASR+q4C6LMnarIS4jjfvluQ9WqNmy?=
 =?us-ascii?Q?8SvQ433wdGt5cfrz76AtVtdORsnHxlSE/OOjuw3JX9J60feLMaamNX4h5YNB?=
 =?us-ascii?Q?dmiNEaddu/yAsNuUDCz9+rfqcL3Ugn2q0QJbTJMo8d3N8K4lj4wsQuWyL4L3?=
 =?us-ascii?Q?Hcgd9fn19IZId2gloQEuKYfYEoHZoegFim2Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:29.8291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0f6d5e-f5af-4281-5b1f-08ddf754235a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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

Keeping waiting the userq fence infinitely until
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 790f51d2b8f2..9cdb82c13a34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -232,7 +232,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -240,11 +240,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

