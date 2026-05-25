Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDCACD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 18:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959E310E15D;
	Mon, 25 May 2026 18:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fWjXqeo6";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9498610E15D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 18:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvDXicBSUyzTDYUmZlKnSqqKmuJ1mFpyabbMywhy3taZgxVhOqtKgdxP4DjIWNeGVMxSRiWV7zkjuqRkDeFKPh5/DmR/K49zH2Dc2WmvFqPVqdJHV/u5pJjJId/qphgUV3olDfD9EZKdcTJdt4bh6D7Y39HMTj2pvpPdpAA2rjF7XTd8kFNObM4FoJqeKPjngVcfThueGi4qgz8lygKkCjsLIlK9tjZrujM2mhDIToKicdFkox7T9kEhugd82AbNs1NzcCj0ytsGtfAyyRw/mdhBRTo05Vnjr84WYCNau038hwQNsbtOnllzk1NXJvXkr/wNDE5U/OISucKDTQ7fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbtIbYcssdMiourbrRjQ4Omv1m/c+hiOhpzoFXCx5BQ=;
 b=I2YCLC8AUBOLB7MOQkOCDbDw/p5a5sbk9xVylvhWrhfAASnEV9Oj8Gr/CwsdTdzIbf2ykNrzexvHhHb+Z7k2hYYCf2XFL/c+CsZSz5ihrpdLhNlP8tGDPUPouCVfT9nZxhoLzdnTZP6+X5Li3hgCBjAFnTW/JlxiQnUnlYKTyrVKehyQ5SPTPRjhQi1vZEZ0QaQEtWlSkFGAGw+t5c2qwSFe9c7AT2E/IJLqpXLr0OpZT5zF7KIGdFNuoSMkIJNiRrh8qpyAMpKGK88R3KQwAzU+I+lkqvqiMYd8V1rjFknuotdX6DOv/A3+sgV4sprRTjGtP0sipgpTpHYBKGRtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbtIbYcssdMiourbrRjQ4Omv1m/c+hiOhpzoFXCx5BQ=;
 b=fWjXqeo6FQv0pq1cYhWVxIVW7Ir1hpHjSIe1RXdzQfAqKtgiVwVDLmLA97P1tTIFouB9uQGWU5ocEP5z1ygvRRWQRtVV7Z8FVBbOLrscvdfcciLFBGtNHrGJwBr7Z9PvFLer6f348bBhh92IBvS5jcNtZRbLVWlPTsOs2P9iluE=
Received: from SJ0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:a03:3a1::15)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 18:49:58 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8f) by SJ0PR03CA0370.outlook.office365.com
 (2603:10b6:a03:3a1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:49:57 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 25 May 2026 13:49:55 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Lijo.Lazar@amd.com>
CC: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>,
 Suresh Guttula <Suresh.Guttula@amd.com>
Subject: [PATCH] drm/amd/pm: re-enable MC access after PrepareMp1ForUnload on
 SMU V15 APUs
Date: Tue, 26 May 2026 00:18:28 +0530
Message-ID: <20260525184858.2451356-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: c56f9b5d-a0f0-46b9-dc60-08deba8e6ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: qEpceECA2ccYP8CwCY2eCLV6QP343S6LG6HaSHwrP12tzWI8FmYUUaPgj4z0RCMD9GE16cymvFvc0W0c0eY7cax2jnBKW4BZd58aa21t5gfOGGfqdNVoptbr9WSWTIJF/dckMijBDX4MBD78HrCNeuqpcpF1GD94r1xqHb7lTfPZ7DXxJ/U2wtZKaxzYJXcfI+b6iFd3SwLQ95ec9JF3hQJnDmO92i5KtPtVpNR7Tlyh7dmupPo8LvO46ULuXOtYXYBX2moXLo3if7NrgwedB+bYRQsXqG2uMb+TstQ0WxTwPMqQHJ4WWzXrmIiUt+59qrxM4LMbrFjNQwMMoWG/In8kG/mZIAGbVVKffdIRlz+l46e4Hjl2JtaRdRJ8jxL9JJvZ5fIwtcbRlmatHJtLBtmFEx6Z4iVkglXgBBeUJZ4FafwuIqa87Xl8N+P5abiMAaQKyrOfwxWqXey8YlMVvUvAF7GxKUuyqE6aTrbIaUc9VJUmfiCN6LVSwZoWez5VXVb6CeZY5E0TbTuPpzLldWGrlfksttG0c4EFo7w6r5MV9GmG+3xVfDu0qACUeMwVjtt1s28vrpS/wM2qP7b6dLrdzKWhJjyfMa3iTkFiUOOZPYtiix81UYM99mDjI/CKs3AeuwQuiKCkew6qngrQ6RztHUXgDJuLJg25QR/K6Wv7gNKcLgxojkTWlUrM3CwvuBIxi9xNyGq2UwCnFXTVSG35nJFBLnunKdJHG+1iyjk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XfZ9wu2DwB95SVN0th+gPW65SMx+Ywk29M4a5SN/D5fiifSg4c2FmkE+QrWyvV9bZGefIklTai17NbJuBTfnJW24+zu8zaaQNtGtN1mY/Hd+9Gui7BA/xAqT+m/LII2QfMR5+orcjKWkGMpbqlUO6emxodkNWWx9VueoQyv07uWQr9sHAI2sUBpyuSVhCYoMjgxTrASlkkmse8suM/BDC8N8QI8mwAZKGrEoZ6KK98HOIQzvF5ibz4pt1NPURbZw8gDj7aroaM4/DybCkHhP43VcTNqBdgzYMyAAqMb9kgEBYf8Dg5bCm04+Gl9cGiPDhA9xLzMDLDYJCXXgVcHTvixH0zzLIlJ74X3aMkBpvfwDtJGuVVCCiZXcVYNd2sdZ5TpCdU5tj4BOUYwoKdUu3UKEvj25CYibpswine0/WzLh3gIKzX1JBt9VS5RaegCI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:49:57.2098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56f9b5d-a0f0-46b9-dc60-08deba8e6ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

During smu_v15_0_0_system_features_control(), the driver sends a
PrepareMp1ForUnload message to PMFW. PMFW then performs nBIF and SYSHUB
function-level resets (FLR), disabling PCIe CFG space reset, which
clears the framebuffer enable bit to zero and disables MC (memory controller)
access from the host.

Re-enable MC access via the nbio mc_access_enable callback right after
PrepareMp1ForUnload completes in smu_v15_0_0_system_features_control().

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 4e7d6a602c6c..3cf47ecdffda 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -227,9 +227,14 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && !adev->in_s0ix)
+	if (!en && !adev->in_s0ix) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
 
+		/* SMU resets BIF_FB_EN to zero, re-enable MC access on APUs with SMU V15 */
+		if (!ret && adev->nbio.funcs && adev->nbio.funcs->mc_access_enable)
+			adev->nbio.funcs->mc_access_enable(adev, true);
+	}
+
 	return ret;
 }
 
-- 
2.43.0

