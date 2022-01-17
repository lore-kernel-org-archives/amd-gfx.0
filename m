Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C37C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 23:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4461B112605;
	Mon, 17 Jan 2022 23:44:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DAB112605
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 23:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGtMUAidsXf8S1HPhA8yacU171rxhu9glZwB/1WyPZDyp7iIQme8wTnHntRn4nvHcSqnnAuL4MvmaR8p9OJpGVAX3Tct1oOHtvkpQw6JvGkuRfJkGB2RkcbL1XAIljVok6ddEi6dgH0ObgNRp1dtxlkjyRk3b3DAw+hoLnSh+qZgFNWGPcqjNwn+0irQbGoVbFPBVwIm7P7QRm+8sw6/V5lQkaVBdBTI0Sn4eBeKuTo7oNxpuzkb3tR1dyKZyMCMlQL1uBMMgqc29DksxXp0z11JB4+d4ISYW4SAK1ZJMB/RfWEW1jkjLYXRxtGKQzSo92p4zDU65jat7sx0kkdAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDMRZV4jESkgCwPrxMpwKui+fCZ+KCGWJSN0w5oYcZU=;
 b=axHiuNJF0mx2sxl49R9zLOJkplZwNdi/Llk7gheeCmCReOG0C3Rd70R3wY7IZZ2mzNXJsT/462csMbRnJ8K+BsuT+NuRPw+j0DdKlg1z8O85zmdu4oLP29VzRdRdczbLcsReeRnFn9mE//nMs1r+pJTSSzSuKbPpPWhsuVqxPN39UQp0CErgeNErlWq3hgv0d8fWINne7oPnLLPJIzdJZCAHWPRuHzuVJxFx6z+LrWIr+eNxgv9nn0/clF1lL4eHlxdugH/rvkEZCYT6KlujsrpZungEvGinpYMvOOe/e52oLYq0rDGeeKIobJZInNE29dFrhWiJgTldL3NRmQ1I5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDMRZV4jESkgCwPrxMpwKui+fCZ+KCGWJSN0w5oYcZU=;
 b=nb9HTrDrItfah/ZXqW4fvpnGKMFGf8a9SD+comsYNBOl3y3//dsRzVJbLMG1HX8yxYKAmDXA1L/hGpTmWB2UJzFLJ2lZONt/5fig5eB4/bjJHVVSNQzteaAO3vCriREduLYCBnE6raCZh7hramJQPfPlY1ghhLR5EWwmtP7HOqY=
Received: from DM3PR12CA0122.namprd12.prod.outlook.com (2603:10b6:0:51::18) by
 SN6PR12MB2735.namprd12.prod.outlook.com (2603:10b6:805:69::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Mon, 17 Jan 2022 23:44:00 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::66) by DM3PR12CA0122.outlook.office365.com
 (2603:10b6:0:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 23:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 23:43:59 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 17:43:58 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix debug sdma vram access checks
Date: Mon, 17 Jan 2022 18:43:47 -0500
Message-ID: <20220117234347.3820493-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 131f8d00-53a3-46af-5802-08d9da133bfc
X-MS-TrafficTypeDiagnostic: SN6PR12MB2735:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB273542231EDF373AFF59DA9885579@SN6PR12MB2735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1miSB8BlsGfz2Fjugxn9/r4hHLuoCfMg4A476VDwHzQasIeUAbsHDaHtQqiToAaDAwkWstrEPBEkNQcOej9lMbAl+e9ag1vnBbE7nwHpvb+rpnu70He3+AlkQbWku2vzBOYh0KHXog5RTDqFpmx1OkfrwYNHjrw9CKV+5tDpVoG0Ibx6Uh1jej91xXKrQZXVgMdZ+CNXM4tlDdbrqv2TlHhw0WOwpb2UujRnyHWfaqynlQ9yVHkGJHO7xzpVu9hLBaTyH3hQ6fwXyzbUFLMc2slrcj9LhSd1iXgr7qQNNiyPLAjO1Q5uNOpr4YYCnUU1DLdJh2yra6Vt47bonkjoqGduKpAhS/ZvVzk01ilisgDAIPeI2NwJQVzWuAzclQuNEejghyaJcLbI3P8U5bmSrpzkiKqtRuvgQPFsLa18f9FW46JQaWCpoBKQRHH+Xv0x1J5dOIBm0RJly/Da3zBrnEh5LQhIeFnLXZilMQHn0XkF7lrn48Y1tzdxVXwkGQpb0FqWlWBMoPHnfQYAZxkcoJWBXudgONOdRfW1/07pyykxeWWV9n5cv5vgvk/IPhO4hhQFBoAD+Nou2daaLvGDYFDN80E3dtPKY/AJZrI9iOAFOhUsG/iVXd9gThaMVUP9iRoLifiD113+X5F1V21+d9X7J+7AcZo6PT5ieEleGCt/qABJjR0FHnKNK4C+uLKEu+Pe5S1Hx+JTZtYso2xgGF7vMCjpdNlfJCkAkG+pOlU/n9pAskIMh1MSjkq6A0y9ueTarsboXtB1dRnBBAjVDUhtFmSroWaZlIwXdeWmd2M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(508600001)(6916009)(86362001)(36756003)(2906002)(8936002)(8676002)(47076005)(316002)(83380400001)(81166007)(356005)(54906003)(7696005)(4326008)(36860700001)(1076003)(70206006)(40460700001)(26005)(2616005)(336012)(16526019)(426003)(186003)(44832011)(5660300002)(70586007)(82310400004)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:43:59.4325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131f8d00-53a3-46af-5802-08d9da133bfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_dev_enter returns true when accessiable so correct the error check.

Source VRAM buffer is reserved by TTM but not pinned so the gpu offset
fetch throws a warning.  Get the gpu offset without a check and then
double check to make sure the source buffer hasn't fallen into a hole.
Otherwise use MMIO access to deal with non-contiguous VRAM cases as
usual.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6178ae7ba624..0acfd872bfef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1440,6 +1440,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	struct dma_fence *fence;
 	uint64_t src_addr, dst_addr;
 	unsigned int num_dw;
+	bool vram_is_contiguous;
 	int r, idx;
 
 	if (len != PAGE_SIZE)
@@ -1448,9 +1449,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (!adev->mman.sdma_access_ptr)
 		return -EACCES;
 
-	r = drm_dev_enter(adev_to_drm(adev), &idx);
-	if (r)
-		return r;
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return -ENODEV;
 
 	if (write)
 		memcpy(adev->mman.sdma_access_ptr, buf, len);
@@ -1460,7 +1460,18 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (r)
 		goto out;
 
-	src_addr = amdgpu_bo_gpu_offset(abo);
+	src_addr = amdgpu_bo_gpu_offset_no_check(abo);
+	vram_is_contiguous = (adev->gmc.real_vram_size - 1 ==
+				adev->gmc.vram_end - adev->gmc.vram_start) &&
+				src_addr >= adev->gmc.vram_start &&
+				src_addr + len <= adev->gmc.vram_end;
+
+	if (!vram_is_contiguous) {
+		amdgpu_job_free(job);
+		r = -EACCES;
+		goto out;
+	}
+
 	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
 	if (write)
 		swap(src_addr, dst_addr);
-- 
2.25.1

