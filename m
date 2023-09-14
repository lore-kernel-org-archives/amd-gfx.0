Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD64EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D656E10E4E0;
	Thu, 14 Sep 2023 02:02:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E0A10E4E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+HjB2RrpAKUs/fvaSmooBhs3xo+j63khzusF02JMlKh8cyW2yNZtLAPd/394ev4H+y45NY7smk61pfGiOYHyrKjRZvK3ClVfMV+OKNeZyt3Abxi6R/d54B4MmjFNOQcmmp20kQ5vE0qqbTctd5MNTadtakEHnDN6kqHPgRnzJ1nERC/G5bUrZMBX3yRD3WSL9l4jbmidLhU68xFgQafAz8nzM8nF5pOuXZT8bdjN5lxo7iUimjyWDhwXvOThfuoSonxGITqROZ0SyIXb32LgMg9a3/wvSydobtsf0/beaEKZQFrRP+54cK8XPZZRDmPNwruFlsKN0+z5sbVDWOtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfvHKSxnq0PB0JPva7+dCKUUEJ0FOVDiKgDv0vIMweA=;
 b=C0bg7yT0FalrtQqBgY5SPu8eXc/IkC2g4IPwu7YL++dw3VGfnEMoawlEznCSoqutTHspMpeNU0DK+azzUnE9IoFlUCGZvg5AKAjdnq9t3k3T3s6jKyHZrhgSJ+Q3OBoddRUowFXaxetu4OMpm6NH1Kw/s+Djk+6gOHb9CYtaebFWeFuyjMBiYH05Nl9aaP6If0cSW2QqwtvacRKz0B/yG6Nhld2UWk/ymu8lNfwhVZCJb8objswdDbPoiAKiIwkUgt6gorAIaEnQXnBXoavit8Mrx59w01QvV9++w8bbYqZiEWOzKSF/Rq3fJCUQ266JatBSQWNL73/73Sgv7Cs3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfvHKSxnq0PB0JPva7+dCKUUEJ0FOVDiKgDv0vIMweA=;
 b=0PDEwtfbKD6EV5FFb2nRs7O1Jf077B0Y8rIRk62XOdbCyBMZSzGrXrUAcwxW89SXHCQqivpnu2uCLNfLFFLQmow+RXcsA/qos0G45yGL/b41ZKS0X9ibqbzxk3RlREEgA0jNVncw8dCBvRHULPEeqyG9kExA1615FVDRJXGqV/o=
Received: from PA7P264CA0157.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::10)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 14 Sep 2023 02:02:06 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10a6:102:36c:cafe::d0) by PA7P264CA0157.outlook.office365.com
 (2603:10a6:102:36c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:02:04 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/28] drm/amd/display: [FW Promotion] Release 0.0.183.0
Date: Wed, 13 Sep 2023 20:00:14 -0600
Message-ID: <20230914020021.2890026-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 905dcf68-e59a-43c3-bb6b-08dbb4c69803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFddG2JEAAx64/M9onMKtk8pjqRHQR+QrEDnXTTM1Wgs22fLvr5ZXczsziBC/EgFqPxIp9K+OUeZUCVbV13BeAgaAAqVOP2qqU+d1Q7mcSzzvJEdBk+ymAD5FZpcNHCqVVSO/0gj2c+wpNIRtMg9DHDv3oVO9k4a7vhFNtQK3XTG6dh/hFUZ/LXWGubiIvBFZhYeWxVReA60WplJGqtYSlrrzIouzZecXOLouqwzUsixveGf1nVbXMEXFL+uik5aYSRbsMDVC6etonSv1mNQqidcbeQ0Jr62jep1sWLL3Zt84gZuHKnCbPJGROTExAAaIEp1Df6GR/osWZ0PM5+FNZtLsm8UraRVza51AOFWFz7bIbA90cQbpweZikSlcCfH/eXTaTxbaq+gzZlObr1swBDfmE+iKwOBjtheC+gWVC+uLZ2ZBlmfohvVTna0lpJiQCB9nM6SP1Zf8PE++7Vqudm6tGyIf0jgEkAIaUak4hy50QfCk9ZCkVJC27h3GCoQm4jkXhTPQa5ScrhewyMl7BjqtTxLfiOksmBT003oQOvuWum7tg07ahsL/5BXD7zjqa6KTE2PucJVtmi4+IEEU3vDnkLeq+OU3Ctfevy9hKokSDSGTwcuV48WiV/FW0fYqAnzrOgOJ+4S640tT5B86Q8NgtwqVvEtaSFXIyHbANIcPdonhpMN/ItiR4xcZP9PPtQtpQpjRRTllY/k8RIBBAKJ6vCKKtfRX1MlxmmAd2Ai2h0kjGm00qdskg2mtgMqwAdBsUG2CVNT3OSLejDTtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(426003)(16526019)(40460700003)(47076005)(26005)(86362001)(336012)(36756003)(6916009)(70206006)(54906003)(70586007)(8676002)(316002)(41300700001)(36860700001)(6666004)(8936002)(4326008)(5660300002)(81166007)(82740400003)(356005)(478600001)(2906002)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:02:04.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905dcf68-e59a-43c3-bb6b-08dbb4c69803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Add new IPS ALLOW masks
 - Add new Replay power configuration options

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6e705b219872..7ff507221285 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -596,6 +596,11 @@ enum dmub_ips_disable_type {
 	DMUB_IPS_DISABLE_IPS2_Z10 = 3,
 };
 
+#define DMUB_IPS1_ALLOW_MASK 0x00000001
+#define DMUB_IPS2_ALLOW_MASK 0x00000002
+#define DMUB_IPS1_COMMIT_MASK 0x00000004
+#define DMUB_IPS2_COMMIT_MASK 0x00000008
+
 /**
  * union dmub_fw_boot_options - Boot option definitions for SCRATCH14
  */
@@ -2786,6 +2791,10 @@ enum dmub_cmd_replay_type {
 	 * Set coasting vtotal.
 	 */
 	DMUB_CMD__REPLAY_SET_COASTING_VTOTAL	= 3,
+	/**
+	 * Set power opt and coasting vtotal.
+	 */
+	DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL	= 4,
 };
 
 /**
@@ -2996,6 +3005,24 @@ struct dmub_rb_cmd_replay_set_coasting_vtotal {
 	struct dmub_cmd_replay_set_coasting_vtotal_data replay_set_coasting_vtotal_data;
 };
 
+/**
+ * Definition of a DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL command.
+ */
+struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
+	 */
+	struct dmub_cmd_replay_set_power_opt_data replay_set_power_opt_data;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_SET_COASTING_VTOTAL command.
+	 */
+	struct dmub_cmd_replay_set_coasting_vtotal_data replay_set_coasting_vtotal_data;
+};
+
 /**
  * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
  */
@@ -4138,6 +4165,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__REPLAY_SET_COASTING_VTOTAL command.
 	 */
 	struct dmub_rb_cmd_replay_set_coasting_vtotal replay_set_coasting_vtotal;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL command.
+	 */
+	struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal replay_set_power_opt_and_coasting_vtotal;
 };
 
 /**
-- 
2.40.1

