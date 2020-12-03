Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B6C4361A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 23:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F06223E8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 23:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F06223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F9E6EC63;
	Thu,  3 Dec 2020 23:10:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDAC6EC67
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 23:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhndHKEpUvGST0r45uQ93FjHBEp3yNgtesRAXXiZUVZlXP/Hn8xHrZcKutKtOYxm/TAnV5/JDcyPyOAhWfmQQh7RtPzS8LmjeZGe3XocMUWFWsphqjtiFyDkYjJC8tA2iobz9S35IXEzaehnvMyxChvaDLl5N4EZm7cpEpXoPsjUs60Y+48mqg2GWE4RquFYKOHLfOmDbjND9INI+vpe2ervPBU9O54LQMrTsMWQ6T54MS+WDvHMWYeapdW6Yrc1zvI0zqJ0TCpuqiXysgmW6iAa095LcMezgXpM53EK0eTbNxVyQFxUhS3fM/YAP1zaTjINzcsTurOKC1c7VclwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FojEsEsanqc4t/dgpWrwhUHoqBUEr2Xy2NoDouHQheU=;
 b=oQN46P2/fsOWsTDLIkzdLy8x3/IhZXh5/2C+tyOmveg6xup8rv5jJbXeWPM/vAWz+7IBt9ewyqckQHgoMIY41t+1OWmaVQQ+OezcfaEjcFWcGGcbLD2FTk3t+9cvDHKZk33VZZe5yRVoGPKRzQFgIVyZDu1ATNegphN3IwdA70z4AR08J7eUClHZXwNlhMZCXcQ0Uj0rurRb7P6/FJFF6WWVicSkqXLK5EukUsLB35Wyl7k7dD1lZ7DjiotgHYtlIpupu2XdK8zfkWDATvahSjO48a3RQAFlgGqlqjgXkLvKCxYcqsgcy5ld3i027jugS8/2/pHjBWg097ADsKZr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FojEsEsanqc4t/dgpWrwhUHoqBUEr2Xy2NoDouHQheU=;
 b=xex5tDhDUU6vfNrvOtmxtzsmkezQN3mdotU74v8ddUXEr+m+JAgC66E3IiTN4rf8r5DE1qMLwgt9sJJ+cMLyksjwW9n8raS9bkNpKBS9urzU0vdqMAU34Z648wSWj3WpgcaZQkm4wtirnF2uV5djMEv/piMKb70i6+f3yVSIA04=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Thu, 3 Dec 2020 23:10:30 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc%7]) with mapi id 15.20.3611.031; Thu, 3 Dec 2020
 23:10:30 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdgpu: VCN 3.0 multiple queue ring reset
Date: Thu,  3 Dec 2020 18:10:11 -0500
Message-Id: <20201203231011.3165-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:404:13f::27) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR14CA0041.namprd14.prod.outlook.com (2603:10b6:404:13f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend
 Transport; Thu, 3 Dec 2020 23:10:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d19d8ed3-2d7c-425c-6430-08d897e0a0b9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1321E8C7AD0EE9473597682EFDF20@DM5PR12MB1321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8HL0P8xNilVxocoo31QrK5n4IOJltrKNFYd1A0jvuLjitAluvwRB45VOWnluUR5XdKF76YsYyV75RhR+Y1qP+xPLc/kWQZqryq8Nd52a9z1dNTxVReAIIa4a2Tpp9FHo86mmMMMeHvSkzxRZlgCDxlyEBoQfj/e+hu7/IjcYxvFv4NjWmgNS/pceVbCrAvJCEG6yAHQYRnSBDS8RIwOYNJhDTw8YHrz+30rSLkYOQYp3YIiHUDmuBOacIj35+xrq/3DEbAVOfFqurK8oFthcI2CCVoOs6kJnhZ42B0guMlA/LqbvOSgNPwC+Xu556Wp40XWu/Ol1a+1G5AA2IYMWqxrJGC0X2tLyUIWWfe9COTDxnLPyCW30dwWbZVkLUQZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(6512007)(5660300002)(6506007)(26005)(16526019)(186003)(8676002)(36756003)(83380400001)(86362001)(316002)(52116002)(478600001)(69590400008)(8936002)(1076003)(956004)(66946007)(66556008)(66476007)(2616005)(2906002)(6916009)(6666004)(44832011)(6486002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mkFuN724ENtE9dVZVfASvXWGO+gAN021tHMy9jfNrRK5O6qSjHIhDaM4ruRR?=
 =?us-ascii?Q?zZ1KC76MODNLqTJwnW3eN9lArSMXl5vSgFXLZmd2/tir1qQuoVlJzjE3ub2e?=
 =?us-ascii?Q?KPjUgN9LRIipXIJ+Y3l46qXCIx2GnklEsp1tu1jVACtxgBAH/uwIMbHqYRyw?=
 =?us-ascii?Q?Z5t90v+sTQaw1Y/1+A+Ucs3B1k1AUSaXTPVpgDMveejjDfJ28l91a8uK8tVc?=
 =?us-ascii?Q?f+L6BQWazBsB+F4ESsyYiEbDYHabnqmNa2zb3k/iACGPdyarkEy63fxC032k?=
 =?us-ascii?Q?obmKtyIL13kSR/3aXArhUtR/0RzTXcXwZffLlIZM+wUoDwAiAqCjdee6IBrU?=
 =?us-ascii?Q?YCxw/11DtKcViSGMMf+lGR2B2fwLHtPdRxgSlnTdEPTV/xzuqrMffhh0u10Z?=
 =?us-ascii?Q?bZKlh+n65YwVdFexA1ELinVjnoIUUekh2Vj4q8igd2rsRadVa0OBqSyiyAQ2?=
 =?us-ascii?Q?NASi552Ko9or+eUfp+iBOqR4dVwQuYC193uIsLFykCAefK7a1PRm0dU8/4+d?=
 =?us-ascii?Q?9aQNhxDG6o8iBWPR5996SwrnWzidvqmK+2VE1P/3XLadw4R4I9G7bDXsqRQx?=
 =?us-ascii?Q?BMNBjI/OiAzcDRMYFQHpQCOfZf45S5jtA3pMH8f+23W/zpBuLJ/FBy9gtIr7?=
 =?us-ascii?Q?y+MGaGUk1TRNikVFnes2MDM5PQLh+ekFJxAQD2DpKWFgWO9kfbf5ev+GsYoQ?=
 =?us-ascii?Q?GfYhtboXqdsdiZKq32nat57fsRNrBJtLtuuHf8aQMn+IXjB3i+InXruAo4mw?=
 =?us-ascii?Q?nqiHv6dsfmowpm+8xTcmUGpTZrJMU948uZPATwdFlBoZCk2waD4N7xaNwUFB?=
 =?us-ascii?Q?lsfzI5GW/zWwvgaMDd/gj/Ra67rQQZYuja3s3wmz0rmBn6pQLvk5+B7pYLYz?=
 =?us-ascii?Q?JM5RgsSIw+tj/XoosKFkHNic33PKP1whMPoUJhFbQWBH7kfl55RSTIs+SoFD?=
 =?us-ascii?Q?XRtB53o2wbKJ1mURmgGGNj1g/5OERfL1UUFwGeebaBaX9KoVwDldxYoJwtgw?=
 =?us-ascii?Q?29i1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19d8ed3-2d7c-425c-6430-08d897e0a0b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 23:10:30.0516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BIJeWwij3Rb306izA80aB0KrGgoPB87oVADaC7i7c47Bg8t8+boucKPQmFgedfx3f7DxPVXzxf5jZX1fdDi2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add firmware write/read point reset sync through shared memory, port from vcn2.5.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 4f718ee803d0..aa1c92de7a80 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -237,7 +237,8 @@ static int vcn_v3_0_sw_init(void *handle)
 		}
 
 		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
-		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG);
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
+					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
 		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
 	}
 
@@ -935,6 +936,7 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 
 static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 
@@ -1048,6 +1050,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
 
 	/* set the write pointer delay */
 	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR_CNTL, 0);
@@ -1071,6 +1074,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
 
+	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
 	/* Unstall DPG */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -1080,6 +1084,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 static int vcn_v3_0_start(struct amdgpu_device *adev)
 {
+	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
@@ -1222,6 +1227,9 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
+		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+
 		/* programm the RB_BASE for ring buffer */
 		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 			lower_32_bits(ring->gpu_addr));
@@ -1234,19 +1242,25 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
 			lower_32_bits(ring->wptr));
+		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
+
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
 		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
 		ring = &adev->vcn.inst[i].ring_enc[1];
 		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 	}
 
 	return 0;
@@ -1595,6 +1609,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 		   int inst_idx, struct dpg_pause_state *new_state)
 {
+	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code;
@@ -1626,6 +1641,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				/* Restore */
+				fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+				fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 				ring->wptr = 0;
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
@@ -1633,7 +1650,9 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+				fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+				fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
 				ring->wptr = 0;
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
@@ -1641,6 +1660,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+				fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 				/* Unstall DPG */
 				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
