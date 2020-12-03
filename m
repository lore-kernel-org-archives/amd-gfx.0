Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39EBC4361A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 14:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430ED206D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 14:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430ED206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8036C6EB78;
	Thu,  3 Dec 2020 14:53:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D0A6EB74
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 14:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU7RdG2p0dns343B9qgsr3Fm7qm1lj2B2hvSoadgwjnwEl+KiswyN/ydMkeRhnNj763KLdtDlTCrhBbRNRMWBc6RUNvJ8TF567ETJIAk7EBH3zGhc331bWjRrcJhFIx13R5r431Z9UKdAbFe4vLIXnuHX7N4Zn/nUUh0zSmQJTAyItxaiRRb45qMF+E5KO0Vu92i6/eXoQTBiD8yGMgSphycb0vtu792baLEi/V0qtUkak/CeHsfjzu78PRisCagc59FrGGVUxtmw0S1suRbhiMkdhqZ4++lvRcAULJIDLPYDKRGW5mNB1g+xrGAA9vY8IlwXqrcV16hFeI8ULVTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsCQZBtCaKULty8j7oNRSfeL5rH3obJtSjN+IYU0jX8=;
 b=IRWI7Ugwx7A+IyHggN3q3HdMIhfVtJIsUyGKnArc9iWbkVoTv8xCwpUsBmNeNL8Wea5SYfAiowXnFsWL04mS8JdtmLV3Xa7yjRPm+kwmTMENRIwGubAwzJ97OWKanmK6YiIs7ophHiLZN3jxceg8yVySMBIpbrubcWD1dPnMZfkNdhMDDslQaBOuLUec03uwLyRJY1e3iPy9EcrPOgb5AHgFbBuUq8XHtpvkjb51UCGtKwctoO78Ic9cxfFaTEUVmTQFSrWUq9Vq9uYR7FzxUUONd4bhgx7reKea+9WUhtFdwM6w6IyAYtaAvtykjdSAOeE6DBmeUMB0nzXSrgnTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsCQZBtCaKULty8j7oNRSfeL5rH3obJtSjN+IYU0jX8=;
 b=F3nB9Hki42W1cRkSDDNSNE94QrMcXM4C/YHlZgrC120EoqU7yrAlD/16Z2qxNKh/TQeCjs2IZadIeAOkoYWyI5aZS2JxmutnanAuqmsNq2277fcZF8fKn1nNlMnb+lk9UF6/s0XALr6hPYbi7mw1nTrMD1p21WYYVkAvDrXWiYo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Thu, 3 Dec 2020 14:53:36 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc%7]) with mapi id 15.20.3611.031; Thu, 3 Dec 2020
 14:53:36 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: VCN 3.0 multiple queue ring reset
Date: Thu,  3 Dec 2020 09:53:16 -0500
Message-Id: <20201203145316.5140-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN4PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:403:1::30) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN4PR11CA0020.namprd11.prod.outlook.com (2603:10b6:403:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21 via Frontend Transport; Thu, 3 Dec 2020 14:53:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b3dbad5-10bd-457f-1c15-08d8979b35dc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4204F00AD048F1FB351BECA7FDF20@DM6PR12MB4204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sc1XEnxEV85tAmY6Qs4S3G28hSQwn5xSOEIEl6Vjn+XY2ONGGlg79Ue5wOls/lB3xww5kzf7vWdtx7Tq68Sl+469sCQsDdVTKJeY5NecLVRO4SnxrrC+eehIZ4f+O0uS30CdU8OccrJSumJw92G4LIw/lKu2eE2NfwqnvId6XJQVhuJOYE7PqGETHfHLZLSHGvZJIyG/DiZBjYqMDir/JelQdP6N9bpCqTUJvtn0IEVH6GbmpkXtatCJyTgMMpQtTyuAaQcEW6rAV8Vv8UblrUGqscdVOGxU04sZmIpSJ08K0EbAB/+DfbpZGx2+g86sy5n7PKAbOYyIloxZ5mVZVA56drhuJG7bbUVqeS7+qUCYi2EdjVoZEdWXv0PU2ceq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(478600001)(1076003)(44832011)(16526019)(36756003)(2906002)(6512007)(6486002)(69590400008)(4326008)(66946007)(66556008)(83380400001)(26005)(6666004)(66476007)(2616005)(5660300002)(6916009)(52116002)(186003)(8936002)(316002)(956004)(86362001)(8676002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w2cNULrBUlNKE1Uj4R5N/1Wl/QdqGCi1HeCJaNXzf4wm4/y2KsZaR0HzONOW?=
 =?us-ascii?Q?7pslle5mG+HpSyj27ITUCkdwbCwArHGJAdsA2NQ6OLs9lOBxFC0HfyVRwE6O?=
 =?us-ascii?Q?+k1MuVdh2HQE9Q4oM88Zql9jkHGkMeJ7HhqYN6L8Zk0L9aK9lppK2VhHij1c?=
 =?us-ascii?Q?DbuuSLVDPvvyJbCPSdlnQuArWv1zNcRHF3lkj6SAKQaXPwQaQSUl0287Yn6Q?=
 =?us-ascii?Q?cUMFO2LzusElntvqrTmwN5SopRWTlEKYycL5fRB+P6rHShO8yJFsmqdJ3Rde?=
 =?us-ascii?Q?zFTw0VTK9/ZYEeYcDeRieJpfrdoVagyd6I3KTAfpZ+10GFcljrNz3KHTvMDs?=
 =?us-ascii?Q?g8lkZOLjyMouYT7Iy+/hDxwQWCKkjkAFVA5XTXshlpgsEv2ThT4gpaf4DfxP?=
 =?us-ascii?Q?7r6wTm4kbSW4HcpdfQD5jlS9yNLTvjQBueDuUTe2s7N+98H9vX+jSCjpNBRq?=
 =?us-ascii?Q?ZBrc7undOWHpSlCSJbVuuFzpkzTvrYloaF2xBJsvz4dUMT0Y/zMXCfCqMp6x?=
 =?us-ascii?Q?8kSUIHP953vuO4aeIQ6NsIEJImH2EcIVByskrg2r5jWMSxsmMwfo7aNJt3US?=
 =?us-ascii?Q?5bN7VbVK1qX69rDSSgNsne4pTe217tWft/utrGiyMuYM/UQF2w86yh5IF7tn?=
 =?us-ascii?Q?iF6FrrVDRj9SJWgWcixJlqCcOzFXIMdzL2H1Clf6/dFwuC02nSBiaSA01BK/?=
 =?us-ascii?Q?/GOjA5Alh2wj6THqGJYFQpj8goyRcHHflUL3AB84AJjpSSRLb3GF10/mUVF5?=
 =?us-ascii?Q?4zDVDRsLYwgoU41P9CymNRjza/+mJphkZJZCZzNcMotyyoUDoXlUndxaBqXl?=
 =?us-ascii?Q?RFCbUGRTGioSSeGU9sGtZEh57seWmZVW8u8y0NuyR9m+l5qyHRILQSluqsW0?=
 =?us-ascii?Q?dv7AmestvUMiL/T4aBnytyHvcGJvbmGTRiSN4xlfiNLZ3TJqVI4sJpfF5NqC?=
 =?us-ascii?Q?VWC6GbU3DoWWbPIoniG2fH9x49pu/t/EB8Z/KZUNmVXWg0dEx3B5SUsVB4LT?=
 =?us-ascii?Q?XR9a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3dbad5-10bd-457f-1c15-08d8979b35dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 14:53:35.9893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQnAdFpBvYN7B1P2mmBk6/xgnWpsUjWHiRb4/4/Up+vzjo0gCPKnKMFdPWBLsQJgbfwi6UtmoinQPkBhBWUxTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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
