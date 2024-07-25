Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45673C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECED910E842;
	Thu, 25 Jul 2024 15:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wBa0nTVp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36A410E841
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcA3ZotnZvKo2n2L9kuYjS27a46dZh0obazhPA8sPrFjV9YwRwIVr0tcf7k9tjL9W91bB9QiWf9+kXQstdYaQFLsQRdFUpc3rQ0u8Cypm/EddbwLOLZWlJLRu8sn+PI6F52qdhy4vkYL6fl37jUlZ3eiI+BUTEKDFPUBNEvpQuanANxOF6WvQ1lB+7XoP7gXRyWVNQurpaVKqQR3BHSfUy+Txm+ONO2uYj3DuULnmD+Hah3/AfCIDZNNK85DV1swpnVLIxzoFinfgdTWt6NcaOshnKsooEo6PashgZ4FqWMgDLD3wVBap4lyLfE+Q45vyZPi20EHlL87+DIdimd5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kToSbrDKR7tvcQwCGXdljdiDh5LRW5ytvSN9RQ7rxwo=;
 b=abOLLcxFq7dyXcrC9SQyCZhe8/wSVSiBaN0caDzokTmVSsdeWThS1dIz3q7mGzSnbYQdCMCGdWgH2geHyrGZ71KlE8iSFtCYnePUuePXQgx7QkCU0eATwDBik2VIbco+XmnIFCOkuWbID+vK+ujmyTS67eK4EN84uD4Vl+aJG1sRoDlpGz08vNaoQc5F8Hcb67jlGcdDq0Iie1iwB+Q0KBiwUNvzGo0vvpwvIm6Tcp1keCNMrN03HCfYCHmkReph70viCiiWnbUpLqobQ6HNQB8bcHq9tdd1kwVjlsloGhLsCFnHfrJy+XMPwgZndN2XnqqK6hjIabM1xmn78rbojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kToSbrDKR7tvcQwCGXdljdiDh5LRW5ytvSN9RQ7rxwo=;
 b=wBa0nTVpeOjMXIN/7BS4T46ZBmHS5M6o/1WDYzQhLuhzqTvuoSTB8tj+PPWJRWzVfYlAGzkEbJOa2Alc26GURtoIrLh+4qORu4SevsQJKAA/KIcKngy57aQByetA0YPLF7U2hdnCye7xBNqtlUAOtCvB4csggJ48vfAyRAvnpw0=
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 25 Jul
 2024 15:01:17 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ca) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/53] drm/amdgpu/mes11: add API for user queue reset
Date: Thu, 25 Jul 2024 11:00:09 -0400
Message-ID: <20240725150055.1991893-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 374b703e-03f0-4bd1-2e48-08dcacbaa25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9WqgX9/cZl3SepoWRk7c2IUF3FU1ZHnnYrHjSDSA8IRIRAMC077Y4qcEaqiq?=
 =?us-ascii?Q?FlzAFfKcST4ofj1AOzOi2PEwHtPewDyR1IcwPf9V5SgKmhbyduykD/dYHV37?=
 =?us-ascii?Q?KXlLEFz3E/g5hcprb/XqhZ2Wo1TJ5TowKy+lQ1wwUvoU6ksczctarW26BneF?=
 =?us-ascii?Q?RZnRjpfwnNuF+ftJmq7ZvlC0wAeF/f8lup41ykBOcbCgCZaXUuOYz6eslnDq?=
 =?us-ascii?Q?4lyXSWVR+56SrzUhyfBi/XdvMvkyomu8Ns6HgYeNxXsxX3Vh+qtN/kmQDorM?=
 =?us-ascii?Q?ea+LOyfu24l177I0CrbbQAJ2tOjuFr5UGpSMK+buJ8DBll0tNzsNqmg5iUHj?=
 =?us-ascii?Q?70+XLPo1ZJXrY0uwt72AhpjPkWBbL5FtAs92rm72/ePQOauTWGq2cVBw5b6f?=
 =?us-ascii?Q?WSTxM1ZhZ4dQlNTeFugrZJTFMRCt/WHgStwYTIse550UyuyBYsajOfbv/Kcy?=
 =?us-ascii?Q?FLnEgAmTj+BTrGD17Js7CxY5aL9uAO8+lz9lGnNZ5Gs7UDrdz6QhLuDR87hO?=
 =?us-ascii?Q?I2qspL7w1Vlk2br3pxwaUCLyO7MfUaUOZOUDemmDAiwoCQkDWzIkapHB2AmO?=
 =?us-ascii?Q?pEWTitdYM7xeREJYQHAdn6cFkc630jxWfwJG5WpTaX7xLT8bS0IMSe0uYSJb?=
 =?us-ascii?Q?q4XI9h5uzyX/yV51e9ugIXnXfpXaRH3DDPbLX77T3Twrk+Seqd52aPGrPr/1?=
 =?us-ascii?Q?caj8eCx7Vj+WRI8gQnwgS9OE6efl2StiNnXLYIlwp+UEXgzdVpFip5SHMi2r?=
 =?us-ascii?Q?4E4oFW0xN1g1BAanBwrT0/gxbQuuHCoWCd+yYWR/c4Q9cZQkRLQqlBM5Oih5?=
 =?us-ascii?Q?LuG+0E20RfcYOGaFvI0Y05xUklvR2Zj6bQ+layEPEJFLO992TmFkp+oCdkdo?=
 =?us-ascii?Q?RwHPFCHLsbDXtaVbVgOIzz0sVEajoH1AgVXc8IumEbU9K00G/Wl/3JYC0vJv?=
 =?us-ascii?Q?g47Pojn6SegssZCCamfXxEgD+CiaYIWmCrXKr2z5GzayeIWlsonNHwYDVuJr?=
 =?us-ascii?Q?mdIDnWBmsxjyiXjcHJ7PVnBGDJLNnyCkt/xztPU/qi+UniP4b076vkRDO9Q0?=
 =?us-ascii?Q?xTjCIaWPuKI5VUhVFrh3UDZ82sE9bkh0TsnRlM6ot/bxewKWlufo9qFeZY77?=
 =?us-ascii?Q?edA5YEN7mvBZ/E0zFOjzZti2C5gAq8gLkj/wXjM+EOK1cwG5w4QA+8wzz8NA?=
 =?us-ascii?Q?VuUKCtDFVGwHhKX0e9eeirbu1XTzP10H7LzxjMR9kB0pxtJaChRiIJ3u4gts?=
 =?us-ascii?Q?IGIu5I80Cx75uIq3UTH/V6Wxi7/xn/SaArnW5Kyg0Xd+LR8+xv8iWn+4Byiq?=
 =?us-ascii?Q?UeE29cQdPxggDNoXRJnysvmAqoc2biO+Dqul1DarZuCpDtLVAeOM0tdkLLrE?=
 =?us-ascii?Q?zJShrl+1aPjDjBci6eC0/m7i75XF83ZzaPymYVMrC6kFZnCi6R9FfS6xhzIr?=
 =?us-ascii?Q?gOrcQhE0fuo1UP0Oc1dSiY3vLERuA2PQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:16.6493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374b703e-03f0-4bd1-2e48-08dcacbaa25e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add API for resetting user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index afcc10e21f6c..afb40d70e41e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -360,6 +360,26 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
+				    struct mes_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr;
+	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+}
+
 static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
@@ -638,6 +658,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_legacy_queue = mes_v11_0_reset_legacy_queue,
+	.reset_hw_queue = mes_v11_0_reset_hw_queue,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.45.2

