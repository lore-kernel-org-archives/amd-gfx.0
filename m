Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232B4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E8F10F28A;
	Fri, 29 Apr 2022 17:47:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E4B10F23A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUluIq17VZn0tdtNtaiu5tWduW+R6hSmP0R0vEncdrpxwwOC/v8JPPOIJ3sGkiwTcFulrs6J9WZLXGCbtDnSuAdy5pOa4epvUgWrCrt9f7zSdgaborx+X/nRI6AE0aPuepvXjiZwt/8g4YfQ95FQd1OqNIyoiNiwDxRof72RiKiqWVkoUP6JSUT1cP5k6aQvGberEXMsi0D/mgfydStGEgJrwHZ4zRR8BnqA+KO7H6we1AtDnNuD6Ki6MkRKIKH333/0uo7AJ5sl/mpIHcXOboRsRGHPuWPN+wBoGgfYLKcNFIq9wmzJoHesWBIg/jlhv9dn5q7ZD+D2aj2Jhrz6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knbXGX+UL5wkhh/YADtS326owPc6gF9RRMIi8+0hUdU=;
 b=aWUAdSR7FJ+b9LAnSwZYPqO5bRiZxMYcfjHtQ51CYnLGNF4htjhh/ZvxuR7fU8RDHjSlF57MBIRXveMyP9+5hx0LXlEHmTJ/vPbYwzLLcFR5WMNlcgDk0XAk5+q6ICiZ9lVIreqiVBbboKlgVHVCJzoIpXD/MsvSwHexcqkjrE3mhI75SmJylpqEFBk3n8f3u5RuAczaOgAm6MBk1EGoKEMoo33gG8wR6txCpEd+wsLdyM+YvBthU04hc/+cDpFayxlJtbHbtFwq+HFraq2cLay/uw3t0aH/WGxB5y+TGNGYJz6JeGB9p6K+g9gmj+8Vuaoq5chgMFcTgP9GQsC/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knbXGX+UL5wkhh/YADtS326owPc6gF9RRMIi8+0hUdU=;
 b=K3aUyfaQULTn65i7Q5JmgjECh4M3iVV+EZ71iBTWpfwJjsgDB7gIuzs9wz5kCUT3IgsV8l7Ea6tEYypw1vjzmnWUr3ygNnBFhAwcVoYsCvLWOFUkIspb+27bcd4lNFqj2Y6ZAwVG7Ahm4hO31vdlwlgrnKo79I+keGfmzVGiJWM=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 29 Apr
 2022 17:46:54 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::d4) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/73] drm/amdgpu/sdma5.2: add mes queue fence handling
Date: Fri, 29 Apr 2022 13:45:38 -0400
Message-ID: <20220429174624.459475-28-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dc21f1cf-3115-4f2e-fda8-08da2a083f9d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5145:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5145A3788F01E06CC6643E3FF7FC9@BN9PR12MB5145.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnQdbWiiqvWQ+4lrmLrhRoxxwwDvSK+XcK/5Vt5vnUWzsWgXab+LU97IekWwQvcD9LK6hHqMQ5buq5WrjyEnv+U6A6IG6Z1fsy0GzhvMgJoyIbMxXj7O7CFLnnOiI25CuofesPRmiOa1ivVg2k36QbqC0pVlYjS6qDJJMNsiKutOaiAhuaWHcQQxgqFD1N4IGFZz8pIv03blUjdqrCV+iYW6I9mVkyQ+mzhtkvFitfSL6RrqZaCQ1PFhZ5tXMi0V6nkFIyJj4yXKhofYiulOdaCQ/wahFmjTN8pbMqIS817lL6hLMxxmwfc3MuuQhgnEu9tCpEK/p+nEZPi9/Aw1yyI0c0yD511uYLMFE/WbtUuBiRYfD9CpNORJHB9mJLJQClnBsK0fyl08WhHvaU6bUi/6QL6NUQevQzwjvf3qWPTphH7oqlBoKLy7H8v5G8WLgIKRVj0jMdoDaaNjLhQADAcBIvHw4P7MoZ3a+9E9t9886dFv/feW80eofSmnwrAVAqerVgS368HjMEhJxeOmyCLR8EHAc73lqVHyLsX2Wq330ZGh1ilLvLK9Xjnwha0N+gNF0Y6L8VQNgGGQ2kWfh7oSJvDCQXk7GkUi4EiLtQla9BOs7xwoDhKRKdkZySXOnel/cdrh+NJQ70y9sJpPWuO2uZJs2wg6WfJTt5GzYmiyaK0TZzaDNavrn0UyBUq+gZD3RGX/GCmf/YU6vulbPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(356005)(6916009)(36756003)(54906003)(508600001)(316002)(8936002)(36860700001)(81166007)(186003)(86362001)(83380400001)(2616005)(70206006)(1076003)(70586007)(16526019)(6666004)(7696005)(2906002)(8676002)(66574015)(336012)(82310400005)(426003)(26005)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:54.0832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc21f1cf-3115-4f2e-fda8-08da2a083f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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

From IH ring buffer, look up the coresponding kernel queue and process.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 0b7de18df5f4..9f246ab942f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1512,7 +1512,25 @@ static int sdma_v5_2_process_trap_irq(struct amdgpu_device *adev,
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

