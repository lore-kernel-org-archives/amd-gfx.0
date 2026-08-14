Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0956C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A1010F6DF;
	Fri, 14 Aug 2026 21:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fzynzIQH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629A410F6E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrjRTLVBPYbv9FGwS/PkUOnNR+dsD6u+VmI6BRf6bOqwpcOB1vlWqszN3QfZqoTnPg6b7f9YWED7N7ajetaFtTLv2Jk6Zm9cDfLhXwGpokcHpdSshV6CothYACUNGqEcPucA8ojaCGTB30WKO5QR2RtgFedty3gyWnBu8Qx08jnToZW9Yz8uqb5mTNyM6H9P/2ziziIhqKFUujE2DSY4r477m4k3xgJ9Fb9sjWVE/XlqszvS97jkzDnhUEp8Edyw6rZrwqayXRGqh/ZylTy5EQJIdL/mOxZakAcUZh9FSpCWPhjNDTx2ctQVRBwA3yQgm45nxsJbgB8SOTuXdEKXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgJFEaQnuxL2EZR/bYVK60eWbXbFbnQ+A1FnfB0Hg1g=;
 b=FuuwQfirKimOwLGKH3s51AlmCYYTAppuRn6Ifr/cqpAYgVPmjFwMy8THl4kSVfBbcQmXg5jnNiGwfbMCFhB5lVFTcM1RTzpzLX0q38RAcPAdfcJ398uYBkai3ff/C2gIuBpgYMzbsMNyIGUfILWZlV93cSR4Xgikp5eCAW/dNTo06C6jY/yfMujVMjw1oCe8J72dVqqBHzW26mu8ho9gzabZx8046OUaSNckZOFU5lJcITWZKRnpfolFvw2dJj2rOz7/QwPXH8s4DB/8WNn4tMweIAEnMnY8bADvg6Q98NGSjUp7q2yQMJOx2gU+2vFe7etZWsz9HFNB0hpXFwR0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgJFEaQnuxL2EZR/bYVK60eWbXbFbnQ+A1FnfB0Hg1g=;
 b=fzynzIQHVcvJXIUWDgIQpzlUyrwOcRtYUkUm3iVaz265q88WQxcpRfI4sQKq8mC/xLKnJcXwBEy9urHLcrBMhtuka8W/hmsK5NNtk+pVFxeCl2m9ROk0XKpzwKdM9/RrJnzwqEY4GzVonMN4+WSzGp6T6INC5uucyAmbvmJnldQ=
Received: from SA1P222CA0031.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::11)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:15 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::31) by SA1P222CA0031.outlook.office365.com
 (2603:10b6:806:2d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 015/109] drm/amd/ras: add common interface to query ras
 subunit version
Date: Fri, 14 Aug 2026 17:01:12 -0400
Message-ID: <20260814210246.3067612-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 72790695-1bea-4204-7c3e-08defa477559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9TEoXwRKdDGeKAMiVhntmwAZOD++KiNSSIoxuR0Cebbo1bQBgp433Bmp9pHaAgnmhGC9KLFV8RWq3ISXjIjSnPmkboDmvAsylLmOGaH60nFbnQpHM5i40paU6gqI2gmD/qCBRhvvJJrCjZek+tPgKq+EkqBy4kLdQTX3jiZDFQnZ9SphOS3LMKQ3ZRChlvgj6FWG/Kz6qrfHcp9KT7w7tTeRwF8avMsrSR1ioLaHD8PxorUd99uHX8sV3jojLOYKj01YvogFG5F8YwT2qNLLZ65M4yesbsQzjmWGtD2fzBY+mgXM8eM0J47UfIcN9L8vd/3G5cz9Tt/HES64nQ/LNwGWz1dtqRSCVqGgazCGUJLf99goUoKv09neSEMmD+Tp+Vwu5UFJQsuNp9ZVL9GFE5tL2iCySjgHukDuB6VEM2ZPnS3wCF7cH+SiqCuQeIJ3b7Tp/NYnlybdqGqQ/MOLhuNGTTB2ookcS5H9u5eIcWZ/OniDGA3B6K5vm18k+WcWYiv/RgQoWKl0pD5QLL2VYJ5LaT27xctkuxuF8TEqvpJnB1RlJ+RzlS1ljD/XiANV3/UQz0qlvTFxXBXg4+oqK6J90NaibgnNH24xim9FNvz/OWdCuVJVxuhCVAxjQF1+89z+YV/pLpVijugn73EfJzZ3ybmem0FFNt+hgI8G6ijYAeTlZiRsyGWxRg5oodWFzncSh0mpH3k6NIezDmBO/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: embu4hKYFeZ0zCw8uIE1OXUBJNL6Ka27t+DhcO28EIhSmOswFUJKljHcMAj6Vonty3/5Cu6oQUxb6JoLwPuwGytYJv5puQVGHNqmLQez4xYeh0GIAHxsFtY+WO/GEajDXaMS/RBjgMiBPLW1W4MizWaSxkz9RAI/pJL7ur0NDdJTfi7tNWObndCFfoxTRutf+JH4OBhVhleQ85+iEXmKasxShM1GCAUQpIm8H1G7saMK/tJnmUSOhHMdl5lq19vAALIjUbRC1HQ3ziOU7o4DgWX/TkcoqnhoGesSRZUmOUS6uJVeUp6Q9r3OEsLEDtLFTQvvRxssNT+HyHLDJggNQYYxHiPFmO+2UEho8bZjfVCOrMMawRb/pl0Fa/3W3xt/ozM/sstqErAji9y6bORXNCR9KP2OpH+X40X5q3fBQ9v4YTPrWMZwPFMz/fjTKwji
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:15.0951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72790695-1bea-4204-7c3e-08defa477559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add common interface to query ras subunit version.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c | 35 +++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras.h  | 13 +++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 3a56abce59dbb..ab5a287a83b51 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -715,6 +715,41 @@ int ras_core_check_address_sanity(struct ras_core_context *ras_core,
 	return 0;
 }
 
+int ras_core_get_ip_version(struct ras_core_context *ras_core,
+	enum ras_unit_id unit_id, uint32_t *version)
+{
+	if (!version)
+		return -EINVAL;
+
+	switch (unit_id) {
+	case RAS_UNIT_ID_UMC:
+		*version = ras_core->ras_umc.umc_ip_version;
+		return 0;
+	case RAS_UNIT_ID_GFX:
+		*version = ras_core->ras_gfx.gfx_ip_version;
+		return 0;
+	case RAS_UNIT_ID_MP1:
+		*version = ras_core->ras_mp1.mp1_ip_version;
+		return 0;
+	case RAS_UNIT_ID_PSP:
+		*version = ras_core->ras_psp.psp_ip_version;
+		return 0;
+	case RAS_UNIT_ID_NBIO:
+		*version = ras_core->ras_nbio.nbio_ip_version;
+		return 0;
+	case RAS_UNIT_ID_ACA:
+		*version = ras_core->ras_aca.aca_ip_version;
+		return 0;
+	case RAS_UNIT_ID_EEPROM:
+		*version = ras_core->ras_eeprom.tbl_hdr.version;
+		return 0;
+	default:
+		break;
+	}
+
+	return -RAS_CORE_NOT_SUPPORTED;
+}
+
 int ras_core_get_eeprom_version(struct ras_core_context *ras_core,
 	uint32_t *version)
 {
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 3e0203d627985..af19a0983fcea 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -151,6 +151,17 @@ enum ras_fw_eeprom_cmd {
 	RAS_SMU_GetBadPageMcaAddr,
 };
 
+enum ras_unit_id {
+	RAS_UNIT_ID_UMC,
+	RAS_UNIT_ID_GFX,
+	RAS_UNIT_ID_MP1,
+	RAS_UNIT_ID_PSP,
+	RAS_UNIT_ID_NBIO,
+	RAS_UNIT_ID_ACA,
+	RAS_UNIT_ID_EEPROM,
+	RAS_UNIT_ID_MAX
+};
+
 struct ras_core_context;
 struct ras_bank_ecc;
 struct ras_umc;
@@ -412,4 +423,6 @@ int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable);
 bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core);
 int ras_core_get_eeprom_version(struct ras_core_context *ras_core,
 	uint32_t *version);
+int ras_core_get_ip_version(struct ras_core_context *ras_core,
+	enum ras_unit_id unit_id, uint32_t *version);
 #endif
-- 
2.55.0

