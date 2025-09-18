Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0419DCA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 17:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840E210E172;
	Thu, 18 Sep 2025 17:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uU4f7OHp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2C310E172
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 17:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am9Ykww7saIfhpB32Uq/k7LDP/VavFOui9Rz90fAReEw55j3aO+Szeo1PU2XnDnQAL+lcUpHfyz6idy44sHcvooXpo5mJw6c6qYa0KC7XEiAh1z9JJlDvSqdjAzZ+gvEXW1HfBeLz1iogPLuMVwYCMF/MilUfE8bdCjbPyWf31W51YMYr5FHtVv2uPGvgcBmSQtEo1EM30zsI6/6F1Sal3CY5A1r7dFX3Ss5hRu2XeXxYtfFnCieWJW8JWbAWe7/B9cRfxLChNLpmoN7WIOyfXp+fIFu7rZ3tUTuGVT/8zwESc/F5bUOUEVN66QcS91NP/QzztAW748ccv+8m9Jj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFIoKBWqUxfcrKo+etrvIVJh4Bj1qumHSmM+llhi5Bw=;
 b=HWvN8EsylkirWnpQJPYADY/p0n78P8Apy1MASrT73auex6UGJJP9WPXBc7KhraVZExOOMXTw+J/2FVi7e5dFw+MUqEt4rYdaKAoVO8Cx9nSBIuWBMnmk67pOaSMoOq2l7YsgNjEyiWyt3aZGEObUBbIzhLhgVJ9V0leLNN9UTgmd4o5XNWcu3V/ANCJ6CPoFK2XomiRFrA+AB46Izj6rcGoEi+nY+gb+St2Cp6UuyWtmN3s46Q6vyypa2ypZHM+JV4N7UnCZbOSa16oZ8wzy7YnkZo2Wnaa0n0UA/CD9BpVIGn+ruaONbrJtJRXPcyJ/OBcXmawJc5Qi9wIeyBF25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFIoKBWqUxfcrKo+etrvIVJh4Bj1qumHSmM+llhi5Bw=;
 b=uU4f7OHpfvcAimYQ/vj8/9idPddLytxp3ree2fjq1kBqCzMTyLH+ajiizhqijX1Jy2CdUnaESvU4Yu4u1zitIYIW240wbPQVrG5IQIZMuG4gX78n27AJ3CjWNAP3tFuVc+PUd+pUDYStWgqKmY7QbcDv0Kndt3CDiUUBA54e/Gw=
Received: from BN0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:e5::8)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 17:13:11 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::26) by BN0PR02CA0033.outlook.office365.com
 (2603:10b6:408:e5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 17:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 17:13:10 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 10:13:07 -0700
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH] drm/amdgpu: Update amdgpu_vcn5_fw_shared for vcn_5_0_1
Date: Thu, 18 Sep 2025 13:12:52 -0400
Message-ID: <20250918171252.2490673-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 14faf69a-36ca-4a93-7646-08ddf6d6a4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LNrLxq29ZkqbP3jOt4TE3VZyxEySDLAhuy1rO5MGK8gNrNk9kD9z9GLxOEWo?=
 =?us-ascii?Q?eSgqHUyzwNU1FJ+YpEArWzWlPjerizNluy1lmAcjUUZQ9Y1CPlcRoV1LGZJE?=
 =?us-ascii?Q?pHEUmFMoMeS8nPnQE+MrlSpLvgAwHj1Bn5aCU6uNwJNesYIGT3a+RrVjYf2z?=
 =?us-ascii?Q?JtJc6ax1GjRj7hFTMo960YEnqDz61JrV3IfRriJA5YRdolzMisX8mszL2nl8?=
 =?us-ascii?Q?li75tuUfUtHnLFgUtJePFA4RnXT/xbpZ58WlHjciYtL0drJlwpIscYs2Vwhk?=
 =?us-ascii?Q?3Z0FTY0u2VdVqxqiCANIt2Hmn+zYDDIIEkrWFJqcJvUIJvTSExbzi4CpQZfF?=
 =?us-ascii?Q?0k4pcKnidilEXx32/tVjTVdzvYZxQqYj8OBdPwaI3tOj8rWryvqIs8Bl4Suf?=
 =?us-ascii?Q?Zq/Pp4ZjSZUYEOKd9M1KEM6C0ZgM0JiDdrw5ruqmsqBYna2/VRTiO9cmX8lc?=
 =?us-ascii?Q?ayqdCXSCV2W7zixjWASlo6iBMUYbti328AJUxeoS47PRINxeg64urn+dcCRp?=
 =?us-ascii?Q?2x7P2PKudIRNNdERXcJmA7XOaOlRnC7XMu6XeekMBHuHjTfXdvJZzAeJW+Q6?=
 =?us-ascii?Q?h6S7Okx5GHcbZlLoJ3iWpiIk3GPd3jPQyRUn3ThsbZmqyzjIl+70eb1X2YjZ?=
 =?us-ascii?Q?ADHMiD0q8RUawbxqjz9g10T1PB3SipORILYpnY4yIr5fsTumN5xU/rhCq1dL?=
 =?us-ascii?Q?0wLcxahxPYsbOn3nT2B/Ousskn9nznhLjNShy+CoFEmIv8e7NYMTMu3v0FnC?=
 =?us-ascii?Q?pf70xuIO1x7JvzT5x80lNfnrIpRs+fVS+KDHjZ8OKuFAMuC+RXWDDPFq6P9E?=
 =?us-ascii?Q?VzD9U3h60v08K25LgKoZTx7fQkxcQ3fbk0X9XCWHWsYWjZFLj+KAJ0vZZ7Ua?=
 =?us-ascii?Q?Acai3UoJeY0Mc25H5L1apDsnCN8uobeV5joElTqZaP7u2VFBpE96V1T5mVKZ?=
 =?us-ascii?Q?FmtYQCAxX0YTgwOL1HTSfJ0XSx9FceYkV9Ck5EERNsSHqPZ9aJXXF3P5ybVg?=
 =?us-ascii?Q?F76pCNSXQB3rq6otVoLPaW/8PvgX0hhmPyhpAAqStCcRtvZtVAZ6c6p8q/sn?=
 =?us-ascii?Q?qoLqHMcFHTphmGNEBDSSbO8nb1VZ1vMcArHS50E748zSFXtIXWRu9BXk1Vkq?=
 =?us-ascii?Q?KH1akptIAsBlVqMje055Kt1FhbZ7K9JRiW6c+u32dwKOx0TL3xpYjMflJ5p7?=
 =?us-ascii?Q?3CCgxmZ4qrUcnyoPRnmbon1p0qVsAQSBopV4DXSck13Gcxza70EkzN4GQ1Br?=
 =?us-ascii?Q?LKFLXdu64LwLjpHJ4U1qIvk/u4TPZRYsF7t05p84EdnbeM0AEwhQbTR3m9vf?=
 =?us-ascii?Q?BRRI+C17tE6UL4VRJp+wplzHpy/W2fljnd4+ztlLZ9xbEOrDDWGrYtVyClyl?=
 =?us-ascii?Q?Vhb6fNnq7A8T9WmWxvUZASf/K5zxKc5CR/ZUqg2xgFztOI+yHyt8b6E4u1ra?=
 =?us-ascii?Q?lgwHf+eVqSkqr+1/yP3qoq5u7MHbFldbAmHKFtT6Patfx9u6JyHiYS6Oa5L3?=
 =?us-ascii?Q?shSnTbSiAhKHvNqL7EBFOcq44vv2LShmCB/5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:13:10.7690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14faf69a-36ca-4a93-7646-08ddf6d6a4ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
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

Align vcn5_fw_shared structure with FW

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bebfc2b34afe..dc8a17bcc3c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -501,7 +501,7 @@ struct amdgpu_vcn5_fw_shared {
 	struct amdgpu_fw_shared_rb_setup rb_setup;
 	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
 	struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
-	uint8_t pad3[9];
+	uint8_t pad3[404];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
-- 
2.51.0

