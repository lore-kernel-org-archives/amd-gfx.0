Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17A3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3949510EEDB;
	Fri, 18 Feb 2022 15:04:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101D710EEDB
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS434JARfOav21AOTMcNLrwdSOxBxcfYTgd/NF7cphAMw3V98ajlXWBac8MFGeZVAcacPQyCaCYTrnqcFyiZ67aNOD9ejhLoDjuBWh5KAQdKa+IjY2DsVq18Ff5h0bj3XD8yCKZJe9hA47n+KSD/OGbzIC5IjfOnXcYhF1MiSU7ze6rATccZCdvGhzD08hEXB/IEqMjX66e7jpSQsfzYM5w/dLrRqWzbael9X6/l9hOcX6ZIft3ZDe9szBtSICb0AScZRh4Tg4HtE2Ygg4flfSBN5bZ1lvNEwaSom7rw627m8LFZVZYUygZTTazE02fRRig/+Bk8F0j097NDJKkvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5vHy71+U8lr06t1M1bnTbCrJ7x5Mae4pV+XasLp/mY=;
 b=WoLQcQ6PriHVtFqdaSA50ie38chOrq2NBQS1Jw4W/rjGSPD2Pmjs9BpPTIdnEnqSsoI336cEypK3oiuJB7ETH4qQuZqNcJx9punzAhRrk81VaeWPspM0oQeE+cshg0o9NRpeGsx30seu1pnWWDabh9umWIWm/9XDDYcxlp83/0x0AT743IBWSuylcV2sJqr70ZTqxlK2Ugm79TkwbD53htzEtNM5/AcJ7VyCmcDakgFHb1AtUf+9dVc+QM9n2mIlXk4loHuS0qk58UMyb2k8V7WKFJVqMtsQ/V/0WbyBD99K93c6wN77mhYoWZd7ucVeRH8eRcqezOhiZB7KL0hf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5vHy71+U8lr06t1M1bnTbCrJ7x5Mae4pV+XasLp/mY=;
 b=4wSzChR1OXQqgpTs0ZFaNC/yeUaYF873cJFGMAXNqevobwziIa3oAvRDZi5UpfSbj69r9QJP7bM++dusPLdyss/cCyhNlDsfnb+t4o0gUfSzIOZFZLCVv5veYxsfaY2TBir6c9MGGcIqQITk2nJNpySE9TjyVhV3bxRR+uFWnfk=
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 BN6PR12MB1523.namprd12.prod.outlook.com (2603:10b6:405:10::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Fri, 18 Feb 2022 15:04:30 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::8f) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:29 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:23 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: Fix wrong resolution with DP/VGA
 adapter
Date: Fri, 18 Feb 2022 23:03:22 +0800
Message-ID: <20220218150329.7976-6-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a703e029-e863-4466-8b02-08d9f2eff691
X-MS-TrafficTypeDiagnostic: BN6PR12MB1523:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB15230548966548B3A7DB0B1297379@BN6PR12MB1523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8bcqev/53KXnK8IKgZRVePyW+RapDpqGTJHKbOt3xaBQcw1h5pC0RZ3fDGlLLHvXL7oLDYGFunYnHnCqbRrbUkdMLOtT9uXlvNIzgtbKPWGKZV8VaxofcJSX4wgHwed0hzwqrV9Yow/0AmjJOkUpxqyxpeZw7Xwbk4lNENw7KkmZfxlEhlutlJxs4QhaKv3+vbNtWtT0rKbedxVkwTo37t8VJLQ5wE2bXmVEHRGdlry1XkobtbnhNAk+8klwO00zjzFh/f8GeJwKiaJiz45i8CivmkipkuACaDixzbVwNPXsBfShCxJP9Pu7qllNPxZo6vP66bgzuIxQNn8J8+jYcvfrrPHGcaB7RURn52sY8GDQZXsX+hNBJSGR2t4wlR4hvt8vP+VBvZszaBD30PAxAHiF1jH4kjaDmBSb++JYwZ2vyymn6BWwqjGVKI8TaI7a2xbdrOWt09g0ASPVkMDuKJmgonX2d4DzgSL9ERU2tyfisEqfxzz49SnycFzRKZc+tHamQlRyiny8Rc0i1AGsbqubNlS5uBZWRWYANuyem14Ll2Z1yjjNF8CAstlB9GREiPwl/pHc6n7lMa2U00jEs5qAt9rN1h5jCAw+ctz3g1fKF7FBZDcgKLTSYef+u5zWRH3h2MmkNh1Xq1BESHhpVzUaVR6GyYwoZQNXBDaL58qHWx1AY5fG/I/ziL8ayvqr/nCcA/evTLpfovtMD+S6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(508600001)(82310400004)(2906002)(8676002)(4326008)(83380400001)(70586007)(70206006)(7696005)(81166007)(6916009)(44832011)(426003)(54906003)(16526019)(186003)(26005)(356005)(5660300002)(336012)(47076005)(8936002)(86362001)(316002)(40460700003)(36756003)(36860700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:29.6381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a703e029-e863-4466-8b02-08d9f2eff691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1523
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
Cc: stylon.wang@amd.com, Ilya <Ilya.Bakoulin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya <Ilya.Bakoulin@amd.com>

[Why]
Hotplugging the VGA side of some DP/VGA adapters caused the display to
light up with the wrong (non-native) resolution.

This is caused by the adapter misbehaving by reporting the wrong number
of downstream ports when the VGA side is unplugged (reports 1 instead of
0), but only if the SINK_COUNT DPCD register is read more than once.

[How]
To work around the adapter behavior, remove the sink if link is
detected, but EDID cannot be read.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Ilya <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    | 16 ++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c    |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 48858e31b092..c553d0ea63d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1197,6 +1197,22 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 
 				return false;
 			}
+
+			if (link->type == dc_connection_sst_branch &&
+					link->dpcd_caps.dongle_type ==
+						DISPLAY_DONGLE_DP_VGA_CONVERTER &&
+					reason == DETECT_REASON_HPDRX) {
+				/* Abort detection for DP-VGA adapters when EDID
+				 * can't be read and detection reason is VGA-side
+				 * hotplug
+				 */
+				if (prev_sink)
+					dc_sink_release(prev_sink);
+				link_disconnect_sink(link);
+
+				return true;
+			}
+
 			break;
 		default:
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 24dc662ec3e4..f1bbd918de35 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -298,6 +298,9 @@ static uint32_t defer_delay_converter_wa(
 
 	if (link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER &&
 		link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_0080E1 &&
+		(link->dpcd_caps.branch_fw_revision[0] < 0x01 ||
+				(link->dpcd_caps.branch_fw_revision[0] == 0x01 &&
+				link->dpcd_caps.branch_fw_revision[1] < 0x40)) &&
 		!memcmp(link->dpcd_caps.branch_dev_name,
 		    DP_VGA_DONGLE_BRANCH_DEV_NAME,
 			sizeof(link->dpcd_caps.branch_dev_name)))
-- 
2.25.1

