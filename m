Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8161CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D58010E5C8;
	Tue, 12 May 2026 15:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kUEdi6vG";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C4D10E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebrJ39o2Ly/4mA19Rm+FilPRXeXdsI7gUNEBrP30EazmGlzsBbeqhMsKSNiYM2rykNktWoAXn9SiLlgWTVDKaT0b+PbJeKMfY0Mi+Es6xfiup3/VxiGBA7TaR0l0AnNqXOG0mzRK91AuOiYzyuJeiuAQfc0Elp8HTmwyl9QNnSwqhKmv839SIBjZnQE0wsrF5bDzCS9CQmkGMBQy6jJAbA7j6aDRkypIgcmiOrSGOD6lXHyo1YOqHT0WcPzIEaV+mTEuu1m9v0ZmfyUwc4qCZ/9tt0vqTjY7vE0TAHcuKGtBMvkcL0xIp+RxZBOUrBZrNzt2/eT6ZTWXxut5iRsxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7JTPbWxteIKxhdESljzkPb3I8UI2+NM+uVKpQShzmo=;
 b=nRGqjIGbJ54MCPgHapYc6KBG95yA3VLB2h2/SQIyqFvNhA9389PYA6ClRctikPXTELky3lroTHkcvsZQAKFclbhLYL0tX3Lgl2Gm5v6VNP3hj5Ff8CX0qBOweM4lrpXAaTi1oN6AcC4sUJ3+LmRnSD7hiIMhE9czIUGAEnJNrQ/4mrMVMtGCxbVjsV6y32XT+uBA4tI0kJE//Vcp6UPJxfGqDSjn9DBhJIxg4TztJyCXvAUDgY8P/EIUBVi7v0dnhLZCkMzWIuiXboQWUSqcVe9E/tDYVQjc/WZ/kblFBJQlpBNyYiXSUPlycr9ygjl/sZ5A0MSgEUhemYFS3/2A0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7JTPbWxteIKxhdESljzkPb3I8UI2+NM+uVKpQShzmo=;
 b=kUEdi6vGNB/UeWSqTSv3DbB9p7KPe5hs1MIJCCl0x95TVtWikhL2ogZ1rlRgCC2r2Gh6bsPV5571/dFLAPeL7W/vmtvQ/GapPmI+YwpBMUNXYXEIGpFAwG7i3qGvQZQfwQE439AO4Vw/fNY12mAKrNjW0C4XQAHqGH6bb/DDafU=
Received: from BY5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:a03:1a0::29)
 by DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:06:04 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::80) by BY5PR16CA0016.outlook.office365.com
 (2603:10b6:a03:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 15:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 15:06:03 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 12 May 2026 10:06:01 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix a vulnerability of integer overflow in kfd
 debugger
Date: Tue, 12 May 2026 11:05:35 -0400
Message-ID: <20260512150535.75401-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d673de1-b142-4c4b-c76d-08deb037fc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /6SxB6eYZRtd5SmTIZmZoOle2jLmPBhT0HEqZxqqtXSerWvANe/DNcMEW0SoZdvR1txQGmwl3YPFVCtNoowsMfCXMbaVnn5Fl31q4qJaE4zLP0zcIjSYH4LAo4EUc7kyOj2dUIfyNNhnfVHWpz5Ei1apcZHRx/KClaWXlGVOXVSatjpV9hMAG/oNu7MQ2+mWLynGZwxhzvhHZ6MOKCcgB+YJu3QRi4VX3win0DfsI/3IUUIwCJhXUvuJcc50/N8kNHucAChFhhimdO8e0jlzkyPJ+c1cR8WUdVmw8XgIwcMI1MzDeVslHg2kZjFNlxXQCFn7Mo2j+U3Zo6lDChnxJRj3VrV34R0DP0CiQBL65kdKnHy3lAL/TVa8+QDT9QNvYIhWTVv6cmaodWGN4arLNUHL6bZm9sJCh4ljo0Is/iqT1Qysq8ixRDYxgCWLjis4Np6+vU1rHw3kUHyKB/x+yk+0BHAiDRJGGJWSpcKi6TC8egUdR9oilJJHXnjCKY9ebE6sjF+T7XdJ0t+nMGKtEUZxRG/CauezKOxaf5Fkipkeo3gl7i5TnuMC2aKSqrunwBfgCnLmSvMQb6TIjeay8DYx8K2p6SUvdhizfSjg4SIdO4IZALiGdCj1gO/O5yHKUBQqc/ciRg1nAsrsOqUSJ2i4RHa1EfXMOQnA8rE8mFMxccKxt3y9kgUOZqSLPg5JlURiggyWg9muSmAyPw/qxojf+ZprUbkBhbfgXdHR8SM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a8IKk9aRRI/UoCrqJlPUk3EjXsYMlZuPJydcYDnhjMxf1p/xNXCufHZoA1bcMovCOXZZ/5IMa8ddV0YQRlxCSIhVM9dDvOYHp5TPsKBW85L79gs/MUYNhAV65GmiYhKAzyYxh6jNKEytWFnhQI+Aa4Sdz9QEGeocB9Mxrj26M6hTaQQkm8AyFiH+8FX1HISpkuExT3iMMU3JCgcWYVRV7IGOI43ea18e78CkKdW+u6U8vb+p5SY4x/9MwHRCEeLyOMqH0ToPg6orBACsVhoUaNTN+ZZykjifpJVF95vfdaSDEuczHRTk3oKN1zV4iLY5SUUUOmGb+601KsfxOHoog4+p30XiXGg2SZEv8TkaHRlfRw8GJq0qvg5wl74d5LTyJsM+I+r4cVFp9SpEkxVM4IPHkSK8pxPJSYz7om51ecqKRPVVxtd8kJjC2uQIihn1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:06:03.0395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d673de1-b142-4c4b-c76d-08deb037fc0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC
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

get_queue_ids() computes array_size = num_queues * sizeof(uint32_t),
which could overflow on 32-bit size_t build. using array_size()
instead, it saturates to SIZE_MAX on overflow.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2e6923528342..b34f29501ff8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3468,12 +3468,14 @@ static void copy_context_work_handler(struct work_struct *work)
 
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
-	size_t array_size = num_queues * sizeof(uint32_t);
-
 	if (!usr_queue_id_array)
 		return NULL;
 
-	return memdup_user(usr_queue_id_array, array_size);
+	if (num_queues > KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user(usr_queue_id_array,
+			   array_size(num_queues, sizeof(uint32_t)));
 }
 
 int resume_queues(struct kfd_process *p,
-- 
2.34.1

