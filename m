Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842D4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0449110F29D;
	Fri, 29 Apr 2022 17:47:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7306710F6A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV1Ue56fhJGN6wnyX8hGjCcCIuWvK7aok+oDXRAPQ+T3lyKmdB2ORBEw2OebhIAM9sJDXCWucZYK7T60luRky/uWSLwW9fy1STMRxw219/G7FIQZtJT+Uku0BcTkZohMN4zKfZx2ocRJzrhnirGlAjKxVliRpBM/wAja1xoyTZ3Nr6S9F3MLs94Xrm04esfDnDH+4qOHuueErkeXKcBHYi5z9soCgmvLDAouQJHIk1FUyiSonBRPaXT83Ync16hm49Je1WqZtIt5MQGpIZw+ncwCrP8AqS8paYdzhMmHvdOPOI4bwSYqV2ejbiWT9L+LHtMY8zBk+qs95MQZKxTC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xkkr7AJ6IAZ0eHGhdfWLhvUmJLZfA6DL+Ogd2WTI9+Q=;
 b=TVQFZvj2RHRT+6MhoYDmMGyZm1TSoW2tFVZ6RjAGnLiSuib6wRtcydam8zKwFcuhELiOv+0sS/zRgyVfQShBZBuG6VxHy4clOadI9UIuFkuojtVjpmL5VztyERjrnZ36PQovbPYBsjSnVXFh2hM/x0AeaBBIqK7sh10MV5pdEpqxetBuFtNEWZUIuNZ3nSieiMsQMh+z62+GvCQOgtQgmQwdzgX7cg/wiY0MaFbRwmonbxYkl7XrYxP8P73A3pykXAlo/VmxtyZINsEgDt4nw6tIHxcMxGba/yr+XlTP6sVR1Sty9sM1WwispQpYOWVgQaU6uMkV8taGnBTsYu86Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xkkr7AJ6IAZ0eHGhdfWLhvUmJLZfA6DL+Ogd2WTI9+Q=;
 b=Xcs09ykHepmndfH6P6kD5z4r18VdYWzeSZrOAjEapovAfLvhv7lBdYur/Ca9gyU2YY+gHPkNxJHU2HOWFR8Cwi/78drp7pE0hpijvtAEzEo0H04/RVCN57XmHJEFp3E1c53rpmT3U+d9TuJC9g3zvMbpCJCMIRruVZPThM0ZRWw=
Received: from DM6PR18CA0023.namprd18.prod.outlook.com (2603:10b6:5:15b::36)
 by BYAPR12MB3448.namprd12.prod.outlook.com (2603:10b6:a03:ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 29 Apr
 2022 17:47:18 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::ea) by DM6PR18CA0023.outlook.office365.com
 (2603:10b6:5:15b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 64/73] drm/amdgpu: skip gds switch for mes queue
Date: Fri, 29 Apr 2022 13:46:15 -0400
Message-ID: <20220429174624.459475-65-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21f6db33-5c0a-4504-6d65-08da2a084e16
X-MS-TrafficTypeDiagnostic: BYAPR12MB3448:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB344821342D46CFFBCE947DCDF7FC9@BYAPR12MB3448.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +P1MDC8jifU6ASfDewjTyJZwYNNLKFazenu/fhNmPiQj5itpCe6ZaQELR4HfgYpQDh2Od39aX5EqWh8Hgg4fEp/ZJ9G6c3PH7XOLkWHBSOmkUKuec2e4pSSR4630J5kq31hP9mzeDpPneo/JQnyA0C2NkqABOhY9xUVdpioyc1l1SQsXBxb0lUkjkesJbFS1DOLJ0ygSMjPuDk8n6X7gA8AXYHgn0Km/ZKFcI6hY/qfkVrrbmV+twKZov0bEh3P5QVQ7r65MzUs8PiEHig18yOM3cwqZmpGgZFdtKBCsEecCvc8hThwUGdqMkV8MG0qp+B6D64gunzUXuEW+GPrtjzYkp/QoA1mdxP6gPJqTu/eQ758agsBuYy9sns7uoxicTzTp16H03oSd+PVUKkPTHQ7gxSkh49Ht51DQEgeW68sfg2t1oV3tA+UVRH33qGV44JjVKMKoPYwKF7YVxwCHzKidSErIt1cI6O3f+S+tURiPwB0GxQwvD0xENXKOAmkMs8LYbbtN2XQqdmQc1ZnfNCZZZ7FFAbXeMouP21APpjQuiNy5/2oCbdxeXGmE9dTlihCckvKVdKZOGzlrTuerTXTR5Q2zTM+XtrCdrxy3m3XO16GrZdy0xgAP42sV2ZfFjATEfQadrZOqTOy78KMO6ZLV/Hep/l1AK71O3hykKY9enhBOZySoChO4ksXSv1+uKuNQvf9PpCDnA2ajtmSbfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(356005)(81166007)(70206006)(86362001)(4326008)(70586007)(82310400005)(36860700001)(8936002)(8676002)(4744005)(2906002)(83380400001)(47076005)(2616005)(1076003)(16526019)(336012)(186003)(426003)(6916009)(40460700003)(66574015)(54906003)(316002)(5660300002)(26005)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:18.3450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f6db33-5c0a-4504-6d65-08da2a084e16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3448
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

For mes manages gds allocation, skip gds switch.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4736174f5e4d..7276b03ef970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -639,7 +639,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 	dma_fence_put(fence);
 
-	if (ring->funcs->emit_gds_switch && gds_switch_needed) {
+	if (!ring->is_mes_queue && ring->funcs->emit_gds_switch &&
+	    gds_switch_needed) {
 		id->gds_base = job->gds_base;
 		id->gds_size = job->gds_size;
 		id->gws_base = job->gws_base;
-- 
2.35.1

