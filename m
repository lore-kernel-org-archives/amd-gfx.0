Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E4CC369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90BD010E990;
	Fri, 25 Apr 2025 18:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tt8iPF5e";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B539910E979
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAA4rkCEYdP3soaPxbpbGbTzpe6eNmWzOT8UrzmE9aqCS2Dxpx8IoxaaDZVrCGzkaSFB8aPwc75PwCva4mhb2R5kK5VHCb0s6yqUoLm93U2/cYPrXiGptXvVnhaLWS0mOqj1PWX2CNt52h7fQpuSa+A5bMgs0qUU3u8SwkMlM/iW4JUBJyMY13k+KOYE1x//RZWW5sQiOHfYaEMl6tdnmuM775E4M2leJ2KSpvyxwJl0UTLbFXRtioh/VSpIdXaK62zCmjFD+uqqwvbGmF5wFh0fmquRHf8j5bwnBt2ok+/FTOAWyHsjGELtVYdM/HYJUqFG2nab4QOmwkkYA+z53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI5wzuZCl0hIzjtcYgW+BohGgrnXg9MTghnmxymGmD8=;
 b=MpcnvED5iiq60KjdL/auZM/esYnjS7zGiQMlNX8qz3+Oyo+Xh2jALhsznx5WTT5D7icFq0py9rVZ+WP4enKZ1zuObFYWSX+kMQXpGlnLxN9rmQAHKqea7XTYgYLyGU+nxoPZDl/yWswYE+qKtIV9GJxVdcAp+Pb+q00nWnMm93U6SiieRBL61kUH064ZN3ae3nY8mnYRBVnFiVdYRyxjbyR/e1LInpgrr97xuYiyaOk7exwBQFmcyovQZGU1bJK/mg/4gpdDjIEsUT0S2loOu/CtVNw2U8mTabPOKGBTBIavvsB1cH03b1au6GhG9Fa2MxEVx3e2EqSknaGYdhX48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI5wzuZCl0hIzjtcYgW+BohGgrnXg9MTghnmxymGmD8=;
 b=tt8iPF5e0X5MFzusd70NwgfG91bzBTrBsmRgSGrncEBlnKHR87hORGn5CBrNx9q+d4AoQ2m/J6GMDZPrxU3ZHc8UIyDL05JACm1MCKs0Op5mI+xPiQCkCEJwVCYeQmha29skdehoibFjzcPMReGYkKJ9S7KyHwqKBPoJsB2X9cU=
Received: from DM6PR11CA0042.namprd11.prod.outlook.com (2603:10b6:5:14c::19)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:41:41 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::7) by DM6PR11CA0042.outlook.office365.com
 (2603:10b6:5:14c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 18:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:41:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:41:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: add UAPI to create user queue gangs
Date: Fri, 25 Apr 2025 14:41:18 -0400
Message-ID: <20250425184125.166270-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: bdad488e-e7e5-4dfd-8401-08dd8428d1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VuZOTdgPxac3P9QWG/9YF6lKMGRu3jFbr3m87ql0G0ZiEO9hkvWZpCjDb/Un?=
 =?us-ascii?Q?IriDL2+IympnzPjkwgBIbWXlERqrnRArY6WB9Yx4dJYSCeniAfi7hdSGtkuT?=
 =?us-ascii?Q?VH8gQG3THqdNjxfM/9h+g2MbWuppIqewdrFsblfmvZrsoV+FcfFc+gF0xXLM?=
 =?us-ascii?Q?SLx7KnetJHimKPSt0JtcDoLzBICOYtqbsKCPxzQwt+PUVvvtaJtFL0TAmRlQ?=
 =?us-ascii?Q?zSIoj3U34PKv8rul0U3TjacL/L5ME3AwL2x++6eG+GN+3f3qasduVtTtDxbM?=
 =?us-ascii?Q?baumyLuoF3VNrbQ9WlhL/25hnvvfzmW3azj8M5qQtv9NbKw6AhlzqOhw7icm?=
 =?us-ascii?Q?Pv9S4lfrAUGu0ZWX+NytP/iFhMsik8tNumlofDwpWbzNeufKRdFNr8cRZo4H?=
 =?us-ascii?Q?8+ZfKmjJWibbzPvtnByJgfD698gOow5k2jt0/Qs8zP6ZUovWkDgqVECCCM4n?=
 =?us-ascii?Q?CJ4DJary44fNkPeSjVlVnUAa4K0Q7W2AH2V7Rt44zRMPp+rDaxYjG7kLL8V2?=
 =?us-ascii?Q?5/6zwW7jN3V6iUtWeuIs33KLe9Y7wnrGig3he/ZIU+YsYEg47OmXPCCWkPeE?=
 =?us-ascii?Q?WoEgnu3TGorXqfaF/JrN80dm1wiAEVNs97C66NEiyOYff/brMiK8RF9LYezw?=
 =?us-ascii?Q?eYL+FGbpx/+ntc6TvlqBpsxtOM0DH1mkYry7hfvTLEquT4c0apCfC8MYVj3N?=
 =?us-ascii?Q?OUYHe9kQtc9maY1gO6sC95MV+ELpuJoSknMnOW215Ab8jMXTFA2JWXf1cAUK?=
 =?us-ascii?Q?+AEBNaT9CBAmPDjXHUFAfr2Lam46UpoGx45lu5AFzhEmx1NJ7PAH2TxYOM3O?=
 =?us-ascii?Q?aLy355i6ngBQ2I9rexbMUSdAIi2OlFMFSBZf1S8F7fKwg6k8gJI9xqwiLumA?=
 =?us-ascii?Q?KliYqXv8B4mOp2iUOlRh3XRM0mxErWwplKywuVjKz+lXnrIFA/d1MGm3v+jz?=
 =?us-ascii?Q?LAosnJmP3TuXA0r81NM8AaAMmzfaM9ysTl4hIrr6xcXiftQeWiX2iSk28p8D?=
 =?us-ascii?Q?Spzhef8IjSfpDIlGOvL1SvJtasOEoLKZJxaXdO4pJ600ry8kGLnEtUEXfQHW?=
 =?us-ascii?Q?fl8jOvO3MXOadgkNx3R9IDi2fWLXvCl3tUNMpx+mVEjjI3gkbngizCc954+z?=
 =?us-ascii?Q?Drc1ELGNJ+TgixB+f3bbVD1QzR+dxSas5GNk7mS4tLO36jBXd1S69+Cf/Mnb?=
 =?us-ascii?Q?BhqiVskShDd6Q69ZoYlkZdjGv4Vh/JbZSOnad3fjUP6T6oJjEt0dP61aoqt2?=
 =?us-ascii?Q?IFtRy3YsiYrNePHEmaFuNaB4aPYs2k2Ym8z6Aom7j7kOeAtU4cIiPdlwKaKb?=
 =?us-ascii?Q?rDC8+rp/MNGtYS6MgyQvxdgqf7tFkN6/kFUDfJY9EfGcLmJuRX7heB1FazYN?=
 =?us-ascii?Q?jt1DJ4GdS5PpnNikGUwqFIzYT9lfeGMZMMrybtOeVCnuBwmzblPOiGZj9GyX?=
 =?us-ascii?Q?8QzslqOccew3WBayyP+iFk7SYrpphljKhQTNbrYDsVwxLC5nbW/WzSMB94Dl?=
 =?us-ascii?Q?s0obqNVrhEatpq1S/fkmiycGRhL84MgZCGTn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:41:40.9948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdad488e-e7e5-4dfd-8401-08dd8428d1d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
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

Queues in a gang will schedule together.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 56f052a10ff38..83414563779fb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -329,6 +329,7 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
 #define AMDGPU_USERQ_OP_QUERY_STATUS	3
+#define AMDGPU_USERQ_OP_CREATE_GANG	4
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -417,6 +418,15 @@ struct drm_amdgpu_userq_in {
 	__u64 mqd_size;
 };
 
+struct drm_amdgpu_userq_in_create_gang {
+	/** AMDGPU_USERQ_OP_* */
+	__u32	op;
+	__u32	pad;
+	/** Queue ids passed for operation USERQ_OP_CREATE_GANG */
+	__u32	primary_queue_id;
+	__u32	secondary_queue_id;
+};
+
 /* The structure to carry output of userqueue ops */
 struct drm_amdgpu_userq_out {
 	/**
@@ -436,6 +446,7 @@ struct drm_amdgpu_userq_out_query_state {
 
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
+	struct drm_amdgpu_userq_in_create_gang in_cg;
 	struct drm_amdgpu_userq_out out;
 	struct drm_amdgpu_userq_out_query_state out_qs;
 };
-- 
2.49.0

