Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5D3C3064D
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1133E10E1C8;
	Sun, 30 Jun 2024 14:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yP79hDbQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3BD110E1C8
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPaAQ33eigpRMdT4f5KWICtaYI8Wf2t+qJnqtsd/NBb4dTldrJE5m4STf7JJCCeSpbb5bPsXRRWLMsXIQPuWeTAUkpJLJEHcyW4RgoS83nArjVMKpXUmEhc9Npwvwz2OH1grSsHFPMUFCX7hkTZznh/nxvEbaTQN5w65+3dkvPdXLk9LMkUPHWmTu4edh8Coap9Rw7P9UxgDlBJM4hTOQMVRUEx7Bi85P6/V4rlBEIAmbuzFgLBAxE40+N72S0AShT06xI3SMmtoDd1zkBmIKzX1vqmUMQMtFCmRYDHZVCMdLCLstdiyxZlcF0XlYPA34lk22Y1MFwn8mq+aEl5/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY++ZY0dNe0wJpYsLzVtC5TybJgOZJSENo5S8aps7T4=;
 b=bL73MwJ0kx9HtdVhbnFfEG13ErU2vhB6ptfl6AXUU4CjythqF58BhPY52mxwcsL0mYOzaup5RisXR1CNZHCna3B/50y1KMx7lNtE9QMmVKs3zDIO2101bP4jH5Wz3pbZGSwUt25yj0sxlrfIIRb+Gp0kFlDN/Gjb4CfcMnIuNDeARIT1XCS4Ai6EWmYxMxXx1RPME5vN1cBqNciPVLBqNy/+k56uIpEkR2h9RUsTSWpiMD81Koy36BoMKa5M7Ym2rosY+Pd4xS0Yy3ARxZLBQB+D9A2G2DSHGxvRh0NsaudB+61T8SPY0NePWPP9Rbnb67IBPxwk6Xh5q8tacO9HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY++ZY0dNe0wJpYsLzVtC5TybJgOZJSENo5S8aps7T4=;
 b=yP79hDbQgt1Tsib7QEw4chBdcroJ14dw9zNIYHlrW0EGtvTtZOy2tuFwcU3mXjHgln/mOnLYbXGxiWgpiHZQnrKHDSyWu3SMXa93AfToUbzugUvvZ2EDLO8sFS1Vh9WfGTaeWXohu1sTsrayK0D0HBZ1VuMv2E+Z9KusAECfbmY=
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:49:29 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::2e) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.18 via Frontend
 Transport; Sun, 30 Jun 2024 14:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:49:29 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:49:27 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add NBIO IP v7.11.3 support
Date: Sun, 30 Jun 2024 22:48:52 +0800
Message-ID: <20240630144852.2018966-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630144852.2018966-1-Tim.Huang@amd.com>
References: <20240630144852.2018966-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8410fccd-e723-4c20-862e-08dc9913d8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SrjZzTRO9rFD1zH3Ii147jxnnSaTpUnMNOHNCFz3JlxzUfm2HEsCrT8ctcqY?=
 =?us-ascii?Q?Qh8/a7EW4cK2G4rQHv9pBLHm5BdBMNSn5Azp64ByQsXpsq/MBbmc7YMFwcbX?=
 =?us-ascii?Q?TDlq4g77dP25t1o+3TIfE/2jrklkWqYomNgl0LYS5ywaiEofUS6+ABXkzoUv?=
 =?us-ascii?Q?MZCE/rq76S20OT/nnnwOU8znOL4jcZA+WvdIZOhfi91GbP37bzsxMsww8sw+?=
 =?us-ascii?Q?p6f0lcWGN/+Xz+OwSfJ00g8Uiq/vyohmNKk6NcH0netGc4pi9K0yzLNOAZlr?=
 =?us-ascii?Q?RgFk8bM3oBl8QDAdWxBdMNDsjYzEeOoHeRtnipK9v77vCw8VZsaAenNMzCsk?=
 =?us-ascii?Q?bFTchze+pndJhbz53WFiGEemoLUyXhpCB0INyRXB8YenwGofo4FAJz+jMhDg?=
 =?us-ascii?Q?lIdlD4QRZOeFIKh9ZhECpNAShEyjIejCarblMsfmBYX+UputvppU2q70MtTL?=
 =?us-ascii?Q?aVxuOmMva3U5D8nuPU5E6/8t+cl29f1d00KLboGx6Z+SoSFmCTrj2nL3svow?=
 =?us-ascii?Q?fH6CNdzGdaA90nLlrmduYdGKiZ5tKFvWxtIOwvy5xP2j4PedruqUqcC/sOhe?=
 =?us-ascii?Q?FCf81wgNpHgNuwTkViRYq/DtvrISUN8LDF9DIcMYHH2QadZ0xfZZ9pxz2DQ7?=
 =?us-ascii?Q?U2HHPQsS2GRuBJ9uVnyKfVFzCtz3u7CasEQTELZGFGvNil53ndDhMASMelA9?=
 =?us-ascii?Q?AIFmqG06wB2JfGhc0YJH4ccaMe8aszCuU8FUgawc0HzIcXsxpyO4sE0krlVC?=
 =?us-ascii?Q?dfwOkxSVH/TAzyV1zbbN/v8Ui5qGEhsj3lQCRMleIr8nZyv0NJekqYu8SC8o?=
 =?us-ascii?Q?3pKDUpGlg388KcrcZRZnc3izHxofd8k36bj8aNwQeMd3oI+9quq2y8HiIMsO?=
 =?us-ascii?Q?DVJNm77Nurs18pS0n/SW7Qsn/iB13VIgQyd/3RkznU4dF3tGfhJZU4RX5CQE?=
 =?us-ascii?Q?wzSA1ZePn2RHf45yP2r4oGIBv7iTsirT7kBrUlHoaNue/ul9Y6Vd+cLptkPs?=
 =?us-ascii?Q?cNmyK0py38EZMkeq8gzfNtI9lpr9dOq2i5q/8XgcD05TjD5678XtRFAa9p/n?=
 =?us-ascii?Q?L29EbpB9kNKkiEq3leWIuZU7HSiqcq1hBx1opubXavnc7D7hOdCYr2btA0rK?=
 =?us-ascii?Q?MpMJ6NwYnBBG1yYAF/CKYog1hagdCEmgrkaG9Tf/vVdrkhZ2tob/CBrNzbmF?=
 =?us-ascii?Q?x15Hopl3FsQXQEIzwPjlIYupMYo6vQs9U9YWCrAjQ8A6lDfXapnq4rk3ZQ6E?=
 =?us-ascii?Q?iPJ2lgKU1GavHkfUuvy3zhdNfwWwQvPdTzYOxAPhfy8K6037t6qMGWEp3AM6?=
 =?us-ascii?Q?Ll7msvJ7LjgdarzZeQe0CrO6qeX/BjxEifuknm3G4U2WuVzRQHaJxV/RjhQe?=
 =?us-ascii?Q?bMkagU5ConMw2Fd7sW29R0m6+SHITdH+Vj25vqq0ptZ/bjTI6Lk1ZPMecbOW?=
 =?us-ascii?Q?KJ74dgzWve3qbuAYE3rgjWM81Te9soUV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:49:29.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8410fccd-e723-4c20-862e-08dc9913d8a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
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

Enable setting soc21 common clockgating for NBIO 7.11.3.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index b04c763015d3..b43c50f1c7ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -953,6 +953,7 @@ static int soc21_common_set_clockgating_state(void *handle,
 	case IP_VERSION(7, 7, 1):
 	case IP_VERSION(7, 11, 0):
 	case IP_VERSION(7, 11, 1):
+	case IP_VERSION(7, 11, 3):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-- 
2.43.0

