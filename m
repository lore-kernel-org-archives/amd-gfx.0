Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1260C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15962072E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tT3LYj7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15962072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDABC89939;
	Thu, 16 Jan 2020 20:30:15 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760059.outbound.protection.outlook.com [40.107.76.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E778913D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwXzGoPnMK0wriH/AzVEtTyuSvQMYcvOG231lEWzgDRKqVEamUyRC/5dJdso8GzOAnnJSD/TFCCb9QXdRvMkUZfg9HxfhEd2witW4GANzZaPsPvXPSBryXoUxpJ8opPzYgbCklpTG/KlDGyvhQtjXaVfMArrXQSWl4SZt20w4E6I6AkEzZ3T1stRDw7/0N7A0dCK5TzlhO1RRgsgI+qkxBV2bVs7yj1jnqJn3UyDp/V9yKArsneaEnfVj/q9/l0uzhe7rX9szVukNJUUClinSNM30hVXPVNCEriwfpbIic5Z+9GqH48bZugQ+8zdUOH2RcGJtz2tJ2LiONZoO2synQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfloqQ34ZAUXjd6PClms7qMrRnKCjdfdxgCTBnCCa/A=;
 b=muWPaf222E8OGGfv6EerJsbgRRWCABHnI0Xuj5ZZnsPRWhtSKLqmM3O4AVn14nEYzoYmIGjILLnyDwHvBcxM8XzF0AxT6xbxArmse4/stByjzjmTktWjezidl9EkUCAzNBhsFaKisLUKgA3VbcdL7ue9xWt+FsRZTthxl2GCcoEP5Mj0x3g7sJPbQmiVnb1zTf/KTosdrR8dFo0NIGp2HUajtBwkKtFULBL9lric7pT4xmftitaHQZziRANgxPxDr7A2m1OnqsIAPiNkKws+EuQjeXg1cYbUTP3enzaf7Z6BSnbFhaBqE5xNxkVtymO0geG1iNV3eGyzp6WBXLU7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfloqQ34ZAUXjd6PClms7qMrRnKCjdfdxgCTBnCCa/A=;
 b=tT3LYj7JFm+LDxf2XD8dHrBimm8nEmrUAW7ETU/SXKEvvC0SVGrtCjrnFyPaMJuG6mTQ005O3ViN405IejxD85VbCfULmWHM27DglMJHSuE0Vo580Md48imDsCWYtjIwv5Xgt0FWWnZ91+A8J2XQfJcsanj1Dy+mRCt4eh9TE4A=
Received: from BN4PR12CA0013.namprd12.prod.outlook.com (2603:10b6:403:2::23)
 by CY4PR12MB1799.namprd12.prod.outlook.com (2603:10b6:903:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Thu, 16 Jan
 2020 20:30:11 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by BN4PR12CA0013.outlook.office365.com
 (2603:10b6:403:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 20:30:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:30:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:09 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:08 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:30:08 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amd/display: Load srm before enabling HDCP
Date: Thu, 16 Jan 2020 15:29:44 -0500
Message-ID: <20200116202945.21801-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(428003)(189003)(199004)(81166006)(6916009)(316002)(26005)(54906003)(81156014)(2616005)(36756003)(7696005)(8676002)(2906002)(186003)(86362001)(4326008)(8936002)(426003)(478600001)(5660300002)(1076003)(356004)(6666004)(336012)(70586007)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1799; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67fffb14-753f-4fe7-a2af-08d79ac2e24b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1799:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1799C57CC63E28EC12C618E9F9360@CY4PR12MB1799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woXf5xUDeez/9xFDNOoDn4DVb4Wny6TcIS1TeNVZMmqw0iI6KMu4CmN8fjFdjgJZ0ZiSCr7+Cr4q4/uBMOUj0DuBpSoGVCPYExKlZ04aw7Wlg9uYCNOAGTH5/Y4DBiBA9HjgTSh4+cWIzAlRJJdLyGtt2f/kR/wA56a/wZm30ZSX85h4FyHTZUiPcNzeFv50O/Sc9utNpSNX47bl7+2HbjmXbZ41gQwmrsgmXqaIpY9pblAujW+dnw0cwPGqRrc04nBr/WYY62cXcmBQdqres9uZGzlo8TR1GY22N7Iybx1W1+piS3V+jYPDCIE+AtSoSsRNbCU0YJH++0qreS1d6ib6pal8F3r7cDxS+LqTHn7KJvba2gBiOmZWtL2yMMWdfjOFbWDE0c5E7sEJe4hX3VytomOXXO47OO/WBt4kp/pRU2AbqBAxVA5dpzBaZyap
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:30:10.5553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fffb14-753f-4fe7-a2af-08d79ac2e24b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1799
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
we need to load SRM before we start HDCP. For S3 case the sysfs call will be
after we already enabled HDCP

[How]
Set srm before starting HDCP

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index a191c84ad8eb..129696e997b6 100644
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
