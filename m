Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5092BC3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 20:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168292146E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 20:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bKdD1RxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168292146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9856E0F6;
	Wed,  4 Mar 2020 20:35:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3126E0F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 20:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlVAFaoommlBMKcpni8UUnVoYA5BLOm3rYwJjxgCHDSZUzDW1CIIPyUzwCaUKgAYpKD67iyBqjsY+l4Z3Q2yQ4iMdd/UFAObOGiuKg9IfdBjL7WNozc7mmmym16dhO+aXIDbjFLLKbE4sxywGx7XHDRRJXAYiThAme4we7T9jsE93jAkPkD/FrDemjnrsseDM2hupBO12E1h5m9tm+rfhbkgqZ4F4ey1xaUstRZex3wk7+eB0F44Je29+h7h3E31zY/3i5ir+NJLoQ6YOXbC8s9Mo1ZSNPNOVlng4C5KWR93VHjUbyYjxSs4tHQgHzlhbMESaLj+Wi1ss54cR4twLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36fOEbnV/OLcCoQd5/qGOEsk2UjzF4gx/aG4MuaauVk=;
 b=P9NHwD6HlmV6yTj1bmvto8lhfPPTLVbYrNTomS3eOrj8pAd+e1ZPn8fz0EeK5KdBZ9sSFK7dyPEDZX/pHDT7ttAQapJIfaiyzVhJnNUgpk8MZyZ/ZIRySTQAoJnxXPRYRxP40CeQok8LzHHuZSsMcyxSIo5utDIyFeiGMUrF59+UZEK665L8s2UvCMVmsUTMd7TKOVxW9lsWfFfmvbGanHx4YjySrObWxZgo2sxW4Ar9tchona0Hs4AVl+7iT8wxmiyiQlxGw1D3p5vm9iI00EmjaluFbRjdCXrqjoQFudWEk6j+QrirhiYhWf280jpbjf7bhW/8foLKVmKtnJ+W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36fOEbnV/OLcCoQd5/qGOEsk2UjzF4gx/aG4MuaauVk=;
 b=bKdD1RxSMkQR+tQ/ApO9Wfz4ecEEJlfFa41s0IRTaI3M+HPcR+eLb5KR2KuN6XurKDTbnAPe0TMoSTWuopyxE2uPpFJtNKQJfgLAmFkEIItg9qpamI/clfqnBRpY2uDQm4dXL6Ir2NHtLs5+weyiM6g4mLRgwEOo4mPsCMpSnog=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Wed, 4 Mar
 2020 20:35:40 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 20:35:40 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use better names to reflect it is CP MQD buffer
Date: Wed,  4 Mar 2020 15:35:29 -0500
Message-Id: <20200304203529.8771-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::36) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 20:35:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab63b8b0-9f87-42ac-a176-08d7c07b9a4a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:|CH2PR12MB4181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB41818496804CE70E5134321BF0E50@CH2PR12MB4181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(5660300002)(2616005)(186003)(36756003)(2906002)(16526019)(478600001)(956004)(86362001)(26005)(66946007)(316002)(6486002)(1076003)(66556008)(8936002)(81156014)(81166006)(4326008)(6666004)(66476007)(8676002)(6916009)(7696005)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4181;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwVwkSWs6ByJe9kffVx/3E3onBMQ3nJnfp7UDesTRP8LcLiAe3yDrOeVx0PpSyWB6JVUt+tT1ZohEG/uNEepXS/lGuxDX6BNiTIBBzpFeCB+0x5K17prKNCuiGHHST7GVCxiDn/pxSP+hpbYZn/hiWiSQzhy74VUhDuOT8iDSrnMOZFi/x54xhY3l2epSXBJVzB0vFrfr+hx2mKXrZ/nOw/IDBKZLYPZgGM5VMxpW9EnxezaLWgvuhSVi/1RXY7RKjoiamS3C9FvTG83/FzFBkYrbhRL9FOcBjDwAsCwEYuIZE0hTILf/KRJaojmUSkAYvihM7Q301AjsGY8AvAOD0ZyLt47NA/47dArsjJ9+ldK5y9f0hbvijxOcYJoX6yldNrU0S5x/crMOQ5z7BNkOqKcgE5FR0F8pBT4SvC2xHEAqrpUweIPhvtY9IVgbof2
X-MS-Exchange-AntiSpam-MessageData: fKB5stKnq43o2d4vwGTku14rmzXpfvpTFaog8PNbhFB3FBOemyRfTo9F0f2gR2xdHvxwH4eot09LKC5D0KF8VVECFL/hDMqZLevb5QKkdghtqeHYAG7CSyLgB0IjLAQVJPM1ubzcEGUJdKGmppYNRw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab63b8b0-9f87-42ac-a176-08d7c07b9a4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 20:35:40.0965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9V+GzFfzLTuJn9/DwCLo6AT9ulHxam4FbBFBw+DrhKbXBLd27l/6DZdm0OgpEN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add "CP" to AMDGPU_GEM_CREATE_MQD_GFX9 to indicate it is only for CP MQD.

Change-Id: Ie69cd3ba477e4bac161ea5b20ec2919a35f3528e
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 7 +++++--
 include/uapi/drm/amdgpu_drm.h              | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index bc2e72a66db9..726c91ab6761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -224,7 +224,7 @@ void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd)
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
-				void **cpu_ptr, bool mqd_gfx9)
+				void **cpu_ptr, bool cp_mqd_gfx9)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_bo *bo = NULL;
@@ -240,8 +240,8 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
 
-	if (mqd_gfx9)
-		bp.flags |= AMDGPU_GEM_CREATE_MQD_GFX9;
+	if (cp_mqd_gfx9)
+		bp.flags |= AMDGPU_GEM_CREATE_CP_MQD_GFX9;
 
 	r = amdgpu_bo_create(adev, &bp, &bo);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index fca87bafe174..665db2353a78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1043,7 +1043,7 @@ int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 	if (amdgpu_bo_encrypted(abo))
 		flags |= AMDGPU_PTE_TMZ;
 
-	if (abo->flags & AMDGPU_GEM_CREATE_MQD_GFX9) {
+	if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
 		uint64_t page_idx = 1;
 
 		r = amdgpu_gart_bind(adev, gtt->offset, page_idx,
@@ -1051,7 +1051,10 @@ int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		if (r)
 			goto gart_bind_fail;
 
-		/* Patch mtype of the second part BO */
+		/* The memory type of the first page defaults to UC. Now
+		 * modify the memory type to NC from the second page of
+		 * the BO onward.
+		 */
 		flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
 		flags |= AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index eaf94a421901..1e59c0146531 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -130,7 +130,7 @@ extern "C" {
 /* Flag that indicates allocating MQD gart on GFX9, where the mtype
  * for the second page onward should be set to NC.
  */
-#define AMDGPU_GEM_CREATE_MQD_GFX9		(1 << 8)
+#define AMDGPU_GEM_CREATE_CP_MQD_GFX9		(1 << 8)
 /* Flag that BO may contain sensitive data that must be wiped before
  * releasing the memory
  */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
