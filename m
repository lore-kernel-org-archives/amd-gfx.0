Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200A6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 14:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D232074B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 14:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D232074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D877089B7D;
	Wed, 27 Jan 2021 14:57:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBF189B7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 14:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8UEn4d5Wic7ePBHIo3RIKMO2f93lUVogzOvs8bJBfbZ3sMjF0gPCqZjMBqj5ZD34QnnTKvNsf5ObshXz4IgT+MfTW7OGSCVCtCsIybcypc4xg0Wyg2OC4OO09CMTtoSBYgmoLQoO8uCUHSXoxFfrP6ffWq713q0uI5OUATOLyXryJJEFMIsnveKew8p5T5n2U0eM29Ul3i2a8q//WdriYPo9ns4Y9wf29F9VRye+fT1+1VzYfH9SEFfMFnvtvp0tPWNl8cxXPf3LhvMvM+kB3sbD0WTooi/k7oFNxJ5PeJzga6mRf9VZYtjSifvezG+dtsYfUfw6v4Z2T4FNO0R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE/55efm2tsQGuyIEaNkukIT6W0w6XgCyvlEnbNJSeQ=;
 b=JLtaw+zwBFf7jKXNaJ7diBckI4r/HfhEwo+pfZXmWQ3OgrCVLeutmfBeTaHXMSz+N2zGbk5ME9O/NnYKG/yx6phmqCVRe06FqOu+8Avbf8CHw59+U8+Cd949+gU364DIi02XdFYICfOY6eoSzkdxtxwg7T0ODH2/ytXaBbmEpTtpn4XImWIaP3lh+1sBm/VsfC8dIwhGUyE/BU9PvbVfltWdYMXdGErQIn6XJN/XVDwVFGwx46baR6/bN/ckWr5f2wkdisswIsL+datZdgrY5mHCfmNJC2m6smzmOCcM3Z4fxf2xW5+D3m16y/xWV3ji2aKGtAxH+CiNgXqXRr8NWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE/55efm2tsQGuyIEaNkukIT6W0w6XgCyvlEnbNJSeQ=;
 b=QoSZRakukhWFhWtMmB5G0L6K6f/IuswDRLv8DKVMD5X6V8rOAPB7u7KxZFWRRSMhoO+AlK/HDnxoZcnfovNHcqGJmMK8PwFaOltDB+ZlyT2MqTizmlPGqw34FF9UWBPqXjEuHfAYz/ks0Q6ogr5E2nbm/f5V0OB8B4TODMcYjco=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1900.namprd12.prod.outlook.com (2603:10b6:3:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 14:57:40 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 14:57:40 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/2] drm/amdgpu: add wave limit functionality for gfx8,9
Date: Wed, 27 Jan 2021 15:56:57 +0100
Message-Id: <20210127145658.13099-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.106.115]
X-ClientProxiedBy: AM0PR02CA0167.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.106.115) by
 AM0PR02CA0167.eurprd02.prod.outlook.com (2603:10a6:20b:28d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Wed, 27 Jan 2021 14:57:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b3036c7-ae0e-41ac-6196-08d8c2d3e48a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB190014C9262BD7B888DC4D6C8BBB9@DM5PR12MB1900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWGcqeptQEI3jYOn94ypsHOAg5H00hoeLFc3eAWTQ48018NU5/fCuBVQNyBPaOK+fHqaWtDzJHkil/rsmZ4CLDomle9jGHEb3ZDKpUqkQ1KiIiuoGPCEedoPeMZFHHEno6OhEmRW7233gjuzMsYhcYfVb1kUI8TTpDXGA0i5eq+s1mQmtTc0c01KRKmcE8ct9X7KKTmMqTLFFiQxujupYObYygz4aq4B2pMsG2aqPa0KGwjPlMisM9unau94MydDJ5n6dIN97vtSgoeQ/GiBXE8bIk0WYjscXsXseaKbsuA7u/L9rX11+EgwtgZQkor7p9pnDLEOCKljvF1GTKiqXrmxwp5nOiUvMkI5tiYJykWri8pys+1woQCA0hipumHUHDaBv0/cQoWcY/gZpynjOnkpnIFdJvaZf5ATCTUI91zltPOR2kh7nj3UijHkrJIdYoebNfmjKlPc2Bhph2rF99dGoP9I1uNZqq7mgKPydDxMyOvsIgMNGQ5gOveVfX+L0rGWVAdN7tKWla5Aa3gEdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(478600001)(6506007)(8936002)(186003)(16526019)(52116002)(2906002)(86362001)(6512007)(6916009)(316002)(6666004)(6486002)(1076003)(4326008)(36756003)(83380400001)(26005)(66946007)(8676002)(66556008)(956004)(66476007)(2616005)(44832011)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gbMOC18NZq8+OHvj8HTaqwGePLZMV+YrtWjo35yQSc755K+vAUkpLbmPy+wn?=
 =?us-ascii?Q?EZ21I/QVyMeKQjVZb0ExYPudQWM1UWtMwqJYKMt93MwLjf62tnOgegwM6eby?=
 =?us-ascii?Q?GpK72XTLHgcw3JVfX8/w+fqc40FPKK/x4zDzCcYvbMCnbCJXr4PSIL1irPRN?=
 =?us-ascii?Q?x/ZmySroCiccWTVmBRMbKAwTaNvMRaX5EIL+8IILGWc6YvYVLEJry0rtEjyX?=
 =?us-ascii?Q?igF3etuMtf2DfkgHlI6XthT5kV67EOVG+ebnS0FWHbXLnKDnFbcLpg4wKOzC?=
 =?us-ascii?Q?VCJEb5a8IwarAE4nQ5l1mKNTaggFaCYGDqtqg9Da8+k7B70YEuUqrSRt5izg?=
 =?us-ascii?Q?2+9uUgMlRZ9ZTeXDkrkzmHK7sLLn5OJH5dSXc6lM823j2fpB4WtGcOE+JPMa?=
 =?us-ascii?Q?l45fPSpwma2buj/qCuMwSlzWsQ1vxG9rUkH4qYMlClrJv8JYXfP5byGpFhiI?=
 =?us-ascii?Q?wIjMSNsntSxS48Ie8YC8+LAzQt8VOWnzUkBEXpEcBaYx6IiOP0qcXQ/51zIR?=
 =?us-ascii?Q?fcer4y7KNIizKk9xPceuagIsGiF7EKrs3MBOByA0m7rkgzrTGE0fXMC9bUky?=
 =?us-ascii?Q?33ggGPFPlSgcRWBLwGOPZUmS9x6tOm6Ybht2fMRk++fdR7CPY4oOQnz4FvqG?=
 =?us-ascii?Q?jAsgieS/j6jlvhQxTQrMY0gIXHTrOu0YPOEWrlLIkxLBOpdpA+/M9q2pakcV?=
 =?us-ascii?Q?97gCoLJKifoRqfNji3WlOGjT8phhytKYY2ttggdZJRv674kHxufchj58ziYe?=
 =?us-ascii?Q?po95EjNSF1EjuvsRHofe3egQMj+qF2ezt5Y1q90kuz6PDrV0MUft58g+k+dj?=
 =?us-ascii?Q?oFUyWpWtgp/Zj4PDvSdY2XipzXahh5qNXgDo0/P3Al1tQt8juv9u2LSGjGgl?=
 =?us-ascii?Q?79uOSLkEwn1m7dEYXliVyh4QAPqMQyBtDAWztd8J9jLh1NxKQy2laCbTJ5N4?=
 =?us-ascii?Q?3j/3SdrFcKz4L7feqDnF+kMn1P9Va6oV6mSSaZWEVXGN/IocBSFR2+9oniL4?=
 =?us-ascii?Q?IxDEMOek3lI0TQiaMJyp7X9UNFeoWrSJFrWJ2Vk5XdAAPNgeNVgzu23+uSfO?=
 =?us-ascii?Q?1F/rvfni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3036c7-ae0e-41ac-6196-08d8c2d3e48a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 14:57:40.6963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6AWB2CZIQLeDA+fkB8s4EiUdc7Q9cD5IqgGIBVeoJ/fb/I0oSEz+GbYnp/YJcYjDv4MTzTLuH7T6s1SyQBHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
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
70% of waves for compute jobs

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+)

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
index 37639214cbbb..ead2cae3927b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6847,6 +6847,21 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }

+#define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT	0x07ffffff
+static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t val;
+
+
+	/* mmSPI_WCL_PIPE_PERCENT_GFX is a 7 bit multiplier register to limit
+	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
+	 * maximum 25% of gpu resources.
+	 */
+	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
+	gfx_v8_0_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
+}
+
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6944,6 +6959,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
+	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };

 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a896e3d0fcf8..e94737d82915 100644
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
+	/* mmSPI_WCL_PIPE_PERCENT_GFX is a 7 bit multiplier register to limit
+	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
+	 * maximum 25% of gpu resources.
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
