Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99982C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 19:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C160710E0B9;
	Thu, 23 Nov 2023 19:55:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE7710E0B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 19:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhafPaaZP4F3w7YH4Z0i65OzKZ08C4ElLClnJvf3yT0lpe0FtFRhC/SaGjLXdU+14a8+ThVRrgi2thFT6ZiVGQdJ+uHpgBhYFawsBCqvhN55khk5WcpPFQIf3uoQryDQl7K6024HxtcCFgee5LpzEJ3FpQScXvidmVyCKnJlPonxkgprdWWlkN/D3XK4PeCXETRYhIe9lNEhI6zB7s3lF+BXeVrPmeCwzFnkR61Ij25Ft8LrXeEITabC/ks3EuzEmy9BzG2fDFEMyGb/4l71n9Vsk/ztdmo2iyPQr2slAzmwrFR1vwmjcKRrpyviKHp5wHl1I0i1OxERk0dqRXQKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OfsarITpTUFpq6uKgl0aQVKVXZT9kdcealg2a0hoQE=;
 b=KT5NildBjL4sVAWenupYLpZIaZl5P84ZGjgBVB1qLWnesvdyqG4R6OXfPaPlbxnm5F94FPEFmxYRYluZDKhbGq8h+PjDA7bNajISCZ2I7hDxD4xBb28gA9PzoqOpfR5GD2hBzwLrv0lFpP3G0Mgy+9CSOUR1QFrPl7aikd88iMZhPe4pOjlIwIfkVtkxsdu08AH8aKF0gvZQan3DgQnsq+LR2DP8aLwaKtFJzDvYBQAaUSXgyM0VktS+IeLiYW+62HBKv1Wc308cTTcdaYLKbZXeHcxBHmGcP2pYefAX/WMR5YT63LOzZIdEZl1ypDoBGsUALvDBCCWgF6xh9pXt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OfsarITpTUFpq6uKgl0aQVKVXZT9kdcealg2a0hoQE=;
 b=M5QWvWS5+U9UahAY5aQjymW4dmwMeAKs458W+TyF1o0wcZr8CJRamrp7NqVWl+MsNVzVRh+hUy97ISmGHHOpKkV3gtGraNzKW9eG/7pgq/8tBwoTGcGLYQIcNmz0PQN7JKcHkI5A59uMlPcEy28EybXSVJ9hbP4np2MPce9y12Y=
Received: from BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::35)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 19:55:21 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::56) by BL1P222CA0030.outlook.office365.com
 (2603:10b6:208:2c7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 19:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 19:55:20 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 13:55:19 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable event log on MES 11
Date: Thu, 23 Nov 2023 14:55:06 -0500
Message-ID: <20231123195506.1042016-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b555cb-91f7-4f11-71ad-08dbec5e1f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWNzfcu0C0v43yiTypbjbpXkriCfVAejQlXyAKw3rD9S1QLE2THUQZDpSodYZffaqqsRijaxnScsse1YQGqmPwbAo9ieHioPQZW70WSoN/+tuM/E1n68LKFRfe+bJ4NQ31XEcMH7qSeVADZLhW2yJUGz4gCKiuQKcQyZ2NyZBAnRO4X2gnh/bMgYI69lr7XCJQPQujxmDv58N2CW4pVzxu668Rf6/uBvm2QBfJdBJdwrr3TH5++3Re+ck0jumkUgGkHjTb1F79A1TA33L2w1T3mqdjUJ9QZ/FuuqYYTVq+1aseQoz2mZppNpDthOAo214Ultgtn062R1ZcD3vsMGiEe1FtR8wQcE0PzDp9FbKcQuPZ7+yQK2B9WkkrMsaeQmbtw+d2Rp9I90Iy206uirJSszp83ORViVVXjSZw0j8Twa7lm4cHWLHyY4qyJRyOPXE2VPTugU9nsYdqP0KvoSycvRISHlcjLctTVri5bBXX7COM1NdcssJgIKHMSTYP1R1ZE9hNYCG6n6BUzgvRHzRb+FvKqM87ZD4k1L16XHy6qTcVIXWIylxbYhjDswrk2cfzzDra8rT2wWtl0zCvaj7GoHgh6N1dmDK044cm9KCbvLyLU9Yw9XiV3Hhp5Ct9I+crK5ukY3lU5/P0ajtiYFz9GYtvuZM7vsy7jB2UdDjBY3LIxYat8SL4RuFIjZ1+qHU7OrG8cvZ4uo4v1ZfR+keDT+D1bDq+Sw9ytsRqL96M5I5wzIfs9W+w7Yi/gxOTDw1dRkiCslSfy6aauVU0WdJLM7c680KT6LF3K3Oy5OOGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39850400004)(376002)(136003)(346002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(16526019)(2616005)(26005)(1076003)(356005)(81166007)(82740400003)(40460700003)(36756003)(86362001)(336012)(7696005)(5660300002)(2906002)(426003)(47076005)(6666004)(36860700001)(4326008)(316002)(8676002)(6916009)(478600001)(70586007)(70206006)(41300700001)(8936002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:55:20.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b555cb-91f7-4f11-71ad-08dbec5e1f84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable event log through the HW specific FW API

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 4dfec56e1b7f..26d71a22395d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -408,6 +408,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
+	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index b1db2b190187..1fbfd1aa987e 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -232,6 +232,7 @@ union MESAPI_SET_HW_RESOURCES {
 		};
 		uint32_t	oversubscription_timer;
 		uint64_t        doorbell_info;
+		uint64_t        event_intr_history_gpu_mc_ptr;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.34.1

