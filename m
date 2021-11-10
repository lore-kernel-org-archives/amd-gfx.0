Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F00C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEFE61037
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDEFE61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AFDC6E5A1;
	Wed, 10 Nov 2021 15:27:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782516E5A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 15:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBP2811ooXfhTx1Mjsza0WOJXDTlO52ZYI0VXShK5gsXYvESSTlUjKYFo3PKX2lrCWviJaK5/4N1tBohBx6ybPgwtniOrSmRJp5oz2Miz3vZ0GsH76oxpLPlGsj/wUor0F47YTYFu2tLDXgi9S2o96FZ9pgHw815A30fMYbw189wXoo4JXewb1IOcLgDhBaYGop+bbeQz2p64NdemPYgREsf+QH/virsybD5N6tsHqocS+buj0yfk/DKTGtBYFS9zYRQRnLB/D6SN/jiOTC/5xa/qi4ZNTWDet2HSNcnxSTb2ZZD7kygfYRU+M3ns7qIjXmgYdFqFXoA+ZUIlthIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5IKgkR/q6PKt1aV67zSQJ7IyZw0RmHXpPEIxsmvOcU=;
 b=ABCG/9UaaSFFETvX/A20ZsGC8jMShSwEZ5HDk+LOiz2QLVCSl41yUN1zwnRetI1+ONfROTmig9mRHAc/+xYM+AtPKUplRyodaVQfWQFB+T7g2hvbQtiYTUufGgdlCs3GMvWKEg7l0rwckRysUa4Lgl19cCdI4rAOZQKCjnFDl/PZMJQ80SLmF7COIs4BRMRrAzNUgZkJwhe+9zbgdXAFAq9YWEXR0+4bJzf0yGIMgVudCR4s6dVvJ/xvxcI/S2swtbhpg7BvAe3Jp7q0dJaAaaWlOaaQsjTgkHnsJ6+uF3I0FNZt5BezQfWpRbeaFziBN33PlDkblFJ6x7+RlzULOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5IKgkR/q6PKt1aV67zSQJ7IyZw0RmHXpPEIxsmvOcU=;
 b=quD16dRQ64LthvjMGEe3yxH6S51uoTuhyUVpw8EGGFk6NFemiTo+W+GCdbr20a0PcK3VZtbMKJ7XotMnXZort6My1Boj+Dala1ZuxmN4ECMzwUAcJWnhEHyfAaPkzHoP073qr5NRdeFJeBM0jVTpM2uOBmNtEFrjqvjN+BDhf4o=
Received: from DM5PR13CA0046.namprd13.prod.outlook.com (2603:10b6:3:7b::32) by
 DM6PR12MB4825.namprd12.prod.outlook.com (2603:10b6:5:1d4::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16; Wed, 10 Nov 2021 15:27:11 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::e3) by DM5PR13CA0046.outlook.office365.com
 (2603:10b6:3:7b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.6 via Frontend
 Transport; Wed, 10 Nov 2021 15:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 15:27:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 09:27:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: set vblank_disable_immediate for DC
Date: Wed, 10 Nov 2021 10:26:52 -0500
Message-ID: <20211110152652.2245569-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62f001dc-5798-4dd6-f316-08d9a45e8f60
X-MS-TrafficTypeDiagnostic: DM6PR12MB4825:
X-Microsoft-Antispam-PRVS: <DM6PR12MB48254E03E04FD6372D30B482F7939@DM6PR12MB4825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iij2Yvr5Gy2tcblIlKQT+9sRa+kwVh03BNWemWXHzntVfgLlYaNDs6Xc8HvGemuQcdw5SsJQrM1OW6vVVeL4XSjtwGKtz1fI+Z3kEi9zDyTBqBorja7ps/8F8ehHcVizLWH08WlqIie/ASiF1iUcDTlXyZxHb+3GA5ppbsFJsuMagzM3CH2nJ+fPB75uEOK9EAAKaP5+8tAtk5F0/0P0hKZ0jzWUZbyq7RO+OVxVBTS9VxrdVr0UokRXPSoMBo0uvx3NaJw3TceyfO/UdBN5s+Q+wiTFGTO52jaGXqhoJoEvyk4Qb+pe0wXReRasEuvyjoMgD823ciOF0Nu1Wq/hXwpJ7pTpX6dJuizObt3XB0wAZTcKPNDitqMwYej151ES2DzcHe6317UW8S1Yb5C8VqEgYzMk4WSlYgnc1g6hvibqvCf2C8tdCdkxOpFhJDM/kzaGAvz7qfUIFgFGsNdMo0gfsAcY+0K3KwwlrbD78RMokB/hUwF+jva+qNy2IiJqxA/PXh60b/uOkDUzUNHvqkAuEfj+ADqoYP4yKzBIetH1eCsnVhL4Vdsl3s0l+3LH1a/+QR+uEPoyDUSSsNUkMfwPUUn/M2PuRzEtz60dXA4bkLwbRsCjZGU0uQEV7U6tveJYJWqcuGbYJ7RcjKjXYAYUdvYwiWSGTcJb6dP+ppu6/zyapqZc0bBlV7z80xPCS2/vvlABS5QwYtoYFDffDrKqRtGs0hex8RZvIF/NUMfaEx9nzWsdp481gy83xBdubWl+An2oJv50Rzk0xs6hnpcsOAvme1Y+3MR4pYxnjfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(1076003)(83380400001)(6916009)(316002)(16526019)(2616005)(508600001)(336012)(186003)(6666004)(7696005)(70586007)(26005)(70206006)(82310400003)(4326008)(356005)(2906002)(5660300002)(47076005)(36860700001)(36756003)(86362001)(81166007)(426003)(966005)(8676002)(14773001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 15:27:08.7963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f001dc-5798-4dd6-f316-08d9a45e8f60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4825
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable vblanks immediately to save power.  I think this was
missed when we merged DC support.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1781
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           | 1 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index cc2e0c9cfe0a..4f3c62adccbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -333,7 +333,6 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	if (!amdgpu_device_has_dc_support(adev)) {
 		if (!adev->enable_virtual_display)
 			/* Disable vblank IRQs aggressively for power-saving */
-			/* XXX: can this be enabled for DC? */
 			adev_to_drm(adev)->vblank_disable_immediate = true;
 
 		r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1371432c8f11..652c973e6daa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1590,6 +1590,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.cursor_width = adev->dm.dc->caps.max_cursor_size;
 	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
 
+	/* Disable vblank IRQs aggressively for power-saving */
+	adev_to_drm(adev)->vblank_disable_immediate = true;
+
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
 		DRM_ERROR(
 		"amdgpu: failed to initialize sw for display support.\n");
-- 
2.31.1

