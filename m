Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10843C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 08:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D3710F247;
	Thu, 14 Apr 2022 08:19:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D7410F243
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 08:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pxb8C7iUeUM0M6ghxiTs/TkM5AeU0onddffutruaeSEAdsK2wFYCX16mNeTt+b6e5gdGyVNiKwXp5MvADdGV7Hy7nddD3PKPX5v0oVLltuM3aDmb1NpvuvaOn5FeMaF5uFxIinprn9VeqDdz9y9HMkaMJfW82D2vVJjxvupWjmesfcIGyWqdfkpwo24idwNsWUuMtlkWz7IWH70+clIj/aMDsdPNiSwjE0GiBFGmQtJLmr60ReuXBAJ7X3iPUZ8ap4c6YcV7XEvWI8PIpNQ++a3ZQ06e3c2fM/jwUFvLm5iPkBKHrnYSVlpX7WlyhGR+MQ9+bmHeeoZpulrjg0fN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFYi2KNZLjcIWvqOYitzcXJaOQIZPvyvsh+xcn8dNAM=;
 b=aOjS/8nmTSkC3yDWuU3SAIXygU5hRVxOby0AqEJYJ+25vcRccloI8NmchIccwXUQRxXVXnhat+oRJbq/mScep61cO7NDoYLFmZSlvjOkZ5J1ABb0SwJZdU9SfpP6BG204SCpoQyY3uDtdeuh5Qc04HPO9JznoeFCVyx/R42+ydj87nJXMh9pliA80cdNRAezv7gfoThhPCer88rn+uFrvmx/bwWqIci8QQi3BkRFpsrxstKy1CmEphfyK+SuP1Tzy9X6bfZKyI0hxPVfQBjpyYIovPXyY1xh4z4tjuooMsiIPLcFiaqn/lyhvsoMBHShh+QFWvT15hrYTog+k76C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFYi2KNZLjcIWvqOYitzcXJaOQIZPvyvsh+xcn8dNAM=;
 b=Zjnc2NSxvepby/q6n0fNZi9v55Ws3GDWc5Lf36sVF5ADOEtAIuNEt5dLn/SoS7l1MFvnrKfoQGTgPFrEU80dybsqSy04B1ya+yz9bnBEdHnwoBgXEGLydDl5kwg3if78HPJAannVol7IdSmw7qf2yFrjzVbq6T81Z+9vjFGDkZ8=
Received: from DS7PR03CA0285.namprd03.prod.outlook.com (2603:10b6:5:3ad::20)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 08:19:28 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::e1) by DS7PR03CA0285.outlook.office365.com
 (2603:10b6:5:3ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28 via Frontend
 Transport; Thu, 14 Apr 2022 08:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 08:19:28 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 03:19:25 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some ASICs
 for SVM too
Date: Thu, 14 Apr 2022 16:19:09 +0800
Message-ID: <20220414081909.796653-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb890a23-d7df-4e72-7685-08da1def7e92
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB418107ABCE894D9AE30E25A1FBEF9@CH2PR12MB4181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bU9GbkC5i5QalO52+VPjQn7xwT9MeWLL4YtIMLv3ik36F6iu69z1TaeTvaMvWye4E0kNwPMir5xeM3jOiEqQdEGY0aR9L3aUBDLlBRgdeqTnZ4Ll6zqz5ATEhZiqOBodhr8nsV5n/AnA7rXz4oFaVG5pKt20LkoTNDqvgOEDOKmYEN/4VBoOmHX6i/XiaFRGC172GZAMgo1aOrcgu9jeVDxADSc9XnUenkgmowSUy948DqSFD1+vqPvVqjMiTDVa4AeSH1Nt6S9NRGsH83N6YGt/LIJ6qsvyDI5gO7cAg2zpMxKidxy8r/oCPYuIK+IcM8mU1q7oC+Zslij6Ak9qbjqbzSZ1ZfcFDA61DbQ//WReXwjfCDcUp7Axy5F7FBXZfQxxEHyc1cAVviPQJ3to4BiMLNAjJTf+5Zp1veYW7iMmOKTMWKc7Q0tOVyzrUGt9jMCWjEgsa1OC+cYll8cRfjdi5xlweRHbjIrWHlC8XvUbO/DF7KvxUN/ngjO00QT/dzLnkLoaLFB24ZCAlusWfhi0xaw1zLKhlS3sVtl4ELrulEbVqrrM7gV02oOxjPK6/Le3LHX0wbBJFf91Gi6UnD14w6la2YXEx4Lg54gNjkB6jyRUlWc8kyFgsOyVcouudly1uKnHLgVvQV9RKLrouPlBlOB3nUOhWBwCk1k1w7pHBadexmkVq0Upi9it+W7J4TL9581MC/xgF1LxKoj0sNSTJM4oRYGg8wmUWBQu85cSr8KD0TMuX6i+SsPfHy8b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(7696005)(6666004)(70586007)(1076003)(82310400005)(5660300002)(508600001)(81166007)(8936002)(36860700001)(54906003)(47076005)(36756003)(40460700003)(2906002)(426003)(316002)(6916009)(336012)(83380400001)(86362001)(356005)(8676002)(186003)(16526019)(26005)(4326008)(70206006)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 08:19:28.3169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb890a23-d7df-4e72-7685-08da1def7e92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
heavy-weight TLB flush on Arcturus"). Otherwise, we will run into problems
on some ASICs when running SVM applications.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 4 +++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 91f82a9ccdaf..459f59e3d0ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	return ret;
 }
 
-static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
-{
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
-		dev->adev->sdma.instance[0].fw_version >= 18) ||
-		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
-}
-
 static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 					struct kfd_process *p, void *data)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8a43def1f638..aff6f598ff2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
 
 void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
+static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
+{
+	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
+	       dev->adev->sdma.instance[0].fw_version >= 18) ||
+	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
+}
+
 bool kfd_is_locked(void);
 
 /* Compute profile */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 459fa07a3bcc..5afe216cf099 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+
+		if (kfd_flush_tlb_after_unmap(pdd->dev))
+			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
 	}
 
 	return r;
-- 
2.25.1

