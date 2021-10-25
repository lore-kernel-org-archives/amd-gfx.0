Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3FCC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6013060FE8
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6013060FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C916E196;
	Mon, 25 Oct 2021 17:56:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209BA6E1A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 17:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaBoT3QsNc7hHMlKvmvZiwzK+Qd1UqRuTeEXEN8YSbWae62Nh+aIBOOfmzsSrOk1/aXJxVtg2xKmyBJXeMUEE5xxcrO4hzRydZ4S+BGENON33aq2K7mYGicjD1zP+FvzklxPZJjIDu0LaBrJ821RLJwNv52F8gutvPeuAwtWYstWqGTmow8FUhsoXYF+QO/jEGcTCEsgPhv9ezs88vtVL2cDhwVumyuShk0sgRQkiuwXkf8zDig63rU48leyVo9W5AurzEJtOMQUdAMuXj8OJktSyp+EH64az/SzrPHSLY78xmlTJYvcutExp0oQusUS1pU98hy/gg/eqlfg56tl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcbAxKkaZJuf9PbpcOcTJ9X2B5Fy85gH9x6WC+mqQjI=;
 b=RumCsGdAMNuFV58XthxDvTSsRb9vfb6Sf8kttyxQk8TB/eo7+BqPyWtqOERdvnbRIjc03D3G30Q7GQfwuMu6stSkr0yECWVn+gMTIzGVGi3UWbibBbDRpYPnbID+DencjklnHKqid4aT3Hk9akx48vJEfSYixxoqpvpCB2cuEdSqcPsWr8N+Nmbzbhsgi4leWEFpKBLDRPyuyo8X6bp2dMxCcnmSbeKJUJkmq3A14CdWLHxl+4qSxUGssGm2tugNAHIlxLp0J+Dt1sruOjHdBj8VuPCj+lZw3jOxm2tQ63SjGpZtrh36oPPd+iLz6lxIYrK/38ywuuTW34iNV2EvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcbAxKkaZJuf9PbpcOcTJ9X2B5Fy85gH9x6WC+mqQjI=;
 b=3sslT8brwr5bEBhF+LDqxKzORSd1BvVrC3cEhudQO62I44YNVjB/ao9v0GNT6tWSTeIYl8B/mAV8dRdAUYQ8YAnQ9tOsfq71kzHrLFPV8V14otAxdOnFFmw5PknriY1QkVc3uK7GZjyOFuvI6QhJRIB+L3pFl78XYGwoixCPG+s=
Received: from MWHPR18CA0035.namprd18.prod.outlook.com (2603:10b6:320:31::21)
 by BYAPR12MB2870.namprd12.prod.outlook.com (2603:10b6:a03:12d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 17:56:05 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::b9) by MWHPR18CA0035.outlook.office365.com
 (2603:10b6:320:31::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 17:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:56:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 12:56:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 10:56:03 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Mon, 25 Oct 2021 12:56:02 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Aurabindo.Pillai@amd.com>, Michael Strauss <michael.strauss@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 1/5] drm/amd/display: Fallback to clocks which meet requested
 voltage on DCN31
Date: Mon, 25 Oct 2021 13:55:53 -0400
Message-ID: <20211025175557.148601-2-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
References: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55547ece-29a9-479f-068b-08d997e0b703
X-MS-TrafficTypeDiagnostic: BYAPR12MB2870:
X-Microsoft-Antispam-PRVS: <BYAPR12MB28706920DC0334A2E60F4C68EC839@BYAPR12MB2870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MpRbS7P+QLm/XjF5g5HNIfmiKGPM4shgwsD6Bz+JuqGCLqWWAF4kJyauXS7a5dkUCmg8koVXbCdriA9Lfv6MPCoZD7OZMuCii0LgDQQIfSuNHb4enUq7f+lLKvfZnUErYVIdn6Hp/gyq0iXnsiOO9dwvt7JbENjT4VEQTVolLYRNjqK793lhhwWSDk9SARSOtHCeQh2r8xuBJm0qgARbQGxY2yXCocEXijPWCPPVsCQlgVuUIjQHP0ToOEA0QVEZ6WoHKp9QdjGbb4PJ/KvhtTbfughjBFJSC2StE0F0SyxwXzDen3pa5QMZMQLdSofx+b/jpK+48xyhKYfd7h5pmUYU41SiSDRZLxnDSDs/JAwiemYsFhlJx/kxl9GIfMK7o11JRBXyd51jvEW48PP35oe2qkYH6ptWvv79+D33gtuZ1BnC2Z8t4zU9NqnRhYXHIQp1Jd+XjRUjLuBjG4Ihj4YOsHcJ2M2PemdW1WI9N9JRyKx71X8ky7wyWpAtKew9WdoHLGoqcclZl+cISfpFP7351RnbLevwkT984CXI7nXMdLLFQdHfRqNXDMU5X3FYJ0x86HyAykftrfAkXl2fgyMBZPApSRZxrIHiNedi6xNIntElrdSx6D/yQNlWPdCMqD7WVFz/vbIXCVnAG7RxmBSaJ+Zs+biXWnTxo3a93X26cM5CkrxX7y0w55B3HKmmWkkZZ754LGA/tOhBogWXjGZHrsudiHvUXGW1xG8/Ek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(8676002)(47076005)(186003)(70206006)(82310400003)(36860700001)(8936002)(83380400001)(86362001)(44832011)(508600001)(336012)(70586007)(2906002)(54906003)(316002)(5660300002)(356005)(6666004)(6916009)(426003)(81166007)(2616005)(36756003)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:56:04.6984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55547ece-29a9-479f-068b-08d997e0b703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2870
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
On certain configs, SMU clock table voltages don't match which cause parser
to behave incorrectly by leaving dcfclk and socclk table entries unpopulated.

[HOW]
Currently the function that finds the corresponding clock for a given voltage
only checks for exact voltage level matches. In the case that no match gets
found, parser now falls back to searching for the max clock which meets the
requested voltage (i.e. its corresponding voltage is below requested).

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c    | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 0088dff441da..f4c9a458ace8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -523,14 +523,21 @@ static unsigned int find_clk_for_voltage(
 		unsigned int voltage)
 {
 	int i;
+	int max_voltage = 0;
+	int clock = 0;
 
 	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
-		if (clock_table->SocVoltage[i] == voltage)
+		if (clock_table->SocVoltage[i] == voltage) {
 			return clocks[i];
+		} else if (clock_table->SocVoltage[i] >= max_voltage &&
+				clock_table->SocVoltage[i] < voltage) {
+			max_voltage = clock_table->SocVoltage[i];
+			clock = clocks[i];
+		}
 	}
 
-	ASSERT(0);
-	return 0;
+	ASSERT(clock);
+	return clock;
 }
 
 void dcn31_clk_mgr_helper_populate_bw_params(
-- 
2.25.1

