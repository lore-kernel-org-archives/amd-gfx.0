Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95D4D1356B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 06:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906CA10E5A7;
	Tue, 29 Oct 2024 06:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XjEKUL9e";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E6710E5A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rscbYB//Lb499iuXT6/yapNYKxQ+xUhTaNb+/n01ctjs53M3Qgzr+gXslR9+lvpL8z1bkCIzbH5/xsZczaz6Yc/Nnr6iaq1GE81vmJpuZ6b3AAD7b0jIpne7F6oBqFuoP4YGY4RNvo8H9pimYcqtbm1qDenYReF0ySE4/ijZTSx1zTa3/U4IpsP3uA8ZTw29WjJpN38WxCGX3ygwv4YyP/L8lTLt/o3qgoPHjUgy8DbxOvXvf8mwsXYDFyq34faOpuI3LW8jwjAnty0tx1AHCQfbxcjVoAfKcTwPVKp6HC0+ToA9swneCHB84RzIWQYExmEJUUUgy+yaT0UQJMc7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKt1exwVWix4Eu3iXj12ZctlpfXNuGxbeKRzwrFnm4M=;
 b=E3TArxrwFx+7jFdoInDL6ehm3MMWMe5PtmDwSMhVVNaxOZb8m8uwndYVqpCz64t1km3JmbzBzzdGHalMQAgRjVhZ7bHmoSGulKHCdCLZDMDMczMWH60mLR8B9wx/jRBOySA65HbpGmRcj9PPbg3wWQdk7dTFbZHtI7s6zxMBteX2+OcME9xsfBxz3Bg3wu0ABXrCXDU1av4lvPr/zUneM4p/6fNoyCrEs/ShjxjoMgbw76dkR2iVpoM2be2b6uBO3zKg2UQRRMcsZc8XjFcB2lXUW1FN0lr0R+CpQWPrmLBfULvY0lAzoVJHYLUg6Tqp1HgwnvWQ0O/OHBv/IyKk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKt1exwVWix4Eu3iXj12ZctlpfXNuGxbeKRzwrFnm4M=;
 b=XjEKUL9eQgbs+Tdd+yb3dAF0fB+iUcFbPwtUECzoepP6AEhEZGVLLb1voDV7jcACluuZAgavKhaRd1YG00uWd9FkkKIZ4UWWCRFY4OI70VBGIbqJUq9KmN0AudPVbg0w7sWjoXZerMSjfz3Fha5P4v5YsPPTF3koLbaSdAAwVmA=
Received: from PH0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::18)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 06:42:12 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::80) by PH0P220CA0025.outlook.office365.com
 (2603:10b6:510:d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 06:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 06:42:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 01:42:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 01:42:11 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 29 Oct 2024 01:42:04 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V4 5/5] drm/amdgpu: Add sysfs interface for jpeg reset mask
Date: Tue, 29 Oct 2024 14:41:36 +0800
Message-ID: <20241029064136.3057034-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029064136.3057034-1-jesse.zhang@amd.com>
References: <20241029064136.3057034-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da84c73-faaa-44ce-5db0-08dcf7e4d1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c3m0EBIrIspJpi7Jr+NV+0EVRnpG48RtmcB31lGqIWjwR9KiIA4Ag+20FgoU?=
 =?us-ascii?Q?Yag2XR/MI04T9zKcdehTYhrF0Ww5eZG8VruXIVoQzoH6n3PmMeVVu/SUaw1D?=
 =?us-ascii?Q?/rSH52PqJndq/6RBTm3FMXvj7VLtQYZK8g+yPpgrOGrp6ChY8t3Tot3BTI7n?=
 =?us-ascii?Q?PRgQKLsRNUduRQGlDbniQ9eQa8pSy3Rga2CW4JFJxlzRh7mlEXcz2dbP2/59?=
 =?us-ascii?Q?EYDeMa2aCLQHnLoX+fy1G4t+x/VoMCDnJtoG1+f250y8yS92todqPWJNNUuo?=
 =?us-ascii?Q?FhaMcavoJC1ypHTGqZ+D9dard00LBzZ0n1Y5qlgyCeItIaBQFrDGaSIsrfgI?=
 =?us-ascii?Q?njkf7qHi2fwn1RRhFipWIFS10ByEJDG+A/C6tsHCns/en3AkQEQFvi3ocRcx?=
 =?us-ascii?Q?lfBZBL3C+xTBKP9S1dIo8EkoGegdk5uP9/YPmDYLxDwLFL3K5zVStt230HPU?=
 =?us-ascii?Q?yBK5JcNmR32eOEYIZbM7YdFcUakMqLWorJiIQtloPv/bUa/r3NPhHK6tqTU6?=
 =?us-ascii?Q?+nY+s+pIJMnmQFwHEY61Ie/PJcHmoAPkzuwsC4DzFqyhiGCTiI7RTWAW2vNy?=
 =?us-ascii?Q?68iZ/4w+ypLuKUwAoIlJ94b32s3ENQGHQgeC9KYTVPh7k3Wurkf9O8GKCS+t?=
 =?us-ascii?Q?y/b2obFWWE8R6WQ+lFG9BMn3UEhqJM0X8rLZIloZhVZHUVw1lcNn0ff8YUiU?=
 =?us-ascii?Q?9lCzbNBfPu8cRhIqSUBDnullGBIGwhkGQsRQx4lbbPr35dKrHbKptZfwETVH?=
 =?us-ascii?Q?RpHFgk/Rjh3/8f5WhrkGzGGDrm6KHOWlmn2WDRq+GHxxybv4YyMoB/ubNPgV?=
 =?us-ascii?Q?1c/Pj+3ZAoXhaTNK4Nlg7Bf6kwmMzyVKF6SYo4vM9jzqNGnf1rfCcCUFLl2P?=
 =?us-ascii?Q?7ZxRy31ol5ZmPx65iUbDl6GfoQuM18v3u7uQ1iYGrvshimbJC4T/sFE6Ya9q?=
 =?us-ascii?Q?sd/zpT3UPraPPfUAAzf5Nj7khA1e1wSqATaPF/0ZvuajTuH57/54E+twxZC+?=
 =?us-ascii?Q?v2XwFk8S8r+VibEp+sP7qWmnLaGnXqCSEQQ2GFwTffaWH2JY8EjL6RDzKXs8?=
 =?us-ascii?Q?ctfB1OAFwa3DX0IFmvrGrVlL/YNYuoYB5FV4voEKwr0A7Te8Jzc/gmlrzJ3s?=
 =?us-ascii?Q?bWQos9dhkzijGN7Qshp5lGb890oW/fBySCDpdp7s0HfdmVuKHOPBLXzvsHeU?=
 =?us-ascii?Q?UIoBOlCaeCOp5rMtygS2QkxP8+oEpnMqeZ819b/k8VqnIbCMi+FdJm3eStvF?=
 =?us-ascii?Q?Vec+WahFl2n7C5cRqokeC7+Oj7D4Uk4aN7NuXEsrEtvh+2Tcg93zZ2F1z5ux?=
 =?us-ascii?Q?RXtyeZCrGCfJgFRVZlSd1I3u25FXUYqJVytwFMRRfmF+1yKjevnhQ+D3RjK/?=
 =?us-ascii?Q?zxSqRFkcMZvjFv04U8uzruQldHJSkbCLgwkZY4B3662IHa4vgw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 06:42:12.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da84c73-faaa-44ce-5db0-08dcf7e4d1dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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

Add the sysfs interface for jpeg:
jpeg_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
    and print the strings in the order they are applied (Christian)

    check amdgpu_gpu_recovery  before creating sysfs file itself,
    and initialize supported_reset_types in IP version files (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  7 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  7 +++++
 6 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..f971ffdffce9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -415,3 +415,38 @@ void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_jpeg_sched_mask_fops);
 #endif
 }
+
+static ssize_t amdgpu_get_jpeg_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->jpeg.supported_reset);
+}
+
+static DEVICE_ATTR(jpeg_reset_mask, 0444,
+		   amdgpu_get_jpeg_reset_mask, NULL);
+
+int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->jpeg.num_jpeg_inst) {
+		r = device_create_file(adev->dev, &dev_attr_jpeg_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->jpeg.num_jpeg_inst)
+		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 819dc7a0af99..3eb4a4653fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -128,6 +128,7 @@ struct amdgpu_jpeg {
 	uint16_t inst_mask;
 	uint8_t num_inst_per_aid;
 	bool	indirect_sram;
+	uint32_t supported_reset;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
@@ -150,5 +151,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
 void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
+int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 20e1fe89c463..c675d6619f9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -121,6 +121,12 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
 	r = amdgpu_jpeg_ras_sw_init(adev);
+	if (r)
+		return r;
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
 
@@ -143,6 +149,7 @@ static int jpeg_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 2a53537db135..a785c970a908 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -159,6 +159,13 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -178,6 +185,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index ef2d4237925b..e130bb2345e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -153,6 +153,13 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->jpeg.inst[i].external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, i, regUVD_JPEG_PITCH);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -172,6 +179,7 @@ static int jpeg_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 7954a6fae464..078b4f9bd312 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -100,6 +100,12 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -119,6 +125,7 @@ static int jpeg_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
-- 
2.25.1

