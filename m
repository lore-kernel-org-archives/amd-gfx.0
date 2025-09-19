Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2F4CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F25E10E956;
	Fri, 19 Sep 2025 08:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="McePf1oK";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF81D10E956
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OthFuxfoV1XdYw2jtRGlIHE4Wdqo7qIE2eJ+wODy5/PkX7EcqRLNt7aaxwUjLsMrvQVhqYyLL76s0htiQ7Fa5VVXwOAn8bzoKwngVYaA2xGr2mxiC7wR+TtZG/dbLKqvDUWDvfnhKooi/bTGhuRtvpe8cD4SI6iHQfWoJQDCCyvgOYG4A67j8yOQ72GQkrCpyEEE29guD3ZqFFwgoJw7Nn5vxzBNiiDi2XRb1OBRI0PSz/11DfFWQ1Eyk1043aHFbnYrFNDzGb0ekVnIhaq6bws32P9mw3gETouHESYP31Kf2uSr5AZoQXASrutK+KXjA867eskRqSYyd5Y76aj6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OplLZUqloQs8tI/Sf+kDrU4+jkOGerxcfz96kWw0Tuw=;
 b=qplRJgdD41KVygu0BW/eWu0FR1T+4XfbrosC24c134/toH9sBK8viVmPa3fJM3YohxbM93L5XKd31OgqrYbmLsowsCZYcDTPlQQ1WNkR7jTXr03fDs4zJUHLxI2B33yqaQ1bRmusyt1l1Q0dwqn7jsF3ojWdQukSNUuC3X1TNW6t9UoHsowFVAVesBRkXaPbXNiPrYmY0+cIfrjmiFtQDTpJT9JSM7gMv5+AwKriRrd6zS3bDgFJM/7eDBuJ+PNldF4CMd8vBkTXbawqlTLLnsYFWzixCejREYXPrKQ3ly/IvINC38excpYWRCzN5aaC1YPEUiW4OnQQBDpxbdLkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OplLZUqloQs8tI/Sf+kDrU4+jkOGerxcfz96kWw0Tuw=;
 b=McePf1oK6gplRKTbM1OyxJ7g+i2Ln15qfm8MxLWqCCdKAeF/xVNke24st7I7Kd6unsC7043RvG8pMzhyOxT3L3iO9zxLeO6QoDctCZvWW0EhJyvDnVDAeORsq5uUpJIFRzM8YOm/IMZ0T1BACbyT9LHsAjyTZ8CMYMewcYk627Y=
Received: from SA0PR11CA0087.namprd11.prod.outlook.com (2603:10b6:806:d2::32)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:11:25 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::96) by SA0PR11CA0087.outlook.office365.com
 (2603:10b6:806:d2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.15 via Frontend Transport; Fri,
 19 Sep 2025 08:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:24 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:22 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 01/10] drm/amdgpu/userq: extend userq state
Date: Fri, 19 Sep 2025 16:11:04 +0800
Message-ID: <20250919081113.2797985-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: f22cbd3b-50e7-4f6a-5846-08ddf7542024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ARPfu+sLU7np9UTlDc3ND2jhEkip3TGC3UCOu10P4C1oXDemnvwZVOmKQg9o?=
 =?us-ascii?Q?vgpG8g/lQmYYRbbHI1rndi2e1rByh+a2FMVkSJrG3PPqJkbBAsbobV5JHjDU?=
 =?us-ascii?Q?zPuE4OVR1FS9njTQIFn1IVEYtss6sFG1cjI6VePdjWeMiYbuMSuEkGP4mrtQ?=
 =?us-ascii?Q?zkY7Q9Q5GgH5ClK0WjcTo48gUruXYRgzoKoyzs3QwU2RKy9MWu0rgd1+1mDC?=
 =?us-ascii?Q?DjxL7Xj5XKgXF9ClHExPOMwLS2nh3OJYUpiEkQxVaEPRhAQVyEQGJomsa6EC?=
 =?us-ascii?Q?hRol61dL3ZBQiZv5rf0p/KgXpzgiou5D+8xzYKlG9dQHLYaQzykMHHHqx3IR?=
 =?us-ascii?Q?Wq7Y9Vgio92Ry3iuUUtqAvypUSs8FPLy2OfOb6jd3LZj+Bu+YJ2dN4g2limZ?=
 =?us-ascii?Q?JJd0/iyzvzvKJmEA14TcVOMc4n9oEKzy/7QxeE7mEicJsW5DcQ/t57m/wUOh?=
 =?us-ascii?Q?Ox27n3RKKi5Bh/OrVVYI//r/Ikjuf2w8USeKMxZvW8TeM2Pu/k13nKwmJXOC?=
 =?us-ascii?Q?XUX16AC0Hzc2Pu8w0wAALu5MKj9Y/+7niWSXx4NRAjectBwE9Y8hdy5IblHK?=
 =?us-ascii?Q?0sXvMwPh5HLutNASBPd/w8ByRhsyS9PV9KcTGUygqKDYckklPbPLhCnQ9csd?=
 =?us-ascii?Q?ZAVOxX5NTUIHzI6zAy5UMH08YaFcP3d+3jNwdHutY3o9Bzow7fRJVCeCYKAV?=
 =?us-ascii?Q?CwDGmAI2v1tEZTcHoO99iMDpF/2kgyt0G7BkvAuVg+yQowjsNycJnAjqN8ie?=
 =?us-ascii?Q?GjM2p0YNSOErXeuq5YQA+OtfdrgJE3XAj1qYTpIYdGOCShU0VHw6VYCfCF6k?=
 =?us-ascii?Q?xyAxTBkYyjy6Nnepto5YIBNonJf3ktvNkNnGhQ7TUYOjydWvEqAh1Z138njL?=
 =?us-ascii?Q?LSq5z5c/yNlNbETX7+9myC2gxExlrrX3YoT1iCYYla0UdqFO3p5G9nbaIxKT?=
 =?us-ascii?Q?xJcvpCtEB1AMAQfV5kom3rT+ZfJVjJ+Bp/lXkIrmamf7E11TRrc+R6s5EL3C?=
 =?us-ascii?Q?iL5d7ynJh8jP20TUYKnensz6QUYH+6Z+HWy6eW8H5oYr7GrWUy59/5lJooUU?=
 =?us-ascii?Q?o7+XtiwP7WbHa+4Z5Icv4aIKG9+CpNTN3A6Qih+Xxblj+y19Mma3ZLkRBe/y?=
 =?us-ascii?Q?3/aMONVC61P0L1a4svME+P4HGVNps8TnXtWW7if1S3zH//QQN2X+sgG75p8e?=
 =?us-ascii?Q?Nf4r8i4Z7S65iJ79KjytmEJ1VCvfW+QzxFYOROIy1UOC8ySapfemtNvlzsLq?=
 =?us-ascii?Q?LZ6DlUur512gCfblqP3H5t+A/h2dMvp+KZCwOA2u4iEXoIYkguLhSuiLX141?=
 =?us-ascii?Q?Z33sfNWmsBIGnWOiFRfXmtOfPqP6bX83Zl6E0pmiGB9QE7WfMscIYrqEhIIa?=
 =?us-ascii?Q?r28FVtQsZ0nZMbe0UxuTVLZgGKnDWNS/ho0T4U/2r70yGzuk+BV50v6YQr3X?=
 =?us-ascii?Q?TQU62bgh3ogQkeo5PwQge3T9tvzoXSa4/Cway1ggrsj211Xs1N7OLYXcTChw?=
 =?us-ascii?Q?BGo0LK0wT53PU+64Iz68JxhgoC96C2oMP1AO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:24.4395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22cbd3b-50e7-4f6a-5846-08ddf7542024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
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

Extend the userq state for identifying the
userq invalid cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c027dd916672..ded33fe76e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,7 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

