Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA08C55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE352224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BaQNwTAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE352224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8ED96EDD5;
	Wed, 21 Oct 2020 14:23:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6256C6EDD1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A10tZRFVOxRH6vmPAozrxaLULOgKHncYuQG0OixzFvuziOStZqBAntHa11LuDOTpFT/qr0eCyRCroH+ENc1Tovk09F6CfcbbgBV627AEIQ2zaGRFq1KJ9lunMfhO7ngot5SdN8QKaS6rZBL/xNcSBHIvjRVT3kjogLB1tB2Wog+BhPXKSeudXNR3mK25gSP/vt3d79Si36jTDhdQv9NDf8k1XD1+DYBt6GDfOub5m6Nul0ieQxz/dTURBoklNhf32+ulZGSlth6MjVgG1QXm4nFuJ2/BxicWyXU2HFW6wj1qBj5txjvc4kcDMPoHGdOXnCJvrL4DDEhbW7tUwAgyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMpZy4AQVVnX0V9QqucPA+o41exw084JK6lPNa6C8WA=;
 b=CS0XOY53mHXTn2mZX20olKBsHypd5AstFyedJ69MSuJ5MFr0wPzrGf5BgVN2H886eusTN+j4BJWB6n5TSQdfIdDA0i6RH1XnQKtp1H3QkXN0Luz78sZatmLovSPSq39JfCoM/UpvBmgBk8n/0z0n4i4bevozfxeoBYscyhbXq+9RHCgEnkACOYzy06VdDXH7aGUglCH/k1wY2uvF44sDz7pj7zzuNoSVxFR82mcoyg0tsQpN2Padii/+PgKZ6MoUnXxi7Ox0FY5p5pOtj9n9NWiLYo3y3cwW9N6u1UbG4rPhrVZ0E32m3MKwQpEEWwh2zU9i4KSAUV6WiptJro4EMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMpZy4AQVVnX0V9QqucPA+o41exw084JK6lPNa6C8WA=;
 b=BaQNwTAZwokMuAjK6tGTKgeKbwcjGOqkFbA5zXCxJAVXSDZoIcq8r95KtSMEMzVpEHZ2WlSPgXAZwkCYbOd9OM49mvcv3iNslS6zbOusHoSGhS5CFqYy93CLCs6jhfLNnwapSl8dGRvgmjvBsaA6C8BQJmzM49ZM6nNACnj3SBo=
Received: from DM5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:4:15::14) by
 DM6PR12MB3593.namprd12.prod.outlook.com (2603:10b6:5:11c::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 21 Oct 2020 14:23:25 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::b7) by DM5PR16CA0028.outlook.office365.com
 (2603:10b6:4:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:25 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:22 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:22 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/33] drm/amd/display: [FW Promotion] Release 0.0.38
Date: Wed, 21 Oct 2020 10:22:47 -0400
Message-ID: <20201021142257.190969-24-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6abfd74d-87d0-4dcc-1e1c-08d875ccdf2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3593:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3593E778332E6B5C4D6945F68B1C0@DM6PR12MB3593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLMqJqrlF8G8xAxTxiOzmqHZM6H6ZK5hOGccju3y6XxKiz/BSiAb2RYUqfEAK7Lg7R33TcbyG4A651aud0a7Cm7zYORdC7cdAzD/CqxIxbXixpJ3r/kZpXlI2Aa+U0BB7A9zBxfPb2OASgbEVflZ11mhN8DTqpGUa3GWeRlOzfMqZaT1h25QtQVBfD1uwjj/uRVmCpvF+Wgy6ZvAtqBN7i5t142LHOi34A1LsRFrDPE0Z6TFWAvbjwPTm4U0B/wbpsD+t+R9phT/5PFb6HGHpGkiXym8e5wAOmRbjcgLRS7EFcns2hn/Uin30ou/zk8m/UP2ifsYN1NGydwznX72B1sqOVo9z5SoQa80yYrI8n9+rV1Q6hVJn7RI/yDSFdDBZr97Re6yJ2YmJLs78iNEtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966005)(2616005)(478600001)(26005)(316002)(82310400003)(6916009)(54906003)(82740400003)(81166007)(47076004)(8936002)(83380400001)(186003)(8676002)(1076003)(356005)(70586007)(336012)(86362001)(36756003)(44832011)(4326008)(426003)(2906002)(5660300002)(6666004)(70206006)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:25.0120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abfd74d-87d0-4dcc-1e1c-08d875ccdf2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3593
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

| [Header Changes]
|       - Add new SCRATCH15 boot option and fw_state member to skip
|         phy access
|       - Add new SCRATCH15 boot option and fw_state member to disable
|         clk gating
|       - Add defines for AUX return status
|       - Add defines for HPD events

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e6166a4ba71b..c0669e47b8c4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x1893cb959
+#define DMUB_FW_VERSION_GIT_HASH 0x8aafc9acc
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 37
+#define DMUB_FW_VERSION_REVISION 38
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -189,7 +189,9 @@ union dmub_fw_boot_options {
 		uint32_t pemu_env : 1;
 		uint32_t fpga_env : 1;
 		uint32_t optimized_init : 1;
-		uint32_t reserved : 29;
+		uint32_t skip_phy_access : 1;
+		uint32_t disable_clk_gate: 1;
+		uint32_t reserved : 27;
 	} bits;
 	uint32_t all;
 };
@@ -477,6 +479,14 @@ enum dp_aux_request_action {
 	DP_AUX_REQ_ACTION_DPCD_READ		= 0x90
 };
 
+enum aux_return_code_type {
+	AUX_RET_SUCCESS = 0,
+	AUX_RET_ERROR_TIMEOUT,
+	AUX_RET_ERROR_NO_DATA,
+	AUX_RET_ERROR_INVALID_OPERATION,
+	AUX_RET_ERROR_PROTOCOL_ERROR,
+};
+
 /* DP AUX command */
 struct aux_transaction_parameters {
 	uint8_t is_i2c_over_aux;
@@ -526,6 +536,17 @@ struct dmub_rb_cmd_dp_aux_reply {
 	struct aux_reply_data reply_data;
 };
 
+/* DP HPD Notify command - OutBox Cmd */
+enum dp_hpd_type {
+	DP_HPD = 0,
+	DP_IRQ
+};
+
+enum dp_hpd_status {
+	DP_HPD_UNPLUG = 0,
+	DP_HPD_PLUG
+};
+
 struct dp_hpd_data {
 	uint8_t phy_port_index;
 	uint8_t hpd_type;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
