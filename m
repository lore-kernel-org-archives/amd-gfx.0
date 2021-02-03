Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FDC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 17:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3DB64E93
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 17:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3DB64E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353F36EAC0;
	Wed,  3 Feb 2021 17:11:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 535276EAC0
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 17:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwIvOaqBMGsBqAM6UuB87JQI6zvaY45Z5C/4dbJ/ljWrN+uk8/secwlOd4+gHq+vPds736g2xO0wXF2jyaK673/cGF++CniP/Y5wTLnoHpXlvu46iYizeZ2aYESE7MxGUkRfHXHj//QQ9jBANdIvihw13OnSDomy5JVKRhJn49G2yDj5h5wK1CC3YJ7q7YdD55gTa2EMboLyo7LG1i0RCm5gUmxPKe1zasgTRlNwwTI7BDopMYRebWXS6/UCfuMdI4bL/UzbtroE3TkElxx1+VShMDt6tPiWz6EO4wvjBNMOF6ndZIZti8gifXzQwHcGd3kjaNt7OfEUesZvJO4Scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qq5u1h5qnm6tSz+9UOWAZxjU57a3q1tx+mXx+sSDRo=;
 b=ek29k1ymTapcEAmTaxKbBxEAAXrxadtGq+CrKTiHL4t4xNso7dvPIVQPdygAMMen8ptTGccRrgkN2KQTFllXGzE8Ro4DoCbnQl+TO+JfsdNHpRlptQhbCLGKXNq62zf6f2zTdqDfqJZ6NOP4ql3RWr/Y6lJsdnmV5BpfHROmYXrEG01w3jNXhHlsV4/e4VwaNZcXapMJ1bZOa/hHcLT+HXhb7IYSDBgXiVic72nVOzbFpbWG8MJrB+N+PvYBICfKYJRdWNxLgW7ycRugrXw+DQW0qc3SEKGZyiPY/4heUE83nW92pMgZcP8pOUqLSxhoP9e8mYv0DORL018G38kGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qq5u1h5qnm6tSz+9UOWAZxjU57a3q1tx+mXx+sSDRo=;
 b=F59E4D8BI94lAGP/P8ZvZT/qkcCrT5L3I8W/BHWv1P12tkFzHp9DW6tdkjneDLM0CV+4WeKqfGn4D6LFlin/ZBOABKj8YofdfTMVeQhX/ZG+0eLxC2/lFoWG+GiGYPw9CsYPxRHuCiBLpp7wwp53Jtc7kbdkozdoOlrZdWdK4Tw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 3 Feb
 2021 17:11:44 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 17:11:44 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/1] drm/amdgpu: enable wave limit on non high prio cs pipes
Date: Wed,  3 Feb 2021 18:11:32 +0100
Message-Id: <20210203171132.121236-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.33.84]
X-ClientProxiedBy: AM8P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.33.84) by
 AM8P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 17:11:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fda74828-9610-4fc6-1aca-08d8c866c816
X-MS-TrafficTypeDiagnostic: DM6PR12MB4417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB441720DCC097138DE1946DA28BB49@DM6PR12MB4417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EC72dLIOe78hiWAXhP1Ph0ZxQ07kH2p00qpLmSDaiXesek5+L6rQ1qTvf17z/0qP8B/yhxMRAeJQC81RBPlz0AY4ALf/SItFF+A+Z1TgEH0uyfX1aCD5+uiCgw95Lsmm4T9/BN4HqQ3NB4op3U9LVilUF8WD7LegTZkynEACEp/eaRFRroQ2FP39zDipiDsb/a7a6n7q6X3xvDfFciucx+4jyy7Dc1CXDrdrmqpcGI9YTtoRu0fpNzP9R1KNk5cG7pD8s1ia8pbq12LmkLn4GcblhI2yeLWdi9MG/y8lwCNeRvtALaIm6Rw0XU0lq7DHq0XJmGo6Nxvu4bSkqrAhgK1VqUSUeAiIjz+zqcWXz/Kix9Ykb3A81eF7+TX8owa8UqS7EOr4G/BLWIWIIpxW5vgPxWsg+skAM3c6sPmrMoAzbhcsT5y19J1WmWE0zwoev730pG9YKUVp675V8w9FNbZuNSnJ3hH77TKch67oqWSQd/khv1scLKzmcYP5OOENePcBXPeAiIpR40olNy+xWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(6512007)(6666004)(26005)(316002)(186003)(16526019)(36756003)(6486002)(83380400001)(44832011)(66556008)(1076003)(5660300002)(8676002)(66946007)(86362001)(66476007)(2616005)(478600001)(4326008)(2906002)(6506007)(52116002)(6916009)(956004)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sOQCzoASCNLWkg46zbk8EQQjtoypAcJcuF6dCiC7I7lxRbwv+4ZMnWrGBpcf?=
 =?us-ascii?Q?sKwSGgnRpBkwU0zOB3XOxLp99T901OxSkIQfX+C02LonhR13pfD8IFw9kPnL?=
 =?us-ascii?Q?QcsH4OPkS6JLq0ccfjQLFUF4v891oUbPk7dBQ5SAHCpcKw7O69/dpsxQrIPN?=
 =?us-ascii?Q?e8jB2r88lEQVUHleO3x0BOiS9CUT6gvzMwXiryhLU/8KEgGJ/I/fz/rBdhGN?=
 =?us-ascii?Q?xvxro/SETlrAGWBjAdMO+yN2mue0AgHU+a1uyVtZCV5fc3L96GazOB1K+jJc?=
 =?us-ascii?Q?kajlWvWAjtLSERxglNOhoukvuvqN+kSFUV77qft3xqgHsaEFkMDRCIM4QflT?=
 =?us-ascii?Q?4ApLZuRQalvvkToKgKpJ5zf0kQSyIPGG2ViCA5TBvb66GWjXO2XG2nHY4MBY?=
 =?us-ascii?Q?VzCIBymaK05gjy5qH/XbynyK0iDoPeaNNnCSXVc+gcLVtccKO7mk6QW8/YYU?=
 =?us-ascii?Q?DawYFMQZCgD7l44t0MHKjQOT1h/acGhwNX2lVrYeqmjpqEUC6s32l2QoK4Rg?=
 =?us-ascii?Q?LUnYWgdA/PSkqf2E2NS9c62goBhvynoRJeTlV0Yoxz4c76oMt971ZlreR1kV?=
 =?us-ascii?Q?MPAa/VBDLriwvEORGLQGwtVeFGFQ1tCe0Ib4GvQkXT7hmKQcbdDumJet5ldn?=
 =?us-ascii?Q?sbKj+fYguPxnZeXhmkrBqCyhv/Gd9oC3gIXd0j9j8NVKuwt7XPkumQPJbvr4?=
 =?us-ascii?Q?NexOpEsznZL6AHgygEBR9Mf1oANsnVAvTaNdX2fpKfB77khV27h98x5JxTrC?=
 =?us-ascii?Q?Udtz0hNiPWZoeFcZFMQV+Ynevb6VUVI041O+aLe75Rf++SPOA6ltnag4Bgmp?=
 =?us-ascii?Q?CFW0fCYBmHfccaE7RIkN68t5k94/TR7DOKj+K+Obu5hcZzTrptFokVUpTLxe?=
 =?us-ascii?Q?SSCZx7JiOe6/ZbHJL7IY6NGNZSkuln51Dxk7I6BBHOwsvrTTedjw2/NA6qKl?=
 =?us-ascii?Q?NcSfbLrQNUW8vRq7SRrNvz97yikjvU5RfKE+ZTwpNn9lnMhKKBVPR1o5VmiZ?=
 =?us-ascii?Q?KKKdj46xHRl9pP5gQfTwjusyITuMPyCmYPrV/h/UxjfWDHM82hqy8MkcD3VD?=
 =?us-ascii?Q?ACP0zNhAt8UBbFntG/WxKuh6OL2ggrmPlLn04u4q+m5hYHSwQs9ynkacE7Dr?=
 =?us-ascii?Q?dXGqYV+DmDq5yTa7QOeGF6K0I04nyTCwU1dwwpco2vVvr6t1SlIJLkOeLPGu?=
 =?us-ascii?Q?57SU2Cqj9mDZWEDbKeWPC3LMwbqpKoimH95AyVWZmNfytOEjSlqzWzSnCN7k?=
 =?us-ascii?Q?8DimAW3TBDKxFgv65yaLMiGZUIu5KzGIU6WEoqguNJUCUzgwEWR/VNbfXOZg?=
 =?us-ascii?Q?F03he+Oxga++rS/H92+yPQtf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda74828-9610-4fc6-1aca-08d8c866c816
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 17:11:44.4455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OfcLeF7CjkeYsyI9YrdZeOVu5MLHT0tBFYOh+N0Zmddi+45uNp8uEOBNWgxEWSWVwhE4hcW+Y+wrzFcQ9HrMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

To achieve the best QoS for high priority compute jobs it is
required to limit waves on other compute pipes as well.
This patch will set min value in non high priority
mmSPI_WCL_PIPE_PERCENT_CS[0-3] registers to minimize the
impact of normal/low priority compute jobs over high priority
compute jobs.

v2: use adev->gfx.mec.num_pipe_per_mec instead of hardcoding 4.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 50 ++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 +++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index bdfd29a22b3d..84d2eaa38101 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6846,10 +6846,45 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }

+
+/* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
+#define mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT	0x0000007f
+static void gfx_v8_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
+					uint32_t pipe, bool enable)
+{
+	uint32_t val;
+	uint32_t wcl_cs_reg;
+
+	val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS_DEFAULT;
+
+	switch (pipe) {
+	case 0:
+		wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS0;
+		break;
+	case 1:
+		wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS1;
+		break;
+	case 2:
+		wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS2;
+		break;
+	case 3:
+		wcl_cs_reg = mmSPI_WCL_PIPE_PERCENT_CS3;
+		break;
+	default:
+		DRM_DEBUG("invalid pipe %d\n", pipe);
+		return;
+	}
+
+	amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
+
+}
+
 #define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT	0x07ffffff
 static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 {
+	struct amdgpu_device *adev = ring->adev;
 	uint32_t val;
+	int i;

 	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
 	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
@@ -6857,6 +6892,18 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	 */
 	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
 	amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
+
+	/* Restrict waves for normal/low priority compute queues as well
+	 * to get best QoS for high priority compute jobs.
+	 *
+	 * amdgpu controls only 1st ME(0-3 CS pipes).
+	 */
+	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
+		if (i != ring->pipe)
+			gfx_v8_0_emit_wave_limit_cs(ring, i, enable);
+
+	}
+
 }

 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
@@ -6943,7 +6990,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
 		7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
 		7 + /* gfx_v8_0_emit_mem_sync_compute */
-		5, /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
+		5 + /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
+		15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
 	.emit_ib_size =	7, /* gfx_v8_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v8_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v8_0_ring_emit_fence_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 027997e95e46..65db88bb6cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6668,10 +6668,42 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }

+static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
+					uint32_t pipe, bool enable)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t val;
+	uint32_t wcl_cs_reg;
+
+	/* mmSPI_WCL_PIPE_PERCENT_CS[0-7]_DEFAULT values are same */
+	val = enable ? 0x1 : mmSPI_WCL_PIPE_PERCENT_CS0_DEFAULT;
+
+	switch (pipe) {
+	case 0:
+		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS0);
+		break;
+	case 1:
+		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS1);
+		break;
+	case 2:
+		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS2);
+		break;
+	case 3:
+		wcl_cs_reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_CS3);
+		break;
+	default:
+		DRM_DEBUG("invalid pipe %d\n", pipe);
+		return;
+	}
+
+	amdgpu_ring_emit_wreg(ring, wcl_cs_reg, val);
+
+}
 static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t val;
+	int i;


 	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
@@ -6682,6 +6714,17 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	amdgpu_ring_emit_wreg(ring,
 			      SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX),
 			      val);
+
+	/* Restrict waves for normal/low priority compute queues as well
+	 * to get best QoS for high priority compute jobs.
+	 *
+	 * amdgpu controls only 1st ME(0-3 CS pipes).
+	 */
+	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
+		if (i != ring->pipe)
+			gfx_v9_0_emit_wave_limit_cs(ring, i, enable);
+
+	}
 }

 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
@@ -6774,7 +6817,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v9_0_emit_mem_sync */
-		5, /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
+		5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
+		15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
--
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
