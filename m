Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9BAC77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 13:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD3F10E42F;
	Tue, 23 May 2023 13:29:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657AF10E44F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 13:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3DP1zRQ8yKXquu+SGY30svi/w6hzbkccF+bLK6nrrdFrzLnbRbGHPU8Y3FOmAkSJMDbgpVSgsbrdh5HTzs55xfc+ydkhlnCIHMNy+entsw2WJfZwew71JzpseoV+7zeVXowwJb0WkSyRTKuk6zrVcWTO9N1YNuPs+GMzFQAw7GiSUGE2Mmy1BdqXunfTY06ncI8V8ht3d7KmIRcVewpXAQwAZLURZ+rAKrziTorR0K8zhbGbHGdoF780/xLKVQhU8X7VQLb3EsSDQX9Z8chtN9mn9Jz98x5i9WtGD2KlSceipJkQ2wBQqLsbiOKDln/DL+T6/TkC+mzgt23kJUuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X4JEc59WN6t8kfNmUSgntUnnzTdQnJTiF/Pd00mZiA=;
 b=X0R53zpRkYD/p23ZqJbzcbMB8/ff/YSORdB26bPHXcUfp0cj++Ph0Rqs1zSmq6Y23WXMMlahaeIgDYOJyIBdFkfKSQP8kPCMjYdpsFgOE/iChlAv0KMqZy0eeCjHbHQPJjuj61dyWZ2nzTwqQoAjulp6KoXMvO4+iorur6pZDOaXkZmOmcqa4YgrR9BHDlShCNplj6DAyaibtIQmDZetapQY6OEZ4GAH0R5H3Mnb2S1WOJk+OjYlL40a9yQG44lM9qL/RO71WufTsvLAFwjRCjHysS9uFU3P3D6G6q/9YwevFc7RDOdA1dzzrxWxXkUfZ0Pp2iQ0RW/MINaCXYXAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X4JEc59WN6t8kfNmUSgntUnnzTdQnJTiF/Pd00mZiA=;
 b=V1Sf4Q6dFpTnlZ7SczrtZwNBK2O/ai+JtpZyAIpCXuRlVODuQCJjuIlZraD9Da9CyvDCHCJopoudM4JdNLtwcwejq81tU5pplaYmt3y8E+FqT1NeBmY5a0NsFz+3wcNWxcn79tcfVYIYwJCTD3WRvm+XzmchgLtGjgJioz77Xho=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:29:26 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::3f) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 13:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 13:29:25 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 08:29:25 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: save/restore part of xcp drm_device fields
Date: Tue, 23 May 2023 09:29:12 -0400
Message-ID: <20230523132914.3144843-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e98945-e059-45a7-41d3-08db5b91ba8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gE/GQPu9tOeyL62USO03CtmO/fUe3mohMRRpwtlvidqtxNoXB1l+B3B7MdRS3an0jJmA3ZR/HLEWhcwqbs6WqUIq7Qpg4vPWer4+rgG4Qn7JQz9pK+7wQ7NKeB21NCunTFxDu3lzSFogUcNJvz2wbQ93OoKP39s3bdImTqCiCQnZr3GInzVpB3YMmPnHvAwLSGFrgN+rCYSPj5nYbZRcjRXS8aDXo/HoWIzFtaQLghRcJBSEdXBZsLR+qZB2MevgFPe6ue3tC7bbPL4E0Keii4dgGKoQZTPs6cT9jng0IyOBRzGO3dQ8Kz1r7prARkWWb+A5N1SEPLsswCZXu2rIflj2hujnJUHHl2rwA0p6/kcqJAWYRi9E1StY6nXKNJhSB378cKK2w/wbJIXo7z6+W2pe5jzYkX/hV/I9zIrxAvR18lbGAWpHwByuM5DrB/xvv2O3cc8ieYxmR5/fjUyjE6WtWc3IqFc+IyEcKIhTvBdP71460xQt1+41ANUy5r5XiQuqf+G67TgI8cJLryQsO2ZxLT04K3e4mBsu9LU7ciUOHlB4iW5BvI3VXFiJuA1kzsOT0lr8bERhl4jby0/Iyy2S8M9rL+kxWQgfkmJ10c0UTubBqQuzRiy3DtcjGxuqmpeWFyPQf6w0jr4595K+DeCL7bsPcue7q6ozLN23vHS+6TPkQqPtzf5OIoS4u1+GsAsKX+oh/H1Kz0Yzm9tazIzxtfZjyWb2RZYHLlFzvoTMi2NZe6vvoLjWdu/MqDUepCVjNnuwu5JEP9VoKmcD5znhzVLF7omSznfRYLxWn60=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(8936002)(8676002)(5660300002)(47076005)(36860700001)(82310400005)(16526019)(186003)(83380400001)(1076003)(86362001)(2616005)(26005)(81166007)(356005)(336012)(82740400003)(426003)(40460700003)(41300700001)(7696005)(40480700001)(70206006)(6666004)(70586007)(316002)(4326008)(6636002)(36756003)(478600001)(110136005)(2906002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:29:25.9790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e98945-e059-45a7-41d3-08db5b91ba8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Redirect xcp allocated drm_device::rdev/pdev/driver with
amdgpu pci_device/drm_device setting. They need be saved
before redirect and restored after unregister xcp drm_device.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index daeb6bcc9245..6ab5713ff741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -240,9 +240,14 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 			return PTR_ERR(p_ddev);
 
 		/* Redirect all IOCTLs to the primary device */
+		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
+		adev->xcp_mgr->xcp[i].pdev = p_ddev->primary->dev;
+		adev->xcp_mgr->xcp[i].driver = p_ddev->driver;
+		adev->xcp_mgr->xcp[i].vma_offset_manager = p_ddev->vma_offset_manager;
 		p_ddev->render->dev = ddev;
 		p_ddev->primary->dev = ddev;
 		p_ddev->vma_offset_manager = ddev->vma_offset_manager;
+		p_ddev->driver = &amdgpu_partition_driver;
 		adev->xcp_mgr->xcp[i].ddev = p_ddev;
 	}
 
@@ -330,13 +335,20 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 
 void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 {
+	struct drm_device *p_ddev;
 	int i;
 
 	if (!adev->xcp_mgr)
 		return;
 
-	for (i = 0; i < MAX_XCP; i++)
-		drm_dev_unplug(adev->xcp_mgr->xcp[i].ddev);
+	for (i = 0; i < MAX_XCP; i++) {
+		p_ddev = adev->xcp_mgr->xcp[i].ddev;
+		drm_dev_unplug(p_ddev);
+		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
+		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
+		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
+		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
+	}
 }
 
 int amdgpu_xcp_open_device(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 9c5912b9d8bd..0f8026d64ea5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -77,6 +77,10 @@ struct amdgpu_xcp {
 	bool valid;
 	atomic_t	ref_cnt;
 	struct drm_device *ddev;
+	struct drm_device *rdev;
+	struct drm_device *pdev;
+	struct drm_driver *driver;
+	struct drm_vma_offset_manager *vma_offset_manager;
 	struct amdgpu_sched	gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
 };
 
-- 
2.34.1

