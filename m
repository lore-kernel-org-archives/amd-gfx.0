Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B29D262B7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90EAC10E68A;
	Wed, 21 Jan 2026 03:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oJXwx3s/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FD1610E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmQmkPobAIyTBOfgiyMbHnaPLlbw7ZYXaMq2NaQetlLH/mdWsQL3oGSEBTtsebMxW4VLaBnH77NtTNcKBxvTu70xQCYmstD5aXCbFWFWD5+WY2z8ZVW75L2q/6o5n6nBEUZWfl7f17gULAWYfROylW0uAVOPCtQn4jEa4DbNtj8Cf5bxkVdjRKaMfH69t0OQEFYJCr+bDxF1rW3Lvln5+EtqvEHG7fP5x3RSXVsvLyPbVDzD4E57Si+6UIuUR+u+aHhxJ5ivlw10OzUiArc3Lvv2vFiCP6GkeSClYt0oCH3r0RgH9f888PFGpNL6ypW2vcnaitce/mDpnTqvehwzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYr6vm65kza/kosPBYaKQpNaO7y5RQ4EybS1Bj9U0J0=;
 b=PGEPbtQ2vcP3xVZF87ZCUeCxOL+3oprOcfrxCDYSWsJvgX3i38K5rEuJz58jO71kK4l4Lxi+OXmiwe5IoJHKnV29jK+TbkjROyCyo4uWqLeK8ezESmwA7l8u/dBBGtJwpAir+vcVo1mfsHbQjdmIQtlTRp34xEHdI11M5LxaNyOcNqCTomzUvtPsLjf94Epyroxk67KAEX2oek0XAZIf530IbYmJsAGvo1OJDdmGpemDPeUDh9a9AMeVst/8mC+9hip3REgEoZRFyzjzhJXanK8cqtVcpa/4F394z+lBx9PFaLkDVTcMnqsCEoE2JWTuicHrVv0YAmksI1LZZrhBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYr6vm65kza/kosPBYaKQpNaO7y5RQ4EybS1Bj9U0J0=;
 b=oJXwx3s/tI/GreJRlCcjGY1FKs8AUnoWQOeFqacqQiVbK9kxw3GjKWGQwckmdLof6fcQM4k7JVkchIIBt6BtjMQqtlEdahwfjy5xdEB0+TJk3M4tbwgR25L8cJydLx1LjbTtFbKwPx1hGQpu//rNfiksJpZgzr8xhsAyApkyFPA=
Received: from CH2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:610:50::14)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Wed, 21 Jan
 2026 03:14:41 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::92) by CH2PR16CA0004.outlook.office365.com
 (2603:10b6:610:50::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 03:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:14:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:14:39 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix smu v14 soft clock frequency setting issue
Date: Wed, 21 Jan 2026 11:14:22 +0800
Message-ID: <20260121031422.3431903-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121031422.3431903-1-kevinyang.wang@amd.com>
References: <20260121031422.3431903-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: fb51493a-4720-48f8-b4e1-08de589b3796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5qyW0pc3qWxlPZFJpTtGzjf2XTZXDEw/XsLI5f9O8yJ3gyaRfBi1uOujl+P5?=
 =?us-ascii?Q?aZ6sEvUZictXiWQGp97nj0YW+p4GHstZ+Axn7dO774XvKouVDRlA1pDcndb0?=
 =?us-ascii?Q?Qz+KYn7aIjmxDKQjxq09+fxOEhtPO3WawliSG9bDwlWJr5k1j25VHtZgQgf0?=
 =?us-ascii?Q?gD+z8UWr/Q+U8uQvypbF6aihxOsPPubRYMPc7R3gi+Jv1SMPYBb2hfwxf09y?=
 =?us-ascii?Q?uIM+jOS0uB5V39eVPEvnWcv6SucGP6KC0/HeenhXRsiYM1U2wwDJAKoI0/d+?=
 =?us-ascii?Q?ZrSoXXv4rKfvRP7QRn8tWcRV5x5I+X73rDR3fElBNNN9JmJ0wHSe3XBE/alK?=
 =?us-ascii?Q?7+1AWorpvvmeJYVKfoLWPMvo9+kQW0rqXZiQ3C1LlVR+xcmPE2DSAJHHBUqv?=
 =?us-ascii?Q?YNYQZ5QYzNhNcqv6jBOjYDJwgmqFAaxV0oWGhGGytzpw4saH7wvMQ72xR+W2?=
 =?us-ascii?Q?f9k/mYCPAynR/KUWMBbPLsg4EuRzOyOJuPlI5EOrmXdGk8bF1Py2LHkEbNfP?=
 =?us-ascii?Q?CTVAsNt1XBhOdgyZOOygUKY3dt7/tjOxYLWGe8inyY815hPscrHUkG7B+Z6m?=
 =?us-ascii?Q?3hhJZZrBzWwQNC+c2NAsmEg2v2JdnQxtWE18Ts+VO4Fa6dk44T/r1MfpHOC+?=
 =?us-ascii?Q?erxtiPyRShr8Xx1EuPyfU4rY1U87nMRGTO6hldKjy3yxzYhhhOfPtpGcIYaN?=
 =?us-ascii?Q?IDmRHGgvr/TalpcRPdT9BbyA59NIAMMp9jggF0H+bkpYXQ+YJDFnpL1AdoYA?=
 =?us-ascii?Q?be9Df5Z7UXdSzSv32dGsfN0nMHJQu/6eAw3CmtLqc6fbIj5WElh2DV1sbbYk?=
 =?us-ascii?Q?ecDm18R6fgFlURFo3UNsx6x+BYUbun7Hqyf/td06Uedn7yeT7Nr5CEIB+eW5?=
 =?us-ascii?Q?eV/kM7P4lNxZ5HiDBitdt8cuwQuARhl2+byvwvuDbeW0zgort1wbUMD1rHqK?=
 =?us-ascii?Q?EPTwYEZYvCq9UU6xw2GNH1ENLZoGRcudI4zDq0f8Vqk+MMEdJzm83Um+NGUl?=
 =?us-ascii?Q?5VOGiUQ6Un72n3XXofNvXR/OhG9tbXKPr5/hxBFPc/AkpA51MAQazzBXhheV?=
 =?us-ascii?Q?/ph1KLGM70fiuIaW9+W3S1JwBuvPhoeXuorxLRGRnReev/0pmi66x2M8xP4m?=
 =?us-ascii?Q?AgHm07uYIMqcSvbkq6hAzKopgILZHGNhQcZHzz4Is7Gd4tvWXq5l87N9Iqk8?=
 =?us-ascii?Q?DEuw8E8y7BBtKqKQE13q4QkvfsTbIiu30qhBLCyo67eXoIQ51ag8S//yJczX?=
 =?us-ascii?Q?j+PhHYwac5//NsZmG/eIbdFvUyWL9a5NpDEuWT4TFmtMo4Aj/pKF+vOay6YR?=
 =?us-ascii?Q?ETu4BzsR/18u5MIgIpXRIu6EO2emWWZuOiVsKuHrH+ykWlPeHj7U8Uqd+0Dq?=
 =?us-ascii?Q?24BRgq3Fb7qiZ+ea04xg+2B3bc6zY3FR3tO8/X1AoH5j66+oHIB59qmhVaeu?=
 =?us-ascii?Q?ATJsq2g4Ddo7F42XfRI6OcovOkE+1ZeOw1cXYfDlq1BxZhRsaELnNNrau0Ww?=
 =?us-ascii?Q?G3ZiaDV8dWkvS0J4l41vkbglpm35kkK8usCm/98ptG8/kLyCv3jga6qSb2aQ?=
 =?us-ascii?Q?LXHsc+7QuDipKf02u94F1dmANFNPZ96GjddbcGZMeLlPuf/ZSQpOJC9HD8w9?=
 =?us-ascii?Q?y0gGMu+R49lYjiZibi+ILFFhgdA8CvNSml2veIppWF7AV4ek49W1eoQTq+9E?=
 =?us-ascii?Q?eSxR4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:14:40.8452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb51493a-4720-48f8-b4e1-08de589b3796
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
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

resolve the issue where some freq frequencies cannot be set correctly
due to insufficient floating-point precision.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h   | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 613d4d36f32f..b453e6efc7c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -56,6 +56,7 @@ extern const int decoded_link_width[8];
 
 #define DECODE_GEN_SPEED(gen_speed_idx)		(decoded_link_speed[gen_speed_idx])
 #define DECODE_LANE_WIDTH(lane_width_idx)	(decoded_link_width[lane_width_idx])
+#define SMU_V14_SOFT_FREQ_ROUND(x)	((x) + 1)
 
 struct smu_14_0_max_sustainable_clocks {
 	uint32_t display_clock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f85ba23f9d99..beb4f9f730bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1177,6 +1177,7 @@ int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu,
 		return clk_id;
 
 	if (max > 0) {
+		max = SMU_V14_SOFT_FREQ_ROUND(max);
 		if (automatic)
 			param = (uint32_t)((clk_id << 16) | 0xffff);
 		else
@@ -1188,6 +1189,7 @@ int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 	if (min > 0) {
+		min = SMU_V14_SOFT_FREQ_ROUND(min);
 		if (automatic)
 			param = (uint32_t)((clk_id << 16) | 0);
 		else
-- 
2.34.1

