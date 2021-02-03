Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4849C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 16:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D4E64E2E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 16:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D4E64E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4F86EB30;
	Wed,  3 Feb 2021 16:07:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283416EB30
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 16:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwhatZxNME7JZqPIHpZIkNE+LNGKa4ULQFXA7nfLHdFxAtVaSTxCQQSXS5Mhl9MdnOmToC9bcP87e5smnBaneL42wozZp6L9MvB5oT+RLOKQ36PIYun4FR8DUPK+tU34neRuQB4CTJYHSE/MTMFfQmxjsT9MncHc3L2dXWX86UuFAxWfZ9l1j5hmlP878mxfPNlxQz7BOzHvoSTTdX7ua8tcpxwotaYAzHW8siQHAIonfEEb1AvlHzk5hoeytITBLRr0xpGXCsv6k2wD3laiTm4QYk9ycE7REf4SF2erUk+89ogfrtM2ZrI1rvwWjIkQvGPhztOb7/ABXT6pAXbrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mgxRON0CrNCa8/83oZML8jsvv9QXzxqNpAH4OWqWRs=;
 b=EzOLt6jYeL5eceT9e4cVcjCM7+/bcB8P6kydbLpci2yC6C2L6FvRrWqvDj7Reu/WHGP4kM1WFqO+8ASCN/eMiCNisYNO3vm4JBJBAXoAH/Wzw1ZXzsjDWSH2idcfzanImtwaJgvJGGLeWuwpAYy5/WTABsewsMlj6Ex74KQpuRR7IaPrEcu3UWbRlROt0sBIKzdoMG3mIXsImqvr7WRNBR0mSiZevU193Z1DNWujAhZzbXYiZ6eJv3ver9qSZsQf4JTrk0iTfXglkNvLCBrtVPm9f233pxLoTS356Fb5K6gId8y2I9x+5lqzKbn4TFuUsM/kGZ1h56riqKWDf+fTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mgxRON0CrNCa8/83oZML8jsvv9QXzxqNpAH4OWqWRs=;
 b=jdvAaruTWF8YQ2vVgs8IBVWQI+/kjbHLwHL5rGFOcVocp877PTkxscJSu66AJIAwvWSExKrtiEDAMSfLyv63MJx5iCymt0XasUWO2OTyzyVshM4KFECORrjaURceZC8UEwJdybGkQ97/3vaCZnvGJRGbdp5smF/fQIrSspLKZ/s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.26; Wed, 3 Feb
 2021 16:07:37 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 16:07:37 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: enable wave limit on non high prio cs pipes
Date: Wed,  3 Feb 2021 17:07:23 +0100
Message-Id: <20210203160723.98588-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.33.84]
X-ClientProxiedBy: AM0PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::38) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.33.84) by
 AM0PR06CA0097.eurprd06.prod.outlook.com (2603:10a6:208:fa::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 16:07:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0009895-4b3c-4b67-3533-08d8c85dd2f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2971B86AACB8F9C2A45F1FD18BB49@DM6PR12MB2971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YehLUaRbJmGjVSE3cZy6a9mmzLQV/QDT9fKxXH8pjn+LZg1U91S1dlDPzS2hm6lF1HRTQbt6oHATJEbCUj3f8TVjuDd9idsWknjZrwXLDZluqkfkN5qe+B8VVaFOwePgltdfSwgB+bUqYxc+9dUTQExA8bpPPusvcopI4Qw7tuKZQesEMUgCV8aTC0H+Jo3AQG7vpFM9S21kTttYBg/D74jQenif+/Weddi5iSQQQmuxCZCLxSWQe0tmYYfHGSBUFWD2WLDk1uwLQ/QuabWnBpUfIYZxKZgUBGea3T1a1ilTwumrmISbYOwYiKW5DNvreiuXFmyklf8HH1P21bIGGg6rARoJWZWQkSewI4ZE+kdsZDYL0v46f1VTpc3dOtMjLO+FLjM8Z9qA9c7KBg08DViETDdnzt92eV6UGeGWKrNvJWMNz+UUVyUoL8847RGriYFK5KmDjKLaHEK2X/pqolyc8UR/XFUsSKWx24s/yZHPSNrnG2B/6t3Yw9QC1r6/o8jorIkomiE1ujfJwQjaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(2616005)(956004)(83380400001)(66946007)(478600001)(86362001)(6916009)(66476007)(66556008)(36756003)(44832011)(6506007)(52116002)(1076003)(2906002)(4326008)(8676002)(26005)(6666004)(8936002)(5660300002)(6486002)(316002)(186003)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XAh9xM6P56nb+9hnktcnBKnLTVtoPFCUuR1zSxWwHbQXcL3T+Erx2XBPoV9I?=
 =?us-ascii?Q?pYDoXfT65tqjfx9+rBXdGIGylhzmU08yauPYIYtn0twXmDEu8sK97BApT6Lm?=
 =?us-ascii?Q?tNvY4EY2lG/FdUqFw37B1CHEDPUdegFGEGUlC8l/pmePYXFaFAMr7Lc2ndmX?=
 =?us-ascii?Q?8nrNcEdUJYxH8hQeLxEL8yV8tts44Fql7R/dWC0NvM85iP0izlRI4xQgXLC4?=
 =?us-ascii?Q?un6zfgalDduPBVePcwDlssejY+/VlZ8sH2u9byJ3XgIgDaNUZkqrjbiprBeC?=
 =?us-ascii?Q?W1GZCgwSwDqoNwOG7yXP3TTiMbNocxR8tMjWptFs6hGrAyiAX7Mjo1yXJRtN?=
 =?us-ascii?Q?RBNd0XlbOmN6NKjgKjO43vp1+fxW8X/S2tGpjmS9o3tQfENunmTd9CqS8oIn?=
 =?us-ascii?Q?+HbJr5wdx1QPanET1O8w8Cm1WzuLQ6penuFfE4vYDqRxE4fSFvVomKB4yGOG?=
 =?us-ascii?Q?aLSEmuwKAcdHa3qBHguN3e54fcg5rOqIzw8mMgzDlPhB8oMYRoEk4tbLbg9+?=
 =?us-ascii?Q?WdHgjZeeKqdNtQ+UAfrpuvI6IHeAtZEnNhTTmMOoyZ2pUmvYH5+LzR5WGbs+?=
 =?us-ascii?Q?JZmmspJnQfLOw4e5Gqn2LaMQkT3jHrrsjT36Pb84Qj0IN6wR2tISjgGIRUNb?=
 =?us-ascii?Q?ZCXgYXNvvma9Pv9gp3TpJbExGCGdu+WUSjXqnDLbDXjfjkQj8Y8tKCOdmel8?=
 =?us-ascii?Q?U5rtOyFFgUVcIJHCTdpwgstZdTbus7PK1xOgv0nq4vJVA4R7FujuLwVfRHT8?=
 =?us-ascii?Q?Zpo+uznoso9/DLRtkmM1br5tR0LU2xzuFrfOHqJEXf2449E3T85xpc/aA8B9?=
 =?us-ascii?Q?ZBkpN5zxT6NAu5ATqv18sbzTckzOR5Qn/GF8sB90exhkLED9kHj1Ix+TiLGV?=
 =?us-ascii?Q?xItoFVcpxSMAUSJulC9QVV1k+a9GeutGbJfQLNLPAvbQy5xxn2XwxVuE6mAI?=
 =?us-ascii?Q?1Vm2dqPkzSVUgAOtU9OZJ1G//aOeSK5xKCwB3Z6gycsCxA+UESo7A/aSAOc3?=
 =?us-ascii?Q?4IIZ3UurvJ96KmK4CJhY3QGjjAv4bDMWR/MAdWGU8v2HEqKf3NGgGSQF+ADq?=
 =?us-ascii?Q?R7Bd7Rg9eIOItZT2gggQxQacmAFNpJuHBmHaei7CsFF9BWcTtlKR0sXw5KMt?=
 =?us-ascii?Q?rJquUKnsbDCyKD0Jvptbiwio+/eQ0ijxJ4qy1ZETC+PJNT3ADHpB3u4m7C6E?=
 =?us-ascii?Q?vMILejGcal48p5+uqJgfdvtFlFmdnJqzxNF/V3Xnuw8SXbS/A5Lbn2Ac3QsU?=
 =?us-ascii?Q?gL6YDAsyIzzgddsUV/qb07A1U1gbwr27yhnlWCRTh+bccnzt9AiKhZCtLySY?=
 =?us-ascii?Q?g2hr7hiRSqJDx0e9HYgey6s4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0009895-4b3c-4b67-3533-08d8c85dd2f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 16:07:37.1606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpUaSfZ7kCVBDLVW89LlPU5WwKomFhAoKHtvbnvDI3Bj5P65ioto8QQmm2J4x3pPsUZpNd9JyaWnkKQ2rveqog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2971
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

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 49 ++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 ++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index bdfd29a22b3d..28dbce1083ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6846,10 +6846,44 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
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
 	uint32_t val;
+	int i;
 
 	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
 	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
@@ -6857,6 +6891,18 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	 */
 	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
 	amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
+
+	/* Restrict waves for normal/low priority compute queues as well
+	 * to get best QoS for high priority compute jobs.
+	 *
+	 * amdgpu controls only 1st ME(0-3 CS pipes).
+	 */
+	for (i = 0; i < 4; i++) {
+		if (i != ring->pipe)
+			gfx_v8_0_emit_wave_limit_cs(ring, i, enable);
+
+	}
+
 }
 
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
@@ -6943,7 +6989,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
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
index 027997e95e46..e44487ae15dc 100644
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
+	for (i = 0; i < 4; i++) {
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
