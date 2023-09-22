Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39021CE7A86
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 21:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739B410E71A;
	Fri, 22 Sep 2023 21:38:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F73D10E102
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 21:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYWRpUQtUQ3gPxhG4xB4oZdztbOwlOB0uRVdWP/AQ/2jU/kZpDDpPOja9DAUIBwCkSGRQl3uD7j6HGgMtM0MxKtZuLszbVd6HKtbK7E+d8y7wNRtnGnTpZa6WsvIaQHYg3D3TQppW4KPjOdCgbKSl8PlINpwDlB/I0W3stwiaE/m4bdqEWxCo5qsvteF6UMtc6NqEJ71c325gW0sFnza6/qVyYEObiW6Kd7/x2/btEG2dDNndxiyXJlUYkHc9AClSOheoWmUV0AKDqicVv92VNcCGhU2Y22D0dBlHdUurTeRno2QdL/TAxqR7TQrLwpTlgbMO/TZjUfJx5ieMfyMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO4VURsWwnr/Z3wGno3Z2avUv3gNmzQmaaqkw24gpKY=;
 b=WqCQV67kjzo7ts3FVxIv0Df1h4NHdLzjIj6RPG8x+2n6ym+t6y9DlGL/DBP5Uv4v0gRuU529BjiZjwbAIkMwVljHA/z9em14OUJHTv0ZIzU2JtK/2DDhrbT2/c6VqUMwb0vEUn40aoNIjp8Mqw6Kx8M3hhd0haUitz/VGlNmt3UXcOWEU1Da39y9AZhnOqcnlBqRnlW8Tt3Ksx7IiW+fodG1T8Y5lb5azRXr93pBx1mJr+1/uVdLlORegGieZkeU/wEm3csA5JEpqSS5P2s8FAZlAwmqFgwNlv0Q1ccOnvlXboye1A5iG1uabfS8HtcXQZwvQdx+tsv+ZB83UgPBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO4VURsWwnr/Z3wGno3Z2avUv3gNmzQmaaqkw24gpKY=;
 b=moJseoSBtLGVDxHQ9Gn/7jrQaGmilmLWUG12CryWOmtk4F5LzdLcuAsFGRz7CxtazkGY1ttKDOZ9LqTf3XUgtY9bhemmk9dxYHjBn+vOEdSK5HGS2tgc7OOyGnGes2bcICpLdv5LriGMVeWa9yjU9v1tN56AItKFpJucyai2vlg=
Received: from DM6PR13CA0060.namprd13.prod.outlook.com (2603:10b6:5:134::37)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 21:38:46 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::93) by DM6PR13CA0060.outlook.office365.com
 (2603:10b6:5:134::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11 via Frontend
 Transport; Fri, 22 Sep 2023 21:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 21:38:46 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 16:38:45 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Wait vm update fence after retry fault recovered
Date: Fri, 22 Sep 2023 17:37:59 -0400
Message-ID: <20230922213759.20904-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a215aab-fdea-4232-32e6-08dbbbb44d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlMH+vQqbzycewiqm66rpRf2tddIwR6wE/lmfKJPk/3dJ310IP7K76IutQ03HktNElEruF1i2dFsqBqac31xvl4ddI3qvl8h5hhBR4w/RTxKYkb+gxci6GD9nwe4Ca0WVnSiMnyvwXHKvMmy2mDVx4V/ibtPuEG9iC8AyIp2Xoitf5tXHn5HiWnoy63ZfkU21+GehBcSv0Dq/hdSnPxT0T1uVwTOo+gpLvTwn5DkYSxBasku07cv1oOjqq68y0MsmEG+JGx+YVKstlQ5gapVtvhIEea2FTUKPt+pM/MF6n/7g2pVhxL64bsm9OAHPp02t+P8H9Qfza7RUCvXyJww1uztWcu1VpjJYh/WMyjFT7BHJG83pr+sGsfn2l4oowz8pZM08ElEQW3xSqItrUFy4/8PnJT665qJDWqwbv8lDZ6QgsNEvAQNsJIOvcXDLCJ8dZfKhpw86xIaKDMpwtbBC49Kx3ebxHU7oYhp65g/MNfYydB5xOAsaUS8X1KuGJ63v6jE4gV4PH+c10663OXz/opeys2YfWt3qE/o5GXsYUj1pxxVyD8jGN7nHtB9cZM2IlRQ/T+Jua1rbPAodgcW4zHHFZz99+p5imm931FpsL3ALNkrXQZqGcSccJZlYS/YmkMbOv80zvYJnwiwP5grzzzyxJb1RiAGQNiufB1XjnrLwFSTw9mc/Hsiv900rJbimq6R2NET8WSoOG7xW1XfYYSv42cxOEih34HVlUcceoXNRrqtH/5YC23yLQXZav55FNoU3JvIk8i6RSe4eml/Kjhmza1wwYO/TTYSaa0WRvD8Aso/vyyj3sNDW5V/UDkP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(186009)(230921699003)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(8676002)(8936002)(4326008)(5660300002)(40460700003)(15650500001)(36860700001)(316002)(26005)(83380400001)(7696005)(40480700001)(6916009)(70206006)(70586007)(16526019)(54906003)(82740400003)(81166007)(356005)(6666004)(41300700001)(336012)(1076003)(86362001)(426003)(47076005)(36756003)(478600001)(2906002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 21:38:46.4280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a215aab-fdea-4232-32e6-08dbbbb44d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise kfd flush tlb does nothing if vm update fence callback doesn't
update vm->tlb_seq. H/W will generate retry fault again.

This works now because retry fault keep coming, recover will update page
table again after AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING timeout and flush
tlb.

Remove wait parameter in svm_range_validate_and_map because it is
always called with true.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 70aa882636ab..61f4de1633a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1447,7 +1447,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 static int
 svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		      unsigned long npages, bool readonly,
-		      unsigned long *bitmap, bool wait, bool flush_tlb)
+		      unsigned long *bitmap, bool flush_tlb)
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev = NULL;
@@ -1480,8 +1480,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
-					 bo_adev, wait ? &fence : NULL,
-					 flush_tlb);
+					 bo_adev, &fence, flush_tlb);
 		if (r)
 			break;
 
@@ -1605,7 +1604,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
 				      struct svm_range *prange, int32_t gpuidx,
-				      bool intr, bool wait, bool flush_tlb)
+				      bool intr, bool flush_tlb)
 {
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
@@ -1729,7 +1728,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		if (!r)
 			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-						  ctx->bitmap, wait, flush_tlb);
+						  ctx->bitmap, flush_tlb);
 
 		if (!r && next == end)
 			prange->mapped_to_gpu = true;
@@ -1823,7 +1822,7 @@ static void svm_range_restore_work(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+					       false, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -3064,7 +3063,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
+	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
@@ -3603,7 +3602,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       true, true, flush_tlb);
+					       true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
 
-- 
2.35.1

