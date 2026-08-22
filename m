Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45642C5DF97
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Aug 2026 10:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC91610E3E6;
	Sat, 22 Aug 2026 10:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkQMq7L7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA3D10E3E6
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Aug 2026 10:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJY59T6rAyK/cIT4J9xmef0n60Ts5eosF9i/jz5D7IMDsSTp70QWLfPEDtKKtafsWTB7r4I/cYcAtw6Qh2ZsuMPK0+u5S/AItN3xBZZqbcso1pB69cm+JWoB7r0jyMulXRGrZ3ahp2fYixuPkX+TUmdENfOKblEckDrpJ1gMIg2PwjldUwcn1Uk0xj65ZUD+jVgLHTewuVuJMwX3W4W75Bdi+2JyMmzfmD3YUJeNrVHpO7hYaV5maf2fb28fhF7EOhx6486p6BKrUgUwimBUlXII3Cxwnq5JeKL+uqGKb1L9jUuchEjmO7iQHSl3gGqaHjXbO4pwuExh3t7uqq/1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EMky5BPQ7GcQ+Qdq119lnZc/324i/sW1/PW3lfXBrA=;
 b=Q4/7/n6p5Ad7MuMaEYa0VlFRyvGUF1YFulSANRy+DWDb/GhPiMZZgsrS3I81osRTcvgLpGDENU93rDpU2WMUlKl4jU4Bx3kJP0u2HuS0CQrogFpIvGGu9MPieL7suNjvyi2/rxk6ROFTFaVIJuUzmdRulmH/mitSlPsnt0UMa0lTEAftQvJhwMN1fP6d+BWscLGlDvYs7Wsc1b2qb/wrFaS5hQcUtPW8lkDkF0pIzyYh/ARjgghgSAKlsgXPjRjO9LFnz2XrbaLZgv8OjY/cUbNyrqfOL8mRN9+vY6x5CGpMroSs53wrC2Le/l5dVyw5rXsVPcIXT21zpZkeDunucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EMky5BPQ7GcQ+Qdq119lnZc/324i/sW1/PW3lfXBrA=;
 b=MkQMq7L7nyXh4+VFDnGaijy2ZMkMZrDlSdmdKMVs/I2aI2Xhyxkp2UX+5fezwWMGWb41myJ1F4jI0CMuSi3KfAQkCIZKJxGMM9xUMgjNqwGcZc/Qsvf5QO5mpAMCnvaCW6eGkN3wui7e9kj/Z8yvr1OH6W6o5UzjrTDePrXRbPc=
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 10:26:48 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::2f) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 10:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 10:26:47 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 05:26:45 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: drop the RAS module state when its sw init
 fails
Date: Sat, 22 Aug 2026 18:26:09 +0800
Message-ID: <20260822102609.84913-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822102609.84913-1-xiang.liu@amd.com>
References: <20260822102609.84913-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b06644-31e8-4401-dd7a-08df0037df3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RZGqgzNV/PMsRctqjr2nRzVB4IwchciLhgSNwdyBMyz632wO98eezCbFHwxsh0IWn33Md2I42ki5dLRg0SnMvfll8QIUUGQwSksh34TofZqDwVoBOv7mrCiGEemE9x+Dx0MVagX0ohgbf91BbXxkMM0dwtgqKGm/O/iKLXiROKB9H5EX/Sw15Uf7Yync5U/cf4zQAsbxJD4kOb+aTn62USv4L4VQOsv9fj6BzKrfeQjUTUwFXMG7Ws90DE2aBAYxBKBLfcJtD3EU5/Ya+05VoFWcDuzeUC+4SF7RBAECGnUeLzTPZpF0GdtogIjTqfdJbje6zzAjqNqmQ9jvh2mZIJU1Idv5YLZHYPNh6P1Qwd2jTMZL5xYNAgiQybRwbPdDMnPVlezUjwXJGMOfQGivi0bCWBuQ/pK0zsj8qcvqP0ga6IUn4SbmXRMSl+cni7z4NhK0Rdv2flYt76PsH32Ys/LAJErWMY8szv32rLRLxq7MsUmrCUIUyJWLjsBX3CY3fUT00Fzaw47FSBUKII6z4lZ22ZZHbPIkh47A4+Z5fqccI9XBx7PVhTTjSHyedipmNBMzbitaSfjVhoSjUhQT62E7zRk2rSNsMLgga+LNymvBf3ERj2qUN+fgUHx+ZnSganjOpVJ4fkyF4W+kH0amq8j8vetD/SP+V7eiCSDsPDC5F0SNmk/X7k9JiugJOiLpNhXsjeEwudTte57Z8jgDMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HmV9CNaoTZL+3RBt9AjURUGu9PP2YfRyT1qJwisWRVVyMiHwHee2Hb7qLsb/Tz8pz/Ku542/m+Y/PrC83jgHuk7eF1J3L6epalMQKerFhbbN1DtpKxtZMThcu3SL/P9jkMS2D5C7MgZNTIQW1O5J0/F6iIDHcofsN3mEhch7jk3JK5Nb4M7JsOVCyjV1QT+1YEyzzxQo6aONX4sC2bzbGyWevDApfh0+DPrGysUVYB9//HYE6TTb2Y8a+gSAvhY3f6OhHu3qRYohn2qZlHpeEkN4X8Mu27RjhXSXQwEZaf9X3mdWWepS7RgMqDPfthITgg8DD/9xlXqDHbu/1LDpViIkTX2YegwRGcB7F2Z9KczGaKPt+EVjRInCBzYt3EXXEmQ1/fmz4sqFBCVKAf3B2hV/FST6yi4E6M3LhOUyZZnBPibYEDxdxVpvpCHVCx5o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 10:26:47.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b06644-31e8-4401-dd7a-08df0037df3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777
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

The failure paths free the RAS manager but keep the flags that advertise
it as the owner of RAS and of the RAS firmware load. Every entry point
gated on those hits the NULL manager, hw_init turns that into -EINVAL
and the whole probe fails.

Clear both once the manager is gone, and route the allocation failure
through the same place.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index b41117deb5f3..a02167397ce2 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -337,8 +337,10 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct ras_module_param *
 	con->uniras_load_ras_fw = true;
 
 	ras_mgr = kzalloc_obj(*ras_mgr);
-	if (!ras_mgr)
-		return -EINVAL;
+	if (!ras_mgr) {
+		ret = -EINVAL;
+		goto err1;
+	}
 
 	con->ras_mgr = ras_mgr;
 	ras_mgr->adev = adev;
@@ -385,6 +387,8 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct ras_module_param *
 err1:
 	kfree(ras_mgr);
 	con->ras_mgr = NULL;
+	con->uniras_enabled = false;
+	con->uniras_load_ras_fw = false;
 	return ret;
 }
 
-- 
2.34.1

