Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5717BECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D934010EA00;
	Thu, 22 Sep 2022 00:19:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD2310E9FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3MeWAMOKJdUs6GfFEwOtJEElbMGR718Hp87hTZdekxfEwD/ciHJhd72u+Wo/53hDbCbI9o9aBIeint04b/yKmJtY2cSj1CVTmtUy8VOHQLPHwcaXG3sG9S26UCKATo9ATM8q0el3J9zikmXxeRXe71mzpCRQPrWh4uV1nNhH+loQ8lWX7b6obYSWOVC9Q7yflWF59/rDO5GMsJL04FvYerVUtDuEKWtltTRoc41F9yNTIrUwms/DLZv3VgeF55S3wnOxxrnesUybknd6gGDBcpRDNPKTFI2e7GnF3MK9TN4d4NO7rr8J12VPlJqOfRoQOX87EaoU8hpNta1QILZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYh+0sM+9xa7JNzgxa4zlG7dEoy3G4y19MMg+kpYAR4=;
 b=Z6bX6JLVLoGGz3UXPxbCek4Hofm+WmMN5hPUVxhMDvXqYi69isVMcpSCjl0gRDMAtTYG7ANo7WAbKbdat/OLSSaURiejbPLkUyotxTx1yH7/pK/MamZR07dg7kKI6UIvadHnKVPl5XHLxAsyjKd90lyZa8mIrGvydW5Qgw3T5+KYlPiV3k3ODNCIHrf/VXu+BDfS1r6DEEM6T11oR6Qg0PikgwsvNLEkUDJqwI4mbH+dFOACeoxn4pa+LXxRDLzW3yGoOkhqkfcd8uLXRkPSrfnycugh5rHDCZ9X5es4Nfsyg8NajkRC+ebs6SFuRM1xGuZeNQvvDv6HTFTXJwuaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYh+0sM+9xa7JNzgxa4zlG7dEoy3G4y19MMg+kpYAR4=;
 b=ZqTEMco7wsTwxnEFutOFPREVEZm798p/254SnqGd9Zrh6yfEQi4mSg+ewE++GvDS7a4I8iQhIujHS7i4YwwvRgb9Y6Yhdq4wJmOS683QOOqCVmJrqxl0LIE+xsGY+/soq7tAQuM2EiHrjwMtXfuvCXkRM6lGxkfprFzzA5JIkTk=
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 22 Sep
 2022 00:19:12 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::d4) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:12 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:07 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/31] drm/amd/display: add debug keys for override bios
 settings.
Date: Wed, 21 Sep 2022 20:18:05 -0400
Message-ID: <20220922001821.320255-16-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 37815771-1e4e-43cd-d6b9-08da9c30136f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xh4VV/adXcets3vIB9A36tLFkP2sueSxGrTg8f6ewxsBDFV+kOqQtd2W4xHtBs+eK9HeE11cQpR/nQztPyoyAz3NiFAYB4V+z0/77/D7/0GpRj3LBMHYkPZHAx/qknjf0hbhrCLukh4fUM4mt+zqg4jYIOxeoznBXRwvRYjl4Nj6f4773Nos88yY0b7rVZ59PEhbNM1KvVW+X/DVgo9nZ7Icbm40qwWlsrLq4uij1liLG069zk2YrpUphXDRQ1/KjZiie2qR3zgTG3Pu/EYkDHgS1J3GgTWX1equm3GEFkgyd+nPeGS4M6EndHupQd1KDSTifjW6+TccaBiXURMrgEceJ7EKfabfAHm/Z/UAUJrOl49YG2pUsDlX5XrMouR7jZrUf0wdTFCTtyG2eqKPZU9QkmhnG5redKwyLgvSHGnWZcm0J7Qj+GO65O6eeFHiSEy8AyI8x/QIdxVNBkZwQuR+xC9e1F6I1DPTDZD/H9rjIpuVddiRZG/HvkCh55bsHJ0GiLOZXOIWeJ7/neVNmZJ+U5BwkIsoX5W48FcUsFKC2zk8BUsF3Phj/s+jWEb0yFj7m1H9c3s6bvnwYhUnOePDfRxJj9bON78Dodxx/+FUG6TdR4LD59cKHqJ5ht4L71UZVvKxQ6PT76OqaVvaNeE2dljB2QIlkwH5QPAmMGxoirM9TKWgyR/T4ZiLlvPNByy7nxH/JG4ty8qc05zXuBtuo+oW2iEG9Jv+pgF1n2JNMPDQbkG4+EQfKR0C4YfDMWar58NyKcQcaTu60Iy9iZK7dEQb5yTnPFZFdOU0cE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(6916009)(82310400005)(54906003)(41300700001)(478600001)(316002)(36860700001)(81166007)(83380400001)(356005)(36756003)(82740400003)(426003)(8936002)(16526019)(8676002)(186003)(2906002)(336012)(1076003)(2616005)(47076005)(4326008)(26005)(70206006)(70586007)(40480700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:12.3712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37815771-1e4e-43cd-d6b9-08da9c30136f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
adding debug keys used for compliance test.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 21 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 5d70f9901d13..53b077b40d72 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -24,6 +24,7 @@
  */
 
 #include "dm_services.h"
+#include "core_types.h"
 
 #include "ObjectID.h"
 #include "atomfirmware.h"
@@ -1374,7 +1375,7 @@ static enum bp_result bios_parser_get_lttpr_interop(
 	default:
 		break;
 	}
-
+	DC_LOG_BIOS("DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE: %d tbl_revision.major = %d tbl_revision.minor = %d\n", *dce_caps, tbl_revision.major, tbl_revision.minor);
 	return result;
 }
 
@@ -1390,6 +1391,7 @@ static enum bp_result bios_parser_get_lttpr_caps(
 	if (!DATA_TABLES(dce_info))
 		return BP_RESULT_UNSUPPORTED;
 
+	*dce_caps  = 0;
 	header = GET_IMAGE(struct atom_common_table_header,
 						DATA_TABLES(dce_info));
 	get_atom_data_table_revision(header, &tbl_revision);
@@ -1423,7 +1425,11 @@ static enum bp_result bios_parser_get_lttpr_caps(
 	default:
 		break;
 	}
-
+	DC_LOG_BIOS("DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE: %d tbl_revision.major = %d tbl_revision.minor = %d\n", *dce_caps, tbl_revision.major, tbl_revision.minor);
+	if (dcb->ctx->dc->config.force_bios_enable_lttpr && *dce_caps == 0) {
+		*dce_caps = 1;
+		DC_LOG_BIOS("DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE: forced enabled");
+	}
 	return result;
 }
 
@@ -2994,13 +3000,22 @@ static enum bp_result construct_integrated_info(
 						info->ext_disp_conn_info.path[i].ext_encoder_obj_id.id,
 						info->ext_disp_conn_info.path[i].caps
 						);
+			if (info->ext_disp_conn_info.path[i].caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN)
+				DC_LOG_BIOS("BIOS EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN on path %d\n", i);
+			else if (bp->base.ctx->dc->config.force_bios_fixed_vs) {
+				info->ext_disp_conn_info.path[i].caps |= EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN;
+				DC_LOG_BIOS("driver forced EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN on path %d\n", i);
+			}
 		}
-
 		// Log the Checksum and Voltage Swing
 		DC_LOG_BIOS("Integrated info table CHECKSUM: %d\n"
 					"Integrated info table FIX_DP_VOLTAGE_SWING: %d\n",
 					info->ext_disp_conn_info.checksum,
 					info->ext_disp_conn_info.fixdpvoltageswing);
+		if (bp->base.ctx->dc->config.force_bios_fixed_vs && info->ext_disp_conn_info.fixdpvoltageswing == 0) {
+			info->ext_disp_conn_info.fixdpvoltageswing = bp->base.ctx->dc->config.force_bios_fixed_vs & 0xF;
+			DC_LOG_BIOS("driver forced fixdpvoltageswing = %d\n", info->ext_disp_conn_info.fixdpvoltageswing);
+		}
 	}
 	/* Sort voltage table from low to high*/
 	for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 30274e8a6d23..ccb5395a8a90 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -406,6 +406,9 @@ struct dc_config {
 	bool ignore_dpref_ss;
 	bool enable_mipi_converter_optimization;
 	bool use_default_clock_table;
+	bool force_bios_enable_lttpr;
+	uint8_t force_bios_fixed_vs;
+
 };
 
 enum visual_confirm {
-- 
2.25.1

