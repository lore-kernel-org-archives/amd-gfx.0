Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8392CCD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCAD112544;
	Thu, 28 Mar 2024 19:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ldgvLbau";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62238893ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLsN2rUz3Kw9hyG7cKkNH36VrXzSpmMyG+TDrpAHopVz0eCrDkiPwqERXNFpDsKWZOnchjrAqeczixRNwy4nuX3ejuBA6NAEE9Dp6c27dXn09TgDFpp2F/8Amh1/Ak2Mw0UFOI9qQvcW/duzLA3CAO3xQQ1oJonQuezIqyI3vwz0RCB4WTOH77plXaKvI2magMlo3LBcUsMlxLAWE+8Gt5ng23D26LlcmE4njj7Ja5GLK9oqmGqVt3zZ0GE3Kfp/NSleVfrpP4L0Qyl0PPfSiUkQjmiDtL6YPSJ2DHircJFEvr5zy1eMn3v1yesFEC69wD76I7E/dP8sSmHk10UZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DkvdKmtMBZRLFRmHVUO6+MhbEsfrP6le2PLBMQty0I=;
 b=Zhn2oKo6rp7UAUnxP/BQ2RsmQjiipJphHfcSxTd0wG1+OvtkyY66oUwwyEpMkGMWvdCPCOOAO+BYNFXa1zvvZAgCc9tetGjJyvwHqoy2toBFL861Cpoms6z5615x5j8qi9/aUK/Ezfz6rE9qqmAb9XlsK+HP4g0fYJUFusdCi6sMcdCr15O+8ZV4GQqcB5HEOTh5JzR16rpQGOKyFzduBQevbFAC6O1NU2n6zxEuzG8VPmRC1LDmbthgXf3yj7qQvWIdvYwwvRgC4xlgI08pYS6PtU9+V8xGoDJKWrYU9iF9xKl27RFtcWFiVtAIDsBwwKXdZfIDo7tpRD/iDQ6VCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DkvdKmtMBZRLFRmHVUO6+MhbEsfrP6le2PLBMQty0I=;
 b=ldgvLbauxZ5WChHd5RB6xL5b6i5XkBdk1SwUxZG9vovjBc+7C4s9g2/xdJxjP2/q2GI4RbbBnVe1KvuqfR0MWuvOv6rEjB8jvJBoNwKno7A8SBEV/DpnbIfRSsGYHgKHVtWNLtdBZP5HscshuqSENEzbyM51gNVm65FQIetkgiY=
Received: from SJ0PR13CA0227.namprd13.prod.outlook.com (2603:10b6:a03:2c1::22)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:52:17 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::84) by SJ0PR13CA0227.outlook.office365.com
 (2603:10b6:a03:2c1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 12:52:09 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:09 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 39/43] drm/amd/display: Add WBSCL ram coefficient for writeback
Date: Thu, 28 Mar 2024 15:50:43 -0400
Message-ID: <20240328195047.2843715-40-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 47296a12-e1b6-469e-01ad-08dc4f60922a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbjXuI+CT3MtTIyzhGQOE3wbuBSlLqlsrPBr3tmPGbUwrXGln8txs0g9OtZa1OHYZE/aXGSf8Jd5Bs4r8Cm2KduF13IZQOFNtMp/aHXUm9YxilMyDUKSmjdMCWXQWvGzGhnfJkmOsvPdXcPq9ZIkostI69aLqYG0feBUFMHYe9HNzdh7umy9RjvO38j2/D/Mzl2WuoMbQNscuTxnm7Js1KnAO6Wzj9l1x3rs+CSRAGkau8Peg9SYYhODbJMMg2bY9Rm8O4+/hByBhO63OawUBzu/opiGd6daWT835VXlkYYsW1v3idZ8DDjPAvolVG/XLir+NbxGR/nAB1UJKjEhsif3VbnfJ5bFwKRyjPKqtd4vW2Tu/J/eiDmKrqBqZd2FTctrJit4VfkxywJXrr5hWIk3/uVrZuLFn2EZuOtsGkIIxuNWX/ObATdRl0Z0I1QgbskCSaUi+Je2kCCq1a5JAdLRwAuIgCq6azp39VWhRA6aIHb+HWh+EfwVl2+E9KSG94A2uusbt55RZnE759+LqZ2RXVnksoxQWl+Emg2aWDCjrYJeSWHqxQCTcS8kei2uXHEBtrWUsz8vIan6mHqR61WcjMU9blglUOkhgVyTLQW+xkJIFxpeIooCwlhnp/4PH9mp5pBgc1w3bldHtfjBexgMlztbFs0yKN9TGIRPu9tY2l2e0ZjUqHq11ONgQdfFuQvv5YMZsuUOcUuGVfUc+T5dyd7izugFqduRLgDjRf67q5KErr0Hk+HOUBrx4vsL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:16.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47296a12-e1b6-469e-01ad-08dc4f60922a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
index f8667be57046..80779e85e2c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
@@ -299,6 +299,17 @@ void dwb2_set_scaler(struct dwbc *dwbc, struct dc_dwb_params *params)
 		}
 	}
 
+
+	if (dwbc20->dwbc_mask->WBSCL_COEF_RAM_SEL) {
+		/* Swap double buffered coefficient set */
+		uint32_t wbscl_mode = REG_READ(WBSCL_MODE);
+		bool coef_ram_current = get_reg_field_value_ex(
+			wbscl_mode, dwbc20->dwbc_mask->WBSCL_COEF_RAM_SEL_CURRENT,
+			dwbc20->dwbc_shift->WBSCL_COEF_RAM_SEL_CURRENT);
+
+		REG_UPDATE(WBSCL_MODE, WBSCL_COEF_RAM_SEL, !coef_ram_current);
+	}
+
 }
 
 static const struct dwbc_funcs dcn20_dwbc_funcs = {
-- 
2.34.1

