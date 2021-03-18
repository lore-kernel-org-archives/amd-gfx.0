Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6DEC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF5B64EBD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF5B64EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 315186E898;
	Thu, 18 Mar 2021 07:23:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A11B6E896
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5LkuSgY0LVaKbMAeGQa4O1bDfQi9vVD/mPZpS2+3rRyJB1AZjog8fAOWiXO6x4sX8sZsjPcYKSYc77iBIZ/GUoyZia2Zyg1ushAyRN8jiC5g376F5IHLX4c1mJGyUp7OVZsBNs44EdqzV9YT7CH6UorXZADK8s1I1GXJNCdqxjMVqUfdZPT+FMcndCDmx6xYYRLl3PE2oajB8vYPDDysgoFiYrPmedtR9sI0QHYFv4MCUhwTvyqTbAXzORAeeqdmL/8+eXKbmgYpsRhkfUecjZcTb9S3tY0YA1SLrcu2CBgdRLexX+bEhlQr1jzn/QlW5arHv8SgAij84w4HY4q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXwC4UWoUT3iSz9RAh/44koSv/naeQn3/O+WLEXzbQo=;
 b=XKDdB8UVzgaj1+qAbBnEUvaVzq+J+ihDEmJG6R+7U9pspy7laEZqMvqAUscQ1VDP4SMeYl4rHRW48vbbMqVC6A0tNy4v8+lS61ijJTqqmr24KCPHJLTRpYLv/c/aDtfmgKH6QPOf5t+ideT/QWWfzkUo0AyAQcs9RgOl6QnQWLurwpZiz/VDulMTFga52lijzmrzIDy03JeJM8iFeC4McPQyGqySJAAfmIFAyeqfo0lZqCTNNmKAqakOA6efs7tdjvTzPsA6G/ODaBREGr5GYZ8UtGennHwfEikzDsMvbPatmCFeS/2DiNfFI6gjUwV94IMgQQOck7j2AFI2HjFpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXwC4UWoUT3iSz9RAh/44koSv/naeQn3/O+WLEXzbQo=;
 b=h8XuC0oP5Grpvhs9dbfVy8UmlsYMEjst6JFlYRVQH0Fzlxbky/i6BQLCK3eOSEl2NX894bNSvYImDcCpWRsqorfN5K/4ml0GnLDuxxhXNHf7/3BU98q0E+DLXYvGs14ou4SBShG0JwwQA5x+ZgkOawnKlTLiA20tQY+G5DPgpeI=
Received: from BN6PR11CA0015.namprd11.prod.outlook.com (2603:10b6:405:2::25)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 07:23:56 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::ea) by BN6PR11CA0015.outlook.office365.com
 (2603:10b6:405:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 07:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 07:23:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 02:23:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 02:23:53 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 18 Mar 2021 02:23:51 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: refine the GPU recovery sequence
Date: Thu, 18 Mar 2021 15:23:37 +0800
Message-ID: <20210318072339.28736-3-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318072339.28736-1-Dennis.Li@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2b12321-392e-4bad-d562-08d8e9deca49
X-MS-TrafficTypeDiagnostic: BL0PR12MB4964:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4964AFD329C73FBED35E06EDED699@BL0PR12MB4964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lf8XjnrbwtvFLjkVpMZH0Fvoq6EVXm6oMxJwm0EBSnI68vF6qjggPWIcCT2AktoAC4/YKOILRoNBFpEfqIOSHrNYGe+3KQTuM4ELR7l/q/YC9Fs4UXvJO8hsR5u3hGH3IpjAiZyl3cSPqcgPkAAZIhu7QLrwfj+CuSkpX0eqi59SuWv8cvxS3k4pU7yEEhHnCeiCHASDK1XhvKNfkxJrzC1eCwC9uvXu/rLGvRokk+p6JzaPecpDX3mlVUt4rtdPEdnS5eL2mz1E2Jh9zhftkOs9HCPiX3DDPb8ugpX3e8d0WspkzWJAZc3BCfV5ATY2u5ELZ12cVWfoR9htNVTsMN/zpZP+6p8lt6FVSYxfJkDgLGVCpt4hSf9z2JX3FqOXXny50L3+r92C1iXk0nUk4rqxGcuhR/8p7SRsP0FZa1iHGw8fxPl9qC2xW3e16TCThaqCf1INXm0UVoglpzYMs5xkoqR3n2SPTF8NM8EigUdacqTyHjlI6pK27Mmk6REF3TccuJK0ElZDfLSKb5w+mVpS9j7AhfPHNehDa2McJYsXTCsQuRGuIFr/u76KHDqztDSEhxq6rSrIEHz2JN0lD45+6tQfUXHI7Y1+/O6d22jirtKTT9YQ3mzTh+LQeEyu5YW/0eXFXCqrILI3ltiYJLkJcDc40/ODimozuSLd5ByNSCNahWdDBsSlPJyVIDRa4uo9hwBMuUygCWzCQXastA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(426003)(47076005)(7696005)(316002)(2616005)(5660300002)(82740400003)(6666004)(36860700001)(2906002)(6636002)(1076003)(36756003)(8676002)(110136005)(70586007)(4326008)(336012)(86362001)(478600001)(8936002)(70206006)(82310400003)(81166007)(356005)(26005)(186003)(83380400001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:23:55.7343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b12321-392e-4bad-d562-08d8e9deca49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changed to only set in_gpu_reset as 1 when the recovery thread begin,
and delay hold reset_sem after pre-reset but before reset. It make sure
that other threads have exited or been blocked before doing GPU reset.
Compared with the old codes, it could make some threads exit more early
without waiting for timeout.

Introduce a event recovery_fini_event which is used to block new threads
when recovery thread has begun. These threads are only waked up when recovery
thread exit.

v2: remove codes to check the usage of adev->reset_sem, because lockdep
will show all locks held in the system, when system detect hung timeout
in the recovery thread.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 02a34f9a26aa..67c716e5ee8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1044,6 +1044,8 @@ struct amdgpu_device {
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
 	struct rw_semaphore reset_sem;
+	wait_queue_head_t recovery_fini_event;
+
 	struct amdgpu_doorbell_index doorbell_index;
 
 	struct mutex			notifier_lock;
@@ -1406,4 +1408,8 @@ static inline int amdgpu_in_reset(struct amdgpu_device *adev)
 {
 	return atomic_read(&adev->in_gpu_reset);
 }
+
+int amdgpu_read_lock(struct drm_device *dev, bool interruptible);
+void amdgpu_read_unlock(struct drm_device *dev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 24ff5992cb02..15235610cc54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -211,6 +211,60 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
 static DEVICE_ATTR(serial_number, S_IRUGO,
 		amdgpu_device_get_serial_number, NULL);
 
+int amdgpu_read_lock(struct drm_device *dev, bool interruptible)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int ret = 0;
+
+	/**
+	 * if a thread hold the read lock, but recovery thread has started,
+	 * it should release the read lock and wait for recovery thread finished
+	 * Because pre-reset functions have begun, which stops old threads but no
+	 * include the current thread.
+	*/
+	if (interruptible) {
+		while (!(ret = down_read_killable(&adev->reset_sem)) &&
+			amdgpu_in_reset(adev)) {
+			up_read(&adev->reset_sem);
+			ret = wait_event_interruptible(adev->recovery_fini_event,
+							!amdgpu_in_reset(adev));
+			if (ret)
+				break;
+		}
+	} else {
+		down_read(&adev->reset_sem);
+		while (amdgpu_in_reset(adev)) {
+			up_read(&adev->reset_sem);
+			wait_event(adev->recovery_fini_event,
+				   !amdgpu_in_reset(adev));
+			down_read(&adev->reset_sem);
+		}
+	}
+
+	return ret;
+}
+
+void amdgpu_read_unlock(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	up_read(&adev->reset_sem);
+}
+
+static void amdgpu_write_lock(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
+{
+	if (hive) {
+		down_write_nest_lock(&adev->reset_sem, &hive->hive_lock);
+	} else {
+		down_write(&adev->reset_sem);
+	}
+}
+
+static void amdgpu_write_unlock(struct amdgpu_device *adev)
+{
+	up_write(&adev->reset_sem);
+}
+
 /**
  * amdgpu_device_supports_atpx - Is the device a dGPU with HG/PX power control
  *
@@ -3280,6 +3334,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	hash_init(adev->mn_hash);
 	atomic_set(&adev->in_gpu_reset, 0);
 	init_rwsem(&adev->reset_sem);
+	init_waitqueue_head(&adev->recovery_fini_event);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 
@@ -4509,39 +4564,18 @@ int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	return r;
 }
 
-static bool amdgpu_device_lock_adev(struct amdgpu_device *adev,
-				struct amdgpu_hive_info *hive)
+static bool amdgpu_device_recovery_enter(struct amdgpu_device *adev)
 {
 	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
 		return false;
 
-	if (hive) {
-		down_write_nest_lock(&adev->reset_sem, &hive->hive_lock);
-	} else {
-		down_write(&adev->reset_sem);
-	}
-
-	switch (amdgpu_asic_reset_method(adev)) {
-	case AMD_RESET_METHOD_MODE1:
-		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
-		break;
-	case AMD_RESET_METHOD_MODE2:
-		adev->mp1_state = PP_MP1_STATE_RESET;
-		break;
-	default:
-		adev->mp1_state = PP_MP1_STATE_NONE;
-		break;
-	}
-
 	return true;
 }
 
-static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
+static void amdgpu_device_recovery_exit(struct amdgpu_device *adev)
 {
-	amdgpu_vf_error_trans_all(adev);
-	adev->mp1_state = PP_MP1_STATE_NONE;
 	atomic_set(&adev->in_gpu_reset, 0);
-	up_write(&adev->reset_sem);
+	wake_up_interruptible_all(&adev->recovery_fini_event);
 }
 
 /*
@@ -4550,7 +4584,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
  *
  * unlock won't require roll back.
  */
-static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
+static int amdgpu_hive_recovery_enter(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 
@@ -4560,10 +4594,10 @@ static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgp
 			return -ENODEV;
 		}
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
-			if (!amdgpu_device_lock_adev(tmp_adev, hive))
+			if (!amdgpu_device_recovery_enter(tmp_adev))
 				goto roll_back;
 		}
-	} else if (!amdgpu_device_lock_adev(adev, hive))
+	} else if (!amdgpu_device_recovery_enter(adev))
 		return -EAGAIN;
 
 	return 0;
@@ -4578,12 +4612,61 @@ static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgp
 		 */
 		dev_warn(tmp_adev->dev, "Hive lock iteration broke in the middle. Rolling back to unlock");
 		list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list, gmc.xgmi.head) {
-			amdgpu_device_unlock_adev(tmp_adev);
+			amdgpu_device_recovery_exit(tmp_adev);
 		}
 	}
 	return -EAGAIN;
 }
 
+static void amdgpu_device_lock_adev(struct amdgpu_device *adev,
+				struct amdgpu_hive_info *hive)
+{
+	amdgpu_write_lock(adev, hive);
+
+	switch (amdgpu_asic_reset_method(adev)) {
+	case AMD_RESET_METHOD_MODE1:
+		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
+		break;
+	case AMD_RESET_METHOD_MODE2:
+		adev->mp1_state = PP_MP1_STATE_RESET;
+		break;
+	default:
+		adev->mp1_state = PP_MP1_STATE_NONE;
+		break;
+	}
+}
+
+static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
+{
+	amdgpu_vf_error_trans_all(adev);
+	adev->mp1_state = PP_MP1_STATE_NONE;
+	amdgpu_write_unlock(adev);
+}
+
+/*
+ * to lockup a list of amdgpu devices in a hive safely, if not a hive
+ * with multiple nodes, it will be similar as amdgpu_device_lock_adev.
+ *
+ * unlock won't require roll back.
+ */
+static void amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+
+	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+		if (!hive) {
+			dev_err(adev->dev, "Hive is NULL while device has multiple xgmi nodes");
+			return;
+		}
+
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+			amdgpu_device_lock_adev(tmp_adev, hive);
+		}
+	} else {
+		amdgpu_device_lock_adev(adev, hive);
+	}
+}
+
 static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
@@ -4732,6 +4815,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
 	int tmp_vram_lost_counter;
+	bool locked = false;
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -4777,7 +4861,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * if didn't get the device lock, don't touch the linked list since
 	 * others may iterating it.
 	 */
-	r = amdgpu_device_lock_hive_adev(adev, hive);
+	r = amdgpu_hive_recovery_enter(adev, hive);
 	if (r) {
 		dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
 					job ? job->base.id : -1);
@@ -4884,6 +4968,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
+	/*
+	 * Pre reset functions called before lock, which make sure other threads
+	 * who own reset lock exit successfully. No other thread runs in the driver
+	 * while the recovery thread runs
+	 */
+	if (!locked) {
+		amdgpu_device_lock_hive_adev(adev, hive);
+		locked = true;
+	}
+
 	/* Actual ASIC resets if needed.*/
 	/* TODO Implement XGMI hive reset logic for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
@@ -4955,7 +5049,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
-		amdgpu_device_unlock_adev(tmp_adev);
+		amdgpu_device_recovery_exit(tmp_adev);
+		if (locked)
+			amdgpu_device_unlock_adev(tmp_adev);
 	}
 
 skip_recovery:
@@ -5199,9 +5295,10 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		 * Locking adev->reset_sem will prevent any external access
 		 * to GPU during PCI error recovery
 		 */
-		while (!amdgpu_device_lock_adev(adev, NULL))
+		while (!amdgpu_device_recovery_enter(adev))
 			amdgpu_cancel_all_tdr(adev);
 
+		amdgpu_device_lock_adev(adev, NULL);
 		/*
 		 * Block any work scheduling as we do for regular GPU reset
 		 * for the duration of the recovery
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
