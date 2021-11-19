Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346CAC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025E261283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 025E261283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BEDC6E3FE;
	Fri, 19 Nov 2021 19:43:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65A76E0D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8PFzSVXJUDThNkSbieZNabsKAighyrDwhusWbcPb47+iRw3bcMtINhwvlhFk8hObs4lKy0+6HrGodHFbiiKj3krM7L5yE3vFKQdkBinEWM9gAUAnNZZFG1IEExHkMiVJYOItjZ0Udss32i+whkF4UtY/nPej4masY2Tjybx7g0kzGcpvp6kgwOM6QOr9Sa5r04395LNuVAR2AtRJfapgnQexKgaSUgJXRyxfYmZ3UgEHH3DQhonb5kWw3FhsY3xiyCcdnAPQTE+4nYOnN3OziYs6eTPVMgBuG/w1PNqlKBj4Ogg1Loi8Mq1A5k4WT2IzsW5pMro4HqaMrnfp+KGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzcuHoIkURhroPH3S+v5T4X29GBYqFMt7NVEwKSvLFg=;
 b=ULcLve9GDC5/QhryKeZGjvkRadF7RJ5DabvVM/s4XkqPftSRqX8kj8TdxIf/wxzY1a+v1cU7SyPuAIzQhlsoOcfkwDtKIyoL+H8mxhF80LUJ77X84bEuKQQd9Cskgz4t2pUrnS1jCADRyMyi/QzsniC/7LRABYlZCqEMtkxz739FNxTLLR7LqGi5I48vjVCY2dQpILjwW50e0wRmVkKfQq5qdD5Joc5ftt5nwyVEv5/+dXYq93Fmz1SqKnvdpgJ2DM5lUdJ7Pkb3cXDVXj4Sgk0xJVYPz4y9y7NsA5l3ozmlN7JQ9su9DCWv/M9g0xdv0P0VRRknn5NcPJ07/s+4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzcuHoIkURhroPH3S+v5T4X29GBYqFMt7NVEwKSvLFg=;
 b=yvWstvL+C4dVdhAz/OhJnj5BOf3hRefi25w3onzLlVRsSJlRAq+fFbiPZjZEMrvRC+B4jVmy05DqTdwfKsdH+a2LnlET/yWn88+UoXprsZOx7zRhozyQKdEtoW3xqu6d2egZi00WCtOUjakZ1hLJOexn/5hhHSVPWdlwGmSe+7Q=
Received: from CO2PR04CA0101.namprd04.prod.outlook.com (2603:10b6:104:6::27)
 by BYAPR12MB3271.namprd12.prod.outlook.com (2603:10b6:a03:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 19:43:52 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::81) by CO2PR04CA0101.outlook.office365.com
 (2603:10b6:104:6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 19:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:43:52 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:51 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Run full global validation in
 dc_commit_state
Date: Fri, 19 Nov 2021 14:43:26 -0500
Message-ID: <20211119194339.97573-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d130bf-32d8-4688-8776-08d9ab94ea87
X-MS-TrafficTypeDiagnostic: BYAPR12MB3271:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3271C1C47D81E093C225A46DFB9C9@BYAPR12MB3271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgThoFkD5VLpt9ybGD8zS56c4QHdS66eolD4dGDa+yLf3Sk8Isa6IYnp6PSNc4zFbEwBkEYqizR3vs5c57QZHGczSiMbyzgHWkZ5t53thjuZZOFSU/v6gftE4Yf2xEnkkbklrE0pdafrPHGpS3JKuNAZToeXOCxdgjY1lDzkZkOXDMLEQW5Rj2cbSpK6sHdZgiBetxP1i+GkrmBDJuS0HiZq2tcywyN+7BAV1nBNcWyLygIeNbPTdBiQpfOWkpEiDgygIQslcm0r6aQmLavHH9NzL2gEYoaF4+7Y2+LPBrBmB4ki/KFUXgIlw+xN7kcDi2dF4uJowKvnmyWU+5G2ER4zeXCwAuVTflwyh3q6BS/VRCdeOfoa6+fc5gtrEdhdnQv5T1apQCunT6AIVZ6GWHGZMr+OOHweWKr2pUQBh2hywP+qY2eIFq6fzqLDNBsg1byaHRIUAjmKNzdayRlGQVo5DaDi0lYqupoCIHNilrq16ElCZuHtJHVC+5nsftBQOBb6/eGls5Ohx+VrHW6hUppBO4wBha+DCZff0YClSKkl8d/FIYwOxqSE9GB+qACvRm8luxKtoP9XQDo0Y64znpiWr+Iv90928WQ55FQ1Xn7at3J52CJUfg1h4bZCJPN5gCg1MfaJekW6U75wS9yoHbqf6V7Sq2Y3lSwGW3ED84NwCoips57/e7EaKq8bfiPtSoajb4f87dtyrmG7XNx43+M4xfvnY4Bh/YGc+gWza14=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(70206006)(2616005)(2906002)(86362001)(426003)(81166007)(16526019)(336012)(44832011)(186003)(26005)(356005)(82310400003)(8676002)(6666004)(5660300002)(4326008)(8936002)(36860700001)(47076005)(54906003)(36756003)(508600001)(316002)(83380400001)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:43:52.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d130bf-32d8-4688-8776-08d9ab94ea87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3271
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Dynamic link encoder assignment expects that it can modify DC
current_state and the links associated with the incoming state when
performing full validation.

This does not align with our actual synchronization constraints
in DM's atomic_check.

[How]
Since link encoder assignment only happens as part of full validation
we can just use fast validation as part of atomic_check instead.

This satisfy's DC interface requirements and skips the DML calculations
needed for pipe programming - hopefully speeding up things a little bit
to offset the cost of double validation during stream modification.

We already do this as part of dc_commit_updates_for_stream()
with validate_bandwidth(), so extend this to dc_commit_state() as
well.

Fixes: 019f278036a2 ("drm/amd/display: Fix concurrent dynamic encoder assignment")

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +------------------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++++++++++++
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c88054f8c583..729ab647f691 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2304,14 +2304,6 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 			goto fail;
 	}
 
-
-	res = dc_validate_global_state(dc, context, false);
-
-	if (res != DC_OK) {
-		DRM_ERROR("%s:resource validation failed, dc_status:%d\n", __func__, res);
-		goto fail;
-	}
-
 	res = dc_commit_state(dc, context);
 
 fail:
@@ -2580,15 +2572,6 @@ static int dm_resume(void *handle)
 					= 0xffffffff;
 			}
 		}
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		/*
-		 * Resource allocation happens for link encoders for newer ASIC in
-		 * dc_validate_global_state, so we need to revalidate it.
-		 *
-		 * This shouldn't fail (it passed once before), so warn if it does.
-		 */
-		WARN_ON(dc_validate_global_state(dm->dc, dc_state, false) != DC_OK);
-#endif
 
 		WARN_ON(!dc_commit_state(dm->dc, dc_state));
 
@@ -11126,7 +11109,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
 			goto fail;
 		}
-		status = dc_validate_global_state(dc, dm_state->context, false);
+		status = dc_validate_global_state(dc, dm_state->context, true);
 		if (status != DC_OK) {
 			DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
 				       dc_status_to_str(status), status);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 39ad3854bfe4..dd4ea98749b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1827,6 +1827,19 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 		dc_stream_log(dc, stream);
 	}
 
+	/*
+	 * Previous validation was perfomred with fast_validation = true and
+	 * the full DML state required for hardware programming was skipped.
+	 *
+	 * Re-validate here to calculate these parameters / watermarks.
+	 */
+	result = dc_validate_global_state(dc, context, false);
+	if (result != DC_OK) {
+		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
+			     dc_status_to_str(result), result);
+		return result;
+	}
+
 	result = dc_commit_state_no_check(dc, context);
 
 	return (result == DC_OK);
-- 
2.25.1

