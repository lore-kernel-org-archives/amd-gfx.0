Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EE5CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDB010F778;
	Tue, 13 Oct 2026 11:18:57 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD6E10F77A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEixn6g8UcpUplr8Gv1y5UIT/F5k7HiCvONl/15/ofvWo34zFzOCiXxodsIKm7RvmACGGBw9b4pvdY/lF79MHmZDI4o4zbJK/jfYDKbeM53foVwEj8f5IGWIqP/OtiVJJnrssvbxcqyapzxNABS4J3QkmqtPSrzw/fPBV5pP3/JNbG9o960OP031oZ7k19iojMk+LZxMpIPKvLFJsjGq1NbWYrIN6HXLYDN0wuCtQP6ADDJ6nCq+qGBr7VWQdB1bQYn1HV/vLiMsBZ8hwBGvtoe17EK3xav9fFo+5szseaPi3+YiMugawGEqdl//jvzCncfvatG/wEF7aCMpaypXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crjgBglNs1vVzilNs3KTBk6WgC2Qq2bU7F4wbapZkms=;
 b=EYP80f7W7CirSYnzPWZeUUJR2of0/W7HxPBbew2iVv/iA82dB/ys0YB0ILm/IFuL7kzm6oK/ZG7UO9o8zuN2++gr2mJhlyj5jFj6jVD6DLcOFDK/+0V5j8ATe7YGXPgfobLX0AMIdjl2MZrqP3eVtA8aTKwgOf1eIh0794fPx7dx2pzyR5UVMBWLb1JbY8IaJ7gNYxsrDfPIRT1jxB3qFEzzFL+Gy1UiHUrVVvaCt/tFhn2lqfmQYE5VJqeIQ+amrt3etGRykg9xWo2KWDTIdsqbVi+kS3oLZkgzQvGgmWAa8uZmlhPWFhxVWVYbgGmjlYhTlEzOrr64bidUtmM5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crjgBglNs1vVzilNs3KTBk6WgC2Qq2bU7F4wbapZkms=;
 b=rUb7e8NgXn8SWMhFQzkOQZSgQyMxGVyckh+W2Xfu05rWDysjzzrUWX7RXJ0sKVns+bm/aWPaSKYuOgTb2o7hmuZTVt4Z6DFC8RsdpAPy0vgzGjr3NIRPuQ4KAStgwieLuZYF4S45op+ZhcZCp0aRcFtaEgkFtiQ8AoF7XTlG6iI=
Received: from DS7PR03CA0227.namprd03.prod.outlook.com (2603:10b6:5:3ba::22)
 by DS4PR12MB444842.namprd12.prod.outlook.com (2603:10b6:8:3e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:18:47 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::6f) by DS7PR03CA0227.outlook.office365.com
 (2603:10b6:5:3ba::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:18:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C3.mail.protection.outlook.com (10.167.23.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:18:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:41 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:18:33 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 19/30] drm/amd/display: Remove unused has_vsdb variable
Date: Tue, 13 Oct 2026 19:08:06 +0800
Message-ID: <20261013111616.2267344-20-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|DS4PR12MB444842:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f50b954-20da-498a-ec77-08df291bc04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|22082099003|18002099003|10067099003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 23igv0/csXIJHb7bqIo+2r52gNSEEK1il+c2ZYGazecB99LB8kAcf00FOYqyep3zKmDijaQQNtcHGeF/sPH2CgahB9x9OqYXeE1J92vGEV7qFjFii13S78sQooJVh7bPsTbfaELz2LcRqY/qX4h5xX1dS63OGZtn9w5aFqXSN46lHfe3g1flb36XyTXOcck2WclO94a2M1Hgw9p395Zb31vHQizDxEejl/PpxrAt0gMxQbdBdRkFBms1ryV3iCAHHkxbykHCsK3dyIFle+9mBn7ecFnU9ih3NqdmnNjTSLFHOMGvsDygePgtS0zc7inCQ34q3L2/KyU/5WJoDaKlEi0lW0KSuRQ7Jvht432IZeK/LuQEoovmuN0a3OId5WgXzgzMsdfxGMODWNLt7XEDrkFm3WRSE/7I56vZFmUXPYcYvXLDid0nZhy5ytfRGPTP/mcZaPPO8ZvfOV7ZWcn1cdV7G7MwGdFfVlNmFLPvNCY5PwmWXF3t8bWnCmmBVSJu7FzPPO6ZDwQqqS/9iXvj4lLF+ijniMLZLLscpAAFm6Vyj5A1iYlwDnhYvg9DbgwzRXkOlgW6z6ahV8pcOLZo2EB+k6etG62Xso7q5+1uHMkP1AWVBACJLpIaufG/WYt3i9f/m2kACHh9H8ixid9EG3JLW4IxRaSRe1TJdB2mdoi4HM9ZjP3K7nLwVbWc/Bn/+FBwZDSlG3cbCz77+JdI0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 05o4E9jMHrHgr9GZm339y2OU7yskx8vk0CB7O6sGCcJTWnM4OeA7ONAFgV0WMzNV6jXu2MdEtAGro4cogSd4O64mjfMvIZvA5Kt3J7Pl0URF+NWNb1iUT/xyrEUb1XmaKRqOTZESr6ZoGNLF8WD4jpVcZwxxum0bCZNMTYFIpVjMxMOmHXdPs3cqVjjAUY45uCiggLt+PIzgBH48z6I/BxzIyovIeXk1VtXOrYJ3aRZwbWYVfeIi/744UEzOZxojyhXhbrZZBGCXWFl2CQ6NPmycVNywKUdqNFEObe059P7stolvNob+ChJFC4DKeGuLDgR3pQrljqqeUOWCy5thOAYF31x/etNkEau3mWTfzmEYaLv5MdOYF7TD2fPxc8H/lahUKw5TdZ+tzuYnt0DGsYY3ISS66/Tjw1M+C1iUZ7j8tueA/EnbTb9U3db1AdDa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:18:47.6103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f50b954-20da-498a-ec77-08df291bc04a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB444842
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why & How]
Coverity analysis flagged this variable as unused, so remove it.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 224e8c6121c4..2ef1483869f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3901,7 +3901,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				freesync_capable = true;
 		}
 
-		has_vsdb = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+		get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
 
 		if (vsdb_info.replay_mode) {
 			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
-- 
2.43.0

