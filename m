Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB2C64E7A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 06:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAB3206E0
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 06:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAB3206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123496E093;
	Thu,  3 Dec 2020 06:23:52 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362586E093
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 06:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCzOHWODldKLYAAcIjJIdogc9VZBLNbMbB2xAtao3zuUd8WQoaLwzPd0Y0uJ+bO3TXP1VobsfxAh81IExZ9T36JuGBKBVgq90NgyH9uGIO9c53U9rUn3/1Nx5l7PRLWbcPmbUecvgSVE44w2mYaiw1PquzZFmAQvyt/LnIRIyJOkvg67BkmUVY+UxaFj+i3XFzOPJY0/IO81HfOKl3klVjmsdt+1IgmQ+gj0agwYNbbhx1n4ISf3inHncyKLHgBaceV8ueSbkKyOIbReeQz3cAyWvviJE3Ug1NOca2QINh7ccHHzLPIPSbFtUUrgH8BAzLhL2WpmYjCaHbdmuyfEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bub1yxdXMqDuqi9cYRwalVbCMqboPJnC+bN4aZZajg=;
 b=JI99JdgFBOCmF+IeyCF04DiOSJ0/PJ9gl3ic+gIyg3LVwB/uEB44xzWwoThxKrHUgERDCJullYke1aGALg+8TEPoyOuRAtP/3ExAQ1F3GrjKERO1RuM58Ug7Hoi0OHP39i9isEtZwk5UQ1dOvMHMvThQVTGyxKOxWw/Xm0Qh61H2K77aNgbOD3vc2/URB4kHK9U5rF9BRx6KCjdweyWt1zlieb8N5Qq+h6S/OdmtquToRwYpReDfsHNG1NMd4TXdCMj+0SAPdUp2uDPvFjdKKpgJLu2U12FA7VMXNADvfdphs4j90+j57eKdW/V3AFw9nJcQ55YdLozSwwrQ2VIX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bub1yxdXMqDuqi9cYRwalVbCMqboPJnC+bN4aZZajg=;
 b=ayVY1kxmZhkKTML41uatJd0AcyuftVVGITjc1oPjEh3lKxfBwgTq1D6cbVf5JvVuXPpTO6TDBWnDZgR+Aj218orKhSiLnrGcm/4I/vE/aBiaM3rr6NRPcMmsj7lGHwnemGqvmzFQ5fEU/h5hCRbVhtWmeLo1w4LlmjqNx6gJb0Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Thu, 3 Dec 2020 06:23:49 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc%7]) with mapi id 15.20.3611.031; Thu, 3 Dec 2020
 06:23:49 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: VCN 3.0 multiple queue ring reset
Date: Thu,  3 Dec 2020 01:23:04 -0500
Message-Id: <20201203062304.3421-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:404:13e::11) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR13CA0025.namprd13.prod.outlook.com (2603:10b6:404:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend
 Transport; Thu, 3 Dec 2020 06:23:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4dd9a20-d0eb-41ba-a7e3-08d89753feed
X-MS-TrafficTypeDiagnostic: DM6PR12MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44505E4F04CD4397256F2CBDFDF20@DM6PR12MB4450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hq7tpuviGbo1LLXdEtJk69MhsZ/dH046vVq7+A0WCYWYa/gc2qPIeIZtpVyfkE++1do5QJukqWqU0NpSpyA8jv3UZsMj1S+VGiT6NxRWjh1XQ/N726HBCtd6rpuEO/c/WSTOPyX50T8Z1BNTJaGDgvQl83F42ie3NJ/PUXrsRsBQYLceuOLFg0BFXSJ9kM6KohdmpOik/8K1AyN9yx1X7izt1oFTKT3HwyDCFlgKUyNGeTtscacUHP3dik47qFTCeEAVzcNVhE8mVZ/Yc4jN4dfxk6cMV3bz1Y96Q7BBhQ8LX80I42GWOZD5AbbT1jyZVm+WdTp4TiQzuRJwzluuO5y0ikqU/v3Nlxl5psjzohoDGJwdEIw76MvqadOVIRzf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6512007)(52116002)(4326008)(69590400008)(2616005)(66946007)(66476007)(5660300002)(66556008)(6486002)(83380400001)(6506007)(186003)(16526019)(26005)(6916009)(478600001)(1076003)(956004)(44832011)(8936002)(36756003)(8676002)(6666004)(2906002)(316002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?spHN1gFU9SPTOEs6px5OnqCG7lrpSyKzzFleeFlZvqW8XvtbqX1c4OSlOahP?=
 =?us-ascii?Q?hU2eImc5W2SDM7c9iUqVeGo3H9y0U0mauhOntIx+Cmh7DCIZ1O6iLmfhLqkN?=
 =?us-ascii?Q?7MkSQtPltTT2cQraFmh2IVA28NIb/ThDxzKY+5EPa8wfSA1cKiy6BGo8TFQK?=
 =?us-ascii?Q?v7HtxMtmpBmDHLAjn4CTFC6snWE5QoKYVZBLHD+1oX0hl5UB/UAeDg5Tbx89?=
 =?us-ascii?Q?/Rl9QVW9ZJEUvy7fodBl66+X54/FUMyUNk/RDs8bt8rKOXV7YhgeRXed7aDe?=
 =?us-ascii?Q?hFMdyUHUCppeyKh7CEXFQas3hejjUkiSct6/oxN47zqkl7PF4MA5sO97zUHL?=
 =?us-ascii?Q?4Pr9ncKOdzOyLLqzy33zp8sZevorzxSxSFX88A+fc7QLab0Lio/MVfrwndbc?=
 =?us-ascii?Q?IoXHF7DEkqyFI10PYowbLh4tCgaINF+ksOqXJEibvQmvq0pT/CgEF4rLZbc0?=
 =?us-ascii?Q?d6IJeeoJTwzT9uigg5OVlyDtN1CLWz3r9KMaGWQCwCWTDwKovRp2rIJSMiDD?=
 =?us-ascii?Q?4n6mf00S4i4/bMleXjFW7Ef9Osvvhh0FZCCg2Mzc7CgZsT966ns+8nk0Tdwr?=
 =?us-ascii?Q?f53mdy5h0KUUzv0SH/WkzxJnzMtZoqTEou1Omdeac6uCTHif4v2AaFXhlypp?=
 =?us-ascii?Q?pkH0PrdrYAjKVvzwmIB9hklnAk9j2xaQe77WDxxctLiAcHBPSL+4th2xTQIw?=
 =?us-ascii?Q?W7o2oOWJ2W7tp+ZGA7TChI/qFKzrBiBGhU74VJ3B3DcRRI7ktAPUhVClHff0?=
 =?us-ascii?Q?Iw+wE42E549pZ2eBNLrfJGQFBBoTbo2iRyVTJyX674YYs15dhkATcDUy04db?=
 =?us-ascii?Q?ftKUdwopvUx0dUppqp322ipH/s/97PwZEWKxfEFFmzsVk+Y/EcFE+y8M3sRU?=
 =?us-ascii?Q?YqUxHY8zh5vzYcNNFLxnl7oU7Dg14LevcFIR0YVROp23MhTvzGihYca/Lft/?=
 =?us-ascii?Q?E7Wov1JmFm78uqmQhwXUIlvKKte/mpJg592MVlgMk1olRZSJ6Urugok7TEMC?=
 =?us-ascii?Q?QaLu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dd9a20-d0eb-41ba-a7e3-08d89753feed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 06:23:49.1570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhrsV+XxO0D/GsRRBf+5o+gVqLlIH6DnS9+J7P9T3IM3Ybj4Yb+OmhwLl0r+InOecApse8oM9lV8uotIUveJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 4f718ee803d0..3eaabcfca94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1080,6 +1080,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 static int vcn_v3_0_start(struct amdgpu_device *adev)
 {
+	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
@@ -1222,6 +1223,9 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
+		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+
 		/* programm the RB_BASE for ring buffer */
 		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 			lower_32_bits(ring->gpu_addr));
@@ -1234,19 +1238,25 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
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
@@ -1595,6 +1605,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 		   int inst_idx, struct dpg_pause_state *new_state)
 {
+	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code;
@@ -1626,6 +1637,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				/* Restore */
+				fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+				fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 				ring->wptr = 0;
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
@@ -1633,7 +1646,9 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+				fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+				fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
 				ring->wptr = 0;
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
@@ -1641,6 +1656,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
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
