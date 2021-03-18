Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F05C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022A764E27
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022A764E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1896E88D;
	Thu, 18 Mar 2021 07:23:54 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC356E88D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa5pByzqhzZBVymQbtafDh6eVT1gs7+dHl1Q7m0cdfi/1RvxZ66p5Y/JoXNeNO9ixweeVxt7L8ZL40RJ4i8Son+NFKZQdqlk/3EuF/15QxjOZFFrTHjCjBRl7nFCJliRzLH7xyGTyMvnVObYBppFWfrBTF14WwL4roHYgDYM6S7I5EJ3vDLpVBnuA8gM/zXUNxskgP+o7VOzdD9Wbw0Yj6/BU7nZEGjf1lGceLz7ekDW7Cl3jlP2Q0BfRJLK256nIR32oJsAIM3eaYwAs6UrcN3q4ODDqkJyg3Vba8TClhRIb9fR8dSsjeZS+y4l2ksuYnEcoN+6snblWkEhfhjKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74lr3uKNDxXX5qZdW3H3ZcXyjoI5+qCTgrRC0rUvkWI=;
 b=SENrQlrqUAV69OCardA2N4K9MlvpaJCBbS8xOmVBSCYLJRYpQl5uo02YL/Yt5ZOCS7P7OO99zXIKFGpZS1Y71rNjVPvTTmLZSZN9kgPghnCLOzBLY2NRvEbAT30M8+UKcRdKBc2CyijfVnXGK3eU9XCCNm1nIDJT1gF3TKXtVWYCwK3XXUzycWmikWogWjwzxdTce+YQQjFCSg22vuDYNmijIQj+kodGc1rsHO0vGAFtdNoeadda5IbB2QoKDndXDcjc4o7N4wptOVUClFHdzNoA71f3f4jX6GJhvfZUbNgEZTDNEItip3FUPOppzs5rf9EAcSivE1O2WEsq6kpGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74lr3uKNDxXX5qZdW3H3ZcXyjoI5+qCTgrRC0rUvkWI=;
 b=EvLWlIN15pXJ0c2rYDSwljojZBXGSGreLmffwmVA0F6zP+Frpz4Ry3Y1CH9wG/aKiXvmoETy20MG2RjquUWEVwJBYM/lV3TVPmkrZKZ5feVcnAKYCapubVGQQCrse9ZBeT+skUSlFAgbQ195hyY3+rlpA2MtfbNRVdImWQPukmc=
Received: from BN9PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:fa::28)
 by BN6PR12MB1921.namprd12.prod.outlook.com (2603:10b6:404:fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 07:23:52 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::cc) by BN9PR03CA0023.outlook.office365.com
 (2603:10b6:408:fa::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 07:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 07:23:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 02:23:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 02:23:51 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 18 Mar 2021 02:23:49 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: remove reset lock from low level functions
Date: Thu, 18 Mar 2021 15:23:36 +0800
Message-ID: <20210318072339.28736-2-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318072339.28736-1-Dennis.Li@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05e94375-861b-4b7d-f0d4-08d8e9dec802
X-MS-TrafficTypeDiagnostic: BN6PR12MB1921:
X-Microsoft-Antispam-PRVS: <BN6PR12MB19215DD5C8A2B91040455D3CED699@BN6PR12MB1921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuVPdnCSwddzDZGIHL9CeziThPFQ3+NG5PaIq2RyMlrl8FstWajbWcUldh4/8oPzBJ80oh3R0foOQmvtLbD8uCzelk609+5E1GMVG4qajf/2/eL3LJ1VBi6IXZxw09sa+yeRItC3YsoxF4ke+Gi2gLWm5R0G9GZ5Owdo98iHB+tiKaEtbbSGOX7gxPtmhdW7+0LJgb/tCk1bHobHiGP7Iw5cduEgWBaLFQT6/2v6AyBrTlcn3hQW9kHOrRnJ1krFZ2FPkPIYgG7x639MEGDd1UYa6DOLap92dDhnkcWCd0yS5DGaL2ZJwMpWSzMKoVG92qPle33LR90n4Qeh07wKNCn3Zg4TSSpGP1rfC2gcoB9o2trpy64xSw9prrMev7qxIVKAQd1eAe19laFcMlyk+MYi7SD6c7EfJhFoq259lDDNVvwF+O86EkqU6z+gsuqKb5A67byRsLovrmeS8ILt2RNM91/JZLaOJr6++F4vJWrAOIBQRZD7kmZUvk52INSzvpBhZXDs6olrWepI+lEFdmSI78Shmqa5XGa4w2AejxgeQeFvuWzjJVhyRC8GEAxZbJiMO5UDLLoQeCQqrTHwFgiMQSgkm1R3Jva/AdnHT5OuJ+4OOECbophdEQFJ3/+m1xQt5zbpmJU/+rcoFj4b2GmNOj0MHKa+liJXrphiA8iTky24FRXEwVaEl/a4KUJTUIU1NpDGQX3hsA4cIOHaXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(83380400001)(7696005)(82740400003)(81166007)(70206006)(2616005)(70586007)(2906002)(47076005)(4326008)(356005)(6666004)(36756003)(1076003)(5660300002)(336012)(8676002)(8936002)(426003)(6636002)(478600001)(316002)(26005)(186003)(36860700001)(82310400003)(110136005)(86362001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:23:51.9393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e94375-861b-4b7d-f0d4-08d8e9dec802
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1921
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is easy to cause performance drop issue when using lock in low level
functions.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0b1e0127056f..24ff5992cb02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -374,13 +374,10 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 
 	if ((reg * 4) < adev->rmmio_size) {
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_sem)) {
+		    amdgpu_sriov_runtime(adev))
 			ret = amdgpu_kiq_rreg(adev, reg);
-			up_read(&adev->reset_sem);
-		} else {
+		else
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
-		}
 	} else {
 		ret = adev->pcie_rreg(adev, reg * 4);
 	}
@@ -459,13 +456,10 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 
 	if ((reg * 4) < adev->rmmio_size) {
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_sem)) {
+		    amdgpu_sriov_runtime(adev))
 			amdgpu_kiq_wreg(adev, reg, v);
-			up_read(&adev->reset_sem);
-		} else {
+		else
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
-		}
 	} else {
 		adev->pcie_wreg(adev, reg * 4, v);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index a05dbbbd9803..9f6eaca107ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -155,11 +155,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	msg.addr = control->i2c_address;
 
-	/* i2c may be unstable in gpu reset */
-	down_read(&adev->reset_sem);
 	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
-	up_read(&adev->reset_sem);
-
 	if (ret < 1)
 		DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
 
@@ -546,11 +542,7 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		control->next_addr += EEPROM_TABLE_RECORD_SIZE;
 	}
 
-	/* i2c may be unstable in gpu reset */
-	down_read(&adev->reset_sem);
 	ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
-	up_read(&adev->reset_sem);
-
 	if (ret < 1) {
 		DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 33e54eed2eec..690f368ce378 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -317,8 +317,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * Directly use kiq to do the vm invalidation instead
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    down_read_trylock(&adev->reset_sem)) {
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
@@ -328,7 +327,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 				1 << vmid);
 
-		up_read(&adev->reset_sem);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1567dd227f51..ec3c05360776 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -757,14 +757,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * as GFXOFF under bare metal
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    down_read_trylock(&adev->reset_sem)) {
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 						   1 << vmid);
-		up_read(&adev->reset_sem);
 		return;
 	}
 
@@ -859,7 +857,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	if (ring->sched.ready && down_read_trylock(&adev->reset_sem)) {
+	if (ring->sched.ready) {
 		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
 		 * heavy-weight TLB flush (type 2), which flushes
 		 * both. Due to a race condition with concurrent
@@ -886,7 +884,6 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (r) {
 			amdgpu_ring_undo(ring);
 			spin_unlock(&adev->gfx.kiq.ring_lock);
-			up_read(&adev->reset_sem);
 			return -ETIME;
 		}
 
@@ -895,10 +892,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
-			up_read(&adev->reset_sem);
 			return -ETIME;
 		}
-		up_read(&adev->reset_sem);
 		return 0;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
