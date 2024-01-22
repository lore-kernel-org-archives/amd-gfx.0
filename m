Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B278C47DD9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 19:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C013F10E79F;
	Mon, 22 Jan 2024 19:46:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED47610E79F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 19:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXi9gLZrLb46EQOz3sn6NY4jaebJsJXEzvcj+GQWTjErCwYvlw1jOykaRyHvobqrfAQgSjMBmirTs6OkAElHFWcCXYu6KgLAYgJa2bJHW47S/SyS63Ik5vGssx9fy9MVc0eWnv99UgnmQoPKll6x5qr6Nld+LeaKmbYQsdZ5MfWr/C+PtVO7gzJTtN2oxZ0yujUOjG/NdX5UeiTILZSD26ZFfpJfo14sTuWUFDnYReI2AOqHERpHpDGFro3oQ5Rc1UaAXi8mg5SMFGDGMo+ix04JC57e6uZMtj3dqZQ+n7IbsndiUmh1E/WNCn6X9lZq4R6WuG+nY9qb2I0/prGZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQwhKbzNvi7l+GrabmJS06rQce5DPxwxfvjKLOnG2J8=;
 b=DxCJFMfZuK7mOCcU+a0PB8leJFFeF83t2LmOmzeGL8HAUDB+WnjhpFQ1CeFMIszh9I3sKLSP4gKK+iRQzy1JA8/AYfvprC8Raf5TuEL7qXKQA+e1IyqC+KhyJgyv11ZTnAIydrZf7g0I2t2VJKWnxYMDGsOCfNGKcXiRdqy6NvFwCz8rogtsgityc6jjYSnfOlHyWGHqGsluds5g8EbJqp9o/jauFeb8Flu6s+XoN/C8udkdUOKQIhX0menio7PCqbevvnTR2lXoJ9LLgH4QYG4JonY8vIF4bN65Bxi/CxArYVj/OB/sB7ac509vzkIOVHw4Fl4JSYTKPomI9YjroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQwhKbzNvi7l+GrabmJS06rQce5DPxwxfvjKLOnG2J8=;
 b=45EjfRXr0Nliny72cKlMkq77+4JcMG0oxlRKpaLbItGwbVf4JZRJfWh0Xelg3pdKRhOaEe2X5qj9Kbyv6QhVyrlwta7hgzEbNHzwiu/bXhynAb0YuTHZ3OgRV3NbfT6gBQ0DkE2lg2Nwoosv4JVdgAdLaVrDX7kpI5mx24guegE=
Received: from CH0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:b0::19)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 19:46:46 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::7c) by CH0PR03CA0014.outlook.office365.com
 (2603:10b6:610:b0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 19:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 19:46:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 13:46:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs
Date: Mon, 22 Jan 2024 14:46:30 -0500
Message-ID: <20240122194630.1537295-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240122194630.1537295-1-alexander.deucher@amd.com>
References: <20240122194630.1537295-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: eee8c268-8cc5-4e6a-6bfc-08dc1b82ddf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2FsnCGGcb4u+edYV3wkSLNJm7LeshsiTtebA7M0989s7Xs886FE4Iqn8CR5/wn42tKB/v5jTogB7NWGuxbFsA38ZqJg7GZwKvU2Fan89t9pS2N33ciD+YZbzIvwDb0Fv7bclBHnyohy9j3gEfDF8JTwopBpoyA3xbffHLygzxIrHvj1+gbsfTrusPeu3QLSfx63EZ8bitOsYkM34TwU03ptSra/2X5AJtovjh37/FGzA9x2tZQewUlj3LwpWEJTRaZaeVac5sDMn1e6pKg3uK5NXy6yxsxpbbn1WCYUfUii/VE8d6DiuTWq8OiWtszQGF6uJVWc0VEODXYmxg+Eb89HgLKI9TGS6GjW/9lgG6nbmGx1sIbxAzYlLF/SJQm62Z3MF48zXXf3HBKbU164tKPwBbBNpxESIIwO0U0cBiKarfGCnuLbofWjHZfYOkKYytpWjPX3ebIYjw6z5NqRS1gE0mm137KUcqgEwHPS4/DGo7PGQGCR8CJ+Fy2pPJDyLPYqf+UT1+Xv0J8FrDd3V7qcho0jnSOihnALgSkdnWjyvEM795B6UGaOq5sIBcymNAlnx587WYWbY/0Evr0UQG0Uyjpvszg7U6ZOWE6nu/A3SMlrK7c1Ak8/P5no6fArvOp+aQUEdbFpODJ0BKQbozMze0XFf+1nnHZg1vrFaQzpHkuqUgUUu1gDU+WytwTMUC+Gn3YVpIzWEJVVIAX9ZNKqh5YnCx3XZGrhLeQ4Om4/1xB9f3YXwTd3BccWm9DSf/pqAVE2sGSp/blC91IgGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(26005)(1076003)(336012)(2616005)(16526019)(426003)(6666004)(7696005)(36860700001)(47076005)(83380400001)(5660300002)(2906002)(41300700001)(478600001)(8936002)(70586007)(54906003)(316002)(6916009)(4326008)(70206006)(8676002)(356005)(86362001)(36756003)(81166007)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 19:46:46.2533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee8c268-8cc5-4e6a-6bfc-08dc1b82ddf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This needs to be set to 1 to avoid a potential deadlock in
the GC 10.x and newer.  On GC 9.x and older, this needs
to be set to 0. This can lead to hangs in some mixed
graphics and compute workloads. Updated firmware is also
required for AQL.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 043eff309100..c1e000010760 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3846,7 +3846,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
 			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 15277f1d5cf0..d722cbd31783 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -224,6 +224,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
-- 
2.42.0

