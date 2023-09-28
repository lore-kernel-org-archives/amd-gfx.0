Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D7ACE7AF8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 03:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B0210E5CB;
	Thu, 28 Sep 2023 03:46:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A3110E5CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 03:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct3DMgMZ9Ah6Yp+tbNykBTuY9nSY845KLWpONmpOrsUv09y7+C+lflvt9Dzwxjl4ZaC1Jqyh5ufCQ+cWHyExAc4hKbvEIDexUu884aDaILMlac5muNvCHL6/Rpo/t4YtqZ8sjs2dWF358ky5YmaOxxuzTIHN4/3FCIoTnMc9f3VsuVKzl4azgJL996PFTk43am79Mi7Zj/ogH36h5kvGnrAggFJiux57CEiFTPdgerjGCUB0QODyX3T5Ie0lFlsmCTVVXKbd6RwqFKthKGLDF9PRIlUnpJMkcNscTQOx3bkoJx8Cxn0KoPTz9wue1N7UQfSgAHtp0SFdcUEU2PZI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RjJhM/MsXqmrgrykwCBb+W3cCbU9ovjtbQoLIBi+2Y=;
 b=G5wNqEPyH43OaO/UmVmCZ+YKVqkcDu1dMhD9yx0jKlRSFGDldROp6ZZYbXuqGZLz56nkfzzfFQE5pUCqLKpAdx1izkuxpbDHskqIo0/NQCVnQCgwfKoFoOGmPYSDYdwh4gIaWDGm8AXWiouPXpPPKQ0jb9bhJCL6X03MhsDXgJYGD3R580Yc5zRKEMtZvdyOrM5NudFlFGaMOgXl9Qr+VpzjMdrXGRt/DudrVS3zx1eQ4g6M+37yAZqd8DmsSVuazgRwDNWeHkT0FWAF4+YaARUUuPdjW828ESPiqqTPEcDKcAhgEfo+Y14b/7SsKrzuw6Mb0bmrTgWFuuUd+pB+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RjJhM/MsXqmrgrykwCBb+W3cCbU9ovjtbQoLIBi+2Y=;
 b=M6UP1L+uv+k3ZMdF4uJAhASb8vGfxkkKbusn/621EU3mJQrHWtwEnEREvHOZI7036NW5kpYpk4TsLKUmnK3sv6GFETOe9c+3VdExxOGAxcU3AIkHn2NixKdu3idbh4eWmIKYDSf8KFG8NevPQxrysT/4hDQpvtWFWGS1NTxK/3Q=
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 03:46:03 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::89) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Thu, 28 Sep 2023 03:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 03:46:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 22:46:00 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 22:45:59 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix potential null pointer derefernce
Date: Thu, 28 Sep 2023 11:45:53 +0800
Message-ID: <20230928034553.2172440-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 151f7063-0927-481c-a0a2-08dbbfd57022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/TeFoT+x/oqbn3cueIyJ2Fw00E5BXf4GJ+6j7aa6hPPWUSWlJ4oK2YWi4HkHvUzJjkHX27tQi9tnwMGUBFhpmq2B/CS5eMfs/0WWmMdv862MAIWXhMUhRmg9cDE2QVnyXTs3lYnPnPS5t16poGOyPVqYeTl6pTb+x5nk22/hAneliXLGlV1XskGe31xgpVF0CHIheOsL1wOY5YDs9AySOBwv7P6vO2/AZFkDcEUb5RS9Txj73JqG747nCmKokVUYcFOETQs/OD1ZklDha8K0HBXtFbhkRVrV6oV+rjljr978mnjlltCMTEDmrp6loKFv4Ys8pvlqA2hl3LsCMSqlvbtoZ72FZHIQ52J4wQGVE7hyTzXqJ034mSq1aK8EsSUfz6/hKKM2rUcNNpr93xEy48vplbnAvV+qEr7HEyWWfymA4RPUv3TGumCnloNtgzW/VUH0gKMhu5F1TEZbgqU7n8WLGxmWeafHujjUCpQrYnwq8WEzZtPZfJ3z8n5l8/OVPMYsjLzn5rhkRXWVpeQxkRso8Dg+lgQV6t3JDvByX5dxYttXNN8dMLdUxVTclzheZHcElrKhOWV2d55qZIgtjlZxXKDbIO2vkh/PSBVsrN3kGdg19uThHh2nobqzGAmbvVE/V60wyVpJLkZxai3WOSzKG1dPNmhMgl0l18rF/6XowGOgYoXuECubodGhQr2zpA9LEupvqVeVH25Evbf4TMF+f2NeU0PrC4fHka/Gmo3MrH4NN5E6BSRqDHiVRQEAisfZNevhBbY0vXJkFfPoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(4744005)(2906002)(8676002)(316002)(8936002)(4326008)(41300700001)(5660300002)(6916009)(6666004)(478600001)(7696005)(2616005)(1076003)(426003)(336012)(26005)(83380400001)(70206006)(70586007)(47076005)(40460700003)(356005)(81166007)(36756003)(82740400003)(86362001)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 03:46:03.2845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 151f7063-0927-481c-a0a2-08dbbfd57022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_ras_get_context may return NULL if device
not support ras feature, so add check before using.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cca3faf4dc23..60f8a18592b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5391,7 +5391,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
+	if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
+		amdgpu_ras_get_context(adev)->reboot) {
 		DRM_WARN("Emergency reboot.");
 
 		ksys_sync_helper();
-- 
2.25.1

