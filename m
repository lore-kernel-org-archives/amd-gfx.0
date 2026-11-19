Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FB606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SEAVqdF6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A301121C0;
	Thu, 19 Nov 2026 09:06:21 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2531121C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 09:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKmHhB27C2x1RwqeNLCOKE1Wamji76V0kCyFX3zNMD9/7GT4jkU5vbrvvh6Y8O23lZTV6Nw8pjnCbpzCK3shDXnryMSLfrKF0vuotAoiT29VSqnniURg3uhUPnPFbYvS3HqkfJYZoxKpv4C+TpbKp3FqFWUkshLw+3nqrZRkP9QVdVUF/eki12avEMdEL9lqywppCLLzg0KWmkyM9JJaIoE30TEmi+knbN8dzgn8SO2azzeZiW609ZMcO1OMpEr8Z5nKFDv+UCUDi0l4+SRb0RVtGhPXENRfL83DXedazGydoqBX2MyuwOOGWegNZWYyM7bX07gO1Q4m2DDV3U4NGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw99XnvLtL5EdJ/lP66abQzETg9pIx/1vICzRWQXzOA=;
 b=BtX8qwumIjlVQhW41VHoDaxQj+L4U+hJOvWqi7C/hSFXsQ096BXMHQwYZAr9zXGN3erCmcXt3kJcjLAeUc1iEanfaEK2j9lR/LTrLWumwRP/1gEfuWzdQRecoQGCS7x8qGsQsDhiZFhp/u6QhqAQH7fMFImmKFXX7yEu+f5hzkmpc4gEPqmik6jEQGQriHYzcx3WHVTnkyqYmX7GbCFgsxGMx62ujccNlOyWLuHvlKfZ8G/V1tOyUNhY8vDlDoEgAfLqP16I4RKeB45svA0LewhGTrcRz5hcwnFQjC8GwQ0HH/XF8e959gDuW5BUfbW6Jy6ekXpZuH6E7ECfklwAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw99XnvLtL5EdJ/lP66abQzETg9pIx/1vICzRWQXzOA=;
 b=SEAVqdF6HYUmqLC/lnwCUNmnfCcAjFXHXAgq/3p8W60j1jTzMJgc5srjDUtjejNTTLr9Y+MI5vne4no39F35/VBxESzgE7NPb6W4Hrg6v7cqsIcofCbJo3kjAJR2UEIcVPbUCelDEkg3w3mLDyh2pfP+6nSYj+B92bhm/2yUBZE=
Received: from CH0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:610:cc::19)
 by LVXPR12MB999196.namprd12.prod.outlook.com (2603:10b6:408:3dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 09:06:12 +0000
Received: from CH3PEPF00024580.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::98) by CH0PR03CA0074.outlook.office365.com
 (2603:10b6:610:cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 09:06:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00024580.mail.protection.outlook.com (10.167.252.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 09:06:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:06:11 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:06:11 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:06:04 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Jonathan.Kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [v2 2/3] drm/amdkfd: return the memory violation data to the debugger
Date: Thu, 19 Nov 2026 17:04:54 +0800
Message-ID: <20261119090557.3494649-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
References: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024580:EE_|LVXPR12MB999196:EE_
X-MS-Office365-Filtering-Correlation-Id: 6801e1d6-7427-4ac7-70ce-08df461c5b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261102123227099003|10067099003|261021121427099003|56012099006|11063799006|261026121527099003|261021123027099003|261026140227099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zpu9zCbSnoMfn7Oz6mdC0SrKCE6xY1qFfS9+nEnSnkKMLTfeogdi1BTLuRXtBYWbXRm1P2plZMDEWtuAb9CsUIqd7Vr5ZD7owjrSbQ2kwls4V9dZAWgTk0TMHNAx9Akn4e8SuFdy9Y8BgJKXCzYpemuHAQg54GYAJpTengP7Bd5qrT7BjO0POkysVm90cjg8tgze/jQ/oBOqnKedVfWn92cxndpCu/CczMdejFYDjXBnVP0KQ8jRfRMXqWuC4In8hzmH00fPw/xOgoeHLV0ivYPetK0wHyTbj/gptaWsjSaTlmUtIIPHnBk6N137ln+GFrLL8HUWsSPbq+dJWPVGM3nOJtBAZDzZcHsPa9a5ZKeTFUjpaBQv4f8GvOT/kpUtdsG4dHIJUzbIgLWoauQwHwy7RJ5IA2ZlEOqZVBKcYrmqSTitCYpwhXubMYzLr32FmOQP1nBbj530QGAHnvMcpwx/KIXucGXjlZDozYcLQcKBqUXp1Z15uEsgKMvz18IrB8NmxgAXWieZmh4W5NSAV7KQI05bGThh2GBC89z98P/ZpJPnPSMA+KU3Tzwwy6kluQOipYJWvnz6Y3NmTLasTjUeKUBmqWMPy+VGxhkL41zOMmVmlIL8bGSWpWE1Y1IJVqiVYPAJ8kw1OkEEAyQ43bui1K1oddkb0tWKqDRzo60/TJtJR1d9pS4YstAmJfnZJWIb/RSQLdSGK6Wwe5zKUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261102123227099003)(10067099003)(261021121427099003)(56012099006)(11063799006)(261026121527099003)(261021123027099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d7n6T4Y3boIF02j5DVgoYxjay7b1ns50ukB5lMsSHV0Vy7CDRyAyRYT5fpfIBhW/i0BjQO4dR2JtIsfWDruaUn/nZqnzytB6V9NWmwWHQG1oZFpmuJMlPrMIDJprGjA2cUjDMstcyRxgKTeoIb1ENiXx+YSn8pX0FGkF8v7q0pbWzFJhA8PYZXw57orlIoULWmz/ERve+NrLcqn523j5GOIBjfVrziqcZSRhgGBjjipMXKcCWTnqUXhr+TvVGKhOY3FmQqI79mELpcNJpI0XDZCaykJfMA0bgElKy+XGzvrBH4L4wADBP956gk3dqW+QoWmuMb+NdtsKq3LgKkm0iuB8T/kUGWsa2VtXzLbEyPH6ocNOhni6mdCu3jucPSt7lzKao0eZEGu+lzf2FFm/EmGQTkI+PEd1Xop2A5DxA6kK28CpCJP6UQfF+NgKKCZA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:06:11.9210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6801e1d6-7427-4ac7-70ce-08df461c5b96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00024580.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999196
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kfd_dbg_ev_raise() saves the memory exception data of a GPU VM fault for a
debugger subscribed to EC_DEVICE_MEMORY_VIOLATION, but never sets
vm_fault_exc_data_size. QUERY_EXCEPTION_INFO copies that many bytes, so the
debugger always gets 0 bytes and no fault address.

With a process debugging itself and a KFD SDMA queue writing to an
unmapped VA:

  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:40 vmid:8 pasid:63)
  amdgpu 0000:03:00.0:   in page starting at address 0x0000000060200000 from client 10
  amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: SDMA0 (0xd)
  memory violation info: 0 bytes, va 0x0 gpu_id 0, fault at 0x60200000

With the size set:

  memory violation info: 32 bytes, va 0x60200000 gpu_id 51573, fault at 0x60200000

The data is also only freed by a query clearing the exception, free it with
the process device as well.

Fixes: 2b36de971d25 ("drm/amdkfd: add debug query exception info operation")
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index b2d01613a21c..cfd43e417db9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -143,7 +143,9 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
 							exception_data,
 							exception_data_size,
 							GFP_KERNEL);
-					if (!pdd->vm_fault_exc_data)
+					if (pdd->vm_fault_exc_data)
+						pdd->vm_fault_exc_data_size = exception_data_size;
+					else
 						pr_debug("Failed to allocate exception data memory");
 				} else {
 					pr_debug("Debugger exception data not saved\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f959f19d92d2..d57eebec063c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1288,6 +1288,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
 		mutex_destroy(&pdd->doorbell_mutex);
 
+		kfree(pdd->vm_fault_exc_data);
 		kfree(pdd);
 		p->pdds[i] = NULL;
 	}
-- 
2.50.1

