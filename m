Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B4C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 13:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A255C6146D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 13:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A255C6146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE966E952;
	Thu, 28 Jan 2021 13:42:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5716E952
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 13:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UchYgSDdczt+gST9j6gu6Hdpo/V8Z0otS2ZJkuQQu/pgrOqrMaZuqLhlQw0voeZ5eyO/7MTk2HhE+dcae+R+xapAVvvzdAVGdMvvdotjXxVjJ9/4iovl7SuH01rH13NrMBpkKqy8w9iuZEcD+0F1cz+GWDdpakVUqZxusa3PDa8a2N0EKuUzoDY6cO29McjmB4apzvze48XMceZN3oOEFvofaMui9q6myOtcfF1XbhS/4c7qaaZcYNz4bnglipVe34Po3x/ddQrRuxS6Hc1xJJIn7BUO9tDZJstwziSDpOb+4GcGcFzJeqTz1yts26FU0hub1hBFZOZdBNaexIP4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ao2OYkjQ5vyPD4klG6zSVVKewpXnEHqXDgqhpD+jDA=;
 b=AccW269k2jjhdj6RV9++kpBpSMTFO/rupyK5054vtb9nHETJH9Fhsp7hI7ItKXti2U0mphPH6qsCQvKie6ipzMk6lHGeI7FiTpxjK4pYjaF4ny9n/BPZSnK8JNHVV3IknEoazpOzl8jdgtHy2BUIqfthEHIFy3UP4zcy+6sbWVL+94kOX//G6En5/UZFfDZZ/oF8sgg5WTqcqXi112wz0jqwMw4KBwnLaFHnBH835CLE0zzmyE5g+gIbL1j7ePg+CD94X4tVuCe7qdEsYf5J1AFZ3tVEjjarDt0IXWfjZWNCYIs1k+2xYgPIvpslDqM7DZaLumh2IiJeHq1weFDhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ao2OYkjQ5vyPD4klG6zSVVKewpXnEHqXDgqhpD+jDA=;
 b=jkqmR177THWx2adab2OzCJOg/qKQlstiO1g2Zswi97ktAhl80s8HS4K61mnvbqerDfB8MsEdMeEDM4ue3Pmb4mr6xzCvVYFrnzZ19DlfxJKqXFFRNs9Mr4tuxgQmI1rU8W1Kq8atKfgFRoMLaO3TwutWD/pG9pYUrtqW8RJhwZ0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 28 Jan
 2021 13:42:14 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 13:42:14 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH v2 1/2] drm/amdgpu: add wave limit functionality for gfx8,
 9
Date: Thu, 28 Jan 2021 14:41:51 +0100
Message-Id: <20210128134152.38101-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.126.145]
X-ClientProxiedBy: AM0PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::19) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.126.145) by
 AM0PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:208:3e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 13:42:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee516fa5-86b6-4f97-0daf-08d8c392851f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4139:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41399D78D9660EAD41660A068BBA9@DM6PR12MB4139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PpRguKsblB2hlJJ2vJHSxGqSVFXreOd3grl1bzp/7OYqofOlIiHkYit37zw68hXgcq1+cyZGMSfU18yHxsrHD5GH1j1QbTtO2WOJ9nuy9oFBE7NMpGIEDDuWu1E01BHmSMer32p/HIpgVGZich3vm/Nq+SPMgbDm9SwHa/tJdJGpahqVkiRJ3nQu1cHIjCMrWxbBk60S9/YCI0MrazzXtYX/tGOtThEsyKmQ5zEnrSgvDak8Hr8ZRlJ9Eg/XexxlpL+Hc5dV4iXiuEuJSQXxYYUYdCLscyxWQHhA/4n6r8XFS2gmDcDj+7gIe4nfBrch4aCjb5jsjxZQQuF45MXgI+EnKRN7hs3uAAmVF0IvX43/nr48E4dNY6CpJey+ez/97dp07iiOlWZWTrNq0Eoj8lHJHf9dBwZxAKbX8o6Y+42ivKkJQO4z1Z+/Sl+4jJ0R7Am+bI+/S5TRXrPsFyb7YScwrNmqIQgeptpwnd9yXgqD1+rleta6e1K9BaU15isNRmvqLINcwnDzf8WNrtmcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(86362001)(26005)(16526019)(186003)(8676002)(6486002)(5660300002)(1076003)(44832011)(478600001)(83380400001)(6506007)(2906002)(36756003)(316002)(8936002)(4326008)(66556008)(66476007)(66946007)(6666004)(956004)(2616005)(6916009)(52116002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EHaPL0sUbxxExPtCwQ3rU0y2Y7d/vzPWoW2CSTMM9NwpMFfD3hddrPM+y2Or?=
 =?us-ascii?Q?st3O+ZNfTIqCQUnGbllK5VdiPjjNDKs7w6yp1EkVCEdDldPKS8ceRbbLVHHy?=
 =?us-ascii?Q?0JacLa4OhcxuUS2zoofMfK+f8+Wkk5S6/m3U4Ieo/x3RPSdg+ND7+hO2MZaV?=
 =?us-ascii?Q?UE/3p0Or0cUkGJapKZBC2RufyCGBwvvNYM7RLPhgnzBFfPIT9vf2Xu7sCQsb?=
 =?us-ascii?Q?GTsIlidkahBskzPKhe9XPTB4mO6Pjj6Zb5HByRcVQIJHxLfB74SZcPCfwECC?=
 =?us-ascii?Q?zTzm9nPD5YdIHKyVIZEwYtKFh+oEUn9rzBUiUewOf7TJvOkj5bvmux3YjGqs?=
 =?us-ascii?Q?HvPN7x6Lt7fOIqYDHqeOGAw5xIkmaf1CmTm00+kfWVu/t8COoytthUC7d/F+?=
 =?us-ascii?Q?a397K8Nr8mxm0uQJdps4LnO8019UfmHHorGW2g3qdXUsORDZ158vGIvzM9mo?=
 =?us-ascii?Q?1qCUgQNUohKxRLcLfGvlDvLxZRlU7tslTi9fyjrLEBMEciXtBZE+i5P2kb5d?=
 =?us-ascii?Q?vcZtF/2zc1kj27Yhdykwq9vonML9OE1C2hFhotLcaNtEdcM1LgwlMDat2+YL?=
 =?us-ascii?Q?itmpJb/0UJq/t20rwUQMA6k1hN/Z3BCzXsRBWctw/dOMA89pK8JpObSLxxZs?=
 =?us-ascii?Q?fjRkGLQkcsh/RThpkhdHvLuJIAxZ/aL2UJwJ2i8RYe9jBKVX3D792WxS+iaL?=
 =?us-ascii?Q?P28lXX8IbBCJfbwQiX4hzryxPKupKFe6GfhloFGZ4I89ZVBuDymFuJDfxKv1?=
 =?us-ascii?Q?i4mAZe/3X1vzHnxRnqHaNG6qQ6fL2KB5hyY0YTqberdxyEbOx7EnaUyxH3/c?=
 =?us-ascii?Q?5uy4TZSGa7VWEpytDpttiqPGBRlJVwVfPOrgMHVUaLAm9T6NbXqtNVI6shm1?=
 =?us-ascii?Q?8RJbese/t3UZ9HWB6GfgMjL3dQP8tnDWJ/dbzYMFCOKpeQS6Hv21YrJK2PKW?=
 =?us-ascii?Q?D6EfJ0yaFbmVLEYZ4pghtKERGwMVYIzBfNSU21vcgvpA9OBoS4awcJPGZYS7?=
 =?us-ascii?Q?qdHQ7d2xBNeqstcr8ShNH/RNCiKmwehn/Vkm+ubzn0g2KHVTmJNul3Gen0/J?=
 =?us-ascii?Q?JVTP+Z1D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee516fa5-86b6-4f97-0daf-08d8c392851f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 13:42:14.1030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/RlRwEpbDOFUSieU6Kcfy9KXaNAdcvwsn0Tx/sgd1LlffVgRgIMk0NSE6hbK38dHi4dK7qiqPKI/tynrfEleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

v2: Use amdgpu_ring_emit_wreg() in gfx8.
    Updated comments.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+)

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
index 37639214cbbb..40ae94b0a471 100644
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
@@ -6944,6 +6960,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
+	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };

 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a896e3d0fcf8..64210544f9b2 100644
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
@@ -6775,6 +6792,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
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
