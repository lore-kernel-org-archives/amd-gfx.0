Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C4D597C8
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 03:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E20610E259;
	Wed, 13 Nov 2024 03:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F7ucZTWJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E21210E581
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 03:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I73oa8epq/fMj7HA0ypuimnG9foryGZg7ABe+xI02wWnH0d04K+2ctO/OtfkiwZ6GOSp1vl4IRWFZGvglud15chccNtP7/bwlIN5d7QqwzyS/jbw4S/bxJWQoKsCbaFiz2HUe7Vpa4TRFYJR312YaQk81Wt75tJHyMofnnGhn5r4SU6ppY7qVjMBXpJt5wwYZn/WgffwAlkrdkKe178vreqE6O4WL9AkZBQ5mtndHBXYOQ8fJl1ZvWwVp9xZaXDSLCxSR+wcsya5chkVoP6LtJHUk3BHnc39z0S6Pk8s7jK9KjxFf2KdUjeB+AhiUdjXFcg3XaoQ5vnGbBAg3NuY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S30sf45c4Wwhf0CJpt2vSzLzGkmRNMvXA1vTXaJdLHM=;
 b=vVWx2EVHfgtASeCUMBSpewwVZiDxhloy9gzKDUOyFc6XXw9XQ/jK9xP3LbVqD6ax44fnmYlGZRb3RkChy+Ue+Flv77bwkJq4fWG5A/tLGqxpVvApptY+816xFGPo/ezq4wWHKdShDhTPADqz47TS7G2HKGkNrXQJy/mA+4T9uL0oPDoq8Zdp50hVOOQnkluyvzH1bXwLp2XFKuYF0zbqIbOpCMG/V3wJWhhX6XhIN2QpmRVQhmJAYeY3rAa4zpoBM6vnWxiRPkoUtSDT3tqlwddAifnXcmAffBxwYs7Sbnad9252mQUhYSJ2cevyBZ/soE0FLcSkpx0LgAbIWwn1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S30sf45c4Wwhf0CJpt2vSzLzGkmRNMvXA1vTXaJdLHM=;
 b=F7ucZTWJNCq0sl1jcrvX/RsmT84lvLxuFqs+7GABR93C9N38rIzrTOgW+MvxPeLC48w2GJQdtl69VzkhZZlIZfe3Zih58mqdwb3fFGdFv5wffNq6vE1MJLwO5dm1fVYem88EeyeOf0DJh/NK6t/qTWEx0JQxuWyueAlQsc2GDJ0=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.26; Wed, 13 Nov 2024 03:15:04 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::b0) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 03:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 03:14:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 21:14:21 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 21:14:19 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shikang Fan <shikang.fan@amd.com>, Tong Liu01 <Tong.Liu01@amd.com>, "Emily
 Deng" <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Check pending job finished or not to identify has
 bad job
Date: Wed, 13 Nov 2024 11:14:11 +0800
Message-ID: <20241113031411.698366-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shikang.fan@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f457bd1-65dc-4949-736d-08dd03915dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OpPPEd0H2FaCeOWww7Q4eUgiFzW++4KN5F5n/GBE2NfpB6SjavElrqqcU0Tf?=
 =?us-ascii?Q?t0a5YXHJhoDR0D1xOiIFsIor2m5WuMApGchZMp8fvB/rPMWghvAFfq5OftoG?=
 =?us-ascii?Q?dDPUp6PkWNrrmufzYc0eNDXi+3I7uiQYj+ns8mUFFV0a0lG1lb1uMVh8hjWp?=
 =?us-ascii?Q?wG1wZwp9AvZka4BY0Mk9RGoMkqlDO65DNFFA6B0PcIt+9+Fp9YN2+PcjMKrI?=
 =?us-ascii?Q?oDZoBDaNGJqFlRBx1SvtXGzrZr6E/wHHAB5LjJQu6XLezKMDMl6grsr794au?=
 =?us-ascii?Q?j7F5wyR9oUQFGlLXFxaxys9CFjIwVF/2zlUlKMThJoCNVm5U+u9Yp3PWC3xw?=
 =?us-ascii?Q?iP40I4E6gbOx3EujsJWI5VWLwe78+rO4y2y6HdsF1nxbPjs9REtBEyW2JeQ9?=
 =?us-ascii?Q?vNFyIoFacEEkDDamnI4rzQMjGChLWfiGWhJViTms4pbIEQvdZh04nfCfcIBz?=
 =?us-ascii?Q?qeYS4U5zRi1ZPU/LUa1JQsJm6QnUi5gf48+m0OpnSeXNCzJXTQZVBMLewWTz?=
 =?us-ascii?Q?P6LnIkuvK1ba3ZGRaX/rXnGxIDhubkoRmReEYO+Qt5p6Nto9ftuCX3iODZk6?=
 =?us-ascii?Q?ayTAtzE1ZiVWPaJ+VKfZMhMnnGo4pHC+OicoH2xhnBna0ZdsHVvmvXUqVxH6?=
 =?us-ascii?Q?TVv712VZTxvJqDtS/mHNHZZjPioKpslZcKlnrJ4DXdsDUgtQET7zjylrq6nw?=
 =?us-ascii?Q?JkjpJ4AN2IzEgKOJ6iogUJnftKK8u6EPd3G57Jy2u6Ws2nbLL2z1CNPNmQWO?=
 =?us-ascii?Q?jk9ipaSL6X+WOlMCRo56cvkLtEWZxh21CA6RvHektJMmtECB4i702JjnHjjp?=
 =?us-ascii?Q?skQiVaJmvyBboWNOCfYyGSZlhSvCciFX5gPBDs0/JJ0Ksp3dvb15o3DWPUrD?=
 =?us-ascii?Q?ZDKzZGwwIl8w4GBxZv3WH8+iYfE9N6kuikh8xecousW4BS7/f4+HjM3gwDTl?=
 =?us-ascii?Q?3OZDfjT7HTJLnpplzicG/NVC1QKsLbTtKM5pqzDH7g6nA9njPPAMqQv6IkJI?=
 =?us-ascii?Q?QEIZnQU6QXuGDC5iMWdpk0bSHU0SoMfk7zd0GNQ26Y2aLIkb43TU5HyNQoal?=
 =?us-ascii?Q?2z23APacLSOMS0is0wtSZg908dR0aynuFNs7F6EpBpQM4kx6vihJ26AdOqHi?=
 =?us-ascii?Q?AIA8pPGSgPTwI3XV1mMrhQ23Jnmk/nVTr2C6NFzTXFruR3PGrQo6GMPWZ6aO?=
 =?us-ascii?Q?+qY5EGoKwEVwgQlVEarDzVRKSY9i4HXxnKcq1/pJsBjjRp7mhhaxjaGbJliS?=
 =?us-ascii?Q?jraWOG2Q6El3kAq5ARebScLS04uC+6zp+1k38dmg+KJLsPZ5EdXSsaeFOcSm?=
 =?us-ascii?Q?uY4EuA1VAuwefUulnMzzGJ+v3bHje/rZ59eoXbdll20XBIw70ERil/MGM3l+?=
 =?us-ascii?Q?2yDyoaJax6Rf99t+kEKnBhtG42gjycpjwjZQphgVvc5QTpWHxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 03:14:45.6760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f457bd1-65dc-4949-736d-08dd03915dd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

drm_sched_free_job_work is a queue work function,
so even job is finished in hw, it still needs some time to
be deleted from the pending queue by drm_sched_free_job_work.
here iterates over the pending job list and wait for each job to finish
within specified timeout (1s by default) to avoid jobs that are not
cleaned up in time or are about to finished.
if wait timeout, return true

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 071d3d9b345d..da2a22618f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -100,6 +100,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
 #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
+#define AMDGPU_PENDING_JOB_TIMEOUT	msecs_to_jiffies(1000)
 
 static const struct drm_driver amdgpu_kms_driver;
 
@@ -5224,7 +5225,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
 	int i;
-	struct drm_sched_job *job;
+	struct drm_sched_job *job, *tmp;
+	long r;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -5233,11 +5235,20 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 			continue;
 
 		spin_lock(&ring->sched.job_list_lock);
-		job = list_first_entry_or_null(&ring->sched.pending_list,
-					       struct drm_sched_job, list);
+
+		/* iterates over the pending job list
+		 * wait for each job to finish within timeout (1s by default)
+		 * if wait timeout, return true
+		 */
+		list_for_each_entry_safe(job, tmp, &ring->sched.pending_list, list) {
+			r = dma_fence_wait_timeout(&job->s_fence->finished,
+								false, AMDGPU_PENDING_JOB_TIMEOUT);
+			if (r <= 0) {
+				spin_unlock(&ring->sched.job_list_lock);
+				return true;
+			}
+		}
 		spin_unlock(&ring->sched.job_list_lock);
-		if (job)
-			return true;
 	}
 	return false;
 }
-- 
2.34.1

