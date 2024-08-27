Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39692C54734
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 13:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C585910E31A;
	Tue, 27 Aug 2024 13:21:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5hfypWPX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5931110E31A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 13:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvYLVjc+zjD++oXkfOlfggFhyvK8uOkvD8/FA0KiyyoNaP2ozDZY1wjk6UgbHEcw2Yo9N1lDHBGDrZxsfFXx1rkDmFxYfIYTkhbn54/9+xgHDe3htJ0vILbHI5gP+rS4X0p+dEpeV21zDpJZWVFv+xluK/J8pXN24p1P/OTOegNughqhZoOu5ZaxF8zU3B7JGC+sgrC7KNEw1iOLbpVmiWkQigWrkp3AdRqrHxD93mnTclc/4WYi+QjQSTTOipiy1weuLoOxqFeRpRt0p+JUh86MHBHtxohVQ3LEMxm5I7x3V5pT5HWd0yks7pzZhMvCFZqyfDUAKV7kEmN/3nVSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS7MtbVCYzELDRilqXMWAbUngL3vGfpbuGLNkzNYwjY=;
 b=SCiCJLFw+ehul5PPaO+r6StBjAhApCOq1l9ffmSQyEtZENBCXovCx7NcZL8uihItpKw3je+99Z72HLyh46JXogyPcLtDxS2IGtfRBMD48ISReY6D+VofP8vdceXnxfSV9BoJ8Y29mC+pGkUAYYQBePx0RVCnLRF3CwcodX4bwcvQNayozBFyY6ZaJ1M4xgbrn7p+oIvEfebfA/ZY0lSqCsB1hc5mYdNe7iQpCss3Gz1UIzNfgB5TaeiPd9XidmaNDiLS9sb6rgN34NtYh1QE1KT7KR+XomfbdWr9MHJu+xOtAnFmKycXMp2gbexf5ptrEnivhDypu03wMKZz5llvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS7MtbVCYzELDRilqXMWAbUngL3vGfpbuGLNkzNYwjY=;
 b=5hfypWPXKan61ZJ3FAUtkwvRhVCc1p4sjqnZsNJG2BrNHVdWF85LZhGYM6rIQJnJe/SvZixKm3Ae7jGxpQqYvcUeko7GJm+3zdkpxGD567TJddns79Hj/KGGsEpnuy0F6mSVnIQINjmJonjEyzKA3lbQcHLMqmTLRmYfnQwLGjI=
Received: from CH3P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::15)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Tue, 27 Aug
 2024 13:21:45 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::3) by CH3P221CA0010.outlook.office365.com
 (2603:10b6:610:1e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 13:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 13:21:44 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 08:21:41 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdkfd: Don't drain ih1 for APU
Date: Tue, 27 Aug 2024 21:21:20 +0800
Message-ID: <20240827132120.62204-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 73060405-46dc-40d0-7549-08dcc69b327a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K7E7l6/tiYvEe6Flj7S5FYzhU8okF9Mg/DdtC80kvtu3LnJXusRH3mcen9+1?=
 =?us-ascii?Q?5mqcCfgn5wGUrz5yoKIMEriLDfAr4Gbf8Kal/BPRvEJqaIlzdIxmyEg35xZU?=
 =?us-ascii?Q?70XTirZolTQyJsFWTLFvmBmV58wZHJIUjBLuynKiayTNK8OdaUhIwozC/Aou?=
 =?us-ascii?Q?QzMJkB5f3GcxqqMN7vR9w7glNuNInpK2V4gHjg4ZzXQQko+XCvynqdiXJYBV?=
 =?us-ascii?Q?nuvNVW1AI9YfFPbqAcN6Oa4CQE63WxXGsLY8Ypg1/Y5p4PRA/iIsOeiuHBLG?=
 =?us-ascii?Q?BMNOoH6kFwCvf6mx8gMgejdPozAghovjhLl7b7JXLSk9Dab79X8/5cjieFQ+?=
 =?us-ascii?Q?tLc+4IzRwBGdzhDWFeTrE6kCkMa+OzggtTOHnk6v8qBi/s45OxgCLEUkfokW?=
 =?us-ascii?Q?D7CXlFqswD4Uv842CbG8CwB7cf5EH/IMYzjMcYMkrVr8fB7mE5dEELgH/3D7?=
 =?us-ascii?Q?6cVS40Vn3Kky3BrPrlgSgOJ34E3WAnAT7oPxiLirzE86gS11B9Lpv12EijpP?=
 =?us-ascii?Q?2RILp98NogFAmpdhGWR58pp3qKM4JskQ+x7mF8huWL7g4pDDbKLkMUGGm6fd?=
 =?us-ascii?Q?7SrJHzQJ8o9pGT3SqlBr6+GhsZ05ooeEHq1yQiCEcxnMhdp4JTk8F31JLbcc?=
 =?us-ascii?Q?iCDnW/E9RhR26rbpGiL/m21UqeVivzYD95+jmZkq2r/dyTvjGWRFA9vvtl2x?=
 =?us-ascii?Q?5ozy/N69pqai+G6FkTAoqs/MX/Yd/AfFGLzhtZMQx4r4gccptlHTslY1Muov?=
 =?us-ascii?Q?2zhwctbrnE2Ho7ZXNGp6jNhsCDAgjQeKwwPj35VeVkvMYCaPWRhYDa91iPAi?=
 =?us-ascii?Q?v5qG8/kMRm05ATl8Rsp31yZXIoNFLWfClyqqAV8yekpSU3wTKchpebDiYmrk?=
 =?us-ascii?Q?ASlb4qYQyp5fXjoaJ/JubAgcqYhEHtMr2rLmQM9SiEfluzsUa3RNDm04C76Z?=
 =?us-ascii?Q?wkwir5SJuHaZ1XDhesI1W6dfSuHj+q56ZilHS6YWncbW6sJ22cedwJTOL2mG?=
 =?us-ascii?Q?fTF4CWQ5kCQrDj+ku9IGIw14E1LZHAKXV4pgRnlQXldbxOG1aOtkOTv8oPtV?=
 =?us-ascii?Q?ywO1ha0lsoYDFTvHlA/Ml4g1QwCkcdKDyAzSILWAn3OCg3tMRNlBYd8Yz819?=
 =?us-ascii?Q?aSCEvkZWjG2+FdGh9AHCrRTsGaMHXu3yXQJtiR/syt5+5FU8X6IDemK3hEv+?=
 =?us-ascii?Q?sV0zFmQTydd0zL8f1EfbLP+whPZ1h0RisUyOso575cfRrQpwMyPT3ULUlJm8?=
 =?us-ascii?Q?pDtNZG6wVVLXUnEqlY8gC9ZwerZqfi0S5tvmHsSdYW/yOU1B+9e18uigsktC?=
 =?us-ascii?Q?XALt5FS6B00L/pNvyetxdh8u1iE3klifSwyJu88LBniIXAcJtzNsRVIBBPvy?=
 =?us-ascii?Q?Iy259OLAeRvpRpRI8TCRlRjDSGcj5fCFQYpqlL18D6lET2a70ljg4uqUd+sR?=
 =?us-ascii?Q?d+8WTQmPpssx7c02Le6/+rmLFbDH3CSL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:21:44.6697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73060405-46dc-40d0-7549-08dcc69b327a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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

ih1 is not initialized for APUs. Don't drain it or NULL pointer
error will be triggered.

Fixes: 490fc21fe97c (drm/amdkfd: Change kfd/svm page fault drain handling)
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b44dec90969f..512cbf9403a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2458,11 +2458,13 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		adev = pdd->dev->adev;
 
 		/* Check and drain ih1 ring if cam not available */
-		ih = &adev->irq.ih1;
-		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-		if (ih->rptr != checkpoint_wptr) {
-			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
-			continue;
+		if (adev->irq.ih1.ring_size) {
+			ih = &adev->irq.ih1;
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			if (ih->rptr != checkpoint_wptr) {
+				svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+				continue;
+			}
 		}
 
 		/* check if dev->irq.ih_soft is not empty */
-- 
2.37.3

