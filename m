Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80940C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 09:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F4B2076D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 09:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DvoLSuzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F4B2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA656EA31;
	Wed, 14 Oct 2020 09:40:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A2C6EA31
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 09:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7S2Whqds7ADkqyiKcAf+vyXsPKGg/plgfG2xS2iPU20AsOKLJuWuTY5TTF9Fu+lNx951LG0ySA14sTUE6O/AJF/WuppGVJL9pjeySJC0v+HgNFgQyp8Lmy2yisLKsdvdlR6SkXrwiSRx//vdgvibRqXYQoAHY0a8nc4yWa7B9BP0YZDNL01DUOLnkgJF7M9ve2N2qyMcKp5L0gK7cl4PBizO4RvJsEIBVqnbXx+Tsqngpv0C+CPVS39/Km9vzWp0LHWWsbSif8eIESMwbgkzFuZV8r1cPflfhjZe8GiEsPxv2Y3uxoxU2VlBYzogFAM1bd2sezgkz5mmgXwut78CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qtPk5Mmqm/uDX8khD7snwJ1uT8NITfRQzZScHUE0zo=;
 b=Izg7xnkbp0CRFNc9mv3YeCXi378prXKfR23c+88Qqwinj9U6N1rPqIjGJv+3l4gbAcSYcezXZ0c7bIQAq1MFx6ILUlQxT4iFPllqvnEEp4KQ4MuqFSM6HqwDOpfiqf0uGDGnSu48W9uzyyde337JS0M3czZwUrEBRb/4Zthzq3o5sWUVceKG/4upQ38ucDD3qYG6Ag53CHuqH8TCXzlFgH8ivw4eqZcFfgVvGrOCTvmMs9+Qz+cczo2lWGwIu4XlNP3JsViCRS8UqRaZXqHgc6UizLvV5H0B9POSq+Vok0BGq13kQzVGR3m51Hw9gv/B/K/2fgE8vl8cmB4us5rQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qtPk5Mmqm/uDX8khD7snwJ1uT8NITfRQzZScHUE0zo=;
 b=DvoLSuzKQ4Y5zj/ymtgRrkiHtvus43lz7NfXkw4WHm9o008gdeNWJmseIZ584QUD0Z4c/Xv6sF9AD8QBc4ttaPsqyalXiWnHrG2NNIfNN38rRwanqafLAQhHBUJMKQo+GjsoZzy/sXyvd5mFBA2AiS8eu3IF62BLbkB2nfxuFXQ=
Received: from MWHPR19CA0093.namprd19.prod.outlook.com (2603:10b6:320:1f::31)
 by CH2PR12MB3878.namprd12.prod.outlook.com (2603:10b6:610:2a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 09:40:44 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::b6) by MWHPR19CA0093.outlook.office365.com
 (2603:10b6:320:1f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.42 via Frontend
 Transport; Wed, 14 Oct 2020 09:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 09:40:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 04:40:42 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 04:40:42 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 14 Oct 2020 04:40:40 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: protect eeprom update from GPU reset
Date: Wed, 14 Oct 2020 17:40:31 +0800
Message-ID: <20201014094031.22448-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3e11085-dd41-448a-aae0-08d870253879
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3878E1D8BE78DBCED211F23FED050@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4unIKRDxr/l5gJ7P8iPCRpkKkYE+BQB71yZZD+NRPRp/5xzK0y3GGN09FPCFHtw3H6N1J+I/y5W3oIPKF3abgo7tiLMUOJY9YdtFF4XkRA22+uoNYrR7c6c2s99DRupZ9tPGAGgyv+VC9F3B8xNVTJypniaupzLkwCJFD03naXPLV+ktYz7vvLDSQHVAIJg5c5P2uWn5n8NZs7ICA5VRH8SLBlFheHFWc3BXwZLahr3svupHXE6q4Tgyi4+5SIN05R/bbYOYHkUSzd1PZ+TSJd873lUSndLtl0zBU9WOKEll7re7VrVXWEJIDzeiy3Kh0V26/gRzrt2GqvVGEaJIjZQxpS+Gp+Y4Ck3e0FTSvGJnKPnXgHKQN68nBQoU2VqxrG3pBzelmaLW5A8zEisfRGBqIKYxVqjjk6ksKouv8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(7696005)(8676002)(70206006)(81166007)(26005)(82310400003)(70586007)(336012)(6636002)(356005)(4326008)(15650500001)(478600001)(186003)(47076004)(2906002)(86362001)(83380400001)(6666004)(1076003)(8936002)(82740400003)(5660300002)(110136005)(316002)(36756003)(2616005)(426003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 09:40:43.4884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e11085-dd41-448a-aae0-08d870253879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

because i2c is unstable in GPU reset, driver need protect
eeprom update from GPU reset, to not miss any bad page record.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0e64c39a2372..695bcfc5c983 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -149,7 +149,11 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	msg.addr = control->i2c_address;
 
+	/* i2c may be unstable in gpu reset */
+	down_read(&adev->reset_sem);
 	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+	up_read(&adev->reset_sem);
+
 	if (ret < 1)
 		DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
 
@@ -557,7 +561,11 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		control->next_addr += EEPROM_TABLE_RECORD_SIZE;
 	}
 
+	/* i2c may be unstable in gpu reset */
+	down_read(&adev->reset_sem);
 	ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
+	up_read(&adev->reset_sem);
+
 	if (ret < 1) {
 		DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
