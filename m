Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46DAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 16:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35BFC10EDBB;
	Thu,  5 May 2022 16:49:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D6010ED7C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 16:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTlZ0L8PnhXT7Qj+pXDmdQqGgQOv3miJjbUsaMuM4Hu6QKIzkM69osSqlETGfjkzicT1f0XXqMvJpRrsuNgWDJzUgK+TLllujBn5BjVJcqjHEKmLlJelZrqL6ORUtt/GlSYjw8JOJqs0jO5WailO0695FpbFDdRWvS5eRa9POXWdTq2GWGm6L+lqtIgdpvrHsFi6PJRQ1+xM4SVvH5aSKH9qJOpRmTudmNQmpceqKQDNLXTs8NxytteMDavYFo/3Caku5FixrwCzKl3SYeZ3EAv+YtGdEeCpd+TjgSs+FjEzldqPM3oIX8p/xOxQlghj7tOqcuExbMjG+ibe/BoKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1jQRIwJeULsLYfqCAnRpGPPcU3eUJutVgP7TYsJXYA=;
 b=m6lzbvneF7MGtRFNSVLsPF1Au6P71lkGlpiyBWXmqFLEeHbPsUURrAkoE8s9kJhcLPG6Uc3paPBqrn0uP06rhhkPqFXW2LgT2IvdiqeeP3rEOwBOpY1kNwe1JT9qnSJGvSQRaUPsjDq0yJlY1S6QumcH1Hm5a/ZNCDm2HOL/oD0DFLXBZvJOlZpTgg1z2gX+PWXpa6sDVaNF2teq9yP0+VKZw+LmT64BzcqADfqwVY/tXcTLPyns7bvKfMD+sevDVrvac/YQ6h/2qe97kDD0E6eRAVRk4+9ZDyGgb00uMxvN+2b+yuoB8pVSvDf3JDYIMoVoiIZH7MpN7FSqDK9SRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1jQRIwJeULsLYfqCAnRpGPPcU3eUJutVgP7TYsJXYA=;
 b=tRLcjkKvlQIMvfeyRzpWiROfztxss7+y+CNUgzvr5CRi65/BYjs/829yuFB/UuV175tqWOhIQ205oTcFxQytcR+8ZlYBpoI+No7XMBd8cZw9YXcjlJe2C53Y7Sex8VHXqrPR+gG6Xw56sxhaVduuL7U6P5FqCagHQ6/6ACrGIGo=
Received: from DM6PR04CA0005.namprd04.prod.outlook.com (2603:10b6:5:334::10)
 by DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 16:49:20 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::3) by DM6PR04CA0005.outlook.office365.com
 (2603:10b6:5:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 5 May 2022 16:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 16:49:20 +0000
Received: from work_495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 11:49:19 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: fixed compiling error
Date: Thu, 5 May 2022 12:48:59 -0400
Message-ID: <20220505164859.21754-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e11e21-37fb-4183-50ef-08da2eb733b8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB135493F381FF431EAC8CDD5BE4C29@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aInJrD1Z0qwDU35jAlw9mDD8FFmvjSN8s7bPPA8PgR3mksV7AAHZsxgG5YmEoxFjEp0qP6BolFHxKA6FG4/+3owyBR7LdEZb5Z07/l6UlHS3f/f5pN4BA71X9p302izsH43STj3MLF7ndnsvCNYMr1y71eInoY7J3sBBAyp/sUKu5g0PB23Upg2oMnfG+Fgwki0VMhDExVjmNEO5cR4V49xnZXGxLH0Cf9Prd7+h+3ww/TXIW1JzLRVwk5epAcTLCWvyKlBy04I0nZl+Mq8eDr/Ymn/F97EMhYiDDY9Xf1G8wzR7OurWOMyzAQQa9qobaczGF8AZV427RAe9PTKHidtye52KMTQfMuEjzLvFmLpHO/lj11nxqOOJ8ORw5niSrWmFuhqkb8BDoVW4iWEavpye7gvo4Qzw3xpZHQsTuupIloH7seUxh0YUbHvLn4hSJ3xy6iZYbWX+wIoBwhFtifwZbTiSKdI8CWYo/EkeLxqS3B1GHVXok+/MrV2dfOacD73t29UqezDCngVAhBsmCT/ZeBw0WRPIRqZJ3HigLaGI6R8Z1OKaZ+uBrFAMsk6H/3UDUtNMfgCVRxK93cMgenj0PKbAwY50sS06KFvL6P9OtdU+oiORZXT5T3PiGJ5Yp0M3togaDYU/AaDK63tUJ1LI+/Sv4ecvwOj8WJEJHsuERB6edQ4NYrVaOz8RFGZbqasLFzxAG44DtaKTAiwIeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(336012)(82310400005)(47076005)(186003)(426003)(16526019)(2616005)(36756003)(86362001)(26005)(1076003)(6916009)(40460700003)(2906002)(356005)(6666004)(70206006)(8676002)(70586007)(8936002)(7696005)(4326008)(316002)(81166007)(508600001)(5660300002)(4744005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 16:49:20.5769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e11e21-37fb-4183-50ef-08da2eb733b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixed compiling error.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
index 08fd61622f95..f4f97f0f5c64 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
@@ -21,7 +21,7 @@
  *
  */
 
-#include "amdgpu_vcn.h"
+#include "amdgpu.h"
 
 void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	u64 seq, uint32_t flags)
-- 
2.35.1

