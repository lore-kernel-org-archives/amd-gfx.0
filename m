Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D420EC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 09:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C3820639
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 09:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S0E9PwnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C3820639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5425889A76;
	Tue, 18 Aug 2020 09:41:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB58789A76
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 09:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f89nMpJWvDlAY8bIrtjsTd3GgpoRHjl4GX7hT0HlHgAdNdpfsCkSLoF62OATacQF4H0M3S2/AhPLVdIcyHegqNisyTxtxsuxCc/SZs+W2JFt4Ao3FF0/UmqOHa32HkZoGQyAbDtsoHFAg3h6EE6ZTufyFMD1YxewB7FQ4uxWMcm7u8vTzzsvuAOF9VKnhdRh4WjdGJMkp6e3MhS8+IgIco0O/cEZF+Kjt9I3PrzdCAXcX04dT2+hCQpFuIfiI0/VRwDwimoFXHCGssVkuphLJzhUBdzqogHJDOHbaGPMLGjX9XgT+UScau+vObpSzz9sYzNvmZXr+Lvu6DhCtEeatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbILUNko5c1FtQFu3k2KegQId2JoFwdUBE805PK6Uh4=;
 b=aENLKe6VOrBtigX368f9R8Jc7tw2JHCMXEM5Hk9VyjUFk61LXY73tVZhirc0wFcwEIvnmgCU0PnoGdO/ZeDDamwuotEo+Odio+bGSiDNGQiz6O82hUmZqSy6q1RoyO72+1SVhkd+amtnp6kvnGExsxQ5CBiMnMnEfRBRqXOnsxioKvHZLJE/m+cW5YrkpAh5IR83Igx36hSPcePmffZd+9g+g6v8WR+LmycTXTP8Qu1QEc8QpmD3N03zqgQ3gYfLyZdKoVCyRV5nxy2ehc4kI7oExc1To8fPYGqW3SnjTuTPQP2fhCoo4pqO/vJzeB/rb7hIM320NmDxjG7R/uXnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbILUNko5c1FtQFu3k2KegQId2JoFwdUBE805PK6Uh4=;
 b=S0E9PwnEFAqlUiXYNIOxVDRa1WZYbPuToh8Q64CP1k+u/P84r/qwnWbYhyOKylQ1ncF6V0eYCWKV55O0ei66HtajZAEMAhaCSGdGCOlqfy58IcscvvfRnqANMQrMjRVmOvTodIt+FB6YkyYl/1m62lobuKSfOhmKI+enm7eyL+w=
Received: from CO1PR15CA0106.namprd15.prod.outlook.com (2603:10b6:101:21::26)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 09:41:50 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::83) by CO1PR15CA0106.outlook.office365.com
 (2603:10b6:101:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Tue, 18 Aug 2020 09:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 09:41:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 04:41:49 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 04:41:48 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 18 Aug 2020 04:41:48 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Fix repeatly flr issue
Date: Tue, 18 Aug 2020 17:41:43 +0800
Message-ID: <20200818094144.378857-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a41f01e6-f8e8-458f-300d-08d8435aee8a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4091:
X-Microsoft-Antispam-PRVS: <DM6PR12MB409160BDF621350948ACB5468F5C0@DM6PR12MB4091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKM35zQusfsWkOu/bAVqKiVGw9ovhrcOcixB25Kik7zpl0QQIxiyn5ZsQGdvINdhwMSCIDCd2HKKjuSfeW6HysxYSfmZJckzZwlNyz/hFkBhndp6TyRF+Fc94f0TG3NYZADn3pmLfkue6MbKV7JNy1XlYQmygIcLIx6wpz4ckX7US62nj2raVUp+oUxMqagVUAaQ6X3kneEPZNyYTzmB1XQ9t6T75VTx9jBBMd3sg4HuSGmE3E2z1w9VAL+Ox3fCi0YSxrWJTASc3Pud1tXy8sWg4ZS469vgxdOhYjgS0ZawTq2/9kwi0E0JFnIVtfAyYgOCTeEixxO1A67rqIwT/6LiN5gQoye2AbHVBfm4eqllroGzJD1uczuNC8yb2/HiDSR3vM0an181q2Nps8Avww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966005)(336012)(6916009)(86362001)(81166007)(8676002)(316002)(356005)(47076004)(186003)(83380400001)(82310400002)(82740400003)(70586007)(5660300002)(26005)(7696005)(8936002)(2906002)(426003)(2616005)(70206006)(6666004)(1076003)(36756003)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 09:41:49.9467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41f01e6-f8e8-458f-300d-08d8435aee8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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
Cc: jqdeng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jqdeng <Emily.Deng@amd.com>

Only for no job running test case need to do recover in
flr notification.
For having job in mirror list, then let guest driver to
hit job timeout, and then do recover.

Signed-off-by: jqdeng <Emily.Deng@amd.com>
Change-Id: Ic6234fce46fa1655ba81c4149235eeac75e75868
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  4 +--
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f9d97f61aa5..69115781be05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1136,6 +1136,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
 /* Common functions */
+bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job* job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe8878761c29..e17f632efd07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3925,6 +3925,35 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_device_has_job_running - check if whether has job in ring mirror list
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Check whether has job in ring mirror list
+ */
+bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
+{
+	int i;
+	struct drm_sched_job *job;
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->sched.thread)
+			continue;
+
+		spin_lock(&ring->sched.job_list_lock);
+		job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
+				struct drm_sched_job, node);
+		spin_unlock(&ring->sched.job_list_lock);
+		if (job) {
+			return true;
+		}
+	}
+	return false;
+}
+
 /**
  * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index fe31cbeccfe9..bd4e7c2d0dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -261,7 +261,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-		&& adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)
+		&& (amdgpu_device_has_job_running(adev) || adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 6f55172e8337..d5c14745a9d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -281,8 +281,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	up_read(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev)
-		&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
+	if (amdgpu_device_should_recover_gpu(adev) && (amdgpu_device_has_job_running(adev) ||
+		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
