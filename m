Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FA8E7718E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2024 08:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686D010E7D0;
	Thu, 26 Dec 2024 08:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N8ZhhRcy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6EE410E7CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2024 08:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z80HlVqxOzi2ZWZLYlfQ4YIHoHmMbgA57p3NW1ttu9FzCid2STt35FefxEPxExlH88zqd09H/D+2f7B/9GT2QsW51tuskXxWdABmU4r+4pf4Mq6gNcwbllSQwrz1O8amKAK0kjlg5b/ti8R9cCU3fALf7Jdeqr/Z/CrvYeYNWiy2C+2lesGtLCNypfFYw7oI7uwVS841elXRBxHdbro/vbmxGWmaLhe/9LYbLvzZGTYkqoGG8fxA04F31HJbpgTpb7vMJEdaTDAHea0yI58G6G0NJEmV4OJeex08W7zWYyfEsnpaF1iUPTIW/BMLFz52BcVF5TzQYBojwk9FWlgxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgR7hbd/E7fegE4s6AIJJFhJzFnQLMLOPv93zvLI/0I=;
 b=bhBWOIRBaQ3/yebzgO9fGSSRHveF4w2b0bObg43sD5ilG4hf2RP6EvYtnXMJZtq56aooiLTXgTRNO16RCg4hdjY5KC/TmM50baNpDcpzTKm3kPiX/uDyOKhff+52lbQfmMDo85TwzOMg4POedkgoCptX4pg60jgZxd1i0Y6Zp4kz5v644OG15vt6qPCaT1BMpXjmlFUSZAgQ+6/q3IiK5L6D2FJwPVPAy5OPvEA9seAMu1wqZttB9ol9Pu4VNYdNBX11D6WIks7YYbCc8BoGL3+cSUgcc8o1NxAdH2VXSxB8HaOUWru8gP2Hq5EEebxkTjmQTHdvr7Jpjq2PqhYRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgR7hbd/E7fegE4s6AIJJFhJzFnQLMLOPv93zvLI/0I=;
 b=N8ZhhRcyJixDNdXt7XdHq1WSviKrKpN4firWP4cUcUy+1L9hCEsorxYQkLFutE0C4Fdr7CipquLFrTl4rbQbDbs4VW/Ekrp5+dZWUxzi489HgQEs1QE9uRhTx9AqYJlIg/iUyocSg7jAYkHmd8cWpHFaavNzuJf9ZGRZgrrgReY=
Received: from SJ0PR05CA0157.namprd05.prod.outlook.com (2603:10b6:a03:339::12)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Thu, 26 Dec
 2024 08:33:18 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::3e) by SJ0PR05CA0157.outlook.office365.com
 (2603:10b6:a03:339::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Thu,
 26 Dec 2024 08:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Thu, 26 Dec 2024 08:33:18 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Dec
 2024 02:33:15 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v3 2/2] drm/amd/pm: Fill max mem bw & total app clk counter
Date: Thu, 26 Dec 2024 16:32:59 +0800
Message-ID: <20241226083259.2670687-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241226083259.2670687-1-asad.kamal@amd.com>
References: <20241226083259.2670687-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba39473-97d0-418b-c432-08dd2587f312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JkAtxxJfw9JtCPF4fc/utyZZs3nxu5Io6i1pnmnzKRbNeSMmshZqBgrUIOsr?=
 =?us-ascii?Q?vQcZCr9vdCiF8VQIiRahHWQz6Pt2runxeik3aS0OzKiSSSHj33Sre4J28mPF?=
 =?us-ascii?Q?js9I4EpzJkMaFtQSVaCer0hcZRxGqXpl48AnhcQ7oxbkyXtF3JpI8YZTUUWu?=
 =?us-ascii?Q?X1DfHwMRYbkrG1GZQdlLmpAwBxvzBPLeRisChJ5DUqrlooAnJpJbRjpaK0OG?=
 =?us-ascii?Q?oaY3G8EC42FM4kCQMdNXTqfrT6KLsGBOKDzdgHwsJgyNIY3ANfCvaAwEK/Ky?=
 =?us-ascii?Q?9FZGLQiBJKBBYZTjX2hiKjmdwoGpdL85P3LyCqMYJ9VBRal1lcqg+6fYH4yC?=
 =?us-ascii?Q?r0HVtqzKIhASp8LCw5CsJ1tgS03jysHXUXISN8G4AsAwYZphVXaW4pYW1EuN?=
 =?us-ascii?Q?nibInd2rWtZYkiJWktyU/bG+o/mLg4oN/eiEP8BpBFq82Npe5X76arbkZ/CV?=
 =?us-ascii?Q?9K0aJNtkAwzrlBN9Jvy538LRMFJxyDe8k6t8MpWKI5xNO6rlCL20Qct39KO/?=
 =?us-ascii?Q?13jl/UEh0uYiFv70kXr99TbXI5MVJySZYGtHx1ZK1c3etknSw1mQVhxYYI+z?=
 =?us-ascii?Q?QwebP5qpO5kZQm76j8h3ncUf9QfJPYP/6jr/YTiJnC9RmX36rs8d783nbr2n?=
 =?us-ascii?Q?L/1J1v6gc/crSzYHHgJrFmKKAGqijSEy0LbXRQi4ov+RqWrrWTdWS7MP3xak?=
 =?us-ascii?Q?zkhd27pNhtPDR/4B7yIgMo5rMd+7tnhfTsi80x0A3lGyw5PlcxaRRKwVKIdo?=
 =?us-ascii?Q?eRoy7EsfmI7xfEDN7ztxr2dGmmcQu8+9tJmsp9pvIgfkRlzTyvKMiaM2aeNu?=
 =?us-ascii?Q?sCflhqop4qeVW889UpFeVMdabfxiFGQYSjyF6G1/iddaTmN+OPA7Z2ccYi0z?=
 =?us-ascii?Q?pHvfmxD3s9oAKcD+5L2bOm9HUOuNFPDygahK6DDUZWLp6+KKOU0fv3DIP3/Q?=
 =?us-ascii?Q?Ms1gUOxmNgHSoizZW8q4mHIqQsT32EN3rYc4Xi3hda7BjejUPyN0MwhKUJtP?=
 =?us-ascii?Q?p9pcn5MAzLgwSrLAOJHsGQOouVLqMRYK0LqP/H9A0BB4ALXQYrMQNkAuvsuo?=
 =?us-ascii?Q?qCvMm+VQauBoPNFgYLWISiDVm4dNufj3S/Vamyz1WxmEBh1oA+6lPSsM5X5w?=
 =?us-ascii?Q?vJFStEL1ceoi3tLeVlJEfdCEPAc9+FOzoEOwoRoSz/N898SkMIKFpqS2HEI9?=
 =?us-ascii?Q?LNEWnr768IVICBbM+QAqt7Au+2A34qErQYtpsY3SOyh/NMIflPgpLKJ+zJeY?=
 =?us-ascii?Q?dHc8baUsf2XtHlc1r/15s8EVfHl+1XOzdKgvz4nN4Kdx0hNjnmi6uX8BAvtF?=
 =?us-ascii?Q?hl+cmGlWdAffnEk5/ydNp6bm5+d/4ETTAFdb0km/EDdwUSeUcAtzruV8DdIS?=
 =?us-ascii?Q?xapQOjS6mkHP00mYh5jdMemuQHWmjX8ysZLRDWvsvaW56WOQbJLdaHVabc5K?=
 =?us-ascii?Q?nuM/VYHbExlIolMff3aH9WJzpuyvU++6vggEcZj2VTfiLaOPfoMfK6z5OGQO?=
 =?us-ascii?Q?x8LnEyuQwE9NgTQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 08:33:18.4290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba39473-97d0-418b-c432-08dd2587f312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

Fill max memory bandwidth and total app clock counter to metrics v1_7

v2: Remove unnecessary check

v3: Add app clock counter support for apu

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b8aeadfc9ac8..8ab30b2f7119 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -119,6 +119,21 @@ static inline bool smu_v13_0_6_is_other_end_count_available(struct smu_context *
 	}
 }
 
+static inline bool smu_v13_0_6_is_blw_host_limit_available(struct smu_context *smu)
+{
+	if (smu->adev->flags & AMD_IS_APU)
+		return smu->smc_fw_version >= 0x04556F00;
+
+	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+		return smu->smc_fw_version >= 0x557900;
+	case IP_VERSION(13, 0, 14):
+		return smu->smc_fw_version >= 0x05551000;
+	default:
+		return false;
+	}
+}
+
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
 	uint16_t hwid;
@@ -2359,6 +2374,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->average_umc_activity =
 		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
 
+	gpu_metrics->mem_max_bandwidth =
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxDramBandwidth, flag));
+
 	gpu_metrics->curr_socket_power =
 		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag));
 	/* Energy counter reported in 15.259uJ (2^-16) units */
@@ -2497,6 +2515,11 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 					SMUQ10_ROUND(metrics_x->GfxBusy[inst]);
 				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
 					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
+
+				if (smu_v13_0_6_is_blw_host_limit_available(smu))
+					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
+						SMUQ10_ROUND(metrics_x->GfxclkBelowHostLimitAcc
+								[inst]);
 				idx++;
 			}
 		}
-- 
2.46.0

