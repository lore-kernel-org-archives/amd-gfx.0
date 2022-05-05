Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC83C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 04:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED9310ED2E;
	Thu,  5 May 2022 04:39:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DF010ED4D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 04:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYE1DmSYp3QEElfzOJUU0d0ny1+iX8uiBlGVn3prBgxgZQGndQ9d4jIf4CemA6H28zxdv0ZTTafPROXotl4HYkSy4oFI4CMJ3c33ZkPouQ3r0SDfO5m8S+1OV9wq8cwqWmxenfoR4AVMKQF9p+XhxWzpjXaGmBA7wqPtAtkgtmnaJTl4OcAE/8CoDM74Fkd6A/B6zpH+E5vCFztfqRIHSONrG0NOHlfLdNPAkMY6SZNkgh3lot+T60pe4d1Q+0rQXiDb2dfm0Kvqb0wiWjy/1XQ8rzjM8WUROx5/QtXMzPYl5WOEKra3v4nCqcj0qQD3ENCn3jC1snLhaD5Gg1f9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPC1r7MBIohT3u6G3YvubvLmi9Ix1gGLI3acG6NGPWU=;
 b=L4qQPuxAfa3CLLuHELmqcY8MgGBeLBZ8/eLq5MicD/IQzd40dWUTWC/xoITBlLm/CEffy4xy9TmUwAUIpmv6kvpkcJRIoFL81oGESKkdHANrAuOSMSRExUNqmCKrVNMk1HGEip+1iCZBfJtvFmPMLzyi+jR6Usnls1rkKOxoQ2oguYMSVL+Ek2vmlrUs6H3vqn4yhmEBcs5OpUG9auAEQqDvPbjwx64mgZWy9Aj+iCSYFUOg0ts6YNwxPPFQntlPNGozm0sOJo9B9OwzbneUjEmHtjZ1vU/IeKh4e9xu0fC8rJhr+N/n+HlCsyShU+UexvWgE6r+X8l3m6WLfIWxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPC1r7MBIohT3u6G3YvubvLmi9Ix1gGLI3acG6NGPWU=;
 b=HZ3/lLk/AjLC/ZUgsDXomO7S07zzyYYQB5GS5OLL+ZWOVLEgfbPEMN0e5H/zSW4jlGkUPplesLkJcZGUXM3i43AjLLw/avLE3YbQ68jNzUVUFt1YGuQJCY3nVEl2V0fTGz6cSsRH2x69YoukzQSddvcAyx1VTAoguViSAlkEg7o=
Received: from DM6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:5:177::14)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 04:39:41 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f3) by DM6PR02CA0037.outlook.office365.com
 (2603:10b6:5:177::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Thu, 5 May 2022 04:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 04:39:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 23:39:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/mes11: remove some register fields that no longer
 exist
Date: Thu, 5 May 2022 00:39:24 -0400
Message-ID: <20220505043924.564500-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ba515d-c720-47f0-fe7e-08da2e51453f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4229:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42298DF0EF5A3013335F5AA3F7C29@CH2PR12MB4229.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBw8PU3Yvz/+BQ/nAIVj+SKkm704dXvmcAOD1/eI3bGTkQM30mDGdFJpdeRdtb6PEnhC+u2TKT3h3ExqW70cgwIQ9zw8CknXbY6wjA9meUysWnUhAAswhE2BDT4QsWLhLu6IiRxkQxWM06q/fvbJNoCRcocIj/CX7A2ZcXsdQcAu4RWWUNE+/zZWNJI8XoLYIR4zptaDZGHGD6So7WfVbYeNAzE3C8878kknd0GRvfkhta2qDhs4Gl5xxUy6bgZ9FgKIDleojNjOESK1531waIRfsSuZ9kMmVrtxFSXHWphpIq46pxXn+LniGjZhOf63U3p1gaoXMhouJub9Ht8lzvO/lZ1YDfVx9vNNT53e7j/8S3fRoQSpM7Y9oq+rdSXW5WhHPICNuWyfUV3qOG/mXIhUA/6cvA2auAXkJdDeowXmUfOaQS60FC4gAXsAKdxAu8aouvZrK3SZlJ3U2CLDo2Gqhl2HxkkJOpXFcpPGxj2tfslV2AjYxN7Og+dw3mPnYD5K49Ma7t8RAsIlACWpOgahBGr3dnvg6Jk1VsX4w8vH2Uia/vFmMO+0xy0R45Iba9breoAsQ6uQxRQmd6kTKPXotIg3FsgthzoQoEUcLnYm47p38y3ylk9Hb5bbU9SVG0QU4sCqNMF9gAeNw/Xx7jTtcGcJh1r6NhLamEtsWEiPRQRA33ionVURnLdvmdJmY5vn/SAuv9N1nI1aCvodcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(83380400001)(2906002)(70206006)(6666004)(40460700003)(4326008)(2616005)(81166007)(1076003)(8676002)(82310400005)(36860700001)(356005)(54906003)(6916009)(16526019)(186003)(26005)(8936002)(7696005)(5660300002)(508600001)(316002)(86362001)(336012)(426003)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 04:39:41.4459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ba515d-c720-47f0-fe7e-08da2e51453f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some copy paste leftovers for older asics.  They were protected
by __BIG_ENDIAN, so we didn't notice them initially.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 840f66457ffe..5d4d54cabf70 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -697,9 +697,6 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
-#ifdef __BIG_ENDIAN
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
-#endif
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
-- 
2.35.1

