Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88CBC433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Oct 2022 04:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832EC10E050;
	Sun, 23 Oct 2022 04:03:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD39F10E050
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Oct 2022 04:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTbw1IehwXwesHNRTvqOdxI54jem+jBnNqE9aJRHLS9UhJYFns1xo9zwsq1L3FChi2mYWwQkrs21Um3XfcrrpVFTDtRepDBdHPX7LkT2b/y8tZdO79Q4gxeohYR/d1Wp3vIKj9xFlBpFsgu/jRNL3hZiw4FAfs2K01Q4hl9TrlxGyc7adylakJQnDi9sU6gJeijwBRGoW1S7wmpOAw2xqFkb+OjEWl8+3D5fY5T8SZ6WBRkbKUFr4GdVzXDpiFQ9wquFSO3sVxnqqxaUDFZVufzwT8mdV/7WNs+Ak77o93NQv9XWMHNteb7HP58uD+e/IfU/l46eYIvbATMbPCAXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoHb9XJxA/Y46hLoJ/dV4sJuL7oABxujf9g7Vrk2dz0=;
 b=a18AZhpnV1VxlF/B5I8BHX15Yy9mIFiZtDtZajeb4dHyDzWmkoX6zUPwhM3LO3HmXtSws4j/vWToVEOqOrnEX+ltegq2BovuTicwgEChG16K72QhrVag+UhOxgM9Gn0xkJmAao04frAMlgusaCKcD362CTT0uD2gLlu2oWk0Wkw2lQ0x7sZENo4+ByrGXH1qhu6jav1D0DfsfbC0t5JmovDhO7pf1fl/gij5n5ElFjWbjT5HqKbJdrbMUvMu9pmdply5vT/CaxZYcrqG6wGruHJj2ot1104fsabn84Nm+2FGOoSmYN3XWn0TvqyhIFtyJY+B78v1rCFnycWque16sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoHb9XJxA/Y46hLoJ/dV4sJuL7oABxujf9g7Vrk2dz0=;
 b=oXXOcgYiTNtTIJhlD84D6XqmZkwThsE74VTG9W2Ml2n34iPYwiRXZkeMAVRGIoABFdb1Y8/mYOOJMB2rk/c4tDm8z/DtO8C0l4iKN4s1XDTgfY2UtokJuEAhsp4ke1dANLbEw1snAvtZggK755HVr3ryHSiYZepVlYDE8aGdekc=
Received: from MW4PR02CA0029.namprd02.prod.outlook.com (2603:10b6:303:16d::34)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Sun, 23 Oct
 2022 04:03:10 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::f7) by MW4PR02CA0029.outlook.office365.com
 (2603:10b6:303:16d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Sun, 23 Oct 2022 04:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Sun, 23 Oct 2022 04:03:10 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 22 Oct
 2022 23:03:07 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set fb_modifiers_not_supported in vkms
Date: Sun, 23 Oct 2022 12:02:46 +0800
Message-ID: <20221023040246.2491869-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 5214018b-3531-4334-00e9-08dab4ab7fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFjpU8D/yy0IHfI6oevCklFNlvqmSt1FsGN2hbYt3MsUXVsY+12a7iOeBbPwG1T6MwtAMROlJYslb9wa6x3v3+qi9yoHDhSPRYq9wtsH4oJKAeOFoE78yIF21JdXVRspTlii3BD6Nr0vWambLUUvicejSbf6XnTPX98xUCuvmwM/3B49P2QEkLi+XUFSHIHeIqp3ZtaCeAb7H/5Nwe2cVYHwe4aIE4QVKx/b+UEHWu0uQkLCx92SUiqeiamzk12DlDrQERKVFkfxkg2RywdSguCIao0Mwe17lqI7d25DnRQ3gOxcoVqFksKKNX+2AzBLhE7qEly7rRVX/IWhS7r8K1mIIrvqQJBhT8WDEAL+4lBRH40i5nzFKaTBBhOOWaTzqUw0k0IN2gJMLGMpjMl+AY4pZEk/Taz76cAZX9GtSnskU3s3cn2EEO/OCNkqmG03R95Au7qMhUfjGWcxq1j41OiW0kAGfqD8u4EWQ6yccUAAyDYtJNgY5thWir1M8XDQLwH/BFChZ+lPoRjUThcnsU3ABaRS6ehj01wZxrhK8Fq3VFRZtC9VbYjHyHtnPSlUubp9cSQuRzJ5RNmeJEPusfBl9LFKyBpEXb7ySkt38ITUpUDpLg7tJry5lhcHLvD19uWYlIX53V/oDzhFrC409qd91ScpMPhpZ7REMpAqRLB3+SmVo3Nie5OfTQUijq4+i1eOyx/vcOjmGdq/6QmaxJtZfi9imw29mNfoZ5pGrNJkjH83AWOFRQvZ747U/ZhkQYH3/2ZqJshHAr2O8SBJDOjIJv7uwIDL27qK17zWwfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(6666004)(70206006)(4326008)(36756003)(47076005)(8676002)(336012)(82740400003)(2616005)(5660300002)(7696005)(2906002)(41300700001)(1076003)(186003)(16526019)(36860700001)(8936002)(426003)(26005)(86362001)(40480700001)(82310400005)(70586007)(356005)(40460700003)(83380400001)(81166007)(6916009)(54906003)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 04:03:10.2815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5214018b-3531-4334-00e9-08dab4ab7fe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Harry.Wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch to fix the gdm3 start failure with virual display:

/usr/libexec/gdm-x-session[1711]: (II) AMDGPU(0): Setting screen physical size to 270 x 203
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to make import prime FD as pixmap: 22
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Invalid argument
/usr/libexec/gdm-x-session[1711]: (WW) AMDGPU(0): Failed to set mode on CRTC 0
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to enable any CRTC
gnome-shell[1840]: Running GNOME Shell (using mutter 42.2) as a X11 window and compositing manager
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Invalid argument

vkms doesn't have modifiers support, set fb_modifiers_not_supported
to bring the gdm back.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 576849e95296..2bb346bf0d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -399,6 +399,8 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 	if (!plane)
 		return ERR_PTR(-ENOMEM);
 
+	dev->mode_config.fb_modifiers_not_supported = true;
+
 	ret = drm_universal_plane_init(dev, plane, 1 << index,
 				       &amdgpu_vkms_plane_funcs,
 				       amdgpu_vkms_formats,
-- 
2.37.3

