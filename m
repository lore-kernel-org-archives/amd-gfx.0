Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31E0C77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 06:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1519B10E697;
	Tue, 25 Apr 2023 06:38:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15B710E696
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 06:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNi7v8842tRq+xhM7dNa3nt7d5cKHNRCXgxeN0Ty5EfKxv4qDkYUoCGILQj06Oz3Q0kV/ORNlds5aEsSUxNnYBv70Mm/WIHiyLq6ob4VLU3KLxLNVP5IXKyFJ6eBkkhuSqYigDGR4a0uomEOfVHCff7bmJnf57wToQOUMEOmiWe2GdRAL2QF6KfOK+0wTU4XO3DP2+o/KgwmEWDQDFvB9KehSNiZZcFG8IC8BQG8tI7nN/M5Ch9rUg5q2zZ05btVNQZpc82DYSKY1Ixl4mYhzK3hOm2FikzLz7vSWoqrT7h0QiH/XsazhV66LavjuuHgnq609jbsy8zQWP78J7cS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da+6YQIQf/n+V+qJG8dU16lS93fhO9YxbwKvdpg3pEg=;
 b=W41yMuDPCxy+NB3QbojXaBMcIijEWR+Qb4THXcx1mCciXOGtmIR6bGusTzbsVD7ib0GH9stD2NPmcMKYROQKipQQHF3VulwO8kLmEfE0G9r+qEb9ql+KyNkEnzVooonRsYZc9Hg8Etlf5WsNpxzCsjdPRqy7/3wbP/3nPElGU2myS3rf+Z4wnX/z8FL6c5MkbKrZXMJGzOUQ8vFqMPPMNKB5Zo+ZzIw2WLdtxxEkfLLf8uMn3sVE0aI3SeyZo7NluUvQWxkn0b62X5nd3aLqW084QtWsVhOhq2kzUwodYHZ3b3jRdTiOZYf/n6MBN75bA9NvMhKsY7pQ35FPX4zthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da+6YQIQf/n+V+qJG8dU16lS93fhO9YxbwKvdpg3pEg=;
 b=XcLS94SAdNeQXsmJaOzLAhFazy9MKNlgrZ5M2mEg8Y21XLVBZxSZiQLQZ3ztASlXfbZ/A7nzZ4n5aT/HBe9FL7tAO2zFqtiAvR2b112bE+htPfTUlTK1RRywn6qZ6OgyB7o95O+HJJ4GAOeQWTlT+6h3V3GMAwqb95pCaIlYJTE=
Received: from DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6) by
 PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 06:38:51 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54::4) by DS7PR06CA0027.outlook.office365.com
 (2603:10b6:8:54::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 06:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Tue, 25 Apr 2023 06:38:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 01:38:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 01:38:50 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 25 Apr 2023 01:38:48 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdgpu: fix amdgpu_irq_put call trace in
 gmc_v10_0_hw_fini
Date: Tue, 25 Apr 2023 14:38:37 +0800
Message-ID: <20230425063837.26701-3-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
References: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 4961e4c0-cc2e-4e9d-931c-08db4557bb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kRN5shGDfvpkiasBUfEsWtkubU4IHx2M2UnnZch4GjmUKaqSdKxFDe3+O8iBYqJrW9HnFGhLoOn7cF08s8BIRUOteflo8oRj8xeZPYQMMXdB9IdqGOS0WaFAGNLFNUIw73JKB9L65MuwKdh/AevXulZREkqIhs8uaRt7WF5yZxrNyhwCnhYY9AGq2ZvIZBSxFXfeAqYabgtif5WUgFvKKT19OF9NZDkKSOzGoXZRchrLeKlO8YsIC6U85o8w9K8nkKXMoGQ/trMxj2LWLrZ17BmfGvNlB5D4KBHepHTtv4zZBHVurF82vH/HRegt5tQFncxbZLlSgHH9rSpUCGSZ0ydvZMrQl0LhSgw2PCGImVO41y8eqZwcpVKKyhUbnOS35HrwP8W861OE7qItSxxnsFBZ21KIdRYtYVhYxvrb2wcZOLgMlQFNu525N99CzfbEeGCt/06H/f/G6l1NQAJC7NgGTkfcBip9bSic1/6GJmd12f70QdWFwM5rECBqCieudEN7TAgEp8IhvuFkHk4ziIFR1wLKJUf5i0iVX9uN94s1MfLUez4NnAzE0BuWabYBpr+gdDloU6D3hRin0u1+2Si6dokPoUM1f6PKr48hIE2BUsUCA5JNZ39yLKZuuyvgr7ttPZ/jdjzYpAmIM8cnOnqk5y8Bo4ZQPGtgf6ujvq1+CwFygHmXXe6XrSBJzCywyb2MdPSxQRfMV+K3tsDbbV8+bfLYBVlPIpkBUYWEVU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(8676002)(8936002)(5660300002)(6666004)(7696005)(40480700001)(4326008)(70586007)(70206006)(81166007)(316002)(40460700003)(356005)(478600001)(54906003)(41300700001)(110136005)(36756003)(2616005)(82310400005)(336012)(426003)(26005)(1076003)(2906002)(186003)(86362001)(47076005)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 06:38:51.3405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4961e4c0-cc2e-4e9d-931c-08db4557bb90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097
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
Cc: longlong.yao@amd.com, feifei.xu@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The gmc.ecc_irq is enabled by firmware per IFWI setting,
and the host driver is not privileged to enable/disable
the interrupt. So, it is meaningless to use the amdgpu_irq_put
function in gmc_v10_0_hw_fini, which also leads to the call
trace.

[   82.340264] Call Trace:
[   82.340265]  <TASK>
[   82.340269]  gmc_v10_0_hw_fini+0x83/0xa0 [amdgpu]
[   82.340447]  gmc_v10_0_suspend+0xe/0x20 [amdgpu]
[   82.340623]  amdgpu_device_ip_suspend_phase2+0x127/0x1c0 [amdgpu]
[   82.340789]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[   82.340955]  amdgpu_device_pre_asic_reset+0xdd/0x2b0 [amdgpu]
[   82.341122]  amdgpu_device_gpu_recover.cold+0x4dd/0xbb2 [amdgpu]
[   82.341359]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[   82.341529]  process_one_work+0x21d/0x3f0
[   82.341535]  worker_thread+0x1fa/0x3c0
[   82.341538]  ? process_one_work+0x3f0/0x3f0
[   82.341540]  kthread+0xff/0x130
[   82.341544]  ? kthread_complete_and_exit+0x20/0x20
[   82.341547]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 23d4081eca00..5697b66bf0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1143,7 +1143,6 @@ static int gmc_v10_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;
-- 
2.34.1

