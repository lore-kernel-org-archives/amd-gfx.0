Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5512EB64DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 07:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2418F10E0D7;
	Mon, 19 Jun 2023 07:30:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CE110E0D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 07:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVFYAiD+RwY3wf6essmQ/XpJ8vcvdVD3o4IXESn6kdwCAgtEb3VY7h49JMEcp0QirMPL0a02MAfeZCKFzIvf24gqWrJx4OJF4T9p9cCS5nVmZzYSSJZry0DxHx7stiH55SPxiICKWuOi/oJLWpT6KLFZ9xLWwmmKOd2OKfuioo4k4E/9iFUu5B/fp+OdorQnVVl4sY21POh4Mbd1BK5AWcwRjT2VVShpHuSzJIyNheOajLXufadZkbr6UOEmAcllmCFGjfFsVBu6tYD56OQHqAfVQd+CA63JO6Qore3YBfMpiFSScFcudI9AGtnJ/ZLVS9rHWZ4pBungEhRJVwmVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeqjznRro/6b/CUvWFaKy72Zhsti7tqE5gY2i6OAWxw=;
 b=FxsLOwuGS88Gtqv7t+g4RGPgu4JugYLVavAk6fqilfrb6XA7x/ic3YNPXKq3fFfUPW/O7WV6I7kSaRW/W8kNAtK/5Z4nOwDrX1XNci+kColqQYr5Xv6D4ejpJehS7+djhNZTMBbub+9GvkMR5kWSMDLuOzAdXbk0D+iClfMMKNpEO86E1JU3V2nCagzqM2NAj8b0p8oJwFvQFLBfp37PRyn9XlCh/cEWsqGpGWehWWvwBrtw3f/QFrzbUDmFgeZ2VX8J/ptfC5VcDw+D3uvkQDU6dm4ZoluFSMbT4lSIYrHUubGCifJ8O6/SatrhAYH4ZkfzBWFKhyNmwS5W0CBI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeqjznRro/6b/CUvWFaKy72Zhsti7tqE5gY2i6OAWxw=;
 b=1765pFistbN/sWPkra/WH2HxLckNKWo3jwIJSrIqlHW7eyGwOMBylih6y9kNEAj6APv/astWK7lExzpB6fUwfqjTG+iChBbkxJ9f2SrfQtD79eauw3Qyf0Hr4HrpY4u7sz53pIeJyqcNuSVJ0n/XnllHuDX9gqoof6GLMac0EUI=
Received: from MW4PR03CA0233.namprd03.prod.outlook.com (2603:10b6:303:b9::28)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 07:30:36 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::73) by MW4PR03CA0233.outlook.office365.com
 (2603:10b6:303:b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36 via Frontend
 Transport; Mon, 19 Jun 2023 07:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Mon, 19 Jun 2023 07:30:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 02:30:30 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Modify for_each_inst macro
Date: Mon, 19 Jun 2023 12:59:56 +0530
Message-ID: <20230619072956.2063020-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc3904b-68d1-4489-9da0-08db709712cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy8FLATHx+MHcatZCzjns0S2B2UQnjh6uydRdax27LoTfdStjPVj6ucezrehCx1fJu2sTz6ao5mwcdX5h0yXmeu6dcNZ7AKnSj3qXJV1NZWGfqXUgHvi8PtXjRAV/GCpcbye5zlADr/LnzqLvQbtclpwri7+lfohNxD8Q2U7Z+Mih7hY2E302BH7RJ8lzIseejMkgAnCNYzHcM7bWODCL2ec2T0+tof9uBXqASco7DhXgM8SvPbweUjcCOz2JuqZhhb3286DWmTJoPW7QyXRHpiM+AXdx5i8elh6s0UD3myABCefYQxTaRZk4rWEf7Zfvuj3y8z096RGu4cr4ItAQ5J+5UexAXZ1v7ZNc4SPdH1BjS/GySXgdoPRbRiLsoTz8RF3TBg8Ghqz0vNpoesscMi19tL4OwWKxO0bwiDUPnP07VQJqxtF4l7+NrrdhhfojY8cuTOeK+ulwObx+XZL4PANGTm8V/WDhJouAasaDb5+k/hkmPyHqeQ8wvDWGuWb30wvAbJQKBx7l0xA0m3w1cz4D6f9lvGx4qDj+g4orbfgEO8FXPPhClFwObT7d+kZA3hU3NVWdTmUKwfGb5/cwjoL8IRPXMz/LNrnuNbLlRhGPk65t00bv/ZemAQM3HLsXB7c8MPKDb1sKS8FwNd/7hkyWs8WUsJpSvWOPUpCnO6FWlZ43vscjLfbRxmL6jHn+vWd4cVEMju3+Ugic4f/rlJIHpPQSWBeuBurPkp1EoukuYg/G1DGb5sDtECKtpDuKCkbAIMensaFHE/059Oqvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(70206006)(70586007)(6916009)(36756003)(8676002)(4326008)(41300700001)(81166007)(47076005)(356005)(40480700001)(2616005)(336012)(426003)(83380400001)(82310400005)(44832011)(86362001)(7696005)(2906002)(5660300002)(6666004)(54906003)(316002)(8936002)(40460700003)(1076003)(26005)(186003)(16526019)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 07:30:35.9176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc3904b-68d1-4489-9da0-08db709712cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Victor.Skvortsov@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify it such that it doesn't change the instance mask parameter.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: 
	Take care of bit-shift beyond width (Victor)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f4029c13a9be..aa42347bd67d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1295,9 +1295,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
-#define for_each_inst(i, inst_mask)                                            \
-	for (i = ffs(inst_mask) - 1; inst_mask;                                \
-	     inst_mask &= ~(1U << i), i = ffs(inst_mask) - 1)
+#define BIT_MASK_UPPER(i) ((i) >= BITS_PER_LONG ? 0 : ~0UL << (i))
+#define for_each_inst(i, inst_mask)        \
+	for (i = ffs(inst_mask); i-- != 0; \
+	     i = ffs(inst_mask & BIT_MASK_UPPER(i + 1)))
 
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 
-- 
2.25.1

