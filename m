Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918CCC33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6250A20663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DhDL0u1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6250A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5082B6E25B;
	Thu, 16 Jan 2020 20:11:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE366E255
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS6yMz8fbN2Z8WaKNJypbiOzTRdwAtN8Cf8bFCl0vFI+BYMgXo3K0SqWGv9vw5AcIE4ZyQJTrnjDfOWFC5sfW/RMzQW89MHRBiLqs+uiV6nkKfkJG9et2753Bm79YRp+MfIXHoVylvHGmDkUXCk8+IheqEAGdOaun43BtGmGPyLkeLAvUgNDdwifWlTTPABnIT6XwtG6SZ6H8CgDv0wYZ4VFj9csO/Rt6JkZnTeV524jDh+90puR3Ls8iJxPyl38Eg76E4P09DDEQHyUHEWNgr8MRxOfyMe7hr+I7+ROs6oQ3PTwqejmyVsQvlBcsB49NZWUDbk91NQ4hZAxd477hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itWPK4X3BZprPzwUqq9G2CGArtb40cess6saIpuhlHA=;
 b=RpkSr4jTY65YA6aqUUmAEr5ixYbI5wtedmujGsw1VkKNxwf/xb1qmnxkBhRzEwjhgeVwDKz909ZwWf9fT0Q6K8g2S2Rnb7PucaqvD0pCTJMJhASU/cNbyg5RS9AfqYNN7JduXJFrPiSQ09Hv5PxAV3A55DtoR11LqKN/JzpRhUgSSqJ0yID7MpBVjDy/dPydN4dvpZ/3Ityoj+hDIHhmbbXmCmReY2sjeNZzcZTjOOYm82D8Wpak2/pffhvDxdjCSguiVPhYFwQr4kxJIUWxyCa+J+Gm9BaJ2EGxFZcYu//xC+wtuPWif/ldofUXGxOyDfexxobhA0z62X1xsJPDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itWPK4X3BZprPzwUqq9G2CGArtb40cess6saIpuhlHA=;
 b=DhDL0u1rri1NuZEx/Qx5wdu9DGgvgNA0c3zcbJFEYLpxkE24HaXUGeuT+JRkcrh1pexEjjFOCDQsjt+mO66KALeXF07NS5fsXQDkADk0vu9vzqYBGGIGxThtCKxhf/xwb4eNqVPNTn9MYAonrGPEgRHlvn4ZYbcBVUSbEL6Dwxo=
Received: from DM3PR12CA0056.namprd12.prod.outlook.com (2603:10b6:0:56::24) by
 BYAPR12MB3030.namprd12.prod.outlook.com (2603:10b6:a03:ae::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 20:11:27 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::203) by DM3PR12CA0056.outlook.office365.com
 (2603:10b6:0:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 20:11:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:11:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:26 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:26 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:11:26 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/22] drm/amd/display: Get fb base and fb offset for DMUB
 from registers
Date: Thu, 16 Jan 2020 15:10:40 -0500
Message-ID: <20200116201058.29200-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(428003)(199004)(189003)(86362001)(26005)(186003)(2616005)(336012)(7696005)(426003)(8676002)(2906002)(6916009)(81156014)(36756003)(316002)(478600001)(81166006)(4326008)(5660300002)(54906003)(8936002)(70586007)(1076003)(70206006)(6666004)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3030; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 946cc14a-2f8a-4506-778c-08d79ac044c7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3030:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3030D73090D86B716911C6E6F9360@BYAPR12MB3030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CS0caoI63gVLpcd5PDqI7wrvAwNLXbJcCxJoY5mnQmVn8g6dNqGuP9jX0ubrcygrLMokBh1yq4wlmZY43b5ioBmJXkMMqyXqgIeET0jMGVhOlE6AOk8FXgoWMG1AoeKFWI75Uyr+oLn+qHlijcTSOFmxTRw/bwzG7xJcGNlnjrxxyZi3l0K5BYfULXMSCWdh2Hglkz4D57ebc27kA9WsXejc/9omH9TD8WrQEYLnMbJ50RfFbAjB90UByeCjt91xvQEcft4sMmi8zfWevIFB/gpPso6Herbpl8jRcjA3/nXzIlg5d0isPnf5MYy4oR1LhYa9qnFEiEoYN5frPmgvfdSZoU1ySNna2a6joc0NbmBXl7a3GkQu3SPiaFnh0DLEnjuSTmrEO0nFcQRUzXwi4AUEyRIY3zjzzHH2/B8Dn1ObqPH1EFcwd7QXB2DJnzV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:11:27.3635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946cc14a-2f8a-4506-778c-08d79ac044c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3030
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Under some hardware initialization sequences the fb base/fb offset
provided can be zero or hardwareinit can happen too late.

We want to ensure that we always have the correct fb_base/fb_offset
when performing DMCUB hardware initialization so we can do DMCUB
command table offloading during first dc hardware init.

[How]
Read from the DCN registers. VBIOS already filled these in for us.

Change-Id: Iea84fd8bda3bff750e6aada75175711c01c6a256
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
IP-reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |  2 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 21 +++++++++++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  8 +++++--
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index 8e23a7017588..287fb9a36a64 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -231,6 +231,8 @@ struct dmub_srv_base_funcs {
 struct dmub_srv_hw_funcs {
 	/* private: internal use only */
 
+	void (*init)(struct dmub_srv *dmub);
+
 	void (*reset)(struct dmub_srv *dmub);
 
 	void (*reset_release)(struct dmub_srv *dmub);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index cd51c6138894..9229012b93e2 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -54,6 +54,19 @@ const struct dmub_srv_common_regs dmub_srv_dcn20_regs = {
 
 /* Shared functions. */
 
+static void dmub_dcn20_get_fb_base_offset(struct dmub_srv *dmub,
+					  uint64_t *fb_base,
+					  uint64_t *fb_offset)
+{
+	uint32_t tmp;
+
+	REG_GET(DCN_VM_FB_LOCATION_BASE, FB_BASE, &tmp);
+	*fb_base = (uint64_t)tmp << 24;
+
+	REG_GET(DCN_VM_FB_OFFSET, FB_OFFSET, &tmp);
+	*fb_offset = (uint64_t)tmp << 24;
+}
+
 static inline void dmub_dcn20_translate_addr(const union dmub_addr *addr_in,
 					     uint64_t fb_base,
 					     uint64_t fb_offset,
@@ -82,7 +95,9 @@ void dmub_dcn20_backdoor_load(struct dmub_srv *dmub,
 			      const struct dmub_window *cw1)
 {
 	union dmub_addr offset;
-	uint64_t fb_base = dmub->fb_base, fb_offset = dmub->fb_offset;
+	uint64_t fb_base, fb_offset;
+
+	dmub_dcn20_get_fb_base_offset(dmub, &fb_base, &fb_offset);
 
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
 	REG_UPDATE_2(DMCUB_MEM_CNTL, DMCUB_MEM_READ_SPACE, 0x3,
@@ -118,7 +133,9 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6)
 {
 	union dmub_addr offset;
-	uint64_t fb_base = dmub->fb_base, fb_offset = dmub->fb_offset;
+	uint64_t fb_base, fb_offset;
+
+	dmub_dcn20_get_fb_base_offset(dmub, &fb_base, &fb_offset);
 
 	dmub_dcn20_translate_addr(&cw2->offset, fb_base, fb_offset, &offset);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index 53bfd4da69ad..04b0fa13153d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -92,7 +92,9 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_SCRATCH14) \
 	DMUB_SR(DMCUB_SCRATCH15) \
 	DMUB_SR(CC_DC_PIPE_DIS) \
-	DMUB_SR(MMHUBBUB_SOFT_RESET)
+	DMUB_SR(MMHUBBUB_SOFT_RESET) \
+	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
+	DMUB_SR(DCN_VM_FB_OFFSET)
 
 #define DMUB_COMMON_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -121,7 +123,9 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_TOP_ADDRESS) \
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
 	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
-	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET)
+	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
+	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
+	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET)
 
 struct dmub_srv_common_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
