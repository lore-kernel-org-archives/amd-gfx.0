Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDE7C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A936510E9F3;
	Fri, 11 Jul 2025 09:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XQCzwpIY";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D064210E9F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfFn0IYNM9ba7UVL2/20Hek5qnpERmbf4b5G7y0W5IQaSai2xT361UaQiBlajaxveJ4/ETlYXOrtBMqdZDqTYlfktq+ZRBX3myyW4esIzvTge3EWcNlghg3pCPV3Dttl9CmM4zgwxfYkpQnyzlrmsKYhQ/KlsNVv+19aDl1yQ47trJ7NjPhfoAJWINLWQYISqQJZ/yUB2dU9LJwRniAXjNQYO3ZVcw9zyrioMXra/7f9U3aCJN3Du3r6G2+jz4u3BVlM9KyGdOOPn8ns6JyXmH972hdZm0teMmBLtwj0hNaE+wznmaEu18EaXZ5bzYg/2HGgj63MEeyM5ZQA/CqiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9fzKuSxDPh9TPxeKAUcHd3z37Pia3/D1sq5HzBw/zk=;
 b=P8s74OfH1cVNkD8FpS90ady4bkpdYzJxh3v8KLcn0dUT/4FouOOYX/aGU0SUiQu3FDHPSEts9eld4J6jC4CvtPSFXDF6x+jZ9wD4bApHocJNtw9vOXpbafGyukvafj/Uo6czbWh79xg9tecSa5fZ3ToTaGoKc6aXNPCmZBokCo2elTYYMSPctpHM80guPYlOX6NHjSf5BFoCusts+MUHf/+sUYamQaNQeaZuToNCCjNf7nLKnXzjmtyMky7Pjn07ua9tnNNyewg8Cp+q4bSsHhphLqoLmVZH6etXSQ9QtUJ9uSkETMIlBknkxAgr9SZtTSYVq4QO2kn1ns5niZut2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9fzKuSxDPh9TPxeKAUcHd3z37Pia3/D1sq5HzBw/zk=;
 b=XQCzwpIY3V/dV49lAw5j1+DPwCvc7G9VLMhH2chC2S4+5QlH6c7LX9ZXmIej8S7UiWNUCpVB+VN4Bnlo+xJeLUgwYFQpLP6LL8J6K5UgHJ+z4jnLs2LaB36bz96eMftf6PCOw0XvfT/ouN2r3NGmkWNwk8NQSl9qh3T3a57vJc4=
Received: from CH2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:610:60::36)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 09:35:46 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::90) by CH2PR14CA0026.outlook.office365.com
 (2603:10b6:610:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 09:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:35:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:35:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Use cached metrics data on aldebaran
Date: Fri, 11 Jul 2025 15:05:22 +0530
Message-ID: <20250711093523.1468431-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711093523.1468431-1-lijo.lazar@amd.com>
References: <20250711093523.1468431-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: cce7e406-1a59-4090-d984-08ddc05e5036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PG0+7wY8g/kndfuo5MNj3RUL4gxBJwEHGMWFIe2/ogHUrfWG9DJaX4UqCLNr?=
 =?us-ascii?Q?JVeCePYkP5ZIN1a/JAoRKPNV6J2jjirQ5v05RBANMzIaKYavgATXmDDfUusD?=
 =?us-ascii?Q?1nNhULko00+4zmj55HsABfRpzNVwyKmY9bnWi8lrTdzEjb9FXeNZWum/lwTt?=
 =?us-ascii?Q?C3NHt3ztLw5G+u6eYNdvOwi1j4qflm0JWMB2T7xGVrEbZimnLc2gJIugLwyP?=
 =?us-ascii?Q?wnmNkd1YhNc1ByF8ij1fP28+imRQPJF5xnBW4HrHfNUwv/qYyYdIsscGrsyw?=
 =?us-ascii?Q?QOIVC2Ok8Y4vIKiFRSBm5CDPx7j5YQGagGK1kUarmklKUAR882X0Bi6ZEy2S?=
 =?us-ascii?Q?301Bg3EdtOAjt25SjCBkHa37K1q8sZCQvujc8ZFXJAZBLNs8S44lZcHThgbp?=
 =?us-ascii?Q?SsuHtm44pj+QylF+ZUk/M9XnO+T0qMEI6e9vvwV43UhdRx3T9RJvW2KtrJNb?=
 =?us-ascii?Q?wuutERlTWtKh9r2vT0u5OFiTMGmpfMJRfzfXea+SiN/3xOjLMWzM29z4r/88?=
 =?us-ascii?Q?Zz63+fp/aaTpXJP5NGvFUut8qiFKyvm2k3L5boeS6/P7LxMLkEDnkUYpBCyK?=
 =?us-ascii?Q?8yCaAFgXhtEqlCRTMCxSCdpQ1HrYHyK4CFc9rUhB9l7Sn8ovPvt5+lsqYomq?=
 =?us-ascii?Q?HbFL3n7Kr0DmfKx0gqFvE/CDamxLm1YPy+ZnIbFAzIcg+ze1OSE/VrWvA1mL?=
 =?us-ascii?Q?kB49aWS37YzFKUOufUY26XntqHnWGg13hXMv6vIhExilTvyxRdbL8SZ+pkBB?=
 =?us-ascii?Q?YbUJJul00NsN94h/70PTKo2eWTMDruwUqbP0cHWkHIY0QlUhctJN9DjHjnqd?=
 =?us-ascii?Q?8xCAbDzsabwN1wAcKuuzKBm/PYXaHdOt60O7TNZPnF6losWpOtOdwOOPC9eZ?=
 =?us-ascii?Q?F2S5k0kdjT0j3K8DXGdXYkAUtCHTVjfxk1medbmVJqRzLyET189M7LChClWH?=
 =?us-ascii?Q?R31vogVPYdvZgzh12Q6+Z4zskuWmEHTJ1h+aGbgCKJqzkYpuYUUeEJm5tm2T?=
 =?us-ascii?Q?FU+vD1ZfDVpdYJa+lIrFRNrBZ/QbhAK+oQONg/PmTosWD0IVyWKNiGENJdIM?=
 =?us-ascii?Q?VTJxe+5xZrJEIbl49T3AThMsNalFAVb6wZUDEuj9d9S8TOMJx/jXN99oXfY4?=
 =?us-ascii?Q?z2zTwAuaynktESAR+3DyPDc+vHE6PUQXZjjF5aU1GzbeDOFkAXwMGxmDlYrC?=
 =?us-ascii?Q?wKz9+Qij0K8iFQIV24hPCl5UumrmFSpjRwcfkAl5Gf8mre0jSUdqM4ixFNc8?=
 =?us-ascii?Q?wppZIkZ+z7BBcKwH8Iq2+uC+265WQkLXitQyem8CAYnDLueoExKa17MVzGkp?=
 =?us-ascii?Q?T3KNV70jLKJBVFkMzX4OEFzg96v1svRSY7cwNI/AzL1DAoXlUDS7gEDK/68M?=
 =?us-ascii?Q?rbRmpQ/PMZRLvIF7Ev+ZVyO+ckOox5dHe7UrtY3JH8raXiLZBWtgPbSoNK42?=
 =?us-ascii?Q?9cFpO8PJCFmMI0q9geN+Y1FfIjol9eLG+jPgDS0SgwfJ0zAR+HDZ3icg+yye?=
 =?us-ascii?Q?fL6RdF0xmkoEBhBurZuLqVKdAY9XMn1rabrW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:35:46.1173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce7e406-1a59-4090-d984-08ddc05e5036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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

Cached metrics data validity is 1ms on aldebaran. It's not reasonable
for any client to query gpu_metrics at a faster rate and constantly
interrupt PMFW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6de653d2ed62..9a61cf904275 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1726,7 +1726,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 	ret = smu_cmn_get_metrics_table(smu,
 					&metrics,
-					true);
+					false);
 	if (ret)
 		return ret;
 
-- 
2.49.0

