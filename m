Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E37E6BF39
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 21:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7148310E39D;
	Fri, 30 Jan 2026 21:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="en4SyIHp";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8728810E39D
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 21:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8c0x4zhwRQWvYFnbXx0YdY6f3aOVF/FHBq0i3tObZdAD+z5EBtrY9mk/QttW3UK9gRPFT/JiAmB9Q+hpLnsoMUiy6gMS2pNoLsLxMY2ilmQPXqeNDZV9sxeobxwMgBLNqSUuJg0Bz97qtISLCGvfH6FsilJGyGv2iEt149dSZ7ocJpaB5st7Er2Am987bMARgFxFeZ/7wswKGNE7Edj9ZjjgjuBlYWaLp/ejQXjrJAZO6Scv5wNf5FYLEKFdbePSTdZJ26UgWVeYTVwLlz0VIIQOcnfx+Q5RQqSucaAKath8dCYJHUMEn/LeURCWf75JbnF/GJe+OYIZic2pfwqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zeEwETZ6spwYIcF1sdHoW60+N1YKe7H+eH7oya6sQY=;
 b=pJgsI/7eBAWxinrrpv17W6vpNUnhFdi0ph/NIYkjQusXkn+PH7KK0sUH0Zo9r9n2Ovti5dPfJxsNy5apRExq/nuBjam3i2yRdRew6T1DCaCcsl6gN30radbW36c726vdzhlTBulVAIR03udy8bz4LCWAmtWmqUW8ZMGcmSkBPbr0/u5BjFoXmwFXRh/v6q1Mq8QInEIQPqS2JTr9vygHViH2hxk5uaaq4MqvcpA5J7xUVJAF1o8sT4TT6asUYKRHi16ZQeEoC+27ibEZCxXgVYjGmEzUaJMjTSLzSjP1JnRwiI8L35iE4rEKYUKTrk3QCCpRxTRt6n9xOQdcgrVWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zeEwETZ6spwYIcF1sdHoW60+N1YKe7H+eH7oya6sQY=;
 b=en4SyIHphmqRqQnosuMsR7G95+uOf511CZxgGk5jECovPwnjYIcLy8TQLAJ8vgibbI2J3GEhHhz455cB7tfV+zBaRu6gF8Fonr/8mlZpmCVyJlJyMIc1j78g2X75Rb0UhmwjE+q4xAyA95nLsl7pH8PDLOw2S8sjxHH7RQlp8Yw=
Received: from SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::19)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 21:10:43 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::e4) by SA1P222CA0194.outlook.office365.com
 (2603:10b6:806:3c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.12 via Frontend Transport; Fri,
 30 Jan 2026 21:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 21:10:42 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 15:10:41 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is exceeded
 on init
Date: Fri, 30 Jan 2026 16:10:30 -0500
Message-ID: <20260130211031.446011-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130211031.446011-1-kent.russell@amd.com>
References: <20260130211031.446011-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b51a3cc-a0a2-4bfb-4a3d-08de604406ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6PucQy5R7Y97HFQP7ZBcpjaiWG6gyEkwxizhmxnhIeUmPAF+GeS/4OcbzkYQ?=
 =?us-ascii?Q?BwShSroJe+6lku/UpzirkeLaYaAOdm+eswxTT9DLBQxobTbTwDHIBHcMrTd6?=
 =?us-ascii?Q?g6/G3Jg1Q23Gu90zuabSAz2ucN0Pqfu49nrpykw/uUhTxE3lNxNofo59elTy?=
 =?us-ascii?Q?fyNJMkK4LM2S3W5MvW+FECOIHWBirTWDqSmVpyeQm92be+2rwX2CnHqiZ+IB?=
 =?us-ascii?Q?rsVA5f2qVGA1D/FJlw+yx7k1uMiTX2h4Ph/nqawxl1PnZCDmKqcq7iUHVBDu?=
 =?us-ascii?Q?3vb7TZVdxlDN/jp9vM7R6vc5d0R9vAsdfGYVEvu5WbMD1Nwe8HcF9Ym0jrxv?=
 =?us-ascii?Q?RYtRl1+tdezzr4kSAGfqCepEdhH9Wq9G+70ocgzobZgdGZqhDNCPZDOaU7AR?=
 =?us-ascii?Q?BF/OZwaNUgPZQqSgNa6WqAAsnpmY8a5xiSQdmvVTxHDwf6OZnusXF3CB/+F/?=
 =?us-ascii?Q?3AiRIevxVCsVHgQlvyGjllNUd8S+kBLc4TsS/QAj5vjjhQJiexrO/9QK4OFh?=
 =?us-ascii?Q?RLbsSWk/0LAQrQTne8B/MUtMHSU0/T8uCPJ2jH2JMP29nve4rX883eMA+wZ5?=
 =?us-ascii?Q?JCOVkyvMsD9k6nMtRk0aKXFYD/fvnDk4gnQ415kUDnyNJjTItIeTGQjStj5G?=
 =?us-ascii?Q?ElCy/lLTVaaAKHE36j6diCFKawZ21nI7lXULfzVRkuB2czraxP4b0s0vjIxb?=
 =?us-ascii?Q?VWb1PQmaQY/x1ES4QOmGw6aoD7yIJwZe6EPLvKAGqPWQFA/Ac3CFjjVqrrq1?=
 =?us-ascii?Q?pB2prouZNR/xgONNHemrZHDN+SuyaBetUznw9M4mg4ucIHoJVa/YQovfKKfL?=
 =?us-ascii?Q?AoBiM8e2qQU1U/mjEAWAzC8NJpH3ZjnK411yAN9bNWOyV8yLX2jySMGiiuXh?=
 =?us-ascii?Q?RJn9NHBg3SFAY/7/6UMC7Hjn4oPLRviM167aTur4lSGCFlJEid4nK0GaIRVw?=
 =?us-ascii?Q?Jf+M5Myc7gGaR3FZYML65Ui/H/EfBjnvhOjJ9yAongJRL+Jtol6KrLbppr4H?=
 =?us-ascii?Q?RzekNhjtVCQeODjVNqVY080smXODvXXyCQhCsLwznpdA+l8hyO85dnK7d1cs?=
 =?us-ascii?Q?tk6PItxJAeKyq2YmwfOfvrthKtaWiim/n7mgMlhHqvZfu4HXk0kFW3x/pQTZ?=
 =?us-ascii?Q?IceerFhTtcgG+dBf+Yzs6BnTK4PlFH3i6G1DrL61lSDEkpY6qfUrISx2KCcf?=
 =?us-ascii?Q?S2t/E925CZjpUFqhWn+5b2JceMJx/x7MP7T3lI89DblaTJpQlLgXzV07ZsUY?=
 =?us-ascii?Q?9oBPtCCP09A2jZUNXbJ6jJvHTbbNUFdYekuXN/HBkfJoQIo+a4vt00UMocFl?=
 =?us-ascii?Q?I/hBO8GAujvg9DdBb9lY6YV+dMoSLv0AgDm/X0bkATjOTqNZj1UnOnBgP67r?=
 =?us-ascii?Q?bcyoZeLXlSqOhNo+BEINVA09Cgyg74a/Qr5omBtBubbQgO8J3ca20iPiwNkX?=
 =?us-ascii?Q?lLhGaTv1saX9CfW5ybnRfVemQGKwYUVoNwivK5Lcecu26LInyooFhzql9BQI?=
 =?us-ascii?Q?ET4ZBzlcWf8wiAKRxLGGufJzN5C4b0XXJChRXvj/B9s8/qMGRBdYLCbSdTHq?=
 =?us-ascii?Q?CtE9b6kHTPBmP7GwCRvzTBZMIy2lxn74fZ9Fo9qL2ajyWxcxszKZvV6L0LMi?=
 =?us-ascii?Q?bmFiqq5EMBCrwH2TpXYHVWMuKepiBXu2OuY2MfgLE/k2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EvVnoT3anmdew7+gno/YK8r7DoyVruP+YNxHzVR+g64mL1L388lNeJdCDxYPerbJbwVrBPnb7l6TlTMQOx6wKG4a966e0mRqryvpH6Y8hXFW84fW/Mk7v/wz57OfEK2eULHpKH5E0o6j6P12GmBZcjHPF6WFFw/1/KDGLwWkpoa5MHgwPv+2tCXPpGSQTvt+MFK6XSyRjPGuHTUzWD3dMt1H73MdEDGu6hyFTgnTtAKvtB4mUZOcarhJZ6oJzVgVKB7CKZzkGk/OIbLAx7tss2X8B2QmmX6Q8r67+EWIw4ifjcaXJQUFUCtF8vgN1GzjrD07ZUSLT6S9nZXG+EUQQFkjaD/P+iFc+qX2dx/sz5oqJzAyWWryc/xonFYTMYRnNAYx28QIka87kzp5oTpwiEAYsyzs6awKp0xthEHN7aPkxdSRbxy75Pt3apMCRe4U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 21:10:42.2591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b51a3cc-a0a2-4bfb-4a3d-08de604406ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263
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

When we load the bad pages, send an in-band CPER if we have met or
exceeded the bad page threshold. This aligns with a previous patch where
we sent an out-of-band CPER for the same case

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 469d04a39d7d..dd7d837b52bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1715,6 +1715,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 		if (amdgpu_bad_page_threshold != 0 &&
 			control->ras_num_bad_pages >= ras->bad_page_cnt_threshold)
 			amdgpu_dpm_send_rma_reason(adev);
+		if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
+		    amdgpu_cper_generate_bp_threshold_record(adev))
+			dev_warn(adev->dev, "Failed to send in-band CPER for exceeding bad page threshold");
 
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
-- 
2.43.0

