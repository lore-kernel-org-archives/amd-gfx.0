Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8C5C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 15:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1667F10E2C5;
	Tue,  1 Jul 2025 15:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XHhHiX0c";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B52210E2C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 15:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXdwQhktml7Fb+ZVkiFDKk1RMsEABeDIHVf6cqlPHEEqNN7OG19ApDqJBywgNIPy57ehbSSlSEhrTpR0Zi7s6aZd5/uPcTLHqchnn2wPIvYDrePaRoOjMxqX3oW7xVVVE42cJqmqqLNzKrOr0+s4VM6A9f3UbiPM7v2NG6qxSWZDw+p73cxUjaGKJAZ85tIVCJ5maGNCGLmh67/pITdevmQ50ccVHe2DU448ABTNDT9ByHSFbrdAHNg+queoaBv1VXAG9ciPaudEEZyan7xSCxnR544ZFDBFSGNw7CzGlq41afk0BnMOtmfWe9ElszgFAI/F8YhK+/Ai0hJgh4e6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H80FGLVPhnNHiXq8kDShOMDlUv1DuyEIYGjIPj0/nGc=;
 b=RntgjUdQeojOQzSLxHiS0PNeac8Sxnm6yuqNjE4lbYwNzKFn7pwPq5zJy8SqHjHPlYb30yggAf0QVweyn4ufFngwxx2Ml+CkvG72Jz8U1QE0saDQiSQ8yDvwcoNWzNy58/FJlMONcjR5KBBRfAYNmy/8Y/e0CiuMo6IMyfod0TpflVghB0o1EMoYI//5IlkPeVnQ5YKPm59o15V8+An1zpXqgWpqGK65oqDZRMhmIyyyutNMivOrC25JrB77F4Pomr3HG4v7cGUkkn+kl2jtqrq3Kauf/Q/TcxdjTMY4OpQnJcZ5KKyK2apPBjWsgj55khtlPOcgnkqFo584fjXMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H80FGLVPhnNHiXq8kDShOMDlUv1DuyEIYGjIPj0/nGc=;
 b=XHhHiX0cV0otlLDImGzKsu2TReTz5qBcMx4vHJUQvoOXgOKXYkz55YAEyHeogO8P/bPPKidNtpu0K9dPrYUOQdc4f7e9Hovu8IRQUxvuRjphKoVhr5/zh4YnvyMqi0QPTNBcUAtaJwEXBHgbiwf+xkiX5MkJHoYOqzusSeCacCs=
Received: from CH0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:610:74::30)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 15:25:54 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::7b) by CH0PR04CA0085.outlook.office365.com
 (2603:10b6:610:74::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 15:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 15:25:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 10:25:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma: don't actually disable any SDMA rings via
 debugfs
Date: Tue, 1 Jul 2025 11:25:38 -0400
Message-ID: <20250701152538.5832-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: fb66e289-a5e1-4bff-d169-08ddb8b3917c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T6MzqzwFkEmX5z/E4qx0fpG5+1t1XS6Ia75udAnBgdQFEaDZ2Wyl6RCjon1/?=
 =?us-ascii?Q?KFAY7wJkzV8tiBqQY4ykQnRjCFm9gI5ed1jF666gt8YdMeKAnldioFbNtiPo?=
 =?us-ascii?Q?zstXtXl7oUeGq+xZPcMzk/NoD3GTtyzyrm2wCp9PHtmPUVPTqs4ZdPqa+4yH?=
 =?us-ascii?Q?LslaLoYv4Ig3MuhjgtP2pmHim7s450nARo+Fvjv2cbi6MWKo2HKNRMe+R/Tl?=
 =?us-ascii?Q?F38OnZw2YJNmVWghVEYYkhLjsFeh4sl3Qxm6ik49TA+XBOaU5X0a/SAJuinT?=
 =?us-ascii?Q?o9K8JugM/iR8jK01zj7JgsWJ76k+ZAfKmIJDbYS5qEvKAeXuIxG8YXH6YLsX?=
 =?us-ascii?Q?yhSSvi563AVYXTN8mi/oFxkvohw7PCIGsRfrbjKjEh2SgYTcMIQpxFnJTQFo?=
 =?us-ascii?Q?j/Wu+qRMs7PiL2GLPj/ECTPHBCJQKGEESbLYdbHbJ5nTelWsaJF3tA5RuC45?=
 =?us-ascii?Q?NaKo9gU310PNrmLnMkdGNkiREvcYE6TnNwGQZmI/eIEz/8kBNpNIWAmMeSUj?=
 =?us-ascii?Q?5J8SGyLHlsQADbyxYFeXJoXT5Ekq5npJwXGoUoK4x7qcaqIzma7otaFa8O2C?=
 =?us-ascii?Q?JJlLanNMT7sIJycbsSPfsgtOJTquTxOLphWEXr7XaXUcpYnaQTRTIN979AzX?=
 =?us-ascii?Q?u4iAzb67QybKBMGai7l+S5ADlUc3ssupIVULSpl2VHrapdccPeowGT/5ql9W?=
 =?us-ascii?Q?GsvO05FO1QKu3rnYfWffQXAlxyX1vo3ijteuQ53PIGZu7suIHGwz64vDMErX?=
 =?us-ascii?Q?8Rjb9kHio4cITg6l3FW7fNgBSjpJv5O2z16dJcTv51cCTHo9NH7lSsnLxQff?=
 =?us-ascii?Q?/bytiE9ulDLxSIn3L1ZuV2Yu/J5F0erHBAcxlVft4Xe7nyyAWiX4XF1O4hOt?=
 =?us-ascii?Q?NI9C24fJJ+Zp2B3Futms9XNt3z92W00E470DLh/A6wSzfisI3tWBN4ty2jSW?=
 =?us-ascii?Q?tGQvvJfo53r2+mc8O5muAX+zOJDQuJnAlqtDM2+DTXhF4AFoILqwaQrLR6L2?=
 =?us-ascii?Q?m9+41WdjyMtmoe2fhrxYEpiW23z8WfBLD/IQs2ht3AmgoqJIOLbOknjKGegH?=
 =?us-ascii?Q?KOmTluvufJQMGUgo/nBXS9oogZkvLeCzbB6uR2vcZMYXxSBYwL0lln0S732H?=
 =?us-ascii?Q?q9c8GO6Xa4aSZpe9+GRzBjTNn8Q6y9OXti68Tv/sFlS9ZjJr6C8p1G74+znF?=
 =?us-ascii?Q?NvKywqrfAyS7H73cTT5USTDEm8i+PfeYmcWWaF0brsfND+jl1XLSDmssMnh2?=
 =?us-ascii?Q?OsKVm3JMBlGhs5EnCQMH0zixIfuJSpZwD+nRwLiassH5NHj9bJ7rtf8FOXig?=
 =?us-ascii?Q?p2EiJtJwKun1oHjTsbOGJtXIDtXr4uXdSdN6w76s5zqBrGbNGMERMLb3Tkfh?=
 =?us-ascii?Q?inSAt1UFbP+Ui1p7ZdQyVMpAXyvJqTktgoGn0cdj+t3WNY70aGCE9y6BYNlV?=
 =?us-ascii?Q?cNtCDedLj8BLXZO1IVrfqb1QX0QJD72Xgp011JawA/uNj9besCCEJY1hs6qo?=
 =?us-ascii?Q?qMhH4CSDyO6AnbfUCjSOWkDSMZNmMYphTbi7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:25:53.5195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb66e289-a5e1-4bff-d169-08ddb8b3917c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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

We can disable various queues via debugfs for IGT testing, but in
doing so, we race with the kernel for VM updates or buffer moves.

Fixes: d2e3961ae371 ("drm/amdgpu: add amdgpu_sdma_sched_mask debugfs")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 25 ++++--------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8b8a04138711c..4f98d4920f5cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -350,9 +350,8 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
-	u64 i, num_ring;
+	u64 num_ring;
 	u64 mask = 0;
-	struct amdgpu_ring *ring, *page = NULL;
 
 	if (!adev)
 		return -ENODEV;
@@ -372,25 +371,9 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)
 
 	if ((val & mask) == 0)
 		return -EINVAL;
-
-	for (i = 0; i < adev->sdma.num_instances; ++i) {
-		ring = &adev->sdma.instance[i].ring;
-		if (adev->sdma.has_page_queue)
-			page = &adev->sdma.instance[i].page;
-		if (val & BIT_ULL(i * num_ring))
-			ring->sched.ready = true;
-		else
-			ring->sched.ready = false;
-
-		if (page) {
-			if (val & BIT_ULL(i * num_ring + 1))
-				page->sched.ready = true;
-			else
-				page->sched.ready = false;
-		}
-	}
-	/* publish sched.ready flag update effective immediately across smp */
-	smp_rmb();
+	/* Just return success here. We can't disable any rings otherwise
+	 * we race with vm udpates or buffer ops.
+	 */
 	return 0;
 }
 
-- 
2.50.0

