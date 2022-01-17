Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5FAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 07:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7697B10F178;
	Mon, 17 Jan 2022 07:56:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B01910F177
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 07:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku27saEbfqKMGAtmYQrgS01Lm/2RPYR/Jlkbzt6K4kiKRFv/6E0HJrZKjNVHyznpaPFibOeSx1y813S0S6RLluOSK70SXNBO5j5/+5vg32SCxYUv8N207f+a84ZPunhYYBPwnRXrKS7v9/Vx+Gm7jzRcU7C/O/i7noi8/EQ+pLYppP6YNKl5oYL0XxG0DwKU2lm0JXnKmFMtvFF6vuHmzHH8TsMKekT46BOVBPwg0Hb/MbqEG/lhlg28Qls8MrvwYhMXbxvT1He+BIn8Z+rPaQOBFUvWv+NrLJSV/UwJy2r12vJ39FWgFk97QuI9L5ilf66Z05h16LPXJUwf5sNVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCYiu9+1rSGDdGEZDdDcbNJdTfSEqN+bJVPCTur42SI=;
 b=ZWKDN6Co3cVHzos4/1SGckU3DhoRcdCIqG6LxyIlCy8w6YgfWwVnIJDqjUaSLE4PwOIzmMhsTKDiGb0rFCrrFTNS3EePuqZFYEF8td6QwGpglZDurITqn5hF2St3oM/CINms6ktL7yVFGx19wZLjfXCFtkBhIJ3OfGv7C3gKhyqNtwegqJOB14bb1x02hYGevdtaOgMGP3FuR5ot2Y5OpcuvVOdzP0cjmlNybAW0H5HhjvAPhVb7UMevqFJ1fX26oyzjAluZ8kdb5PH0E/tRs3gt7i14Ev+iucfCKDC2Je1wSmGDVQwTvN8hL3RExmzNqNqzcU7fy46iva1s7KmTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCYiu9+1rSGDdGEZDdDcbNJdTfSEqN+bJVPCTur42SI=;
 b=NAIykV1WFvlTdOBSW7x2Y4wHpTiWcAOtaAvBN8Iru2br4PP0pRaEslAAgS6XjACzcAhh9EF/StXHcUm9TVDlx7qbhXS3q96xIidbTFUk1YZfjeyrATIDRWPZOAGoGrPdTJOYg30kh0P8MtqpkeO3iOcOrdsQlrk91xQZFIdlyMQ=
Received: from DM6PR07CA0123.namprd07.prod.outlook.com (2603:10b6:5:330::24)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 07:56:08 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::e) by DM6PR07CA0123.outlook.office365.com
 (2603:10b6:5:330::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 07:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 07:56:07 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 17 Jan 2022 01:56:04 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: limit the number of dst address in trace
Date: Mon, 17 Jan 2022 13:25:46 +0530
Message-ID: <20220117075546.40427-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abf8ec1-1a0d-400b-fc27-08d9d98ed1c6
X-MS-TrafficTypeDiagnostic: CO6PR12MB5393:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB53932B5A12AD321832B82561F8579@CO6PR12MB5393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTfbD027dzDcvsy9c8O6Gax7kgfif2VhYm1sNkdLnPOBDyYcRKlHW8d3cg8S7rkTAUEBggtbikcr+S4qTNfhUiG6sI0oY/xoi7V4OR5czklFDrJfNP2KZ3gis0DWtpLrYiG6ilt8/Jux1YghIV+xj3vD7FM1eFVg2hM+FX4VI78R801Mjx8m7VNRbzEsOdJ1cZcLUW3R2pzw5Xe7jap12hA8/NgSrovTgPYYLGG4hLpn/DXMuVhlAglFlfbQp392DYOcUl9vgcGm0fGcw5y70P6bHP7oKdWFl0ZZjQTLGPCaOr0rmj4IznelDp+pyI6EdVxi7L3Yg8kA2zO2S8ilSsiEqX3pomiKqu3ff/KBsYsvP0AWAyXc/nDyB0O9kf6xp7472Ci8jOmeWVMlYvAxR5EZrs8eiixQ0PK+BjgoO68JiIQB+mecPxU6AebUjHR0LsEtgXcQ1vmIy4EfQ09X0uTvlU797dxSGF4t8VvG35BqTDvuh2UwkYaMBXD9gv5hsdjGDUiurksz6/giloYTTiEHizlf/wKAFT42WaCqFmfv5tNX1iDXH7oC06OUBZww1Ys21LzZd7P9vIG6BjOuBbIkTKahKmCIBHa3alSMEExZWg0eirzTenJkUrMJTvB34lEKatcrVruENg526OjawBJR5rSW20h58ZHWFCRXdG1geg4U9oL9seEa/kUjYcHL9TltlD2zY2hbpLcSnJoGSpYgFVoxpPr2pXO+oCz1d5EToAs2dmoifdC6TptaVses6gVZ3IWKwfM+jVFe1fn3Xj4eH4t8l5V3g7yCa2qOF6M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(4326008)(70586007)(508600001)(36860700001)(316002)(336012)(47076005)(82310400004)(2616005)(8676002)(426003)(86362001)(8936002)(81166007)(40460700001)(186003)(16526019)(1076003)(5660300002)(6916009)(356005)(26005)(70206006)(2906002)(36756003)(54906003)(83380400001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 07:56:07.6760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abf8ec1-1a0d-400b-fc27-08d9d98ed1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

trace_amdgpu_vm_update_ptes trace unable to log when nptes too large

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d855cb53c7e0..a48b34d4ce31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -358,11 +358,10 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
 			}
 	),
 	TP_printk("pid:%u vm_ctx:0x%llx start:0x%010llx end:0x%010llx,"
-		  " flags:0x%llx, incr:%llu, dst:\n%s%s", __entry->pid,
+		  " flags:0x%llx, incr:%llu, dst:\n%s", __entry->pid,
 		  __entry->vm_ctx, __entry->start, __entry->end,
 		  __entry->flags, __entry->incr,  __print_array(
-		  __get_dynamic_array(dst), min(__entry->nptes, 32u), 8),
-		  __entry->nptes > 32 ? "..." : "")
+		  __get_dynamic_array(dst), __entry->nptes, 8))
 );
 
 TRACE_EVENT(amdgpu_vm_set_ptes,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0e7dc23f78e7..f367fcc5c535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1634,7 +1634,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			nptes = max(nptes, 1u);
 
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
-						    nptes, dst, incr, upd_flags,
+						    min(nptes, 32u), dst, incr, upd_flags,
 						    vm->task_info.pid,
 						    vm->immediate.fence_context);
 			amdgpu_vm_update_flags(params, to_amdgpu_bo_vm(pt),
-- 
2.25.1

