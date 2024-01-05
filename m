Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A07C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 10:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0105510E59A;
	Fri,  5 Jan 2024 10:52:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5037D10E59A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 10:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNqMosqZTNkrMvaBRKZH4T4kiz1SgoFoZN6FrsVU+fkgDZCsZ8mUNYzxhlqBdcvMnB0rYd6MDiUASCKsijiBc98iDJRs+4zFsCivwE4LuKaxO8EyyxG/lyX2evhBKcd+n4WPCswwMWimMYAUNim0eRLm/l6lkKIoE7w/oDYUlAQQ39Iw+GG+BwpPXJQINJ8hohH1c1R73Xk82YKG+pHsRxyHQYx9klVM1Df4nWTkzY2pO+LuC/ero0cGw4tgDEngggNe3HtfjeeXl3zURCGmg9f9L8HjcJUIsirZ10W6AhaMpCv+xN7flvPK/jtw19imkw2Rax08nlQPlmhCa8bTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpek4ayoeIlMONekEyujg6vpfXFYd28dtCXCmXd+YKo=;
 b=jLgwMXhZgUs2ryz+QZkTo+/9bzjIpy+DN3YPIrjWjKTjDnG5vrMRs9EGB8dh/PgoGHUu6KmjZe9q9rfszn9U9FE6oeEQoU7zR1WrTD2Qz+KcWhMM6JqRirngnq31KZH3k1IIRRh2yCNkPK6ApVEFbQgQTCk0dCvQ7BZ/31qZqHp7wqMB1nDHQVoe0R3tCPD1PKcU4Fq3c5UQzrlmjeKAPnP9HPMUcd2AG8CPjYBRm72Z/MukuhV3x16uMDLz8WiHF8IrbVJJXlsdOeCgg4fp3zSwy0uv4edAdYp79Vy+G14uAO4x3/SbfMWp8+GwPujWEjDHQYlnTxxZX2IpRcps3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpek4ayoeIlMONekEyujg6vpfXFYd28dtCXCmXd+YKo=;
 b=iCewiPtEUrxnm/7wC/qfxnt6AJGAaAm3xE3pcWxB63nI4reTHVxG28yMJ4ExPi4LwoF2lzip/y8Qb9In2MYHd13xjsrIgp5yiPtPyXCXX+F2rM+U1cVexRPRKITV8D5avFvSG+e6zbfiKf+Tb/TYUscDExlFwYDb9WETGCFH2y0=
Received: from MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) by
 PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.17; Fri, 5 Jan 2024 10:52:16 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::9c) by MN2PR01CA0024.outlook.office365.com
 (2603:10b6:208:10c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Fri, 5 Jan 2024 10:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 10:52:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 5 Jan 2024 04:52:12 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdkfd: Fix variable dereferenced before NULL check in
 'kfd_dbg_trap_device_snapshot()'
Date: Fri, 5 Jan 2024 16:22:02 +0530
Message-ID: <20240105105203.2776015-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH0PR12MB5466:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ecff5c-a8f9-4961-f73e-08dc0ddc61aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYD2tPs5w/zTolmlAwjfvqIlQvbtKMmz6ViHtF/P3U46xC+nJ94Kx3qtJRR2pxNnNmENUgS5KzhxRtGWnR1SNNGpekzum/r7yahBzIdQI7u9Ss/Had6XXh6yAjTY2MfnisUgP/ZzT6j0OtS2CRUYGrXt7onVBveIxOmUxKWxyXlvepllgapuFjeyHcbWQjjVKj2zuUHXj/p6BDy0aeh4zrfcC2znrDnZrrOxeZag9yTPeKmNXExw3YaWwYo13OJ7GGMYmxg1oIi6pKTeb6N9K0Z2E1cXsSDlQFYKor9Y36DK4fB+wMQlVJh+3hszT2NPINQ1zkOnJ7pOmWFKwkBgWtuHc5oIHJUgcloOroLKkmWc9n8YOXwuzhvWYw2/wm0XsV5opa1MBjNqy7ZJ/MuAFNYtSDXevDI2PVUTVpN0P8jwxlo8YsHeI9dO0bwKP/eFXbhn62gVW4r+0F6UsN+vMD0F+pw58t6q//iJduLjP8h+HcthvxG7NleYn65vTajtgoulFL/6LbNMd0zggJe8BVqEHpZVIKf2pYbx5mDZvRud8j6x4v4CLuTXTADUQcFq/nSVR9wVfQnMZNqFX0MMOewWIw28qIfv/W564lHw8BYRU0QseHBdwKO/hdPlnuOsyJ4NIWufkuCGomLYrA8m1erVxthbRWbCoZZWhGaMFYm+AncN2GHCnz+5LLXpJFz+itmrin6QsKerXRyXxJzNDIJuunuHm43x+wyOlN7kcZ+thMrJNOjSSoAFfheKP54pdAtj5OkooU9kiRneRGfdpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(426003)(26005)(336012)(1076003)(2616005)(478600001)(6666004)(7696005)(47076005)(83380400001)(66574015)(16526019)(2906002)(5660300002)(41300700001)(54906003)(70586007)(70206006)(316002)(110136005)(8936002)(8676002)(44832011)(4326008)(6636002)(36860700001)(82740400003)(36756003)(86362001)(81166007)(356005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 10:52:16.1859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ecff5c-a8f9-4961-f73e-08dc0ddc61aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c:1024 kfd_dbg_trap_device_snapshot() warn: variable dereferenced before check 'entry_size' (see line 1021)

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 9ec750666382..00fec106cd3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1018,12 +1018,14 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 		uint32_t *entry_size)
 {
 	struct kfd_dbg_device_info_entry device_info;
-	uint32_t tmp_entry_size = *entry_size, tmp_num_devices;
+	u32 tmp_entry_size, tmp_num_devices;
 	int i, r = 0;
 
 	if (!(target && user_info && number_of_device_infos && entry_size))
 		return -EINVAL;
 
+	tmp_entry_size = *entry_size;
+
 	tmp_num_devices = min_t(size_t, *number_of_device_infos, target->n_pdds);
 	*number_of_device_infos = target->n_pdds;
 	*entry_size = min_t(size_t, *entry_size, sizeof(device_info));
-- 
2.34.1

