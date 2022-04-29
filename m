Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CB3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3BD10F6D9;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5E810F4D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbJ6dBQSMIvGPEVtYenpF1MTeLuWNORXSiOpEja0CFnEEsdBrbW5gqOwwcnLlZb1YQZeOZvUkz/CPrrdfhvDwM39faXDyfooMox9SiBFg5f61/CINP0q5555xH+7Jv7r8Dnd7Ms/AFJD8KQ2zFgVDdO5ERAo3kvYmQ73fXbEnCjIK8J8F4P39vsw9WEUR0rJCf0ihKqN/SGvX5lgxnQo/asdPDEuf6DPcan7yl9xIJ0baz8Odzm4XG3og8fSU4Jrdtvm2vzgVGO5s/B3ykMHu0WUrFHdQLvIkURBoFv1H/2lbTPBgXgM4mtFK8cbW1pTXayPc4lyIuFyJMyOqxUnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKb5pSYOo8uT9ZNZEIFb9KESUiRMQbBeEesEnUrTzRU=;
 b=gN4xJNz19eawH+PDLIA1DROq6Lldezsi7bK8NCOYE89KEPDSbZ4SctvyaJyvsyqoBiG69gs5l+GN7aVdeyxdTr/bjiDkNrvbvRat/554tAWae9W+nzPshKXCbT4+jhIAuFK8MbUfk0n3ijlStFosNazUh3290AxX90tdtzTVkwSF0b5ydvrB+ebHu/JLYZS6mWGYIg5Z5u8h5KljftdzIU/rvmZqo6EDK15oK19oGS5PUDcrj9m1F+7o4+hfyA5zeg6U40gVaC/D9p/EPAqkTRrmkjM3C619ei/k2s2oLsOMpmdk+QIi5RDphuzZrniM1Hutr7rDy5eK90ODookCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKb5pSYOo8uT9ZNZEIFb9KESUiRMQbBeEesEnUrTzRU=;
 b=D+5/b9KD7f62TRq9oI6hBGGfR72T7Sxk4jA80a+OH2VsBPTCy1NIbgW0c1eI+yPI7lSusr3YKq4tmHCmsYLP3f854kKdQ7KHsrJ6SbeB4sMYp7/fY2+QZcRF8++rjS1+9U53MRMxnPnCUuuoxr+hQvabhwiUug1o/7kbXMFD2Mg=
Received: from DM6PR02CA0106.namprd02.prod.outlook.com (2603:10b6:5:1f4::47)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Fri, 29 Apr
 2022 17:47:11 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::5a) by DM6PR02CA0106.outlook.office365.com
 (2603:10b6:5:1f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
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
 2022 12:47:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 54/73] drm/amdgpu/mes: implement removing mes queue
Date: Fri, 29 Apr 2022 13:46:05 -0400
Message-ID: <20220429174624.459475-55-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dde39be7-54ba-41e7-67f6-08da2a084a26
X-MS-TrafficTypeDiagnostic: BY5PR12MB4194:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4194F3E5DB3061619EFC8498F7FC9@BY5PR12MB4194.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Poju91r8YmieKbEIxOc999n2V7BZ8OYMKUpZZ5PAVyUgcVANsjHMinRFRqRwYS2nxshS4PzFjKpOHVtJBZM/okQzMhgLTlyc17HxtBW2BodcrvLXf5JFVNQTEhvtRl61IVMitMHB7yvgFLZB1STgS+GSEHS1zhqqBMaBhzfLLA9GeoawvDPSEtbzyFDozalEsLz2qXfcvJZyeGWisHPAyAAA7ftAXDbfxHt5v9HDMeALg+nuGt7OwPhOzR7eHLqz2Osd7yFXhWPeIaJQJdxFqLh0TdsEl5BMJ0NyzyebkwR8EDoDtJAVlHW334sFqXzWWCqmW6hPsBNImD0x+pS8gjC3OokbNqnOSh5OuMI3RKQ8iV+zDu63H7n08gcYBy3GoHY0DH6O8RSNK4X73vgkDNrEtaK3i9hOS61gg1wDGLHboM+4WCfgT7sjFb4zzNZygN93RCA01+VoU0Ky4gEyrmj0ItYvyz/a8uafl8ngyMG/fnEBUp82S7Rox07opHeHVnBeK7F9RuM6xbfXwvy4qW5FRtpyxq5h2QA5OHWF7WK+fgZZPbSE94qAjM9JrYKBqzQqSFiRoigZSGRnezrNf6J2DpRMPAIzKFKTKBgIS4LG5UEBqOK05LOLdY2EVTDpluww4Z1YO3POVPaiVveYXzo+N2ltUSV7cdUZFfRuG2wEXi0GY6tDIWGT6jQZF+W2QDZPgKkLo8sbraxAZfJz8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(4326008)(356005)(6916009)(54906003)(36756003)(508600001)(316002)(8936002)(36860700001)(86362001)(81166007)(186003)(83380400001)(2616005)(70206006)(1076003)(70586007)(16526019)(6666004)(7696005)(2906002)(8676002)(66574015)(336012)(426003)(26005)(82310400005)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:11.7388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde39be7-54ba-41e7-67f6-08da2a084a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

Remove the MES queue from MES scheduling and free its resources.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 45 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9f059c32c6c2..df0e542bd687 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -655,3 +655,48 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	mutex_unlock(&adev->mes.mutex);
 	return r;
 }
+
+int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
+{
+	unsigned long flags;
+	struct amdgpu_mes_queue *queue;
+	struct amdgpu_mes_gang *gang;
+	struct mes_remove_queue_input queue_input;
+	int r;
+
+	mutex_lock(&adev->mes.mutex);
+
+	/* remove the mes gang from idr list */
+	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
+
+	queue = idr_find(&adev->mes.queue_id_idr, queue_id);
+	if (!queue) {
+		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+		mutex_unlock(&adev->mes.mutex);
+		DRM_ERROR("queue id %d doesn't exist\n", queue_id);
+		return -EINVAL;
+	}
+
+	idr_remove(&adev->mes.queue_id_idr, queue_id);
+	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+
+	DRM_DEBUG("try to remove queue, doorbell off = 0x%llx\n",
+		  queue->doorbell_off);
+
+	gang = queue->gang;
+	queue_input.doorbell_offset = queue->doorbell_off;
+	queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
+
+	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
+	if (r)
+		DRM_ERROR("failed to remove hardware queue, queue id = %d\n",
+			  queue_id);
+
+	amdgpu_mes_queue_free_mqd(queue);
+	list_del(&queue->list);
+	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+				       queue->doorbell_off);
+	kfree(queue);
+	mutex_unlock(&adev->mes.mutex);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index ec727c2109bc..bf90863852a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -251,5 +251,6 @@ int amdgpu_mes_resume(struct amdgpu_device *adev);
 int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 			    struct amdgpu_mes_queue_properties *qprops,
 			    int *queue_id);
+int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id);
 
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

