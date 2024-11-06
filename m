Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3725BD29F9D
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 07:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91A010E216;
	Wed,  6 Nov 2024 07:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u09//7Du";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7EAE10E216
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 07:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkyClQakzKhGsRsvI0U+na6+ckT0Zfns0RrkyyWRO1LLuRynsWl1DnCqCyhOjjVGI+3FDawngGQsVW4dEGGeAaXpO+HbjWixuY/q3sl1xcC8YqJdq0XVrpddIY6LEp1DV2WSBDWFq4pEWNYdEb3239xtjYuftrVWs2/ocXR5eh6H0WLeillgfT2KUWaF7FJE44fEEaOQoaYAbnINmbQHijrArnXpH4G1Iz/VaStB2GLmrMSKaDJ6nZUAxVVN69X56lY4YxcDkL2Xnuz5YiWYpcjcfU9d1mfPs57JnhrY95QbmzobqyO78OEOZcPZQ5ZX1jUPVKRh34VTb5rumBIRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8mOKkAwqOrzU7Yv8pfSB6q5CADQkiv7A5NNMGM0pPw=;
 b=CFjqZcyM3THWSyymQed+AUvqU+si3tsARFEojSyZCizi4WsRPx4o7p74WL/fQD8tpeUpZwxZZTsmVxlEob/6DhKlNkmN30ER/zyeoR70hYJNhskFGZeSIyhSQRf2WpdHt0Jw1C8dcGN2O470rbSCm0DteuX4X+18wpPJ/KA1Koul2N8l1HZNfvKegDJOt8V9S2RMMwbkZVEsW3C4SkVmhTcC4VqA1Ie3ny1dal0iBPEFF+q6G6nqo+b6KWtPtpV8sINLRUBM4s5kCeZeuF/ToKm6UnqLvWBsi3MiPsbIYYekWepcPXXxN9XLJcDvl1iOOdDsarRWL7EEXYWYt6t1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8mOKkAwqOrzU7Yv8pfSB6q5CADQkiv7A5NNMGM0pPw=;
 b=u09//7DuLWtgpr0U9Pv6vhkOWJxYCjvb7GJ4YT0IsftylIRQKyWLdI1qkTgzS98dBdfr3lcHvxiYUuyU3H+s4Qx2rHPNQJF38HJWVpFNYbo0jvBoGvHRbS8Me6qPkXF3oBFQ8hXAHCzONCX6wTOnF4xWkia5LDsy0JFOVDKv6rg=
Received: from CH0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:33::15)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 07:00:20 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::66) by CH0PR08CA0010.outlook.office365.com
 (2603:10b6:610:33::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 07:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:00:20 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 00:59:10 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: fix ACA bank count boundary check error
Date: Wed, 6 Nov 2024 14:58:39 +0800
Message-ID: <20241106065839.743458-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fb96cc-c917-47d7-d8bd-08dcfe30ad9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g4eUfyE2z89H0ClG89csbfgD6A+1zUduOYz6RUl4TfZYFgEzrCM4wj+j87dt?=
 =?us-ascii?Q?p85n98AIIVZJT6I6StX6pIXDIQi6qRiKze6/KjPlZFaFHw+9YoThzlcgKXnv?=
 =?us-ascii?Q?oJWlldqiU0Qxf3Yqc8A2DAfS/SE4y08oYtyY0N2rnyxSKqzz6BDLQSJNjlyl?=
 =?us-ascii?Q?rIQxElal8gnBdRKilNYkEgKG5NRb3thVOop2/zSh4QDlTlyE7iX+vNS84/41?=
 =?us-ascii?Q?kRiq/JJllxHFfyxy9UXGqqCTB5yXwXvHrSCDu/rwkE2dFMFH+s+wCZyCGhfe?=
 =?us-ascii?Q?1eySpjGvznKf/8aIRzxRfLsGRw2JnDONGlR+rOPq6duOjDF04t4rESm0plPV?=
 =?us-ascii?Q?9ShfigaRzq8CxugqqNTzsZu4WVxreG3Jy+s7VwbJh9dh3qQK8aPeLxsxLjW7?=
 =?us-ascii?Q?zrfQY0dI+LUNclvBTJtgccl8koBpXTpxBQh/7FtjtUu+JRqwYvTMb29UB8/9?=
 =?us-ascii?Q?9RGs2rWbySJOxGXPkf4yw8klPwwAR2RubEHQ1jI2Dsu+2bjQqY+yCSwzZSjL?=
 =?us-ascii?Q?9L2NCL4i0P/bGNAdF8yIhruisKSQ9H8MAIi5vYzUhFBwKx/9tp3v3gMyZrC6?=
 =?us-ascii?Q?wGSKZlNC4NLAsrb3gfYyJwhZVPcqQ0Hw0YtIvuNqHRKo6ddxFTh5bIn16PCy?=
 =?us-ascii?Q?vHHEGkZpIY0R8tjBnfkbXR2EJ+D13bvQUKFk1E53G24EihTFuYPG+2fmSzMG?=
 =?us-ascii?Q?05XKnKP2Q49/K5FDyCr3I4M9+Cc7F9TlXvMIYxN9LclqKb/01FQo7fVwEieE?=
 =?us-ascii?Q?JjYrLUMJbJ3rk6QvKWklUMHF/V4SwTXDXpCG+eQZ208+aPjpGoZRpuDBvj0J?=
 =?us-ascii?Q?YSO8ZrZXSaG3H9moltJchQChohHEtPr/UzSqF1kE3m2iP/je60Qmch9mmBEc?=
 =?us-ascii?Q?ARq7nZxKhplQZ1HMpqbS7Ig5mhwle4sX8q0EJb/HFwM20HoZ2pPGbMuJjfaD?=
 =?us-ascii?Q?CzKzHBN8wTYNwXVltRDoOUVM6+7F6Vgj4ygm2ZqpLpvS+Yb2x969MuMjo+Tn?=
 =?us-ascii?Q?RPg3kiFSdD3X08VvdfGpwvL66mqAgtbAuvq3h++HIaCWoNVp6zyYWbghbBnP?=
 =?us-ascii?Q?HG1ixLkmokDDFXkG6qn/v7SNwWyY335yEgEKqav5RA5iYzKjC9Pkwu7F/vdT?=
 =?us-ascii?Q?lZ3HDIrWEn+Rld4tKm/j+qRJsvQeXJ1GQ0Rip+bTPN5UeTJ3nmRZp3+q2jL0?=
 =?us-ascii?Q?yrdtvP3mHQdkUeh4MwqpOkPzZ/qoaXKHBNcy93punSjl6WO1X+urKcHX6RhG?=
 =?us-ascii?Q?8NmSL7S/wYPwPVc959LkdOo8+Gvr+MtVeySuT5zuPp5h8oQCpIW8w7jJNMZu?=
 =?us-ascii?Q?B9Tr5Mof7rsw40OUVtodTtrKj2w/JaMWsQUK7GHJmF8ynwwBpBMl95RVc6J8?=
 =?us-ascii?Q?LQZG2F0yapIkvYeySUR7Z1TGiHbZOoiodU1imIiBET5TJItHQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:00:20.3831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fb96cc-c917-47d7-d8bd-08dcfe30ad9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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

fix ACA bank count boundary check error.

Fixes: f5e4cc8461c4 ("drm/amdgpu: implement RAS ACA driver framework")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 2ca127173135..9d6345146495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -158,7 +158,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 		return -EINVAL;
 	}
 
-	if (start + count >= max_count)
+	if (start + count > max_count)
 		return -EINVAL;
 
 	count = min_t(int, count, max_count);
-- 
2.34.1

