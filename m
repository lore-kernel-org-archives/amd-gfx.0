Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0ADC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 17:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB14010EB0A;
	Fri, 21 Feb 2025 17:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sm7ueloC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AA910EB08
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 17:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP2BawefZXLxuRr+fBh1QOvBQAcAWCQ1wLEfgwx/QvuJZjQupwQxAMFOt6j69DSBnNZScXa4kCAM8nsVv0Miy4PIro1EjvFXWIuZN7WGugTbfEzXTbCXZ63LjqnAhKyd4f2r203Y6G8kEVcSyKLJ45B7Zffzi9H7K+Bs4SDE6wWShVbqZeorkvXdIiYnHVwc7WIuYjGlE2v999Q76VTHLIFO6tFAae7BhuAkUeDRBtSmKX8llOEEhjweuHxGzX62Bn2WYNjAJHFdUjFACbSfEbGO+ZFbabP3tTuQvRM/vBBcAZro0MKQLykpuKW+CHvajTSMJ7KnPDM3e4EQqEj2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsjHsoq9CndGFZLuy9i0Ln/Nul15/nzDxY579/rwxjs=;
 b=Bbg5wyZFHMpNlg8hz1ULf9VeRatLwMgyzg/J8IomMC9l7ujmcVhrHNLna7emjYRQe6c0sTXvf/0Rrq5o64wX07wz/ytu5qx/QltaTyrZmi9ChFpIbBTN8g2CxVi9IihTHH2N4EvlpbpKvzDAPQQVcFVPBIGzeVDyMhtjog/jDD/YXsYxPDjd6XABvJeBBsHxOegXuELs6xvTKnGV2sn9fZGPmHRVc5Yi18gI3VV2G1P1bnH8sFcZEmgrrdR0BRWGCLtHVBKFgy41Cbwdyteh8vSqL8kqcMc+VY2yQ4bmxHywWQteVL7pJl2+otXBP4p5A4bsdTaxBLC7lEVQQEKt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsjHsoq9CndGFZLuy9i0Ln/Nul15/nzDxY579/rwxjs=;
 b=Sm7ueloCZfy06cR098vu/JQ6qqOZaYiL0wEatJo+xTN64DNjSK2HnZObR50nnkEuIk3YvIpoPD4zxlbcFaD+7k0V3qM5kVLv0vvH6FE1wcDzNMu2uTx407kuT+oRIxmX3MQpjzXc2fBdSKffcgqIhvOtZz1kb1iJbgw+iDPNn44=
Received: from CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::10)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 17:10:18 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::8c) by CH0P221CA0002.outlook.office365.com
 (2603:10b6:610:11c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 17:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 17:10:18 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 11:10:17 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>,
 Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <Harry.Wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 4/5] drm/amd/display: Add support for custom brightness curve
Date: Fri, 21 Feb 2025 11:10:01 -0600
Message-ID: <20250221171002.209895-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221171002.209895-1-mario.limonciello@amd.com>
References: <20250221171002.209895-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 41037f6e-fc66-4e36-1d2a-08dd529a9e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WHdrqgDMHDL/0b8oGkNbs9e0syAu0Z04/w7l2i52njxIJGNKR4KSiWqYDAIt?=
 =?us-ascii?Q?i4+QeahmSqMA22uzJYlnC5VKVHO9yMML3cC5cZBBZbE9XZestwiQZzlCFm7d?=
 =?us-ascii?Q?WprSiwjStEZNkgjAhRTQ4QmGCjLLmOdWDQ2huCBQDJusiokqSoSkU6ikoJif?=
 =?us-ascii?Q?GYk1+66qZwoXVSqY7Sxx7BY7e9Z327AVCZcp5cHye2V7hS6M893gozUpuOwt?=
 =?us-ascii?Q?3beNdsAO4XhbjCsd3/rTx+wkmpXlsEYTBIi/73TTQnNAxVS/cDPy2rVxjRdc?=
 =?us-ascii?Q?GtghE2FPdqEUCIR5bajrYT6QeVQTI4hlLvqCInVQb3pSTldHW08zAsd9BQWh?=
 =?us-ascii?Q?aNssn2sH4p1XmTds7+oI422q8lvRg0PWgIHThifbJIU3t8GzsGoiLGwW6pQm?=
 =?us-ascii?Q?PKulWiiOJrlolF1i9PH6Mn/cFhHrlOXxZXek0411liMzomJdXr+e5klLOLu6?=
 =?us-ascii?Q?yWR8WtP/CMBf5xfZimmMyI6J/YfLe6iQ1mE1BMxmQpURphZ95vrN9JU827s+?=
 =?us-ascii?Q?r0rf6b27+uBno6MCkOOUt/mgzGMCl/OEhVx4vOyd2bKw5uoVgecsvd6DpTMY?=
 =?us-ascii?Q?FZGdL71iN58BdHdu0p5W9ULpoNhx2ulVEMYJedwaZfHKkdmHwdDbp/8ZA14V?=
 =?us-ascii?Q?cMmWJSpFgk9mCqF++zBkJvBN0M4N9qGiGrsAqsyIrj571C7Y/Qbk7GEIiLFb?=
 =?us-ascii?Q?eeWfphseNsuPh7RJU1aBnl6r85eFuzWP7irxZTHckuS55m/qhDYzSGfIK3e+?=
 =?us-ascii?Q?VvVQPskucdMR48OqSVzF4laS1sG4Z+ouqO5khCo7JeKuS/vtmtAfSP9fMOLt?=
 =?us-ascii?Q?eVmfpSXx3+fIBYOJ0de/OAPdXHbQBWPa+uiSk0TsztBTA4IOEOmf2oYqXCEh?=
 =?us-ascii?Q?9QTITsw4iHFNfePJXD3K0fG+jHc2U0G+OzZteT4Nh0fzfTdzUoHVSUdvn71F?=
 =?us-ascii?Q?xw11K4rvaqXu+CcuQrFRO9SJDsajqLOswtX0mjacZsfCrvYl77QkWqBcD10v?=
 =?us-ascii?Q?Ofouv1aG7dFpAzmGmcYFfpb1rGQxYNjjkANPpeRejpHpPbv8pYlkRoCyOjyO?=
 =?us-ascii?Q?xBI2H/FWfO7K3HyWFIP0F/jp8Ywed6/9BWgE+R9ECP3vRuUwDuC+xwYQMka5?=
 =?us-ascii?Q?PGOrS4dk0LFWKFoNyKao9Q3iv9SLsb4xxsEEeI2uBjyw7QxRw1fjmRADim0U?=
 =?us-ascii?Q?+VTlCG6CNJ8gXzrzPd5TmoSWeC8vX1EJHwItrCmpvm19c+dZGZNnpXT6tZXN?=
 =?us-ascii?Q?mJpyZxBeiCio9C+ixA7q7aUauWnakFZgRhy5VpiCO1u0eldtkpzXrH39LcHY?=
 =?us-ascii?Q?Is6KGilsuigd6DN/7cmvxISjwEMnZatHHYrI1SmxAy9p3koPNCA4C/wT5Gvf?=
 =?us-ascii?Q?0aMtPYLKAxwGEAp++oVROf9+SvkdDPW97g3PszirNp+ePnh2J3Gsn4zZcMNv?=
 =?us-ascii?Q?vljp11ecCnaey33v+fbVERrizxig92VAVqszXg5nWcOdNoOge6w9yXogDIVn?=
 =?us-ascii?Q?GZBiG5QtWnA5hIE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:10:18.7920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41037f6e-fc66-4e36-1d2a-08dd529a9e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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

Some systems specify in the firmware a brightness curve that better
reflects the characteristics of the panel used. This is done in the
form of data points and matching luminance percentage.

When converting a userspace requested brightness value use that curve
to convert to a firmware intended brightness value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 70c8d800e173..136abfcdb76d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4704,10 +4704,35 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 					uint32_t brightness)
 {
 	unsigned int min, max;
+	u8 prev_signal = 0, prev_lum = 0;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
 
+	for (int i = 0; i < caps->data_points; i++) {
+		u8 signal, lum;
+
+		signal = caps->luminance_data[i].input_signal;
+		lum = caps->luminance_data[i].luminance;
+
+		/*
+		 * brightness == signal: luminance is percent numerator
+		 * brightness < signal: interpolate between previous and current luminance numerator
+		 * brightness > signal: find next data point
+		 */
+		if (brightness < signal)
+			lum = prev_lum + DIV_ROUND_CLOSEST((lum - prev_lum) *
+							   (brightness - prev_signal),
+							   signal - prev_signal);
+		else if (brightness > signal) {
+			prev_signal = signal;
+			prev_lum = lum;
+			continue;
+		}
+		brightness = DIV_ROUND_CLOSEST(lum * brightness, 101);
+		break;
+	}
+
 	// Rescale 0..255 to min..max
 	return min + DIV_ROUND_CLOSEST((max - min) * brightness,
 				       AMDGPU_MAX_BL_LEVEL);
-- 
2.48.1

