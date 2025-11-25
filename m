Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F1ED0E6FA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510B410E436;
	Tue, 25 Nov 2025 15:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nNdptMoS";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010054.outbound.protection.outlook.com
 [52.101.193.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0371510E430
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I74T3PGag19NTjJpveDgnkFM4vx4bCgGqm1PZ2nCePSxGIMNwAUmHD9KT1zplfmZZle5gKQCDRxp2dYyxgtxkoVVB8Jdz5NSUxKANFGkXasQN3stX241OcyYNDern1YvxeLEEPSFe7EIyYzPgEwRcP9p/VaZtq9J78jb3/B5zXR385QFGMBhJxppjxLZfllUGPThTUiq6fKuCSG1Ikn7ahUXUBcPu/N22qlfz5gNGhzg1GP3SAza78ZKXZOJRg0dpUKed4RMCp7cChy2fRYQ0LcpYPh47mCd9MAt7nqDqS66TMv60J0QkMK1rrMP4oORZfKVhSa1pzwZIhbH3MZZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7DVrlB4xDv7uOl9GN/hjNLCbnBFYVL2w+w7/FOBwqM=;
 b=oGtNhiJCXR+bfSHpj4MyThmqYxfqfF1zLu1MZFw2FzRkWDLCylPqZVSbP408IVvpMFSB3SIKkstyZa0z8gTV14lrPeSh35uGfE6xDaKZCmQYyZWFTeliGKwJFmVOa8x8ByWZG44PQejkCSgosNCF6ElQKljNnAZmYrlhFdG7o+Q7qixUA/rBTZyTLfM+kjC1oipZhD0beOMACC6oOJx0yoPiDaGJsFeFORwttDFBL+qwyoTU0iGkv55PlXtfJ1QAW9WmOLpvOh++mj2LyMmHssu67iMUiZ1wQ1WMuhugMmOcrGbQL3p4UwK2s/68TFsrgl28xwgX+bCEplV/hqAIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7DVrlB4xDv7uOl9GN/hjNLCbnBFYVL2w+w7/FOBwqM=;
 b=nNdptMoSxSrDRVHXy85An7uSPz3OM9re+B+azlkTCi8vFKzknaWF7+zeXAWvPvEICRcVk8XejEZKavfENn9/vq6dPRpBcE6AxwX75Drq7oph/Tfa9FnJKJCgc3dgeLQxmU7+q8iqWtg9tw+7sPlY9xFzFk5BhSPk3JQfRfBNR0g=
Received: from BN1PR10CA0005.namprd10.prod.outlook.com (2603:10b6:408:e0::10)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 25 Nov
 2025 15:08:32 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::8d) by BN1PR10CA0005.outlook.office365.com
 (2603:10b6:408:e0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 15:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:08:32 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:08:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Setup Atomics enable in TCP UTCL0 for GFX 12.1.0
Date: Tue, 25 Nov 2025 10:08:08 -0500
Message-ID: <20251125150812.2046438-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125150812.2046438-1-alexander.deucher@amd.com>
References: <20251125150812.2046438-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3e5d3d-40cb-42c9-b77c-08de2c347fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A3El8RgVbk292apHSsFYHhw22UQSS181fF8UfOWywl1WEDv+EVjAILvd1idG?=
 =?us-ascii?Q?JtgG+EDY64T7inYrHLQ22+z+8WHgzFAIfIkwm47hQz28U64SWVhyqGgFRAFc?=
 =?us-ascii?Q?39d7ncNaA5fdzXcQRkriYfUNJqHqxxYQ3KclY+pbHcRPSTrYttHEx3y9ZJKX?=
 =?us-ascii?Q?XhGXZuMGZAR1rIuttv44EnubmqYJfnaaq1hTAv31BXn4sXA3ZrrOGFyEVYMb?=
 =?us-ascii?Q?QABMc/LJWgkWDVSCwCgkHLn1w3P7dv9M+gMPcktkc8oFtGUG5zRwJ6pRp4MD?=
 =?us-ascii?Q?WClX+4Zhi1SUKKU45kwtYHUP7iUgSS+rT8rB+c6mv2XI77IOL4jkMS76MhwY?=
 =?us-ascii?Q?8+CYig9XRSl8sgwNk2w2MMrmnJuQOgPfRYLQT7ZynQbSh5J5loJK2trcKoqa?=
 =?us-ascii?Q?XfuQCNgfFXLOLbLFncp2wWZoRvVcLgwV7WCRjzgIjFInJTNYLhzKy/XoI28X?=
 =?us-ascii?Q?66kyMm5d11WYMrkirO+ep8yAJLv27HW0HIOPtHZvwnPExgoTcPxGvdJCSE7J?=
 =?us-ascii?Q?sYJTj9MMhKdqYnPT3oDeZggKWEEluMrNHmFRi1SFGHmnvTGuqPduoaag8Bwd?=
 =?us-ascii?Q?JvgXsejLOcVEA+1Gc0MxrDYR31YCjOaVElAtYjAksqNkJg80552j/sNbAkI4?=
 =?us-ascii?Q?u+FiLK513ra2ZP1an9NEe5LUkV4hsruo7CcWnNAL+E1qqyiFfCK9qWBFIk2p?=
 =?us-ascii?Q?OV91QKH+AaP6zoGr+JzelVL9Uy021TTz6mDz2FaMFw2k/HA530pCR1CR03at?=
 =?us-ascii?Q?G9YoBKw8vbtJH1nb+n0PCmR7UzS60tiWs7PkogMnmE8ROH5/lu5Dcbo1fCk9?=
 =?us-ascii?Q?IMvDx5dGtrMLYC4P04kmakWtB32I8saEWhWw2yQyQvO1O34eOJgnQiNdg+4q?=
 =?us-ascii?Q?vD2mJzFMjWDO5HXjgWceG2h92j68XYUfLRfnpXvOoU9lb3Ion5DVibs2inBV?=
 =?us-ascii?Q?IAyOmBfXDbSpSGFas4FJC0QH+FzdBTl52j8qGGkshJF80PkJt25hkwECCMUk?=
 =?us-ascii?Q?O7/Eh2fanw3uuy8y0o5jDH3LngLtzpQnvP7rwNbHER21rSiGUBbSMVuJmVwc?=
 =?us-ascii?Q?g8fEivTWtgQFn+tZsn6g3z1EnsqKZziAw4QgifK0jClWG7npq1eDaIdlof6G?=
 =?us-ascii?Q?+x0SSAQnOqGob4XUULikkQuh/UN6r8o1ThFEGWH0d9AHj26B8PMEgUCW3FDm?=
 =?us-ascii?Q?0oZt2VlD0pkptHDmNdjSRGyOCIyEpjNwdkSeDxempRTbns6WLyI1a+CSyrJg?=
 =?us-ascii?Q?MZrMwYGiK72iJdivXcG6oSPD3oK8wNsytHsmcxDDTogRfIIiAnBeLWpaGC91?=
 =?us-ascii?Q?LpzZm+UteVHDcSPT0dCBnfo5pPdwbwIXWxgUXB2K7986ySFHDrlui0rB0cSU?=
 =?us-ascii?Q?Y8hDOnh6maS41YD6cvphftTLk6e88vEgoGwOnHz+9TEYOGHXRi+a6pH5Y4Fs?=
 =?us-ascii?Q?utV5Oks6Rtrenum05cT7C2+K06lYSeHf3E/hCFV7q2LZ2w6Rp7dUW/XQj63g?=
 =?us-ascii?Q?nIUa2+UvRC+PJo4D09HkZSlBKI25r5VF9XfS2geZojoDlU0mxaIywgwGvHpL?=
 =?us-ascii?Q?2CjjVt9SueL/U5iuH+0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:32.4514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3e5d3d-40cb-42c9-b77c-08de2c347fa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

From: Mukul Joshi <mukul.joshi@amd.com>

We need to explicitly setup atomics enable in TCP UTCL0 to enable
PCIe atomics to host memory.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 607ec3bf80aa3..a7174da2741b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2521,6 +2521,12 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 				RETRY_FRAGMENT_THRESHOLD_UP_EN, 0x0);
 
 	WREG32_SOC15(GC, 0, regTCP_UTCL0_THRASHING_CTRL, val);
+
+	/* Set the TCP UTCL0 register to enable atomics */
+	val = RREG32_SOC15(GC, 0, regTCP_UTCL0_CNTL1);
+	val = REG_SET_FIELD(val, TCP_UTCL0_CNTL1, ATOMIC_REQUESTER_EN, 0x1);
+
+	WREG32_SOC15(GC, 0, regTCP_UTCL0_CNTL1, val);
 }
 
 static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
-- 
2.51.1

