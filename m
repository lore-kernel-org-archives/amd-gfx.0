Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5298C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A8F20B80
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lEf7s6zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A8F20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A670B6E7E2;
	Fri, 13 Nov 2020 20:27:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8F66E7E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mspmPLqBxhfloUiLKfZ+I2mbc9zNh1WQQNTS2MyFANBl518KebMbiLgy3DtsDD6FvQmVedX1swse3KEkdGqrDuAQ+HRQ/T5kx6xTB+2jIp4PrHZeS5e2TAitKT230Qdsgv5kMs4y98FDI3UKDa/z3uam8V/m1TAq4v6pJCoRkUrUqKGGbRwHgWE7aQQNo/A6oo24nPnMWb/5+oc1Ewdg7rdqY2zuF9otDWhXGqyYFoA5t3lIWg/0tIZUgeUmk94773mU+75E/PvKXoF/kv+tqeey1ayswRJe/TdeqpPHRMRCBK/5edjtr3poEWIxoCCW+OlBt2HIRpFFWm8M7ulaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+R1y7lW8nTTfBE49e4N3TOAnI5N0KTDtPskUDU1Gl8=;
 b=aKQaXYMDDviZoAhoPmBZr80dVzEJuk/oyNAe1GHj9spCOPVRaXEeu1irj0ttXEFIZSlYBCHAik4OtCrDlhf3TN4Ibly9M6EJeN6Zcd+yl3UU0WedAbSZg/gJlIbNGV9L4OfOcmRmnhmTU7pM/TVs6c3l4oUR6rWRnOfdnB9j9xeN079KxT2MIqzFH+TXuhx0OZu40S4bqIWugd2t0bD18NHjKUl1iIPCSGxr5Ck4X4a9HsRPW8N3OWl0+R+HY1jLjy4Ls5ML9FXnqGqungIiQwkEBNdgprNaeHT/kYuG63qEmyW0Z14JDA7afzkpwh06wk0WEQxvHVdVP9lbvYHBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+R1y7lW8nTTfBE49e4N3TOAnI5N0KTDtPskUDU1Gl8=;
 b=lEf7s6zBc3rJUm3lwVGVFnD2ElOO0cP/Xnpu5lxv02jvnbk/MOTfp1w/dKfsKLWLz+WRTFNZnEVSOgvO36G7h8BsdedF/y64GFOdJ3fNPkfzKiGNX3RiaxV0yxaFtKghsP6idQf6iZs4T9SRvqFS7XwNpdiYN6CXcF2i1FB76Z4=
Received: from MWHPR14CA0015.namprd14.prod.outlook.com (2603:10b6:300:ae::25)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 20:27:15 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::ce) by MWHPR14CA0015.outlook.office365.com
 (2603:10b6:300:ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:27:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:27:14 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:27:14 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 13 Nov 2020 14:27:14 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Update dmub code
Date: Fri, 13 Nov 2020 15:27:06 -0500
Message-ID: <20201113202706.1890613-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68732aa0-903b-40b7-7321-08d8881282a0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4181F35F2A17E42D67011F2FF9E60@CH2PR12MB4181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZR9jEqc5CcRo006ZgnpaJTOFD03YmKj9/HziJGQcBwv2n3C8xKO5QKmhfdxw7FZHLs5AzdUDfNyL1BmFWDfOrqt2XlvBBqKaRSXUUbf5Dk+qMe2XD3P8sSuBU29/BwkKEKWqdXFZ/ncw4at2M+Ks4UD8C72dXMu7NYLatYvheyll5BOaMQq8KLYH4vwFJTWuJw0TfvYDzsfD/XUgYGeNO2vrVMlryV0uDXXP618PEiMMvrA4qindsOp9zqYUJlDi4zlxc0axUYxBEHAbvJfhYxOkf/V1i7gxTaOosV3CszXVlDkBCixC8KH4Io7yyU9D9ShqSApy69vgoiPj0hSvyipGidFLjvJzWxjx1aJrNJJvWlggnxnOeK8UF9NvEuE9aDjBN20LpzTj9iPEvbwbdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966005)(70206006)(82740400003)(70586007)(8936002)(316002)(81166007)(2906002)(6666004)(86362001)(4326008)(1076003)(478600001)(15650500001)(8676002)(5660300002)(110136005)(54906003)(26005)(186003)(7696005)(47076004)(356005)(336012)(2616005)(6636002)(36756003)(82310400003)(426003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:27:15.3598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68732aa0-903b-40b7-7321-08d8881282a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is a delta in the dmub code
- add boot options
- add boot status
- remove unused auto_load_is_done func pointer

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 20 +++++++++++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 23 ++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  6 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |  5 ----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |  2 --
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |  5 ----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.h |  1 -
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 26 ++++++++++++++-----
 9 files changed, 70 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index ac41ae2d261b..b82a46890846 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -265,8 +265,12 @@ struct dmub_srv_hw_funcs {
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
 	bool (*is_phy_init)(struct dmub_srv *dmub);
+	void (*enable_dmub_boot_options)(struct dmub_srv *dmub);
+
+	void (*skip_dmub_panel_power_sequence)(struct dmub_srv *dmub, bool skip);
+
+	union dmub_fw_boot_status (*get_fw_status)(struct dmub_srv *dmub);
 
-	bool (*is_auto_load_done)(struct dmub_srv *dmub);
 
 	void (*set_gpint)(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
@@ -309,6 +313,7 @@ struct dmub_srv_hw_params {
 	uint64_t fb_offset;
 	uint32_t psp_version;
 	bool load_inst_const;
+	bool skip_panel_power_sequence;
 };
 
 /**
@@ -590,6 +595,19 @@ enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
  */
 void dmub_flush_buffer_mem(const struct dmub_fb *fb);
 
+/**
+ * dmub_srv_get_fw_boot_status() - Returns the DMUB boot status bits.
+ *
+ * @dmub: the dmub service
+ * @status: out pointer for firmware status
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - unspecified error, unsupported
+ */
+enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
+					     union dmub_fw_boot_status *status);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b0d1347d13f0..9fd24f93a216 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -191,7 +191,8 @@ union dmub_fw_boot_options {
 		uint32_t optimized_init : 1;
 		uint32_t skip_phy_access : 1;
 		uint32_t disable_clk_gate: 1;
-		uint32_t reserved : 27;
+		uint32_t skip_phy_init_panel_sequence: 1;
+		uint32_t reserved : 26;
 	} bits;
 	uint32_t all;
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 2c4a2fe9311d..cafba1d23c6a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -312,3 +312,26 @@ uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_SCRATCH7);
 }
+
+union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+	return status;
+}
+
+void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_options boot_options = {0};
+
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
+
+void dmub_dcn20_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip)
+{
+	union dmub_fw_boot_options boot_options;
+	boot_options.all = REG_READ(DMCUB_SCRATCH14);
+	boot_options.bits.skip_phy_init_panel_sequence = skip;
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index a316f260f6ac..d438f365cbb0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -192,4 +192,10 @@ bool dmub_dcn20_is_gpint_acked(struct dmub_srv *dmub,
 
 uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub);
 
+void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub);
+
+void dmub_dcn20_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip);
+
+union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
index e8f488232e34..1cf67b3e4771 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
@@ -53,11 +53,6 @@ const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
 
 /* Shared functions. */
 
-bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub)
-{
-	return (REG_READ(DMCUB_SCRATCH0) == 3);
-}
-
 bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_SCRATCH10) == 0;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
index 2bbea237137b..6fd5b0cd4ef3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
@@ -34,8 +34,6 @@ extern const struct dmub_srv_common_regs dmub_srv_dcn21_regs;
 
 /* Hardware functions. */
 
-bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub);
-
 bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub);
 
 #endif /* _DMUB_DCN21_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index 215178b8d415..f00df02ded81 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -188,8 +188,3 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
 		  DMCUB_REGION3_CW6_ENABLE, 1);
 }
-
-bool dmub_dcn30_is_auto_load_done(struct dmub_srv *dmub)
-{
-	return (REG_READ(DMCUB_SCRATCH0) > 0);
-}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
index 4d8f52b8f12c..9a3afffd9b0f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
@@ -45,6 +45,5 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw5,
 			      const struct dmub_window *cw6);
 
-bool dmub_dcn30_is_auto_load_done(struct dmub_srv *dmub);
 
 #endif /* _DMUB_DCN30_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index d11b96d132ad..ba8494cf005f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -153,17 +153,18 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->set_gpint = dmub_dcn20_set_gpint;
 		funcs->is_gpint_acked = dmub_dcn20_is_gpint_acked;
 		funcs->get_gpint_response = dmub_dcn20_get_gpint_response;
+		funcs->get_fw_status = dmub_dcn20_get_fw_boot_status;
+		funcs->enable_dmub_boot_options = dmub_dcn20_enable_dmub_boot_options;
+		funcs->skip_dmub_panel_power_sequence = dmub_dcn20_skip_dmub_panel_power_sequence;
 
 		if (asic == DMUB_ASIC_DCN21) {
 			dmub->regs = &dmub_srv_dcn21_regs;
 
-			funcs->is_auto_load_done = dmub_dcn21_is_auto_load_done;
 			funcs->is_phy_init = dmub_dcn21_is_phy_init;
 		}
 		if (asic == DMUB_ASIC_DCN30) {
 			dmub->regs = &dmub_srv_dcn30_regs;
 
-			funcs->is_auto_load_done = dmub_dcn30_is_auto_load_done;
 			funcs->backdoor_load = dmub_dcn30_backdoor_load;
 			funcs->setup_windows = dmub_dcn30_setup_windows;
 		}
@@ -535,11 +536,10 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
-	if (!dmub->hw_funcs.is_auto_load_done)
-		return DMUB_STATUS_OK;
-
 	for (i = 0; i <= timeout_us; i += 100) {
-		if (dmub->hw_funcs.is_auto_load_done(dmub))
+		union dmub_fw_boot_status status = dmub->hw_funcs.get_fw_status(dmub);
+
+		if (status.bits.dal_fw && status.bits.mailbox_rdy)
 			return DMUB_STATUS_OK;
 
 		udelay(100);
@@ -634,3 +634,17 @@ enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
 
 	return DMUB_STATUS_OK;
 }
+
+enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
+					     union dmub_fw_boot_status *status)
+{
+	status->all = 0;
+
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (dmub->hw_funcs.get_fw_status)
+		*status = dmub->hw_funcs.get_fw_status(dmub);
+
+	return DMUB_STATUS_OK;
+}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
