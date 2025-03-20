Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B61C35FFF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 14:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E86210E620;
	Thu, 20 Mar 2025 14:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hiru3Qty";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FC310E620
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 14:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqWD4JRM+J3xJKuUIWHifSS4/4CH8aannx58FR0jilC4rphXMZ7jvxSELCkRLrH4kQ4Ftlys7bCGmzeDqxWTb9l1V/EF18oBhl93pzFg8LXzUwn+BWdivt7Pi8HgwqUdLVp6F7WyH+ZYHzmgFr1EEThUrivTbCrrria947DipEYUO3jjLyspXuJQR06LWmVPFbiTncPRF5Z+lMVEVhVWwqktP6Ph0AWXx/JrRzU+TDVPHw0PPF7KbbdXhF4Xv4kE/XMyPe/HV+gDBLEDeLCoKvgiVIKIn6EkA8rL2aYVK2z66w/vMrK5e6tKKyi4MKIku5LLJdHWAxRCHarjeSelgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZL94z646Mtt8L2RUEyv70j0p0zGklibzhYa2LiaNSI=;
 b=Xgo0NeDHdjMFiWJvBt20rx4Ug1fHw3JtLCURpbeH26PoV7W/FaBD1rcOF776oX3O9E8GTYXs8sFub+qOr2mD1bAJoNx1wU8zcnaMFRO9MYZT8HU8b2Tfjo9QcJLo/1MMRdkTBrrOd0+m2abdxvs5ypM+fdB2IPppZyXmpfcevepf/VEMYROSfVBwV23+0Jy2teM7QVDKZK/ia7xyqXAhayRWavmM14L9Rp+oWKZvreMT2iuvXWT8BikKttCdkOAZSx+yq8GNHX+r10KFKM6G0RkViBSlkbCzbIk+oW0ek3F3FcIABqHDIJcQLwKvWs4iAgwuc1WTzbSsxE3v/eAogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZL94z646Mtt8L2RUEyv70j0p0zGklibzhYa2LiaNSI=;
 b=hiru3QtyESY77aCDC/2ApjeiMJoct/rRTreQZhryalUtnUbMFb7CYjiOYTwUD0uMEf9VN/TcM+RoNcnw3SQBAt/STXpEN9qImTfo4CCjJObXRGQJfE8j1ZMiyX7xMOyA8fNTDg+3yY+poy8qXSonqr57qLHJPXF1j70mycLzOYg=
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by BN7PPF02710D35B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Thu, 20 Mar
 2025 14:23:23 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:dd:cafe::3d) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.30 via Frontend Transport; Thu,
 20 Mar 2025 14:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 14:23:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 09:23:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/mes: clean up SDMA HQD loop
Date: Thu, 20 Mar 2025 10:23:05 -0400
Message-ID: <20250320142306.1135063-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320142306.1135063-1-alexander.deucher@amd.com>
References: <20250320142306.1135063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d026e7b-9673-49d8-e31c-08dd67bac5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2TQdP8bW7MZvwcGDoRjZ1YHiCEWS+xSMwX0DhIaBUjTsczEWmLMZwFp4Ooi7?=
 =?us-ascii?Q?eSI06YQ1qHYymjZKlF7Joy6GTHoReb1vCnZLbIrZ2H247jkYscjCqUUUsf0e?=
 =?us-ascii?Q?xLbb63/PcRqpjKbPleFssZ86C498xiN4cScIOQ9kkfsPGiOTx+AJ06cz7pip?=
 =?us-ascii?Q?F0daugTkA6cXeu8nkqfB4koBpP/I8z9jIm+/XbDEzsgukRWg3B7P3MA+V7T1?=
 =?us-ascii?Q?GbzYGC8mB+XySBWSZLjDVkRDEOSYShwRhUbHJcfy9DxUFK8LDrXE4Z54rzRM?=
 =?us-ascii?Q?OquLHbrYBpEjaQJ9pcOwNuSq5F+ER+Wu0ASaJ+HceuUncDp4B/33ZMN61C7a?=
 =?us-ascii?Q?zUBfFT8oWvTld22fSq94ZBDPD1biEmIe6qAFiltCtd4bTj5o1AFlyEif50H9?=
 =?us-ascii?Q?+ri9F3tgLdMsltZeOD+iUIx9KgnnMdpKD4WzoX1i6DUgOsi4ctfTTsFWvQPW?=
 =?us-ascii?Q?rVJo+wxRLo9iqd+oIn51IfBpJ+Ar5fVm4U7wMImTI06/EzZB1wI/VClYHZI5?=
 =?us-ascii?Q?d7L/x50/9UCTpjbLdHUcTqO3TNRku5G7E2yGaVpQTF8UN2SEMWoe5gt7SCPn?=
 =?us-ascii?Q?lVp38THQJ4Sab5MinPC6Uj67ZLKKG+4itTC6CeUpaB9o5ceD2kKBDSOvXZW/?=
 =?us-ascii?Q?+iMwHkhpELi/fM+AA+Baj2gu9086MvCKj+169/Fl9598BnMTHHUiza5B96yY?=
 =?us-ascii?Q?pEHeskUxIB1ObrWyoLl+ypFB8gn1VppeFBFLO7DbA58HKtGr4uBhKC9vVtmR?=
 =?us-ascii?Q?jXP65IxKAICxkQ4mZROktJEJchPjmWCCPRltX93tuoOu6b/mUkPG9HbjhQ3R?=
 =?us-ascii?Q?56DPaJJe22t0+HJautJ93ylMoasZXJDZknzVKZL9Voq5s7orQGKFCAADP3H8?=
 =?us-ascii?Q?qwlMkrRG3TdSirvpTyfRWIDf3DeciwB0HBx/zD21QNr717zkQo8pOar9+j64?=
 =?us-ascii?Q?QtWW3Y5K3hf+5uy880JjapUCVHZAD25eIqzW7mWX0yZE/81YTbGdOg0KXpin?=
 =?us-ascii?Q?MUl0bfB+B0H2PkB2mN6QuDKZt+Y6lyPPp5E//RAlbFKszP/BRUbcM2Swoc18?=
 =?us-ascii?Q?GV7vsraGpi8K2/c4ETYD5g3AHduLERJwjmnyD9m9PczhSW9v0/MQNCqJUb6E?=
 =?us-ascii?Q?/dk/rEP+/lHvhsGt54VtTQCRhgigY8errAogG8+bod5sQfuA1k6nkzaK99Z5?=
 =?us-ascii?Q?26BwWAn3TSqiGYWyk/AVIoar6sU643cu+AUhMFJMxd+9gIIiDNt2Mi641tCp?=
 =?us-ascii?Q?5O4EpMT7jaZznd8lS48bWDjIbhYKho968Uahj8PA2iaREXcWFml6v41dR5Rz?=
 =?us-ascii?Q?oIsKqY/x10fR6XpWM2UVnND3Ex31OBI8zYrrIA7AY2Fhd77wPSa1ezRvybIV?=
 =?us-ascii?Q?/MmhBpJwHY02oDzYfLNHFb/JeFUeZra8FimzBZF58firdDUq7Pbo8kq5vnnd?=
 =?us-ascii?Q?ruMquNN1txdUBQuQ+wOvX/X4XoAIr2ewOs0umXHfCes7fvP/du7mqrIKB/xD?=
 =?us-ascii?Q?YiY49KUQUVAxQEA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:23:23.3182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d026e7b-9673-49d8-e31c-08dd67bac5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B
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

Follow the same logic as the other IP types.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index fddec5d1f2444..016af4e9c35fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -136,11 +136,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-		/* zero sdma_hqd_mask for non-existent engine */
-		if (adev->sdma.num_instances == 1)
-			adev->mes.sdma_hqd_mask[i] = i ? 0 : 0xfc;
-		else
-			adev->mes.sdma_hqd_mask[i] = 0xfc;
+		if (i >= adev->sdma.num_instances)
+			break;
+		adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
 
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
-- 
2.49.0

