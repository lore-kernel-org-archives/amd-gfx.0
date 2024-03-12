Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C9C54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 15:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A257112E9C;
	Tue, 12 Mar 2024 15:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TV7IeSDX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46AD9112E9C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 15:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjHBptaDRJgYJX5RpfmmfmC4ao/S3sIEjStkdQ6EIqb5E8QimgHt+YQpKjEJ52KUwHoIy97qhMamdwLBE3/AodZneaYP4ehXUXmSyPVbQE9vWKuWw4Ww6J6tEQSq302W0oY4+na/Agc4fJyg+Q6lV3jLxCcx9zWp8tVkmgI0IiZodxrN2zO+HfS6/MIUJvQpWPcqFjPUY161YMPLE/kVFjrIUO8wPQw4En061daGULrji/xHojY+fbMpf1wHZKjSHZVoMIhkReUS6oUEeM96pdQeZ8MD6rEZPpHt9Eq1C5iuqTxsHqJM6fzM/NtO3dWJbM72GJQsqlmqyOUWl+eBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxvYeLOFoJZvxPinJ2wTx6Ejt3vNPhgWzpx6K9MVkdY=;
 b=bXUfx8BF93nTQu9eBbseqUcz+Job7T4/+IaxaG4eKDRsulilNk7hA09WT58/zmCtDe33ohlK6rHbFkL/+5Vyjk+WZOMYbvupjNbkBJrGIQOKgmkWVJhZnY4cl6IX/dV+MSOcHMgls5bDXp4w4/bIPHYh6YOSF+/iUCCxJR1xLRcxDz5NSJnNqUx5PZnShJtF2T4C2AvHO4w1jJMG5E1q+tJlM9eNBJmxZysm3wUsDQB5ms7ktRf21P9zCOmLT1IFy7Jw7o8cNeT2+8zWmB+UlkhJFlPXkn2TFSkcU0Wb4EhR49xoULPug+aCgjuaT9B1zSKcd5ycrjWvu7uavIKbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxvYeLOFoJZvxPinJ2wTx6Ejt3vNPhgWzpx6K9MVkdY=;
 b=TV7IeSDXkJSRVQMG4JYCZYiMma0MDdgT1cdfds0przWvMQxXo0jjO+4XJa+Xgj4KVQS8lNiyli7KSaL9TuFfap8oSb/sm3ktrwkJS77/mwKiOa2uk0M+QrsSlvA6jxVehiqR+s9k5ey2D/TxaP7GN+xz5wm3EaHCGGQAivuZthA=
Received: from BLAPR03CA0069.namprd03.prod.outlook.com (2603:10b6:208:329::14)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 15:31:39 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::bc) by BLAPR03CA0069.outlook.office365.com
 (2603:10b6:208:329::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 15:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 15:31:39 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 10:31:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: cleanup unused variable
Date: Tue, 12 Mar 2024 16:31:00 +0100
Message-ID: <20240312153100.1046-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 53816333-7d6b-4b94-2059-08dc42a982f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPEVjF5l4EcEJMd3z9nyLQruP0Le5jaPS17fi2Id4txUDm7TLs87EZ8KT7dUqzBy5krUT4Zat8CivASsL+rA1JFesnKrYfw3j/q7But1I1ykfxxT+ko/vdqHCVJk+dPCeurx51NHo6XJaAj4CZs86/eN+iKDZfgFWD9S4PR8uNZhm8TxS/kpwNIOE5lK8UNIy8GRLMt+8y4hSOmpYJnAppDNXErILKrToDgx0TzqZ7He4VaKqxl7vX49ITkJH+/dGPtX4Cl9CDYjmHv/qqWjWjVKxWbc8mzrMgUOwrrWFlncI8nP9Zzz3VxSjLVKfspgm07Is9cNtiVmyL1fypFPUBVRCedn671enLSxih1HPsH1Ams2k33Aaa7AKPwHeWuug/SMUWSUjYBEL0ExklrN1N1erQf8RHI6Fo0XM/oic3AcZE6dromGH3wKd4oVflxQyUxlNUHRFs8C8IqFD+mbRuHjRoGfoYB4ZOFxg/oO3wiNMQNxK37lrXN8ouU+wGPQj04Jeck+Xiy+In42fGEnnTzUgQECohoWO9tmuCxZJGRgbeu/F9zd2hmplbktTiXzxYbV81XPLUCSnY9G/eAHoOFpkcWTqt+tS7AlAQSdZKoA2OFj7XrbUFJOlJjqLz1uxFcCGjhLQAOpnWQARvsOyzN6RYmiXKLPFxVCBUi3sK0Ff3KFtjDN8Nt1TuetWsrEzWD/Hte9X3QdgPMngMcN4HbeIhDDeZKhjgqlFvN0GAA9AaMhXYoQtcMJmlLPQFsp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:31:39.3504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53816333-7d6b-4b94-2059-08dc42a982f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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

This patch removes an unused input variable in the MES
doorbell function.

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 89ac50405e25..7615daf89ba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -40,7 +40,6 @@ int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 }
 
 static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
-					 struct amdgpu_mes_process *process,
 					 int ip_type, uint64_t *doorbell_index)
 {
 	unsigned int offset, found;
@@ -65,7 +64,6 @@ static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
 }
 
 static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
-					   struct amdgpu_mes_process *process,
 					   uint32_t doorbell_index)
 {
 	unsigned int old, rel_index;
@@ -623,7 +621,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	*queue_id = queue->queue_id = r;
 
 	/* allocate a doorbell index for the queue */
-	r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
+	r = amdgpu_mes_kernel_doorbell_get(adev,
 					  qprops->queue_type,
 					  &qprops->doorbell_off);
 	if (r)
@@ -681,8 +679,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	return 0;
 
 clean_up_doorbell:
-	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
-				       qprops->doorbell_off);
+	amdgpu_mes_kernel_doorbell_free(adev, qprops->doorbell_off);
 clean_up_queue_id:
 	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
 	idr_remove(&adev->mes.queue_id_idr, queue->queue_id);
@@ -736,8 +733,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 			  queue_id);
 
 	list_del(&queue->list);
-	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
-				       queue->doorbell_off);
+	amdgpu_mes_kernel_doorbell_free(adev, queue->doorbell_off);
 	amdgpu_mes_unlock(&adev->mes);
 
 	amdgpu_mes_queue_free_mqd(queue);
-- 
2.43.2

