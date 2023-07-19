Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C8EC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE7F10E4E9;
	Wed, 19 Jul 2023 18:36:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF8010E4E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grO5klzDrT38tWVbftlqwmPtMPdljacypZkZaiMBd4BMpsCSmMGSgzRIEmdvOxR0M+NYQaBSrUYP9y06GIZcX+EC5Bl2W3Dhs61iHIw0ZMDRJyotfoVWjDn1JFuRADGYP61N3k3iq/0qzr942sT9tOyfMmtUj5e5g+Pd8jzTG8WbRP/Ss5uow2brXlXiJvum8d9LCHQxnUR52/Typdlo7X9nAaweIxWCQ3VOUE1a3j5s8Qlb5rsc/unz+U87rA5PLY2LLdu/n5lZtXL2LfaxQ7qshERltaKc4kRkON+ctWDhTqi56HAnhfeWDkhhP7DLpQYdRab99FOb2TSkjHKttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=visAsVJkEZnGFlePIozYjpRkju71/TotYWW8sGae3SI=;
 b=FvRoBsG+JtcU5V02iZYP0T7y4djB83MzPNSoAzepPn1R/zbj2OVUs1beVzxY3LgWEvN13sgkemqrQKtn99GrqhopXS6q9M7MiCUC+ffNZjmejG47fV0oi902FRvJffXrdZITzkFnNrAVNjW2K8UOKd028WgTPlGYyC+MzhvTstHainvj0Ci9DZKE7kXlTvXxutTXRaTVRxmvLhnfc0KsEsp9lp5xyHg7x5ej9JJ1byPsjO0bhAfkFJSi/rxAN42FiZCOMDpUhMPnGRNRFMBDqF3e+9xSkYdcR5rnaR9S1sL2b8rsJ0VE0o9xQlb0MVyQ+0yNdeGVinD++UjtT6diyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=visAsVJkEZnGFlePIozYjpRkju71/TotYWW8sGae3SI=;
 b=QAcvTqvYk/e0UzO63G2t7c5Lkgiv/lBQqKkRPxx0i5Ks0oImyOVzzAg7+z0FCkoBr4yFieViGZPmR1JR2Yh0ieErj2lP65tdp8tZp7t2w+TNordh8SjygvaZ8oPwf+KHpqYrZ9Z63XR4gSVO/QEdEcwPsEHaFgwthGYi3gVCAFk=
Received: from BN0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:e7::25)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 18:36:05 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::18) by BN0PR03CA0050.outlook.office365.com
 (2603:10b6:408:e7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 18:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 18:36:05 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:36:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Add interface to modify DMUB panel
 power options
Date: Wed, 19 Jul 2023 12:28:04 -0600
Message-ID: <20230719183211.153690-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: f76d9db7-3f06-426c-8e25-08db888702fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY2d9e6ZmSuImdZuFCv+q7K1LSIgsv/a6eFbx/rEHVtWpKNeDVta9jLejDmp5yVt7N8JdFKnjX3pWUCgZxdOP02HeEXy+Zy+hMt/zhY4vSjMe0NLgvwr3e+ox4LTSQkETh9qrKNTWoiL9kU7Zjr9FZjEcWMTzZdP6JGppHgD3xo/CUAScJTc+Tk3tIz+7Fm78K5sPEnLwhyYiVJRLsIdUWFd12+82Xp67ADwkW6ThK78rYE+LfavI3Fc4FYSW3WW1rTMAsOZo1w1R9tMnsafFegOrWikUbfaKNyBarb5tknYOBkLx/48F0bnmHJ4LvHNOb1nZIRmyBSpnnyB+VmXyvVteBrJa8osUTFCuw6xRUF9KPcB6Qfd1CeGNH3nFPFEumnvPmg0CdwuVhs1265/kVf+g4pYYaO3i4rwJ7oNZ1NltvjOc7rFrMEmG4pFIB8QFTTS2owfTo6TIbUZLs9zw/QpJEFJ7e40OsWHMuUcR2Pdqco6a17WewNLVC2mg7rZeA8wMloQefVi7vYqBL2CFXwN/WkrXrKgWL6QBcEeWtEDyrkwskOBzCwWJUowhVoVMxd9CFuGoWyo7kMidO2fFQvWKcPkiMPt+4LPX7LH79cih3mydiqKSmuq+ea+rywHJoYhdL+6Iz6Zld4ehlPXmgzqzAXHNa+zuEhavjmrmhJEINnfuAeROxBcQGRAQDR7oLf5iuRnwuw7lpFfmfXzrqNACdN3XY/yCOiiT1vr/nwKh07rDfXWKwxpm/vti9XoATOBZMT5NjQCHhAJxXwMWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(26005)(8676002)(8936002)(1076003)(40460700003)(54906003)(356005)(81166007)(82740400003)(6916009)(478600001)(4326008)(70206006)(70586007)(316002)(40480700001)(36756003)(7696005)(2906002)(47076005)(86362001)(83380400001)(2616005)(5660300002)(426003)(336012)(186003)(44832011)(16526019)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:36:05.4656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76d9db7-3f06-426c-8e25-08db888702fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Paul Hsieh <paul.hsieh@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
This option can vary depending on the panel and may be required to be
called during sink detection phase before transmitter control.

[How]
Allow modify the bit depending on the eDP panel connected with a new
interface.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     |  3 +++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 53bd9bf8f0c8..2d995c87fbb9 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -785,6 +785,9 @@ enum dmub_status dmub_srv_get_fw_boot_option(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 					      union dmub_rb_cmd *cmd);
 
+enum dmub_status dmub_srv_set_skip_panel_power_sequence(struct dmub_srv *dmub,
+					     bool skip);
+
 bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry);
 
 bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 70af110af687..93624ffe4eb8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -861,6 +861,18 @@ enum dmub_status dmub_srv_get_fw_boot_option(struct dmub_srv *dmub,
 	return DMUB_STATUS_OK;
 }
 
+enum dmub_status dmub_srv_set_skip_panel_power_sequence(struct dmub_srv *dmub,
+					     bool skip)
+{
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (dmub->hw_funcs.skip_dmub_panel_power_sequence && !dmub->is_virtual)
+		dmub->hw_funcs.skip_dmub_panel_power_sequence(dmub, skip);
+
+	return DMUB_STATUS_OK;
+}
+
 enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 					      union dmub_rb_cmd *cmd)
 {
-- 
2.41.0

