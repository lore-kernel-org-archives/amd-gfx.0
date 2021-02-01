Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880DC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 12:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AAC64E2A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 12:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AAC64E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2CF6E3D0;
	Mon,  1 Feb 2021 12:07:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88236E3D0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 12:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWNN5DPrFiSlXGQlR4mQEmRMTp1W+jtmboMnLMhKchzRr8p9Zw7gSRHlseQkngXx9Ba7j35X/khArJbBzF665usnxO7pLHactJU5KW+5ICYemlYeh12iXmEO0ayfQaZPe6G1bsKSrPy7IJ6MUgNXGZkG5mjt10PM2tUiS+RBtUfNbsAw+PvvKUbSuOYC68VswYSLgXXguFBEG1M5Z+9qCg82c5gaVfH8Pnf52fY9x2byghq4HLk1XEtXyRc7Glvo+l/P8UTRibEhwN+OoEYKwdBavPBoQJ68blk+5vTc8yZhhZSWopjYMGLJ2LA0qfIt1q29LHfZdoY4yEBjZcJ/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvgBDXTRkx/T+hOREm32AW4HVDOF7hZ92APH9bfTpgo=;
 b=gd5tkn/XZmcPciRKIOGmsw71Gwzdwy3RQLbTKkjDWJg5IfkRdq8zN+rSfUE/55+V5lcMrL0L/QajP3wZm1iVWp98O5S6va4NB61NHlnZvEvanCI0TQVc993YaEtg5fvQSdKPKCrrOkv0PTTleI8vQZMdiflBiq0rYnO0juw36YsIRH064POvYq0U6mzw1SercF8US58+HKAlltUV3glO+V/SSmzPC+TW2MHxUl7qydV7rFAMIi2CvoH0suzOi5xVRKUakFog4ROESb3dobe3Y4pmmgjp89n4/aNNrIycopF4rUd35PiJe9q/oRHn5DZlLqlKQ6ViLinVyhFf/vVO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvgBDXTRkx/T+hOREm32AW4HVDOF7hZ92APH9bfTpgo=;
 b=lr21thSnyMdISUDijM40rKpHY1WDA6Bmr1FIG5NY6BmZX0+UEzD2v4QmIKHYF4Fck+vXf9gq+Bs6vLFQswWo4PCQiU0YHZg8wAE8m/qIgKMknPA1rswAXqT59RFH9xwXQC/xUQmyr4lvCbQS44W8XPbKf7ZPj1BqfKkkY353Rjo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 12:07:51 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 12:07:51 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: add wave limit functionality for gfx8,9
Date: Mon,  1 Feb 2021 13:07:34 +0100
Message-Id: <20210201120735.2970-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201120735.2970-1-nirmoy.das@amd.com>
References: <20210201120735.2970-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR05CA0087.eurprd05.prod.outlook.com (2603:10a6:208:136::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Mon, 1 Feb 2021 12:07:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be3b32b3-5e4e-461b-79b8-08d8c6a9ffa8
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2454EF09B3945F792F9738588BB69@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +T3fiQPNVQ0h++rd8rykm7slaIvJw3ZC6xSuo5901qUfE51Lo3v+FKkAY1t+9TJRcZ8eKoGAXhyz2I9He5xOJphkFRpsLf5I0j2IXHzWPuFZY/hrytq7fNEAxZrFjf+sSiB94wfHOZdssF2cb6HSarZEq0DFTpoAxfneN9Hxa1AETvIh2yPca4ZCfsQ171v83IsRKgyvrPg6DqC5gev0+1QCQr+BIrlM4Ub+D7u9dTwnGpYRDGYAjnUdCyUchRvkHFyLo5vAqy4hIBhm9l8iBrk2CwNGTZOjp1A/NhAEu1iqZF/JZaJZXitEDBYfvBVtJkPKGfPk8F4uLu8shmuP1d68aXEkCrlG01AJ3fR9haJn1bQhXL4UdorpCADcxtVJhRGon05b8MzA3r5fbqa7slkP7KmY9/mwZnEhUR8SDYItPeyXXwAgOEmJtpTR1QxIyrgin0eP4YwKrsWGYIHExcpYjAEUkURNtAVdA9zh3/MYIk9X/0U1DGjnhKkU3AYXqNyoALHqLn3f9Je4wUWdNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(52116002)(5660300002)(1076003)(6486002)(316002)(66556008)(6666004)(66946007)(6512007)(66476007)(6916009)(16526019)(2616005)(956004)(26005)(6506007)(86362001)(36756003)(478600001)(44832011)(4326008)(2906002)(83380400001)(186003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LH2Mw3ptxmkXNt6Dz5wfYus1iVwo7iFIOifjuEufnKki4G1l8zPO3vbfnl/k?=
 =?us-ascii?Q?Tf8yyMdgDbkyOtzKAHF9l1FH/xCAHlG+86/vWg7V8kQCiUcSLa0ge44mCQhX?=
 =?us-ascii?Q?ZAjmQwI2xpxjOQKJbJHy3FyfuNcnjcrc0UFJrNFcNOMMXSgrpuGx7zwH6v0f?=
 =?us-ascii?Q?F1GaFDQYwflV7L0ssTLsX2u2fP43dKBqWFV0SYkfwl58UptFXZoEvngcCW/r?=
 =?us-ascii?Q?icgMUXqsjrtWCkthNnWQTVBY7hlkrApQAr//czUkNqfrvGaVytSxdjIRSzcc?=
 =?us-ascii?Q?tu09FhPvz2zkRygUaynI7PiD5NbfmTP4T0A4oKlnteE9vRqPM5Bua6JSOAUJ?=
 =?us-ascii?Q?jWZOU8a8VmVPridZnUuPjYtIEUCrU7u+fWSQ1IpZaVnsXyuefB7GwWyRIT5o?=
 =?us-ascii?Q?iHB1hEykn7yFLc7iYLAUJZtIxNjcNBcpDrmnRzLz1eZRa/27RKTMUrBY1rYh?=
 =?us-ascii?Q?gXhmo7GJqori/H6IX9E9/R+Gg/o7hQMbQBLGBRa3g9j4XmKuqhd8SMjl2Fw1?=
 =?us-ascii?Q?42Rz3ECsQCnlk1jlob5BIygwRbrIP3kNN+DPQcwRnGYhyVRZ5xAZHwdUb72f?=
 =?us-ascii?Q?89WLD24ftoxBCiiFvK3nqhGJqWPNP2OSOj4B3KXIAukbVEKjgQub79+Febmq?=
 =?us-ascii?Q?fcDcE37Cny313M3iv08ayB2Jq04fLNFHoH3x3ioUCEb1+2LqKiwixjnUer3w?=
 =?us-ascii?Q?3Nd0RKuzhDXAfzdbIbATEdYguvawDacPk8xSiUhOqljnUphg7PK1wBN13+87?=
 =?us-ascii?Q?JGNKDwELKMdbq9mwPkrsmJpUjJeRmlvjI1nJTeKZTbvhzTQBE0xkej8ueCtw?=
 =?us-ascii?Q?RAMR4lrhuN3Q+AvXGp8gM8VTzkQQa2oWyLZNRISCRQBFPNiAgoDG9ctNdoWT?=
 =?us-ascii?Q?tmIf1GAc1InnAePk4jpdqFcGQhmuPNca3zIaIX4TVuAIysODFWmHlYAQo/Fv?=
 =?us-ascii?Q?9OYdlfEH1WXKx5VKn1fWbV416be0EZU7sTKgAFGYtkuvwmmaEfKvHSqZHSNa?=
 =?us-ascii?Q?4rEjd4gIIQ2TYhpPmbIuXzVolOztUABvZD9pbsMsi9wUFU8OvqL6n2NemXHd?=
 =?us-ascii?Q?qG0sOosi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3b32b3-5e4e-461b-79b8-08d8c6a9ffa8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 12:07:51.6057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCPU0YHKkqqlmt1TGI+FWEJAxyO0WbsCLrQJ/l77s8n/ij9qw8DeqBWxNLSUWayTYl4p8VNI+EBtaGVz/M0fAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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
