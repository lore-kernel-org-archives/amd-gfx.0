Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA4AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 04:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE78361207
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 04:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE78361207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B106E02A;
	Fri,  5 Nov 2021 04:13:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBD86E02A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 04:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POhUQCgBFq6+Io39SXgVMhvPt3he4N16dN63Zx2yO1N/7tv4wZ0JU+ZmKI8vPbPE13QvOU8fUjnPuuPaqdR3uf4yZ4cWSlx/8hpggi5N/ksyFR+wx2T5qAgTjDYYtCbCVbpA3YDACg7lxkG+umYpvfupXvymQS2aBWXJ4JJU8hT+uYN4PhDvIX1ZZeE/J/Up6VD5ITIFAbcJiONfIJ+gX0F4InCYQkjcVD7fCWiTIjtBfnjUXh3gaECS0JH/LvtN2rp6/LxJcgRDqAI3DGcPHQUgbe2V5Jhi+o6Q1IYTh8TbzAdFo6cvz3mc4pt+pe7g4BoleRzq3jzglF7IrfW4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf5PhCWUdp+2U8I2Y3ng/Knxm/Edil6QYa+HwXz095k=;
 b=a4RARoJr0IwZ60po6eiO+WW8IwRzLqsEe+0KJKZqWMkw4WA+/Fu41d8YgX9aWo8bwTNX0TunxSeUSFucPhJ90lZKy468XJqzztsbzP0g21t+XLHxr7DNDQ0wGiETGkV+lu/o7DeFCvnaFSJFej5NjtmT6M4YG7bOldn4TrhvWUXLF/gWnujAkFDyNwQzE8KcscvcjivkyUzVmtehHWWHkNweiLxlSSqqjevJVO5N6KpstUtLsjRBs3uiUqRp+02wkn/y5NCYgRJBaWiODrLY31viOfhe3SqCBOSZjJ+Y3hQ29fVoKKwMFd+tyzwybQJ43AY6YgOwZvFkjf+qKuDEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf5PhCWUdp+2U8I2Y3ng/Knxm/Edil6QYa+HwXz095k=;
 b=DbHGxlGYOqlHMxt2SY92Ku8X2KmSK0tQoewVMJ64whd1N1Z7s4npP8Ndpl+K8NJve24NATnAXFE+FgW67RIPX3TWlC27RMi29fQV/Rf55NC2EH16npQlBYhuuPEtn1//BVifTS9oyKcIPFVAHRqbr5JWXtk7SWhGaFEHnpQ1TcM=
Received: from DM5PR17CA0059.namprd17.prod.outlook.com (2603:10b6:3:13f::21)
 by MN2PR12MB3886.namprd12.prod.outlook.com (2603:10b6:208:16a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Fri, 5 Nov
 2021 04:13:17 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::94) by DM5PR17CA0059.outlook.office365.com
 (2603:10b6:3:13f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 04:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 04:13:16 +0000
Received: from sdc-lnx-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 23:13:15 -0500
From: Asher Song <Asher.Song@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: assign dpms for amdgpu_vkms_crtc_helper_funcs
Date: Fri, 5 Nov 2021 12:13:01 +0800
Message-ID: <20211105041301.3640212-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2da1b9a9-f50a-495d-745e-08d9a01297fb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3886:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3886175B08004095B93A287C8B8E9@MN2PR12MB3886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:378;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsMuyJUnKeAhv+10RZanrC54DenWLRFSWX9HajbmjkeJ2JieLRWsheOPjbsVexgPS7lYHWMQ6RnJUlrAh9zQC+VpbPqaaH78Lp9KVF904bvfV+bVJMI+g11U6Aw2CIH8tUmzBxfqRP7ed0/EeP1KPNBKX63cPkwQGBEipp8MSRnctXk9kEUDlOWO57/QG1xAvvNB21gwsIEjsexeJnt6Hh9gouQaCaG7y+Es/dhnOQHQhh0PPZaOcd556GqKhcbREee0AP3gUEm6ZR3KlTtANfnMhVaI5rPE7DjpRPxLzwD1h+hbZRY6SZl5OGSurFtq0UMiCRUQ6WJ6o7T85ggwi/bBeKIKk7JEi2vnNoK1t+XMzPdpk0eR11uOg1+3t+4aIA0Q5Q8xWT5/UbiX1iE4M1iQwqzNG9nNxxGOa3b6SqvbN/5JxSzWYBouUxRAxxBWgVLbnfIIA58NlxVSvVoeS6zqJZHhhGwKbKHGKe0VpNLIZGw+Z5V5rVwXHPUNP7WpolMXN1WlFF+sdXrgrRo3RqogO3VKtBacm0j7Wql3wYj/rgxDXi5IDqUTneqLz3891bv7j2Jcmz6ipsCFr1azfAuj2rJqg5rGpmC0M7DmFd4nQz7VqMoQSdekM7iRnssULJBTmeGDB3NVaK2gAEP81djyRZaShfI0KJzbWPV1Lk8Hhpwt1s3vDxztXd9KEUJ/2FkVt5g634AHDdHNk6YSn1fEv2SKsIY84oxm+iTPEZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(86362001)(426003)(36756003)(5660300002)(356005)(8936002)(47076005)(70586007)(336012)(6666004)(83380400001)(4326008)(26005)(508600001)(81166007)(1076003)(2906002)(6916009)(8676002)(186003)(7696005)(36860700001)(82310400003)(2616005)(16526019)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 04:13:16.8530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da1b9a9-f50a-495d-745e-08d9a01297fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
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
Cc: Asher Song <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid NULL pointer, assign dpms for amdgpu_vkms_crtc_helper_funcs.

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 26 +++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 50bdc39733aa..920b6bc1a9fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -155,8 +155,32 @@ static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 		crtc->state->event = NULL;
 	}
 }
-
+static void amdgpu_vkms_crtc_dpms(struct drm_crtc *crtc, int mode)
+{
+	struct drm_device *dev = crtc->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	unsigned type;
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		amdgpu_crtc->enabled = true;
+		/* Make sure VBLANK interrupts are still enabled */
+		type = amdgpu_display_crtc_idx_to_irq_type(adev,
+						amdgpu_crtc->crtc_id);
+		amdgpu_irq_update(adev, &adev->crtc_irq, type);
+		drm_crtc_vblank_on(crtc);
+		break;
+	case DRM_MODE_DPMS_STANDBY:
+	case DRM_MODE_DPMS_SUSPEND:
+	case DRM_MODE_DPMS_OFF:
+		drm_crtc_vblank_off(crtc);
+		amdgpu_crtc->enabled = false;
+		break;
+	}
+}
 static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs = {
+	.dpms = amdgpu_vkms_crtc_dpms,
 	.atomic_flush	= amdgpu_vkms_crtc_atomic_flush,
 	.atomic_enable	= amdgpu_vkms_crtc_atomic_enable,
 	.atomic_disable	= amdgpu_vkms_crtc_atomic_disable,
-- 
2.25.1

