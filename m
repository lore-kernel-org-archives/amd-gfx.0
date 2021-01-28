Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C315BC433E9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 14:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6504764D9F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 14:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6504764D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02596E97F;
	Thu, 28 Jan 2021 14:36:09 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750053.outbound.protection.outlook.com [40.107.75.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AAC6E981
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 14:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck2xg6xhbuyT3pH0xQ3+kT2b30KaeXZoXabjdjjyYM47Xv+W3tIb6nQfvTCTRPmHG7x6aWmUwLVxSj5VRtS3ROzAq8k9gsybkgsPAG1UEEXafN6DJn70XnRhMyr9kJNiiaPvDC9E0WtyPzSB+HNGHORuAk2KfDIpWw+oW9uYpu09S6K747vi99KAIx3DJJ/7fWvg6quSXD+jN5i8tbfA2OKlFq+yrttUytokVNxIPGqMVy+D3cH6KV4QkuGE2hHtQyS+5vXD5d2c016mQjKdpUtdmi6JHfXAAOilDtCLL9uiNfpUr4fvC/hQXkB69saoIAHbms8Nupi/tJ64iKGtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nupJILqwkkTp+Z8W+G/irLmtDBi0LJNWTZ6QCNZxQYc=;
 b=giBnq6/Y6YPHasj+Zb9nA6I04CIYV9DNjxm1Rw1uP014Lm45wI3wF6CflOHkwDmMFqYgugPl94DNgM5xqLs/adT/P+/KdZFfkdfTgjiaZqB3akMxwYAVF9H00yGhmYkLS4P1yVDhCstxfbk9S4jcxouMSuMy0EXlxqNQWT0DkFt4UC+5+T9EcWk+orP5kPHRkDXs4yLVcyqQKd4w4rzxxKWENrez4k7+bL0wnZwiA/mseCT0TTi/z/7yhlL8h6ERymUUcc/xP4jSZCuJzIlqpZvNQXd5J88OgZqRzpe5ipQ1VYXnwICRBDHk0avG/x53qKG9LgDZeErqOzqkk2TrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nupJILqwkkTp+Z8W+G/irLmtDBi0LJNWTZ6QCNZxQYc=;
 b=P63J9frqjqQwA4GGb4twWqtJOleenHniJ//q95oZeOyxpWT+WB0UwB42ebPDXb5UdnKlmQtmoaDJCsHuBsXeoMzuPxS4ZILnn6zFHhhcw8/jCvux+yD7okjavZHQgFn3uaoUEmuT9g0X7qGbYcrsO32ticzu4Szrtx+Ubvm2CO8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 14:36:07 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 14:36:07 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH v3 1/2] drm/amdgpu: add wave limit functionality for gfx8,
 9
Date: Thu, 28 Jan 2021 15:35:53 +0100
Message-Id: <20210128143554.61100-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.126.145]
X-ClientProxiedBy: AM0PR02CA0167.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.126.145) by
 AM0PR02CA0167.eurprd02.prod.outlook.com (2603:10a6:20b:28d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Thu, 28 Jan 2021 14:36:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 495ce3f5-4d90-4403-0057-08d8c39a0c40
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4202DC2B47D3C808664169518BBA9@DM6PR12MB4202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IV64syYyy2fk2cEZBwQvcAnES/DpNHcxaMS5aWwmvi1nOstCqynK8f4gQ58SvNxp/w6CInXd+AwgCkYq1aSEy0INSevpVgz9JIuvez7wBwEQhUo3qmlpvLgR9+IiI9JvpbxSXb6VcN5kfHCMaAwRiMKOAM70kpoBJqQ1bd6ZXECWOMOnzJm+9vCfoJA52YMSYZh733NhiOW/Plw2JAtRwD0xIOtBXhw7RfBLhelsD4McWtAFGhJ+UiZPXb+KHd7ribMHX6Zm6no/lmycRJ75t8w1vEB6FzKAD7GFZloAFisn8UAiEDAHM2aZFD59wFsWkblKzPPtGA4Z6/aYl3oTPVZhcbT3MLpCfi/54PiMM4M4KwHaJpB3wN/ZsEr71IotZdhjOO0NtrDEsFBi27oDssHHmq7eMxzGS7oJetJHd0oVIXolowBBNIo//gWHLYZMT+MD9kpQgsX7m5cbMYVlVfFB6OWlAY06Xo47h/+N5PMyweC2I8fuVUWb/dMB8bkp6vZ8+6sgEy1S0YTiVktAcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(66476007)(2906002)(52116002)(2616005)(66556008)(83380400001)(26005)(66946007)(86362001)(36756003)(1076003)(5660300002)(6506007)(6666004)(44832011)(186003)(316002)(6916009)(16526019)(6512007)(8936002)(8676002)(478600001)(956004)(4326008)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gn0NaRVxgB9bEwp/zHDC2Cxo/8B9PG+VIkhogRu17nVX0aduuQp4xQOP91NM?=
 =?us-ascii?Q?YXvsmKW+GxPKw58XirM7gr0GGraaiewCl5E0BgO2EaabkmIOlBYIWnmkQACP?=
 =?us-ascii?Q?BbhyAAplWrxTieF5ecCTPtH9YVgLTu1n1cJ9U2tRr2af8FZKhKBD4Lh3Juyz?=
 =?us-ascii?Q?jUjOdp6EX25p5MpSogAyeXiyQoz6a4FultkXmHIVr6uNRRHASjpREz2F+Ts4?=
 =?us-ascii?Q?ilaOhX5ONHhx27RStQHaEOfx+57gZWXYNT701OHHrws841VJBzSm4rUX4V+v?=
 =?us-ascii?Q?4RwEvT6OchnZdxVbdVEOOCXND4fnqMp0QP5wz8afUAY66TaZ4iwMGXmaBwaJ?=
 =?us-ascii?Q?bGHPr8Bbt3rExIAxBnr2fWTkOWPwvnpT8EvPRF+WW/J8uPCkurfTqqelo2I9?=
 =?us-ascii?Q?1MRJducE9qZvEtXu2rR6FznzboDS+0d2nyqgnUVFrEFmK/vwOZMVVxM2rhWZ?=
 =?us-ascii?Q?7gaze9Z48L10GgpJHDj9DIYQXk6b63lgkrTu+KyBwad5lYu3z0hqVD+ZPRtu?=
 =?us-ascii?Q?SXEqENJgz87ISvu67cIkSD/JzZPXATVkrPfkzuLWtlHZjca72d8inn1Gwy/J?=
 =?us-ascii?Q?e+ZQiqev/NSm6EuPXsedDvuXM60PCnpDxfPYvXxKRU0bMpRctC2+th/VKN0F?=
 =?us-ascii?Q?81CPue8NUKF5inNmFd7azP2jIEPVbfCrRrT40hh3SkuXFSjiWX6m9NGYYpot?=
 =?us-ascii?Q?IgV41Mxcc7G2K63/dACHJUPlJ3JgODV47xntu6Fd048qvWyMXohDxAmJCnKf?=
 =?us-ascii?Q?RarCgGu/8BaZCRCwC3dswpgqg1eR0YfTQVqgrkrvctckhZA2iaKRbQmF6O2u?=
 =?us-ascii?Q?+2/72h/dpqeIno1DxHA/zRqJoIrlVIx7h3Z1Q7So8jxGnz8AKJ9OGfn76Ij9?=
 =?us-ascii?Q?1TjyQpRjh31ruXvZopxj1BP5sJ1rM4hNk4deWIdc04FT9bcFI7b9WvI5F/Wt?=
 =?us-ascii?Q?1LqBpU3u8o+WcClBKBft5BKqvoVe511YvT58Em1Z+9vf2MN7mBVQEuOPJAPy?=
 =?us-ascii?Q?lSLkj5OAca4/JUjk/w5vTIimMn3eGuWzmnsHRmBODxsMEzkbABVSOmpcLuH3?=
 =?us-ascii?Q?M9uQS1Q1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495ce3f5-4d90-4403-0057-08d8c39a0c40
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 14:36:07.2525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vdjood59vBAt0vBzH7EdT4EhJk6boFyA3JOoFSZ6++RxfockGnqEboMhmlpbSd9vh4u8zEeCZTjqNv0pxmIVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

v3: Updated emit_frame_size.
v2: Use amdgpu_ring_emit_wreg() in gfx8.
    Updated comments.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 21 ++++++++++++++++++++-
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7112137689db..220eec886f23 100644
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
index 37639214cbbb..9140e3f75a26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -29,6 +29,7 @@

 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_ring.h"
 #include "vi.h"
 #include "vi_structs.h"
 #include "vid.h"
@@ -6847,6 +6848,21 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }

+#define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT	0x07ffffff
+static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
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
+	amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
+}
+
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6930,7 +6946,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 		7 + /* gfx_v8_0_ring_emit_pipeline_sync */
 		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
 		7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
-		7, /* gfx_v8_0_emit_mem_sync_compute */
+		7 + /* gfx_v8_0_emit_mem_sync_compute */
+		5, /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
 	.emit_ib_size =	7, /* gfx_v8_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v8_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v8_0_ring_emit_fence_compute,
@@ -6944,6 +6961,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
+	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };

 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a896e3d0fcf8..3022aff50ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -52,6 +52,7 @@

 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
+#include "asic_reg/gc/gc_9_0_default.h"

 #define GFX9_NUM_GFX_RINGS     1
 #define GFX9_MEC_HPD_SIZE 4096
@@ -6670,6 +6671,22 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
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
@@ -6759,7 +6776,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
-		7, /* gfx_v9_0_emit_mem_sync */
+		7 + /* gfx_v9_0_emit_mem_sync */
+		5, /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
@@ -6775,6 +6793,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
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
