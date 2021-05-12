Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E3C43616
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB2661429
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB2661429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32246EC6D;
	Wed, 12 May 2021 17:31:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB6C6EC76
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkJ0VHWQiDS9YmMe/0rCRdI9dQNwYCtXsCPe3D2LrlgO/+I7HAC2WIlhj5lNPwjpFD6y/1JFQKle2FdLKcGtOrMiPbGqWpFXmoBJIiERVMjEyH35Gwl1Sto4JQ4w5zocf5YXhjab602ri3pbSH5unL4Jf9FBKFZJfV0KUcAy3RnKEgBGgjL59Vy+UzWHD7MSA/rn5PQaiNTnknWLNlqWSpSaujt+45XlXPXT/pA3XJjommFFG6zErw/VyIBNuevI6pZJXtnL+1vQcvsHgpcFdZlWmTD7ws0LFnY7TybxTLLa9GkTCq9WR2Tf2SDtsu9PQYgRYiupQBh4PNt+i3dVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kfXmVIsEayBek3wxl3UBLo8R8GrYCwqK9NT7iQQnP8=;
 b=MQb6j4f3OgPgcvuzKsbz3mp94jRkH0ZlcwUN7uRyDmGHUNPSbStKCnLrWdX0TP3yNVtHwlS8bLAikVa/RoxV1WNDt9VaIJPadDNELpV63LG5fWuTQFqfnmbQ17fNR6rrb+dfzptA3tHCU7eWQVCIjEGPxVoXDz8DTg/JKrGeemHvRpPUiKdo7tbXc5HK/YqJMRJMyp2emTZVADaNgk/z5uBTma92hILWoI1yLgHmUgyRthFPke8m2PJBXcglbh+UM6s0uI4Z6KngpyyJqO5B8XjV99UJMKxoZhFMW220cc+oESqqfOVYjUVB33RqPL7sZo4MNqo8Rru5KEqjIWCCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kfXmVIsEayBek3wxl3UBLo8R8GrYCwqK9NT7iQQnP8=;
 b=z/87rYB1vOkhkbCSqeAkEEWhzQDKvgCCKrboSRqGgb7EoiB8NLmHTIPUx6avx0bJvWiV1wJ/IAMEd9bnmDKiGlQhBJrJpng9gJF/aqqg4C6aJ/k7xvWeAZUWf7cUIcCvbtsJ2agpE3cf7Bowz7H0jLp4yX4tv6FL7dgAs8JbkXI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/49] drm/amdgpu: Enable VCN for Beige Goby
Date: Wed, 12 May 2021 13:30:29 -0400
Message-Id: <20210512173053.2347842-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2330932e-ab37-4e53-0657-08d9156bc67c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340C43A213F6F4AEBB976D1F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTowXdwezKLqe9E1WrpK80BL85f5WZMaklTwx+NacXkdkuYLsnjBG7CBsBhU9HFgxG4DVVXUaX+9eRD2Z8la5I+EWqFmJLGrwPrqn85tZjmnEI3dFnKoikY6/uGeLofl92dU5B1hCXyZXw1s+fRw5i1OZZT256J7KnyLEtw0PYm09uK+hC1+hgt7mqReFBXw5DmGbEotrLPV83wBYQoJMM1tAZLhhI0Q5r9hGHizVmZXyT6hzw1X13EEjiXqB0tT93UytVRIAJhcFj5QjsehsakK9SE8eN1ZSku6BcwKHDzZBbX3AqHVEOWrksci0EaWS/UBxRFVyEUihW7WLaCU9ouer/xUXDyOOBzpvENZGBKFfKpKRXfBPu9usL7KeLjJciE9IQ7hAYvlJUHQhLuc2AermWxxuivRXNg+tEi/wHqp8x8peY6prXgXVWtsDKbg21Gq28VKNa/LYpWeyEoj+6ki8ZFj1LFRRW52OESLLmUZck/3tDwMluK/d0IOAlYqdv5AIWK4aw9fY4hpVp2Qbav42PVZHZrcIKzjmMq5T7PYtViu4QPaUHNMa39Zzvhl/XdIbJ6c3cxC0v0Ak7xywei3LTrfSG1unZNRtmL2yVTwCUp26NaX/8vwKFcLlW4RlprzQsB1sTVu3+Qk/eqiJhShiJ9LaPS4K73hXiLVsFcfvRvogib6nPi2V6afqg1z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?22/upX3MHRdcHBpXuKU0wwWewt46DHXu2DnqZIYbSp7D3yGHotn7tWx1gkSw?=
 =?us-ascii?Q?tWuiGGitcHHzDhYq88B3atP1fZwARlFGXSTfOLWULv00xAv21sLedcFip+el?=
 =?us-ascii?Q?v1D6UYVk4s8hntdn8jaSOrmynb5vht57/WICcmb6VkoMf1ez5cN+k3fh2Lfj?=
 =?us-ascii?Q?4NCcU85xMr36E42tieOVUR2XjG5gmbNi8yjmV4ru410zRKrU0ad+FKr2DZiY?=
 =?us-ascii?Q?i5oybNCgrYPpUMZdn27YTSq7MPrZfRm6X+WzTdfSXBvbxHG+Y1iaeY3A+Z73?=
 =?us-ascii?Q?j4IDl9U/byfxLV70+SxAKFYXJOJWlMCpL1la3Jb1RRwbx0G0oUVzMDBUNOax?=
 =?us-ascii?Q?0K0EHf9HKoXUFP5lCW3QfCWuH/kPzMDwfyuB3EPIXk+AumLcCeNVblNImeHm?=
 =?us-ascii?Q?N4FamjeKbAqb/Ydd7WH976LXQ9SWT6Ogla+eXOVcOYp6SeKmQDpobYuwr6N7?=
 =?us-ascii?Q?e+Up4nsfHrQ1Pci9BGfG9+IpJhYE/ffg9rpp7nF2gmSOmI/DP7LQKgZ9+3TJ?=
 =?us-ascii?Q?xGAyMmPa8a1l+yp8nb2trMF+dIxjWtO+n7fQD4z4nCXipUsqfdMapfSmqcpC?=
 =?us-ascii?Q?rwx6FuFOWCll4kuT0+a3ClubbdLuC5RTrMzqHGP83t5JVER0E7pP1+5L8Icz?=
 =?us-ascii?Q?8ziVO0J7owoeHnMpiopFNudTBuf+iDMI1coqmxYvhqzodSPeCJrkzLrMvT8D?=
 =?us-ascii?Q?RmrXw9ggaD381G4bFRjUoXP4QU4Wi08uZRTWPWxpJOgGMqBdIAQWUvCKVaV7?=
 =?us-ascii?Q?qoDQxjpMgXDWmRHVRlevT8Xjis92rOP3KbEOYNRe1D22PO6prMlG5KBOBBAh?=
 =?us-ascii?Q?8NT7y5DmTU0Xa1b/iYcbnsRavMFWuufi2KMWaOdrQ1ZpkOrQcEbWhZSW81o4?=
 =?us-ascii?Q?bB1RF2ARmCLgFaFQFD8lGSTBRs0NJf2/0eWLLdeJrva33CJDHMWGqSjT+mDy?=
 =?us-ascii?Q?VNo4wvfhpkIFR60SMMlP2IjfQoCZ70ekoh4BcLJ9DSV1JYbCsKlIz106SUe9?=
 =?us-ascii?Q?qtuWhCmxHhaSh9HavLEmGc4TGtnCcEmvjGRI+1a58hghL1hMj+yt+Pd3MI7E?=
 =?us-ascii?Q?8QUbp/dzNPvppPDqf2dy4RJ8GdROvWlZwsPN5CJkvXvBCNYcOdgNa739EZdc?=
 =?us-ascii?Q?zwiu1fM5GnxqYDS5ag7RSBl4PbrLcfzigGzjhDi2BElt0sNSwYO/rcFydiXb?=
 =?us-ascii?Q?x6DMDSkNQHYCpRaKFGTw3iy/Gm155L9H05yuMHJaZgOtWuC1KoCDgRAzfIiQ?=
 =?us-ascii?Q?uZJA+2iKMtjNs1ugdRFcQMav0OIfEXrcNTrA7mTx3v1MIkU5eyE1cfvYofr2?=
 =?us-ascii?Q?9UFtpkGDh9SfH3nvaLNg9CAv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2330932e-ab37-4e53-0657-08d9156bc67c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:28.6820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ref3nUuGB7llCCYXN8FQ9EtgWejkGfzHwyqVFGcl/kb+9Fr1eB4byPJevFaNjMafd0OljCWoCjz/Lil2BpyViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Enabled VCN support for Beige Goby chip

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |   8 ++
 drivers/gpu/drm/amd/amdgpu/nv.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 101 +++++++++++++-----------
 3 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 201645963ba5..d101cb9697a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -48,6 +48,7 @@
 #define FIRMWARE_VANGOGH	"amdgpu/vangogh_vcn.bin"
 #define FIRMWARE_DIMGREY_CAVEFISH	"amdgpu/dimgrey_cavefish_vcn.bin"
 #define FIRMWARE_ALDEBARAN	"amdgpu/aldebaran_vcn.bin"
+#define FIRMWARE_BEIGE_GOBY	"amdgpu/beige_goby_vcn.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -63,6 +64,7 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID);
 MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER);
 MODULE_FIRMWARE(FIRMWARE_VANGOGH);
 MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH);
+MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
@@ -151,6 +153,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case CHIP_BEIGE_GOBY:
+		fw_name = FIRMWARE_BEIGE_GOBY;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 06ff5b23c993..c56f8e7e20f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -861,6 +861,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
@@ -1171,7 +1172,8 @@ static int nv_common_early_init(void *handle)
 		break;
 	case CHIP_BEIGE_GOBY:
 		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x46;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3f15bf34123a..58a63c42bf9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -91,6 +91,11 @@ static int vcn_v3_0_early_init(void *handle)
 		adev->vcn.harvest_config = 0;
 		adev->vcn.num_enc_rings = 1;
 
+	if (adev->asic_type == CHIP_BEIGE_GOBY) {
+		adev->vcn.num_vcn_inst = 1;
+		adev->vcn.num_enc_rings = 0;
+	}
+
 	} else {
 		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
 			u32 harvest;
@@ -110,7 +115,10 @@ static int vcn_v3_0_early_init(void *handle)
 		} else
 			adev->vcn.num_vcn_inst = 1;
 
-		adev->vcn.num_enc_rings = 2;
+		if (adev->asic_type == CHIP_BEIGE_GOBY)
+			adev->vcn.num_enc_rings = 0;
+		else
+			adev->vcn.num_enc_rings = 2;
 	}
 
 	vcn_v3_0_set_dec_ring_funcs(adev);
@@ -1257,23 +1265,25 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
 		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-		fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-		ring = &adev->vcn.inst[i].ring_enc[1];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+		if (adev->asic_type != CHIP_BEIGE_GOBY) {
+			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+			ring = &adev->vcn.inst[i].ring_enc[0];
+			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
+			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
+			fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+			fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+			ring = &adev->vcn.inst[i].ring_enc[1];
+			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
+			fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+		}
 	}
 
 	return 0;
@@ -1653,31 +1663,33 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 					UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
-				/* Restore */
-				fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
-				fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
-				ring->wptr = 0;
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-				fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-				fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
-				ring->wptr = 0;
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-				fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-				/* restore wptr/rptr with pointers saved in FW shared memory*/
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR, fw_shared->rb.rptr);
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR, fw_shared->rb.wptr);
+				if (adev->asic_type != CHIP_BEIGE_GOBY) {
+					/* Restore */
+					fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
+					fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+					ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+					ring->wptr = 0;
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+					fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+					fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+					ring = &adev->vcn.inst[inst_idx].ring_enc[1];
+					ring->wptr = 0;
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+					fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+					/* restore wptr/rptr with pointers saved in FW shared memory*/
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR, fw_shared->rb.rptr);
+					WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR, fw_shared->rb.wptr);
+				}
 
 				/* Unstall DPG */
 				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
@@ -2134,7 +2146,8 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
 			adev->vcn.inst[i].ring_enc[j].me = i;
 		}
-		DRM_INFO("VCN(%d) encode is enabled in VM mode\n", i);
+		if (adev->vcn.num_enc_rings > 0)
+			DRM_INFO("VCN(%d) encode is enabled in VM mode\n", i);
 	}
 }
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
