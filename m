Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3F2C54E68
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EACE10F3A4;
	Wed, 13 Mar 2024 11:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ciz9vHdK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D63410F68C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3l4anMrkfB1pL9UiyM6B1hx2Wz2GFlDy8t0bzg5vqEaSO0bCNqn0GbXlgWmA39V2htAdZg5J3YF9xJbYvJExrpkfZcliYPZUWI1UiBgF9lmmv9mYZY8hKKH8VzUxp9ChuU7cSHYENpvsPIFm9u8RSBzk03jBIRjxt0HTWA54QiKACiJP0fo1a9xvL4JY1YhpNClYHqJ3sch4gwCrd9KpHaY03u39or/cAoRs6FM6RQoaSUcXvTt5mzLUUTRII+pzLlDgXhvzBiK3P8zJH+mMC+5yAXNrzkd9P9IcikpblYNuN6K+fQB0utA1JX51f34A30+IkcJ+1XjOfoqCTzYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCxOhKG64yoUxayUV7XW3yrWuEcDLqT9pESG2QRMzUw=;
 b=kIPeysat1I5cwW5sSrm7QY+UixTF4RsR2BmUQOzXe+pZA4kUqknMBhZhlJTz5H+tNQdjcQWJulbRFuH6zZJ+0wHfESvcohza5IYYGxHUWzOgH/Kv9K8wc3olaf0KPfr9y/frK8MF7Fd9QUBvnVLu0mxxKYZ9BJW/vTp4KueJrenWaxm9SNlmvMBlKGfvTZrhdSBSbZJHgqa1PxlTl6QNoy1xvAMRoUChkKY0nrYJNS4CCamxgsw9ecLzkF8vzjwYFH+K/aXRIvWqiwAm2eS6CtH4KdL3G2FTFsy3Z+IEjyiI8QAZ86Z4spDOpPclT3HgrOs6N6i5TNN26Jnk/TSQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCxOhKG64yoUxayUV7XW3yrWuEcDLqT9pESG2QRMzUw=;
 b=ciz9vHdKu/ogoZnr584G1hLtAl7iSFuJJ2x6X8prmsg0CD3ptR6Ot9T24mUHhDciN8pZdpP0ceVd6RIdGji6Ox5BA8q3Ko4qOpSwnmpJncvDW1Waf3yjo7IBBd1lxHb/xTCiv9bawEQ4N07UD956euWoQ68K2oKSSHyn1qmz280=
Received: from MN2PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:160::15)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 11:03:31 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::49) by MN2PR13CA0002.outlook.office365.com
 (2603:10b6:208:160::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 6/9] drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
Date: Wed, 13 Mar 2024 16:32:53 +0530
Message-ID: <20240313110256.669474-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313110256.669474-1-lijo.lazar@amd.com>
References: <20240313110256.669474-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d5b013-12f2-46dc-b65d-08dc434d37fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGFVC5lRo2/xLs1BzL2gPNjwdug8s/ceeH1hh/AERKk6xxTRhP9BlFbD7HOEMVZicisCWXTB9fwguvujop+FULgaH56ddOJa0RlgsVGD8QJSj0W9BZ22RyVXHIktAQM7zbTMNNFglJXZR1s5k7POl5rMhCDut6k/dyVuds807EXqpiMGAkg4V3rHC2e/af8B29+QiQgmG/EuT4FAdfmKPcxZHtsnem59x4FlHIsHC7nfxO/QVz6wOutdp/XWYCTYLAM55Xjbf0Pj7kJjPirfDhj01IxWQxIvWPdomOmLpxhb1hhsp41j5d6JaOO2MeVKKSaN5H89TEpQTw/O9S67oLktIv09/H1HeEopWcjxZhGxBlUdmI0eh1v9i2LOagP57lk5W9UR6D4uBRg5FLJqDwRz2YekdmGoFgY0I/X0RhVwRINdltSBDHK7oSPO24/sWiSri1wB7xg9Y2qvvIA3E4hG6mck0qIjZNmFQrG0S/ZGH2VdaVSLaBHInKTVLcTnZSQtfu2NsV/KG+4vTamgsI6onSqOctH0pBLrTmmfNVM6sKBgKCP0yyog2fJfziuYAJez+GnUbn3ZriuB3tDLJR2OJEHoex39T/VKqB0l+Dt7saADTgq5cb9SXiJmH2z2ZJD/I798EfxOlrndRbt3vNj0xt+KZR17Pik3cjD2bvvaR9JWbGR21z2R3vx8a9Dea5kdYKgS25VUG5IIy1AB0YkDd/SW/PnUFt8CozYs69Z8SFduwHL+X0P7DXnXoCWB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:31.0306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d5b013-12f2-46dc-b65d-08dc434d37fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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

