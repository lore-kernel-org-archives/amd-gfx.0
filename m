Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9873C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D46C10F6FD;
	Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CF4ERJwq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C26110F708
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzRqDiQi/srQaU6CkruPT0n8e6UNe4WP+uvAs4YdgT69Fvv5l1XVh6L2RpNQNBuLXfwJnOPcjcjKS+zGz02aWX2CX0j+zmV+nY11fGxrZxyhwn4FrTIVB9LefREubpHsIVWN49D/pmdTLJMwz+KzbBmBMFXXmAN6Z5iiJBPJCLcjY5uDLT+Magn7uQ5PFRT0V+BRmvg76SfzzMvjdka/UBz3vF45cq16jOSYcAj85BXmB+TkqV1FlyWnZAP4YIa9I8cVpCasmYVyL15bdFPiJu4CR1TwtBLAfYtKzp9cEKx6qCquXDPnvnW3gKj/3Lx/daI5OyznD9N7xo0Xlb8Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nLOG8Hegx7bQl/OFBnjFj8mIjZe9ymQ4lfJdViwCGk=;
 b=KL7f9MXLwM+fIcEnjsnHJ1kyE11WhH2zP4INFth9GhA615tnBz7krFz0TzqK+ZJVYdEPdTZwmlXvvINRCFKCp+9s0mYuIn2Hebt35XWpmp3PhcQcnJ1Sl5ZaBxDB4UbkLEw48BlF3TSukTgAh+CUhdw4JvAtNwEn5kLqd3Dz3usbUo6YJhAFc/Ml6vT0Z9pSFOr8xz2hJ5DjXVx44JRqgHLt8qufs67Gk0Y0bZNIyHIdE5UIXyvr/Fz4GC5htdIpblYyD9GGeO2+8jMV/PU/vzthEAoX7+i+hppbZVXqqzIkOgafeHb1gw+2hg+54QEBFFViV0xGh98BC21T7Un7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nLOG8Hegx7bQl/OFBnjFj8mIjZe9ymQ4lfJdViwCGk=;
 b=CF4ERJwqSmXtnlTiFign2ecYewB158qEnOE9bN9nR90cHSOsJA5EweIxvh3TyegaID8vtG7IfwGSiqrZ6MX369y60BsIoditAHOCG2EiAq7w4mwKcktHlhwCR3mkl9ja9CE0hFDs0BCTv0eeu8JuE6b7b0iqSu9685QccbArjqc=
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:27 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::63) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:20 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 038/109] drm/amd/ras: add helper to convert aca bank to eeprom
 record
Date: Fri, 14 Aug 2026 17:01:35 -0400
Message-ID: <20260814210246.3067612-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dee5b44-3edc-4ee8-d1a6-08defa477ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 34ak5BIqVxzrv8J0xnnLoBGxFNv6JcF2REIdw8AFYDYvAxhPKIOMyC3MrzUDc1ghx7OWel7lrfCpg1OBkJG/3DMS++yRwPJAVUtIF1wZ7NhCI/MOrInxQ5sNbnaBZzpLRyTG3h/wPxXX7TgeQsowUV+7H97uPMUtOB0u/mDY9ZebTNp6wY2hgQWT0/TtlP3Xh+Xh5cq3kkHUGRyzLA1c2jZNck9+0pzqU1jSuINIxCt2Yw4vEweE09zLIG/WpCB0JWLrDudM9QMRss3x8R+LruNZXdA1o9h5JdCYZqiHh/zI6sikRbExjJe6LSI8Tv1uN4ifpnZgcglUHR6+ThCI9f2WgAuNh0FZcbkyABXaOXQCjyyNjJnWGIa1GJJGeJZIEgFdtGdFxaqknlZkzCFZw2zFB9Hc/HL4xLPKaEPuHYgdRvpeJP5u/XPRvbza1lQHcTiTJRYcbXVaXIa7tb7xirrMDekTWZ5gOqRcp5FPjL+hD//1HcLNdH5qE88+PGus+oRzLA24YAgUUMzm8AYYutjexGoNMsXf5LXyvqRdUSS7lcvtV1pMqj2Wx2T7WWhgb95Mt9RwB1wnKcgCF2PLIvxiY4q2GcmmpxGhPgMmW4HZ/lrb6qRkTDkmEVvUOVyIcDFnAQClhW86MVQkuyDo3B11gUe3XMNj4XVVJX+qsJ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZpNYzC/ODpKckL47zClKjs5Bq01JcRi9pCpqpQUnTL3zkQcmmFRBR1O/yrDKFxcz0y4pzmiJBesi/qdJnEIyl5lN7Qn13HSVitvXSUsZz1mYn/S27ftThhCuOxD8PTUWR5L1ENdrojtvo7g25dPDnv8I3Idx4kyYWOFFmIK13ep2KLeO9UoscoVjs142ecGlVvHL25UL/Uu7IkCm3/HaZUyp5j/ka4u6V+SvJRQPYyveRAXxD2gYiVqaiWXVIer8HjxWugz6/Gr/+a8dxxWY1wdwUyIXOOrBneiHieonDF3YEU55MwbaO6f3FI7AB+oDMvNa5ydWPalMhuyfWzn8+9EkllBHzjF4GhpNec5aWsxxL3nXB5nRsFHon93cuCRbf9GQcicB95oRtvctqqND96RtS3AEeR58HTvBpASqWXkv1vfPqUf//mImIS1RJIPp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:27.3766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dee5b44-3edc-4ee8-d1a6-08defa477ca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

add helper to convert aca bank to eeprom record.

v2:
  Correct incorrect return values.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.h  |  1 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_umc.h |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.h b/drivers/gpu/drm/amd/ras/core/eeprom.h
index c46ce23ea6ee6..7eff0e5435d01 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.h
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.h
@@ -164,6 +164,7 @@ struct eeprom_umc_record {
 	uint64_t cur_nps_retired_row_pfn;
 	uint32_t cur_nps_bank;
 	uint32_t cur_nps;
+	uint64_t ipid;
 };
 
 struct ras_core_context;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 0237a4f737ec3..2403daa75f69e 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -958,3 +958,22 @@ uint32_t ras_umc_bit_wise_xor(uint32_t val)
 
 	return result;
 }
+
+int ras_umc_bank_to_umc_record(struct ras_core_context *ras_core,
+		struct ras_bank_ecc *bank, struct eeprom_umc_record *record)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	int ret;
+
+	if (!bank || !record || !ras_umc->ip_func ||
+	    !ras_umc->ip_func->bank_to_eeprom_record)
+		return -EINVAL;
+
+	ret = ras_umc->ip_func->bank_to_eeprom_record(ras_core, bank, record);
+	if (ret)
+		return ret;
+
+	record->ipid = bank->ipid;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index 1f257eb3e3df6..ed77fb3912d59 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -219,4 +219,6 @@ uint32_t ras_umc_bit_wise_xor(uint32_t val);
 int ras_umc_ma2pa(struct ras_core_context *ras_core,
 	struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
 	uint32_t nps);
+int ras_umc_bank_to_umc_record(struct ras_core_context *ras_core,
+		struct ras_bank_ecc *bank, struct eeprom_umc_record *record);
 #endif
-- 
2.55.0

