Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BD4C76195
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3525910E2AB;
	Sat, 18 Mar 2023 07:57:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C73310E2AB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrFUGk/+rNJykz2TH+LR0OW+q3tb8OcQ8P7taDIsesS5HpCq1jSTjo87zGuITdezeg6y2C2c9DJqi1XiSzwY60+aod0he9dfgFn65B7IOP58vbYKKlT7lw0eyNonklLg/OwvkC6svs0Fi5YRk5o/R0oA6A/DiQ332VIAvkoRIObEnw3lOp10kbZFiP4UWRpgjOgGTxeTNqIFlZLomU2SmkfabNPGv78sKUnO279A/tKunhjLanVR5kqGpl8v9uyX8gegD+e2sHUAB0Q67SvUbYSKLANwdOg6dP+A9x19b1yYimJPLuYR0xZTelI3jaqHrN76ZaI7APG0wdvCCJkfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TC0+4DBb1gitqqYpq66NxPRePrGg2Zm4qzikN6E9Mo=;
 b=flPMRVnIlYQzo1PyrayPfzk17b4AFdFL8KmVMq6387ZZfNwRrMI7qDHjwUt3hBYeK2TpIfxDVTd8PfsL6Vs/0COFseVJ5eLOJlelMsYmyU7kesHazD3Cmq6ULSGUMQ79qeOJoaOrkxu/8rsIAbk2vno4ektH3WOZqMB19YsvXnFEXrY0WfZwIqIH1jHV6cFlfMQS2cKePYG70jZaaeoSOh4nV32sTCaVxRSuXQ6ROH7mTWvS3AKZyGPeh6AheOa+KJeRqvbpmtPvWonWNjlXGHsIqaTa4cuPvoH1duoZmkL5x7W5LXOY0qjGr3VS9Cy/V8gWYkXPV1PAP3DOmgzBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TC0+4DBb1gitqqYpq66NxPRePrGg2Zm4qzikN6E9Mo=;
 b=G4C5LD9xAkeQo8D8bii9fgL7HYDh1idGqODjfTbz0cy9KJOwupKhYUBP709Ez1+oxOup4naJmCMKC8KazZveJVGZHsLHBf21Z02yri1IdxrivdCOrMdPdGuEJHu6oidl3XoQUjbgFopMgQjksJj0k0hyBM6a+lnev+s6Uqx10Ng=
Received: from BN9PR03CA0521.namprd03.prod.outlook.com (2603:10b6:408:131::16)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Sat, 18 Mar
 2023 07:57:10 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::a4) by BN9PR03CA0521.outlook.office365.com
 (2603:10b6:408:131::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.10 via Frontend Transport; Sat, 18 Mar 2023 07:57:10 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:56:59 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amd/display: update dio for two pixel per container
 case
Date: Sat, 18 Mar 2023 03:56:02 -0400
Message-ID: <20230318075615.2630-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 2315e95b-406c-41c6-e954-08db27866082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWS7uJ6IANfm87iXIhx3loWTVBBNCm07hPiGRMxtDbGxoa4nWNINgwIKF+naNYnfhnhMDqFn7fSUZeNtHs4oOHo0CK8gZf+7aO9f4GyO+Hr2luscKxsu/poX2caW46+ETcQuHDUImELEYXio+yxi/6RdyUyrUS5B/iK004D8elmkXEzWrsMs6j159FPjsdoaKOBNowFJ2oTXh9joWLWcSH9Apna2iT9GwfqRTkLCM3Fs3UqiXEupzZ0aD+1QH7Y3aOUXmvNF77b+2MtieRLt0wZ3QqR51DjW+2RDTmWpZfRn8/mhnrohxR0BSwjSBqQHqF+Uz1tdy/7bX9SdB1bhA75iB91vmbKCQok9KETJLrQSLYw1voqyAHb5DPleZ4iB516+W6TzZqWG5XqUp/Ofe/Zfg7Sn7ntCckka43BMcpaBZUN0pR1LHN94+8XIwAsrklZqQv40xGJ2YzlAkSR5/VXs0UpAguqs0WQWpv4Jz+Upr8VWqyI4CGprEPNw1904a+AY0jRnrGgORS6z9NtReBxyn0M+EnKDsb6ZQ5voVSjXTUjrL1yr1TNjc5Ur7n2JdrV4+b6tZDwA+TdGg1HVc5orpcUkkxjCazoGtDh5kkSlRE4ONUDaLJJBcpK2vxFbEqtELsEjJapQXfG7yzM+V1zSL8/F+Ij6UTun3YPnsmTg5YhyU20zMSw3CB81cjBrPoS46RNMV4MH4Gu8ttXZbhQH3Q47AAHqr8O2vgrJXOg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199018)(46966006)(40470700004)(36840700001)(44832011)(36756003)(40480700001)(6916009)(8676002)(8936002)(82310400005)(70586007)(41300700001)(4326008)(2616005)(70206006)(316002)(54906003)(86362001)(5660300002)(478600001)(426003)(40460700003)(186003)(81166007)(2906002)(6666004)(1076003)(82740400003)(26005)(356005)(336012)(83380400001)(36860700001)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:10.1037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2315e95b-406c-41c6-e954-08db27866082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Processing rate of the DP encoder, must be programmed to be the same as
DIG_FIFO_OUTPUT_ PROCESSING_MODE in DP mode
0: 1 pixel per cycle
1: 2 pixel per cycle

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index c72448125976..89de64f18040 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -286,6 +286,7 @@ static void enc32_stream_encoder_dp_unblank(
 		uint32_t n_vid = 0x8000;
 		uint32_t m_vid;
 		uint32_t n_multiply = 0;
+		uint32_t pix_per_cycle = 0;
 		uint64_t m_vid_l = n_vid;
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
@@ -320,6 +321,10 @@ static void enc32_stream_encoder_dp_unblank(
 		REG_UPDATE_2(DP_VID_TIMING,
 				DP_VID_M_N_GEN_EN, 1,
 				DP_VID_N_MUL, n_multiply);
+
+		REG_UPDATE(DP_PIXEL_FORMAT,
+				DP_PIXEL_PER_CYCLE_PROCESSING_MODE,
+				pix_per_cycle);
 	}
 
 	/* make sure stream is disabled before resetting steer fifo */
-- 
2.34.1

