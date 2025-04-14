Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15468C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 15:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1A710E619;
	Mon, 14 Apr 2025 15:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RJeUGkhz";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0649E10E619
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 15:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpAiOYYJvIiOmYek7OHgfEeconLZSce23V2tUl5OXqOVTe1j+wIFYfrN7spHKKtw28Y8PHUWYFvkCigVnLt797ohcZwmULsbMe7tA1TO0tgU8mq0NhjLO7VrAK5ghICtfigPUfcAQc2KZk7GaZ0iB6uDAh0TaoLd9Jd5C1EnSOY9YKlda3SH0Za1RVDQmT/34ilzmmIdqFR9YUi+OeYOPShP6vqB6b6ZJWPlSaB3+0GEVpUjQ5I7xXkJlLFTo6aSrTlmDDd+UJuT9Gd6A72nnawX6ahthjnrXohQzI0NRkGX0UEqZwrJ6RCs7tkeMkZ9JlRbldA8oUZHVA2TOSu+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PHPOtGRduWoF0znoPF0+vVJhgNZIg2f/Afa/tbKbeE=;
 b=Idjp20gTLXHN0UqvuTnNca96866ub5pUu5PCgytuIX8XWOFk3HMDh7GKHhGLSGUo2+iBWqM6lSa3azKvTaMgMieVfm6A6dx3sDqYAHP7eL9DEq1iLVspToFmLHEm7VEyTeLs/Krg8YUZKY3FlhkkY064gXislomgQj29BQzro+u1CEwWbVUnvDCpfeXftvDHgFA1vQpvQ8UwvFz5EdyTyBYO/r6xT5Qj+IvbjuFoHcUFYCVUD5qEwzlNYahEQ3MqhUwvO3kWfTcwfZcYLdnjhubKxSNVuVLp5lUD+73RiUmISZy+dHPY4Kxep7aiUvKB5H10KU2Syc8l/46JnRp42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PHPOtGRduWoF0znoPF0+vVJhgNZIg2f/Afa/tbKbeE=;
 b=RJeUGkhzpwnWUFXgqq1HEjT4kzxJ0LUvVuF3puKTkz9w0TeG57vdqmeFfkJbOm6PdLh5pg8yhzqVstcB8/LdAjKixmiq/tPsCYLQJKWMUnjyzJ3YlNY0iSzkq13vMh3ULRVLJFSzbCjB5fVFhH1jFExuyCoAlfTp524JoM3HzFM=
Received: from PH7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::28)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 15:33:52 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::92) by PH7P222CA0015.outlook.office365.com
 (2603:10b6:510:33a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:33:51 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Apr 2025 10:33:50 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: fix a bug of smi event for superuser
Date: Mon, 14 Apr 2025 11:33:01 -0400
Message-ID: <20250414153301.51427-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414153301.51427-1-jinhuieric.huang@amd.com>
References: <20250414153301.51427-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 827782ae-f7f9-45c9-e9dd-08dd7b69c259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iWby3+Blbgunae6AW05PgRlfWuJQ5p+AZlxW6bdoPBK/DBxXu5VdvcXru5//?=
 =?us-ascii?Q?SFYr6qynJ2iuZPsT0/k3rHlX9A6lVgKsV1ul2Dr5H51Vp4Jc+Sfn2PeHty1a?=
 =?us-ascii?Q?jzqfHLc561VaCwUMsGY84Jvh3fateVJ49NEMcVv9cTTP33Yk487u70TLkvE9?=
 =?us-ascii?Q?fpfatBDfNkI5TsDzP9jOL29tpDSuhOo6xENFwgzzODXsJXlm6kKAWBPxOHhw?=
 =?us-ascii?Q?zK0ybcUz5RRtU6aCr5dwEcbaBlJt4hxchcnyJ1ys/XEvmk6b30tKkguD0STo?=
 =?us-ascii?Q?y31PksDQMrXKLkysCiplK+V5nccShYC9FAO4b1Ozt75RQhv33GOuYlVu0soK?=
 =?us-ascii?Q?I7ZF0FrtBGsl10TMUo7y1Ch4136gRHhJnnGL/IWt2gz7/tWFz+3xT8ZBM8eW?=
 =?us-ascii?Q?8XwfCATN48JPFhshGcx+B2k2lYRkUEDltezM5ZI3cwINI5zreoKy8NQ2Fp3M?=
 =?us-ascii?Q?agPwJ5zUPHld5qtB9WK+0jJeaInmTTzp8fUyI4k0RY0bShEmf6mH9GWPV8dr?=
 =?us-ascii?Q?Kgou1UdJApr790s4cqgDoOLIzyRDqqm/sROPuHAE+nDF5M9sY0PMJp568iNK?=
 =?us-ascii?Q?kx+K4JoDjnAf6HxEQY67YjEYu8cdMrLaO5PP27rEpjT7f+lcgTskTFd3BiNJ?=
 =?us-ascii?Q?abCmeOGFwUbsrLawUibkDG+/s0uWNr6k28eOiHsw9VHbxLfqTpp+oJlAhDfA?=
 =?us-ascii?Q?4R0sJ523h326NC8T1NJFQBP8WzhOFG6fZOaqPToLiRyVXg63TuwhJKjWaCoD?=
 =?us-ascii?Q?nU1zlLjpeHmaMQZ5UbG+xh/OcvRaUdzHc5og3gbUaNDQ0/qPNg1neaVQR2Ey?=
 =?us-ascii?Q?4PPePEUMiUUgffUnfzxm9Tyjxs4ARNdM1LvMHpVUQ1GK2Bwp+pGmkBgNHXj3?=
 =?us-ascii?Q?EPzygoIHEb+2tEnftO3UKQlQSrEv41IQquA97/8IV8OEdDBzPRM2XVtckkjj?=
 =?us-ascii?Q?2ZwqV4nsKKQT5AIPttq9YEFKMwlhR1H4usfGdhgM4/LWW1MyhHII1bJ4Jvr4?=
 =?us-ascii?Q?so4+xCoukWTq6Yzm3c0zSv8dkWmvxCYAijfiZfaE1fo5Q6YNcM1N+6zYA/vg?=
 =?us-ascii?Q?8eCdTNv8tFBm5AKDuxlTc9XMzxXOOPe2GnZFbdPhsr0mDpOtQ9I9NL781a5e?=
 =?us-ascii?Q?cs3sZVAlW0hbnFt+TA/QMuyyOwxD/cJ5ujGV/ykec9qtsCv/nSOg/sj+PsdW?=
 =?us-ascii?Q?8IUsH7mx9AA5saU3u33b/HcEAGO3QS4XeXHqoI7mpVBHuLEdfLimQXyoz/zS?=
 =?us-ascii?Q?1PnqTxrCBx4nj+zQXm3ybMPhdnfQU3ed8l8ks8YCOz+JP7YvkzDO7WWcUbSr?=
 =?us-ascii?Q?VMbvnSGss/AcnDf6rByAwa2IYu/Q8dsDkgVFu0M09nFeRv7DhHuFQMowXxPs?=
 =?us-ascii?Q?oMhVIQbO/z9UwGba1EX3lbszgM2SscM27WuCF0Q49dg6BkTkqqat9vustSJQ?=
 =?us-ascii?Q?LKoYieiMFxFnC2u7Z1Tp6BD7rDv1wnwY5eA04YDxIjiFeVTeGXSqOfGTP5t7?=
 =?us-ascii?Q?KVINjJCpMHiG4+jZbtbmqVw8OuqjYPxyHfRx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:33:51.8152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827782ae-f7f9-45c9-e9dd-08dd7b69c259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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

rocm-smi with superuser permission doesn't show some
of smi events, i.e. page fault/migration, because the
condition of "(events & all)" is false. Superuser
should be able to detect all events, the condiiton of
"(events & all)" seems redundant, so removing it will
fix the issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index c27fd7aec1c3..83d9384ac815 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -163,10 +163,9 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
 			       unsigned int event)
 {
-	uint64_t all = KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS);
 	uint64_t events = READ_ONCE(client->events);
 
-	if (pid && client->pid != pid && !(client->suser && (events & all)))
+	if (pid && client->pid != pid && !client->suser)
 		return false;
 
 	return events & KFD_SMI_EVENT_MASK_FROM_INDEX(event);
-- 
2.34.1

