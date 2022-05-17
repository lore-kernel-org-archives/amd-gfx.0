Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4862BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3673011373D;
	Tue, 17 May 2022 19:21:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8755A11372C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV5slTrziKIgvNTu7xsA4K+HoJ/u3/dTuP/48qQwG232hSSViaNnMw5nSs7i147te25EeQQbInqL5SDo5yDnf3CjcSxjPy8UK2rY1W2IINgkQZquZo3rp1+dwtf9A41nwc1U8P3nIXdKlCOPaAZxvA6bbl+KD27YWCNLxFOdTgwZaTUfBNJhZC1sgeHE8bj+ZzDIfN6p/Qh1er7/2C2fETXWooaj9sPaCYkR+PCDNfa2uUcCNDhmvFAM4F6Bu6ZHGGflz4g59+yhfteF3vHQnDmgd6cdHLmhmsWitYeVaNk6JP6+aHibgMQWufXpn6y8xFcq0HhWCDe6v/FxqV94kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf+qw87uKbe3QPWfdTKRUqwPd9zVSxjaHfDZ0RV5QY0=;
 b=dakz3UNb7Bh1z7us+s+KANe/tPmJsqcvTX1pNGiZf5RGXrsGeQ3soKySAH1IIUgudRalvO4tyKuhCyoXAahKHhsk6jvNUyTP7WWUVWKn+cbTTD4sLSjJcHxArPo0wdQWyoZWTya26rEMc0SrqRPGTYoigVlJ3c8xMK7GanFXt35CcXf/lRv6ivwSXkdeXs8symOKGZACl7TdTpjyLKkT2GkvH+GYCdDxjIcmlkml3Li4eOyf6BzcsUmN+EQkYQOVeDHTgMKxwiuH80CQTqDLu7X7qX7v3n8mA0aMcndHzBHDTrxoMBFItGLV3nYacXI6n7G80eKd3UCR6NSuXITzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf+qw87uKbe3QPWfdTKRUqwPd9zVSxjaHfDZ0RV5QY0=;
 b=HGN/foYhu4z8xqpRQ9RQqX6E7Q8TP+FcJgxiUCn3Vma0rF7+kx0i9l1GU1uimTmih7jsSw/7Po3a4HI0uJwFTChq35brxqoMYyjwGJ6FUmejMBitUPFSdARm7DkfC5hWHztF5r9p8Wx6+cMyMp5N//68FLcW8d5ZJiB6etdExnc=
Received: from MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 19:21:27 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::fb) by MW4PR03CA0274.outlook.office365.com
 (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 19:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:21:26 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:21:25 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/7] drm/amdgpu: Cache result of last reset at reset domain
 level.
Date: Tue, 17 May 2022 15:20:56 -0400
Message-ID: <20220517192102.238176-2-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dab656c-9764-437f-512b-08da383a6fff
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5141D7E39FE78817DC3B1CC1EACE9@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uikFCreCyT2hT3BylD5Gn3bucpCuNBSTWGijpD+ypuSatLLY65l/WnjZbvyL2aecvwFhGvY11kfep3P436rwOnPYSq5JGY3kijGlDtV48qG/hKPJsZKQdsyGf/lkdJMn4rH0UWUnbWzKE8mEnNqzNfYSEEcE2+1qF2oQsLa2Mkv1gnxWqBGFu7wwVgVMJKD8wfAphTtmmvf74X1ndya3ezQT0yk4IE2JiBJHfQdPvpFFa3IeUGhZe3TEGSP9xx9SX6BqWNxbWA2AYGYKhW3HKcD03X8DL20iNgrg6WOf+mYJ5+42ty8oPPfeQF5jaBo+Y01ttyEXs6kFJ7xjnb/KhEOSiMQ/I7b99sBmkgDPi7iiD7kuSyjzm4XXWnkgYOyHheMYOHCIte/YwephjtxpnANzDry9RVGJzfEDO0Lhhb5JJTWYgfyPK/G1GiEa5a7NcKUBz0Wp+mnV936iTd050nXRFZnFlIvXCEzIRUNUtpUx/XIVNRqm5WYJzHeQ79IGHSPx/tfNfC3zy+gqFvJ0st3/+LBZ4pR/wZIL0PHY+vT9z9BXl6hcubNLmKJ1EH/q/MaEo8Xe4IjaBhjWl3mjSiaqo+hNdvn+/V0yAQTlCSFOyENPp3yJEgXlIPspGE/WUobDVJguhJV022VSgpZU8uq1W66V6K4MrBJMipEUPIboeQ0uNOPzqvJ3u7P8T2GGmIzfz2TyN3IURjFxBvZvUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(508600001)(7696005)(316002)(70206006)(6666004)(54906003)(6916009)(40460700003)(81166007)(356005)(8676002)(86362001)(4326008)(5660300002)(36860700001)(26005)(1076003)(336012)(426003)(82310400005)(47076005)(16526019)(8936002)(44832011)(2616005)(186003)(83380400001)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:21:26.2733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dab656c-9764-437f-512b-08da383a6fff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
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
index b583026dc893..3948e7db6ad7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5303,6 +5303,8 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 
 	if (r)
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
+
+	atomic_set(&adev->reset_domain->reset_res, r);
 	return r;
 }
 
@@ -5317,7 +5319,7 @@ static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
 {
 	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
 
-	recover_work->ret = amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
+	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
 }
 /*
  * Serialize gpu recover into reset domain single threaded wq
@@ -5334,7 +5336,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
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

