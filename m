Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4ABFD4F04
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 16:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8314110E76E;
	Tue, 10 Mar 2026 16:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PUtKmCpf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CEE10E76E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 16:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br9foP6AqEK7j7M1pnIg2HBaKgk1f1ah6L8ylRFNke8Ifk4MOS9MfWstHKyq0v4wOl6vtnl6w7vAdh63+xlwK5WL9KJy2nkZmedPC0P10KHMHe2/Qq5u6irHF9k+POppTLTA/2rWzdMPiRUIQZWEj+9PNNRYMYgIeMf06PRwje5NFzvJVxUhCZpw/UATxNYky0+yr7vMg01R/V3IOAsFridUBqogoL6tnKVh1ON2L0hPgiJL3xoRbwuwgD3UCj3WSfmlc9+HcS3Ni7dHTRIgkKDx20op9unomLq3bz78ED/og4U7vbYk9K3DwlCgq/n6LPr0TPqNtdC9S5CbvSyHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJTY+OflshKjcM6mtiQ7U3Bg93womaQjuXUF6ARUTGc=;
 b=TgG448vyCAeUwwQhMlJiN2WEiizLS0jnoOXHN1Zh+J4cNFJraxaG2yf9pWzwK9kpiJ7i0bBMjy2F9/9jGAKmh/ebDQN2/Tz7qVa35/jrEHQlyzIqu6d+W26ovRu8XnpMv928nmH59jt9ZJ0zNiLbzkJZmSsSvhFOXhi0b+QSDMGAALhJ/XhYazQHGEVMyCDvNcCS3OUUT68DONvskH9GgOcrYq3unirW5pwOO5egH0Q7VjcBcdPOFXg0RJdEMlStO37qjejC5bgTYbm+iVOgk1OheQU7kRYJ6/sex2PYpEYQzx+Bbrl3I8+wqnAiUzKRUsNRSaoPmPPcAPHXconX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJTY+OflshKjcM6mtiQ7U3Bg93womaQjuXUF6ARUTGc=;
 b=PUtKmCpfYX7wtczjfCzW6FQ4CAJ3vKjtqXfLUAvsROszm/T0Kc8SUBCeg9v5XVEM7QHdIGSWlk8byjvmCOyd7+EgjxgPWrcf4jCBA0kV8N2mJAhtdyVnOzeH5Pi5+c3i7Q/sok4sQuIDDwYrimhT24jrLjJb+zs3oNu6Fg+aEeg=
Received: from BN0PR04CA0166.namprd04.prod.outlook.com (2603:10b6:408:eb::21)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:58:43 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::6e) by BN0PR04CA0166.outlook.office365.com
 (2603:10b6:408:eb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 16:58:43 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Mar 2026 11:58:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH v3] drm/amd: Set num IP blocks to 0 if discovery fails
Date: Tue, 10 Mar 2026 11:58:22 -0500
Message-ID: <20260310165822.2930580-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 802862dc-2c79-427e-d9be-08de7ec64989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fhs5kfOI5zPKMeugVVwMqaxkcXemAFAlDO0XT3x7xGojwa+7zeeX4Tc81Pq2SkZNEsKTmFqqpnRGx/BGGehIB2nkx4asn0cKoOLAFqWkbqJbKM0ddzre7A95rJGcpv3mODwk3hbpBYMXOA57g8T1IZq/czegc/f7R+2AfMo5+ET0V/Fi3uWBsSdx8T1FaiEuDf+0xK4QvdMndluw1a1d2Fh/mUtSjZ/WSngQuy/pWrw0f+yCelXHMOq0mW5X/3JP+le63FNZ6cO8bB7YcvUTTRLGCozco35P/wlRnmpHuLnPjax0i7hX8nnW9UIDeXpbb8N2FwWTIMVELwNgc5nh1np29apVyMfdDnauJ3Pz1enl88oLr89Omb78Q7TyoltvLBExm5scxKcQqdYJvHZvJMb1P1c+fnSOsKIKYsik9NCR9YLc+woEr1YVJJCA2oQOPEMMy1yFUxZfBzypsUNgAinEinrf+bzdlvl5SiGDGofQQKzU575oHtJkHLqgafyYKcyOUKX4buZvTDjWwAaVBffnAgsOgYFdB2VWtxLXllbv6Fupl5FWWEArrDa3WcGgYvH2HuWh1aqD6T7444oGstA+z9d/eF+CCR3wynkTVVXuDF99I8UwVbId06kIUrPwctQjvR5Cg8QO1RTTB+/VKawKGvD0Kp0JeCkt1cQMtRayELxHGpnim4X9aUNPDyaKbIcFT/Usmx4wVc6grz+Tu4AUsqsY4nnW9/X84l4YUpCDWSPav/68aukcp9mT29vsN6DrmoJfM/39bMNBvbxD3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LDWV+W99qWezJKmpqvdrP/EMo4W6orUraK7/GT/iJjmq78+g4B/rGtlGwyarXQkiju6MB57VmGgAuXDFl5/63tCd1eio0mFGyiEwPmKocbpKSysME78HQU+3mhyPynI8rz54jyRMCgZoOBeOl5k9WPGdPbA0mJ+wq2HWHEG9YwoN9S7xslS9S8jpHuETQwfoTKhGv06o08xBtHz24dKhzysUxI1fDHlOjt5gtgHLJdo1qrLAi1mJp9+X2mCh0H8EoE4el+ipp9d0/MXhgZ6YhEBImZnsWJF7JQIR4orLxM83dERV/2zZwOIRXvILHUQm92o4JLxjs+CZX8Foh0nQ0HBuhyetD6dCocLj1QyVrb+i6fe8vOcwh8geTLz0XPfjRFQGa51r7GYGAQgTuqfU49v7f7oRBxEIurt2jcjNUIev39BgQ4d2Pu5W7ltpw7EO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:58:43.5135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 802862dc-2c79-427e-d9be-08de7ec64989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

If discovery has failed for any reason (such as no support for a block)
then there is no need to unwind all the IP blocks in fini. In this
condition there can actually be failures during the unwind too.

Reset num_ip_blocks to zero during failure path and skip the unnecessary
cleanup path.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Skip cleanup path for early discovery failure
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c24369821e47..c1949070a2969 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2701,8 +2701,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		break;
 	default:
 		r = amdgpu_discovery_set_ip_blocks(adev);
-		if (r)
+		if (r) {
+			adev->num_ip_blocks = 0;
 			return r;
+		}
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 77e2133de5cf9..7f19554b9ad11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -83,7 +83,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	if (adev == NULL)
+	if (adev == NULL || !adev->num_ip_blocks)
 		return;
 
 	amdgpu_unregister_gpu_instance(adev);
-- 
2.53.0

