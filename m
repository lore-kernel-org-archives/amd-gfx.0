Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A42AC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE228206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i5EvrRTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE228206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E546EA0D;
	Fri, 24 Jul 2020 21:07:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53FF6EA0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ/v16Iz+FIkOlPXbwJ6F939/As70+iCCmYXBajHA1qYQSJoOXdt/MnKATUSf1xMxtMVgynMr2IfVuI6lXuHozy2nKe7uK30XaDzfipMtcyvRbtBbLGkozLfnS7GZKa/lmV6Rb1zVNCM7PpGZ14QK+Tzu1J/Vyds5NVV8xEom/TN4kkBXcjh4jgOJSg1CEo1FtTU9AUE+F+29TKsiiF+wbwiIB9YWvzrqNFpj6IpYjjalA58tD5F6wM7bq1fWklgyHMATfmEOlNguP6DHS962JXcic9T9r4k6ZL7IOaOk60Y0k9MeRpReOskjyHSUhK8Zxn5IQofNjhdpknohNKi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltv1zLQ5zGl00n8uxMk4YFPc94EU4v6uvUvy/ZCcsB0=;
 b=IANbDo8r4vQo2NK5wKm8wiaJYz0k9Amyl1NGLesdMo1VYux5JCjKpPsVR5KU58BDvDl9U9v/jZ5SwnmMQFkITpLRmulj5C10ViPB1qh2S5q4UR/SIsjmKHHiXITv0Y/V1Ca8nqS4KJWOekaZxihg3nyxtqzSL84MqiREyys4hD1HLdZpsb5v2esx3iNn79uNJcSb/5fYxRxMDtMDD1PVSCWeJ26jSLxKo1yPzRY8Xv0uzIcqti8TEgWiyprhIrrXy88nKtZ9lTINeBpMPC1Ty8bqxparXFifieBbPkQywrQsS+HwuM/FiHtXEvBYM22L6owdnTTkSegiQu65GRzZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltv1zLQ5zGl00n8uxMk4YFPc94EU4v6uvUvy/ZCcsB0=;
 b=i5EvrRTbvkfC2+3rDeTWlPhbIorJ87jUrFXNwIGGNvA5XkFeFOzcLB5bFjycH9bCMIYE9pl8gTXBDiYw19tILw1m9oK4Cp8s9YKM5BgBvTm6ByJrzi8lhWUkBTWNBUhZdrt6X67FFTWSJmUAA5G+SUUx/F3GGpj+nVgNwPJVKao=
Received: from MWHPR14CA0065.namprd14.prod.outlook.com (2603:10b6:300:81::27)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21; Fri, 24 Jul 2020 21:07:22 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::3d) by MWHPR14CA0065.outlook.office365.com
 (2603:10b6:300:81::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Fri, 24 Jul 2020 21:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:07:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:21 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:21 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:07:15 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/15] drm/amd/display: Fix dmesg warning from setting abm
 level
Date: Fri, 24 Jul 2020 17:06:09 -0400
Message-ID: <20200724210618.2709738-7-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c8c086-0e81-4bc3-9f07-08d830158f2c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-Microsoft-Antispam-PRVS: <DM5PR12MB151446F86A377B4E57576420E5770@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kn9eVQfL5VwOayVlkTNWgc8Gp3j9IHknOfycTHqFUAYg0cgqNZfZN32VpbhFEL2jnHhXEvVRGP+cFgbMT7rDTtGvqYK2VW3qard8e327rqdiYp0a1Cy1s4mr2c1Mslqh31Ba8njOmxEVmtZHDm5Y253UbpWYkjlqBkrBQXIXtY02O7qseU3aMwDQ9f53sM244tMS6heW6ES+/I6scPxZgviVjYnscMMz2/qgIwYVMQGckkn3H/nmIopPTv9m7YFKCjn+iN3182mdnHz3ffVxIS0M0TAblEfDrzUEY7uQ5CRGX6wWG1WzGhdpTGKBUf0dryfqOjTjW6DESKug7TdHuLSGm/oItv30HU2mJhTOG9tEIoTg0Csco81rr0B8L5bMc3eIZOdpFMhF+OebVcTW4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966005)(70206006)(70586007)(2906002)(44832011)(1076003)(86362001)(82740400003)(8676002)(81166007)(4326008)(5660300002)(186003)(356005)(83380400001)(82310400002)(36756003)(26005)(6666004)(8936002)(47076004)(2616005)(54906003)(426003)(478600001)(6916009)(316002)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:07:22.5728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c8c086-0e81-4bc3-9f07-08d830158f2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Stable <stable@vger.kernel.org>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Setting abm level does not correctly update CRTC state. As a result
no surface update is added to dc stream state and triggers warning.

[How]
Correctly update CRTC state when setting abm level property.

CC: Stable <stable@vger.kernel.org>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2b5e70f68e57..b1bc03594e5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8625,6 +8625,29 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	if (ret)
 		goto fail;
 
+	/* Check connector changes */
+	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
+		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
+
+		/* Skip connectors that are disabled or part of modeset already. */
+		if (!old_con_state->crtc && !new_con_state->crtc)
+			continue;
+
+		if (!new_con_state->crtc)
+			continue;
+
+		new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
+		if (IS_ERR(new_crtc_state)) {
+			ret = PTR_ERR(new_crtc_state);
+			goto fail;
+		}
+
+		if (dm_old_con_state->abm_level !=
+		    dm_new_con_state->abm_level)
+			new_crtc_state->connectors_changed = true;
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (adev->asic_type >= CHIP_NAVI10) {
 		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
