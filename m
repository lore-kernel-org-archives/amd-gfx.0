Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEA2C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E55A10E7BD;
	Wed, 10 Jan 2024 21:58:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C4110E7BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ8XzhR+soVsgPz9met3Tu8m9j1vhyRtfZb+IcEU4vKI057fUQNl8alvrIeV4l7uw7yDeju6k6qZVBJMyiB96+E1YyV6AGbsKOJmClpZAEUF5xzzLwoSnYpi6CB7XCUB30ILpvTZt280FXteEme8fR5O0JOEm3SiXN4Pd1xTGPkAWyfndTqW4eRHK270r1OTJqXCADQjhy1lOBVgcvQLIdiL4f0EkYJW7QwA7lG1LF/v78tcV18lkTsKtn4q/kOJqj9AL7Fv7pf4m8Y30LVrH9EjUk9BnpTkD9jXnZfTYzUgN29YaPeIRsO3ZB3wPxlEWFmdV/TPtZ/txMS33+mx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8SvNvVpLMhUJIJ+n7JiKWsHFjY098UlbuhRCCuu+vw=;
 b=JfF10kSUv10Y+RUsc6oCsUNkodNHNxjLe29TZm5JfSOZAEA37htjQ1TTt7IW9nnLFqIKh13KPN0sQ36pbqufPvrXINFwbgknsu+7qWgkOzc3avb8Y4uuaMSfcbN70ldYyiPe2gF7MU0pE/WisWvMu8Heko4na2rZnCNVLqk60KejQnPzcB+ckSs4BuvhYIRLv04Do+jAUTuRvrTYnOVkQI5BI0R6Geg6xQoWt1iNgEliOVBenWz4mY2EXLR9ey/RxUWh/zK6NnC2zrAVFPICeHwYpXFleUgTUYnvs7s0OQu1R6tj1EOjj7ihd3u8zP8q9TvhYLPPIwiwieoUjHdFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8SvNvVpLMhUJIJ+n7JiKWsHFjY098UlbuhRCCuu+vw=;
 b=39GwrY+hTvl6CDV+0o/EMo9XoSvBhoVMeKIpREYr2YzULJFUX4HqGlxesQEkgkbderIKjJ7QZsPeHJ19XbxwXPEO+ekWrf3mAcyyv5fAoZLIAe4bNsK5xqKs2QAemAxkAri6X+lNycfzqGkTYxKCWHx5ELBsCsA4LiHMJ2D9Dic=
Received: from CH5P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::8)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:58:25 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::df) by CH5P221CA0021.outlook.office365.com
 (2603:10b6:610:1f2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:58:24 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:58:23 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amd/display: 3.2.267
Date: Wed, 10 Jan 2024 14:53:02 -0700
Message-ID: <20240110215302.2116049-20-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c3bbb7-7da3-4cee-3e62-08dc122744f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qpz2uu1xdez1II7gqeuVsZSMCLez2Ui613ruI0R0tqqdOtduJY5qmDLynyeYvfAQHd3VISRFOgybbe06GwRDuHzpvxq+4Sd2yvBjRU3VHQ70G6l+2dtVAC3KMkwjaASUYfqzV79xa6ME1hR7Yl/HuZ1laHUvNgs6gu+MJPMP8ez2Dq9ApKUW2q/3mAzpFdvGqTfHdiDYkud0WMzn0BfLZFVI0+6itQcCIAKPaaioXJ73z6Rxt1BS0f2BbV4Q+OboQXY6uK9ms7uByUxnYgntWZDhl+e+ZpH2gCYDBUuFuNeAQI3f3vUM09zT5vZut0Ka1rDU9hhUgyO6Ne+/loX2/+x99OMkCe1XB8g73IgR5ZqZv9sD4lvt/VMtmvgy3ZPPakeW7Li5sEqQX+PptwCbe/A9S44MCL8OcglF8CnmsHfHfdZEpR9CkTH5oTdKsbv6tLFk40eBmkxD9uPw18Jo7L6AXh9Zphn9UJ8yf8zCrI8vHhdxUpw9m6jrQCYYMlkNQCICXJ5mjolJSBdoKThCrtmkDV9qm1FTi/EtiWPHKLF0g9RaUPQyp/isU1rNFB/ckZTX3JRSrZ2k+8gyiZvXR8bOYcXZSBZFImyAuZGv6zOkr5iQOUcUY+kPNtlJPLhXb78JOEByUGUvUCfbDXvrpPz+dVilNdYqpaBQCRZyMzl+cQhFyvepUcUayzhDs7EmPAzoQinYvaR2FxEuucMQKAHj2uVVvPSksdv1bIL0y1qYl9otjY4rhdRQn6xD/ctN90JGIDwhLifQGCHQY7WPTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(83380400001)(86362001)(70206006)(70586007)(41300700001)(356005)(36756003)(81166007)(54906003)(82740400003)(47076005)(36860700001)(1076003)(16526019)(426003)(336012)(2616005)(26005)(5660300002)(6916009)(2906002)(7696005)(316002)(44832011)(6666004)(478600001)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:58:24.8802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c3bbb7-7da3-4cee-3e62-08dc122744f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

- Align the returned error code with legacy DP
- Allow Z8 for multiplane configurations on DCN35
- Set default Z8 minimum residency for DCN35
- Rework DC Z10 restore
- Enable Panel Replay for static screen use case
- Add DP audio BW validation
- Fix dml2 assigned pipe search
- Ensure populate uclk in bb construction
- Update P010 scaling cap
- Reenable windowed mpo odm support
- Fix DML2 watermark calculation
- Clear OPTC mem select on disable
- Floor to mhz when requesting dpp disp clock changes to SMU
- Port DENTIST hang and TDR fixes to OTG disable W/A
- Add logging resource checks
- Add Replay IPS register for DMUB command table
- Init link enc resources in dc_state only if res_pool presents
- Allow IPS2 during Replay

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c9317ea0258e..1d052742d4c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.266"
+#define DC_VER "3.2.267"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

