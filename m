Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50574C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 14:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC5310F125;
	Fri, 22 Apr 2022 14:58:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F1C10ECFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 14:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6NHGWrRhfwh8/EvnGC1OpkQ2nVEWzrgSLkL6q21/EGwrukcSa+8YBBpraqKOUWbUnDY03o1qQ5k8b5UUg2eyBfexvyi1kcw9+sE46PA0hDvaxUcjlh4QkiYn4XlJR1qjkrfNHNhYSXzR8whmxaw8Ti+yq6HkPlasv1jYyQjSody0M7zvXOv+5HpQ6Rimz0zC9tg4Rpe55s1sMVRGvWXkCAPtB7RcdLZmzaI4XowajCOq+kNLAHeRQy5pWdm9Z0g+EtI8u3cxkCIj16czhBAVJbHJ06+rbTF0xXQe9o0POojue+VrDK5v93Lx9vNCQjrPB7NeobHJ9nt6ms43EwOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu9BXhBPE9OaXH+FMabuCTHcRz/VbvPmdEX4RGqfFvs=;
 b=nmjvp1gWDqOZqWXT0jExh0QXnIjri4ZMDxJEgqtz6P+9wziyxa5Ej0vuL+CeEBFDEuBi9mJmcOClz1hXEpSWUeuFpbiMVmyLfDhQAEhiQDgkowsr1KbkMCWv6IszF3otE/p/hysR/zHburUgUJPEV8aKtf7T2LI/BOfw1dfmGfLSVeDNxjUqWb7EGuF1QGIU8cRyQOjyH3uKeB+lG+BHuHd9EHcRyuvVrQH9jd1nHGbfgS0E1czroAW0ph/l01Dhz5qIYvwQ80k7IGVPNGVzrTzxuUu5Sk8BZNY5chHLxMF0KGVNa5egFdv6p9+o26v7GXlnbev6MAxO/UYr/JnpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu9BXhBPE9OaXH+FMabuCTHcRz/VbvPmdEX4RGqfFvs=;
 b=ykV9JSwYYmN0V75kRo9mwcmOoJH6wkmpF8EDfnXhF077qe1qI1D8xDW0fx+5KDQKZABOfw7lIrZjjoPe6TiWHhVlCRvmKvfBfTQUjZBexjeiUAdRWH2pziXEQ3WIsjWz4fB3JrSg+UEOyLIHO5/9W2gootXCAkTAwMxyTixSwOc=
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 14:58:37 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::a5) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 14:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 14:58:37 +0000
Received: from MSDN-LAPTOPDYU.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 09:58:35 -0500
From: David Yu <David.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Ta fw needs to be loaded for SRIOV aldebaran
Date: Fri, 22 Apr 2022 10:58:22 -0400
Message-ID: <20220422145822.3628-1-David.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8f56b05-7cb2-440c-e280-08da2470948c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4359:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4359D4B4698FC85DA91B3E8981F79@MN2PR12MB4359.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n95dAXZyz/wjxCYHrFoARDXIQpOxOLbcFFvgyPHU654CImhgQnGlk/seSjHCRzIbV1i4jhuVoE84PxtR8npRocB07F+1QrRtoKcn4Y+/rER6HYTSbmxe3FjYGiEM/LH/J+Q3AyiksHlmBGrd5an7U4y3YCybilKGU61rX12rojMXJuwCCbNRhNliwdWcmAVLjacUuFjZU+r6bdKCdkOpohplHamdSLhZkcnGwbRu7fSf+sAdbgB/jsh43m0YKlST7CyXJeIP9d/RQfy92boBXIrOyfjOU84C61J4CbXdUWdIPW1gEblu4FDKHb1uULpoQAAm4ZEnKjiRqDrJIHkgA9rFq9WUI+aKM6dJtWcyTbEBSoRg9cK/Q9TbaYHOT9Jnq9m/RxvRMIeV3799vzVmAlcsTCmmwznMupNELmOtJnVdN8oJSs1CCx9DppRGPnA3H3kRUGawB/MjlCW2Bvuj6XDbl54bKdpdYELq6EtX1dHGVQALxrIYPslWGUaBLPOac+mKh29IUQjrxtpLupVkd5WGUknCFk3VpetKy7laPeAd/801lSd4nn4v3bKXDx4OK0ZfiNh68HpA9fOIURSUOKzfB+rgJOMt/UYVM8zgfDHumptNqtTV9P9OrIF0cOdBU3SqIwa+gFI8OIDtNnfuczjZ/zoe0WhjRALFSwQJX5kQBJ4ccdxnVjKDfNZ1x5E9qGqJslUpo8VMjqKhdOhMLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(47076005)(6666004)(4326008)(82310400005)(26005)(83380400001)(356005)(316002)(6916009)(508600001)(5660300002)(16526019)(81166007)(426003)(4744005)(70206006)(1076003)(8676002)(336012)(186003)(70586007)(2616005)(36756003)(86362001)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:58:37.1669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f56b05-7cb2-440c-e280-08da2470948c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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
Cc: David Yu <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Load ta fw during psp_init_sriov_microcode to enable XGMI

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f6527aa19238..895251f42853 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -275,7 +275,8 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		ret = psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret = psp_init_cap_microcode(psp, "aldebaran");
+		ret = psp_init_ta_microcode(psp, "aldebaran");
+		ret &= psp_init_cap_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
-- 
2.25.1

