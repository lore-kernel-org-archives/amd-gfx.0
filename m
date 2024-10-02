Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB80CF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8AE10E68E;
	Wed,  2 Oct 2024 04:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hyj7VI+s";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B1210E68D
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJl7UaQlpKMpntFuhmY+uRVBiMk4D3fzRdrRWRoAl3F427bGxE+a9C/jzVkXcp9H1LasabnGOvtuLbw2qfQk4eiB5xb/+8S/zdxutHIcv2xItWS2++FzWrnWz2EKg23Jj5Q3n6FrHBku1cz9s5smPA4sBY4IfgE8yxflP2zYxKJt7G9OZUWovxCP3l9GJrc+dnSF6GBkOYBnIqvYGX/03BoHWU8RGzhD+Y8us1i9Q6lDzJfVwptPw1vMVjUsCIwqfMikQuYu1Qs3IpAt9+AKypqj5gSfLyNVLqQWk1dQxUCFs9EI2Fsqi5P4eG0oW7Q7rzCC+rqjVyNKxdgEQsImBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkOfDWJlZv5oc4CHxVh5QAO5j8I63MNBBB0PJ+g44FQ=;
 b=bcN9ajsOOmOupa2tLI31bs0fgHLYpAPN4wINDOCq5GwoTRZvXQqCWgQi44DQIxdyU9faGVkETTQSAualpIUrUeWy9PzKmK+VNH7Gxj2G3nYjmZTvqp6fRYuXJJW51hIMxI22XPsNXnp1OfUi4IWM08DJwX4hR/KFOi6B6eTruX3cLICnARy92bS6XASrm0WAyxdeLHLUh8UMxfH8Q+NewidoaQS7iDNMGShySkQBGKY6fMYd6cihmSY3U5uTZII+vPFsVW17YEj/IzmjDjKwbZJmCeMcesUKbFdEi+Mk3NRyjkY3BpzcOXmBCww6ib6XltcfGiOiPMuKraNbr5HPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkOfDWJlZv5oc4CHxVh5QAO5j8I63MNBBB0PJ+g44FQ=;
 b=Hyj7VI+s/Kkm8/5zlYYUbSrgUTRi/QcpXNEZzTERvfguGTQlYGeg09zg8OmkgjO7gKapT4+EKSOjfhKxzsKME1ItWRstVRu2SIL/+ZpyhmOeTJ/XtPnuCz25oJdk14+yUF3jKOOuxVPgALVPb/EELydhd+beQ5FYq5N+6RBtpjI=
Received: from BYAPR07CA0040.namprd07.prod.outlook.com (2603:10b6:a03:60::17)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 04:40:09 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::99) by BYAPR07CA0040.outlook.office365.com
 (2603:10b6:a03:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 04:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:40:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:54 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 18/18] drm/amdgpu: set powergating state by vcn instance
Date: Wed, 2 Oct 2024 00:36:27 -0400
Message-ID: <20241002043627.102414-19-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: f5539124-fa0b-40d6-fc3b-08dce29c4b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PK+FsCxT06BJvwzPNT8hiEbjjDEBeCxxkzVI/s3oUPVgVRJstwrAOmatPBvx?=
 =?us-ascii?Q?oE3L11kq1tGhzTq1O99BzWNQSiLDoWHsLJ6R5svps51sBUePJvtnxqvyQHSu?=
 =?us-ascii?Q?sTsCxRtX5nCnExcdJAHD/gS9xjVbh4SrY2mYobL0+e1XRaLzHUxPyxAnx5pQ?=
 =?us-ascii?Q?otDkd8+X2bWbw8F1cnYNoIYX0mLomCCBlcVuV9soZ941ek00xr5JR0Hgvby5?=
 =?us-ascii?Q?fK4iaIDol3E9DG0pSmg+ttkHKriCHBdUCd4nNUpMTnzH4DMR6u914nYDxBUo?=
 =?us-ascii?Q?VpK8iN06LSr8w4fDBsu6Ce06B78xI3+QcgMdkoftTwHvEnNCrPKM2rwMF+lv?=
 =?us-ascii?Q?/fQpcbEUmyLbYIB0ZmFbhm7Ahc2DHAxCBSnUZBKSYatgoIMfYvwEjq7xp/fr?=
 =?us-ascii?Q?zvQLlx1dctfIn8+FcHa+DMRaDKGaCOatnfdCaNF9S0gJ2K8/FR69/5wFI6+2?=
 =?us-ascii?Q?GR7DNDRNPa5WZ9QTsUYTAjv1zqMhR4lj+3dYMO9dloY7nMV6I5wRqlTBA4o1?=
 =?us-ascii?Q?cGNDn4vm+lgpYRdh0zSOAofCsJfHjkamc1jZJAJnaoKRMG7g+4KG1wMDAjfY?=
 =?us-ascii?Q?aKzl0RFb9sMbFm5VYiPryE6Tf8TsQleJKjTQ08xYumJTBl9ZshI4L1WJR8B4?=
 =?us-ascii?Q?fqEVeGc4zkC2M8girCpyOflt0Fhr2oF8jClenOBbhcwkmLGJ9A4c0E/Db8aM?=
 =?us-ascii?Q?3irwJiecOcZtCY/EZhZK630FBJuSxjpnD8+AJfGt+9nGK7DeCMJD+FOtqzwE?=
 =?us-ascii?Q?NCdMz2IH4HuBLOlH7ut4PyrmfphuuBufjq5ac+qxEy69WI39fkznVl3Q9I+4?=
 =?us-ascii?Q?zazSOje+upGs/fV+6z1q0+hJHDaeIBiCFvHnUtunP/ibgnfeWhfg4oAP0wuX?=
 =?us-ascii?Q?gU46PUg80gqLtY58XB+gzVU5rDX+DpEHUD4ZYhujz6uM/LNPxtJujqidkoKY?=
 =?us-ascii?Q?zJz1Gp/ioQa4SvDiixwFDJRl8A4ny+MMArxz84F6H4SYDvPrz2IMfcf1R+Te?=
 =?us-ascii?Q?VZ9i7FtKOalpL1HDOVzAvMz5p966bf1Apd3qmcUU4qTANzgSsbn2xsKOaUHJ?=
 =?us-ascii?Q?EKnbnS+Uq6k7on+lJKan64JV+anjsdYckruG3A29dfH7RuRerPP1gdvfDJoS?=
 =?us-ascii?Q?SHDO93kuI4FKaZVo16DnNjZYDaRqcK50TueIB+sRYM+otf5x6hZpRJeDKYkQ?=
 =?us-ascii?Q?3rHBB6Vx5Eq9Ww8RyhsNJki7ceKTHphc++IVwCKEGLbTJtzSbcpjRFjLsE9J?=
 =?us-ascii?Q?bkWTZhuD5H2G3C5bIm0BdpUEVMpqCrsooh8Ls+EnDb0P8R8F/8ljimmWGPU8?=
 =?us-ascii?Q?VBB9Jg+zyGeOODym8w8AYEcqOYBZF8FATUl9xJtopl5GuFGKWZWnN9R1q89K?=
 =?us-ascii?Q?fepSmu4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:40:08.7422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5539124-fa0b-40d6-fc3b-08dce29c4b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Set powergating state by vcn instance in idle_work_handler() and
ring_begin_use() functions for vcn with multiple instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 28c5e15d166d..9a8e8f88e1ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -410,8 +410,12 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
 
 	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_GATE);
+		if (adev->vcn.num_vcn_inst > 1)
+			amdgpu_device_ip_set_powergating_state_instance(adev,
+				AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_GATE, inst);
+		else
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+				AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 											false);
 		if (r)
@@ -436,8 +440,12 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+	if (adev->vcn.num_vcn_inst > 1)
+		amdgpu_device_ip_set_powergating_state_instance(adev,
+			AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_UNGATE, ring->me);
+	else
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+			AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-- 
2.34.1

