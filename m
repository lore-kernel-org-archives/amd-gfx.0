Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631A2C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FDA10EDC2;
	Fri, 14 Apr 2023 15:54:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6E410EDC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgYPHVXHfEVwDRw6YQCa39cpBx54u+//hVPKBetZlMNR9OimrAcRAqfsHMv1Bn5YnLBWN4cHuIfEIHhE7GKzxBl1OyERqZ6W2g+Cwu9BdqeAlbYOgNRd5glnvU0Nbu62VDsT2PEHOL9hu1AZRKJttdLFcApksnhZgildwR1ZJZ2D0ShJqh42sAQTY9kGsW0meHsYI2iUtpxsudlCgEY2oTp0aV4/xEfWvasMAHYeBq1pjS4a2c5DXUfIl/jqQ5Ivs/idJ6Y/GbvZLjwkHylUavtHr315hMvYj4RMCZSFF4pCOC5LQO11jnb5ois/PUt8siTgOqXrEdcX9rQabcw8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOUUXw5UtHo3J8KvQ+rfUBJWEWKYAEohDaBFE5p09zU=;
 b=M4kkapPH5lMzno0dUQMVrb9VDpFbF9hgK0zMQdi0pf2CKgQwSCCv2dS3F5+F7e/b+3uLuU2yXfJvcYOTd9IVNZ8SnMOmSvp74ZAHedMugmcJwqqgxkka1v/PHtG5yfYONCXIgm4tP1ghlXXpFjBbLTPGV6tjWUr9hwwrizRwGYCEZ4MrYSD6yKm4gbC/Ws6AphnanEp6p/aEsIdeIHNR6QSuRLubBPacZgCqMKMYyAXFLYy2WNlI26szj+Fq7AFikL/puCzmUNooUQNNzdDag/qwPt04gOUVJfUQRFMSqTA7WFMQClSiYN/rI0oR8nWW/RJJID2foMf5yfjgW1Az0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOUUXw5UtHo3J8KvQ+rfUBJWEWKYAEohDaBFE5p09zU=;
 b=wfKSUC32EeCi2WbpD9mzZ3sjJObXMhYkyRnD3CDYuzLDR5B1Yaiv19h+IjG68Ef5cT3ihMJOQLA6iPAyQTCoOvFR495A16lLKTpwswOG86pAj22j5sovx6gwx6+CbylM32HOPN70fSLl4Dnk7RWK7gVYJJYudGkBeQCNaN2LG7A=
Received: from DM6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:5:1b3::16)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:13 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::19) by DM6PR17CA0003.outlook.office365.com
 (2603:10b6:5:1b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 15:54:12 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:10 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/66] drm/amd/display: fix memleak in
 aconnector->timing_requested
Date: Fri, 14 Apr 2023 11:52:41 -0400
Message-ID: <20230414155330.5215-18-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 04319881-1ef6-488a-a98d-08db3d007dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrrVMLH65M5cvnWo6anYumvAo3bJj1WfMPHoJB3JgKz12CboZWRXKSy69NPX3BJIehKY8kZZhohZ0aF6uUj41Psx2IlBF34RfG1Vo6eJzJ7H7CoEywl+0XdiCvN/exKWsaudgjaaGkYDXSIy0/xvv+L3f2/17WkO5gdtjde6CQcBIZSPV9uZeGEeCmje0L8QjQLRlhwcJdc7fdBUuTyKMcwdYH7smYZyU11WmWLyDVOkyS+8MO16MdpyNiyfb3TFej8Ms23r9qnxm4Zdl0HRqPJTaD/G2isGGbm6m1TULuW6kf0AUF33Za5mL7koh5TFWp/7agvDxs1kz5akETjsbGronzIyDTmN0qPwGnf+vVspuSnHc9Ah2QNddcBbR8C9ywV3Jw2CjC/heXpZ7Z2WjQeglWBhFgEtLtIBo27PTLVZ9+lhCpiB7whDkZOz9+NY/EjFcXb18t/HsCQAGT+vzJVM8bYNEuQkeDSzem8GB37hJQJLPjepf9Z7rsESFYj/NLZ7HzylUiAQvuRSJIutX7yztnTVU8UKL29MLyn8ZIBwhmTSHOaohl3E+65ah4vDEvlF6fYl90J6eFHXn4bX9sxcGgVPLHidKVB2uPsZScJ42qD3iM/oxe+9L25WBqrG7EJ2UVI2B9Vszk9ILScPGEXz9rKyrYYrii3IHJ8C2qkgHxvQWwES9NUG8Ga+ix01M/HsgvY+YMNVpRC1isJIcxeGYoL6XBcWLYT7GhzJOAQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(336012)(70206006)(426003)(83380400001)(54906003)(47076005)(2616005)(70586007)(6666004)(16526019)(26005)(478600001)(1076003)(186003)(2906002)(36756003)(5660300002)(316002)(356005)(81166007)(41300700001)(4326008)(82740400003)(40460700003)(6916009)(82310400005)(40480700001)(8676002)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:12.5280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04319881-1ef6-488a-a98d-08db3d007dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
when amdgpu_dm_update_connector_after_detect is called
two times successively with valid sink, memory allocated of
aconnector->timing_requested for the first call is not free.
this causes memeleak.

[How]
allocate memory only when aconnector->timing_requested
is null.

Reviewed-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8b4a470a7e60..fa2acc017437 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3127,9 +3127,12 @@ void amdgpu_dm_update_connector_after_detect(
 						    aconnector->edid);
 		}
 
-		aconnector->timing_requested = kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
-		if (!aconnector->timing_requested)
-			dm_error("%s: failed to create aconnector->requested_timing\n", __func__);
+		if (!aconnector->timing_requested) {
+			aconnector->timing_requested =
+				kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
+			if (!aconnector->timing_requested)
+				dm_error("failed to create aconnector->requested_timing\n");
+		}
 
 		drm_connector_update_edid_property(connector, aconnector->edid);
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
-- 
2.34.1

