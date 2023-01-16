Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C6C677F1
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 16:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528C910E2B7;
	Mon, 16 Jan 2023 16:17:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E763610E2B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 16:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTMEElf+vkncnDZMUnALUFl1XT9nRmzxJk3FgL3EJHJDyBIKaml47Hox0XnEEOy4ufZRt5qUdGT9mP5URoJot7XIxzsKCrbQmv4VkwsVz1tJ+uC3VdX8T17liOfD3F5tu8+wJzTSec6ACy2/VsMGjVS+uhuBtLJXBFlzuilg2eNC42jNAU4S5h7B9efkzbUdxDdgrXRt7aznLseauGPSj29mDCV9tCj81FICvk8EhOEPh6qt/1rFkRz40fHNVTB2nKw54632ajwAwSJZubHoxuFZlr3BMeZ2miZwvn4G1V5FArXSl1CaV4wRIAvdshbI6wPRdP00r5J0Ftb69olZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+1yyy+bPUtK8dgyn940UxrZc2+viYBrTNAPIFRkaj8=;
 b=FWUDyLJc6R3I7A2BykYrPOgpkYKXvSEvvIFw2Io5qOHqM12IHbDqS/0Id3JRtJW8WJ/TTwZRJmGCK3AkdThX5ySw8v3aOZXbRV7vp2xX62tVCeJtiTSDUyTN1F1NPGIfcPITMu9w1c59gV3rWh1o40SVTyi+M0pLgoFwEB5ngHJtNiWijMXyvwammT7taOPm/AZMIipLNpDFEH4XQr7/D/tJJaZiP9GL7fELI4c5lSfHxw8oejOqXVu1TlcZXK3COCY2d6FOnxcEbYMbW0eZ8JMcg2g2QW7FcAElOC7W384Pga3hwHEhy8kVz/cNacwmWF+SEuYsKN4d1xryJ0rPNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+1yyy+bPUtK8dgyn940UxrZc2+viYBrTNAPIFRkaj8=;
 b=mgi95sS6ESc1R/Vw6gPFyg+n7Z+vbgx/bAM/gpAInw1+Eiga9Q0ONvDG3VUKjcK/Jhz2eqBRhPl/itegBw8T6l65Kh0ewSAeYljMTidTHkXabdWFMTy5gnKHcK52eFi+chMsJZVhPupPKzS4R41DuOBmWW/N5roymJBoxAOWL3I=
Received: from BN9PR03CA0646.namprd03.prod.outlook.com (2603:10b6:408:13b::21)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Mon, 16 Jan 2023 16:16:58 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::d9) by BN9PR03CA0646.outlook.office365.com
 (2603:10b6:408:13b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 16:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 16:16:58 +0000
Received: from ubuntu-Golemit-RV.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 10:16:57 -0600
From: Leo Liu <leo.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use the sched from entity for amdgpu_cs trace
Date: Mon, 16 Jan 2023 11:16:29 -0500
Message-ID: <20230116161629.6450-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: a1973aa7-1836-44ce-f269-08daf7dd17e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SD0HuvShn8Y1T5wvLYMkEn2/tjvGhZko5u59MTEPdozoeYoZe/IUml2/2cIamkRGZUcs3Kfq+BiyJiFNB7ikMneRd864oEP+Bqc+q8BhEDF9d5ATXv101TsIWoju4BvJ5ZrWEUqreFWcWinYtyEwfBx9Z6nUpOf846te9hIB4pHHC8LvZ4iBxeh8B16sOF/tLvleZsA2LEYIpOvTM+Kme8PYg9RQbqShotDfmc7jb1n8hu4VW/5brjhdt8+m86n00enrW1ic0Gq6/QBmc71bieGTKwni2jAJbGW9V0I+XvyvvhASQl7VX4u0nGrV5Iub7UuMkVN4PDszrrYhEMFjBIo4ovHuYpX+wOtBYbIRPDLIy11ruI8VuKU+H9cEIyz4lxY7NoOVg9JzK0u2OwXGUEfLWjKGuwv0PbXFPG5PSe/qHPuGCYQ5vwHjXlBoKYK6DUwMCBc1Rl63FZA3uGgM0+ScUkxy4zwT0ZWrUbVTqmNzxeMurZ4ihHz2lRmeycRNy1oWds+K2aTR1S3ZemVd/oB/AfchHapXFF/lk21urhJG8MBUEQnhCvLBycjwWwlsywW0oorJFeVewh5XYrHXVnQuAIJNMiJp9gaK2y5dk3SbglkKgLlxb+FOdGmqqyCiQExdz6QynolXRtXcMW1ysgEJK0zDD1URXNYzw1iOW4OOvZSl1F4CNLWnCmpe5sdi5T55gjPSSOHqWhFkUTFY+cXU40uyW5F+4FkMc8RpDjY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(81166007)(356005)(2906002)(4326008)(70586007)(70206006)(86362001)(44832011)(5660300002)(36860700001)(82740400003)(6666004)(8676002)(7696005)(478600001)(40460700003)(316002)(6916009)(40480700001)(82310400005)(41300700001)(8936002)(83380400001)(47076005)(426003)(2616005)(1076003)(186003)(16526019)(26005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 16:16:58.6394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1973aa7-1836-44ce-f269-08daf7dd17e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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
Cc: Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The problem is that base sched hasn't been assigned yet at this moment, causing something like "ring=0"
all the time from trace.
         mpv:cs0-3473    [002] .....   129.047431: amdgpu_cs: bo_list=ffff92ffb3070400, ring=0, dw=48, fences=0
         mpv:cs0-3473    [002] .....   129.089125: amdgpu_cs: bo_list=ffff92ffba4b7000, ring=0, dw=48, fences=0
         mpv:cs0-3473    [002] .....   129.130987: amdgpu_cs: bo_list=ffff92ff84831c00, ring=0, dw=48, fences=0
         mpv:cs0-3473    [002] .....   129.172478: amdgpu_cs: bo_list=ffff92ffa4b84c00, ring=0, dw=48, fences=0
         mpv:cs0-3473    [003] .....   129.214000: amdgpu_cs: bo_list=ffff92ffb405b400, ring=0, dw=48, fences=0
         mpv:cs0-3473    [003] .....   129.255763: amdgpu_cs: bo_list=ffff92ffba4b7000, ring=0, dw=48, fences=0
         mpv:cs0-3473    [003] .....   129.297316: amdgpu_cs: bo_list=ffff92ffa4b84c00, ring=0, dw=48, fences=0
         mpv:cs0-3473    [003] .....   129.338978: amdgpu_cs: bo_list=ffff92ff84831c00, ring=0, dw=48, fences=0
         mpv:cs0-3473    [003] .....   129.380685: amdgpu_cs: bo_list=ffff92ffba4b7000, ring=0, dw=48, fences=0
         mpv:cs0-3473    [003] .....   129.421993: amdgpu_cs: bo_list=ffff92ffdb4c3400, ring=0, dw=48, fences=0

Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")
Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5e6ddc7e101c..6cd6ea765d37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -153,10 +153,10 @@ TRACE_EVENT(amdgpu_cs,
 
 	    TP_fast_assign(
 			   __entry->bo_list = p->bo_list;
-			   __entry->ring = to_amdgpu_ring(job->base.sched)->idx;
+			   __entry->ring = to_amdgpu_ring(job->base.entity->rq->sched)->idx;
 			   __entry->dw = ib->length_dw;
 			   __entry->fences = amdgpu_fence_count_emitted(
-				to_amdgpu_ring(job->base.sched));
+				to_amdgpu_ring(job->base.entity->rq->sched));
 			   ),
 	    TP_printk("bo_list=%p, ring=%u, dw=%u, fences=%u",
 		      __entry->bo_list, __entry->ring, __entry->dw,
-- 
2.25.1

