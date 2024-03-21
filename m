Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7404BC54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 05:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BD110F970;
	Thu, 21 Mar 2024 05:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xobmZ8oE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C4C10F86D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 05:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkQS7/wlXJesME+BwZcXJQsOnAzg/ALkBgrOWBm3u6l7UgVJDzrQ/Pvxa4cKdGI36rQp8uWdBxMIe9CN5nMLb371Y3sDDfPnZDZF38MCqGpiB3vndAy+TcQq+547RrPpaYsy0BIL0MTflBhiEe+woriOLqhwU3sOJrcO3ozgq9i7oNUYyn2DCa6/vkyQPoVitV/RSeOQOJQJWK3ZReVowvvvGy/zZTdfVoGGkRKOY2ukEzlJqSaTCrdfStmqCT6STqsog/CIBoTJRxqfdpISAnVkOAeAF324zzb2SryqFDuiLqPvC4NK4Hi6O/N2V3Qb3zvDAaQCaJtWK4K1s/tEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8S8oXscxF1BpsFQ+urMQQGZRSo9jj6OieJVJih0C0o=;
 b=bbphiVee1ZnMClN3T7YWy81GEEgkPv0+SHQYmTEcqQzbS5Q+EoHFusHEjdUNBkcKkVlzUKQLztVaAy0xO4QZOp7JK9h0H1DR7U/9VjflP9hjK760YWHyNoqRi7SEGHnxU8YkgqZy9SZNYUCOZ/B4XeJwa0udvUQB0F5y6i98p9w1PJkcYMKPmO1yOiQUzgjGqI09WdHmmEkPr6ZwrOL4QsUj4oBmJjsZXdu0OwJzMf3wPNZd0KWO6l7IlyKrTtvT3TKa3fU8E1VPpq2j9ukE6bbcuRFhhpQOYO4aXs04T+T0b6cD5ZUQsqjB2QlLtTjjTFDk+zUUFMQfb0rlIA7wkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8S8oXscxF1BpsFQ+urMQQGZRSo9jj6OieJVJih0C0o=;
 b=xobmZ8oEfn1llgHmTNJOs1LssuGrgMzP3ARR7rv7KzlXWdPA0DAFUdd0CDnZ6zVAVlcDOqD0mYzYcyT7sktzRzZSdYhaKp7X+hjujKYjKVFgiiep5MQeCDMyRo8+9TKGNKcwBE7wFlcT80zuFGYU/IZLKA7eGLAvlpKr2S2F/mg=
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 05:47:05 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::dc) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 21 Mar 2024 05:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 05:47:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 00:47:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix 'fw_name' buffer size to prevent truncations
 in amdgpu_mes_init_microcode
Date: Thu, 21 Mar 2024 11:16:47 +0530
Message-ID: <20240321054647.3625987-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: ca59b48d-86ea-42e4-99a4-08dc496a56f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDOR61aI+Dg/57dcTXAhH8P/9BU+ysapOfM6phBpm26FaNLFR73aoyYADkDl9qdceO3SoOGAcND7rsNELOxd1ePSRBxN3l7q0+y/+CdLrtmNluUzTkUCC37XeIkeRkRciZun7Q3sJpDK0v/S8zgpZci3466oeemM+3QliX6ncwhrn7DhuhxZpSOo57zYSW24ZPTg2EAD5A2kUjbJievLVfKJpq50oOXx7LLjHH1dVTdJRGimrAKTfP0O+kq/xvyviGjt0DZ7dq7VGvTtFIfzjjl99Qpi4U1bT7DcBYIaHsX5jLHSaDR9+TQ16HNa6qVjOOUySLJ7VGN35P4EU+ZVbVkOoFQdBugl2XJskRSDavwyq//uS9yz+GHvRCFMVXHj9pOzwiFN0hnx7//wnVPAToYn6HtSpMBRAv8xkYHHdPoPSLXPpPO/G4fkZXGI4MwmKCLWEm8IKcfjRp18PP9t7GWEHkXdihMC5oJGuAHcp8R5aNQKIqDW6pnsqvFI7qFPQEXZAl4Vfq1UCFh0xYQ5Ej2T5qD1p2jpZB6vQfwEQCMZWXyYoP9OsZ68yChgJ0Ntl90g9yd/d3f2vDzI5DFJKvWDfWlJv5OiS4ouYpUXvf+l0HG2mZkMjVLIqtUoCfV6iM/nPn868xv2hrj2fobx/pZ8BCpaZLCxYTQwaVkGkprmY/LKu/bIzO5FmCjrTUfPzFAFhGd7+Y/GPN8wSTfflI8g5Cun2f0wzhFl31WlrA508Mb8g73s12+rFcA2N1Ay
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 05:47:05.3324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca59b48d-86ea-42e4-99a4-08dc496a56f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

The snprintf function is used to write a formatted string into fw_name.
The format of the string is "amdgpu/%s_mes%s.bin", where %s is replaced
by the string in ucode_prefix and the second %s is replaced by either
"_2" or "1" depending on the condition pipe == AMDGPU_MES_SCHED_PIPE.

The length of the string "amdgpu/%s_mes%s.bin" is 16 characters plus the
length of ucode_prefix and the length of the string "_2" or "1". The
size of ucode_prefix is 30, so the maximum length of ucode_prefix is 29
characters (since one character is needed for the null terminator).
Therefore, the maximum possible length of the string written into
fw_name is 16 + 29 + 2 = 47 characters.

The size of fw_name is 40, so if the length of the string written into
fw_name is more than 39 characters (since one character is needed for
the null terminator), it will be truncated by the snprintf function, and
thus warnings will be seen.

By increasing the size of fw_name to 50, we ensure that fw_name is
large enough to hold the maximum possible length of the string, so the
snprintf function will not truncate the output.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function ‘amdgpu_mes_init_microcode’:
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1482:66: warning: ‘%s’ directive output may be truncated writing up to 1 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
 1482 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
      |                                                                  ^~
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1482:17: note: ‘snprintf’ output between 16 and 46 bytes into a destination of size 40
 1482 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1483 |                          ucode_prefix,
      |                          ~~~~~~~~~~~~~
 1484 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1477:66: warning: ‘%s’ directive output may be truncated writing 1 byte into a region of size between 0 and 29 [-Wformat-truncation=]
 1477 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
      |                                                                  ^~
 1478 |                          ucode_prefix,
 1479 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
      |                                                                 ~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1477:17: note: ‘snprintf’ output between 17 and 46 bytes into a destination of size 40
 1477 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1478 |                          ucode_prefix,
      |                          ~~~~~~~~~~~~~
 1479 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1477:66: warning: ‘%s’ directive output may be truncated writing 2 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
 1477 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
      |                                                                  ^~
 1478 |                          ucode_prefix,
 1479 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
      |                                                          ~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1477:17: note: ‘snprintf’ output between 18 and 47 bytes into a destination of size 40
 1477 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1478 |                          ucode_prefix,
      |                          ~~~~~~~~~~~~~
 1479 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1489:62: warning: ‘_mes.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
 1489 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
      |                                                              ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1489:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
 1489 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1490 |                          ucode_prefix);
      |                          ~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bc8906403270..78dfd027dc99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1467,7 +1467,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	const struct mes_firmware_header_v1_0 *mes_hdr;
 	struct amdgpu_firmware_info *info;
 	char ucode_prefix[30];
-	char fw_name[40];
+	char fw_name[50];
 	bool need_retry = false;
 	int r;
 
-- 
2.34.1

