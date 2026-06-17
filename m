Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843FBCD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 11:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177D610EFAF;
	Wed, 17 Jun 2026 11:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hins+ptQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E061E10EFAF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 11:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyVVJ452jGG5iao4Csw0i1GskOs83r82iTVj8M52RSXa5ztLYcX8oTXYkckmAlHMqRi9YmLFGv7RIYMi+1oC0sX+HEHyb4fnjMSrJRN2CrC0ZAhJXcuFOd7cPUyNa5HMdVSSXklg66omoRwNm5OQq8yFiQ2K3NItbUDVG+Q0wX8KE0dYjzi8KHRn777L+YH0ePIkpNiAQGOeD1PVYR0qFZKY/9P73Sl8LPRy/lGKl/Jih7Q1iyHAPMKIDLdBqTONYlj1OZ2q6mYVnnAnSBvd8WUgk3fALe63fFcMYZRu7V6Lk9Y8noCY85rvdViefE2VCieeyBysJa7ADYgHz1i4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFZFIYQ+xVHeJCIsfBtTrmvR/zfEf3ZYYaS5Ax5RRCE=;
 b=ZEoIJnxFRy63WQnK+qZmgev1QsBa9jwone+kQw6b3/oBXSQAFvKaBZlYBrQ6YqGyHOcnrT9CXP2JMTpCswd0qFf6M3MuuzQEHARWJs/6rbKlqgRL4bvZu4hKdn1pD+6uv4L0n0a8CrE9Z7DbfNTi7feIAr2YhcnYLT7lM5upu70153nhC09htzBp/S8y7rtqSDfnggm1R/I6J3Pe9bSGYs8KT5v96LZCIIIdc56aZUulOWsaOtgwxD5Uni+yb6W4x6uII/GwT6971L9oBj0phQ+79t9Jz4nDTJVt5Jeu5cAA5QbysvaFPviPDpE93MucfxUpcPgmAeablsBXqURDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFZFIYQ+xVHeJCIsfBtTrmvR/zfEf3ZYYaS5Ax5RRCE=;
 b=hins+ptQ5Ch9fTz4uPT3pCwZ95qBJ7L07jF2NvSLpCwZhYt22J3aABpAexst7fbCf2yylpKGfqc5WUHlBudl1vhLH4iQc4jAFr9BCll79eKNPPV/3dGkDB4rUyaBel3P9HMGPql299hS22Js91z9GtjZu16EQVh0KwXWgncpsEw=
Received: from BN9PR03CA0973.namprd03.prod.outlook.com (2603:10b6:408:109::18)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Wed, 17 Jun
 2026 11:09:32 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::a5) by BN9PR03CA0973.outlook.office365.com
 (2603:10b6:408:109::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Wed,
 17 Jun 2026 11:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Wed, 17 Jun 2026 11:09:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:09:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 04:09:29 -0700
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 06:09:26 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 3/4] drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in
 DPM frequency queries
Date: Wed, 17 Jun 2026 16:39:25 +0530
Message-ID: <20260617110926.13765-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: a62c9e54-e5dd-4fc3-8ee7-08decc60e86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YTkmgFac1kgfzm+wB/y4BzSgnNMAt5fiva14oEViz3oVGdl98o7DevDG+cbNyd1/GZ3+E0XjNuIn1f5g8N9gO36iPW3MnDgAuESJGcCtJ/Z8FHdc5nYuZ6WFVstNAvXIlIvYLAgpWT9oWgCUkIFiWb/7saEfv/dUsRL4D29F1i3LlV8j2fDiKOax77xO/d31y4nTrA8KtZF5qwH6SOLv9dgdBzW2BaTC4sSsxFtEWfpiomewOV8TRUvBSl7RnzxOyJBv4QSlEVi0MsL+EkTTe1q659WREOqZkRAnc+MJATuivF3TXiZauJTBO4Nobz6/mOC3aMbNllPUoNKn1AwoOgLCxP6JixZG1qCuu/geEC7iYXymKxHiMvLBb1EaokAlWhe2PTwM73unGJkwVJfPlTaUf0Qx94L0bRewrUJlHBa0rgStHkr5x5pMQ2IqkotK64UD66SrturKaNYKHnpInK/YGQuPP24MHGnK5TcwFBh6Vk2bJ7ip6k/tK4gvlf2+BuBJMSuiWAiYWnbiwnR5u9CdyryspwUB6Q3riStMb/UvWpb73v4Rh5eFOE/CBs2d2wksMvZNe0ahZsdd73lYfh2k3POBt9NGi5TXc8IRyMThaq0rgwIWIh8HwwSP2mpIoEDMQmAsDpTgldsqzg7cd4rGxVMG5frHvP3BYFTKgbDQu9gyiJ+gaKK9iShqKrZeBr1dXXUlBZD/pHdkywTP06OjDgZDktAlBTCuCylB8/I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q7lYymgRmOkKxmqp9rmwkoqoZ/nO5yc9ZxoP5JvbBWZpwI8sVw5RjSUa5iqC3WYxzKE763eq39xVK6DUrW7VCbM1nanqnItmkt9MgxXKfr0swrnb0BRZYhsWFpHTiArfozxh8nA7he1S0tm4qUL4DMf/4OSVr/uBq0A7AwOXFEXDLlWbLhjmtWmj41+pAM7NO55aO7rYODPjE0xBoy0qacBdad+iP5RregM/B74gWz7DZpm3a/mdcHMjMbefXT+fDzSNO9SGQGkGaVG52/OF/sahRH+aCZcNtpzP5Z5W0ojhUWawWAZrZidoafvtaxnHwxUeneevHZRtarIwz2MkDa7scnT6/ty5Q9UC2cgp672R45ssrGCXTaiKWGyvX0WhSmTGAdMtftMBdf+4ftMHrPwwlWja+mGyG2zucwtfkjFcGHwt1j0mK7TzymeGKye2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:09:32.1013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62c9e54-e5dd-4fc3-8ee7-08decc60e86a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
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

Add SMU_DCEFCLK case to smu_v14_0_1_get_dpm_freq_by_index and
smu_v14_0_0_get_dpm_freq_by_index using DcfClocks[] with
NumDcfClkLevelsEnabled bounds check. Add matching case in both
get_dpm_level_count functions.

Add SMU_DCEFCLK case in emit_clk_levels to list DCEF DPM levels.
No * marker is emitted since SmuMetrics_t has no DcfclkFrequency
field (same firmware limitation as Phoenix).

Without this, pp_dpm_dcefclk reports N/A on Strix Halo.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index b206a4d0376b..f273b95928c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -735,6 +735,11 @@ static int smu_v14_0_1_get_dpm_freq_by_index(struct smu_context *smu,
 			return -EINVAL;
 		*freq = clk_table->FclkClocks_Freq[dpm_level];
 		break;
+	case SMU_DCEFCLK:
+		if (dpm_level >= clk_table->NumDcfClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DcfClocks[dpm_level];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -779,6 +784,11 @@ static int smu_v14_0_0_get_dpm_freq_by_index(struct smu_context *smu,
 			return -EINVAL;
 		*freq = clk_table->FclkClocks_Freq[dpm_level];
 		break;
+	case SMU_DCEFCLK:
+		if (dpm_level >= clk_table->NumDcfClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DcfClocks[dpm_level];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1142,6 +1152,9 @@ static int smu_v14_0_1_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1171,6 +1184,9 @@ static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1237,6 +1253,18 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
 					      cur_value == value ? "*" : "");
 		}
 		break;
+	case SMU_DCEFCLK:
+		ret = smu_v14_0_common_get_dpm_level_count(smu, clk_type, &count);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < count; i++) {
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			if (ret)
+				return ret;
+			size += sysfs_emit_at(buf, size, "%d: %uMhz\n", i, value);
+		}
+		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
 		ret = smu_v14_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
-- 
2.43.0

