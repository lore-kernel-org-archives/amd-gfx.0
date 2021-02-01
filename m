Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847CDC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3000564E2B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3000564E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51C189FA9;
	Mon,  1 Feb 2021 15:52:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EC089FA9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUcaLDSMoKpW4wIrRECRy9W99rjIdnn2nRCfb04mQkoAmNwVPyVjryV2+MIHGWDPk74h4ZEoV3DTW64a1htNufv2/BLAvcLJ1UEw1clHEoxdJcMbt3hdXcyxxBkK9azfINmht0A3+xXM8q+cLb0oLWkdY98z+RkJshxmLahKIUf5XJ7RE8zTrdPoEPTLGNRbNG8P1QONlJFi8nM4bY4dLRXqiWlBqmAyYjI5fo1VGKohlQ2HtxJ0M+1+P6CtQaaML78pnN+twYGoBW9MiaV6u9GQHhLWtLS4cKw0YXR+/Kf7JJtg8/H2xm7YfOHGFCuYzMme1pJiwRp4dfAiVUw+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUut7Va7ZK2YkzfbUE7twKfKlrQfW5o0HKPCWGqnENA=;
 b=Z62GjoEG7YkSkFFx7kprH8NEmbEX45+UXfTBqCZn3Gf/2k67vRzHBxtW1D5O+dyrqvq05n5ljERK4254h8cGJj0Xb5ZrvaI7EvXv3vFZcm72GJOVGX46CJFPdbNNoKQhiXMzzk60aFcJregKB0YMDJg8F4KIswo8woU9IuzXnu4gBaZ94P9kefC3MkjdPQ2wUcoGkY4rTIMAjpw/xoLVQSpxCTToUIWZF/KI69nH1W9Rhfiem5bA4S+S8SiLF09kmkWwyqv9YYbPlJMi+ZuNRr2q+4DMtLjR/NlMQF9ABUEYJy4jFwwT3Rg8xsQslbNDoMTbR2mOS5Ux2Xy6jE97kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUut7Va7ZK2YkzfbUE7twKfKlrQfW5o0HKPCWGqnENA=;
 b=CCoR8p3zgEIL8nPxNfOKlm7zNsCzE1+Q+BohbLD1sCiql8H4EocVuAKgzthAL136Z5I/FSXRMJXIRgm5IxK5xT0oKECGm0Cb04rR9EcjfjFMef+CM6x+Yw8w0Uc2Jd8xpXig3EuLIN9coFjnGzjX30zfWSIfYq73oO1Cw7nNXLk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 15:52:12 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 15:52:12 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: add wave limit functionality for gfx8,9
Date: Mon,  1 Feb 2021 16:51:54 +0100
Message-Id: <20210201155155.103360-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201155155.103360-1-nirmoy.das@amd.com>
References: <20210201155155.103360-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:208:55::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:208:55::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 15:52:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 622a4ef3-ebce-40a7-37a4-08d8c6c95696
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3066AB535B621737E71AC6648BB69@DM6PR12MB3066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wibDxKwpqLwzQLZ1xXHsm4ojhRupZIHcaEK6N6vI6ZaZrLMAh1dO1PWZOc9idTD0PWiF+5MePhx90n22V40G2MeuIMUnCtPCQZzmYWnX/AArPnoLybNti3YBYeMwVF4ml9OxaITA27r4IwJM5flTevvaaKYhr5U0AFgVp4oOkwW6oDPaCBe4lacK2pCbQXbpaFixv5jZ6wQf8GmjvBHNXuU1BfXAEQy1SIv1oBZ9XxcXGNn/kp9paZoK/O3kT9+woINir68NXe+ImAidSMfdCm9bdytDYs+J3dZrbq8vwTT6iPEaz7eSETfgekyCkI022OA9swKSICva9oAhVCYGYZ8DnvK1g1b2Rsj/G6ZGXsjgxcDIht9pOuB90kb9AHoBmhwhLVTHLZuFyNFKlGMeWVwo85DKDP5luVVFsnBUXZAO7hVXPIPVZcSEpKGI8ucSNO9E2GQ4NEB535ItbeqxdXql6nT7RzGZ4W/dAQpHenMw/DbVPx+IoYY/0kAhA82LPTpE8nRgVADmVZFgLsMtWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(52116002)(6666004)(5660300002)(1076003)(6486002)(316002)(66476007)(66946007)(66556008)(6512007)(6916009)(2616005)(26005)(956004)(16526019)(6506007)(36756003)(86362001)(478600001)(4326008)(44832011)(2906002)(83380400001)(186003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?69S/pay7WARM5kSnFCjctjxTcFgef14RaTEoJuiv2oiY7Oy5pRy80a0SrtAS?=
 =?us-ascii?Q?j+AmKkSdYNzvsg5jRi2mro/wXgDJokDsO6CrH/Iw+HTbmn8eLzOZOsEFWtaS?=
 =?us-ascii?Q?iUdzrS3Ey10euQNEB11Xocj/Y+4rciPTPYNN/XvzQJ3DfQZ/+qVJXGZb6Sp2?=
 =?us-ascii?Q?rhq3UVyXdiWuuvbR8ct1xxHSvK1Y3G3E0jmR1PKLy+hFOc2tVnZkY6oUiEvt?=
 =?us-ascii?Q?bTELdeyNYLphwKmMRmmID8tkemBuezP6peNMAaw2ktzoJdRQtNv6DB8C6wpm?=
 =?us-ascii?Q?nVrB3O/MrNzi0E5n4j2o1AWzrbN4fSf/MAz6axJojuXpXNFiWyBVYP2HMKR0?=
 =?us-ascii?Q?cYBCPDIpqFdpPJxCn5odOCpCEvvdrmN6UIGHBSUZPKvmxXlBUnjX/WC01iYL?=
 =?us-ascii?Q?anB+Rf0W4qMGXw4UF2P3y873O8FEZaV8WKr+cTOQb+f+oOhkA+kjXl4KFzB3?=
 =?us-ascii?Q?T6J03d0iSA7ijwlCWiHWuaRtdHgvxPtFzuo609JZB/rEJe9Xb/j99Dq/PtIr?=
 =?us-ascii?Q?0N0MYPeOT7B3NxlOq1llgBizQaFU1/0W8+T6D+eHvaHGFmNSeWWpo6nPexD9?=
 =?us-ascii?Q?n8j8DEEZuIBbnX55pj4DtJq73qquog5cVqlgK3gG14hUA+ST+GfBRnBLxjm0?=
 =?us-ascii?Q?kKo3WDv0pCdKW9ms/Q9gCMmEtAFCCanCSosoDNRZIE7Ft4YLvTW+0J/cJPSw?=
 =?us-ascii?Q?PHYJT7FC3rjecWoN4ov/1wh4eXSUhdVAUs0xvcPk2uUvgUVdxWf4WDX/D/mX?=
 =?us-ascii?Q?SKQsvkT8HIKMEqV5N+QKWP3Nhltk7RaSblc4UCmLAFcknkEnL6DfYpJ9Zq2o?=
 =?us-ascii?Q?G1c2tTErUVYpwF6qCeMqW5ZKoW3mWfFo0Lq/oZuD0ho6jVUzJnGGNJC+Z9fD?=
 =?us-ascii?Q?/9aC9OcYj6Z9nkCgAwuzDm+J664McRfO+KgVbDUC6z0R/BHynOBaIqOP/NuD?=
 =?us-ascii?Q?t/Q5S1EfS1GehLKczLDDbayi7xE3I19lUCU94HecOWnh2Zzrbr22L9ZxKGOM?=
 =?us-ascii?Q?ll2nlzYQOERhV6UXSGpmYpUvPABQNdWmKcA04SQapmnqu5rLmuCbhaO6oPO9?=
 =?us-ascii?Q?TN3/xLsT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622a4ef3-ebce-40a7-37a4-08d8c6c95696
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:52:11.9574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s94gJVW5B39I9vwnpy4AA/Ecc4nkIP4u5SWi/j8oKEFgdS+Xli9qx7R11/QNWpF7WsLuHhHUwYYidemXBoepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wave limiting can be use to load balance high priority
compute jobs along with gfx jobs. When enabled, this will reserve
~75% of waves for compute jobs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 21 ++++++++++++++++++++-
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 2ada80ce42f5..56acec1075ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -197,6 +197,7 @@ struct amdgpu_ring_funcs {
 	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
 	int (*preempt_ib)(struct amdgpu_ring *ring);
 	void (*emit_mem_sync)(struct amdgpu_ring *ring);
+	void (*emit_wave_limit)(struct amdgpu_ring *ring, bool enable);
 };
 
 struct amdgpu_ring {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b0284c4659ba..bdfd29a22b3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -29,6 +29,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_ring.h"
 #include "vi.h"
 #include "vi_structs.h"
 #include "vid.h"
@@ -6845,6 +6846,19 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
+#define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT	0x07ffffff
+static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
+{
+	uint32_t val;
+
+	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
+	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
+	 * around 25% of gpu resources.
+	 */
+	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
+	amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
+}
+
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6928,7 +6942,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 		7 + /* gfx_v8_0_ring_emit_pipeline_sync */
 		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
 		7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
-		7, /* gfx_v8_0_emit_mem_sync_compute */
+		7 + /* gfx_v8_0_emit_mem_sync_compute */
+		5, /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
 	.emit_ib_size =	7, /* gfx_v8_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v8_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v8_0_ring_emit_fence_compute,
@@ -6942,6 +6957,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
+	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7b13f9dd965a..027997e95e46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -52,6 +52,7 @@
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
+#include "asic_reg/gc/gc_9_0_default.h"
 
 #define GFX9_NUM_GFX_RINGS     1
 #define GFX9_MEC_HPD_SIZE 4096
@@ -6667,6 +6668,22 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }
 
+static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t val;
+
+
+	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
+	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
+	 * around 25% of gpu resources.
+	 */
+	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
+	amdgpu_ring_emit_wreg(ring,
+			      SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX),
+			      val);
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -6756,7 +6773,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
-		7, /* gfx_v9_0_emit_mem_sync */
+		7 + /* gfx_v9_0_emit_mem_sync */
+		5, /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
@@ -6772,6 +6790,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
