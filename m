Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C9D21263
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 09:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A850C10E7BC;
	Thu, 17 Oct 2024 09:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XDVRmDH1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E57E10E7BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 09:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijyuyKNJCx9tbwHIThjndk/oULAtIy3vHK6wLYd0qrfoi6L/DnCFTbl8o3aO3I86yurkdc9gLuVtzo4uc1zUQ9FqNu9aMnxOfD4bAMMyxu4l2pqOvmxElUPMaLzR+mRvleQH2B1yfO/yf27q/aaR+pfr2gi1sibaJ9ErDW+/Pgm0aKmm7gMW/zlDY6OGmQJ5cAb3tDrDZYAsX6F0j1VmZ6FxFooyxKko4sanLWGyxLqAih8DAFPtGC/CG3V44ydeWqNDoIVo/vl5zBTtCv/0/pmWF3t35DLWBTjP6ZX75thDViXdVQlL92ClIxH2wdM5wtSWLNkjchgX1EiSZjzWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YbwVhCt/KS29P2a1+/3cpyfLGhZ9xuesisTPuR8eOU=;
 b=WOTlnZ9nT2SCxD3yPO3lyj5ejOhFFQmscIaY91rhTlkv4u+tDKDdCVxdiWr3XUSRQiT8gOCKdEgSa06n7/5TK9yGewmmdp/KHktMrzRKpY4y05QZXoW0hDpgnYgCez5tyPkScLW09cet/76guIOSwWxOra392/ai+xBCYx81E47PsVa8NnYA6FZDZt6CcU5LfTwn9yyS5Y6A4I4KGu507dIxGhyDxh3J789dny/LWBO+MuqLmsINb3gqLufVzgXIQjyiCpLLF8TEUDUn5dUmgSPA6uANrKlFpeI5enwae8OwUm3vl3BarO3WUOucpouFchAWf+tM0RMkWiDNTQsc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YbwVhCt/KS29P2a1+/3cpyfLGhZ9xuesisTPuR8eOU=;
 b=XDVRmDH1BiyBGKJFmJo+osqvUoW0CGTX5IGLBLsYHyPTe7cs/SAYkqJhFEiaL7+nYjBUbXbd4Hj5tOsoFZRPKUxA06Nh2BWbxooNJEDKMunpdWpQ/d10O/IRVdZXM67CiVC3l5sxAztI1XJ3ZfF2vA0GDqLMYEVMQWXzgYe3rSM=
Received: from BN9PR03CA0784.namprd03.prod.outlook.com (2603:10b6:408:13f::9)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 09:10:04 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::5c) by BN9PR03CA0784.outlook.office365.com
 (2603:10b6:408:13f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Thu, 17 Oct 2024 09:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:10:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 04:10:01 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the logic for NPS request failure
Date: Thu, 17 Oct 2024 14:39:45 +0530
Message-ID: <20241017090945.3069598-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 76499a96-897c-4f1b-f904-08dcee8b7ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3VhA8Nk0m2NkObu5OXYmgwShcYf4ipBZmPScSbXiZOJI3xloExzxvSlUJOY6?=
 =?us-ascii?Q?10a+H6uUCRlvq60PMDpSxnrFOtB82BJ7Kaln3C9aIy3HZkxw5VBt8DLBQcm9?=
 =?us-ascii?Q?qSC5fxTpuW1/4J/s/LbpKgKJVJaR8Zp02DkVZKL+qbIt81t5bXGXP8g/n4t4?=
 =?us-ascii?Q?VWBGoaeXWyETRois2tptiWyuhoZ5eo+ulFyt1SIiqbC3X8/cSrmvWyhP+kdp?=
 =?us-ascii?Q?eFLohF4GB/ftQo3fWHbZGge94ppIsI4SrGptLoxzNAtgC7OEagtWSSbRGP3+?=
 =?us-ascii?Q?sn2NvPcil2gWvPqT+6JXBQUXFt9EHPiyW9LIOjJaHBJejXvrsjnpfEFa+KDL?=
 =?us-ascii?Q?H1iDc+4QonmE9f0DqHw9/h0uETcIV8e9UxIjAlC0fwxNYIexo6saO5hV/327?=
 =?us-ascii?Q?/IJhx4a6Yc49vUF6Loga5DHRCwm1I0tTy9Bz+hLyoTm0CZsVRaE/Nc+6pfdO?=
 =?us-ascii?Q?byv/rs3BHUlbcTMaU9Mc6vDiRdV1YzKxmGFaAY14QuXugtWs/OFLAP+holgl?=
 =?us-ascii?Q?ULsewX7zBeOsyBvzSa/0eRQERaMrhbulyjCtW5yjHUviKVpsL7gzfLgiTkX5?=
 =?us-ascii?Q?2HukgFQ39A/M/8EXhX3OpPh9CRfttmonD0fCgvPu2l89cJhZ4amfqN2j1fD4?=
 =?us-ascii?Q?Jvui4kwmGR73dmovTVk84oGFvIlxP00YELdiUHEye17NSSeg2iUD3j5Wci/e?=
 =?us-ascii?Q?ktqRDU0bXL0MzZlDs8nyG8x46RevQUjyWBBnkkHeiJAMqgeyTc4xG9rldyI2?=
 =?us-ascii?Q?9gClb6/QPAC4lHczX6PyhJRMStNbFNJBUNiHo2bLebf+sGWQP7RUmIOHBaft?=
 =?us-ascii?Q?xWyqvEjTOi3hLsNxgGK+ht563inZwq2WCP7ntU50rXUYc++lOqHOc1dsgfj6?=
 =?us-ascii?Q?Gqm0su7TSjdhRU+anA5Tyx+lCTI1z3nmixZEl8ZovP+vsh8iAYQe2A3u2g2l?=
 =?us-ascii?Q?orYhd08pZC8cdh5/YIQFmH2X50VZC2FQH9i+iFeQGoBoNt2U2pTnAtenZpD3?=
 =?us-ascii?Q?keZF/oKn5sjuZR/BC6Kx6ZqU45qUWetth3LLqnkKwthkBYC3Ixnmsof78+Td?=
 =?us-ascii?Q?OpaDUkZWvTK9OMNqDeERvwei02Atjw2Y8nOdglzMqsJ7X/dhB2ex6a4/7yd9?=
 =?us-ascii?Q?+y95CBxjDCCEte8gjZJnicZ5kbY45VCMYZQNxSpgh0fcK/UZ2oGaWNwvuhS2?=
 =?us-ascii?Q?aaVdaNKw17czt/jJ5PFm7fHzt03v13pvWowBMgHvwFRp3GeO5Gw1lmeLu0bi?=
 =?us-ascii?Q?59HOGTAu7rhclaoxZdNpkLSIyfobFiwFlYrftSnEqEs2nzTNr5VnPqsHtO68?=
 =?us-ascii?Q?/1d9hTJsEXNAxHrmK/aNj8cl/dl0RzJtD1qDah+lorysZx1DRjj8I8yl+BCf?=
 =?us-ascii?Q?N+YuoAF0myPyOQZ2HHhrNrHTunhWKa5xg2bEzjXyLN/VF/4bYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:10:04.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76499a96-897c-4f1b-f904-08dcee8b7ccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
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

On a hive, NPS request is placed by the first one for all devices in the
hive. If the request fails, mark the mode as UNKNOWN so that subsequent
devices on unload don't request it. Also, fix the mutex double lock
issue in error condition, should have been mutex_unlock.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 44d5206ec07c ("drm/amdgpu: Place NPS mode request on unload")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 +++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index fcdbcff57632..d2c25af2c5fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1586,26 +1586,29 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 	 * devices don't request anymore.
 	 */
 	mutex_lock(&hive->hive_lock);
+	if (atomic_read(&hive->requested_nps_mode) ==
+	    UNKNOWN_MEMORY_PARTITION_MODE) {
+		mutex_unlock(&hive->hive_lock);
+		return 0;
+	}
 	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 		r = adev->gmc.gmc_funcs->request_mem_partition_mode(
 			tmp_adev, req_nps_mode);
 		if (r)
-			goto err;
+			break;
+	}
+	if (r) {
+		/* Request back current mode if one of the requests failed */
+		cur_nps_mode =
+			adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_adev);
+		list_for_each_entry_continue_reverse(
+			tmp_adev, &hive->device_list, gmc.xgmi.head)
+			adev->gmc.gmc_funcs->request_mem_partition_mode(
+				tmp_adev, cur_nps_mode);
 	}
 	/* Set to UNKNOWN so that other devices don't request anymore */
 	atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE);
-
 	mutex_unlock(&hive->hive_lock);
 
-	return 0;
-err:
-	/* Request back current mode if one of the requests failed */
-	cur_nps_mode = adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_adev);
-	list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list,
-					     gmc.xgmi.head)
-		adev->gmc.gmc_funcs->request_mem_partition_mode(tmp_adev,
-								cur_nps_mode);
-	mutex_lock(&hive->hive_lock);
-
 	return r;
 }
-- 
2.25.1

