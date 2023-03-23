Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1729C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65EE310EB5A;
	Thu, 23 Mar 2023 21:41:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D55510EB57
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko8htwEPdL0O622AjPSPPlgEaCJKR6gKgQrGFU06RGicYNNPGgthu6TD8LH7+Qom2sp8UJx/3uApnk0EM7ZAAerW99eHCeWDiLgDE3+0q/Ad51cbGL7KHXd223SUSPqRg6EUdj4vypGAwi1ZMVQj9axT6xISArUKKvzL4gmy+ar+yjEL/wopwFejF8mS63SyMn6fcdG7wnhxR7DRlD/WmfUhM/hcm0Styb3lBQ7JMLZy/vv5VxZFVqxrWIJECYEmfdqd1qkm42eHc86+BnX+/mPTvy0xy4DqrZmGo4xHrwVItOSpEloq8JEVlfKeb2ygIfkOlc659wpbxp+KH0fOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=930j2tsxmwCIhqZoQ7wFiFpV1XZ17qvlVdGI0rOymGI=;
 b=Q9dS9EO26slariesWY6ttfQmVMt1np5sLKa4RxLpMSDf61ikrRs+a0zQ71xgsDtsAIba23n5/FTatOEw21CglD6CXlVsq0E2KoYMrl0HL20YTw3TbC2j+riqCb3sJI3Q7Gr2+IA94sp7JXSF70uzA07EdWYul/CyKS3w16eNu5/gTWnxS8gJpxEz/pGwR4KEnvIa0XlwtfsiJvz6TXc0Ve0iAYVGxnJF+AMMgTkY+eWUEGYDrJdmfDVAk4YoMKq6ukfT/F3kSPLCJkzFsb/c3msWqBYaR7wDw8Cm5i0onuDAfbqPSkual0YgW4OtTk1dw0i14EPcK1s3btmlZFIVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=930j2tsxmwCIhqZoQ7wFiFpV1XZ17qvlVdGI0rOymGI=;
 b=CNRVUfNIDOSO+1N2LAuaGzTlC1caroDACmN5gV4v2zbGF6B5utQWcOF+gGyHDOLEiJSStTpnPD2fpNtLojmwdl9abTxwuWHhLp9eaZj4gxY++XTW2TCXUSMPwXwWG6Je5/1HIhugM8WRRZMdg1mKxqvOPPojj87D1Br5BU01CiE=
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:40:55 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::70) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amdgpu: add debugfs interface for reading MQDs
Date: Thu, 23 Mar 2023 17:40:34 -0400
Message-ID: <20230323214034.1169310-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bfe225-afdb-45c7-ef71-08db2be74882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01m+Aebj33VpfQcGDCKp/2zShIM7q6+v0EX5h1JA+qw32NQsECHEGAWIAWKn4xy3KFxBWTVUFxCqAWRU3yWAWHczIQnjn99dsMvhxZ0PtPw3VDAH9mJws4YJ8btcDK2niNWHQWeKniXe94EoUqDhTMnCcQKENfCEKvdfXUGCejDGTNUL10gm54P2bQHAiSbVDTrfaDDyeRq06GnnaGMQ26DQKyKv1wZ777DjjGDWnWfwclNb95anzq+vPJuhhsIlMaf2UerrV7B9vWE/yC1igAv/V0sOIauyIv1Ii25o7LbevbTG3PHCCHjlS7HffB/wX8rFvnAeoVsYYCIHnbru/uwPEzfYAKv/fZv6MFolwQX+YQtzpOaghksuOvEM2i+RjWo3buz9HczHcDWR0i8AE8mgvEwEVYsAeqFCLUqgZOEMJ/1N+aW27wGXhBwLOKUXN7jxPFDZljTBJPadx7WFnoJQhkZMlDAKyafbToLVjkBOFlQ0hVBt9+l1TzgbDfImrP3dIjHVvQ303uEwQ1HQzpV8K67I7LVUiuDFbeZ3iqMQoZDukcR1vZmjSE+U/6quxGZpDPedn0fQd8+ekh0Sd7hBURdRtxrFV+Emr0Z3I8ZUcTiT5LMfLmF+HW56pMd+HpDTUr0Be99KOr08ODi8odWysryc5K5U+7D/Ps6eaV2svcyzA9G3e2E8xKgBvKTocFUsIM/Uy3YU7wdp2DFoYNbUKWQog+hCW5h+QFs6rx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(8676002)(6916009)(70206006)(54906003)(4326008)(36860700001)(70586007)(41300700001)(81166007)(5660300002)(82740400003)(426003)(8936002)(47076005)(316002)(26005)(1076003)(6666004)(16526019)(66574015)(186003)(478600001)(83380400001)(2616005)(336012)(7696005)(86362001)(82310400005)(40480700001)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:55.6099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bfe225-afdb-45c7-ef71-08db2be74882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 60 +++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..4da67faef668 100644
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
+			return result;
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

