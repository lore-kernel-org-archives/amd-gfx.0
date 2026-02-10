Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421CEEA3F2A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 09:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54A110E530;
	Tue, 10 Feb 2026 09:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZqtPaaTf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960D610E530
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 09:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFNa08c4sEzV6EUMz92urTHKRuYt/gMxW0wAw5La9T00fXqGO242Pv1dgVPjuEt6GKKsutp+fQZK5c9/vHv79vFWesb/joj/ZA6AJMunSShz9Y2HkFjZHPxhgQ5tc+AUsh2s/5QCUUurTjILa/YsLSTCn2/4U53+VhUbcq/naF/A6O0LUhHd76qehaVLuAukv7gsWohcJNcgfr/4zNb8AakJJPWf6/QoVeM5Il8sY7jQptSZn1E1qpz5KqDsG55qXF8bPcpV+VYTe/cpS/nF8nSDSKW6osxDeW/CEDbawvjdjzymI0X7srxRt1aNRcNgpeaz+KlLBrR8wxBoVnXkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOjFBKmNkk7yGYWeCTQpwtlERc/zmNugPbeTiysaPec=;
 b=CdIkFBh/Og+oOhSyutq59vlB64kbPMDEW4YNxRggXqxmio7r2k+10lLZ7WgAYH225xnbChkrfUSqr7LzGmh9LZhWtmIstRJLTzgJ4GAx08EZ22k8IdEBX6ER3b9waBWYEW9TvWkq9Cs0hrVuGJ9cCph1bUiTsPIf2A55LVogubUIP9LYShnKKynGJwegCvs4hZPIM9CxlVWpeX8UbxUnQP6zB8pzbpYi6P5lappyuy6PNFd5TlaBWmC5AbMiF9aI3hp2zq7LeAiMAFE43TdmKEMGPlnYYpbe0BD66PT5pphERpgkGkyOxha3FYbNWaMNE/rmF8Q/wALqiwNRV3qoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOjFBKmNkk7yGYWeCTQpwtlERc/zmNugPbeTiysaPec=;
 b=ZqtPaaTfQXyb2A87gGPKC06+yDMXKbDm/PwqWJYfT05EY8lc3/Bu4UInitrvhlfYQhvcGzlBvEiFNE5LBhZQ1dzYY9SUMWIEMrc1ydMwzoHmgXG9aq2nSrailOqvqyBh3n5uV4tFPC7OJ+N4NNWYBUSx3rWMX0f85h6SqavZP8U=
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 10 Feb
 2026 09:52:59 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::56) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.6 via Frontend Transport; Tue,
 10 Feb 2026 09:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:52:59 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 03:52:57 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <tao.zhou1@amd.com>, Jinzhou Su <jinzhou.su@amd.com>
Subject: [PATCH 4/5] drm/amd/ras: Add function to convert retired address
Date: Tue, 10 Feb 2026 17:52:32 +0800
Message-ID: <20260210095233.3078476-4-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210095233.3078476-1-jinzhou.su@amd.com>
References: <20260210095233.3078476-1-jinzhou.su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: b31428a5-93e2-475f-051e-08de688a2c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WmjMItC1s4AyjVsR0btIy1z9RGfTioTUafsFGor5YknM4AhluCbbyh5bDBo7?=
 =?us-ascii?Q?XonYJtk418wKhJJCbxNWSNSHJQbhXSnZO214wXX68Jg7tKFQ5pAzlAi3zOzB?=
 =?us-ascii?Q?sf9CVcfV92D6TZRjtoNge4dusKpbiT/wrCjlrhuqOU3O4F1N+UcNyC3Ka9Pr?=
 =?us-ascii?Q?pcRAPWBzhflGkBReCFKXj8IAomfyf6N29Am/srct1gpo6Drpa1ejFxDrDcKI?=
 =?us-ascii?Q?QpdDtHuBXHYx5+8nYYC3lW96EhMhKJMmS11y4BPS0q21RViFJg1hmdzbeEPS?=
 =?us-ascii?Q?/dY9Zou27tQgNVqn0JBGRIHYNE0BYUZNjhJm27kUuvHhiXIuWPn4zxGy4K5j?=
 =?us-ascii?Q?QU65MkTerYP6eF3CfqZR4JvDpWxy6M0k2QBPIEmkE9wdKbQUUZhAGOy4UWkY?=
 =?us-ascii?Q?0QXjUXeAlMjTfJt9RLL6GW/Zz2GlF0KC1PY1HWBPgQ7fLqeZWOb+4CC5riI9?=
 =?us-ascii?Q?IjQEl0z4YnnuZS/ugzMts5MiBwBF5PDnEI7Vc6it4xH9+TSfrS4eVyKVeKye?=
 =?us-ascii?Q?d2YMBhaOWzRMcp7c0HnocQGZoAIik/1PMGl+2OG2iZNxn7osdcL5T9O05WUh?=
 =?us-ascii?Q?UOixi//4sx722E1MP4/ZH6v+/1AxcCQPZb8oDZygsufOQ/CleTqnvTrd8vY9?=
 =?us-ascii?Q?1Mkv8+60SALzhB0Yn12J1gomev2d7n9URJq7RvUgBOdykZHtyoGI04M2JpkW?=
 =?us-ascii?Q?ylBlw2WUraOXeN64SjgE3QWRrnZtKcosrTUM0QoGOyigWTFVr/6NBhNLM8D/?=
 =?us-ascii?Q?4fZlv7QNSLB94KopiYN/68fZTsZGgMmq75ginWODb9ri8Amk538XDzc72tbq?=
 =?us-ascii?Q?7mpfIt+BfIKEMHaVM15g++69L3x0HoW7CWwv8pRdQKwPCZFn9VHF8YcX8154?=
 =?us-ascii?Q?nRqn9lMwBIz4+zUsr3IDJmLJoUdqU+/d4halPRSA+z3vF3GYtPTvlKzsDOUQ?=
 =?us-ascii?Q?3WRzgcrIetwOlKmaDxnk5HpI9bTjRR568wF+g6B+qUnpGIHsROP20vr3lT0h?=
 =?us-ascii?Q?PUfDCpTNZ/UsUVXV1ZHGR6fWkBE7/yCETjAWzit/ZLspkkzE9htxD93o6XAy?=
 =?us-ascii?Q?37/sd0ERx1m+2D9uV+GS24OThKLB/RUx8tb2kn3ZT11WGzoiEcXccTk82FSk?=
 =?us-ascii?Q?0oeFHCmdLnWNbLKx3uuy72brMr+WegNJ9iA4H9DJLBB/o2f1htBT/0FADrWQ?=
 =?us-ascii?Q?QvK01sopJHLiwjat97Ffb8X2QlJz9ime6oMKt4zeSQOkKfACs14rvTGaWjj5?=
 =?us-ascii?Q?RmusE2+KyqINcKnAqApMuDTA1wUPLL1ib5OgnhvgIqy71GSobbq82i3P9RVc?=
 =?us-ascii?Q?6Taoi6m+ZNErWQBMFJePc2tyTWhy6wXHLvkUPZiqDHJI7g6zZ0JWaAes2+ar?=
 =?us-ascii?Q?JArZp/IKsu4WuyVi57quVlBmvWcu+u6pwoGtSNtqzCqjYDZthF3aekI67Q+G?=
 =?us-ascii?Q?oajBVP0DsFtDfx6x0DZXW8d564ZGtnCgPRPdc/AwpvMdQ/SU6R1tybLsQFyr?=
 =?us-ascii?Q?wTJHf8ylhIs47JcrPB2eYfy8vLion07fjlbx5g4NH7LgVylxp/xS+sLFJb6U?=
 =?us-ascii?Q?D5s6m0pdSAKfSHiicrN6+TUSb/As7t8gxvhUM4KhJqYKydkDgRPe8h9am/fT?=
 =?us-ascii?Q?bNOuaMWpBoMNGUZ+airbJFY1g0HNXQ5YXtMa6N2cDVz1pWg5pvYZAzj8E4EZ?=
 =?us-ascii?Q?7fisYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tsFUoirBCoOeENw4vBP5MY+XdKPp9QewQHdap46xphfkqUHclSiPnXQ6CPjmEQixA0FoTIG6ONmed6ro1gJqkLeeVm/CqXYh+LWaat7Yc/P+4PF9OylsNt1E88yZvjI5cQb5WL/Hd5tSYsNb66bp0zp1nJLlhzp2/EKZLFXP09F+hSxWSS+j9ec5y0dTI6f/zr98q4s3W74s6uvYEsdxcMlSxcJpv1eB4AjLDDUMDliStjswAd+nEq9qEvi19EabWq0BeEeRdITeqnkZm6BDJnFCWZXf+fHdnackT8lqtIN52iAAfcmWEfVV7OXSxu7Q7ISJnp68DPieAGmhjykZJxLSRRFlGKwQy35YRTh2zayZtm9URVgEXTTJIDNRhJszCcTEy28Joo5/DVCc1EsRnBBcwhrxB+QxbceV+P6kUhyvtEwFYPIlqJ4D1i71p3Pl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:52:59.0782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31428a5-93e2-475f-051e-08de688a2c4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

Add function to convert retired address in SR-IOV
guest.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 27 +++++++++++++++++++
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 3e0ce9b004e7..26d062239ba9 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -344,6 +344,33 @@ int amdgpu_virt_ras_check_address_validity(struct amdgpu_device *adev,
 	return RAS_CMD__SUCCESS;
 }
 
+int amdgpu_virt_ras_convert_retired_address(struct amdgpu_device *adev,
+			uint64_t address, uint64_t *pfn, uint32_t max_pfn_sz)
+{
+	struct ras_cmd_convert_retired_address_req req = {0};
+	struct ras_cmd_convert_retired_address_rsp rsp = {0};
+	int ret = 0, i;
+	int retired_page_count;
+
+	if (!pfn || !max_pfn_sz)
+		return -EINVAL;
+
+	req.address = address;
+
+	ret = amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__CONVERT_RETIRED_ADDRESS,
+		&req, sizeof(req), &rsp, sizeof(rsp));
+
+	if (ret || rsp.retired_count == 0)
+		return -EINVAL;
+
+	retired_page_count = rsp.retired_count > max_pfn_sz ? max_pfn_sz : rsp.retired_count;
+
+	for(i = 0; i < retired_page_count; i++)
+		pfn[i] = rsp.retired_addr[i] >> AMDGPU_GPU_PAGE_SHIFT;
+
+	return retired_page_count;
+}
+
 static struct ras_cmd_func_map amdgpu_virt_ras_cmd_maps[] = {
 	{RAS_CMD__GET_CPER_SNAPSHOT, amdgpu_virt_ras_get_cper_snapshot},
 	{RAS_CMD__GET_CPER_RECORD, amdgpu_virt_ras_get_cper_records},
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
index f4a4dfa4bdf2..6e1cce490e47 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
@@ -56,4 +56,6 @@ void amdgpu_virt_ras_set_remote_uniras(struct amdgpu_device *adev, bool en);
 bool amdgpu_virt_ras_remote_uniras_enabled(struct amdgpu_device *adev);
 int amdgpu_virt_ras_check_address_validity(struct amdgpu_device *adev,
 			uint64_t address, bool *hit);
+int amdgpu_virt_ras_convert_retired_address(struct amdgpu_device *adev,
+			uint64_t address, uint64_t *pfn, uint32_t max_pfn_sz);
 #endif
-- 
2.43.0

