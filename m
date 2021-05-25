Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1669EC4707F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 12:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D7261408
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 12:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D7261408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA1B6EA07;
	Tue, 25 May 2021 12:47:28 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9506EA06;
 Tue, 25 May 2021 12:47:27 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PCdZng092275;
 Tue, 25 May 2021 12:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=0fsajLiKq3dAG0qs/eZDP0WUC0DG6tj2wIx7UTbk6ug=;
 b=luEooYaQm2gZWD1cQgsISLJxeae76NyOxubEbc/uR1pKnWq3Q9ZbMGNxE2vmZhUzQ/77
 edoHDh/U3461ghgsGLjklW+CgP4kjNC1aH/JSo/ii++DVQIgm/sKhDptBwC0doIyNu7P
 Ts4WmqOF084yy/RoJwRUm/0Qdw+HK5gj9DeJjdhz1PFxZKdZyL8u7291+vSwjbb0KMOD
 Lnx6+8wCaIP2fACBtlZ7O/znA0JShXsuWK4fZF0ichWqy/AVfoxXzZx4OebAMT1BT2c+
 IBwHooHzEtI7R9dBYRfbxOOMfh4qHLEoEJuaX4418+h4VIogdP6aaiI2boO4HofU1MUV RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 38q3q8wcxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 May 2021 12:47:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PCerbe064934;
 Tue, 25 May 2021 12:47:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 38reh9snkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 May 2021 12:47:18 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14PClHLx110318;
 Tue, 25 May 2021 12:47:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 38reh9snjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 May 2021 12:47:17 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14PClAbP000784;
 Tue, 25 May 2021 12:47:10 GMT
Received: from mwanda (/10.175.166.49) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 25 May 2021 12:47:10 +0000
Date: Tue, 25 May 2021 15:46:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add missing unreserve on error
Message-ID: <YKzxvyKEl/gNPg/r@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: mpE-O_OflR3KcX0cJ71_sicTnI4ZeKql
X-Proofpoint-ORIG-GUID: mpE-O_OflR3KcX0cJ71_sicTnI4ZeKql
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9994
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250078
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
Cc: David Airlie <airlied@linux.ie>, Oak Zeng <Oak.Zeng@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_bo_unreserve() has to be done on the error path as well.

Fixes: b4f0f97b8f5f ("drm/amdgpu: Move kfd_mem_attach outside reservation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 928e8d57cd08..68109908a869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -624,11 +624,10 @@ kfd_mem_attach_userptr(struct amdgpu_device *adev, struct kgd_mem *mem,
 				       0, ttm_bo_type_sg,
 				       mem->bo->tbo.base.resv,
 				       &gobj);
+	amdgpu_bo_unreserve(mem->bo);
 	if (ret)
 		return ret;
 
-	amdgpu_bo_unreserve(mem->bo);
-
 	*bo = gem_to_amdgpu_bo(gobj);
 	(*bo)->parent = amdgpu_bo_ref(mem->bo);
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
