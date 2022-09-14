Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83C7ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEC110E850;
	Wed, 14 Sep 2022 05:19:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0E310E850
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAiubS4nqXFWhPGwqqcytjTAWVRF4BuO5ktLyKjSIAs9jwYaWxMQPw/SF/afRt1gXGv+up7qQq3q8Z9d9VZNhjL32ICyEn03d+aMc8V172kq7YkPHPwSHAg9rfvEvMKWIVvcnkgJFAZySF4UPQje/JeELSvDoiaHd1+PWxfzy53uibK8jjzzyv4S+n2wGJI9ttf+hDMM2ovKsOEplS/xbokYbeT4XRsNb7FkduWKXI+wn0rR0m/9ygNDYn+8c0A0Hjptomv2pfnBZhubpP7VfySw85TCNAEGlbT1Lx9rPshUIDedvMsS8mmPzmPWH1LViBI+Gt6gLTD7KJnuE+wAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agz2kjnV0upFMGPyOl3LQMVNbYvt3lq4VsYSrOBARFU=;
 b=dgJI7g3XwKbhzqpwzY1kQXUHnkiLx6vk/RG2GrPg6+sVO6DD5ep146ccZ5ptPgUj2KO8jPDKKQ5Usouk2MvTse8p5dZW6gLiSFhiAROSehCOZ2S1KlIsg2Z8Aov5AUgLJjz2TBTiU67iG6V5XDK4+rG6bS2DGa5BJC50Itw7EM/E34Jxrx2awypiMKByknbgj1Zyh5Ph6U9QUU9Ifiu8F5BTQYJJM7vy1AkTMgPAwHaHEDe4jq7vniuGchWCelQAQhFGDWYVEyJxLA+zUa5vC6eoP5j9Km5IYj/vEYgvN4XHitTPThw496DS+8+22a7+Uo3OjEp904C4hp25WYbErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agz2kjnV0upFMGPyOl3LQMVNbYvt3lq4VsYSrOBARFU=;
 b=tEi0RNHnBgpDapD5ZTP/E/1vWcsbWbR6U2j2TvuOW5oX5S+h3s6ouYKVHVODFMM8gfjUC3vS5hSHiCr6Agm/eNOVmmH/TfV5SRTcv6wWR6D6Cb93nJDLtnuMvEOj4Jfzxh9KO3huiSqrkxWS23KPAk8UsqBQTKLh2QrvXfd+T/w=
Received: from MW4PR04CA0179.namprd04.prod.outlook.com (2603:10b6:303:85::34)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.17; Wed, 14 Sep 2022 05:18:58 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::9a) by MW4PR04CA0179.outlook.office365.com
 (2603:10b6:303:85::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:57 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:18:45 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:18:40 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 40/47] drm/amd/display: Revise Sink device string ID
Date: Wed, 14 Sep 2022 13:10:39 +0800
Message-ID: <20220914051046.1131186-41-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 024b2723-ba54-46ce-4431-08da9610a040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /H4ry06J/c1+AjerhixXq0myUQTXceRbV4uo75h/gUqfM8LoCTQb4aBm7h4DK6Y6tmC6pQflhCD4kQfUCOI/3YV/aP/RR1tDvRYlBoDYfkQOmQA7GVCCjHON8lJppu9y0lvi+P5kb3wKDlbDZ0Aiv5xfDAnttfsTn1+JZPmP9oMjb6qSwLCGdLMCbkJTd0jFvKiRsNQShIZ8uZnqTvZ66O+9TDHmP9L28Z9FfPd0pWcfZ8zbCflQo/SjvrZ+IANXnp3sO+Dh2N5FKv8oGuPOwkIsxp6Ys8jXfU4de3na7cvETbQ+jpC2YtVEVUbf7+7dltRN/ecDZo9j8reCgA6/V7FIu4X2mgthV/Hdt/+4soMIOZIOQ8UfDYvA8Dv992w493ogvnT/A2Ws9mZD+R+AG+TfRuEYuoJW7Oumx5EhpeXosE9JJ3ttdDmTXNHf9IuNcl/cZ8fKWNxoXn//biJqN1bS/eNcQM+5oB1pFBSW2Mah/766WOvaAVGiDI82TPVoO8K7pOd+q9wVilkcOAuLJ+DQuTxDg3LSRNLCNhBO8e1r/I4u1PD8L3vRTLsPA39rFM2vjiczuHW2Qol8mxH5dELjYuwPqK5Eh8JN2aJ2w+MWBRiZfNzkGYaPMiXwFEUIfSlWCBG4OTdx6w7aGJXglgeI13fOOzPSM8+yxI9dY2U5vSL3wFKzmha1+JsaJCIzpBd+HysVhFwe2ylgGsRlKASGULghfgx1SmwfC8ai9ZyHP52FI6G9F7fQHpwk6U4Su2vAm5j7SQMOpgC9729OoICI8BcigDAdNAv0XlDNn/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(5660300002)(426003)(7696005)(40480700001)(82740400003)(478600001)(4326008)(83380400001)(8676002)(356005)(41300700001)(40460700003)(316002)(336012)(86362001)(70206006)(47076005)(36756003)(6916009)(54906003)(82310400005)(2906002)(8936002)(2616005)(81166007)(70586007)(186003)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:57.6837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024b2723-ba54-46ce-4431-08da9610a040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Robin Chen <po-tchen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <po-tchen@amd.com>

[Why]
The Sink device string ID1/ID2 use 5 bytes instead of 6 bytes,
so the driver should compare the first 5 bytes only.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Robin Chen <po-tchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c           | 7 ++++---
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 0df06740ec39..bec5e9f787fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -393,17 +393,18 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	if (copy_settings_data->dsc_enable_status &&
 		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
 		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
-			sizeof(link->dpcd_caps.sink_dev_id_str)))
+			sizeof(DP_SINK_DEVICE_STR_ID_1)))
 		link->psr_settings.force_ffu_mode = 1;
 	else
 		link->psr_settings.force_ffu_mode = 0;
 	copy_settings_data->force_ffu_mode = link->psr_settings.force_ffu_mode;
 
 	if (link->fec_state == dc_link_fec_enabled &&
+		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
 		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
-			sizeof(link->dpcd_caps.sink_dev_id_str)) ||
+			sizeof(DP_SINK_DEVICE_STR_ID_1)) ||
 		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_2,
-			sizeof(link->dpcd_caps.sink_dev_id_str))))
+			sizeof(DP_SINK_DEVICE_STR_ID_2))))
 		copy_settings_data->debug.bitfields.force_wakeup_by_tps3 = 1;
 	else
 		copy_settings_data->debug.bitfields.force_wakeup_by_tps3 = 0;
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 05096c644a60..a7ba5bd8dc16 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -128,8 +128,8 @@ struct av_sync_data {
 	uint8_t aud_del_ins3;/* DPCD 0002Dh */
 };
 
-static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
-static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
+static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
+static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
 
 static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
 
-- 
2.37.3

