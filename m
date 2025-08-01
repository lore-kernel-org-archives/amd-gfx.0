Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667F5C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF19B10E3B7;
	Fri,  1 Aug 2025 06:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M8IVOlh2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDAA10E3B7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI+wuI35iTYoLYrHDcQzrVTMrv+B5HIxS4yLm69LaUHDPTEE70rehR3FBciG62pE1WJx9A1iG1818+qqr+VdxlsRh9C6tjaxCzVfDArKZeEQrlyOcCS8tDVGXCmNPuXJAcwzVcYLYfemcIW/khgLUsRud+umHtk729FDKhdcPYThAa9dLuJ5AYOUoCYcUQW/RKKqUa+DPwJ5u5SkZ6hWfdM+zmf3Jmj9gNg6cNyVAUWZyJOXy60iLwrilBzGFRBv0YsL6JaL0MWxiMWbzSncWjP2b/bMSI7HaVdTj3AyKbbzatsFWjDENRy9GkctPs8+av39aiaseqbfTgZicAYfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=DIOaLteJ1cXFZTSKzHtgXcBVY0iNQ9rTDhIFY0T+yLCFdq7rXczlqmGIpCBpurLNDKbf5qzAjwscxaQk+MSK++YmqIcdkTK/eqq8W6CpEh6Zwgu2Kjl2q7ZNfMre0815yywXrjdQUvyYkBiOt6EXd5z5XFKFQ/pswX9pzA86W4I9l6zsH2DMoxDEgqg/SMwxtN3aBVgZDDknm5t5N2AuPeOdYG7v51jlYmX/KuLKK183V+mHweiBdQN30bKpReL6w52lhVO5YivCe9r8HaIcOXs4ZO3o18Mng1msMH7cVSoYs47hgtUeNRCGK2yw2U4jliPth0QUUU0GKvVXMt30kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=M8IVOlh207nm9bC733xh+P67q4DPcSqghffD5CxsEvcY5kxS7yfZ19wYl57l1BUxORBD9zC6bSXVlatEbwmgtxFSTaNTZHnlcOiUfaEDHYQbJ9RN2ZKJgru4L9FZwf0PgE5yRLrGkPJ75VAqt8+uffZgyKLBpwq7NnLNGtpKUv8=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 06:26:39 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::e4) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 06:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:38 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:31 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 09/12] drm/amdgpu: add user queue reset source
Date: Fri, 1 Aug 2025 14:21:07 +0800
Message-ID: <20250801062547.4085580-9-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b630a6-0539-415c-695f-08ddd0c45f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qNkJ+LHVILINE0CJr8z8n/QfHu1oLgfdUi8GsMfxjBZiFvl3CR0jQlGApvtG?=
 =?us-ascii?Q?tAf9hLkmLeJXaupJbjqh+QQ233S0FsbruiBObQqpUP0RZ+3y/tegiI0VCpf5?=
 =?us-ascii?Q?+34LNmIhoTq3lLrGpN/nXwycZM45WkuL2teKfcTAO4vE9tKxKTTI8zm9gKHK?=
 =?us-ascii?Q?yZJpD092RQI8FhVp+3ps5y2Ohz4cLzuqUfnDBqekfbLzBl0mKt/xSjBl1rVd?=
 =?us-ascii?Q?OrKsaQxWCuJQytX1egt/IfTiIn+j6M2dAIfuuTmnoX/goPS+Y+wgKUWpu6sk?=
 =?us-ascii?Q?8gZML5z+fUGk4Hi9wBcBUYqazIanZd9F5igjxDTFGg2P2xeA1ad4spJ54k5A?=
 =?us-ascii?Q?q3tcFJHDmFcarENpNo99O2MQui4fFf4GgotAFVS6MUreGp+Rp7Rc8bHq02IL?=
 =?us-ascii?Q?/CIgt7lcRoWnjkbv+BJGvlQry9tV7mlch3BV0fljyn6ZAK/vLsav9NIKf+JJ?=
 =?us-ascii?Q?+a5EZv0Sw8/ExF0U+D1GyTNuYMfY7/k0VewBdGwRgAM3Grsa9wKYo+ArRDiM?=
 =?us-ascii?Q?9e7ecsMgY8o9izb5sz+IZYal0ZW/pQ/TGGQpqayXEGrY7slUQmu8j3OLqHtV?=
 =?us-ascii?Q?kS3J9lWM47w+Q70C4PlMGpntObAFp6yAsjFx8tQYDqsKVeP4rz6upcihhIAI?=
 =?us-ascii?Q?lP3mT+qxLt50HTgb/rKgkulfyVTbUu0Uot3PGW6AoAJ0cUu8mhX+XWRlNXh5?=
 =?us-ascii?Q?vamvBINHV9XkzJhiOmrRDZ20dz9z5Get/do0IwSUEZxn5rYU4tjXM9/nQBIp?=
 =?us-ascii?Q?xK7AOCArFc9C3fhlxedKI5HUqrGEh9WXcLpmVa7xAMHq3pbXx4kBjwJkd1ET?=
 =?us-ascii?Q?2FF9HkUJLfYISqB/f8ncT1u6MN8jBBdcn9jMJ1jn914pfW0nBO0zW13HqLPX?=
 =?us-ascii?Q?/IBQObGLghacJx9lcAXr7lBdl8esuirfyf0flghBajUKbfw/4jd+pHdtF9sI?=
 =?us-ascii?Q?YTlIdWi5f5tstg9Owr+pMkKcAJssKXfkfhGEhYEcXVKDz5tW8vbrQQxShmoO?=
 =?us-ascii?Q?9NhNseHi7rEja0N8vgzXMJin11WkK2ydjqDmA+neHJXNpQMA/LV+BaEActG/?=
 =?us-ascii?Q?USqWCzc2aEEq2zy+0Lw4OWWtHgNnSo8sBWh37r5F4wKMFQMiq43B2atXIK3B?=
 =?us-ascii?Q?jdefw2Mm0F4JSnIRcSv3CDL7FBvbBkWe3eNuH9CXtY5y5t0p6aJgc/YiUVcR?=
 =?us-ascii?Q?I3EwvqUkLicc3hJ0tu3zYt6kb8ECBBY4brwFk76V0C6KCP05TpfcslFV3NVz?=
 =?us-ascii?Q?7tU0YpXqNTanya4AvuUL/ptTHTlpxGKlW1RBFS39yLeY57l0H+cbdvgz/H8H?=
 =?us-ascii?Q?ys/SHBeyRVEyJo1m2JCdCuIMbcxbsbM/w0nR0BIactL/erfoVVH6HPT2KUdj?=
 =?us-ascii?Q?RIJWXSiJC9X46wTYWLFOKn2Tsc2oqZMEH0DYbUwLmGtF1g8VBPmaYY1XHVRe?=
 =?us-ascii?Q?QQ8sivcTwMeVmHVM91vdgBMXqyfj1Fk3HEB8V7y3f7gXED4Wi7Js95sUR1yK?=
 =?us-ascii?Q?aW2KAH3gbho0SfOpYi2x7rxECMnMloP+M5hz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:38.9030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b630a6-0539-415c-695f-08ddd0c45f78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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

From: Alex Deucher <alexander.deucher@amd.com>

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

