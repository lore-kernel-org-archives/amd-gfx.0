Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7DFC47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C57D10E675;
	Wed, 10 Jan 2024 21:54:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B56210E675
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH0rDl1wq8XiUHSqMr0hVJhgL6AaZ3//5N4K84Fbh9TMEr7n7H5TOUVpQvV1+NCVFWlGGTRcptrM/OJb1qf3/+bX/yfMBvD9Qqvn40OPHRljJVehw/lkqAE47ulqY4s28PzR8Ape6ecEd7WIA5YEBY/7N8Y5K6hwfjpN1tT66C8Yl3OsXbSjmgrLkYPZO33RuGcqG3UNHxFx+hdoHueOTRQ8I2fT33bi/kxmTLvnchQICHphCxitC2HuAL4Ckb7Y4EEanlUAGppISdvdXP8/esreCVETlcjg3rR1im4hiwZYuw8VO9hcXAs8z1zCQdGBeOy9nGeySX6xkhXQYaEjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mDm0j2+i37mKx8ThLS77E+RpYSJSYc9GE6rMEOgiC0=;
 b=PT3VKLTlv/Ml9fRnl0zxVN5YvCmfze9kGvkIyvMgDVtSu/+26FT0t8+VtA22WabROFtWWpqCWHqeIqrzdtsfxK2HIjpQBie/95Nghn9zwyV3URBQZX41bt83r7i2TxOwDVwlazPpYL/PkH8XdnXrUEBxlV8VjP/bjF6wCTbjke8S7dorVDUSRDqMXoJyn3m2BOLywUJkOJRcnkBDtET4oxi9oKjy9tf91nwa+YrNAjvbfMJnSqnIQpQgjoiahRB6ebOZyqLVPApgxMHZQ13rWjbYR+Kj4tb49Kz8iduS4ameP5F9QviHmoUKd/HtYr5G4F891TmMIaO3JmFu9TMk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mDm0j2+i37mKx8ThLS77E+RpYSJSYc9GE6rMEOgiC0=;
 b=nTQxZpY7d5fJXDwSVUfk4ZqGITFhFxUcyey01qUSLkT+UQayyiLZXVEer92lB5en67mEbvIb+yMYz37V1h99E0j6/4Z7Tr6WkG4MFuHOBHJwkfx1qvq9pSjTk7+wVU8hcWzM/FGpVsygpsMDJOEwkr2KGyHPKSfSZ7OalNQ05uU=
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:53:59 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::c) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.8 via Frontend
 Transport; Wed, 10 Jan 2024 21:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 21:53:58 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:53:55 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amd/display: Allow IPS2 during Replay
Date: Wed, 10 Jan 2024 14:52:44 -0700
Message-ID: <20240110215302.2116049-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9e2f14-72e8-40a3-704c-08dc1226a637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOq4VcO6t/8Ndj5MBy1Vz0FTioQ6P1VC2S4uGPKEDs7yQ6IMdgUJVu/Pc2jydwmAHLwZp9ZE8x+wTCPo1WR+Tpmop7CXomTMTBwCquW8Waq+yZVzfWe2qIDzoP03s7TxkLfXmsxzn8G2uEF2HiQvMTxRN7dIxB/BwCdNPMHLyvCBBk2NJO9dAJvii8rGVqD1Bu8OhfdR3Heihzg6PrYr5sEJqIiwOMlxE9N5wLSidmyD/eSxNWuXw+RLlaYLsVn0XfrLQ4sPu9AqvojOrPF1O9j1v3XEjvvLdxzUOiVaMt3NeOuMKoyX617OSeNvu+AE2GK7T+ttInRfpiDRaKMpM4YqMICOEK2dhHn1if/iZknY/tTNgSsxE5IfIhzpbtePfP8ktJCAX/6uqlg3cSpe3FyLQqDChb9EXlfl57UAu4xTchSrRUnVaiNEtqWwztUwR+cxBVSd0Pmx8Ws1kuYLdMidtMlHh/IcQBb97WzCC/cQ/LyRj9SbAZXNvrnwOsY37wuUy0+dEY4vg4bKlkNhEd0u8qyBh3Oea7LhMno19gqUmcpXlbUrv6aZNI6LsnEx8MljVKkVJvBEETRk4EoOzxU+QCkdtgDZD8/fMi0oubGHKfy8/hwZwpsPOJoJBCwcxvG0eR46KoBsjh4UH7eO1qb04xWsQqZTBaIbEhCgKHtBMnUN+wjTee4LBtP/XzBPALUtxD2Adjpb1nehkH+kII4AFixfnqKYhtFhpJSS+0X8tZWY8Kot+p447ZLSpxrl+cMAYloOFT48YvPLo/5DgKnyxeXfBULNG/KQP7vumSP9UlGS6clUm0b0RIq26MHg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(41300700001)(83380400001)(40480700001)(40460700003)(26005)(2616005)(336012)(426003)(1076003)(478600001)(47076005)(7696005)(36860700001)(86362001)(6666004)(81166007)(356005)(16526019)(4326008)(70206006)(8936002)(8676002)(44832011)(54906003)(70586007)(82740400003)(36756003)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:53:58.5069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9e2f14-72e8-40a3-704c-08dc1226a637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Add regkey to block video playback in IPS2 by default

Allow idle optimizations in the same spot we allow Replay for
video playback usecases.

Avoid sending it when there's an external display connected by
modifying the allow idle checks to check for active non-eDP screens.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 111c6f51f0ae..95ff3800fc87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1716,6 +1716,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
 
+	init_data.flags.disable_ips_in_vpb = 1;
+
 	/* Enable DWB for tested platforms only */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5d7aa882416b..c9317ea0258e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -434,6 +434,7 @@ struct dc_config {
 	bool EnableMinDispClkODM;
 	bool enable_auto_dpm_test_logs;
 	unsigned int disable_ips;
+	unsigned int disable_ips_in_vpb;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 9c806385ecbd..8b6c49622f3b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -680,7 +680,7 @@ void dcn35_power_down_on_boot(struct dc *dc)
 bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
-	int edp_num;
+	int i, edp_num;
 	if (dc->debug.dmcub_emulation)
 		return true;
 
@@ -688,6 +688,13 @@ bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 		dc_get_edp_links(dc, edp_links, &edp_num);
 		if (edp_num == 0 || edp_num > 1)
 			return false;
+
+		for (i = 0; i < dc->current_state->stream_count; ++i) {
+			struct dc_stream_state *stream = dc->current_state->streams[i];
+
+			if (!stream->dpms_off && !dc_is_embedded_signal(stream->signal))
+				return false;
+		}
 	}
 
 	// TODO: review other cases when idle optimization is allowed
-- 
2.34.1

