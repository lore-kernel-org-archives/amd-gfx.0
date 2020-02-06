Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D5C352A2
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45B021775
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q0eym9uS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45B021775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300696FB5D;
	Thu,  6 Feb 2020 21:14:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D026FB61
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 21:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy4sDrELE99r3xXCTH03vkkAdZV/oZSbi49NOvGdyauDalo/ewE/8oMJ/pC2Tu6qDychG+J+mAXI3/orKh0MAHVT1QfUmSPB21oPakBy9ysNU1saP4TZTeTInPmX+X2XVpwX6vxhZouDgtyHsf/+JXi4FJCAqalYn6rLC+aMtmJbXx+TAGVtkSb+1ArdBDYdlszJiZ+ITUGHSULKlsHx7TNHO9Y76jA/kFuTdj5gJyq5GdPyqtklmJQuu+P9VH/rtcHj9afXeGI65+uf8V47e3gaWTioc822TRAj2AvlYG2jW3fPPGCubsJMd4EBCQCPLm978cw+vQhHKZoo+LQeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8KZLmwApnFgLgG66yzLalQXxc4Hke5tWOVbqG2LIAA=;
 b=bwYcfWpPNCTWH0azAHA8ama5LPbKCCSEZ7RibAyg9f0SOdmc8uMwy0faUyXIEYU1HSpxwiyMFTdVEi3hVtQV+snMsGapZvHPhPgC18cb1pDScyYjygdyrg1NhIkRaiGKc+XZ6qSAoAETmBSgXmmj2do05iS9qX9Nnu8RY43EZnpzH18wLCaSkw2Fj/x4e3p07pW/z/m6al+z1/ILM8T4yHemb9U0iQnb7xU0tzsiHTjU6M0xHdvXik9eGIQQGN1hSc/IGVUMlxFUbgtfEODj33vOmjamRbUMvN7FVkQvq8SDkv8AoOROvdjQv9+1u2jdgICOOLM3LApnqBBegmqBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8KZLmwApnFgLgG66yzLalQXxc4Hke5tWOVbqG2LIAA=;
 b=q0eym9uSMzgrpkOw/I+7/gI9XGiUF9mZnWlIiSsmTXYT9FFt07XBb8uLL4MqSODiQ57PnlDg/NAwbVe989gEHirioNBpRPH+3niYoPK0dbBvuXC4jwFEzn8650TVihRSAtraIWJQ0MDziLfHc4M/Y8Egr/0jwjZjKiqtTdWesvk=
Received: from MN2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:208:a8::19)
 by DM5PR12MB1931.namprd12.prod.outlook.com (2603:10b6:3:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32; Thu, 6 Feb
 2020 21:14:40 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by MN2PR12CA0006.outlook.office365.com
 (2603:10b6:208:a8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend
 Transport; Thu, 6 Feb 2020 21:14:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 21:14:40 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:38 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Feb 2020 15:14:38 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd/display: Fix message for encryption
Date: Thu, 6 Feb 2020 16:14:25 -0500
Message-ID: <20200206211425.20394-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
References: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(428003)(199004)(189003)(4326008)(186003)(426003)(8936002)(26005)(8676002)(2616005)(36756003)(6666004)(356004)(6916009)(1076003)(2906002)(336012)(5660300002)(70586007)(70206006)(54906003)(7696005)(478600001)(86362001)(81156014)(81166006)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1931; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71f538df-d233-43d2-929e-08d7ab499453
X-MS-TrafficTypeDiagnostic: DM5PR12MB1931:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1931A3BAEF0BB698AD267903F91D0@DM5PR12MB1931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opHGhUGf8aNaEDtVBBQKS3dbg+ba7ZH5NA25wlH810TK76LN0mqHqBiobem4V/ymuVmqI7Q4CSJ7mkrItSvdyIRwMvfG2TKMVmayFw2zIQc3I+Vdom3TaxoO+dNm/T76MGqMcCOz1ugCtAuX4GoW6K3IreehoA9RfsCg+HzGphuze5lt0IWP+pcs3guyeIoQ5yu9dkZ40cnpQpwACDn5Kain3aDeq18dHsmGqHJ+jHRrFb7Daocc20KfVEZcqHEMiWDy15pM9h8Vt1hUaJ6oXVL5MZbaD/6slCypdGMGmnneLmV5Xi94gsozIYhdtnXNSKcnQtr/kP3txSHOKSF9p6pnrLzeXyd7nN+o84WGUo652Wl+F7lGcevIbaEw9O7DdOQoTumoBjuFJa/Q0PjM8OK0+UQI0fNBod8nKqW2HDyOmyy3ahzaJeC7ss4ju5zd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 21:14:40.5261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f538df-d233-43d2-929e-08d7ab499453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1931
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

-msg_in is not needed for enabling encryption.
-Use hdcp2_set_encryption instead of hdcp1_enable_encryption for hdcp2.2

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index acbe3e8a8eb7..d9cb2383d6de 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -662,20 +662,15 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
-	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
 	struct mod_hdcp_display *display = get_first_added_display(hdcp);
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
-	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
-
-	hdcp2_message_init(hdcp, msg_in);
-
 	if (!display)
 		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
 
-	hdcp_cmd->in_msg.hdcp1_enable_encryption.session_handle = hdcp->auth.id;
+	hdcp_cmd->in_msg.hdcp2_set_encryption.session_handle = hdcp->auth.id;
 
 	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_SET_ENCRYPTION;
 	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
