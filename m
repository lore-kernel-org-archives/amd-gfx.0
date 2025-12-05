Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A39D339A0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 17:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6C810EB71;
	Fri,  5 Dec 2025 17:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GeZP2SEc";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2B810EB71
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 17:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V66DjQyTL1ePsfDZftBkGR8PzSKe6SY9tkFs8/sXQEPkPLUQrLivedep4acuA+ww3hB1RRitLsN34vbEKlUAGiK0UzL62XOTta/2Ly08z5eIyPWjy9xORzGbpgb8qUVLWsRka0eTGnByTWApsg7QlqIX1XkqiCOLmunV/CNeRHga1/9ZG/CRLKNt4xy5c1jzajecy/PeR6ZUil291oUEvs8WoNlpdfDPuYXCouaR7w7THVMeLDwaatFstnZ4Xkn88yJXwbCNMjvSkONUZDmyz6rt+dYXQz4dvcU7m62UDkL95ZxQI3m9Hg3p6I4EbUwFFufLCXkjkeM/UBe9OwdJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7K0C7KLx+mPGT2cKLZ7PBh4tUfTDgh4/8qFIaEaCFI=;
 b=BHdTpgeCgIwjrCXh4SW3qCfZuogcWaAzgp5BJrbAwsebU8zO1nYzDsC9/16qGdWMYSQ+xarZlz27gzlblUv9SQMVjB895I9dwu47gG2wkM3YlLnMceG+kZ+QpeSxDrafMDv2xPNAm0tpPe+08GJvP+W6ReOoveTNxggEq973ejbGIQ5al5s97il0GBXWse8lw4o6Tsj8JhnkU8z2BIMC23MLDcdkbUjhGEfUWr4tmPYR7SCLNyfgdIrMUEPGIjlNJBoW4jgNahoAmJb+Ib9G/rDAJ65MuUJLPXoo87JoqYrPZQOvEKp7BWkkGM5exV3OB13oU2/nT5LNP/QLpADxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7K0C7KLx+mPGT2cKLZ7PBh4tUfTDgh4/8qFIaEaCFI=;
 b=GeZP2SEctRpUBIZWCtWxViYGatkY6NAQ8mHtM1bVxJX4Vt4VOtQkraA1340gQCBZomfDs36IGRonZ3W+SuyU9UGJrLP7y58UI9L/XwjmJDWbLkiALAcj/wko5yGOYdHaiZj8C+YC1+Dt9tX1qyFvIGIjPfYbWKyYiYCGexmGJLE=
Received: from SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 5 Dec
 2025 17:45:32 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::7f) by SJ0PR13CA0029.outlook.office365.com
 (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.3 via Frontend Transport; Fri, 5
 Dec 2025 17:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 17:45:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 11:45:31 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 5 Dec 2025 09:45:25 -0800
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Xiaogang Chen
 <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: kfd driver supports hot unplug/replug amdgpu
 devices
Date: Fri, 5 Dec 2025 11:46:47 -0600
Message-ID: <20251205174647.492240-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfbb973-6c24-4c3f-966e-08de34261642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PpahY8RcESqmHfVsyHNtKG8gYlPMFTJlVoc23722lI0YIqKGdZFL7frvm1pQ?=
 =?us-ascii?Q?0llm98Ygkt+3N2ATkWpNoUOwhupAQTmuIaksTjgbrOFd87gmReuWX2sw+vNm?=
 =?us-ascii?Q?gyjKWsHaEuyPy84ppaY9UcKKHgYR9kBRFFeanEDyAlql966gBzV6ROxqZ4f9?=
 =?us-ascii?Q?DWDRnkSBRLR8DWdoXhzDK796TptbEM7FUtEwSu6NCmkskI6/Ehmt1waBWhqG?=
 =?us-ascii?Q?NIVxI8Y1q8WqsuSEi1ooVWsq5kM5y7ztNGgnGL6slwNdFdyAUGpEvenTPks4?=
 =?us-ascii?Q?XcUBDw+/R4+cKW8b2xXYx0R7aPE4+8x5Jum2L/1oK1gvtGwN3ysGs1yDrsLp?=
 =?us-ascii?Q?umnG0cEaG2DTPooRDmmWc+4aPGD3vEXhWXmka8uzmX3+2aYHZ34vAvtgb/YT?=
 =?us-ascii?Q?Zm3D8Bf2/JX3fxyUMlnmRKymoFn0PKUrvr01DgJKR4301Kk2ULjHrBesC063?=
 =?us-ascii?Q?Qszg0gnMvtoy2A6rw1Zwkg+4nexAEVT5mr6U5Z5F5X/AB/qANvuffyPqeUGk?=
 =?us-ascii?Q?widfiOw9NnpI8UqRD2bS9dd5jWu5Pg02JFtdPs/nX3rdoKzsWNpRRijKLaGg?=
 =?us-ascii?Q?6HSdzwC1+McIEuLCx9gDDEYX9cTwzyY4Emx0f2ljGKUGoMHN/bHfj6sBXsfD?=
 =?us-ascii?Q?jS0RXRz5OCKMIBl5YbzhC+yR924aA1laGnkqQUGRYGuLG34/8lQzY1kggsEG?=
 =?us-ascii?Q?wkQi5mSgw2R0sIiXrGzdyDBh1Ofgyzv/Y81i8RhP8RTuyTjgCYfXidtyOehx?=
 =?us-ascii?Q?aUE4giUTCLensjU6aumU+6TFrg+tGthEcUFgk5sRwzyl0bZd2SXXVxml0KIu?=
 =?us-ascii?Q?CaihAyrHcwhPKwEzuUYIPA7jid6OOWW23V02DgJH00kUk/5cORqbC+znJBbj?=
 =?us-ascii?Q?vSGMF8Yp9+ygjmoluwlpb6OiE0Ng09fwWcRUrJNsns7tSAcyFcfTVbJtGqnd?=
 =?us-ascii?Q?mryy4oxzX5jfFQsUjSAo6gRbnem3u9X6hCTw3BYQGDjoIRwy7YI5xbD14Rpb?=
 =?us-ascii?Q?WYUWCy9g+rWLWZohyo3m3ztJOarMvfxtdaaQM2U9DxTcZ6snoxl5fyfhtC/k?=
 =?us-ascii?Q?MVVzmB9uEw5YKJmP4V39ZaEFJuEgVwR56AaPQBVXsRnw3fxlzIDwCec3HznH?=
 =?us-ascii?Q?mhkXgcVRWeiyECA9C6upRTlBXVXPvhR94fgvZMYj3yLfvlZD/zrf5aoGwYLG?=
 =?us-ascii?Q?jrqNTWs4KvUD4NWrwqfCbZ/6/X+Hiaqe9yaqe4zgOr5fDb0VqycFl1bu7iPj?=
 =?us-ascii?Q?mgDaYOzh94zlLmQfVcbTwwQ23L3vFDsMZdP/qhS1eALw3zlUY0KzxlKf77Qb?=
 =?us-ascii?Q?/ltTt2BA77qgrKV2aaQMWHXbPo7I5m+Wayv8i4QVDphxBfuk8bMEJZc/7hXy?=
 =?us-ascii?Q?EzdOJRyXKEyUQ4B+36Krr7MXiRhBrOReVXrFwjvklS3nzHd2wBw3dof84Vbf?=
 =?us-ascii?Q?EqaTCFwCTJp2fYzrfI3B1JpANoMvzAh/cFoNGiVHggdrq4tHeNwFmmUG29Dn?=
 =?us-ascii?Q?OhsbJa4I/zzC4Ia4nJJzIgSV3bjUwPuOupIu/jr7AWTpxx8XWn5uFZJSQrjQ?=
 =?us-ascii?Q?2ZxhLs8Kg4hgLR0MjWU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 17:45:31.9222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfbb973-6c24-4c3f-966e-08de34261642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

This patch allows kfd driver function correctly when AMD gpu devices got
unplug/replug at run time.

When an AMD gpu device got unplug kfd driver gracefully terminates existing
kfd processes after stops all queues by sending SIGBUS to user process. After
that user space can still use remaining AMD gpu devices. When all AMD gpu
devices at system got removed kfd driver will not response new requests.

Unplugged AMD gpu devices can be re-plugged. kfd driver will use added devices
to function as usual.

The purpose of this patch is having kfd driver behavior as expected during and
after AMD gpu devices unplug/replug at run time.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 11 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 78 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 29 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 12 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 ++++++
 8 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8e..622f613e7627 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
 }
 
+void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev)
+{
+	kgd2kfd_teardown_processes(adev);
+}
+
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc)
 {
 	if (adev->kfd.dev) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 8bdfcde2029b..f79e20cadd70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -155,6 +155,7 @@ struct amdkfd_process_info {
 
 int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
+void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev);
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc);
@@ -434,6 +435,8 @@ int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd);
 bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
 bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entry *entry,
 			       bool retry_fault);
+void kgd2kfd_lock_kfd(void);
+void kgd2kfd_teardown_processes(struct amdgpu_device *adev);
 
 #else
 static inline int kgd2kfd_init(void)
@@ -546,5 +549,13 @@ static inline bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct
 	return false;
 }
 
+void kgd2kfd_lock_kfd(void)
+{
+}
+
+void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
+{
+}
+
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f75ede1b1c6b..dd8fc2d42b69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3663,6 +3663,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	amdgpu_amdkfd_suspend(adev, true);
+	amdgpu_amdkfd_teardown_processes(adev);
 	amdgpu_userq_suspend(adev);
 
 	/* Workaround for ASICs need to disable SMC first */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e3da2f149ae6..30d87e4daad2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -936,6 +936,9 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	}
 
 	kfree(kfd);
+
+	/* after remove a kfd device unlock kfd driver */
+	kgd2kfd_unlock_kfd(NULL);
 }
 
 int kgd2kfd_pre_reset(struct kfd_dev *kfd,
@@ -1519,10 +1522,14 @@ int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
 	return r;
 }
 
+/* unlock a kfd dev or kfd driver */
 void kgd2kfd_unlock_kfd(struct kfd_dev *kfd)
 {
 	mutex_lock(&kfd_processes_mutex);
-	--kfd->kfd_dev_lock;
+	if (kfd)
+		--kfd->kfd_dev_lock;
+	else
+		--kfd_locked;
 	mutex_unlock(&kfd_processes_mutex);
 }
 
@@ -1686,6 +1693,75 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
 	return false;
 }
 
+/* check if there is kfd process still uses adev */
+static bool kgd2kfd_check_device_idle(struct amdgpu_device *adev) {
+
+	struct kfd_process *p;
+	struct hlist_node *p_temp;
+	unsigned int temp;
+	struct kfd_node *dev;
+
+	mutex_lock(&kfd_processes_mutex);
+
+	if (hash_empty(kfd_processes_table)){
+		mutex_unlock(&kfd_processes_mutex);
+		return true;
+	}
+
+	/* check if there is device still use adev */
+	hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_processes) {
+		for (int i = 0; i < p->n_pdds; i++) {
+			dev = p->pdds[i]->dev;
+			if (dev->adev == adev){
+				mutex_unlock(&kfd_processes_mutex);
+				return false;
+			}
+		}
+	}
+
+	mutex_unlock(&kfd_processes_mutex);
+
+	return true;
+}
+
+/** kgd2kfd_teardown_processes - gracefully tear down existing
+ *  kfd processes that use adev
+ *
+ * @adev: amdgpu_device where kfd processes run on and will be
+ *  	teardown
+ *
+ */
+void kgd2kfd_teardown_processes(struct amdgpu_device *adev) {
+
+	struct hlist_node *p_temp;
+	struct kfd_process *p;
+	struct kfd_node *dev;
+	unsigned int temp;
+
+	mutex_lock(&kfd_processes_mutex);
+
+	if (hash_empty(kfd_processes_table)){
+		mutex_unlock(&kfd_processes_mutex);
+		return;
+	}
+
+	hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_processes) {
+		for (int i = 0; i < p->n_pdds; i++) {
+			dev = p->pdds[i]->dev;
+			if (dev->adev == adev)
+				kfd_signal_process_terminate_event(p);
+		}
+	}
+
+	mutex_unlock(&kfd_processes_mutex);
+
+	/* wait all kfd processes use adev terminate */
+	while (!kgd2kfd_check_device_idle(adev))
+		cond_resched();
+
+	return;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 5a190dd6be4e..ea913368e231 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1380,3 +1380,32 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 
 	kfd_unref_process(p);
 }
+
+/* signal KFD_EVENT_TYPE_SIGNAL events from process p
+ * send signal SIGBUS to correspondent user space process
+ */
+void kfd_signal_process_terminate_event(struct kfd_process *p)
+{
+	struct kfd_event *ev;
+	uint32_t id;
+
+	rcu_read_lock();
+
+	/* iterate from id 1 for KFD_EVENT_TYPE_SIGNAL events */
+	id = 1;
+	idr_for_each_entry_continue(&p->event_idr, ev, id)
+		if (ev->type == KFD_EVENT_TYPE_SIGNAL) {
+			spin_lock(&ev->lock);
+			set_event(ev);
+			spin_unlock(&ev->lock);
+		}
+
+	/* Send SIGBUS to p->lead_thread */
+	dev_notice(kfd_device,
+			"Sending SIGBUS to process %d",
+			p->lead_thread->pid);
+
+	send_sig(SIGBUS, p->lead_thread, 0);
+
+	rcu_read_unlock();
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 76842bb8e78b..d7b4aba0f488 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1177,6 +1177,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 }
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
 int kfd_numa_node_to_apic_id(int numa_node_id);
+uint32_t kfd_gpu_node_num(void);
 
 /* Interrupts */
 #define	KFD_IRQ_FENCE_CLIENTID	0xff
@@ -1529,6 +1530,7 @@ void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
 void kfd_signal_reset_event(struct kfd_node *dev);
 
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
+void kfd_signal_process_terminate_event(struct kfd_process *p);
 
 static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
 				 enum TLB_FLUSH_TYPE type)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f5d173f1ca3b..5a74469f5bef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -854,6 +854,12 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	 */
 	mutex_lock(&kfd_processes_mutex);
 
+	if (kfd_gpu_node_num() <= 0) {
+		pr_warn("no gpu node! Cannot create KFD process");
+		process = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
 	if (kfd_is_locked(NULL)) {
 		pr_debug("KFD is locked! Cannot create process");
 		process = ERR_PTR(-EINVAL);
@@ -1176,7 +1182,6 @@ static void kfd_process_wq_release(struct work_struct *work)
 	if (ef)
 		dma_fence_signal(ef);
 
-	kfd_process_remove_sysfs(p);
 	kfd_debugfs_remove_process(p);
 
 	kfd_process_kunmap_signal_bo(p);
@@ -1192,6 +1197,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 
 	put_task_struct(p->lead_thread);
 
+	/* the last step is removing process entries under /sys
+	 * to indicate the process has been terminated.
+	 */
+	kfd_process_remove_sysfs(p);
+
 	kfree(p);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5c98746eb72d..062ad5d40d62 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2349,6 +2349,28 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
 	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
 }
 
+/* kfd_gpu_node_num - Return kfd gpu node number at system */
+uint32_t kfd_gpu_node_num(void) {
+
+	struct kfd_node *dev;
+	uint8_t gpu_num  = 0;
+	uint8_t id  = 0;
+
+	while (kfd_topology_enum_kfd_devices(id, &dev) == 0) {
+		if (!dev || kfd_devcgroup_check_permission(dev)) {
+			/* Skip non GPU devices and devices to which the
+			 * current process have no access to
+			 */
+			id++;
+			continue;
+		}
+		id++;
+		gpu_num++;
+	}
+
+	return gpu_num;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
-- 
2.34.1

