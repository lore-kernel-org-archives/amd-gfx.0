Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC66DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7323510F6A2;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C91C10F52F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC2ida1HZUFfI6XbhoLGg3YTxziWIafkCcgCYYU+3cqwrEieQ82dA/iq9qAV2dI4wCoydIgaOLCqHTpo3g40u4AFBCJyvJRCth73XEy2m51DTADLW3orX2KTnOaJ6fbrNcLQ8o/U8RBYdS1qY4PsMVxBWFGjh1D+zQKZpaVykp85V4P24JxZuIyMGXO3dPtJEork+0svxMSjZevwWpCCsm4n+WFlX/hKe3uKgvpyS6O1wj45PTC/NSj0oy+gyLbpScxgeaO4zQ3TKPcGCgVIpLMhxiXjbd6eqtKYH+dzg5p08+HuQzPkse4BGhB1SapsA8pYxP6xQJKefBWhhAfFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yqic9u8585TCW0PTbdIcmvuV8XFQrPovuhtG7lgb1qY=;
 b=IDzzmIjIoZICT7Symf/oFaI3E4B3yP6hZcYP0njUNiVPC5u+f4pwtbePDneCxl22jJQj6mUTa/WDW68ruQ4YfAu1QL9K/ewu0oociv+Df73uCiBAh5O/jQStLkMesLPW1yaejaTEdzyAm+dpo/5z4C4LuoJW0ynSAI3h9e8IbKaEAhCXapAUp6sqrs5r7yYBV1lnGFNx1to/k22hf+ceKKShcLgY8xEGXRnSuuD3mLuWkFkG2zw8Q378wxdvFUg5aQumPSSrvcSIIJJ5SUHhVfMK/Hd0qIGvRoZzPlcg56GDVBusIThmGpvT/maBEBjcB41cufePqlWM9Bw43AbmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqic9u8585TCW0PTbdIcmvuV8XFQrPovuhtG7lgb1qY=;
 b=R4QTnRk+mSKx97r75IFWYVLoiAIujXQooPveXi1/U0ECpTq14xCmOqx5Ifroc0fvn9jE0Ev2FXieYBynQZeIdeuKTFLNf4MXgwuFV+LaVGjKR4PkRxRWfX1XvS8jW7PX1oPRQD5TDY4HNpVlN/N1k8VavBT5/23u7NFK7tulIFA=
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.20; Fri, 29 Apr 2022 17:47:02 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::c0) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 40/73] drm/amdgpu: add mes queue id mask v2
Date: Fri, 29 Apr 2022 13:45:51 -0400
Message-ID: <20220429174624.459475-41-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67af9456-ee22-459d-68ca-08da2a084499
X-MS-TrafficTypeDiagnostic: SN6PR12MB2830:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2830F1D72B80D82251D63906F7FC9@SN6PR12MB2830.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFr8PYH7n9EEhooWSjw5a+BgR8vtFftTWBOMu17MZ9uON3CuOop7RKKINstfsBTnBBhZWcvCvwuZW320SAICvWzPDQUbES9b87KJ2buaCXUuOjfYCpcbMRCBFLEXTb6mN3joQykHd1f4VjeFVX80JVF+r5DJ64wvk1RUbSsoB872NPr5sh6E4ikAm1uNTyXjPAY07OKjWWJ4AqKh/uSpgeKgVwvRV025nCJwc9rk+uir3jRoICef96yGHR3HbNVWYOPJ5ch6rWYyTE3rnthfQdU6AmawtKN5UVT7Rs6zxerVzEvQRxqdmNQaX5/szMUpN/d8n9Xd9piDxZ/6LayAuH1NqrseLITo87BkdwLA8naoO1wqNgDzsLU6wHTrYol6DU+bg/SmszeW594Sj6+i7OijUPnESn/qD9T3kKul/6qN57pynXej7w/+81qagkzjJDx4+/So3AClYdowXxvq3Ayzb6hndqAx/JweOYAkiAPdlMgm+t4dyrnIG0RFHrDQHaP7ipN2iQ7U4O65xbcFexd0HEnYwY75qCG3XcwNVAwPEIYuh1db0yiXrPpeSRhEMqtqZ3iRQxqMoIamh9SJAh9xNiSLBS6wai/lnB5EwNRxRmkguWf93b+052QT0/cM3qpls9COzmIAx05QRYMNHFL0GEpT6FqiqHJfAYDDYB98fNc2xjrRg6kMzxkt4ct76kyQP4LYoWqX97RKoD7ueQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(70586007)(2616005)(36756003)(70206006)(54906003)(186003)(356005)(4326008)(5660300002)(4744005)(8936002)(336012)(426003)(40460700003)(16526019)(8676002)(7696005)(47076005)(1076003)(82310400005)(6916009)(6666004)(508600001)(36860700001)(316002)(86362001)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:02.4262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67af9456-ee22-459d-68ca-08da2a084499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
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

Add MES queue id mask.

v2: move queue id mask to amdgpu_mes_ctx.h

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
index 544f1aa86edf..c000f656aae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
@@ -116,5 +116,6 @@ struct amdgpu_mes_ctx_data {
 #define AMDGPU_FENCE_MES_QUEUE_ID_MASK  (AMDGPU_FENCE_MES_QUEUE_FLAG - 1)
 
 #define AMDGPU_FENCE_MES_QUEUE_FLAG     0x1000000u
+#define AMDGPU_FENCE_MES_QUEUE_ID_MASK  (AMDGPU_FENCE_MES_QUEUE_FLAG - 1)
 
 #endif
-- 
2.35.1

