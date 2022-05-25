Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12E8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC86B10E539;
	Wed, 25 May 2022 19:05:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDA210E238
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dkmj8G0n/CCTwERFB522Bpntx0k1bdG9ljkoxHS8Ef/UyArt89lLkhCoQlC3/64IIIdL2Abq2XC/miomYs0FPX7kR5Nmnn8o6OJKJQpeXB0mF+OZDdMswv9tasiZPgRxdMVmT/oefqlfXWYZYYl3srVQLkR8izUMz0ft2+q+UERYiV1pBd44CtpoCYz00BHxc8qckFJVFFt6a1bTbBurN947Slq5z2hJAEWmeCNxsXu5HHjU1ycHaA4vvMQAeIOkGoHi5+YHLohvcNEyReRxVZyUaKc44j4uXhqrCdidiTsGQR1qNoMjMCnCtUafQkRFvYrht5paVTWLnkpP2FBjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1JGdh7Olo6KCowPtRtQnZT1EcM5AsrFrep9u9tAyHs=;
 b=Gr/VbMqQh9D/fH29+YuHKFGPmwnZoNlqHUeHHqhkZYdnoqO/ABtS0y373R/JVYyhaoPKPH6aGcF2eGIz/gu44zGmWYmISVwrKP7MiExSWOHhm83Hn3Qi6qPm+YL8VTLpR1RZOzq/mGXKhSZDeB+lyd5fVeH7FZEJlf5opKVPLz6uI3Ky+TUI99fd5L86yJFOaNinTGivqBdtuipx57FGN2BNmBt2QnvPifM6A1Xlhg3eImUtdFyj7+A36D0/Oi6W4ayszLRWkXsCr53zECEZ9aR5AWmmmkO0qzKk2VSRMIPHD2qdalXt/teTolPT9KNixfOnGgD4EMhrIdiU8VEZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1JGdh7Olo6KCowPtRtQnZT1EcM5AsrFrep9u9tAyHs=;
 b=R+WoHoy+oyY6OnVD1i0u0REKz/sPNYrd2X2jrgX8F1cDBj4HDXuXvp0hZzMwHOU0TtN5Q9JKre0/oJOF7XjXZF0+nPxoepN1e1tiZnDTksZK9XEBKn9myPhV8WhmhHb1zliLE9u4dsPCXfUMt6tfLq40U5N/Z4XbKaA5xHQMEbU=
Received: from BN9PR03CA0716.namprd03.prod.outlook.com (2603:10b6:408:ef::31)
 by DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 19:05:12 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::42) by BN9PR03CA0716.outlook.office365.com
 (2603:10b6:408:ef::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 19:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 19:05:12 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:05:10 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/7] drm/amdgpu: Cache result of last reset at reset domain
 level.
Date: Wed, 25 May 2022 15:04:42 -0400
Message-ID: <20220525190447.239867-3-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c305af4d-4cd1-4626-e3c0-08da3e817e99
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25041DA9514E1307E487A93FEAD69@DM5PR12MB2504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWCI8i+GfcU/HIe2AWpDrpKy5tBzDu+CJV0XwhFbHRvYeici5ETU9NhebBgEkrEcCh6gTWv6hNfqs4PQqzZk9P2XN6RWtVZq7p6qmD5+GTpD3zO3w+AebCZn13PDhRCO+oJ4oAY4S6mQ+eQGLrW/r5J5K0i6nuK9X3ejPK5mnMMMUieuDJbLD3eR75KuNfIwvZj6xZX9WytP2j0IyiClJIj5XemmUK1DBA0TD5qoDkOM6q1mRduq3/w2nhwAhL798sp9lb5j/34Nopc+DfJSlhanxQjCpx6apiRV1AIVGuTf+/hPCrSNthfEpX3pdaUIj5Q5Mw6Rs5G2UxVy88xH3zjQxT0wsBNJP7gaSReUmkGEXckJ8CYH+N/OUKy6pJdOAT2VXMBR3hx7TzKC9Qwpre1+119caGuBWSiDrYnRAJTNtamNJBhIEZcaKPTmlaaZjWsuYj36HWDP9zLFYkSQePMIjmD6+bD7IyWqvaOLoW1lDUEn80P9a0EVnNTm+0tkVvetPXL+uNyzPK3mOTFcZ+EGidfUq65c/iqC6wmobzA3AlJ4D1HJ27G+r0LRby9YCPy4Bzg9Czf9bc63XhzU+tBsFGtAi0HlWbSuZdXxEi9TGpUrVpL6MAYaTHTrx08fMcOON29tix86tBi/XYwPF1Dl40WZp9wZtEGoM4JweMBeAlccT/lyJbQF4YmdFtTi2CPBUQzky/BWr7LorDn6+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400005)(1076003)(36860700001)(8676002)(4326008)(7696005)(83380400001)(86362001)(316002)(186003)(16526019)(2906002)(508600001)(44832011)(2616005)(36756003)(8936002)(6666004)(5660300002)(6916009)(26005)(40460700003)(54906003)(356005)(70586007)(70206006)(47076005)(426003)(336012)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:05:12.1439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c305af4d-4cd1-4626-e3c0-08da3e817e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Will be read by executors of async reset like debugfs.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4daa0e893965..bfdd8883089a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5307,6 +5307,8 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 
 	if (r)
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
+
+	atomic_set(&adev->reset_domain->reset_res, r);
 	return r;
 }
 
@@ -5321,7 +5323,7 @@ static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
 {
 	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
 
-	recover_work->ret = amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
+	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
 }
 /*
  * Serialize gpu recover into reset domain single threaded wq
@@ -5338,7 +5340,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	flush_work(&work.base);
 
-	return work.ret;
+	return atomic_read(&adev->reset_domain->reset_res);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index c80af0889773..32c86a0b145c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -132,6 +132,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
 	}
 
 	atomic_set(&reset_domain->in_gpu_reset, 0);
+	atomic_set(&reset_domain->reset_res, 0);
 	init_rwsem(&reset_domain->sem);
 
 	return reset_domain;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 1949dbe28a86..9e55a5d7a825 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -82,6 +82,7 @@ struct amdgpu_reset_domain {
 	enum amdgpu_reset_domain_type type;
 	struct rw_semaphore sem;
 	atomic_t in_gpu_reset;
+	atomic_t reset_res;
 };
 
 
-- 
2.25.1

