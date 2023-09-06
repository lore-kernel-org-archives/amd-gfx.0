Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFFCEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3B710E632;
	Wed,  6 Sep 2023 12:49:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B136D10E631
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y26WGY5QpjBqGSKf2tPHEhl9kglBG5NvL3gTGCHM6iNeZzaao9jKJyKezrEYlibK7lekDXJNzdS3K3xbIbSNhVK2QjDCyJOvYdnt8YP4gAHJHPXGt3w5xo8QqOyt40KX/EEwDwkzSeQwpbRU2xHT0EBLeQelc7pZgbYoGRWNbx3L/UVL9xd23c3VuePl/mnaeLIeL7cgEYTj63om7/L6ECU2Ih4YNjJLuRnv9GfHIxR1dlonRzsk1hNnkdI7/++SKc0i2pkLIDxJkDUEQU+uH1XEEI1e7Plri4ToTpBmVO5ZZwqTwzrmpc1G5hyGvpIBVewk3hSJ+dVFNkiHlO26xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG78CXoU0oyAJWj3o1kyNu5Th8YK9mWlWmh/zXfP+54=;
 b=kx9isiZqW2l4ySfXDo5d+lmsVUh4OdqPkA3sz9Un9FWTL+j4ttn78HiB9pUWXZ5dg2/r6Usfjr9gFY/LFtueFUDQRBT/37Zr+oZdl0bfxmYIyYN/1XsTJCwBXvZWRPgajTh7oGRiN+e4dzaAYSxLIC+RbACHKbeIgFRNx3jXwwCS/QossuwhDB4PGcz1SaMlPRv05Qm1X0rZu4dEiBL3XvgwOLXw7/M70oCIrqCRXx/uDKIH287hAzGT9hWWazHzsGgxIAND8cOXP09Scp69I1v9q0RbHvCNSwY3Dta07qXeeVf2FaDOs4HKdjPE1jI+3i6Cjdq2uqlY8CIbbOAEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG78CXoU0oyAJWj3o1kyNu5Th8YK9mWlWmh/zXfP+54=;
 b=YhKVoukCdP5U6JQS2sIwlqBo4+DrHJNWmoZQ9u/DDqFWP5COxz9htazzqNmjPd+XAyEDCzlIVohnQS1bKvs/JvQoj1lMxKSIIxvaarsEE3JcpL81SCU8ZBs64pfzQJt8wQ7y4UKU/ZgA45hnayvc65cIft3Itphi9moiZ0vZMCI=
Received: from CYZPR05CA0033.namprd05.prod.outlook.com (2603:10b6:930:a3::22)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 12:49:24 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::58) by CYZPR05CA0033.outlook.office365.com
 (2603:10b6:930:a3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:23 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:18 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/28] drm/amd/display: Don't check registers,
 if using AUX BL control
Date: Wed, 6 Sep 2023 20:28:10 +0800
Message-ID: <20230906124915.586250-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: d78580fa-0672-4bbd-8446-08dbaed7b277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGlptRkFqbH3h8MDQRkfPlSNvA7Y65wwrnnAB4UN6n1sp7s8S6M1ZBSYpLXhY29cLbKsRF5ZDhtnO8+Np+GolbRkXDBh3z5XdEEd1Cu1bCBf4efep6yGpAzRWHeB+is1caKB6EdUtHQBlxrbluxd6kC0aymxxKBuIYyQfedaFSAGDUlT//qplWLZnd9r9D9paa6WwTTWk7KbMkNvGAzXgRM8vn+FsF4nH7ZjXk2K3Lo8QpXdIApDXVaLO2cj60dfGpmyon3WAmg+svR/+/oUnaYaGWvJPape1Vt+3JBwp7MrMpGlzhGCnXqEGcI6YrXkW7eevnJdzl46+UxRy2038gcIfeUsXeZjwk8ZqT2KYlZNWUrAKYDv/P451E1cj11CHOwuY+dsbV/lwesSBoWqlaSa2CGPyhzKvVOT57t6uiLg4sDYoJ80n8tt6fON2jPfrdKm11gA3AANn/BjUJw3b+kE/phj4Ut3gO5lGszszRdpnvSlwF46X4MWVLVuwko3YUQGUDnc99+ykRvQqeZKv9c1fiy61h2uHJIc07IhLdrUhMtUxVhxA7skZ7KKv1Sh6m61yflkms1n+GISziBy14mC2NrRnx1jMH6ozuNGSSAKTt69SaB3TH/O0eI8rfEIiCeelYahfSQ53RrPMAAulLCRMTEPaiTZWu3VXgZHj59Az0XmeeV3GCfA7RP5dx7jxlimrsdsaSUJpEsvElQplPfY0ULJbjuw0M5npsWTAG2Jyij8wVcGhjcEjAIg4mopsTiz9Kubla/cGEySek6mJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(1076003)(8936002)(54906003)(316002)(70206006)(8676002)(4326008)(70586007)(6916009)(426003)(82740400003)(81166007)(356005)(7696005)(40480700001)(41300700001)(336012)(478600001)(16526019)(26005)(83380400001)(5660300002)(44832011)(6666004)(2906002)(36860700001)(40460700003)(47076005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:23.7342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78580fa-0672-4bbd-8446-08dbaed7b277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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
Cc: stylon.wang@amd.com, Swapnil Patel <swapnil.patel@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Swapnil Patel <swapnil.patel@amd.com>

[Why]
Currently the driver looks DCN registers to access if BL is on or not.
This check is not valid if we are using AUX based brightness control.
This causes driver to not send out "backlight off" command during power off
sequence as it already thinks it is off.

[How]
Only check DCN registers if we aren't using AUX based brightness control.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 602fb149dc10..31454db00ed5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -964,7 +964,9 @@ void dce110_edp_backlight_control(
 		return;
 	}
 
-	if (link->panel_cntl) {
+	if (link->panel_cntl && !(link->dpcd_sink_ext_caps.bits.oled ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)) {
 		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
 
 		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
-- 
2.42.0

