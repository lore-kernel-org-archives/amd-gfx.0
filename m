Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E31CC2BAEE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BD520749
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TASAppDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BD520749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBA06E9A4;
	Wed, 11 Mar 2020 20:49:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6FC6E50C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 20:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGXML03OnxU6MunJPhpf2AniPRJUy+t0SKAXUhDdEvprCS0ninv/vgLeayoiT0a0Mg3Cq7kjs48CpU4ToxPubt1ZJ+HrPpSfZu91MY4eGLe3uwxmPCAWMsfAj1wQ1P5K08oQ79muIgayXqPgIULqVdiy4341BCQ6DVZzMtwJ3clRqEu21tbnX/1CnV+ZnzCV4yb3zVnVToiObvzJg5ck5/w25XotDvo50xsy7tudrJjzNPozcR7iygI21Tcj1tHu9/a1hva3ftGacVGulxvtkk2uwAjxA3JgJq0h7PKJRRYO/PmulrgIF/zBNL4VTF1xT4P2zRMizBUIk8zXX/bKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lezLnRpAIOBE5iBMs+x8UbvGtUyLl4VdSrN06Q7g7c0=;
 b=GUU/enqDJixaoHaqyPo3gooRS/bVgmoyWvw3ZCa8AOaOJfomXX5MfZSiXmAOzFElFJ/cFn7MaIM2fNXwZKHj8znF6CeZOnHlUu5lQ7FXsGk/iZCT68OPc6hXrO+9R6wtNHvMwFTKubjNYN/RvkTwbSZKUxyRTwA+I/gRf2v99qv9rgGiQhPXyXeKwFD0bASKwTUKzAb3DyMSVMWqfU4vehcV3Z3yjxNhqpcnVm16o9yWgqji9XHei/+S1IvJ8rNbbQLYdgEGLm1dISsHy0YAwZ6YZzattJdS2d/zneyZwHm2D5M3TmUfC1yEPhLUeOhrB/kqlQmzfKzCEL1nQ+WQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lezLnRpAIOBE5iBMs+x8UbvGtUyLl4VdSrN06Q7g7c0=;
 b=TASAppDIu9cN12tktA/kkPuTce90Wwrcn/fa6zwi23jbH5JZIO0V9cw/usaioHMcPE2CA5FkOz4pfezqLDTsuZ9dOxYu/yVtROVuuCQlcE+r/QhUwOIWBldj2P4Sr+nKxPZVwTOHBoJdeX7YXW8wZ2zBgIzr43bObcwjfaQQIiY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 20:49:46 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:49:46 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 4/4] drm/amdgpu/vcn2.5: add sync when WPTR/RPTR reset under
 DPG mode
Date: Wed, 11 Mar 2020 16:49:34 -0400
Message-Id: <1583959774-16570-4-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583959774-16570-1-git-send-email-James.Zhu@amd.com>
References: <1583959774-16570-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 20:49:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 186c6fac-9871-40ea-b79b-08d7c5fdbbae
X-MS-TrafficTypeDiagnostic: BYAPR12MB3079:|BYAPR12MB3079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3079C5D94353BE301ECD533BE4FC0@BYAPR12MB3079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(66946007)(26005)(66476007)(4326008)(2906002)(66556008)(6666004)(5660300002)(7696005)(52116002)(6916009)(316002)(81166006)(8676002)(478600001)(6486002)(8936002)(81156014)(86362001)(956004)(186003)(2616005)(36756003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3079;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvMGPcbJrur7vFX+7QjPBRmtI4tuyW3jujsOMsfJm8L846BJ7HVjt2EX+tHl0m/KeLwlLeEKV0IUaR0idpk6N4uQaDQpDsDp6Z8z9mpu2BvGhahRZbfmPkm5LloJvn001qnaP1Y9kP8S/ygRuosFOqFQZl2yaRTPyKHwFF6FlqbTH04rEunFuhHnfNBfqF2EyKnBHKjbvmdW9NfUXSoKrvM6YIS9GfsSOKL8+eaFjVIOuBNUv4xxNSJ/sUdWUvcCZ1eGPTzRpo4NpA2R6zPMHV72K2Frfd0B3Dub2+oc2pvtDZTa9IZWoxc5vO0kp6dLskIhT7nlVqofKhxb2MlTKrWR0IquZSzzIRH2Ujy9N1eoZyHKq+iGCYqGheqbY5eDocGZP2sM17ua6a4laHMTnvTrd00BYJ/K+pqaGmTa8RdmuMld3GK6IaigoPv4k2mI
X-MS-Exchange-AntiSpam-MessageData: YGXC8KQl5UqsbT3aBt8uKrzwJ7NkqsOvC+z9jbCanqd/grgnr7VV0pSyE/OpVw00IGTZ79G9KtnxTE1mznt72W11ofIkj+4EPRnyqlN/eLNxa4fnyX9qU9GLZ6fMU+EGbMwCxkkEvA5kJ27bidib/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186c6fac-9871-40ea-b79b-08d7c5fdbbae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:49:46.5060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5s6Ka2yRaGDNc4tO3k6FkHWhlA/ujyDv+yqgrA86ZI3lLAsop64f+m79mEkxmxs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
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

Add vcn harware and firmware synchronization to fix race condition
issue among vcn driver, hardware and firmware under DPG mode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <Leo.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 9b22e2b..9793a75 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -868,6 +868,10 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(UVD, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
 		upper_32_bits(ring->gpu_addr));
 
+	/* Stall DPG before WPTR/RPTR reset */
+	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
+		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 	/* Initialize the ring buffer's read and write pointers */
 	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_RPTR, 0);
 
@@ -876,6 +880,9 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	ring->wptr = RREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_RPTR);
 	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
+	/* Unstall DPG */
+	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 	return 0;
 }
@@ -1389,8 +1396,13 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
 
+				/* Stall DPG before WPTR/RPTR reset */
+				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+					   UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
+					   ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 				/* Restore */
 				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
@@ -1398,6 +1410,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 
 				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
@@ -1406,6 +1419,9 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
 					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+				/* Unstall DPG */
+				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
