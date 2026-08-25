Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD15C5DF94
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 08:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B0D10E966;
	Tue, 25 Aug 2026 08:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBFhRZ0+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91AB210E966
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 08:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZBHIP8KwParnAbFAjENRhz3Jpos3Oe1RB4tlrC36NBTDpxb8VZJp6fvgFv0dKBENqBHUtOiAOwfcKbKunbrIsb9l9DN1bhrWEjfAYBy7JL4YZ5TyOkskfapalSpGxUuLwnydgAUcqtg9mxucTGDOfO3y487hTxiujM5FXqapOxoM1Ev4we6pZwONm/lbHDIgXek5JMWa1t1FQ2OuYwosnRrDj903E9fDImRKEBBYYdnayRzd0FSYpNh+EwK1BO0D7ADQdfbzXFbb8osfQYPLmKatBUseDfmkkYGuya07b17vljVbkHkKHca86zOcAulz/y2aCq0Q6qluH4pz00fdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdm6XmvR6WzgNzPyV94+/uxj5H155NVdYHr+IhdZKfs=;
 b=gV8pvGFkzoJRDz3XNWuQ2RvsRfwGW+eVIEQ8D1xfsJKsvfoG3PyQWN8pQKOTftMotLnbbaXJtbyFwnPfR7r1jlCOmPvmW3ylvU3pkVRAsW7otPKtg5knyQnw1lpTGIz4olDf28SHFfU8y5UY5THRIJH8aLztT02KLsqDV/bZQ8IcLAG9K98X4795JD3mD5ATaLs5tO+VkzGy5V19Ol0rhOWvcH3bRVREEmGsFcfsS+zKTb8oV+rrnUvky0HN8KHHIVfqlPXLfS7Dh7jhQXCmyvNyT8PMYvyc1pkqyLiVnA5ZK6mhBF7rlFTXJ+ZNZXGxGXb6XB1kXXA1K0slPVKkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdm6XmvR6WzgNzPyV94+/uxj5H155NVdYHr+IhdZKfs=;
 b=zBFhRZ0+gsJOyFfDJCKYstGGgJjYa3mCF5cmBKa/SG0/Cyyw8lSQiu28B3lhmxAo2iEe1kcsdhsGmCTY0eDeY9c1x3gcnyB1Uy56dFdYdAN832cJ0uGnw465pmrvyaQjPLEGo61gFRpvgVCI6uEPYucsx7QeoCyIP9qre2PThBE=
Received: from CH2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:610:4f::38)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:15:43 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::2f) by CH2PR18CA0028.outlook.office365.com
 (2603:10b6:610:4f::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 08:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 08:15:42 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 03:15:39 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: use hyphens in TLB fence driver and timeline names
Date: Tue, 25 Aug 2026 16:15:28 +0800
Message-ID: <20260825081528.496730-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb80d19-37c7-4f1f-c924-08df02810e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: fsG62I6xZ6UEWEDcAcHy2mykCiaezdR8b26cTMaZ6lji9blciNBcdT6NgV08X0HSRCn73TwwXE/HAg5g1AcZpnzz7k+VVa0kZjgE1nmIg7lAltdwwmrGDMA3+k/Nb+fLDDJ1PyY8nB0K7dzT06z6R2iWQng0+nyq2Wx9DHWIw738QkeXEdEH4iCt/N8S1jOoI6LYkLvRdNyn+GduSqwe3aA6ju/5impp/SK45AMNJlXuPFqOBCFFJQMhCfOkNDFPKvlRktXWq1fSEDigVr3jjVzJ7RPODsQpJ/6yGN/4xL0haa0Lno2OawF+A6spZp1zQEBPzJRpnLBIoJCoWn+IqPfbXF89mKex6LmFdQryVALyvf6vfuTe61r8boJezI6Nqvq2SbyRaDR5vLKl7Argeq6zqAPyN/xRwLP0qLMKOmpDiCiQ+iD9rDEl7gKDrrdMfs1jbVB0CXvhGf6x9Lg9LMlE0ImoZzK0Oh8UiG2pnh87l2rvFmunp++xNlL/ES/98jRRiBbJUbMLWRGC97DYS49iZUJ/TKRjlXl0lOSWXTokDHEF3Uthz9OMEWaScnQHsQS6jlHwHQvNHxxZvLlgw6UtJlW3TLXjbIsdlGk3HLSpPvEA+Dk9mDZotZvMVR1cEOLiRkE9FdWp0vyyTyDCB/zZu2BxQKKJEYzA6gRPzCj9XNB1k4NU6T8sbVFPPyEUBeBKBtbGGd3iQ+rsRJ5xWw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pknVIMkVm7PGn0sTrG0fHYNjNkRZOgDE/76KAdO6kvF41sGoAYptbpM3tRXQqbyQbl3holeuy2/R79/w8A0OPXsRKTJP1QSzqFB5G5guKsmjtDETmc6imHXk6rZF4H7il3X3WhEglPsk4bU1uv73yf0M799hcdN8yORuhJ2N3CyPJGESCWbUn3uHTZ/lIIb5XT9xt8zyKX+le3APy3/F/wQdKSbWB6XmFLtTuqzw8RNkP5YV7EHGj0hpY90ChpqRspcsZlWYaXVxAUyrK0VFsZ8yPIA3+2fX/dfUEBiDxRmYkGnx6hI+Efq4ylTGdu/CFPz8lS2fctoNQW6X/1qFX0oclfjhK34vYE1IpRVscR8CE4YQOy0To/Cq8u9sPJDCdc9umfWKuP9ZE4N7EOtj1IX/zjKhJhisN8NM83amswwa0RMqeshVvZOYwx3DNUUy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:15:42.6426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb80d19-37c7-4f1f-c924-08df02810e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
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

Replace spaces with hyphens in amdgpu_tlb_fence_get_driver_name() and
amdgpu_tlb_fence_get_timeline_name(). Returning string literals with
spaces makes ftrace fence events and debugfs fence entries visually
ambiguous and harder to parse using standard log analysis tools.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index 82b8badde453..b0002c898386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -40,12 +40,12 @@ struct amdgpu_tlb_fence {
 
 static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
 {
-	return "amdgpu tlb fence";
+	return "amdgpu_tlb_fence";
 }
 
 static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
 {
-	return "amdgpu tlb timeline";
+	return "amdgpu_tlb_timeline";
 }
 
 static void amdgpu_tlb_fence_work(struct work_struct *work)
-- 
2.34.1

