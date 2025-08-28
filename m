Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F76CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABB510E955;
	Thu, 28 Aug 2025 09:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LI7KEVeh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67EA210E94D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg6gysYMZaSCI1y2tYeUgRX9IQk6lw0tVNur1NTHTbuP6c5Jn4OA8iFAu4gSQAojp7ZkWd8XP32R3iLYTNxW9cFTzgZI1UyqCE/AWYD4Wwb+tAmhDEKf2S1+H9G51Vxf5CR3JiTzqFZ3YtTnzT1EfTdCdRk7kVFvxgtLwiy3eKvYTcM0OO3plW0eCV2pk2ClaWeFSx3JxDlSmkcNORWjn77Y6SuV3P0yMeSbfCLgyOiz/8LQ4sNRw4d+hJnafrOIH4j/r8c2RSyPMlJSxCtVcw1JsHAh5YSupjzi1mAnKxqeSHKjbpQCJ6exDquJIWQgtbbXP9arIVmX4y3WPXRu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=v6dEWLpFiBomCY2lXj9XZ+doeTHGr8lK+GUfgUrQsopoGntPJeBpO482hvzWwKGIamCwxxQLIqzI1rzGeLRsUH5hD7hvYA0iuQoDoBnErnzbbms4/KghCAUw1BLy1C6FndVkIwnhSvXoZWVz1vtvA1RRQwNdmqdYPTzivXQQAs8rgN/MBGazfg8yJuteWx7mqmnR0iTC855m5wGWjfE638Q6qt6wuMAwb+Mhs+M0o3MDHhiNGIMtKVz1VAzzz8mhhAVFTr+MDMo2KYoNg7fcafEP5c9K5OlWxP5i4vY+fbjAJ+GfgsFJJh6g021cPp+BfDxRTWE1JNFo4P9XACAqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=LI7KEVehXeAWR6zAVHc1EzjQeCjUmzweNZtVVBztcUJbe9tCfFpI4nldOq0Ix+AViyE5w2IuGXApe1PqUhbGcj7Se8voDR2QpAr3D29nLuqLvzYDAzONg+gGFkRr5R/RElrnxMFrSuPCgRqXwkgjvPBj76UU45dZw5ypz0aykns=
Received: from CH0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:610:e5::20)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 09:17:35 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::7e) by CH0PR03CA0255.outlook.office365.com
 (2603:10b6:610:e5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:17:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 01:45:17 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:11 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Thu, 28 Aug 2025 16:42:09 +0800
Message-ID: <20250828084457.1999535-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcb1fd0-6def-4125-383e-08dde613b9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nAQQUbQdVKFrX0ICEj0wssXzmPgakkXm4FiPiJYbYeglonlDyQXmNzwPWufl?=
 =?us-ascii?Q?ehPo/l8aPoY5iP2DhFbU2d73gZIAFLlcjzNFyXZYmZP2vWKCsGyXQ110IxXO?=
 =?us-ascii?Q?v7aJuKWsrM6sCEciZyBQ7OEv5NnrOeynbCmCx9CWAbgpF0xCuDxf3K5LGCl9?=
 =?us-ascii?Q?8dQNG8KBLQeQIWyecDOVBou/+C6v17p2eo3FQdRn82ZO+tRgk2EjEQZbTlrg?=
 =?us-ascii?Q?ff0UJrfFy3LG3cQNmAtePzDh/DI8FUoOmDFL2iFBQ+NAeYjgEHc0gd9VK3cH?=
 =?us-ascii?Q?r2r3SRkpKkuYLd/rXFNQpTEKYwRBdXSdTWG176gzzZSOy2GFI48eZs6+w+CW?=
 =?us-ascii?Q?6fGxWlLoi+74A+Xa/azMLuqauXvlkEYb+fMvd9uS0w/jP3WNOtNm7WxFW6E3?=
 =?us-ascii?Q?EJset+9IVCIxrm3pmk4OCcKEExf5L0g76hZTCzYJSrH4+tvnDvG6eVHAiLLr?=
 =?us-ascii?Q?Bzd74of7eJ59lAJWIuinKtb7yqc6ZRcyZKAhTkYa+GD7XMMpvIgaJR5JcbJR?=
 =?us-ascii?Q?vzC2WfTTN75q3izBklyvpn6G63AkOykAzi8Prz2kwD4q2BtXr2J4sYfnWnle?=
 =?us-ascii?Q?ZTDkzHiKHxO7fqmooRROU5mIlcSChjDeRjMEGCQ98ccAj6ecCKw7iHik1BWl?=
 =?us-ascii?Q?NUjQ33jwKPKLLNrhndOrJTAGbz7BvINCNkOB+1cZ+sHc/Pil+trVWsWV5acs?=
 =?us-ascii?Q?cTdnlgy3aHyYNUXipCjYgxlxT2cn9ERdogNuvQswBHKh/yYtZ1CzqamBhCbN?=
 =?us-ascii?Q?Bw+OvTncBGOXiPWtUDPBIQc3DIRHN00xNtRFqEOlM3h5ymOaP//C5fIruGVL?=
 =?us-ascii?Q?MTICdvEkp03Mu3SkhdwduboQNHq/E5AydVx50ojs4UFgxE+Vz7fzzDppd6lD?=
 =?us-ascii?Q?NBzqLU1zUM7gespdO3fJoQzSCGvAyAxrrpunmbVUCKjmcB+CAGJ6KWDMcmrS?=
 =?us-ascii?Q?olsJuL/VnKJzodM8VxVCum3zC2g8V+YXRQjNAm40AIUaVnEWjAFwbmvqICk1?=
 =?us-ascii?Q?3T9CldB4DYPLDI7LSv9WqcbHIwLeoCLI2Kd7v2X9y2/ikEll//lT8l5oxUmQ?=
 =?us-ascii?Q?S9sbSG3QuOqX77shpRjjk+nEc/tdDZY1wwUx0Nq/mmEtxEN3LjpWfA83NTZc?=
 =?us-ascii?Q?oQHxDqvb/k2uXJzZe3vhXdWiRhm9bhZ2+NaYv9r83m+3AY8ReLbvqwAWfCF1?=
 =?us-ascii?Q?T2GDJLb3ULAb8GH0bSNYvIlFHcGCiA1V33afmh1JBiTpZgiudaJN1M4CPNR+?=
 =?us-ascii?Q?BgsDY7vksLy7Ruo0TFyiM2LCrzyTX7ROZITjRAdJC50QWTkeei4hXgAZSgx5?=
 =?us-ascii?Q?DGSOinOLJm17NvQHrw43wmKTwGXhu01X27LJoh0VS8bbAXBNSRMRVPEznhOZ?=
 =?us-ascii?Q?gDK1N+OYYkc9Sxp+I9CPpQneZSKcopohEPFK8dVRIKe4uIu5zBsvS3SoB+rp?=
 =?us-ascii?Q?v3GCSS7OGR9PUMJxfKzTphxXfBrsqB3xjZKXLy1Z5lPzlvLe7/ywzWwxG3og?=
 =?us-ascii?Q?T0wtPNgoYlj58ULFgybtA83iv7nGlq/Ei9at?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:17:35.3925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcb1fd0-6def-4125-383e-08dde613b9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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

This commit implements the actual MES (Micro Engine Scheduler) suspend
and resume gang operations for version 12 hardware. Previously these
functions were just stubs returning success.

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..24c61239b25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -567,13 +567,41 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe)
-- 
2.49.0

