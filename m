Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAB2C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8DD60233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8DD60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08EC89E5A;
	Wed, 24 Feb 2021 22:19:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1DF89DC7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCEV3NLVHjpK2LSw+1v3ZXbZLjoZdMA5HN5k+p5JG6/driPIq0bJTDiFPZxpD0sxzd9Gyk3lP+QmXnvUWXHVUl9/yjuWf9XVgXZPQGzWGfLEsTtqFTo4xJBlZsA/CxkYetGAt4rubFJAvaE3cjlEdRIpNVP/mxwBsqN8cN0RrV6AaIvXiI7m5u9vTqRezZHtsdV+yh9ly+sni0C0FdWLH/LFLaOy/XqzJrOdVUPSK9jVnp8aoGQhAZmnMaamuWAXb946xQu2WRmMNMsBkqqjUkGgNLGLeTw0H7p7h7Mq10nn/vkJcFwp5pw0WDOAcFMx1Io9gEPf8VzMRZfoHIEjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA4JOBPQObbm4UwV6jjKAUXGAqDESa7RW+AUK09nXb8=;
 b=QE2N6Fab0Z2h//c0Ruw0vxd9fdUSjs2yoD5hIrEkBP419pdVGEoYvx7wYkGwV53IrBtzsifFZsdDBhckNCboykK/zcwPjO6XuDGnPIf47BJbVW05N2aH/eDl5Agxlv/NuuAPPIgXuSYFXwgACsQZQ63WfHrqGIa1e1sB5NKMZV4Mt0EmCuGOLemCWCTr3Bv9rJJtS7ep7ZtpMyeClDXw1Zh04CGTvyimxyEwtmjeMTXy/7/Nl2yVp0IW91fKLOXKRuVg6wgzG9ZTvxcYKP1YNf/64Off8lYnQuUZT1xArskex7YHFH8btz1nffnHQhbTIRHqJqLr3Daq4stK4NkVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA4JOBPQObbm4UwV6jjKAUXGAqDESa7RW+AUK09nXb8=;
 b=Bm7MQ/XkinDkJ8FFy+cb8OG6mTYY8e2RlguSJ2GZmUuOXupo/5YFB+pIFG893ruFCC2R+qwx8ARPLbjS9Ywci/J8KEuwYkzMu6dR1bmkXK7AYQymPW9Xg9FWxhYZr0vlKNAJlC769AILLv0JLtUHFEn7egAsT7p01qC194lX+Ao=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 017/159] drm/amdgpu: add gfx v9 block support for aldebaran
Date: Wed, 24 Feb 2021 17:16:37 -0500
Message-Id: <20210224221859.3068810-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72f41cf0-c358-4b7c-23a2-08d8d9124148
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41756E3BFD6618B1BAC7401AF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7DuTv8Dg/VZdeIeRRkLasc9xlaWe+qxRVa26h1aBr5uxLV4tyqxppw4v6qdi5KXXXXeokOn3b0f2aHmOVdG4kO448SPF7q3iHrQ9/3xnQzBv212VjC7i3Dx0WnWPZKRwvmUX3HeKIdueUDUvQofvgiXgKEuo3G+jbmjICBbYiWRFm01rOqcfhiIKkzvVEJZ945zGHFf6fZb16fHkjvpna53r7EKBSQwXiTaWTo037bQvB3pYIGo/PAIb1ejUwc+b4jNLNXpduf0ZEZrZG5ksIlQpKuZhP+/Ti80h2NzVMEGR1KjtuLWhouv4h2sz3FRozjPYaHGDRXcSl+kpaaHkBnJ6hDVa65n36hRkcZfKq3+MdOGBFclxZNKItMZ1+MDR5ol6JsM++TfHA3jrQkn2gvSofRURCnXm83Dzqas4uC371JhDPO0Tbjei8isR9V1/qSpctzTeHq6gWCf2ZGZJM9IdNi7G3ASKrHzmjRolDUF0mFvG/CHYs/2kprGzcdZ548i14Tourg6zVrEs2vUkF4fYL6orAiITaQfz9C1E8lJf32Bz4QQPTAeMvaBpKfWPHMWEWeBJkT+VYZOl4XtvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+ZEsP7GfuxNNDt1Tz/ToHXHcc55FPLO1SDQ5SyNnjrq/vIoMzkutwf36zN+h?=
 =?us-ascii?Q?cZQLmB9gCn3/Qc0K06PDqteey+0B0pu7HgLDnZVRPWGwfPct9zQiV3K5NZ92?=
 =?us-ascii?Q?H+ok6C9V1pzFGsurgaGyLVkzl2iBiY9eEUW/EqNc4OAlEkFa3YTf09wGk4aZ?=
 =?us-ascii?Q?UmUsKfW9PTtLEU7j0n5PhJEv87tPkwpx9gW9hXGhCHqEEj+ZcrgCWk85aO6g?=
 =?us-ascii?Q?Z3OYtiNPEqjAFWPgQxDoX6mIVeEhBdVAIFMKYUv3UJTIzSgg/RvG0olEHyPP?=
 =?us-ascii?Q?7fdGTlJG+REV+2wk5ZGwF4E2OhJNNLBmOYVkIBZ1B50Wpf9C3kS3RyGPs0Xo?=
 =?us-ascii?Q?R3KBaxf26MAXek9lcpPG0O3wxxPf2mElAEXVh1LU6NzDi2W6X2kWar/hqELO?=
 =?us-ascii?Q?h5CdDi3xPJ+l03fNi2hYQSb9Lj0Qpu3n7CEgJaYwL8orX1ZIb+YZIbcu9LQ0?=
 =?us-ascii?Q?ytunsG2Qjogvdzwsyc+5VahWzKKPp2otINRpKTxJYhDUnW41F0NX0Xmk65y+?=
 =?us-ascii?Q?oN3lzuoSl02EolJgCMM/YDm3vH1uvWGl5GLsvHmwqHm2P5OMWTSJEPWjLmm/?=
 =?us-ascii?Q?kLTzhrbumUABZ2NU8+17xvEavN+aEp2Qt9CgjbqzVcVYSTOJ4zxvgukvK0rG?=
 =?us-ascii?Q?1oKYVeF3JqwoKS77+++1olyTNVG68K5EeHkv92V2b9XPeSCB6j7yFDmj5lHX?=
 =?us-ascii?Q?CZFdfI/CnfXYhkSJtITqD883t7LR33ROoBZ2bt+vCWQGU8KSjDQmvApuZELp?=
 =?us-ascii?Q?sWA18SYnAdzxdeiYCcKCA5758jTscf9qCYzZJH+T/dS5E3CsCcYGG2zfwi6i?=
 =?us-ascii?Q?jB6ALvlc4pSmKgnNzmAoC7b6SG3RncCcz/JNDelNlTQ7CM415pTeEQe3aJ1x?=
 =?us-ascii?Q?dX+C5C9at9Zt05cCrqrqzBa8nUJAPCXN9kKk/ucp4FkzIaRoFgj0xP87s+5F?=
 =?us-ascii?Q?f/WtAjeUTDa9uAhNAUxsoA2jmDS3VWmlvEU/RX0GYcsY6fS/1jT8jqAY0I5+?=
 =?us-ascii?Q?J618rnnLegu7mv6DB2CLSaUXAShT+fsHiwGvmVF6hni8vPdnSKxRb5ddBkfG?=
 =?us-ascii?Q?iwK8gRDRwO7dzN2Oh3jqRpmTtjgufWXwtP+5X63cOMnfzEFJSx1Ndm0GeR+7?=
 =?us-ascii?Q?HB/vGXWQirf/uok4mcYR3MNM9OlGONupOZZOIr+SRym+7FWGm0NhP8IavLxv?=
 =?us-ascii?Q?O+yF26qQkae8Agttt8OqeB5uqeGc6UxBFfGP3C/fi02BaZ0KqFPIXB0sS8cP?=
 =?us-ascii?Q?4Uo4pQxmaDMyVD0zQUqLpVOYGchvlWZ+doo0v97McyHJPDDqbBAmwPmOzQ8H?=
 =?us-ascii?Q?A2r3d0uWGvQgsVPekQtf+Eqa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f41cf0-c358-4b7c-23a2-08d8d9124148
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:30.2642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRWRQs+PFMo5rS1ZLSeMsFO8DatTUTDV5gS9jChjXSknJDNnjZAWG+IRpPfClGw7Dqnx9xwPvunJA30Qy4fNbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Add gfx initial support

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2f56adebbb31..3a2ac7ae908f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -122,6 +122,10 @@ MODULE_FIRMWARE("amdgpu/green_sardine_mec.bin");
 MODULE_FIRMWARE("amdgpu/green_sardine_mec2.bin");
 MODULE_FIRMWARE("amdgpu/green_sardine_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/aldebaran_mec.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_mec2.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_rlc.bin");
+
 #define mmTCP_CHAN_STEER_0_ARCT								0x0b03
 #define mmTCP_CHAN_STEER_0_ARCT_BASE_IDX							0
 #define mmTCP_CHAN_STEER_1_ARCT								0x0b04
@@ -1650,6 +1654,9 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 		else
 			chip_name = "green_sardine";
 		break;
+	case CHIP_ALDEBARAN:
+		chip_name = "aldebaran";
+		break;
 	default:
 		BUG();
 	}
@@ -2167,6 +2174,16 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config &= ~0xf3e777ff;
 		gb_addr_config |= 0x22010042;
 		break;
+	case CHIP_ALDEBARAN:
+		adev->gfx.config.max_hw_contexts = 8;
+		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
+		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
+		adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
+		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
+		gb_addr_config = RREG32_SOC15(GC, 0, mmGB_ADDR_CONFIG);
+		gb_addr_config &= ~0xf3e777ff;
+		gb_addr_config |= 0x22014042;
+		break;
 	default:
 		BUG();
 		break;
@@ -2257,6 +2274,7 @@ static int gfx_v9_0_sw_init(void *handle)
 	case CHIP_RAVEN:
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
+	case CHIP_ALDEBARAN:
 		adev->gfx.mec.num_mec = 2;
 		break;
 	default:
@@ -4644,7 +4662,8 @@ static int gfx_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->asic_type == CHIP_ARCTURUS)
+	if (adev->asic_type == CHIP_ARCTURUS ||
+	    adev->asic_type == CHIP_ALDEBARAN)
 		adev->gfx.num_gfx_rings = 0;
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
@@ -6932,6 +6951,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case CHIP_RAVEN:
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
+	case CHIP_ALDEBARAN:
 		adev->gfx.rlc.funcs = &gfx_v9_0_rlc_funcs;
 		break;
 	default:
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
