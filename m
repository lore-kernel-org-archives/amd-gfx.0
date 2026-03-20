Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE741093168
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 01:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8565D10E884;
	Fri, 20 Mar 2026 01:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PjbPk1h1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A1C10E884
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 01:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws4VFBGCvgm8R2qObMWFnyg93wT2NOGdyWOobq1NteNuT2R6SdHRcmlXc/J2zA1sbuxYdaHvI7ctneEzxVDi7LYmoHR5tLNer2mmB8v08l5IWZtcAsb+WVFwPfVzEUkdM5y5aBFqjmXPq98OqXpTknuwdoYZl596zajrHculH29o1QjcdBNQ/OhIhza5cKvX1+rLTXkiWJTAfUUFgTECtgzYiwR/xtca+S5UUi9Q6QDkM9Nq20GDLCefnm27cubG9bR3Pn1yVV35zFqq68TxI2GrtHTaMql9hE/lU99ZW1xYutg3LrQcpH/N/UfNKnjTzx+9TPTfKLwuz7emxYFVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYT4xetLxZ0QKKosY75F7PjTGCB225iAfGXCRvOptT0=;
 b=qbtMXJ+jhyy+pPoDC2npm9Rzy7tlBSDBaqL7hIrhdWKaovgH7QiCopD1PbRvb2HeVE3TgCuLgSAgoBfjxI3pKzZp/WXC9yJeH3LskovlZ25GVMd2WKasEBknbMkZwTSdOqfuAqIyaWtBMSLApYVV0bJ5Km7+Vj9gCxQtFDQS27XpiaMmivAZ1UNnG1RxNcFH6sud5/4EKddZbohoHn97xLomshKIq+0ehr+8pfHQvpAer2dL/m5YpHR8oJmh3nqL0pEZ9YkSYZnei+aeWfriMfONNFZukPya2Q82L4HA1uQIaIxnkb1Wcq+axO5GTnK9kDDSqSnK3O6VhYgPcA4tiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYT4xetLxZ0QKKosY75F7PjTGCB225iAfGXCRvOptT0=;
 b=PjbPk1h1jiEz2y8cgxaJf42xDtqz+126yvYpXa/LEMULQ/iD1ScFsIQufMprU7SaSpZbokTVyfIoBwLELQ/V4fLiIFzSkxWDvmmw7KAlSmbdS+fkQuAjueUl/xo7YD0UMMtsXEUJRBCdE72pHudpa5j8TXePPAGFJAEdn/hgD8E=
Received: from SA9PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:21::23)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Fri, 20 Mar
 2026 01:48:14 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::92) by SA9PR13CA0018.outlook.office365.com
 (2603:10b6:806:21::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 01:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 01:48:13 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 20:48:12 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range
 invalid for smu v14
Date: Thu, 19 Mar 2026 21:48:00 -0400
Message-ID: <20260320014800.228582-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320014800.228582-1-kevinyang.wang@amd.com>
References: <20260320014800.228582-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cc0073-e2aa-4607-8414-08de8622bfe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jXKOAZ6V1NALiITQ03CS3oyabrBc6fxwbLgK199HJ1WEaP56u7xgHnUycCijviuEx9kL+trxqTUr6o+hTaD5jZLVa6UJvJg3Ycx3s3klYNvKhIOtpqLsMi9siz0iDh8/ILGkl1sVgiLro9t19bZTtE5N+/8TmCdTdyI3iaNPdKyDok2eKV1vOBhVNTLUDWwnpj2m2B7NlqwzFV6JiPXGTs9ZFAx5EBRlvjbvlCMuTLTmk3g6C7oaswwYPZgulEk5ORgHygoS7Vd8eVAyXJlEcjufSAhYLEXNl9EU0zy3GcDOingMFB09+EmhJzGJtTDql7i+iyNQeY7siIiK++7E1tFmD/ds/ERR9NdSrmjjv9haqZj+6hjiCYoRFE1iBOvFJVJ1JidmcS7DfdFI6iSyN9t3NtFaaraQ4B+1tBmAihGxvi6hVl6mjYdNloZbkGIZFP7f5JtNZHaoAC6yHCrcShkH9AzHYQluixPcC8gb7bkiDIS65gfzFP0XWRJF9c+oQV3aWDlQ39Xkfx1+wWId2asuPE40cLHkufAAXcal0JkY3M4wtRvR7Onx2UHdeQIy+nF2Pxq4H0GNz8Ttf2GszAE3NGaaD53P5NWnzpmZnuuU1Z5s3tDulBJyE65xn2YC3S1i3/JmsSm4U1rVCXInn5z+geij9EiP9k1rwLsW65G6FV1fFu11oskTwcivzAPfsGB99z7YbPqV6Vhz7kW2Mf1VL6tt/IUdNo/TbTp5675W0A+F+rIWZnos0RSeASkS2DouyxgXi2X5pFGHz9VzLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eisWr4S9Ng1ONHqFOEcIfVKqT2FJMC/48tQbetNT9zZTTJkdIU5Su0NS0tu3raNAJz71+QOyCQKUeTr6emE5zQUfewq+oHeLPgHpta0JGMjxA4FZUBThkmDVmZM5ne0VXuglPPp4gZC4yC0eD5P6HGf7UuVsv/m+/2tOijOY1FYswtG4Ufg2YN4QOlijNLpSeSWXj4xMCMdmHbUuyfLoCbQGESsVLRigFFsI883dqR+lEG3eL90KLPptQl3Xdb8+D3POh78UGSQua1E38m50/jr84DVliglWXFRTgs11zcmBacB1qxOt6IqkLTAwCuSna8dVqaN+l/ax9aBle5XwwjxHdnvdOw+8t8krltCQfmPVRGY4WyXx0W1wsuKerNJV7p/9xfySPdp7qAORQ2WwUKD2+hg9P+XkDP46rUWNijGOmKfBQLQq0t6pg80nD5II
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 01:48:13.9277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cc0073-e2aa-4607-8414-08de8622bfe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

Forcibly disable the OD_FAN_CURVE feature when temperature or PWM range is invalid,
otherwise PMFW will reject this configuration on smu v14.0.2/14.0.3.

example:
$ sudo cat /sys/bus/pci/devices/<BDF>/gpu_od/fan_ctrl/fan_curve

OD_FAN_CURVE:
0: 0C 0%
1: 0C 0%
2: 0C 0%
3: 0C 0%
4: 0C 0%
OD_RANGE:
FAN_CURVE(hotspot temp): 0C 0C
FAN_CURVE(fan speed): 0% 0%

$ echo "0 50 40" | sudo tee fan_curve

kernel log:
[  969.761627] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!
[ 1010.897800] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 44d1168be812..28c1b084fe62 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -56,6 +56,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
 		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
@@ -923,8 +927,35 @@ static bool smu_v14_0_2_is_od_feature_supported(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
 				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	int32_t min_value, max_value;
+	bool feature_enabled;
 
-	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+	switch (od_feature_bit) {
+	case PP_OD_FEATURE_FAN_CURVE_BIT:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		if (feature_enabled) {
+			smu_v14_0_2_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_TEMP,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+
+			smu_v14_0_2_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_PWM,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+		}
+		break;
+	default:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		break;
+	}
+
+out:
+	return feature_enabled;
 }
 
 static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
-- 
2.47.3

