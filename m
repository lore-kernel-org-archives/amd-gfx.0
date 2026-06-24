Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BECCDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 06:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E73D10ED7F;
	Wed, 24 Jun 2026 06:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GNHql9aE";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B6F10ED34
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 06:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoNcOradCEoYlqJd9pFGVP1g396j+JAXVIWhobCtKBBcwDlnG8UII5sokCvcrZH+LIReQ06ZHZGHC0DoPKWGh05pLF1udfrsdiUsO4bymgRQbTEleIigVMoFyu61Q8udsp2ZhXK3UF8Q2EUg6PlSuAGnxc/HXqhN9yY1LjRzd+EUFAEDKTQSX4p3NjjIjTrNagDFnEa1rgb+h0v80Wyh+tdv0jzQITF4jRhc+O+jaJCg4J5aQ+xuwT0vszsywpRtipCC21cGpd3CUJX4ZmGiKsk+zr7jTNlPFFzYlkdDB0rxuDjahE2T7KvIkPKXwZD7FihmJvAT5A/sGOfBI6vlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf7zjRD2vrRzZjF2ib9wqLb/NnYqHgdyYjFxGYWpFEg=;
 b=EXY6ACJCrsd0QcDOBP4pFB1ZQxOYat9IxbrS1X2jnIrHA8L/K2wYOyiCmwuyhaqYIBgwtVcPMjFZT79A7SACZLSMXPaZwgdhE0AYebr8Lvuucm9rz4kJCRVO9QsxxjnZVEvOPt6I75XOphVAK/IUPKGxw/eHBGEQlAPnS2aBH5zzkeqS9zcICTyQW22odWNE3WdQbLvDuUDiBpAdsbVrESc6wmLQmK8Lgf0Ep63nST93Y531ebbcLHtxtwW2EdF/GbaaDMqkZ2mo6AmINNxjUnBGZ+2SK97L0lb/PcRyugfUEQjLEQ0fHZhF6Wkc+N++z2hhjMGeN2v+65a6SD1jWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf7zjRD2vrRzZjF2ib9wqLb/NnYqHgdyYjFxGYWpFEg=;
 b=GNHql9aExHcoZ8YaU5kgqeGFtW4YuHtVTEFZdh50WqIiQV64mfUtRKOqp7APm5crdHDuuRcO8uK20IcjG2SU2U3wkKAJGKmgWa6YXtR1cEN6MiAYGA45Lue2UByApAYGRC6FUUMfDnpn9+hZXBHZHwEDUZfWFFIBxs9MDKnx2iQ=
Received: from SJ0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:33b::7)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 24 Jun
 2026 06:44:38 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a2) by SJ0PR05CA0002.outlook.office365.com
 (2603:10b6:a03:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 06:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 06:44:38 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 01:44:35 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/pm: add pp_entries_max() helper
Date: Wed, 24 Jun 2026 14:44:10 +0800
Message-ID: <20260624064414.144468-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edb7600-20eb-4128-2ac4-08ded1bc1004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: snDm5a30foA/mVG/K+kwdvIjAbXOdXXL94klCPRtCkSYsPki8C3D7ZzkQSm/9OezVrLKz1dGXWKskPuXxioOYp3iOPzbP8TQzR6xJwgKT9v/mwW9t9NJ7XWPQrzl50W8Ktrlx3NTxt15DGWOtpnSPfaKyVBhDJQSaWpEweKrdsRHb4ZYvuZz2FSH0p8EpPpGz3H6WkF3VnFafFtnitGDE0e6MpcIqhNFtE/xrvStMnwNuJu64/qCUBC7IKdxBF+c8RM95saZJJrNSavmT9Rl6v6f7XxO0SOe8Zi5+leH9pA/CTEwXx7WRo3w84eDYvEpbN90q08RjxB7GzSC5lPj5wYKZ+xmw0P/3jwBfeEEV2wJvOpt8zggsPEdM6pCF64TKAf4iINz4fm66jMSDYtVwWpvg3+0Iqnv9YOIt+LYEVheFqn2WLloXK/G4Yf+x3eztz6vL2rAasjhLSKS2nNLWLEWUmevPj0zrDDmQ4lzb81kofd5HTzzpgnhX4xjsnLrHXsP3frzD09cbrfLh2+J/KZqCfkMIBT3/iCXQRlYe/TtzwY0LcQPtxbi5yrF6l+BLn7EXFqABsvE0VEQt15IejfNqpfwiZpD5aXm2gnUE+uDXCJlTiUKJG1EijnB+w5KyPDSFO2EinHuDqx2RFcRcxJMPM5ZAfds2tFMHi1ZL8g7WbCL3M9TGm/EIl16zTRPTQZkUIj6EQLXL2QatuJdvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DRvASNB2I+Qr41G4NnaCMTsup/EGp3o6Dk2KWpsmrj/3J25aPS/wQUAyA51CkOdRzAll+QFZsePSAApr3vwLLdl+cvbi6B5Wz2ZF80ZFNimNVd1x6z9CYO5NyIDvQOz/k/QoeV/NpenExb/1nDnnhQV8CEAdCYaICLUyuCXlgD6yetBihBtHP+sJd2KSBO6E8rb3D7Iydh/zLIyNTblL870CHl+DuI0T+4HV8TKKIPYIJhxII9R9Lrmsdjpo7DkUq0R+P0ouLm6WLBZHP/qWRC2mI0r8kf/seZOeouaR0omrhNn6sqd5adXyrhnLdORXxQafTHpMjBNpX2J6ZcnttJ0swb5BZNeLcMaIo44OZSmaRv7fSaPubDnax8y0ZKnp7I+Wwdh/BDDUOPAPtehDkTdh/SNYjHxhxipvDzMISYP52YPxiVYG6087zmOhfDgT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:44:38.4604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edb7600-20eb-4128-2ac4-08ded1bc1004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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

Add a static inline that returns the maximum safe record count for a
PowerPlay sub-table, bounded by the lesser of soft_pp_table_size and
adev->bios_size. Uses adev->bios directly to avoid a dependency on
struct atom_context. Subsequent patches use it to clamp ucNumEntries.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index ca71efaa1656..7ebc1344023f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -829,4 +829,21 @@ int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
 int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
 int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
 
+static inline uint32_t pp_entries_max(const struct pp_hwmgr *hwmgr,
+				      const void *sub_table,
+				      size_t hdr_size, size_t rec_size)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
+	const char *bios_end = (const char *)adev->bios + adev->bios_size;
+	const char *pp_end   = (const char *)hwmgr->soft_pp_table
+			       + hwmgr->soft_pp_table_size;
+	const char *entries  = (const char *)sub_table + hdr_size;
+
+	if (pp_end > bios_end)
+		return 0;
+	if (!rec_size || entries >= pp_end)
+		return 0;
+	return (uint32_t)((pp_end - entries) / rec_size);
+}
+
 #endif /* _HWMGR_H_ */
-- 
2.46.0

