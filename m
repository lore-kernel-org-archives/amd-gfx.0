Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A75C54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 08:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC6E10F8CC;
	Fri,  8 Mar 2024 08:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D+xlv91t";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1192511368A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 08:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rn02AFrH0RO1ZOYa6tY/sl7pWbt8iC9YKqWZSE5CTbyrxe5ZlwNEXN/bHr3hGhOWHd+l9wEBjQKNoNSckWiF7/jaGGdA9262qXOcysQD9+nspk6ANKgpKcwxghhjv699LmZFwcsu6w276Cf4h/7zKtsDfsYQHhhBVJYrom1VjDmyCv7GcBJSM/jTlkQ1g/73qqyy7lb0KmKnf12ciTDWntbfNoSpGi8XDfhzpOBUcjr+2Eu4DzgyjwW6942lDkwzUWt27kKSTamf8XCGAC+8o+7Ut5D+fMGIZpYq8Ylyh5hT+McrsGjsYPYO2NtgLATJHIIt7+EDLCX9auE2MhxHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9h+CTUUODOgH+xLz1L4PMdAAlQgnDjxkglI5C+4Ix8=;
 b=d4vfpiAf6QwAKGDplTp9P8Io7iP2V/A1U8kStJbJ9z1VUliSk4/pw2BMF7DIcVCmH4UHq5nz2SJ/FAdh3bm/Sz/48E1/0xdiqcGxXJNkh3rV2A/u2UEXqYplvaPRbX+zzm9neAeCd8R9uqzM/phXghliODjdf9JMszPVsf6uVWVdicum/aTHehO8hLYJg3dPXKnLHODnYi9LNsqBG0M3rHD0i5MrXda8HTEf6LAsSFWhX/GrvMcNKDr8Oi40yNoU/1wFMYWIZy5LvTZXYMoB0HV2WnoSUzbt+2aIrYHWqaG/9wNgZQcMjDIaAwxEbouxqX+hwZkQ+UB5A8noQjER2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9h+CTUUODOgH+xLz1L4PMdAAlQgnDjxkglI5C+4Ix8=;
 b=D+xlv91tuePOFN2YQPsSjt2s0gFILXI/f9oDSKn/DvJYgtFJqUDcA6VxdYTszCFBq7O+eK1wx8aY0Pfqo816SUmL/j8/3TAuqSSPCgSsIAEw4xyk9cyVj8efoj8iG3vx9s5/qF6AriPCvYJYBMhkmaOxZFFE0/QyljouXQJXuKM=
Received: from MW4PR04CA0348.namprd04.prod.outlook.com (2603:10b6:303:8a::23)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 08:54:21 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::1a) by MW4PR04CA0348.outlook.office365.com
 (2603:10b6:303:8a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Fri, 8 Mar 2024 08:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:54:20 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 02:54:18 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH v2 2/7] drm/amdgpu: add VCN sensor value for SMU 13.0.4
Date: Fri, 8 Mar 2024 16:53:55 +0800
Message-ID: <20240308085400.385793-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308085400.385793-1-Xiaojian.Du@amd.com>
References: <20240308085400.385793-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 103c41fa-9019-420b-7cf5-08dc3f4d588c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ks6VYmOz1bpZdf8FhWvRZk+wXDqZ8cf1YLM5dteBhQgGlDjwwBfmsqrdZB1tCgDf+siOnAm9d8SuIYzXkXAPiPYu6QBGcC0at6Vg1kYffV9LrZpcf41vFibGFYUWdOwcThFlPGjwW4vkZd5gefWBKyR91Om5RCebQMLdF2calR8nEwQYnz0QayEr+nuyfRnsPSoBxS8PskjBGQmivzMhaneyUnnIaqF4TN7TC2jnMy0fOBoKX7zVCXI9gl3AVJE8zMYVSYMsZIO5vT2QqoQ4DUuBzMDXU4RLMHWER3MDIMRu3fSmt9ZQDREc/vBC00h3HN33ibppan4FYvmC5dBX2wcUKKtzKEXsUp2mDa1aIaoLIw6TZ90iURsLWnqpE38yTKQRb5BPBUB6TR2ioNiSoRA3kV0QjPQlU4C6hOLqQr7MPBrkxIgxyadF4b9WkqrthUb4IzbHPzCCaP9o+/2P92H0l113PxOJ5TpLfLCn/F7dGhERnRmLMGP/KYXlmutLaDQIyE4pWBBUApElfOTwn1Xz1Wie6dmL4U4tN+6S2Isi2oOzvmrBpyV35YQ2AO4UqFow0QMTUrJgNKUiXTCYc3Ha3ZD1ojHFGyndF4x0Jd5W9Elrdrr3qjE3x9caTa05IO7i+ga84Qy+0JZdiO8JcFi7GuCJrHkSpBnhIQjlEFYLZF8ZH1utLQXUXi9vphAIX8/9drD56le4Z25v3DMJmnTVhq3NqO7NrTo1XL4B1kCNoScBQlfKCPoCQoQJ2hSE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:54:20.8995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103c41fa-9019-420b-7cf5-08dc3f4d588c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107
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

This will add VCN sensor value for SMU 13.0.4.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index bb98156b2fa1..e8119918ef6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -318,7 +318,7 @@ static int smu_v13_0_4_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->GfxActivity / 100;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->UvdActivity;
+		*value = metrics->UvdActivity / 100;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 		*value = (metrics->AverageSocketPower << 8) / 1000;
@@ -572,6 +572,12 @@ static int smu_v13_0_4_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = smu_v13_0_4_get_smu_metrics_data(smu,
+							METRICS_AVERAGE_VCNACTIVITY,
+							(uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v13_0_4_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
-- 
2.34.1

