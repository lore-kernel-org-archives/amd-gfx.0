Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ECEC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47560112C9E;
	Mon, 29 Apr 2024 14:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q5BhD+pF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9281A112C79
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQgKXYnjduFVNK420aG25p01cBU8aZOIkqDV3DA3/h0fAQ3Hn7ZUDZhJ8pX2mHHIPhEL/j5BNGOWTOyCZJK+O5GbCfrsrX6BQjWKQZtvosQTrVtYq/or0l981NUY377GTkkcjKHz2p4beKacbi7TxH0GWsX/oykQib029QrBeQOw/O5MBCIB/LqIv2kfdNc6GV6EME4KrpUt5No9jXRFH5ILWeCG5SPKd9I2YQtgZp8trNEbpGnDrwipDXk4qOQkh0LfEGBnbi4Fua1LLDgshVVMN8ItpC9Rq6f4WuNGpbmAWov+c2y0wgscGVP7xw+wOoXTwRkIEmIYMnHUImMMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGC9ujNugiZp6ddJ0UFlNd5iiYfLiVfoVpnE6kwHvF0=;
 b=l/I+9eDLMVxpPa3xFWvct7t57MNM646cbN08kWZRMtpMso/REKznnpomMJN2rCE9WQqgdr7bv2dXQvcC01yXYSiR2GKdOCOxmQAyuNAF9Mo4YViPcBtkzOEwdFHbAqN1vXhgPtPvffOvtQLNoxihUSafw7zqlMX4dlwGiCbV5E4Fd1cYfEnsfeYt8hiVrGUjPIYf3yCpkXmIYup4FlyHQOosLoy5FQdUBBIPqOrABGCeQGgM8pE/mZmxSFN4ISX17Icwi30uln0SuTmWABq5ZTHLExXN04PAk/xdSS9lZhn4XfBx8b+0LHgwGP0oKEymguPl1JpLiJhw7TanHVt+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGC9ujNugiZp6ddJ0UFlNd5iiYfLiVfoVpnE6kwHvF0=;
 b=q5BhD+pFsMtcmc3ia3gmF0nv9DHG4Da4OmprDylW0+CTe14SzAiRplHqJ6uhacqZ/sWnb8j6Xtq/h8IrkZxlQkOze+NYw8b4EjHgrOc8QfzSB1byogYc6+xkLrTgRxyZgck4+zR4Rdi+KDD3SimHLu62gyzBjc2NpXRQTkKNpCY=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:02 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::fc) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 02/31] drm/amdgpu/discovery: Set GC family for GC 12.0 IP
Date: Mon, 29 Apr 2024 10:33:10 -0400
Message-ID: <20240429143339.3450256-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dff200-b42a-4295-2acc-08dc685969d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GiNn97/Yok7aeQiwZ2dSPOG54FZhYeU0y04mVxtYuh80pkHP9ZFKjHHU+8AN?=
 =?us-ascii?Q?SgIESf1iRayz3br1BGjhdIdpH0LiqPZP4rmbUpxIRH1eLupirex1AEwZ1bwT?=
 =?us-ascii?Q?srtG8ffPSlqDpFa4yNz/aFCa7/PKaxREn6S6/+b5IyDmr0UgA5Vs4aquGJFG?=
 =?us-ascii?Q?8NET0Iu/jn0m3tP6Qimkq1FJ8Ke3WJzogJ75gAJPpdJg66vqcPxdAEEIEbfn?=
 =?us-ascii?Q?MXGdbnoD452Y3+W67JsGH2MugyF1qyUvAatlb8Fqgsxjl2E9bJ8J0DhhIKoF?=
 =?us-ascii?Q?+4Ws9aWbzuiFm+6anelVp8HLAnfVGqVyB70o1YwJesIxV1r8N4M7iWBTVNKB?=
 =?us-ascii?Q?bJ/kBBaewlCyM27stivut+CBbRfujUoZ7Ory+ZL/6z365+Xg/nAV0bZw6Occ?=
 =?us-ascii?Q?+V8iHt65ZCStapEKF9M10fl5o7VyV6dQHAJW/NO1m55w37kt2saLrRCNY0lf?=
 =?us-ascii?Q?0TW7ohr9DsKaWcvgL5DvKuahrO5nw5yuXuOHYJ8LTyS4qXyw1iSLuS2tVE7w?=
 =?us-ascii?Q?Zj9quM4TvV0qsEL9wc/FOMXO4ax+LcqYvpfGDgs2qNO1H/dplRBbd8ANctls?=
 =?us-ascii?Q?mrUBLJDdIfaEuznhArWeMNYVGv6Fr83yi3BVHjKJN/UWGd0e1Tta0ZP6d7Wf?=
 =?us-ascii?Q?oZgheUYBLSnLplAFUxT3kElJbSmzypcVgwujk5gOuaTRxIVzbpiOoo++gSc7?=
 =?us-ascii?Q?VjLPZuwk0iZCZIYB+Qpv5+94k3h//pqKQKhPf2npO+aALlyykOGCz0iLz68V?=
 =?us-ascii?Q?MzaXo0EmM+0C+ijp/tRP9YPFn7BzUFMnPMvoIhgKKHQUm61EewOnPPFOZ4DQ?=
 =?us-ascii?Q?iFb/phipGEkmlX1kUmFEW3BeS66C9jQJlkZTRb41LQoANrMApb/aB33LjyMd?=
 =?us-ascii?Q?Km9sdFs0EK7t7r5SgOg+afWHOcyNK+YQ4AjhPeqtMJ53sgSmWt3VT43tYpGN?=
 =?us-ascii?Q?immYcAaO7DDAq3rEXxJ4HqOQyYXScffB+o4k4Jz1W8Oc2OfyabfNRRdguyCe?=
 =?us-ascii?Q?rSwrCuxza8lVN3lyh/mR/KjeunO4o+ub1Ar3HhCiNTnuHPlhZZNNLGPhTVkX?=
 =?us-ascii?Q?ekgz8ANaoqt4dKvgxaSACYGbN7jHHWBgHGRUxdb0CWDxmvoSYNewLP2Yhw4+?=
 =?us-ascii?Q?yYsT0zm2/wpuAToX0JVFWnQcBtpB/B/wreUInaW62NatD0ib2WkjiGTxPxkE?=
 =?us-ascii?Q?RDXIhq4hDx1Ge+iVKz6WMs0H3YS4Vjg5iUfbgXZPV5go5emKyaa9Hl1/skAI?=
 =?us-ascii?Q?YF1IfHJonh9w9Wgg1ochLTZAJm2mWY9718uFUdLaST6iZZOpKOjrDaXZA8C8?=
 =?us-ascii?Q?pEv6BBJ9BeHzTKf8uRhoeD+hY7VWV+OD4JWklqg9i3FBleCsNbK/Iw/0gHLO?=
 =?us-ascii?Q?LheLnzI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:01.5277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dff200-b42a-4295-2acc-08dc685969d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

From: Likun Gao <Likun.Gao@amd.com>

Set GC family for GC 12.0 IPs.

v2: squash in updates (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2aad1ba0ab9d2..7187968226a81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2503,6 +2503,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		adev->family = AMDGPU_FAMILY_GC_12_0_0;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.44.0

