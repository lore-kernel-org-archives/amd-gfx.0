Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA66C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 14:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73C810E04D;
	Fri,  6 May 2022 14:33:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3364010E04D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 14:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxTtTDg8MgbL/dq7ujOpT7dbSgTLwpQmmGDSwnkw1yyDgt5wyvdmGhWs92KP39+kHLViy/pme45cNyeJMabGc5GBEQlW8dqF6WS9taaEbzv4xZ9Qfw1rjLswbec0HA3eZMjsXyC833whTMaLAlfYFHXAMMqzS1+AMPQba11bcVlUu1w91BU78/Sw3jDaCbMx783s7UNC5cfaD0ZRzQhnQ0kvdfa2LUw3C3OrTeckH31LXNruX7DjGUQxNnOlt4Psx2Kbxqm1aqia6uC/0AmeKPfP/9tgzZKoQeDvkPf5zt4TRrMaz+lwAkMa4W3CPnts6Eq6uIXyhPI/pwmMcdiLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O55Ms/vUB7aG9SH3Djpa5lD726hnfYz+2bEGyELNFl8=;
 b=UzdqxELGQQnGougVb+tRjr4tWtN51JbFJqIjdPBOGUnp1zc3ucrU9ltJ5aq8LUvv4PmbffzF62ZWLrPJ7u1GS1a8kJJsZShpfK7QVZMpDKq2sBnqqZyKvwcVQEa2ie6LqtroeGy1Brq+74uEYNoMotz5aSEZMqfqiTvZuJ4WA27myeKDgG4J9mlUDPuQii4rQRrrKDnKBP71JagVqgVw2RuLOmOUn5tw8xAFakhQONcMlxJCZiCFM908f96UmZdfc6zoly4FYGPyzh3cq2FbH4hLhbXuWR3nmjaMzVsScEkbWBQMJWjSrj+zw7roaeKl23urY8ON2+RbGR+MLwntRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O55Ms/vUB7aG9SH3Djpa5lD726hnfYz+2bEGyELNFl8=;
 b=qyDsJgoBIfgzJKqp7Lwa5rIv4iNgB7VCs0c4khDwppjsaJpWtnUraW3o8PDUXc/3bImtn1OIAi/V3r9cq0+Hl+5TIDOnlqkwsWlpqsd3vuix8RwaoGzUV40ASLB2gBfHiJpgtJ5WY9gDLakiMWTMgfDgCUjUOLdARrwoyTURKuk=
Received: from BN9PR03CA0792.namprd03.prod.outlook.com (2603:10b6:408:13f::17)
 by BN8PR12MB3201.namprd12.prod.outlook.com (2603:10b6:408:6c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Fri, 6 May
 2022 14:33:31 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::2d) by BN9PR03CA0792.outlook.office365.com
 (2603:10b6:408:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 6 May 2022 14:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 14:33:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 09:33:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: make smu_v13_0_7_check_fw_status() static
Date: Fri, 6 May 2022 10:33:18 -0400
Message-ID: <20220506143318.2467559-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c2c6870-be44-479f-d0d6-08da2f6d6489
X-MS-TrafficTypeDiagnostic: BN8PR12MB3201:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32011D4B7514329018290899F7C59@BN8PR12MB3201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DemUvyFOPK+NYiCa8+a3f1EQSZsx5yANFCT5tBDcrIMh3hS27JzxwyqHZyuDANJ3L6gAxDWjcE34e7BhXssLOEfPLErB9rFVbEhSsqbgyaqpTfUUGTnEsZXGAUMZ3f+SNcrVutLZ0yaTMu4iUWRgABYyIVyIStb1lNo8Oun9s86I4MCgDwdQkH+xZAv4fFUbzWad1KPxImrXBCVvC/PAuzO2amg7aTQ/+LWe7LHtVmad/clWEJjei77mBct083T9bYQynuIQD9uUd7pUTa1ik+KW1hWgGKllXLxjeD6NqOTIHVe5Y6pYvTielxsBvkRApEdTxs9g5m2LvzE0hcngvwRm9IC2ZtMno+9KM/v1VXGY90HVzvU6SUxY9uTGILwo8nwnoh2LCIRsVmDAjhJQEVxR217ANdrTv9j72dhTPLkaIGlm9fPIhNMZA/0quU/r0ujfR6LQNxrZvpbK7egUS300Vl3pO8zilubXzjF5RXNRH1/8H5aZ6swuNnjhxhJGehNaXmtm5AXVVmBd5OIndjWdafBiHrRaLf/RxeMmPX3h0pzaUpoaj9+wsB5cC4R5+VQB9VqJIW4oGpeII5Gw4T+D+Tv6J4OqRCibom13r85Iwgf0qJ3r6NTSaF30buVw+T84IOobzTp98x//gdgGHCWG3Yo6OZDOqidvhqZEom4aar1beD/CWl4SiS+APV+dFNPOfZZcKcf5KVi6zEFtDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(6666004)(4326008)(70206006)(70586007)(36756003)(86362001)(2906002)(40460700003)(356005)(8936002)(8676002)(81166007)(5660300002)(26005)(7696005)(2616005)(6916009)(83380400001)(186003)(82310400005)(16526019)(1076003)(508600001)(336012)(426003)(47076005)(54906003)(36860700001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 14:33:31.0259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2c6870-be44-479f-d0d6-08da2f6d6489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3201
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

It's not used outside of the this file.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index cf5800822174..9949ee3ae090 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -291,7 +291,7 @@ static int smu_v13_0_7_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
-int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
+static int smu_v13_0_7_check_fw_status(struct smu_context *smu) {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t mp1_fw_flags;
 
-- 
2.35.1

