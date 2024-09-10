Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8237ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 08:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FED610E507;
	Tue, 10 Sep 2024 08:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="361pB6MF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C132510E507
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 08:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2qizwmOUUXz/cn4EJSTNEMJKv2D6z9nU9G99NSWKK0m+iV42nipObfGQFr7nMc0tEQjWlnZnsoMthVENjz5mFQeXBoY4JkdB6eFMNU6/vg4geLAKHJZXfoTuhKEy0ezO0jmOxpNJWwMk1zv7WmhLRTI+ryZCvKa1qPKTEJuV1tU/M/mP5gGIGPqAHL05HkU6UWqSCNkntXBWbvKEWG8ZPKPf3fnT0lrtvhbQI3aSUanADjO0OSX7z1nnSfqYQYeXYw/1cBoOpTiYE+vp+s6tOW7WsPpMiIw3nbcwnhGmbGajTIX1ptatmMPitcrS4n7ydM1vwfB2i0C6LghCwqL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vtn7p3ELMT2ydBiSV7BRR6gOxxwxwVIbXvJrm/jeNZM=;
 b=Rp1+P/4fhyOjNCVoUMqeAHIljuyVRcDTrwvKpF9jruhwYB7ASI/Zs3vzONOO99td1GZoql6yTEuILOh20mdqNuUq8B4FvAVd1HztBNCAs1YYIaqt/3sYLjJ6oDbIhBMW+ZShaoBhr1O84L3/ztSKf3sIdHwuIGDDJMTkI1vWD1s1rScGFAdQmbO8+8jvIrfR0eo4ALYIJDhi0ZzRG4Q2thSRTTeJJRxt41SBdrNirLVWXgR98oy739vLOyk7RlnWARe+og1o4xEAsunt/vvL4B5NdqObOcZwLwyxENH4jAbQO3YPnqcvb2scQB/38q3JmR8nMUOP/AaANgw8Ab//VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vtn7p3ELMT2ydBiSV7BRR6gOxxwxwVIbXvJrm/jeNZM=;
 b=361pB6MFRjpyf5Sh6MJ2eeeItcInIElbmyqhYqUN75Ah3EkqFvAb58zJWzb6wUt1ch7rdIAQ6OEfsn4PsguNFf0k+xPlUin3DMISoNFZQmyw+ETfYYJ90g0ZQkkPgmvrbH7EaYl3XqkGd/cwTFLmdOcc6ZjDdOA38VNIbqQe+6Q=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 08:37:50 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::9c) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Tue, 10 Sep 2024 08:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Tue, 10 Sep 2024 08:37:50 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 03:37:48 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific ASIC
Date: Tue, 10 Sep 2024 16:37:39 +0800
Message-ID: <20240910083739.20813-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: e0910f6a-1968-4e29-d79a-08dcd173dae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IeM9DkgsQkCXCP+b7cT+QYBxICH0sWf5Mei31S1bhOaFSkOUWzW8QG/bUNzK?=
 =?us-ascii?Q?GriMs1fQW4kUrjzKOSQBdh12cyWzAAfq7had5Lkao2aJuJrxEYd7LUOCZxHu?=
 =?us-ascii?Q?NGr3VFdwy49nduFZE4EQvXdGM46bJTg8ai+cQ/OXi7qIFByVJS6S3/+2ZFZ+?=
 =?us-ascii?Q?YShdfK4wQXPWPgSArMW56mWnXJrMYdc+O70z3rMqB+5d58fOoTGseuyUH3KL?=
 =?us-ascii?Q?YMPj3NKnplGnauuIEDUkPoAowDkQdd2YXVqZrjWLW77QY3YmpuHIAA+VommL?=
 =?us-ascii?Q?EY19U988Z0bVulBAo2G2hOKmM2SiR6X66XCuxdMB9l1pmfRfJV4QiLjlwYAJ?=
 =?us-ascii?Q?P1fyTCD+jmwXOq7avhIkb7pynMuEa3RXAAwR9IZVE6gTsqCrnnob3XTjQ6ja?=
 =?us-ascii?Q?FMS0+soafMB2E7r+OaD+pxdHgjKYQ9N3YfPsu/hIQUgv8mP5w/1CyRtFsMY6?=
 =?us-ascii?Q?rEo7NzDJ8AlT0FdPx+/R3uK5oT1L+CgFjpGYBx5sGiG082wkbDG+QZMWmTQO?=
 =?us-ascii?Q?7vyTPDXleTsBv+M5ZNsVd8DoOG5y/NnpO8m49RPh1gCjEDn/b2DlDmBs4ukY?=
 =?us-ascii?Q?so9wPpZDsU8Xf6Mcsxg6fBlQ8bwN/tWQFSgY/NjYOPLQPDVeGWGcZhwQZFNa?=
 =?us-ascii?Q?tqFOa6iHBEivJs0JXFSo06yJAevWD5QFbGzSaB4s0f3T20t2PX9hKpTuuLmr?=
 =?us-ascii?Q?AUZwfplu0sZetU03ZwJLiFEryHEn/GOhJJF4wIWh+OpoCRrmfHTFwZ/S+vvV?=
 =?us-ascii?Q?ECoGAgCOlMf0scNbCYUlj9ZA0ITC7vBJ4Sh2OV2PqI0J3qOXCOPy/9vfBK34?=
 =?us-ascii?Q?h/BbZtzBltIAdKh+8Epg5qkg7IlWUYcRaJaJaXUrnChfpHbOs1Yy8EqcKsl0?=
 =?us-ascii?Q?gF4DR/twVnTzvdf/gPwDUCefUFeiO1P7/UF7fnkIBBI8Q6f89vfXwHrYQEH3?=
 =?us-ascii?Q?3aLi0D6aTKAMBFDilavfqo36ro7tAQuxkD+D5nPTxTRdMshp74wXYsSg04L5?=
 =?us-ascii?Q?1tX/M0l/t3NyirDx+4MG1YTJky5cbe38O9GWnoOaEGqIMcgK5LrJ/Ea7SJL1?=
 =?us-ascii?Q?WhKe3Qry92zV58IQmFFMYeOkqtLij14XK0xM79qdYgSgbGrDyGjg2Uq2EVPm?=
 =?us-ascii?Q?XVIOk//VDC5o/xKi31Qe6Olpvib0hF/EVj2nYC3hJaqdA7nhIxIt4vu1ASmW?=
 =?us-ascii?Q?SAJR59d5qLb2SurNH/wfFkTCIs4fVAAqm0cvswQrqCPHJxNMRPnuRCP++NRp?=
 =?us-ascii?Q?J8PkO0/OZjVP96nbZQWfgDR2X/viKUVfrPb+Q7ErMTLWIhPAKtGsAbQCiGqf?=
 =?us-ascii?Q?GMKNIBR5ntcxOlEnxoqbj6LunJ8+1wwA1kTlyAJrRxh2onizwInp8+JW8TzM?=
 =?us-ascii?Q?KTli38tlGBFq19svTrP8upujhshnTzTJHmAp6XadK3kWihop5iIgJETGy9oP?=
 =?us-ascii?Q?hp+TAAHLK/w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 08:37:50.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0910f6a-1968-4e29-d79a-08dcd173dae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
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

The feature is not applicable to specific app platform.

v2: update the disablement condition and commit description
v3: move the setting to amdgpu_ras_check_supported

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..ebe3e8f01fe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3483,6 +3483,11 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 
 	/* aca is disabled by default */
 	adev->aca.is_enabled = false;
+
+	/* bad page feature is not applicable to specific app platform */
+	if (adev->gmc.is_app_apu &&
+	    amdgpu_ip_version(adev, UMC_HWIP, 0) == IP_VERSION(12, 0, 0))
+		amdgpu_bad_page_threshold = 0;
 }
 
 static void amdgpu_ras_counte_dw(struct work_struct *work)
-- 
2.34.1

