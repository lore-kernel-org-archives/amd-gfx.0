Return-Path: <SRS0=udmR=3H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54914C33C9E
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2020 01:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1628721D56
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2020 01:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KKTRaJXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1628721D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0366F989;
	Sat, 18 Jan 2020 01:38:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72F76F989
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jan 2020 01:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLz+lFb5AClmQ//qFpA3laxVV/ufG9Qmi/lU3USaOHop60/M1TJ/nnONex3A6MUHTESNxkC9zH/PGy7LgBVdqwltQ22kaZwtgk9Zg9MiIIcMcXRNcL3HRdObXo0d35fXZfBiMOdgDkxVR/kzoOZTknqn3gmwKnbt/xPipdNVxx10eCXE9MV7+XjnMecW6QoIsJLpb2Lj2vRKFNryz2lgtxo3RZKcHTQO9Zkj0BZD0pNd427iih3xppMTHkE0Oh1pFy/FfAAS5vPKnNfFjckGNrpk2OjpQWOI8VOVkd3JLc/k95BQEVBWcwDz5soudmmSo5nzdG5DoIBt+sndU/07OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J4VpcN7+GFYJRFST7UOeT6aOr/LS2gQuUV9il1bJ2M=;
 b=dL4pt+jycej7LkVSPb9NT3hS46xkwSGhzf1O0sjEZrz7Ibo5bbiGXjOVT2/fqEuu6cE+iD3Gnry8hyCjUzhJcrwKAs+H4p+eNaNEjieRgtawq3hkVpyydncU1T7fsy24fGAmFOqJ/TDOfOJ/9/NsOZ4ZsTQg52S4LzexotjlIhs1w2GzU57iBNeVQl3QIyIUD3XjDhe0uwZcm/P8hlAN1PZm740fgt214SDGD8aci89x6WYctx4IPAafeZYvkHEqJwN4VH12+c62G1tvx5UxAevSnM/mSIt3gA67EYkOXNis9BYixBTJ0OJwWBWMkFRed4ouJ8ZSznopCFar05gwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J4VpcN7+GFYJRFST7UOeT6aOr/LS2gQuUV9il1bJ2M=;
 b=KKTRaJXaa9zGC007C7UB6GLcCxWWT7Z75XvOFm+uTeI5PXnPmnRcPruOicr/lGVPkQtMzmxMLskYPtKU37S3oqWmbBrI7zK1jHSRtAUWrM2yn1YDMTAxKD1Nis5usJy9jnNfDvLiiZ+6dC3CyHDfUd6U1Wv7Q9WyMhrLo/dw5C8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0009.namprd12.prod.outlook.com (10.172.85.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Sat, 18 Jan 2020 01:38:07 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.023; Sat, 18 Jan 2020
 01:38:07 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: Fix TLB invalidation request when using
 semaphore
Date: Fri, 17 Jan 2020 20:37:33 -0500
Message-Id: <20200118013735.19361-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::25) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from Harpoon.amd.com (165.204.55.251) by
 YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Sat, 18 Jan 2020 01:38:06 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b742c414-d1bf-4bee-4536-08d79bb7113c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0009B69F3AD846CDF6B00C0292300@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0286D7B531
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(5660300002)(1076003)(2906002)(6666004)(316002)(6486002)(86362001)(6916009)(478600001)(36756003)(956004)(8676002)(7696005)(52116002)(2616005)(66556008)(16526019)(186003)(66946007)(66476007)(81156014)(81166006)(26005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0009;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDsZz8rtwnDTRGSJLa1gmFiD3IlU5Alebdf/Gj/FKWRd/fn5uKT8/AhE9rof5rZkkE4znXTHbFwfhw8+LZWfDT0nMFs7mEcUo32h2pJFt6PzEK8w8jN+6yBxL1oIE8YuU8F8k2YNWRo/pHPrhLOYWRWTkjkpd1A8AaSjNZ4bgoQXdUf7F3S4TkUnkX+LcU5Ray6S/FeSBZg6tHga7iFc96EFXKKvnwm3gi+p+NsUFxZVZpQvIGQFuppOE8aQm4Z/hcIgGDXS81bNDB7dF3d9ApECPeYW4g6HcsRv6kHD2IWwNvwFCbB0xfQqIfGjqCP9EYf0bevHnLpioTwYQPM8KvpQhVM8Zfwus7ujDqfv/mfjKZHJDY0RwWmBsOtZ8k/0Be/F/t6ii0SYYkEjqPnVUvPpUEKwLTGV1MtOuscJAP1ff8KMtTY0uq4XfgeqJCIt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b742c414-d1bf-4bee-4536-08d79bb7113c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2020 01:38:06.9426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPjMsGmqSdiZ46sIZA8DUeVIOCY6Mn37512sDR5bsabGsyuNbuc9jqroKZ09EJYeL9U8S+9WOn4xU/WY8YiZYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use a more meaningful variable name for the invalidation request
that is distinct from the tmp variable that gets overwritten when
acquiring the invalidation semaphore.

Fixes: 00f607f38d82 ("drm/amdgpu: invalidate mmhub semaphore workaround in gmc9/gmc10")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 86f4ffe408e7..d914555e1212 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -262,7 +262,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 {
 	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 tmp = gmc_v10_0_get_invalidate_req(vmid, flush_type);
+	u32 inv_req = gmc_v10_0_get_invalidate_req(vmid, flush_type);
+	u32 tmp;
 	/* Use register 17 for GART */
 	const unsigned eng = 17;
 	unsigned int i;
@@ -289,7 +290,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, tmp);
+	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to be cleared
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 54bdc1786ab1..6d95de1413c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -476,13 +476,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
 	const unsigned eng = 17;
-	u32 j, tmp;
+	u32 j, inv_req, tmp;
 	struct amdgpu_vmhub *hub;
 
 	BUG_ON(vmhub >= adev->num_vmhubs);
 
 	hub = &adev->vmhub[vmhub];
-	tmp = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
 
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
@@ -493,7 +493,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		uint32_t req = hub->vm_inv_eng0_req + eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + eng;
 
-		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, tmp,
+		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 				1 << vmid);
 		return;
 	}
@@ -521,7 +521,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, tmp);
+	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to be cleared
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
