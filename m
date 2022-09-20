Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D3DC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 13:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C6EB10E150;
	Tue, 20 Sep 2022 13:08:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC63710E150
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 13:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSufl0QrPp8IiITo4WdwwXzXSZErRCt823YNHoQimWkZT++wC6vZhW1mLU69DmfFvHxgLSNfNZJXEA+bdjEfdSNAac+7g0n020BvjawpZttRH9GWmwol56s9Zvr0imByOnfWQgokvGUGFT3gO5RhwvgQw7gM+Ja8mCDydwFnpDa6QubOGekYi5Q5JEL8O1vHoUtc2keOTJvxaLs1Jieo8GblOQmEetacFdZJq6RURO8MDGjIxgbDJHMdXzIXk3iNU0enFLrWJ8+DRSOAJE+PUisJpAX40Qmu/zXK/me8FtbhA11CHF/3Tg43NlLglMKNOfwcnL7Rcd/Mb7B/Y/7wMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVeUyItYxcph+88Cs+UjB7cWtzCvFr9nm18fJubsvuk=;
 b=aNZttXrsZCude50WEL1DpGYfTVnmhntzH8S5QarUbkKkwnvaNgtz4O+TdNE02Lx59Cc6xwb1yskyLB/26AWcZPDd/i7UuDsaHhXC6OnZRx5N0/G7HPp+OeIVb47aYyCLf2lKgcsxLmaW+IPw4tMI3BPiOFUag+zKhYRxGxwldnrnJwSXSbIfaYXOOW42CQ2aMsTGfVD+y4nkwEATVCPn/GyLdmCRon+aZWsOYbLP1ttOLN2rWtisCGdHnBx6iU0QnjtP8QeZzWeKClF0BBDTXjM0DkxuFa0pkDG4wZJnvAlJrg9PdpoEL75wveEUVmaJ035RFYWMTahWZGS2TdHOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVeUyItYxcph+88Cs+UjB7cWtzCvFr9nm18fJubsvuk=;
 b=02ATd3hLqlfSXPn66BHQBA03XZBrLLoIlSXo3p8+wVbsnNClmocweMpF2z9BLlzxmtR+Q/ggzA2N1vttyELtjM1Id8E0gCxS3gnDtlrF18XAx7P5o/9hYX7UZmpR0FL5XhToLJrMttReMSq0Acszt75K1kxzxgj+bSxHDtl2yUc=
Received: from BN9PR03CA0847.namprd03.prod.outlook.com (2603:10b6:408:13d::12)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 13:08:51 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::ea) by BN9PR03CA0847.outlook.office365.com
 (2603:10b6:408:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 13:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 13:08:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 08:08:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: don't register a dirty callback for non-atomic
Date: Tue, 20 Sep 2022 09:08:32 -0400
Message-ID: <20220920130832.2214101-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e839f7-2c76-4fda-7f70-08da9b094349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHOqiZf+Q7xsXKaVRzC4bAthW8NJclhdsOm9K1NvBnL90ElyypSiIm6gFpwIhk20zg2VtsAE3/3saCUmpgNjmrH6yocfeB4B724AdWd9FUFyE5TeNxyz9H5vs/ZQ+VvqXpKIM/TgiC+AJSUENo0ipZVIB6JjcWnpMJKOZ9qliENYMsxUu8w6+pSDwyNaWsqDKLm31Hkmqmk7uYWssklfykFA3Ddm5/s/DgzyKUspihGHFiya0KXQwYPFrJPVynCrnymvghW5rZdyrugBY/F/KBtsxv6iwMwIjQbV1HzJoFiVWXaQis87b5uzMmXUfY2GIV5++EfWWBJOb4/s+oiwaLFsXQ5WfOLYT/lJYBpNT5hYYa7lAWx4znOpVCWKAQV4IKzyYvEsvoET9meOxn6MxzQuwSoX7Y1zDRqJgQO+oAnCIJHaS6T7c10s8fIbAZ7prkvUoSLTguy7S7S2dNeJzF4LnOba9nEVOVqYB+ol/fO+/KpLUn5hdVv7As4bZ6j2FXaoFBHRpm4Iak59vn9KRUzvfOJ9yZLQR9L6NZkqMu2aBVbfS+Wgb+VzdsL34C7Aots/jnMDYo3g1fi08Ag6CH6jLWfCvQXfQF/Cx9r+/Y/RVqaeM65OBWGuaQ/XvS56c4eAJLy0a3XRV7SqJlPbIf+xXUneHz/qyKbgIL3YrXj5/nWwAwELtCDtIRcW8f0KaUpoKWZktuKMqRhrIezzYO4lEsAy+7QsD3sYzaFmB1IhxWFhjz53N1IfSggTGSSairdoVYI30NLB3LoZ6bFsXCxIGGflGVq3OfOWbwvMz3zB+Ycaa157AZSaxRT49lTzTevE6PlenU6ljlMuvHqz0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(26005)(81166007)(82740400003)(70586007)(40480700001)(6666004)(36860700001)(8676002)(4326008)(2906002)(2616005)(54906003)(41300700001)(356005)(7696005)(186003)(16526019)(47076005)(70206006)(5660300002)(36756003)(478600001)(86362001)(8936002)(316002)(6916009)(83380400001)(1076003)(40460700003)(426003)(336012)(14143004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 13:08:51.1466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e839f7-2c76-4fda-7f70-08da9b094349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Arthur Marsh <arthur.marsh@internode.on.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some asics still support non-atomic code paths.

Fixes: 66f99628eb2440 ("drm/amdgpu: use dirty framebuffer helper")
Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index dc5ef5fe6660..01618cd09acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -39,6 +39,7 @@
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
@@ -532,6 +533,11 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
 	.destroy = drm_gem_fb_destroy,
 	.create_handle = drm_gem_fb_create_handle,
+};
+
+static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
+	.destroy = drm_gem_fb_destroy,
+	.create_handle = drm_gem_fb_create_handle,
 	.dirty = drm_atomic_helper_dirtyfb,
 };
 
@@ -1137,7 +1143,10 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
 	if (ret)
 		goto err;
 
-	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
+	if (drm_drv_uses_atomic_modeset(dev))
+		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs_atomic);
+	else
+		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
 	if (ret)
 		goto err;
 
-- 
2.37.3

