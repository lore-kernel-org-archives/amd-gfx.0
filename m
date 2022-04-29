Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4761AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3002010F178;
	Fri, 29 Apr 2022 17:46:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36D810F126
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRmPMihG2+kXLU/jtIf+5B+mvjDc2opKCndDWKcEJ0l4sT1TIrOpt4ESiK/MFWi6R7xuwJpGKWJlOMULWevHyjNhie1YgpuaMgQtYDiQXBJrtCgPb788b+/52ZQxc76RAt9kZvkw+t5ai8hHHMcKhhJ307iMfqOygwKBW5rYei98eF/C640fEFXCLpXuEOLf017f3MYC4Ar411Sv1gxVZv7BD5VyFolhz1oTPBipdRw6bj3/oxSjBQxyhp86uBFg0HTQhzIIlqD7JqrcESFLDcDcInIUOW0tvy0uDlWk2gp1UMcZEb4CXh1+OGQfIm32ImWatbClvqitF+i2OLQA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miDn9Czu2NMtvP2c2TJQ3lMRr2nrlvpAwKzr8KkjsbM=;
 b=dvv9lAi7845AKCxfOluF3letN3ikO8lGo6BLLcr/5CcYg9pf+RAgYOkbVIrlsdcBUWpiWB+MNaEoBGT25KilN9Zovjso+ertWC+oMpMgdxvNZ1guVejgaJZHFe6fAXYcIG1sLXBr09SWDklv3qvUJn9Ml+L+oOf5NkE3PEZmEM2rtx9FoyIjOTMF1rup2Zfg2TkrG/IaiD/BG5YpDuXuXGfxEP0NCY3j+Uv1bU5ZyrsLnrBdHU5Y02avJlmiL3f4hK18oVdR6PaocJhXWc8iyi6x3z3ayK4Ls4f24JC3LzXlrbr85J1tMLsomztQjid49jMDzbdWK7H/I5SgS0tlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miDn9Czu2NMtvP2c2TJQ3lMRr2nrlvpAwKzr8KkjsbM=;
 b=DSuVcXBlrFWCCNRd/C9WG76uqHh8DEnKHUzUmK/2dBISFBFKjRPHDQu7+/HUrXjcOk/l9xVSHpG66hDTfTahPNj5+qCmON1B38a2UmWNFerzUH4Lni+5XskpmSSlZi802ODJNiGJyD/JjO9b5lk7lRHKorI5jWR5PvYRfICXoXQ=
Received: from DM5PR08CA0052.namprd08.prod.outlook.com (2603:10b6:4:60::41) by
 MWHPR12MB1776.namprd12.prod.outlook.com (2603:10b6:300:113::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 17:46:40 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::54) by DM5PR08CA0052.outlook.office365.com
 (2603:10b6:4:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/73] drm/amdgpu: define ring structure to access
 rptr/wptr/fence
Date: Fri, 29 Apr 2022 13:45:16 -0400
Message-ID: <20220429174624.459475-6-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6bbcd7a9-debc-406e-eb78-08da2a0837a7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17762F089EA0B3F6B3292E3EF7FC9@MWHPR12MB1776.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNh0TP3sQ+hauwJyX/OfE16RCxbIFAgtdtVy0DvmorCo8TGlpnUheGv1Jn796cqwYv9rtAvxU1z4lOJcKelKeftGETxkt16iRGoD+q1OgPehx1rCzPHHy3SJgj0G6PF5KTfHRBkNZvB1YGtAb9qi5ozZv1vMgMQFmlbqPYwPYRI5okcufOBjByOFZqlUpqiyLtdixwOSdPcKhI8QzEwHRCHBvoOQMXfgEoyupnZM1DX2oaSdqv/RF7je8PRL4rfhIE3obxbjpeWv7CayIfqHhqKvu3xDuShlY/hb5hq1KG+IJV3uSlYgmbdNKB4u6xzrVZ5IgSwolrMn5Fwz4QPW/sYRTzjHRWCq2A3a1zqNH0yjGYqJLc+PZZgrcWERAwMAnCofNXcdBZYnjwJEFEFK/P+D7P1dL98gOXOIFFjGhPOz1KQXvQ/xDRQecw9GlP8877HcLEqCFZNsM51NfvTcpVIMMpm5j8lVN5S6zGxu3Oh/yobd0cFghYSPw/0RMhNP3WLfCbP3AugerPHU08pNzSsSQhSUa6aVOUFXh5b7qSIAUhSopIZBJr3OwWEU6CDMiWT34Shjue+ziN6D7pnM8qiUMbA4Dwsdp2wCm1I5t09p66RKFLQwhx7ajggrGHjKLRtxtvkAGTY39z6tjtbI9c4Qy4IK8u1YsL5ukT8hE0FbY9m2m0/CpffO6Jh8iPt7zWmMg1fCm0ZKd4oXzOwLdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(26005)(40460700003)(47076005)(86362001)(70206006)(54906003)(316002)(6916009)(36756003)(2906002)(7696005)(6666004)(426003)(336012)(1076003)(36860700001)(2616005)(8936002)(16526019)(83380400001)(5660300002)(508600001)(81166007)(356005)(66574015)(82310400005)(186003)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:40.7265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbcd7a9-debc-406e-eb78-08da2a0837a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
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

Define ring structure to access the cpu/gpu address of rptr/wptr/fence
instead of dynamic calculation.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 317a66bcd258..7d89a52091c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -230,6 +230,8 @@ struct amdgpu_ring {
 	struct amdgpu_bo	*ring_obj;
 	volatile uint32_t	*ring;
 	unsigned		rptr_offs;
+	u64			rptr_gpu_addr;
+	volatile u32		*rptr_cpu_addr;
 	u64			wptr;
 	u64			wptr_old;
 	unsigned		ring_size;
@@ -250,7 +252,11 @@ struct amdgpu_ring {
 	bool			use_doorbell;
 	bool			use_pollmem;
 	unsigned		wptr_offs;
+	u64			wptr_gpu_addr;
+	volatile u32		*wptr_cpu_addr;
 	unsigned		fence_offs;
+	u64			fence_gpu_addr;
+	volatile u32		*fence_cpu_addr;
 	uint64_t		current_ctx;
 	char			name[16];
 	u32                     trail_seq;
-- 
2.35.1

