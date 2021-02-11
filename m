Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C07C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 01:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FB164EC9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 01:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FB164EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A1A89E47;
	Thu, 11 Feb 2021 01:31:59 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680041.outbound.protection.outlook.com [40.107.68.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC62789DFE
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 01:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay/hv6xolu+XcWLl5y5QEjX6vkJ9YSS8DAPevotUgCZCPAnSTqRRgmEf5b53VyiTiCYuqyrh3GbOawWcjPsrfqsybBMUWpxU9A/O+YGxWP3TA9owjF6kkmwcNo10dwemQJj1CfFK6P+gce2+yaGIzMGWHlbBLLCSnVi8Lq+Y5Lq1sx87scsjNOhsGoMDVY9DRtJc3Ke7iVTViWA20kJiw8ccB7CVf+wBUpIDrwkTg1ErsJiKE+3VyIJJ8p59HYuNKII0sbmRJUi8JbBCwhbb6vaU5TT2tsSmDTsmFgznHTPsUnbwSvKzAdB7ca6jwHfvcUkbaaWrEWej1WcEhlLm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BS+b/QvBPPYettGgSx0NSW8IXlyP3l8QyYq5iWOMQE=;
 b=Cw/Do7UolMmE/blqte44g09HlSRJdxrzgPfw22xkUQ7vjqSKfcJ6O9wh0Jlz0Vjz6co0YfYWtwFOOb/Geky+jYMYZJkRJo+z1XeU7cw1PrYEUXFQeZOZ3wk1U+E8+kCOpTZwF7V7epkG5Tkj1Ky2t7a3QVn04hpR2jCFDf7vdy58D+eXcHIfk3IjxSVgD5dtl0CdvgFYgaZuTS1t1g6bx9uk1bBmf7RRFr4QeoLkMhz8p51obenetxB/gWWxeU+ls8I3qSuh3qBgXxjGpbbRR2oKSSvLrexNBZTrwqd0GqocFI14alRQGkfwcCvoHc3DXyhUkA8xLxKlQwB/XC+z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BS+b/QvBPPYettGgSx0NSW8IXlyP3l8QyYq5iWOMQE=;
 b=SJ24+wy7fUWpeq9HQ5o9aja1FietoJU+xd32H+XBD1esd9pTollNbWTWXA5Uqp339YaOAlWKhgyNzSaJxCFMzY69A3uPgT06xoVgIRIfaTRWhjMEEA+FrMB/BvqqNVF6AEsXtlsbfGsJLBWleEr0iwKxpH8DXIv/Juj562vNoV8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM6PR12MB3065.namprd12.prod.outlook.com (2603:10b6:5:3c::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.24; Thu, 11 Feb 2021 01:31:57 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::9d32:b262:3e68:b951]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::9d32:b262:3e68:b951%7]) with mapi id 15.20.3846.026; Thu, 11 Feb 2021
 01:31:56 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share memory
Date: Wed, 10 Feb 2021 20:31:09 -0500
Message-Id: <20210211013109.16781-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [67.71.205.18]
X-ClientProxiedBy: YQBPR0101CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::16) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (67.71.205.18) by
 YQBPR0101CA0173.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Thu, 11 Feb 2021 01:31:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 698ef785-e9f9-495a-201b-08d8ce2cd1ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3065:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB306539859DFB32F23AACC557FD8C9@DM6PR12MB3065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdkzL/Uj0nxGueqHksI+gv+Nf8SQpOC2DYWc5WYl65x9YNpZykr7Ac51Mur0HsQzYTRxqBSa16M2bnPkPuFmY//CH7Y69GVSuRoK0s/4vbYkf4fg+2KwWsoXY9ZVo0+X/OX/Y8jZ0H+qXchEqDMBRUaOcuj5C7ictxaQK81U4RqFB29LqZkBa2fscDpK5gMAmzJrhRiPMi932AOQ/0p+i0fsUdjxzWlsTT+SVC9bP4vVp5QLiWZQRSM8Wt/V/3kT2xCnh/phQGrmYkS+vZ/6Nmx06JjVSp/39MYJnY85IYRUuhqGfPA0xmsu5QeHd1CVvbRnQE+ec0UPF8Shjnx3IqIPf2b0sdc2aoUEkDLrlKJGG2mhQIi597vUZZYOBd7ZNKKcQx974OyRTrcE4fXw4vk1eVj3HsiYSyt9e7P8KCfY9/hO3ZZdJETk12jjOIfMULBxwH278GXikStLqJHlqbNu499RLZaDP6tE+gPV+rGwEOI0O0ddO6/Y716NntTSajcaePFrjIwlz1k6qceRVho8uwhpd/V4HLB66NOjbS/Ao/pI1WFi7XqQMRIvyxVnrI5c/uHfbyS/4xSAvYKYMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(83380400001)(6486002)(15650500001)(86362001)(2616005)(2906002)(36756003)(6512007)(69590400011)(8936002)(6916009)(26005)(6666004)(8676002)(44832011)(5660300002)(478600001)(186003)(52116002)(16526019)(316002)(4326008)(956004)(6506007)(66946007)(1076003)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SNAuEuT5+RXwe0eLlpV/OQ2COaMVLYgTGnZpWauJXc+KZkPcy3/pF69bslwL?=
 =?us-ascii?Q?FbS0+Ul5in70xO3K33iXVLbt817ZW9iAQPU2/haoafQq9uKgcfezYsGqHllI?=
 =?us-ascii?Q?loBcmBxVjfzujU9M0ydleueXkjqm4re2iWQzs3zewe/CuB169+InCy3/lWRc?=
 =?us-ascii?Q?RGKKHqf+Pf8AJSJUezPuJ1WBANbT9oL+sPQIgXix54Bsrlv4AEwI42WB9c1W?=
 =?us-ascii?Q?C0/AVG9WRuDPbgbkUvabOpiiGRcVjYwHT97sak2xMz9ucoWjEgEgxGP4z+gx?=
 =?us-ascii?Q?x/yViQerFkLI8JkIjvBy3YzSyFIwESNssyqEi4W1hikaGWpHu0GLPF3z1H//?=
 =?us-ascii?Q?Aszy0in3s7vEDx8IgECKgaFWdBu6yOokTvjfptfafyMPwcMNiCBWAe53cxd8?=
 =?us-ascii?Q?vXZbcC5qjat4NRfN5gwS5/L843iN3ZluO9l3bQPkvq1lyWdB78tqjTYtqRid?=
 =?us-ascii?Q?krTi32PE6mrBtfbSp0f06rJ535IH8et1ahuMUuzach7llf5ciT03hWBaFfx6?=
 =?us-ascii?Q?xXcGwJ890XSOWD9fkqDNIxTJR3IbuxAQG5P9FeG4lu1q5sPjHQPr1LhX5P6O?=
 =?us-ascii?Q?AwIxQM2sbfP2cXMygNjH5T2iHV7oIN5a/wUAEHwz4p4y1BQ6ppkNjDOsd2u8?=
 =?us-ascii?Q?lcIRpEA6zrA0oB+spOYd5YD2uSKHOHGGxTMGKKOmOnyNDlpoxFHQZ+O88j0C?=
 =?us-ascii?Q?Wy1uTvQRBZ48waC18d3LefnGsS/hntfe0B2iqn27euQvtP+k2qJeCvAqpuFN?=
 =?us-ascii?Q?JABHyV1HJY4mzf44vej1xDOIXVbBJdtiWnOkjG24EiCPr32K2u15nu0rbeS4?=
 =?us-ascii?Q?o4z090783EimUKjnYL9XOm1Mn6oaSH81pRMEZIo8vpIIn4roenSI9MOTp3ME?=
 =?us-ascii?Q?DJeJl9zyG8kIcLCc4BCW3UdrSX6u42RDl/oTnhfLCqvseiMlnDvbLopGrPNA?=
 =?us-ascii?Q?deNFU4OJrrmkRkP3yV21AvRjX7jfNnn7AbyL7Ks9r0FONnx3iIUsAl1NOUDm?=
 =?us-ascii?Q?HnvpJPlDp4B9rcISMqetB8c4TJ6UNvkEVlpg3dOp/YK+OGNPdHcD8FvV1jX0?=
 =?us-ascii?Q?gbUmcys91Yfp6N5brwwCBLtdtJQhV+C5PwqUFUfyeWtNqYpIAlw7Uj0KL2Mc?=
 =?us-ascii?Q?pzisREW9ZfafZJgRRfBB7MMlQ9jiAYrJnXHyWpSNxvyBMBm9WQQcfUCcwBC6?=
 =?us-ascii?Q?iSIyhZm7dQircK/WN24CN2AZ1PZt8qTZa8wt7VL1p/Ljqs/0c+VWmqL5PL6d?=
 =?us-ascii?Q?Irh6INrGp1IqOUmLhkNWeEngystLeTm3gS2J75w0pTb4YB439jR1mrpyi9/l?=
 =?us-ascii?Q?OooHKyenz7ejySK1ZzRYbt3J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698ef785-e9f9-495a-201b-08d8ce2cd1ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 01:31:56.8453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xo3dDotDYkI32tmVTEKAhlIDUTRLd2IpPSN2U+tVEj0ZR/5ox1i/yzFz9ZW+WrpJ8LDIiX80uM87O7MQjB6tJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3065
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

Because of dpg, the rptr/wptr need to be saved on fw shared memory,
and restore them back in RBC_RB_RPTR/WPTR in kernel at power up.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 24 +++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 13aa417f6be7..a19c0c35e2d8 100644
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
@@ -258,9 +265,12 @@ struct amdgpu_fw_shared_sw_ring {
 
 struct amdgpu_fw_shared {
 	uint32_t present_flag_0;
-	uint8_t pad[53];
+	uint8_t pad[44];
+	struct amdgpu_fw_shared_rb_ptrs_struct rb;
+	uint8_t power;
 	struct amdgpu_fw_shared_multi_queue multi_queue;
 	struct amdgpu_fw_shared_sw_ring sw_ring;
+	uint8_t padding[13];
 } __attribute__((__packed__));
 
 struct amdgpu_vcn_decode_buffer {
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
