Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7F0C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 10:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C200920775
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 10:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N901NobB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C200920775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361D26E23F;
	Tue, 28 Jul 2020 10:22:39 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F9C89831
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 10:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftnhBdLsgh0d/wSq+SZ3cJjAV/wMMUCes/qxuwpl5+Ee1v32UzpWYAzQwZ1AuFLgbzmfb7Pe5ndSRfJSKh+SkBa6oULsuv7hZJg7B3/aouVXQuhXuNtu5xLUl2+sCYmKEBppcVAoFNZbbk8nlUePeVWbdVvKzvuY2DTDx5jP+rUNxsdkv4/U8Gmw9nXf3dxA7ddWNvBWHbZ9aDLqs+BkDZm9pBM79XPjNcWxCQBRbKOROni1pAe2Ecbpm3a5KCucWzcWl4+BMHmuzJUEbR/ALjsrtc+2YPHA7msG5l6Z5FzUCfEN5O2U62Z4sQzRhJpePt8hRMTfCCRkjHIinH/+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQgss75tL3OSnbhMWe5BRA2juNIc+XqizYby887VD6w=;
 b=C1Uban05sjWtsuTYhaX8A3swy8Hrx1IiDcDNR6jnEzGGsq8/QIQ3vVXMPi9U1PwUUBF5DBT2lF00PZDB7/CAAKtIgaPLTld8NfEurbznoq1Cy1woIKCUu8cTVbSgTzt3R3LQ0umWlHpt6E+R2iL0aqQo39++sxOExxuMPgAWFsHArOvjmVvtAYC8X+lQZc4zSXcfnzwPVMV4T4Ae1U6zzaUvnSn9F2s7csB4R9FWZCo+ls5DP/2tux7CxbIN34YngJS7ePFgKg8Q0OK/Hd2lNz0TrhPssvDc23G+/7LSnvFxkqZI7oA+uNTcEsvXwb7u1xauwEY7bxgtEV8XSOljEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQgss75tL3OSnbhMWe5BRA2juNIc+XqizYby887VD6w=;
 b=N901NobBgQGInsf4a6VVMxyo1xySksn8HexRBWqnrvLIcVoJ+CxLrW1iRrV17DabQ2PDLuGxhZJUnW+9qUUfeYVfax2hmYbihP9IfN3VzUEdNr9F9KVBmG1P2HzwZIOGthSF9lEz9J55tErNw4/OYgz7encHSB0IYe5LkxWbcDU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10) by CY4PR12MB1847.namprd12.prod.outlook.com
 (2603:10b6:903:11c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:22:36 +0000
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::3912:f141:7c9c:ea33]) by CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::3912:f141:7c9c:ea33%9]) with mapi id 15.20.3216.024; Tue, 28 Jul 2020
 10:22:36 +0000
From: Jack Xiao <Jack.Xiao@amd.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com, Christian.Koenig@amd.com, Le.Ma@amd.com
Subject: [PATCH 2/4] drm/amdgpu: initialize the cpu/gpu address of
 rptr/wptr/fence
Date: Tue, 28 Jul 2020 18:21:52 +0800
Message-Id: <20200728102154.2505095-2-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728102154.2505095-1-Jack.Xiao@amd.com>
References: <20200728102154.2505095-1-Jack.Xiao@amd.com>
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jackfedora30.amd.com (58.247.170.242) by
 HK2PR02CA0146.apcprd02.prod.outlook.com (2603:1096:202:16::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 10:22:34 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 903dadf7-3926-42ac-5085-08d832e0259f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18474ABEC63D2E2DF004298BEF730@CY4PR12MB1847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOOe/Z5F8vmXMNgxLFPMY+F0bHflBJFywB+HCPZswggqOlhHvTocQ3SJQNjQ/ECGem6nL/2lSE+QWQ+4UUjaDRxmjWmeSI9d1bBRhv3/Fxbj1k3C7YRzlNsdS9MPEkkDRJVwqm0LleoRK70K9Nezwto1YdZOlXnBBi+APppDCcddECAjkYQipvJ+aNy49KbaICOtF8gLerO/vH73WODrk76nJ93lQKJsauOs+CgGFUCSr9dukO9FiiRx8nXMBk5l/mVH4jgX1jI8Y9o49mc+bXA4S9eekzn6SeY4fLjnQXePlEzIqOBa9WE0Y8pY0F3q6HbOZIvYzEIptuSQ/coUxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB2471.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(26005)(5660300002)(86362001)(1076003)(6666004)(2906002)(36756003)(66476007)(66556008)(66946007)(16526019)(52116002)(7696005)(478600001)(4326008)(6636002)(956004)(83380400001)(2616005)(6486002)(316002)(8676002)(186003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: isZ9Eq0s6XpiykBb4zlOZgHYgh+VEwQas49Qmlo/U/7gJ02zYnKjbEHN9k/baQsZK9FKzf3xZJGYyCdOzckyICC1dyCxUaA7wO5LzEsGulNTpWDnOZFxbWuJG1rfanF+5yISp+j+BRoMbu6H88GQuORNGs04dmszi9jmD4spJO7LQYc24UmeMgHVMH3OeRo7QPBclj8xVN9nQvSxZZG27eb3p/+VGfaR4vBARV0Y9BexTpZz8hpy+OnMOJlrV+A2khFC5V5sEXGkOc9Ler8iWWck995B0vHSEbxQm8Fu7HlOAFOrYGlTlBiASMy9I16e+xQI3kCEVtmzhz3W6GPGdGqOdngg9rx/Wj7voHJQXLvBQqQZlH14vls66RQsLXQ9zYywu5zjEZ7zPoBLgkznvSq9C5F2WAkoW+kAjihYc65EjgPHsOMNqf8YYz/7vZWeM6Wp8dxsFSbPRYc2m6H3bo30GIp+/IOjTVVkzHbgTKa0K0K2yLAm4+m+ewkY8KV0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903dadf7-3926-42ac-5085-08d832e0259f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2471.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 10:22:36.2044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWb+U57GxQuipQRwAO4+BWcvWXLKSCMoWPcmmwjpZZer3QotsmidwJrF+DddemnX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize the cpu/gpu address of rptr/wptr/fence.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 37 ++++++++++++++++++++----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 13ea8ebc421c..ff63ecc861bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -150,6 +150,12 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
 		ring->funcs->end_use(ring);
 }
 
+#define amdgpu_ring_get_gpu_addr(ring, offset)	\
+	(ring->adev->wb.gpu_addr + offset * 4)
+
+#define amdgpu_ring_get_cpu_addr(ring, offset)	\
+	(&ring->adev->wb.wb[offset])
+
 /**
  * amdgpu_ring_init - init driver ring struct.
  *
@@ -217,17 +223,38 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			"(%d) ring trail_fence_offs wb alloc failed\n", r);
 		return r;
 	}
-	ring->trail_fence_gpu_addr =
-		adev->wb.gpu_addr + (ring->trail_fence_offs * 4);
-	ring->trail_fence_cpu_addr = &adev->wb.wb[ring->trail_fence_offs];
 
 	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
 	if (r) {
 		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
 		return r;
 	}
-	ring->cond_exe_gpu_addr = adev->wb.gpu_addr + (ring->cond_exe_offs * 4);
-	ring->cond_exe_cpu_addr = &adev->wb.wb[ring->cond_exe_offs];
+
+	ring->fence_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
+	ring->fence_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
+
+	ring->rptr_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->rptr_offs);
+	ring->rptr_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->rptr_offs);
+
+	ring->wptr_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->wptr_offs);
+	ring->wptr_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->wptr_offs);
+
+	ring->trail_fence_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
+	ring->trail_fence_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
+
+	ring->cond_exe_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
+	ring->cond_exe_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
+
 	/* always set cond_exec_polling to CONTINUE */
 	*ring->cond_exe_cpu_addr = 1;
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
