Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9588D111A7
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 05:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7031E10E02F;
	Mon,  4 Nov 2024 05:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sxqPI05G";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE0310E02F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 05:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpE6O+VmKglCQ9imi8A6XhiXPC58q+8zFOhdeNjYlzSxXdMWKiQM0D7xZwAP76fiCVzOuWZ3zUWk3ICegIznrTfPkp06Uc9IEarvRaj2o8GBDP5SthXtoQL5dNNCTx1PrNovXSZpihuP2RFWAJ0bE2ki+jiMdxQKx09F8HGmlao0hkxKETvI1zOlAad+77LHUoClfBKNh3thrvOLbnMiciHm+o93ZvzLeOwKndWcupx9YansRSbd+eg4S22VwPblqxIzTKSuNVinWLmUAr0WTnsd7xWi//04tX/p0f4z8r4Cjz/l0Z/pijccMOqu7Qg/METPR+evbsY6Hi2qAuVjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SN0QFSoX5q6MrGy5ljZR46WMzIDrFS8zPnN9gkArlY=;
 b=Fx1WtoyUPxqSd5OSpiXpZCMMCXlQ3SJI24JUoHRm0WSdcV39nc0azFF+/tsA7isxGVSgZ7veEOa3WgV05GrkYvPCO3NNqDDRlz58jr1+e4ip0fAkt4x32w8ygYWj5y9QINHuKNc0PNkzEquoXZlnXAnno0Qdzmp/skDa9klKUQTuPoAqlpKMcDthhJfKsEMYY1Mj/tYVD6JgqgYxCPbCZb1R4C08wciX+tHqMzoKzMbS6BQlxCagviGXYmjWCFPqsJx998fSIAZUnYTUcy7D9ENjiUrRB7Hc/YEXfEVSqlPlO5hRAb7X/+MOZWkKlvWqwgZO3xvHAlf5vNsqLPw0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SN0QFSoX5q6MrGy5ljZR46WMzIDrFS8zPnN9gkArlY=;
 b=sxqPI05GQdomWdYNhwHPiPH8Mj405eieEq5JFh8LnbVopKCq3QXZlBTKEJ6TlmpQedvcMmeVC7fQPLVP0MNpaSYTD+/CWBBdNrlHImwZbBuAABeEWQv4lkY5mEoSR9SI/bGyNZ6WO3tCEaJhXah3IMDlM4us/+piqdYTyZXz/9k=
Received: from BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::30)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:11:34 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::82) by BL1P222CA0025.outlook.office365.com
 (2603:10b6:208:2c7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 05:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 05:11:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 3 Nov
 2024 23:11:06 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Fix DPX valid mode check on GC 9.4.3
Date: Mon, 4 Nov 2024 10:40:31 +0530
Message-ID: <20241104051031.3204728-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9b3c44-d659-4353-9788-08dcfc8f26b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rTCSka5INt6QZ8g0+vRXLkQNKLjQ8E7qTT3IxBDL0vZD+0026VbsGjyu+ey1?=
 =?us-ascii?Q?n3DogFXRcuB0xj9w3Eyr2Tn3OSZUWgHmMnPRSs2Ko96NnaFtS+Id+QwEsIeP?=
 =?us-ascii?Q?2MMKeio1N5O6OOGV+AEV6hGVHsGl6kgPa7gFF0kbC/18Xvuvf4Zl59Ga/ttf?=
 =?us-ascii?Q?xiCm771+Ppt9MtXg9NDcgjcob0rtzND7jJwqAuti76O0jBvQHqRtci6Lagpq?=
 =?us-ascii?Q?eiMlL/CeJHGvFsvq56xoxH+xofNBr11WBWxAItj8IcKZ/jco0Z6JX7sQxCgf?=
 =?us-ascii?Q?XmWQauVAuoSsUoGLrUBPAbN/LIqijA+/J5NSCi6egaV7ISzYHe0dwFS4J3L9?=
 =?us-ascii?Q?ZheazuRVcu25jtqoTHHlUWxkqT2se1F89xQ7RSgMGIaXXg6B5TXRKnRaQKx1?=
 =?us-ascii?Q?6/1DLCx6v6A94Y7fFeU5NoCmVebeUYrH96yb9vXVpvZhT8nyU2pePiXHCk+Z?=
 =?us-ascii?Q?pr2r7jtr/Zv2bNsRGEcmIfnxGvnO8HHXaTncUt3f3SYJJlhB6eCc70lZ5iAE?=
 =?us-ascii?Q?0ixeY+SytixZBDnUde9bb67lqy0jYFod2/1rEoVgziMGwAxODnpyj2NZI/Hz?=
 =?us-ascii?Q?5A888hXoaDjA7X4B89V6Tb/Ez9hyct43TFFQ4+ZkzO1+2J6qMc1KWKv3w+/q?=
 =?us-ascii?Q?HMCGTaRVZ8M1Mx4oTs7CLySzd0MQSI9O32w/DAZ/c6ySG1QKNojd7hFXV73J?=
 =?us-ascii?Q?OtrL3HohufVe9wNj20SIPY8nLcR3WctOE/3sJtwOYdJXRBjkK0StOhajZRnA?=
 =?us-ascii?Q?VBezMtYyXtmizwuZKty+Kh/PSNgHmSH9XoRP45WoxVi22PwxEUBQ06gt3al8?=
 =?us-ascii?Q?UFMKCgHhQQWqI0nC1VIQjx/FZyeePgVZQE3eaO/FiD2XIv6zu44KvgKXcVEd?=
 =?us-ascii?Q?yTzMRKOG69GzhBjOM01wKNJ66qO/6MRTGIUq4DUjMijkDKdkZ616+HjD/fjx?=
 =?us-ascii?Q?ChGF/XkjGwyok827bQ7l0aBRyY94frH9bM6moV7lZDWD6oqsghw9yi1+BP1p?=
 =?us-ascii?Q?jY4inRsGL2gamaNBeLJHX5bl614vXYqyD9BHI8MFey19z4vF6KaGf1bhS04b?=
 =?us-ascii?Q?GGhwlsebfOTzOktEQRuo1apZI+i6VIS6cn+H3A4uawDa7NGoRvaxGGXjDV7D?=
 =?us-ascii?Q?oqcQ9TDxI4GPfjjtrjI/hurHjvttOFn1pLKs6ZB4WZoHFzjzplIBIKHFk57/?=
 =?us-ascii?Q?Lbiq3+dL3RKg9lUd6fCaScFeT+BlP0BWBo3OvuJEuzEZq/62Ba/gz1s4RXfW?=
 =?us-ascii?Q?nhbvMJoWbYg8QIk/yeMLnNCYjak1AKRo3DbxV0KAcDdlZ3Hf11TCQ4AeGp2o?=
 =?us-ascii?Q?wNy53ucK/I2KP4VJbyKvmZV+mx1lUGGpUPFXGNnawl+60w6AcWoPlXJGS5h3?=
 =?us-ascii?Q?XklDdRMI8aRDQaKHyuPYKqynFOcRImsh1xZm7qNh+NxYq593Bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 05:11:33.9140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9b3c44-d659-4353-9788-08dcfc8f26b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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

For DPX mode, the number of memory partitions supported should be less
than or equal to 2.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 1589c82a1085 ("drm/amdgpu: Check memory ranges for valid xcp mode")
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index fccccea0d2d0..e157d6d857b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -548,7 +548,7 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	case AMDGPU_SPX_PARTITION_MODE:
 		return adev->gmc.num_mem_partitions == 1 && num_xcc > 0;
 	case AMDGPU_DPX_PARTITION_MODE:
-		return adev->gmc.num_mem_partitions != 8 && (num_xcc % 4) == 0;
+		return adev->gmc.num_mem_partitions <= 2 && (num_xcc % 4) == 0;
 	case AMDGPU_TPX_PARTITION_MODE:
 		return (adev->gmc.num_mem_partitions == 1 ||
 			adev->gmc.num_mem_partitions == 3) &&
-- 
2.25.1

