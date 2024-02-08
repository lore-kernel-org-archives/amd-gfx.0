Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D15C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 19:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4BF10EB98;
	Thu,  8 Feb 2024 19:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U0Lsmst4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2807610EBA0
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 19:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awOX7M486Za6//f5RLVs4JLPhjadFNGYxN0JgZIGJnDtRjG8N7B8LaYF/qmMQsfYbJomaJjjSJbX8xc4ByTMMo8cXyStcUMAG4nnvAhQUwhVUuRrmyf64PT39dMwaDOKadBDBLAQx196a4O96m48TKtOqMjhoJLlINQm/xPR5TZgTCrTLkjMESg2jRJYqC1UgCum4VW6XEgzDbXy7/zGRNjWxXqiFZoKE6D9Yw9UE7AWOGjuxmqZFgkkFkG2g4ujxShLvmrcO0D0v1Q5jGyXMl4WVk/ofI1xpEgoNV9oHjTaYkL6izQYqlZ3xtwk9x+xzIz00wvlbzNvW3Y+jgmtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VENqd4WcOQaiCcAQ5v7SyVZkzdQ5mJXdv/TbM520EPE=;
 b=VbA869TY74raOZ/Wa8bofkrIfPHqz6JT9R+CYth43sAyzc6QGAU0j9xy6SDMKusy6pN7JCA31hzcTys/vJYVpMs/PE2DilzH7C2oa7rce6JNyO3rgBqAafUTiXajhBWhbx1B7JMMM3Km+JMEJVqijNZbg6FuXSIq4wbNLCZys2e8X6SpV5RMN6t/sezhVlm45CSnQEt6SV9ADwcoGDJ4j387CbXESVgScJVGhDFIQ/h1inl1V4voNUsWNE3NY+UQUv0BmyVX47eFb3NGnid0Oo2pxfSI3vty6xD71MYCfUqG3ecqenQbt08zP5ovt09dWmfWabfdYFYj53x13AMGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VENqd4WcOQaiCcAQ5v7SyVZkzdQ5mJXdv/TbM520EPE=;
 b=U0Lsmst4YbZzOlVF1CxukWWIiBWzYySsCGX3p8bLndrCN+0U317o8AT34uRWb5uUlKKLaJSYj3+iOGnIGHw6c7bg8le2M7BKe7Bm5L9cVh0GvpSw9YEaiMKFktQ5JfSeJ4VFkt9oTEq8bkOORr/mECF9xkwXkVcplH8bZ833yiY=
Received: from BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::6)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 19:53:47 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::86) by BL1P222CA0001.outlook.office365.com
 (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41 via Frontend
 Transport; Thu, 8 Feb 2024 19:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 8 Feb 2024 19:53:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 13:53:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add VCN_5_0_0 firmware support
Date: Thu, 8 Feb 2024 14:53:28 -0500
Message-ID: <20240208195330.408853-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240208195330.408853-1-alexander.deucher@amd.com>
References: <20240208195330.408853-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 45febc05-1728-4d1f-9bcb-08dc28dfa9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgOQDOkjo6/RP7bQJfHS389f82UqkivGN7OJGbk7nqK9CNC2kMbII4Czju32jF+a8CQ9izwLpFVSjIDdc6/jSXsJVOvRNUQLqTetpYt7dmYwUOOBU8I4fFGNynQGjl8RrQ6cdtDu7HLEWV+xqb2r5n3ZHf0jYn+EvmHDb6jWD3Lks1xe7sEsONwVla91TbqobIuMulqhUPwznjasTQ6o9NOPBC1i7Y6b2LQRC09mzlrNsZKQ5uyWvjJKOsGMA63e1MrJueMFzaRg1B/iK6HgORq8P37mGvnL9ck8yM7PX47/l548AMuz1QZKEitQ5XFD22c3lXRh5y1T0ju+jySOd2rrMPXYDFCRE84OFcHvxFnGM7Kd2Hn5gWPoTE+K3T4LeWdc4uRQE7dPBHMxG3SDoPwKt+MV7d4E+Zo6SOm5s8elDkhWC5Qrq76W/msK2rfhi5aAXXIrof82JAI5eV6/xeFSk1UHs5Fdz3u0NIVhTYHQI0okjO5nmNPVLAIf0YTXIccFHyfO7W04YKD3sVNz/48ESiCtdwUtgz3h8P5xzaSgk+sh44dQ2gyRliJD7RirFpmNMorC+05c8oIVuRwmWlbVbw9ke50v4CCveULGTew=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(40470700004)(46966006)(36840700001)(86362001)(6666004)(26005)(2906002)(41300700001)(7696005)(1076003)(70586007)(16526019)(36756003)(82740400003)(81166007)(316002)(356005)(5660300002)(6916009)(478600001)(8676002)(8936002)(54906003)(70206006)(336012)(2616005)(426003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:53:47.0679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45febc05-1728-4d1f-9bcb-08dc28dfa9c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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

From: Sonny Jiang <sonny.jiang@amd.com>

Add VCN5_0_0 firmware support

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f300d4a4457d..eb2a88991206 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -59,6 +59,7 @@
 #define FIRMWARE_VCN4_0_3		"amdgpu/vcn_4_0_3.bin"
 #define FIRMWARE_VCN4_0_4		"amdgpu/vcn_4_0_4.bin"
 #define FIRMWARE_VCN4_0_5		"amdgpu/vcn_4_0_5.bin"
+#define FIRMWARE_VCN5_0_0		"amdgpu/vcn_5_0_0.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -82,6 +83,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_2);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_3);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_5);
+MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
-- 
2.42.0

