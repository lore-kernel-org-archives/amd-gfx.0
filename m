Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D463C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E180810F61E;
	Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B76D10F498
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRaaCtpbnwe4Dged7V9qkrRVLzPxLLcLAjiFX/gmHJZETFHX+ge/1ujd751h24b/jXHhDQyZTefoSzdMMQJKshbYePMl0GLhQtmBqjqJEkqQDY+b6F6ZGeyFXxejPaMM/mdcatbpXshuVPswjPwV4LxFik7LF4j+y4wdGF7TlQePr5VIVLhNZdd0i+9yHhLi2fbWn7LQ7+z1bOuNIpZQPPhUE7Cmp0FU3ZKdw5aHEYBxgbVhnxztQAZsZi/ajZpQeXsb9rzyZrhWko52IcB5iN3HbOMMgMoXvJmwatQVanMSxxjP+Myg4HdIwpC8U6XzILTuyiR6q+jUZsoWsGptyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pznCsI7eWak3x1R+XwMIT+fCMZlRvjKSqRMaaY0zeBM=;
 b=Hdb7447BnpxPtDl8kanK0BsE10XkJXC9flyLm51FrA/cYw2M+CLPgkqi7QxaQ0w/SVxgPT0mLSLEekMc9G8ZuwiQm1E3A3MGpk7/FDxso3IEIGAn22GcxjfEKnaczfwkdQXZZ9XMp8tEbvdC4xKlAiuYdXyRxuJHHsHh+Uz4mDC+EwfiFdooT5b56F4No038V4JfJtCj7fo+sAE3GNQ+pWpgD55LdW5GNhXgbg6i7ckzs4k0I2Q8jeZ2ui000QzFdGlI9hI7sHVnm2XTm/AnSd0V/wi1KUftnveZxmcHNQ7YZmWq4nrNXuOBo6dhV3pSm6xlicMtewVPAnBISJ7VHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pznCsI7eWak3x1R+XwMIT+fCMZlRvjKSqRMaaY0zeBM=;
 b=VxIE/rF2z4NR3/0tf1NxCn8M5sYoSfBj2MbCgK71xGKxAjT7nmttRwOQPoSRW5v1K/NyqkG4W8Q01NI2VxM1PF/+NjsjXfS1E04J0isv6KxMPQ6Bl5vnuhgWstNpOkteOOPSwzoLcgvY8mpKXNLJti1+1DRUC4tHRe3XqjwEeCI=
Received: from DM6PR02CA0094.namprd02.prod.outlook.com (2603:10b6:5:1f4::35)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 17:47:11 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::3c) by DM6PR02CA0094.outlook.office365.com
 (2603:10b6:5:1f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 52/73] drm/amdgpu/mes: initialize mqd from queue properties
Date: Fri, 29 Apr 2022 13:46:03 -0400
Message-ID: <20220429174624.459475-53-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7301a6b6-3125-4ce5-9354-08da2a0849ef
X-MS-TrafficTypeDiagnostic: DM8PR12MB5398:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5398C44392BEF4932B082675F7FC9@DM8PR12MB5398.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4tPeVDHhT72G1tUO/6tNfbmn0bglyGleU0la+SjgOLBEO4vtnv4V1OfBcnBqtaTHd6QAnjcdYhWbVGah8hsAISaDq8nkAfm4xQA68xNW+qF7mQXxSuAkyFWckd7T7KZ1+EEpW5GZ3fBNJampWDkzOfBUFCffoZqY43/33JlC38I0PdhjhBKHK1XPCiSr8CqNw2YsFtJhNhSsDgiY4CQM1rQFBCAbsiH985vR8dnTTCFjwAz2cPJ4sWzMkwzrhDMRwUptOoBcOK6D6j1Wjm9a1sKw3Wl868/KeX9CVMlYUbcNznJoWyxSZ/SBDB/OAXz/lE4fRj4Fe1WRArxgE3//XdpSrWQA26iL1hEKILUU+4n7yl0BJpASuQQUVUCD3ud8es5WjGkFmxoBzYiPGB8RZ7lFsrWUJWEHhSp/vU7X/Y5IcvEjq+Xh4YQD9B1ibJdfxM3gw3/bEpoFpmVuk9JoksAGHb3GEM0JGP9K95a6TnyqfSv7VODBNEWxIxHHVfZOjmA1EjPvajgz36KqU7AxhH2opJz3rJqwCCS5fCMSn8umVYfNhuvOOThmfusjNuzX36kVhayvI4GUwGS3AbbPInh6KT0Jz8pd04K2fkXdPpQ1ue0clX8nBNwylA+eSXRIpSZWz9+/DfaxVzTRXkvBVqqJ57z5dbLQuttD/RbKb6W522YtLZZkh+6z18yW371tX3LZHcen3mVgMOfe20tNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(6916009)(54906003)(82310400005)(6666004)(26005)(36756003)(508600001)(7696005)(86362001)(2616005)(36860700001)(5660300002)(1076003)(186003)(4326008)(70206006)(356005)(8676002)(70586007)(16526019)(316002)(8936002)(47076005)(426003)(336012)(83380400001)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:11.3795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7301a6b6-3125-4ce5-9354-08da2a0849ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add helper function to initialize mqd from queue properties.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index b58af81f04a3..2cd2fa76b5c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -496,3 +496,57 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
 	mutex_unlock(&adev->mes.mutex);
 	return 0;
 }
+
+static int amdgpu_mes_queue_init_mqd(struct amdgpu_device *adev,
+				     struct amdgpu_mes_queue *q,
+				     struct amdgpu_mes_queue_properties *p)
+{
+	struct amdgpu_mqd *mqd_mgr = &adev->mqds[p->queue_type];
+	u32 mqd_size = mqd_mgr->mqd_size;
+	struct amdgpu_mqd_prop mqd_prop = {0};
+	int r;
+
+	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &q->mqd_obj,
+				    &q->mqd_gpu_addr, &q->mqd_cpu_ptr);
+	if (r) {
+		dev_warn(adev->dev, "failed to create queue mqd bo (%d)", r);
+		return r;
+	}
+	memset(q->mqd_cpu_ptr, 0, mqd_size);
+
+	mqd_prop.mqd_gpu_addr = q->mqd_gpu_addr;
+	mqd_prop.hqd_base_gpu_addr = p->hqd_base_gpu_addr;
+	mqd_prop.rptr_gpu_addr = p->rptr_gpu_addr;
+	mqd_prop.wptr_gpu_addr = p->wptr_gpu_addr;
+	mqd_prop.queue_size = p->queue_size;
+	mqd_prop.use_doorbell = true;
+	mqd_prop.doorbell_index = p->doorbell_off;
+	mqd_prop.eop_gpu_addr = p->eop_gpu_addr;
+	mqd_prop.hqd_pipe_priority = p->hqd_pipe_priority;
+	mqd_prop.hqd_queue_priority = p->hqd_queue_priority;
+	mqd_prop.hqd_active = false;
+
+	r = amdgpu_bo_reserve(q->mqd_obj, false);
+	if (unlikely(r != 0))
+		goto clean_up;
+
+	mqd_mgr->init_mqd(adev, q->mqd_cpu_ptr, &mqd_prop);
+
+	amdgpu_bo_unreserve(q->mqd_obj);
+	return 0;
+
+clean_up:
+	amdgpu_bo_free_kernel(&q->mqd_obj,
+			      &q->mqd_gpu_addr,
+			      &q->mqd_cpu_ptr);
+	return r;
+}
+
+static void amdgpu_mes_queue_free_mqd(struct amdgpu_mes_queue *q)
+{
+	amdgpu_bo_free_kernel(&q->mqd_obj,
+			      &q->mqd_gpu_addr,
+			      &q->mqd_cpu_ptr);
+}
-- 
2.35.1

