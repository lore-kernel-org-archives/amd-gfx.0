Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57714C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE97B10E542;
	Wed, 10 May 2023 21:24:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 113AE10E53F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnGuTCYDsXO98TIvscfgWRPuOwQgVamJRy8FFJ984nc05gyOPuh2ToPSfUhjjq4Wh6c5spGlWuHJFnyv8N7C/bPK6KkkIlR1jBd5ASrrGkUumtv8pOy3rwxzaD5C9M+xxnb3+ufTPELvsLznpOfX1x7UxIDWGv/Xy9APefX+uFlYIDJD8llPFIZSpVPAyvqBs0aMOhStn5HqC2Lky2dCLHFA9gqnll4wG0YTDfLcnit0Rhu1eoqwB/t4K4zwxu0fce9kAT9DnxR32LSInmyCtTK9BSsTBFiSUhslAX/OLyC8JHBE+grgNF8xqh8Ih+XJCjCefPAl1dBAvBSY+rK+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43KQDsNwT8UP8r6ajWo5t6JaNgq6+UNoQffKIcAEqVY=;
 b=f9vammvqcI8xNJFgs/hjXog9jXYwd1noi1f9lIhYSZQ89gMXpgOiasWh7f1Xj2r7oh+NSX35aA66PD/wiaVnq9xzeZG4JoFaMI1ItMw5lfuhDUZc4VDlxC2oMOCaSXDdbJnQ510e6T0iCALd80UCz4KU8LjOn2V6PXEhPKuXihIFPkF+0VJYgJe8pdq3YILP0hOJQxAgaMmHwrWkWrVUIjEaIOxIVjGWv81Ao1icMyhKgn04+OxrIuLdze7lB9bB0e5bjb8prM2Vgo6wRUV1wLzDnNh8NBt0deMzwD//hshve+nbrZ/oNBOmg3F/99h2W2Qh6MhuSq/A1U+KMjaF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43KQDsNwT8UP8r6ajWo5t6JaNgq6+UNoQffKIcAEqVY=;
 b=Nmitj1aEIBswdgkrGh/IUdjB5Zdda+4zxZzt7rls0oLe9pACB6tSPmoMKStGjDPpcARAo+XABPCqldytizQ014RmeZ274STlOzyM5IZqHcwC7DJs4Vb8o3JFisrzXdbgmX6EZ0QGH35noH8SeNlncCKyiV1ZxfFGs7KR1Il1zfg=
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:24:00 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a::4) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/29] drm/amdgpu: dGPU mode placement support memory partition
Date: Wed, 10 May 2023 17:23:21 -0400
Message-ID: <20230510212333.2071373-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2510ee9b-8e56-40ef-d037-08db519cdf07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ykYmDSF70dcnePLafSRqigAtw6BkCSlw0CJbBAnrMaKfGEMRLTjd/ope9RAC6eHLbesP33oyDNGJ8zEjlKOQBRyatbn3K9KRD0d61RBHVkMxVxe3j+T/Lp338c7K0lQPOTowZTWzfejEzUlvx5HRPuGQCWC0JQSfa2PoyQEGG54dKKnchk4uaZtqehB4uXyclLnwr+iyclfQAdVWB6yTQZFKScyufysBLKIL0XFroJxj8RCJrzRz1y4ja1l9IWAW0BwJlQZNhxVMlZ2TaTfHvUf0iFGocD4YVOtIHlgGGPWq5iIy4dssZvHFRJbActnI+rsybzKXsuDL4NPZD6mELVFDIlkhC9LlI2JiH6JP9bmXLbE79ee0eH07nFVEorpatz/+Rp2U8OiwYqa6tAy8zzGtnGXQa/npiKwMWb7HT+sNMU1WEqhfPs63F5ZvGVQMJCuruC5figGlbyXD+NJ3iSqmC00L+zq/G2cP7M/F3ab0MKyXX1I4uDQtxBOKPnSSgzG4j0v1oRZjejyaRfrjwU/Y3W3yV5cx0U7jnwh1AVgn4Qwv/Imqx9K+LxxuIVchP4Xdfi6LJCt7JeTRrVxRjOfbXyAVyJi9pIltUHj00j+HXIIkCU1lgbARYmk0gxonTGf963LrTwHQQWJd+R24iyYC269/EA9BSKvXbFEA1o+pQZXhfBIGBimN5XYKEegzVvn1QYeHivH4jDxWFKxjlJcwbPNqgsZNIXsGM1yPy4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(4326008)(316002)(6916009)(8936002)(40460700003)(5660300002)(2906002)(8676002)(41300700001)(40480700001)(36756003)(82310400005)(16526019)(1076003)(26005)(336012)(2616005)(6666004)(426003)(7696005)(186003)(47076005)(81166007)(83380400001)(82740400003)(356005)(36860700001)(54906003)(86362001)(70586007)(478600001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:59.9917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2510ee9b-8e56-40ef-d037-08db519cdf07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

dGPU mode uses VRAM manager to validate bo, amdgpu bo placement use the
mem_id  to get the allocation range first, last page frame number
from xcp manager, pass to drm buddy allocator as the allowed range.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 155b62971a33..cfa14b56c419 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -132,13 +132,18 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
 		unsigned visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
 
-		places[c].fpfn = 0;
-		places[c].lpfn = 0;
+		if (adev->gmc.mem_partitions && abo->mem_id >= 0) {
+			places[c].fpfn = adev->gmc.mem_partitions[abo->mem_id].range.fpfn;
+			places[c].lpfn = adev->gmc.mem_partitions[abo->mem_id].range.lpfn;
+		} else {
+			places[c].fpfn = 0;
+			places[c].lpfn = 0;
+		}
 		places[c].mem_type = TTM_PL_VRAM;
 		places[c].flags = 0;
 
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-			places[c].lpfn = visible_pfn;
+			places[c].lpfn = min_not_zero(places[c].lpfn, visible_pfn);
 		else if (adev->gmc.real_vram_size != adev->gmc.visible_vram_size)
 			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
 
-- 
2.40.1

