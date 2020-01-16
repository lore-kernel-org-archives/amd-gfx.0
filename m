Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B115AC33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8650D2072E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bNR3lQhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8650D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50310898A3;
	Thu, 16 Jan 2020 20:30:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FB789081
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TevaFjWL+N4NPc1JVplxhjY7sq0MtCT4kJ3t0chWMJwW2smoa/1Ffp4wahMIB/05H9e8nbXk/JGD+VNP6rNbnM4SaXOYB7P0VksBKd+lxucBZuxuF8w5xh2Jmhmrdey029tCPvXryWRlq9Km6/ZXllJGRO4Bd2rl80wWh9sYk2KtxkbNCO42WUvvU1UFjwgPPV5djptzivZSedc57UMIdhy9+ftImMMb/gS6rcZ2KL21+tcRQIXpHIYonCUV7szewu+vA44qbn7e+4fB/795Y3OTkGaKKyu0vxD4q7O3iJGRZvIj+ZMrecnpGIlEjKm7OQhFkizcooq1IYa4rjNb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moOEti8AJwO4LhqPvtyKdXBOIHXYmnjvBpUkU7xnSPo=;
 b=D4h7it1zlw33EoiEnYAubjm6d5JAlFYnp3UZE2rJ0ECZzCGu0BpXWUym7kU8MQoADig6aeuc8ad7PeJbvVwSMlLVwrNlGCPjpGvYAFILk7P/r/SEzASb7h/HoUILocAD08rnAlltaS4Uxtno89pyTr8bk16tA3844OJfY6j+B3D7j+MOEDiqj3zPwK0nOwbiHkXBWUqwGqw4V9vmhZVwoSrRjcN3aOTDvyUQXkHm9lkCCx2KKrCQEjkrn5sltXblXNixtIjUnrlUNXv8+2kwwHhc4GueFM7JQO1Hy3TpSKSCVH31M0DhsejBCd2plDr5DjGEODtmYffkKTp3qs+c1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moOEti8AJwO4LhqPvtyKdXBOIHXYmnjvBpUkU7xnSPo=;
 b=bNR3lQhP78ZXVFCds9g0db/u9YNxt4lKw8pCa5SVIXtT7AoKOGO1m0Zo1WUst5DwGQxNnZm6kii8kGSN9vBRE2P873Y4uyPZnGDySRY2frDH1C+NsE1dyKUw8SutAi+URFXd9FzB4df+q3AVKsRlcfOU0pFesiZ1mwb9ntSwNgY=
Received: from BN4PR12CA0013.namprd12.prod.outlook.com (2603:10b6:403:2::23)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8; Thu, 16 Jan
 2020 20:30:10 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by BN4PR12CA0013.outlook.office365.com
 (2603:10b6:403:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 20:30:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:30:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:07 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:07 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:30:07 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amd/display: Pass amdgpu_device instead of psp_context
Date: Thu, 16 Jan 2020 15:29:41 -0500
Message-ID: <20200116202945.21801-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(428003)(199004)(189003)(70206006)(26005)(70586007)(186003)(81156014)(7696005)(336012)(36756003)(426003)(8936002)(8676002)(81166006)(54906003)(6916009)(2616005)(316002)(2906002)(86362001)(6666004)(478600001)(4326008)(1076003)(5660300002)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3333; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb34a586-abdd-49c9-1d44-08d79ac2e154
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3333C4E287A2324AB4292683F9360@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNYZIE7BuaCO5ORGUhDHMtWuxc9QQzNn5mkCwK6W/CQMltajLODlglCVi2bL6YCRjjTqlJOot9bLxNACfhgdPFN17ZRrAPlrOHD/JOWW4cjdX6Zd8CaIQpJM4h3sNAwOW6+liUiN7kQbNKxn5ZpChws2hFfEoHcEXqnj56Wsb1/pHrs7tf9o4HgtTEEsaKLfhNPiPC7wSG2Wd+kxAO/8Iwe8dJO+d6+tHjNgYCIc2uh3Fof0Je1jmsHWwBU1EXFlXITxMJX39tr3M+TM+JMPKOo7K0i7hXuY6oV0v+RzMkPW/UFVKQEgdOn/LM36naRocb9h4MieDDDhgDItyeAdWTUcQaTGrq8Sso5B4Mn/iWtriiZOnfzEtLGyo59nHd598H23uOI8p3RSTgTY5wqEsHW5j2ss/0HFPmjLW7Hhp7Qmg69lj3wt+oW7QCfirPHz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:30:08.9342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb34a586-abdd-49c9-1d44-08d79ac2e154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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
We need this to create sysfs (followup patch)

[How]
Change the parameter

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 48ad49c9a33c..db2404a9e2f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -960,7 +960,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (adev->asic_type >= CHIP_RAVEN) {
-		adev->dm.hdcp_workqueue = hdcp_create_workqueue(&adev->psp, &init_params.cp_psp, adev->dm.dc);
+		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
 		if (!adev->dm.hdcp_workqueue)
 			DRM_ERROR("amdgpu: failed to initialize hdcp_workqueue.\n");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 0acd3409dd6c..a269916f7dd6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -338,7 +338,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
 }
 
-struct hdcp_workqueue *hdcp_create_workqueue(void *psp_context, struct cp_psp *cp_psp, struct dc *dc)
+struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc)
 {
 
 	int max_caps = dc->caps.max_links;
@@ -360,7 +360,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(void *psp_context, struct cp_psp *c
 		INIT_DELAYED_WORK(&hdcp_work[i].watchdog_timer_dwork, event_watchdog_timer);
 		INIT_DELAYED_WORK(&hdcp_work[i].property_validate_dwork, event_property_validate);
 
-		hdcp_work[i].hdcp.config.psp.handle =  psp_context;
+		hdcp_work[i].hdcp.config.psp.handle = &adev->psp;
 		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
 		hdcp_work[i].hdcp.config.ddc.funcs.write_i2c = lp_write_i2c;
 		hdcp_work[i].hdcp.config.ddc.funcs.read_i2c = lp_read_i2c;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 6abde86bce4a..331b50825510 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -30,6 +30,7 @@
 #include "hdcp.h"
 #include "dc.h"
 #include "dm_cp_psp.h"
+#include "amdgpu.h"
 
 struct mod_hdcp;
 struct mod_hdcp_link;
@@ -64,6 +65,6 @@ void hdcp_reset_display(struct hdcp_workqueue *work, unsigned int link_index);
 void hdcp_handle_cpirq(struct hdcp_workqueue *work, unsigned int link_index);
 void hdcp_destroy(struct hdcp_workqueue *work);
 
-struct hdcp_workqueue *hdcp_create_workqueue(void *psp_context, struct cp_psp *cp_psp, struct dc *dc);
+struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc);
 
 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
