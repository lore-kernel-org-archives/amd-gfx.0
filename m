Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43EBE92724
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 14:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D4810E1C9;
	Mon, 29 Dec 2025 14:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eiNElbqV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66EB10E3E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 14:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK/Tc1gQl8z/TTu3Jvg4pLK5RwqdtnyjtQoJ+g9K839mA3688IJzXgr+6zNNGIMdwJUDFBRRu/TqLluBPoND+AOg25LiHh0gVaZMhY99kBkpGQZBmorolgEsSSXpRy0tzkimic8pkRoQPBPlnzD7WyLeIkGKYUWimUjKQ05XBYBhk9Q6w2SJlt8HPf8WdwKdyeYcTx7R00YV0h2+AUlbvY4ipuRIjSHOrh4zELaU0Hyh2Qbx6YbR+H/hFukoP4BA/jm4YjTWIFgfVVTcjR+xtv6313mcGJroTpB/YNZ8zv4N43Pu9poNsc0YhI6hGCcX+vveTolNSCB7QjlG4YTWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW8WiPB2R1XNdAZ+75joXZIpOHe4lpKS/lhHkoITGMI=;
 b=ZyM8n94t+THk9wAN3OLgChMJx2Ja5B2Nt3rqb53D4wZKgiQTB0oXq8paKr/jdBFj9eFC3ypf3r+slR1+5Apfnm+FHUrZgPh4TcUarDQMGeswa8wYQATEqOhwBx+9rT5KsaTP6YrykV0Jh54ogauSWVQdc/Z3tlXhPzjHezriB102NpEE5EbuvGszMHCDxBNpF6xnax3FjSfdBfsGYCmlw6exH06nYRv6wFBhxbkRwN9lQKaMvXdEFm6OX+w0105EN5/LhxdUh5By/yUQTt1TaJw9hg4Iv7mSsAN4TEAHhivj0gCMf8kD0DpSNx11aW3VVpIflAm9oDN/B3P3p6gyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW8WiPB2R1XNdAZ+75joXZIpOHe4lpKS/lhHkoITGMI=;
 b=eiNElbqVFcJUjVbj+ilI0JAB+x3hXz96p6TPmNtIaEpDhbR8S1GsNNJpW2y6256fBuo/u7OLnFtpc5n7M2IKOgv+x41ikTUH89pjT08uz/UxxNPQtTb3T/kHdejjhWuzLuN/jZuIP/iNP1cOaFjqaibak17hjLtYTreZLVAErkY=
Received: from CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 14:34:07 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com (2603:10b6:610:4d::4)
 by CH2PR19CA0023.outlook.office365.com (2603:10b6:610:4d::33) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14
 via Frontend Transport; Mon, 29 Dec 2025 14:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 14:34:06 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Dec
 2025 08:34:05 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Gavin.Wan@amd.com>, <YuBiao.Wang@amd.com>
CC: Victor Skvortsov <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Skip loading SDMA_RS64 in VF
Date: Mon, 29 Dec 2025 09:33:41 -0500
Message-ID: <20251229143341.276909-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec03ac1-f7c9-48fe-2623-08de46e75262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ZJGIBwtatAnvsJS9C+SBvIDB5vVj7hr6ybGyUBYuwV2Z5e1r/UGUMXwJZbZ?=
 =?us-ascii?Q?t7rUiac8W2uf3MsQ+Oi2r+K1+FA8Mk92Mn1HzW7g9tDGSpgp/X87bJSeTSKK?=
 =?us-ascii?Q?vjEfzEedoyzx63R2E8C1q4yfY+kAJDVaQv3hLypNqBEn9+cOQqV9KslFur9s?=
 =?us-ascii?Q?8WAlHbMjuIMFj/SnIEIEgjSVvqTB71PmPqTtMbZSdgDEiFC+uf3SihmPH0UK?=
 =?us-ascii?Q?vWBHc0uAoM4nu4yX2AMHSHMHuRZ6b2JwLs5aDK4f1deCWepgsqmKGnvH2a65?=
 =?us-ascii?Q?VNZqtSkJJDH5+t9gF979PcVh/8CWnp/Q007EwM33rsORreO4z0pmEfxwUgzM?=
 =?us-ascii?Q?ZgnckXXmB8N1b/eH6Q1TsJSgnWIlEmtv5/JO1z4Z399NcErZj+Ug9jejSZS8?=
 =?us-ascii?Q?LvAa1h5oBpIBiYm10PbpFVKfrHfu8vChCftF3I/EOnO6Ey8NTOt4vNDQFNA/?=
 =?us-ascii?Q?W3GF38aGGow0P9bmaFHEVoTZa1vHGRIo76pxOyZWge3N7aXp7ez09pzO6Nr2?=
 =?us-ascii?Q?jTFvErHqE2RbiQeRzALsx91j8BhJuy8E2DepsqU2mAEa/3etsxpM1OyCmFHG?=
 =?us-ascii?Q?b2i17bdkiz/XnTMLRsqcSSq3R2Mgd044UeK1hBciOxsM74mDRTE6BFK4hdw4?=
 =?us-ascii?Q?LwPpWX3+lalnA9Pu9CO+l4g1OqS2TD6L7Lc9nbhSqBwzRdbGyH7+dUhDEO6T?=
 =?us-ascii?Q?inSAPZ71MNvymef9cN1np25h3voeYJ6jgi2B7pJH7U/EXHDXB3h4NQKdqQXe?=
 =?us-ascii?Q?2VZTtCiDK+qFUbvdmjD/N4NzyFtu4xhEk9n330MMMxzeBU5yg1xGWlRifMy5?=
 =?us-ascii?Q?TxhzbTMcHKrIKWfLp+4HYK9z4YjphjJAWRsQ3tr0V5S702llG3gExGfCtgjb?=
 =?us-ascii?Q?K++E9NjHnKDxFMrt14btAMu4bXrJu1dE5BPNbKa1SYnLGlJgxMAPtmqqY2od?=
 =?us-ascii?Q?a5NWgt02LN8Qo3x0coJrCuuG2emT+aVdqOGurVMSp4I25soea/rvzNcZU5uo?=
 =?us-ascii?Q?X5+goiF2nbfM7ht1dq5k0idruUKbnnLVok+W03dxuw3Mv9UKy4oKlw+0O3MR?=
 =?us-ascii?Q?5+f5lxsyqCayxdR8Qf4fUJHpeM3WEh22RZtQSjhQLA/iEMUiieGtXWZWEQx7?=
 =?us-ascii?Q?eHWQmpON80dLGxe0KB2BhVb//to9Msr6EOdoD/wqEwaS6yh6s0DzEwkLkeXd?=
 =?us-ascii?Q?lHxsAoB63p5vHrKYdZjqPoHLg23Tr3niy+O89txZTmPFI4Rf/JvAyxVBZ09A?=
 =?us-ascii?Q?zq5EknkTN4aJniUd9FgiSCgOwG7+zqqhbCpyvEPcSrXDCnaNugiDrx/YfcY0?=
 =?us-ascii?Q?KgM8Ld8DJX2//EU5T7yc+q6T09GM1q0dEMkBhu1/2bUW1yrWn+ux5KyimoWT?=
 =?us-ascii?Q?rtWAI+jNFCdmBg9X2AkNdcE0DUDd0924shcZDZvPh+WHSKuUSjjatja4T3GX?=
 =?us-ascii?Q?DAf+1yOQLg/D/iq1svTVDK8leUTwrhGUyBijdGVT9EkEpbdAJiW51nIoHChx?=
 =?us-ascii?Q?ZjerVCcOOg14EnCfza9izeHjMW4zsNKoVBtAjywcrvwAdi23FtaF9ZNqaGqq?=
 =?us-ascii?Q?DLnRp9IHdM/ULoNbVoI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 14:34:06.5955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec03ac1-f7c9-48fe-2623-08de46e75262
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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

From: YuBiao Wang <YuBiao.Wang@amd.com>

VFs use the PF SDMA ucode and are unable to load SDMA_RS64.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f8eac92a2b36..f01f38509108 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1262,6 +1262,7 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_i
 		    || ucode_id == AMDGPU_UCODE_ID_SDMA5
 		    || ucode_id == AMDGPU_UCODE_ID_SDMA6
 		    || ucode_id == AMDGPU_UCODE_ID_SDMA7
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA_RS64
 		    || ucode_id == AMDGPU_UCODE_ID_RLC_G
 		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
 		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
-- 
2.34.1

