Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03EDD148A0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD6B10E68E;
	Thu,  8 Jan 2026 04:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="alfK9UGc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9796010E68E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGm96Hyeku9YsE37JAe2xNXBpiY6plm+kp++Rq5L3uG1SfoX43bt5YxtF/Bv8pWwAUMYi8yh852F0dYBlIrVtWbWLqyMMOZ//5PmI+In5NgjO0R6PBuxmI5hcz8V1Z90uTM99QN5oFDZeROg/Yv3osaiaAHherSzSovcGI80oicyOy8bA5z6nz5T8vGfn4xAxpMv/RfiUmNeOW0lR2RW+QwC4ywedVLDy60kycdBGtcJiRXd88A+QSbxJWeci/GlOLjEQjNTcYer8cPv3pC5NoF8DDlypl6AB7UJCXZ3es06fvC25EuQCIkVk7GzIU4ETsIv4mdmdM7lMgopZb6BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK3Tquh9FSQ5FQb4eX+Yj5HA9GXkN+Q4qXWkFAdoXAQ=;
 b=OO4qVZbfr7gPA1wx8gdRnB5v6ssjfl/ID0IUvRtyOp7QZVQSEq7t0+o1K3s/WlAhKYso1j4406Ep8vaSmeP2muE69xaoBn8sNygnwx1T28ynExJ+xOombh8MoUxX/W3uPcUwi2a/Kzt1SJG7BqIlkVqd9oa0chzRuAKsv6nYle9NCBR9fFq3NkMoO/S2IIfzunpGZBYpOGQELz/wvFzDhSJK9oI8SyMNb2hl946X/+qvynS4Q4hrBl5eMVemZje389Fpfb6YUAiKhs5yRK5UmJG9ul+HQLdMhQz5gwbpKILEGu42Yd0e/iStBVEuVld6coDYR1FtwYKuWlQs1XUyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK3Tquh9FSQ5FQb4eX+Yj5HA9GXkN+Q4qXWkFAdoXAQ=;
 b=alfK9UGcy2A7rHySLANx5esttvVX5TbD415AwpAaMFFllGkbFnYBFodzbJqh3XsgXB1KXTcGn45txOUghS7R9qU/AwCWcwZ2WDkpkL/n3+382PHrBUctoEk/ouEqjSnqb9ddOIZB9PpNLZLvaz8TLp/BB693XqjUBrLvoYYhX5U=
Received: from CH0PR03CA0313.namprd03.prod.outlook.com (2603:10b6:610:118::34)
 by CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 04:50:06 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::6b) by CH0PR03CA0313.outlook.office365.com
 (2603:10b6:610:118::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:50:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:50:02 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 22/24] drm/amd/pm: Drop unused ppt callback definitions
Date: Thu, 8 Jan 2026 10:17:38 +0530
Message-ID: <20260108044839.4084279-23-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH8PR12MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecf64f4-24b0-4bda-7695-08de4e716492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?emhJTAOTkFRghyoCUGTAVcxrgin3QXkvDqdq7YudfOKWgY1ZPH9EkehrtRaW?=
 =?us-ascii?Q?I5x41mCxnKrE4PsmoDazMDvcJ9s/i9vg3AdUmuIGCaUCV1inwKdKLDyL4zHK?=
 =?us-ascii?Q?E1GeaLGyRtlWbxPrcGnCSYLlyLrVF+TMkeqCNh1ePpk8CAVLuM+dpujC2joV?=
 =?us-ascii?Q?V94qGtSlQLduUGJVxxysAAXjKECZzWPLjMxHCUpEHfL3JVcOeuTcYz/CcSDn?=
 =?us-ascii?Q?EYNPK7hkcHGmTszyL95juObXSCo42c92aG0MJXE7DeqbDKsQukZ3S8Rtl9v6?=
 =?us-ascii?Q?fBxyr8Dex3lKk8SxrF6yGB1wJFJm4Qzygrkop2IlarMO/o+O7znrk55/JqJb?=
 =?us-ascii?Q?OQRvT9n23kLLm5rcZ3frDUfDziR3qnfRJ+D9pvgmo6TBBLUgmt3/gmTtRhqi?=
 =?us-ascii?Q?OT0j13zvyDHhrJANdv0GVm7Aqhap4IXaghUA6r/ggd8C0Niujokxud82LdJ+?=
 =?us-ascii?Q?JXzIl5ABUkGcmRi0aX9G1Ue8trBaT1OX15+PIfw68YUQDy7cTRRvoNw/WPCo?=
 =?us-ascii?Q?9mNdKlON1mCeAN9byeOxnK1Ai+dcs78OxuQ0PHelwnFbiwR02ZENi1Q0TIO7?=
 =?us-ascii?Q?0uh6gh6csMcHfzapEgkOc+N43aCf/QRWvVJBR5O/35bi/voGXbLsb5E497gQ?=
 =?us-ascii?Q?ItMAG9+vEhANpmaQ722iOD9CVXikYkcGLRSW6zEfKwaYlGWy2AS21iJVQs6H?=
 =?us-ascii?Q?5R4pss+kgpwcqFGhyawB9sM4oOlOfZ9mQ+Q4r9PAfl7y9C5a21zvpNVmMBi0?=
 =?us-ascii?Q?rvkGjIOiJJvT2pb5ZblNu+a4tn/vaVhcVxe95rjdp9KGpTPLz9+FCtSpZoZY?=
 =?us-ascii?Q?+hJ1CwgYL6GVQitmSbNsrxocp/6uGE00UVq4D3RRwauwWMz4eEPxZYFhTL2W?=
 =?us-ascii?Q?qiUGbQb4GUWAsRGm/fyYGcRLKsafBgU1UERL+vK9KxE9FMz3N9R+RRhXJL2N?=
 =?us-ascii?Q?S5XVJk2YR82KL3cqmjqaVo8tO5HLzNg1yGlb0WqR75nfbkT9zDBEVG4dV/VD?=
 =?us-ascii?Q?rM5ewJa7S6eCjm1FanWLDzedDEVvTxPuij8qXRmzKDXXiY5r9IPmdI25UKp9?=
 =?us-ascii?Q?WCHhoToKbAzEWV5klhmIO4TXdOis8SUyd4/SxGMoCLsTkMpJEmV8PbmIY/w5?=
 =?us-ascii?Q?echqOZWNOJHu+Tk59uoY6svxsP6qEZoPnCjdJopDEbx51NNn2PyeSpf26r81?=
 =?us-ascii?Q?tJrs8ap+ISLqhTgeEi/U9tO6MQRsCU7kWnzNIJxYvR5JnhTMWOT/Gd0OsEfd?=
 =?us-ascii?Q?Q8FlTZ40DDC0R094U5Ztq10jFv0IoIm+NJWWX2WbTW1q+G3wCm+wL9d1sWFI?=
 =?us-ascii?Q?WmLbMlQl5y/pLt7LmALvH6Xcm2WEQjPu977mJ0dNVuOzqO4sXgXzxPAteljZ?=
 =?us-ascii?Q?H5Bk9kMTmnCFHNMJXZOKozKO/nSWKdSg4+iXrWY3e6bSdp3Npts1YWfj5Pkn?=
 =?us-ascii?Q?IQWcU+zaapgG9f98Hk9i58ftWPVMC+CwbxMJmoaHln9pt4pI9KNJMZmjTSub?=
 =?us-ascii?Q?wVrf9zLSNrZR0uTCOxaWHrO6RTOzDbx9nMdjR8tRwgmyCRUQZsAxsq9ygfeh?=
 =?us-ascii?Q?e5zWWU6pMyhA2jH1gkU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:50:05.8238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecf64f4-24b0-4bda-7695-08de4e716492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838
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

SMU message related ppt callbacks are not used. Drop from ppt_funcs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 18 ------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9e0c8ed67e73..e88fdd65e1cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1187,24 +1187,6 @@ struct pptable_funcs {
 	 */
 	int (*system_features_control)(struct smu_context *smu, bool en);
 
-	/**
-	 * @send_smc_msg_with_param: Send a message with a parameter to the SMU.
-	 * &msg: Type of message.
-	 * &param: Message parameter.
-	 * &read_arg: SMU response (optional).
-	 */
-	int (*send_smc_msg_with_param)(struct smu_context *smu,
-				       enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
-
-	/**
-	 * @send_smc_msg: Send a message to the SMU.
-	 * &msg: Type of message.
-	 * &read_arg: SMU response (optional).
-	 */
-	int (*send_smc_msg)(struct smu_context *smu,
-			    enum smu_message_type msg,
-			    uint32_t *read_arg);
-
 	/**
 	 * @init_display_count: Notify the SMU of the number of display
 	 *                      components in current display configuration.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 34f6b4b1c3ba..0f7778410a3a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -54,8 +54,6 @@
 #define smu_system_features_control(smu, en)				smu_ppt_funcs(system_features_control, 0, smu, en)
 #define smu_init_max_sustainable_clocks(smu)				smu_ppt_funcs(init_max_sustainable_clocks, 0, smu)
 #define smu_set_default_od_settings(smu)				smu_ppt_funcs(set_default_od_settings, 0, smu)
-#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
-#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, -EOPNOTSUPP, smu, mask)
-- 
2.49.0

