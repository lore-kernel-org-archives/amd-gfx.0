Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C522E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 09:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CB710E563;
	Mon, 16 Dec 2024 09:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QT1uHwOD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E94D10E563
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 09:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boPxrZQ3hoMLnRK6wsGog3SS2/qpSBAJQXA9GCQduqfYomsu5bdi566ZsLWMxQb8saU/kI0LWHGtJhRL9P82QuP8UU7/DEHhOQy1l4iyzQ/7oTXTENGEBd5WsNlcu6Z8H8ObAQ7BM8McsnZBLoChUspvYZgemP5WUubAPGeOLMrXHOsHCOCVIvGeY/BnXhSIIZjhw3sFFYPl5eYkyQUe6I7Tsx0gJskDBSDL4PQGBx/6StfQSaYZ5Qjerq0tGGFEfQBCO4HRxzKeX4phRf9xmjhg61TAXfcho+Z1VDF3lGjFeSZfIdtm//SsTUAFrVcbyJil7Zd6ynD7tI5/dwYJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdbbbDvvipiMjDjaDxzim0Olt2JOGXbYYXWKDcP+C/s=;
 b=VDgl4uQwyGnK8KJrIsIrSOGmngUHV+zJN9IxvwppWDsRUd3SGyhTaxUgZdYOh4d1LINZDq7leWkc+TqO8pXPW8hkgRxo2fA/VpEq/CxyZ0LuE35CX1uPd9PyiINZ9VvvoX5z4JgGMa4Ji6xDv0bNPu2V8DLFjp7Hgf9yRB9aXaqryewA2touHAxB86PLqSdgvI4OgqPM/SKHSAtoE4YQKkUTDHl3vo+/oONtgGUtI72ofxQmNkSzbG+G1e6qhpjUwIXQ0tNCyPe0Qoh5n85dEbp3gwGP+Sc0dxDLZLhRruaNdpaouUyg5oktApoq4J2ijLg0Pd97UnAO8fOW9yTFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdbbbDvvipiMjDjaDxzim0Olt2JOGXbYYXWKDcP+C/s=;
 b=QT1uHwODysIY7TkT2H7+Yhp2opmasY7ZdR6uLQHgBw2MBmv5bVmziDXFK7UcnSHER/g+gYH91sBvLJgcKxq6L2UKYnzqQQ7Uv8TiGbYbnuJtzc7t19i8LsL2zUinivYvZu+YdS7dOJJc9/oXE9TWyAAGoNBZIOMPu6UUzi6Xa+4=
Received: from BN9PR03CA0270.namprd03.prod.outlook.com (2603:10b6:408:ff::35)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:29:52 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::d9) by BN9PR03CA0270.outlook.office365.com
 (2603:10b6:408:ff::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 09:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:29:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:29:51 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 16 Dec 2024 03:29:44 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue reset for different
 asic
Date: Mon, 16 Dec 2024 17:29:29 +0800
Message-ID: <20241216092929.105280-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216092929.105280-1-jesse.zhang@amd.com>
References: <20241216092929.105280-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d3d4c8-2e9e-4a1a-85ad-08dd1db4319f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kRVPv4q4oFRKimJO27M4FN73PxPHoN3CDtlw+gIYcO5Mo1b1EbIeLmxbr+MY?=
 =?us-ascii?Q?TI3/HlGRkLCreqM/PiSrvLM+FyRoxP3NahYunFiMSGOQ65mmDFc/gGWPUsUj?=
 =?us-ascii?Q?WebutmXcQR72mfX3QE8tfx4+g165oxxHuchBa30R1oBL0DoIzNEkbwgcl37J?=
 =?us-ascii?Q?TdN44f75ViMNr2SMFYUavdd0uDCsYiF6SLfMIs927IWUei+uReqzO307bPzv?=
 =?us-ascii?Q?S8d1Cuz4mVCJbGOEHnmaPI0uMqdGwqiKdzjitOGEEVT85Dp+2WLyeXWQNS1z?=
 =?us-ascii?Q?rHroTzhq3SBJHIWqz1sdE0Un2Vla4p2EmzF0UvqPR2PXHQfZhGV74FZevcMW?=
 =?us-ascii?Q?HYld+LojquCLNIigWvG2W3l/DnX71vObwBEg6bfnm+JTo0hXO7JcYb6enqEc?=
 =?us-ascii?Q?AcoOaYrv8RZgOny7iw+gYPXasQb26ts0SeAFp050iAVOXLeKPVt1SDO4Bez7?=
 =?us-ascii?Q?zvfRLU/tQKNeEfaAdUzoCJgSh+sp1e/xzU9s16pJzjsUxLJJN/CdkQLH8Axm?=
 =?us-ascii?Q?74YTraT5NMHKW6Kt2ZdFK4J/QZ6vRMe/EgJ4e9l9MunKydiQWxx0TXSYdQj7?=
 =?us-ascii?Q?YM1F7PqVrfyR19VF1BNN45yHsoGh1pTxJF6A5QrAhmJuOeJFAn8lwuprcUaH?=
 =?us-ascii?Q?39n6VrqH9woXPz4yTjrE/DPTFI4KM3XEnKYqlgBSm1OMkiP/wdsdlTjygZ5T?=
 =?us-ascii?Q?tvxKmLyr+ud0xkZGSkLzYLDwCFMLFdzlktoQVPxsAM57M8+c12CDSBs/s5i0?=
 =?us-ascii?Q?t9x1rgsMhJU5ILINRJ6KjcgiH5I4PjT8ol9QHimNldm7iMFVUK7sBTdwaop5?=
 =?us-ascii?Q?zmYRpF8am9hzG8bo5igV7IfTG2TJyjGpscwsOXh6ze9VXDirOslqvS2MaX51?=
 =?us-ascii?Q?18fGev6y07RR+TvvF8wMzoi9FALBZ1q6kx4lC6MQUtTnH9iMteBFkQC3+0Ge?=
 =?us-ascii?Q?s2ICuocjf8YeRTAir0x31TUSHcyQSu3UniPAaNQyGPLNDpYE3UBIUwSwqxz/?=
 =?us-ascii?Q?h4RH6J3VRldt7oEp85tTiX1bIFO3CCPiZQp7ghrak0QPK8qZdreC6WjmFKQf?=
 =?us-ascii?Q?pzf1pIA9v7rlerWP9I81QFN4/SoNcr0oCLXinRnRpn3eLQG3cwSDzm3kXshl?=
 =?us-ascii?Q?1VAF3/ZRmntU9cK0P8srUKz+O19mDWfoOauc9zHSqk//chEDB8+ZZ5MMD2A1?=
 =?us-ascii?Q?zohmzTMCHzM6h6ajmqsuPpP+ThQ6U4YEGEVqJvP/w1OI51yEIKI4Wp/48RIT?=
 =?us-ascii?Q?Uo1ellTLSN4aO69TAVNNX42iI9Hp4RxhczyH5McUGw1hVJMiLi8jaBRU/2nR?=
 =?us-ascii?Q?qjLTveUh9c0HHUyKh7hCPdzpIy+sZ6twpp4Hvx+NaS++15GBgfF853hR7AFJ?=
 =?us-ascii?Q?G4LnX2Nvyxvndp72rUtUIcVwqUBtbEJvXTaD2UtBNz3duprDM68+plCccHeN?=
 =?us-ascii?Q?O0tLh8YNYGsJTuOallrOQtN0iOysvDzew6S+9nshUdfTFZCh+k32zDMTA8nU?=
 =?us-ascii?Q?Cx5mR0lggl1e+Lw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:29:51.9554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d3d4c8-2e9e-4a1a-85ad-08dd1db4319f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

Implement sdma queue reset by SMU_MSG_ResetSDMA2

Suggested-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9222e7a777a6..446959145058 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2721,17 +2721,31 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 
 static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
-	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_program;
 	int ret = 0;
 
-	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
-	if ((adev->flags & AMD_IS_APU) ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
-	    smu->smc_fw_version < 0x00557900)
-		return 0;
+	smu_program = (smu->smc_fw_version >> 24) & 0xff;
+	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+		if (((smu_program == 7) && (smu->smc_fw_version > 0x07550763)) ||
+			((smu_program == 0) && (smu->smc_fw_version > 0x00557700)))
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+				SMU_MSG_ResetSDMA, inst_mask, NULL);
+		else if ((smu_program == 4) &&
+			(smu->smc_fw_version > 0x4556e6c))
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
+		break;
+	case IP_VERSION(13, 0, 14):
+		if ((smu_program == 5) &&
+			(smu->smc_fw_version > 0x05550f00))
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
+		break;
+	default:
+		break;
+	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_ResetSDMA, inst_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"failed to send ResetSDMA event with mask 0x%x\n",
-- 
2.25.1

