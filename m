Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BB9C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 12:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6C910E1EF;
	Wed, 28 May 2025 12:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ck6aFnGQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD6D10E1EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 12:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf8RA0oZr7Wqis+LodCgbsQA4FNEuhppey9vhjI9FEz2g6IIWeX9oJGCd85zxGdVL31UhUtJwK+0vn6rCu/gWGpOo/9qTMTXgcWsFjWQ4UugTNtNzYEzs/PzF1thCsctyYTXbV8TIPydn7U9qxBk4Q1a4XRYrB+jysrBPa6Ph45BNvjlYNNVSr0zY8zXvnwjxiZCKB/uhvEAoqg9bj9NV6g5KmC7skxX4i4BYZliWMCy6PrVVFGCMQM/HzsYVeftJDCTWeApS7J9PH0jqkx9Lir9pstbytsuXovQIWc19ej8LwxrjqD0R92tHyEUZlusflQPLeGQDc7Sjl2KCWC95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzuui1fGEpZeBWgiAGK5GHT7A/lLvokbRAd6r9PBPWE=;
 b=OB6kZCGTkDOIyjnLND4guI8W5yp/MfdbD736DQzP8E8dAd696KRVPsiXZG2bgt4Ql9WdCp1E4gmahvQCx6FZ7mKmrdSIt+mUBNcJj2aVUg5oTv0et286WfEpAOX38HO6OXtIEE2ub3+Vapp7nmbF5wjfLoLNC895K7MbKdDLlQHhXz4rtHx38SOZ95TA0E4pLRe/y6XalfqzsC21M99+k85RI11O/fziHhM0GCK9S0DoAplNdBIXR+8EUIYHrkUp1xyuAyGlf5n0/80YRzOSwUcf8wotkMUjMm8XcWfvr1vZLCOrJ9i8PwjdfztX/5i4Dc6OlCcjnAQPTepo6oA2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzuui1fGEpZeBWgiAGK5GHT7A/lLvokbRAd6r9PBPWE=;
 b=Ck6aFnGQDN6doOWHAGb3CRj436/gTV6/RP4RGt5CYAMj/QDksz8CeHDLs9f+HFP/2puoCaxnBlhNEi+q9VB7dGXZyemXTKqD+OnJvngC2o9Gym61in+uyCfiKLdmHl4dTFLlBRRR/NPaLWuQ/OwupHY+F7BMqwwA0tDCEmvJGG0=
Received: from CH0P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::22)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 28 May
 2025 12:59:34 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::fb) by CH0P223CA0023.outlook.office365.com
 (2603:10b6:610:116::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 12:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 12:59:34 +0000
Received: from codemachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 07:59:32 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <Hawking.Zhang@amd.com>, <Likun.Gao@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable IFWI update support for PSPv14.0.3
Date: Wed, 28 May 2025 20:59:20 +0800
Message-ID: <20250528125920.492831-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: bce330c7-af15-4047-4aad-08dd9de77e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6wgc7mobl5DfcBIdaGlL6keC2P3yumD21/rkkUIWh+szswNZuQpOni4UXDY7?=
 =?us-ascii?Q?hMrfNgA2TSKP7UK5CkwZ2XdzLaBUprZJ2NNfdirIpy0a3HaCnrlFv3w/4YFd?=
 =?us-ascii?Q?JEF++nkM1Jpm+AXcQLW5iqKktFJZNe9/h1N0WyATqN14h8t78nWqDrp2NG29?=
 =?us-ascii?Q?2RhsgGvmMoUq1WHghoY8uBgRFIu3p/j0LHlwJ7UHLO5nMOTzBYtJvnVcuhdd?=
 =?us-ascii?Q?YWLZVMoXwAf5D2JIEuzRUO8viKKNPJwZqQmFbHuuYU7apnNIVlcagT55D2i7?=
 =?us-ascii?Q?vexYY4nltlZJ7jqk5Pm1g5insYtmMTNogLzQf5lzCtxe5RLBphcON+ICCDhe?=
 =?us-ascii?Q?nLsKhFnBPLDlYJGkdlxbM2sqSpNUD8SvultqLI4aMfectol3LtaIro0HW3t7?=
 =?us-ascii?Q?AR9L8yS3ya3Ck5KD0gNeNnP3rS+XS0IbFV8fyxPfBuZpM9ePBj7C2HJg1+de?=
 =?us-ascii?Q?5bswgoaKR82rtAcRvLyS7NS1hp//iC/7tqbCJq40rY5Dws1DZ6DZPhVxmfqy?=
 =?us-ascii?Q?3tizfce8JqfAiBqNUAKDP9GldTgG86Nem39WnhG7U4Oc/LBWMzx2e0CGpn0i?=
 =?us-ascii?Q?l4mjs0qpq+M9BOHA4IiQE1xNeGn2DybbYVA44oNPtLeztHNM2a58z7VwtNud?=
 =?us-ascii?Q?rSJIugt7P3vQ/+PmPfoFs0tCxx2UjizYSfTRWgLqvKyQzlIj07RkbcqcRt5B?=
 =?us-ascii?Q?XORLERG11VXDdChEf5lTLNVsmg8AflpixawXZrWStdZrqZNG+1O+SStOVVHI?=
 =?us-ascii?Q?QME9E/WyTVV+bRAscEMtZ/ZTGwvM+661ow15e8gmL0KRQ8LpoPxnTeduck9r?=
 =?us-ascii?Q?+mi2Kr0QPCtBzJQ/wM98w1BFhyOKjUA4HY18JKRMIGf2lE1pN4GItTzIDU7j?=
 =?us-ascii?Q?hOMIeUqIzEdnKYVEShG/IbdJWBi2KQPZLm4c6jxXPJkj7tYYQeuvp+/gkdEB?=
 =?us-ascii?Q?Wfr8Rwh1mllnv0ZG4tf0bmZk7kk/SMAdPcI0a6frKqH4N2Ou4KjZkR/TlkmH?=
 =?us-ascii?Q?xPkeuQTIoI7xMeBS+aSuoGYgrk+Sf84ZO4XE/BXI0yoLQYgPNy3dQTaV98Mg?=
 =?us-ascii?Q?wKXNTVQcOQRGFMN4HEPXLo2gtgaGxdHaAwRooHYwpOGEBI5lDnTt1T91uRys?=
 =?us-ascii?Q?fSdgtV6R6hqySH1xK+pxXAcRal86yWi9GBpUitAJ1buqsLfea/RNbig2IHNM?=
 =?us-ascii?Q?uLdoIl2S4dzTac1CIwSsDRjSOqiZu1Pwu1dyJIwCMvXPv+9jkqYA4pKaiAFP?=
 =?us-ascii?Q?vvUu/DHX22whjzypX/q/iNqN5Ris1z0QJ4Og+VmlRbnjWKrQI5FLoMgiJQCO?=
 =?us-ascii?Q?cgqFgxSdUis4D+XyNfVa+NLoVFTKHItQVcrFCYldF2DAnBrxFB9Zm3Cqupbh?=
 =?us-ascii?Q?dIpAsnq/TCfjo+8jcokHajo5F4WAl6khIDf3u9TaS8sHGq+Bj1n0HZ/w/GCV?=
 =?us-ascii?Q?OCNKd8hePTfQ+DFdttsmG7C71g2J1/0+qUn7Hu1NPu9KjCJxmmhuyEbqVOgm?=
 =?us-ascii?Q?gqTAk8hHkjY8nQc2Wd/borgJUbPSFd3p2awe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:59:34.0758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce330c7-af15-4047-4aad-08dd9de77e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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

Make the psp_vbflash and psp_vbflash_status available in sysfs.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dd37264f1ec9..c2f48e1fe964 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -251,7 +251,10 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp->boot_time_tmr = false;
 		break;
 	case IP_VERSION(14, 0, 2):
+		psp_v14_0_set_psp_funcs(psp);
+		break;
 	case IP_VERSION(14, 0, 3):
+		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
 		psp_v14_0_set_psp_funcs(psp);
 		break;
 	case IP_VERSION(14, 0, 5):
-- 
2.34.1

