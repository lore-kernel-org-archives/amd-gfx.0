Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A789CC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 06:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DAD10E087;
	Thu,  2 Mar 2023 06:32:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF06E10E087
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 06:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu0AHNp03dBzc8EVpbF/kjKgAXl22/EKD48C5GC2Ywa7YKnNaTwgQQTVWYbYrUeJlW/vcQ3X7RHNYaQ2A75Xb2nKcHcCnKYFn72eaUO0J/DZW0Fs8cXj4yHRfBrvKeMFEoO5WXvuLYpsMJLS6+9aT1nyX3aHuf/BMVqaIkJOAMBQoErAhAlfN+m8No0GgJmKVf40QtauaLgz39oQHsHSoyyDWzSqONfZVbfrNXAfa7yiuCLmOjmbUIoqCDe6a5Gjrf+kYXMdAzq3JexYO3kPLHQI+hG9tyVTTqE8GET9hAuNBY3Hul36d5W5yE4DUyd2xBVsky5WVftP3JnYV3Cy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAjSTRA95P/qDbmrJPF9DR56hrILp1IgUU8ElQrkorA=;
 b=jq4OMNwdSvmQ4rO07i/dYdurkz/B9Zzw4RVkMTvogiAHe4KY/zKuAVAK0bjw5KyCDNEjc2LMSh4NBcabmmqceM7IXpBcaMs73a5rdnN1qvw+7UZGE9zDrezkdGJ3cD+yrf+kK1o3RpA9UTV3bdDein3wmgfPPcUQYBxSfkHW8t+DRZbH58AtHAj9okzSt4mHfc8JrfEJ++geBXKpWmjFerhH8UHMzq6ueouTtLFXlbz+YIgkWo2NJbWgtRK8kFhWrToIBu1TU/rfTupp7pBpT9QalqkGkJHItSp1vDyt/v0hOV/YU9IpAzr2WTAAde73FdK45W13FGD4NFjcNGNxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAjSTRA95P/qDbmrJPF9DR56hrILp1IgUU8ElQrkorA=;
 b=KFKkFh4cJHJGepPaZ8DnSeoyL/oe8g5yVB7Q8WOnzr8F2KuOLIHXtQp9OE/EzN1vPacZZzzpMdvnWAToSHGG6QB0oq93boHy7GrOke8bmZjA6L6Lw2X0oYSNRsHK6/GysicuNOq6z+ndjWX0HRHW6knTz1NfLAvmKtEeuXYN8No=
Received: from CY5PR22CA0050.namprd22.prod.outlook.com (2603:10b6:930:1d::17)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 06:32:47 +0000
Received: from CY4PEPF0000C966.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::11) by CY5PR22CA0050.outlook.office365.com
 (2603:10b6:930:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 06:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C966.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 06:32:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 00:32:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 00:32:45 -0600
Received: from lyndon-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 2 Mar 2023 00:32:44 -0600
From: lyndonli <Lyndon.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix call trace warning and hang when removing
 amdgpu device
Date: Thu, 2 Mar 2023 14:32:43 +0800
Message-ID: <20230302063243.11096-1-Lyndon.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C966:EE_|BN9PR12MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c68ba9d-d104-4fc0-a28d-08db1ae7efbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCXO4bYXRG5FmhfUP7lCPmQyfE9Li0hQIxzwCjNNMKqhMZ5tFcMYYL9RXDj7KNRKitn0xQn0ZB/t9fDpsiQNjhdd39OUx++UHr3tNxMNS6lNGrR86BfVMHnTyMpJgzbJl1aH8orsfSEvzDA/f5SXM3TnvN9jV5tj8LImQIZODWgmrf3Dowb98yFyevsFkMET8csdozKy6e1e2455oYMJ5H/KNg1GTG6aTkUFYlWhBAvImaeNLPiO7/WzxwCZrWHB8s5ZSLdAUCC5pFGJFFUJ4RJEmV0Oui214T0ym1gfjNh2AAsqarSeziRLTCchUIcDvfXeDS211bhT2ZCvye66lp+qSTRDm7x/pvNdjPBzK0CAutcAfoUF1tgakfdAG8qvtMCUE5/LJSFYHatxC6nvCDDGL1fsQZYIOdGh6mdmnXpn22YYGTfNQn08JgtFQKkgWggsLXD6zmZkLn6tQnZ0ML9ojZQHk4YQ5CyyeuorKQuXzQlEA58OaQ8kmq9D64FitdBpNxR4GJM/pvvQiAMAkAtOC1x0HhWWqltJd65veVUzCuleozHjW+mg2E2UxBW9FL+c879YmnzhMObdaMh3LpUhQIV/dhzjQsRzsjYnFNl8VV/A72GhQkMo6RRBT400ypWujaypXyeNLFzRCa+NvzauN27rcPYSLDxjhCYL5H3NAKIN92wRFGMo1pTVDvVV9MDel9lom6lN11ZuTTZE32zf5mJ0TtW4wFvKxW/QzcH//e+4nhxkfivqTKDNXPzFUscxhrF9nU6BQb9Rpn3b2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(1076003)(2616005)(186003)(336012)(26005)(316002)(41300700001)(54906003)(4326008)(6916009)(8676002)(70586007)(7696005)(2906002)(8936002)(5660300002)(478600001)(81166007)(82740400003)(86362001)(40480700001)(82310400005)(356005)(47076005)(36860700001)(83380400001)(70206006)(426003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:32:46.4134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c68ba9d-d104-4fc0-a28d-08db1ae7efbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C966.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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
Cc: feifei.xu@amd.com, YiPeng.Chai@amd.com, christian.koenig@amd.com,
 guchun.chen@amd.com, lyndonli <Lyndon.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GPUs with RAS enabled, below call trace and hang are observed when
shutting down device.

v2: use DRM device unplugged flag instead of shutdown flag as the check to
prevent memory wipe in shutdown stage.

[ +0.000000] RIP: 0010:amdgpu_vram_mgr_fini+0x18d/0x1c0 [amdgpu]
[ +0.000001] PKRU: 55555554
[ +0.000001] Call Trace:
[ +0.000001] <TASK>
[ +0.000002] amdgpu_ttm_fini+0x140/0x1c0 [amdgpu]
[ +0.000183] amdgpu_bo_fini+0x27/0xa0 [amdgpu]
[ +0.000184] gmc_v11_0_sw_fini+0x2b/0x40 [amdgpu]
[ +0.000163] amdgpu_device_fini_sw+0xb6/0x510 [amdgpu]
[ +0.000152] amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
[ +0.000090] drm_dev_release+0x28/0x50 [drm]
[ +0.000016] devm_drm_dev_init_release+0x38/0x60 [drm]
[ +0.000011] devm_action_release+0x15/0x20
[ +0.000003] release_nodes+0x40/0xc0
[ +0.000001] devres_release_all+0x9e/0xe0
[ +0.000001] device_unbind_cleanup+0x12/0x80
[ +0.000003] device_release_driver_internal+0xff/0x160
[ +0.000001] driver_detach+0x4a/0x90
[ +0.000001] bus_remove_driver+0x6c/0xf0
[ +0.000001] driver_unregister+0x31/0x50
[ +0.000001] pci_unregister_driver+0x40/0x90
[ +0.000003] amdgpu_exit+0x15/0x120 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1c3e647400bd..5554ff22d724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1314,7 +1314,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 
 	if (!bo->resource || bo->resource->mem_type != TTM_PL_VRAM ||
 	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
-	    adev->in_suspend || adev->shutdown)
+	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
 		return;
 
 	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
-- 
2.34.1

