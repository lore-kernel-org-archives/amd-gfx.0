Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A2C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A2110F58E;
	Fri, 29 Apr 2022 17:47:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3187410F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuUfV9qX2ibfAVakgazrjKjX3jcJkES2eqlMQnBrID5scdEjoC/lF34pyZDjh1GnnEpHJvtjnwdb2q4uLZsK4AiyIWP/WXU14YQwRDxv3BKXZijOS8U8h4wEBWGCgERncyyY4DtCGW4XmC+GUtiMXs/XRiFewvQavzkDpo4CXqfqnk+Olh1nD3OIq/IRqhkF8p9JW2uDEoHLDpEniRzwmkB+8fn8b4jiEgboGhNAdrzgpdUOnT85Xsr3LkcVsVBk7vxd+WiW3IDNBOLpUXhdro2ldXMS4U96chCSMEdzE+z5C78+DU+GvfK9LhS2Hf+aTP6Mu1aoLIPBBztL8XJsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXCYsVLrdzONkYp/DzxTJgg/zhI8cTORdu9Jdn4Tgqc=;
 b=Mb+Gz2iNFE3lsHhLiP9J7kHiDAvXFLHTuwtZclYtO3jlp2lZbP3HRr6nWaf9YEzJZWlV4UvB5vTfFHVOrIC66falYGipKVYg2pGmGeYYshQ0cnfgkyddzyg2xrV0fME3nB+scw/nWPmj4LaxKfBM2M6mbjv6BOKknz43Cu2LGnqmjOV/qdCIgwbTt3H0F+locsjYhbKmwPBlyZLdIQgWaML5z4Wa8KNDPJb8gZPWVS6ZwubBiHfOfAKwXtFIoSCONy1hK6NykiFBJSQcF+xgXd8PKW0SFzvmVD5wbqFb/Qa6KwLKmX8Rzgb+BTJaVZiKbxYmlXTS6B2oMy4ygosQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXCYsVLrdzONkYp/DzxTJgg/zhI8cTORdu9Jdn4Tgqc=;
 b=b2b5TCzibYvk0nzs3COnpQkf6PwRGDeSubus/SKAgnH8ua0vd4MVEmopF0XOKbTZZlG3NDxyBnLEIJimTTMOw8M9hIs3Xs6aYpX48r728TF9psCrc0bJwjJqOUK9bMZJlzrwGWheZ7VyS/J+1L46duhXqqTtO+jQOfBhKYoTm88=
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by MWHPR12MB1389.namprd12.prod.outlook.com (2603:10b6:300:13::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Fri, 29 Apr
 2022 17:47:08 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::92) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 49/73] drm/amdgpu/mes: implement removing mes gang
Date: Fri, 29 Apr 2022 13:46:00 -0400
Message-ID: <20220429174624.459475-50-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b8d959b3-c9bd-41be-79b4-08da2a084823
X-MS-TrafficTypeDiagnostic: MWHPR12MB1389:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1389DB87556F7F47675A1490F7FC9@MWHPR12MB1389.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VprnRHQlvCkVedXpDL51WIPit96NVK6kanDVEHwlC4fjDddgeBuUdVdH1ShuZw5Hu6Jq9cG8Nvpmx4LBEBthXJxS849O+74XMioTQkCqOGZ1finP/yenpmbXuk994RqGDQ6wsnRR5euZmSDJx6GxtGrYNHN6fzHMNFViawkSasfq3WrUTEEZPFFzWncBuBt0BLA7nMyOgQvcpv/rYTMXyiI57iXqyq9fLAuRJLaxRMzX3fQzHm/0+sa+O8yy75beuNtoSvVFFmwd/2HMDfWyP/G5WCqm9BYfHfFrffQzdQork1qT4uySWEM1JyyNsRAJHyjIMAMsofJuE+KAGaFYrEntlq1ORoVZiFlx4q1b1cjUOFOXqSmoLeWZy/h3UZAf/wShrXX+fA/1Ah2ue7IneCzbUTMa0iMS8/3Ubk5PO/JXl7Kx6wAaGkEF2Y9iXcLqHdZGE5hB6Zx+CM7tKBQQJqKD2RbadcMfIdtGoRbuszjp/q0YEqoS90/zPusHKeJkoVOmED9ujetUoMrR2rdif0EAc/WvH4ob2UniVitjYgGbx1b8T0N0RHU+vAS3fCyZlvtU3/1x+6flp7cu0+pA60njeI6f4+XwbHy5d3y78wjZR1pnNdTv6t15HGDLrEFi2t0Cf2KFaLRFzVkEUo6IKf74Uw/LWAMpXGaB/hE7ydMCiXQ1PCCuu9G+yfh2eGDw7cAzRvkr57djFS6ylvZww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(6666004)(7696005)(8936002)(26005)(36756003)(86362001)(2906002)(508600001)(336012)(47076005)(186003)(1076003)(16526019)(66574015)(2616005)(426003)(54906003)(70586007)(81166007)(356005)(36860700001)(4326008)(8676002)(5660300002)(316002)(6916009)(70206006)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:08.3642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d959b3-c9bd-41be-79b4-08da2a084823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1389
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

Free the mes gang and its resources.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 74385e4b45c4..07ddf7bf6a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -416,3 +416,33 @@ int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
 	mutex_unlock(&adev->mes.mutex);
 	return r;
 }
+
+int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id)
+{
+	struct amdgpu_mes_gang *gang;
+
+	mutex_lock(&adev->mes.mutex);
+
+	gang = idr_find(&adev->mes.gang_id_idr, gang_id);
+	if (!gang) {
+		DRM_ERROR("gang id %d doesn't exist\n", gang_id);
+		mutex_unlock(&adev->mes.mutex);
+		return -EINVAL;
+	}
+
+	if (!list_empty(&gang->queue_list)) {
+		DRM_ERROR("queue list is not empty\n");
+		mutex_unlock(&adev->mes.mutex);
+		return -EBUSY;
+	}
+
+	idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
+	amdgpu_bo_free_kernel(&gang->gang_ctx_bo,
+			      &gang->gang_ctx_gpu_addr,
+			      &gang->gang_ctx_cpu_ptr);
+	list_del(&gang->list);
+	kfree(gang);
+
+	mutex_unlock(&adev->mes.mutex);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 3109bd1db6bc..f401a0a3eebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -228,5 +228,6 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid);
 int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
 			struct amdgpu_mes_gang_properties *gprops,
 			int *gang_id);
+int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id);
 
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

