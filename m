Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DD5C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D3F10EC1B;
	Tue, 22 Sep 2026 09:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWW8CPvS";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF6210EBD5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFQyuQO1NLOan5WElFiNq2sqawCMYwKfaP4Ykx9zLtDV1L2e0ql3jXJjc7BEdYTHZn0TxU4Oj5AQessc0b25r5debbebZeb5db+n+St/mjRWxVQyJ3no6sJ2BEXoA1RcY5J76STr3b0IA6RX42sTYKGh1aMgfAQPN9RMGHB4IBC3iUdPVNw5OWbogUSP4uWqJK1/nBm3XiuWWawcpnomnRvE1A02a+uVdF2vL+K4TAoeuNZu7pzILseEDY23OEX/mIR76z1Md+4qZxdQLTQkbU7jgNc0abosRxjUDIQvhBFeTCN7s6DeE46NaHi/oM7qRnO6U5GFwuNQS7Cb+cBdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5wDGRntr0jAkG+a+YvT6lrvv0ApKlrNeErp4lVRsCc=;
 b=QGccdZH0x2WU/gHaNGiATIphwJUpcgR6uOdqq75IaXZM9hzRuvwI397K5msYER7nR0SG9PlPg0y8kXmG4pOocRH5PA46LpcQPvJKxKj+bTKfPyucAPsgPtuFs+bxcJJ1NC8N4BtfzTDy4Je8L3hzxSb72i7r2XGHvowoJly6vaRz5zP9yYVaVeBzk6TYpaZ2g3AkjjAMcJtxXaLnv7ALRE+3eA8uya3HEtpbXRshT1Os7CbiDZB5kN0G03uKZPuGSQwTwWof4G1nd2ssW69P7Ets6UYz7AwKYEKc84D1hQTydUOPd64hfqILyoXuQANkOT6qTM7Q+1ByO11ZAGJYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5wDGRntr0jAkG+a+YvT6lrvv0ApKlrNeErp4lVRsCc=;
 b=RWW8CPvS2SOKc7iV4BrMCaqWNG+StaUsZ6CAfsTbnsHoLBUt+B4vKzPhs0lQvzWetuANHte0qX31Vv0NIExUhjWWUa9AOCCJGqrXsS4lN04rOjv39AmlnbenzekEK2AT7nIXRFW3Mc5x+HWgxRsWAnIw2m04otm0hAtkh+2y8sQ=
Received: from BN9PR03CA0548.namprd03.prod.outlook.com (2603:10b6:408:138::13)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 09:34:18 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::18) by BN9PR03CA0548.outlook.office365.com
 (2603:10b6:408:138::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 22
 Sep 2026 09:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:18 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:16 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 05/10] drm/amdgpu: set device-wide PMC enablement indicator
Date: Tue, 22 Sep 2026 17:34:31 +0800
Message-ID: <20260922093436.596947-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ce8772-57ca-460d-0fb9-08df188cacc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|11063799006|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: CxMz0b6i6plOke8SYHg691NBO+qggOBTP7Ul64+bvmKWCdr6VrTZyR7fDofvPqfVGh1X+m5RmTUm6PDcx4Zaxh02TcdPWCuEWZM3klFATcoKe+0qTmfVT6lB1oIvZSw90H9gs/liK/DRsLSjLUOL6R+x5a3rPYuJRw+5GGN4cQoqRZlK/y7c1sujHChfIn+axB+QUt/DZ7n8oTmrediXjfFSxz6NReFx7F8JBcH1qJh5goA0PM8kbUbXeNQE/GrrGXsAsfFFDZNT0FrXV0tlDvY6FgzyXya+V4plGmzC1vcAP3fLc05+t1/WFzy3Do+yew3NkFIoCjSYLl1MfyATE1qFJSFyaTDs1Th9t3oz84rzWCf+N5xy8fLF45dnps/enr7ciSnvHSEaENX3W7KT1dnRztsa4Js9ecc0A+YnOJ49FkQbb4Ie6nzRSgwGJnRlIC5kZEfC76/tu21G98cSB+qihW6IzXWtuzkBivKZnuaP26kOyzrOzIemXvL+qxl6mh7ICbBk7J1cWD3gaNyyFwkRFgq0dqSk17ZbaRL6B4+boUkxL6rcdH9IF+s7l08W6DOiSzAut+5CjNYeRKvKFzt0H9lE4b7qEc3p4W3DJsS5F/5s/SfR2Vt6w1KpoCreupBib3z65jxld3bgndXl6zsGmp30XaESUTvpevMwynStIPWPzYIPEM1vQa9TLkS+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1eDtBYYLIazjNYCVMVW7/Ac0HDhdcMlYNKd+7Xq7OK/vPw0ct6o+jF5TlrjzGnPkv4+heoeidNeYGbKqiKVoCKJl/TqiQ9dd0IcHiaF8MkVK1Hf3IKXE31lQ6bvf5IkoIonCv/DbYoiOU9tSRviZrxqVWOclnq+PHFa8OgnBH/BuyHKy3J1iGjtR8SMeYN3lfjhHorqd6G5gukE8voOevSj2RGFeAj0qA9EV6xL4MsqNhNZzekhpZ/dZGlMR1ikTIYwGAG4BaAc4TEvSKteygsk47Rrzv2HpL9mDZxMs8ZavCroY91cPfMkb1shteV+q9k2wczK6W0FA2U8YyzBO7FqVf44lvuLb6xnq9FUCNS9PrDlRIf0k1mow5syngq8HTK12IXWibJZpYhJLbb0HhIBsrx4U8unIzyCW87ESpTHOkwEy6ZK4Xp18AyxaaBe5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:18.2674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ce8772-57ca-460d-0fb9-08df188cacc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit introduces a new function amdgpu_profiler_set_perfcount
which sets the device-wide PMC enablement indicator.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 23 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  2 ++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3dc563a64639..5b86fa50a95e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2988,6 +2988,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
+		amdgpu_profiler_set_perfcount(drm_to_adev(dev), file_priv, false);
 		amdgpu_profiler_release_device(drm_to_adev(dev), file_priv);
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 6464af0d1b10..254fb8d77d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -77,6 +77,27 @@ static void amdgpu_profiler_clear_reservation(struct amdgpu_device *adev)
 	mutex_unlock(&adev->pmc_profiler.lock);
 }
 
+int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev,
+				  struct drm_file *filp, bool enable)
+{
+	int ret;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.owner == filp) {
+		/* set device-wide PMC enablement bit,
+		 * new created queues inherit it.
+		 */
+		adev->pmc_profiler.enable = enable;
+		ret = 0;
+	} else
+		ret = -EBUSY;
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
 static int amdgpu_profiler_check_access(struct drm_device *dev)
 {
 	if (!perfmon_capable())
@@ -120,7 +141,7 @@ static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
 	if (ret)
 		return ret;
 
-	return -EOPNOTSUPP;
+	return amdgpu_profiler_set_perfcount(drm_to_adev(dev), filp, enable);
 }
 
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 048ce84f0ef2..532aa7881191 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -30,6 +30,8 @@
 
 struct amdgpu_device;
 
+int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev, struct drm_file *filp,
+				  bool enable);
 int amdgpu_profiler_release_device(struct amdgpu_device *adev, struct drm_file *filp);
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
-- 
2.55.0

