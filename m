Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F6C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 16:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BF622227
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 16:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BF622227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B2D6E2E1;
	Tue, 12 Jan 2021 16:13:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53AFD6E2E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 16:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeJkTjvdvuWrLhEHo4++R06VgvJ1DIBzCOdou89qPKOEInnDZ1R0JpNxcuKziAhVNQUQaHUxQYL+asnfJ7YyRkLzKBIUgyYZTYMQU8clihpZL3+ksQqJnxtfX0eXNRFSELVc12dUcnbrelAjVlTEI4Np6EhftpYK/W32phjfmomZ20f6XxqYq/4tgI43u/Sl7yTuIjbEpTYzw0nyEDtz7qQlhScXsp41wkE4MSrO4xMqp1pnXxyJZUjSeP2D8XQ55yHFMTHyyHihHMtBsEE17+gg8P5EhERw8AwWxlwwp6kxbOM7Xsbr3XJZopKR3UcTPf2zxPUfHxJccymU+Rd38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q0WYHHX58fPynhLZ8tJ15NIlmB64/moP/LWqZ2bNDE=;
 b=JPWaKBRb5trKhPYKVogOIavtik4VrtmvM3iJV+fm9chRupPdUCOpe3bg4KGd2q5bgBwDZYTV0hYu3KwQLqdZjuGWsnoBumBfm7Qj5Xo4vJC73hI5/bkwJ4+g+qffjg2Ls/sIAo4bZyiIkIIYoiRJ2AxS0YmqRdjjYuqThdT8PR2A0A5BB/oIZY3VKsdCGd9XEBgvLuqtIjiW+XhVPwwcDAoBWYIzayXuALJt+sXV31kG9fR3m45dcbcSlWehN9jxUef2MT60c1k1uI+Hm3byHa80y8R8UbPfuKhqmzkOzJyfeo4UxO8qvflAyYpaBif308j+KT9qAxWptpXMD9DhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q0WYHHX58fPynhLZ8tJ15NIlmB64/moP/LWqZ2bNDE=;
 b=QnApr6Hl3Wy6zfOIXih/3DnfRcq4+Zq8ZCuJRBgpvPJjREjizzjv86/XA5kjp+5eUXaCMnoa63yXA6xa0V2PsFcGvTsRkOFXtU2NBwJBGmCc+2iQzZfeqZKHRo2ThxUrKh9hD5E+j6hysIqYz6zHScsPkbcDlhevsLDTyGhvU2w=
Received: from MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 12 Jan
 2021 16:13:35 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::2) by MW4PR03CA0113.outlook.office365.com
 (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Tue, 12 Jan 2021 16:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Tue, 12 Jan 2021 16:13:34 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 12 Jan
 2021 10:13:33 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 12 Jan 2021 10:13:32 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <Guchun.Chen@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix deadlock during gpu reset v3
Date: Tue, 12 Jan 2021 11:13:26 -0500
Message-ID: <20210112161326.1159175-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <MW3PR12MB455434CFD3336676DB64B077F9AA0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <MW3PR12MB455434CFD3336676DB64B077F9AA0@MW3PR12MB4554.namprd12.prod.outlook.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e6aff94-8c42-4f80-ff81-08d8b71502cf
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848506EF03CEE0D0C9C3905F9AA0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QZo4vsVKAWpALveINkI502ewzn+CKsJM+IDq0VPgxMmEwi9Qkmzx5TCIpWTEOa6G37nfHWOPB5BPUrL2e83zb1pVOmbIb/31jWBO7NXJi5IbprdfbQSwsyCTQ1GnsDBv5Pv6mZovFDbhredDwdGsqEw2aJ9sA63r0cn2mQJVDG03XmFLKpcKHxXCfyFoQBlDWqkA/jZnFoCHs5qk9J1G8uUaMsydZlKxJArToTMmG2stTP4+vDHkiouM9Wtr6TSvFstjMnjFf3o1WkYBnEQqZaFlsLfF/X7Dmz+4ft8JKlcJGd5XTCTFq1N8KYAi5i6qeKsSAWHtEWSE/D3UrKgO9HSp1Q2/xST9YJNJRf0hubhxiCLqW/JRNCbwDAd8E/9LZ5DLa1WGfHKBKTiPtObj1Yey82+zfHG/xOnSnKRswaZLvB5/ogfBWdCkKZkYtzUXUFTxLT5Et2kVHe6S0RLegSWzKsyeYu8vVAlzHI/C5Rra6pqvsNWoX5wh8AxXAAE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(426003)(70586007)(83380400001)(8936002)(82310400003)(186003)(4326008)(86362001)(2906002)(81166007)(336012)(6666004)(70206006)(26005)(34020700004)(82740400003)(47076005)(6636002)(356005)(7696005)(36756003)(110136005)(316002)(478600001)(1076003)(5660300002)(8676002)(54906003)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 16:13:34.0628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6aff94-8c42-4f80-ff81-08d8b71502cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
during idle optimizations we acquire the dc_lock, this lock is also
acquired during gpu_reset so we end up hanging the system due to a
deadlock

[How]
If we are in gpu reset:
 - disable idle optimizations and skip calls to the dc function

v2: skip idle optimizations calls
v3: add guard for DCN

Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linux (MALL stutter)")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index de71b6c21590..82ceb0a8ba29 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1816,6 +1816,11 @@ static int dm_suspend(void *handle)
 
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
+
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		dc_allow_idle_optimizations(adev->dm.dc, false);
+#endif
+
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
 
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
@@ -5556,6 +5561,10 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
 		return -EBUSY;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (amdgpu_in_reset(adev))
+		return 0;
+
 	mutex_lock(&dm->dc_lock);
 
 	if (enable)
@@ -5572,6 +5581,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 
 	mutex_unlock(&dm->dc_lock);
 
+#endif
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
