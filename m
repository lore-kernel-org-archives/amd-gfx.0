Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6415BEE20A4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08BD110E70C;
	Fri,  6 Feb 2026 13:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LsqEvfKN";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B38310E70C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYDqVXMOImuU7yS5ArVWVRFgeF7y0J0nw6uCEg7z3z9kUrXZJ0hqMBuIV048nqpHYPT73NRR163xRG1hkCjATjNfeB2IvNrYuphrs6ZT79/yMwMcLQppuASdFejaADzUSc1/GR184i/RDZAZQdT5czsqS6MeRLA9j8G8CZ9nuVz4CG4o3ZX+QvEgq+aA5ly3MvoiHmeKFRkzI8HRGK8DELNxtEf8B+mEINfUUVWoxWsDOUy8M8BYoZdb8sks4NR6cdjbTBIC01R/XN/yVreMFvKiVjPK5pgNskatWtaSG21fTkB/kLR+D8xmI6Q10xIu0UOyh6uYicsaPhJIFskSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqdJkvgtFx2rtOEILLQhwlZMkzY53Dl8yf2NOXn4hO0=;
 b=gYmzWMqCMF6MZL1vp23sHLpKveiUUg9y7/C+8s3hoJ4KIuPFOOiUqa8DE7zG+P2bX/8nlOTI3s9uY0cjAl2pJmcOtCVXPEIAfEB+sRgDSfjOtjcLxtKOWxFWP2M6KHAqvHtiYV1lf49mjrLkb/yA6YmBQkG7Fxga/w79/PABh0p5cuB8X1cbfwAOo1/R4emmpMvgx+cY4usJOwBb/aff95cbqqXj8IMgEMUuZO2nGZZAJPtuMgcf1KYmTXHbMwOUoUaK4Lujhwgy14jzwVBr6EvfkRQHkxNH+Hc6Ab4LSogtGfA9bHUCFtBVYikyVZItZHS24fTUhigcTufs8BEuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqdJkvgtFx2rtOEILLQhwlZMkzY53Dl8yf2NOXn4hO0=;
 b=LsqEvfKNU/wVLCIigFHrjHxL1N+UQoWlwNjycF3AvY/yUVld9PtcKszUNhvKGX3eUJaVifg31NB10xcW4PDN0kIV+pwS8bKz3N/K0lMPUsU3q25liu7pMO2gYjwTlfPaB89kJbi/MG8Um3jYOQLueacnTcPsjfGJ6U59BbB2CDg=
Received: from SN7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::19)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Fri, 6 Feb
 2026 13:36:32 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::47) by SN7P222CA0006.outlook.office365.com
 (2603:10b6:806:124::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:32 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:30 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v4 06/11] drm/amdgpu: Fix is_dpm_running
Date: Fri, 6 Feb 2026 13:36:02 +0000
Message-ID: <20260206133607.91047-6-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a64fb0f-e18e-4edb-107e-08de6584bda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wToYMDiIZ1fBN0D6ZgNg6RyuSyFzi5aLhqlJhoPDrrfOWr+YwgEiIU61mj8t?=
 =?us-ascii?Q?5rL/LRO8ohLCiZv5XtBN7Kjy/PxoUgUn/PBv5k0f/qod22s8ldNh7uSjo8DY?=
 =?us-ascii?Q?CgnLUqUKuXJNS7NJpCfHDETedBUoTmm9T7/5/wzpMkFpQgD5EAuhM0Obq0XK?=
 =?us-ascii?Q?IuqECVIJo1viED54T4snFDaEELj9Bu2yt7X7NoyM7stBFM5lW4Eg/FNQSJSR?=
 =?us-ascii?Q?r0cXzEtJssaQXo2v5OhoVbEqdCrOoKwBugoqnUttifF2OTlGOnURIqRzfH5F?=
 =?us-ascii?Q?j90ECvTflLrA2crTD66RT6/F7kMqTi2l69aEm+ljCjzMg6yhPdoZU0l2aWfO?=
 =?us-ascii?Q?nPyVkVBm8DI9LsWGJgG7kF0CLPprr6cPEOxW3MaIF+CU8R9ecSlXnVTU6VmS?=
 =?us-ascii?Q?DadmagayzD8TDR4eMBubQn4VtCITYb6BOA3g2cqjRPb/OEEu2zqCu3LQ/cXo?=
 =?us-ascii?Q?Z7cf8v/J6gtPn5J+Vq+A06oGBBdTjN33L44Y9gDp24piuDtceosr38RcoVN4?=
 =?us-ascii?Q?w+wJSORAFdexjeEhx+rMnLD+sXuHvNpZSgDLrTvGZPzw7MYTOcjvfNdSk3N7?=
 =?us-ascii?Q?5gIIaX4FNnzSirBnh1jXoz81jLymb3nXfi7bSnSuhGA4otWA8c1HDXfGGBtf?=
 =?us-ascii?Q?/S9SV0+hQr+ktXKmSZNOzKxo4NZIJcsvDWCpMSG2UmJSc7NBTJtpnSewNGbZ?=
 =?us-ascii?Q?a4wj+PyGUD2czhqjWCKGg4P/OKYIRiOOVWuh9uMC5nzoyS/AuvDr/IOsr/Ir?=
 =?us-ascii?Q?jeRzodUqax+P20D/mn2psihgVE7fbJ0IIaWy1wl1PwiRc/guuR9s24KGfYyI?=
 =?us-ascii?Q?jQMi/j6gRr7rCbAdBnYQrQ8GHsUB/Bem1nUNDeQDktXmL0W/yQWWYwsWt1Ls?=
 =?us-ascii?Q?VRZtLqGRPhOsjvKPR0XgLjN1efW+vHJaSWXD0rkM1lDjzao6nJ/MLPeWa1Lf?=
 =?us-ascii?Q?L3ymsgWK4N838yGkq6uuTkVln4Xqyba1RFOaEJiiicg+q4I/k6SY5CvohhX+?=
 =?us-ascii?Q?gLN0XgUJgS7P3fmzZLZ7opVS2odDZphBrH64J0JWrFucGZfpnkzIxxtYmEln?=
 =?us-ascii?Q?vfXrJ09MTRnEpOwXToHtTAOrGqWUYQuERildLSsWR05jE9sd0lTXEugJIaPk?=
 =?us-ascii?Q?YEiU4N1wnBWIEmTRt2JjPK51Bj9puHD532i4y02Fa7YRU5VscD1+5LRBH1Jt?=
 =?us-ascii?Q?VfFlSacNqrGRZxWvror8aTtZ2ewhqUgqBGAHFjkIesKDUz6gnfJKfurjMDD0?=
 =?us-ascii?Q?3Q2ulqxnLzQrlmcpulgW39ngxfBuEU1jBxv5VT7Zk7HhCW+7re0mNSEyQaKb?=
 =?us-ascii?Q?qZ1nREqR+E+Fy1eYPkoxrX1GJb4zSaX5yItNE7WGtAELe3CYZRmJa3zBd7SY?=
 =?us-ascii?Q?97gG5ymruJ3HOI+fCjueNIX2aK7UyuYtz5y5BzKBFthUjS3fSBYMjsRvC5xi?=
 =?us-ascii?Q?rFO8esQrdKPih4EUoTmKL+M/JDjouXlIQccLwkIchGa+dlQGYJBUcZmbW9yD?=
 =?us-ascii?Q?1jfIchSkyB7IeieLK5PmH8KKCCPIXLFVyhNe42dz6UDIIIwCp8E1fQDDR01i?=
 =?us-ascii?Q?6Czd7DEhjWtg5CF3uoWACb3amBmgxEYxVUH7XrXhhQCwKKT+oTzrmZv7hTux?=
 =?us-ascii?Q?WMlpgHFCo2pt/lhXiEDuHNH0+6MUMJEfmwZj+PJTZSmtM5iTvO80oBNqlowJ?=
 =?us-ascii?Q?zxO2ig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FQ4nWTo+Z9BvtKQy521k+Cg5zGDqbpavdarFYTzuoHyJeLN9fo6N2E96+vUFrqYeK2FB+PvNa3tqAOglzcq9aBwMDSTB1M6hhr6MCPoEK5H10WeNrpjpiRh1Q1UKwsecYGIMwkB8ZF9E1vKXCQ6eoTSg3jcsrXTo4dd2//sOU++5I3mIIwWrd324KwQnn03AKOoDj9kh5MiMu+RSeK4dp8609BfK7p6s1PZ+urAnEub85RNg7y/mV8wKbWHAkVDD4NT/p0Q3u+xANhvcV4cbkx5UlGjZHaiGtjf7iEsoaDYnluzdUxJ/6OLx7VMV7dmckDUUP06tvcmd9MqXJ0PW7ExieSbWgUSVmXgIlaBKH3dQHwYHWzXDX9iNp/kRrWCwoPnrg0TULm4GqjErMJ+sEjQFhC4EST2/cbnGtrVk3mie5tS35DWtLnB7DVAwEAa8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:32.4407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a64fb0f-e18e-4edb-107e-08de6584bda6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8
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

Use multi args for get_enabled_mask to fix is_dpm_running

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index c07cf438e4c0..0a8cafc84435 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -517,12 +517,43 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
+					struct smu_feature_bits *feature_mask)
+{
+	uint32_t *feature_mask_high;
+	uint32_t *feature_mask_low;
+	int ret = 0;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!feature_mask)
+		return -EINVAL;
+
+	feature_mask_low = &((uint32_t *)feature_mask)[0];
+	feature_mask_high = &((uint32_t *)feature_mask)[1];
+
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetEnabledSmuFeatures,
+		.num_args = 0,
+		.num_out_args = 2,
+	};
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (ret)
+		return ret;
+
+	*feature_mask_low = args.out_args[0];
+	*feature_mask_high = args.out_args[1];
+
+	return ret;
+}
+
 static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	struct smu_feature_bits feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
+	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
@@ -1394,7 +1425,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.is_dpm_running = smu_v15_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
-	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
-- 
2.43.0

