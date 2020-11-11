Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E51C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC590208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iVSLj/oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC590208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76E36E0C6;
	Wed, 11 Nov 2020 22:28:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5EAC6E0C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 22:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTQlbuwI/qJKLDlc4uN5f4HAQr/pJ3c2UP8xWQqR5XNTg8lllbqYM4ByEKREGbHPrMUa+X16pUElWyZZXUENUyE6bMU9tvQBT71g1LWOz76Bs9ad2p8oKTS6f6akw11eCB+EVy5AWy3hpTsqb+mwdBMF/HSjf/qtiAuEHhL4RIDtC+JxjPqlzaggdIE6DvW0KOluwA9rcwG88uRLY0D5dBDosLWmdd/7aVuNvK0dAY+7ctHy+FsJixrJP+pMcxdjsTA3Q2sIxRQ0bTP+PCrbozuiWqFn8PF5t0bUY0PWvVYGGfXMFHvsqu96Q45cMi3AK2QLz8BGpEq0P/2IfvWHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCNvrzHKMoTxP/aRL/j/Nl8hc9Jh3M2GNT6LOpkPiPI=;
 b=TQMPS/EzxYPP8e4ONqe5QhiaaRLEUzYxNxE9akr9DJFJSvHYPVyy7VVF+Ja0Qnjv239G1llS5hT45+PhMg/wUQyW9Tjex5mfsrs9oRvwtzyropItZ+CYFWAeq+TYZF325ZdhdokIqTfGMqUfDRzlSlwJc/vD4mSdZZqBNXarixEXZC49Y20Xm+jY8McTV1befa1H+bN9qks+GC+Y4QdzrSamDvhlCozbAO/FDJHmuHGnxbQ7/RRNsY+YBZI0V1SCRJHzjOd2Txzue+CwJJMBe4eeD7g1EYw43dF3kCcFvxaK+nVgOXWnejngDjQCIZrpkkk7bQW9NPbLY9v8pTdgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCNvrzHKMoTxP/aRL/j/Nl8hc9Jh3M2GNT6LOpkPiPI=;
 b=iVSLj/oHYfQF/F0Eef4jerQaufbUiAPR8awOJNvKJkvkMmYdUUAY4vl40UoE/dnWYovTKNUnT8dbfXbywD5M2vJvOVP/qLLwG7Gy4A1ydVHXaE8zyaOpaAp8dp77cI+B+B00VwpHWfjvaOel8AF20Ca6D04Lj4ClbSedWdLreLM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 11 Nov 2020 22:28:03 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 22:28:03 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu/vcn3.0: add software ring share memory support
Date: Wed, 11 Nov 2020 17:27:54 -0500
Message-Id: <1605133674-21093-5-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
References: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend
 Transport; Wed, 11 Nov 2020 22:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1618ef7-a9a2-41c7-e3a0-08d886910de3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27464D1F8899D0E314BDF4FCE4E80@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cS0Z6K8xXT8lqLcOlrncgy4enEXIUCfr1nLYfFK5nLs6IdlanzGVpXFONs04hFlmYuHecbX5ggdUZXzIzJfqx8urqOm9Ou+WgugQ1fkWRJJpzkizL+NaQ4chY8PGxNgINOLlSJYu7ZhOXFnbbcuJUR7O+XN6LjwgyjKmsW80L3yGN7YOvaZzthT5JUXD2w1RbvbPfmJv0u4Q36RkNxEjRARKt86Vam2i0D66j7UY9S80kFfYSV4VK0YEfKPG/cSMAaVrnYI5Kf9oVoEOC1CME5toLx1ojYmRwOnPk+ELgFaYB+5vXLZW5ucbLAhhI1eV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(66476007)(66946007)(8676002)(6666004)(8936002)(2906002)(316002)(83380400001)(52116002)(478600001)(86362001)(6486002)(26005)(7696005)(66556008)(2616005)(186003)(956004)(6916009)(16526019)(36756003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bYsrdmQYAaZnLeEi5rltmn1o5Q5vhsT0VuINj+ZaJH4mxS9ZnG71rlivi1B6hsb477AJRfjbzqXb40Vg05TmIKeLHxqflCy7NhDn584x3Y355EOoqpjFf4PzV2vySsOIRCMEi5z+V1Dsl430xLghy9Z4q3bnQPuzaeqnDy5XflREYPGO8VNnW7iBXKQdgNhKeCIDB0VDzQ/NIamplJNQqLriZ3cZWB4RQzxmlvUYxwKrDFlw86vzJ3YWeIVaynzymvMq+VlqaGziUr8nfzIhtuEaROR4uZ4YXHPoEXEvvpa7hgQ6lbX103hdOo4KNiosffn99hdXiBRlcRyWkWw5lfmXbZ6RKYFjxZ7WRlR3wZ07u2P34UnsTIhewxHh08XFInM1kZB4TY8aUOHTTMdv7nrspKBIqCJvPmCdQK2wV+msnNrcFGDOvON95F1VLm3z/Au6LJLwBqV6TrbneKPM96DNlvoERy3I0rSexPFpjP4Yj4UYLoJJK7X82Twk1DaI50QbTishp/oakc64GSuGFXt27xCRTf9fNn/CPTkcSWxD6IAhwmiXrc66Dgm1ecQ50rD5ESFL5CnPuTmXt+hiiGdf5MEqRgIt/bcbInJ5jYLChaz5fYP2rr0ThGvIB/Kn3Q0BPUo40PfPVJWLTimUEnn8nyidPGq8/ubgVGY8tScaX8y0J9g5RLGFkV8hLSbqTXYqZxexW3J2HG9ovLI0HDA5PyRFVhJVfn9NcKI5aT8m2SKjd35eWNv7GxuIIzXMplnJSUqWFxIyjT/qWM5q4b1yfmnNiy3PVHpQ70dsFrDVtO27AlgVAafuBT8RsmMCdVBeEimeIVcoJH7/B4LJr9RYP2yZ2Ib6LV7BUycrVHR5yHKxDZmKel3XEUTc5kf2c+a6dEyD53La4LfOPoHlnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1618ef7-a9a2-41c7-e3a0-08d886910de3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 22:28:03.6302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeWqdmhDjqbe2lP2ZpXnAZKjfShxMPtEbqJF0totf0mS7rzN04InxEPFjQgPxyCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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

Support software ring share memory with vcn firmware.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9d3c902..18a56c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -169,6 +169,7 @@ static int vcn_v3_0_sw_init(void *handle)
 	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		volatile struct amdgpu_fw_shared *fw_shared;
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
@@ -233,6 +234,10 @@ static int vcn_v3_0_sw_init(void *handle)
 			if (r)
 				return r;
 		}
+
+		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG);
+		fw_shared->sw_ring.is_enabled = cpu_to_le32(!!amdgpu_dec_sw_ring_enabled);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -256,7 +261,17 @@ static int vcn_v3_0_sw_init(void *handle)
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
@@ -466,6 +481,15 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
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
@@ -548,13 +572,16 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 
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
