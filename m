Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577E3FED9FD
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 18:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E795610E105;
	Tue, 17 Mar 2026 18:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3h7XUHzY";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8546C10E105
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 18:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YodL5Jup6zKawnasB0HkHZb1IbIAdHlNC2ZHZbuH8HedjNtntCcOzXKzvRuA5BXrxTd2FFAyXFeLt8SnNQn4eCyVZFcKezMyS+AIxEiI5SewUH7ZYCyOmlXLm6UB2NQkvk+cBQu+3DdNyJqiBxCGcQF0CrPM9tDS85nbonJwhYNbUViA43q9MKr60MeueY2Dh6lke6zuQ7YOeTf0AjgKT0MQ+cgq9WfHeWEghO7cAqp0wDccfUyFsl5Ae9RINcX2dle+2kNRhu9wWc2ZAIh+p7tbvp/u7hFDu1ff9Z3CExFdcsQQHhBSOFFcK1TnUnsG9uMyWOCbViccSLxCIbJwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W44TUauBJcET5FPW5niusR/AZubGQ87VAzeeaPo3ruc=;
 b=bBHciFO6S8nYs9wdLDa83AarjIfE0HtM9jfUD4G7nd0MSvhJSptVqmwP6qYYnO1choY7TB+SO+ayFBb751DP+acvkpJXRNssZhPcQjc6r9q9V9ed3Xpk3jOFwYZKFGtLUj7wH8pk+SRiWNm+MSXx3YypLd+/75Jcr7ikvQfksYOtbxH80RvSF0Y8NIb3trz3qzsBW5GM0bj+rFB2waV1TczrvOcALOTkF8m1qZbjZJtY9CC6IJpMyX87XbkWSiA4/ock3he6exMVkoP6Lb36EB28iTd/G5797ljwgPR6SSsray8Tprc6ro4yszqHpbrV4wMhsLE41X2urfA7Eh9Hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W44TUauBJcET5FPW5niusR/AZubGQ87VAzeeaPo3ruc=;
 b=3h7XUHzYIVYcPq5ZsIUl3gUEvJt6dfzsDka+PCbOjRji/15OAP9FThFhsL/ghBebrWL4NHcF8a0aJ2cy+ya+MDpBc8mXZZum2/ndEPahGpwPV46hmzDUA+TnS0L8ybC7RQLXx3r7/UaVsFWI2KNMTTLqKGJs8lEM1v/7UeMkGDM=
Received: from BN0PR04CA0125.namprd04.prod.outlook.com (2603:10b6:408:ed::10)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::605) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Tue, 17 Mar
 2026 18:18:15 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::2a) by BN0PR04CA0125.outlook.office365.com
 (2603:10b6:408:ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 18:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 18:18:14 +0000
Received: from ruijing-dev0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:18:13 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <ruijing.dong@amd.com>, <leo.liu@amd.com>
Subject: [PATCH] drm/amdgpu: fix strsep() corrupting lockup_timeout module
 parameter on multi-GPU
Date: Tue, 17 Mar 2026 14:17:59 -0400
Message-ID: <20260317181759.34331-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.49.0.593.gd86a19f485
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d57e13-70d9-4928-54f2-08de84518e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lqh1cF1MJxy+HW5HBeh+KULdmsH5lIjhqZ8hhwwkl8a60caxnV8bx7qR8Z+3oqzruX6yvmwJ1B2ZkNez5hC9ydHgjNaNjjx4R+llFAprCEFGSXvpBhBfQj2ydgIhULu1sApMYO3YhVX3pczlXG14uz/wtFkxWZQMM3j7BoRFrYJICxUE52i+m8SzNnJN3j9q4us+tIS2I1rTy5MMDwhyYTSS5jGPVnEqGnCupXpqAz1mURmHKMFv/WeG3OSYHT1noy6kyr5qg9OAWxkN9akwrWuh3jvxn1F6e2UwZNfwyeWrS0y+V1cdr/FCuZw/kDFpa7QYvijlLOKfctIpLPpGML7mOL26O2Cfb9t6y7nZlylC4VOjDwYRXFWZlfS/h2I02X6kjQhvfkE52uuG3O6PrQ7eSLJBOFfiN0GXaLrJQLP2J/+Y1xiuMeG9NAOFwl0r0Eb0fEFHpIiqzceuXYqaUx9gQ4rUgMHvb2naCvNUjLwGFrLZmVDHnADEzQHuXcjHHQGYIlXYVPxZzURZZgMetWfZkDWfiHWNU++CAoOaLl8OKqFAJJdcvjUCMap++hEcaXsnG3Pdfh6DTeytqYON3/CPZq7ug07QoX846HPfspirRonHz7kdnpAzJaMaJ7ZgN7VUtHScR4RnOH2FpZIgg8KCbeETr5o3yrFpLJzr6fBr/um6Zu/ugFNYvLkqoZXtE9W6Mg/u1EA51iequCGJDY3n6N8Ks6V8ckK4ouMGReEJ1iaVV9jQ/Eqizftzb6EP+kULRxqqEqXYq+fnwFv5Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xQB84JhWIgzN6SJ8vTRvi++IZtgKXpJvXPTD1NvhPCAHh5+st5J2z/GCuBQ5xg6GMpzAysBDgARrIV4MplP627o4MiJ6wtVWmJnsrzmRNKnUbnP1qS1B8ExJlsb/cK0mFwE5y6QK04CD6x1UFvxFXRZ92rMT00zCciQhwIc20vD85U859F+pHof7UyfMJBO3f1RZkl8vUplYo5Ozhuz0YfdzKrvfdWQjfS14jH5FWtCNqiinrVffPF6OMYbOfXliS0cPH2YuSIjC+YP1Q8VMmF+039+SdCuBk/occgNE3R3R000EHjaFWoY594ChGNkoHbAWQtLoI3/5zIWhDklPApuHsNQT1K+T0mpeJVKmiqDTdJ4A8oNoPiEn2xLqtq8ZodCge60G2J+tdIR+V2FKtDoTMb7XJMqhsJOJHjxC/jgiTFFCeIoJk0MZ5sSW0D0c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:18:14.5295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d57e13-70d9-4928-54f2-08de84518e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6
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

amdgpu_device_get_job_timeout_settings() passes a pointer directly to
the global amdgpu_lockup_timeout[] buffer into strsep(). strsep()
destructively replaces delimiter characters with '\0' in-place.

On multi-GPU systems, this function is called once per device. When a
multi-value setting like "0,0,0,-1" is used, the first GPU's call
transforms the global buffer into "0\00\00\0-1". The second GPU then
sees only "0" (terminated at the first '\0'), parses a single value,
hits the single-value fallthrough (index == 1), and applies timeout=0
to all rings — causing immediate false job timeouts.

Fix this by using kstrdup() to make a local copy before calling strsep(),
so the global module parameter buffer remains intact across calls. A
separate pointer is kept to the allocation start since strsep() advances
the working pointer to NULL by the end of parsing.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dcae77b6c272..97ebcc5bb763 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3498,7 +3498,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 
 static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 {
-	char *input = amdgpu_lockup_timeout;
+	char *input, *input_copy;
 	char *timeout_setting = NULL;
 	int index = 0;
 	long timeout;
@@ -3508,14 +3508,25 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
 		adev->video_timeout = msecs_to_jiffies(2000);
 
-	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
+	if (!strnlen(amdgpu_lockup_timeout, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
 		return 0;
 
+	/*
+	 * strsep() destructively modifies its input by replacing delimiters
+	 * with '\0'. Make a local copy so the global module parameter buffer
+	 * remains intact for multi-GPU systems where this function is called
+	 * once per device.
+	 */
+	input = kstrdup(amdgpu_lockup_timeout, GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+	input_copy = input;
+
 	while ((timeout_setting = strsep(&input, ",")) &&
 	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		ret = kstrtol(timeout_setting, 0, &timeout);
 		if (ret)
-			return ret;
+			goto out_free;
 
 		if (timeout == 0) {
 			index++;
@@ -3551,6 +3562,8 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 		adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
 			adev->video_timeout = timeout;
 
+out_free:
+	kfree(input_copy);
 	return ret;
 }
 
-- 
2.49.0.593.gd86a19f485

