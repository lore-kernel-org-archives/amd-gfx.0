Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D55C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 17:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D937464F02
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 17:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937464F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958F18990D;
	Mon, 22 Feb 2021 17:07:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB618990D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 17:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flHElh2HMO0BO7W/ML7DChfxFBPIALJxyQ9LApuzDLzeRk8JLG5fJiOCsevtSCYCsOqfuQIGUmLmMoPpfVKSqAFmna411Jxi+7Ld/YGR7hFzlxCoty3eb6PVmFCbW1GMSoOaVWNnOXPCkybEp9LRaYphTHYJLaSHAB2QrM4z4/s6B6B5deSdFip4uz6YKqRsh4M9nfJSNSWD/V1ChOIsnSCxq4gDScZ7jeOP3GJmgTMGtiIM9MtQ/nm6/TmQT7TfhCc+Ap5DUvEP9Pi85SCon8pcQ14PT/XnmnMYnAT7zjwJnJ3xvGsePh4shKt56G/4vqWHGAjMWVhvzD6N7wFAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKqor30a1feyW+DhexdMKFruc5R5ZuRQCoKrYc9KIds=;
 b=dKPg2pW4xflYzltXHqXaTDoNF0UFf0eH6m7WOz+dIhuJeHE+u/ikTR1ZQXu154zo5dnu/xbX3qGkhfYcNKNRpAB/rlXruGfdKx0+gxhu5w99nNWscizW0fsr0GEHNjUsRrEkJSE+c3Rz36ilVNz6Kq7Biaqa1jb5M1RXQ3UINFdafmjsPq/7TbnkJAnbf+HmJArF3PIrOjgXIQsnqFKuhOYX908O6MjOYkQbGUkgzTu3NFvP8OmZAemzxpm4oYU72KmrIQwkEuZ4I1UYigZdyLjgSy0Pf4ow5S/bAYpqcjnHAmzZ1+Hvr1JwB7Be0TFaCtd6F2ID9lev+LQLYOOMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKqor30a1feyW+DhexdMKFruc5R5ZuRQCoKrYc9KIds=;
 b=Sl9qeS77FZxDQNfIhApzRptu5aiOz1oo0Ze7K7CAmif+yhvhKrpKwDAXQB8Miv9W5IZxn8f34dKWduCRnOwOX9hHDouR1q9HqtvoRKyryOiR572gIJO/itltC0nnr2yeMM85ZB/xhiZt4U6kFiI6iytM6+IMPxz+yeduSxMeElA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM6PR12MB2633.namprd12.prod.outlook.com (2603:10b6:5:50::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27; Mon, 22 Feb 2021 17:07:20 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::807c:1f17:9a40:51a3]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::807c:1f17:9a40:51a3%7]) with mapi id 15.20.3868.027; Mon, 22 Feb 2021
 17:07:20 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share
 memory
Date: Mon, 22 Feb 2021 12:06:26 -0500
Message-Id: <20210222170626.17640-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [67.71.205.18]
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (67.71.205.18) by
 YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38 via Frontend Transport; Mon, 22 Feb 2021 17:07:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9513dafd-3415-4a79-9218-08d8d75450ba
X-MS-TrafficTypeDiagnostic: DM6PR12MB2633:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2633B299AEEAECB76C824B21FD819@DM6PR12MB2633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhTmYEuI+oKbL1XNUMpzRymc/e+CZmFbuDnQlCa4ytvFh+GGttprcvd9yF2cUmM98+tHAzTz9OpEZ8WAvlEC2K+M9KP2wxBjzNn+7c0vZTSCsjWyNU/XW1MTU0Wo1OP+e/Ls6rrgxBu+2Ow7wv+RkHniVDT61DUbWWtu/rWgDoyOjbWP9P9yluDSOUOQtSTG6iNcqiWEWPXiD2W21CedyWrFfnvqRq41rHeLq7ezyOIjOkMZ27T/KB9Ji6O42jXNeWV/suUk4LW98HSYSdtS5xxiMS9YJ86tFlmPYgHcFL0aIg/0bnp2NfgFo/kF32aA1VKLGJkmCCHQDnUoAxCN5wcYAc+46qWrR8QB1odyrIUvP3RljJMalz153IJYJAX9o9XQsebSPwN3dlmCprke2yJl7fSxlYYyylqFBb2Y4b1wSLhoSiVMjiUl1YAoY9lLjPhLI21kV8S62OlkAuI1a3H9o0ZT64nJzN9fZ2Egyf0DvUji831kXMQrlc4mW94wSy8i19FfQf/4e+gc+TT8ZurRMrHbTTAPBeIRCwiYM8doiLwBLhbiPTghKtUuclYu1kwmSvzYEa08QLhbIBd2TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(478600001)(6486002)(44832011)(4326008)(6506007)(86362001)(6512007)(8676002)(83380400001)(54906003)(8936002)(15650500001)(2906002)(69590400012)(316002)(1076003)(2616005)(956004)(26005)(186003)(5660300002)(66946007)(66476007)(66556008)(16526019)(52116002)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hF8MUcVvVZSi9opgB2ZdnfuD16SDQPZuNLnweD9NvhzVmmxFz6nAHDhL5E9q?=
 =?us-ascii?Q?TB3FVhvO8XuUl3FUVLxPT7ibeOIJkvFvVSL3betWoveHbA3DEnkixdbX0ZcH?=
 =?us-ascii?Q?3OfhZF3F6cWdMBKdAUQ+M12LNtS2aT7SagOmLwxUkAnYNThfgyhiH3gAZUOG?=
 =?us-ascii?Q?gNJ0llUDeL474vKeHcW9MnkHYrJJo2Jw8z/U0jhnT+ltg/5ShR3+tLWtnfy6?=
 =?us-ascii?Q?4OT2I1UEvsRrTt7Iz+dpUGZUUyug4z9yf4cQ8Kn/8tuuQEDxGsL6qeucHMaO?=
 =?us-ascii?Q?OXQsr322xYi2pIkUjETSGqTs0Fh6umJdvSN206SUbjohiSvzJg5AZVyODvca?=
 =?us-ascii?Q?ryJsbNK9KftIyGu55wHorDG9VzSC3t/97IhqaxPCaLKx0KqQwc142pKGTWWC?=
 =?us-ascii?Q?/qRI72HjHCGSvVG2EvMaUrOiqdzaV3md6CSO++3HKxeUPhrKDZqHfJAG5e2A?=
 =?us-ascii?Q?8DrI5VVs3UFex/i36uffvPQ8jcFyYTQXeI39VbhY8XopkI1mFQ/b1rmyZWdE?=
 =?us-ascii?Q?SAtrzx9SMYrOFgFXZEtVO6fZ3ub6ZSx+0EJ5M3Hr2+QePhrdIkjPhWsx7lcF?=
 =?us-ascii?Q?/zYW6b/PWJRXcuvunMyY4UW0F9jtT+9Dq4i6HYrmXyaa4ur9Q2Z4zCcKL4Wy?=
 =?us-ascii?Q?geMgjqByfO2dbzGmKJarR9qjemdGdWhfTgozxMFd0ps6fIvEg2eL/aAl5qni?=
 =?us-ascii?Q?FQLr4epJPMNaknFoSENsP3Y8QuQ/6xaMVkmYaC76TMEocCCpA5CB+gjtJ3TE?=
 =?us-ascii?Q?LjDbmouNONULIbEqLabey0ZfFMyF30Vb74TigQN9sWgAr9FX3Yt/InF/TxPj?=
 =?us-ascii?Q?tWE9sY/crx8m6NLjLZco5l5MbVW3pgf0qPXJWwBLFE7IHMzh0YbNOcpksxbo?=
 =?us-ascii?Q?64RCcOKVBcMVDJa6tGdFa3jZQVCH6ELk30CCeQPF5WwOuK5zqE6YWB4xkEgu?=
 =?us-ascii?Q?vPk3hXwkmAdQ7HVs8rii4TtiUYkv8YRoPFZFfMjzuimYp115pZpJW99hd0Rt?=
 =?us-ascii?Q?rSbrWjaWqHWaLjsacHSNFkWqY5vqQi0HV+Dw6MSdKSljYpmiWU9SF+jIVCsA?=
 =?us-ascii?Q?Bl9sOxK7iJPXVI+tFgsANjYyOHp421bpC+TDbBp0NB+L6fM4o4kuXKtluEF4?=
 =?us-ascii?Q?uZs5AGcbqkIbSpJViCGPyVsWcn+Hn17IdlOftObTOsl6rvbIYDIyZ0nqyKPI?=
 =?us-ascii?Q?ZQdjzhjtylveW3ndFJi4sMTxJ9zb5qQbaBlj23t/pxLGNP3FvPZ+uzhYTisk?=
 =?us-ascii?Q?EhpBV2wR3Fj5OLGidLJDGRTathR1HsWSepE81bV808JYqjfGp1V2DE3BAbXU?=
 =?us-ascii?Q?+kRybEcMYc5owVEask3uPS2y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9513dafd-3415-4a79-9218-08d8d75450ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 17:07:20.7312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx1edia1ePbY727OQTK5Mivk5BykBZB7fvAbyFzT7HBpRpfOVUa71/2IfAdwfloYpi6/1/1KCf2zSZd25K0jqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2633
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because of dpg, the rptr/wptr need to be saved on fw shared memory,
and restore them back in RBC_RB_RPTR/WPTR in kernel at power up.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 24 +++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 13aa417f6be7..1843bf8de0cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -155,6 +155,7 @@
 		}										\
 	} while (0)
 
+#define AMDGPU_VCN_FW_SHARED_FLAG_0_RB	(1 << 6)
 #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
 #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
 
@@ -243,6 +244,12 @@ struct amdgpu_vcn {
 		int inst_idx, struct dpg_pause_state *new_state);
 };
 
+struct amdgpu_fw_shared_rb_ptrs_struct {
+	/* to WA DPG R/W ptr issues.*/
+	uint32_t  rptr;
+	uint32_t  wptr;
+};
+
 struct amdgpu_fw_shared_multi_queue {
 	uint8_t decode_queue_mode;
 	uint8_t encode_generalpurpose_queue_mode;
@@ -258,10 +265,12 @@ struct amdgpu_fw_shared_sw_ring {
 
 struct amdgpu_fw_shared {
 	uint32_t present_flag_0;
-	uint8_t pad[53];
+	uint8_t pad[44];
+	struct amdgpu_fw_shared_rb_ptrs_struct rb;
+	uint8_t pad1[1];
 	struct amdgpu_fw_shared_multi_queue multi_queue;
 	struct amdgpu_fw_shared_sw_ring sw_ring;
-} __attribute__((__packed__));
+};
 
 struct amdgpu_vcn_decode_buffer {
 	uint32_t valid_buf_flag;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index def583916294..b61d1ba1aa9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -238,7 +238,8 @@ static int vcn_v3_0_sw_init(void *handle)
 
 		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
 		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
-					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
+					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
+					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
 		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
 	}
 
@@ -1074,7 +1075,13 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
 
+	/* Reset FW shared memory RBC WPTR/RPTR */
+	fw_shared->rb.rptr = 0;
+	fw_shared->rb.wptr = lower_32_bits(ring->wptr);
+
+	/*resetting done, fw can check RB ring */
 	fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
 	/* Unstall DPG */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -1239,9 +1246,11 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		/* Initialize the ring buffer's read and write pointers */
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
 
+		WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
 		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
 			lower_32_bits(ring->wptr));
+		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
 		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
 		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
@@ -1662,6 +1671,10 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 				fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
+				/* restore wptr/rptr with pointers saved in FW shared memory*/
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR, fw_shared->rb.rptr);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR, fw_shared->rb.wptr);
+
 				/* Unstall DPG */
 				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 					0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -1721,6 +1734,15 @@ static uint64_t vcn_v3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	volatile struct amdgpu_fw_shared *fw_shared;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		/*whenever update RBC_RB_WPTR, we save the wptr in shared rb.wptr and scratch2 */
+		fw_shared = adev->vcn.inst[ring->me].fw_shared_cpu_addr;
+		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
+		WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
+			lower_32_bits(ring->wptr));
+	}
 
 	if (ring->use_doorbell) {
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
