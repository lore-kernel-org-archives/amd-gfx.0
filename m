Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F141C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FB610F372;
	Fri, 21 Aug 2026 16:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+MQXzqW";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C61E10F36E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2dZrsQ7+rIMRS38174YVY2AO/kNToDJ7RI3CEaj2Hqf9DxXaJCXOGAKnCBKpCQKjUwNw6s9r0/RTiQ3Iww1hgEDkcYWici4gWmlefsjfGn6SjOkmrcz0PrMqfx0mi/YVkCenxRg68HmBgQNd8C1zOhnWxh+yP6BPKfmv5cy20McjjkNrNrvfVzZA3lzFz2rhbxsHB+rBCIiZ8QPuf634ZGcjOZlwHOMMNuK2pPZAfADU69Rj/UR+Ue3wbFkxwEdrQbOjuNgJMrp5NFn+aE4BRoMzCxJlTqC8j3EQnV+kNlC+JQ1Z7UvuuNHAlUWkhQhUyZ+HZHRfTo7EOWsKPUUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0ZuGxbId6uQiIpzbiMqOASFie5ASeYlLm/dVnfzYeg=;
 b=SPmlzvz+aCPV2nIsFnobwfkY8P2IrVWg5VT2rkwV8e3WvUm8PnSFIAtlVysuOiVBtC4RYTgWR6iVBOPrjROcR3wcKSzA5Z/+RVeHc7tD6WgToCTAMFMPY7/Nt1PYkvxZGReBUXjizXbYb0zb3u4GVE+gV8Y1lu/3aKyw7IWoMLwMYwplG2yKos2a1QlUG+rmKDROcj/V/RMTUJOVjZI71xKN/1Cabn9Empkj5WQlKQSOdOxNzIRIVOr6PQEZyiHOeEyEG4X8gz/p4MG7gwMezQnOZOqb/k0OkptzLCDk/8pLt5qN/sRsReZ2QXGvqoxat3+UhQFroPprURXPO0Mziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0ZuGxbId6uQiIpzbiMqOASFie5ASeYlLm/dVnfzYeg=;
 b=z+MQXzqW97JKv2ZD2xXHAvPVdnKoyehCZlu6kqQ1SC7gWe/bi6zU21jIJoGS4RnOVR/PDBcbR0s+9eg9dmDgUynNYkfuKyiAEF34OcAr9WmZb2bd6tu4cSyVybkRKu1+sZ4I7fIf/0sUsSriHgE2euxFjDYbKCppiC3gpDKLhLU=
Received: from SN7PR18CA0005.namprd18.prod.outlook.com (2603:10b6:806:f3::24)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:11:57 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::a) by SN7PR18CA0005.outlook.office365.com
 (2603:10b6:806:f3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:11:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:11:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:11:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:11:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Use 100M as refclock for SOCv1.0
Date: Fri, 21 Aug 2026 12:11:44 -0400
Message-ID: <20260821161147.753435-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 794ed43a-486f-45f9-bba6-08deff9eec8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: qaR0cePlpY2ZklR3evNCwiZpaKtWFVxM26sNl47b+5sffooEUoVykz5TPz/OMe/R1dKckes7cP2HveifxFY4Q772qZnfJK1dVvHHAhBib33jAsnXuizfMotp7Ya6CZlZJ1I7BLoHH+i61Lhvz0mSD1bE+/qweIBNhy1IwDIfr+6BSGf03W1/kad81OvwqXURy5ej9lD8mwfU1oi2qCNjrCIikghC5SoKjgUFsC+ahU9LyXcGDZhbOGdEk/l7yCflrD9RrX9oG00uIuuIqQ7pStMeNNGtfDOAGdcxTSTHqsSze7sadKthDg2dALZBMCDTrn++OlELvyjD7DHTcF4l4MxKI1aZH3CVKGTCR3zkXwWi+EvDaVKtUXxGi42MHIc9Q3fZPKXuZZu6xvXqkrJJuMuWD4D3ioS97g3OKantrzia6bGE9B1i7Y/3YJlis8dqCOyEL43aYKo1kZMfTUzVO4hQ/Hk7io3Orub0CF4OpGloRVmmHV9gq+kY+qY4a3YUIiGIoOeQi65bjSvAXW7EBjQMvYhP68O85Y2vF/+nnthvBLzm+SvhECkISos9L7SvsSnjyrEvAsHw9ZeaUeshyDnk0jKxoRzPrXJzEkNkKQZCdsw2kDNCUcoeNzSEu9LG4u+KN6rVxCX+p3H38BfBfzoPK/1ghNQwGa35a5A8Sr4XWAPU1lmdj5d+ckWox98qfO4QIUGIHyVQ3mn89fyGsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: onx2cNLe/cNOgYFtrRKn54k0ugI2GqrwU5an7gSB4kKR8UKvbMjnik4C6wV2klY3WcHjvtuZ21Sc4kmtNbBvFfzphyhMSqFLHVcLyG8wbfBo9tEDDRj3eaLlUdzShjRWM7jbXfvlDhSWEFOpy6wKbC5AaGTc2lcDNjPgsrntMLtJ+zlSkHUfZhWzEqO6ZEacbWDu+XlnMjOb/U1T4Kil/kA0c8IAjy3q03Ckqjv/prDsOWS6OQuQdKa5QEh6M74vuzn02f2Me166LtcDTr2kBkBsyMmIEmpQnMgjVjHAWg/qyyusDWVP4zm+qbObSEGGegPgt5GA2mThBdOjPHqBm9msJH4qJ8/l5Gp8UkQR2YuSbkLdof1xuPBn3ProZLS7mk4hg1v7L8TkDN99xxcReBJr8iFXhm/X5PWkg1Dv72lxH4jrqcsKGQEIm+vJA1jI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:11:56.0418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794ed43a-486f-45f9-bba6-08deff9eec8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

From: Lijo Lazar <lijo.lazar@amd.com>

When VBIOS is not available, fallback to use 100M for refclock value.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 3c1ddbd1b93f7..5e40fb0cdaf2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -149,7 +149,11 @@ static u32 soc_v1_0_get_config_memsize(struct amdgpu_device *adev)
 
 static u32 soc_v1_0_get_xclk(struct amdgpu_device *adev)
 {
-	return adev->clock.spll.reference_freq;
+	/* 100MHz is the default */
+	if (!adev->bios)
+		return 10000;
+	else
+		return adev->clock.spll.reference_freq;
 }
 
 void soc_v1_0_grbm_select(struct amdgpu_device *adev,
-- 
2.55.0

