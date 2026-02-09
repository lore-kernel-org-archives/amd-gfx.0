Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E314CE81BB1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8115210E3E5;
	Mon,  9 Feb 2026 13:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c/2wFeAd";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5065510E3E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWEg/jV2rMMvu3ssKVU5E9xbx2At1UcCiopAgENZk1oLOLrirhYw0ShHo0voEo1LjgvRl3GwqfBfXUQopcuoHLVAvr8LSfcQXCy2+c75MJ/BPJffPAuI7tXA3T43bxVHn8aURKn3Lte6RvqrswWGCeANxL2qOhJJONtUvjlSTiR06R6gCYE58SYxH5u2zXDgE9355jWh83zKjH1m+Gclh1zxVhyFhWzBgr/lY9KeN0xTPR2jBOaipz7tLyutuN8lDwnkJTF9zLp2PR2xcznHM7+rkXi/ViGd3n7lVIjNV57RWuZnJNwVlZT+TX4sbRyNb0pdv6Fqg+3cFmfnzOUezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y41xVI3bHtdOTMdNzK+peWkt3kauzDiYcblPvC5ronY=;
 b=NJ5mEsOjRSxTmKRGw+esLiHCAr0Xxw/vIPUeOlTAVDcXZx+GAp3k5Hr18kaI6WqCaSATcXSRICCreBpZkLp3gc/veqjpqKaljEiv+rzEchIJv+h8CTTXNdBlyddaEhvDoquyjY6bnWhnJDCLZpOs3SjwhP35+U9HXNidhvU7ZTkz0ao6imzrp4Hmc2t0Oxe1D/cpcyWh+ibUSdNYcUeaiLuimtpDAtHZgCnrcOS8gLCkln4qW7uj/p9mx9J9ahPrsZ3atqvtrU8wE23lGMJ5BzdkupsqwtI9VVt+q2VG3kYLcgUPubscZFoKqXsT8wJ8Sh3bIJigXzqa5cxe3fJ/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y41xVI3bHtdOTMdNzK+peWkt3kauzDiYcblPvC5ronY=;
 b=c/2wFeAdkxjxfssaa3zoI0/7ie+pA5ceNArBnDG7MUKlNnGnYQVbYUh48D67B0ScBDwCHlFLQOtFGiycqOBEwyEVMV9guSQNPsT8EPybWMYcQfI2vCnX6/tPjVFuGm/FKF7J9c2yFyWsiMfJUiiWVQU10Sszbo7fISilvQIeAGI=
Received: from CH0PR03CA0425.namprd03.prod.outlook.com (2603:10b6:610:10e::27)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 13:04:48 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::25) by CH0PR03CA0425.outlook.office365.com
 (2603:10b6:610:10e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:47 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:45 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v7 06/11] drm/amdgpu: Fix is_dpm_running
Date: Mon, 9 Feb 2026 13:04:08 +0000
Message-ID: <20260209130413.118291-6-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b695da2-7874-4371-72f4-08de67dbcd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1TZZ356Shl3UaRXK90JJpp32wLleCisjZKwA9cyO1M+6rfFMW0593rM6vjbs?=
 =?us-ascii?Q?jqUo8idoJTL4y1Ek3rr/8v18Wz9iugAsnaJE1cAGT5P/HOB+tMtVPUtiM2KJ?=
 =?us-ascii?Q?Hn/89D/xL8o33F2GZ9/KVJ1XXA6FZST8mkkbfhDJbAtoK33HkdTE/qTBJ5BS?=
 =?us-ascii?Q?8ZCDOTZqJjwHXjcml+vSk+pVe3ibg5osTIOG1XtG0DaOuvKd3rP8xPIhBKLn?=
 =?us-ascii?Q?D+fkIKNZMvzS3XI8xjhfxz8riYl5NLfU3rhpbi+Uz1MjwtL+q9IMsFHdjboq?=
 =?us-ascii?Q?KbQHXLOVtnvcCdLtM4kVhkRkFd/GQ5Yvi2o+3N0wtBcBLPIzVyRnOs3+mgNh?=
 =?us-ascii?Q?cUYnuapfsd+2c9h8PFFja/j3jJiT+fQP2yQz2sRrEaMZVWAo5Cx0F075XNFa?=
 =?us-ascii?Q?kfRy+NxDH9mUAdB11/K90o9/GnO+oSrFA8mq63ozohshQsUpriJZk/6kHTqd?=
 =?us-ascii?Q?Qb/pvL7hv3kbWve6GMWRLmVmeRoyFgKYXX0KtuhJRM1SqoK1KPh6sIQ+HISc?=
 =?us-ascii?Q?ILonEAS3qkAqJ9K+8KYUApvSI//HHuGViNbUDKQ3kbb/zdPiBH5EiVMrv14O?=
 =?us-ascii?Q?4C5oUhLlGJMsNBWsVZqSapac7YhAE951OznSUk3YyzVULLKngzxVxmkHINCk?=
 =?us-ascii?Q?TXOwtF5/0cIIj6Ec9qYAD6JoensMyvZreVTl+Akj97lYX7NbKThUI+MxaF3A?=
 =?us-ascii?Q?z9Rr8Sh8Yt+eAg/IsChFTRKW54I+0bR/+NUQHfWcvdRaTKbj5cDYpVFXpith?=
 =?us-ascii?Q?QcCO+CBovJQdH6Ybavev40WcAILDR0X9MPpaIEN51yzxozSOVGZT04cXRtty?=
 =?us-ascii?Q?cqQOKtI1xBYcYqLfHhGmSh64UWRsES/qJgFPb0lP05SXAvswkp8Tsav3GpOq?=
 =?us-ascii?Q?HcC5UnZKjdQuPZ20wQginPgVqLms3KrekUXq0qWe2QizYIyRQjk8zKpUKq0e?=
 =?us-ascii?Q?KbgeKx8Vemz8bWogaAQGH2QU8LnfvJnw7Jfs3+nSWZ0zSpIYTEitciPIYXVh?=
 =?us-ascii?Q?0GI3Nm6XbLZLoSzPJbJe/ab65auyE9EH5A3xYPxyekZl3PcSBfijBOiZVTMC?=
 =?us-ascii?Q?Roe8ddM7FHr7xK2ZCH14EV93XYSZsTpKmteYc45/Y2O+tmWbrqLZbxpxJgv9?=
 =?us-ascii?Q?otkYoufpyVcM8G4YjYDpwUd15NEPARRqLRtTqUjZNI+oexzgcKnZmfEBzIPM?=
 =?us-ascii?Q?Kz8uYKGPdEZ8plRhi35Vi+fR1DLvkGwz2Y9Pyhnogkh+6BbQJUyAelRJ00bZ?=
 =?us-ascii?Q?/AvutVs1kMNOoQVsGWYgXSMOb/YUF+7I05fXOol0wVMtFrsNhwaSTbI/arwj?=
 =?us-ascii?Q?gJ3KY1607mgNTwAG9+L8TVS5PgN8cbyIVxfaKRDY0XMSAqnJApb9/2l1w5kM?=
 =?us-ascii?Q?NdxHA2dwu+KM1P4Xn8Rgdeivw/HvyZdzPq5T83wSbC7QxTbDNfxhHfVGgjn8?=
 =?us-ascii?Q?Z2iS3mgX4SJGngeeXiZmDdjQG3/o7JwIXq7nc3xHyZ3i9MIKSCAcwfLACdH3?=
 =?us-ascii?Q?8SlPnWBFL4dVDe6ho3+OZCblODgLj0UweU2JuhtV8pp/brcNoXAhsgVVENdc?=
 =?us-ascii?Q?f4o16Ip/Od7LpMp/NdMkqra34dAQG+WOgcwQKThu/4gGDxG3gGhvCfBgrEYy?=
 =?us-ascii?Q?fsgkep4/POoZSnh4OtmXv0tyDruCUs84AcIp/8LmOU7xPClX3u497omg2Nah?=
 =?us-ascii?Q?s+ANiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8gqBfEDW9A8uvTHmZxp2l9rL/w3LLaR6uyZaPVr934E1gZa90pVb0yQTnnUF1no9x4AwL15/mxLM0Vg+om+OeRhNJPtgtUUOfPXvfPtzs3rowMhuDO2qRNGV2H8zUF1yEEAXx0p8LQ9S03eBuSdSuDsnKklnvcsCJiygRlnMRW2G8qtXVU7Dli6WZN+mTIeW1XlKMvbhNWeyQNGAcNHhqrnLsrueE/zle0tFhkk/yCjpi6bFTux8L4twp159rcLFqOIZ6HVBmKdTfWnPqQW0bKkWJRDrQi/uYDe8xuYhfIPmX2nV/0SiR1/ynFUc0jKPJ/1A6AzKpvEvDFh0t/vhqK5hSFVp16GmNZ6qnCHjQRz9QvXiv9kYHHUJPMOAQFqvwf2qCib3vi0JlQULMRGUtLjLOlX6poTjTLKEMj8FkW5LFsxwVjo6X49Fhssg8bM7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:47.7227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b695da2-7874-4371-72f4-08de67dbcd95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index b42d56f7e621..c1ce603fcdd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -479,12 +479,36 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
+					struct smu_feature_bits *feature_mask)
+{
+	int ret;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!feature_mask)
+		return -EINVAL;
+
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetEnabledSmuFeatures,
+		.num_args = 0,
+		.num_out_args = 2,
+	};
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (!ret)
+		smu_feature_bits_from_arr32(feature_mask, args.out_args,
+					    SMU_FEATURE_NUM_DEFAULT);
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
@@ -1356,7 +1380,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
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

