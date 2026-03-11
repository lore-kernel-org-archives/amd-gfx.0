Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7E8FD88DF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA6E10E2FA;
	Wed, 11 Mar 2026 04:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UCedos9y";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AEF10E2FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/RS4cebHU6Zi1EWCx49pnn5d0CpnMZHIJLZChuIsUVlJwYV8WaZTNnsIsFVvhFAXtr9yTz+jEOYr7jCKYQn0hY5Vzmwxeg8yVaM1Gwf0uPZvxrLpH9y3TYwsVeOldNJuu7FHNTSIm2+Sgipt3MWsgNzXeciTLgT81F/vpIdlraWE/4HT5DlOeba3AAL44OJoqHvKxNtmWxSBwcmUWN/V4zdA1CIhkanlJMnv/VJMNTGea8p7slQUESCouEHHKIeKifAFVH7Egr7WJXhuEv9IvG4X9/AE6Qe61SdlvFqGmvZ3GwUuK7P5MnSxN/Oqe1crcTkHBvVCSduhG6dOcuWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cwl9Mq+uW/bko9ovd3ZV1bR+HDhlh2LN1aZ+OnikFY=;
 b=co2b+UykWE9bbou84KU77rv7toWh7FxCn7iJZboNHp8IYMUQ+7CDRUfj3L7v0gMgRKeHtgbi9jp7pKutLpWVLHFREoIqqAEU+czXLBvSRCrfFkHx8KisbCm5pZBqLjeZw1jY8akaqgZIXhfAXFydTI37bRKxfP+ZugKVpd+lB9zV/eajaYWtFkXY72Z+mJ1M6SyJ7zkmWjd0eWGHuhKxTOLAtwqCs84xtSLYySNT0SjyOfRKHJPGAFX1V05T2xuxzTQdyYxr0jQ717O9wjjVnm40Mjb8nVjkvznktb7jDmfYAIFrxlUyvpL18ZFJVi0HS4CFwtvnEebH09G5NPQiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cwl9Mq+uW/bko9ovd3ZV1bR+HDhlh2LN1aZ+OnikFY=;
 b=UCedos9yWhpJ3aGXNxcV7WSahB84I8SYWFz42aY6sl7TxPv9VZ9cF6Z/Y00BrzNDw8+m9hf5Kh+7Jg3PdScdfc4ofeSLWljigsfL3GlwMse6vywZAg3Q6zPUOkLxEeQZLHPfSv9yXfOrV4np6bqtB4T9sLvGCk13pUJkeIKSjX0=
Received: from SA1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::33)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 04:03:47 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::3e) by SA1P222CA0015.outlook.office365.com
 (2603:10b6:806:22c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:03:47 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:03:43 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 3/9] drm/amd/display: Add dcn_mrq_present Field
Date: Wed, 11 Mar 2026 11:32:58 +0800
Message-ID: <20260311040501.2693643-4-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ad5071-9198-41b6-f740-08de7f2331f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: tvylUw+2Y2JzNBKZ3J6h27Rml0TE42E9UTv9PsoFGCB6AY3zzEnQQ+sNJmpBwLuqV3PYd5u5wR8RVbgvU3kOPPDecSaRtJkBqU8tSTwBjVcRKoXHRzf084jvuOlZsHnYhwpHnDJiya5C53jKLVY6tT1bGdfKCzRWzYlDUzeZ2BklxF4BAYeVWUXwi+emWMpQ+b7ztUwbM72VY+BimtEqU6ELtzmw/BL8tE5n5ewLgNtyO7O8nfuPe6/n1TxGzJwFLepra8X4OSfZqLpK0E9lvOrH3N6G+pAm0s+FUUe1pzvQsSXq58U8vlK47a6GPszcd8ru/Iev2E3F0QkkQR17Q4bnBjow1La/e3gPodfxMtkdGhZV6zSmjRH8NsfLw1Wtu99Gl6wMjiXSvyDFievZ/71JaTGHZ4ksaoMN1bdJcyBGFb7vAKarYDQlTIJl46Y1WLzcoHqb5xHliKoNGRa3rs2nKDYMPoj70ggECg8RRXqJwfWCZ55JlDvEKc6H3cEzlDqJqnhonho1ZYFt4AsIW+2S4eG8n825xRudEJlpKWwSNfe+/VimWVnxrWzQTOgJ5h9V8GQyQ5nXgu8+w3xCcxogxKfk1RH8B+Dwep0RztGJXjLVPvR1NyTht8MrYv/tl5I7x5GFyiklZauiwcJsByXKf1iyzvsnbHRGFHc80giLv0nyESUxtCjEL1Jfv0FeJq/MPRLHGYt8q9GFegFdyu8wMQ8ClZiUR4sWgeEa2HKHTMg7vwl66ivfMCd1teX1T/wjhufbLF3pbxLN2ajCuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BOT46uMLgvmCZk6YyytyXd8lQU+bOVzvVBR7y+2Zkgue2mPH3rBERZY3PUPJcFerRti9qzFyHyLgQzXWMUFdmM1b0d0AcBZ6zVcaUFx1K3lGlVG5UgsPu9FKFg9beYlUo+lGn7cv6mWeu3qWd3uc2wxtB6eThMlLrzRRL46fkzk1mbMY0bMdMp/fT6N85ByA2gUAsRNjKAYelDjEKChaSdwKOyBU18DkK3U0U+zK/FUUp+15cI2C7vqUc/x26T17aIOMDbqdkdX2z5hbJlRqvxmSsQKD49YwStBZMi1P4laKkly1TOCTQ3koSIUg7b43btC7PcEzSxCgrOMbgZcAK0SkYwDwuNXVnFisE7sCTH+5yhVlM1ThuvoJZ8+f1NxFV0AGW8n14Im/g/QSOs7mKzgOCT1R15Dfrfssux6t1s5UNDnCiwpXIWh0e+RQZju1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:03:47.1412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ad5071-9198-41b6-f740-08de7f2331f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Add MRQ flag so it can be passed from ip_caps to ip_params

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index ddbb8dfa9ff8..6152155d6073 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -192,6 +192,7 @@ struct dml2_ip_capabilities {
 	unsigned int max_flip_time_us;
 	unsigned int max_flip_time_lines;
 	unsigned int hostvm_mode;
+	bool dcn_mrq_present;
 	unsigned int subvp_drr_scheduling_margin_us;
 	unsigned int subvp_prefetch_end_to_mall_start_us;
 	unsigned int subvp_fw_processing_delay;
-- 
2.43.0

