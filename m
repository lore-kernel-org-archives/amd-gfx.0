Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52365CCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E8B950D4;
	Tue, 12 Jul 2022 15:42:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02E7950DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MssBbN3rMmiwtWMhGoJ95REztTc1Bgryzyckk/MdBT4xTVInu6EytM5jyYg2FzHR/1+KP5oxTdkelCp7NT/Z49TRlnCua5ukpeOpsQE9dWxBJOma/lYqIVcyAuuLet7rHXhB3r/0dj3Jh2fT7NvOuHw5OEVnTs8c7ahPr9WFK/495X775ohqGU2JwKqPOl9c4hSZGpve+VyzyTn5HGDiyKIlbiSbqpp4zm7mgUIsyIOftlu2U1h60QaRcH01N8oo1sR55FmsChuyRPiFniw59pa6Gp9VtwplSJwI2SsPKsFHsJnwawScDQpSUXTERTykO9lhzcn8pzpxW6MkCtIEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HNJOqXwG2T1lIdV6QQvAhSVqmgglp7coHRzVYobbDs=;
 b=hoz5FhgA8eA6GSsgMdL2xgUGO1P1nC+o7FvxCKnDws8E76C33UZhs1kQB0iU5Pqn3jQAC7WOfj80vFKkBsrzpd/oNIKTAbRhspvOCyfmUQHQbSHQVbY5g9z8pn4qtHSglDC8UZ9WhnQcAp1zuJVoTXhYSYAgaBmDHwJK9XwpyWRtlcEpccIK2wDYPXord+fVPdfG2ZymkGr/oXxvpqWkMmxirLSiyPYGTwAZjX7vj593OgjzJAZl9zYVvaqRmZnPjSFYa4Obo4Z76r1BuxaWwo5dvIX8fbSsc2QdOrq5AeIAndBlucJy2dxf7DsuhEwvaP8yn3ys1hTl+/KKyx/x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HNJOqXwG2T1lIdV6QQvAhSVqmgglp7coHRzVYobbDs=;
 b=YB70icEamBIxuidsKna4Cu5dOZCoffTDn+77/Wf4Y6AsU5eerDXUSPTae0SVXF66EvpU7qLZBVkpVMEsP92Esqi7pvzqw0GWOXiAtHLS/mh03tayEpdrVjq0coOdBhJA7QvtCFx1NiIdm11YNOhxL4LDT09CgvsMkOCSzsfYGng=
Received: from BN9P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::26)
 by MN2PR12MB3264.namprd12.prod.outlook.com (2603:10b6:208:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 12 Jul
 2022 15:41:57 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::c8) by BN9P221CA0007.outlook.office365.com
 (2603:10b6:408:10a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Tue, 12 Jul 2022 15:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:41:56 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:41:51 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/21] drm/amd/display: Fix wrong reference
Date: Tue, 12 Jul 2022 23:41:33 +0800
Message-ID: <20220712154133.501620-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c922901-b9d9-4761-f729-08da641d0d07
X-MS-TrafficTypeDiagnostic: MN2PR12MB3264:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CGg9/SpLgut6xUsVPuRGISRnxCFxub+9RpEzWXTZlQbtxdNeSQxiNg2HV2Rb0VUH+FFeF+8gPEQXJHUIs3OUyEQnG3cEGKRklel1kji9Ar1RlrZYUtL+DfOBSBogW9lVO/8wKOItt/vJW0HZlaX/c+X/qAVgeBboOr2SBjlHvSkLeUJVPU3gzSwPvlOkghzO24rLd8sx+w1BKGz6HGLCb1Lex1UbQ6TmzMIPlPwJHqfxxV/2nLhfSQ0JUVlocxkMebcQXFRooxSvEh23WIUxlu0s8NStKk4eqduJKccYLT8Z2eynJyY8GHFHD0dfXlit2pOwvMjFm9zEn4c4VXrVQbjn+Ss1QgyxVVTki9i+nEmqiI9c0OPlM3WLODeadB/qOhreRyMF5eRneX1RkUjylItlgfb8PoeVc3aavaIJVRbHOi22ELHkJS6TVq5/eNWcyvjprwwP3qSRDJjf829UQAxa3SknVcWgvL9GTsKy7mUb9IYQIsDFGO4vegxaWvSMM0GuMarcWdchHSEI90llfwCxutGOlxsFuglCjzKKHoKyo0zinu/nyh9QH8w9Aec7M49rfMoYz8kGttiBZQK3Qhyvr/IsmtOz2si/JpD2vPuSjn6uM9QeGp7JLTuOj69JHiNt33YQzPZsFoKYF+eUfcGWKSrnxrWQ2tmGbTDAdECiq+kpAwJTQ8afGEFDQsTxq7ITgPHIZRDdv9sI1m39Lp3Flh5c7ikC3Iu6sp+yinoFKqaUHU+2M8lNOagPdBeYExs6iVsX/8GbrKZFjdqNGafBj52Z87GWVmglRq5zXfcWjuu+8FTwLQ89Q9OXbERKIxAchav4hcFJhHKfK0jozAEWtoFOQ4rsFTPDuULWsI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(40470700004)(46966006)(36840700001)(336012)(8936002)(426003)(26005)(6666004)(83380400001)(1076003)(82310400005)(36756003)(478600001)(2616005)(186003)(5660300002)(2906002)(70586007)(16526019)(44832011)(7696005)(47076005)(40480700001)(41300700001)(86362001)(81166007)(40460700003)(8676002)(82740400003)(36860700001)(54906003)(70206006)(316002)(356005)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:41:56.1020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c922901-b9d9-4761-f729-08da641d0d07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3264
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
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

We recently introduced a commit that caused a compilation warning
because we tried to print a struct as an unsigned int. This commit
address this issue by adding the missing field.

Fixes: "drm/amd/display: add system info table log"

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index c2a5ab3e5f2f..09fbb7ad5362 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2079,7 +2079,7 @@ static enum bp_result bios_parser_get_encoder_cap_info(
 	record = get_encoder_cap_record(bp, object);
 	if (!record)
 		return BP_RESULT_NORECORD;
-	DC_LOG_BIOS("record->encodercaps 0x%x for object_id 0x%x", record->encodercaps, object_id);
+	DC_LOG_BIOS("record->encodercaps 0x%x for object_id 0x%x", record->encodercaps, object_id.id);
 
 	info->DP_HBR2_CAP = (record->encodercaps &
 			ATOM_ENCODER_CAP_RECORD_HBR2) ? 1 : 0;
@@ -2961,10 +2961,10 @@ static enum bp_result construct_integrated_info(
 						i,
 						info->ext_disp_conn_info.path[i].device_tag,
 						info->ext_disp_conn_info.path[i].device_acpi_enum,
-						info->ext_disp_conn_info.path[i].device_connector_id,
+						info->ext_disp_conn_info.path[i].device_connector_id.id,
 						info->ext_disp_conn_info.path[i].ext_aux_ddc_lut_index,
 						info->ext_disp_conn_info.path[i].ext_hpd_pin_lut_index,
-						info->ext_disp_conn_info.path[i].ext_encoder_obj_id,
+						info->ext_disp_conn_info.path[i].ext_encoder_obj_id.id,
 						info->ext_disp_conn_info.path[i].caps
 						);
 		}
-- 
2.25.1

