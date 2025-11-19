Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E05FCF34C9
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F1D10E657;
	Wed, 19 Nov 2025 15:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p/XaSrjW";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010011.outbound.protection.outlook.com
 [52.101.193.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ECD410E657
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMdvcE0gLUqlVnNIZQxFMy/5wc17TebUnWJxlpptL8oMTrntv7PLBby60E7UCHRTpIr9KgMhoWrWxq8Fln6glKnP0sK1CcSZroFeHRDoHoQDCsG6pWOBJz8iSq/q7eGb8OHRF8pIeNkYtPgzQKINDKSl1MRWy+wCyktoVN6qC9MIC0IeeLbXzbGOF+u0JQfmWOdfsw06TiA9/m3q8q2oyEaxUAJ9mvenu/qgBHATIeBb6urmTk7ZjP/o2c55cfPoSo+VEl+XW/0YWnUYCNjt/0VO+9uXS5B/9CQYl2QBcvU4ecCdGz4sB9vIWHbtgmWSlfUG6Wz5+ERXOEnr31I/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuSstSxJbmLuTbFQCePNMIuQmz3P+iloo82hMNMtfVY=;
 b=R+BDyq/wEAe/Sj2u1mzY3J8xUzzV1G9LceRLfbspCGBTsIxvqQD5VaJphV+Qckx/y0yhostGgOZ/JDwGpwPimgv+v9wZSfzoZA7WhBEYWRPakqvOXjKEZm4myBli2CRlUtFeqDvAXcyTP14Vd01VyNzcEtfNpZlFoegYnLTr8azScEkJ7eu34bTMS6+hN7K7SO3BbrNHRE4Fw++Csb8SVVWEqvf9aWAS0O8bVg5gaWQZqiWp/qr5qlfuFH/t9KtzYyDctdY1gacHCBddKcOrRH0uRicAzHKfAibBpKRnrigm0Ze4hAFqZ3uTCrY6R++1Rw1yky5H42gRiM/AndWBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuSstSxJbmLuTbFQCePNMIuQmz3P+iloo82hMNMtfVY=;
 b=p/XaSrjWCuanIysptEaxKVbRNxhrLxjFXAYieLGviaK1Hi5r8yz/L0KYZI/UnyfUNA2a7aqMh50jg4z04PuO8dt1CJDmOqVSvjLuf9h+m9bcQ0GCKaleKQIAe/VlHHY+zu5/ev9G06Ffq1rJaGo9WudXOuKWM/SzFLLySweVjSs=
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 15:17:10 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::28) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 15:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:17:09 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:17:08 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix spelling in gmc9/10 code
Date: Wed, 19 Nov 2025 10:16:54 -0500
Message-ID: <20251119151654.3664461-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: c254a420-2042-4a4b-91ed-08de277eb582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n7hdgZzHJtG3EZiZjJ0ehRKSSQ2i1ZFQKOeyRrIDwHYrCtd6dwO3DweuHS9/?=
 =?us-ascii?Q?W7ULPXyGbp5uRMm7lUiJ05VLe3AcOsPN9Y8bJYwwc+EDaK9Pgp73M3GzyJH/?=
 =?us-ascii?Q?4tswtVETeDTcIp1Hj5+PT9hL2VrH/v/VZ7exKVWWGNGO6XMuCLMpJXoG6laA?=
 =?us-ascii?Q?OGWETe2KJM4+rQX36OIxg9Tc4jBoS37dxcOcz7hpqBviQxbKTrb/PNfnfsBM?=
 =?us-ascii?Q?rjMvMi444STxjzpuddLTBr9fYIwNjGg2RcDVfQZAAfmoeTkrhA6JlaL1+EUJ?=
 =?us-ascii?Q?d2wJtPeI9zATWMqstXDnJHqmIKCy06Qurm1e06A8L2aRI8fJMeg+JfjAk0OM?=
 =?us-ascii?Q?P7su1I4xVn0X9qGbqm3gxv/pSBfcPoI5rDRghRCCp/AsJqTwdJxEoAsIj2rQ?=
 =?us-ascii?Q?Tiq3g8gcWL9WAX+XazNQGGywtX8TTW0l9in/yI1EbFwctZTGt+qnhKYOeQ/q?=
 =?us-ascii?Q?uKc2qu4pZEbKFD/ufeubL+szRrNqXdvZ4YSnA7nvo9wLILQLToBC4ZyqLFqm?=
 =?us-ascii?Q?bkYtwuf9LjVdR4ESoXQrgVvF7CywCbWuAsCnaGJJ/tN+PdS7zG7g6JdQslJc?=
 =?us-ascii?Q?4PcKzCtHH5l7qJr0aOrn6zkfaC6s+3wHU3/8jjazD2CSBzL0djI1V0S4Aaow?=
 =?us-ascii?Q?10I+uWVKlkmQpHtGM512G9h/bmDNw+CA/pZERTVzxJmm3nnNZ624bDbnIHxT?=
 =?us-ascii?Q?PdNEAdSiIEjBzaS4rfXpgT4qyzBKJ1rdPxVMGtMlQZvLNiVIof8WsRk7hHWO?=
 =?us-ascii?Q?KeG5dzcebgvzFsXoQDpo3WZMCnYp5PEPFBNijvcKLNvFRWTQ/fra1z2k7LTc?=
 =?us-ascii?Q?gGzUBsMgaovFmyD32kmNZbBJ0a4zyDYZwZlmNbWpyDVxCo5b4HMqFvN6f+SI?=
 =?us-ascii?Q?5y0e+SN/aURK7mLE9f0l61MlgwtDJPixzWqdKcR4uyoA0yMoP8z7itV2Rdl+?=
 =?us-ascii?Q?5p6iptx48AMmXXfhTPs458uZ/iryT3WHsYzclvPnpu6Jkse8jBI4SYGIyMCj?=
 =?us-ascii?Q?Mmi1p3sygqvVeiDZzfdSrLXuaQdHiQgCKT+T1O8mb4VePDGxCkIoUWsH4qUq?=
 =?us-ascii?Q?+bjpfTC//5IavYSz9qxDBxcavG7XjCSBqC18DFcXCx3asLnA5SzPZeM8I2bv?=
 =?us-ascii?Q?J/5LV5I5R+4ZrDfbyvjCi4eKEBiZnl69wOqvWOQQ+s1riZpsWTrjZU2tpHNS?=
 =?us-ascii?Q?2j9VDCTznZ0l7Fl90FxK9BCWvv1/vnDvdODsd19NnplpSC13v7osrrnGr+Yl?=
 =?us-ascii?Q?PnrSK9IqL1zg13gxqDzTAZ5qElIRRLmkZiFHMCZgLmTZplNUSiCtRwxZcTKN?=
 =?us-ascii?Q?wZx0BqmrTzAnWA1Bg2ASkXMjmMubLqizxrJfTVu18VCTzwspgKEMh7LZ/RPo?=
 =?us-ascii?Q?8nNDnQb+i+aPvIskh6A1kvec0ut/Pv38+Du7E0NkIhT569F36cSHFvWZRcYx?=
 =?us-ascii?Q?/cilOkJMKNaSuehkKL9CpNSeCG4iIT18nD4SfeVQMwrnYmHAreskfBU5RoD3?=
 =?us-ascii?Q?N/O1JjrLnNMZyjC5gz2Z6wW8Ih3WoTFU8UTXBLeqeoiuf0xunO8U9J+HPmTF?=
 =?us-ascii?Q?TtoDdnCGjEVtoMRcDmM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:17:09.7348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c254a420-2042-4a4b-91ed-08de277eb582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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

onyl -> only

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ce6e04242c522..47558e572553a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -117,7 +117,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (retry_fault) {
 		/* Returning 1 here also prevents sending the IV to the KFD */
 
-		/* Process it onyl if it's the first fault for this address */
+		/* Process it only if it's the first fault for this address */
 		if (entry->ih != &adev->irq.ih_soft &&
 		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
 					     entry->timestamp))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8ad7519f7b581..778ad7ac6d086 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -600,7 +600,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			if (ret)
 				return 1;
 		} else {
-			/* Process it onyl if it's the first fault for this address */
+			/* Process it only if it's the first fault for this address */
 			if (entry->ih != &adev->irq.ih_soft &&
 			    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
 					     entry->timestamp))
-- 
2.51.1

