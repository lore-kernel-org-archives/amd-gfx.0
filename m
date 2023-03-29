Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAFCC77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F8A10EC46;
	Wed, 29 Mar 2023 20:14:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9754A10EC39
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+s24sWETBeMfp21AioHJU7Z7W7wY5lBYItyCWe37y36XYXdKx7fZmJEjllZwVeIHwMY2Fh//yFpgX2Z/4/Q7oVl0MEegozBxThVQ7h2JDv/UKn7cXEgnA9r2pqdwyaHevdTIVwG77ecMAvAnv19Ar2PVkpMVs8rCH3VN0Qr/s9RNrP0F74DEXp1PfVPuNWpcUSdFUTAtr82I/cXCbv9+o+BF/vGcV2gZTeostTfDZKwHAVHurS4R4E+vbM17GrsoizyWRE8LP7VhVfWryl9R+V4gJ6Mveux25fGDNhCV3wmBUkRQm4Vo73Uy2HW3cq+Kj/aeQvE71bPKlfTGHXXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbTL+Is6CJHah1Ramq68wxOYgycJpT6e57lg9vCLkZ0=;
 b=IGhaUCG6I34Y90NjQJT8gQwP1v8oDI/nvAXCgNvwNF+0PGgLZdb8V8NeBql6rQKQ64F3AUFBdJqzbmyjf77f2jF8AhohASXD7py0Z9KcGeUqkRkwjYPVJAQ2wsod6SM3paSFZdJEJvZRufmlU7XpqH3RjyoOcsL+jY2RO3NKA6bc0SJHIptA2kxFZRimTD3Ol0be9wkNp8ObAjS/p5iaViSR3xOGW2HGv1kjb3piWfCHWD0uHVq2OchiPJvuVjbTJYvQ37IRh8QkGbGWz+BuuUK1WFmNIkMlUPawqS8+/p11Uupwa0UHe9MTLoOSBlwhpPNNZNe9MhrypahIjd2hTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbTL+Is6CJHah1Ramq68wxOYgycJpT6e57lg9vCLkZ0=;
 b=4Q/2+XBXkfjKhE4G+FcPDL6rO0i7GfMVEy16Y1UdBIq4ax9FHPZ5Wh+hnv6ncBfaBTcTzOVD8eguBqNF/45GvGc/um+f/aFyrMWW6AxufNYAxtRD8V5hCa1MwFr0PYVApr4P4DXaTR8yE3cwtQ77O/A2inD0+OGAxi2wxG/laYI=
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:14:51 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::86) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amdgpu: Fix failure when switching to DPX mode
Date: Wed, 29 Mar 2023 16:14:23 -0400
Message-ID: <20230329201426.1982669-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f99d349-57c8-4032-6def-08db3092409c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2yEyl2Umz9mqzDwQDQv5w71vf02u95p/Zbx6eJIM8O4TIAXJ9GvNq+UR5Bk1XoOJ1y0R2gFhwLq74K5jOBpVC6PNChxUzJZn1o/qPQjxBkPJHqTUtq2ClkAnTe7E+zH0TLnPjPmzMzAEkRGI9xdArcrW8quqUTVkeSKfxYNquG1asktLN51nHkrTYM4PTottNXwZBcZdmMaybzJdWiLQWvM+9z6zQ5A3BQOhOK1eHIHxLJWl8EkOywfRy/sL1K4Y+wyFtavgKtA3eLb2qy619pLTO2F688SNaiyxKwrsBepBSJHuVHnIB7Zg+yitRH9/AsTe17DRgMbAvzPLpv9a3rDYIrY+WXxeh9dZgD/2rJnJpL9iNbyPD+dSnTak4+UEV+dkmYNyHWOxCxrwPF32948M4Ktt+0E6/AMKYtRU73V1Ob5Ia7HMahXG2MGBgyQOsnZKSAT54RjISu13e8bOYdUSnXlFTB0kgVRZ2S8J2KtFdBgrQvHl07IwhGWFO44stksjptqSQFkxXOZMnjumoproBb7N9HkZF22Kr218fC2AYtVSfI1z/tmKqABxP/kJLfPTfHRJENWpyiOORfKfp/Th8F5bvX4fmBUgEV/Sp5IV/sZgtnKg+djqn4s7n9BsU3++FtFI32JE+Nnf94l+kki0cv8hGMfP83MiFCE5YVGAEb+yt3RcNjHrx+OyGY7sbH7PgKA/PuZpqTEOYETW6jzTcu1bAzB/6xHol6od5Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(2616005)(7696005)(26005)(36756003)(47076005)(1076003)(186003)(82310400005)(16526019)(6666004)(86362001)(70586007)(41300700001)(336012)(82740400003)(6916009)(40480700001)(4326008)(8676002)(316002)(81166007)(356005)(5660300002)(54906003)(8936002)(83380400001)(478600001)(426003)(36860700001)(2906002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:50.9003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f99d349-57c8-4032-6def-08db3092409c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Fix the if condition which causes dynamic repartitioning
to fail when trying to switch to DPX mode.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a98c38a75504..c69e4f412963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1138,7 +1138,11 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	if (!strncasecmp("SPX", buf, strlen("SPX"))) {
 		mode = AMDGPU_SPX_PARTITION_MODE;
 	} else if (!strncasecmp("DPX", buf, strlen("DPX"))) {
-		if (num_xcc != 4 || num_xcc != 8)
+		/*
+		 * DPX mode needs AIDs to be in multiple of 2.
+		 * Each AID connects 2 XCCs.
+		 */
+		if (num_xcc%4)
 			return -EINVAL;
 		mode = AMDGPU_DPX_PARTITION_MODE;
 	} else if (!strncasecmp("TPX", buf, strlen("TPX"))) {
-- 
2.39.2

