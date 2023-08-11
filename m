Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6600C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 21:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BECC10E11C;
	Fri, 11 Aug 2023 21:06:44 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F2E10E11C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 21:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUh0Vc4WRbKTzlp/dZpBesxf6lld9J8Gi+7nxGyl2DuFwQk+MphLAIGSgv4JU0F7zp5U6HrIonHA8DsDupKaKA/iJKT016WAn6j6mP5NAteoYKnpIHGIEvePjBKJFBDvbi4jj0IXVq8Tn3A/j2FNZbFfrW1VBzDFvS/6Verxdiwqj5k/+Mc4Qk35ZljAMFattVm7hpo/MpTNTw4NFL5dUCFJHtNGC6a/+ROxk42t34bPVWGPIL6KRtqHbO/fk8bMPP2yfan/V1FHVkU9FovWPugEZFGVF1LH2U3LWvoKPHzVBJF/bXu0vPZzzpqe6fuGu/sqEY1Z4Pix8EIxuZcqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o77Xx89gdztA1pGozxXirKIhUFZCrPDyQr0CQo/Zw/I=;
 b=dBJOZH6MQ8c1epvLEW56wfirevjWoni3mDt3DUxcK4mP6BQ88ddqqKRl028KotxYnVnyRBLfPPMwWXzDEBhcW1GENx7722cSYrauYKvD4vTd4fFC4IgNv2n0NoR9QyZ/obFmWtuKOWWzvOWsIzFxq0MZlyXXrlPhOlXjsEW+RLjE09Fj3H+/p0SMj0TL6I7LowY85PDtz0/HaDNWPclR4XeCJPq6YVM12zFMdrAl/CLSFIAe3cRSVsu2Lx1TWaMKgY5P5v9jFB1Qx2I8zHsokVZBqsGgX+HZ/ExeOX4Q9YSIqL6c8VoKdhhgJz+MhYQrrNDl3xuuCRwlT8Y/WVf8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o77Xx89gdztA1pGozxXirKIhUFZCrPDyQr0CQo/Zw/I=;
 b=BUVruR9UNI5QzcQkjfHSIamJieVYbPrRt6bIX0TCMUB2Z+iI5AEA2LiFsx8uhoQHnDesC8e7/Qg7vKWWXLz8/DXkcFAwnZyEzCiDJo9ssGSc1yLY4lxsfCCoZx6fqmAPeCip+HSyBkxclUSkoXiW4FMXmqhqbSh48t1+jy74g9w=
Received: from PH0PR07CA0092.namprd07.prod.outlook.com (2603:10b6:510:4::7) by
 SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:06:39 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::b) by PH0PR07CA0092.outlook.office365.com
 (2603:10b6:510:4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 21:06:38 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:06:37 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out of drm
 resource
Date: Fri, 11 Aug 2023 17:06:27 -0400
Message-ID: <20230811210627.1888328-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811202337.1867891-1-James.Zhu@amd.com>
References: <20230811202337.1867891-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 3001de65-d35b-4504-ef6d-08db9aaedace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+LlFjaFWdizQp4hCpQo5tM3nQvr8DHzbTcas3/QfK902223zGI00esngtF1x1xsf4SxCwHheUsXoYOyXc4mh1+507zmarCirA8hvgnDf0BaxNrWNxNZpv2Hn1/ijuKN4G6kY8DMMNvnFKhpmTBHFqXB2LpIsjUbho/bP0uguEF7shvw6FLLydzuBqJqAxgLn2tnBHHmiobjmMOXS9RjdDyMJSnimqlGQvV+aLaZ0dSUSZOWpK7tZhIcFyGu50bX1nAuab+ivGzRYZDcYubyVS0EyqqdRupOoY7rN/YYK36H171EkBe4hCWwWXKpRQ1e6zy0QYz38Epc71Dg2qISdZvf+K2793oLie139uMhfcmDMB9Fvq0nC9cBosD6445XRztFokT/sJGiZr/oiBFO/JpYC2qw8d8WFaUpERMBJvOXPy0UkqFz+0g/1KVY21nqU/wdpSQ79KHECEs4ZYCAbH1VJLM0eY1XxhFUZ2QCK3EyqPRigw5Y84IhlhcQsLtWpYbCX/mdCELY26+TPjgIzyklnDxWZA8J72SAkf95/+rM1jKGf1/CaUpHKMhJkw6qzHk12Vmibd8AjxtIDCoMBLh4enB9yjeI0NFGTAg/JcayMyfaAVob2xdmxMvjk2Z8PiD27fyptqYNSdRhg9rJRU2FGRF85GJ6U/AePYB0ZZgAt8uhMnLCa3FuHJ4C4OEyTykc8iSRA7dksygRTiKMEnaoO576G8UTa56V7eua6LOFMmblNt1uKfJeLE92ACH0fv8V4y5tFAtZjKKS5nqZ1jRh0C/3J1ZAIfyI8kHcEMU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(1800799006)(82310400008)(186006)(36840700001)(46966006)(40470700004)(36860700001)(356005)(478600001)(86362001)(81166007)(40480700001)(54906003)(36756003)(4326008)(70206006)(70586007)(7696005)(966005)(6916009)(2616005)(2906002)(26005)(82740400003)(1076003)(316002)(47076005)(41300700001)(5660300002)(66574015)(16526019)(336012)(40460700003)(83380400001)(426003)(8676002)(6666004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:06:38.8414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3001de65-d35b-4504-ef6d-08db9aaedace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
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
Cc: Amber.Lin@amd.com, jamesz@amd.com, Harish.Kasiviswanathan@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return 0 when drm device alloc failed with -ENOSPC in
order to  allow amdgpu drive loading. But the xcp without
drm device node assigned won't be visiable in user space.
This helps amdgpu driver loading on system which has more
than 64 nodes, the current limitation.

The proposal to add more drm nodes is discussed in public,
which will support up to 2^20 nodes totally.
kernel drm:
https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/
libdrm:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>

-v2: added warning message
-v3: use dev_warn
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 9c9cca129498..565a1fa436d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 
 	for (i = 1; i < MAX_XCP; i++) {
 		ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
-		if (ret)
+		if (ret == -ENOSPC) {
+			dev_warn(adev->dev,
+			"Skip xcp node #%d when out of drm node resource.", i);
+			return 0;
+		} else if (ret) {
 			return ret;
+		}
 
 		/* Redirect all IOCTLs to the primary device */
 		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
@@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 		return 0;
 
 	for (i = 1; i < MAX_XCP; i++) {
+		if (!adev->xcp_mgr->xcp[i].ddev)
+			break;
+
 		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
 		if (ret)
 			return ret;
@@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		return;
 
 	for (i = 1; i < MAX_XCP; i++) {
+		if (!adev->xcp_mgr->xcp[i].ddev)
+			break;
+
 		p_ddev = adev->xcp_mgr->xcp[i].ddev;
 		drm_dev_unplug(p_ddev);
 		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3b0749390388..310df98ba46a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	int i;
 	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
 
+
 	gpu_id = kfd_generate_gpu_id(gpu);
-	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
+	if (!gpu->xcp->ddev) {
+		dev_warn(gpu->adev->dev,
+		"Won't add GPU (ID: 0x%x) to topology since it has no drm node assigned.",
+		gpu_id);
+		return 0;
+	} else {
+		pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
+	}
 
 	/* Check to see if this gpu device exists in the topology_device_list.
 	 * If so, assign the gpu to that device,
-- 
2.34.1

