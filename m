Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61321D65C52
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0088110ECE1;
	Wed, 17 Dec 2025 13:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VDFChTu+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E13D10ECE1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqGFFHE7Zn8l7dDqZIj6W+dGy2wanA7eouEpcfb2cE/JCBlMp8tDC3uzAEAZW6Zzww+qO0nWK+k6Hr5obGpDTqyR3lG+OLyV0Y8IHLVvHulvIfwVE1ek4OEnvnBxE/AkDYLjcfRWrOIYnWge5I5sHpBnVQsOoGNYi+fAWtqGJ2olW8eb+rxN9rt4KDz9q8uWA5F48h7Ggz04YI3Q/DarEj/SlRZQ41I8JudYaUCuPEBV6bomnoadwea/0auhf0QsxXy3hMKgqct1atWSCASKdy/fWj+5rpdySC7jDgHOWfxFjOMvt3eSyuXyIZGwm6p0knHCixsJfUHt6smy8cbrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJtxLOSNjNpYzgLt+zWOqSHUmBfRsf+uAuR9F5ckSig=;
 b=DQYsoMlltYjYltXCM8GQ9Y9QEyjor6Nrdkh5R2+3IEj+KCiy6rr55okUARONqxxiTZ0YfmCGnGYLzlfUU8OuanWcJKwBX4IG5mIb4zaCjwoU4c5KSXtJHWtg+tXy59ammBtBTb7g+vKByr/UihPKyThM+isSlqoG/3jwVNAd5RlXKRtPNRMlwLyff8GbW23RSKgX3xFcz2l/inroKttUocj18KnhBW9adgUftKNTYHSgFti4ETqS9/Q+qB+nIMN5wAzjSPqmxmPGQsme0eR3dN0Xb9z/A5HdjRb2TytcOPMobOfChqZ8Or8ElPC/Ts53YvjzDKoNtG28g91hSb8ebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJtxLOSNjNpYzgLt+zWOqSHUmBfRsf+uAuR9F5ckSig=;
 b=VDFChTu+9eLxKsBwqZwWqBb7d07alzPB99u4dCei8JRPrATaDPbR2wihW/03OfKYi3qMIWbSUKST1iuGNBZJW8d7vuzz5tanuLCSVtEt5AC47vwPmlOTBOZKZc/lWS3X69MUf5Z/0KdQnoEeqDe5Il5jA3XTZs6bNgdZ0qcMSek=
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:29 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::e9) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:27 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 19/21] drm/amd/pm: Drop unused ppt callback definitions
Date: Wed, 17 Dec 2025 19:18:12 +0530
Message-ID: <20251217135431.2943441-20-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d477a3-3064-4d0c-f142-08de3d73f02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?naQbRVXk7WcwK8L9jWmxqN/2CM5B0VevzXGcfw59hoZwJ4YT8ZKU5Bo9JJYS?=
 =?us-ascii?Q?jcDEB/gPgaSMvIRrPDBgQtDSSnuOdmzwceIYpwaeqq2Yru97zBuLyGo7+U+T?=
 =?us-ascii?Q?dA2W6yWO3MGWKmvoe6KqZksvoAqm5pYvHnjXaBNe+gI3MGYt2bDpvJwFUp+b?=
 =?us-ascii?Q?XZylQhGF4Fw0Srij/ADEsAR/nObGaBSnuBxGCcUbTL+jgOloQetgJtVb0J9O?=
 =?us-ascii?Q?nDoTzM2Onq/bqJmCjUSsz/LUk3L9LcQVn5B9UzfwEhVwsbL36aTr6+TtdGMG?=
 =?us-ascii?Q?/IAxDhWqXBaxRlZXwqIiDrtGTK3tbv81u+dY2b3scm7/VK3iVr1XSR38ZPeP?=
 =?us-ascii?Q?jzUz9bml6GGMUDOYJ2mjsC7Cb0TkeQJiAi1KIl3wtBjyNipbtT1XsnjTF3Ea?=
 =?us-ascii?Q?+QWJ7sqvIfCzDm3cW5bwjLdQqkUvn2Z9SdciEiTpt0kua6UTEDjqJEhFa/0F?=
 =?us-ascii?Q?ppJdopljt8PaC0kL7TmkdkJ//MLSl5oLK7QuzXyaEqGTm9i5lel0RlBQn9xP?=
 =?us-ascii?Q?pesjjq/9uLvU4D+KDabEr7KmoxF07VpU6W/fDjbhfaEfWEz7cbgkvWLQnWqA?=
 =?us-ascii?Q?1o0g3Z9zfQmz3Q2HsH1W5WfqLjLQVqQjQgAztnJkkEmDwdmUSpQMjeQ9i81w?=
 =?us-ascii?Q?eJ6b4Efz5z4QODnspkWZ8CjemB7XWRESRjtmqPDt7gxPMQwfpyfHhAucYv3S?=
 =?us-ascii?Q?1NU+iV8KWn+yLcGG6jsVBRaOdneJnVsmlOiS8lz+NZ7gz/EPWVRy8QTcRcv0?=
 =?us-ascii?Q?Ff60XEykqg83n6rp5K3d39a7Z28b0o00jF7MkLTxPwMDNxmV9YjZtTzqPok8?=
 =?us-ascii?Q?TbhzyMLbnPGRtRN+7brmNXhj1FAVu5C2+UHrKjnmqA5ZfBwLbRjXhsYuNwI1?=
 =?us-ascii?Q?8h2DbTKKCurMJ84UhfaKmk8mNRj2WdIP9p8nCqg9Qwl1ECucPE+9Sz7sCMGB?=
 =?us-ascii?Q?yq29FLc+WVK4XAKcOSav9HATvbnKgwjQTKMeACKaEG+3UV5nCYBRqEtufR+K?=
 =?us-ascii?Q?qlJo/3FCKmdiIU7K2DJmzPiyzPAE0bObuiXUqL0f0Zxx738aFD8NrdA5pHWk?=
 =?us-ascii?Q?eYVBY9xgOxVcc7RNvUVTOAkkSq7tJDJxRAGfL/kLs2Tqx3pBNaYXCCL75+Np?=
 =?us-ascii?Q?aza72H/8YCDaKGrjItN7VdAIX13j6bPL55qUM8Aqv6y9Xk/UMis3k7UR5iJm?=
 =?us-ascii?Q?Oy82Ci+b48choxBYxOHFFaPrSenBWkkWM5GiUMTn2LM9OJgYUPOkEGlT7DN1?=
 =?us-ascii?Q?9Rz/QNHrlAIfoNnET7QnnuH/Gs+lR7/rcLYk7NSyRI04S2wrZ5VOPZwbd7KS?=
 =?us-ascii?Q?V1ijjcqNoA3J5oe/v0Nim8qqsGxT9H5vsDAmSf4olTE81FvhTl8fwqrCgDAc?=
 =?us-ascii?Q?u/KCo2W2fYATymg/+hEU0cRVQJJAiujNAJFDx/moO+5k2rD9shtJFqsmAQwc?=
 =?us-ascii?Q?/v++IgUVjJaiCaNBkhzyZp5NOmnRZLK+khk37iB45ZQtmZKFGlYz4/kTSzM/?=
 =?us-ascii?Q?h/kMs20A4nSNhYqmVUJUpJzUFufCpMUleWJOgdBgVpais/VGUcCG7MaHlB54?=
 =?us-ascii?Q?dAS3DauXaiA93KdQD3g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:29.2589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d477a3-3064-4d0c-f142-08de3d73f02b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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

SMU message related ppt callbacks are not used. Drop from ppt_funcs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 18 ------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a403e3a45e59..93c943151721 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1187,24 +1187,6 @@ struct pptable_funcs {
 	 */
 	int (*system_features_control)(struct smu_context *smu, bool en);
 
-	/**
-	 * @send_smc_msg_with_param: Send a message with a parameter to the SMU.
-	 * &msg: Type of message.
-	 * &param: Message parameter.
-	 * &read_arg: SMU response (optional).
-	 */
-	int (*send_smc_msg_with_param)(struct smu_context *smu,
-				       enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
-
-	/**
-	 * @send_smc_msg: Send a message to the SMU.
-	 * &msg: Type of message.
-	 * &read_arg: SMU response (optional).
-	 */
-	int (*send_smc_msg)(struct smu_context *smu,
-			    enum smu_message_type msg,
-			    uint32_t *read_arg);
-
 	/**
 	 * @init_display_count: Notify the SMU of the number of display
 	 *                      components in current display configuration.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 34f6b4b1c3ba..0f7778410a3a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -54,8 +54,6 @@
 #define smu_system_features_control(smu, en)				smu_ppt_funcs(system_features_control, 0, smu, en)
 #define smu_init_max_sustainable_clocks(smu)				smu_ppt_funcs(init_max_sustainable_clocks, 0, smu)
 #define smu_set_default_od_settings(smu)				smu_ppt_funcs(set_default_od_settings, 0, smu)
-#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
-#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, -EOPNOTSUPP, smu, mask)
-- 
2.49.0

