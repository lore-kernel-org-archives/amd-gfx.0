Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6476C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DEA010F6EF;
	Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876B810F498
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdoHgpLfdJe2BDSOrny34ZibFSbE3klJxToj64GIBtBNZzMniukYRPTJHhYyQipxwzYQ4vJJ2TGv5hr/n86qrFWV56Uje70udCO5/LOTm68UnQW9vW0Qt1EI+g8PHJzeHO4ugBf8S4mGJ01vvnQJo71JbzZzHss8Wel1vgFKT4xM96vE8aDwzuyncwQoF9LXpo9T89OJngbhZ60RpAfeFmfxqP01/HmJLjcFscn8BVmjDQNDBImitLc/KFHqJTu1IQo7twRiLDbcTRjzzKeVTBUGZiPpPsOT4ImA2Hk3HTmFbJIeyfqZaT1nBrth2QP2zg7nd5LVwbYhRrIdJYIo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tptqzq+Gy9jStWdHNy7GwoA5AgZ7eGQI0rozDq/ciHQ=;
 b=TdU4Q1fB+y66Lzo7lAbBa71NfaFHfH3ZbcKJCQaUmjbYas/LuH2ECKrKBN59pai4+hWf1Doy8z6WzqZ5MZ5w4kGWrk0zTaKKeK5px4eGTufh540iWqfVwrdr2B+EnsRR3fba3Qx5cCIvsWhODuxJuYQmQOrdO+VUGI57EFQ+BFyBIJA/uTyHdU2bakbE6Mz+2Igx9MgZyaUPylLchRspczWX6dPeHlR0jW/HdLhUUp161ve24tvOyQSJMKqYk8emHKG48zgQKcFGesTCGaj9Ym6ITBW9ca9ZHGgErsz51J1uxlJ2J8TL6brGhY2n++E8JEQfBaJnyd+0agqqBrlghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tptqzq+Gy9jStWdHNy7GwoA5AgZ7eGQI0rozDq/ciHQ=;
 b=3MiZTG8NElQ8Hfuxu55PRO5HePqvPqY7GyoJp1xkmZKPM2cQ8NenO1PiV1RbZ5OTsEwYJC6vAd6yh9TirQw5AW0sBBzzuCDC/7KToXktkYemtZmfDZMeK+hCcadY9FTO+Fo3FexP8QG1seeGfGRkt9uCIB9Sp46HWkbwm/VMPQQ=
Received: from DM6PR02CA0105.namprd02.prod.outlook.com (2603:10b6:5:1f4::46)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:47:12 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::a7) by DM6PR02CA0105.outlook.office365.com
 (2603:10b6:5:1f4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
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
Subject: [PATCH 56/73] drm/amdgpu/mes: add helper function to get the ctx meta
 data offset
Date: Fri, 29 Apr 2022 13:46:07 -0400
Message-ID: <20220429174624.459475-57-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0760fdcc-9d48-4206-7143-08da2a084ab5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4121:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB412153609D38D4D8AE083E77F7FC9@DM6PR12MB4121.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mZQo0TxWhBJOTQ3wX5Q5MVr+ZNeOUlX/E62wnxQMe+fIIT3lf4yaIW8rn0ggTk7yY8RaqM9at8nKQilz+Jq08PgpCO+wcv/iyAzwJn+2T1R/Qv2lC0tM5S5cjZuJmRF69cE4LacR+hYq8AnAdxE3Q3a8ZO6nO+EGtIZXKqx/YptuhTuJ8+Brg6Q03pYT7ZyU8ImXowHptRdIEqGjeNgiWxEejmqihlCrYTHUApDjVRUK8FlSuhsvdxC/reHIxhW/2YbIImpJvHIPyJsMcm67ur9SqQtjM5OD8FIPpqvLCVODqChii9Q6ebACA619BpM5/yUfgo6pB3//sdoxHmOlFJHxOw2dOXJCjCbF/cepViEGBLjc15mX5gutbMXqdXWxfpxFBFKm3V5q2UvQiNJw3G7/S2t2zu6ZxhsefYElvTvquzTJXykLDsjV6OOxI6fzAjXkO5gK37qKK1FKRux26ygCiQV1pR1MGqPfVaBuqSKl2xMuMhpXMp/51reFAuWKYD61c/mi72hfAWlKymGoLvOgJsTGLcSFTwQJfndZ+cQpj1BBPAhMvAvxpdbS9bftPifyKJfu4fg4mpeqQwkz+vGaZjaYGkoTkFZBNTd0So2it5HxhOvwD345aP6+s2z6ZZsEaba8IkM+JIRIv18R/u9PSxB7vGiAbBrVSognDmMLEvyoSxFCJmw77V5DPp3B/1RM4/MxI1tfPWUB00kVez31Ex9pwPCfpGEHaoY0H8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(1076003)(6916009)(2906002)(26005)(2616005)(336012)(83380400001)(66574015)(47076005)(40460700003)(5660300002)(86362001)(426003)(186003)(16526019)(82310400005)(508600001)(8936002)(36756003)(54906003)(316002)(356005)(81166007)(70586007)(70206006)(36860700001)(8676002)(4326008)(15583001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:12.6762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0760fdcc-9d48-4206-7143-08da2a084ab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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

Add the helper function to get the corresponding ctx meta data offset.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 36 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8cb74d0d0a1f..4e99adcfbb0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -717,3 +717,39 @@ amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
 	props->paging = false;
 	props->ring = ring;
 }
+
+#define DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(_eng)			\
+do {									\
+       if (id_offs < AMDGPU_MES_CTX_MAX_OFFS)				\
+		return offsetof(struct amdgpu_mes_ctx_meta_data,	\
+				_eng[ring->idx].slots[id_offs]);        \
+       else if (id_offs == AMDGPU_MES_CTX_RING_OFFS)			\
+		return offsetof(struct amdgpu_mes_ctx_meta_data,        \
+				_eng[ring->idx].ring);                  \
+       else if (id_offs == AMDGPU_MES_CTX_IB_OFFS)			\
+		return offsetof(struct amdgpu_mes_ctx_meta_data,        \
+				_eng[ring->idx].ib);                    \
+       else if (id_offs == AMDGPU_MES_CTX_PADDING_OFFS)			\
+		return offsetof(struct amdgpu_mes_ctx_meta_data,        \
+				_eng[ring->idx].padding);               \
+} while(0)
+
+int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs)
+{
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_GFX:
+		DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(gfx);
+		break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(compute);
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(sdma);
+		break;
+	default:
+		break;
+	}
+
+	WARN_ON(1);
+	return -EINVAL;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index bf90863852a7..36684416f277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -230,9 +230,10 @@ struct amdgpu_mes_funcs {
 			   struct mes_resume_gang_input *input);
 };
 
-
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
 
+int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs);
+
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
-- 
2.35.1

