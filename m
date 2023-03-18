Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3966CC74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB55310E456;
	Sat, 18 Mar 2023 07:58:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BB210E45C
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsD2w3/S5sjh7yYRWU5b7tBoOAHzKlGprY0D5GEbHrnzvQgIu9ZANvTi7q51iyhZHKeSTxSmJFZnR8XKwBBXahHWL+NsYfX79kO0VF8aHNgNTgsDHobrUlzxNgWMGIY2m9yOwVe1vlm8uGNXvFe1GpgeX/Io17uzu464lUSvoLaTSI3nrCVAkBo5m3vzAC2N+kUIgLIgKxlnWhn5Du0pi7kTSq6qcFlxV+6vYvJWAsdaIF983f9MxczfyiMSYiV0Qd9tLcCthyTfzM8OR03YWoKERZ5G2A6eXyYVYlZS3IeSQ16qwStT7lQB+2IRosH5FinAQ6TY26rUEiGUSLrUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdmJ2GkhzpB9oZUOeSHX4W4b+ms5kPjJr+h80ygrEvY=;
 b=a94u6hNXPWh9NHKXKVfny3uNJsD8RGTREP3Qvm4gBfrcgkK50ohxnLO/OaBOAzFg/ef/dM/3nBs2WNtMzCrprBQdaLWb5BqdtJ6NZKJzNtqU6Ypk481F53hAlimN/eE/4m36LU0uHgcVE0XczRO73Ra9YSNT/dCXAVl7lR20K28c+KgTyfcOyaNiXIWuisCa9kszcJt0FZ3GUGCApk1EmX6257ajzvnY0gBjF9lQq6yJpzHUlm/BMWMnP3V1+wOaeMC5ndOcbu9qVVm76XH3LCTMYnBP4+UkVWCBH7fzDRhr0bYVtv9NhGcQocNXiqig1Fvs75qnpWN//ZZsFSh/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdmJ2GkhzpB9oZUOeSHX4W4b+ms5kPjJr+h80ygrEvY=;
 b=GXjPUglacaBp7+RUfhLY1wDqZucIPY2TRYZCIb+ZwWT9QSSR84leEGZjCxvBSvXuF+M78a4tc7UskF0v3SZbSXEWu5quH4HHQpZ6R/HV4MwyRiEVbJTqwq0Tizx6DQXyn2w+W8yJDbeWJOWLUe6ZCjGmR1Pkml13fMAf6ACGNEk=
Received: from BN9PR03CA0079.namprd03.prod.outlook.com (2603:10b6:408:fc::24)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:58:08 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::5f) by BN9PR03CA0079.outlook.office365.com
 (2603:10b6:408:fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.18 via Frontend Transport; Sat, 18 Mar 2023 07:58:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:58:02 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amdgpu/smu11: enable TEMP_DEPENDENT_VMIN for navi1x
Date: Sat, 18 Mar 2023 03:56:15 -0400
Message-ID: <20230318075615.2630-20-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: c2df7a52-b87f-441a-83f9-08db278682b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2K6vrLqg2Kl8dRR30ldds/cKMK9/9IdvN+6zpef5ORgQA7KEh/W8a4RMuAxia8Wh5bK9cqRimhD8EOx+wGHaHRa249fznBKfUZEYa5kVRRpTpvegUzXed6DO90GZ+77JOxIppugb5QWqVVPmIiAfhfBn0onaBiw9vLNoztztUlv5GeKAOID6z0JQnVQpFJqJVV+d0o47RJCSehwzAfOApkBDUnLb2kAFBzb8ZUQS16oLRax80buFzO9yo4MT/1RP6cnZ0HJuZHvhDjnrVNWYxBxMIYr2QAn6lukGLyOtEb6JgYD2SdaSpgFU54PThMBrUHPgFcJlumolKDZtGh2nL3Q+meTldFDUYSIWu4Q/gDYxF15dBUDBwvyPmmPvDgrRaQE5PZHObAt8Qz2VAel/ldGCamu2ndQOiphPxatrnRg+f1ZtgwgIpfscXhg+2hz14Mdz6VkBasIBrGbR1aHk9RNVbSp+6oPT0GyS071od29j4Qd3CHJet96bhHuBjOyoaT0Jy80vBYt/E8oNSotQQ3VWWJnh3aBkrS025nLATYwlqHuOwr2a1c6WNkMsSAn4wxGU06kbp0o5d6xDffj2bReTiTtuXppfdkt6TB39mpY1y/IZ7rsb4TeaetVtFC63D/chzxIuI5f8MpySZhdKHBpJzsXiN7OJT9x3mYYmXm9qyDXL2SIzvQbR/fDmweTDOm/nRxdW0gid0ZkvhupOjNg8Sh6BFgvQfeLRdVT0Jqs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(336012)(8936002)(41300700001)(36860700001)(81166007)(2906002)(5660300002)(44832011)(356005)(82740400003)(86362001)(47076005)(40480700001)(966005)(426003)(316002)(70206006)(8676002)(6916009)(4326008)(70586007)(82310400005)(54906003)(36756003)(83380400001)(478600001)(2616005)(16526019)(186003)(26005)(1076003)(32563001)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:58:07.4885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2df7a52-b87f-441a-83f9-08db278682b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

May help stability with some navi1x boards.

Hopefully this helps with stability with multiple monitors
and would allow us to re-enable MPC_SPLIT_DYNAMIC in the
DC code for better power savings.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2196

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 95da6dd1cc65..c4000518dc56 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -304,7 +304,8 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
 				| FEATURE_MASK(FEATURE_APCC_DFLL_BIT)
 				| FEATURE_MASK(FEATURE_FW_CTF_BIT)
-				| FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT);
+				| FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT)
+				| FEATURE_MASK(FEATURE_TEMP_DEPENDENT_VMIN_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-- 
2.34.1

