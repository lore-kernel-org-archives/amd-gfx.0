Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E68C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE8D10E87C;
	Fri,  1 Dec 2023 13:28:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B2110E87A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKqu+rVr6JFakY7IJsTkFFxkKJMRGdsuSgXDydlH4FvGY3y8BexaPF0Iz99NbCyhvu0oqeQ3xhzxc9+HB9Hbk9cUl8GNaMWIGtkxdL2VFEex8blUu2bq8zxpTmkE9syOlhaN2e1tHGxaVIqtm7X+3w4R/463qCXyKx/bqfqKl29soveD795fVJ5inqttx6NbpLWFfoTxH9RxoPJi6ezoaFhMsRK6swSW7pqMEG/8p01fpKlwT7KU8izRP9UfJOYMPqaRjOxvrznTjsb/gNS9pJLsIzLQEXHZU0fkTDc/XDkSdjjRe7VeuNyvx6EFW/PMk6y9AEXKrDf6dmc8XpO4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP882w8ti8FBO0DmmdY4hnwtaBjXNl72zLqC+2twCwY=;
 b=gugbvKzzBGZwlN/ICq98B7ldSgHWbTQfQn/Z74ysj7+eSOOhAQf9427e35VBY6P24IUFzwwyNFXVq7GZuPmCVPUzTcFcT+Y6Md2ZGBz9Z7Qmzm7EvpJ57JDOKTpBP9yGWnlbHChe/9ncaCZJ+3blgMsfjNM/30D9ThXgAvT89ARfJCw+0UAaF3ZIZxoKuJJbj58SrBK2XRKipeIe0TqOkWj96jwWjmHrea2wixcdz86Zzv5gwSyHRZEn30jW3KTWZy5hi82kKlD5u910Pd4DojU55OtK8n9iFpU95y0Z3RYTVzcyyAAcP6fDe1uJFlnMhIlOibBmouzxZkZ1iUhOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP882w8ti8FBO0DmmdY4hnwtaBjXNl72zLqC+2twCwY=;
 b=4DqAfIyjpNMUKu8wnOvNDc1Xm3M2w9hL7NqtEjpalbzUQpjvbNkpHevYmEuCQmd8j6/X8aN1zDtSfBhCSOIg7mN9dftbWAAWy1S5Zc4FVP4/OPmA5HGGGVjQPRQWQ65Iqd81Izzief9RDt8mQF6IoJTG+ZJP6aeZjvQqMpAARNI=
Received: from CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::9)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 1 Dec
 2023 13:28:25 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::1) by CH0P221CA0025.outlook.office365.com
 (2603:10b6:610:11d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:24 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:22 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/47] drm/amd/display: Update BIOS FW info table revision
Date: Fri, 1 Dec 2023 06:25:10 -0700
Message-ID: <20231201132731.2354141-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: c2961fb5-b0e1-4bc0-68da-08dbf2716557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDvZULrRoN1faZVYz5ZvUNlGhmEPClUSfYRubHJp4g4xgeE6cvtLBSKX/ls6YqC2CInYQM9wTLD/0JNgqbgm5IuBewoFJTfhmGiJikuYRWtU0aqReOF9NQ1R7kvcGomXHmONt8AcSz2Jwu9AwF6bMeojUXqfUwTXXA8tPrgOTGXdaP4K6R8XBaOI9tQGjBmAYKEfRCavTEM1Z75lN44qSGJ6Tincjw2FX6qo6hQAujZ0ZQCxdXtnjWhL6pbFpIizGg8H0vcEQb9lsfD+KejtqvYc9Ubfg2qc/JuiJAAInhEdKPySkUomGfFZBsHJp6DMraVFx9xF4+zqZSfTsJakcX0WfeMK/F1BM0qDSz/vIfX0fnEou5M/iiiNutXumaJ70FpODN5LordaaWPAGr1dFSI0Mr4wnT2xiUHMLrxmpFAy9UG4makIF1WNDBS+jrV6KKcnsgjVRzaQHDBf6N6+CNFK4IEK/N40uCq0uOSW9Vs6eGAfYRjzPrs7lpO2v031Ij/8YNByEM9HaEk2DQxcM4PT4ZM4Ki86InwB3ey/pAPX7lXx4p7CdCmddMZXFQ1e6vv2pgpBrnug8Tc1Yk48su0GkhfGIb/837bhgc1XViZDNfRuLScS50McTmdaKr8lwUvRIkFAd8Gy1GbJs0/bcg2zg9MrhhnkC0KC0avxW0JrVGAhD8apQEhotRn9l4jQIERtYSZdf+UcTfQ6Y4U4iSY1ARwqdKe/Hbsfmc5ZurCnL6/9fePb12yZcoaQ4S47m5Mb5g+PrTUURi3abJeWqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(336012)(41300700001)(82740400003)(356005)(54906003)(81166007)(478600001)(8676002)(4326008)(8936002)(36756003)(70206006)(1076003)(316002)(16526019)(26005)(86362001)(70586007)(6916009)(426003)(47076005)(2616005)(6666004)(4744005)(2906002)(40480700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:24.7729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2961fb5-b0e1-4bc0-68da-08dbf2716557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Chris Park <chris.park@amd.com>, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
BIOS FW info version 3.5 is introduced to support new ASICs, but it's
content is currently same as 3.4.

[How]
Include minor version 5 in parsing to enable support.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 01abc2f3081a..971473c69b32 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1747,6 +1747,7 @@ static enum bp_result bios_parser_get_firmware_info(
 				result = get_firmware_info_v3_2(bp, info);
 				break;
 			case 4:
+			case 5:
 				result = get_firmware_info_v3_4(bp, info);
 				break;
 			default:
-- 
2.42.0

