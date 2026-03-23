Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F29D58B00
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 06:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67D910E058;
	Mon, 23 Mar 2026 06:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5apnPsub";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013018.outbound.protection.outlook.com
 [40.107.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DC110E058
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 06:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuujIb+8OfHyolk2m9CNxjeLiLSob5PJr1ONd36IDKrslnBP6bE6WfmoevuKOILLXO8rD3SPaeuP8mOCT4i9mE3QlRdH1ahpIc7JR+zfSCYxzvy1ROx6caWKPWMFmHX2faZZXRtCU/WvM2eGhZIujBRsTlsXIYrP5Iv4Y0zFki1lBM+ZLEvsINQ6pzc425y/XeF3XGIUya79R/t9V7EsxdwiwTNCmYNBANuavyAAIvPeNPQt4l6XLnVdp3aLybdBY4sCkJ3wXFX6VYYGhb2jprpxdiFpKAh7XhKEa1j2VN2luXxYHNkEeIwvJgwo4/fknLhxxhdjVh8LHtchhdgl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA8KL0y04xOKPATYFvlh+hTwUSvFOyrOHjPsCx5eAs0=;
 b=d75Ki4dP635q4xMPuYXuc8E6kNDIa6xyd6owIkJVM5mBv/S0zUYwe5CScr/oGVrDz8KqRwQHBDITtvQB5mkTEuDtnut6dYlMQQSOD3OL84XKUZdcdA+gUxU4kdzhn/y8smyqe0iVmBSLp84U+F0MS6D4jfzNebpPtal+FeIPxcmjVddvbheVapHCFKoMz4SlCYginFXOw0L3BbkokEPgjzDu1C/Si4Jb6z4aVL2jtiHaDsJC3Ij1fBL1tOGcMWt5craFpKEtF9oS+vZf72cfLF+j5P0eCIzgqvOgsPgsIb3Fhe5oHE/Z8rh8CF2XPlCjA+Xj/Y0SnTYstcfNxCcm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA8KL0y04xOKPATYFvlh+hTwUSvFOyrOHjPsCx5eAs0=;
 b=5apnPsubA0AYXXpCoWSN66xN8TS454hBy/ICZ8S2yy1DSXPRv2BYVNuPcVLBCtGaUf4/eYsAFCUwFo4IfnjNkxHXejoPOxuHmsY1rvRd3gn3EeXdZhS1HvA/fVpXS8WBjmmV8tec8XZa7ThgTkW2zXwHo1t74ygLwnZpt/UZcGY=
Received: from PH8PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:2cf::18)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:07:09 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::f9) by PH8PR07CA0038.outlook.office365.com
 (2603:10b6:510:2cf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 06:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 06:07:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 01:07:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 01:07:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 01:07:02 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu/vcn4.0.3: gate per-queue reset by PSP SOS
 program version
Date: Mon, 23 Mar 2026 14:06:43 +0800
Message-ID: <20260323060701.437428-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c91577-eada-47dd-309b-08de88a26aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: DCC3/gnvZgH+mc1OiDN+l5pDHUbD530V63NFqugffM1OO7JhaaCOUjssmgUI4fbmRyYHZzrvNN6YzOZR+8030R9gvkz8uzFx89W1BFPwG8WuJu65Wku0ZtVe83pIjt3s7wO9WW+uvq9OMFEe0HcrKd/Hquqsb6wFqQyUIcUyKDdUaCM/Pmo8ovZKStihua2faCTHElckQ3mHNhDCbsFHfIciS/WvjJ2RQdjGrnxdmLPnFgUKRXC2eaunb9KkAnoZv9ZMNRpz9KvkKvsqpeNFwTTEJtLc6K1A0Y5HEoCGWeKKAnzK6FO3qaSlNXZpsPrUiHXCAmJqkHK723t26GET17FPXUc/qQsuIBgF8PvqgbkLZV99wH7tkxoHPjxET0+vZ6bRA/XZtIXirTN47JMVOJamuB2jMXI6Ryj76/nd4fwxkvI9q/HGvqC9Zzig29i1YBXUQO97uCAsv8DT8VYo17prgznWzJCbgIfrx4ta/FItNEWh+K+AukqZJdZZ1wgCX5OIvnHQsybqy/NqfZdHLQrmraEAxE8qPkT5Zo4+C/uAukhq5hnrURA+eJ5aQtTIlj6EP7hMzDaNE8PcnHuf9DeNicGPpfZgE15bCFmIMvvuK0w8/rv4WdmEz6Hpz4UDXM2qzQ11Lzdb7VJ4q1DNV9vJ0OZCYS6yG5svn4dyU4P1lgiSCujS0EbfXuWix7IX0ULurZ2Yv7sBsIe5oQuNfNGJSLEpZD619Mtu30LEz9CiSyDia43A1+hQ31hzdwSbqmG1IG9rwdy3kesoFPYXNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B2X809+OwvUrTyMp2lFU5NAvlOtlDyKL2zCnA678uIQoRaHsm6ceb3R3G75fm2KHfUCE+g8U4ikiK++GMZKb3oSXEV+2/Ob+OGzCgfrqjYtUexbwTaAaK4RQUoUVA/MnZqO87KFbMr5bWEAno+6GLhA009qd+8WsGv6xnpk59G+QoU5YIXfHlHSamjpJcSS8cQzPx++M1eYvtrkum/cVayWZZsq90l/1SUYLNTYCPdjp6dO7wjmHEWWyO+3YRy+mAzXVagcumwNb6jS6mrQ9bo+aOtfuaMkUGvsr6lRK6uvpeCdc3tRnm0es5NHyXwzvB+cdVdXNylU2vCa9BJXByc6oREEn3IsWEFzYx+CILQ1m/s5MfGgX/LX5XVdDCOlApHP/vch2OkmrXIuU7gRLotIHmxMA4hvH4DVQmV24YP45rd+TysoFYjPkP8ogeRpt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:07:09.2866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c91577-eada-47dd-309b-08de88a26aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
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

Add a PSP SOS firmware compatibility check before enabling VCN per-queue
reset on vcn_v4_0_3.

Per review, program check is sufficient: when PSP SOS program is 0x01,
require fw version >= 0x0036015f; otherwise allow per-queue reset.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e78526a4e521..ff3013b97abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -134,6 +134,21 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static bool vcn_v4_0_3_is_psp_fw_reset_supported(struct amdgpu_device *adev)
+{
+	uint32_t fw_ver = adev->psp.sos.fw_version;
+	uint32_t pgm = (fw_ver >> 8) & 0xFF;
+
+	/*
+	 * FWDEV-159155: PSP SOS FW must be >= 0x0036015f for program 0x01
+	 * before enabling VCN per-queue reset.
+	 */
+	if (pgm == 1)
+		return fw_ver >= 0x0036015f;
+
+	return true;
+}
+
 static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -141,7 +156,9 @@ static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
-	if (amdgpu_dpm_reset_vcn_is_supported(adev) && !amdgpu_sriov_vf(adev))
+	if (amdgpu_dpm_reset_vcn_is_supported(adev) &&
+	    vcn_v4_0_3_is_psp_fw_reset_supported(adev) &&
+	    !amdgpu_sriov_vf(adev))
 		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	return 0;
-- 
2.49.0

