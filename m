Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC762C38BE0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 19:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2552080D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XUNYcSJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2552080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5636E903;
	Mon, 24 Feb 2020 19:45:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2386E903
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 19:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2FFA1TMGJPzpv+X+TRX7otmUvO6+b24OiobvxqjxoWHPI9dtxCrxWW6rcMP312qfFlIRhQk/IzoCnLCpi9ZJOfmyN0o0qeCmWhfgiD+PIJTcSTmpEoxrNfhpQWcx/bHgr6NoeRaMyFs9OZKZpjGLzVp/LDKNw2CY68ynz84Y+Il1Uy3H/swLX5UiPrdFVMXO1fb3qFksdQAsTVnkaWRZJxNOUF3r/cadeErSFeUDZgNL0ygu3K8ueWTgtoRb/1CyRJNUtbKpQ6MaSZEovTWlVldKmXH+brVEi1dlMOIMyIoxEdW8lOgZqwOmY0x8OxWjPUp/j/5jyqjJZM1650lbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXePzdXqMbXxCIfTJls1ICxfbyLI8fYi+Ian8vhvsXM=;
 b=GtJTPN2g7BDhuxDCBQuEeuY+0vvXRcpktZJyIav1SklZS8rLuhNrEaQfxF2C60lVrHBTvtKJc1UkNEDN7Y688RK3IVuBIlWXSN02BA2gi+fz2ia4G8EJY+zeLuTYat0APKp8u7IoO2RKfwHIG1X5df6k/RLNs3r+dWEJjl6UOvdwzdwyH191XTA7A61uP3KmJeqn2TtYJzsmOddRgtSd370VWN2Nsmn3gmqEs7yCd0XcBhL7AvfAl5ehbP+DoEWavekADOAQ8o2haSGMJ2QQttbHbSTBI5Q99Hc22oN7QsXAwWGUmTcKbJiB6ZY6O6yN4tGeexgRy5u+Mf+jbs66xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXePzdXqMbXxCIfTJls1ICxfbyLI8fYi+Ian8vhvsXM=;
 b=XUNYcSJxr+NaL3anfmTpgsUWc8uJlDgkXj3PCg3sSe296ZVH2RxxIdDIjaIEdVzR7LXkrSP6cEUmxdDFs1gT/CbiJzOpSfRfPr04UydZedpfYMSZeVvmZM9VnkXhJyKYhYc9tsFh9qSJs5YRFtTGJ++xBLVUScQk3BeDgSLgbso=
Received: from DM6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:5:1b3::37)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 19:45:37 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::1e) by DM6PR17CA0024.outlook.office365.com
 (2603:10b6:5:1b3::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Mon, 24 Feb 2020 19:45:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 19:45:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 13:45:36 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 13:45:36 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 24 Feb 2020 13:45:36 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: log TA versions on init
Date: Mon, 24 Feb 2020 14:45:27 -0500
Message-ID: <20200224194527.15599-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(428003)(199004)(189003)(186003)(2616005)(26005)(8936002)(426003)(336012)(7696005)(110136005)(70586007)(70206006)(356004)(6666004)(81166006)(81156014)(8676002)(4326008)(1076003)(6636002)(36756003)(316002)(5660300002)(86362001)(2906002)(478600001)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4126; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 385ae74f-9519-4243-b77b-08d7b9621f03
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4126B9AA0E014AA5F9B5DFE2F9EC0@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeTN9eh64CwXJ3Iq66QBgRvg+FyURPY4rXZCEZ8N76RCX7WWS7PcXNWdcwl801kNIDdSpMchkFKL7mxeUghDx8VVtwkOKdp0q6FiFW5qqXJl7nzeKhU4oXyDZoK6xDvCRqn7k9kYIAdxMa8c7lvji4YraY5kA8iNqyS+V8czwB8EBdMKddK7hIBRP620DcM0XwA4sVwoGoxjwwVwjpoQOafwMg2ZK/6jb9IkeyeuyTl6jp6AvzT2KtSlpmwol9iiWgwrMDV5zrTIqBLvyuiojZPoqXXA2IEYtnat6/FDSAJEudTq70VH3Clz2fAPLwWJh7yhmN92rvWOritPLCw3ZUOSsMNSPbgPVkXAWfQ0svNCLi9s0DipBnmhdrCacsiWirqfygjiAwvw76ooqRuqcaYVQc3bcOU6eaoDtUkqngJgGDLx6bmXa6yj1Nupyvys/czaQY0aJy7DKsjhOWoGfnAFvS0u/O8Qyk+En34tDAk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 19:45:37.3595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385ae74f-9519-4243-b77b-08d7b9621f03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is helpful to know what version the TA's are for debugging

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a16c8101e250..09d1433677a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -358,6 +358,7 @@ static int psp_asd_load(struct psp_context *psp)
 	if (!ret) {
 		psp->asd_context.asd_initialized = true;
 		psp->asd_context.session_id = cmd->resp.session_id;
+		DRM_INFO("ASD: Initialized (version: 0x%X)", psp->asd_fw_version);
 	}
 
 	kfree(cmd);
@@ -518,6 +519,7 @@ static int psp_xgmi_load(struct psp_context *psp)
 	if (!ret) {
 		psp->xgmi_context.initialized = 1;
 		psp->xgmi_context.session_id = cmd->resp.session_id;
+		DRM_INFO("XGMI: Initialized (version: 0x%X)", psp->ta_xgmi_ucode_version);
 	}
 
 	kfree(cmd);
@@ -658,6 +660,7 @@ static int psp_ras_load(struct psp_context *psp)
 	if (!ret) {
 		psp->ras.ras_initialized = true;
 		psp->ras.session_id = cmd->resp.session_id;
+		DRM_INFO("RAS: Initialized (version: 0x%X)", psp->ta_ras_ucode_version);
 	}
 
 	kfree(cmd);
@@ -832,6 +835,7 @@ static int psp_hdcp_load(struct psp_context *psp)
 	if (!ret) {
 		psp->hdcp_context.hdcp_initialized = true;
 		psp->hdcp_context.session_id = cmd->resp.session_id;
+		DRM_INFO("HDCP: Initialized (version: 0x%X)", psp->ta_hdcp_ucode_version);
 	}
 
 	kfree(cmd);
@@ -977,6 +981,7 @@ static int psp_dtm_load(struct psp_context *psp)
 	if (!ret) {
 		psp->dtm_context.dtm_initialized = true;
 		psp->dtm_context.session_id = cmd->resp.session_id;
+		DRM_INFO("DTM: Initialized (version: 0x%X)", psp->ta_dtm_ucode_version);
 	}
 
 	kfree(cmd);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
