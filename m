Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D7C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84BB610C8
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84BB610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060236ED15;
	Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA316ED15
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIsac0irppHSp30/Q5KIJjR4VSM2axmNXmkqTmaZV5Tn/CATgMBkAHVnG8+4Sfq8KJ0pkTCmuL515gD28FreopoVdvIewALeGR60QudUOIsG8cCNRMsbLtkEmq/j7f2aATSfZGxrXBl5PajDBdHQaI8HBKZrZdRk12H3WBf/nMx6FbwpzN9HjVZwOjLy/M4j/GnczAcHMv7D5XqIff5/KSADReKvKxMtsw3FEyWkGvbEulLWH1yOK4O/XnV7Q9xxeIjsVh636kHC5zXooiHSXFBFTE53VmKkxppRLtfohhpNoawU1W9r1hki8phnG9kKyFF699BFq+CkpdwCu6J3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOvwAPEbryxNrreL9EYmizTyYrDBsrXq+7N3/4Imx2c=;
 b=QffOuOdENWDy84sHI7u90D303ZA9j9IO4mtryE8zkxBxbIXQUfirVVhZT4hWPZN11nb+0y8Eb2t5pl1BSukgKasCeCp+nqajMGrey+Uem3gWLPUC0P4FVxfSXI1B3j4fFXf1UqFYGG/LBpDwjJaiGNDzwKTJCVfkO85RbLz3AjHK+0QKD56+s4OZ/pnIwee7fl9NeBYltxHayDb5v7v7cDnJaq2bDN6VBDb9TaUIb9mFxT3cu06uZ/xybJ2PUudNqkOXGupIlZJLJw8zbOksjLjF3WXptHESEONDyio8YI1GVLhmutwwWe7oS9g60weKH8cWOR7aPsHlNSeCS3pIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOvwAPEbryxNrreL9EYmizTyYrDBsrXq+7N3/4Imx2c=;
 b=hF8EyHia1bW7KGIjzRg6xvgmOs94ROhe73Hqm/QrEk19q8+62v5xVKppy2dslS6kre+nPXtDxzowBRvZoEsvi4pHj4MoXFnz33gkQwg4a+MN+e5k7UiGltWW5b4YXNJ4VR0GLn7ZBw7apXKbCje8iZtyiybFwT0aqZvP8MUs2yU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/89] drm/amdgpu: add gfx support for yellow carp
Date: Wed,  2 Jun 2021 12:47:49 -0400
Message-Id: <20210602164908.2848791-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67969c3c-8993-4070-d6cf-08d925e666d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4063AB4120DA5A11A319A5EDF73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsIWqhre3RmcKDAdXRjc2iHgwfbLVc3sZM91vBHkfj4D1mdlC9/uIqnvaVye+Gr3sS+Xw/J7vaFStbTLZq2y26FFg32VlJcfhrZcXqo4azfQP3PN9fy6jT+g37FfBoi+uevykAAoRjC6dbSCO0Ae0hO6OjqunCrLxW6B7pQDsW916SnbHswEv6HCwwIRnr05fEAob1hX2JyhkxAcM3d/sx9mXvXou/XEbDXkQxR41KlwXLEfP8hDpWwG469lxfuUPH5qWn/ry9v5zpRH2VIsJe2d8OH1Dez4HfnGknaH6OLUQBXkU9bABmf0+x1RLTMvoWuSShUycaFwSYxdN9WpzNqpn8mqCFWJrBY3OFB8eP2lzbrbcsj6t3ioyUjZkA1fUKrGDa5EF3GmPkCYAmJ7nnDnVquHNnjTiyCuhOcj4EcAHpmdwIxa/GV0FzUtY58ewpXjH7Edikygc9vhlim75IogzLC9L6Yc/UzErKLApdcEWOFq+R0moA2uzpxJsALqC7/b12c1arTITMLNuoU3v0L8m2nz/Q4gya3DXV5QDVpw3QGHdB2rUcd762eIzGa0m2YVut1895sFQ2JzEoLYkG35QQPPnZ05UdXPdS4kCjaRDhFmH3F0Zb2CBxhAdos+FV0tJFtlgfhHpjT2YM2dMBYIy8xOmBlLvdc7SYEYM9/O2cSERSfW5NRHOWD07BEN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cKGhoLs4hR8fabK5nXnf6+5ZS/LgAxLL9QaOYH3XfGTa8YrViYs5p5qdbMzU?=
 =?us-ascii?Q?9p2CbQdzqPU/MEErxb/rkiaBKTmIo0MazC9PhsuB5qVkZALRFNaZo4ORd1O7?=
 =?us-ascii?Q?gBthLwKSnhK5JUppDoySXx4T/cHP6OcPpCZPK0nqg0MZLL8ZqXE/SI5nsi66?=
 =?us-ascii?Q?uaU5FbfJKcMilQOzjgPu7xOaMX7iffXZZGAIvFF2RMVCc5dbVLcvFTxaU7D3?=
 =?us-ascii?Q?VO8oyTQTthTJWjk0KXaCpJ2zJ6B2k6VuR8QvpQ3S3wlvcyLZgkjU4P1zO9CG?=
 =?us-ascii?Q?BT8KKYguvElCh5H7Svr1GAeVE8hvy3KPXq/MCVn11RlL+IMRlRmi9Orm4uOw?=
 =?us-ascii?Q?R7uei9bepWUo0wydtzI/eo/KURIbAMKqutPzgykhcJHxUEF+pv3oeMBCy3xS?=
 =?us-ascii?Q?XYjeqkHZfqQKQk6X++s7qmjTJFU/fvZSSFuQFhZXWOUbdbEVNQkIrLCsWRUp?=
 =?us-ascii?Q?XgOgQKIeYruoc6uxDWcdQDQb+0SqJ+bE0pch8EN6njgreD5Vx6xWMp5RV0Qc?=
 =?us-ascii?Q?zPJ/XTUeSfYE03lg2L5wyRP+wJdxkrSkJiTo+wLJN/40a4opNfcTaojtb1yM?=
 =?us-ascii?Q?ayaEGCF8/vviGdklj19vSP3sIWhnaYZmHEXsUdTtF0DXflOuMouHK5szgszB?=
 =?us-ascii?Q?GtfDnPvT4oDVE+xKp8o72H97S5ybLqFvEbRa8kZ9Aop2/Q8JYMWtwvonhKPN?=
 =?us-ascii?Q?GCSOkUkdZBX9w5XTfg4Yqxtv18FTjBmfBUK2WS4OFY2ZA51Z/9rpOgV+P1Cn?=
 =?us-ascii?Q?b9WYcn99sV8KqjywrY9kfNcyxsrLCSIV75KlwPq9RcxWsG5eB8H1nlMuSyfv?=
 =?us-ascii?Q?L7l9yj2PdUKcBvm0WNgcs2YLAvEBLGvAB7IF5T/DYfkcADwFe0DVy9mnCy14?=
 =?us-ascii?Q?dG8BaavlXxBVHWYI/Rj2NSCdxALU76g8BtwfJsW6AGyd7KDLl7y5MIK241RM?=
 =?us-ascii?Q?h442Hnhzrcp1zMUxMXFv+PGgkv0jQMAb5PRx2j7jgqfwHgQj8pOxz+AApH7k?=
 =?us-ascii?Q?OyLKELLAl61GTyTGsEKq1phWMp+GjJba5b2GSxC60/877TeJSjhtfortSFWn?=
 =?us-ascii?Q?BxfLsryxauhoSyqFqsDM2h+nPVeuRxIQ3FpBtLMix/dtjHC9SPrA2/shLsDE?=
 =?us-ascii?Q?6DqJq8L+yeFUnjJ6cmvmOyFnjDGPtw1DPwAtX/xkgYM4KUdgWi7QHHIA0mNf?=
 =?us-ascii?Q?A5HyedH/ELu7GmxQ7yqXGklRnu3gAh9zmVOPoTVGx5HcIjo4VrGQjJurj9Sp?=
 =?us-ascii?Q?Wuo/utZsKqnwuJI9RVmvNQf5O+xaeSWzy5/3jUbKfpEXdet1ZsVwgE5N4L06?=
 =?us-ascii?Q?uVWdydUUCPFQKDt7lpD4oSW3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67969c3c-8993-4070-d6cf-08d925e666d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:34.9545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5OUixc7pEmdeYetFewBWNmAL+r2cxhMC3igM8E0X1OZONJScNC4cNxSjxtVgMCWEgqs5N8XMK+AULP6B6bndQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Add yellow carp checks to gfx10 code.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 11a64ca8a5ec..110e0e8dbd69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -243,6 +243,13 @@ MODULE_FIRMWARE("amdgpu/beige_goby_mec.bin");
 MODULE_FIRMWARE("amdgpu/beige_goby_mec2.bin");
 MODULE_FIRMWARE("amdgpu/beige_goby_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/yellow_carp_ce.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_pfp.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_me.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_mec.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_mec2.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_rlc.bin");
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
@@ -3859,6 +3866,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		adev->gfx.cp_fw_write_wait = true;
 		break;
 	default:
@@ -3976,6 +3984,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_BEIGE_GOBY:
 		chip_name = "beige_goby";
 		break;
+	case CHIP_YELLOW_CARP:
+		chip_name = "yellow_carp";
+		break;
 	default:
 		BUG();
 	}
@@ -4545,6 +4556,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -4670,6 +4682,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -6178,6 +6191,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
 				    DOORBELL_RANGE_LOWER_Sienna_Cichlid, ring->doorbell_index);
 		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
@@ -6314,6 +6328,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		case CHIP_VANGOGH:
 		case CHIP_DIMGREY_CAVEFISH:
 		case CHIP_BEIGE_GOBY:
+		case CHIP_YELLOW_CARP:
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid, 0);
 			break;
 		default:
@@ -6327,6 +6342,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		case CHIP_VANGOGH:
 		case CHIP_DIMGREY_CAVEFISH:
 		case CHIP_BEIGE_GOBY:
+		case CHIP_YELLOW_CARP:
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid,
 				     (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
 				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
@@ -6424,6 +6440,7 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
 		tmp &= 0xffffff00;
 		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
@@ -7152,6 +7169,7 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 		}
 		break;
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		return true;
 	default:
 		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE);
@@ -7186,6 +7204,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
@@ -7496,6 +7515,7 @@ static int gfx_v10_0_soft_reset(void *handle)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY_Sienna_Cichlid))
 			grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
 							GRBM_SOFT_RESET,
@@ -7606,6 +7626,7 @@ static int gfx_v10_0_early_init(void *handle)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_Sienna_Cichlid;
 		break;
 	default:
@@ -7663,6 +7684,7 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
 
 		/* wait for RLC_SAFE_MODE */
@@ -7698,6 +7720,7 @@ static void gfx_v10_0_unset_safe_mode(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
 		break;
 	default:
@@ -8069,6 +8092,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		gfx_v10_cntl_pg(adev, enable);
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
@@ -8095,6 +8119,7 @@ static int gfx_v10_0_set_clockgating_state(void *handle,
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		gfx_v10_0_update_gfx_clock_gating(adev,
 						 state == AMD_CG_STATE_GATE);
 		break;
@@ -9206,6 +9231,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
 	case CHIP_NAVI12:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
