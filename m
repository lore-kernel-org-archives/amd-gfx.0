Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216EACD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40EC10F946;
	Fri, 29 May 2026 06:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ujLcHXb";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DDC10F946
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFXCZZbeyCpy9at3qUlD8gk/2iJSTBVJsKx69GPBHRvrTfco5scmlWjcDGe4b0wPtf5CUp13kRAAoLDNdn0bZUqkhgaxuFva5EbFa6xgKIdg8b16YGcNJXJ4GBSvcXzB6nUJiN+MIh6l0dJKZSf/X7vY2AB9cmDRNLdEpqb6ZBECav7iT7UYI8uIK1f6k4+5WmixIPVvBvnU7JHWr7TXKpNp+lssIJ+LHMhvJ8GCPiu+DFbrIp0YE8weK1V7BGJLOfBjCuOMM58n0KXFiLgXFjMsX59KzpKROjV1Hcz3rlaXN+P74/VsWQlyuiff2YJvHwzgaiph/ORbcXnW7dlfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+lQqJYDpMlqBoBYVN2EZF4FH6hrzpEeLud8beXu40U=;
 b=vhjzHhriQd2rQom/oVklSC30j17BLeX+ZxYpN11fqPuP5TKXsdbDokp864FfvoGG9PiDQOHVMLis2beJfUzyaiBtl064OZUFP8ZDPJOxkDVrdw/bs5CH4Gxky71HDiFFMoiGaAg8TP7eee+PdIHy+SZQyGYBdnnpHT9JHFEirOR+ioLFbPSK+97TWkRb4AWW6sE/Od9fZ6XHj/ppC02DVMKeYC23qETBPaAoH6G29fHrqczbcLaq9WvGkoc+Pfdn1LWMvG3mlpmgE8bATvl/LQ+ntTr2/nkh2gAqrNT6IVgLUVfwdxy7TSkQ06TiobA//IaAqTggTAVxBasqE6OHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+lQqJYDpMlqBoBYVN2EZF4FH6hrzpEeLud8beXu40U=;
 b=1ujLcHXbXTpExGx5cHti1Kuep1bQuRCUn41fxo8P3R4S6y84kL0Mq0TGu7aPJmXDJYAGJD28CAPPlKKaexX23bqK5evOsCILi9QA8M2nqL8hrGq4pE/GQ4RWX3ae//PJ+RlfTcMyl+3UHBPw11VAGNJBY+VtK5Pp6SH8AEjEqHQ=
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:18:27 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::1) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 06:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 29 May 2026 06:18:26 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:18:24 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Date: Fri, 29 May 2026 14:18:11 +0800
Message-ID: <20260529061811.357041-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b11ea2-61fa-41d8-888f-08debd4a188a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BAaurrChyo2T70gv5MJLxaL9i7TY+9+zicaF1TdQGZydSe+m8jFM0kGq52Yz0DOyP+/ukU1eKeqLOo/nzSryk48MAWaAbXiNfH3HkUafT30XhyPpd1FJeCtXlpG+29PuIB9KuZUpV3oy+LPfxQVaH99c1PgVMFcv9qtUg7LjwWPJRmCATCDxK9mjEKh/oEY1waSPFCZF98XYS2tSrqUK5KY+KEi6j4GXbEVy2E3eYhbvHN6rmb9aCmL1+Lw4VINucLsS+AR9pxpV7roMQFiUWcCyX8Uo551J1OgGDKcDmXv7Q0G9/ekVP6kEAsszmFvh8dajcVrpUzkfS8HplWpylG9bq0/rhifdbN7QE1ciYlSGQyY6Ycqu1VDyVZoCrdpNSybron+aV/NtTSf57/HPLxiATVvsWrxr3SIy7/ab1VKphdw1/6RfnofYGU01AnLswxZPjIPHngSaAr5g8pL7VtxCgRK9Kq5mGM9oWaD2jkBLFLlZPosR1/9HmG5kCLjcNIyh425X8E+ZwMTvMqoC4qT2OUYX0uDJc3bg/ZGAZ5ysbRj1ZTHdtBrWrMFulAQGLzZ12McQTL/btHrjPZ853Q2SIvxV3mNssRSQmzN7DSQ5z2psp0TGfaKqXfeCevOnVbB3C09S9kMRdlfPYb/sDnrDtnAlucsxvEMsDeHNoMCVQzFDZtQhrTkAdPNDDQ6734iuMAendXC8pDxYS7HLbHM8RgK6EAao+VJIc5yHwPA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2wMRiF6L2+2lUkxc1aXrsvuFv6jsNUF2c4BH/Vpqb5USylSR5+bExxDpMl2gjgeC8RI+exHYQQnSdq+3WIdPpYNH3QYRX7RSTL3Fzpd6xkmSdfmIYBApj5l/97+SMbHhHLcoBuyMbiB6x4viNGLUVjRV3P9di1bSuwAy7XUxE/R4++xlmZvdPoszvxBxVXCqCmQxRqc2QmxBwrgj+7InD3uvbe7q7VMGDvqGxDJIG03L9c0LKwiLJkOELjrl+XEgHxw7H8q9g0m0fl5JB+ImTnIAv5tyWaievXpXAldQ6sQTuXA4mchvqAgvGg373kaDtQHHkMqxfy8hNRZH0wxXkKcrI2T0TG4P1zxcyNqA/tBM102RF0GKcCCuQ/1SiRUvYNBfO8hFM0msH1SH03XOgxuSDWx7SXwE+E+Hyela18dNou5uDyTgMnZbr7bwHYOJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:18:26.9371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b11ea2-61fa-41d8-888f-08debd4a188a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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

After consuming the leading profile digit in tmp[0] and skipping i bytes of
whitespace via *++buf, buf points at original + 1 + i. The number of bytes
still inside the sysfs buffer is count - (1 + i), not count - i; using the
latter copied one byte past the store buffer.

NUL-terminate buf_cpy before strsep() so parsing cannot run past the copied
payload.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 60db9b66d08c..450ecb188aed 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1379,6 +1379,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	char tmp[2];
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
+	size_t len;
 
 	tmp[0] = *(buf);
 	tmp[1] = '\0';
@@ -1391,7 +1392,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 			return -EINVAL;
 		while (isspace(*++buf))
 			i++;
-		memcpy(buf_cpy, buf, count-i);
+		len = count - 1 - i;
+		memcpy(buf_cpy, buf, len);
+		buf_cpy[len] = '\0';
 		tmp_str = buf_cpy;
 		while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
 			if (strlen(sub_str) == 0)
-- 
2.46.0

