Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F38C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393BC10F6EE;
	Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B9510F28A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCPAaszfkCFU3M8b6VwboQj2V7l+8uKENOZdgKgzBFpwIQ+HwQs+KW1OHSy/1mkaxfF47Bt4SgS9E1AlY+r3bJVRXF3FuG/DKGpN0vq0G+K4RIEzuHjuBrDZX3NgHg2EfmYl47BsAHlHQ2ZzLuFNEuVFlP3BKIIxvIOXMr5KEMWjm6oxEaxJRjx5dBd8aujd7FezdgfgDN9kOpJaYkajqWQVpvujAJZeyuzZkWw7CbK7U9AbbnaaBSi5gcncxuPp3jpzFS2kuywfq6TH/3BCk+tmPkbDuCbBTWB932FdzDPu744V2aTJ3X0+HKCst2RBlNwd0f0HD3ryDS3twXyjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVMnbldo+k52rYdnQ58l3BrAjgYdF6icIQCRJeVuOFQ=;
 b=IJDMe1qMm2DaXbUUsBQCNJpaLHapTn0SzXzS3Kldent0U2tatzfvYA2IMkPaRddwciGZ9Kt7PoIpjHY11cGx8+EGMpYxKf8JnBQFf/6irX/AVo2Isyjggm56byD/qV9Xnpa+CE84BhBRLWuYxrD9ItiWLZ/a1v9+A7x5A++NfYPJDp/3cGGg9kO5QrBAYX7Cr81uBFXtl62kOCQIDcmiPN4LMI9jgJHQaMBeWE1c6M6JfLlq3jNrLWRx2jNbzkyJJ8CBcdTo56TIRKqod/D6rB70+xFqCtQbm2ImpTx3VmAFaiXs6HvYB1mQFONAoFy1KEkilh3xDX70oYHi31jH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVMnbldo+k52rYdnQ58l3BrAjgYdF6icIQCRJeVuOFQ=;
 b=QFbGvFWMmdHuoF3LXHWhKkzAAe4x3je3cDKn0+/JY7horNEpqrCzm797fHbXqwSNpt5A2X9y/5VG/1j/jHKSIhlbEdllhVOz5QTXeqiyyr1RouMNTrCWiw1bVu5EvyPOMpTIPcrDL80bfFSiAFmbqb2izbOp96ggNNOKjrOY7IQ=
Received: from DM6PR02CA0098.namprd02.prod.outlook.com (2603:10b6:5:1f4::39)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:47:12 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::f6) by DM6PR02CA0098.outlook.office365.com
 (2603:10b6:5:1f4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 55/73] drm/amdgpu/mes: add helper function to convert ring to
 queue property
Date: Fri, 29 Apr 2022 13:46:06 -0400
Message-ID: <20220429174624.459475-56-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee72cc03-588a-40e5-1378-08da2a084a75
X-MS-TrafficTypeDiagnostic: DM8PR12MB5496:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5496067AF6C6FB0E8D46F1B6F7FC9@DM8PR12MB5496.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXQ33QiWiJ4p9HxXM133ll1w2kc7IzqEZlApFbEtbjqroILMSIyAQUXrfrTiKKc395eOwDIqC5kP2HtcUoxJdX8F9uDRdyI2OeKFJO4Lule9YPYKjtRMZCQvKhXpOjR+ADwnz29H4dQg7OsXam99u3SRl18IJypRMNcUWh+ZjN/oHlLFz37oyQW9zSX3DisBTR9fjkIauXICGnY7icvhEvXKkKZyM1F0BLIo/bHNLEwBKY768AA0LXTjrrMEnStij+YfPwhSUZjUZzjf+BX3yEQahp4EuMLq56Y5rRuCo0vqMlqfd4XULQjRmfhN9o3D2x7UFwWrSIkAGnDVCv3J2t8V0MV59J58TLV6X7V5itoePi03xAGpsN0vcwaePH88/Ip7jF/CM6wJkHH5s3EMi6vIDiarKjb9aEWOkBLVXmeVO447CC/SqLB3XvCxfgKrdHfwRfAv3yg+qMrd7GOJyE73OA3bG9elR0J9iBH0nFuCo8qMXeWmkZJLNvmXlfgHz2Mk7tad+OTazIlMaYpr4gcgDSRlUHNQ/n+LPc/NhHhxCDgiHfVT4eJKEKiugppuC9W016UhBi6z4Esor5FDjUJw4lsPQiu6rCHTljVjbxsDsxpa1eRbCPDPV34amzbsrKlgLlpLLA+C6f3KubKdZRNrJ/OTj3phsC+Gaok7doxIDE0Jq/+1SX/c2M9eAXmRM5xVBx1vDV++Xcne2Ymm7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(4326008)(47076005)(426003)(336012)(5660300002)(356005)(70586007)(8936002)(70206006)(6916009)(83380400001)(81166007)(16526019)(86362001)(186003)(36860700001)(6666004)(26005)(2906002)(36756003)(1076003)(316002)(82310400005)(40460700003)(7696005)(2616005)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:12.2544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee72cc03-588a-40e5-1378-08da2a084a75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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

Add the helper function to convert ring to queue property.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index df0e542bd687..8cb74d0d0a1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -700,3 +700,20 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 	mutex_unlock(&adev->mes.mutex);
 	return 0;
 }
+
+static void
+amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
+			       struct amdgpu_ring *ring,
+			       struct amdgpu_mes_queue_properties *props)
+{
+	props->queue_type = ring->funcs->type;
+	props->hqd_base_gpu_addr = ring->gpu_addr;
+	props->rptr_gpu_addr = ring->rptr_gpu_addr;
+	props->wptr_gpu_addr = ring->wptr_gpu_addr;
+	props->queue_size = ring->ring_size;
+	props->eop_gpu_addr = ring->eop_gpu_addr;
+	props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
+	props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+	props->paging = false;
+	props->ring = ring;
+}
-- 
2.35.1

