Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EECE98FA1
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 03:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD1F10E70E;
	Thu,  9 Apr 2026 03:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KjOOLwU1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B793B10E70E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 03:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CM/BdCHCokhmTQO0WDz4MSjQqciAZIJGEO42ax6MuwhYQuQesOJHgSixukLdsCdkfTj8urJvxpoFfSyFIr1ERt82mw8+ASoV53O3H4l8bEAtjwcEVFiWQO23AKR0hdidfgGGP3OkJCQT7hwvTGTMBL5h3+1+rrtX5D60vrq4MoJDAJgG72FGxkInCMAQOd7KuJ1t3eUEkR3Y543UU3deJVRdxgsU43eV8mS1ID6zKgsDboqC5QiiKNRnzJJV11diyOZLv1c+NDP/bgH6G+c/0IvmXgVvHcnFZ5Cfyr/UGJ+r3HnpuvsKt2rbXvTh9Fs2q6sdqXXKa6voWNhEAAj7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VEo1vZmMP47mSEJ61sWOIggRRECurffI/bjYe1RwDI=;
 b=h8GB94F8aVdjvk/YyfKTOjtWhycTT8jH+Ep1bifDMV4p1gcIbTbE5C8qNdNRw0ZwVpFV8So8d/+2BUZNQbaGqQIrs4PWDqKuOLCoTHT/yg8HEL2fMP7xzOKp7+4JKa/Aj3ctmqC2GpM5C6anMeAd5uJalzVHSdza3cy/Whb7h0H7U/kTrVCIBy4MZRFtzb8Od0lXRJs8ggrvpip8iq+HobAT1io1Oj8AAnwerN9CzNKbBU+jA4Kko/74adobXUyKamMEWMV2qrYflhGxySGcBdNn8nQFJGEa4hVUN7UgLOEYAA4SeFtefQS7aGIElHtUwV5DM9NbDDbVfeD6KHXxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VEo1vZmMP47mSEJ61sWOIggRRECurffI/bjYe1RwDI=;
 b=KjOOLwU1hxh7/xamThAwtCuZZGZ2Ug/w8R4yYL1N6v5hj+1Dj9KBMpkeq6/scR3K8DkSHpaEMvZ3hcU03yxYzKVLkux8r/BvuSNqvu1XFlUJfC7tHg5dqwwaylgeXTjxYX1+m0tERiWKHVPrEB3L4fj2A3ufZvNbR3J51L8vpA4=
Received: from BY3PR10CA0014.namprd10.prod.outlook.com (2603:10b6:a03:255::19)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 03:10:26 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::ce) by BY3PR10CA0014.outlook.office365.com
 (2603:10b6:a03:255::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 03:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 9 Apr 2026 03:10:25 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 22:10:24 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix typo in OD fan feature mask bit clear on smu
 v14.0.x
Date: Wed, 8 Apr 2026 23:10:12 -0400
Message-ID: <20260409031012.3446559-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 8008e9f8-c52f-4bc5-41a2-08de95e58bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: tfpV8jf76Q5QwE1TJBZRBlp4FY7+T6bdNaqMnL2nK9zJW2rq99kXe54SSG9j0UbuM8Uma/fHIl64OWMw0FE6TrtgusMbBnbv8mhUrfWpWWViBw0QrmjNmTz1iyJwHhgYSj8qWI/seopjLSCyp+lbsVhXici8AO0xjZ4lfpQvuxneYjII0TGWyrlgli/mrauuRBEup0CRYs74zvcGrciGeaGsPBY9fM5DmZqJYr7JOx5BMsSk/ELuWc36PQnyoi7Rbr2qlpxNU7bJXi+Y9VcreSTeP9EROiJQoKtOPKfkSAU7Hzp1He3c5XARi0FIUZ/RrSunPivmCrvPbAxsORYbVKgX+Vt3Nxh+zrtQQExklf8uIBaNixiwz5Lcl9cAL5sf8+WSXdBQGKi5HnP4pr0D2ux2Z+5LEAUZZCD7FzCUvEpp4hMSXSx/ngyVr68USuYWUPwxsqNxFRbcqclhVYl7jORcmZ71fjdA681BQqGWtCz0rIRFhfDzHYUusyGd0+xceKTa5ZN/dTb0yFsU8H/5T9AK7bwr3SXZL7US98Y2yjkKot11T70MH9P/OP+mXBeoRiw59aVciELTcU32JhGUjAb2PY6mIEOUg62qgITMMS/4dp8wqZDcx9ZlBKJaBHntrrg4cK4SHaK4gCmSu3UGExF0948A3qWs3CfcNV4U7SM4PrTxT86j/YiEIeLvYDcWuli5d4/kkho0EvWOkDyDDGA2cTZDe3iZK7n+2QV7HX0sYIyk05rZ9roohaEp2Kthr3CmYQ8CiQz0srWEJzJXjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uF25N/6kH4tgDwXpmycdefQyQ/oeVRwYhUn2XbrSZbuR46KYEqBp7TAVEupSalmafiooBXNOWKacSyw+E4KdVY5ph9YZfiQgy7loJDa8bPVqSYqLnrfqzppSY3swAQSKb5irxara0mR3jWOSqCktKxMGgXulWTVeD3eFJeiX65DzyPHJXB7Vi+IC/JGvCmAR9lSS3OWHHb8NeYTX+YHg60dpbd5gOXZheTl8EmrTfX5/dE+plmrFTq2fEkReG/QbXdeT23z4jNXw80a/Nep+UqYonQBLdaS5i2SYWt7uka2x6LZ+xZWuWzu+gf4ZQ6/xngAI0EGJ8wPO3YXWPyitYdWfV7KBdDjy7CRkwyhDckFaOSMHaD2q+jKus5T4Y2OOxK65jBUAuUj87rtgC7wC7HHzBdvqGNPTw7nQ0wG63bmWlCw58xhTxzfjDauE3Ux9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 03:10:25.5382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8008e9f8-c52f-4bc5-41a2-08de95e58bae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
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

Fix a trivial typo in SMUv14.0.2 OverDrive fan control bit handling.
The code missed the '~' bitwise NOT operator when clearing feature bits,
use &= ~BIT() instead of &= BIT() to correctly clear the corresponding bits.

Fixes: b787d21fab08 ("drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu v14.0.x")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0ccad0b48c09..fa5131a2890b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2434,7 +2434,7 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 		}
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
-		od_table->OverDriveTable.FeatureCtrlMask &= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
 		od_table->OverDriveTable.FanZeroRpmEnable =
@@ -2464,7 +2464,7 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
-		od_table->OverDriveTable.FeatureCtrlMask &= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
@@ -2723,7 +2723,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FanMinimumPwm = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
-		od_table->OverDriveTable.FeatureCtrlMask &= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
-- 
2.47.3

