Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBFAC982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CCB10E587;
	Mon, 21 Sep 2026 07:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yfIz/CXH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1E910E574
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFq9ov8hOp7PqUlS8rKciCbnZ8ePMVnzdzJ9lBqwwEsKdScu7pOZIuKVanjt5XO/C4xl0qQJEP/+PJm6UKgY+d3FYXPnd1LZMsPdIekss/Sm0w6R9zUMHWdktc9zk6J/i2NutrOLXCawFUDF6iXNTFMnNWuhE+RHFqK/BmZiwqQSlTXDrxcTBuzNV4j3CE+0RWxSYVfC+oPKqh84QHUsSiGG3Ucatops4Fco3OP1aJdB+aQEcFdQ7Fxbq+ALgqM2Va3VpEtVJ3xdO1nsyP2mwN1X7hxbU6C4T8oi8jEyT4FxESwzcODTBcqgemQ7Q45qTdvpCEMAxO9QD3Ee5lpZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS/57ytCfsY5/o3kzysRAdLioZW3N3xh1/8qkMplS/4=;
 b=NU66Dr87SoRg7gfWKoFZvTqFrLQvqG+dbgAoHkrKuvR0S1J5cf0HRDkj2EcyuzP3lRbSIFFSsBpbNzomNBhum4/U/ScYDZgGP0e9VxtkgwnZZuhSkcaDImu7IuAGudFyMFwf7CszkYiN6Hz3v9LJ6KPrsAeygqbWsTujkmE+LcTfGNAKwZw/8TpnQo11ToB2nv6tf95hx6cimOqE+jNp3qbGLrfaep4uR3D/5LmWv/1XDs+IlhhBNSyl8FxYFb+kP6N8T+E2E3Gzd/bPX4yBCwMeqoy9FQIb88txQeD5Pd2Vl982RyRvJVSL3Vh7PHd/q5n+XU6W1UpM5q2hBRYzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS/57ytCfsY5/o3kzysRAdLioZW3N3xh1/8qkMplS/4=;
 b=yfIz/CXHUSZdHoEuk88dWODwDjIkBlcglhTNoolSYhNMVDji10oZ1CjdZ4yTxBta8ftrpPMWUzJ7vQpSYAbJL0lH69Km9SUGmHB7rCWOkh0e9zSyQbo5DUS/qnqPz/hKTEODCtveGpsM8VX8qTN0r1hNoP9mMyLoayirfASfqUQ=
Received: from BL1PR13CA0173.namprd13.prod.outlook.com (2603:10b6:208:2bd::28)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:54:18 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::47) by BL1PR13CA0173.outlook.office365.com
 (2603:10b6:208:2bd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Mon, 21
 Sep 2026 07:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:54:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:54:12 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:54:11 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 20/21] drm/amdgpu/gfx11: defer gfx pipe reset enablement
Date: Mon, 21 Sep 2026 15:51:27 +0800
Message-ID: <20260921075326.2409021-20-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 51adadc9-cb83-4db7-1ac3-08df17b58a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fjWZnz4CqqZ6mcQDNzR3bje9TI8clHStCmeLc7iE1Dngp2ApKYRbQGQIQVnoFRVj57bgyHGYxkpP4lLCA6bbzVYsNXwTQ1/QmxxV3S1jnUY5zfirrYn4kq7Yeig7J2zCaJXMMN0clxoH12umazo3L3VIOhTDDgub5BRpZC4r0TWYmavihxcsNauxm1rzLHDRHoRklTY3coK7/8m/fIQkLy0oVteBivllkhPld3wOnAgbyGRx6uGw21/X8zUA6B7ZieEHmYMSqmyuJMLkWpy7p2HkYw8nSC/nA5NRqVPzCHZ5uaD/mUu9AHORFC2PEj3y4p4xm/bM5037LSFmVjD8hoEfBvipmVYtI0/cjADe6TSsf4ktHZPakBlgEsCoUEqHV/BT7ViejhDr88DuUR91tBFS0wQaTNUR+VDO5e7AIrkoIYjlijGP1GKN1euNE9BCJjIC23VEcEz5NxUATGvGggTtRt5tv4V51K9Z0aupgfnxCAN9G8HBCCDVjo2neqhq51DS4dik3XJSLfxmvAMfEogx+3Sx7eaT6EyfbujRN3ZtmHh25imhirnla7bg38eO9uwvkFID0PaNqYfD6t6EH5mOI36b1tKl8LMCH1g6D5HL0zu5/MKKCpO4iNpnBP2NseWHGoSqxsqea/PGsO4U7tKv1JlaDseyMsX91anOEO9h5fesbj045WRcreMpiBUWPn+htaV7LrRWPer6I626/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qtaFLh1YdN6UAcuxyZ5n9FG0qsLxsSY5fIBmqVwLPefI8bO61RixLVRLr0Ze3IZzYWf/RX0zswxkrpkdDp3v/gFcxGP8Jak5C3bDGcCaCm7DoU4mDbibGgEmWI5kBqBJG0f+PyhZzBiBReGcLuAIc4JSxd+NRK9k8jJOJSXjCHQam45hp9X56ECnpmWekUdOF+RcST/Smc27rQHQvqkjMidbSdVm4slmqh7MjF73Et7D7BViFS+N2xYKoHPH2EtDkM4ibSB+PN9851/63IQo1d8d+1BUsijYEfe/ZBTjzP5SBe2z0KxGtWsr4bX06aLVDg7iA7JKiyeuB5GQjcRcwW1Nt7Mhy6jvnPIoaPxDltT8LyJiYZUC4Yx6mkmSKGlFJ12QC8qqHPuSkJvXWHYuIgsa31JHfouWI2igKAWVS928lXH4LL9VkRRbGEdhbb/f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:54:18.0914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51adadc9-cb83-4db7-1ac3-08df17b58a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
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

Keep PER_PIPE disabled until the minimum CP firmware version for
warm reset is confirmed.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5ed70bbf5313..70a7b890e70d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1921,6 +1921,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			/* TODO: verify CP warm-reset support before enabling PER_PIPE. */
+			/* adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE; */
 		}
 		break;
 	default:
-- 
2.49.0

