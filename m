Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DCDCF3196
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 483D310E687;
	Wed,  2 Oct 2024 04:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJm7B/P4";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52F110E687
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FehKfyyBmCullIe8N6uqaV9HbJbfdvJexVN4WuaoBKpJtbDDlSqYWF+oVIqqVewx+T9n+TwdbLNm3C0vV7AJG64/scB5W7jNFH6s4FkSJowr3l9NkPyJv2GKSV8HRjeTk76sc77F/g30fr+OWGAKOuJGnUIvpgdGKA9zP40mvPjVZNS6OGO4ZuVgsqLhtCj8fe80v3LnU9ZbDW4SMOHWtieOu3BG69WZvLiOMCwtbK92mOYm5XHU2jKyft1D+sY4ekn3BppXFtNAXN/Y0XuShEU7CXQlh5BTdWBeoT7T+K0FbUFJpQ72NMqmGnGTuQSGG6Y+GxAlXvkcXIiKy5bvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SYF0MFZs9XaUQO7SQ0+Z8EvXo6aZQsdkRoZr4eDtcs=;
 b=i+6TwWBDhZyXbVMp8DMwI+YHKAhj+JrBjOHYhDtAjUeoTBwgkhQ7mRtxGrSgMYMQUH1zyIyiDQR3YJhsOl4Y8OuIOvParoLurvtZRtp5yyr6PIFo82f1VjeD7w1JlK9TjCss2Dq+NRonjZY5l25Xnqg7e+CRSz8HtDfnFarITxuK1WzmEKLmY9zGNd/BsGmNFXyswD2Aka47HmewV+JxRMbXdMLjsxmtoTXdN8TSOx53FukyhAT6kqXbwa0dE0jEbngNNW9RuDLPgH9QG+sVs2uDBTNCR9n+C2MI6nqLaBcAL6w/Fey4dR1UD+z3kNaqWf++MdWTRptu0QhO9NlYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SYF0MFZs9XaUQO7SQ0+Z8EvXo6aZQsdkRoZr4eDtcs=;
 b=ZJm7B/P47Vn9fxVFlbNgfgFVYOuBntvIR2SnUEDBp90lSAFh9o1zaYm3WEoM9KEKmhCcJnshFi/621Jsnlq1Yu9hIcpALWgOZfkA88SIlkTzIg74Nz+BLTd2OzaO/exwUMINMp0KwiOgCkzoK9IGpS4wcdw5nm7P4uj1eDOvfRE=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 04:38:52 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::4) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:45 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 04/18] drm/amd/pm: enable vcn by instance for smu 11
Date: Wed, 2 Oct 2024 00:36:13 -0400
Message-ID: <20241002043627.102414-5-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: be45f9fc-cdca-4f94-bb2b-08dce29c1d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvZoJds6rzpWGZqgcYdQgRRYe8X9n1RW+f31GSKC9LiTdSXJ2OlfVWpe5gno?=
 =?us-ascii?Q?+TXHM6BjkOsin9jkBrj1Lrr1vVe19DuNSK/sRq+QNG59OQUAZAL4NX/SnzrH?=
 =?us-ascii?Q?SYnTwsjQ/LPlZ/WzFYl7Nb19fNruBYa+1OujxL1NwUsmvI/++EoBUlhQYdkS?=
 =?us-ascii?Q?IMVv3ywQPX8mK6Rblt1DslmL7e2KnU383SaF4bO/XbHJoQ9xRs6qTxhQzP/o?=
 =?us-ascii?Q?TLSv01+zrWaDDEAHctqhrmTII3crGqyQ3ecIIXlk3yv6xi4TY7rAgri+tJ+O?=
 =?us-ascii?Q?xGQSwUHncS/kahL0S1aDoC4wEgt5xRPJNGs0jNJQaxj9IcZMXNf2Rn5A5zVu?=
 =?us-ascii?Q?8JQBYHsatm9MpP/5yVVmLpDsYfIsBBYeWngAokStiyJUkcW5Fezqs0LgyJ7f?=
 =?us-ascii?Q?Nfgdrs61oTLEA4khGiVLsAQPnIB2iFFiHr9rMkfoenLeaK63QfoC+R/unRPg?=
 =?us-ascii?Q?aSKnFCeSskXV9Evs+Xbn1sxC/QerX5okciZ7quqMBIN8HvOLJN9O+/TYc14u?=
 =?us-ascii?Q?QUfx4A3ByGvZvGfQmukRhmTg7/CgzymDqFFe8ULGcMrKFSbNZmDm+3WhI/g9?=
 =?us-ascii?Q?f3HMpq3IKdlPM6wbKywKiEqinPt9OQTlIYNO+Oa9e89BZa66Mi2LZBr/dLQ/?=
 =?us-ascii?Q?oU3mOACGPwuipjOfcuLCiL3F2qBnZT174g1B2H9n7XBov41h+n1C70YXb69h?=
 =?us-ascii?Q?rp385vasGqqXyXQ5tBkvFKEcxeEk6UvRWxF/Hh4VYEq3RpXObtZ2ANpst+u+?=
 =?us-ascii?Q?P6NSqmYq05YJvR3Bj5IiHMWH27RPrk4ll0KhsD9Xr8AtufCAaBSBXHFXRyY6?=
 =?us-ascii?Q?xB89Vw2xhcT8841KsQ3aWjdv+hx+aB9QXbvJxY0gn39ROP0xsEl+8OWDY/cB?=
 =?us-ascii?Q?erRyeN8k44dFnQZJUOE9Hc4Vh5x3PAS2XSGZgSJ/swI8pINtfkw0TpaNSMVn?=
 =?us-ascii?Q?8IdZtihTDhfV0+kOgS6YxG++eE4owfGa8TlTovwFnnC2sybmv7kNm7ym4PNU?=
 =?us-ascii?Q?7c1S+j769DLtwi4IeLkIrjByD42Q59emT1A0o6E+raLCDdwsRP3yL2aF3yMG?=
 =?us-ascii?Q?c18Sawetg51QOScwIzwXNqoFjuxnnnwYKBVvQD6DpuKcLjbr+l76qxxOkd3p?=
 =?us-ascii?Q?ec4bF02fqeagWceruna6xgqzKdGakUPCUizPvwaxV32/tXkZzYrGbRYGZvwS?=
 =?us-ascii?Q?8sPKOtIXpX3X2+IyftaqXH1+4/QtnoKJi09jecZ5Z1we4N1LS8rSHMxN3zKX?=
 =?us-ascii?Q?su+5QSV6unWK3wl1Ul++UwpqSkDDPMBAjWsPI3IqeHcUZxtj+unTL95ldDcp?=
 =?us-ascii?Q?261Q6LyK+Xn7jSh3zyNPg/MT6+CkFKvQuktpGOSII2xZIFWsayjGjehiagel?=
 =?us-ascii?Q?ugAsepS3sVx84ZM3bqm2Df3+lggo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:51.2155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be45f9fc-cdca-4f94-bb2b-08dce29c1d46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For sienna_cichlid, set vcn enable or disable by the given instance
instead of setting it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3b29cb74c47b..8ecf49ae489c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1152,22 +1152,18 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	return 0;
 }
 
-static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int sienna_cichlid_dpm_set_vcn_enable_instance(struct smu_context *smu, bool enable, int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-							      0x10000 * i, NULL);
-			if (ret)
-				return ret;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
+	/* vcn dpm on is a prerequisite for vcn power gate messages */
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+                                            SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+                                            0x10000 * inst, NULL);
 	}
 
 	return ret;
@@ -3106,7 +3102,7 @@ static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
-	.dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
+	.dpm_set_vcn_enable_instance = sienna_cichlid_dpm_set_vcn_enable_instance,
 	.dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
 	.i2c_init = sienna_cichlid_i2c_control_init,
 	.i2c_fini = sienna_cichlid_i2c_control_fini,
-- 
2.34.1

