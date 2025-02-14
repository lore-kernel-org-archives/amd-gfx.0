Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E5AC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B15210EBF4;
	Fri, 14 Feb 2025 08:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B5PbuXAy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1618310EBF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPM0Hx40l59HKm+3OPQmNBfXYSdl3kJxKNtIcWxOFAmPk2pMJBF/g5hiw2taxZuYqRwgdf595y6dd+pdbz1LB7scaS8AaBh2Jtgp53ZhUPSku1EQOq8LKYFoVlcjuWVrYKe+chbqVoGDaWdOS1a1o8M4VHlArTTBz9i25JexO3sEofxb6Ipd8UJb3iGlaejLc2BpcpOcuhiXn+y3RM2ddvJWUMA7w9S3rHwSL22TrfbRj6bZiM/GQz42vZqieMaj+80MqYIelPji3XD+kTbF+SxcOBc2/pBYbXtcjgeBldeguA5uif6WoD+8VRGL+G5acwRsG97jsMFYKD27J6Eh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FwzTI+lqSSYia/yhcT7AU2f0FCrAbrSv5fqx0srgX0=;
 b=Eg6pwyfZdh706uXiXzOx5a6eo0AZ1JRR3WrtnFo/GCMbciSUfdYb6dkTKENfmrrrImgu6UZa7leOAuarWpW3b2qiC3tKoIZlTEZhIkJPHEgkHv4E6C2Eam4rBRfu8KCPtCRKcpWiE4W+aXMlal4/MW+vka+Ygjn3P7k/VArbC+ZpOR52TuYc0TNi3EmMt601bo6Uq4A5/oyya2nH01t1KJfPhyenUjPU26bO4fKu3xQWabl4maoxfwO+lw6HIZ3QVzbPwsDeuIxkxNrTn41KV7QextHD54H3WySIdveAM8pDq0MynhhkTFjp7MYZ2tliu08N4C82179wP6vYyEGrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FwzTI+lqSSYia/yhcT7AU2f0FCrAbrSv5fqx0srgX0=;
 b=B5PbuXAyZvSgqzm5He74CPP+GR3U2lh+Qd92Moj1B+uUUMv4SiKpMuFBDm7jsy68XmDKi4eC7ppTvT/3X7K2N6i05+k5n/xR57T5bwWNMKL3sqTu6+/lBQnpgCMwgx2dyClQaHu4TZee7u219nbboQWY+2RFqsUpP1t6tDAlsLw=
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 08:08:07 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::66) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 08:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:08:07 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:08:06 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2 12/12] drm/amdgpu: Generate bad page threshold cper records
Date: Fri, 14 Feb 2025 16:07:19 +0800
Message-ID: <5d25ca3334b9799ea60822f4bb4498b2ba12827b.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c634e58-8ae8-4e63-3c97-08dd4cceb74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pviOZ45t/cX5gciQ8EOELEst2sDNtOSHup8zPAmH6qZTvhLSIySvmlGkDpJv?=
 =?us-ascii?Q?GM1ER4/6kx8TF3YZe/q5ZAxrcxIHTscKfBxlkgkycGUWa2zyPiOk+XVY+0eM?=
 =?us-ascii?Q?I+Zoz3aMRYlHM7kITGFWM8VvPvA2InVwyNKHlWxg9gSYoRiYcFU1VZ1gQ8/I?=
 =?us-ascii?Q?5KBiC37MQTQcINqC1Pq8V5kKO18FF3nJ1vL+mRvP7GERFz9fMgvk3UddUUW3?=
 =?us-ascii?Q?xqsRJ1Kfg98P4/jDHE1X5gpW/fNJGjBqdFuL8QnsELKftpfalEijo7VC38E7?=
 =?us-ascii?Q?gF8x0CyA2tKAbpH76l12bfIFP0xuV7eoUhLiRU6jSKFl9/Y875157BODNJ3i?=
 =?us-ascii?Q?hUhLopipowUQFhtgYjz4zSK+SnbUKVmCjH1WD1yNcIxYfFzTgAAw/f7OjpSj?=
 =?us-ascii?Q?pQA4K84Un4miaATuslA9gSW2XdKnxeg+BSvGakSn5VnI3cshgbefAZcGUYOZ?=
 =?us-ascii?Q?s4K7ysPW6cxcF2GczTxl09UdCD5DNTD/USKF00e6Uh2CktweP0XDvPYeesnJ?=
 =?us-ascii?Q?JHQ9CDfPqUM1YaZREo9mkijjssJS0EEyh3ScYAHc9t/ALYXLaes+WleIYx1h?=
 =?us-ascii?Q?YQWmk9g1f1Ul8SLvl4og95OrxJf/kV1UVgQ18Hn/yc+Dq4hM7UNpr0GpWoS/?=
 =?us-ascii?Q?19CqHpES60iHocH++PB5bMAXdOw9+/7O+zg/6BygohPR+Z/HUhf1UaEHV4xQ?=
 =?us-ascii?Q?nbG8JMvdbjv0PGDo3uJTusr6paVhZRjEQCcRCOk3ZWYGPA0Q43vKvCSTWXg0?=
 =?us-ascii?Q?6KpPN8dhSeL8vXoq6B+FzKlk1O54y3zTQKSzb/0xbZIGEAL4rDUbSK/qJFZY?=
 =?us-ascii?Q?3nIriXy+B6PU2EV0o0SnhcWXP4mDx2udxRGGjucC/cIheXunERn250yhbFRp?=
 =?us-ascii?Q?9QNMqYiUFwXfVvbsyx3hxCTWmpWATVMkq+qRBVErNRmeLg4XRs7M1E1YgO/7?=
 =?us-ascii?Q?A8ORNu7BDFf3Ex0JCw29KS+GqBSmcxizpLbdIT20eOA99MaKgzhCkVbdKSiN?=
 =?us-ascii?Q?ej0vvWtYDZWW1SaKqoUS1fVGWEIqiTx6TCtGpjJ7BmGZZH5RPU6VuZIiNulj?=
 =?us-ascii?Q?o8ZgSJ0k8l3jJMGoi9cqVRk6C5UVlcK7E4gvvjfm9WWjjsQmUMyWOImdqEIL?=
 =?us-ascii?Q?p00O8lfApBnZQ4S8KLdpqjjrhKkqz7vyyGNCNpjtp1sOLms6z6CbgrUEJVyb?=
 =?us-ascii?Q?Lp9reE27gqViQHzuh5B+OzbEuuT4RQZF5dci2/72cbGTxzgUTfsYBtEjOyEl?=
 =?us-ascii?Q?tlSoNhrZCVqbAiF1zueew1XxGbDc6zN3gnrQrZQZwL243/rpru7OKNIbxDcb?=
 =?us-ascii?Q?VCeJZTWQwan0gkvP9tH85w5xzdTFmjPjWBn8FC7jBhEs8S1W6EdNdYccpneO?=
 =?us-ascii?Q?hpLgMPxeLbcQ60vvuRnODGE/BZ6h1wr3GnCVe+dQY2qN6A7ogXUz2hYUC/tm?=
 =?us-ascii?Q?0BSSPlF/P73us0BVt2XBBDO4+SRMjEXpS/WbMXWiV3CrHbO14DzWuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:08:07.8119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c634e58-8ae8-4e63-3c97-08dd4cceb74d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
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

Generate CPER record when bad page threshold exceed and
commit to CPER ring.

v2: return -ENOMEM instead of false
v2: check return value of fill section function

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c      |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 00f953ed6740..67ad26c5e6df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -308,6 +308,29 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
+{
+	struct cper_hdr *bp_threshold = NULL;
+	struct amdgpu_ring *ring = &adev->cper.ring_buf;
+	int ret;
+
+	bp_threshold = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_FATAL, 1);
+	if (!bp_threshold) {
+		dev_err(adev->dev, "fail to alloc cper entry for bad page threshold record\n");
+		return -ENOMEM;
+	}
+
+	amdgpu_cper_entry_fill_hdr(adev, bp_threshold, AMDGPU_CPER_TYPE_BP_THRESHOLD,
+				CPER_SEV_FATAL);
+	ret = amdgpu_cper_entry_fill_bad_page_threshold_section(adev, bp_threshold, 0);
+	if (ret)
+		return ret;
+
+	amdgpu_cper_ring_write(ring, bp_threshold, bp_threshold->record_length);
+
+	return 0;
+}
+
 static enum cper_error_severity amdgpu_aca_err_type_to_cper_sev(struct amdgpu_device *adev,
 								enum aca_error_type aca_err_type)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index 527835cbf0d3..561e0a43b4b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -94,6 +94,8 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
 int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 				    struct aca_banks *banks,
 				    uint16_t bank_count);
+/* Bad page threshold is encoded into separated cper entry */
+int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev);
 void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
 			void *src, int count);
 int amdgpu_cper_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index ba6e44951e57..c7abc0c4e87c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -716,6 +716,9 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	ret = smu_send_rma_reason(smu);
 	mutex_unlock(&adev->pm.mutex);
 
+	if (amdgpu_cper_generate_bp_threshold_record(adev))
+		dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
+
 	return ret;
 }
 
-- 
2.34.1

