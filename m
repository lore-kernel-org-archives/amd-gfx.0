Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FC4D10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BE810E605;
	Wed, 26 Nov 2025 13:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="od8LEipU";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62ED210E605
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uztVyhlEvah3D4ldzFpPlFDLVhse+VHO+4P7vzcfFwNmJLOypoEt+L4XZPySZmUcse5ae2GfIvKfVia64Ym7pmbmJSEf3b72ybU/jP5NhXy+njt+IlI8ezB5h5wb6fKR40Tr6xj5hYgxqQX+XDeHlxP0pgJC4C/5XmPiN8fwNCzwHMyT8sLw9jQ17IsVqpo9HW3aN21qC3GyzaiotRtJWt43wwBa4OVLVV1H+JTAKPaljsXsLQVaLcWKjorldOWTMrb10e163aA9uWv4t8hQ4LpHEjIr32vPFPuwO//LEDAwfuYE9Gr/HnhJ26WxpkPiq0hhLrCvrWTitUKdK5pT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jc9uDAsozOKTu81ujsO4vi174olaZMcZLrIGHVj+7Q=;
 b=uPmGCqLUMi/OIp1Afv+Q0gvkFyQOTu6cvYGEwnhmQpXvqMwdW5bqMsC68ARM6I69W607+07VYcTgrqN7XaZSr1YhqTP/LASzxIaLwcwzO302zsrL9epVRb1yu1a0d34Fj2ZfQXIMzCUoarXB260/a25870vCUt08+b7S/uvjBLGYiIQzZT5gablHZJysk4rbSNfKUuN/LrJT3vHoXeM+27PPCwVsVBDmb3iRMaUpyglhAYXHeoue5B+Jr4RiOcsmbX9Dmv3oSrQ5Beza1skGNlWGDFh6ygA5PSPEGUOMpoE82U3rScgnBFy/GI84FupprwU3fjkYQYI2+yZBT3ogwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jc9uDAsozOKTu81ujsO4vi174olaZMcZLrIGHVj+7Q=;
 b=od8LEipUOhRJSQqLc89ndQAlCzdVnu2bOO9dhpWjn8lay0SvTrO6xVZm3W1WKQicgrnj95+2DYEU3IKNR7BZz0ZCVBxLGXr4CVpgdp7DbY37/8p0DPcoxP916KphyycmWRndq5mL77tQoQdQwvFhohllDko5nLuGgbNTOUXz1p4=
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.11; Wed, 26 Nov 2025 13:29:15 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::ef) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.9 via Frontend Transport; Wed,
 26 Nov 2025 13:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:12 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 19/20] drm/amd/pm: Use emit_clock_levels in vega20
Date: Wed, 26 Nov 2025 18:54:06 +0530
Message-ID: <20251126132822.3266730-20-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf8c7f8-ae58-43a7-d36c-08de2cefcb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+q8pt0fTtQfdc13dBL6H6McE/XU2UfHBWl5Qp9Ax92uU85QmaNv4Xf66tHH2?=
 =?us-ascii?Q?+2VWkxI80537kuT2Q2t6oj3lXv4I7pPJrqUx9kGXjlpyaNh+kFBq4teuVLJf?=
 =?us-ascii?Q?ATrDUsFZ46c4PZhGTdQ4qNtsqMYRjKo4/nJxmzwB9Y3pOqENEEXWu40I20ja?=
 =?us-ascii?Q?DQlSDJ2cC5zzGzUwWiWPoDhysntag04zH4BxbHxxmhDS/XcC156+zAWp5tGB?=
 =?us-ascii?Q?TCHYZwkPTVxz2Psm2gfo4dc7yXW+6/4OK52MxiNqIVti+TOG390CgnTUPy96?=
 =?us-ascii?Q?uVHMA//AEEd6RiQGb9wKsszi+/rDQ35wORI7Q1gX9Je8XmLAVQVVsByCqj3O?=
 =?us-ascii?Q?0AoHC7cRg6ccRZ7XMGe4nx5+amL2zEgewfhU00OeSMHVTKJjZv9nXIoeRagr?=
 =?us-ascii?Q?pnYuROQUKTMy/o9Ar69UdOgCyiQRdos75TAua9vMkwhcWFRKGyyPp1Kgsf7v?=
 =?us-ascii?Q?r6T44f+nXvNBXA7mE/U0gbSAJXeiY9ncib+eJVKdxGqlZqJVq/gYjcJVVkCH?=
 =?us-ascii?Q?r2N7H+9yV66945agCUTCfFQyu72WDgDvz8sqwdq0y/8TUkrjz1h6TAIPrzsZ?=
 =?us-ascii?Q?UB9a5y5iS7uOBZzphcNX4btaA/SYrh4r3UaZsTlDCTDjNSS6wxUki+gzo2Kw?=
 =?us-ascii?Q?cIuVkRDACqlaE7KQX+ZaKVQ3ulqR7YrfBeERTXi4aOi3O2OFiBrbEK2nteXO?=
 =?us-ascii?Q?WlQLEbwf/1A/BLUCCle3BRCpWW7hczeAY/1XJs7vaua2cLfcSjzAOqH9od9J?=
 =?us-ascii?Q?jOk7AAeC/bWNMtFUuC/HVS/vJG9V3J/2uhzWTWojNxHhW2tF3Kdo+H5QZoiT?=
 =?us-ascii?Q?qGzdiLzKP/pPT1Ww6L8JWkrnB5q8ru/O88mdUq57XfmiGmVqG3EdPAA9bEhQ?=
 =?us-ascii?Q?3Ob+svgwjTb97Pj0Vy6117v9Bb9dKO4wucpcxM8PEdK1lBiEMbCB8Qk0NUnh?=
 =?us-ascii?Q?w3SB5D31xKRPptCmgZTH3D8d+FgwpVc2d3D5E5IcA007AnmhPmgR+mnyn0bo?=
 =?us-ascii?Q?gsVYFVY00RcMXoYyuSNFrb+oASm+DRva4fFew80pGNdBruXFRdJHEOo+pjOW?=
 =?us-ascii?Q?QLqaz31gub9f2mbS0AZ5LFUkZbYS85B2q10XBCW586ir9uRmmNqlHBx6HQWp?=
 =?us-ascii?Q?OhwBGVvftvZOcG96sMd5tE5kjPT/Fvoh9DqWopAJEaghddpw29SEiqfIhhIG?=
 =?us-ascii?Q?AbOmMYdPoRm7pcmY+tcOtBeWGJ//on4I5923HdVKOgOQN7dOkX3nfOtXSBin?=
 =?us-ascii?Q?J0firRnQDrpXwtXevXbDti6Wgt025c+yU+n7azekABO6Fzmo8FZoxKsFu6Cy?=
 =?us-ascii?Q?q2TEmlSYqBoWD91uMPRijFurv7TABgZ0jrBjExhbY/vshYUpnGkcr50rp10V?=
 =?us-ascii?Q?9RU+ZjcDFS71Exhm5oClLSAMUrriU2aLWsuhxFlJdCqK0AUDveuD4BY4K06Y?=
 =?us-ascii?Q?j4ktIecSLBs9neNWptl443uyCUY8Mf7mHIAnPCGaKxtPmKGGnURb7II7w9dn?=
 =?us-ascii?Q?izZir3RHzp+XE9H44SCgeyc0wC2131YfCeFmd498mNtB5l3LKB3AwTVtanis?=
 =?us-ascii?Q?zum8hAwmfI49XkXb1Wo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:14.6724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf8c7f8-ae58-43a7-d36c-08de2cefcb04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move to emit_clock_levels from print_clock_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 211 +++++++++++-------
 1 file changed, 132 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index baf251fe5d82..5193b7d0e11b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3362,8 +3362,9 @@ static int vega20_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
 	return link_speed[speed_level];
 }
 
-static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
-		enum pp_clock_type type, char *buf)
+static int vega20_emit_clock_levels(struct pp_hwmgr *hwmgr,
+				    enum pp_clock_type type, char *buf,
+				    int *offset)
 {
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
@@ -3375,7 +3376,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 	struct pp_clock_levels_with_latency clocks;
 	struct vega20_single_dpm_table *fclk_dpm_table =
 			&(data->dpm_table.fclk_table);
-	int i, now, size = 0;
+	int i, now, size = *offset;
 	int ret = 0;
 	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
 
@@ -3387,15 +3388,19 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_sclks(hwmgr, &clocks)) {
-			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
-				now / 100);
+			size += sysfs_emit_at(buf, size,
+					      "0: %uMhz * (DPM disabled)\n",
+					      now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				clocks.data[i].clocks_in_khz / 1000,
+				(clocks.data[i].clocks_in_khz == now * 10) ?
+					"*" :
+					"");
 		break;
 
 	case PP_MCLK:
@@ -3405,15 +3410,19 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_memclocks(hwmgr, &clocks)) {
-			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
-				now / 100);
+			size += sysfs_emit_at(buf, size,
+					      "0: %uMhz * (DPM disabled)\n",
+					      now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				clocks.data[i].clocks_in_khz / 1000,
+				(clocks.data[i].clocks_in_khz == now * 10) ?
+					"*" :
+					"");
 		break;
 
 	case PP_SOCCLK:
@@ -3423,15 +3432,19 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_socclocks(hwmgr, &clocks)) {
-			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
-				now / 100);
+			size += sysfs_emit_at(buf, size,
+					      "0: %uMhz * (DPM disabled)\n",
+					      now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				clocks.data[i].clocks_in_khz / 1000,
+				(clocks.data[i].clocks_in_khz == now * 10) ?
+					"*" :
+					"");
 		break;
 
 	case PP_FCLK:
@@ -3441,9 +3454,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		for (i = 0; i < fclk_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, fclk_dpm_table->dpm_levels[i].value,
-				fclk_dpm_table->dpm_levels[i].value == (now / 100) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				fclk_dpm_table->dpm_levels[i].value,
+				fclk_dpm_table->dpm_levels[i].value ==
+						(now / 100) ?
+					"*" :
+					"");
 		break;
 
 	case PP_DCEFCLK:
@@ -3453,15 +3470,19 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_dcefclocks(hwmgr, &clocks)) {
-			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
-				now / 100);
+			size += sysfs_emit_at(buf, size,
+					      "0: %uMhz * (DPM disabled)\n",
+					      now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-				i, clocks.data[i].clocks_in_khz / 1000,
-				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", i,
+				clocks.data[i].clocks_in_khz / 1000,
+				(clocks.data[i].clocks_in_khz == now * 10) ?
+					"*" :
+					"");
 		break;
 
 	case PP_PCIE:
@@ -3473,40 +3494,45 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 			gen_speed = pptable->PcieGenSpeed[i];
 			lane_width = pptable->PcieLaneCount[i];
 
-			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
-					(gen_speed == 0) ? "2.5GT/s," :
-					(gen_speed == 1) ? "5.0GT/s," :
-					(gen_speed == 2) ? "8.0GT/s," :
-					(gen_speed == 3) ? "16.0GT/s," : "",
-					(lane_width == 1) ? "x1" :
-					(lane_width == 2) ? "x2" :
-					(lane_width == 3) ? "x4" :
-					(lane_width == 4) ? "x8" :
-					(lane_width == 5) ? "x12" :
-					(lane_width == 6) ? "x16" : "",
-					pptable->LclkFreq[i],
-					(current_gen_speed == gen_speed) &&
-					(current_lane_width == lane_width) ?
-					"*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %s %s %dMhz %s\n", i,
+				(gen_speed == 0) ? "2.5GT/s," :
+				(gen_speed == 1) ? "5.0GT/s," :
+				(gen_speed == 2) ? "8.0GT/s," :
+				(gen_speed == 3) ? "16.0GT/s," :
+						   "",
+				(lane_width == 1) ? "x1" :
+				(lane_width == 2) ? "x2" :
+				(lane_width == 3) ? "x4" :
+				(lane_width == 4) ? "x8" :
+				(lane_width == 5) ? "x12" :
+				(lane_width == 6) ? "x16" :
+						    "",
+				pptable->LclkFreq[i],
+				(current_gen_speed == gen_speed) &&
+						(current_lane_width ==
+						 lane_width) ?
+					"*" :
+					"");
 		}
 		break;
 
 	case OD_SCLK:
 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
-			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
-			size += sprintf(buf + size, "0: %10uMhz\n",
-				od_table->GfxclkFmin);
-			size += sprintf(buf + size, "1: %10uMhz\n",
-				od_table->GfxclkFmax);
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
+					      od_table->GfxclkFmin);
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+					      od_table->GfxclkFmax);
 		}
 		break;
 
 	case OD_MCLK:
 		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
-			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
-			size += sprintf(buf + size, "1: %10uMhz\n",
-				od_table->UclkFmax);
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+					      od_table->UclkFmax);
 		}
 
 		break;
@@ -3518,32 +3544,38 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
-			size += sprintf(buf + size, "%s:\n", "OD_VDDC_CURVE");
-			size += sprintf(buf + size, "0: %10uMhz %10dmV\n",
-				od_table->GfxclkFreq1,
-				od_table->GfxclkVolt1 / VOLTAGE_SCALE);
-			size += sprintf(buf + size, "1: %10uMhz %10dmV\n",
-				od_table->GfxclkFreq2,
-				od_table->GfxclkVolt2 / VOLTAGE_SCALE);
-			size += sprintf(buf + size, "2: %10uMhz %10dmV\n",
-				od_table->GfxclkFreq3,
-				od_table->GfxclkVolt3 / VOLTAGE_SCALE);
+			size += sysfs_emit_at(buf, size, "%s:\n",
+					      "OD_VDDC_CURVE");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz %10dmV\n",
+					      od_table->GfxclkFreq1,
+					      od_table->GfxclkVolt1 /
+						      VOLTAGE_SCALE);
+			size += sysfs_emit_at(buf, size, "1: %10uMhz %10dmV\n",
+					      od_table->GfxclkFreq2,
+					      od_table->GfxclkVolt2 /
+						      VOLTAGE_SCALE);
+			size += sysfs_emit_at(buf, size, "2: %10uMhz %10dmV\n",
+					      od_table->GfxclkFreq3,
+					      od_table->GfxclkVolt3 /
+						      VOLTAGE_SCALE);
 		}
 
 		break;
 
 	case OD_RANGE:
-		size += sprintf(buf + size, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 
 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(
+				buf, size, "SCLK: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FMIN].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FMAX].max_value);
 		}
 
 		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
-			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(
+				buf, size, "MCLK: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_UCLK_FMAX].min_value,
 				od8_settings[OD8_SETTING_UCLK_FMAX].max_value);
 		}
@@ -3554,31 +3586,52 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(
+				buf, size,
+				"VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ1].min_value,
-				od8_settings[OD8_SETTING_GFXCLK_FREQ1].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
-				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,
-				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
+				od8_settings[OD8_SETTING_GFXCLK_FREQ1]
+					.max_value);
+			size += sysfs_emit_at(
+				buf, size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
+				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1]
+					.min_value,
+				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1]
+					.max_value);
+			size += sysfs_emit_at(
+				buf, size,
+				"VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ2].min_value,
-				od8_settings[OD8_SETTING_GFXCLK_FREQ2].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
-				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,
-				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
+				od8_settings[OD8_SETTING_GFXCLK_FREQ2]
+					.max_value);
+			size += sysfs_emit_at(
+				buf, size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
+				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2]
+					.min_value,
+				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2]
+					.max_value);
+			size += sysfs_emit_at(
+				buf, size,
+				"VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ3].min_value,
-				od8_settings[OD8_SETTING_GFXCLK_FREQ3].max_value);
-			size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
-				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,
-				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value);
+				od8_settings[OD8_SETTING_GFXCLK_FREQ3]
+					.max_value);
+			size += sysfs_emit_at(
+				buf, size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
+				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3]
+					.min_value,
+				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3]
+					.max_value);
 		}
 
 		break;
 	default:
 		break;
 	}
-	return size;
+
+	*offset = size;
+
+	return 0;
 }
 
 static int vega20_set_uclk_to_highest_dpm_level(struct pp_hwmgr *hwmgr,
@@ -4412,7 +4465,7 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	.odn_edit_dpm_table = vega20_odn_edit_dpm_table,
 	/* for sysfs to retrive/set gfxclk/memclk */
 	.force_clock_level = vega20_force_clock_level,
-	.print_clock_levels = vega20_print_clock_levels,
+	.emit_clock_levels = vega20_emit_clock_levels,
 	.read_sensor = vega20_read_sensor,
 	.get_ppfeature_status = vega20_get_ppfeature_status,
 	.set_ppfeature_status = vega20_set_ppfeature_status,
-- 
2.49.0

