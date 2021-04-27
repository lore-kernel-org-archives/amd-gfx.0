Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97256C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 09:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C86560FDA
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 09:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C86560FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB9226E933;
	Tue, 27 Apr 2021 09:58:51 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690075.outbound.protection.outlook.com [40.107.69.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E1666E933
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 09:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf9HIJ6TE8q/wO1MyBh80gL67zqLfx8rbguc/hKy6OKRnwSJFMa9xa0y0gqM2cMmb1k3R48tL3TNAKLTAGLYkpUb2GeP4qnuRI1/O6TTgfHH+ndGsiMkTrPo/cz3JOOkV7+7S4m1BCII/5kxxn+mQlW2nLfuh8juyTglpd56SHFAHQcQEvYaLhTQamusdkuLBB8eLagtJ7kWVlc7WDoUDsK3cbk2db8AO62gMFfIs7/pyq4OzQsUHt4fR6Us5Pz/ck9CcA/Q67vZUYXf3ZstPcx16LvrAN7wQHYvyeBqvVriNg57cAoZYnFrCmvb1pdxlAdR3mAkNNmlsSEx4YSAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GN/MHT6QzEzFEaqXGdF5kniQ+ZGp/NTTjs9OtlOb28=;
 b=U+BvE5irtgE64rflu+QgL71e/Fuq0sl+BbXQ2rDAksZqMVBDaiqsnBBLEFT/CMuAjKFC2P7my4T/YHMAdvsAq5KS63J2heiNtxzjGC6b9XtM9JDf8UHeuDEosEsVN2EFQhAgh2JT2uDKq0yqCQx7C8kzhOumZXZWt9nvnMFl0+GhYtPGGHEykk603afnNufc7jhYHtA6A9TcUdd17jG3H2g9HwdZhVpVWPZo87deFcO57MFlJAmRQGoALBzX/oGSODvu+UyZv4PHGYRadGGImJczv6S3dlhASjRI8njS3PwLHONDn/Qf2MAuCTjk0orG37ll6Ibtjd+knisazDWzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GN/MHT6QzEzFEaqXGdF5kniQ+ZGp/NTTjs9OtlOb28=;
 b=zTvJf0O+8UtElgsDxM4LYjmH3ATl4DYufCYzCHmRHnFEqiqc1DUPPpm6YZl2OD5m/xhvG+AzPPaQbpDkw8Ukg6xPO0VBv3dPC3syEUf3H1jHumXgGWqqQBfBOlXbSgsomM6yFVN3cwD8jHPyo6zuNfLsUBb+meipuv5MGLFVDnc=
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 09:58:48 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::d8) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 09:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 09:58:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 27 Apr
 2021 04:58:46 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 27 Apr 2021 04:58:45 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix r initial values
Date: Tue, 27 Apr 2021 17:58:38 +0800
Message-ID: <20210427095838.10865-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e558f411-02f2-4bae-86dc-08d909630d64
X-MS-TrafficTypeDiagnostic: MN2PR12MB3774:
X-Microsoft-Antispam-PRVS: <MN2PR12MB377435F173679A2313F2567BFA419@MN2PR12MB3774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZ6ctLDK/w5AMmWcAZlybo96yKstjjewyv+geLPhLVJly8tGU2K1o3l9WgX0NvOKhtnySRQ948j4zS+ZosXYWTjzo2JIpoL7AUMhAO/nJz6sjmYyU6qScMkWF6xjBncxzhgnji4ivKvra+j9GSUxZW2Z44wTL8Kk62ntIwXf97dEPP5qsNfOzWgs6DPXja1hcXvSutxIqIb5Gj+L+A9jGgb4/ldJWOPqx/pxmiTyJWeIqbNE3ovrXmZCF4tD12ME2D6snaumNEBvBvjd+c8QHEB9LKFLapoUqKelGj1gwQdH3yUnY4hEQ+Ary0YfNmI6NUOtDiezYquHK1T/ukP8JWtikB3RHP/K14Ud3r/nRQ9o1RQLm+fDqAeH94VFRSftKkhVyfK2AFqW14F1ZO/6B+7UQSTTWolih+2NzwKkpurC+yAtIEZ/VXprAVrX+Cq7fGr+cjkf7r+EzEvVML7jkcvSd4Og+frndwIbAcpvJC9M6J1dBDV1sTxoJpSytOiyB2xkRLEYYaU/qP1yh7reiCVwl26z7WU7qH1hriGc5tnvwhK6+FQq9o6LV93ZAnzCySGFRe61YIFxAjAHAN4xcxcVMbMuF/83+opyLTKMUWAA4R5u+c++jxxIbwWbXgH/NGsaO50Hr3O+tLHtjFDckPOqrKS0vS4gB5cN2g4w3BMMd+4GgajxnEdvFefyrKUs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(36860700001)(336012)(8936002)(36756003)(1076003)(478600001)(186003)(356005)(4326008)(26005)(86362001)(5660300002)(6916009)(2616005)(316002)(6666004)(82740400003)(8676002)(82310400003)(7696005)(426003)(70586007)(47076005)(70206006)(81166007)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 09:58:48.0300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e558f411-02f2-4bae-86dc-08d909630d64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3774
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Give initial values otherwise sriov will get suspend of
IP block <dce_virtual> failed

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0f17984fdea4..36fdffd103c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1384,7 +1384,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 	struct drm_crtc *crtc;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	int r;
+	int r = 0;
 
 	/* turn off display hw */
 	drm_modeset_lock_all(dev);
@@ -1431,7 +1431,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct drm_crtc *crtc;
-	int r;
+	int r = 0;
 
 	/* pin cursors */
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
