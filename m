Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA2FC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173D16196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173D16196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72BC6EB19;
	Sat, 20 Mar 2021 04:19:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9EC6EB1C
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St0KdydGfYlVDMOe9h/5MejBu7QwgolaoF0IENVAOlJmo1GQ7T5nmRTvjX/SHOtsZ+EWyWR/VOGZ+Pq1G4K0S/4EFjA7as19MJEwQaieJh9JnioHo4d2rb1qcaUgjaRuZyY3ePG2Xkg+5NUBOE25K0ZojGc/sH4nR+lmkZHINsuU7R0OvNlAcTpv5eV12NHJeDkBuiSgRncI8rW0lcQIbvjeOYpBRcSWJ3hQQLLUdRUNddHHmGj1x/9VeLvds8MMZJoln5may4xeRCdvDfBw+HV7Eorm6iLj9cNovSj+9ba03CeeHh4RGBrsRu0UZBlmgw2ZEsoIzCwy1RkNeqnBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M52bb6jCmQ7m0LR0JXsl7ssxfmMyZC7x8k091plCPsQ=;
 b=flHcOwVZe7cZlJGo0fsXnkZPh00FvVpL9ewwq+T9TueciS/C02IVedD+Xv0dYE3rYgKTBTI2cyz+V+4E7iFm8ZxouYF8DRUk6g97Xea/sZWRGhQowsuch2ok8SH7HnXvaxCwnVJQUswp4OJfQBEs4lEEwk+5lcHQqgv3MJ+lrhIpzJ5Obekb0SyIYz+JIiRjY0mu7wom5TlKUBksIo0OgUf6GNw4DZGTJFgkMf3blGiuzvRXS8vxrUrCL4HrV5SvL7Fj9aqX3Fm0DFrNvFC6QhHq8YlSqjfi9w7iwa2vsACGARrl8/j37H1e1gQ7w5RaptV31rGxqHPbMVs2LIAaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M52bb6jCmQ7m0LR0JXsl7ssxfmMyZC7x8k091plCPsQ=;
 b=aD+jPbkGw64porlCfuQw193GHx66y1kC1ptKkTUTiweKSDzChdr8st0cgjKGe6GTYuZH+/z29efxDZEQ7nUaWaBwEkZRKbT+jiR/B5nB+bdHNsjhj8bTfzWnF6x4BQJfW4idZH3SkYXG+ZGmyxTl7nBig6B6X1yxwY1b2msMkSg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:02 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:02 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/14] drm/amd/display: Log DMCUB trace buffer events
Date: Sat, 20 Mar 2021 09:46:47 +0800
Message-Id: <20210320014656.23350-6-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:18:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 686bd807-b2dc-49cd-18fe-08d8eb574aa3
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704FC215171586594409DBF97679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUevwRdHPRtJ0fdFd5Pfu7lOOYYPybznRo3se8V25ojGV27cuNSmO1EnHZiam/p+Z8/yq4H0I9u+dscEz0lUnbJx167PtCLRN0pAEToNlsXwLJRkwj9yYm4qKXHPBY4aGQUdfHKH74nAaSHz8fFYBa2SSTcCXPcNgkhw+V7K7JFUcYWf+0dVdqkiubjWpwzxG9ZWuVwC2VxGdnKS99vT+qhioMeRy5qa6PxKkwvp3IvQ/JjHHtBpDBZBfRNXYDQAaf+GMFIv0nW1OCdz7Wst6F5GoM6Fqk64jclTmnpJ8d9UdvIqA1PpuynJ/gkQF+KUn3HAJcmZd/JZ+H/Lp/QPOmaTP8w03gdLrqSf+HiH24I9I+wSnaCbR88GxkHhxf1n2JrR877ScKr4lK9Nag87vhEVxQWuSy3ydiNF7JPcYrDgM40E43nny3YJ2C3iBMnC+LB2YNnJrEkbBGdUynuSmCwdLofgDr+fo2Wg8IMpMDZ5GoIhojAvmDRTCIQRSDLFj4AMiSfS2URAdE/1Ccpu54/VCxsRulgJ+uj8kWkG05Qxni9qPF1kq4BJ/WC1PvKcGpkSgvzPdvRZp4u1X9pxM6A+Kcw6Og1jTQdz302YwtN1l/b7J1am9MjfvNL9DSEbZx+ng6ATTHBN+r9tKYT72M9YraXM32L/s+kY/DQA49c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(30864003)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AdjmDXZJ+gYFijXqCGaSuyneDzb72XgYztRAo9fu2f+nn6yaWRUu8NEjnMF3?=
 =?us-ascii?Q?I/5qKUE7AjrIRk98jXe5GztclAWP90Prhmt6RQcEyTF50eFMraUo1GYSSorm?=
 =?us-ascii?Q?h6uHtgMX4v3XaVNp1yae0sPN0b7w04r/XoEQCsoJuD3VKtej4ueWGr9VcSYA?=
 =?us-ascii?Q?q8j/e0NQalR6VgJK0HeZnw3Js0wh2WD8iE/bEq5z/a7vfy8sQJBaCGle31ei?=
 =?us-ascii?Q?YTSJxZfdrgjsb1tpu5GUq68n3ugeXgFMdLyF3UjvmUPZfM16YJKFvsGKhNuy?=
 =?us-ascii?Q?IN5Z/nefq8e7N3A6SEYHsvUtYW+qWuMM84n/pFKdQMkSCm7JrGGZzrqOLx0W?=
 =?us-ascii?Q?PDWQYbD63IMKjYUA+5z5eTBm74OCmoJSKLU8fOjacwN7y6ONR9i5Z3EIi7lG?=
 =?us-ascii?Q?carxGNEQTDSX23YuDiCmTr+LqbuHITX8/hpkjnWvIkKrlVSAukM46laF4A8A?=
 =?us-ascii?Q?y93rds/AZuSeSi9dYQ2n6xsNhBBrc2PK9tclnzCGT+CV0/9+esDvsrLNPi3W?=
 =?us-ascii?Q?mkaKsdtMSsVFLd6os1/5Lco53SoZDpCwUrB1h9mzseExgbDwlH077tzTr/9j?=
 =?us-ascii?Q?3GC1rIN/bZ7yo0mEBrfV8Zmqg1BnEFPjWF/9wEEnLeqk/KSR/Dnd7jaEEkqv?=
 =?us-ascii?Q?nXlF4ByrX+dq4K0sZCt9WrAkYZol3tnqCPXji8RJFTjfyJSTvmMdIrRXbWaq?=
 =?us-ascii?Q?f1Kp09yMpQAo5Hy9Px6IjhZyCB/7Gm21fzvB00+yOkv9o78UdfxXFBes7zrW?=
 =?us-ascii?Q?W5mLPnNVYOeeHwGJLfIsnaaeHqfHqHYwO90P64L/SbMnSzX8kd7DIn71Tygx?=
 =?us-ascii?Q?fGE9yXGoNcMQsPVJ1A8BDz9Jxv5xtBLhh3BaYtCUYprcPLkK5vlvZnEfmN9D?=
 =?us-ascii?Q?afI3dbtEZbHA1R6FS1y2aw45Q6Y4kQSQa3tEiY+B80Q9sC9ZNEBenWu2mu7v?=
 =?us-ascii?Q?xHsp8xkSuOSDXppJACHdphDg2RVaRJhEVIerhC6bhjgB9qMES/m/l7zwdhY9?=
 =?us-ascii?Q?LSeYLXMVUkgT3Sf9xy4oixFPMOyHU/bnebt3FSV+vSBuzZ9fjrU4TMYB7WSo?=
 =?us-ascii?Q?sS9q46j4vaUSOdDbN+tUCy/PV0pFNOk2lpe6RMykUnvev0RHL7mfNN/pP+ZI?=
 =?us-ascii?Q?ldbU0mfeTfwcrKaKSyCMk9a/MZdN19d8RSaQBBe7bvyEgLr4M3YhlYKQI05/?=
 =?us-ascii?Q?EiAdc8O9W6VGRwAeVm1BCEDygLwzZJ//mT5mYT/E1goAy5vEQWia4wKDojya?=
 =?us-ascii?Q?Gw1OIr4KfPVc/CdRpGAbcg6jH/NVYl12x70x4aXgGZl4JuUsXK4vH1+mhGBO?=
 =?us-ascii?Q?DNfklQr3lMVuQo1Ch8Rt4CUR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686bd807-b2dc-49cd-18fe-08d8eb574aa3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:02.5326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn48coC22Kv+aoklWPCMyFaFHSeIZYlqXw4cmhYZf4B1cbiISQUiPof3jErgNnXMuTyObs225bg9Lo21ViQIGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
We want to log DMCUB trace buffer events as Linux kernel traces.

[How]
Register an IRQ handler for DMCUB outbox0 interrupt in amdgpu_dm,
and log the messages in the DMCUB tracebuffer to a new DMCUB
TRACE_EVENT as soon as we receive the outbox0 IRQ from DMCUB FW.

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 48 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 ++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 12 ++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 20 ++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 21 ++++++++
 .../display/dc/irq/dcn21/irq_service_dcn21.c  | 32 ++++++++++++-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  | 32 ++++++++++++-
 7 files changed, 170 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8b464debc1ef..36100eeefb3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -908,6 +908,32 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+#define DMUB_TRACE_MAX_READ 64
+static void dm_dmub_trace_high_irq(void *interrupt_params)
+{
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct dmcub_trace_buf_entry entry = { 0 };
+	uint32_t count = 0;
+
+	do {
+		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
+			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
+							entry.param0, entry.param1);
+
+			DRM_DEBUG_DRIVER("trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
+				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
+		} else
+			break;
+
+		count++;
+
+	} while (count <= DMUB_TRACE_MAX_READ);
+
+	ASSERT(count <= DMUB_TRACE_MAX_READ);
+}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
@@ -3078,6 +3104,28 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 
 	}
 
+	if (dc->ctx->dmub_srv) {
+		i = DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT;
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->dmub_trace_irq);
+
+		if (r) {
+			DRM_ERROR("Failed to add dmub trace irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, i, 0);
+
+		c_irq_params = &adev->dm.dmub_trace_params[0];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				dm_dmub_trace_high_irq, c_irq_params);
+	}
+
 	/* HPD */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_HPD1_INT,
 			&adev->hpd_irq);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f7f0680c1fa1..9d12f304b2ee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -339,6 +339,15 @@ struct amdgpu_display_manager {
 	struct common_irq_params
 	vupdate_params[DC_IRQ_SOURCE_VUPDATE6 - DC_IRQ_SOURCE_VUPDATE1 + 1];
 
+	/**
+	 * @dmub_trace_params:
+	 *
+	 * DMUB trace event IRQ parameters, passed to registered handlers when
+	 * triggered.
+	 */
+	struct common_irq_params
+	dmub_trace_params[1];
+
 	spinlock_t irq_handler_list_table_lock;
 
 	struct backlight_device *backlight_dev;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 09bdffb3a09e..103e29905b57 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -700,6 +700,14 @@ void dm_helpers_free_gpu_mem(
 
 bool dm_helpers_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable)
 {
-	// TODO
-	return true;
+	enum dc_irq_source irq_source;
+	bool ret;
+
+	irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX0;
+
+	ret = dc_interrupt_set(ctx->dc, irq_source, enable);
+
+	DRM_DEBUG_DRIVER("Dmub trace irq %sabling: r=%d\n",
+			 enable ? "en" : "dis", ret);
+	return ret;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index d3c687d07ee6..ffd18cd90947 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -731,6 +731,18 @@ static int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 		__func__);
 }
 
+static int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
+					   struct amdgpu_irq_src *source,
+					   unsigned int type,
+					   enum amdgpu_interrupt_state state)
+{
+	enum dc_irq_source irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX0;
+	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
+
+	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	return 0;
+}
+
 static const struct amdgpu_irq_src_funcs dm_crtc_irq_funcs = {
 	.set = amdgpu_dm_set_crtc_irq_state,
 	.process = amdgpu_dm_irq_handler,
@@ -746,6 +758,11 @@ static const struct amdgpu_irq_src_funcs dm_vupdate_irq_funcs = {
 	.process = amdgpu_dm_irq_handler,
 };
 
+static const struct amdgpu_irq_src_funcs dm_dmub_trace_irq_funcs = {
+	.set = amdgpu_dm_set_dmub_trace_irq_state,
+	.process = amdgpu_dm_irq_handler,
+};
+
 static const struct amdgpu_irq_src_funcs dm_pageflip_irq_funcs = {
 	.set = amdgpu_dm_set_pflip_irq_state,
 	.process = amdgpu_dm_irq_handler,
@@ -768,6 +785,9 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
 	adev->vupdate_irq.num_types = adev->mode_info.num_crtc;
 	adev->vupdate_irq.funcs = &dm_vupdate_irq_funcs;
 
+	adev->dmub_trace_irq.num_types = 1;
+	adev->dmub_trace_irq.funcs = &dm_dmub_trace_irq_funcs;
+
 	adev->pageflip_irq.num_types = adev->mode_info.num_crtc;
 	adev->pageflip_irq.funcs = &dm_pageflip_irq_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 86960476823c..ac8bcd171b57 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -597,6 +597,27 @@ TRACE_EVENT(amdgpu_dm_dce_clocks_state,
 	    )
 );
 
+TRACE_EVENT(amdgpu_dmub_trace_high_irq,
+	TP_PROTO(uint32_t trace_code, uint32_t tick_count, uint32_t param0,
+		 uint32_t param1),
+	TP_ARGS(trace_code, tick_count, param0, param1),
+	TP_STRUCT__entry(
+		__field(uint32_t, trace_code)
+		__field(uint32_t, tick_count)
+		__field(uint32_t, param0)
+		__field(uint32_t, param1)
+		),
+	TP_fast_assign(
+		__entry->trace_code = trace_code;
+		__entry->tick_count = tick_count;
+		__entry->param0 = param0;
+		__entry->param1 = param1;
+	),
+	TP_printk("trace_code=%u tick_count=%u param0=%u param1=%u",
+		  __entry->trace_code, __entry->tick_count,
+		  __entry->param0, __entry->param1)
+);
+
 #endif /* _AMDGPU_DM_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 0e0f494fbb5e..e9db4f56a39f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -58,6 +58,8 @@ enum dc_irq_source to_dal_irq_source_dcn21(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -173,6 +175,11 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.ack = NULL
 };
 
+static const struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
 
@@ -185,6 +192,9 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 			mm ## block ## id ## _ ## reg_name
 
+#define SRI_DMUB(reg_name)\
+	BASE(mm ## reg_name ## _BASE_IDX) + \
+			mm ## reg_name
 
 #define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
 	.enable_reg = SRI(reg1, block, reg_num),\
@@ -200,7 +210,19 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.ack_value = \
 		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
 
-
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI_DMUB(reg1),\
+	.enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		reg1 ## __ ## mask1 ## _MASK,\
+		~reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI_DMUB(reg2),\
+	.ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
 
 #define hpd_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_HPD1 + reg_num] = {\
@@ -254,6 +276,13 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
+#define dmub_trace_int_entry()\
+	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
+		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
+		.funcs = &dmub_trace_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
@@ -366,6 +395,7 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] = {
 	vblank_int_entry(3),
 	vblank_int_entry(4),
 	vblank_int_entry(5),
+	dmub_trace_int_entry(),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn21 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index a35b76772b9d..238f68cdd41b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -65,6 +65,8 @@ enum dc_irq_source to_dal_irq_source_dcn30(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -179,6 +181,11 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.ack = NULL
 };
 
+static const struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -191,6 +198,9 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 			mm ## block ## id ## _ ## reg_name
 
+#define SRI_DMUB(reg_name)\
+	BASE(mm ## reg_name ## _BASE_IDX) + \
+			mm ## reg_name
 
 #define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
 	.enable_reg = SRI(reg1, block, reg_num),\
@@ -206,7 +216,19 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.ack_value = \
 		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
 
-
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI_DMUB(reg1),\
+	.enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		reg1 ## __ ## mask1 ## _MASK,\
+		~reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI_DMUB(reg2),\
+	.ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
 
 #define hpd_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_HPD1 + reg_num] = {\
@@ -252,6 +274,13 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
+#define dmub_trace_int_entry()\
+	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
+		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
+		.funcs = &dmub_trace_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
@@ -360,6 +389,7 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] = {
 	vblank_int_entry(3),
 	vblank_int_entry(4),
 	vblank_int_entry(5),
+	dmub_trace_int_entry(),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn30 = {
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
