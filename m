Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D06C021A7
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE1610ECB5;
	Fri, 14 Feb 2025 15:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="il3W6rOP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAD110ECC5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLeJtMGE6PIODFycVfN8UKy3Z1QE3ZQHYhIryP8seKja1JrON21XgNGoB8TKSxgnNIZMowFWPQ9rhpBK0KYUn3VJu2M85EpE7cbv8jH6Dp61luKnoIf6/Wug6TG2KMN/4P5XrJw/HOmjDF7eebphFOwaT7H60iGybX/2O+YAtv4a7qN5D0yXHXMGWfmvCI8wR+bscAR9XB86+ZbmU4lDNBFdnNk3zc8rggcfvEuVzjTSVxsICDVijZhjM56vwHDDyie2N8NkpgyvRWobQqVYpSo5y3b2J8ms8krdLkWYG5u+7IAk0pN+FV3XVG7gpW+yzkguKtKN2PXKk2tOEPKbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK0qMnQf2Q7VCrU96GoK8G6G1beWb9d1TGcQV7WtNfM=;
 b=JGWlni6XdkIvWL/JN0IypubKoP1zZKQgX5nKkFhu4avN/a80AFzpUHo+pIdMDikaAGmQNMVxi7yOfphlsQm0goFjFm4tZD50SdYAECXdV324a+hUif82GyqlQkNIVvxDTYFJv2DUhP2RKrNqtfur3xRktGdGYjIdrPWfFpIruULH8CXW2P+dGRSfM4n9jOy0e7gXXOWDN8gayKMQh/7ar9ZbzJicyVLjuKNpHuIoHYLPCbt34VDMghMVpIl62vC8yDQsbOzROhqFiBaSdNspdlQvN5FRnh9/Zd/TNu4OPRcwdyypo6QKBPuKUCCs07sIRF2x21g4SzLCNFHiZ4CVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK0qMnQf2Q7VCrU96GoK8G6G1beWb9d1TGcQV7WtNfM=;
 b=il3W6rOPVC58UrBn7lNMll1w3leqVhTu3T8QMrG0E/P6b7hx9tpuil3vcwKjSXe+/vlODpB8jeAB7OIJ2ZUzO2xu0zMIvOHulFi+9rBe8HX4aKqKP5E3MvCpKpXHVSwXuER+3nArXrZ/xXeVBv4AnVmGkKXJUl62L/lc2g/Im7k=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 15:01:42 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::c8) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:40 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:40 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Peichen
 Huang" <PeiChen.Huang@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 14/16] drm/amd/display: dpia should avoid encoder used by dp2
Date: Fri, 14 Feb 2025 10:00:31 -0500
Message-ID: <20250214150033.767978-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eceada8-c9bd-4bcd-9fc0-08dd4d087da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vyMOKtvS5y+PaIECHkVijtRWxHsHqcSW76tKaKrIl+4xNX20E6YfBp0NKke0?=
 =?us-ascii?Q?C/uJ+wpJdrl0RD8rsvsZhWmP3v6ISzuseoQXe5B/cGi9En2QUmkkRHVG/sXD?=
 =?us-ascii?Q?LRQ5etoH/2Te3oKrENVtmcWSWeBkcNMoktZfRMggbRiiWyDit3Sp05SgUPyq?=
 =?us-ascii?Q?3ALe6TU/EotyAHlDjDtBRRuN30BodiWexp3syLDsWc6gSyrU6cN89iAxgR3f?=
 =?us-ascii?Q?aw+paYc9Z+mjTwjNhcDYo/lNB9cuHQEvhrgyvNdqhsxHKfHRVl1AiiKiX9U8?=
 =?us-ascii?Q?UhtmINzXh3fGoGcdMaFLMRjUDed4K80R4xw3b1vTydstT4wPWgDY5xAkUvgg?=
 =?us-ascii?Q?UPB7AdEb99FpVNwQm5XKHTAf6qjgcVgI3vkUCC2lVYMewk4CgVpBdUBmEb1o?=
 =?us-ascii?Q?luFFgRAkRMq1Mp9x78+lw4PqRa3tbFDZTJFp8eNQFJeiXuO5cVWdt5Nu1zRt?=
 =?us-ascii?Q?be5FtWmM1LjnqfSz8ghBcFr1Bglza1aoJKnAFEh+w7qdWO5r++8sUH/ZHo9E?=
 =?us-ascii?Q?Xf4yrcmIbr8XJjiETCkVj7auG1Kh2nOw/7BaL2u0bHhN8nzvKOqzcVqOA9fN?=
 =?us-ascii?Q?PqrYYeqGXZCi8/0o3hl+tivMmUrgtrzMRKWXDfgPPnaQWgqNoTxW6wEgxE8t?=
 =?us-ascii?Q?rBwzql8/QfKaUp7iwkhVKeEdt0cgifw+wcUJZG5hkBjWjruJ0b+XLCVSFpXp?=
 =?us-ascii?Q?ADwhyD7L80lsGJkhbeFtJXM5qAz2xYDJ29T89Dx0xDxru7+lckO4sOW2MkFP?=
 =?us-ascii?Q?w5WVQ6wGcJXTj+xGeLDlqPspmxU2xJgqUVOhrFNRaVinXoldIHPbmGHDX/m0?=
 =?us-ascii?Q?qqu46Piagv9iTtEQa4XrJpyOLwKHJbas9GjeeqggUeF+biVoSULSZADwhUEJ?=
 =?us-ascii?Q?hymU3m7urlejVaw86T1wbSDwYcVMXU8KytNuI9VNPWA4RMIfDLI2WBt3vSa7?=
 =?us-ascii?Q?OgINIxpTuTfw9+wdTc4BuVzImo+i40dJdMaMHru+fOGj1a7ja76RGQM0V+FM?=
 =?us-ascii?Q?SsYQ78qR9TlgT9MjxNArQJcHzpeSnBOziyHrzFeKoNMdcVOVvIodaBTWiMJQ?=
 =?us-ascii?Q?6NIIA5Tj6J5ISS3mrIrBsl/cwFof1H8gN3TSTjwlekOpOt11I57hnHvE2M3x?=
 =?us-ascii?Q?bdpSzsOTWorjYwAcscyvuy9ny8ZsapMsCiyB4pHeqpyksBv2OlgDf81oNTmG?=
 =?us-ascii?Q?rVJ7/HdNTf5bIMhRbS0D8ALxPIlpCIh/cwkTOYpmUNhxEw4EpIQSahLiwAcg?=
 =?us-ascii?Q?uVCAdvfF5DY1ysthGhvgHFTiBxS0rQRk6Srj/18fHf46KinOrm/5AoPn2UPn?=
 =?us-ascii?Q?ufMzOJTee6ZIySBNqgsxaK5ENfAxFhnHTezwRdje/h70FoHGDklwqmGh691C?=
 =?us-ascii?Q?egIFJKqwx6F5AxDzbDemRheq+FsD2PWvV9QUhN47tM7FuabhKPz5DWjEmP8y?=
 =?us-ascii?Q?BlMbJVyTjGmXLwMb0+rQoIOw2U/5c/L2RxCTpGZClVRdV/CMF+flh1GfoJm9?=
 =?us-ascii?Q?UMnxT/m7/uf729k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:41.9042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eceada8-c9bd-4bcd-9fc0-08dd4d087da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
In current HPO DP2 implementation, driver would enable/disable DIG
encoder when configuring HPO DP2. Therefore, usb4 dp tunnelling should
not use the DIG encoder if the corresponded phy is used by a HPO DP2
stream.

[HOW]
A DP2 stream is treated as a dig stream.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c    | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 08b4258b0e2f..814f68d76257 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -44,20 +44,8 @@ static bool is_dig_link_enc_stream(struct dc_stream_state *stream)
 			 * yet match.
 			 */
 			if (link_enc && ((uint32_t)stream->link->connector_signal & link_enc->output_signals)) {
-				if (dc_is_dp_signal(stream->signal)) {
-					/* DIGs do not support DP2.0 streams with 128b/132b encoding. */
-					struct dc_link_settings link_settings = {0};
-
-					stream->ctx->dc->link_srv->dp_decide_link_settings(stream, &link_settings);
-					if ((link_settings.link_rate >= LINK_RATE_LOW) &&
-							link_settings.link_rate <= LINK_RATE_HIGH3) {
-						is_dig_stream = true;
-						break;
-					}
-				} else {
-					is_dig_stream = true;
-					break;
-				}
+				is_dig_stream = true;
+				break;
 			}
 		}
 	}
-- 
2.34.1

