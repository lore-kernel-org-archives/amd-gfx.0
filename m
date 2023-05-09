Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B096C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 08:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2097C10E359;
	Tue,  9 May 2023 08:25:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF3710E359
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 08:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAwp/PfiQrBCy0g/uHYs0R1uP5sbzTbgHSG1k4EhGS15WOPZHIg5Brj8w6lRwVzDg6f37qj2r4eJta+8dEsIcGU7evDlcNTBy19xWVzr1t3eN2GEXvh4yIp5aW3ou447GlqgtQDHMLt3p5wS6868M2Xa3qbDlVBrEYf9aLzfahrkz62q/EG7hm7G5jEl0XAb8KD4aaIistnHVd9bOAPjQEVLm8JM6NSyZf0o9liQqzcuwCiEwcvBts38SZ5SzTBVCYPDI8HQJMkg4ClqfLWsvqbh59uitn/vrydjEN+TjLYsnSkh5EL7Cl7JNVc18YHgG+3dTfKbQRSKAVwUKG07/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh+NPGfEQNZR6r4eoel9n/xl0eR8pP7q6EFaG5Q/CBo=;
 b=lCmFZ0DxoT5cv5+dA7xB+mr8Eb86YMcLKTQD4U5qyN2DoCGd+fnuuq1a73Z0efCnVCBeEITIu4HrgsoVGbqqLrio/sOTZFFH9d6xZMVENaQxF94H/dTW4iafOi1pKNgwkJutzvOwUxsgItnkzAZja75BWyARcg8Ve9TaYwES7oFgY5FaZdg2F26JRFfEoSrQPSmZIccwYTqSy5W/oc48Py3N+pcnMF5n7EtWi09mziXNy6Usp+Lzk3nODHxsKLBeQamd3VoqWd2nnUuVRjD93Or3xMUs2ktaOBvWpApkeNAbSvis8w8JcU63GTJ/V4HwMouANMAQi6pLBVh/RJAuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh+NPGfEQNZR6r4eoel9n/xl0eR8pP7q6EFaG5Q/CBo=;
 b=M6suJXp6VyTnpB7qF4DD2YSuPBaGLA0oHKg4uHReyh3I0uDVoDdRMuPizRUOOyAsvGVD2/A71d/Td5QsUFQoN0p+69TbVkY0YHKRoaj9JZXPPxsYAB529ggdN0IOsReZoa6Qc/cXpzXbD2n5TMGQGM+1kUFa2w1hD2FczFH3kUQ=
Received: from SJ0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:33b::8)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 08:25:30 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a4) by SJ0PR05CA0003.outlook.office365.com
 (2603:10b6:a03:33b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 08:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 08:25:28 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 03:25:25 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: skip disabling fence driver src_irqs when device
 is unplugged
Date: Tue, 9 May 2023 16:25:11 +0800
Message-ID: <20230509082511.2183745-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc9d88f-e2c2-4ea8-19da-08db5066f28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LrbCJBZ1DQhHhMTJ2l4jbsFd1EW+HP70LYgqnXIMukV2CVEjA/KN0mbNSWW4Zc/6g6VEwJB1ACZSgK5Xeb4QNdph9VH3Y1TBuLjc389DuLDlyeD3iJ7ceYYZsK3/1qytq6sVq+GAA9oSyiHPPw6gtkwhDZxogTBg90fXTYrnmv3Ns1DBsdqxovGv6ze/SlykRZjI1lDjnnM9eQO9ixqMICfI6cfZ2CCD9+OBw8IRPQHY76tD/M7GLkjPsfNRl111xbmyeEFviVINUzlp/mu84VTOrIK7YOJ7mDbJ9q6P7ieTf22fhUzUyI41ptF0EKFLmVAyEys3jdclORTp8U1iNKkFJ5hCQIqGxAnuLnt4iyZj0vNcmv5gyVZPvk5ol5B4RcZbEyZjmiLwnb9+GqdqqvNACxHwTiTvj+zyiT++UQ6jUQfFajcyvyhVFf9sRjw5PNWl9zKKNKU09z8N6dQPkE/P6ZOD4wKM3JxuT5yRV1PLi6HC7xtykvwbtfOpUXI13BO8wM4/uOnJuLRw7qm504cjjUh4PANvBTfdH0sjn4rcc6ZL4COOXhzQH3SUiA4V7D9rOLQOH2URJAEm8AQkvG5p0v2JYXD9cpDqszIcHuq4SlVBvuWsgCWics1JUASrEPnlr1qVRKFtQfs7Rjilv0hCm4Dtfi83+uKhsVR6QqGOT1AAbkhGIxQHI0SGY8Qx7aYRI8qgWj/pd4dJZjidxy2NLcXXkc/C+hZVOg2wgQh6Xl+tDP5EnkoHZkBSIcQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(110136005)(8936002)(6666004)(7696005)(41300700001)(316002)(8676002)(26005)(44832011)(478600001)(70586007)(6636002)(70206006)(1076003)(4326008)(2906002)(83380400001)(426003)(63350400001)(336012)(40460700003)(63370400001)(186003)(16526019)(2616005)(36860700001)(82740400003)(356005)(81166007)(40480700001)(47076005)(86362001)(82310400005)(36756003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 08:25:28.7491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc9d88f-e2c2-4ea8-19da-08db5066f28c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

When performing device unbind or halt, we have disabled all irqs at the
very begining like amdgpu_pci_remove or amdgpu_device_halt. So
amdgpu_irq_put for irqs stored in fence driver should not be called
any more, otherwise, below calltrace will arrive.

[  139.114088] WARNING: CPU: 2 PID: 1550 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:616 amdgpu_irq_put+0xf6/0x110 [amdgpu]
[  139.114655] Call Trace:
[  139.114655]  <TASK>
[  139.114657]  amdgpu_fence_driver_hw_fini+0x93/0x130 [amdgpu]
[  139.114836]  amdgpu_device_fini_hw+0xb6/0x350 [amdgpu]
[  139.114955]  amdgpu_driver_unload_kms+0x51/0x70 [amdgpu]
[  139.115075]  amdgpu_pci_remove+0x63/0x160 [amdgpu]
[  139.115193]  ? __pm_runtime_resume+0x64/0x90
[  139.115195]  pci_device_remove+0x3a/0xb0
[  139.115197]  device_remove+0x43/0x70
[  139.115198]  device_release_driver_internal+0xbd/0x140

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 5d96f630a3aa..d0ed70f45db7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -581,7 +581,8 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 		if (r)
 			amdgpu_fence_driver_force_completion(ring);
 
-		if (ring->fence_drv.irq_src)
+		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
+		    ring->fence_drv.irq_src)
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
 
-- 
2.25.1

