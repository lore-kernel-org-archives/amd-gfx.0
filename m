Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6100CA0FED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Aug 2024 13:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B40B10E077;
	Fri, 30 Aug 2024 13:04:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60AD210E844;
 Fri, 30 Aug 2024 07:48:12 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ww9Gs1Fq9zyQQt;
 Fri, 30 Aug 2024 15:47:33 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
 by mail.maildlp.com (Postfix) with ESMTPS id 92D00140360;
 Fri, 30 Aug 2024 15:48:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 15:48:05 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <chaitanya.dhere@amd.com>, <jun.lei@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <lihongbo22@huawei.com>
Subject: [PATCH -next] drm/amd/display: Use swap() to improve code
Date: Fri, 30 Aug 2024 15:56:16 +0800
Message-ID: <20240830075616.3541445-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-Mailman-Approved-At: Fri, 30 Aug 2024 13:04:03 +0000
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

Use the swap() macro to simplify the code and improve its
readability.

The target code segment uses the bubble sort, we can use
this macro to simplify the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 6eccf0241d85..07e9133e8d6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -452,7 +452,6 @@ static void sort_pipes_for_splitting(struct dc_plane_pipe_pool *pipes)
 {
 	bool sorted, swapped;
 	unsigned int cur_index;
-	unsigned int temp;
 	int odm_slice_index;
 
 	for (odm_slice_index = 0; odm_slice_index < pipes->num_pipes_assigned_to_plane_for_odm_combine; odm_slice_index++) {
@@ -468,9 +467,7 @@ static void sort_pipes_for_splitting(struct dc_plane_pipe_pool *pipes)
 		swapped = false;
 		while (!sorted) {
 			if (pipes->pipes_assigned_to_plane[odm_slice_index][cur_index] > pipes->pipes_assigned_to_plane[odm_slice_index][cur_index + 1]) {
-				temp = pipes->pipes_assigned_to_plane[odm_slice_index][cur_index];
-				pipes->pipes_assigned_to_plane[odm_slice_index][cur_index] = pipes->pipes_assigned_to_plane[odm_slice_index][cur_index + 1];
-				pipes->pipes_assigned_to_plane[odm_slice_index][cur_index + 1] = temp;
+				swap(pipes->pipes_assigned_to_plane[odm_slice_index][cur_index], pipes->pipes_assigned_to_plane[odm_slice_index][cur_index + 1]);
 
 				swapped = true;
 			}
-- 
2.34.1

