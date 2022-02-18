Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C484C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 14:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2750310E4C6;
	Fri, 18 Feb 2022 14:51:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3692910E4C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 14:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjkjBlr+GbXP+0l7ZO6oSzbo0lpePlAqt5cw9GqeR5SpxV/nUEoqYFqOBjWtRd451K4uSxFf9FC5zbG6WLAyJwKdbFU1UgmV2YUqw/EoMXvgEpbbDS37KtgVqUNTJww1/zEizCLgzBPtCE0yhQpQE3hAtdGKTUe8rI/JXlY3j+sYlFMtd/3i7661ie9igoD0vEKAHh92LHQDunLNakMHbi9sH9XI4PisY8g7VP/njt/i/+ndNbXeJnKi5Zr4OWdCPZ6ytsB2JH//tLPKTcLKTWLlu7Qz7hbx3j2vB7u9O+xoFoGzEe8y43iFgP9eTNWujvPt3yldOfnAkfJEqW0siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFNUo8BNVS4GuPw+kg17zVA399onPB9zpETBC66Y3t8=;
 b=VhM1l9YSzqC3n9ouUPZyyoQPtQXtSxLgR4Xae7pfir7rPxpAjV3t7f+m66hiBfqrT7aBrQ3gQlyRW6h7iS3OOA/iXNzXB/zFzmz2u45TThoHfc6xUGX/Oht5a86W7uv+E5ukDzrwE0Mj02UVQE8GXYHp2+MTNTBVoDIBtyMh/lQnEQPim6uO/AlnJkK7hz/Fv6RLWXdwPmJtgdirf0QAXY7s5eP6Y48/T3aBARF/8sr5VBGWSHZ0v3q8sV+Q9QTZX/roTpJpVOxgoDO4t9wciV3uyj3xCtEQymwIBDR57i7q+3FH5SSLLG8Fp9/tP0joF7X8YFW0zxAlJKpFQKUVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFNUo8BNVS4GuPw+kg17zVA399onPB9zpETBC66Y3t8=;
 b=BF7Hf54FFKZ3K5+LkrW/N3ulZeH3OkmcWPCP87ktXaYnWgQPJsyVVv0KaUnIPsf6BYQnYe5tjp46Sw9aQp7IJMkZj/bKhTCI2/vV0hTWYbQlc/H7+rYrCEEd3v2b2orF+DjI3U0nfTsXwmZ5DgE912MYeNYKc2SosITt6rt7gig=
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by DM6PR12MB3644.namprd12.prod.outlook.com (2603:10b6:5:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 14:51:23 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::ac) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 14:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 14:51:23 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 18 Feb 2022 08:51:20 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <Yuliang.Shi@amd.com>, <flora.cui@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in virtual display
 case (v2)
Date: Fri, 18 Feb 2022 22:51:03 +0800
Message-ID: <20220218145103.7593-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78d00a00-48d3-465f-0c2e-08d9f2ee21e4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3644:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3644862E4D0FD6728D933F47F1379@DM6PR12MB3644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86ZL/m1Rq1dCFEqEHz2yk0eig+C82xZPQX3N6ZqwfpwS0CB6hG2WwHbA3fF893tA8wntQ/dpe+ebQMPJ75WzDP5m4/1pLeGpCSw0CfhsGBWDUbz5QPeg782nP/hBhb1cv6SUC4NeLeyMhhwNkCGUgEI1ja1lhc6z56bU0P5qR3zwnrG6liN5BGeSwu2LD0PsE5guVr90klKRAFsYK3XJS8Dn0EoAj0xmaSkk7a6PIhCr3WX/sCpTuYp9Vi6bBnr+rFmsTgWFII3xe4K3qI+uIKJRx5Mcisfm1XmAGRx20RGk1jnkV/vKzHSrCqqw3NlW6fNlYFUpYuf4wj1H9tQQC5iP9jzEpRbSZTVPbGZLusq45+QM24HNtYR5imIlUDhMmdPGvcz7hVDw47pyunKEsUBK3YPdlWvrtvMIY6y1igOAvo1FDHuHBxEo2DytdUF/rnd31PXq7qlb3dqoT+uCKjHLmD4Q+4+2p6RpzMgHEK2fQRiiGLpQ3PYinDeamlak0WQbkMYM8jPHnqg99B4t6spuJrJKiJQx+DH+oZtEpYKw3zFpw3HrMqJjwrnpSeINaeb0o15+8HrGe7wHOlyaiFT2DF4jIpXOraPYM32TxEJSyF4GHB5U2Zso8MMfxfuoLT1eR+SPUy3zuHh82MkWdCkBkEqt43lAVkFWN1TMhh2nMRxKK9TgESsSpjC9d8S+lCwyxrpl950AqkZkt/TwvRnLQwoS+g/YAKqOzjuNHRU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(4326008)(70206006)(70586007)(8676002)(36756003)(44832011)(316002)(426003)(336012)(110136005)(83380400001)(6636002)(40460700003)(7696005)(16526019)(186003)(81166007)(5660300002)(356005)(26005)(1076003)(47076005)(508600001)(2906002)(86362001)(82310400004)(6666004)(36860700001)(8936002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 14:51:23.3273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d00a00-48d3-465f-0c2e-08d9f2ee21e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3644
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

vkms leverages common amdgpu framebuffer creation, and
also as it does not support FB modifier, there is no need
to check tiling flags when initing framebuffer when virtual
display is enabled.

This can fix below calltrace:

amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:1150 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]

v2: check adev->enable_virtual_display instead as vkms can be
	enabled in bare metal as well.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0d4ad1ee8348..1043e599b734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1150,7 +1150,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	if (!dev->mode_config.allow_fb_modifiers) {
+	if (!dev->mode_config.allow_fb_modifiers && !adev->enable_virtual_display) {
 		drm_WARN_ONCE(dev, adev->family >= AMDGPU_FAMILY_AI,
 			      "GFX9+ requires FB check based on format modifier\n");
 		ret = check_tiling_flags_gfx6(rfb);
-- 
2.17.1

