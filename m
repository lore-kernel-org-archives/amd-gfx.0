Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA5DC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 12:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D35210E8C7;
	Mon, 18 Mar 2024 12:50:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pl2+T6Wt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C27B10E8C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 12:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZloEWLtGlVkQvPOO0F3m2NM6RZ/Z8B06sRZzklJmZ3C4wTW4hoRH/87YonAvyotBpCrMnQQzI8xslpmiPB4nhuI9T/4z1jP/GCEhBe6nMqgc7jtEibC/OhfiqeUmmdGnek45gryULDDOBrctkFjruJKe5UDtWNFo9Dut3Z2BF7PNswVGCl8BnFMtlQB5wpnCU1rCfDLYYiqIi4wrgRsiPpDhH0LwmcQiVQPvrc4uW3dYjtBFaLzk1SvxTCWaX8a5cdOzjQ5DJvhhUxqDTQ12t9iW2b7kxpZ8WQWxJmzRi0eVpEUZS5bCxmgUFWImAltS1gEq6+QSk/IohvBd8O2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTcgHQmU3MLJONLyb3ttH64qigpPpZTa52EkWh2gnqA=;
 b=LkC8lXZsoWh1jPXc+JTkafeNHz9M3XWvApBSZ7jQHX6eHzN8xRtdfSttPlGo1gZcLv88CpXCm6cjvXOYG1DASlrbXvMyJlJaCjRaM9uVjiRojsNkWE7R5dVRLlrMrKVmgYf3d/0u9f/KTSO2X137PooTSSFr2ieXRRSTA7D+nr8McLwKLHA7FrylICVTwu5wfI9KFS47PpRW76JzfGLgOpdEdRunUXmculmXiYy0g8Z7Hkt63O76wpW2zCuH0kP79WUH8J4HnlRJT7WNyq6oUJ5LwEtHGkwgjcDHciApUJK2iNkPGuhZxor8Ft12pVcn63HHz+MVMNxh+G4N0+mhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTcgHQmU3MLJONLyb3ttH64qigpPpZTa52EkWh2gnqA=;
 b=pl2+T6Wtm+g4cEngDLJBrUCqcBCCrSYSWT/50KUj/t37YobYnHWzJ89l+UmW8mhnAdEKB+jFsZBEJERK/RD0/dxW0qrbZ5XQbkMZ+nEPAw/N2P+evMTCgzIJ2EZ87hNKzSyOqc4Cev0nTMBdzIXbOoQqA0Vp4L0JqVO3aqIcdjE=
Received: from CH0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:b0::25)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 12:50:48 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::32) by CH0PR03CA0020.outlook.office365.com
 (2603:10b6:610:b0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 12:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 12:50:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 07:50:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Address kdoc for
 commit_minimal_transition_state_in_dc_update()
Date: Mon, 18 Mar 2024 18:20:27 +0530
Message-ID: <20240318125027.2238100-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: b16385ec-1095-44fe-0af4-08dc474a08e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +REn+y9v+oiKqlai+GrczASZc01/MOekFtcUq90bkquWuqFvYHr8NKhw4EpKk7bCTjpEw5nl0U+fnI43ACNLz38TC2qk5Rsbvf1oAuCXtkWaPIO9XrtJLClxMSNFsEq7whTQbUp53mUfekE6tITSQczJCUrgXuK0dJlxxySoeor8A6w095ytyUIIjiZSl0E0lTZW+Giy0UJF7pUurQ7JAxHM5zz8qa57Iwe1ZrKVzn8HEd3CEl1lStntF8NyHOVuRsVVkXofDRBCkvFmT6f5JG/6zre822s4bvnZhLvvSxGe7SWsnlHn3pSMRxiA7PSi3BlrAX9myNeRJhczxw5dH+/l8rdVhGkZB5vatTvJ+1gtPujIUo9Q9+sNosu6mSKmRYJa7zDpJI29lyp+D5fNb3+cVuPOMN3CMWtje0EVI+VnWfxtG/bIda4eM0DEAAMJnKrNF73m3uqgfitF1t1LqvMEbXSpN1W6XLdlEM+MYdx//kPE3Tsrwi1vPqHrJJcvttLe90f+N1SiWu4W8VV8EMsxBlws25G+b53b+RzLgbqjYlNXSyk+FR1Ec03LIFZue7rmpfDGWK7zP7RGOrp09azCoOUPiXN79M7Y+BNgWwnGawlt9XfxRFmDhF0iwxaRRjGqWWvVRh24TjAyIaP9GwOgdpJ2FrXIOpTtZNC+pO6VhyoCeodPnU6vCTAUre7fQlxtWLGp0cpOUNGguc+e93MN1RA91ZM+IrcWhV9SgFx24dFoySyqJty0KQ00PDru
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 12:50:48.1326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16385ec-1095-44fe-0af4-08dc474a08e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adds descriptions for 'new_context', 'srf_updates', and 'surface_count',
and removes the excess description for 'context'.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4411: warning: Function parameter or member 'new_context' not described in 'commit_minimal_transition_state_in_dc_update'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4411: warning: Function parameter or member 'srf_updates' not described in 'commit_minimal_transition_state_in_dc_update'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4411: warning: Function parameter or member 'surface_count' not described in 'commit_minimal_transition_state_in_dc_update'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4411: warning: Excess function parameter 'context' description in 'commit_minimal_transition_state_in_dc_update'

Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 119eee2c97d4..08ca97bb4160 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4391,8 +4391,10 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
  * on current or new context
  *
  * @dc: DC structure, used to get the current state
- * @context: New context
+ * @new_context: New context
  * @stream: Stream getting the update for the flip
+ * @srf_updates: Surface updates
+ * @surface_count: Number of surfaces
  *
  * The function takes in current state and new state and determine a minimal
  * transition state as the intermediate step which could make the transition
-- 
2.34.1

