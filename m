Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB552C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2D210EABB;
	Thu,  6 Jun 2024 21:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRbLProZ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228E810EABC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBKRfm438Bo6ef3sdNhM0ZJW5RJwRy0wO5639nRUvG58zQw1lJMATCRlNMJmV8ckl1BpTFNhlvxQvPggT7DjXUukkfPpxlf8LNU1yYP++MkX2v9W/9asc/ADGh3rGrIaAnl07OMcDgQBnTAMwkwaRI/MzBekDz3ZBJzs4VDiM1ZStvRRgq/0ugd0KMBLaZN1Z0Vh0o5nGKsjOv4qkegPsIz3NH8Jc4OY2+mCeuUufgPBLfGVRpsxZ30zmHNHACkbeHQMlJ+GIBtHdJ14kPIQLwsNUxtmok1WvouZ/kAddngBiF+2j+gy1yeU6Bev0a2Ka+hBB5+Wn4+slGwaFemyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGcAWp5X8EucpTOP4RZsF4JY+UdHhLcPfn6Zqgd5FjQ=;
 b=K8XXNyjFslhDzp7Xu20PiiNvGCdcD1RTRjJY62rraJgWjPlm6lQG4sp1Tu3e3e9jXgW12L+1IUzgyahLru0s3okD6irAQTozdB1B5VTOK5OjH5pTgsSkyA1za49LuGoqGaWaciaIKW5FTB9D65KxOkohsU4WUpDC3MDR3fhzO1yZ9vhiEfmIRr4iHYF/OzaeNevwn3BSjHd6ve/I5BR+qJk2PQwObNX6vXr/p1F7ehFZlTYnXD+oITtBsHxpRkXIx34PkuO84XA6seXNLS0OcV0MM4Es8KEesgsBZmav3n6+VYl3xZMx3cMFL3hfRDdreSx4/e4P4+BPVXMTRXxd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGcAWp5X8EucpTOP4RZsF4JY+UdHhLcPfn6Zqgd5FjQ=;
 b=yRbLProZjhyHXhnl2duDw+VbWc61LmaShhgxhZceaVBnnp7li5Kv7uuQPSWzhCKSoUKdjxpP65NLCzmlZDjzweP0ocTwxhNXEYYyBOeevOLbPVw1uXEELEcoOOOTLKLhhEdCyDC8bxK6+DwwhOTx9u3VUTvK0zFIobChxYjrABc=
Received: from SA9PR13CA0019.namprd13.prod.outlook.com (2603:10b6:806:21::24)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:02:26 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::c5) by SA9PR13CA0019.outlook.office365.com
 (2603:10b6:806:21::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:26 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:20 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Anthony Koo <anthony.koo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 21/67] drm/amd/display: [FW Promotion] Release 0.0.220.0
Date: Thu, 6 Jun 2024 16:58:42 -0400
Message-ID: <20240606205928.4050859-22-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcea88c-0cf2-43d3-6e55-08dc866bf81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+anz5hXhl7c23o04N5liuNJyUE5RQdKU5eewI5dM/fXIVC8s4DNpAhANouV?=
 =?us-ascii?Q?uwnz8uHbvQ4E5WSwSMDX1QJ4UgXcIxENfZq0Undo5TLPctvXZ0AaKE2D3bzi?=
 =?us-ascii?Q?yTqdYqt0dypXk6wlQeHWxnkc+2NX282+aPEGWkOtMSePj3NUAWSeMZnZeSRI?=
 =?us-ascii?Q?GoZmInAogTa3IsZmJRqALtjMA3jee+6P4+9vIoTYJWIaPsSptONuTz6A9EUU?=
 =?us-ascii?Q?ywo72gKFqn1WSMH8zDixQOJc3PJ/weKJM7wzk5vtDr0ZC7ZqgafcK7Zd5KfD?=
 =?us-ascii?Q?Ay1HHAsgmJCo30tYrYuGViib3Ya+HKjty8wLEJOvcdwJ0TDptDto4dQDRh38?=
 =?us-ascii?Q?ysXqHndM4rpsdfL3i2aUreuhn/57QYCi0KyOtRjIaB6yP9RKtUSVHOFVVudQ?=
 =?us-ascii?Q?ecirwr8cHZNEdoD7pmblImqQ6QTTmJBLXqSOAgtgOMsEkrl76vGvvS2dAtuI?=
 =?us-ascii?Q?B2s2dqa5I1BuULE7WklzlXRIcf2deaw0//PPAZLmNdO0TBwUKvz93Vij6wFt?=
 =?us-ascii?Q?x95hvHM3hc13CAVGJL/tt6lXJN2ENDHlHmkd7+c7Y1t5HKe+gMM/BvizKlc1?=
 =?us-ascii?Q?iduussiDPKsuMtx65PY2Hj7Z8bwz506fgsGWCqT1gzm4ElWike8+Q8RaGtOx?=
 =?us-ascii?Q?Kb9LDzw8UKnek/ZYVAl0XswB7pphplmg3iu00Il0T7vMPsBAPw/XmcqPUiYl?=
 =?us-ascii?Q?9N51FSD8o2UMqQ5nAjD9VmUsDNHqbfMn4vn3R3AySVWbdsPdAFWCExoiyq8E?=
 =?us-ascii?Q?AjPD3ZnZWDV7YOVLhQ4EsFk2IXTvw31Xrhstqpcuh36MG5Vx3OkOWe4mMe0M?=
 =?us-ascii?Q?IKMCgMLBdHF0Btv+o7Ze8FuyCwsF2gp2gNpE7kdp1uX3v1bytUwlTmVzab81?=
 =?us-ascii?Q?EZFWAkqAAZgEbfHhMqM0WGsDODCjOTratgUu70tAIAliCpg9UOZdKvirr70v?=
 =?us-ascii?Q?kuPJPvys1nbjfsRBfzyr0rpmoYDO+YfGTvtRX20idEMVpeAs+Uw2BvXixY9G?=
 =?us-ascii?Q?hMEYV2EomYBKtXMiggYYjEd8L03jfIB9y7/cWHbInYMjHaofj/o2IPCgVSqX?=
 =?us-ascii?Q?aXIzbr6Kw5geRBbMvDRvNK0tuuAUB5sVJ8PlzRDzfixqeyrC6Ud4jFrnMmBY?=
 =?us-ascii?Q?7G4/lU5hcspHNQ1gJ+EDx5ZNKdbJAcDbHZziJuRWu2EgoFyXlS2DWf5Fwdzy?=
 =?us-ascii?Q?LO/Py84ZOGTNUVFKiafS54AQuhcifZeyjCcadhtppaQSdFBLsCiIVanJIlD2?=
 =?us-ascii?Q?lEPuy9Jux/pFTqSB++WjtPBymFO52+oGuSFMZM+Rg9oo5CkpNKrCnersZHXQ?=
 =?us-ascii?Q?ANm28l5B8NF6Na4RClNXNEtDjFCV5yyCUhFJT3B2Bh5z2xhdLzoNcaxItn7Q?=
 =?us-ascii?Q?DI+/m2M+7oKTdZwDD9AjYk4YtN44VohWwNU2+OcfZcxfTPq2Fw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:26.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcea88c-0cf2-43d3-6e55-08dc866bf81d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
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

From: Anthony Koo <anthony.koo@amd.com>

 - Change ordering of structs to put enums together
 - Add new define DMUB_TRACE_ENTRY_DEFINED to guard
   the trace code enum

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index fe529b67369e..7fea9bec7b64 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -558,6 +558,7 @@ union dmub_fw_meta {
 //==============================================================================
 //< DMUB Trace Buffer>================================================================
 //==============================================================================
+#if !defined(TENSILICA) && !defined(DMUB_TRACE_ENTRY_DEFINED)
 /**
  * dmub_trace_code_t - firmware trace code, 32-bits
  */
@@ -572,6 +573,7 @@ struct dmcub_trace_buf_entry {
 	uint32_t param0; /**< trace defined parameter 0 */
 	uint32_t param1; /**< trace defined parameter 1 */
 };
+#endif
 
 //==============================================================================
 //< DMUB_STATUS>================================================================
@@ -2538,6 +2540,18 @@ enum dmub_cmd_psr_type {
 	DMUB_CMD__SET_PSR_POWER_OPT = 7,
 };
 
+/**
+ * Different PSR residency modes.
+ * Different modes change the definition of PSR residency.
+ */
+enum psr_residency_mode {
+	PSR_RESIDENCY_MODE_PHY = 0,
+	PSR_RESIDENCY_MODE_ALPM,
+	PSR_RESIDENCY_MODE_ENABLEMENT_PERIOD,
+	/* Do not add below. */
+	PSR_RESIDENCY_MODE_LAST_ELEMENT,
+};
+
 enum dmub_cmd_fams_type {
 	DMUB_CMD__FAMS_SETUP_FW_CTRL	= 0,
 	DMUB_CMD__FAMS_DRR_UPDATE		= 1,
@@ -3259,18 +3273,6 @@ struct dmub_rb_cmd_psr_set_power_opt {
 	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
 };
 
-/**
- * Different PSR residency modes.
- * Different modes change the definition of PSR residency.
- */
-enum psr_residency_mode {
-	PSR_RESIDENCY_MODE_PHY = 0,
-	PSR_RESIDENCY_MODE_ALPM,
-	PSR_RESIDENCY_MODE_ENABLEMENT_PERIOD,
-	/* Do not add below. */
-	PSR_RESIDENCY_MODE_LAST_ELEMENT,
-};
-
 /**
  * Definition of Replay Residency GPINT command.
  * Bit[0] - Residency mode for Revision 0
-- 
2.34.1

