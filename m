Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B59C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 08:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BC110E243;
	Mon, 30 Oct 2023 08:40:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B8910E243
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 08:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWrKiFJJr+uNBzd7MGQ19GslhzgaZi+rvAaKLmQ9Xa7EYp24ycEAeA9gY61Vcol9Gcm2XMhzRq6XsqXHxHyb+vY6qa7z0aZbJQp8+x/NQkq/838DqtZdMNGNN7nnmpZ2TXpz3Yk0/QHkoLCTvEntnUI3bRUimdPYhbiOBsPonqp5Np3TRESUNygme6M6srRijT5wDdiGtujNKwApmTou6NBC1uGSw9aZ0c0CrFCh40WUN6uXsvTTbzbkrU1d5+iu+x8+WD1MXfVQrn7T+7WfwYZAs3bsHAy0KZlb56c/u4+aUIKAPdfqK7owErrdomX1hS1qBezMqKho/Df46iorlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIIDsAB6HBJoinx0GgRcLv4O0w9kzdOGzoQj3Xp21kQ=;
 b=GIq7EH2DWppqjTauZLB8BrMI5P7jCyONZQAxAHz2dAEjJD+VQCWQeSoZaqD5yTu/6VQvB21RuEi6ugVZxVOOXXkx2ScgiWD+4w3xui5Q4tI1qqDst0AY/0rQfSWR5Nl2i3UXZpkbbzVWr2KtoF7BYZtQpzzESGgUGtZRHJqjp8YTDUC0zfQ7LdF6yUhefS8F/u5kY5uefrlPqzmqOjuiWHQQR7APvqZ5tjYcEuL2xPZWhaYA84wiLVeGCdX9c64HVmvN5v/HVwd33k99jEpcl3ROkZF4i98n1x5czQDXzdz0mkRM4uQWsNPjF0NEhXJVrJJzCwca8LsgcF+O1dRo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIIDsAB6HBJoinx0GgRcLv4O0w9kzdOGzoQj3Xp21kQ=;
 b=Vxyz7oMhh/HBs/aZE81vtxUI0vpbIv1q5YXmHvRmwLx+wpxXmyQfY5V9LLNijEugiTJYviNT8fY/azBEPynltBuUQhCkRegeOc03hglgXeolZVwmHhOmJbRsbFoOAFHuLyHBXXNg+4z5olBVig9iSIFo0Sqd6tMWQtJm5LCaN6c=
Received: from CH2PR19CA0012.namprd19.prod.outlook.com (2603:10b6:610:4d::22)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 08:40:03 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::98) by CH2PR19CA0012.outlook.office365.com
 (2603:10b6:610:4d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 08:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 08:40:02 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 03:39:59 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: move kfd_resume before the ip late init
Date: Mon, 30 Oct 2023 16:36:58 +0800
Message-ID: <20231030083658.537469-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030083658.537469-1-Tim.Huang@amd.com>
References: <20231030083658.537469-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: f1987647-2e1c-4e31-ae28-08dbd923cf46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thJyDjSq4QME+9nwPMbCEj6zBMFPCfyPxuswzezTgQmJBm28i0dnI21Kwvgk7tFWYc5mo0Ha7rUCXVRdDZuMY68w3HeDSOXVEZOXQDoMIgfCZKWgEal1DlaxT5pF+TFMj610GANRMSqquqbOvKVq6oOKeZ/fVCg8UuIt7c0ogE1REYA1gGCxv61WRLSl8b9j7sMkv3yJr9nK897JLfgh203cipH2+bjqCpx0HD0tSf2oTXIH+zIro/FwvRbR3DgzxDm0LmaiOjeTTP7cLxSVW9V5NsJfzN6+/c5XNorYxeBH7JEXr8QUrfnRi8PCTOjU6y3uK5JsPhM6iTqlBCRbH3qFB+xMabL2KZ3+/elkyozNkGEBLlr4ZMYiXkzpflYgQ+oeUEMbNGn907lkHSajANp//W3E9Ofv5Kq3wU2CfIy1jRshdlsOH4yN5+tjfvck3ZaaEYCVv8X2/2lFCm0u8o8uYROMSuPeZf4eReZwZ6KsbVq6/M8NzYBuHb28RIYC8kO0vz5+7/FUn3pWeopS/Qj8zEbVADY/FeCnqG1UUyacI56rYQBdu8qdpB9ntiXDTkpxhlnde3juJlSOy6BMIt+7WD675lkbLJOX2J0TTYei65OxPupKpFZ9M4p3M0nBtiQjZQ1zBdxq6xOBjTFNp6u3bhQ4KPxQudiDIwLDyje+zdHjkdGRxyACzzwhpoCwb/wCFRXfih53rXV52qspbPE4xKq6JUNa6CGRi7XOZd+a/7Z/Qly9cR7TsxyPesQ1IHz5bE4iWdqkZSZV2omoOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(26005)(1076003)(2616005)(16526019)(478600001)(47076005)(7696005)(36860700001)(2906002)(83380400001)(426003)(336012)(5660300002)(70206006)(70586007)(8936002)(8676002)(4326008)(6916009)(54906003)(41300700001)(316002)(356005)(81166007)(82740400003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:40:02.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1987647-2e1c-4e31-ae28-08dbd923cf46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The kfd_resume needs to touch GC registers to enable the interrupts,
it needs to be done before GFXOFF is enabled to ensure that the GFX is
not off and GC registers can be touched. So move kfd_resume before the
amdgpu_device_ip_late_init which enables the CGPG/GFXOFF.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 21b8a8f2b622..ad98be349100 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4478,19 +4478,18 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 	amdgpu_fence_driver_hw_init(adev);
 
-	r = amdgpu_device_ip_late_init(adev);
-	if (r)
-		goto exit;
-
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
-			   msecs_to_jiffies(AMDGPU_RESUME_MS));
-
 	if (!adev->in_s0ix) {
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
 			goto exit;
 	}
 
+	r = amdgpu_device_ip_late_init(adev);
+	if (r)
+		goto exit;
+
+	queue_delayed_work(system_wq, &adev->delayed_init_work,
+			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 exit:
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_init_data_exchange(adev);
-- 
2.39.2

