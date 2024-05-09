Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D84C25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 09:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD2C10E170;
	Thu,  9 May 2024 09:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VET7vKne";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97BDA10E170
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 09:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RejRXXo0oq/CTmAbsJflv7NIOxRa7SeKgi0w3ABjNI/Z9VZryIOkA01AQx8tFou0FEDXswc2ofjjQRBsZWRuW2hENIP+KV1dIDeST0EnwiZPamSwsyqm/ZJu+c02VpDal3b2uLTJ9bmAk/9e90gAp72WuKGxmyMwOKBmozfIR0ek/JfVmMMloZpNfrFiivBvnNqC6z+InPW5EBB3LINCj5ScH8lGe+9FXucq//GHR2Ir1edtHZV78YZ54oTqoK96o6ti4afBGHBbPWuDZMnPeOfalo8wo2QTxje812GpRJ7wT0LrXq6S/en5trpg4rhPqLV1oPAu/m79tS03gFbd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT6/f3vyHUa3s8z4D+FjP7EA0DXqRmV12ey6iCzKCfk=;
 b=YOb3lx2aD5rfIR/V5onEjpMFl2shdhOC5MwynOCpvaWYPsCIaxFlQ4cuEcUHJHfxdAG3u3kqgYKgmaoa3x0WBj3AdZkGKj2vR3W2OQKNMSIPOkNiBe4EyFjuXficZb7bRfm3boep3L98c2Hzf534rwgdqGcA1nEvJFo1HIRdD8akrHsimoSTCdQM4cYrJ07OH0fBdDknKJ3FiY89JbzlI8b4jZHXojHRLvU+2IEh24s03hQK5hBFvkHFrcUbTXE0mZQ0QrSBDPt+o2hzOrQbGLhQ4dDwU+MqFlPPEl0hbsxANMdfJvXPM/lAyUA7dZ+tIr4TZc6gGOMaS4QqDBJXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT6/f3vyHUa3s8z4D+FjP7EA0DXqRmV12ey6iCzKCfk=;
 b=VET7vKneH0qpsM8Wch/sBa6snLzwp4lo/7MwsgHqpe0T63BpdI222Q+zeF5aNF9gE4Lm9a61/YJ6HrekV3u9TjlxAQZqRAISPfmW1kK2gquo7MRVouAzMFDIINM95UkYoDgidS4YCME0I6SQt1Jg2aI1rSPK2RXBj6+In1cce4g=
Received: from MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 09:36:50 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::26) by MN2PR11CA0009.outlook.office365.com
 (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 09:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:36:49 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 04:36:47 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Fix code alignment issue
Date: Thu, 9 May 2024 17:36:33 +0800
Message-ID: <20240509093633.414100-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: e04b0a6e-d148-437a-47de-08dc700b8d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Y1exfssH+1I225f6eTQZ/v6jTa+nZrsuYzDbJhHIvIz2n3wY7XA37J/Mj72?=
 =?us-ascii?Q?L33OLQlC2Wjfx+1NZeRTsnQZTsUsm91pP6TksjnVOpBzFmv45wV8O5Yh1t6p?=
 =?us-ascii?Q?AINVMrGR6gzlmAdORlKDO9AGO2AaRD3ccpv0HL+yUVhCZoQ34c23xwwvnIGD?=
 =?us-ascii?Q?gUMJdOp04G2C+ft1d4uI/9bUIS7BnMTe+k41am8N97AUIvIwT2zufdI/heU/?=
 =?us-ascii?Q?AGccpOeH68tkoFDEa4BJFyJ/AJ/Rqk3E4JGIXIxTalzrqgRhn9dXZmS8YGDC?=
 =?us-ascii?Q?gl43x+Uzcd9okvsNuvInG2jD6s7b7wKfO1rpXYt4bAip3HesY+JKRJJKc/Zz?=
 =?us-ascii?Q?EWbMJ1uRbNm6FOPTpeGTmX1Kq4n2KXIUa0VpbIBCzR2w6W8VSyXBIp8zdBhg?=
 =?us-ascii?Q?1xQWy0r+IVe5u7SYLmUH4hpUoAi4j+gD8Sr/9Are2jsAoJ4KNDV9HcYWBl9g?=
 =?us-ascii?Q?5CUxgUVdVkKEr5yk0FGtZVpxkB3mxUnRVzAqg4pxNOacV0xGmcwBWVeD9Vxe?=
 =?us-ascii?Q?4eNZ31rrt3+uOWo+tsUleI+aFWbBSs2VZermlt3Sk3CO9hKU0Nz9NuAFn7h7?=
 =?us-ascii?Q?p4brWbF4Ld0jw6NP+sNIwvpGwBbxYk0Y3HMakwg/vyqCcmZNkvK0sALZ5GXt?=
 =?us-ascii?Q?FC+lcv/OEuIQZBEvAKEXiFuouqXW8KgbjLaBtRsklsVjaujdYwTioeii0G5O?=
 =?us-ascii?Q?BwRmXckeUiJ1Nv6kSgpJJt4gkLSmDCSyCfHJCul1G+xP5OMeRp1IDpjOWKwm?=
 =?us-ascii?Q?DIEvVqJaPMCwT+zZs3oh+2vA/Ao39zElAhdWQE+np5D2Goz53EIzI0TCTpb6?=
 =?us-ascii?Q?pbaJeu3BB8IKQet48pdxOXdyFqRg49K4e0kiHl/nPie56VZUKKkGuFL55CcH?=
 =?us-ascii?Q?pOzmqp4HA7hUAISs7RSeqK/H00IaFuyiBW/7f/+7wLfv+18hGiphsAECXUJM?=
 =?us-ascii?Q?bYE1OEufWhx0SdR0b2IHVYKxe6pJa9c1ZXwm3G48QSurQD4j30Hk10RPnK1z?=
 =?us-ascii?Q?2Fd1XWtRnpIMKUZKPLxmeLCn8UzYyXSyG9KAo8xP9bDYKWY64o9Asw6wxijC?=
 =?us-ascii?Q?DOmgPSxKT5Pq6eSZoIdkGGiNTHAYoZMiv2QshOLx++StEjaQo1aSJyUXVFy1?=
 =?us-ascii?Q?uJxpIyg5QyYhDPKVUsCQT+UMEv/qcIpXqvw+oOeUt3fW4vaWPXGSln8xMd5L?=
 =?us-ascii?Q?oYvJ+YOudkunLOZ9HndLILxz8kJdMEFa7yeNnNFpPPOgBpeASC+s7QJfdWCp?=
 =?us-ascii?Q?xaizfWjQ3AUS0N8NciE1ZnvMI5aKc9iwgzYQFeXpiF9udpzWMHcCylHXIOGV?=
 =?us-ascii?Q?slOBHx++ze6OVONvrhOfxjC7oFWSTHa57ws41fcjfbqqQDXMhJxmCcYJSL45?=
 =?us-ascii?Q?Gh2NHQQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:36:49.7492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e04b0a6e-d148-437a-47de-08dc700b8d56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

Fix code alignment issue

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                   | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ec9058c80647..110f2fc31754 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4381,8 +4381,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	/* under multi-vf mode, the hwmon attributes are all not supported */
 	if (mode != SRIOV_VF_MODE_MULTI_VF) {
 		adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
-														DRIVER_NAME, adev,
-														hwmon_groups);
+									DRIVER_NAME, adev,
+									hwmon_groups);
 		if (IS_ERR(adev->pm.int_hwmon_dev)) {
 			ret = PTR_ERR(adev->pm.int_hwmon_dev);
 			dev_err(adev->dev, "Unable to register hwmon device: %d\n", ret);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1e09d5f2d82f..e8b01662e164 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2557,8 +2557,8 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			(amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
 			 smu->adev->pm.fw_version >= 0x00504500)) {
 			workload_type = smu_cmn_to_asic_specific_index(smu,
-														   CMN2ASIC_MAPPING_WORKLOAD,
-														   PP_SMC_POWER_PROFILE_POWERSAVING);
+								CMN2ASIC_MAPPING_WORKLOAD,
+								PP_SMC_POWER_PROFILE_POWERSAVING);
 			if (workload_type >= 0)
 				workload_mask |= 1 << workload_type;
 		}
-- 
2.34.1

