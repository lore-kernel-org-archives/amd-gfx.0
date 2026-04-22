Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2362BFA1FD6
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 16:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF42510EA6B;
	Wed, 22 Apr 2026 16:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p1aSfU/N";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1691C10EA6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 16:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzJQmGZ6YuRp7r8VwrcnD0uMTjmRArU860OMTyNWZnDCzLMhzSi0COBGHNlNgFjFUTgSlZTlT8F1PJ1B1jvCNL17puyL7zyZkOwYaJ/GYjPNTX5gvProcPq7ZxtpjurFZZ5eJ4cDU99vWhlS4s4E9nBv2bsRRQrhupFA8TOLaxtZKRCjNZ2w8Fgu/z1KiIBsjmf+0gBT9eJFjCtOhn1sRBYqmHcu8rpWdrI5ftmJlKbEmhdDLnF63lEheCWcOWSRugTymlspOcu0HtE1sxyWFxalhvoagTEvBdz6WcftAZVF/Q+9GVHwbC6Z1Mrd7xotWRBNwpKqaXMRv1DMJEHWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBXvf8EQrNy/d+7omVEDK9dRi+m87zRlKgAVKpwqEOY=;
 b=ETMpOeNeNXooZyMlcEV9TPEAUXLvAjyKksQJDnj7w/BDyRugFpshQ1mcJ1iEFz0bneWVakkZukwkCztmPJozGiueKIramtFkXPNdbyxzaBNpI5/ASrL4Air3xI8VRt661JSBBF+tCVc8OgMc05lXMueCMPDcnOyLbu1F/+3hnVS9VJ5SGppi0fe6Ra9FhlMeiIkuB0F6iKM/WHEAienWPFCCPDfvJ67w5PdHvRcwkqzPE/8edYGO3ZsPp186M7cpp1YzYIdmoV/y30BQ2H5wDhGgQ+097ymK00hssOI8KCm92OlydYplZfC2EISHD0MJ9unxe5n5ZCkR5bpe7XLwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBXvf8EQrNy/d+7omVEDK9dRi+m87zRlKgAVKpwqEOY=;
 b=p1aSfU/NpBNkTNON1xB2RGVuRcvfDjw8jJEBJAc2J2zrKegqCzYgMyDJKC0tMA8vL2Zz2vfk6GJpb4Ux4Ay320xX7oKKSzuiUpiX38WELUVFnOAVlHRQ3YBjR/Dfr1+dgfiTPKaxT83AskVzkCiY8aX7+yOKL4sm+VISP8mcyNE=
Received: from SA9PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:21::19)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 16:30:43 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::86) by SA9PR13CA0014.outlook.office365.com
 (2603:10b6:806:21::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Wed,
 22 Apr 2026 16:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 16:30:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 11:30:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 09:30:42 -0700
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Wed, 22 Apr 2026 11:30:41 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Aurabindo.Pillai@amd.com>,
 <mario.limonciello@amd.com>, <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>,
 <stable@vger.kernel.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
Date: Wed, 22 Apr 2026 12:29:56 -0400
Message-ID: <20260422162956.620362-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2f334a-5195-492f-d20d-08dea08c7fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|1800799024|82310400026|376014|32650700020|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5c3e0Cee2zqTCAKLid/DC6odNhzGTySRXVOyGuIQhC6uuFpb+bAIfGElkRiLN1LyKOA3V/Cjeye99t5x4ass5zv8y1b7M+9PCzHZWw+bnwyg/62VWCcic5rllC15bD7hXVc3bWL7Xu/WiM522Jr4h+ZqOlZQ4VNg0YnATZ4H2GsSv79h+y4UUDiX7zCPM4qS4II150/FaNJwz+D0hBI2L2i29px0BIkoOGUZFwesNly1dVN/zf9jbo8FcG1yrmto+VHWxijVybbGdFvwLcDUwGbHicduYXDQyUJWBklK6SKY6zj3H/Drg1QxxOBpMmsaTg/cX63a5vMNRjZQNpHJCuYMvY6/VPJn6gQGZWjBvnd2sWe1Uyh0FDi4jRynd6J05r3aPp0OCTJS+PDvGKk+6mAAn82AXZUuf3Pe+C8SGsNm/gQHbM399JnlHHwX7Hh1qlh8YWR2BgYe2qhtz3UHbBf/w4lrPEf2DCvwO1vMxVb2pZRvpY1kVDEFNMuMJyiT+9E8iR7dHqsgsx4vY816FzjYCibD2zYTWN8Fuv5DDE9fSNo7VxCIZbtP4nb8Hh1epGShX3JjHyqnsUoNsezi8aB5yIES1otsZNpV26nIq86//sM8pZRSArvczqlEDlV4uBnumxkaXLrTmj/dnYaak3fNHPHV66W+u/1aTHUYvYBxAzfzlD8NGCvYA3Ijtjy+hhOisJV4tOG+008QvkoTmBnVwnT/C6YScSnUne1I8bY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(1800799024)(82310400026)(376014)(32650700020)(36860700016)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mlq+I/AQ7NejQI+GKXZmg/km406/YiW13xj5IAGI9coS7J5c6qIAcfG0LmZwKZwKvTosqXlgd0eFFZgLgdwsR5G1myXYmbeNfh9OSPH1khI7iYHUCkgSh77PVNNBMwJMs445Bqn9TP0F3kt09KJRhXdr9eJc3si2IRXB3oRM+Q9+zKNpZRJgzNomwwi6+XiGWzYEoad7Nl8e/a5Z8lNkb8IckWipk046Y+dniDJ4/iMyBiXtZuyby/N/9vfyOzfn2pzZEgXMX4BXacwUoY71+m/iZ4Ou8ShqiQjoKDT0jWDhaoprjwlqU1gCnDtNDp4Zanb1jVsWQDSK2DpkWsjRTRnkLFXxI+ODpzm3rg5XNedhyAfs6vcTdOMMIE6LKYm6SQn/9gUDBv3lgt6Ai9jfZ1VMLQXzusyE6WrcEFCVCyP+R881ppU+vS/DHf/Womi5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 16:30:43.4031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2f334a-5195-492f-d20d-08dea08c7fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

Rapid vblank off is causing flip-done timeouts for NV3x and newer
family of GPUs that support more idle optimization features.

A proper fix requires further investigation. In lieu of it, let's
workaround it for now.

[How]

For NV3x and newer family of DGPUs, restore the old 5s vblank off timer.

Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3787
Link: https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Tested-by: Michele Palazzi <sysdadmin@m1k.cloud>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3fa4dbda4517c..ce5063928413c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	if (acrtc_state) {
 		timing = &acrtc_state->stream->timing;
 
-		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-			   IP_VERSION(3, 5, 0) ||
-			   !(adev->flags & AMD_IS_APU)) {
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
+		      IP_VERSION(3, 2, 0) &&
+		      !(adev->flags & AMD_IS_APU)) {
+			/*
+			 * DGPUs NV3x and newer that support idle optimizations
+			 * experience intermittent flip-done timeouts on cursor
+			 * updates. Restore 5s offdelay behavior for now.
+			 *
+			 * Discussion on the issue:
+			 * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
+			 */
+			config.offdelay_ms = 5000;
+			config.disable_immediate = false;
+		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+			     IP_VERSION(3, 5, 0)) {
 			/*
 			 * Older HW and DGPU have issues with instant off;
 			 * use a 2 frame offdelay.
-- 
2.53.0

