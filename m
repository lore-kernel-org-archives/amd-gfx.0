Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FAFC636CE
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A6961029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A6961029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CE26E437;
	Tue, 20 Jul 2021 15:44:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B9E6E436
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeSz47gdbLhPVVNcYEgzHGHAUMQeaNN5ZfJSr92tmaTbs5XJQDiEvKyLz88yI+nr2LRZhi6sR7gaJM87vMZGATiz5lEA8XEiD0STd3MaGCe+/P4VmtcbG+Rc/CWpzh2WlmigoZ2Mr/ltNGvvdIIQ6T4ZVXvz8kUc3f0ivE3Ihe6cRwsE1nDmvPyWfiYKT06Kq37Rzdm6Yf5/TpwjAJBwwUM0t6trQayLZqKdG1tAhfAZn6yv1TElhLWf+7U92PWZ/fzy/CrV0If8IrC9rjea9LB9aGnd2Oaq3r7fWjbLUBmVeAuP+7qTEjdRH1EKMB6l0mRYsaZXoAszaBjHMpS/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FaJOlRS2AS0QIk+sgm5mpa8k9j95womKm9xPtmju5o=;
 b=H8pBSLjJkv5hnU/nCBXXvsdLIfC5ct2b1md6T0RKpK6jgPd4/q2PDGXjTYqxFf0WbCEplKhcd98DHXAsfFjHAgv0wR0vTxd/fckfB5XuSzQOmitO8nCuL9uVgd+aJom6SF5J8iV18f8+v7PNLcCLfw/3UoGnMtYozARP3jf5LhErj385COx78vNEn5e4u1T0Ey2SQN2Ie0UZKLbrimRIozr35giFiHROeAMAtip/2nlHH2k3Y6ksYNA1b0kU/JPSda3xyhZexAyGqgPDMmhAVnIGr5FYTed29hGRDzGgc4L+jKf5caaTPjj7JLPthV8sBUCNih3lrfM8AwR+iVET6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FaJOlRS2AS0QIk+sgm5mpa8k9j95womKm9xPtmju5o=;
 b=F/a13zItihruDtyYYOPdc/CcjYTJlYozfhXfvtmL6W3HR1BOXwQe0IuYLhIO0PkMczDW1zLjaq7bEhsxbByg6vs/BiV7du0+pENgAIJ4u980Pi/hbywkmnfTIhjDRU2wv9C0HD/cYTvb4AIOG7lAJ1KulkQ/pc8Oe2BlKlz4ccQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:14 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/29] drm/amdgpu: add cyan_skillfish support in gfx v10
Date: Tue, 20 Jul 2021 11:43:31 -0400
Message-Id: <20210720154349.1599827-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6292619-a113-4e18-96b8-08d94b953983
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52885222A4769BD5F188340BF7E29@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faQu5mhWB2RvU4vzCdytGLfI4lEdCG2fDWYOzA95lIAPv+5X4zapSPgwyyqjNrK4eEW3LfEmyapFoOPst97WoNdie77RK/lEPzI/gIxibGE9EUwIf6HWtKU9dQ2cbyxj9zgHqCgyIhWSSE93QumchwkunlR5EZQ2aW23YDPe0aErnvnJDEHl+aLEyO7QC0mzwrojOczqLJs/0uRFCNuczpxQd6Bjbntejk8wfegLvw1lOfddQLOjwTa5koTMR2hgDZz2cT4fU98GiMjpHtJ1Cfff2cd5L+imO83caJH93FcBy5HDWb/45CUdGXx74yxd7dhaQksaG/v6Q1A9vI1cGkWc7sa/tTOWoMdCUa6IKTjcL0CwAHC/Hzv7LQvI3VpWEj5lRl/1QK9MesmnsZiDt05ba5F/kiN6UkIEYuSJDQTUn6JDxpC7El1rI0FOajNnUteZCaNDC23kBOGk/HAzU/5IsGcKtLDNbBSParSmcSt505eKyrhhtkLxNBZok38gWPOlX2WdGNr0hzF0kQs6O5DOx3D9YCVF8d4hBtzsgCSj35h/GQ2YEAyoqvTlKauQe7KFny8OhlA5PXN/kuGilOysQyBp3/9R6kIcIhkI4cEKm76baxrWjAGThGzRRRU0UJnK7P1y7B9bB6uV6i4HP1RothJX13rPHWdSTtKd8KUH5c8V88eDI+kcGdjKlaMXZ/ysTemyFJhMSdNYi6I91w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(6666004)(66946007)(66476007)(54906003)(1076003)(86362001)(2906002)(6486002)(38350700002)(38100700002)(8936002)(316002)(478600001)(36756003)(66556008)(6916009)(26005)(186003)(5660300002)(8676002)(4326008)(956004)(52116002)(7696005)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GM7dYLbolQmzsFMzvC9qu2YhMaqJDRdnPlWr9O8rioDBqBjInPhQk8+9uhmR?=
 =?us-ascii?Q?LH7GNvA1Od7H9Xg98IgB7tGv2lfZkR+3kSngpDeciQcyiLM013rjd0Q0ugad?=
 =?us-ascii?Q?oKso/VBDk9jCzRxRxTrJIpMFu05C27/jZooxoRu/9HIZeF23rBtk7QDfhGLn?=
 =?us-ascii?Q?6Rr+4JuLqVneiM7lCojbQig6a2uAUff+b6PMCr5lBN4L9R0vRryileUErZQf?=
 =?us-ascii?Q?B/fdgkYTWiy1DyiKkCClXhFjzEecazvgqCAgOYVCWWm7+ZQ5he9rLff5zrPk?=
 =?us-ascii?Q?gLhFqhIlEuwq28CEC8PUUI0LStFyJDK8lMqs/swegm9YHyzHw4uKsobexYhj?=
 =?us-ascii?Q?zXCXZZ6Tnv8qT3pY868XyBUeoSsSFJFDeXacWoKQeZ013xrQXY+KCj+oMlNG?=
 =?us-ascii?Q?dJuHT4cliOH1sKRM4d1ExKX+GzlaF0rTUUtHIfwllSDk9x1XoEGet25lVZe+?=
 =?us-ascii?Q?tIi8krpy1Ze/ymlDHGeesbR5R1gaaS17WQu/YP1Z83nJDiIM8XcAdX9CdyQH?=
 =?us-ascii?Q?UX2lsp3/Z752YwMKOE8nRA+yCBczOSgfYpiKZ8Rk5oHisuOPaexU9CELum8M?=
 =?us-ascii?Q?/CWuEPK2Fl+RVVmPuY2pUVK0XOCcL6kn28Igo6U92vAAOlg6kIjRkCEBazRA?=
 =?us-ascii?Q?bODacn2vEeUn4OLWwUPy1foyYUAWF7X5dXB+Hn3OltZT5+gk7YbiAwUBSH1E?=
 =?us-ascii?Q?sLMT/ppj8+Qbu+ZcHJIzmnYUQgcWIi1zVG0KBzJ59d1H9XMShcaIKQqG6upM?=
 =?us-ascii?Q?pajjHriJRaD/ev3Xuuj5Tnv5iebD0O8FAwJ7zLz2jav252wPvaIFkWSvBXUA?=
 =?us-ascii?Q?loTQyvpF6bEEyGA/qp2T8vFNbPhGLuVB+/Sk2TLF4uwPqwR1sp9axRQx9Yfj?=
 =?us-ascii?Q?pqrZAxWNrZl8XSVnduuvDjK0YVWnn6MNyuiseDOX+yl/TTFN4YcnVNmlPm/l?=
 =?us-ascii?Q?GeHxc08P12Qb8HpoHFJjklyEfLLar6w6/QXqBHCujr4CRmWrh4DylzMWwkSP?=
 =?us-ascii?Q?P0/SsjARJmgAV/+u9FjNiYiFPEEsenHYxTYXEMbLMuIEPSTuBWwFf7V3IP0M?=
 =?us-ascii?Q?y6YJSES3jmzJpsd7C7PaG1WLoZWudOXW/QJ/HBGg45uyAq6HJtQjTRbqkKeF?=
 =?us-ascii?Q?pRuFNCXjuPB5SHGjzOVUnXecvRt0YGAlHh6pIKd44CgpqXsPP/ncTzNCYqxN?=
 =?us-ascii?Q?N5r2QOuM0kuzT74qzK+qVfiXD9lQEqMb2wVGcmdGrK+dmWRAxX3tMBcnqCXi?=
 =?us-ascii?Q?KZTGqZrod/w9zt6ZgM+9cq4Y/rYMZb72MmU4rl/FbpLQ/QZ96j+3rXK5DyOl?=
 =?us-ascii?Q?eMbpEOwIotBkr2kJZ4VaNSgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6292619-a113-4e18-96b8-08d94b953983
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:13.8991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCocQtCW5BIDWVww1Q2HBUtt9hkK3/44vfnuKrvt4x0mSV7vETPMTXpjjZFT0XOGUFR9bo1nqfMDuW3fAhxBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add gfx support for cyan_skillfish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 47b348a7fbab..2808c8bd174a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3528,6 +3528,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
 	 (SH_MEM_RETRY_MODE_ALL << SH_MEM_CONFIG__RETRY_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
+/* TODO: pending on golden setting value of gb address config */
+#define CYAN_SKILLFISH_GB_ADDR_CONFIG_GOLDEN 0x00100044
 
 static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -3925,6 +3927,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
+	case CHIP_CYAN_SKILLFISH:
 		if ((adev->gfx.me_fw_version >= 0x00000046) &&
 		    (adev->gfx.me_feature_version >= 27) &&
 		    (adev->gfx.pfp_fw_version >= 0x00000068) &&
@@ -4644,6 +4647,14 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.gb_addr_config_fields.num_pkrs =
 			1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PKRS);
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		adev->gfx.config.max_hw_contexts = 8;
+		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
+		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
+		adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
+		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
+		gb_addr_config = CYAN_SKILLFISH_GB_ADDR_CONFIG_GOLDEN;
+		break;
 	default:
 		BUG();
 		break;
@@ -4748,6 +4759,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_CYAN_SKILLFISH:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -7712,6 +7724,7 @@ static int gfx_v10_0_early_init(void *handle)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_CYAN_SKILLFISH:
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_NV1X;
 		break;
 	case CHIP_SIENNA_CICHLID:
@@ -9472,6 +9485,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_YELLOW_CARP:
+	case CHIP_CYAN_SKILLFISH:
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
 	case CHIP_NAVI12:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
