Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A10C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D452072E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Iqon4lLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D452072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A13089081;
	Thu, 16 Jan 2020 20:30:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE47889081
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoU/fztqJllwS1q6pFUDE2ziLlzf0gJAqwVeHgVWwZTCBD0a2jyh49yhwOK7iB/7ey06OHSMsbBopRhrYTdJFXLwtZBaAEQwzAVXDgyYm+RH27NJO8uFogFbn/Ev6Uee+BFeraou+zkWmkidRCYAPYtkyfd9lF/xQBbSGFXvA5OThr+4tQBmsXHp7cX9opLfNDDy0aBtAfOdWjENQ6CkXcl/gReKbDnG6BvJ9zAL6xp/7T8Ft+LevXE9eCKDa2JPwu7371VGmggsSWDE03/QL6aRyqI/Iuah+1EYd7H/vsdOSetmqG4Y12qqf+muf/OzGJtGDd6LdD9HHZf1ArmCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt+R1QemWsRxt8U1v1WldRvw8/358FPSU2gRPkpTp38=;
 b=e24Vn4PpFK9hZjPUEP6msZQBTo6oU55p+OhrFKZuTStJFrAiyAut74LtbB1oFrsmsJzDg8K9+Y7/bOIOZ1//8uDIv2PFOkUIOEqZ52mYcGBPxMNk5ci+n9z3MTTbjzXXRT0akNbh7zBUhJov/CKLVF2PWcN8M1M6f7WeaYWmlYHISWJU/O5AC6uo8GhVKsSodPnsB9mdYUUbF1l2P0uE2OU7lzu83HiaZ3hewSg3aQwvSlpOL2fNzu2HGq4qYvJH/qr03A7VOp8Sf2hIIL+Z3Qv2e4SJtrnilayvTXQ895nCi6JXjR3HolnxgPgtT1wstGwVt4IkMZSmH6Zj6RKwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt+R1QemWsRxt8U1v1WldRvw8/358FPSU2gRPkpTp38=;
 b=Iqon4lLYYjLSeLsNvElctlNQ+g1ebBnXJxH2sg8H88A93eET/LqMLxxYlNhnQ1JR8D7fSKKwv2bv5Dyrcdn82oJS8VHL1rJVaW7xxAg7i+wR1Zc5RxsvTgD8Z0GKRGYcuuPP9Ex+b2ha6mbj+iH0zxT/UwffauITLtt8MRsEX14=
Received: from SN1PR12CA0044.namprd12.prod.outlook.com (2603:10b6:802:20::15)
 by MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 16 Jan
 2020 20:30:11 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by SN1PR12CA0044.outlook.office365.com
 (2603:10b6:802:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Thu, 16 Jan 2020 20:30:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:30:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:08 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:30:07 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amd/display: update psp interface header
Date: Thu, 16 Jan 2020 15:29:42 -0500
Message-ID: <20200116202945.21801-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(428003)(189003)(199004)(86362001)(186003)(316002)(5660300002)(1076003)(54906003)(2906002)(8936002)(81156014)(8676002)(81166006)(6666004)(356004)(36756003)(426003)(70206006)(70586007)(336012)(2616005)(478600001)(4326008)(6916009)(7696005)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3725; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a0ed02-58a1-4f17-7a90-08d79ac2e260
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37251EA119DC08B10F93D948F9360@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjzoJw4XHWbIewjwIjQv0o+BEi+QTG9UTkUgAVoYWUtodxXEmwPuE7hfgESaM7xGTCgKEoYPh3bHi0ltm2Q83SxChT0d96WteccT0b4EE69qOJCj0xnwddDdox48cHznWQOGyCNyKFjswttnswGn2smgHqaNUM50GhdBhrBRJLYdaVjO0hq7DiyP9+APUv3ry7wn0mezm/Y4McgYypErKpFoYl0XhkQSfTXcmqrqlkRo/AATCuFnhxLijYI/9FI6biMfCoGbt0LrCNUUPi//9YZOyVX5o/XWQJZKtz9nBGskGwdNZxgpmKkIaLDzpLTA08PzVE3JZQpGB2DKrPYrBl/abyi0h9X25rokReg51Cxd4iyXWpw18GkcsCALvCpEBhpYMSviHBNWpCy4Eox9/zf5TNMfLQy5zwXbvcm9bAxhqyvrK4JxF3ObJADDIyY1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:30:10.6929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a0ed02-58a1-4f17-7a90-08d79ac2e260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
We need to support SRM

[How]
Add the interface to the header file

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
index 82a5e997d573..d5cb3f46606f 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
@@ -117,6 +117,8 @@ struct ta_dtm_shared_memory {
 int psp_cmd_submit_buf(struct psp_context *psp, struct amdgpu_firmware_info *ucode, struct psp_gfx_cmd_resp *cmd,
 		uint64_t fence_mc_addr);
 
+enum { PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE = 5120 };
+
 enum ta_hdcp_command {
 	TA_HDCP_COMMAND__INITIALIZE,
 	TA_HDCP_COMMAND__HDCP1_CREATE_SESSION,
@@ -134,7 +136,10 @@ enum ta_hdcp_command {
 	TA_HDCP_COMMAND__UNUSED_3,
 	TA_HDCP_COMMAND__HDCP2_CREATE_SESSION_V2,
 	TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2,
-	TA_HDCP_COMMAND__HDCP2_ENABLE_DP_STREAM_ENCRYPTION
+	TA_HDCP_COMMAND__HDCP2_ENABLE_DP_STREAM_ENCRYPTION,
+	TA_HDCP_COMMAND__HDCP_DESTROY_ALL_SESSIONS,
+	TA_HDCP_COMMAND__HDCP_SET_SRM,
+	TA_HDCP_COMMAND__HDCP_GET_SRM
 };
 
 enum ta_hdcp2_msg_id {
@@ -415,6 +420,22 @@ struct ta_hdcp_cmd_hdcp2_enable_dp_stream_encryption_input {
 	uint32_t display_handle;
 };
 
+struct ta_hdcp_cmd_set_srm_input {
+	uint32_t srm_buf_size;
+	uint8_t srm_buf[PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE];
+};
+
+struct ta_hdcp_cmd_set_srm_output {
+	uint8_t valid_signature;
+	uint32_t srm_version;
+};
+
+struct ta_hdcp_cmd_get_srm_output {
+	uint32_t srm_version;
+	uint32_t srm_buf_size;
+	uint8_t srm_buf[PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE];
+};
+
 /**********************************************************/
 /* Common input structure for HDCP callbacks */
 union ta_hdcp_cmd_input {
@@ -432,6 +453,7 @@ union ta_hdcp_cmd_input {
 	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2
 		hdcp2_prepare_process_authentication_message_v2;
 	struct ta_hdcp_cmd_hdcp2_enable_dp_stream_encryption_input hdcp2_enable_dp_stream_encryption;
+	struct ta_hdcp_cmd_set_srm_input hdcp_set_srm;
 };
 
 /* Common output structure for HDCP callbacks */
@@ -444,6 +466,8 @@ union ta_hdcp_cmd_output {
 	struct ta_hdcp_cmd_hdcp2_create_session_output_v2 hdcp2_create_session_v2;
 	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2
 		hdcp2_prepare_process_authentication_message_v2;
+	struct ta_hdcp_cmd_set_srm_output hdcp_set_srm;
+	struct ta_hdcp_cmd_get_srm_output hdcp_get_srm;
 };
 /**********************************************************/
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
