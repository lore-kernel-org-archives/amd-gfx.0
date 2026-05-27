Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954A9CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 15:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3664210E7F4;
	Wed, 27 May 2026 15:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UwcOaI2V";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C86010E7F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 15:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIaAI3mw/Wg8CQ6N4D+/MLZJCG7hy9PqkqKMKvhQfciqifxKN8K4Tyed6GyPPUMmlUxb+XHomMXRSOjWzohwWdQ+0BMn4TzzGhac6KdBvK90m3k2YgWhfoHBQaJqexzgRKSP3A3jeoC/7Lr4R2MYjg5BqAHRZaphfz8Q7TyEOOkmhz8fiTlc44jmLhqDMhL5pvMEuOXW0gixnLrO8TNKcvpZrEmPYDXXkdJHrHiovrTvzsxH+XhxTrja/OTw0u0Ro9b5CpaWL0dobuVAZnYe//4RlhHCBEcfsDG71ITBoWw+pvF76+8vyer7xBT8cxOPof1e/F5kDoPK1dzM8fSmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LgHH6A5VJISKoaVSHAMxy9vW6BqLPy/ekYaQXK6cRQ=;
 b=cZYf6xXtR0/+pviAAsCCwnKXksK7LoyU3Mnn4TX7E7PG20lvcOPIQpOF1IkVnffLnMjQdxLdlFYIRsxPBpPleEtT00gPBDWuXFAuA0VuZTuysiOpykr4h9+jMK/h/Rs12BC3wcFm+MXRxTqadDABnwvNLH7b105IVv2wDicaNdubDQ1D7VAwyznELVEGQ3iKBb6qNNw8zC2Tj2fIk9fI5y7Gmke/rJOtxgGV7d1GSAF+2bhzUe/Vi5vdx8BPeg1mSytqCtz3J8vXz+aavXnXUUUXrrVv37S1+MDDPXOd8xGMMywaLgyyyUCgUlOethxnYdIaEakYBufdze3M16+GKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LgHH6A5VJISKoaVSHAMxy9vW6BqLPy/ekYaQXK6cRQ=;
 b=UwcOaI2VSzbwxkhLbWN191WC8Lu8RxvP2TSxxrHUmpqlIkU9X5DX7ekii2K6e5IB8iDKmFcqogapA9kjmIM/hji+8C19pFrh769GEvD4Z/K9yBv2y7kjpgBayn43q3HsqnOV0HDFhMRY9wTuwYQKJtCETVrYKqKkMTyugyn73iY=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 15:33:38 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6d) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 15:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 15:33:36 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 10:33:36 -0500
From: Alysa Liu <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <amir.shetaia@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: fix UAF race in destroy_queue_cpsch
Date: Wed, 27 May 2026 11:33:26 -0400
Message-ID: <20260527153326.137687-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b479f0-7e28-43f4-8c68-08debc0551ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6j4XMCsvMABbKa4oikmvrYHo5Bt5OoEeD54gDKJlIQ1Ndx2fJrnH3PePZwpGz3O4IvTw2HeRxhIAVQe1zvT4UhXmgvr1q0HzmnmiP5Jo0Zf+yzZAnt5oFt6FEFFc0Ec2JSbiIYAnRiv4RmlUMo+FhkLPt/qqL49kfn86PB7oIuPm15EleUk5DxJQSh0mufc1Rro1O1kvSucfzH35/6Cvn1ecNqbTphSw3roKpDH/LTiGVe9MSpLfpNv+AYBZQa+DKtg3Idz8ldL376ak3xZQTgvdCjnUnS6fppt1X10s0EGbGKg40uT493dz2tsfimVyOKVH8Mq4+qVAhdFMb7Pedv2EeeMhRFGz3/m/kepnmEfHs+Oz3vZwKYwv2cyiYiVevzvOhfRKjc4CZElcSCn6K4TtTQG73YetP/4FTE03Oel2uQYtCLuoHiXQlW39S5GzpBqRQ2/zzlygu5KGv/L+LxgikbioDYU4/pjqfKWCqtBU7XioinRO9aSAMoNyXw7s4lK+oq4ff18art0gdFSMF2nY6fEyJVf8rMnEl+tDhusSZbCIUFvzctY9luvOd0kDIFx3oB+VDJ7zJ4xxPCyX/qmMsCP8sp/cURSo1u/Vj8Uk5JkvLDgSSx34JptiXvWVL4f71Jvc9eFagSpRAhlr2CG68sbMF+zPiaiWjWUbxfKgupDfOm52t7QcCTvj3a2dxhmPJgKSAgFRIRQkkG+6RoBIO8JfikiR9CIyLpmUzWE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Ka6mUS35kXsI+3CaaNsYDL2MidHqbX63SQYs9CADip8Z30gSItrtyhuzLkEL9Q+GUU5iV2PZrU4MXcQ6TkwQYcMAoo2ZCwKFYlOBYIMF4ZwYC51DPpmyZFxZX/iAYzL/KqemOEQKoMPRfFMjC3ehH6TqOlADdgC2053NauzoRwMKxD8NFaxS5iPECQu2z0DImCIxoR7TXfwx550840WLDBQFTsnRGm54/NO7T7izbh/VM0CsMTEFootugnDLzmybKdLdIt9D0K7Y+SJSTEGabrZvc0xcuvq3khIrN768MJnGN+l3K62WTm+5swbCjqgGkUWxMimlUiwZNXPumYw8tvQFMz1zNnWy38JyzTqXkEelfw9CYA95Z3VORFoCEvprUMtbHmdIW1jLve8jhREUR5ialW6QEFEl3+xV1GYCs9n5SUnJWFn4eJzyyEMoNHE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 15:33:36.7836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b479f0-7e28-43f4-8c68-08debc0551ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
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

wait_on_destroy_queue() drops locks to wait for queue resume, allowing
a concurrent destroy to free the queue. Use is_being_destroyed flag to
serialize destruction.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4c2378bbdc95..4c383d549ab3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2669,6 +2669,9 @@ static int wait_on_destroy_queue(struct device_queue_manager *dqm,
 	if (pdd->qpd.is_debug)
 		return ret;
 
+	if (q->properties.is_being_destroyed)
+		return -EBUSY;
+
 	q->properties.is_being_destroyed = true;
 
 	if (pdd->process->debug_trap_enabled && q->properties.is_suspended) {
@@ -2681,6 +2684,9 @@ static int wait_on_destroy_queue(struct device_queue_manager *dqm,
 		dqm_lock(dqm);
 	}
 
+	if (ret)
+		q->properties.is_being_destroyed = false;
+
 	return ret;
 }
 
@@ -2774,7 +2780,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	return retval;
 
 failed_try_destroy_debugged_queue:
-
+	q->properties.is_being_destroyed = false;
 	dqm_unlock(dqm);
 	return retval;
 }
-- 
2.34.1

