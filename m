Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2500FCD0C4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 13:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758AC10E829;
	Wed, 18 Mar 2026 13:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVxBz+rG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275D910E829
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 13:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcrQFVRjcNoF/t5OrNf3QFsZUuvhb8f/3CKrxFpHzr+InuFAnlVfqzHb4ETqjoBqvyXY/Fae2zW13+x8xmu3SBIUBfZG5muYGwhAJoXVdm0C7mB7RQLaNG4fP9cWEAQRWgCbbzcsR9hA7Y1Y+VTqq9HcF3l2+1zmt2A868DAUKd4fZphO9geKNSzR70v3d9qRk42zgo4W/vXGaSWMRoTIKHJAT2MRs2E6Ir4FKNIVgDpyEAgpggUV5kU8eVRgA2PWvDoKHHviLYB6bfZqzPZ4u0BFms6wVSNbZGmEXLcMgpmjBS6RhdrCGQfDRiF6jX+bFUEfA59/+Ngb2A921LhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTfF+slcE4NpqQYQYk3ZfNef5fjBcC/fiP18zWdOolE=;
 b=p0C4QROlTPUgv8mzzvkoOLQphab2QcnJP2VVXbzvpScUHGcMYE9kqdwqZbhIpo93AwmD7gJk6LyKnj9KxuZHSx5XoQFkj5Fu0KXY82iWR8WhPntXTC5YEI6K2l33yX9RSHRK7LdW7mtOWbDqCW37noZp1Czt2YbbPFXvQlKSELbSmmj99p4O1t2S4QJmGIcnymS8wFqNVr9VIS8iJnRf5rvdNFaGwbuFZVJpUf8H2aO2MRXn52GG8/lOnZ8yj8z90oEtFy73luECBD5nckIxZqx621kxJp8wSbYGQQXoul4oJ6C/9JecBkYug/5oKbAKgqqDLu3thxGeJimDiOyeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTfF+slcE4NpqQYQYk3ZfNef5fjBcC/fiP18zWdOolE=;
 b=BVxBz+rGPJ+FjhpvDp0CmBhnnBcg1CbiO8AFbgPHd8HxC3PZyP0MKcSoo8fKzj3QY/GOjbal5H3D4WWDe9uEhjn9si+p4lzqzF6YYY0P3mKaAK+VMdu+QP0g/mqbCbZncx3ZqZfrPQwrSvFWW5K6WEW+8ZkX97pWPTrvD06bTnQ=
Received: from DM6PR11CA0062.namprd11.prod.outlook.com (2603:10b6:5:14c::39)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 13:32:03 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::28) by DM6PR11CA0062.outlook.office365.com
 (2603:10b6:5:14c::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 13:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 13:32:03 +0000
Received: from ruijing-dev0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 08:32:02 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <ruijing.dong@amd.com>, <leo.liu@amd.com>
Subject: [PATCH v3] drm/amdgpu: fix strsep() corrupting lockup_timeout on
 multi-GPU (v3)
Date: Wed, 18 Mar 2026 09:31:52 -0400
Message-ID: <20260318133152.18900-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.49.0.593.gd86a19f485
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb7de11-a2cd-47ae-836f-08de84f2bdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: lIHwspG1LC42IIFE34QWTqHu/OMPo+xosH8XlEo+0Ww89B+UXN3xEThhyzwcrlSdKLmZU+If2M/bemS8Lv/X6vGyM+UIB+93eyiVdEZeDtEGCSIm7Qu8ehcKpTkg8iVT0+rvcL3KfKe946s8YKa0rtKd+fYL9HXiCWK8/XoO9MheRjr+NcU/wr1RdwlBeufu8Kk5eVvdwzKsaynSSSEZOxeZZQHr1clUurO4lxULvc5+CtmxcbrFda1nIpIVlBaMoBbTlWXJl6JVKSvS29yyDrEkHqSttPH5CF+rlAgIv1T4FQ7V+a0nHWmbh1Uv1+R7xElhiSgKYtENCo6yy3enHj+kxCzZSSzSc9bEs6IEUYcwB8PrHCHb1nCih09Oxx8WSGqZgdfHhUYoG7HeJwHcGUfmLeBYZgPJybelFr+XcyPFYwth6ABIDLB2LET7H2+ElxvMUOeDJhKvswGY8SU/Zxl/mdhFwWtI184W0eBgnnrgbxdRtz9TAOynBgc5W4OYRdo7Rk6eJK2aoOq96YN4Whdmt1MtkxiycQ8xfhf8jKnslPrg7o5qQ7S5eIztHX0HYctH+BCbSrl9POjMc+dx7xB4sb/3bmTliLQVyzQSy4faLXocJtebhkSyeqbICaw1EsGEMeXDpGyjmnUya3a3WcqYRIxan2MEEuGsOo7eF+6YTjeFs/OgglZt1asMh9jV0QyqFxIehRcGKmYtNYB5+FQjTJAZZ5jD7HB5pI0gNBsd8Mrl9134Zhf58+gcjrJDZGiUctwEJ6EgnQV+R69NEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zGY2k+eP4t6nzq4ZRoFXBY0uzgHqtmnmuDZjjhz3IJ1WXfm0rp1bmsGx0c37kkDmavceOsXHywKjbtFVe6RdbZfXGGFnL35QLhzGQfGMVUCX3oBF8567aBtDWNQl1yJDcMrHxor70DA9r16LBb5Wk5YbsHbsdOE87kk+LO4U6pwfzonDe6og/olyI6LpXSi2u8gPh7ztqt7tsA6kpARyJWna985vH3Wbi/r4rxRejjH9UgrhmGgvoZ9ExW1hxFGYCwSATtrgXbUJEsbfw0G2SqSHdtJ3cAkLpIvKdFnnNmyGI+mSdw900ql7yJosy/scPfl0pAUeh2pdnDbC17Y/FjnRCRk1a3KkLboHQ2OJPBa5i6KYRObQP2qMba5j/GwglTECd1BZjKZQiRPHWBWNdogVEQzgrkD+OJFjLNnx3AE8Smmw6TpxVys6BrjwT8br
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:32:03.4142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb7de11-a2cd-47ae-836f-08de84f2bdce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946
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

amdgpu_device_get_job_timeout_settings() passes a pointer directly
to the global amdgpu_lockup_timeout[] buffer into strsep().
strsep() destructively replaces delimiter characters with '\0'
in-place.

On multi-GPU systems, this function is called once per device.
When a multi-value setting like "0,0,0,-1" is used, the first
GPU's call transforms the global buffer into "0\00\00\0-1". The
second GPU then sees only "0" (terminated at the first '\0'),
parses a single value, hits the single-value fallthrough
(index == 1), and applies timeout=0 to all rings — causing
immediate false job timeouts.

Fix this by copying into a stack-local array before calling
strsep(), so the global module parameter buffer remains intact
across calls. The buffer is AMDGPU_MAX_TIMEOUT_PARAM_LENGTH
(256) bytes, which is safe for the stack.

v2: wrap commit message to 72 columns, add Assisted-by tag.
v3: use stack array with strscpy() instead of kstrdup()/kfree()
    to avoid unnecessary heap allocation (Christian).

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dcae77b6c272..fbe553c38583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3498,7 +3498,8 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 
 static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 {
-	char *input = amdgpu_lockup_timeout;
+	char buf[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
+	char *input = buf;
 	char *timeout_setting = NULL;
 	int index = 0;
 	long timeout;
@@ -3508,9 +3509,17 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
 		adev->video_timeout = msecs_to_jiffies(2000);
 
-	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
+	if (!strnlen(amdgpu_lockup_timeout, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
 		return 0;
 
+	/*
+	 * strsep() destructively modifies its input by replacing delimiters
+	 * with '\0'. Use a stack copy so the global module parameter buffer
+	 * remains intact for multi-GPU systems where this function is called
+	 * once per device.
+	 */
+	strscpy(buf, amdgpu_lockup_timeout, sizeof(buf));
+
 	while ((timeout_setting = strsep(&input, ",")) &&
 	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		ret = kstrtol(timeout_setting, 0, &timeout);
-- 
2.49.0.593.gd86a19f485

