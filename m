Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B17BC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 15:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8FFDA71F;
	Tue,  9 Aug 2022 15:10:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012C4DA64E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 15:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKgddXbL9RVKj4C5J/qdMFdUmOMT1Ww6o+aXIHYyYN3FObcVYHp3GnC6sB0wG6iQoWdvsLp/Tx3Dx4vk28/OHVNryQaSx9d6ZWKp2Bh01N5dUfhDVJ/zCdUJo6cEyG3iJLkAdpTS8dcwhmO/++CrHfbOAEQ9AdpWfmXe5x6u4p9ylGi0jxwZhYGcOF30eLqBtwQY4wxtYLel1eVLfsZsMkx6tCN5L9mzOulgT+R2WqLNs9J+Qz/8lCtm2rpwH62wPSxcxOJ8MYfqnnOvBU3Zy0EAVBN+y6qkGrMORcMVucwLPEgLLo5JjeXmuX+oSVdQr3UBgyvOh8aJmjQ95q+T+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NJnQ/OKGW0J59PUrlV+I0SwLJ/FEa8QC3Qons50g6Q=;
 b=oc85oPKLMK4enu5lZDuodZWK/nNwtrZ/kdH/i82rP5DwEbdgEKXVM6TtcnARSwY4S/Hj2Z8EEc9kJnrKTt2ZKFlS/rbsDMmYkxrdQRPpgJH7qZT/NQ3V04no71A6WbTCCaYaEosy2+Rxw+GlfA6k+9v7zXifBN/zgOeSeO6oeJWsI4UcwTxMDntPNzwISDNbGCu7+S8sLfA7wu/SeMG0HizpAxze+0Oz+C/ebQydfhRrqit/lqUPT3lyOOOWHEI5JAfxWyZlZf/snCp+ZVBCh5GFLWAuwnVp26w6bGmLF6PW08FVj0PpXSluMxkVQk4ts1fIm3eVdO8JYww9M+v8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NJnQ/OKGW0J59PUrlV+I0SwLJ/FEa8QC3Qons50g6Q=;
 b=dyB2oYhSkuScYVWFY55+vKQIilui2Y+dNADwDGG9LVNKAGDQx15rfJ2Itgu++P3lSN1//4VUXfRE7ImNr2E27KP7o4nSeRkxVsUqIkfau1C1SRp21cXZo//Id3IoiwPH/ar7YuZjm4NFbzcqrZEY7pw2kI6hhSaM9e/1Oe3wM/E=
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by BN8PR12MB3298.namprd12.prod.outlook.com (2603:10b6:408:69::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 15:10:08 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::4f) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 15:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:10:08 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 10:10:06 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] Revert "drm/amdgpu: drop amdgpu_display_gem_fb_init()"
Date: Tue, 9 Aug 2022 10:10:07 -0500
Message-ID: <20220809151008.20376-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809151008.20376-1-mario.limonciello@amd.com>
References: <20220809151008.20376-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a8f9818-75b9-4422-5582-08da7a193f50
X-MS-TrafficTypeDiagnostic: BN8PR12MB3298:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deiwX17VNDyQ2hUqo5Y4T+kzzomQhm1PA8wIqLQS2Uu+O4aKD+Y0U5UVVX68VCmXrh7WfXt4xthAohuWfX9sy0iI/jWWCNCvl94XtgKE24UFu2bHljeW1BVSEpQuvDd4KZlc1WooB+PlWjCgfr5zwMWWxEXfO2Zp7duz6WD16ITsKYsNy798oXvs7aF66b44ssBW5vC5oSZWYDWZApnzaSgm40JAmDkbimf50m8e9epqe7pDk6jgYng7+0Bh+fV4iWK40FJQlgbmM4ss5HRywIqvelvAer6vV1nEPfH9Qk0ScTFDNJlXoCkcp0YK+kyCsNWXiRY2MyFMf4oZlf14E6B08HYWweAZnkWTnzyltwod55BzyqCE8UOWJWA4xmpQSz5ThfMdiWHYG+u2o/wx6XqPfpQpbLfpqsPF+KGVGaaOmzAPBVcXshcEQw0BDwn/CuizvvUD1b2YOA1Hp60RPGnckmIWnilvjFzRDEFl26B7WJkSjwPRkZZglGI0rgv+JZG5CnP1zHEabOUbBalKmJPFy2l2Xghg0DpN1tj1VPHXaAH6ABx3DddWdJf8uF0JSF6R0Ei/V/bl0sGNakko6aH0sMGCCDMPD6nXbXh8/eGiscXC87I86DxmAP0nJzxKHFCrqbquQkBMLL5N4PbNbXPNflrLpz9nuZ949DcYZxRY+V+e5e7imbsHKOyDnhgse2BCYAvZl+7f2uIPOTaRepofXV2ABJdPPvjRaIDWj89PFFNv1epBz2QRG9dSxMY5kNiRJEFeM3uc06qFQMHmM/Zebxoh+ZYbGL3x+bOCE6lgE3nU7kPjshllt94J1OXuPlbnVAjPjTXmecDe/E8dlLFmtAsiXuxktuCw2LnjJgYUkSbnub1EJ0nnlfBhHAar
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(966005)(82740400003)(41300700001)(86362001)(26005)(478600001)(36756003)(81166007)(356005)(83380400001)(16526019)(426003)(336012)(186003)(47076005)(1076003)(2616005)(7696005)(8936002)(40480700001)(70586007)(70206006)(82310400005)(8676002)(40460700003)(5660300002)(54906003)(6916009)(4326008)(316002)(36860700001)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:10:08.0253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8f9818-75b9-4422-5582-08da7a193f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3298
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
Cc: Alexander.Deucher@amd.com, h.judt@gmx.at, Renjith.Pananchikkal@amd.com,
 Evan.Quan@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 60da2f7440f22dba48944602c2a0373068f13880.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216119
Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 25 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 97fff4727724..92281e57f3ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1075,6 +1075,31 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
 	return r;
 }
 
+int amdgpu_display_gem_fb_init(struct drm_device *dev,
+			       struct amdgpu_framebuffer *rfb,
+			       const struct drm_mode_fb_cmd2 *mode_cmd,
+			       struct drm_gem_object *obj)
+{
+	int ret;
+
+	rfb->base.obj[0] = obj;
+	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
+
+	ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
+	if (ret)
+		goto err;
+
+	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	drm_dbg_kms(dev, "Failed to init gem fb: %d\n", ret);
+	rfb->base.obj[0] = NULL;
+	return ret;
+}
+
 static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
 						 struct amdgpu_framebuffer *rfb,
 						 struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index dbe2904e015b..fb120abeec96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -588,6 +588,11 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 			int *hpos, ktime_t *stime, ktime_t *etime,
 			const struct drm_display_mode *mode);
 
+int amdgpu_display_gem_fb_init(struct drm_device *dev,
+			       struct amdgpu_framebuffer *rfb,
+			       const struct drm_mode_fb_cmd2 *mode_cmd,
+			       struct drm_gem_object *obj);
+
 int amdgpufb_remove(struct drm_device *dev, struct drm_framebuffer *fb);
 
 void amdgpu_enc_destroy(struct drm_encoder *encoder);
-- 
2.34.1

