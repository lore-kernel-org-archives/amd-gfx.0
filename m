Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F23C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0991B10E13E;
	Wed,  6 Dec 2023 19:52:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFEB10E5E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeHvm0EnB2BI5/OYr9K6a8+P1svfgY8/obG2pVkuZrqKj66rFT5Tm60gJ87Ylfjsw8F4r6Ke7nnyJjyqwFM5SVM82CTZP00QEJODgLVvDzCOgOUPhUcbwIN3r7FNN1nML5yAkmvB321f+tHQe9/4ZZmrLh/+thFvu/9tOZ0Z9g+S+MN43rT3/SKEi81AC2AHMmUzoUQSKeZexUIgzlgsMDabrl1eA6g3IPcoY9/Ky31EDrWY4kJOSvV8SHbaPu+FCVTUels+6AAijWOF1+er2gLtL+zmtJGw3U3oTBoqeafpcMu/0CTW5FNqWEa/xGx2uVqwOyCjraHuPZ4PISFDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3jroVId0Xglk95vGkAtsFtod5EoB9YZ+LexIPQyA1k=;
 b=Bz+y2dCkxFoi6Quuw8Pw681uOeH36we8HY7SKbye2Qh17mWojiTRK94TRwT2itifA71/slSrU7KN8HuKppZjCvKb4Be7RKuyxOjr24i2RgXMmvTtdLeVZxaqaKixN4jDRgnsmFDSFmE9ugl+fVlXHRVeH/8hW8akBDXKIBw0iCFaZ2Rv0l4F1u+LE1QjLcjLP2jiAAERPRws+gtW6fBG/9yzcD65CnPMi+HmKZfGVzrD2ZWXiRspOGnEnlO8bFmlhbdMePHqZ42QX3S6Lkp7y6E+x/oN8Gb7MX8Bb/nJR9Dc2Pm1RnYab+PAKBRVRnZyIb9NTIx++mfRG22QFqj7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3jroVId0Xglk95vGkAtsFtod5EoB9YZ+LexIPQyA1k=;
 b=lCrkc1jUBoNvGeqDSVheDzFvSEX7YkmeIBhyZi+KiipgolTK7MdCsjmjq9WB4T1grX9VbGDOa+g1kYRPBZAfe7OKL68uzNkeFfAXOUmVRsyiiET6AFq+Z6CF4OQ916A7AbAcLh9F29eyuPSHJFFF/D/QLEf8QRFkGQV2Sj4sfZI=
Received: from CY5PR15CA0180.namprd15.prod.outlook.com (2603:10b6:930:81::22)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 19:52:37 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::dc) by CY5PR15CA0180.outlook.office365.com
 (2603:10b6:930:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.26 via Frontend Transport; Wed, 6 Dec 2023 19:52:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:36 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:36 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amd/display: Use explicit size for types in DCCG's
 struct dp_dto_params
Date: Wed, 6 Dec 2023 14:52:23 -0500
Message-ID: <20231206195234.182989-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: a46a61ea-fac3-495a-ebc8-08dbf694e5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44Q/P9SoKiAxTOcREotQvWN2pEmYi9TxtIw/0o4sO3Bvy9vz8odt/Cvt4rRpP8jmUh4yNUxrH5DDO2EOg2AG1i0U1UrNWfmNmfCrRAqaty/EVj9Ktq2QYXtmuiZBZDKdtHP42qLuPr2iqnu+lMIzmCC4iwKaZrGDCfdoYkEu2KEAoGSPX9KQ5b5dH0IqWu+zLbB7sO7f9iAI+QBwqup5nwzeKx7TLP7sWA/H1MM9aSifW0OyJKaCIYwCGzMndROffUKcKTP94WEW88/miWcSyU997N1CXM7XdCpqWQoSUlQi0b9Q2lwljcCHwIjIlMofX7HIMnaqwUUkd+uZxfy0otqkKIiwmUtotJr4IlldDA6fhQhrW1u0brWKnlc8Vmr8qUWKccYYfXl8F4n0U5bKE4qfBNgkr93ga3z6ytAfYF867cqE6PkA42AJl6Jcjs2HqrCaWbN9JjSouQSrX2E4LIQnb51RhbcC0JruLqHLBZCZrbzm8qkVDiqfyARhtKG1Rts30xhsu5oRs9Tva3EvFz+33ITpeM6BFSa9hGZijXISILbTx0kk9ZtkX2UZE1T2khkHQ+sp5n4XNpUZhfG6fi5wK4BtqbCiHjA+NazCVfq8rXAnggW/7NhwFHKrJrfjPdV4YmRUBEJk2xAua9begRKs9yTL0+rAMNK3E60AOcjb+rc/RBRcqvJMu2l6dy0A/HZbZA38WQLF9nuLXWq5nCpKcUqSp2h3w6iuHjY+mnuds0qVtktYDQiBt71tVSwzA1/l+4bL119NaIZYYJ7DxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(426003)(83380400001)(478600001)(2616005)(26005)(1076003)(336012)(6666004)(7696005)(316002)(54906003)(6916009)(86362001)(41300700001)(8936002)(36756003)(70586007)(70206006)(8676002)(4326008)(36860700001)(40480700001)(4744005)(2906002)(44832011)(5660300002)(356005)(82740400003)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:37.4304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46a61ea-fac3-495a-ebc8-08dbf694e5de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 6b44557fcb1a..b9a06bf84cc9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -59,8 +59,8 @@ enum dentist_dispclk_change_mode {
 struct dp_dto_params {
 	int otg_inst;
 	enum signal_type signal;
-	long long pixclk_hz;
-	long long refclk_hz;
+	uint64_t pixclk_hz;
+	uint64_t refclk_hz;
 };
 
 enum pixel_rate_div {
-- 
2.39.2

