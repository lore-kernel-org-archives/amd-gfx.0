Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD64C33CB6
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 21:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082F92465A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 21:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="frpvLVgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082F92465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351A16F8ED;
	Wed, 22 Jan 2020 21:06:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443286F8E2;
 Wed, 22 Jan 2020 21:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGrwRWRvD4k0e+kP/jU8N2bk34HVoiIi1NpJzuLkHMc9b5sHuPhIoOVDs/W0+fsyL3+fNraqY+PC/fHDcEdyMI32odNXF/JrVzy+jVTod9bgDzWOSGZJHTNFIHXw13duYS0i3Voo2lRiBeuo1kLRbKjTo4az+ID+yrlckzEwTs8fWHJqEK5CbkSTEKN6FAbaOLUDCVE6okNtLBHQb1wgVWs/Ss/pgf05Ifqc6bBGnAz3pT7JYZ4ii/xVQDD5Y1LVV8isRX8LQKXDDXQ3QOmp3H8cK3v7NDcgyxNpHCGOgreicwT5QS5RKljFG97HEq249fGwpTnBwYjuONYNjjbK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI9Qgax/SMSJ8L8YdW90uREAog76xOhDNgi0E1EjUlk=;
 b=YV4kTdfRiPyFUaj6V8N0iIx/LwH1SkgcKBuZYtFaTBE1oVbqqDToIBNjBrDWLItaTmV5/EXxfPs8XKXMy3gW0nlk5KdVv7co4KTdwNJszaL18uKziZ2lMYi6FdRUVIyxR0oHmdkCAOsCPcp8CtnRPnwFqcbkef62ba9yFxFLJsx4wt8/w5TVU3+XemEV8e90fGJwFHSBh/qdpd04PKVnlBMBuOUN6e+9751ddfjVgbKgyGnzCHVYW429yaHhuwxJsYUMfvNnB9aaLhukTbVia8S0k5kt+/Trc7boI3VqK+Fk6x4GanjBWtOVMOxUMvYa57Zd3mhExKmfArUs13lyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI9Qgax/SMSJ8L8YdW90uREAog76xOhDNgi0E1EjUlk=;
 b=frpvLVgso5xSCsPYkW5cMtjqpajcHfyWQsmJlrF2Wo8Aab3cO/1Oi54p6xKPC+kD9X7AuZU0oJvXR9nc/UN1nRHsn2QATspTADKzWfnVr7EpiPucr6ciF8MkxE68+JZhl1lRo58qcty2pKaIfiBJBAV40FPILCjskSInJG4Fkew=
Received: from DM3PR12CA0093.namprd12.prod.outlook.com (2603:10b6:0:55::13) by
 MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Wed, 22 Jan 2020 21:06:03 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by DM3PR12CA0093.outlook.office365.com
 (2603:10b6:0:55::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend
 Transport; Wed, 22 Jan 2020 21:06:03 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Wed, 22 Jan 2020 21:06:02 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Jan
 2020 15:05:59 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Jan 2020 15:05:58 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <harry.wentland@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH 4/6] drm/amd/display: Load srm before enabling HDCP
Date: Wed, 22 Jan 2020 16:05:46 -0500
Message-ID: <20200122210548.2647-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122210548.2647-1-Bhawanpreet.Lakha@amd.com>
References: <20200122210548.2647-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(199004)(189003)(450100002)(2906002)(8676002)(8936002)(7696005)(26005)(186003)(1076003)(81166006)(81156014)(316002)(356004)(6666004)(110136005)(86362001)(336012)(70206006)(70586007)(426003)(2616005)(478600001)(36756003)(5660300002)(6636002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f3b7fb4-2698-46e8-7c80-08d79f7ee32d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25728EAA46EF735323C02E7FF90C0@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jADKPvfmucC0MToLPGoka5VC5dVdBUUoFse+V8oburl129ngCONIGTfAb5djFCF073YDGm7OUpu1+lruU9a+0BV11Ovh7Aug9TZC6yiqUAnLVv1xY2gZY8jFPdcHAo/S52ttxOFDZgJEtdtuNLbjRTGFvLKOc1VPAkojKz8a/8OWWKKwgHeU+10Xzdbs/55cdafgWAQCxmFCRMyskYXvvItFYxIZqqnHXzZ51e7nJO8nUKQuOclEzpLGh6jgzQL3hnHkn29N5wksQ+tR3QvH5B3tv12MxclX481Jtn5mQrui8SX54yyOKYC2kEbkoOy05mzrLwCEDDF6txi8L0dpS57sRyJAWJq0DXyI8wUq1XK8sA/ucqSM6+ahBMlEcOPFutdPD5fhyhwmdx45/pGdiKQcDf6afEYgSE9o7cnXmtSeCf1SwTLhDTro4bWDvBe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 21:06:02.0731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3b7fb4-2698-46e8-7c80-08d79f7ee32d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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

[Why]
we need to load SRM before we start HDCP. Because for S3 case the sysfs call will be
after we have already enabled HDCP, so we might not be using the latest SRM

[How]
Set srm before starting HDCP.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 074243a2f808..e6a89cd7ed57 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -136,6 +136,13 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 		hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
 
 		if (enable_encryption) {
+			/* Explicitly set the saved SRM as sysfs call will be after we already enabled hdcp
+			 * (s3 resume case)
+			 */
+			if (hdcp_work->srm_size > 0)
+				psp_set_srm(hdcp_work->hdcp.config.psp.handle, hdcp_work->srm, hdcp_work->srm_size,
+					    &hdcp_work->srm_version);
+
 			display->adjust.disable = 0;
 			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0)
 				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
