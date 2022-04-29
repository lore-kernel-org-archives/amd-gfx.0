Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3E6C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FB3310F163;
	Fri, 29 Apr 2022 17:46:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECB610F126
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM3IP2xBm2yu0F5ywJ+RPr38o5+HG8lThXIRwCG4IQt2W7ARTY6EarZl06bCVpVqf1WQipmQIGcOa0Viu1FJvf9p55/fykM8llObDG/gNC5x9hu0y3xdwRG7sWKo1plXxx62FwRcvAr4Ti3O/CsPFvfQRttBVX9kdCXJeSOMc08W1jyII1M/GwKQDb4CIbM2Q65FF/EKhTd7eDlp2qCE+4ZU1woMszSOZ1IEEQjb081qo1ZgvlcK8tP3/ry4a5cHt8y2xnTWN8+bARgQ284VOAw3+E2uLF2Z+lFMBocwPmKG9tgMZN6Z3xWf7AkJWLCs3W/QvwGZoyujQarni5qjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUZuJrRidtv2Do58vigMiKkbSoFjKgVURfr06j3EjT4=;
 b=i0eM9GE3lf8Ytg3lcb0tKTK48WkowBfuZm7gzgfLSZ11fLWucG/yn8Gd+yIr/wgjh92PveIU+wsB/DoEtk58C5cXYxWdV51vylKcq0gxFZfNNNEgtl81/ZjGDfgZ0FJBhsgWtVMISJzySTkV25oZIpSgmYXWyNb+y2f3ON01oeHOLeSsMqLgtnV0tRMdWTw3DwH3RkDtmJ8rOFTRCmcFLuXmh6CMXEuFgeDzDljjrh+n1fZvxmfK4TP5Z3hflRGbY4Xy3AYMLCmCDr6RUhcmNV4KBBgQRi84zZEiiH3DzvP7EsTcm5GCpP4pgrG2fThEpvvc8NhePcFLqnyrIrqkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUZuJrRidtv2Do58vigMiKkbSoFjKgVURfr06j3EjT4=;
 b=O6SjiLCrBJervNsBx6Y7Cn+4LQhdVB11eNCCEFiaI48ao9/qzPxCOWpoOTFiMDjKywsIkRKQLlTuO/G2On7Y4hGNST//8D+zJjSAJmZxdKZxzd+yot5ZgHDz1pYQDzvFZh6+fXFhGh1wDgFcViN7tZRWHumRdvASceed/qspyhg=
Received: from DM5PR08CA0043.namprd08.prod.outlook.com (2603:10b6:4:60::32) by
 CH0PR12MB5313.namprd12.prod.outlook.com (2603:10b6:610:d4::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 17:46:39 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::fd) by DM5PR08CA0043.outlook.office365.com
 (2603:10b6:4:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/73] drm/amdgpu: add mes ctx data in amdgpu_ring
Date: Fri, 29 Apr 2022 13:45:15 -0400
Message-ID: <20220429174624.459475-5-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51a5d873-1095-464f-69fb-08da2a083722
X-MS-TrafficTypeDiagnostic: CH0PR12MB5313:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53132AB0F707CEF3E706824FF7FC9@CH0PR12MB5313.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0R+JQEUG4Hb3HzE6auo9xunIozhsf1pDYgJo/idoTXP7jWE1mBzghUCm/JICXUr8BF/wjIcuHoBTmi6W/yHBmqikebjUiBJoksmgyjZM3dKwfxBofJE818ZP9JnGeAmhKt9WAfmXVPvYH+L6lCsrIkX+dRCiHGyQRkz4dCYlF0KME/t9jZHhxuhonPuZbE53JB8DD35pIU+6vPvMBlOL3C5LXUc4/d8bERiacAJ2KD4vzGKxycT1ufECw8OYJoSu7PKAbiSNbMqkQeH9EibLXr0w/MdM9UlFQvkWS0oo0JDiMEEfQn/tt1YdQjtA9eABBUxcWwJB2n/+MVDjr3bxu9GOoC0G9kgnTUIB2COF1zCcfI0vGU7Aa8YuTWipiO1sOf/koKIIGaUnZjhv9gQtRyhehhJY0arZR2HzSZd4aEuLzsjxhqsYOwayVGVyIsRB/GbGS5u2po70/dSt39n8uYsUI5zzWvzLYIc6CJkTbWUqdbSIMGEpq4WJX/eGf3/ZaCkvxOSvW4KLpiEOi5gBQ9gAOU7So8T0i+GGSeGwMs33Unexr+X0L/NmkL9qLbUumTzmPUDh5EoFAk2ZcKTnGaXpGz3J9XimnWwscTBLCNa9LmSwX49bsozCgqb//5/hWytQJdOuuiA+DpVM7NgSJdfzXMtKbtreux6iqNZJ12LTRfiMbxU6xotKbSs3ovb/T/VYjn6CscwWZL3T4FkZCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(8936002)(36756003)(5660300002)(508600001)(16526019)(186003)(316002)(70586007)(70206006)(54906003)(2616005)(8676002)(6916009)(82310400005)(1076003)(336012)(47076005)(426003)(36860700001)(26005)(4744005)(81166007)(356005)(7696005)(6666004)(4326008)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:39.8516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a5d873-1095-464f-69fb-08da2a083722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5313
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

Add mes context data structure in amdgpu_ring.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 112c2b0ef0b1..317a66bcd258 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -267,6 +267,11 @@ struct amdgpu_ring {
 	int			hw_prio;
 	unsigned 		num_hw_submission;
 	atomic_t		*sched_score;
+
+	/* used for mes */
+	bool			is_mes_queue;
+	uint32_t		hw_queue_id;
+	struct amdgpu_mes_ctx_data *mes_ctx;
 };
 
 #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
-- 
2.35.1

