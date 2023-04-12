Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3063AC77B6C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 22:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F0010E9C8;
	Wed, 12 Apr 2023 22:25:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E807010E9C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 22:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n00NxJifapTuDqvo10rSLF3Qsg3j0k+dbFWmWL55ziIoqbFtRiplrPJdbV+fmh0moZkvZo89CEfqw4+beZOpXiaIK3LXk/JCWrp2q4woi/GuC+ZZoHnv7sEMmYYpwaXX8CYbJ6ZcJxzkK01SaiakIlti+oPizJihEYkQbZtIniynHpNXXYBhvcI768TClcfv2aNqpzRFNTQbLT+jbAYMOrf7lOzGGVuZxrx8BctGw8agUlTjd9BMJSwXaFcXqxnoY5J0NpjipM2Bo9pz53tT3bXQze6+QpxnWnICLVtFA6jueFXc0Eo31rWfxFMQbuzAa8ELolnZukqOtYbQ/hb4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgQ1HVIeJxNmgaOaHrzJ8DQI5ywCOYRCnV9iREMEs2I=;
 b=MwnPNVVLnuvQKSezJVVEO2e4Ckcf75hXY+YSk0lPPm6VNMvBb7isHMkWvMC4fYphwAssGYWwxYrVPWUmD53TykRST6l5HiQoBoZT2PWFToSLtAb+cTLeX9wpRYkuMICudHoEnvSznSLrHlAY9mOZFgHvVb+xqykBSweUXQsA9AX52xij4y9Y5j1wHNwJxkUjSzJCrT3PW4DrYBcPGoYTP987Ty62Umx0pm94vlq5pJEHCZ7ttWbhKC5EgTpMFw7BbMX3aFo/35SHBkBj6dBJxvHCbvJLHyAW7vWaBtPlnXBquRlgKaHEoME4FRcQT8OIXqlGjCb5aRkI/HOPIQWkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgQ1HVIeJxNmgaOaHrzJ8DQI5ywCOYRCnV9iREMEs2I=;
 b=2W5S2aZhmyWgC0E8uRZG/ig4uUz0Ws64eTqMoHkj3meAqRLMi9MoILkFhj7+ifa5cAQPxD51HRE4k6q7KJFay5lopsqpQPLktMB7ggvZH8l18sAyTIZ0ZgcX7SqxeBi0Mbc8xExf8oOQ9Tn/tUtIbIYjgdgUAY10VGEKaFYQUrI=
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 22:25:28 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::8a) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Wed, 12 Apr 2023 22:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Wed, 12 Apr 2023 22:25:28 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 12 Apr 2023 17:25:26 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Date: Wed, 12 Apr 2023 18:25:11 -0400
Message-ID: <20230412222511.236384-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: c04c4ed8-0055-41e5-0707-08db3ba4d1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RbWe1vZt9pGZLvPse0L3OypGJJu011+6XZLnlwc7U+iptnlawyxJMUYXHGN7Lg5lZG8o+6kctkyjLh37V7lHr9SGO2o7/YskTtR1Iz4tdJ8QV8llv5FEw32rDClBh6geKDhZScbstuANxfLzRLMfu0BVcxkddn66PVm+oK0y7Jiw0NEN9t/cbEVk1PsC8qmMl180/wYp6WMkvQIhu5JFnRomkZ3oNjeSsa20aXyVQJBDnCR5tYeQxPuW6dJgCCsiZxwSRTed5im1ZxkYd6+c8rrSwRpKDWSboVHr4PebXFe72iv3QOpby4fgOLMTh6Bou+NPcTZAVWLyM7Qs2sJh5mPyMK2uNHA0dEHTy4LQapR052jg7lO8wZ/PdLQI4ecPYc6eWCrW18v9NKr9ofvHNkm7iuw4X4ClDph5vF5tZ47Q2BXmr3V/viF1Eowlo3liijv6UfkwTpWyE0Ch3A0JqLqJaSfmqz4yDb8XBn/CRtmkqRbNY0rNaQaaNtx+km/hlW9S8QH1PObF45EcgBWjY512Eqb29HERDZWJcN22MprgqL+aEIo6AtucQ2k4izNphjxRi5d0qQFODdAnHjcpB8Yuxxdi69PIXQkBR4ht3QXNTwRVOd+Y6dT6ddRHp2PYy9b6BIyS3hqQWjG8+EXH2+qay9wgMTwJkr2G5zs5/zauOdZ6YI44NpsJDktFowaMbbKtNc5i/y6ULftxJjrVfOyTEOdT3FRRs+8aYIK6bI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(82310400005)(2906002)(4744005)(5660300002)(8936002)(86362001)(40480700001)(8676002)(26005)(7696005)(6666004)(1076003)(36860700001)(54906003)(478600001)(2616005)(47076005)(336012)(426003)(83380400001)(186003)(70206006)(16526019)(70586007)(82740400003)(81166007)(356005)(41300700001)(6916009)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 22:25:28.0930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04c4ed8-0055-41e5-0707-08db3ba4d1bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to avoid redundant eviction for KFD's DMAbuf import
bo when dmaunmapping DMAbuf. The DMAbuf import bo has
been set as AMDGPU_PL_PREEMPT in KFD when mapping.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2430f3e9f3a7..64795fe9eecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if ((old_mem->mem_type == TTM_PL_TT ||
 	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
 	    new_mem->mem_type == TTM_PL_SYSTEM) {
-		r = ttm_bo_wait_ctx(bo, ctx);
+		if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
+			r = amdgpu_bo_sync_wait(abo,
+						AMDGPU_FENCE_OWNER_KFD,
+						ctx->interruptible);
+		else
+			r = ttm_bo_wait_ctx(bo, ctx);
 		if (r)
 			return r;
 
-- 
2.34.1

