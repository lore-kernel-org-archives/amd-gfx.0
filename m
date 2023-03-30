Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6B6C77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 09:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D65810ED59;
	Thu, 30 Mar 2023 09:00:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2525B10ED59
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 09:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvsTiNM4mORnzO8UiAtkOdwrIcMlpxPOLgDDZ2wz6bc87Pds6YEVoc7oS7O6TCZyIqgr5afqdWNOd5Jf0bq0Gjio9BXb9Uh2guz7r3IsNpAkkHQh73RxfdiyhL0deME90HR+zVF1kLCtWxjYW0oUgkFS7PHELpv5kJcECd9HU6rslp7C5MBGE0uDpwtAcxCObfgK0B+KUOghE3qFM4SxOe3Qh3zyC+/mHFIzf162Tbq94cLk6tOKdlRsLa7ImiZWOrYvP75ceB16zAlZ8jtfnKkLsEKrYd93os5iqq2JEjkXGPumBOjLsnS53cMmJrTzfsD06Xed0RKWPvr9qfPxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wgKBa7Jxb1GuUwpUOzU/hOjbVaoz2Z8jxGGCs/7bmc=;
 b=gmXvhkV4IbOM9AOFIDcIsYJ6mI12NaFrAhSPO1JRwtXrncfeDScYAChCEnEASv6RK7CwGrVf1jQnd0pJhGo06/p7X4LN892BJUREOv6X89wDim2lrRZdbfT0nnZE4wMfnjtUeDEROPSoD0aV/Cibf/ZHoN/yZ4lCrrx8MoNvg9U0nODiVkVaVoK2+UySw1GVNeQzLD1D1qKpUpP0UhubqC6Zy347SKNKoEjCBoqfOZHSY+11VWZKa9CeWl593heuLiyazxbTMXfcX7A1CcH9V2bRBDJLvD7I+ye1943mdcg1f5deGw7y28L1rWh38Y3vI6eU2Hta9A8cs/0/pzom8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wgKBa7Jxb1GuUwpUOzU/hOjbVaoz2Z8jxGGCs/7bmc=;
 b=ztB21jY5Fg9nqA+ehDHMO3tu3/eDy6H3+46YGd5ncC+2c9HjryjzDxZGZLNiKHacZxOqjA/ULIbe68ZxavtzFbgqPIdvj3bWmzs/g/XO1sAALkYFpY7xP46anA9mlt3p1L+UWJM9DDh4eTBdshGshjHEPOyrXBIJrNad+7UWeD8=
Received: from BN9PR03CA0782.namprd03.prod.outlook.com (2603:10b6:408:13f::7)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 09:00:19 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::73) by BN9PR03CA0782.outlook.office365.com
 (2603:10b6:408:13f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 09:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 09:00:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:59:50 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amd/display: [FW Promotion] Release 0.0.161.0
Date: Thu, 30 Mar 2023 04:57:19 -0400
Message-ID: <20230330085720.3863-10-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|BN9PR12MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2b4f3c-1499-4578-1d30-08db30fd2fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ia8P8Wk625zDwxFzqjYIxcMHI54ZctSXkdB96s6M1eXNacqfPK6MTDsbMkNHBnio6LOEUDG8/zJJq2kGFBbg87BXMF2GQD50hMb6m+MX0/iqMU49Gsvq1JCluJhUVEtk55MKEPnEATyZ3ej9cMzaHw9AmW2g23lWRCIVlJTYGRVvnMdLf8UIvkpi+/W5Ohb1S88k+hAOYKqnZhD9MP8rDMbD894TPzyBOwIpjgb0MuSa1N49kDhV3ouP1I6BZ12zelvrif2LoHisNAkRAPJ4HN07HH9Qeq0V9uUGQ8k1NJVczAi0idcPpl+T9mnTw4uXTTTC2TnFMADSIBTVH9fypHPWuGmvfMIjyd9IJh7JSwkvGNra+A4PTTpiQssI91BeYMADa91Wxu99jXhSqFzlEq5cTafLmtmw6jYCvuzLzdlv+n1sm+lM6bpeVcJMqycvS3S2dgWYTtlTIpwoytoirl2Pv1hT+Jtqgz1Pd/dP0rSX7tIjT0VkSjTfuAL/C99CAYL4LNoHgryntn1iZaP6hwE5Qdsqfu0wxB8jyirqwkTn4oAKrRv45V7Xh7AjP1OulBm6MtwowC87owX0BfPlHjrEsIVIUnxM/vM6Fb6qgqE5xo3J6q9vNln3yfnWgwnsidybWXw6r3gl2+3bW9ske7lTU1HzPu5YTJc2+FSDKddWAbn0PgsZoO+AQk47pC0lWVSoeShIEb/fGECk6oRctBrPwk+DKA64NfSzVHxmbbs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(6666004)(81166007)(1076003)(356005)(82740400003)(26005)(70586007)(82310400005)(54906003)(316002)(70206006)(36756003)(8676002)(40480700001)(41300700001)(86362001)(6916009)(4326008)(47076005)(478600001)(336012)(2616005)(8936002)(40460700003)(5660300002)(2906002)(426003)(36860700001)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 09:00:19.0205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2b4f3c-1499-4578-1d30-08db30fd2fd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

 - Add command to idle opt.
 - Rename d3 entry event and add idle trigger param on
   notify event.
 - Add bit to fw boot status to notify status when hardware
   is powered up.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 15d26222597a..598fa1de54ce 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -362,7 +362,7 @@ union dmub_fw_boot_status {
 		uint32_t defer_load : 1; /**< 1 if VBIOS data is deferred programmed */
 		uint32_t reserved : 1;
 		uint32_t detection_required: 1; /**<  if detection need to be triggered by driver */
-
+		uint32_t hw_power_init_done: 1; /**< 1 if hw power init is completed */
 	} bits; /**< status bits */
 	uint32_t all; /**< 32-bit access to status bits */
 };
@@ -377,6 +377,7 @@ enum dmub_fw_boot_status_bit {
 	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3), /**< 1 if driver should call restore */
 	DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED = (1 << 4), /**< 1 if VBIOS data is deferred programmed */
 	DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED = (1 << 6), /**< 1 if detection need to be triggered by driver*/
+	DMUB_FW_BOOT_STATUS_BIT_HW_POWER_INIT_DONE = (1 << 7), /**< 1 if hw power init is completed */
 };
 
 /* Register bit definition for SCRATCH5 */
@@ -1104,7 +1105,12 @@ enum dmub_cmd_idle_opt_type {
 	/**
 	 * DCN hardware save.
 	 */
-	DMUB_CMD__IDLE_OPT_DCN_SAVE_INIT = 1
+	DMUB_CMD__IDLE_OPT_DCN_SAVE_INIT = 1,
+
+	/**
+	 * DCN hardware notify idle.
+	 */
+	DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE = 2
 };
 
 /**
@@ -1114,6 +1120,24 @@ struct dmub_rb_cmd_idle_opt_dcn_restore {
 	struct dmub_cmd_header header; /**< header */
 };
 
+/**
+ * struct dmub_dcn_notify_idle_cntl_data - Data passed to FW in a DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE command.
+ */
+struct dmub_dcn_notify_idle_cntl_data {
+	uint8_t driver_idle;
+	uint8_t d3_entry;
+	uint8_t trigger;
+	uint8_t pad[1];
+};
+
+/**
+ * struct dmub_rb_cmd_idle_opt_dcn_notify_idle - Data passed to FW in a DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE command.
+ */
+struct dmub_rb_cmd_idle_opt_dcn_notify_idle {
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_dcn_notify_idle_cntl_data cntl_data;
+};
+
 /**
  * struct dmub_clocks - Clock update notification.
  */
-- 
2.34.1

