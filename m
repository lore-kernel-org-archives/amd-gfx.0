Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472D7C71150
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 03:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2B810E097;
	Fri, 13 Jun 2025 03:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2IV6IPsg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE46510E097
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 03:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPyO9z19ilyNF/kgBWFMfKOV/bgXuW42VlYr1RfhvKyqHPPHFAbzYbrKklXq9McEMdORJvV+RUjyBk2nJ9SkhLgnbzIKWmkN/UsJTLsWOpZsVuem7XYZK4nK4uxY+lCSCqMVbSVgFPWAWAOqCxZGJwyjWC/Ki+0zcIlVfA5/SW+dj/rAaWRdsA/lwyAD12Gua90rLf7oRIfeP9GNPxn6DGHguxwARjCRwJTWinTzJpJYsqNsmG2sGISRT8bTqe0ebI61NsxsN0TrT6bMeLfItN+FXABDwr1oSkqBhw9yT5PwBTLdHJhRCXRkrynG26VyGKwuXnKm5hDAaFBIbYScXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ61Qj4a+Awyr7b0p4sUXaKQAIfbzBgev+tflI99APU=;
 b=URKSh7poNzyErFR0d1Tdhc8xTJC6LsJt8vi4gl3YfVcU89A+x+HYR7W42MHkPz3PhrbKVqGS0v0ZkJ3KiE5ozc4yc7jW8R8d655mxTmyY5zW2LZBvJjBceZJCn0B4mPQePAVqBaA0NGgRrkNTX8ZZNMUb+hGdK19ROzLV+r1J4NB58V84YQekQ6LsXdwkDQBL+1vjf4T3VyiDUVteMJFA8Kt8JBa3wQ3zCgYabVwI+DCwRb+OlLHheH1geIfvGGIFStc1B2O+r9/hhYgmUU2/soG1uQUh0wP9onIgCSMc4OvJM5EuCux79BR9md2kr/GJFNo/78iiMm2ITD9cpd0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ61Qj4a+Awyr7b0p4sUXaKQAIfbzBgev+tflI99APU=;
 b=2IV6IPsg/+lxUj7kFeLR6UHQ1jmijdg+2m5MKQkIodQB/eEXFmL0WwDG4ezk1188JxTeqk/tFEz+zNB0HmUbmxcK/w5m9JpjYCBbnVwbzgR1A8l/Or7pAQz7GHNgnaCCdsS+1a/EHNeKHOZ834NsFjkKzwPU4Kj/TJj4JnzxkSg=
Received: from BY5PR17CA0037.namprd17.prod.outlook.com (2603:10b6:a03:167::14)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 03:07:10 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::c7) by BY5PR17CA0037.outlook.office365.com
 (2603:10b6:a03:167::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Fri,
 13 Jun 2025 03:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 03:07:10 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Jun 2025 22:07:08 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Date: Fri, 13 Jun 2025 11:06:36 +0800
Message-ID: <20250613030636.188030-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b809602-59fc-47b9-3ebe-08ddaa276386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?113+YaBnB4rar3kf0PLa5xytGwlxU90eCyZE8PWcQfrTGjJgRVl+En8020iz?=
 =?us-ascii?Q?q2q7XB+Rt4Brc9JZuRNrmtFY71CRUCSu68XEYs8/HLLsSxfSuJ67xtAozmpU?=
 =?us-ascii?Q?cME7rytD8SYfAN3/YoAlm2wgYxDfmGiVVLLfVsniCyot1PzEATenf4FFLgx1?=
 =?us-ascii?Q?EZNggAVYE3RtaFVS+GbDjivWdj+11dY3WB6codlrpjfszm9IpgcccRyf7wms?=
 =?us-ascii?Q?gjVQHu6xK3/tRhcOwpNirzHWi8U+svkfrlfhrfkyGw04TN53nREKEfXxEU3H?=
 =?us-ascii?Q?n1m9pWk2sJbzRykqltGN/9gXPyb7CBwlS8QdELUDtkvmlLdf0qAi6bNVG7Af?=
 =?us-ascii?Q?NS8WQrMWCuILXvzuQ9CfdD+4XW2LvUE9LNEPc96vEbgMmRHLMyATy9isD+Ht?=
 =?us-ascii?Q?RCpsS8xhFct0ahWWG+mDmKFqVt2lIKYA/+bxDlaCspfmy3vf3wjgF00m8u3Y?=
 =?us-ascii?Q?AjyFRjS83PvGjYTsLyLjvOX6lAa2YFASrdHFGJMmy9nxM67jQTWK/zVtqX7Q?=
 =?us-ascii?Q?+Q09dhxGuiuLSP5YBSXBuAGn9zfkQavR3v003ex3phVD050CiIzmA36v20w4?=
 =?us-ascii?Q?WErGoxDo00IdAutACF+BGltPZEA7jgBycebvYtdB9CC4DfLStTjDoBi9KpNO?=
 =?us-ascii?Q?ZCf7B8Q69RYh3i20bMpsO1FAk63RlMI+Q30DflfUsITsEspDGYv9NIlWg9xm?=
 =?us-ascii?Q?A3ocEyoAMyxzOSF98l2tj5euiTZe/Z9NCjffI3sOquZtJ30PuOZDx2qlWU2e?=
 =?us-ascii?Q?qG2YNQXPP7SGIo/FfTa6J1QJ2Ua/DRpAwNNAqZSwSe5TJ7Gq28Z54RGeEsKh?=
 =?us-ascii?Q?FIiPZtdwE5yh/1Asx9YiBcDKj0kHlebZDFpU8G82InVqHeVe8TDzB0ZkIXm3?=
 =?us-ascii?Q?8rV7KQEPRRN0j3I7/IRxhU7EZn4wUT5XU556x0syEqCUqx8EcJups9h2rL6l?=
 =?us-ascii?Q?m68B7lrEP5cJwk9GQjgkvpJHqMkx1UQ8QyUFInQu+5p/sAPKA0Qey4BSV+N3?=
 =?us-ascii?Q?ToS5epA4ZP3SeUi9bsPt63Gm1y006R6PI63aB8m7l0cVjnZAWzzeNPoC+LcA?=
 =?us-ascii?Q?HRwo/frfBAWUOu7c1TVRcasHeOYCyDidIVmGfQ317MjH5p8f5jkbLyXADKJ+?=
 =?us-ascii?Q?VqmCJ5IcipaJ3tZjUOZzy+AKqEiZ10Rig47Du52kjLYXDtec49ztlLRpgzgU?=
 =?us-ascii?Q?micIqlXSaPEDcOOcbhJXZVcr2reaUtnPylzgi8YKu3yE43g8aFnG75kMH2aW?=
 =?us-ascii?Q?Ze40xTsgpO40C4dm2juv7MlQK56UTsMk+wjGGJHWGat/Lihd88rnV2kMLlVf?=
 =?us-ascii?Q?HQkCKdNs4w8dxISj7T/wU69qiaJpDI7KL1RZGfi66/dZJOWRSdDq52DEYz7L?=
 =?us-ascii?Q?G6FMKaXgvuI56YjF55YBnPY1xN3yeGyO93K3dP4d4wMO5COyGrYV9ampRkGc?=
 =?us-ascii?Q?ux1jrRtug1Q90z90pJgdSTBaP2uxDqkfsN3wYCaNteh7yAOkCr5v21PSeLx5?=
 =?us-ascii?Q?PXWxaCpUmi7hf78U3itug6lI46UzNfbuV4oD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 03:07:10.5417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b809602-59fc-47b9-3ebe-08ddaa276386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
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

when amdgpu_bad_page_threshold == -1 or -2, driver will issue a warning
message when threshold is reached and continue runtime services.

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2ddedf476542..a9246c53bde9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -763,18 +763,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		dev_warn(adev->dev,
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
-		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
-		if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1) {
-			control->tbl_rai.rma_status = GPU_RETIRED__ECC_REACH_THRESHOLD;
-			control->tbl_rai.health_percent = 0;
-		}
-
 		if ((amdgpu_bad_page_threshold != -1) &&
-		    (amdgpu_bad_page_threshold != -2))
+		    (amdgpu_bad_page_threshold != -2)) {
+			control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
+			if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1) {
+				control->tbl_rai.rma_status = GPU_RETIRED__ECC_REACH_THRESHOLD;
+				control->tbl_rai.health_percent = 0;
+			}
 			ras->is_rma = true;
-
-		/* ignore the -ENOTSUPP return value */
-		amdgpu_dpm_send_rma_reason(adev);
+			/* ignore the -ENOTSUPP return value */
+			amdgpu_dpm_send_rma_reason(adev);
+		}
 	}
 
 	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
@@ -1509,7 +1508,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 				"RAS records:%d exceed threshold:%d\n",
 				control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
 			if ((amdgpu_bad_page_threshold == -1) ||
-			    (amdgpu_bad_page_threshold == -2)) {
+				(amdgpu_bad_page_threshold == -2)) {
 				res = 0;
 				dev_warn(adev->dev,
 					 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
-- 
2.34.1

