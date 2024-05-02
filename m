Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEBAC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 20:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1612610EDAC;
	Thu,  2 May 2024 20:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mbr++6bt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3817010EDAC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 20:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwLmU6cac2mORjZK/eUJARtvxSVbMLuEcf2217GOR+BZALMP2jM/x8aEcIUfDbARIQNUclZOuNncpigW5q8cZkY6J5pNlJjAMfz2dH5Moxzl9N0zkGxAL2LpJLt0utiQz+6fuTCboWUb3hfmxXFZT7+itOdXlDWo84yaP06kgcoP475nnbG9VrLA2tj2VI5rAw5wo3KHlaKmc6haz9cX2L3PYaAPORbAi36fJwE4OafSxWyiD2RqKNcCeW+PCmS+JBx49XJPLN6GiCQOnZ8BCdGbVHfeIG2h/4tLfO+/QW8vG5A96aelDlrerGKCbqX1zdDaajuDQsU+IW+prnQxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtHVLGu8Ud2pE/5iI11PBp0NqAlgHSwpkOGZPS52kNE=;
 b=S530AE9o7rM1HZbVuRfcMh5QXV8cPwcHeCVXeqI6peX6SITkPFrevR+ImOCnCMQTwbCrZ+NaF0XrUkMriDuHWqwSkBWLYMfge+ZWBNkIRjeAxrFt28JHN3K+HaNL/eIbswMYHj1DP2fdOMIRZ2YBrTRNsYlZ3MghGf2s+vEMQIzjEbgCpF/OCK7DBQhufod4f+4QCOiuNUVKC/05PmQqfX4dS/054frv2/QMtCi32eAzS8JMjV2n7vncmSD9E5Z8eYRmIJqc3NGHjGA5KT+H0SHsBYDpkTQQJyz9s8NiUIMW2D5vPaPg2/HpojhNZ/chu+QxBVAu+D5iySNZ57+4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtHVLGu8Ud2pE/5iI11PBp0NqAlgHSwpkOGZPS52kNE=;
 b=mbr++6btZSMhJV7xt4qvs4MUtXF3uG0PqGReirD5bb8pWGXRw9RYnr3Wkhnuwm8LWmETN0DXoAEmcfDmM/NTUOLk8Kfn495ek0G4fDYXWWuMrKPrUb508W+/QWPVtZmfhPVkHKHxZVkxc1lSa+2lSpbhoozjDOqsQqY1meN2skg=
Received: from PH7PR13CA0005.namprd13.prod.outlook.com (2603:10b6:510:174::8)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 20:22:34 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::a7) by PH7PR13CA0005.outlook.office365.com
 (2603:10b6:510:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 20:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 20:22:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 15:22:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: update documentation on memory clock
Date: Thu, 2 May 2024 16:22:16 -0400
Message-ID: <20240502202216.3385044-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e16fa9-39ad-475e-2788-08dc6ae599c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bxWCFz8/dH18Up9gwuAdCFfS3ZpCryy1NNTnWH2ripADAQGHHyO0XYbxoJX+?=
 =?us-ascii?Q?CiEzovn250qzSeQHvnor8BKmjGzxXXxkYZTDAIbtQD/HgqcU1BpZzG0sRJDJ?=
 =?us-ascii?Q?xzw3S7gem0/YgBgfa1h9s6J30Ny+0nuuMbbDw9zTIpwQWJNNqwyPAR3b5Q8L?=
 =?us-ascii?Q?2XdmmP+MeUD/YUF8lFSj3MBCSj6SeHvcNo3KPLoVyS0G0KFpQJAayBPzh4xy?=
 =?us-ascii?Q?A/df/4WZs3/SS8f9h3SyY6Y2v6EtWJx55KB+PIv+NpO9DBl91EcGy0/TZwNN?=
 =?us-ascii?Q?1Cwdb3Rsx8I8LWeFxFMUrSyPeBlz9hfENSJR5f2yDNXxBouysIY4pQ3WYMya?=
 =?us-ascii?Q?yf1xuOh+z5Oyf4rLA27xUijSNQf6NuFd6v/45quapYi4aBVZSXxYqknhVsq/?=
 =?us-ascii?Q?LIhG4lx2v6oYYhoyqpbJXnSd7epOwHkMLv6aNBX35CAwW/JF7Ihqek7I8gNs?=
 =?us-ascii?Q?n7D1ZvMMDfEEIKzpkAIfVYJ5WigmyCbQz8h7ZfbMu/813BR29fcdtGk7MX4e?=
 =?us-ascii?Q?PmNp32nhv59gOl8QLH5qqCm41wxly4J3FB4wa8MrwzQj13yiumUHmgMdZpwz?=
 =?us-ascii?Q?bfa3mz03/HTtxneMZ/KpWm2gifx9QtgS6egtqutLWjeXNTFxB2IOsiyTS7Wi?=
 =?us-ascii?Q?9bbGcLGlfisZRyzDu6Xk4Z/5uZHLPIgltkIJQOsXWyfXnJ/uAWVbOYpWak2I?=
 =?us-ascii?Q?HyCy3EHR8khlqp2ShJbXFpFpAVjpCAg/IT5d94MgqEP/Xdp2W5jRVmYIHscP?=
 =?us-ascii?Q?QQKbhErXskRzKSFgFrA+UbQfXaHbT7aVJVjSdatjf2VMcxYptD/n99xUQfSL?=
 =?us-ascii?Q?ir/hrXRwU1akS7ESWNRLyXqDVNGpG7fYIFrNEA9Xu4zdlR/oJCKFY0xNiAcN?=
 =?us-ascii?Q?RPsescOMWvfZnDFMqjLpTUapvJU320CMsy4//RGpMZK7Boxni1jjnEGrPeWC?=
 =?us-ascii?Q?NHxsxSCq2CMRRi50ZYV7DkB49tYu+ejLPxyEyyzJFbMSkS24Nm+mi5d9OGv2?=
 =?us-ascii?Q?+hAFw7Rt4WM1FA0MdvRXqkC73iARkXJ54oFp0gVfTw1mjr7uoVvKkx91MAHk?=
 =?us-ascii?Q?ZRAk4dwKj1z8QNPbZXeGhR9PqaaOZKJIshE6h+KA0ygjEXL5uzwZrOUwhH4K?=
 =?us-ascii?Q?MnBPmtpis047k4kmlrzp42jBdY4cEfR9OeeQ09poGN63yG+EmBhw+H3Z0ZD0?=
 =?us-ascii?Q?wF0MRtQWsxIQrfPbd0mLvAYXAh+KwizsGC6W844sn1qGqG5bSIHr91d6/Y7l?=
 =?us-ascii?Q?op7eFEJqaWIDYTtSj3mCa5kaXURoKDG4oIUCqUGH5Q2sVBvoq0fbMDiQXWE8?=
 =?us-ascii?Q?uXJhBMXaZVQ/8SS0pckCaz6iRGerLDlewDT6tqTanlHO507CXmPbzP7v1qQM?=
 =?us-ascii?Q?dt4gKlO1AyDW2ejjBAQm86y25K9f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 20:22:33.9098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e16fa9-39ad-475e-2788-08dc6ae599c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
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

Update documentation for RDNA3 dGPUs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ec9058c80647a..9ad114e695e5d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -610,12 +610,18 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *
  * Clock conversion (Mhz):
  *
+ * Pre-RDNA3 GPUs:
+ *
  * HBM: effective_memory_clock = memory_controller_clock * 1
  *
  * G5: effective_memory_clock = memory_controller_clock * 1
  *
  * G6: effective_memory_clock = memory_controller_clock * 2
  *
+ * RDNA3 GPUs:
+ *
+ * G6: effective_memory_clock = memory_controller_clock * 1
+ *
  * DRAM data rate (MT/s):
  *
  * HBM: effective_memory_clock * 2 = data_rate
-- 
2.44.0

