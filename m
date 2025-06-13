Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0908C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 04:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9891010E18D;
	Fri, 13 Jun 2025 04:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0pPFvLYk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFC410E18D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 04:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmlZhb0Ka9d2aiA1Ys6hNjCOBcKDF4yJb4CwOabWN0ZM6KalNFue2mTiEPOZTkoyUFH9+4cCZE8mpmV8FiSDg7LLrgoVZEeZMdfd5mINWbKCdMkPb0GHN+G6E5LLgayy3ULhexZ3PTCtinFWX9528/DPuSZysHKAKIz0yv29xWxeb580d1bKLzKeIyKOGl+2xkCVgsGoYWo0e7prrtof5lVTh+4F4QL1i6vgvZceCRZhWJX2Wet3z3VgUcGVcb1V9r3Ng005quV/a9jQjhZFajClBhmxW1hV76RgbN3onQJApem8tmOgl4IXiBFZf/C8hdOiMJKxBVN1akj1cF3MnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T7jNz4liETlkVU+Px01QZoeBlF2gilbIGyaLoRE9ps=;
 b=Szdgpt6WyPeLfbq8G15cqZys6e0gaWrehka54Lsh+vse6Wpmsm2Atjk3/3CUMrHD8EtLsH3lTUoe/UtNyZlRb3Wfaqq/vcaevGdH06bHneRYHDdOV2GkvyNX4K9s5RCdnGj+hBX4Mp4r0DcB4pNTPoMwvcPcnV2Q22VxllNWBx5VfmlVtNbDRNdSuiGheWYqJYUGE4Iw193vFY8rO+GvFMiqnPzvhLiwkVkTRl8MXePahItFs8PhRkQRsTAbYv3ws2P0qgKrmbFpFqN+JHNbE75otHzcLLjmy2jjUtQZeiBCe9BBjLnNsMoG3ea3QF7rPrPhKCRYgl/x+EdrNaWeZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8T7jNz4liETlkVU+Px01QZoeBlF2gilbIGyaLoRE9ps=;
 b=0pPFvLYk6zPBLVS+uLr3OxZvQXm6q6jkB1Lmduag40tZIcAitgv4n9UhVfrt+SkxIXUyTHKBF798A6uCrSxyZzlm/VAshoiQ8aTpXd5zQQdWPdzuHXqLxt9lpf/OWEp3HiTVbSM5G0qpCqKZqIuO04JJXefsEFAu2+E5bzwrcpI=
Received: from SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::12)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 04:03:44 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::5f) by SA1P222CA0176.outlook.office365.com
 (2603:10b6:806:3c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 04:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 04:03:43 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Jun 2025 23:03:38 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Date: Fri, 13 Jun 2025 12:03:13 +0800
Message-ID: <20250613040313.188841-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b2b811-15fc-4ca8-6bf9-08ddaa2f49c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+6jE72QDV1ZrRx4gaU3YyZ7TbHfqBb0qtMEIrkyiQ3Cy343VdhHEqfPH9XD3?=
 =?us-ascii?Q?LuA5iACrwNbP0YhQb8Nvirdg8yGIkwE6O5Y3e6OSXtlYhXVw3r7cB6WhsuCq?=
 =?us-ascii?Q?5dxs/WdLen+KLDxxDLX6yW4lwwTIV7L6lhR41Ii1StRrWeE7HMqAcPERY1AC?=
 =?us-ascii?Q?8zgFqtT8eD06Y8Y3uu40YL0cDXJFHqYPLHJlEAJusM7+sCo8dLEW0SNFLKYz?=
 =?us-ascii?Q?c9V7L1O8w7C0JRKgX6S/4RymmKU7GTPUjgVP/rzm6C8RYdQdeiumXr6vWeua?=
 =?us-ascii?Q?Z8pC48SecVQW5l6P8GbhGCixFm7NRg0GrjLDXXJp0I3XdCBoG9RRtRZWINb9?=
 =?us-ascii?Q?1N5R/UsDxfIGz3W6AiDL6JiQwXL+/8Tn+WQ9Xsj83bP9nNz5kQuT411yufPR?=
 =?us-ascii?Q?6P0nC5zGKEIadNFbldPnHv3y0c58eItTF/ZLHgSrNsDHg7d03GNL7aQhHh6T?=
 =?us-ascii?Q?RUkGMlK4AuznFGnaqeLh3HbGXSu6g43YAdtm1Gra8SBQNpjKiaUvQZi0nVBd?=
 =?us-ascii?Q?jNjGEAID7KtN3HC2I6ntY2zLLfRugnbAxqu3EU4wnHa86xuSCB2x6VFzLTOA?=
 =?us-ascii?Q?TrCdTqSjriCA3dTbjNocIH1eq5/SaONWpJm7RN5eNfSD3AhIlCflJUfwRT6G?=
 =?us-ascii?Q?KlOE5Cpdt78BW1wuMzA2rdsWJzLHNwLH5KbnRldSiVMWnu4oyDiqIoCWLXgI?=
 =?us-ascii?Q?c8wqV6CybhxQ8lFKT2e7KSFn13XO6ZOTlcAu/7btCRPBuXa1aS5lfbFzeW0O?=
 =?us-ascii?Q?zaoy2MHipmIG0Gaxu3QCa39QeYafpopD4ELTl9AYSu9erKUMJ5wWYcy4S1ol?=
 =?us-ascii?Q?aCLowFRp3mAHUo7H6sjt5ZsV1tiCM0qyQs41cCetf7+plaUjhy71AjBaSK2a?=
 =?us-ascii?Q?SGFL/KAq46ThIv6d3jpDHHjiN/Ab8hpU7VVLMmLu8K58tyBp8LoZ2+zpiPVu?=
 =?us-ascii?Q?jmQNg2IAfdnUurzInWo2S3RAMxdiLebBhRPs1ergxPz4jRHOwA8dVbU+5AlH?=
 =?us-ascii?Q?BiCb2ZmKbTG0CoxhpAi7SZBZwe8xLU/XForn85SZ3pmEKsF09oIGZ7B4uWnl?=
 =?us-ascii?Q?wVjcTYsJ4xxEM3lxfnaUOBydHOV2y0Co8RVe0Gwd+zP+KKIrMgrQSldTm3SZ?=
 =?us-ascii?Q?ufMMmstP3yMsBD0jNHACZjZLV1r7rUYXtx5BAgtmMOrjHFVYoXo8UqBUrvXA?=
 =?us-ascii?Q?s3QcVv/0x75tZZEVyPs4xFEc+AmNyvxsl+STwEN9Abg9w/L2XYO92xe7Nphp?=
 =?us-ascii?Q?UpJzyp2b+vNja2IEHRQXkYEj9NBePNJ0V9iJRNQnsnyZQxExflO0R3PjAGad?=
 =?us-ascii?Q?Zu6wV4RS25P7rhMECvtV4pDzzn4Hmsng5fw0wZIFAPsc3tTG0yn+oaJZQPSW?=
 =?us-ascii?Q?NGlMUvB/AWzXDsjkBHgNBfRXwT3djvZft50AzzQDXMqIF/Loe72dVk+RL1SG?=
 =?us-ascii?Q?/8Ji/4krg4bmVpuAc935PLYx2p0BOUasAxOt+XGpr9Mz/0Fi9KXSlPIXByIZ?=
 =?us-ascii?Q?eeydU/XJoEbiQGrDYEOIUY05yK+f7xf2o4C5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 04:03:43.3741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b2b811-15fc-4ca8-6bf9-08ddaa2f49c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
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
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2ddedf476542..2af14c369bb9 100644
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
-- 
2.34.1

