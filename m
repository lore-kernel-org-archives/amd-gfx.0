Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C41CFA472
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 21:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA1810E237;
	Wed, 23 Oct 2024 21:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAc1R9uI";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9311C10E237
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 21:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2Liv8g3MvKHo9e2Nh4WZRyZarZqRbMiqsxleFWaOuz+utQAiYXXroh6xKEZUnEbrkjdaWYhY6+9p3euy3KFwVm/31kocktTCP+doREJhe983i/LdjvUFwpsr62IZ8vJobvEcgvgz9N1crHjslh1rgyOcsqJPMsVyxz/a2dhzPbIIcXgqvQIOa+3gzbH+ElaTwjZBrco8ROtHZiGRRm7aC2KOVBQUPr8bNA8vs6Q7/KOZoQR9e6xuWfDwrxNOgaaRL7Yjk3d26QCOGDF8ii0VzxVY20u7TEjEDtAD+wmjIaB07pVaSum5UNziXQ4bY+xMaB7QwWLaosy/lvLm3xUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pde46NAFSiOcBlSNxqkJvGJrXtG6VSMFx7AI97T1+Cs=;
 b=hPKOw3pwntDY5/OmCMS8Rm2zc4+Mxn+ymi9H7cvK915IExj76q3wMt8+m61FgU3QQp0n8qz9qo6+BK1AWm/Ib2GQ93Hvi55zDRHKUmuTsfTZ+Ip2Y8C5Z5y6qcy8mFlRmQ6b8QbvVRXb3Hpx9OS1+ZQLQ7Rarur/4Z9nOngZVj58PLk494W62V8ZIsNBFYsrIhKI8YQSRD416JA6kuanRVIajNF/uSkV/eAvxo5AUhWLJwOGrjPz5k3jYKIy+Gl847RpIHOvQqegyH1BGWlan3nThfUiiI6lSc54Lc0nCZFFXSB8a1Ms8Zxc+mIG+GhXeecuEMgEWVX+RTvIv3UsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pde46NAFSiOcBlSNxqkJvGJrXtG6VSMFx7AI97T1+Cs=;
 b=pAc1R9uIIbXgr0CsOvBuR3XHddIVXb/qxipjvGE/RrFp6OL6rhN1k27vBwlQ9n+bWt4ZoNQf0IrR6TfuB7PiKplelaM4Kb3yus+PlXRLdptNF0MXGrjiXfyqZfsQDnkkw4WMzps5KEwbK4ZvEN0JlEh//bv6QjOoLPSfP0g3fRs=
Received: from BN7PR06CA0061.namprd06.prod.outlook.com (2603:10b6:408:34::38)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:03:57 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::78) by BN7PR06CA0061.outlook.office365.com
 (2603:10b6:408:34::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 21:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 21:03:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 16:03:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access permissions
Date: Wed, 23 Oct 2024 17:03:40 -0400
Message-ID: <20241023210342.685808-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5a3ee3-b795-4cc8-cf03-08dcf3a635dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o8Zi8d62ovLMbIvCfNzFAD4VTS34+9pOJdypXbcklkPBHfWwTRT4WYq2tH+q?=
 =?us-ascii?Q?HWrRf0K19eiws3MQm3qjsKkNr0+KeVeHpnqNbg+XNedglsMyMdJqy4vmMvu7?=
 =?us-ascii?Q?sSYQZs58V0MUzSC6iAaV+Q3wxSMCNfcQWX24AK+goQvZpYnv0sHSaAnQuq0q?=
 =?us-ascii?Q?V8vFnhrfvaCw5vy3S4I5JfK3s++lJmveBCb5dZiT2woB6NbtJz24No+7oF/q?=
 =?us-ascii?Q?+YcZzs32ZquuLFgIWcC7cFuGw2lEXIH0WUoH+yRRe73lIeEBO6PaeATAyknz?=
 =?us-ascii?Q?2N035mfqx60M9vosh3C6CJJNCdQ9yiP2EaFmLcmt+tbuSoDicVx6bfjFtvnb?=
 =?us-ascii?Q?QIm3Je6+P76ZIBS9IQrjNiZnZX2esiP9845wiaEeDNu1tRLXb+GbtlaTsBm+?=
 =?us-ascii?Q?6GQBh59lOpXkSBIfZJtE34iwrd/Hhj8+l48bTp1rSKRnyLP+9RtU1VqmuhMk?=
 =?us-ascii?Q?DKuavxfdJ3YstlOSRsepu45sQwVJWyTBQRAOcXw+VGM7AA913S0OTgHvh/79?=
 =?us-ascii?Q?sMi18C8kkCH8UCQCupldBRKbQ71AaPWaASUixI1cnBl77BBOPUGLgeyTFPhr?=
 =?us-ascii?Q?AQqCuntwjE2R8BtVwmfF2MwN25PhL/mS/51LFXm8b8xhIqYCBtdfQF4bNAkM?=
 =?us-ascii?Q?wZo76KE+uh+EOoGmrBTVABTaKZYws+IkpRLazxtMKamvlLtp2oBkD+qeXsQM?=
 =?us-ascii?Q?2vWnVqfep7zrB5NtDNWtAcKZZbadVZLWpUjTnxBAIZ2TqPpPDDXii7ER4Oye?=
 =?us-ascii?Q?vn3zFH9018z4ifWf7TsoeIZwQujvskycOOg4iU0yiVvdYZyt1DFzP4weihcw?=
 =?us-ascii?Q?doEIGPgIj3nERQkvFV+zbSjXZorD4cIcO4dT8EiowfnKkOmPvtHuYHgExllY?=
 =?us-ascii?Q?zIGGSF2srKcrq3ECUIsMFlsHAceUkxluyHd/SZtkzClU7/4RvjWRC5GFxeUY?=
 =?us-ascii?Q?GCJqwP+XPqRHQ+7rfm2MlCZGHhHk3DrXYisGiZmD4Ufhb2TfUEll39kcbSpC?=
 =?us-ascii?Q?pDhQi/+Mza4l+e3KEA3UWEGiKzKfMerFVJjAGWpGrcLQwndP3veWWIB2dU5O?=
 =?us-ascii?Q?ua5abNHBPbHdY5PZATxRJj3sbXzSWXW+jRn3mps33XIbHLcZ3uQVg1v9nA3p?=
 =?us-ascii?Q?qiB1DmjuzMtUkBZCqpbaQfBS94maq9CehT5m3Zx5+47RZwJq5/lMScpijT0X?=
 =?us-ascii?Q?5JROrpfm9p1P9/OPcRvzensDZKu2etEZUP3RcdrYfJ2QZofF4Hu+KwgqSb5v?=
 =?us-ascii?Q?JI0YZM8iYJ0Hu1z9wen/cP2cgYvdopn+b6i+nPEkUu6X2t15qnWsxoaUXRnT?=
 =?us-ascii?Q?SXf6/4DoOpMAr9QmxiQHH3/WWlmk8GSYDGyNyCX8HeMaByTgoInLp5VlSxrt?=
 =?us-ascii?Q?T1DzcG4/kkb1MS/LqDaLMGEjhSZFImoeiB7lL0m9HTCv1X/ljw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:03:57.2992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5a3ee3-b795-4cc8-cf03-08dcf3a635dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

Regular users shouldn't have read access.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 6e6092916d4e..e44a44405266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1654,7 +1654,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
 		ent = debugfs_create_file(debugfs_regs_names[i],
-					  S_IFREG | 0444, root,
+					  S_IFREG | 0400, root,
 					  adev, debugfs_regs[i]);
 		if (!i && !IS_ERR_OR_NULL(ent))
 			i_size_write(ent->d_inode, adev->rmmio_size);
-- 
2.46.2

