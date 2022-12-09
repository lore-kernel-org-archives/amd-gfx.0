Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4B0C04FDE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA89010E570;
	Fri,  9 Dec 2022 16:37:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4C010E56C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9RV+xsOzM2cvgkTfTfVy1xULPeBjiyuVSMPgKqo28fIOqN5BBahbAWghNafpUBMwcSjwTPVQi960GjAVfReEYNH41s4Vip7GtbZcf6mD5u+o2iWD1ItdsxltBtxp/LvDfM9VHrUJon8H0dsiFm5Jo3BTe8Dru4yfPyvvN73S+07ZNwLcc8420tlMHyW8h7vEob2dk/+EqFvkc/+ypDQfjccpZb+vUAliUFV4eJ5W4/4TX2PaBEr/OLSoGUG/1IbPClfHT+6p/AQLuoZXMS0Kpt7V/BWd5GpntVgKgXoXHysaIrmWglnYHkQXon744NVaxMWW/3ag8lkyxBz0EpIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysH0fZDxfLLMfvgRb9vfb6CEmfXRogkaKIkuX2O7juE=;
 b=gKoe9gumVU+5HJ0tp8K+TnrbBfq9VtqQVRO3yuB5Wu4sztkY/tcpPP3THI7iY8VSiyRNJMObm5P42WlK70J8oVUMZ9BnkN1IzApWU1CA7iXWPtckdgVUu4ppBWaMJYRjeRjS8t3XYCCpEomAtM6jX5y3zl0LAgCCG0K9mPuLF8HBErFQOR4uovHfSCvEE3YMve1ejJsyjuT/UwruJyDvY1Hm5X5eyHewjgzim6QVN/Twq28Zc00d6Yp/XAJzDGUMv/TyCp7cx9oDmap94AtTCLxDqBUc9mE+4IXSFMesERjsiS9ltsfw5Gr9wluiC1YaSRMHwAamgcaQLvYAGY3PNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysH0fZDxfLLMfvgRb9vfb6CEmfXRogkaKIkuX2O7juE=;
 b=G4UE7tvbd+arzjuzvHXrekt7dW07P0rVESSvHjJtGqxTeGGawVwIfgQj/+3jSdmcq2nWIKiKVoSCGk4+MTz11bGcaTsDlvvVDLYG0Wm0T3VtPng05peMmCWzPliSODopY3or9iR+Iicu8ASFEPZCMpkyZW5AoT9eS3xxb5PgepM=
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 16:37:38 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::ac) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:38 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:36 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/23] drm/amd/display: Revert Reduce delay when sink device
 not able to ACK 00340h write
Date: Fri, 9 Dec 2022 11:36:44 -0500
Message-ID: <20221209163647.25704-21-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: a899d3ef-f53d-4a69-f64b-08dada03af16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27KfKUfFvajuvmRypLvUnG5NeAHncgeSzJGh+zAvdWxsj7P56dC487lxvYSWVYmMbTjMQ6RZWklo7ueOnIRDWFsqOJXSLXiq+yFqzPWazTNEV6TqTijugjO+kDCxiqjZJKIUzODXTm+jFDNTGLDeHuJ+VcS9Xpfu5LnSZhbYQUhdgjz9AUjISIF9xWNP3tSJe9eAuo9+jqHdImLQfdInczSiQbGuQKpYXA3znfZR4M4db1x9qD4c4p8P4IAxGOCRK5k+jKlcnMwQxxiXZ8pbG1cEnef5loKe4sOW+/JEl0jgvY5ENe2FYF8jTJ+/S1skzKI1HvS4ltPMGFAm4p5nToA8w6o3nbVbHjyGOzP6QeougfAvqssn1nzGxqG3uUD29QrY4+S+s2opd3v6dgwWXquvFt4FkR3ZZohMd4p4TgpRIUWjzFupY/ByyZLTUxIYZ5alISAcUa3B1g4aoGRcg9pOaDmTEs8QNt1KxTxisUXhbUQ/9S7rLHIvJe1lolTpvzNpjpuaZkrtYkUajR7aHOpiOkvb1/lxJve4F4V6Mfi9zmpvr/0/0Z5os1z06C5m8oDf6aRkOy6JQ1650nxsoSN5bSQoyhvW2HSXg0YbxYUDn0pcf2cyGJL7tTAeKnecfV8H7EsVQEARAaEsbyb+u0qubuttIFlwIEf6BM7XTOJ+anme7+E8BFS7CGuRk9EY/3dcgzcUr6bvHS2g0tbX9Q98zExDPaCuDyKSvnbqvaI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(70586007)(40480700001)(8676002)(36756003)(4326008)(40460700003)(336012)(70206006)(2616005)(82310400005)(186003)(1076003)(5660300002)(426003)(6666004)(47076005)(54906003)(478600001)(6916009)(16526019)(81166007)(356005)(82740400003)(8936002)(316002)(26005)(83380400001)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:38.2058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a899d3ef-f53d-4a69-f64b-08dada03af16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

[WHY]
It causes regression AMD source will not write DPCD 340.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    |  6 ------
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 14 +++-----------
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h     |  1 -
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 342e906ae26e..1ca3328b492c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1916,12 +1916,6 @@ struct dc_link *link_create(const struct link_init_data *init_params)
 	if (false == dc_link_construct(link, init_params))
 		goto construct_fail;
 
-	/*
-	 * Must use preferred_link_setting, not reported_link_cap or verified_link_cap,
-	 * since struct preferred_link_setting won't be reset after S3.
-	 */
-	link->preferred_link_setting.dpcd_source_device_specific_field_support = true;
-
 	return link;
 
 construct_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 905642349ba2..af9411ee3c74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6584,18 +6584,10 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 
 			uint8_t hblank_size = (uint8_t)link->dc->caps.min_horizontal_blanking_period;
 
-			if (link->preferred_link_setting.dpcd_source_device_specific_field_support) {
-				result_write_min_hblank = core_link_write_dpcd(link,
-					DP_SOURCE_MINIMUM_HBLANK_SUPPORTED, (uint8_t *)(&hblank_size),
-					sizeof(hblank_size));
-
-				if (result_write_min_hblank == DC_ERROR_UNEXPECTED)
-					link->preferred_link_setting.dpcd_source_device_specific_field_support = false;
-			} else {
-				DC_LOG_DC("Sink device does not support 00340h DPCD write. Skipping on purpose.\n");
-			}
+			result_write_min_hblank = core_link_write_dpcd(link,
+				DP_SOURCE_MINIMUM_HBLANK_SUPPORTED, (uint8_t *)(&hblank_size),
+				sizeof(hblank_size));
 		}
-
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 							WPP_BIT_FLAG_DC_DETECTION_DP_CAPS,
 							"result=%u link_index=%u enum dce_version=%d DPCD=0x%04X min_hblank=%u branch_dev_id=0x%x branch_dev_name='%c%c%c%c%c%c'",
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index b4eddd83b330..73f58ac3b93f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -149,7 +149,6 @@ struct dc_link_settings {
 	enum dc_link_spread link_spread;
 	bool use_link_rate_set;
 	uint8_t link_rate_set;
-	bool dpcd_source_device_specific_field_support;
 };
 
 union dc_dp_ffe_preset {
-- 
2.34.1

