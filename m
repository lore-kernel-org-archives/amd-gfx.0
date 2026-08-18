Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09817C5DF88
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC11910ECEE;
	Tue, 18 Aug 2026 20:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZuKKQMYM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC7010ECDC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCC0wYUMDwdS7/88SSfNgTjHLpWSp/+h5hg/VMsy6utJhPJmqqDr2MoAw9Jwvrir7CtftJBeGGbud721V9dmc7rmGrrhskZyJRXLDDiEjZA+/itgvTQ8OCUuxA1sc24TjcpSHi/DTarEk3aWbizkWp/wtR4aw3gNg7pifjqFFZVS1439AItoofmf6Plfuh+B8/xI4nySj30lAl3M05yT3Ff/lbA2J4Cdu8GGaW1yReAoEBC2XDxkLg3ba5UEG5+TRrvlvFPNNRtiB6lg7s/myv7YWP3gV/s1N8ovf4ZKD94aBhycusCTuMRrAuWb0H1EaahSB+V+BAY19ivsrsvmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nnFM1iEcWdfbS48AcmZOsUpg6Us8dCZ1GDSKXzNfsI=;
 b=bX29LsNce/IZteDMKDvWP+GheuwlCPF2hTf96B/9l45S7pl4U6cw5IhADsC4rs+ySiXMjvCvG9shrcyTUujxBZnR3cwXAcNcf4vMVW5Duq0SS9Q4jTJQ/Q6PAL3kt9BagbeLfVyr31qKVrdWTr+NpdVmxINiUVvBwP7F7WFD+q/ISRel7oiCO334yceCmZoXfRBArq0pucNTvR/ifs+CAtIRMq3lXDFrra+94N5+cUUzV66WcDSumupZEkECLUF/fZjopnJ9HukPoOu0TQ/uBGVr1em/NILsfnF1ZN233TW8d1VTQAfUTYXxZ/RSszmZ2RaW2s4EpWLZ6NoYU7qMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nnFM1iEcWdfbS48AcmZOsUpg6Us8dCZ1GDSKXzNfsI=;
 b=ZuKKQMYMQrjEsugNPFYmAJgszbf03lTZN7ygqnSYSFuOg+cZBCDrW9hBoOIsFTTA2Rj2v7PUjJEHxBJHnG0sBpfVtaHzO9v4sTNBDzBXsxORvL2E9beiFJJI8eC+9syIpuzEYzIzWnRyDnJLKV7OuTR3oEVFL9O+qUYN3ZctyI0=
Received: from MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:58 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::65) by MN2PR07CA0027.outlook.office365.com
 (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:55 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:54 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 81/82] drm/amd/display: Guard amdgpu_dm_irq_schedule_work
 against NULL irq_wq
Date: Tue, 18 Aug 2026 16:16:13 -0400
Message-ID: <20260818202139.4172592-82-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: bd21ee45-2f2e-43fb-0fe4-08defd667cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IurHzi25wzYuhq+FslYkLvSJA9D5E6Mar1fZrNy+Y1bcq0nr2ca91ko1st39Lh9QryPOJDOZ7aFaWsigOGAiXc+uJTHOkEX6BklOIGkYI2n6VzFrB0tCJhJ2kEn9fL3BimOrtHPUbDhpPXipEjtd82M1/KPXoqEqouYF3XcWgpJOsD21+W1bFK+4iRO/4CS5amn56gioLHid8hbOjY+KmhZx++NcesPUQyj3Xd3Z3WlQ3gRU3eiOV9Q6NBPsDFwxmZkaMLQjcDMxFUH++DIprDJFGQO4geuPPB6f3YJd96+73ie3x8TW0OsOTF9W1+JbXk8D5Txxe4A3wf8nQatO4Ctcod0dQyZ4kRPGeZH72KEv0OFDBZpu6pduI95qwpuWdfTz/Gvgy33V8O35U8Iki7hnwcBU/sGzR96rW/7X5daIGH5d0NYrMuxW9HwsvzcFB4+/kMqWjSURvK2PPbUzgndNwaqyNl6jYg2lGbMNm5AUKyq3SmXiDqo7oZ//m+XlKnN7FfvoFLTrSJwtAPoHNc7JyR+pknOVZt67Hs3ZYz4GRY7tp7koLhHH+S1r5S50qZM8b+PNwO3GqTqfKkmhMSYMUzdeZUFa6SMhgOSgraYmiWcNbOFnidMWn9mJ6R5+zoZ0NBd6CqrUP3qD0lSNIaCs1JZQXNahOkqatyYZ63rUpIw1B1724LD9VFtNMzdoD+vwRxs+PI5IrEzAyLJhjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wnV8Gbxjxajk4Y2i40GTfG0KDiBULC5OFdXNf1CI/3qkbdglJKwGi25FNFOvAy2+/L+GkIur6ZcnZmdcEf+M9gYCQFUObMATDKXPqR8Jh2NBcEcRqUUd6OQ2ejfF67pGYI+pSepnkJ9SwDUtOWHO+jdcZH1/wcPKolP2fJphZ9XNDVPkGPvHMSRF1RGhVa7eO4fSPOaRfesZ9qvBoKtBdE+T3A4vZp+TE3xmrelrW92Id7Rv+uXbHySCt9pCzsxbjGt8LI47SO3zrkYOl34E4haYvxfILI8RHgvvfDgAIiXd4kpGPPoo2hf1uIGQfApdo5oRowEno7QfYiQl/0KqWRuI9Jd9JRJZZrCfa1s/PrRTvjxzVL0zD1BM2pnYcVFWhBW6Hyo4m2GalCHxwst3oHnUW3Dds5OzgqfvbY6kUKEWFKIQglKelQiDgQufVy+2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:55.4151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd21ee45-2f2e-43fb-0fe4-08defd667cbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
An interrupt racing DM teardown can reach amdgpu_dm_irq_schedule_work()
after the IRQ workqueue is destroyed, passing a NULL wq to queue_work()
and crashing in __queue_work(). Bail out early when adev->dm.irq_wq is
NULL so a registered handler is simply not queued.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 9be63996b0627..560ff697ff950 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -618,6 +618,9 @@ STATIC_IFN_KUNIT void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 
 	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 
+	if (!adev->dm.irq_wq)
+		goto out_unlock;
+
 	if (list_empty(handler_list))
 		goto out_unlock;
 
-- 
2.43.0

