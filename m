Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAFAC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 21:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8E210E3E8;
	Tue, 30 Apr 2024 21:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tuSi8jw/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DFB10E227
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 21:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw1lyTKjmEa7zpWMidBbQRB3FRHuOIJosDVGYt+EuY/qMTLesJ7IHQxlnrX/SZlljYcx8qng7JBi3V/Z3gO0GbxuBZkek7aXGRWAYeavO85nadr6A4ZV6LPmmvFhdJ0eQuNJFB8gU5G8J0UEgGX/EBtlAFT04a9rfW6llQy1J17Umj5lLbuoapxA1pvABhN7gI+Orpzy82NBK+d3ewSIEix8L0kR2KefctK7U+44rCuPzq4oH7mOA1LOWigAY/VGOrROpad4NrkG1yaYwZyrvUpSPUrzcg+S2NVD0X0iIaEIruNWcccwPvlp9p5BTwMZI2cuvfj6GX694mP3Hsf6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LGoOnjaKn2qNr2+GiXrtADy1Mqqx4qt5mj6dBQSb38=;
 b=Uj5vynEq9mc6nMNAEj4ImgxgIFceRtWsLjAzRUFsLaBEeqNeUFIuZuPmmSN0e20WtUu1XfHt60j1m2TWaertyfYbbzK1d26UtMCVsKgolS2DAFx1NgsbMMVDLhMEPyIar0Y2ZikLTfQKm+kcHwfXsbNzEtJ+ivR5IXuiPYi++V4Zmthh0l69v2C9KbrvZ7zzzYaDYBrWNh7kJHj48/Dur3vcwk5QQ1zsN219+m/oZeZUSJFqxDUS0Bm0iY81OVwS1QUqft/cUrqH7cIuObtnFrQVFphPbu3Nunul/LOfa0hjKIc9RzsEOUf2aOlB7L8m2hTgO/4szshFN1hUJszCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LGoOnjaKn2qNr2+GiXrtADy1Mqqx4qt5mj6dBQSb38=;
 b=tuSi8jw/fAWmj46KI8ABSMOVAAvLORq6kpIZtIbwDhjyWQ/VHzkFO3WRTypSlWasF6wOZiNOpt+ebjV/Jon0I7YgpH3Fgha5Wpf+CjIyu4ZskU0yL0xbBceiTdJxulwXxkd+N7gNK8ND3rQK142IMKN5xP0JdcBV4j/i4H76aWY=
Received: from BYAPR06CA0027.namprd06.prod.outlook.com (2603:10b6:a03:d4::40)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 21:12:44 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::51) by BYAPR06CA0027.outlook.office365.com
 (2603:10b6:a03:d4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 21:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 21:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 16:12:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add sdma v4_4_5 ip block
Date: Tue, 30 Apr 2024 17:12:09 -0400
Message-ID: <20240430211212.814162-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e89b72-b111-4096-95b2-08dc695a4731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oCfjvoEZRmzlvfDElzDOGKu3qFX6dcfqSZef9Xj/ZOepLi2lr95h0QKMU9J3?=
 =?us-ascii?Q?IgxkcA6YIAZeD4m9FCYTApmPhF2KYKFSMp5u4JO7eVKahsXqOcZS2w81wytD?=
 =?us-ascii?Q?hm5EJLgS0oo927SScGHs0/cEg/e7yvjvyqzZQtjbq1iFxVAAi3D9eFk0GknQ?=
 =?us-ascii?Q?teEftOCXY8wzUHz+ZN2vLiC/2tlDGohClQmnFXWg4R3XZEsWK2hAtIfFkJJz?=
 =?us-ascii?Q?kG6OMbW44LzRfHaP68YMp+zsy+fw0gYrROIPS0ouX7H+7wrpRl7kNVfHRozQ?=
 =?us-ascii?Q?LuX0eH+gl/E2gTnsIaRO590QR0IXXnosx/9dYyOiv9Bxvj5iEcibaF7Mro9e?=
 =?us-ascii?Q?Iuxq8K0dFnJ4F78+aCPhb14clUpi+3hNcSmFFNPYaNGXhquYZWg7+bxhkwlS?=
 =?us-ascii?Q?ePLZX9VuYMxCsg80pFDtDCZx5OOETLreFoTXYh7iL7JgqubPBaqXlA85mQH2?=
 =?us-ascii?Q?SS8X57Z1ddncVoeEe6B8v2NqeTfC1jZScvxTSP180FIo/yhIu8w2Xkc72Osz?=
 =?us-ascii?Q?1dUUkMDLQOVPSBzS7xT8FG3lj9vy0cZ88YrG7/fpoqM5RmIKcozTECH2tBSB?=
 =?us-ascii?Q?GjAUNfjuGjbpHnKahcCi9npNk3MmFF7MIyF3cAYcdoFG+mdpQ1PjjziKdNF7?=
 =?us-ascii?Q?8N+jzSx+K6JG4OD7j5mjQfdPVW89MpJeFwPAzpUWEPhqZonAY4wDktvjMcIo?=
 =?us-ascii?Q?RqTkbeGPPIlWFT/uJ4wEjymTBHIV4lGZOTECt+ix3gQT5uVwz0a4T1VzYUvA?=
 =?us-ascii?Q?y1dxivVn/MmAs3sJydj6u/CVo/626gVhbesTTbuNfRJ0CkhFf8ORVADTY3YE?=
 =?us-ascii?Q?amoONBQj6U5Wu43EozN6TLz1WGmw8N+3Ykus1X8VNPjZEp0hWJCRbwUDJ/xE?=
 =?us-ascii?Q?U6/auxRB09S5bBCEVUw1X6gAAS40clklZCVRWRB/ecvVU/mCZCxC7wYW7Tnf?=
 =?us-ascii?Q?OlxP8lnCss7T8CTu+bNDg780lbNdrxus7CVKZSVcGOz5h9YpBLjSoyEv3Fhw?=
 =?us-ascii?Q?TCVPd5PMCSZnlnp3k2lWSLTstbop6xgSCWq0tB6kBvzuDYs4pK/ZJ0bqAmOq?=
 =?us-ascii?Q?36909JKct/sVsetpxTLxOHAUsdsVDhmX+pabI00LSbia1OLwd9BZkO0EwRA3?=
 =?us-ascii?Q?p8vL9B3G4wHttmj6hc6HgBj2rAtj7sqOmW7wUrADFzFf3XrmNzAqU8d+YIJO?=
 =?us-ascii?Q?1tQM4HSrye5pDlHX6UQqp0PnK8O1vPnzcNoJxpiZ//O+maUoY6KN+SA+6FYd?=
 =?us-ascii?Q?BL0IhUSEkbwxeXMSCdk/fpph/tXTMuoKxoADkzkRLr32B7ja+Ar3JxjRvTN1?=
 =?us-ascii?Q?CUZg6OlG595trCz9n7L/bjNAKZtgRjxIryeQeqgUL12mTrla8tUgwOUO7Wt3?=
 =?us-ascii?Q?HVBiGTOQwl+KEcOcDdrYPwMVrglm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 21:12:44.0766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e89b72-b111-4096-95b2-08dc695a4731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add sdma v4_4_5 ip block support

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c         | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 9 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 1 +
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2aad1ba0ab9d2..83bc80f517fe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1781,6 +1781,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(4, 2, 1):
 	case IP_VERSION(4, 4, 0):
 	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 5):
 		amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
 		break;
 	case IP_VERSION(5, 0, 0):
@@ -2059,6 +2060,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 		break;
 	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 5):
 		amdgpu_device_ip_block_add(adev, &sdma_v4_4_2_ip_block);
 		break;
 	case IP_VERSION(5, 0, 0):
@@ -2611,6 +2613,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(4, 2, 1):
 	case IP_VERSION(4, 4, 0):
 	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 5):
 		adev->hdp.funcs = &hdp_v4_0_funcs;
 		break;
 	case IP_VERSION(5, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6d23588ef2a2e..151f83ea803bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -258,11 +258,12 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 				else {
 					/* Use a single copy per SDMA firmware type. PSP uses the same instance for all
 					 * groups of SDMAs */
-					if (amdgpu_ip_version(adev, SDMA0_HWIP,
-							      0) ==
-						    IP_VERSION(4, 4, 2) &&
+					if ((amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
+						IP_VERSION(4, 4, 2) ||
+					     amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
+						IP_VERSION(4, 4, 5)) &&
 					    adev->firmware.load_type ==
-						    AMDGPU_FW_LOAD_PSP &&
+						AMDGPU_FW_LOAD_PSP &&
 					    adev->sdma.num_inst_per_aid == i) {
 						break;
 					}
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 4db6bb73ead42..077c6d920e27f 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -50,7 +50,8 @@ static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
 	if (amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 0) ||
-	    amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 2))
+	    amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 2) ||
+	    amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 5))
 		return;
 
 	if (!ring || !ring->funcs->emit_wreg)
@@ -129,7 +130,8 @@ static void hdp_v4_0_get_clockgating_state(struct amdgpu_device *adev,
 {
 	int data;
 
-	if (amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 2)) {
+	if (amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 2) ||
+	    amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 5)) {
 		/* Default enabled */
 		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 7ea209b681541..3b5f7a5c3756b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -44,6 +44,7 @@
 #include "amdgpu_ras.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_4_4_2.bin");
+MODULE_FIRMWARE("amdgpu/sdma_4_4_5.bin");
 
 #define mmSMNAID_AID0_MCA_SMU 0x03b30400
 
@@ -134,8 +135,8 @@ static int sdma_v4_4_2_init_microcode(struct amdgpu_device *adev)
 	int ret, i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
-		    IP_VERSION(4, 4, 2)) {
+		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2) ||
+		    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5)) {
 			ret = amdgpu_sdma_init_microcode(adev, 0, true);
 			break;
 		} else {
@@ -1229,6 +1230,7 @@ static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 5):
 		return false;
 	default:
 		return false;
@@ -1392,7 +1394,8 @@ static int sdma_v4_4_2_sw_fini(void *handle)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
-	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2))
+	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2) ||
+	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
 	else
 		amdgpu_sdma_destroy_inst_ctx(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index b9e7858466376..ac439f0565e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -306,7 +306,8 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 		 * driver needs to program it properly according to
 		 * MC_SPACE type in IH_RB_CNTL */
 		if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0)) ||
-		    (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))) {
+		    (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2)) ||
+		    (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 5))) {
 			ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN);
 			if (adev->irq.ih.use_bus_addr) {
 				ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
@@ -337,7 +338,8 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 
 	/* Enable IH Retry CAM */
 	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0) ||
-	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))
+	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2) ||
+	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 5))
 		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
 			       ENABLE, 1);
 	else
@@ -562,7 +564,8 @@ static int vega20_ih_sw_init(void *handle)
 	adev->irq.ih1.use_doorbell = true;
 	adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
 
-	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) != IP_VERSION(4, 4, 2)) {
+	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) != IP_VERSION(4, 4, 2) &&
+	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) != IP_VERSION(4, 4, 5)) {
 		r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9596bca572129..3c4b758d9733d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -83,6 +83,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(4, 2, 2):/* ARCTURUS */
 	case IP_VERSION(4, 4, 0):/* ALDEBARAN */
 	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 5):
 	case IP_VERSION(5, 0, 0):/* NAVI10 */
 	case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
 	case IP_VERSION(5, 0, 2):/* NAVI14 */
-- 
2.44.0

