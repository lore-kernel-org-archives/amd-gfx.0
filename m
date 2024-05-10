Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E289CC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B5910E11D;
	Fri, 10 May 2024 02:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fZZs8OrT";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6FA10E10B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3fljJKDAoFCrgevGeDZPZNMZg2Gbr3+KQFx2RyIgxG1n2U+m0FAx2DJKFEZMCLq+n44XztMcHAkVlblLz3/VBeBWScwFY6tHTYbS6Pmzk/QQ/QRCSKNQuP8j4SmwGgGKb+ghM93ZrfjNCObi825OlTDSgxfcT5R4MAYdZGQb9p709ea1Cc3JXysMARV1F9EKUoScmrsW5/96P1Dc14tzo22H1UgLvn52181M7rcfiq80R2awogvW2GC1SUDL0u7zQFOFochA/2h5cvGq6OipkkzahsYAQkHbcVRkxdTEpiQC8smh44ClEwu67h8jqBY3FMHc9Wru7LtbG/xwMsZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=740X4Sg4Q6KNdRCVeNL76PAUiHSH6nyMhzn59FgVi9g=;
 b=WTczn3AW7jYlIe/Una7JYVoG9fDSTrsZNLqjTDJ+kDr8d/5moHEOM8bGSeAV9nqOaguA4fiV9lEJUMvqhp9NU09uqrCN0tS2xa4W1bqA6qfRd/cDjv6ELewCkMgBg0tyU4jt2MEpdotdM/mP9odudI4nOpBC+CZBBBcM0RUlqTueEg2TJsGwYMkdZtJl+k4sAyToMuwlPhv6FW6gVfvMIfBQOECoPLZo314htoqBi+PTW9k71xB7h6vaibScbND0nnHSGIhtHiS+qLXUcB9COACNa8/PCH01vyaldKcRUjoZgUzoD/65YChjrEU/uVgfXGZY4naETDoM1siZ7CV9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=740X4Sg4Q6KNdRCVeNL76PAUiHSH6nyMhzn59FgVi9g=;
 b=fZZs8OrTC4plIxJTTENmt7luCB0pqJsLuD4WeRkgiysVdkB0JCwPHxZCTO9COmFkz9LGfDnRwmnKEQ8DHywbT/RTugJB0ygHBXb5PZzJi0kyvPenJvcTLOsUnRG9vAs/A0JsMpGkMW2lPYxBk5RjNjczrcepmo7CVbZDUKHx16Q=
Received: from BY5PR17CA0057.namprd17.prod.outlook.com (2603:10b6:a03:167::34)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 02:52:56 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::ba) by BY5PR17CA0057.outlook.office365.com
 (2603:10b6:a03:167::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Fri, 10 May 2024 02:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:52:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:52:50 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:52:43 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 08/22] drm/amd/pm: check the return of send smc msg for smu_v13
Date: Fri, 10 May 2024 10:50:24 +0800
Message-ID: <20240510025038.3488381-8-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ca6bed-fabf-436e-2f23-08dc709c4b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sxmoFlnbvvHKOqp6OjZUsfBvQ2iWwks9fyhEeUelgHu8ygPDxOe1Z8knMBPu?=
 =?us-ascii?Q?2Tin8zf1LZBu+0hPLNctxfjotEu4iTfXQeP7yZwmSYyGQwGSEXBEWlq6jgLM?=
 =?us-ascii?Q?pgyBB2nJ+EMOqJqxjhOMGmM89tjiBsRa9zKjq0GP1n6vURogEaNTTmWl3EtV?=
 =?us-ascii?Q?h5Zkbe9m/ILI2vPRAdPTkBvrex5DnwafjWMS3JJTT9MGDDNDkufZUdnn8lSG?=
 =?us-ascii?Q?x0pPoRKkIPQPw5we+1nDCCocwW7cNJFjtHPRF8ytd5Hospy0oLe4XglAnZ31?=
 =?us-ascii?Q?SV6Zre8a28jZ1OMX3A7lrkFQrRaEwrMXPqBysH5PvQ16YDAlJhENqVhCpcjk?=
 =?us-ascii?Q?6WP+qbvn/63CMNyYzXXZ+Zh2jJzuHTHSSIR9+rjdecqyaLCt+S+90eWnG4qh?=
 =?us-ascii?Q?DKxouyKEiY+OL5bLLhfDXBlEdidcaE9QDE0IPy2Obc550HuY298Em7zPy4pu?=
 =?us-ascii?Q?IL2mvUnEEckdpQtnYymnBh6ty9Nx6DtP5OtliB4dUGpua7zpb1O3fRvgnD4l?=
 =?us-ascii?Q?Pk74KPQCiHqyo+8byFZTQpRuHQJrEO84fdy/JjCyl2Y5biZHilCeh7FHWlvV?=
 =?us-ascii?Q?n2Wf5GonADED4kmvZPruWw8+Rls8mnj2Fb8vctpuYVhOMlhlnqMFJo/02i4m?=
 =?us-ascii?Q?tpQtg0Gh6vAB11QmlJnpTGl5+vPrlYVgbHxw8nkMQ854VAfswCl/2R+6FHGo?=
 =?us-ascii?Q?5qQ+EwAHxUmzexU+DVpZaFtG5tqXqhv9oyZBWoXAH2uVLPMoivKSGpOLEhaK?=
 =?us-ascii?Q?nnI8/TseLa882Kx3tNs7XEXeg9k2RsfZuvP7JjQLE5S2wXW5eRHEQC1F7BaX?=
 =?us-ascii?Q?TVf3ysdhN8YhIJiOhZq4EJi65SLg9P6MdTR4ehBhZXmnvIOLYiKIg6iocN1f?=
 =?us-ascii?Q?7QD9THNpSRxOTPLmp8qYbge2Wbx3e4mMwhlIKfWnzkScbPyaT2VH/zcku7FG?=
 =?us-ascii?Q?jgqGK86mwCWeCfJj0IpgBMCjGnExYFLO2V+t0NAAilkqcnNkfJBru9mTEgXM?=
 =?us-ascii?Q?hbV8tmpkfsgcNSfPxr5upqJ8GmBZUAsFrzpSd12ULfdNcCE+7Y51RumBvYDC?=
 =?us-ascii?Q?m6Yz3vJXb9J3AijNEx5ZqtW9hevKF1PVTjOVXSsFOIw8FnPwgutztrV7y9KB?=
 =?us-ascii?Q?cT5dXzH/NeQgWSfAfpYeyVexi2jxZjfuGBTxY+RjWDM+0vDP5fnn902QhgtZ?=
 =?us-ascii?Q?iqwE7hphk+qBrMc6N82RMroLo8uLtwsEoVubBHSJkbD/7/cPfd9upOKD/hRz?=
 =?us-ascii?Q?e2mxCR9hxw4WyB9HEUP9hGWP09dr/kR+BSyBgKs9uwhwv47VnitFiPqBC85P?=
 =?us-ascii?Q?trBhBWstckPIlAAqa5Y5+VANtc0Hw3zPAC1mvAMyqG0aUMkat0NYsgDH0YYW?=
 =?us-ascii?Q?vmJSgJ8oUFdpLvo4x1Rc4S9IfLO5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:52:55.8033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ca6bed-fabf-436e-2f23-08dc709c4b49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
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

Set smu work laod mask may fail, so check return.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index e996a0a4d33e..dcb68ab51fa0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2495,8 +2495,10 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 
 	return ret;
 }
-- 
2.25.1

