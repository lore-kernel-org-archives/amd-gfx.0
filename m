Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160FAC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A3D10E210;
	Wed, 23 Sep 2026 15:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mYcba6/l";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B7010E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfx/l5AI8qrO6GZniAFGHEZtrqlpAvj9grLLHTpDc6RBA4IigC4xA8Q0s+esKfwREbjrdO2xJbxSHz43ul58H8DqBijgRx35MVNmtNduLtglQI3vlRQKVyxJAefkZJB+rYnY8o++F5jcAzRxnoVZMhCWIUmse6pIVFBC/lyhArmeTZ+WpWGfaHLPYCBdcaqbWBqQLT/IDC9X5ZnKNP2gVWaRhcP313IkL4v8a1sfc81tgk4iRZmMqbCaCKTSEENvn+K+Mr+5j8uPiGItS767TE7SASs7fsQpG1hAlClbH9bfaK1poff+UNxjp+A0dYnCFdrjXVJ4mvHZw+uO5bNRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdylyQJw+6PW9hN092UQob8/G8b0LQ82OxRSB9KPhWk=;
 b=v76zSvEzLXGYa70ZVUgmLvQlgK+P8/B7TTeublEUcL9Nsze9y42FdZz7t5pmiaiTRubx1og3G4Igezcfyh4msD6izfO1DNF8xGPdC18tHM2B95KtqmzCyk3lz7aV4KE15QEMhU+Erx1dToPAD/Jgm4VQOETqWiZ26yObHpnBKU5c5Hs4/3sueoIQGQID/0veihWiPmqZS2BhD7KuAAdmlbfb3vmEE/g5Pta7ShYPZrWUJVuBEqNfmB5v+KIBOwC1HBHq4PDvXWwRqggCgxJwTI0xHvUVZwOy1l11twOoZOqTdZopU5VBSaBWZdOur7xmjrg03GCwRinQWeBPsdeXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdylyQJw+6PW9hN092UQob8/G8b0LQ82OxRSB9KPhWk=;
 b=mYcba6/l65nqDmT0FN8829qAUj4S/3kKq9AY3Y18N+SbhQGuoho1MyOjPiYybB/pnFEQI04qcc/gU+mg45vKF9w555PPRnMDGmS5f3e4B0Q8rXfNyLlPgbyT41uU+cM+M1jS1gVQ0Yf3UOu6oJP4VIt+nE1tu96UEfRv+QaxTMc=
Received: from PH8PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:2d0::6)
 by CH8PR12MB999204.namprd12.prod.outlook.com (2603:10b6:610:35a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:12:38 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::43) by PH8PR02CA0014.outlook.office365.com
 (2603:10b6:510:2d0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gangliang Xie <ganglxie@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/12] drm/amdgpu: add ta loading in psp v15_0_3
Date: Wed, 23 Sep 2026 11:12:19 -0400
Message-ID: <20260923151226.2778589-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CH8PR12MB999204:EE_
X-MS-Office365-Filtering-Correlation-Id: f13de954-69a7-4b33-8398-08df19851b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4nl6a0oOXtWkZ2ad0pbO2Dwfpf+3cETuuDj05PBwz3jk5ROALZrlCogFEv7DMP+K2Zkq0TjEvpselxKE8uPR4cvhNAhfUfxzk+K26agolVWSvw2S/CMUffU5nI9AU/ZZuNC4ajFJFQcvdbskXOWruFRr/q/ONO778MeCtO7a7UTtzP7NdMXWiWwY/GCMNP5rgyITNSqe5Ex+Armr/HZUZk4l/JnnU0ZR1fYT3bGaahUnjWRFJYD9U7EqGPHExNxOVmfqC9F7mJmeU4ZQ5DHvlFfisUVyzCtt22NmxjsCr8Wr/nqDy2dHeTeBZOEyYw/w6bIZyd+dpLp1kfUWit9VA6zfZ/m2zWVnDwW7fUX8fH3RtXtWezkrt1GOdOcLeUI9LSUvA2li36l9HDDRArLxX6IPquVlCXPIKPle/kMmEzd/piftAUGVh6ZwQhX6LFTrPz0z5IOm85qvObKEfFhKBU3d+D+1MxpQ4EGU8XHfplFOrR0BT/mP3E9TEsSZmh9dZQDxTAt5CdhIxc6si2nzeO6qsFWtUhaT076jjJGC5y/kS5bUDJuJRs1yE4mZNaf2VkBw5Ah4j3/+Mi7SDa2Nd0TwvMonv0vixZ01hCJa6+I12+zmiaG1sBrNzG8GX+Um/NV0CXOv0g6Thza8+LGH/FO0pVA8ibGaHWuvO+dgVSFdeyWLn1mM3H7QkzpgPEyhEFOJH8LlQ0TAFazJ1CCLQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jljLWqozZCpGojq5jgG1sfkYHB8F4tG0LKa1EOhOKJ1NpYY9PWjO3j6YeZEtCB08EHtJTmtebXsP1dvZDaoANK0StzEKePThuokZRV3G9bqXB7MRlNbNvYcQfxNtHz6I8w9O6lJNmNeD0Uy/IG4pglC/qllJ8LYmhE1ioWj4q3v/UdX39d9tZ+cD9N9yYEb3aTFPy5Qbjbe8R1YAG0Rin8VZjd1HtWUAJKkO5w3f0m5yTBO0N3mUxYJHEePP3H7OfpnY5mX9Do0TilxYF0HHIPi/vUHKtKLbb2sxFaL5EBB7SkybUbsiiQHxGWir7ZEf8Hj3gabp6VbbyFP2ZrEjidqkhOH1guH8zszqeMU4PJ6Wwr1O+yWjxzs4M3Dm9kezXuwAANQBxwhd0jR+n11NKGBTNigtEUKoVIfSACNDM3ocRHO8Sjgz80+4q4acMr0x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:38.4180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13de954-69a7-4b33-8398-08df19851b15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999204
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

From: Gangliang Xie <ganglxie@amd.com>

add ta loading in psp v15_0_3

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c      | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 89b09ab2a34f8..d43f036a3f37a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3160,6 +3160,7 @@ static int amdgpu_discovery_set_ras_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(15, 0, 8):
+	case IP_VERSION(15, 0, 3):
 		amdgpu_device_ip_block_add(adev, &ras_v1_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
index d07588e8efb3a..cab3bec1e5127 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -64,7 +64,9 @@ static int psp_v15_0_3_init_microcode(struct psp_context *psp)
 		err = psp_init_sos_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
-
+		err = psp_init_ta_microcode(psp, ucode_prefix);
+		if (err)
+			return err;
 		break;
 	default:
 		BUG();
-- 
2.55.0

