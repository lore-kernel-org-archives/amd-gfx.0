Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA6BCD6E45
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 13:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE79D10E7C9;
	Wed, 27 May 2026 13:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="PPBXPX2B";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B859210E7CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 13:19:46 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RCWPFw347100; Wed, 27 May 2026 13:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=AZfc/mFojlM/SSXLmb92fYcpdMRW
 XcILH9ptL5TH3uI=; b=PPBXPX2B5DS6EZSQfXneY1y9GhnZB0dbICPj+aYwpSPB
 F5lsnvXtMtoRSOr3TJgJpgsXdOU59IacAX6KUB77nH9AIYQ/srGDmvOV5APvqWmp
 EMXpfZyiHRFXlQ4W1/RHFMy5HucS7tTJJjM+opF2k5+Wd958PQOalYJuJ81c0BK+
 mpHM8u8KZyLzh0IkPMSz3tbntPgOtXb6FUar5dq2lSfLeU6pF73DLkh//c/qZGMT
 9awqJSbvHxHJf14nwdmbCeFZkMsaEjvEOCV/jwDrAjE/71cCMenGaviUK4B7zKF6
 Gkp+D8cE0buFQgkhNWvoQCmWZCNn7M+wZcvDG808Hg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nusj5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 13:19:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RD958G020063;
 Wed, 27 May 2026 13:19:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb34jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 13:19:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64RDJduO38207848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2026 13:19:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5894820043;
 Wed, 27 May 2026 13:19:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7A782004B;
 Wed, 27 May 2026 13:19:34 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.20.122]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 May 2026 13:19:34 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com,
 timur.kristof@gmail.com
Subject: [PATCH v3] drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K
 page size systems
Date: Wed, 27 May 2026 18:49:31 +0530
Message-ID: <20260527131931.1133797-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEyOCBTYWx0ZWRfX2ZFn0tgfo/WM
 N3Z1ECGsjQuttGhdy1+gqQcmhpVkFrJlX64inttc89HjyPJ+X2r45At9+gL3KZSbanpdkl84vot
 YlJBHErg0gMGjN8JM+sUtu8UCq6Lqp1zja8gDX/Pi3jPLFPwU3sE/SYt6R6IAawpNpC1bAdNlAh
 Vx0uLWicTR/0FWbzF9+Ot1A3/1SSXVnHpDNAegBXUq5MdOitZDsGGzwbOTDs6LNvWaW3bDIk9wz
 LtsRj6G+QABDEML+ptz21XdJ8XS5OBxj33i2dJmtYrPpE/GZ/dr44BKM48znGQygRFwFM3vJnci
 8N664KXOTfU7X0So7yTrBevVZgOPp/QVFqx3v0/+c6fgFQXnLQD1WeQ7iGz5IRwqnf//z3FdcBz
 RoShUZB8oBUGvQypPq9JHdljHxgYK9gMxjEI1AmaSPCwy5RQ327ppxdQvsrMvI3fgNr3sOZR9n8
 yj5+FqtqToSxGe/vbyg==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a16ef70 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=n88roBbitPJnb_ZC6A4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5hkIu7zkNRhf9nZ-um0u2-D8-9ls-am1
X-Proofpoint-GUID: XdiAUGYEdS5TWyXM7Jm8U-EbWwyVWU7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270128
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

When mapping VRAM pages into the GART page table,
amdgpu_gart_map_vram_range() assumes that the system page size is the
same as the GPU page size.

On systems with non-4K page sizes, multiple GPU pages can exist within
a single CPU page. As a result, the mappings are created incorrectly
because fewer page table entries are programmed than required.

Fix this by programming the mappings correctly for non-4K page size
systems.

Fixes: 237d623ae659 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2)")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
v2 -> v3
- Addressed Christian's review comments and added the Reviewed-by tag.

v2 - https://lore.kernel.org/all/20260527111750.1084088-1-donettom@linux.ibm.com/
v1 - https://lore.kernel.org/all/20260522112838.1311531-1-donettom@linux.ibm.com/
---
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index b6f849d51c2e..c4c21dbbbdbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -394,7 +394,8 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 				uint64_t start_page, uint64_t num_pages,
 				uint64_t flags, void *dst)
 {
-	u32 i, idx;
+	u32 i, j, t, idx;
+	u64 page_base;
 
 	/* The SYSTEM flag indicates the pages aren't in VRAM. */
 	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
@@ -402,9 +403,12 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return;
 
-	for (i = 0; i < num_pages; ++i) {
-		amdgpu_gmc_set_pte_pde(adev, dst,
-			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
+	page_base = pa;
+	for (i = 0, t = 0; i < num_pages; i++) {
+		for (j = 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++) {
+			amdgpu_gmc_set_pte_pde(adev, dst, start_page + t, page_base, flags);
+			page_base += AMDGPU_GPU_PAGE_SIZE;
+		}
 	}
 
 	drm_dev_exit(idx);
-- 
2.52.0

