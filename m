Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C5BCD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5302110E0E4;
	Wed, 20 May 2026 08:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cuOjaVe+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D59E10E0E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhGQ5rm/jvozcoKiRvZsxWraYbxi08L3G6jY/nWW4cd7/mtmHshJ3nkKPgT8Quij2IF4EzJydvjFZgVSKlsPuKAm+Urs91cHwh+kaCp8vHCCbJAY8RSkQVq/7R6wdKO9VtKKj1CnOsW4jYh/BTvplGbNRF5nvoLvI3sCa1J44zZMplJTEdFGYMJFL8a9RDioPwrfkBEtk+Xds2TwHZO8hOggDGGTZZtsupxxyFkWriGeF/yo+qYxK4s1+PZgF5JZJUrDrmQe9j4VKmY3orL+PK/OMe600avpNiLTis0JjeQhA1+tFgc8tjn0Dthz9HMnQjq7vu/9TtOId80CKQeIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMmbNGTe71Ae8OR6Vv5rbRs5NSDJyNVc4RdNZCW7ni0=;
 b=XVH1vMPDmVadnMwwGv6sA/2V+k9c8WvRYpjDYwR4NVhq8HSU3O1ixcj7fyHjd6YDvEv+StN9GvrThAcGPPlDqzeXnpvKue8t7VYjBDowmUdjNm1SyPH2aDbjaH3yrbeM3PnFkKvLrpLbh+Wu1XpjvFPFbX/OSvVy9p8vd6hfytxvfhsCCNcKmOtx4vJlbCv+7HSsDAEmQE407VN4k6mzWhN3lXW1peo7eJK5kOq43Ez5WNzkslqiBhFa82KEpnoWapL/JSgu1cuar4IdoiDkderXFJ9V5B67h8CsImvJrKxjZCjwKJaDyTbbrOO6eh8ml3WIGqQXPNTosm13J05XXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMmbNGTe71Ae8OR6Vv5rbRs5NSDJyNVc4RdNZCW7ni0=;
 b=cuOjaVe+QZVJSY7A7WDjyQvD9NIkz+sx7QvSk/kTlfVUzrWq2/2wZgScMW49JeaK6MRv5w5+yxgG/IWxv3rMSlWoYF2o+gtPe3mjaE/vp5IYGZBodYLc4Y5GHTuAcN5zoPGz5jO1Y2xp37yOQ3OqjaYuNxcCm3YV5bThKp0OOh0=
Received: from SA0PR11CA0139.namprd11.prod.outlook.com (2603:10b6:806:131::24)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 08:35:39 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::6) by SA0PR11CA0139.outlook.office365.com
 (2603:10b6:806:131::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 08:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:35:38 +0000
Received: from codemachine.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 03:35:37 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: fix buffer overflow during vBIOS update
Date: Wed, 20 May 2026 16:34:50 +0800
Message-ID: <20260520083518.191863-2-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520083518.191863-1-shiwu.zhang@amd.com>
References: <20260520083518.191863-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: ce949c88-8fad-4c65-71f6-08deb64ac57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1AIzEHJB2rayDNQ34lA8XThzuJJI5p+YYh5jRtZg8p5+Z4o4F9brnp/Usmtscu/ZvTvgeaEClkQ3gc7PxfBrEKd75xgytr0f69ROZEzQtoyVKIEHy0mrNcdjhPlcr2LwrBF1yYIMUNfaULpG1eAVAdCsUBi7MC9xOSGcorx27PgakMJrLirFYWHSgJOrEMqoHaCloDezpXwmVQqQG5CmvDM/ke27gHPqtbmxNdBidzvSXdKID3bCg1tameGZd7KnGWEsN1qx7btkfvJE/7rW1XN8bdb8bEtyHCWoqahBC7BtY77aODgfuYf0kORWdpAuJhjBc/LF5A/JnvLNWCbeAFuHTcu7H14o044363DmkQFW88ALQe2YKEicW0gma1oNtdIFCXhTtu0/WeOLCH/k7TKdipnRyLLb+hXMnmYTGOuL6XBiSfq+99jj0ZYK8h+OTk24RhxZ/bJISUX+VHCrLyBv0nI8iXPn27kEypzLTe9D6b6F3hYKRQexRWBXkQ4RV9l+hh1mvF5VK4KjPTfDI09tHUmijWPNP4u5vlMJcBgqNIAnpDHLwzJQdZLGiYhJOUvtAT7wFTRixBQcNGF83ppnj+f8si7+KY95r+940OLIJZ1Le7bsNz9E2x7agOO01oWwolJMdHFEUd+w2wrcqGrEWoYuStkOEQKPRp2sLR1Az24ZENojvyHsY5kmGiftcjw1eF2wS/xPtqIPi3ylcyIAUW+NA6431CIGlHsRaXk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KPEH8sNEEuf5fOthqvpdm+NofpZxaGHD8NOdvJSTiR/uIkrOV1qgtPRUgbt0m2K7QieD0uy+2G1/lBeGhwbs/5NJeV/91/tY+duxCe2ATCwaQGcKcBULKVXeHflCnDl/mzTr8JdhKCbnc3IpPICkGkTnp90f6lLNuKrFFK/3D/l8A6GJ1/qLYD1bxV2JSf7CIjzEfK6gFpGIoTIb/AOXb8I2mdmrrsGk46wYNuoCscdM/otcRuY8U+W4j4Amr3FSldtT/UvKuxgTiDlYYwb3VVx6yZT7D9PI+o2icTX+wdA0C7U7gIMWt85LC/YI/uFMe2YsUxDbe5bL2RGv46exB/FROUX8qqhGsJQju84o+EbI8QEARFCZsnhM56jdsyqnpyqk5UPooXbmiDX1W+OYfep4B/48gjPAl3CIK8S6oMlPjpXCLjd9NON/VoV9ciwK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:35:38.9638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce949c88-8fad-4c65-71f6-08deb64ac57c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

Clamp the buffer postion to write by setting the bin attribute
to the maximum buffer size so that VFS layer will block the
out-of-bounds accessing.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f88df51a2558..576372ead63e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -5022,7 +5022,7 @@ static const struct bin_attribute psp_vbflash_bin_attr = {
 static struct bin_attribute psp_vbflash_bin_attr = {
 #endif
 	.attr = {.name = "psp_vbflash", .mode = 0660},
-	.size = 0,
+	.size = AMD_VBIOS_FILE_MAX_SIZE_B,
 	.write = amdgpu_psp_vbflash_write,
 	.read = amdgpu_psp_vbflash_read,
 };
-- 
2.43.0

