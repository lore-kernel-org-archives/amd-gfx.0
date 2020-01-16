Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C3AC33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C292072E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dgCMRvll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C292072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515F7892FF;
	Thu, 16 Jan 2020 20:30:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019828913D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGV8ex6IfG6LH/i+ES8on+vbdcvUS4O0qgme7rn1tL5LyWe3CO15212zFqR+pqrv0xijR4HE7mtBdZnEa9cP/1n/W3grrM0ICDYRIfn21HgtX/vtmmleyDPtOHCOdFwIei2x+3gIN8ykojtRTRG9KPiekC3oPzCBkOHPRR/cduC8kPY+eNPFy293RR+VnMMzVhXMEKm0n2WNIN2oI+qVB86xI89Clt6Cu7w0b+fypCwClMzBQ4NWSDATQCwcQDxrW595TOw40yIKPAPdumAmRwWr1GVIGqndbX/EiQSX8Ekmwcg14tjr5ri5pmdzMuXO5wVnKMR/TP/tv2YR4Kvzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uS8z1Le3xpfMQMvyMrbj16uMKIE/Y+OWppCht8BL+w=;
 b=kHHsfvPFrOHYnM3g9MuX0RNPAk3i03ExVA5cG8ZF9HHkBRR+nsX8QUVwdq+/miemAzinIpPxf2EUbd5VHWp887fvvfRmmtTOyH1a7xAbKR1k7m+tb6Wb36Q1Mtulgz9+Gsapfl+WRPSQH3NWRCgvUhbeB5hkZEhea8uiY/beuxTxByKbWPWVxlx25wq2j1pLBSlFnjZMHxQ8EO6Iliio/LdyqYLrq2oTdOcsNDHASpTsfY34dGNsIdvk3gh5AlAlxPPdDgq1NzAi4JopN0cH/sfEr8dWOZZ9rNdJ9/rGKaWvr6B4cOeIE8NppjMLXMzObR+6rAmXmTk05hlbnyHddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uS8z1Le3xpfMQMvyMrbj16uMKIE/Y+OWppCht8BL+w=;
 b=dgCMRvll8YoZYjfmf3bqXqUaA2mLiED5DFbLTOyEGWw+qB3VUDLX90VTgNjFeWnwVI+fP8G5LqvVDeNI1P14WhsXbWYdhDMoUHUzMlGeoTsquqQibAwukkIpcUb17ztk0lJzjAKjTaclb+bsphqBUZJdqrAQc8/4w/kqoPQ1jD4=
Received: from BN4PR12CA0013.namprd12.prod.outlook.com (2603:10b6:403:2::23)
 by BYAPR12MB3429.namprd12.prod.outlook.com (2603:10b6:a03:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11; Thu, 16 Jan
 2020 20:30:12 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by BN4PR12CA0013.outlook.office365.com
 (2603:10b6:403:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 20:30:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:30:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:09 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:09 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:30:08 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd/display: call psp set/get interfaces
Date: Thu, 16 Jan 2020 15:29:45 -0500
Message-ID: <20200116202945.21801-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(199004)(189003)(8676002)(356004)(6666004)(70206006)(2906002)(54906003)(1076003)(70586007)(316002)(5660300002)(6916009)(36756003)(478600001)(4326008)(86362001)(8936002)(2616005)(336012)(26005)(81166006)(426003)(186003)(7696005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3429; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26688166-d132-42f7-d2d0-08d79ac2e2f4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3429:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3429C9EACDEA219A11F2249BF9360@BYAPR12MB3429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbB1TRz1KIjnXYzcwd14bbGItfrK8Sj4b1FrPde9TbIamAEhdezE0pJztJ7M/dTPzvCeXk2wDoKfKhhpXSosQQn6G4SMWKc4SYZOM5vCQAQkek9/pkYMPcfetDzzkUp/7UOjfO1ntiiihjIzR5xLmPrrLoQlO9CacXEIlaB5RaodJXwnC63ggTA4r3v/bupNSkzHO3PhiTL8euWmx0gpq23OmLoX5R6zgmPsGgmQkvX8RNgeKRrCj2O6l1WIH1VFdkIGCGJAQoiZ7IrrULvC8Q7WGu8xnHB/fZuyo5SxbZy+RB711jcjHTQnzix7LKrCAhfL5RcWqQkVORtvnm2zkTspdGPA2s+sLBuKeTZHZ4DEut5ZWCD2mG8t8w9TdH0ubK20pHzgG0Sh/6fDsH8uYeoWzGzZ3EKB6CVURDROBx8ebNhT8vOi1nHc+ozgKyBa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:30:11.6651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26688166-d132-42f7-d2d0-08d79ac2e2f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3429
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

Call the cmd ids for set/get srm according to the sysfs call

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 129696e997b6..913d0e1e0828 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -71,11 +71,58 @@ lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
 
 static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
 {
-	return NULL;
+
+	struct ta_hdcp_shared_memory *hdcp_cmd;
+
+	if (!psp->hdcp_context.hdcp_initialized) {
+		DRM_WARN("Failed to get hdcp srm. HDCP TA is not initialized.");
+		return NULL;
+	}
+
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
+
+	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP_GET_SRM;
+	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
+
+	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
+		return NULL;
+
+	*srm_version = hdcp_cmd->out_msg.hdcp_get_srm.srm_version;
+	*srm_size = hdcp_cmd->out_msg.hdcp_get_srm.srm_buf_size;
+
+
+	return hdcp_cmd->out_msg.hdcp_get_srm.srm_buf;
 }
 
 static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size, uint32_t *srm_version)
 {
+
+	struct ta_hdcp_shared_memory *hdcp_cmd;
+
+	if (!psp->hdcp_context.hdcp_initialized) {
+		DRM_WARN("Failed to get hdcp srm. HDCP TA is not initialized.");
+		return -EINVAL;
+	}
+
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
+
+	memcpy(hdcp_cmd->in_msg.hdcp_set_srm.srm_buf, srm, srm_size);
+	hdcp_cmd->in_msg.hdcp_set_srm.srm_buf_size = srm_size;
+	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP_SET_SRM;
+
+	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
+
+	/*
+	 * If the SRM version being loaded is less than or equal to the
+	 * currently loaded SRM, psp will return 0xFFFF
+	 */
+	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS || hdcp_cmd->out_msg.hdcp_set_srm.valid_signature != 1 ||
+	    hdcp_cmd->out_msg.hdcp_set_srm.srm_version == 0xFFFF)
+		return -EINVAL;
+
+	*srm_version = hdcp_cmd->out_msg.hdcp_set_srm.srm_version;
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
