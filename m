Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF11EB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A1510E633;
	Wed,  6 Sep 2023 12:49:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC7A710E625
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlOM9iZyDd5d0ReKvMQLDh3u0gj8GlYRnGQncCUG3OR96SLm5YSIegujZthltxMjXq6jnrhn2Te6g2bptIClkSQywZW09JEzOz0vyaYzcOIKvGNITtmbxEWd/cD30AWanKNoKnk88jK8e7iWlqlDEB+ZD0sG4ZpGtyYxu43Tt3JE8Nxn7s9mZ7VVQQUU9esMV5q5n5trEoJfYxBgxIKvnOkbvaRweSIFV/C+QkH8z7yPA9W/5EroYhyfPCZMBCnBsO0L70CA97LpNo+QqK51pzHxuI1ZRvvaPJciWCqZ36cBw+mwoFVNMGD/L3pH4RzvCT1O2HpkzfD7LadhG4uXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmDRngKYTGwsyQSMr/yg4v7EGxO5A1l6nzbruvafP8k=;
 b=Bh2ZjF97VXjBcwurkSCsD3aG2av2pS79SmaN9AXeN1Fu25u6BBC5WT3PMOtgujtwlxredM0nrzG0vN1k3KeFqkvKQeOqdPz5ieAo6fviv5v3x1VzEq6zOSnQc5XQgdhWr792lBuyv117rnwOMa3nBbIOqUVcZwkAT67LY7/mAKNsImljYzSY8V5ZBgQuea0qJn7bAohL8RFCh0R1/0a8ouUyv+Pde0pKttDzMOhplS7/pA29a+Lz74XnqBoeFyQkVeDFbVUVL1ngQMlYrN8hP01Eyqigt6teurR76yMxH8Bi/lizCmFbKK9XN+9j3FY8QuTut7ijGHVUr1EoDYVpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmDRngKYTGwsyQSMr/yg4v7EGxO5A1l6nzbruvafP8k=;
 b=cxz0KNIVu/PdC6dTesqsg94uND2/fqB4ozZ23WRJJHBajiitcSEA6l8kCZjZ/H5uS7+Ra/uXLfd12jaW1XFTIswlsxBE7URyiIO7pVbLRXVesqXDOQ7nqdLwv1ZtDyi0X0ge9D8V5r7So2Sk9ShEmHv9fhFsPFJP1HTFnuvGbIo=
Received: from DM6PR17CA0005.namprd17.prod.outlook.com (2603:10b6:5:1b3::18)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:49:31 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::c9) by DM6PR17CA0005.outlook.office365.com
 (2603:10b6:5:1b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:31 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:26 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/28] drm/amd/display: Fix DML calculation errors
Date: Wed, 6 Sep 2023 20:28:12 +0800
Message-ID: <20230906124915.586250-8-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bb8521-7309-48c9-668b-08dbaed7b6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qgjjh6s4PRpIiyi0GhLFiwaIo+qsMEbUX9znN1/+5KP0xOAXSjxvXVOKFrgsZcPmbVHWs76fSV8FyVB12qr97i8dN37gL9PF9+81cxpCKqn4SJRUkFwq3U9l65T5p1vlXWKN1wJ0HXMUEkTQeFDtTLVat9PnMPBfA+BdfhXZcMorF/CUBA4BwbBLgoJG3uFjRAf8zpVSYItLWSD9ooU4EW24ykHZZCIOFIusVHcJxQ1NSPxgBea0reUvGlfdYAANgpvNeBSZx1adKyGdT7E8T4oK7z0nc2ZvhYG4j6OCAf9FOM9eWboWz3zXfc8WVuFpSi0hosezUV7Y9YpQkNaLQuS4VihJc/3aa12D1QoUjnCGtIL9zV6b3hvatc40jB+iGZ6et/jk2s3IBLketYJGprmLxRsJuf6bRtSzvKPhUrClL1jrA3DVIn8c+oQSIACX/zdQ4RmgCMc/uDh6EJjX1THhJfSjaO5bmd2BsbXoT3z8dloewD7kTq5Rv1iYJ2r6NfzOHFcQfDf2BMAKN2fLszIpqLI2cl4x0DabCReAllZCAZMVpDmnC4jv/wCQbQeWrp71oHQNhBKXWSLF6jVAh2QF6G+LDXwvpoerGYdmLwb0nVxbD3NQU2K8d4X50VDB1sadwqXN4xaitKzE6m3m+a/vQQsnKaF4nreYiDObay/DsTKxVu4W564Bopv4kKqgk8HOzVQOm45Y7Cj1sYuu8a9+IhzQGuzlVJ0d8ttlnP4tWX0F+UNoyY70rnezeEDUjaA5g+qgC74FuwWmVoTDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(6666004)(426003)(336012)(1076003)(16526019)(86362001)(26005)(2906002)(83380400001)(478600001)(7696005)(47076005)(40460700003)(70206006)(36860700001)(81166007)(6916009)(82740400003)(54906003)(356005)(70586007)(36756003)(316002)(41300700001)(40480700001)(8936002)(4326008)(8676002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:31.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bb8521-7309-48c9-668b-08dbaed7b6ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
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
Cc: stylon.wang@amd.com, Nicholas Susanto <nicholas.susanto@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]
DML calculations differ with DCN3.1 spreadsheet values due to
translations errors from the visual basic code

[How]
Add missing calculations that set the value for DSCDelay

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index a94aa0f21a7f..88e56889a68c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -2311,6 +2311,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 								v->OutputFormat[k],
 								v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
 			}
+			v->DSCDelay[k] = v->DSCDelay[k] + (v->HTotal[k] - v->HActive[k]) * dml_ceil((double) v->DSCDelay[k] / v->HActive[k], 1);
 			v->DSCDelay[k] = v->DSCDelay[k] * v->PixelClock[k] / v->PixelClockBackEnd[k];
 		} else {
 			v->DSCDelay[k] = 0;
@@ -4719,6 +4720,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 									v->OutputFormat[k],
 									v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
 				}
+				v->DSCDelayPerState[i][k] = v->DSCDelayPerState[i][k] + (v->HTotal[k] - v->HActive[k]) * dml_ceil((double) v->DSCDelayPerState[i][k] / v->HActive[k], 1.0);
 				v->DSCDelayPerState[i][k] = v->DSCDelayPerState[i][k] * v->PixelClock[k] / v->PixelClockBackEnd[k];
 			} else {
 				v->DSCDelayPerState[i][k] = 0.0;
-- 
2.42.0

