Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D199CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B2610E887;
	Wed, 10 Jun 2026 09:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="muFJ8W5T";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DFCD10E887
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vl1pY4kEhEUvlovWD0YOlTycuPuGI5sn+bKn/DVjfYIazQMqUjPeN8b5hSkgOhjhjz+Qu7JPFO1RXk4V2lgOhUNG1JiSLYwsJ3XYFR4K5sg5yc3wkqSsWFQrO1/i8vlpUduGy3164y1+tnTjl67QAv5lGSK037CP6gboLDpiWAqG76/1LVA4ywKnMTg8Jj2KHIlzDBiiyJg1D9F3fimlJHrd+hONd0x9i3oF0YIRtjToKKkhtjz85Lr4ssmkLSC6pAra3cliffGLmIEa8nJoBZeIujCBWP+YIDIGJOar0ejXRfHrKoRvUnYzx3zfmNaIIFvuWFHCbsMSbRj2FF022A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaZqxtTGIR1MYxay9rPoXpbUUYYHAmJU4D+S0+6UJAg=;
 b=sZyZCRUoxapisRo8SZZG1halvVCxDGNiJR12v4QBR0BvFGlJLR80xNWf1mxhWcnqTeoLAdEnr1hmHBKpqBK3wWidmhpOsnjOTNPn9nE2josAC29adhEQQASopACMNqVgMul88n7qT+LTxWG8Sr8nv7HDgBBfb2vc2Lct9ryHtOMn5EfQWmnFQm7maZCSCiHcILGnsqg5bdG8QR/NSXuc/Js9382YE0+YcF3uZhoGxBn2ntF6mNo15bXdecvKa4W0URXr9WcTYjqDUKa/QGV8Hcz0AlDLyNfvORSN7iesWSxjF2DQL9zfvmMXSMb3cNFydN+2DtOPxj+RolpplZSHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaZqxtTGIR1MYxay9rPoXpbUUYYHAmJU4D+S0+6UJAg=;
 b=muFJ8W5TDNhZ2a6Tw2owbWhsgbGlM10dNVxLLwkBomKCNrZyJj8q1IQoWVkICUPzmZDIDJbzZkiTUTMtIQ9ntdxEMGOUU6h3ux6R9eXCZhfpGdFYsbC4LYOzpGp6TNuqhTMMMOA+NsfP4xuq9Dh9rh+zCusVYO2GoMMfAr0G3Ls=
Received: from PH1PEPF000132FC.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2d)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:52:52 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH1PEPF000132FC.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:52:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:52:50 -0700
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:52:42 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 32/32] drm/amd/display: Promote DC to 3.2.386
Date: Wed, 10 Jun 2026 17:45:16 +0800
Message-ID: <20260610094639.1965367-33-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 55295ab0-b900-4e14-40f0-08dec6d60972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|6133799003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hDIZeFhmmdOYs/FjZZOxz0r6lAV9fGg2GLhfnyQnZg30O0N+pGPgGjW2L6UGIIZevcCQk6jZJ73E2iiU4uL8XznmpXB3tgTCKeAoB1ZRU0vmvsXp9wwr3V8mJeo5bjvZZowZtE5b2WxaXTyFAimBEMZYG8Syk15LOUXeDCoklfx8E3+W9CpPG/Q9M34jmdmgeMtfUPYJ7KY1rqjZw6tlgTPVYOUR5SEfDWvLc1+z813ZLf/eyveQHkRW3Z47MowDY3iWvCUxK4X8FwUW6WsPdpnWahEbFEh3N2t/ySIHl0ifeSIo9gtRbWCfKeEWzUQ9NVdlKi00qdGiUH8w7FcSxkSeiGb9g/fbv2QOyiLR4T9BEJuA23GhroF8GaV6N7mr5uCqN9Jt9MXnIIjLu1jeNAmLxtdEAmT9sIUCTjWXI5OGEh7CMZCa/hx++U0HgMNJhzvH17YBpH+ox0rFanJXkC3UblSixsvatShwdEiiP/VGQ8JG1ST4KtDveOkGP1hXzq2yWJ5MLouN5kBdLP8ebZZ5TQXVexRPRtYmqXlsBZJwpCYq/bxvRUzj6FJubzLztYbKCdnacs8IKPYfC4RoqaimnQ8CH+EdWRHW+IcSfbFCb5Anr3FdrHS736RItOsYUwyhnaZX9aPNbfp0iKdTauk8r/4Kij1rtwXpq4cw4hwZIWd3fhtze+uUV+aAgRcdUSnZOn8ivYXjdFKbrEPZmNNoSwunDFAi/2CVBYUD42Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s2MrQFk0br1fJQJBoK83SslOzsBbuFQD2TdalpKuRfxt0L/1Fj+j8va2BLR+qXWrdPl0NYK9N5HXOtCZ8KKJHyKDbqQy/4FR7Pp9seQsDscclC6j3H1NiFY0yGJdapNqJnVYwqyMVOSK5y+6xDXc9AGkCvFSE8ieK+0yuwBXWshMFOudCSNttUr9I3YsrEOZM/BkugkpWhcfim91/QiNcRna7QCrrNUzov3yVNwv2YW1KM7EKd6kwBtO77g328iy1ZVPfMyETvMHesWmPjw7NK8s7PtSdHdhjnfkewaJHwhzd6fupkg+/EVs++fpWWKyq+DkRbkghmGIM+RroQ1pumqjFYGzybzbrb/3LXOG9im6ckKD/Bfuhv+7rgZZKhCQfofGPKT92SxXWPmlo5bp25SjmHZBWIfPYcDcO7lfhhgKp+Gc//9dHT6kF5WzqZ+1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:52:51.6311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55295ab0-b900-4e14-40f0-08dec6d60972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Increase dcn42b uclk value.
 - Add a new interface to set idle opts in clock manager.
 - Revert dmub_cmd updates for HDMI.
 - Add utm_qos_model pointer to clk_bw_params.
 - Remove get_utm_qos_model from soc_and_ip_translator.
 - Rename hdmi_frl_borrow_mode.
 - Remove unused project_id from DML2 core instance.
 - Drop HDMI2_1 guards.
 - Introduce dc_plane_cm and migrate surface update color path.
 - Extract backlight code to amdgpu_dm_backlight.
 - Extract audio code to amdgpu_dm_audio.
 - Extract DMUB code to amdgpu_dm_dmub.
 - Move HPD and IRQ handler code to amdgpu_dm_irq.
 - Extract connector and encoder code to amdgpu_dm_connector.
 - Fix conflicting types for dc_plane_cm functions.
 - Add PSR Active VTotal Control capability.
 - Enable pstate for DCN4 non-emulation builds.
 - Refactor surface_update_flags to flat struct with helpers.
 - Add support for HDMI Compliance Automation.
 - Add KUnit tests for amdgpu_dm and its components.
 - Set default backlight without ACPI support.
 - Move backlight macros to backlight header.
 - FW Promotion Release 0.1.63.0.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2202c8669bf8..2de0f9cf8264 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -65,7 +65,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.385"
+#define DC_VER "3.2.386"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

