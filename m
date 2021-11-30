Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69196C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D0B6F3A8;
	Tue, 30 Nov 2021 07:43:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626696F37F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYg9N3/or7EwDUe0O2acz4lcHKS9Y/Dyc26DpzI3CxyyIs8YK6K/D+rmCUyMjh8kL31GDKv1Ke2+Sr/+MlFqq6+SRjYbHfMDsvLfbJHReX3qHf5m1pKsPNBaNVjT6dzcpBfJcqF86pD4RG7A70p5gEIsXDU/lDARNU8Xjp09BNXh9HWikktmb56QPcln4xPPj56kcm7MGdaa//E8LQ/FW3MZsshZTt7m/Ur19GFafWvw2MJ/0nirmXXrgYwczJVXeNxmg4nSa3zg62x0pG2Byijapg6S/KYKkhf8v7JzmmGklFU0W2gjQn4nUFcIVM6eO8EWPh4d0PeFTOa+KhVjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxRqeYncmzWiqg177bFpUdNwAH7D0HmWbV1APy9by60=;
 b=JB8RPbbuDqYFyPqawB2TsA4vkAvS9RLwDGwqvfpS2qSc5n/3Kmum4e8xjEJoVVucSrje5ZZRPHMDetZUThFPQ8t5lOH/z24xoVg6OzI114t7N52IwsrLS18a0OFh0MBZlKL6IYeirxnd4iLFn/iMDEAZKE62AN23nv2ZtooxzQHGZdkVHfZLtfzLN74KFGuk5XbLDIOwuoxgrAuXxb4Tc96mlql53FKHhzNm5jJQwFw/GyCICJSVqdEC/wWFmVOdInBZ13Wfc/g0QOh1EYnjqBW7QrDZBGjqKOkGTPR0igz1vgHzIxm86doSINNlaFPRXoayVgvS7H/UL6Pu+R2RdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxRqeYncmzWiqg177bFpUdNwAH7D0HmWbV1APy9by60=;
 b=qCylo9ewAk7DATHlax1ZNF2ZTuxOFSMr7QCOYjyEAAtkB2TP2VS+Goa4fIhioRvzpTstMvdS4z6zE0RHhg3OYaKaSwtKKg0a0F0bZht6AEB+MTJPQuZJE6ybrkZUsQsajZf2ZeOz1gb7scIq9WVuY+k3qIr0P7fTX4VUVxchxiw=
Received: from BN9PR03CA0408.namprd03.prod.outlook.com (2603:10b6:408:111::23)
 by MWHPR1201MB0061.namprd12.prod.outlook.com (2603:10b6:301:52::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 07:43:41 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::a1) by BN9PR03CA0408.outlook.office365.com
 (2603:10b6:408:111::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:40 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:38 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 08/17] drm/amd/pm: move pp_force_state_enabled member to
 amdgpu_pm structure
Date: Tue, 30 Nov 2021 15:42:50 +0800
Message-ID: <20211130074259.1271965-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17503330-5331-49dc-c5c4-08d9b3d52091
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0061:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB006187E2D687924539B70E51E4679@MWHPR1201MB0061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfR6QPdwpV637DF+KcVcFwqgIR0tXcMV8MeS2hkO9DGvsePGVUAVUuL7MMSs48cT0T9690Y8Xojn+zHRK+O8he5kOrFVizJC9RAyXNWSG5fIEIF+52PRlxqcMwGQ+XjliKvib4zG7VRvSPZbHJi72iUQT1AP0H9+orikFx8Aue5cv9fAdInwsNg+4vD4WkuWDjV1hlHkDzl9Jisfq/4fkfcrtS+ak9TekI4LUuzxRyGHf4fKAVoD15t8WwBkLugsKq1teAw+8y8GjITjaiYKn0t1qAPamXuwoVTTfHkX1XvudfTW/qYov2r0zYlHpmKsxpo7GY1N8PepHG+8N1TCXx3qGg5DlwFzJBKE/9yRskIk3TrXKGgmHCHogz4D2LU91nICtQt5QMkG+ZqZs3VjKcDP28JHWaZBAkAHDWk3ROX0PhpxXKCeuLuE1yrmhRssNR3Nb24GrVd2p/jXu3MDEahqkZV1qhUPTjxa2WVinCf3FNBClwFLk7cJwUs0dT3JPiyilUQEQgqjoRu6CvUy2aB+MWB7lmVBAKvekrIVbDubogeGPuWOU5iRUddzzgl1Kjm/1YUreQSouVRQGi4317/dyhcxrttsJCbqt5X4Ii5YQLWZ6H9tojlBBO5ygRmDNbSEQ/03spLCAbijpL5uYJ45jpFvXEG6ccdI+HVpfcV95qlLDU6+yteuAc6CYHxvxe2FthraEt/ICy+CukeGKD5Jo7iXh7jz2aA3avAg5BSA3qp/RexGG1HyRVFNNEmuNa0nVnbTv0hzqNEwXSBqaCEAVpbeF1Nhc76DJAZliiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(82310400004)(316002)(5660300002)(36860700001)(508600001)(83380400001)(86362001)(47076005)(54906003)(336012)(4326008)(44832011)(81166007)(2906002)(70206006)(6666004)(6916009)(1076003)(356005)(70586007)(26005)(7696005)(36756003)(186003)(16526019)(8936002)(8676002)(426003)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:40.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17503330-5331-49dc-c5c4-08d9b3d52091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0061
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As it lables an internal pm state and amdgpu_pm structure is the more
proper place than amdgpu_device structure for it.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I7890e8fe7af2ecd8591d30442340deb8773bacc3
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 6 +++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5cfe2926ca1..c987813a4996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -950,7 +950,6 @@ struct amdgpu_device {
 
 	/* powerplay */
 	struct amd_powerplay		powerplay;
-	bool				pp_force_state_enabled;
 
 	/* smu */
 	struct smu_context		smu;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3382d30b5d90..fa2f4e11e94e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -469,7 +469,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	if (adev->pp_force_state_enabled)
+	if (adev->pm.pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
 		return sysfs_emit(buf, "\n");
@@ -492,7 +492,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	adev->pp_force_state_enabled = false;
+	adev->pm.pp_force_state_enabled = false;
 
 	if (strlen(buf) == 1)
 		return count;
@@ -523,7 +523,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 		if (ret)
 			goto err_out;
 
-		adev->pp_force_state_enabled = true;
+		adev->pm.pp_force_state_enabled = true;
 	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 295d2902aef7..1462c4933ca1 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -335,6 +335,8 @@ struct amdgpu_pm {
 	struct list_head	pm_attr_list;
 
 	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
+
+	bool			pp_force_state_enabled;
 };
 
 #define R600_SSTU_DFLT                               0
-- 
2.29.0

