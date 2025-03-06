Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8CDC19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50AA410E87F;
	Thu,  6 Mar 2025 01:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0onSxG+A";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDA510E87F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpIaNUvQXgliCr5gqzYdwZU4+HF9Ulkk0VD5Q/b5drcehoLZiJt+N4TM7N3tW11daz5IobAPzbt+JQKhnOMlU7abD/RiCGVcgtcoqd10isC4ViIq0UFG4/7n4wlJh2R1/TP+WmVAyn+k7V++dODpJubza8hVIFtwq84tiiCOZsPlDMMItjB6FE6Wm+25yC1UQze9GExBvpEjygvIbxadgZra/poEl+r/NjHuOGLOkomHeXLyC7l0e2CEm2bVR1NpFdlRT/xF5m1gl+yoNUrSLeWVduBkicruiw1nTBFowJwppz26krhvILCrGNnJuIFU/tbAb5P9kquPefIIyBFU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIJCZyZLpBgt48AXLx9N8D+/amiBZRwQavMsHbneqoo=;
 b=Fow9Jh2zByhuoJD8DziP8nxBpm4olpHFEatfKR/SGg+6v/LvvjmBlxVR/W2E1X+NijLu7iJpreXrnAz6WCabKcfG/5bCrDT6ktKwoopNlpkjWX5nTiZEZ1u+y+FN1aUU+ypqb06eAATu5HAlwVX1UhzPCLCK0UXsTKR2AGmcV16Ly0kkA25PEnUtlnMl7QV/0mu4rpYkrcWV2ufmOGtJmhd4Xq+BCrtOMva7iHH0qfdsXfWJTDvOTHhsRvgsdZfo3qXWdc0ohM5cvL8on0+na3Bpnc5Z58uj2BV9pHfG1OhariB6xHS26GRSyQDycQ6BWXHvbzIMleJY3dnt5FpheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIJCZyZLpBgt48AXLx9N8D+/amiBZRwQavMsHbneqoo=;
 b=0onSxG+AOoMA1/GfAufMWCXBOQAF6VM82UvlUpITE8R/XESLnD+Ttc1vIXg12D7w3U+wRO8UuqQFgbo6gez6FHCWj4yeOFbwxmYAGJ7Xr5SvUj7chHKL0tdYx5IrtGR0oKvaxYtWr2VRUrd1QABF+msSRy6z0b3lDzdlakBem+U=
Received: from MW4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:303:b7::20)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 01:10:28 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::24) by MW4PR03CA0105.outlook.office365.com
 (2603:10b6:303:b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 01:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 01:10:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 19:10:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 19:10:26 -0600
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 5 Mar 2025 19:10:25 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix the race condition for draining retry fault
Date: Thu, 6 Mar 2025 09:10:23 +0800
Message-ID: <20250306011023.3220173-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 87553a4d-4346-41bc-846f-08dd5c4bae89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xwiRbPG9qlEGRJcpbiIhmSMNWyB3LkFyO+wFBC4Qf8gucLyYWPOnwm3bNdsI?=
 =?us-ascii?Q?arnGbwMoBm4gWOAdUXVE4G8jJHcta12vyl7wl7uYT79Hz+u54kuHERHBkx1Z?=
 =?us-ascii?Q?sqsYeP1x9Xrse12R8XiFZRDppIegm+O9DiWY5C3v7q6Yjr1R6Foe4M117EkD?=
 =?us-ascii?Q?wgT31e6aGkQR7TXRz+cYDwNboJ5Zubc6ff7vKq8QJAsdgRn8kQ4oBzsPzgEw?=
 =?us-ascii?Q?s0piy43Sb0cfQqXv4tfZRVvwe+AlinRm2amh4VUOz+fVhJNJdbzsDq4NjGUI?=
 =?us-ascii?Q?SD5jW7zAWGtARSX3W3mKXBhNtnRGn5sepAzWcHFecbJnCLbTbxmX47kRq8j8?=
 =?us-ascii?Q?ruBMALA7g8PZXTENBHOOM+/uTBoof++hIMD9PIGU5L4IMSFwqZ8hYOcJCumE?=
 =?us-ascii?Q?RtuX+2he/tE5AcYoFEtaHoqHHlAfWYPFdSwv6vpIMdy7Lge422WsypRFjw5D?=
 =?us-ascii?Q?5KIap6pRdFZ+FTabfgZkBn7kjhmNLvY9oIvZKXoqlxypuw/YtPHbrVfpOMSU?=
 =?us-ascii?Q?biJcCQSBHIyFDgJ3DfEfxgi4xA0637Szsr3HSEaqpwCgKby4cHgkXAZXGIeX?=
 =?us-ascii?Q?iu/mZe78rb9nwLZJBzHDfQoVV0WvlTZlpNaatejYaOoBCb4lRMJstDBfrscf?=
 =?us-ascii?Q?zX6qLJ/TudyBSSP7d/G9tTkdGDJtykDLTNv0L8tL6IvTLvb6slq7ykl3/9HN?=
 =?us-ascii?Q?cOKVHvOEAVPcHnZMEfxBl9YzWPNlMQEae3qyHy5lW+VwBnmnnw47/8iyiCg7?=
 =?us-ascii?Q?SbjEsFTxHsGy7mGPTSCwOnFEEsrnQUCKrkNtFLaZ1GI7oPqJXrAvjHhygDVF?=
 =?us-ascii?Q?cPDR64JJNC4XRoOGmkdDuHO2370O0LF1O/YxhEaOYSNqrN18bntUMq4DllS9?=
 =?us-ascii?Q?+hSne/tuffq2D7wHBO/VtVAH51H/qw4kbE93XEICrOGUHg2GLF8HJoEFis/0?=
 =?us-ascii?Q?pXUJbBL+hgWyiLqGZYccV1d9UDf3bzyy2MrecrhbNJ+fbrSEIqS7Q1R+wumv?=
 =?us-ascii?Q?lX7Du0C+fo4NSO2UW7+Ya5iTuLuHVMQoNgjxUBLnA+aK/vrjo5D1+yokbhKu?=
 =?us-ascii?Q?njQGLSgfJOdGhrlO5R0WasXKxmstaGXiF+fhJZCeR88rdOfcQlH/LWCkfCEA?=
 =?us-ascii?Q?8neecRlYFQMPMZP58pIIE5bmtuak6vffdKB0nmI5e+1v6VT9P20diHlC68gT?=
 =?us-ascii?Q?As0IbGl9w2m2HIaOoHYwlb+u2/HY9VVCk+8t8y30uyqd5eZ2buLs+yT/ynef?=
 =?us-ascii?Q?FPcQ2520FhCIeOkSP+TUhGYly4Izv6y1fGqQpqJZJ3mc9xDQchmd8U+ZCeFe?=
 =?us-ascii?Q?Ni9BHHNQeSdk+aRHGufG38RXVU5hMUEDIw+IIz6IZMeXx7/TXkWZe1Vcq/BN?=
 =?us-ascii?Q?8LtA/elxScgw8n3IoZhomoR82bDXtXemD/cnh5jGtILKFi2FputE4rtElXpB?=
 =?us-ascii?Q?EPmWCCaR23BYU2zTllToAmYSGH7lWFQh7s3KexfXWE5a4ilxdd+wlq/4GrwI?=
 =?us-ascii?Q?Tf9Byn7j0FJ6C6w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:10:27.5310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87553a4d-4346-41bc-846f-08dd5c4bae89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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

Issue:
In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
 has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
continues execution and reaches svm_range_from_addr. This results in
a "failed to find prange..." error, causing the page recovery to fail.

How to fix:
Move the timestamp check code under the protection of svm->lock.

v2:
Make sure all right locks are released before go out.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 ++++++++++++++++------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d04725583f19..db898757f92e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
-			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
-			r = 0;
-			goto out;
-		} else
-			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
-			 * to zero to avoid following ts wrap around give wrong comparing
-			 */
-			svms->checkpoint_ts[gpuidx] = 0;
-	}
-
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
@@ -3040,6 +3027,23 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (svms->checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
+			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			r = 0;
+			mutex_unlock(&svms->lock);
+			mmap_read_unlock(mm);
+			mmput(mm);
+			goto out;
+		} else
+			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms->checkpoint_ts[gpuidx] = 0;
+	}
+
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
-- 
2.34.1

