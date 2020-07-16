Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3104C433E8
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 13:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C833C20760
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 13:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YIcjO54Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C833C20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7141C89E3B;
	Thu, 16 Jul 2020 13:14:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C59CF6EC61
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 13:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB5GS2+jccr4kxiNpOujz9yI/ghAezWauxOIDTKyp3y6mfnHKt3k1hRmtc+Y2Hj2tEvROBBVewGZ92CIC8ZHBRF2b7kxASkk3e/dzcuU9xZpSOwEldbE6JKL3xeLyDOX56iazYae6EnoLMFkTmp23lbK3yKXdZKeo3x2rViLuiY4a7MrjD4mUEuVgeurnqWAU1oWR4LMEmJF3gZCzQxzD2cnrVEq1F9i7gg6EWbayGA8O4KL1i7BRhtIXLIsK0DYmpoCvK2oOL+xSJ+fNe616NgkDxSzztBq6WWC94DFGsVotubiNZe8xd7SIY+xJ/Z3dKtxXVgydgcUBLso3LVAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLC+x+PjoQzXGRua9+nADl7iLmJxzliE8Tnboc1lr9A=;
 b=k8tQsf7miVzHbxMePm8FtwH3QZxnPssSBlwgywrivnfY9VInx/4e2wS7qwdkPiHwfxfq1kC7vu++pYNcZccXTSD6RVbjaJYVnTZiJ6vzJs5HRKRXEqfNLzziK74IQu25YI7BDD8AIWAiUmuee+viHQmdMlNIlOdjJh3mK9dFGfEFB/9BZYJQZOFwRxRWePScH5TRFVVy7fwiv1E+M5NrgUGZ4ft3+vwo+CAm0ktoB9bEuHEFr35nrI5M2OBQDMdDwoXbkfJbSU/DUCkW5b0/Yjb45z5frwQpEYV5s+WetphjWi5N7EhEc2t70RqxIG2zjon9G3IGXJaBGdd3baFx2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLC+x+PjoQzXGRua9+nADl7iLmJxzliE8Tnboc1lr9A=;
 b=YIcjO54YxDFv1c4FDq4QPxcG6AxyqJIzejJ4vu+p1bmM/8EO8Nbd8LT2udzs8VVTcIGnYfR1+Alhl5ec8BmUuaSd9sRVvtQVoS5vAekpamN7H1635xKo72n7zoDkAb+5ArfaU+u+R0aavlO5Dvh3sCSP3fFeNuQGWhRXk1cbLdk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR1201MB0092.namprd12.prod.outlook.com (2603:10b6:4:54::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Thu, 16 Jul 2020 13:14:57 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 13:14:57 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/vcn: merge shared memory into vcpu
Date: Thu, 16 Jul 2020 09:14:47 -0400
Message-Id: <1594905287-2895-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594905287-2895-1-git-send-email-James.Zhu@amd.com>
References: <1594905287-2895-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 13:14:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74a31716-a8a1-4327-d744-08d8298a3c22
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00926935835E08CDC96FB407E47F0@DM5PR1201MB0092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUxYsQCluztkBtn+yTC+kRWkE8QZ6FBxuJVMq9GxKsDii/TTDuqIwV61wFaIljepRFWubd5YTxHkUejhfxFZA/dc3ndRiPP1dP53APVICC03uRX0/LHMip38SUwk9QhnFd4Nl2tGd/dyHx1iSZHI5D7Y+3Hcx/ei01dk/MctaK1qAJAmmAZ1rbUjv1RDruewdnpUuWw8qsiQhZVoe6Uzym/MXBgIVGxT+cbICbVjbJF4OyvvNorh/W9xZyLN+lGllLI+7HrcZS6Fl2EuIIR08xqUO+uvzFz5022QS5Nh/2yTEPO0ARA2I+YgvQOmWN+eK8QnwL6smtKq88ejebVE3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(6666004)(66946007)(7696005)(66556008)(66476007)(4326008)(478600001)(8676002)(6486002)(316002)(52116002)(2616005)(2906002)(956004)(26005)(186003)(16526019)(5660300002)(83380400001)(36756003)(86362001)(8936002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CSPcsgu2c4Kp+yon7hKczItlBmycAztFTTOU+D82PmhaDpNp/eTVMTgI3gP6jelHp3acVb19n4C6IhMUhr6yw693xvwM5WoOTHm36Z2L53NyURh/PQXgu55KuH42e2JTib9wp1GRKHVGoIMwiduNgNx1wDiXA8WZWz5bgQCanmgJx2gS7aENPb7UoRM4gtGvsgMrNosNd+X/hJW+vRGYQsJu65q6jHGpRsjNV0pY2+oJL53bnI3ZhZoBR4CRj1EMnjDOmT0xGaop2TSrXmKfeJjwyWr8PCl8jOZgAjjvOMo/lqVvoIFRJ0jimLl/boniE/JP3XbehfIJ97nBt4nBjRWdFWjqmW2JecHAuWO8eK4U3zM5ZHBHNClfEZCszkY9mEDNlTgodr4sDJ7XRZE9AXGV3DIWlMHjY3PP4XEdmN84NxO8MibjwhOvD1ksUHk+Z6icmKx9hhyR8yzSb0nZlMs7c2yk1USE/7N9EdFK/xKYGk4Al5vBE0zit/amFmn0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a31716-a8a1-4327-d744-08d8298a3c22
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 13:14:56.5716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4ZSGgnnEosyKmxupJsx+TkSNHWN2w7TFrVejeBi4dYcBVLqjXvCDyacaFcXb/tg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0092
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Merge vcn firmware shared memory bo into vcn vcpu bo.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 18 ++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 -
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index cbc2b30..8c77f9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -168,6 +168,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
 		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+	bo_size += AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -181,6 +182,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			return r;
 		}
 
+		adev->vcn.inst[i].fw_shared_cpu_addr = adev->vcn.inst[i].cpu_addr +
+				bo_size - AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
+		adev->vcn.inst[i].fw_shared_gpu_addr = adev->vcn.inst[i].gpu_addr +
+				bo_size - AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
+
 		if (adev->vcn.indirect_sram) {
 			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
 					AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].dpg_sram_bo,
@@ -190,14 +196,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 				return r;
 			}
 		}
-
-		r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)),
-				PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].fw_shared_bo,
-				&adev->vcn.inst[i].fw_shared_gpu_addr, &adev->vcn.inst[i].fw_shared_cpu_addr);
-		if (r) {
-			dev_err(adev->dev, "VCN %d (%d) failed to allocate firmware shared bo\n", i, r);
-			return r;
-		}
 	}
 
 	return 0;
@@ -213,10 +211,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 
-		amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
-					  &adev->vcn.inst[j].fw_shared_gpu_addr,
-					  (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
-
 		if (adev->vcn.indirect_sram) {
 			amdgpu_bo_free_kernel(&adev->vcn.inst[j].dpg_sram_bo,
 						  &adev->vcn.inst[j].dpg_sram_gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b5e9088..7a9b804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -199,7 +199,6 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_irq_src	irq;
 	struct amdgpu_vcn_reg	external;
 	struct amdgpu_bo	*dpg_sram_bo;
-	struct amdgpu_bo	*fw_shared_bo;
 	struct dpg_pause_state	pause_state;
 	void			*dpg_sram_cpu_addr;
 	uint64_t		dpg_sram_gpu_addr;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
