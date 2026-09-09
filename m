Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29716C79FAA
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 07:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A579910EF8F;
	Wed,  9 Sep 2026 07:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DL3ddSo3";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237AC10EF8F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 07:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIMLJZ9QI1lApqV2lweQ3SOvx+zNkKposRDt7QxBXXZFHhuRv4uiMumvDAtqkr1KjXO4lk6s9Y89KpA/k/9U0z0YroHOBWOoKhjmKn4A2nWZgNQrqAijrPee5xEHPA4SqZw7HXhiU+I9Genzis8bix0Iujq54gXmowF+oI1xfdU0qyCr5p757ONOcts8bZIJkMqey3ohPYTTdrHfN+n1fJL0aZMhTEzNzg6qcMPjQaxbFFDVGZWxdPZATxDh+gFkuXtiYtWT0vI4v+NHfpow81CH2Mx76pooIcxoCd8QASYOLa8bBepZ20E/48ocvNxBC4QhTNe1vPialoNl9eF+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+WrX5oigQMkQHS5XFWa6iIDF80ISW8wGqklCbsALKw=;
 b=kkj4bFtvX3ARKQm6FqZKMtm+ItluBZtoIzHWT1VyHcSIe6oteae5rnn8czGLvi+ozfDpd9KmmqzShevEf1tPk2dTUssW54OeaPPMKdnptc3xhcJ203EuMBPbYnoGyiE5QvxUSkm7NGU7FiicctTjw36pHkUcZ1+xXu8n0yrZjN888ODRe/ZFKqdCBOrBPK1RLP3thz9qQUXwcPMPlqOVsm6923LrkePJJOXL4Emwp9JetdYr5ShAhaFvtiplm2iuBUrg76KUAPBRj0oULyQ36aWH730KPftsMefuEmS9IPBFyqJ/f4OYZJCX4aNrP3fLZkqimVAh1ZzTF1sd/S49VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+WrX5oigQMkQHS5XFWa6iIDF80ISW8wGqklCbsALKw=;
 b=DL3ddSo30M17MIYUTrTikTT95K153YlkJYOdzqkvN5cR39dqVXmIudUGDAMbXg7ih5PwjlbF2apFJvEcnxh8JdCVLmV/ZqpEvXj9VH0mrpIG//q9rr2JhCuhRaO0QO5QXSTm90QwIiNMUTjAYY9EfV1YpC9KPMlzhjtJ+3k/06Y=
Received: from MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::35)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 07:51:46 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::67) by MW4P221CA0030.outlook.office365.com
 (2603:10b6:303:8b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Wed, 9
 Sep 2026 07:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 07:51:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 02:51:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <mukul.joshi@amd.com>, <Xiang.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: remove unused kfd lock wrappers
Date: Wed, 9 Sep 2026 13:21:21 +0530
Message-ID: <20260909075121.598208-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909075121.598208-1-lijo.lazar@amd.com>
References: <20260909075121.598208-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: b1107e8c-aadf-406f-050b-08df0e473256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hvzICGoznL4haEhRoU1HZ0t8eg6ebsrHpcnMZo/d6Kn+TqslY7g3PS2qKg9KTRXj+Qu/nLhWCBXZ/bb2Lwr3dlXSDllFrtk79CGiF0rQPb/mNDtpuRwtAWGMBWZqyTYXKiyz0uZoaYBHv+JrAsCe1tNHAKZnJgR4MXDmhyIudXoCWSzkeC3/sKZCXr+sta9f2+oqDyCbkIMG0V3uUNvASffbyX5Te0kQ6MVGsXNYH7hAkMMKmzV34IGzrRvMAnpYePA56aSB4WcRrCHqTrmTfHfHGAq1h0UeaHXFLitEMiATqKN09h1z0huBpPR4t9L8+Oa9dfnwvSxzEFYHR1f1fzrC/bINf3gaept/xdEsJfu8wMcoJMfVvG1Oo8Iu0CSBmzYzhGSVxgH2f8W70BUw64rJLdZ/X713rXHcJtLpp9spvv2mOiFhPiA3ToUFiMjLMki/hz9lsfuIbn5StwUBmx0jOcAGLP3wbZ8LSFyzR7U0u688LgHdjCb0StUH4hblJ9m2g97zAxebAmNQvTbZ0m0MrCHueTRALZkE9v+EHom/lJRrsXIl6RmVs+Vo9Stn1EQ2laPBdo1ehEvqRXtwNx3G4yVtWLEd4bBl5gpWPP8JS+b5Q5Hr25YjOf1YA0x840lXC1OTNCRn7l49COTBCssNVD5/R/Fti367P2rNKCXfBauIBBSQPvmj2axMHmoyCG4/x3dTUZnwQgEFkvsuvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tu7Ar6qLdj0UDR3mH+rRrSw6zPLJY876pHQOztBLhmxKWVd2wAo59xnBxZaQg9HE51rszcLr7bMjCeFktefSOJlnzF25vm7CS5UUuTjibcyMDtk/5WLic9LX3854kcGX3iV4S1hiW5dX2nTIMgfeFRFifVZJlyx5X/MrTTgW84ikyteLgxDnLnkgWVBv6Y7Ne5RM1BmwE/3Y9Anc+x+b4FGJ1oZvcmYhhb9/iBQ19GI99Jpcu54Ix+O0BLgtLgK8WwSaLfeLXtWcRTGdDp8He3TU5n2O8Z2ZAl850faTXaP5iE6RAqN8TE7tdX3xVZS7CtauBBie8IJWRrGJg7OXpRK7RxUorKkS6hGp5cBqsSXaeaN+/Td6SGQPcZmlJZVln6Gl1YtYUQRvN75dWKLbcssfckcbDlgxif2aiQn0ZgV5jZaVHe0tzVn8D6yI0pT7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 07:51:45.8523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1107e8c-aadf-406f-050b-08df0e473256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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

amdgpu_amdkfd_check_and_lock_kfd() and amdgpu_amdkfd_unlock_kfd() no
longer have any callers since the compute partition switch was reworked.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 10 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2a368f1e290..8e161d700afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -836,16 +836,6 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev)
-{
-	return kgd2kfd_check_and_lock_kfd(adev->kfd.dev);
-}
-
-void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
-{
-	kgd2kfd_unlock_kfd(adev->kfd.dev);
-}
-
 
 u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 36e222f3ac5b..e3da382ceb3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -171,8 +171,6 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);
 int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device *adev);
-int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
-void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);
 int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 				enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
-- 
2.49.0

