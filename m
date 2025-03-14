Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDBDC35FF1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 13:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5EC10E9F2;
	Fri, 14 Mar 2025 13:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CgONzB0Y";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B51E10E9F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 13:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNHw6+ICtZZv+9FwgWjUFIvZF/WX7zY/nBp+ZUQ/iDg2HpVjB1o9QLyAFO2BZ9sBa6nLoYZGoT3XHHPsJMV+016PXs75trWySFseISLaG0IwwgVjSotviMXmpX8WUxlqoKfnK0pkVGvrvXt0IriUwaVJnU8VREK4MfCUiJjJfpd8rPZgwiyUiZEIi78nzJv7crmorxyBkdateV986Dg+GY7pCsx1yU7C6uxQsfdzj3Bp2jSnaqyNd3Y+6KqJYE/eWDaiB5DdmuAUIZQEkaOrPxWSVErohaP6cBxepfHBDrWYPdxIkH92L6ZPO8RpCS0aTRVa9gF2sp0x23cnxja/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVD2FPE/zj9aGNukWbp4zjExGLLEoTxPDEyXCvNx4Fg=;
 b=HcxcOGWWcUiZk5FgvBuge6NZMj73GoyYUp6MD2PPDjomxMF312sdfpjeR3+FiLTeqBJNUKH5TQIrosuQFBQRftilSt0CaBKQbU4L79LO0v8/rJBvikdy1SDx6bfnI4DoHGDvfywwodhVydmjo+NgWCEm3JlC7eYB+gm2HDcdw/11C7yRv4c8QN3+bfc5onTxcY6Ubidd/0jpjhfGFPzY2kVcMDfViVrysIbaLGRE7mFwKXNkDq6lSLUhmLozbRSGot8Ty5LfGomW64lRAaMeyIdq7Jo+VZwX0pQ5Fk7lXQIj1IQKPP4FPOE2nOsBUSW1vRUkdrEplsEZb/5xLzVcww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVD2FPE/zj9aGNukWbp4zjExGLLEoTxPDEyXCvNx4Fg=;
 b=CgONzB0YR9BLBK3v6DmKQnRHGoM36q+gA3aAUExYEKMoAUxQOR0sdPGsaCx+1IVzx7gpTjOpkkPgYseHYKmsoAlLQ2l/T3tDzvyBWnBpFKmxPRNC+sN6XnSOxtqBTnjw2VkJMiwarybpiBGfE80gAVP8iErqYUYuTJTm1ShJvXg=
Received: from BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30) by
 IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Fri, 14 Mar 2025 13:47:24 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::5a) by BYAPR01CA0053.outlook.office365.com
 (2603:10b6:a03:94::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Fri,
 14 Mar 2025 13:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Fri, 14 Mar 2025 13:47:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 08:47:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: adjust workload profile handling
Date: Fri, 14 Mar 2025 09:47:07 -0400
Message-ID: <20250314134707.3012124-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314134707.3012124-1-alexander.deucher@amd.com>
References: <20250314134707.3012124-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dddefa8-53f3-482b-b3db-08dd62febfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJaxAgmlheapjwKn/GYhn8PRg2HBjACiLX5PJ9fJa56d7hwpueQVUOrFGBTD?=
 =?us-ascii?Q?Bsz16uesUX2LX1s2IqK4EO7olNqNaxUIayhskSyZOVk+gnN1r5IbPhcRtcbO?=
 =?us-ascii?Q?eI6Z5vI1I9LMXO/SDBMDApP0zKUG0wr3HAff7677PUGkIYqsiHvsQexBKvWN?=
 =?us-ascii?Q?WaN120rJ2DVqmY8ypunQKQY7PukWIvcb1ACZ/mJLAO78nq8aX30OOSKzLWys?=
 =?us-ascii?Q?V2Po93Pg1QJyyzLkb+cF70Cgu3hs8QVH+wU1HyMYVww8Dkxst9KONMzZsDX2?=
 =?us-ascii?Q?uGDPzmpdVU75MQ3DBB14o7VnO75c5YAuHIOR0n8x10uIT63bcqgAdWhYewn1?=
 =?us-ascii?Q?tSjwDe9z16F28YXLevfisZH3PvFRkyZgLjHjAikRpknDhggUSwo9OqmKqS35?=
 =?us-ascii?Q?aGJsyZCHw2JcS0D0w2TN8FUWraQXzMFeYfZ/te2+cWQvIIQfkwXz2DNg3ykp?=
 =?us-ascii?Q?ZlxqBNGdCJ36g+F6OSUH6NCpKbJcyrk/coYaGA0LL1fiH3Wezun0sT3X1oFm?=
 =?us-ascii?Q?CVjKbTGie5BwuJK9KWud3BTMS845E8PbP1JJQ701qjFTxWbLpmR9/mffccaS?=
 =?us-ascii?Q?5jd2tB/2Y/g6z6LGEai8zWBSeiR5L6VkDY5wRIJWGP5ZBRmMM6jExI0nztpQ?=
 =?us-ascii?Q?UV7wFFZ8PvjmLfNRvWwnd4yudV00Ty5uKR2UsC/8sM3eI5d++A68OMvUeYEj?=
 =?us-ascii?Q?EQm9gGnhMgLVm2mD3PkSyMQ8vXYZHJQo9zSAvH32kv5wqLv55mYXca+5MoXk?=
 =?us-ascii?Q?qLl5A2Hn4iHs+IV7uJSgKBF03LVIA93mASg6dGaMjx2iNGa0RbmEZtYFWe3E?=
 =?us-ascii?Q?IySyE5qDhXjURLGZfpZce5VpfJdgLCxOWAl+8n2OJdZkN5n9fn0wkHvnDPgK?=
 =?us-ascii?Q?+4FhFWrXTMreOhisSemWl2ATWN6tA61qPe36MtGxtXPBsAbNgEKYuEiIeuM5?=
 =?us-ascii?Q?qUPMwvuIrWVj/Ci8XBW7fkhUbKpRU57WiPI3n2vLg/JZhtZeQr8l9rScM+SZ?=
 =?us-ascii?Q?yz165s8OFTI9pWplDMC/PjXjnk4JFWTiZSfA4tAn8oA6fdkswgst4WGIMSLv?=
 =?us-ascii?Q?BR6TdtYJCQAaS2eZyvJEDxrHe3fBIiZ00xjTZt6EjqO5qrBaCC5SiyLvf7be?=
 =?us-ascii?Q?ttILOtGVyrTRo+UtPRvQt2kQfvmkJecNIisAz3fZkiQe4+QeBvQSivrhRvOo?=
 =?us-ascii?Q?G5iYyE2i/J69OGHp3/dqYoMplU6NK6QfgIvljajMAA5xqCNrVpBqHeF1qwfd?=
 =?us-ascii?Q?EFqXp8beRFUd2DhSGFFRtIHd2lVfKOo+PJ/Zyig2RHArNxPAD4F7Q+zWYEK1?=
 =?us-ascii?Q?VjoueZEaw7MBzEJ82z5gEuj8sVrugllgvM1aCBTmkb7M0Q8j4pmAAWZOdX+4?=
 =?us-ascii?Q?2Jbd8XoR74Hg1SIKgLhjGxcJcUFik3c4Im9L7RlEVbj5X8KU0ihzPPkcAs7f?=
 =?us-ascii?Q?DtseNLbCVIzEAQaAOuJD7T+440TIRjA2+gGihDpQglwnL7YhM+ScxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 13:47:23.4322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dddefa8-53f3-482b-b3db-08dd62febfd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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

No need to make the workload profile setup dependent
on the results of cancelling the delayed work thread.
We have all of the necessary checking in place for the
workload profile reference counting, so separate the
two.  As it is now, we can theoretically end up with
the call from begin_use happening while the worker
thread is executing which would result in the profile
not getting set for that submission.  It should not
affect the reference counting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6b410e601bb65..0ab74b46bcb0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -460,17 +460,17 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&vcn_inst->total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (!adev->vcn.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-							    true);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-			adev->vcn.workload_profile_active = true;
-		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+	cancel_delayed_work_sync(&vcn_inst->idle_work);
+
+	mutex_lock(&adev->vcn.workload_profile_mutex);
+	if (!adev->vcn.workload_profile_active) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+		adev->vcn.workload_profile_active = true;
 	}
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b4b8091980ad5..8c7c50f34fce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -169,17 +169,17 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (!adev->vcn.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-							    true);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-			adev->vcn.workload_profile_active = true;
-		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
+
+	mutex_lock(&adev->vcn.workload_profile_mutex);
+	if (!adev->vcn.workload_profile_active) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+		adev->vcn.workload_profile_active = true;
 	}
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
 	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-- 
2.48.1

