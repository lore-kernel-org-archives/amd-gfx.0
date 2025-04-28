Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187FDC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD0310E218;
	Mon, 28 Apr 2025 21:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="et3XZCKv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECAFF10EA6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 21:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs9Z3Qkgx47lhK00HgOUM4imvkwlI58aAQcd4yPk4QJ/9R6Jk8nsn8toniVj8txFHplKQSLp9PnhetazPpLbB6dacNAi3S+VWE/g7UH8h79i2ZFFUcPzL2XaFOj4CAulMtK+xy7HfN2tSYrrVSI+cpJE7pRZEfSO/m1EULS5P2Sa2PAwOdeBXsuS4bl0ytahl5k4y1iLwI5smhuj22K5mBcgwj3zKpTc+uz6od6RHEFlE4HAHtQLBqM9/11Siu6qbLfmuGV7kO/ex80RZevOztrJTYhtgZARlf3QRHTdRcyYk6UjaYr5f7UH6PZSXH/YIqAOOEkCT/09cilkmZaXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS1rsE0+8L5EmcvixMtRmKqlbhF+Ylm8cPDVKDAC/5E=;
 b=yz1hQMbJrqQuJn47DQFGbEbDby0HNtYF3MbH+WIqgHUJuX9HIt7ZNbQuk71ZG6BwJM5NshcSuM6sLuXBnR7ABcyN8FHnn+KqJr25pdyMRvpI2SkAVkeKSB2B5DfrMPXsaRY9hBlkDmw92R2o1Izud0IFG1nbPPBkeNb+s+MmysP81a9CvBPn1Tw8dihVhFd0xdDbNA93KBGjMy5489oSQwUbdUpwTwwnCV/6/KmGAl/NU/Ynx3YtUFCuiH+99qsqWfwp42wOsfc0AQQqGTpMkSpVMuTAV8sT3LVmyRY1QDhs1Mi57A39A9ZswMjJm+wFRaAQyIEqDpexTcu/5dvyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS1rsE0+8L5EmcvixMtRmKqlbhF+Ylm8cPDVKDAC/5E=;
 b=et3XZCKvnfupqBeld+Swo+dLeyivss1HG3V6duQaAZ+Mn/ir7oNrmhtOJSk02L8pd8G5Bia9PXyp57a0fPCes7WzA06z8ydE68EfRE/WZ3xFXPTowZuEW4EvodoMFuT2kmvb04qMS1Ew3nCPTkmDvtkSiAXwkTqz/NYP9AWPdsM=
Received: from BYAPR07CA0074.namprd07.prod.outlook.com (2603:10b6:a03:12b::15)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 21:21:11 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::87) by BYAPR07CA0074.outlook.office365.com
 (2603:10b6:a03:12b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:21:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:21:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 4/8] drm/amdgpu/mes11: add support for setting gang submit
Date: Mon, 28 Apr 2025 17:20:46 -0400
Message-ID: <20250428212050.1098434-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428212050.1098434-1-alexander.deucher@amd.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a311575-fdfc-4220-c8de-08dd869a991d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tglR+22+Du5NmSwa0dzC6Bc5et2ErOUiPBkfGwKtZozxCUTSxCyeIHaam4OI?=
 =?us-ascii?Q?gx0c5LFMqpY4eEhWy0JDvIM2ZIODSxRyH+hHqzIqYyY1fKxYEub24C759ZrB?=
 =?us-ascii?Q?qldDCRhhaRD/mhTay3H55Nw2KQvl4y05uxP2+7+kEhSO82ee0dO9rqDytNGu?=
 =?us-ascii?Q?8/KtFVZeRfzV7L8nSUwo/oyh3lOzxEKwW3LgEo5JSTVU7UxALwukR89BQoQd?=
 =?us-ascii?Q?rLm6P5R8Qy70jEepn0SOj7oOJSuAwKTUm1KP4/U1ro94Xrdr8YHCg88A3dhx?=
 =?us-ascii?Q?krjD8AH0DtTuNI7eRyuWeS6q1b/VvABPt6qPg+MCka/d7fsorsGxRfzPfY/r?=
 =?us-ascii?Q?ZQhfoDs9HmPxw3+6kWwgsTosHZSq/wsiFmyu/Gi52Iwb0+l8eUnrVEQDNBWj?=
 =?us-ascii?Q?HnnWxmjIzfgYpaQ8AwF66heZ8GEzTQESzKNnKb0XgV0qDzZG/uoZnguTEjQK?=
 =?us-ascii?Q?sYZO7eEPLe2mv7c7GG5w4l0V1sJv1E46iKt+G+8gsJZnc5qbAm5UmOBB66qq?=
 =?us-ascii?Q?4Y7JB0cMiLZEHaJZTN0l6XA6PKfk4UQ+Oy3laLNVtphyGViHqvDxKR2Kaoim?=
 =?us-ascii?Q?nka0FkkXfwpwhMHalPQNG3o1RxxkEtSVvjvZJdO1HWAQV3jFy+KN9ARNBoge?=
 =?us-ascii?Q?oe2KRS8HjeIP1+BBpI0hrG1NNRhbu3MIfBSC13SOb1Qq65e8EoKmAE1X7cBo?=
 =?us-ascii?Q?MC7B8sWjjdRZY2IKAJOStb3055dXLWgnrfXi5shlCdFBqmgi9DLAcZyDs8db?=
 =?us-ascii?Q?2ES7iaJwCYhfRMxFIGa74k0nZR42UkmpPjQG58RZ5kfgV2jPApZFOzarMWfX?=
 =?us-ascii?Q?2VwMePQSA7Ij+EmcdR++qY6WsFalkVeDNiQvSkiwd3UvchFxyWXjt0Gm7hmH?=
 =?us-ascii?Q?Mgbg04OiYRSVNSUHdq62Mty123s5BWOsOzImsapmE9rVd8QsaHVDn9YHm6An?=
 =?us-ascii?Q?mvYZ325jwUmaBRs1hAly/bwrHTX1+cGlpsG244ybLtCuCIvpU660oSrCfe0c?=
 =?us-ascii?Q?qmvWax1fWaHLSOqT9uISG+tIr19gvuJ/eIHdX8S4Hq3uSrSH9WjWbImgASOs?=
 =?us-ascii?Q?ZyvwZShZUQhtbzyBzru0zI5AaLCfdWYZxyk+lL8VzH8P8Ad5tHUqdiBRoAia?=
 =?us-ascii?Q?3RC+051DenOp+5DqZm/WtuGBUjrSqqcXE3Mem1oDQJ3V/j0X4ZbsbEnhk/uz?=
 =?us-ascii?Q?3qillEc4Znq0xnHvtIYgfe2Sd6ZhMBdXwm4r+IZU3EnfQqF5LQKnrPRrOTiw?=
 =?us-ascii?Q?U3IUImDWCVjT/PeCucvmov2VdDFt1ReRFxB0FRfu630ZQDm1pmbw54vdFPwV?=
 =?us-ascii?Q?mixkZhjTAU7LEFhjd3LAPFY4dpQCjGKW2LBgUKCG01ZVVv9aE93ARl2lOh8b?=
 =?us-ascii?Q?VOi7b2osxBxIN6uCMIP0hCkwUpN/lw/Ezj3eebsvwprUztf7BzeoFANrxztA?=
 =?us-ascii?Q?0US1so8b2/ucqIfOfO3i8xr/siWlglqIfU+Af2OqBjAzRrg8fPhzm7Zv35Q7?=
 =?us-ascii?Q?CUOhf1R8iA2E7XpdqfE2lDG3TZ5b4HYmLglB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:21:10.7020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a311575-fdfc-4220-c8de-08dd869a991d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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

Enable a primary and secondary queue that schedule together.

v2: fix offset of api_status (Prike)

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8a31bd81bcb9d..e43f19815b315 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -783,6 +783,27 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v11_0_set_gang_submit(struct amdgpu_mes *mes,
+				     struct mes_set_gang_submit_input *input)
+{
+	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+
+	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
+
+	mes_gang_submit_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_gang_submit_pkt.header.opcode = MES_SCH_API_SET_GANG_SUBMIT;
+	mes_gang_submit_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =
+		input->primary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
+		input->secondary_gang_context_addr;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+			offsetof(union MESAPI__SET_GANG_SUBMIT, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -792,6 +813,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
+	.set_gang_submit = mes_v11_0_set_gang_submit,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.49.0

