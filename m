Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15108C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7E920708
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0kcTSJ4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7E920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907616E0CD;
	Mon,  6 Jul 2020 05:05:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65FF6E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOp6D3HT12up/p5DiREzrlC/WLIfxqA0Rt7brprroOUFdvY/KL/Uqw2isAT2FJ5rgu1RHZGqNfBZwfw7k/tMSQIVLS/6faBGu87ZCAvw602IxJCr9QcDe31EUd83UWOU2MjA45cIFKl2LXHXAUI55o/x6r6BG+pTRSBC+vuDjiPSoUTxdHSlR8+wFvuOwSTrV6BfHo1m8G8l+5YXDxly1wrRcOl8a97DdjqV/S+g6aHX9j1DPfwfeL9AvoEzDtoNSaoL9mZpdnUC4DO6Qy2DpPL8ZdQmmw5pGbXPrG1/GF85a+0+hNV+sFu0JLnBFgs7l6YKHIMuBdPqV8ZKKKCGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFNn1DLJDWAFPuEtau0/cU7CvpMoW/CI8Cn82jY8YEU=;
 b=Q0SJ52G0xO5g0o/gW3Opr5sHXsq0hfBr5RxlHt2zNgWqPGWy/WV2apLap6n54fKtMannHWrfWVgPov0iPAJdlTEr7sKqLEiGThu+O+zDsQG3K6hdj0dEwyLmfWQ2gDfntG2+PsmjJb2E3bGf3EJUK5wx7X9t09245Ktbk8XHAQVzDwIL25DPtM8Kb7SE23gYaBXxqiL5LPIAHHh0mtJjU5d8pSRg2/EhcuoQ3faXFAL1NpLwcEJy1PWuOoJYN2j5sr8yJomQJfVKA6TdWrhtG6vTGDBzfaGtNgbkalOCccdi5GLMBhrqgi1u6YruFJL814/1GG/iMlayrOWlNUF/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFNn1DLJDWAFPuEtau0/cU7CvpMoW/CI8Cn82jY8YEU=;
 b=0kcTSJ4y/8ARdPk8/Ojsj4WMa9YwQqHHB5tUYnuoRl1IoFjqYEET69tjEQQZ4OpdpxDgT1XSYTvn301MIa815X2nbPePIBFO0XGAoJz1/nmZ55LG85+OtBH9vqGMXYi9taHKhBOo4f4FDW1joxilGbtjgxgBpNhzrl0MDnzvkSQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:05:40 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:05:40 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/12] drm/amdgpu: use register distance member instead of
 hardcode in GMC9
Date: Mon,  6 Jul 2020 13:04:59 +0800
Message-Id: <20200706050509.714975-3-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706050509.714975-1-ray.huang@amd.com>
References: <20200706050509.714975-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:05:37 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8af8bc83-c21b-4e4a-88ba-08d8216a3a04
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470C735722D7C0F7DF2C037EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FR14YU6jBjOujvKASus8WH8RAfyTsWHsOls9GKICw7L7JzISawJUJFi3v3sEqU5vpc5h8Ogf52cc5AIBHeCb89FBX3GbomGtWVWGAuDWEZrvnkefnGbthNdG1SO5xwf/KeqOkEMVFfUkpWoo7l+ak80LFV4V1K0a1uR2Mr48u9GxO4bBraC0uA5MS+1B4q67NVmZP6Dt0SLeFKGhYhiorCgP4yiG9RFTa/wCV1SOaa1JTwlXqSvlwZcvZevcdT0CzSvm3Qv6Hg+V0V2Hsqf3sZvUaV9pSLARAkOBl1CLmdvWQRdt0hjYsmQuIWIPQSEhO8daUtw+Nq5iD0SC5kZUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6666004)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EooqYqxyUxxy1iyI+Nmo6az3BYgAAKxSTG3ee3BqwG1dIMVULYIz0wugDSfh0AuQbcMZvr1OW6ejXsl8oC3VbigUoX0nEpIwb3OVPS50NempMwpfeS9n5slk1wQAdmSjUFxOSpzqn98exbwant8gwRxtvkYeH76gxojRKhCLqi27KjvKMz0zV1kYRGNKvHWeqdfmFIvewf7Knf4dVYn6iY9DGqi/8gWItuFa1ZwSg9PTcr7hn3ldWBoBgDtyVVJFICfiyB6EJClWseez3q0WXRolyUkBItaYvdJafHcNKd9kmlBhyGaYwHi2cZbRtJ9AaelidQxf+c2byaNY7HVXVsRHJOHAnjf7G1ommiF34IRYLUQ+w7lNY3d/Iij7kVgy/Qf53W0j1NdIfGfjWmQDzSuraiEmDwQPeOWfne/7R2Lj8s4MlpCzSrsTGi0bloC5ELysdHpa/5n3YV9r/pdntdaj/lFLv+cN78tPqP358D8vhxv8sGdjOo3LxKjbJ16L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af8bc83-c21b-4e4a-88ba-08d8216a3a04
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:05:40.2107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ6g3OFBuXHccV1rsTPS9DFz5Z0Zi5huohIjQf64EMpx28jo41PgM/kNzzGJ1P/zmpkFUreAtN2g//rl7NYbQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: AnZhong Huang <anzhong.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch updates to use register distance member instead of hardcode
in GMC9.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 39 +++++++++++++++++----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3470929e5b8e..6e4f3ff4810f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -502,11 +502,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (adev->gfx.kiq.ring.sched.ready &&
 			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
 			!adev->in_gpu_reset) {
-		uint32_t req = hub->vm_inv_eng0_req + eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + eng;
+		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+						   1 << vmid);
 		return;
 	}
 
@@ -523,7 +523,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (use_semaphore) {
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
+			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
+					    hub->eng_distance * eng);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -534,7 +535,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	do {
-		WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
+		WREG32_NO_KIQ(hub->vm_inv_eng0_req +
+			      hub->eng_distance * eng, inv_req);
 
 		/*
 		 * Issue a dummy read to wait for the ACK register to
@@ -542,10 +544,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * GRBM interface.
 		 */
 		if (vmhub == AMDGPU_GFXHUB_0)
-			RREG32_NO_KIQ(hub->vm_inv_eng0_req + eng);
+			RREG32_NO_KIQ(hub->vm_inv_eng0_req +
+				      hub->eng_distance * eng);
 
 		for (j = 0; j < adev->usec_timeout; j++) {
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack + eng);
+			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
+					    hub->eng_distance * eng);
 			if (tmp & (1 << vmid))
 				break;
 			udelay(1);
@@ -561,7 +565,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		WREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng, 0);
+		WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
+			      hub->eng_distance * eng, 0);
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
@@ -676,16 +681,21 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	if (use_semaphore)
 		/* a read return value of 1 means semaphore acuqire */
 		amdgpu_ring_emit_reg_wait(ring,
-					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
+					  hub->vm_inv_eng0_sem +
+					  hub->eng_distance * eng, 0x1, 0x1);
 
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 + (2 * vmid),
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
 			      lower_32_bits(pd_addr));
 
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 + (2 * vmid),
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
 			      upper_32_bits(pd_addr));
 
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req + eng,
-					    hub->vm_inv_eng0_ack + eng,
+	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
+					    hub->eng_distance * eng,
+					    hub->vm_inv_eng0_ack +
+					    hub->eng_distance * eng,
 					    req, 1 << vmid);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
@@ -694,7 +704,8 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem + eng, 0);
+		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
+				      hub->eng_distance * eng, 0);
 
 	return pd_addr;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
