Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7791C56201
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 06:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33ED72222F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 06:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z/CLYJIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ED72222F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5845B6E86C;
	Fri, 20 Nov 2020 06:41:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1486E86C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 06:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZKBNNtugfmqcSmH7vFi0NS4XarlV1cYBm/3urftjGetIWAWvAEF5hGKG/KzOmS75Z6Ipoh60NR5VU4zjcBg1kIdSjlhv16N/lWlpaGxswOm/iZn7yoATu8FvPUM+0XstP4Ql9fY9eWajr9wkgYdmaXv4htO1QtoVQEkTuTbborneiCH2Lyu8bAJhFbQyU7jVSX80+C1A2f3RkBuggRNtch7LEUKgKSe3bAViM6RaWLf5qlsdkByYP6ty5PAYuL9I8JQZBXBbdwon0jxw5UfcqY38tHllF2K+Sdf7Hk4FBinZ4udfki+JqKsqPwaiif9Cnnc0wWKKXUElFUYuXva6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEVWjwN6GunamXTDMj0QKQtznGEGXk3nnoE0UJbW4wM=;
 b=l5dCHZWUNMqFI7KHcKLyjEC4CSX6RG48d1zolOhqDL7GI0sElXZxn0WOrzfR3rORKALr6b+HJPworA6s7yOUmrY/WMc41DwSBgnfCh5sDsZz3ESC47GLWIqUXcgTthSluadTDkJGFM88YA0T26JpMDjmBQLcfQ8sHYG7FCrVTHOEJpvPIJQIt/bMiqHZs3wC6HgXyT2sDBXZXXFPKlkLVIb5mv/Moi4wcgkCefMDpXeRIrZVf0zNS4UfOprA9Letgqt1eHy7a9zjKX8GqkJOXONMYohoL64/6ZW/Zw8gdFdG4yvTmzKWakdP0GYiN+dkn5F1JYJlu8GKDF77k17ueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEVWjwN6GunamXTDMj0QKQtznGEGXk3nnoE0UJbW4wM=;
 b=z/CLYJIhdGkTqyCFIQ15nT+32y9l8n/MlPN4TFMHNkYcm7cIDomvMYHzGXbGfIrJCQnpjxtD6gRviQQElMmyTvUhF3+ewk/BkS04LXZixxuMe0oWtHKjbhWwLQ+9G3QhSCUl1SQ3IEjk2u7YLp0GoUxpdR/qaR5I2zqTefnhPbA=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 06:41:48 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::a8) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 20 Nov 2020 06:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.22 via Frontend Transport; Fri, 20 Nov 2020 06:41:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 20 Nov
 2020 00:41:46 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 20 Nov
 2020 00:41:46 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 20 Nov 2020 00:41:44 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: skip unload message in reset
Date: Fri, 20 Nov 2020 14:41:04 +0800
Message-ID: <20201120064104.29795-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04a9e84-50d1-47a8-2114-08d88d1f5a99
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40858B9BE8B08F22AAB62DE28EFF0@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vk0M91DvkWPkmRS0ngBvNoGNsypVqaOZJAxi0TASt7I73bNY2rAsJqJmZ6P39IU7j0T2CHOEV5qEACpXg9VImTma6XfXNeaTZFmd6c1tF45OdjIEWReICh2+HLyl0jL1rqTdf94YO5fBBozMb35z5rBSpcy9ZJATXZMpCpBPIx4vVFWHB1KfF5665d+AJO6LTaMWfPUub2+ne8AgK3y/HF7gdYN+guJ1403/r+qbr0p6WYwj4sHskT/n0+JwsZR4tAZReYgBtmlEAXexOLhn6pAHi3smmn3Z6Z4bg1u2pC+yqu6C78wAFE9QnZOu/fBp6SzRxuvjRohhJaUZ3b1xyOsSAiYHSz9aleZNu+UBI7qPD2r2LyHuhkDV0djA7vxlTbqomdaR+umYfFXMTyFqCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(6916009)(15650500001)(1076003)(7696005)(5660300002)(336012)(70206006)(36756003)(6666004)(4326008)(82310400003)(86362001)(316002)(186003)(83380400001)(81166007)(478600001)(2906002)(70586007)(44832011)(8676002)(47076004)(2616005)(82740400003)(26005)(356005)(8936002)(426003)(4744005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 06:41:47.4663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04a9e84-50d1-47a8-2114-08d88d1f5a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This has been confirmed that unload message is not needed from SIENNA_CICHLID in reset.
Otherwise it will cause the fw wrong state after reset and no response for any messages.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 74cbaf212698..0f0ee7c5ffab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1925,7 +1925,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
 		return 0;
 
 
-	if (amdgpu_in_reset(adev) && ras && ras->supported) {
+	if (amdgpu_in_reset(adev) && ras && ras->supported &&
+		adev->asic_type == CHIP_ARCTURUS) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
