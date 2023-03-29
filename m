Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF1CC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091A010E48A;
	Wed, 29 Mar 2023 15:25:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA6710EB25
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tdc444q+uGjE6ijjkBqxHEsX50f62JLyMKLko9AmSMmTb30y9NujVHMoEPiU8/z/CkH827RMym2c/rG479iiQAieFAoWJ26NLhFiQ5TtmvCmbBMti74nzBAbUe7vguXrH27Qwy1oxuO6O8GekuOxSp1Ibj9DvmJkToZLaOwIKPotlyCx+4ee/x3MhJA2b9XdBcn+dYUhZ1ZMj0/F5ZrtvCvVgbj+TT+DdZkYx6UjPdNjMtpUGSy0E5rWGedDTq/LbbbOouwCILGHBpp9epMYMZEMHDcY/etQwpwl+OnQIZ36Wjqz9WU5nkr3jO2N8Vx/F6rO3rUwIRxX3beP7rMkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vkQS//RBRPX33u43eHiSnTEFYb+5aqrhcUpzsGiKtU=;
 b=etFJkxl4R6x5Y7caNUYzFFP7TwcTiVJffglbtx+6Vs0tnyczkckA1cTuARldZ6Dys+BZBDqRrvxH7JQVAIpsHTzN7VQb+Undtjws08g14wG9CDo7us8yRZ0sB+Brr02Iiozg8EeO7RxGwIro0+Rzgbwb1zmzwBTb1+PBewIXy7YnnviWuByaeDNLLOl9YFV48J+nNeCSPR+EICthanklQWks38lKnJqvXvySJYWQoXmxemtWcaA6ZM0KK3tesWCy10aDqazrG1l9T1Rbn/P5XzsO/RFnPYXhGYMS+lbtQ3tED7+ovqpXlEWlZubc0yHTYCXqVlKifDqiDr3Xp+LFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vkQS//RBRPX33u43eHiSnTEFYb+5aqrhcUpzsGiKtU=;
 b=LVS/aHin9A3fkDTFqsvP6pZc6hNhTefAlafncZDNJ4RhLe0O9suFLM0E/4kk7lANHE4y3eyuJ3Ei/6h2RnuKg85hbTNGvw5eKy8wvoU/3MPQKE0PO+q+Xl4N9oC38JXzUw487gm/VxAsbrsqF1Q9sP1nbouQTiEynwtdFyNHOUU=
Received: from BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.31; Wed, 29 Mar 2023 15:25:42 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::a4) by BL0PR02CA0125.outlook.office365.com
 (2603:10b6:208:35::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amdgpu: add debugfs interface for reading MQDs
Date: Wed, 29 Mar 2023 11:25:21 -0400
Message-ID: <20230329152521.1980681-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db41067-638f-4083-75a2-08db3069dbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOmg7ELusHGUjKIH8knhtjGwmL6/SVO9jrxxjs+c+0MWkAg6buKycuMqWORX4Zozrt+wK/h+Y9GN+ONTZBnHqsCreYfCJ16k7am2fe14JiH/6x8TiNQoIsPojQWlntmJM8AlpWAgdRa8Yfvjbshb3XmdQLa3hsfMXckyP+UN7x2Feg4SfL/VX+NuO1Xj1J7s066UU6bTI82hHMfnxbPNac/10Twn+KK561mF0ZPS07bU9ovBRwBimF61ugYnddEeYnw1ygknT7qrGBuZzaeiBGZoKKvVu/NRAO0uEki3UVuMnbhY51Lr+qQ9446z2Llo6/177FeYlh5CgD6cpIjfA2OioO1MzhCumS9sSvccRmRSgh29ZMNId0VeM4Xt8YjxuvE59TKFursCauBiuo8udFPcs6NDnij/vSHKI7NoQR1nIjXYsfPYQSAdFJ19lRO+UTjn/ZeIo1qCVJdi1qLDKgnRcuWf3Qn7ucCVPtAoRioMcgdHaVBVSu5Deo69rPHsyXEU4M7/uHqOEfbCKPzRAIeRr8D7v8RmUNvkfITwvxQjGC4PI+s5dPxaymHOjDdPJeIKHcVL55gfL2V/pgS2sDiKXDaQiVSTgZYm4vY+CJZn82G3QOYyYdGkzDzH0oWlM7BihoLzYGTcEtDIVHd0rMaZal0Z7YNdu4aA5/txDHMv1IPYFb7QdMKjPGrSua5ESsi9Ta41fgqrDQjOTUyl3PsbOo1GktBfQ4wiTnTJwvg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(86362001)(82310400005)(478600001)(40480700001)(40460700003)(316002)(54906003)(7696005)(70206006)(82740400003)(70586007)(4326008)(36860700001)(8676002)(41300700001)(6666004)(1076003)(26005)(336012)(426003)(16526019)(47076005)(186003)(2616005)(66574015)(83380400001)(6916009)(81166007)(356005)(8936002)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:41.8652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db41067-638f-4083-75a2-08db3069dbb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Provide a debugfs interface to access the MQD.  Useful for
debugging issues with the CP and MES hardware scheduler.

v2: fix missing unreserve/unmap when pos >= size (Alex)

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 60 +++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..c3b7654678c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -478,6 +478,59 @@ static const struct file_operations amdgpu_debugfs_ring_fops = {
 	.llseek = default_llseek
 };
 
+static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
+				       size_t size, loff_t *pos)
+{
+	struct amdgpu_ring *ring = file_inode(f)->i_private;
+	volatile u32 *mqd;
+	int r;
+	uint32_t value, result;
+
+	if (*pos & 3 || size & 3)
+		return -EINVAL;
+
+	result = 0;
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0))
+		return r;
+
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&mqd);
+	if (r) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
+		return r;
+	}
+
+	while (size) {
+		if (*pos >= ring->mqd_size)
+			goto done;
+
+		value = mqd[*pos/4];
+		r = put_user(value, (uint32_t *)buf);
+		if (r)
+			goto done;
+		buf += 4;
+		result += 4;
+		size -= 4;
+		*pos += 4;
+	}
+
+done:
+	amdgpu_bo_kunmap(ring->mqd_obj);
+	mqd = NULL;
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r)
+		return r;
+
+	return result;
+}
+
+static const struct file_operations amdgpu_debugfs_mqd_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_mqd_read,
+	.llseek = default_llseek
+};
+
 #endif
 
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
@@ -492,7 +545,12 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
 				 &amdgpu_debugfs_ring_fops,
 				 ring->ring_size + 12);
-
+	if (ring->mqd_obj) {
+		sprintf(name, "amdgpu_mqd_%s", ring->name);
+		debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
+					 &amdgpu_debugfs_mqd_fops,
+					 ring->mqd_size);
+	}
 #endif
 }
 
-- 
2.39.2

