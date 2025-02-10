Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD3BC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 23:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBAF10E21A;
	Mon, 10 Feb 2025 23:31:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cST9TFk9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4236910E21A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 23:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLJvwh+StxGTr6iYshAWBJ99VRMiQvEXe/zhRhHpI7PLIdu+P/c5WOvIBZ0kiSkewhHd/Unc2J/dv01HbG6pfesZfVKJpBzq6c6lZSEGLApuKG6lYdwix3ENs31uCB6dECGKJjM7n8CuQe2uBNcQ6bbMmFhHT7bzwzBOKy1tKBijkRHinBuUBXkDabLkVDXeOLXv8BkhwI89AvMu+RLKNL9qEUkRwo2ZfzkjBe7ZB4sNn+5dJOP4NTwYh4rq5+rORA4zpaCb481BfRQ7PDn4zodIsz4ts75PlXByXh9W49cXKGlqCPkGd29hRYPSsG/1qCHSqkXeGtDp8LNavbFuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4rnak744fYF8jANVEYmWFP7ukPwqv2IAV6L+kQw4Pw=;
 b=Pa8U+VQkn25rvCgpBuv9mD59qheJxlZCRnYkQanOvRK7dlaHAbh6kMQfRz07nourheOmlj0aOnjhslkkgkpo7Z7lZu6iF+IJF3f8AH35aqEtxO+ei1sAgEzu0aeDt9O4YT5qre0reL6/bEmVWIoMXW2PZSdyVN0qdYeoIUi9AP1lnnrD+4sXEFcCj24vseLBXBCBwilecJPFpWa6XFSMAKQ0b3Z1uxv85QJ4iCJh7mw3sEPosj+Z8LQ8LPBCo+kdFAALIU3ft/41wOmyl0wZ7dgkVWzxpWkIbQJFP7SxiHf06nzDyAlaT+5oZDiLlYPmzv8Vrlf1h/aab1JjEcOfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4rnak744fYF8jANVEYmWFP7ukPwqv2IAV6L+kQw4Pw=;
 b=cST9TFk9DFS9qyas12G4JQ0VIeWjO+X5uC/A/uhbFG4FQdfGrrAZ/TPrpzsQ6+KCvr6ROXhdDQB7e5IQcsFtcTnxdAu/c4hbBWFjVM/J+DXf4C2lWekX0Q/J4XWbTJ0noWyHC++rGl/cdje3Y+sknzeYADKkESEhgjYuCdGgHp4=
Received: from BYAPR07CA0040.namprd07.prod.outlook.com (2603:10b6:a03:60::17)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 23:31:50 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::b8) by BYAPR07CA0040.outlook.office365.com
 (2603:10b6:a03:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 23:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 23:31:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 17:31:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/pm: fix UVD handing in
 amdgpu_dpm_set_powergating_by_smu()
Date: Mon, 10 Feb 2025 18:31:31 -0500
Message-ID: <20250210233132.583035-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210233132.583035-1-alexander.deucher@amd.com>
References: <20250210233132.583035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bc987f-56e4-46df-ec9b-08dd4a2b1849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+UOWbre7I3WC5FnvusGvV8FutG4BtNkQvJ3qP4Ucxkk3Sr2OfIOJ+lHE603G?=
 =?us-ascii?Q?RdLHqX8VG6DBz0T9jcdm++/eNO/fMmPgW5BHtvp8gjwvKkLLkJEULCEVw2Bs?=
 =?us-ascii?Q?wA/gEMnTqtNCeSDkx5l73KFwbIKO7v8qTY8Sewk3EYgHgkfKBJVIGhEJHgHP?=
 =?us-ascii?Q?5eZYFmntWtwyCt4WanH8zm75ae9u5wK8fBimNHHBY8B9irRLN+WqfJxygcHe?=
 =?us-ascii?Q?8CBR/YtO/0el3Vg3R7I8lngBE9ganNr7+A1jXEkdy9XfLA1kydKAFRiggS1e?=
 =?us-ascii?Q?837XxId0A1D8+Wlf9p/YWgS52cfRPEUDnqcayQ7rOFhSV9b4DLzMFdGegTF2?=
 =?us-ascii?Q?VfUOKM6wXYoibuk4s2eubCksvHs6MClXvp+QUIqqbeNRNeTDHiw55kks1vTx?=
 =?us-ascii?Q?Fq/dgoRxbMxfaNrjiS1R+THRcLb9lJhnXVcttEbUagu/aqyoCU4haIjZU854?=
 =?us-ascii?Q?Tx/Sx2aH5GUjQCz0fY/kzxOhkGxXWs6lsIuO9H8gAMOgndsnFNYlQmI0IkSq?=
 =?us-ascii?Q?Fmed/U1KwayPLLpZppdRDoE/jQJJSJffwDOYlv3Y4XETYDGSH6/WSONPgeW+?=
 =?us-ascii?Q?nLsId0OPHBJ6B/552YK8oT4Lq88XedONCs2cJ0dGNcknVyXP4PO/OsaW4GwS?=
 =?us-ascii?Q?5IKY6LAWuyXAYZOtqcAdCtcQYe373cfDH8AGuftDxn4d223EBv7wJXeqq8A5?=
 =?us-ascii?Q?Gw3QkVoCDLpdZ2f0z6TzvlNYv7gQe3C/7LKv+JUGuCcjqKowaTeQsfLWseZn?=
 =?us-ascii?Q?ARoERuoVRXpKkvKMWR6DeBoMvy1P9JdCj/ZGWjfL1wPgvHhi6LNRtA/drXLh?=
 =?us-ascii?Q?USM/Q3fNiTLxDC2/5hAhm/kjqwbo1ORVVCixJrfhisIWH5+TY1gi6niOe+g8?=
 =?us-ascii?Q?ujdNpY657shQUlyv4pjqenozfZahHN+c4K9ALMg1nFhjA45bNr+taLGCD/SA?=
 =?us-ascii?Q?dNe2HL9jLZb9klC6sye8HOUt9QwuAc5AUsUCRdxk4zcZInlASx+JDPJVtUzM?=
 =?us-ascii?Q?AIbq+U7d1QwH3Y7EHOwS2PV+Yv9H1Uc++n+rFKIq07EkRDrCVCotGL4L5hGQ?=
 =?us-ascii?Q?uDQzipYN2c50cJoNFrofLdLSBGB9qALLntNW1PW/nugZCGfipTFNMENCzfg+?=
 =?us-ascii?Q?eKrPMugG3aUedTqxbtq94JjSjWkxp5teJCamWxpihzq1BanDgScHaQ9UC94w?=
 =?us-ascii?Q?IapJJ8BU013rJWom7KvsM5a7Sq9+VVk/wJsCe6pqxgEfz2sru102NixgPFuX?=
 =?us-ascii?Q?LJW70+g6O4CtdMBmo8qEiLGjzFi1fyZvCIJc1LYc7yN+DR4UGVWUSQBkA36/?=
 =?us-ascii?Q?zmHpw2coEMD9TeWcL8i4IJSSZk8xjyto1biyIbXm69ecMahZ9SoX7lTuM5SR?=
 =?us-ascii?Q?8XPA3GcH2PUMNF/JfznV7tgwg6GuvlPZagVeuAPD4DYUZWHfKbyxRRubYI4q?=
 =?us-ascii?Q?Pz212G5Pjgo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 23:31:50.6463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bc987f-56e4-46df-ec9b-08dd4a2b1849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
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

UVD and VCN were split into separate dpm helpers in commit
ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
but the check at the top was still included UVD from an earlier
version of the patch.  Fix the check.

Fixes: ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3959
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-February/119827.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6a9e26905edfc..7a22aef6e59c3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -78,7 +78,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
-	bool is_vcn = (block_type == AMD_IP_BLOCK_TYPE_UVD || block_type == AMD_IP_BLOCK_TYPE_VCN);
+	bool is_vcn = block_type == AMD_IP_BLOCK_TYPE_VCN;
 
 	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
 			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
-- 
2.48.1

