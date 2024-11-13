Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDCD637CE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C54D10E720;
	Wed, 13 Nov 2024 21:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="axVKE0Qu";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7712D10E6F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3myi45SQaM1R5lHUhh1Kp2qgBzYOgsqiX+/x1tzLpygB6+U4Ba4LzJMsV16Hbr5Mrim76T7XcIORyvlYCeKd8yUmKUen2qi5HCIN3aCbMKgvUeOvWM64o86Artv5cfX9UtURWJd2hsJcIsMNpHC2kClPdSv9DvU5XuHMBziCctuTS9+x+fSK7jO6tbW7SN6B1vM1IcvhN4LmKScGxCb/24mUxMLtXtCnF/nPgiIsq/uYkkLGkDvNAOZgxjAnwwhjd1TsGEYXpoh64YDsc9E8F1MXhasEyx/wimAARBRsKA8TMsxJHQdVbhPGba+yyrpx+NZMoOW0YB7zjv/u8Qpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9neoWfAyEhxi8t0BasDbJzLRnwKHOM3XwB+W/minRs0=;
 b=OjbrS2YpKRfcdDUr4zpfp6J9BPxkyENZmzNBQWlquBzyJWFYef/2jDYvuwMVTXl0rg4N18eQ1HSWyBhHJwdAUKtuwsX1VornJ/eF9zt8fh8m/Cm+Ylq9ZFE69kK5eW27B597gQnvDMw3s6yg2o4Ksjd8Z+jSQCYOUSUMQfenkbQPFQT219xjDrY8HDwl7GZhYPNnohYbTCB6B/0nQMRtn1oLdCEbDVK5l1uSZMDRacpA81+vMnQ9lTpUj4zo6pVhRkISlBebU1t/VbpeiEtLuAFpBt+pQuRgY+J2cTf05e79ghYwTikG4gH8sfF8PvFeb6WCucmg7R1FK72UkuBkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9neoWfAyEhxi8t0BasDbJzLRnwKHOM3XwB+W/minRs0=;
 b=axVKE0QuTDJ/qlOxLZzJ/rJdQ2qZERe8pHre1DsbhAAbGzQ8voHQ1OdbUlTYAmP5xtSIUccQy8pOVcY9DPjGSdhP41EPNesnxiJEOP4hakSooP7I3y1nXa+XStWmT/d5Z5KEeQcZ50EYGnCO02Lw0jgbo2mlzXPOB3QvOqxjRz4=
Received: from BYAPR11CA0085.namprd11.prod.outlook.com (2603:10b6:a03:f4::26)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 21:45:15 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::49) by BYAPR11CA0085.outlook.office365.com
 (2603:10b6:a03:f4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/15] drm/amdgpu/vcn2.5: split code along instances
Date: Wed, 13 Nov 2024 16:44:41 -0500
Message-ID: <20241113214453.17081-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 162a8d18-ef1a-4804-a9b5-08dd042c7503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uv2OwWQKtxoayodRV3omOBOFKKkkQTew8ywfHQAMMX+1/LzPXx8upvoJ+4mr?=
 =?us-ascii?Q?zpl8E9fd1tSiWDrBkZO1eCgOFFtxaARSoMoClagDzO9Kn0XmPSYDSpK/8HXm?=
 =?us-ascii?Q?Onn94rqXquoF/7rujbFcjL6XH+8s79c8dRtw9BaqyeC5WSWDfw1uX6l55b9T?=
 =?us-ascii?Q?PkK8xd+Qd2snuqO3frtZw0XDk9nPpSKpKgraBz4ZvxoSfSAq6yvPczrnOLLG?=
 =?us-ascii?Q?VrZ/AHUt4x1A08KO8Dv5zjbRPbldTgni2C7AjKGakM2ROY0OIl8VHg5SEelQ?=
 =?us-ascii?Q?Kn/8h5KAGppdepltLJ8hTyXWJHySRweH8xWR8/5wkGP603g3FGlIS1b2SvYO?=
 =?us-ascii?Q?VV0DO7XfmsxGjScfEPLYJSO9Qgw919694OwcSDUUngBYDuVfK39rjqTOJm+U?=
 =?us-ascii?Q?Mglwz1BWquWtFVsDD57MHV6GcAkW+kJcq6sdPqTP3B+TJf6tyDwIWyfbTnaU?=
 =?us-ascii?Q?s6u92XGDCl5+gHYPZVp2TAwFtYx6gO4d1d9Q3XB3CkUmcpfGCxgV5XMDDXI9?=
 =?us-ascii?Q?DJS8i0Un9tTc/wdhwQI53ZUvEq+XTS8hnATQS2hKV2ekutDHBx4Kfb4EjYSy?=
 =?us-ascii?Q?pPFqlNKjhzrYiBtmQ4WORq9eLunyac7Qq7VLGYV5SJrNzpWzDze+LpA4HEiH?=
 =?us-ascii?Q?Q468g6SCQeFfXiHq1CJhKgKMf+Y0Y3/SYZSK0VkThctRXBub8oc8cCrUUelA?=
 =?us-ascii?Q?IO1xHraAUCsjdI4CemO4Ce2ldxNRgThYn1s1j8GKTiaGumjZvNkWcrW0TYzx?=
 =?us-ascii?Q?xoeWkjxAi7tx/Z/rXziFjl8SVylKiflj13Zartx/7vJjQdoEzU8nw96tc2ZB?=
 =?us-ascii?Q?XBLN836qbrKEyZRrzthWLfYVq3rkEaywO9gGrvIjg+cjWvLHu4b5glketxJ4?=
 =?us-ascii?Q?0WXoZLH7CTHuL62QEf6LcxClq/HTg7gtA+8ztfrsF0DzJBNidUY5X9MV+U94?=
 =?us-ascii?Q?xc0Aj1Two1ra4sm++g3nUdOzqKzCfALsC0nf7x2zFtURReSp2lXbTtYJ3k1m?=
 =?us-ascii?Q?D9FhzvxHxUObB1bGEiuqbMbns+/rrFum5jumTguAWkyin/XezV+LUZJ44+Xp?=
 =?us-ascii?Q?PcjZDznnfUQPCwoFqh5+VPNhJRNWT7H8RmUvq7wbq+6DyIFv6TJh7q8KJW31?=
 =?us-ascii?Q?JAwrZW1JBaqaQstNIdgxeI8+Ymv+ZWcJSW3vrRmw1IJZijZoMlP7S3Dseooi?=
 =?us-ascii?Q?583cdu9mQoNlaLOSChGNSP23DIDN6EimyoQveAdSTzNNVu9Jub1WlBmpMtvz?=
 =?us-ascii?Q?RGNQhFBCXPY0QYsBBiThQnP/ziP8A9t68xiR1Q3tYVduI0+4cs+bqrh9EtDK?=
 =?us-ascii?Q?mYDT/8atQVl50YIg4MqXo2fMaJBFdXyYn4C3Vhq07bBC/uBpoTVeGBkNrt5g?=
 =?us-ascii?Q?m8v9CFWKDOk8drjI0t3MWKdWQhGCIEoc76RGbYq/0pT46WPMIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:14.2224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162a8d18-ef1a-4804-a9b5-08dd042c7503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822
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

Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 841 +++++++++++++-------------
 1 file changed, 411 insertions(+), 430 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b518202955ca..b9be304aa294 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -452,64 +452,62 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
  * vcn_v2_5_mc_resume - memory controller programming
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to resume
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
+static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
 {
 	uint32_t size;
 	uint32_t offset;
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
-		/* cache window 0: fw */
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
-				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
-				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
-			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
-			offset = 0;
-		} else {
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
-				lower_32_bits(adev->vcn.inst[i].gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
-				upper_32_bits(adev->vcn.inst[i].gpu_addr));
-			offset = size;
-			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
-				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
-		}
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
+	if (adev->vcn.harvest_config & (1 << i))
+		return;
 
-		/* cache window 1: stack */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
-			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
-			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
-
-		/* cache window 2: context */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
-			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
-			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
-
-		/* non-cache window */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-			upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
-			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
+	size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
+		offset = 0;
+	} else {
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			     lower_32_bits(adev->vcn.inst[i].gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			     upper_32_bits(adev->vcn.inst[i].gpu_addr));
+		offset = size;
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
+			     AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
 	}
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
+
+	/* cache window 1: stack */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
+		     lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
+		     upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
+
+	/* cache window 2: context */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
+		     lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
+		     upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+
+	/* non-cache window */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		     lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		     upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
+		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
 static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
@@ -612,117 +610,115 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to disable clockgating on
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
 {
 	uint32_t data;
-	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* UVD disable CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
-		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
-		data &= ~(UVD_CGC_GATE__SYS_MASK
-			| UVD_CGC_GATE__UDEC_MASK
-			| UVD_CGC_GATE__MPEG2_MASK
-			| UVD_CGC_GATE__REGS_MASK
-			| UVD_CGC_GATE__RBC_MASK
-			| UVD_CGC_GATE__LMI_MC_MASK
-			| UVD_CGC_GATE__LMI_UMC_MASK
-			| UVD_CGC_GATE__IDCT_MASK
-			| UVD_CGC_GATE__MPRD_MASK
-			| UVD_CGC_GATE__MPC_MASK
-			| UVD_CGC_GATE__LBSI_MASK
-			| UVD_CGC_GATE__LRBBM_MASK
-			| UVD_CGC_GATE__UDEC_RE_MASK
-			| UVD_CGC_GATE__UDEC_CM_MASK
-			| UVD_CGC_GATE__UDEC_IT_MASK
-			| UVD_CGC_GATE__UDEC_DB_MASK
-			| UVD_CGC_GATE__UDEC_MP_MASK
-			| UVD_CGC_GATE__WCB_MASK
-			| UVD_CGC_GATE__VCPU_MASK
-			| UVD_CGC_GATE__MMSCH_MASK);
-
-		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
-
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK
-			| UVD_CGC_CTRL__MMSCH_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		/* turn on */
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
-		data |= (UVD_SUVD_CGC_GATE__SRE_MASK
-			| UVD_SUVD_CGC_GATE__SIT_MASK
-			| UVD_SUVD_CGC_GATE__SMP_MASK
-			| UVD_SUVD_CGC_GATE__SCM_MASK
-			| UVD_SUVD_CGC_GATE__SDB_MASK
-			| UVD_SUVD_CGC_GATE__SRE_H264_MASK
-			| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_H264_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCM_H264_MASK
-			| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_H264_MASK
-			| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCLR_MASK
-			| UVD_SUVD_CGC_GATE__UVD_SC_MASK
-			| UVD_SUVD_CGC_GATE__ENT_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
-			| UVD_SUVD_CGC_GATE__SITE_MASK
-			| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
-			| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+	if (adev->vcn.harvest_config & (1 << i))
+		return;
+	/* UVD disable CGC */
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
+	data &= ~(UVD_CGC_GATE__SYS_MASK
+		  | UVD_CGC_GATE__UDEC_MASK
+		  | UVD_CGC_GATE__MPEG2_MASK
+		  | UVD_CGC_GATE__REGS_MASK
+		  | UVD_CGC_GATE__RBC_MASK
+		  | UVD_CGC_GATE__LMI_MC_MASK
+		  | UVD_CGC_GATE__LMI_UMC_MASK
+		  | UVD_CGC_GATE__IDCT_MASK
+		  | UVD_CGC_GATE__MPRD_MASK
+		  | UVD_CGC_GATE__MPC_MASK
+		  | UVD_CGC_GATE__LBSI_MASK
+		  | UVD_CGC_GATE__LRBBM_MASK
+		  | UVD_CGC_GATE__UDEC_RE_MASK
+		  | UVD_CGC_GATE__UDEC_CM_MASK
+		  | UVD_CGC_GATE__UDEC_IT_MASK
+		  | UVD_CGC_GATE__UDEC_DB_MASK
+		  | UVD_CGC_GATE__UDEC_MP_MASK
+		  | UVD_CGC_GATE__WCB_MASK
+		  | UVD_CGC_GATE__VCPU_MASK
+		  | UVD_CGC_GATE__MMSCH_MASK);
+
+	WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
+
+	SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		  | UVD_CGC_CTRL__SYS_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_MODE_MASK
+		  | UVD_CGC_CTRL__MPEG2_MODE_MASK
+		  | UVD_CGC_CTRL__REGS_MODE_MASK
+		  | UVD_CGC_CTRL__RBC_MODE_MASK
+		  | UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		  | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		  | UVD_CGC_CTRL__IDCT_MODE_MASK
+		  | UVD_CGC_CTRL__MPRD_MODE_MASK
+		  | UVD_CGC_CTRL__MPC_MODE_MASK
+		  | UVD_CGC_CTRL__LBSI_MODE_MASK
+		  | UVD_CGC_CTRL__LRBBM_MODE_MASK
+		  | UVD_CGC_CTRL__WCB_MODE_MASK
+		  | UVD_CGC_CTRL__VCPU_MODE_MASK
+		  | UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	/* turn on */
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
+	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_MASK
+		 | UVD_SUVD_CGC_GATE__SMP_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SCLR_MASK
+		 | UVD_SUVD_CGC_GATE__UVD_SC_MASK
+		 | UVD_SUVD_CGC_GATE__ENT_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
+		 | UVD_SUVD_CGC_GATE__SITE_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
+	data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
 			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+		  | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
@@ -774,65 +770,63 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 }
 
 /**
- * vcn_v2_5_enable_clock_gating - enable VCN clock gating
+ * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to enable clockgating on
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
 {
 	uint32_t data = 0;
-	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* enable UVD CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+	if (adev->vcn.harvest_config & (1 << i))
+		return;
+	/* enable UVD CGC */
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		 | UVD_CGC_CTRL__SYS_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_MODE_MASK
+		 | UVD_CGC_CTRL__MPEG2_MODE_MASK
+		 | UVD_CGC_CTRL__REGS_MODE_MASK
+		 | UVD_CGC_CTRL__RBC_MODE_MASK
+		 | UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		 | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		 | UVD_CGC_CTRL__IDCT_MODE_MASK
+		 | UVD_CGC_CTRL__MPRD_MODE_MASK
+		 | UVD_CGC_CTRL__MPC_MODE_MASK
+		 | UVD_CGC_CTRL__LBSI_MODE_MASK
+		 | UVD_CGC_CTRL__LRBBM_MODE_MASK
+		 | UVD_CGC_CTRL__WCB_MODE_MASK
+		 | UVD_CGC_CTRL__VCPU_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
+	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
@@ -1006,197 +1000,185 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v2_5_start(struct amdgpu_device *adev)
+static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 {
+	volatile struct amdgpu_fw_shared *fw_shared =
+		adev->vcn.inst[i].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev->vcn.harvest_config & (1 << i))
+		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-		/* disable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 
-		/* set uvd status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
-	}
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
+		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* set uvd status busy */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return 0;
 
-	/*SW clock gating */
-	vcn_v2_5_disable_clock_gating(adev);
+	/* SW clock gating */
+	vcn_v2_5_disable_clock_gating(adev, i);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		tmp &= ~0xff;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
-			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
-			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
-			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-	}
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-	vcn_v2_5_mc_resume(adev);
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
+	tmp &= ~0xff;
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
+		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
+		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
+		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v2_5_mc_resume(adev, i);
 
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
 
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (k = 0; k < 10; ++k) {
-			uint32_t status;
-
-			for (j = 0; j < 100; ++j) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status & 2)
-					break;
-				if (amdgpu_emu_mode == 1)
-					msleep(500);
-				else
-					mdelay(10);
-			}
-			r = 0;
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (k = 0; k < 10; ++k) {
+		uint32_t status;
+
+		for (j = 0; j < 100; ++j) {
+			status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
 			if (status & 2)
 				break;
+			if (amdgpu_emu_mode == 1)
+				msleep(500);
+			else
+				mdelay(10);
+		}
+		r = 0;
+		if (status & 2)
+			break;
 
-			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+			 UVD_VCPU_CNTL__BLK_RST_MASK,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-			mdelay(10);
-			r = -1;
-		}
+		mdelay(10);
+		r = -1;
+	}
 
-		if (r) {
-			DRM_ERROR("VCN decode not responding, giving up!!!\n");
-			return r;
-		}
+	if (r) {
+		DRM_ERROR("VCN decode not responding, giving up!!!\n");
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		ring = &adev->vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring->ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	ring = &adev->vcn.inst[i].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
-		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
+	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		     lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		     upper_32_bits(ring->gpu_addr));
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
 
-		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-				lower_32_bits(ring->wptr));
-		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
+	ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
+		     lower_32_bits(ring->wptr));
+	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
 
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
-
-		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &adev->vcn.inst[i].ring_enc[1];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
-	}
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &adev->vcn.inst[i].ring_enc[0];
+	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
+
+	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &adev->vcn.inst[i].ring_enc[1];
+	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 	return 0;
 }
@@ -1425,72 +1407,66 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v2_5_stop(struct amdgpu_device *adev)
+static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << i))
+		return 0;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v2_5_stop_dpg_mode(adev, i);
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
+	/* block LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
 
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
-		vcn_v2_5_enable_clock_gating(adev);
+	vcn_v2_5_enable_clock_gating(adev, i);
 
-		/* enable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
-			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-	}
+	/* enable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
+		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
+		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -1811,16 +1787,19 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
+	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (enable) {
-		if (!vcn_v2_5_is_idle(adev))
-			return -EBUSY;
-		vcn_v2_5_enable_clock_gating(adev);
-	} else {
-		vcn_v2_5_disable_clock_gating(adev);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (enable) {
+			if (!vcn_v2_5_is_idle(adev))
+				return -EBUSY;
+			vcn_v2_5_enable_clock_gating(adev, i);
+		} else {
+			vcn_v2_5_disable_clock_gating(adev, i);
+		}
 	}
 
 	return 0;
@@ -1830,20 +1809,22 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret;
+	int ret = 0, i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(adev);
-	else
-		ret = vcn_v2_5_start(adev);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v2_5_stop(adev, i);
+		else
+			ret |= vcn_v2_5_start(adev, i);
+	}
 
-	if(!ret)
+	if (!ret)
 		adev->vcn.cur_state = state;
 
 	return ret;
-- 
2.47.0

