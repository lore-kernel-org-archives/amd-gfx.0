Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8ACC369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9012C10E98D;
	Fri, 25 Apr 2025 18:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JHCnwOaL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E351810E979
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqVca+pftZlHDbFnkFmm5H/IOVfZLRJY01o8mb9AfJxh6qdBtRCsGSP+EJQUvDAIUA96odc/AOPJTnecldYGau9owyjxXkHgQUlig/650o45aKtCEaCh9Zoekdnct/ioXidTrkQbujBmp+IekFfLHpOcgoQfGVrHPkxH55KDF2M+X8jZmJxBktLFYYa1T7VfbtmgVntbzTlyiaRIEjdSYDspmxfJMJTK+1Am44NGbyfDn81W9WNc9d0araCe/IU+Hg5MF4dDRzK30bEmB3s3N/f2U2jLjWNxpzi0OQKdDYjcDldOJZUIPXPZ/k6Ka+nqwtPg/QS+LGGRPmvtJO7kkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABS/rOtnUyxuFZ9+uvyCixzaWnEbD2rjf2fqGDWd6p4=;
 b=GrX5Cx2+wiIko9q8s/6/9gURNDeEJZVG7aLEpKVgZGfjC9hJa0tu7ybx1ll3YPsZMxCKGwFBhGECyuIJZTJqw6FEx9PQkR86oLwF9xDnr+wMwqmi5UC8VCZTDV2u2hNW9xngKmb7WKZfmn5VubhffOX+ugPUM88qlHIBoZd3AQ9QB8vEL1QILOjuR8SLx8ejJTuwMsRZjjTHQT1rZbvP6VarQROz+Y3ZYJgcDROYN9s5DR1ltv4Aq+RqXlNNFz0OZsU1T+6NgzoesnyjRvBIfAWYI9yhlBdaLVe+Og5hse2D1GUk+SrPqJWQhL62ismsZMBGqcehnaxCkZsLDkNw8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABS/rOtnUyxuFZ9+uvyCixzaWnEbD2rjf2fqGDWd6p4=;
 b=JHCnwOaLeI/zn8e1Xmw34FwHHWA6tDECJAqjt8hqTlpM1tyeT5+qnHTFmT8XwIuDhDLFk67lSaRBKUX7uakzRxMiFCWrdE2NfrgiXpUF9dVHi2u9tQPJLdVL4goyjOMu8sjjiJ7DtX4Phit3otHcN8y+ToTlI0di56aiyiiRReI=
Received: from DM6PR11CA0054.namprd11.prod.outlook.com (2603:10b6:5:14c::31)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:41:42 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::f1) by DM6PR11CA0054.outlook.office365.com
 (2603:10b6:5:14c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 18:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:41:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:41:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/mes11: add API for gang submit
Date: Fri, 25 Apr 2025 14:41:19 -0400
Message-ID: <20250425184125.166270-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425184125.166270-1-alexander.deucher@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a584898-8a30-44fa-2d61-08dd8428d285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?00aHZ/4N0BqQEk5wv+3q7B5WhVHjdQ/yVlF/0rSFPPlR1mjSqvSfNEJV3zr1?=
 =?us-ascii?Q?FKjsiHyUpCt1vZh8XYcPhI/iOz/YHKX0VzHR3SJY+79hWis2FZQZedZJUuOK?=
 =?us-ascii?Q?Zk8NLIYZ3P+5XgjEhygHi0ORVX3pFneIjZl5CeFXjWpQ8lESvzfMkortxVjn?=
 =?us-ascii?Q?uOBWYoqgphY7Z74DHW40EwaEmac68rEz9A3llYeXpt6WV+uYDRFsjiujyvAe?=
 =?us-ascii?Q?fyvDyWvwuWzFL9OYlKnxWeQ4fSr/g5aKtMAD5+6//Hhl51Wf92t23Lyk/mJk?=
 =?us-ascii?Q?keuh5uq1bji/TrSbT/WWr3gNTjZ2wOnuLtKxg5Wget93moYe/23IIEp58DF2?=
 =?us-ascii?Q?PV0UffTwW1NfRSTxlNXgFVCytS4YwKZ/JESZKZPzyXF1V76c2kot2OtI0GnD?=
 =?us-ascii?Q?cQ3HUG7eO+A7QxSfimpmTnU5Yvr0s0TK3kLct3AVhDWfzIg/c/ipZx2qsb//?=
 =?us-ascii?Q?jvvQToW+e/4LlSqMzMJcPydXNfJJZmqolwaeqnXuxFGl0S+CJu7mJ05tId/1?=
 =?us-ascii?Q?+43w/c8QWuEll95QnC1jqZod/QR0xCJXCvyTxdluudKD6hkzO79pWSEgFleB?=
 =?us-ascii?Q?izDHxhfS9Oz9IUiwuAHOK45GcAKAye7IB/369oMw/kGje+LPPxEaF4Yvy8Z3?=
 =?us-ascii?Q?mfmtQ8YNmlRnCjAHKcZVStg9D99LCb93vne+sz63+Pv1mlT9KwMFW7FDhcxq?=
 =?us-ascii?Q?hHb9Hi/dJYZvHwqvC69ZPdS7dOWdzffXwOWHUc5h19TlapLh3Vo1ovU2vY5N?=
 =?us-ascii?Q?h+d65jZPStkjca9xhJu8e1wGvE0CphtNObc0ZfHj3zJJTTYRXhJr807ciwbn?=
 =?us-ascii?Q?ks+EGVy32TadfA2+PT9ZgkN61Uckwo1ledF3SWjYSIr+Pql6CCT4Rdx9zzT6?=
 =?us-ascii?Q?NemDb2lbM2D9z7pQ01GwCRqvvcURfOGzLRpvrpvKJCZESUdTwM7xQ5uXdDUT?=
 =?us-ascii?Q?9a/p9t1UQCNMPzqQE/YEKYzLe20MP/KvrqlRZTWWwqIvrRXXTEBNGp+BhMVa?=
 =?us-ascii?Q?V0l1548xahHpxCicoBGT3I1KaFZT5tw2I3bLkMD5YMfrTPvLsC+zO7+MYnjA?=
 =?us-ascii?Q?fzr+J42CmztCF+l0G8jtK4gEsoFaYlQ/DFXRHchm7QIvEuwYL3a8MUSdQ+L4?=
 =?us-ascii?Q?w67ewzJ0eBeguQAVYLCk5z8ys5YKW1jC5RUIrVtvzCgd2P7YCjFjLn5m5Yag?=
 =?us-ascii?Q?wHelPO3b5+XCiD4ELmTREQ3wKONix9VyC86JTk4gSlOha9uXnaUxBwcfJ7GE?=
 =?us-ascii?Q?+cw5lyxKgeLjUKuvz+YTuGVoN/ojMgyhfdIvKocKqP03JDV+Op7g+hzAdkC0?=
 =?us-ascii?Q?crY30yUdG7R4pP04Rilc27aO2aUeel0s3dml4g7RriLz2LhNmaqR4Gmhkdik?=
 =?us-ascii?Q?ZrT1as9m933KZZSvqnyDZ8IAvb0FsIC9tpb7ePWnAcQkFfEg4MaWpUOzuMFV?=
 =?us-ascii?Q?MTgH5J+rFVmJ0iQzRThYvLUOUKENtUUC/MgCfBONcq6ILcJ+PnXxcOyZT0Pe?=
 =?us-ascii?Q?GmIxXdUOASvdw+tlFz9QR8iZh4o8ImV5sbVK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:41:42.1198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a584898-8a30-44fa-2d61-08dd8428d285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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

Add API for setting up a gang.  Gangs schedule together.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c9eba537de094..8a31bd81bcb9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -125,7 +125,7 @@ static const char *mes_v11_0_opcodes[] = {
 	"UPDATE_ROOT_PAGE_TABLE",
 	"AMD_LOG",
 	"unused",
-	"unused",
+	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
 };
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 15680c3f49704..d1933bc3669d7 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -64,6 +64,7 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_MISC			= 14,
 	MES_SCH_API_UPDATE_ROOT_PAGE_TABLE      = 15,
 	MES_SCH_API_AMD_LOG                     = 16,
+	MES_SCH_API_SET_GANG_SUBMIT             = 18,
 	MES_SCH_API_SET_HW_RSRC_1               = 19,
 	MES_SCH_API_MAX				= 0xFF
 };
@@ -633,6 +634,13 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t trap_en;
 };
 
+struct SET_GANG_SUBMIT {
+	uint64_t gang_context_addr;
+	uint64_t slave_gang_context_addr;
+	uint32_t gang_context_array_index;
+	uint32_t slave_gang_context_array_index;
+};
+
 enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
 	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
 	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
@@ -703,5 +711,15 @@ union MESAPI_AMD_LOG {
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
+union MESAPI__SET_GANG_SUBMIT {
+	struct {
+		union MES_API_HEADER    header;
+		struct MES_API_STATUS   api_status;
+		struct SET_GANG_SUBMIT  set_gang_submit;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
 #pragma pack(pop)
 #endif
-- 
2.49.0

