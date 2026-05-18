Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B1CCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7C010E6AF;
	Mon, 18 May 2026 07:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDlemMdY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E5A10E6BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwwAkJ2crSRdDJcz+1teuR9SGAQwOzg5JeJkA23lqgEqzvTepv4Bsi8lIjtLBWZv5OCLqbcjwoZ1h7BbyHsb1q5oStuDN+waLKY+uUg3NXhP25/YfkG4IjYNHL42flhOYI7n20vxA1miFWQs8VJ4b1c3jcO7AoPdcjthIYFH5Px8lnNvajdxYbIeVSyAlJYUVQqxKKU0ILKpTO5koM4A1t3NY5+wofmpCxcoML7fsH3AJ0KLhCoEQ4TKZIzffao1HN/CndcY7Pu+LsL/j9vB+gDbQk6R0afREPNNKpFkRIEbJZlXQNx9sI/MHrRND63Vzd5+15Pkhcpi86zE/C5OUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWa+hpMIcx8k0I1aMjfBtui4J/nrj6YSR7Nx8Ad7arc=;
 b=ZsQJ6mc6+vAX5b3VFzqH7AdKtow1Vj0lgv8iGjwC6F+zBmNo2Vxkz5UpU+Tpt8146vaBCFkQsCCmfTvxKTO3iYBxqT/HtnOLpuQyBKaJGE2oco8K76/qJJxNK13/0vbe8V9yJLqhgFhzhKHa8lk2p0nZntATN+ehWQzdFhqvu7mdXRTF4zWcJAu6zRtSv2UtrLmeDGiI+2U3hunHiwU7imk7WOO5U4Wlp/AboTsY71Vdlj5Zt9bPERMD2DTYEvM202RdIhBbNmpQi1IJU7QIpaRoo3A+fOy8v9JtBUSTU8Lpn3GjDZVRCUJU3pA64Cr37HdY5pmsQ9/ygWpqXoXJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWa+hpMIcx8k0I1aMjfBtui4J/nrj6YSR7Nx8Ad7arc=;
 b=UDlemMdYCY+usZzuf8VLFD/mEznfceoUzm3+RoWc3PWqhFAJUXyJFMVt+DqnuAMfD8I7asfuHpPkotuMW1+MkVF6L1pnrjhF+cAclw51/7pJECaduVS8RZ2w7wWScYpMl5aNhmZDMSzelSiDJGFC4n8cOb7cd1xZL+YaCBApZkU=
Received: from BN1PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:e1::22)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:23:17 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::13) by BN1PR12CA0017.outlook.office365.com
 (2603:10b6:408:e1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:23:16 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:23:14 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 2/7] drm/amd/ras: add error handling for seqno operations
Date: Mon, 18 May 2026 15:22:10 +0800
Message-ID: <20260518072215.3647120-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8deab5-7852-470e-d71a-08deb4ae5479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zoyCdV80BBRnrLlG0i+6ZRry40B8ImnTaHIziyQ4ojF1Wn6G0S+bhLnM5KjRU51vdD7rJt97XhNJ+Qg6saf6YLHszdfmzxePitb2Uo8BHAhpVPn1CHBQ5/uzxxb2YDHxPYCpD6pE8AlObtpMfzm/DYTb+IbI6ZglliYyqQ/RaxwG2YWMnNUI7FuLMGbgqUu1H/X0mlS2ejYsDODzlXcDyfuUnL3ldCEC7TFzDnPRbbhAFKaC8r/pCeQVwXMG1yPrwZZ3fwGm32UhO3gTBRgg7x/1zu4k9SD0UpziUdVhrAyFtyyvWuVWzn/GXfo1W04VuaZzLgiW2toRgZzuFijEoMeFO0KqqvAWQ7HoVZAefd+jw4vEOcE0XeCAppNFzWn5ttEsR3UUMK2F1DOxVztuBKA1b0tKrfp+2UUaSPO58HW48IkVWsEPupHEGOGUptJygBR2cLF5/u1fid225iZHPnmBSdFEnNWLyahScwEd5MQydf4w4Vs3phtf323q70/liHxipC1ZI7LiEDYjfe2XYoVNcEKR2SwFAutFLuKT2jYB+qK65hHmIfe2j8qVPCxFbDAyfEce3Wd76dOJQFiAepM+GuzIqO1qdWTJCMrRyKvvUcghsRLj33ZgBsr7j4ByvWe3Xoyq8RUgcI4fC2nG/UnWJqKrCovUhniUwgpzObKAWcDUkDkiS6UmO5FC1wNiy0KRM/idTdxfwxxnzMl1Xm3UyZ5c+/Mgg2vaSDxNmTI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eoy1Or7pDDHA8tozVq88H+BAU6Q0W2UJRApj45cBh2CQIbH6fIRjGrDcPpnZLiO5WOEiYT7BWPi+R6EZ+UYyCYA10yroFLLs1mmPXBMYtrE5lEK5C+YfSu3GAmzD1Z2FJ2K4RiIp4tCm5ymD+7IQlDa2nq3Obhv3tvj6ZVSNOm9PtO1Twi44j46BngFNOjdXhSGYWb3tI2ZC/NVU548BxeQURM+u6enOb4D3aWDyVR2CJncObVve5ZLhD3TFQ94Ir/BYWMVSPPlRhgxBBFAtrapB4W1xwNYF4aLA1xnxhcJ9oamzTK3m+KsEv7EJ3GDZ4VFSR6yIFLTmLDuCC42VOcGYt/hpJjMpGCJUXP3lwptJ606ImZdRYOaUPyJV4bPVDMwMLMp2qdLIJa8/texEa/6L6M2q0530ZxXsice5AsczjZ8il/HRuB0tf5dzm9wV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:23:16.7339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8deab5-7852-470e-d71a-08deb4ae5479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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

Add error handling for seqno operations.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 4 +++-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index aaf88e1cdd07..3a819c89e2fd 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -496,8 +496,10 @@ uint64_t amdgpu_ras_mgr_gen_ras_event_seqno(struct amdgpu_device *adev,
 	if ((seqno_type == RAS_SEQNO_TYPE_DE) ||
 	    (seqno_type == RAS_SEQNO_TYPE_POISON_CONSUMPTION)) {
 		ret = ras_core_put_seqno(ras_mgr->ras_core, seqno_type, seq_no);
-		if (ret)
+		if (ret) {
 			RAS_DEV_WARN(adev, "There are too many ras interrupts!");
+			return 0;
+		}
 	}
 
 	return seq_no;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 29b1b8f0cc26..ad6fffaa42de 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -196,9 +196,9 @@ uint64_t ras_core_gen_seqno(struct ras_core_context *ras_core,
 {
 	uint64_t seqno = 0;
 
-	if (ras_core->sys_fn &&
-		ras_core->sys_fn->gen_seqno)
-		ras_core->sys_fn->gen_seqno(ras_core, type, &seqno);
+	if (ras_core->sys_fn && ras_core->sys_fn->gen_seqno &&
+	    ras_core->sys_fn->gen_seqno(ras_core, type, &seqno))
+		return 0;
 
 	return seqno;
 }
-- 
2.43.0

