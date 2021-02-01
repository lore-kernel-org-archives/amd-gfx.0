Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D042EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D10364DE1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D10364DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2076E7E5;
	Mon,  1 Feb 2021 15:33:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBF56E7E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1CyDOkJy9ywHR+DEN2XVeiQAwg0PnytKdVjrAmaOtuMUoIti8BHwEvtLsqgT9/l9H6xngvJ3Qx2KTZyQ+gX0d1uNbD5NSChu9SJzN+q2VzKw98FruYLYIkJFvTQIcdGBKL7xR3l7YOi2HOmWEAgs3yuIilahd9rdRpKCwv4bp4lxZBlfiZ5VzVx0RIQT+Z4VI/8VjsDPnYfN4BdTNpdRA4GbMmTFf3pM+923sIT6g0JMW3WJz1IfH+j8pTUewP9LMz4zbXjuz/Eirspe3SyLL7Bkw9edPWje40JHFSvr7TxoURYz/xNkIE2oIxSB0lMyIO0gwGrsyLjbUiTp2wO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5lglcyd0puzdTIKVE44OHQ7K57gq92j+xk+Ihd0yyg=;
 b=gWS5WICuik92Hnf8yk0odHveZdIYIvSDBGADC32nZpSDaV6qYT5BXnk5f66SRII0PXzz0nztH7QhNz940FF22C8IVWgwa6+Ok+1Iwvqty1G0EJu0zTKFlb2aJOQWckQ6FtWVgPKlVk9BZlTvbav3WR2oiP7xcTnWPPySPVorgpbsXPqaJeqHAqQ3lTR6opNH25q3RL/n5uzb6a7nv4olRCXuEwLr/Jr9ykaDGDOXUZ1hmorjBHyjiZBOYwWlDkDnvaiWt3b0gdGDGSq7PK4Lhb8VVsun9dHoNzfOYOhvPsynddQtUpWbNrteIm2TwLeh2Ji6OOvHbVxWOX4YXsM6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5lglcyd0puzdTIKVE44OHQ7K57gq92j+xk+Ihd0yyg=;
 b=GEjkKp5ZQqeiJvUAF+viwBHnJ3+mLM2BjE52jZQ8YepIORBsTW1BYB9GdYFWh8rSJDdCJVuheLJMsujQ4BN751I7DmZ/el0om515Jexw4N0kc6HSmHzZzt4mKHDK4MNNwGDx2oP1cUAiZcSLqu9ih6X/O3gLtxY0niOvIMDXDTY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 15:33:35 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 15:33:35 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: add wave limit functionality for gfx8,9
Date: Mon,  1 Feb 2021 16:33:20 +0100
Message-Id: <20210201153320.59415-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201153320.59415-1-nirmoy.das@amd.com>
References: <20210201153320.59415-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR06CA0089.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::30) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR06CA0089.eurprd06.prod.outlook.com (2603:10a6:208:fa::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 15:33:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d650edf-0ca8-47b2-2bff-08d8c6c6bd4c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB490921F10A2E89224D9D805E8BB69@DM6PR12MB4909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoG6gM3oUUZm0VPx4dGe/EU2AQ1h9V6TDT0ZSadrpCYnEB//01eWmT6IEeJEc4BLydGyhVWGBaSr1V+HFlJR/Y2SpZFC+gDP0q3y4cQoTYC5ap0nxyuJmZSRBpBXYg2GgW8Hrsblp2IJO78HuufpfLO4yQC6HPww8CrUbSqAdbYpgbZiAh0J2wYWdxKJXo9Mxdw+1JYR+BqsZTfklZ2BBp2pv046H0X3a3g0awFlYbo5sG/lQtQvcPuBm/1m0tDiJUtaOZinRfONi2vZn7XLg9IQ9B3Br/c8EpLJEneoK0niRDe/3y9KjCNWTrLzHbZs40jn70pgzeOTEZY7WlggcIn6IrQKS+tfbkTYYohqmr1Fr2sc3mZRnUYapsUHzehdcu7HfcZlfs8aqV9hcCwq9Hbqp/1Dljw/o4Y8Nu/fWXsbHfwlDrQKEBDWoapO/Hg3owRa5brPS970q7ML+G3t/OyH+Thv2Pe0w4l33QSG4ozCiiKy14Ry9iIDPC5Cq+L7Z3D4jvbGVFouWBzU+phAYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(26005)(956004)(2616005)(86362001)(478600001)(6506007)(6666004)(6916009)(186003)(6512007)(16526019)(8936002)(6486002)(2906002)(4326008)(52116002)(8676002)(44832011)(1076003)(36756003)(316002)(66556008)(66476007)(66946007)(83380400001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Tq6b/sQzVOhZDbxTGyrAzw+VMdy+vPooYHNmNNVfpeAn5GW7Kbd/0PP9WBxV?=
 =?us-ascii?Q?xENUXbyM6w6+6q2xEb0/woZPawyE6zqtpt1QnoC5bdUHIbRxVE+0KdR9yjWy?=
 =?us-ascii?Q?3OzMCihsPu7VqVxWSoeQevC/JK+1X7toHASolkHLK73nH2fzEwZ+jPqTJ05r?=
 =?us-ascii?Q?HnkbBccvWa1cMX68mDlT55PUfio5B/gvOQLA1lYvedchY1GuAFiHSXHE4DYb?=
 =?us-ascii?Q?5zbXw6T7kvfGapmUADCc+0+qsMNJB5mH3Uf66ERGqoHqNf/UQB+M/qFOc6J9?=
 =?us-ascii?Q?TCcV5Q8AHEgkpi7uCtLh4efylwyrExxPj2nD0pxNqUxiB8PryxcgK+kn6U8g?=
 =?us-ascii?Q?+g066gAsyU/6I8mPQvpknyoNx/wquyd33l7tujyGMD65vz8A+ZmjRRwFnnzM?=
 =?us-ascii?Q?pWM8kXXDK2N0pTrDBIpM10KMUoq5x5c/jgJdJl3NClSgRLyjDWqvOhPrkCPp?=
 =?us-ascii?Q?TLnKrTMqxhD+qIfHXYL0JOhvXeRL04OUDN0kSr8iq4vWigQzFDHkXcNJJxZl?=
 =?us-ascii?Q?UIwqdy2ivOIs6z4OpK4e34cwHS6gxJayFXGdNp+8A+mExbhoY+1OsXLTcv3h?=
 =?us-ascii?Q?xuf9jmxYKI7+XPrPN+c4VteIKaMRjg/U6+Q60FWVxgpzjWOjWd3RTd2rJLk4?=
 =?us-ascii?Q?/fMuqSTcsTE4JtLrno4G3L1yhKpKD2tMPwZV/iv7bTrAXzgzP0IYc1LKa6rj?=
 =?us-ascii?Q?1KgHK8BmxflPkd0O9oMd79P/iLHf9bkQNHL879nCHz9p50mYu4iVlGHREMx4?=
 =?us-ascii?Q?JKc4enCX7I1B/QOL4GLAgnOb9dZBzzzBR+ipFQdlFQhzH95y+8Kz/OQWKdDj?=
 =?us-ascii?Q?k2iaBg0h6eC0T6lqDLYOSRe77LM0Xbjwk25ETNhdJyOLctoxMui1NV9d5Tlf?=
 =?us-ascii?Q?EtIIVVcgnaTIJO6OqAlX2ra2O01lRLPes8JswLWYzdYkzXYvo9OUBNy5+1XL?=
 =?us-ascii?Q?mD++PAHjT17E5ZeAe5icmcZjyCFROyWdS01l9bWMvHJqrADO4hie3If+yPla?=
 =?us-ascii?Q?rJ1DNDcBD3KiADsYE1yqNJBpS2lS0EKaRKqyXCvT/KiShFpct++Vf1e8RHNj?=
 =?us-ascii?Q?3mvwMd4t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d650edf-0ca8-47b2-2bff-08d8c6c6bd4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:33:35.6224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfxrtWOVokAXq2MvsA6HB/8lj9+J1P7fEHxikKsoZccCpQCYV/rVnWohjuq3Zj/99W6k3Arak4JIoKk7pt5IdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
index a831003c2d53..267293548e87 100644
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
