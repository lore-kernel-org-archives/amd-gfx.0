Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E80CE9A04C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 20:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA8A10E620;
	Wed, 18 Feb 2026 20:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CK8Gjrl8";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1558810E620
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 20:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEeVieaCrjW+7sSB/D0NHPd9Oeoy+ABZotX/KD1SlDkbWHy6N3sS5Oox0iOOJpKHXJIbT6p8f2BEmJCrbooQJS9riaz3PE+Advh4lrGgqy3mlLL1mLP1DlNIY0hVyoCKgDxAVuctpKbGqiWhLOQpix8GT4503XuZdpFDgX3IChe603SR6pb2DWqqZJ7AOU2e8aS5LD9wLZEyqDy6vVKe/MDvh+mm3K+uLuuN2XDu1KQ6kP0oQQiwZEl6tvj3clP3nh1YYbDiEu9iZn8wh5A3YR6N4cdt95UIlVPQYGxT4pKKLiMyzfu7zpvKgu4iVTNYAXqODgsYoEX+blajPZoviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0eLOhIjexcxawRBUCMbQeg7AN+nR4Eq2ZLe7fcBV9o=;
 b=ntRllBfCsRx069S+6Pp2caAf1v4xPO5bW3H3hZ0bwMNR/fgPNmSTvQdYNlntupTKqr58Qfr2+WRmiU49EHBLnUIeCwqh/3WowiLGPAVso2kUUt+xeXJ/L/oRyZhdXtqXo9vtFpCEuzUXKV4af6r1LQt3cBbxkrA48oNyiMwOmEicOE78cOYZAz97LOpa0lasENt/dGmTz4PH+qUZVeODMJuwc9XEFubnXQf3dATqRUdKOTXBM3Xa8MoGu/Zdp+BE5V6Bu+3tNHvh4SAWQP6UItq1MG9qO+NAO2X6EIsKBr6T1UeZUIgb/fSHnZg1iOzl8nBsoERfI7f/OwmGllKalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0eLOhIjexcxawRBUCMbQeg7AN+nR4Eq2ZLe7fcBV9o=;
 b=CK8Gjrl8DyW7j4bB20+KLpHxgfhu9R9Pk394hWlxo5MVeT5uirt2Flkj7t3BxiuM6+bf6Ngwn2EWCT5A/8YKrmdSiJLE9i6sFw2yeYoHXoP56lop3WxN/Cv+Gb0ufg441URLVquYsT+nNmvAZ8fAYSCw3s2lHatOBgIjYSDF9mM=
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by CY1PR12MB9581.namprd12.prod.outlook.com (2603:10b6:930:fe::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 20:56:12 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::7b) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 20:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 20:56:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 14:56:11 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 14:56:11 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 18 Feb 2026 14:56:11 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>
Subject: [PATCH] drm/amd/display: Add atomfirmware cap for DP++ Type2
Date: Wed, 18 Feb 2026 15:56:11 -0500
Message-ID: <20260218205611.2539493-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|CY1PR12MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 22685687-dff9-4503-e6f0-08de6f30265f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HO5TCqqDQkZvzZwcTfyg5YNcRfVngoMUjCTCMuxQGyd6NMTmKTRyN12WgJUx?=
 =?us-ascii?Q?RLj0ajNyeH99OD7FfQoH8OjRrrLEEiORMXg0NKIuy5MdlQWq89Vv44CI3daF?=
 =?us-ascii?Q?hPPE2uqSC3imY13y+FQJdaC3XdOs/G48H899Drje69LSsx5AWzSYQJqEOAop?=
 =?us-ascii?Q?puVFVmQDXp7oqIgkTwca16QQuN6CxqIAwkNJ77zpify4+TWtq5mPbEKVTY8a?=
 =?us-ascii?Q?reEv2taWyjHLTBAhzM6KOFsS/Ri6PaBPlX2Ns4PzV1XhV+OQnEFgeVGiIgi+?=
 =?us-ascii?Q?PPdTKZPwbRrl1AW9o3eg6JDd1WuHxhjY59DtUCAAJ6X6dZYTgOVOuKPp8ZwU?=
 =?us-ascii?Q?Lta8jTwRLX/M1FvZodCeyhWJnFLWsIu42FJmNmRS/nZXPLPab0CGnD4THb6r?=
 =?us-ascii?Q?yddgbsDcPRCuIoPopg/d+p1YcA9+gApU6NxgehFvG6FjevxRXjz8pv9gw1l9?=
 =?us-ascii?Q?WMSg00exr3+crTdxjTHoHexU4hspGHwDKacdF+SoPs7IA3NRd/+nmQTDZqFo?=
 =?us-ascii?Q?/a39FdM26F6GdEli2d3WyCglZbMt800YsPE5P55BaOZl1hbEtjvmD91AvQ7h?=
 =?us-ascii?Q?Xu9mxLhQhWfp2E8ZALzGmA/diYYTDBLkBl9UtzTZif1xCj4JMCm4n7Tbdtuo?=
 =?us-ascii?Q?H4myb1N+UV/j7q8HT1c6zc6FtD8NwoP9ZQKIq3UhuCHCZnlI8+ch5NaVboMA?=
 =?us-ascii?Q?adzxFZZDpGMsGoUTMToYsTZbIXCuNxiUJIqfkogVsMgIoErbgHCD1vR4WPiE?=
 =?us-ascii?Q?qiMQ3AINBph6Hh3cRvR3FxINulLci1AMnHmHlbJAESD2Xs4B+zkc0AReoDo9?=
 =?us-ascii?Q?x9zXU7jO3J5jMec98c+7uyj8BbTtKQpuApcM6SW2CSsLlfjKYlSAMe0YVzNR?=
 =?us-ascii?Q?SWlukQPu7BliFIyshmE8vqVpM3l1BZZ0zCuJZkH4bPGj6rvizGQPiAgFe8yB?=
 =?us-ascii?Q?L4GIxi0omskT/XWH1p2xUjpeUhF6wcCU2XWXd07NtiO0gcqtOMV8DEDBz63Y?=
 =?us-ascii?Q?lZHi1OJqYOHtWTzo3h9gMBw5ix22K1Twc7a+QIUWqtN+hWQlB2I3AecuJjvc?=
 =?us-ascii?Q?piBbxqy5fga5LlJqGwk19q6QmhYIqDLCgl/nCOzfmxjEm86Ws1wu8Ms0KthD?=
 =?us-ascii?Q?gcsYULVskGXZQ+L469Bgr/j4cPSefUur5uUcKO5+f7FBczbsNvPThPEe6vRS?=
 =?us-ascii?Q?ZB7KVUQxxPt3NdZf86GMb5ZlEpwJaKagrk8g3knjvGCzjKSsE/ApWhn94BqM?=
 =?us-ascii?Q?mMyNbdv7Zya4lrtXu0EK1vUinTAEgqOr3xmr8oHVi5tcpIFmcvg/iEh3A5Sk?=
 =?us-ascii?Q?llu0ELKG6WgTws8x25TRmDplHwVKuhUVYIY5bKPAkdb1izujVLEISbzfTM7/?=
 =?us-ascii?Q?iafCtxMS1XdpD3TbkB0f9U3UUkOAS0GUVbOejENpRNOUcVurbv2rYEhu+qfZ?=
 =?us-ascii?Q?MUbg/dpjg+Y4uccEVxqFf/a6G9JwCmsNiJJ+Pr4gYdajjknwaLwlteQGHhHw?=
 =?us-ascii?Q?D/1oWgfbZVQ59mxLPQQTjkwb2ml4kgCmuqbcUsQS6Dny5n4tBT4KrWdq6op7?=
 =?us-ascii?Q?CL9HU39Jik+SIt71bJC8VtlN08JS+45IkMGqzeFSSK1vamUk82GjsakMo1Np?=
 =?us-ascii?Q?xFsQ2Re9XfGb8N+7i7A7Hy9Qi1yXQfI+WCxWHO9f0MrX1kLbkvlR7FmkYf0B?=
 =?us-ascii?Q?nEe6Aw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: umd416ZKb367j2XLZE3g8VilmkibsyyZmEH6kZwMPJG9ddfmOqGkKbXxKWs6FoIrxiKy/OzWFo88x/PkLFtIIZOjHXjWSVa+0Q2BQ4TB11+dqRzPAV52clhfFvf7ekwPJMQwgAJhsafok05VABm40RBP0HLcPRa5L369JT0M1F5SSlDbdWsR1BBMiSXiEfAs6w78hqVAzcXkkk9hWLT0v2c+i8vRWOTEMBux5tFMxATrO7vIm1xW4+GGNLB6x7mcUzyR0qiYOLcw6/GlXEUnki4L6k/MZVl9+LZICbUQ01w0dWQrBEaLq27/Lo3emWJqauwnkuTkZpndWVIHs0FVrbESaYFeoY8yxq0Of9l4NbktbDHerLL9U3vdA38cK9b5jdS/m768b36g7DNCXNpKvNK3SaPgy59tJJa+vF1DPtF4p0+E+fCFXxp6PGiPcOir
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 20:56:12.4770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22685687-dff9-4503-e6f0-08de6f30265f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9581
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

Add ATOM_CONNECTOR_CAP_DP_PLUS_PLUS_TYPE2_ONLY in atom connector caps definitions.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 3d083010e734..18f9642a42ee 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -879,6 +879,7 @@ enum atom_connector_caps_def
 {
   ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY         = 0x01,        //a cap bit to indicate that this non-embedded display connector is an internal display
   ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY_BL      = 0x02,        //a cap bit to indicate that this internal display requires BL control from GPU, refers to lcd_info for BL PWM freq 
+  ATOM_CONNECTOR_CAP_DP_PLUS_PLUS_TYPE2_ONLY  = 0x10,        //a cap bit that indicates connector with DP_PLUS_PLUS_TYPE2_ONLY
 };
 
 struct atom_disp_connector_caps_record
-- 
2.53.0

