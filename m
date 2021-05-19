Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071BC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 06:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938F561355
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 06:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938F561355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105456E219;
	Wed, 19 May 2021 06:03:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF7B6E202
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 06:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjbEqiuRrGFzB7fYo4vPskXCsJ69GwowWwg/Dyh00rZTZ+/v4lXF1YrqOkWaWqz7obsS1thtmizp134mo/r5P6Y2US///3Bt9s9zzaXnRAbSIqskkYin0OFNlwhYHlW9U6zuD5nFugCCjIg0xBxZasPB0siqk++yE9o9NJfJr8IzDx6fb2jH22Jyl+KdZVI4Syf3rk9sr+hh3m36vE/g/B6tqfpZ/J3q+N//KVGUKKHSCD4d4Mf8N/FaoCcRodUPN69ceoItPUHIKg09gJrp2ufZZVIWb5EWlzn7ZBYrh56ZBkCe8d2G2r0kx/nr0L/NO0+I7Ox6rAwqGuzbqXL4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDO/Y6begsWRjM2L3idEAIaQZL4poJEvqrNefcXR72o=;
 b=iYmUHi70rxaTr1K9xv1sWjfmUQwSzbFQGgU1mE+r29TJM9QZtIuAirRFXIi8ppmfORbv8Nb0vmpfzpgoV/1BwuJV3yFrAF/hqDeTU540cvg/kT3oL1uHtuyT2wZ48kghy2RcRP/uhZkim7x8wJK0IyIbAYB1HxZM0VeifEoeQoqwsWeCpJb3D1jLOCIIcEFX5I+Y6uPik+AeC5QG4Kupzju4tb5s1SX+AWG3DGoR4sN14VmSdPg+4/3Iu7Q+Q61b3DLpnsl4bXNr/fkCp7g4ij7Bwd1llW+J7NMDoZWGu4WR/Gr2YWmiikEZODGf9dV2NOT1vo5MThojkqxpN9ZROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDO/Y6begsWRjM2L3idEAIaQZL4poJEvqrNefcXR72o=;
 b=yckrG/gBp53aEQgvZ0OqzRGDcJrDSIdeANmfEtFple5g2g6yTYb9OGMG9TWLwR7UgSPdQJZjo/aYO5zsG2k0nIgzeByMB8//DimONYrs4xPrcuH3MNrwda8ouxT/4EoIqwJXAMZSY21HsHPKklVdV7OdLzjm3TEJrxF7oPaFKRc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3287.namprd12.prod.outlook.com (2603:10b6:a03:131::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 06:03:08 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 06:03:08 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/pm: Update metrics table
Date: Tue, 18 May 2021 23:02:31 -0700
Message-Id: <20210519060233.13597-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 19 May 2021 06:03:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49567453-8f65-4ff5-c5ca-08d91a8bc66e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB32871C73FC2D0E779B1447A0F42B9@BYAPR12MB3287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxUDW6j1vL4WR2bzZ2GttuyCIjh0H+tip7sOTPyBBzMy2B8fwzmzy3+JjRBDW9vbagSsa21xrv5BT1EROOBVxnWWq3i1g4+ZbwpgLNSwCxRDbuf4DBOQgZ7GDGucl0n1LKCeyeT05gm8ui5jGOCJmfoPYTf4CVRMHsnVoQlbblX7BU48KbTp5aIZTV1aT6XHMkpY2XpitVMf47Vq5D/LlqeatLGoNLL/JpSbbMwdKtVuCpTabf1+2jAiKGc9JO7oIII+f8yE/eMC2NtV7EsXZeCATA6cCZlvYGFtauU9HA1oOY2gSt/IKu84QXMwzB7od6q2IN9K/rB2kIgAPgTvj4rKT6u4PGw09Hna/yqTCBPdubE2N6Z6qcoVakTWY0WEZm9VvP0NDGrgsRwQxxLXuZfvwZCnSBfKqLVEVbtZAInOk5oXxRtwQphAH8zBrmCM69L/zyVsL9an8CWg6i6wmodejs4fnJGDDvaEEgpbvOP5F+se1WsTHrd+MZ8+UJKWmKEN305EF09/VVf08Jl8wFmLJojdxSAnFaFFrMsM195lHZWaLX7A8VL27Cn6xnhEaIksHb2N4aB5q4NhV/PVGKQOx9OHbOvkqvmqAVvUB8+BdUwNS+k2Y9h42k9Cx2M27j6jAiplGbvB264gLDRbVQN/B01vgZ5TBkjGXjCnjD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(5660300002)(38100700002)(66476007)(38350700002)(316002)(66556008)(6486002)(8676002)(66946007)(8936002)(6916009)(2906002)(7696005)(52116002)(956004)(2616005)(26005)(83380400001)(86362001)(478600001)(36756003)(1076003)(186003)(4326008)(6666004)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CQnXzIy/8FD+23upvXwL11AQEVlaPr3gpWMrm2JW8//Z+wMYwXc2J/jx8WYB?=
 =?us-ascii?Q?ONkgptmTF1dSW1RMXVWxyMG+KWq6XY5keeFs9c5ugB1v8WTUS1P8jiReyEpF?=
 =?us-ascii?Q?ib0JM91U5S7pPQGiXn2/fVzOxC0MnHw1dX1PU79tH/+NquRCHLSWnjYXU/xn?=
 =?us-ascii?Q?k7qddS6F2BTcTRVpVJ4eOK7BBKneHr+aOpjWoGdu8Zr26DCkXYUtldzeghBA?=
 =?us-ascii?Q?reSNFOBOvxv9W2whWBBOK919fodm7GCzrnRIjHh9MLVLXOB78trSgtQaoSAp?=
 =?us-ascii?Q?A2mX01RDGJSKqoi80N7gXMJztOjM39PHftc7aVmXVICIxW/JBiQwFZ7R4VCB?=
 =?us-ascii?Q?2Yjb5AJtl78iUrgSaq2hxSdZNnC1cPk/qotzvnVJQpVmFVVN8gsQ0O7mR6HI?=
 =?us-ascii?Q?caJ+En35wjiBw95SYc1sXpWW35Whbn8EJPqO7U6N5oJdTb23AXfnKRtORoSS?=
 =?us-ascii?Q?4K1Gd2lP5NMZinDYUEwywIm22kKesya6EehgetvYBdFHV2EXd2MIR87GPKiv?=
 =?us-ascii?Q?c0lqe9sEP1/kVv7JHtBnjkfV5cKt1aefMmsSBghPQ7q+eQCJ/fSDb5lcX86l?=
 =?us-ascii?Q?5eGzPeDNMoXwTlcNFTtrQDs/E8XRYWtCZMWV9D82YNouebtYqinqYS4BL5wn?=
 =?us-ascii?Q?wD/FUHxDPS1Km8KR2Qgq/yHngXrj/bHZctEH8Eajkd3CFFjd6HdTWNgEi1JM?=
 =?us-ascii?Q?jpKGGsLMGDM0RxCVtawU5zDJpupd79tJRCuYsmv3t8fOVELq4JkiY+X8SqlN?=
 =?us-ascii?Q?j5zdV8kvyZVKyvx11w33MuEdDjSt9KajnryrkHD4B6QFlzR8rLh88cIyMQ0p?=
 =?us-ascii?Q?7acVtC+Pf0vmRcYU/uUlyfDuuxPqeQDxsGBtR1UUZTYJhVmi2dN2XHRNwLYH?=
 =?us-ascii?Q?osMALmvYIWEzw5bZweijfWKFFkKChGua3CNq8fOMpsVC9cHmoSKu1uLK8lYL?=
 =?us-ascii?Q?gacEJ5UoTR1nF4MMnSWmTQXvBSFRA2wIe9vQkhu3QdNszX9vzTim+08S8gwn?=
 =?us-ascii?Q?NyoPlXz4Q7oq7Cbr0zk1eDb9bNARSyL2WKJi/pgl1ZZpTzqL9MslNiKvW/Qc?=
 =?us-ascii?Q?nK0It968lhoYG41NWy5qRXEnulBkyW2pnuzdKNY6hdpl2yQJYfXx+36koi3L?=
 =?us-ascii?Q?MdA3AVLH1hvu979ZbCV4owTdkQsG7KSLGLMGYgX6Hp++ivofCGZm25SMaKa7?=
 =?us-ascii?Q?GrZQOotECHBhcl4+VS0UXmlRY3DJAllaiOYXY5VmccOiPHQMdCoo/OZVt9Jx?=
 =?us-ascii?Q?N4eTP6qtH0zGIF2acXHDYAjZ0srHQo+lZ3Vl0FRhLZ3lDqbE51xNBSZCIMxc?=
 =?us-ascii?Q?s9brCKVqZGb5KRv/hkd441Rk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49567453-8f65-4ff5-c5ca-08d91a8bc66e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 06:03:08.3839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIWt3qC94Dm00rYifNalcUi4J114m9gpmz6f1pEFItaLXzMx0NE2kEHsf6VzWK0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3287
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

expand metrics table with voltages and frequency ranges

Signed-off-by: David M Nieto <david.nieto@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 69 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e2d13131a432..b1cd52a9d684 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -536,6 +536,75 @@ struct gpu_metrics_v1_2 {
 	uint64_t			firmware_timestamp;
 };
 
+struct gpu_metrics_v1_3 {
+	struct metrics_table_header	common_header;
+
+	/* Temperature */
+	uint16_t			temperature_edge;
+	uint16_t			temperature_hotspot;
+	uint16_t			temperature_mem;
+	uint16_t			temperature_vrgfx;
+	uint16_t			temperature_vrsoc;
+	uint16_t			temperature_vrmem;
+
+	/* Utilization */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_umc_activity; // memory controller
+	uint16_t			average_mm_activity; // UVD or VCN
+
+	/* Power/Energy */
+	uint16_t			average_socket_power;
+	uint64_t			energy_accumulator;
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Average clocks */
+	uint16_t			average_gfxclk_frequency;
+	uint16_t			average_socclk_frequency;
+	uint16_t			average_uclk_frequency;
+	uint16_t			average_vclk0_frequency;
+	uint16_t			average_dclk0_frequency;
+	uint16_t			average_vclk1_frequency;
+	uint16_t			average_dclk1_frequency;
+
+	/* Current clocks */
+	uint16_t			current_gfxclk;
+	uint16_t			current_socclk;
+	uint16_t			current_uclk;
+	uint16_t			current_vclk0;
+	uint16_t			current_dclk0;
+	uint16_t			current_vclk1;
+	uint16_t			current_dclk1;
+
+	/* Throttle status */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			current_fan_speed;
+
+	/* Link width/speed */
+	uint16_t			pcie_link_width;
+	uint16_t			pcie_link_speed; // in 0.1 GT/s
+
+	uint16_t			padding;
+
+	uint32_t			gfx_activity_acc;
+	uint32_t			mem_activity_acc;
+
+	uint16_t			temperature_hbm[NUM_HBM_INSTANCES];
+
+	/* PMFW attached timestamp (10ns resolution) */
+	uint64_t			firmware_timestamp;
+
+	/* Voltage (mV) */
+	uint16_t			voltage_soc;
+	uint16_t			voltage_gfx;
+	uint16_t			voltage_mem;
+
+	uint16_t			padding1;
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0934e5b3aa17..0ceb7329838c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -764,6 +764,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 2):
 		structure_size = sizeof(struct gpu_metrics_v1_2);
 		break;
+	case METRICS_VERSION(1, 3):
+		structure_size = sizeof(struct gpu_metrics_v1_3);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
