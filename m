Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555B4C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 22:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243E824653
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c+INVCG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243E824653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDC76E31D;
	Tue, 21 Jan 2020 22:22:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C9316E31D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 22:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/b3EPiqNi+tnl9qdVeJ2Cynl9VKd09zbn1034/zn/ka7YwUXrF7biD0tFzcKwah3M3OgwBicalArQEixcB+5Rt1qR7Sdy7zG3XCf1xTjOqgvgQnFqbCMcol0CPcBa3qSEyl6/V5D8BTKDbKve77khXN7xTb+ko9Hqsub/fbn8ac0mjjspFh9IF6I2S7wA2CsbGf6XJ+TZsJsqFZ//H9ccTYb2LoNqpMJGItgEijsOV1uQ6nuIwEpC4/sVgeBAPo2jguyu+oL0Z4y6iZlpnQFt/M8T604zIVQuElzvIxeDoNBPLBuJsg+C+Zk6c+K8kBnqfMVv+59snqiKAijCqG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGPHzn/AbMuacrTD+2vo3Ra+v7dmEf5HQul250MIG1w=;
 b=VKoi1tCQYqv9LBpie+wuU2PJKjdUz9fBXVaNPg9iRnFbzKCCMyojaBkGV38Feuql5Rm1zE6qMg/ucS1347KqnKF09JTY0L9P0TIfc8Yww7SOFdjrv24dUzMFW/3w3j662jJ58EWawbat+3H0WXleEJDzATjfuy0C/JlPH86k1cIGHCIR7gf6iDSeXBvu7ZP+0+W8Hneu8OcBnPGP/PNEgF7/pghh5JinDKlP14iqXdn4QPdy1MIWqYvOXQvkqAceOqNGW5tQGXN7UUoqd6K25YbRkq7gQsOj6graLEL3QCoP/9QLUwgLYMLWt2O1Y780yvbHG1qjt3nhaxdx5lW8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGPHzn/AbMuacrTD+2vo3Ra+v7dmEf5HQul250MIG1w=;
 b=c+INVCG3pxKdGXy/xt1Pj0FMYTsdB8knAlUKlN4kcIr+zVxNfzaECFItVziFL967BB8OVt6tk5Wpn3koDSGMSRwIHedG5r3eeSgleIml7VATMun/bvE1+6GqZpnlFS0IcLzYK43+AkMMwu6+Y3WXV8IDHY/EtTqquf54gIOn8rY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3528.namprd12.prod.outlook.com (20.179.93.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 22:22:06 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 22:22:06 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/5] drm/amdgpu/vcn: fix vcn2.5 instance issue
Date: Tue, 21 Jan 2020 17:21:59 -0500
Message-Id: <1579645319-12747-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579623556-30941-3-git-send-email-James.Zhu@amd.com>
References: <1579623556-30941-3-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 22:22:05 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 678b095e-e9c8-4678-b2f5-08d79ec058d3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3528:|BYAPR12MB3528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3528B31A7F3A4194136748A7E40D0@BYAPR12MB3528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(81156014)(8936002)(8676002)(81166006)(316002)(5660300002)(16526019)(4326008)(52116002)(6666004)(186003)(7696005)(956004)(86362001)(30864003)(6486002)(66476007)(66556008)(26005)(66946007)(478600001)(2906002)(2616005)(36756003)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3528;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uu+NtcBJFKipC7VztcdxWs/iZtlTefy2EBVuFV3QgSt9Dhd8/ogC+Vx++ruwFlhh4MOZudxpOU3zlI516xxaZPUrMHnArAYcOhonjXuKwntAXxWdQPv/g8QNnwdwBnlOC3xma44YoV1/qW7P1Pe/ZE2mb1CgOqsC6dUHREv6G832hpDxqWVlISXuh5lcsPH6QpBAPOypNK+ZWGssH9TyeeGrGAPbH4ULAnswitPLA6aArO8i5vQVN4HQMXC03DDLXDKG6CAGKf/yvka+BF2RDUvMo56AK7jlWURoUgiPkSFsg/+ZZKJ5vQddOAmco8d2q5JvXVwtU9sW5K+fvQx4IJDZwuGlVe+ZPtVw6zWqF/MXEjGP13YClbx5fccpW6+S6lqHjhTsLKS0VcA+KZtYDkFgqR5++DI8XKfAVWxVV8UHJttDMPK7h8nSH3G2vhXZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678b095e-e9c8-4678-b2f5-08d79ec058d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 22:22:06.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgYGIu/PeMZtSunY3hZklgKhaJFZN+r4TatpmbOPpTGCi1Luss9fyV2jc3NuL7dR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3528
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

Fix vcn2.5 instance issue, vcn0 and vcn1 have same register offset

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 88 ++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index c4984c5..bf7f2aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -91,7 +91,7 @@
 		uint32_t internal_reg_offset, addr;						\
 		bool video_range, aon_range;							\
 												\
-		addr = (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg);		\
+		addr = (adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg);			\
 		addr <<= 2; 									\
 		video_range = ((((0xFFFFF & addr) >= (VCN_VID_SOC_ADDRESS_2_0)) && 		\
 				((0xFFFFF & addr) < ((VCN_VID_SOC_ADDRESS_2_0 + 0x2600)))));	\
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 740a291..f513c6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -435,88 +435,88 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		if (!indirect) {
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		} else {
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
+				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
+				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		}
 		offset = 0;
 	} else {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
 		offset = size;
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0),
+			UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
 	if (!indirect)
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
 	else
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
+			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
 	if (!indirect) {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	} else {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
+			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
+			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	}
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+		UVD, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
 	/* cache window 2: context */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+		UVD, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+		UVD, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
 
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
+		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
+		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
+		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		UVD, 0, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 /**
@@ -670,19 +670,19 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
+		UVD, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
 
 	/* turn off clock gating */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_CGC_GATE), 0, sram_sel, indirect);
+		UVD, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
 
 	/* turn on SUVD clock gating */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
+		UVD, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
+		UVD, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
 }
 
 /**
@@ -772,11 +772,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* disable master interupt */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MASTINT_EN), 0, 0, indirect);
+		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
 
 	/* setup mmUVD_LMI_CTRL */
 	tmp = (0x8 | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
@@ -788,28 +788,28 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		0x00100000L);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_CTRL), tmp, 0, indirect);
+		UVD, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MPC_CNTL),
+		UVD, 0, mmUVD_MPC_CNTL),
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MPC_SET_MUXA0),
+		UVD, 0, mmUVD_MPC_SET_MUXA0),
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MPC_SET_MUXB0),
+		UVD, 0, mmUVD_MPC_SET_MUXB0),
 		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MPC_SET_MUX),
+		UVD, 0, mmUVD_MPC_SET_MUX),
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
@@ -817,26 +817,26 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
+		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
+		UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
 
 	/* enable LMI MC and UMC channels */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_CTRL2), 0, 0, indirect);
+		UVD, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
 	/* unblock VCPU register access */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
+		UVD, 0, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* enable master interrupt */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MASTINT_EN),
+		UVD, 0, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
