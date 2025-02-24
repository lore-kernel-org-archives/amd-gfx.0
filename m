Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117B1C021A6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B93A710E057;
	Mon, 24 Feb 2025 13:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D5HCUbDl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2ACC10E057
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 13:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnrGPq/7ev6IhMqlp2CFaq8p0//EK1VDOVk4LwNZ6ZiDTMJI+ST04IkQr7Bn5VgyPl9XtvCovYv8gggC9aic/cLTY7BPra3a7cbE2YNJlnCYgGNbWADjW+gZhTrQw894fpopQCsvNH98JXe2WpKgP1hgvGknDiz3hmtf+v5fE3UGPScmZjdDPM78ZVjnBqeAYB9eJmed24e6+xI/O4y4juVYELCv+4CW6ofRTVwlifCzdaN6MkAk+TSs3z19nHX3G9WSus94+6rN9aNT5LOo0mmr+X0RQ7w/Qv1/R9yHzHnx0joO8He9T4DjHO0jmGRNPpB+3Wb2tLOFLedHkC86GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2r8Ji/PP2sYVGfOhTaln5BCNGhxFjieFCovZNVQi4Q=;
 b=b9DlZpKxvKkgGJbZukmFi6+GyHYzPynAof4sYyBrs385SsNf0Q8/YXp+cGwBq4FWfrOzU344CzJLtLglo1QFtU9I9b4gfmVDjEOOCFvHYBcvyLJSR/ZC8T8oCEJWv23PRpW82qKetJrXicQ/sk/IZbXiC0UBNFGiTElfJwgeML2Z7XdKY9y7KsWpIA3C6V6NOOCq3ej9Jqfp3EjfhEEI8yOk+/LPsjFVWErOnWBK9zYH1/DGJWmLncwEKYp2anQCjBiTTh1d8kylIW/fcCJP6o2PGQV4feytPabTDa/73s6krTi87KjgZ8bfW1mElaYpy4zI9nP6WPPj5KYTBn6siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2r8Ji/PP2sYVGfOhTaln5BCNGhxFjieFCovZNVQi4Q=;
 b=D5HCUbDl1DMLJtGJX40Wo0/BG34egk6SLAhwTRBI45EwU0EsqkgG8HT52lDWSUw2M1/0s591UXqj2+e2zVm2tLH4dzaCzjxz6rUtkNQC+Mf/FHf8i3X5r3pjLTX5WpSKaFTaGKFOnPW9Bj+q0DM0Y+Sk4291OdsWZeN7qehv0ok=
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 13:15:10 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::45) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 13:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 13:15:10 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 07:14:53 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, <andy.dong@amd.com>, "Xiang
 Liu" <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Check if CPER enabled when generating CPER
Date: Mon, 24 Feb 2025 21:14:09 +0800
Message-ID: <20250224131409.26433-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e73980-31f3-4b3c-136b-08dd54d54442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ux+Vst7OLi6QXsH6EmjY/tdN4nkXb/kNR+pOADMHM1pdXwuRXQQGcfSu4gEm?=
 =?us-ascii?Q?PNyJgox9t+DFtUAfwIE2ACECSp5a4+3J7ujUsRbQSjds7tBcPYR8DCB7zg/d?=
 =?us-ascii?Q?pHx5tk59VV7RwiV5PJYuWiTgwPx7PFXNA9BW7lbRrH+41m9gE3FyqdM2Nw1h?=
 =?us-ascii?Q?9k3EugTmNOQ5Vz07RFWAuuf52GQx4VUDf6GrLIkPOw7ZbMqJq5uNydaAgPfq?=
 =?us-ascii?Q?s6pGCxSzpORCMIbmNjQzmpKQ6pYjxfhKEKDSdQNp/HOFjEnLdC4G1QXq7aCF?=
 =?us-ascii?Q?U2w2HBJP+rjpFtNry6X1RxUzT7Zi8+PZNv1J86TqiaHce06l1HjjJGKV2H/j?=
 =?us-ascii?Q?4C/r1iO1bId8LxUabKqpUYLXzDk9fuYSD/IFWCJcFmp3fvB2YHslY66eMkB3?=
 =?us-ascii?Q?yLy+V75hjDG/1Nd5DLsAoyjl8smYDjBUKkf5vU6y2HIjYr6XDUwOdRkS6uXw?=
 =?us-ascii?Q?r+oH66QIwEbz5i6t17IZzE6u4PSn8cHrFESfoiOhYNlWOTQirg8IlqJFaON8?=
 =?us-ascii?Q?sDvQswS2GcNPy0RVs9KJCbvC1h7EpULdjsW8gZj8xy5TN9jL60Z6OFItwzqv?=
 =?us-ascii?Q?+Ewpap+p2cCEN7va1XNxtc4BUjIg/JyctUuXLJdhVRx1Fa7gjvasJQtVQ5EY?=
 =?us-ascii?Q?XsTlNs/MBLV/lL5iMlUns9Zblbbvnm5pFRqZqoITPpu+5BMR1yX74597Rf8j?=
 =?us-ascii?Q?MxSSdslNlUMHZ/b77IwdbVqKu6lCw38a62EW7PYbN1fyzfWXF5fcREPA/dFW?=
 =?us-ascii?Q?x6/Ie03hOcAR0fQq7QTLdqlZLcK6eslMEQMcq3OhVWUAweI2H2bX/hqHz96O?=
 =?us-ascii?Q?SpULG3+LRz+Jr6Vdcnqe3hAO8O7zTExztZ0OSXKpI3IInTgmewbN1ZeNzYSE?=
 =?us-ascii?Q?2hb5ikMKo0r2zQkpNUs6QljQ3PXjqe3CB6LOsGZ6AOD6t/oCsmwe49jwJ5ky?=
 =?us-ascii?Q?upKtFd9W32W2Dd286MTe540mCcNX3c2B/Gz/0hQwdKCrTebJNAxtZ+gyx5Ag?=
 =?us-ascii?Q?1byfyxqK43j7dJXK4W6RzUkMZQvLz8Kbf0adSMrLJVylWo9Jdo21zalTpw25?=
 =?us-ascii?Q?uvADStOWKmyPyWojCdpv/+wL8YuDq+sCXQUenBNkxQ9Fm1qI/tYKrnNQoDME?=
 =?us-ascii?Q?JZCLbH5i+iu8qzrk5ZsS5b+pJ5sQtdYITQ22ktOEKK+UdrNKcBLctghXTrZY?=
 =?us-ascii?Q?0WCq9SDaehfcBsnCm1kLSzVHF/MvD+gXzFIX7euAsDXP5Zez9cLIpiyHaFx/?=
 =?us-ascii?Q?4CsdfzkQR9eM1kQTj0kp4iRM5XbKYP55ylbw4/MFny9g6teGdMedH07bOsNN?=
 =?us-ascii?Q?7kKP0OZmZ74g8Vqytta4z705cJZU04hISdIpoanY72Z0w0PzZmkYIcV1omZk?=
 =?us-ascii?Q?zf6OFoy4criw8c6Q/TzJjETLpUCnvPclk4beVqzbbf7xyP6xtOnf94Bt8IXD?=
 =?us-ascii?Q?8q1q/ghhx2wJiv2FfRORyvz4SYmoEjzIoXoMJfAH0L/X6qZ92vd2sQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 13:15:10.5645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e73980-31f3-4b3c-136b-08dd54d54442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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

In the case of CPER disabled, generating CPER will cause kernel NULL
pointer dereference without checking.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 3 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index d11593cd1922..ffd4c64e123c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -392,6 +392,9 @@ static void aca_banks_generate_cper(struct amdgpu_device *adev,
 	struct aca_bank_node *node;
 	struct aca_bank *bank;
 
+	if (!adev->cper.enabled)
+		return;
+
 	if (!banks || !count) {
 		dev_warn(adev->dev, "fail to generate cper records\n");
 		return;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 7c4ff12269d9..81e9b443ca0a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -716,8 +716,9 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	ret = smu_send_rma_reason(smu);
 	mutex_unlock(&adev->pm.mutex);
 
-	if (amdgpu_cper_generate_bp_threshold_record(adev))
-		dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
+	if (adev->cper.enabled)
+		if (amdgpu_cper_generate_bp_threshold_record(adev))
+			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
 
 	return ret;
 }
-- 
2.34.1

