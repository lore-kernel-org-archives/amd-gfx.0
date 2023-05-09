Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619EBC7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 10:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D66B10E382;
	Tue,  9 May 2023 10:22:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650FF10E381
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 10:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLeMvVNMPJgjvnjCrjl+SdEYrsLFcLLgXZrR8vcEjdKBs3u3HCPb2Y99xrdgTAh2r5bsmaBYSGxwmP8mnleJW8tQt3O6PoKorw/UN02PVPhFC0/4bwLgnzi+Ofxkpfoccuru4u8qLkZJWIzJUCHOv4lg5tFrXXiTl3dPgs9P1Rb9ya7aNX4Cd9ksbGd9Tayn4LaZJki5qzw32VFfZZPo0q/DCgwG3/htyCahuil3/594lF6en5TJHF4nASq7NWWbBF0Qt/Lf8BsHfgS0VIfn9/qlULHL64z6Rj6ctzida2zFgrxc0s0ZsKkTDpfZvPLzQLzBcGDPWlva1N1PX0RqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uf4QoH9yId1KMKVjffsvjFGZLUeZm5Gfbp/dprviE8Y=;
 b=oJBj5AHPV8odezve5SgXsu6GwuI+XzRukQEbvNL22tXmqdYj7F4XAIzeaEvDt7nyEGwBd2qS2khpVKohpJg4hKxrBGZsrHPTb/F3yhFdrFXEgjmLR74OdnCsqdkitao7LG1OGNt3frwJuCm7b+MY4fYdAIwBIK9ewIaMYIm0gG531LjKX6WfRHUAfAaj+h8m68uLawaA+aRFSCZyMYHtN2o3/17yqLUo1SUvEf8+arjZIFJgc0y5Av8QcSZjxNVAlzYTmLyowk1pYVLBGjgUmSQs4lm5nZYlHwte+GEJ9dr5V5FBCez6ibzAyihn1u76NqsJNi46HIT1zGGmXopB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf4QoH9yId1KMKVjffsvjFGZLUeZm5Gfbp/dprviE8Y=;
 b=YkY93QrDmtmX5rNGIJlq8LE+VfGuBco1LuMzsVB8H2omNNmGWdqw5fNelrYzgDhsxGZ19nkL+UnHaE66ndWLfSoLpgzmLRnEIK+ncGo0E0ZtfF1ZX6WzHNGEz9X057fDfvYq9nAnfC3gHwzfogxJmoujnWZIYJlCzF4o8ekIMIU=
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 10:22:54 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f4) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 10:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 10:22:54 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 05:22:52 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/scheduler: avoid infinite loop if entity's dependency
 is a scheduled error fence
Date: Tue, 9 May 2023 18:22:39 +0800
Message-ID: <20230509102239.2935744-2-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230509102239.2935744-1-zhenguo.yin@amd.com>
References: <20230509102239.2935744-1-zhenguo.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 63efb3e9-9d74-40b2-f75a-08db50775a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOJmeRc2XXqW/eOkE26VofWs9PVNQ1Y0o8Wwha5zReTUpGxDPfaXXd6gOjnrlfMdIdGq3AewdwTdcRs0MENG3guAAPMudpPc85CYACZY1nXJLdV5IZy9li9br/SY8WDKxShrWR6I5IbqfIkwgSgzI6rUKzdugnQAipVXRki2Dw08oNVZrdXsTJxwUmMr/+46wTUcwNtl7iPMrj3FyfOhGAfkTZ4w2rwIE8YKL0qZ7jY7VR40xM3wyes3X0NAj8YpwJCmnDeW+dOhkUovk6D7Xx/UKzzFKAq4WL/g6BCNfI+pbsNOZF7qttEHTd7G59LMrjl8Bego3XPDhOyQ16TTxERxoB8Zt4jIVK/zcaIkkOI1SqMl4XwjlocoCJf7UehxjH5GR2H3m0MprN+leFOqj/AWPFrgaHszcvYwNMSJRLjwCNCM6g1vhb4PTum/udMK6EiKwALS8NdFHEmo/ndVvTD8RxWSn4r3eYUft3XjCSifaFC2G6uIahAk56LRSIyZRNTpZRsKY2HzL5VmyrE5RX+C2KrC6iBHGIfVuEA+VQmsYqXYIb8GIjaOyKvzCJGdTuJwTBNXsVAyDhOHH9yLgqcWaaXbIdf32EojO497H/7XqppyHSBjERPL2L4IjVSO44vBawzbSN3fUKHhg8rU9NuB7ajOsZrxV1pr4X0v0UMGecZdvbx+8iklAdS9/RE1ELXJomTtiqK7/iSYF9XHDktQ5vcBAfMo4oVhCoSEeXk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(16526019)(36860700001)(83380400001)(86362001)(82740400003)(82310400005)(356005)(36756003)(81166007)(426003)(336012)(2616005)(40480700001)(47076005)(70586007)(6916009)(70206006)(4326008)(316002)(5660300002)(41300700001)(54906003)(7696005)(6666004)(8676002)(1076003)(26005)(186003)(478600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 10:22:54.4405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63efb3e9-9d74-40b2-f75a-08db50775a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, jingwen.chen@amd.com, monk.liu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
drm_sched_entity_add_dependency_cb ignores the scheduled fence and return false.
If entity's dependency is a schedulerd error fence and drm_sched_stop is called
due to TDR, drm_sched_entity_pop_job will wait for the dependency infinitely.

[How]
Do not wait or ignore the scheduled error fence, add drm_sched_entity_wakeup
callback for the dependency with scheduled error fence.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index d3f4ada6a68e..96e173b0a6c6 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -384,7 +384,7 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 	}
 
 	s_fence = to_drm_sched_fence(fence);
-	if (s_fence && s_fence->sched == sched &&
+	if (!fence->error && s_fence && s_fence->sched == sched &&
 	    !test_bit(DRM_SCHED_FENCE_DONT_PIPELINE, &fence->flags)) {
 
 		/*
-- 
2.35.1

