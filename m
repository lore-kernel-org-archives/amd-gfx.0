Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656C0C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22E010FABF;
	Thu, 14 Mar 2024 11:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ltWV+06+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3947510FABA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8JcrvMBVjNXEA7g9LEDdb2KuZTcxStat3gFMiRye/U0wBa+Y/LUM1S7XvU1lx4D7c3tLP+DPa01muY5YoAuYwKUNHLjsAB2P0Y3GHoDLvqyHOpedbDBvw2HVCRJEd70rYnNk3AgIKUnF795GH24T7rMEVGGPUqTJUS+mkn7iQd53KWfdNx9EE1da8ebQI4fYZKT79U9tw9S7pfnCQ/xTFYJtc6ixODZVyRMUNXU6cdl5YdX87qcLRUKDp0cmrWAVP0EEiEjWfcqjIuDC6zSRXJo78CQX52qk6VeuleGvyp7HV0QeX1hUYwRJq4bHyeuj0/tlpR8Z06/Ou0CZoEKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCxOhKG64yoUxayUV7XW3yrWuEcDLqT9pESG2QRMzUw=;
 b=bJ4bM/Y7ZWEeDitUODWxOJof5i+1CTphcJRlpCofTXY8SIssKi9c6G4OOyBGnq34UlzJXN+GbkyLC36T/6c5fM4PI9Os4J+qsePxHg9xLzoQI33NJiPlL955heUR8oCi40r4NT6Rnrw0+4ppYBOdd/+uWqT/k5Sgfxb5WBlxy7QlOp0RWI5ATuPwJu4ZVuoO48sCKfZ1Tan9pSYsoqR8VA1gw8PdD/O9z8fylatRbHE1ewCP5DsW6dnGzteLTnXcaI3FGiXZEgEY2HW+gRyTiSh4zNAaVnW11+otJrf5GlPCbK10kJii5B7J8RoZpynG8E5HeLWLyxeztp3wDqbOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCxOhKG64yoUxayUV7XW3yrWuEcDLqT9pESG2QRMzUw=;
 b=ltWV+06+AdlNFUQCyR26HPZ3qyryG/kbxVPOfMEYBP+7DLslh5O6UiNBQVWZfdPj6wc+g5nc1Ws0vuYDB8XIxmrxnx+4FqPS87kEKkfV+TnlWdByJKXLh76BwDki8CQfjME53hSoNsS+5BSSfuz2W0sZqfjd3wu3kVFz6UrywEg=
Received: from CH2PR07CA0036.namprd07.prod.outlook.com (2603:10b6:610:20::49)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 11:57:27 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::76) by CH2PR07CA0036.outlook.office365.com
 (2603:10b6:610:20::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:25 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 6/9] drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
Date: Thu, 14 Mar 2024 17:26:27 +0530
Message-ID: <20240314115630.682937-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314115630.682937-1-lijo.lazar@amd.com>
References: <20240314115630.682937-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0e4ec4-2d4f-46fe-b2d0-08dc441deb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjUbar1Odi2ocQfnhNbWF8CaInwl3+5srTC+hDc/qyXFfQS/eOL+Wt5kSIK/U3pv+Nn1zf7paNLyK5Z91wKiJOvCZClj+I71NhqzLjKMIWjASp3oIN6IC2nB3X82EjwI0Pgzp8KiS2yBvdw2yXJZ6T/dKQBQN5JAsVTq+zPfWet7ktnGwLXgzdLhnYNHd60apmkuhZplfoAVFoBcb+N8dtU/kMgI9JBKU8phio1nCw5Hj1WGZK7uKSIqAdnYziMW126S4E57LoxPWd9zjAYV9+rVV+zCmFfIHGAPzhO95tMx3WEN8QFde2WHIftmAznxPsYiaGwQ2n5Gxs7aQR2HMDtwlKnuKEr2I259ETv8e1csOfBtr2TewRhAWfBuBC+nJPS4b5TQexQNMhaD5W2+2Oc9jzLBqHWWrP2x7x2qcwT4idcxeZrfNPczl6t+Mz/OcCKBCTgTTAYKFg5GXRuWmgMB+dp/86JSYjAhTAtQrz30UA7RRmbYNBu1Y35YpdWsXXsW6krv61iuekhAg0RISKdALpEwNgtQWkxnbA+Mur7R611Pw7maIVSJoAcwwGG66bb3oBHAH0MT+9HtcLcNNPp7bLinu57YzdYPjse4TATbkUb/V5w1Pg0UQxi04ay9LsuvhOSsuRK4GcR4CJ09dAdYOnOmYpTFygExnbYubKU8fE1DcuURxRk0c5CkgqCWVT/fu+suVVRGjwnPwlg8N5OXSNl7fdY7zTYX2dqIicwmdH4wpLG/KvBGXpecYZsC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:27.1424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0e4ec4-2d4f-46fe-b2d0-08dc441deb4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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

On aldebaran, allow changing xgmi plpd policy through pm_policy sysfs
interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 0467864a1aa8..a0efc3c39e64 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -266,9 +266,30 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int aldebaran_select_plpd_policy(struct smu_context *smu, int level)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	/* The message only works on master die and NACK will be sent
+	   back for other dies, only send it on master die */
+	if (adev->smuio.funcs->get_socket_id(adev) ||
+	    adev->smuio.funcs->get_die_id(adev))
+		return 0;
+
+	if (level == XGMI_PLPD_DEFAULT)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
+	else if (level == XGMI_PLPD_DISALLOW)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
+	else
+		return -EINVAL;
+}
+
 static int aldebaran_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_dpm_policy *policy;
 
 	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_13_0_dpm_context),
 				       GFP_KERNEL);
@@ -276,6 +297,20 @@ static int aldebaran_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
+	smu_dpm->dpm_policies =
+		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+
+	if (!smu_dpm->dpm_policies)
+		return -ENOMEM;
+
+	policy = &(smu_dpm->dpm_policies->policies[0]);
+	policy->policy_type = PP_PM_POLICY_XGMI_PLPD;
+	policy->level_mask = BIT(XGMI_PLPD_DISALLOW) | BIT(XGMI_PLPD_DEFAULT);
+	policy->current_level = XGMI_PLPD_DEFAULT;
+	policy->set_policy = aldebaran_select_plpd_policy;
+	smu_cmn_generic_plpd_policy_desc(policy);
+	smu_dpm->dpm_policies->policy_mask |= BIT(PP_PM_POLICY_XGMI_PLPD);
+
 	return 0;
 }
 
-- 
2.25.1

