Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1778EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D2510F291;
	Fri, 29 Apr 2022 17:47:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C449B10F23A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bElrToF5ZryGEK4WufEvm8iY+jKL8aQxMdtaq+67qJ7OF6MEipvghjoMztM8KquJlgOIqsK4v62mkgFJTVA+9LrL3EJvLShAzaCM+5gWv8QARtifsKRpzGLVlZn6UAPkA6Bya5Lt+2eae6NX3oCpFl9p/RQBWOjKSKnOK6VgLjvqtYwF4K7nyHFSwXgjCS4jZtWDo+EgTbFSz/flSKn1nIS9G4yTUyP0Q1cSUtQ8wk9eo/8m4dPqQRRTuP3cV2LRS8kqtpWtojpzC0OfVJksld6ofqXXsYQKv0cyz+h6fRgci3Hsk7LIOJzsRquXJdGcbj8faxq+g7v/BVEHo85piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+Ciy9yGjLXp8qUkiJHo9oW0bReFszNcZa0jbKuICLk=;
 b=nZLiq8AA8UJ/3oG8eyXDbstmzsM+5q5UycI29drWqiux7H/d+0swu5yyAHHbt8rZg4fOChGh01igZyZvHmX3jj8uBVgNbx7hOVAORDxkxGr49/5i7NiSKCDCgoWIU1beiI2L84fPH8jNjiHiM16TskA5t6wys/+3nJQavuKL4tTfPutkYAcJqq4xml8JO4mhGQs5zjnxZQB5jiZjJYXHgx0piE8D5h+i/xl9D5oSf3w7f9jUWKK+p7FAqD+SSSdd+q4aYf3pH1yLQw9wofJEzZGqrS8r8tkZmRJDJ2+OpSKESjAJ1owXtu1iDOj6ww/bmR/VhTwtaDWYMytlohcBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+Ciy9yGjLXp8qUkiJHo9oW0bReFszNcZa0jbKuICLk=;
 b=WdXbtLiGP3WrxnfZj36X6p15CehbrIQJdgfrE2Cr8NAq6ALWPQvMKIZRzlzBPKO1sLB48yjoA+8F4vpfwwmAsf/0dTgOHnrWQohsXJ2BgHkA20MtdWdmIvPAeRd4hgX5z/FWNMj7Gq5NZPTd7VJ+g+ODhbGHRIyOuZscC7ZiydU=
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 BYAPR12MB3351.namprd12.prod.outlook.com (2603:10b6:a03:de::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 17:46:58 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::b9) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/73] drm/amdgpu/sdma5: add mes queue fence handling
Date: Fri, 29 Apr 2022 13:45:43 -0400
Message-ID: <20220429174624.459475-33-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38a93a13-107a-4cfa-c405-08da2a0841b8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3351:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3351A5895075D730BC675AF2F7FC9@BYAPR12MB3351.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sbs6tgHzZfNBxPVXU9dzIPgHcN/UepWUZxDBcr5eOYsjHwyLcvRkDkc9guz+4OkqTEyWbvDYtrjJdd6I2RjZzpo63r4SOH/zaDSpzM2C/BJ2P11Br4GOKd/eeGD/UANLn56vLZK9wVz22wSXK3lUozBXOd586rzO+8QyxP400JbHIIjINCdJkLbA9lU/PQcWEE9v+nN1yWwT3X3qFbbJYwYc38DrsqHIErLqDawLvuo/rsZdlVGDItAEB0Y0qk43uVosBMV8wjKlt29io2K+yEUtZjYFYVZH8Crre+Wj4IUv1FUkOp1GBQ6TiS2kQdfJ3u8cqMQCO/UYRezl/dyOpe0FFELr3CStsFcPZ9nC1jJ8HfPuyGPqx9UQ3NxKs9Sl78TkeGc/Q97qaLmfyOf9ubWK6pU5q4VJJqBagqnwsKEYWa82XAbFUjOLrSaBYbuVaJ7kIFAnSkiIYwGQEbA/ySKiMOv5/rUnhjSmctdPmEden9sDK95dCtahv6I7vqA65/1oFpZ03tiBBta0sFyPWUbeiFanfynpxBLCzjrMS+bDebNDabzMRkagX4N/2i17dU9Ok/Fir6lJsUT/oTZ7RPIzZTR1/WERGzvfQGgpI+4o0cdiTMDvv64jAa1FmwoS1drNOsr9Qg6KI5/1A9aFPC6jPibkDMkWynyiB+hQJ0Z9+xVQx4RmJHYMo0V9ioU4oMrkMdbTMrnrqJnXYi9j/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(7696005)(5660300002)(36756003)(70206006)(36860700001)(16526019)(316002)(2906002)(83380400001)(8676002)(4326008)(6916009)(70586007)(8936002)(54906003)(40460700003)(66574015)(336012)(426003)(2616005)(86362001)(47076005)(508600001)(82310400005)(81166007)(356005)(6666004)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:57.5985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a93a13-107a-4cfa-c405-08da2a0841b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3351
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

From IH ring buffer look up the coresponding kernel queue and process.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b73e45597031..564adc7b010c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1555,7 +1555,25 @@ static int sdma_v5_0_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
+	uint32_t mes_queue_id = entry->src_data[0];
+
 	DRM_DEBUG("IH: SDMA trap\n");
+
+	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
+		struct amdgpu_mes_queue *queue;
+
+		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+
+		spin_lock(&adev->mes.queue_id_lock);
+		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
+		if (queue) {
+			DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
+			amdgpu_fence_process(queue->ring);
+		}
+		spin_unlock(&adev->mes.queue_id_lock);
+		return 0;
+	}
+
 	switch (entry->client_id) {
 	case SOC15_IH_CLIENTID_SDMA0:
 		switch (entry->ring_id) {
-- 
2.35.1

