Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CFEC4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 14:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA3210E1DE;
	Mon,  4 Dec 2023 14:13:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC18210E1DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 14:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrzg/Yxur/gKhKWCSnfE0FgyAgkHQGX0dYWX5EIcBF98B+YNQuzCZe4MBHwQ+hocE7xeMK0H8w0E6TBlDMVyGw25jYwgRn3DKxAX6WMkNeTHG1d9uCJP4s+YiGPwMT5YHf/cel9eE6nM8FVvnosx8qVPs/nzeleAZpyxQG9Mhuu+leNqV1+KnW5JxJP+kcxT04oApTu5bV52yMNTs3PbvqlLqM7ldZK+s0EXaZH872XxlV4sPeoKSaFF570OCKZfYyniRQvkxvypGX35f3+yKUoCRn/qnzonb67Foe3XDZuzKbAuauPBReoCTb6Z04yObh4D/XhGqzugczMnR8zuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJLfk/KGOg2ckSgm9ji92eLfCnw5NPHEmIKsHJnWvKM=;
 b=HJAJHzl6Qbtihi3uSQJlX2AazpE5F5qSoRnnE8kk2bqqthxeUKra5CsHh3MtS5GsAfmoD44eZV6QAdQ8UuvH4YUdbABIGLJkkpPP/95SM8r49FWSmUzc5oMYxCpX48rGl9GQ74kZmvFQJrHNhEjbpzlZOc1nLAkKKxPutre2WAIZL2quyWoiWm4dSgMSZitFX+gNfxsLxZSGzuMZyVa1DHMB7r+EBDG2iuJUFd0+qyLne3Sn/+JnxpKblgR2V/Spxb/zfZNKzHKiB0bPNUAnl7nMmxdinYsWFBPPnwveHkCtuI0XNtF/qf6ANNKgJx4NEOCVYMjoCOiBb1yZImKFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJLfk/KGOg2ckSgm9ji92eLfCnw5NPHEmIKsHJnWvKM=;
 b=RQun7Onk1xkbV7nwvqevT2t4Zy1WdkAxVxiRxWYuikLUSlMHXAbCNwj/fDLw7k3hz7/XScBeM/uZOo0zsSt6yhR8sowELv4dOnrG3tZAdtDjhurB5EZqTED8VDJAQ69MDz7okr+hmn55e8zBnrLH/0fvDpYFlP3D0neWF6Id20g=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 14:13:28 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::b5) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Mon, 4 Dec 2023 14:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 14:13:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 08:13:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix buffer funcs setting order on suspend
Date: Mon, 4 Dec 2023 09:13:07 -0500
Message-ID: <20231204141307.20647-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c89db2-6216-41c9-2065-08dbf4d32ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALgX3dL8nHarQ9SzyUoj3DXkgdH2kqbnGx9DM3PSE3Ac6ptJvJxasmpcEa9M4yIjB9yQFEGKLZiQL2jnqkWel9myJW6qCmk1H0ytAYavGdNnNMpT7BpyQIqGbV41dsvhq7+x/hPXIj1YiCmSQEbCt0mGB0/bz/kH89XH5v2cdScYr7Qko7Bs9l49JjCJAUJz7KFkzfmHz9zkm8N0sqmR+o7s4E0RQUOJmy4HPtH/IRbZIOsX1UJQ5Cf6fVnmMlzihOb8unjZBByAiBrnChKrxVeUUZ0SM02OxJHLUCgze96SQ8LxdIEOEMh41DiGl4kNssxRjWzw/OO7Vw8lc2tLF3oR0qQnZlC444sqJKlxHaxlO5nnnecIBe0Q+k6xgOLpdGWyAe2h/dXanQTypd9etW8ToLNdFfbBrwD45ks/Mkc5mqmLcFBE+unM0Egw7nixC0MUY75Jh00wkBKnc4qK+g6pLMMkWGWn8wbrEiLetiASY7XNe6cpTWx/3wkungQfNfbW0RnO7N1uxPBOl3nGCcm6MWqtba/5JP3nFvsKeY5eAeedgdbbV0XkjifoPh8+zSUmAIkzWiWHpcIJ8ngwi9ds1U8Nw/mE0Oy2FgKSSZDIvG4o8Br25mw6AaYKPzvfP5e8wO0SQCvbCoklYYhue5Hr8SCOBAWijE3MxtsMROFtnNFh4MEVWjHk1+HdQUVks6jkQ9W056guPJ89CXZf8n4NlJ/Y0ON3EaST1XmIGuqWfPZeStQGzw9VSoSgwcqLMdjUmX+t5euHEyK7EqCcaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(1076003)(2616005)(4326008)(8676002)(8936002)(7696005)(47076005)(40480700001)(356005)(81166007)(83380400001)(36860700001)(16526019)(426003)(336012)(82740400003)(26005)(966005)(478600001)(40460700003)(6666004)(70206006)(70586007)(54906003)(316002)(6916009)(2906002)(36756003)(41300700001)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 14:13:28.2474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c89db2-6216-41c9-2065-08dbf4d32ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Phillip Susi <phill@thesusis.net>,
 Luben Tuikov <ltuikov89@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to disable this after the last eviction
call, but before we disable the SDMA IP.

Fixes: b70438004a14 ("drm/amdgpu: move buffer funcs setting up a level")
Link: https://lore.kernel.org/r/87edgv4x3i.fsf@vps.thesusis.net
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Phillip Susi <phill@thesusis.net>
Cc: Luben Tuikov <ltuikov89@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f29d0faf956e..b76ec5ec04c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4593,8 +4593,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_ras_suspend(adev);
 
-	amdgpu_ttm_set_buffer_funcs_status(adev, false);
-
 	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix)
@@ -4604,6 +4602,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (r)
 		return r;
 
+	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+
 	amdgpu_fence_driver_hw_fini(adev);
 
 	amdgpu_device_ip_suspend_phase2(adev);
-- 
2.42.0

