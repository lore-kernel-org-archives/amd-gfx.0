Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1366BCD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F28310F493;
	Fri, 22 May 2026 00:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PhK/RJ5T";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E6F10F493
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI1mfxCXNFZHlOzJ0sE7JhbgJfODRG67q0iqboLOKolYXA4VsD08NSbShdtpbjtj9NloA7derJwNj0/5Ytf/rptPnXrElz37lkaled05YY0cHAMRu61EnkjOce2fjVgyoVkMHRaZbyzjqntFioc4yQVQRyZRw9CR4TF+KeKaMbLrrwCBfaTtc+sn5e1mOEfFuGg6WGdGiMVo4MhHfkb13z2UUFUhsZfHXTHm/0ZUbIZBbfYfT3jDLY+o0Hw6/RwnEqkv07p3BPPUClssByfLRhV0BuVilFBGY+HEWEYRJz131ppl9hAmNZhgU+hqryt4qMLZnzBinNjsWriDQbxcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS0UB6cVp0wJrTfRyMUkEWi8ki/wG4B5t7yfGnYoRTk=;
 b=XAJbcFLTHoC4UiTCd3vq3m9tczl4eSqvn7JA2yJLdFzXtQlx2NWhlT3QzAY2H6U2wmA6L7MkwTvCz8gIdVjSsL1cF7aXrNM94OqbMSe5r+HsnI7QOc/2ujYGuxPdWlYCCE4M5xvEHCh+tTAGf0KrgV5dpspMSmhzpLxOW9lj0Oss2TmDY+2xRagNFwdEFOuxQ6BpbCAWFGrs6hFIbbmSemVdvuwVNfPe71UnGl2+AZ/RAnW6coI4v7aCZSnbyJmbgl6COVwfirT/uX7F0I7kjBM/x4muPRc+2DYNzI5UHHUxJzkn58/WCTIKq5IrSK/ZEDi9lYNOcNtnlUvCDWdLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS0UB6cVp0wJrTfRyMUkEWi8ki/wG4B5t7yfGnYoRTk=;
 b=PhK/RJ5T+MFxw/zwLbk+Yt6rF5fEejrDO2QmRPpIBKbbvzg+SEen6IPPt6NQVkeRInPZtzH3+FI63pAlhCxDwNOh6E120BHI2QT+KSe2MW2iTstibnQwlCo8VeXr/B0PpKMSlzbGw+LTHmyjxx+gaZotfDDfTUF97ADdYiBgeEQ=
Received: from CH0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:610:119::15)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:22:29 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::91) by CH0PR03CA0364.outlook.office365.com
 (2603:10b6:610:119::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/42] drm/amdgpu: Expand MES queue/pipe reset support
Date: Thu, 21 May 2026 20:20:48 -0400
Message-ID: <20260522002048.98506-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de4abbc-c1a3-4897-0820-08deb7983472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: WGq8w0nLL05GaJdHe1NowmQIH6qzbqXPylGQunntIuySkqOyEVPoi6jEfHmZEUjyUk3gPe+n8Hkn1KROlGhsQQf9eLAm8b/9EhNG1YadGjEqowJPOmaDM7MNWlm3NtLCWtth8wDBCuxbC+2vOTgRMsJ8PXGVCYcJguy/mNufKD/6cM40IqJRTvhx1MaGJLwLfUU/5lhqyThzCKYuNFv5fCzuV2AnwUgU0yoNMlgJ+cX7Jri8++PzeOfXE2t8btY6qtcaL7Biag/li+rgPgkfWSHanGd+uhTQTqjvnEKFA3VQb69NhjrZM5xF+qQqs0cYl2XBRk4YVK8k/YJj9ZBM3RC4uR5wtYEJXKTKIopXa21Im+DHnCKxn1SJkvhkycWQ2u8ApunzKLlUrG4wPE0DHqQaRn/hE7512n1TViBAo5zIYyAhFuWtyEWAzUdr2WbowC6TjxwNK5avLWdhUYgIFj54M+mviJ0KPsg9Zb86s75f8OGh/jTZMbiGCOYWHMcmQ/9s+8fXewqLCmt76ywvhZjEJXi3Ti/SJlzxcFdjCJwbhfmbLZy0aNJbC62Cg6KOMHEUri78pDfv2egxExEsiFiY9t3WNRhB961+jTjm4SvdFrTloVDUCnrdIT2G7cnsU8pQR/9DZOoN/ndX1SXie/h/vkcC9AhiU2V/OkJR1W9EcX5JWbn3CgMhq9DOzQ/VnHaGgagv0loZFhWwYDDdBvienjfbBPRhhAJ8HZJ28UA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1HF8d04r14GF7h2IaaGyx0FLS7x02JgY52Yz6a6zIfY1Zw5ufWo1UueSaG0UudX1KvMLfydz87N4ZT3uBu2MaushgMzuS4x3DNKIJMpO2Rw/HpaKMExUn88NqiuIJjvJTA9eJEXgVUDY+EARzfFTy9Ak/RzZ8vNQh5m/u/6m4E+6lGYEmT/y1wcB54qCQ7+0Jh2m7di90/6yJKwWBL2X22PURn/kpuQOA/AELoM+rHqPT93RFsPyFC1KnQ59mcAGhjEbKPafcpZsmlZ0mI/7otoDDhcngzguhRTmraxdPX1aisDYlAOlnpeaytzjJ3uuwSwIxjO8Je9qZHsyBHd4rA9wtEeWIDPj6YGjZVfIaXQmfJGaYskbTApZr+XWGhILxSrP7YCO/sthPTdd/DsKn9Vr0bQt3jZVzgC9a1pjMUi7UXL9MZQ6OARmGR2YAqOu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:27.5405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de4abbc-c1a3-4897-0820-08deb7983472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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

From: Amber Lin <Amber.Lin@amd.com>

MES in newer versions on gfx11 and gfx12 can support queue/pipe reset via
MES.

XXX: fix the version numbers when FW is complete

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ec4d9a1e029a7..c65f893815c50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -853,7 +853,11 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
 {
 	return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
-		(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73);
+			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73) ||
+		(IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
+			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x8a) ||
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0) &&
+			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x8b);
 }
 
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
-- 
2.54.0

