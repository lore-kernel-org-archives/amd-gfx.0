Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B45C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6BD2463B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="atA8SYKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6BD2463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA096E455;
	Wed, 18 Nov 2020 16:24:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AB76E452
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 16:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aES5NpeRaVa41Ty1Ggu1eNSPI8GcraxIZBK1k+QLr7UaKW/U5wtmrBtKe0h9aXwjsrgELnjleX5+dukWcMclcTut+c0MDu8AKt7rdcyzIDWbH/WWqBSbGNxr8j0NxEZqRDjz4cNrRCvnn2S2mxH2Th/9on+oFeFTVQ40dRMB5ykx6Ll+NOb/LmM6ZHxe3VT5vLjxFcNKa5Q0n2p0dy5PgP5WOLNDzTdj2aYXVzG0/TOoaE9RCtL4ntabZCTjunghEZlaN64jMdZAKzjI4hR7AcEQ8XJw61a/6NCMKxOPfQd1M9klCsYrhpHM8TvTqmo54fkzcNKtj9WxDgmrLNwZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMnOfi3o/lKBbZ38QsHTUh1PGnD2GBg8IeFa6ypzU/g=;
 b=VpvbJo15TL3LT5z8tSCJ0ZY6gthZ5zwgnDcQ6nDcF7y8h5KcZh7EypZYRQYVZWCHNCiiDL2lyinXrAFIU88zxKjUbLyuEMecYRYyWPAiu+3qGF9CmFK9ssZbCpZW5JMp4kZHl+E/pcdle6wseW6gBoKqnbU6K2nLmA4URP4aIwGtdBE0dsIzDWVJmPaPyhMUe5x8gb38LNv4rzuzSC4BLLLZfN/2NIpXtx191WQ0YugEzGoKvM4v7Q6n0ZLPUdJLelbBn8Uv8JG/5ZVtBdanzq2a2L7Vg7EZd6dw951JpMPd6GIInpNrG/xbGNcnkvSYWjM/Zf+ysETXcRIOa7FbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMnOfi3o/lKBbZ38QsHTUh1PGnD2GBg8IeFa6ypzU/g=;
 b=atA8SYKY0TOFeb+lip6AdpeQJXnaIds5s+zMBwxhBTxBvCWkY2qa2wTvEg9msTqGzorJuKj3Eg+wSLzt8JgvO6kpm31IAHHZpoDYOVGQxxkTVxLQvpFaKErHpP7rp70XEEpluJOJ4t06aZ6FOrUACta8j6XiLVubuX369Sfve8U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 18 Nov 2020 16:24:12 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 16:24:12 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 5/5] drm/amdgpu/vcn3.0: add software ring share memory
 support
Date: Wed, 18 Nov 2020 11:24:01 -0500
Message-Id: <1605716641-22176-6-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
References: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 CH2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:610:4c::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 16:24:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a01c23f2-5c8b-4502-75b1-08d88bde6225
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4314C2758BDF6F5D369AAEC6E4E10@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMqd7vcbm1I4CyXINqvS25FEjqzxvf3UjFJeFn2CGiYM61l3SilKd2l3Qy0Mjm1dgm19fBrf+07cFJ6ysw2zQ+hq3LBJ5iUBIVLjvdG56daojgzU0xuqGObb2unr2QAohCyGXWYYjD8mh4n+wtp4PLY3YofeSMkOHPG8QdXuwkkoI60aqsEc/slQrcf9CtSJQYehD1nH/BeTImJKzXXQQ7qAA52w1SGkcZYRbYlSR3RXC9xu0lGbeLhR1rvhZVVmyNyJ36fA/7NwR+ARDtFdJrUJ+hgVDD+vvCkm8FKT/d8rM8sao13jEgECEMMTK/jC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(6666004)(478600001)(36756003)(6486002)(26005)(16526019)(52116002)(83380400001)(86362001)(186003)(316002)(7696005)(2906002)(2616005)(4326008)(956004)(8676002)(66476007)(66946007)(66556008)(8936002)(5660300002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +gFhzO1AJQDiqIruqPB+pQLWcSd1EgXxyBEXD5KkeBGC4OP1EgXpATLd7Mt6L+N5TUNToyspr/BV5hs1Hf+rtnG00N3XjkboY9Od9hDg6W9cykPLN1fVzGzXgrWszy9yAq2Qyk5xuZLRFY2AEhWBmXAkZcUhINJGvEeO5fS9IrD1k2BUXZByI4M5eJIPA4XrVFUbzndf/qQf5bRX13dkzq2aJ6p1vog09zWxBHOvxp8u3SLXxF3WsHRE+hwAPAmsS2e9eK+oTMHvj2Wq9Qlj7Y5EzeIBocLVAT3v27VaFP9ckHY4twtQjYQJZ4UftXrs3gjbILqKXVjPepqmQ6ejVnqm15rnCDawBnfk+98EIRwB4rfjWcDzHrlUPD/U1EhihpZNPWzfwo1yOauhS5fKTZbBYl9byAS7BSkPmLAthtSuKuSQxgipJa8FRiSHQ4PLqlMXEl7+FByED4wJCDVym10wYbfuwWRi4tD17VOH0X/iSp21uNOxy9jqiZWAsarn1yJvMb74vo8s1ObYu0UdYyeFjn6RMO06NREDwwp8NI+fX8seAze0UKbA/b/Ra2iMMdVYf0Fi8Wzm4CC9sNxHyGF8s/wkzMaHG0ufJqPAfy6DJBK8k+UezESOS13/v24pyzWSrnqNzFacS2A6QOfkqpisc6BjOOwdFFBxFEZgL/P17jR2q4bGdo+v6h3GmxAru0/HepKXg4sNfrDVmZ0xgqJGgSvQWeYlYs+IdWVWvaZpgjLkMV+uPRqEM5NGZEAAIghqv9sz+GAp6dznLbPlTvlu0QGxp8NFxtceI5Kd7b0NRkkmeeSsNq2cfZkTXiAReAO6sYd6LmeNxypV7pZul+kTy1LKayTvaQiw80vj7dVxh5R/ICoB9BmwH6SQmCFpKIWNXEWa/iDJ69SoUtr8TA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01c23f2-5c8b-4502-75b1-08d88bde6225
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 16:24:12.2605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6gPQ8YtMmiF09AoAhTH6rEBo0FNFXvG9QliZXeo4CgJ+6le/VpV7KGWFKMBijcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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

Support software ring share memory with vcn firmware.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a94dce4..71e10bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -170,6 +170,7 @@ static int vcn_v3_0_sw_init(void *handle)
 	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		volatile struct amdgpu_fw_shared *fw_shared;
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
@@ -234,6 +235,10 @@ static int vcn_v3_0_sw_init(void *handle)
 			if (r)
 				return r;
 		}
+
+		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG);
+		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -257,7 +262,17 @@ static int vcn_v3_0_sw_init(void *handle)
 static int vcn_v3_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r;
+	int i, r;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		volatile struct amdgpu_fw_shared *fw_shared;
+
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sw_ring.is_enabled = false;
+	}
 
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
@@ -467,6 +482,15 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 		upper_32_bits(adev->vcn.inst[inst].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
 	WREG32_SOC15(VCN, inst, mmUVD_VCPU_CACHE_OFFSET2, 0);
 	WREG32_SOC15(VCN, inst, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+
+	/* non-cache window */
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].fw_shared_gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].fw_shared_gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
+	WREG32_SOC15(VCN, inst, mmUVD_VCPU_NONCACHE_SIZE0,
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
 static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
@@ -549,13 +573,16 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-			VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
+			VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-			VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
+			VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-			VCN, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
+			VCN, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0),
+			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 }
 
 static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
