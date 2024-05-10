Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD8C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC7010E10B;
	Fri, 10 May 2024 02:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sZGtBL+L";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338CF10E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYWXE7xz3L6kZCDdC88Ao+nsHwwGvKnzTdSxIMSfDkeWMuuWVs6rm4SY/3YKNpnVEkWGmRUI2eFfb/OnQhoubOeTarl6SI049lNIYljY3OmaCSrD+rPTHrMqnjB2Fw4OmqneQoAMHrwB/QFhpWXlb1eLdLL2rU0Ds5lZOm7qzOdTHbFrYC4QpK1oQgHCQ+J6uRYwKYAhjLAmho3LWpjpcegOjOOkJvB9Fl1DifYIgxYCjEKwr6llNfloAZL1xrEhAvmTKwVJ0qnNjSY32NdyzVaXf3CwuSoK7x8qYugYbbO+Fvdlx8nZzNlQQcFb7508W9Q+g/EteH/AsxRQjhxIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPxzUScvKUwQUtvjD51rih786zFZe6Q4D+BHf2m1R3g=;
 b=c9EkZDkouTbf5NASdik5NKTxhDcN0rDJ0ePyO6xyVXN4rz1NgurdrmhrDK4WHATdw8yhpKmmYmuzi+yzGMl4NeL2/lB5Qv0Sc22pBHHkni81x8evusXcIhMJr6qr8c0XURnvUuTruZGjWWytAV3Kux4ol191ln3FDCXXptsqIRjCD7QbqYtiZFXwEReY9u/qwf34lYclxc0/lTcfve+G4OUy2D3qPaphxCi/kX4wl7IgBw4NU4XnHecbJ4inBzuqRlBjh/MYu4AeBY/mcHzGhyD393P47cfT/g9zsOn5+R3Ki5Bm7+fOMxGY+7P2Sk73udbeGhA79AtK3QQpDerMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPxzUScvKUwQUtvjD51rih786zFZe6Q4D+BHf2m1R3g=;
 b=sZGtBL+Ld9CwMdc7nv5O2xArivtJ49srwGn24CQyxQn/XIFogUNbOlAXMtE4SLggxwgf0YNM2pRlC++NlaNYmWdTjHfOYuzSff19mieDOKmKktZSVVfDkMgFT9qylmlybSL5LPITXOINSB03lHoxSvH/Pw9l42zTz1RVRvpxEEQ=
Received: from BY5PR17CA0064.namprd17.prod.outlook.com (2603:10b6:a03:167::41)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 02:52:58 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::bf) by BY5PR17CA0064.outlook.office365.com
 (2603:10b6:a03:167::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 02:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:52:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:52:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:52:50 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 09/22] drm/amd/pm: check specific index for smu13
Date: Fri, 10 May 2024 10:50:25 +0800
Message-ID: <20240510025038.3488381-9-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 410ff67d-f723-4316-aafe-08dc709c4c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NNa5FGSsj5ZvayoLl3NrMqcf+B6iRTHZoNLxZjcTFATCqATKJTmjxBvkCM1v?=
 =?us-ascii?Q?E74HKJ7X4z8aNZNPR6uiclGe8uR4FKBAwBR/5gEXDBZv1B+dIMepPLothF4G?=
 =?us-ascii?Q?oYNCZox5RXCW8xSR6jmssPeHdio0q0lqz+qQ7We1uwjZ3RiJtmHSGB8DAucv?=
 =?us-ascii?Q?1FBwRXuAmq1iYHs6IcLzVq4Ux8mfo8OVQP9byvaNzJDaW7O5hTP4sFqi0teU?=
 =?us-ascii?Q?lNPzNg5KtwBR8iKxM80R0umuJgBsUhWLKalM/Zd7cJmaDlFNiVFIRJSjK/1L?=
 =?us-ascii?Q?C+bAeaUfs5uoCcUkbVetuPRj/dJrJxHiK+ewu7c8nEhWQhYWItqFKQoe+GRb?=
 =?us-ascii?Q?dnorOD5Q5HcnGzYStu7beFzy7jRh40edvmrW5+oNI3vejZbDRTfSMvqPZTR4?=
 =?us-ascii?Q?XYHnuue2OG4eD5IWg2Tv5S3Y/bOqVoJMPKYmRaoQs86RjKX43Ve10ZYPBGn+?=
 =?us-ascii?Q?dovoQFdImM7xQQaeuNWblLhFzZppVlNPAqoR5dMZ4roi/wkPbsFqssXXI338?=
 =?us-ascii?Q?oGFd1Os3SjAaTAPRHxCp3bxZsRoGz+/EqCYXKu8L8tjCH+RdrXiHPNB1ekAE?=
 =?us-ascii?Q?76IugfAP4gg/3eZj09Cg0FQVdu5JWdowIoRj2Sp3upMjn+YC+v3pND7Oe5lp?=
 =?us-ascii?Q?bVdHBSWyPfOikrtrn1kF5+fF4Xig76ZOp7xygE1AkDxXw+sY0V1xbp1K3gaN?=
 =?us-ascii?Q?NNtxbA1x7LbXmNfAp35eFTM5K7w0t2FLMqyvfxLq/wr74jxkNSZ68GraVKTR?=
 =?us-ascii?Q?ZpM/4oM6DxJ7udRG9HwDe1rOHFw62E1yaLFG5MjvPbU3lRG7GulNtDinOWa+?=
 =?us-ascii?Q?Z+kE6ret19SDLPBX6m/LpO4bB4BHqstHQPvdhUNUrC/d74fQ2aA8ij++uFaq?=
 =?us-ascii?Q?cgLvJpqTQVanyFM+NoTHOFMJULw5c0rMUQYqwJT3AuQ6/v7AAeVw7ZHLhN5H?=
 =?us-ascii?Q?UEXPDu1APNBuCW7kkXCmRvswccmXy5Gd01mskTP54pg3bqA80cIc1A/K3I2T?=
 =?us-ascii?Q?n6XnslvcjpqHUthvhj8p6AFNhc/L+b0WP0Y1Ab3+YaALROsmty7wMMGAOjYA?=
 =?us-ascii?Q?l+eSOJ0dPFRiKn3CN5r8EyRdLbvYKaGuJj9LAWhqAQ0sJGqPgDld1BZtJrRZ?=
 =?us-ascii?Q?+iZ4l6RFYRTdM7PZ61AVyZWEKjJ76QjekTp+SsnIt1X4Mq/w+m64ANwM+7Jp?=
 =?us-ascii?Q?JKgYOCYE2C0tceGOc+Xnl8tTZdY+e4Pw02PuRzoZFcUr3LOQspW4KV9fVrww?=
 =?us-ascii?Q?GupYnLRqwbA4TAgW5T0gaJnisZa8C2jZBZHjy/5PCXDB2nrfLY168XZ5cPGI?=
 =?us-ascii?Q?FVcVAx47gGQWEsy7zMZdRaBd6U6DHKd7eWdpbD6wHAO8sqBNpbjaI1Juo4+l?=
 =?us-ascii?Q?bf/o3y4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:52:57.9126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 410ff67d-f723-4316-aafe-08dc709c4c88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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

Check for specific indexes that may be invalid values.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 051092f1b1b4..7c343dd12a7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2336,6 +2336,8 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 					       SMU_MSG_GfxDeviceDriverReset);
+	if (index < 0)
+		ret = -EINVAL;
 
 	mutex_lock(&smu->message_lock);
 
-- 
2.25.1

