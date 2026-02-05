Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A55EC1EB2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303C110E1D0;
	Thu,  5 Feb 2026 14:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="VNw+i+fA";
	dkim-atps=neutral
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290B610E796
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 02:16:21 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6150CFjX2399728; Thu, 5 Feb 2026 02:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=5VDfWN0aKWvcEd8kwa689xcG+rxiD
 oMXSJQKW39jbZ4=; b=VNw+i+fA4TGWduzctxbiPIwsuhFFIrpEywtkJyas2eupp
 st9gnWfPfKCTO5luNUxx+7pcpTMn3dyoUF66Lv0OQQ/4ywKGBzo7nZ9jdf8/rgbY
 LY7lhM34zd8SeQHDg6+km+eUsfQh+9AYOTA8hPnhiApzihXSR0ZqNJuUBcYP0Z7j
 cqEKVhc2IbKEUgZBZrBRdJOLXvq1pnmhJbCK41qhyEgQQbHFgkfF8hnbPq12HkpB
 4YaduFZB44dypD/SVMzyWMXpiSJ+vrj/r0MAA+VKe60cWaoRlR3XsaHULpEORVNd
 1NtgjU55wcj3SPY4lvvq3O0CmT6A612JiJccjwhDQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k5g2tye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Feb 2026 02:16:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 6150U2MX002290; Thu, 5 Feb 2026 02:16:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4c186puw7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Feb 2026 02:16:19 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6152GIiA017091;
 Thu, 5 Feb 2026 02:16:19 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com
 [10.129.136.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4c186puw75-1; Thu, 05 Feb 2026 02:16:18 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, pierre-eric.pelloux-prayer@amd.com
Cc: samasth.norway.ananda@oracle.com
Subject: [PATCH] drm/amdgpu: fix uninitialized variable in amdgpu_fill_buffer()
Date: Wed,  4 Feb 2026 18:16:17 -0800
Message-ID: <20260205021617.1279195-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=981
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050014
X-Authority-Analysis: v=2.4 cv=Jor8bc4C c=1 sm=1 tr=0 ts=6983fd74 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wGxCXQvqJJzLoLU4KEsA:9 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: xL7RO3p0HdQVVDdtd9GQ3q8LX40hsXlc
X-Proofpoint-GUID: xL7RO3p0HdQVVDdtd9GQ3q8LX40hsXlc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDAxNSBTYWx0ZWRfXwGCZ8QR3IEBJ
 aWLP/0OxcdbJU3hwcu8hI77ePmyduvPqDEGMfMQS+ADZMwhtwvq5wEn00i7WAnQ8Tx74tlmh4y5
 H3KCHrlW53s4ikB6ElzulQ2a09/5ndJoDCFG0HFxdcEISCX228PMSBOA90+4nMcsAxnmX4Mukpv
 CMd/K+cjsyz8KWh5exhKDzvm2tbDiGQx8OEabGj4E/9/6PSlqzjgBB/A84q/lbhDc/GQejcxEDz
 KOSLC5cKLthz+XcS3QSuRs9iI/XSyqO6MzT7pSvpRi2fliUjk/6srkyw9dU6rKvDrp7GHE93/xu
 hDtTmmXeGpk+Dq9eFtE2PclE0XCy0pSy+E1GRRgH+m0cVvyfUbgq2ZCOkHMnVwB1RnI9b8nSz3N
 Q/t6a/rUd7SMrxXMUhgOdCqi2N7iEnAVlf92uIh2lcD6VSeRiXHZbrTnJC6eMwcQ34Dv5cp4cJp
 uypuqBEvhDmTfJW9Rp4cJaRH4ALYyIGJxdSAPNqY=
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:01:18 +0000
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

Initialize 'r' to 0 so the function does not return an uninitialized
value when the while loop body is never entered. Current callers always
supply non-zero sized BOs so the loop always executes, but the function
itself does not enforce this and static analysis tools flag the
potential use.

Fixes: 22f7cc752408 ("drm/amdgpu: restructure amdgpu_fill_buffer v2")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 15d561e3d87f..44524eb2f74f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2564,7 +2564,7 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
-	int r;
+	int r = 0;
 
 	if (!adev->mman.buffer_funcs_enabled) {
 		dev_err(adev->dev,
-- 
2.50.1

