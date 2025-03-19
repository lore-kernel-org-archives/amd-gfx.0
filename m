Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4044BC35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 19:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6F110E30A;
	Wed, 19 Mar 2025 19:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PQOiHqaI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3802F10E30A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 19:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbtVN+fDYt8vYJCBBhnxOlOKLqcdX6g8sFxqK8HNiS06aZZq9FcA9oHDIjeM2RWuPMt9q1PIp9H6iFMZA1HMUcvPTKYdkVubG9iUzQnuW4Vi/Ipf5M7r9mJ2lo4RjMSaALnrnT6Ub+GSItLoYd1U5FA0grOiQHiMC68dwhK+W2VpF8wO6/5SHhmrwz1azqloVDlLxs8ggLeszTqjkR+35v95J9r6PqSjpR2txvjbWUmHiJk/xOptzrh/FGiPSnduIkEAwAf9f3b3YF64e8zf1vMQHPL/xjJBO51idK710ti1b0BZIAwuydKIZpfKejc4/q4b15umpWjGPtImMbmWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqip6r9IOTiMJWR6OmQ98fyMui3x7HuNYThVOU0AIAk=;
 b=xJGlxOS/yGxqa1P2PfGjbmied+em9DN5YQ9z/GTVu3yNWMxI2NXJ2T53WMd7bkPMl0UOBL+0E52G4HMIfw4yLUcOYOOww186TQmQAFYliDhFW5CySSXboqpgAr9OuFQ6Fw9T33hVZfyW6/OKtV9zUpckqmbQPf0ZPbY+VqbzXHWPdbHETb4Le2nyeksTY2ZEu749ftSSlZxGgM2q+zCOOwsBBYTs0r66HuoAAJo6N3g09Gbd0hB7cZvICGAdinpi8Kb+6QMGFdPCu5reS+K3Ps/jUdXD613UN+3WwbWyfWx7UqBo/FKgubTDyHG8lkvP0iUF6BNsSzMrnNxaV2Kwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqip6r9IOTiMJWR6OmQ98fyMui3x7HuNYThVOU0AIAk=;
 b=PQOiHqaILbiLYGwELgvckwglGg4z6WfjhM4kS7sByOczf2tG732YvTXIaGC/QLMFKuE1vl3QbjtdaibW41rGSahFB7YNBMIpHEn8f2VYKyU6y1f6Z5osL6a1EeBXryDSZ0h4SVhtG/n2gzcgd1Z7G7pgExXfNBY0NVUz0ShIK9U=
Received: from BL1PR13CA0362.namprd13.prod.outlook.com (2603:10b6:208:2c0::7)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:09:06 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::bc) by BL1PR13CA0362.outlook.office365.com
 (2603:10b6:208:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Wed,
 19 Mar 2025 19:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 19:09:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:09:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/mes: drop MES 10.x leftovers
Date: Wed, 19 Mar 2025 15:08:49 -0400
Message-ID: <20250319190850.3899718-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319190850.3899718-1-alexander.deucher@amd.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff2eca4-161a-4a3e-9080-08dd67198520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KU60+lUUwAKV4rn0BnIAWz71V9YLDdvntYl/PMSg+WbgqxgQHQGTisK5DAER?=
 =?us-ascii?Q?lZPfNfEQsBv+t6SoUePeb8tq+sjyk/HGt0t+ZJkoxngSnDNc6qnZ4TVpp/dB?=
 =?us-ascii?Q?WmTcb13ifVn7KH9qhD0yk7+SX4EYMKcsp37AmgOl25Cq8SAc6Lg+IjVg3rT/?=
 =?us-ascii?Q?luib0LSJWSXv+H5/ouLFEp+d7XaS8Hu52q5oi9nMDMwnH6ZafylI7+C9fSL2?=
 =?us-ascii?Q?HG8/7zUrR9FjP9lS5s3f8KIRK+O07fPIB+pT5MlyYQ/rCWPiNbt/sxmHn8wM?=
 =?us-ascii?Q?eUQf9eBR7qYGv8b9r/T34p/XADNZra7T3o2Rp3wr9ENRGs1XOKQkRTgrm6Tb?=
 =?us-ascii?Q?otvfijLkS5FGjou7qXnwixowdeSHj6j15akqH+nSX0AhVJ7h68iKo/AdDYsa?=
 =?us-ascii?Q?Vu9wdXqI1XjS88cn8Rqc1gzK2us7rkOMjhISH2xEz7UYt6Z9ods5+VP9HcI+?=
 =?us-ascii?Q?TOV/+pjHRzUJG2ZJnSt3bidnx7BB3o+l1rajRtWsdLoDYBjFCLXSAMOvS3Fj?=
 =?us-ascii?Q?POdYYQzoC+oeqLg6CKF5c7zTgnlA4eKaA1k6079qPG+Q7OWA9BXZY/8X8TD6?=
 =?us-ascii?Q?5VlTsHBrG1HlcN4mXHBGKaMztWbkXS85BuTVqfbc73mhwqtIi4Fahvi5P9ic?=
 =?us-ascii?Q?tAUYq9NRen7/VzBM4+bVqTThbJ66JpRH0B1Y6KqCipKvKGj6lpuALC6KjouF?=
 =?us-ascii?Q?7t3ckQQc0sJa2YptyEEExi6HiLLTWDqrdXf7tDtk378iTdvSXDkrq5NXZzsn?=
 =?us-ascii?Q?XXdgWTMkgdsc6HtIdQn1eeqBU23JHj8EKoQuP+R2Vra3IGfE+I8UNhoS7BtV?=
 =?us-ascii?Q?BRF1p+r3FPxOUZiHbUThbZRK9n6DahipOoWdlbJ2a5IQVkcZFz9903AYOSeM?=
 =?us-ascii?Q?ByGRWvChM5OH8jNTow6frUjF3rzBWwin2lFcLnJfSu78kH75xloRr4cURqwB?=
 =?us-ascii?Q?zQ64fCXPTBEghoSCalsRHWVzdqM40ZJX8YRjtpYBoy1wty8ZLmTK3HE2rsgC?=
 =?us-ascii?Q?x7LlFQF+6Uuob+nxa9MuAQNVzWbsbt7dju3xcNHpvMNyp0z0/sXkwun7fWr4?=
 =?us-ascii?Q?i6oiS4shbYsqOgAG2g09icnqkrVxmDpU1AjKgyXEfI4ygVqApz3WdmoirL0m?=
 =?us-ascii?Q?4Tb5nluF/u0ZL/ghSjU4tAGdm0UhyCvwcbb7JRJyTDn2z3uogpt4azGWEkaf?=
 =?us-ascii?Q?R+LGFj1ndNQuolYBLAxrXXMqD+smGvJtqYAsIAl9xSptFvYR+NE1XOMP9C6K?=
 =?us-ascii?Q?/XtJu1oJ9d+RjmmLFdH/YxeeY93yipQJansuKq6/7yva/L9YyvY8VDpZdBXg?=
 =?us-ascii?Q?ZPfWi4h2ygiALTBp60Ps75HjwAYORozRWUQOi0tpXUpk7xxZj/FKFNC5I3n5?=
 =?us-ascii?Q?U46XIxG8nd3D9Gag5CGmZrycYpFGVmw52ZHXnGjGy8IBIEu2pJXke6FsxyjX?=
 =?us-ascii?Q?D9JNidag0fe8Iuj4Bpn6BGxQzruwO26caWkvf96cdgZUvxM/foWslDWuGEN+?=
 =?us-ascii?Q?qs10hMQ8YXropOY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:09:06.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff2eca4-161a-4a3e-9080-08dd67198520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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

Leftover from MES bring up.  There is no production
MES support for MES 10.x.  The rest of the MES 10.x
code has already been removed so drop this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ac9b1708e20d8..fddec5d1f2444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -136,11 +136,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
-		    IP_VERSION(6, 0, 0))
-			adev->mes.sdma_hqd_mask[i] = i ? 0 : 0x3fc;
 		/* zero sdma_hqd_mask for non-existent engine */
-		else if (adev->sdma.num_instances == 1)
+		if (adev->sdma.num_instances == 1)
 			adev->mes.sdma_hqd_mask[i] = i ? 0 : 0xfc;
 		else
 			adev->mes.sdma_hqd_mask[i] = 0xfc;
-- 
2.48.1

