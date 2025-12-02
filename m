Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B51CFD376
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 10:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C7410E60A;
	Tue,  2 Dec 2025 10:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FrcnMWT2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACA089262
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 10:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJKq2JW3qOgHCpstYjOqICIx7hrH6IOUmuYlNbyqzoSucsAivToigbLc71WT8Q90QXvBlS9n8CTvjajAjb0u/cVHUK8VTE5NqqXGxTAuSPUjxBNwgO8bF+7YaxYuyg2BM8DBNbK/kli1/ZG1TS1ieoqgdTpU5Eb5bdTa/gqYyVMCoqUQdH5XkSfSpD3UFSfCvNnjLN+lt04klErz/W/g4havskjGdFL6CoNRlebBrk2ncgykTtnvM2Gj6fQARQZYnhDeUt9q31kXk9sDIwy9DeshYnmpVnC13oPITnXwat2KeHqiei09zi3a/+0wC1b+JnyMD6bnm0/y+L8GPt2vNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+sV58wdRAbu3mdmGpWociIWDUOoLMLHRY8o/Kyjl6s=;
 b=q0MNwmkjbm91nv6hFBhijc7S0dA+/JcZGvaDkwSD1rrMgo7mpDd6/NKCsLma5Nq4TB/XEn6Y3x4uc5KSOcTzt41fRoo1YfHZQWwhAd2itzIbXP4Ds8KsCK3t8mm9OKzEC9AszZGVQiUbGYtcpBs6jTsxe+8UMLcgwhoFh9sNq1n6eebusgekX6fIGsDuUqhBhRW4cgCD+dVRGjQOa/iAhls8yVFv4Tu6sPFE6MfgDQjmcc9a0SFddATTFNhzDGtyLqB1PPk28OT3lO8F9pJP4mbEWpItKrk7Slhs3DtcN086G5gUg/o/zXUPFxgyAQKiSnwTGDk8yjaDz7GmGcC80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+sV58wdRAbu3mdmGpWociIWDUOoLMLHRY8o/Kyjl6s=;
 b=FrcnMWT2/+mBM1w7OP3NduX6mFHWDrzH/tnSwaVFlA2h8hKmFjYNQQrA53ypgX9rSTav/ExE9/zVh5jtTeNYP5cc5uPcQyeB3CGFTjXSWRVIS7Uf3ny6iG/sVdVcfVMpvt3QXwDnNh4cKWhRig0WYnpZlz8ggGcA6oWtxjtvLlM=
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:28:52 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::bb) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 10:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 10:28:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:51 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Dec
 2025 04:28:51 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 02:28:48 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 3/6] drm/amd/display: Fixes for S0i3 exit
Date: Tue, 2 Dec 2025 18:21:05 +0800
Message-ID: <20251202102437.3126523-4-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202102437.3126523-1-chen-yu.chen@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fe8999-e167-4741-778e-08de318d9695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5uKJm2HvqC3ujFyz3xPjEi/+hiH/Dq6M0Xy1Mwf9bYKXXm4AhSL0ubDXP/HY?=
 =?us-ascii?Q?oUXep9s6ENVUUinphG6K8uMknbbhOg+aG6Df6/LGBAiijOoWziXF47Q7Gh85?=
 =?us-ascii?Q?JYcJ0YwAQqvzwUTDakJEdBYLXpSMdoWzp7HhrkAsZFPlZdW4oTibWlHSXIwU?=
 =?us-ascii?Q?/nw4TfCVGFjTqGet9NAX2qvV0y3lyqdcrncwonoeOEP1WJchZ5Gshwyxmod7?=
 =?us-ascii?Q?Pmovd1rOsNAg+7sDkz4bGlJZ7ZZTMz5V3ZVAcSG7S0i6EtuxvuptqmgRFWy1?=
 =?us-ascii?Q?sgRoVdAByuCMl7SvjUPw8QPiTs6JfyLuvXvwX6gz7SJSXFU3DwBQ1pHtoAGB?=
 =?us-ascii?Q?J+FkSzyT8Mn19XnepUBJQTDR/gTBgW3MRrjtiCRkjolBC7Uj+H3lEkzFX2p8?=
 =?us-ascii?Q?qHmCxQOlp6uPo1ucA2i7EflpRy/gAtjThsdqTGgeOjd/kHh4hXKn+A0xZaWX?=
 =?us-ascii?Q?BJjp0XCAL8Pz/4pNr/V5HkXqCsmcVjDGRU9Txq8V57KU58hF+r0Mq8dMmkpX?=
 =?us-ascii?Q?PMWWSRQ6QVaChHYd1eJXPq2O+ZsdMfinjqSsAB5K6AlYkt35bx6u/viAVvPx?=
 =?us-ascii?Q?YQBkWiN6waBvlgXUe5TIYItWi791TD9WmHxK+5gkCFdsGYVD+TZk8NQH4OLz?=
 =?us-ascii?Q?4Gbb+RfCH35XOUNcuCL09OdyZ6ZwvCmfzAtU/+lM9BiB83QCxzJ4iMUnB+5U?=
 =?us-ascii?Q?V49C1VjBfUH0Wa5eiJ8D0tUEo/VONvH6H4hcEiqQ2liPc8aeKHXMjx1DgYn4?=
 =?us-ascii?Q?vZE4d09Q1dIPJaPiGTYM9Rr7FkOGZJR7MdJOCagBqOgInbZ8++lMAChqCnpu?=
 =?us-ascii?Q?HH2MQHMfpJtPTyFsLKwD5VWUfCFoyjjvU2kpMXKfxgE6tSLACO+5mzW7Fsjr?=
 =?us-ascii?Q?DXUFQr8bDuFGrDNPlIGOczKrQgkN253PWhF7QD57oeSsnQ1SsnhpNIDClrHJ?=
 =?us-ascii?Q?DE3MXwr5tZBlp8PtWPaKKoybJst4YZrk1KNO2HoMQZa+kyOxBIGLGdDK9eSY?=
 =?us-ascii?Q?3GJb/evXjnMqWC2X7H26Oev4us+AJNTcf66nZBzGv16mx9spnBBCAicLhryq?=
 =?us-ascii?Q?Qk8Pnk4pI1KCEdvnb2usdQkWSw3lOedPPPRK877rDrzUyX+JT1UXd2uUAawf?=
 =?us-ascii?Q?ICQoWz+B0yUTbPn+Pw9ePGKqbIwDqS+wJW5YRzpQipRjL2wWD7El6SKV4lRK?=
 =?us-ascii?Q?u95e5al0OIHN8KnUKcdsdvCVRHjUVz7SIULlNRYMG1ZPc66Zzqs2/uuU6BqG?=
 =?us-ascii?Q?Gn6riPcawg59FaW2M6w7u+mnzqPHEEnlrBl9lDU5tyW9/cqXkIcSaY9W0efO?=
 =?us-ascii?Q?M/dvLSJvLEFVRLlKwdMEKmlsl1vEtvftZAvRLJ0GrJKqD7OOcn2Q9rNMep3H?=
 =?us-ascii?Q?MgrlMenXAaa03HBwS9NK8zixQ1E5BtdZs9w2WmgLW35lSpn7hQddR8z0ZZFq?=
 =?us-ascii?Q?dOaHs3eDgGg+wmg01I97C0Dzyjjp0h0Qq4Xuk1Ml5pBjy8uEzblpWg98Kk4C?=
 =?us-ascii?Q?EbY2+O3T/PxJTybcx4oh3I+gE7e/8hnvmrhZ9PoxwhW8GiQ7189dTjWyZYUI?=
 =?us-ascii?Q?M4VAKNgaKsmBtEGoNNc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:28:51.9284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fe8999-e167-4741-778e-08de318d9695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
Add debug flag "ignore_pg" to dcn32 PG functions.
Update default z10 support status.
Temp disable RFB features for ASIC.
Remove legacy code path.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c   | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c     | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
index 319eb1061ba8..20bf04dac609 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
@@ -120,7 +120,6 @@ void dcn35_link_encoder_setup(
 void dcn35_link_encoder_init(struct link_encoder *enc)
 {
 	enc31_hw_init(enc);
-	dcn35_link_encoder_set_fgcg(enc, enc->ctx->dc->debug.enable_fine_grain_clock_gating.bits.dio);
 }
 
 void dcn35_link_encoder_set_fgcg(struct link_encoder *enc, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index b213a2ac827a..3cd44c6602b3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -82,6 +82,9 @@ void dcn32_dsc_pg_control(
 	if (!dc->debug.enable_double_buffered_dsc_pg_support)
 		return;
 
+	if (dc->debug.ignore_pg)
+		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
@@ -168,6 +171,9 @@ void dcn32_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool p
 	if (hws->ctx->dc->debug.disable_hubp_power_gate)
 		return;
 
+	if (hws->ctx->dc->debug.ignore_pg)
+		return;
+
 	if (REG(DOMAIN0_PG_CONFIG) == 0)
 		return;
 
-- 
2.43.0

