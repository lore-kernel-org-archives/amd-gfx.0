Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16035C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 03:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE8110E22F;
	Tue,  5 Aug 2025 03:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0kdxxoxH";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB82010E22F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 03:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAhIHtdLPMTvm8qECI+k6TLkLyyAThvf3ieH21JjpxoASfd/SHRNjvyEUqZpXSocKWzuXb/UgMHIO7JDBCsQ1C+g5/5gTGwzqYim051CfHA4DLniFQ5SOD3ZL1UXoxXv5RXwbAKt54z2BJBDTkgBU2UdrXn2rT6NmxyOo/ANU8YipVLtuCMFJhMG9GJT9gnb7e9ZLjk3gr3hBz4NTk0GsgzHDNL/EJwKN/95TUXLftupxbB2KmZDHRfRqqS1m8mnMwWLO830ZzgvtlxtGlNLiq01j11cK2FTZyWrAdcnzvMUkB3WPKqqS3dhdp1sISJme1VDRVecZBru3wc+XANPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYbWKyAUXglGmYLoeQ3Hd85LyRtfxX/zY3z4OvF50vE=;
 b=QBgYzmMCaBPzv+EE1paSUnwhmF2xndFlVma7IlChjH6lsXBKhhIMcSF9YrwUI/wtayeWtzeuoqiBflwCyGSGD5c+P2jLRQbK++Pc+CC0RmkNzT5twvXr+5Sudj56Evn0VS4zLzc+FJswflmd9nru0K+2yiSQveRvK7fIFCfWRPgezFMJXMP4BaCl9GF2I3SHkQB24YHeAj9kljsNydxeq1z2lQqXRstPuvpUjHk0OPPiJAY3mCcmX76YJhf9KSibDatTnBlzXIRgInsq9XGr45i+m07D0Ng5nfwhOZIp1G7CRe2/AfVFfVqyAQ3CI6jRZ1Xm+V2gCeDFay5MX7Ajgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYbWKyAUXglGmYLoeQ3Hd85LyRtfxX/zY3z4OvF50vE=;
 b=0kdxxoxHhBagW6TFGCh5VjGDlU0BPyTSEEctTnxjUj26Mc2KVsU0LLH5Gt3iEX9PCGTI93gugklcGxbDGW0L3A5E7+detfmIp6Dw058U3dUBQnlTDWQDjcvXkR2EKDAuHDt+vhvtVBh+WA9KdX20YTEd5en0jLXCYrFJnRQmYwU=
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 03:44:29 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::8a) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 03:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 03:44:28 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 22:44:27 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Generate BP threshold exceed CPER once threshold
 exceeded
Date: Tue, 5 Aug 2025 11:44:13 +0800
Message-ID: <20250805034413.102087-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: aafcd64f-02ea-408c-f8b3-08ddd3d2615d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D1tLZwoe8HcYiwQU+AEJt3Nr91BqjxYeoQ5dDqzhe8ApKXlABsOiEXyf9+ya?=
 =?us-ascii?Q?8u1Wo7ja/NiA2vMDM14dvkdEZ2ksZ3R0RaY5Qczz1INFusGQKSvy4ciqpXM+?=
 =?us-ascii?Q?waILOt9rSb2cMBXfRMXq/WIsBjPHQQolSChYf0M/NQ/WnSJin1XoD2upxP5Y?=
 =?us-ascii?Q?wu6LPZP6+j7Y550TBgxmV2zq86oc+WYcsrezh40gJYUxWU0mF97e4M5hj/TH?=
 =?us-ascii?Q?3nGmz+XnUw04bEHH7Rs3Tkcyn28oILUzagi9JUcYYj8NgLD+oDJET+QLwL96?=
 =?us-ascii?Q?Z/LQ46up6YIFNeKlmgZWrdsSU9OqEu70MTnH+qSYnWUn9yTSaSNNZYoBB4Sc?=
 =?us-ascii?Q?DywIAAmIboVaCJ330Bv4JOSwzIJ04Nr/6o0R23JX+cBAWfRUfbfb+6Va2q7p?=
 =?us-ascii?Q?fSxGYpso9Q9ovPeAdqvC5K817z2KzmeUA90pJOzXIUfPDHwL527PGdw3gqid?=
 =?us-ascii?Q?yEEtVXzdkmpLB7rVIVc+gHi9QwQQHkO8vjdI/hHw8cN9EWmZTfY/6hSYkxeQ?=
 =?us-ascii?Q?+wvidTWPZ6pltRmV/mNVGTUOuYEZPvT9ziWYkDu2kwQnBTaXX5md/dn2illU?=
 =?us-ascii?Q?93zQKBegbqokzoid9OjHUKhUByj/JBK4T5L3c93kJUgQqIVSYyPtSsYZl8fs?=
 =?us-ascii?Q?EjuMZ2nmUAXclGqoLWwarUqbuCWVtpO68EFvMt83CiLIj7wewH8yfC7b/Ukc?=
 =?us-ascii?Q?JgBXkl5WfuToipqAIJVEZMZ9Y+8z9/4zxIkGghl8GNEj0PP5GmZ3lAVjrwPG?=
 =?us-ascii?Q?VLKmscUy13ZKSNgmWb+JWPj8ewS6d3RZdJ4kiD5xzuAqtY0TKLBTjeU0ktE+?=
 =?us-ascii?Q?/qJY3im64WQcXrfqYrjGbFmMhJIISt7SG9Gtr8H4v+3jHnkY+70Q1kA2yh3A?=
 =?us-ascii?Q?ORDUcIwMsJZ39RZcuh/akIr/kx5AvHwun8/glloMZivDghV5w6jYXG+PgCo9?=
 =?us-ascii?Q?hiZQdK15ZaDjJiPFfwrqiYa913LgoqxCefJyAsGKKyeaA0gp/bFlPhngIe3T?=
 =?us-ascii?Q?6imZmIs6m2SNDhlLr/pcO041133aOFUVecAfCeqF4fF/awFSvgk4rOgPBD3o?=
 =?us-ascii?Q?YU0QIWh88HSddCzHsUaNdKWxqZlE/ytQ78j+KHuYimDOFIhLL3w0zye19KFY?=
 =?us-ascii?Q?9gJTtteoU1dM0P0wfWSfHykT41pdaO/CWTpPzM6DVYyT24u6Na8AFLz3quod?=
 =?us-ascii?Q?I6hh2tpnJrLcvQg9pjLr6nu6CYHbXlZzUR6bLaWPtOYe/NMb3WYbifWSswyd?=
 =?us-ascii?Q?GzEZZJ67ApeQ5hynu5nEen9gJaYRgt8XXyTDdHDp/VPPcqoavcbg56StcEGV?=
 =?us-ascii?Q?lGhRqMc/MrvwX26mcUmyrb9HEczt5qTv65HGly0gfzhgUZ6Y9xUhJEtLffIs?=
 =?us-ascii?Q?lt8rADBh9+pvK8r4rGlWKpcbJvTIyMMPvKEAaAJ104AQQxzIX9CAc25/fW4X?=
 =?us-ascii?Q?UdzarVr8afZwIuM3tZwElwetRQkgzPp4j88HApl6L8tbJ+ToTVuTl00niTOL?=
 =?us-ascii?Q?Q4y3bnnDnAXZ/wEzK4rw0ajRqMXbqcxNuzea?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 03:44:28.6085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aafcd64f-02ea-408c-f8b3-08ddd3d2615d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

The bad pages threshold exceed CPER should be generated once threshold
exceeded, no matter the bad_page_threshold setted or not.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index b66e09ad0cc9..e3d7071b5853 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -763,6 +763,10 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		dev_warn(adev->dev,
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
+
+		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
+			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
+
 		if ((amdgpu_bad_page_threshold != -1) &&
 		    (amdgpu_bad_page_threshold != -2)) {
 			control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0d94cc04e322..607e3048eacb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -764,10 +764,6 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	ret = smu_send_rma_reason(smu);
 	mutex_unlock(&adev->pm.mutex);
 
-	if (adev->cper.enabled)
-		if (amdgpu_cper_generate_bp_threshold_record(adev))
-			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
-
 	return ret;
 }
 
-- 
2.34.1

